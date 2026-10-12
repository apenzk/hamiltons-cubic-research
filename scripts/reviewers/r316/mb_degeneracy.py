"""Morse-Bott test at a critical point: multiplicity of the 1/2-eigenvalue of L_e|_{W-perp}
against the dimension of the O(n)-orbit tangent. Dense, on the ambient Sym(Lambda^2)."""
import sys, time; sys.path.insert(0,'scripts/reviewers/r316')
import numpy as np, core

def spectrum(alg, pr, W, dimWeyl):
    th=float(np.sum(pr.apply(alg.Q(W))*W))
    sh=core.Sharp(alg,W); N=alg.N
    SB=core.sym_basis(N)
    cols=[]
    for k in range(SB.shape[0]):
        H=pr.apply(SB[k]); H=H-np.sum(H*W)*W
        Y=pr.apply(sh.L(H)); Y=Y-np.sum(Y*W)*W
        cols.append(Y.reshape(-1))
    Mm=np.array(cols)                      # rows: T(e_k) in raw coords
    G=SB.reshape(SB.shape[0],-1)@Mm.T      # <e_i, T e_k>
    G=0.5*(G+G.T)
    w=np.sort(np.linalg.eigvalsh(G))[::-1]/th
    T=np.array([(alg.A[X]@W - W@alg.A[X]).reshape(-1) for X in range(N)])
    s=np.linalg.svd(T,compute_uv=False); orb=int(np.sum(s>1e-9*max(1,s.max())))
    return th, w, orb

def report(n, W, tag):
    alg=core.Alg(n); pr=core.ProjFast(alg)
    dimW=n*n*(n*n-1)//12 - n*(n+1)//2
    th,w,orb=spectrum(alg,pr,W,dimW)
    mult=int(np.sum(w>0.5-1e-7))
    above=int(np.sum(w>0.5+1e-7))
    nxt=w[mult] if mult<len(w) else None
    print(f"n={n} {tag}: theta={th:.9f} dimWeyl={dimW} orbit dim={orb} "
          f"mult(1/2)={mult} (#>1/2: {above}) next below={nxt:.9f} -> "
          f"{'MORSE-BOTT DEGENERATE, excess %d'%(mult-orb) if mult>orb else 'Morse-Bott nondegenerate'}",flush=True)
    return th,w,orb,mult

if __name__=='__main__':
    from padded_cp2 import cp2
    for n in [8,10,12]:
        alg=core.Alg(n)
        t=time.time(); report(n, cp2(alg), 'padded CP^2'); print('   %.0fs'%(time.time()-t),flush=True)
        if n>=10:
            report(n, core.sphere_product_weyl(alg,n//2), f'S^{n//2}xS^{n//2} (control)')
