"""K1: the component-indicator direction, admissibility and eigenvalue."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from k1defs import sphere_M, direct_sum, components, solve_crit

rng=np.random.default_rng(7)
def build(sel_specs):
    Ms=[];ths=[]
    for s in sel_specs:
        M=sphere_M(*s); r,t=crit_res(M); Ms.append(M); ths.append(t)
    return direct_sum(Ms,ths)

cases={
 "S2xS2 (+) S2xS2 (equal sizes, equal theta)":[(2,2),(2,2)],
 "S2xS2 (+) S3xS4 (sizes 4 and 7)":[(2,2),(3,4)],
 "S2xS2 (+) S2xS3 (+) S3xS3 (three, unequal)":[(2,2),(2,3),(3,3)],
}
for name,spec in cases.items():
    M,th=build(spec)
    n=M.shape[0]; k,lab=components(M)
    print(f"\n--- {name}: n={n} comps={k} theta={th:.12f}")
    # component-indicator a: constant on each component, sum_i a_i = 0 over VERTICES
    for mode in ["sum_a_vertices=0","random a"]:
        a=np.zeros(n)
        vals=rng.normal(size=k)
        if mode=="sum_a_vertices=0":
            sizes=np.array([(lab==c).sum() for c in range(k)])
            vals=vals-np.dot(vals,sizes)/sizes.sum()
        for c in range(k): a[lab==c]=vals[c]
        Nm=2*M*(a[:,None]+a[None,:])
        LN=Lcal(M,Nm)
        rat=LN[np.abs(Nm)>1e-12]/Nm[np.abs(Nm)>1e-12]
        print(f"  {mode:22s}: rowsums={np.abs(Nm.sum(1)).max():.2e}  <M,N>_F={np.sum(M*Nm):+.6f}  "
              f"||LN-theta N||={np.abs(LN-th*Nm).max():.2e}  ratio range=[{rat.min():.9f},{rat.max():.9f}]/theta")
    # spectrum of the diagonal operator
    Lm,B=diag_L_matrix(M)
    ev=np.linalg.eigvalsh(0.5*(Lm+Lm.T))
    # M as a coefficient vector
    coef=np.array([np.sum(B[i]*M) for i in range(len(B))])
    coef/=np.linalg.norm(coef)
    Pp=np.eye(len(B))-np.outer(coef,coef)
    evp=np.linalg.eigvalsh(Pp@(0.5*(Lm+Lm.T))@Pp-1e6*np.outer(coef,coef))
    print(f"  diag spectrum: lam_max={ev[-1]:.12f} theta={th:.12f} ratio={ev[-1]/th:.9f};"
          f" mult(theta)={sum(abs(ev-th)<1e-9)}; lam_max on M-perp={evp[-1]:.12f} ratio={evp[-1]/th:.9f}")
    print(f"  is M an eigenvector of L at theta? ||L(M)-theta M||={np.abs(Lcal(M,M)-th*M).max():.2e}")
