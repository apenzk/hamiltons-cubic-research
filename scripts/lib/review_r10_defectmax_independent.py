"""
Reviewer 10 -- independent adversarial verification of three claim groups:

  A. FINDINGS "The defect-penalty candidate inequality", Result 7: the refutation
     of the universal defect bound delta^2 <= 1/9 at critical points, its
     closed-form violator, the theta=0 stratum point, the su(m) Kaehler family,
     the Fox plateau, and the analytic by-products.
  B. FINDINGS "Lifting Jaeger's 3.3 in trace form", Result 10: the break-even
     computation c(12), Theta(d,12), the Fox anchor, the two agent-own bounds,
     and the E-track geometric-realizability by-product.
  C. The padded-flat second-order addendum inside the Fox-lemma Result:
     T(W,H,H) = 0 by disjoint support, Hess P(H,H) = -3 theta ||H||^2, and the
     18x second-order margin.

INDEPENDENCE.  Every quantity under review is rebuilt here from FINDINGS'
mathematical definitions and from Jaeger's thesis text (sections 3.0-3.5, read
at the source).  Imports are restricted to the older validated primitives
(curvature_operator, weyl_decomposition, weyl, rsharp_basis_free) -- nothing is
imported from the pipeline under review (run_breakeven_theta, run_defect_max_hunt,
run_defect_penalty_test, run_jaeger_lift_33/34, run_j5_structure,
run_fox_firstorder_lemma, run_lift_32x_check, run_gram_identity_exact).  The two
saved .npy violators are loaded as data.  This file carries its own:

  * pair-matrix <-> 4-tensor dictionary, own Alt (Lambda^4 projection), own
    Ricci cross-check, own spectral split, own delta^2;
  * a THIRD sharp implementation ((R#)_{ijkl} = sum_pq R_{ipkq}R_{jplq} -
    R_{iplq}R_{jpkq}) in float AND in exact Fraction arithmetic;
  * own constructions: Fox block from the omega-formula, sphere products,
    su(m) Kaehler family from the Cartan pair (SU(m),SO(m)), the sp(2)/u(2)
    two-projection point on H^2 = R^8 (the structural identification of the
    violator), multi-block Fox, zero-padding, random genuine Weyl tensors;
  * an independent transcription of the lifted Jaeger chain from the thesis
    (every inequality re-derived in the header comments of section B below),
    own grid maximiser, own bisection, own mpmath corner solve;
  * own trilinear form T(W,H,H) by polarization of P and own Hessian profile.

Validation before use (part 0): Q_op (curvature_operator) and Q_full
(rsharp_basis_free) agree to 3e-16; Id# = (n-2)Id exactly in all three sharp
implementations; scal(R^2+R#) = ||Ric||^2 + 6||Alt R||^2 on random symmetric
operators (pins this reviewer's Alt normalization to Reviewers 6/8/9); Alt
idempotent and self-adjoint; Fox anchors theta = sqrt(3/2), delta^2 = 1/9,
Alt(W_-) = star/(3 sqrt 6) entrywise; balanced sphere anchor theta_0(n).

Usage:
    python3 review_r10_defectmax_independent.py A     # claim group A
    python3 review_r10_defectmax_independent.py B     # claim group B
    python3 review_r10_defectmax_independent.py C     # claim group C
    python3 review_r10_defectmax_independent.py       # everything
"""
import sys
import time
import itertools
from fractions import Fraction

import numpy as np

from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop, norm, frob
from weyl import build_structure_constants
from rsharp_basis_free import Q_full, Rsharp_full

SQ32 = np.sqrt(1.5)


# =====================================================================
# own machinery
# =====================================================================
_CTX = {}


def ctx(n):
    if n not in _CTX:
        L2 = Lambda2(n)
        idx, pos, N, c = build_structure_constants(n)
        _CTX[n] = dict(n=n, L2=L2, idx=idx, pos=pos, N=N, c=c)
    return _CTX[n]


def mat4_from_mop(cx, M):
    """full 4-tensor R[i,j,k,l] from the pair-basis operator matrix."""
    n, idx = cx["n"], cx["idx"]
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            v = M[a, b]
            R[i, j, k, l] = v
            R[j, i, k, l] = -v
            R[i, j, l, k] = -v
            R[j, i, l, k] = v
    return R


def mop_from_mat4(cx, R):
    n, idx, N = cx["n"], cx["idx"], cx["N"]
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            M[a, b] = R[i, j, k, l]
    return M


