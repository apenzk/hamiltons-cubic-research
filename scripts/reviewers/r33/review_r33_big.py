"""Push the N10 spectrum check to n=15,16 with chunked assembly."""
import sys, gc, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r33_spec import weyl_basis, sharp_operator, eps_of, predicted, s_m, c_m

def L_big(p,q,chunk=192):
    n=p+q; D=n*(n-1)//2
    eps=eps_of(p,q)
    B,_=weyl_basis(n); dim=B.shape[0]
    Bf=B.reshape(dim,D*D); del B; gc.collect()
    M=sharp_operator(n,eps)
    epsum=0.5*(eps[:,None]+eps[None,:]).reshape(-1)
    L=np.zeros((dim,dim))
    for s in range(0,dim,chunk):
        blk=Bf[s:s+chunk]                        # (c, D^2)
        Tv=(M@blk.T)                             # (D^2, c)
        T=Tv.reshape(D,D,-1)
        sh=-0.25*(T+T.transpose(1,0,2))
        out=epsum[:,None]*blk.T + sh.reshape(D*D,-1)
        L[:,s:s+chunk]=Bf@out
        del Tv,T,sh,out
    return L,dim

def cluster(ev,tol=1e-7):
    ev=np.sort(ev); out=[]
    for x in ev:
        if out and abs(x-out[-1][0])<tol: out[-1]=((out[-1][0]*out[-1][1]+x)/(out[-1][1]+1),out[-1][1]+1)
        else: out.append((x,1))
    return out

for (p,q) in [(3,12),(4,11),(5,10),(6,9),(7,8),(2,13),(4,12),(8,8),(6,10)]:
    n=p+q
    L,dim=L_big(p,q); L=(L+L.T)/2
    ev=np.linalg.eigvalsh(L); del L; gc.collect()
    cl=cluster(ev)
    pred,named=predicted(p,q,dim)
    ck=[(round(v,7),m) for v,m in cl]; used=[False]*len(ck); ok=True; rep=[]
    for v,m in sorted(pred.items()):
        hit=next((i for i,(cv,cm) in enumerate(ck) if not used[i] and abs(cv-v)<1e-6),None)
        if hit is None or ck[hit][1]!=m: ok=False; rep.append(f"pred {v}^{m} got {ck[hit] if hit is not None else 'MISSING'}")
        else: used[hit]=True
    extra=[ck[i] for i in range(len(ck)) if not used[i]]
    if extra: ok=False; rep.append(f"EXTRA {extra}")
    mu=(n-2)/(2*(p-1)*(q-1))
    print(f"({p},{q}) n={n} dim={dim} mu={mu:.8f} lam_max={ev[-1]:.10f} 2nd={ev[-2]:.10f} "
          f"{'MATCH' if ok else 'MISMATCH'}", flush=True)
    for r in rep: print("    ",r)
    del ev; gc.collect()
