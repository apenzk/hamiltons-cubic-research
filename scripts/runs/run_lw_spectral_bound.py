"""Sub-step A3, Track A of plan.md: combine the A1 trace identities with the
A2 Peirce cap into an upper bound on lambda = P(u) at a critical point /
local maximum of P on {|W|=1} subset W_n, and measure how far that bound
sits from the conjectured value theta0(n) = sqrt(2(n-1)(n-2))/n.

WHAT THIS SCRIPT DOES (four independent parts, run in order by main()):

  PART 1  Independent spot-check of A1's trace identities.  Builds L_W twice
          by structurally different routes -- run_lw_trace_identities.build_LW
          (vectorized congruence) and a column-by-column polarization of
          rsharp_basis_free.Q_full -- and checks
             tr(L_W)   = 0
             tr(L_W^2) = cn ||W||^2,            cn = (n-1)(2n-1)/4
             tr(L_W^3) = an tr(W^3) + bn <W#,W>, an = -(5n-1)/8, bn = n(n-5)/8
          at random Weyl tensors, the balanced sphere product, Fox's
          S^4(alpha), and a rescaled point (homogeneity).

  PART 2  Ground truth: the full spectrum of L_u at the two known critical
          families.  Confirms the cap (every eigenvalue off the u-line is
          <= lambda/2), that the cap is EXACTLY attained, and that its
          multiplicity equals the O(n)-orbit dimension of u.

  PART 3  The moment-problem bounds themselves (pure arithmetic, no curvature
          machinery), in the four flavours derived in the report:
          level 2, level 3, and each with the orbit multiplicity k0 folded in.

  PART 4  The kill-criterion table: bound - theta0(n) measured in units of the
          S^4(alpha)-to-W* gap theta0(n) - sqrt(3/2), plus the level-4
          assessment from precomputed tr(L_u^4) values.

Machinery reused (no new curvature primitives introduced):
  run_lw_trace_identities.py  build_weyl_orthonormal_basis, build_LW,
                              sphere_product_unit, fox_S4_unit
  rsharp_basis_free.py        Q_full (validation oracle + the two cubic invariants)
  weyl.py                     build_structure_constants

SIGN NOTE: fox_S4_unit() returns the tensor at the sign for which P < 0; the
critical point relevant here is its negative (P = +sqrt(3/2)).  Parts 2-4 use
-fox_S4_unit(n, c).
"""
import sys
import numpy as np
from math import sqrt

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from run_lw_trace_identities import (build_weyl_orthonormal_basis, build_LW,
                                     sphere_product_unit, fox_S4_unit)


# ---------------------------------------------------------------
# Closed-form data
# ---------------------------------------------------------------

def dims(n):
    """(D, cn, N, sigma_n): dim W_n, the tr(L^2) constant, dim Lambda^2 R^n,
    and Huisken/Lemma-2.10's sharp constant for |tr(u^3)| <= sigma_n ||u||^3."""
    D = n * (n + 1) * (n + 2) * (n - 3) // 12
    cn = (n - 1) * (2 * n - 1) / 4.0
    N = n * (n - 1) // 2
    sigma = (N - 2) / sqrt(N * (N - 1))
    return D, cn, N, sigma


def theta0(n):
    """P/|W|^3 at the balanced sphere product -- the conjectured maximum."""
    return sqrt(2.0 * (n - 1) * (n - 2)) / n


def orbit_dim_sphere_product(n):
    p, q = n // 2, n - n // 2
    return n * (n - 1) // 2 - p * (p - 1) // 2 - q * (q - 1) // 2


# ---------------------------------------------------------------
# PART 1 -- independent spot-check of the A1 trace identities
# ---------------------------------------------------------------

