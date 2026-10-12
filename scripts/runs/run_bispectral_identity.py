"""Falsifier for the bi-spectral identity  P(W) = 3/2 tr_{Lambda^2}(W^3) - 1/2 tr_{S^2_0}(Wring^3).
Second-kind operator in LI'S CONVENTION, arXiv:2112.08465 eq. (2.2): (Wring h)_ij = sum W_{iklj} h_kl.
The opposite index order W_{ikjl} flips the sign of Wring and of the 1/2 coefficient.
Fresh implementation: W as a 4-index array, W^# via so(n) structure constants,
W̊ on symmetric 2-tensors by (W̊h)_{ij} = Σ W_{ikjl} h_{kl}."""
import numpy as np, itertools, sys
rng = np.random.default_rng(0)

def random_weyl(n):
    # random algebraic curvature tensor by symmetrising a random 4-tensor, then remove Ricci part
    A = rng.standard_normal((n,n,n,n))
    R = A - A.transpose(1,0,2,3); R = R - R.transpose(0,1,3,2); R = R + R.transpose(2,3,0,1)
    R = R - (R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/1.0  # crude; re-project with Bianchi below
    # proper projection: b(R)_{ijkl} = (R_{ijkl}+R_{jkil}+R_{kijl})/3 ; curvature part = R - b(R)
    b = (R + R.transpose(1,2,0,3) + R.transpose(2,0,1,3))/3
    R = R - b
    # remove Ricci part via Kulkarni–Nomizu
    Ric = np.einsum('ikjk->ij', R); g = np.eye(n); s = np.trace(Ric)
    E = Ric - s/n*g
    def KN(A,B): return np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)-np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B)
    W = R - KN(E,g)/(n-2) - s/(2*n*(n-1))*KN(g,g)
    return W/np.sqrt(np.einsum('ijkl,ijkl',W,W))

def checks(W):
    n=W.shape[0]
    ric=np.abs(np.einsum('ikjk->ij',W)).max()
    bia=np.abs(W+W.transpose(1,2,0,3)+W.transpose(2,0,1,3)).max()
    return ric,bia

def lam2_matrix(W):
    n=W.shape[0]; pairs=list(itertools.combinations(range(n),2)); N=len(pairs)
    M=np.zeros((N,N))
    for a,(i,j) in enumerate(pairs):
        for b,(k,l) in enumerate(pairs):
            M[a,b]=W[i,j,k,l]
    return M,pairs

def sharp(M,pairs,n):
    # so(n) structure constants in the e_i∧e_j basis with [e_ij,e_kl] = δ_jk e_il - δ_ik e_jl - δ_jl e_ik + δ_il e_jk
    N=len(pairs); pos={p:a for a,p in enumerate(pairs)}
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    basis=[E(i,j) for (i,j) in pairs]
    c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=basis[a]@basis[b]-basis[b]@basis[a]
            for g,(k,l) in enumerate(pairs): c[a,b,g]=C[k,l]
    # (M#)_{ab} = 1/2 Σ c_{a γ δ} c_{b ε ζ} M_{γ ε} M_{δ ζ}
    return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M)

def ring_matrix(W):
    n=W.shape[0]
    # orthonormal basis of S^2_0: use all symmetric e_i⊙e_j then restrict; simpler: matrix of W̊ on Sym^2 (n(n+1)/2 dim), then restrict to trace-free
    idx=[(i,j) for i in range(n) for j in range(i,n)]
    m=len(idx); Op=np.zeros((m,m))
    def basis(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[basis(i,j) for (i,j) in idx]
    for a,h in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)  # Li arXiv:2112.08465 eq. (2.2)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    # project to trace-free: remove the g direction
    gvec=np.array([np.sum(basis(i,j)*np.eye(n)) for (i,j) in idx]); gvec/=np.linalg.norm(gvec)
    Pr=np.eye(m)-np.outer(gvec,gvec)
    Op0=Pr@Op@Pr
    return Op0

for n in [4,5,6,7]:
    rows=[]
    for t in range(12):
        W=random_weyl(n); ric,bia=checks(W)
        M,pairs=lam2_matrix(W)
        # normalise so that <W,W> on Λ² = 1 (Frobenius of M)
        M/=np.linalg.norm(M); W=W*(np.linalg.norm(M)/1) # W consistent scaling irrelevant for ratios; recompute
        W4=W/np.sqrt(np.einsum('ijkl,ijkl',W,W))*2  # so that M=lam2 has Frobenius 1 (since |W|^2 = 4|M|^2)
        M,_=lam2_matrix(W4)
        Msh=sharp(M,pairs,n)
        P=np.trace(M@M@M)+np.trace(Msh@M)
        t1=np.trace(M@M@M)
        R0=ring_matrix(W4); t2=np.trace(R0@R0@R0); q2=np.trace(R0@R0)
        rows.append((P,t1,t2,q2,ric,bia))
    A=np.array(rows)
    X=A[:,1:3]; y=A[:,0]
    coef,res,rk,sv=np.linalg.lstsq(X,y,rcond=None)
    fit=X@coef; err=np.abs(fit-y).max()
    print(f"n={n}: max Ricci {A[:,4].max():.1e} Bianchi {A[:,5].max():.1e} | fit P=c1*trW^3+c2*trWring^3: c1={coef[0]:.6f} c2={coef[1]:.6f} maxres={err:.2e} | trW̊^2/|M|^2 = {A[:,3].mean():.6f} (spread {A[:,3].std():.1e}) | rank X={rk}")
    if n==4:
        # is t2 proportional to t1 at n=4?
        r=A[:,2]/A[:,1]; print("   n=4 ratio trW̊^3/trW^3:",np.round(r,6))
