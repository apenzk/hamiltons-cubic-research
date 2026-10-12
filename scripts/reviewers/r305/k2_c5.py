"""K2: the C_5-edge H_A family at the C_5 blow-up."""
import numpy as np, sys, itertools
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from scipy.optimize import least_squares

def blowup(graph_edges, sizes):
    """block-constant vertex matrix on blocks of given sizes; graph_edges = adjacency of blocks.
    Three orbit types -> solve criticality within the ansatz."""
    k=len(sizes); n=sum(sizes)
    off=np.cumsum([0]+list(sizes))
    types=np.zeros((n,n),int)   # 0 inside, 1 across-edge, 2 across-nonedge
    for b1 in range(k):
        for b2 in range(k):
            for i in range(off[b1],off[b1+1]):
                for j in range(off[b2],off[b2+1]):
                    if i==j: continue
                    if b1==b2: types[i,j]=0
                    elif (min(b1,b2),max(b1,b2)) in graph_edges: types[i,j]=1
                    else: types[i,j]=2
    def build(p):
        M=np.zeros((n,n))
        for t in range(3): M[types==t]=p[t]
        np.fill_diagonal(M,0)
        return M
    def res(p):
        M=build(p)
        Phi=M*M+M@M; Phi=Phi-np.diag(np.diag(Phi))
        th=np.sum(M*Phi)/np.sum(M*M) if np.sum(M*M)>1e-12 else 0
        r=(Phi-th*M)
        r=r-np.diag(np.diag(r))
        return np.array([r[types==t].sum() if (types==t).any() else 0.0 for t in range(3)]
                        +[np.abs(M.sum(1)).max()*10, np.sum(M*M)-2.0])
    best=None
    for s in range(80):
        rng=np.random.default_rng(s)
        sol=least_squares(res,rng.normal(size=3),xtol=1e-15,ftol=1e-15,gtol=1e-15)
        M=build(sol.x)
        if np.sum(M*M)<1e-6: continue
        M=M/np.linalg.norm(M)*np.sqrt(2)
        rr,th=crit_res(M)
        if rr<1e-12 and np.abs(M.sum(1)).max()<1e-12 and th>1e-6:
            if best is None or th>best[1]: best=(M,th)
    return best

C5=set([(0,1),(1,2),(2,3),(3,4),(0,4)])
M,th=blowup(C5,[2]*5)
n=10
print(f"C_5 blow-up n=10: theta={th:.9f} crit_res={crit_res(M)[0]:.1e} rowsum={np.abs(M.sum(1)).max():.1e}")
print("  distinct entries:", sorted(set(np.round(M[np.triu_indices(n,1)],9))))

idx,pos,N,c,B=weyl_basis(n)
W=diag_to_operator(M,pos)
coefW=np.array([inner(b,W) for b in B]); coefW/=np.linalg.norm(coefW)
thF=P(c,W)
print(f"  theta_full={thF:.9f}  ||Q-thW||={np.abs(Qmap(c,W)-thF*W).max():.1e}  weyl-dim={len(B)}")
Lm=L_operator(c,B,W)/thF
lmax,ev=lam_max_perp(Lm,coefW)
print(f"  lambda_max(L_e|e-perp) = {lmax:.9f}   Delta = {Delta(c,W):.6f}")

def D_A(A, idx):
    """derivation action of symmetric A on Lambda^2 in the phi_ij basis."""
    N=len(idx); D=np.zeros((N,N)); pos={p:k for k,p in enumerate(idx)}
    for b,(i,j) in enumerate(idx):
        # A e_i ^ e_j + e_i ^ A e_j
        for p in range(A.shape[0]):
            if p!=j and abs(A[p,i])>0:
                a,s=(pos[(p,j)],1.0) if p<j else (pos[(j,p)],-1.0)
                D[a,b]+=s*A[p,i]
            if p!=i and abs(A[p,j])>0:
                a,s=(pos[(i,p)],1.0) if i<p else (pos[(p,i)],-1.0)
                D[a,b]+=s*A[p,j]
    return D

# projector onto Weyl_n
Bmat=np.array([b.reshape(-1) for b in B])
def proj_weyl(X):
    co=Bmat@X.reshape(-1)
    return np.tensordot(co,B,axes=(0,0)), co

# the twenty C_5-edge generators
blocks=[[2*b,2*b+1] for b in range(5)]
gens=[]
for (b1,b2) in sorted(C5):
    for a in blocks[b1]:
        for bb in blocks[b2]:
            A=np.zeros((n,n)); A[a,bb]=1; A[bb,a]=1
            HA=D_A(A,idx)@W+W@D_A(A,idx)
            _,co=proj_weyl(HA)
            gens.append(co)
G=np.array(gens)
u,s,vt=np.linalg.svd(G)
r=(s>1e-9).sum()
print(f"\n  20 generators -> span dim {r};  overlap with W: max |<g,W>|/|g| = "
      f"{max(abs(g@coefW)/np.linalg.norm(g) for g in G):.2e}")
Vspan=vt[:r]                                   # orthonormal basis of the span
Ls=0.5*(Lm+Lm.T)
Cmp=Vspan@Ls@Vspan.T
print(f"  compression of L_e on the span: eigenvalues {np.round(np.linalg.eigvalsh(Cmp),12)[:6]} ... "
      f"max dev from 2/3 = {np.abs(Cmp-(2/3)*np.eye(r)).max():.2e}")
# residual operator
Rop=Ls@Vspan.T-Vspan.T*(2/3)          # columns: L_e v_i - (2/3) v_i
Gram=Rop.T@Rop
evg=np.linalg.eigvalsh(Gram)
print(f"  ||r||^2 over the span: eigenvalues of the Gram {np.round(evg,12)}")
print(f"  -> ||r|| constant? {np.allclose(evg,evg[0],atol=1e-10)};  sqrt = {np.sqrt(evg[0]):.9f}  vs 1/(3 sqrt2) = {1/(3*np.sqrt(2)):.9f}")
print(f"  1/18 = {1/18:.12f}")
# where does the residual live?
print(f"  is the family L_e-invariant? ||(I-P)L_e P|| = {np.linalg.norm((np.eye(len(B))-Vspan.T@Vspan)@Ls@Vspan.T):.6f}")
np.save('scripts/reviewers/r305/c5_M.npy',M)
