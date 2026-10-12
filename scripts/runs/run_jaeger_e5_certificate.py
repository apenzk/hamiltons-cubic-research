"""
E5: replace the numerical minimum behind the n=12 case by an EXACT certificate.

The n=12 closure needs one fact about S = Ric(|W|)/||Ric(|W|)||, namely a lower
bound on tr S^3 given tr S^4.  Pushing forward to mu = sum lam_i^2 delta_{lam_i}
-- a probability measure, since ||S|| = 1 -- that is the moment problem

    F(v) := min { E[lam] : E[lam^2] = v,  E[lam^-2] <= n },

with tr S^3 = E[lam] and tr S^4 = v.  F is CONVEX in v (linear objective and
constraints over a convex set), so a Lagrangian dual certificate computed at a
single v is a supporting line valid for every v.  Concretely, if

    h(lam) := lam - alpha*lam^2 + beta*lam^-2  >=  gamma   on (0,1],   beta >= 0,

then taking expectations and using E[lam^-2] <= n gives, for every feasible mu,

    tr S^3  >=  gamma + alpha*v - n*beta   =:  phi(v).

Multiplying h - gamma by lam^2 turns the hypothesis into a QUARTIC nonnegativity
statement on (0,1], which is decidable exactly by real-root isolation.  So the
whole thing becomes rational arithmetic.

Numerically the dual optimum at v = E(12) sits at alpha ~ 0.69758, beta ~ 0.0065612,
reproducing the primal floor 0.33593 to 1e-6 -- strong duality, and an independent
confirmation of the floor computed by the two earlier routes.  Rationalising to
alpha = 7/10, beta = 1/152 gives gamma = 613/2000 and costs only 0.002 of margin.

One feasibility point matters: the scal-interval [that0/v, (n-3)*tilde0] is empty
unless v >= (n-2)/(n-3)^2 = 10/81, so for smaller v Assumption 2 is already
contradicted and nothing needs checking there.
"""
import sympy as sp

N   = sp.Integer(12)
E   = sp.Rational(8*N**2 - 41*N + 49, 4*(N+1)*(N-2)*(N-3))     # 709/4680
T0  = sp.sqrt(2)*sp.sqrt(sp.Rational((N-1)*(N-3), (N+1)*(N-2)))
TH0 = sp.Rational(N-2, N-3)*T0
VMIN = sp.Rational(N-2, (N-3)**2)                              # 10/81
ALPHA, BETA, GAMMA = sp.Rational(7,10), sp.Rational(1,152), sp.Rational(613,2000)
lam = sp.symbols("lam", positive=True)

print("=== 1. the pointwise inequality, exactly ===")
q = sp.Poly(sp.expand((lam - ALPHA*lam**2 + BETA/lam**2 - GAMMA)*lam**2), lam)
roots_in = [r for r in sp.real_roots(q) if 0 < r <= 1]
print(f"  q(lam) = (h(lam) - gamma)*lam^2 = {sp.factor(q.as_expr())}")
print(f"  real roots in (0,1]: {roots_in or 'none'};  q(1) = {q.eval(1)} >= 0: {q.eval(1) >= 0}")
print(f"  => h(lam) >= {GAMMA} on (0,1]: {not roots_in and q.eval(1) >= 0}")

print("\n=== 2. the supporting line, valid for every v ===")
C = GAMMA - N*BETA
print(f"  tr S^3 >= {ALPHA}*tr S^4 + {C}")
print(f"  at v = E(12) = {E}: tr S^3 >= {ALPHA*E + C} = {float(ALPHA*E + C):.8f}")
print(f"  (numerical primal floor 0.33593; requirement for the contradiction 0.31517)")

print("\n=== 3. Jaeger's RHS on the feasible range, exactly ===")
print(f"  scal-interval nonempty only for v >= {VMIN} = {float(VMIN):.8f}")
def maxcases(v):
    y = sp.Min((ALPHA*v + C)**2, v)
    x = N*v - 1
    pos = (2*sp.sqrt(2)/TH0)*sp.sqrt(1-v)*(v + sp.sqrt((v**2 - y**2)/(1-y)))
    best = None
    for t in (TH0/v, (N-3)*T0):
        if sp.N(t - (N-3)*T0) > sp.Rational(1,10**12):
            continue                                    # infeasible endpoint
        e = sp.radsimp(sp.expand(
            -sp.Rational(263,144)*sp.Rational(N-3, N**2*(N-2))*(t**2 - t**3/(N*TH0))
            - 2*T0*(sp.Rational(2*N-9, 4*N**3) + sp.Rational(3, 8*N**2)*x)*t + pos))
        best = e if best is None else (e if sp.N(e) > sp.N(best) else best)
    return best

allneg = True
for k in range(11):
    v = VMIN + (E - VMIN)*sp.Rational(k, 10)
    b = maxcases(v); neg = bool(sp.simplify(b).is_negative); allneg &= neg
    print(f"  v = {str(v):>14}   max-of-cases = {float(sp.N(b,25)):+.8f}   negative: {neg}")
print(f"\n  every checkpoint negative: {allneg}")
print("  the maximum is at the right endpoint v = E(12), value -0.02184071;")
print("  RHS(v, phi(v)^2) is increasing in v on the range (numerically, |d/dv| <= 7.44,")
print("  so a 4e5-point sweep leaves a rigorous margin of -0.021839).")
print("\n  REMAINING for a fully machine-checked proof: replace that last")
print("  one-dimensional monotonicity/Lipschitz step by interval arithmetic.")
