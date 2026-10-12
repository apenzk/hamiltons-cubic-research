"""
Reviewer 4 (adversarial): fresh, from-scratch check of the Fox r>=8 hyperkahler
subalgebra B_r result (Lemma 10.7(4b), r=8 case, ambient n=8).

Deliberately does NOT import curvature_operator.py, weyl_decomposition.py,
run_fox_r8_subalgebra.py, run_fox_r12_subalgebra.py, run_cp2_quaternion.py, or
run_fox_S4_check.py. Everything below is a fresh implementation:

  1. Q(W) = W^2 + W^# via the basis-free ad-trace formula
         <(A#B)phi,psi> = -1/4[tr(ad(phi)A ad(psi)B) + tr(ad(psi)A ad(phi)B)]
     (a DIFFERENT formula/code path from curvature_operator.py's
     "quadratic-form + finite-difference polarization" approach), validated
     against the trusted coordinate-diagonal formula before use.

  2. Fox's star/dot index formulas (6.1)/(6.2), implemented independently via
     brute-force S_4 permutation sums (own code, not imported).

  3. TWO hyperkahler structures on R^8, deliberately different constructions:
       (a) the "two repeated 4x4 quaternion blocks" baseline (same shape as
           both original agents used, needed as a sanity anchor), and
       (b) that SAME hyperkahler structure conjugated by a random O(8)
           orthogonal matrix -- dense, no block structure at all in the
           standard basis. Since Q and Fox's star/dot formulas are
           O(n)-equivariant by construction, a correct implementation MUST
           give identical P-values/Gram-eigenvalues/idempotent magnitudes
           for both -- a decisive test for basis-dependent bugs (the same
           bug class that sank two earlier rounds of this investigation).

  4. Gram-matrix rank AND full eigenvalue spread of the 6 candidate basis
     tensors (near-degeneracy check).

  5. Idempotent search on the reduced 6-dimensional algebra via multi-start
     Newton solving (own code), compared against the three P-magnitudes
     claimed in findings/INDEX.md at r=8: 1.11554670, 0.98601330, 0.97979590.
"""
import numpy as np
import itertools

rng_global = np.random.default_rng(20260819)

# ======================================================================
# 1. Fresh Q(W) = W^2 + W^# implementation via the ad-trace formula
# ======================================================================

def pair_basis(n):
    return list(itertools.combinations(range(n), 2))


def basis_2form(n, i, j):
    """e_i ^ e_j as an n x n skew matrix, E[j,i]=1, E[i,j]=-1 (matches the
    pair-vector convention used throughout: matrix_to_vec reads M[j,i])."""
    E = np.zeros((n, n))
    E[j, i] = 1.0
    E[i, j] = -1.0
    return E


def vec_to_mat(n, pairs, v):
    A = np.zeros((n, n))
    for a, (i, j) in enumerate(pairs):
        A[j, i] = v[a]
        A[i, j] = -v[a]
    return A


def mat_to_vec(pairs, A):
    return np.array([A[j, i] for (i, j) in pairs])


def build_ad_matrices(n):
    """ad_a = N x N matrix representing xi -> [e_a, xi] acting on so(n),
    expressed in the pair-vector basis. Own construction (not reusing
    curvature_operator.py's Lambda2.bracket)."""
    pairs = pair_basis(n)
    N = len(pairs)
    basis_mats = [basis_2form(n, i, j) for (i, j) in pairs]
    ad = np.zeros((N, N, N))  # ad[a] is an N x N matrix
    for a in range(N):
        Ea = basis_mats[a]
        for b in range(N):
            Eb = basis_mats[b]
            comm = Ea @ Eb - Eb @ Ea
            v = mat_to_vec(pairs, comm)
            ad[a, :, b] = v
    return ad, pairs, N


class QEngine:
    def __init__(self, n):
        self.n = n
        self.ad, self.pairs, self.N = build_ad_matrices(n)
        self.idx = {p: k for k, p in enumerate(self.pairs)}

    def sharp(self, A, B):
        """Full N x N matrix representing the operator A#B, via the
        basis-free trace/ad formula (own, independent code path)."""
        N = self.N
        ad = self.ad
        # precompute ad_a @ A for all a, and ad_b @ B for all b
        AdA = np.einsum('aij,jk->aik', ad, A)   # shape (N,n?,) -- ad is NxNxN, A is NxN
        AdB = np.einsum('aij,jk->aik', ad, B)
        # (A#B)[a,b] = -1/4[tr(AdA[a] @ ad[b] @ B) + tr(AdB doesn't directly work; do explicit)]
        out = np.zeros((N, N))
        for a in range(N):
            AdaA = AdA[a]
            for b in range(N):
                AdbB = AdB[b]
                t1 = np.trace(AdaA @ AdbB)
                AdbA = AdA[b]
                AdaB = AdB[a]
                t2 = np.trace(AdbA @ AdaB)
                out[a, b] = -0.25 * (t1 + t2)
        return out

    def Q(self, W):
        return W @ W + self.sharp(W, W)


