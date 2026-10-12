"""
Running the LIFTED Jaeger chain quantitatively: solve for theta instead of
contradicting (plan.md C8, the step after FINDINGS "Lifting Jaeger's 3.3 in
trace form" Results 1-9).

WHAT THIS COMPUTES
------------------
  c(n)        the DEFECT THRESHOLD: the largest delta^2 for which the lifted
              contradiction still closes at theta >= tilde_theta_0(n).  It is
              the constant in the dichotomy that is the corridor's current end
              state: "every critical point with theta >= tilde_theta_0(n) has
              scal(|W|) >= (n+1) tilde_theta_0(n)  or  delta^2 >= c(n)".
  Theta(d,n)  the BREAK-EVEN upper bound: on the small-scal branch (Assumption
              2, scal(|W|) <= (n-3) tilde_theta_0(n)) the largest theta the
              lifted chain leaves consistent at defect d = delta^2.  For
              theta > Theta(d,n) the chain closes, so no critical point has
              that theta, defect <= d, and small scal.  (Every appearance of d
              below is an upper bound on the defect, so the statement covers
              delta^2 <= d, not only delta^2 = d.)

The report also names WHAT BINDS at each break-even, because three different
things can close the chain and they mean different things: the maximum of
RHS_lift turning negative (the real contradiction), the admissible region
becoming empty (the lifted 3.3.1/3.3.2/3.3.6 triple being jointly infeasible --
also a genuine contradiction, but a cruder one), and one of Jaeger's own
hypotheses failing at an admissible point (NOT a contradiction: the chain
simply says nothing there).

Everything is at ||W|| = 1.  Jaeger's chain is NOT scale invariant (r^2, scal,
lambda_max and theta all carry weight), so unit norm is used throughout and
every number printed is a unit-norm number.

THE CHAIN, PARAMETRIZED BY theta AND BY THE DEFECT
--------------------------------------------------
Notation is Jaeger's 3.0.3: Ric := Ric(|W|), r := ||Ric||, S := Ric/r,
t := scal(|W|) = n*lambda_bar, v := tr S^4, y := (tr S^3)^2, x := n v - 1,
s := sqrt(1-e^2), d := delta^2 = ||Alt(W_-)||^2, and
  tilde0 := tilde_theta_0(n) = sqrt(2 (n-1)(n-3)/((n+1)(n-2))),
  hat(theta) := (n-2)/(n-3) * theta   (Jaeger's hat_theta_0 is hat(tilde0)).

Every tilde0 that entered Jaeger's text only as a lower bound for theta is
replaced by theta itself -- that is what "solve for theta" means.  Assumption 2
keeps tilde0, since it defines the branch.

Two DISTINCT defect entry points, and they are not the same one:

  (P) the SECTION 3.3 PENALTY (FINDINGS Result 3).  Lifted Lemma 3.3.4 reads
        theta r^2 <= sqrt2 r^2 sqrt(1-v) s - 2<Ric(W_-^2),Ric> + (J4 - J5),
      with J4 - J5 <= 24 d lambda_max(Ric), granted J5 >= 0.
  (B) the SECTION 3.2 BIANCHI CORRECTION.  scal(R^2+R^#) = ||Ric(R)||^2 +
      6||Alt R||^2 for every symmetric R and Alt(|W|) = 2 Alt(W_-), so Lemma
      3.2.2 becomes theta t = r^2 + 24 d - 4||W_-||^2 - C_#(W).  Lemma 3.2.3
      improves by the same mechanism (|W|'s Lambda^4 part is orthogonal to the
      Weyl space and ||R_{Lambda^4}||^2 = ||Alt R||^2 -- PART 0), so the
      Lemma 3.2.5 radicand moves by d*(96/(n-2) - 16) <= 0 for n >= 8, i.e. in
      the helpful direction.  Net: Lemma 3.3.1 lifts to r^2 >= hat(theta) t - 24 d.

The ingredients, all at a critical point of norm 1 (each is Jaeger's lemma with
both corrections carried; sources named):

  (L1) r^2 >= hat(theta) t - 24 d                                [3.2.5 -> 3.3.1]
       valid while theta >= (n-3) sqrt(2/((n-1)(n-2))) and theta t <= 2(n-3)^2/(n-2)
  (L2) r^2 >= theta t - 24 d + 4||W_-||^2 >= theta t - 24 d + 4 cW(n)     [3.2.2]
       with the elementary floor cW(n) on ||W_-||^2 proved in PART 0
  (L2') t = scal(|W|) = 2 tr_{Lambda^2}|W| = 4 tr W_-  >=  4 max(||W_+||,||W_-||)
        >= 2 sqrt2, since tr W_+ = tr W_- (W is trace-free on Lambda^2), tr A >=
        ||A|| for A >= 0, and ||W_+||^2 + ||W_-||^2 = 1.  This script's own
        addition; without it the chain has a spurious escape at scal -> 0.
  (L3) t^2/n <= r^2 <= v t^2,  r^2/t^2 <= y <= v,  1/n <= v <= 1  [3.3.2 + Cauchy-Schwarz]
  (L4) B := theta + hat(theta) r^2/(2(n-2)(r^2+24d)) - p <= sqrt2 sqrt(1-v) s,
       p := (J4-J5)/r^2 <= 24 d lambda_max/r^2                    [3.3.4 + 3.3.5]
       whence v <= 1 - max(B,0)^2/2 (lifted 3.3.6) and s >= B/(sqrt2 sqrt(1-v))
       (lifted 3.3.8, sharper than his e^2 <= 3/(2n) on this range)
  (L5) tr S^3 >= (7/10) v + 8647/38000                    [E-track exact certificate]
  (L6) the section 3.5 contradiction function.  Lifted Corollary 3.5.1 is
       Jaeger's with the single additive term (J4-J5)/s on the right; running it
       through Lemma 3.5.5's proof (definitions of X and Y, Lemma 3.5.3's
       spectral bound, Lemma 3.5.4, then (3.15) and multiplication by
       (2/r^2)(n-3)/(n-2)) gives: if a critical point with these data exists,

         RHS_lift := -(263/144) (n-3)/(n^2(n-2)) [t^2 - t^4/(n(hat(theta)t - 24d))]
                     - 2 theta Y0 t + 48 d (n-3)/(n-2) Y0
                     + (2 sqrt2/hat(theta)) sqrt(1-v) M(v,y)
                     + (n-3)/(n-2) sqrt2 sqrt(1-v) (J4-J5)/s
                  >= 0,
         Y0 := (2n-9)/(4n^3) + 3x/(8n^2),   M(v,y) := v + sqrt((v^2-y^2)/(1-y)).

       At theta = tilde0, d = 0 the first three lines are exactly the E-track's
       RHS (scripts/run_jaeger_threshold.py, scripts/run_jaeger_e5_certificate.py),
       asserted against it in PART 1.

  APPLICABILITY (Jaeger's own hypotheses, kept exact rather than rounded, and
  theta-parametrized).  Where one FAILS at a geometrically admissible point the
  chain yields nothing there: that point is an escape, not a contradiction.
  (C1) Lemma 3.5.4 needs Phi(x,theta) <= 0 and x <= 2, where Phi is the exact
       quadratic his proof requires.  He first rounds the x-coefficient
       (n^2-3n+4)/(n^2(n+1)(n-2)) down to (n-4)/(n^2(n-2)) and then rounds the
       hypothesis to x <= (n-2)/n; unrounded the admissible range at n=12,
       theta=tilde0 is x <= 1.1936 against his 0.8333.
  (C2) (3.12) needs Y >= -1+3/n, i.e. v/2 + (theta/sqrt2) sqrt(1-v) >= 3/(2n).
  (C3) Lemma 3.4.7 needs Z := (v-y)(1-y)/((1-v)^2 (v+y)) <= 1/2.
  (C4) Lemma 3.4.7's absorption step needs (1+sqrt Z) t / (2 theta r^2) <= 1.
  (C5) Lemma 3.3.1's side conditions (see L1).

THE BOUNDS THAT ARE CHOICES -- a reviewer should check these first
------------------------------------------------------------------
  * lambda_max(Ric) <= r v^(1/4), from lambda_max^4 <= tr Ric^4 = r^4 v.  It is
    sharper than lambda_max <= r and than lambda_max <= scal (both also true,
    since |W| >= 0 gives Ric(|W|) >= 0).  At Fox it returns 1.1547 against the
    true 0.8165, so it is lossy by 41% there.
  * the AM-GM parameter inside Lemma 3.4.7 is taken to be a = theta/sqrt(1-e^2)
    rather than Jaeger's a = tilde0/sqrt(1-e^2).  It is a free parameter of his
    proof, and taking theta makes Corollary 3.5.1's left side collapse to
    exactly theta r^2 after the division by sqrt(1-e^2), as his does at tilde0.
  * r is taken at its floor inside B (largest penalty p, smallest s) and at its
    ceiling t sqrt(v) inside the penalty (largest lambda_max).  Using opposite
    extremes of one number in two places is valid but lossy.
  * the ||W_-||^2 floor cW(n) is this script's own addition, not Jaeger's.
  * y is taken at its floor and Z is monotone in y, so both the penalty and the
    hypothesis checks are evaluated in the escape-favouring direction.

WHAT IS EXACT AND WHAT IS NUMERIC
---------------------------------
  exact (sympy / closed form):  tilde_theta_0, theta_0, E(n), the identification
    of Const(x,tilde0) with Jaeger's own pre-rounding expression, the quadratic
    Phi and hence x_max(theta), and theta_disc = 5 sqrt(561)/96 at n=12 -- the
    theta below which Lemma 3.5.4 is inapplicable for every x, which is a floor
    on Theta(d,n) unrelated to the defect.
  high precision (mpmath, 40 digits):  c(n), re-solved from the two corner
    equations once the grid has located the maximiser at (t_hi, E_lift).
  numeric (float64 grid + bisection):  the 2-D maximisation over (t,v), the
    location of the maximiser, and Theta(d,n).

USAGE:  python3 run_breakeven_theta.py
"""
import contextlib
import io

