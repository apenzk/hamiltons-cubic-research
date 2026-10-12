"""I121 screen (not evidence): the maximum of |grad F(sigma)|_F / |sigma|_F^2 for the signed triangle-pair minor cubic F, 2/sqrt3 at m = 4, 5, the constant the Cauchy-Schwarz route to the candidate lemma needs. Run with sage -python."""
import numpy as np, itertools
from scipy.optimize import minimize
def build(m):
    P=range(m); Q=range(m,2*m)
    V=[(pi,ka) for pi in itertools.combinations(P,2) for ka in itertools.combinations(Q,2)]; ix={v:i for i,v in enumerate(V)}
    H=[]
    for tp in itertools.combinations(P,3):
        pe=[(tp[0],tp[1]),(tp[1],tp[2]),(tp[0],tp[2])]
        for tq in itertools.combinations(Q,3):
            qe=[(tq[0],tq[1]),(tq[1],tq[2]),(tq[0],tq[2])]
            for perm in itertools.permutations(range(3)):
                H.append(([ix[(pe[k],qe[perm[k]])] for k in range(3)],np.linalg.det(np.eye(3)[list(perm)])))
    A=np.array([h[0] for h in H]); S=np.array([h[1] for h in H]); return len(V),A,S
def grad(s,A,S,nv):
    g=np.zeros(nv)
    np.add.at(g,A[:,0],S*s[A[:,1]]*s[A[:,2]]); np.add.at(g,A[:,1],S*s[A[:,0]]*s[A[:,2]]); np.add.at(g,A[:,2],S*s[A[:,0]]*s[A[:,1]])
    return g
rng=np.random.default_rng(1)
for m in (3,4,5):
    nv,A,S=build(m); best=0
    for t in range(30):
        f=lambda s: -np.linalg.norm(grad(s,A,S,nv))/np.dot(s,s)
        r=minimize(f,rng.standard_normal(nv),method='L-BFGS-B'); best=max(best,-r.fun)
    print(f'm={m}: max |grad F|/|sigma|^2 = {best:.5f}  (route needs 2/sqrt3 = {2/np.sqrt(3):.5f}; m=3 cofactor 1/sqrt3 = {1/np.sqrt(3):.5f})')
