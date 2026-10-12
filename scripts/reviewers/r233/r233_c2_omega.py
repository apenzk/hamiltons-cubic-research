"""r233 claim 2: the omega-spectrum of the balanced product against the closed form
in findings/bispectral.md, with the fixed sign and with the old sign."""
import numpy as np, itertools, sys
sys.path.insert(0, 'scripts/lib')
exec(open('scripts/reviewers/r233/r233_c2_signs.py').read().split('print("=== S^p')[0])

def ring(W, order='iklj'):
    n=W.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]; m=len(idx)
    def basis(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[basis(i,j) for (i,j) in idx]; Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum(f'{order},kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    g=np.array([np.trace(basis(i,j)) for (i,j) in idx]); g/=np.linalg.norm(g)
    Pr=np.eye(m)-np.outer(g,g); return Pr@Op@Pr

def lam2(W):
    n=W.shape[0]; pairs=list(itertools.combinations(range(n),2))
    M=np.zeros((len(pairs),len(pairs)))
    for a,(i,j) in enumerate(pairs):
        for b,(k,l) in enumerate(pairs): M[a,b]=W[i,j,k,l]
    return M

for m in (3,4,5,6):
    n=2*m
    W=weyl_from_R(R_sphere_product(m,m))
    M=lam2(W); nrm=np.linalg.norm(M); W=W/nrm; M=M/nrm
    R0=ring(W)
    om=np.linalg.eigvalsh(R0)
    A=1/(m*np.sqrt((m-1)*(2*m-1)))
    pred=sorted([m*A]*((m-1)*(m+2))+[-(m-1)*A]*(m*m)+[-2*m*(m-1)*A])
    # ring has dim n(n+1)/2, one extra zero from the trace projection
    obs=sorted(np.round(om,10))
    # drop the eigenvalue nearest zero (the pure-trace direction killed by Pr)
    k=int(np.argmin(np.abs(om))); obs2=sorted(np.delete(om,k))
    err=max(abs(a-b) for a,b in zip(pred,obs2))
    print(f"m={m} n={n}: dim(ring)={len(om)} dim(S^2_0)={n*(n+1)//2-1}  max|omega_obs - closed form|={err:.2e}")
    print(f"    dropped eigenvalue = {om[k]:.3e}; second-smallest |lambda| = {sorted(abs(om))[1]:.6f}")
    print(f"    min(omega)={om.min():+.6f}  -2m(m-1)A={-2*m*(m-1)*A:+.6f}   max(omega)={om.max():+.6f}  mA={m*A:+.6f}")
    p3mu=np.sum(np.linalg.eigvalsh(M)**3); p3om=np.sum(obs2**3 if False else np.array(obs2)**3)
    print(f"    p3(mu)={p3mu:+.8f} vs 1/(m sqrt((m-1)(2m-1)))={A:+.8f}")
    print(f"    p3(om)={p3om:+.8f} vs -(4m^2-6m-1)*A={-(4*m*m-6*m-1)*A:+.8f}")
    print(f"    theta=1.5p3mu-0.5p3om={1.5*p3mu-0.5*p3om:+.8f}  theta_0={np.sqrt(2*(n-1)*(n-2))/n:+.8f}")
