"""Reviewer 25, (F1)-(F3) tests, criticality, theta, S_mmm, gradedness, slack."""
import numpy as np, itertools, functools
import review_r25_core as R

# ------------------------------------------------------------------ (F2)
def sym2_invariants(n, gens, extra):
    """dim of {S symmetric n x n : [S,X]=0 for X in h, gSg^T = S for g in extra}."""
    rows = []
    # basis of Sym^2 R^n
    B = []
    for i in range(n):
        E = np.zeros((n, n)); E[i, i] = 1; B.append(E)
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = 1; E[j, i] = 1; B.append(E)
    A = []
    for S in B:
        col = []
        for X in gens:
            col.append((S @ X - X @ S).flatten())
        for g in extra:
            col.append((g @ S @ g.T - S).flatten())
        A.append(np.concatenate(col) if col else np.zeros(1))
    A = np.array(A)                       # (dimSym2, constraints)
    if A.shape[1] == 1 and np.allclose(A, 0):
        return len(B)
    s = np.linalg.svd(A, compute_uv=False)
    tol = 1e-8 * max(s[0], 1.0)
    return len(B) - int((s > tol).sum())

# ------------------------------------------------------------------ (F3)
@functools.lru_cache(maxsize=None)
def quads(n):
    return tuple(itertools.combinations(range(n), 4))

def _sorted_sign(t):
    t = list(t); sgn = 1
    for i in range(len(t)):
        for j in range(len(t) - 1 - i):
            if t[j] > t[j + 1]:
                t[j], t[j + 1] = t[j + 1], t[j]; sgn = -sgn
    if len(set(t)) < len(t):
        return None, 0
    return tuple(t), sgn

@functools.lru_cache(maxsize=None)
def quad_index(n):
    return {q: i for i, q in enumerate(quads(n))}

def lam4_deriv_matrix(n, X):
    """matrix of the so(n)-derivation action of X on Lambda^4 R^n (quadruple basis)."""
    Qs = quads(n); qi = quad_index(n); d = len(Qs)
    M = np.zeros((d, d))
    for col, Qd in enumerate(Qs):
        for p in range(4):
            for a in range(n):
                x = X[a, Qd[p]]
                if x == 0:
                    continue
                t = list(Qd); t[p] = a
                st, sgn = _sorted_sign(t)
                if sgn == 0:
                    continue
                M[qi[st], col] += sgn * x
    return M

def lam4_group_matrix(n, g):
    Qs = quads(n); d = len(Qs)
    M = np.zeros((d, d))
    for col, Qc in enumerate(Qs):
        sub = g[np.ix_(list(range(n)), list(Qc))]     # n x 4
        for row, Qr in enumerate(Qs):
            M[row, col] = np.linalg.det(sub[list(Qr), :])
    return M

def lam4_invariants(n, gens, extra):
    d = len(quads(n))
    if d == 0:
        return 0
    cols = [lam4_deriv_matrix(n, X) for X in gens]
    for g in extra:
        cols.append(lam4_group_matrix(n, g) - np.eye(d))
    A = np.vstack(cols) if cols else np.zeros((1, d))
    s = np.linalg.svd(A, compute_uv=False)
    tol = 1e-8 * max(s[0], 1.0)
    return d - int((s > tol).sum())

# ------------------------------------------------------------------ (F1)
def lam2_action(n, gens, extra):
    """operators on Lambda^2 R^n = so(n): ad_X for X in h, Ad_g for g in extra."""
    B = R.basis(n); N = B.shape[0]
    ops = []
    for X in gens:
        M = np.zeros((N, N))
        for b in range(N):
            C = X @ B[b] - B[b] @ X
            M[:, b] = R.mat_of_2form(n, C)
        ops.append(M)
    for g in extra:
        M = np.zeros((N, N))
        for b in range(N):
            C = g @ B[b] @ g.T
            M[:, b] = R.mat_of_2form(n, C)
        ops.append(M)
    return ops

def sym_commutant_dim(ops, Pi):
    """dim of symmetric operators on range(Pi) commuting with all ops (restricted)."""
    U, s, _ = np.linalg.svd(Pi)
    k = int(round(np.trace(Pi)))
    U = U[:, :k]
    rops = [U.T @ M @ U for M in ops]
    # basis of symmetric k x k
    B = []
    for i in range(k):
        E = np.zeros((k, k)); E[i, i] = 1; B.append(E)
    for i in range(k):
        for j in range(i + 1, k):
            E = np.zeros((k, k)); E[i, j] = 1; E[j, i] = 1; B.append(E)
    A = []
    for S in B:
        A.append(np.concatenate([(S @ M - M @ S).flatten() for M in rops]))
    A = np.array(A)
    s = np.linalg.svd(A, compute_uv=False)
    tol = 1e-8 * max(s[0], 1.0)
    return len(B) - int((s > tol).sum())

def block_invariance(ops, Pi):
    """how far the K-action is from preserving range(Pi)."""
    Pm = np.eye(Pi.shape[0]) - Pi
    return max(np.linalg.norm(Pm @ M @ Pi) for M in ops)

# ------------------------------------------------------------------ full report
def analyse(name, n, gens, extra, do_F3=True):
    Pi, r, Pm = R.h_data(n, gens)
    N = n * (n - 1) // 2
    if r == 0 or r == N:
        return dict(name=name, n=n, r=r, N=N, skip="degenerate (r=0 or r=N)")
    W = Pi - (r / N) * np.eye(N)
    W = W / np.linalg.norm(W)
    QW = R.Q(n, W)
    th = float(np.tensordot(W, QW))
    crit = float(np.linalg.norm(QW - th * W))
    Ric = R.ricci(n, W); alt2 = R.alt_norm2(n, W)
    Shhh, Shmm, Smmm = R.S_sums(n, Pi)
    kap = 2 * (n - 2); sig = n - 1
    th_pred = (2.0 / n) * np.sqrt(r * N / (N - r))
    Smmm_pred = (N - r) * (2 * (n - 2) - 4 * (n - 1) * r / N)
    Shmm_pred = 2 * sig * r * (N - r) / N
    cap = n * (n - 2) / 4.0
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    ops = lam2_action(n, gens, extra)
    res = dict(name=name, n=n, r=r, N=N, cap=cap, th0=th0,
               theta=th, theta_pred=th_pred,
               crit_resid=crit, ric_norm=float(np.linalg.norm(Ric)), alt2=alt2,
               Shhh=Shhh, Shmm=Shmm, Shmm_pred=Shmm_pred,
               Smmm=Smmm, Smmm_pred=Smmm_pred,
               id1=Shhh + Shmm - kap * r, id2=2 * Shmm + Smmm - kap * (N - r),
               F1h=sym_commutant_dim(ops, Pi), F1m=sym_commutant_dim(ops, Pm),
               hinv=block_invariance(ops, Pi),
               F2=sym2_invariants(n, gens, extra))
    if do_F3:
        res['F3'] = lam4_invariants(n, gens, extra)
    # gradedness: [m,m] perp m  <=>  S_mmm = 0
    res['graded'] = Smmm < 1e-7 * max(1.0, abs(Smmm_pred) + 1)
    # slack
    ev, U = np.linalg.eigh(W)
    Wm = U @ np.diag(np.maximum(-ev, 0)) @ U.T          # PSD negative part
    d2 = R.alt_norm2(n, Wm)
    res['slack'] = (float(np.linalg.norm(R.ricci(n, Wm)) ** 2) + 6 * d2
                    - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm)))
    res['delta2'] = d2
    return res
