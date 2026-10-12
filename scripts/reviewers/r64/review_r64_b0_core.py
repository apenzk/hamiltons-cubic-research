"""R64: independent re-derivation of the residual one-variable inequality F(A) <= sqrt(3/2).

Written from the statement of the claim alone.  Covers S1 (closed form of psi*),
S2 (the low band), S4 (the endpoint expansion, symbolically) and S5 (coverage and
monotonicity).  The middle band and the interval-arithmetic verdict live in
review_r64_b0_interval.py.
"""
import mpmath as mp
import sympy as sp

mp.mp.dps = 40

A0 = mp.sqrt(mp.mpf(2) / 3)
K0 = 3 / (2 * mp.sqrt(2))
GAMMA = 1 - 3 * K0
TARGET = mp.sqrt(mp.mpf(3) / 2)


def g(A):
    return A**3 - (1 - A**2) ** mp.mpf(1.5) / mp.sqrt(2) + 3 * A * (1 - A**2)


def alpha(A):
    return K0 * (2 - 3 * A**2)


def beta(A):
    return mp.mpf(3) / 4 * mp.sqrt(2 - 2 * A**2) - 3 * A


def Tcap(A):
    return 2 * mp.sqrt(2) / 3 * A


def psi(A, t):
    return alpha(A) * t + beta(A) * t**2 + GAMMA * t**3


def t_c(A):
    b, a = beta(A), alpha(A)
    D = b**2 - 3 * GAMMA * a
    return (-b - mp.sqrt(D)) / (3 * GAMMA)


def t_star(A):
    return min(t_c(A), Tcap(A))


def F(A):
    return g(A) + psi(A, t_star(A))


def psi_star_bruteforce(A, n=200):
    """max over [0,T] found without using the closed form: dense scan + local polish."""
    T = Tcap(A)
    best = mp.mpf(0)
    bt = mp.mpf(0)
    for i in range(n + 1):
        t = T * i / n
        v = psi(A, t)
        if v > best:
            best, bt = v, t
    lo, hi = max(mp.mpf(0), bt - T / n), min(T, bt + T / n)
    for _ in range(200):  # golden-section on a unimodal function
        m1 = lo + (hi - lo) * mp.mpf(0.382)
        m2 = lo + (hi - lo) * mp.mpf(0.618)
        if psi(A, m1) < psi(A, m2):
            lo = m1
        else:
            hi = m2
    return max(best, psi(A, (lo + hi) / 2))


def sec(t):
    print("\n" + "=" * 78 + "\n" + t + "\n" + "=" * 78)


# ----------------------------------------------------------------- S1
sec("S1  closed form of psi*")
print(f"gamma = 1 - 3*K0 = {GAMMA}   (negative: {GAMMA < 0})")

# (i) alpha >= 0 on (0,A0], with a single zero at A0 -- symbolic
As = sp.Symbol("A", positive=True)
K0s = sp.Rational(3, 2) / sp.sqrt(2)
alpha_s = K0s * (2 - 3 * As**2)
print("alpha(A) = 0  <=>  A^2 =", sp.solve(sp.Eq(alpha_s, 0), As**2), " (A0^2 = 2/3)")

# (ii) discriminant.  D = beta^2 - 3*gamma*alpha, gamma<0, alpha>=0 => -3*gamma*alpha >= 0
worst_D = None
for i in range(1, 6001):
    A = A0 * i / 6000
    D = beta(A) ** 2 - 3 * GAMMA * alpha(A)
    if worst_D is None or D < worst_D:
        worst_D, worst_A = D, A
print(f"min discriminant on a 6000-point grid: {mp.nstr(worst_D,8)} at A={mp.nstr(worst_A,8)}")
print("  (D = beta^2 + 3|gamma|alpha is a sum of two nonnegative terms -- structurally >= 0)")

# (iii) t_c is the nonnegative root; the other root is <= 0
bad_root = bad_sign = bad_zero = 0
for i in range(1, 4001):
    A = A0 * i / 4000
    b, a = beta(A), alpha(A)
    D = b**2 - 3 * GAMMA * a
    r_minus = (-b - mp.sqrt(D)) / (3 * GAMMA)   # claimed t_c
    r_plus = (-b + mp.sqrt(D)) / (3 * GAMMA)
    if r_minus < 0:
        bad_root += 1
    if r_plus > mp.mpf("1e-30"):
        bad_sign += 1
    if a < 0:
        bad_zero += 1
