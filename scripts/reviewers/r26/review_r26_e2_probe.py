"""E2 (b)(c): fusion support by exact projectors, FULL bases on two of the three slots,
and a generic probe on the third (rigorous up to genericity of one random vector).
Cross-checked against the exact full-basis computation at n=6,8."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, math
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
from review_r26_e2_core import sphere_e, Lmap_on_weyl
from review_r26_e2_fusion import eigblocks, gf2_grading


def Lu_matrix(u, C, B):
    return Lmap_on_weyl(u, C, B)


def probe_fusion(n, nprobe=3, seed=0):
    e, th, C, B, W = sphere_e(n)
    K = B.shape[0]
    M = Lmap_on_weyl(e, C, B)
    ev, U, blocks = eigblocks(M)
    rng = np.random.default_rng(seed)
    nb = len(blocks)
    # projectors in the Weyl-basis coordinates
    Pr = []
    for (l, s, t) in blocks:
        Us = U[:, s:t]
        Pr.append(Us @ Us.T)
    F = np.zeros((nb, nb, nb))
    for x, (lx, sx, tx) in enumerate(blocks):
        for rep in range(nprobe):
            c = rng.normal(size=tx-sx)
            uc = U[:, sx:tx] @ c
            uc /= np.linalg.norm(uc)
            umat = np.einsum('k,kab->ab', uc, B)
            Lu = Lu_matrix(umat, C, B)
            for y in range(nb):
                Ly = Lu @ Pr[y]
                for z in range(nb):
                    F[x, y, z] = max(F[x, y, z], ((Pr[z] @ Ly)**2).sum())
    return F, blocks, ev, U, B, C, e, th


def report(n, nprobe=3):
    F, blocks, ev, U, B, C, e, th = probe_fusion(n, nprobe)
    labs = [f"{l:+.8f}" for (l, s, t) in blocks]
    print(f"\n{'='*95}\nn={n}: dim Weyl={B.shape[0]}, theta={th:.10f}")
    print("  L_e blocks (eigenvalue, multiplicity):",
          [(round(l, 10), t-s) for (l, s, t) in blocks])
    scale = F.max()
    nz = np.sort(F.flatten())
    pos = nz[nz > 1e-18*scale]
    print(f"  max fusion mass {scale:.4e}; smallest mass above 1e-18*max: {pos[0]:.3e} "
          f"({pos[0]/scale:.2e} of max); largest below: {nz[nz<=1e-18*scale][-1]:.3e}")
    print("  fusion support (lambda o mu -> which nu are NONZERO, mass fraction):")
    for x in range(len(blocks)):
        for y in range(x, len(blocks)):
            tot = F[x, y].sum()
            if tot < 1e-18*scale:
                print(f"    E({labs[x]}) o E({labs[y]}) = 0"); continue
            hits = [f"{labs[z]}({F[x,y,z]/tot:.3f})" for z in range(len(blocks))
                    if F[x, y, z] > 1e-12*tot]
            print(f"    E({labs[x]}) o E({labs[y]}) -> " + ", ".join(hits))
    for tr in [1e-14, 1e-10, 1e-6]:
        d, sols = gf2_grading(F, blocks, tr*scale)
        print(f"  GF(2) Z2-grading solution-space dim at threshold {tr:g}*max: {d}"
              + ("  -> only trivial" if d == 0 else "  -> NONTRIVIAL: " + str([[int(t) for t in s] for s in sols])))
    return F, blocks


if __name__ == '__main__':
    for n in [int(x) for x in sys.argv[1:]] or [6]:
        report(n)
