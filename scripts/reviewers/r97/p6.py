import sys,time,itertools; sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
from weyl97 import *
SC='scratchpad'
L='abcdef'
PERMS=list(itertools.permutations(range(6)))
def sgn(p):
    s=1
    p=list(p)
    for i in range(6):
        for j in range(i+1,6):
            if p[i]>p[j]: s=-s
    return s
SUBS=[]
for p in PERMS:
    sub=f"{L[0]}{L[1]}{L[p[0]]}{L[p[1]]},{L[2]}{L[3]}{L[p[2]]}{L[p[3]]},{L[4]}{L[5]}{L[p[4]]}{L[p[5]]}->"
    SUBS.append((sgn(p),sub))
def K6(W):
    tot=0.0
    for s,sub in SUBS:
        tot += s*np.einsum(sub,W,W,W,optimize=True)
    return tot
rng=np.random.default_rng(606)
for n in range(4,8):
    B=np.load(f'{SC}/wb{n}.npy'); d=len(B)
    for s in range(3):
        M=np.tensordot(rng.normal(size=d),B,axes=1); M/=np.linalg.norm(M); W=M_to_W(M,n)
        t0=time.time(); k=K6(W); dt=time.time()-t0
        a=alpha(W); b=beta(W); target=b-a/2
        ratio = (k/target) if abs(target)>1e-12 else float('nan')
        print(f"n={n} s={s}: K6={k:.9f}  beta-alpha/2={target:.9f}  K6/(beta-alpha/2)={ratio:.6f}  -64*(b-a/2)={-64*target:.9f}  [{dt:.1f}s]")
    sys.stdout.flush()
