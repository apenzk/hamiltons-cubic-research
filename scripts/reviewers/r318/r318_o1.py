import sys, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S

def solve_blocks(projs, n, fix=None, einstein=0.5):
    rows=[]; tgt=[]
    for M in L.ricci_rows(n):
        rows.append([float(np.sum(M*Pi)) for Pi in projs])
    for j in range(n):
        for l in range(j,n): tgt.append(einstein if j==l else 0.0)
    for M in L.bianchi_rows(n):
        rows.append([float(np.sum(M*Pi)) for Pi in projs]); tgt.append(0.0)
    if fix:
        for (i,v) in fix:
            r=[0.0]*len(projs); r[i]=1.0; rows.append(r); tgt.append(v)
    A=np.array(rows); t=np.array(tgt)
    lam,*_=np.linalg.lstsq(A,t,rcond=None)
    return sum(l*Pi for l,Pi in zip(lam,projs)), lam, float(np.linalg.norm(A@lam-t))

def W_cp(m):
    n=2*m; Pj,Psu,Pm,um,mm,jv=S.cp_blocks(m)
    R,lam,res=solve_blocks([Pj,Psu,Pm],n,fix=[(2,0.0)])
    W=L.weyl_of(R,n); return W/np.linalg.norm(W), n, (um,mm,jv,Pj,Psu,Pm)

def ad_commutant_in_weyl(pcols, n, wb):
    """dim of {W in Weyl_n : [ad x, W]=0 for all x in p}."""
    c=L.C(n); N=c.shape[0]
    rows=[]
    for k in range(pcols.shape[1]):
        A=L.ad_op(pcols[:,k], n)
        rows.append(np.array([ (A@B - B@A).ravel() for B in wb ]).T)
    M=np.vstack(rows)
    u,s,vt=np.linalg.svd(M, full_matrices=False)
    rank=int((s>1e-8*max(1.0,s.max())).sum())
    ns = np.linalg.svd(M)[2][rank:]
    return ns, s

print('='*78); print('O1a  (C) => (A):  is every ad(p)-invariant Weyl tensor of a symmetric pair sign-graded?')
for m in [2,3,4]:
    W,n,(um,mm,jv,Pj,Psu,Pm)=W_cp(m)
    rep=L.grading_report(W,n)
    th,r=L.theta_of(W,n)
    print(f'\n W_CP^{m}  (pair (so({n}), u({m})))   theta={th:.9f}  crit-resid={r:.1e}')
    print(f'   dim E+ ={rep["dim_p"]}, dim E- ={rep["dim_m"]}, dim ker ={rep["dim_ker"]}  (dim so({n})={rep["N"]}, dim u({m})={m*m})')
    print(f'   SIGN-GRADED (A): {rep["sign_graded"]}   Delta={L.defect(W,n):.6e}')
    # confirm it is (C): ad(u(m))-invariant and the commutant in Weyl_n is 1-dim
    wb=L.weyl_basis(n)
    ns,s=ad_commutant_in_weyl(um,n,wb)
    comm=[sum(co*B for co,B in zip(row,wb)) for row in ns]
    inv=max(np.linalg.norm(L.ad_op(um[:,k],n)@W - W@L.ad_op(um[:,k],n)) for k in range(um.shape[1]))
    print(f'   dim Weyl_{n} = {len(wb)};  dim of ad(u({m}))-commutant inside Weyl_{n} = {len(comm)}')
    print(f'   max ||[ad x, W]|| over x in u({m}) = {inv:.2e}   => W IS the pair-graded (C) tensor')
