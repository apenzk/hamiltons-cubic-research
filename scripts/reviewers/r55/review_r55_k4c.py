"""Reviewer 55, K4c: exact closed form for the equal-block C_5 blow-up family,
and its m -> infinity limit."""
import sympy as sp

m, d, p, q, t = sp.symbols('m d p q t', positive=True)
d, p, q, t = sp.symbols('d p q t')
eqs = [
    (m-1)*d + 2*m*p + 2*m*q,
    (m-1)*d**2 + 2*m*(p**2+q**2) - t*d,
    p**2 + m*(2*p*q+q**2) + 2*(m-1)*d*p - t*p,
    q**2 + m*(p**2+2*p*q) + 2*(m-1)*d*q - t*q,
]
# scale-fix d = 1
sub = {d: 1}
E = [sp.expand(e.subs(sub)) for e in eqs]
sol = sp.solve(E, [p, q, t], dict=True)
print(f"{len(sol)} solution branches with d=1")
for s in sol:
    print("  p =", sp.simplify(s[p]), "  q =", sp.simplify(s[q]), "  t =", sp.simplify(s[t]))

# theta/theta_0 for a general C_5 blow-up with equal blocks m
def ratio_expr(pv, qv):
    n = 5*m
    # sum_{i != j} lam^3  and tr(lam^3), computed at block level
    # blocks: 5, each size m; C_aa = 1, C_adj = p, C_non = q
    C = sp.Matrix(5,5, lambda a,b: 1 if a==b else (pv if (a-b) % 5 in (1,4) else qv))
    nn = sp.Matrix(5,1, lambda a,_: m)
    S3 = sum(m*m*C[a,b]**3 for a in range(5) for b in range(5)) - sum(m*C[a,a]**3 for a in range(5))
    nrm2 = sp.Rational(1,2)*(sum(m*m*C[a,b]**2 for a in range(5) for b in range(5)) - sum(m*C[a,a]**2 for a in range(5)))
    trB3 = sum(m**3*C[a,b]*C[b,c]*C[c,a] for a in range(5) for b in range(5) for c in range(5))
    trB2D = sum(m*m*C[a,b]*C[b,a]*C[b,b] for a in range(5) for b in range(5))
    trBD2 = sum(m*C[a,a]**3 for a in range(5))
    trD3 = sum(m*C[a,a]**3 for a in range(5))
    trL3 = trB3 - 3*trB2D + 3*trBD2 - trD3
    P = sp.Rational(1,2)*(S3 + trL3)
    th = P/nrm2**sp.Rational(3,2)
    th0 = sp.sqrt(2*(5*m-1)*(5*m-2))/(5*m)
    return sp.simplify(th/th0)

for s in sol:
    pv, qv = sp.simplify(s[p]), sp.simplify(s[q])
    if pv.is_number and qv.is_number and pv == qv:
        print("  (degenerate branch p=q skipped)"); continue
    r = ratio_expr(pv, qv)
    print("\nbranch p =", pv, " q =", qv)
    print("  theta/theta_0(m) =", sp.simplify(r))
    for mv in (2,3,4,5,10,100):
        print(f"    m={mv}: {sp.N(r.subs(m,mv), 10)}")
    print("  limit m->oo :", sp.simplify(sp.limit(r, m, sp.oo)), "=", sp.N(sp.limit(r,m,sp.oo),12))
