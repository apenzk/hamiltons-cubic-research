"""E1 (e): growth of the FULLY CONSTRAINED relaxation (repeat-free + row + pair + tr(W^#) + |V|<=1)
under general w. Every value is a rigorous lower bound (an explicit feasible (w,T))."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, math, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_e1_lp4 import build, twoblock, theta0
from review_r26_e1_verify import solve_full

print(f"{'n':>3} {'N':>4} | {'LP(all constraints)':>20} {'theta0':>9} {'ratio':>7} {'LP/sqrt(n-2)':>13}")
for n in [5,6,7,8,9,10]:
    N=n*(n-1)//2; taus,Arow,Apair=build(N)
    rng=np.random.default_rng(2024)
    best=(-1e9,None)
    for p in range(3,N-2):
        v,_=solve_full(n,twoblock(N,p),taus,Arow,Apair,True,True)
        if v is not None and v>best[0]: best=(v,twoblock(N,p))
    for _ in range(25):
        w=rng.normal(size=N); w-=w.mean(); w/=np.linalg.norm(w)
        v,_=solve_full(n,w,taus,Arow,Apair,True,True)
        if v is not None and v>best[0]: best=(v,w)
    cur=best[1]
    steps = 400 if n<=8 else 250
    for it in range(steps):
        w=cur+0.25*(0.99**it)*rng.normal(size=N); w-=w.mean(); w/=np.linalg.norm(w)
        v,_=solve_full(n,w,taus,Arow,Apair,True,True)
        if v is not None and v>best[0]: best=(v,w); cur=w
    print(f"{n:>3} {N:>4} | {best[0]:>20.6f} {theta0(n):>9.6f} {best[0]/theta0(n):>7.3f} "
          f"{best[0]/math.sqrt(n-2):>13.6f}", flush=True)
