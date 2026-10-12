import sympy as sp, itertools, random
random.seed(5)
def build(n, m, eps):
    n = sp.Integer(n); m = [sp.Integer(x) for x in m]; eps = [sp.Rational(x) for x in eps]
    cls = range(3)
    trip = sorted(set(tuple(sorted(t)) for t in itertools.product(cls, repeat=3)))
    tv = {t: sp.Symbol('t%d%d%d' % t) for t in trip}
    tau = lambda a, b, c: tv[tuple(sorted((a, b, c)))]           # tau_abc symmetric (ordered-triple sums)
    g12 = sp.Symbol('g12')
    E = lambda k: sum(m[a] * eps[a]**k for a in cls)
    s = [2 * (n - 1) * m[a] for a in cls]
    p, q = eps[1] - eps[0], eps[2] - eps[1]
    G = sp.zeros(3, 3)
    G[0, 1] = G[1, 0] = g12
    G[0, 2] = G[2, 0] = (-eps[0] * s[0] - p * g12) / (p + q)
    G[1, 2] = G[2, 1] = (-eps[1] * s[1] + p * g12) / q
    G[0, 0] = (s[0] * eps[2] - q * g12) / (p + q)
    G[1, 1] = (s[1] * eps[2] - (p + q) * g12) / q
    G[2, 2] = s[2] - G[0, 2] - G[1, 2]
    ric2 = sum(eps[a]**2 * eps[b]**2 * G[a, b] for a in cls for b in cls)
    m22 = sum(eps[a]**2 * eps[b]**2 * tau(a, b, c) for a in cls for b in cls for c in cls)
    m211 = sum(eps[a] * eps[b] * eps[c]**2 * tau(a, b, c) for a in cls for b in cls for c in cls)
    E2, E3, E4 = E(2), E(3), E(4)
    k = (n - 4) * (n - 5) / 9
    M = {(0,0): 0, (0,1): 12*E2, (0,2): 12*E3, (1,1): 12*E3 - 4*E2, (1,2): 4*ric2 - 4*m22 - 2*m211, (2,2): sp.Symbol('phi22')}
    O = {(0,0): 0, (0,1): k*E2, (0,2): k*E3, (1,1): (12*E3 - 4*E2)/9,
         (1,2): sp.Rational(4,9)*E4 + sp.Rational(2,9)*E2**2 - sp.Rational(2,9)*ric2 - sp.Rational(2,9)*m22 - sp.Rational(2,9)*m211,
         (2,2): sp.Symbol('om22')}
    sym = lambda D, i, j: D[(min(i,j), max(i,j))]
    def L(a):
        b, c = [x for x in cls if x != a]
        l = 1 / ((eps[a] - eps[b]) * (eps[a] - eps[c]))
        return [l * eps[b] * eps[c], -l * (eps[b] + eps[c]), l]
    def F(D, a, b):
        return sum(L(a)[i] * L(b)[j] * sym(D, i, j) for i in range(3) for j in range(3))
    def S(a, b):
        tab = sum(tau(a, b, c) for c in cls)
        U = sp.Rational(1,4) * m[a] * m[b] * (eps[a] + eps[b]) - sp.Rational(1,4) * sum(eps[c] * tau(a, b, c) for c in cls)
        N = sp.Rational(1,2) * m[a] * m[b] - (G[a, b] - tab / 2) / (n - 2) - (m[a] * m[b] - G[a, b]) / 6
        return U - F(M, a, b) / (8 * (n - 2)) - sp.Rational(3,8) * F(O, a, b) - N / 2
    I1 = sp.expand(p * S(0, 1) + (p + q) * S(0, 2))
    rows = []
    for a in cls:
        rows.append(sum(tau(a, b, c) for b in cls for c in cls) - 2 * (n - 2) * m[a])
        rows.append(sum(tau(a, b, c) * eps[b] for b in cls for c in cls) + 2 * m[a] * eps[a])
        rows.append(sum(tau(a, b, c) * eps[b] * eps[c] for b in cls for c in cls) - 2 * m[a] * eps[a] * (1 - eps[a]))
    return I1, rows, list(tv.values()), g12
for trial in range(4):
    n = random.choice([6, 7, 8, 9, 10])
    m1, m2 = random.randint(3, 8), random.randint(3, 8); N = n * (n - 1) // 2; m3 = N - m1 - m2
    e1 = sp.Rational(-random.randint(2, 9), 10); e2 = sp.Rational(random.randint(-9, 9), 37)
    e3 = -(m1 * e1 + m2 * e2) / m3            # traceless
    if not (e1 < e2 < e3): continue
    I1, rows, tvars, g12 = build(n, [m1, m2, m3], [e1, e2, e3])
    lam = sp.symbols('l0:9')
    resid = sp.expand(I1 - sum(l * r for l, r in zip(lam, rows)))
    eqs = [sp.expand(resid).coeff(t) for t in tvars]
    sol = sp.solve(eqs, lam, dict=True)
    print(f"n={n} m=({m1},{m2},{m3}) eps=({e1},{e2},{e3}): tau-part of I1 in the row span? {'YES' if sol else 'NO'};",
          f"G12 coefficient {sp.nsimplify(sp.expand(I1).coeff(g12))}")
