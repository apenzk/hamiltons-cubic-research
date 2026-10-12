"""Reviewer 27: a wider subalgebra-family sweep -- graded and ungraded members alike."""
import sys
import numpy as np
from itertools import combinations
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M


def so3_irrep_real(L):
    """so(3) on real spherical harmonics of degree L, dim = 2L+1, via Gram-Schmidt on
    harmonic polynomials in 3 variables."""
    from itertools import product
    # monomials of degree L in x,y,z
    mons = [(a, b, L - a - b) for a in range(L + 1) for b in range(L + 1 - a)]
    midx = {m: i for i, m in enumerate(mons)}
    # inner product on polys: use the Bombieri/apolar product <x^a, x^a> = a! b! c! / L!
    from math import factorial
    def ip(m1, m2):
        if m1 != m2:
            return 0.0
        return factorial(m1[0]) * factorial(m1[1]) * factorial(m1[2]) / factorial(L)
    # harmonic subspace = kernel of the Laplacian
    rows = []
    lap_mons = [(a, b, L - 2 - a - b) for a in range(L - 1) for b in range(L - 1 - a)] if L >= 2 else []
    lidx = {m: i for i, m in enumerate(lap_mons)}
    Lap = np.zeros((len(lap_mons), len(mons)))
    for m in mons:
        a, b, c = m
        for (k, sh) in [(0, (a - 2, b, c)), (1, (a, b - 2, c)), (2, (a, b, c - 2))]:
            if min(sh) < 0:
                continue
            coef = [a * (a - 1), b * (b - 1), c * (c - 1)][k]
            Lap[lidx[sh], midx[m]] += coef
    if len(lap_mons) == 0:
        H = np.eye(len(mons))
    else:
        u, s, vt = np.linalg.svd(Lap)
        rk = int((s > 1e-9 * s.max()).sum())
        H = vt[rk:].T                       # (nmons, 2L+1)
    # metric on the monomial coordinates
    Gm = np.diag([ip(m, m) for m in mons])
    Gh = H.T @ Gm @ H
    w, V = np.linalg.eigh(Gh)
    Hor = H @ (V / np.sqrt(w))              # orthonormal harmonic basis
    # so(3) action: rotation generators as first-order operators
    gens = []
    for (p, q) in [(0, 1), (0, 2), (1, 2)]:
        Dm = np.zeros((len(mons), len(mons)))
        for m in mons:
            a = list(m)
            # (x_p d_q - x_q d_p)
            if a[q] > 0:
                t = a.copy(); t[q] -= 1; t[p] += 1
                Dm[midx[tuple(t)], midx[m]] += a[q]
            if a[p] > 0:
                t = a.copy(); t[p] -= 1; t[q] += 1
                Dm[midx[tuple(t)], midx[m]] -= a[p]
        M_ = Hor.T @ Gm @ Dm @ Hor
        gens.append(M_)
    for g in gens:
        assert np.abs(g + g.T).max() < 1e-9, np.abs(g + g.T).max()
    return gens


def gens_um(m):
    """u(m) inside so(2m):  realify m x m anti-hermitian matrices."""
    gens = []
    E = np.zeros((2 * m, 2 * m))
    for a in range(m):
        for b in range(m):
            if a < b:
                X = np.zeros((2 * m, 2 * m))          # real part: E_ab - E_ba on both copies
                X[2 * a, 2 * b] = 1; X[2 * b, 2 * a] = -1
                X[2 * a + 1, 2 * b + 1] = 1; X[2 * b + 1, 2 * a + 1] = -1
                gens.append(X)
                Y = np.zeros((2 * m, 2 * m))          # imaginary part
                Y[2 * a, 2 * b + 1] = 1; Y[2 * b + 1, 2 * a] = -1
                Y[2 * a + 1, 2 * b] = 1; Y[2 * b, 2 * a + 1] = 1
                Y[2 * a + 1, 2 * b] = 1; Y[2 * b, 2 * a + 1] = -1
                gens.append(Y)
    for a in range(m):
        Z = np.zeros((2 * m, 2 * m))
        Z[2 * a, 2 * a + 1] = 1; Z[2 * a + 1, 2 * a] = -1
        gens.append(Z)
    return gens


def run(n, gens, name):
    W, r, Pi = PT.W_subalgebra(n, gens)
    o = M.analyse(n, W, name)
    S, neg, U, ev = M.gradedness(n, W)
    N = n * (n - 1) // 2
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    print('%-28s n=%2d r=%3d theta=%.9f/th0=%.4f  res=%.1e Ric=%.1e Alt=%.1e  S_mmm=%9.3f  lam_max=%.12f %s'
          % (name, n, r, o['theta'], o['theta'] / th0, o['res'], o['ric'], o['alt'], S, o['lam_max'],
             '' if o['res'] > 1e-9 else ('GRADED' if S < 1e-8 else 'ungraded')))
    sys.stdout.flush()


if __name__ == '__main__':
    for L in [2, 3, 4]:
        g = so3_irrep_real(L)
        run(2 * L + 1, g, 'so(3) irred (spin %d)' % L)
    for m in [4, 5]:
        run(m * (m - 1) // 2, PT.gens_so_adjoint(m), 'so(%d) adjoint' % m)
    g, f, d = PT.gens_su3_adjoint()
    run(8, g, 'su(3) adjoint')
    for m in [2, 3, 4]:
        run(2 * m, gens_um(m), 'u(%d) in so(%d)' % (m, 2 * m))
    for (p, q) in [(3, 5), (2, 6), (4, 4), (2, 4)]:
        run(p + q, PT.gens_so_direct_sum(p + q, [p, q]), 'so(%d)+so(%d)' % (p, q))
    run(9, PT.gens_so_direct_sum(9, [3, 3, 3]), 'so(3)^3 in so(9)')
    run(12, PT.gens_so_direct_sum(12, [4, 4, 4]), 'so(4)^3 in so(12)')
