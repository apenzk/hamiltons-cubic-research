import sys, os, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S
np.random.seed(318)

n=8; m=4
Pj,Psu,Pm,um,mm,jv = S.cp_blocks(m)
J = S.Jmat(m)
AdJ = L.lam2(J,n)
print('Ad(J) is an involution of so(8):  ||Ad(J)^2 - I|| =', np.linalg.norm(AdJ@AdJ-np.eye(28)))
print('J is NOT an orthogonal involution:  ||J^2 - I|| =', np.linalg.norm(J@J-np.eye(n)), '   ||J^2 + I|| =', np.linalg.norm(J@J+np.eye(n)))

# the u(4)-graded Weyl subspace at n=8 = Weyl tensors commuting with Ad(J)
wb = L.weyl_basis(n)
rows = np.array([ (AdJ@B - B@AdJ).ravel() for B in wb ]).T
u,s,vt = np.linalg.svd(rows)
rank = int((s>1e-8*s.max()).sum())
ns = np.linalg.svd(rows)[2][rank:]
V = [sum(c*B for c,B in zip(r,wb)) for r in ns]
print(f'dim Weyl_8 = {len(wb)};  dim of the u(4)-graded Weyl subspace V = {len(V)}')

# W_CP^4 lives in V; perturb inside V, keeping E+ = u(4), E- = m
def solve_blocks(projs, nn, fix=None):
    rws=[];tgt=[]
    for M in L.ricci_rows(nn):
        rws.append([float(np.sum(M*Pi)) for Pi in projs])
    for j in range(nn):
        for l in range(j,nn): tgt.append(0.5 if j==l else 0.0)
    for M in L.bianchi_rows(nn):
        rws.append([float(np.sum(M*Pi)) for Pi in projs]); tgt.append(0.0)
    if fix:
        for (i,v) in fix:
            r=[0.0]*len(projs); r[i]=1.0; rws.append(r); tgt.append(v)
    A=np.array(rws); t=np.array(tgt)
    lam,*_=np.linalg.lstsq(A,t,rcond=None)
    return sum(l*Pi for l,Pi in zip(lam,projs))
R = solve_blocks([Pj,Psu,Pm], n, fix=[(2,0.0)])
W0 = L.weyl_of(R,n); W0/=np.linalg.norm(W0)

Pu = L.proj_from_cols(um); Pmm = L.proj_from_cols(mm)
best=None
for trial in range(400):
    eps = 0.14
    d = sum(np.random.randn()*B for B in V); d /= np.linalg.norm(d)
    W = W0 + eps*d; W/=np.linalg.norm(W)
    ev_p = np.linalg.eigvalsh(um.T@W@um)
    ev_m = np.linalg.eigvalsh(mm.T@W@mm)
    if ev_p.min() > 1e-3 and ev_m.max() < -1e-3:
        gap = min(np.diff(np.sort(ev_p)).min(), np.diff(np.sort(ev_m)).min())
        if best is None or gap > best[0]:
            best = (gap, W, ev_p, ev_m)
gap,W,ev_p,ev_m = best
print(f'\nperturbed W in V: min eigen-gap on u(4) block = {gap:.4f}')
print('  weyl residual', [f'{x:.1e}' for x in L.weyl_residual(W,n)])
rep = L.grading_report(W,n)
print(f'  dim E+={rep["dim_p"]} dim E-={rep["dim_m"]} ker={rep["dim_ker"]}  SIGN-GRADED (A) = {rep["sign_graded"]}')
print(f'  leaks pp->m {rep["pp_to_m"]:.2e}  pm->p {rep["pm_to_p"]:.2e}  mm->m {rep["mm_to_m"]:.2e}')
print(f'  Delta = {L.defect(W,n):.6f}   (0 would mean ad(p)-equivariant)')
kk,ss = L.symmetry_algebra(W,n)
print(f'  dim of symmetry algebra k(W) = {kk.shape[1]}')
np.save(os.path.join(os.path.dirname(os.path.abspath(__file__)),'W_A_not_B_n8.npy'), W)

# ---- exhaustive test: can any orthogonal involution sigma fix W? ----
# Ad(sigma) commutes with W, preserves E+=u(4), and (simple spectrum there) acts
# diagonally in the eigenbasis of W|u(4).  Its +1 eigenspace must be a subalgebra,
# with [E-,E-] in E+ and [E+,E-] in E-.  Enumerate all 2^16 sign patterns.
wv, Vp = np.linalg.eigh(um.T@W@um)
E = um @ Vp                      # 28 x 16 eigenbasis of W restricted to u(4)
c = L.C(n)
cc = np.einsum('abg,ai,bj,gk->ijk', c, E, E, E)     # structure constants in that basis
print(f'\n  |c| max in the u(4) eigenbasis = {np.abs(cc).max():.4f}')
good=[]
for mask in range(1<<16):
    eps = np.array([1.0 if (mask>>t)&1 else -1.0 for t in range(16)])
    # Ad(sigma) e_i = eps_i e_i must be an automorphism: eps_i eps_j c_ijk = eps_k c_ijk
    bad = np.abs(cc) > 1e-8
    sgn = np.einsum('i,j,k->ijk', eps, eps, eps)
    if np.all(sgn[bad] > 0):
        good.append(mask)
print(f'  sign patterns on the u(4) eigenbasis that are Lie automorphisms: {len(good)}')
for g in good:
    eps=[1 if (g>>t)&1 else -1 for t in range(16)]
    print('     pattern:', 'ALL +1 (identity)' if all(e==1 for e in eps) else eps)
