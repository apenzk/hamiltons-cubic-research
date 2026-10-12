"""r272 -- independent check of the ad-form claims in findings/ad-form-attempt.md.

Nothing here imports the record's scripts. Conventions fixed from scratch:
  g = so(n), basis phi_{ij} = E_ij - E_ji (i<j), inner product <A,B> = (1/2) tr(A^T B),
  so {phi_a} is orthonormal.  A curvature operator M is the matrix M_ab = W_{ijkl}
  in that basis.  Hamilton/Bohm-Wilking:  (M^#)_ab = (1/2) sum c_{a p q} c_{b r s} M_pr M_qs
  with c_{abg} = <[phi_a,phi_b],phi_g>.  Wilking: <M^# x,y> = -(1/2) tr(ad_x M ad_y M).
"""
import numpy as np, itertools, sys

def basis(n):
    pairs = list(itertools.combinations(range(n), 2))
    mats = []
    for (i, j) in pairs:
        E = np.zeros((n, n)); E[i, j] = 1.0; E[j, i] = -1.0
        mats.append(E)
    return pairs, mats

def struct(n):
    pairs, mats = basis(n)
    N = len(pairs)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = mats[a] @ mats[b] - mats[b] @ mats[a]
            for g in range(N):
                c[a, b, g] = 0.5 * np.trace(mats[g].T @ C)
    return pairs, mats, N, c

def ad_ops(c):
    # (ad_a)_{g b} = <[phi_a, phi_b], phi_g> = c[a,b,g]
    return np.transpose(c, (0, 2, 1))   # ad[a][g,b]

def sharp_hamilton(M, c):
    return 0.5 * np.einsum('apq,brs,pr,qs->ab', c, c, M, M, optimize=True)

def sharp_wilking(M, ad):
    N = M.shape[0]
    AM = np.einsum('agb,bc->agc', ad, M)          # ad_a M
    return -0.5 * np.einsum('apq,bqp->ab', AM, AM, optimize=True)

# ---------- random Weyl tensor, built from the 4-tensor side ----------
def random_weyl(n, rng):
    G = rng.normal(size=(n, n, n, n))
    A = (G - np.transpose(G, (1, 0, 2, 3)) - np.transpose(G, (0, 1, 3, 2))
         + np.transpose(G, (1, 0, 3, 2))) / 4.0
    S = (A + np.transpose(A, (2, 3, 0, 1))) / 2.0
    cyc = (S + np.transpose(S, (0, 2, 3, 1)) + np.transpose(S, (0, 3, 1, 2))) / 3.0
    B = S - cyc                                   # first Bianchi now holds
    # project out the Kulkarni-Nomizu directions (Ricci part) by Gram-Schmidt
    g = np.eye(n)
    kn = []
    for i in range(n):
        for j in range(i, n):
            h = np.zeros((n, n)); h[i, j] += 1.0; h[j, i] += 1.0
            K = (np.einsum('ik,jl->ijkl', h, g) + np.einsum('jl,ik->ijkl', h, g)
                 - np.einsum('il,jk->ijkl', h, g) - np.einsum('jk,il->ijkl', h, g))
            kn.append(K)
    basisK = []
    for K in kn:
        v = K.copy()
        for u in basisK:
            v = v - np.sum(v * u) * u
        nv = np.linalg.norm(v)
        if nv > 1e-9:
            basisK.append(v / nv)
    for u in basisK:
        B = B - np.sum(B * u) * u
    return B

def to_operator(W, pairs):
    N = len(pairs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            M[a, b] = W[i, j, k, l]
    return M

def bianchi_defect(M, pairs, n):
    """Lambda^4 component of a symmetric operator on Lambda^2, as a 4-tensor norm ratio."""
    T = np.zeros((n, n, n, n))
    pos = {p: k for k, p in enumerate(pairs)}
    def val(i, j, k, l):
        if i == j or k == l: return 0.0
        si = 1.0; a = (i, j)
        if i > j: a = (j, i); si = -1.0
        sk = 1.0; b = (k, l)
        if k > l: b = (l, k); sk = -1.0
        return si * sk * M[pos[a], pos[b]]
    for i, j, k, l in itertools.product(range(n), repeat=4):
        T[i, j, k, l] = val(i, j, k, l)
    cyc = (T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))) / 3.0
    return np.linalg.norm(cyc), np.linalg.norm(T)

