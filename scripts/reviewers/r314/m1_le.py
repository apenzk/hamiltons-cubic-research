import sys,os,time; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L
from m1_graded import sphere_product, theta_of
n=int(sys.argv[1]); p=int(sys.argv[2])
t0=time.time()
W=sphere_product(n,p); th,res,Wh=theta_of(n,W)
B=L.weyl_basis(n); dim=B.shape[0]; Bf=B.reshape(dim,-1)
print('dimWeyl',dim,'theta',th,'res',res,'t',time.time()-t0,flush=True)
M=L.LW_matrix_on_weyl(n,Wh,B)/th
print('built L_e',time.time()-t0,'sym err',np.abs(M-M.T).max(),flush=True)
w=Bf@Wh.reshape(-1); w/=np.linalg.norm(w)
print('L_e w - w:',np.abs(M@w-w).max())
Pp=np.eye(dim)-np.outer(w,w)
Mp=Pp@M@Pp
ev=np.linalg.eigvalsh(Mp)
print('top eigs',ev[-1:-12:-1])
tol=1e-8
mult=int(np.sum(np.abs(ev-0.5)<1e-7))
print('lambda_max(L_e|Wperp)=',ev[-1],' mult at 1/2 =',mult,' orbit dim pq =',p*(n-p))
# spectrum summary
u,cnt=np.unique(np.round(ev,7),return_counts=True)
print('distinct:',list(zip(u[::-1][:12],cnt[::-1][:12])))
print('t',time.time()-t0)
