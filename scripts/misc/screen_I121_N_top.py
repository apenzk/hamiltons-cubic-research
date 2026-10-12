"""Falsifier screen: is lambda_max(N) <= tr(N)/4 for every Weyl tensor, N_ik = sum W_impq W_kmpq?

Random-perturbation ascent on lambda_max(N)/tr N from four starts at n = 5, 6, 8 (400 steps each),
reporting the largest ratio and the largest |N|_F^2 found; equality 1/4 and |N|_F^2 = 4 hold at every
padded four-dimensional Weyl tensor. Values found are lower bounds on the maxima. (seconds)
Run: sage -python scripts/misc/screen_I121_N_top.py
"""
import numpy as np
src=open("scripts/misc/g1_I121_E_second_kind.py").read()
src=src[:src.index("for n in (6,8,10):")]; ns={}; exec(src,ns)
bw=ns['bianchi_weyl']; normalise=ns['normalise']
rng=np.random.default_rng(11)
def ratio(W):
    W=normalise(W); N=np.einsum('impq,kmpq->ik',W,W); ev=np.linalg.eigvalsh(N)
    return ev[-1]/np.trace(N), (N**2).sum()
for n in (5,6,8):
    best=0; bestF=0
    for start in range(4):
        W=bw(rng.normal(size=(n,n,n,n))); r,F=ratio(W); step=0.3
        for it in range(400):
            V=W+step*bw(rng.normal(size=(n,n,n,n)))*np.linalg.norm(W)/np.sqrt(W.size)
            r2,F2=ratio(V)
            if r2>r: W,r,F=V,r2,F2
            else: step*=0.995
        best=max(best,r); bestF=max(bestF,F)
    print(f"n={n}: max lambda_max(N)/trN found {best:.4f} (1/4=0.25), max |N|_F^2 found {bestF:.3f} (4 at padded 4D)")
