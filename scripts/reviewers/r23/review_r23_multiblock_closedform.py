"""Reviewer 23: closed form for the multi-block (vertex-system) critical points,
derived independently and verified against the full Q on Lambda^2(R^n).

Uniform branch of the vertex system for blocks (n_1,...,n_k), all n_a >= 2:

    w_ab = c            (a != b)
    w_aa = -c (n-n_a)/(n_a-1)
    theta = -c (n-1)
    theta^2 = 2 (n-1)^2 / D,   D = (k-1) n^2 + sum_a (n-n_a)^2/(n_a-1)

which gives theta^2 < 2/(k-1) strictly, for every partition and every n.
"""
import itertools
from fractions import Fraction

import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad

SQ32 = np.sqrt(1.5)


def theta2_closed(blocks):
    """exact rational theta^2 for the uniform branch."""
    n = sum(blocks)
    k = len(blocks)
    D = Fraction((k - 1) * n * n)
    for a in blocks:
        D += Fraction((n - a) ** 2, a - 1)
    return Fraction(2 * (n - 1) ** 2) / D


def uniform_w(blocks):
    """(w matrix, theta) for the uniform branch, unit norm, theta > 0."""
    n = sum(blocks)
    k = len(blocks)
    th = float(theta2_closed(blocks)) ** 0.5
    c = -th / (n - 1)
    w = np.full((k, k), c)
    for a in range(k):
        w[a, a] = -c * (n - blocks[a]) / (blocks[a] - 1)
    return w, th


def embed(L2, blocks, w):
    n = sum(blocks)
    starts = np.cumsum([0] + list(blocks))
    blk = np.zeros(n, int)
    for a in range(len(blocks)):
        blk[starts[a]:starts[a + 1]] = a
    M = np.zeros((L2.N, L2.N))
    for t, (i, j) in enumerate(L2.pairs):
        M[t, t] = w[blk[i], blk[j]]
    return M


class Core:
    def __init__(self, n):
        self.n = n
        _, _, self.N, self.c = build_structure_constants(n)
        self.L2 = Lambda2(n)
        self.alt = build_alt_indices(self.L2)


def measure(core, W, verbose_extra=True):
    """theta, RHS (e2 dropped), RHS (e2 kept), slack S, residual, delta^2, J5."""
    nrm = np.linalg.norm(W)
    W = W / nrm
    QW = Q_full(W, core.c)
    th = float(np.sum(W * QW))
    if th < 0:
        W, th = -W, -th
        QW = Q_full(W, core.c)
    res = np.linalg.norm(QW - th * W)
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    Wp = (V[:, ~neg] * ev[~neg]) @ V[:, ~neg].T
    absW = Wp + Wm
    d2 = float(delta2_and_grad(W, core.alt)[0])
    rho = ricci_from_mop(core.L2, Wm)
    nr2 = float(np.sum(rho * rho))
    Sh = rho / np.sqrt(nr2)
    trSh4 = float(np.trace(np.linalg.matrix_power(Sh, 4)))
    RicWm2 = ricci_from_mop(core.L2, Wm @ Wm)
    base = (- float(np.sum(RicWm2 * rho)) / nr2
            + 12.0 * d2 * float(np.linalg.eigvalsh(rho)[-1]) / nr2)
    tach = np.sqrt(2) * np.sqrt(max(1 - trSh4, 0.0))
    # sqrt(1-e^2) factor, exactly as review_r13_independent.evaluate_point builds it
    Ric = ricci_from_mop(core.L2, absW)
    RR = np.zeros((core.N, core.N))
    for a, (i, j) in enumerate(core.L2.pairs):
        for b, (kk, l) in enumerate(core.L2.pairs):
            RR[a, b] = Ric[i, kk] * Ric[j, l] - Ric[i, l] * Ric[j, kk]
    sq1me2 = float(np.sum(absW * RR)) / np.linalg.norm(RR)
    S = nr2 + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    out = dict(theta=th, rhs_e2drop=tach + base, rhs_e2keep=tach * sq1me2 + base,
               S=S, res=res, d2=d2, sq1me2=sq1me2, nr2=nr2, trSh4=trSh4,
               ric_check=float(np.linalg.norm(ricci_from_mop(core.L2, W))))
    return out


# ---------------------------------------------------------------- closed forms
def slack_closed(blocks):
    """S = 3 theta^2 e_3(n_1..n_k) / (n-1)^2 ; zero exactly when k <= 2."""
    n = sum(blocks)
    e3 = sum(x * y * z for x, y, z in itertools.combinations(blocks, 3))
    return 3.0 * float(theta2_closed(blocks)) * e3 / (n - 1) ** 2


def rhs_closed(blocks, keep_e2=True):
    """sharp (II)-side bound on the uniform branch; delta^2 = 0 so the cap term drops."""
    n = sum(blocks)
    th = float(theta2_closed(blocks)) ** 0.5
    c = th / (n - 1)                                   # |c|
    s = [c * (n - a) / (a - 1) for a in blocks]
    R = [2 * c * (n - a) for a in blocks]              # Ric(|W|) on block a
    T = sum(a * (n - a) ** 2 for a in blocks)
    trSh4 = sum(a * (n - a) ** 4 for a in blocks) / T ** 2
    num = sum(a * (a - 1) / 2 * s[i] * R[i] ** 2 for i, a in enumerate(blocks))
    num += sum(blocks[i] * blocks[j] * c * R[i] * R[j]
               for i, j in itertools.combinations(range(len(blocks)), 2))
    den = sum(a * (a - 1) / 2 * R[i] ** 4 for i, a in enumerate(blocks))
    den += sum(blocks[i] * blocks[j] * R[i] ** 2 * R[j] ** 2
               for i, j in itertools.combinations(range(len(blocks)), 2))
    sq1me2 = num / den ** 0.5
    tach = np.sqrt(2) * np.sqrt(max(1 - trSh4, 0.0))
    return (tach * sq1me2 if keep_e2 else tach) - th / (n - 1), sq1me2
