"""Reviewer 32: attack N10 / N11 -- the full L_e spectrum at S^p x S^q.

L_e is symmetric on Sym^2(Lambda^2) and preserves Weyl_n, hence preserves
Weyl_n^perp too, so spec(P L_e P) = spec(L_e|Weyl) union {0}^{codim}.  The
codimension is the rank of the Bianchi+Ricci constraint system, so the zero
multiplicity on Weyl_n is recovered exactly.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import itertools
from fractions import Fraction
from collections import Counter
import numpy as np
import scipy.sparse as sps
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r32_core import (planes, plane_index, struct_sparse_lists,
                             W_pq, L_operator_sparse)


def sym_coord_map(n):
    """Sparse (N^2, D) matrix whose columns are an orthonormal basis of the
    symmetric N x N matrices (row-major vec)."""
    N = n * (n - 1) // 2
    rows, cols, data = [], [], []
    col = 0
    for a in range(N):
        rows.append(a * N + a)
        cols.append(col)
        data.append(1.0)
        col += 1
    s = 1.0 / np.sqrt(2.0)
    for a in range(N):
        for b in range(a + 1, N):
            rows += [a * N + b, b * N + a]
            cols += [col, col]
            data += [s, s]
            col += 1
    return sps.coo_matrix((data, (rows, cols)), shape=(N * N, col)).tocsr(), col


def constraints_in_coords(n):
    """Bianchi + Ricci constraint rows, expressed in the orthonormal symmetric
    coordinates above."""
    N = n * (n - 1) // 2
    pi = plane_index(n)
    off = {}
    col = N
    for a in range(N):
        for b in range(a + 1, N):
            off[(a, b)] = col
            col += 1
    D = col
    rows = []

    def emit(entries):
        """entries: dict (a,b)->value for the symmetric matrix v (a<=b given
        once, value is v[a,b])."""
        v = np.zeros(D)
        for (a, b), val in entries.items():
            if a == b:
                v[a] += val
            else:
                v[off[(min(a, b), max(a, b))]] += np.sqrt(2.0) * val
        rows.append(v)

    for (i, j, k, l) in itertools.combinations(range(n), 4):
        ent = {}
        for (p1, p2, s) in [((i, j), (k, l), 1.0), ((i, k), (j, l), -1.0),
                            ((i, l), (j, k), 1.0)]:
            a, b = pi[p1], pi[p2]
            key = (min(a, b), max(a, b))
            ent[key] = ent.get(key, 0.0) + s
        emit(ent)
    for j in range(n):
        for l in range(j, n):
            ent = {}
            for i in range(n):
                if i == j or i == l:
                    continue
                a = pi[tuple(sorted((i, j)))]
                b = pi[tuple(sorted((i, l)))]
                si = 1.0 if i < j else -1.0
                sl = 1.0 if i < l else -1.0
                key = (min(a, b), max(a, b))
                ent[key] = ent.get(key, 0.0) + si * sl
            emit(ent)
    return np.array(rows), D


def weyl_spectrum(n, p, q, tol=1e-8):
    N = n * (n - 1) // 2
    lists = struct_sparse_lists(n)
    W = W_pq(n, p, q)
    e = W / ((n - 1) / (p * q))
    Lop = L_operator_sparse(n, e, lists)
    Sc, D = sym_coord_map(n)
    M = np.asarray((Sc.T @ (Lop @ Sc)).todense())
    M = 0.5 * (M + M.T)
    C, D2 = constraints_in_coords(n)
    assert D == D2
    u, s, vt = np.linalg.svd(C, full_matrices=False)
    rank = int((s > tol * max(1.0, s[0])).sum())
    Qb = vt[:rank].T                       # (D, rank) orthonormal, Weyl^perp
    QM = Qb.T @ M
    Mp = M - Qb @ QM - (M @ Qb) @ Qb.T + Qb @ (QM @ Qb) @ Qb.T
    Mp = 0.5 * (Mp + Mp.T)
    ev = np.linalg.eigvalsh(Mp)
    dimW = D - rank
    return ev, dimW, rank


def collapse(ev, drop_zeros, tol=1e-7):
    """Bucket eigenvalues, then remove `drop_zeros` of the zeros."""
    ev = np.sort(ev)
    groups = []
    for x in ev:
        if groups and abs(x - groups[-1][0]) < tol:
            groups[-1][1].append(x)
        else:
            groups.append([x, [x]])
    out = []
    for centre, vals in groups:
        m = float(np.mean(vals))
        out.append((m, len(vals)))
    fixed = []
    for m, k in out:
        if abs(m) < tol:
            k -= drop_zeros
            assert k >= 0, (m, k, drop_zeros)
            if k == 0:
                continue
        fixed.append((m, k))
    return fixed


def predicted(p, q):
    n = p + q
    def s(m): return (m + 2) * (m - 1) // 2
    def c(m): return m * (m - 1) // 2
    mu = Fraction(n - 2, 2 * (p - 1) * (q - 1))
    lp = Fraction(p - 2, 2 * (p - 1))
    lq = Fraction(q - 2, 2 * (q - 1))
    acc = Counter()
    acc[-mu] += s(p) * s(q)
    acc[mu] += c(p) * c(q)
    acc[lp] += s(p)
    acc[lq] += s(q)
    acc[Fraction(1, 2)] += p * q
    acc[Fraction(1)] += 1
    dimW = n * (n + 1) * (n + 2) * (n - 3) // 12
    named = sum(acc.values())
    acc[Fraction(0)] += dimW - named
    return {k: v for k, v in acc.items() if v != 0}, named, dimW


def fmt(fr):
    return str(fr)


print(f"{'p,q':>7} {'n':>3} {'dimW':>6} {'named':>7} {'pq(pq+3)/2':>11}  verdict")
splits = []
for n in range(4, 15):
    for p in range(2, n // 2 + 1):
        splits.append((p, n - p))
for (p, q) in splits:
    pred, named, dimW = predicted(p, q)
    target = p * q * (p * q + 3) // 2
    ok = 'named<=dimW OK' if named <= dimW else '*** NAMED EXCEEDS dim Weyl ***'
    print(f"{p:3d},{q:3d} {p+q:3d} {dimW:6d} {named:7d} {target:11d}  "
          f"{'sum==pq(pq+3)/2' if named==target else 'SUM MISMATCH'}; {ok}")

print("\n" + "=" * 78)
print("MEASURED SPECTRA")
print("=" * 78)
NMAX = int(sys.argv[1]) if len(sys.argv) > 1 else 12
fails = []
for (p, q) in splits:
    n = p + q
    if n > NMAX:
        continue
    ev, dimW, codim = weyl_spectrum(n, p, q)
    got = collapse(ev, codim)
    pred, named, dimWf = predicted(p, q)
    assert dimW == dimWf, (dimW, dimWf)
    # match
    predl = sorted(((float(k), v) for k, v in pred.items()))
    gotl = sorted(got)
    same = (len(predl) == len(gotl) and
            all(abs(a[0] - b[0]) < 1e-7 and a[1] == b[1] for a, b in zip(predl, gotl)))
    tag = 'MATCH' if same else '*** MISMATCH ***'
    print(f"\n(p,q)=({p},{q})  n={n}  dim Weyl={dimW}  {tag}")
    print("   measured : " + ", ".join(f"{m:+.9f}^{k}" for m, k in gotl))
    print("   predicted: " + ", ".join(f"{float(k):+.9f}^{v}" for k, v in predl))
    if not same:
        fails.append((p, q))
        print("   predicted (exact): " + ", ".join(f"{fmt(k)}^{v}" for k, v in
                                                  sorted(pred.items(), key=lambda t: float(t[0]))))
    # N11 quantities
    half = [k for m, k in gotl if abs(m - 0.5) < 1e-7]
    lmax = max(m for m, _ in gotl)
    print(f"   dim E(1/2) = {half[0] if half else 0}   pq = {p*q}   "
          f"lambda_max = {lmax:.9f}   #eigs >= 1/2 (excl. 1) = "
          f"{sum(k for m,k in gotl if m > 0.5 - 1e-7 and m < 1 - 1e-7)}")

print("\n\nSPLITS WHERE THE CLOSED FORM FAILED:", fails if fails else "NONE")
