"""r228, claim 2: is the two-atom extremal structure right, is the algebra right, and can
anything beat p_3^min(m,N) = 9/(16 m N) - 3m/4?

THE PROBLEM.  minimise  P3(x) = sum_i x_i^3
        over  x in R^N   subject to  sum x_i = 0,  sum x_i^2 = c,  x_i >= -m.
The file takes c = 3/4 (the |W| = 1 normalisation).  Everything below is done for
general c so the normalisation cannot hide in it; c = 3/4 is the special case.

WHY TWO ATOMS, FROM MOMENT THEORY RATHER THAN ASSERTION.  Pass to the empirical measure
rho = (1/N) sum delta_{x_i}, a probability measure on [-m, infinity) with
    int 1 drho = 1,   int t drho = 0,   int t^2 drho = c/N,
and P3 = N int t^3 drho.  Dropping the requirement that the weights be multiples of 1/N
relaxes the feasible set, so the relaxed minimum is a valid LOWER bound for every N-tuple.
The relaxed problem is the classical Markov moment problem: minimise the next moment given
three moments on a half-line.  Krein-Markov theory says the extreme values of int t^3 over
that moment set are attained at the principal representations, and on [a, infinity) the
LOWER principal representation for an odd index is the one whose support includes the
finite endpoint a; the parameter count matches -- three moment equations against (weight
at -m, weight at the free atom, position of the free atom) = three unknowns.  So the
minimiser is one atom AT the boundary -m and one free atom, which is the file's
configuration.  The file's own justification ("with two equality constraints an extremal
point takes at most two distinct values") counts the constraints wrong -- there are three
including the mass -- and the correct count admits THREE values, {-m, y, z}.  The
conclusion survives the correction, but only because of the boundary structure, which the
file does not invoke.  This script therefore checks the three-atom family explicitly.

Note the constraint is never inactive: with sum x^2 fixed and no lower bound, a mass eps
at -T obeys eps T^2 <= c and contributes -eps T^3 >= -cT, which is unbounded below.
"""
import numpy as np, itertools
from scipy.optimize import minimize, linprog
import sympy as sp

# ---------------------------------------------------------------- 1. the algebra
print("=" * 78)
print("1.  THE ALGEBRA, symbolically, for general second moment c")
print("=" * 78)
m, N, k, a, c, r = sp.symbols('m N k a c r', positive=True)
a_sol = sp.solve(sp.Eq(k*(-m) + (N-k)*a, 0), a)[0]
print(f"   trace-freeness      =>  a = {a_sol}")
p2 = sp.simplify(k*m**2 + (N-k)*a_sol**2)
k_sol = sp.solve(sp.Eq(p2, c), k)
print(f"   second moment = c   =>  k = {sp.simplify(k_sol[0])}")
ksol = sp.simplify(k_sol[0])
r_expr = sp.simplify(ksol/(N-ksol))
print(f"   ratio r = k/(N-k)   =  {r_expr}      (file says 3/(4 m^2 N) at c = 3/4:"
      f" {sp.simplify(r_expr.subs(c, sp.Rational(3,4)))})")
p3 = sp.simplify(-ksol*m**3 + (N-ksol)*a_sol.subs(k, ksol)**3)
print(f"   p_3                 =  {sp.simplify(sp.factor(p3))}")
closed = c**2/(N*m) - c*m
print(f"   claimed general form c^2/(Nm) - c m:  difference = {sp.simplify(p3 - closed)}")
at34 = sp.simplify(p3.subs(c, sp.Rational(3,4)))
print(f"   at c = 3/4:  p_3^min = {at34}")
print(f"   file's 9/(16 m N) - 3m/4:  difference = "
      f"{sp.simplify(at34 - (sp.Rational(9,16)/(m*N) - sp.Rational(3,4)*m))}")
print(f"   also stated: p_3 = N m^3 r (r-1).  difference = "
      f"{sp.simplify(p3 - (N*m**3*r_expr*(r_expr-1)))}")
print(f"   monotone in m:  d/dm = {sp.simplify(sp.diff(at34, m))}  (negative for m,N>0,"
      " so the cap is the weakest valid member -- the file is right about that)")

def p3min(mm, NN, cc=0.75): return cc**2/(NN*mm) - cc*mm

