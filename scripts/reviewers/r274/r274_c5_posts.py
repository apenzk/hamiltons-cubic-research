"""r274, Claim 5: does a bound built from ||M#||_F fall under fence posts 26 / 29 / 33?
Post 26 hypothesis: exact at the coordinate-diagonal end t = ||K||_F^2 = 2.
Post 29 mechanism: an O(n)-invariant quantity bounded by a frame-dependent one.
"""
import numpy as np, sys
sys.path.insert(0, __file__.rsplit('/',1)[0])
from r274_weyl import Geo
def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

print("post 29's mechanism: is (tr(M^3)+||M#||_F) O(n)-invariant?  (a frame-dependent")
print("quantity would fall under 29; an invariant one cannot)")
for n in (6, 8):
    g = Geo(n); rng = np.random.default_rng(4)
    A = rng.standard_normal((g.N,g.N)); M = g.proj_weyl(0.5*(A+A.T)); M/=np.linalg.norm(M)
    base = float(np.trace(M@M@M)) + np.linalg.norm(g.sharp(M))
    dev = []
    for _ in range(20):
        Q, _ = np.linalg.qr(rng.standard_normal((n,n)))
        if np.linalg.det(Q) < 0: Q[:, 0] *= -1
        R = g.to_tensor(M)
        R2 = np.einsum('ia,jb,kc,ld,abcd->ijkl', Q, Q, Q, Q, R, optimize=True)
        M2 = g.to_matrix(R2)
        dev.append(abs(float(np.trace(M2@M2@M2)) + np.linalg.norm(g.sharp(M2)) - base))
    print(f"  n={n}: max drift over 20 random rotations = {max(dev):.2e}  (value {base:.6f})")

print("\npost 26's hypothesis: the bound at the coordinate-diagonal end.")
print("At S^m x S^m -- coordinate-diagonal, so t=2 -- the bound EXCEEDS theta there:")
for n in (6, 8, 10, 12, 20, 24):
    m = n//2
    g = None
    a  = 1/np.sqrt((m-1)*(2*m-1)); b = -np.sqrt(m-1)/(m*np.sqrt(2*m-1))
    import itertools
    idx = list(itertools.combinations(range(n),2))
    lam = np.array([a if (i<m)==(j<m) else b for i,j in idx])
    def L(i,j,pos={p:k for k,p in enumerate(idx)}):
        return lam[pos[(i,j)]] if i<j else lam[pos[(j,i)]]
    sh = np.array([sum(L(i,k)*L(j,k) for k in range(n) if k not in (i,j)) for i,j in idx])
    tr3 = float(np.sum(lam**3)); th = tr3+float(np.dot(sh,lam)); bd = tr3+float(np.linalg.norm(sh))
    print(f"  n={n:>2}: theta={th:.6f}=theta_0  bound={bd:.6f}  bound/theta_0={bd/theta0(n):.6f}"
          f"  -> the bound is NOT exact at t=2, it is +{100*(bd/theta0(n)-1):.3f}% there")
