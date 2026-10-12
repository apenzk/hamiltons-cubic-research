"""T3b: orthogonal block sums -- FULL-SUPPORT critical points with S=0 that are ungraded.
Q is additive over orthogonal blocks: if W_A lives in Lambda^2(V), W_B in Lambda^2(V^perp),
then W_A . W_B = 0 and W_A # W_B = 0, so Q(W_A+W_B) = Q(W_A)+Q(W_B)."""
import numpy as np, itertools
from review_r47_core import *
from review_r47_t3 import cp_m, support_rank, kblock

def embed(g_big, idxs, g_small, M):
    out = np.zeros((g_big.N,g_big.N))
    for a,(i,j) in enumerate(g_small.prs):
        for b,(k,l) in enumerate(g_small.prs):
            out[g_big.pidx[idxs[i],idxs[j]], g_big.pidx[idxs[k],idxs[l]]] = M[a,b]
    return out

def block_sum(n, pieces):
    """pieces = [(index list, Geom, W_i critical unit)] on pairwise disjoint index sets"""
    g = Geom(n)
    ths = []
    for idxs,gs,Wi in pieces:
        ths.append(crit_residual(gs,Wi)[0])
    th = 1.0/np.sqrt(sum(1.0/t**2 for t in ths))
    W = np.zeros((g.N,g.N))
    for (idxs,gs,Wi),t in zip(pieces,ths):
        W = W + (th/t)*embed(g, idxs, gs, Wi)
    return g, W, th, ths

def report(tag,g,M):
    th,res = crit_residual(g,M); st = struct_sums(g,M); sup=support_rank(g,M)
    graded = st['leak']<1e-14*max(1,st['total']) and st['S']<1e-14*max(1,st['total'])
    nc = 0 if st['dim_m']<3 else st['dim_m']*(st['dim_m']-1)*(st['dim_m']-2)//6
    print(f" {tag:44s} n={g.n:2d} th={th:.9f} res={res:.1e} dim_m={st['dim_m']:3d} "
          f"#S-eqs={nc:6d} S={st['S']:.3e} leak={st['leak']:9.3f} supp={sup:2d} "
          f"{'GRADED' if graded else 'UNGRADED'}  theta0(n)={theta0(g.n):.6f}")

g6=Geom(6); W33=sphere_product(g6,3,3)
g8=Geom(8); W44=sphere_product(g8,4,4)
g4,Wcp2 = cp_m(2)
g6c,Wcp3 = cp_m(3)

print("### full-support S=0 UNGRADED critical points from orthogonal block sums")
cases = [
 ("S3xS3 (+) S3xS3, n=12",       12, [(list(range(6)),g6,W33),(list(range(6,12)),g6,W33)]),
 ("S3xS3 (+) CP2, n=10",         10, [(list(range(6)),g6,W33),(list(range(6,10)),g4,Wcp2)]),
 ("CP2 (+) CP2, n=8",             8, [(list(range(4)),g4,Wcp2),(list(range(4,8)),g4,Wcp2)]),
 ("CP2 (+) CP2 (+) CP2, n=12",   12, [(list(range(4)),g4,Wcp2),(list(range(4,8)),g4,Wcp2),(list(range(8,12)),g4,Wcp2)]),
 ("S4xS4 (+) CP2, n=12",         12, [(list(range(8)),g8,W44),(list(range(8,12)),g4,Wcp2)]),
 ("CP3 (+) CP3, n=12",           12, [(list(range(6)),g6c,Wcp3),(list(range(6,12)),g6c,Wcp3)]),
 ("S3xS3 (+) CP2 pad-in-14",     14, [(list(range(6)),g6,W33),(list(range(6,10)),g4,Wcp2)]),
]
for tag,n,pieces in cases:
    g,W,th,ths = block_sum(n,pieces)
    report(tag,g,W)

print("\n### does the same trick raise theta above theta_0(n)?  (block sums strictly lower theta)")
for tag,n,pieces in cases:
    g,W,th,ths = block_sum(n,pieces)
    print(f" {tag:44s} theta={th:.9f}  min piece theta={min(ths):.9f}  theta_0(n)={theta0(n):.9f}"
          f"  {'ABOVE theta_0' if th>theta0(n) else 'below theta_0'}")

print("\n### highest-theta S=0 ungraded point available: padded balanced products")
for k in (6,8,10,12):
    for n in (k+2,k+4):
        if n>16: continue
        gs=Geom(k); Ws=sphere_product(gs,k//2,k//2); gb=Geom(n)
        Wp=pad(gs,gb,Ws); th,_=crit_residual(gb,Wp)
        print(f" S^{k//2}xS^{k//2} padded to n={n}: theta={th:.9f} vs theta_0({n})={theta0(n):.9f}"
              f"  {'ABOVE' if th>theta0(n) else 'below'}")
gb=Geom(8); Wp=pad(g4,gb,Wcp2); print(f" W_CP2 padded to n=8: theta={crit_residual(gb,Wp)[0]:.9f} vs theta_0(8)={theta0(8):.9f} ABOVE")
