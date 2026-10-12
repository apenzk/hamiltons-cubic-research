"""Circulant critical points: 30-odd witnesses with Delta > 0, and what they decide.

WHY.  [b_sharpened_lambda_bound.py] showed the lambda-weighted bound's discarded term is
exactly the Delta term, and that keeping it recovers all the slack at the C_5 blow-up.
But C_5 was the ONLY catalogued critical point with Delta > 0, so the size of the
improvement rested on a single witness.  This file supplies more, from a family the
record already carries rather than from a blind search: the CIRCULANT critical points on
the n-cycle, which [findings/INDEX.md]'s B1 entry records at n = 8 and Reviewer 71 re-derived
independently at Gate 2.

THE FAMILY.  Diagonal Weyl_n is {w symmetric, zero diagonal, zero row sums}, and
criticality there is the complete n x n system

    M^{o2} + M^2  =  theta M + diag(s_i) ,     s_i = sum_j M_ij^2

(recorded, verified at 1e-16).  Restricting to symmetric circulants makes every term
circulant, so the system collapses to floor(n/2) equations in the half-row, solved here
by fsolve from random starts.  Every solution is screened for Weyl-ness AND criticality
before it is used.

WHAT IS REPORTED, per point: theta, dim m, the Lemma 36 cap floor(n^2/4), the slack
S_mmm, Delta, and the two bounds -- the recorded |lam_min| M / 4 and the sharpened
(|lam_min| M - lam_p^min Delta) / 4 -- together with band membership
{S = 0, 3 <= dim m < floor(n^2/4)} and whether each bound establishes theta <= sqrt(3/2).

THE COUNTS THIS FILE PRINTS ARE A SEARCH YIELD, NOT A CENSUS.  Gate 2 (Reviewers 73/74):
with 400-4000 starts the true figures are >= 73 points, >= 61 with Delta > 0, and >= 22
in the band, against the 37 / 32 / 9 that 60 starts find.  There is a proof of
incompleteness needing no numerics: Q is QUADRATIC, so Q(-W) = Q(W) = theta W
= (-theta)(-W) and the critical locus is closed under W -> -W -- yet nine of the 37 have
no negation partner in the list.  The 60-start run also MISSES the C_5 blow-up itself,
which is a member of this family.  Raise `starts` before quoting any number here as a
count.  And note that 6 of the 9 band points have theta <= 0, where "theta <= sqrt(3/2)"
is vacuous; only three have theta > 0, the largest 0.612372.

FALSIFIER: the sharpened bound violated at any of them; or a band point where it exceeds
sqrt(3/2), which would show the sharpening still does not close the band.
"""
import numpy as np, sys, warnings
from scipy.optimize import fsolve
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index
from weyl_screen import critical_screened
from b_symmetry_defect import phis

SQ32 = np.sqrt(1.5)
TOL = 1e-9


def circ_M(n, half):
    r = np.zeros(n)
    for k in range(1, n):
        r[k] = half[min(k, n - k) - 1]
    return np.array([[r[(j - i) % n] for j in range(n)] for i in range(n)])


def crit_res(x, n):
    M = circ_M(n, x)
    nr = np.linalg.norm(M)
    if nr < 1e-9:
        return list(np.ones(len(x)))
    M = M * np.sqrt(2.0) / nr
    th = 0.5 * (np.sum(M ** 3) + np.trace(M @ M @ M))
    F = M ** 2 + M @ M - th * M - np.diag((M ** 2).sum(1))
    return [F[0, k + 1] for k in range(len(x))]


def M_to_W(n, M):
    pairs, _ = pair_index(n)
    W = np.zeros((len(pairs), len(pairs)))
    for a, (i, j) in enumerate(pairs):
        W[a, a] = M[i, j]
    return W