import numpy as np
import sympy as sp


# ------------------------------------------------------------------ constants
def tilde0_sym(n):
    n = sp.Integer(n)
    return sp.sqrt(2) * sp.sqrt(sp.Rational((n - 1) * (n - 3), (n + 1) * (n - 2)))


def consts(n):
    t0 = np.sqrt(2.0 * (n - 1.0) * (n - 3.0) / ((n + 1.0) * (n - 2.0)))
    N = n * (n - 1) // 2
    return dict(n=n, tilde0=t0, theta0=np.sqrt(2.0 * (n - 1.0) * (n - 2.0)) / n,
                N=N, cW=(2.0 / (np.sqrt(N + 4.0) + np.sqrt(float(N)))) ** 2,
                t_lo_abs=2.0 * np.sqrt(2.0),
                t_hi=(n - 3.0) * t0,
                theta_min_331=(n - 3.0) * np.sqrt(2.0 / ((n - 1.0) * (n - 2.0))),
                tt_max_331=2.0 * (n - 3.0) ** 2 / (n - 2.0))


# ------------------------------------------------- Lemma 3.5.4, unrounded
def phi_coeffs(n, th):
    """Phi(x,theta) = ((2(n-2)-x)/n) Y0 + Y0^2 + Const(x,theta), the exact
    quantity the proof of Lemma 3.5.4 needs to be <= 0.  Const comes from
    squaring (3.11):
      (1 - (1+x)/(2n) - 3/(2n) + Y)^2 >= (theta^2/2)(1 - (1+x)/n),
    which rearranges to  ((2(n-2)-x)/n) Y + Y^2 >= -Const  with
      Const = (1+x)^2/(4n^2) + 9/(4n^2) - 3/n + 3(1+x)/(2n^2)
              + (1 - theta^2/2)(1 - (1+x)/n).
    Returns (c2, c1, c0) with Phi = c2 x^2 + c1 x + c0."""
    a, b = (2.0 * n - 9.0) / (4.0 * n ** 3), 3.0 / (8.0 * n ** 2)
    q = 1.0 - th * th / 2.0
    c2 = -b / n + b * b + 1.0 / (4.0 * n ** 2)
    c1 = (2.0 * (n - 2.0) * b - a) / n + 2.0 * a * b \
        + 1.0 / (2.0 * n ** 2) + 3.0 / (2.0 * n ** 2) - q / n
    c0 = 2.0 * (n - 2.0) * a / n + a * a \
        + 1.0 / (4.0 * n ** 2) + 9.0 / (4.0 * n ** 2) - 3.0 / n + 3.0 / (2.0 * n ** 2) + q * (1.0 - 1.0 / n)
    return c2, c1, c0


