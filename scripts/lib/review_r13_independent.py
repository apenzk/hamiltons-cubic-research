#!/usr/bin/env python3
"""Reviewer 13: independent adversarial audit of the four post-R12 "Gate 2 pending" results.

Everything here is rebuilt from findings/INDEX.md's *definitions* (read as text), importing
nothing from the pipeline under review. One permitted cross-check against
scripts/curvature_operator.py's Q_op pins the normalisation.

Conventions fixed by validation anchors (run `validate`):
  - Pair basis e_i^e_j (i<j) orthonormal on Lambda^2 R^n; operators = symmetric NxN.
  - 4-tensor T[i,j,k,l] = <W(e_i^e_j), e_k^e_l>, ||W||^2_op = (1/4) sum T^2.
  - sharp via so(n) structure constants, calibrated so Id# = (n-2) Id exactly.
  - Q(W) = W^2 + W#, critical: Q(W) = theta W on the Weyl space (Alt=0, Ric=0).
  - Alt = first-Bianchi projection; delta^2 = ||Alt(|W|)||^2_op / 4  (Fox anchor 1/9).
  - Master identity (FINDINGS "Lifting Jaeger's 3.3", Result 1), at critical points:
      theta r^2 = sqrt2 r^2 sqrt(1-trS^4) sqrt(1-e^2) - 2<Ric(W_-^2),Ric> + J4 - J5
    with Ric = Ric(|W|), r = ||Ric||, S = Ric/r, sqrt(1-e^2) = <|W|, RR>/||RR||,
    RR = Ric wedge Ric (operator x^y -> Ric x ^ Ric y), J4 = <D(|W|),Ric>,
    D_ij = (3/2) sum Alt_iklm Alt_jklm, J5 = <Ric(X_inv),Ric>,
    X_inv = |W|# - P+ W# P+ + P- W# P-.
  - Sharp (II)-side bound (rho = Ric(W_-) = Ric/2):
      RHS = sqrt2 sqrt(1-trS^4) sqrt(1-e^2) - <Ric(W_-^2),rho>/||rho||^2
            + 12 delta^2 lmax(rho)/||rho||^2
    and RHS - theta = [ (24 d2 lmax(Ric) - J4) + J5 ] / r^2  (both >= 0 mod J5-grant).

Subcommands: validate | catalog | hunt <n> <seeds> | claim2 | hess <n> | growth
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import itertools
import json
import sys
import time

import numpy as np

LOG = _os.path.join(_ROOT, "agent_logs/review_r13.log")
RNG = np.random.default_rng(20260820)


def log(msg):
    line = time.strftime("%Y-%m-%dT%H:%M:%S") + " " + msg
    print(line, flush=True)
    with open(LOG, "a") as f:
        f.write(line + "\n")


# ---------------------------------------------------------------- core dictionary
class Core:
    _cache = {}

    def __new__(cls, n):
        if n in cls._cache:
            return cls._cache[n]
        self = super().__new__(cls)
        self._build(n)
        cls._cache[n] = self
        return self

    def _build(self, n):
        self.n = n
        self.pairs = list(itertools.combinations(range(n), 2))
        self.N = len(self.pairs)
        self.pidx = {p: k for k, p in enumerate(self.pairs)}
        # structure constants of so(n) on the L_ij = E_ij - E_ji basis:
        # [L_ij, L_kl] = d_jk L_il - d_ik L_jl - d_jl L_ik + d_il L_jk
        N = self.N
        c = np.zeros((N, N, N))
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                for (u, v, s) in ((i, l, (j == k)), (j, l, -(i == k)),
                                  (i, k, -(j == l)), (j, k, (i == l))):
                    if not s or u == v:
                        continue
                    if u > v:
                        u, v, s = v, u, -s
                    c[a, b, self.pidx[(u, v)]] += s
        self.c = c

    # ---- conversions
    def op_to_t4(self, M):
        n, N = self.n, self.N
        T = np.zeros((n, n, n, n))
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                v = M[a, b]
                T[i, j, k, l] = v
                T[j, i, k, l] = -v
                T[i, j, l, k] = -v
                T[j, i, l, k] = v
        return T

    def t4_to_op(self, T):
        M = np.zeros((self.N, self.N))
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                M[a, b] = T[i, j, k, l]
        return M

    def biv_to_mat(self, v):
        """bivector (N-vector) -> antisymmetric n x n matrix."""
        A = np.zeros((self.n, self.n))
        for a, (i, j) in enumerate(self.pairs):
            A[i, j] = v[a]
            A[j, i] = -v[a]
        return A

    def mat_to_biv(self, A):
        return np.array([A[i, j] for (i, j) in self.pairs])

    # ---- basic operations
    def sharp(self, A, B=None):
        """polarized sharp: A#B symmetric bilinear with A#A = Hamilton's A#."""
        if B is None:
            B = A
        c = self.c
        # (X#Y)_ab = 1/2 c_age c_bdz X_gd Y_ez ; symmetrize in (X,Y)
        t1 = np.einsum('age,gd->ade', c, A)
        t2 = np.einsum('bdz,ez->bde', c, B)
        S1 = 0.5 * np.einsum('ade,bde->ab', t1, t2)
        if B is A:
            return 0.5 * (S1 + S1.T)
        t1 = np.einsum('age,gd->ade', c, B)
        t2 = np.einsum('bdz,ez->bde', c, A)
        S2 = 0.5 * np.einsum('ade,bde->ab', t1, t2)
        S = 0.5 * (S1 + S2)
        return 0.5 * (S + S.T)

    def sharp_t4(self, A):
        """independent 4-tensor implementation of A#A for cross-validation:
        (R#)_ijkl = sum_pq (R_ipkq R_jplq - R_iplq R_jpkq), calibrated below."""
        T = self.op_to_t4(A)
        S = np.einsum('ipkq,jplq->ijkl', T, T) - np.einsum('iplq,jpkq->ijkl', T, T)
        # antisymmetrize in (ij) and (kl) is automatic? enforce pair symmetry:
        S = 0.25 * (S - S.transpose(1, 0, 2, 3) - S.transpose(0, 1, 3, 2)
                    + S.transpose(1, 0, 3, 2))
        S = 0.5 * (S + S.transpose(2, 3, 0, 1))
        return self.t4_to_op(S)

    def Q(self, W):
        return W @ W + self.sharp(W)

    def sharp_lin_mat(self, W):
        """matrix (N^2 x N^2) of H -> W#H (polarized), acting on vec(H)."""
        c, N = self.c, self.N
        D1 = np.einsum('age,gd->ade', c, W)          # (a,d,e)
        # M[(ab),(ez)] = 1/2 sum_d D1[a,d,e] c[b,d,z]
        A2 = D1.transpose(0, 2, 1).reshape(N * N, N)      # (a e, d)
        C2 = c.transpose(1, 0, 2).reshape(N, N * N)       # (d, b z)
        M = 0.5 * (A2 @ C2)                               # (a e, b z)
        M = M.reshape(N, N, N, N).transpose(0, 2, 1, 3).reshape(N * N, N * N)
        # symmetrize output (a,b) and input (e,z) so it maps sym->sym
        Msym = M.reshape(N, N, N, N)
        Msym = 0.5 * (Msym + Msym.transpose(1, 0, 2, 3))
        Msym = 0.5 * (Msym + Msym.transpose(0, 1, 3, 2))
        return Msym.reshape(N * N, N * N)

    def Q_lin_mat(self, W, theta=0.0):
        """matrix of H -> dQ_W[H] - theta H = WH + HW + 2 W#H - theta H, on vec."""
        N = self.N
        I = np.eye(N)
        L = np.kron(I, W) + np.kron(W, I) + 2.0 * self.sharp_lin_mat(W)
        if theta:
            L -= theta * np.eye(N * N)
        return L

    def ric(self, M):
        T = self.op_to_t4(M)
        return np.einsum('ikjk->ij', T)

    def ric_star(self, h):
        """adjoint of ric: 4-tensor h_ac d_bd + h_bd d_ac - h_ad d_bc - h_bc d_ad."""
        n = self.n
        d = np.eye(n)
        X = (np.einsum('ac,bd->abcd', h, d) + np.einsum('bd,ac->abcd', h, d)
             - np.einsum('ad,bc->abcd', h, d) - np.einsum('bc,ad->abcd', h, d))
        return self.t4_to_op(X)

    def alt_t4(self, T):
        return (T + T.transpose(0, 2, 3, 1) + T.transpose(0, 3, 1, 2)) / 3.0

    def alt_op(self, M):
        return self.t4_to_op(self.alt_t4(self.op_to_t4(M)))

    def delta2(self, M):
        """Bianchi defect: ||Alt(M)||^2_op / 4 = (1/16) sum Alt^2."""
        A = self.alt_t4(self.op_to_t4(M))
        return float(np.sum(A * A)) / 16.0

    def weyl_project(self, M):
        M = 0.5 * (M + M.T)
        M = M - self.alt_op(M)
        h = self.ric(M)
        n = self.n
        ginv = (h - np.trace(h) / (2 * n - 2) * np.eye(n)) / (n - 2)
        return M - self.ric_star(ginv)

    def weyl_basis(self):
        if hasattr(self, '_wb'):
            return self._wb
        N = self.N
        cols = []
        for a in range(N):
            for b in range(a, N):
                E = np.zeros((N, N))
                E[a, b] = E[b, a] = 1.0 if a == b else 2 ** -0.5
                cols.append(self.weyl_project(E).ravel())
        A = np.array(cols).T                       # (N^2, Nsym)
        U, s, _ = np.linalg.svd(A, full_matrices=False)
        k = int(np.sum(s > 1e-8))
        self._wb = U[:, :k]                        # orthonormal, columns = basis
        return self._wb


