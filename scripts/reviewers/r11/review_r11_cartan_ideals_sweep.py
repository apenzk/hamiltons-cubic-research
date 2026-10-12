"""
Step (ii): the non-single-Casimir pairs, which the two-eigenvalue screen had to
reject.  The largest such class is A' = (so(N), so(j)+so(N-j)) with j != N-j,
and for it every per-ideal constant is available in closed form, so the
ideal-wise system can be solved rather than screened.

Closed forms, in the so(n)-induced normalisation (coordinate 2-planes
orthonormal, so the standard embedding of so(j) inherits its own standard
normalisation):

    p_i  = dim so(j_i) = j_i (j_i - 1) / 2        q = j (N - j)
    c_i  = adjoint Casimir of so(j_i)   = 2 (j_i - 2)
    C_i  = Casimir of so(j_i) on m = R^j (x) R^{N-j}, i.e. (N - j_i) copies of
           the vector representation, so C_i = j_i - 1
           (both from the trace identity sum_a tr_V(e_a^2) = -2 dim g)

Checked against HP^2 = (so(8), so(3)+so(5)), where the brackets were measured
directly in review_r11_graded_ideals.py: (p, C, c) = (3, 2, 2) and (10, 4, 6).
The closed forms give exactly those.

The ideal-wise system (r ideals, b > 0 the m-eigenvalue, a_i the k_i-eigenvalues):

    m-block :   sum_i a_i C_i - b = theta
    k_i-block:  a_i (1 + c_i/2) + (q C_i / (2 p_i)) b^2 / a_i = theta
    trace    :  sum_i p_i a_i = q b
    norm     :  sum_i p_i a_i^2 + q b^2 = 1

is one equation richer than it has unknowns, so consistency is a CONSTRAINT
selecting which pairs actually carry a graded critical point -- the same lesson
that corrected the two-eigenvalue sweep.  Here that constraint is solved for
honestly: fix b = 1, solve the r k-equations and the trace equation for
(a_1..a_r, theta), then test the m-equation as the residual.
"""
import numpy as np
from scipy.optimize import fsolve

SQ32, SQ2 = np.sqrt(1.5), np.sqrt(2.0)


def system(N, j):
    """(p_i, C_i, c_i) for the two ideals, and q."""
    js = [j, N - j]
    p = [x * (x - 1) / 2 for x in js]
    C = [x - 1.0 for x in js]
    c = [2.0 * (x - 2) for x in js]
    q = j * (N - j)
    return p, C, c, q


def solve_pair(N, j):
    p, C, c, q = system(N, j)
    if min(p) <= 0:
        return None                       # so(1) is trivial: handled by the simple sweep

    def eqs(z):
        a1, a2, th = z
        a = [a1, a2]
        out = [a[i] * (1 + c[i] / 2) + (q * C[i] / (2 * p[i])) / a[i] - th for i in (0, 1)]
        out.append(p[0] * a[0] + p[1] * a[1] - q)          # trace, with b = 1
        return out

    best = None
    for s in (0.5, 1.0, 2.0, 4.0):
        try:
            z, info, ier, _ = fsolve(eqs, [s, s, 2 * s], full_output=True)
        except Exception:
            continue
        if ier != 1:
            continue
        a1, a2, th = z
        if a1 <= 0 or a2 <= 0:
            continue
        resid_m = abs(a1 * C[0] + a2 * C[1] - 1.0 - th)     # m-equation, b = 1
        scale = np.sqrt(p[0] * a1 ** 2 + p[1] * a2 ** 2 + q)  # norm of the unscaled W
        theta = th / scale
        if best is None or resid_m < best[0]:
            best = (resid_m, theta, a1 / scale, a2 / scale, 1.0 / scale)
    return best


print("gate: HP^2 = (so(8), so(3)+so(5)) -- closed forms vs brackets measured earlier")
p, C, c, q = system(8, 3)
print(f"   p={p}  C={C}  c={c}  q={q}     measured: p=[3,10] C=[2,4] c=[2,6] q=15")
res = solve_pair(8, 3)
print(f"   solved theta={res[1]:.9f}   true 1.115546702   |d|={abs(res[1]-1.115546702):.1e}"
      f"   m-eqn residual={res[0]:.1e}\n")

rows = []
for N in range(4, 41):
    for j in range(2, N // 2 + 1):
        if j == N - j:
            continue                       # balanced: covered by the simple sweep
        r = solve_pair(N, j)
        if r is None:
            continue
        resid, th, a1, a2, b = r
        rows.append((resid, th, N, j))

consistent = [x for x in rows if x[0] < 1e-9]
print(f"swept {len(rows)} unbalanced pairs (so(N), so(j)+so(N-j)), N<=40")
print(f"   consistent (m-equation satisfied, i.e. genuine graded critical points): {len(consistent)}")
print(f"   inconsistent (no graded critical point of this shape): {len(rows)-len(consistent)}\n")

consistent.sort(key=lambda t: -t[1])
print(f"{'theta':>12} {'N':>4} {'j':>4}   pair")
print("-" * 60)
for resid, th, N, j in consistent[:25]:
    mark = "  <-- ABOVE sqrt(3/2)" if th > SQ32 + 1e-12 else ""
    print(f"{th:>12.9f} {N:>4} {j:>4}   (so({N}), so({j})+so({N-j})){mark}")
if len(consistent) > 25:
    print(f"... {len(consistent)-25} more, all smaller")

above = [x for x in consistent if x[1] > SQ32 + 1e-12]
print(f"\nabove sqrt(3/2) among unbalanced so-pairs: {len(above)}")
for resid, th, N, j in above:
    print(f"   {th:.9f}   (so({N}), so({j})+so({N-j}))")
if not above:
    print("   none -- every unbalanced so(j)+so(N-j) pair sits at or below sqrt(3/2)")
