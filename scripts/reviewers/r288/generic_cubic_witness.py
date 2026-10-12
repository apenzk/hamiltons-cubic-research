"""Reviewer 288, C2 witness: a cubic form and a STRICT local maximum on the sphere
where the geodesic t^4 coefficient is POSITIVE, not -3 theta/8.  Generic symmetric
trilinear form on R^6; the critical point is produced by power iteration on Q."""
import numpy as np
np.random.seed(101)
m = 6
A = np.random.randn(m, m, m)
T = sum(A.transpose(p) for p in
        [(0,1,2),(0,2,1),(1,0,2),(1,2,0),(2,0,1),(2,1,0)]) / 6
P = lambda x: float(np.einsum('ijk,i,j,k->', T, x, x, x))
Qv = lambda x: np.einsum('ijk,j,k->i', T, x, x)
W = np.random.randn(m); W /= np.linalg.norm(W)
for _ in range(5000):
    v = Qv(W); W = v / np.linalg.norm(v)
th = P(W); L = np.einsum('ijk,k->ij', T, W)
ev = np.linalg.eigvalsh(L)
print("theta =", th, " ||Q(W)-thW|| =", np.linalg.norm(Qv(W) - th * W))
print("spec L_W =", np.round(ev, 4), "  theta/2 =", th / 2,
      "  => L_W < theta/2 on W-perp STRICTLY: A(1/2) = 0, W is a STRICT local max")
for _ in range(3):
    z = np.random.randn(m); z -= (z @ W) * W; z /= np.linalg.norm(z)
    lam = z @ L @ z
    ts = np.linspace(-1, 1, 9)
    g = np.array([P((W + t * z) / np.linalg.norm(W + t * z)) for t in ts])
    c4 = np.polyfit(ts, g, 8)[::-1][4]
    print(f"  lambda={lam:+.5f}  geodesic [t^4] ~ {15*th/8 - 4.5*lam:+.6f}"
          f"   (-3theta/8 would be {-3*th/8:+.6f})")
