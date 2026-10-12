"""VALIDATION of r265/r266: are trilinear Weyl invariants already 2-dimensional
on THREE INDEPENDENT slots?

WHY THIS RUN EXISTS.  r265 and r266 refuted a claim this programme had recorded --
that Weyl's restitution explained the collapse of the 10,395 Brauer functionals to
rank 2 -- by asserting that on three INDEPENDENT Weyl slots the invariant trilinear
forms are ALREADY 2-dimensional, so restitution accounts for none of the loss.
That refutation retracted a proved result and rewrote the plan, and it was applied
without being reproduced.

  A REFUTATION CARRIES THE HEAVIER BURDEN, because it closes routes and nobody
  reopens a closed route to check.  So it is checked here.

INDEPENDENCE OF METHOD.  Nothing below imports the reviewers' scripts or the
record's own contraction code.  Weyl tensors are built from scratch (antisymmetrise,
project out the Bianchi part, remove traces), the matchings are generated here, and
the contraction is staged pairwise rather than through a 12-index einsum.

WHAT THE TEST CAN AND CANNOT DO.  Sampling matchings gives a LOWER bound on the
dimension of the span, so it can REFUTE "the dimension is 2" by exhibiting 3
independent functionals, and it cannot by itself prove the dimension is not larger.
That asymmetry is the right way round: the claim under test is the reviewers', and
a lower bound is what would overturn it.
"""
import numpy as np
from random import Random

def weyl(n, rng):
    """A Weyl tensor, built in ONE pass rather than by iterating projectors.

    A first version alternated symmetrisation and trace removal in a loop and
    DIVERGED -- neither step is idempotent in the presence of the other, so the
    residuals grew instead of shrinking.  The classical decomposition does it
    once: antisymmetrise into an algebraic curvature tensor, subtract the totally
    antisymmetric part to impose Bianchi, then subtract the Ricci and scalar parts
    by the Kulkarni-Nomizu formula.
    """
    R = rng.standard_normal((n, n, n, n))
    R = R - R.transpose(1, 0, 2, 3)
    R = R - R.transpose(0, 1, 3, 2)
    R = R + R.transpose(2, 3, 0, 1)
    R = R - (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3   # Bianchi, once

    I = np.eye(n)
    def kn(h, g):                       # Kulkarni-Nomizu product
        return (np.einsum('ik,jl->ijkl', h, g) + np.einsum('jl,ik->ijkl', h, g)
                - np.einsum('il,jk->ijkl', h, g) - np.einsum('jk,il->ijkl', h, g))
    ric = np.einsum('ikjk->ij', R)
    sca = np.trace(ric)
    ric0 = ric - (sca / n) * I
    W = R - kn(ric0, I) / (n - 2) - sca * kn(I, I) / (2 * n * (n - 1))

    b = np.abs(W + W.transpose(0, 2, 3, 1) + W.transpose(0, 3, 1, 2)).max()
    t = np.abs(np.einsum('ikjk->ij', W)).max()
    assert b < 1e-9 and t < 1e-9, f"not a Weyl tensor: Bianchi {b:.1e}, trace {t:.1e}"
    return W / np.sqrt(np.einsum('ijkl,ijkl->', W, W))

def contract(A, B, C, matching):
    """Evaluate the full contraction of A,B,C along `matching` on 12 legs.

    Legs 0-3 are A's, 4-7 B's, 8-11 C's.  Done by relabelling into an einsum
    subscript string -- each matched pair gets one shared index letter, so numpy
    plans the contraction rather than materialising 12 free indices.
    """
    letters = {}
    for k, (a, b) in enumerate(matching):
        letters[a] = letters[b] = chr(ord('a') + k)
    sub = "".join(letters[i] for i in range(4)) + "," + \
          "".join(letters[i] for i in range(4, 8)) + "," + \
          "".join(letters[i] for i in range(8, 12))
    return float(np.einsum(sub, A, B, C, optimize=True))

def random_matchings(count, rng):
    out = set()
    while len(out) < count:
        pts = list(range(12)); rng.shuffle(pts)
        m = tuple(sorted(tuple(sorted((pts[2*i], pts[2*i+1]))) for i in range(6)))
        out.add(m)
    return sorted(out)

for n in (6, 7):
    rng = np.random.default_rng(11)
    ms = random_matchings(1200, Random(5))
    triples_indep = [(weyl(n, rng), weyl(n, rng), weyl(n, rng)) for _ in range(24)]
    Ws = [weyl(n, rng) for _ in range(24)]
    triples_diag = [(W, W, W) for W in Ws]

    def rank_on(triples):
        M = np.array([[contract(A, B, C, m) for m in ms] for A, B, C in triples])
        s = np.linalg.svd(M, compute_uv=False)
        return int((s > s[0] * 1e-9).sum())

    r_ind = rank_on(triples_indep)
    r_dia = rank_on(triples_diag)
    print(f"  n={n}:  independent slots -> rank {r_ind}     diagonal (W,W,W) -> rank {r_dia}")
    assert r_ind >= r_dia, "the diagonal cannot see more than independent slots do"

print("\n  r265/r266 claim the independent-slot rank is already 2, so restitution")
print("  loses nothing and cannot explain the 10,393.  A rank of 3 or more on")
print("  independent slots would refute them.")
