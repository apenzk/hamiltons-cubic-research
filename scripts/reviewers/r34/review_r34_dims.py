"""M2: the ten summand dimensions sum to dim Weyl_n identically in k,l."""
import sympy as sp
k, l = sp.symbols('k l', positive=True, integer=True)
n = k + l
Wd = lambda m: m*(m+1)*(m+2)*(m-3)/12
s  = lambda m: (m+2)*(m-1)/2          # dim S^2_0(R^m)
c  = lambda m: m*(m-1)/2              # dim Lambda^2(R^m)
X  = lambda m: m*(m*m-4)/3            # claimed dim X_m

total = 1 + Wd(k) + Wd(l) + k*l + s(k) + s(l) + s(k)*s(l) + c(k)*c(l) + X(k)*l + X(l)*k
target = Wd(n)
print("sum - dim Weyl_n  =", sp.simplify(sp.expand(total - target)))

# X_m identification: GL module S_{(2,1)}(R^m) has dim m(m^2-1)/3;
# its O(m)-traceless part [2,1] has dim m(m^2-1)/3 - m.
gl21 = m_ = sp.Symbol('m', positive=True)
gl = m_*(m_**2-1)/3
print("dim S_{(2,1)}(R^m) - m  =", sp.simplify(gl - m_), " vs  m(m^2-4)/3 =",
      sp.simplify(m_*(m_**2-4)/3), " equal:", sp.simplify(gl - m_ - m_*(m_**2-4)/3) == 0)

# also: Nienhaus builds X_k from Lambda^2(R^k) (x) R^k = Lambda^3 + R^k + X_k
lam2xv = m_*(m_-1)/2*m_
lam3 = sp.binomial(m_, 3)
print("dim(Lambda^2 (x) R^m) - dim Lambda^3 - m =",
      sp.simplify(sp.expand(lam2xv - lam3 - m_)), " (should be m(m^2-4)/3)")
print("  equals m(m^2-4)/3:",
      sp.simplify(sp.expand(lam2xv - lam3 - m_ - m_*(m_**2-4)/3)) == 0)

# integrality / positivity
for mm in range(1, 10):
    print(f"   m={mm}: X_m = {mm*(mm*mm-4)//3 if (mm*(mm*mm-4))%3==0 else mm*(mm*mm-4)/3}")
