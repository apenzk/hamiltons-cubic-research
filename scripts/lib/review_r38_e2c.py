"""Reviewer 38 phase P3c: ablations (drop Bianchi / drop Ricci) and identification
of the larger space on which sharp_bilin(I_p,.) = -1/2 holds inside Weyl_n."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from fractions import Fraction
from review_r38_core import *

LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(msg):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + msg + '\n')
    print(msg, flush=True)

def Xd(m): return m * (m * m - 4) // 3
def s20(m): return m * (m + 1) // 2 - 1

# ---------------- A. ABLATIONS -------------------------------------------------
def ablate(p, q, use_b, use_r):
    n = p + q
    A = structure_constants(n)
    Ip = I_p_matrix(n, p)
    mats, d = S_space(n, p, use_bianchi=use_b, use_ricci=use_r)
    nbad = 0
    worst = None
    for V in mats:
        Vi, _ = to_int_matrix(V)
        D = sharp_bilin_int(A, Ip, Vi) + 2 * Vi
        if np.any(D != 0):
            nbad += 1
            if worst is None:
                worst = int(np.abs(D).max())
    return d, nbad, worst

log('P3c A: ablations -- does the identity survive dropping Bianchi or Ricci?')
log('  columns: dim of the constrained space, #basis vectors FAILING the identity')
for (p, q) in [(3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4), (5, 3), (5, 4), (6, 3)]:
    n = p + q
    raw = p * (p - 1) // 2 * p * q
    dB, bB, wB = ablate(p, q, True, False)     # Bianchi only
    dR, bR, wR = ablate(p, q, False, True)     # Ricci only
    dN, bN, wN = ablate(p, q, False, False)    # neither: raw block
    dF, bF, wF = ablate(p, q, True, True)      # both
    log(f'  ({p},{q}) raw block dim={raw} | both: dim={dF} fail={bF} | '
        f'Bianchi-only: dim={dB} fail={bB} | Ricci-only: dim={dR} fail={bR} | '
        f'none: dim={dN} fail={bN}')
    log(f'        predicted: X(p)q={Xd(p)*q}, (X(p)+p)q={(Xd(p)+p)*q}, '
        f'(C(p,3)+X(p))q={(p*(p-1)*(p-2)//6+Xd(p))*q}')

# ---------------- B. KN construction of S^2_0(R^p) (x) S^2_0(R^q) --------------
def kn_product(n, h, k):
    """Kulkarni-Nomizu (h ? k)_{ijkl} = h_ik k_jl + h_jl k_ik - h_il k_jk - h_jk k_il,
    returned as an N x N matrix on Lambda^2."""
    pairs, idx = pair_data(n)
    N = len(pairs)
    M = np.zeros((N, N), dtype=np.int64)
    for a, (i, j) in enumerate(pairs):
        for b, (kk, l) in enumerate(pairs):
            M[a, b] = (h[i, kk] * k[j, l] + h[j, l] * k[i, kk]
                       - h[i, l] * k[j, kk] - h[j, kk] * k[i, l])
    return M

def s20_basis(n, lo, hi):
    """Integer basis of traceless symmetric matrices supported on [lo,hi)."""
    m = hi - lo
    out = []
    for i in range(lo, hi):
        for j in range(i + 1, hi):
            E = np.zeros((n, n), dtype=np.int64); E[i, j] = 1; E[j, i] = 1
            out.append(E)
    for i in range(lo, hi - 1):
        E = np.zeros((n, n), dtype=np.int64); E[i, i] = 1; E[i + 1, i + 1] = -1
        out.append(E)
    return out

log('P3c B: is S^2_0(R^p) (x) S^2_0(R^q), built by Kulkarni-Nomizu, in the eigenspace?')
for (p, q) in [(3, 3), (3, 4), (4, 3), (4, 4), (5, 3), (5, 4), (4, 5), (6, 3)]:
    n = p + q
    A = structure_constants(n)
    Ip = I_p_matrix(n, p)
    Iq = I_p_matrix(n, n)  # placeholder, replaced below
    pairs, idx = pair_data(n)
    N = len(pairs)
    cl = plane_class(pairs, p)
    Iq = np.zeros((N, N), dtype=np.int64)
    Imx = np.zeros((N, N), dtype=np.int64)
    for a in range(N):
        if cl[a] == 'QQ': Iq[a, a] = 1
        if cl[a] == 'MX': Imx[a, a] = 1
    hs = s20_basis(n, 0, p); ks = s20_basis(n, p, n)
    nbad_p = nbad_q = nbad_mx = 0
    nweyl_bad = 0
    supp_mx = True
    cnt = 0
    vecs = []
    for h in hs:
        for k in ks:
            V = kn_product(n, h, k)
            cnt += 1
            # Weyl?
            if np.any(sharp_bilin_int(A, np.eye(N, dtype=np.int64), V) * 0 != 0):
                pass
            Dp = sharp_bilin_int(A, Ip, V) + 2 * V
            Dq = sharp_bilin_int(A, Iq, V) + 2 * V
            Dm = sharp_bilin_int(A, Imx, V)
            if np.any(Dp != 0): nbad_p += 1
            if np.any(Dq != 0): nbad_q += 1
            if np.any(Dm != 0): nbad_mx += 1
            for a in range(N):
                for b in range(N):
                    if V[a, b] != 0 and not (cl[a] == 'MX' and cl[b] == 'MX'):
                        supp_mx = False
            vecs.append([Fraction(int(V[a, b])) for a in range(N) for b in range(N)])
    _, piv = rref(vecs, N * N)
    log(f'  ({p},{q}): built {cnt} KN tensors, rank={len(piv)} (=s20(p)*s20(q)={s20(p)*s20(q)}) '
        f'support all (MX,MX)={supp_mx} | sharp(I_p,.)+V/2 fails: {nbad_p} | '
        f'sharp(I_q,.)+V/2 fails: {nbad_q} | sharp(I_mix,.) nonzero: {nbad_mx}')