# ------------------------------------------------- 2. the three-atom family, exhaustively
print()
print("=" * 78)
print("2.  CAN THREE ATOMS BEAT TWO?  {-m, y, z} with free weights, exhaustive sweep")
print("=" * 78)
def best_three_atom(mm, NN, cc, ngrid=420):
    """min of N*int t^3 over probability measures on {-m, y, z}; weights solved from the
    three moment equations, kept only when all are >= 0."""
    lo, hi = -mm, 6*np.sqrt(cc/NN) + 3*mm
    grid = np.linspace(lo, hi, ngrid)
    best, arg = np.inf, None
    for iy in range(ngrid):
        for iz in range(iy+1, ngrid):
            y, z = grid[iy], grid[iz]
            A = np.array([[1.0, 1.0, 1.0], [-mm, y, z], [mm*mm, y*y, z*z]])
            if abs(np.linalg.det(A)) < 1e-12: continue
            w = np.linalg.solve(A, np.array([1.0, 0.0, cc/NN]))
            if w.min() < -1e-12: continue
            v = NN*(w[0]*(-mm)**3 + w[1]*y**3 + w[2]*z**3)
            if v < best: best, arg = v, (w, y, z)
    return best, arg

for (mm, NN) in ((0.6742, 77), (1.3484, 77), (0.3, 30), (0.9, 12), (0.12, 200)):
    b2 = p3min(mm, NN)
    b3, arg = best_three_atom(mm, NN, 0.75)
    w, y, z = arg
    print(f"   m={mm:7.4f} N={NN:4d} | two-atom {b2:+.8f} | best 3-atom {b3:+.8f} "
          f"| slack {b3-b2:+.2e} | weights {np.round(w,4)} at (-m, {y:.4f}, {z:.4f})")
print("   (a NEGATIVE slack would refute the two-atom claim; none appears)")

# ------------------------------------- 3. the raw N-variable problem, many random starts
print()
print("=" * 78)
print("3.  THE RAW PROBLEM IN N VARIABLES -- SLSQP from many starts, N = 77 and N = 12")
print("=" * 78)
rng = np.random.default_rng(228)
def raw_min(NN, mm, cc, tries=40):
    cons = [{'type':'eq','fun': lambda x: x.sum()},
            {'type':'eq','fun': lambda x: (x**2).sum() - cc}]
    bnds = [(-mm, None)]*NN
    best, bx = np.inf, None
    for _ in range(tries):
        x0 = rng.standard_normal(NN); x0 -= x0.mean(); x0 *= np.sqrt(cc/ (x0**2).sum())
        x0 = np.maximum(x0, -mm*0.99)
        res = minimize(lambda x: (x**3).sum(), x0, jac=lambda x: 3*x**2,
                       constraints=cons, bounds=bnds, method='SLSQP',
                       options={'maxiter':800,'ftol':1e-14})
        if res.success:
            x = res.x
            if abs(x.sum()) < 1e-7 and abs((x**2).sum()-cc) < 1e-7 and x.min() >= -mm-1e-9:
                if (x**3).sum() < best: best, bx = (x**3).sum(), x
    return best, bx

for (NN, mm) in ((77, 0.6742), (77, 1.3484), (12, 0.9), (30, 0.3)):
    b, bx = raw_min(NN, mm, 0.75)
    b2 = p3min(mm, NN)
    vals = np.unique(np.round(bx, 6))
    print(f"   N={NN:3d} m={mm:7.4f} | SLSQP best {b:+.8f} | closed form {b2:+.8f} "
          f"| SLSQP - bound = {b-b2:+.3e} (must be >= 0)")
    print(f"        distinct values found: {len(vals)}  -> {np.round(vals,5)[:6]}"
          f"{' ...' if len(vals)>6 else ''}  (n at -m: {(np.abs(bx+mm)<1e-6).sum()})")

