"""Reviewer 55: the corrector's residual floor along an excess direction IS the
third-order obstruction.  For each of the 20 excess directions compare

   lim_corrector ||Q(e)-e||    against    ||Psi(v)|| * t^3

after freezing the gauge so the corrector cannot slide back down the excess."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r55_k3j import (n,e0,B,D,Bf,V,ev,dinv,half,exc,c0,mat,G,pinvstep,correct)
from review_r55_k3b import build, make_ops
from review_r55_core import *

s=build(); _,_,circ_c,pinv,_,Psi=make_ops(s)
h2=s['half']
# express the excess columns (in the k3j eigenbasis) in the k3b E(1/2) basis
print(f"{'dir':>4} {'||Psi(v)||':>11} {'t':>6} {'floor':>11} {'floor/t^3':>11} {'ratio to ||Psi||':>17}")
for i in range(0,20,4):
    v=exc[:,i]
    a=h2.T@v
    P=Psi(a/np.linalg.norm(a)); nP=np.linalg.norm(P)
    for t in (0.02,0.05,0.1,0.2):
        c,floor=correct(c0+t*v)
        print(f"{i:>4} {nP:11.6f} {t:6.3f} {floor:11.4e} {floor/t**3:11.5f} {floor/t**3/nP:17.4f}")
