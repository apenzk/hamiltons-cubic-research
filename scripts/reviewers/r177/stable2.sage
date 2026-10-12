# stable-range O(n)-invariants of Sym^d(Weyl):  o_{22} = s_{22} - s_2  as universal characters,
# and mult of the trivial O-rep in s_mu is 1 iff every part of mu is even.
Sym = SymmetricFunctions(QQ); s = Sym.s(); e = Sym.e()
h22 = {0: s.one()}; e2 = {0: s.one()}
for i in range(1,7):
    h22[i] = s(s[i].plethysm(s[2,2]))
    e2[i]  = s(e[i].plethysm(s[2]))
for d in range(1,7):
    F = sum((-1)**j * h22[d-j] * e2[j] for j in range(0,d+1))
    n = sum(c for mu,c in s(F).monomial_coefficients().items() if all(p%2==0 for p in mu))
    print("degree",d," stable dim (Sym^d Weyl)^{O(n)} =",n)
