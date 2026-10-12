"""Reviewer 61 / C6: structured screen.  A two-negative Weyl_m tensor with
dim U = m needs its two negative eigenvectors y,z to have im y + im z = R^m.
Sweep the structured (y,z) families -- block skew matrices of prescribed rank
and singular-value pattern, in random relative position -- and read the exact
SDP margin for each.  m = 6 and 8 calibrate the screen (witnesses exist there)."""
import numpy as np, itertools, sys, time
from review_r61_core import skew_to_vec, vec_to_skew
from review_r61_c6_sdp import margin


def block(m, rank, alphas, frame):
    """skew matrix of the given even rank with the given singular values,
    supported on the first `rank` columns of `frame`."""
    X = np.zeros((m, m))
    for i in range(rank//2):
        u = frame[:, 2*i]; v = frame[:, 2*i+1]
        X += alphas[i]*(np.outer(u, v) - np.outer(v, u))
    x = skew_to_vec(X, m)
    return x/np.linalg.norm(x)


def spanrank(y, z, m):
    X = vec_to_skew(y, m); Y = vec_to_skew(z, m)
    return np.linalg.matrix_rank(np.hstack([X, Y]), tol=1e-8)


def run(m, trials, seed):
    rng = np.random.default_rng(seed)
    best = {}
    t0 = time.time()
    ranks = [(a, b) for a in range(2, m+1, 2) for b in range(2, m+1, 2) if a + b >= m]
    for (ra, rb) in ranks:
        for eq in (True, False):
            hit = None
            for tr in range(trials):
                Fa, _ = np.linalg.qr(rng.normal(size=(m, m)))
                Fb, _ = np.linalg.qr(rng.normal(size=(m, m)))
                aa = np.ones(ra//2) if eq else rng.uniform(0.4, 1.0, ra//2)
                bb = np.ones(rb//2) if eq else rng.uniform(0.4, 1.0, rb//2)
                y = block(m, ra, aa, Fa); z = block(m, rb, bb, Fb)
                z = z - (z @ y)*y
                nz = np.linalg.norm(z)
                if nz < 1e-6:
                    continue
                z /= nz
                if spanrank(y, z, m) < m:
                    continue
                t, _, _ = margin(m, y, z)
                if hit is None or t > hit:
                    hit = t
            lbl = "equal sv" if eq else "generic sv"
            print(f"  m={m} rank(y)={ra} rank(z)={rb} {lbl}: best margin over "
                  f"{trials} random positions = {hit if hit is None else f'{hit:+.4e}'}"
                  f"  [{time.time()-t0:.0f}s]")
            sys.stdout.flush()
            best[(ra, rb, eq)] = hit
    return best


if __name__ == '__main__':
    for m, tr in [(6, 12), (8, 10), (10, 8), (12, 4)]:
        print(f"=== m={m} (a margin >= ~0 is a full-support two-negative witness) ===")
        sys.stdout.flush()
        run(m, tr, seed=4000+m)
