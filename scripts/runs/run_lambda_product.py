"""The lambda-weighted bound: a sharpening that is free, and the falsifier for the route.

THE RECORDED BOUND.  With g_gamma = ||[ad(v_gamma), W]||^2 in an eigenbasis, Petersen-Wink
Prop 1.7 plus A(W) = 2W give the two contractions

    sum_gamma g_gamma = 4(n-1),        sum_gamma lambda_gamma g_gamma = -4 theta,

and dropping the positive block from the second gives

    theta <= |lambda_min| * (4(n-1) - Delta - G0) / 4,     Delta := sum_{p} g,  G0 := sum_{ker} g.

THE SHARPENING, and it costs nothing.  The dropped block is not merely non-negative: on
p every eigenvalue is at least the smallest POSITIVE eigenvalue lam_p_min, so

    4 theta = sum_{m} |lambda| g  -  sum_{p} lambda g
            <= |lambda_min| * (4(n-1) - Delta - G0)  -  lam_p_min * Delta.

Equality needs g supported on the lambda_min eigenspace within m AND on the lam_p_min
eigenspace within p.  The two bounds agree exactly at Delta = 0 and the new one is
strictly smaller whenever Delta > 0, so it changes nothing at the maximiser -- which is
the point: the recorded bound's failure is entirely at Delta = 0, and Delta = 0 on
{S = 0} with trivial kernel means W is GRADED, a case step H already owns.

THE FALSIFIER THIS FILE EXISTS TO TEST.  plan.md item 3 says the route dies if the
product

    Pi(W) := |lambda_min| * (4(n-1) - Delta - G0)

is unbounded on the target set.  Bounded by 4*sqrt(3/2) = 4.89898 would close it; the
question is whether it is bounded at all, and by what.

Controls: both contractions must reproduce exactly, and both bounds must hold at every
catalogued point, with the recorded bound returning theta_0(12) at the balanced product.
"""
import numpy as np, itertools, sys, os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import run_grading_test as GT

TARGET = np.sqrt(1.5)


def setup(n):
    pr = list(itertools.combinations(range(n), 2))
    N = len(pr)
    GT.n, GT.pr, GT.N = n, pr, N
    GT.B = GT.so_basis(n, pr)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = GT.B[a] @ GT.B[b] - GT.B[b] @ GT.B[a]
            for g in range(N):
                c[a, b, g] = GT.ip(C, GT.B[g])
    return pr, N, c


def sharp_op(M, c):
    return 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, M, M, optimize=True)


def g_vector(M, c, tol=1e-9):
    """g_gamma = sum_{alpha,beta} (lam_a - lam_b)^2 T_{gamma,a,b}, in the eigenbasis."""
    lam, V = np.linalg.eigh(M)
    cE = np.einsum('abg,aA,bB,gG->ABG', c, V, V, V, optimize=True)
    T = cE ** 2
    D = (lam[:, None] - lam[None, :]) ** 2
    g = np.einsum('gab,ab->g', T, D)
    return lam, g


def bounds(M, c, tol=1e-9):
    """Both bounds, and the product the route's falsifier is about."""
    lam, g = g_vector(M, c)
    theta = float(np.sum((M @ M + sharp_op(M, c)) * M))
    n = GT.n
    idx_p = [k for k in range(len(lam)) if lam[k] > tol]
    idx_m = [k for k in range(len(lam)) if lam[k] < -tol]
    idx_0 = [k for k in range(len(lam)) if abs(lam[k]) <= tol]
    Delta = float(g[idx_p].sum()) if idx_p else 0.0
    G0 = float(g[idx_0].sum()) if idx_0 else 0.0
    Sm = float(g[idx_m].sum()) if idx_m else 0.0
    lmin = float(lam.min())
    lpmin = float(min(lam[k] for k in idx_p)) if idx_p else 0.0

    prod = abs(lmin) * Sm                      # the product plan item 3 names
    rec = prod / 4.0                           # the recorded bound
    new = (prod - lpmin * Delta) / 4.0         # the sharpening
    return dict(theta=theta, lmin=lmin, lpmin=lpmin, Delta=Delta, G0=G0, Sm=Sm,
                sum_g=float(g.sum()), sum_lg=float((lam * g).sum()),
                prod=prod, rec=rec, new=new, dim_m=len(idx_m), dim_ker=len(idx_0))


def sphere_product(p, q):
    m = p + q
    prm = list(itertools.combinations(range(m), 2))
    K = np.zeros((m, m))
    for (i, j) in prm:
        if i < p and j < p:
            v = -q / (p - 1)
        elif i >= p and j >= p:
            v = -p / (q - 1)
        else:
            v = 1.0
        K[i, j] = K[j, i] = -v
    D = np.diag([K[i, j] for (i, j) in prm])
    return D / np.linalg.norm(D)


