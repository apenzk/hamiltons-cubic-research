"""K4/K5: the k-block vertex system, independently.

A coordinate-diagonal operator constant on block pairs is determined by a symmetric
k x k matrix w.  For i in block a, j in block b (i != j),
    W_{ij,ij} = w_ab ,
    Q_{ij}    = w_ab^2 + sum_c (n_c - [c=a] - [c=b]) w_ac w_bc ,
    Ric_i     = (n_a - 1) w_aa + sum_{c!=a} n_c w_ac ,
    |W|^2     = sum_a C(n_a,2) w_aa^2 + sum_{a<b} n_a n_b w_ab^2 ,
    P         = sum_a C(n_a,2) w_aa Q_aa + sum_{a<b} n_a n_b w_ab Q_ab .
First Bianchi holds automatically for coordinate-diagonal operators.
S_structural = 3 x (number of triangles of the negative graph on the n vertices).
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import itertools, sys
from math import comb
import numpy as np
from scipy.optimize import least_squares


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def Qmat(sizes, w):
    k = len(sizes)
    nsz = np.asarray(sizes, float)
    Qm = np.empty((k, k))
    for a in range(k):
        for b in range(a, k):
            m = nsz.copy()
            m[a] -= 1
            m[b] -= 1
            Qm[a, b] = Qm[b, a] = w[a, b] ** 2 + float(np.sum(m * w[a] * w[b]))
    return Qm


def normsq(sizes, w):
    k = len(sizes)
    t = sum(comb(sizes[a], 2) * w[a, a] ** 2 for a in range(k))
    t += sum(sizes[a] * sizes[b] * w[a, b] ** 2 for a in range(k) for b in range(a + 1, k))
    return t


def Pval(sizes, w, Qm=None):
    k = len(sizes)
    if Qm is None:
        Qm = Qmat(sizes, w)
    t = sum(comb(sizes[a], 2) * w[a, a] * Qm[a, a] for a in range(k))
    t += sum(sizes[a] * sizes[b] * w[a, b] * Qm[a, b] for a in range(k) for b in range(a + 1, k))
    return t


def ricci(sizes, w):
    k = len(sizes)
    nsz = np.asarray(sizes, float)
    return np.array([(sizes[a] - 1) * w[a, a] + sum(sizes[c] * w[a, c] for c in range(k) if c != a)
                     for a in range(k)])


def pack(w, k):
    return np.array([w[a, b] for a in range(k) for b in range(a, k)])


def unpack(z, k):
    w = np.zeros((k, k)); t = 0
    for a in range(k):
        for b in range(a, k):
            w[a, b] = w[b, a] = z[t]; t += 1
    return w


def residual(z, sizes):
    k = len(sizes)
    w = unpack(z, k)
    Qm = Qmat(sizes, w)
    th = Pval(sizes, w, Qm)
    r = [Qm[a, b] - th * w[a, b] for a in range(k) for b in range(a, k)]
    r += list(ricci(sizes, w))
    r.append(normsq(sizes, w) - 1.0)
    return np.array(r)


def triangles(sizes, w, tol=1e-9):
    """triangles of the negative graph on the n = sum(sizes) vertices."""
    k = len(sizes); t = 0
    neg = w < -tol
    for a in range(k):
        if neg[a, a]:
            t += comb(sizes[a], 3)
        for b in range(k):
            if b == a: continue
            if neg[a, a] and neg[a, b]:
                t += comb(sizes[a], 2) * sizes[b]
    for a, b, c in itertools.combinations(range(k), 3):
        if neg[a, b] and neg[a, c] and neg[b, c]:
            t += sizes[a] * sizes[b] * sizes[c]
    return t


def effective_rows(w, tol=1e-6):
    """group blocks with identical rows; returns the grouping."""
    k = w.shape[0]
    groups = []
    used = [False] * k
    for a in range(k):
        if used[a]: continue
        g = [a]; used[a] = True
        for b in range(a + 1, k):
            if not used[b] and np.abs(w[a] - w[b]).max() < tol:
                g.append(b); used[b] = True
        groups.append(g)
    return groups


def solve_family(sizes, starts=400, seed=0, tol=1e-11):
    """all critical points of the block-symmetric system, deduplicated."""
    k = len(sizes); n = sum(sizes)
    rng = np.random.default_rng(seed)
    found = []
    for _ in range(starts):
        z0 = rng.normal(size=k * (k + 1) // 2)
        z0 /= np.sqrt(max(normsq(sizes, unpack(z0, k)), 1e-12))
        sol = least_squares(residual, z0, args=(sizes,), xtol=1e-15, ftol=1e-15,
                            gtol=1e-15, max_nfev=5000)
        if np.linalg.norm(sol.fun) > 1e-10:
            continue
        w = unpack(sol.x, k)
        th = Pval(sizes, w)
        if th < 0:
            w, th = -w, -th
        if th < 1e-9:
            continue
        key = np.sort(np.round(np.concatenate([w.ravel(), [th]]), 8))
        if not any(np.allclose(key, f[0], atol=1e-6) for f in found):
            found.append((key, w, th))
    return [(w, th) for _, w, th in found]


if __name__ == "__main__":
    # validate the reduced system against the full structure-constant machinery
    sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
    from review_r54_core import pairs_of, Q as Qfull, P as Pfull, ricci_of, slack_structural

    def full_W(sizes, w):
        n = sum(sizes); ps, idx = pairs_of(n)
        lab = []
        for bi, b in enumerate(sizes): lab += [bi] * b
        Wf = np.zeros((len(ps), len(ps)))
        for a, (i, j) in enumerate(ps):
            Wf[a, a] = w[lab[i], lab[j]]
        return Wf

    print("=== validation of the reduced vertex system against the full operator ===")
    rng = np.random.default_rng(1)
    for sizes in [(2,2,2,2,2), (3,3,4), (2,3,3,4), (4,4,4)]:
        n = sum(sizes); k = len(sizes)
        w = rng.normal(size=(k, k)); w = (w + w.T) / 2
        Wf = full_W(sizes, w)
        Qm = Qmat(sizes, w); Qf = Qfull(n, Wf)
        ps, idx = pairs_of(n)
        lab = []
        for bi, b in enumerate(sizes): lab += [bi] * b
        err = max(abs(Qf[a, a] - Qm[lab[i], lab[j]]) for a, (i, j) in enumerate(ps))
        offd = np.abs(Qf - np.diag(np.diag(Qf))).max()
        nerr = abs(normsq(sizes, w) - np.sum(Wf * Wf))
        perr = abs(Pval(sizes, w) - Pfull(n, Wf))
        rerr = abs(np.abs(ricci_of(n, Wf)).max() - 0) if np.abs(ricci(sizes, w)).max() < 1e-12 else \
               max(abs(ricci_of(n, Wf)[i, i] - ricci(sizes, w)[lab[i]]) for i in range(n))
        print(f" {sizes}: Q err={err:.2e} offdiag={offd:.2e} |W|^2 err={nerr:.2e} P err={perr:.2e} Ric err={rerr:.2e}")

    print("\n=== S_structural = 3 x triangles, checked against the operator-level slack ===")
    for sizes, wspec in [((2,2,2,2,2), 'c5'), ((3,3,3), 'sph'), ((2,2,4), 'sph'), ((2,2,2,2,2), 'rand')]:
        n = sum(sizes); k = len(sizes)
        if wspec == 'c5':
            w = np.zeros((k, k))
            for a in range(k):
                for b in range(k):
                    w[a, b] = 4.0 if a == b else (-2.0 if (a - b) % k in (1, k - 1) else 1.0)
        elif wspec == 'sph':
            w = np.zeros((k, k))
            for a in range(k):
                for b in range(k):
                    w[a, b] = 1.0 / (sizes[a]*(sizes[a]-1)) if a == b else -1.0/(sizes[a]*sizes[b])
        else:
            w = rng.normal(size=(k, k)); w = (w + w.T) / 2
        Wf = full_W(sizes, w); Wf /= np.linalg.norm(Wf)
        wn = w / np.sqrt(normsq(sizes, w))
        print(f" {sizes} {wspec}: slack_struct(full)={slack_structural(n, Wf):.6f}  3*tri={3*triangles(sizes, wn):.1f}")
