"""r241 / claim 3, part 2: the denominator that IS root-free, and the theorem
that makes Sturm unnecessary for it.

Part 1 (c3_casimir_differences.py) showed 204 of the 2485 block pairs have EVERY
one of the six invariant-differences vanishing somewhere in [12, oo), so no
single-Casimir Lagrange denominator survives the interval.

The repair.  For a pair (lambda, mu) let g = gcd(D_1, ..., D_6) in Q[n].
Bezout gives u_k in Q[n] with sum_k u_k D_k = g, so
    Z = sum_k u_k(n) (C^(2k) - c_j^(2k))
is a central element, n-rational, vanishing on block mu and equal to g(n) on
block lambda.  The projector's denominator is then g, not any single D_k.

THEOREM (no Sturm needed).  g has no real root in [12, oo).
Proof.  g(n0) = 0 with n0 real forces every D_k(n0) = 0, i.e. p_k(x) = p_k(y)
for k = 1..6 with x_i = l_i(lambda; n0)^2, y_i = l_i(mu; n0)^2, i = 1..6.
Newton in characteristic zero turns six power sums of six quantities into six
elementary symmetric functions, so the multisets {x_i} and {y_i} coincide.
For real n0 >= 12 and i <= 6, l_i = lambda_i + n0/2 - i >= lambda_6 + n0/2 - 6 >= 0
and l_i - l_{i+1} = (lambda_i - lambda_{i+1}) + 1 >= 1, so both l-vectors are
nonnegative and strictly decreasing; equal multisets of squares therefore force
l(lambda) = l(mu) entrywise, hence lambda = mu.  QED

This script CHECKS the theorem by exact Sturm counting on every gcd, which is an
independent route to the same statement.
"""
import pickle, itertools, time
import sympy as sp

n = sp.symbols('n')
blocks_so = pickle.load(open('scripts/runs/n12_sym3_blocks.pkl', 'rb'))
o_labels = sorted({tuple(list(l[:5]) + [abs(l[5])]) for l in blocks_so}, reverse=True)
assert len(o_labels) == 71

def ell(lam):
    return [sp.Integer(lam[i]) + sp.Rational(1, 2)*n - (i+1) for i in range(6)]
ELL = {lam: ell(lam) for lam in o_labels}

def diffs(lam, mu):
    a, b = ELL[lam], ELL[mu]
    return [sp.Poly(sp.expand(sum(a[i]**(2*k) - b[i]**(2*k) for i in range(6))), n)
            for k in range(1, 7)]

pairs = list(itertools.combinations(o_labels, 2))
t0 = time.time()
bad_gcd, degs = [], {}
worst = None
for lam, mu in pairs:
    D = diffs(lam, mu)
    g = D[0]
    for p in D[1:]:
        g = sp.gcd(g, p)
    g = sp.Poly(g, n)
    degs[g.degree()] = degs.get(g.degree(), 0) + 1
    if g.degree() >= 1 and g.count_roots(12, sp.oo) > 0:
        bad_gcd.append((lam, mu, g))
print(f"gcd(D_1..D_6) computed for all {len(pairs)} pairs in {time.time()-t0:.1f}s")
print("  degree histogram of the gcd:", dict(sorted(degs.items())))
print(f"  gcds with a real root in [12, oo): {len(bad_gcd)}   <-- theorem says 0")
for lam, mu, g in bad_gcd[:5]:
    print("   ", lam, mu, sp.factor(g.as_expr()))

# the sum-of-squares denominator, as a cross-check on the same theorem
t0 = time.time()
bad_sos = []
for lam, mu in pairs[:300]:
    D = diffs(lam, mu)
    S = sp.Poly(sum(p.as_expr()**2 for p in D), n)
    if S.count_roots(12, sp.oo) > 0:
        bad_sos.append((lam, mu))
print(f"\nsum_k D_k^2 checked on 300 pairs in {time.time()-t0:.1f}s: "
      f"{len(bad_sos)} with a root in [12, oo)   <-- theorem says 0")

# the headline witness, verified from the plain c_2 formula
def c2(lam, nv):
    return sum(lam[k]*(lam[k] + nv - 2*(k+1)) for k in range(6))
A, B = (6, 4, 0, 0, 0, 0), (6, 2, 2, 2, 0, 0)
print(f"\nwitness at the BASE dimension: c_2({A}, 12) = {c2(A,12)}, "
      f"c_2({B}, 12) = {c2(B,12)}  -> equal, so prod (C_2 - c_j)/(c_i - c_j) "
      f"divides by zero at n = 12 itself.")
