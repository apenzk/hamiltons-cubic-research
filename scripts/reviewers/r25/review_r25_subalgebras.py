"""Reviewer 25, library of subalgebras h subset so(n), with the extra (possibly
disconnected) group generators needed for K.  Each entry returns
    (name, n, list of so(n) generators of h, list of extra O(n) elements of K)
"""
import numpy as np, itertools

def so_gens(n, idx=None):
    idx = list(range(n)) if idx is None else list(idx)
    out = []
    for a in range(len(idx)):
        for b in range(a + 1, len(idx)):
            X = np.zeros((n, n)); X[idx[a], idx[b]] = 1; X[idx[b], idx[a]] = -1
            out.append(X)
    return out

def block_diag_perm(n, perm):
    Pm = np.zeros((n, n))
    for i, p in enumerate(perm):
        Pm[p, i] = 1.0
    return Pm

# ---- so(p)+so(q) inside so(p+q), K gets the swap when p==q
def so_p_so_q(p, q):
    n = p + q
    g = so_gens(n, range(p)) + so_gens(n, range(p, n))
    extra = []
    if p == q:
        perm = list(range(p, n)) + list(range(p))
        extra = [block_diag_perm(n, perm)]
    return f"so({p})+so({q})", n, g, extra

def so_blocks(parts):
    """so(p1)+...+so(pk) with K containing the permutations of equal blocks."""
    n = sum(parts)
    offs, s = [], 0
    for p in parts:
        offs.append((s, s + p)); s += p
    g = []
    for (a, b) in offs:
        g += so_gens(n, range(a, b))
    extra = []
    if len(set(parts)) == 1 and len(parts) > 1:
        p = parts[0]
        # cyclic shift and a transposition of the first two blocks
        cyc = []
        for k in range(len(parts)):
            cyc += list(range(((k + 1) % len(parts)) * p, ((k + 1) % len(parts)) * p + p))
        extra.append(block_diag_perm(n, cyc))
        tr = list(range(p, 2 * p)) + list(range(p)) + list(range(2 * p, n))
        extra.append(block_diag_perm(n, tr))
    return "so(" + ")+so(".join(map(str, parts)) + ")", n, g, extra

# ---- u(m) inside so(2m):  real form of gl, J = standard complex structure
def u_m(m):
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1; J[2 * k + 1, 2 * k] = -1
    g = []
    # u(m) = {X in so(2m) : XJ = JX}
    for a in range(n):
        for b in range(a + 1, n):
            X = np.zeros((n, n)); X[a, b] = 1; X[b, a] = -1
            g.append(X + J @ X @ J.T)   # project onto the J-commuting part
            g.append(X - J @ X @ J.T)
    # keep only the J-commuting ones
    g = [X for X in g if np.linalg.norm(X @ J - J @ X) < 1e-12 and np.linalg.norm(X) > 1e-12]
    extra = [np.diag([1.0] + [-1.0] + [1.0] * (n - 2))]  # complex conjugation
    return f"u({m})", n, g, extra

def su_m(m):
    name, n, g, extra = u_m(m)
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1; J[2 * k + 1, 2 * k] = -1
    # remove the centre R.J : project each generator orthogonal to J
    nJ2 = np.tensordot(J, J)
    g2 = [X - (np.tensordot(X, J) / nJ2) * J for X in g]
    g2 = [X for X in g2 if np.linalg.norm(X) > 1e-10]
    return f"su({m})", n, g2, extra

# ---- sp(m) + sp(1) inside so(4m) via quaternionic structures
def quat_structs(m):
    n = 4 * m
    def blk(M):
        Z = np.zeros((n, n))
        for k in range(m):
            Z[4 * k:4 * k + 4, 4 * k:4 * k + 4] = M
        return Z
    I4 = np.array([[0,-1,0,0],[1,0,0,0],[0,0,0,-1],[0,0,1,0]], float)
    J4 = np.array([[0,0,-1,0],[0,0,0,1],[1,0,0,0],[0,-1,0,0]], float)
    K4 = I4 @ J4
    return blk(I4), blk(J4), blk(K4)

def sp_m_sp_1(m):
    n = 4 * m
    I, J, K = quat_structs(m)
    # sp(m) = so(4m) elements commuting with I,J,K ; sp(1) = span{I,J,K}
    g = []
    for a in range(n):
        for b in range(a + 1, n):
            X = np.zeros((n, n)); X[a, b] = 1; X[b, a] = -1
            Y = X + I @ X @ I.T + J @ X @ J.T + K @ X @ K.T
            if np.linalg.norm(Y) > 1e-10:
                g.append(Y)
    g = [X for X in g if max(np.linalg.norm(X @ M - M @ X) for M in (I, J, K)) < 1e-9]
    return f"sp({m})", n, g, []

