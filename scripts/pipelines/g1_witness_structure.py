"""Where the second-order violation lives, and what indexes it.

Three results, all at critical points of the subalgebra family, where gradedness
varies with no block count present:

  (1) the rank-two Rayleigh quotient in closed form, and the bound it implies;
  (2) the violation is attained inside Sym^2(m), the slack's own subspace;
  (3) at the su(3) bi-invariant the violating eigenspace is exactly the
      d_abc family of the symmetric invariant cubic -- and that is special to
      su(3), the eigenspace being a different h-module elsewhere.
"""
import itertools
import sys

import numpy as np

from g1_le_machinery import weyl_basis, Le_matrix
from rsharp_basis_free import Q_full
from p5_casimir_family import (projector, casimir_operator, h_adjoint, h_so3_in_so5,
                               su3_structure_constants, so_k_structure_constants,
                               h_so_p_so_q)


def gell_mann():
    l = np.zeros((8, 3, 3), dtype=complex)
    l[0] = [[0, 1, 0], [1, 0, 0], [0, 0, 0]]
    l[1] = [[0, -1j, 0], [1j, 0, 0], [0, 0, 0]]
    l[2] = [[1, 0, 0], [0, -1, 0], [0, 0, 0]]
    l[3] = [[0, 0, 1], [0, 0, 0], [1, 0, 0]]
    l[4] = [[0, 0, -1j], [0, 0, 0], [1j, 0, 0]]
    l[5] = [[0, 0, 0], [0, 0, 1], [0, 1, 0]]
    l[6] = [[0, 0, 0], [0, 0, -1j], [0, 1j, 0]]
    l[7] = np.array([[1, 0, 0], [0, 1, 0], [0, 0, -2]]) / np.sqrt(3)
    return l


def d_tensor():
    L = gell_mann()
    d = np.zeros((8, 8, 8))
    for a in range(8):
        for b in range(8):
            for cc in range(8):
                d[a, b, cc] = 0.25 * np.real(
                    np.trace((L[a] @ L[b] + L[b] @ L[a]) @ L[cc]))
    return d


def setup_point(n, gens):
    N, c, L2, alt_idx, B = weyl_basis(n)
    Pi, r = projector(gens, n)
    W = casimir_operator(Pi, r, N)
    th = float(np.sum(W * Q_full(W, c)))
    return N, c, B, W, th, r


def rank_two_formula(n, gens, trials=200):
    """(1) R(x,y) = alpha - (1/2)(beta |z_h|^2 + alpha |z_m|^2), z = [x,y]."""
    N, c, B, W, th, r = setup_point(n, gens)
    e = W / th
    ev, V = np.linalg.eigh(W)
    alpha, beta = float(ev[0] / th), float(ev[-1] / th)
    Pm = V[:, ev < -1e-9] @ V[:, ev < -1e-9].T
    Ph = np.eye(N) - Pm
    rng = np.random.default_rng(0)
    err = 0.0
    best = -np.inf
    for _ in range(trials):
        x = Pm @ rng.normal(size=N); x /= np.linalg.norm(x)
        y = Pm @ rng.normal(size=N); y -= (y @ x) * x; y /= np.linalg.norm(y)
        v = 0.5 * (np.outer(x, y) + np.outer(y, x))
        circ = 0.5 * (Q_full(e + v, c) - Q_full(e, c) - Q_full(v, c))
        direct = float(np.sum(v * circ) / np.sum(v * v))
        z = np.einsum('abg,a,b->g', c, x, y)
        pred = alpha - 0.5 * (beta * np.sum((Ph @ z) ** 2)
                              + alpha * np.sum((Pm @ z) ** 2))
        err = max(err, abs(direct - pred))
        best = max(best, direct)
    return alpha, beta, err, best


def eigenspace_structure(n, gens):
    """(2) and (3): the top eigenspace, its block masses and its dimension."""
    N, c, B, W, th, r = setup_point(n, gens)
    M = Le_matrix(W / th, B, c)
    wv = np.einsum('kmn,mn->k', B, W); wv /= np.linalg.norm(wv)
    P = np.eye(len(B)) - np.outer(wv, wv)
    ev, U = np.linalg.eigh(P @ M @ P)
    top = ev[-2] if abs(ev[-1] - 1) < 1e-6 else ev[-1]
    idxs = np.where(np.abs(ev - top) < 1e-8)[0]
    evW, VW = np.linalg.eigh(W)
    Pm = VW[:, evW < -1e-9] @ VW[:, evW < -1e-9].T
    Ph = np.eye(N) - Pm
    hh = mm = 0.0
    vecs = []
    for k in idxs:
        v = np.einsum('k,kmn->mn', U[:, k], B)
        vecs.append(v)
        t = np.sum(v * v)
        hh += np.sum((Ph @ v @ Ph) ** 2) / t
        mm += np.sum((Pm @ v @ Pm) ** 2) / t
    k = len(idxs)
    return float(top), k, hh / k, mm / k, 1 - hh / k - mm / k, vecs, r


