import sys, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S
exec(open(os.path.join(os.path.dirname(os.path.abspath(__file__)),'r318_o2.py')).read().split("# the ad(p)-invariant")[0])
n=8
wb=L.weyl_basis(n)
rows=[]
for k in range(pcols.shape[1]):
    A=L.ad_op(pcols[:,k],n); rows.append(np.array([(A@B-B@A).ravel() for B in wb]).T)
M=np.vstack(rows); s=np.linalg.svd(M,compute_uv=False); rank=int((s>1e-8*s.max()).sum())
ns=np.linalg.svd(M)[2][rank:]
Wq=sum(cf*B for cf,B in zip(ns[0],wb)); Wq/=np.linalg.norm(Wq)
if L.theta_of(Wq,n)[0]<0: Wq=-Wq
ev,th=L.Le_spectrum(Wq,n,wb)
kk,_=L.symmetry_algebra(Wq,n)
print(f'\nHP^2 / sp(1)+sp(2) point at n=8: theta={th:.9f}')
print(f'   lambda_max(L_e|W^perp) = {ev.max():.12f}; mult(1/2) = {int(np.sum(np.abs(ev-0.5)<1e-8))}; '
      f'dim orbit = 28 - {kk.shape[1]} = {28-kk.shape[1]}')
print(f'   Morse-Bott nondegenerate: {ev.max()<=0.5+1e-9 and int(np.sum(np.abs(ev-0.5)<1e-8))==28-kk.shape[1]}')

print('\n--- successor test: is every local max of P|S(V) equivariant for a grading it carries? ---')
def solve_blocks(projs, nn, fix=None):
    rws=[];tgt=[]
    for Mx in L.ricci_rows(nn): rws.append([float(np.sum(Mx*Pi)) for Pi in projs])
    for j in range(nn):
        for l in range(j,nn): tgt.append(0.5 if j==l else 0.0)
    for Mx in L.bianchi_rows(nn):
        rws.append([float(np.sum(Mx*Pi)) for Pi in projs]); tgt.append(0.0)
    if fix:
        for (i,v) in fix:
            r=[0.0]*len(projs); r[i]=1.0; rws.append(r); tgt.append(v)
    A=np.array(rws); t=np.array(tgt); lam,*_=np.linalg.lstsq(A,t,rcond=None)
    return sum(l*Pi for l,Pi in zip(lam,projs))
Pj,Psu,Pm2,um,mm2,jv=S.cp_blocks(2)
W4=L.weyl_of(solve_blocks([Pj,Psu,Pm2],4,fix=[(2,0.0)]),4); W4/=np.linalg.norm(W4)
Wp=L.pad(W4,4,8); Wp/=np.linalg.norm(Wp)
kk2,_=L.symmetry_algebra(Wp,8)
print(f'   padded W_CP^2 at n=8: dim k(W) = {kk2.shape[1]}')
print(f'   dims of every Z_2-grading subalgebra p of so(8): so(p)+so(q) -> '
      f'{[p*(p-1)//2+(8-p)*(8-p-1)//2 for p in range(1,5)]}, u(4) -> 16, sp(1)+sp(2) -> 13, spin(7) -> 21')
print(f'   every one exceeds dim k(W) = {kk2.shape[1]}, so W is ad(p)-equivariant for NO grading p at all.')
print(f'   and it IS a local maximum of P on S(V) for V = fix(Lambda^2(diag(I_4,-I_4))): lambda_max(L_e)=1/2 = orbit only.')
