"""Screen: is the three-value class-level system (rows A-C, tau >= 0, pair caps, Gram interval incl.
G_ab >= tau_ab/2 and Cauchy-Schwarz, and L235's window Gamma/p <= I1 <= 0) feasible at spectra with
theta above sqrt(3/2)?  A handful of spectra, seconds each."""
import sympy as sp, itertools, random, numpy as np
from scipy.optimize import linprog
exec(open(__file__.rsplit('/', 1)[0] + '/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0])
def lp_at(n, m, eps_raw, theta):
    m = list(m)
    e = np.array(eps_raw, float); e = e - np.dot(m, e) / sum(m)                  # traceless
    e = e / np.sqrt(np.dot(m, e**2)) / theta                                    # E2 = 1/theta^2
    eps = [sp.Rational(x).limit_denominator(10**9) for x in e]
    I1, rows, tvars, g12 = build(n, m, eps)
    # rebuild G and tau pieces for the interval constraints
    cls = range(3); s = [2*(n-1)*m[a] for a in cls]; p, q = eps[1]-eps[0], eps[2]-eps[1]
    G = sp.zeros(3,3); G[0,1]=G[1,0]=g12
    G[0,2]=G[2,0]=(-eps[0]*s[0]-p*g12)/(p+q); G[1,2]=G[2,1]=(-eps[1]*s[1]+p*g12)/q
    G[0,0]=(s[0]*eps[2]-q*g12)/(p+q); G[1,1]=(s[1]*eps[2]-(p+q)*g12)/q; G[2,2]=s[2]-G[0,2]-G[1,2]
    tv = {tuple(int(c) for c in str(t)[1:]): t for t in tvars}
    tau = lambda a,b,c: tv[tuple(sorted((a,b,c)))]
    Nabc = lambda a,b,c: m[a]*(m[b]-(a==b))*(m[c]-(a==c)-(b==c))
    X = list(tvars) + [g12]
    ineq = []                                                                    # expressions required <= 0
    for a in cls:
        for b in cls:
            if a <= b:
                ineq.append(sum((m[c]-(a==c)-(b==c)) * tau(a,b,c)/Nabc(a,b,c) for c in cls if Nabc(a,b,c) > 0) - 2)
    for a in cls:
        for b in cls:
            if a < b:
                ineq += [sum(tau(a,b,c) for c in cls)/2 - G[a,b], G[a,b] - m[a]*m[b], -G[a,b]]
                ineq.append(sp.expand(G[a,b]**2 - G[a,a]*G[b,b]))             # affine in g12
        ineq.append(sp.Rational(4*m[a]**2, n) - G[a,a])
    E2 = sum(m[a]*eps[a]**2 for a in cls); E3 = sum(m[a]*eps[a]**3 for a in cls)
    Gam = sp.Rational(n+4,12)*((n-1)*E3-(n-3)*E2)
    base_ineq = list(ineq)
    ineq += [I1, Gam/p - I1]
    def mat(exprs):
        A = np.array([[float(sp.expand(ex).coeff(x)) for x in X] for ex in exprs])
        b = np.array([-float(sp.expand(ex).subs({x: 0 for x in X})) for ex in exprs])
        return A, b
    Aeq, beq = mat(rows)
    bounds = [(0, None)]*len(tvars) + [(None, None)]
    res = {}
    for label, iq in (("without the window", base_ineq), ("with L235's window", ineq)):
        Aub, bub = mat(iq)
        r = linprog(np.zeros(len(X)), A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
        res[label] = r.status == 0
    Aub, bub = mat(base_ineq)
    cI = np.array([float(sp.expand(I1).coeff(x)) for x in X]); c0 = float(sp.expand(I1).subs({x:0 for x in X}))
    lo = linprog(cI, A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
    hi = linprog(-cI, A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
    rng_ = (lo.fun + c0, -hi.fun + c0) if lo.status == 0 and hi.status == 0 else None
    return [float(x) for x in e], res, rng_, float(Gam/p)
random.seed(3)
for n in (8, 6, 10):
    N = n*(n-1)//2; cnt = 0
    while cnt < 3:
        m1, m2 = random.randint(3, N//2), random.randint(3, N//2); m3 = N - m1 - m2
        if m3 < 3: continue
        raw = sorted(random.uniform(-1, 1) for _ in range(3))
        for theta in (1.25, 1.45):
            e, res, rng_, lowwin = lp_at(n, (m1, m2, m3), raw, theta)
            if not (e[0] < e[1] < e[2]): continue
            print(f"n={n} m=({m1},{m2},{m3}) theta={theta} eps=({e[0]:+.3f},{e[1]:+.3f},{e[2]:+.3f}): "
                  f"feasible {res}; I1 range {None if rng_ is None else tuple(round(v,3) for v in rng_)} vs window [{lowwin:.3f}, 0]")
        cnt += 1
