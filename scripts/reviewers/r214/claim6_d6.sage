# r214 claim 6: the n=12 Weyl module as an so(12)=D6 representation.
print("=== D6 irrep with epsilon highest weight (2,2,0,0,0,0) = 2*omega_2 ===")
R = WeylCharacterRing("D6", style="coroots")
L = R.fundamental_weights()
lam = 2*L[2]
V = R(lam)
print("highest weight (coroots):", lam)
print("dimension by Weyl dimension formula:", V.degree())
print("closed form n(n+1)(n+2)(n-3)/12 at n=12:", 12*13*14*9//12)

# dominant weight multiplicities, via Freudenthal (Sage's weight_multiplicities)
wm = V.weight_multiplicities()
amb = R.space()
dom = [(w, m) for w, m in wm.items() if w.is_dominant()]
def eps(w):
    return tuple(w.to_vector())
dom.sort(key=lambda t: (-sum(eps(t[0])), eps(t[0])))
print("\ndominant weights (epsilon coords) and multiplicities:")
tot = 0
for w, m in dom:
    print("   ", tuple(QQ(x) for x in w.to_vector()), "->", m)
print("number of dominant weights:", len(dom))
print("multiset of dominant multiplicities:", sorted(m for _, m in dom))
print("sum over ALL weights (should equal dim):", sum(wm.values()))

# also: dimension of the O(12) / SO(12) invariants question -- check the
# associated partition
print("\nassociated O(12) partition of (2,2): first column 2 -> 12-2 = 10 rows")
