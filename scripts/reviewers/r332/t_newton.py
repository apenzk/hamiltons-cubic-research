"""Find generic critical points of P on unit Weyl_6 by Newton, then LP the S22 interval at their (lambda, theta)."""
import numpy as np
from itertools import combinations
from core import basis_so, ad_matrices, op_from_R4, sharp, theta_crit, eig_and_T, rows_ABC, S22_of
from t_freeness import polytope_S22_range

n = 6
idx, mats = basis_so(n)
ads = ad_matrices(mats)
N = len(idx)

# --- orthonormal basis of Weyl_6 inside symmetric operators on Lambda^2 ---
# symmetric operator coords: upper triangle incl diagonal of NxN
pairs = [(a, b) for a in range(N) for b in range(a, N)]
D = len(pairs)


def op_of(x):
    W = np.zeros((N, N))
    for t, (a, b) in enumerate(pairs):
        if a == b:
            W[a, a] = x[t]
        else:
            W[a, b] = W[b, a] = x[t] / np.sqrt(2.0)
    return W


def coords_of(W):
    x = np.zeros(D)
    for t, (a, b) in enumerate(pairs):
        x[t] = W[a, a] if a == b else np.sqrt(2.0) * W[a, b]
    return x


def R4_of_op(W):
    R4 = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            v = W[a, b]
            R4[i, j, k, l] = v
            R4[j, i, k, l] = -v
            R4[i, j, l, k] = -v
            R4[j, i, l, k] = v
    return R4


def constraints(x):
    """Ric entries and Bianchi components of the 4-tensor."""
    W = op_of(x)
    R4 = R4_of_op(W)
    Ric = np.einsum('ijkj->ik', R4)
    Bi = R4 + np.transpose(R4, (0, 2, 3, 1)) + np.transpose(R4, (0, 3, 1, 2))
    return np.concatenate([Ric[np.triu_indices(n)], Bi.ravel()])


# nullspace of the constraint map = Weyl subspace
Cmat = np.zeros((len(constraints(np.zeros(D))), D))
for t in range(D):
    e = np.zeros(D)
    e[t] = 1.0
    Cmat[:, t] = constraints(e)
u, s, vt = np.linalg.svd(Cmat)
nullmask = s < 1e-10 * s.max()
rank = np.sum(~nullmask)
Wbasis = vt[rank:]  # rows: orthonormal basis of Weyl_6 in x-coords
dw = Wbasis.shape[0]
print(f"dim Weyl_6 = {dw} (expect 84)")


def W_of_y(y):
    return op_of(Wbasis.T @ y)


def resid(y):
    W = W_of_y(y)
    nrm = np.sqrt(np.sum(W * W))
    W = W / nrm
    Q = W @ W + sharp(W, ads)
    th = np.sum(Q * W)
    G = Q - th * W
    return Wbasis @ coords_of(G), th


rng = np.random.default_rng(12)
found = []
for trial in range(60):
    y = rng.standard_normal(dw)
    y /= np.linalg.norm(y)
    ok = False
    for it in range(60):
        F, th = resid(y)
        if np.linalg.norm(F) < 1e-12:
            ok = True
            break
        # numerical Jacobian
        J = np.zeros((dw, dw))
        h = 1e-6
        for t in range(dw):
            e = np.zeros(dw)
            e[t] = h
            J[:, t] = (resid(y + e)[0] - F) / h
        try:
            dy = np.linalg.lstsq(J, -F, rcond=1e-8)[0]
        except np.linalg.LinAlgError:
            break
        if np.linalg.norm(dy) > 5.0:
            dy *= 5.0 / np.linalg.norm(dy)
        y = y + dy
        y /= np.linalg.norm(Wbasis.T @ y) or 1.0
    if ok:
        W = W_of_y(y)
        W /= np.sqrt(np.sum(W * W))
        th, res = theta_crit(W, ads)
        if th < 0:
            W = -W
            th, res = theta_crit(W, ads)
        lam = np.linalg.eigvalsh(W)
        nv = len(set(np.round(lam, 7)))
        found.append((th, res, nv, W))
        print(f"trial {trial}: critical point theta={th:.9f} res={res:.2e} distinct-values={nv}")
        if len(found) >= 3:
            break

for (th, res, nv, W) in found:
    lam, U, T = eig_and_T(W, ads, mats)
    A, B, C = rows_ABC(lam, T)
    dev = max(np.max(np.abs(A - 2 * (n - 2))), np.max(np.abs(B + 2 * lam)),
              np.max(np.abs(C - 2 * lam * (th - lam))))
    s22 = S22_of(lam, T)
    lo, hi, obj, trips = polytope_S22_range(lam, th, n)
    print(f"\ntheta={th:.9f} rowdev={dev:.2e} true S22={s22:.9f}")
    if lo.success and hi.success:
        print(f"   S22 LP interval: [{lo.fun:.9f}, {-hi.fun:.9f}] width={-hi.fun - lo.fun:.9f}")
    else:
        print(f"   LP failed: {lo.status} {hi.status}")
