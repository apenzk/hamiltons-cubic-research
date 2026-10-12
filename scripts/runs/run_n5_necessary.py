"""Whether F_5 can have a certificate at all reduces to ONE dimension count.

The n=5 SOS route asks for F_5 = sum of squares of cubics drawn from
K = {f in Sym^3(Weyl_5) : sigma_lambda(W_0) = 0}, the cubics vanishing on the
orbit of W_0.  Before any search for a PSD point, F_5 must lie in the IMAGE of
the certificate map at all -- a linear condition, and a necessary one.  This
file reduces that question to the dimension of a single intersection, and shows
the one obstruction known to exist is exactly the one F_5 passes.

THE PAIRING.  Apolarity pairs Sym^6 against Sym^6, and for a sextic F the
catalecticant Cat_F is the symmetric form on cubics with Cat_F(f, g) = <F, fg>.
For a Gram B on Sym^3, mu(B) = sum_ij B_ij m_i m_j, so

    <F, mu(B)> = sum_ij B_ij Cat_F(m_i, m_j) = <Cat_F, B>.

Hence F annihilates the image of Sym^2(K) exactly when Cat_F(K, K) = 0, and

    ANN = { F in (Sym^6 Weyl_5)^{O(5)} : Cat_F(K, K) = 0 },
    rank = 14 - dim ANN,          F_5 in image  <=>  F_5 _|_ ANN.

THE TWO SPACES BEING INTERSECTED.  F |-> Cat_F is injective on the invariant
sextics -- mu is surjective, so its adjoint is injective -- putting a copy of
the 14 inside the 65-dimensional space of invariant symmetric forms on Sym^3.
The forms vanishing on K x K make up 29 of that 65, counted here block by block
from the multiplicities alone:

  * on a block with lambda_2 ODD, K contains all of M_lambda, so the whole
    m(m+1)/2 must vanish;
  * on a block with lambda_2 EVEN, K has codimension 1 in M_lambda -- the orbit
    direction u survives -- so the matrix must be u (x) v + v (x) u, leaving m
    of the m(m+1)/2.

That gives 36 conditions on 65, so dim = 29, and 65 = 36 + 29 splits the
invariant forms into those supported ON K (the 36 unknowns) and those vanishing
on K x K.  A generic 14 and a generic 29 inside a 65 miss each other entirely,
14 + 29 - 65 = -22 < 0, so every dimension of ANN is a coincidence.

ONE COINCIDENCE IS KNOWN, AND F_5 IS ORTHOGONAL TO IT.  The sextic A(W_0^6) is
the invariant projection of the sixth power of W_0.  Its catalecticant is the
ORBIT AVERAGE of the rank-one forms (f, g) |-> f(gW_0) g(gW_0), of rank 3570 --
NOT any single one of them.  Reviewer 207 caught an earlier version of this
paragraph naming the rank-one form itself, which is false twice over: the
average of rank-one forms is not rank one, and the rank-one form is not
O(5)-invariant, so it cannot be the catalecticant of any invariant sextic.
The correct reason each term dies is that every f in K vanishes on the WHOLE
ORBIT of W_0, not merely at W_0.  So dim ANN >= 1 and rank <= 13, recovering the
bound.  Its pairing is

    <F, A(W_0^6)>  proportional to  F(W_0),

so F_5 _|_ A(W_0^6) precisely because F_5(W_0) = 0 -- which is how F_5 was
built.  THE ONE GUARANTEED OBSTRUCTION IS THE ONE F_5 PASSES.

WHAT IS LEFT.  If dim ANN = 1 then rank = 13, the image is the whole
13-dimensional space of invariant sextics cutting out W_0, and F_5 lies in it:
the necessary condition holds and the route survives to the PSD question.  If
dim ANN > 1, the extra directions are a second coincidence, and F_5 is excluded
exactly when it fails to annihilate one of them.

    THE ROUTE'S NECESSARY CONDITION IS: dim ANN = 1, or every extra
    direction of ANN is orthogonal to F_5.

WHICH INVARIANTS LIE IN ANN, WRITTEN WITHOUT MENTIONING Cat.  Sym^6 is spanned
by sixth powers, so the invariant sextics are spanned by their projections
A(v^6), v in Weyl_5.  Apolarity gives <v^6, h> proportional to h(v) for a sextic
h, so Cat_{v^6} is the rank-one form (f, g) |-> f(v) g(v), and averaging,

    Cat_{A(v^6)}(f, g) = integral over O(5) of f(gv) g(gv).

Setting f = g, that vanishes for every f in K exactly when f(gv) = 0 for all g
and all f in K.  Since f(gv) = <f, (gv)^3> and K = C^perp with
C = span{(g W_0)^3}, the condition is

    A(v^6) lies in ANN   <=>   v^3 lies in C.

The cone over the orbit of W_0 satisfies this, and gives back the one known
element: A((g W_0)^6) = A(W_0^6) for every g, so the whole orbit contributes a
single direction.

THIS IS WHAT REVIEWER 203 MEASURED.  Twelve gradient ascents on
||P_C u^3||^2 / ||u^3||^2 reach 1 only at points whose Lambda^2 spectrum matches
W_0's -- no v with v^3 in C off the orbit cone.  So no SECOND obstruction of the
form A(v^6) exists, as far as that search reached.

WHAT THAT DOES NOT SETTLE.  ANN is a subspace, and a subspace need not be
spanned by the sixth powers it happens to contain.  A second dimension of ANN
could be a combination of A(v^6) with no single v^3 in C.  So the search above
is evidence and not a proof, and dim ANN = 1 stays open.

This file establishes the reduction, the 65 = 36 + 29 split, and the
v^3-in-C criterion.  Deciding dim ANN needs Cat_F block by block for a basis of
the 14, which is the next computation and is not done here.
"""
MULT = {(0,0):1,(1,0):1,(2,0):2,(3,0):2,(2,1):2,(2,2):4,(4,0):2,(3,1):2,
        (3,3):1,(5,0):1,(3,2):3,(6,0):1,(4,1):2,(4,4):2,(4,2):4,(4,3):2,
        (5,1):1,(5,2):2,(5,4):1,(5,3):1,(6,6):1,(6,2):1,(6,3):1,(6,4):1}