def sp_m_plus_sp1(m):
    name, n, g, _ = sp_m_sp_1(m)
    I, J, K = quat_structs(m)
    return f"sp({m})+sp(1)", n, g + [I, J, K], []

# ---- adjoint embedding of a compact simple g into so(dim g)
def adjoint_embedding(gens, label):
    """gens: matrices spanning a Lie algebra; build ad on an orthonormal basis."""
    B = np.array([X.flatten() for X in gens])
    Uq, s, Vt = np.linalg.svd(B, full_matrices=False)
    keep = s > 1e-9 * s[0]
    onb = Vt[keep]            # rows: orthonormal (Frobenius) basis of g
    d = onb.shape[0]
    k = gens[0].shape[0]
    mats = [onb[i].reshape(k, k) for i in range(d)]
    # normalise Frobenius-orthonormal already
    ad = []
    for X in mats:
        A = np.zeros((d, d))
        for j, Y in enumerate(mats):
            C = X @ Y - Y @ X
            for i, Z in enumerate(mats):
                A[i, j] = np.tensordot(C, Z)
        ad.append(0.5 * (A - A.T) + 0.5 * (A - A.T) * 0)  # should already be antisym
    ad = [0.5 * (A - A.T) for A in ad]
    return label, d, ad, []

def so_k_adjoint(k):
    return adjoint_embedding(so_gens(k), f"so({k})-adjoint")

def su_k_adjoint(k):
    # su(k) as real matrices? use the complex antihermitian traceless algebra
    gens = []
    for a in range(k):
        for b in range(a + 1, k):
            X = np.zeros((k, k), complex); X[a, b] = 1; X[b, a] = -1; gens.append(X)
            Y = np.zeros((k, k), complex); Y[a, b] = 1j; Y[b, a] = 1j; gens.append(Y)
    for a in range(k - 1):
        D = np.zeros((k, k), complex); D[a, a] = 1j; D[a + 1, a + 1] = -1j; gens.append(D)
    # real-linear ad action on the real vector space su(k)
    B = np.array([X.flatten() for X in gens])
    # orthonormalise w.r.t. real inner product Re tr(X^* Y)
    Br = np.hstack([B.real, B.imag])
    Uq, s, Vt = np.linalg.svd(Br, full_matrices=False)
    keep = s > 1e-9 * s[0]
    onb = Vt[keep]
    d = onb.shape[0]
    mats = [(onb[i][:k*k] + 1j * onb[i][k*k:]).reshape(k, k) for i in range(d)]
    ad = []
    for X in mats:
        A = np.zeros((d, d))
        for j, Y in enumerate(mats):
            Cm = X @ Y - Y @ X
            for i, Z in enumerate(mats):
                A[i, j] = np.real(np.tensordot(Cm, Z.conj()))
        ad.append(0.5 * (A - A.T))
    return f"su({k})-adjoint", d, ad, []

# ---- tensor product so(p) (x) so(q) inside so(pq)
def so_p_tensor_so_q(p, q):
    n = p * q
    Ip, Iq = np.eye(p), np.eye(q)
    g = [np.kron(X, Iq) for X in so_gens(p)] + [np.kron(Ip, Y) for Y in so_gens(q)]
    extra = []
    if p == q:
        S = np.zeros((n, n))
        for i in range(p):
            for j in range(q):
                S[j * p + i, i * q + j] = 1.0
        extra = [S]
    return f"so({p})(x)so({q})", n, g, extra

# ---- so(3) irreducible in so(2l+1) via the spin-l real representation
def so3_irrep(l):
    """real (2l+1)-dim irrep of so(3); l integer."""
    d = 2 * l + 1
    # complex spin-l matrices in the |l,m> basis, then a real basis
    ms = np.arange(l, -l - 1, -1.0)
    Jz = np.diag(ms).astype(complex)
    Jp = np.zeros((d, d), complex); Jm = np.zeros((d, d), complex)
    for a in range(d):
        for b in range(d):
            if a == b - 1:
                m = ms[b]
                Jp[a, b] = np.sqrt(l * (l + 1) - m * (m + 1))
            if a == b + 1:
                m = ms[b]
                Jm[a, b] = np.sqrt(l * (l + 1) - m * (m - 1))
    Jx = (Jp + Jm) / 2; Jy = (Jp - Jm) / (2j)
    # real structure: |l,m> basis has the reality map |l,m> -> (-1)^m |l,-m>
    T = np.zeros((d, d), complex)
    for a, m in enumerate(ms):
        b = int(round(l - (-m)))
        if m > 0:
            T[a, a] = 1 / np.sqrt(2); T[a, b] = ((-1) ** int(m)) / np.sqrt(2)
        elif m == 0:
            T[a, a] = 1.0
        else:
            T[a, a] = 1j / np.sqrt(2); T[a, b] = -1j * ((-1) ** int(-m)) / np.sqrt(2)
    g = []
    for Jc in (Jx, Jy, Jz):
        M = T @ (1j * Jc) @ np.linalg.inv(T)
        assert np.abs(M.imag).max() < 1e-8, np.abs(M.imag).max()
        M = M.real
        g.append(0.5 * (M - M.T))
    return f"so(3)@spin{l}", d, g, []

