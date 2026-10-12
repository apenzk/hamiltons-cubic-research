"""R30: targeted large-n test of the dangerous eigenvalue family without building all of Weyl_n.
Pi_Weyl(phi_a (.) phi_b) for a a 2-plane inside block P and b inside block Q is Ricci-flat
already, so the Weyl projection is just X - Alt(X)."""
import numpy as np, sys, itertools, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, sphere_product_W, normalize, Q

def alt_project(n, X):
    """Lambda^4 component of a symmetric operator on Lambda^2 (in phi coords)."""
    pairs, idx = pair_index(n); N=len(pairs)
    def R(i,j,k,l):
        if i==j or k==l: return 0.0
        s=1.0
        if i>j: i,j=j,i; s=-s
        if k>l: k,l=l,k; s=-s
        return s*X[idx[(i,j)],idx[(k,l)]]
    A=np.zeros((N,N))
    for a,(i,j) in enumerate(pairs):
        for b,(k,l) in enumerate(pairs):
            if len({i,j,k,l})<4: continue
            A[a,b]=(R(i,j,k,l)+R(i,k,l,j)+R(i,l,j,k))/3.0
    return A

def le_apply(n, e, X, A2, AeT, N):
    AX=(A2@X).reshape(N,N,N)
    T=AX.reshape(N,N*N)@AeT.T
    return 0.5*(e@X+X@e)-0.25*(T+T.T)

def test(p,q):
    n=p+q; pairs,idx=pair_index(n); N=len(pairs)
    W,lab=sphere_product_W((p,q)); W=normalize(W)
    th=float(np.tensordot(W,Q(n,W))); e=W/th
    A=adj(n); A2=A.reshape(N*N,N)
    Ae=(A2@e).reshape(N,N,N); AeT=Ae.transpose(0,2,1).reshape(N,N*N)
    # candidate family vector
    a=idx[(0,1)]; b=idx[(p,p+1)]
    X=np.zeros((N,N)); X[a,b]=X[b,a]=1/np.sqrt(2)
    Xw=X-alt_project(n,X)
    Xw/=np.linalg.norm(Xw)
    Y=le_apply(n,e,Xw,A2,AeT,N)
    lam=float(np.tensordot(Xw,Y))
    resid=np.linalg.norm(Y-lam*Xw)
    pred=(n-2)/(2*(p-1)*(q-1))
    # also the orbit direction check: [A_a,W] for a mixed should be a 1/2 eigenvector
    amix=idx[(0,p)]
    T0=A[amix]@W-W@A[amix]; T0/=np.linalg.norm(T0)
    Y0=le_apply(n,e,T0,A2,AeT,N)
    lam0=float(np.tensordot(T0,Y0)); res0=np.linalg.norm(Y0-lam0*T0)
    # and one intra-block direction for the (q-2)/(2(q-1)) family:
    print(f"  ({p},{q}) n={n}: family eig = {lam:.12f}  eigresid={resid:.1e}  predicted {pred:.12f}  "
          f"diff={abs(lam-pred):.1e}   [>=1/2? {lam>=0.5-1e-12}]   orbit eig={lam0:.12f} (res {res0:.1e})")
    return lam,pred

if __name__=="__main__":
    print("dangerous family v(p,q) = (n-2)/(2(p-1)(q-1)), multiplicity C(p,2)C(q,2)")
    for n in (8,10,12,14,16,18,20,24,30):
        for p in range(2, n//2+1):
            q=n-p
            if p<2 or q<2: continue
            if p>4 and p!=n//2: continue
            test(p,q)
        print()
