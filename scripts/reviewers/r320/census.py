import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, lib320 as L, solve320 as S, json, time
n=int(sys.argv[1]); ntr=int(sys.argv[2]); out=sys.argv[3]
N=L.struct(n).shape[0]; rows=[]; t0=time.time()
for s in range(ntr):
    try: W,th,res=S.find(n,1000+s)
    except Exception: continue
    if res>1e-9 or abs(th)<1e-7: continue
    if th<0: W=-W; th=-th
    ev=np.linalg.eigvalsh(W); tol=1e-8
    rp=int((ev>tol).sum()); rm=int((ev<-tol).sum()); k=len(ev)-rp-rm
    rows.append(dict(seed=s,theta=float(th),res=float(res),rp=rp,rm=rm,ker=k,
        lmin=float(ev.min()),lmax=float(ev.max()),
        nev=int(len(np.unique(np.round(ev,7)))),
        bound_r=float((2/n)*np.sqrt(rp*N/(N-rp))) if rp<N else float('inf'),
        bound_lmin=float((n-1)*abs(ev.min()))))
    if s%50==0:
        json.dump(rows,open(out,"w"))
    if s%50==0: print(f"[{time.time()-t0:6.1f}s] {s}/{ntr} kept {len(rows)}",flush=True)
json.dump(rows,open(out,'w'))
print("kept",len(rows),"of",ntr,"in %.1fs"%(time.time()-t0))
