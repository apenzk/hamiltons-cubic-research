"""r68: the load-bearing question -- are the block estimates behind bounds (a),(b),(c) valid?

Attacks each estimate separately on families of S=0 operators (and on general ones,
to map the exact scope), reporting the worst slack found.

Families
  F1  d in {1,2}: any operator with at most two negative eigenvalues has S_mmm=0
      automatically, so m may be an ARBITRARY subspace -- random O(N) eigenframes.
  F2  m = span of coordinate planes whose index pairs form a triangle-free graph
      (S_mmm=0 is a property of the subspace m), with an arbitrary negative-definite
      operator on m and an arbitrary PSD operator on h.  Arbitrary d.
  F3  general random symmetric traceless operators (S_mmm > 0) -- scope probe.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from itertools import combinations
import review_r68_core as R
from review_r68_bounds import bounds

rng = np.random.default_rng(6868)


def rand_orth(N, rng):
    A = rng.normal(size=(N, N))
    q, r = np.linalg.qr(A)
    return q * np.sign(np.diag(r))


def make_from_blocks(N, m_basis, negspec, h_basis, posspec):
    W = np.zeros((N, N))
    for lamv, vec in zip(negspec, m_basis.T):
        W += lamv * np.outer(vec, vec)
    for lamv, vec in zip(posspec, h_basis.T):
        W += lamv * np.outer(vec, vec)
    return W


def F1(n, N, rng, d=None):
    d = d if d is not None else int(rng.integers(1, 3))
    Q = rand_orth(N, rng)
    neg = -np.abs(rng.gamma(rng.uniform(0.3, 3.0), size=d))
    k = int(rng.integers(1, N - d + 1))
    pos = np.abs(rng.gamma(rng.uniform(0.2, 3.0), size=k))
    pos = pos * ((-neg.sum()) / pos.sum())          # traceless
    spec = np.concatenate([neg, pos, np.zeros(N - d - k)])
    W = (Q * spec) @ Q.T
    return W / np.linalg.norm(spec)


def triangle_free_edges(n, rng, target):
    """Random triangle-free edge set on n vertices."""
    E = list(combinations(range(n), 2))
    rng.shuffle(E)
    chosen = []
    adj = {i: set() for i in range(n)}
    for (i, j) in E:
        if len(chosen) >= target:
            break
        if adj[i] & adj[j]:
            continue
        chosen.append((i, j)); adj[i].add(j); adj[j].add(i)
    return chosen


def F2(n, N, rng, target=None):
    P = R.pairs(n)
    idx = {p: k for k, p in enumerate(P)}
    target = target if target is not None else int(rng.integers(1, max(2, n * n // 4)))
    edges = triangle_free_edges(n, rng, target)
    d = len(edges)
    mcols = np.zeros((N, d))
    for c, e in enumerate(edges):
        mcols[idx[e], c] = 1.0
    hcols = np.zeros((N, N - d))
    rest = [k for k in range(N) if k not in {idx[e] for e in edges}]
    for c, k in enumerate(rest):
        hcols[k, c] = 1.0
    # arbitrary rotations inside m and inside h
    mcols = mcols @ rand_orth(d, rng)
    hcols = hcols @ rand_orth(N - d, rng)
    neg = -np.abs(rng.gamma(rng.uniform(0.3, 3.0), size=d))
    kpos = int(rng.integers(1, N - d + 1))
    pos = np.abs(rng.gamma(rng.uniform(0.2, 3.0), size=kpos))
    pos *= (-neg.sum()) / pos.sum()
    posspec = np.concatenate([pos, np.zeros(N - d - kpos)])
    W = make_from_blocks(N, mcols, neg, hcols, posspec)
    return W / np.sqrt(np.sum(neg**2) + np.sum(posspec**2))


def F3(n, N, rng):
    A = rng.normal(size=(N, N)); A = (A + A.T) / 2
    A -= np.trace(A) / N * np.eye(N)
    return A / np.linalg.norm(A)


def check(n, W, C, tol=1e-12):
    an = R.analyse(n, W, C, tol)
    bd = bounds(an['lam'], n, tol)
    B = an['B']
    N = an['N']; d = an['d']
    out = {}
    out['ppp_spec'] = bd['ppp_spec'] - B['hhh']     # (b) (+++)  slack, want >= 0
    out['pmm_spec'] = bd['pmm_spec'] - B['mmh']     # (b) (+--)
    out['ppp_mass'] = bd['ppp_mass'] - B['hhh']     # (a) (+++)
    out['pmm_mass'] = bd['pmm_mass'] - B['mmh']     # (a) (+--)
    out['ppb_neg'] = -B['mhh']                      # (++-) <= 0
    out['mmm_neg'] = -B['mmm']                      # (---) <= 0
    out['bound_a'] = bd['a'] - an['theta']
    out['bound_b'] = bd['b'] - an['theta']
    out['bound_c'] = bd['c'] - an['theta']
    out['Smmm'] = an['S']['mmm']
    out['d'] = d
    out['theta'] = an['theta']
    out['npos'] = bd['npos']
    return out, an, bd


if __name__ == '__main__':
    ns = [5, 6, 7, 8]
    keys = ['ppp_spec', 'pmm_spec', 'ppp_mass', 'pmm_mass', 'ppb_neg', 'mmm_neg', 'bound_a', 'bound_b', 'bound_c']
    for fam, fn, ntr in [('F1 d<=2 random frame', F1, 200), ('F2 triangle-free m', F2, 200), ('F3 generic (S>0)', F3, 120)]:
        print(f"--- family {fam} ---")
        for n in ns:
            C = R.struct(n)
            N = n * (n - 1) // 2
            worst = {k: (np.inf, None) for k in keys}
            maxSmmm = 0.0
            for t in range(ntr):
                W = fn(n, N, rng)
                out, an, bd = check(n, W, C, tol=1e-12)
                maxSmmm = max(maxSmmm, out['Smmm'])
                for k in keys:
                    if out[k] < worst[k][0]:
                        worst[k] = (out[k], (out['d'], out['npos'], out['theta']))
            print(f" n={n} maxS_mmm={maxSmmm:.3e} " + " ".join(
                f"{k}:{worst[k][0]:+.3e}" for k in keys))


def scope_probe():
    """Is S_mmm = 0 load-bearing for (a)?  Is it needed for (b)?

    Diagonal operator: negatives -eps on all edges of a clique on the first k vertices
    (so S_mmm = C(k,3) > 0), positives on the remaining edges.
    """
    import review_r68_core as R
    from review_r68_bounds import bounds
    print("=== scope probe: bounds (a),(b) on operators with S_mmm > 0 ===")
    print(f"{'n':>3} {'k':>3} {'d':>4} {'S_mmm':>8} {'theta':>10} {'(a)':>11} {'(b)':>11} {'a valid':>8} {'b valid':>8}")
    for n in [7, 8, 9]:
        C = R.struct(n)
        P = R.pairs(n)
        for k in range(3, n + 1):
            diag = np.array([-1.0 if (i < k and j < k) else 0.0 for (i, j) in P])
            neg = diag < 0
            pos_ct = (~neg).sum()
            if pos_ct == 0:
                continue
            diag[~neg] = (-diag[neg].sum()) / pos_ct
            diag /= np.linalg.norm(diag)
            W = np.diag(diag)
            an = R.analyse(n, W, C)
            bd = bounds(an['lam'], n)
            print(f"{n:>3} {k:>3} {an['d']:>4} {an['S']['mmm']:8.1f} {an['theta']:10.6f} "
                  f"{bd['a']:11.5f} {bd['b']:11.5f} {str(bd['a'] >= an['theta'] - 1e-9):>8} {str(bd['b'] >= an['theta'] - 1e-9):>8}")
