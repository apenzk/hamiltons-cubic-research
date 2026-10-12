# I73 (c), n = 12, asymmetric three-value spectra: the general coupled average against the recorded survivors.
# At x in E_0:  E[(p0+2) tr x^4 + c0 mu_{p1}(x)] <= R0,  c0 = 2(l2-l1)/(l2-l0),  R0 = 6 + 4(l0+(n-2)l2)/(l2-l0),
#   region: (1/2)(l2-l1)^2 mu_{N-2p2}(x) <= (n-2)l2^2 - 2 l2|l0| - l0^2 - |l0| theta  (general per-element ceiling).
# At x in E_2 (mirror): E[(p2+2) tr x^4 + c2 mu_{p1}(x)] <= R2, c2 = 2(l1-l0)/(l2-l0), R2 = 6 + 4((n-2)|l0|-l2)/(l2-l0),
#   region: (1/2)(l1-l0)^2 mu_{N-2p0}(x) <= l2 theta - l2^2 - 2|l0| l2 + (n-2) l0^2.
# A spectrum is excluded when min over the region of the bracket exceeds the right side (screen: Nelder-Mead minimum).
# Usage: /usr/bin/python3 <this> <survivor log> [theta]
import sys, re, ast, itertools, numpy as np
from scipy.optimize import minimize
n=12; N=66; P=list(itertools.combinations(range(6),2)); th=float(sys.argv[2]) if len(sys.argv)>2 else 1.2361
def spectrum(m, frac):
    a = m[1]*frac+m[2]; b = -m[0]-m[1]+m[1]*frac; s = -b/a; t = -1+frac*(s+1)
    d = np.array([-1.0, t, s]); return list(d/np.sqrt(np.dot(m, d**2)))
def ev(s):
    v=[(s[i]-s[j])**2 for i,j in P]+[(s[i]+s[j])**2 for i,j in P]; return np.sort(np.r_[np.zeros(6),v,v])
def srt(y): s=np.sort(np.abs(y))[::-1]; return s/np.linalg.norm(s)
rng=np.random.default_rng(0)
pts=[]
for l in open(sys.argv[1]):
    if l.startswith('FEASIBLE'):
        m=ast.literal_eval(re.search(r'\(.*?\)',l).group(0))
        for fr in ast.literal_eval(re.search(r'\[.*\]',l).group(0)): pts.append((m,fr))
excl=[]
for k,(m,fr) in enumerate(pts):
    l0,l1,l2=spectrum(m,fr); p0,p1,p2=m; a0=-l0
    sides=[(p0,2*(l2-l1)/(l2-l0),6+4*(l0+(n-2)*l2)/(l2-l0),0.5*(l2-l1)**2,N-2*p2,(n-2)*l2**2-2*l2*a0-l0**2-a0*th),
           (p2,2*(l1-l0)/(l2-l0),6+4*((n-2)*a0-l2)/(l2-l0),0.5*(l1-l0)**2,N-2*p0,l2*th-l2**2-2*a0*l2+(n-2)*l0**2)]
    hit=None
    for side,(pc,c,R,w,r,D) in enumerate(sides):
        if D<0: hit=(side,'region empty'); break
        def f(y):
            s=srt(y); e=ev(s); mu_r=e[:max(r,0)].sum(); pen=100*max(0,w*mu_r-D)
            return (pc+2)*2*np.sum(s**4)+c*e[:p1].sum()+pen
        best=min(minimize(f,rng.normal(size=6),method='Nelder-Mead',options={'maxiter':1500}).fun for _ in range(25))
        if best>R: hit=(side,round(best,3),round(R,3)); break
    if hit: excl.append((m,round(fr,3),hit))
    if k%20==0: print(f'progress {k}/{len(pts)} excluded so far {len(excl)}',flush=True)
for e in excl: print('EXCLUDED',e)
print(f'DONE {len(excl)} of {len(pts)} excluded at theta={th}')