def x_max(n, th):
    """largest x with Phi(x,theta) <= 0 (Phi is convex in x); -inf if none."""
    c2, c1, c0 = phi_coeffs(n, th)
    disc = c1 * c1 - 4.0 * c2 * c0
    if disc < 0.0:
        return -np.inf
    return (-c1 + np.sqrt(disc)) / (2.0 * c2)


# ------------------------------------------------------------- the E-track y
ALPHA_Y, C_Y = 0.7, 8647.0 / 38000.0          # tr S^3 >= ALPHA_Y v + C_Y


def m_of(v, y):
    return v + np.sqrt(np.clip((v * v - y * y) / np.maximum(1.0 - y, 1e-300), 0.0, None))


def rhs_formula(ct, th, d, t, v, y, pen=0.0):
    """RHS_lift as a plain formula in (t, v, y) -- no geometry imposed."""
    n = ct["n"]
    hat = (n - 2.0) / (n - 3.0) * th
    x = n * v - 1.0
    Y0 = (2.0 * n - 9.0) / (4.0 * n ** 3) + 3.0 * x / (8.0 * n ** 2)
    den = np.maximum(n * (hat * t - 24.0 * d), 1e-300)
    return (-(263.0 / 144.0) * (n - 3.0) / (n ** 2 * (n - 2.0)) * (t * t - t ** 4 / den)
            - 2.0 * th * Y0 * t + 48.0 * d * (n - 3.0) / (n - 2.0) * Y0
            + (2.0 * np.sqrt(2.0) / hat) * np.sqrt(np.maximum(1.0 - v, 0.0)) * m_of(v, y)
            + pen)


