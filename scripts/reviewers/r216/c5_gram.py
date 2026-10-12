"""r216, claim 5.  Is "the covariants' Gram has rank m_lambda per block" a
sufficient span check, and what does it miss?

The good direction first, then three ways it passes on a family that does not
span.  Everything here is elementary linear algebra over an invariant pairing,
which is what makes it worth writing down: the check is sound, but only after
three preconditions that the commit does not state.
"""
import numpy as np
from fractions import Fraction as F

print("A.  THE DIRECTION IS RIGHT, and conservatively so.")
print("    Let M_lambda be the multiplicity space, dim m_lambda, and let the")
print("    covariants D_1..D_N lie in it.  For any pairing,")
print("        rank Gram(D) <= dim span{D_i} <= m_lambda,")
print("    so rank = m_lambda forces span = M_lambda.  The test cannot pass a")
print("    family that fails to span.  If in addition the pairing is invariant")
print("    and nondegenerate on M_lambda -- true for the apolar pairing on a")
print("    self-dual block -- the converse holds too and the test is exact.")
print()
print("    COROLLARY WORTH USING: rank over GF(p) is the safe direction.")
print("        rank_p <= rank_Q <= m_lambda,")
print("    so a mod-p rank equal to m_lambda certifies spanning over Q with no")
print("    lifting and no rational arithmetic.  A FLOATING-POINT rank is not")
print("    safe: it can only overestimate, which is the direction that passes a")
print("    deficient family.")
print()

print("B.  MISS 1 -- the check inherits m_lambda, and the route it replaces")
print("    produced m_lambda.")
print("    The test certifies dim span{D_i} >= m_lambda_STATED.  Spanning follows")
print("    only if m_lambda_stated equals the true multiplicity.  If the peel")
print("    understates one multiplicity, a deficient family passes and nothing")
print("    downstream notices.  Highest-weight vectors are a basis by")
print("    construction: their COUNT is an independent measurement of m_lambda,")
print("    which is exactly the cross-check the switch gives up.")
print("    (c5_racah.py supplies that count by Racah's alternating sum.)")
print()

print("C.  MISS 2 -- it presupposes each D_i sits in ONE block, and raw")
print("    contraction diagrams do not.")
rng = np.random.default_rng(216)
# an invariant pairing on M_lambda (+) M_mu decouples the blocks by Schur, so a
# Gram formed on unprojected diagrams is the SUM of the per-block Grams.
m_lambda = 2
# D_1 lies in block lambda, D_2 lies in block mu.  Coordinates: (lambda-part | mu-part)
D = np.array([[1.0, 0.0, 0.0],       # lambda-component (1,0), mu-component 0
              [0.0, 0.0, 1.0]])      # lambda-component (0,0), mu-component 1
G = D @ D.T                          # the invariant pairing, block diagonal
print(f"    two diagrams, block structure (lambda: 2 coords | mu: 1 coord)")
print(f"    Gram = {G.tolist()}, rank {np.linalg.matrix_rank(G)} = m_lambda = {m_lambda}")
lam_part = D[:, :2]
print(f"    but the lambda-components span dimension "
      f"{np.linalg.matrix_rank(lam_part)} < {m_lambda}: the family does NOT span")
print("    M_lambda.  The check passed because the mu-block contributed rank.")
print("    So the Gram must be formed on covariants ALREADY PROJECTED into the")
print("    block -- and that projection is linear algebra inside Sym^3, which is")
print("    the cost run_n12_route.py says the diagram route avoids entirely")
print("    ('forms no weight space at all').  The obligation and the advantage")
print("    are in tension and the commit records only the advantage.")
print()

print("D.  MISS 3 -- it presupposes the pairing is G-invariant.")
print("    Blocks decouple by Schur's lemma only for an invariant pairing.  With")
print("    a non-invariant one the Gram is not block diagonal, 'rank m_lambda per")
print("    block' is not well defined, and the per-block ranks do not add to the")
print("    rank of the whole.  A witness:")
Q = rng.standard_normal((3, 3))
Gn = D @ Q @ D.T
print(f"    same two diagrams under a non-invariant pairing: Gram rank "
      f"{np.linalg.matrix_rank(Gn)}, still {m_lambda}, and still not spanning.")
print()

print("E.  MISS 4 -- it says nothing about whether the D_i are covariants.")
print("    Rank of a Gram is insensitive to equivariance.  A family of arbitrary")
print("    sextics of the right degree can have Gram rank m_lambda.  The n=5")
print("    build carries a live equivariance guard (r214 recorded its output);")
print("    the n=12 diagram route needs the same guard, and the check as stated")
print("    does not contain one.")
print()
print("F.  MISS 5 -- coverage.  The check is per-lambda.  Passing it on the")
print("    blocks that were tested says nothing about the blocks that were not,")
print("    and for the six FUSED chirality pairs 'rank m_lambda on the O(12)")
print("    block' is a statement about a space that is reducible as SO(12), so")
print("    the multiplicity used must be the O(12) one (184) and not the SO(12)")
print("    one (191).  The two differ on exactly those six blocks.")
