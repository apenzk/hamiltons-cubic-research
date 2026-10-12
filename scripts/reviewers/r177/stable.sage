s = SymmetricFunctions(QQ).s()
seq=[]
for d in range(1,7):
    pl = s[d].plethysm(s[2,2])
    n = sum(c for mu,c in pl.monomial_coefficients().items() if all(p%2==0 for p in mu))
    seq.append(n); print("degree",d,"stable O(n)-invariants:",n)
