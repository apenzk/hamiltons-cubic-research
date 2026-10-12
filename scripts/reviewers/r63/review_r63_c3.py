"""Reviewer 63 -- C3: the chain theta <= 9 b c (b+c), step by step, on real Weyl operators."""
import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')[0])
from review_r63_core import *

def audit(m, ndraw, rng, extra=()):
    c,_,_ = structure_constants(m); wb = weyl_basis(m); out = []
    Ws = [random_weyl(m, rng, wb) for _ in range(ndraw)] + list(extra)
    for W in Ws:
        lam, T, _ = eigen_T(W, c)
        if int(np.sum(lam < -1e-9)) != 2: continue
        o = np.argsort(-lam); lam = lam[o]; T = T[np.ix_(o,o,o)]
        n = len(lam); Nm1, N = n-2, n-1
        b = -lam[N]; cc = -lam[Nm1]; s = b + cc
        P = [a for a in range(n) if lam[a] > 1e-9]
        u = sum(lam[a]**2 for a in P); l1 = max(lam[a] for a in P)
        th = theta(W, c)
        blk = {'ppp':0.,'ppm':0.,'pmm':0.,'mmm':0.}
        for (a,bb,g) in itertools.combinations(range(n),3):
            v = 3*T[a,bb,g]*lam[a]*lam[bb]*lam[g]
            ng = sum(1 for i in (a,bb,g) if lam[i] < -1e-9)
            if abs(lam[a]*lam[bb]*lam[g]) < 1e-18: continue
            blk[['ppp','ppm','pmm','mmm'][ng]] += v
        cube = float(np.sum(lam**3))
        out.append(dict(theta=th, s=s, b=b, c=cc, u=u, l1=l1, k=len(P),
                        cube=cube, **blk,
                        step_mmm=blk['mmm'], step_ppm=blk['ppm'],
                        step_pmm_slack=6*l1*b*cc-blk['pmm'],
                        step_ppp_slack=l1*(s*s-u)-blk['ppp'],
                        step_cube_slack=l1*u-(cube+b**3+cc**3),
                        step_l1_slack=s-l1,
                        bound=9*b*cc*s, gap=9*b*cc*s-th))
    return out

if __name__ == '__main__':
    rng = np.random.default_rng(5)
    # base-case family
    _, B4 = basis(4)
    w = [(B4[0]+B4[5])/np.sqrt(2), (B4[1]-B4[4])/np.sqrt(2), (B4[2]+B4[3])/np.sqrt(2)]
    vecs = np.array([[ip(wi, B4[a]) for a in range(6)] for wi in w])
    base = []
    for (q,r) in [(1,1),(1,2),(0.3,2.7),(2,5),(1,0.05)]:
        W = (q+r)*np.outer(vecs[0],vecs[0]) - q*np.outer(vecs[1],vecs[1]) - r*np.outer(vecs[2],vecs[2])
        base.append(W/np.sqrt(ip_mat(W,W)))
    print('=== base-case family W4(q,r): every step of the C3 chain ===')
    for d in audit(4, 0, rng, extra=base):
        print('  k=%d theta=%.6f  bound 9bcs=%.6f  gap=%.2e | slacks: (---)=%.1e (++-)=%.1e (+--)=%.2e (+++)=%.2e cube=%.2e lam1<=s=%.2e'
              %(d['k'],d['theta'],d['bound'],d['gap'],d['step_mmm'],d['step_ppm'],
                d['step_pmm_slack'],d['step_ppp_slack'],d['step_cube_slack'],d['step_l1_slack']))
    print('=== random two-negative Weyl operators (m=4) ===')
    g = audit(4, 400, rng)
    print('  %d hits; min gap 9bcs - theta = %.4f; all steps nonneg: %s'
          %(len(g), min(d['gap'] for d in g),
            all(min(d['step_pmm_slack'],d['step_ppp_slack'],d['step_cube_slack'],d['step_l1_slack'],
                    -d['step_ppm'], -d['step_mmm']) > -1e-9 for d in g)))
    print('  max theta = %.6f, max 9bcs = %.6f, sqrt(3/2)=%.6f'
          %(max(d['theta'] for d in g), max(d['bound'] for d in g), np.sqrt(1.5)))
