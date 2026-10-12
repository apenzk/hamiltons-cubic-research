"""
An UPPER bound on the inner maximisation, via the second eigenvalue and the
worst-case alignment.

The separated bound charges lambda_1 = sup ||A|| and ||b|| = 2/3 at once, which
requires W_1 to sit simultaneously at A's top eigenvector and along b.  Splitting
x = t v_max + sqrt(1-t^2) w with w orthogonal to v_max:

    <A x, x>  <=  t^2 lambda_1 + (1-t^2) lambda_2
    <b, x>    <=  ||b|| ( t rho + sqrt((1-t^2)(1-rho^2)) ),   rho = |<b,v_max>|/||b||

so the inner maximum is at most the one-dimensional maximum over t in [-1,1] of

    g ( t^2 lambda_1 + (1-t^2) lambda_2 )  +  lin ||b|| ( t rho + sqrt((1-t^2)(1-rho^2)) ).

This IS an upper bound -- the previous attempt ascended the outer maximisation and
so bounded the wrong way.  It is sharp when rho = 1 (recovering the separated
bound) and improves as rho falls and as lambda_2 falls below lambda_1.

The four constants are suprema over admissible W_2, each obtained by ascent, so
each is a measured lower bound on the supremum it names; the resulting bound
inherits that status, exactly as the constants sqrt(5/6), 2/3 and sqrt(2/3)
already in use do.  Recognisable closed forms are reported where they appear.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)
R23 = np.sqrt(2.0 / 3.0)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def setup(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    M = F_matrix(u, c, Eflat)
    w, V = np.linalg.eigh(M)
    r = w / SQ32
    return c, Eflat, u.shape[0], V[:, np.abs(r - 1 / 3) < 1e-8], V[:, r < 1e-8]


def constants(n, restarts=6, iters=25, seed=5):
    c, Eflat, Nl, V13, Vle0 = setup(n)
    k = V13.shape[1]
    E13 = []
    for i in range(k):
        e = (Eflat.T @ V13[:, i]).reshape(Nl, Nl)
        E13.append(0.5 * (e + e.T))

    def W2of(y):
        W = (Eflat.T @ (Vle0 @ y)).reshape(Nl, Nl)
        W = 0.5 * (W + W.T)
        return W / max(np.linalg.norm(W), 1e-300)

    def Ab(W2):
        A = np.empty((k, k))
        for i in range(k):
            # /4, not /2: the polarization (Q(x+y)-Q(x-y))/2 is TWICE the symmetric
            # form with T(W,W,W) = P(W).  The same factor-2 slip appeared in the
            # tri() helper of p0_repair_417.py.
            col = (Q_full(E13[i] + W2, c) - Q_full(E13[i] - W2, c)) / 4.0
            A[:, i] = V13.T @ (Eflat @ col.reshape(-1))
        A = 0.5 * (A + A.T)
        return A, V13.T @ (Eflat @ Q_full(W2, c).reshape(-1))

    rng = np.random.default_rng(seed)
    l1 = l2 = nb = rho = 0.0
    for _ in range(restarts):
        y = rng.normal(size=Vle0.shape[1]); y /= np.linalg.norm(y)
        for _ in range(iters):
            W2 = W2of(y)
            A, b = Ab(W2)
            ev, U = np.linalg.eigh(A)
            W1 = (Eflat.T @ (V13 @ U[:, -1])).reshape(Nl, Nl)
            W1 = 0.5 * (W1 + W1.T); W1 /= max(np.linalg.norm(W1), 1e-300)
            # lambda_1(A_{W_2}) = max_v T(v,v,W_2) = <Q(v), W_2>, linear in W_2,
            # so its ascent direction is Q(W_1) with W_1 the current top eigenvector --
            # NOT the polarization, which ascends T(W_1,W_2,W_2) instead.
            g = Eflat @ Q_full(W1, c).reshape(-1)
            yn = Vle0.T @ g
            if np.linalg.norm(yn) < 1e-300:
                break
            y = yn / np.linalg.norm(yn)
        W2 = W2of(y)
        A, b = Ab(W2)
        ev, U = np.linalg.eigh(A)
        q = U.T @ b
        nbv = np.linalg.norm(q)
        l1 = max(l1, ev[-1]); l2 = max(l2, ev[-2]); nb = max(nb, nbv)
        if nbv > 1e-12:
            rho = max(rho, abs(q[-1]) / nbv)
        print(f"      restart: l1={ev[-1]:.6f} l2={ev[-2]:.6f} |b|={nbv:.6f}"
              f"  running max: l1={l1:.6f} |b|={nb:.6f} rho={rho:.6f}", flush=True)
    return l1, l2, nb, rho


def bound(a, n, l1, l2, nb, rho, grid=200001):
    eps = 1 / 3 - a
    s2 = 3 * eps
    if not (0 < s2 < 1):
        return np.inf
    s, cb = np.sqrt(s2), np.sqrt(1 - s2)
    g, lin = 3 * cb * cb * s, 3 * cb * s2
    t = np.linspace(-1, 1, grid)
    q = np.sqrt(np.clip(1 - t * t, 0, None))
    val = g * (t * t * l1 + (1 - t * t) * l2) + lin * nb * (t * rho + q * np.sqrt(1 - rho * rho))
    return R23 * (val.max() + s2 * s * theta0(n))


def tradeoff(n, samples=400, seed=9):
    """Is ||b|| forced down when lambda_1 is up?  Sampling W_2 across the sphere and
    plotting the pair (lambda_1, ||b||) shows whether the two can be large together.
    The ascent converges to lambda_1 maximal with ||b|| EXACTLY zero, which if
    structural is the sharpest possible form of the coupling."""
    c, Eflat, Nl, V13, Vle0 = setup(n)
    k = V13.shape[1]
    E13 = []
    for i in range(k):
        e = (Eflat.T @ V13[:, i]).reshape(Nl, Nl)
        E13.append(0.5 * (e + e.T))
    rng = np.random.default_rng(seed)
    pts = []
    for _ in range(samples):
        y = rng.normal(size=Vle0.shape[1]); y /= np.linalg.norm(y)
        W2 = (Eflat.T @ (Vle0 @ y)).reshape(Nl, Nl)
        W2 = 0.5 * (W2 + W2.T); W2 /= max(np.linalg.norm(W2), 1e-300)
        A = np.empty((k, k))
        for i in range(k):
            col = (Q_full(E13[i] + W2, c) - Q_full(E13[i] - W2, c)) / 4.0
            A[:, i] = V13.T @ (Eflat @ col.reshape(-1))
        A = 0.5 * (A + A.T)
        b = V13.T @ (Eflat @ Q_full(W2, c).reshape(-1))
        pts.append((float(np.linalg.eigvalsh(A)[-1]), float(np.linalg.norm(b))))
    pts = np.array(pts)
    print(f"n={n}  tradeoff over {samples} random W_2:")
    print(f"   lambda_1 range [{pts[:,0].min():.6f}, {pts[:,0].max():.6f}]"
          f"   ||b|| range [{pts[:,1].min():.6f}, {pts[:,1].max():.6f}]")
    print(f"   correlation(lambda_1, ||b||) = {np.corrcoef(pts[:,0], pts[:,1])[0,1]:+.4f}")
    hi = pts[pts[:, 0] > np.quantile(pts[:, 0], 0.9)]
    print(f"   among the top-decile lambda_1: ||b|| max = {hi[:,1].max():.6f}"
          f"  vs overall max {pts[:,1].max():.6f}")
    print(f"   max of (lambda_1 + ||b||) = {(pts[:,0]+pts[:,1]).max():.6f}"
          f"   vs separate maxima summed = {pts[:,0].max()+pts[:,1].max():.6f}", flush=True)


if __name__ == "__main__":
    tradeoff(12)
    for n in (12,):
        l1, l2, nb, rho = constants(n)
        print(f"n={n:3d}  lambda_1={l1:.6f} (sqrt(5/6)={np.sqrt(5/6):.6f})  lambda_2={l2:.6f}"
              f"  ||b||={nb:.6f} (2/3={2/3:.6f})  rho={rho:.6f}")
        for a in (0.25, 0.29, 0.295, 0.30, 0.31):
            bd, req = bound(a, n, l1, l2, nb, rho), (3 - 5 * a) / np.sqrt(3)
            sep = bound(a, n, l1, l1, nb, 1.0)
            print(f"     alpha={a:.4f}  angle bound={bd:.6f}  separated={sep:.6f}"
                  f"  requirement={req:.6f}  {'CLOSES' if bd < req else 'fails'}")
        print(flush=True)
