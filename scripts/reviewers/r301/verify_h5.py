import sys, time; sys.path.insert(0,'scripts/reviewers/r301')
import numpy as np, core301 as C, points301 as PT, defect as DF, diag_census as DC, hunt as HN
n=10
hit=None
for s in range(200):
    r=DC.solve_diag(n,s)
    if r is None: continue
    L,th,res=r
    if abs(th-0.641091)<1e-4:
        hit=(s,L,th,res); break
print("seed",hit[0],"theta",hit[2],"resid",hit[3])
s,L,th,res = hit
np.save('scripts/reviewers/r301/w_n10_h5_counterexample_vertex.npy', L)
lab,nb = DC.blocks_of(L); G = DC.neg_block_graph(L,lab,nb)
print("blocks",lab,"nb",nb)
print("negative block graph:")
for row in G: print("   ",row)
print("block weight matrix:")
import collections
rep=[lab.index(a) for a in range(nb)]
Bw=np.zeros((nb,nb))
for a in range(nb):
    for b in range(nb):
        i=rep[a]; j=rep[b] if b!=a else (lab.index(a)+1 if lab.count(a)>1 else None)
        if b==a:
            idxs=[k for k in range(n) if lab[k]==a]
            Bw[a,b]= L[idxs[0],idxs[1]] if len(idxs)>1 else np.nan
        else:
            Bw[a,b]=L[rep[a],rep[b]]
print(np.round(Bw,6))
W=DC.to_operator(n,L)
pos,tot,ev=DF.delta(n,W)
print(f"Delta={pos:.6f} of total {tot:.4f}; eigenvalues of W: {np.round(np.unique(np.round(ev,8)),6)}")
As=DF.edge_family(n,W,th,lab,G,'edge')
e2,U=DF.compress_on(n,W,th,As)
print(f"edge family: |A|={len(As)} dimV={U.shape[0]} avg={e2.mean():.9f} max={e2.max():.6f} min={e2.min():.6f}")
As2=DF.edge_family(n,W,th,lab,G,'allpairs')
e3,U3=DF.compress_on(n,W,th,As2)
print(f"all-pairs family: dimV={U3.shape[0]} avg={e3.mean():.9f} max={e3.max():.6f}")
t0=time.time()
st=HN.stats(n,W,th)
print(f"lam_max(L_e|Wperp)={st['lam_full']:.6f}  lam_max on Sym_0={st['lam_sym0']:.6f}  avg Sym_0={st['avg_sym0']:.6f} dimV_Sym0={st['dimV']}  ({time.time()-t0:.0f}s)")
