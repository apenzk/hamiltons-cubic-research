"""Reviewer 114: independent implementation from the brief's definitions.

n=6.  Lambda^2 basis: e_i ^ e_j, i<j, orthonormal.  Identification with so(n) via the
UNNORMALISED phi_ij = E_ij - E_ji, so the invariant inner product on so(n) that makes the
frame orthonormal is <X,Y> = tr(X^T Y)/2.
"""
import numpy as np
import itertools

def pair_index(n):
    prs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: k for k, p in enumerate(prs)}
    return prs, idx

def phi_matrices(n):
    prs, idx = pair_index(n)
    mats = np.zeros((len(prs), n, n))
    for k, (i, j) in enumerate(prs):
        mats[k, i, j] = 1.0
        mats[k, j, i] = -1.0
    return mats, prs, idx

def struct_consts(n):
    """c_{abc} = <[phi_a, phi_b], phi_c>,  <X,Y> = tr(X^T Y)/2."""
    mats, prs, idx = phi_matrices(n)
    N = len(prs)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            br = mats[a] @ mats[b] - mats[b] @ mats[a]
            c[a, b] = 0.5 * np.einsum('ij,kij->k', br, mats)
    return c

# ---------- Weyl space ----------
def weyl_basis(n):
    """Orthonormal basis (in Frobenius inner product on the NxN matrix M) of algebraic Weyl
    tensors, represented as symmetric matrices on Lambda^2 with M[(ij),(kl)] = W_ijkl."""
    prs, idx = pair_index(n)
    N = len(prs)
    # coordinates: symmetric NxN matrices, parametrised by upper triangle incl diagonal
    coords = [(a, b) for a in range(N) for b in range(a, N)]
    ncoord = len(coords)

    def sym_from_vec(v):
        M = np.zeros((N, N))
        for t, (a, b) in enumerate(coords):
            M[a, b] = v[t]
            M[b, a] = v[t]
        return M

    def Wcomp(M, i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        if i > j:
            i, j, si = j, i, -si
        if k > l:
            k, l, si = l, k, -si
        return si * M[idx[(i, j)], idx[(k, l)]]

    rows = []
    # first Bianchi: W_ijkl + W_iklj + W_iljk = 0 for i<j<k<l
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        r = np.zeros(ncoord)
        for t, (a, b) in enumerate(coords):
            E = np.zeros((N, N)); E[a, b] = 1.0; E[b, a] = 1.0
            r[t] = Wcomp(E, i, j, k, l) + Wcomp(E, i, k, l, j) + Wcomp(E, i, l, j, k)
        rows.append(r)
    # Ricci: sum_k W_ikjk = 0 for i<=j
    for i in range(n):
        for j in range(i, n):
            r = np.zeros(ncoord)
            for t, (a, b) in enumerate(coords):
                E = np.zeros((N, N)); E[a, b] = 1.0; E[b, a] = 1.0
                r[t] = sum(Wcomp(E, i, k, j, k) for k in range(n))
            rows.append(r)
    A = np.array(rows)
    # metric: Frobenius norm of M in these coords is sum_diag v^2 + 2*sum_offdiag v^2.
    # switch to an orthonormal coordinate w: w_t = v_t for a==b, sqrt(2) v_t for a<b
    scale = np.array([1.0 if a == b else np.sqrt(2.0) for (a, b) in coords])
    Aw = A / scale  # A v = (A/scale) w
    u, s, vt = np.linalg.svd(Aw)
    tol = max(Aw.shape) * s[0] * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]           # orthonormal in w-coords
    basis = []
    for w in ns:
        basis.append(sym_from_vec(w / scale))
    return np.array(basis), rank, coords

# ---------- the cubic ----------
class Setup:
    def __init__(self, n):
        self.n = n
        self.c = struct_consts(n)
        self.prs, self.idx = pair_index(n)

    def sharp(self, M):
        c = self.c
        return 0.5 * np.einsum('ace,bdf,cd,ef->ab', c, c, M, M, optimize=True)

    def Q(self, M):
        return M @ M + self.sharp(M)

    def theta(self, M):
        return np.trace(M @ M @ M) + np.sum(self.sharp(M) * M)

# ---------- the full grading test (record's notion) ----------
def spectral_projectors(M, tol):
    ev, V = np.linalg.eigh(M)
    pos = V[:, ev > tol]; neg = V[:, ev < -tol]; zer = V[:, np.abs(ev) <= tol]
    P = lambda U: U @ U.T if U.shape[1] else np.zeros_like(M)
    return ev, P(pos), P(neg), P(zer), pos.shape[1], neg.shape[1], zer.shape[1]

def Tblock(c, P1, P2, P3):
    """sum over a in range(P1), b in P2, g in P3 of <[v_a,v_b],v_g>^2, basis-free."""
    return np.einsum('abg,ABG,aA,bB,gG->', c, c, P1, P2, P3, optimize=True)

def grading_report(setup, M, tol=1e-9):
    c = setup.c
    ev, Ph, Pm, Pz, dh, dm, dz = spectral_projectors(M, tol)
    out = {'ev': ev, 'dim_h': dh, 'dim_m': dm, 'dim_ker': dz, 'tol': tol}
    blocks = {}
    names = {'h': Ph, 'm': Pm, 'z': Pz}
    for key in ['hhh', 'hhm', 'hmm', 'mmm', 'hhz', 'hmz', 'mmz', 'hzz', 'mzz', 'zzz']:
        blocks[key] = Tblock(c, names[key[0]], names[key[1]], names[key[2]])
    out['T'] = blocks
    out['S'] = blocks['mmm']          # the brief's slack S
    out['graded_kerfree'] = (dz == 0) and blocks['mmm'] < 1e-8 and blocks['hhm'] < 1e-8
    return out