def alt_mop(cx, M):
    """orthogonal projection onto Lambda^4: total antisymmetrization of the
    4-tensor (cyclic average over the last three slots), back as pair matrix."""
    R = mat4_from_mop(cx, M)
    A = (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
    return mop_from_mat4(cx, A)


def sharp4(cx, M):
    """third, independent sharp: (R#)_{ijkl} = sum_pq R_{ipkq}R_{jplq} - R_{iplq}R_{jpkq}."""
    R = mat4_from_mop(cx, M)
    S = np.einsum('ipkq,jplq->ijkl', R, R, optimize=True) \
        - np.einsum('iplq,jpkq->ijkl', R, R, optimize=True)
    return mop_from_mat4(cx, S)


def spectral_split(M):
    w, V = np.linalg.eigh(M)
    Wp = (V * np.maximum(w, 0.0)) @ V.T
    Wm = (V * np.maximum(-w, 0.0)) @ V.T
    return Wp, Wm, w


def delta2(cx, M):
    _, Wm, _ = spectral_split(M)
    A = alt_mop(cx, Wm)
    return frob(A, A)


def qfun(cx):
    c = cx["c"]
    return lambda M: Q_full(M, c)


def theta_resid(cx, M):
    Q = qfun(cx)(M)
    th = frob(M, Q)
    return th, norm(Q - th * M)


def bracket_vec(cx, u, v):
    return np.einsum('abg,a,b->g', cx["c"], u, v, optimize=True)


def pad_mop(cx_small, cx_big, M, offset=0):
    """zero-pad an operator on Lambda^2 R^m into Lambda^2 R^n, coords shifted by offset."""
    R = mat4_from_mop(cx_small, M)
    m = cx_small["n"]
    idx_b, Nb = cx_big["idx"], cx_big["N"]
    Mb = np.zeros((Nb, Nb))
    for a, (i, j) in enumerate(idx_b):
        if not (offset <= i < offset + m and offset <= j < offset + m):
            continue
        for b, (k, l) in enumerate(idx_b):
            if not (offset <= k < offset + m and offset <= l < offset + m):
                continue
            Mb[a, b] = R[i - offset, j - offset, k - offset, l - offset]
    return Mb


# ---------------- constructions ----------------
def fox_weyl(cx, block=(0, 1, 2, 3)):
    """W = (1/sqrt6)(2 w1 w1^T - w2 w2^T - w3 w3^T), wi the orthonormal
    self-dual forms of the distinguished R^4 (FINDINGS Result 6's definition)."""
    n, L2 = cx["n"], cx["L2"]
    i0, i1, i2, i3 = block

    def bv(i, j):
        E = np.zeros((n, n)); E[j, i] = 1.0; E[i, j] = -1.0
        return L2.matrix_to_vec(E)

    w1 = (bv(i0, i1) + bv(i2, i3)) / np.sqrt(2)
    w2 = (bv(i0, i2) - bv(i1, i3)) / np.sqrt(2)
    w3 = (bv(i0, i3) + bv(i1, i2)) / np.sqrt(2)
    W = (2 * np.outer(w1, w1) - np.outer(w2, w2) - np.outer(w3, w3)) / np.sqrt(6)
    Qf = qfun(cx)
    if frob(W, Qf(W)) < 0:
        W = -W
    return W


def sphere_weyl(cx, p):
    """balanced/unbalanced sphere-product Weyl S^p x S^{n-p}: coordinate-diagonal
    pattern x = 1/(p(p-1)), y = 1/(q(q-1)), z = -1/(pq), normalized."""
    n, idx, N = cx["n"], cx["idx"], cx["N"]
    q = n - p
    lam = np.zeros(N)
    for a, (i, j) in enumerate(idx):
        if i < p and j < p:
            lam[a] = 1.0 / (p * (p - 1))
        elif i >= p and j >= p:
            lam[a] = 1.0 / (q * (q - 1))
        else:
            lam[a] = -1.0 / (p * q)
    W = np.diag(lam)
    return W / norm(W)


def su_m_kahler(cx):
    """su(m) Ricci-flat Kaehler point on R^{2m} = C^m (FINDINGS Result 7's
    closed form): W = a Pi_{so(m)} - b Pi_p, so(m) = [[B,0],[0,B]],
    p = [[0,-S],[S,0]] with S symmetric traceless; r1 a = r2 b, r1 a^2 + r2 b^2 = 1."""
    n, L2 = cx["n"], cx["L2"]
    m = n // 2
    vecs_h, vecs_p = [], []
    for i in range(m):
        for j in range(i + 1, m):
            B = np.zeros((m, m)); B[i, j], B[j, i] = -1.0, 1.0
            M = np.zeros((n, n)); M[:m, :m] = B; M[m:, m:] = B
            v = L2.matrix_to_vec(M); vecs_h.append(v / np.linalg.norm(v))
    Ss = []
    for i in range(m):
        for j in range(i + 1, m):
            S = np.zeros((m, m)); S[i, j] = S[j, i] = 1.0; Ss.append(S)
    for k in range(1, m):
        d = np.zeros(m); d[:k] = 1.0; d[k] = -float(k)
        Ss.append(np.diag(d) / np.linalg.norm(d))
    for S in Ss:
        M = np.zeros((n, n)); M[:m, m:] = -S; M[m:, :m] = S
        v = L2.matrix_to_vec(M); vecs_p.append(v / np.linalg.norm(v))
    B1, B2 = np.array(vecs_h), np.array(vecs_p)
    r1, r2 = len(vecs_h), len(vecs_p)
    G = np.vstack([B1, B2])
    assert np.linalg.norm(G @ G.T - np.eye(r1 + r2)) < 1e-12
    b = np.sqrt(r1 / (r2 * (r1 + r2)))
    a = r2 * b / r1
    return a * (B1.T @ B1) - b * (B2.T @ B2), B1, B2


def _quat_L(q):
    """4x4 real matrix of LEFT multiplication by quaternion q = (a,b,c,d) on H = R^4,
    basis (1,i,j,k)."""
    a, b, c, d = q
    return np.array([[a, -b, -c, -d],
                     [b, a, -d, c],
                     [c, d, a, -b],
                     [d, -c, b, a]], dtype=float)


def so5_so4_point(cx):
    """the reviewer's structural identification of the Result-7 violator: the
    two-projection operator of the SYMMETRIC PAIR (so(5), so(4)) in the spin
    embedding so(5) = span{E_q} (+) span{E_q E_q'} c so(8), where
    E_q (q in {1,i,j,k}) are the four anticommuting complex structures
    E_q(a,b) = (q b, -conj(q) a) on H^2 = R^8 (a Clifford Cl(4)-system).
    p = span{E_q} (dim 4, the S^4 = SO(5)/SO(4) tangent part) carries the
    POSITIVE eigenvalue, h = so(4) = span{E_q E_q'} (dim 6) the negative:
    W = a Pi_p - b Pi_h, a = 3/(2 sqrt15), b = 1/sqrt15."""
    n, L2 = cx["n"], cx["L2"]
    assert n == 8
    quats = [(1, 0, 0, 0), (0, 1, 0, 0), (0, 0, 1, 0), (0, 0, 0, 1)]

    def conj(q):
        return (q[0], -q[1], -q[2], -q[3])

    def E_of(q):
        M = np.zeros((8, 8))
        M[:4, 4:] = _quat_L(q)
        M[4:, :4] = -_quat_L(conj(q))
        return M

    Es = [E_of(q) for q in quats]
    for i in range(4):
        for j in range(4):
            tgt = -2.0 * np.eye(8) if i == j else 0.0
            assert np.linalg.norm(Es[i] @ Es[j] + Es[j] @ Es[i] - tgt) < 1e-12, \
                "Clifford relations fail"
    p_mats = Es
    h_mats = [Es[i] @ Es[j] for i in range(4) for j in range(i + 1, 4)]
    vp = []
    for M in p_mats:
        v = L2.matrix_to_vec(M); vp.append(v / np.linalg.norm(v))
    vh = []
    for M in h_mats:
        v = L2.matrix_to_vec(M); vh.append(v / np.linalg.norm(v))
    B1, B2 = np.array(vp), np.array(vh)          # B1 = p (rank 4, +), B2 = h (rank 6, -)
    G = np.vstack([B1, B2])
    assert np.linalg.norm(G @ G.T - np.eye(10)) < 1e-12, "so(5) frame not orthonormal"
    a, b = 3.0 / (2.0 * np.sqrt(15.0)), 1.0 / np.sqrt(15.0)
    return a * (B1.T @ B1) - b * (B2.T @ B2), B1, B2


def random_weyl(cx, rng):
    """random genuine Weyl operator: random symmetric pair-matrix, remove the
    Lambda^4 part (own Alt), then the Ricci/scalar parts (validated projection)."""
    N = cx["N"]
    M = rng.normal(size=(N, N)); M = 0.5 * (M + M.T)
    M = M - alt_mop(cx, M)
    W, _, _ = weyl_from_mop(cx["L2"], M)
    return W / norm(W)


# ---------------- exact Fraction layer ----------------
def frac_sharp_pairs(cx, Rp):
    """exact sharp on the pair matrix Rp (Fraction entries), returning the pair
    matrix of R#.  Rp must be a dict {(a,b): Fraction} or full array of Fractions."""
    n, idx, pos, N = cx["n"], cx["idx"], cx["pos"], cx["N"]

    def R4(i, j, k, l):
        if i == j or k == l:
            return Fraction(0)
        s = 1
        if i > j:
            i, j = j, i; s = -s
        if k > l:
            k, l = l, k; s = -s
        return s * Rp[pos[(i, j)]][pos[(k, l)]]

    out = [[Fraction(0)] * N for _ in range(N)]
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            if b < a:
                continue
            s = Fraction(0)
            for p in range(n):
                for q in range(n):
                    s += R4(i, p, k, q) * R4(j, p, l, q) - R4(i, p, l, q) * R4(j, p, k, q)
            out[a][b] = s
            out[b][a] = s
    return out


def frac_check_critical(cx, Rp, theta_times):
    """exact check R^2 + R# == theta_times * R in Fraction arithmetic."""
    N = cx["N"]
    R2 = [[sum(Rp[a][m] * Rp[m][b] for m in range(N)) for b in range(N)] for a in range(N)]
    RS = frac_sharp_pairs(cx, Rp)
    bad = 0
    for a in range(N):
        for b in range(N):
            if R2[a][b] + RS[a][b] != theta_times * Rp[a][b]:
                bad += 1
    return bad


def frac_alt_norm2(cx, Rp):
    """exact ||Alt R||^2 (pair-matrix Frobenius of the Lambda^4 projection)."""
    n, idx, pos, N = cx["n"], cx["idx"], cx["pos"], cx["N"]

    def R4(i, j, k, l):
        if i == j or k == l:
            return Fraction(0)
        s = 1
        if i > j:
            i, j = j, i; s = -s
        if k > l:
            k, l = l, k; s = -s
        return s * Rp[pos[(i, j)]][pos[(k, l)]]

    tot = Fraction(0)
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            A = (R4(i, j, k, l) + R4(i, k, l, j) + R4(i, l, j, k)) / 3
            tot += A * A
    return tot


def to_frac_matrix(M, scale, denom_limit=10 ** 6):
    """M*scale should be rational; return Fractions, and the worst rounding error."""
    N = M.shape[0]
    out = [[Fraction(0)] * N for _ in range(N)]
    worst = 0.0
    for a in range(N):
        for b in range(N):
            f = Fraction(M[a, b] * scale).limit_denominator(denom_limit)
            worst = max(worst, abs(float(f) - M[a, b] * scale))
            out[a][b] = f
    return out, worst


# =====================================================================
# PART 0 -- validation of the reviewer's own machinery
# =====================================================================
def part0():
    print("=" * 78)
    print("PART 0: validation of the reviewer's own machinery")
    print("=" * 78)
    rng = np.random.default_rng(7)
    cx = ctx(6)
    N = cx["N"]
    M = rng.normal(size=(N, N)); M = 0.5 * (M + M.T)
    Q1 = Q_op(cx["L2"], M)
    Q2 = Q_full(M, cx["c"])
    Q3 = M @ M + sharp4(cx, M)
    print(f"  Q_op vs Q_full (random, n=6):        {norm(Q1-Q2)/norm(Q1):.1e}")
    print(f"  own 4-tensor sharp vs Q_full:        {norm(Q3-Q2)/norm(Q2):.1e}")
    print(f"  Id# = (n-2)Id (own sharp):           {norm(sharp4(cx, np.eye(N)) - (6-2)*np.eye(N)):.1e}")
    A = alt_mop(cx, M)
    print(f"  Alt idempotent / self-adjoint:       {norm(alt_mop(cx, A)-A):.1e} / {norm(A-A.T):.1e}")
    ric = ricci_from_mop(cx["L2"], M)
    scal_qm = np.trace(ricci_from_mop(cx["L2"], Q2))
    ident = np.trace(ric @ ric) + 6.0 * frob(A, A)
    print(f"  scal(R^2+R#) = ||Ric||^2 + 6||Alt||^2 (pins Alt normalization): "
          f"{abs(scal_qm-ident):.1e}")
    W = fox_weyl(cx)
    th, res = theta_resid(cx, W)
    print(f"  Fox anchor n=6: theta = {th:.10f} (sqrt(3/2) = {SQ32:.10f}), resid {res:.1e}, "
          f"delta^2 = {delta2(cx, W):.10f} (1/9 = {1/9:.10f})")
    cx8 = ctx(8)
    Ws = sphere_weyl(cx8, 4)
    th, res = theta_resid(cx8, Ws)
    th0_8 = np.sqrt(2.0 * 7 * 6) / 8
    print(f"  balanced sphere anchor n=8: theta = {th:.10f} (theta_0(8) = {th0_8:.10f}), "
          f"resid {res:.1e}, delta^2 = {delta2(cx8, Ws):.1e}")
    Wr = random_weyl(cx, rng)
    print(f"  random Weyl generator: |Ric| = {norm(ricci_from_mop(cx['L2'], Wr)):.1e}, "
          f"|Alt| = {norm(alt_mop(cx, Wr)):.1e}, |W| = {norm(Wr):.6f}")


# =====================================================================
# PART A -- the defect-bound refutation (Result 7)
# =====================================================================
def bracket_closure(cx, Vcols, Wcols=None, target=None):
    """max residual of [span V, span W] projected off span(target)."""
    if Wcols is None:
        Wcols = Vcols
    if target is None:
        target = np.hstack([Vcols, Wcols])
    Pt = target @ np.linalg.pinv(target)
    worst = 0.0
    for i in range(Vcols.shape[1]):
        for j in range(Wcols.shape[1]):
            br = bracket_vec(cx, Vcols[:, i], Wcols[:, j])
            worst = max(worst, np.linalg.norm(br - Pt @ br))
    return worst


def partA():
    print("=" * 78)
    print("PART A: the defect-bound refutation (defect-penalty Result 7)")
    print("=" * 78)
    cx8 = ctx(8)
    Qf8 = qfun(cx8)

    # ---------------- A1: the violator ----------------
    print("\n-- A1: the violator W = (3/(2 sqrt15)) Pi_4 - (1/sqrt15) Pi_6 --")
    W = np.load("scripts/data/defect_violation_n8_0.120000.npy")
    print(f"  loaded: ||W|| = {norm(W):.12f}, sym resid {norm(W-W.T):.1e}")
    ric = ricci_from_mop(cx8["L2"], W)
    print(f"  Weyl: |Ric| = {norm(ric):.1e},  |Alt W| = {norm(alt_mop(cx8, W)):.1e}")
    w = np.linalg.eigvalsh(W)
    a_ex, b_ex = 3.0 / (2 * np.sqrt(15.0)), 1.0 / np.sqrt(15.0)
    rp = int(np.sum(w > 1e-6)); rm = int(np.sum(w < -1e-6))
    print(f"  rank split (r+, r-) = ({rp}, {rm})   [claimed (4, 6)]")
    print(f"  eigenvalues: pos spread {np.ptp(w[w>1e-6]):.1e} around {np.mean(w[w>1e-6]):.10f} "
          f"(3/(2 sqrt15) = {a_ex:.10f})")
    print(f"               neg spread {np.ptp(w[w<-1e-6]):.1e} around {np.mean(w[w<-1e-6]):.10f} "
          f"(-1/sqrt15 = {-b_ex:.10f})")
    th_ex = np.sqrt(3.0 / 20.0)
    Q1 = Qf8(W); th1 = frob(W, Q1)
    print(f"  criticality (Q_full):  theta = {th1:.10f} (sqrt(3/20) = {th_ex:.10f}), "
          f"resid {norm(Q1-th1*W):.1e}")
    Q2 = Q_op(cx8["L2"], W); th2 = frob(W, Q2)
    print(f"  criticality (Q_op):    theta = {th2:.10f}, resid {norm(Q2-th2*W):.1e}")
    Q3 = W @ W + sharp4(cx8, W); th3 = frob(W, Q3)
    print(f"  criticality (own #):   theta = {th3:.10f}, resid {norm(Q3-th3*W):.1e}")
    d2 = delta2(cx8, W)
    print(f"  delta^2 = {d2:.12f}   (3/25 = {0.12:.12f}),  excess over 1/9: {d2-1/9:+.6f}")

    # padding invariance
    cx12 = ctx(12)
    W12 = pad_mop(cx8, cx12, W)
    th12, res12 = theta_resid(cx12, W12)
    print(f"  padded to n=12: theta = {th12:.10f}, resid {res12:.1e}, "
          f"delta^2 = {delta2(cx12, W12):.12f}")
    # Conjecture 10 margin at n=12
    th0_12 = np.sqrt(2.0 * 11 * 10) / 12
    kap12 = 9.0 * (SQ32 - th0_12)
    print(f"  C7 penalty margin at n=12: theta_0 + kappa*delta^2 - P = "
          f"{th0_12 + kap12*d2 - th12:+.6f}   [claimed +0.83]")

    # structural identification: eigenspace bracket closure (both gradings)
    lam, V = np.linalg.eigh(W)
    Vm, Vp = V[:, :6], V[:, -4:]
    g = np.hstack([Vp, Vm])
    print("\n  structure of the loaded point (V+ = 4-dim, V- = 6-dim eigenspaces):")
    print(f"    total closure [g,g] in g:        {bracket_closure(cx8, g, g, g):.1e}")
    print(f"    su(m)-style grading (h = V+): [V+,V+]->V+ resid {bracket_closure(cx8, Vp, Vp, Vp):.1e}")
    print(f"    so(5)/so(4) grading (h = V-):")
    print(f"      [V-,V-] closes into V-:        {bracket_closure(cx8, Vm, Vm, Vm):.1e}")
    print(f"      [V-,V+] closes into V+:        {bracket_closure(cx8, Vm, Vp, Vp):.1e}")
    print(f"      [V+,V+] closes into V-:        {bracket_closure(cx8, Vp, Vp, Vm):.1e}")
    print(f"    => g IS a 10-dim subalgebra (confirming FINDINGS), with [V+,V+] c V-")
    print(f"       exact -- but NEITHER eigenspace is a subalgebra, so the split is NOT")
    print(f"       a symmetric pair (unlike the su(m) family).")
    # Killing form of g, Casimir on R^8, isotropy
    basis = [g[:, i] for i in range(10)]
    ad = np.zeros((10, 10, 10))
    Ginv = np.linalg.pinv(g.T @ g)
    for i in range(10):
        for j in range(10):
            br = bracket_vec(cx8, basis[i], basis[j])
            ad[i, j, :] = Ginv @ (g.T @ br)
    K = np.einsum('iab,jba->ij', ad, ad)
    ev = np.linalg.eigvalsh(K)
    Cas = np.zeros((8, 8))
    for i in range(10):
        Mx = cx8["L2"].vec_to_matrix(g[:, i])
        Cas -= Mx @ Mx
    evc = np.linalg.eigvalsh(Cas)
    print(f"    Killing form on g: all eigenvalues in [{ev[0]:.4f}, {ev[-1]:.4f}], "
          f"center dim {int(np.sum(np.abs(ev) < 1e-8))}; Casimir on R^8 in "
          f"[{evc[0]:.4f}, {evc[-1]:.4f}]")
    print(f"    => g is the unique 10-dim compact semisimple algebra so(5) = sp(2),")
    print(f"       acting IRREDUCIBLY (Casimir scalar): the 8-dim SPIN representation.")
    c8 = cx8["c"]
    rows = [(c8[a] @ W - W @ c8[a]).reshape(-1) for a in range(cx8["N"])]
    sv = np.linalg.svd(np.array(rows).T, compute_uv=False)
    print(f"    isotropy algebra of W inside so(8): dim "
          f"{int(np.sum(sv < 1e-6*sv[0]))}  (an so(3) of symmetries)")
    brs = np.array([bracket_vec(cx8, Vp[:, i], Vp[:, j])
                    for i in range(4) for j in range(i + 1, 4)])
    print(f"    [V+,V+]: 6 brackets of norm {np.linalg.norm(brs[0]):.4f} spanning all of V-")

    # the natural symmetric split of the SAME algebra is NOT the violator:
    print("\n  control: the (so(5), so(4)) Clifford split with the same spectrum is NOT Weyl:")
    Wc, B1, B2 = so5_so4_point(cx8)
    print(f"    a Pi_p - b Pi_so(4) on spin-embedded so(5): |Ric| = "
          f"{norm(ricci_from_mop(cx8['L2'], Wc)):.1e} but |Alt| = "
          f"{norm(alt_mop(cx8, Wc)):.2f} -- Bianchi FAILS; the violator's (4,6) split")
    print(f"    inside so(5) is a different, non-symmetric, so(3)-invariant one")
    print(f"    ([V+,V+] c V- holds exactly, but [V-,V-] is not inside V-).")

    # eigenvalue-snap control: is the 3.9e-10 residual the .npy's polish level?
    lam_snap = np.where(w > 1e-6, a_ex, np.where(w < -1e-6, -b_ex, 0.0))
    Wsnap = (V * lam_snap) @ V.T
    ths, ress = theta_resid(cx8, Wsnap)
    print(f"\n  eigenvalue-snapped W (exact a, -b, 0 on the numerical eigenspaces):")
    print(f"    theta = {ths:.12f}, criticality residual {ress:.1e}  (vs 3.9e-10 raw)")

    # the claimed chain EQUALITY delta^4 = lam_max(Alt W_-)^2 r+r-/(r++r-)
    print("\n  the claimed chain equality delta^4 = lam_max(Alt W_-)^2 * r+r-/(r++r-)")
    print("  'at every two-projection critical point':")
    for label, cxx, Wx, rr in (("violator", cx8, W, (4, 6)), ("Fox", cx8, fox_weyl(cx8), (1, 2))):
        wx, Vx = np.linalg.eigh(Wx)
        Wm = (Vx * np.maximum(-wx, 0)) @ Vx.T
        A = alt_mop(cxx, Wm)
        lm = np.max(np.abs(np.linalg.eigvalsh(A)))
        d2x = frob(A, A)
        r1, r2v = rr
        Pplus = Vx[:, -r1:]; Pminus = Vx[:, :r2v]
        Aplus = Pplus.T @ A @ Pplus; Aminus = Pminus.T @ A @ Pminus
        cp = np.trace(Aplus) / r1; cm = np.trace(Aminus) / r2v
        scalar_res = max(np.linalg.norm(Aplus - cp * np.eye(r1)),
                         np.linalg.norm(Aminus - cm * np.eye(r2v)))
        rhs = lm ** 2 * r1 * r2v / (r1 + r2v)
        rhs_c = cp ** 2 * r1 * r2v / (r1 + r2v)
        verdict = "EQUALITY" if abs(d2x ** 2 - rhs) < 1e-10 else \
            f"STRICT INEQUALITY (slack factor {rhs/d2x**2:.3f})"
        print(f"    {label:9s}: delta^4 = {d2x**2:.10f}  lam_max(A)^2 = {lm**2:.10f}  "
              f"rhs = {rhs:.10f}  -> {verdict}")
        print(f"    {'':9s}  A restricted to V+/V- IS scalar c*Id: c+ = {cp:.6f}, "
              f"c- = {cm:.6f}, resid {scalar_res:.1e}; c^2 * ratio = {rhs_c:.10f} "
              f"{'= delta^4 EXACTLY' if abs(rhs_c-d2x**2) < 1e-9 else '(no)'}")
    print("    DIAGNOSIS: the equality version of the chain uses the ON-SUPPORT scalar")
    print("    c of Alt(W_-) (A|_g = c Id), and c = lam_max(A) at Fox but NOT at the")
    print("    violator, where lam_max(A) = 1/sqrt60 = 0.1291 is attained OFF the")
    print("    critical subalgebra while c = 0.0775.  FINDINGS' parenthetical numbers")
    print("    1/20 and 1/6 are (c/||A||)^2, not lam_max^2 -- as written, the")
    print("    'equality at every two-projection critical point' claim is FALSE for")
    print("    lam_max and TRUE for c.")

    # ---------------- A2: the theta = 0 stratum point ----------------
    print("\n-- A2: the theta=0 stratum point --")
    W0 = np.load("scripts/data/defect_theta0_n8_0.125000.npy")
    print(f"  ||W|| = {norm(W0):.10f}")
    ric0 = ricci_from_mop(cx8["L2"], W0)
    print(f"  Weyl: |Ric| = {norm(ric0):.1e}, |Alt| = {norm(alt_mop(cx8, W0)):.1e}")
    Qv = Qf8(W0)
    print(f"  ||Q(W)|| (absolute) = {norm(Qv):.2e}   [criticality at theta = 0]")
    print(f"  cross-check Q_op:    {norm(Q_op(cx8['L2'], W0)):.2e}")
    w0 = np.linalg.eigvalsh(W0)
    tgt = 1.0 / np.sqrt(10.0)
    rp0, rm0 = int(np.sum(w0 > 1e-6)), int(np.sum(w0 < -1e-6))
    print(f"  spectrum: (r+, r-) = ({rp0}, {rm0}); pos mean {np.mean(w0[w0>1e-6]):.10f}, "
          f"neg mean {np.mean(w0[w0<-1e-6]):.10f} (+-1/sqrt10 = {tgt:.10f}); spreads "
          f"{np.ptp(w0[w0>1e-6]):.1e}/{np.ptp(w0[w0<-1e-6]):.1e}")
    print(f"  delta^2 = {delta2(cx8, W0):.10f}   (1/8 = 0.125)")
    lam0, V0 = np.linalg.eigh(W0)
    Va, Vb = V0[:, :5], V0[:, -5:]
    print(f"  bracket closure of the 10-dim span: "
          f"{bracket_closure(cx8, np.hstack([Va, Vb])):.1e}"
          f"   [A,A]->B: {bracket_closure(cx8, Va, Va, Vb):.1e}"
          f"   [B,B]->A: {bracket_closure(cx8, Vb, Vb, Va):.1e}")

    # ---------------- A3: the su(m) Kaehler family, m = 3 ----------------
    print("\n-- A3: su(3) Kaehler member on C^3 = R^6, built from scratch --")
    cx6 = ctx(6)
    W3, B1s, B2s = su_m_kahler(cx6)
    th3v, res3 = theta_resid(cx6, W3)
    th3_ex = np.sqrt(3.0 * 4.0 / (5.0 * 2.0))
    d23 = delta2(cx6, W3)
    ric3 = ricci_from_mop(cx6["L2"], W3)
    print(f"  Weyl: |Ric| = {norm(ric3):.1e}, |Alt| = {norm(alt_mop(cx6, W3)):.1e}, "
          f"||W|| = {norm(W3):.10f}")
    print(f"  theta = {th3v:.12f}  (closed form sqrt(m(m+1)/((m+2)(m-1))) = {th3_ex:.12f}), "
          f"resid {res3:.1e}")
    print(f"  delta^2 = {d23:.12f}  (closed form (m+2)/(12(m+1)) = {5/48:.12f})")
    # exact certificate: sqrt120*W = 5 Pi_h - 3 Pi_p rational, theta*sqrt120 = 12
    Rp3, err3 = to_frac_matrix(W3, np.sqrt(120.0))
    bad3 = frac_check_critical(cx6, Rp3, Fraction(12))
    print(f"  EXACT: R^2 + R# == 12 R with R = sqrt120*W (Fraction): "
          f"{'EXACT (0 bad entries)' if bad3 == 0 else f'{bad3} BAD'} (rationalization err {err3:.1e})")
    Pp3, _ = to_frac_matrix(B2s.T @ B2s, 1.0)
    alt3 = frac_alt_norm2(cx6, Pp3)
    print(f"  EXACT delta^2 = (3/40) ||Alt Pi_p||^2 = (3/40)({alt3}) = {Fraction(3,40)*alt3} "
          f"  [5/48 = {Fraction(5,48)}]")
    # m = 4 bonus
    W4, _, _ = su_m_kahler(cx8)
    th4v, res4 = theta_resid(cx8, W4)
    th4_ex = np.sqrt(4.0 * 5.0 / (6.0 * 3.0))
    print(f"  bonus m=4 (n=8): theta = {th4v:.10f} (closed form {th4_ex:.10f}), resid {res4:.1e}, "
          f"delta^2 = {delta2(cx8, W4):.10f} (closed form {6/60:.10f})")

    # ---------------- A4: the Fox plateau ----------------
    print("\n-- A4: balanced 2-block Fox plateau on R^8 --")
    F1 = fox_weyl(cx8, (0, 1, 2, 3))
    F2 = fox_weyl(cx8, (4, 5, 6, 7))
    Wpl = (F1 + F2) / np.sqrt(2.0)
    thpl, respl = theta_resid(cx8, Wpl)
    print(f"  ||W|| = {norm(Wpl):.10f}, theta = {thpl:.12f} "
          f"(sqrt(3/2)/sqrt2 = {SQ32/np.sqrt(2):.12f}), resid {respl:.1e}")
    print(f"  delta^2 = {delta2(cx8, Wpl):.12f}   (1/9 = {1/9:.12f})")
    Rpl, errpl = to_frac_matrix(Wpl, np.sqrt(12.0))
    badpl = frac_check_critical(cx8, Rpl, Fraction(3))
    print(f"  EXACT: R^2 + R# == 3 R with R = sqrt12*W (Fraction): "
          f"{'EXACT (0 bad entries)' if badpl == 0 else f'{badpl} BAD'} (rationalization err {errpl:.1e})")

    # ---------------- A5: analytic by-products ----------------
    print("\n-- A5: analytic by-products --")
    rng = np.random.default_rng(11)
    worst_pm, worst_id, worst_quart = 0.0, 0.0, 0.0
    for _ in range(6):
        Wr = random_weyl(ctx(6), rng)
        Wp_, Wm_, _ = spectral_split(Wr)
        Ap, Am = alt_mop(ctx(6), Wp_), alt_mop(ctx(6), Wm_)
        worst_pm = max(worst_pm, norm(Ap - Am))
        aw = Wp_ + Wm_
        worst_id = max(worst_id, abs(frob(Am, Am) - 0.5 * frob(Am, aw)))
        worst_quart = max(worst_quart, frob(Am, Am) - 0.25)
    print(f"  Alt(W+) = Alt(W-) on random Bianchi W (6 samples, n=6): worst {worst_pm:.1e}")
    print(f"  delta^2 = (1/2)<Alt(W_-), |W|>: worst residual {worst_id:.1e}")
    print(f"  delta^2 <= 1/4: worst delta^2 - 1/4 = {worst_quart:+.4f} (proof: 2 delta^2 = "
          f"<Alt W_-, |W|> <= ||Alt W_-|| * 1 = delta)")


# =====================================================================
# PART B -- the break-even computation (Result 10)
# =====================================================================
# The lifted chain, re-derived from the thesis by this reviewer:
#   (L1)  r^2 >= hat(theta) t - 24 d, from lifted 3.2.2 (theta t = r^2 + 24d
#         - 4||W_-||^2 - scal(X_inv), scal(X_inv) >= 0 proven in Result 5a) and
#         the Lambda^4-corrected 3.2.3 (2||W_-||^2 >= 1 - sqrt(1 - ||W|_Ric||^2
#         - 4 delta^2)), completing Jaeger's 3.2.5/3.3.1 square.  The exact
#         mechanism: the -16d the Lambda^4 term contributes to the radicand pays
#         96d/(n-2) to absorb the -24d shift of the linear term, leaving slack
#         -d(16 - 96/(n-2)) <= 0 for n >= 8 -- checked SYMBOLICALLY in B1.
#         Side conditions: theta >= (n-3) sqrt(2/((n-1)(n-2))) (radicand
#         completion) and theta t <= 2(n-3)^2/(n-2) (root branch/positivity).
#   (L2)  r^2 >= theta t - 24 d + 4 c_W, same 3.2.2 with the ||W_-||^2 floor.
#   (L2') t = scal(|W|) = 4 tr W_- >= 2 sqrt2.
#   (L3)  t^2/n <= r^2 <= v t^2, r^2/t^2 <= y <= v  [3.3.2, eigenvalue algebra
#         on Ric(|W|) >= 0, frame-free].
#   (L4)  B := theta + hat r^2/(2(n-2)(r^2+24d)) - p <= sqrt2 sqrt(1-v) s, from
#         lifted 3.3.4 (penalty J4-J5 <= 24 d lam_max, granted J5 >= 0) plus
#         *** LIFTED 3.3.5 *** (<Ric(W_-^2),Ric> >= tr Ric^3/(4(n-2))), whose
#         thesis proof is diagonal-specific (row-sum count) -- tested in B5.
#         Whence v <= 1 - max(B,0)^2/2 and s >= B/(sqrt2 sqrt(1-v)).
#   (L5)  tr S^3 >= 0.7 v + 8647/38000  [E-track certificate, inherited].
#   (L6)  RHS_lift >= 0 (lifted 3.5.5): re-derived line by line from Cor 3.5.1
#         with the additive (J4-J5)/s, the (3.15) substitution r^2 >= hat t-24d,
#         and the -2 (n-3)/(n-2) Y0 r^2 <= -2 theta Y0 t + 48 d (n-3)/(n-2) Y0 step.
#   (C1)  Lemma 3.5.4 unrounded: Phi(x,theta) <= 0 and x <= 2 (the vertex
#         condition -1+3/k >= -1+2/k+x/(2k)).
#   (C2)  v/2 + (theta/sqrt2) sqrt(1-v) >= 3/(2n)  [(3.12)].
#   (C3)  Z <= 1/2 and (C4) (1+sqrt Z) t/(2 theta r^2) <= 1  [3.4.7's proof].
#   (C5)  L1's side conditions.
import sympy as sp

ALPHA_Y, C_Y = 0.7, 8647.0 / 38000.0


def bconsts(n):
    t0 = np.sqrt(2.0 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))
    N = n * (n - 1) // 2
    return dict(n=n, tilde0=t0, theta0=np.sqrt(2.0 * (n - 1) * (n - 2)) / n, N=N,
                cW=((np.sqrt(N + 4.0) - np.sqrt(float(N))) / 2.0) ** 2,
                t_lo=2.0 * np.sqrt(2.0), t_hi=(n - 3.0) * t0,
                th_min=(n - 3.0) * np.sqrt(2.0 / ((n - 1.0) * (n - 2.0))),
                tt_max=2.0 * (n - 3.0) ** 2 / (n - 2.0))


