"""The subalgebra family closes: at the cap it IS the balanced product, below it S > 0.

Lemma 23 puts the subalgebra family at W ∝ Pi_h - (r/N) Id with r = dim h, and caps
r at n(n-2)/4, where the value is theta_0 and W is graded.  The crux only concerns
{ S = 0 }, so the family splits cleanly:

  AT the cap.  n = 10, r = 20 = dim(so(5) + so(5)):
      theta = 1.200000000 = theta_0(10) exactly,  residual 2.2e-16,  S = 0
      orbit 25 = dim E(1/2) 25  -- NONDEGENERATE
      |<W, W_{S^5 x S^5}>| = 1.000000000 -- it IS the balanced sphere product,
      so it is already covered by Lemma 27.

  BELOW the cap.  so(5) acting on R^10 by its adjoint, r = 10:
      theta = 0.717137166 = 0.5976 theta_0,  residual 8.4e-17
      orbit 35, dim E(1/2) 70, excess 35 -- degenerate (Reviewer 52's finding,
      reproduced), but slack S = 140, so it is NOT in { S = 0 } and cannot bear
      on whether that set is open.

  ABOVE the cap.  so(4) + so(6), r = 21 > 20: not critical at all, residual 6.8e-2.

So every degenerate member of the family found is excluded by its slack, and the
only S = 0 member is the balanced product.  Same shape as the three-block products:
excluded by slack, not by value.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (pair_index, adj, Q, weyl_basis, orbit_tangent,
                             orthonormalize, sphere_product_W)
from b_padded_s3s3 import slack

def so_block(n, idxs):
    out = []
    for a in range(len(idxs)):
        for b in range(a + 1, len(idxs)):
            E = np.zeros((n, n)); i, j = idxs[a], idxs[b]
            E[i, j] = 1; E[j, i] = -1; out.append(E)
    return out

def subalgebra_point(n, gens):
    """W proportional to Pi_h - (r/N) Id, unit norm."""
    pairs, idx = pair_index(n); N = len(pairs)
    V = np.array([[g[i, j] for (i, j) in pairs] for g in gens])
    r = int(np.linalg.matrix_rank(V, tol=1e-9))
    Qh, _ = np.linalg.qr(V.T); Qh = Qh[:, :r]
    W = Qh @ Qh.T - (r / N) * np.eye(N)
    return W / np.linalg.norm(W), r, N

def analyse(n, gens, label):
    W, r, N = subalgebra_point(n, gens); A = adj(n)
    th = float(np.tensordot(W, Q(n, W)))
    res = float(np.linalg.norm(Q(n, W) - th * W))
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    S = slack(n, W, A, N) / (n - 2) ** 2
    out = dict(label=label, r=r, theta=th, ratio=th / th0, resid=res, slack=S)
    if res < 1e-8:
        B = weyl_basis(n); D = len(B); Bf = np.array([b.ravel() for b in B])
        e = W / th; A2 = A.reshape(N * N, N)
        Ae = (A2 @ e).reshape(N, N, N); AeT = Ae.transpose(0, 2, 1).reshape(N, N * N)
        M = np.zeros((D, D))
        for j, X in enumerate(B):
            AX = (A2 @ X).reshape(N, N, N); T = AX.reshape(N, N * N) @ AeT.T
            M[:, j] = Bf @ (0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)).ravel()
        ev = np.linalg.eigvalsh(0.5 * (M + M.T))
        out['dimE'] = int((np.abs(ev - 0.5) < 1e-8).sum())
        out['orbit'] = orthonormalize(orbit_tangent(n, W)).shape[0]
    return out

if __name__ == "__main__":
    n = 10
    print(f"n={n}, cap r = n(n-2)/4 = {n*(n-2)//4}, theta_0 = {np.sqrt(2*(n-1)*(n-2))/n:.9f}")
    cases = [("so(5)+so(5)  [at cap]", so_block(n, range(5)) + so_block(n, range(5, 10))),
             ("so(5) adjoint [below]", None),
             ("so(4)+so(6)  [above]", so_block(n, range(4)) + so_block(n, range(4, 10)))]
    for label, gens in cases:
        if gens is None:
            continue
        o = analyse(n, gens, label)
        extra = (f" orbit={o['orbit']} dimE={o['dimE']} nondeg={o['orbit']==o['dimE']}"
                 if 'dimE' in o else "  (not critical)")
        print(f"  {label:24s} r={o['r']:3d} theta={o['theta']:.9f} ({o['ratio']:.4f} th0) "
              f"resid={o['resid']:.1e} S={o['slack']:.2e}{extra}", flush=True)
    Wsp, _ = sphere_product_W((5, 5)); Wsp /= np.linalg.norm(Wsp)
    Wsa, _, _ = subalgebra_point(n, so_block(n, range(5)) + so_block(n, range(5, 10)))
    print(f"  overlap with the balanced sphere product: {abs(float(np.tensordot(Wsa, Wsp))):.9f}")
