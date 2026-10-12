"""The odd MW' for m >= 7: exact checks of the one-variable steps and the side conditions.

R48 working note, batches 9 and 10. With t = m - 7 >= 0 and S in [1/2, 1] written as S = 1/2 + v/2
(or S = 1/2 + v/6 on the chord branch [1/2, 2/3]), every polynomial below is expanded in the Bernstein
basis of v on [0, 1], and each Bernstein coefficient is a polynomial in t whose coefficients are all
of one sign. That proves the sign for every integer (indeed real) m >= 7 and every S in the interval.

  (b) d(s_o^2/D)/ds_o >= kappa_o on the line s_o = S^2/m (the numerator quartic in S);
  (c) Phi(S, S^2/m) <= c0 on the cubic branch: numerator = (positive)(2Sm - 2m + 1)^2 Q, Q >= 0;
  (c') Phi <= c0 on the chord branch of the concave envelope, S in [1/2, 2/3];
  side conditions: kappa_o <= kappa(n), c' < 1, c0-slope <= 1/sqrt2, beta(1/2) > 0, 1/2 < r1 < 1.

Everything is divided by sqrt(2), so all arithmetic is exact rational. /usr/bin/python3, about a minute.
"""
import sympy as sp

m, S, v, t, r, y = sp.symbols('m S v t r y')
r2 = sp.sqrt(2)
n = m - 1
lam = 3 * r2 * m / (2 * (2 * m - 1))
c0 = r2 * (2 * m - 1) * (4 * m - 1) / (8 * m ** 2)
to = r2 * (2 * m - 1) ** 2 / (4 * m * (2 * m - 3))
tn = r2 * (2 * m - 1) / (4 * (m - 1))
ko = sp.factor((2 * lam - 1 / to) / to)
al2 = (2 * m - 1) / (2 * m)
b0 = 2 * (n - 1) / n
cp = sp.factor(n ** 2 * ko / (2 * (n - 1) ** 2))


def bet(x):
    return b0 * (1 - cp * x)


pu = (2 * m - 1) / (2 * m ** 2)
bt0 = sp.factor(bet(pu) * 2 * m / (2 * m - 1))
c0w = to / 2 * bt0
k3 = (tn / al2) * ((m - 1) / m) ** 2 + c0w / m
B = to / (2 * n)

assert sp.simplify(ko - 4 * m ** 2 * (2 * m - 3) * (2 * m + 3) / (2 * m - 1) ** 4) == 0


def one_signed_in_t(expr):
    """+1 or -1 if the rational function has numerator and denominator one-signed as polynomials in t."""
    nu, de = sp.fraction(sp.factor(sp.together(expr)))
    sg = 1
    for part in (nu, de):
        cs = sp.Poly(sp.expand(part.subs(m, 7 + t)), t).all_coeffs()
        if all(c >= 0 for c in cs):
            continue
        if all(c <= 0 for c in cs):
            sg = -sg
            continue
        return 0
    return sg


def bernstein_sign(P, lo, hi):
    """+1 if every Bernstein coefficient of P(S) on [lo, hi] is a polynomial in t with non-negative coefficients."""
    Pv = sp.expand(P.subs({S: lo + (hi - lo) * v, m: 7 + t}))
    d = sp.degree(Pv, v)
    cs = [sp.expand(Pv.coeff(v, k)) for k in range(d + 1)]
    for j in range(d + 1):
        bj = sp.expand(sum(sp.binomial(j, k) / sp.binomial(d, k) * cs[k] for k in range(j + 1)))
        if not all(c >= 0 for c in sp.Poly(bj, t).all_coeffs()):
            return 0
    return 1


def sign_on(expr, lo, hi):
    """Sign of a rational function of (S, m) on S in [lo, hi], m >= 7, factor by factor."""
    nu, de = sp.fraction(sp.factor(sp.together(expr)))
    total = 1
    for part in (nu, de):
        const, facs = sp.factor_list(part)
        total *= sp.sign(const)
        for f, e in facs:
            if e % 2 == 0:
                continue
            if sp.degree(f, S) == 0:
                s = one_signed_in_t(f)
            else:
                s = bernstein_sign(f, lo, hi)
                if s == 0:
                    s = -bernstein_sign(-f, lo, hi)
            assert s != 0, f'undecided factor {f}'
            total *= s ** e
    return total