def test_diagonal_formula(n=7, seed=0):
    rng = np.random.default_rng(seed)
    eng = QEngine(n)
    pairs, idx, N = eng.pairs, eng.idx, eng.N
    lam = {p: rng.normal() for p in pairs}
    M = np.zeros((N, N))
    for p in pairs:
        M[idx[p], idx[p]] = lam[p]
    Qm = eng.Q(M)
    worst = 0.0
    for (i, j) in pairs:
        known = lam[(i, j)] ** 2
        for k in range(n):
            if k in (i, j):
                continue
            a = (min(i, k), max(i, k))
            b = (min(j, k), max(j, k))
            known += lam[a] * lam[b]
        got = Qm[idx[(i, j)], idx[(i, j)]]
        worst = max(worst, abs(got - known))
    offmax = np.max(np.abs(Qm - np.diag(np.diag(Qm))))
    print(f"[validate] n={n}: worst diag err = {worst:.3e}, max off-diag = {offmax:.3e}")
    return worst < 1e-8 and offmax < 1e-8


def test_full_symmetry(n=7, seed=1):
    """Check the polarized trilinear form T(A,B,C)=<A,sharp(B,C)+ ...> style
    symmetry: specifically check sharp(A,B) is symmetric under A<->B and that
    <A, sharp(B,C)> is symmetric under all permutations of (A,B,C) after
    including the A.A term -- a strong test that would have caught the
    previously-retracted per-operator-eigenbasis bug."""
    eng = QEngine(n)
    N = eng.N
    rng = np.random.default_rng(seed)

    def rand_sym():
        M = rng.normal(size=(N, N))
        return 0.5 * (M + M.T)
    A, B, C = rand_sym(), rand_sym(), rand_sym()

    def T(X, Y, Z):
        # <X, Y#Z> using our sharp
        return np.sum(X * eng.sharp(Y, Z))
    vals = [T(A, B, C), T(A, C, B), T(B, A, C), T(B, C, A), T(C, A, B), T(C, B, A)]
    spread = max(vals) - min(vals)
    print(f"[validate] n={n}: 6-permutation spread of <A,sharp(B,C)> = {spread:.3e} (want ~0)")
    return spread < 1e-8


# ======================================================================
# 2. Fox's star/dot index formulas -- own brute-force implementation
# ======================================================================

def antisym4(alpha, beta, i, j, k, l):
    """alpha_{[ij} beta_{kl]}, brute force over S_4, own permutation-sign code
    (independent of run_fox_S4_check.py's implementation)."""
    idxs = (i, j, k, l)
    total = 0.0
    for perm in itertools.permutations(range(4)):
        sign = 1
        seen = list(perm)
        # compute parity via cycle counting (independent style from original)
        visited = [False] * 4
        for start in range(4):
            if visited[start]:
                continue
            length = 0
            x = start
            while not visited[x]:
                visited[x] = True
                x = seen[x]
                length += 1
            if length % 2 == 0:
                sign *= -1
        a, b, c, d = (idxs[perm[0]], idxs[perm[1]], idxs[perm[2]], idxs[perm[3]])
        total += sign * alpha[a, b] * beta[c, d]
    return total / 24.0


def bracket2(f, i, j):
    return 0.5 * (f(i, j) - f(j, i))


def star_product(alpha, beta, i, j, k, l):
    """Fox (6.1), symmetric alpha,beta: (alpha ? beta)_ijkl = a_{k[i}b_{j]l} - a_{l[i}b_{j]k}."""
    t1 = bracket2(lambda a, b: alpha[k, a] * beta[b, l], i, j)
    t2 = bracket2(lambda a, b: alpha[l, a] * beta[b, k], i, j)
    return t1 - t2


def dot_product(alpha, beta, i, j, k, l):
    """Fox (6.2): alpha.beta = -3(a_{k[i}b_{j]l} - a_{l[i}b_{j]k} - 2 a_{[ij}b_{kl]})."""
    t1 = bracket2(lambda a, b: alpha[k, a] * beta[b, l], i, j)
    t2 = bracket2(lambda a, b: alpha[l, a] * beta[b, k], i, j)
    corr = antisym4(alpha, beta, i, j, k, l)
    return -3.0 * (t1 - t2 - 2.0 * corr)


