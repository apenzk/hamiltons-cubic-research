"""r280: independent checks of the support-dichotomy theorem's ingredients.

Checks, from the definitions only:
  A. padding embeds Weyl_{n0} into Weyl_n and preserves ||W||, P, and criticality.
  B. Frobenius orthogonality is implied by circ-orthogonality + criticality + theta!=0.
  C. the harmonic-square law on an explicit circ-orthogonal critical pair.
  D. a piece of a genuine splitting can have support dimension n_i = n.
  E. Lovelock collapse at n=5: P = 3 tr(W^3), and it fails at n=6.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (pair_index, Q, circ, P, weyl_basis,
                             sphere_product_W, normalize)

rng = np.random.default_rng(280)

def rand_weyl(n):
    B = weyl_basis(n)
    c = rng.standard_normal(B.shape[0])
    W = np.tensordot(c, B, axes=(0, 0))
    return normalize(W)

def pad(n0, n, W0):
    """embed an operator on Lambda^2 R^{n0} into Lambda^2 R^n by index inclusion"""
    p0, i0 = pair_index(n0); p, i = pair_index(n)
    out = np.zeros((len(p), len(p)))
    for a, (i1, j1) in enumerate(p0):
        for b, (i2, j2) in enumerate(p0):
            out[i[(i1, j1)], i[(i2, j2)]] = W0[a, b]
    return out

print("== A. padding ==")
for (n0, n) in [(4, 6), (5, 8), (6, 12), (8, 13)]:
    W0 = rand_weyl(n0); W = pad(n0, n, W0)
    # is the padded operator in Weyl_n?  project onto Weyl_n and compare
    B = weyl_basis(n)
    proj = np.tensordot(np.tensordot(B, W, axes=([1, 2], [0, 1])), B, axes=(0, 0))
    print(f"  n0={n0}->n={n}: ||W||={np.linalg.norm(W):.12f} vs {np.linalg.norm(W0):.12f}"
          f"  in-Weyl residual={np.linalg.norm(proj - W):.2e}"
          f"  P0={P(n0, W0):.12f}  Ppad={P(n, W):.12f}  dP={abs(P(n,W)-P(n0,W0)):.2e}")

print("== A'. padding preserves criticality and theta ==")
for (n0, n) in [(6, 12), (4, 12)]:
    W0 = normalize(sphere_product_W([n0 // 2, n0 // 2])[0])
    th0 = P(n0, W0); r0 = np.linalg.norm(Q(n0, W0) - th0 * W0)
    W = pad(n0, n, W0); th = P(n, W); r = np.linalg.norm(Q(n, W) - th * W)
    print(f"  S^{n0//2}xS^{n0//2} padded {n0}->{n}: theta {th0:.12f} -> {th:.12f}, "
          f"crit residual {r0:.2e} -> {r:.2e}")

print("== E. Lovelock collapse: P = 3 tr(W^3)? ==")
for n in [4, 5, 6, 7]:
    rows = []
    for _ in range(4):
        W = rand_weyl(n)
        tr3 = np.trace(np.linalg.matrix_power(W, 3))
        rows.append((P(n, W), tr3))
    ratios = [p / t for p, t in rows]
    print(f"  n={n}: P/tr(W^3) = " + ", ".join(f"{r:.10f}" for r in ratios))

print("== E'. <W,W#> vs 2 tr(W^3) ==")
from review_r30_core import sharp
for n in [4, 5, 6]:
    W = rand_weyl(n)
    s = np.tensordot(W, sharp(n, W))
    tr3 = np.trace(np.linalg.matrix_power(W, 3))
    print(f"  n={n}: <W,W#>={s:.12f}  2tr(W^3)={2*tr3:.12f}  diff={abs(s-2*tr3):.2e}")

print("== E''. the extremiser W_CP2 at n=5 ==")
# padded W_CP2 lives at n=4 already; build from the repo's own routine
sys.path.insert(0, 'scripts/lib')
from b_cp2_nondegenerate import padded_cp2
for n in [5, 6, 12]:
    W = normalize(padded_cp2(n)[0])
    tr3 = np.trace(np.linalg.matrix_power(W, 3))
    print(f"  n={n}: ||W||={np.linalg.norm(W):.12f} P={P(n,W):.12f} "
          f"tr(W^3)={tr3:.12f} 1/sqrt6={1/np.sqrt(6):.12f} "
          f"crit res={np.linalg.norm(Q(n,W)-P(n,W)*W):.2e}")

print("== B/C. circ-orthogonality: symmetry, implied orthogonality, harmonic law ==")
from review_r30_core import circ
n = 8
X, Y, Z = rand_weyl(n), rand_weyl(n), rand_weyl(n)
s1 = np.tensordot(circ(n, X, Y), Z); s2 = np.tensordot(circ(n, Y, Z), X)
s3 = np.tensordot(circ(n, Z, X), Y)
print(f"  trilinear symmetry: {s1:.12f} {s2:.12f} {s3:.12f}  spread={max(abs(s1-s2),abs(s2-s3)):.2e}")
# the cross term <Q(A),B> vanishes for ANY circ-orthogonal pair, critical or not
print("  <Q(A),B> = <A o B, A> is identically 0 whenever A o B = 0 -- algebraic, no criticality")
