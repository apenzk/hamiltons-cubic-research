"""
Jensen's second homogeneous Einstein metric on S^3 x S^3, from
Petersen-Stanfield (arXiv:2508.11236, end of Subsection 2.4).

This is a literature-supplied NON-SYMMETRIC Einstein metric with an explicitly
computed curvature operator -- the natural candidate for a high-theta UNGRADED
critical point of P, which would close the slack-gap question by refuting it.
It is also outside the symmetric class in a visible way: their Theorem A puts a
symmetric space's curvature eigenvalues in [0, 1/2], and Jensen's has a NEGATIVE
one.

Their presentation, in the splitting of Lambda^2(R^6) for R^6 = su(2) + su(2)
under the diagonal SU(2):

    Lambda^2(su(2))_1 (3) , Lambda^2(su(2))_2 (3) ,
    Lambda^2 part of su(2) (x) su(2) (3) , Sym^2_0 (5) , R (1)

                  [ 9  5  0  0  0 ]
                  [ 5  9  0  0  0 ]
    R = (1/48)    [ 0  0  4  0  0 ]
                  [ 0  0  0 -2  0 ]
                  [ 0  0  0  0  4 ]

with eigenvalues 7/24 (mult 3), 1/12 (mult 7), -1/24 (mult 5) -- reproduced here
as a validation gate before anything is concluded.

The script builds this operator on Lambda^2(R^6), checks the spectrum against
the paper, extracts the Weyl part, and reports theta, the criticality residual,
the Bianchi defect and the graded-compression slack S.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad

SQ32 = np.sqrt(1.5)
n = 6


def su2_basis():
    """Orthonormal basis of su(2) as 3 vectors; we only need the index labels."""
    return [0, 1, 2]


def build_jensen():
    """R^6 = su(2)_1 + su(2)_2 with coords 0,1,2 and 3,4,5.
    Lambda^2(R^6) splits as Lambda^2(first) + (first (x) second) + Lambda^2(second)."""
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: k for k, p in enumerate(pairs)}
    N = len(pairs)

    A = [pidx[p] for p in pairs if p[0] < 3 and p[1] < 3]      # Lambda^2 su(2)_1, dim 3
    B = [pidx[p] for p in pairs if p[0] >= 3 and p[1] >= 3]    # Lambda^2 su(2)_2, dim 3
    M = [pidx[p] for p in pairs if p[0] < 3 <= p[1]]           # mixed, dim 9

    # identify Lambda^2(su(2)) with su(2) via the Hodge/epsilon map:
    # e_i ^ e_j  <->  e_k  with (i,j,k) cyclic.
    def cyc(idx3):
        out = {}
        for (i, j) in [(0, 1), (0, 2), (1, 2)]:
            k = 3 - i - j
            sgn = 1.0 if (i, j) in [(0, 1), (1, 2)] else -1.0
            out[k] = (idx3[(i, j)], sgn)
        return out

    a_map = {}
    for (i, j) in [(0, 1), (0, 2), (1, 2)]:
        k = 3 - i - j
        a_map[k] = pidx[(i, j)]
    b_map = {}
    for (i, j) in [(0, 1), (0, 2), (1, 2)]:
        k = 3 - i - j
        b_map[k] = pidx[(i + 3, j + 3)]

    # mixed block: e_i ^ e_{3+j} indexed by (i,j); decompose into
    # Sym^2_0 (5), Lambda^2 ~ adjoint (3), trace R (1)
    mix = {}
    for i in range(3):
        for j in range(3):
            mix[(i, j)] = pidx[(i, 3 + j)]

    R = np.zeros((N, N))
    s = 1.0 / 48.0
    # the coupled 2x2 block on (Lambda^2_1, Lambda^2_2), matched index by index
    for k in range(3):
        ia, ib = a_map[k], b_map[k]
        R[ia, ia] += 9 * s
        R[ib, ib] += 9 * s
        R[ia, ib] += 5 * s
        R[ib, ia] += 5 * s
    # mixed block: build the three isotypic projectors
    E = np.zeros((N, 3, 3))
    for (i, j), col in mix.items():
        E[col, i, j] = 1.0
    Tr = np.zeros(N)
    for i in range(3):
        Tr[mix[(i, i)]] = 1.0 / np.sqrt(3.0)
    P_tr = np.outer(Tr, Tr)
    P_anti = np.zeros((N, N))
    for (i, j) in [(0, 1), (0, 2), (1, 2)]:
        v = np.zeros(N)
        v[mix[(i, j)]] = 1 / np.sqrt(2.0)
        v[mix[(j, i)]] = -1 / np.sqrt(2.0)
        P_anti += np.outer(v, v)
    P_mix = np.zeros((N, N))
    for col in M:
        P_mix[col, col] = 1.0
    P_sym0 = P_mix - P_anti - P_tr
    R += 4 * s * P_anti + (-2) * s * P_sym0 + 4 * s * P_tr
    return R


R = build_jensen()
ev = np.linalg.eigvalsh(R)
print("Curvature operator spectrum (against Petersen-Stanfield):")
lo = 0
evs = np.round(ev, 12)
while lo < len(evs):
    hi = lo
    while hi + 1 < len(evs) and abs(evs[hi + 1] - evs[lo]) < 1e-10:
        hi += 1
    print(f"   {evs[lo]:+.10f}  mult {hi-lo+1}   (= {evs[lo]*24:+.4f}/24)")
    lo = hi + 1
print(f"   expected: 7/24={7/24:.10f} x3,  1/12={1/12:.10f} x7,  -1/24={-1/24:.10f} x5")

idx, pos, N_, c = build_structure_constants(n)
L2 = Lambda2(n)
alt = build_alt_indices(L2)
W = weyl_from_mop(L2, R)[0]
nw = np.linalg.norm(W)
print(f"\n||Weyl part|| = {nw:.9f}")
if nw > 1e-10:
    W = W / nw
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    if th < 0:
        W, th = -W, -th
        QW = Q_full(W, c)
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    ric = float(np.max(np.abs(ricci_from_mop(L2, W))))
    d2 = float(delta2_and_grad(W, alt)[0])
    evn, V = np.linalg.eigh(W)
    neg = evn < 0
    Wm = (V[:, neg] * (-evn[neg])) @ V[:, neg].T
    rm = ricci_from_mop(L2, Wm)
    S = float(np.sum(rm * rm)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    print(f"theta        = {th:.9f}   (sqrt(3/2) = {SQ32:.9f})")
    print(f"crit residual= {res:.3e}   {'CRITICAL' if res < 1e-8 else 'NOT a critical point of P'}")
    print(f"|Ric(W)|     = {ric:.3e}")
    print(f"delta^2      = {d2:.9f}")
    print(f"slack S      = {S:+.9f}   {'GRADED' if abs(S) < 1e-8 else 'UNGRADED'}")
