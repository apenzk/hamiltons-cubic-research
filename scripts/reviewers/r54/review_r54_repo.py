"""Run the REPOSITORY's own C_5 code (b_c5_blowup, b_c5_openness) and compare.

b_c5_openness.run() drives 60 Levenberg-Marquardt corrections with a NUMERIC Jacobian
over a 770-dimensional parameter vector, i.e. 771 residual evaluations per Jacobian;
that is hours per correction on this machine, so the loop is run here over a small
sample of the same directions and distances rather than all 60.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import b_c5_blowup, b_c5_openness
from review_r30_core import pair_index, adj, Q as Qrepo
from b_padded_s3s3 import slack as repo_slack
from review_r54_core import slack_structural, P as Pmine, Q as Qmine, theta0

print("--- repository b_c5_blowup ---", flush=True)
Wr, nr = b_c5_blowup.c5_operator([2]*5)
thr = float(np.tensordot(Wr, Qrepo(nr, Wr)))
Nr = nr*(nr-1)//2
print(f"  theta={thr:.9f}  resid={np.linalg.norm(Qrepo(nr,Wr)-thr*Wr):.1e} "
      f"ratio={thr/theta0(nr):.7f}")
print(f"  repo slack (adjoint scale) = {repo_slack(nr, Wr, adj(nr), Nr):.3e}; "
      f"/(n-2)^2 = {repo_slack(nr, Wr, adj(nr), Nr)/(nr-2)**2:.3e}; "
      f"my structural = {slack_structural(nr, Wr):.3e}")
print(f"  my Q vs repo Q on this W: {np.abs(Qmine(nr,Wr)-Qrepo(nr,Wr)).max():.2e}")

print("\n--- repository b_c5_openness.setup() ---", flush=True)
t0 = time.time()
W, n, N, A, Bb, Bf, exc, th = b_c5_openness.setup()
print(f"  theta={th:.9f}  excess directions={exc.shape[1]}  dim Weyl={len(Bb)}  "
      f"({time.time()-t0:.0f}s)")

print("\n--- repository corrector, sampled (same residual, same LM settings) ---", flush=True)
tens = lambda c: np.einsum('d,dij->ij', c, Bb)
c0 = Bf @ W.ravel()
def resid(c):
    Wc = tens(c); QW = Qrepo(n, Wc); t = float(np.tensordot(Wc, QW))
    r = Bf @ (QW - t*Wc).ravel()
    return np.append(r - (r @ c)*c, np.dot(c, c) - 1.0)
rng = np.random.default_rng(0)
recs = []
spec0 = np.sort(np.round(np.linalg.eigvalsh(W),6))
picks = list(range(exc.shape[1]))
print(f"{'dir':>5} {'t':>6} {'converged':>10} {'|resid|':>10} {'theta':>12} {'S(struct)':>11} "
      f"{'|dc|':>8} {'time':>7}")
for i in picks:
    for t in (0.05, 0.2, 0.4):
        c = c0 + t*exc[:, i]; c /= np.linalg.norm(c)
        t0 = time.time()
        sol = least_squares(resid, c, method='lm', xtol=1e-15, ftol=1e-15,
                            gtol=1e-15, max_nfev=20000)
        rn = np.linalg.norm(resid(sol.x))
        Wn = tens(sol.x); Wn /= np.linalg.norm(Wn)
        thn = float(np.tensordot(Wn, Qrepo(n, Wn)))
        if thn < 0: Wn, thn = -Wn, -thn
        S = repo_slack(n, Wn, A, N)/(n-2)**2
        cn = Bf @ Wn.ravel()
        if cn @ c0 < 0: cn = -cn
        print(f"{i:>5} {t:>6.2f} {str(rn<1e-5):>10} {rn:>10.1e} {thn:>12.6f} {S:>11.4f} "
              f"{np.linalg.norm(cn-c0):>8.4f} {time.time()-t0:>6.0f}s", flush=True)
        recs.append((i, t, rn < 1e-5, thn, S, float(np.linalg.norm(cn-c0)), np.sort(np.round(np.linalg.eigvalsh(Wn),6))))

nconv = sum(1 for r in recs if r[2])
print(f"\nSUMMARY over {len(recs)} corrections: converged {nconv}, not converged {len(recs)-nconv}")
if nconv:
    print(f"  theta values: {sorted(set(round(r[3],6) for r in recs if r[2]))}")
    print(f"  S values:     {sorted(set(round(r[4],4) for r in recs if r[2]))}")
    print(f"  max |dc| = {max(r[5] for r in recs if r[2]):.4f}")
    same = sum(1 for r in recs if r[2] and np.allclose(r[6], spec0, atol=3e-5))
    print(f"  SAME SPECTRUM as the base point (a conjugation invariant): {same} of {nconv}")
