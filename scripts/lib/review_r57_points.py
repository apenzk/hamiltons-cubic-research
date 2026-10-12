"""Reviewer 57: the catalogue of critical points, built independently.

Every point is produced either
  (a) as the unique invariant Weyl operator of a subalgebra k (Schur: if the
      k-invariant subspace of Weyl_n is one-dimensional then Q(W) = theta W
      automatically, by equivariance of Q), or
  (b) explicitly from its curvature tensor (W_CP2, C_5 blow-ups, sphere
      products), or
  (c) as an orthogonal BLOCK SUM of two critical points living on
      complementary coordinate blocks.

Criticality is then verified, never assumed:  ||Q(W) - theta W|| is printed.
"""
import itertools
import numpy as np

from review_r57_core import Alg, Weyl, slack_structural, slack_theta_identity, ricci, bianchi_defect

# ------------------------------------------------------------------ helpers

def unit(W):
    return W / np.linalg.norm(W)


def orient(alg, W):
    """P is odd; pick the sign with theta > 0."""
    return -W if alg.P(W) < 0 else W


def crit_residual(alg, W):
    th = alg.P(W)
    return th, float(np.linalg.norm(alg.Q(W) - th * W))


def weyl_report(alg, W):
    return float(np.abs(ricci(alg, W)).max()), float(np.abs(bianchi_defect(alg, W)).max())


# ------------------------------------------------------------------ invariant spaces

def commutant_on_weyl(n, gens, tol=1e-8):
    """Basis (in Weyl coordinates) of {W in Weyl_n : [ad(A), W] = 0 for A in gens}."""
    w = Weyl.get(n)
    alg = w.alg
    N, d = alg.N, w.dim
    F = w.basis_flat.reshape(N, N, d)
    K = np.zeros((d, d))
    for A in gens:
        ad = alg.ad(A)
        C = np.einsum('ij,jkd->ikd', ad, F, optimize=True) - np.einsum('ijd,jk->ikd', F, ad, optimize=True)
        M = w.basis_flat.T @ C.reshape(N * N, d)
        K += M.T @ M
    ev, V = np.linalg.eigh(K)
    keep = ev < tol * max(1.0, ev.max())
    return V[:, keep], ev


def invariant_point(n, gens, label):
    """The invariant Weyl operator when the invariant space is 1-dimensional."""
    V, ev = commutant_on_weyl(n, gens)
    w = Weyl.get(n)
    if V.shape[1] != 1:
        return None, V
    W = orient(w.alg, unit(w.from_coords(V[:, 0])))
    return W, V


# ------------------------------------------------------------------ subalgebras

def so_pq_gens(n, blocks):
    """Generators of so(p_1) + ... + so(p_k) in the given coordinate blocks."""
    gens = []
    for blk in blocks:
        for i, j in itertools.combinations(blk, 2):
            A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
            gens.append(A)
    return gens


def complex_structure(n):
    """J on R^n = C^{n/2}, J e_{2a} = e_{2a+1}."""
    m = n // 2
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a, 2 * a + 1] = -1.0
        J[2 * a + 1, 2 * a] = 1.0
    return J


def u_m_gens(n):
    """u(m) = {A in so(n) : AJ = JA}."""
    J = complex_structure(n)
    gens = []
    for i, j in itertools.combinations(range(n), 2):
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        gens.append(A)
    # solve the linear system AJ - JA = 0 inside so(n)
    G = np.array([(A @ J - J @ A).ravel() for A in gens]).T
    u, s, vt = np.linalg.svd(G)
    rank = int(np.sum(s > 1e-9 * s[0]))
    ns = vt[rank:]
    out = []
    for row in ns:
        A = sum(row[k] * gens[k] for k in range(len(gens)))
        out.append(A)
    return out, J


def su_m_gens(n):
    """su(m) = u(m) cap {tr_C = 0}: drop the centre R.J."""
    gens, J = u_m_gens(n)
    out = []
    for A in gens:
        A = A - (np.sum(A * J) / np.sum(J * J)) * J
        out.append(A)
    # re-orthogonalise
    G = np.array([A.ravel() for A in out])
    u, s, vt = np.linalg.svd(G, full_matrices=False)
    keep = s > 1e-9 * s[0]
    return [vt[k].reshape(n, n) for k in range(len(s)) if keep[k]], J


