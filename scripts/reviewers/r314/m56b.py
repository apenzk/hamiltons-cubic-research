import sys,os,itertools; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3
from m1_gradings import ad_on_lambda2
n=8
proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]
c=L.struct(n)

def closure_defects(V,ip,im):
    p=V[:,ip]; m=V[:,im]
    Pp=p@p.T; Pm=m@m.T
    def br(X,Y):
        return np.einsum('abc,ai,bj->ijc',c,X,Y)   # [x_i,y_j] in coords
    dpp=br(p,p); dpm=br(p,m); dmm=br(m,m)
    f=lambda Z,Pr: float(np.sqrt((np.einsum('ijc,cd->ijd',Z,Pr)**2).sum()))
    return dict(pp_to_m=f(dpp,Pm), pm_to_p=f(dpm,Pp), mm_to_m=f(dmm,Pm),
                norms=(float(np.sqrt((dpp**2).sum())),float(np.sqrt((dpm**2).sum())),float(np.sqrt((dmm**2).sum()))))

def killing_split(V,ip):
    """split the subalgebra p = span(V[:,ip]) into Killing-form eigenspaces."""
    p=V[:,ip]; k=len(ip)
    ad=np.zeros((k,k,k))
    for i in range(k):
        X=np.einsum('a,ab->b',p[:,i],np.eye(p.shape[0]))
        pass
    # ad_p(x_i) on p: [x_i, x_j] projected to p
    br=np.einsum('abc,ai,bj->ijc',c,p,p)
    adm=np.einsum('ijc,ck->ijk',br,p)     # adm[i,j,k] = coefficient of x_k in [x_i,x_j]
    K=np.einsum('ijk,ikj->i... ',adm,adm) if False else None
    Kf=np.zeros((k,k))
    for i in range(k):
        for j in range(k):
            Kf[i,j]=float(np.einsum('ab,ba->',adm[i],adm[j]))
    w,U=np.linalg.eigh(Kf)
    return w,U,p

for f in ['r305_n8_seed9015','r305_n8_seed9018','r305_n8_seed9033']:
    W=np.load('scripts/reviewers/r305/out/%s.npy'%f)
    W,th,res=m3.polish(n,W)
    lam,V=np.linalg.eigh(W)
    ip=list(np.where(lam>1e-9)[0]); im=list(np.where(lam<-1e-9)[0])
    d=closure_defects(V,ip,im)
    print(f'=== {f}: theta={th:.9f} dim p={len(ip)} dim m={len(im)}')
    print('   spectral-split closure defects: ||Pi_m[p,p]||=%.3e  ||Pi_p[p,m]||=%.3e  ||Pi_m[m,m]||=%.3e   (bracket norms %.3f/%.3f/%.3f)'%(
        d['pp_to_m'],d['pm_to_p'],d['mm_to_m'],*d['norms']))
    w,U,pmat=killing_split(V,ip)
    print('   Killing spectrum of p:',np.round(np.unique(np.round(w,6)),4),'multiplicities',[int((np.abs(w-v)<1e-6).sum()) for v in np.unique(np.round(w,6))])
    # simple ideals: Killing eigenspaces
    vals=np.unique(np.round(w,6))
    ideals=[pmat@U[:,np.abs(w-v)<1e-6] for v in vals]
    print('   ideal dims',[i.shape[1] for i in ideals])
    # does p have an invariant 3-dim subspace in R^8 ?
    A=L.so_mats(n)
    Xs=[np.einsum('a,aij->ij',pmat[:,i],A) for i in range(pmat.shape[1])]
    # Casimir-ish: common invariant subspaces = eigenspaces of sum X X^T? use commutant
    Cm=sum(X@X.T for X in Xs)
    ev=np.linalg.eigvalsh(Cm)
    print('   p acting on R^8: eigs of sum(X X^T) =',np.round(ev,5))
    np.save('/tmp/r314_%s_spec.npy'%f,np.array([lam]))
    # M6 decomposition with the SPECTRAL grading
    M=L.LW_matrix_on_weyl(n,W,B)/th
    Bf=B.reshape(dim,-1); wv=Bf@W.reshape(-1); wv/=np.linalg.norm(wv)
    Pp=np.eye(dim)-np.outer(wv,wv)
    evL,evec=np.linalg.eigh(Pp@M@Pp)
    H=fromc(evec[:,-1]); H=H/np.linalg.norm(H)
    # change to the eigenbasis of W
    Hb=V.T@H@V
    small=ideals[np.argmin([i.shape[1] for i in ideals])]
    big=ideals[np.argmax([i.shape[1] for i in ideals])]
    # indices in the eigenbasis: p rows are ip, m rows are im; ideal coordinates
    Ps=V[:,ip]
    cs=Ps.T@small; cb=Ps.T@big     # coordinates of the ideals inside p
    Hpp=Hb[np.ix_(ip,ip)]; Hmm=Hb[np.ix_(im,im)]; Hpm=Hb[np.ix_(ip,im)]
    tot=float(np.sum(Hb*Hb))
    def blk(X,Y): return float(np.sum((X.T@Hpp@Y)**2))
    print('   lambda_max=%.9f mult=%d'%(evL[-1],int((np.abs(evL-evL[-1])<1e-8).sum())))
    print('     off p(+)m (p x m)  : %.4f%%   (abs mass %.6f)'%(200*float(np.sum(Hpm**2))/tot, 2*float(np.sum(Hpm**2))))
    print('     m x m              : %.2f%%'%(100*float(np.sum(Hmm**2))/tot))
    print('     big ideal (so5)    : %.2f%%'%(100*blk(cb,cb)/tot))
    print('     cross so3 x so5    : %.2f%%'%(200*blk(cs,cb)/tot))
    print('     small ideal (so3)  : %.2f%%'%(100*blk(cs,cs)/tot))
