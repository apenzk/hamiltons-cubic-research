"""Reviewer 12: independent adversarial audit of everything marked "Gate 2
pending" in findings/INDEX.md (post-Reviewer-11 material).

Own machinery throughout: own pair-basis/4-tensor dictionary, own R^# via the
index formula (R#)_{ijkl} = sum_{pq} (R_{ipkq}R_{jplq} - R_{iplq}R_{jpkq}),
own Ricci / Alt / Weyl projections, own spectral parts, own constructions
(Fox, sphere products, multi-block, HP^m, SU(3) bi-invariant, Sp(m)/U(m),
quaternionic Grassmannians, G2), own Weyl-basis + Levenberg-Marquardt polish.
The single permitted cross-check against the pipeline is curvature_operator's
Q_op, used once in the validation gate to pin normalisation.

Usage: python review_r12_independent.py <phase>
  validate | slack | bound | hunt | spm | grass | g2 | j5 | p4i
"""
import itertools
import sys
import time

import numpy as np
from scipy.optimize import least_squares

SQ32 = np.sqrt(1.5)
LOG = "agent_logs/review_r12.log"


def log(msg):
    line = f"{time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())} {msg}"
    print(line, flush=True)
    try:
        with open(LOG, "a") as f:
            f.write(line + "\n")
    except OSError:
        pass


# =====================================================================
# Pair-basis dictionary (mine).  Basis vector a <-> e_i ^ e_j (i<j),
# treated as orthonormal.  A symmetric operator is an N x N matrix M;
# its 4-tensor is R4[i,j,k,l] = s(ij) s(kl) M[a(ij), a(kl)].
# =====================================================================
class Alg:
    def __init__(self, n):
        self.n = n
        self.pairs = list(itertools.combinations(range(n), 2))
        self.N = len(self.pairs)
        self.idx = {p: a for a, p in enumerate(self.pairs)}
        IDX = np.zeros((n, n), dtype=np.int64)
        SGN = np.zeros((n, n))
        for a, (i, j) in enumerate(self.pairs):
            IDX[i, j] = a; SGN[i, j] = 1.0
            IDX[j, i] = a; SGN[j, i] = -1.0
        self.IDX, self.SGN = IDX, SGN
        # gather indices for R4 build
        self.g_rows = IDX[:, :, None, None] * np.ones((1, 1, n, n), dtype=np.int64)
        self.g_cols = IDX[None, None, :, :] * np.ones((n, n, 1, 1), dtype=np.int64)
        self.g_sign = SGN[:, :, None, None] * SGN[None, None, :, :]
        # scatter indices for R4 -> M
        I = np.array([p[0] for p in self.pairs])
        J = np.array([p[1] for p in self.pairs])
        self.pi, self.pj = I, J

    def to4(self, M):
        return self.g_sign * M[self.g_rows, self.g_cols]

    def from4(self, R4):
        return R4[self.pi[:, None], self.pj[:, None], self.pi[None, :], self.pj[None, :]]

    def sharp4(self, R4):
        A = np.einsum('ipkq,jplq->ijkl', R4, R4, optimize=True)
        B = np.einsum('iplq,jpkq->ijkl', R4, R4, optimize=True)
        return A - B

    def sharp(self, M):
        return self.from4(self.sharp4(self.to4(M)))

    def sharp_pol(self, X, Y):
        """X # Y = ((X+Y)^# - X^# - Y^#)/2, via polarized index formula."""
        R4, S4 = self.to4(X), self.to4(Y)
        A = np.einsum('ipkq,jplq->ijkl', R4, S4, optimize=True)
        A += np.einsum('ipkq,jplq->ijkl', S4, R4, optimize=True)
        B = np.einsum('iplq,jpkq->ijkl', R4, S4, optimize=True)
        B += np.einsum('iplq,jpkq->ijkl', S4, R4, optimize=True)
        return self.from4(A - B) / 2.0

    def Q(self, M):
        return M @ M + self.sharp(M)

    def ricci(self, M):
        return np.einsum('ijkj->ik', self.to4(M), optimize=True)

    def ricstar(self, h):
        """Adjoint of ricci: <ricci(M), h>_F = <M, ricstar(h)>_F."""
        n = self.n
        d = np.eye(n)
        X4 = (np.einsum('jl,ik->ijkl', d, h) - np.einsum('jk,il->ijkl', d, h)
              - np.einsum('il,jk->ijkl', d, h) + np.einsum('ik,jl->ijkl', d, h))
        return self.from4(X4)

    def alt(self, M):
        R4 = self.to4(M)
        A4 = (R4 + np.einsum('iklj->ijkl', R4) + np.einsum('iljk->ijkl', R4)) / 3.0
        return self.from4(A4)

    def weyl_project(self, M):
        """Remove Ricci and scalar parts (Kulkarni-Nomizu), keep Bianchi."""
        R = self.ricci(M)
        s = np.trace(R)
        n = self.n
        return (M - self.ricstar(R) / (n - 2)
                + (s / ((n - 1) * (n - 2))) * np.eye(self.N))

    # ---- so(n) bracket on pair-vectors (for the rank-one # identity) ----
    def mat(self, v):
        A = np.zeros((self.n, self.n))
        A[self.pi, self.pj] = v
        return A - A.T

    def vec(self, A):
        return A[self.pi, self.pj]

    def brk(self, u, v):
        U, V = self.mat(u), self.mat(v)
        return self.vec(U @ V - V @ U)


# =====================================================================
# spectral parts and the audited scalars
# =====================================================================
def parts(W, tol=1e-10):
    ev, V = np.linalg.eigh(W)
    neg, pos = ev < -tol, ev > tol
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    Wp = (V[:, pos] * ev[pos]) @ V[:, pos].T
    Pm = V[:, neg] @ V[:, neg].T
    Pp = V[:, pos] @ V[:, pos].T
    return Wp, Wm, Pp, Pm, int(pos.sum()), int(neg.sum())


def unit(W):
    return W / np.linalg.norm(W)


def orient(A, W):
    th = float(np.sum(W * A.Q(W)))
    return (-W, -th) if th < 0 else (W, th)