# ------------------------------------------------ 4. the integer-relaxation direction
print()
print("=" * 78)
print("4.  INTEGER k VS RELAXED k -- the file says relaxing can only LOWER the minimum")
print("=" * 78)
print("   The relaxed feasible set CONTAINS every N-tuple's empirical measure, so the")
print("   relaxed minimum is <= the true minimum.  That is the direction claimed, and it")
print("   is the safe one.  Checked against the best integer two-value split:")
for (mm, NN) in ((0.6742, 77), (1.3484, 77), (0.3, 30), (0.9, 12)):
    best_int = np.inf
    for kk in range(1, NN):
        aa = kk*mm/(NN-kk)
        if abs(kk*mm**2 + (NN-kk)*aa**2 - 0.75) > 1e-9:
            # the second-moment equation cannot hold at integer k with BOTH values pinned;
            # instead solve for the free value with k fixed and the boundary atom at -m.
            # k*m^2 + (N-k)*a^2 = c and k*(-m) + (N-k)*a = 0 over-determines a, so with k
            # an integer only one of the two can hold.  Relax the boundary atom to -mu<=m.
            continue
    # the honest integer problem: k atoms at -mu (mu <= m) and N-k atoms at a
    for kk in range(1, NN):
        # unknowns mu, a with k*(-mu)+(N-k)a = 0 and k mu^2 + (N-k) a^2 = c
        # => a = k mu/(N-k), k mu^2 (1 + k/(N-k)) = c => mu^2 = c (N-k)/(k N)
        mu2 = 0.75*(NN-kk)/(kk*NN)
        mu = np.sqrt(mu2)
        if mu > mm + 1e-12: continue
        aa = kk*mu/(NN-kk)
        v = -kk*mu**3 + (NN-kk)*aa**3
        best_int = min(best_int, v)
    print(f"   m={mm:7.4f} N={NN:4d} | best integer two-value {best_int:+.8f} "
          f"| relaxed closed form {p3min(mm,NN):+.8f} | relaxed is lower by "
          f"{best_int-p3min(mm,NN):+.3e}")

# ------------------------------------------------------- 5. planted violations
print()
print("=" * 78)
print("5.  PLANTED VIOLATIONS -- each MUST fire")
print("=" * 78)
NN, mm, cc = 77, 0.6742, 0.75
# (a) allow one entry below -m: the bound must break
kk = 30
mu_bad = 1.35
x = np.zeros(NN); x[0] = -mu_bad
rest = np.full(NN-1, mu_bad/(NN-1))
x[1:] = rest
x = x*np.sqrt(cc/(x**2).sum())
print(f"   (a) one entry at {x.min():+.4f} < -m = {-mm:.4f}: p_3 = {(x**3).sum():+.8f} vs bound "
      f"{p3min(mm,NN):+.8f}  ->  {'FIRES (bound broken, as it must be)' if (x**3).sum() < p3min(mm,NN) else 'does NOT fire'}")
# (b) wrong second moment: use c = 3 (the |M|_F = 1 normalisation) against the c = 3/4 bound
x = None
b3v, arg = best_three_atom(mm, NN, 3.0, 240)
print(f"   (b) second moment 3 instead of 3/4 (the OTHER normalisation) against the same")
print(f"       bound: true min {b3v:+.8f} vs 3/4-bound {p3min(mm,NN):+.8f}  ->  "
      f"{'FIRES' if b3v < p3min(mm,NN) else 'does NOT fire'}")
print(f"       (the matching bound at c = 3 is {p3min(mm,NN,3.0):+.8f}, and {b3v:+.6f} >= it)")
# (c) a config satisfying everything: must NOT beat the bound
ok = True
for _ in range(20000):
    x = rng.standard_normal(NN)
    x -= x.mean()
    x = np.maximum(x, -mm)
    x -= x.mean()
    if x.min() < -mm: continue
    s = (x**2).sum()
    if s <= 0: continue
    x = x*np.sqrt(cc/s)
    if x.min() < -mm - 1e-12: continue
    if abs(x.sum()) > 1e-9: continue
    if (x**3).sum() < p3min(mm, NN) - 1e-12: ok = False; print("   (c) BEATEN by", x); break
print(f"   (c) 20000 random feasible configs: bound survives = {ok}  (this one must NOT fire)")

# ---------------------------------------- 6. the bound at the extremiser, correct units
print()
print("=" * 78)
print("6.  THE BOUND AT THE EXTREMISER, WITH THE CORRECT m AND THE CORRECT SIGN")
print("=" * 78)
def theta0(n): return np.sqrt(2*(n-1)*(n-2))/n
def sphere_omega(mm_):
    """the record's closed-form omega spectrum of S^m x S^m, |M|_F = 1 normalisation."""
    A = 1.0/(mm_*np.sqrt((mm_-1)*(2*mm_-1)))
    return (np.array([mm_*A, -(mm_-1)*A, -2*mm_*(mm_-1)*A]),
            np.array([(mm_-1)*(mm_+2), mm_**2, 1]))
