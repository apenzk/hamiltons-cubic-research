import numpy as np
import time
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, P_value, norm, frob, mop_from_4tensor
from cp2_tensor import cp2_tensor

def analyze(n, verbose=True):
    t0 = time.time()
    L2 = Lambda2(n)
    T, J = cp2_tensor(n)
    Mop = mop_from_4tensor(L2, T)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    ricci_trace_of_weyl_ok = True  # weyl_from_mop already subtracts trace parts; verify via recompute
    Ric2 = None
    # sanity: Ricci of Weyl itself should vanish
    from weyl_decomposition import ricci_from_mop
    RicW = ricci_from_mop(L2, Weyl)
    maxRicW = np.max(np.abs(RicW))
    Q = Q_op(L2, Weyl)
    nv = norm(Weyl)
    Pv = frob(Weyl, Q)
    Pnorm = Pv / nv**3
    # idempotent check: Q(Weyl) proportional to Weyl?
    # lambda estimate = P value itself (should equal <W,Q(W)> / |W|^2 * ... on unit sphere lambda=P)
    Wn = Weyl / nv
    Qn = Q_op(L2, Wn)
    lam = frob(Wn, Qn)
    diff = Qn - lam * Wn
    reldiff = norm(diff) / norm(Qn) if norm(Qn) > 0 else float('nan')
    t1 = time.time()
    if verbose:
        print(f"n={n}: |Ric(Weyl)|max={maxRicW:.2e}  P_normalized={Pnorm:.6f}  "
              f"idempotent-reldiff={reldiff:.4f}  time={t1-t0:.1f}s")
    return Pnorm, reldiff

if __name__ == "__main__":
    for n in [4,5,6,7,8]:
        analyze(n)
