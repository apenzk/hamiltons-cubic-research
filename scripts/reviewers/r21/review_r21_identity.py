"""Reviewer 21: the identity that certifies the joint frontier as a GLOBAL maximum.

    (I)   P_ker Fbil( W1 , P_ker Q(W1) ) = 0     for every W1 in V_{1/3}.

With M_{W1} the matrix of  K -> P_ker Fbil(W1,K)  on ker F_u and q = P_ker Q(W1),
(I) says M q = 0, i.e. the linear term of the inner trust-region problem lies in
the kernel of its quadratic form.  Then, exactly,

    max_{|K|=1} <K,q> + t <K,M K> = a           if a >= 2 t lam
                                  = a^2/(4t lam) + t lam   otherwise,

a = |q|, lam = lam_max(M).  Both a <= sqrt(5/6) and lam <= 2/3 are suprema of the
project's two coupling constants, the right-hand side is nondecreasing in both,
and both are attained at the same W1* -- so the frontier is the true maximum.

Also checks the polarised (trilinear) form of (I) and the two suprema.
"""
import sys, time
import numpy as np
from review_r21_core import Setup, unit

n = int(sys.argv[1]); nsamp = int(sys.argv[2]) if len(sys.argv) > 2 else 40
S = Setup(n)
rng = np.random.default_rng(99)
t0 = time.time()

print("(I) cubic form:  || M_{W1} P_ker Q(W1) || / ||P_ker Q(W1)||   over random unit W1 in V13")
worst = 0.0
lam_max_seen = -9.0; a_max_seen = -9.0
for k in range(nsamp):
    y = unit(rng.normal(size=S.d13)); W1 = S.mat13(y)
    q = S.q_ker(W1); a = np.linalg.norm(q)
    M = S.block_fast(W1, S.Vker, S.Vker); M = 0.5 * (M + M.T)
    rel = np.linalg.norm(M @ q) / a
    worst = max(worst, rel)
    w = np.linalg.eigvalsh(M)
    lam_max_seen = max(lam_max_seen, w[-1]); a_max_seen = max(a_max_seen, a)
    if k < 6:
        print(f"   sample {k}: a={a:.6f} lam_max={w[-1]:.9f} lam_min={w[0]:.9f} rel={rel:.2e}", flush=True)
print(f"   worst over {nsamp} samples: {worst:.3e}   [{time.time()-t0:.0f}s]")
print(f"   (spot maxima over these random samples: a={a_max_seen:.6f}, lam_max={lam_max_seen:.6f})")

print("\n(I) polarised trilinear form: || P_ker Fbil(x, P_ker Fbil(y,z)) || on random V13 triples")
wp = 0.0
for k in range(12):
    xs = [S.mat13(unit(rng.normal(size=S.d13))) for _ in range(3)]
    inner = S.matker(S.f_ker(xs[1], xs[2]))
    v = S.f_ker(xs[0], inner)
    sc = np.linalg.norm(S.f_ker(xs[1], xs[2]))
    wp = max(wp, np.linalg.norm(v) / max(sc, 1e-300))
    if k < 4:
        print(f"   triple {k}: ||inner||={sc:.6f}  ||outer||/||inner||={np.linalg.norm(v)/max(sc,1e-300):.3e}")
print(f"   worst: {wp:.3e}  -> the UNsymmetrised trilinear identity {'HOLDS' if wp < 1e-10 else 'FAILS (only the symmetrised/cubic one holds)'}")

print("\nControl: the same quantity with W1 drawn from ker F_u instead of V13")
for k in range(3):
    Y = S.matker(unit(rng.normal(size=S.dker)))
    q = S.Vker.T @ S.coeff(S.Q(Y)); a = np.linalg.norm(q)
    M = S.block_fast(Y, S.Vker, S.Vker); M = 0.5 * (M + M.T)
    print(f"   ker sample {k}: ||M q||/||q|| = {np.linalg.norm(M@q)/a:.3e}")
print(f"[{time.time()-t0:.0f}s] done", flush=True)
