"""r233 claim 2: rebuild W(S^p x S^q) and W(CP^m) from the metric, in Hamilton's
convention R_{ijij}=+K (sectional), and compare against the catalogue's builders."""
import numpy as np, itertools, sys
sys.path.insert(0, 'scripts/lib')

def KN(A,B):
    return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
            -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))

def weyl_from_R(R):
    """R in Hamilton convention R_{ijij}=K.  Ric_{jl}=sum_i R_{ijil}."""
    n=R.shape[0]; g=np.eye(n)
    Ric=np.einsum('ijil->jl',R); s=np.trace(Ric); E=Ric-s/n*g
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)

def R_sphere_product(p,q):
    """product of unit round S^p and S^q; K=1 inside a factor, 0 across."""
    n=p+q; R=np.zeros((n,n,n,n))
    for blk in (range(p),range(p,n)):
        for i in blk:
            for j in blk:
                for k in blk:
                    for l in blk:
                        R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R

def R_cpm_hamilton(m):
    """Fubini-Study, holomorphic sectional curvature 4, Hamilton convention.
    K(e_i,e_j)=R_{ijij}=1+3<Je_i,e_j>^2 for orthonormal i,j."""
    d=2*m; J=np.zeros((d,d))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    g=np.eye(d)
    # R_{ijkl} = g_ik g_jl - g_il g_jk + J_ik J_jl - J_il J_jk + 2 J_ij J_kl
    R=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
       +2*np.einsum('ij,kl->ijkl',J,J))
    return R

def checks(name,R):
    n=R.shape[0]
    b1=np.abs(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3)).max()
    sym=np.abs(R-R.transpose(2,3,0,1)).max()
    a1=np.abs(R+R.transpose(1,0,2,3)).max()
    print(f"  {name}: |Bianchi|={b1:.1e} |pair-sym|={sym:.1e} |antisym|={a1:.1e}")

# ---- the catalogue's own builders, both signs ----
def diag_weyl(Lam):
    n=Lam.shape[0]; I=np.eye(n)
    return np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I)
def sphere_product(p,q,b):
    n=p+q; Lam=np.zeros((n,n))
    a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i==j: continue
            Lam[i,j]= a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    return diag_weyl(Lam)
def cpm_catalogue(m, n=None):
    d=2*m; J=np.zeros((d,d))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    g=np.eye(d)
    R=(np.einsum('jk,il->ijkl',g,g)-np.einsum('ik,jl->ijkl',g,g)
       +np.einsum('jk,il->ijkl',J,J)-np.einsum('ik,jl->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J))
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/d*g
    def KN2(A,B): return np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)-np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B)
    W=R-KN2(E,g)/(d-2)-s/(2*d*(d-1))*KN2(g,g)
    if n and n>d:
        Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; W=Wp
    return W

def unit(T): return T/np.linalg.norm(T)

print("=== S^p x S^q: true Weyl (Hamilton conv) vs catalogue builder ===")
for (p,q) in [(3,3),(4,4),(5,5),(6,6),(5,7),(4,8)]:
    R=R_sphere_product(p,q); checks(f"R S^{p}xS^{q}",R)
    Wt=weyl_from_R(R)
    ric=np.abs(np.einsum('ijil->jl',Wt)).max()
    Wnew=sphere_product(p,q,-1.0); Wold=sphere_product(p,q,+1.0)
    dn=np.linalg.norm(unit(Wt)-unit(Wnew)); do=np.linalg.norm(unit(Wt)-unit(Wold))
    # sectional signature
    intra=Wt[0,1,0,1]; cross=Wt[0,p,0,p]
    print(f"  S^{p}xS^{q}: |Ric(W)|={ric:.1e}  W_intra={intra:+.4f} W_cross={cross:+.4f}"
          f"  |Wtrue-Wnew|={dn:.2e}  |Wtrue-Wold|={do:.2e}")

print()
print("=== CP^m: true Weyl (Hamilton conv) vs catalogue builder ===")
for m in (2,3,4):
    R=R_cpm_hamilton(m); checks(f"R CP^{m}",R)
    d=2*m
    # sectional curvature sanity: holomorphic = 4, totally real = 1
    print(f"   K(e0,e1)={R[0,1,0,1]:+.4f} (holomorphic, want +4)   K(e0,e2)={R[0,2,0,2]:+.4f} (totally real, want +1)")
    Wt=weyl_from_R(R); Wc=cpm_catalogue(m)
    ric=np.abs(np.einsum('ijil->jl',Wt)).max()
    dp=np.linalg.norm(unit(Wt)-unit(Wc)); dm=np.linalg.norm(unit(Wt)+unit(Wc))
    print(f"  CP^{m}: |Ric(W)|={ric:.1e}  |Wtrue-Wcat|={dp:.2e}  |Wtrue+Wcat|={dm:.2e}")
