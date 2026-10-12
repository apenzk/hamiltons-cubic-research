import sys,os,time; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L

def c5_blowup():
    n=10; blk=[i//2 for i in range(n)]
    adj={(a,(a+1)%5) for a in range(5)}|{((a+1)%5,a) for a in range(5)}
    M=np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            if i==j: continue
            a,b=blk[i],blk[j]
            M[i,j]= 4.0 if a==b else (-2.0 if (a,b) in adj else 1.0)
    return M,blk

def D_A(n,A):
    """derivation of symmetric A on Lambda^2, in E-basis"""
    Amats=L.so_mats(n)   # A_a matrices
    P=L.pairs(n); N=len(P)
    D=np.zeros((N,N))
    e=np.eye(n)
    for a,(i,j) in enumerate(P):
        # A e_i ^ e_j + e_i ^ A e_j
        v=np.zeros((n,n))
        v+=np.outer(A[:,i],e[:,j])-np.outer(e[:,j],A[:,i])
        v+=np.outer(e[:,i],A[:,j])-np.outer(A[:,j],e[:,i])
        D[:,a]=0.5*np.einsum('ik,bik->b',v,Amats)
    return D

if __name__=='__main__':
    n=10
    M,blk=c5_blowup()
    W0=L.diag_op(n,M); W=W0/np.linalg.norm(W0)
    th=float(np.sum(W*L.Q(n,W))); res=np.abs(L.Q(n,W)-th*W).max()
    proj,coords,fromc,B=L.weyl_proj_factory(n)
    print(f'C5 blow-up n=10: theta={th:.9f} crit_res={res:.2e} weyl_res={np.abs(proj(W)-W).max():.2e} rowsum={np.abs(M.sum(1)).max():.1e} kernel dim={int((np.abs(np.linalg.eigvalsh(W))<1e-10).sum())}')
    dim=B.shape[0]; Bf=B.reshape(dim,-1)
    Lm=L.LW_matrix_on_weyl(n,W,B)/th
    print('dimWeyl',dim,'L_e sym',np.abs(Lm-Lm.T).max())
    # orthonormal basis of Sym_0(R^n)
    sy=[]
    for i in range(n):
        for j in range(i,n):
            A=np.zeros((n,n))
            if i==j: A[i,i]=1
            else: A[i,j]=A[j,i]=1/np.sqrt(2)
            sy.append(A)
    # traceless part
    Gs=np.array([a.reshape(-1) for a in sy])
    I=np.eye(n).reshape(-1)/np.sqrt(n)
    Gs=Gs-np.outer(Gs@I,I)
    u,s,vt=np.linalg.svd(Gs,full_matrices=False)
    S0=[vt[k].reshape(n,n) for k in range(int((s>1e-10).sum()))]
    print('dim Sym_0 =',len(S0))
    # H_A and the leak
    Hs=[];frac=[];Hp=[]
    for A in S0:
        D=D_A(n,A)
        H=D@W+W@D
        H=0.5*(H+H.T)
        Pw=proj(H)
        nh=np.linalg.norm(H)
        frac.append(np.linalg.norm(H-Pw)/nh)
        Hs.append(H); Hp.append(Pw)
    frac=np.array(frac)
    print(f'(a) leak fraction over 54 orthonormal Sym_0 directions: min={frac.min():.4f} median={np.median(frac):.4f} max={frac.max():.4f}; all>0: {bool((frac>1e-12).all())}')
    # image subspace
    Vc=np.array([coords(h) for h in Hp])       # 54 x dim
    nr=np.linalg.norm(Vc,axis=1)
    print('  projected-image norms: #(<1e-10)=',int((nr<1e-10).sum()),' range', f'{nr[nr>1e-10].min():.4f}..{nr.max():.4f}')
    u2,s2,vt2=np.linalg.svd(Vc,full_matrices=False)
    r=int((s2>1e-9*s2[0]).sum())
    Vo=vt2[:r]      # orthonormal basis of image, in Weyl coords
    print('  dim of P_W(image) =',r)
    C=Vo@Lm@Vo.T; C=0.5*(C+C.T)
    ev=np.linalg.eigvalsh(C)
    uu,cc=np.unique(np.round(ev,6),return_counts=True)
    print('(b) compression spectrum on P_W(image):',list(zip(uu[::-1],cc[::-1])))
    # per-direction Rayleigh quotients
    rq=[]
    for h in Hp:
        c=coords(h); nn=c@c
        if nn<1e-20: rq.append(0.0); continue
        rq.append(float(c@Lm@c/nn))
    rq=np.array(rq)
    uu,cc=np.unique(np.round(np.sort(rq),6),return_counts=True)
    print('(b) per-direction Rayleigh quotients (this orthonormal Sym_0 basis):',list(zip(uu[::-1],cc[::-1])))
    # invariance residual
    Pv=Vo.T@Vo
    LV=Lm@Vo.T
    resid=np.linalg.norm(LV-Pv@LV)
    print(f'(c) L_e-invariance residual of the projected image: {resid:.4f}  (Frobenius, on orthonormal basis)')
    print(f'    per-direction max ||(1-P_V)L_e v|| = {np.linalg.norm(LV-Pv@LV,axis=0).max():.4f}')
    # full lambda_max
    w=coords(W); w/=np.linalg.norm(w)
    Pp=np.eye(dim)-np.outer(w,w)
    evf=np.linalg.eigvalsh(Pp@Lm@Pp)
    print('lambda_max(L_e|W^perp) full =',evf[-1])
    np.save('/tmp/r314_c5.npy',W)
