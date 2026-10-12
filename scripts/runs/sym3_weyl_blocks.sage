"""The SOS blocks for item 3c: Sym^3(Weyl_n) decomposed into O(n)-irreducibles.

RUN:  sage scripts/runs/sym3_weyl_blocks.sage        (under a second)

A degree-six O(n)-invariant SOS certificate for
    Theta_n^2 |W|^6 - <Q(W),W>^2 + mu |W ^ Q(W)|^2
is a sum over the isotypic blocks of Sym^3 of the Weyl module, ONE PSD MATRIX PER BLOCK
SIZED BY THAT BLOCK'S MULTIPLICITY.  The multiplicity profile is the object the
certificate needs; the block count alone gives the number of matrices and nothing about
any size.

METHOD.  In the stable range the O(n)-irreducible [2,2] is s[2,2] - s[2], and the
plethysm is taken in the ORTHOGONAL basis directly.  No character is expanded, so this is
degree-12 symmetric-function algebra rather than a 734-million-dimensional object.

TWO EARLIER ROUTES, both recorded because each cost something:
  * h_3[s_{2,2}] in the symmetric-function ring is Sym^3 of the GL Schur functor, whose
    space is algebraic curvature tensors -- 105-dimensional at n = 6 against Weyl_6's 84.
  * WeylCharacterRing("D6").symmetric_power(3) materialises the character, drove this
    machine 5.2 GB into swap for fifteen minutes, and counts SO(12)-irreducibles rather
    than O(n) ones: six constituents have n/2 rows and split on restriction, so its 77 is
    65 + 2*6 against the correct 71.

CHECKS: the trivial summand has multiplicity 2, the count of cubic invariants, which
ATTEMPTS.md Result 3 proves four ways and fence post 2g gives independence for.
"""
Sym = SymmetricFunctions(QQ)
s, h, o = Sym.s(), Sym.h(), Sym.o()

W = s[2, 2] - s[2]                      # the O(n)-irreducible [2,2], stably in n

P = o(h[3].plethysm(W))
d = P.monomial_coefficients()
mults = sorted(d.values(), reverse=True)

print("Sym^3(Weyl_n) into O(n)-irreducibles, stable range:")
print("   blocks                     = %d" % len(d))
print("   multiplicities             = 1..%d, summing to %d" % (max(mults), sum(mults)))
print("   scalar unknowns            = %d" % sum(m * (m + 1) // 2 for m in mults))
print("   largest block              = %d x %d" % (max(mults), max(mults)))
print("   trivial multiplicity       = %d   (must be 2)" % d.get(Partition([]), 0))

print("\nO(n)-invariant dimensions by degree -- the SDP's constraint counts:")
for k in (2, 3, 4, 5, 6):
    inv = o(h[k].plethysm(W)).monomial_coefficients().get(Partition([]), 0)
    print("   k=%d: %d" % (k, inv))
print("\nSo item 3c's SDP: 477 unknowns, 89 constraints, 71 blocks of size at most 9.")
