"""r295: everything re-derived from the definitions, sharing no code with scripts/lib.

Conventions fixed from the definitions in review_r30_core's header, then checked:
  phi_a = E_ij - E_ji for a = (i<j);  <X,Y> = 1/2 tr(X^T Y), so ||phi_a|| = 1.
  c_abg = <[phi_a,phi_b],phi_g>.
  W acts on Lambda^2 R^n in that basis; the 4-tensor is R_ijkl = s_ij s_kl W[(ij),(kl)].
  W^#_ab = 1/2 c_apq c_brs W_pr W_qs      (Boehm-Wilking), Q = W^2 + W^#.
Wedge: omega = sum_{i<j} w_ij e_i ^ e_j;  omega ^ omega = sum_{i<j<k<l} 2 pl_ijkl e_ijkl
  with pl_ijkl = w_ij w_kl - w_ik w_jl + w_il w_jk (the Pluecker coordinate).
"""
import numpy as np, itertools, functools


def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


@functools.lru_cache(maxsize=None)
def phi(n):
    P = np.zeros((n * (n - 1) // 2, n, n))
    for a, (i, j) in enumerate(pairs_of(n)):
        P[a, i, j] = 1.0
        P[a, j, i] = -1.0
    return P


@functools.lru_cache(maxsize=None)
def cst(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g>, built by brute force over triples."""
    P = phi(n)
    N = P.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            comm = P[a] @ P[b] - P[b] @ P[a]
            c[a, b] = 0.5 * np.einsum('ij,gij->g', comm, P)
    return c


def sharp(n, W):
    c = cst(n)
    return 0.5 * np.einsum('apq,brs,pr,qs->ab', c, c, W, W, optimize=True)


def Qmap(n, W):
    return W @ W + sharp(n, W)


def theta(n, W):
    return float(np.sum(W * Qmap(n, W)))


def tensor4(n, W):
    """R_ijkl from the operator, sign-corrected, zero on repeated indices."""
    idx = {p: a for a, p in enumerate(pairs_of(n))}
    R = np.zeros((n, n, n, n))
    for (i, j) in pairs_of(n):
        for (k, l) in pairs_of(n):
            v = W[idx[(i, j)], idx[(k, l)]]
            R[i, j, k, l] = v; R[j, i, k, l] = -v
            R[i, j, l, k] = -v; R[j, i, l, k] = v
    return R


def weyl_residuals(n, W):
    R = tensor4(n, W)
    ric = np.einsum('ijkj->ik', R)
    bia = R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))
    pairsym = R - np.transpose(R, (2, 3, 0, 1))
    return dict(ricci=float(np.abs(ric).max()),
                bianchi=float(np.abs(bia).max()),
                pairsym=float(np.abs(pairsym).max()),
                trace=float(abs(np.trace(W))),
                scal=float(abs(np.einsum('ijij->', R))))


def plucker_vec(n, w):
    """the Pluecker coordinate vector; omega ^ omega = 2 * this in the e_ijkl basis."""
    idx = {p: a for a, p in enumerate(pairs_of(n))}
    out = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        out.append(w[idx[(i, j)]] * w[idx[(k, l)]]
                   - w[idx[(i, k)]] * w[idx[(j, l)]]
                   + w[idx[(i, l)]] * w[idx[(j, k)]])
    return np.array(out)


def plucker_bilin(n, u, v):
    """polarisation: pl(u+v) - pl(u) - pl(v), all halved -> the u^v coefficient array."""
    return 0.5 * (plucker_vec(n, u + v) - plucker_vec(n, u) - plucker_vec(n, v))


def skew(n, w):
    return np.einsum('a,aij->ij', w, phi(n))


def defect_quantities(n, W, tol=1e-9):
    """(Delta, S_mmm, dim m, n_zero) re-derived: g_d = ||[ad v_d, W]||^2 via T_dab."""
    lam, V = np.linalg.eigh(W)
    P = phi(n)
    v = np.einsum('ga,gij->aij', V, P)                      # v[a] = eigvec a as skew
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2      # <[v_a,v_b],v_c>^2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    m, p = lam < -tol, lam > tol
    return (float(g[p].sum()), float(T[np.ix_(m, m, m)].sum()), int(m.sum()),
            int((np.abs(lam) <= tol).sum()), lam, V, float(g.sum()))
