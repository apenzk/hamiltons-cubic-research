"""r274: confirm ||M#||_F for GENERAL (non-diagonal) M by a pure index formula,
independent of the ad-form:  (R#)_{ijkl} = sum_{p,q} (R_{ipkq} R_{jplq} - R_{iplq} R_{jpkq}).
"""
import numpy as np, sys
sys.path.insert(0, __file__.rsplit('/',1)[0])
from r274_weyl import Geo
def sharp_index(g, M):
    R = g.to_tensor(M)
    T = np.einsum('ipkq,jplq->ijkl', R, R, optimize=True) - np.einsum('iplq,jpkq->ijkl', R, R, optimize=True)
    return g.to_matrix(T)
for n in (5, 6, 7):
    g = Geo(n); rng = np.random.default_rng(2)
    A = rng.standard_normal((g.N,g.N)); M = g.proj_weyl(0.5*(A+A.T)); M/=np.linalg.norm(M)
    S1, S2 = g.sharp(M), sharp_index(g, M)
    print(f" n={n}: ||S_ad - S_index|| = {np.linalg.norm(S1-S2):.2e}   ratio {np.linalg.norm(S1)/np.linalg.norm(S2):.12f}")
print("\n the claim-2 maximisers, ||M#||_F by the index formula:")
for n in (6, 8, 10, 12):
    g = Geo(n); M = np.load(f"scripts/reviewers/r274/best_F_n{n}.npy")
    t0 = np.sqrt(2.0*(n-1)*(n-2))/n
    S2 = sharp_index(g, M)
    print(f"  n={n:>2}: |M#|_ad={np.linalg.norm(g.sharp(M)):.9f}  |M#|_index={np.linalg.norm(S2):.9f}"
          f"  F={(float(np.trace(M@M@M))+np.linalg.norm(S2))/t0:.6f}")
