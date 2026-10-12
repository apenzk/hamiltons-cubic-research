import sys, itertools, time
sys.path.insert(0,'scripts/reviewers/r98')
import numpy as np, lib98 as L
s='abcdef'
def gkd(W1,W2,W3):
    tot=0.0
    for sg in itertools.permutations(range(6)):
        # sign
        p=list(sg); sign=1
        for i in range(6):
            for j in range(i+1,6):
                if p[i]>p[j]: sign=-sign
        sub='ab'+s[sg[0]]+s[sg[1]]+','+'cd'+s[sg[2]]+s[sg[3]]+','+'ef'+s[sg[4]]+s[sg[5]]+'->'
        tot += sign*np.einsum(sub,W1,W2,W3,optimize=True)
    return tot
rng=np.random.default_rng(7)
for n in [4,5,6,7]:
    t=time.time()
    W=L.rand_weyl(n,rng); W/=np.linalg.norm(L.to_M(W,n))
    g=gkd(W,W,W); dev=L.beta(W)-L.alpha(W)/2
    ratio = g/dev if abs(dev)>1e-12 else float('nan')
    print('n=%d  GKD=%+.8e   beta-alpha/2=%+.8e   ratio=%+.6f   (%.1fs)'%(n,g,dev,ratio,time.time()-t)); sys.stdout.flush()
