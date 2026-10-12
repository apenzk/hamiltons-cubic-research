"""r244 / claim 6.  Is the screen's 'solver output' a fair model of an SDP
solver, or a straw man that makes fitting look worse than it is?

The screen models the per-dimension solver output as

    x(n0) + t * ker,      t = randint(-5,5)/randint(1,4),   seed 9

drawn INDEPENDENTLY at each dimension -- and again, freshly, at the held-out
dimension n = 20.  Four tests.

  T1  the held-out value is a FRESH draw, so the screen compares a fit against
      an independent sample of the same random variable.
  T2  the screen's ansatz is (deg2/deg1) at four dimensions.  Check whether it
      can represent the miniature's OWN noiseless answer.
  T3  a converged primal-dual interior-point solver returns the ANALYTIC CENTRE
      of the optimal face -- canonical, deterministic in n.  Model that, with an
      ADEQUATE ansatz.  (a) rational centre.  (b) algebraic centre, generic.
  T4  size the miss.  A loud miss is caught by anything; a quiet miss is the
      real hazard, and only one of the models produces quiet ones.

Fitting p/q at points is LINEAR in the coefficients with q monic:
p(n_i) - y_i q(n_i) = 0.  Exact over Q where the data is rational, and at 60
decimal digits where it is algebraic (a magnitude measurement, not a verdict).
"""
import sympy as sp, random as _r, mpmath as mp

mp.mp.dps = 60
n = sp.symbols('n')
line = lambda s='': print(s)

A = sp.Matrix([[1, n, 2], [0, n - 2, 1]])
b = sp.Matrix([n + 3, 1])
v = sp.Matrix([1, 1, -1])
Aug = A.col_join(v.T); bug = b.col_join(sp.Matrix([0]))
x = sp.simplify(Aug.solve(bug))
ker2 = A.nullspace()[0]

def fit_exact(dp, dq, pts, holdout, true):
    """p of degree dp over monic q of degree dq, through the rational pts."""
    P = sp.symbols(f'p0:{dp+1}'); Q = sp.symbols(f'q0:{dq}')
    p = sum(P[i]*n**i for i in range(dp+1))
    q = n**dq + sum(Q[i]*n**i for i in range(dq))
    eqs = [sp.Eq(p.subs(n, ni) - sp.Rational(y)*q.subs(n, ni), 0) for ni, y in pts]
    sol = sp.solve(eqs, list(P)+list(Q), dict=True)
    if not sol: return None, None
    f = sp.cancel((p/q).subs(sol[0]))
    pred = sp.nsimplify(f.subs(n, holdout))
    return sp.simplify(pred - sp.Rational(true)) == 0, f

def fit_mp(dp, dq, pts, holdout, true):
    """the same fit at 60 digits, for algebraic data.  Returns relative miss."""
    N = dp + 1 + dq
    M = mp.matrix(N, N); rhs = mp.matrix(N, 1)
    for r, (ni, y) in enumerate(pts):
        for i in range(dp+1): M[r, i] = mp.mpf(ni)**i
        for j in range(dq):   M[r, dp+1+j] = -y * mp.mpf(ni)**j
        rhs[r] = y * mp.mpf(ni)**dq
    co = mp.lu_solve(M, rhs)
    pv = sum(co[i]*mp.mpf(holdout)**i for i in range(dp+1))
    qv = mp.mpf(holdout)**dq + sum(co[dp+1+j]*mp.mpf(holdout)**j for j in range(dq))
    return abs(pv/qv - true)/abs(true)

# ------------------------------- T1 -----------------------------------------
line("T1  the screen's model -- an independent draw at EVERY dimension,")
line("    the held-out one included.")
DIMS = (12, 14, 16, 18)
hits, errs = 0, []
for s in range(40):
    _r.seed(s)
    def out(ni):
        t = sp.Rational(_r.randint(-5, 5), _r.randint(1, 4))
        return sp.Rational((x + t*ker2).subs(n, ni)[0])
    pts = [(ni, out(ni)) for ni in DIMS]
    true = out(20)
    ok, _ = fit_exact(2, 1, pts, 20, true)
    hits += bool(ok)
    if true != 0:
        errs.append(float(abs(sp.N(_ .subs(n, 20) - true, 40)/true)) if _ is not None else None)
errs = sorted(e for e in errs if e is not None)
line(f"    exact hits over 40 seeds: {hits} / 40")
line(f"    relative miss at n=20: min {errs[0]:.3e}  median {errs[len(errs)//2]:.3e}"
     f"  max {errs[-1]:.3e}")
line("    The held-out value is sampled AFTER the fit.  Extrapolating four")
line("    samples of a random variable and comparing to a fifth independent")
line("    sample fails with probability 1, for ANY fitting method, sound or not.")
line("    The test measures the planted noise -- not fitting, and not solvers.")

