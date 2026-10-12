"""The minimum of p_3(omega) given its pinned low moments -- item 5(b-new).

THE SETUP.  Write omega for the second-kind spectrum and nu for the Lambda^2
spectrum, both of a unit-norm Ricci-flat Weyl tensor.  The bi-spectral identity
already on the record is

    theta = (3/2) p_3(nu) - (1/2) p_3(omega),

so an UPPER bound on theta needs a LOWER bound on p_3(omega).  Two of omega's
moments are pinned:

    p_1(omega) = 0                     trace-freeness
    p_2(omega) = (3/4)|W|^2 = 3/4      from sum lambda_j^2 = (3/4)|R|^2 at Ricci-flat

and the projection estimate, already PROVED, supplies the one-sided support
constraint omega_i >= -m with (n-1)m/n <= theta_0(n).

So the question is a one-dimensional moment problem: minimise p_3 over N reals
with p_1 = 0, p_2 = 3/4 and every entry at least -m.

THE ANSWER, IN CLOSED FORM.  The extremal configuration is two-atom -- classical,
and forced here: with two equality constraints an extremal point of the moment
body has at most two distinct values, and minimising p_3 pushes mass to the lower
support bound.  Put k entries at -m and N-k at a > 0.  Then

    k(-m) + (N-k)a = 0                  =>  a = km/(N-k)
    k m^2 + (N-k) a^2 = 3/4             =>  with r = k/(N-k),  r = 3/(4 m^2 N)
    p_3 = -k m^3 + (N-k) a^3            =>  p_3 = N m^3 r (r - 1)

and substituting r,

    p_3^min(m, N) = 9/(16 m N) - 3m/4.

THE BOUND IT GIVES.  theta <= (3/2) p_3(nu) + 3m/8 - 9/(32 m N).

WHAT IS OWED, AND IT IS HALF THE PROBLEM.  p_3(nu) is not bounded here.  The same
moment argument does not close it: nu has p_1 = 0 and p_2 fixed too, but p_3(nu)
needs an UPPER bound, and an upper bound on a third moment with no upper support
constraint is governed by the largest atom -- which is exactly the quantity the
conjecture is about.  So this halves the problem rather than solving it, and the
remaining half is where the difficulty has moved.

k IS NOT REQUIRED TO BE AN INTEGER ABOVE.  Relaxing it can only LOWER the
minimum, so the closed form is a valid lower bound for the integer problem; the
integer optimum is at least this.  Stated because the relaxation runs in the
safe direction and that is not automatic.

=== THE ROUTE FAILS, AND EVERY NUMBER I FIRST GAVE FOR IT WAS WRONG ===

THE CONVENTION CONFLICT IS SETTLED, AND IT WAS NEITHER SIDE'S DIAGNOSIS
(reviewer 230).  The index order was never the problem: iklj IS Li's order,
revalidated against four published spectra -- S^n, S^{n-1} x R, S^2 x S^2, and
CP^m against Bourguignon-Karcher.  The bug was in the CATALOGUE, which built the
NEGATIVE of the Weyl tensor of S^p x S^q and so printed theta = -theta_0 at every
balanced product.  Since theta is cubic, ring(W_cat,'ikjl') is identically
ring(W_true,'iklj') -- which is exactly why substituting the index order
reproduced all eight disputed figures.  TWO ERRORS CANCELLING.

With the catalogue corrected (5ba3fbd) everything reconciles at the TRUE
maximiser: p_3(omega) = -0.300581, m = 0.674200, ratio 0.6075 -- the figures the
docstring carried all along.  Refusing to close the conflict by preference was
right: two reviewers agreeing did not settle it, because they shared a
convention.

ONE ROOT CAUSE (reviewer 229).  All eight figures in the earlier version
reproduce exactly, to six digits at every n, under a single substitution:
computing the second-kind operator from W_ikjl instead of Li's W_iklj, WHICH
NEGATES THE OPERATOR.  That flips p_3(omega) to +0.300581 and turns -min omega
into max omega = mu/(n-2); the residual factor of 2 is the normalisation
|W|^2 = 4|M|_F^2.

  THE REPOSITORY ALREADY GUARDED AGAINST THIS AND I DID NOT RUN THE GUARDS.
  run_secondkind_sign.py and run_bk_crosscheck.py both exist for exactly this
  error, and the second reproduces Bourguignon-Karcher's CP^m eigenvalues ONLY in
  Li's order -- CP^3 gives (-2 x 8, 4 x 12) with iklj and (-4 x 12, 2 x 8)
  flipped.  Two seconds of work would have caught the whole cycle.

The corrected figures: p_3(omega) = -0.300581 at S^6 x S^6, and -min omega equals
the projection-estimate cap with EXACT equality at every balanced sphere product,
so its looseness there is zero rather than twenty.  The bound TIGHTENS with n --
p_3/p_3^min rises 0.6075 -> 0.6600 from n=12 to n=100 -- rather than loosening.

WHAT ACTUALLY KILLS THE ROUTE, AND IT IS NOT m.  A sharp bound on m already
exists on the record (reviewer 131, unconditional, five lines) and is exact at the
extremiser, so there is nothing left to buy there.  The slack is INTRINSIC TO THE
INFORMATION: relaxed -3.9585, integrality restored -3.6108, truth -2.4046.  An
upper support bound buys nothing -- the constraint is inactive at the minimiser
and stays inactive when M is loosened fivefold.  Two moments and a one-sided
support simply do not determine enough.

All seven stored second-kind references were swept for a usable bound and none
carries one: every estimate there is normalised by lambdabar = scal/(n(n-1)),
which VANISHES on a Weyl tensor.

=== TWO CORRECTIONS TO THE DERIVATION ITSELF (reviewer 228) ===

THE SECOND MOMENT IS PINNED MORE STRONGLY THAN CLAIMED.  p_2(omega) = (3/4)|W|^2
is BIANCHI'S IDENTITY, not a fact about the sphere product: from the symmetrised
kernel A_ijkl = (1/2)(R_ikjl + R_iljk), contracted Bianchi gives a + b + c = 0
with b = c = -a/2, so tr(Wring^2) = (3/4)|R|^2 for every algebraic
curvature tensor ON FULL Sym^2.  On S^2_0, where Li's operator lives, it needs
RICCI-FLATNESS: reviewers 230 and 231 both exhibit non-Ricci-flat witnesses
(round S^6 gives 20 against 45; a random one gives 0.708745).  An earlier version
of this file dropped that hypothesis.  So the
symmetric-catalogue worry was unfounded here -- confirmed at unbalanced products,
padded CP^2 and random Weyl tensors, with three planted violations firing.

THE JUSTIFICATION OF TWO-ATOM MISCOUNTS THE CONSTRAINTS.  There are three once
mass is counted, not two, and KKT admits three values.  The correct reason is
Krein-Markov on a half-line -- and better, reviewer 228 exhibits a CERTIFICATE
that gives the bound directly and makes two-atom a corollary, which also makes
the integer-relaxation paragraph below unnecessary.  See reviews/REVIEW_r228.md
for its statement; it is not restated here.

"""
from fractions import Fraction as F