def quaternion_structures(n, block=None):
    """I,J,K on a 4m-dimensional coordinate block (identified with H^m)."""
    if block is None:
        block = list(range(n))
    assert len(block) % 4 == 0
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    for b in range(len(block) // 4):
        a0, a1, a2, a3 = block[4 * b:4 * b + 4]
        for (M, (p, q), (r, s), sgn) in ((I, (a0, a1), (a2, a3), +1),
                                         (J, (a0, a2), (a3, a1), +1),
                                         (K, (a0, a3), (a1, a2), +1)):
            M[p, q] = -1.0; M[q, p] = 1.0
            M[r, s] = -sgn; M[s, r] = sgn
    return I, J, K


def sp_m_gens(n, with_sp1=False):
    """sp(m) = {A in so(4m): A commutes with I,J,K};  sp(m)+sp(1) adds I,J,K."""
    I, J, K = quaternion_structures(n)
    gens = []
    for i, j in itertools.combinations(range(n), 2):
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        gens.append(A)
    G = np.array([np.concatenate([(A @ M - M @ A).ravel() for M in (I, J, K)]) for A in gens]).T
    u, s, vt = np.linalg.svd(G)
    rank = int(np.sum(s > 1e-9 * s[0]))
    out = [sum(row[k] * gens[k] for k in range(len(gens))) for row in vt[rank:]]
    if with_sp1:
        out = out + [I, J, K]
    return out, (I, J, K)


# ------------------------------------------------------------------ explicit points

def sphere_product(n, blocks):
    """Weyl part of the curvature operator of a product of unit spheres:
    the projection of Pi_h, h = so(p_1)+...+so(p_k), onto Weyl_n."""
    alg = Alg.get(n)
    w = Weyl.get(n)
    M = np.zeros((alg.N, alg.N))
    lab = {}
    for b, blk in enumerate(blocks):
        for i in blk:
            lab[i] = b
    for a, (i, j) in enumerate(alg.pairs):
        if lab.get(i, -1) == lab.get(j, -2):
            M[a, a] = 1.0
    return orient(alg, unit(w.project(M)))


def w_cp2(n, block=(0, 1, 2, 3)):
    """The self-dual operator on the 4-block: Nienhaus's W_CP2, zero-padded."""
    alg = Alg.get(n)
    b = list(block)
    def phi(i, j):
        s = 1.0
        if i > j:
            i, j, s = j, i, -1.0
        return alg.idx[(i, j)], s
    sd = []
    for (p, q), (r, s) in (((0, 1), (2, 3)), ((0, 2), (3, 1)), ((0, 3), (1, 2))):
        v = np.zeros(alg.N)
        k1, s1 = phi(b[p], b[q]); k2, s2 = phi(b[r], b[s])
        v[k1] += s1; v[k2] += s2
        sd.append(v / np.linalg.norm(v))
    W = 2 * np.outer(sd[0], sd[0]) - np.outer(sd[1], sd[1]) - np.outer(sd[2], sd[2])
    return orient(alg, unit(W))


def c5_blowup(n, sizes):
    """The C_5 blow-up: diagonal in coordinate 2-planes, entries by block pair."""
    alg = Alg.get(n)
    k = len(sizes)
    assert sum(sizes) == n
    G = [[1 if (abs(a - b) % k == 1 or abs(a - b) % k == k - 1) else 0 for b in range(k)]
         for a in range(k)]
    lab = []
    for b, sz in enumerate(sizes):
        lab += [b] * sz
    W = np.zeros((alg.N, alg.N))
    for a, (i, j) in enumerate(alg.pairs):
        A_, B_ = lab[i], lab[j]
        W[a, a] = 4.0 if A_ == B_ else (-2.0 if G[A_][B_] else 1.0)
    return orient(alg, unit(W))


def su_m_kahler(n):
    """Reviewer-57 rebuild of the 'su(m) Kaehler' point: the two-eigenvalue
    operator supported on su(m) subset so(2m), a * P_{so(m)} - b * P_{p}."""
    m = n // 2
    alg = Alg.get(n)

    def bivec(M):
        v = np.array([M[i, j] for (i, j) in alg.pairs])
        return v / np.linalg.norm(v)

    so_m, p_part = [], []
    for i, j in itertools.combinations(range(m), 2):
        B = np.zeros((m, m)); B[i, j] = -1.0; B[j, i] = 1.0
        M = np.zeros((n, n)); M[:m, :m] = B; M[m:, m:] = B
        so_m.append(bivec(M))
    Ss = []
    for i, j in itertools.combinations(range(m), 2):
        S = np.zeros((m, m)); S[i, j] = S[j, i] = 1.0
        Ss.append(S)
    for k in range(1, m):
        d = np.zeros(m); d[:k] = 1.0; d[k] = -float(k)
        Ss.append(np.diag(d) / np.linalg.norm(d))
    for S in Ss:
        M = np.zeros((n, n)); M[:m, m:] = -S; M[m:, :m] = S
        p_part.append(bivec(M))
    B1, B2 = np.array(so_m), np.array(p_part)
    r1, r2 = len(so_m), len(p_part)
    b = np.sqrt(r1 / (r2 * (r1 + r2)))
    a = r2 * b / r1
    return orient(alg, unit(a * (B1.T @ B1) - b * (B2.T @ B2)))


def block_sum(n, W1, blk1, W2, blk2):
    """Orthogonal block sum of two critical points on disjoint coordinate blocks,
    scaled by the harmonic-square law so that the sum is again critical."""
    alg = Alg.get(n)
    a1, a2 = Alg.get(len(blk1)), Alg.get(len(blk2))
    th1, th2 = a1.P(W1), a2.P(W2)
    t = 1.0 / th1
    s = 1.0 / th2
    nrm = np.hypot(t, s)
    t, s = t / nrm, s / nrm
    W = np.zeros((alg.N, alg.N))
    for (sub, sml, Wi, coef) in ((blk1, a1, W1, t), (blk2, a2, W2, s)):
        for a, (i, j) in enumerate(sml.pairs):
            A = alg.idx[(sub[i], sub[j])]
            for b, (k, l) in enumerate(sml.pairs):
                B = alg.idx[(sub[k], sub[l])]
                W[A, B] += coef * Wi[a, b]
    return W



def pad(n, W_small, block):
    """Zero-pad an operator on Lambda^2(R^k) into Lambda^2(R^n) along `block`.
    Padding preserves Ricci-flatness, Bianchi and criticality exactly."""
    alg = Alg.get(n)
    sml = Alg.get(len(block))
    W = np.zeros((alg.N, alg.N))
    for a, (i, j) in enumerate(sml.pairs):
        A = alg.idx[(block[i], block[j])]
        for b, (k, l) in enumerate(sml.pairs):
            W[A, alg.idx[(block[k], block[l])]] = W_small[a, b]
    return W


def invariant_family(n, gens):
    """The invariant Weyl subspace and its dimension."""
    V, ev = commutant_on_weyl(n, gens)
    return V


def crit_points_in_subspace(n, V, tries=400, seed=0):
    """All critical points of P inside the invariant subspace V (Q maps V to V,
    so critical in V == critical in Weyl_n).  Newton from random starts."""
    w = Weyl.get(n); alg = w.alg
    d = V.shape[1]
    rng = np.random.default_rng(seed)
    found = []
    for t in range(tries):
        x = rng.normal(size=d); x /= np.linalg.norm(x)
        for it in range(200):
            W = w.from_coords(V @ x)
            QW = alg.Q(W)
            th = float(np.sum(W * QW))
            g = V.T @ w.coords(QW) - th * x          # gradient of P/3 on the sphere
            if np.linalg.norm(g) < 1e-13:
                break
            # gradient ascent with projection (cheap, robust in small d)
            x = x + 0.05 * g / max(1.0, np.linalg.norm(g))
            x /= np.linalg.norm(x)
        W = w.from_coords(V @ x)
        th, res = crit_residual(alg, unit(W))
        if res < 1e-8:
            Wn = orient(alg, unit(W))
            if not any(np.linalg.norm(Wn - F) < 1e-6 or np.linalg.norm(Wn + F) < 1e-6
                       for F in found):
                found.append(Wn)
    return found


# ------------------------------------------------------------------ report

def describe(label, n, W, extra=""):
    alg = Alg.get(n)
    th, res = crit_residual(alg, W)
    ric, bia = weyl_report(alg, W)
    Sabs, Sfrac = slack_structural(alg, W)
    Sth = slack_theta_identity(alg, W)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    print(f"{label:<30} n={n:3d} theta={th:11.6f} th/th0={th/th0:7.4f} "
          f"crit={res:8.2e} ric={ric:7.1e} bia={bia:7.1e} "
          f"S_struct={Sabs:10.3e} S_theta={Sth:10.3e} {extra}")
    return dict(label=label, n=n, theta=th, ratio=th / th0, crit=res,
                S_struct=Sabs, S_frac=Sfrac, S_theta=Sth, W=W)


if __name__ == "__main__":
    rows = []
    print("== sphere products ==")
    rows.append(describe("S^3 x S^3", 6, sphere_product(6, [[0, 1, 2], [3, 4, 5]])))
    rows.append(describe("S^4 x S^4", 8, sphere_product(8, [list(range(4)), list(range(4, 8))])))
    rows.append(describe("S^6 x S^6", 12, sphere_product(12, [list(range(6)), list(range(6, 12))])))
    rows.append(describe("padded S^3 x S^3 -> 12", 12, sphere_product(12, [[0, 1, 2], [3, 4, 5]])))

    print("\n== W_CP2 / Fox ==")
    rows.append(describe("W_CP2 (n=4)", 4, w_cp2(4)))
    rows.append(describe("padded W_CP2 -> 8", 8, w_cp2(8)))
    rows.append(describe("padded W_CP2 -> 12", 12, w_cp2(12)))

    print("\n== C_5 blow-up ==")
    rows.append(describe("C_5 blow-up (2,2,2,2,2)", 10, c5_blowup(10, [2, 2, 2, 2, 2])))

    print("\n== su(m) Kaehler ==")
    for n in (6, 8, 12):
        rows.append(describe(f"su({n//2}) Kaehler", n, su_m_kahler(n)))
