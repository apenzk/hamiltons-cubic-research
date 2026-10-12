import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, diag2, lp, math, time
n=int(sys.argv[1]); K=int(sys.argv[2]); seed=int(sys.argv[3])
c=core.Ctx(n); pos={p:i for i,p in enumerate(c.P)}; rng=np.random.default_rng(seed)
d=n*(n-1)//2; rows=[]; t0=time.time(); sat=[]
for t in range(K):
    M,thd,res=diag2.solve(n,rng.normal(size=d)*rng.choice([1.0,3.0]))
    if np.linalg.norm(M)<1e-9: continue
    W=np.zeros((c.N,c.N))
    for (i,j),k in pos.items(): W[k,k]=M[i,j]
    W/=np.sqrt(np.trace(W@W)); th,r=core.crit_residual(c,W)
    if r>1e-11: continue
    if th<0: W=-W; th=-th
    lam=np.linalg.eigvalsh(W); lmin,lmax=lam[0],lam[-1]
    if lmin>=-1e-12 or lmax<=1e-12: continue
    slack=lmin+(n-2)*lmax-th
    pi=(n-1)*abs(lmin)-th                       # Pi-bound slack
    spec=(n-2)*lmax-n*abs(lmin)                 # spectral term
    rows.append((slack,th,r,pi,spec,len(np.unique(np.round(lam,7))),int(np.sum(np.abs(lam)<1e-8))))
    if slack<1e-7: sat.append(W)
    if t%50==0: print(f'[{time.time()-t0:.0f}s] {t}/{K} kept={len(rows)} minslack={min(x[0] for x in rows) if rows else None} maxtheta={max(x[1] for x in rows) if rows else None}',flush=True)
rows.sort()
print(f'n={n} DIAGONAL: {len(rows)} critical pts from {K} starts')
print(' slack | theta | res | Pi-slack | (n-2)lmax-n|lmin| | #eig | kerdim')
for x in rows[:15]: print('  %.9f %.9f %.1e %.9f %.9f %d %d'%x)
print(' worst-case negative slack:',min(x[0] for x in rows))
print(' max theta:',max(x[1] for x in rows))
print(' min Pi-slack:',min(x[3] for x in rows))
