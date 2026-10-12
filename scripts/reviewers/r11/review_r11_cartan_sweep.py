"""
Step (i) of the graded enumeration -- and a correction to how it must be run.

FIRST ATTEMPT, AND WHY IT WAS WRONG.  The dictionary of
review_r11_graded_dictionary.py solves the two criticality relations

    (R1)  c_k = [ C (2q - p) - 2 (p + q) ] / q               (m-block)
    (R2)  c_k p + 3 q C = c_h^ad (p + q)                     (Lie identity)

for C and c_k given (p, q, c_h^ad).  That is legitimate for the operators it was
checked on, but it is NOT a way to sweep symmetric pairs, because for a given
pair C and c_k are already determined by the algebra.  (R1) is then a CONSTRAINT
selecting which pairs carry a graded critical point at all -- not a definition of
C.  Solving instead of checking manufactures a "theta" for pairs that are not
critical points, and the numbers give it away: the first run of this sweep
returned theta up to 51.3, against the hard ceiling sqrt(2), and missed HP^2 by
1.5e-2 (its k = so(3)+so(5) is non-simple with inequivalent ideals, so W is not
scalar on E+ and the two-eigenvalue form does not apply there either).

WHAT THIS SCRIPT DOES INSTEAD.  It applies the necessary conditions that any
genuine two-eigenvalue graded critical point must satisfy, and reports only the
pairs that survive:

    (N1)  k acts on m with a single Casimir -- k simple, or a sum of ideals
          interchanged by a symmetry of the pair (otherwise the ideal-wise
          system of review_r11_graded_ideals.py is required)
    (N2)  2q - p > 0            (else the normalisation W = (q Pi_k - p Pi_m)
                                 has the wrong sign structure)
    (N3)  0 < theta <= sqrt(2)  (the ceiling every sphere family approaches)
    (N4)  c_k >= 0 and C > 0    (Casimirs of a compact algebra)

Surviving pairs are candidates, to be confirmed by explicit construction; pairs
failing (N2)-(N4) are excluded outright.  This is a screen, not a proof.
"""
import numpy as np

SQ32, SQ2 = np.sqrt(1.5), np.sqrt(2.0)


def solve(p, q, n, ratio):
    """Returns (C, c_k, theta) from the two relations, or None if degenerate."""
    if p <= 0 or q <= 0:
        return None
    dim_h = p + q
    ch = (2.0 * dim_h / n) * ratio
    den = 2 * p * q - p * p + 3 * q * q
    if den == 0 or 2 * q - p == 0:
        return None
    C = dim_h * (q * ch + 2 * p) / den
    ck = (C * (2 * q - p) - 2 * dim_h) / q
    th = (ck * q * q + 2 * q * q + p * p) / ((2 * q - p) * np.sqrt(p * q * dim_h))
    return C, ck, th


def so_dim(k):
    return k * (k - 1) // 2


# (label, p, q, n, C2(adj)/C2(V), single_casimir?)
cand = []

