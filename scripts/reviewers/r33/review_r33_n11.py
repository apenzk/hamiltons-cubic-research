import sys, itertools, numpy as np, sympy as sp
sys.path.insert(0, 'scripts/lib')
from review_r33_spec import weyl_basis, L_matrix, pairs, s_m, c_m

print("=== N9 / N10 bookkeeping, symbolically ===")
p,q=sp.symbols('p q', positive=True)
S=lambda m:(m+2)*(m-1)/2; Cc=lambda m:m*(m-1)/2
named=sp.expand(S(p)*S(q)+Cc(p)*Cc(q)+S(p)+S(q)+p*q+1)
print("  sum of named mults =",sp.factor(named)," ; pq(pq+3)/2 =",sp.expand(p*q*(p*q+3)/2),
      " equal:",sp.simplify(named-p*q*(p*q+3)/2)==0)
n=p+q
dimW=sp.expand(n*(n+1)*(n+2)*(n-3)/12)
diff=sp.simplify(dimW-p*q*(p*q+3)/2)
print("  dim Weyl_n - named =",sp.factor(diff))
print("  sign at small (p,q):")
for a in range(2,7):
    row=[]
    for b in range(2,7):
        row.append(int(diff.subs({p:a,q:b})))
    print("     p=%d:"%a,row)
mu=(n-2)/(2*(p-1)*(q-1))
print("  mu>=1/2  <=>  (p-2)(q-2)<=1 :",
      sp.simplify(sp.expand(2*(p-1)*(q-1)-2*(n-2)) - sp.expand(2*((p-2)*(q-2)-1)))==0)

print("\n=== N11: is E(1/2) the orbit tangent? ===")
def orbit_tangent(pp,qq):
    n=pp+qq; P=pairs(n); idx={x:a for a,x in enumerate(P)}; D=len(P)
    # rho(A) on Lambda^2 for A in so(n):  rho(phi_ab) acting on e_i^e_j
    def rho(ab):
        a,b=ab; M=np.zeros((D,D))
        for (i,j) in P:
            for (k,l),s in [((a,j),1) if i==b else ((0,0),0),]:
                pass
        # build directly: A e_i = sum_k A_ki e_k with A = phi_ab = E_ab - E_ba
        Amat=np.zeros((n,n)); Amat[a,b]=1; Amat[b,a]=-1
        for (i,j) in P:
            col=idx[(i,j)]
            for k in range(n):
                if Amat[k,i]!=0:
                    ii,jj=k,j
                    if ii==jj: continue
                    s=Amat[k,i]
                    if ii>jj: ii,jj=jj,ii; s=-s
                    M[idx[(ii,jj)],col]+=s
                if Amat[k,j]!=0:
                    ii,jj=i,k
                    if ii==jj: continue
                    s=Amat[k,j]
                    if ii>jj: ii,jj=jj,ii; s=-s
                    M[idx[(ii,jj)],col]+=s
        return M
    from review_r33_spec import eps_of
    W=np.zeros((D,D)); eps=eps_of(pp,qq)
    for t,(i,j) in enumerate(P): W[t,t]=eps[t]
    T=[]
    for ab in P:
        Rm=rho(ab)
        T.append(Rm@W-W@Rm)
    return np.array(T), W

for (pp,qq) in [(3,4),(4,4),(3,5),(4,6),(5,5),(2,6),(3,3)]:
    n=pp+qq
    B,_=weyl_basis(n); dim=B.shape[0]
    L=L_matrix(pp,qq,B); L=(L+L.T)/2
    ev,V=np.linalg.eigh(L)
    E12=V[:,np.abs(ev-0.5)<1e-8]
    T,W=orbit_tangent(pp,qq)
    Bf=B.reshape(dim,-1)
    Tc=Bf@T.reshape(T.shape[0],-1).T        # orbit tangent in Weyl coords
    # rank / orthonormal basis of tangent
    u,s,vt=np.linalg.svd(Tc,full_matrices=False)
    r=int((s>1e-9*max(1,s[0])).sum())
    U=u[:,:r]
    # principal angles between orbit tangent and E(1/2)
    if E12.shape[1]>0 and r>0:
        sv=np.linalg.svd(U.T@E12,compute_uv=False)
        cosmin=sv.min(); cosmax=sv.max()
    else: cosmin=cosmax=float('nan')
    # residual of L on tangent
    res=np.max(np.abs(L@U-0.5*U)) if r>0 else 0
    print(f"  ({pp},{qq}) n={n}: dim E(1/2)={E12.shape[1]:3d}  rank(orbit tangent)={r:3d}  pq={pp*qq:3d}  "
          f"|L U - U/2|={res:.2e}  princ cos in [{cosmin:.9f},{cosmax:.9f}]")
