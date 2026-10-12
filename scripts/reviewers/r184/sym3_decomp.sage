# r184, claim 5 cross-check: the full so(5)-decomposition of Sym^3(Weyl_5),
# independent of run_n5_highest_weight.py's highest-weight search.
B2 = WeylCharacterRing("B2")
V = B2(2,2)
S = V.symmetric_power(3)
def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6
items = []
for mon, c in S.monomial_coefficients().items():
    lam = tuple(ZZ(x) for x in B2(mon).highest_weight().to_vector())
    items.append((lam, c, dimB2(lam)))
items.sort(key=lambda t: t[2])
tot = 0; ncop = 0
for lam, c, d in items:
    print("lambda=%-8s mult %d  dim %4d  (Weyl-formula check: %s)" % (str(lam), c, d, dimB2(lam)==d))
    tot += c*d; ncop += c
print("blocks:", len(items), " total copies:", ncop, " dim sum:", tot,
      " equals dim Sym^3 =", S.degree(), ":", tot == S.degree())
