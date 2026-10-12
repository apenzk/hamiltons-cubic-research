"""K2 -- the C_5-edge family: constant compression, or an eigenspace?"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r306_defs as R
from r306_weyl import weyl_basis_fast, L_operator_full
from scipy.optimize import least_squares

rng = np.random.default_rng(306)


def c5_blowup(m):
    n = 5 * m; blk = np.repeat(np.arange(5), m)
    def build(par):
        x, y, z = par; M = np.zeros((n, n))
        for a in range(n):
            for b in range(n):
                if a == b: continue
                d = min((blk[a] - blk[b]) % 5, (blk[b] - blk[a]) % 5)
                M[a, b] = x if d == 0 else (y if d == 1 else z)
        return M
    def resid(par):
        M = build(par); th = R.theta_diag(M); G = R.hollow(R.Phi(M)) - th * M
        r = [G[0, m], G[0, 2 * m], np.sum(M * M) - 2.0, M.sum(1)[0]]
        if m > 1: r.append(G[0, 1])
        return np.array(r)
    best = None
    for _ in range(300):
        s = least_squares(resid, rng.normal(size=3), xtol=1e-15, ftol=1e-15)
        M = build(s.x)
        if np.max(np.abs(resid(s.x))) < 1e-12 and R.theta_diag(M) > 1e-8:
            if best is None or R.theta_diag(M) > R.theta_diag(best): best = M
    return best, blk


def D_A(alg, A):
    """The derivation of Lambda^2 induced by a symmetric A: X -> A X + X A."""
    Bs = basis_matrices(alg)
    D = alg.D
    out = np.zeros((D, D))
    for a in range(D):
        Y = A @ Bs[a] + Bs[a] @ A
        for b in range(D):
            out[b, a] = np.sum(Bs[b] * Y)
    return out


def basis_matrices(alg):
    return R.basis_so(alg.n)


def H_A(alg, W, A):
    Dm = D_A(alg, A)
    Hm = Dm @ W + W @ Dm
    return 0.5 * (Hm + Hm.T)


if __name__ == '__main__':
    M, blk = c5_blowup(2)
    n = M.shape[0]
    alg = R.Algebra(n)
    W = R.diag_operator(M)
    th = alg.P(W)
    print(f'C_5 blow-up n={n}: theta={th:.9f}, criticality {np.abs(alg.Q(W) - th * W).max():.1e}')
    B = weyl_basis_fast(n)
    Bm = np.array([b.ravel() for b in B]).T
    Lop = L_operator_full(alg, W) / th
    print(f'dim Weyl_{n} = {len(B)}')

    # the twenty C_5-edge generators
    fam = []
    tags = []
    for a in range(n):
        for b in range(a + 1, n):
            d = min((blk[a] - blk[b]) % 5, (blk[b] - blk[a]) % 5)
            if d == 1:
                A = np.zeros((n, n)); A[a, b] = A[b, a] = 1.0
                fam.append(A); tags.append((a, b))
    print(f'{len(fam)} edge generators')
    Hs = [H_A(alg, W, A) for A in fam]
    # project into Weyl and orthonormalise
    V = np.array([h.ravel() for h in Hs]).T
    Vp = Bm @ (Bm.T @ V)
    leak = np.linalg.norm(V - Vp) / np.linalg.norm(V)
    print(f'relative mass of H_A outside Weyl_n: {leak:.3e}')
    Uq, sv, _ = np.linalg.svd(Vp, full_matrices=False)
    k = int(np.sum(sv > 1e-9 * sv[0]))
    U = Uq[:, :k]
    print(f'span dimension: {k}   singular values {sv[:3]} ... {sv[k-1]:.3e}, next {sv[k] if k < len(sv) else 0:.1e}')
    # compression
    C = U.T @ (Lop @ U)
    print(f'compression: symmetric to {np.abs(C - C.T).max():.1e}')
    ev = np.linalg.eigvalsh((C + C.T) / 2)
    print(f'compression eigenvalues: min {ev.min():.12f}  max {ev.max():.12f}')
    print(f'||C - (2/3) I||_max = {np.abs(C - (2/3) * np.eye(k)).max():.3e}')
    # residual of the action
    Y = Lop @ U
    Rres = Y - U @ C
    G = Rres.T @ Rres
    evr = np.linalg.eigvalsh((G + G.T) / 2)
    print(f'residual Gram eigenvalues: min {evr.min():.12f} max {evr.max():.12f}')
    print(f'  sqrt: {np.sqrt(evr.min()):.9f} .. {np.sqrt(evr.max()):.9f}   1/(3 sqrt2) = {1/(3*np.sqrt(2)):.9f}')
    print(f'  ||G - (1/18) I||_max = {np.abs(G - np.eye(k)/18).max():.3e}')
    # orthogonality to W and to the orbit tangent
    w = W.ravel() / np.linalg.norm(W)
    print(f'max |<u, W>| over the span: {np.abs(U.T @ w).max():.2e}')
    orb = []
    for a in range(n):
        for b in range(a + 1, n):
            X = np.zeros((n, n)); X[a, b] = 1; X[b, a] = -1
            Dm = D_A(alg, X * 0)  # placeholder
            # orbit direction: [rho(X), W] with rho(X) the Lambda^2 rep of X in so(n)
            Bs = basis_matrices(alg)
            rho = np.zeros((alg.D, alg.D))
            for i in range(alg.D):
                Y2 = X @ Bs[i] + Bs[i] @ X.T
                for j in range(alg.D):
                    rho[j, i] = np.sum(Bs[j] * Y2)
            orb.append((rho @ W - W @ rho).ravel())
    O = np.array(orb).T
    Oq, so_, _ = np.linalg.svd(O, full_matrices=False)
    ko = int(np.sum(so_ > 1e-9 * so_[0]))
    print(f'orbit tangent dimension {ko}; max principal cosine with the family: {np.linalg.svd(Oq[:, :ko].T @ U)[1].max():.2e}')
