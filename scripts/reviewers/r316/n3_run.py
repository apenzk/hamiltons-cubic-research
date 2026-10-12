import sys, time
sys.path.insert(0, 'scripts/reviewers/r316')
import numpy as np
from n3_slice import Slice, ascend, certify

def run(n, a, ntrial, seed=0, log=None):
    sl = Slice(n, a); VB = sl.basisV()
    print(f"n={n} pair ({a},{n-a}) dim V={VB.shape[0]}", flush=True)
    rng = np.random.default_rng(seed)
    recs = []
    t0 = time.time()
    for t in range(ntrial):
        M = rng.normal(size=(sl.alg.N, sl.alg.N)); M = M + M.T
        W = sl.PV(M); W /= np.linalg.norm(W)
        W, P, gn = ascend(sl, W)
        th, res, lmax, spec = certify(sl, W, VB)
        recs.append((th, res, lmax, gn, spec))
        if (t + 1) % 25 == 0:
            print(f"  {t+1}/{ntrial} {time.time()-t0:.0f}s", flush=True)
    return sl, VB, recs

if __name__ == '__main__':
    n = int(sys.argv[1]); a = int(sys.argv[2]); nt = int(sys.argv[3])
    sl, VB, recs = run(n, a, nt, seed=int(sys.argv[4]) if len(sys.argv) > 4 else 0)
    th_eq = sl.P(sl.Weq)
    print(f"\nequivariant theta = {th_eq:.9f}")
    ths = np.array([r[0] for r in recs]); lm = np.array([r[2] for r in recs])
    res = np.array([r[1] for r in recs]); gn = np.array([r[3] for r in recs])
    order = np.argsort(-ths)
    seen = []
    for i in order:
        th = ths[i]
        if not any(abs(th - s) < 1e-7 for s in seen):
            seen.append(th)
    print("distinct theta values among ascent limits (desc):")
    for s in seen:
        idx = [i for i in range(len(recs)) if abs(ths[i] - s) < 1e-7]
        print(f"  theta={s:.9f}  count={len(idx)}  lam_max(L_e|V,Wperp)={lm[idx].max():.9f}"
              f"  localmax={'YES' if lm[idx].max() < 0.5 - 1e-7 else ('DEGEN' if lm[idx].max()<0.5+1e-7 else 'NO')}"
              f"  full-space crit resid={res[idx].max():.2e} gradnorm={gn[idx].max():.1e}")
    print(f"\nsummary: {len(seen)} distinct theta among {len(recs)} ascents; "
          f"max theta found={ths.max():.9f} vs equivariant {th_eq:.9f}")
