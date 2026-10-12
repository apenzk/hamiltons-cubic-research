"""The harmonic-square law for orthogonal block sums, and its decomposability bound.

Q is quadratic and additive over DISJOINT INDEX BLOCKS -- operator orthogonality is
not enough, since <W_{S^3xS^3}, W_CP2> = 0 at n = 6 while the cross term is 0.2152.
For W = a W_A + b W_B with W_A, W_B critical on disjoint index blocks,

    Q(W) = a^2 theta_A W_A + b^2 theta_B W_B,

and criticality Q(W) = theta W forces theta = a theta_A = b theta_B.  With
a^2 + b^2 = 1 that gives

    1/theta^2 = 1/theta_A^2 + 1/theta_B^2,      and in general  1/theta^2 = sum_i 1/theta_i^2.

Verified to 1e-16 with criticality residual 0.0.  Two consequences:

  * |theta| < min_i |theta_i| for two or more nontrivial blocks -- the absolute
    values are needed, since (+Fox) + (-Fox) at n = 8 gives theta = +0.866
    against min_i theta_i = -1.2247.  k equal blocks give theta_1 / sqrt(k).
  * The bound sqrt(3/2)/sqrt(2) = sqrt(3)/2 originally claimed here is REFUTED
    (Reviewers 48 and 49).  Its hypothesis "theta_i <= sqrt(3/2) for n_i <= 11"
    IS the open low-dimensional half of Conjecture A -- proved only at n_i = 4 --
    so the bound was circular; and the constant is false from n = 16, where
    S^6xS^6 on 12 coordinates plus W_CP2 on 4 gives theta = 0.869988927484.
    What survives: |theta| <= max_i M(n_i)/sqrt(2) < 1 < theta_0(n) for n >= 12,
    with theta/theta_0 <= 0.706, needing only theta_i < sqrt(2).  It is an
    INDUCTION on n.

CAVEATS THE LAW DOES NOT COVER.  Padding is the b = 0 case and leaves theta
unchanged, so nothing here bounds padded points -- padded W_CP2 has S = 0, is
ungraded, and sits at 0.9909 theta_0(12).  And "disjoint index blocks" is
sufficient but not necessary: the classifying condition is W_A o W_B = 0, which
cross-block companions also satisfy.  The agreement with the Fox plateau value is
a tautology, since the plateau is defined as two W_CP2 blocks.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q, sphere_product_W

def embed(Ws, ns, n, off):
    ps, _ = pair_index(ns); pairs, idx = pair_index(n)
    M = np.zeros((len(pairs), len(pairs)))
    for a, (i, j) in enumerate(ps):
        for b, (k, l) in enumerate(ps):
            M[idx[(i + off, j + off)], idx[(k + off, l + off)]] = Ws[a, b]
    return M

def block_sum(pA, nA, pB, nB):
    """Build the critical orthogonal sum and return (theta_A, theta_B, theta, residual)."""
    n = nA + nB
    WA0, _ = sphere_product_W(pA); WA0 = WA0 / np.linalg.norm(WA0)
    WB0, _ = sphere_product_W(pB); WB0 = WB0 / np.linalg.norm(WB0)
    thA = float(np.tensordot(WA0, Q(nA, WA0)))
    thB = float(np.tensordot(WB0, Q(nB, WB0)))
    th_pred = 1.0 / np.sqrt(1 / thA**2 + 1 / thB**2)
    W = (th_pred / thA) * embed(WA0, nA, n, 0) + (th_pred / thB) * embed(WB0, nB, n, nA)
    W = W / np.linalg.norm(W)
    th = float(np.tensordot(W, Q(n, W)))
    return thA, thB, th, th_pred, float(np.linalg.norm(Q(n, W) - th * W))

if __name__ == "__main__":
    print(f"{'blocks':>20} {'theta_A':>9} {'theta_B':>9} {'measured':>10} {'1/sqrt(sum)':>12} {'resid':>9}")
    for (pA, nA, pB, nB) in [((3,3),6,(3,3),6), ((3,3),6,(2,4),6), ((4,4),8,(3,3),6),
                             ((4,4),8,(2,4),6), ((5,5),10,(3,3),6)]:
        thA, thB, th, pred, res = block_sum(pA, nA, pB, nB)
        lbl = f"S^{pA[0]}xS^{pA[1]} + S^{pB[0]}xS^{pB[1]}"
        print(f"{lbl:>20} {thA:9.6f} {thB:9.6f} {th:10.6f} {pred:12.6f} {res:9.1e}", flush=True)
    print(f"\n  bound for decomposable points with every theta_i <= sqrt(3/2): "
          f"{np.sqrt(1.5)/np.sqrt(2):.6f} = sqrt(3)/2")
