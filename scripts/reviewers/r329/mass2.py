import sys; sys.path.insert(0,'scripts/reviewers/r329')
import numpy as np; from core import *; from families import *
def show(name,n,W):
    idx,B,c=struct_consts(n)
    ev,V=np.linalg.eigh(W); ce=np.einsum('abc,ai,bj,ck->ijk',c,V,V,V); T=ce**2
    M=np.where(np.abs(ev-ev[0])<1e-9)[0]; H=np.where(np.abs(ev-ev[-1])<1e-9)[0]
    dm,dh=len(M),len(H)
    mrow_tot=T[M].sum()
    mrow_blk=T[np.ix_(M,M,H)].sum()+T[np.ix_(M,H,M)].sum()
    hrow_tot=T[H].sum(); hrow_mm=T[np.ix_(H,M,M)].sum()
    print("%-14s n=%d dm=%d dh=%d || m-row tot %g (half %g) | m-row on(m,h) %g (half %g) | dm(n-2)=%d || h-row tot %g | h-row on(m,m) %g | residue %g (half %g) | (n-2)(2dh-dm)=%d dh(n-4)=%d"
      %(name,n,dm,dh,mrow_tot,mrow_tot/2,mrow_blk,mrow_blk/2,dm*(n-2),hrow_tot,hrow_mm,hrow_tot-hrow_mm,(hrow_tot-hrow_mm)/2,(n-2)*(2*dh-dm),dh*(n-4)))
show("balanced n=6",6,W_from_h(6,h_blocks(6,[0,0,0,1,1,1])))
show("torus n=6",6,W_from_h(6,h_blocks(6,[0,0,1,1,2,2])))
show("balanced n=8",8,W_from_h(8,h_blocks(8,[0]*4+[1]*4)))
