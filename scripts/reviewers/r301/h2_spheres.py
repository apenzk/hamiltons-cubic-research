"""H2/H3: the branching on sphere products, piece by piece, with the trivial
summand kept in view; and whether H_A vanishes BEFORE or only AFTER projection."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core301 as C, points301 as PT, sym0 as S

def blocks(n, p):
    """Orthonormal bases of the four k = so(p)+so(q) summands of Sym_0(R^n)."""
    q = n - p
    S0p, S0q, mix, triv = [], [], [], []
    def emb(M):
        return M
    # Sym_0(R^p)
    for i in range(p):
        for j in range(i + 1, p):
            M = np.zeros((n, n)); M[i, j] = M[j, i] = 1 / np.sqrt(2); S0p.append(M)
    for k in range(1, p):
        d = np.zeros(n); d[:k] = 1; d[k] = -k; d /= np.linalg.norm(d); S0p.append(np.diag(d))
    for i in range(p, n):
        for j in range(i + 1, n):
            M = np.zeros((n, n)); M[i, j] = M[j, i] = 1 / np.sqrt(2); S0q.append(M)
    for k in range(p + 1, n):
        d = np.zeros(n); d[p:k] = 1; d[k] = -(k - p); d /= np.linalg.norm(d); S0q.append(np.diag(d))
    for i in range(p):
        for j in range(p, n):
            M = np.zeros((n, n)); M[i, j] = M[j, i] = 1 / np.sqrt(2); mix.append(M)
    d = np.zeros(n); d[:p] = q; d[p:] = -p; d /= np.linalg.norm(d); triv.append(np.diag(d))
    return dict(Sym0p=S0p, Sym0q=S0q, mix=mix, triv=triv)

def piece_spectrum(n, W, theta, As):
    """Compression of L_e to span{ Pi H_A : A in As }, and the raw ||H_A|| before
    any projection."""
    Mw = C.weyl_mat(n)
    w = Mw @ C.sym_to_vec(n, W); w /= np.linalg.norm(w)
    raw, vecs = [], []
    for A in As:
        D = C.D_A(n, A)
        Hm = D @ W + W @ D
        raw.append(C.nrm(Hm))
        v = Mw @ C.sym_to_vec(n, 0.5 * (Hm + Hm.T))
        vecs.append(v - (v @ w) * w)
    Hv = np.array(vecs)
    u, s, vt = np.linalg.svd(Hv, full_matrices=False)
    keep = s > 1e-9 * max(1.0, s.max())
    U = vt[keep]
    if U.shape[0] == 0:
        return np.array([]), np.array(raw), s
    L = S.Le_matrix(n, W, theta)
    Mc = U @ L @ U.T
    return np.linalg.eigvalsh(0.5 * (Mc + Mc.T)), np.array(raw), s
