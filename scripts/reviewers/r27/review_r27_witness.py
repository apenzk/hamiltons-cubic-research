"""Reviewer 27: an explicit violating direction at the GRADED point S^2 x S^{n-2}."""
import numpy as np
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M


def witness(n, a=2, b=3, verbose=True):
    """Indices 0,1 are the S^2 block; a,b >= 2 sit in the S^{n-2} block."""
    pr, idx, c = C.struct(n)
    N = len(pr)

    def ph(i, j):
        v = np.zeros(N)
        s = 1.0
        if i > j:
            i, j, s = j, i, -1.0
        v[idx[(i, j)]] = s
        return v

    def od(x, y):
        return 0.5 * (np.outer(x, y) + np.outer(y, x))

    H = od(ph(0, 1), ph(a, b))                                      # in Sym^2(h)
    Mx = od(ph(0, a), ph(1, b)) - od(ph(0, b), ph(1, a))            # in Sym^2(m)
    W, lab, res = PT.solve_multiblock(n, [2, n - 2])
    o = M.analyse(n, W, 'S^2 x S^{n-2}')
    e = o['e']
    B = o['B']

    def inWeyl(X):
        return np.linalg.norm(X - np.einsum('k,kab->ab', np.einsum('kab,ab->k', B, X), B)) / np.linalg.norm(X)
    best = None
    # find the combination that is a Weyl element and an L_e eigenvector
    Gm = np.array([[np.trace(H @ H), np.trace(H @ Mx)], [np.trace(H @ Mx), np.trace(Mx @ Mx)]])
    Lm = np.array([[np.trace(H @ C.circ(n, e, H)), np.trace(H @ C.circ(n, e, Mx))],
                   [np.trace(Mx @ C.circ(n, e, H)), np.trace(Mx @ C.circ(n, e, Mx))]])
    from scipy.linalg import eigh
    w, V = eigh(0.5 * (Lm + Lm.T), Gm)
    if verbose:
        print('n=%2d  span{H, M} is L_e-invariant?  residuals:' % n)
    for k in range(2):
        v = V[0, k] * H + V[1, k] * Mx
        v = v / np.sqrt(np.trace(v @ v))
        r = np.linalg.norm(C.circ(n, e, v) - w[k] * v)
        hh = np.trace(v @ H) ** 2 / np.trace(H @ H)
        if verbose:
            print('   lambda=%.15f   ||L_e v - lambda v||=%.2e   Weyl-defect=%.2e   ratio beta/alpha=%.9f'
                  % (w[k], r, inWeyl(v), V[1, k] / V[0, k]))
        if best is None or w[k] > best[0]:
            best = (w[k], v)
    lam = best[0]
    v = best[1]
    hhmass = np.trace((v @ H)) ** 2 / (np.trace(H @ H) * np.trace(v @ v))
    print('n=%2d  S^2 x S^{n-2}: witness eigenvalue %.15f   vs 1/2+1/(2(n-3)) = %.15f   vs lam_max %.12f'
          % (n, lam, 0.5 + 1.0 / (2 * (n - 3)), o['lam_max']))
    print('      second variation 6 theta (lambda - 1/2) = %+.9f  (theta=%.9f)  Weyl-defect of v = %.1e'
          % (6 * o['theta'] * (lam - 0.5), o['theta'], inWeyl(v)))
    return lam


if __name__ == '__main__':
    for n in [5, 6, 7, 8, 9, 10, 11, 12]:
        witness(n, 2, 3, verbose=(n == 8))
