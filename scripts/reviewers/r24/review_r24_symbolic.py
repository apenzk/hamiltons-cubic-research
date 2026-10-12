"""Reviewer 24 phase 4: the symbolic half.

  * CLAIM 1's theta^2 and S, re-derived from the vertex system rather than
    quoted, with symbolic block sizes at k = 2, 3, 4.
  * CLAIM 4's perturbation: the t^2 coefficient of theta^2 for GENERAL m and
    GENERAL epsilon with sum eps = 0, plus the exact convexity statement that
    settles every direction at once.
  * CLAIM 5's theta^2 and S for (2,...,2,N).
  * J_5 >= 0 on the whole family: F = A1^2 - 2 C2 >= 0, with the equality case.
"""
import sympy as sp

print("=" * 78)
print("PART H: the vertex point and theta^2, symbolically, from the equations")
print("=" * 78)
for k in (2, 3, 4):
    ns = sp.symbols(f'n1:{k+1}', positive=True)
    n = sum(ns)
    th = sp.Symbol('theta', positive=True)
    c = -th / (n - 1)
    w = sp.zeros(k, k)
    for a in range(k):
        for b in range(k):
            w[a, b] = c
    for a in range(k):
        w[a, a] = th * (n - ns[a]) / ((n - 1) * (ns[a] - 1))
    # Weyl row sums
    rows = [sp.simplify((ns[a] - 1) * w[a, a]
                        + sum(ns[b] * w[a, b] for b in range(k) if b != a))
            for a in range(k)]
    # criticality
    crit = []
    for a in range(k):
        for b in range(a, k):
            s = w[a, b] ** 2
            for d in range(k):
                cnt = ns[d] - (1 if d == a else 0) - (1 if d == b else 0)
                s += cnt * w[a, d] * w[b, d]
            crit.append(sp.simplify(s - th * w[a, b]))
    nrm = sum(ns[a] * (ns[a] - 1) / 2 * w[a, a] ** 2 for a in range(k)) \
        + sum(ns[a] * ns[b] * w[a, b] ** 2 for a in range(k) for b in range(a + 1, k))
    t2 = sp.simplify(sp.solve(sp.Eq(sp.simplify(nrm), 1), th ** 2)[0]) \
        if False else sp.simplify(1 / sp.simplify(sp.expand(nrm / th ** 2)))
    D_claim = (k - 1) * n ** 2 + sum((n - a) ** 2 / (a - 1) for a in ns)
    t2_claim = 2 * (n - 1) ** 2 / D_claim
    print(f"  k={k}: Weyl rows all zero: {all(r == 0 for r in rows)};  "
          f"criticality all zero: {all(sp.simplify(e) == 0 for e in crit)}")
    print(f"       theta^2 - CLAIM1 formula = {sp.simplify(t2 - t2_claim)}")
    # slack
    mu = th / (n - 1)
    A2 = sum(ns[a] * (n - ns[a]) ** 2 for a in ns.__class__(ns) and range(k))
    e2s = sum(ns[a] * ns[b] for a in range(k) for b in range(a + 1, k))
    S = sp.simplify(mu ** 2 * A2 - th * mu * e2s - mu ** 2 * e2s)
    e3 = sum(ns[a] * ns[b] * ns[cc] for a in range(k) for b in range(a + 1, k)
             for cc in range(b + 1, k))
    print(f"       S - 3 theta^2 e_3/(n-1)^2 = "
          f"{sp.simplify(S - 3*th**2*e3/(n-1)**2)}   (e_3 = {sp.expand(e3)})")

print()
print("=" * 78)
print("PART I: CLAIM 4 -- the t^2 coefficient for GENERAL m and GENERAL eps")
print("=" * 78)
m, t = sp.symbols('m t', positive=True)
k = 3
eps = sp.symbols('e1 e2 e3')
n = k * m                                     # sum n_a is fixed under sum eps = 0
blocks = [m * (1 + t * eps[i]) for i in range(k)]
D = (k - 1) * n ** 2 + sum((n - b) ** 2 / (b - 1) for b in blocks)
th2 = 2 * (n - 1) ** 2 / D
th2 = th2.subs(eps[2], -eps[0] - eps[1])
ser = sp.series(th2, t, 0, 3).removeO()
c0 = sp.simplify(ser.coeff(t, 0))
c1 = sp.simplify(ser.coeff(t, 1))
c2 = sp.simplify(sp.factor(sp.simplify(ser.coeff(t, 2))))
print(f"  theta^2(t=0) = {sp.simplify(c0)}")
print(f"  t^1 coefficient = {c1}")
print(f"  t^2 coefficient = {c2}")
sub = {m: 8, eps[0]: 1, eps[1]: -1}
print(f"  at m=8, eps=(1,-1,0): {sp.nsimplify(c2.subs(sub))} = "
      f"{float(c2.subs(sub)):.9f}   (FINDINGS: -529/4032 = {-529/4032:.9f})")
