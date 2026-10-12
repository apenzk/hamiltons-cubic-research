"""H4: how many k-isotypic pieces are there really, and is the C_5 edge family an eigenspace?"""
import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from points import sphere_product, c5_blowup, cpm, witness
from le import build_weyl, Le_matrix, HA_span, compression
from run_h1 import isotropy, rep_on_V, log
from run_h5 import lam_matrix, blocks_of, edge_pairs


def commutant_basis(reps, d, tol=1e-8):
    """nullspace of  T -> ([R,T])_R , via the Gram matrix (eigh is stable where svd is not)"""
    G = np.zeros((d * d, d * d))
    I = np.eye(d)
    for R in reps:
        Kk = np.kron(I, R) - np.kron(R.T, I)
        G += Kk.T @ Kk
    w, V = np.linalg.eigh(G)
    scale = max(max((np.linalg.norm(R) for R in reps), default=1.0), 1e-12) ** 2
    keep = w < (tol * scale) ** 2 * d
    return [V[:, i].reshape(d, d) for i in np.where(keep)[0]]


def n_isotypes(reps, d, seed=0, tol=1e-6):
    C = commutant_basis(reps, d)
    m = len(C)
    # Z(C): coefficients c with [sum c_i C_i, C_j] = 0 for all j
    rows = []
    for j in range(m):
        rows.append(np.array([(C[i] @ C[j] - C[j] @ C[i]).ravel() for i in range(m)]).T)
    A = np.vstack(rows)
    u, s, vt = np.linalg.svd(A)
    scaleC = max(np.linalg.norm(c) for c in C) ** 2          # ABSOLUTE scale, never s[0]
    r = int((s > 1e-8 * scaleC).sum())
    Z = [sum(c * C[i] for i, c in enumerate(row)) for row in vt[r:]]
    rng = np.random.default_rng(seed)
    T = sum(rng.normal() * (z + z.T) for z in Z)
    ev = np.linalg.eigvalsh(T)
    ev = ev / max(np.max(np.abs(ev)), 1e-300)
    uniq = 1
    for a in range(1, len(ev)):
        if ev[a] - ev[a - 1] > tol:
            uniq += 1
    return len(C), len(Z), uniq


def go(name, f):
    g, W = f()
    B, sv = build_weyl(g)
    th = g.P(W)
    Le = Le_matrix(g, W, B, sv, th)
    ks = isotropy(g, W)
    C, _ = HA_span(g, W, B, sv)
    U, M, _ = compression(Le, C)
    reps = rep_on_V(g, B, sv, U, ks)
    dimC, dimZ, niso = n_isotypes(reps, U.shape[1])
    nev = len(np.unique(np.round(np.linalg.eigvalsh(0.5 * (M + M.T)), 7)))
    log(f"{name:12s} dim k={len(ks)} dim V={U.shape[1]} dim End_k(V)={dimC} dim Z={dimZ} "
        f"ISOTYPIC PIECES={niso}  distinct L_e values={nev}")


if __name__ == '__main__':
    log("[p6] H4: true k-isotypic piece counts vs the record's '3 -> 13'")
    for nm, f in [("S3xS5", lambda: sphere_product(3, 5)), ("witness_n8", witness),
                  ("C5blowup", c5_blowup), ("CP4", lambda: cpm(4))]:
        go(nm, f)
    log("[p6] is the 20-dim C_5 edge family an L_e-EIGENSPACE or only a Rayleigh-Ritz block?")
    g, W = c5_blowup(); B, sv = build_weyl(g); th = g.P(W)
    Le = Le_matrix(g, W, B, sv, th)
    L = lam_matrix(g, W); lab, nb = blocks_of(L); val, ep, allp = edge_pairs(L, lab, nb)
    cols = []
    for (a, b) in ep:
        A = np.zeros((g.n, g.n)); A[a, b] = A[b, a] = 1 / np.sqrt(2.0)
        Hm = g.H(W, A)
        cols.append(B.T @ sv.vec(0.5 * (Hm + Hm.T)))
    Cm = np.array(cols).T
    e = B.T @ sv.vec(W); Cm = Cm - np.outer(e, e @ Cm)
    U, M, _ = compression(Le, Cm)
    resid = np.linalg.norm(Le @ U - U @ M)
    log(f"     dim edge family = {U.shape[1]}, ||L_e U - U M|| = {resid:.3e}  "
        f"(0 => genuine eigenspace)   spec = {np.unique(np.round(np.linalg.eigvalsh(0.5*(M+M.T)),9)).tolist()}")
    # and the whole Sym_0 span
    C2, _ = HA_span(g, W, B, sv)
    U2, M2, _ = compression(Le, C2)
    log(f"     dim full Sym_0 image = {U2.shape[1]}, ||L_e U - U M|| = {np.linalg.norm(Le@U2-U2@M2):.3e}")
