# I73 (c), off L173's ray: an EXACT rational point of the capped three-value class system above sqrt(3/2) at n=12.
# System: per-index rows, tau >= 0, pair caps, Ky Fan caps, the Gram constraints, L235's window, section 5's
# per-pair inequalities, and L240's seven-frame cap over every composition. Spectrum e = (-1/5, 0, 1/5),
# multiplicities (7, 52, 7), theta = 5/sqrt(14). Usage: python3 verify_I73c_offray_witness.py [G12, default 77] [T7, default 54064/1000]; a negative max-min-slack is a floating-point infeasibility screen. Verification in exact rational arithmetic; the LP only proposes the point.
import sys, itertools, numpy as np, sympy as sp
from scipy.optimize import linprog
here = __file__.rsplit('/', 1)[0]
exec(open(here + '/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0])
R = sp.Rational
KAPPA = {1: 2, 2: 4, 3: 6, 4: 6, 5: 8, 6: 8}      # L31, L237 (odd r bounded by the next even one)
def exprs(n, m, eps, T7, mu):
    I1, rows, tvars, g12 = build(n, m, eps)
    cls = range(3); s = [2*(n-1)*m[a] for a in cls]; p, q = eps[1]-eps[0], eps[2]-eps[1]
    G = sp.zeros(3,3); G[0,1]=G[1,0]=g12
    G[0,2]=G[2,0]=(-eps[0]*s[0]-p*g12)/(p+q); G[1,2]=G[2,1]=(-eps[1]*s[1]+p*g12)/q
    G[0,0]=(s[0]*eps[2]-q*g12)/(p+q); G[1,1]=(s[1]*eps[2]-(p+q)*g12)/q; G[2,2]=s[2]-G[0,2]-G[1,2]
    tv = {tuple(int(ch) for ch in str(t)[1:]): t for t in tvars}
    tau = lambda a,b,c: tv[tuple(sorted((a,b,c)))]
    Nabc = lambda a,b,c: m[a]*(m[b]-(a==b))*(m[c]-(a==c)-(b==c))
    t = lambda a,b,c: tau(a,b,c)/Nabc(a,b,c) if Nabc(a,b,c) > 0 else 0
    P = lambda a,b: sum((m[c]-(a==c)-(b==c))*t(a,b,c) for c in cls)
    ineq = [(f'pair cap {a}{b}', P(a,b)-2) for a in cls for b in cls if a <= b]
    for a in cls:
        for r in itertools.product(*[range(0, min(6, m[b]-(a==b))+1) for b in cls]):
            if 2 <= sum(r) <= 6:
                ineq.append((f'Ky Fan {a} {r}', sum(r[b]*P(a,b) for b in cls) - KAPPA[sum(r)]))
    for k in itertools.product(range(8), repeat=3):
        if sum(k) == 7 and all(k[a] <= m[a] for a in cls):
            ineq.append((f'seven-frame {k}', sum(k[a]*(k[a]-1)*P(a,a) for a in cls) + 2*sum(k[a]*k[b]*P(a,b) for a in cls for b in cls if a < b) - T7))
    for a in cls:
        for b in cls:
            if a < b:
                tab = sum(tau(a,b,c) for c in cls)
                ineq += [(f'G{a}{b} >= tau/2', tab/2 - G[a,b]), (f'G{a}{b} <= mm', G[a,b]-m[a]*m[b]), (f'G{a}{b} >= 0', -G[a,b]),
                         (f'G{a}{b} Cauchy-Schwarz', sp.expand(G[a,b]**2 - G[a,a]*G[b,b]))]
                lhs = R(1,4)*m[a]*m[b]*(eps[a]+eps[b]-1) - R(1,4)*sum(eps[c]*tau(a,b,c) for c in cls)
                rhs = (mu-1)/(2*(n-2))*(G[a,b]-tab/2) + (3*max(eps)-R(1,2))*(m[a]*m[b]-G[a,b])/6
                ineq.append((f'section 5 pair {a}{b}', lhs - rhs))
        ineq.append((f'G{a}{a} >= 4m^2/n', R(4*m[a]**2, n) - G[a,a]))
        ineq.append((f'G{a}{a} >= tau_aa/2', sum(tau(a,a,c) for c in cls)/2 - G[a,a]))
    E2 = sum(m[a]*eps[a]**2 for a in cls); E3 = sum(m[a]*eps[a]**3 for a in cls)
    Gam = R(n+4,12)*((n-1)*E3-(n-3)*E2)
    ineq += [('window I1 <= 0', I1), ('window I1 >= Gamma/p', Gam/p - I1)]
    ineq += [('G psd, 2x2 minors', -sp.expand(G[0,0]*G[1,1]-G[0,1]**2)), ('G psd, det', -sp.expand(G.det()))]
    return list(tvars) + [g12], [sp.expand(e) for _, e in ineq], [nm for nm, _ in ineq], [sp.expand(r) for r in rows], len(tvars)
# arguments: [G12|free] [T7] [m0,m1,m2] [e0,e1,e2] (rationals), defaulting to L241's point
arg = lambda k, d: sys.argv[k] if len(sys.argv) > k else d
n = 12
m = [int(x) for x in arg(3, '7,52,7').split(',')]
eps = [R(x) for x in arg(4, '-1/5,0,1/5').split(',')]
assert sum(m) == n*(n-1)//2 and sum(mi*e for mi, e in zip(m, eps)) == 0
# theta from sum m e^2 = 1/theta^2: 14/25 = 1/theta^2, theta = 5/sqrt(14) > sqrt(3/2) since 25/14 > 3/2
E2v = sum(mi*e**2 for mi, e in zip(m, eps)); assert 1/E2v > R(3,2), 'theta^2 = 1/sum m e^2 must exceed 3/2'
print('theta^2 =', 1/E2v, float(1/E2v))
# mu-ring <= n Theta_n / ((n-1) theta) with Theta_12 = sqrt(220)/12: the bound is sqrt(220*14)/55 = sqrt(3080)/55.
# Section 5 is looser for larger mu (its coefficient multiplies G_ab - tau_ab/2 >= 0), so a point satisfying it at a
# rational mu BELOW the cap satisfies it at the cap: mu = 55/55 + ... chosen with mu^2 * 55^2 <= 3080 checked exactly.
# mu below the cap n Theta_12 / ((n-1) theta), Theta_12 = sqrt(220)/12: cap^2 = 220 / (121 E2v^-1) = 220 E2v / 121
cap2 = R(220)*E2v/121
# section 5 is looser for larger mu, so any rational mu at or below the cap gives a valid, stronger check
mu = R(0); step = R(1, 1000)
while (mu + step)**2 <= cap2: mu += step
assert mu**2 <= cap2
print('mu used', mu, 'cap', float(cap2)**0.5)
T7 = R(arg(2, '54064/1000'))
X, ineq, names, rows, nt = exprs(n, m, eps, T7, mu)
# fix the isotropy parameter inside its feasible interval, away from the G_02 <= m_0 m_2 boundary
G12a = arg(1, '77')
if G12a != 'free': rows = rows + [X[-1] - R(G12a)]
f = lambda e: (np.array([float(e.coeff(x)) for x in X]), -float(e.subs({x: 0 for x in X})))
A = np.array([f(e)[0] for e in ineq]); b = np.array([f(e)[1] for e in ineq])
Ae = np.array([f(e)[0] for e in rows]); be = np.array([f(e)[1] for e in rows])
k = len(X)
# the Cauchy-Schwarz rows are quadratic in g12; the LP linearises nothing, so fix g12 first from the float LP, then treat as data
quad = [i for i, e in enumerate(ineq) if sp.Poly(e, *X).total_degree() > 1]
lin = [i for i in range(len(ineq)) if i not in quad]
r = linprog(np.r_[np.zeros(k), -1], A_ub=np.vstack([np.hstack([A[lin], np.ones((len(lin),1))]), np.hstack([-np.eye(k)[:nt], np.ones((nt,1))])]),
            b_ub=np.r_[b[lin], np.zeros(nt)], A_eq=np.hstack([Ae, np.zeros((len(Ae),1))]), b_eq=be,
            bounds=[(None,None)]*k + [(None,1)], method='highs')
print('LP (linear part), max min-slack:', r.status, -r.fun)
xr = sp.Matrix([R(v).limit_denominator(10**4) for v in r.x[:k]])
Aem = sp.Matrix([[e.coeff(x) for x in X] for e in rows]); bem = sp.Matrix([-e.subs({x: 0 for x in X}) for e in rows])
xe = xr - Aem.T*(Aem*Aem.T).pinv()*(Aem*xr - bem)
sub = {x: xe[i] for i, x in enumerate(X)}
eq_ok = all(sp.simplify(e.subs(sub)) == 0 for e in rows)
vals = [e.subs(sub) for e in ineq]
bad = [(nm, v) for nm, v in zip(names, vals) if v > 0]
tau_ok = all(xe[i] >= 0 for i in range(nt))
print('rows exact:', eq_ok, '| tau >= 0 exact:', tau_ok, '| inequalities violated:', len(bad), 'of', len(vals))
for nm, v in bad[:5]: print('  VIOLATED', nm, v)
tight = sorted(zip(vals, names), key=lambda z: -z[0])[:6]
print('tightest:', [(nm, float(v)) for v, nm in tight])
print('point:', {str(x): xe[i] for i, x in enumerate(X)})
if not (eq_ok and tau_ok and not bad): sys.exit('NOT A WITNESS')
print('WITNESS: exact rational point of the full capped system at theta^2 =', 1/E2v, '> 3/2, n = 12, m =', m, 'e =', eps)
