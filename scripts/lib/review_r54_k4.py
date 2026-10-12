"""K4: how high can theta/theta_0 go over blow-ups with a triangle-free negative graph?

Two layers.
(1) The n -> infinity CONTINUUM vertex system.  With n_a = f_a n and n -> infinity the
    block system has a finite limit: writing w_aa = d_a, w_ab = x_ab,
       Ricci   f_a d_a + sum_{c!=a} f_c x_ac = 0
       q_aa    = f_a d_a^2 + sum_{c!=a} f_c x_ac^2          = mu d_a
       q_ab    = (f_a d_a + f_b d_b) x_ab + sum_{c!=a,b} f_c x_ac x_bc = mu x_ab
       N0      = sum_a f_a^2 d_a^2 / 2 + sum_{a<b} f_a f_b x_ab^2 = 1,  mu = theta,
    and theta_0(n) -> sqrt(2), so the ratio in the limit is theta / sqrt(2).
    In the limit S = 0 reads: every d_a >= 0 and the graph {x_ab < 0} triangle-free.
(2) Finite n, the exact vertex system, for named graphs and for unequal blocks.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import itertools, sys
from math import comb
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_blocks import (Qmat, normsq, Pval, ricci, pack, unpack, residual,
                               triangles, effective_rows, theta0)

# ---------------- continuum limit ----------------

def lim_pack(d, x, k):
    return np.concatenate([d, [x[a, b] for a in range(k) for b in range(a+1, k)]])

def lim_unpack(z, k):
    d = z[:k]
    x = np.zeros((k, k)); t = k
    for a in range(k):
        for b in range(a+1, k):
            x[a, b] = x[b, a] = z[t]; t += 1
    return d, x

def lim_resid(z, f):
    k = len(f)
    d, x = lim_unpack(z[:-1], k)
    mu = z[-1]
    q = np.zeros((k, k))
    for a in range(k):
        q[a, a] = f[a]*d[a]**2 + sum(f[c]*x[a, c]**2 for c in range(k) if c != a)
        for b in range(a+1, k):
            q[a, b] = q[b, a] = (f[a]*d[a] + f[b]*d[b])*x[a, b] + \
                sum(f[c]*x[a, c]*x[b, c] for c in range(k) if c not in (a, b))
    r = [f[a]*d[a] + sum(f[c]*x[a, c] for c in range(k) if c != a) for a in range(k)]
    r += [q[a, a] - mu*d[a] for a in range(k)]
    r += [q[a, b] - mu*x[a, b] for a in range(k) for b in range(a+1, k)]
    N0 = sum(f[a]**2*d[a]**2/2 for a in range(k)) + \
         sum(f[a]*f[b]*x[a, b]**2 for a in range(k) for b in range(a+1, k))
    r.append(N0 - 1.0)
    return np.array(r)

def lim_rows(d, x, k):
    w = x.copy()
    for a in range(k):
        w[a, a] = d[a]
    return w

def lim_solve(f, starts=3000, seed=0):
    k = len(f); rng = np.random.default_rng(seed)
    out = []
    for _ in range(starts):
        z0 = np.append(rng.normal(size=k + k*(k-1)//2), rng.normal()*2)
        sol = least_squares(lim_resid, z0, args=(f,), xtol=1e-15, ftol=1e-15,
                            gtol=1e-15, max_nfev=4000)
        if np.linalg.norm(sol.fun) > 1e-10:
            continue
        d, x = lim_unpack(sol.x[:-1], k); mu = sol.x[-1]
        if mu < 0:
            d, x, mu = -d, -x, -mu
        if mu < 1e-8:
            continue
        w = lim_rows(d, x, k)
        key = np.round(np.sort(np.concatenate([np.sort(w.ravel()), [mu]])), 7)
        if not any(np.allclose(key, kk, atol=1e-5) for kk in out_keys(out)):
            out.append((w, mu))
    return out

def out_keys(out):
    for w, mu in out:
        yield np.round(np.sort(np.concatenate([np.sort(w.ravel()), [mu]])), 7)

def lim_triangle_free(w, tol=1e-9):
    k = w.shape[0]
    if any(w[a, a] < -tol for a in range(k)):
        return False
    neg = [(a, b) for a in range(k) for b in range(a+1, k) if w[a, b] < -tol]
    E = set(neg) | {(b, a) for a, b in neg}
    for a, b, c in itertools.combinations(range(k), 3):
        if (a, b) in E and (a, c) in E and (b, c) in E:
            return False
    return True

def connected_nonbipartite(w, tol=1e-9):
    k = w.shape[0]
    adjl = {a: [b for b in range(k) if b != a and w[a, b] < -tol] for a in range(k)}
    if any(len(v) == 0 for v in adjl.values()):
        return False, False
    seen = {0}; st = [0]
    while st:
        u = st.pop()
        for v in adjl[u]:
            if v not in seen:
                seen.add(v); st.append(v)
    conn = len(seen) == k
    col = {0: 0}; st = [0]; bip = True
    while st:
        u = st.pop()
        for v in adjl[u]:
            if v not in col:
                col[v] = 1 - col[u]; st.append(v)
            elif col[v] == col[u]:
                bip = False
    return conn, not bip

if __name__ == "__main__":
    print("=== continuum limit, equal blocks f_a = 1/k, sup over ALL solutions ===")
    print(f"{'k':>3} {'#sols':>6} {'best ratio (any)':>18} {'best ratio S=0':>16} "
          f"{'S=0 & conn & non-bip & k-block':>32}")
    for k in range(2, 9):
        f = np.ones(k)/k
        sols = lim_solve(f, starts=(200 if k <= 5 else 500), seed=k)
        rows = []
        for w, mu in sols:
            ratio = mu/np.sqrt(2.0)
            tf = lim_triangle_free(w)
            grp = effective_rows(w, tol=1e-5)
            genuine = len(grp) == k
            conn, nonbip = connected_nonbipartite(w)
            rows.append((ratio, tf, genuine, conn, nonbip, w, mu))
        any_best = max((r[0] for r in rows), default=float('nan'))
        s0_best = max((r[0] for r in rows if r[1]), default=float('nan'))
        strict = max((r[0] for r in rows if r[1] and r[2]), default=float('nan'))
        print(f"{k:>3} {len(sols):>6} {any_best:>18.6f} {s0_best:>16.6f} {strict:>32.6f}")
        for r in sorted(rows, key=lambda t: -t[0])[:3]:
            w = r[5]
            print(f"      ratio={r[0]:.6f} S=0:{r[1]!s:>5} k-block:{r[2]!s:>5} "
                  f"conn:{r[3]!s:>5} nonbip:{r[4]!s:>5}  w-rows={np.round(w[0],4)}")
