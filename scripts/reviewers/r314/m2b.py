import sys,os; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L
from m2_b1 import c5_blowup, D_A
n=10
M,blk=c5_blowup(); W0=L.diag_op(n,M); W=W0/np.linalg.norm(W0)
th=float(np.sum(W*L.Q(n,W)))
proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]
Lm=L.LW_matrix_on_weyl(n,W,B)/th

def HA(A):
    D=D_A(n,A); H=D@W+W@D; return 0.5*(H+H.T)

# --- natural basis: E_ab+E_ba (a<b) and traceless diagonals
nat=[]
for a in range(n):
    for b in range(a+1,n):
        A=np.zeros((n,n)); A[a,b]=A[b,a]=1; nat.append(('off',a,b,A))
for a in range(n-1):
    A=np.zeros((n,n)); A[a,a]=1; A[n-1,n-1]=-1; nat.append(('diag',a,n-1,A))
fr=[]
for tag,a,b,A in nat:
    H=HA(A); Pw=proj(H); fr.append(np.linalg.norm(H-Pw)/np.linalg.norm(H))
fr=np.array(fr)
print(f'leak in the natural E_ab+E_ba / diag basis (54 dirs): min={fr.min():.4f} med={np.median(fr):.4f} max={fr.max():.4f}')
fro=np.array([np.linalg.norm(HA(A)-proj(HA(A)))/np.linalg.norm(HA(A)) for tag,a,b,A in nat if tag=='off'])
print(f'  off-diagonal A only (45): min={fro.min():.4f} med={np.median(fro):.4f} max={fro.max():.4f}')

# --- is the 10-dim zero block genuine kernel of L_e ?
sy=[]
for i in range(n):
    for j in range(i,n):
        A=np.zeros((n,n))
        if i==j: A[i,i]=1
        else: A[i,j]=A[j,i]=1/np.sqrt(2)
        sy.append(A)
Gs=np.array([a.reshape(-1) for a in sy]); I=np.eye(n).reshape(-1)/np.sqrt(n)
Gs=Gs-np.outer(Gs@I,I)
u,s,vt=np.linalg.svd(Gs,full_matrices=False)
S0=[vt[k].reshape(n,n) for k in range(int((s>1e-10).sum()))]
Vc=np.array([coords(proj(HA(A))) for A in S0])
u2,s2,vt2=np.linalg.svd(Vc,full_matrices=False); r=int((s2>1e-9*s2[0]).sum()); Vo=vt2[:r]
C=Vo@Lm@Vo.T; C=0.5*(C+C.T); ev,evec=np.linalg.eigh(C)
z=evec[:,np.abs(ev)<1e-9]
Z=(z.T@Vo)          # 10 x dim
print('zero-block: dim',Z.shape[0],' ||L_e z|| max =',np.linalg.norm(Lm@Z.T,axis=0).max())
kerL=int((np.abs(np.linalg.eigvalsh(Lm))<1e-9).sum())
print('dim ker(L_e) on Weyl_10 =',kerL)
# how much of the 2/3 and 0.820541 blocks are genuine eigenvectors?
for val in [0.412281,0.441754,0.6666667,0.820541]:
    sel=evec[:,np.abs(ev-val)<1e-5]
    if sel.shape[1]==0: continue
    Y=(sel.T@Vo)
    R=Lm@Y.T - val*Y.T
    print(f'  block {val}: dim {Y.shape[0]}  max ||(L_e-lam)v|| = {np.linalg.norm(R,axis=0).max():.6f}')

# --- torus invariants of Sym_0
inv=[]
for a in range(5):
    A=np.zeros((n,n)); A[2*a,2*a]=A[2*a+1,2*a+1]=1; inv.append(A)
Gi=np.array([a.reshape(-1) for a in inv]); Gi=Gi-np.outer(Gi@I,I)
ui,si,vti=np.linalg.svd(Gi,full_matrices=False)
T0=[vti[k].reshape(n,n) for k in range(int((si>1e-10).sum()))]
print('dim torus-invariant Sym_0 =',len(T0))
Vt=np.array([coords(proj(HA(A))) for A in T0])
ut,st,vtt=np.linalg.svd(Vt,full_matrices=False); rt=int((st>1e-9*st[0]).sum()); Vto=vtt[:rt]
Ct=Vto@Lm@Vto.T
print('  compression spectrum on torus-invariant image:',np.round(np.linalg.eigvalsh(0.5*(Ct+Ct.T)),6))
Rt=Lm@Vto.T-Vto.T@(0.5*(Ct+Ct.T))
print('  invariance residual there:',np.linalg.norm(Rt))
HI=HA(np.eye(n)); print('  A=I: H_I = 4W?',np.abs(HI-4*W).max(),' Rayleigh',float(coords(HI)@Lm@coords(HI)/(coords(HI)@coords(HI))))
