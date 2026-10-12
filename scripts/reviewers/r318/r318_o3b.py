import sys, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S

def solve_blocks(projs, nn, fix=None):
    rws=[];tgt=[]
    for M in L.ricci_rows(nn): rws.append([float(np.sum(M*Pi)) for Pi in projs])
    for j in range(nn):
        for l in range(j,nn): tgt.append(0.5 if j==l else 0.0)
    for M in L.bianchi_rows(nn):
        rws.append([float(np.sum(M*Pi)) for Pi in projs]); tgt.append(0.0)
    if fix:
        for (i,v) in fix:
            r=[0.0]*len(projs); r[i]=1.0; rws.append(r); tgt.append(v)
    A=np.array(rws); t=np.array(tgt); lam,*_=np.linalg.lstsq(A,t,rcond=None)
    return sum(l*Pi for l,Pi in zip(lam,projs))
Pj,Psu,Pm,um,mm,jv=S.cp_blocks(2)
W4=L.weyl_of(solve_blocks([Pj,Psu,Pm],4,fix=[(2,0.0)]),4); W4/=np.linalg.norm(W4)

for n in [8,10]:
    wb=L.weyl_basis(n)
    W=L.pad(W4,4,n); W/=np.linalg.norm(W)
    ev,th=L.Le_spectrum(W,n,wb)
    kk,_=L.symmetry_algebra(W,n)
    orbit=n*(n-1)//2 - kk.shape[1]
    m12=int(np.sum(np.abs(ev-0.5)<1e-8))
    print(f'padded W_CP^2 at n={n}: theta={th:.12f}  lambda_max(L_e|W^perp)={ev.max():.12f}')
    print(f'   mult(1/2) = {m12}   dim(orbit) = dim so(n) - dim k(W) = {n*(n-1)//2} - {kk.shape[1]} = {orbit}')
    print(f'   top eigenvalues: {np.round(ev[-6:],9)}')
    print(f'   Morse-Bott nondegenerate local max: {ev.max()<=0.5+1e-9 and m12==orbit}')
    # (C) census at this n by spectrum: sphere products and CP^{n/2}
    print(f'   --- (C) class at n={n}: spectra of the pair-graded tensors ---')
    for p in range(2,n//2+1):
        Wp,_=S.sphere_prod_W(p,n-p); Wp/=np.linalg.norm(Wp)
        sp=sorted(collections.Counter(np.round(np.linalg.eigvalsh(Wp),6)).items())
        t2,_=L.theta_of(Wp,n)
        print(f'     S^{p}xS^{n-p}: theta={t2:.9f} spec={sp}')
    m2=n//2
    Pj2,Psu2,Pm2,um2,mm2,jv2=S.cp_blocks(m2)
    Wc=L.weyl_of(solve_blocks([Pj2,Psu2,Pm2],n,fix=[(2,0.0)]),n); Wc/=np.linalg.norm(Wc)
    t3,_=L.theta_of(Wc,n)
    print(f'     CP^{m2}: theta={t3:.9f} spec={sorted(collections.Counter(np.round(np.linalg.eigvalsh(Wc),6)).items())}')
    print(f'     padded W_CP^2: theta={th:.9f} spec={sorted(collections.Counter(np.round(np.linalg.eigvalsh(W),6)).items())}  -> matches none')