assert len(MULT) == 24 and sum(MULT.values()) == 41

EVEN = {l: m for l, m in MULT.items() if l[1] % 2 == 0}
ODD = {l: m for l, m in MULT.items() if l[1] % 2 == 1}
assert len(EVEN) == 16 and len(ODD) == 8

FORMS = sum(m*(m+1)//2 for m in MULT.values())          # invariant forms on Sym^3
ONK = (sum((m-1)*m//2 for m in EVEN.values())           # supported on K
       + sum(m*(m+1)//2 for m in ODD.values()))
# NOT NAMED "ANN" -- reviewer 207.  The docstring's ANN is a SUBSPACE OF THE 14,
# and this is the dimension of a subspace of the 65.  With both called ANN,
# "rank = 14 - dim ANN" reads off this 29 and gives -15.
KILLKK = sum(m for m in EVEN.values())                  # forms vanishing on K x K
SEXTICS = 14

print("=== the necessary condition, reduced ===\n")
print(f"  invariant symmetric forms on Sym^3(Weyl_5)   {FORMS}")
print(f"    of which supported on K -- the unknowns    {ONK}")
print(f"    of which vanishing on K x K                {KILLKK}")
assert (FORMS, ONK, KILLKK) == (65, 36, 29)
assert ONK + KILLKK == FORMS, "the two subspaces must split the 65"

print(f"\n  invariant sextics                            {SEXTICS}")
print(f"  Cat embeds them in the {FORMS}, and a generic {SEXTICS} meets a")
print(f"  generic {KILLKK} in {SEXTICS + KILLKK - FORMS} dimensions -- so every")
print("  dimension of ANN is a coincidence.")
assert SEXTICS + KILLKK - FORMS < 0

print("\n  ONE coincidence is known: A(W_0^6), whose catalecticant is the ORBIT")
print("  AVERAGE of the rank-one forms (f,g) |-> f(gW_0) g(gW_0), of rank 3570.")
print("  It kills K x K because every f in K vanishes on the WHOLE ORBIT.")
print(f"  So dim ANN >= 1 and rank <= {SEXTICS - 1}.")
print("\n  <F, A(W_0^6)> is proportional to F(W_0), and F_5(W_0) = 0, so F_5 is")
print("  ORTHOGONAL to the one obstruction guaranteed to exist.")
print(f"\n  NECESSARY CONDITION: dim ANN = 1 (giving rank {SEXTICS-1} and F_5 in")
print("  the image), or every extra direction of ANN annihilates F_5.")

print("\n  WRITTEN WITHOUT Cat: A(v^6) lies in ANN exactly when v^3 lies in")
print("  C = span{(g W_0)^3}.  The orbit cone gives the one known direction,")
print("  and reviewer 203's twelve gradient ascents found no v off it.")
print("  That is EVIDENCE, not proof: a subspace need not be spanned by the")
print("  sixth powers it contains.")