# ---- g2 inside so(7) : derivations of the octonions / stabiliser of phi
def g2_in_so7():
    n = 7
    # associative 3-form phi with the standard structure constants
    triples = [(0,1,2),(0,3,4),(0,6,5),(1,3,5),(1,4,6),(2,3,6),(2,4,5)]
    phi = np.zeros((7,7,7))
    for (i,j,k) in triples:
        for perm, s in ((( i,j,k),1),((j,k,i),1),((k,i,j),1),((j,i,k),-1),((i,k,j),-1),((k,j,i),-1)):
            phi[perm] = s
    g = []
    for a in range(n):
        for b in range(a+1, n):
            X = np.zeros((n,n)); X[a,b]=1; X[b,a]=-1
            g.append(X)
    # solve for the subspace annihilating phi
    A = []
    for X in g:
        d = np.einsum('ia,ajk->ijk', X, phi) + np.einsum('ja,iak->ijk', X, phi) + np.einsum('ka,ija->ijk', X, phi)
        A.append(d.flatten())
    A = np.array(A)
    U, s, Vt = np.linalg.svd(A.T, full_matrices=False)
    ns = [i for i in range(len(s)) if s[i] < 1e-8 * s[0]]
    # nullspace of A^T ... we need nullspace of the map coeff -> d
    import scipy.linalg as sla
    ker = sla.null_space(A.T.T) if False else None
    # coefficients c with sum c_i A_i = 0
    U2, s2, V2t = np.linalg.svd(A, full_matrices=True)
    tol = 1e-8 * s2[0]
    rank = int((s2 > tol).sum())
    ker = V2t  # wrong shape; do it properly below
    # A is (21 x 343); nullspace of A as a map R^21 -> R^343 is right-null of A
    Uu, ss, Vv = np.linalg.svd(A, full_matrices=True)
    # A = U S V^T with A: 21x343 -> left singular vectors in R^21
    # coefficients c in R^21 with c^T A = 0  <=> c in left-nullspace of A
    lnull = Uu[:, rank:]
    out = []
    for c in lnull.T:
        M = sum(ci * Xi for ci, Xi in zip(c, g))
        out.append(M)
    return "g2", 7, out, []

def spin7_in_so8():
    n = 8
    # Cayley 4-form from the octonion multiplication: use the standard Phi
    quads = [(0,1,2,3),(0,1,4,5),(0,1,6,7),(0,2,4,6),(0,2,7,5),(0,3,4,7),(0,3,5,6),
             (4,5,6,7),(2,3,6,7),(2,3,4,5),(1,3,5,7),(1,3,6,4),(1,2,5,6),(1,2,7,4)]
    Phi = np.zeros((8,8,8,8))
    for q in quads:
        for perm in itertools.permutations(range(4)):
            s = 1
            pl = list(perm)
            # parity
            visited = [False]*4; par = 0
            for i in range(4):
                if not visited[i]:
                    j = i; c = 0
                    while not visited[j]:
                        visited[j] = True; j = pl[j]; c += 1
                    par += c - 1
            s = (-1)**par
            Phi[tuple(q[p] for p in perm)] = s
    g = []
    for a in range(n):
        for b in range(a+1, n):
            X = np.zeros((n,n)); X[a,b]=1; X[b,a]=-1
            g.append(X)
    A = []
    for X in g:
        d = (np.einsum('ia,ajkl->ijkl', X, Phi) + np.einsum('ja,iakl->ijkl', X, Phi)
             + np.einsum('ka,ijal->ijkl', X, Phi) + np.einsum('la,ijka->ijkl', X, Phi))
        A.append(d.flatten())
    A = np.array(A)
    Uu, ss, Vv = np.linalg.svd(A, full_matrices=True)
    rank = int((ss > 1e-8 * ss[0]).sum())
    lnull = Uu[:, rank:]
    out = [sum(ci * Xi for ci, Xi in zip(c, g)) for c in lnull.T]
    return "spin(7)", 8, out, []
