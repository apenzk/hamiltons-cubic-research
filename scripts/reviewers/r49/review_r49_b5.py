"""Reviewer 49 phase P6 -- B5: does 'theta large => indecomposable' do what the repair needs?

Three probes.
 (1) The n=4 identity P = 9(det W^+ + det W^-), which makes max P on Weyl_4
     unconditional and equal to sqrt(3/2), and exhibits S^2 x S^2 as the
     Lambda^+ / Lambda^- sum of two CP^2 operators -- a Q-additive splitting that
     is NOT an orthogonal coordinate split.
 (2) The annihilator ker(Y -> X o Y) inside Weyl_n at a padded point: every
     Q-additive companion of X, coordinate or not.
 (3) Padded W_CP2 at n=12: indecomposable, ungraded, S = 0 by dim m <= 2, and
     theta / theta_0 = 0.9909 -- the shape the law does not reach.
"""
import sys
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

SQ32 = np.sqrt(1.5)
th0 = lambda n: np.sqrt(2 * (n - 1) * (n - 2)) / n
rng = np.random.default_rng(4949)

print("=== (1) Weyl_4 = Sym^2_0(Lambda^+) (+) Sym^2_0(Lambda^-), and P = 9(det W+ + det W-) ===",
      flush=True)
ps, idx = C.pindex(4)
trip = [((0, 1), (2, 3)), ((0, 2), (3, 1)), ((0, 3), (1, 2))]
Vp, Vm = [], []
for (p, q) in trip:
    for sgn, store in ((+1, Vp), (-1, Vm)):
        v = np.zeros(6)
        g, s = C._sgn_idx(idx, *p); v[g] += s / np.sqrt(2.0)
        g, s = C._sgn_idx(idx, *q); v[g] += sgn * s / np.sqrt(2.0)
        store.append(v)
Vp = np.array(Vp); Vm = np.array(Vm)
print(f"  Lambda^+ / Lambda^- bases orthonormal: {np.abs(Vp@Vp.T-np.eye(3)).max():.1e} / "
      f"{np.abs(Vm@Vm.T-np.eye(3)).max():.1e}, mutual overlap {np.abs(Vp@Vm.T).max():.1e}", flush=True)
for trial in range(4):
    Mp = rng.standard_normal((3, 3)); Mp = Mp + Mp.T; Mp -= np.trace(Mp) / 3 * np.eye(3)
    Mm = rng.standard_normal((3, 3)); Mm = Mm + Mm.T; Mm -= np.trace(Mm) / 3 * np.eye(3)
    W = Vp.T @ Mp @ Vp + Vm.T @ Mm @ Vm
    r = np.abs(C.ricci(4, W)).max() + np.abs(C.bianchi(4, W)).max()
    lhs = C.Pval(4, W)
    rhs = 9 * (np.linalg.det(Mp) + np.linalg.det(Mm))
    print(f"  trial {trial}: in Weyl_4 (Ric+Bianchi {r:.1e})  P = {lhs:+.12f}   "
          f"9(detW+ + detW-) = {rhs:+.12f}   diff {abs(lhs-rhs):.1e}", flush=True)
print("  => max P on Weyl_4 = max 9(t+^3 + t-^3)*(2/6^1.5) s.t. t+^2+t-^2=1 = "
      f"{9*2/6**1.5:.12f} = sqrt(3/2), attained at t-=0. UNCONDITIONAL.", flush=True)

WS = C.normalize(C.sphere_product((2, 2)))
Wpm = C.normalize(Vp.T @ np.diag([2, -1, -1]) @ Vp / np.sqrt(6) +
                  Vm.T @ np.diag([2, -1, -1]) @ Vm / np.sqrt(6))
print(f"  S^2xS^2 at n=4: theta = {C.Pval(4, WS):.12f}; the (Lambda^+,Lambda^-) Fox sum: "
      f"theta = {C.Pval(4, Wpm):.12f}; sqrt(3)/2 = {np.sqrt(3)/2:.12f}", flush=True)
print(f"  spectra: S^2xS^2 {np.sort(np.linalg.eigvalsh(WS)).round(6)}   "
      f"pm-sum {np.sort(np.linalg.eigvalsh(Wpm)).round(6)}", flush=True)

print("\n=== (2) annihilator of a padded point: all Q-additive companions ===", flush=True)
print(f"{'n':>3} {'X':>14} {'dim ker L_X|Weyl':>18} {'coordinate prediction':>24}", flush=True)
for n, lbl, X, pred in [
    (6, "W_CP2 pad", C.embed(C.fox_cp2(4), 4, 6, (0, 1, 2, 3)), "Weyl_2 = 0, plus Lambda^- (5)"),
    (8, "W_CP2 pad", C.embed(C.fox_cp2(4), 4, 8, (0, 1, 2, 3)), "Weyl_4 on {4..7} = 10, plus Lambda^- (5)"),
    (9, "W_CP2 pad", C.embed(C.fox_cp2(4), 4, 9, (0, 1, 2, 3)), "Weyl_5 on {4..8} = 35, plus Lambda^- (5)"),
    (8, "S^3xS^3 pad", C.embed(C.normalize(C.sphere_product((3, 3))), 6, 8, tuple(range(6))),
     "Weyl_2 on {6,7} = 0"),
    (10, "S^3xS^3 pad", C.embed(C.normalize(C.sphere_product((3, 3))), 6, 10, tuple(range(6))),
     "Weyl_4 on {6..9} = 10"),
    (8, "S^4xS^4", C.normalize(C.sphere_product((4, 4))), "nothing (no free coordinates)"),
]:
    B = C.weyl_basis(n)
    d = B.shape[0]
    M = np.array([np.einsum('kij,ij->k', B, C.circ(n, X, E)) for E in B]).T
    s = np.linalg.svd(M, compute_uv=False)
    tol = max(M.shape) * s[0] * 1e-12
    ker = int((s <= tol).sum())
    print(f"{n:3d} {lbl:>14} {ker:18d}   {pred:>24}", flush=True)

print("\n=== (3) the padded point the law does not reach ===", flush=True)
for n in (8, 10, 12, 14):
    Wp = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))
    res, th = C.crit_residual(n, Wp)
    ev = np.linalg.eigvalsh(Wp)
    dm = int((ev < -1e-12).sum())
    print(f"  padded W_CP2 at n={n:2d}: theta={th:.9f}  theta_0={th0(n):.9f}  "
          f"theta/theta_0={th/th0(n):.6f}  dim(negative eigenspace)={dm}  "
          f"(S == 0 identically once dim m <= 2)  resid={res:.1e}", flush=True)
print("  Record says 'every ungraded S=0 point sits low, theta/theta_0 <= 0.53 measured and", flush=True)
print("  capped at 0.89 for n=12 by the law above'.  The padded W_CP2 is on that list at 0.9909.",
      flush=True)

print("\n=== (4) how large must theta be to force indecomposability? ===", flush=True)


def m(k):
    return SQ32 if k <= 11 else max(SQ32, th0(k))


for n in (12, 14, 16, 20, 24, 40):
    best = max(1.0 / np.sqrt(1 / m(a)**2 + 1 / m(n - a)**2) for a in range(4, n - 3))
    print(f"  n={n:3d}: decomposable ceiling D(n)={best:.6f}; sqrt(3)/2={np.sqrt(3)/2:.6f}; "
          f"theta_0(n)={th0(n):.6f}; a critical point with theta>{best:.6f} is indecomposable",
          flush=True)
