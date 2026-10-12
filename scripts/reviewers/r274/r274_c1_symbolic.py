"""r274, Claim 1 in closed form in m (n=2m). No numerics, no imports from scripts/."""
import sympy as sp
m = sp.symbols('m', positive=True, integer=True)
n = 2*m
# unit-norm Weyl tensor of S^m x S^m on Lambda^2: a on each factor's 2-forms, b on mixed
a = 1/sp.sqrt((m-1)*(2*m-1))
b = -sp.sqrt(m-1)/(m*sp.sqrt(2*m-1))
# derived from R - c*Id, c=(m-1)/(2m-1), norm m*sqrt((m-1)/(2m-1)) -- re-derive to be safe:
c = sp.Rational(1,1)*(m-1)/(2*m-1)
lam_same = sp.simplify(1-c); lam_mix = sp.simplify(-c)
nrm2 = sp.simplify(m*(m-1)*lam_same**2 + m**2*lam_mix**2)
a2 = sp.simplify(lam_same/sp.sqrt(nrm2)); b2 = sp.simplify(lam_mix/sp.sqrt(nrm2))
print("a matches:", sp.simplify(a-a2)==0, " b matches:", sp.simplify(b-b2)==0)
print("||W||^2 before normalising:", sp.simplify(nrm2))
print("check ||mu||^2 = 1:", sp.simplify(m*(m-1)*a**2 + m**2*b**2))
print("check sum mu = 0 :", sp.simplify(m*(m-1)*a + m**2*b))

tr3 = sp.simplify(m*(m-1)*a**3 + m**2*b**3)
print("tr(M^3) =", sp.simplify(sp.radsimp(tr3)))

# M#: (M#)_{(ij)} = sum_{k != i,j} lam_ik lam_jk   (triangle formula, derived in the report)
s_same = sp.simplify((m-2)*a**2 + m*b**2)     # both indices in one factor
s_mix  = sp.simplify(2*(m-1)*a*b)             # one index in each factor
ip   = sp.simplify(m*(m-1)*a*s_same + m**2*b*s_mix)
nsh2 = sp.simplify(m*(m-1)*s_same**2 + m**2*s_mix**2)
print("<M#,M>   =", sp.simplify(sp.radsimp(ip)))
print("||M#||^2 =", sp.factor(sp.simplify(nsh2)))
theta = sp.simplify(tr3 + ip)
theta0 = sp.sqrt(2*(n-1)*(n-2))/n
print("theta          =", sp.simplify(sp.radsimp(theta)))
print("theta_0(2m)    =", sp.simplify(sp.radsimp(theta0)))
print("theta - theta_0 =", sp.simplify(sp.radsimp(sp.simplify(theta-theta0))))

# the two structural claims, in closed form
r = sp.simplify(sp.sqrt(nsh2)/ip)
print("\n||M#||/<M#,M> squared =", sp.factor(sp.simplify(nsh2/ip**2)))
print("  limit m->oo :", sp.limit(sp.sqrt(sp.simplify(nsh2/ip**2)), m, sp.oo))
print("  series      :", sp.series(sp.sqrt(sp.simplify(nsh2/ip**2)), m, sp.oo, 4))
exc = sp.simplify((tr3 + sp.sqrt(nsh2))/theta0 - 1)
print("\nexcess (sum/theta_0 - 1):")
for mm in (3,4,5,6,10,12,50,200):
    print(f"   m={mm:>4} n={2*mm:>4}  {sp.N(exc.subs(m,mm)*100, 8)} %")
print("  limit m->oo:", sp.limit(exc, m, sp.oo))
print("  asymptotics:", sp.series(exc, m, sp.oo, 3))
print("\ntr(M^3)/theta:")
for mm in (3,6,12):
    print(f"   m={mm}: {sp.N(sp.simplify(tr3/theta).subs(m,mm)*100,6)} %")
