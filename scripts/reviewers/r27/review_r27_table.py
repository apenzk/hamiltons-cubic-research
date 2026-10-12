import sys, time
import numpy as np
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M

rows = []


def run(n, W, name):
    t = time.time()
    o = M.analyse(n, W, name)
    S, neg, U, ev = M.gradedness(n, W)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    rows.append((name, n, o['theta'], th0, o['res'], o['ric'], o['alt'], S, o['lam_max'], o['ev'], time.time() - t))
    print('%-26s n=%2d theta=%.9f (th0=%.9f) res=%.1e Ric=%.1e Alt=%.1e S_mmm=%.4g lam_max=%.12f  [%.1fs]'
          % (name, n, o['theta'], th0, o['res'], o['ric'], o['alt'], S, o['lam_max'], time.time() - t))
    top = o['ev'][o['ev'] > o['lam_max'] - 1e-8]
    print('     top eigenvalue %.15f  mult %d   next %.12f' % (o['lam_max'], len(top), o['ev'][-len(top) - 1]))
    sys.stdout.flush()
    return o


if __name__ == '__main__':
    which = sys.argv[1] if len(sys.argv) > 1 else 'all'
    if which in ('all', 'a'):
        for n in (8, 10, 12):
            m = n // 2
            W, r, Pi = PT.W_subalgebra(n, PT.gens_so_direct_sum(n, [m, m]))
            run(n, W, 'so(%d)+so(%d)' % (m, m))
    if which in ('all', 'b'):
        g, f, d = PT.gens_su3_adjoint()
        W, r, Pi = PT.W_subalgebra(8, g)
        run(8, W, 'su(3) adjoint')
        W, r, Pi = PT.W_subalgebra(5, PT.gens_so3_in_so5())
        run(5, W, 'so(3) irred in so(5)')
        W, r, Pi = PT.W_subalgebra(10, PT.gens_so_adjoint(5))
        run(10, W, 'so(5) adjoint')
    if which in ('all', 'c'):
        W, lab, res = PT.solve_multiblock(8, [3, 5])
        run(8, W, 'S^3 x S^5')
        for (n, bl) in [(9, [3, 3, 3]), (12, [4, 4, 4]), (12, [3, 3, 3, 3]), (12, [2, 5, 5]), (9, [2, 3, 4])]:
            W, lab, res = PT.solve_multiblock(n, bl)
            run(n, W, 'blocks ' + str(bl))
