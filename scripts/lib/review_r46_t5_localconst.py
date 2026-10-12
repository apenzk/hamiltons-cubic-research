"""Reviewer 46, T5: is the slack locally constant on Crit(P)?

Facts used, all re-derived here:
  * on the unit sphere of Weyl_n the criticality map is G(W) = Q(W) - P(W) W,
    and D G[v] = theta (2 L_e - 1) v on W^perp, so  T_W Crit  is contained in
    E(1/2) of L_e;
  * at a Morse-Bott nondegenerate point E(1/2) = T(orbit), so Crit is locally
    one orbit and every SO(n)-invariant function -- S included -- is locally
    constant there for free;
  * hence the whole question lives at the DEGENERATE critical points, which is
    the same place route B's crux lives.

The script surveys a catalogue at n = 8, marks degenerate points, and at each
one measures the directional derivative of the continuous slack
S_w = <(W_-)^#, W_-> along E(1/2) \\ T(orbit) -- the only directions a path of
critical points could leave along.
"""
import numpy as np
from review_r46_core import (structure_constants, weyl_basis, Q_of, P_of,
                             sharp, negative_part, slack_structural, slack_hhm,
                             slack_weighted, so_generators)
from review_r46_t1_cp2 import u_m_generators, invariant_weyl_line, pad, lambda2_rep
from review_r46_t4_nondeg import make_Le, orbit_tangent
from review_r46_t3_hunt import diag_operator, srg_point, perfect_matching, complete_bipartite
from review_r46_t2_identity import two_block


def spectral_data(n, W, c, B, flat, verbose=True, name=""):
    th = P_of(c, W)
    res = np.abs(Q_of(c, W) - th * W).max()
    Le = make_Le(c, W / th) if abs(th) > 1e-12 else None
    if Le is None:
        return None
    K = B.shape[0]
    M = np.zeros((K, K))
    for k in range(K):
        M[:, k] = flat @ Le(B[k]).ravel()
    M = 0.5 * (M + M.T)
    ev, V = np.linalg.eigh(M)
    half = np.abs(ev - 0.5) < 1e-8
    dimE = int(half.sum())
    Ovt, orb = orbit_tangent(n, W)
    E = (flat.T @ V[:, half]).T            # (dimE, N*N) rows spanning E(1/2)
    # directions inside E(1/2) orthogonal to the orbit tangent
    proj = E - (E @ Ovt.T) @ Ovt
    u, s, vt = np.linalg.svd(proj, full_matrices=False)
    extra = vt[s > 1e-8 * max(1.0, s[0])] if s.size else np.zeros((0, W.size))
    return dict(theta=th, res=res, dimE=dimE, orb=orb, extra=extra,
                Smmm=slack_structural(c, W), Shhm=slack_hhm(c, W),
                Sw=slack_weighted(c, W))


def dSw(n, c, W, v, h=1e-5):
    N = W.shape[0]
    V = v.reshape(N, N)
    V = 0.5 * (V + V.T)
    V /= np.linalg.norm(V)
    def f(t):
        X = W + t * V
        X /= np.linalg.norm(X)
        return slack_weighted(c, X)
    return (f(h) - f(-h)) / (2 * h), (f(h) - 2 * f(0) + f(-h)) / h ** 2


def survey(n):
    c = structure_constants(n)
    B = weyl_basis(n)
    flat = B.reshape(B.shape[0], -1)
    cat = {}
    # CP2 padded
    g, _ = u_m_generators(2)
    W4 = invariant_weyl_line(4, g)[0]; W4 /= np.linalg.norm(W4)
    if P_of(structure_constants(4), W4) < 0:
        W4 = -W4
    cat["W_CP2 padded"] = pad(W4, 4, n)
    # Fox plateau: CP2 on {0,1,2,3} plus CP2 on {4,5,6,7}
    if n >= 8:
        from review_r46_core import pairs_of, pair_index
        ib = pair_index(n)
        Ps = pairs_of(4)
        WB = np.zeros_like(cat["W_CP2 padded"])
        for a, (i, j) in enumerate(Ps):
            for b, (k, l) in enumerate(Ps):
                WB[ib[(i + 4, j + 4)], ib[(k + 4, l + 4)]] = W4[a, b]
        cat["Fox plateau"] = (cat["W_CP2 padded"] + WB) / np.sqrt(2.0)
    # sphere products
    for p in range(2, n // 2 + 1):
        lam = two_block(n, p)
        cat[f"S^{p} x S^{n-p}"] = diag_operator(
            n, {(i, j): lam[i, j] for i in range(n) for j in range(i + 1, n)})
    # ungraded diagonal points: perfect matching, and multi-block products
    lam, _, _ = srg_point(perfect_matching(n))
    cat["perfect matching"] = diag_operator(
        n, {(i, j): lam[i, j] for i in range(n) for j in range(i + 1, n)})
    # multi-block products (ungraded)
    for blocks in ([2, 3, 3], [2, 2, 4], [2, 2, 2, 2]):
        if sum(blocks) != n:
            continue
        lab = []
        for bi, bs in enumerate(blocks):
            lab += [bi] * bs
        lamd = np.zeros((n, n))
        x = -1.0
        for i in range(n):
            bk = blocks[lab[i]]
            for j in range(n):
                if i == j:
                    continue
                if lab[i] == lab[j]:
                    lamd[i, j] = -(n - bk) * x / (bk - 1)
                else:
                    lamd[i, j] = x
        cat["x".join(f"S^{b}" for b in blocks)] = diag_operator(
            n, {(i, j): lamd[i, j] for i in range(n) for j in range(i + 1, n)})

    print(f"=== n={n}: catalogue, degeneracy, and dS_w on E(1/2) \\ T(orbit) ===")
    print(f"{'point':20s} {'theta':>13} {'crit.res':>9} {'dimE':>5} {'orbit':>6} "
          f"{'excess':>7} {'S_mmm':>11} {'S_hhm':>9} {'S_w':>11}")
    results = {}
    for name, W in cat.items():
        W = W / np.linalg.norm(W)
        if P_of(c, W) < 0:
            W = -W
        d = spectral_data(n, W, c, B, flat, name=name)
        if d is None:
            print(f"{name:20s}  theta = 0, skipped")
            continue
        if d['res'] > 1e-9:
            print(f"{name:20s}  NOT critical (res {d['res']:.1e}), skipped")
            continue
        print(f"{name:20s} {d['theta']:13.9f} {d['res']:9.1e} {d['dimE']:5d} {d['orb']:6d} "
              f"{d['dimE']-d['orb']:7d} {d['Smmm']:11.3e} {d['Shhm']:9.3f} {d['Sw']:11.3e}")
        results[name] = (W, d)
    print()
    print("--- first and second derivative of the continuous slack S_w along the")
    print("    extra kernel directions (the only ones a branch of Crit can use) ---")
    for name, (W, d) in results.items():
        ex = d['extra']
        if ex.shape[0] == 0:
            print(f"{name:20s} nondegenerate: Crit is locally the orbit, S locally constant")
            continue
        d1s, d2s = [], []
        for v in ex:
            a, b = dSw(n, c, W, v)
            d1s.append(abs(a)); d2s.append(b)
        print(f"{name:20s} excess={ex.shape[0]:3d}  max|dS_w| = {max(d1s):.3e}   "
              f"second derivative range [{min(d2s):+.3e}, {max(d2s):+.3e}]")
    return results


if __name__ == "__main__":
    survey(8)
