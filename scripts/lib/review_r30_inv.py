"""Reviewer 30: invariant Weyl spaces of candidate symmetric subalgebras h < so(n),
and the gradedness test [m,m] subset h."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import *

def as_bivector(n, A):
    """so(n) matrix A -> coefficient vector in phi basis."""
    pairs, idx = pair_index(n)
    return np.array([A[i,j] for (i,j) in pairs])

def subalg_so_pq(p,q):
    n=p+q; pairs,idx=pair_index(n)
    lab=[0]*p+[1]*q
    return n, np.array([[1.0 if a==b else 0.0 for b in range(len(pairs))]
                        for a,(i,j) in enumerate(pairs) if lab[i]==lab[j]])

def subalg_u(m):
    """u(m) < so(2m): A with AJ=JA, J = diag blocks [[0,-1],[1,0]]."""
    n=2*m; pairs,idx=pair_index(n)
    J=np.zeros((n,n))
    for k in range(m):
        J[2*k,2*k+1]=-1.0; J[2*k+1,2*k]=1.0
    # basis of so(n)
    B=[]
    for (i,j) in pairs:
        E=np.zeros((n,n)); E[i,j]=1; E[j,i]=-1; B.append(E)
    B=np.array(B)
    M=np.array([ (b@J-J@b).reshape(-1) for b in B ])   # (N, n*n)
    u,s,vt=np.linalg.svd(M.T, full_matrices=True)  # nullspace of M^T? we want x with sum x_a M_a =0
    # solve M^T x = 0  -> x in nullspace of M^T ( (n*n, N) )
    u2,s2,vt2=np.linalg.svd(M.T, full_matrices=True)
    tol=max(M.shape)*s2[0]*1e-12
    r=int((s2>tol).sum())
    return n, vt2[r:]

def spin7_so8():
    """spin(7) < so(8): stabilizer of the Cayley 4-form Phi (octonion multiplication).
    Built as the annihilator of Phi in Lambda^4 R^8 under the so(8) action."""
    n=8; pairs,idx=pair_index(n)
    # octonion multiplication table via Cayley-Dickson from quaternions
    # use standard Fano-plane triples for imaginary units e1..e7
    triples=[(1,2,3),(1,4,5),(1,7,6),(2,4,6),(2,5,7),(3,4,7),(3,6,5)]
    n_ = 8
    mul=np.zeros((8,8,8))
    for i in range(8): mul[0,i,i]=1; mul[i,0,i]=1
    for i in range(1,8): mul[i,i,0]=-1
    for (a,b,c) in triples:
        for (x,y,z) in [(a,b,c),(b,c,a),(c,a,b)]:
            mul[x,y,z]=1; mul[y,x,z]=-1
    # associative 3-form phi(x,y,z)=<x*y,z> on Im O = R^7 ; Cayley form on R^8:
    # Phi = dx0 ^ phi + *phi   (standard).  Instead: stabilizer of the 3-form in so(7) gives G2.
    # For spin(7) we use: Phi(x,y,z,w) = <x*(conj(y)*z) ... > -- use the cross-product def:
    # Phi_{ijkl} = <(e_i x e_j) x e_k , e_l>-type is messy; use triple cross product.
    def octmul(u,v):
        return np.einsum('i,j,ijk->k', u, v, mul)
    def conj(u):
        w=-u.copy(); w[0]=u[0]; return w
    # Cayley 4-form: Phi(x,y,z,w) = <x, (conj(y) z) conj(w) ... > ; use standard formula
    # Phi(x,y,z,w) = <x*conj(y), z*conj(w)> - <x,z><y,w> + <x,w><y,z>   (Harvey-Lawson-like)
    E=np.eye(8)
    Phi=np.zeros((8,8,8,8))
    for i,j,k,l in itertools.product(range(8),repeat=4):
        x,y,z,w=E[i],E[j],E[k],E[l]
        val = np.dot(octmul(x,conj(y)), octmul(z,conj(w))) - np.dot(x,z)*np.dot(y,w) + np.dot(x,w)*np.dot(y,z)
        Phi[i,j,k,l]=val
    # antisymmetrize
    A4=np.zeros_like(Phi)
    for perm in itertools.permutations(range(4)):
        sgn=np.linalg.det(np.eye(4)[list(perm)])
        A4 += sgn*Phi.transpose(perm)
    Phi=A4/24.0
    # so(8) action on Phi
    Bs=[]
    for (i,j) in pairs:
        M=np.zeros((8,8)); M[i,j]=1; M[j,i]=-1; Bs.append(M)
    rows=[]
    for M in Bs:
        d = -(np.einsum('ai,ajkl->ijkl',M,Phi)+np.einsum('aj,iakl->ijkl',M,Phi)
              +np.einsum('ak,ijal->ijkl',M,Phi)+np.einsum('al,ijka->ijkl',M,Phi))
        rows.append(d.reshape(-1))
    Mrow=np.array(rows)          # (28, 8^4)
    u,s,vt=np.linalg.svd(Mrow.T, full_matrices=True)
    tol=max(Mrow.shape)*s[0]*1e-12
    r=int((s>tol).sum())
    return 8, vt[r:], Phi

def invariant_weyl(n, hbasis):
    """dim of {X in Weyl_n : [ad(h),X]=0 for all h in hbasis}; returns (dim, basis)."""
    A=adj(n); N=A.shape[0]
    B=weyl_basis(n); d=B.shape[0]
    Bf=B.reshape(d,-1)
    G=np.zeros((d,d))
    for hv in hbasis:
        H = np.einsum('a,amn->mn', hv, A)      # = -ad(h) ; sign irrelevant
        act = np.einsum('mn,knp->kmp', H, B) - np.einsum('kmn,np->kmp', B, H)
        C = act.reshape(d,-1) @ Bf.T           # d x d matrix per generator
        G += C.T @ C
    ev,V=np.linalg.eigh(G)
    tol=max(ev[-1],1.0)*1e-10
    ns=V[:,ev<tol].T
    return ns.shape[0], np.einsum('kd,dij->kij', ns, B), ev

def gradedness(n, hbasis):
    """slack: || Pi_m [m,m] ||^2 relative; 0 iff symmetric pair."""
    A=adj(n); N=A.shape[0]
    Hb=np.array(hbasis)
    # orthonormal projector onto h in the phi basis
    u,s,vt=np.linalg.svd(Hb, full_matrices=False)
    Hon=vt[:int((s>1e-10).sum())]
    Ph = Hon.T@Hon
    Pm = np.eye(N)-Ph
    c=structure_constants(n)
    # [m,m] leakage: for orthonormal basis of m
    um,sm,vtm=np.linalg.svd(Pm); mb=vtm[:int((sm>1e-10).sum())]
    br = np.einsum('xa,yb,abg->xyg', mb, mb, c)
    leak = np.einsum('xyg,gh->xyh', br, Pm)
    return float(np.linalg.norm(leak)**2), float(np.linalg.norm(br)**2), Hon.shape[0]

if __name__=="__main__":
    print("=== dim Weyl_n^h for so(p)+so(q) ===")
    for n in (6,8,10):
        for p in range(1,n//2+1):
            q=n-p
            nn,hb=subalg_so_pq(p,q)
            dim,bas,s=invariant_weyl(n,hb)
            sl,tot,dh=gradedness(n,hb)
            note=""
            if dim>=1:
                W=bas[0]; W=normalize(W)
                th=float(np.tensordot(W,Q(n,W))); res=np.linalg.norm(Q(n,W)-th*W)
                note=f" theta={th:.9f} crit_resid={res:.1e}"
            print(f"  n={n} so({p})+so({q}) dim h={dh} dimWeyl^h={dim} slack[m,m]->m ={sl:.2e}{note}")
    print("=== dim Weyl_2m^{u(m)} ===")
    for m in (3,4,5):
        n,hb=subalg_u(m)
        dim,bas,s=invariant_weyl(n,hb)
        sl,tot,dh=gradedness(n,hb)
        note=""
        if dim>=1:
            W=normalize(bas[0]); th=float(np.tensordot(W,Q(n,W)))
            res=np.linalg.norm(Q(n,W)-th*W); note=f" theta={th:.9f} crit_resid={res:.1e}"
            np.save(f"scratchpad/r30/W_cp{m}.npy", W)
        print(f"  n={n} u({m}) dim h={dh} dimWeyl^h={dim} slack={sl:.2e}{note}")
    print("=== spin(7) < so(8) (triality image of so(7)) ===")
    n,hb,Phi=spin7_so8()
    print("   dim of stabilizer of Cayley form:", hb.shape[0], "(expect 21)")
    sl,tot,dh=gradedness(8,hb)
    print(f"   slack [m,m]->m = {sl:.3e} (total ||[m,m]||^2={tot:.3f})  => symmetric pair? {sl<1e-16*max(tot,1)}")
    dim,bas,s=invariant_weyl(8,hb)
    print(f"   dim Weyl_8^spin(7) = {dim}")
    if dim>=1:
        W=normalize(bas[0]); th=float(np.tensordot(W,Q(8,W)))
        print(f"   theta={th:.9f} crit_resid={np.linalg.norm(Q(8,W)-th*W):.1e}")
