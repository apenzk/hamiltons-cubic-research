"""Reviewer 67 -- C4: are (a), (b), (c) genuinely upper bounds on theta for S=0 tensors?

Strategy: build genuine (lam, T) pairs from genuine orthonormal frames of so(n)
whose negative eigenspace lies inside an isotropic subspace (so S_mmm = 0
exactly), then MAXIMISE theta - bound over the spectrum by local ascent from
many random starts.  Any positive value is a refutation.
"""
import numpy as np
from scipy.optimize import minimize
from review_r67_core import *

rng = np.random.default_rng(6767)


def isotropic_frame(n, p, d, om, rot=True, seed=None):
    """m = random d-dim subspace of the symmetric-pair odd part for the split (p,n-p),
    optionally conjugated by a random g in SO(n); h = orthogonal complement, random frame.
    Returns V (N x N, first d columns span m) and its T."""
    r = np.random.default_rng(seed)
    P, B = so_basis(n)
    N = len(P)
    m0 = np.array([1.0 if (i < p) != (j < p) else 0.0 for (i, j) in P])
    cols = np.where(m0 > 0)[0]
    assert d <= len(cols)
    # random d-dim subspace of span{phi_e : e in cols}
    A = r.standard_normal((len(cols), d))
    Q, _ = np.linalg.qr(A)
    Vm = np.zeros((N, d)); Vm[cols, :] = Q
    # complement
    full = np.concatenate([Vm, r.standard_normal((N, N - d))], axis=1)
    Q2, _ = np.linalg.qr(full)
    # fix signs so first d columns still span m
    V = Q2
    if rot:
        # conjugate by g in SO(n): acts on Lambda^2 as the induced rep -> preserves omega
        Ag = r.standard_normal((n, n)); Qg, _ = np.linalg.qr(Ag)
        if np.linalg.det(Qg) < 0: Qg[:, 0] *= -1
        # induced action on the phi basis
        G = np.zeros((N, N))
        for k, (i, j) in enumerate(P):
            Mk = np.zeros((n, n)); Mk[i, j] = 1; Mk[j, i] = -1
            Mk = Qg @ Mk @ Qg.T
            G[:, k] = np.array([Mk[a, b] for (a, b) in P])
        V = G @ V
    T = c_tensor(om, V) ** 2
    return V, T


def make_lam(x, d, N):
    """x: unconstrained; returns lam with lam[:d]<0, lam[d:]>=0, sum=0, ||lam||=1."""
    neg = np.abs(x[:d]) + 1e-12
    pos = np.abs(x[d:]) + 1e-12
    neg = neg * (pos.sum() / neg.sum())
    lam = np.concatenate([-neg, pos])
    return lam / np.linalg.norm(lam)


def attack(n, p, d, nstart=8, seed=0, bounds=('a', 'b', 'c'), om=None, verbose=False):
    om = omega_tensor(n) if om is None else om
    P, _ = so_basis(n); N = len(P)
    worst = {k: (-1e9, None) for k in bounds}
    for t in range(nstart):
        V, T = isotropic_frame(n, p, d, om, seed=(seed * 1000 + t))
        # confirm isotropy
        Smmm = float(np.einsum('abg->', T[:d, :d, :d])) / 6.0
        assert Smmm < 1e-18, Smmm
        fns = dict(a=lambda l: bound_a(l, n, N), b=lambda l: bound_b(l, n, N),
                   c=lambda l: bound_c(l, n, N))
        for key in bounds:
            f = fns[key]
            def obj(x):
                lam = make_lam(x, d, N)
                return -(theta_from(lam, T) - f(lam))
            best = (-1e9, None)
            for _ in range(3):
                x0 = np.random.default_rng(seed * 7919 + t * 31 + _).standard_normal(N)
                res = minimize(obj, x0, method='Nelder-Mead',
                               options=dict(maxfev=6000, fatol=1e-14, xatol=1e-10))
                val = -res.fun
                if val > best[0]:
                    best = (val, make_lam(res.x, d, N))
            if best[0] > worst[key][0]:
                worst[key] = best
    return worst


if __name__ == "__main__":
    print("=== pair cap / row marginal, independent check on random frames ===")
    for n in [5, 6, 7, 8]:
        om = omega_tensor(n)
        P, _ = so_basis(n); N = len(P)
        mx_pair, mx_row = 0.0, 0.0
        for t in range(200):
            A = rng.standard_normal((N, N)); V, _ = np.linalg.qr(A)
            T = c_tensor(om, V) ** 2
            mx_pair = max(mx_pair, T.sum(axis=2).max())
            mx_row = max(mx_row, abs(T.sum(axis=(1, 2)) - 2 * (n - 2)).max())
        print(f"  n={n}: max_pair sum_g T = {mx_pair:.12f} (cap 2)   row marginal dev {mx_row:.2e}")

    print()
    print("=== C4 validity: max over spectra of (theta - bound), S=0 frames ===")
    print(f"{'n':>3} {'p':>3} {'d':>4} {'theta-a':>14} {'theta-b':>14} {'theta-c':>14}")
    for (n, p, ds) in [(6, 3, [1, 2, 3, 5, 7, 9]), (7, 3, [2, 4, 8, 12]), (8, 4, [2, 5, 9, 14, 16])]:
        om = omega_tensor(n)
        for d in ds:
            w = attack(n, p, d, nstart=4, seed=d, om=om)
            print(f"{n:>3} {p:>3} {d:>4} {w['a'][0]:>14.3e} {w['b'][0]:>14.3e} {w['c'][0]:>14.3e}")
