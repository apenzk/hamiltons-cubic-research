"""E1: which two-block w attains the LP maximum once tr(W^#)=-1 is imposed?"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, math, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import itertools
from scipy.optimize import linprog
from scipy.sparse import coo_matrix, vstack
from review_r26_e1_lp4 import build, twoblock, theta0, solve

for n in [6,8,10,12]:
    N=n*(n-1)//2; m=n//2
    taus,Arow,Apair=build(N)
    best=(-1e9,None)
    for p in range(3,N-2):
        v=solve(n,twoblock(N,p),taus,Arow,Apair,True,True)
        if v is not None and v>best[0]: best=(v,p)
    ppure=m*(m-1)      # # of pure bivectors = 2*C(m,2), the sphere product's positive block
    print(f"n={n}: argmax p = {best[1]}   value {best[0]:.10f}   theta0 {theta0(n):.10f}   "
          f"diff {abs(best[0]-theta0(n)):.2e}   |  #pure bivectors of S^{m} x S^{m} = {ppure}")