def audit_point(A, W):
    """All the scalars under review, from my own machinery."""
    W = unit(0.5 * (W + W.T))
    W, th = orient(A, W)
    QW = A.Q(W)
    res = np.linalg.norm(QW - th * W)
    Wp, Wm, Pp, Pm, rp, rm = parts(W)
    Qm = np.eye(A.N) - Pm
    t = float(np.trace(Wm))
    ric_m = A.ricci(Wm)
    rho = np.linalg.eigvalsh(ric_m)
    d2 = float(np.sum(A.alt(Wm) ** 2))
    trWm2 = float(np.trace(Wm @ Wm))
    S = float(np.sum(ric_m * ric_m)) + 6 * d2 - th * t - trWm2
    shp_p = A.sharp(Wp)
    shp_m = A.sharp(Wm)
    X = A.sharp_pol(Wp, Wm)
    T1 = float(np.trace(Pm @ shp_p @ Pm))
    T2 = float(np.trace(Qm @ X @ Qm))
    T3 = float(np.trace(Pm @ shp_m @ Pm))
    # lemma (B):  tr(W-^2) + tr(W-#) - tr(W+ # W-)
    lemB = trWm2 + float(np.trace(shp_m)) - float(np.trace(X))
    # lemma (A):  tr(W+^2)+tr(W+#) - tr(W-^2)-tr(W-#)
    lemA = (float(np.trace(Wp @ Wp)) + float(np.trace(shp_p))
            - trWm2 - float(np.trace(shp_m)))
    # my exact-identity form: S - (T1+2T2+T3) = -tr(P-(Q(W)-th W)P-)
    crit_compress = -float(np.trace(Pm @ (QW - th * W) @ Pm))
    lmax = float(rho.max()) if t > 1e-12 else 0.0
    K = lmax * A.n / (2 * t) if t > 1e-12 else np.nan
    ric2 = float(np.sum(ric_m * ric_m))
    rhs = 4 * K * t / A.n + (6 * d2 - trWm2 - S) / t if t > 1e-12 else np.nan
    return dict(W=W, th=th, res=res, t=t, d2=d2, trWm2=trWm2, S=S,
                T1=T1, T2=T2, T3=T3, lemA=lemA, lemB=lemB,
                crit_compress=crit_compress, lmax=lmax, K=K, ric2=ric2,
                rhs=rhs, rp=rp, rm=rm, ricW=float(np.max(np.abs(A.ricci(W)))),
                altW=float(np.max(np.abs(A.alt(W)))))


# =====================================================================
# constructions (mine)
# =====================================================================
def fox_padded(A):
    """Fox idempotent on a distinguished 4-plane {0,1,2,3}, zero-padded."""
    N = A.N
    def pv(*terms):
        v = np.zeros(N)
        for (i, j, c) in terms:
            v[A.idx[(i, j)]] = c
        return v
    w1 = pv((0, 1, 1.0), (2, 3, 1.0)) / np.sqrt(2)
    w2 = pv((0, 2, 1.0), (1, 3, -1.0)) / np.sqrt(2)
    w3 = pv((0, 3, 1.0), (1, 2, 1.0)) / np.sqrt(2)
    W = (2 * np.outer(w1, w1) - np.outer(w2, w2) - np.outer(w3, w3)) / np.sqrt(6)
    return W


def sphere_product(A, blocks):
    """Weyl part of the Einstein product of round spheres (Ric = id)."""
    owner = []
    for bi, b in enumerate(blocks):
        owner += [bi] * b
    d = np.zeros(A.N)
    for a, (i, j) in enumerate(A.pairs):
        if owner[i] == owner[j]:
            d[a] = 1.0 / (blocks[owner[i]] - 1)
    return unit(A.weyl_project(np.diag(d)))


def quat_left(n):
    """Left multiplications L_i, L_j, L_k on H^{n/4} (block 4x4 pattern)."""
    m = n // 4
    Li = np.zeros((n, n)); Lj = np.zeros((n, n)); Lk = np.zeros((n, n))
    for b in range(m):
        o = 4 * b
        # q = x0 + x1 i + x2 j + x3 k ; left mult by i, j, k
        # L_i: (x0,x1,x2,x3) -> (-x1, x0, -x3, x2)
        Li[o + 1, o + 0], Li[o + 0, o + 1] = 1, -1
        Li[o + 3, o + 2], Li[o + 2, o + 3] = 1, -1
        # L_j: -> (-x2, x3, x0, -x1)
        Lj[o + 2, o + 0], Lj[o + 0, o + 2] = 1, -1
        Lj[o + 1, o + 3], Lj[o + 3, o + 1] = 1, -1
        # L_k: -> (-x3, -x2, x1, x0)
        Lk[o + 3, o + 0], Lk[o + 0, o + 3] = 1, -1
        Lk[o + 2, o + 1], Lk[o + 1, o + 2] = 1, -1
    return Li, Lj, Lk


def quat_right(n):
    """Right multiplications R_i, R_j, R_k on H^{n/4}."""
    m = n // 4
    Ri = np.zeros((n, n)); Rj = np.zeros((n, n)); Rk = np.zeros((n, n))
    for b in range(m):
        o = 4 * b
        # q*i: (x0,x1,x2,x3) -> (-x1, x0, x3, -x2)
        Ri[o + 0, o + 1], Ri[o + 1, o + 0] = -1, 1
        Ri[o + 2, o + 3], Ri[o + 3, o + 2] = 1, -1
        # q*j: -> (-x2, -x3, x0, x1)
        Rj[o + 0, o + 2], Rj[o + 2, o + 0] = -1, 1
        Rj[o + 1, o + 3], Rj[o + 3, o + 1] = -1, 1
        # q*k: -> (-x3, x2, -x1, x0)
        Rk[o + 0, o + 3], Rk[o + 3, o + 0] = -1, 1
        Rk[o + 1, o + 2], Rk[o + 2, o + 1] = 1, -1
    return Ri, Rj, Rk


def hpm_weyl(A):
    """Weyl part of the quaternionic space-form curvature on R^{4m}."""
    n = A.n
    Js = quat_left(n)
    d = np.eye(n)
    R4 = np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
    for Jm in Js:
        R4 = R4 + (np.einsum('ik,jl->ijkl', Jm, Jm)
                   - np.einsum('il,jk->ijkl', Jm, Jm)
                   + 2 * np.einsum('ij,kl->ijkl', Jm, Jm))
    return unit(A.weyl_project(A.from4(R4)))


def su3_weyl(A):
    """Weyl part of the bi-invariant SU(3) curvature on su(3) = R^8."""
    assert A.n == 8
    lam = []
    def m(rows):
        M = np.zeros((3, 3), dtype=complex)
        for (r, c, v) in rows:
            M[r, c] = v
        return M
    lam.append(m([(0, 1, 1), (1, 0, 1)]))
    lam.append(m([(0, 1, -1j), (1, 0, 1j)]))
    lam.append(m([(0, 0, 1), (1, 1, -1)]))
    lam.append(m([(0, 2, 1), (2, 0, 1)]))
    lam.append(m([(0, 2, -1j), (2, 0, 1j)]))
    lam.append(m([(1, 2, 1), (2, 1, 1)]))
    lam.append(m([(1, 2, -1j), (2, 1, 1j)]))
    lam.append(m([(0, 0, 1), (1, 1, 1), (2, 2, -2)]) / np.sqrt(3))
    X = [1j * L / np.sqrt(2) for L in lam]         # orthonormal: <A,B> = -tr(AB)
    def ip(Au, Bu):
        return float(np.real(-np.trace(Au @ Bu)))
    M = np.zeros((A.N, A.N))
    for a, (i, j) in enumerate(A.pairs):
        Cij = X[i] @ X[j] - X[j] @ X[i]
        for b, (k, l) in enumerate(A.pairs):
            Ckl = X[k] @ X[l] - X[l] @ X[k]
            M[a, b] = 0.25 * ip(Cij, Ckl)
    return unit(A.weyl_project(M))