print(f"   {'n':>4} {'N':>5} {'m = mu = cap/2':>15} {'p_3(omega)':>12} {'p_3^min':>12} "
      f"{'holds?':>7} {'loss factor':>12}")
for n in (12, 14, 16, 24, 40, 100):
    mm_ = n//2
    vals, mult = sphere_omega(mm_)
    vals = vals/2.0                      # |M|_F = 1  ->  |W| = 1
    NN = n*(n+1)//2 - 1
    assert mult.sum() == NN
    p1 = (vals*mult).sum(); p2 = (vals**2*mult).sum(); p3 = (vals**3*mult).sum()
    assert abs(p1) < 1e-12 and abs(p2 - 0.75) < 1e-12, (p1, p2)
    mu = -vals.min()
    cap = n*theta0(n)/(n-1)/2
    assert abs(mu - cap) < 1e-12, f"mu should equal the cap at the balanced product: {mu} {cap}"
    lo = p3min(mu, NN)
    print(f"   {n:>4} {NN:>5} {mu:>15.8f} {p3:>12.6f} {lo:>12.6f} "
          f"{str(lo <= p3):>7} {p3/lo:>12.4f}")
print("   'loss factor' is p_3(omega)/p_3^min, both negative; 1.00 would be tight.")
print()
print("   What the route then needs, in the |M|_F = 1 units the identity uses:")
for n in (12, 24, 100):
    mm_ = n//2
    vals, mult = sphere_omega(mm_)
    NN = n*(n+1)//2 - 1
    p3o = (vals**3*mult).sum()
    mu = -vals.min()
    lo = p3min(mu, NN, 3.0)
    t0 = theta0(n)
    A = 1.0/(mm_*np.sqrt((mm_-1)*(2*mm_-1)))
    p3nu = A                              # the record's p_3(mu) at the balanced product
    print(f"   n={n:3d}: identity check  1.5*{p3nu:.6f} - 0.5*({p3o:.6f}) = "
          f"{1.5*p3nu - 0.5*p3o:.6f}  vs theta_0 = {t0:.6f}")
    print(f"          bound gives theta <= 1.5*p_3(nu) - 0.5*({lo:.6f}) = "
          f"{1.5*p3nu - 0.5*lo:.6f}, over target by {1.5*p3nu - 0.5*lo - t0:+.6f}")

# ------------------------------- 7. a certificate that PROVES the bound in two lines
print()
print("=" * 78)
print("7.  THE BOUND HAS A ONE-LINE SOS-TYPE CERTIFICATE -- no extremal structure needed")
print("=" * 78)
t, s_ = sp.symbols('t s', positive=True)
q = (t + m)*(t - s_/m)**2                  # >= 0 for every t >= -m
qe = sp.expand(q)
print(f"   q(t) = (t+m)(t - s/m)^2 = {qe}   >= 0 on t >= -m")
# integrate against a probability measure with int 1 = 1, int t = 0, int t^2 = s
c0 = qe.coeff(t, 0); c1 = qe.coeff(t, 1); c2 = qe.coeff(t, 2); c3 = qe.coeff(t, 3)
print(f"   coefficients: t^3:{c3}  t^2:{c2}  t^1:{c1}  t^0:{c0}")
lower = sp.simplify(-(c2*s_ + c1*0 + c0))
print(f"   0 <= int q  =  int t^3 + ({c2})*s + ({c1})*0 + ({c0})   =>   int t^3 >= {lower}")
# rescale to the N-tuple: s = c/N and P3 = N int t^3
P3low = sp.simplify(N*lower.subs(s_, c/N))
print(f"   with s = c/N and P_3 = N int t^3:   P_3 >= {sp.simplify(sp.expand(P3low))}")
print(f"   difference from the file's closed form (at c = 3/4): "
      f"{sp.simplify(P3low.subs(c, sp.Rational(3,4)) - (sp.Rational(9,16)/(m*N) - sp.Rational(3,4)*m))}")
print("   Equality iff the measure sits on {-m, c/(Nm)}, which is the file's two-atom")
print("   configuration -- so the structural claim is CORRECT, and the certificate proves")
print("   the inequality without needing it, and without the integer-relaxation remark.")
