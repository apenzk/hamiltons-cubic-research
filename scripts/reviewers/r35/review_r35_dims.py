"""Reviewer 35 / M2, M5: the dimension identities, symbolically."""
import sympy as sp

k, l = sp.symbols('k l', positive=True)
n = k + l
Wd = lambda m: m*(m+1)*(m+2)*(m-3)/12
s  = lambda m: (m+2)*(m-1)/2
c  = lambda m: m*(m-1)/2
X  = lambda m: m*(m**2-4)/3

total = 1 + Wd(k) + Wd(l) + k*l + s(k) + s(l) + s(k)*s(l) + c(k)*c(l) + X(k)*l + X(l)*k
print("M2  sum of the ten dims  - dim Weyl_{k+l} =",
      sp.simplify(sp.expand(total - Wd(n))))

# dim X_m from the Nienhaus construction:  Lambda^2 (x) R^m = Lambda^3 + R^m + X_m
m = sp.symbols('m', positive=True)
Xm = m*(m-1)/2*m - m*(m-1)*(m-2)/6 - m
print("M2  dim X_m from the construction   =", sp.factor(sp.simplify(Xm)),
      "   claimed m(m^2-4)/3 :", sp.simplify(Xm - m*(m**2-4)/3) == 0)
# GL(m) hook (2,1) minus its trace part
hook = m*(m**2-1)/3
print("    GL hook (2,1) dim = m(m^2-1)/3 ; traceless part =",
      sp.factor(sp.simplify(hook - m)), " equals X_m:", sp.simplify(hook-m-Xm)==0)

# zero block
zero = Wd(k) + Wd(l) + X(k)*l + X(l)*k
print("M5  W(k)+W(l)+X(k)l+X(l)k - [W(k)+W(l)+kl(k^2+l^2-8)/3] =",
      sp.simplify(sp.expand(zero - (Wd(k)+Wd(l)+k*l*(k**2+l**2-8)/3))))

# mu = 1/2 ?
p, q = sp.symbols('p q', positive=True)
mu = (p+q-2)/(2*(p-1)*(q-1))
print("\nM7  mu - 1/2 = 0  <=>", sp.factor(sp.simplify(sp.numer(sp.together(mu - sp.Rational(1,2))))), "= 0")
print("    i.e. (p-2)(q-2) = 1 ; integer solutions with p,q>=3:",
      [(a,b) for a in range(2,40) for b in range(2,40) if (a-2)*(b-2)==1])
print("    mu at small splits:", {(a,b): sp.nsimplify(mu.subs({p:a,q:b})) for a,b in
      [(3,3),(3,4),(3,5),(3,9),(4,4),(4,5),(5,5),(5,7),(6,6),(2,4),(2,6)]})
lam = lambda mm: sp.Rational(mm-2, 2*(mm-1))
print("    lambda_m = (m-2)/(2(m-1)) < 1/2 for all m:", [ (mm, lam(mm)) for mm in range(3,10)])

# when do two summand DIMENSIONS coincide (a necessary condition for a Casimir merge)?
print("\nM7  splits p,q>=3, n<=20 where two of the ten summand dims coincide:")
for P in range(3, 18):
    for Qq in range(P, 21-P):
        d = {"<W>":1, "Weyl_p":int(Wd(P)), "Weyl_q":int(Wd(Qq)), "R^p(x)R^q":P*Qq,
             "S0_p":int(s(P)), "S0_q":int(s(Qq)), "S0(x)S0":int(s(P)*s(Qq)),
             "L2(x)L2":int(c(P)*c(Qq)), "X_p(x)R^q":int(X(P)*Qq), "X_q(x)R^p":int(X(Qq)*P)}
        items = [(kk, vv) for kk, vv in d.items() if vv > 0]
        for i in range(len(items)):
            for j in range(i+1, len(items)):
                if items[i][1] == items[j][1] and items[i][1] > 1:
                    print(f"   ({P},{Qq}): {items[i][0]} = {items[j][0]} = {items[i][1]}")