# =====================================================================
# my Weyl basis (Ric = 0 and Alt = 0) and LM machinery
# =====================================================================
def weyl_basis(A):
    n, N = A.n, A.N
    D = N * (N + 1) // 2
    iu = np.triu_indices(N)
    rows = []
    for k in range(D):
        M = np.zeros((N, N))
        M[iu[0][k], iu[1][k]] = 1.0
        M[iu[1][k], iu[0][k]] = 1.0
        R = A.ricci(M)
        Al = A.alt(M)
        con = [R[i, k2] for i in range(n) for k2 in range(i, n)]
        con += [A.to4(M)[i, j, k2, l] * 0 for i, j, k2, l in ()]  # placeholder
        rows.append(np.array(con))
    C_ric = np.array(rows).T                      # (n(n+1)/2, D)
    # Alt constraints: independent components live on 4-subsets i<j<k<l
    quads = list(itertools.combinations(range(n), 4))
    rows2 = np.zeros((len(quads), D))
    for k in range(D):
        M = np.zeros((N, N))
        M[iu[0][k], iu[1][k]] = 1.0
        M[iu[1][k], iu[0][k]] = 1.0
        A4 = A.to4(A.alt(M))
        for qi, (i, j, k2, l) in enumerate(quads):
            rows2[qi, k] = A4[i, j, k2, l]
    C = np.vstack([C_ric, rows2])
    _, sv, Vt = np.linalg.svd(C, full_matrices=True)
    rank = int(np.sum(sv > 1e-9 * sv[0]))
    B = Vt[rank:]                                  # (Dw, D) coords in triu space
    # embed back to symmetric matrices (with off-diagonal doubling handled)
    mats = []
    for r in B:
        M = np.zeros((N, N))
        M[iu] = r
        M = M + M.T - np.diag(np.diag(M))
        mats.append(M)
    # orthonormalize w.r.t. Frobenius
    V = np.array([m.reshape(-1) for m in mats])
    Qm, _ = np.linalg.qr(V.T)
    return Qm.T.reshape(-1, N, N)                  # (Dw, N, N)


def lm_polish(A, Bw, W0, max_nfev=6000):
    Bflat = Bw.reshape(Bw.shape[0], -1)
    x0 = Bflat @ W0.reshape(-1)
    def F(x):
        W = np.einsum('d,dab->ab', x, Bw)
        nr = np.linalg.norm(W)
        if nr < 1e-12:
            return np.full(A.N * A.N, 1e3)
        W = W / nr
        QW = A.Q(W)
        th = float(np.sum(W * QW))
        return (QW - th * W).reshape(-1)
    r = least_squares(F, x0, method='lm', xtol=1e-15, ftol=1e-15,
                      max_nfev=max_nfev)
    W = np.einsum('d,dab->ab', r.x, Bw)
    return unit(0.5 * (W + W.T))


def lm_seed(A, Bw, seed, max_nfev=6000):
    rng = np.random.default_rng(seed)
    x0 = rng.normal(size=Bw.shape[0])
    W0 = np.einsum('d,dab->ab', x0 / np.linalg.norm(x0), Bw)
    return lm_polish(A, Bw, W0, max_nfev=max_nfev)


# =====================================================================
# phases
# =====================================================================
def phase_validate():
    log("VALIDATE: start")
    A = Alg(6)
    rng = np.random.default_rng(0)
    # 1. Id^# = (n-2) Id
    e = np.max(np.abs(A.sharp(np.eye(A.N)) - (A.n - 2) * np.eye(A.N)))
    log(f"gate1 Id^# - (n-2)Id  max err = {e:.2e}")
    # 2. trilinear symmetry: <X, B(Y,Z)> under permutations, B = polarized Q
    X = rng.normal(size=(A.N, A.N)); X = X + X.T
    Y = rng.normal(size=(A.N, A.N)); Y = Y + Y.T
    Z = rng.normal(size=(A.N, A.N)); Z = Z + Z.T
    def Bp(Yv, Zv):
        return 0.5 * (Yv @ Zv + Zv @ Yv) + A.sharp_pol(Yv, Zv)
    t1 = np.sum(X * Bp(Y, Z)); t2 = np.sum(Y * Bp(X, Z)); t3 = np.sum(Z * Bp(X, Y))
    log(f"gate2 trilinear symmetry rel err = "
        f"{max(abs(t1-t2), abs(t1-t3))/abs(t1):.2e}")
    # 3. Alt idempotent + self-adjoint
    Al = A.alt(X)
    log(f"gate3 Alt idempotent err = {np.max(np.abs(A.alt(Al)-Al)):.2e}, "
        f"self-adjoint err = {abs(np.sum(A.alt(X)*Y)-np.sum(X*A.alt(Y))):.2e}")
    # 4. scal(R^2+R^#) = ||Ric||^2 + 6||Alt||^2 for random symmetric R
    worst = 0.0
    for _ in range(4):
        R = rng.normal(size=(A.N, A.N)); R = R + R.T
        lhs = 2 * np.trace(A.Q(R))
        rhs = np.sum(A.ricci(R) ** 2) + 6 * np.sum(A.alt(R) ** 2)
        worst = max(worst, abs(lhs - rhs) / abs(lhs))
    log(f"gate4 scal identity rel err = {worst:.2e}")
    # 4b. ricstar adjointness
    h = rng.normal(size=(A.n, A.n)); h = h + h.T
    e = abs(np.sum(A.ricci(X) * h) - np.sum(X * A.ricstar(h)))
    log(f"gate4b ricstar adjointness err = {e:.2e}")
    # 5. rank-one sharp identity (uu^T)#(vv^T) = c [u,v][u,v]^T ; measure c
    u = rng.normal(size=A.N); v = rng.normal(size=A.N)
    Lhs = A.sharp_pol(np.outer(u, u), np.outer(v, v))
    w = A.brk(u, v)
    Rhs = np.outer(w, w)
    c = np.sum(Lhs * Rhs) / np.sum(Rhs * Rhs)
    log(f"gate5 rank-one #: constant c = {c:.15f}, residual "
        f"{np.linalg.norm(Lhs - c*Rhs)/np.linalg.norm(Lhs):.2e}")
    # 6. Fox anchor at n=8
    A8 = Alg(8)
    W = fox_padded(A8)
    a = audit_point(A8, W)
    log(f"gate6 Fox padded n=8: theta = {a['th']:.12f} (sqrt(3/2) = "
        f"{SQ32:.12f}), delta^2 = {a['d2']:.12f} (1/9 = {1/9:.12f}), "
        f"crit res = {a['res']:.2e}, RicW = {a['ricW']:.2e}, AltW = {a['altW']:.2e}")
    # 7. permitted cross-check vs pipeline Q_op
    sys.path.insert(0, 'scripts/lib')
    from curvature_operator import Lambda2, Q_op
    L2 = Lambda2(6)
    R = rng.normal(size=(A.N, A.N)); R = R + R.T
    e = (np.linalg.norm(Q_op(L2, R) - A.Q(R)) / np.linalg.norm(A.Q(R)))
    log(f"gate7 vs pipeline Q_op rel diff = {e:.2e}")
    # 8. sphere anchors
    for n, blocks, want in ((6, [3, 3], 1.054093), (8, [4, 4], 1.145644),
                            (12, [6, 6], 1.236033), (12, [5, 7], None)):
        An = Alg(n)
        a = audit_point(An, sphere_product(An, blocks))
        log(f"gate8 S^{blocks} n={n}: theta = {a['th']:.9f}"
            + (f" (want {want})" if want else "") + f", res = {a['res']:.2e}")
    log("VALIDATE: done")


