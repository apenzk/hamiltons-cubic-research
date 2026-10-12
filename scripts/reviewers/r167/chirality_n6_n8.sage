"""Direct SO(2r) runs at n = 6 and n = 8, counting the chiral (self-associate) blocks.

RUN:  sage scripts/reviewers/r167/chirality_n6_n8.sage      (n = 8 takes a few minutes)

Reviewer r167.  Two things are established here.

n = 6 IS NOT EXCLUDED.  In D_3 node 2 is one of the two fork nodes, so omega_2 =
(1,1,-1)/2 is a half-spin weight and 2*omega_2 = (1,1,-1) is the 10-dimensional
Sym^2 C^4 of the exceptional D_3 = A_3.  The Young label [2,2] = 2e_1 + 2e_2 is
2*(omega_2 + omega_3), which has dimension 84 = dim Weyl_6 exactly.

CHIRALITY.  A weight whose last ambient coordinate is nonzero has exactly r rows, so
its O(2r)-irreducible is self-associate and splits into a mirror pair under SO(2r).
The pairs are printed with their multiplicities, which agree pairwise as the O(2r)
action forces.
"""
import sys


def audit(label, rank, n, hw):
    R = WeylCharacterRing(label, style="coroots")
    fw = R.fundamental_weights()
    W = R(sum(c * fw[i] for i, c in hw))
    D = (n + 2) * (n + 1) * n * (n - 3) // 12
    print("n=%d  highest weight %s  dim %d (target %d)" % (n, hw, W.degree(), D))
    assert W.degree() == D
    sys.stdout.flush()
    S3 = W.symmetric_power(3)
    d = S3.monomial_coefficients()
    rows = [(tuple(QQ(x) for x in wt.to_vector()), c) for wt, c in d.items()]
    chi = sorted((v, c) for v, c in rows if v[-1] != 0)
    triv = [c for v, c in rows if all(x == 0 for x in v)]
    print("  SO(%d) blocks %d, total dim %d (target %d), trivial multiplicity %s"
          % (n, len(d), S3.degree(), binomial(D + 2, 3), triv))
    print("  chiral SO blocks %d  =>  %d mirror pairs  =>  %d self-associate O(%d)-irreducibles"
          % (len(chi), len(chi) // 2, len(chi) // 2, n))
    print("  O(%d) block count = %d - %d + p = %d + p,  p = number of merged associate pairs"
          % (n, len(d), len(chi) // 2, len(d) - len(chi) // 2))
    print("  chiral pairs:", chi)
    print("  multiplicity profile:", sorted((c for v, c in rows), reverse=True))
    sys.stdout.flush()


audit("D3", 3, 6, [(2, 2), (3, 2)])
audit("D4", 4, 8, [(2, 2)])
