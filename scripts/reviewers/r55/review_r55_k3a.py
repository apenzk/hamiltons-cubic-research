"""Reviewer 55, K3 part A: the SECOND-ORDER OBSTRUCTION at the C_5 blow-up.

A corrector from a displaced start only samples; the tangent cone is decisive.

  W(t) = W + t v + t^2 u + ...  critical with |W(t)|=1
    order t : 2 theta (L_e - 1/2) v = 0            => v in E(1/2)
    order t^2: 2 theta (L_e - 1/2) u = -v o v + c W
  L_e is self-adjoint, so solvability needs  <v o v, z> = 0  for all z in E(1/2).

So the tangent cone of Crit(P) at W is contained in
      C = { v in E(1/2) : Pi_{E(1/2)}(v o v) = 0 }.
It always contains the orbit tangent.  If C = orbit tangent, then Crit(P) near W is
the orbit alone and {S=0} is open there for a reason a corrector cannot supply.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k1 import c5_vertex
from review_r55_k2 import Le_matrix

def setup(n=10):
    lam,_ = c5_vertex([2]*5)
    W = diag_operator(lam); W = W/np.linalg.norm(W)
    th = float(np.tensordot(W, Q(n,W))); e = W/th
    B = weyl_basis(n); D=B.shape[0]; Bf=B.reshape(D,-1)
    M = Le_matrix(n, e, B); Ms = 0.5*(M+M.T)
    ev, V = np.linalg.eigh(Ms)
    half = V[:, np.abs(ev-0.5)<1e-8]                 # (D, 60) coefficient columns
    F = np.einsum('dk,dij->kij', half, B)            # (60, N, N) matrices
    OT = onb(orbit_tangent(n, W))                    # (40, N*N)
    Oc = OT @ Bf.T                                   # orbit in Weyl coordinates
    Oq,_ = np.linalg.qr(Oc.T)                        # (D,40)
    # orbit expressed in the E(1/2) basis
    Oh = half.T @ Oq                                 # (60,40)
    Oh,_ = np.linalg.qr(Oh)
    return dict(n=n,W=W,th=th,e=e,B=B,Bf=Bf,ev=ev,V=V,half=half,F=F,Oh=Oh,Ms=Ms)

def build_T(s):
    """T[i,j,k] = <F_i, F_j o F_k> on E(1/2)."""
    n=s['n']; F=s['F']; K=F.shape[0]
    T = np.zeros((K,K,K))
    for j in range(K):
        T[:,j,:] = Le_matrix(n, F[j], F)
    return T

def main():
    t0=time.time(); s=setup(); print(f"setup {time.time()-t0:.1f}s")
    T = build_T(s); K = T.shape[0]
    print(f"T built {time.time()-t0:.1f}s ; full symmetry check:")
    print(f"  max|T - T.transpose(1,0,2)| = {np.abs(T-T.transpose(1,0,2)).max():.2e}")
    print(f"  max|T - T.transpose(2,1,0)| = {np.abs(T-T.transpose(2,1,0)).max():.2e}")
    Oh = s['Oh']                                     # (60,40) orbit inside E(1/2)
    # sanity: orbit directions must satisfy the obstruction exactly
    obs = lambda x: np.einsum('ij,i,j->', T, x, x) if False else np.einsum('kij,i,j->k', T.transpose(2,0,1), x, x)
    def phi(x): return np.einsum('ijk,j,k->i', T, x, x)
    rng=np.random.default_rng(0)
    vals=[]
    for _ in range(200):
        a = rng.normal(size=Oh.shape[1]); v = Oh@a; v/=np.linalg.norm(v)
        vals.append(np.linalg.norm(phi(v)))
    print(f"  orbit directions: ||Pi_E(1/2)(v o v)|| max over 200 = {max(vals):.2e}")
    # excess complement
    Ex = np.eye(K) - Oh@Oh.T
    u,sv,_ = np.linalg.svd(Ex); Exb = u[:, sv>1e-8]
    print(f"  excess dim = {Exb.shape[1]}")
    exvals=[]
    for _ in range(500):
        a = rng.normal(size=Exb.shape[1]); v = Exb@a; v/=np.linalg.norm(v)
        exvals.append(np.linalg.norm(phi(v)))
    exvals=np.array(exvals)
    print(f"  PURE excess directions: ||phi(v)|| min={exvals.min():.4f} median={np.median(exvals):.4f} max={exvals.max():.4f}")
    # minimise ||phi(v)||^2 over the unit sphere of E(1/2), many starts,
    # and record how much of each solution lies OUTSIDE the orbit tangent.
    from scipy.optimize import minimize
    def f(x):
        nx=np.linalg.norm(x); v=x/nx
        p=phi(v); return float(p@p)
    def g(x):
        nx=np.linalg.norm(x); v=x/nx
        p=phi(v)
        gv = 4*np.einsum('ijk,i,k->j', T, p, v)
        gv = (gv - (gv@v)*v)/nx
        return gv
    outside=[]
    res_list=[]
    for trial in range(300):
        x0 = rng.normal(size=K)
        r = minimize(f, x0, jac=g, method='L-BFGS-B',
                     options=dict(maxiter=5000, ftol=1e-18, gtol=1e-14))
        v = r.x/np.linalg.norm(r.x)
        out = np.linalg.norm(v - Oh@(Oh.T@v))
        res_list.append(np.sqrt(r.fun)); outside.append(out)
    res_list=np.array(res_list); outside=np.array(outside)
    ok = res_list < 1e-7
    print(f"\n  300 minimisations of ||Pi_E(1/2)(v o v)|| over the unit sphere of E(1/2):")
    print(f"    residual < 1e-7 in {ok.sum()} of 300;  residual quantiles "
          f"{np.percentile(res_list,[0,25,50,75,100]).round(6)}")
    if ok.any():
        print(f"    of those, component OUTSIDE the orbit tangent: "
              f"min={outside[ok].min():.3e} max={outside[ok].max():.3e}")
    # tighter: only accept genuinely converged, report the largest outside-component
    for thr in (1e-6,1e-8,1e-10):
        m = res_list<thr
        if m.sum(): print(f"    thr {thr:g}: {m.sum():3d} solutions, max outside-component {outside[m].max():.3e}")
    np.save('scratchpad/r55_T.npy', T)
    np.save('scratchpad/r55_Oh.npy', Oh)
    print(f"[{time.time()-t0:.1f}s]")

if __name__=="__main__": main()
