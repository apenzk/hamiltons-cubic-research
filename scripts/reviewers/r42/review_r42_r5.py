"""R5: is the sequential (Bianchi-then-Ricci) removal the orthogonal projection,
   and does L_e preserve Weyl_n?"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
from review_r42_spec import e_cpm
from review_r42_hw import Le_apply
np.random.seed(5)

def weyl_formula(n, Y):
    """standard Weyl part of an ALGEBRAIC CURVATURE tensor, via Kulkarni-Nomizu."""
    Ric=ricci(n,Y); s=np.trace(Ric); g=np.eye(n)
    Ric0=Ric-(s/n)*g
    return Y - (1.0/(n-2))*kn(n,Ric0) - (s/(2*n*(n-1)))*kn(n,g)

def seq_BR(n,X):          # remove Lambda^4 (orthogonally), then the Ricci part
    Y=0.5*(X+X.T); Y=Y-alt(n,Y); return weyl_formula(n,Y)
def seq_RB(n,X):          # remove the Ricci part first, then Lambda^4
    Y=0.5*(X+X.T); Z=weyl_formula(n,Y); return Z-alt(n,Z)
def seq_bianchi_nofactor(n,X):   # 'remove the Bianchi part' WITHOUT the 1/3
    Y=0.5*(X+X.T); return weyl_formula(n, Y-3.0*alt(n,Y))

def as_matrix(n, f):
    N=len(pairs(n)); basis=[]
    for i in range(N):
        for j in range(i,N):
            E=np.zeros((N,N)); E[i,j]=1; E[j,i]=1
            if i!=j: E=E/np.sqrt(2.0)
            basis.append(E)
    B=np.array([b.ravel() for b in basis])
    M=np.array([f(n,b).ravel() for b in basis])
    return B@M.T          # Gram: <b_a, f(b_b)>

for n in [6,8]:
    N=len(pairs(n))
    for nm,f in [('Bianchi-then-Ricci',seq_BR),('Ricci-then-Bianchi',seq_RB),
                 ('true orthogonal',proj_weyl),('Bianchi w/o 1/3',seq_bianchi_nofactor)]:
        G=as_matrix(n,f)
        idem_err=None
        # idempotency and agreement with the true projector
        M2=np.random.randn(N,N); M2=M2+M2.T
        Y=f(n,M2); Y2=f(n,Y)
        Wt=proj_weyl(n,M2)
        print(f"n={n} {nm:20s} asym|G-G^T|={np.abs(G-G.T).max():.2e}  idem={np.abs(Y2-Y).max():.2e}  "
              f"vs true proj rel-diff={np.linalg.norm(Y-Wt)/np.linalg.norm(Wt):.2e}  "
              f"fixes Weyl: {np.abs(f(n,Wt)-Wt).max():.1e}")
    print()

# does L_e preserve Weyl?
for m in [3,4,5,6]:
    n=2*m; N=len(pairs(n)); e=e_cpm(m)
    M=np.random.randn(N,N); X=proj_weyl(n,M+M.T); X/=np.linalg.norm(X)
    Y=Le_apply(n,e,X)
    leak=np.linalg.norm(Y-proj_weyl(n,Y))/np.linalg.norm(Y)
    # leak measured with the BAD projector, for comparison
    leakbad=np.linalg.norm(Y-seq_bianchi_nofactor(n,Y))/np.linalg.norm(Y)
    print(f"m={m}: |L_e X - P_Weyl(L_e X)|/|L_e X| = {leak:.2e}   (with the no-1/3 projector: {leakbad:.2e})")
