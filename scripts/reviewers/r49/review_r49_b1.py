"""Reviewer 49 phase P2 -- B1: is Q additive over orthogonal index blocks?

Cross term is circ(X,Y) = 1/2(XY+YX) + sharp_polar(X,Y).  Q(X+Y) = Q(X)+Q(Y)
exactly when circ(X,Y) = 0.  Four regimes are separated here:

  (a) supports Lambda^2(A), Lambda^2(B) for DISJOINT coordinate blocks A, B,
      including ambient n > |A|+|B| and non-contiguous coordinate sets;
  (b) Frobenius-orthogonal operators sharing coordinates;
  (c) operators with orthogonal RANGES (X Y = 0) sharing coordinates;
  (d) one operator on Lambda^2(A), the other with support touching A^ B planes.
"""
import sys, itertools
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

rng = np.random.default_rng(4900)


def rand_weyl(n, seed=None):
    B = C.weyl_basis(n)
    g = np.random.default_rng(seed) if seed is not None else rng
    return np.einsum('k,kij->ij', g.standard_normal(B.shape[0]), B)


def cross(n, X, Y):
    Z = C.circ(n, X, Y)
    add = C.Qmap(n, X + Y) - C.Qmap(n, X) - C.Qmap(n, Y)
    return np.abs(Z).max(), np.abs(add).max()


def anti_self_dual_cp2(n=4, coords=(0, 1, 2, 3)):
    """The Lambda^- twin of fox_cp2: same eigenvalues on the anti-self-dual forms."""
    ps, idx = C.pindex(n)
    N = len(ps)
    a, b, c, d = coords
    trip = [((a, b), (c, d)), ((a, c), (d, b)), ((a, d), (b, c))]
    V = []
    for (p, q) in trip:
        v = np.zeros(N)
        g, s = C._sgn_idx(idx, *p); v[g] += s / np.sqrt(2.0)
        g, s = C._sgn_idx(idx, *q); v[g] -= s / np.sqrt(2.0)
        V.append(v)
    lam = np.array([2.0, -1.0, -1.0]) / np.sqrt(6.0)
    return sum(l * np.outer(v, v) for l, v in zip(lam, V))


print("=== (a) DISJOINT coordinate blocks: cross term and additivity defect ===", flush=True)
print(f"{'n':>3} {'block A':>16} {'block B':>16} {'|circ(A,B)|':>12} {'|Q(A+B)-QA-QB|':>16} {'<A,B>':>10}", flush=True)
setups = [
    (8, (0, 1, 2, 3), (4, 5, 6, 7)),
    (9, (0, 1, 2, 3), (4, 5, 6, 7)),          # ambient exceeds the union
    (10, (0, 1, 2, 3), (4, 5, 6, 7)),         # ambient exceeds the union by 2
    (10, (0, 2, 4, 6), (1, 3, 5, 7)),         # interleaved, still disjoint
    (10, (1, 4, 7, 9), (0, 2, 3, 5)),         # scattered, disjoint, n>union
    (12, (0, 1, 2, 3, 4, 5), (6, 7, 8, 9, 10, 11)),
]
for n, A, B in setups:
    nA, nB = len(A), len(B)
    WA = C.embed(rand_weyl(nA, seed=11), nA, n, A)
    WB = C.embed(rand_weyl(nB, seed=22), nB, n, B)
    c1, c2 = cross(n, WA, WB)
    print(f"{n:3d} {str(A):>16} {str(B):>16} {c1:12.2e} {c2:16.2e} {C.fro(WA,WB):10.1e}", flush=True)

print("\n  same test with generic (non-Weyl) symmetric block-supported matrices:", flush=True)
for n, A, B in [(8, (0, 1, 2, 3), (4, 5, 6, 7)), (10, (0, 2, 4, 6), (1, 3, 5, 7))]:
    nA, nB = len(A), len(B)
    M = rng.standard_normal((nA * (nA - 1) // 2,) * 2); M = M + M.T
    Nn = rng.standard_normal((nB * (nB - 1) // 2,) * 2); Nn = Nn + Nn.T
    WA = C.embed(M, nA, n, A); WB = C.embed(Nn, nB, n, B)
    c1, c2 = cross(n, WA, WB)
    print(f"   n={n}: |circ|={c1:.2e}  |additivity defect|={c2:.2e}", flush=True)

print("\n=== (b) Frobenius-orthogonal but sharing coordinates ===", flush=True)
print(f"{'n':>3} {'<X,Y>':>10} {'|circ(X,Y)|':>12} {'|Q(X+Y)-QX-QY|':>16}", flush=True)
for n in (5, 6, 7, 8):
    X = rand_weyl(n, seed=101 + n)
    Y = rand_weyl(n, seed=202 + n)
    Y = Y - (C.fro(X, Y) / C.fro(X, X)) * X          # force <X,Y> = 0
    X = C.normalize(X); Y = C.normalize(Y)
    c1, c2 = cross(n, X, Y)
    print(f"{n:3d} {C.fro(X,Y):10.1e} {c1:12.4e} {c2:16.4e}", flush=True)

print("\n=== (c) orthogonal RANGES (X Y = 0) on the SAME coordinates ===", flush=True)
print(f"{'ambient n':>10} {'<X,Y>':>10} {'|XY|':>10} {'|circ|':>12} {'|defect|':>12}", flush=True)
for n in (4, 5, 6, 8):
    X = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))          # supported on Lambda^+(R^4)
    Y = C.embed(anti_self_dual_cp2(4), 4, n, (0, 1, 2, 3))  # supported on Lambda^-(R^4)
    c1, c2 = cross(n, X, Y)
    print(f"{n:10d} {C.fro(X,Y):10.1e} {np.abs(X@Y).max():10.1e} {c1:12.4e} {c2:12.4e}", flush=True)

print("\n=== (d) one block-supported, one touching the cross planes ===", flush=True)
print(f"{'n':>3} {'<X,Y>':>10} {'|circ|':>12} {'|defect|':>12}  description", flush=True)
n = 8
WA = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))
ps, idx = C.pindex(n)
# Y: a Weyl_8 element with its Lambda^2({0..3}) x Lambda^2({0..3}) part projected out
Y = rand_weyl(n, seed=999)
mask = np.zeros((len(ps), len(ps)))
insideA = [a for a, (i, j) in enumerate(ps) if i < 4 and j < 4]
for a in insideA:
    for b in insideA:
        mask[a, b] = 1.0
Y2 = Y * (1 - mask)
c1, c2 = cross(n, WA, Y2)
print(f"{n:3d} {C.fro(WA,Y2):10.1e} {c1:12.4e} {c2:12.4e}  Y has zero Lambda^2(A) block", flush=True)
# and the sphere product itself: is S^p x S^q a block sum?
for blocks in [(4, 4), (3, 5), (6, 6)]:
    nn = sum(blocks)
    W = C.normalize(C.sphere_product(blocks))
    off = 0.0
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    psn, _ = C.pindex(nn)
    crossmass = sum(W[a, a]**2 for a, (i, j) in enumerate(psn) if lab[i] != lab[j])
    print(f"   S^{blocks[0]}xS^{blocks[1]}: mass on cross-block 2-planes = {crossmass:.6f} "
          f"(a block sum would have 0)", flush=True)
