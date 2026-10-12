import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, newton, math, time, os
n=int(sys.argv[1]); K=int(sys.argv[2]); seed=int(sys.argv[3]) if len(sys.argv)>3 else 7
c=core.Ctx(n); rng=np.random.default_rng(seed); d=c.W.shape[0]; found=[]; Ws=[]
t0=time.time()
for t in range(K):
    W,th,res=newton.solve(c,rng.normal(size=d),iters=80)
    if res>1e-10 or abs(th)<1e-6: continue
    lam=np.linalg.eigvalsh(W); lmin,lmax=lam[0],lam[-1]
    if lmin>=-1e-12: continue
    if th<0: W=-W; lam=np.linalg.eigvalsh(W); lmin,lmax=lam[0],lam[-1]; th=-th
    slack=lmin+(n-2)*lmax-th
    nd=len(np.unique(np.round(lam,7))); ker=int(np.sum(np.abs(lam)<1e-8))
    found.append((slack,th,res,nd,ker,int(np.sum(np.abs(lam-lmin)<1e-8))))
    Ws.append(W)
    if t%20==0:
        print(f'[{time.time()-t0:.0f}s] {t}/{K} kept={len(found)} minslack={min(f[0] for f in found) if found else None}',flush=True)
found_s=sorted(range(len(found)),key=lambda i:found[i][0])
print(f'n={n}: {len(found)} critical pts (theta>0, lmin<0) from {K} starts')
print(' slack theta res ndistinct kerdim multlmin')
for i in found_s[:15]:
    f=found[i]; print('   %.9f %.9f %.1e %d %d %d'%f)
print(' max theta:',max(f[1] for f in found) if found else None)
print(' NEGATIVE SLACK count:',sum(1 for f in found if f[0]<-1e-9))
np.save(f'scripts/reviewers/r323/crit_n{n}_s{seed}.npy',np.array(Ws))
