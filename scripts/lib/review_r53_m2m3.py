"""Reviewer 53, M2 + M3.

M2  the block-symmetric vertex solver: correctness (solutions really critical and
    Ricci-flat once embedded) and completeness (is anything missing?).
    Completeness is settled EXACTLY for k=3: the block-symmetric Ricci-flat
    coordinate-diagonal operators form a 3-dimensional space V (= Weyl_n^K for
    K = O(p)xO(q)xO(r), which is multiplicity-free), so the whole critical set of
    P|_V is the solution set of 3 quadrics, solved over Q with a Groebner basis.

M3  (S^3)^3 at n=9: theta, criticality residual, orbit dimension, dim E(1/2).
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import itertools
import sys
import time

import numpy as np
from scipy.optimize import least_squares

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Le_matrix, Npairs, Pval, Qop, alt, circ, onb_rows,
                             orbit_tangent, pairs_of, ricci, theta0, weyl_basis)

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


# ---------------------------------------------------------------- vertex system

def vertex_residual(blocks, w, th):
    """Row sums (Ricci) and per-pair-class criticality, from the definitions."""
    k = len(blocks)
    res = []
    for a in range(k):
        res.append((blocks[a] - 1) * w[a, a]
                   + sum(blocks[b] * w[a, b] for b in range(k) if b != a))
    for a in range(k):
        for b in range(a, k):
            if a == b and blocks[a] < 2:
                res.append(w[a, a])
                continue
            s = 0.0
            for c in range(k):
                cnt = blocks[c] - (1 if c == a else 0) - (1 if c == b else 0)
                s += cnt * w[a, c] * w[b, c]
            res.append(w[a, b] ** 2 + s - th * w[a, b])
    return np.array(res)


def wnorm2(blocks, w):
    k = len(blocks)
    t = 0.0
    for a in range(k):
        t += blocks[a] * (blocks[a] - 1) / 2 * w[a, a] ** 2
        for b in range(a + 1, k):
            t += blocks[a] * blocks[b] * w[a, b] ** 2
    return t


def solve_vertex(blocks, nstart=800, seed=53):
    """My own multistart solve of the block-symmetric vertex system."""
    k = len(blocks)
    idxs = [(a, b) for a in range(k) for b in range(a, k)]
    rng = np.random.default_rng(seed)

    def unpack(z):
        w = np.zeros((k, k))
        for t, (a, b) in enumerate(idxs):
            w[a, b] = w[b, a] = z[t]
        return w, z[len(idxs)]

    def F(z):
        w, th = unpack(z)
        r = list(vertex_residual(blocks, w, th))
        r.append(wnorm2(blocks, w) - 1.0)
        return np.array(r)

    found = []
    for _ in range(nstart):
        z0 = np.concatenate([rng.standard_normal(len(idxs)) * 0.5,
                             [rng.standard_normal() * 1.5]])
        sol = least_squares(F, z0, method='lm', xtol=1e-15, ftol=1e-15, gtol=1e-15)
        if np.linalg.norm(F(sol.x)) > 1e-12:
            continue
        w, th = unpack(sol.x)
        if th < 0:
            w, th = -w, -th
        found.append((w, th))
    # dedupe up to permutation of equal-sized blocks
    uniq = []
    for w, th in found:
        dup = False
        for w2, th2 in uniq:
            if abs(th - th2) > 1e-8:
                continue
            for perm in itertools.permutations(range(k)):
                if any(blocks[perm[i]] != blocks[i] for i in range(k)):
                    continue
                if np.max(np.abs(w[np.ix_(perm, perm)] - w2)) < 1e-7:
                    dup = True
                    break
            if dup:
                break
        if not dup:
            uniq.append((w, th))
    return uniq


def embed(blocks, w):
    n = sum(blocks)
    prs, _ = pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    lam = np.array([w[lab[i], lab[j]] for (i, j) in prs])
    return np.diag(lam)


# ---------------------------------------------------------------- exact k=3 census

def invariant_space(blocks):
    """Orthonormal (Frobenius) basis of the block-symmetric coordinate-diagonal
    Ricci-flat operators, as N x N matrices, plus a RATIONAL spanning set."""
    from fractions import Fraction
    k = len(blocks)
    idxs = [(a, b) for a in range(k) for b in range(a, k)]
    # linear row-sum constraints in the coefficients of the pair-classes
    A = []
    for a in range(k):
        row = [0] * len(idxs)
        for t, (p, q) in enumerate(idxs):
            if p == q == a:
                row[t] += blocks[a] - 1
            elif p == a:
                row[t] += blocks[q]
            elif q == a:
                row[t] += blocks[p]
        A.append(row)
    import sympy as sp
    M = sp.Matrix(A)
    ns = M.nullspace()          # rational basis vectors
    return idxs, [list(v) for v in ns]


def exact_k3_census(blocks):
    """Complete critical set of P restricted to the invariant space V, over Q."""
    import sympy as sp
    n = sum(blocks)
    idxs, ns = invariant_space(blocks)
    d = len(ns)
    # build the matrices for the rational basis
    Bs = []
    for v in ns:
        w = sp.zeros(len(blocks), len(blocks))
        for t, (a, b) in enumerate(idxs):
            w[a, b] = w[b, a] = v[t]
        Bs.append(np.array(sp.Matrix(w).evalf(30), dtype=float))
    Mats = [embed(blocks, w) for w in Bs]
    # Gram and cubic tensor, numerically, then rationalised
    G = np.array([[float(np.sum(Mats[i] * Mats[j])) for j in range(d)] for i in range(d)])
    T = np.zeros((d, d, d))
    for i in range(d):
        for j in range(d):
            cj = circ(n, Mats[i], Mats[j])
            for l in range(d):
                T[i, j, l] = float(np.sum(Mats[l] * cj))
    Gq = sp.Matrix(d, d, lambda i, j: sp.nsimplify(G[i, j], rational=True))
    Tq = [[[sp.nsimplify(T[i, j, l], rational=True) for l in range(d)]
           for j in range(d)] for i in range(d)]
    xs = sp.symbols(f'x0:{d}')
    eqs = []
    for l in range(d):
        lhs = sum(Tq[i][j][l] * xs[i] * xs[j] for i in range(d) for j in range(d))
        rhs = sum(Gq[l, i] * xs[i] for i in range(d))
        eqs.append(sp.expand(lhs - rhs))          # theta normalised to 1
    sols = sp.solve(eqs, xs, dict=True)
    out = []
    for s in sols:
        vec = np.array([float(sp.re(sp.N(s.get(x, 0)))) for x in xs])
        if np.linalg.norm(vec) < 1e-12:
            continue
        W = sum(vec[i] * Mats[i] for i in range(d))
        nn = np.linalg.norm(W)
        out.append((W / nn, 1.0 / nn))
    return out, d


# ---------------------------------------------------------------- report

def full_check(blocks, W, th):
    n = sum(blocks)
    Wn = W / np.linalg.norm(W)
    thn = Pval(n, Wn)
    res = float(np.linalg.norm(Qop(n, Wn) - thn * Wn))
    return dict(n=n, theta=thn, res=res,
                ric=float(np.linalg.norm(ricci(n, Wn))),
                alt=float(np.linalg.norm(alt(n, Wn))))


def main():
    log("M2: block-symmetric vertex solver -- correctness and completeness")

    for blocks in [(3, 3, 3), (4, 4, 4), (3, 3, 6), (2, 5, 5), (3, 4, 5)]:
        n = sum(blocks)
        sols = solve_vertex(blocks)
        log(f"  blocks={blocks} n={n}: my multistart found {len(sols)} distinct solutions")
        for w, th in sorted(sols, key=lambda t: -t[1]):
            W = embed(blocks, w)
            ch = full_check(blocks, W, th)
            vr = float(np.linalg.norm(vertex_residual(blocks, w, th)))
            log(f"     theta_vertex={th:.9f} theta_full={ch['theta']:.9f} "
                f"vertex_resid={vr:.1e} full_resid={ch['res']:.2e} "
                f"|Ric|={ch['ric']:.2e} |Alt|={ch['alt']:.2e} "
                f"w={np.round(w[np.triu_indices(len(blocks))], 6)}")

    log("M2 exact census over Q for k=3 (all critical points of P on the invariant space):")
    for blocks in [(3, 3, 3), (4, 4, 4), (3, 3, 6)]:
        try:
            cen, d = exact_k3_census(blocks)
        except Exception as exc:                       # pragma: no cover
            log(f"  blocks={blocks}: symbolic census failed: {exc}")
            continue
        n = sum(blocks)
        log(f"  blocks={blocks} n={n}: dim V = {d}, {len(cen)} nonzero critical rays")
        for W, th in sorted(cen, key=lambda t: -t[1]):
            ch = full_check(blocks, W, th)
            log(f"     theta={ch['theta']:+.9f}  full_resid={ch['res']:.2e} "
                f"|Ric|={ch['ric']:.2e}  theta/theta_0={ch['theta']/theta0(n):+.6f}")

    # ------------------------------------------------------------------ M3
    log("M3: (S^3)^3 at n=9")
    blocks = (3, 3, 3)
    n = 9
    sols = solve_vertex(blocks)
    # fully block-symmetric branch: w_aa equal across blocks, w_ab equal
    target = None
    for w, th in sols:
        diag = [w[a, a] for a in range(3)]
        off = [w[a, b] for a in range(3) for b in range(a + 1, 3)]
        if (max(diag) - min(diag) < 1e-9 and max(off) - min(off) < 1e-9
                and abs(off[0]) > 1e-9):
            if target is None or th > target[1]:
                target = (w, th)
    w, th = target
    W = embed(blocks, w)
    W = W / np.linalg.norm(W)
    thn = Pval(n, W)
    res = float(np.linalg.norm(Qop(n, W) - thn * W))
    log(f"  fully block-symmetric vertex matrix w = {np.round(w, 12).tolist()}")
    log(f"  theta = {thn:.12f}   theta_0(9) = {theta0(9):.12f}   "
        f"ratio = {thn/theta0(9):.9f}")
    log(f"  criticality residual = {res:.3e}   |Ric| = {np.linalg.norm(ricci(n,W)):.2e}"
        f"   |Alt| = {np.linalg.norm(alt(n,W)):.2e}")
    B = weyl_basis(n)
    t0 = time.time()
    M = Le_matrix(n, W / thn, B)
    ev = np.linalg.eigvalsh(M)
    for tol in (1e-6, 1e-8, 1e-10):
        log(f"  dim E(1/2) at tol {tol:.0e}: {int((np.abs(ev-0.5)<tol).sum())}")
    orb = onb_rows(orbit_tangent(n, W)).shape[0]
    log(f"  orbit dimension = {orb}   (dim so(9) - dim so(3)^3 = 36 - 9 = 27)")
    log(f"  L_e spectrum multiset (rounded 9dp): "
        f"{sorted(set(np.round(ev,9)))}")
    cnt = {}
    for v in np.round(ev, 9):
        cnt[v] = cnt.get(v, 0) + 1
    log(f"  multiplicities: {sorted(cnt.items(), key=lambda t: -t[0])}")
    log(f"  [Le build {time.time()-t0:.1f}s, dim Weyl_9 = {B.shape[0]}]")
    # do the orbit tangent and E(1/2) coincide?
    U = onb_rows(orbit_tangent(n, W))
    Evec = np.linalg.eigh(M)[1][:, np.abs(ev - 0.5) < 1e-8]
    Emat = np.einsum('kd,dij->kij', Evec.T, B)
    Erow = onb_rows(Emat)
    cos = np.linalg.svd(U @ Erow.T, compute_uv=False)
    log(f"  principal cosines orbit vs E(1/2): min={cos.min():.9f} max={cos.max():.9f} "
        f"(orbit {U.shape[0]}, E {Erow.shape[0]})")
    log("M2/M3 done")


if __name__ == '__main__':
    main()
