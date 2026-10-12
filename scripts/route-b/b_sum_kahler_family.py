"""The (su(m), so(m)) family: already in the record, non-diagonal, S = 0, and CAPPED.

WHAT THIS SETTLES.  Gate 2 (Reviewer 78) reported four families outside the non-diagonal
census -- HP^2 and three it called Q_3, Q_5, Q_6 (complex quadrics).  Three of the four
are NOT new: they are the record's own "su(m) Kaehler" points, catalogued at
findings/INDEX.md's graded/Morse-Bott table, matching to nine digits:

    record su(3) Kaehler, n=6   1.095445115  ==  R78's "Q_3"
    record su(5) Kaehler, n=10  1.035098339  ==  R78's "Q_5"
    record su(6) Kaehler, n=12  1.024695077  ==  R78's "Q_6"

and the record additionally carries su(4) at n=8, theta = 1.054092553, which R78 missed.
Nobody connected them because they sit in a table about GRADEDNESS, under a different
name, while the census hunted by construction rather than by querying recorded values.
This is the third time in this programme that the record already contained the point that
refuted a claim made about it.  The lesson is the skill's own rule: query the record by
NUMBER, since prose describing an object varies while its theta does not.

THE CLOSED FORM.  Built from the symmetric pair (su(m), so(m)) on C^m = R^{2m}, so
n = 2m, with k = so(m) embedded diagonally (dim m(m-1)/2) and m-part the symmetric
traceless B (dim m(m+1)/2 - 1).  Writing T = binom(m+1, 2) = m(m+1)/2, the value is

    theta^2  =  T / (T - 1)  =  (dim m-part + 1) / (dim m-part) ,

verified EXACTLY at m = 3..8 against the operator built from the pair (residual <= 4e-16
and 0 at four of the six).

*** DERIVED, symbolically in m.  No longer pattern-matched. ***

The two-eigenvalue graded ansatz W = a.Pi_k + b.Pi_m, trace-free (a p + b q = 0) and unit
norm (a^2 p + b^2 q = 1), with p = dim k = m(m-1)/2 and q = dim m-part = m(m+1)/2 - 1.

Two of the four block masses VANISH IDENTICALLY, from the symmetric-pair relations
[k,k] in k perp m and [m,m] in k perp m:

    S_kkm = 0 ,   S_mmm = 0     (the second is why S = 0 on the whole family)

and the two survivors have closed forms, computed exactly at m = 3..7 and integer:

    S_kkk = (m-2) p             (the Killing form of so(m))
    S_kmm = m q                 (k acting on the m-part)

and BOTH ARE THEOREMS, not spot values -- Reviewers 81 and 82 independently supplied the
same argument: k = so(m) sits DIAGONALLY, so the induced metric is exactly twice so(m)'s,
which halves its Killing constant to c_k = 2(m-2)/2 = m-2, whence S_kkk = (m-2)p; then
S_kmm = cp - S_kkk = 2mp - (m-2)p = (m+2)p, and (m+2)p = mq identically.  (Commit 4a32434
called this "PROVED" while these were still spot values at m = 3..7; the closing argument
arrived later.)

Then theta = tr(W^3) + <W, W#> with <W, W#> = (1/2) sum_abc T lam lam lam
           = (1/2)[ a^3 S_kkk + 3 a b^2 S_kmm ],
and eliminating b = -a p/q and a^2 = q/(p(m^2-1)) gives EXACTLY

    theta^2 = m(m+1) / ((m-1)(m+2))  =  X/(X-2),   X = m(m+1) = 2T,

whose difference from T/(T-1) simplifies to 0 identically in m.

MONOTONICITY IS NOW IMMEDIATE: X/(X-2) is strictly decreasing in X and X is increasing in
m, so the family's maximum is at m = 3 (X = 12, theta^2 = 6/5) and theta -> 1.  No
enumeration, no sampling, and no dependence on the six spot values.

WHY IT MATTERS -- AND THE CAP ONCE CLAIMED HERE IS WRONG.  T/(T-1) is strictly decreasing
in T, hence in m, so the maximum is at the family's SMALLEST member.  This file once said
that was m = 3, giving sqrt(6/5).  It is m = 2: the construction runs verbatim there
(p = dim so(2) = 1, q = 2) and yields a genuine Weyl operator -- Ricci-flat, Bianchi,
critical, NON-DIAGONAL, S = 0 -- at theta = 1.224744871, with the closed form returning
exactly 3/2.  Gate 2 (Reviewers 81 and 82, independently).

AND THAT m = 2 MEMBER IS W_CP^2 -- identical eigenvalues (0.816497, -0.408248, -0.408248,
0, 0, 0); its k and m are span{e01+e23} and span{e02-e13, e03+e12}, a u(1) in the
self-dual su(2).  So "CP^m is not of this form" is false at exactly the member that sets
the threshold.

WHAT THAT COSTS AND WHAT IT BUYS.  It costs the cap: the family's supremum is sqrt(3/2),
ATTAINED, so this closed form can never bound the class strictly below the target.  What
it buys is better than a cap -- a STRUCTURAL statement: the conjectured equality case is
the smallest member of a natural infinite family along which theta decreases
monotonically.  The equality case stops being an isolated coincidence.

FALSIFIER: the closed form failing at any m, or a member with S != 0 or diagonal.
"""
import numpy as np, sys, io, contextlib
from fractions import Fraction as F

