"""Batch 34: what batch 20's value identity does and does not give.

BATCH 20's IDENTITY.  At a critical point Phi = 2 mu T - 2 P_3, with
P_3 = alpha tr U^3 + beta tr(U V^2).  Two things follow, one of them a caution.

  1. mu*T - P_3 = Phi/2 IDENTICALLY.  So "comparing mu*T - P_3" is comparing Phi
     itself, and batch 20's earlier wording, that the open question becomes a
     comparison of two numbers rather than of configurations, was circular.  The
     real content is that the FIELDS drop out: Phi is fixed by mu, T and P_3.

  2. The pairing mu |V|^2 = 2 beta tr(U V^2) + <V,C>, together with batch 18's
     Jordan cap tr(U V^2) <= (|U|/sqrt6)|V|^2, gives

         mu <= 2 beta |U| / sqrt6 + <V,C> / |V|^2

     at every critical point with V nonzero.  It is TRUE AND NOT A BOUND: the only
     non-trivial term is a field pairing, and C is defined by the equation the
     display came from.  Rearranged it is the Rayleigh inequality and nothing more.
     Post F69 for a fourth time.

  3. Against batch 18's lower bound it forces <V,C> >= 0 at a global maximum.  That
     is not vacuous, since <V,C> takes both signs at critical points, but it is
     IMPLIED by batch 18 alone and so adds nothing.

THE CONTROL.  <V,C> is evaluated at batch 28's two recorded non-commuting critical
points, where batch 18's bound FAILS, and it comes out of both signs.  That is what
shows the corollary is a real condition rather than an identity, and it is also why
it cannot be read as evidence about maximisers: neither point is one.

Screening and checking only.  No positive claim in batch 34 rests on a run.
"""

import numpy as np
import sympy as sp

ALPHA, BETA = 15 / 4, 9 / 4


def identity_is_circular():
    mu, T, P3 = sp.symbols("mu T P3")
    Phi = 2 * mu * T - 2 * P3
    print("1. mu*T - P_3 - Phi/2 =", sp.simplify((mu * T - P3) - Phi / 2),
          " <- zero, so the comparison is of Phi itself")


def rayleigh_cap(trials=20000, seed=0):
    """tr(U V^2) = <L_U V, V> <= lambda_max(L_U) |V|^2 with lambda_max = |U|/sqrt6."""
    rng = np.random.default_rng(seed)

    def ts():
        M = rng.normal(size=(3, 3))
        M = (M + M.T) / 2
        return M - np.trace(M) / 3 * np.eye(3)

    worst = -np.inf
    for _ in range(trials):
        U, V = ts(), ts()
        worst = max(worst, np.trace(U @ V @ V) - np.linalg.norm(U) / np.sqrt(6) * np.sum(V * V))
    print(f"2. max of tr(U V^2) - (|U|/sqrt6)|V|^2 over {trials} pairs: {worst:.3e}"
          "  <- must be <= 0, and it is not tight on random pairs")


def vc_sign():
    """<V,C> from C's Lagrange form, at batch 28's two recorded critical points."""
    U = np.diag([3.0, 1.0, -4.0])
    need = 2 * BETA * np.linalg.norm(U) / np.sqrt(6)
    print(f"3. batch 18 needs mu >= {need:.4f} at a global maximum")
    for mu, a1, a2 in [(-6.06130, 1.58669, 2.22137), (-24.43870, 11.77482, 16.48475)]:
        V = np.array([[a1, 0.0, 1.0], [0.0, a2, 1.0], [1.0, 1.0, -a1 - a2]])
        vc = mu * np.sum(V * V) - 2 * BETA * np.trace(U @ V @ V)
        print(f"   mu = {mu:10.5f} (fails that bound, so NOT a maximum): <V,C> = {vc:12.4f}")
    print("   both signs occur, so <V,C> >= 0 is a real condition at a maximum,")
    print("   and batch 18 already implies it in two lines, so it adds nothing.")


if __name__ == "__main__":
    identity_is_circular()
    rayleigh_cap()
    vc_sign()
