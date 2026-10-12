# I73, quartic bound, approach 1 probe (a screen): split Pi = (d/N) I + X into isotypic parts of Sym^2(Lambda^2)
# (trace, traceless Ricci, Weyl, Lambda^4) and measure ||Pi#Pi||^2 against its pieces, on so(k), Lambda^2_+, stars
# and random subspaces of so(n). Record normalisation; # via L244's formula. /usr/bin/python3 <log> n
import sys, itertools, numpy as np
log=open(sys.argv[1],'w'); n=int(sys.argv[2])
def P(*a): print(*a,file=log,flush=True)
prs=list(itertools.combinations(range(n),2)); N=len(prs); idx={p:k for k,p in enumerate(prs)}
E=np.zeros((N,n,n))
for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2
def sharp(X,Y):   # <(X#Y)z,z> = 1/2 sum X_ab Y_cd <[e_a,e_c],z><[e_b,e_d],z>, symmetrised
    S=0.5*np.einsum('ab,cd,acz,bdw->zw',X,Y,f,f); return 0.5*(S+S.T)
I=np.eye(N); P('control: I#I = (n-2) I ?', np.allclose(sharp(I,I),(n-2)*I))
def ric(X):   # Ricci contraction to an n x n matrix: sum_k X(e_i^e_k, e_j^e_k)
    R=np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            s=0
            for k in range(n):
                if k in (i,j): continue
                a=idx[tuple(sorted((i,k)))]; b=idx[tuple(sorted((j,k)))]
                sa=1 if i<k else -1; sb=1 if j<k else -1
                s+=sa*sb*X[a,b]
            R[i,j]=s
    return R
def report(name,V):
    Q,_=np.linalg.qr(np.array(V).T); Pi=Q@Q.T; d=Q.shape[1]
    B=sharp(Pi,Pi); nb=np.linalg.norm(B); target=(n-2)*d/np.sqrt(N)
    X=Pi-(d/N)*I; Rx=ric(X); r0=np.linalg.norm(Rx-np.trace(Rx)/n*np.eye(n))
    P(f'{name}: d={d} ||Pi#Pi||={nb:.4f} target={target:.4f} ratio={nb/target:.4f} ||X||^2={np.sum(X*X):.3f} |Ric0(X)|={r0:.3f} ||I#X||={np.linalg.norm(sharp(I,X)):.3f} ||X#X||={np.linalg.norm(sharp(X,X)):.3f}')
def vec(i,j): v=np.zeros(N); v[idx[(min(i,j),max(i,j))]]=1 if i<j else -1; return v
for k in [4,6,8]:
    report(f'so({k})',[vec(i,j) for i,j in itertools.combinations(range(k),2)])
report('Lambda2+',[ (vec(0,1)+vec(2,3))/np.sqrt(2),(vec(0,2)-vec(1,3))/np.sqrt(2),(vec(0,3)+vec(1,2))/np.sqrt(2)])
report('star d=8',[vec(0,j) for j in range(1,9)])
rng=np.random.default_rng(0)
for d in [6,16,26]:
    report(f'random d={d}',list(rng.normal(size=(d,N))))
P('DONE')
