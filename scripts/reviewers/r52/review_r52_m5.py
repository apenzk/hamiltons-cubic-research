"""R52 M5 + the logical test behind M4: does a LARGE slack keep a point away
from {S=0}?  S is only lower semicontinuous, so it jumps; demonstrate directly."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K
import review_r52_cp2 as CP
import review_r52_slack as SL

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')

RNG = np.random.default_rng(777)


def degeneracy(n, W, tag):
    th = K.P_val(n, W)
    res = np.linalg.norm(K.Q(n, W) - th * W)
    M = K.Le_matrix(n, W / th); M = 0.5 * (M + M.T)
    ev = np.linalg.eigvalsh(M)
    dimE = int((np.abs(ev - 0.5) < 1e-8).sum())
    orb = K.orth_rank(K.orbit_tangent(n, W))
    log(f"  {tag:>26} n={n:3d} th={th:.9f} th/th0={th/K.theta0(n):.4f} res={res:.1e} "
        f"S_struct={K.slack_structural(n,W):9.3f} S_theta={K.slack_theta_formula(n,W,th):9.6f} "
        f"orbit={orb:4d} dimE(1/2)={dimE:4d} excess={dimE-orb:4d} lam_max={ev[-1]:.6f}")


if __name__ == '__main__':
    log("PHASE 7 M5: what remains untested + the semicontinuity test")
    log(" (a) subalgebra-family members that are NOT block products:")
    degeneracy(8, SL.casimir_W(8, SL.su3_ad_gens())[0], "su(3) adjoint")
    degeneracy(10, SL.casimir_W(10, SL.so_ad_gens(5))[0], "so(5) adjoint")
    log(" (b) three/four-block products, degeneracy (the untested-scope item):")
    for n, parts in [(9, (3, 3, 3)), (12, (4, 4, 4)), (12, (3, 3, 3, 3)),
                     (12, (2, 5, 5)), (10, (2, 4, 4)), (8, (2, 3, 3))]:
        degeneracy(n, SL.sphere_multi_vertex(n, parts), f"S{'xS'.join(map(str,parts))}")
    log(" (c) the semicontinuity test: S at random perturbations of an S=0 point.")
    for n, name, W in [(8, "W_CP2 padded", CP.cp2_padded(8) / np.linalg.norm(CP.cp2_padded(8))),
                       (8, "S^4xS^4", SL.sphere_multi_vertex(8, (4, 4)))]:
        B = K.weyl_basis(n)
        for eps in (1e-6, 1e-3):
            vals = []
            for _ in range(60):
                d = sum(v * b for v, b in zip(RNG.standard_normal(len(B)), B))
                d /= np.linalg.norm(d)
                Wp = W + eps * d
                Wp /= np.linalg.norm(Wp)
                vals.append(K.slack_structural(n, Wp))
            log(f"  {name} n={n} eps={eps:.0e}: S_struct over 60 perturbations "
                f"min={min(vals):.4f} median={np.median(vals):.4f} max={max(vals):.4f}")
    log("PHASE 7 M5 done")
