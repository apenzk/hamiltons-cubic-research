"""r271: where the Cauchy-Schwarz bound's factor ~240 actually goes.
max <M#,M> over ||M||_F=1 in three nested spaces at n=12:  all of S^2(so(n)) > S^2_B > Weyl.
Projected gradient ascent, grad = 3 M# (cubic form)."""
import numpy as np, sys
sys.path.insert(0, "scripts/lib")
from weyl import build_structure_constants, bianchi_constraint_matrix, vec_to_mat, mat_to_vec, R_val
from rsharp_basis_free import Rsharp_full

def spaces(n):
    idx,pos,N,c = build_structure_constants(n)
    Bmat,triu,tp = bianchi_constraint_matrix(idx,pos,n,N)
    U,S,Vt=np.linalg.svd(Bmat); r=int(np.sum(S>1e-9*S[0]))
    nb=Vt[r:,:].T; D=nb.shape[1]
    Rd=[vec_to_mat(nb[:,d],triu,N) for d in range(D)]
    rows=[]
    for i in range(n):
        for k in range(i,n):
            row=np.zeros(D)
            for j in range(n):
                if j==i or j==k: continue
                for d in range(D): row[d]+=R_val(Rd[d],pos,n,i,j,k,j)
            rows.append(row)
    Ur,Sr,Vtr=np.linalg.svd(np.array(rows)); rr=int(np.sum(Sr>1e-9*Sr[0]))
    wb = nb@Vtr[rr:,:].T
    return idx,pos,N,c,triu,nb,wb

def ascend(N,c,proj,rng,iters=3000):
    best=-1e18; bestM=None
    for s in range(6):
        X=rng.standard_normal((N,N)); M=proj((X+X.T)/2); M/=np.linalg.norm(M)
        step=0.4
        for it in range(iters):
            G=3*Rsharp_full(M,c); G=proj(G); G-=np.tensordot(G,M)*M
            Mn=M+step*G; Mn=proj(Mn); Mn/=np.linalg.norm(Mn)
            if np.tensordot(Rsharp_full(Mn,c),Mn) >= np.tensordot(Rsharp_full(M,c),M):
                M=Mn; step*=1.05
            else: step*=0.5
            if step<1e-12: break
        v=float(np.tensordot(Rsharp_full(M,c),M))
        if v>best: best,bestM=v,M
    return best,bestM

n=12
idx,pos,N,c,triu,nb,wb = spaces(n)
def mk(basis):
    P = basis@basis.T   # projector in the triu coordinate system -- careful: not Frobenius-orthonormal
    def proj(X):
        v = mat_to_vec(X,triu)
        # weight: Frobenius pairing <X,E_ab-sym> ; use least squares onto span(basis) w.r.t Frobenius
        return vec_to_mat(basis@np.linalg.lstsq(basis,v,rcond=None)[0],triu,N)
    return proj
projall = lambda X: (X+X.T)/2
rng=np.random.default_rng(271)
th0=np.sqrt(2*(n-1)*(n-2))/n
res={}
for name,proj in (("all S^2(so(n))",projall),("S^2_B (Bianchi)",mk(nb)),("Weyl",mk(wb))):
    v,M=ascend(N,c,proj,rng)
    res[name]=v
    print(f"  max <M#,M>, ||M||_F=1, {name:16s} = {v:9.5f}")
print(f"\n  theta_0(12) = {th0:.6f}   ;  <M#,M> at S^6xS^6 = 1.213560")
print(f"  file's Cauchy-Schwarz bound at the maximiser = 293.68")
print(f"  CS bound / (max over ALL of S^2) = {293.68/res['all S^2(so(n))']:.1f}x   <-- cost of Cauchy-Schwarz alone")
print(f"  (max all) / (max Weyl)           = {res['all S^2(so(n))']/res['Weyl']:.2f}x   <-- cost of discarding Bianchi+trace-free")
