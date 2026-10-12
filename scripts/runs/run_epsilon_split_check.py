"""Measure epsilon = <A, Q(W) - theta W> at graded critical points.

CHECKS A DERIVED STATEMENT, which is the licensed use.  The derivation
(findings/graded-half.md) says the graded criticality split contains exactly one new
scalar equation, namely epsilon = 0, because <A, N> = -<B, N> for N := Q(W) - theta W:
N is perpendicular to Weyl_n, W lies in it, and W block-diagonal kills the cross term.

So this run measures three things at each point and nothing else:
    epsilon      = <A, N>            -- the whole content of the split
    epsilon_B    = <B, N>            -- must equal -epsilon, which tests the derivation
    ||N||        = ||Q(W) - theta W|| -- how far criticality is from exact

The equivariant point S^3 x S^5 and the n = 8 non-equivariant witness on the same pair
are the two that matter: a nonzero epsilon at the witness makes the split a property of
the equivariant locus, where V2 does not live.
"""
import sys
import numpy as np

sys.path.insert(0, 'scripts/lib')
sys.path.insert(0, 'scripts/runs')
from review_r30_core import pair_index, Q, sphere_product_W


def block_projector(n, p):
    """P onto frak-p = so(p) (+) so(n-p) inside Lambda^2 R^n, as a diagonal 0/1 matrix."""
    pairs, _ = pair_index(n)
    d = np.array([1.0 if ((i < p) == (j < p)) else 0.0 for (i, j) in pairs])
    return np.diag(d)


def report(name, n, p, W):
    W = W / np.linalg.norm(W)
    QW = Q(n, W)
    th = float(np.tensordot(QW, W))
    N = QW - th * W
    P = block_projector(n, p)
    Pm = np.eye(P.shape[0]) - P
    A = P @ W @ P
    B = Pm @ W @ Pm
    cross = W - A - B
    eps_A = float(np.tensordot(A, N))
    eps_B = float(np.tensordot(B, N))
    print(f"\n{name}   n={n}  p={p}  theta={th:.9f}")
    print(f"  ||W - A - B||        = {np.linalg.norm(cross):.3e}   (0 iff W is graded)")
    print(f"  ||N|| = ||Q-thW||    = {np.linalg.norm(N):.3e}")
    print(f"  ||A||^2              = {float(np.tensordot(A, A)):.9f}")
    print(f"  epsilon   = <A,N>    = {eps_A:+.3e}")
    print(f"  epsilon_B = <B,N>    = {eps_B:+.3e}")
    print(f"  sum (derivation says 0) = {eps_A + eps_B:+.3e}")
    return th, eps_A, eps_B


if __name__ == '__main__':
    # control: the equivariant point on the pair so(3) (+) so(5)
    report("S^3 x S^5 (equivariant)", 8, 3, sphere_product_W([3, 5])[0])
    # the balanced product, a different pair, as a second control
    report("S^4 x S^4 (equivariant)", 8, 4, sphere_product_W([4, 4])[0])
    # the point that matters
    W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
    report("n=8 non-equivariant witness", 8, 3, W)


def q_preserves_weyl(n, trials=4, seed=0):
    """Is N ever nonzero at all?  Test whether Q maps Weyl_n into Weyl_n.

    If it does, then criticality (which is stated projected) forces N := Q(W) - theta W
    to lie in Weyl_n while being perpendicular to it, hence N = 0, and the epsilon
    caveat is vacuous rather than merely satisfied at the tested points.
    """
    from b_weyl_projector_free import weyl_project
    rng = np.random.default_rng(seed)
    N_ = len(pair_index(n)[0])
    print(f"\n--- does Q map Weyl_{n} into Weyl_{n}?  (random Weyl tensors) ---")
    for t in range(trials):
        X = rng.standard_normal((N_, N_))
        W = weyl_project(n, 0.5 * (X + X.T))
        W /= np.linalg.norm(W)
        chk = np.linalg.norm(W - weyl_project(n, W))
        QW = Q(n, W)
        off = np.linalg.norm(QW - weyl_project(n, QW))
        print(f"  trial {t}: ||W - Pi W|| = {chk:.2e}   ||Q(W) - Pi Q(W)|| = {off:.3e}"
              f"   (||Q(W)|| = {np.linalg.norm(QW):.3f})")


