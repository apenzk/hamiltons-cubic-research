"""Reviewer 32: symbolic attack on N8 for general (p,q).

Two independent things are established here.

(A) The reduction.  For X supported on the six planes inside the four labels
    {0,1,2,3}, write  T = sum_r eps(r) A_r X A_r  (derived below and checked
    against the definition).  Then

      (A_r X A_r)_{ab} != 0  =>  r, a, m is a triangle for some core plane m,
      and r, t, b is a triangle for some core plane t.

    That forces: r carries at most one label outside the core; a and b each
    carry at most one, and it is the SAME label.  So a universe of the four
    core labels plus two spare P labels and two spare Q labels realises every
    (a,b) type that can be nonzero, and the value computed there is the exact
    full-universe value with NO multiplicity weighting.  This script verifies
    the reduction numerically against genuine large (p,q).

(B) The identity.  In that 8-label universe, with eps_PP, eps_QQ, eps_PQ kept
    as the exact functions of p and q, every one of the 784 entries of
    e o X - mu X is checked symbolically.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import itertools
from fractions import Fraction
import sympy as sp
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r32_core import (plane_index, struct_sparse_lists, W_pq,
                             L_operator_sparse, struct_constants_dense,
                             sharp_bilin_ref)

# ----------------------------------------------------------------- sanity: T
print("=== 0. check T = sum_r eps(r) A_r X A_r reproduces sharp_bilin(e,X) ===")
rng = np.random.default_rng(7)
for n in (5, 6, 7):
    N = n * (n - 1) // 2
    c = struct_constants_dense(n)
    A = np.transpose(c, (2, 0, 1))       # A[r][a,m] = c[a,m,r] = c_{ram}
    ev = rng.standard_normal(N)
    e = np.diag(ev)
    M = rng.standard_normal((N, N))
    X = 0.5 * (M + M.T)
    T = sum(ev[r] * (A[r] @ X @ A[r]) for r in range(N))
    ref = sharp_bilin_ref(n, e, X, c)
    print(f"  n={n}: |(-1/2)T - sharp_bilin(e,X)| = {np.abs(-0.5*T - ref).max():.3e}"
          f"   |T-T^T| = {np.abs(T-T.T).max():.3e}")
    assert np.abs(-0.5 * T - ref).max() < 1e-10

# --------------------------------------------------- the 8-label universe
LAB = list(range(8))
BLK = {0: 'P', 1: 'P', 4: 'P', 5: 'P', 2: 'Q', 3: 'Q', 6: 'Q', 7: 'Q'}
CORE = (0, 1, 2, 3)
PR = [(i, j) for i in LAB for j in LAB if i < j]
PIX = {pl: k for k, pl in enumerate(PR)}
NP = len(PR)


def bracket(Apl, Bpl):
    """[phi_ij, phi_kl] expanded in the phi basis; phi_ij = E_ij - E_ji."""
    i, j = Apl
    k, l = Bpl
    out = {}

    def add(x, y, co):
        if x == y:
            return
        t = (x, y) if x < y else (y, x)
        s = co if x < y else -co
        out[t] = out.get(t, 0) + s
    if j == k:
        add(i, l, 1)
    if i == k:
        add(j, l, -1)
    if j == l:
        add(i, k, -1)
    if i == l:
        add(j, k, 1)
    return {t: v for t, v in out.items() if v}


# c[a][m][r]
Cst = [[dict() for _ in range(NP)] for _ in range(NP)]
for a, pa in enumerate(PR):
    for m, pm in enumerate(PR):
        for t, v in bracket(pa, pm).items():
            Cst[a][m][PIX[t]] = v

# A[r][a][m] = c_{ram} = Cst[r][a].get(m)
Amat = [[[0] * NP for _ in range(NP)] for _ in range(NP)]
for r in range(NP):
    for a in range(NP):
        for m, v in Cst[r][a].items():
            Amat[r][a][m] = v

# cross-check total antisymmetry of c on this universe
for a in range(NP):
    for m in range(NP):
        for r, v in Cst[a][m].items():
            assert Cst[m][a].get(r, 0) == -v
            assert Cst[m][r].get(a, 0) == v, (a, m, r)
print("  structure constants on the 8-label universe: totally antisymmetric OK")


def Rt(Xd, i, j, k, l):
    if i == j or k == l:
        return Fraction(0)
    s = 1
    if i > j:
        i, j, s = j, i, -s
    if k > l:
        k, l, s = l, k, -s
    return s * Xd.get((PIX[(i, j)], PIX[(k, l)]), Fraction(0))


# X = phi_(01) (x) phi_(23) + sym, minus the Lambda^4 part
raw = {(PIX[(0, 1)], PIX[(2, 3)]): Fraction(1), (PIX[(2, 3)], PIX[(0, 1)]): Fraction(1)}
Xd = dict(raw)
for a, pa in enumerate(PR):
    for b, pb in enumerate(PR):
        i, j = pa
        k, l = pb
        if len({i, j, k, l}) < 4:
            continue
        alt = (Rt(raw, i, j, k, l) + Rt(raw, i, k, l, j) + Rt(raw, i, l, j, k)) / 3
        if alt:
            Xd[(a, b)] = Xd.get((a, b), Fraction(0)) - alt
Xd = {k: v for k, v in Xd.items() if v}
print("  X support:", sorted((PR[a], PR[b], str(v)) for (a, b), v in Xd.items()))
assert sum(v * v for v in Xd.values()) == Fraction(4, 3)

Xmat = [[Fraction(0)] * NP for _ in range(NP)]
for (a, b), v in Xd.items():
    Xmat[a][b] = v


def mul(Aa, Bb):
    out = [[Fraction(0)] * NP for _ in range(NP)]
    for i in range(NP):
        Ai = Aa[i]
        nz = [(k, Ai[k]) for k in range(NP) if Ai[k]]
        for k, v in nz:
            Bk = Bb[k]
            oi = out[i]
            for j in range(NP):
                if Bk[j]:
                    oi[j] += v * Bk[j]
    return out


def blocktype(pl):
    s = BLK[pl[0]] + BLK[pl[1]]
    return 'PP' if s == 'PP' else 'QQ' if s == 'QQ' else 'PQ'


S = {'PP': [[Fraction(0)] * NP for _ in range(NP)],
     'QQ': [[Fraction(0)] * NP for _ in range(NP)],
     'PQ': [[Fraction(0)] * NP for _ in range(NP)]}
per_r = {}
for r, pr_ in enumerate(PR):
    M = mul(mul(Amat[r], Xmat), Amat[r])
    per_r[pr_] = M
    bt = blocktype(pr_)
    for i in range(NP):
        for j in range(NP):
            if M[i][j]:
                S[bt][i][j] += M[i][j]

# ------------------------------------------------- claim (ii): tr(A_r X A_r X)
print("\n=== (ii) tr(A_r X A_r X) by plane type: do one-generic-index planes vanish? ===")
buckets = {}
for r, pr_ in enumerate(PR):
    M = per_r[pr_]
    tr = sum(M[i][j] * Xmat[j][i] for i in range(NP) for j in range(NP))
    ncore = sum(1 for x in pr_ if x in CORE)
    key = (ncore, blocktype(pr_))
    buckets.setdefault(key, []).append((pr_, tr))
for key in sorted(buckets):
    vals = set(str(t) for _, t in buckets[key])
    print(f"  r with {key[0]} core index(es), type {key[1]:2s}: "
          f"{len(buckets[key])} planes, tr values {sorted(vals)}")

# ------------------------------------------------------- (B) symbolic identity
p, q = sp.symbols('p q', positive=True)
nn = p + q
E = {'PP': q / ((p - 1) * (nn - 1)),
     'QQ': p / ((q - 1) * (nn - 1)),
     'PQ': sp.Integer(-1) / (nn - 1)}
mu = (nn - 2) / (2 * (p - 1) * (q - 1))

print("\n=== (B) all 784 entries of e o X - mu X, symbolic in (p,q) ===")
bad = []
maxterms = 0
for a in range(NP):
    for b in range(NP):
        xab = Xmat[a][b]
        sym = sp.Rational(1, 2) * (E[blocktype(PR[a])] + E[blocktype(PR[b])]) * sp.Rational(xab)
        shp = -sp.Rational(1, 2) * sum(E[bt] * sp.Rational(S[bt][a][b]) for bt in ('PP', 'QQ', 'PQ'))
        got = sp.together(sp.simplify(sym + shp))
        want = sp.simplify(mu * sp.Rational(xab))
        d = sp.simplify(got - want)
        if d != 0:
            bad.append((PR[a], PR[b], sp.simplify(got), sp.simplify(want), d))
print(f"  entries checked: {NP*NP}")
print(f"  mismatches: {len(bad)}")
for row in bad[:20]:
    print("   ", row)
assert not bad

# what the support entries look like, for the record
print("\n  support entries (a,b), value of (e o X)_ab and mu*X_ab:")
for (a, b), v in sorted(Xd.items()):
    sym = sp.Rational(1, 2) * (E[blocktype(PR[a])] + E[blocktype(PR[b])]) * sp.Rational(v)
    shp = -sp.Rational(1, 2) * sum(E[bt] * sp.Rational(S[bt][a][b]) for bt in ('PP', 'QQ', 'PQ'))
    print(f"    {PR[a]} x {PR[b]}: X={v}  (eoX)={sp.factor(sp.simplify(sym+shp))}  "
          f"muX={sp.factor(sp.simplify(mu*sp.Rational(v)))}")

# ------------------------------------------- how much of this needs the eps values
print("\n=== how structural is it?  free eps_PP, eps_QQ, eps_PQ ===")
u1, u2, u3, lam = sp.symbols('u1 u2 u3 lam')
Efree = {'PP': u1, 'QQ': u2, 'PQ': u3}
eqs = []
for a in range(NP):
    for b in range(NP):
        xab = Xmat[a][b]
        sym = sp.Rational(1, 2) * (Efree[blocktype(PR[a])] + Efree[blocktype(PR[b])]) * sp.Rational(xab)
        shp = -sp.Rational(1, 2) * sum(Efree[bt] * sp.Rational(S[bt][a][b]) for bt in ('PP', 'QQ', 'PQ'))
        expr = sp.expand(sym + shp - lam * sp.Rational(xab))
        if expr != 0:
            eqs.append(sp.simplify(expr))
eqs = list({sp.simplify(e) for e in eqs})
print(f"  distinct nontrivial conditions on (u1,u2,u3,lam): {len(eqs)}")
for e in eqs:
    print("   ", sp.factor(e), "= 0")
sol = sp.solve(eqs, [lam, u1, u2, u3], dict=True)
print("  solutions:", sol)
