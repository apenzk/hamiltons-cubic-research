"""Catalogue: dim m, number of scalar conditions in {S=0}, S, leak, support, gradedness."""
import numpy as np
from review_r47_core import *
from review_r47_t3 import cp_m, support_rank, kblock
from review_r47_t3b import block_sum

rows=[]
def add(tag,g,W):
    th,res=crit_residual(g,W); st=struct_sums(g,W); sup=support_rank(g,W)
    dm=st['dim_m']; nc=0 if dm<3 else dm*(dm-1)*(dm-2)//6
    grass = dm*(g.N-dm)
    rows.append(dict(tag=tag,n=g.n,th=th,res=res,dm=dm,nc=nc,grass=grass,
                     S=st['S'],leak=st['leak'],sup=sup,
                     graded=(st['leak']<1e-12 and st['S']<1e-12)))

g4,Wcp2=cp_m(2); g6c,Wcp3=cp_m(3); g8c,Wcp4=cp_m(4)
add("W_CP2 (n=4, native)",g4,Wcp2); add("W_CP3 (n=6, native)",g6c,Wcp3); add("W_CP4 (n=8, native)",g8c,Wcp4)
for n in (8,10,12):
    g=Geom(n); add(f"W_CP2 padded to n={n}",g,pad(g4,g,Wcp2))
for (p,q) in ((3,3),(4,4),(5,5),(6,6)):
    gs=Geom(p+q); add(f"S^{p}xS^{q} (native)",gs,sphere_product(gs,p,q))
for (p,q,n) in ((3,3,8),(3,3,12),(4,4,12),(5,5,14),(6,6,14)):
    gs=Geom(p+q); gb=Geom(n); add(f"S^{p}xS^{q} padded to n={n}",gb,pad(gs,gb,sphere_product(gs,p,q)))
g6=Geom(6); W33=sphere_product(g6,3,3); g8=Geom(8); W44=sphere_product(g8,4,4)
for tag,n,pieces in (("CP2 (+) CP2",8,[(list(range(4)),g4,Wcp2),(list(range(4,8)),g4,Wcp2)]),
                     ("S3xS3 (+) S3xS3",12,[(list(range(6)),g6,W33),(list(range(6,12)),g6,W33)]),
                     ("S4xS4 (+) CP2",12,[(list(range(8)),g8,W44),(list(range(8,12)),g4,Wcp2)])):
    g,W,_,_=block_sum(n,pieces); add(f"{tag}, n={n}",g,W)
for blocks in ((2,2,2),(3,3,3),(4,4,4),(2,2,2,2)):
    g=Geom(sum(blocks)); add(f"blocks {blocks}",g,kblock(g,blocks))

hdr=f"{'point':32s} {'n':>2s} {'theta':>11s} {'dim m':>5s} {'#S-eqs':>7s} {'dimGr':>6s} {'S':>10s} {'leak':>9s} {'supp':>4s} {'verdict'}"
print(hdr); print('-'*len(hdr))
for r in rows:
    v = 'GRADED' if r['graded'] else ('ungraded, S=0  <-- COUNTEREXAMPLE' if r['S']<1e-12 else 'ungraded, S>0')
    print(f"{r['tag']:32s} {r['n']:2d} {r['th']:11.7f} {r['dm']:5d} {r['nc']:7d} {r['grass']:6d} "
          f"{r['S']:10.3e} {r['leak']:9.2f} {r['sup']:4d} {v}")
print()
ce=[r for r in rows if (not r['graded']) and r['S']<1e-12]
print(f"S=0 ungraded counterexamples: {len(ce)}, dim m from {min(r['dm'] for r in ce)} to {max(r['dm'] for r in ce)},")
print(f"  #scalar conditions in S=0 from {min(r['nc'] for r in ce)} to {max(r['nc'] for r in ce)},")
print(f"  theta from {min(r['th'] for r in ce):.6f} to {max(r['th'] for r in ce):.6f}"
      f" (theta_0 at those n: {[round(theta0(r['n']),6) for r in ce]})")
print(f"  full-support ones: {[r['tag'] for r in ce if r['sup']==r['n']]}")
