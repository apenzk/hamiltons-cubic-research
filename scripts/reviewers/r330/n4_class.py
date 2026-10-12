"""Exact n=4 classification + sign check + mass-law convention check."""
import numpy as np, core, fam
wl4 = core.Weyl(4)

def full(name, W, n, wl):
    W = W/np.linalg.norm(W)
    res, th = fam.crit_res(W, wl.c)
    ev,_ = np.linalg.eigh(W)
    slack = ev[0] + (n-2)*ev[-1] - th
    print(f"{name:26s} dW={wl.dist(W):.1e} res={res:.1e} theta={th:+.9f} "
          f"lmin={ev[0]:+.6f} lmax={ev[-1]:+.6f} slack={slack:+.9f} "
          f"kerdim={int((np.abs(ev)<1e-9).sum())} spec={np.round(ev,6)}")

Wcp2 = fam.W_cp2()
Wss  = fam.W_from_subalgebra(4, fam.so_block(4,[0,1])+fam.so_block(4,[2,3]), wl4)
for nm,W in [("W_CP2",Wcp2),("-W_CP2",-Wcp2),("S2xS2",Wss),("-(S2xS2)",-Wss)]:
    full(nm, W, 4, wl4)

print()
print("Independent exhaustive n=4 solve: W=(A,B) on Lambda^2_+ / Lambda^2_-, kappa^2 check")
# verify kappa^2 = 2 numerically from the code, using the self-dual basis
pi=fam.pair_index(4)
def v(i,j,k,l,s):
    w=np.zeros(6); w[pi[(i,j)]]=1/np.sqrt(2); w[pi[(k,l)]]=s/np.sqrt(2); return w
sd=[v(0,1,2,3,1), v(0,2,1,3,-1), v(0,3,1,2,1)]
asd=[v(0,1,2,3,-1), v(0,2,1,3,1), v(0,3,1,2,-1)]
c=wl4.c
for lbl,B in [("self-dual",sd),("anti-self-dual",asd)]:
    k2=[]
    for a in range(3):
        for b in range(3):
            for d in range(3):
                k2.append(np.einsum('i,j,k,ijk->', B[a],B[b],B[d], c))
    k2=np.array(k2).reshape(3,3,3)
    eps=np.zeros((3,3,3))
    for p in [(0,1,2),(1,2,0),(2,0,1)]: eps[p]=1
    for p in [(0,2,1),(2,1,0),(1,0,2)]: eps[p]=-1
    kap = k2[0,1,2]
    print(f"  {lbl}: c = kappa*eps with kappa={kap:.9f}, kappa^2={kap**2:.9f}, "
          f"max dev {np.abs(k2-kap*eps).max():.1e}")
# cross terms between the two blocks must vanish
cross=max(abs(np.einsum('i,j,k,ijk->', sd[a],asd[b],x, c)) for a in range(3) for b in range(3) for x in sd+asd)
print(f"  max |c(sd,asd,*)| = {cross:.1e}  (blocks commute)")

print()
print("Exhaustive numeric solve of the n=4 criticality system over Weyl_4 (10 params), 4000 starts:")
from scipy.optimize import least_squares
K = wl4.K
def resid(x):
    W = wl4.from_vec(K@x); nrm=np.linalg.norm(W); W=W/nrm
    th = float(np.tensordot(W, core.Q(W,c),2))
    r = core.Q(W,c)-th*W
    return np.append(K.T@wl4.to_vec(r), np.linalg.norm(x)-1.0)
rng=np.random.default_rng(1)
found=[]
for t in range(4000):
    x0=rng.normal(size=K.shape[1]); x0/=np.linalg.norm(x0)
    s=least_squares(resid, x0, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
    if np.linalg.norm(s.fun)>1e-10: continue
    W=wl4.from_vec(K@s.x); W/=np.linalg.norm(W)
    th=float(np.tensordot(W, core.Q(W,c),2)); ev=np.linalg.eigvalsh(W)
    slack=ev[0]+2*ev[-1]-th
    found.append((round(th,6), tuple(np.round(ev,6)), round(slack,9)))
import collections
cnt=collections.Counter(found)
print(f"  {len(found)} converged criticality solutions; distinct spectra:")
for (th,ev,sl),k in sorted(cnt.items(), key=lambda z:-z[1]):
    print(f"    theta={th:+.6f} slack={sl:+.9f} count={k:5d} spec={ev}")
