"""Reviewer 40 -- C6: the U(m)-isotypic decomposition of Weyl_{2m}, and which summand
carries each L_e eigenvalue.

Method, entirely from scratch:
  * build the u(m)-action on Weyl_{2m} in an orthonormal Weyl basis;
  * check [L_e, u(m)] = 0;
  * split each L_e eigenspace into joint weight spaces of the maximal torus of U(m);
  * peel the weight multiset into GL(m,C) irreducible characters (Kostka numbers via
    Gelfand-Tsetlin patterns), giving the isotypic content of every eigenspace;
  * decide multiplicity-freeness, and check real/complex type.
"""
import sys, time, json
from functools import lru_cache
from itertools import combinations
import numpy as np

from review_r40_core import (pairs_of, so_basis, struct_const, Qop, ip, weyl_basis,
                             coords, project, rho_alg, L_matrix)
from review_r40_cpm import Jmat, u_m_basis

LOG = '../agent_logs/review_r40_cpm.log'


def log(msg):
    print(msg, flush=True)
    with open(LOG, 'a') as f:
        f.write(msg + '\n')


# ----------------------------------------------------------- Kostka numbers


def _interlace(top, k):
    """all partitions mu with <= k parts interlacing under 'top' (<= k+1 parts)."""
    top = list(top) + [0] * (k + 1 - len(top))
    out = []

    def rec(i, cur):
        if i == k:
            out.append(tuple(cur))
            return
        lo, hi = top[i + 1], top[i]
        if cur:
            hi = min(hi, cur[-1])
        for v in range(hi, lo - 1, -1):
            rec(i + 1, cur + [v])
    rec(0, [])
    return out


@lru_cache(maxsize=None)
def _gt_count(top, k, content):
    """# GT patterns with row k equal to 'top' and rows 1..k having the given content
    (content[j] = |lambda^{(j+1)}| - |lambda^{(j)}|, j = 0..k-1)."""
    if k == 1:
        return 1 if (len(top) == 0 or sum(top) == content[0]) and \
                    (len(top) <= 1) else 0
    tot = sum(top)
    need = tot - content[k - 1]
    if need < 0:
        return 0
    cnt = 0
    for mu in _interlace(top, k - 1):
        if sum(mu) == need:
            cnt += _gt_count(tuple(x for x in mu if x > 0), k - 1, content[:k - 1])
    return cnt


def kostka(nu, alpha):
    """K_{nu,alpha}: # SSYT of shape nu, content alpha (entries 1..len(alpha))."""
    m = len(alpha)
    nu = tuple(x for x in nu if x > 0)
    if len(nu) > m or sum(nu) != sum(alpha):
        return 0
    return _gt_count(nu, m, tuple(alpha))


def weights_of_irrep(lam, m):
    """weight multiplicities of the GL(m) irrep with h.w. lam (decreasing ints)."""
    c = -min(lam)
    nu = tuple(x + c for x in lam)
    s = sum(nu)
    out = {}
    # all compositions of s into m nonneg parts bounded by nu[0]
    def rec(i, rem, cur):
        if i == m - 1:
            if 0 <= rem <= nu[0]:
                out[tuple(cur + [rem])] = None
            return
        for v in range(0, min(rem, nu[0]) + 1):
            rec(i + 1, rem - v, cur + [v])
    rec(0, s, [])
    res = {}
    for w in out:
        k = kostka(nu, tuple(sorted(w, reverse=True)))
        if k:
            res[tuple(x - c for x in w)] = k
    return res


def peel(wmult, m):
    """decompose a weight-multiplicity dict into GL(m) irreps."""
    wm = {k: v for k, v in wmult.items() if v}
    pieces = []
    guard = 0
    while wm:
        guard += 1
        if guard > 400:
            raise RuntimeError('peel did not terminate')
        hw = max(tuple(sorted(k, reverse=True)) for k in wm)
        wi = weights_of_irrep(hw, m)
        mult = wm.get(hw, 0)
        if mult <= 0:
            raise RuntimeError(f'bad peel at {hw}')
        for w, c in wi.items():
            wm[w] = wm.get(w, 0) - c * mult
            if wm[w] == 0:
                del wm[w]
            elif wm[w] < 0:
                raise RuntimeError(f'negative multiplicity at {w} peeling {hw}')
        pieces.append((hw, mult, sum(wi.values())))
    return pieces


# ------------------------------------------------------------------- main


def torus_gens(m, prs, idx):
    n = 2 * m
    B, _, _ = so_basis(n)
    return [B[idx[(2 * k, 2 * k + 1)]] for k in range(m)]


def adjoint_on_weyl(n, E, Bs, prs):
    r = rho_alg(n, E, prs)
    img = np.einsum('ij,cjk->cik', r, Bs) - np.einsum('cij,jk->cik', Bs, r)
    return np.einsum('dij,cij->dc', Bs, img)


