"""Screen for the quartic Sigma4 behind the index step of the I121 band (r1868, r1869).

Checks, on objects built here from the definitions and sharing no code with the reviewers:
  (1) tr(G#G) = |N|_F^2/8 - Sigma4/2 at G = W^2, with # from so(n)'s structure constants in the
      record's normalisation (e_ij = E_ij - E_ji of record norm 1, anchor I#I = (n-2)I);
  (2) Sigma4 = sum G_ijkl G_jkli = (1/2)|G|^2 - (3/2)|Alt G|^2 in four-index sum norms, so
      Sigma4 >= 0 iff |Alt(W^2)|^2 <= |W^2|^2 / 3;
  (3) a bounded falsifier hunt: L-BFGS on Sigma4/|G|^2 over the Weyl space, n = 5..8,
      a fixed number of random starts and iterations.
Run: sage -python scripts/misc/screen_I121_sigma4.py   (about a minute)
"""
import itertools, sys
import numpy as np
from scipy.optimize import minimize

def perm_sign(p):
    s, p = 1, list(p)
    for i in range(len(p)):
        while p[i] != i:
            j = p[i]; p[i], p[j] = p[j], p[i]; s = -s
    return s

PERMS = [(p, perm_sign(p)) for p in itertools.permutations(range(4))]

def alt(T):
    return sum(s * T.transpose(p) for p, s in PERMS) / 24.0

def pair_sym(T):
    R = T - T.transpose(1, 0, 2, 3)
    R = R - R.transpose(0, 1, 3, 2)
    return (R + R.transpose(2, 3, 0, 1)) / 8.0

def kn(h, g):
    return (np.einsum('ik,jl->ijkl', h, g) + np.einsum('jl,ik->ijkl', h, g)
            - np.einsum('il,jk->ijkl', h, g) - np.einsum('jk,il->ijkl', h, g))

def weyl_part(R):
    n = R.shape[0]
    R = R - alt(R)
    ric = np.einsum('ijkj->ik', R); sc = np.trace(ric); g = np.eye(n)
    return R - kn(ric - sc / (2 * (n - 1)) * g, g) / (n - 2)

def weyl_basis(n, rng):
    d = n * (n + 1) * (n + 2) * (n - 3) // 12
    X = np.array([weyl_part(pair_sym(rng.standard_normal((n,) * 4))).ravel() for _ in range(d + 5)])
    U, S, Vt = np.linalg.svd(X, full_matrices=False)
    assert S[d - 1] > 1e-8 * S[0] and (len(S) == d or S[d] < 1e-8 * S[0])
    return Vt[:d].reshape(d, n, n, n, n)

def rec_norm2(T):
    return 0.25 * np.sum(T * T)

def G_of(W):
    return 0.5 * np.einsum('ijpq,klpq->ijkl', W, W)

def sigma4(G):
    return np.einsum('ijkl,jkli->', G, G)

def N_of(W):
    return np.einsum('impq,kmpq->ik', W, W)

def sharp_trace(G):
    n = G.shape[0]; P = list(itertools.combinations(range(n), 2)); m = len(P)
    E = []
    for (i, j) in P:
        X = np.zeros((n, n)); X[i, j] = 1; X[j, i] = -1; E.append(X)
    ip = lambda X, Y: 0.5 * np.sum(X * Y)
    c = np.zeros((m, m, m))
    for a in range(m):
        for b in range(m):
            C = E[a] @ E[b] - E[b] @ E[a]
            for g in range(m):
                c[a, b, g] = ip(C, E[g])
    Gop = np.array([[G[i, j, k, l] for (k, l) in P] for (i, j) in P])
    I = np.eye(m)
    assert np.allclose(0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, I, I), (n - 2) * I)
    return 0.5 * np.einsum('agd,aez,ge,dz->', c, c, Gop, Gop)

def unit(W):
    return W / np.sqrt(rec_norm2(W))

def padded_cp2(n):
    s = [np.zeros((n, n)) for _ in range(3)]
    for X, (a, b, c, d) in zip(s, [(0, 1, 2, 3), (0, 2, 3, 1), (0, 3, 1, 2)]):
        X[a, b], X[b, a], X[c, d], X[d, c] = 1, -1, 1, -1
    W = 2 * np.einsum('ij,kl->ijkl', s[0], s[0]) - sum(np.einsum('ij,kl->ijkl', X, X) for X in s[1:])
    return unit(W)

def checks(W, tag):
    W = unit(W); G = G_of(W); N = N_of(W); S4 = sigma4(G)
    lhs = sharp_trace(G); rhs = np.sum(N * N) / 8 - S4 / 2
    red = 0.5 * np.sum(G * G) - 1.5 * np.sum(alt(G) ** 2)
    ratio = np.sum(alt(G) ** 2) / np.sum(G * G)
    ricmax = np.abs(np.einsum('ijkj->ik', W)).max(); bmax = np.abs(alt(W)).max()
    print(f"{tag:22s} trG#G={lhs:.6f} |N|^2/8-S4/2={rhs:.6f}  S4={S4:.6f} reduction={red:.6f}"
          f"  Alt-fraction={ratio:.6f}  (Ric {ricmax:.1e}, Alt W {bmax:.1e})")
    assert abs(lhs - rhs) < 1e-9 and abs(S4 - red) < 1e-9 and ricmax < 1e-9 and bmax < 1e-9

def hunt(n, rng, starts, iters):
    B = weyl_basis(n, rng); d = len(B)
    def f(x):
        W = np.tensordot(x, B, 1); G = G_of(W)
        S4 = sigma4(G); Q = np.sum(G * G)
        H = G.transpose(1, 2, 3, 0) + G.transpose(3, 0, 1, 2)
        dS = 0.5 * (np.einsum('ijkl,klpq->ijpq', H, W) + np.einsum('ijkl,ijpq->klpq', H, W))
        dQ = np.einsum('ijkl,klpq->ijpq', G, W) + np.einsum('ijkl,ijpq->klpq', G, W)
        gS = np.tensordot(B, dS, 4); gQ = np.tensordot(B, dQ, 4)
        return S4 / Q, (gS * Q - S4 * gQ) / Q ** 2
    x0 = rng.standard_normal(d); v0, g0 = f(x0); e = rng.standard_normal(d) * 1e-6
    assert abs((f(x0 + e)[0] - f(x0 - e)[0]) - 2 * g0 @ e) < 1e-9 * max(1, abs(v0))
    best = None
    for _ in range(starts):
        r = minimize(f, rng.standard_normal(d), jac=True, method='L-BFGS-B', options={'maxiter': iters})
        if best is None or r.fun < best.fun:
            best = r
    W = np.tensordot(best.x, B, 1)
    # best.fun divides by the full four-index sum sum(G^2) = 4 tr W^4, so the record's-norm ratio is 4x
    print(f"n={n}: dim Weyl={d}, min Sigma4/sum(G^2) over {starts} starts = {best.fun:.6f}"
          f"  (Sigma4/tr W^4 = {4 * best.fun:.6f}, Alt-fraction {(0.5 - best.fun) / 1.5:.6f})")
    return W, best.fun

if __name__ == '__main__':
    rng = np.random.default_rng(1869)
    for n in (4, 5, 6):
        checks(padded_cp2(n), f"padded CP2, n={n}")
    for n in (5, 6, 7):
        checks(weyl_part(pair_sym(rng.standard_normal((n,) * 4))), f"random Weyl, n={n}")
    for n in (5, 6, 7, 8):
        W, v = hunt(n, rng, starts=8 if n < 8 else 4, iters=400)
        checks(W, f"hunt minimiser, n={n}")
    sys.stdout.flush()
