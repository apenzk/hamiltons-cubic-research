"""Is the g-weighted reformulation new content, or a restatement of theta's definition?

  g_gamma = sum_{ab}(lam_a - lam_b)^2 T_{gamma a b}     (Petersen-Wink Prop 1.7)
  sum_gamma lam_gamma g_gamma = -4 theta                 (reviewers 69/70)

Expanding with T totally symmetric and using the per-row identity sum_b lam_b R_{ab} = -2 lam_a:
  sum lam_g lam_a^2 R_{ga} = -2 p3(mu)   =>   theta = p3(mu) + (1/2) sum lam lam lam T
which is theta = tr(M^3) + <M#,M>, the DEFINITION.  Check each step.
"""
import numpy as np, itertools
rng=np.random.default_rng(307)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def pairs(n): return list(itertools.combinations(range(n),2))
for n in [5,6,7]:
    pr=pairs(n); N=len(pr)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pr]
    c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g_,(k,l) in enumerate(pr): c[a,b,g_]=C[k,l]
    W=proj_weyl(rng.standard_normal((n,n,n,n)),n)
    M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]); M/=np.linalg.norm(M)
    lam,V=np.linalg.eigh(M)
    # T in the EIGENFRAME
    cE=np.einsum('abg,aA,bB,gG->ABG',c,V,V,V,optimize=True)
    T=cE**2
    gvec=np.einsum('ab,gab->g',(lam[:,None]-lam[None,:])**2,T)
    sharp=0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
    theta=np.trace(M@M@M)+np.sum(sharp*M)
    R2=np.einsum('gab->ga',T)                      # pair marginal
    perrow=np.abs(R2@lam + 2*lam).max()
    lhs=np.sum(lam*gvec)
    step1=np.einsum('g,a,a,ga->',lam,lam,lam,R2)   # sum lam_g lam_a^2 R_{ga}
    C3=np.einsum('g,a,b,gab->',lam,lam,lam,T)
    print(f"n={n}: sum g = {gvec.sum():.6f} (=4(n-1)={4*(n-1)})   sum lam*g = {lhs:+.6f}  -4theta = {-4*theta:+.6f}  dev {abs(lhs+4*theta):.1e}")
    print(f"      per-row identity residual {perrow:.1e} | sum lam_g lam_a^2 R = {step1:+.6f}   -2 p3(mu) = {-2*np.trace(M@M@M):+.6f}")
    print(f"      C = sum lam lam lam T = {C3:+.6f}   2<W#,W> = {2*np.sum(sharp*M):+.6f}   =>  p3(mu)+C/2 = {np.trace(M@M@M)+C3/2:+.6f}  theta = {theta:+.6f}")
