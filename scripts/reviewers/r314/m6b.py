import sys,os,itertools; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3
from m4_slack import conj_lambda2
n=8
proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]
Pr=L.pairs(n)
W=np.load('scripts/reviewers/r305/out/r305_n8_seed9015.npy')
W,th,res=m3.polish(n,W)
lam,V=np.linalg.eigh(W)
ip=np.where(lam>1e-9)[0]
A=L.so_mats(n)
Xs=[np.einsum('a,aij->ij',V[:,i],A) for i in ip]
Cm=sum(X@X.T for X in Xs)
ev,U8=np.linalg.eigh(Cm)
print('eigs of sum XX^T:',np.round(ev,6))
U=U8[:,:3]                      # eigenvalue 2 -> the 3-dim invariant subspace
g=np.hstack([U8[:,:3],U8[:,3:]])
if np.linalg.det(g)<0: g[:,-1]*=-1
R=conj_lambda2(n,g.T)           # rotate so that U becomes span(e0,e1,e2)
Wr=R@W@R.T
print('after rotation: crit res',np.abs(L.Q(n,Wr)-th*Wr).max(),' theta',float(np.sum(Wr*L.Q(n,Wr))))
def blocks(U3):
    Uu=set(U3); b={'p1':[],'p2':[],'m':[]}
    for a,(i,j) in enumerate(Pr):
        if i in Uu and j in Uu: b['p1'].append(a)
        elif i not in Uu and j not in Uu: b['p2'].append(a)
        else: b['m'].append(a)
    return b
b=blocks((0,1,2)); p1,p2,mm=b['p1'],b['p2'],b['m']; pidx=p1+p2
print('coordinate 3+5 split cross-block ||W_[p,m]|| =',np.linalg.norm(Wr[np.ix_(pidx,mm)]))
Amat=Wr[np.ix_(pidx,pidx)]
print('||A||^2 = %.9f   sum_{lam>0} lam^2 = %.9f'%(float(np.sum(Amat*Amat)), float((lam[lam>0]**2).sum())))
print('block traces: so(3)=%.6f  so(5)=%.6f  CS floor=%.6f'%(np.trace(Wr[np.ix_(p1,p1)]),np.trace(Wr[np.ix_(p2,p2)]),
    np.trace(Wr[np.ix_(p1,p1)])**2/3+np.trace(Wr[np.ix_(p2,p2)])**2/10))
print('p-internal cross-block mass 2*||W_[p1,p2]||^2 =',2*float(np.sum(Wr[np.ix_(p1,p2)]**2)))
# eigenvector decomposition in this frame
M=L.LW_matrix_on_weyl(n,Wr,B)/th
Bf=B.reshape(dim,-1); wv=Bf@Wr.reshape(-1); wv/=np.linalg.norm(wv)
Pp=np.eye(dim)-np.outer(wv,wv)
evL,evec=np.linalg.eigh(Pp@M@Pp)
H=fromc(evec[:,-1]); H/=np.linalg.norm(H)
tot=float(np.sum(H*H))
print('lambda_max=%.9f mult=%d'%(evL[-1],int((np.abs(evL-evL[-1])<1e-8).sum())))
def sh(I,J,fac=1): return fac*float(np.sum(H[np.ix_(I,J)]**2))/tot
print('  m x m   : %.4f'%sh(mm,mm))
print('  so(5)   : %.4f'%sh(p2,p2))
print('  cross   : %.4f'%sh(p1,p2,2))
print('  so(3)   : %.4f'%sh(p1,p1))
print('  p x m   : %.4f'%sh(pidx,mm,2))
# cross-block test direction
Hc=np.zeros_like(Wr); Hc[np.ix_(p1,p2)]=Wr[np.ix_(p1,p2)]; Hc[np.ix_(p2,p1)]=Wr[np.ix_(p2,p1)]
nh=np.linalg.norm(Hc); Hp=proj(Hc)
cc=coords(Hp)
# remove W component
cc=cc-(cc@wv)*wv
print('cross-block test dir: ||H||=%.6f outside=%.4f  Rayleigh(after removing W)=%.6f'%(nh,np.linalg.norm(Hc-Hp)/nh,float(cc@M@cc/(cc@cc))))