def analyse(m):
    n = 2 * m
    t0 = time.time()
    log(f"=== C6: U({m}) isotypic decomposition of Weyl_{n} ===")
    A = struct_const(n)
    Bs, prs, idx = weyl_basis(n)
    D = Bs.shape[0]
    import os
    if os.path.exists(f'review_r40_Le_cpm{m}.npy'):
        Le = np.load(f'review_r40_Le_cpm{m}.npy')
        W = np.load(f'scripts/data/review_r40_W_cpm{m}.npy')
        if os.path.exists(f'review_r40_Bs_n{n}.npy'):
            Bs = np.load(f'review_r40_Bs_n{n}.npy')
    else:                                     # rebuild from scratch
        from review_r40_proof import run_m
        run_m(m)
        Le = np.load(f'review_r40_Le_cpm{m}.npy')
        W = np.load(f'scripts/data/review_r40_W_cpm{m}.npy')
    gens, _, _, J = u_m_basis(m)
    ads = [adjoint_on_weyl(n, E, Bs, prs) for E in gens]
    eq = max(np.max(np.abs(ad @ Le - Le @ ad)) for ad in ads)
    log(f"  [L_e, u({m})] max = {eq:.2e}  (D={D})")

    Zs = [adjoint_on_weyl(n, E, Bs, prs) for E in torus_gens(m, prs, idx)]
    cz = max(np.max(np.abs(Zs[a] @ Zs[b] - Zs[b] @ Zs[a])) for a in range(m) for b in range(m))
    log(f"  torus generators commute to {cz:.2e}")

    rng = np.random.default_rng(7)
    cc = rng.uniform(1.0, 2.0, m) * np.array([1.0, np.pi / 3, np.sqrt(5), np.exp(1),
                                              np.sqrt(11), np.log(7)][:m])
    C = sum(cc[k] * Zs[k] for k in range(m))

    w, V = np.linalg.eigh(Le)
    rw = np.round(w, 7)
    uu = np.unique(rw)
    total = {}
    per_eig = {}
    for lam in uu:
        sel = np.where(rw == lam)[0]
        U = V[:, sel]
        Cr = U.T @ C @ U
        # joint weights: eigen-decompose the antisymmetric Cr over C
        ev, ew = np.linalg.eig(Cr)
        ew = ew / np.linalg.norm(ew, axis=0, keepdims=True)
        Wt = np.zeros((m, ew.shape[1]), dtype=complex)
        for k in range(m):
            Zr = U.T @ Zs[k] @ U
            Wt[k] = np.sum(np.conj(ew) * (Zr @ ew), axis=0)
        Wr = (Wt / 1j).real
        bad = max(float(np.max(np.abs(Wt.real))), float(np.max(np.abs(Wr - np.round(Wr)))))
        if bad > 1e-5:
            log(f"    WARNING: weights not integral in eigenspace {lam} (dev {bad:.2e})")
        Wi = np.round(Wr).astype(int)
        wm = {}
        for t in range(Wi.shape[1]):
            key = tuple(int(x) for x in Wi[:, t])
            wm[key] = wm.get(key, 0) + 1
        # sanity: weights come in a set of size dim
        assert sum(wm.values()) == len(sel)
        pieces = peel(wm, m)
        per_eig[float(lam)] = pieces
        for hw, mult, dm in pieces:
            total[hw] = total.get(hw, 0) + mult
        desc = ', '.join(f"{hw}x{mult} (dim {dm})" for hw, mult, dm in pieces)
        log(f"  lambda = {lam:+.6f}  dim {len(sel):4d}  ->  {desc}")

    dup = {k: v for k, v in total.items() if v > 1}
    log(f"  distinct GL({m})-irreps in Weyl_{n}^C: {len(total)}; "
        f"multiplicity-free (complexified): {not dup}")
    if dup:
        log(f"  repeated: {dup}")
    # real type bookkeeping
    reals, pairs_c = [], []
    seen = set()
    for hw in total:
        dual = tuple(-x for x in reversed(hw))
        if hw == dual:
            reals.append(hw)
        elif hw not in seen:
            pairs_c.append((hw, dual))
            seen.add(hw); seen.add(dual)
            if dual not in total:
                log(f"  WARNING: {hw} present but its dual {dual} is not")
    log(f"  self-dual irreps: {len(reals)}; conjugate pairs: {len(pairs_c)}; "
        f"real-irreducible summands: {len(reals)+len(pairs_c)}")
    log(f"  [m={m} isotypic done in {time.time()-t0:.1f}s]")
    return per_eig, total


if __name__ == '__main__':
    for m in [int(x) for x in sys.argv[1:]] or [3, 4, 5]:
        analyse(m)
