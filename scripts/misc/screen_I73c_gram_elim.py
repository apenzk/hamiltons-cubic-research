"""I73 (c) section 7: exact sympy check of the G12 elimination across L235's two inequalities.

The Gram null direction dG = -z z^T/(q(p+q)), d|Ric e^2|^2/dG12 = -p^2 q (p+q), the vanishing G-sums on
both weight vectors, and that p*w1 + q*w2 = (p^2, (p+q)^2, q^2) kills both M22 and G12.  The M12 coefficient
printed here is doubled by the symmetrisation over (a,b) and (b,a); ratios and zeros are unaffected.  Seconds.
"""
import sympy as sp
e1, p, q, n, g, s1, s2, s3 = sp.symbols('e1 p q n g s1 s2 s3')
e2, e3 = e1 + p, e1 + p + q
eps = [e1, e2, e3]
# Gram with section 3's six equations, G12 = g free (s_a = 2(n-1) m_a, sum s_a eps_a = 0 imposed via s3)
G = sp.Matrix(3, 3, sp.symbols('G11 G12 G13 G12 G22 G23 G13 G23 G33'))
eqs = []
for a in range(3):
    eqs += [sum(G[a, b] for b in range(3)) - [s1, s2, s3][a], sum(eps[b] * G[a, b] for b in range(3))]
sol = sp.solve(eqs[:-1] + [G[0, 1] - g], list(set(G)), dict=True)[0]
Gs = G.subs(sol).subs(s3, -(e1 * s1 + e2 * s2) / e3)
Gs = sp.simplify(Gs)
dG = sp.simplify(Gs.diff(g))
z = sp.Matrix([e2 - e3, e3 - e1, e1 - e2])
print("dG == -z z^T/(q(p+q)):", sp.simplify(dG + z * z.T / (q * (p + q))) == sp.zeros(3))
dRic = sp.simplify(sum(eps[a] ** 2 * eps[b] ** 2 * dG[a, b] for a in range(3) for b in range(3)))
print("d|Ric e^2|^2/dg =", sp.factor(dRic))
def lead(a):
    o = [x for x in range(3) if x != a]; return 1 / ((eps[a] - eps[o[0]]) * (eps[a] - eps[o[1]]))
def Lvec(a):
    o = [x for x in range(3) if x != a]; l = lead(a)
    return [l * eps[o[0]] * eps[o[1]], -l * (eps[o[0]] + eps[o[1]]), l]
c = (n - 8) / (12 * (n - 2))
for name, w in (("w1=(p,p+q,0)", {(0, 1): p, (0, 2): p + q, (1, 2): 0}), ("w2=(0,p+q,q)", {(0, 1): 0, (0, 2): p + q, (1, 2): q}),
                ("p*w1+q*w2", {(0, 1): p * p, (0, 2): (p + q) ** 2, (1, 2): q * q})):
    C = lambda i, j: sum(wab * (Lvec(a)[i] * Lvec(b)[j] + Lvec(b)[i] * Lvec(a)[j]) for (a, b), wab in w.items())
    c22 = sp.simplify(C(2, 2)); c12 = sp.simplify(C(1, 2) + C(2, 1))
    dGsum = sp.simplify(sum(wab * dG[a, b] for (a, b), wab in w.items()))
    kappa = sp.factor(c * (c12 * dRic) - c * dGsum)
    print(f"{name}: M22 coeff {c22}, M12+M21 coeff {sp.factor(c12)}, sum w dG {dGsum}, G12 coefficient {kappa}")
