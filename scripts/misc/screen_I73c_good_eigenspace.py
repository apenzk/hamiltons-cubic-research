# R39, approved 2026-09-25 as a bounded screen (one hour in total): for a survivor spectrum and eigenspace E_c,
# maximise over m_c-dimensional subspaces V of so(12) the minimum over unit x in V of the per-vector ceiling
# (L244 (i) with union Ky Fan caps). A best minimum below theta_0 is evidence that no eigenspace of that
# dimension can be all good, i.e. the spectrum is excluded; at or above theta_0 exhibits a candidate V.
# Inner min: random samples + Nelder-Mead on the sphere of V. Outer: hill-climb by Givens rotations
# between V and its complement, restarts until the per-target time cap. Screen only.
import os, sys, time, json, numpy as np
from multiprocessing import Pool
from scipy.optimize import minimize
os.environ['UNION'] = '1'
here = __file__.rsplit('/', 1)[0]
exec(open(here + '/screen_I73c_per_vector_ceiling.py').read().split("if __name__ == '__main__':")[0])
n = 12; N = 66; TH0 = np.sqrt(220)/12; CAP = float(os.environ.get('CAP_SECONDS', '540'))
pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
def mat(c):
    X = np.zeros((n, n))
    for k, (i, j) in enumerate(pairs): X[i, j] = c[k]; X[j, i] = -c[k]
    return X
def angles(c):
    ev = np.sort(np.abs(np.linalg.eigvals(mat(c)).imag))[::-1]
    return ev[::2]
def spectrum(m, frac):
    a = m[1]*frac+m[2]; b = -m[0]-m[1]+m[1]*frac; s = -b/a; t = -1+frac*(s+1)
    d = np.array([-1.0, t, s]); return list(d/np.sqrt(np.dot(m, d**2)))
def job(target):
    m, frac, c = target; L = spectrum(m, frac); mc = m[c]; rng = np.random.default_rng(hash(tuple(m)) % 2**32)
    ceil = lambda coef: theta_max(angles(coef), n, L, list(m), c)
    def inner(U, nsamp=40, nm=120):
        best = (np.inf, None)
        for _ in range(nsamp):
            y = rng.standard_normal(mc); y /= np.linalg.norm(y); v = ceil(U @ y)
            if v < best[0]: best = (v, y)
        f = lambda y: ceil(U @ (y/np.linalg.norm(y))) if np.linalg.norm(y) > 1e-9 else 9.0
        r = minimize(f, best[1], method='Nelder-Mead', options={'maxiter': nm})
        return min(best[0], r.fun)
    t0 = time.time(); overall = -np.inf; restarts = 0
    while time.time()-t0 < CAP:
        U = np.linalg.qr(rng.standard_normal((N, mc)))[0]; cur = inner(U); restarts += 1
        step = 0.4
        while time.time()-t0 < CAP and step > 0.02:
            improved = False
            for _ in range(8):
                # rotate one direction of V towards a random direction of its complement
                a = rng.standard_normal(mc); a /= np.linalg.norm(a)
                w = rng.standard_normal(N); w -= U @ (U.T @ w); w /= np.linalg.norm(w)
                u = U @ a; Un = U + np.outer(np.cos(step)*u + np.sin(step)*w - u, a)
                Un = np.linalg.qr(Un)[0]; val = inner(Un)
                if val > cur: U, cur, improved = Un, val, True; break
            if not improved: step /= 2
        overall = max(overall, cur)
    return (m, frac, c, overall, restarts, time.time()-t0)
if __name__ == '__main__':
    targets = [((5,55,6),0.5,0), ((6,54,6),0.5,0), ((7,52,7),0.5,0), ((8,50,8),0.5,0),
               ((6,58,2),0.3,2), ((24,35,7),0.3,2), ((12,42,12),0.5,0)]
    print('targets', targets, 'cap per target', CAP, 's; theta_0 =', TH0, flush=True)
    with Pool(len(targets)) as p:
        for m, frac, c, best, rs, dt in p.imap_unordered(job, targets):
            print(f'{m} frac {frac} class {c} (m_c={m[c]}): best min ceiling over subspaces {best:.4f} '
                  f"{'< theta_0: no all-good eigenspace found' if best < TH0 else '>= theta_0: candidate eigenspace'}  ({rs} restarts, {dt:.0f}s)", flush=True)
    print('DONE')