# ---------------------------------------------------------------- point evaluation
def spectral_parts(W, tol=1e-9):
    lam, U = np.linalg.eigh(W)
    pos = lam > tol
    neg = lam < -tol
    Wp = (U[:, pos] * lam[pos]) @ U[:, pos].T
    Wm = -(U[:, neg] * lam[neg]) @ U[:, neg].T
    Pp = U[:, pos] @ U[:, pos].T
    Pm = U[:, neg] @ U[:, neg].T
    nz = np.abs(lam[np.abs(lam) > tol])
    gap = float(nz.min()) if nz.size else 0.0
    return lam, U, Wp, Wm, Pp, Pm, gap


def graded_masses(core, lam, U, tol=1e-7):
    """bracket-mass fractions of the three grading conditions (0 = graded)."""
    pos = [k for k in range(len(lam)) if lam[k] > tol]
    neg = [k for k in range(len(lam)) if lam[k] < -tol]
    if not pos or not neg:
        return (0.0, 0.0, 0.0)
    Bp = [core.biv_to_mat(U[:, k]) for k in pos]
    Bm = [core.biv_to_mat(U[:, k]) for k in neg]
    Um = U[:, neg]           # (N, q) orthonormal bivectors of E-
    Up = U[:, pos]

    def masses(As, Bs, proj_cols):
        tot = 0.0
        hit = 0.0
        for ii, A in enumerate(As):
            for B in (Bs if Bs is not As else Bs[ii + 1:]):
                v = core.mat_to_biv(A @ B - B @ A)
                tot += v @ v
                w = proj_cols.T @ v
                hit += w @ w
        return hit / tot if tot > 1e-14 else 0.0

    f1 = masses(Bp, Bp, Um)                      # [E+,E+] mass in E-  (want 0)
    f3 = masses(Bm, Bm, Um)                      # [E-,E-] mass in E-  (want 0)
    # [E+,E-] mass outside E-  (want 0)
    tot = hit = 0.0
    for A in Bp:
        for B in Bm:
            v = core.mat_to_biv(A @ B - B @ A)
            tot += v @ v
            w = Um.T @ v
            hit += v @ v - w @ w
    f2 = hit / tot if tot > 1e-14 else 0.0
    return (float(f1), float(f2), float(f3))


def evaluate_point(core, W, theta, want_masses=True):
    """all master-identity / sharp-bound quantities at a critical point."""
    n = core.n
    lam, U, Wp, Wm, Pp, Pm, gap = spectral_parts(W)
    absW = Wp + Wm
    Ric = core.ric(absW)
    r2 = float(np.sum(Ric * Ric))
    r = np.sqrt(r2)
    S = Ric / r
    trS4 = float(np.trace(np.linalg.matrix_power(S, 4)))
    # e-term: RR operator (x^y -> Ric x ^ Ric y)
    RR = np.zeros((core.N, core.N))
    for a, (i, j) in enumerate(core.pairs):
        for b, (k, l) in enumerate(core.pairs):
            RR[a, b] = Ric[i, k] * Ric[j, l] - Ric[i, l] * Ric[j, k]
    sq1me2 = float(np.sum(absW * RR)) / np.linalg.norm(RR)
    # B-term
    RicWm2 = core.ric(Wm @ Wm)
    Bterm = float(np.sum(RicWm2 * Ric))          # <Ric(W_-^2), Ric>
    # J4 via Gram D
    A4 = core.alt_t4(core.op_to_t4(absW))
    D = 1.5 * np.einsum('iklm,jklm->ij', A4, A4)
    J4 = float(np.sum(D * Ric))
    d2 = float(np.sum(A4 * A4)) / 16.0
    lmax = float(np.linalg.eigvalsh(Ric)[-1])
    cap = 24.0 * d2 * lmax
    # J5 via definitional X_inv and closed forms
    Wsh = core.sharp(W)
    absWsh = core.sharp(absW)
    Xdef = absWsh - Pp @ Wsh @ Pp + Pm @ Wsh @ Pm
    Xcf1 = absWsh + (W - theta * np.eye(core.N)) @ absW
    C = core.sharp(Wp, Wm)
    Xcf2 = 4.0 * C - 2.0 * theta * Wm - 2.0 * Wm @ Wm
    J5 = float(np.sum(core.ric(Xdef) * Ric))
    J5_cf1 = float(np.sum(core.ric(Xcf1) * Ric))
    J5_cf2 = float(np.sum(core.ric(Xcf2) * Ric))
    master_res = theta * r2 - (np.sqrt(2) * r2 * np.sqrt(max(1 - trS4, 0)) * sq1me2
                               - 2 * Bterm + J4 - J5)
    # sharp bound RHS in rho = Ric(W_-) variables (independent recomputation)
    rho = core.ric(Wm)
    nr2 = float(np.sum(rho * rho))
    Sh = rho / np.sqrt(nr2)
    trSh4 = float(np.trace(np.linalg.matrix_power(Sh, 4)))
    rhs = (np.sqrt(2) * np.sqrt(max(1 - trSh4, 0)) * sq1me2
           - float(np.sum(RicWm2 * rho)) / nr2
           + 12.0 * d2 * float(np.linalg.eigvalsh(rho)[-1]) / nr2)
    res_crit = np.linalg.norm(core.Q(W) - theta * W)
    out = dict(theta=float(theta), res=float(res_crit), gap=gap, d2=d2,
               r2=r2, trS4=trS4, sq1me2=float(sq1me2), Bterm=Bterm,
               B_over_rho2=float(np.sum(RicWm2 * rho)) / nr2,
               J4=J4, J5=J5, J5_cf1=J5_cf1, J5_cf2=J5_cf2, cap=cap,
               master_res=float(master_res), rhs=float(rhs),
               margin=float(np.sqrt(1.5) - rhs),
               slack=float(rhs - theta), t=float(np.trace(Wm)),
               ric_check=float(np.linalg.norm(core.ric(W))))
    if want_masses:
        f1, f2, f3 = graded_masses(core, lam, U)
        out.update(f1=f1, f2=f2, f3=f3, graded=bool(max(f1, f2, f3) < 1e-8))
    return out


# ---------------------------------------------------------------- LM machinery
def lm_polish(core, W0, theta0=None, max_iter=60, tol=1e-14):
    """Levenberg-Marquardt on F = [vec(Q(W)-theta W); |W|^2-1] over Weyl coords."""
    V = core.weyl_basis()                        # (N^2, d)
    N = core.N
    x = V.T @ W0.ravel()
    if theta0 is None:
        W = (V @ x).reshape(N, N)
        theta0 = float(np.sum(W * core.Q(W))) / max(np.sum(W * W), 1e-30)
    th = float(theta0)
    mu = 1e-8
    for it in range(max_iter):
        W = (V @ x).reshape(N, N)
        F = np.concatenate([(core.Q(W) - th * W).ravel(), [x @ x - 1.0]])
        f0 = np.linalg.norm(F)
        if f0 < tol:
            break
        d = len(x)
        V3 = V.reshape(N, N, d)
        AC = np.einsum('ab,bck->ack', W, V3) + np.einsum('abk,bc->ack', V3, W)
        SH = core.sharp_lin_mat(W) @ V
        J = np.zeros((N * N + 1, d + 1))
        J[:N * N, :d] = AC.reshape(N * N, d) + 2.0 * SH - th * V
        J[:N * N, d] = -W.ravel()
        J[N * N, :d] = 2 * x
        ok = False
        for _ in range(40):
            A = J.T @ J + mu * np.eye(J.shape[1])
            try:
                step = np.linalg.solve(A, -J.T @ F)
            except np.linalg.LinAlgError:
                mu *= 10
                continue
            xn = x + step[:len(x)]
            tn = th + step[len(x)]
            Wn = (V @ xn).reshape(N, N)
            Fn = np.concatenate([(core.Q(Wn) - tn * Wn).ravel(), [xn @ xn - 1.0]])
            if np.linalg.norm(Fn) < f0:
                x, th = xn, tn
                mu = max(mu / 3, 1e-14)
                ok = True
                break
            mu *= 10
        if not ok:
            break
    W = (V @ x).reshape(N, N)
    res = np.linalg.norm(np.concatenate([(core.Q(W) - th * W).ravel(),
                                         [x @ x - 1.0]]))
    if th < 0:                                   # sign convention: theta >= 0
        W, th = -W, -th
    return W, th, float(res)


