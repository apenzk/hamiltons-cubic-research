"""Reviewer 180: weight-character toolkit for so(2r) / so(2r+1).

Everything is exact integer arithmetic on dicts  tuple(weight) -> multiplicity.
No representation of Sym^3 is ever materialised as a vector space.
"""
from itertools import combinations
from collections import defaultdict
import numpy as np


# ---------------------------------------------------------------- characters
def char_vector(r, odd):
    """Character of the defining rep C^{2r} (odd=False) or C^{2r+1} (odd=True)."""
    c = defaultdict(int)
    for i in range(r):
        for s in (1, -1):
            w = [0]*r
            w[i] = s
            c[tuple(w)] += 1
    if odd:
        c[tuple([0]*r)] += 1
    return dict(c)


def adams(c, j):
    """psi^j : chi(t) -> chi(t^j)."""
    out = defaultdict(int)
    for w, m in c.items():
        out[tuple(j*x for x in w)] += m
    return dict(out)


def mul(a, b):
    out = defaultdict(int)
    for wa, ma in a.items():
        for wb, mb in b.items():
            out[tuple(x+y for x, y in zip(wa, wb))] += ma*mb
    return {w: m for w, m in out.items() if m}


def add(a, b, s=1):
    out = defaultdict(int, a)
    for w, m in b.items():
        out[w] += s*m
    return {w: m for w, m in out.items() if m}


def scal(a, s):
    return {w: m*s for w, m in a.items()}


def divide(a, d):
    out = {}
    for w, m in a.items():
        assert m % d == 0, (w, m, d)
        if m//d:
            out[w] = m//d
    return out


def dim(c):
    return sum(c.values())


def sym_power(c, k, mulf=None):
    """Sym^k via Newton:  k h_k = sum_{j=1..k} p_j h_{k-j}."""
    mulf = mulf or mul
    p = {j: adams(c, j) for j in range(1, k+1)}
    h = {0: {tuple([0]*len(next(iter(c)))): 1}}
    for m in range(1, k+1):
        acc = {}
        for j in range(1, m+1):
            acc = add(acc, mulf(p[j], h[m-j]))
        h[m] = divide(acc, m)
    return h[k]


def ext_power_char(c, k):
    """Lambda^k via Newton with signs: k e_k = sum_{j=1..k} (-1)^{j-1} p_j e_{k-j}."""
    p = {j: adams(c, j) for j in range(1, k+1)}
    e = {0: {tuple([0]*len(next(iter(c)))): 1}}
    for m in range(1, k+1):
        acc = {}
        for j in range(1, m+1):
            acc = add(acc, mul(p[j], e[m-j]), 1 if (j-1) % 2 == 0 else -1)
        e[m] = divide(acc, m)
    return e[k]


def char_weyl(r, odd):
    """Character of the Weyl-tensor module W_n, n = 2r (+1).

    Sym^2(Lambda^2 V) = Lambda^4 V  +  R  and  R = W + Sym^2_0 V + C.
    """
    V = char_vector(r, odd)
    L2 = ext_power_char(V, 2)
    S2L2 = sym_power(L2, 2)
    L4 = ext_power_char(V, 4)
    S2V = sym_power(V, 2)
    zero = tuple([0]*r)
    ch = add(S2L2, L4, -1)
    # Sym^2_0 V + C = Sym^2 V, so subtracting Sym^2 V removes both Ricci pieces at once
    ch = add(ch, S2V, -1)
    return {w: m for w, m in ch.items() if m}


# ------------------------------------------------------- fast numpy products
BASE = 1 << 8
OFF = 1 << 7


def encode(ws, r):
    a = np.zeros(len(ws), dtype=np.int64)
    for i in range(r):
        a += (np.array([w[i] for w in ws], dtype=np.int64) + OFF) * (BASE**i)
    return a


def decode(a, r):
    out = []
    for v in a:
        w = []
        x = int(v)
        for i in range(r):
            w.append((x % BASE) - OFF)
            x //= BASE
        out.append(tuple(w))
    return out


