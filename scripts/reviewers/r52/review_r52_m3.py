"""R52 M3: is (S^3)^3 at n=9 exactly critical, and is it degenerate?
orbit dimension vs dim E(1/2) of L_e on Weyl_n."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')

def vertex_W(n, parts):
    prs, idx = K.pairs_of(n)
    which = {}; s = 0
    for bi, q in enumerate(parts):
        for i in range(s, s + q): which[i] = bi
        s += q
    lam = np.zeros(len(prs))
    for a, (i, j) in enumerate(prs):
        if which[i] == which[j]:
            na = parts[which[i]]; lam[a] = (n - na) / ((n - 1) * (na - 1))
        else:
            lam[a] = -1.0 / (n - 1)
    return np.diag(lam / np.linalg.norm(lam))

def analyse(n, parts):
    t0 = time.time()
    W = vertex_W(n, parts)
    th = K.P_val(n, W)
    res = np.linalg.norm(K.Q(n, W) - th * W)
    e = W / th
    M = K.Le_matrix(n, e)
    M = 0.5 * (M + M.T)
    ev = np.linalg.eigvalsh(M)
    dimE = int((np.abs(ev - 0.5) < 1e-8).sum())
    dim1 = int((np.abs(ev - 1.0) < 1e-8).sum())
    T = K.orbit_tangent(n, W)
    orb = K.orth_rank(T)
    # is the orbit tangent inside E(1/2)?
    U = K.orth_rows(T)
    B = K.weyl_basis(n)
    d = B.shape[0]
    coord = np.array([[float(np.tensordot(b, u.reshape(W.shape))) for b in B] for u in U])
    resid = np.linalg.norm(coord @ M.T - 0.5 * coord) / max(np.linalg.norm(coord), 1e-30)
    w_, V_ = np.linalg.eigh(M)
    E = V_[:, np.abs(w_ - 0.5) < 1e-8]
    # principal cosines orbit vs E(1/2)
    Uo, _ = np.linalg.qr(coord.T)
    cos = np.linalg.svd(Uo.T @ E, compute_uv=False)
    log(f"  {parts} n={n}: dimWeyl={d} theta={th:.9f} (th/th0={th/K.theta0(n):.6f}) resid={res:.1e}")
    log(f"      lam_max(L_e)={ev[-1]:.9f}  mult(1)={dim1}  dim E(1/2)={dimE}  orbit={orb} "
        f"excess={dimE-orb}  orbit-in-E(1/2) resid={resid:.1e}  min princ cos={cos.min():.9f} "
        f"[{time.time()-t0:.1f}s]")
    top = sorted(set(np.round(ev, 9)))[-6:]
    log(f"      top distinct L_e eigenvalues: {top}")
    return dict(n=n, parts=parts, th=th, dimE=dimE, orb=orb)

if __name__ == '__main__':
    log("PHASE 4 M3: (S^3)^3 criticality + degeneracy")
    analyse(9, (3, 3, 3))
    log("  controls (two-block, known nondegenerate except (3,3)):")
    analyse(9, (4, 5))
    analyse(8, (4, 4))
    analyse(6, (3, 3))
    log("  other multi-block:")
    analyse(8, (2, 3, 3))
    analyse(10, (2, 4, 4))
    log("PHASE 4 M3 done")
