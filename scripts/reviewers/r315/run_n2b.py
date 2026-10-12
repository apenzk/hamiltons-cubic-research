import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, core, geom
from run_n12 import sphere_product_W
LOG='agent_logs/r315-c3-reduction.log'
def log(s):
    open(LOG,'a').write(time.strftime('%H:%M:%S')+' [n2b] '+s+'\n')
n=12; alg=core.Alg(n); B=core.weyl_basis(n,verbose=False)
Bf=B.reshape(B.shape[0],alg.N*alg.N); D=B.shape[0]
for a in [6,5]:
    W=sphere_product_W(alg,a); th=core.frob(W,alg.Q(W))
    t=time.time(); Lm=np.zeros((D,D))
    for k in range(D):
        Lm[:,k]=Bf@alg.L(W,B[k]).ravel()
    Lm=0.5*(Lm+Lm.T)
    wv=Bf@W.ravel(); wv/=np.linalg.norm(wv)
    Pp=np.eye(D)-np.outer(wv,wv)
    ev,Vs=np.linalg.eigh(Pp@Lm@Pp); Le=np.sort(ev/th)
    idx=np.where(np.abs(ev/th-0.5)<1e-8)[0]
    cols=[]
    for c in range(alg.N):
        ad=alg.C[c].T; cols.append(Bf@(ad@W-W@ad).ravel())
    Mo=np.array(cols).T; U,s,_=np.linalg.svd(Mo,full_matrices=False); U=U[:,s>1e-9*max(1.,s[0])]
    Es=Vs[:,idx]
    r1=np.linalg.norm(U@(U.T@Es))/np.linalg.norm(Es); r2=np.linalg.norm(Es@(Es.T@U))/np.linalg.norm(U)
    log(f'n=12 S^{a}xS^{n-a} FULL SPACE: theta={th:.9f} lam_max(L_e)={Le[-1]:.9f} #(=1/2)={len(idx)} '
        f'#(>1/2)={int(np.sum(Le>0.5+1e-8))} orbit tgt dim={U.shape[1]} eig<=orb={r1:.12f} orb<=eig={r2:.12f} '
        f'next={Le[-len(idx)-1]:.9f} gap={0.5-Le[-len(idx)-1]:.9f} 1/(2(M-1))={1/(2*(max(a,n-a)-1)):.9f} [{time.time()-t:.0f}s]')
log('n2b DONE')