def np_mul(a, b, r, chunk=400):
    """Product of two characters, via encoded int64 keys."""
    wa = list(a); wb = list(b)
    ka = encode(wa, r); va = np.array([a[w] for w in wa], dtype=object)
    kb = encode(wb, r); vb = np.array([b[w] for w in wb], dtype=object)
    va = np.array([a[w] for w in wa], dtype=np.int64)
    vb = np.array([b[w] for w in wb], dtype=np.int64)
    zero_off = sum(OFF * BASE**i for i in range(r))
    acc = defaultdict(int)
    for s in range(0, len(ka), chunk):
        kk = (ka[s:s+chunk, None] + kb[None, :] - zero_off).ravel()
        vv = (va[s:s+chunk, None] * vb[None, :]).ravel()
        u, inv = np.unique(kk, return_inverse=True)
        sums = np.bincount(inv, weights=vv.astype(np.float64))
        # redo exactly with int64 accumulation
        sums = np.zeros(len(u), dtype=np.int64)
        np.add.at(sums, inv, vv)
        for key, val in zip(u.tolist(), sums.tolist()):
            acc[key] += val
    out = {}
    keys = np.array(list(acc.keys()), dtype=np.int64)
    for w, key in zip(decode(keys, r), keys.tolist()):
        if acc[key]:
            out[w] = acc[key]
    return out


# ------------------------------------------------------------- root systems
def positive_roots(r, typ):
    R = []
    for i, j in combinations(range(r), 2):
        a = [0]*r; a[i] = 1; a[j] = -1; R.append(tuple(a))
        b = [0]*r; b[i] = 1; b[j] = 1; R.append(tuple(b))
    if typ == 'B':
        for i in range(r):
            a = [0]*r; a[i] = 1; R.append(tuple(a))
    return R


def rho(r, typ):
    if typ == 'D':
        return tuple(r-1-i for i in range(r))          # (r-1, ..., 1, 0)
    return tuple((2*(r-i)-1)/2 for i in range(r))      # B_r : half-integers


def dominant_D(w):
    """W(D_r)-dominant representative: sort |w| descending, sign of last entry
    is + iff the number of negative entries was even."""
    neg = sum(1 for x in w if x < 0)
    a = sorted((abs(x) for x in w), reverse=True)
    if neg % 2 == 1:
        a[-1] = -a[-1]
    return tuple(a)


def dominant_B(w):
    return tuple(sorted((abs(x) for x in w), reverse=True))


def weyl_group_D(r):
    """All (perm, signs) of W(D_r) as (matrix action, det)."""
    from itertools import permutations, product
    els = []
    for perm in permutations(range(r)):
        # det of permutation
        p = list(perm); sgn = 1
        seen = [False]*r
        for i in range(r):
            if not seen[i]:
                j = i; ln = 0
                while not seen[j]:
                    seen[j] = True; j = p[j]; ln += 1
                if ln % 2 == 0:
                    sgn = -sgn
        for signs in product((1, -1), repeat=r):
            if signs.count(-1) % 2:
                continue
            els.append((perm, signs, sgn))     # det = sgn * prod(signs) = sgn since even # of -1
    return els


def apply_w(w, perm, signs):
    return tuple(signs[i]*w[perm[i]] for i in range(len(w)))


# ------------------------------------------------- Weyl group as (image, det)
from itertools import permutations, product as _prod


def _perm_sign(perm):
    r = len(perm); seen = [False]*r; sgn = 1
    for i in range(r):
        if not seen[i]:
            j = i; ln = 0
            while not seen[j]:
                seen[j] = True; j = perm[j]; ln += 1
            if ln % 2 == 0:
                sgn = -sgn
    return sgn


def weyl_elements(r, typ):
    """Yield (perm, signs, det) for W(B_r) or W(D_r)."""
    out = []
    for perm in permutations(range(r)):
        ps = _perm_sign(perm)
        for signs in _prod((1, -1), repeat=r):
            nneg = signs.count(-1)
            if typ == 'D' and nneg % 2:
                continue
            det = ps * ((-1)**nneg)
            out.append((perm, signs, det))
    return out


def act(v, perm, signs):
    return tuple(signs[i]*v[perm[i]] for i in range(len(v)))


def trivial_multiplicity(ch, r, typ, W=None, rh=None):
    """dim of the G-invariants of a character ch, by the Racah alternating sum
       mult_0 = sum_{w in W} det(w) * ch(rho - w rho)."""
    W = W or weyl_elements(r, typ)
    rh = rh or rho(r, typ)
    tot = 0
    for perm, signs, det in W:
        d = tuple(a-b for a, b in zip(rh, act(rh, perm, signs)))
        if all(float(x).is_integer() for x in d):
            key = tuple(int(x) for x in d)
            tot += det*ch.get(key, 0)
    return tot


