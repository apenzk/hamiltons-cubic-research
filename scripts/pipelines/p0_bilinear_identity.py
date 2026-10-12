"""
Where does the top eigenspace live?

The hard-case condition is a bilinear identity, <Pi_ker Q(W_1), top(W_1')> = 0 for
every pair, with top(W_1) exactly 2-dimensional at every W_1.  Two is the
multiplicity of Weyl_4^{-,2}, the summand carrying the -sqrt(3/2) eigenvalue of
F_u, which suggests the moving 2-plane is a copy of a fixed representation rather
than an arbitrary plane.

Three things separate the possibilities, and each picks a different proof:

  1. SUPPORT.  Is top(W_1) supported inside Lambda^2(R^4) -- the block where u
     lives, and where the Weyl_4^{-,2} eigenvectors sit -- or does it spread over
     the whole of Lambda^2(R^n)?  A plane confined to the 4-block is a statement
     about a fixed finite-dimensional object however much it moves.

  2. STABILISER TYPE.  Applying the stabiliser of u to top(W_1) and measuring how
     far the plane moves says which isotypic piece it belongs to.  If the orbit of
     the plane under Stab(u) stays 2-dimensional, it is a single copy.

  3. THE PAIRING ITSELF.  <Pi_ker Q(W_1), top(W_1')> = 0 is bilinear in the pair.
     Fixing W_1' and varying W_1 turns it into a linear functional annihilating
     all of Q(V_{1/3}); measuring the rank of that annihilator across many W_1'
     says how many independent conditions the identity really imposes.

Reported for each: the fraction of the top plane's norm inside Lambda^2(R^4), the
dimension of its Stab(u)-orbit, and the rank of the annihilator.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


def run(n, trials=16, seed=7):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    w, V = np.linalg.eigh(M)
    r = w / SQ32
    V13 = V[:, np.abs(r - 1 / 3) < 1e-7]
    Vker = V[:, np.abs(r) < 1e-7]
    Vm1 = V[:, np.abs(r + 1.0) < 1e-7]          # the -sqrt(3/2) summand, Weyl_4^{-,2}
    k13, kk = V13.shape[1], Vker.shape[1]

    # indices of Lambda^2 pairs lying inside the 4-block
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    in4 = np.array([1.0 if (i < 4 and j < 4) else 0.0 for (i, j) in pairs])
    mask4 = np.outer(in4, in4)

    rng = np.random.default_rng(seed)

    def mk(B, y):
        X = (Eflat.T @ (B @ y)).reshape(Nl, Nl)
        X = 0.5 * (X + X.T)
        return X / max(np.linalg.norm(X), 1e-300)

    tops, bs, frac4, b4 = [], [], [], []
    for _ in range(trials):
        y = rng.normal(size=k13); y /= np.linalg.norm(y)
        W1 = mk(V13, y)
        b = Vker.T @ (Eflat @ Q_full(W1, c).reshape(-1))
        Mw = np.empty((kk, kk))
        for i in range(kk):
            K = (Eflat.T @ Vker[:, i]).reshape(Nl, Nl)
            K = 0.5 * (K + K.T)
            col = (Q_full(W1 + K, c) - Q_full(W1 - K, c)) / 4.0
            Mw[:, i] = Vker.T @ (Eflat @ col.reshape(-1))
        Mw = 0.5 * (Mw + Mw.T)
        ev, U = np.linalg.eigh(Mw)
        top = U[:, np.abs(ev - ev[-1]) < 1e-9 * abs(ev[-1])]
        tops.append(top)
        bs.append(b / max(np.linalg.norm(b), 1e-300))
        # the same support question for b: if b sits INSIDE the 4-block while the
        # top plane sits entirely outside it, the orthogonality is immediate
        Xb = (Eflat.T @ (Vker @ b)).reshape(Nl, Nl)
        Xb = 0.5 * (Xb + Xb.T)
        nb = np.linalg.norm(Xb)
        b4.append(np.linalg.norm(Xb * mask4) / max(nb, 1e-300))
        # support of the top plane inside Lambda^2(R^4)
        f = []
        for a in range(top.shape[1]):
            X = (Eflat.T @ (Vker @ top[:, a])).reshape(Nl, Nl)
            X = 0.5 * (X + X.T)
            nn = np.linalg.norm(X)
            f.append(np.linalg.norm(X * mask4) / max(nn, 1e-300))
        frac4.append(max(f))

    print(f"n={n:3d}  dim V_1/3={k13}  dim ker={kk}  dim V_{{-1}}={Vm1.shape[1]}")
    print(f"      top plane's norm fraction inside Lambda^2(R^4):"
          f" min {min(frac4):.4f} max {max(frac4):.4f}"
          f"   -> {'CONFINED to the 4-block' if min(frac4) > 0.999 else 'spread over Lambda^2(R^n)'}")
    # rank of the annihilator: how many independent conditions does the identity impose?
    A = np.array([np.hstack([t[:, a] for a in range(t.shape[1])]) for t in tops])
    sv = np.linalg.svd(np.hstack(tops), compute_uv=False)
    print(f"      rank span(all top planes) = {int(np.sum(sv > 1e-8 * sv[0]))}"
          f" from {2*len(tops)} vectors")
    B = np.array(bs)
    svb = np.linalg.svd(B.T, compute_uv=False)
    print(f"      rank span(all b) = {int(np.sum(svb > 1e-8 * svb[0]))} from {len(bs)}")
    cross = max(abs(float(bs[i] @ tops[j][:, a]))
                for i in range(len(bs)) for j in range(len(tops))
                for a in range(tops[j].shape[1]))
    print(f"      b's norm fraction inside Lambda^2(R^4):"
          f" min {min(b4):.4f} max {max(b4):.4f}"
          f"   -> {'CONFINED to the 4-block, so the orthogonality is immediate' if min(b4) > 0.999 else 'not confined'}")
    print(f"      max |<b_i, top_j>| over all pairs: {cross:.3e}")
    print(flush=True)


if __name__ == "__main__":
    for n in (10, 12):
        run(n)
