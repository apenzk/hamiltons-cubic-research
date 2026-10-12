import numpy as np
from itertools import combinations, permutations

def build_structure_constants(n):
    idx = list(combinations(range(n), 2))  # sorted pairs i<j
    N = len(idx)
    pos = {p: k for k, p in enumerate(idx)}
    # c[a,b,g] = <[phi_a,phi_b], phi_g> with phi_{ij} = E_ij - E_ji, inner = 1/2 tr(A^T B)
    c = np.zeros((N, N, N))
    for (a, (i, j)) in enumerate(idx):
        for (b, (k, l)) in enumerate(idx):
            # [phi_ij, phi_kl] via matrix commutator formula for L_ij=E_ij-E_ji:
            # [L_ij,L_kl] = d_jk L_il - d_ik L_jl - d_jl L_ik + d_il L_jk
            terms = []  # (coeff, (p,q)) meaning coeff * L_pq
            if j == k: terms.append((1.0, (i, l)))
            if i == k: terms.append((-1.0, (j, l)))
            if j == l: terms.append((-1.0, (i, k)))
            if i == l: terms.append((1.0, (j, k)))
            for coeff, (p, q) in terms:
                if p == q:
                    continue
                sign = 1.0
                if p > q:
                    p, q = q, p
                    sign = -1.0
                g = pos[(p, q)]
                c[a, b, g] += coeff * sign
    return idx, pos, N, c

def Q_general(Rmat, c):
    """Q(R) = R^2 + R^# --- CORRECT FOR <R, Q(R)>, WRONG AS A VECTOR.

    THIS FUNCTION DISCARDS THE OFF-DIAGONAL PART OF R^# in R's own eigenbasis.
    ||Q_general - Q_true|| is 0.73 ||Q|| at random Weyl operators (r285, r286).

    WHAT IT IS SAFE FOR: the scalar P(R) = <R, Q(R)>, which pairs only against the
    diagonal and is exact to 1e-16.  Every theta in this record computed through it
    is right.

    WHAT IT IS NOT SAFE FOR: Q(R) used as a VECTOR -- gradients, directional
    derivatives, criticality residuals against a direction, anything of the form
    <Q(R), V> for V != R.  A finite-difference gradient test built on it returns
    residuals of 1e-2 to 1e-1 and reads as a refutation of grad P = 3 Q(R), which is
    in fact TRUE: P(W) = T(W,W,W) for the fully symmetric T(A,B,C) = <A o B, C>, so
    dP[V] = 3 T(W,W,V) = 3 <Q(W), V> on all of Sym^2(so(n)).

    Use scripts/rsharp_basis_free.py's Q_full for the vector.
    """
    N = Rmat.shape[0]
    w, V = np.linalg.eigh(Rmat)  # Rmat = V diag(w) V^T, V orthogonal columns = eigenvectors
    # transform structure constants to eigenbasis: c'[A,B,G] = sum c[a,b,g] V[a,A]V[b,B]V[g,G]
    # too expensive to fully transform (N^3 x N^3)? N up to ~66 -> N^3=287496, transform cost ~ N^4 manageable (66^4=19M) ok for n=8 (28^4=614656) fine.
    cp = np.einsum('abg,aA,bB,gG->ABG', c, V, V, V, optimize=True)
    Rsharp_diag = 0.5 * np.einsum('ABG,B,G->A', cp**2, w, w)
    Q_diag = w**2 + Rsharp_diag
    Qmat = V @ np.diag(Q_diag) @ V.T
    return Qmat

def R_val(Rmat, pos, n, i, j, k, l):
    if i == j or k == l:
        return 0.0
    si = 1.0
    a, b = i, j
    if a > b:
        a, b = b, a
        si = -si
    sk = 1.0
    p, q = k, l
    if p > q:
        p, q = q, p
        sk = -sk
    return si * sk * Rmat[pos[(a, b)], pos[(p, q)]]

