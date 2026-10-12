"""Reviewer 55, K3 part E: what critical points actually sit near the C_5 blow-up?

Rather than pushing along chosen directions and correcting, this samples the whole
neighbourhood: Levenberg-Marquardt from random starts on spheres of radius r about
W inside Weyl_10, then records theta, S_structural, the distance travelled, and the
Lambda^2 spectrum of the landing point (a conjugation invariant, so a spectrum
different from the base's proves a different orbit).
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from scipy.optimize import least_squares
from review_r55_core import *
from review_r55_k1 import c5_vertex
from review_r55_k2 import Le_matrix

n=10
lam,_=c5_vertex([2]*5)
W=diag_operator(lam); W/=np.linalg.norm(W)
th=float(np.tensordot(W,Q(n,W)))
B=weyl_basis(n); D=B.shape[0]; Bf=np.ascontiguousarray(B.reshape(D,-1))
cW=Bf@W.ravel()
base_spec=np.sort(np.linalg.eigvalsh(W))
mat=lambda c: np.einsum('d,dij->ij',c,B)

def resid(c):
    X=mat(c); QX=Q(n,X); t=float(np.tensordot(X,QX))
    r=Bf@(QX-t*X).ravel()
    r=r-(r@c)*c
    return np.append(r, c@c-1.0)

def jac(c):
    """Analytic Jacobian: d/dc [Pi_{perp c}(Q(X)-t X)] with X = mat(c)."""
    X=mat(c); QX=Q(n,X); t=float(np.tensordot(X,QX)); q=Bf@QX.ravel()
    M=Le_matrix(n,X,B)                       # M[i,j] = <B_i, X o B_j>
    Jc=2*M - t*np.eye(D) - 3*np.outer(c,q)
    r=Bf@(QX-t*X).ravel()
    # d/dc of r - (r.c) c  =  Jc - c (r^T Jc + r^T) - (r.c) I
    Jp=Jc - np.outer(c, Jc.T@c) - np.outer(c, r) - (r@c)*np.eye(D)
    return np.vstack([Jp, 2*c])

def land(c):
    X=mat(c); X/=np.linalg.norm(X)
    t=float(np.tensordot(X,Q(n,X)))
    if t<0: X,t=-X,-t
    res=float(np.linalg.norm(Q(n,X)-t*X))
    return X,t,res,slack_struct(n,X),np.sort(np.linalg.eigvalsh(X))

def _main():
    rng=np.random.default_rng(int(sys.argv[1]) if len(sys.argv)>1 else 0)
    t0=time.time()
    print(f"base theta={th:.9f}  S=0  dim Weyl={D}")
    print(f"{'r':>6} {'starts':>7} {'conv':>6} {'same orbit':>11} {'S>1e-6':>8} {'notes'}")
    rows=[]
    for r in (0.02,0.05,0.1,0.2,0.4,0.7):
        nstart=25
        conv=0; same=0; spos=0; found=[]
        for k in range(nstart):
            v=rng.normal(size=D); v-=(v@cW)*cW; v/=np.linalg.norm(v)
            c=cW+r*v; c/=np.linalg.norm(c)
            sol=least_squares(resid,c,jac=jac,method='lm',xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=3000)
            rr=np.linalg.norm(sol.fun)
            X,t,res,S,spec=land(sol.x)
            if res>1e-5: continue
            conv+=1
            d=np.linalg.norm(np.sort(spec)-base_spec,ord=np.inf)
            dist=min(np.linalg.norm(sol.x-cW), np.linalg.norm(sol.x+cW))
            if d<1e-6: same+=1
            else: found.append((t,S,dist,d))
            if S>1e-6: spos+=1
        rows.append((r,nstart,conv,same,spos))
        print(f"{r:6.2f} {nstart:7d} {conv:6d} {same:11d} {spos:8d} "
              f"{'; '.join(f'th={f[0]:.5f} S={f[1]:.3f} d={f[2]:.3f}' for f in found[:4])}")
        # tabulate distinct landing points that are NOT the base orbit
        if found:
            import collections
            cc=collections.Counter((round(f[0],6),round(f[1],4)) for f in found)
            for kk,vv in sorted(cc.items(), key=lambda z:-z[0][0])[:8]:
                print(f"        landed: theta={kk[0]:.6f} S={kk[1]:.4f}  x{vv}")
    print(f"[{time.time()-t0:.0f}s]")


if __name__=='__main__': _main()
