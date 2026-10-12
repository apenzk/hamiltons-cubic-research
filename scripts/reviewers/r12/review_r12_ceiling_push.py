"""Reviewer 12: recover the theta = 0.906672 ungraded record point, verify it,
and push the ungraded ceiling further with pinned-then-released LM around the
known ungraded cluster."""
import numpy as np
from scipy.optimize import least_squares
import sys
sys.path.insert(0, 'scripts/lib')
from review_r12_independent import (Alg, weyl_basis, catalogue, unit,
                                    audit_point, lm_polish, log, SQ32)

A, cat = catalogue(8)
Bw = weyl_basis(A)
Bflat = Bw.reshape(Bw.shape[0], -1)
wit = None
for lab, W0 in cat:
    if lab == 'wit_0.9008':
        wit = unit(np.asarray(W0, float))

bases = [("wit", wit)]
try:
    bases.append(("breaker", unit(np.load('agent_logs/review_r12_rhs_breaker_n8.npy'))))
except Exception:
    pass

rng = np.random.default_rng(31415)
records = {}
best = (0.0, None)
for th_t in (0.905, 0.907, 0.91, 0.915, 0.92, 0.93, 0.95):
    for s in range(16):
        blab, B0 = bases[s % len(bases)]
        x0 = Bflat @ B0.reshape(-1)
        x0 = x0 + (0.06 + 0.18 * rng.random()) * rng.normal(size=Bw.shape[0])
        x0 /= np.linalg.norm(x0)
        def F(x):
            W = np.einsum('d,dab->ab', x, Bw)
            nr = np.linalg.norm(W)
            if nr < 1e-12:
                return np.full(A.N * A.N, 1e3)
            return (A.Q(W / nr) - th_t * (W / nr)).reshape(-1)
        r = least_squares(F, x0, method='lm', xtol=1e-14, ftol=1e-14,
                          max_nfev=1000)
        W = unit(np.einsum('d,dab->ab', r.x, Bw))
        W = lm_polish(A, Bw, 0.5 * (W + W.T), max_nfev=3000)
        a = audit_point(A, W)
        if a['res'] > 1e-12 or abs(a['th']) < 1e-3:
            continue
        graded = max(a['T1'], 2 * a['T2'], a['T3']) < 1e-8
        key = round(a['th'], 6)
        if key not in records:
            records[key] = graded
            if not graded and a['th'] > 0.898:
                log(f"CEIL: th={a['th']:.9f} UNGRADED S={a['S']:.4f} "
                    f"rhs={a['rhs']:.6f} d2={a['d2']:.5f} K={a['K']:.4f} "
                    f"res={a['res']:.1e} (from {blab}, th_t={th_t})")
        if not graded and a['th'] > best[0]:
            best = (a['th'], a)
if best[1] is not None:
    a = best[1]
    np.save('agent_logs/review_r12_ungraded_record_n8.npy', a['W'])
    ev = np.sort(np.linalg.eigvalsh(a['W']))
    log(f"CEIL: RECORD ungraded th = {a['th']:.9f}, rhs = {a['rhs']:.6f}, "
        f"margin to sqrt(3/2) = {SQ32 - a['rhs']:.6f}, saved "
        f"agent_logs/review_r12_ungraded_record_n8.npy")
    log(f"CEIL: record spectrum = {np.round(ev, 6).tolist()}")
    log(f"CEIL: record T1={a['T1']:.5f} 2T2={2*a['T2']:.5f} T3={a['T3']:.5f} "
        f"decomp dev={a['S']-(a['T1']+2*a['T2']+a['T3']):.1e} "
        f"lemB={a['lemB']:.1e} ricW={a['ricW']:.1e} altW={a['altW']:.1e}")
log("CEIL: done")