q = sp.simplify(sp.expand(c2 / (eps[0]**2 + eps[0]*eps[1] + eps[1]**2)))
print(f"  t^2 coefficient / (e1^2+e1 e2+e2^2) = {sp.simplify(q)}")
print(f"    e1^2+e1 e2+e2^2 > 0 for (e1,e2) != 0, so the sign is the sign of that")
print(f"    factor: at m>1 it is {sp.simplify(sp.sign(q.subs(m, 8)))} (m=8), "
      f"{sp.simplify(sp.sign(q.subs(m, 2)))} (m=2), "
      f"{sp.simplify(sp.sign(q.subs(m, sp.Rational(3,2))))} (m=3/2)")

print()
print("  the exact statement, valid for every k and every direction:")
x = sp.Symbol('x')
f = (sp.Symbol('N') - 1) ** 2 / (x - 1) + x - 1
print(f"    D = (k-1)n^2 + sum_a [(n-1)^2/(n_a-1) + n_a - 1] - 2k(n-1)")
nn, na = sp.symbols('n n_a', positive=True)
lhs = sp.simplify((nn - na) ** 2 / (na - 1) - ((nn - 1) ** 2 / (na - 1) + na - 1 - 2 * (nn - 1)))
print(f"    identity check: (n-n_a)^2/(n_a-1) - [(n-1)^2/(n_a-1)+n_a-1-2(n-1)] = {lhs}")
print(f"    d^2/dn_a^2 of (n-1)^2/(n_a-1) = "
      f"{sp.simplify(sp.diff((nn-1)**2/(na-1), na, 2))} > 0 for n_a > 1")
print("    => D is STRICTLY CONVEX in (n_1..n_k) on the simplex sum n_a = n,")
print("       symmetric, hence uniquely minimised at n_a = n/k; theta^2 = 2(n-1)^2/D")
print("       is therefore GLOBALLY maximised at balanced blocks, for every k, n.")

print()
print("=" * 78)
print("PART J: CLAIM 5 -- the (2,...,2,N) family")
print("=" * 78)
N, j = sp.symbols('N j', positive=True)
nn = 2 * j + N
D5 = j * nn ** 2 + (nn - 1) ** 2 * (j / (2 - 1) + 1 / (N - 1)) \
    - 0  # assembled directly below instead
D5 = (j + 1 - 1) * nn ** 2 + j * (nn - 2) ** 2 / (2 - 1) + (nn - N) ** 2 / (N - 1)
th2_5 = sp.simplify(2 * (nn - 1) ** 2 / D5)
claim5 = (N ** 2 + 2 * N * j - 2 * N - 2 * j + 1) / (j * (N ** 2 + 2 * N * j - 2 * N - 2 * j + 2))
print(f"  theta^2 (from CLAIM 1's formula) = {sp.simplify(th2_5)}")
print(f"  theta^2 - CLAIM 5's expression   = {sp.simplify(th2_5 - claim5)}")
print(f"  limit N -> oo : {sp.limit(th2_5, N, sp.oo)}")
print(f"  limit j -> oo : {sp.limit(th2_5, j, sp.oo)}")
e3_5 = sp.binomial(j, 3) * 8 + sp.binomial(j, 2) * 4 * N
S5 = sp.simplify(3 * th2_5 * e3_5 / (nn - 1) ** 2)
claimS = 2 * (N - 1) * (j - 1) * (3 * N + 2 * j - 4) / ((N + 2 * j - 1) * (N ** 2 + 2 * N * j - 2 * N - 2 * j + 2))
print(f"  S - CLAIM 5's expression = {sp.simplify(sp.expand(S5 - claimS))}")
print(f"  limit of S, N -> oo : {sp.limit(S5, N, sp.oo)}")
print(f"  limit of S, j -> oo : {sp.limit(S5, j, sp.oo)}")

print()
print("=" * 78)
print("PART K: J_5 >= 0 on the whole family -- F = A1^2 - 2 C2")
print("=" * 78)
for k in (2, 3, 4):
    ns = sp.symbols(f'b1:{k+1}', positive=True)
    n = sum(ns)
    A1 = sum(a * (n - a) for a in ns)
    C2 = sum(a ** 2 * (n - a) ** 2 for a in ns)
    e2s = sum(ns[a] * ns[b] for a in range(k) for b in range(a + 1, k))
    F = sp.factor(sp.expand(A1 ** 2 - 2 * C2))
    print(f"  k={k}: A1 - 2 e_2 = {sp.simplify(A1 - 2*e2s)};  F = A1^2-2C2 = {F}")
print("  general argument: x_a := n_a(n-n_a) = sum_{b!=a} n_a n_b, so")
print("    sum_a x_a = 2 e_2  and  x_a <= e_2 for every a (e_2 = x_a + sum of")
print("    the remaining nonnegative products).  Hence")
print("      sum_a x_a^2 <= (max_a x_a) sum_a x_a <= e_2 * 2 e_2 = 2 e_2^2,")
print("      F = (sum x_a)^2 - 2 sum x_a^2 = 4 e_2^2 - 2 sum x_a^2 >= 0,")
print("    with equality iff exactly two x_a are nonzero and equal, i.e. k = 2.")
