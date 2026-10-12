"""E2 (b): exact fusion masses from exact spectral projectors + FULL basis pairs,
and the Z2-grading question solved as a LINEAR SYSTEM over GF(2) (no random sampling,
no exponential search over sign assignments)."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np, sys, math, itertools
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
from review_r26_e2_core import sphere_e


def eigblocks(M, gap=1e-6):
    ev, U = np.linalg.eigh((M+M.T)/2)
    blocks = []
    start = 0
    for i in range(1, len(ev)+1):
        if i == len(ev) or ev[i]-ev[i-1] > gap:
            blocks.append((ev[start:i].mean(), start, i))
            start = i
    return ev, U, blocks


def struct_tensor(C, B):
    """S[i,j,k] = <B_i o B_j, B_k>, exactly, for a modest-size Weyl basis."""
    N = C.shape[0]; K = B.shape[0]
    Bv = B.reshape(K, N*N)
    S = np.zeros((K, K, K))
    Cf = C.reshape(N, N*N)
    for k in range(K):
        Z = B[k]
        tmp = np.einsum('acd,ab->bcd', C, Z, optimize=True).reshape(N, N*N)
        G = (tmp.T @ Cf).reshape(N, N, N, N)          # G[c,d,e,f]
        G = 0.5*np.transpose(G, (0, 2, 1, 3)).reshape(N*N, N*N)
        S[:, :, k] = Bv @ G @ Bv.T
        # Jordan part
        Zi = np.einsum('iab,bc->iac', B, Z, optimize=True).reshape(K, N*N)
        A = Zi @ Bv.T
        S[:, :, k] += 0.5*(A + A.T)
    return S


def fusion_from_S(S, U, blocks):
    """rotate S into the L_e eigenbasis and sum squares over blocks"""
    K = S.shape[0]
    Sr = np.einsum('ijk,ia,jb,kc->abc', S, U, U, U, optimize=True)
    nb = len(blocks)
    F = np.zeros((nb, nb, nb))
    for x, (lx, sx, ex) in enumerate(blocks):
        for y, (ly, sy, ey) in enumerate(blocks):
            for z, (lz, sz, ez) in enumerate(blocks):
                F[x, y, z] = (Sr[sx:ex, sy:ey, sz:ez]**2).sum()
    return F, Sr


def gf2_grading(F, blocks, thresh):
    """sigma: blocks -> {0,1}=GF(2) with sigma_z = sigma_x + sigma_y whenever F[x,y,z] != 0.
    Returns the dimension of the solution space and a basis."""
    nb = len(blocks)
    rows = []
    for x in range(nb):
        for y in range(nb):
            for z in range(nb):
                if F[x, y, z] > thresh:
                    r = np.zeros(nb, dtype=np.uint8)
                    r[x] ^= 1; r[y] ^= 1; r[z] ^= 1
                    if r.any():
                        rows.append(r)
    if not rows:
        return nb, []
    A = np.array(rows, dtype=np.uint8)
    # gaussian elimination over GF(2)
    m, n = A.shape
    piv = []
    r = 0
    for c in range(n):
        p = None
        for i in range(r, m):
            if A[i, c]:
                p = i; break
        if p is None: continue
        A[[r, p]] = A[[p, r]]
        for i in range(m):
            if i != r and A[i, c]:
                A[i] ^= A[r]
        piv.append(c); r += 1
        if r == m: break
    free = [c for c in range(n) if c not in piv]
    sols = []
    for f in free:
        v = np.zeros(n, dtype=np.uint8); v[f] = 1
        for i, c in enumerate(piv):
            v[c] = A[i, f]
        sols.append(v)
    return len(free), sols


def run(n, thresh_rel=1e-10):
    e, th, C, B, W = sphere_e(n)
    from review_r26_e2_core import Lmap_on_weyl
    M = Lmap_on_weyl(e, C, B)
    ev, U, blocks = eigblocks(M)
    print(f"\n{'='*90}\nn={n}: dim Weyl={B.shape[0]}, theta={th:.10f}")
    print("  L_e blocks:", [(round(l, 10), ei-si) for (l, si, ei) in blocks])
    S = struct_tensor(C, B)
    # Frobenius check: is <x o y, z> totally symmetric?
    print(f"  Frobenius symmetry of S: max|S - S^T(perm)| = "
          f"{max(np.abs(S-np.transpose(S,p)).max() for p in [(0,2,1),(1,0,2),(2,1,0)]):.2e}")
    F, Sr = fusion_from_S(S, U, blocks)
    scale = F.max()
    print(f"  fusion mass table (normalized by max={scale:.4e}); rows=lambda, cols=mu, entries = "
          f"list of nu with mass fraction")
    labs = [f"{l:+.6f}" for (l, s, e_) in blocks]
    thr = thresh_rel*scale
    print(f"  threshold = {thr:.3e}  (relative {thresh_rel:g})")
    # print the full table of mass fractions
    for x in range(len(blocks)):
        for y in range(x, len(blocks)):
            tot = F[x, y].sum()
            parts = [f"{labs[z]}:{F[x,y,z]/max(tot,1e-300):.3e}" for z in range(len(blocks))]
            print(f"    E({labs[x]}) o E({labs[y]}) -> " + "  ".join(parts) + f"   [total {tot:.4e}]")
    # gap analysis: how separated are the 'zero' entries from the nonzero ones?
    vals = np.sort(F.flatten())
    nz = vals[vals > 0]
    print(f"  smallest nonzero entries: {nz[:6]}")
    print(f"  largest 'numerically zero' candidates below 1e-6*max: "
          f"{[f'{v:.2e}' for v in vals[vals<1e-6*scale][-5:]]}")
    for tr in [1e-14, 1e-12, 1e-10, 1e-8, 1e-6]:
        d, sols = gf2_grading(F, blocks, tr*scale)
        print(f"  GF(2) grading solution space dimension at threshold {tr:g}*max : {d}"
              + ("   -> ONLY the trivial grading" if d == 0 else
                 "   -> NONTRIVIAL gradings exist: " + str([[int(t) for t in s] for s in sols])))
    return F, blocks, labs


if __name__ == '__main__':
    ns = [int(x) for x in sys.argv[1:]] or [6]
    for n in ns:
        run(n)
