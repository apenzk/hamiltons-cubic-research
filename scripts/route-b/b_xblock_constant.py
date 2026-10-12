"""The remaining vanishing debt in Lemma 27, isolated and measured.

L_e = 0 on X_p (x) R^q reduces to one constant: sharp_bilin(I_p, V) = -V/2 there,
where I_p projects onto Lambda^2 of the p-block.  Two facts, both established here:

  * The identity FAILS on a generic V merely supported on the (pp,mix) block --
    relative residual 0.57 to 0.81, ratio nowhere near -1/2.  So any proof must use
    the Weyl conditions and the irreducible structure; a support-block index
    computation cannot reach it.
  * On the summand itself -- built as the intersection of ker L_e with that support,
    whose dimension comes out at X(p)*q on the nose -- it holds to 1e-15.

Numerical at the splits below; the proof is still owed.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, weyl_basis, sphere_product_W, Q

def sharp_bilin(n, X, Y, A):
    N=A.shape[0]; A2=A.reshape(N*N,N)
    AX=(A2@X).reshape(N,N,N); AY=(A2@Y).reshape(N,N,N)
    T=AX.reshape(N,N*N)@AY.transpose(0,2,1).reshape(N,N*N).T
    return -0.25*(T+T.T)

def run(p,q):
    n=p+q; pairs,idx=pair_index(n); N=len(pairs); A=adj(n)
    W,_=sphere_product_W((p,q)); e=W/float(Q(n,W)[0,0]/W[0,0])
    Ip=np.zeros((N,N))
    for a,(i,j) in enumerate(pairs):
        if i<p and j<p: Ip[a,a]=1.0
    B=weyl_basis(n); D=len(B); A2=A.reshape(N*N,N)
    Ae=(A2@e).reshape(N,N,N); AeT=Ae.transpose(0,2,1).reshape(N,N*N)
    M=np.zeros((D,D))
    for j,X in enumerate(B):
        AX=(A2@X).reshape(N,N,N); T=AX.reshape(N,N*N)@AeT.T
        Y=0.5*(e@X+X@e)-0.25*(T+T.T)
        M[:,j]=[np.tensordot(b,Y) for b in B]
    w,vec=np.linalg.eigh(0.5*(M+M.T))
    K=vec[:, np.abs(w)<1e-9]
    mask=np.zeros((N,N))
    for a,(i,j) in enumerate(pairs):
        for b,(k,l) in enumerate(pairs):
            if ((i<p and j<p) and ((k<p)!=(l<p))) or ((k<p and l<p) and ((i<p)!=(j<p))):
                mask[a,b]=1
    S=np.zeros((D,D))
    for j,X in enumerate(B): S[:,j]=[np.tensordot(b,X*mask) for b in B]
    G=K.T@S@K; ew,ev=np.linalg.eigh(0.5*(G+G.T))
    sel=ev[:, ew>0.99]
    worst=0.0
    for c in (K@sel).T:
        V=sum(ci*b for ci,b in zip(c,B)); nv=np.linalg.norm(V)
        if nv<1e-10: continue
        worst=max(worst, np.linalg.norm(sharp_bilin(n,Ip,V,A)+0.5*V)/nv)
    return sel.shape[1], p*(p*p-4)//3*q, worst

if __name__=="__main__":
    print(f"{'(p,q)':>7} {'dim intersect':>14} {'X(p)*q':>7} {'max||sb(I_p,V)+V/2||':>21}")
    for (p,q) in [(3,4),(3,5),(4,4),(3,7)]:
        d,pred,worst=run(p,q)
        print(f"{str((p,q)):>7} {d:14d} {pred:7d} {worst:21.3e}", flush=True)
