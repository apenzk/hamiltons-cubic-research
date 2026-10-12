"""R30: explicit D_4 triality via octonions; transport of graded critical points."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import *
from review_r30_spec import le_matrix, cluster
from review_r30_inv import invariant_weyl, gradedness
from review_r30_conj import isotropy_algebra, rep_commutant_dim, isotypic

# ---- octonions ----
triples=[(1,2,3),(1,4,5),(1,7,6),(2,4,6),(2,5,7),(3,4,7),(3,6,5)]
mul=np.zeros((8,8,8))
for i in range(8): mul[0,i,i]=1; mul[i,0,i]=1
for i in range(1,8): mul[i,i,0]=-1
for (a,b,c) in triples:
    for (x,y,z) in [(a,b,c),(b,c,a),(c,a,b)]:
        mul[x,y,z]=1.0; mul[y,x,z]=-1.0
def Rmat(k, conj=False):
    """right multiplication by e_k (or its conjugate) as an 8x8 matrix on R^8."""
    M=np.zeros((8,8))
    s=-1.0 if (conj and k>0) else 1.0
    for c in range(8):
        M[:,c]=s*mul[c,k,:]
    return M

R=[Rmat(k) for k in range(8)]
Rb=[Rmat(k,True) for k in range(8)]

def triality_matrix():
    """tau: so(8) -> so(8) induced by the half-spin rep S+ (octonion model)."""
    n=8; pairs,idx=pair_index(n)
    T=np.zeros((28,28))
    for a,(i,j) in enumerate(pairs):
        S = 0.5*(R[i]@Rb[j])              # = 1/2 gamma_i gamma_j on S+
        S = 0.5*(S-S.T)                   # enforce antisymmetry (should already hold)
        T[:,a]=np.array([S[k,l] for (k,l) in pairs])
    return T

def check_hom(T):
    n=8; c=structure_constants(8)
    # tau([a,b]) == [tau(a),tau(b)] : c_{abg} T_{g h} ?= sum c_{a'b'h} T_{a'a}T_{b'b}
    lhs=np.einsum('abg,hg->abh', c, T)
    rhs=np.einsum('xa,yb,xyh->abh', T, T, c)
    return np.abs(lhs-rhs).max(), np.abs(T@T.T-np.eye(28)).max()

if __name__=="__main__":
    T=triality_matrix()
    err,orth=check_hom(T)
    print(f"triality tau: Lie-hom error {err:.2e}   orthogonality error {orth:.2e}")
    ev=np.linalg.eigvals(T); 
    # order of tau
    P=np.eye(28); k=0
    for k in range(1,13):
        P=P@T
        if np.abs(P-np.eye(28)).max()<1e-8: break
    print(f"order of tau = {k}")
    # is tau inner? inner automorphisms are Ad(g), g in SO(8) -> they preserve
    # the vector representation, i.e. exist g with tau(phi_ij)= g phi g^T.
    print()
    print("=== transport of graded critical points by tau ===")
    from review_r30_inv import subalg_u
    pts=[]
    for blocks in [(1,7),(2,6),(3,5),(4,4)]:
        if blocks[0]>=2:
            W,_=sphere_product_W(blocks); pts.append((f"S^{blocks[0]}xS^{blocks[1]}", normalize(W)))
    n_,hb=subalg_u(4); d,b,_=invariant_weyl(8,hb); pts.append(("CP^4", normalize(b[0])))
    B=weyl_basis(8); Bf=B.reshape(B.shape[0],-1)
    for name,W in pts:
        th=float(np.tensordot(W,Q(8,W)))
        if th<0: W=-W; th=-th
        for power,lab in ((1,"tau"),(2,"tau^2")):
            M=np.linalg.matrix_power(T,power)
            Wt=M@W@M.T
            inW=np.linalg.norm(Wt.reshape(-1)-Bf.T@(Bf@Wt.reshape(-1)))
            tht=float(np.tensordot(Wt,Q(8,Wt)))
            res=np.linalg.norm(Q(8,Wt)-tht*Wt)
            hc,dim=isotropy_algebra(8,Wt)
            print(f"  {lab}({name}): stays in Weyl? {inW:.1e}  theta={tht:.9f} crit_resid={res:.1e} "
                  f"dim iso={dim} R^8 summands={isotypic(8,hc)} commutant={rep_commutant_dim(8,hc)}")
        hc,dim=isotropy_algebra(8,W)
        print(f"     original {name}: dim iso={dim} R^8 summands={isotypic(8,hc)} commutant={rep_commutant_dim(8,hc)}")
