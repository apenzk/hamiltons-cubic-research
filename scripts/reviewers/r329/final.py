import sys; sys.path.insert(0,'scripts/reviewers/r329')
import numpy as np; from core import *; from core import _pairidx; from families import *; from solve import solve_crit
rng=np.random.default_rng(5)
# (a) trace-free on W_n
for n in (5,6,8):
    Bo=weyl_basis(n)
    tr=[abs(np.trace(np.einsum('k,kij->ij',rng.normal(size=Bo.shape[0]),Bo))) for _ in range(5)]
    print("n=%d  max |tr W| over random W in W_n: %.2e"%(n,max(tr)))
# (b) bracket relations + ideal at balanced products
for n in (6,8):
    idx,B,c=struct_consts(n); Bo=weyl_basis(n); N=len(idx)
    m2=n//2; W,_=subalg_W(n,[0]*m2+[1]*m2)
    ev,V=np.linalg.eigh(W)
    mi=np.abs(ev-ev[0])<1e-9; ha=np.abs(ev-ev[-1])<1e-9; rr=~(mi|ha)
    ce=np.einsum('abc,ai,bj,ck->ijk',c,V,V,V)
    def mass(A,Bs,C): return float((ce[np.ix_(A,Bs,C)]**2).sum())
    M=np.where(mi)[0]; H=np.where(ha)[0]; R=np.where(rr)[0]
    ALL=np.arange(N)
    print("n=%d dim m/h/r = %d/%d/%d"%(n,len(M),len(H),len(R)))
    print("   [m,m] off h : %.2e   [m,h] off m : %.2e   [m,r] : %.2e"%(
        mass(M,M,np.setdiff1d(ALL,H)), mass(M,H,np.setdiff1d(ALL,M)), mass(M,R,ALL)))
    # g' = m + [m,m]; check dim
    Bmm=np.array([ce[a,b,:] for a in M for b in M])
    s=np.linalg.svd(Bmm,compute_uv=False); dmm=int((s>1e-9*s[0]).sum())
    print("   dim[m,m]=%d (dim h=%d)  dim m + dim[m,m] = %d (N=%d)"%(dmm,len(H),len(M)+dmm,N))
    print("   [h,[m,m]] off [m,m] : %.2e   [h,h] off h : %.2e"%(mass(H,H,np.setdiff1d(ALL,M)) if False else mass(H,H,np.setdiff1d(ALL,H)), mass(H,H,np.setdiff1d(ALL,H))))
# (c) mass law both conventions at W_CP2 (n=4) and torus (n=6)
def masslaw(name,n,W):
    idx,B,c=struct_consts(n); N=len(idx)
    ev,V=np.linalg.eigh(W); ce=np.einsum('abc,ai,bj,ck->ijk',c,V,V,V); T=ce**2
    M=np.where(np.abs(ev-ev[0])<1e-9)[0]; H=np.where(np.abs(ev-ev[-1])<1e-9)[0]
    mrow=T[M].sum(); hrow=T[H].sum(); hmm=T[np.ix_(H,M,M)].sum()
    dm,dh=len(M),len(H)
    print("%-16s n=%d dm=%d dh=%d | m-row ordered=%.0f  half=%.0f  dm(n-2)=%d | residue ordered=%.0f half=%.0f  (n-2)(2dh-dm)=%d dh(n-4)=%d"%(
        name,n,dm,dh,mrow,mrow/2,dm*(n-2),hrow-hmm,(hrow-hmm)/2,(n-2)*(2*dh-dm),dh*(n-4)))
Bo4=weyl_basis(4); Wc4=W_cp(4,2); Wc4=dist_weyl(Wc4,Bo4)[1]; Wc4/=np.linalg.norm(Wc4)
masslaw("W_CP2",4,Wc4)
masslaw("S2xS2",4,W_from_h(4,h_blocks(4,[0,0,1,1])))
masslaw("torus n=6",6,W_from_h(6,h_blocks(6,[0,0,1,1,2,2])))
masslaw("balanced n=6",6,W_from_h(6,h_blocks(6,[0,0,0,1,1,1])))
