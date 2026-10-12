import sys; sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
from weyl97 import *
SC='scratchpad'
rng=np.random.default_rng(97)
for n in range(4,9):
    B=np.load(f'{SC}/wb{n}.npy'); d=len(B)
    NS = max(120, 2*d)
    coeffs = rng.normal(size=(NS,d))
    # spanning check: rank of sample set in W_n coordinates
    r = np.linalg.matrix_rank(coeffs, tol=1e-8)
    errs=[]
    for s in range(min(NS,25)):
        M = np.tensordot(coeffs[s],B,axes=1); M/=np.linalg.norm(M)
        W = M_to_W(M,n)
        a=alpha(W); b=beta(W)
        t3=np.trace(M@M@M); sm=np.sum(sharp(M,n)*M)
        errs.append((abs(a-8*t3), abs(b-2*sm), a,b,t3,sm))
    ea=max(e[0] for e in errs); eb=max(e[1] for e in errs)
    print(f"n={n} dimW={d} samples={NS} sample-rank={r} | max|alpha-8trM^3|={ea:.3e} max|beta-2<M#,M>|={eb:.3e}")
    print(f"    e.g. alpha={errs[0][2]:.6f} 8trM3={8*errs[0][4]:.6f}  beta={errs[0][3]:.6f} 2<M#,M>={2*errs[0][5]:.6f}")