# ---------------------------------------------------------------- constructions
def fox_tensor(core, plane=(0, 1, 2, 3)):
    """Fox's S^4(alpha) from his (6.1),(6.2),(10.2), literally; returns unit-norm W."""
    n = core.n
    g = np.zeros((n, n))
    for i in plane:
        g[i, i] = 1.0
    J = np.zeros((n, n))
    a, b, cc, d = plane
    J[a, b], J[b, a], J[cc, d], J[d, cc] = 1.0, -1.0, 1.0, -1.0
    alpha = J            # fundamental 2-form of J (as antisymmetric matrix)
    gg = np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
    # (al.al)_ijkl = -3( al_k[i al_j]l - al_l[i al_j]k - 2 al_[ij al_kl] )
    A = alpha

    def br2(Tkl_i_j):   # antisymmetrize [i j] handled inline below
        pass
    t1 = 0.5 * (np.einsum('ki,jl->ijkl', A, A) - np.einsum('kj,il->ijkl', A, A))
    t2 = 0.5 * (np.einsum('li,jk->ijkl', A, A) - np.einsum('lj,ik->ijkl', A, A))
    # full antisymmetrization al_[ij al_kl] over 4 indices, weight 1/4!
    t3 = np.zeros((n, n, n, n))
    for perm in itertools.permutations(range(4)):
        sign = perm_sign(perm)
        t3 += sign * np.einsum('ijkl->' + ''.join('ijkl'[p] for p in perm),
                               np.einsum('ij,kl->ijkl', A, A))
    t3 /= 24.0
    aa = -3.0 * (t1 - t2 - 2.0 * t3)
    T = (1.0 / 6.0) * (gg - aa)          # S^4(alpha), r=4: 3/(r-1)=1
    W = core.t4_to_op(T)
    W = W / np.linalg.norm(W)
    # fix sign so that Q(W) = +theta W
    if np.sum(W * core.Q(W)) < 0:
        W = -W
    return W


def perm_sign(perm):
    s = 1
    p = list(perm)
    for i in range(len(p)):
        while p[i] != i:
            j = p[i]
            p[i], p[j] = p[j], p[i]
            s = -s
    return s


def sphere_product(core, p):
    """Weyl part of S^p x S^q product curvature (q = n-p), unit norm, critical."""
    n = core.n
    T = np.zeros((n, n, n, n))
    for blk in (range(p), range(p, n)):
        g = np.zeros((n, n))
        for i in blk:
            g[i, i] = 1.0
        T += np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
    W = core.weyl_project(core.t4_to_op(T))
    W /= np.linalg.norm(W)
    if np.sum(W * core.Q(W)) < 0:
        W = -W
    return W


def multiblock_seed(core, blocks, kappas=None):
    n = core.n
    assert sum(blocks) == n
    if kappas is None:
        kappas = [1.0] * len(blocks)
    T = np.zeros((n, n, n, n))
    s = 0
    for blk_len, kap in zip(blocks, kappas):
        g = np.zeros((n, n))
        for i in range(s, s + blk_len):
            g[i, i] = 1.0
        T += kap * (np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g))
        s += blk_len
    W = core.weyl_project(core.t4_to_op(T))
    W /= np.linalg.norm(W)
    if np.sum(W * core.Q(W)) < 0:
        W = -W
    return W


def su_m_family(core, m):
    """(su(m), so(m)) Kaehler pair on C^m = R^2m (padded to n): two-eigenvalue W."""
    n = core.n
    assert n >= 2 * m
    # k = so(m): [[A,0],[0,A]];  m-part: [[0,-B],[B,0]], B sym traceless
    kvecs, mvecs = [], []
    for i in range(m):
        for j in range(i + 1, m):
            X = np.zeros((n, n))
            X[i, j] = X[m + i, m + j] = 1.0
            X[j, i] = X[m + j, m + i] = -1.0
            kvecs.append(core.mat_to_biv(X))
    for i in range(m):
        for j in range(i, m):
            B = np.zeros((m, m))
            B[i, j] = B[j, i] = 1.0
            if i == j:
                B -= np.eye(m) / m
                if i == m - 1:
                    continue
            X = np.zeros((n, n))
            X[:m, m:2 * m] = -B
            X[m:2 * m, :m] = B
            mvecs.append(core.mat_to_biv(X))
    Uk = np.linalg.qr(np.array(kvecs).T)[0]
    Um = np.linalg.qr(np.array(mvecs).T)[0]
    Pk = Uk @ Uk.T
    Pm = Um @ Um.T
    # W = a Pk - b Pm, Ricci-flat + unit norm
    rk = core.ric(Pk)
    rm = core.ric(Pm)
    # both should be multiples of the projection onto the 2m-plane
    ck = rk[0, 0]
    cm = rm[0, 0]
    p, q = Uk.shape[1], Um.shape[1]
    b = 1.0 / np.sqrt(q + p * (cm / ck) ** 2)
    a = b * cm / ck
    W = a * Pk - b * Pm
    W /= np.linalg.norm(W)
    if np.sum(W * core.Q(W)) < 0:
        W = -W
    return W


def hp_m(core, m):
    """HP^m Weyl operator on R^{4m} (padded to n), via the QK curvature formula."""
    n = core.n
    d = 4 * m
    assert n >= d
    # quaternion right-multiplication complex structures on R^4 blocks
    i4 = np.array([[0, -1, 0, 0], [1, 0, 0, 0], [0, 0, 0, 1], [0, 0, -1, 0.]])
    j4 = np.array([[0, 0, -1, 0], [0, 0, 0, -1], [1, 0, 0, 0], [0, 1, 0, 0.]])
    k4 = i4 @ j4
    Js = []
    for q4 in (i4, j4, k4):
        J = np.zeros((n, n))
        for b in range(m):
            J[4 * b:4 * b + 4, 4 * b:4 * b + 4] = q4
        Js.append(J)
    g = np.zeros((n, n))
    for i in range(d):
        g[i, i] = 1.0
    T = np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
    for J in Js:
        T += (np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
              + 2.0 * np.einsum('ij,kl->ijkl', J, J))
    W = core.weyl_project(core.t4_to_op(T))
    nw = np.linalg.norm(W)
    if nw < 1e-12:
        return None
    W /= nw
    if np.sum(W * core.Q(W)) < 0:
        W = -W
    return W


def su3_biinvariant(core):
    """bi-invariant SU(3): T(a,b,c,d) = 1/4 <[Xa,Xb],[Xc,Xd]> on su(3)=R^8."""
    n = core.n
    assert n == 8
    lam = []
    E = lambda i, j: np.eye(3)[:, [i]] @ np.eye(3)[[j], :]
    for (i, j) in ((0, 1), (0, 2), (1, 2)):
        lam.append((E(i, j) + E(j, i)).astype(complex))
        lam.append(1j * (E(i, j) - E(j, i)))
    lam.append(np.diag([1, -1, 0]).astype(complex))
    lam.append(np.diag([1, 1, -2]).astype(complex) / np.sqrt(3))
    X = [1j * L / np.sqrt(2) for L in lam]   # orthonormal wrt <A,B> = -tr(AB)... check
    # normalize: <A,B> = Re tr(A^H B); A = iL antihermitian
    for a in range(8):
        nrm = np.sqrt(np.real(np.trace(X[a].conj().T @ X[a])))
        X[a] = X[a] / nrm
    T = np.zeros((n, n, n, n))
    br = [[X[a] @ X[b] - X[b] @ X[a] for b in range(8)] for a in range(8)]
    for a in range(8):
        for b in range(8):
            for c in range(8):
                for dd in range(8):
                    T[a, b, c, dd] = 0.25 * np.real(
                        np.trace(br[a][b].conj().T @ br[c][dd]))
    W = core.weyl_project(core.t4_to_op(T))
    W /= np.linalg.norm(W)
    if np.sum(W * core.Q(W)) < 0:
        W = -W
    return W


def pad_to(core_big, core_small, W_small):
    Wb = np.zeros((core_big.N, core_big.N))
    for a, pa in enumerate(core_small.pairs):
        for b, pb in enumerate(core_small.pairs):
            Wb[core_big.pidx[pa], core_big.pidx[pb]] = W_small[a, b]
    return Wb


