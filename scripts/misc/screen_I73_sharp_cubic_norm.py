# I73: candidate (batch 30) -- the Holder bound for Hamilton's sharp form on Sym^2(so(n)):
#   F(X) = <X#X, X> <= ((n-2)/sqrt N) ||X||_F^3  for every symmetric X on so(n), n >= 9 (equality at X = I).
# It would give L257's quartic bound (X = Pi, pair with Pi#Pi) and the internal-mass cap (F(Pi) = M/2) at once.
# Screen (refutation instrument): shifted power ascent X <- normalise(X#X + alpha X) from random and structured starts,
# over ALL symmetric X and over PSD X (= Z Z^T). Ratio r = F(X) sqrt(N) / ((n-2) ||X||^3); r = 1 at I.
# Record normalisation: (X#X)_{cc'} = 1/2 sum f_abc f_a'b'c' X_aa' X_bb', f_abc = <[e_a,e_b],e_c>.
# Logs every start, appends to the log. Structured projectors are fixed points of the iteration.
# /usr/bin/python3 scripts/misc/screen_I73_sharp_cubic_norm.py <log> n1 n2 ...
import sys, time, itertools, os, numpy as np
log=open(sys.argv[1],'a'); ns=[int(x) for x in sys.argv[2:]]
def L(*a): print(time.strftime('%H:%M:%S'),*a,file=log,flush=True)
L('START pid',os.getpid(),f'plan: n in {ns}; per n: control, structured starts, 24 random general + 12 random PSD ascents')
for n in ns:
    prs=list(itertools.combinations(range(n),2)); N=len(prs)
    E=np.zeros((N,n,n))
    for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
    f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2
    T=np.transpose(f,(2,0,1))                      # T[c] = f[:,:,c]
    def sharp(X): U=np.matmul(np.matmul(X,T),X); return 0.5*T.reshape(N,-1)@U.reshape(N,-1).T
    def F(X): return np.sum(sharp(X)*X)
    def ratio(X): return F(X)*np.sqrt(N)/((n-2)*np.linalg.norm(X)**3)
    I=np.eye(N); L(f'n={n} N={N} control r(I)={ratio(I):.6f}  ||I#I-(n-2)I||={np.linalg.norm(sharp(I)-(n-2)*I):.2e}')
    rng=np.random.default_rng(n)
    def ascend(X,psd=False,its=600):
        X=X/np.linalg.norm(X); a=2.0*(n-2)
        for _ in range(its):
            if psd:
                Z=X                                   # X = Z Z^T, ascend in Z
                Y=Z@Z.T; G=sharp(Y)@Z; Z=Z+0.05*G/ (np.linalg.norm(G)+1e-12)*np.linalg.norm(Z); X=Z/np.sqrt(np.linalg.norm(Z@Z.T))
            else:
                S=sharp(X); X=S+a*X; X=(X+X.T)/2; X/=np.linalg.norm(X)
        return (X@X.T if psd else X)
    # structured starts
    def proj(vs): Q,_=np.linalg.qr(np.array(vs).T); return Q@Q.T
    idx={p:k for k,p in enumerate(prs)}
    def e(i,j): v=np.zeros(N); v[idx[(min(i,j),max(i,j))]]=1 if i<j else -1; return v
    lp=proj([e(0,1)+e(2,3),e(0,2)-e(1,3),e(0,3)+e(1,2)]) if n>=4 else None
    starts={'Lambda2+':lp} if n>=4 else {}
    for k in range(3,n+1): starts[f'so({k})']=proj([e(i,j) for i in range(k) for j in range(i+1,k)])
    for name,X in starts.items():
        L(f'  fixed point {name}: r={ratio(X):.4f} (a fixed point of the iteration, so ascending it tests nothing)')
    best=-9; bestX=None
    for t in range(24):
        X=rng.normal(size=(N,N)); X=(X+X.T)/2; X=ascend(X); r=ratio(X)
        L(f'    general start {t}: r={r:.6f}')
        if r>best: best=r; bestX=X
    ev=np.linalg.eigvalsh(bestX/np.linalg.norm(bestX))
    L(f'  general: best r={best:.6f}; eig(min,max)=({ev[0]:.3f},{ev[-1]:.3f}); dist to I/sqrtN={np.linalg.norm(bestX/np.linalg.norm(bestX)-I/np.sqrt(N)):.3e}')
    best=-9
    for t in range(12):
        k=rng.integers(1,N+1); Z=rng.normal(size=(N,k)); X=ascend(Z,psd=True); r=ratio(X); best=max(best,r)
        L(f'    PSD start {t} (rank {k}): r={r:.6f}')
    L(f'  PSD: best r={best:.6f}')
L('DONE')
