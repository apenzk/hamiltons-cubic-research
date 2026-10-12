"""Reviewer 35 / M6: the Casimir table, and the joint-separation question in closed form.

The ten summands of Nienhaus's Weyl_n decomposition are, as (so(p)-irrep, so(q)-irrep):
  1 <W>          (triv, triv)          6 S^2_0(R^q)     (triv, S20)
  2 Weyl_p       (Weyl, triv)          7 S^2_0(x)S^2_0  (S20, S20)
  3 Weyl_q       (triv, Weyl)          8 Lam^2(x)Lam^2  (L2 , L2 )
  4 R^p(x)R^q    (vec , vec )          9 X_p(x)R^q      (X  , vec)
  5 S^2_0(R^p)   (S20 , triv)         10 X_q(x)R^p      (vec, X  )

Casimir of each so(m)-constituent, in the normalisation C = -sum_a G_a^2 over the
orthonormal basis phi_ij:  triv 0, vec m-1, Lam^2 2(m-2), S^2_0 2m, X_m 3(m-1),
Weyl_m 4(m-1).  This script verifies the table from the measured blocks and then
solves every pairwise joint-equality in closed form.
"""
import sympy as sp, sys, re

m = sp.symbols('m', positive=True)
CAS = {'triv': sp.Integer(0), 'vec': m-1, 'L2': 2*(m-2), 'S20': 2*m,
       'X': 3*(m-1), 'Weyl': 4*(m-1)}

print("== the Casimir table, checked against the measured blocks ==")
meas = {  # (m, constituent) -> measured C value, read off the sweep output
    (3,'vec'):2, (3,'L2'):2, (3,'S20'):6, (3,'X'):6,
    (4,'vec'):3, (4,'L2'):4, (4,'S20'):8, (4,'X'):9,  (4,'Weyl'):12,
    (5,'vec'):4, (5,'L2'):6, (5,'S20'):10,(5,'X'):12, (5,'Weyl'):16,
    (6,'vec'):5, (6,'L2'):8, (6,'S20'):12,(6,'X'):15, (6,'Weyl'):20,
    (7,'vec'):6, (7,'L2'):10,(7,'S20'):14,(7,'X'):18, (7,'Weyl'):24,
}
bad = [(k,v) for k,v in meas.items() if CAS[k[1]].subs(m,k[0]) != v]
print("   mismatches:", bad if bad else "none  (25 entries, m=3..7)")

p, q = sp.symbols('p q', integer=True, positive=True)
def J(a, b):
    return (CAS[a].subs(m,p), CAS[b].subs(m,q))
S = {1:('triv','triv'), 2:('Weyl','triv'), 3:('triv','Weyl'), 4:('vec','vec'),
     5:('S20','triv'), 6:('triv','S20'), 7:('S20','S20'), 8:('L2','L2'),
     9:('X','vec'), 10:('vec','X')}
NAME = {1:'<W>',2:'Weyl_p',3:'Weyl_q',4:'R^p(x)R^q',5:'S0_p',6:'S0_q',
        7:'S0(x)S0',8:'L2(x)L2',9:'X_p(x)R^q',10:'X_q(x)R^p'}

print("\n== every pair of summands: for which integer p,q >= 3 do the joint Casimirs agree? ==")
collide = []
for i in range(1, 11):
    for j in range(i+1, 11):
        ai, bi = J(*S[i]); aj, bj = J(*S[j])
        sol = sp.solve([sp.Eq(ai, aj), sp.Eq(bi, bj)], [p, q], dict=True)
        good = []
        for so in sol:
            pv = so.get(p); qv = so.get(q)
            if pv is None or qv is None:
                good.append("a whole family - inspect"); continue
            if pv.is_Integer and qv.is_Integer and pv >= 3 and qv >= 3:
                good.append((int(pv), int(qv)))
        if good:
            collide.append((NAME[i], NAME[j], good))
            print(f"   {NAME[i]:12s} vs {NAME[j]:12s} : {good}")
if not collide:
    print("   (none)")
print("\n   => for p,q >= 3 the joint Casimir separates all ten summands except")
print("      R^p(x)R^q vs Lambda^2(x)Lambda^2 at (p,q)=(3,3).")

print("\n== is 'equal joint Casimir => isomorphic' a valid inference? ==")
print("   NO.  Casimir eigenvalue is an isomorphism INVARIANT, not a complete one.")
print("   Explicit counterexamples with real, non-isomorphic irreps of ONE so(m):")
# so(m) Casimir of highest weight lambda:  <lam, lam+2rho>
def cas_so(lam, mm):
    r = len(lam)
    if mm % 2 == 0:  rho = [sp.Rational(mm,2)-1-i for i in range(r)]   # D_r
    else:            rho = [sp.Rational(mm,2)-1-i for i in range(r)]   # B_r, rho_i = (m-2i)/2... use same
    return sum(l*(l+2*rr) for l, rr in zip(lam, rho))
def dim_so(lam, mm):
    # Weyl dimension formula, orthogonal coordinates
    r = len(lam)
    rho = [sp.Rational(mm-2-2*i, 2) for i in range(r)]   # B_r and D_r alike
    a = [lam[i]+rho[i] for i in range(r)]
    num = den = sp.Integer(1)
    for i in range(r):
        for j in range(i+1, r):
            num *= (a[i]-a[j])*(a[i]+a[j]); den *= (rho[i]-rho[j])*(rho[i]+rho[j])
        if mm % 2:
            num *= a[i]; den *= rho[i]
    return sp.simplify(num/den)
for mm in (5, 7, 9):
    r = mm//2
    seen = {}
    for lam in [tuple(x) for x in __import__('itertools').product(range(0,5), repeat=r)]:
        if any(lam[i] < lam[i+1] for i in range(r-1)):  continue
        if lam == (0,)*r: continue
        c = cas_so(list(lam), mm)
        seen.setdefault(c, []).append(lam)
    hits = [(c, v) for c, v in seen.items() if len(v) > 1]
    for c, v in sorted(hits)[:3]:
        dims = [int(dim_so(list(l), mm)) for l in v]
        print(f"   so({mm}): highest weights {v} all have Casimir {c}, dims {dims} -> non-isomorphic")
