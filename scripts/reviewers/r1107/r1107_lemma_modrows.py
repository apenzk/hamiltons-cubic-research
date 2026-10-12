import sympy as sp, random, sys
src = open('scripts/misc/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0]
# expose S by returning it: patch build to also return S, G
src = src.replace("return I1, rows, list(tv.values()), g12", "return I1, rows, list(tv.values()), g12, S, p, q, E")
exec(src)
def reduce_mod_rows(expr, rows, tv, free):
    others = [t for t in tv if t not in free]
    sol = sp.solve(rows, others, dict=True)
    assert sol, "rows inconsistent / not solvable for chosen pivots"
    return sp.expand(expr.subs(sol[0]))
random.seed(11)
def spec(n):
    N=n*(n-1)//2
    while True:
        m1,m2=random.randint(3,N//2),random.randint(3,N//2); m3=N-m1-m2
        if m3<3: continue
        e1=sp.Rational(-random.randint(2,9),10); e2=sp.Rational(random.randint(-9,9),37)
        e3=-(m1*e1+m2*e2)/m3
        if e1<e2<e3: return [m1,m2,m3],[e1,e2,e3]
for n in (6,7,8,9,10):
    m,eps=spec(n)
    I1,rows,tv,g12,S,p,q,E=build(n,m,eps)
    I2=sp.expand(q*S(1,2)+(p+q)*S(0,2))
    Gam=sp.Rational(n+4,12)*((n-1)*E(3)-(n-3)*E(2))
    tvd={str(t):t for t in tv}
    free=[tvd['t012'],tvd['t000'],tvd['t222']]
    comb=reduce_mod_rows(p*I1+q*I2-Gam,rows,tv,free)
    red=reduce_mod_rows(I1,rows,tv,free)
    print(n,m,eps,"pI1+qI2-Gamma mod rows:",sp.simplify(comb),"| I1 mod rows coeffs free:",[sp.nsimplify(red.coeff(f)) for f in free],"g12:",red.coeff(g12), "phi22/om22 present:", red.has(sp.Symbol('phi22')) or red.has(sp.Symbol('om22')))