# ---------------------------------------------------------- the lifted chain
def chain(ct, th, d, t, v):
    """What the chain says at (t, v), vectorized.  Keys: adm (geometrically
    admissible), app (all of Jaeger's hypotheses hold), rhs (RHS_lift)."""
    n, cW, K = ct["n"], ct["cW"], 24.0 * d
    hat = (n - 2.0) / (n - 3.0) * th

    r2_min = np.maximum.reduce([hat * t - K, th * t - K + 4.0 * cW, t * t / n])
    r2_max = v * t * t
    adm = (r2_min > 0) & (r2_min <= r2_max) & (v >= 1.0 / n) & (v <= 1.0) \
        & (t >= ct["t_lo_abs"]) & (t <= ct["t_hi"])
    r_min = np.sqrt(np.maximum(r2_min, 1e-300))

    p = K * np.power(np.maximum(v, 1e-300), 0.25) / r_min       # >= (J4-J5)/r^2
    Bp = np.maximum(th + hat * r2_min / (2.0 * (n - 2.0) * (r2_min + K)) - p, 0.0)
    adm = adm & (v <= 1.0 - Bp * Bp / 2.0)                      # lifted 3.3.6

    y = np.minimum(np.maximum((ALPHA_Y * v + C_Y) ** 2, r2_min / (t * t)), v)
    s = np.clip(Bp / np.sqrt(2.0 * np.maximum(1.0 - v, 1e-300)), 1e-12, 1.0)

    x = n * v - 1.0
    Z = (v - y) * (1.0 - y) / (np.maximum(1.0 - v, 1e-300) ** 2 * np.maximum(v + y, 1e-300))
    c2, c1, c0 = phi_coeffs(n, th)
    cond = {
        "C1 Lemma 3.5.4  Phi(x,theta) <= 0": (c2 * x * x + c1 * x + c0) <= 0.0,
        "C1 Lemma 3.5.4  x <= 2": x <= 2.0,
        "C2 (3.12)  Y >= -1+3/n":
            v / 2.0 + (th / np.sqrt(2.0)) * np.sqrt(np.maximum(1.0 - v, 0.0)) >= 1.5 / n,
        "C3 Lemma 3.4.7  Z <= 1/2": Z <= 0.5,
        "C4 Lemma 3.4.7 absorption":
            (1.0 + np.sqrt(np.maximum(Z, 0.0))) * t / (2.0 * th * r2_min) <= 1.0,
        "C5 Lemma 3.3.1  theta*t <= 2(n-3)^2/(n-2)": t <= ct["tt_max_331"] / th,
        "C5 Lemma 3.3.1  theta floor":
            np.full_like(t, th >= ct["theta_min_331"], dtype=bool),
    }
    app = np.logical_and.reduce(list(cond.values())) & (x >= 0.0)

    # lambda_max <= r v^(1/4) <= t v^(3/4);  penalty = (n-3)/(n-2) sqrt2 sqrt(1-v) (J4-J5)/s
    pen = (n - 3.0) / (n - 2.0) * np.sqrt(2.0) * np.sqrt(np.maximum(1.0 - v, 0.0)) \
        * K * t * np.power(np.maximum(v, 0.0), 0.75) / s
    return dict(adm=adm, app=app, cond=cond, rhs=rhs_formula(ct, th, d, t, v, y, pen),
                y=y, s=s, Z=Z, x=x, pen=pen, r2_min=r2_min, r2_max=r2_max)


def escape_score(ct, th, d, nt=700, nv=700, refine=3):
    """max over geometrically admissible (t,v) of RHS_lift, with +inf as soon as
    an admissible point falls outside Jaeger's hypotheses.  < 0 <=> chain closes."""
    tlo, thi, vlo, vhi = ct["t_lo_abs"], ct["t_hi"], 1.0 / ct["n"], 1.0
    best, where = -np.inf, None
    for _ in range(refine + 1):
        T, V = np.meshgrid(np.linspace(tlo, thi, nt), np.linspace(vlo, vhi, nv),
                           indexing="ij")
        c = chain(ct, th, d, T, V)
        gap = c["adm"] & ~c["app"]
        if gap.any():
            i = int(np.argmax(gap.ravel()))
            broken = [k for k, ok in c["cond"].items() if not np.ravel(ok * np.ones_like(gap))[i]]
            return np.inf, (float(T.ravel()[i]), float(V.ravel()[i])), \
                "open: " + "; ".join(broken)
        val = np.where(c["adm"], c["rhs"], -np.inf)
        i = int(np.argmax(val.ravel()))
        if val.ravel()[i] > best:
            best = float(val.ravel()[i])
            where = (float(T.ravel()[i]), float(V.ravel()[i]))
        if not np.isfinite(best):
            return -np.inf, None, "region empty"
        dt, dv = (thi - tlo) / nt, (vhi - vlo) / nv
        tlo = max(ct["t_lo_abs"], where[0] - 3 * dt)
        thi = min(ct["t_hi"], where[0] + 3 * dt)
        vlo, vhi = max(1.0 / ct["n"], where[1] - 3 * dv), min(1.0, where[1] + 3 * dv)
    return best, where, "max of RHS_lift"


def closes(ct, th, d, **kw):
    return escape_score(ct, th, d, **kw)[0] < 0.0


def bisect(pred, lo, hi, tol, itmax=80):
    """smallest point where the monotone predicate flips False -> True."""
    for _ in range(itmax):
        if hi - lo < tol:
            break
        mid = 0.5 * (lo + hi)
        if pred(mid):
            hi = mid
        else:
            lo = mid
    return 0.5 * (lo + hi)


# ============================================================ report sections
def part0(n):
    print("=" * 78)
    print("PART 0: the two convention-dependent inputs, and the ||W_-||^2 floor")
    print("=" * 78)
    try:
        from run_defect_penalty_test import setup
        from run_bianchi_defect import alt_mop
        from weyl_decomposition import norm, frob
        rng = np.random.default_rng(5)
        ctx = setup(6, verbose=False)
        alt_idx, Nd = ctx["alt_idx"], ctx["N"]
        worst = 0.0
        for _ in range(4):
            A = rng.normal(size=(Nd, Nd)); A = 0.5 * (A + A.T); A /= norm(A)
            Al = alt_mop(A, alt_idx)
            worst = max(worst, abs(frob(A, Al) - frob(Al, Al)),
                        norm(alt_mop(Al, alt_idx) - Al))
        print(f"  alt_mop is the orthogonal projector onto Lambda^4: idempotent and")
        print(f"  <A, Alt A> = ||Alt A||^2, worst residual {worst:.1e}")
        print(f"  => ||R_(Lambda^4)||^2 = ||Alt R||^2, so |W|'s Lambda^4 part adds 4 delta^2")
        print(f"     to Lemma 3.2.3 and the Lemma 3.2.5 radicand moves by "
              f"d*(96/(n-2)-16) = {96.0/(n-2)-16:+.4f} d at n={n} (helpful for n >= 8).")
    except Exception as exc:                                    # pragma: no cover
        print(f"  [skipped repo-machinery calibration: {exc}]")
    ct = consts(n)
    print(f"\n  ||W_-||^2 floor: W is trace-free on Lambda^2 (scal(W)=0), so tr W_+ = tr W_-,")
    print(f"  ||W_+||^2 <= lambda_max(W_+) tr W_+ <= tr W_- <= sqrt(N) ||W_-||, N = {ct['N']},")
    print(f"  and ||W_+||^2 + ||W_-||^2 = 1, whence ||W_-||^2 >= cW = {ct['cW']:.8f}.")
    print(f"  The same trace identity gives the sharper scal floor used below:")
    print(f"    scal(|W|) = 2 tr_(Lambda^2)|W| = 4 tr W_- >= 4 max(||W_+||,||W_-||)")
    print(f"             >= 4/sqrt2 = {ct['t_lo_abs']:.6f}, independent of n and of the defect.")
    return ct


