import sys,time,itertools; sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
from weyl97 import *
SC='scratchpad'
rng=np.random.default_rng(4242)

def a3(X,Y,Z): return np.einsum('tpsq,tpkl,sqkl->',X,Y,Z,optimize=True)
def b3(X,Y,Z): return np.einsum('tspq,tjpl,sjql->',X,Y,Z,optimize=True)
def sym(f,X,Y,Z):
    T=[X,Y,Z]; return sum(f(T[p[0]],T[p[1]],T[p[2]]) for p in itertools.permutations(range(3)))/6.0

print("=== Claim C: diagonal beta = alpha/2 ? ===")
for n in range(4,9):
    B=np.load(f'{SC}/wb{n}.npy'); d=len(B); mx=0; sc=0
    for s in range(15):
        M=np.tensordot(rng.normal(size=d),B,axes=1); M/=np.linalg.norm(M); W=M_to_W(M,n)
        a=alpha(W); b=beta(W); mx=max(mx,abs(b-a/2)); sc=max(sc,abs(a))
    print(f"  n={n}: max|beta-alpha/2|={mx:.3e}  (scale max|alpha|={sc:.3f})")

print("=== Claim C polarised: full trilinear form on independent X,Y,Z ===")
for n in range(4,9):
    B=np.load(f'{SC}/wb{n}.npy'); d=len(B)
    mr=0; ms=0
    for s in range(8):
        Ws=[]
        for k in range(3):
            M=np.tensordot(rng.normal(size=d),B,axes=1); M/=np.linalg.norm(M); Ws.append(M_to_W(M,n))
        X,Y,Z=Ws
        mr=max(mr,abs(b3(X,Y,Z)-a3(X,Y,Z)/2))
        ms=max(ms,abs(sym(b3,X,Y,Z)-sym(a3,X,Y,Z)/2))
    print(f"  n={n}: max|beta(X,Y,Z)-alpha(X,Y,Z)/2| raw={mr:.3e}  symmetrised={ms:.3e}")
