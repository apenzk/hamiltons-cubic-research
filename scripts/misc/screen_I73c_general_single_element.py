# I73 (c), n = 12, asymmetric spectra: the single-element exclusion with Eckart-Young added. A three-value critical point
# needs, in EVERY eigenspace E_c, a unit x whose per-vector LP allows theta. The LP: rows (A)-(C), Ky Fan source caps single
# and union, and Eckart-Young for each third class e: 2 sum_{a,b != e} b_ab >= mu_{N-2m_e}(x). Excluded when the supremum
# over angle vectors of the LP's theta is below theta, for some c. Screen (Nelder-Mead suprema). Usage: <log> [theta]
import sys, re, ast, itertools, numpy as np
from scipy.optimize import linprog, minimize
n=12; N=66; P=list(itertools.combinations(range(6),2)); th=float(sys.argv[2]) if len(sys.argv)>2 else 1.2361
def spectrum(m, frac):
    a = m[1]*frac+m[2]; b = -m[0]-m[1]+m[1]*frac; s = -b/a; t = -1+frac*(s+1)
    d = np.array([-1.0, t, s]); return list(d/np.sqrt(np.dot(m, d**2)))
def spec(s):
    v=[(s[i]-s[j])**2 for i,j in P]+[(s[i]+s[j])**2 for i,j in P]; return np.sort(np.r_[np.zeros(6),v,v])[::-1]
pairs=[(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]
def bvec(f):
    v=np.zeros(6)
    for x in range(3):
        for y in range(3): v[pairs.index((min(x,y),max(x,y)))]+=f(x,y)
    return v
def theta_max(s,L,m,c):
    ev=spec(s); kap=lambda r: ev[:max(r,0)].sum(); mu=lambda r: ev[::-1][:max(r,0)].sum()
    Aeq=[bvec(lambda x,y:1),bvec(lambda x,y:L[y]),bvec(lambda x,y:L[x]*L[y])]
    Aub=[bvec(lambda x,y:2*(x==a_)) for a_ in range(3)]; bub=[kap(m[a_]-(a_==c)) for a_ in range(3)]
    for b_,d_ in ((0,1),(0,2),(1,2)):
        Aub.append(bvec(lambda x,y:2*(x in (b_,d_)))); bub.append(kap(m[b_]+m[d_]-(c in (b_,d_))))
    for e in range(3):
        o=[k for k in range(3) if k!=e]
        Aub.append(-bvec(lambda x,y:1.0*(x in o and y in o))); bub.append(-0.5*mu(N-2*m[e]))
    if abs(L[c])<1e-14: return np.inf
    Aeq2=np.array([np.r_[Aeq[0],0],np.r_[Aeq[1],0],np.r_[Aeq[2],-L[c]]]); Aub2=np.array([np.r_[v,0] for v in Aub])
    sgn=1 if L[c]<0 else -1   # maximise theta; the column for theta carries -L_c
    r=linprog(np.r_[np.zeros(6),-1],A_ub=Aub2,b_ub=bub,A_eq=Aeq2,b_eq=[n-2,-L[c],-L[c]**2],bounds=[(0,None)]*6+[(None,None)],method='highs')
    return -r.fun if r.status==0 else (np.inf if r.status==3 else -np.inf)
def srt(y): s=np.sort(np.abs(y))[::-1]; return s/np.linalg.norm(s)
rng=np.random.default_rng(0); pts=[]
for l in open(sys.argv[1]):
    if l.startswith('FEASIBLE'):
        m=ast.literal_eval(re.search(r'\(.*?\)',l).group(0))
        for fr in ast.literal_eval(re.search(r'\[.*\]',l).group(0)): pts.append((m,fr))
excl=[]
for k,(m,fr) in enumerate(pts):
    L=spectrum(m,fr); hit=None
    for c in (0,2,1):
        best=-np.inf
        for _ in range(20):
            r=minimize(lambda y:-min(theta_max(srt(y),L,list(m),c),10),rng.normal(size=6),method='Nelder-Mead',options={'maxiter':800})
            best=max(best,-r.fun)
            if best>=th: break
        if best<th: hit=(c,round(best,4)); break
    if hit: excl.append((m,round(fr,3),hit)); print('EXCLUDED',m,round(fr,3),'class',hit,flush=True)
    if k%20==0: print(f'progress {k}/{len(pts)} excluded {len(excl)}',flush=True)
print(f'DONE {len(excl)} of {len(pts)} excluded at theta={th}')
