"""
The k = 3 vertex system with symbolic block sizes.

J_5 > 0 is proven on the balanced diagonal.  Off it the vertex values w[a,b]
enter RHS, so closing general k = 3 needs the vertex system solved with n_1, n_2,
n_3 as symbols rather than numbers.

The system, for blocks of sizes n_1, n_2, n_3 and a diagonal operator with entry
w[a,b] on 2-planes joining blocks a and b:

  Weyl condition, one per block a:
      (n_a - 1) w[a,a] + sum_{b != a} n_b w[a,b] = 0
  criticality, one per pair class (a,b):
      w[a,b]^2 + sum_c (n_c - [c=a] - [c=b]) w[a,c] w[b,c] = theta w[a,b]

That is six equations in the six unknowns w[a,b] plus theta, with the overall
scale fixed by unit norm.  Solving it symbolically gives w and theta as functions
of the block sizes, and substituting into the closed-form RHS leaves
RHS - theta as a rational function whose positivity on n_a >= 2 is the statement
to prove.

Solved here with the Weyl conditions used to eliminate the diagonal entries
first, which reduces the system before Groebner work begins -- the direct solve
is what makes this expensive.
"""
import sympy as sp

n1, n2, n3, th = sp.symbols('n_1 n_2 n_3 theta', positive=True)
m = sp.Symbol('m', positive=True)
w11, w22, w33, w12, w13, w23 = sp.symbols('w11 w22 w33 w12 w13 w23', real=True)
blocks = [n1, n2, n3]
W = {(0, 0): w11, (1, 1): w22, (2, 2): w33,
     (0, 1): w12, (0, 2): w13, (1, 2): w23}


def wv(a, b):
    return W[(min(a, b), max(a, b))]


# Weyl conditions: eliminate the diagonal entries
weyl = []
for a in range(3):
    weyl.append(sp.Eq((blocks[a] - 1) * wv(a, a)
                      + sum(blocks[b] * wv(a, b) for b in range(3) if b != a), 0))
sol_diag = sp.solve(weyl, [w11, w22, w33], dict=True)
print("Weyl conditions solved for the diagonal entries:")
if sol_diag:
    for kk, vv in sol_diag[0].items():
        print(f"   {kk} = {sp.simplify(vv)}")
sub = sol_diag[0] if sol_diag else {}

# criticality on the off-diagonal classes, after substitution
crit = []
for (a, b) in [(0, 1), (0, 2), (1, 2)]:
    s = 0
    for cc in range(3):
        cnt = blocks[cc] - (1 if cc == a else 0) - (1 if cc == b else 0)
        s += cnt * wv(a, cc) * wv(b, cc)
    crit.append(sp.expand((wv(a, b)**2 + s - th * wv(a, b)).subs(sub)))

print("\nthree criticality equations in w12, w13, w23, theta")
print("attempting the symbolic solve (this is the expensive step)...", flush=True)
try:
    sols = sp.solve(crit, [w12, w13, w23], dict=True)
    print(f"   {len(sols)} branch(es) found")
    # the genuine three-block point has every off-diagonal entry nonzero;
    # branches with a vanishing w reduce to a coarser partition
    live = [S for S in sols if all(sp.simplify(S.get(v, v)) != 0 for v in (w12, w13, w23))]
    print(f"   {len(live)} with all three off-diagonal entries nonzero")
    for i, S in enumerate(live):
        print(f"\n   --- branch {i} ---")
        for kk in (w12, w13, w23):
            print(f"   {kk} = {sp.simplify(S[kk])}")
        # balanced specialisation, as a check against the known theta
        bal = {n1: m, n2: m, n3: m}
        vals = {kk: sp.simplify(S[kk].subs(bal)) for kk in (w12, w13, w23)}
        print(f"   balanced: " + ", ".join(f"{kk}={vv}" for kk, vv in vals.items()))
except Exception as e:
    print(f"   direct solve did not return: {e}")
    print("   falling back to the balanced-perturbation route below")

# balanced perturbation, done properly: expand jointly to second order
print("\n=== perturbation off the balanced diagonal ===")
e1, e2 = sp.symbols('epsilon_1 epsilon_2', real=True)
subs_pert = {n1: m * (1 + e1), n2: m * (1 + e2), n3: m * (1 - e1 - e2)}
n = n1 + n2 + n3
den = 2 * n**2 + sum((n - x)**2 / (x - 1) for x in blocks)
theta2 = sp.simplify(2 * (n - 1)**2 / den)
t2p = sp.simplify(theta2.subs(subs_pert))
t = sp.Symbol('t', real=True)
line = sp.simplify(t2p.subs({e1: t * e1, e2: t * e2}))
ser = sp.simplify(sp.series(line, t, 0, 3).removeO())
print("theta^2 along n_a = m(1 + t eps_a), to second order in t:")
print("   ", sp.simplify(sp.expand(ser)))
quad = sp.simplify(sp.expand(ser).coeff(t, 2))
print("\n   coefficient of t^2 :", sp.simplify(quad))
print("   sign at m=8, eps=(1,-1):", sp.simplify(quad.subs({m: 8, e1: 1, e2: -1})))
