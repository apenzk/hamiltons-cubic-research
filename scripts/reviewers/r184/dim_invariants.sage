# r184, claim 4: the degree-k O(5)-invariant dimension on Weyl_5, from scratch.
# Weyl_5 is the so(5)=B2 irrep with highest weight (2,2) in epsilon coordinates
# (Weyl dim formula: (l1-l2+1)(l1+l2+2)(2l1+3)(2l2+1)/6 = 35 at (2,2)).
# dim of degree-k invariants = multiplicity of the trivial rep in Sym^k(Weyl_5).
# -Id acts trivially (W is even in the vector), so O(5)- and SO(5)-invariants agree.
B2 = WeylCharacterRing("B2")
V = B2(2,2)
print("dim V_(2,2) =", V.degree(), "  (35:", V.degree()==35, ")")
import time
for k in [1,2,3,4,5,6]:
    t0 = time.time()
    S = V.symmetric_power(k)
    m = S.monomial_coefficients().get(B2(0,0).support()[0], 0)
    print("k =", k, " dim Sym^k =", S.degree(), " binom check:",
          S.degree() == binomial(35+k-1, k), " invariants:", m,
          " [%.0fs]" % (time.time()-t0))
