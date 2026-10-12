"""Reviewer 39: independent implementation of Weyl_n, sharp_bilin, and S(p,q).

Written from the definitions only.  Nothing is imported from b_*.py or review_r3*.py.

Conventions (as given in the brief):
  phi_ij = E_ij - E_ji  for i<j, an orthonormal basis of Lambda^2(R^n) under
  <X,Y> = 1/2 tr(X^T Y).
  [phi_a, phi_b] = sum_d c_{abd} phi_d ;  (A_a)_{mn} = c_{a m n}.
  sharp_bilin(X,Y)_{ab} = -1/4 (T_ab + T_ba),  T_ab = tr(A_a X A_b Y).
"""
from fractions import Fraction as F
from itertools import combinations
import numpy as np


# ---------------------------------------------------------------- basis / so(n)

def pair_list(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def struct(n):
    """c[a,b,d] = coefficient of phi_d in [phi_a, phi_b].  Returns int64 array."""
    pr = pair_list(n)
    idx = {p: a for a, p in enumerate(pr)}
    N = len(pr)
    c = np.zeros((N, N, N), dtype=np.int64)
    for a, (i, j) in enumerate(pr):
        for b, (k, l) in enumerate(pr):
            # [phi_ij, phi_kl] = d_jk phi_il + d_il phi_jk - d_jl phi_ik - d_ik phi_jl
            terms = []
            if j == k: terms.append((i, l, 1))
            if i == l: terms.append((j, k, 1))
            if j == l: terms.append((i, k, -1))
            if i == k: terms.append((j, l, -1))
            for (x, y, s) in terms:
                if x == y:
                    continue
                if x < y:
                    c[a, b, idx[(x, y)]] += s
                else:
                    c[a, b, idx[(y, x)]] -= s
    return pr, idx, c


# ------------------------------------------------------------------ sharp_bilin

def sharp_bilin(A, X, Y):
    """A = c tensor (A_a)_{mn} = c[a,m,n].  X, Y are N x N float/int arrays.

    Returns -1/4 (T + T^T) with T_ab = tr(A_a X A_b Y), computed as
    T_ab = sum_{m,n} (A_a X)_{m n} (A_b Y)_{n m}.
    """
    N = X.shape[0]
    M = np.tensordot(A, X, axes=([2], [0]))       # M[a,m,n] = (A_a X)_{mn}
    P = np.tensordot(A, Y, axes=([2], [0]))       # P[b,m,n] = (A_b Y)_{mn}
    T = M.reshape(N, N * N) @ P.transpose(0, 2, 1).reshape(N, N * N).T
    return -(T + T.T) / 4.0


# ------------------------------------------------------- exact rational algebra

def rref(rows, ncols):
    """Exact RREF over Q.  rows = list of dict col->Fraction.  Returns pivots dict."""
    rows = [dict(r) for r in rows]
    piv = {}          # col -> reduced row (dict)
    for r in rows:
        for pc in sorted(piv):
            if pc in r:
                f = r[pc]
                for cc, vv in piv[pc].items():
                    nv = r.get(cc, F(0)) - f * vv
                    if nv:
                        r[cc] = nv
                    else:
                        r.pop(cc, None)
        r = {k: v for k, v in r.items() if v}
        if not r:
            continue
        pc = min(r)
        f = r[pc]
        r = {k: v / f for k, v in r.items()}
        # back-substitute into existing pivot rows
        for opc in list(piv):
            if pc in piv[opc]:
                g = piv[opc][pc]
                nr = dict(piv[opc])
                for cc, vv in r.items():
                    nv = nr.get(cc, F(0)) - g * vv
                    if nv:
                        nr[cc] = nv
                    else:
                        nr.pop(cc, None)
                piv[opc] = nr
        piv[pc] = r
    return piv


def nullspace(rows, cols):
    """cols = ordered list of variable names.  Returns list of dict var->Fraction."""
    pos = {cname: i for i, cname in enumerate(cols)}
    irows = [{pos[k]: F(v) for k, v in r.items() if v} for r in rows]
    piv = rref(irows, len(cols))
    pivcols = set(piv)
    free = [i for i in range(len(cols)) if i not in pivcols]
    basis = []
    for f in free:
        vec = {f: F(1)}
        for pc, r in piv.items():
            if f in r:
                vec[pc] = -r[f]
        basis.append({cols[k]: v for k, v in vec.items() if v})
    return basis


# ------------------------------------------------------ Weyl conditions (exact)

def block_of(pr, p):
    def blk(a):
        i, j = pr[a]
        if j < p:  return 'PP'
        if i >= p: return 'QQ'
        return 'MX'
    return blk


def entry_accessor(idx):
    """R_{ijkl} as a signed reference to the symmetric-matrix variable (min,max)."""
    def get(i, j, k, l):
        if i == j or k == l:
            return None, 0
        s = 1
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        a, b = idx[(i, j)], idx[(k, l)]
        return ((a, b) if a <= b else (b, a)), s
    return get


def weyl_rows(n, idx, allowed):
    """Bianchi + Ricci rows restricted to the variable set `allowed` (set of (a,b), a<=b).

    Entries outside `allowed` are forced to zero, so they simply drop out.
    Returns (bianchi_rows, ricci_rows), each a list of dict var->int.
    """
    get = entry_accessor(idx)

    def term(row, key, s, co=1):
        if key is None or key not in allowed:
            return
        row[key] = row.get(key, 0) + s * co

    bi = []
    for (a, b, d, e) in combinations(range(n), 4):
        # R_abde + R_adeb + R_aebd = 0
        row = {}
        for (i, j, k, l) in ((a, b, d, e), (a, d, e, b), (a, e, b, d)):
            key, s = get(i, j, k, l)
            term(row, key, s)
        row = {k: v for k, v in row.items() if v}
        if row:
            bi.append(row)
    ric = []
    for i in range(n):
        for k in range(i, n):
            row = {}
            for j in range(n):
                key, s = get(i, j, k, j)
                term(row, key, s)
            row = {kk: v for kk, v in row.items() if v}
            if row:
                ric.append(row)
    return bi, ric


def all_vars(N):
    return [(a, b) for a in range(N) for b in range(a, N)]


def support_vars(pr, N, p):
    blk = block_of(pr, p)
    out = []
    for a in range(N):
        for b in range(a, N):
            ba, bb = blk(a), blk(b)
            if {ba, bb} == {'PP', 'MX'}:
                out.append((a, b))
    return out


def to_matrix(vec, N, dtype=object):
    M = np.zeros((N, N), dtype=dtype)
    for (a, b), v in vec.items():
        M[a, b] = v
        M[b, a] = v
    return M