def secondkind(W, n):
    """Li's convention (W-ring h)_{ij} = sum W_{iklj} h_{kl}, on S^2_0."""
    # build on symmetric traceless basis
    B = []
    for i in range(n):
        for j in range(i + 1, n):
            h = np.zeros((n, n)); h[i, j] = h[j, i] = 1 / np.sqrt(2); B.append(h)
    for k in range(1, n):
        h = np.zeros((n, n))
        for i in range(k): h[i, i] = 1.0
        h[k, k] = -float(k)
        B.append(h / np.linalg.norm(h))
    d = len(B)
    Op = np.zeros((d, d))
    for a in range(d):
        img = np.einsum('iklj,kl->ij', W, B[a])
        for b in range(d):
            Op[a, b] = np.sum(img * B[b])
    return Op

if __name__ == '__main__':
    for n in [4, 5, 6, 7]:
        rng = np.random.default_rng(11 * n)
        pairs, mats, N, c = struct(n)
        ad = ad_ops(c)
        # total antisymmetry of c
        asym = max(np.abs(c + np.transpose(c, (1, 0, 2))).max(),
                   np.abs(c - np.transpose(c, (1, 2, 0))).max())
        W = random_weyl(n, rng)
        M = to_operator(W, pairs)
        M = M / np.linalg.norm(M)
        W = W / np.linalg.norm(to_operator(random_weyl(n, np.random.default_rng(11*n)), pairs)) if False else W
        # rebuild W consistently with normalised M
        SH = sharp_hamilton(M, c)
        SW = sharp_wilking(M, ad)
        p3mu = np.trace(M @ M @ M)
        pair_H = np.sum(SH * M)
        pair_W = np.sum(SW * M)
        # the file's formula, written literally
        lit = -0.5 * sum(M[a, b] * np.trace(ad[a] @ M @ ad[b] @ M) for a in range(N) for b in range(N))
        # Q preserves Bianchi?
        bQ, nQ = bianchi_defect(M @ M + SH, pairs, n)
        bS, nS = bianchi_defect(SH, pairs, n)
        bM2, nM2 = bianchi_defect(M @ M, pairs, n)
        bM, nM = bianchi_defect(M, pairs, n)
        # Ricci of W (check it is Weyl)
        ric = np.einsum('ijil->jl', W)
        print(f"n={n} N={N}  c totally antisym resid {asym:.2e}   Ric(W) {np.abs(ric).max():.2e}")
        print(f"   Hamilton vs Wilking sharp: max|diff| {np.abs(SH-SW).max():.3e}")
        print(f"   <M#,M>  Hamilton {pair_H:+.10f}   Wilking {pair_W:+.10f}   file-formula {lit:+.10f}")
        print(f"   p3(mu)={p3mu:+.8f}  theta={p3mu+pair_H:+.8f}")
        print(f"   Lambda^4 defect  M:{bM/nM:.2e}  M^2:{bM2/nM2:.3f}  M#:{bS/nS:.3f}  Q=M^2+M#:{bQ/nQ:.2e}")
        # bi-spectral cross-check
        Ow = secondkind(W, n)
        s = np.linalg.norm(to_operator(W, pairs))
        Ow = Ow / s; Mn = to_operator(W, pairs) / s
        p3w = np.trace(Ow @ Ow @ Ow)
        print(f"   bi-spectral: 1/2(p3(mu)-p3(omega)) = {0.5*(np.trace(Mn@Mn@Mn)-p3w):+.10f}"
              f"   tr(Ow^2)={np.trace(Ow@Ow):.6f}")
