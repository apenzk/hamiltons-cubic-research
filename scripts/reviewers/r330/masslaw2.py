import numpy as np, core, fam
def blk(name,n,W,wl,tol=1e-8):
    W=W/np.linalg.norm(W); c=wl.c
    res,th=fam.crit_res(W,c); ev,V=np.linalg.eigh(W)
    m=np.abs(ev-ev[0])<tol; h=np.abs(ev-ev[-1])<tol; r=~(m|h)
    dm,dh,dr=int(m.sum()),int(h.sum()),int(r.sum())
    ce=np.einsum('ai,bj,ck,ijk->abc',V.T,V.T,V.T,c); T=ce**2
    Mrow = T[m].sum()                       # full row mass over m (ordered)
    Mblk = T[np.ix_(m,m,h)].sum()+T[np.ix_(m,h,m)].sum()   # m rows landing on (m,h) pairs
    hm   = T[np.ix_(h,m,m)].sum()
    hrow = T[h].sum()
    print(f"{name:24s} n={n:2d} slack={ev[0]+(n-2)*ev[-1]-th:+.3e} dm/dh/dr={dm}/{dh}/{dr} | "
          f"m-row total={Mrow:.1f} m-row on(m,h)={Mblk:.1f} (half={Mblk/2:.1f}) | "
          f"h-row total={hrow:.1f} h-row on(m,m)={hm:.1f} residue={hrow-hm:.1f} (half={(hrow-hm)/2:.1f}) | "
          f"dm(n-2)={dm*(n-2)} (n-2)(2dh-dm)={(n-2)*(2*dh-dm)} dh(n-4)={dh*(n-4)}")
for n in [6,8,10,12]:
    wl=core.Weyl(n); g=fam.so_block(n,list(range(n//2)))+fam.so_block(n,list(range(n//2,n)))
    blk(f"balanced n={n}",n,fam.W_from_subalgebra(n,g,wl),wl)
wl4=core.Weyl(4); blk("W_CP2",4,fam.W_cp2(),wl4)
blk("S2xS2 n=4",4,fam.W_from_subalgebra(4,fam.so_block(4,[0,1])+fam.so_block(4,[2,3]),wl4),wl4)
wl6=core.Weyl(6); blk("torus n=6 CONTROL",6,fam.W_from_subalgebra(6,fam.torus(6),wl6),wl6)
