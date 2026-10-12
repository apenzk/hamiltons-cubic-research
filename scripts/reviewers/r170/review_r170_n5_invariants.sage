"""Reviewer 170 -- the n = 5 block and invariant data for item 3c, by torus arithmetic.

RUN:  sage scripts/reviewers/r170/review_r170_n5_invariants.sage      (a few seconds)

Weyl_5 is the O(5)-irreducible [2,2] = 4*omega_2 of B2 (omega_2 is the spin weight).
Two things are computed, neither of which needs the stable range that
scripts/runs/sym3_weyl_blocks.sage assumes and that fails at n = 5:

  * the isotypic profile of Sym^3, via WeylCharacterRing("B2").symmetric_power(3)
    (7770-dimensional, cheap);
  * dim Sym^k(Weyl_5)^{O(5)} for k = 1..6, by Weyl integration -- power sums from
    the 35 weights, h_k by Newton's identities in Z[x^{+-},y^{+-}], then
    (1/|W|) CT[ h_k * prod_{alpha in Phi}(1 - x^alpha) ].

O(5)-invariants equal SO(5)-invariants here: n is odd, so O(5) = SO(5) x {+-I},
and -I acts trivially on Weyl_5 (four tensor indices), hence on every Sym^k.

The last block discriminates the module: [2,1] also has dimension 35, but carries
NO cubic invariant, while Weyl_5 carries exactly one (tr W^3, fence post 2g).
"""
Ra = WeylCharacterRing("B2")
Rc = WeylCharacterRing("B2", style="coroots")
print("dim 4*omega_2 =", Rc(0, 4).degree(), "  dim 2*omega_2 =", Rc(0, 2).degree())
print("dim [2,2] =", Ra(2, 2).degree(), "  dim [2,1] =", Ra(2, 1).degree())

S3 = Ra(2, 2).symmetric_power(3)
d = S3.monomial_coefficients()
mults = sorted(d.values(), reverse=True)
print("\nSym^3(Weyl_5): dim %d, %d blocks, multiplicities 1..%d summing to %d"
      % (S3.degree(), len(d), max(mults), sum(mults)))
print("   scalar unknowns = %d, largest block %dx%d"
      % (sum(m * (m + 1) // 2 for m in mults), max(mults), max(mults)))
print("   block dimensions (mult x dim):")
rows = sorted(((Integer(v), Integer(Ra(k).degree())) for k, v in d.items()),
              key=lambda t: -t[1])
print("     " + ", ".join("%dx%d" % r for r in rows))

ONE = {(0, 0): Integer(1)}
def mul(A, B):
    C = {}
    for a, ca in A.items():
        for b, cb in B.items():
            k = (a[0] + b[0], a[1] + b[1]); C[k] = C.get(k, 0) + ca * cb
    return {k: v for k, v in C.items() if v != 0}
def add(A, B):
    C = dict(A)
    for b, cb in B.items(): C[b] = C.get(b, 0) + cb
    return {k: v for k, v in C.items() if v != 0}
DEN = ONE
for a in [(1,0),(-1,0),(0,1),(0,-1),(1,-1),(-1,1),(1,1),(-1,-1)]:
    DEN = mul(DEN, {(0, 0): Integer(1), a: Integer(-1)})
print("\nsanity: CT of the Weyl denominator product =", DEN.get((0, 0), 0), "(= |W(B2)| = 8)")

def invariant_dims(label, K=6):
    V = Ra(*label)
    wts = []
    for w, mu in V.weight_multiplicities().items():
        c = list(w.to_vector()); wts.append(((Integer(c[0]), Integer(c[1])), Integer(mu)))
    def p(k):
        C = {}
        for w, m in wts:
            key = (k * w[0], k * w[1]); C[key] = C.get(key, 0) + m
        return C
    h = {0: ONE}
    for k in range(1, K + 1):
        acc = {}
        for i in range(1, k + 1): acc = add(acc, mul(h[k - i], p(i)))
        h[k] = {x: y / Integer(k) for x, y in acc.items()}
    return [mul(h[k], DEN).get((0, 0), 0) / Integer(8) for k in range(1, K + 1)]

print("   dim Sym^k(Weyl_5)^{O(5)}, k=1..6:", invariant_dims((2, 2)))
print("   the same for the impostor [2,1], k=1..5:", invariant_dims((2, 1), K=5))
print("\nSo: 24 blocks, 65 unknowns, 14 degree-six constraints; and [2,1] is excluded")
print("by having no cubic invariant, which Weyl_5 provably has exactly one of.")
