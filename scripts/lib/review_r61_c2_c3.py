"""Reviewer 61 / C2 and C3.

C2: N_v = 2 v(x)v - ad(v)^2 psd on so(m) with ker = v^perp cap z(v).
    <u,N_v u> = 2<v,u>^2 + |[v,u]|^2 -- so this is elementary; checked anyway.
C3: x nondegenerate skew, c = z(x) cap x^perp; is dim(z(c) cap c^perp) = 1?
    Enumerated over EVERY multiplicity partition of p = m/2, m = 4,6,8,10,12,
    with random distinct alphas and a random orthogonal conjugation.
"""
import numpy as np, itertools
from review_r61_core import ad_matrix, vec_to_skew, skew_to_vec, pairs


def nullspace(M, tol=1e-8):
    if M.size == 0:
        return np.eye(M.shape[1])
    _, s, Vt = np.linalg.svd(M)
    r = int((s > tol * max(1.0, s[0])).sum())
    return Vt[r:]


def centraliser(vs, m):
    """common kernel of ad(u) for u in the rows of vs (coordinate vectors)."""
    M = np.vstack([ad_matrix(v, m) for v in vs]) if len(vs) else np.zeros((0, m*(m-1)//2))
    return nullspace(M)


def perp_within(space, vecs):
    """rows of `space` intersected with the orthogonal complement of rows `vecs`."""
    if len(vecs) == 0:
        return space
    G = np.array(vecs) @ space.T           # (k, dimspace)
    N = nullspace(G)
    return N @ space


def block_x(mults, alphas, m):
    X = np.zeros((m, m))
    k = 0
    for mu, a in zip(mults, alphas):
        for _ in range(mu):
            X[k, k+1] = a; X[k+1, k] = -a
            k += 2
    return X


def partitions(n):
    if n == 0:
        yield ()
        return
    for first in range(n, 0, -1):
        for rest in partitions(n - first):
            if not rest or first >= rest[0]:
                yield (first,) + rest


def test(m, mults, alphas, rng, conjugate=True):
    X = block_x(mults, alphas, m)
    if conjugate:
        Qm, _ = np.linalg.qr(rng.normal(size=(m, m)))
        X = Qm @ X @ Qm.T
    x = skew_to_vec(X, m); x /= np.linalg.norm(x)
    zx = centraliser([x], m)                     # z(x)
    c = perp_within(zx, [x])                     # z(x) cap x^perp
    zc = centraliser(list(c), m)                 # z(c)
    res = perp_within(zc, list(c))               # z(c) cap c^perp
    # does it contain x?
    contains = np.linalg.norm(res.T @ (res @ x) - x) if res.shape[0] else 1.0
    return X, len(zx), len(c), len(zc), len(res), contains


if __name__ == '__main__':
    rng = np.random.default_rng(11)
    print("=== C2: N_v psd, ker = v^perp cap z(v) ===")
    for m in (4, 6, 8):
        D = m*(m-1)//2
        for t in range(3):
            v = rng.normal(size=D); v /= np.linalg.norm(v)
            C = ad_matrix(v, m)
            N = 2*np.outer(v, v) - C @ C
            ev = np.linalg.eigvalsh(N)
            ker = nullspace(N, 1e-10)
            zc = centraliser([v], m)
            pred = perp_within(zc, [v])
            # compare subspaces
            Pk = ker.T @ ker; Pp = pred.T @ pred
            print(f"  m={m} #{t}: lambda_min(N)={ev[0]:+.2e}  dim ker={ker.shape[0]}"
                  f"  dim(v^perp cap z(v))={pred.shape[0]}  |P_ker-P_pred|={np.linalg.norm(Pk-Pp):.1e}")

    print("\n=== C3: dim( z(c) cap c^perp ) over all multiplicity patterns ===")
    for m in (4, 6, 8, 10, 12):
        p = m // 2
        for mults in partitions(p):
            r = len(mults)
            base = rng.uniform(1.0, 3.0, size=r)
            base = np.sort(base)[::-1]
            for trial in range(2):
                al = base if trial == 0 else rng.uniform(0.5, 4.0, size=r)
                if len(set(np.round(al, 9))) < r:
                    continue
                X, dz, dc, dzc, dres, cont = test(m, mults, al, rng)
                flag = "" if dres == 1 else "   <-- NOT 1"
                print(f"  m={m:2d} mult={str(mults):12s} dim z(x)={dz:3d} dim c={dc:3d}"
                      f" dim z(c)={dzc:3d}  dim(z(c) cap c^perp)={dres}"
                      f"  x-in-it resid={cont:.1e}{flag}")
        # special: x a multiple of a complex structure (all alphas equal)
        X, dz, dc, dzc, dres, cont = test(m, (p,), [1.0], rng)
        print(f"  m={m:2d} COMPLEX STRUCTURE            dim z(x)={dz:3d} dim c={dc:3d}"
              f" dim z(c)={dzc:3d}  dim(z(c) cap c^perp)={dres}  resid={cont:.1e}")
