"""Reviewer 38 phase P3b: audit the basis, ablate Bianchi/Ricci, hunt a larger space."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from fractions import Fraction
from itertools import combinations
from review_r38_core import *

LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(msg):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + msg + '\n')
    print(msg, flush=True)

def Xd(m): return m * (m * m - 4) // 3

# ---- A. independent tensor-level verification that each basis vector is Weyl --
def direct_weyl_check(n, M):
    """M is an N x N object/int matrix.  Check symmetry, Bianchi, Ricci directly."""
    pairs, idx = pair_data(n)
    def ent(i, j, k, l):
        s1 = signed(idx, i, j); s2 = signed(idx, k, l)
        if s1 is None or s2 is None: return 0
        return s1[1] * s2[1] * M[s1[0], s2[0]]
    if not all(M[a][b] == M[b][a] for a in range(len(pairs)) for b in range(len(pairs))):
        return 'not symmetric'
    for i, j, k, l in combinations(range(n), 4):
        for (a, b, c, d) in [(i, j, k, l), (i, k, l, j), (i, l, j, k)]:
            pass
        v = ent(i, j, k, l) + ent(i, k, l, j) + ent(i, l, j, k)
        if v != 0:
            return f'Bianchi fails at {(i,j,k,l)}: {v}'
    for i in range(n):
        for j in range(n):
            v = sum(ent(i, k, j, k) for k in range(n))
            if v != 0:
                return f'Ricci fails at {(i,j)}: {v}'
    return 'ok'

def support_check(n, p, M):
    pairs, idx = pair_data(n)
    cl = plane_class(pairs, p)
    for a in range(len(pairs)):
        for b in range(len(pairs)):
            if {cl[a], cl[b]} != {'PP', 'MX'} and M[a][b] != 0:
                return f'support violated at {(pairs[a], pairs[b])}'
    return 'ok'

# ---- B. independent dimension: intersect full Weyl_n nullspace with support ---
def dim_S_via_full_weyl(n, p):
    pairs, idx = pair_data(n)
    N = len(pairs)
    cols, ncols = sym_vars(N)
    rows = bianchi_rows(n, cols, ncols) + ricci_rows(n, cols, ncols)
    # add the support constraints as extra equations: every non-support var = 0
    sup = set(support_columns(n, p, cols))
    extra = []
    for c in range(ncols):
        if c not in sup:
            r = [Fraction(0)] * ncols
            r[c] = Fraction(1)
            extra.append(r)
    R, piv = rref(rows + extra, ncols)
    return ncols - len(piv)

# ---- C. raw support block: invariance + full -1/2 eigenspace ------------------
def block_operator(n, p):
    """Matrix of 4*sharp_bilin(I_p, .) on the raw support block; plus leakage count."""
    A = structure_constants(n)
    N = A.shape[0]
    Ip = I_p_matrix(n, p)
    pairs, idx = pair_data(n)
    cl = plane_class(pairs, p)
    cols, ncols = sym_vars(N)
    sup = sorted(support_columns(n, p, cols))
    pos = {c: k for k, c in enumerate(sup)}
    inv_cols = {v: k for k, v in cols.items()}
    D = len(sup)
    Op = np.zeros((D, D), dtype=np.int64)
    leak = 0
    for c in sup:
        a, b = inv_cols[c]
        E = np.zeros((N, N), dtype=np.int64)
        E[a, b] = 1; E[b, a] = 1
        S4 = sharp_bilin_int(A, Ip, E)
        for aa in range(N):
            for bb in range(aa, N):
                key = cols[(aa, bb)]
                if S4[aa, bb] != 0:
                    if key in pos:
                        Op[pos[key], pos[c]] = S4[aa, bb]
                    else:
                        leak += 1
    return Op, sup, pos, leak, N, cols, inv_cols

def eig_minus_half_in_block(n, p):
    Op, sup, pos, leak, N, cols, inv_cols = block_operator(n, p)
    D = len(sup)
    M = Op + 2 * np.eye(D, dtype=np.int64)   # 4*sharp + 2*Id  == 4*(sharp + 1/2)
    rows = [[Fraction(int(M[i][j])) for j in range(D)] for i in range(D)]
    R, piv = rref(rows, D)
    return D, D - len(piv), leak

# ---- D. eigenspace of the identity inside all of Weyl_n ----------------------
def eig_minus_half_in_weyl(n, p):
    """dim { V in Weyl_n : 4*sharp_bilin(I_p,V) + 2V = 0 }."""
    A = structure_constants(n)
    N = A.shape[0]
    Ip = I_p_matrix(n, p)
    cols, ncols = sym_vars(N)
    inv_cols = {v: k for k, v in cols.items()}
    # image of each symmetric basis matrix under 4*sharp+2*Id, as columns
    colvecs = []
    for c in range(ncols):
        a, b = inv_cols[c]
        E = np.zeros((N, N), dtype=np.int64)
        E[a, b] = 1; E[b, a] = 1
        S4 = sharp_bilin_int(A, Ip, E) + 2 * E
        colvecs.append(S4)
    # rows of the linear system: one per (aa<=bb) output entry
    rows = []
    for aa in range(N):
        for bb in range(aa, N):
            r = [Fraction(int(colvecs[c][aa, bb])) for c in range(ncols)]
            if any(r):
                rows.append(r)
    rows += bianchi_rows(n, cols, ncols) + ricci_rows(n, cols, ncols)
    R, piv = rref(rows, ncols)
    return ncols - len(piv)

splits = [(3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4), (5, 2), (5, 3), (3, 5), (5, 4), (6, 2), (6,3)]

log('P3b A/B: basis audit (direct tensor Bianchi+Ricci, support) and independent dim')
for (p, q) in splits[:9]:
    n = p + q
    mats, d = S_space(n, p)
    prob = None
    for V in mats:
        Vi, den = to_int_matrix(V)
        r1 = direct_weyl_check(n, Vi)
        r2 = support_check(n, p, Vi)
        if r1 != 'ok' or r2 != 'ok':
            prob = (r1, r2); break
    # independent rank/independence check of the basis itself
    N = len(pair_data(n)[0])
    cols, ncols = sym_vars(N)
    vecs = []
    for V in mats:
        vecs.append([Fraction(V[a][b]) for (a, b) in sorted(cols, key=lambda k: cols[k])])
    _, pv = rref(vecs, ncols) if vecs else ([], [])
    d2 = dim_S_via_full_weyl(n, p)
    log(f'  ({p},{q}): dim={d} rank(basis)={len(pv)} indep={len(pv)==d} '
        f'weyl+support direct check={"ok" if prob is None else prob}  '
        f'independent dim via full-Weyl route={d2} agree={d2==d}')

log('P3b C: raw support block -- invariance and exact -1/2 eigenspace')
for (p, q) in splits:
    n = p + q
    t0 = time.time()
    D, dim_half, leak = eig_minus_half_in_block(n, p)
    log(f'  ({p},{q}): block dim={D} (=C(p,2)*p*q={p*(p-1)//2*p*q}) leakage entries={leak} '
        f'dim ker(sharp+1/2) in block={dim_half} X(p)*q={Xd(p)*q} '
        f'equal={dim_half==Xd(p)*q}  [{time.time()-t0:.1f}s]')

log('P3b D: eigenspace of the identity inside ALL of Weyl_n')
for (p, q) in splits[:8]:
    n = p + q
    t0 = time.time()
    d = eig_minus_half_in_weyl(n, p)
    log(f'  ({p},{q}): dim{{V in Weyl_n : sharp(I_p,V)=-V/2}}={d}  X(p)*q={Xd(p)*q} '
        f'equal={d==Xd(p)*q}  [{time.time()-t0:.1f}s]')
