import numpy as np, collections
from core import *; from weyl import *; from tools import *; from sub import *; from solve import *
n=6; pairs,B,bas=weyl_basis(n); C=structure(B); F=bas.reshape(84,-1)
def ascend(x,iters=4000):
    for k in range(iters):
        W=np.einsum('i,ijk->jk',x,bas)
        g=F@Q(W,C).ravel()
        y=x+0.3*g
        nn=np.linalg.norm(y)
        if nn<1e-12: return x
        y/=nn
        if np.linalg.norm(y-x)<1e-14: x=y; break
        x=y
    return x
rng=np.random.default_rng(5); vals=[]; gr=0
for t in range(500):
    x=rng.normal(size=84); x/=np.linalg.norm(x)
    x=ascend(x)
    W=np.einsum('i,ijk->jk',x,bas); th=theta(W,C)
    res=np.abs(Q(W,C)-th*W).max()
    if res<1e-8:
        vals.append(th)
        r=grading_report(W,C,tol=1e-8)
        if r['graded']: gr+=1
vals=np.array(vals)
print('full Weyl_6 ascent: %d converged, max theta = %.9f, distinct top: %s'%(len(vals),vals.max(),np.array2string(np.unique(np.round(vals,6))[-8:],precision=6)))
print('graded among ascent limits:',gr)
print('S3xS3 theta 1.054093 ; CP2-padded theta 1.224745')
print('count within 1e-6 of 1.054093:',int(np.sum(np.abs(vals-1.0540925533894598)<1e-6)))
print('count within 1e-6 of 1.224745:',int(np.sum(np.abs(vals-np.sqrt(1.5))<1e-6)))