def LW_columnwise(W, Eflat, c):
    """L_W column by column from B(X,Y) = (Q(X+Y)-Q(X)-Q(Y))/2 evaluated with
    Q_full -- structurally independent of build_LW's congruence transform."""
    D, _ = Eflat.shape
    N = W.shape[0]
    QW = Q_full(W, c)
    L = np.zeros((D, D))
    for j in range(D):
        E = Eflat[j].reshape(N, N)
        B = 0.5 * (Q_full(W + E, c) - QW - Q_full(E, c))
        L[:, j] = Eflat @ B.reshape(-1)
    return L


def part1_trace_identities(ns=(6, 7, 8)):
    print("=" * 100)
    print("PART 1 -- independent spot-check of the A1 trace identities")
    print("=" * 100)
    for n in ns:
        Eflat, c, N, D = build_weyl_orthonormal_basis(n, verbose=False)
        idx = build_structure_constants(n)[0]
        rng = np.random.default_rng(11 + n)
        cn_c, an_c, bn_c = (n - 1) * (2 * n - 1) / 4.0, -(5 * n - 1) / 8.0, n * (n - 5) / 8.0
        pts = []
        for k in range(3):
            co = rng.normal(size=D)
            co /= np.linalg.norm(co)
            pts.append((f"random{k}", (co @ Eflat).reshape(N, N)))
        pts.append(("sphere prod", sphere_product_unit(n, c, idx, N)[0]))
        pts.append(("Fox S^4", -fox_S4_unit(n, c)))
        pts.append(("random0 x2.3", 2.3 * pts[0][1]))
        print(f"\n  n={n}  N={N}  D={D}")
        first = True
        for label, W in pts:
            L = build_LW(W, Eflat, c)
            if first:
                Lc = LW_columnwise(W, Eflat, c)
                print(f"    cross-route ||L_congruence - L_polarized|| / ||L|| = "
                      f"{np.linalg.norm(L - Lc)/np.linalg.norm(L):.2e}")
                first = False
            L2 = L @ L
            t1, t2, t3 = np.trace(L), np.trace(L2), np.trace(L2 @ L)
            nW2 = float(np.sum(W * W))
            trW3 = float(np.trace(W @ W @ W))
            sharp = float(np.sum(W * Q_full(W, c))) - trW3
            p2, p3 = cn_c * nW2, an_c * trW3 + bn_c * sharp
            print(f"    {label:<13} tr1={t1:9.1e}  tr2 rel.err={abs(t2-p2)/abs(p2):.1e}"
                  f"  tr3 rel.err={abs(t3-p3)/max(abs(p3),1e-12):.1e}")


# ---------------------------------------------------------------
# PART 2 -- ground truth: the spectrum of L_u at the known critical points
# ---------------------------------------------------------------

def off_u_spectrum(W, Eflat, c):
    """(lambda, s, mu[]) with mu the D-1 eigenvalues of L_u on u^perp."""
    N = W.shape[0]
    D = Eflat.shape[0]
    coeffs = Eflat @ W.reshape(-1)
    u = coeffs / np.linalg.norm(coeffs)
    lam = float(np.sum(W * Q_full(W, c)))
    s = float(np.trace(W @ W @ W))
    L = build_LW(W, Eflat, c)
    Pp = np.eye(D) - np.outer(u, u)
    w, V = np.linalg.eigh(Pp @ L @ Pp)
    j = int(np.argmax(np.abs(V.T @ u)))     # the projection's spurious zero
    return lam, s, np.delete(w, j), L


