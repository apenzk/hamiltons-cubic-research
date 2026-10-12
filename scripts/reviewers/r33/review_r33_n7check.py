import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r33_core as R
from review_r33_spec import weyl_basis

for (p,q) in [(2,2),(2,5),(3,3),(4,4),(3,6),(5,4)]:
    n=p+q; idx=R.pair_index(n); D=n*(n-1)//2
    E=np.zeros((D,D)); E[idx[(0,1)],idx[(p,p+1)]]=1; E[idx[(p,p+1)],idx[(0,1)]]=1
    B,_=weyl_basis(n); Bf=B.reshape(B.shape[0],-1); Pi=Bf.T@Bf
    X=(Pi@E.reshape(-1)).reshape(D,D)
    # Ricci and Bianchi of X, computed from the definitions
    Ric=np.zeros((n,n)); 
    for i in range(n):
        for k in range(n):
            Ric[i,k]=sum(R.Rget(X,idx,i,j,k,j) for j in range(n))
    bi=max(abs(R.Rget(X,idx,i,j,k,l)+R.Rget(X,idx,i,k,l,j)+R.Rget(X,idx,i,l,j,k))
           for (i,j,k,l) in itertools.combinations(range(n),4))
    # is E - X purely Lambda^4 (totally antisymmetric)?
    Y=E-X
    tot=0.0
    for (i,j,k,l) in itertools.combinations(range(n),4):
        v=R.Rget(Y,idx,i,j,k,l)
        tot=max(tot, abs(R.Rget(Y,idx,i,k,l,j)-v), abs(R.Rget(Y,idx,i,l,j,k)-v))
    ent=sorted(round(X[a,b],10) for a in range(D) for b in range(a,D) if abs(X[a,b])>1e-12)
    print(f"({p},{q}) n={n}: ||E||^2={np.sum(E*E):.6f} ||X||^2={np.sum(X*X):.6f} ||E-X||^2={np.sum(Y*Y):.6f} "
          f"|Ric(X)|={np.max(np.abs(Ric)):.1e} |Bianchi(X)|={bi:.1e} (E-X) tot-antisym dev={tot:.1e} entries={ent}")
