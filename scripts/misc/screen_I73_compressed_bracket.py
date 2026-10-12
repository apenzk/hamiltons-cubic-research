# I73, D8's in-house question: over orthogonal p-dim subspaces E0, E2 of so(n) with EQUAL isotropy
# (sum_x x^T x over E0 = same over E2), how large is S = sum_{x,y in E0, z in E2} <[x,y],z>^2 ?
# The summed row (C) demand at theta0(n) is S >= p (theta0 sqrt(2p) + 1); a relaxation max below it would support
# closing by this route at that (n,p), a max above it shows the equal-isotropy bound alone cannot close.
# Record normalisation: e_i ^ e_j unit, <A,B> = tr(A^T B)/2. Projected gradient ascent on S - mu |A0 - A2|^2 with
# QR retraction, fixed iterations and restarts: a screen, bounded to minutes. /usr/bin/python3 <log>
import sys, time, itertools, numpy as np
log=open(sys.argv[1],'w')
def L(*a):
    print(time.strftime('%H:%M:%S'),*a,file=log,flush=True)
def setup(n):
    prs=list(itertools.combinations(range(n),2)); N=len(prs)
    E=np.zeros((N,n,n))
    for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
    f=np.einsum('aij,bjk,cik->abc',E,E,E)/2-np.einsum('bij,ajk,cik->abc',E,E,E)/2   # <[Ea,Eb],Ec> = tr([Ea,Eb]^T Ec)/2
    M=np.einsum('ajk,bjl->abkl',E,E)   # E_a^T E_b
    return N,f,M
def obj(X,Z,f,M,mu):
    FX=np.einsum('ijk,jb->ikb',f,X); T=np.einsum('ikb,ia,kc->abc',FX,X,Z); S=np.sum(T**2)
    A0=np.einsum('ij,ijkl->kl',X@X.T,M); A2=np.einsum('ij,ijkl->kl',Z@Z.T,M); Dm=A0-A2; Pen=np.sum(Dm**2)
    return S-mu*Pen,S,Pen,FX,T,Dm
def run(n,p,rng,stages=6,iters=250,restarts=3):
    N,f,M=setup(n); th0=np.sqrt(2*(n-1)*(n-2))/n; best=(-1,None)
    for r in range(restarts):
        Q,_=np.linalg.qr(rng.normal(size=(N,2*p))); X,Z=Q[:,:p],Q[:,p:]; mu=1.0
        for st in range(stages):
            lr=0.1
            for it in range(iters):
                J,S,Pen,FX,T,Dm=obj(X,Z,f,M,mu)
                gX=4*np.einsum('abc,ikb,kc->ia',T,FX,Z); gZ=2*np.einsum('abc,ikb,ia->kc',T,FX,X)
                D=2*np.einsum('kl,ijkl->ij',Dm,M); gX-=mu*(D+D.T)@X; gZ+=mu*(D+D.T)@Z
                while lr>1e-8:
                    Q,_=np.linalg.qr(np.hstack([X+lr*gX,Z+lr*gZ])); Xn,Zn=Q[:,:p],Q[:,p:]
                    if obj(Xn,Zn,f,M,mu)[0]>=J: X,Z=Xn,Zn; lr*=1.3; break
                    lr*=0.5
            mu*=10
        J,S,Pen,_,_,_=obj(X,Z,f,M,mu)
        if Pen<1e-5 and S>best[0]: best=(S,Pen)
        L(f'n={n} p={p} restart {r}: S={S:.4f} penalty={Pen:.2e}')
    dem=p*(th0*np.sqrt(2*p)+1)
    L(f'RESULT n={n} p={p} maxS={best[0]:.4f} demand={dem:.4f} ratio={best[0]/dem if best[0]>0 else float("nan"):.4f} p^1.5={p**1.5:.2f}')
    return best[0],dem
L('START pid',__import__('os').getpid(),'plan: default grid n=6,8; with a second argument n=10 p=5,11,17,22 and n=12 p=7,16,25,33, 2 restarts')
rng=np.random.default_rng(0)
grid={'small':[(6,range(2,8)),(8,range(3,14,2))],'big':[(10,[5,11,17,22]),(12,[7,16,25,33])],'window':[(12,[8,10,13])]}[sys.argv[2] if len(sys.argv)>2 else 'small']
for n,ps in grid:
    for p in ps: run(n,p,rng,restarts=3 if n<10 else (1 if len(sys.argv)>2 and sys.argv[2]=='window' else 2))
L('DONE')