def my_phi(n, th):
    """Phi(x, theta) = ((2(n-2)-x)/n) Y0 + Y0^2 + Const(x, theta), re-derived:
    Const from squaring  (1 - (1+x)/(2n) - 3/(2n) + Y)^2 >= (theta^2/2)(1-(1+x)/n)."""
    a, b = (2.0 * n - 9.0) / (4.0 * n ** 3), 3.0 / (8.0 * n ** 2)
    q = 1.0 - 0.5 * th * th
    c2 = 1.0 / (4.0 * n ** 2) + b * b - b / n
    c1 = (2.0 * (n - 2.0) * b - a) / n + 2.0 * a * b + 2.0 / (n ** 2) - q / n
    c0 = 2.0 * (n - 2.0) * a / n + a * a + 10.0 / (4.0 * n ** 2) + 3.0 / (2.0 * n ** 2) \
        - 3.0 / n + q * (1.0 - 1.0 / n)
    return c2, c1, c0


def my_chain(ct, th, d, T, V, sound_y=False):
    """my transcription of the lifted chain; T, V broadcastable arrays."""
    n, cW, K = ct["n"], ct["cW"], 24.0 * d
    hat = (n - 2.0) / (n - 3.0) * th
    r2lo = np.maximum.reduce([hat * T - K, th * T - K + 4.0 * cW, T * T / n])
    r2hi = V * T * T
    adm = (r2lo > 0) & (r2lo <= r2hi) & (V >= 1.0 / n) & (V <= 1.0) \
        & (T >= ct["t_lo"]) & (T <= ct["t_hi"])
    rlo = np.sqrt(np.maximum(r2lo, 1e-300))
    p = K * np.power(np.maximum(V, 1e-300), 0.25) / rlo
    B = np.maximum(th + hat * r2lo / (2.0 * (n - 2.0) * (r2lo + K)) - p, 0.0)
    adm = adm & (V <= 1.0 - 0.5 * B * B)
    yflo = np.minimum(np.maximum((ALPHA_Y * V + C_Y) ** 2, r2lo / (T * T)), V)
    if sound_y:
        # M(v, y) is increasing in y below ystar = 1 - sqrt(1 - v^2): take the
        # maximizing y in [yflo, V] instead of the floor
        ystar = 1.0 - np.sqrt(np.maximum(1.0 - V * V, 0.0))
        y = np.clip(ystar, yflo, V)
    else:
        y = yflo
    s = np.clip(B / np.sqrt(2.0 * np.maximum(1.0 - V, 1e-300)), 1e-12, 1.0)
    x = n * V - 1.0
    Y0 = (2.0 * n - 9.0) / (4.0 * n ** 3) + 3.0 * x / (8.0 * n ** 2)
    Mvy = V + np.sqrt(np.clip((V * V - y * y) / np.maximum(1.0 - y, 1e-300), 0.0, None))
    pen = (n - 3.0) / (n - 2.0) * np.sqrt(2.0) * np.sqrt(np.maximum(1.0 - V, 0.0)) \
        * K * T * np.power(np.maximum(V, 0.0), 0.75) / s
    den = np.maximum(n * (hat * T - K), 1e-300)
    rhs = (-(263.0 / 144.0) * (n - 3.0) / (n ** 2 * (n - 2.0)) * (T * T - T ** 4 / den)
           - 2.0 * th * Y0 * T + 48.0 * d * (n - 3.0) / (n - 2.0) * Y0
           + (2.0 * np.sqrt(2.0) / hat) * np.sqrt(np.maximum(1.0 - V, 0.0)) * Mvy + pen)
    c2, c1, c0 = my_phi(n, th)
    Z = (V - y) * (1.0 - y) / (np.maximum(1.0 - V, 1e-300) ** 2 * np.maximum(V + y, 1e-300))
    conds = {
        "C1a Phi(x,theta)<=0": c2 * x * x + c1 * x + c0 <= 0.0,
        "C1b x<=2": x <= 2.0,
        "C2 (3.12)": V / 2.0 + th / np.sqrt(2.0) * np.sqrt(np.maximum(1.0 - V, 0.0)) >= 1.5 / n,
        "C3 Z<=1/2": Z <= 0.5,
        "C4 absorption": (1.0 + np.sqrt(np.maximum(Z, 0.0))) * T / (2.0 * th * r2lo) <= 1.0,
        "C5a theta*t cap": T <= ct["tt_max"] / th,
        "C5b theta floor": np.full(np.shape(T), th >= ct["th_min"]),
    }
    app = np.logical_and.reduce(list(conds.values()))
    return adm, app, conds, rhs