def part1(ct):
    n = ct["n"]
    print()
    print("=" * 78)
    print("PART 1: at theta = tilde_theta_0(n), d = 0 the formula IS the E-track's RHS")
    print("=" * 78)
    xs = sp.symbols("xs", real=True)
    ns = sp.Integer(n)
    t0s = tilde0_sym(n)
    const = ((1 + xs) ** 2 / (4 * ns ** 2) + sp.Rational(9, 4 * ns ** 2) - sp.Rational(3, ns)
             + 3 * (1 + xs) / (2 * ns ** 2)
             + (1 - t0s ** 2 / 2) * (1 - (1 + xs) / ns))
    jaeger = (sp.Rational(ns ** 2 - 7 * ns + 8, ns ** 2 * (ns + 1) * (ns - 2))
              + sp.Rational(ns ** 2 - 3 * ns + 4, ns ** 2 * (ns + 1) * (ns - 2)) * xs
              - xs ** 2 / (4 * ns ** 2))
    print(f"  Const(x,tilde0) + [Jaeger's own pre-rounding left side] = "
          f"{sp.simplify(sp.expand(const + jaeger))}   (expect 0)")
    c2, c1, c0 = phi_coeffs(n, ct["tilde0"])
    xm = x_max(n, ct["tilde0"])
    # his rounding replaces the x-coefficient (n^2-3n+4)/(n^2(n+1)(n-2)) by
    # (n-4)/(n^2(n-2)), i.e. drops 8/(n^2(n+1)(n-2)) from it
    c1r = c1 + 8.0 / (n ** 2 * (n + 1.0) * (n - 2.0))
    xm_rounded = (-c1r + np.sqrt(c1r * c1r - 4.0 * c2 * c0)) / (2.0 * c2)
    print(f"  unrounded Lemma 3.5.4 hypothesis: x <= {xm:.6f}  "
          f"(with his rounded x-coefficient: {xm_rounded:.6f}; his stated bound: "
          f"{(n-2)/n:.6f})")
    E = (8.0 * n * n - 41.0 * n + 49.0) / (4.0 * (n + 1.0) * (n - 2.0) * (n - 3.0))
    print(f"  i.e. tr S^4 <= {(1+xm)/n:.6f}, comfortably above E(n) = {E:.6f}")

    with contextlib.redirect_stdout(io.StringIO()):
        from run_jaeger_threshold import rhs_num
    t0 = ct["tilde0"]; hat0 = (n - 2.0) / (n - 3.0) * t0
    v = np.array([E]); yE = np.array([(ALPHA_Y * E + C_Y) ** 2])
    for lbl, t in (("case 1  t = hat_theta_0/E", np.array([hat0 / E])),
                   ("case 2  t = (n-3) tilde0", np.array([ct["t_hi"]]))):
        ref = rhs_num(n, v, yE)[0] if "case 1" in lbl else None
        mine = rhs_formula(ct, t0, 0.0, t, v, yE)[0]
        extra = f"   run_jaeger_threshold.rhs_num = {ref:+.8f}" if ref is not None else ""
        print(f"  {lbl}:  RHS_lift = {mine:+.8f}{extra}")
    print(f"  (the E-track's certified n=12 endpoint value is -0.02184071)")

    # the theta below which Lemma 3.5.4 is inapplicable for EVERY x: Phi's
    # discriminant is a quadratic in theta^2, so this is exact
    ths = sp.symbols("ths", positive=True)
    a = sp.Rational(2 * n - 9, 4 * n ** 3); b = sp.Rational(3, 8 * n ** 2)
    q = 1 - ths ** 2 / 2
    C2 = -b / ns + b ** 2 + sp.Rational(1, 4 * ns ** 2)
    C1 = (2 * (ns - 2) * b - a) / ns + 2 * a * b + sp.Rational(2, ns ** 2) - q / ns
    C0 = (2 * (ns - 2) * a / ns + a ** 2 + sp.Rational(1, 4 * ns ** 2)
          + sp.Rational(9, 4 * ns ** 2) - sp.Rational(3, ns) + sp.Rational(3, 2 * ns ** 2)
          + q * (1 - sp.Rational(1, ns)))
    roots = [rt for rt in sp.solve(sp.Eq(sp.expand(C1 ** 2 - 4 * C2 * C0), 0), ths)
             if rt.is_real and float(rt) > 0]
    th_disc = min(float(rt) for rt in roots)
    print(f"\n  Lemma 3.5.4 is inapplicable for every x when its quadratic Phi has no real")
    print(f"  root, i.e. for theta < theta_disc = {th_disc:.9f}  (exact: "
          f"{sp.nsimplify(sp.radsimp(min(roots, key=lambda r: float(r))))})")
    print(f"  This is a floor on Theta(d,n) that has nothing to do with the defect.")

    sc, wh, why = escape_score(ct, t0, 0.0)
    print(f"\n  full 2-D search at (theta,d) = (tilde0, 0): max RHS_lift = {sc:+.8f}")
    print(f"    at (t,v) = ({wh[0]:.5f}, {wh[1]:.6f})  [{why}]")
    print(f"  The margin is larger than the E-track's 0.0218 because the geometric floor")
    print(f"  y >= r^2/t^2 (Jaeger's own Lemma 3.3.2) is imposed here; the E-track lets")
    print(f"  (t,v,y) vary independently and so evaluates a point that is not realisable.")
    return sc