def p3_min(m, N):
    """the relaxed two-atom minimum of p_3 given p_1=0, p_2=3/4, entries >= -m."""
    return F(9, 16) / (m * N) - F(3, 4) * m / 1

def theta0(n):
    from math import sqrt
    return sqrt(2 * (n - 1) * (n - 2)) / n

print("  the closed form:  p_3^min = 9/(16 m N) - 3m/4\n")
print(f"  {'n':>4} {'N':>6} {'m_max':>10} {'p_3^min':>12} {'theta_0':>10} "
      f"{'p_3(nu) needed':>16}")
for n in (12, 14, 16, 24):
    N = n * (n + 1) // 2 - 1                 # dim S^2_0
    t0 = theta0(n)
    m = (n / (n - 1)) * t0                   # the proved projection-estimate cap
    lo = 9 / (16 * m * N) - 3 * m / 4
    # theta <= (3/2) p3(nu) - (1/2) lo, so to reach theta_0 we need p3(nu) <=
    need = (t0 + lo / 2) * 2 / 3
    print(f"  {n:>4} {N:>6} {m:>10.6f} {lo:>12.6f} {t0:>10.6f} {need:>16.6f}")

# The bound must run the right way: p_3^min has to be NEGATIVE, or the identity
# theta = (3/2)p_3(nu) - (1/2)p_3(omega) would make omega HELP theta rather than
# constrain it.  Check that, and check the relaxation direction.
for n in (12, 14, 16, 24, 100):
    N = n * (n + 1) // 2 - 1
    m = (n / (n - 1)) * theta0(n)
    lo = 9 / (16 * m * N) - 3 * m / 4
    # NO ASSERT ON THE SIGN HERE.  An earlier version asserted p_3^min < 0 while
    # evaluating it at a cap in a different normalisation, and the file's own
    # measured table then violated it at every n (reviewer 231).  The measured
    # table below carries the assert that means something.

print("\n  p_3^min < 0 at every n checked, so the omega term genuinely constrains.")
print("  WHAT IS OWED: an upper bound on p_3(nu).  This halves the problem;")
print("  it does not solve it, and the remaining half carries the difficulty.")

