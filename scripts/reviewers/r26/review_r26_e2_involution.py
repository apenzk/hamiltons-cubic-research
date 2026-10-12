"""E2 (d): is the grading found on the Stab-refinement realized by an honest involutive
automorphism, namely R_g for g = (-I_m) (+) I_m -- the symmetric-pair involution of
(so(n), so(m)+so(m))?  Direct, threshold-free automorphism test."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, math
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
from review_r26_e2_core import sphere_e, Lmap_on_weyl
from review_r26_e2_fusion import eigblocks, gf2_grading
from review_r26_e2_stab import group_on_weyl, fusion_blocks


def run(n, nprobe=4):
    e, th, C, B, W = sphere_e(n)
    K = B.shape[0]; m = n//2; N = C.shape[0]
    Le = Lmap_on_weyl(e, C, B)
    ev, U, blocks = eigblocks(Le)
    g = np.eye(n); g[:m, :m] = -np.eye(m)          # (-I_m) (+) I_m
    Rg = group_on_weyl(g, C, B, n)
    print(f"\n{'='*95}\nn={n}: dim Weyl={K}; L_e blocks {[(round(l,10),t-s) for (l,s,t) in blocks]}")
    print(f"  R_g^2 - I           = {np.abs(Rg@Rg-np.eye(K)).max():.2e}")
    print(f"  R_g symmetric        = {np.abs(Rg-Rg.T).max():.2e}")
    print(f"  [R_g, L_e]           = {np.abs(Rg@Le-Le@Rg).max():.2e}")
    ecoef = np.einsum('kab,ab->k', B, e)
    print(f"  |R_g e - e|          = {np.abs(Rg@ecoef-ecoef).max():.2e}")
    # automorphism test, threshold free
    rng = np.random.default_rng(9)
    worst = 0.0
    for _ in range(6):
        x = rng.normal(size=K); y = rng.normal(size=K)
        X = np.einsum('k,kab->ab', x, B); Y = np.einsum('k,kab->ab', y, B)
        gx = np.einsum('k,kab->ab', Rg@x, B); gy = np.einsum('k,kab->ab', Rg@y, B)
        lhs = circ(X, Y, C); rhs = circ(gx, gy, C)
        lhsc = Rg @ np.einsum('kab,ab->k', B, lhs)
        rhsc = np.einsum('kab,ab->k', B, rhs)
        worst = max(worst, np.abs(lhsc-rhsc).max()/max(np.abs(rhsc).max(), 1e-30))
    print(f"  AUTOMORPHISM test  max rel |R_g(x o y) - R_g x o R_g y| = {worst:.2e}")
    evg = np.linalg.eigvalsh((Rg+Rg.T)/2)
    print(f"  R_g eigenvalues: +1 x {int((evg>0).sum())}, -1 x {int((evg<0).sum())}")
    # how R_g splits each L_e eigenspace
    print("  splitting of each L_e eigenspace by R_g:")
    fine = []
    for (l, s, t) in blocks:
        Us = U[:, s:t]
        Mr = Us.T @ Rg @ Us; Mr = (Mr+Mr.T)/2
        w2, V = np.linalg.eigh(Mr)
        npos = int((w2 > 0).sum()); nneg = int((w2 < 0).sum())
        print(f"    E({l:+.8f}) dim {t-s}:  R_g = +1 on {nneg and npos and nneg or 0}"
              f"   -> (+1: {npos}, -1: {nneg})   spectrum spread "
              f"{np.abs(np.abs(w2)-1).max():.1e}")
        if nneg:
            fine.append(((round(l, 8), -1), Us @ V[:, :nneg]))
        if npos:
            fine.append(((round(l, 8), +1), Us @ V[:, nneg:]))
    # the induced sign map: is sigma a function of the L_e eigenvalue alone?
    print(f"  refinement by (L_e, R_g): {len(fine)} blocks {[ (lab, Uu.shape[1]) for lab,Uu in fine]}")
    F = fusion_blocks(fine, C, B, nprobe=nprobe)
    sc = F.max()
    for tr in [1e-14, 1e-10, 1e-7]:
        d_, sols = gf2_grading(F, fine, tr*sc)
        print(f"  GF(2) grading dim on the (L_e,R_g) refinement at {tr:g}*max: {d_}")
        if d_ > 0 and tr == 1e-10:
            labs = [lab for lab, _ in fine]
            for s_ in sols:
                print("      sigma=-1 on", [labs[i] for i in range(len(fine)) if s_[i] == 1])
            # is R_g's own sign among the solutions?
            target = np.array([1 if lab[1] == -1 else 0 for lab, _ in fine], dtype=np.uint8)
            hit = any(np.array_equal(target, s_) for s_ in sols) or \
                  any(np.array_equal(target, (s_ ^ sols[0]) if len(sols) > 1 else s_) for s_ in sols)
            print(f"      R_g's own sign pattern is a solution: {hit}")
    # can sigma be a function of the L_e EIGENVALUE alone?  (that is the Miyamoto condition)
    Fe, bl2, *_ = None, None
    d0, sols0 = gf2_grading(fusion_blocks([(l, U[:, s:t]) for (l, s, t) in blocks], C, B, nprobe=nprobe),
                            blocks, 1e-12)
    print(f"  MIYAMOTO condition (sigma a function of the L_e eigenvalue alone): "
          f"solution-space dim = {d0}  -> {'NO nontrivial grading' if d0==0 else 'exists'}")


if __name__ == '__main__':
    for n in [int(x) for x in sys.argv[1:]] or [8]:
        run(n)
