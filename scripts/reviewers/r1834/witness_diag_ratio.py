"""r1834 screen: at the pi/4 matching-rotated balanced product, the diagonal part A (beta on matching pairs, (alpha+beta)/2 elsewhere), its Weylness, and P(A)/|A|^3 against theta_0 = P(e) and sqrt(3/2). Q normalised as in scripts/misc/check_I121_rotated_product.py. Run: sage -python witness_diag_ratio.py 4 5 6. Seconds."""
import numpy as np, itertools, sys
def run(m):
    n=2*m; pairs=list(itertools.combinations(range(n),2)); idx={pr:i for i,pr in enumerate(pairs)}; N=len(pairs)
    def mat(a,b):
        M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
    basis=[mat(a,b) for (a,b) in pairs]
    C=np.zeros((N,N,N))
    for i in range(N):
        for j in range(N):
            br=basis[i]@basis[j]-basis[j]@basis[i]
            for k in range(N): C[i,j,k]=np.sum(br*basis[k])
    def sharp(X,Y): return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y,optimize=True)
    I=np.eye(N); scale=(n-2)/sharp(I,I)[0,0]
    def P(X): return np.sum((X@X+scale*sharp(X,X))*X)
    NN=(n-1)*(n-2); al=m*(m-1)/NN; be=-(m-1)**2/NN
    E=np.diag([al if (a<m)==(b<m) else be for (a,b) in pairs])
    print("brief alpha,beta norm^2",np.sum(E**2),"formula",m*m*(m-1)/(4*(2*m-1)))
    e=E/np.linalg.norm(E); th0=P(e)
    # witness diagonal: matching pairs (k, m+k)
    A=np.diag([be if b==a+m else (al+be)/2 for (a,b) in pairs])
    ric=[sum(A[idx[tuple(sorted((a,c)))],idx[tuple(sorted((a,c)))]] for c in range(n) if c!=a) for a in range(n)]
    t2=np.sum(A**2)/np.sum(E**2)
    a=A/np.linalg.norm(A)
    print(f"n={n} theta0={th0:.6f} sqrt(3/2)={np.sqrt(1.5):.6f} t^2={t2:.6f} (1/n={1/n:.6f}) max|Ric(A)|={max(map(abs,ric)):.1e} P(A)/|A|^3={P(a):.6f}")
for s in sys.argv[1:]: run(int(s))
