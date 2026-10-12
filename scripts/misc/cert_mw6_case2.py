"""MW' at m = 6, case 2 of the pi-only step: exact Bernstein certificate.

J1 working note, batch 13. At n = 5, kappa = 192/125, pi* = 25/96, the row slope is
beta* = max(8/5 - 48/25 pi, 3/2 - kappa pi). When some pi_i > pi*, Titu's form and the concave
tangent of each linear piece at its cluster's weighted mean reduce the step to
    N(S, u, v) = s^2 l1(u) l2(v) - [(1-S)(s-u^2) l2(v) + S(s-v^2) l1(u)] W >= 0,
    s = (1-S)u + S v,  W = (1-S) l1(u) + S l2(v) - kappa (1 - 2s),
on the box S in [pi*, 1], u in [0, pi*], v in [pi*, 1/2]. This script subdivides the box until every
Bernstein coefficient (degree (3, 3, 3), exact rationals) is non-negative, and asserts it.
It also checks the three factorisations of the row inequality at pi* (batch 12).
/usr/bin/python3, about a minute.
"""
import sympy as sp

a, b, c, x = sp.symbols('a b c x')
k = sp.Rational(192, 125)
ps = sp.Rational(25, 96)
half = sp.Rational(1, 2)


def poly_on(al, ah, bl, bh, cl, ch):
    A = al + (ah - al) * a
    Bv = bl + (bh - bl) * b
    C = cl + (ch - cl) * c
    S2 = ps + (1 - ps) * A
    S1 = 1 - S2
    m1 = ps * Bv
    m2 = ps + (half - ps) * C
    l1 = sp.Rational(8, 5) - sp.Rational(48, 25) * m1
    l2 = sp.Rational(3, 2) - k * m2
    s = S1 * m1 + S2 * m2
    W = S1 * l1 + S2 * l2 - k * (1 - 2 * s)
    return sp.Poly(sp.expand(s**2 * l1 * l2 - (S1 * (s - m1**2) * l2 + S2 * (s - m2**2) * l1) * W), a, b, c)


def bernstein(P, d=(3, 3, 3)):
    coef = dict(P.terms())
    out = []
    for i in range(d[0] + 1):
        for j in range(d[1] + 1):
            for l in range(d[2] + 1):
                tot = 0
                for (p, q, r), val in coef.items():
                    if p <= i and q <= j and r <= l:
                        tot += val * sp.binomial(i, p) * sp.binomial(j, q) * sp.binomial(l, r) / (
                            sp.binomial(d[0], p) * sp.binomial(d[1], q) * sp.binomial(d[2], r))
                out.append(tot)
    return out


def certify():
    # Exact rational box corners: plain `(al + ah) / 2` on Python ints gives floats, which made the
    # certificate a floating-point one and split boxes whose exact Bernstein coefficients are zero.
    zero, one = sp.Integer(0), sp.Integer(1)
    todo = [(zero, one, zero, one, zero, one)]
    done = []
    while todo:
        new = []
        for box in todo:
            P = poly_on(*box)
            assert max(P.degree(a), P.degree(b), P.degree(c)) <= 3
            assert all(isinstance(t, sp.Rational) for t in P.coeffs()), 'coefficients must be exact rationals'
            if min(bernstein(P)) >= 0:
                done.append(box)
                continue
            al, ah, bl, bh, cl, ch = box
            for x0, x1 in [(al, (al + ah) / 2), ((al + ah) / 2, ah)]:
                for y0, y1 in [(bl, (bl + bh) / 2), ((bl + bh) / 2, bh)]:
                    for z0, z1 in [(cl, (cl + ch) / 2), ((cl + ch) / 2, ch)]:
                        new.append((x0, x1, y0, y1, z0, z1))
        todo = new
        assert len(done) + len(todo) < 5000
    return done


def row_check():
    cc = sp.Rational(2, 5)
    A = -half
    psiL = lambda z: z * (1 - z) * (1 - 2 * z + A) - cc * z**2
    psih = lambda z: z * (1 - z) * A + (1 - z)**2 * (1 - 2 * z)**2 / (4 * cc)
    psib = lambda z: z * (1 - z) * A
    y = (1 - x) / 4
    assert sp.expand(psiL(x) + 4 * psiL(y) - (3 * x - 4) * (5 * x - 1)**2 / 40) == 0
    assert sp.expand(psih(x) + 4 * psiL(y) - (x - 1)**2 * (100 * x**2 - 105 * x + 21) / 40) == 0
    assert sp.expand(psib(x) + 4 * psiL(y) + (x - 1)**2 * (5 * x + 4) / 40) == 0


if __name__ == '__main__':
    row_check()
    boxes = certify()
    print(f'row check at pi*: three factorisations exact')
    print(f'case 2: N >= 0 on the box, certified on {len(boxes)} sub-boxes, every Bernstein coefficient >= 0')
