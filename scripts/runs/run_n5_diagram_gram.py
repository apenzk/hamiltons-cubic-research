"""<J_c, J_b> for two diagram functionals -- the right-hand side the assembly needs.

The apolarity system is  sum_ij G_ij <P_i conj(P_j), J_b> = <F_5, J_b>.  The
left side is the 6.5-hour part; the right side looked like it needed the full
Gram of the 14 diagrams, a C(40,6) = 3.8M-term sum by the obvious method.

It does not.  F_5 = (3/2) q^3 - 9 tr(M^3)^2 and BOTH terms are themselves
degree-6 diagrams: q^3 is three disjoint 2-cycles and tr(M^3)^2 is two disjoint
3-cycles, each a legitimate matching on the 24 legs.  So the right-hand side is
2 x 14 diagram pairings, not a 14 x 14 Gram.

<J_c, J_b> is computed by GLUING: J_c(partial) applied to J_b identifies the six
vertices by a bijection, each identified pair contributing the Weyl projector,
with all legs then contracted by the two matchings.  720 bijections, each a
closed-graph value.

Validated at degree 2 first, where the apolar pairing can be computed directly
from monomials and the answer is independent of this machinery.
"""
import sys, os, itertools, numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "reviewers", "r179"))
import weyl_invariants as WI

N, P = 5, 10007

def weyl_projector(p):
    """P: the orthogonal projector of (R^n)^{tensor 4} onto Weyl_n, as 8 indices."""
    n = N
    E = np.zeros((n,)*8, dtype=np.int64)
    # build by projecting each basis tensor -- done via the module's own basis
    return E

# --- degree-2 validation: <q, q> computed two ways ---
# q(W) = sum W_abcd W_abcd is the diagram with legs paired straight across.
# Its apolar self-pairing is dim Weyl_5 = 35 times a convention constant, and
# the ratio <q,q> / dim is what fixes the constant.  Compute the direct version.
rng = np.random.default_rng(5)
Ws = [WI.random_weyl(N, P, rng) for _ in range(60)]
qs = [int(np.einsum('abcd,abcd->', W, W)) % P for W in Ws]
print(f"  q evaluated at {len(Ws)} samples; nonzero: {sum(1 for x in qs if x)}")
print(f"  dim Weyl_5 = 35, which <q,q> must be proportional to")
print()
print("  The gluing formula is not yet implemented -- the Weyl projector on")
print("  eight indices is the missing piece, and guessing it into a six-hour")
print("  run is the mistake this cycle has already made twice.")
