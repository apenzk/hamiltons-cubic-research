"""Reviewer 55, K3 part B: the THIRD-ORDER obstruction.

Critical rays of P are exactly idempotents:  Q(e)=e  with e = W/theta.
Expand e(t) = e + t v + t^2 u + t^3 p in Q(e)-e = 0:

  t^1 : (2 L_e - 1) v = 0                 => v in E(1/2)
  t^2 : (2 L_e - 1) u = -(v o v)          solvable iff Pi_E(v o v)=0  [VACUOUS here]
        so u = u_0 + w,  u_0 = -(2L_e-1)^+ (v o v),  w in E(1/2) free
  t^3 : (2 L_e - 1) p = -2 (v o u)        solvable iff Pi_E(v o u)=0
        and Pi_E(v o w)=0 automatically (T vanishes on E(1/2)), so w drops out:

        Psi(v) := Pi_E( v o (2L_e-1)^+ (v o v) ) = 0.

Orbit directions satisfy Psi = 0.  If nothing else does, Crit(P) near W is the orbit.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k1 import c5_vertex
from review_r55_k2 import Le_matrix

def build(n=10):
    lam,_ = c5_vertex([2]*5)
    W = diag_operator(lam); W = W/np.linalg.norm(W)
    th = float(np.tensordot(W, Q(n,W))); e = W/th
    B = weyl_basis(n); D=B.shape[0]; Bf=np.ascontiguousarray(B.reshape(D,-1))
    M = Le_matrix(n, e, B); Ms=0.5*(M+M.T)
    ev, V = np.linalg.eigh(Ms)
    halfmask = np.abs(ev-0.5)<1e-8
    half = V[:, halfmask]
    # pseudo-inverse of (2 L_e - 1) on E(1/2)^perp, in the eigenbasis
    d = 2*ev-1.0
    dinv = np.where(np.abs(d)>1e-7, 1.0/np.where(np.abs(d)>1e-7,d,1.0), 0.0)
    OT = onb(orbit_tangent(n,W)); Oc = OT@Bf.T
    Oq,_ = np.linalg.qr(Oc.T)
    Oh,_ = np.linalg.qr(half.T@Oq)
    return dict(n=n,e=e,W=W,th=th,B=B,Bf=Bf,V=V,ev=ev,dinv=dinv,half=half,Oh=Oh)

def make_ops(s):
    n=s['n']; B=s['B']; Bf=s['Bf']; V=s['V']; dinv=s['dinv']; half=s['half']
    def mat(x):  return np.einsum('d,dij->ij', x, B)
    def coo(X):  return Bf @ X.ravel()
    def circ_c(x,y): return coo(circ(n, mat(x), mat(y)))
    def pinv(x): return V @ (dinv * (V.T @ x))
    def PiE(x):  return half @ (half.T @ x)
    def Psi(a):
        """a: coefficients in the E(1/2) basis (length 60)."""
        v = half @ a
        vv = circ_c(v, v)
        u0 = -pinv(vv)
        return half.T @ circ_c(v, u0)          # returns length-60 vector
    return mat, coo, circ_c, pinv, PiE, Psi

def main():
    t0=time.time(); s=build(); mat,coo,circ_c,pinv,PiE,Psi = make_ops(s)
    K = s['half'].shape[1]; Oh = s['Oh']
    rng = np.random.default_rng(7)
    print(f"E(1/2) dim {K}, orbit dim {Oh.shape[1]}, excess {K-Oh.shape[1]}")
    # sanity: orbit directions must have Psi = 0
    m=[]
    for _ in range(60):
        a = Oh @ rng.normal(size=Oh.shape[1]); a/=np.linalg.norm(a)
        m.append(np.linalg.norm(Psi(a)))
    print(f"  orbit directions: ||Psi|| max over 60 = {max(m):.3e}")
    # excess directions
    Ex = np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]
    m2=[]
    for _ in range(200):
        a = Exb @ rng.normal(size=Exb.shape[1]); a/=np.linalg.norm(a)
        m2.append(np.linalg.norm(Psi(a)))
    m2=np.array(m2)
    print(f"  pure excess:  ||Psi|| min={m2.min():.4f} med={np.median(m2):.4f} max={m2.max():.4f}")
    # scalar version <Psi(v),v>
    sc=[]
    for _ in range(50):
        a = Exb @ rng.normal(size=Exb.shape[1]); a/=np.linalg.norm(a)
        sc.append(float(Psi(a)@a))
    print(f"  <Psi(v),v> on pure excess: min={min(sc):.6f} max={max(sc):.6f}")
    # global minimisation of ||Psi(v)||^2 over the unit sphere of E(1/2)
    from scipy.optimize import minimize
    def f(x):
        v=x/np.linalg.norm(x); p=Psi(v); return float(p@p)
    best=[]
    t1=time.time()
    for trial in range(120):
        x0 = rng.normal(size=K)
        r = minimize(f, x0, method='Nelder-Mead' if False else 'Powell',
                     options=dict(maxiter=20000, xtol=1e-12, ftol=1e-16))
        v=r.x/np.linalg.norm(r.x)
        out = np.linalg.norm(v - Oh@(Oh.T@v))
        best.append((np.sqrt(max(r.fun,0)), out))
        if trial%30==0: print(f"    trial {trial}: res={np.sqrt(max(r.fun,0)):.3e} outside={out:.3e}  [{time.time()-t1:.0f}s]")
    best=np.array(best)
    for thr in (1e-4,1e-6,1e-8):
        msk = best[:,0]<thr
        if msk.sum():
            print(f"  thr {thr:g}: {msk.sum():3d}/120 zeros of Psi, max outside-orbit component = {best[msk,1].max():.3e}")
        else:
            print(f"  thr {thr:g}: 0/120")
    print(f"  residual quantiles {np.percentile(best[:,0],[0,10,50,90,100])}")
    print(f"[{time.time()-t0:.1f}s]")

if __name__=="__main__": main()
