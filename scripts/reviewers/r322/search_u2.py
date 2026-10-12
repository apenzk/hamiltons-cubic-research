import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, itertools, core, points, walk, diagcrit

def analyse(n, M, th):
    W=points.diagW(n,M)
    lam,Phi,C=walk.walk_data(n,W)
    b,m,p,z=walk.blocks(lam,C)
    Smmm,Smpp,c=walk.S_tensors(n,lam,Phi)
    mult=int((np.abs(lam-lam[0])<1e-9).sum())
    return b,Smmm,Smpp,mult,lam

def graph_facts(n,M,tol=1e-9):
    neg=[(i,j) for i,j in core.pairs(n) if M[i,j]<-tol]
    pos=[(i,j) for i,j in core.pairs(n) if M[i,j]>tol]
    negset=set(neg); posset=set(pos)
    tri=[t for t in itertools.combinations(range(n),3)
         if all((min(a,b),max(a,b)) in negset for a,b in itertools.combinations(t,2))]
    # min edge
    e0=min(core.pairs(n), key=lambda e: M[e])
    i,j=e0
    tri_at_e0=[k for k in range(n) if k not in e0 and (min(i,k),max(i,k)) in negset and (min(j,k),max(j,k)) in negset]
    pp_at_e0=[k for k in range(n) if k not in e0 and (min(i,k),max(i,k)) in posset and (min(j,k),max(j,k)) in posset]
    mpp_any=[(e,k) for e in neg for k in range(n) if k not in e
             and (min(e[0],k),max(e[0],k)) in posset and (min(e[1],k),max(e[1],k)) in posset]
    return neg,pos,tri,e0,tri_at_e0,pp_at_e0,mpp_any

rng=np.random.default_rng(int(sys.argv[1]) if len(sys.argv)>1 else 1)
found_mm=[]; found_pp=[]
ns=[6,7,8]
for trial in range(int(sys.argv[2]) if len(sys.argv)>2 else 400):
    n=ns[trial%len(ns)]
    M,th,res,ier=diagcrit.find_diag_critical(n,rng)
    if ier!=1 or res>1e-10 or th<=1e-6: continue
    neg,pos,tri,e0,tri_e0,pp_e0,mpp_any=graph_facts(n,M)
    # counterexample A: mm block 0 (no negative triangle at e0) but S_mmm>0 (graph has a triangle)
    if len(tri)>0 and len(tri_e0)==0:
        found_mm.append((n,M.copy(),th,tri,e0))
    # counterexample B: pp block 0 at e0 but S_mpp>0
    if len(mpp_any)>0 and len(pp_e0)==0:
        found_pp.append((n,M.copy(),th,e0))
print('mm-counterexamples',len(found_mm),' pp-counterexamples',len(found_pp))
np.save('/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/cex_mm.npy',
        np.array([f[1] for f in found_mm],dtype=object),allow_pickle=True)
for tag,found in (('MM',found_mm),('PP',found_pp)):
    for (n,M,th,*rest) in found[:4]:
        b,Smmm,Smpp,mult,lam=analyse(n,M,th)
        print(f'{tag} n={n} theta={th:.7f} lmin={lam[0]:.6f} mult={mult} mm={b["mm"]:.3e} mp={b["mp"]:.6f} pp={b["pp"]:.3e} Smmm={Smmm:.4f} Smpp={Smpp:.4f} dimm={b["dimm"]} dimp={b["dimp"]} dimz={b["dimz"]}')
        np.save(f'/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/cex_{tag}_{n}_{abs(hash(M.tobytes()))%10000}.npy',M)
