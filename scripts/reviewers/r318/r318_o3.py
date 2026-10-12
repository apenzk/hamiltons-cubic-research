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
R=solve_blocks([Pj,Psu,Pm],4,fix=[(2,0.0)])
W4=L.weyl_of(R,4); W4/=np.linalg.norm(W4)
print('unpadded W_CP^2 on n=4')
th,r=L.theta_of(W4,4)
print(f'   theta={th:.12f}  sqrt(3/2)={np.sqrt(1.5):.12f}  theta-sqrt(3/2)={th-np.sqrt(1.5):.2e}  crit resid={r:.2e}')
print(f'   spectrum {sorted(collections.Counter(np.round(np.linalg.eigvalsh(W4),9)).items())}')

for n in [4,8,10,12]:
    W = W4 if n==4 else L.pad(W4,4,n)
    W = W/np.linalg.norm(W)
    th,r=L.theta_of(W,n)
    rep=L.grading_report(W,n)
    kk,_=L.symmetry_algebra(W,n)
    dl=L.defect(W,n)
    print(f'\npadded W_CP^2 at n={n}:  N=dim so(n)={W.shape[0]}')
    print(f'   theta = {th:.12f}   theta - sqrt(3/2) = {th-np.sqrt(1.5):.3e}   ||Q(W)-theta W|| = {r:.2e}')
    print(f'   weyl residual {[f"{x:.1e}" for x in L.weyl_residual(W,n)]}')
    print(f'   dim E+ = {rep["dim_p"]}, dim E- = {rep["dim_m"]}, dim ker = {rep["dim_ker"]}')
    print(f'   S_mmm = {rep["S_mmm"]:.3e}   S_mpp = {rep["S_mpp"]:.3e}   Delta = {dl:.3e}')
    print(f'   SIGN-GRADED (A) = {rep["sign_graded"]}')
    print(f'   dim k(W) (symmetry algebra) = {kk.shape[1]}')
    if n>4:
        sig=np.diag([1.0]*4+[-1.0]*(n-4)); Ls=L.lam2(sig,n)
        print(f'   SLICE-GRADED (B): ||[Lambda^2(diag(I_4,-I_{n-4})), W]|| = {np.linalg.norm(Ls@W-W@Ls):.2e}')
        # (C): does k(W) contain a symmetric subalgebra of so(n)?
        dims={'so(p)+so(q)':[p*(p-1)//2+(n-p)*(n-p-1)//2 for p in range(1,n//2+1)]}
        if n%2==0: dims['u(n/2)']=[(n//2)**2]
        print(f'   (C) needs a symmetric subalgebra p subset k(W); dim k(W) = {kk.shape[1]}, '
              f'symmetric-subalgebra dims = {sorted(set(sum(dims.values(),[])))} -> (C) = False')