def h_casimir_on_eigenspace(n, gens):
    """Name the violating module invariantly: h acts on the Weyl space by
    X -> [ad_u, X], and its quadratic Casimir is scalar on each isotypic piece,
    so its value on the top eigenspace identifies the module without relying on
    a dimension coincidence."""
    N, c, B, W, th, r = setup_point(n, gens)
    M = Le_matrix(W / th, B, c)
    wv = np.einsum('kmn,mn->k', B, W); wv /= np.linalg.norm(wv)
    P = np.eye(len(B)) - np.outer(wv, wv)
    ev, U = np.linalg.eigh(P @ M @ P)
    top = ev[-2] if abs(ev[-1] - 1) < 1e-6 else ev[-1]
    idxs = np.where(np.abs(ev - top) < 1e-8)[0]
    prs = list(itertools.combinations(range(n), 2))
    pos = {q: k for k, q in enumerate(prs)}
    ads = []
    for A in gens:
        Mat = np.zeros((N, N))
        for a, (i, j) in enumerate(prs):
            for k in range(n):
                if k != j and abs(A[k, i]) > 1e-14:
                    pq = (k, j, 1.0) if k < j else (j, k, -1.0)
                    if pq[0] != pq[1]:
                        Mat[pos[(pq[0], pq[1])], a] += pq[2] * A[k, i]
                if k != i and abs(A[k, j]) > 1e-14:
                    pq = (i, k, 1.0) if i < k else (k, i, -1.0)
                    if pq[0] != pq[1]:
                        Mat[pos[(pq[0], pq[1])], a] += pq[2] * A[k, j]
        ads.append(Mat)
    Cas = np.zeros((len(B), len(B)))
    for A in ads:
        act = np.einsum('mp,kpn->kmn', A, B) - np.einsum('kmp,pn->kmn', B, A)
        Cas += np.einsum('imn,kmn->ik', B,
                         np.einsum('mp,kpn->kmn', A, act)
                         - np.einsum('kmp,pn->kmn', act, A))
    Cas = 0.5 * (Cas + Cas.T)
    sub = U[:, idxs]
    vals = sorted(set(np.round(-np.linalg.eigvalsh(sub.T @ Cas @ sub), 6)))
    return float(top), len(idxs), vals


def main():
    cases = [("so(3) irred in so(5)", 5, h_so3_in_so5()),
             ("so(4)+so(4) graded", 8, h_so_p_so_q(8, 4)),
             ("su(3) adjoint", 8, h_adjoint(su3_structure_constants())),
             ("so(5) adjoint", 10, h_adjoint(so_k_structure_constants(5)))]

    print("(1) rank-two directions: R = alpha - (1/2)(beta|z_h|^2 + alpha|z_m|^2)")
    print(f"{'point':>22} {'alpha':>10} {'-1/(n-1)':>10} {'beta':>10} "
          f"{'max err':>9} {'best R':>9} {'bound':>7}")
    for nm, n, gens in cases:
        a, b, err, best = rank_two_formula(n, gens)
        print(f"{nm:>22} {a:10.6f} {-1/(n-1):10.6f} {b:10.6f} {err:9.1e} "
              f"{best:9.6f} {a*(1-2/2):7.4f}")

    print("\n(2)/(3) the top eigenspace")
    print(f"{'point':>22} {'dim h':>6} {'lambda':>9} {'dim':>4} "
          f"{'hh':>6} {'mm':>6} {'mixed':>6}")
    su3_vecs = None
    for nm, n, gens in cases:
        top, k, hh, mm, mx, vecs, r = eigenspace_structure(n, gens)
        print(f"{nm:>22} {r:6d} {top:9.6f} {k:4d} {hh:6.3f} {mm:6.3f} {mx:6.3f}")
        if nm == "su(3) adjoint":
            su3_vecs = (vecs, gens, n)

    vecs, gens, n = su3_vecs
    prs = list(itertools.combinations(range(n), 2))
    G = np.array([[A[i, j] for (i, j) in prs] for A in gens]).T
    G = G / np.linalg.norm(G, axis=0)
    d = d_tensor()
    A_mat = np.array([(G.T @ v @ G).ravel() for v in vecs])
    D_mat = np.array([np.einsum('abc,c->ab', d, u).ravel() for u in np.eye(8)])
    qa, _ = np.linalg.qr(A_mat.T)
    qd, _ = np.linalg.qr(D_mat.T)
    s = np.linalg.svd(qa.T @ qd, compute_uv=False)
    print("\n(4) the violating module, named by its h-Casimir")
    print(f"{'point':>22} {'lambda':>9} {'dim E':>6} {'Casimir on E':>14}")
    for nm, n, gens in cases:
        if "graded" in nm:
            continue
        top, k, vals = h_casimir_on_eigenspace(n, gens)
        print(f"{nm:>22} {top:9.6f} {k:6d} {str(vals):>14}")

    print(f"\nsu(3): principal cosines between the eigenspace hh-blocks and the "
          f"d_abc family:\n  " + "  ".join(f"{x:.6f}" for x in s))
    print(f"  => {'the same space' if np.allclose(s, 1, atol=1e-6) else 'different'}")


if __name__ == "__main__":
    main()