print(f"t_c < 0 anywhere: {bad_root} pts;  other root > 0: {bad_sign} pts;  alpha < 0: {bad_zero} pts")
print(f"at A0 exactly: alpha={mp.nstr(alpha(A0),5)}, beta={mp.nstr(beta(A0),8)}, t_c={mp.nstr(t_c(A0),8)}")

# (iv) closed form vs brute-force maximisation
worst = mp.mpf(0)
for i in range(1, 401):
    A = A0 * i / 400
    d = abs(psi(A, t_star(A)) - psi_star_bruteforce(A))
    if d > worst:
        worst, worstA = d, A
print(f"max |closed form - brute force| over 400 points: {mp.nstr(worst,5)} at A={mp.nstr(worstA,8)}")

# (v) where does the cap bind?
sw = mp.findroot(lambda A: t_c(A) - Tcap(A), mp.mpf("0.5"))
print(f"branch switch t_c = T at A = {mp.nstr(sw,12)}  (cap binds for A below this)")
print(f"  t_c(0.3)={mp.nstr(t_c(mp.mpf('0.3')),8)} T(0.3)={mp.nstr(Tcap(mp.mpf('0.3')),8)}")
print(f"  t_c(0.7)={mp.nstr(t_c(mp.mpf('0.7')),8)} T(0.7)={mp.nstr(Tcap(mp.mpf('0.7')),8)}")

# ----------------------------------------------------------------- S2
sec("S2  the low band (0, 1/3]")
third = mp.mpf(1) / 3
print("beta(A) >= 0  <=>  (3/4)sqrt(2-2A^2) >= 3A  <=>  1-A^2 >= 8A^2  <=>  A <= 1/3")
print("  sympy:", sp.solve(sp.Eq(sp.Rational(3, 4) * sp.sqrt(2 - 2 * As**2), 3 * As), As))
print(f"  beta(1/3) = {mp.nstr(beta(third),8)}")

env = lambda A: g(A) + alpha(A) * Tcap(A) + beta(A) * Tcap(A) ** 2
mx = mp.mpf("-inf")
neg_beta = 0
for i in range(1, 200001):
    A = third * i / 200000
    if beta(A) < 0:
        neg_beta += 1
    v = env(A)
    if v > mx:
        mx, mxA = v, A
print(f"beta < 0 on (0,1/3]: {neg_beta} of 200000 points")
print(f"max envelope g + alpha*T + beta*T^2 on (0,1/3] = {mp.nstr(mx,12)} at A = {mp.nstr(mxA,10)}")
print(f"8/9 = {mp.nstr(mp.mpf(8)/9,12)};  envelope(1/3) = {mp.nstr(env(third),12)}; equal: {mp.nstr(env(third)-mp.mpf(8)/9,5)}")
print(f"envelope is increasing on (0,1/3]:  d/dA at 1/3 = {mp.nstr(mp.diff(env, third),8)}")
print(f"max F itself on (0,1/3] = {mp.nstr(max(F(third*i/20000) for i in range(1,20001)),12)}")
print(f"8/9 <= sqrt(3/2)?  {mp.mpf(8)/9 < TARGET}   (slack {mp.nstr(TARGET-mp.mpf(8)/9,8)})")

# is the envelope ever violated as an upper bound for F?
viol = max(F(third * i / 20000) - env(third * i / 20000) for i in range(1, 20001))
print(f"max (F - envelope) on (0,1/3] = {mp.nstr(viol,5)}  (must be <= 0)")

# ----------------------------------------------------------------- S3 preview
sec("S3 preview  the envelope overshoots above 1/3")
mx = mp.mpf("-inf")
for i in range(0, 100001):
    A = third + (mp.mpf("0.7") - third) * i / 100000
    v = env(A)
    if v > mx:
        mx, mxA = v, A
print(f"max envelope on [1/3,0.7] = {mp.nstr(mx,10)} at A={mp.nstr(mxA,8)}  (> sqrt(3/2) = {mp.nstr(TARGET,10)})")