def full_profile(n, W):
    W = W / np.linalg.norm(W)
    th, info = critical_screened(n, W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    m, p, z = lam < -TOL, lam > TOL, np.abs(lam) <= TOL
    return dict(theta=th, info=info, d=int(m.sum()),
                S=float(T[np.ix_(m, m, m)].sum()),
                Delta=float(g[p].sum()), M=float(g[m].sum()),
                lmin=abs(float(lam.min())),
                lpmin=float(lam[p].min()) if p.any() else 0.0)


def solve_family(ns=(8, 10, 12), starts=60, seed=11):
    # starts=60 is the historical default and UNDER-COUNTS; see the header.
    rng = np.random.default_rng(seed)
    out = []
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        for n in ns:
            for _ in range(starts):
                x0 = rng.normal(size=n // 2)
                try:
                    sol = fsolve(crit_res, x0, args=(n,), xtol=1e-13)
                except Exception:
                    continue
                if max(abs(np.array(crit_res(sol, n)))) > 1e-10:
                    continue
                M = circ_M(n, sol)
                nr = np.linalg.norm(M)
                if nr < 1e-6:
                    continue
                r = full_profile(n, M_to_W(n, M * np.sqrt(2.0) / nr))
                if not (r['info']['is_weyl'] and r['info']['is_critical']):
                    continue
                key = (n, round(r['theta'], 7), round(r['Delta'], 4))
                if any(k == key for k, _ in out):
                    continue
                out.append((key, r))
    return sorted(out)


def main():
    found = solve_family()
    print(f"  {'n':>3s}{'theta':>10s}{'d':>4s}{'cap':>5s}{'S_mmm':>10s}{'Delta':>9s}"
          f"{'recorded':>10s}{'sharp':>9s}  band  old  new")
    worst = -np.inf
    band = []
    for (n, _, _), r in found:
        cap = (n * n) // 4
        old = r['lmin'] * r['M'] / 4.0
        new = (r['lmin'] * r['M'] - r['lpmin'] * r['Delta']) / 4.0
        worst = max(worst, r['theta'] - new)
        inb = (r['S'] < 1e-8) and (3 <= r['d'] < cap)
        if inb:
            band.append((n, r, old, new))
        print(f"  {n:>3d}{r['theta']:>10.6f}{r['d']:>4d}{cap:>5d}{r['S']:>10.4f}"
              f"{r['Delta']:>9.3f}{old:>10.6f}{new:>9.6f}"
              f"  {'YES ' if inb else '  . '}"
              f"{'ok ' if old <= SQ32 else 'NO '}{'ok' if new <= SQ32 else 'NO'}")
    npos = sum(1 for _, r in found if r['Delta'] > 1e-8)
    print(f"\n  {len(found)} distinct circulant critical points, {npos} with Delta > 0")
    print(f"  sharpened bound, worst theta - bound: {worst:.2e}"
          + ("  -- equality, not violation" if abs(worst) < 1e-12 else "  *** VIOLATED ***"))
    print(f"  points IN THE BAND (S = 0, 3 <= dim m < floor(n^2/4)): {len(band)}")
    print("\n  READ THIS BEFORE QUOTING THE SHARPENING.  On these witnesses the RECORDED")
    print("  bound already suffices in the band -- the sharpening's value shows OUTSIDE")
    print("  it, at theta = 0.728768 (d = 36 = cap, S = 96), where the recorded bound")
    print("  gives 1.348672 > sqrt(3/2) and proves nothing while the sharpened one gives")
    print("  1.123155 and does.  So this family does not yet demonstrate that the")
    print("  sharpening is NEEDED on the band; it demonstrates that it is real.")
    if band:
        bad_old = [x for x in band if x[2] > SQ32]
        bad_new = [x for x in band if x[3] > SQ32]
        print(f"    where the RECORDED bound fails to give theta <= sqrt(3/2): {len(bad_old)}")
        print(f"    where the SHARPENED bound fails:                          {len(bad_new)}")


if __name__ == '__main__':
    main()
