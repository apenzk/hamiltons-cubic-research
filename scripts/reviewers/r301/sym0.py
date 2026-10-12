"""The Sym_0 deformation subspace V = span{ Pi_{e-perp} Pi_{Weyl} (D_A W + W D_A) },
the compression of L_e to it, and the k(W)-module structure of Sym_0 and of V."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core301 as C

def phi_map(n, W, theta):
    """Returns (Abasis, Hvecs) with Hvecs[i] = coordinate vector (in the Weyl
    orthonormal basis) of Pi_{Wperp} Pi_{Weyl} (D_{A_i} W + W D_{A_i})."""
    Ab = C.sym0_basis(n)
    M = C.weyl_mat(n)
    w = M @ C.sym_to_vec(n, W)
    w = w / np.linalg.norm(w)
    H = []
    for A in Ab:
        D = C.D_A(n, A)
        Hm = D @ W + W @ D
        v = M @ C.sym_to_vec(n, 0.5 * (Hm + Hm.T))
        v = v - (v @ w) * w
        H.append(v)
    return Ab, np.array(H)          # (dimSym0, dimWeyl)

def Le_matrix(n, W, theta):
    """L_e as a matrix on the Weyl coordinate space."""
    Bs = C.weyl_basis(n); M = C.weyl_mat(n); d = len(Bs)
    L = np.zeros((d, d))
    for i, b in enumerate(Bs):
        L[:, i] = M @ C.sym_to_vec(n, C.circ(n, W, b) / theta)
    return 0.5 * (L + L.T)

def compression(n, W, theta, tol=1e-9):
    """Orthonormal basis U of V = im(phi_map), and the compression U^T L_e U."""
    Ab, H = phi_map(n, W, theta)
    u, s, vt = np.linalg.svd(H, full_matrices=False)
    keep = s > tol * max(1.0, s.max())
    U = vt[keep]                    # (dimV, dimWeyl) orthonormal rows
    L = Le_matrix(n, W, theta)
    Mc = U @ L @ U.T
    return Ab, H, U, 0.5 * (Mc + Mc.T), s

def k_action_on_sym0(n, kbasis):
    """Matrices of ad(x)|Sym_0(R^n) in the orthonormal Sym_0 basis, x running over k."""
    Ab = C.sym0_basis(n); m = len(Ab)
    out = []
    for c in kbasis:
        X = C.so_from_coeffs(n, c)
        M = np.zeros((m, m))
        for j, A in enumerate(Ab):
            B = X @ A - A @ X
            for i, A2 in enumerate(Ab):
                M[i, j] = np.tensordot(B, A2, axes=([0, 1], [0, 1]))
        out.append(M)
    return out

def k_action_on_V(n, W, kbasis, U):
    """Matrices of the k-action on the Weyl coordinate space, restricted to V.
    k acts on Weyl_n by X.S = [D_X, S] with D_X the derivation action of X in so(n)."""
    M = C.weyl_mat(n); Bs = C.weyl_basis(n); d = len(Bs)
    out = []
    for c in kbasis:
        X = C.so_from_coeffs(n, c)
        D = C.D_A(n, X)
        A = np.zeros((d, d))
        for i, b in enumerate(Bs):
            Sm = D @ b - b @ D
            A[:, i] = M @ C.sym_to_vec(n, 0.5 * (Sm + Sm.T))
        out.append(U @ A @ U.T)
    return out

def commutant(mats, tol=1e-7):
    """Basis of {Y : Y M = M Y for all M in mats}, as (k, d, d).  Uses the normal
    equations so that no thin SVD of a tall Kronecker stack is needed."""
    d = mats[0].shape[0]
    I = np.eye(d)
    G = np.zeros((d * d, d * d))
    for M in mats:
        K = np.kron(I, M) - np.kron(M.T, I)
        G += K.T @ K
    ev, V = np.linalg.eigh(G)
    sc = max(1.0, ev.max())
    keep = ev <= tol * tol * sc
    return np.array([V[:, i].reshape(d, d) for i in np.where(keep)[0]])
