"""r274: verify the optimiser's maximisers are genuine Weyl tensors, and recompute
theta by a route that never touches so(n): the Dai-Fu contractions
   alpha = W_tpsq W_tpkl W_sqkl = 8 tr(M^3),   beta = W_tspq W_tjpl W_sjql = 2<M#,M>.
"""
import numpy as np, sys, itertools
sys.path.insert(0, __file__.rsplit('/', 1)[0])
from r274_weyl import Geo

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

def theta_by_contraction(g, M):
    R = g.to_tensor(M)
    alpha = np.einsum('tpsq,tpkl,sqkl->', R, R, R, optimize=True)
    beta  = np.einsum('tspq,tjpl,sjql->', R, R, R, optimize=True)
    return alpha/8.0, beta/2.0

# first: validate the dictionary on random Weyl tensors
print("== dictionary check on random unit Weyl tensors ==")
for n in (5, 6, 7):
    g = Geo(n); rng = np.random.default_rng(11)
    A = rng.standard_normal((g.N, g.N)); M = g.proj_weyl(0.5*(A+A.T)); M /= np.linalg.norm(M)
    a8, b2 = theta_by_contraction(g, M)
    print(f" n={n}  tr(M^3): {float(np.trace(M@M@M)):+.12f} vs {a8:+.12f}"
          f"   <M#,M>: {float(np.sum(g.sharp(M)*M)):+.12f} vs {b2:+.12f}")

print("\n== the maximisers ==")
for n in (6, 8, 10, 12):
    g = Geo(n)
    for which in ('F', 'T'):
        M = np.load(f"scripts/reviewers/r274/best_{which}_n{n}.npy")
        R = g.to_tensor(M)
        bia = np.abs(R + np.transpose(R,(0,2,3,1)) + np.transpose(R,(0,3,1,2))).max()
        ric = np.abs(np.einsum('ijkj->ik', R)).max()
        tr3, ip = theta_by_contraction(g, M)
        S = g.sharp(M); nS = np.linalg.norm(S)
        F = (float(np.trace(M@M@M)) + nS)/theta0(n)
        print(f" n={n:>2} obj={which}: |M|={np.linalg.norm(M):.12f} bianchi={bia:.1e} ric={ric:.1e}"
              f"  theta={tr3+ip:.8f} (contraction)  theta/th0={(tr3+ip)/theta0(n):.6f}"
              f"  F={F:.6f}  cos={ip/nS:.6f}")
        if which == 'T':
            ev = np.sort(np.linalg.eigvalsh(M))
            print(f"      Lambda^2 spectrum of the theta-maximiser (x sqrt6): "
                  f"{np.round(ev*np.sqrt(6),6)[[0,1,2,-3,-2,-1]]}  nonzero count="
                  f"{int(np.sum(np.abs(ev)>1e-8))}")
