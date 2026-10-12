# Independent of the repo's Weyl-integration constant-term code.
# Sage's WeylCharacterRing decomposes into irreducibles via Brauer/Klimyk;
# the invariant count is then the multiplicity of the TRIVIAL irrep, a
# different final step from "constant term of chi * prod(1-t^alpha)".
B2 = WeylCharacterRing("B2", style="coroots")
# coroots style: B2(a,b) has highest weight a*om1 + b*om2.
# Weyl_5 = [2,2] = 2e1+2e2 = 4*om2  (om2 is the SPIN weight for B2).
W5 = B2(0,4)
print("dim Weyl_5 =", W5.degree())
assert W5.degree() == 35

S3 = W5.symmetric_power(3)
print("dim Sym^3 =", S3.degree())
d3 = S3.monomial_coefficients()
blocks = sorted(((k, B2(k).degree(), int(v)) for k, v in d3.items()),
                key=lambda t: (-t[2], -t[1]))
print("blocks:", len(blocks), " sum m =", sum(b[2] for b in blocks),
      " sum m*d =", sum(b[1]*b[2] for b in blocks))
for b in blocks: print("   ", b)

# Frobenius-Schur type of each occurring block, computed independently:
# multiplicity of trivial in Sym^2(V) is 1 for real type, in Lambda^2 for quaternionic.
triv = B2(0,0)
bad = []
for k, d, m in blocks:
    V = B2(k)
    s2 = V.symmetric_power(2).monomial_coefficients().get(triv.highest_weight(), 0)
    e2 = V.exterior_power(2).monomial_coefficients().get(triv.highest_weight(), 0)
    if (s2, e2) != (1, 0): bad.append((k, s2, e2))
print("blocks NOT of real type:", bad)

sym = sum(m*(m+1)//2 for _,_,m in blocks)
anti = sum(m*(m-1)//2 for _,_,m in blocks)
print("sum m(m+1)/2 =", sym, "  sum m(m-1)/2 =", anti, "  sum m^2 =", sym+anti)

S6 = W5.symmetric_power(6)
print("dim Sym^6 =", S6.degree())
inv6 = S6.monomial_coefficients().get(triv.highest_weight(), 0)
print("dim (Sym^6 Weyl_5)^SO(5) =", inv6)
for k in range(1,7):
    hk = W5.symmetric_power(k)
    print("  degree", k, "invariants =", hk.monomial_coefficients().get(triv.highest_weight(), 0))
