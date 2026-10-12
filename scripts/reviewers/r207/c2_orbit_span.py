"""r207, claim 2 (premise): dim C = dim span{(g W_0)^3}, built from scratch.

W_0 is rebuilt here from the CP^2 description alone -- no repo module is
imported -- as a symmetric operator on Lambda^2 R^5 in the orthonormal basis
{e_i ^ e_j}_{i<j}.  The orbit span is measured through the Gram identity
<v^3, w^3> = <v, w>^3, so the 7770 cubic coordinates are never materialised:
dim span{(g_i W_0)^3} = rank of [ <g_i W_0, g_j W_0>^3 ].

Also prints ranks at degrees 1 and 2 as calibration: degree 1 must give 35
(Weyl_5 is irreducible, so the orbit spans it).
"""
import numpy as np, itertools

PAIRS = list(itertools.combinations(range(5), 2))          # 10
PIDX = {p: k for k, p in enumerate(PAIRS)}

def wedge(i, j):
    """e_i ^ e_j as a 10-vector."""
    v = np.zeros(10)
    if i == j: return v
    s = 1.0
    if i > j: i, j, s = j, i, -1.0
    v[PIDX[(i, j)]] = s
    return v

w1 = wedge(0,1) + wedge(2,3)
w2 = wedge(0,2) - wedge(1,3)
w3 = wedge(0,3) + wedge(1,2)
assert all(abs(w @ w - 2) < 1e-12 for w in (w1,w2,w3))
assert abs(w1@w2) + abs(w1@w3) + abs(w2@w3) < 1e-12
S6 = np.sqrt(6.0)
W0 = (2*np.outer(w1,w1) - np.outer(w2,w2) - np.outer(w3,w3)) / (2*S6)
print(f"|W_0|^2 = {np.sum(W0*W0):.12f}   (1)")
print(f"tr(W_0^3) = {np.trace(W0@W0@W0):.12f}   (1/sqrt6 = {1/S6:.12f})")
print(f"tr(W_0) = {np.trace(W0):.2e}   F_5(W_0) = "
      f"{1.5*np.sum(W0*W0)**3 - 9*np.trace(W0@W0@W0)**2:.2e}")

def lam2(g):
    L = np.empty((10,10))
    for a,(i,j) in enumerate(PAIRS):
        for b,(k,l) in enumerate(PAIRS):
            L[a,b] = g[i,k]*g[j,l] - g[i,l]*g[j,k]
    return L

rng = np.random.default_rng(20718)
def rand_so5():
    q, r = np.linalg.qr(rng.standard_normal((5,5)))
    q = q * np.sign(np.diag(r))
    if np.linalg.det(q) < 0: q[:, 0] = -q[:, 0]
    return q

N = 3800
pts = np.empty((N, 100))
for t in range(N):
    L = lam2(rand_so5())
    pts[t] = (L @ W0 @ L.T).ravel()
print(f"\n{N} orbit points; max ||gW_0|^2 - 1| = "
      f"{np.abs((pts**2).sum(1)-1).max():.2e}")

M = pts @ pts.T
for d in (1, 2, 3):
    ev = np.linalg.eigvalsh(M**d)[::-1]
    r = int((ev > ev.max()*1e-10).sum())
    print(f"\ndegree {d}: rank {r}")
    if r < N:
        print(f"   ev[{r-1}] = {ev[r-1]:.3e}   ev[{r}] = {ev[r]:.3e}   "
              f"ratio {ev[r-1]/abs(ev[r]):.2e}")
    for tol in (1e-8, 1e-9, 1e-11, 1e-12):
        print(f"   tol {tol:g}: {(ev > ev.max()*tol).sum()}")
