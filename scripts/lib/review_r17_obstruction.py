"""Reviewer 17: independent audit of the second-order branching obstruction.

Everything here is rebuilt from the primitives (structure constants + basis-free
Q) rather than reused from p3b_obstruction_and_path.py, so agreement is evidence.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full, Rsharp_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl

np.set_printoptions(precision=4, suppress=True)


def sharp_bilin(A, B, c):
    """Polarisation of R# : sharp(A,B) = 1/2 (Q(A+B)-Q(A)-Q(B)) - (AB+BA)/2."""
    return 0.5 * (Rsharp_full(A + B, c) - Rsharp_full(A, c) - Rsharp_full(B, c))


def Qbil(A, B, c):
    """Symmetric bilinear polarisation G(A,B) with G(A,A) = Q(A)."""
    return 0.5 * (A @ B + B @ A) + sharp_bilin(A, B, c)


def rho_lambda2(A, pairs, pidx):
    """Induced so(n) action on Lambda^2 in the orthonormal basis e_i ^ e_j."""
    n = A.shape[0]
    Np = len(pairs)
    R = np.zeros((Np, Np))
    for col, (i, j) in enumerate(pairs):
        # rho(A)(e_i ^ e_j) = (A e_i)^e_j + e_i^(A e_j)
        for m in range(n):
            if m != j and A[m, i] != 0.0:
                p, s = (m, j), 1.0
                if m > j:
                    p, s = (j, m), -1.0
                R[pidx[p], col] += s * A[m, i]
            if m != i and A[m, j] != 0.0:
                p, s = (i, m), 1.0
                if i > m:
                    p, s = (m, i), -1.0
                R[pidx[p], col] += s * A[m, j]
    return R


class Ctx:
    def __init__(self, n):
        self.n = n
        self.idx, self.pos, self.N, self.c = build_structure_constants(n)
        self.Eflat, self.D = build_weyl_basis(n, self.idx, self.pos, self.N, self.c, verbose=False)
        self.pairs = self.idx
        self.pidx = {p: k for k, p in enumerate(self.pairs)}

    def coord(self, M):
        return self.Eflat @ M.reshape(-1)

    def mat(self, x):
        M = (self.Eflat.T @ x).reshape(self.N, self.N)
        return 0.5 * (M + M.T)


