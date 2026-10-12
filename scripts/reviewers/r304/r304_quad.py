"""A closed-form lower bound on lam_max(calL|e-perp) from 'quadrilateral' directions.

N = u v^T + v u^T with u = e_a - e_b, v = e_c - e_d (a,b,c,d distinct) is hollow,
symmetric, has zero row sums; <N,calL N>/||N||^2 = (M_ac+M_ad+M_bc+M_bd-2M_ab-2M_cd)/4.
"""
import sys, itertools; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C

def quad_bound(M, check=False):
    n=M.shape[0]; best=-1e9; arg=None
    for S in itertools.combinations(range(n),4):
        for (a,b,c,d) in [(S[0],S[1],S[2],S[3]),(S[0],S[2],S[1],S[3]),(S[0],S[3],S[1],S[2])]:
            u=np.zeros(n); u[a]=1; u[b]=-1
            v=np.zeros(n); v[c]=1; v[d]=-1
            N=np.outer(u,v)+np.outer(v,u)
            Np=N-np.sum(M*N)/np.sum(M*M)*M                 # project onto e-perp
            nn=float(np.sum(Np*Np))
            if nn<1e-12: continue
            R=float(np.sum(Np*C.calL(M,Np)))/nn
            cf=(M[a,c]+M[a,d]+M[b,c]+M[b,d]-2*M[a,b]-2*M[c,d])/4
            if check: assert abs(float(np.sum(N*C.calL(M,N)))/8-cf)<1e-12, (cf,)
            if R>best: best=R; arg=(a,b,c,d)
    return best, arg

if __name__=='__main__':
    from r304_solve import find, signature
    from r304_prize import lam_diag
    from r304_selfcheck import sphere_product
    print("closed form vs direct Rayleigh check on a random point:", end=' ')
    rng=np.random.default_rng(1); n=6
    Bs=C.basis_hollow_zero_rowsum(n); M=sum(x*B for x,B in zip(rng.normal(size=len(Bs)),Bs))
    quad_bound(M, check=True); print("OK")
    for n in [6,7,8]:
        sols=find(n,120,seed=400+n); seen={}
        for M,r in sols:
            seen.setdefault((round(C.theta_of(M),6),signature(M,4)),M)
        print(f"--- n={n} ---")
        for (th,_),M in sorted(seen.items(), key=lambda kv:-kv[0][0]):
            if th<=1e-9: continue
            d,_=C.defect_delta(M); qb,arg=quad_bound(M); lm=lam_diag(M)
            print(f" theta={th:+.6f} Delta={d:8.4f} theta/2={th/2:+.6f} quad_bound={qb:+.6f} "
                  f"quad>theta/2={qb>th/2}  lam_diag={lm:+.6f}")
        for (p,q) in ([(2,4),(3,3)] if n==6 else ([(2,5),(3,4)] if n==7 else [(2,6),(3,5),(4,4)])):
            M=sphere_product(p,q); th=C.theta_of(M); qb,_=quad_bound(M)
            print(f" S{p}xS{q}: theta={th:+.6f} Delta={C.defect_delta(M)[0]:.4f} theta/2={th/2:+.6f} "
                  f"quad_bound={qb:+.6f} quad>theta/2={qb>th/2} lam_diag={lam_diag(M):+.6f}")
