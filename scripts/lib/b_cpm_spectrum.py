"""L_e spectrum at the CP^m critical point, via the u(m)-invariant Weyl line.

Companion to the sphere-product case: closing route B needs nondegeneracy at
EVERY graded critical point, and the classification leaves the two-block sphere
products (Lemma 27) together with the CP^m family, handled here.

Two traps worth stating.  u(m) inside so(2m) is NOT spanned by the elementary
E_ab - E_ba that happen to commute with J -- it must be solved for as
{ E antisymmetric : EJ = JE }, or the invariant space comes out m(m-1)-dimensional
instead of 1.  And the invariant generator is defined up to sign, so theta lands on
the negative branch half the time; e = W/theta is sign-invariant, so the spectrum is
unaffected, but theta must be flipped before it is quoted.

Measured: CP^m is Morse-Bott nondegenerate at m=3,4 (dim E(1/2) = orbit), with
lambda_max = 1/2 + 1/(2(m+1)) > 1/2, so it is not a maximiser.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, weyl_basis, Q

def um_basis(m):
    """Basis of u(m) inside so(2m), as { E antisymmetric : EJ = JE }."""
    n=2*m
    J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    idx=[(i,j) for i in range(n) for j in range(i+1,n)]
    Mt=[]
    for (i,j) in idx:
        E=np.zeros((n,n)); E[i,j]=1; E[j,i]=-1
        Mt.append((E@J-J@E).ravel())
    Mt=np.array(Mt).T
    _,s,vt=np.linalg.svd(Mt)
    out=[]
    for c in vt[int((s>1e-9).sum()):]:
        E=np.zeros((n,n))
        for co,(i,j) in zip(c,idx): E[i,j]+=co; E[j,i]-=co
        out.append(E)
    return out

def run(m):
    n=2*m; pairs,idx=pair_index(n); N=len(pairs)
    G=um_basis(m); B=weyl_basis(n); D=len(B)
    Bf=np.array([b.ravel() for b in B])
    S=np.zeros((len(G)*D,D))
    for t,E in enumerate(G):
        L=np.zeros((N,N))
        for b,(k,l) in enumerate(pairs):
            for a,(i,j) in enumerate(pairs):
                L[a,b]=(E[i,k]*(j==l))-(E[i,l]*(j==k))-(E[j,k]*(i==l))+(E[j,l]*(i==k))
        for c,X in enumerate(B): S[t*D:(t+1)*D,c]=Bf@(L@X+X@L.T).ravel()
    sv=np.linalg.svd(S,compute_uv=False)
    inv=int((sv<1e-8).sum())+max(0,D-len(sv))
    if inv!=1: return dict(m=m,n=n,inv=inv)
    _,V=np.linalg.eigh(S.T@S)
    W=sum(c*b for c,b in zip(V[:,0],B)); W/=np.linalg.norm(W)
    th=float(np.tensordot(W,Q(n,W)))
    if th<0: W=-W; th=-th                      # positive branch
    e=W/th
    A=adj(n); A2=A.reshape(N*N,N)
    Ae=(A2@e).reshape(N,N,N); AeT=Ae.transpose(0,2,1).reshape(N,N*N)
    M=np.zeros((D,D))
    for j,X in enumerate(B):
        AX=(A2@X).reshape(N,N,N); T=AX.reshape(N,N*N)@AeT.T
        M[:,j]=[np.tensordot(b,0.5*(e@X+X@e)-0.25*(T+T.T)) for b in B]
    w=np.linalg.eigvalsh(0.5*(M+M.T)); grp=[]
    for v in w:
        if grp and abs(v-grp[-1][0])<1e-8: grp[-1][1]+=1
        else: grp.append([v,1])
    return dict(m=m,n=n,inv=1,theta=th,resid=float(np.linalg.norm(Q(n,W)-th*W)),
                orbit=n*(n-1)//2-len(G),
                dimE=sum(c for v,c in grp if abs(v-.5)<1e-8),
                lmax=max(v for v,_ in grp if v<0.99), spec=grp)

if __name__=="__main__":
    for m in (3,4):
        t0=time.time(); r=run(m)
        print(f"m={r['m']} (n={r['n']}): theta={r['theta']:.9f} resid={r['resid']:.1e} "
              f"orbit={r['orbit']} dimE(1/2)={r['dimE']} lam_max={r['lmax']:.6f} "
              f"(1/2+1/(2(m+1))={0.5+1/(2*(m+1)):.6f})  [{time.time()-t0:.0f}s]", flush=True)
        print("   spec: "+", ".join(f"{v:+.6f}x{c}" for v,c in r['spec']), flush=True)
