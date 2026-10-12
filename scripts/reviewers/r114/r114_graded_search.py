"""Targeted search for GRADED critical points at n=6 inside each involution-invariant subspace.
Gradedness w.r.t. the involution g is the SIGN condition: W|Lambda^2_+ > 0, W|Lambda^2_- < 0.
Penalised least squares drives the sign violations to zero while enforcing criticality; the
result is accepted only if the true (unpenalised) criticality residual is <=1e-12 AND the
record's full grading test passes."""
import numpy as np, sys, os, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r114_core import *
from r114_four import invol, invariant_basis, S, n
from scipy.optimize import least_squares

name = sys.argv[1]; NST = int(sys.argv[2]); seed = int(sys.argv[3])
D = invol(name); C, _ = invariant_basis(D)
d = C.shape[0]; plus = np.diag(D) > 0
M_of = lambda x: np.einsum('k,kab->ab', x, C)

def blocks(M):
    return (np.linalg.eigvalsh(M[np.ix_(plus, plus)]),
            np.linalg.eigvalsh(M[np.ix_(~plus, ~plus)]))

def resid(x, mu):
    M = M_of(x); th = S.theta(M)
    r = np.einsum('kab,ab->k', C, S.Q(M) - th*M)
    ea, eb = blocks(M)
    if th < 0: ea, eb = -eb, -ea
    pen = np.concatenate([np.maximum(0.0, 0.02 - ea), np.maximum(0.0, 0.02 + eb)])
    return np.concatenate([r, [np.sum(x*x) - 1.0], mu*pen])

rng = np.random.default_rng(seed)
found = []
for t in range(NST):
    x = rng.standard_normal(d); x /= np.linalg.norm(x)
    for mu in (3.0, 1.0, 0.3, 0.0):
        s = least_squares(resid, x, args=(mu,), xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=6000)
        x = s.x
    M = M_of(x); M /= np.linalg.norm(M); th = S.theta(M)
    if th < 0: M, th = -M, -th
    fr = np.linalg.norm(S.Q(M) - th*M)
    if fr > 1e-12: continue
    rep = grading_report(S, M, tol=1e-9)
    ev = np.linalg.eigvalsh(M); gap = min(abs(e) for e in ev if abs(e) > 1e-9)
    ea, eb = blocks(M)
    wrong = int((ea < 0).sum() + (eb > 0).sum())
    if rep['graded_kerfree'] or wrong == 0:
        found.append((float(th), float(gap), rep['dim_h'], rep['dim_m'], bool(rep['graded_kerfree'])))
        print(f"[{name}] GRADED theta={th:.9f} gap={gap:.6e} dims {rep['dim_h']}/{rep['dim_m']} "
              f"S={float(rep['S']):.2e} Thhm={float(rep['T']['hhm']):.2e}", flush=True)
    if (t+1) % 25 == 0:
        print(f"[{name}] {t+1}/{NST} graded found={len(found)}", flush=True)
u = sorted(set((round(a,9), round(b,9), c, dd, e) for a,b,c,dd,e in found))
print(f"[{name}] DONE distinct graded: {len(u)}")
for z in u: print("   ", z)
