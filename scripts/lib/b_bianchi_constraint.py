"""Bianchi as a condition on eigenvectors, and how much of the gap it explains.

THE REFORMULATION.  The first Bianchi identity is the vanishing of the Lambda^4
component of W in Sym^2(Lambda^2), and that component is the image of v (x) v under
v -> v ^ v.  So for W = sum_a lam_a v_a v_a^T,

    Bianchi  <=>  sum_a lam_a (v_a ^ v_a) = 0  in Lambda^4,

verified to 7e-16 across the catalogue against 0.545 for a random traceless
symmetric operator.  This is exactly the "constraint on eigenvector planes" the
rank-stratified relaxation was missing: it couples the lambda to the PLANES, which
no eigenvalue inequality can see.

THE EXPERIMENT.  The relaxation's full-rank supremum at n = 6 is 1.6300, while
ascent inside Weyl_6 reaches 1.5449.  Imposing only Bianchi -- by penalty, with rho
raised until the residual is below 1e-6 -- measures how much of that 0.085 gap one
identity accounts for, with Ricci-flatness still dropped.

A PENALTY IS THE WRONG TOOL, AND A BASIS IS THE RIGHT ONE.  Driving the residual
below 1e-5 by raising rho works at n = 6 but stalls at n = 8, where Lambda^4 is
70-dimensional.  The Bianchi-feasible set is a LINEAR subspace -- the kernel of the
wedge map, i.e. the space of algebraic curvature operators -- so it can be built
once by SVD and ascended over exactly.  Its dimension is n^2(n^2-1)/12: 105 at
n = 6 inside a 120-dimensional Sym^2(Lambda^2), and 336 at n = 8 inside 406.

THE SUPREMUM IS NON-DECREASING IN n, WHICH IS THE GUARD.  Padding a curvature
operator gives a curvature operator, lam_max*p is unchanged, and B5 sees c only on
the support of W, where so(n) sits inside so(n+1) with c restricting unchanged.  So
a LOWER value at larger n is an ascent failure, not a value: at n = 10 one random
start returned 1.4425 and another 1.548765, and only the second is admissible.

FALSIFIER.  A Bianchi-constrained optimum above the unconstrained one, which would
mean the constraint is not binding.
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, normalize, weyl_basis, adj
from b_rank_stratified import value, project_lam


def wedge_map(n):
    pairs, idx = pair_index(n); N = len(pairs)
    quads = list(itertools.combinations(range(n), 4)); qi = {q: k for k, q in enumerate(quads)}
    T = np.zeros((len(quads), N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            s = {i, j, k, l}
            if len(s) < 4:
                continue
            perm = [i, j, k, l]; sgn = 1
            for x in range(4):
                for y in range(x + 1, 4):
                    if perm[x] > perm[y]:
                        sgn = -sgn
            T[qi[tuple(sorted(s))], a, b] += sgn
    return T


def bianchi_residual(T, V, lam):
    W = (V * lam) @ V.T
    return float(np.linalg.norm(np.einsum('qab,ab->q', T, W)))


def ascend_constrained(c, T, r, seed, rho, iters=200, warm=None):
    N = c.shape[0]; rng = np.random.default_rng(seed)
    if warm is not None:
        V, lam = warm[0].copy(), warm[1].copy()
    else:
        V = np.linalg.qr(rng.normal(size=(N, r)))[0]
        lam = project_lam(rng.normal(size=r))
    f = lambda V_, l_: value(c, V_, l_) - rho * bianchi_residual(T, V_, l_) ** 2
    v = f(V, lam); step = 0.3; h = 1e-5
    for _ in range(iters):
        gV = np.zeros_like(V)
        for i in range(V.shape[0]):
            for j in range(r):
                E = np.zeros_like(V); E[i, j] = h
                gV[i, j] = (f(np.linalg.qr(V + E)[0], lam) - v) / h
        gl = np.zeros(r)
        for j in range(r):
            e = np.zeros(r); e[j] = h
            gl[j] = (f(V, project_lam(lam + e)) - v) / h
        nV, nl = np.linalg.norm(gV), np.linalg.norm(gl)
        if nV + nl < 1e-11:
            break
        for t in (step, step / 2, step / 4, step / 8):
            Vn = np.linalg.qr(V + t * gV / max(nV, 1e-12))[0]
            ln = project_lam(lam + t * gl / max(nl, 1e-12))
            if f(Vn, ln) > v + 1e-13:
                V, lam, v = Vn, ln, f(Vn, ln); break
        else:
            step /= 2
            if step < 1e-7:
                break
    return V, lam


def _report():
    print("=== Bianchi as sum_a lam_a (v_a ^ v_a) = 0 ===")
    from b_apriori_bound import rows
    for nm, n, W in rows():
        if n > 8:
            continue
        T = wedge_map(n); lam, V = np.linalg.eigh(W)
        r = np.einsum('qab,ak,bk,k->q', T, V, V, lam, optimize=True)
        print(f"  {nm:20s} n={n:2d}  ||sum lam (v^v)|| = {np.linalg.norm(r):.1e}")
    rng = np.random.default_rng(1)
    n = 6; T = wedge_map(n); X = rng.normal(size=(15, 15)); X = 0.5 * (X + X.T)
    X -= np.trace(X) / 15 * np.eye(15); X /= np.linalg.norm(X)
    print(f"  control, random symmetric traceless: "
          f"{np.linalg.norm(np.einsum('qab,ab->q', T, X)):.3f}")

    print("\n=== the Bianchi subspace, exactly, and the supremum over it ===")
    weyl = {6: 1.544872, 8: 1.545809}
    free = {6: 1.630017}
    for n in (6, 8):
        B = curvature_basis(n)
        print(f"  n={n}: dim = {B.shape[0]} (n^2(n^2-1)/12 = {n*n*(n*n-1)//12})")
        best, bw = -9.0, None
        for s in range(6 if n == 6 else 4):
            v, W = ascend_in_curvature_space(n, B, 100 + s)
            if v > best:
                best, bw = v, W
        rank = int((np.abs(np.linalg.eigvalsh(bw)) > 1e-9).sum())
        line = (f"    sup = {best:.6f}  (rank {rank}),  Weyl_{n} = {weyl[n]:.6f}")
        if n in free:
            line += (f",  free relaxation = {free[n]:.6f}  -> Bianchi closes "
                     f"{(free[n]-best)/(free[n]-weyl[n])*100:.1f}% of the gap")
        print(line)
    print(f"  rank-3 closed form = 1.544331 (padded W_CP2); the full-rank optimum "
          f"adds 4.5e-3 to it, so the profile does NOT collapse onto rank 3")


def curvature_basis(n):
    """Orthonormal basis of {W in Sym^2(Lambda^2) : Bianchi}, the kernel of v -> v^v.

    Exact rather than penalised.  dim = n^2(n^2-1)/12."""
    T = wedge_map(n)
    pairs, _ = pair_index(n); N = len(pairs)
    sym = []
    for a in range(N):
        for b in range(a, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1.0
            sym.append(E / np.linalg.norm(E))
    S = np.array(sym)
    M = np.einsum('qab,kab->qk', T, S)
    ns = np.linalg.svd(M)[2][np.linalg.matrix_rank(M):]
    return np.einsum('mk,kab->mab', ns, S)


def ascend_in_curvature_space(n, B, seed, iters=120, step=0.2):
    """Full finite-difference ascent on the bound inside the Bianchi subspace."""
    from b_lowrank_bound import bound
    from review_r30_core import normalize as _nz
    rng = np.random.default_rng(seed)
    D = B.shape[0]
    c = adj(n)
    W_of = lambda z: _nz(np.einsum('d,dij->ij', z, B))
    x = rng.normal(size=D); x /= np.linalg.norm(x)
    v = bound(n, W_of(x), c); h = 1e-5
    for _ in range(iters):
        g = np.empty(D)
        for d in range(D):
            e = np.zeros(D); e[d] = h
            g[d] = (bound(n, W_of(x + e), c) - v) / h
        g -= (g @ x) * x; gn = np.linalg.norm(g)
        if gn < 1e-10:
            break
        g /= gn
        for t in (step, step / 2, step / 4, step / 8):
            xn = x + t * g; xn /= np.linalg.norm(xn); vn = bound(n, W_of(xn), c)
            if vn > v + 1e-13:
                x, v = xn, vn; break
        else:
            step /= 2
            if step < 1e-7:
                break
    return v, W_of(x)


if __name__ == "__main__":
    _report()
