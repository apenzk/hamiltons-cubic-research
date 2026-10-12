"""Reviewer 27: the counterexample to claim (B) -- graded critical points with lambda_max > 1/2."""
import sys
import numpy as np
from itertools import combinations
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M


def slack_full(n, W, theta):
    """S = ||Ric(W_-)||^2 + 6 delta^2 - theta tr(W_-) - tr(W_-^2), delta^2 = ||Alt(W_-)||^2 style."""
    pr, idx, c = C.struct(n)
    ev, U = np.linalg.eigh(W)
    sel = ev < -1e-11
    Wm = (U[:, sel] * ev[sel]) @ U[:, sel].T
    Ric = C.ricci(Wm, n, idx)
    d2 = C.alt_norm(Wm, n, idx) ** 2
    return (np.linalg.norm(Ric) ** 2 + 6 * d2 - theta * np.trace(Wm) - np.trace(Wm @ Wm)), d2


def report(n, p):
    q = n - p
    W, lab, res = PT.solve_multiblock(n, [p, q])
    o = M.analyse(n, W, '', want_vecs=True)
    Smmm, neg, U, ev = M.gradedness(n, W)
    Sfull, d2 = slack_full(n, W, o['theta'])
    uq = sorted(set(np.round(ev, 12)))
    lam = o['lam_max']
    pred = 0.5 + 1.0 / (2.0 * (n - 3)) if p == 2 else 0.5
    top = o['evals'][o['evals'] > lam - 1e-9]
    # is the top eigenspace inside Sym^2(m) / Sym^2(h) / mixed?
    mB = U[:, ev < -1e-11]; hB = U[:, ev >= -1e-11]
    Pm = mB @ mB.T; Ph = hB @ hB.T
    fr = []
    for k in range(len(top)):
        V = o['evecs'][:, -1 - k]
        X = np.einsum('k,kab->ab', V, o['B'])
        nn = np.trace(X @ X)
        fr.append((np.trace((Pm @ X @ Pm) @ X) / nn, np.trace((Ph @ X @ Ph) @ X) / nn,
                   2 * np.trace((Ph @ X @ Pm) @ X) / nn))
    fr = np.array(fr)
    print('n=%2d S^%d x S^%d  theta=%.12f  W-eigs %s' % (n, p, q, o['theta'], np.round(uq, 9)))
    print('   crit res %.1e  Ric %.1e  Alt %.1e   S_mmm=%.3e   full slack S=%.3e (delta^2=%.1e)'
          % (o['res'], o['ric'], o['alt'], Smmm, Sfull, d2))
    print('   lambda_max = %.15f   predicted %.15f   mult %d  (C(n-2,2)=%d, orbit=%d)'
          % (lam, pred, len(top), (n - 2) * (n - 3) // 2, n * (n - 1) // 2 - p * (p - 1) // 2 - q * (q - 1) // 2))
    print('   top eigenvectors: mm-mass %.6f  hh-mass %.6f  mixed %.6f'
          % (fr[:, 0].mean(), fr[:, 1].mean(), fr[:, 2].mean()))
    print('   second-order excess 6*theta*(lam-1/2) = %+.9f  ->  %s'
          % (6 * o['theta'] * (lam - 0.5), 'NOT a local max' if lam > 0.5 + 1e-9 else 'passes'))
    sys.stdout.flush()
    return lam, Smmm, Sfull


if __name__ == '__main__':
    for n in [5, 6, 7, 8, 9, 10, 11]:
        report(n, 2)
    print()
    for (n, p) in [(8, 3), (8, 4), (10, 4)]:
        report(n, p)
