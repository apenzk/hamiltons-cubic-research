import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lem70, math
D='scripts/data/'
files=['review_r40_W_cpm3.npy','review_r40_W_cpm4.npy','review_r40_W_cpm5.npy','w_n8_nondiagonal_witness.npy','frontier_n6_th1.224745_d20.111111.npy','frontier_n8_th1.224745_d20.111111.npy','frontier_n12_th1.224745_d20.111111.npy','frontier_n12_th1.236033_d20.000000.npy']
ctxs={}
for f in files:
    M=np.load(D+f); N=M.shape[0]; n=int(round((1+math.sqrt(1+8*N))/2))
    if n not in ctxs: ctxs[n]=core.Ctx(n)
    c=ctxs[n]; M=0.5*(M+M.T); M/=np.sqrt(np.trace(M@M))
    lem70.report(c,M,f.replace('.npy','')[:28],nv=8)
    lam=np.linalg.eigvalsh(M)
    print('   distinct eigs:',np.round(np.unique(np.round(lam,8)),6),' kernel dim:',int(np.sum(np.abs(lam)<1e-9)))
    print()