def part2_ground_truth(ns=(8, 10, 12)):
    print()
    print("=" * 100)
    print("PART 2 -- ground truth: spectrum of L_u at the known critical points")
    print("=" * 100)
    for n in ns:
        Eflat, c, N, D = build_weyl_orthonormal_basis(n, verbose=False)
        idx = build_structure_constants(n)[0]
        _, cn, _, _ = dims(n)
        for label, W, k0 in [("sphere product", sphere_product_unit(n, c, idx, N)[0],
                              orbit_dim_sphere_product(n)),
                             ("Fox S^4(alpha)", -fox_S4_unit(n, c), 4 * n - 14)]:
            lam, s, mu, L = off_u_spectrum(W, Eflat, c)
            cap = lam / 2.0
            at_cap = int(np.sum(np.abs(mu - cap) < 1e-8))
            M1, M2, M3 = mu.sum(), (mu ** 2).sum(), (mu ** 3).sum()
            pred3 = n * (n - 5) / 8.0 * lam - (n * n - 1) / 8.0 * s - lam ** 3
            print(f"  n={n:>3} {label:<15} lam={lam:.6f} s={s:.6f}"
                  f"  max(mu)-lam/2 = {mu.max()-cap:+.1e}"
                  f"  mult at cap = {at_cap} (orbit dim {k0})")
            print(f"        M1 {M1:+.6f} (pred {-lam:+.6f})   M2 {M2:.6f}"
                  f" (pred {cn-lam**2:.6f})   M3 {M3:+.6f} (pred {pred3:+.6f})")


# ---------------------------------------------------------------
# PART 3 -- the bounds
# ---------------------------------------------------------------

def bound_level2(n, k0):
    """PROVEN.  Cauchy-Schwarz on the D-1-k0 eigenvalues that are neither the
    lambda-eigenvalue on the u-line nor pinned at the cap lambda/2:
        lambda^2 <= 4 m' cn / ((k0+2)^2 + m'(k0+4)),   m' = D-1-k0.
    k0 = 0 recovers the plain level-2 bound lambda^2 <= cn (D-1)/D."""
    D, cn, N, _ = dims(n)
    mp = D - 1 - k0
    return sqrt(4.0 * mp * cn / ((k0 + 2) ** 2 + mp * (k0 + 4)))


def _feasible(n, lam, k0, s):
    """Level-3 necessary conditions on the free block (see report):
       R1^2 <= m' R2            (Cauchy-Schwarz)
       R3 <= (lam/2) R2         (from mu_i <= lam/2)
       R3 >= -R2^{3/2}          (from |mu_i| <= sqrt(R2), equal-weight atoms)"""
    D, cn, N, _ = dims(n)
    mp = D - 1 - k0
    R1 = -lam * (1.0 + k0 / 2.0)
    R2 = cn - lam ** 2 * (1.0 + k0 / 4.0)
    if R2 < 0 or R1 ** 2 > mp * R2 + 1e-12:
        return False
    trL3 = -(5 * n - 1) / 8.0 * s + n * (n - 5) / 8.0 * (lam - s)
    R3 = trL3 - lam ** 3 * (1.0 + k0 / 8.0)
    return not (R3 > lam / 2.0 * R2 + 1e-9 or R3 < -R2 ** 1.5 - 1e-9)


def bound_level3(n, k0, ngrid=40001, nsamp=61):
    """Largest lambda > 0 admitting some s in [-sigma_n, sigma_n]."""
    D, cn, N, sigma = dims(n)
    ss = np.linspace(-sigma, sigma, nsamp)
    grid = np.linspace(1e-6, sqrt(cn) * 1.0001, ngrid)
    ok = [any(_feasible(n, l, k0, s) for s in ss) for l in grid]
    idx = np.nonzero(ok)[0]
    return grid[idx[-1]] if len(idx) else 0.0


def part3_bounds(ns=(12, 14, 16, 20, 24, 32, 48, 64, 100, 200)):
    print()
    print("=" * 100)
    print("PART 3 -- upper bounds on lambda at a local maximum, by level and by orbit dimension k0")
    print("=" * 100)
    print(f"{'n':>4} {'theta0':>8} | {'L2 k0=0':>9} {'L3 k0=0':>9} | {'L2 k0=n^2/4':>12}"
          f" {'L3 k0=n^2/4':>12} | {'L2 k0=C(n,2)':>13} {'L3 k0=C(n,2)':>13} | {'L3 k0=n-1':>10}")
    print("-" * 100)
    for n in ns:
        D, cn, N, _ = dims(n)
        print(f"{n:>4} {theta0(n):>8.4f} | {bound_level2(n,0):>9.3f} {bound_level3(n,0):>9.3f}"
              f" | {bound_level2(n,n*n//4):>12.4f} {bound_level3(n,n*n//4):>12.4f}"
              f" | {bound_level2(n,N):>13.4f} {bound_level3(n,N):>13.4f}"
              f" | {bound_level3(n,n-1):>10.3f}")


