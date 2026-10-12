"""Reviewer 63 -- adversarial global maximisation of C4's G on the two-negative stratum.

Maximise G(lam) over: k positives >= 0, two negatives -b <= -c < 0,
sum lam = 0, ||lam|| = 1.  Target: is sup G = sqrt(3/2) = 1.2247448713915889 ?
"""
import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')[0])
from scipy.optimize import minimize
from review_r63_G import G_closed, G, G_grad

TARGET = np.sqrt(1.5)

def unpack(x, k):
    p = x[:k]; b = x[k]; c = x[k+1]
    return p, b, c

def obj(x, k):
    p, b, c = unpack(x, k)
    return -G_closed(p, b, c)

def cons(k):
    return [
        {'type':'eq', 'fun': lambda x: float(np.sum(x[:k]) - x[k] - x[k+1])},
        {'type':'eq', 'fun': lambda x: float(np.sum(x**2) - 1.0)},
    ]

def maximise(k, ntrial, rng, seed_pts=None):
    best = (-1e9, None)
    starts = []
    if seed_pts: starts += list(seed_pts)
    for _ in range(ntrial):
        p = rng.random(k)**rng.uniform(0.2, 4.0)
        b, c = np.sort(rng.random(2)+1e-3)[::-1]
        p = p*(b+c)/p.sum()
        x = np.concatenate([p, [b, c]]); x = x/np.linalg.norm(x)
        starts.append(x)
    for x0 in starts:
        r = minimize(obj, x0, args=(k,), constraints=cons(k),
                     bounds=[(0, None)]*(k+2), method='SLSQP',
                     options={'maxiter':500, 'ftol':1e-12})
        if -r.fun > best[0]:
            best = (-r.fun, r.x.copy())
    return best

if __name__ == '__main__':
    rng = np.random.default_rng(int(sys.argv[1]) if len(sys.argv)>1 else 2024)
    kmax = int(sys.argv[2]) if len(sys.argv)>2 else 9
    ntr  = int(sys.argv[3]) if len(sys.argv)>3 else 200
    print('TARGET sqrt(3/2) = %.15f'%TARGET, flush=True)
    for k in range(1, kmax+1):
        v, x = maximise(k, ntr, rng)
        p, b, c = unpack(x, k)
        ordp = np.sort(p)[::-1]
        print('k=%d  max G = %.12f   excess = %+.3e   argmax pos=%s  b=%.6f c=%.6f  #(pos>1e-6)=%d'
              %(k, v, v-TARGET, np.array2string(ordp, precision=6), b, c, int(np.sum(p>1e-6))), flush=True)
