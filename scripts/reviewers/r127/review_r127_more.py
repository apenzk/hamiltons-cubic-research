import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np, itertools
import review_r127_lib as L

def analyse(M, n, tag):
    M = M/np.linalg.norm(M)
    Qm = L.Q(M, n); lam = float((Qm*M).sum())
    res = float(np.abs(Qm-lam*M).max())
    K = L.vertex(M,n); ev=np.sort(np.linalg.eigvalsh(K))[::-1]
    pos=ev[ev>1e-9]; ins=pos[pos<lam-1e-9]
    psd=float(np.linalg.eigvalsh(K@K-lam*K).min()); t=float((K*K).sum())
    U=lam*K-K*K-K@K; np.fill_diagonal(U,0.0); Wt=K*K+U
    off=Wt[~np.eye(n,dtype=bool)]
    print(f"{tag:22s} n={n:2d} lam={lam:+.6f} crit-res={res:.1e} {'CRITICAL' if res<1e-8 else '   not-crit'} "
          f"t={t:.5f} lam^2={lam*lam:.4f} offM={float(np.abs(M-np.diag(np.diag(M))).max()):.1e} "
          f"r={len(pos)} inside={len(ins)} minEig={psd:+.5f} minW={off.min():+.5f}")
    return res, psd

# ---- HP^m ----
def quat_structs(n, m):
    Js = []
    for which in range(3):
        J = np.zeros((n,n))
        for b in range(m):
            o = 4*b
            # right mult by i, j, k on (1,i,j,k) coordinates
            if which==0:   # i: 1->i, i->-1, j->-k? use  e0->e1,e1->-e0,e2->-e3,e3->e2
                pairs=[(0,1,1),(1,0,-1),(2,3,-1),(3,2,1)]
            elif which==1: # j: e0->e2, e2->-e0, e1->e3, e3->-e1
                pairs=[(0,2,1),(2,0,-1),(1,3,1),(3,1,-1)]
            else:          # k: e0->e3, e3->-e0, e1->-e2, e2->e1
                pairs=[(0,3,1),(3,0,-1),(1,2,-1),(2,1,1)]
            for (src,dst,s) in pairs:
                J[o+dst, o+src] = s
        Js.append(J)
    return Js

def hpm_tensor(m):
    n = 4*m
    Js = quat_structs(n, m)
    # check quaternion relations
    for a in range(3):
        assert np.allclose(Js[a]@Js[a], -np.eye(n)), a
    g = np.eye(n)
    R = np.einsum('ac,bd->abcd', g, g) - np.einsum('ad,bc->abcd', g, g)
    for J in Js:
        Jm = J.T.copy()
        R = R + (np.einsum('ac,bd->abcd', Jm, Jm) - np.einsum('ad,bc->abcd', Jm, Jm)
                 + 2*np.einsum('ab,cd->abcd', Jm, Jm))
    return R

# ---- bi-invariant compact Lie group ----
def su_basis(N):
    B=[]
    for i in range(N):
        for j in range(i+1,N):
            X=np.zeros((N,N),complex); X[i,j]=1; X[j,i]=-1; B.append(X)
            Y=np.zeros((N,N),complex); Y[i,j]=1j; Y[j,i]=1j; B.append(Y)
    for k in range(1,N):
        d=np.zeros(N,complex); d[:k]=1j; d[k]=-1j*k
        B.append(np.diag(d))
    G=np.array([[ (-np.trace(X@Y)).real for Y in B] for X in B])
    w,V=np.linalg.eigh(G)
    T=V@np.diag(1/np.sqrt(w))@V.T
    return [sum(T[i,k]*B[k] for k in range(len(B))) for i in range(len(B))]

def so_basis(N):
    B=[]
    for i in range(N):
        for j in range(i+1,N):
            X=np.zeros((N,N)); X[i,j]=1; X[j,i]=-1; B.append(X/np.sqrt(2))
    return [b.astype(complex) for b in B]

def lie_tensor(basis):
    n=len(basis)
    ip=lambda X,Y: (-np.trace(X@Y)).real
    C=np.zeros((n,n,n))
    for a in range(n):
        for b in range(n):
            br=basis[a]@basis[b]-basis[b]@basis[a]
            for c in range(n):
                C[a,b,c]=ip(br,basis[c])
    R=0.25*np.einsum('abg,cdg->abcd',C,C)
    return R, n

if __name__=="__main__":
    print("=== HP^m (non-Kaehler? quaternion-Kaehler, NOT Kaehler) ===")
    for m in [2,3]:
        n=4*m
        R=hpm_tensor(m); Wt=L.weyl_part(R,n)
        print(f"  HP^{m}: |Ric(W)|={L.traces(Wt,n):.1e}")
        analyse(L.mop_from_tensor(Wt,n), n, f"HP^{m}")
    print()
    print("=== compact simple Lie groups, bi-invariant (non-Kaehler, non-symmetric) ===")
    for tag,bas in [("SU(3)",su_basis(3)),("SO(5)",so_basis(5)),("SU(4)",su_basis(4)),("SO(6)",so_basis(6))]:
        R,n=lie_tensor(bas)
        Wt=L.weyl_part(R,n)
        print(f"  {tag}: n={n} |Ric(W)|={L.traces(Wt,n):.1e}")
        analyse(L.mop_from_tensor(Wt,n), n, tag)
