"""How much a vanishing slack actually constrains, as a function of dim m.

S measures whether [m,m] has a component in m, where m is the negative eigenspace
of W.  Its strength therefore depends on how big m is:

    point                n   dim m   dim [m,m]   slack S
    W_CP2 padded         8     2         1       -1.4e-47
    W_CP2 padded        10     2         1        1.8e-48
    W_CP2 padded        12     2         1        1.8e-46
    balanced S^p x S^p   8    16         -        0.0
    balanced S^p x S^p  12    36         -        0.0

At W_CP2 the negative eigenspace is TWO-dimensional, so [m,m] is spanned by a
single bracket and S = 0 is one scalar condition.  At a balanced sphere product m
has dimension 36 and S = 0 is a large system.  The slack magnitudes reflect it:
1e-46 against 1e-28, because at W_CP2 there is almost nothing to cancel.

WHY THIS MATTERS.  The refutation of "S = 0 implies Z_2-graded" (Reviewers 30 and
31) rests on W_CP2 as its counterexample.  That counterexample is weaker than it
looks: S = 0 there is close to automatic, not a structural coincidence.  The
implication may well survive under a hypothesis that keeps m large enough for S = 0
to bite -- which is a different repair from the one currently recorded.

W_CP2 padded also sits ON the eigenvalue-jump locus: 2 negative, 1 positive, and
42 zero eigenvalues at n = 10 (63 at n = 12).  dim m is exactly where a
perturbation can change it discontinuously.  Openness still holds there, because
W_CP2 is Morse-Bott nondegenerate (b_cp2_nondegenerate.py), so nearby critical
points are just its orbit -- but S as a formula is fragile at that point.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import adj, sphere_product_W
from b_cp2_nondegenerate import padded_cp2
from b_padded_s3s3 import slack

def content(n, W):
    """dim m, dim [m,m], and the slack."""
    N = n * (n - 1) // 2; A = adj(n)
    w, V = np.linalg.eigh(W); neg = V[:, w < -1e-9]; k = neg.shape[1]
    brk = []
    for i in range(k):
        Xi = sum(neg[c, i] * A[c] for c in range(N))
        for j in range(i + 1, k):
            Xj = sum(neg[c, j] * A[c] for c in range(N))
            C = Xi @ Xj - Xj @ Xi
            brk.append(np.array([np.trace(C @ A[c].T) for c in range(N)]) / 2)
    r = 0 if not brk else int(np.linalg.matrix_rank(np.array(brk), tol=1e-9))
    zeros = int((np.abs(w) < 1e-9).sum())
    return k, r, slack(n, W, A, N), zeros

if __name__ == "__main__":
    print(f"{'point':>22} {'n':>3} {'dim m':>6} {'dim[m,m]':>9} {'zeros':>6} {'slack':>11}")
    for n in (8, 10, 12):
        W, _ = padded_cp2(n)
        k, r, S, z = content(n, W)
        print(f"{'W_CP2 padded':>22} {n:3d} {k:6d} {r:9d} {z:6d} {S:11.2e}", flush=True)
    for n in (8, 12):
        p = n // 2
        W, _ = sphere_product_W((p, n - p)); W = W / np.linalg.norm(W)
        k, r, S, z = content(n, W)
        print(f"{'balanced S^p x S^p':>22} {n:3d} {k:6d} {r:9d} {z:6d} {S:11.2e}", flush=True)