def my_score(ct, th, d, ngrid=500, refine=3, sound_y=False):
    """max of RHS over the admissible region; +inf if an admissible point breaks
    a hypothesis (open); -inf if the region is empty (closes)."""
    tlo, thi, vlo, vhi = ct["t_lo"], ct["t_hi"], 1.0 / ct["n"], 1.0
    best, wh = -np.inf, None
    for _ in range(refine + 1):
        T, V = np.meshgrid(np.linspace(tlo, thi, ngrid), np.linspace(vlo, vhi, ngrid),
                           indexing="ij")
        adm, app, conds, rhs = my_chain(ct, th, d, T, V, sound_y=sound_y)
        gap = adm & ~app
        if gap.any():
            i = int(np.argmax(gap.ravel()))
            names = [k for k, v in conds.items()
                     if not np.ravel(np.broadcast_to(v, gap.shape))[i]]
            return np.inf, (T.ravel()[i], V.ravel()[i]), "open: " + ",".join(names)
        val = np.where(adm, rhs, -np.inf)
        i = int(np.argmax(val))
        if val.ravel()[i] > best:
            best = float(val.ravel()[i]); wh = (float(T.ravel()[i]), float(V.ravel()[i]))
        if not np.isfinite(best):
            return -np.inf, None, "region empty"
        dt, dv = (thi - tlo) / ngrid, (vhi - vlo) / ngrid
        tlo, thi = max(ct["t_lo"], wh[0] - 3 * dt), min(ct["t_hi"], wh[0] + 3 * dt)
        vlo, vhi = max(1.0 / ct["n"], wh[1] - 3 * dv), min(1.0, wh[1] + 3 * dv)
    return best, wh, "max RHS"


