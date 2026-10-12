import numpy as np
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, norm, frob, mop_from_4tensor
from cp2_tensor import build_J

def cp2_block_st_tensor(n, s, t, block=(0,1,2,3)):
    J = build_J(n)
    Jmat = J.T.copy()
    d = np.eye(n)
    blockset = set(block)
    def T(i,j,k,l):
        if not (i in blockset and j in blockset and k in blockset and l in blockset):
            return 0.0
        val = s*(d[i,k]*d[j,l]-d[i,l]*d[j,k])
        val += t*((Jmat[i,k]*Jmat[j,l]-Jmat[i,l]*Jmat[j,k]) + 2*Jmat[i,j]*Jmat[k,l])
        return val
    return T

def analyze(n, s, t, verbose=True):
    L2 = Lambda2(n)
    T = cp2_block_st_tensor(n, s, t)
    Mop = mop_from_4tensor(L2, T)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    nv = norm(Weyl)
    if nv < 1e-10:
        if verbose: print(f"n={n} s={s} t={t}: Weyl~0")
        return None, None
    Q = Q_op(L2, Weyl)
    Pv = frob(Weyl, Q)
    Pnorm = Pv / nv**3
    Wn = Weyl / nv
    Qn = Q_op(L2, Wn)
    lam = frob(Wn, Qn)
    diff = Qn - lam * Wn
    reldiff = norm(diff) / norm(Qn) if norm(Qn) > 0 else float('nan')
    if verbose:
        print(f"n={n} s={s:+.3f} t={t:+.3f}: P_normalized={Pnorm:+.6f}  idempotent-reldiff={reldiff:.5f}")
    return Pnorm, reldiff

if __name__ == "__main__":
    n = 8
    for t in [-2.0,-1.5,-1.2,-1.0,-0.8,-0.5,0.0,0.5,1.0]:
        analyze(n, 1.0, t)
