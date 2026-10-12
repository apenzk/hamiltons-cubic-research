# I73 (c), n = 12, p = 14 (r1200 asked for it on disk). Run with /usr/bin/python3 (numpy, scipy).
# screen: p=14, T16 restricted to structures with m>=3 gaps d_1j chosen (vertex 1 in P1), G2>=2, vertex 1 not in P2
# groups g in {0 (free), 1 (d), 2 (d+sigma)}; #g2 = #g0 + 1; DP over 15 groups with state (n2-n0 offset, m, G2)
import numpy as np, itertools
from scipy.optimize import minimize
P=list(itertools.combinations(range(6),2))
def cost(s):
    best=9.0
    # enumerate: dp dict key (diff=n2-n0, m, n2) -> min cost
    dp={(0,0,0):0.0}
    for (i,j) in P:
        d=(s[i]-s[j])**2; sg=(s[i]+s[j])**2; nd={}
        for (df,m,n2),c in dp.items():
            opts=[(df-1,m,n2,c),(df,m+(i==0),n2,c+d)]
            if i!=0: opts.append((df+1,m,n2+1,c+d+sg))
            for a,b,e,cc in opts:
                k=(a,b,e)
                if cc<nd.get(k,9e9): nd[k]=cc
        dp=nd
    for (df,m,n2),c in dp.items():
        if df==1 and m>=3 and n2>=2: best=min(best,c)
    return best
def srt(y): s=np.sort(np.abs(y))[::-1]; return s/np.linalg.norm(s)
rng=np.random.default_rng(0); res=[]
for _ in range(600):
    r=minimize(lambda y: cost(srt(y)),rng.normal(size=6),method='Nelder-Mead',options={'maxiter':1500})
    s=srt(r.x); res.append((cost(s),tuple(np.round(s,3)),round(s[0]**2,3)))
res.sort(); print(res[:4])