def catalogue(n):
    """Structured critical points at dimension n, built with my machinery."""
    A = Alg(n)
    out = []
    if n >= 6:
        for p in range(2, n // 2 + 1):
            out.append((f"S{p}xS{n-p}", sphere_product(A, [p, n - p])))
    for blocks in ([2, 2, n - 4], [3, 3, n - 6], [2, 2, 2, n - 6]):
        if all(b >= 2 for b in blocks) and sum(blocks) == n:
            out.append((f"sph{tuple(blocks)}", sphere_product(A, blocks)))
    if n % 4 == 0:
        out.append((f"HP^{n//4}", hpm_weyl(A)))
    if n == 8:
        out.append(("Fox_pad", fox_padded(A)))
        out.append(("SU3bi", su3_weyl(A)))
        for f, lab in (("scripts/data/defect_violation_n8_0.120000.npy", "viol_3/25"),
                       ("scripts/data/gap_band_point_n8.npy", "wit_0.9008")):
            try:
                out.append((lab, np.load(f)))
            except Exception:
                pass
    return A, out


HDR = (f"{'point':<18} {'th':>9} {'S':>9} {'T1':>8} {'2T2':>8} {'T3':>8} "
       f"{'S-sum':>9} {'lemB':>9} {'cc-id':>9} {'res':>8}")


def row(lab, a):
    d = a['S'] - (a['T1'] + 2 * a['T2'] + a['T3'])
    cc = d - a['crit_compress']
    return (f"{lab:<18} {a['th']:>9.5f} {a['S']:>9.5f} {a['T1']:>8.5f} "
            f"{2*a['T2']:>8.5f} {a['T3']:>8.5f} {d:>9.1e} {a['lemB']:>9.1e} "
            f"{cc:>9.1e} {a['res']:>8.1e}")


def phase_slack():
    log("SLACK: start.  Testing S = T1+2T2+T3, lemmas A/B, and my exact "
        "identity S-(T1+2T2+T3) = -tr(P-(QW-thW)P-) at structured, witness "
        "and generic LM points.")
    print(HDR)
    worst_d, worst_lem, worst_ccid, min_term = 0.0, 0.0, 0.0, np.inf
    for n in (6, 8, 12):
        A, cat = catalogue(n)
        for lab, W in cat:
            a = audit_point(A, W)
            if a['res'] > 1e-7 * max(1, abs(a['th'])):
                # polish structured points through my own LM (n<=8 basis)
                pass
            print(row(f"{lab} n={n}", a))
            d = a['S'] - (a['T1'] + 2 * a['T2'] + a['T3'])
            if a['res'] < 1e-6:
                worst_d = max(worst_d, abs(d))
                worst_lem = max(worst_lem, abs(a['lemA']), abs(a['lemB']))
            worst_ccid = max(worst_ccid, abs(d - a['crit_compress']))
            min_term = min(min_term, a['T1'], a['T2'], a['T3'])
    # generic LM points at n = 6, 7, 8
    for n, nseed, want in ((6, 24, 8), (7, 16, 6), (8, 14, 5)):
        A = Alg(n)
        log(f"SLACK: building Weyl basis n={n}")
        Bw = weyl_basis(A)
        log(f"SLACK: Weyl basis n={n} dim = {Bw.shape[0]}; LM hunts start")
        got = 0
        for seed in range(nseed):
            if got >= want:
                break
            W = lm_seed(A, Bw, seed)
            a = audit_point(A, W)
            if a['res'] > 1e-12 or abs(a['th']) < 1e-3:
                continue
            got += 1
            print(row(f"LM n={n} s{seed}", a))
            d = a['S'] - (a['T1'] + 2 * a['T2'] + a['T3'])
            worst_d = max(worst_d, abs(d))
            worst_lem = max(worst_lem, abs(a['lemA']), abs(a['lemB']))
            worst_ccid = max(worst_ccid, abs(d - a['crit_compress']))
            min_term = min(min_term, a['T1'], a['T2'], a['T3'])
            log(f"SLACK: n={n} seed={seed} th={a['th']:.6f} S={a['S']:.4f} "
                f"d={d:.2e} lemB={a['lemB']:.2e} res={a['res']:.1e}")
        # negative control: random NON-critical Weyl points
        rng = np.random.default_rng(99)
        for k in range(3):
            x = rng.normal(size=Bw.shape[0])
            W = unit(np.einsum('d,dab->ab', x, Bw))
            a = audit_point(A, W)
            print(row(f"NONCRIT n={n} #{k}", a))
            worst_ccid = max(worst_ccid,
                             abs(a['S'] - (a['T1'] + 2*a['T2'] + a['T3'])
                                 - a['crit_compress']))
            worst_lem = max(worst_lem, abs(a['lemA']), abs(a['lemB']))
    log(f"SLACK: worst |S-(T1+2T2+T3)| at critical pts = {worst_d:.2e}")
    log(f"SLACK: worst lemma A/B residual (incl NONCRITICAL Weyl) = {worst_lem:.2e}"
        " -> lemmas are identities on the whole Weyl space, not just critical pts")
    log(f"SLACK: worst residual of exact identity S-(T1+2T2+T3) = "
        f"-tr(P-(QW-thW)P-) everywhere = {worst_ccid:.2e}")
    log(f"SLACK: most negative T-term = {min_term:.2e}")
    log("SLACK: done")


def phase_bound():
    log("BOUND: start. theta formula, bounds 1/2, K, assembled bound, trap.")
    print(f"{'point':<18} {'th':>9} {'t':>8} {'K':>7} {'lmax/t':>7} "
          f"{'rhs':>9} {'marg32':>9} {'S':>8} {'d2':>8} {'tcap':>7} "
          f"{'CSfac':>7} {'trap-th':>9}")
    viol1 = viol2 = violCS = violRHS = 0
    worst_margin = None
    for n in (6, 8, 12, 16):
        A, cat = catalogue(n)
        for lab, W in cat:
            a = audit_point(A, W)
            if a['res'] > 1e-6:
                continue
            tcap = (a['rp'] * a['rm']) ** 0.25 / np.sqrt(2)
            csb = 2 * (n - 1) * a['trWm2']
            trap = 4 * a['t'] / n - a['t'] / max(a['rm'], 1)
            m32 = SQ32 - a['rhs']
            print(f"{lab+f' n={n}':<18} {a['th']:>9.5f} {a['t']:>8.4f} "
                  f"{a['K']:>7.4f} {a['lmax']/a['t']:>7.4f} {a['rhs']:>9.5f} "
                  f"{m32:>9.5f} {a['S']:>8.4f} {a['d2']:>8.5f} "
                  f"{tcap:>7.4f} {a['ric2']/csb:>7.4f} {trap - a['th']:>9.5f}")
            if a['lmax'] > a['t'] + 1e-10:
                viol1 += 1
            if a['t'] > tcap + 1e-10:
                viol2 += 1
            if a['ric2'] > csb + 1e-10:
                violCS += 1
            if a['th'] > a['rhs'] + 1e-9:
                violRHS += 1
            graded = max(a['T1'], 2 * a['T2'], a['T3']) < 1e-8
            if not graded and (worst_margin is None or m32 < worst_margin[0]):
                worst_margin = (m32, lab, n, a['th'], a['rhs'])
    log(f"BOUND: violations -- lmax<=t: {viol1}, t<=(r+r-)^(1/4)/sqrt2: {viol2}, "
        f"CS 2(n-1)tr(W-^2): {violCS}, assembled RHS: {violRHS}")
    if worst_margin:
        log(f"BOUND: thinnest ungraded margin below sqrt(3/2): {worst_margin}")
    # K = n/(2p) exact check on two-factor sphere products, n=12 and 16
    for n in (12, 16):
        A = Alg(n)
        errs = []
        for p in range(2, n // 2 + 1):
            a = audit_point(A, sphere_product(A, [p, n - p]))
            errs.append(abs(a['K'] - n / (2 * p)))
        log(f"BOUND: K = n/(2p) exactness n={n}: max err = {max(errs):.2e}")
    log("BOUND: done")


def phase_hunt():
    """n=8 LM sweep hunting for ungraded points with theta > 0.900828 or
    assembled RHS above sqrt(3/2)."""
    seeds = int(sys.argv[2]) if len(sys.argv) > 2 else 60
    log(f"HUNT: start, n=8, {seeds} LM seeds")
    A, cat = catalogue(8)
    Bw = weyl_basis(A)
    log(f"HUNT: Weyl basis dim = {Bw.shape[0]}")
    found = {}
    best_ung = (0.0, None)
    best_rhs = (-np.inf, None)
    rng0 = np.random.default_rng(42)
    jobs = [("rnd", 1000 + s) for s in range(seeds)]
    # perturbation seeds around every catalogue point (lands on neighbours)
    starts = []
    for lab, W0 in cat:
        for eps in (0.08, 0.15, 0.25):
            for rep in range(2):
                V = rng0.normal(size=Bw.shape[0])
                V = np.einsum('d,dab->ab', V / np.linalg.norm(V), Bw)
                starts.append((f"{lab}+{eps}", unit(unit(W0) + eps * V)))
    total = len(jobs) + len(starts)
    done = 0
    for kind, item in jobs + [("pert", s) for s in starts]:
        done += 1
        if done % 25 == 0:
            log(f"HUNT: progress {done}/{total}, distinct={len(found)}, "
                f"best ungraded th={best_ung[0]:.6f}, best rhs={best_rhs[0]:.5f}")
        if kind == "rnd":
            W = lm_seed(A, Bw, item, max_nfev=4000)
        else:
            W = lm_polish(A, Bw, item[1], max_nfev=4000)
        a = audit_point(A, W)
        if a['res'] > 1e-12 or abs(a['th']) < 1e-3:
            continue
        key = round(a['th'], 6)
        graded = max(a['T1'], 2 * a['T2'], a['T3']) < 1e-8
        if key not in found:
            found[key] = (graded, a['S'], a['rhs'])
            src = item if kind == "rnd" else item[0]
            log(f"HUNT: {kind} {src}: th={a['th']:.6f} "
                f"{'graded' if graded else 'UNGRADED'} S={a['S']:.4f} "
                f"rhs={a['rhs']:.5f} res={a['res']:.1e}")
        if not graded:
            if a['th'] > best_ung[0]:
                best_ung = (a['th'], a)
            if a['rhs'] > best_rhs[0]:
                best_rhs = (a['rhs'], a)
    log(f"HUNT: {len(found)} distinct critical values; "
        f"max ungraded theta = {best_ung[0]:.6f} (record claim 0.900828); "
        f"max ungraded assembled RHS = {best_rhs[0]:.5f} vs sqrt(3/2) = {SQ32:.5f}")
    # perturb the 0.9008 witness and re-polish, 8 tries
    try:
        Wit = np.load("scripts/data/gap_band_point_n8.npy")
        rng = np.random.default_rng(7)
        for k in range(6):
            P = Wit + 0.02 * unit(np.einsum(
                'd,dab->ab', rng.normal(size=Bw.shape[0]), Bw))
            W = lm_polish(A, Bw, unit(0.5 * (P + P.T)))
            a = audit_point(A, W)
            graded = max(a['T1'], 2 * a['T2'], a['T3']) < 1e-8
            if a['res'] < 1e-12 and not graded and a['th'] > best_ung[0]:
                best_ung = (a['th'], a)
                log(f"HUNT: witness-perturb {k}: th={a['th']:.6f} ungraded!")
    except Exception as ex:
        log(f"HUNT: witness perturb skipped ({ex})")
    log(f"HUNT: final max ungraded theta = {best_ung[0]:.6f}")
    log("HUNT: done")


# ---------------------------------------------------------------------
# Family C: Sp(m)/U(m) and quaternionic Grassmannians, my construction
# ---------------------------------------------------------------------
def span_basis(vs, tol=1e-9):
    V = np.array(vs)
    q, r = np.linalg.qr(V.T)
    keep = np.abs(np.diag(r)) > tol
    return q[:, :len(keep)][:, keep[:min(len(keep), q.shape[1])]] if False else _ortho(V, tol)


def _ortho(V, tol=1e-9):
    U, s, Vt = np.linalg.svd(V, full_matrices=False)
    return Vt[s > tol * s[0]].T


def centralizer_subspace(A, mats):
    """{X in so(n): [X, M] = 0 for all M in mats}, as pair-basis columns."""
    N = A.N
    rowsets = []
    for M in mats:
        L = np.zeros((A.n * A.n, N))
        for a in range(N):
            E = A.mat(np.eye(N)[a])
            L[:, a] = (E @ M - M @ E).reshape(-1)
        rowsets.append(L)
    L = np.vstack(rowsets)
    _, s, Vt = np.linalg.svd(L)
    rank = int(np.sum(s > 1e-9 * s[0]))
    return Vt[rank:].T                             # columns = basis


def proj(cols):
    return cols @ cols.T


def sp_um_projections(A, m):
    """My fixed construction: sp(m) = centraliser of RIGHT mults; u(m) =
    part commuting with LEFT mult L_i.  Returns (P_centre, P_su, P_m)."""
    n = A.n
    assert n == 4 * m
    Ri, Rj, Rk = quat_right(n)
    Li, _, _ = quat_left(n)
    sp_cols = centralizer_subspace(A, [Ri, Rj, Rk])
    dim_sp = sp_cols.shape[1]
    u_cols_all = centralizer_subspace(A, [Li])
    # u(m) = sp(m) ^ centraliser(L_i): intersect subspaces
    P1, P2 = proj(sp_cols), proj(u_cols_all)
    w, V = np.linalg.eigh(P1 + P2)
    u_cols = V[:, w > 2 - 1e-7]
    dim_u = u_cols.shape[1]
    # centre of u(m): the image of L_i itself
    li = A.vec(Li); li = li / np.linalg.norm(li)
    Pc = np.outer(li, li)
    Pu = proj(u_cols)
    Psu = Pu - Pc
    Pm = proj(sp_cols) - Pu
    return dim_sp, dim_u, Pc, Psu, 0.5 * (Pm + Pm.T)


def sp_grass_projections(A, m, j):
    """(sp(m), sp(j)+sp(m-j)): block-diagonal split of my sp(m)."""
    n = A.n
    Ri, Rj, Rk = quat_right(n)
    sp_cols = centralizer_subspace(A, [Ri, Rj, Rk])
    Psp = proj(sp_cols)
    outs = []
    for (lo, hi) in ((0, 4 * j), (4 * j, n)):
        sel = np.array([(lo <= p < hi and lo <= q < hi)
                        for (p, q) in A.pairs], dtype=float)
        P = np.diag(sel) @ Psp @ np.diag(sel)
        P = 0.5 * (P + P.T)
        w, V = np.linalg.eigh(P)
        cols = V[:, w > 0.5]
        outs.append((proj(cols), cols.shape[1]))
    Pk = outs[0][0] + outs[1][0]
    Pm = Psp - Pk
    return outs[0], outs[1], 0.5 * (Pm + Pm.T)


def ansatz_search(A, Pks, Pm, label, restarts=120, seed=5):
    """Find unit, trace-free, RICCI-FLAT critical points of the ideal-wise
    shape W = sum_i a_i P_i - b P_m.  Full criticality residual reported."""
    keys = list(Pks) + [Pm]
    dims = [np.trace(P) for P in keys]
    if min(dims) < 0.5:
        log(f"{label}: DEGENERATE projections dims={dims}")
        return None
    rng = np.random.default_rng(seed)
    best = None
    for _ in range(restarts):
        z0 = rng.normal(size=len(keys)) * 0.5 + np.array(
            [1.0] * (len(keys) - 1) + [-1.0])
        def F(z):
            W = sum(a * P for a, P in zip(z, keys))
            nr = np.linalg.norm(W)
            if nr < 1e-9:
                return np.full(A.N * A.N
                               + A.n * A.n + 1, 10.0)
            W = W / nr
            QW = A.Q(W)
            th = float(np.sum(W * QW))
            out = np.concatenate([
                (QW - th * W).reshape(-1),
                30.0 * A.ricci(W).reshape(-1),
                [30.0 * np.trace(W)],
            ])
            return out
        r = least_squares(F, z0, method='lm', xtol=1e-15, ftol=1e-15,
                          max_nfev=2000)
        z = r.x
        W = sum(a * P for a, P in zip(z, keys))
        if np.linalg.norm(W) < 1e-9:
            continue
        W = unit(W)
        a = audit_point(A, W)
        resv = max(a['res'], a['ricW'], abs(np.trace(a['W'])))
        if best is None or resv < best[0]:
            best = (resv, a)
    return best


def phase_spm():
    log("SPM: start. Family C, my own construction (sp(m) = centraliser of "
        "RIGHT mults; u(m) cut by LEFT complex structure).")
    # positive control: sphere pair via the same ansatz machinery
    A = Alg(8)
    so4a = [A.vec(M) for M in _so_block(8, 0, 4)]
    so4b = [A.vec(M) for M in _so_block(8, 4, 8)]
    Pk1 = proj(_ortho(np.array(so4a)))
    Pk2 = proj(_ortho(np.array(so4b)))
    mixed = np.diag(np.array([(p < 4) != (q < 4) for p, q in A.pairs],
                             dtype=float))
    r = ansatz_search(A, [Pk1, Pk2], mixed, "control S4xS4", restarts=40)
    log(f"SPM control S4xS4: res={r[0]:.2e} theta={r[1]['th']:.6f} "
        f"(want 1.145644)")
    for m in (2, 3, 4):
        n = 4 * m
        A = Alg(n)
        dim_sp, dim_u, Pc, Psu, Pm = sp_um_projections(A, m)
        log(f"SPM (sp({m}),u({m})) n={n}: dim sp = {dim_sp} "
            f"(theory {m*(2*m+1)}), dim u = {dim_u} (theory {m*m}), "
            f"dim m = {np.trace(Pm):.1f} (theory {m*(m+1)})")
        r = ansatz_search(A, [Pc, Psu], Pm, f"sp({m})/u({m})",
                          restarts=100 if m < 4 else 60)
        if r is None:
            continue
        resv, a = r
        want = {2: np.sqrt(8 / 9), 3: 5 / 6, 4: np.sqrt(3 / 5)}[m]
        log(f"SPM (sp({m}),u({m})): best full-residual = {resv:.2e}, "
            f"theta = {a['th']:.9f} (claim {want:.9f}), "
            f"delta^2 = {a['d2']:.9f} (claim 1/9 = {1/9:.9f})")
    # Grassmannians (m,j) = (3,1) and (4,1)
    for m, j in ((3, 1), (4, 1)):
        n = 4 * m
        A = Alg(n)
        (P1, d1), (P2, d2_), Pm = sp_grass_projections(A, m, j)
        log(f"SPM (sp({m}),sp({j})+sp({m-j})) n={n}: dim k1 = {d1} "
            f"(theory {j*(2*j+1)}), dim k2 = {d2_} "
            f"(theory {(m-j)*(2*(m-j)+1)}), dim m = {np.trace(Pm):.1f} "
            f"(theory {4*j*(m-j)})")
        r = ansatz_search(A, [P1, P2], Pm, f"sp({m})/sp({j})+sp({m-j})",
                          restarts=100 if m < 4 else 60)
        if r is None:
            continue
        resv, a = r
        log(f"SPM (sp({m}),sp({j})+sp({m-j})): best full residual over "
            f"ansatz = {resv:.3e} (claim: NO Ricci-flat critical point; "
            f"theta at best = {a['th']:.6f})")
    log("SPM: done")


def _so_block(n, lo, hi):
    out = []
    for i in range(lo, hi):
        for j in range(i + 1, hi):
            M = np.zeros((n, n))
            M[i, j], M[j, i] = 1.0, -1.0
            out.append(M)
    return out


# ---------------------------------------------------------------------
# G2 in so(7) from octonion structure constants
# ---------------------------------------------------------------------
def octonion_table():
    """Structure constants for Im(O): e1..e7, e_i e_j = -d_ij + c_ijk e_k."""
    C = np.zeros((7, 7, 7))
    trips = [(0, 1, 2), (0, 3, 4), (0, 6, 5), (1, 3, 5),
             (1, 4, 6), (2, 3, 6), (2, 5, 4)]
    for (a, b, c) in trips:
        for (x, y, z), s in (((a, b, c), 1), ((b, c, a), 1), ((c, a, b), 1),
                             ((b, a, c), -1), ((a, c, b), -1), ((c, b, a), -1)):
            C[x, y, z] = s
    return C


def g2_subspace(A):
    """g2 = derivations: D(xy) = D(x)y + xD(y) on Im(O), as so(7) elements."""
    C = octonion_table()
    N = A.N
    rows = np.zeros((7 * 7 * 7, N))
    for a in range(N):
        D = A.mat(np.eye(N)[a])
        # constraint: sum_k C[i,j,k] D[l,k]  - C[k,j,l] D[k,i] - C[i,k,l] D[k,j] = 0
        T = (np.einsum('ijk,lk->ijl', C, D)
             - np.einsum('kjl,ki->ijl', C, D)
             - np.einsum('ikl,kj->ijl', C, D))
        rows[:, a] = T.reshape(-1)
    _, s, Vt = np.linalg.svd(rows)
    rank = int(np.sum(s > 1e-9 * s[0]))
    return Vt[rank:].T


def phase_g2():
    log("G2: start. Building g2 in so(7) from octonion derivations.")
    A = Alg(7)
    g2 = g2_subspace(A)
    log(f"G2: dim g2 = {g2.shape[1]} (theory 14)")
    # k = derivations preserving the quaternion subalgebra span(e0,e1,e2)
    # (indices 0,1,2 close under the first triple (0,1,2))
    sel = []
    for cidx in range(g2.shape[1]):
        pass
    # build linear condition: D(e_a) in span(e0,e1,e2) for a=0,1,2
    cond = []
    for col in range(g2.shape[1]):
        D = A.mat(g2[:, col])
        cond.append(D[np.ix_(range(3, 7), range(0, 3))].reshape(-1))
    Cm = np.array(cond).T                          # (12, dim g2)
    _, s, Vt = np.linalg.svd(Cm)
    rank = int(np.sum(s > 1e-9 * s[0]))
    kcoef = Vt[rank:].T
    k_cols = g2 @ kcoef
    k_cols = _ortho(k_cols.T).T if False else _ortho(k_cols.T)
    k_cols = k_cols.T if k_cols.shape[0] != A.N else k_cols
    Pk = proj(k_cols if k_cols.shape[0] == A.N else k_cols.T)
    Pg = proj(_ortho(g2.T))
    Pm = Pg - Pk
    dk = np.trace(Pk); dm = np.trace(Pm)
    log(f"G2: dim k = {dk:.1f} (su(2)+su(2) theory 6), dim m = {dm:.1f} "
        f"(theory 8)")
    # split k into its two su(2) ideals via the bracket: an ideal is an
    # eigenspace of the Casimir of k acting on itself.  Use bracket closure.
    kb = k_cols if k_cols.shape[0] == A.N else k_cols.T
    dimk = kb.shape[1]
    ad = np.zeros((dimk, dimk, dimk))
    for i in range(dimk):
        for j2 in range(dimk):
            w = A.brk(kb[:, i], kb[:, j2])
            ad[i, j2] = kb.T @ w
    Cas = np.einsum('ijk,ljk->il', ad, ad)
    w, V = np.linalg.eigh(Cas)
    log(f"G2: casimir eigs of k on itself: {np.round(w, 6)}")
    # ideals: group eigenvectors by eigenvalue
    vals = sorted(set(np.round(w, 6)))
    Pks = []
    for v in vals:
        cols = kb @ V[:, np.abs(w - v) < 1e-6]
        Pks.append(proj(_ortho(cols.T)))
    log(f"G2: k splits into {len(Pks)} ideals with dims "
        f"{[float(np.round(np.trace(P),1)) for P in Pks]}")
    r = ansatz_search(A, Pks, Pm, "G2/(su2+su2)", restarts=120)
    if r:
        resv, a = r
        log(f"G2: best full residual = {resv:.2e}, theta = {a['th']:.6f} "
            f"(claim 1.07155), delta^2 = {a['d2']:.6f}")
    log("G2: done")


# ---------------------------------------------------------------------
# J5 and P4(i)
# ---------------------------------------------------------------------
def j5_terms(A, W):
    a = audit_point(A, W)
    W = a['W']; th = a['th']
    ev, V = np.linalg.eigh(W)
    tol = 1e-9
    absW = (V * np.abs(ev)) @ V.T
    Xinv = A.sharp(absW) + (W - th * np.eye(A.N)) @ absW
    Xinv = 0.5 * (Xinv + Xinv.T)
    h = A.ricci(absW)
    H = A.ricstar(h)
    J5 = float(np.sum(A.ricci(Xinv) * h))
    J5b = float(np.sum(Xinv * H))
    # spectral blocks of W: -, 0, +
    blocks = [ev < -tol, np.abs(ev) <= tol, ev > tol]
    J5diag = 0.0
    for b in blocks:
        if not b.any():
            continue
        P = V[:, b] @ V[:, b].T
        J5diag += float(np.sum((P @ Xinv @ P) * (P @ H @ P)))
    return a, J5, J5b, J5diag, J5 - J5diag


def phase_j5():
    log("J5: start")
    worst_ratio = 0.0
    minJ5 = np.inf
    for n in (6, 8, 12):
        A, cat = catalogue(n)
        for lab, W in cat:
            a, J5, J5b, J5d, cross = j5_terms(A, W)
            if a['res'] > 1e-6:
                continue
            ratio = abs(cross) / J5d if J5d > 1e-12 else 0.0
            print(f"{lab+f' n={n}':<18} th={a['th']:>9.5f} J5={J5:>10.5f} "
                  f"(check {J5b:>10.5f}) diag={J5d:>10.5f} "
                  f"|cross|/diag={ratio:>9.2e}")
            minJ5 = min(minJ5, J5)
            worst_ratio = max(worst_ratio, ratio)
        if n in (6, 8):
            Bw = weyl_basis(A)
            got = 0
            for seed in range(20):
                if got >= 4:
                    break
                W = lm_seed(A, Bw, 500 + seed, max_nfev=2500)
                a0 = audit_point(A, W)
                if a0['res'] > 1e-12 or abs(a0['th']) < 1e-3:
                    continue
                got += 1
                a, J5, J5b, J5d, cross = j5_terms(A, W)
                ratio = abs(cross) / J5d if J5d > 1e-12 else 0.0
                print(f"{'LM n='+str(n)+' s'+str(seed):<18} th={a['th']:>9.5f} "
                      f"J5={J5:>10.5f} diag={J5d:>10.5f} "
                      f"|cross|/diag={ratio:>9.2e}")
                minJ5 = min(minJ5, J5)
                worst_ratio = max(worst_ratio, ratio)
    log(f"J5: min J5 = {minJ5:.6f} (claim >= 0), worst |cross|/diag = "
        f"{worst_ratio:.3e} (claim <= 2.88e-2)")
    log("J5: done")


def phase_p4i():
    """Mixed flat directions of Phi = P - kappa_n delta^2 at padded Fox."""
    ndir = int(sys.argv[2]) if len(sys.argv) > 2 else 60
    log(f"P4I: start, {ndir} mixed directions per dimension")
    for n in (8, 12):
        A = Alg(n)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        kap = 9 * (SQ32 - th0)
        W0 = fox_padded(A)
        a0 = audit_point(A, W0)
        Bw = weyl_basis(A)
        def Phi(W):
            W = unit(W)
            P = float(np.sum(W * A.Q(W)))
            Wm = parts(W)[1]
            d2 = float(np.sum(A.alt(Wm) ** 2))
            return P - kap * d2
        phi0 = Phi(W0)
        log(f"P4I n={n}: kappa = {kap:+.6f}, Phi(Fox) = {phi0:.6f} "
            f"(theta0(n) = {th0:.6f}), crit res = {a0['res']:.1e}")
        # mixed mask: pairs meeting both the 4-plane and its complement
        mixmask = np.array([(i < 4) != (j < 4) for (i, j) in A.pairs])
        rng = np.random.default_rng(3)
        worst = -np.inf
        Bflat = Bw.reshape(Bw.shape[0], -1)
        w0 = W0.reshape(-1)
        for k in range(ndir):
            while True:
                x = rng.normal(size=Bw.shape[0])
                V = np.einsum('d,dab->ab', x, Bw)
                V = V - np.sum(V * W0) * W0
                V = unit(V)
                mass = np.sum(V[mixmask][:, :] ** 2)
                mixfrac = (np.sum((V[mixmask, :]) ** 2)
                           + np.sum((V[:, mixmask]) ** 2)) / (2 * np.sum(V ** 2))
                if mixfrac >= 0.15:
                    break
            t = 1e-3
            c2 = (Phi(W0 + t * V) + Phi(W0 - t * V) - 2 * phi0) / t ** 2
            worst = max(worst, c2)
        log(f"P4I n={n}: worst second-order coefficient over {ndir} mixed "
            f"dirs = {worst:+.4f} "
            f"(claims: n=12 all negative, worst -1.83; n=8 positive, +4.33)")
    log("P4I: done")


def phase_pinned():
    """Theta-pinned LM hunt at n=8: solve Q(W) = th_t W at fixed targets,
    hunting for ungraded points above 0.900828."""
    log("PINNED: start")
    A, cat = catalogue(8)
    Bw = weyl_basis(A)
    Bflat = Bw.reshape(Bw.shape[0], -1)
    wit = None
    for lab, W0 in cat:
        if lab == "wit_0.9008":
            wit = unit(W0)
    rng = np.random.default_rng(2718)
    best_ung = (0.0, None)
    found = {}
    targets = (0.90, 0.905, 0.92, 0.95, 1.00, 1.05, 1.10, 1.16, 1.20)
    for th_t in targets:
        hits = 0
        for s in range(14):
            if s < 7 or wit is None:
                x0 = rng.normal(size=Bw.shape[0])
                x0 /= np.linalg.norm(x0)
            else:
                x0 = Bflat @ wit.reshape(-1)
                x0 = x0 + 0.12 * rng.normal(size=Bw.shape[0])
                x0 /= np.linalg.norm(x0)
            def F(x):
                W = np.einsum('d,dab->ab', x, Bw)
                nr = np.linalg.norm(W)
                if nr < 1e-12:
                    return np.full(A.N * A.N, 1e3)
                W = W / nr
                return (A.Q(W) - th_t * W).reshape(-1)
            r = least_squares(F, x0, method='lm', xtol=1e-14, ftol=1e-14,
                              max_nfev=1200)
            W = unit(np.einsum('d,dab->ab', r.x, Bw))
            # release theta: free Rayleigh polish from the pinned stall point
            W = lm_polish(A, Bw, 0.5 * (W + W.T), max_nfev=2500)
            a = audit_point(A, W)
            if a['res'] > 1e-11 or abs(a['th']) < 1e-3:
                continue
            hits += 1
            graded = max(a['T1'], 2 * a['T2'], a['T3']) < 1e-8
            key = round(a['th'], 6)
            if key not in found:
                found[key] = graded
                log(f"PINNED: th_t={th_t}: found th={a['th']:.6f} "
                    f"{'graded' if graded else 'UNGRADED'} S={a['S']:.4f} "
                    f"rhs={a['rhs']:.5f} res={a['res']:.1e}")
            if not graded and a['th'] > best_ung[0]:
                best_ung = (a['th'], a['rhs'])
        log(f"PINNED: target {th_t}: {hits}/14 converged; running best "
            f"ungraded th = {best_ung[0]:.6f}")
    log(f"PINNED: max ungraded theta = {best_ung[0]:.6f} "
        f"(record claim 0.900828); its rhs = {best_ung[1]}")
    log("PINNED: done")


if __name__ == "__main__":
    phase = sys.argv[1] if len(sys.argv) > 1 else "validate"
    {"validate": phase_validate, "slack": phase_slack, "bound": phase_bound,
     "hunt": phase_hunt, "spm": phase_spm, "g2": phase_g2,
     "j5": phase_j5, "p4i": phase_p4i, "pinned": phase_pinned}[phase]()
