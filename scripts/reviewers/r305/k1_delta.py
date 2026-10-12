"""Delta at diagonal points (cheap: eigenvectors of a diagonal W are the coordinate pairs)
and the admissibility audit of the component-indicator N."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from k1defs import sphere_M, direct_sum, components, solve_crit

def delta_diag(M, tol=1e-10):
    n=M.shape[0]; idx,pos,N,c=struct(n)
    W=np.diag([M[i,j] for (i,j) in idx])
    tot=0.0; npos=0
    for k,(i,j) in enumerate(idx):
        if M[i,j]>tol:
            npos+=1
            ad=c[k].T
            Cm=ad@W-W@ad
            tot+=float(np.sum(Cm*Cm))
    return tot,npos

# cross-check delta_diag against the basis-free Delta at n=6,8
for spec in [[(3,3)],[(2,2),(2,2)]]:
    Ms=[];ths=[]
    for s in spec:
        M=sphere_M(*s); r,t=crit_res(M); Ms.append(M);ths.append(t)
    M,th=direct_sum(Ms,ths); n=M.shape[0]
    idx,pos,N,c=struct(n); W=diag_to_operator(M,pos)
    print(f"cross-check {spec}: Delta_basisfree={Delta(c,W):.9f}  Delta_diag={delta_diag(M)[0]:.9f}")

print("\n=== Delta at DISCONNECTED diagonal critical points ===")
rng=np.random.default_rng(305)
zoo=[]
for (p,q) in [(2,2),(2,3),(3,3),(3,4)]:
    M=sphere_M(p,q); r,t=crit_res(M); zoo.append((f"S^{p}xS^{q}",M,t))
found=0
for trial in range(500):
    n=int(rng.integers(5,8))
    M,r,t=solve_crit(n,trial,rng)
    if r>1e-12 or t<1e-6: continue
    k,_=components(M)
    if k!=1: continue
    d,_=delta_diag(M)
    if d<1e-8: continue
    zoo.append((f"rand n={n} D={d:.3f}",M,t)); found+=1
    if found>=4: break
for nm,M,t in zoo:
    d,npos=delta_diag(M)
    print(f"  connected {nm:22s} n={M.shape[0]} theta={t:.6f} Delta={d:.6f}")
print()
import itertools
for i,j in itertools.combinations(range(len(zoo)),2):
    Ms=[zoo[i][1],zoo[j][1]]; ths=[zoo[i][2],zoo[j][2]]
    M,th=direct_sum(Ms,ths)
    r,thm=crit_res(M); d,_=delta_diag(M)
    Lm,B=diag_L_matrix(M); ev=np.linalg.eigvalsh(0.5*(Lm+Lm.T))
    print(f"  SUM {zoo[i][0]:22s} (+) {zoo[j][0]:22s} n={M.shape[0]:2d} theta={th:.6f} Delta={d:9.5f} "
          f"lam_max={ev[-1]:.6f} ratio={ev[-1]/th:.6f} res={r:.0e}")

print("\n=== admissibility of the component-indicator N at the record's OWN three sums ===")
for spec in [[(3,3),(4,4)],[(3,5),(3,3)],[(4,4),(5,5)]]:
    Ms=[];ths=[]
    for s in spec:
        Mi=sphere_M(*s); r,t=crit_res(Mi); Ms.append(Mi); ths.append(t)
    M,th=direct_sum(Ms,ths); n=M.shape[0]; k,lab=components(M)
    sizes=np.array([(lab==cc).sum() for cc in range(k)])
    for label,vals in [("a=(+1,-1) [sum over components = 0]", np.array([1.0,-1.0])),
                       ("sum over vertices = 0", np.array([1.0, -sizes[0]/sizes[1]]))]:
        a=np.zeros(n)
        for cc in range(k): a[lab==cc]=vals[cc]
        Nm=2*M*(a[:,None]+a[None,:])
        ip=np.sum(M*Nm)                     # <W,H> in the Frobenius normalisation
        print(f"  {' (+) '.join('S^%d xS^%d'%s for s in spec):26s} {label:36s} rowsums={np.abs(Nm.sum(1)).max():.1e} "
              f"<W,N>={ip:+.6f} rel={abs(ip)/(np.linalg.norm(M)*np.linalg.norm(Nm)):.4f} "
              f"||LN-thN||={np.abs(Lcal(M,Nm)-th*Nm).max():.1e}")
