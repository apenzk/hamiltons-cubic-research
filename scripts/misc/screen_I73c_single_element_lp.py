# I73 (c), n = 12, window 8 <= p <= 13: supremum over angle vectors of the full single-element per-vector LP (rows,
# every Ky Fan cap single and union, Eckart-Young 2 sum_{a,b != e} b_ab >= mu_{N-2m_e}); equals L249's. /usr/bin/python3, minutes.
# per-vector LP at x in E_0 (symmetric spectrum): rows A,B,C + Ky Fan source caps (single and union) + Eckart-Young
# for each third class e: 2*sum_{a,b in other two} b_ab >= mu_{N-2 m_e}(x). Region = {s: LP theta_max >= theta_0}.
import numpy as np, itertools
from scipy.optimize import linprog, minimize
n=12; N=66; P=list(itertools.combinations(range(6),2))
def spec(s):
    v=[(s[i]-s[j])**2 for i,j in P]+[(s[i]+s[j])**2 for i,j in P]
    return np.sort(np.r_[np.zeros(6),v,v])[::-1]
pairs=[(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]
def bvec(f):
    v=np.zeros(6)
    for x in range(3):
        for y in range(3): v[pairs.index((min(x,y),max(x,y)))]+=f(x,y)
    return v
def theta_max(s,p,EY=True):
    a=1/np.sqrt(2*p); L=[-a,0,a]; m=[p,N-2*p,p]; c=0
    ev=spec(s); kap=lambda r: ev[:max(r,0)].sum(); mu=lambda r: ev[::-1][:max(r,0)].sum()
    Aeq=[bvec(lambda x,y:1),bvec(lambda x,y:L[y]),bvec(lambda x,y:L[x]*L[y])]
    Aub=[bvec(lambda x,y:2*(x==a_)) for a_ in range(3)]; bub=[kap(m[a_]-(a_==c)) for a_ in range(3)]
    for b_,d_ in ((0,1),(0,2),(1,2)):
        Aub.append(bvec(lambda x,y:2*(x in (b_,d_)))); bub.append(kap(m[b_]+m[d_]-(c in (b_,d_))))
    if EY:
        for e in range(3):
            o=[k for k in range(3) if k!=e]
            Aub.append(-bvec(lambda x,y: 1.0*(x in o and y in o))); bub.append(-0.5*mu(N-2*m[e]))
    Aeq2=np.array([np.r_[Aeq[0],0],np.r_[Aeq[1],0],np.r_[Aeq[2],-L[c]]]); Aub2=np.array([np.r_[v,0] for v in Aub])
    r=linprog(np.r_[np.zeros(6),-1],A_ub=Aub2,b_ub=bub,A_eq=Aeq2,b_eq=[n-2,-L[c],-L[c]**2],bounds=[(0,None)]*6+[(None,None)],method='highs')
    return -r.fun if r.status==0 else -9

th0=np.sqrt(220)/12
def srt(y): s=np.sort(np.abs(y))[::-1]; return s/np.linalg.norm(s)
rng=np.random.default_rng(1)
for p in range(8,14):
    best=-9;arg=None
    for _ in range(300):
        r=minimize(lambda y:-theta_max(srt(y),p),rng.normal(size=6),method='Nelder-Mead',options={'maxiter':2000})
        if -r.fun>best: best=-r.fun; arg=np.round(srt(r.x),3)
    print(p,'sup theta_max',round(best,4),'theta0',round(th0,4),'EXCLUDED' if best<th0 else 'open',arg,flush=True)