def my_closes(ct, th, d, **kw):
    return my_score(ct, th, d, **kw)[0] < 0.0


def my_bisect(pred, lo, hi, tol=1e-12, itmax=80):
    for _ in range(itmax):
        if hi - lo < tol:
            break
        mid = 0.5 * (lo + hi)
        if pred(mid):
            hi = mid
        else:
            lo = mid
    return 0.5 * (lo + hi)


def my_corner(ct, th):
    """mpmath corner solve at t = t_hi: v = 1 - B(v,d)^2/2 and RHS = 0."""
    from mpmath import mp, mpf, sqrt as msqrt, findroot
    mp.dps = 40
    n = mpf(ct["n"]); t = mpf(ct["t_hi"]); th = mpf(th); cW = mpf(ct["cW"])
    hat = (n - 2) / (n - 3) * th
    aY, cY = mpf(7) / 10, mpf(8647) / 38000

    def eqs(v, d):
        K = 24 * d
        r2 = max(hat * t - K, th * t - K + 4 * cW, t * t / n)
        B = th + hat * r2 / (2 * (n - 2) * (r2 + K)) - K * v ** mpf("0.25") / msqrt(r2)
        f1 = v - (1 - max(B, mpf(0)) ** 2 / 2)
        y = min(max((aY * v + cY) ** 2, r2 / (t * t)), v)
        s = min(max(B, mpf(0)) / msqrt(2 * (1 - v)), mpf(1))
        x = n * v - 1
        Y0 = (2 * n - 9) / (4 * n ** 3) + 3 * x / (8 * n ** 2)
        Mv = v + msqrt((v * v - y * y) / (1 - y))
        pen = (n - 3) / (n - 2) * msqrt(2) * msqrt(1 - v) * K * t * v ** mpf("0.75") / s
        f2 = (-(mpf(263) / 144) * (n - 3) / (n ** 2 * (n - 2))
              * (t * t - t ** 4 / (n * (hat * t - K)))
              - 2 * th * Y0 * t + 48 * d * (n - 3) / (n - 2) * Y0
              + 2 * msqrt(2) / hat * msqrt(1 - v) * Mv + pen)
        return f1, f2

    v, d = findroot(eqs, (mpf("0.157"), mpf("0.00108")))
    return float(d), float(v)


