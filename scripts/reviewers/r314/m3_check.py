import sys,os; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3
n=8
proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]
print('dim Weyl_8 =',dim)
files=['r305_n8_seed9018','r305_n8_seed9033','r305_n8_ratio_lt1','r305_n8_seed9015']
store={}
for f in files:
    W=np.load('scripts/reviewers/r305/out/%s.npy'%f)
    print('====',f)
    print('  sym err %.2e  ||W|| %.12f  weyl-proj err %.2e  Ric %.2e'%(
        np.abs(W-W.T).max(), np.linalg.norm(W), np.abs(proj(W)-W).max(), np.abs(m3.ric_of_op(n,W)).max()))
    th=float(np.sum(W*L.Q(n,W))); res=np.abs(L.Q(n,W)-th*W).max()
    print('  as loaded: theta=%.12f  crit_res=%.3e'%(th,res))
    Wp,thp,resp=m3.polish(n,W)
    ov=float(np.sum(W*Wp))
    print('  polished : theta=%.12f  crit_res=%.3e  <W,Wpol>=%.12f'%(thp,resp,ov))
    D,lam,g=m3.Delta(n,Wp)
    ev,M=m3.lam_max(n,Wp,thp,B)
    G=m3.ric_of_op(n,Wp@Wp); ge=np.linalg.eigvalsh(G)
    kern=int((np.abs(lam)<1e-9).sum())
    print('  Delta=%.9f  lambda_max(L_e|Wperp)=%.12f  ratio/theta=%.6f  margin/(1/2)=%.4f'%(D,ev[-1],ev[-1]/thp,ev[-1]/0.5))
    print('  dim ker W=%d   eigs of Ric(W^2): min=%.8f max=%.8f  (trace %.6f, n-dim support => min>0)'%(kern,ge.min(),ge.max(),ge.sum()))
    print('  mult(1/2) in L_e|Wperp:',int((np.abs(ev-0.5)<1e-7).sum()),' top eigs',np.round(ev[-4:],9))
    store[f]=(Wp,thp,D,ev[-1])
np.save('/tmp/r314_m3.npy',np.array([store[f][0] for f in files]))