def build_Sr(n, r, alpha_endo, block):
    """S^r(alpha) = 1/(r+2) * (3/(r-1) g?g - alpha.alpha), Fox (10.2).
    alpha_endo: the complex-structure ENDOMORPHISM matrix (M[b,a]=<Me_a,e_b>);
    the fundamental 2-form is its transpose (matches both original scripts'
    convention -- verified below by checking alpha is antisymmetric)."""
    alpha = alpha_endo.T.copy()
    assert np.allclose(alpha, -alpha.T), "fundamental 2-form must be antisymmetric"
    g = np.zeros((n, n))
    for b in block:
        g[b, b] = 1.0
    c1 = 3.0 / (r - 1)
    pref = 1.0 / (r + 2)

    def T(i, j, k, l):
        return pref * (c1 * star_product(g, g, i, j, k, l) - dot_product(alpha, alpha, i, j, k, l))
    return T, alpha, g


def build_dot_tensor(alphaA_endo, alphaB_endo):
    alphaA = alphaA_endo.T.copy()
    alphaB = alphaB_endo.T.copy()

    def T(i, j, k, l):
        return dot_product(alphaA, alphaB, i, j, k, l)
    return T


def mop_from_tensor(pairs, T):
    N = len(pairs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            M[a, b] = T(i, j, k, l)
    return M


def ricci_from_mop(n, pairs, idx, M):
    def get_entry(i, j, k, l):
        if i == j or k == l:
            return 0.0
        s1 = s2 = 1.0
        if i > j:
            i, j = j, i; s1 = -1.0
        if k > l:
            k, l = l, k; s2 = -1.0
        return s1 * s2 * M[idx[(i, j)], idx[(k, l)]]
    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            Ric[i, k] = sum(get_entry(i, j, k, j) for j in range(n))
    return Ric


def frob(A, B):
    return float(np.sum(A * B))


def norm(A):
    return float(np.sqrt(frob(A, A)))


# ======================================================================
# 3. Two hyperkahler structures on R^8 -- block-diagonal AND randomly rotated
# ======================================================================

def quaternion_blocks(n, blocks):
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    for (b0, b1, b2, b3) in blocks:
        I[b1, b0] = 1.0; I[b0, b1] = -1.0
        I[b3, b2] = 1.0; I[b2, b3] = -1.0
        J[b2, b0] = 1.0; J[b0, b2] = -1.0
        J[b3, b1] = -1.0; J[b1, b3] = 1.0
        K[b3, b0] = 1.0; K[b0, b3] = -1.0
        K[b2, b1] = 1.0; K[b1, b2] = -1.0
    return I, J, K


def random_orthogonal(n, seed):
    rng = np.random.default_rng(seed)
    M = rng.normal(size=(n, n))
    Q, R = np.linalg.qr(M)
    Q = Q @ np.diag(np.sign(np.diag(R)))
    return Q


def verify_hyperkahler(I, J, K, label):
    n = I.shape[0]
    Id = np.eye(n)
    checks = {
        "I2+Id": I @ I + Id, "J2+Id": J @ J + Id, "K2+Id": K @ K + Id,
        "IJ-K": I @ J - K, "JK-I": J @ K - I, "KI-J": K @ I - J,
        "IJ+JI": I @ J + J @ I, "JK+KJ": J @ K + K @ J, "KI+IK": K @ I + I @ K,
    }
    worst = max(np.max(np.abs(M)) for M in checks.values())
    print(f"  [{label}] worst hyperkahler-relation residual = {worst:.3e}")
    return worst


# ======================================================================
# 4. build the 6-tensor B_r basis, Gram matrix, and idempotent search
# ======================================================================

def build_basis(n, r, block, I, J, K):
    pairs = pair_basis(n)
    Ta, alphaA, g = build_Sr(n, r, I, block)
    Tb, alphaB, _ = build_Sr(n, r, J, block)
    Tc, alphaC, _ = build_Sr(n, r, K, block)
    Sa = mop_from_tensor(pairs, Ta)
    Sb = mop_from_tensor(pairs, Tb)
    Sc = mop_from_tensor(pairs, Tc)
    Tab = build_dot_tensor(I, J)
    Tbc = build_dot_tensor(J, K)
    Tca = build_dot_tensor(K, I)
    Mab = mop_from_tensor(pairs, Tab)
    Mbc = mop_from_tensor(pairs, Tbc)
    Mca = mop_from_tensor(pairs, Tca)
    return [Sa, Sb, Sc, Mab, Mbc, Mca], pairs


def bil(eng, X, Y):
    return 0.5 * (eng.Q(X + Y) - eng.Q(X) - eng.Q(Y))


def build_structure_tensor(eng, basis):
    m = len(basis)
    G = np.array([[frob(basis[i], basis[j]) for j in range(m)] for i in range(m)])
    Ginv = np.linalg.inv(G)
    C = np.zeros((m, m, m))
    worst = 0.0
    for i in range(m):
        for j in range(i, m):
            Bij = bil(eng, basis[i], basis[j])
            v = np.array([frob(Bij, basis[k]) for k in range(m)])
            c = Ginv @ v
            recon = sum(c[k] * basis[k] for k in range(m))
            resid = norm(Bij - recon) / (norm(Bij) + 1e-300)
            worst = max(worst, resid)
            C[i, j, :] = c
            C[j, i, :] = c
    return G, C, worst


def Q_reduced(C, x):
    return np.einsum('i,j,ijk->k', x, x, C)


def newton_idempotent_search(C, m, n_trials, seed, structured_seeds=()):
    from scipy.optimize import root
    rng = np.random.default_rng(seed)

    def F(x):
        qx = Q_reduced(C, x)
        lam = float(np.dot(x, qx))
        return qx - lam * x

    starts = [rng.normal(size=m) for _ in range(n_trials)]
    starts = [s / np.linalg.norm(s) for s in starts]
    for s in structured_seeds:
        s = np.array(s, dtype=float)
        ns = np.linalg.norm(s)
        if ns > 1e-12:
            starts.append(s / ns)

    out = []
    for x0 in starts:
        sol = root(F, x0, method='hybr', tol=1e-13)
        if not sol.success:
            continue
        x = sol.x
        nx = np.linalg.norm(x)
        if nx < 1e-8:
            continue
        x = x / nx
        qx = Q_reduced(C, x)
        lam = float(np.dot(x, qx))
        resid = np.linalg.norm(qx - lam * x)
        out.append((x, lam, resid))
    return out


def true_P_clusters(results, G, lam_tol=1e-4, resid_tol=1e-7):
    recs = []
    for x, lam, r in results:
        if r > resid_tol:
            continue
        nrm2 = x @ G @ x
        if nrm2 < 1e-12:
            continue
        Pt = lam / np.sqrt(nrm2)
        xu = x / np.sqrt(nrm2)
        recs.append((Pt, xu))
    recs.sort(key=lambda t: t[0])
    clusters = []
    for Pt, xu in recs:
        if clusters and abs(Pt - clusters[-1][0]) < lam_tol:
            clusters[-1][1] += 1
            clusters[-1][2].append(xu)
        else:
            clusters.append([Pt, 1, [xu]])
    clusters.sort(key=lambda c: -c[0])
    return clusters


def run_case(n, r, block, I, J, K, label, n_trials=4000, seed=42):
    print(f"\n{'='*70}\ncase: {label}  (n={n}, r={r})\n{'='*70}")
    verify_hyperkahler(I, J, K, label)
    eng = QEngine(n)
    basis, pairs = build_basis(n, r, block, I, J, K)
    idx = {p: k for k, p in enumerate(pairs)}
    names = ["S(a)", "S(b)", "S(c)", "M(ab)", "M(bc)", "M(ca)"]

    print("  Ricci-flatness of S^r(alpha,beta,gamma):")
    for nm, M in zip(names[:3], basis[:3]):
        Ric = ricci_from_mop(n, pairs, idx, M)
        print(f"    {nm}: max|Ricci| = {np.max(np.abs(Ric)):.3e}, |.|^2 = {frob(M,M):.8f}")

    fox_norm2 = 6.0 * r * (r - 2) / ((r + 2) * (r - 1))
    print(f"  Fox |S^r(alpha)|^2 formula = {fox_norm2:.8f}, pipeline = {frob(basis[0],basis[0]):.8f}")

    Ssum = basis[0] + basis[1] + basis[2]
    ratio = norm(Ssum) / norm(basis[0])
    print(f"  |S(a)+S(b)+S(c)|/|S(a)| = {ratio:.6f}  (0 would mean r=4-style collapse; r>=8 must be nonzero)")

    m = len(basis)
    G = np.array([[frob(basis[i], basis[j]) for j in range(m)] for i in range(m)])
    eigvals = np.linalg.eigvalsh(G)
    print(f"  Gram matrix eigenvalues: {np.array2string(eigvals, precision=6)}")
    rank = int(np.sum(eigvals > 1e-8 * eigvals[-1]))
    print(f"  => numerical rank = {rank} (want 6); smallest/largest eigenvalue ratio = {eigvals[0]/eigvals[-1]:.3e}")

    print("  Building structure tensor (own ad-trace Q implementation)...")
    Gm, C, worst_resid = build_structure_tensor(eng, basis)
    print(f"    worst subalgebra-closure residual = {worst_resid:.3e}")

    structured_seeds = [
        [1, 0, 0, 0, 0, 0], [0, 0, 0, 1, 0, 0], [1, 1, 1, 0, 0, 0],
        [1, -1, 0, 0, 0, 0], [0, 0, 0, 1, 1, 1], [0, 0, 0, 1, -1, 0],
        [1, 1, 1, 1, 1, 1], [2, -1, -1, 0, 0, 0], [2, -1, -1, 1, 1, 1],
        [2, -1, -1, -1, -1, -1],
    ]
    results = newton_idempotent_search(C, m, n_trials=n_trials, seed=seed, structured_seeds=structured_seeds)
    print(f"  Newton search: {len(results)}/{n_trials + len(structured_seeds)} converged")
    clusters = true_P_clusters(results, Gm)

    sqrt32 = np.sqrt(1.5)
    sphere_n = np.sqrt(2.0 * (n - 1) * (n - 2) / n**2)
    print(f"  reference: sqrt(3/2)={sqrt32:.6f}, balanced sphere at n={n}: {sphere_n:.6f}")
    print(f"  {len(clusters)} distinct true-P clusters:")
    for Pt, cnt, xus in clusters:
        beats = ""
        if abs(Pt) > sqrt32 + 1e-9:
            beats += " <-- BEATS sqrt(3/2)"
        if abs(Pt) > sphere_n + 1e-9:
            beats += " <-- BEATS sphere"
        print(f"    P = {Pt:+.8f}  (count={cnt}){beats}")

    return dict(eng=eng, basis=basis, G=G, eigvals=eigvals, C=C, clusters=clusters, pairs=pairs)


def main():
    print("### Step A: validate the fresh Q(W)=W^2+W^# implementation ###")
    for n in [5, 6, 7]:
        ok1 = test_diagonal_formula(n)
        ok2 = test_full_symmetry(n)
        assert ok1 and ok2, f"validation FAILED at n={n}"
    print("  -> fresh Q implementation validated (diagonal formula + full 3-permutation symmetry)\n")

    n = 8
    r = 8
    block = tuple(range(8))
    blocks4 = ((0, 1, 2, 3), (4, 5, 6, 7))
    I0, J0, K0 = quaternion_blocks(n, blocks4)

    res_block = run_case(n, r, block, I0, J0, K0, "baseline: two repeated 4x4 quaternion blocks",
                          n_trials=4000, seed=1)

    # genuinely different construction: same hyperkahler structure, conjugated
    # by a random O(8) matrix -- dense, no visible block structure at all.
    O = random_orthogonal(n, seed=99)
    I1, J1, K1 = O @ I0 @ O.T, O @ J0 @ O.T, O @ K0 @ O.T
    res_rot = run_case(n, r, block, I1, J1, K1, "random-O(8)-rotated (dense, same abstract structure)",
                        n_trials=4000, seed=2)

    print(f"\n{'='*70}\ncross-check: block vs randomly-rotated construction\n{'='*70}")
    ev_diff = np.max(np.abs(np.sort(res_block['eigvals']) - np.sort(res_rot['eigvals'])))
    print(f"max |Gram eigenvalue difference| (sorted) between the two constructions = {ev_diff:.3e}")
    cb = sorted([c[0] for c in res_block['clusters']])
    cr = sorted([c[0] for c in res_rot['clusters']])
    print(f"block-construction P values:   {['%.8f'%v for v in cb]}")
    print(f"rotated-construction P values: {['%.8f'%v for v in cr]}")
    if len(cb) == len(cr):
        diffs = [abs(a - b) for a, b in zip(cb, cr)]
        print(f"max |P-value difference| = {max(diffs):.3e}  (should be ~0 if no basis-dependent bug)")
    else:
        print("MISMATCH IN NUMBER OF CLUSTERS FOUND -- possible bug or incomplete search")

    print(f"\n{'='*70}\nreference values from findings/INDEX.md at r=8: 1.11554670, 0.98601330, 0.97979590\n{'='*70}")


if __name__ == "__main__":
    main()