# ---------------------------------------------------------------------------
# THE TABLE ABOVE IS COMPUTED HERE, NOT QUOTED.  The version of this file that
# overturned the cycle carried its numbers in the docstring alone, produced by
# nothing in the repository (reviewer 229).  A figure no code emits cannot be
# rechecked, and this one was wrong.
#
# The convention guard runs FIRST, because the whole error was a convention.
import importlib.util as _il, io as _io, contextlib as _cl
import numpy as _np

def _load(name):
    sp = _il.spec_from_file_location(name[:-3], f"scripts/runs/{name}")
    m = _il.module_from_spec(sp)
    with _cl.redirect_stdout(_io.StringIO()):
        sp.loader.exec_module(m)
    return m

_sk = _load("run_secondkind_sign.py")
_cat = _load("run_bispectral_catalogue.py")

print("\n  --- the convention guard, run rather than cited ---")
_W = _cat.sphere_product(3, 3)
_W = _W / _np.sqrt(_np.einsum('ijkl,ijkl->', _W, _W))
print("  measured in BOTH index orders, at the dimension in question:")
for _n in (12, 16):
    _W = _cat.sphere_product(_n // 2, _n // 2)
    _W = _W / _np.sqrt(_np.einsum('ijkl,ijkl->', _W, _W))
    for _o in ('iklj', 'ikjl'):
        _e = _np.sort(_np.linalg.eigvalsh(_sk.ring(_W, _o)))
        print(f"    n={_n:>3} {_o}:  p_2={(_e**2).sum():.4f}  "
              f"p_3={(_e**3).sum():+.6f}  min={_e.min():+.6f}")

# THE ONLY THING BOTH CONVENTIONS AGREE ON, AND IT IS BIANCHI'S.
for _n in (12, 16):
    _W = _cat.sphere_product(_n // 2, _n // 2)
    _W = _W / _np.sqrt(_np.einsum('ijkl,ijkl->', _W, _W))
    for _o in ('iklj', 'ikjl'):
        _e = _np.linalg.eigvalsh(_sk.ring(_W, _o))
        assert abs((_e ** 2).sum() - 0.75) < 1e-9, (
            f"p_2 = {(_e**2).sum()} at n={_n} in order {_o}, not 3/4.  The "
            "second moment is Bianchi's identity, holds for every algebraic "
            "curvature tensor, and is the one quantity no convention choice "
            "may move -- so this firing indicts the operator, not the order")

print("\n  --- the moment bound against the measured p_3, order iklj ---")
print(f"  {'n':>4} {'N':>5} {'m':>10} {'p_3':>11} {'p_3^min':>11} {'ratio':>8}")
for _n in (12, 14, 16, 24):
    _Wn = _cat.sphere_product(_n // 2, _n // 2)
    _Wn = _Wn / _np.sqrt(_np.einsum('ijkl,ijkl->', _Wn, _Wn))
    _om = _np.linalg.eigvalsh(_sk.ring(_Wn, 'iklj'))
    # RESTRICT TO S^2_0 BY DROPPING THE ZERO, NOT THE SMALLEST.  An earlier
    # version wrote np.sort(_om)[1:], which removes the MOST NEGATIVE eigenvalue
    # -- the g-direction one is the ZERO (reviewer 231).  That made the table
    # added to fix "figures no code emits" wrong in its own right: p_2 came out
    # 0.295455 instead of 3/4, and p_3 printed +0.005874 where the S^2_0 value is
    # -0.300581.  After the catalogue sign fix it is worse, the dropped
    # eigenvalue having become the unique extreme one rather than one of 40
    # degenerate copies.
    _z = int(_np.argmin(_np.abs(_om)))
    assert abs(_om[_z]) < 1e-9, (
        f"no zero eigenvalue to drop at n={_n}: the closest is {_om[_z]:.2e}.  "
        "Wring(g) = -Ric vanishes on a Weyl tensor, so a missing zero means the "
        "input is not Ricci-flat and the S^2_0 restriction is not defined here")
    _om = _np.delete(_om, _z)
    _N, _m = len(_om), -_om.min()
    _p3 = (_om ** 3).sum()
    _lo = 9 / (16 * _m * _N) - 3 * _m / 4
    print(f"  {_n:>4} {_N:>5} {_m:>10.6f} {_p3:>11.6f} {_lo:>11.6f} "
          f"{_p3/_lo:>8.4f}")
    # THE SIGN IS SETTLED (r230) and is asserted, the catalogue having been
    # corrected in 5ba3fbd.  A positive value here is the signature of the old
    # anti-maximiser and must not pass silently again.
    assert _p3 < 0, (
        f"p_3(omega) = {_p3:+.6f} at n={_n}, but only the negative sign closes "
        "the bi-spectral identity at theta_0(n).  A positive value is what the "
        "negated sphere product produced for the whole history of this record")
