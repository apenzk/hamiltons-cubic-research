import numpy as np
from core111 import Core
# Is the per-row identity a LINEAR identity on Weyl_n?  Test:
#   for every unit v in so(n),  Pi_Weyl( Psi(v) ) = 2 Pi_Weyl( v v^T ),
# where <M, Psi(v)> = -tr(M ad(v)^2) = sum_{a,b} <[v,phi_a],phi_b>^2-weighted form.
for n in (5, 6, 8):
    C = Core(n); c = C.struct(); rng = np.random.default_rng(7)
    worst = 0.0
    for _ in range(5):
        v = rng.standard_normal(C.D); v /= np.linalg.norm(v)
        Adv = np.einsum('g,gba->ab', v, c)      # Adv[a,b] = <[v,phi_b],phi_a>
        Psi = -(Adv @ Adv)                       # so <M,Psi> = -tr(M ad(v)^2)
        Psi = 0.5*(Psi+Psi.T)
        lhs = C.weyl_project(Psi)
        rhs = -2.0*C.weyl_project(np.outer(v, v))
        worst = max(worst, np.abs(lhs-rhs).max())
    print("n=%d  || Pi_W(Psi(v)) + 2 Pi_W(v v^T) ||_inf  = %.2e   (5 random unit v)" % (n, worst))
