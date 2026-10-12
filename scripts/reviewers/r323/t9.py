"""Max over admissible spectra of the deficiency-LP bound. 3 distinct eigenvalues."""
import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, lp, math
from scipy.optimize import brentq

def bound_from_spec(lam,n):
    lam=np.sort(lam); lmin,lmax=lam[0],lam[-1]
    if lmin>=0 or lmax<=0: return None
    r=lp.lp_min_D(lam,n,use_marg=True)
    if not r.success: return None
    return lmin+(n-2)*lmax-r.fun/abs(lmin)

def spec3(a,b,c,t,n):
    """multiplicities a,b,c for values x<y<z ; t parametrises the 1-dim family"""
    # choose y = t (free), then solve a x + c z = -b t and a x^2 + c z^2 = 1 - b t^2
    S=-b*t; Q=1-b*t*t
    if Q<=0: return None
    # a x + c z = S, a x^2 + c z^2 = Q -> solve
    # x = (S - c z)/a ; a*((S-cz)/a)^2 + c z^2 = Q
    A=c*c/a+c; B=-2*S*c/a; C=S*S/a-Q
    disc=B*B-4*A*C
    if disc<0: return None
    for s in [1,-1]:
        z=(-B+s*math.sqrt(disc))/(2*A); x=(S-c*z)/a
        if x<t<z: return np.array([x]*a+[t]*b+[z]*c)
    return None

for n in [8,12]:
    N=n*(n-1)//2; th0=math.sqrt(2*(n-1)*(n-2))/n
    best=(-9,None)
    for a in [1,2,3,4,6,9,12,16,20,25,30,36]:
        for c in [1,2,3,4,6,9,12,15,20,25,30]:
            b=N-a-c
            if b<1: continue
            for t in np.linspace(-0.35,0.35,61):
                sp=spec3(a,b,c,t,n)
                if sp is None: continue
                bd=bound_from_spec(sp,n)
                if bd is not None and bd>best[0]: best=(bd,(a,b,c,round(t,4),sp[0],sp[-1]))
    print(f'n={n}: theta0={th0:.6f}  MAX LP bound over 3-value spectra = {best[0]:.6f}  at (d_min,d_mid,d_max,mid,lmin,lmax)={best[1]}')
