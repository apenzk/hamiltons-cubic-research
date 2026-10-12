"""Reviewer 326 -- independent construction of the catalogued test points."""
import numpy as np, itertools, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core

def norm_M(M):
    return M/(np.linalg.norm(M)/np.sqrt(2))

def sphere_product_M(p,q):
    n=p+q; M=np.zeros((n,n))
    for a in range(n):
        for b in range(n):
            if a==b: continue
            ina,inb = a<p, b<p
            if ina==inb:
                blk = p if ina else q
                M[a,b] = 1.0/(blk*(blk-1)) if blk>1 else 0.0
            else:
                M[a,b] = -1.0/(p*q)
    return norm_M(M)

def subalgebra_W(H, n):
    """W = (Pi_h - (r/N) I)/||.||  for h = span(H) inside so(n) (H rows in the pair basis)."""
    c,P,B = core.Struct = core.struct(n)
    N = len(P)
    Hq,_ = np.linalg.qr(H.T)
    Pi = Hq@Hq.T
    r = Hq.shape[1]
    W = Pi - (r/N)*np.eye(N)
    return W/np.linalg.norm(W)

def pair_index(n):
    return {pq:i for i,pq in enumerate(core.pairs(n))}

def torus_H(n):
    """so(2)^{n/2}: span of e_1^e_2, e_3^e_4, ..."""
    idx = pair_index(n); N=len(idx)
    H=np.zeros((n//2,N))
    for k in range(n//2):
        H[k, idx[(2*k,2*k+1)]]=1.0
    return H

def su3_ad_H():
    """ad(su(3)) inside so(8): adjoint matrices of an orthonormal basis of su(3)."""
    # Gell-Mann matrices /2 -> basis of su(3) as i*herm; use X_k = i*lambda_k/2 (anti-herm, traceless)
    l=[]
    def m(*rows): return np.array(rows,dtype=complex)
    l.append(m([0,1,0],[1,0,0],[0,0,0]))
    l.append(m([0,-1j,0],[1j,0,0],[0,0,0]))
    l.append(m([1,0,0],[0,-1,0],[0,0,0]))
    l.append(m([0,0,1],[0,0,0],[1,0,0]))
    l.append(m([0,0,-1j],[0,0,0],[1j,0,0]))
    l.append(m([0,0,0],[0,0,1],[0,1,0]))
    l.append(m([0,0,0],[0,0,-1j],[0,1j,0]))
    l.append(m([1,0,0],[0,1,0],[0,0,-2])/np.sqrt(3))
    X=[1j*L/2 for L in l]                      # anti-hermitian, tr=0
    # <X,Y> = -2 tr(XY) makes these orthonormal:  -2 tr(X_a X_b) = delta
    G=np.array([[-2*np.trace(a@b).real for b in X] for a in X])
    assert np.abs(G-np.eye(8)).max()<1e-12, G
    # ad matrices in this orthonormal basis: (ad X_a)_{cb} = <[X_a,X_b],X_c>
    ad=np.zeros((8,8,8))
    for a in range(8):
        for b in range(8):
            com=X[a]@X[b]-X[b]@X[a]
            for cc in range(8):
                ad[a,cc,b]=(-2*np.trace(com@X[cc])).real
    # ad[a] is antisymmetric 8x8; express in the pair basis of so(8)
    idx=pair_index(8); N=len(idx)
    H=np.zeros((8,N))
    for a in range(8):
        A=ad[a]
        assert np.abs(A+A.T).max()<1e-10
        for (i,j),k in idx.items():
            H[a,k]=A[i,j]*np.sqrt(2)   # <A, X_ij> with X_ij=(E_ij-E_ji)/sqrt2, <,>=tr(A^T B)
    # rescale to the record's Lambda^2 inner product: <A,B>=tr(A^TB)/2 -> coeff along e_i^e_j is A_ij
    H=np.zeros((8,N))
    for a in range(8):
        A=ad[a]
        for (i,j),k in idx.items(): H[a,k]=A[i,j]
    return H

def cpm_weyl(m):
    """Weyl operator of CP^m (Fubini-Study, hol. sec. curv. 4), n=2m, unit norm."""
    n=2*m
    J=np.zeros((n,n))
    for k in range(m):
        J[2*k,2*k+1]=1.0; J[2*k+1,2*k]=-1.0
    d=np.eye(n)
    # R_{ijkl} = <R(e_i,e_j)e_k, e_l> with the FS tensor
    R=np.einsum('ik,jl->ijkl',d,d)-np.einsum('il,jk->ijkl',d,d) \
      +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J) \
      +2*np.einsum('ij,kl->ijkl',J,J)
    # operator on Lambda^2 with e_i^e_j orthonormal:  W_{(ij),(kl)} = R_{ijkl}
    P=core.pairs(n); N=len(P)
    Op=np.array([[R[i,j,k,l] for (k,l) in P] for (i,j) in P])
    Op=(Op+Op.T)/2
    Ric=np.einsum('ijil->jl',R)
    scal=np.trace(Ric)
    # Einstein: Weyl part = R - scal/(n(n-1)) * Id  (Id = constant curvature operator)
    Wl=Op - scal/(n*(n-1))*np.eye(N)
    return Wl/np.linalg.norm(Wl)

def cp2_padded(n):
    """W_{CP^2} on Lambda^2 R^4 subset Lambda^2 R^n, zero elsewhere."""
    W4=cpm_weyl(2)
    P4=core.pairs(4); Pn=core.pairs(n); idx={pq:i for i,pq in enumerate(Pn)}
    N=len(Pn); W=np.zeros((N,N))
    for a,pa in enumerate(P4):
        for b,pb in enumerate(P4):
            W[idx[pa],idx[pb]]=W4[a,b]
    return W
