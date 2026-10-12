"""A per-direction cap on g_gamma using the per-row identity as a CONSTRAINT.

  g_g = 2 sum_a lam_a^2 R_{ga} - 2 Q_g,   Q_g = sum_ab lam_a lam_b T_{gab}

Constraints available per gamma:
  R_{g.} >= 0,  sum_a R_{ga} = rho = 2(n-2),  sum_a lam_a R_{ga} = -2 lam_g   [per-row identity]
Maximising sum lam^2 R over that set is a two-moment problem: the optimum puts mass on two
eigenvalues, and for lam in [a,b] with mean mubar it gives E[lam^2] <= (a+b) mubar - ab.
  => sum lam_a^2 R_{ga} <= rho[ (lmin+lmax)(-2 lam_g/rho) - lmin lmax ]
And Q_g >= lmin*lmax*rho since T >= 0 and lam_a lam_b >= lmin lmax.
Compare against the recorded uniform cap 2(n-2)(lmax-lmin)^2.
"""
import numpy as np, itertools
rng=np.random.default_rng(401)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def diag_weyl(Lam):
    n=Lam.shape[0]; I=np.eye(n)
    return np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I)
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i!=j: Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    return -diag_weyl(Lam)
def setup(n,W):
    pr=list(itertools.combinations(range(n),2)); N=len(pr)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pr]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g_,(k,l) in enumerate(pr): c[a,b,g_]=C[k,l]
    M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]); M/=np.linalg.norm(M)
    lam,V=np.linalg.eigh(M)
    cE=np.einsum('abg,aA,bB,gG->ABG',c,V,V,V,optimize=True); T=cE**2
    gvec=np.einsum('ab,gab->g',(lam[:,None]-lam[None,:])**2,T)
    R2=np.einsum('gab->ga',T)
    return lam,T,gvec,R2
def caps(lam,n):
    a,b=lam.min(),lam.max(); rho=2*(n-2)
    crude=2*(n-2)*(b-a)**2
    # two-moment cap on sum lam^2 R, per gamma, then Q >= a*b*rho
    mubar=-2*lam/rho                      # per-gamma mean of lam under R_{g.}
    m2cap=rho*((a+b)*mubar - a*b)
    refined=2*m2cap - 2*(a*b*rho)
    return crude, refined
print(f"{'point':20s} {'max g':>8} {'crude cap':>10} {'refined':>9} {'refined/crude':>14} {'valid?':>7}")
for n in [6,8,10]:
    for lbl,W in [(f"S^{n//2}xS^{n//2}",sphere_product(n//2,n//2,n)),
                  (f"random n={n}",proj_weyl(rng.standard_normal((n,n,n,n)),n))]:
        lam,T,gvec,R2=setup(n,W)
        crude,refined=caps(lam,n)
        ok=np.all(gvec<=refined+1e-9)
        print(f"{lbl:20s} {gvec.max():8.4f} {crude:10.4f} {refined.max():9.4f} {refined.max()/crude:14.4f} {'yes' if ok else 'NO':>7}")
        # per-row identity residual, as a sanity check on the constraint used
        pr_res=np.abs(R2@lam+2*lam).max()
        print(f"{'':20s} per-row residual {pr_res:.1e}   worst slack refined-g = {(refined-gvec).min():+.4f}")
