# I117 / statement H, batch 33: (a) the SVD bound F(X) <= (F(|X|) + F(|X^T|))/2 for every X in End(so(n)),
# F(X) = 1/2 sum f_abc f_a'b'c' X_aa' X_bb' X_cc'; (b) Newton on C#C = C from random positive-definite starts,
# reporting every converged idempotent's support rank, positivity and norm against N/(n-2)^2 (does any positive
# definite idempotent other than I/(n-2) exist?).  A screen.  /usr/bin/python3 <log> n1 n2 ...
import sys, itertools, time, numpy as np
log=open(sys.argv[1],'a'); ns=[int(x) for x in sys.argv[2:]]
def L(*a): print(time.strftime('%H:%M:%S'),*a,file=log,flush=True)
for n in ns:
    prs=list(itertools.combinations(range(n),2)); N=len(prs)
    E=np.zeros((N,n,n))
    for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
    f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2
    T=np.transpose(f,(2,0,1)); Tf=T.reshape(N,-1)
    def Fext(X): return 0.5*np.einsum('abc,ABC,aA,bB,cC->',f,f,X,X,X,optimize=True)
    def sharp(X,Y): return 0.25*(Tf@np.matmul(np.matmul(X,T),Y).reshape(N,-1).T+Tf@np.matmul(np.matmul(Y,T),X).reshape(N,-1).T)
    rng=np.random.default_rng(n); worst=-np.inf
    for t in range(200):
        X=rng.normal(size=(N,N))
        U,s,Vt=np.linalg.svd(X); A=U@np.diag(s)@U.T; B=Vt.T@np.diag(s)@Vt
        worst=max(worst,Fext(X)-(Fext(A)+Fext(B))/2)
    L(f'n={n}: (a) max over 200 random X of F(X)-(F(|X^T|)+F(|X|))/2 = {worst:.3e}  (<=0 expected)')
    # (b) Newton on G(C)=C#C-C, symmetric C, basis of Sym
    iu=np.triu_indices(N); D=len(iu[0])
    def vec(C): return C[iu]*np.where(iu[0]==iu[1],1,np.sqrt(2))
    def mat(v):
        C=np.zeros((N,N)); C[iu]=v/np.where(iu[0]==iu[1],1,np.sqrt(2)); return C+C.T-np.diag(np.diag(C))
    basis=[mat(e) for e in np.eye(D)]
    found=[]
    for t in range(12):
        Q=rng.normal(size=(N,N)); C=Q@Q.T; C=C/np.trace(C)*N/(n-2)*rng.uniform(0.3,1.5)
        for it in range(60):
            G=sharp(C,C)-C
            if np.linalg.norm(G)<1e-11: break
            J=np.array([vec(2*sharp(C,Bk)-Bk) for Bk in basis]).T
            C=C-mat(np.linalg.lstsq(J,vec(G),rcond=None)[0])
        ev=np.linalg.eigvalsh(C); res=np.linalg.norm(sharp(C,C)-C)
        if res<1e-9:
            rank=int(np.sum(np.abs(ev)>1e-8)); psd=ev.min()>-1e-8
            found.append((round(float(np.sum(C*C)),6),rank,psd,round(float(ev.min()),4),round(float(ev.max()),4)))
    L(f'n={n}: (b) Newton from 12 positive-definite starts, converged idempotents (norm^2, rank, psd, min eig, max eig):')
    for x in sorted(set(found)): L(f'    {x}   target N/(n-2)^2 = {N/(n-2)**2:.6f}')
L('DONE')
