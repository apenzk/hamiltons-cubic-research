"""B0, the broader statement: is there a Weyl_m element with exactly two negative
eigenvalues and FULL support, dim U = m?

The rank-3 theorem in b0_psd_identity.py covers dim m_neg <= 2 with ONE positive
eigenvalue.  The reduction recorded in plan.md is broader: dim m_neg <= 2 with any
number of positive eigenvalues and dim U = m, U = im y + im z for the two negative
eigenvectors.  That case is decided here EXACTLY, as a semidefinite feasibility
problem rather than by a search, because the whole question is linear once the two
negative eigenvectors are fixed:

    given orthonormal y, z in Lambda^2 and b, c > 0, a Weyl tensor with negative
    eigenvalues exactly -b, -c on span{y,z} exists  iff  the affine set

        { W in Weyl_m :  G := W + b y(x)y + c z(x)z  satisfies  G >= 0, Gy = Gz = 0 }

    is non-empty.

Since dim U = m is  ker y ^ ker z = 0, sampling y, z with that property and solving
the SDP decides the broader statement at each configuration.  A positive control is
padded W_CP^2, where y and z share a 2-dimensional kernel and the SDP must be
feasible.

FALSIFIER.  A feasible point with ker y ^ ker z = 0 refutes the broader B0 statement
and shows the rank-3 theorem does not close B0 on its own.
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
import cvxpy as cp
from review_r30_core import pair_index, weyl_basis
from b0_psd_identity import phis, mat_of, vec_of

np.set_printoptions(precision=6, suppress=True)


def feasible(m, y, z, cmin=0.1, verbose=False):
    """y, z skew m x m, Frobenius-orthonormal under <X,Y>=1/2 tr(X^T Y)."""
    B = weyl_basis(m); d, N, _ = B.shape
    yv, zv = vec_of(y, m), vec_of(z, m)
    t = cp.Variable(d)
    cc = cp.Variable(nonneg=True)
    W = sum(t[k] * B[k] for k in range(d))
    G = W + np.outer(yv, yv) + cc * np.outer(zv, zv)
    cons = [G >> 0, G @ yv == 0, G @ zv == 0, cc >= cmin, cp.norm(t) <= 50]
    prob = cp.Problem(cp.Maximize(cc), cons)
    try:
        prob.solve(solver=cp.SCS, eps=1e-9, max_iters=200000, verbose=False)
    except Exception as e:
        return None, str(e)
    return prob.status, (None if t.value is None else (t.value, float(cc.value)))


def common_kernel_dim(y, z):
    return y.shape[0] - np.linalg.matrix_rank(np.vstack([y, z]), tol=1e-9)


def orthonormalise(y, z, m):
    yv, zv = vec_of(y, m), vec_of(z, m)
    yv /= np.linalg.norm(yv)
    zv = zv - np.dot(zv, yv) * yv
    zv /= np.linalg.norm(zv)
    return mat_of(yv, m), mat_of(zv, m)


def selfdual4():
    """the three self-dual 2-forms on R^4, each of full rank."""
    def sk(pairs):
        X = np.zeros((4, 4))
        for (i, j, s) in pairs:
            X[i, j] = s; X[j, i] = -s
        return X
    w1 = sk([(0, 1, 1), (2, 3, 1)])
    w2 = sk([(0, 2, 1), (3, 1, 1)])
    w3 = sk([(0, 3, 1), (1, 2, 1)])
    return w1, w2, w3


def pad(X, m):
    Y = np.zeros((m, m)); k = X.shape[0]; Y[:k, :k] = X; return Y


if __name__ == '__main__':
    rng = np.random.default_rng(7)
    m = 6
    P, pairs, idx = phis(m)

    print("=== positive control: padded W_CP^2 configuration (y,z on a common 4-plane) ===")
    w1, w2, w3 = selfdual4()
    y, z = orthonormalise(pad(w2, m), pad(w3, m), m)
    print(f"  dim(ker y ^ ker z) = {common_kernel_dim(y,z)}  (dim U = {m-common_kernel_dim(y,z)})")
    st, val = feasible(m, y, z)
    print(f"  SDP status: {st}")

    print("\n=== the question: ker y ^ ker z = 0 ===")
    cases = []
    # (a) both nondegenerate, random
    for k in range(3):
        A = rng.normal(size=(m, m)); A = A - A.T
        Bm = rng.normal(size=(m, m)); Bm = Bm - Bm.T
        cases.append((f"random nondegenerate #{k}", A, Bm))
    # (b) both rank 4, complementary kernels
    y4 = pad(w1, m)
    z4 = np.zeros((m, m)); z4[2:, 2:] = w1[:4, :4]
    cases.append(("rank 4 + rank 4, complementary kernels", y4, z4))
    # (c) one full rank, one rank 2
    A = rng.normal(size=(m, m)); A = A - A.T
    e = np.zeros((m, m)); e[0, 1] = 1; e[1, 0] = -1
    cases.append(("nondegenerate + decomposable", A, e))

    for name, Y, Z in cases:
        y, z = orthonormalise(Y, Z, m)
        k = common_kernel_dim(y, z)
        st, val = feasible(m, y, z)
        print(f"  {name:42s} dim(ker y ^ ker z)={k}  dim U={m-k}  SDP: {st}")


def extract_and_verify(m, Y, Z, tag):
    """Rebuild W from the SDP solution and screen it independently."""
    from b0_psd_identity import ricci, bianchi_res, A_of_W
    from review_r30_core import Q, P as Pfun
    y, z = orthonormalise(Y, Z, m)
    B = weyl_basis(m); d = B.shape[0]
    yv, zv = vec_of(y, m), vec_of(z, m)
    t = cp.Variable(d); cc = cp.Variable(nonneg=True)
    W = sum(t[k] * B[k] for k in range(d))
    G = W + np.outer(yv, yv) + cc * np.outer(zv, zv)
    prob = cp.Problem(cp.Maximize(cc),
                      [G >> 0, G @ yv == 0, G @ zv == 0, cc >= 0.1, cp.norm(t) <= 50])
    prob.solve(solver=cp.SCS, eps=1e-10, max_iters=400000)
    Wv = np.tensordot(t.value, B, axes=([0], [0]))
    Wv = 0.5 * (Wv + Wv.T)
    Wn = Wv / np.sqrt(np.sum(Wv * Wv))
    lam, V = np.linalg.eigh(Wn)
    nneg = int(np.sum(lam < -1e-7))
    ys = [mat_of(V[:, i], m) for i in range(nneg)]
    S = np.vstack(ys) if ys else np.zeros((1, m))
    dU = np.linalg.matrix_rank(S, tol=1e-8)
    print(f"\n--- {tag} ---")
    print(f"  c = {cc.value:.6f}   status {prob.status}")
    print(f"  Ricci  |.|max = {np.abs(ricci(m,Wn)).max():.3e}")
    print(f"  Bianchi|.|max = {bianchi_res(m,Wn):.3e}")
    print(f"  |A(W)-2W|     = {np.abs(A_of_W(m,Wn)-2*Wn).max():.3e}")
    print(f"  spectrum      = {np.round(lam,6)}")
    print(f"  #negative     = {nneg}    dim U = {dU}")
    print(f"  theta         = {Pfun(m, Wn):.6f}   (sqrt(3/2) = {np.sqrt(1.5):.6f})")
    return Wn, lam, dU


if __name__ == '__main__':
    rng2 = np.random.default_rng(7)
    m = 6
    w1, w2, w3 = selfdual4()
    y4 = pad(w1, m)
    z4 = np.zeros((m, m)); z4[2:, 2:] = w1[:4, :4]
    extract_and_verify(m, y4, z4, "rank4+rank4, complementary kernels, m=6")
    extract_and_verify(m, pad(w2, m), pad(w3, m), "positive control: padded W_CP^2")


def rank_sweep(m, rng, trials=6):
    """Which (rank y, rank z) profiles admit a Weyl_m tensor with m_neg = {y,z}?"""
    from itertools import product
    print(f"\n=== rank profile sweep at m = {m} ===")
    def rand_rank(r):
        A = rng.normal(size=(m, r)); Qr, _ = np.linalg.qr(A)
        S = rng.normal(size=(r, r)); S = S - S.T
        return Qr @ S @ Qr.T
    ranks = [r for r in range(2, m + 1, 2)]
    for ry, rz in product(ranks, ranks):
        if ry > rz:
            continue
        ok = 0; seen = 0
        for _ in range(trials):
            Y, Z = rand_rank(ry), rand_rank(rz)
            y, z = orthonormalise(Y, Z, m)
            if common_kernel_dim(y, z) != 0:
                continue
            seen += 1
            st, _ = feasible(m, y, z)
            ok += (st == 'optimal')
        print(f"  rank y={ry}, rank z={rz}:  full-support draws {seen}/{trials},"
              f"  feasible {ok}/{max(seen,1)}")