# ---------------------------------------------------------------- validation
def validate():
    log("VALIDATE start")
    ok = True
    for n in (5, 6, 8):
        core = Core(n)
        I = np.eye(core.N)
        r = np.linalg.norm(core.sharp(I) - (n - 2) * I)
        log(f"  n={n}: ||Id# - (n-2)Id|| = {r:.2e}")
        ok &= r < 1e-12
    core = Core(6)
    A = rand_sym(core)
    B = rand_sym(core)
    Cm = rand_sym(core)
    t = [np.sum(core.sharp(A, B) * Cm), np.sum(core.sharp(B, Cm) * A),
         np.sum(core.sharp(Cm, A) * B)]
    log(f"  trilinear symmetry spread: {max(t)-min(t):.2e}")
    ok &= max(t) - min(t) < 1e-10
    r = np.linalg.norm(core.sharp_t4(A) - core.sharp(A))
    log(f"  sharp via 4-tensor vs structure constants: {r:.2e}")
    ok &= r < 1e-10
    T = core.op_to_t4(A)
    A1 = core.alt_t4(T)
    r1 = np.linalg.norm(core.alt_t4(A1) - A1)
    r2 = abs(np.sum(A1 * core.op_to_t4(B)) - np.sum(T * core.alt_t4(core.op_to_t4(B))))
    log(f"  Alt idempotent {r1:.2e}, self-adjoint {r2:.2e}")
    ok &= r1 < 1e-12 and r2 < 1e-10
    QA = core.Q(A)
    scal = np.trace(core.ric(QA))
    tgt = np.sum(core.ric(A) ** 2) + 6 * (4 * core.delta2(A))
    log(f"  scal(R^2+R#) - ||Ric||^2 - 6||Alt||^2 = {scal-tgt:.2e}")
    ok &= abs(scal - tgt) < 1e-9
    h = RNG.standard_normal((6, 6))
    h = h + h.T
    r = abs(np.sum(core.ric_star(h) * B) - np.sum(h * core.ric(B)))
    g = core.ric(core.ric_star(h)) - ((6 - 2) * h + np.trace(h) * np.eye(6))
    log(f"  Ric* adjointness {r:.2e}, Ric Ric* = (n-2)h+tr(h)I: {np.linalg.norm(g):.2e}")
    ok &= r < 1e-10 and np.linalg.norm(g) < 1e-10
    Wt = core.weyl_project(A)
    r = max(np.linalg.norm(core.ric(Wt)), 4 * core.delta2(Wt),
            np.linalg.norm(core.weyl_project(Wt) - Wt))
    log(f"  Weyl projector: ric/alt/idempotency worst {r:.2e}")
    ok &= r < 1e-10
    # diagonal formula cross-check at n=6
    lamm = RNG.standard_normal((6, 6))
    lamm = lamm + lamm.T
    np.fill_diagonal(lamm, 0)
    lamm -= np.diag(np.zeros(6))
    # make row sums zero (hollow with zero row sums = diagonal Weyl class)
    for _ in range(200):
        lamm -= np.outer(lamm.sum(1), np.ones(6)) / 6
        lamm = 0.5 * (lamm + lamm.T)
        np.fill_diagonal(lamm, 0)
    M = np.zeros((core.N, core.N))
    for a, (i, j) in enumerate(core.pairs):
        M[a, a] = lamm[i, j]
    QM = core.Q(M)
    worst = 0.0
    for a, (i, j) in enumerate(core.pairs):
        pred = lamm[i, j] ** 2 + sum(lamm[i, k] * lamm[j, k] for k in range(6)
                                     if k != i and k != j)
        worst = max(worst, abs(QM[a, a] - pred))
    offd = np.linalg.norm(QM - np.diag(np.diag(QM)))
    log(f"  diagonal Q formula: worst diag err {worst:.2e}, offdiag {offd:.2e}")
    ok &= worst < 1e-10 and offd < 1e-10
    # Fox anchor
    core8 = Core(8)
    Wf = fox_tensor(core8)
    th = float(np.sum(Wf * core8.Q(Wf)))
    res = np.linalg.norm(core8.Q(Wf) - th * Wf)
    d2 = core8.delta2(0.5 * (spectral_abs(Wf)))
    log(f"  Fox anchor: theta={th:.12f} (sqrt(3/2)={np.sqrt(1.5):.12f}), "
        f"res={res:.2e}, delta2(|W|)={core8.delta2(spectral_abs(Wf)):.12f} (1/9={1/9:.12f})")
    ok &= abs(th - np.sqrt(1.5)) < 1e-10 and res < 1e-12
    ok &= abs(core8.delta2(spectral_abs(Wf)) - 1 / 9) < 1e-10
    # balanced sphere anchors
    for n in (6, 8, 12):
        cor = Core(n)
        Ws = sphere_product(cor, n // 2)
        th = float(np.sum(Ws * cor.Q(Ws)))
        res = np.linalg.norm(cor.Q(Ws) - th * Ws)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        log(f"  S^{n//2}xS^{n//2}: theta={th:.10f} vs theta0={th0:.10f}, res={res:.2e}")
        ok &= abs(th - th0) < 1e-9 and res < 1e-11
    # permitted cross-check vs curvature_operator.Q_op
    sys.path.insert(0, _os.path.join(_ROOT, "scripts"))
    import curvature_operator as co
    L2 = co.Lambda2(6)
    Wr = core.weyl_project(rand_sym(core))
    Wr /= np.linalg.norm(Wr)
    q_theirs = co.Q_op(L2, Wr)
    q_mine = core.Q(Wr)
    r = np.linalg.norm(q_theirs - q_mine) / np.linalg.norm(q_mine)
    log(f"  cross-check vs curvature_operator.Q_op: rel diff {r:.2e}")
    ok &= r < 1e-12
    log(f"VALIDATE {'PASS' if ok else 'FAIL'}")
    return ok


def spectral_abs(W):
    lam, U = np.linalg.eigh(W)
    return (U * np.abs(lam)) @ U.T


def rand_sym(core):
    A = RNG.standard_normal((core.N, core.N))
    return 0.5 * (A + A.T)


# ---------------------------------------------------------------- claim 1: catalog
def fmt_point(name, ev):
    return (f"{name:28s} th={ev['theta']:.6f} res={ev['res']:.1e} d2={ev['d2']:.5f} "
            f"gap={ev['gap']:.1e} graded={'Y' if ev.get('graded') else 'n'} "
            f"masses=({ev.get('f1',0):.1e},{ev.get('f2',0):.1e},{ev.get('f3',0):.1e}) "
            f"mres={ev['master_res']:.1e} RHS={ev['rhs']:.6f} "
            f"margin={ev['margin']:+.6f} slack={ev['slack']:+.6f} "
            f"J4={ev['J4']:.4f} cap={ev['cap']:.4f} J5={ev['J5']:.4f} "
            f"e~{np.sqrt(max(1-ev['sq1me2']**2,0)):.4f}")


def catalog():
    log("CATALOG start")
    rows = []

    def add(name, core, W, polish=True):
        th = float(np.sum(W * core.Q(W)))
        res = np.linalg.norm(core.Q(W) - th * W)
        if polish and res > 1e-11:
            W, th, res = lm_polish(core, W, th)
        ev = evaluate_point(core, W, th)
        rows.append((name, ev))
        log("  " + fmt_point(name, ev))
        return W, th, ev

    core8 = Core(8)
    add("Fox n=8", core8, fox_tensor(core8), polish=False)
    add("S4xS4", core8, sphere_product(core8, 4), polish=False)
    add("S3xS5", core8, sphere_product(core8, 3), polish=False)
    add("S2xS6", core8, sphere_product(core8, 2), polish=False)
    for blocks in ((2, 2, 4), (2, 3, 3), (2, 2, 2, 2)):
        W = multiblock_seed(core8, blocks)
        add(f"S{'xS'.join(map(str,blocks))}", core8, W)
    add("su(3) Kaehler n=8", core8, su_m_family(core8, 3))
    add("su(4) Kaehler n=8", core8, su_m_family(core8, 4))
    add("SU(3) bi-invariant", core8, su3_biinvariant(core8))
    add("HP^2 n=8", core8, hp_m(core8, 2))
    # saved witnesses (loaded as data, then re-polished with MY machinery)
    import os
    wit = {
        "witness th=0.9008 (gap_band)": "scripts/data/gap_band_point_n8.npy",
        "3/25 violator": "scripts/data/defect_violation_n8_0.120000.npy",
        "defect_theta0 d2=1/8": "scripts/data/defect_theta0_n8_0.125000.npy",
        "frontier n8 Fox-like": "scripts/data/frontier_n8_th1.224745_d20.111111.npy",
        "r12 record th=0.9067": "agent_logs/review_r12_ungraded_record_n8.npy",
        "r12 rhs-breaker": "agent_logs/review_r12_rhs_breaker_n8.npy",
    }
    base = _os.path.join(_ROOT, "")
    for name, path in wit.items():
        p = base + path
        if not os.path.exists(p):
            log(f"  {name}: MISSING {path}")
            continue
        dat = np.load(p, allow_pickle=True)
        arrs = []
        if dat.ndim == 2 and dat.shape[0] == dat.shape[1]:
            arrs = [np.asarray(dat, float)]
        elif dat.ndim == 3:
            arrs = [np.asarray(d, float) for d in dat]
        else:
            try:
                d = dat.item()
                arrs = [np.asarray(v, float) for v in
                        (d.values() if isinstance(d, dict) else [d])]
            except Exception:
                log(f"  {name}: unparsed shape {dat.shape}")
                continue
        for k, Wr in enumerate(arrs):
            if Wr.ndim != 2 or Wr.shape[0] != Wr.shape[1]:
                continue
            nn = {15: 6, 21: 7, 28: 8, 66: 12}.get(Wr.shape[0])
            if nn is None:
                continue
            cor = Core(nn)
            Wr = 0.5 * (Wr + Wr.T)
            Wr /= np.linalg.norm(Wr)
            add(f"{name}[{k}]", cor, Wr)
    # n=12
    core12 = Core(12)
    log("  building n=12 (slower)...")
    add("S6xS6 n=12", core12, sphere_product(core12, 6), polish=False)
    add("S5xS7 n=12", core12, sphere_product(core12, 5), polish=False)
    add("S2xS10 n=12", core12, sphere_product(core12, 2), polish=False)
    add("Fox padded n=12", core12, pad_to(core12, core8, fox_tensor(core8)),
        polish=False)
    add("HP^3 n=12", core12, hp_m(core12, 3), polish=False)
    add("HP^2 padded n=12", core12, pad_to(core12, core8, hp_m(core8, 2)),
        polish=False)
    # summary
    viol = [(nm, e) for nm, e in rows if e['slack'] < -1e-8]
    over = [(nm, e) for nm, e in rows if not e.get('graded', True)
            and e['rhs'] >= np.sqrt(1.5) - 1e-9]
    log(f"CATALOG done: {len(rows)} points, inequality violations: {len(viol)}, "
        f"ungraded RHS>=sqrt(3/2): {len(over)}")
    for nm, e in viol + over:
        log("  !! " + fmt_point(nm, e))
    return rows


# ---------------------------------------------------------------- claim 1: hunt
def hunt(n, n_seeds=120, out_prefix=None):
    core = Core(n)
    V = core.weyl_basis()
    d = V.shape[1]
    log(f"HUNT n={n}: dimWeyl={d}, {n_seeds} random seeds + witness cascade")
    found = {}

    def register(W, th, res, src):
        if res > 5e-12:
            return None
        ev = evaluate_point(core, W, th)
        key = (round(ev['theta'], 6), round(ev['d2'], 6), round(ev['t'], 5),
               round(ev['trS4'], 5))
        if key in found:
            return None
        ev['src'] = src
        found[key] = (W, ev)
        return ev

    # seed the cascade pool with the saved high-slack witnesses (n=8 only)
    if n == 8:
        import os
        base = _os.path.join(_ROOT, "")
        for path in ("scripts/data/defect_violation_n8_0.120000.npy",
                     "scripts/data/defect_theta0_n8_0.125000.npy",
                     "scripts/data/gap_band_point_n8.npy",
                     "agent_logs/review_r12_ungraded_record_n8.npy",
                     "agent_logs/review_r12_rhs_breaker_n8.npy"):
            if not os.path.exists(base + path):
                continue
            dat = np.load(base + path, allow_pickle=True)
            arrs = [dat] if dat.ndim == 2 else list(dat) if dat.ndim == 3 else []
            for Wr in arrs:
                Wr = 0.5 * (np.asarray(Wr, float) + np.asarray(Wr, float).T)
                if Wr.shape[0] != core.N:
                    continue
                Wr /= np.linalg.norm(Wr)
                W, th, res = lm_polish(core, Wr)
                register(W, th, res, "witness:" + path.split("/")[-1])
    t0 = time.time()
    for s in range(n_seeds):
        x = RNG.standard_normal(d)
        W0 = (V @ (x / np.linalg.norm(x))).reshape(core.N, core.N)
        W, th, res = lm_polish(core, W0)
        register(W, th, res, f"rand{s}")
        if time.time() - t0 > 150:
            log(f"  hunt n={n}: seed {s+1}/{n_seeds}, {len(found)} unique pts, "
                f"maxRHS={max((e['rhs'] for _, e in found.values()), default=0):.6f}")
            t0 = time.time()
    # cascade: perturb every interesting (ungraded, defective) point
    log(f"  hunt n={n}: random phase done, {len(found)} pts; cascade phase")
    t0 = time.time()
    pool = [(W, ev) for (W, ev) in found.values() if not ev.get('graded')]
    pool.sort(key=lambda we: -we[1]['rhs'])
    for gen in range(3):
        new = []
        for W, ev in pool[:12]:
            for amp in (0.03, 0.1, 0.25):
                for rep in range(4):
                    dx = RNG.standard_normal(d)
                    W0 = W + amp * (V @ (dx / np.linalg.norm(dx))).reshape(core.N, core.N)
                    W0 /= np.linalg.norm(W0)
                    Wp, th, res = lm_polish(core, W0)
                    e2 = register(Wp, th, res, f"casc{gen}")
                    if e2 is not None:
                        new.append((Wp, e2))
                if time.time() - t0 > 150:
                    log(f"  hunt n={n}: cascade gen{gen}, {len(found)} pts, "
                        f"maxRHS={max(e['rhs'] for _, e in found.values()):.6f}")
                    t0 = time.time()
        pool = sorted([(W, e) for W, e in list(found.values())
                       if not e.get('graded')],
                      key=lambda we: -we[1]['rhs'])
    # report
    pts = sorted(found.values(), key=lambda we: -we[1]['rhs'])
    log(f"HUNT n={n} done: {len(found)} unique critical points")
    for W, e in pts[:20]:
        log("  " + fmt_point(e['src'], e))
    viol = [e for _, e in pts if e['slack'] < -1e-8]
    over = [e for _, e in pts if not e.get('graded', True)
            and e['rhs'] >= np.sqrt(1.5) - 1e-9]
    log(f"HUNT n={n}: inequality violations {len(viol)}, "
        f"ungraded RHS>=sqrt(3/2): {len(over)}, minJ5={min(e['J5'] for _, e in pts):.6f}")
    if out_prefix:
        np.save(out_prefix + f"_n{n}_top.npy",
                np.array([W for W, _ in pts[:8]]))
    return pts


def lm_pinned(core, W0, th_pin, max_iter=50):
    """LM on F = Q(W) - th_pin*W over unnormalized Weyl coords (scale free)."""
    V = core.weyl_basis()
    N = core.N
    x = V.T @ W0.ravel()
    mu = 1e-8
    for it in range(max_iter):
        W = (V @ x).reshape(N, N)
        F = (core.Q(W) - th_pin * W).ravel()
        f0 = np.linalg.norm(F)
        if f0 < 1e-14 or np.linalg.norm(x) < 1e-6:
            break
        J = (core.Q_lin_mat(W, th_pin)) @ V
        ok = False
        for _ in range(40):
            A = J.T @ J + mu * np.eye(J.shape[1])
            try:
                step = np.linalg.solve(A, -J.T @ F)
            except np.linalg.LinAlgError:
                mu *= 10
                continue
            xn = x + step
            Wn = (V @ xn).reshape(N, N)
            Fn = (core.Q(Wn) - th_pin * Wn).ravel()
            if np.linalg.norm(Fn) < f0:
                x = xn
                mu = max(mu / 3, 1e-14)
                ok = True
                break
            mu *= 10
        if not ok:
            break
    W = (V @ x).reshape(N, N)
    s = np.linalg.norm(W)
    if s < 1e-6:
        return None, None, 1.0
    return W / s, th_pin / s, np.linalg.norm(core.Q(W) - th_pin * W) / s ** 2


def pinhunt(n, per_pin=25):
    """pinned-theta sweep targeting the mid-theta ungraded band."""
    core = Core(n)
    V = core.weyl_basis()
    d = V.shape[1]
    log(f"PINHUNT n={n}: theta pins x {per_pin} seeds each")
    found = {}
    t0 = time.time()
    for th_pin in (0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95):
        for s in range(per_pin):
            x = RNG.standard_normal(d)
            W0 = (V @ (x / np.linalg.norm(x))).reshape(core.N, core.N)
            W, th, res = lm_pinned(core, W0, th_pin)
            if W is None or res > 1e-8:
                continue
            # free polish to a genuine critical point at unit norm
            W, th, res = lm_polish(core, W, th)
            if res > 5e-12:
                continue
            ev = evaluate_point(core, W, th)
            key = (round(ev['theta'], 5), round(ev['d2'], 5), round(ev['t'], 4),
                   round(ev['trS4'], 4))
            if key in found:
                continue
            ev['src'] = f"pin{th_pin}"
            found[key] = ev
            if time.time() - t0 > 150:
                mx = max(e['rhs'] for e in found.values()
                         if not e.get('graded')) if any(
                    not e.get('graded') for e in found.values()) else 0
                log(f"  pinhunt n={n}: pin={th_pin} seed={s} pts={len(found)} "
                    f"max ungraded RHS={mx:.6f}")
                t0 = time.time()
    pts = sorted(found.values(), key=lambda e: -e['rhs'])
    log(f"PINHUNT n={n} done: {len(pts)} unique")
    for e in pts[:15]:
        log("  " + fmt_point(e['src'], e))
    viol = [e for e in pts if e['slack'] < -1e-8]
    over = [e for e in pts if not e.get('graded', True)
            and e['rhs'] >= np.sqrt(1.5) - 1e-9]
    mn = min((e['J5'] for e in pts), default=float('nan'))
    log(f"PINHUNT n={n}: violations {len(viol)}, ungraded RHS>=sqrt(3/2) "
        f"{len(over)}, minJ5={mn:.6f}")
    return pts


def hunt12b():
    """n=12 targeted hunt: perturb padded n=8 ungraded witnesses into the full
    n=12 Weyl space and LM-polish; probes whether the ungraded RHS ceiling rises
    with n (measured 1.033/1.056/1.091 at n=6/7/8)."""
    core = Core(12)
    c8 = Core(8)
    V = core.weyl_basis()
    d = V.shape[1]
    log(f"HUNT12B start: dimWeyl={d}")
    base = _os.path.join(_ROOT, "")
    roots = []
    for path in ("agent_logs/review_r12_ungraded_record_n8.npy",
                 "scripts/data/defect_violation_n8_0.120000.npy",
                 "scripts/data/gap_band_point_n8.npy"):
        Wr = np.load(base + path)
        Wr = 0.5 * (Wr + Wr.T)
        Wr /= np.linalg.norm(Wr)
        roots.append((path.split("/")[-1], pad_to(core, c8, Wr)))
    import os
    if os.path.exists(base + "agent_logs/review_r13_n8_top.npy"):
        tops = np.load(base + "agent_logs/review_r13_n8_top.npy")
        for k, Wr in enumerate(tops[:4]):
            roots.append((f"r13top{k}", pad_to(core, c8, np.asarray(Wr))))
    found = {}
    t0 = time.time()
    for nm, Wroot in roots:
        for amp in (0.05, 0.15, 0.35):
            for rep in range(3):
                dx = RNG.standard_normal(d)
                W0 = Wroot + amp * (V @ (dx / np.linalg.norm(dx))).reshape(core.N, core.N)
                W0 /= np.linalg.norm(W0)
                W, th, res = lm_polish(core, W0, max_iter=120)
                if res > 5e-12:
                    continue
                ev = evaluate_point(core, W, th)
                key = (round(ev['theta'], 5), round(ev['d2'], 5),
                       round(ev['t'], 4), round(ev['trS4'], 4))
                if key in found:
                    continue
                ev['src'] = f"{nm}+{amp}"
                found[key] = ev
                if time.time() - t0 > 150:
                    mx = max((e['rhs'] for e in found.values()
                              if not e.get('graded')), default=0)
                    log(f"  hunt12b: {len(found)} pts, max ungraded RHS={mx:.6f}")
                    t0 = time.time()
    pts = sorted(found.values(), key=lambda e: -e['rhs'])
    log(f"HUNT12B done: {len(pts)} unique")
    for e in pts[:15]:
        log("  " + fmt_point(e['src'], e))
    viol = [e for e in pts if e['slack'] < -1e-8]
    over = [e for e in pts if not e.get('graded', True)
            and e['rhs'] >= np.sqrt(1.5) - 1e-9]
    log(f"HUNT12B: violations {len(viol)}, ungraded RHS>=sqrt(3/2) {len(over)}")
    return pts


def combo_attack():
    """direct sums of critical blocks on disjoint index supports.
    a W1 (+) b W2 is critical iff a th1 = b th2 (with a^2+b^2=1); the J4 cap
    couples global lmax with total delta^2, so combinations probe RHS inflation
    that single-support points cannot reach."""
    log("COMBO start: direct-sum attack")
    base = _os.path.join(_ROOT, "")
    parts = {}                    # name -> (support_dim, W(matrix on Core(d)), th)
    c8 = Core(8)
    c6 = Core(6)

    def put(name, core, W):
        th = float(np.sum(W * core.Q(W)))
        res = np.linalg.norm(core.Q(W) - th * W)
        parts[name] = (core.n, W, th)
        log(f"  part {name}: n={core.n} th={th:.6f} res={res:.1e}")

    put("fox", Core(4) if False else c8, fox_tensor(c8))
    put("violator", c8, np.load(base + "scripts/data/defect_violation_n8_0.120000.npy"))
    put("record", c8, np.load(base + "agent_logs/review_r12_ungraded_record_n8.npy"))
    put("hp2", c8, hp_m(c8, 2))
    put("su3k", c8, su_m_family(c8, 3))
    Wt0 = np.load(base + "scripts/data/defect_theta0_n8_0.125000.npy")
    parts["theta0pt"] = (8, Wt0 / np.linalg.norm(Wt0), 0.0)
    # a generic low-theta / high-slack n=6 point from a quick LM
    V6 = c6.weyl_basis()
    best = None
    for s in range(30):
        x = RNG.standard_normal(V6.shape[1])
        W0 = (V6 @ (x / np.linalg.norm(x))).reshape(c6.N, c6.N)
        W, th, res = lm_polish(c6, W0)
        if res < 5e-12 and th > 0.05:
            ev = evaluate_point(c6, W, th, want_masses=False)
            if best is None or ev['rhs'] > best[1]['rhs']:
                best = (W, ev)
    if best is not None:
        put("gen6", c6, best[0])
    combos = [("fox", "violator"), ("fox", "record"), ("violator", "record"),
              ("violator", "violator"), ("record", "record"),
              ("violator", "hp2"), ("record", "hp2"), ("record", "su3k"),
              ("violator", "gen6"), ("record", "gen6"), ("gen6", "gen6"),
              ("theta0pt", "theta0pt")]
    out = []
    for nm1, nm2 in combos:
        if nm1 not in parts or nm2 not in parts:
            continue
        d1, W1, th1 = parts[nm1]
        d2_, W2, th2 = parts[nm2]
        n = d1 + d2_
        core = Core(n)
        # weights: a th1 = b th2, a^2 + b^2 = 1
        if th1 < 1e-12 and th2 < 1e-12:
            a = b = 2 ** -0.5
        elif th1 < 1e-12 or th2 < 1e-12:
            continue
        else:
            a = th2 / np.hypot(th1, th2)
            b = th1 / np.hypot(th1, th2)
        W = np.zeros((core.N, core.N))
        cs1 = Core(d1)
        cs2 = Core(d2_)
        for al, pa in enumerate(cs1.pairs):
            for bl, pb in enumerate(cs1.pairs):
                W[core.pidx[pa], core.pidx[pb]] = a * W1[al, bl]
        off = d1
        for al, pa in enumerate(cs2.pairs):
            for bl, pb in enumerate(cs2.pairs):
                qa = (pa[0] + off, pa[1] + off)
                qb = (pb[0] + off, pb[1] + off)
                W[core.pidx[qa], core.pidx[qb]] = b * W2[al, bl]
        th = a * a * th1 / a if th1 > 1e-12 else 0.0   # = a th1 = b th2
        res = np.linalg.norm(core.Q(W) - th * W)
        if res > 1e-10:
            W, th, res = lm_polish(core, W, th)
        ev = evaluate_point(core, W, th, want_masses=False)
        out.append((f"{nm1}(+){nm2}", ev))
        log("  " + fmt_point(f"{nm1}(+){nm2} n={n}", ev))
    mx = max(e['rhs'] for _, e in out)
    log(f"COMBO done: max RHS = {mx:.6f} (sqrt(3/2) = {np.sqrt(1.5):.6f}); "
        f"violations: {sum(1 for _, e in out if e['slack'] < -1e-8)}")
    return out


# ---------------------------------------------------------------- claim 2
def claim2():
    log("CLAIM2 start: Fox trS4=1/4 identity and su(m) family")
    for n in (8, 12, 16):
        core = Core(n)
        Wf = fox_tensor(core)
        th = float(np.sum(Wf * core.Q(Wf)))
        ev = evaluate_point(core, Wf, th, want_masses=(n == 8))
        lam, U, Wp, Wm, Pp, Pm, gap = spectral_parts(Wf)
        rho = core.ric(Wm)
        supp = np.diag(rho)[:4]
        off = rho - np.diag(np.diag(rho))
        log(f"  Fox n={n}: theta={th:.12f}, trS4={ev['trS4']:.14f} (1/4), "
            f"sq(1-e2)={ev['sq1me2']:.14f} (2/3={2/3:.14f}), "
            f"B/rho2={ev['B_over_rho2']:.14f} (1/sqrt6={6**-0.5:.14f}), "
            f"cap/r2-normalized={12*ev['d2']*np.linalg.eigvalsh(rho)[-1]/np.sum(rho*rho):.14f} "
            f"(2/sqrt6={2/np.sqrt(6):.14f}), RHS={ev['rhs']:.12f} "
            f"(sqrt(3/2)={np.sqrt(1.5):.12f})")
        log(f"    rho diag on 4-plane: {supp}, spread={supp.max()-supp.min():.2e}, "
            f"offdiag={np.linalg.norm(off):.2e}  -> scalar on plane: "
            f"{supp.max()-supp.min() < 1e-13 and np.linalg.norm(off) < 1e-13}")
    # su(m) family
    for m in (2, 3, 4, 5):
        n = 2 * m
        core = Core(max(n, 6) if n >= 6 else 6)
        if core.n < n:
            core = Core(n)
        W = su_m_family(core, m)
        th = float(np.sum(W * core.Q(W)))
        res = np.linalg.norm(core.Q(W) - th * W)
        ev = evaluate_point(core, W, th, want_masses=False)
        th_pred = np.sqrt(m * (m + 1) / ((m + 2) * (m - 1)))
        d2_pred = (m + 2) / (12 * (m + 1))
        tach = np.sqrt(2) * np.sqrt(1 - ev['trS4'])
        log(f"  su({m}) n={core.n}: theta={th:.10f} (pred {th_pred:.10f}) res={res:.1e} "
            f"d2={ev['d2']:.10f} (pred {d2_pred:.10f}) trS4={ev['trS4']:.12f} "
            f"(1/4? {abs(ev['trS4']-0.25)<1e-12}) Tach={tach:.10f} "
            f"(sqrt(3/2)? {abs(tach-np.sqrt(1.5))<1e-10}) RHS={ev['rhs']:.8f} "
            f"slack={ev['slack']:+.2e}")
    log("CLAIM2 done")


# ---------------------------------------------------------------- claim 3: Hessian
def hessian_spectrum(n, check_fd=False):
    core = Core(n)
    m = n // 2
    log(f"HESS n={n} (m={m}) start")
    W = sphere_product(core, m)
    th = float(np.sum(W * core.Q(W)))
    res = np.linalg.norm(core.Q(W) - th * W)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    log(f"  W* critical: theta={th:.10f} (theta0={th0:.10f}), res={res:.2e}")
    N = core.N
    # Hessian of P on unit sphere: H -> 6 B(W,H) - 3 theta H, restricted+projected
    L = 0.5 * (np.kron(np.eye(N), W) + np.kron(W, np.eye(N))) + core.sharp_lin_mat(W)
    Hfull = 6.0 * L - 3.0 * th * np.eye(N * N)
    # projector onto Weyl \cap W-perp, inside vec space (sym part enforced by basis)
    V = core.weyl_basis()                       # (N^2, dW) orthonormal
    w = W.ravel() / np.linalg.norm(W.ravel())
    Vw = V - np.outer(w, w @ V)
    # orthonormalize the tangent basis
    Uq, s, _ = np.linalg.svd(Vw, full_matrices=False)
    k = int(np.sum(s > 1e-8))
    Tb = Uq[:, :k]
    M = Tb.T @ Hfull @ Tb
    M = 0.5 * (M + M.T)
    ev = np.linalg.eigvalsh(M)
    evn = ev / th0
    if check_fd:
        # finite-difference validation on 3 random tangent directions
        for _ in range(3):
            x = RNG.standard_normal(k)
            h = (Tb @ (x / np.linalg.norm(x))).reshape(N, N)
            h = 0.5 * (h + h.T)
            h /= np.linalg.norm(h)
            eps = 1e-4

            def Pval(Wm_):
                Wn = Wm_ / np.linalg.norm(Wm_)
                return float(np.sum(Wn * core.Q(Wn)))
            fd = (Pval(W + eps * h) - 2 * Pval(W) + Pval(W - eps * h)) / eps ** 2
            hv = h.ravel()
            quad = float(hv @ Hfull @ hv)
            log(f"  FD check: fd={fd:.8f} quad={quad:.8f} diff={abs(fd-quad):.2e}")
    # cluster eigenvalues
    tol = 1e-6
    clusters = []
    for x in evn:
        if clusters and abs(x - clusters[-1][0] / clusters[-1][1]) < 1e-5:
            s0, c0 = clusters[-1]
            clusters[-1] = (s0 + x, c0 + 1)
        else:
            clusters.append((x, 1))
    dist = [(s / c, c) for s, c in clusters]
    log(f"  tangent dim = {k} (expected dimWeyl-1 = {V.shape[1]-1})")
    log("  spectrum/theta0 clusters: " +
        ", ".join(f"{v:.6f} x{c}" for v, c in dist))
    # predictions
    pred = {0.0: m * m, -3.0 / (m - 1): (m - 1) * (m + 2),
            -3.0 * (m - 3) / (m - 1): m * (m - 1) ** 2 * (m) // 4}
    from math import comb
    pred = [(0.0, m * m), (-3.0 / (m - 1), (m - 1) * (m + 2)),
            (-3.0 * (m - 3) / (m - 1), comb(m, 2) ** 2), (-3.0, None),
            (-3.0 * (m + 1) / (m - 1), None)]
    log("  claimed: " + ", ".join(f"{v:.6f} x{c}" for v, c in pred))
    # match measured clusters against claimed values (with collisions merged)
    from collections import defaultdict
    want = defaultdict(int)
    known = 0
    for v, c in pred[:3]:
        want[round(v, 6)] += c
        known += c
    rest = k - known
    got = {round(v, 6): c for v, c in dist}
    log(f"  measured clusters: {json.dumps({str(a): b for a, b in got.items()})}")
    log(f"  check kernel: got {got.get(0.0, 0)} want {m*m} -> "
        f"{'OK' if got.get(0.0,0)==m*m else 'MISMATCH'}")
    for v, c in pred[1:3]:
        vv = round(v, 6)
        log(f"  check {vv} x{c}: measured x{got.get(vv,'?')} "
            f"{'OK' if got.get(vv,-1)==c or vv in [round(p[0],6) for p in pred if p is not (v,c)] else 'see merge'}")
    log(f"HESS n={n} done")
    return dist, k


def hessian_big(n):
    """sphere-pair Hessian for large n exploiting W* diagonal in the pair basis.
    Works in Sym(Lambda^2) coordinates (dim N(N+1)/2) with sparse operators."""
    import scipy.sparse as sp
    core = Core(n)
    m = n // 2
    N = core.N
    log(f"HESSBIG n={n} (m={m}) start: N={N}, symdim={N*(N+1)//2}")
    W = sphere_product(core, m)
    th = float(np.sum(W * core.Q(W)))
    offd = np.linalg.norm(W - np.diag(np.diag(W)))
    log(f"  theta={th:.10f}, res={np.linalg.norm(core.Q(W)-th*W):.1e}, "
        f"W offdiag={offd:.1e} (must be 0 for this route)")
    assert offd < 1e-12
    w = np.diag(W)
    # total antisymmetry check of c
    c = core.c
    ta = max(np.abs(c + c.transpose(0, 2, 1)).max(),
             np.abs(c - c.transpose(1, 2, 0)).max())
    log(f"  c total-antisymmetry residual: {ta:.1e}")
    # sym basis bookkeeping
    su, sv = np.triu_indices(N)
    ns = len(su)
    colid = np.full((N, N), -1, int)
    colid[su, sv] = np.arange(ns)
    colid[sv, su] = np.arange(ns)
    wt = np.where(su == sv, 1.0, np.sqrt(2.0))     # embedding weights
    # sharp part: W#H = 0.5 sum_g w_g A_g H A_g^T, (A_g)_{ae} = c[a,g,e] sparse
    rows, cols, vals = [], [], []
    for g in range(N):
        Ag = c[:, g, :]
        nz = np.argwhere(np.abs(Ag) > 1e-13)
        if not len(nz):
            continue
        for (a1, e1) in nz:
            for (a2, e2) in nz:
                if a1 > a2:
                    continue          # read output only at the ordered position
                r = colid[a1, a2]
                q = colid[e1, e2]
                v = 0.5 * w[g] * Ag[a1, e1] * Ag[a2, e2]
                rows.append(r)
                cols.append(q)
                vals.append(v * wt[r] / wt[q])
    Msh = sp.coo_matrix((vals, (rows, cols)), shape=(ns, ns)).tocsr()
    # validated against the dense generic route at n=8 below (action check).
    # anticommutator part is diagonal in sym coords: (w_a + w_b)/2
    diag_ac = 0.5 * (w[su] + w[sv])
    Hsym = 6.0 * (sp.diags(diag_ac) + Msh) - 3.0 * th * sp.identity(ns)
    Hsym = 0.5 * (Hsym + Hsym.T)
    # validation vs dense generic route at small n
    if n <= 8:
        L = 0.5 * (np.kron(np.eye(N), W) + np.kron(W, np.eye(N))) \
            + core.sharp_lin_mat(W)
        Hfull = 6.0 * L - 3.0 * th * np.eye(N * N)
        # direct check: apply both to random symmetric H
        for _ in range(3):
            Hr = rand_sym(core)
            x = Hr[su, sv] * wt
            y1 = Hsym @ x
            Y2 = (6.0 * (0.5 * (W @ Hr + Hr @ W) + core.sharp(W, Hr))
                  - 3.0 * th * Hr)
            y2 = Y2[su, sv] * wt
            log(f"  sparse-vs-dense action check: {np.linalg.norm(y1-y2):.2e}")
    # projector onto Weyl cap W-perp in sym coords (dense)
    log("  building projector columns...")
    t0 = time.time()
    P = np.eye(ns)
    # Alt part: apply alt_op columnwise (vectorized tensor round trip)
    ii = np.array([p[0] for p in core.pairs])
    jj = np.array([p[1] for p in core.pairs])

    def op_to_t4_fast(M):
        T = np.zeros((n, n, n, n))
        T[ii[:, None], jj[:, None], ii[None, :], jj[None, :]] = M
        T[jj[:, None], ii[:, None], ii[None, :], jj[None, :]] = -M
        T[ii[:, None], jj[:, None], jj[None, :], ii[None, :]] = -M
        T[jj[:, None], ii[:, None], jj[None, :], ii[None, :]] = M
        return T

    def t4_to_op_fast(T):
        return T[ii[:, None], jj[:, None], ii[None, :], jj[None, :]]

    # sanity of fast converters
    Hr = rand_sym(core)
    r = np.linalg.norm(t4_to_op_fast(op_to_t4_fast(Hr)) - Hr)
    log(f"  fast t4 converters roundtrip: {r:.1e}")
    AltP = np.zeros((ns, ns))
    RicM = np.zeros((n * n, ns))
    for q in range(ns):
        a, b = su[q], sv[q]
        E = np.zeros((N, N))
        E[a, b] = E[b, a] = 1.0 / wt[q]
        T = op_to_t4_fast(E)
        A4 = (T + T.transpose(0, 2, 3, 1) + T.transpose(0, 3, 1, 2)) / 3.0
        Ao = t4_to_op_fast(A4)
        AltP[:, q] = Ao[su, sv] * wt
        RicM[:, q] = np.einsum('ikjk->ij', T).ravel()
        if q % 2000 == 0 and time.time() - t0 > 120:
            log(f"  projector columns {q}/{ns}")
            t0 = time.time()
    # Ric* G^-1 Ric part
    log("  assembling projector...")
    # G^-1 on sym matrices: (h - tr(h)/(2n-2) I)/(n-2)
    # build RicStar columns from RicM^T? use adjointness: RicStar in sym coords
    # <RicStar(h), E_q>_sym = <h, Ric(E_q)>  -> RicStarM = RicM^T (as maps to/from
    # the n^2 vec of h with standard inner product)
    tr_vec = np.eye(n).ravel()
    Ginv = (np.eye(n * n) - np.outer(tr_vec, tr_vec) / (2 * n - 2)) / (n - 2)
    P = P - AltP - RicM.T @ Ginv @ RicM
    wsym = W[su, sv] * wt
    wsym /= np.linalg.norm(wsym)
    P = P - np.outer(wsym, wsym)
    # symmetrize & verify idempotency on a few vectors
    P = 0.5 * (P + P.T)
    x = RNG.standard_normal(ns)
    log(f"  projector idempotency: {np.linalg.norm(P@(P@x)-P@x)/np.linalg.norm(P@x):.1e}")
    log("  forming projected Hessian and eigendecomposing...")
    Mmat = P @ (Hsym @ P)
    Mmat = 0.5 * (Mmat + Mmat.T)
    ev = np.linalg.eigvalsh(Mmat)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    evn = np.sort(ev / th0)
    # cluster
    clusters = []
    for x in evn:
        if clusters and abs(x - clusters[-1][0] / clusters[-1][1]) < 1e-6:
            s0, c0 = clusters[-1]
            clusters[-1] = (s0 + x, c0 + 1)
        else:
            clusters.append((x, 1))
    dist = [(s / cnt, cnt) for s, cnt in clusters]
    dimW = N * (N + 1) // 2 - n * (n + 1) // 2 - \
        len(list(itertools.combinations(range(n), 4)))
    comp = ns - (dimW - 1)          # complement + W-direction: eigenvalue 0
    log(f"  dimWeyl={dimW}, tangent={dimW-1}, zero-from-projection={comp}")
    log("  spectrum/theta0 clusters: " +
        ", ".join(f"{v:.6f} x{cnt}" for v, cnt in dist))
    from math import comb
    log(f"  claimed: 0 x{m*m}(+{comp} projection zeros), "
        f"-3/(m-1)={-3/(m-1):.6f} x{(m-1)*(m+2)}, "
        f"-3(m-3)/(m-1)={-3*(m-3)/(m-1):.6f} x{comb(m,2)**2}, -3 x?, "
        f"-3(m+1)/(m-1)={-3*(m+1)/(m-1):.6f} x?")
    log(f"HESSBIG n={n} done")
    return dist


# ---------------------------------------------------------------- claim 4
def growth():
    log("GROWTH start: minimal faithful rep dims, real-form accounting")
    from math import comb
    # (complex) minimal nontrivial irrep dims + Frobenius-Schur type
    # type: R real, C complex, H quaternionic
    def su(r):   # su(r+1)
        return (r + 1, 'C') if r >= 2 else (2, 'H')
    def so_odd(r):  # so(2r+1)
        spin = 2 ** r
        vec = 2 * r + 1
        if spin < vec:
            typ = {1: 'H', 2: 'H'}.get(r % 4, '?')
            return (spin, typ)
        return (vec, 'R')
    def sp(r):
        return (2 * r, 'H')
    def so_even(r):  # so(2r)
        half = 2 ** (r - 1)
        vec = 2 * r
        if half < vec:
            typ = {0: 'R', 1: 'C', 2: 'H', 3: 'C'}.get(r % 4)  # spin type mod 8
            return (half, typ)
        return (vec, 'R')
    rows = []
    for r in range(2, 12):
        rows.append((f"su({r+1})", *su(r), r * (r + 2)))
        rows.append((f"so({2*r+1})", *so_odd(r), r * (2 * r + 1)))
        rows.append((f"sp({r})", *sp(r), r * (2 * r + 1)))
        if r >= 3:
            rows.append((f"so({2*r})", *so_even(r), r * (2 * r - 1)))
    exc = [("g2", 7, 'R', 14), ("f4", 26, 'R', 52), ("e6", 27, 'C', 78),
           ("e7", 56, 'H', 133), ("e8", 248, 'R', 248)]
    for name, dmin, typ, dimg in rows + exc:
        # real minimal orthogonal dim: R -> d, C -> 2d, H -> 2d... but for
        # tensor-product embeddings what matters is the product type.
        realmin = dmin if typ == 'R' else 2 * dmin
        log(f"  {name:9s} min cplx irrep {dmin:4d} type {typ} "
            f"(min real orthogonal ~{realmin:4d})  dim g = {dimg}")
    # tensor-product candidates k1 x k2 -> so(n): real iff type product is real
    # (RxR, HxH real; anything with C complex -> real dim doubles)
    log("  candidate check for the three FINDINGS examples:")
    log("   so(10)xso(20) vector x vector: R x R = R, n = 10*20 = 200 OK")
    log("   sp(5)xsp(10):  H x H = R, n = (2*5)*(2*10) = 200 OK")
    log("   su(9)xsp(11):  C x H = C, complex dim 9*22=198 -> REAL dim 396, "
        "so 'n=198' is NOT a real orthogonal embedding dimension (needs n=396)")
    # unboundedness with correct real accounting:
    cnt = 0
    for a in range(3, 30):
        for b in range(a, 40):
            if a * b <= 200:
                cnt += 1
    log(f"  so(a)xso(b) vector-vector real candidates with n=ab<=200: {cnt} "
        "(unbounded in n as claimed)")
    log("GROWTH done")


# ---------------------------------------------------------------- main
if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "validate"
    if cmd == "validate":
        validate()
    elif cmd == "catalog":
        catalog()
    elif cmd == "hunt":
        n = int(sys.argv[2])
        seeds = int(sys.argv[3]) if len(sys.argv) > 3 else 120
        hunt(n, seeds, out_prefix=_os.path.join(_ROOT, "agent_logs/review_r13"))
    elif cmd == "pinhunt":
        n = int(sys.argv[2])
        per = int(sys.argv[3]) if len(sys.argv) > 3 else 25
        pinhunt(n, per)
    elif cmd == "claim2":
        claim2()
    elif cmd == "hess":
        hessian_spectrum(int(sys.argv[2]), check_fd=(len(sys.argv) > 3))
    elif cmd == "hessbig":
        hessian_big(int(sys.argv[2]))
    elif cmd == "growth":
        growth()
    elif cmd == "combo":
        combo_attack()
    elif cmd == "hunt12b":
        hunt12b()
    else:
        print("unknown command", cmd)