for N in range(4, 41):                      # h = so(N) on R^N
    n, dh, r = N, so_dim(N), (2 * N - 4) / (N - 1)
    for j in range(1, N // 2 + 1):
        p, q = so_dim(j) + so_dim(N - j), N * 0 + j * (N - j)
        # single Casimir iff one factor is trivial (k simple) or the two are swapped
        single = (j <= 1) or (j == N - j)
        cand.append((f"(so({N}), so({j})+so({N-j})) on R^{N}"
                     + (" [balanced sphere pair]" if j == N - j else ""), p, q, n, r, single))
    if N % 2 == 0:                          # k = u(N/2) = su(N/2)+u(1): single only if N<=4
        p = (N // 2) ** 2
        cand.append((f"(so({N}), u({N//2})) on R^{N}", p, dh - p, n, r, N <= 4))

for m in range(2, 21):                      # h = su(m) on C^m
    n, dh, r = 2 * m, m * m - 1, 2 * m * m / (m * m - 1)
    p = m * (m - 1) // 2
    cand.append((f"(su({m}), so({m})) on C^{m}", p, dh - p, n, r, True))
    if m % 2 == 0:
        p = (m // 2) * (m + 1)
        cand.append((f"(su({m}), sp({m//2})) on C^{m}", p, dh - p, n, r, True))
    for j in range(1, m // 2 + 1):          # s(u(j)+u(m-j)); single only when it is u(1)
        p = j * j + (m - j) ** 2 - 1
        cand.append((f"(su({m}), s(u({j})+u({m-j}))) on C^{m}", p, dh - p, n, r,
                     (m == 2 and j == 1)))

for m in range(1, 13):                      # h = sp(m) on H^m
    n, dh, r = 4 * m, m * (2 * m + 1), 4 * (m + 1) / (2 * m + 1)
    p = m * m
    cand.append((f"(sp({m}), u({m})) on H^{m}", p, dh - p, n, r, m <= 1))
    for j in range(1, m // 2 + 1):
        p = j * (2 * j + 1) + (m - j) * (2 * (m - j) + 1)
        cand.append((f"(sp({m}), sp({j})+sp({m-j})) on H^{m}", p, dh - p, n, r, j == m - j))

# ---- gate on the operators actually built ----
GATE = {"(su(2), s(u(1)+u(1))) on C^2": SQ32,
        "(su(3), so(3)) on C^3": 1.095445115,
        "(so(12), so(6)+so(6)) on R^12 [balanced sphere pair]": 1.236033081}
print("gate (single-Casimir pairs whose operators exist in the repo):")
ok = True
for label, p, q, n, r, single in cand:
    if label in GATE:
        res = solve(p, q, n, r)
        d = abs(res[2] - GATE[label])
        ok &= d < 2e-9 and single
        print(f"   {label:<54} theta={res[2]:.9f} |d|={d:.1e} single={single}")
print(f"   gate {'PASSED' if ok else 'FAILED'}")
print("   (HP^2 is deliberately absent: its k = so(3)+so(5) has inequivalent ideals,\n"
      "    so it needs the ideal-wise system, not this two-eigenvalue formula.)\n")

kept, rejected = [], {"non-single k": 0, "2q<=p": 0, "theta range": 0, "Casimir sign": 0}
for label, p, q, n, r, single in cand:
    if not single:
        rejected["non-single k"] += 1
        continue
    if 2 * q - p <= 0:
        rejected["2q<=p"] += 1
        continue
    res = solve(p, q, n, r)
    if res is None:
        continue
    C, ck, th = res
    if not (0 < th <= SQ2 + 1e-12):
        rejected["theta range"] += 1
        continue
    if ck < -1e-12 or C <= 0:
        rejected["Casimir sign"] += 1
        continue
    kept.append((th, label, p, q, n, C, ck))

print(f"screened {len(cand)} pairs -> {len(kept)} survive all necessary conditions")
for k, v in rejected.items():
    print(f"   rejected, {k:<14}: {v}")

kept.sort(key=lambda t: -t[0])
print(f"\n{'theta':>12} {'p':>5} {'q':>5} {'n':>4} {'C':>7} {'c_k':>7}  pair")
print("-" * 100)
for th, label, p, q, n, C, ck in kept:
    mark = "  <-- ABOVE sqrt(3/2)" if th > SQ32 + 1e-12 else ""
    print(f"{th:>12.9f} {p:>5} {q:>5} {n:>4} {C:>7.3f} {ck:>7.3f}  {label}{mark}")

above = [t for t in kept if t[0] > SQ32 + 1e-12]
nonsphere = [t for t in above if "balanced sphere pair" not in t[1]]
print(f"\nabove sqrt(3/2): {len(above)}   of which not the balanced sphere pair: {len(nonsphere)}")
for th, label, p, q, n, C, ck in nonsphere:
    print(f"   {th:.9f}  {label}")
