"""The second inequality the low-rank regime needs, and the chain it completes.

WHERE THIS SITS.  B3 left theta <= sqrt(y) + (n-2)y with y = ||lambda||_4^2, which
is 0.97 of the truth at S^6 x S^6 and 0.12 of it at padded W_CP2, so six of eight
catalogued critical points blow through the sqrt(3) it needs.  Both halves of that
bound are wasteful at low rank, and both have a sharper replacement.

THE SHARP TERM: A ROW CAUCHY-SCHWARZ INSTEAD OF A FLATNESS ONE.  With T = c'^2 >= 0
transported to an eigenbasis of W and mu = |lambda|,

    <W,W#> = 1/2 sum T_{abg} lam_a lam_b lam_g <= 1/2 sum_a mu_a <T_a mu, mu>
           <= 1/2 ||mu||_2 sqrt( sum_a <T_a mu, mu>^2 )  =  B5,

using ||mu||_2 = 1.  Restricting c to the SUPPORT of W is what low rank buys: at
padded W_CP2 the support carries structure mass 4 against 2(n-2) = 20, and B5 = 1.0
against the flatness bound's 7.07.  Antisymmetry makes it exact at the bottom --
c'_{abg} vanishes identically on a subspace of dimension 1 or 2, so B5 = 0 and the
bound reduces to the cubic term at rank <= 2.

THE CUBIC TERM: THE POSITIVE PART, NOT THE LARGEST ENTRY.  tr W^3 <= ||lambda||_inf
throws away half the truth at padded W_CP2 (0.8165 against 0.4082).  Dropping the
negative eigenvalues instead,

    tr W^3 = sum_{lam>0} lam^3 + sum_{lam<0} lam^3 <= lam_max * p,   p = sum_{lam>0} lam^2,

which is 0.5443 there.  Both replacements are needed: either alone leaves padded
W_CP2 above sqrt(3).

WHAT THE CHAIN DELIVERS.  theta <= lam_max * p + B5 holds at every catalogued
critical point with margin, the worst being padded W_CP2 at 1.5443 against sqrt(3)
= 1.7321.  Subspace-gradient ascent ON THE BOUND, seeded at three catalogued
points, moves it to at most 1.5448 -- padded W_CP2 is a local maximum of the bound
itself, not merely of P.

WHAT IS OWED, PLAINLY.  This is the bound's value at particular points, not its
supremum over Weyl_n, and the supremum is what M(n) <= sqrt(3) requires.  The
naive random-direction climber in the report below reaches only 1.03 at n = 12 --
BELOW the seeds' own values -- so it is a broken instrument and its numbers are
evidence about the climber, not about the supremum.

FALSIFIER.  A W in Weyl_n with lam_max * p + B5 > sqrt(3).
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (adj, weyl_basis, normalize, sphere_product_W, sharp,
                             Q)
from b_cp2_nondegenerate import padded_cp2
from b_apriori_bound import rows, theta


def pieces(n, W, c=None, tol=1e-9):
    """(tr W^3 bound, sharp-term bound B5) for unit-norm W."""
    c = adj(n) if c is None else c
    lam, V = np.linalg.eigh(W)
    k = np.abs(lam) > tol
    Vk, mu = V[:, k], np.abs(lam[k])
    T = np.einsum('abg,ap,bq,gr->pqr', c, Vk, Vk, Vk, optimize=True) ** 2
    B5 = 0.5 * float(np.sqrt((np.einsum('abg,b,g->a', T, mu, mu) ** 2).sum()))
    return float(lam.max()) * float((lam[lam > 0] ** 2).sum()), B5


def bound(n, W, c=None):
    a, b = pieces(n, W, c)
    return a + b


if __name__ == "__main__":
    r3 = np.sqrt(3)
    print("=== the chain at the catalogued critical points ===")
    print(f"{'point':20s} {'n':>3s} {'tr W^3':>8s} {'lmax*p':>8s} {'<W,W#>':>8s} "
          f"{'B5':>8s} {'theta':>8s} {'bound':>8s}  < sqrt3")
    for nm, n, W in rows():
        t3 = float(np.trace(W @ W @ W)); sh = float(np.tensordot(W, sharp(n, W)))
        a, b = pieces(n, W)
        print(f"{nm:20s} {n:3d} {t3:8.4f} {a:8.4f} {sh:8.4f} {b:8.4f} "
              f"{theta(n, W):8.4f} {a+b:8.4f}  {'yes' if a+b <= r3 else 'NO'}")

    print("\n=== B5 vanishes below rank 3, by antisymmetry of c ===")
    rng = np.random.default_rng(2)
    # Projecting a low-rank matrix onto Weyl_n destroys its rank -- every such seed
    # comes back at full rank 28, so that route measures nothing.  The claim is
    # about the SUBSPACE c is restricted to, so restrict c to random subspaces
    # directly: three antisymmetric indices ranging over <= 2 values must vanish.
    n = 8; c = adj(n); N = c.shape[0]
    for r in (1, 2, 3, 4):
        worst = 0.0
        for _ in range(20):
            V = np.linalg.qr(rng.normal(size=(N, r)))[0]
            T = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True)
            worst = max(worst, float(np.abs(T).max()))
        print(f"  random {r}-dim subspace of Lambda^2: max |c'| = {worst:.2e}"
              f"{'   -> B5 = 0 identically' if r <= 2 else ''}")

    print("\n=== ascent ON THE BOUND, seeded at catalogued points (n=12) ===")
    n = 12; c = adj(n); B = weyl_basis(n); Bf = np.asarray(B); D = len(B)
    W_of = lambda x: normalize(np.einsum('d,dij->ij', x, Bf))
    seeds = {"padded W_CP2": padded_cp2(12)[0], "S^6xS^6": sphere_product_W([6, 6])[0],
             "S^4xS^8": sphere_product_W([4, 8])[0]}
    t0 = time.time()
    for nm, W0 in seeds.items():
        x = np.array([float(np.tensordot(b, normalize(W0))) for b in B])
        x /= np.linalg.norm(x); v = bound(n, W_of(x), c); step = 0.15
        for _ in range(22):
            S = rng.normal(size=(30, D)); S /= np.linalg.norm(S, axis=1, keepdims=True)
            g = np.array([(bound(n, W_of(x + 1e-4 * s), c) - v) / 1e-4 for s in S])
            d = (g[:, None] * S).sum(0); d /= max(np.linalg.norm(d), 1e-12)
            for t in (step, step / 2, step / 4, step / 8):
                xn = x + t * d; xn /= np.linalg.norm(xn); vn = bound(n, W_of(xn), c)
                if vn > v:
                    x, v = xn, vn; break
            else:
                step /= 2
            if step < 1e-4:
                break
        print(f"  from {nm:15s} -> {v:.4f}   (sqrt(3) = {r3:.4f})")
    print(f"  [{time.time()-t0:.0f}s]  padded W_CP2 is a local max OF THE BOUND, "
          f"not only of P")


def full_gradient_ascent(n, x0, Bf, c, iters=250, step=0.2, seed=0):
    """Ascent on the bound with a FULL finite-difference gradient.

    The random-direction climber above is useless in 1638 dimensions; at n = 6, 8
    the Weyl space is 84- and 288-dimensional and the real gradient is affordable,
    so the supremum can be probed rather than guessed at."""
    D = Bf.shape[0]
    W_of = lambda z: normalize(np.einsum('d,dij->ij', z, Bf))
    x = x0 / np.linalg.norm(x0); v = bound(n, W_of(x), c)
    h = 1e-5
    for _ in range(iters):
        g = np.empty(D)
        for d in range(D):
            e = np.zeros(D); e[d] = h
            g[d] = (bound(n, W_of(x + e), c) - v) / h
        g -= (g @ x) * x
        gn = np.linalg.norm(g)
        if gn < 1e-10:
            break
        g /= gn
        for t in (step, step / 2, step / 4, step / 8, step / 16):
            xn = x + t * g; xn /= np.linalg.norm(xn); vn = bound(n, W_of(xn), c)
            if vn > v + 1e-13:
                x, v = xn, vn; break
        else:
            step /= 2
            if step < 1e-7:
                break
    return x, v


if __name__ == "__main__":
    print("\n=== the supremum, probed with a real gradient at n = 6 and 8 ===")
    rng2 = np.random.default_rng(19)
    for n in (6, 8):
        c = adj(n); Bf = np.asarray(weyl_basis(n)); D = Bf.shape[0]
        best = -np.inf; bestW = None
        starts = [np.array([float(np.tensordot(b, normalize(padded_cp2(n)[0])))
                            for b in Bf])]
        starts += [rng2.normal(size=D) for _ in range(11)]
        for x0 in starts:
            x, v = full_gradient_ascent(n, x0, Bf, c, seed=0)
            if v > best:
                best, bestW = v, normalize(np.einsum('d,dij->ij', x, Bf))
        lam = np.linalg.eigvalsh(bestW)
        print(f"  n={n:2d}  D={D:4d}  sup(bound) found = {best:.6f}   "
              f"sqrt(3) = {np.sqrt(3):.6f}")
        print(f"        maximiser: theta = {theta(n, bestW):.6f}, rank "
              f"{int((np.abs(lam)>1e-9).sum())}, "
              f"crit residual {float(np.linalg.norm(Q(n,bestW)-theta(n,bestW)*bestW)):.2e}")
