"""K4: the C_5 blow-up with equal blocks of size m, solved symbolically in m."""
import sympy as sp

m, p, q = sp.symbols('m p q', positive=True)
d = sp.symbols('d')

def system(k, deg, m):
    """equal blocks of size m on a strongly-regular triangle-free graph:
       C_5 = srg(5,2,0,1) -> k=5, deg=2 ; Petersen = srg(10,3,0,1) -> k=10, deg=3.
       For srg(k, r, 0, mu) with mu=1: for an ADJACENT pair (a,b) the other k-2
       blocks split as: lambda=0 common neighbours, (r-1) adjacent-to-a-only,
       (r-1) adjacent-to-b-only, rest non-adjacent to both.
       For a NON-ADJACENT pair: mu common neighbours, (r-mu) adj-to-a-only,
       (r-mu) adj-to-b-only, rest non-adjacent to both."""
    return None

def c5_general(k, r, lam, mu, m):
    """srg(k,r,lam,mu) blow-up with equal blocks of size m; entries d, p (adjacent),
    q (non-adjacent).  Returns Ricci, Q_d, Q_p, Q_q, |W|^2, P as sympy exprs."""
    dd, pp, qq = sp.symbols('dd pp qq')
    Ric = (m - 1) * dd + r * m * pp + (k - 1 - r) * m * qq
    Q_d = (m - 1) * dd**2 + r * m * pp**2 + (k - 1 - r) * m * qq**2
    # adjacent pair a~b: c=a gives (m-1) d p ; c=b gives (m-1) p d ;
    # lam common neighbours: p*p ; (r-1-lam) adj-a-only: p*q ; (r-1-lam) adj-b-only: q*p ;
    # rest k-2-lam-2(r-1-lam) = k-2r+lam non-adjacent to both: q*q
    n_bothadj = lam
    n_aonly = r - 1 - lam
    n_bonly = r - 1 - lam
    n_none = k - 2 - n_bothadj - n_aonly - n_bonly
    Q_p = pp**2 + 2*(m-1)*dd*pp + m*(n_bothadj*pp*pp + (n_aonly+n_bonly)*pp*qq + n_none*qq*qq)
    # non-adjacent pair a,b: mu common neighbours p*p ; (r-mu) adj-a-only p*q ;
    # (r-mu) adj-b-only q*p ; rest non-adj to both q*q
    m_both = mu
    m_aonly = r - mu
    m_bonly = r - mu
    m_none = k - 2 - m_both - m_aonly - m_bonly
    Q_q = qq**2 + 2*(m-1)*dd*qq + m*(m_both*pp*pp + (m_aonly+m_bonly)*pp*qq + m_none*qq*qq)
    E_adj = sp.Rational(k*r, 2)
    E_non = sp.Rational(k*(k-1-r), 2)
    nsq = k*sp.binomial(m,2)*dd**2 + E_adj*m**2*pp**2 + E_non*m**2*qq**2
    Praw = k*sp.binomial(m,2)*dd*Q_d + E_adj*m**2*pp*Q_p + E_non*m**2*qq*Q_q
    return dd, pp, qq, Ric, Q_d, Q_p, Q_q, nsq, Praw

def solve_srg(k, r, lam, mu, mval, verbose=True):
    dd, pp, qq, Ric, Q_d, Q_p, Q_q, nsq, Praw = c5_general(k, r, lam, mu, sp.Integer(mval))
    Ric_ = Ric.subs(sp.Symbol('m'), mval)
    dsol = sp.solve(sp.Eq(Ric, 0), dd)[0]
    sub = {dd: dsol}
    e1 = sp.expand((Q_d.subs(sub)*pp - Q_p.subs(sub)*dsol))
    e2 = sp.expand((Q_p.subs(sub)*qq - Q_q.subs(sub)*pp))
    # set qq = 1
    e1q = sp.simplify(e1.subs(qq, 1)); e2q = sp.simplify(e2.subs(qq, 1))
    r1 = sp.Poly(e1q, pp); r2 = sp.Poly(e2q, pp)
    g = sp.gcd(r1, r2)
    roots = sp.solve(sp.Eq(g.as_expr(), 0), pp) if g.degree() > 0 else []
    out = []
    n = k*mval
    th0 = sp.sqrt(2*(n-1)*(n-2))/n
    for rt in roots:
        if not rt.is_real:
            continue
        pv = sp.nsimplify(rt); qv = sp.Integer(1); dv = dsol.subs({pp: pv, qq: 1})
        ns = nsq.subs({dd: dv, pp: pv, qq: qv})
        pr = Praw.subs({dd: dv, pp: pv, qq: qv})
        if ns == 0: continue
        th = pr / ns**sp.Rational(3,2)
        thf = float(th)
        if thf < 0:
            thf = -thf
        out.append((dv, pv, qv, thf, thf/float(th0)))
    return out, float(th0), dsol

if __name__ == "__main__":
    print("C_5 = srg(5,2,0,1) blow-ups, equal blocks of size m")
    print(f"{'m':>4} {'n':>4} {'d:p:q (scaled)':>34} {'theta':>12} {'theta_0':>10} {'ratio':>10} {'tri-free?':>10}")
    for mval in [2,3,4,5,6,8,10,15,20,30,50,100,200,500,1000]:
        out, th0, _ = solve_srg(5,2,0,1,mval)
        for dv,pv,qv,th,ratio in sorted(out, key=lambda t:-t[4]):
            # negative graph triangle-free?  need p<0 (edges = C_5 blow-up, triangle-free)
            # and d>=0, q>=0.  If q<0 the negative graph gains the complement -> triangles.
            dvf, pvf, qvf = float(dv), float(pv), float(qv)
            sc = max(abs(dvf), abs(pvf), abs(qvf))
            neg_d, neg_p, neg_q = dvf < -1e-12, pvf < -1e-12, qvf < -1e-12
            # triangles of negative graph on n=5m vertices
            from math import comb
            t = 0
            if neg_d: t += 5*comb(mval,3)
            if neg_d and neg_p: t += 5*2*comb(mval,2)*mval
            if neg_d and neg_q: t += 5*2*comb(mval,2)*mval
            # triples of distinct blocks: C_5 has 0 triangles, complement of C_5 = C_5 has 0
            # mixed a~b, a!~c, b!~c etc: enumerate
            import itertools
            G = [[1 if (a-b)%5 in (1,4) else 0 for b in range(5)] for a in range(5)]
            for a,b,c in itertools.combinations(range(5),3):
                def sgn(x,y): return neg_p if G[x][y] else neg_q
                if sgn(a,b) and sgn(a,c) and sgn(b,c): t += mval**3
            print(f"{mval:>4} {5*mval:>4} {dvf/sc:>11.6f}:{pvf/sc:>10.6f}:{qvf/sc:>10.6f} "
                  f"{th:>12.8f} {th0:>10.6f} {ratio:>10.6f} {'YES' if t==0 else f'no({3*t})':>10}")
