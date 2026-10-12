"""Claim 4: solve the joint both-sided relaxation independently, and try to beat it.

R(t) = max over vertex-class K with ||K||_F^2 = t of
         3/2 * max{p3(x) : sum x=0, ||x||^2=1, x > d_phi(K)}
       - 1/2 * min{p3(y) : sum y=0, ||y||^2=3, y > d(K)}
Sorted-descending parametrisation makes majorization linear.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from scipy.optimize import minimize
from scipy.linalg import null_space

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

class Cell:
    def __init__(self, n, t):
        self.n, self.t = n, t
        self.basis, self.prs = C.vertex_space_basis(n)
        self.nk = self.basis.shape[1]
        self.D = n*(n-1)//2
        self.N = n*(n+1)//2 - 1
    def K(self, c):
        K = C.K_from_coords(c, self.basis, self.prs, self.n)
        nk = np.linalg.norm(K)
        return K*np.sqrt(self.t)/max(nk, 1e-300)
    def diag(self, c):
        K = self.K(c)
        dphi, d, nu = C.diagonals_from_K(K)
        return np.sort(dphi)[::-1], np.sort(d)[::-1]

def unpack(z, cell):
    nk, D, N = cell.nk, cell.D, cell.N
    return z[:nk], z[nk:nk+D], z[nk+D:]

def obj(z, cell):
    c, x, y = unpack(z, cell)
    return -(1.5*np.sum(x**3) - 0.5*np.sum(y**3))

def build_cons(cell):
    nk, D, N = cell.nk, cell.D, cell.N
    def eqs(z):
        c, x, y = unpack(z, cell)
        return np.array([np.sum(x), np.sum(x**2)-1.0, np.sum(y), np.sum(y**2)-3.0])
    def ineqs(z):
        c, x, y = unpack(z, cell)
        cp, dd = cell.diag(c)
        return np.concatenate([
            x[:-1]-x[1:], y[:-1]-y[1:],
            np.cumsum(x)[:-1]-np.cumsum(cp)[:-1],
            np.cumsum(y)[:-1]-np.cumsum(dd)[:-1],
        ])
    return [dict(type='eq', fun=eqs), dict(type='ineq', fun=ineqs)]

def feas_report(z, cell):
    c, x, y = unpack(z, cell)
    cp, dd = cell.diag(c)
    e = np.array([np.sum(x), np.sum(x**2)-1.0, np.sum(y), np.sum(y**2)-3.0])
    i = np.concatenate([x[:-1]-x[1:], y[:-1]-y[1:],
                        np.cumsum(x)[:-1]-np.cumsum(cp)[:-1],
                        np.cumsum(y)[:-1]-np.cumsum(dd)[:-1]])
    return np.abs(e).max(), i.min()

def start(cell, rng, mode, Kseed=None):
    nk, D, N = cell.nk, cell.D, cell.N
    if Kseed is not None:
        # exact coordinates of a supplied K in the vertex basis
        v = np.array([Kseed[i, j] for (i, j) in cell.prs])
        c = cell.basis.T @ v
    else:
        c = rng.standard_normal(nk)
    cp, dd = cell.diag(c)
    if mode == 'scaled':
        x = cp*np.sqrt(1.0/max(np.linalg.norm(cp), 1e-12))**2
        x = cp/np.linalg.norm(cp) if np.linalg.norm(cp) > 0 else rng.standard_normal(D)
        y = dd/np.linalg.norm(dd)*np.sqrt(3.0)
    elif mode == 'okumura':
        a = 1.0/np.sqrt(D*(D-1)); x = np.full(D, -a); x[0] = (D-1)*a
        b = np.sqrt(3.0/(N*(N-1))); y = np.full(N, b); y[-1] = -(N-1)*b
    else:
        x = np.sort(rng.standard_normal(D))[::-1]; x -= x.mean(); x /= np.linalg.norm(x)
        y = np.sort(rng.standard_normal(N))[::-1]; y -= y.mean(); y *= np.sqrt(3)/np.linalg.norm(y)
    return np.concatenate([c, x, y])

def solve(n, t, nstart=120, seed=0, Kseeds=()):
    cell = Cell(n, t); cons = build_cons(cell); rng = np.random.default_rng(seed)
    best, bz = -9e9, None
    starts = []
    for Ks in Kseeds:
        for m in ('scaled', 'okumura', 'rand'):
            starts.append(start(cell, rng, m, Kseed=Ks))
    for k in range(nstart):
        starts.append(start(cell, rng, ('scaled', 'okumura', 'rand')[k % 3]))
    for z0 in starts:
        try:
            r = minimize(obj, z0, args=(cell,), constraints=cons, method='SLSQP',
                         options=dict(maxiter=500, ftol=1e-10))
        except Exception:
            continue
        eq, iq = feas_report(r.x, cell)
        if eq < 1e-7 and iq > -1e-7:
            val = -obj(r.x, cell)
            if val > best: best, bz = val, r.x.copy()
    return best, bz, cell

if __name__ == '__main__':
    import json
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
    # seed the outer K search with the balanced sphere product's own vertex matrix
    def balanced_vertex(m):
        nn = 2*m; a = 1.0/np.sqrt((m-1)*(2*m-1)); b = -(m-1)*a/m
        K = np.full((nn, nn), b); K[:m, :m] = a; K[m:, m:] = a; np.fill_diagonal(K, 0.0); return K
    Kseeds = [balanced_vertex(n//2)] if n % 2 == 0 else []
    print(f"n={n}  theta0={theta0(n):.6f}")
    print(f" {'t':>6} {'R(t)':>10} {'/theta0':>8}   feas(eq,ineq)")
    out = {}
    for t in (0.05, 0.1, 0.25, 0.5, 1.0, 1.5, 1.9, 1.99, 2.0):
        v, z, cell = solve(n, t, nstart=150, seed=1234+int(t*1000), Kseeds=Kseeds)
        eq, iq = feas_report(z, cell) if z is not None else (np.nan, np.nan)
        out[t] = v
        print(f" {t:>6} {v:>10.4f} {v/theta0(n):>8.3f}   ({eq:.1e}, {iq:+.1e})")
    print(json.dumps({str(k): v for k, v in out.items()}))
