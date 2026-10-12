"""Reviewer 55, K3 part J: a fast corrector in the IDEMPOTENT formulation.

Critical rays are exactly the nonzero solutions of Q(e) = e, with theta = 1/|e|.
That removes the sphere constraint entirely, and Newton's step is

    (2 L_e - 1) Delta = -(Q(e) - e).

Near a degenerate point the operator is singular, so the step is taken with the
Moore-Penrose pseudo-inverse of (2 L_{e0} - 1) frozen at the base point: that both
regularises the step and gauge-fixes it, since ker(2L_{e0}-1) = E(1/2) contains the
whole orbit tangent.  Convergence is judged by the residual ceasing to improve, not
by a threshold carried over from the nondegenerate case.
"""
import numpy as np, sys, time, collections
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k1 import c5_vertex
from review_r55_k2 import Le_matrix

n=10
lam,_=c5_vertex([2]*5); W=diag_operator(lam); W/=np.linalg.norm(W)
th=float(np.tensordot(W,Q(n,W))); e0=W/th
B=weyl_basis(n); D=B.shape[0]; Bf=np.ascontiguousarray(B.reshape(D,-1))
M=Le_matrix(n,e0,B); Ms=0.5*(M+M.T); ev,V=np.linalg.eigh(Ms)
d=2*ev-1.0; keep=np.abs(d)>1e-7
dinv=np.where(keep,1.0/np.where(keep,d,1.0),0.0)
half=V[:,~keep]
OT=onb(orbit_tangent(n,W)); Oq,_=np.linalg.qr((OT@Bf.T).T)
Pex=half-Oq@(Oq.T@half); u_,s_,_=np.linalg.svd(Pex,full_matrices=False); exc=u_[:,s_>1e-8]
c0=Bf@e0.ravel()
base_spec=np.sort(np.linalg.eigvalsh(W))
mat=lambda c: np.einsum('d,dij->ij',c,B)

def G(c):
    X=mat(c); return Bf@Q(n,X).ravel()-c
def pinvstep(r): return V@(dinv*(V.T@r))

def correct(c, maxit=4000):
    best=np.inf; bc=c.copy(); stall=0; lam_=1.0
    for k in range(maxit):
        r=G(c); nr=np.linalg.norm(r)
        if nr<best-1e-14: best=nr; bc=c.copy(); stall=0
        else:
            stall+=1
            if stall>60: break
        step=-pinvstep(r)
        ns=np.linalg.norm(step)
        if ns>0.5: step*=0.5/ns
        c=c+lam_*step
        if np.linalg.norm(c)>50: break
    return bc, best

def describe(c):
    X=mat(c); nrm=np.linalg.norm(X)
    if nrm<1e-8: return None
    Xn=X/nrm; t=float(np.tensordot(Xn,Q(n,Xn)))
    if t<0: Xn,t=-Xn,-t
    res=float(np.linalg.norm(Q(n,Xn)-t*Xn))
    return dict(theta=t, res=res, S=slack_struct(n,Xn),
                specdev=float(np.abs(np.sort(np.linalg.eigvalsh(Xn))-base_spec).max()),
                dc=float(np.linalg.norm(c-c0)))

rng=np.random.default_rng(9)
sets={'excess E(1/2)':[exc[:,i] for i in range(exc.shape[1])]}
rr=[]
for _ in range(20):
    v=rng.normal(size=D); v-=Oq@(Oq.T@v); v/=np.linalg.norm(v); rr.append(v)
sets['random Weyl_10']=rr
for tgt in (1.2060113,0.7602588,0.6666667,0.3333333,-0.6666667,0.0,0.4269255,-0.2602588):
    msk=np.abs(ev-tgt)<1e-6
    if msk.sum()==0: continue
    cols=V[:,msk]; dd=[]
    for _ in range(min(5,int(msk.sum()))):
        a=rng.normal(size=cols.shape[1]); v=cols@a; v/=np.linalg.norm(v); dd.append(v)
    sets[f'L_e eigenspace {tgt:+.4f} (dim {int(msk.sum())})']=dd

print(f"base theta={th:.9f}, |e0|={np.linalg.norm(e0):.6f}, S=0, excess=20, dim Weyl={D}")
print(f"{'direction set':>34} {'t':>5} {'#':>3} {'conv':>5} {'med resid':>10} {'med theta':>11} "
      f"{'max S':>9} {'med|dc|':>8} {'max specdev':>11}")
t00=time.time()
allland=collections.Counter()
for name,dirs in sets.items():
    for t in (0.05,0.2,0.4,0.8,1.2,2.0):
        rows=[]
        for dv in dirs:
            c,best=correct(c0+t*dv)
            info=describe(c)
            if info is None: continue
            rows.append(info)
            if info['res']<1e-5:
                allland[(round(info['theta'],6),round(info['S'],4),round(info['specdev'],6)>1e-6)]+=1
        if not rows: continue
        conv=sum(1 for r_ in rows if r_['res']<1e-5)
        med=lambda k: np.median([r_[k] for r_ in rows])
        print(f"{name:>34} {t:5.2f} {len(rows):3d} {conv:5d} {med('res'):10.2e} {med('theta'):11.7f} "
              f"{max(r_['S'] for r_ in rows):9.4f} {med('dc'):8.4f} {max(r_['specdev'] for r_ in rows):11.2e}")
print(f"\nlanding tally (theta, S, different-spectrum?):")
for k,v in sorted(allland.items(), key=lambda z:-z[1]):
    print(f"   theta={k[0]:.6f} S={k[1]:.4f} differentOrbit={k[2]}   x{v}")
print(f"[{time.time()-t00:.0f}s]")
