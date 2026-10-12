# I73 (c): the single-vector exclusion. A three-value critical point needs, for EVERY eigenspace E_c, some unit x
# whose per-vector system (L244 (i), with union Ky Fan caps) allows theta. So if sup over angle types of the
# per-vector ceiling in E_c is below theta, the spectrum is excluded outright. Screen: sampled sup per class
# (a lower bound on the true sup), then Nelder-Mead from many starts to confirm each class it flags.
# Usage: UNION=1 python3 screen_I73c_single_vector_exclusion.py <screen log> [theta]
import os, sys, re, ast, time, numpy as np
from scipy.optimize import minimize
os.environ['UNION'] = '1'
here = __file__.rsplit('/', 1)[0]
exec(open(here + '/screen_I73c_per_vector_ceiling.py').read().split("if __name__ == '__main__':")[0])
n = 12; th = float(sys.argv[2]) if len(sys.argv) > 2 else 1.2361
def spectrum(m, frac):
    a = m[1]*frac+m[2]; b = -m[0]-m[1]+m[1]*frac; s = -b/a; t = -1+frac*(s+1)
    d = np.array([-1.0, t, s]); return list(d/np.sqrt(np.dot(m, d**2)))
pts = []
for l in open(sys.argv[1]):
    if l.startswith('FEASIBLE'):
        m = ast.literal_eval(re.search(r'\(.*?\)', l).group(0))
        for fr in ast.literal_eval(re.search(r'\[.*\]', l).group(0)): pts.append((m, fr))
rng = np.random.default_rng(0)
samples = [np.array(k, float) for k in ([1,0,0,0,0,0],[1,1,0,0,0,0],[3,1,1,1,0,0],[2,1,1,0,0,0],[1,1,1,0,0,0],[1,1,1,1,1,1])]
for t in range(150):
    s = np.abs(rng.standard_normal(6))**rng.uniform(0.5, 4); samples.append(np.sort(s/np.linalg.norm(s))[::-1])
t0 = time.time(); excluded = []
for k, (m, fr) in enumerate(pts):
    L = spectrum(m, fr); flag = None
    for c in range(3):
        sup = max(theta_max(s, n, L, list(m), c) for s in samples)
        if sup < th:
            f = lambda s: -theta_max(np.abs(s)+1e-12, n, L, list(m), c)
            for r in range(25):
                sup = max(sup, -minimize(f, rng.random(6), method='Nelder-Mead', options={'maxiter': 2000}).fun)
                if sup >= th: break
            if sup < th: flag = (c, round(sup, 4)); break
    if flag: excluded.append((m, fr, flag)); print('EXCLUDED', m, fr, 'class', flag[0], 'sup ceiling', flag[1], flush=True)
    if k % 20 == 0: print(f'progress {k}/{len(pts)} {time.time()-t0:.0f}s', flush=True)
print(f'DONE: {len(excluded)} of {len(pts)} survivor points excluded by a single eigenspace at theta={th}, {time.time()-t0:.0f}s')
