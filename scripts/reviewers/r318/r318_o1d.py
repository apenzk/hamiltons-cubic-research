import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S
np.random.seed(31801)
n=8; m=4
Pj,Psu,Pm,um,mm,jv=S.cp_blocks(m)
J=S.Jmat(m); AdJ=L.lam2(J,n)
wb=L.weyl_basis(n)
rows=np.array([(AdJ@B-B@AdJ).ravel() for B in wb]).T
s=np.linalg.svd(rows, compute_uv=False); rank=int((s>1e-8*s.max()).sum())
ns=np.linalg.svd(rows)[2][rank:]
V=[sum(c*B for c,B in zip(r,wb)) for r in ns]

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
R=solve_blocks([Pj,Psu,Pm],n,fix=[(2,0.0)]); W0=L.weyl_of(R,n); W0/=np.linalg.norm(W0)

best=None
for trial in range(4000):
    eps=np.random.uniform(0.10,0.25)
    d=sum(np.random.randn()*B for B in V); d/=np.linalg.norm(d)
    W=W0+eps*d; W/=np.linalg.norm(W)
    ep=np.linalg.eigvalsh(um.T@W@um); em=np.linalg.eigvalsh(mm.T@W@mm)
    if ep.min()>2e-3 and em.max()<-2e-3:
        gap=np.diff(np.sort(ep)).min()
        if best is None or gap>best[0]: best=(gap,W,ep,em)
gap,W,ep,em=best
np.save(os.path.join(os.path.dirname(os.path.abspath(__file__)),'W_A_not_B_n8.npy'),W)
rep=L.grading_report(W,n)
print(f'WITNESS  n=8, u(4)-graded Weyl tensor, ||W||=1')
print(f'  weyl residual (bianchi,ricci,trace) = {[f"{x:.1e}" for x in L.weyl_residual(W,n)]}')
print(f'  dim E+ = {rep["dim_p"]} (=dim u(4)=16), dim E- = {rep["dim_m"]}, dim ker = {rep["dim_ker"]}')
print(f'  bracket leaks:  [p,p]->m {rep["pp_to_m"]:.2e}   [p,m]->p {rep["pm_to_p"]:.2e}   [m,m]->m {rep["mm_to_m"]:.2e}')
print(f'  SIGN-GRADED (A) = {rep["sign_graded"]};  Delta = {L.defect(W,n):.6f};  dim k(W) = {L.symmetry_algebra(W,n)[0].shape[1]}')
print(f'  spectrum on u(4): {np.round(np.sort(ep),6)}')
print(f'  min gap within u(4) spectrum = {gap:.6f}')
print(f'  spectrum on m   : {np.round(np.sort(em),6)}')
th,r=L.theta_of(W,n); print(f'  theta = {th:.9f}, criticality residual = {r:.3f}  (this is a Weyl tensor, not a critical point)')

E=um@np.linalg.eigh(um.T@W@um)[1]
c=L.C(n); cc=np.einsum('abg,ai,bj,gk->ijk',c,E,E,E)
a=np.abs(cc).ravel(); a=np.sort(a)
print(f'\n  structure constants in that eigenbasis: max {a[-1]:.4f};  '
      f'largest below 1e-3: {a[a<1e-3][-1]:.2e};  count > 1e-3: {(a>1e-3).sum()}')
for tol in [1e-3,1e-5,1e-8,1e-10]:
    bad=np.abs(cc)>tol; good=0; witness=None
    for mask in range(1<<16):
        eps=np.array([1.0 if (mask>>t)&1 else -1.0 for t in range(16)])
        sgn=np.einsum('i,j,k->ijk',eps,eps,eps)
        if np.all(sgn[bad]>0):
            good+=1
            if mask!=(1<<16)-1: witness=mask
    print(f'  tol {tol:.0e}: sign patterns that are Lie automorphisms of u(4) = {good}  (nontrivial: {witness})')
