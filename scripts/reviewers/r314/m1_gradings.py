import sys,os,time,itertools; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L

def ad_on_lambda2(n,X):
    A=L.so_mats(n)
    C=np.einsum('ij,ajk->aik',X,A)-np.einsum('aij,jk->aik',A,X)
    return 0.5*np.einsum('aik,bik->ba',C,A)

def so_gens(n,idxs):
    idxs=list(idxs); g=[]
    for i,j in itertools.combinations(idxs,2):
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; g.append(X)
    return g

def u_gens(n):
    m=n//2; J=np.zeros((n,n))
    for a in range(m): J[2*a,2*a+1]=1; J[2*a+1,2*a]=-1
    B=L.so_mats(n); N=B.shape[0]
    M=(np.einsum('aij,jk->aik',B,J)-np.einsum('ij,ajk->aik',J,B)).reshape(N,-1)
    u,s,vt=np.linalg.svd(M@M.T)
    r=int((s>1e-9*s[0]).sum()); ns=vt[r:]
    return [ (c@B.reshape(N,-1)).reshape(n,n) for c in ns ]

def commutant_in_weyl(n,gens,B,nprobe=5,seed=3):
    dim,N,_=B.shape; Bf=B.reshape(dim,-1)
    rng=np.random.default_rng(seed)
    probes=[sum(c*X for c,X in zip(rng.normal(size=len(gens)),gens)) for _ in range(nprobe)]
    Phi=np.zeros((dim,dim))
    for X in probes:
        K=ad_on_lambda2(n,X)
        C1=np.matmul(K,B)-np.matmul(B,K)
        Phi += (C1.reshape(dim,-1)@C1.reshape(dim,-1).T)
    Phi=0.5*(Phi+Phi.T)
    w,V=np.linalg.eigh(Phi)
    tol=1e-8*max(1.0,w.max()); k=int((w<tol).sum())
    Vk=V[:,:k]
    # verify against ALL generators
    if k:
        cand=np.einsum('ij,jkl->ikl',Vk.T,B)
        worst=0.0
        for X in gens:
            K=ad_on_lambda2(n,X)
            worst=max(worst,np.abs(np.matmul(K,cand)-np.matmul(cand,K)).max())
    else: worst=0.0
    return Vk, worst

def crit_in_subspace(n,Vk,B,resid_full=True):
    k=Vk.shape[1]
    if k==0: return []
    bs=np.einsum('ij,jkl->ikl',Vk.T,B)     # already orthonormal (V orthonormal, B orthonormal)
    # structure tensor T[i,j,l] = <Q(b_i,b_j), b_l>, Q bilinear symmetric
    N=B.shape[1]
    T=np.zeros((k,k,k))
    for i in range(k):
        for j in range(i,k):
            Qij=0.5*(bs[i]@bs[j]+bs[j]@bs[i])+L.sharp(n,bs[i],bs[j])
            for l in range(k): T[i,j,l]=T[j,i,l]=np.sum(Qij*bs[l])
    out=[];seen=[]
    rng=np.random.default_rng(11)
    trials=[np.ones(k)]+[rng.normal(size=k) for _ in range(600)]
    for x0 in trials:
        x=x0/np.linalg.norm(x0)
        ok=True
        for it in range(500):
            q=np.einsum('ijl,i,j->l',T,x,x)
            nq=np.linalg.norm(q)
            if nq<1e-12: ok=False;break
            xn=q/nq
            if np.linalg.norm(xn-x)<1e-15: x=xn;break
            x=xn
        if not ok: continue
        th=float(np.einsum('ijl,i,j,l->',T,x,x,x))
        r=np.linalg.norm(np.einsum('ijl,i,j->l',T,x,x)-th*x)
        if r>1e-11: continue
        if any(abs(float(s@x))>1-1e-9 for s in seen): continue
        seen.append(x.copy())
        W=np.einsum('i,ikl->kl',x,bs)
        rf=np.abs(L.Q(n,W)-th*W).max()
        out.append((th,rf,W))
    return out

if __name__=='__main__':
    n=int(sys.argv[1]); t0=time.time()
    B=L.weyl_basis(n); print('n',n,'dimWeyl',B.shape[0],flush=True)
    cases=[]
    for k in range(1,n//2+1):
        cases.append((f'so({k})+so({n-k})', so_gens(n,range(k))+so_gens(n,range(k,n))))
    if n%2==0: cases.append((f'u({n//2})',u_gens(n)))
    for tag,gens in cases:
        Vk,worst=commutant_in_weyl(n,gens,B)
        pts=crit_in_subspace(n,Vk,B)
        s=' | '.join(f'th={t:.9f}(fullres {r:.1e})' for t,r,_ in sorted(pts,key=lambda z:-z[0]))
        print(f'{tag:22s} dim(equiv Weyl)={Vk.shape[1]:2d} commcheck={worst:.1e}  crit:{len(pts):2d}  {s}',flush=True)
    print('t',time.time()-t0)