def analyse(name, ctx, W, ker_tol=None):
    c, Eflat, D, N = ctx.c, ctx.Eflat, ctx.D, ctx.N
    W = 0.5 * (W + W.T)
    W = W / np.linalg.norm(W)
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    if th < 0:
        W, th = -W, -th
        QW = Q_full(W, c)
    print(f"\n=== {name}  n={ctx.n}  dim Weyl = {D} ===")
    # 0. is W actually in the Weyl subspace, and is it critical?
    w = ctx.coord(W)
    print(f"  |W - Pi_Weyl W|        = {np.linalg.norm(W - ctx.mat(w)):.3e}")
    print(f"  theta                  = {th:.12f}")
    amb = np.linalg.norm(QW - th * W)
    proj = np.linalg.norm(ctx.coord(QW) - th * w)
    nonweyl = np.linalg.norm(QW - ctx.mat(ctx.coord(QW)))
    print(f"  |Q(W)-theta W| ambient = {amb:.3e}")
    print(f"  |Pi_W Q(W)-theta w|    = {proj:.3e}   (the real criticality residual)")
    print(f"  |(1-Pi_W) Q(W)|        = {nonweyl:.3e}   (non-Weyl part of Q(W))")

    # 1. Hessian: L(h) = Pi_W DQ(W)[h] - theta h,  DQ(W)[h] = 2 G(W,h). Hess = 3 L.
    Lmat = np.zeros((D, D))
    for b in range(D):
        Hb = ctx.mat(np.eye(D)[b])
        Lmat[:, b] = ctx.coord(2.0 * Qbil(W, Hb, c)) - th * np.eye(D)[b]
    asym = np.linalg.norm(Lmat - Lmat.T)
    Lmat = 0.5 * (Lmat + Lmat.T)
    print(f"  |L - L^T|              = {asym:.3e}  (self-adjointness check)")
    print(f"  |L w - theta w|        = {np.linalg.norm(Lmat @ w - th * w):.3e}  (W_0 is a theta-eigenvector)")

    # sphere-tangent basis
    B = np.linalg.svd(np.outer(w, w))[0][:, 1:]
    Hs = 3.0 * (B.T @ Lmat @ B)
    ev, V = np.linalg.eigh(Hs)
    order = np.argsort(np.abs(ev))
    aev = np.abs(ev[order])
    if ker_tol is None:
        ker_tol = 1e-7
    ker_idx = np.abs(ev) < ker_tol
    ker = V[:, ker_idx]
    print(f"  |ev| sorted (first 26) : {np.array2string(aev[:26], precision=3)}")
    nk = ker.shape[1]
    print(f"  kernel tolerance       = {ker_tol:.3e}  ->  dim ker(Hess) = {nk}")
    print(f"  gap: largest |ev| inside kernel = {aev[nk-1]:.3e}, smallest outside = {aev[nk]:.3e}")

    # 2. orbit tangent space, built independently
    vecs = []
    for a in range(ctx.n):
        for b2 in range(a + 1, ctx.n):
            A = np.zeros((ctx.n, ctx.n)); A[a, b2] = 1.0; A[b2, a] = -1.0
            R = rho_lambda2(A, ctx.pairs, ctx.pidx)
            assert np.linalg.norm(R + R.T) < 1e-10
            vecs.append(ctx.coord(R @ W - W @ R))
    Ovec = np.array(vecs)
    U, sv, Vt = np.linalg.svd(Ovec @ B, full_matrices=False)
    rk = int(np.sum(sv > 1e-8 * max(sv[0], 1e-300)))
    Ob = Vt[:rk].T                      # orthonormal basis of orbit tangent, in B-coords
    print(f"  orbit tangent dim      = {rk}   (sv: {np.array2string(sv[:rk+2], precision=3)})")
    print(f"  |Hess . orbit|         = {np.linalg.norm(Hs @ Ob):.3e}  (orbit inside kernel?)")

    # transverse kernel = ker \cap orbit^perp
    Ok = ker.T @ Ob
    s_ = np.linalg.svd(Ok, compute_uv=False) if Ok.size else np.array([])
    nfit = int(np.sum(s_ > 1e-6))
    comp = np.linalg.svd(Ok)[0][:, nfit:] if Ok.size else np.eye(ker.shape[1])
    T = ker @ comp
    print(f"  orbit-in-kernel sing.v.= {np.array2string(s_, precision=6)}")
    print(f"  transverse kernel dim  = {T.shape[1]}")
    return dict(W=W, th=th, w=w, B=B, Lmat=Lmat, Hs=Hs, ev=ev, ker=ker, Ob=Ob, T=T, ctx=ctx)


def obstruction_tensor(st):
    """C[k,i,j] with Phi(v) = sum_ij v_i v_j C[:,i,j], v in transverse kernel coords."""
    ctx, B, ker, T = st["ctx"], st["B"], st["ker"], st["T"]
    m = T.shape[1]
    mats = [ctx.mat(B @ T[:, a]) for a in range(m)]
    C = np.zeros((ker.shape[1], m, m))
    for i in range(m):
        for j in range(i, m):
            g = Qbil(mats[i], mats[j], ctx.c)
            y = ker.T @ (B.T @ ctx.coord(g))
            C[:, i, j] = y
            C[:, j, i] = y
    return C


def full_kernel_tensor(st):
    """Same but v ranges over the WHOLE kernel (orbit directions included)."""
    ctx, B, ker = st["ctx"], st["B"], st["ker"]
    m = ker.shape[1]
    mats = [ctx.mat(B @ ker[:, a]) for a in range(m)]
    C = np.zeros((m, m, m))
    for i in range(m):
        for j in range(i, m):
            g = Qbil(mats[i], mats[j], ctx.c)
            y = ker.T @ (B.T @ ctx.coord(g))
            C[:, i, j] = y
            C[:, j, i] = y
    return C


if __name__ == "__main__":
    ctx6 = Ctx(6)
    L2_6 = Lambda2(6)
    st1 = analyse("S^3 x S^3", ctx6, weyl_sphere_product_mop(L2_6, 3, 3))
    st2 = analyse("su(3) Kahler", ctx6, su_m_kahler_weyl(L2_6, 3))
    np.save("scratchpad/dummy.npy", np.zeros(1))
