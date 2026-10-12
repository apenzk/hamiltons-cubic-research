"""J5 and J6: algebraic candidates, and the invariant subspace of the admissible space."""
import sys, itertools; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from r304_selfcheck import sphere_product

def admissible_basis(M):
    """orthonormal basis of {N hollow sym, N1=0} intersect M-perp."""
    Bs=C.basis_hollow_zero_rowsum(M.shape[0])
    return C.orth_complement_of(Bs,M)

def proj(V, X):
    """orthogonal projection of X onto span(V) (V Frobenius-orthonormal list)."""
    return sum(float(np.sum(B*X))*B for B in V) if V else np.zeros_like(X)

def rayleigh(M,N):
    nn=float(np.sum(N*N))
    if nn<1e-24: return 0.0, 0.0
    return float(np.sum(N*C.calL(M,N)))/nn, np.sqrt(nn)

def autos(M, tol=1e-9):
    n=M.shape[0]; out=[]
    for p in itertools.permutations(range(n)):
        idx=list(p)
        if np.abs(M[np.ix_(idx,idx)]-M).max()<tol: out.append(idx)
    return out

def invariant_subspace(M, V, G):
    """basis of the Aut(M)-invariant part of span(V)."""
    k=len(V); A=np.zeros((k,k))
    for g in G:
        for b in range(k):
            gb=V[b][np.ix_(g,g)]
            for a in range(k): A[a,b]+=float(np.sum(V[a]*gb))
    A/=len(G); A=(A+A.T)/2
    w,U=np.linalg.eigh(A)
    keep=U[:,w>0.5]
    return [sum(keep[i,j]*V[i] for i in range(k)) for j in range(keep.shape[1])]

def analyse(tag, M, do_autos=True):
    n=M.shape[0]; th=C.theta_of(M); d,_=C.defect_delta(M)
    V=admissible_basis(M)
    A=C.op_matrix(V, lambda N: C.calL(M,N)); ev,U=np.linalg.eigh(A)
    lam=ev.max(); top=[U[:,i] for i in range(len(ev)) if ev[i]>lam-1e-9]
    print(f"\n=== {tag}: n={n} theta={th:+.6f} Delta={d:.4f} res={np.abs(C.crit_residual(M)).max():.1e} "
          f"lam_diag={lam:+.6f} theta/2={th/2:+.6f} top-multiplicity={len(top)}")
    # J5 candidates
    for name,X in [("M o M",M*M),("M^2",M@M),("M o M o M",M*M*M)]:
        Pj=proj(V,X); r,nrm=rayleigh(M,Pj)
        print(f"   {name:10s}: ||proj||={nrm:.6e}  Rayleigh={r:+.6f}  exceeds theta/2={r>th/2}")
    p1=proj(V,M*M); p2=proj(V,M@M)
    print(f"   proj(MoM) + proj(M^2) = {np.linalg.norm(p1+p2):.3e}   (criticality forces 0)")
    if not do_autos: return
    G=autos(M); print(f"   |Aut(M)| = {len(G)}")
    Inv=invariant_subspace(M,V,G)
    print(f"   dim(admissible) = {len(V)},  dim(Aut-invariant admissible) = {len(Inv)}")
    if Inv:
        Ai=C.op_matrix(Inv, lambda N: C.calL(M,N)); evi=np.linalg.eigvalsh(Ai)
        print(f"   max Rayleigh over INVARIANT directions = {evi.max():+.6f}  vs theta/2={th/2:+.6f}  "
              f"{'*** INVARIANT DIRECTION VIOLATES ***' if evi.max()>th/2+1e-9 else 'invariant directions cannot violate'}")
    # is the top eigenspace invariant as a set / pointwise?
    Etop=[sum(t[i]*V[i] for i in range(len(V))) for t in top]
    Pt=np.zeros((len(V),len(V)))
    for t in top: Pt+=np.outer(t,t)
    worst_set=0.0; worst_fix=1e9
    for g in G:
        Mg=np.zeros((len(V),len(V)))
        for b in range(len(V)):
            gb=V[b][np.ix_(g,g)]
            for a in range(len(V)): Mg[a,b]=float(np.sum(V[a]*gb))
        worst_set=max(worst_set, np.abs(Mg@Pt-Pt@Mg).max())
    for E in Etop:
        dev=max(np.abs(E[np.ix_(g,g)]-E).max() for g in G)
        worst_fix=min(worst_fix,dev)
    print(f"   top eigenspace: invariant as a set (commutator {worst_set:.1e}); "
          f"min deviation of a top eigenvector from pointwise-fixed = {worst_fix:.4f}")

if __name__=='__main__':
    # C_5 blow-up n=10
    def c5(k,x,y,z):
        n=5*k; M=np.zeros((n,n)); blk=lambda i:i//k
        adj={(a,b) for a in range(5) for b in [(a+1)%5,(a-1)%5]}
        for i in range(n):
            for j in range(n):
                if i==j: continue
                a,b=blk(i),blk(j); M[i,j]= x if a==b else (y if (a,b) in adj else z)
        return M
    M=c5(2,0.2981,0.0745,-0.1491); M*=np.sqrt(2/np.sum(M*M))
    from scipy.optimize import least_squares
    def res(p):
        Mp=c5(2,*p); Mp*=np.sqrt(2/np.sum(Mp*Mp))
        R=C.crit_residual(Mp); return [R[0,1],R[0,2],R[0,4],Mp.sum(1)[0]]
    s=least_squares(res,[0.2981,0.0745,-0.1491],xtol=1e-15,ftol=1e-15)
    M=c5(2,*s.x); M*=np.sqrt(2/np.sum(M*M))
    analyse("C_5 blow-up (k=2)", M)
    for (p,q) in [(3,3),(3,5)]:
        analyse(f"S^{p}xS^{q}", sphere_product(p,q))

def trivial_aut(M, tol=1e-7):
    """sufficient certificate: all vertex signatures distinct => Aut(M) = {id}."""
    n=M.shape[0]
    sig=[tuple(np.round(np.sort(M[i]),7)) for i in range(n)]
    return len(set(sig))==n