def cp2_padded(m):
    prm = list(itertools.combinations(range(m), 2))
    K = len(prm)

    def bi(i, j, s, k, l, t):
        v = np.zeros(K)
        v[prm.index((i, j))] = s
        v[prm.index((k, l))] = t
        return v / np.linalg.norm(v)

    plus = [bi(0, 1, 1, 2, 3, 1), bi(0, 2, 1, 1, 3, -1), bi(0, 3, 1, 1, 2, 1)]
    D = (2 * np.outer(plus[0], plus[0]) - np.outer(plus[1], plus[1])
         - np.outer(plus[2], plus[2]))
    return D / np.linalg.norm(D)


def theta0(n):
    return np.sqrt(2 * (n - 1) * (n - 2)) / n


if __name__ == "__main__":
    print("=" * 100)
    print("CONTROLS: both contractions exact, both bounds valid, recorded bound sharp at")
    print("the balanced product.  sum g must be 4(n-1) and sum lambda g must be -4 theta.")
    print("=" * 100)
    print(f"{'point':22s} {'n':>3s} {'theta':>10s} {'sum g':>9s} {'4(n-1)':>8s} "
          f"{'sum lg':>10s} {'-4th':>9s} {'Delta':>8s} {'recorded':>10s} {'sharpened':>10s}")

    cases = []
    for (p, q) in [(3, 3), (4, 4), (5, 5), (6, 6), (3, 5), (5, 7)]:
        cases.append((f"S^{p} x S^{q}", p + q, sphere_product(p, q)))
    for m in (6, 8, 10):
        cases.append((f"padded W_CP2", m, cp2_padded(m)))

    prods = []
    for name, n, M in cases:
        pr, N, c = setup(n)
        b = bounds(M, c)
        ok_g = abs(b['sum_g'] - 4 * (n - 1)) < 1e-9
        ok_l = abs(b['sum_lg'] + 4 * b['theta']) < 1e-9
        assert ok_g and ok_l, f"contraction failed at {name}"
        assert b['rec'] >= b['theta'] - 1e-12, f"recorded bound violated at {name}"
        assert b['new'] >= b['theta'] - 1e-12, f"sharpened bound violated at {name}"
        assert b['new'] <= b['rec'] + 1e-12, "the sharpening must never be weaker"
        print(f"{name:22s} {n:3d} {b['theta']:10.6f} {b['sum_g']:9.4f} {4*(n-1):8d} "
              f"{b['sum_lg']:10.4f} {-4*b['theta']:9.4f} {b['Delta']:8.4f} "
              f"{b['rec']:10.6f} {b['new']:10.6f}")
        prods.append((name, n, b))

    print("\nAll contractions exact, both bounds valid, sharpening never weaker.")
    bal = [b for nm, n, b in prods if nm == "S^6 x S^6"]
    if bal:
        print(f"At the balanced product n=12: recorded bound = {bal[0]['rec']:.6f} "
              f"against theta_0(12) = {theta0(12):.6f}  -> "
              f"{'SHARP' if abs(bal[0]['rec']-theta0(12))<1e-9 else 'NOT sharp'}")

    print("\n" + "=" * 100)
    print("THE FALSIFIER: is the product |lambda_min| * (4(n-1) - Delta - G0) BOUNDED?")
    print("Closing needs it below 4*sqrt(3/2) = %.5f on the target set." % (4 * TARGET))
    print("=" * 100)
    print(f"{'point':22s} {'n':>3s} {'theta':>10s} {'|lam_min|':>10s} {'Sum_m g':>9s} "
          f"{'product':>10s} {'vs 4sqrt(3/2)':>14s}")
    for name, n, b in prods:
        print(f"{name:22s} {n:3d} {b['theta']:10.6f} {abs(b['lmin']):10.6f} "
              f"{b['Sm']:9.4f} {b['prod']:10.6f} {b['prod']/(4*TARGET):14.4f}")

    print("\nGrowth in n along the balanced family, which is where the product is decided:")
    print(f"{'n':>4s} {'|lam_min|':>11s} {'Sum_m g':>10s} {'product':>11s} "
          f"{'product/4':>11s} {'theta_0(n)':>11s} {'ratio':>8s}")
    for k in range(3, 11):
        n = 2 * k
        pr, N, c = setup(n)
        b = bounds(sphere_product(k, k), c)
        print(f"{n:4d} {abs(b['lmin']):11.6f} {b['Sm']:10.4f} {b['prod']:11.6f} "
              f"{b['prod']/4:11.6f} {theta0(n):11.6f} {b['prod']/4/theta0(n):8.4f}")
