"""r274, Claim 4 in closed form: at S^m x S^m the two halves of the spectral split
are exactly ORTHOGONAL, so any triangle-inequality recombination loses a factor
(p+q)/sqrt(p^2+q^2) -> sqrt(2)."""
import sympy as sp
m = sp.symbols('m', positive=True)
a  = 1/sp.sqrt((m-1)*(2*m-1))            # W_+ eigenvalue, mult m(m-1)
bp = sp.sqrt(m-1)/(m*sp.sqrt(2*m-1))     # |W_-| eigenvalue, mult m^2
P = sp.simplify((m-2)*a**2 + m*bp**2)    # parts, on the m(m-1) same-factor coords
C = sp.simplify((m-1)*a*bp)              # cross, on the m^2 mixed coords
p  = sp.sqrt(sp.simplify(m*(m-1)*P**2)); q = sp.sqrt(sp.simplify(4*m**2*C**2))
Wn = sp.sqrt(sp.simplify(m*(m-1)*P**2 + 4*m**2*C**2))
print("parts value on same-factor coords :", sp.simplify(P), "   (0 on mixed)")
print("cross value on mixed coords       :", sp.simplify(C), "   (0 on same-factor)")
print("=> <parts,cross>_F = 0 identically: disjoint supports")
print("||parts||_F =", sp.simplify(p))
print("2||cross||_F =", sp.simplify(q))
print("||W^#||_F   =", sp.simplify(Wn))
ratio = sp.simplify((p+q)/Wn)
print("\ntriangle loss (||parts||+2||cross||)/||W^#||_F =", sp.simplify(ratio))
print("  limit m->oo:", sp.limit(ratio, m, sp.oo))
th0 = sp.sqrt(2*(2*m-1)*(2*m-2))/(2*m)
print("\n(||parts||+2||cross||)/theta_0(2m):")
for mm in (3,4,5,6,10,12,50):
    print(f"   m={mm:>3} n={2*mm:>3}: {sp.N(((p+q)/th0).subs(m,mm),8)}")
print("  limit m->oo:", sp.limit((p+q)/th0, m, sp.oo))