# ------------------------------- T2 -----------------------------------------
line("\nT2  can the screen's ansatz represent the miniature's noiseless answer?")
c_rat = sp.simplify(6 - n/12)                    # a rational selection t(n)
exact_expr = sp.cancel(sp.together(x[0] + c_rat*ker2[0]))
dn, dd = sp.degree(sp.numer(exact_expr), n), sp.degree(sp.denom(exact_expr), n)
line(f"    a rational selection t(n) = {c_rat} makes coordinate 0 exactly")
line(f"      {exact_expr}")
line(f"    -- type (deg {dn} / deg {dd}).  The screen's ansatz is (deg 2 / deg 1),")
line(f"    4 coefficients at 4 points.  It cannot represent a (deg {dn}/deg {dd})")
line("    function, so the screen is UNDER-PARAMETERISED before any noise is")
line("    added.  Part of its 'failure' is a wrong ansatz, not a wrong method.")

# ------------------------------- T3 -----------------------------------------
line("\nT3  an actual solver's output: the analytic centre of the body,")
line("    with an ADEQUATE (deg 3 / deg 2) ansatz at six dimensions.")
D6 = (12, 14, 16, 18, 20, 22); HO = 26
line("    (a) two active constraints: the analytic centre of [l(n), u(n)] is the")
line("        midpoint, RATIONAL in n whenever l and u are.")
pts_a = [(ni, sp.Rational(exact_expr.subs(n, ni))) for ni in D6]
true_a = sp.Rational(exact_expr.subs(n, HO))
ok_a, f_a = fit_exact(3, 2, pts_a, HO, true_a)
line(f"        exact hit at n = {HO}?  {ok_a}")
line(f"        recovered f(n) = {sp.cancel(f_a)}")
assert ok_a, "a rational solver output must be recovered exactly"
line("        => WITH AN HONEST SOLVER MODEL AND AN ADEQUATE ANSATZ THE FIT IS")
line("           EXACT.  Dropped into the screen, this makes its assert FIRE and")
line("           the screen CRASH announcing that the flaw is not exhibited.")
line("           The screen passes only because its model is random.")

t = sp.symbols('t')
g = [t - (3 - n/2), (n/3 + 9) - t, (n + 4) - t]
crit = sp.solve(sp.Eq(sp.numer(sp.together(sum(sp.diff(sp.log(gi), t) for gi in g))), 0), t)
centre3 = next(cc for cc in crit if -3 < sp.N(cc.subs(n, 12), 30) < 13)
line(f"\n    (b) three active constraints: the centring equation is quadratic, so")
line(f"        the analytic centre is ALGEBRAIC --")
line(f"        t(n) = {sp.simplify(centre3)}")
expr_b = sp.together(x[0] + centre3*ker2[0])
val = lambda ni: mp.mpf(str(sp.N(expr_b.subs(n, ni), 55)))
rel_b = fit_mp(3, 2, [(ni, val(ni)) for ni in D6], HO, val(HO))
line(f"        adequate (3/2) ansatz, held out at n = {HO}:")
line(f"          relative miss {mp.nstr(rel_b, 4)}")

# ------------------------------- T4 -----------------------------------------
med = errs[len(errs)//2]
line("\nT4  the size of the miss is the whole point.")
line(f"    screen's random model    : median relative miss {med:.2e}   LOUD")
line(f"    algebraic analytic centre: relative miss {mp.nstr(rel_b,3)}   "
     f"{'QUIET -- passes a 1e-6 acceptance test' if rel_b < mp.mpf('1e-6') else 'visible'}")
line(f"    rational analytic centre : relative miss 0            the fit is CORRECT")
line(f"    ratio: the honest model's miss is {mp.nstr(mp.mpf(med)/rel_b, 3)}x SMALLER")
line("    than the screen's manufactured one.")

line("\nVERDICT -- the exhibited failure does not prove what it claims.")
line("  1. TAUTOLOGY.  The held-out value is a fresh draw from the same")
line("     generator, so the comparison fails regardless of the method tested.")
line("  2. THE MODEL IS WRONG.  A converged interior-point solver does not")
line("     return 'whatever its path-following happens to hit'.  It returns the")
line("     analytic centre of the optimal face: canonical, and a deterministic")
line("     semi-algebraic function of n.  The screen's premise -- 'four")
line("     arbitrary points of four DIFFERENT feasible bodies' -- is the false")
line("     part: the four bodies are four members of ONE rational family, so")
line("     their centres lie on one algebraic curve, not scattered.")
line("  3. UNDER-PARAMETERISED.  The ansatz cannot represent even the")
line(f"     noiseless answer, which is (deg {dn}/deg {dd}).")
line("  4. THE STRAW MAN HIDES THE DIRECTION THAT MATTERS.  Under an honest")
line("     model the fit succeeds exactly (rational centre) or misses by")
line(f"     {mp.nstr(rel_b,2)} (algebraic centre) -- small enough to PASS a numerical")
line("     acceptance test.  A4's real hazard is a QUIET wrong answer; the")
line("     screen manufactures only loud ones, so it makes the flaw look easier")
line("     to detect than it is, and it makes A2' look more necessary for the")
line("     wrong reason.")
line()
line("  A2' IS STILL THE RIGHT REPAIR, for a reason the screen does not give:")
line("  the analytic centre is an ALGEBRAIC function of n of uncontrolled")
line("  degree, so no rational ansatz of bounded degree is JUSTIFIED however")
line("  well it fits -- and by T3(b) it will fit well.  That argument survives")
line("  an honest solver model.  The screen should make it instead.")
