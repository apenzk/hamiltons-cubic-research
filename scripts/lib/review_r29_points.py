"""R29 attacks 5,6,7: critical-point catalogue, L_e spectrum, T3 and T4 checks."""
import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, L_matrix, project, theta0


def so_gens(n):
    g = []
    for i in range(n):
        for j in range(i + 1, n):
            A = np.zeros((n, n)); A[i, j] = 1; A[j, i] = -1
            g.append(A)
    return g


def rho_of(alg, A):
    """action of A in so(n) on Lambda^2 (adjoint rep, in phi basis)."""
    n, N, P = alg.n, alg.N, alg.P
    M = np.zeros((N, N))
    for m, (i, j) in enumerate(P):
        # A.(e_i ^ e_j) = (A e_i)^e_j + e_i^(A e_j);  as matrices: [A, phi_m]
        C = A @ alg.phi[m] - alg.phi[m] @ A
        for g, (k, l) in enumerate(P):
            M[g, m] = C[k, l]
    return M


def invariant_subspace(alg, B, gens):
    """basis (in Weyl coordinates) of {X in Weyl_n : [rho(A),X]=0 for all A in gens}."""
    D, N, _ = B.shape
    Bf = B.reshape(D, N * N)
    rows = []
    for A in gens:
        r = rho_of(alg, A)
        M = np.zeros((D, D))
        for k in range(D):
            Mk = r @ B[k] - B[k] @ r
            M[:, k] = Bf @ Mk.reshape(N * N)
        rows.append(M)
    S = np.vstack(rows)
    u, s, vt = np.linalg.svd(S)
    tol = max(S.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    r = int((s > tol).sum())
    return vt[r:]


def from_coords(B, v):
    return np.tensordot(v, B, axes=([0], [0]))


def newton_critical(alg, B, v0, iters=200, tol=1e-14):
    """Gauss-Newton for Q(W)=theta W, |W|=1, in Weyl coordinates v."""
    D = B.shape[0]
    Bf = B.reshape(D, -1)
    v = v0 / np.linalg.norm(v0)
    for it in range(iters):
        W = from_coords(B, v)
        QW = alg.Q(W)
        q = Bf @ QW.reshape(-1)
        th = float(v @ q)
        F = q - th * v
        if np.linalg.norm(F) < tol:
            break
        L = L_matrix(alg, B, W)
        J = 2 * L - th * np.eye(D)
        # solve J dv = -F in least squares, then re-normalise
        try:
            dv, *_ = np.linalg.lstsq(np.vstack([J, v[None, :]]), np.concatenate([-F, [0.0]]), rcond=None)
        except np.linalg.LinAlgError:
            break
        s = 1.0
        for _ in range(40):
            vn = v + s * dv; vn /= np.linalg.norm(vn)
            Wn = from_coords(B, vn); Qn = alg.Q(Wn)
            qn = Bf @ Qn.reshape(-1); thn = float(vn @ qn)
            if np.linalg.norm(qn - thn * vn) < np.linalg.norm(F):
                v = vn; break
            s *= 0.5
        else:
            break
    W = from_coords(B, v); QW = alg.Q(W); th = ip(W, QW)
    return v, th, np.linalg.norm(alg.Q(W) - th * W)


def orbit_dim(alg, B, W):
    D, N, _ = B.shape
    Bf = B.reshape(D, N * N)
    cols = []
    for A in so_gens(alg.n):
        r = rho_of(alg, A)
        M = r @ W - W @ r
        cols.append(Bf @ M.reshape(N * N))
    S = np.array(cols)
    s = np.linalg.svd(S, compute_uv=False)
    tol = max(S.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    return int((s > tol).sum())


def analyse(alg, B, v, name):
    D = B.shape[0]
    W = from_coords(B, v)
    QW = alg.Q(W); th = ip(W, QW)
    resid = np.linalg.norm(QW - th * W)
    e = W / th
    Le = L_matrix(alg, B, e)
    lam = np.sort(np.linalg.eigvalsh(0.5 * (Le + Le.T)))[::-1]
    orb = orbit_dim(alg, B, W)
    kap = (2 * alg.n - 1) * (alg.n - 1) / 4.0
    s1 = lam.sum(); s2 = (lam ** 2).sum(); s3 = (lam ** 3).sum()
    tol = 1e-8
    m1 = int(np.sum(np.abs(lam - 1.0) < tol))
    mh = int(np.sum(np.abs(lam - 0.5) < tol))
    mz = int(np.sum(np.abs(lam) < tol))
    lam2 = lam[1] if D > 1 else np.nan
    return dict(name=name, n=alg.n, D=D, theta=th, resid=resid, orb=orb,
                sum1=s1, th2s2=th * th * s2, kappa=kap, th2s3=th * th * s3,
                mult1=m1, multhalf=mh, mult0=mz, lam_max_perp=lam2,
                lam_min=lam[-1], lam=lam)
