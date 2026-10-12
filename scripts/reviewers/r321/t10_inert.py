"""Direct test of the sign-inertness claim:
theta = tr W^3 + 3 sum_{triples} lam_a lam_b lam_c t_{abc}, and m x m x m triples carry
lam_a lam_b lam_c < 0, so any maximiser of theta over the c^2-data already puts t=0 there.
Hence S_mmm=0 is an INACTIVE constraint for every such bound."""
import numpy as np, itertools, sys
from scipy.optimize import linprog

def run(n, spectra, seed=0):
    N=n*(n-1)//2
    tri=[tuple(s) for s in itertools.combinations(range(N),3)]
    tidx={s:i for i,s in enumerate(tri)}
    inc=[[] for _ in range(N)]
    for i,s in enumerate(tri):
        for a in s: inc[a].append((i,[x for x in s if x!=a]))
    nt=len(tri)
    out=[]
    for tag,lam in spectra:
        Aeq=np.zeros((2*N,nt+1)); beq=np.zeros(2*N)
        for a in range(N):
            for (i,(b,c)) in inc[a]: Aeq[a,i]=lam[b]*lam[c]
            Aeq[a,nt]=-lam[a]; beq[a]=-lam[a]**2
            for (i,_) in inc[a]: Aeq[N+a,i]=1.0
            beq[N+a]=n-2.0
        c=np.zeros(nt+1); c[nt]=-1.0
        r=linprog(c,A_eq=Aeq,b_eq=beq,bounds=[(0,None)]*nt+[(None,None)],method='highs')
        if not r.success: out.append((tag,None,None)); continue
        neg=lam<0
        mmmmass=sum(r.x[i] for i,s in enumerate(tri) if neg[s[0]] and neg[s[1]] and neg[s[2]])
        out.append((tag,r.x[nt],mmmmass))
    return out

n=6; N=15
sp=[]
sp.append(("S^3xS^3 spectrum", np.array([-np.sqrt(0.4/9)]*9+[np.sqrt(0.1)]*6)))
rng=np.random.default_rng(808)
for k in range(6):
    D=rng.integers(3,10)
    mu=np.abs(rng.standard_normal(D))+0.05; nu=np.abs(rng.standard_normal(N-D))+0.05
    nu*=mu.sum()/nu.sum(); l=np.concatenate([-mu,nu]); l/=np.linalg.norm(l)
    sp.append((f"random dim m={D}", l))
print("LP maximising theta over the c^2 data, WITHOUT any S_mmm=0 constraint.")
print("If the optimal t already has zero mass on m x m x m, the constraint is inactive.\n")
for tag,th,mmm in run(6,sp):
    print(f"  {tag:22s} LP theta = {th if th is None else round(th,6)}   mass of t on m x m x m at the optimum = {mmm if mmm is None else format(mmm,'.3e')}")