# ----------------------------------------------------------------- S4
sec("S4  the endpoint expansion, symbolically")
e = sp.Symbol("e", positive=True)
A0s = sp.sqrt(sp.Rational(2, 3))
g_s = As**3 - (1 - As**2) ** sp.Rational(3, 2) / sp.sqrt(2) + 3 * As * (1 - As**2)
beta_s = sp.Rational(3, 4) * sp.sqrt(2 - 2 * As**2) - 3 * As
T_s = 2 * sp.sqrt(2) / 3 * As
gs = sp.simplify(g_s.subs(As, A0s))
g1 = sp.simplify(sp.diff(g_s, As).subs(As, A0s))
g2 = sp.simplify(sp.diff(g_s, As, 2).subs(As, A0s))
print("g(A0)      =", sp.nsimplify(sp.radsimp(gs)), " = sqrt(6)/2 ?", sp.simplify(gs - sp.sqrt(6) / 2) == 0)
print("g'(A0)     =", g1)
print("-g''(A0)/2 =", sp.radsimp(-g2 / 2), " = (9/4)sqrt6 ?", sp.simplify(-g2 / 2 - sp.Rational(9, 4) * sp.sqrt(6)) == 0)
a_exp = sp.series(alpha_s.subs(As, A0s - e), e, 0, 3).removeO()
print("alpha(A0-e) =", sp.expand(a_exp), " ; leading coeff 3sqrt3 ?", sp.simplify(sp.expand(a_exp).coeff(e, 1) - 3 * sp.sqrt(3)) == 0)
b0 = sp.simplify(beta_s.subs(As, A0s))
print("beta(A0)   =", sp.radsimp(b0), " = -(3/4)sqrt6 ?", sp.simplify(b0 + sp.Rational(3, 4) * sp.sqrt(6)) == 0)
print("T(A0)      =", sp.radsimp(sp.simplify(T_s.subs(As, A0s))), "=", float(T_s.subs(As, A0s)))
tstar_sym = sp.simplify(3 * sp.sqrt(3) * e / (2 * sp.Rational(3, 4) * sp.sqrt(6)))
print("t* = alpha/(2|beta|) =", sp.radsimp(tstar_sym), " = sqrt2*e ?", sp.simplify(tstar_sym - sp.sqrt(2) * e) == 0)
psistar_sym = sp.simplify((3 * sp.sqrt(3) * e) ** 2 / (4 * sp.Rational(3, 4) * sp.sqrt(6)))
print("psi* = alpha^2/(4|beta|) =", sp.radsimp(psistar_sym), " = (3/2)sqrt6 e^2 ?",
      sp.simplify(psistar_sym - sp.Rational(3, 2) * sp.sqrt(6) * e**2) == 0)
margin = sp.simplify(sp.Rational(9, 4) * sp.sqrt(6) - sp.Rational(3, 2) * sp.sqrt(6))
print("endpoint margin coefficient (9/4 - 3/2)sqrt6 =", sp.radsimp(margin), "=", float(margin), " ( (3/4)sqrt6 )")

print("\nnumerical check of the e^2 law:")
for ex in ["1e-2", "1e-3", "1e-4"]:
    ee = mp.mpf(ex)
    A = A0 - ee
    print(f"  e={ex}: (sqrt(3/2)-F)/e^2 = {mp.nstr((TARGET-F(A))/ee**2,10)}   [(3/4)sqrt6 = {mp.nstr(mp.mpf(3)/4*mp.sqrt(6),10)}]")

print("\nvalidity of the second-order picture across (0.7, A0]:")
for x in ["0.70", "0.72", "0.75", "0.78", "0.80", "0.8165"]:
    A = mp.mpf(x)
    if A > A0:
        A = A0
    ee = A0 - A
    exact = F(A)
    quad = TARGET - mp.mpf(3) / 4 * mp.sqrt(6) * ee**2
    print(f"  A={x}: e={mp.nstr(ee,6)}  F={mp.nstr(exact,12)}  2nd-order model={mp.nstr(quad,12)}  "
          f"model-F={mp.nstr(quad-exact,6)}  t*/T={mp.nstr(t_star(A)/Tcap(A),6)}")

# ----------------------------------------------------------------- S5
sec("S5  coverage and monotonicity")
print("ranges (0,1/3], (1/3,0.7], (0.7,A0] are consecutive half-open intervals: no gap, no overlap")
N = 600000
prev = None
desc = 0
worst_step = mp.mpf("inf")
mxF = mp.mpf("-inf")
for i in range(1, N + 1):
    A = A0 * i / N
    v = F(A)
    if v > mxF:
        mxF, mxA = v, A
    if prev is not None:
        d = v - prev
        if d < 0:
            desc += 1
        if d < worst_step:
            worst_step, wsA = d, A
    prev = v
print(f"{N} points: descending steps = {desc}; smallest step = {mp.nstr(worst_step,6)} at A={mp.nstr(wsA,10)}")
print(f"max F on the grid = {mp.nstr(mxF,15)} at A = {mp.nstr(mxA,12)};  sqrt(3/2) = {mp.nstr(TARGET,15)}")
print(f"F(A0) - sqrt(3/2) = {mp.nstr(F(A0)-TARGET,6)}")
