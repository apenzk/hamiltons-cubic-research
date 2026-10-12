"""Reviewer 27: sweep every two-block sphere product S^p x S^q and measure lambda_max(L_e | W-perp)."""
import sys
import numpy as np
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M


def theta_kl(k, l):
    n = k + l
    return np.sqrt(2.0) * np.sqrt((k - 1) / k * (l - 1) / l * (n - 1) / (n - 2))


def run(n, p):
    q = n - p
    W, lab, res = PT.solve_multiblock(n, [p, q])
    o = M.analyse(n, W, 'S^%d x S^%d' % (p, q))
    S, neg, U, ev = M.gradedness(n, W)
    tk = theta_kl(p, q)
    print('n=%2d  S^%d x S^%d : theta=%.12f (formula %.12f, d=%.1e) res=%.1e S_mmm=%.3e '
          'dim(m)=%d  lam_max=%.12f' % (n, p, q, o['theta'], tk, abs(o['theta'] - tk),
                                        o['res'], S, neg.shape[1], o['lam_max']))
    ee = o['ev']
    top = ee[ee > o['lam_max'] - 1e-9]
    print('        mult(top)=%d   orbit dim = %d   next=%.10f' %
          (len(top), n * (n - 1) // 2 - p * (p - 1) // 2 - q * (q - 1) // 2, ee[-len(top) - 1]))
    sys.stdout.flush()
    return o['lam_max'], S


if __name__ == '__main__':
    for n in [6, 7, 8, 9, 10]:
        for p in range(2, n // 2 + 1):
            run(n, p)