def branch_trivial_multiplicity(ch, WH, rhoH):
    """dim of the H-invariants, H an EQUAL-RANK connected subgroup with Weyl
       group WH (list of (perm,signs,det)) and Weyl vector rhoH."""
    tot = 0
    for perm, signs, det in WH:
        d = tuple(a-b for a, b in zip(rhoH, act(rhoH, perm, signs)))
        if all(float(x).is_integer() for x in d):
            key = tuple(int(x) for x in d)
            tot += det*ch.get(key, 0)
    return tot


# ------------------------------------------------------------- Freudenthal
from fractions import Fraction


def simple_root_coeffs(v, r, typ):
    """Coefficients of v in the simple-root basis, or None if not integral."""
    v = list(v)
    if typ == 'B':
        c = [sum(v[:i+1]) for i in range(r)]
        return c
    c = [0]*r
    for i in range(r-2):
        c[i] = sum(v[:i+1])
    cm2 = sum(v[:r-1]) - v[r-2] if r >= 2 else 0
    cm2 = c[r-3] if r >= 3 else 0
    s = cm2 + v[r-2]
    if (s + v[r-1]) % 2:
        return None
    c[r-1] = (s + v[r-1])//2
    c[r-2] = (s - v[r-1])//2
    return c


def dominant_weights_below(lam, r, typ):
    """All dominant mu with lam - mu in the positive root cone."""
    tot = sum(abs(x) for x in lam)
    out = []
    def rec(i, prev, acc):
        if i == r:
            mu = tuple(acc)
            cands = [mu]
            if typ == 'D' and mu[-1] != 0:
                cands.append(mu[:-1] + (-mu[-1],))
            for m in cands:
                v = tuple(a-b for a, b in zip(lam, m))
                c = simple_root_coeffs(v, r, typ)
                if c is not None and all(x >= 0 for x in c) and all(float(x).is_integer() for x in c):
                    out.append(m)
            return
        hi = prev
        for val in range(hi, -1, -1):
            if sum(acc)+val > tot:
                continue
            rec(i+1, val, acc+[val])
    rec(0, int(tot), [])
    return out


def freudenthal(lam, r, typ):
    """Dominant weight multiplicities of V_lam."""
    rh = rho(r, typ)
    pos = positive_roots(r, typ)
    dom = dominant_weights_below(lam, r, typ)
    dominate = dominant_D if typ == 'D' else dominant_B
    def ip(a, b):
        return sum(Fraction(x)*Fraction(y) for x, y in zip(a, b))
    lr = tuple(Fraction(a)+Fraction(b) for a, b in zip(lam, rh))
    nl = ip(lr, lr)
    key = lambda m: -sum(m)
    dom.sort(key=lambda m: sum(m), reverse=True)
    mult = {}
    for mu in dom:
        if mu == tuple(lam):
            mult[mu] = 1
            continue
        mr = tuple(Fraction(a)+Fraction(b) for a, b in zip(mu, rh))
        den = nl - ip(mr, mr)
        if den == 0:
            mult[mu] = 0
            continue
        s = Fraction(0)
        for al in pos:
            k = 1
            while True:
                nu = tuple(a+k*b for a, b in zip(mu, al))
                d = dominate(nu)
                m = mult.get(d)
                if m is None:
                    if sum(abs(x) for x in nu) > sum(abs(x) for x in lam):
                        break
                    k += 1
                    continue
                if m:
                    s += m*ip(nu, al)
                k += 1
                if k > 60:
                    break
        val = 2*s/den
        assert val.denominator == 1, (lam, mu, val)
        mult[mu] = int(val)
    return mult


def full_character(mult, r, typ):
    """Expand dominant multiplicities to the full weight-multiplicity dict."""
    W = weyl_elements(r, typ)
    ch = {}
    for mu, m in mult.items():
        if not m:
            continue
        for perm, signs, det in W:
            ch[act(mu, perm, signs)] = m
    return ch


def dim_from_mult(mult, r, typ):
    W = weyl_elements(r, typ)
    tot = 0
    for mu, m in mult.items():
        if not m:
            continue
        orb = {act(mu, p, s) for p, s, d in W}
        tot += m*len(orb)
    return tot