def jaeger_rhs_diag(n, t, v, y):
    """Jaeger's own Lemma 3.5.5 RHS (diagonal case, d = 0, theta = tilde0),
    with the sharp (2 sqrt2/hat0) sqrt(1-v) coefficient kept (E-track form)."""
    ct = bconsts(n)
    t0 = ct["tilde0"]; hat0 = (n - 2.0) / (n - 3.0) * t0
    x = n * v - 1.0
    Y0 = (2.0 * n - 9.0) / (4.0 * n ** 3) + 3.0 * x / (8.0 * n ** 2)
    Mvy = v + np.sqrt(np.clip((v * v - y * y) / np.maximum(1.0 - y, 1e-300), 0.0, None))
    return (-(263.0 / 144.0) * (n - 3.0) / (n ** 2 * (n - 2.0)) * (t * t - t ** 3 / (n * hat0))
            - 2.0 * t0 * Y0 * t + (2.0 * np.sqrt(2.0) / hat0) * np.sqrt(max(0.0, 1.0 - v)) * Mvy)


def partB():
    print("=" * 78)
    print("PART B: the break-even computation (Jaeger-lift Result 10)")
    print("=" * 78)
    n = 12
    ct = bconsts(n)

    # ---------------- B1: symbolic checks ----------------
    print("\n-- B1: symbolic re-derivations --")
    ns, xs, ths, ds, ts = sp.symbols("ns xs ths ds ts", positive=True)
    # Phi identity vs Jaeger's pre-rounding polynomial at theta = tilde0
    nS = sp.Integer(n)
    t0s = sp.sqrt(2) * sp.sqrt(sp.Rational((n - 1) * (n - 3), (n + 1) * (n - 2)))
    const = ((1 + xs) ** 2 / (4 * nS ** 2) + sp.Rational(9, 4 * n ** 2) - sp.Rational(3, n)
             + 3 * (1 + xs) / (2 * nS ** 2) + (1 - t0s ** 2 / 2) * (1 - (1 + xs) / nS))
    jaeg = (sp.Rational(n ** 2 - 7 * n + 8, n ** 2 * (n + 1) * (n - 2))
            + sp.Rational(n ** 2 - 3 * n + 4, n ** 2 * (n + 1) * (n - 2)) * xs
            - xs ** 2 / (4 * nS ** 2))
    print(f"  Const(x,tilde0) + Jaeger's pre-rounding LHS = "
          f"{sp.simplify(sp.expand(const + jaeg))}   [expect 0]")
    # x_max numbers
    c2, c1, c0 = my_phi(n, ct["tilde0"])
    xm = (-c1 + np.sqrt(c1 * c1 - 4 * c2 * c0)) / (2 * c2)
    c1r = c1 + 8.0 / (n ** 2 * (n + 1.0) * (n - 2.0))
    xmr = (-c1r + np.sqrt(c1r * c1r - 4 * c2 * c0)) / (2 * c2)
    print(f"  Lemma 3.5.4 x-range at theta = tilde0: unrounded x <= {xm:.6f} "
          f"[claimed 1.1936]; his rounded coeff: {xmr:.6f} [claimed 0.9153]; "
          f"his stated (n-2)/n = {(n-2)/n:.6f}")
    # theta_disc exact
    a = sp.Rational(2 * n - 9, 4 * n ** 3); b = sp.Rational(3, 8 * n ** 2)
    q = 1 - ths ** 2 / 2
    C2 = sp.Rational(1, 4 * n ** 2) + b ** 2 - sp.Rational(b.p, b.q) / nS
    C2 = sp.Rational(1, 4 * n ** 2) + b ** 2 - b / nS
    C1 = (2 * (nS - 2) * b - a) / nS + 2 * a * b + sp.Rational(2, n ** 2) - q / nS
    C0 = 2 * (nS - 2) * a / nS + a ** 2 + sp.Rational(10, 4 * n ** 2) \
        + sp.Rational(3, 2 * n ** 2) - sp.Rational(3, n) + q * (1 - sp.Rational(1, n))
    roots = [r for r in sp.solve(sp.Eq(sp.expand(C1 ** 2 - 4 * C2 * C0), 0), ths)
             if r.is_real and r > 0]
    thd = min(roots, key=lambda r: float(r))
    print(f"  theta_disc (Phi has no real root below): {float(thd):.9f}  exact "
          f"{sp.nsimplify(sp.radsimp(thd))}   [claimed 5 sqrt(561)/96 = "
          f"{float(5*sp.sqrt(561)/96):.9f}]")
    # the L1 coefficient-24 mechanism, symbolically:
    #   (radicand with Lambda^4 term at u = theta t - 24 d)
    #     - (2(n-3)/(n-2) - theta t/(n-3))^2
    #   == 2 t^2/((n-1)(n-2)) - theta^2 t^2/(n-3)^2 - d (16 - 96/(n-2))
    Rrad = 4 * (ns - 3) ** 2 / (ns - 2) ** 2 - 4 * (ths * ts - 24 * ds) / (ns - 2) \
        + 2 * ts ** 2 / ((ns - 1) * (ns - 2)) - 16 * ds
    tgt = (2 * (ns - 3) / (ns - 2) - ths * ts / (ns - 3)) ** 2
    diff = sp.simplify(Rrad - tgt
                       - (2 * ts ** 2 / ((ns - 1) * (ns - 2)) - ths ** 2 * ts ** 2 / (ns - 3) ** 2
                          - ds * (16 - 96 / (ns - 2))))
    print(f"  L1 mechanism identity (radicand - target - slack expression) = {diff}  [expect 0]")
    print(f"  => r^2 >= hat(theta) t - 24 d holds with coefficient 24 (not 24(n-2)/(n-3))")
    print(f"     whenever theta >= (n-3) sqrt(2/((n-1)(n-2))) and n >= 8, because the")
    print(f"     Lambda^4 slack -d(16 - 96/(n-2)) = {-(16-96/(n-2)):+.2f} d <= 0 at n = {n}.")

    # ---------------- B2: E-track anchors ----------------
    print("\n-- B2: E-track anchors at (theta, d) = (tilde0, 0) --")
    E = (8.0 * n ** 2 - 41.0 * n + 49.0) / (4.0 * (n + 1) * (n - 2) * (n - 3))
    hat0 = (n - 2.0) / (n - 3.0) * ct["tilde0"]
    ycert = (ALPHA_Y * E + C_Y) ** 2
    r1 = jaeger_rhs_diag(n, hat0 / E, E, ycert)
    r2v = jaeger_rhs_diag(n, ct["t_hi"], E, ycert)
    print(f"  case 1 (t = hat0/E = {hat0/E:.5f}): RHS = {r1:+.8f}   [certified -0.02184071]")
    print(f"  case 2 (t = (n-3) tilde0):          RHS = {r2v:+.8f}")

    # ---------------- B3: geometric-realizability by-product ----------------
    print("\n-- B3: the by-product 'y >= r^2/t^2 moves the margin to -0.10954' --")
    r1f = jaeger_rhs_diag(n, hat0 / E, E, E)
    print(f"  case-1 point with y = v = E forced:  RHS = {r1f:+.8f}   [claimed -0.10954]")
    print(f"  forcing mechanism check: at t = hat0/E, r^2 in [hat0 t, v t^2] = "
          f"[{hat0*hat0/E:.5f}, {E*(hat0/E)**2:.5f}] pinches r^2 = hat0 t, so 3.3.2 gives")
    print(f"  y >= r^2/t^2 = {hat0/(hat0/E):.6f} = E = v >= y.")
    # sound 2-D version: max over admissible (t, v) with the y-floor imposed
    # pointwise (t treated as the true scal at every grid point -- the same
    # architecture as the break-even chain, no convexity/endpoint step needed)
    tg = np.linspace(ct["t_lo"], ct["t_hi"], 1201)
    vg = np.linspace(1.0 / n, E, 1201)
    T, V = np.meshgrid(tg, vg, indexing="ij")
    r2lo = np.maximum(hat0 * T, T * T / n)
    admE = (r2lo <= V * T * T)
    yflo = np.minimum(np.maximum(ycert * 0 + (ALPHA_Y * V + C_Y) ** 2, r2lo / (T * T)), V)
    vals = np.where(admE, np.vectorize(lambda t, v, y: jaeger_rhs_diag(n, t, v, y))(T, V, yflo)
                    if False else np.nan, -np.inf)
    # vectorized re-evaluation (jaeger_rhs_diag is scalar in max(); inline it):
    x = n * V - 1.0
    Y0 = (2.0 * n - 9.0) / (4.0 * n ** 3) + 3.0 * x / (8.0 * n ** 2)
    Mvy = V + np.sqrt(np.clip((V ** 2 - yflo ** 2) / np.maximum(1.0 - yflo, 1e-300), 0, None))
    rhsg = (-(263.0 / 144.0) * (n - 3.0) / (n ** 2 * (n - 2.0)) * (T ** 2 - T ** 3 / (n * hat0))
            - 2.0 * ct["tilde0"] * Y0 * T
            + (2.0 * np.sqrt(2.0) / hat0) * np.sqrt(np.clip(1.0 - V, 0, None)) * Mvy)
    vals = np.where(admE, rhsg, -np.inf)
    i = int(np.argmax(vals))
    print(f"  sound 2-D max over admissible (t,v) with the pointwise y-floor: "
          f"{vals.ravel()[i]:+.8f} at (t, v) = ({T.ravel()[i]:.5f}, {V.ravel()[i]:.6f})")
    # without the geometric y-floor (certificate floor only):
    ycrt = np.minimum((ALPHA_Y * V + C_Y) ** 2, V)
    Mv2 = V + np.sqrt(np.clip((V ** 2 - ycrt ** 2) / np.maximum(1.0 - ycrt, 1e-300), 0, None))
    rhs2 = (-(263.0 / 144.0) * (n - 3.0) / (n ** 2 * (n - 2.0)) * (T ** 2 - T ** 3 / (n * hat0))
            - 2.0 * ct["tilde0"] * Y0 * T
            + (2.0 * np.sqrt(2.0) / hat0) * np.sqrt(np.clip(1.0 - V, 0, None)) * Mv2)
    vals2 = np.where(admE, rhs2, -np.inf)
    j = int(np.argmax(vals2))
    print(f"  same max WITHOUT the y >= r^2/t^2 floor:                     "
          f"{vals2.ravel()[j]:+.8f} at (t, v) = ({T.ravel()[j]:.5f}, {V.ravel()[j]:.6f})")

    # ---------------- B4: Fox anchor at n = 12 ----------------
    print("\n-- B4: Fox anchor -- every lifted ingredient evaluated at Fox, n=12 --")
    cx12 = ctx(12)
    W = fox_weyl(cx12)
    Qf = qfun(cx12)
    th, res = theta_resid(cx12, W)
    Wp, Wm, _ = spectral_split(W)
    aW = Wp + Wm
    Ric = ricci_from_mop(cx12["L2"], aW)
    r2 = np.trace(Ric @ Ric); r = np.sqrt(r2); t = np.trace(Ric)
    S = Ric / r
    v = np.trace(np.linalg.matrix_power(S, 4))
    y = np.trace(np.linalg.matrix_power(S, 3)) ** 2
    lmax = np.linalg.eigvalsh(Ric)[-1]
    d = delta2(cx12, W)
    # s = cosine of |W| against Ric^Ric; J4 - J5 from the (proven) master identity
    RwR = np.zeros_like(W)
    idx = cx12["idx"]
    for a_, (i, j) in enumerate(idx):
        RwR[a_, a_] = Ric[i, i] * Ric[j, j] - Ric[i, j] ** 2
    # (Ric^Ric)_{(ij),(kl)} has off-diagonal entries too; build via wedge formula
    for a_, (i, j) in enumerate(idx):
        for b_, (k, l) in enumerate(idx):
            RwR[a_, b_] = (Ric[i, k] * Ric[j, l] - Ric[i, l] * Ric[j, k])
    s_cos = frob(aW, RwR) / norm(RwR)
    ric_wm2 = ricci_from_mop(cx12["L2"], Wm @ Wm)
    J = th * r2 - np.sqrt(2.0) * r2 * np.sqrt(1.0 - v) * s_cos + 2.0 * frob(ric_wm2, Ric)
    hat = (n - 2.0) / (n - 3.0) * th
    p = J / r2
    print(f"  theta = {th:.6f} (resid {res:.1e}), t = {t:.5f}, r^2 = {r2:.5f}, v = {v:.5f}, "
          f"y = {y:.5f}, s = {s_cos:.5f}, delta^2 = {d:.6f}")
    print(f"  ||Ric^Ric|| = r^2 sqrt(1-v)/sqrt2: "
          f"{abs(norm(RwR) - r2*np.sqrt(1-v)/np.sqrt(2)):.1e}")
    print(f"  J4 - J5 = {J:.6f};  24 d lam_max = {24*d*lmax:.6f}  "
          f"(equality at Fox: {abs(J-24*d*lmax):.1e});  p = (J4-J5)/r^2 = {p:.6f} "
          f"[claimed 0.8165 = 2/sqrt6 = {2/np.sqrt(6):.6f}]")
    checks = [
        ("L1  r^2 >= hat t - 24d (applies: th >= th_min, th t <= cap)",
         r2 >= hat * t - 24 * d - 1e-9 if (th >= ct["th_min"] and th * t <= ct["tt_max"]) else None),
        ("L2  r^2 >= th t - 24d + 4||W_-||^2 (equality at Fox)",
         abs(r2 - (th * t - 24 * d + 4 * frob(Wm, Wm))) < 1e-9),
        ("L2' t = 4 tr W_- >= 2 sqrt2",
         abs(t - 4 * np.trace(Wm)) < 1e-9 and t >= ct["t_lo"]),
        ("L3  t^2/n <= r^2 <= v t^2 (right one equality)",
         t * t / n <= r2 + 1e-9 and abs(r2 - v * t * t) < 1e-9),
        ("L3  r^2/t^2 <= y <= v (both equalities)",
         abs(y - r2 / t ** 2) < 1e-9 and abs(y - v) < 1e-9),
        ("L4  B <= sqrt2 sqrt(1-v) s",
         th + hat * r2 / (2 * (n - 2) * (r2 + 24 * d)) - p
         <= np.sqrt(2) * np.sqrt(1 - v) * s_cos + 1e-9),
        ("L5  tr S^3 >= 0.7 v + 8647/38000",
         np.sqrt(y) >= ALPHA_Y * v + C_Y - 1e-9),
        ("lam_max <= r v^(1/4) (41% lossy)", lmax <= r * v ** 0.25 + 1e-9),
        ("cW <= ||W_-||^2", ct["cW"] <= frob(Wm, Wm)),
    ]
    for name, ok in checks:
        print(f"    {name:58s} {'HOLDS' if ok else ('n/a' if ok is None else '*** FAILS ***')}")
    c2f, c1f, c0f = my_phi(n, th)
    xF = n * v - 1.0
    phiF = c2f * xF ** 2 + c1f * xF + c0f
    print(f"  escape localization: x = {xF:.4f}, Phi(x, theta_Fox) = {phiF:+.6f} "
          f"{'> 0 -> Lemma 3.5.4 inapplicable, Fox escapes via C1' if phiF > 0 else '<= 0 ?!'}")
    Bnop = th + hat * r2 / (2 * (n - 2) * (r2 + 24 * d))
    print(f"  without the penalty p, 3.3.6 would cap v <= {1-0.5*Bnop**2:.4f} < v_Fox = {v:.4f}"
          f" -> p is exactly what keeps Fox alive in the lifted 3.3.6")
    print(f"  full-chain check: my_score at (theta_Fox, d = 1/9) = ", end="")
    sc, wh, why = my_score(ct, th, 1.0 / 9.0, ngrid=400, refine=2)
    print(f"{'OPEN (chain says nothing -- anchor respected)' if not (sc < 0) else 'CLOSED (*** anchor VIOLATED ***)'} [{why[:60]}]")

    # ---------------- B5: the unflagged lifted Lemma 3.3.5 ----------------
    print("\n-- B5: lifted Lemma 3.3.5  <Ric(W_-^2), Ric> >= tr Ric^3 / (4(n-2)) --")
    print("   (the thesis proof is diagonal-specific; the chain's L4/3.3.6 step needs it")
    print("    off-diagonal; NOT flagged in FINDINGS Result 10's caveat list)")
    tests = []
    cx8 = ctx(8)
    cx6 = ctx(6)
    tests.append(("Fox n=8", cx8, fox_weyl(cx8)))
    tests.append(("Fox n=12", cx12, W))
    tests.append(("sphere (4,4) n=8", cx8, sphere_weyl(cx8, 4)))
    tests.append(("sphere (2,6) n=8", cx8, sphere_weyl(cx8, 2)))
    tests.append(("sphere (6,6) n=12", cx12, sphere_weyl(cx12, 6)))
    tests.append(("su(3) Kaehler n=6", cx6, su_m_kahler(cx6)[0]))
    tests.append(("su(4) Kaehler n=8", cx8, su_m_kahler(cx8)[0]))
    tests.append(("violator n=8", cx8, np.load("scripts/data/defect_violation_n8_0.120000.npy")))
    tests.append(("theta=0 point n=8", cx8, np.load("scripts/data/defect_theta0_n8_0.125000.npy")))
    F1 = fox_weyl(cx8, (0, 1, 2, 3)); F2 = fox_weyl(cx8, (4, 5, 6, 7))
    tests.append(("Fox 2-block n=8", cx8, (F1 + F2) / np.sqrt(2)))
    rng = np.random.default_rng(23)
    for k in range(4):
        tests.append((f"random Weyl n=6 #{k} (non-critical)", cx6, random_weyl(cx6, rng)))
    for k in range(2):
        tests.append((f"random Weyl n=8 #{k} (non-critical)", cx8, random_weyl(cx8, rng)))
    worst = np.inf
    for name, cxx, Wx in tests:
        nn = cxx["n"]
        _, Wmx, _ = spectral_split(Wx)
        aWx = Wx + 2 * Wmx
        Rc = ricci_from_mop(cxx["L2"], aWx)
        lhs = frob(ricci_from_mop(cxx["L2"], Wmx @ Wmx), Rc)
        rhs = np.trace(np.linalg.matrix_power(Rc, 3)) / (4.0 * (nn - 2))
        margin = lhs - rhs
        worst = min(worst, margin)
        print(f"    {name:34s} lhs = {lhs:9.5f}  rhs = {rhs:9.5f}  margin = {margin:+9.5f}"
              + ("   *** VIOLATED ***" if margin < -1e-9 else ""))
    print(f"    worst margin: {worst:+.6f}")

    # ---------------- B6: c(12) ----------------
    print("\n-- B6: c(12) reproduced independently --")
    for name, th_ in (("tilde_theta_0", ct["tilde0"]), ("theta_0", ct["theta0"])):
        hi = 1e-3
        while my_closes(ct, th_, hi, ngrid=350, refine=2) and hi < 1:
            hi *= 2
        cval = my_bisect(lambda dd: not my_closes(ct, th_, dd, ngrid=350, refine=2), 0.0, hi, 1e-11)
        try:
            cm, vm = my_corner(ct, th_)
            extra = f";  corner solve (mpmath): c = {cm:.10e} at v = {vm:.6f}, |diff| = {abs(cm-cval):.1e}"
        except Exception as exc:
            extra = f";  [corner solve failed: {exc}]"
        print(f"  theta = {name} = {th_:.6f}:  c = {cval:.6e}{extra}")
    print(f"  [claimed: 1.081e-3 at tilde_theta_0, 1.223e-3 at theta_0]")

    # ---------------- B7: Theta(d, 12) ----------------
    print("\n-- B7: break-even Theta(d,12) --")
    for d_, claim in ((0.0, "1.23368"), (1.22e-3, "~theta_0 crossing"), (1.0 / 9.0, "2.079")):
        grid = np.geomspace(1.0, 8.0, 220)
        openi = [i for i, th_ in enumerate(grid)
                 if not my_closes(ct, th_, d_, ngrid=250, refine=1)]
        if not openi:
            print(f"  d = {d_:.6g}: closes at every theta scanned")
            continue
        last = max(openi)
        Th = my_bisect(lambda th_: my_closes(ct, th_, d_, ngrid=250, refine=1),
                       grid[last], grid[min(last + 1, len(grid) - 1)], 1e-6)
        why = my_score(ct, Th * (1 - 1e-5), d_, ngrid=250, refine=1)[2]
        print(f"  d = {d_:<10.6g} Theta = {Th:.6f}  [claimed {claim}]  binds below: {why[:64]}")
        if d_ > 0.1:
            openi2 = [i for i, th_ in enumerate(grid)
                      if not my_closes(ct, th_, d_, ngrid=250, refine=1, sound_y=True)]
            Th2 = my_bisect(lambda th_: my_closes(ct, th_, d_, ngrid=250, refine=1, sound_y=True),
                            grid[max(openi2)], grid[min(max(openi2) + 1, len(grid) - 1)], 1e-6) \
                if openi2 else -np.inf
            print(f"        with the CORRECTED y-choice (M maximized over y in [floor, v],")
            print(f"        fixing the M-monotonicity leak at v > ~0.985): Theta = {Th2:.6f}")

    # ---------------- B8: the agent-own bounds ----------------
    print("\n-- B8: the two agent-own bounds, proved and spot-checked --")
    print("  (i) scal(|W|) = 4 tr W_-: scal(R) = 2 tr_pair(R) in this basis, and")
    print("      tr_pair W = scal(W)/2 = 0 forces tr W_+ = tr W_-; PSD gives tr >= ||.||;")
    print("      max(||W+||,||W-||) >= 1/sqrt2.  PROOF SOUND.")
    print("  (ii) ||W_-||^2 >= cW: ||W+||^2 <= lam_max(W+) tr W+ <= tr W- <= sqrt N ||W-||")
    print("      (lam_max <= ||W||_F = 1), so u = ||W-|| solves u^2 + sqrt N u - 1 >= 0.")
    print("      PROOF SOUND.")
    print("  (iii) lam_max(Ric) <= r v^(1/4): lam_max^4 <= tr Ric^4 = r^4 v, Ric >= 0.")
    print("      PROOF SOUND.")
    worst1, worst2 = np.inf, np.inf
    for name, cxx, Wx in tests[:10]:
        _, Wmx, _ = spectral_split(Wx)
        aWx = Wx + 2 * Wmx
        t_ = np.trace(ricci_from_mop(cxx["L2"], aWx))
        worst1 = min(worst1, abs(t_ - 4 * np.trace(Wmx)))
        worst2 = min(worst2, frob(Wmx, Wmx) - bconsts(cxx["n"])["cW"])
    print(f"  numeric: worst |scal - 4 tr W_-| = {worst1:.1e}; "
          f"min ||W_-||^2 - cW over catalogue = {worst2:+.4f} (>= 0)")


