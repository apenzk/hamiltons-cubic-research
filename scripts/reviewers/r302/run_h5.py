"""H5: the negative-block-graph edge average tr(L_e|V)/dim V.

Blocks = classes of coordinates with identical rows of the matrix (lambda_ij).
Block graph edges = block pairs with lambda < 0 (the record's "negative block graph",
the one C_5 is an edge set of, and the one that gives K_2 at S^p x S^q).
"""
import sys, os, time, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from le import build_weyl, Le_matrix, HA_span, compression
from defect import Delta
from run_h1 import log


def lam_matrix(g, W):
    n = g.n
    L = np.zeros((n, n))
    for a, (i, j) in enumerate(g.pairs):
        L[i, j] = L[j, i] = W[a, a]
    return L


def blocks_of(L, tol=1e-7):
    n = L.shape[0]
    lab = [-1] * n
    reps = []
    for i in range(n):
        for r, j in enumerate(reps):
            Li, Lj = L[i].copy(), L[j].copy()
            Li[[i, j]] = 0; Lj[[i, j]] = 0
            if np.max(np.abs(Li - Lj)) < tol and abs(L[i, j] - L[i, i]) < 1e9:
                lab[i] = r; break
        else:
            lab[i] = len(reps); reps.append(i)
    return lab, len(reps)


def family_average(g, W, B, sv, index_pairs):
    """V = span{ Pi_{e-perp} Pi_Weyl H_A : A = (E_ab+E_ba)/sqrt2, (a,b) in index_pairs }"""
    th = g.P(W)
    Le = Le_matrix(g, W, B, sv, th)
    cols = []
    for (a, b) in index_pairs:
        A = np.zeros((g.n, g.n)); A[a, b] = A[b, a] = 1 / np.sqrt(2.0)
        Hm = g.H(W, A)
        cols.append(B.T @ sv.vec(0.5 * (Hm + Hm.T)))
    C = np.array(cols).T
    e = B.T @ sv.vec(W / np.linalg.norm(W))
    C = C - np.outer(e, e @ C)
    U, M, _ = compression(Le, C)
    if U.shape[1] == 0:
        return None, 0, None, Le
    ev = np.linalg.eigvalsh(0.5 * (M + M.T))
    return float(np.trace(M) / U.shape[1]), U.shape[1], ev, Le


def edge_pairs(L, lab, nb, sign='neg', tol=1e-7):
    """block-value matrix and the index pairs across edges"""
    val = np.zeros((nb, nb))
    for A in range(nb):
        for Bk in range(nb):
            ia = [i for i in range(len(lab)) if lab[i] == A]
            ib = [i for i in range(len(lab)) if lab[i] == Bk]
            cand = [(i, j) for i in ia for j in ib if i != j]
            val[A, Bk] = L[cand[0]] if cand else 0.0
    ep, allp = [], []
    for A in range(nb):
        for Bk in range(A + 1, nb):
            ia = [i for i in range(len(lab)) if lab[i] == A]
            ib = [i for i in range(len(lab)) if lab[i] == Bk]
            prs = [(i, j) for i in ia for j in ib]
            allp += prs
            if val[A, Bk] < -tol:
                ep += prs
    return val, ep, allp


def report(name, g, W, B=None, sv=None):
    if B is None:
        B, sv = build_weyl(g)
    L = lam_matrix(g, W)
    lab, nb = blocks_of(L)
    val, ep, allp = edge_pairs(L, lab, nb)
    D = Delta(g, W)
    th = g.P(W)
    ea, de, evs, Le = family_average(g, W, B, sv, ep) if ep else (None, 0, None, None)
    aa, da, _, _ = family_average(g, W, B, sv, allp) if allp else (None, 0, None, None)
    e = B.T @ sv.vec(W)
    if Le is None:
        Le = Le_matrix(g, W, B, sv, th)
    Pe = np.eye(B.shape[1]) - np.outer(e, e)
    full = np.linalg.eigvalsh(Pe @ Le @ Pe).max()
    ea_s = f"{ea:.9f}" if ea is not None else "undefined/empty"
    aa_s = f"{aa:.9f}" if aa is not None else "undefined/empty"
    spread = f" spec={np.round(np.unique(np.round(evs,7)),7).tolist()}" if evs is not None and de <= 60 else ""
    log(f"{name:22s} n={g.n} th={th:.6f} D={D:8.4f} blocks={nb} lam_max={full:.6f} | "
        f"EDGE avg={ea_s} (dim {de}) | ALL-pairs avg={aa_s} (dim {da}){spread}")
    return dict(name=name, D=D, edge=ea, dim=de, allpairs=aa, full=full)