# ---------------------------------------------------------------
# PART 4 -- the kill criterion, and the level-4 assessment
# ---------------------------------------------------------------

# tr(L_u^4) at unit norm, computed by this repo's machinery (see part2 route).
TRL4_WSTAR = {6: 4.60071, 7: 5.44254, 8: 6.31641, 9: 7.49323, 10: 8.85938,
              11: 10.46013, 12: 12.31007}
TRL4_FOX = {6: 9.59375, 7: 11.0625, 8: 12.65625, 9: 14.375, 10: 16.21875,
            11: 18.1875, 12: 20.28125}


def part4_kill_criterion(ns=(12, 13, 14, 16, 20, 30, 50, 100)):
    print()
    print("=" * 100)
    print("PART 4 -- kill criterion.  gap* = theta0(n) - sqrt(3/2) is the S^4(alpha)-to-W* gap.")
    print("          A bound settles Conjecture A only if (bound - theta0) < gap*.")
    print("=" * 100)
    print(f"{'n':>4} {'theta0':>9} {'gap*':>9} | {'best bound':>11} {'excess':>9} {'x gap*':>8}"
          f" | {'oracle L4':>10} {'excess':>9} {'x gap*':>8}")
    print("-" * 100)
    for n in ns:
        D, cn, N, _ = dims(n)
        t0, gap = theta0(n), theta0(n) - sqrt(1.5)
        b = bound_level3(n, N)                     # most favourable orbit dimension
        line = f"{n:>4} {t0:>9.5f} {gap:>9.5f} | {b:>11.4f} {b-t0:>9.4f} {(b-t0)/gap:>8.1f}"
        if n in TRL4_WSTAR and n % 2 == 0:
            k0 = orbit_dim_sphere_product(n)
            b4 = (TRL4_WSTAR[n] / (1 + k0 / 16.0)) ** 0.25
            line += f" | {b4:>10.4f} {b4-t0:>9.4f} {(b4-t0)/gap:>8.1f}"
        print(line)

    print()
    print("  Level-4 tightness at W*: tr(L^4) / [lambda^4 (1 + k0/16)] -- 1.0 would be perfectly tight")
    for n in [6, 8, 10, 12]:
        k0 = orbit_dim_sphere_product(n)
        r = TRL4_WSTAR[n] / (theta0(n) ** 4 * (1 + k0 / 16.0))
        print(f"    n={n:>3} k0={k0:>3}  tr(L^4)={TRL4_WSTAR[n]:>8.4f}   ratio={r:.4f}")
    print("  Fox S^4(alpha) carries a strictly larger tr(L^4) at every n "
          "(e.g. 20.281 vs 12.310 at n=12),")
    print("  so a theorem-grade level-4 bound must use at least that value: at n=12 it gives")
    b = (TRL4_FOX[12] / (1 + orbit_dim_sphere_product(12) / 16.0)) ** 0.25
    print(f"    bound = {b:.4f},  excess {b-theta0(12):.4f} = "
          f"{(b-theta0(12))/(theta0(12)-sqrt(1.5)):.1f} x gap*.")

    print()
    print("  Sanity filter -- no bound may exclude S^4(alpha) (P = sqrt(3/2) = 1.224745) at n <= 11:")
    for n in [6, 8, 10, 11]:
        b = bound_level3(n, 4 * n - 14)            # Fox's own orbit dimension
        print(f"    n={n:>3}: bound at Fox's k0={4*n-14:>3} is {b:.4f}  -> "
              f"{'PASSES (does not exclude)' if b >= sqrt(1.5) else 'FILTER FAILED'}")


def main():
    part1_trace_identities()
    part2_ground_truth()
    part3_bounds()
    part4_kill_criterion()


if __name__ == "__main__":
    main()
