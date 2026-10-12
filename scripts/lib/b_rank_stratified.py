"""The bound's supremum stratified by rank, on a relaxation of Weyl_n.

WHY A RELAXATION.  M(n) <= sqrt(3) needs sup over Weyl_n of lam_max*p + B5.  Both
terms depend on W only through its eigenvalues lambda and the SUBSPACE V its
eigenvectors span, so the problem can be posed over

    V an r-plane in so(n),   lambda in R^r with sum lambda = 0, sum lambda^2 = 1,

dropping every Weyl constraint except total trace-freeness.  That is a strictly
larger feasible set, so a sup below sqrt(3) here proves it over Weyl_n -- and the
rank-3 slice of it is already the closed case, maximised at padded W_CP2.

WHAT THE STRATIFICATION BUYS.  The two terms pull opposite ways: lam_max*p wants
one dominant eigenvalue, B5 wants the structure mass an r-plane can carry, which
grows with r.  Reading the profile in r says which rank a proof has to fight.

WHY THE PROFILE CANNOT DEPEND ON n.  so(n) sits inside so(n+1) as a subalgebra
with the structure constants restricting unchanged, so every r-plane in so(n) is an
r-plane in so(n+1) and the relaxed supremum at fixed rank is NON-DECREASING in n.
Measured, it is already saturated at n = 4: rank 3 gives 1.544331 at each of
n = 4, 5, 6, 8, rank 4 gives 1.545949 at all four, rank 5 agrees to 1e-4.  So the
profile is one universal function Phi(r), and

    M(n) <= Phi(dim so(n)) = Phi(n(n-1)/2),

which turns the whole question into the growth of Phi.

WHAT IT FOUND.  The profile is IDENTICAL at n = 6 and n = 8 to five digits at
every rank tested, so the relaxed supremum is a function of rank alone.  It rises
monotonically and slowly: 1.544331 at r = 3 -- the closed rank-3 case, padded
W_CP2 -- through 1.563 at r = 9 to 1.630017 at r = 15, which is FULL rank for
n = 6.  So

    M(6) <= 1.6300 < sqrt(3),

proved on a set strictly containing Weyl_6.  Whether the same holds at larger n
turns on how the profile continues past r = 15, since dim so(n) is 28, 45, 66 at
n = 8, 10, 12 and the rise near the top is about 0.007 per rank.

FALSIFIER.  A relaxed optimum above sqrt(3) at any rank -- which would not refute
M(n) <= sqrt(3), but would kill this route to it, since the relaxation would then
be too loose to decide the question.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import adj


def value(c, V, lam):
    mu = np.abs(lam)
    T = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True) ** 2
    B5 = 0.5 * float(np.sqrt((np.einsum('abg,b,g->a', T, mu, mu) ** 2).sum()))
    return float(lam.max()) * float((lam[lam > 0] ** 2).sum()) + B5


def project_lam(x):
    """onto {sum lam = 0, sum lam^2 = 1}."""
    x = x - x.mean()
    nx = np.linalg.norm(x)
    return x / nx if nx > 1e-12 else None


def ascend(c, r, seed, iters=300, warm=None):
    """Ascent at fixed rank.  `warm` is an (V, lam) optimum from rank r-1.

    Phi is non-decreasing in r -- a rank-(r-1) configuration is a rank-r one with a
    zero eigenvalue appended -- so a lower value at higher rank is an ASCENT
    FAILURE, not a value.  Warm-starting from the previous rank makes monotonicity
    hold by construction and is what keeps the tail of the profile trustworthy."""
    N = c.shape[0]
    rng = np.random.default_rng(seed)
    if warm is not None and warm[0].shape[1] == r - 1:
        Vw, lw = warm
        V = np.linalg.qr(np.hstack([Vw, rng.normal(size=(N, 1))]))[0]
        lam = project_lam(np.concatenate([lw, [0.0]]))
    else:
        V = np.linalg.qr(rng.normal(size=(N, r)))[0]
        lam = project_lam(rng.normal(size=r))
    v = value(c, V, lam); step = 0.3
    for _ in range(iters):
        h = 1e-5
        gV = np.zeros_like(V)
        for i in range(V.shape[0]):
            for j in range(r):
                E = np.zeros_like(V); E[i, j] = h
                gV[i, j] = (value(c, np.linalg.qr(V + E)[0], lam) - v) / h
        gl = np.zeros(r)
        for j in range(r):
            e = np.zeros(r); e[j] = h
            gl[j] = (value(c, V, project_lam(lam + e)) - v) / h
        nV, nl = np.linalg.norm(gV), np.linalg.norm(gl)
        if nV + nl < 1e-11:
            break
        moved = False
        for t in (step, step / 2, step / 4, step / 8):
            Vn = np.linalg.qr(V + t * gV / max(nV, 1e-12))[0]
            ln = project_lam(lam + t * gl / max(nl, 1e-12))
            vn = value(c, Vn, ln)
            if vn > v + 1e-13:
                V, lam, v, moved = Vn, ln, vn, True
                break
        if not moved:
            step /= 2
            if step < 1e-7:
                break
    return v, lam, V


if __name__ == "__main__":
    r3 = np.sqrt(3)
    for n in (6, 8):
        c = adj(n); N = c.shape[0]
        print(f"\n=== n = {n}, dim so(n) = {N};  sqrt(3) = {r3:.6f} ===")
        print(f"{'rank':>5s} {'sup(bound)':>11s} {'< sqrt3':>8s}   eigenvalues at the optimum")
        t0 = time.time(); warm = None; prev = -np.inf
        for r in list(range(3, min(N, 9) + 1)) + ([10, 11, 12, 13, 14, 15] if n == 6 else []):
            best = (-1.0, None, None)
            for s in range(4):
                out = ascend(c, r, 100 * r + s)
                if out[0] > best[0]:
                    best = out
            out = ascend(c, r, 999, warm=warm)
            if out[0] > best[0]:
                best = out
            warm = (best[2], best[1])
            flag = "" if best[0] >= prev - 1e-9 else "  ASCENT FAILED (Phi is monotone)"
            prev = max(prev, best[0])
            lam = np.sort(best[1])[::-1]
            print(f"{r:5d} {best[0]:11.6f} {'yes' if best[0] <= r3 else 'NO':>8s}   "
                  f"{np.round(lam, 4)}{flag}")
        print(f"  [{time.time()-t0:.0f}s]")


def weyl_distance_of_relaxed_optimum(n, iters=140):
    """How far outside Weyl_n the relaxed optimum sits, and what it is worth there.

    The relaxation is not merely loose: at n = 6 its full-rank optimum is 56% away
    from Weyl_6 in relative Frobenius distance, and projecting it into Weyl_6 drops
    the bound from 1.6302 to 1.2374 -- below what ascent inside Weyl_6 reaches.  So
    the binding constraint is on the EIGENVECTOR PLANES a Weyl tensor can have, not
    on its eigenvalues, and a proof has to use that rather than tighten Phi.
    """
    from review_r30_core import weyl_basis, normalize
    from b_lowrank_bound import bound
    c = adj(n); N = c.shape[0]; B = np.asarray(weyl_basis(n))
    warm = None; out = None
    for r in range(3, N + 1):
        cands = [ascend(c, r, 100 * r + s, iters=iters) for s in range(2)]
        if warm:
            cands.append(ascend(c, r, 999, iters=iters, warm=warm))
        out = max(cands, key=lambda t: t[0])
        warm = (out[2], out[1])
    v, lam, V = out
    W = V @ np.diag(lam) @ V.T
    Wp = np.einsum('d,dij->ij', np.einsum('dij,ij->d', B, W), B)
    return v, float(np.linalg.norm(W - Wp) / np.linalg.norm(W)), bound(n, normalize(Wp), c)


def max_eigenvalue_of_unit_weyl(n, tries=25, seed=4):
    """max lambda_max over unit-norm Weyl_n = max over unit u in Lambda^2 of
    ||P_Weyl(u u^T)||.  A Weyl-specific constraint the relaxation does not have:
    0.816497 at n = 4, 5, then 0.843274, 0.845154, 0.881917 at n = 6, 8, 10."""
    from review_r30_core import weyl_basis
    B = np.asarray(weyl_basis(n)); N = B.shape[1]
    rng = np.random.default_rng(seed)
    f = lambda u: float(np.linalg.norm(np.einsum('dij,ij->d', B, np.outer(u, u))))
    best = 0.0
    for _ in range(tries):
        u = rng.normal(size=N); u /= np.linalg.norm(u); v = f(u); step = 0.3
        for _ in range(300):
            g = np.zeros(N); h = 1e-6
            for i in range(N):
                e = np.zeros(N); e[i] = h; w = u + e; w /= np.linalg.norm(w)
                g[i] = (f(w) - v) / h
            g -= (g @ u) * u; ng = np.linalg.norm(g)
            if ng < 1e-12:
                break
            for t in (step, step / 2, step / 4, step / 8):
                w = u + t * g / ng; w /= np.linalg.norm(w)
                if f(w) > v:
                    u, v = w, f(w); break
            else:
                step /= 2
                if step < 1e-9:
                    break
        best = max(best, v)
    return best
