import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lem70, math, os
D='scripts/data/'
def load(f): return np.load(D+f)
for f in ['review_r40_W_cpm3.npy','review_r40_W_cpm4.npy','review_r40_W_cpm5.npy','w_n8_nondiagonal_witness.npy','gap_band_point_n8.npy','defect_violation_n8_0.120000.npy','defect_theta0_n8_0.125000.npy','frontier_n6_th1.224745_d20.111111.npy','frontier_n8_th1.224745_d20.111111.npy','review_r61_best_stratum_m6.npy']:
    M=load(f)
    N=M.shape[0]; n=int(round((1+math.sqrt(1+8*N))/2))
    if n*(n-1)//2!=N: print(f,'shape',M.shape,'not a Lambda^2 dim'); continue
    c=core.Ctx(n)
    M=0.5*(M+M.T); M=M/np.sqrt(np.trace(M@M))
    dw=np.linalg.norm(M-core.proj_weyl(c,M))
    th,res=core.crit_residual(c,M)
    print(f'{f:42s} n={n} distWeyl={dw:.2e} theta={th:.9f} res={res:.2e}')
