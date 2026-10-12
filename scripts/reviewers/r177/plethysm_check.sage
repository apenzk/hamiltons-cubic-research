Sym = SymmetricFunctions(QQ); s = Sym.s()
pl = s[3].plethysm(s[2,2])
print("Sym^3[s_{2,2}] : number of terms", len(pl.support()))
tot = 0
for mu, c in sorted(pl.monomial_coefficients().items(), key=lambda t: (len(t[0]), t[0])):
    d = 0
    if len(mu) <= 12:
        d = s(mu).expand(12).coefficient([1]*0) if False else 0
    print("  ", mu, c, " ell =", len(mu))
print()
# dimension check in GL(12)
from sage.combinat.partition import Partition
def dimGL(mu, n):
    mu = Partition(mu); num = 1; den = 1
    for (i,j) in mu.cells():
        num *= n + j - i
        den *= mu.hook_length(i,j)
    return num//den if num % den == 0 else num/den
tot = sum(c*dimGL(mu,12) for mu,c in pl.monomial_coefficients().items() if len(mu)<=12)
print("dim Sym^3(S_{2,2}(C^12)) =", tot, " expected C(1718,3) =", binomial(1716+2,3))
print("max ell(mu) =", max(len(m) for m in pl.support()))
# n=5 analogue
tot5 = sum(c*dimGL(mu,5) for mu,c in pl.monomial_coefficients().items() if len(mu)<=5)
print("dim Sym^3(S_{2,2}(C^5)) =", tot5, " expected C(52,3) =", binomial(50+2,3))
