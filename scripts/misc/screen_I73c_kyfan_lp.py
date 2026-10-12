import sympy as sp, itertools, numpy as np
from scipy.optimize import linprog
exec(open(__file__.rsplit('/', 1)[0] + '/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0])
KAPPA = {1: 4, 2: 4, 3: 6, 4: 6, 5: 8, 6: 8}      # proved kappa_2,4,6; odd r bounded by the next even one
KAPPA[1] = 2                                      # the pair cap
def system(n, m, eps, kyfan=True, window=True):
    I1, rows, tvars, g12 = build(n, m, eps)
    cls = range(3); s = [2*(n-1)*m[a] for a in cls]; p, q = eps[1]-eps[0], eps[2]-eps[1]
    G = sp.zeros(3,3); G[0,1]=G[1,0]=g12
    G[0,2]=G[2,0]=(-eps[0]*s[0]-p*g12)/(p+q); G[1,2]=G[2,1]=(-eps[1]*s[1]+p*g12)/q
    G[0,0]=(s[0]*eps[2]-q*g12)/(p+q); G[1,1]=(s[1]*eps[2]-(p+q)*g12)/q; G[2,2]=s[2]-G[0,2]-G[1,2]
    tv = {tuple(int(ch) for ch in str(t)[1:]): t for t in tvars}
    tau = lambda a,b,c: tv[tuple(sorted((a,b,c)))]
    Nabc = lambda a,b,c: m[a]*(m[b]-(a==b))*(m[c]-(a==c)-(b==c))
    t = lambda a,b,c: tau(a,b,c)/Nabc(a,b,c) if Nabc(a,b,c) > 0 else 0
    P = lambda a,b: sum((m[c]-(a==c)-(b==c))*t(a,b,c) for c in cls)   # per-pair bracket sum ||[x_i,x_j]||^2
    ineq = [P(a,b) - 2 for a in cls for b in cls if a <= b]
    if kyfan:
        for a in cls:
            for r in itertools.product(*[range(0, min(6, m[b]-(a==b))+1) for b in cls]):
                R = sum(r)
                if 2 <= R <= 6:
                    ineq.append(sum(r[b]*P(a,b) for b in cls) - KAPPA[R])
    for a in cls:
        for b in cls:
            if a < b:
                ineq += [sum(tau(a,b,c) for c in cls)/2 - G[a,b], G[a,b]-m[a]*m[b], -G[a,b], sp.expand(G[a,b]**2-G[a,a]*G[b,b])]
        ineq.append(sp.Rational(4*m[a]**2, n) - G[a,a])
    if window:
        E2 = sum(m[a]*eps[a]**2 for a in cls); E3 = sum(m[a]*eps[a]**3 for a in cls)
        Gam = sp.Rational(n+4,12)*((n-1)*E3-(n-3)*E2); ineq += [I1, Gam/p - I1]
    X = list(tvars) + [g12]
    mat = lambda ex: (np.array([[float(sp.expand(e).coeff(x)) for x in X] for e in ex]),
                      np.array([-float(sp.expand(e).subs({x: 0 for x in X})) for e in ex]))
    Aeq, beq = mat(rows); Aub, bub = mat(ineq)
    bounds = [(0, None)]*len(tvars) + [(None, None)]
    r = linprog(np.zeros(len(X)), A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
    return r.status == 0
R = sp.Rational
n, m = 12, [4, 59, 3]
print("L173 witness spectrum, theta = sqrt(21)/2:",
      "feasible without Ky Fan caps:", system(n, m, [R(-1,7), R(0), R(4,21)], kyfan=False),
      "| with:", system(n, m, [R(-1,7), R(0), R(4,21)], kyfan=True))
for n, m in ((12, [4, 59, 3]), (10, [4, 38, 3]), (8, [4, 21, 3])):
    line = []
    for th in (1.23, 1.3, 1.5, 1.8, 2.0, 2.29):
        d = np.array([-1.0, 0.0, 4/3]); d = d / np.sqrt(np.dot(m, d**2)) / th
        eps = [R(x).limit_denominator(10**9) for x in d]
        line.append(f"{th}: {'F' if system(n, m, eps, kyfan=False) else '-'}/{'F' if system(n, m, eps, kyfan=True) else '-'}")
    print(f"n={n} m={tuple(m)} along L173's ray, theta: without/with Ky Fan caps  ", "  ".join(line))
