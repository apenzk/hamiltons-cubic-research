# r214: second route to dim (Sym^6 Weyl_5)^{SO(5)} -- Sage's own plethysm,
# against the Kostant alternating sum in claim4_inv14.sage.
R = WeylCharacterRing("B2")
V = R(2,2)
S6 = V.symmetric_power(6)
print("dim Sym^6 =", S6.degree(), " expected C(40,6) =", binomial(40, 6))
for k, v in S6.monomial_coefficients().items():
    if all(x == 0 for x in k):
        print("multiplicity of the trivial representation:", v)
