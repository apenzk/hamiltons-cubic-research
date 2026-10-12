"""I121 screen (not evidence for a positive claim): maximum over unit sigma of the cubic 6 kappa sum over hyperedges of signed products, the true P(f) on the +c_* modes (model checked against P at n = 8 to 1e-16), at m = 3..6, by shifted power iteration from 40 random starts. Run with sage -python."""
# Screen: max over unit sigma of q = 6 kappa sum_{hyperedges} sign * s_S s_T s_U (no closedness imposed),
# hyperedges = (triangle in K_P) x (triangle in K_Q') x (edge matching, sign = parity), kappa = 5 sqrt3 / 24.
import numpy as np, itertools
kap=5*np.sqrt(3)/24
def run(m, trials=40, seed=0):
    P=range(m); Q=range(m,2*m)
    V=[(pi,ka) for pi in itertools.combinations(P,2) for ka in itertools.combinations(Q,2)]; ix={v:i for i,v in enumerate(V)}
    H=[]
    for tp in itertools.combinations(P,3):
        pe=[(tp[0],tp[1]),(tp[1],tp[2]),(tp[0],tp[2])]
        for tq in itertools.combinations(Q,3):
            qe=[(tq[0],tq[1]),(tq[1],tq[2]),(tq[0],tq[2])]
            for perm in itertools.permutations(range(3)):
                sgn=np.linalg.det(np.eye(3)[list(perm)])
                H.append(([ix[(pe[k],qe[perm[k]])] for k in range(3)],sgn))
    rng=np.random.default_rng(seed); best=0
    for t in range(trials):
        s=rng.standard_normal(len(V)); s/=np.linalg.norm(s)
        for it in range(400):
            g=np.zeros(len(V))
            for (a,b,c),sg in H: g[a]+=sg*s[b]*s[c]; g[b]+=sg*s[a]*s[c]; g[c]+=sg*s[a]*s[b]
            s=s+0.5*g; s/=np.linalg.norm(s)
        val=6*kap*sum(sg*s[a]*s[b]*s[c] for (a,b,c),sg in H); best=max(best,val)
    return best, len(V), len(H)
for m in (3,4,5,6):
    d2=2*(2*m-1)*(2*m-2)/(2*m)**2; bound=np.sqrt(d2*m*m*(m-3)/(m-1)**3) if m>3 else 0
    b,nv,nh=run(m)
    print(f'm={m}: vertices {nv}, hyperedges {nh}, max q (no closedness) {b:.4f}, sufficient bound {bound:.4f}')
