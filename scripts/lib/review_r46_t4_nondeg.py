"""Reviewer 46, T4: Morse-Bott nondegeneracy at the padded W_CP2, and whether
the slack is continuous AS A FUNCTION where its defining formula jumps.

Nondegeneracy is checked from definitions: on the unit sphere of Weyl_n the
derivative of the criticality map G(W) = Q(W) - P(W) W at a critical point is
D G[v] = 2 B(W,v) - theta v = theta (2 L_e - 1) v on W^perp, so
    ker(Hess) = E(1/2)  of  L_e = B(e, .),  e = W/theta,
and Morse-Bott nondegeneracy is dim E(1/2) = dim orbit.
"""
import sys
import time
import numpy as np
from review_r46_core import (pairs_of, pair_index, structure_constants, weyl_basis,
                             Q_of, P_of, slack_structural, slack_hhm,
                             slack_weighted, slack_theta_identity, so_generators)
from review_r46_t1_cp2 import (u_m_generators, invariant_weyl_line, pad, lambda2_rep)


def make_Le(c, e):
    """Return a callable X -> B(e, X) = (eX + Xe)/2 + (e # X)."""
    N = e.shape[0]
    Y1 = np.einsum('eg,eza->gza', e, c, optimize=True)      # (g, z, a)
    Y1t = np.ascontiguousarray(np.transpose(Y1, (1, 0, 2)))  # (z, g, a)
    Y1f = Y1t.reshape(N, N * N)
    cf = c.reshape(N * N, N)

    def op(X):
        Zt = X.T @ Y1f                     # (d, g*a)
        Z = Zt.reshape(N, N, N)            # (d, g, a)
        Zg = np.transpose(Z, (1, 0, 2)).reshape(N * N, N)   # (g*d, a)
        sh = 0.5 * (Zg.T @ cf)             # (a, b)
        sh = 0.5 * (sh + sh.T)
        return 0.5 * (e @ X + X @ e) + sh
    return op


def orbit_tangent(n, W):
    G = so_generators(n)
    vecs = []
    for A in G:
        r = lambda2_rep(n, A)
        vecs.append((r @ W - W @ r).ravel())
    M = np.array(vecs)
    u, s, vt = np.linalg.svd(M, full_matrices=False)
    tol = max(M.shape) * s[0] * 1e-12
    rank = int((s > tol).sum())
    return vt[:rank], rank


def analyse(n, W4, verbose=True):
    t0 = time.time()
    c = structure_constants(n)
    W = pad(W4, 4, n)
    th = P_of(c, W)
    e = W / th
    Le = make_Le(c, e)
    # self-check: L_e W = W
    err = np.abs(Le(W) - W).max()
    B = weyl_basis(n)
    K = B.shape[0]
    flat = B.reshape(K, -1)
    M = np.zeros((K, K))
    for k in range(K):
        M[:, k] = flat @ Le(B[k]).ravel()
        if verbose and (k + 1) % 400 == 0:
            print(f"      L_e column {k+1}/{K}  ({time.time()-t0:.0f}s)", flush=True)
    asym = np.abs(M - M.T).max()
    M = 0.5 * (M + M.T)
    ev, V = np.linalg.eigh(M)
    tol = 1e-8
    half = np.abs(ev - 0.5) < tol
    dimE = int(half.sum())
    Ovt, orb = orbit_tangent(n, W)
    # do the two subspaces coincide?
    PE = (flat.T @ V[:, half]) 
    PE = PE @ PE.T
    PT = Ovt.T @ Ovt
    dPi = np.abs(PE - PT).max() if dimE == orb else float('nan')
    tr = float(np.trace(M))
    if verbose:
        print(f"  n={n:3d}: dim Weyl={K}  |L_e W - W|={err:.2e}  asym(L_e)={asym:.2e}  "
              f"tr(L_e)={tr:+.3e}")
        print(f"        dim E(1/2)={dimE}   dim orbit={orb}   4n-14={4*n-14}   "
              f"||Pi_E - Pi_T||_max={dPi:.2e}")
        top = np.sort(ev)[::-1][:6]
        print(f"        top L_e eigenvalues: {np.round(top,9)}")
        print(f"        eigenvalue multiplicities near 1/2 within 1e-6: "
              f"{int((np.abs(ev-0.5)<1e-6).sum())}, within 1e-10: {int((np.abs(ev-0.5)<1e-10).sum())}")
        print(f"        ({time.time()-t0:.0f}s)")
    return dict(n=n, K=K, dimE=dimE, orb=orb, dPi=dPi, ev=ev)


def continuity_probe(n, W4, seed=5):
    """Is S continuous AS A FUNCTION at the padded W_CP2, where the formula
    'sum over an orthonormal basis of m' has a jumping index set?"""
    c = structure_constants(n)
    W = pad(W4, 4, n)
    B = weyl_basis(n)
    rng = np.random.default_rng(seed)
    print(f"  n={n}: perturbing inside Weyl_{n}, W_h = (W + h V)/|W + h V|")
    print(f"   {'h':>10} {'dim m':>6} {'S_mmm':>13} {'S_weighted':>13} {'S_theta-id':>13}")
    for trial in range(3):
        V = np.einsum('k,kij->ij', rng.normal(size=B.shape[0]), B)
        V /= np.linalg.norm(V)
        for h in (1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6):
            Wh = W + h * V
            Wh /= np.linalg.norm(Wh)
            ev = np.linalg.eigvalsh(Wh)
            dm = int((ev < -1e-12).sum())
            print(f"   {h:10.0e} {dm:6d} {slack_structural(c, Wh, 1e-12):13.6e} "
                  f"{slack_weighted(c, Wh):13.6e} {slack_theta_identity(n, c, Wh):13.6e}")
        print(f"   {'--':>10} direction {trial+1} done")
    print(f"   at W itself: dim m=2  S_mmm={slack_structural(c, W):.3e}  "
          f"S_weighted={slack_weighted(c, W):.3e}  S_theta-id={slack_theta_identity(n, c, W):.6f}")


if __name__ == "__main__":
    gens, J = u_m_generators(2)
    line = invariant_weyl_line(4, gens)
    W4 = line[0] / np.linalg.norm(line[0])
    c4 = structure_constants(4)
    if P_of(c4, W4) < 0:
        W4 = -W4
    ns = [int(a) for a in sys.argv[1:]] or [8, 10]
    print("=== Morse-Bott nondegeneracy at padded W_CP2 (independent) ===")
    for n in ns:
        analyse(n, W4)
        print()
    print("=== continuity of S at padded W_CP2 ===")
    continuity_probe(8, W4)