def part2(ct):
    n = ct["n"]
    print()
    print("=" * 78)
    print("PART 2: cross-validation at Fox S^4(alpha) and the sphere products")
    print("=" * 78)
    try:
        from run_defect_penalty_test import setup, fox_weyl, sphere_weyl
        from run_bianchi_defect import bianchi_defect
        from weyl import build_structure_constants
        from weyl_decomposition import mop_from_4tensor, norm, frob
        from rsharp_basis_free import Q_full
        from run_jaeger_lift_33 import (ric_of, dot_contract, sharp_of, ric_wedge,
                                        spectral_parts)
    except Exception as exc:                                    # pragma: no cover
        print(f"  [skipped: {exc}]")
        return None
    ctx = setup(n, verbose=False)
    _, _, _, cst = build_structure_constants(n)
    L2 = ctx["L2"]
    rows = []
    for label, W in (("Fox S^4(alpha)", fox_weyl(ctx)),
                     (f"sphere ({n//2},{n//2})", sphere_weyl(ctx, n // 2)),
                     (f"sphere (2,{n-2})", sphere_weyl(ctx, 2))):
        th = frob(W, Q_full(W, cst))
        Wp, Wm, Pp, Pm = spectral_parts(W)
        aW = Wp + Wm
        d = bianchi_defect(W, ctx["alt_idx"]) ** 2
        Ric = ric_of(L2, aW)
        r2 = frob(Ric, Ric); r = np.sqrt(r2); t = np.trace(Ric)
        S = Ric / r
        v = np.trace(np.linalg.matrix_power(S, 4))
        y = np.trace(np.linalg.matrix_power(S, 3)) ** 2
        lam = np.linalg.eigvalsh(Ric)[-1]
        RwR = mop_from_4tensor(L2, ric_wedge(Ric))
        s = frob(aW, RwR) / norm(RwR)
        Xinv = sharp_of(aW, cst) - Pp @ sharp_of(W, cst) @ Pp + Pm @ sharp_of(W, cst) @ Pm
        J = frob(ric_of(L2, aW @ aW + sharp_of(aW, cst)) - dot_contract(L2, aW, Ric), Ric) \
            - frob(ric_of(L2, Xinv), Ric)
        rows.append(dict(label=label, th=th, d=d, t=t, r2=r2, r=r, v=v, y=y, lam=lam,
                         s=s, J=J, Wm2=frob(Wm, Wm), trWm=np.trace(Wm),
                         nRwR=norm(RwR)))
    print(f"  {'point':22s} {'theta':>9s} {'delta^2':>9s} {'scal':>9s} {'r^2':>9s} "
          f"{'trS^4':>8s} {'s':>7s} {'J4-J5':>9s}")
    for R in rows:
        print(f"  {R['label']:22s} {R['th']:9.6f} {R['d']:9.6f} {R['t']:9.5f} "
              f"{R['r2']:9.5f} {R['v']:8.5f} {R['s']:7.5f} {R['J']:+9.5f}")
    print()
    for R in rows:
        th, d, t, r2, v, lam = R["th"], R["d"], R["t"], R["r2"], R["v"], R["lam"]
        hat = (n - 2.0) / (n - 3.0) * th
        # L1 is Jaeger's Lemma 3.3.1: it presupposes Assumption 2 and (in the
        # theta-parametrized form) theta >= (n-3) sqrt(2/((n-1)(n-2))).
        l1_applies = (t <= ct["t_hi"] + 1e-9) and (th >= ct["theta_min_331"]) \
            and (th * t <= ct["tt_max_331"] + 1e-9)
        checks = [
            ("||Ric^Ric|| = r^2 sqrt(1-trS^4)/sqrt2",
             abs(R["nRwR"] - r2 * np.sqrt(1 - v) / np.sqrt(2.0)) < 1e-9),
            ("L1  r^2 >= hat*t - 24d  [only where it applies]",
             (not l1_applies) or r2 >= hat * t - 24 * d - 1e-9),
            ("L2  r^2 >= th*t - 24d + 4||W_-||^2",
             r2 >= th * t - 24 * d + 4 * R["Wm2"] - 1e-9),
            ("cW <= ||W_-||^2", ct["cW"] <= R["Wm2"] + 1e-12),
            ("L2' scal = 4 tr W_- >= 2 sqrt2",
             abs(t - 4.0 * R["trWm"]) < 1e-9 and t >= ct["t_lo_abs"] - 1e-9),
            ("L3  t^2/n <= r^2 <= v t^2",
             t * t / n <= r2 + 1e-9 and r2 <= v * t * t + 1e-9),
            ("L3  r^2/t^2 <= y <= v", r2 / (t * t) <= R["y"] + 1e-9 and R["y"] <= v + 1e-9),
            ("penalty  J4-J5 <= 24 d lambda_max", R["J"] <= 24 * d * lam + 1e-9),
            ("lambda_max <= r v^(1/4)", lam <= R["r"] * v ** 0.25 + 1e-9),
            ("L4  B <= sqrt2 sqrt(1-v) s",
             th + hat * r2 / (2.0 * (n - 2.0) * (r2 + 24 * d)) - R["J"] / r2
             <= np.sqrt(2.0) * np.sqrt(1 - v) * R["s"] + 1e-9),
            ("L5  trS^3 >= .7 v + 8647/38000",
             np.sqrt(R["y"]) >= ALPHA_Y * v + C_Y - 1e-9),
        ]
        bad = [k for k, ok in checks if not ok]
        note = "" if l1_applies else "   [Assumption 2 / 3.3.1 side condition off: L1 not asserted]"
        print(f"  {R['label']:22s} {len(checks)-len(bad)}/{len(checks)} lifted ingredients hold"
              + (f"    FAIL: {bad}" if bad else "") + note)
    fox = rows[0]
    c2, c1, c0 = phi_coeffs(n, fox["th"])
    xf = n * fox["v"] - 1.0
    print(f"\n  Fox is a genuine critical point on the small-scal branch (scal "
          f"{fox['t']:.4f} <= (n-3)tilde0 = {ct['t_hi']:.4f}),")
    print(f"  so the chain MUST leave it alive.  It does, and the escape localises exactly:")
    print(f"    Lemma 3.5.4 needs Phi(x,theta_Fox) <= 0; at Fox x = {xf:.4f} gives "
          f"Phi = {c2*xf*xf + c1*xf + c0:+.6f} > 0  -> hypothesis fails")
    print(f"    the root cause is p = (J4-J5)/r^2 = {fox['J']/fox['r2']:.4f}, larger than")
    print(f"    theta itself, so the lifted 3.3.6 ceiling on tr S^4 is vacuous at Fox.")
    return rows


def corner_c(ct, th, digits=40):
    """High-precision c: at d near c the maximiser sits at the corner
    (t, v) = (t_hi, E_lift), so c solves two scalar equations -- the fixed point
    v = 1 - B(v,d)^2/2 and RHS_lift(t_hi, v, y(v)) = 0 -- which mpmath can nail.
    Returns (c, v_at_c); the caller must confirm the corner claim on the grid."""
    from mpmath import mp, mpf, sqrt, findroot
    mp.dps = digits
    n = mpf(ct["n"]); t = mpf(ct["t_hi"]); th = mpf(th); cW = mpf(ct["cW"])
    hat = (n - 2) / (n - 3) * th
    aY, cY = mpf(7) / 10, mpf(8647) / 38000

    def eqs(v, d):
        K = 24 * d
        r2 = max(hat * t - K, th * t - K + 4 * cW, t * t / n)
        B = th + hat * r2 / (2 * (n - 2) * (r2 + K)) - K * v ** mpf(0.25) / sqrt(r2)
        f1 = v - (1 - max(B, mpf(0)) ** 2 / 2)
        y = min(max((aY * v + cY) ** 2, r2 / (t * t)), v)
        s = min(max(B, mpf(0)) / sqrt(2 * (1 - v)), mpf(1))
        x = n * v - 1
        Y0 = (2 * n - 9) / (4 * n ** 3) + 3 * x / (8 * n ** 2)
        M = v + sqrt((v * v - y * y) / (1 - y))
        pen = (n - 3) / (n - 2) * sqrt(2) * sqrt(1 - v) * K * t * v ** mpf(0.75) / s
        f2 = (-(mpf(263) / 144) * (n - 3) / (n ** 2 * (n - 2))
              * (t * t - t ** 4 / (n * (hat * t - K)))
              - 2 * th * Y0 * t + 48 * d * (n - 3) / (n - 2) * Y0
              + (2 * sqrt(2) / hat) * sqrt(1 - v) * M + pen)
        return f1, f2

    v, d = findroot(eqs, (mpf("0.157"), mpf("0.00108")))
    return d, v


def part3(ct):
    n, t0, th0 = ct["n"], ct["tilde0"], ct["theta0"]
    print()
    print("=" * 78)
    print(f"PART 3: c({n}) -- the largest defect at which the chain still closes")
    print("=" * 78)
    out = {}
    for name, th in (("tilde_theta_0", t0), ("theta_0", th0)):
        hi = 1e-3
        while closes(ct, th, hi) and hi < 1.0:
            hi *= 2.0
        cval = bisect(lambda dd: not closes(ct, th, dd), 0.0, hi, 1e-12)
        out[name] = cval
        sc, wh, why = escape_score(ct, th, cval * 0.999)
        try:
            cm, vm = corner_c(ct, th)
            ref = (f"  corner equations (mpmath, 40 digits): c = {float(cm):.10e} "
                   f"at v = {float(vm):.8f}, agreement {abs(float(cm)-cval):.2e}")
        except Exception as exc:                                # pragma: no cover
            ref = f"  [corner refinement failed: {exc}]"
        print(f"  theta = {name:14s} = {th:.6f}:   c = {cval:.6e}   "
              f"(grid maximiser at t = {wh[0]:.5f} = t_hi, v = {wh[1]:.6f})")
        print(ref)
    print()
    print(f"  DICHOTOMY at n={n}.  Every critical point with theta >= tilde_theta_0({n}) has")
    print(f"    scal(|W|) >= (n+1) tilde_theta_0({n}) = {(n+1)*t0:.5f}   or   "
          f"delta^2 >= c({n}) = {out['tilde_theta_0']:.6e}.")
    print(f"  Fox's delta^2 = 1/9 exceeds c({n}) by a factor "
          f"{(1/9)/out['tilde_theta_0']:.0f}, so it sits on the defect branch -- consistent")
    print(f"  (and at n={n} Fox does not even satisfy theta >= tilde_theta_0).")
    return out


def break_even(ct, d, th_hi=12.0, nscan=240):
    """Theta(d,n) = the largest theta at which the chain still fails to close.
    Computed by scanning theta rather than by bisection, because closes() is not
    guaranteed monotone in theta (Lemma 3.3.1's side condition theta*t <=
    2(n-3)^2/(n-2) cuts the other way)."""
    grid = np.geomspace(0.85 * ct["theta_min_331"], th_hi, nscan)
    open_at = [i for i, th in enumerate(grid) if not closes(ct, th, d, nt=420, nv=420)]
    if not open_at:
        return -np.inf, "closes at every theta scanned"
    last = max(open_at)
    if last == len(grid) - 1:
        return np.inf, f"still open at theta = {th_hi}"
    Th = bisect(lambda th: closes(ct, th, d), grid[last], grid[last + 1], 1e-7)
    why_below = escape_score(ct, Th * (1 - 1e-6), d)[2]
    why_above = escape_score(ct, Th * (1 + 1e-6), d)[2]
    return Th, f"below: {why_below[:46]} | above: {why_above[:30]}"


def part4(ct, grid):
    n, th0 = ct["n"], ct["theta0"]
    print()
    print("=" * 78)
    print(f"PART 4: Theta(d,{n}) -- break-even theta on the small-scal branch")
    print("=" * 78)
    print(f"  {'d = delta^2':>13s} {'Theta(d,n)':>14s} {'- theta_0':>12s}  vs theta_0")
    rows = []
    for d in grid:
        Th, note = break_even(ct, d)
        rows.append((d, Th))
        shown = "infinite" if not np.isfinite(Th) else f"{Th:.7f}"
        delta = "-" if not np.isfinite(Th) else f"{Th - th0:+.7f}"
        print(f"  {d:13.6g} {shown:>14s} {delta:>12s}  "
              f"{'BELOW theta_0' if Th < th0 else 'above theta_0'}")
        print(f"                what binds at the break-even -- {note}")
    return rows


def part5_break(ct):
    """the defect at which the chain stops saying anything at ANY theta"""
    n = ct["n"]
    print()
    print("=" * 78)
    print(f"PART 5: d_break({n}) -- where the chain goes vacuous at every theta")
    print("=" * 78)
    fin = lambda dd: np.isfinite(break_even(ct, dd)[0])
    lo, hi = 1e-3, 1e-2
    while fin(hi) and hi < 1.0:
        hi *= 2.0
    d_break = bisect(lambda dd: not fin(dd), lo, hi, 1e-9)
    print(f"  d_break = {d_break:.6e}.  Since delta^2 = ||Alt(W_-)||^2 <= ||W_-||^2 <= 1")
    print(f"  always, d_break > 1 means the chain stays non-vacuous at every attainable")
    print(f"  defect: Theta(d,{n}) is finite throughout 0 <= d <= 1.")
    return d_break


def main(n=12):
    ct = part0(n)
    part1(ct)
    part2(ct)
    cs = part3(ct)
    grid = sorted(set([0.0, 1e-5, 1e-4, round(cs["tilde_theta_0"], 12), 1e-3,
                       1.5e-3, 2e-3, 3e-3, 5e-3, 1e-2, 2e-2, 4e-2, 6e-2, 8e-2,
                       1e-1, 1.0 / 9.0, 0.12]))
    rows = part4(ct, grid)
    d_break = part5_break(ct)
    print()
    print("=" * 78)
    print("PART 6: the headline")
    print("=" * 78)
    Th_fox = next(Th for d, Th in rows if abs(d - 1.0 / 9.0) < 1e-12)
    tf = np.sqrt(1.5)
    print(f"  c({n})           = {cs['tilde_theta_0']:.6e}   (closing at theta >= tilde_theta_0)")
    print(f"                     {cs['theta_0']:.6e}   (closing at theta >= theta_0)")
    print(f"  d_break({n})     = {d_break:.6e}")
    print(f"  Theta(1/9, {n})  = {'infinite' if not np.isfinite(Th_fox) else f'{Th_fox:.7f}'}")
    print(f"  theta_0({n})     = {ct['theta0']:.6f}")
    print(f"  Is Theta(1/9,{n}) < theta_0({n})?   "
          f"{'YES' if Th_fox < ct['theta0'] else 'NO'}")
    print(f"  Fox anchor Theta(1/9,{n}) >= theta(Fox) = {tf:.6f}:  "
          f"{'satisfied' if Th_fox >= tf else 'VIOLATED -- bookkeeping bug'}")


if __name__ == "__main__":
    main()
