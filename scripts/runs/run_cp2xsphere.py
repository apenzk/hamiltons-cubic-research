import numpy as np
import time
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, P_value, norm, frob, mop_from_4tensor, ricci_from_mop
from cp2_tensor import cp2_tensor

def cp2_times_sphere_mop(L2, kappa):
    n = L2.n
    T, J = cp2_tensor(n)
    Mop = mop_from_4tensor(L2, T)
    for a, (i, j) in enumerate(L2.pairs):
        if i >= 4 and j >= 4:
            Mop[a, a] += kappa
    return Mop

def analyze(n, kappa=None, verbose=True):
    L2 = Lambda2(n)
    q = n - 4
    if kappa is None:
        kappa = 6.0 / (q - 1) if q > 1 else None
    Mop = cp2_times_sphere_mop(L2, kappa)
    Ric = ricci_from_mop(L2, Mop)
    einstein_ok = np.allclose(Ric, Ric[0,0]*np.eye(n)*0 + np.diag(np.concatenate([np.full(4,Ric[0,0]),np.full(q,Ric[4,4] if q>0 else 0)])), atol=1e-8) if q>0 else True
    Weyl, RicChk, S = weyl_from_mop(L2, Mop)
    Q = Q_op(L2, Weyl)
    nv = norm(Weyl)
    Pv = frob(Weyl, Q)
    Pnorm = Pv / nv**3
    Wn = Weyl / nv
    Qn = Q_op(L2, Wn)
    lam = frob(Wn, Qn)
    diff = Qn - lam * Wn
    reldiff = norm(diff) / norm(Qn) if norm(Qn) > 0 else float('nan')
    if verbose:
        print(f"n={n} q={q} kappa={kappa}: Ric00={Ric[0,0]:.4f} Ric44={(Ric[4,4] if q>0 else float('nan')):.4f} "
              f"P_normalized={Pnorm:.6f}  idempotent-reldiff={reldiff:.4f}")
    return Pnorm, reldiff

if __name__ == "__main__":
    for n in [5,6,7,8,9,10]:
        analyze(n)
