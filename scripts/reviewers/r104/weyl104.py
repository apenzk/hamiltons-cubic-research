"""Reviewer 104: independent implementation of the objects in the brief."""
import numpy as np
import itertools

def kn(A, B):
    """Kulkarni-Nomizu product (A o B)_ijkl = A_ik B_jl + A_jl B_ik - A_il B_jk - A_jk B_il."""
    return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
            - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))

def pair_index(n):
    return [(i, j) for i in range(n) for j in range(i+1, n)]

def M_to_tensor(M, n):
    """M symmetric over pairs i<j  ->  4-tensor with Riemann pair symmetries."""
    P = pair_index(n)
    W = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = M[a, b]
            for (ii, jj, s1) in ((i, j, 1), (j, i, -1)):
                for (kk, ll, s2) in ((k, l, 1), (l, k, -1)):
                    W[ii, jj, kk, ll] = s1*s2*v
    return W

def tensor_to_M(W, n):
    P = pair_index(n)
    return np.array([[W[i, j, k, l] for (k, l) in P] for (i, j) in P])

def bianchi_project(W):
    """Remove the totally antisymmetric part; result satisfies first Bianchi."""
    A = (W + np.transpose(W, (0, 2, 3, 1)) + np.transpose(W, (0, 3, 1, 2)))/3.0
    return W - A

def weyl_project(R, n):
    """R with Riemann symmetries + Bianchi -> its trace-free (Weyl) part."""
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R)
    scal = np.trace(Ric)
    S = Ric - (scal/n)*g
    return R - kn(S, g)/(n-2) - (scal/(2*n*(n-1)))*kn(g, g)

def random_weyl(n, rng, normalise=True):
    P = pair_index(n)
    N = len(P)
    A = rng.standard_normal((N, N))
    M0 = (A + A.T)/2
    W = M_to_tensor(M0, n)
    W = bianchi_project(W)
    W = weyl_project(W, n)
    if normalise:
        W = W/np.sqrt(np.sum(tensor_to_M(W, n)**2))
    return W

def sym_symmetries_residual(W, n):
    r = {}
    r['antisym12'] = np.abs(W + np.transpose(W, (1, 0, 2, 3))).max()
    r['antisym34'] = np.abs(W + np.transpose(W, (0, 1, 3, 2))).max()
    r['pairsym'] = np.abs(W - np.transpose(W, (2, 3, 0, 1))).max()
    r['bianchi'] = np.abs(W + np.transpose(W, (0, 2, 3, 1)) + np.transpose(W, (0, 3, 1, 2))).max()
    r['tracefree'] = np.abs(np.einsum('ikjk->ij', W)).max()
    return r

def basis_S20(n):
    """NPW-style orthonormal basis of S^2_0: phi_{ij} (i<j) then n-1 traceless diagonals."""
    B = []
    for (i, j) in pair_index(n):
        h = np.zeros((n, n)); h[i, j] = h[j, i] = 1/np.sqrt(2); B.append(h)
    # traceless diagonal part filled in by caller (needs K's eigenvectors)
    return B

def ring_W_operator(W, n, diag_vecs):
    """Matrix of (ring W h)_ij = sum_kl W_iklj h_kl in basis {phi_ij} + {diag(v) for v in diag_vecs}."""
    B = basis_S20(n)
    for v in diag_vecs:
        B.append(np.diag(v))
    D = len(B)
    out = np.zeros((D, D))
    for b, h in enumerate(B):
        img = np.einsum('iklj,kl->ij', W, h)
        for a, hh in enumerate(B):
            out[a, b] = np.sum(img*hh)
    return out

def vertex_matrix(W, n):
    K = np.zeros((n, n))
    for a in range(n):
        for b in range(n):
            if a != b:
                K[a, b] = W[a, b, a, b]
    return K

def onb_of_1perp(n):
    Q, _ = np.linalg.qr(np.hstack([np.ones((n, 1)), np.random.default_rng(0).standard_normal((n, n-1))]))
    return Q[:, 1:].T   # rows: orthonormal basis of 1^perp

def K_eigvecs_on_1perp(K, n):
    B = onb_of_1perp(n)              # (n-1, n)
    Kr = B @ K @ B.T
    w, V = np.linalg.eigh(Kr)
    return (V.T @ B), w              # rows are eigenvectors of K in 1^perp, eigenvalues w

def sharp(M, n):
    """Lie-algebra sharp on Lambda^2 in the UNNORMALISED phi_ij = E_ij - E_ji basis."""
    P = pair_index(n)
    N = len(P)
    # structure constants for basis X_a = E_{ij}-E_{ji}
    X = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        X[a, i, j] = 1.0; X[a, j, i] = -1.0
    # [X_a, X_b] = c^c_{ab} X_c ; <X_a,X_b> = 2 delta  (Frobenius)
    C = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            comm = X[a] @ X[b] - X[b] @ X[a]
            for c in range(N):
                C[c, a, b] = np.sum(comm*X[c])/2.0
    Msh = 0.5*np.einsum('cab,dpq,ap,bq->cd', C, C, M, M)
    return Msh, C

def theta_from_M(M, n):
    Msh, _ = sharp(M, n)
    return np.trace(M @ M @ M) + np.sum(Msh*M)

def p3(x):
    return float(np.sum(np.asarray(x)**3))
