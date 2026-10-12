import numpy as np, itertools
n=5
# so(5) generators L_ij = E_ij - E_ji on R^5
gens=[]
for i,j in itertools.combinations(range(n),2):
    L=np.zeros((n,n)); L[i,j]=1; L[j,i]=-1; gens.append(L)
print("number of generators:", len(gens))
# (A) vector rep: C = -sum L^2
Cv = -sum(L@L for L in gens)
print("C on R^5 =", np.unique(np.round(Cv[np.eye(n)==1],12)), " | <lam,lam+2rho> for (1,0) =", 1*(1+3)+0)
# (B) Lambda^2 R^5, dim 10, rho2(X) = X (x) 1 + 1 (x) X restricted
pairs=list(itertools.combinations(range(n),2)); idx={p:k for k,p in enumerate(pairs)}
def lam2(X):
    M=np.zeros((10,10))
    for (a,b),k in idx.items():
        for c in range(n):
            for (p,q),l in idx.items():
                # <e_p^e_q , X.(e_a^e_b)> where X.(ea^eb)=Xea^eb + ea^Xeb
                pass
    # build directly
    M=np.zeros((10,10))
    for (a,b),k in idx.items():
        v=np.zeros((n,n))
        for c in range(n):
            v[c,b]+=X[c,a]; v[a,c]+=X[c,b]
        w=(v-v.T)/2*2  # antisym part, coefficient on e_a^e_b basis
        for (p,q),l in idx.items(): M[l,k]=w[p,q]
    return M
R2=[lam2(L) for L in gens]
C2=-sum(A@A for A in R2)
ev2=np.round(np.linalg.eigvalsh(C2),9)
print("C on Lambda^2 R^5:", np.unique(ev2), " | <lam,lam+2rho> for (1,1) =", 1*(1+3)+1*(1+1))
# (C) Sym^2(Lambda^2) = symmetric 10x10 matrices, dim 55, action X.M=[rho(X),M]
basis=[]
for a in range(10):
    for b in range(a,10):
        E=np.zeros((10,10)); E[a,b]=1; E[b,a]=1
        basis.append(E/np.sqrt(np.sum(E*E)))
B=np.array([e.ravel() for e in basis])           # 55 x 100, orthonormal
Binv=B.T  # since orthonormal rows, coords = B @ vec
def act(A):
    out=np.zeros((55,55))
    for k,e in enumerate(basis):
        out[:,k]=B@ (A@e - e@A).ravel()
    return out
Ops=[act(A) for A in R2]
print("skewness max |A+A^T| =", max(np.abs(O+O.T).max() for O in Ops))
C3=-sum(O@O for O in Ops)
ev3=np.round(np.linalg.eigvalsh(C3),8)
vals,cnts=np.unique(ev3,return_counts=True)
print("C on Sym^2(Lambda^2 R^5), dim 55:")
for v,c in zip(vals,cnts): print("   c = %8.4f   multiplicity %d" % (v,c))
print("predicted: (2,2)->16 dim35, (2,0)->10 dim14, (1,0)->4 dim5, ()->0 dim1")
# Killing-form normalised Casimir for comparison: kappa = (n-2)*tr = 3*tr = 6*B'
print("if the Killing form had been used instead, Weyl_5 would read 16/6 =", 16/6)
