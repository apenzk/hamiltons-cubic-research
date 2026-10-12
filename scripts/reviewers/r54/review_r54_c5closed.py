"""K4, closed form: the C_5 blow-up with equal blocks of size m.

Set d = 1, s = p + q, u = p - q.  Ricci gives s = -(m-1)/(2m).  Subtracting the two
off-diagonal criticality equations gives (for u != 0)  theta' = (m-1)(2-s), and the
diagonal one gives s^2 + u^2 = (m-1)(1-s)/m.  Hence

    theta'   = (m-1)(5m-1)/(2m),          |W_raw|^2 = (5/4)(m-1)(5m-1),
    theta^2  = (m-1)(5m-1)/(5m^2),        theta_0^2 = 2(5m-1)(5m-2)/(25m^2),

    (theta/theta_0)^2 = 5(m-1) / (2(5m-2)) ,

strictly increasing in m, supremum 1/sqrt(2), never attained.  theta itself increases
to 1 from below, since 5m^2 - (m-1)(5m-1) = 6m - 1 > 0.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import numpy as np
import sympy as sp
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_blocks import Qmat, normsq, Pval, ricci, triangles, theta0
from review_r54_core import pairs_of, Q as Qfull, P as Pfull, ricci_of, slack_structural

m = sp.symbols('m', positive=True)
th2 = (m-1)*(5*m-1)/(5*m**2)
ratio2 = 5*(m-1)/(2*(5*m-2))
print("closed form   theta^2 =", sp.simplify(th2), "   ratio^2 =", sp.simplify(ratio2))
print("limits: theta ->", sp.limit(sp.sqrt(th2), m, sp.oo), "  ratio ->", sp.sqrt(sp.limit(ratio2, m, sp.oo)),
      "=", float(sp.sqrt(sp.limit(ratio2, m, sp.oo))))
print("monotone: d/dm ratio^2 =", sp.simplify(sp.diff(ratio2, m)), " > 0 for m > 1")
print("theta < 1 always:  5m^2 - (m-1)(5m-1) =", sp.expand(5*m**2 - (m-1)*(5*m-1)))

print("\ncheck against the full structure-constant operator")
def c5_blocks(mv):
    k = 5
    d, p, q = sp.symbols('d p q')
    sv = sp.Rational(-(mv-1), 2*mv)
    u2 = sp.Rational((mv-1)*(5*mv-1), 4*mv**2)
    uv = sp.sqrt(u2)
    pv, qv = (sv+uv)/2, (sv-uv)/2
    w = np.zeros((k, k))
    for a in range(k):
        for b in range(k):
            w[a, b] = 1.0 if a == b else (float(pv) if (a-b) % k in (1, k-1) else float(qv))
    return w

print(f"{'m':>4} {'n':>5} {'closed theta':>14} {'measured theta':>15} {'resid':>10} {'ratio':>10} "
      f"{'closed ratio':>13} {'S':>6}")
for mv in [2, 3, 4, 5, 6, 8]:
    n = 5*mv
    w = c5_blocks(mv)
    sizes = [mv]*5
    wn = w/np.sqrt(normsq(sizes, w))
    thr = float(sp.sqrt(th2.subs(m, mv)))
    thm = Pval(sizes, wn)
    if thm < 0:
        wn, thm = -wn, -thm
    Qm = Qmat(sizes, wn)
    res = max(abs(Qm[a, b] - thm*wn[a, b]) for a in range(5) for b in range(5))
    res = max(res, abs(ricci(sizes, wn)).max())
    S = 3*triangles(sizes, wn)
    print(f"{mv:>4} {n:>5} {thr:>14.9f} {thm:>15.9f} {res:>10.1e} {thm/theta0(n):>10.7f} "
          f"{float(sp.sqrt(ratio2.subs(m,mv))):>13.7f} {S:>6}")
    if n <= 20:
        ps, idx = pairs_of(n)
        lab = []
        for bi in range(5): lab += [bi]*mv
        Wf = np.zeros((len(ps), len(ps)))
        for a, (i, j) in enumerate(ps):
            Wf[a, a] = wn[lab[i], lab[j]]
        Wf /= np.linalg.norm(Wf)
        thf = Pfull(n, Wf)
        if thf < 0: Wf, thf = -Wf, -thf
        print(f"       full operator: theta={thf:.9f} resid={np.linalg.norm(Qfull(n,Wf)-thf*Wf):.1e} "
              f"|Ric|={np.abs(ricci_of(n,Wf)).max():.1e} S_struct={slack_structural(n,Wf):.3e}")