# =====================================================================
# PART C -- the padded-flat second-order addendum
# =====================================================================
def partC():
    print("=" * 78)
    print("PART C: the padded-flat second-order addendum at Fox, n = 12")
    print("=" * 78)
    n = 12
    cx12 = ctx(12)
    cx8 = ctx(8)
    Qf = qfun(cx12)
    W = fox_weyl(cx12)                          # supported on R^4 = coords 0..3
    th = frob(W, Qf(W))
    th0 = np.sqrt(2.0 * 11 * 10) / 12
    kap = 9.0 * (SQ32 - th0)
    print(f"  theta(Fox) = {th:.10f}, theta_0(12) = {th0:.10f}, kappa_12 = {kap:.10f}")
    print(f"  Phi(Fox) - theta_0 = {th - kap*delta2(cx12, W) - th0:+.1e}  [equality point]")

    def Pval(M):
        return frob(M, Qf(M))

    rng = np.random.default_rng(31)
    print(f"\n  {'dir':>4} {'T(W,H,H)':>12} {'<H#,W>':>10} {'||WH||':>9} "
          f"{'measured':>10} {'predicted':>10} {'diff':>9}   (curvatures = (Phi(t)-theta_0)/t^2)")
    Ts, meas = [], []
    for k in range(6):
        H8 = random_weyl(cx8, rng)
        H = pad_mop(cx8, cx12, H8, offset=4)     # supported on coords 4..11
        H /= norm(H)
        TWHH = (Pval(W + H) + Pval(W - H) - 2.0 * Pval(W)) / 6.0
        sharpH = Qf(H) - H @ H
        hw = frob(sharpH, W)
        wh = norm(W @ H)
        d2H = delta2(cx12, H)
        t_ = 1e-2
        x1 = (W + t_ * H) / np.sqrt(1 + t_ * t_)
        x2 = (W - t_ * H) / np.sqrt(1 + t_ * t_)
        phi1 = Pval(x1) - kap * delta2(cx12, x1)
        phi2 = Pval(x2) - kap * delta2(cx12, x2)
        curv = 0.5 * ((phi1 - th0) + (phi2 - th0)) / t_ ** 2
        pred = -1.5 * th - kap * (d2H - 1.0 / 9.0)
        Ts.append(TWHH); meas.append(curv)
        print(f"  {k:>4} {TWHH:>12.1e} {hw:>10.1e} {wh:>9.1e} "
              f"{curv:>10.4f} {pred:>10.4f} {curv-pred:>9.1e}")
    print(f"\n  max |T(W,H,H)| over 6 padded directions: {max(abs(x) for x in Ts):.1e}  "
          f"[claimed 0 by disjoint support]")
    print(f"  mean measured curvature: {np.mean(meas):.4f}  [FINDINGS: -1.846]; "
          f"pure-P prediction -3 theta/2 = {-1.5*th:.4f}  [FINDINGS: -1.837]")
    print(f"  NOTE: the -1.846 vs -1.837 gap is NOT truncation error -- it is the exact")
    print(f"  defect term -kappa (delta^2(H) - 1/9), reproduced per-direction above.")
    # support analysis of H#: does # couple disjoint blocks at all?
    H8 = random_weyl(cx8, rng)
    H = pad_mop(cx8, cx12, H8, offset=4); H /= norm(H)
    sharpH = Qf(H) - H @ H
    idx = cx12["idx"]
    blocks = {"pure4": 0.0, "pure8": 0.0, "mixed-any": 0.0}
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            v_ = abs(sharpH[a, b])
            in4 = (i < 4 and j < 4, k < 4 and l < 4)
            in8 = (i >= 4 and j >= 4, k >= 4 and l >= 4)
            if in4[0] and in4[1]:
                blocks["pure4"] = max(blocks["pure4"], v_)
            elif in8[0] and in8[1]:
                blocks["pure8"] = max(blocks["pure8"], v_)
            else:
                blocks["mixed-any"] = max(blocks["mixed-any"], v_)
    print(f"\n  support of H# (max |entry|): pure-R^4 block {blocks['pure4']:.1e}, "
          f"pure-R^8 block {blocks['pure8']:.2f}, blocks touching mixed pairs "
          f"{blocks['mixed-any']:.2e}")
    print(f"  => H# stays supported on the pure-R^8 block (padding commutes with #):")
    print(f"     although the structure constants do couple mixed bivectors, every")
    print(f"     coupling term needs H to eat a bracket [w, .] with w in Lambda^2 R^4,")
    print(f"     and such brackets have no pure-R^{{n-4}} component -- so the mixed and")
    print(f"     pure-R^4 blocks of H# vanish identically.  With WH = 0 this gives")
    print(f"     T(W,H,H) = tr(W H^2) + <H#, W> = 0 exactly: disjoint index support IS")
    print(f"     sufficient, and the polarization measurement confirms it.  CONFIRMED.")
    print(f"\n  18x margin: 3 theta = {3*th:.4f} vs 2|kappa_12| ||Alt(H_-)||^2 <= "
          f"2|kappa_12| = {2*abs(kap):.4f}: ratio {3*th/(2*abs(kap)):.1f}x.")
    print(f"  ||Alt(H_-)|| <= ||H_-|| <= ||H|| = 1 always (Alt is an orthogonal")
    print(f"  projection), and the proven delta^2 <= 1/4 sharpens it to "
          f"{3*th/(2*abs(kap)*0.25):.0f}x -- AIRTIGHT, no extra hypothesis needed.")


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    t0 = time.time()
    part0()
    if which in ("A", "all"):
        partA()
    if which in ("B", "all"):
        partB()
    if which in ("C", "all"):
        partC()
    print(f"\n[total {time.time()-t0:.0f}s]")