sys.path.insert(0, 'scripts/lib')
with contextlib.redirect_stdout(io.StringIO()):
    from review_r13_independent import Core, su_m_family
from b_circulant_band_witnesses import full_profile
from b_frame_independent_diagonality import diagonalisable

SQ32 = np.sqrt(1.5)


def theta_sq_exact(m):
    T = m * (m + 1) // 2
    return F(T, T - 1)


def main():
    print("=== the family, and the closed form theta^2 = T/(T-1), T = binom(m+1,2) ===")
    print(f"  {'m':>3s}{'n':>4s}{'T':>5s}{'exact th^2':>12s}{'theta (form)':>15s}"
          f"{'theta (built)':>15s}{'resid':>10s}{'S_mmm':>10s}{'crit':>9s}")
    worst = 0.0
    for m in (3, 4, 5, 6, 7, 8):
        n = 2 * m
        t2 = theta_sq_exact(m)
        core = Core(n)
        W = su_m_family(core, m)
        W = W / np.linalg.norm(W)
        r = full_profile(n, W)
        res = abs(float(t2) ** 0.5 - r['theta'])
        worst = max(worst, res)
        print(f"  {m:>3d}{n:>4d}{m*(m+1)//2:>5d}{str(t2):>12s}{float(t2)**0.5:>15.9f}"
              f"{r['theta']:>15.9f}{res:>10.1e}{r['S']:>10.1e}{r['info']['crit_res']:>9.1e}")
    print(f"\n  worst residual against the closed form: {worst:.1e}")

    print("\n=== diagonality: every member is non-diagonal, frame-independently ===")
    for m in (3, 4, 5, 6):
        n = 2 * m
        core = Core(n)
        W = su_m_family(core, m)
        W = W / np.linalg.norm(W)
        v, k = diagonalisable(n, W)
        print(f"  m={m}, n={n:2d}:  {v}  (dim ker Phi = {k})")

    print("\n=== the cap, in one line and with no enumeration ===")
    print("  T/(T-1) is strictly decreasing in T, hence in m, so the family's maximum is")
    print(f"  at m = 3:   sup theta = sqrt(6/5) = {np.sqrt(F(6,5).__float__()):.9f}")
    print(f"  target threshold      sqrt(3/2) = {SQ32:.9f}")
    print(f"  margin {SQ32 - np.sqrt(1.2):.6f};  theta -> 1 as m -> infinity.")
    print("\n  *** THE CAP CLAIMED HERE IS WRONG -- see the header. ***")
    print("  theta DECREASES in m, so the family's maximum is at its SMALLEST member,")
    print("  and the construction runs at m = 2: p = dim so(2) = 1, q = 2, giving a")
    print("  genuine Weyl operator -- Ricci-flat, Bianchi, critical, non-diagonal, S = 0")
    print("  -- at theta = 1.224744871, with the closed form returning exactly 3/2.")
    print("  That m = 2 member IS W_CP^2 (identical eigenvalues).  So the family's")
    print("  supremum is sqrt(3/2), ATTAINED, not sqrt(6/5) at m = 3.")


if __name__ == '__main__':
    main()