half, two3 = sp.Rational(1, 2), sp.Rational(2, 3)

# side conditions
kapn = 2 * m * (m - 2) ** 2 / (m - 1) ** 3
assert one_signed_in_t(kapn - ko) == 1, 'kappa_o <= kappa(n)'
assert one_signed_in_t(1 - cp) == 1, "c' < 1"
assert one_signed_in_t((1 / r2 - c0w) / r2) == 1, 'row-0 slope below Lemma A slope'
assert one_signed_in_t(bet(half)) == 1, 'beta(1/2) > 0'
print('side conditions: all hold for m >= 7')

# (b) the s_o-derivative on s_o = S^2/m
E = (S - y / S) / bet(y / S) + (1 - S) / bt0
dq = ((E - y * sp.diff(E, y)) / E ** 2 - ko).subs(y, S ** 2 / m)
assert sign_on(dq, half, 1) == 1
print('(b) d(s_o^2/D)/ds_o - kappa_o > 0 on s_o = S^2/m, S in [1/2, 1]')

# (c) the one-variable inequality, cubic branch
sig = (2 * S - 1) / S
rb = (1 - S) / S
Gu = 2 * sig * (1 - sig / n) ** 2
psit = to / 2 * Gu + tn * al2 * rb * sig ** 2 + B * b0 * sig ** 2
bS = bet(S / m)
rest = (-B * b0 * cp / m * (2 * S - 1) ** 2 - to / 2 * S ** 2 / (S * (m - 1) / bS + m * (1 - S) / bt0)
        + k3 * (1 - S) + (S ** 2 - S ** 2 / m) / (2 * to) + (1 - S) * S / tn + lam * S ** 2 / m - c0)
Phi1 = sp.together(sp.simplify((S * psit + rest) / r2))
Su = (2 * m - 1) / (2 * m)
assert sp.simplify(Phi1.subs(S, Su)) == 0
nu, de = sp.fraction(sp.factor(Phi1))
assert any(sp.expand(f - (2 * S * m - 2 * m + 1)) == 0 and e == 2 for f, e in sp.factor_list(nu)[1])
assert sign_on(Phi1, half, 1) == -1
print('(c) Phi(S, S^2/m) - c0 <= 0 on the cubic branch, double root at S = (2m-1)/(2m)')

# (c') chord branch: psi-tilde as a cubic in r, tangent at r1 through (1, 0)
sg = 1 - r
psir = sp.expand((to / 2 * 2 * sg * (1 - sg / n) ** 2 + tn * al2 * r * sg ** 2 + B * b0 * sg ** 2) / r2)
c3, c2 = psir.coeff(r, 3), psir.coeff(r, 2)
r1 = sp.factor((-c2 / c3 - 1) / 2)
assert sp.simplify(r1 - (2 * m ** 2 - 3 * m - 1) / (2 * (2 * m ** 2 - 5 * m + 1))) == 0
assert sp.simplify(psir.subs(r, 1)) == 0
assert sp.simplify(psir.subs(r, r1) + sp.diff(psir, r).subs(r, r1) * (1 - r1)) == 0
assert one_signed_in_t(c3) == 1 and one_signed_in_t(r1 - half) == 1 and one_signed_in_t(1 - r1) == 1
psilin = r2 * psir.subs(r, r1) * sig / (1 - r1)
Philin = sp.together(sp.simplify((S * psilin + rest) / r2))
assert sign_on(Philin, half, two3) == -1
print("(c') Phi <= c0 on the chord branch S in [1/2, 2/3]; r1 = (2m^2-3m-1)/(2(2m^2-5m+1)) in (1/2, 1)")
print('all checks passed')
