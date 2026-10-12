"""Reviewer 32: exact certification of the L_e spectrum at S^p x S^q.

L_e is a real symmetric operator on Weyl_n, hence diagonalisable.  If for the
predicted set of distinct eigenvalues {lam_i} the EXACT nullities of
(L_e - lam_i I) sum to dim Weyl_n, the spectrum is exactly that set with
exactly those multiplicities: no hidden eigenvalue in either direction.

Two modes:
  * exact  -- Gauss-Jordan over Q with Fraction.  Decisive, feasible to n=8.
  * modp   -- elimination over F_p with numpy int64.  rank_p <= rank_Q, so
              nullity_Q <= nullity_p: this rigorously bounds each multiplicity
              from ABOVE, which is the direction N11 needs for dim E(1/2).

Usage:  python3 review_r32_exact.py exact 6 8
        python3 review_r32_exact.py modp  10 11 12
"""
import sys
import itertools
from fractions import Fraction as F
from collections import Counter
import numpy as np

PRIMES = [2147483629, 2147483587]


# ------------------------------------------------------------------- structure

def planes(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def bracket(A, B):
    i, j = A
    k, l = B
    out = {}

    def add(x, y, co):
        if x == y:
            return
        t = (x, y) if x < y else (y, x)
        out[t] = out.get(t, 0) + (co if x < y else -co)
    if j == k:
        add(i, l, 1)
    if i == k:
        add(j, l, -1)
    if j == l:
        add(i, k, -1)
    if i == l:
        add(j, k, 1)
    return {t: v for t, v in out.items() if v}


def Arows(n):
    """A[r] as a dict a -> {m: c_{ram}} (integers)."""
    pls = planes(n)
    pix = {p: k for k, p in enumerate(pls)}
    N = len(pls)
    A = [dict() for _ in range(N)]
    for a, pa in enumerate(pls):
        for m, pm in enumerate(pls):
            for t, v in bracket(pa, pm).items():
                r = pix[t]                # c_{amr} = c_{ram}
                A[r].setdefault(a, {})[m] = v
    return A, pls, pix


def constraint_rows(n):
    """Bianchi + Ricci rows as dicts over the coordinate index of the upper
    triangle (a<=b) of a symmetric N x N matrix, with the convention that a
    row represents a linear functional whose value on X is
    sum_{a<=b} coeff * X[a,b]."""
    pls = planes(n)
    pix = {p: k for k, p in enumerate(pls)}
    N = len(pls)
    coord = {}
    k = 0
    for a in range(N):
        for b in range(a, N):
            coord[(a, b)] = k
            k += 1
    rows = []
    for (i, j, kk, l) in itertools.combinations(range(n), 4):
        r = {}
        for (p1, p2, s) in [((i, j), (kk, l), 1), ((i, kk), (j, l), -1),
                            ((i, l), (j, kk), 1)]:
            a, b = pix[p1], pix[p2]
            key = coord[(min(a, b), max(a, b))]
            r[key] = r.get(key, 0) + s
        rows.append({c: v for c, v in r.items() if v})
    for j in range(n):
        for l in range(j, n):
            r = {}
            for i in range(n):
                if i == j or i == l:
                    continue
                a = pix[tuple(sorted((i, j)))]
                b = pix[tuple(sorted((i, l)))]
                si = 1 if i < j else -1
                sl = 1 if i < l else -1
                key = coord[(min(a, b), max(a, b))]
                r[key] = r.get(key, 0) + si * sl
            rows.append({c: v for c, v in r.items() if v})
    return rows, coord, k


def apply_L(A, epsv, Xu, N, zero, half):
    """e o X, with X given as dict (a,b)->value, a<=b, e diagonal = epsv.
       e o X = 1/2(eX+Xe) - 1/2 sum_r eps(r) A_r X A_r ."""
    X = {}
    for (a, b), v in Xu.items():
        X.setdefault(a, {})[b] = v
        if a != b:
            X.setdefault(b, {})[a] = v
    out = {}
    for (a, b), v in Xu.items():
        out[(a, b)] = half * (epsv[a] + epsv[b]) * v
    for r in range(N):
        er = epsv[r]
        if er == zero:
            continue
        Ar = A[r]
        Y = {}
        for a, row in Ar.items():
            acc = {}
            for m, cv in row.items():
                Xm = X.get(m)
                if not Xm:
                    continue
                for t, xv in Xm.items():
                    acc[t] = acc.get(t, zero) + cv * xv
            if acc:
                Y[a] = acc
        for a, Ya in Y.items():
            for t, yv in Ya.items():
                rowt = Ar.get(t)
                if not rowt:
                    continue
                for b, cv in rowt.items():
                    if a > b:
                        continue          # symmetric; upper triangle only
                    out[(a, b)] = out.get((a, b), zero) - half * er * yv * cv
    return out


def predicted(p, q):
    n = p + q
    def s(m): return (m + 2) * (m - 1) // 2
    def c(m): return m * (m - 1) // 2
    mu = F(n - 2, 2 * (p - 1) * (q - 1))
    acc = Counter()
    acc[-mu] += s(p) * s(q)
    acc[mu] += c(p) * c(q)
    acc[F(p - 2, 2 * (p - 1))] += s(p)
    acc[F(q - 2, 2 * (q - 1))] += s(q)
    acc[F(1, 2)] += p * q
    acc[F(1)] += 1
    dimW = n * (n + 1) * (n + 2) * (n - 3) // 12
    acc[F(0)] += dimW - sum(acc.values())
    return {k: v for k, v in acc.items() if v != 0}, dimW


# --------------------------------------------------------------- exact over Q

def rref_Q(rows, D):
    rows = [dict(r) for r in rows]
    piv, red = [], []
    for r in rows:
        r = {c: F(v) for c, v in r.items()}
        for pc, pr in zip(piv, red):
            if pc in r:
                f = r[pc]
                for c, v in pr.items():
                    nv = r.get(c, F(0)) - f * v
                    if nv:
                        r[c] = nv
                    else:
                        r.pop(c, None)
        r = {c: v for c, v in r.items() if v}
        if not r:
            continue
        pc = min(r)
        f = r[pc]
        r = {c: v / f for c, v in r.items()}
        for pr in red:
            if pc in pr:
                g = pr[pc]
                for c, v in r.items():
                    nv = pr.get(c, F(0)) - g * v
                    if nv:
                        pr[c] = nv
                    else:
                        pr.pop(c, None)
        piv.append(pc)
        red.append(r)
    return piv, red


def weyl_basis_Q(n):
    rows, coord, D = constraint_rows(n)
    piv, red = rref_Q(rows, D)
    pivset = set(piv)
    free = [c for c in range(D) if c not in pivset]
    inv = {v: k for k, v in coord.items()}
    basis = []
    for fc in free:
        vec = {fc: F(1)}
        for pc, pr in zip(piv, red):
            if fc in pr:
                vec[pc] = -pr[fc]
        basis.append({inv[c]: v for c, v in vec.items() if v})
    return basis, free, coord, inv


def build_L_matrix_Q(n, p, q):
    A, pls, pix = Arows(n)
    N = len(pls)
    epsv = []
    for (i, j) in pls:
        if i < p and j < p:
            epsv.append(F(q, (p - 1) * (n - 1)))
        elif i >= p and j >= p:
            epsv.append(F(p, (q - 1) * (n - 1)))
        else:
            epsv.append(F(-1, n - 1))
    basis, free, coord, inv = weyl_basis_Q(n)
    dim = len(basis)
    M = [[F(0)] * dim for _ in range(dim)]
    for k, b in enumerate(basis):
        Y = apply_L(A, epsv, b, N, F(0), F(1, 2))
        for jcol, fc in enumerate(free):
            key = inv[fc]
            v = Y.get(key, F(0))
            if v:
                M[jcol][k] = v
    return M, dim


def nullity_Q(M, dim, lam):
    rows = []
    for i in range(dim):
        r = {j: M[i][j] for j in range(dim) if M[i][j]}
        r[i] = r.get(i, F(0)) - lam
        rows.append({c: v for c, v in r.items() if v})
    piv, red = rref_Q(rows, dim)
    return dim - len(piv)


# ------------------------------------------------------------- mod p, numpy

def rank_modp(Mat, pmod):
    Mat = Mat.copy() % pmod
    m, ncol = Mat.shape
    r = 0
    for c in range(ncol):
        piv = None
        col = Mat[r:, c]
        nz = np.nonzero(col)[0]
        if nz.size == 0:
            continue
        piv = r + nz[0]
        if piv != r:
            Mat[[r, piv]] = Mat[[piv, r]]
        inv = pow(int(Mat[r, c]), pmod - 2, pmod)
        Mat[r] = (Mat[r] * inv) % pmod
        colvals = Mat[:, c].copy()
        colvals[r] = 0
        idx = np.nonzero(colvals)[0]
        if idx.size:
            Mat[idx] = (Mat[idx] - np.outer(colvals[idx], Mat[r])) % pmod
        r += 1
        if r == m:
            break
    return r


def build_L_matrix_modp(n, p, q, pmod):
    A, pls, pix = Arows(n)
    N = len(pls)

    def inv(x):
        return pow(int(x) % pmod, pmod - 2, pmod)
    epsv = []
    for (i, j) in pls:
        if i < p and j < p:
            epsv.append(q * inv((p - 1) * (n - 1)) % pmod)
        elif i >= p and j >= p:
            epsv.append(p * inv((q - 1) * (n - 1)) % pmod)
        else:
            epsv.append((-1) * inv(n - 1) % pmod)
    rows, coord, D = constraint_rows(n)
    Cm = np.zeros((len(rows), D), dtype=object)
    for i, r in enumerate(rows):
        for c, v in r.items():
            Cm[i, c] = v % pmod
    Cm = Cm.astype(np.int64) % pmod
    # rref mod p to get free columns
    Mat = Cm.copy()
    m, ncol = Mat.shape
    r = 0
    pivots = []
    for c in range(ncol):
        col = Mat[r:, c]
        nz = np.nonzero(col)[0]
        if nz.size == 0:
            continue
        piv = r + nz[0]
        if piv != r:
            Mat[[r, piv]] = Mat[[piv, r]]
        iv = pow(int(Mat[r, c]), pmod - 2, pmod)
        Mat[r] = (Mat[r] * iv) % pmod
        cv = Mat[:, c].copy()
        cv[r] = 0
        idx = np.nonzero(cv)[0]
        if idx.size:
            Mat[idx] = (Mat[idx] - np.outer(cv[idx], Mat[r])) % pmod
        pivots.append(c)
        r += 1
        if r == m:
            break
    pivset = set(pivots)
    free = [c for c in range(D) if c not in pivset]
    invco = {v: k for k, v in coord.items()}
    basis = []
    for fc in free:
        vec = {fc: 1}
        for i, pc in enumerate(pivots):
            val = int(Mat[i, fc])
            if val:
                vec[pc] = (-val) % pmod
        basis.append({invco[c]: v for c, v in vec.items() if v})
    dim = len(basis)
    M = np.zeros((dim, dim), dtype=np.int64)
    zero = 0
    half = inv(2)
    for k, b in enumerate(basis):
        Y = apply_L(A, epsv, {kk: int(vv) % pmod for kk, vv in b.items()},
                    N, zero, half)
        for jcol, fc in enumerate(free):
            v = Y.get(invco[fc], 0) % pmod
            if v:
                M[jcol, k] = v
    return M, dim


# ------------------------------------------------------------------------ main

if __name__ == '__main__':
    mode = sys.argv[1]
    ns = [int(x) for x in sys.argv[2:]]
    for n in ns:
        for p in range(2, n // 2 + 1):
            q = n - p
            pred, dimW = predicted(p, q)
            if mode == 'exact':
                M, dim = build_L_matrix_Q(n, p, q)
                assert dim == dimW, (dim, dimW)
                tot = 0
                parts = []
                for lam, mult in sorted(pred.items(), key=lambda t: float(t[0])):
                    nu = nullity_Q(M, dim, lam)
                    tot += nu
                    parts.append(f"{lam}: exact {nu} vs claimed {mult}"
                                 f"{'' if nu == mult else '   *** DIFFERS ***'}")
                print(f"\n(p,q)=({p},{q}) n={n} dim={dim}  [EXACT over Q]")
                for s_ in parts:
                    print("   ", s_)
                print(f"    sum of exact nullities = {tot}  (dim = {dim})  "
                      f"{'COMPLETE - spectrum certified' if tot == dim else '*** INCOMPLETE: hidden eigenvalue ***'}")
                sys.stdout.flush()
            else:
                for pmod in PRIMES[:1]:
                    M, dim = build_L_matrix_modp(n, p, q, pmod)
                    assert dim == dimW, (dim, dimW)
                    print(f"\n(p,q)=({p},{q}) n={n} dim={dim}  [mod {pmod}]  "
                          f"(nullity_p >= nullity_Q, so these bound the true "
                          f"multiplicities from ABOVE)")
                    tot = 0
                    for lam, mult in sorted(pred.items(), key=lambda t: float(t[0])):
                        lm = (lam.numerator * pow(lam.denominator, pmod - 2, pmod)) % pmod
                        Mm = (M - lm * np.eye(dim, dtype=np.int64)) % pmod
                        nu = dim - rank_modp(Mm, pmod)
                        tot += nu
                        flag = '' if nu == mult else '   *** DIFFERS ***'
                        print(f"    {lam}: nullity_p {nu} vs claimed {mult}{flag}")
                    print(f"    sum = {tot} (dim = {dim})")
                    sys.stdout.flush()


def half_only(n):
    """Rigorous dim E(1/2) <= pq via mod-p rank, for every split of n.
    Lower bound pq is a theorem: differentiating the SO(n)-equivariance of Q
    at W gives 2 L_W([rho(A),W]) = [rho(A), Q(W)] = theta [rho(A),W], so the
    whole orbit tangent (dim pq, Nienhaus) sits in E(1/2)."""
    for p in range(2, n // 2 + 1):
        q = n - p
        for pmod in PRIMES[:1]:
            M, dim = build_L_matrix_modp(n, p, q, pmod)
            lm = (1 * pow(2, pmod - 2, pmod)) % pmod
            Mm = (M - lm * np.eye(dim, dtype=np.int64)) % pmod
            nu = dim - rank_modp(Mm, pmod)
            print(f"  n={n} (p,q)=({p},{q}) dim={dim} mod {pmod}: "
                  f"nullity(L-1/2) = {nu}   pq = {p*q}   "
                  f"{'dim E(1/2) = pq  (nondegenerate, rigorous)' if nu == p*q else '*** EXCESS ' + str(nu - p*q) + ' ***'}")
            sys.stdout.flush()
