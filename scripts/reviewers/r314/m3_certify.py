import sys,os,glob; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3
from m4_slack import slacks
n=8
proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]
for f in sorted(glob.glob(os.path.join(os.path.dirname(os.path.abspath(__file__)),'out_n8_*.npy'))):
    W=np.load(f)
    x=coords(W); x/=np.linalg.norm(x)
    for it in range(50):
        Wc=fromc(x); Qm=L.Q(n,Wc); q=coords(Qm); th=float(x@q); F=q-th*x
        if np.linalg.norm(F)<1e-16: break
        M=L.LW_matrix_on_weyl(n,Wc,B)
        J=2*M-th*np.eye(dim)-3*np.outer(x,q)
        Jx=np.vstack([J,x[None,:]]); Fx=np.concatenate([F,[0.0]])
        u,s,vt=np.linalg.svd(Jx,full_matrices=False)
        si=np.where(s>1e-6*s[0],1.0/np.maximum(s,1e-300),0.0)
        x=x+(-(vt.T*si)@(u.T@Fx)); x/=np.linalg.norm(x)
    Wc=fromc(x); th=float(np.sum(Wc*L.Q(n,Wc))); res=np.abs(L.Q(n,Wc)-th*Wc).max()
    D,lam,g=m3.Delta(n,Wc); ev,M=m3.lam_max(n,Wc,th,B)
    G=m3.ric_of_op(n,Wc@Wc); ge=np.linalg.eigvalsh(G)
    s=slacks(n,Wc)
    print(os.path.basename(f))
    print('   theta=%.12f res=%.2e Delta=%.6f lam_max=%.12f margin=%.6f'%(th,res,D,ev[-1],ev[-1]/0.5))
    print('   weylproj=%.1e Ric=%.1e ||W||=%.12f  dim ker W=%d'%(np.abs(proj(Wc)-Wc).max(),np.abs(m3.ric_of_op(n,Wc)).max(),np.linalg.norm(Wc),int((np.abs(lam)<1e-9).sum())))
    print('   Ric(W^2) eigs=%s rank=%d'%(np.round(ge,8),int((ge>1e-9).sum())))
    print('   S_mmm=%.2e S_mpp=%.2e dim p=%d dim m=%d ; mult(1/2)=%d top5=%s'%(s['Smmm'],s['Smpp'],s['dimp'],s['dimm'],int((np.abs(ev-0.5)<1e-9).sum()),np.round(ev[-5:],9)))
    # overlap with the known points
    for g2 in ['r305_n8_seed9018','r305_n8_seed9033','r305_n8_seed9015','r305_n8_ratio_lt1']:
        W2=np.load('scripts/reviewers/r305/out/%s.npy'%g2)
        pass
