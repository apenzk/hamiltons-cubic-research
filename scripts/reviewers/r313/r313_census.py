"""M3 push: hunt for a non-diagonal Delta>0 critical point with lambda_max(L_e) <= 1/2."""
import sys, numpy as np, json, time
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m3 import defect, support_op, simple_ranks, gauss_newton

n = int(sys.argv[1]); nstart = int(sys.argv[2]); seed0 = int(sys.argv[3])
out = open(f"scripts/reviewers/r313/census_n{n}.jsonl","a")
best = 9.9
t0=time.time()
for s in range(seed0, seed0+nstart):
    rng = np.random.default_rng(s)
    x = rng.standard_normal(R.weyl_basis(n).shape[0]); x /= np.linalg.norm(x)
    Wp = R.from_coords(n, x)
    for _ in range(300):                      # power iteration onto Crit(P)
        Y = R.Qmap(n, Wp); nrm = np.linalg.norm(Y)
        if nrm < 1e-14: break
        Wn = Y/np.sqrt(np.tensordot(Y,Y,axes=2))
        if np.linalg.norm(Wn-Wp) < 1e-13: Wp = Wn; break
        Wp = Wn
    W = gauss_newton(n, Wp)
    res, th = R.crit_residual(n, W)
    if th < 0: W = -W; res, th = R.crit_residual(n, W)
    if res > 1e-12 or th < 1e-6: continue
    D, tot, ev, V, gs = defect(n, W)
    T = support_op(n, W); tev = np.linalg.eigvalsh(T)
    kerT = int((tev < 1e-9*tev[-1]).sum())
    sr = simple_ranks(n, W)
    lam, evec, evs, Cp, Lm = R.lam_max_perp(n, W, th)
    rec = dict(seed=s, theta=th, res=res, Delta=D, lam=lam, kerT=kerT, simple_ranks=sr,
               nondiag=bool([r for r in sr if r > 2]))
    out.write(json.dumps(rec)+"\n"); out.flush()
    if D > 1e-6 and rec['nondiag'] and lam < best:
        best = lam
        print(f"seed {s}: theta={th:.9f} Delta={D:.6f} lam={lam:.9f} kerT={kerT} ranks={sr}", flush=True)
print("done", nstart, "starts in", time.time()-t0, "s; best non-diagonal Delta>0 lam =", best, flush=True)
