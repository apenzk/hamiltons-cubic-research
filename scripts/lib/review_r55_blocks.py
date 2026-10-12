"""Reviewer 55: the k-block vertex system, solved independently.

A k-block operator is coordinate-DIAGONAL on Lambda^2: W(e_i ^ e_j) = w_ij e_i ^ e_j
with w_ij = c[block(i), block(j)].  So it lives entirely inside the diagonal locus.

  Weyl (Ricci-flat + Bianchi)  <=>  hollow symmetric w with zero row sums.
  criticality Q(W) = t W       <=>  w_ij^2 + sum_{k!=i,j} w_ik w_jk = t w_ij.

Normalising t = 1 loses nothing (scale c -> c/t), so we solve the idempotent system.
"""
import numpy as np, itertools, sys
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
from review_r55_core import theta0

def block_pairs(sizes):
    k = len(sizes)
    return [(a, b) for a in range(k) for b in range(a, k) if a != b or sizes[a] >= 2]

def expand(sizes, c):
    """block coefficient vector -> full n x n vertex matrix."""
    k = len(sizes); n = sum(sizes)
    bp = block_pairs(sizes); pos = {p: t for t, p in enumerate(bp)}
    lab = sum([[a]*b for a, b in enumerate(sizes)], [])
    C = np.zeros((k, k))
    for (a, b), t in pos.items():
        C[a, b] = C[b, a] = c[t]
    lam = C[np.ix_(lab, lab)].astype(float)
    np.fill_diagonal(lam, 0.0)
    return lam, C

def residual(sizes, c):
    lam, C = expand(sizes, c)
    n = lam.shape[0]
    M = lam @ lam
    QQ = lam**2 + M
    np.fill_diagonal(QQ, 0.0)
    lab = sum([[a]*b for a, b in enumerate(sizes)], [])
    bp = block_pairs(sizes)
    r = []
    for (a, b) in bp:
        i = lab.index(a)
        j = [x for x in range(n) if lab[x] == b and x != i][0]
        r.append(QQ[i, j] - lam[i, j])
    # row sums
    for a in range(len(sizes)):
        i = lab.index(a)
        r.append(lam[i].sum())
    return np.array(r)

def solve_all(sizes, ntry=4000, seed=0, tol=1e-11):
    rng = np.random.default_rng(seed)
    bp = block_pairs(sizes); m = len(bp)
    sols = []
    for _ in range(ntry):
        x0 = rng.normal(scale=0.6, size=m)
        s = least_squares(lambda c: residual(sizes, c), x0, method='lm',
                          xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=5000)
        if np.linalg.norm(s.fun) > tol: continue
        if np.linalg.norm(s.x) < 1e-8: continue
        sols.append(s.x)
    # dedupe modulo block relabelling
    uniq = []
    for x in sols:
        lam, _ = expand(sizes, x)
        key = np.sort(np.round(np.linalg.eigvalsh(lam), 7))
        keyt = tuple(key)
        if not any(np.allclose(key, k2, atol=1e-6) for k2 in uniq_keys) if False else True:
            pass
        found = False
        for (k2, _) in uniq:
            if np.allclose(key, k2, atol=1e-6): found = True; break
        if not found: uniq.append((key, x))
    return [x for _, x in uniq]

def info(sizes, c):
    lam, C = expand(sizes, c)
    n = lam.shape[0]
    nrm = np.sqrt(0.5 * float((lam**2).sum()))
    P = 0.5 * (float((lam**3).sum()) + float(np.trace(lam @ lam @ lam)))
    th = P / nrm**3
    # distinct rows of the k x k block matrix (with block sizes attached)
    rows = [tuple(np.round(np.concatenate([C[a], [0.0]]), 7)) for a in range(len(sizes))]
    # proper test: rows of the full n x n vertex matrix up to the index itself
    frows = [tuple(np.round(np.sort(lam[i]), 7)) for i in range(n)]
    # negative graph
    E = set((i, j) for i in range(n) for j in range(i+1, n) if lam[i, j] < -1e-9)
    tri = sum(1 for a, b, d in itertools.combinations(range(n), 3)
              if (a, b) in E and (a, d) in E and (b, d) in E)
    # connected components + bipartite test of the negative graph
    adjl = {i: set() for i in range(n)}
    for (i, j) in E: adjl[i].add(j); adjl[j].add(i)
    col = {}; comps = 0; bip = True
    for s in range(n):
        if s in col or not adjl[s]: continue
        comps += 1; col[s] = 0; st = [s]
        while st:
            u = st.pop()
            for v in adjl[u]:
                if v not in col: col[v] = 1-col[u]; st.append(v)
                elif col[v] == col[u]: bip = False
    return dict(theta=th, ratio=th/theta0(n), n=n, tri=tri, edges=len(E),
                comps=comps, bipartite=bip, lam=lam, C=C,
                distinct_block_rows=len(set(map(tuple, np.round(C, 7)))),
                isolated=sum(1 for i in range(n) if not adjl[i]))