def bianchi_constraint_matrix(idx, pos, n, N):
    """Build linear map from upper-tri vector of Sym^2(Lambda^2) (dim N(N+1)/2) to Bianchi residuals."""
    triu_idx = [(a, b) for a in range(N) for b in range(a, N)]
    M = len(triu_idx)
    tpos = {p: k for k, p in enumerate(triu_idx)}
    def entry_coeff(alpha, beta, coeff, rows):
        a, b = alpha, beta
        if a > b:
            a, b = b, a
        rows.setdefault(tpos[(a, b)], 0.0)
        rows[tpos[(a, b)]] += coeff
    rows_list = []
    for (i, j, k, l) in combinations(range(n), 4):
        # Bianchi over the 4-subset {i,j,k,l}: use canonical labeling i<j<k<l
        # R_{ij,kl} + R_{ik,lj} + R_{il,jk} = 0   (first Bianchi: R_i[jkl]=0 style, using pairs)
        rows = {}
        # term1: (ij)(kl)
        def add_pair(p1, p2, sign, rows):
            a = pos[tuple(sorted(p1))]
            b = pos[tuple(sorted(p2))]
            s = sign
            if p1[0] > p1[1]:
                s = -s
            if p2[0] > p2[1]:
                s = -s
            entry_coeff(a, b, s, rows)
        add_pair((i, j), (k, l), 1.0, rows)
        add_pair((i, k), (l, j), 1.0, rows)
        add_pair((i, l), (j, k), 1.0, rows)
        rows_list.append(rows)
    Mat = np.zeros((len(rows_list), M))
    for r, rows in enumerate(rows_list):
        for cidx, val in rows.items():
            Mat[r, cidx] += val
    return Mat, triu_idx, tpos

def vec_to_mat(v, triu_idx, N):
    Rmat = np.zeros((N, N))
    for k, (a, b) in enumerate(triu_idx):
        Rmat[a, b] = v[k]
        Rmat[b, a] = v[k]
    return Rmat

def mat_to_vec(Rmat, triu_idx):
    return np.array([Rmat[a, b] for (a, b) in triu_idx])

if __name__ == "__main__":
    n = 8
    idx, pos, N, c = build_structure_constants(n)
    print("n=", n, "N=binom(n,2)=", N)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    M = len(triu_idx)
    print("Sym^2 dim M =", M, " #Bianchi eqns (raw) =", Bmat.shape[0])
    # null space of Bmat gives algebraic curvature tensors
    U, S, Vt = np.linalg.svd(Bmat)
    tol = 1e-9 * S[0] if len(S)>0 else 1e-9
    rank = np.sum(S > tol)
    print("rank(Bianchi) =", rank, " => dim algebraic curvature tensors =", M - rank)
    null_basis = Vt[rank:, :].T  # M x (M-rank), columns orthonormal basis of nullspace
    print("null_basis shape:", null_basis.shape)
    # sanity check dimension formula n^2(n^2-1)/12
    print("formula n^2(n^2-1)/12 =", n**2*(n**2-1)/12)

    # Ricci contraction: Ric_{ik} = sum_j R_{ijkj}, linear in the curvature-tensor coordinates.
    # Build linear map from null_basis coords (dim M-rank) to Ric entries (n x n, take upper tri incl diag)
    D = null_basis.shape[1]
    Rmat_ds = [vec_to_mat(null_basis[:, d], triu_idx, N) for d in range(D)]
    ric_rows = []
    ric_labels = []
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D)
            for j in range(n):
                if j == i or j == k:
                    continue
                for d in range(D):
                    row[d] += R_val(Rmat_ds[d], pos, n, i, j, k, j)
            ric_rows.append(row)
            ric_labels.append((i, k))
    RicMat = np.array(ric_rows)
    print("RicMat shape:", RicMat.shape)
    Ur, Sr, Vtr = np.linalg.svd(RicMat)
    tolr = 1e-9 * Sr[0]
    rankr = np.sum(Sr > tolr)
    print("rank(Ricci map) =", rankr, "=> dim Weyl =", D - rankr)
    formula_weyl = (n+2)*(n+1)*n*(n-3)/12
    print("formula (n+2)(n+1)n(n-3)/12 =", formula_weyl)
    weyl_coeffs = Vtr[rankr:, :].T  # D x (D-rankr) in null_basis coordinates
    weyl_basis = null_basis @ weyl_coeffs  # M x (D-rankr): each column = vec of a Weyl-tensor basis elt
    print("weyl_basis shape:", weyl_basis.shape)

    np.save("weyl_basis.npy", weyl_basis)
    import pickle
    with open("meta.pkl","wb") as f:
        pickle.dump({"n":n,"idx":idx,"pos":pos,"N":N,"triu_idx":triu_idx,"tpos":tpos,"c":c}, f)
    print("saved.")
