# R39's spread envelope: phi_r(q) = max kappa_r(x) over unit x in so(12) with sum_i s_i^4 = q (s = angles),
# then its concave upper hull. kappa_r = sum of the top r eigenvalues of -ad_x^2. Screen: SLSQP from many starts
# at each grid value of q. Writes agent_logs/spread_envelope.npz with q grid, phi[r, q] and the hull.
import numpy as np, time
from scipy.optimize import minimize
n = 12; H = 6
def spec(s):
    ev = []
    for i in range(H):
        for j in range(i+1, H): ev += [(s[i]+s[j])**2]*2 + [(s[i]-s[j])**2]*2
    ev += [0.0]*(n*(n-1)//2 - len(ev)); return np.sort(ev)[::-1]
Q = np.linspace(1/6, 1, 41); R = np.arange(1, 61); phi = np.zeros((len(R), len(Q)))
rng = np.random.default_rng(0); t0 = time.time()
cons = lambda q: [{'type': 'eq', 'fun': lambda s: np.sum(s**2)-1}, {'type': 'eq', 'fun': lambda s, q=q: np.sum(s**4)-q}]
for j, q in enumerate(Q):
    starts = [rng.random(H) for _ in range(40)]
    for ri, r in enumerate(R):
        best = 0.0
        for s0 in starts:
            s0 = s0/np.linalg.norm(s0)
            res = minimize(lambda s: -spec(np.abs(s))[:r].sum(), s0, constraints=cons(q), method='SLSQP', options={'maxiter': 300})
            if res.success and abs(np.sum(res.x**4)-q) < 1e-6: best = max(best, -res.fun)
        phi[ri, j] = best
    print(f'q={q:.3f} done {time.time()-t0:.0f}s  kappa_2 max {phi[1,j]:.3f} kappa_12 max {phi[11,j]:.3f} kappa_30 max {phi[29,j]:.3f}', flush=True)
# concave upper hull in q, per r
hull = np.zeros_like(phi)
for ri in range(len(R)):
    pts = list(zip(Q, phi[ri])); up = []
    for p in pts:
        while len(up) >= 2 and (up[-1][1]-up[-2][1])*(p[0]-up[-2][0]) <= (p[1]-up[-2][1])*(up[-1][0]-up[-2][0]): up.pop()
        up.append(p)
    hull[ri] = np.interp(Q, [u[0] for u in up], [u[1] for u in up])
np.savez(__file__.rsplit('/',1)[0] + '/../../agent_logs/spread_envelope.npz', Q=Q, R=R, phi=phi, hull=hull)
print('DONE')
