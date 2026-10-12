"""Does the per-n gap floor hold across gradings, or only inside one sigma-cone?

The closedness of the graded critical set reduces to a lower bound, per n, on the
smallest NONZERO eigenvalue modulus over that set (see findings/nondegeneracy.md).
Among the named product families at n = 12 the floor is 0.038925, attained at the most
unbalanced split; at n = 6 the named floor is S^3 x S^3's 0.210819.  One sigma-cone is
not the graded set, so this sweeps several.

For each involution sigma on R^6 -- and the complex structure, which is the other kind
of Z_2-grading of so(6) -- restrict Weyl_6 to the sigma-invariant subspace, solve
criticality there from many starts, and apply the TWO-condition grading test of
run_grading_test.py to every solution.  Report the smallest gap among the points that
actually pass.

The falsifier is a GRADED critical point at n = 6 whose smallest nonzero |lambda| sits
materially below 0.210819.

Both fixes that run_grading_test.py paid for apply here and are the reason its
block_masses is imported rather than rewritten a third time:
  * the sign of W is normalised so theta > 0, since h and m swap under W -> -W;
  * the h/m split carries a kernel tolerance, since padding's numerical zeros would
    otherwise scatter into m.
"""
import numpy as np, itertools, sys, os
from scipy.optimize import least_squares

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import run_grading_test as GT

n = 6
pr = list(itertools.combinations(range(n), 2))
N = len(pr)
NAMED_FLOOR_N6 = 0.21081851  # S^3 x S^3, the named-family floor at n = 6


def weyl_basis(rng):
    """An orthonormal basis of Weyl_6 inside Sym^2(Lambda^2), by projection and SVD."""
    out = []
    for X in rng.standard_normal((400, n, n, n, n)):
        R = X - X.transpose(1, 0, 2, 3)
        R = R - R.transpose(0, 1, 3, 2)
        R = R + R.transpose(2, 3, 0, 1)
        R = R - (R + R.transpose(1, 2, 0, 3) + R.transpose(2, 0, 1, 3)) / 3
        g = np.eye(n)
        Ric = np.einsum('ikjk->ij', R)
        s = np.trace(Ric)
        E = Ric - s / n * g
        KN = lambda P, Qm: (np.einsum('ik,jl->ijkl', P, Qm) + np.einsum('jl,ik->ijkl', P, Qm)
                            - np.einsum('il,jk->ijkl', P, Qm) - np.einsum('jk,il->ijkl', P, Qm))
        W = R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)
        out.append(np.array([[W[i, j, k, l] for (k, l) in pr] for (i, j) in pr]).ravel())
    U, sv, _ = np.linalg.svd(np.array(out).T, full_matrices=False)
    d0 = n * (n + 1) * (n + 2) * (n - 3) // 12
    assert sv[d0 - 1] > 1e-8 > sv[d0], "the Weyl basis is not cleanly separated"
    return [U[:, k].reshape(N, N) for k in range(d0)]


def struct_consts():
    B = GT.so_basis(n, pr)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for g in range(N):
                c[a, b, g] = GT.ip(C, B[g])
    return c


C3 = struct_consts()


def sharp(M):
    return 0.5 * np.einsum('agd,bez,ge,dz->ab', C3, C3, M, M, optimize=True)


def cone_basis(BW, A):
    """The subspace of Weyl_6 fixed by conjugation by A in O(6), orthonormalised."""
    P = np.zeros((N, N))
    for a, (i, j) in enumerate(pr):
        for b, (k, l) in enumerate(pr):
            P[a, b] = A[i, k] * A[j, l] - A[i, l] * A[j, k]
    BS = [x for x in ((b + P @ b @ P.T) / 2 for b in BW) if np.linalg.norm(x) > 1e-9]
    if not BS:
        return []
    G = np.array([[np.sum(a * b) for b in BS] for a in BS])
    w, V = np.linalg.eigh(G)
    keep = [k for k in range(len(w)) if w[k] > 1e-8]
    return [sum(V[i, k] * BS[i] for i in range(len(BS))) / np.sqrt(w[k]) for k in keep]


def hunt_in(BS, rng, starts):
    d = len(BS)

    def resid(v):
        M = sum(v[i] * BS[i] for i in range(d))
        nm2 = np.sum(M * M)
        Q = M @ M + sharp(M)
        th = np.sum(Q * M) / nm2
        Rr = Q - th * M
        return np.concatenate([[np.sum(Rr * b) for b in BS], [nm2 - 1.0]])

    sols = []
    for _ in range(starts):
        v0 = rng.standard_normal(d)
        M0 = sum(v0[i] * BS[i] for i in range(d))
        v0 /= np.linalg.norm(M0)
        r = least_squares(resid, v0, method='lm', xtol=3e-16, ftol=3e-16,
                          gtol=3e-16, max_nfev=20000)
        if np.linalg.norm(r.fun) > 1e-12:
            continue
        M = sum(r.x[i] * BS[i] for i in range(d))
        M /= np.linalg.norm(M)
        th = float(np.sum((M @ M + sharp(M)) * M))
        if abs(th) < 1e-6:
            continue
        if th < 0:                       # sign normalisation, see the module docstring
            M, th = -M, -th
        sols.append((th, M))
    return sols


def gradings():
    """The involutions of R^6, plus the complex structure. Each generates a Z_2-grading."""
    out = []
    for p in (1, 2, 3):
        s = np.diag([1.0] * p + [-1.0] * (n - p))
        out.append((f"sigma({p},{n-p})", s))
    J = np.zeros((n, n))
    for k in range(0, n, 2):
        J[k + 1, k], J[k, k + 1] = 1.0, -1.0
    out.append(("complex structure J", J))
    return out


def recovery_control(BW, name, A, th33, W33):
    """Can the search find a graded point it is started ON?

    Without this the sweep is uninterpretable: "no graded point found" is a claim about
    the sampler until the sampler is shown able to find one.  S^3 x S^3 lies in three of
    these four cones, so start near it and see whether the solver returns it.

    The recovery RATE, not a single trajectory, is what carries the reading, so this
    samples many directions at each radius.  The row that matters is the largest radius,
    because that is where the sweep's own random starts sit."""
    BS = cone_basis(BW, A)
    if not BS:
        return None
    d = len(BS)
    coef = np.array([np.sum(W33 * b) for b in BS])
    rec = sum(coef[i] * BS[i] for i in range(d))
    inside = np.linalg.norm(rec - W33) / np.linalg.norm(W33)
    if inside >= 1e-8:
        print(f"   control: S^3 x S^3 is NOT in this cone (residual {inside:.2e}), "
              f"so no recovery control is available here")
        return None

    def resid(v):
        M = sum(v[i] * BS[i] for i in range(d))
        nm2 = np.sum(M * M)
        Q = M @ M + sharp(M)
        th = np.sum(Q * M) / nm2
        return np.concatenate([[np.sum((Q - th * M) * b) for b in BS], [nm2 - 1.0]])

    # DIRECTIONS, not one ray.  Re-seeding inside the loop -- which an earlier version
    # did -- samples the same direction at every radius, so three "starts" are three
    # points along one line and the recovery rate they suggest is not a rate at all.
    # Radii are RELATIVE to ||W||, so they are comparable with the sweep's own random
    # starts, which sit at relative radius about 1.
    dirs = 40
    rng_c = np.random.default_rng(4242)
    out = []
    for rel in (1e-3, 1e-2, 3e-2, 1e-1, 3e-1, 1.0):
        hits = 0
        for _ in range(dirs):
            u = rng_c.standard_normal(d)
            u /= np.linalg.norm(u)
            v0 = coef + rel * np.linalg.norm(coef) * u
            r = least_squares(resid, v0, method='lm', xtol=3e-16, ftol=3e-16,
                              gtol=3e-16, max_nfev=20000)
            M = sum(r.x[i] * BS[i] for i in range(d))
            nm = np.linalg.norm(M)
            if nm < 1e-12:
                continue
            M /= nm
            th = float(np.sum((M @ M + sharp(M)) * M))
            if th < 0:
                M, th = -M, -th
            if abs(th - th33) < 1e-6:
                hits += 1
        out.append((rel, hits))
        print(f"   control: relative radius {rel:<5} -> recovered {hits}/{dirs}")
    far = [h for rel, h in out if rel >= 1.0]
    print(f"   the load-bearing figure is the last row: at the radius the sweep's own "
          f"random starts sit at, recovery is {far[0] if far else 0}/{dirs}")
    return out


if __name__ == "__main__":
    STARTS = int(sys.argv[1]) if len(sys.argv) > 1 else 400
    GT.n, GT.pr, GT.N = n, pr, N
    GT.B = GT.so_basis(n, pr)

    print("Controls first -- the grading test must call the two known points correctly.")
    GT.run_controls()

    rng = np.random.default_rng(90210)
    BW = weyl_basis(rng)
    W33, _ = GT.sphere_product_W(3, 3)
    TH33 = float(np.sum((W33 @ W33 + sharp(W33)) * W33))
    assert GT.block_masses(W33)["graded"], "the control point must itself be graded"
    print(f"control point S^3 x S^3: theta = {TH33:.6f}, graded")
    print(f"\ndim Weyl_6 = {len(BW)}   starts per cone = {STARTS}")
    print(f"named-family floor at n=6 (S^3 x S^3): {NAMED_FLOOR_N6:.8f}\n")

    overall = []
    for name, A in gradings():
        BS = cone_basis(BW, A)
        if not BS:
            print(f"{name}: empty invariant subspace, skipped")
            continue
        sols = hunt_in(BS, np.random.default_rng(abs(hash(name)) % (2**31)), STARTS)
        rows = []
        for th, M in sols:
            bm = GT.block_masses(M)
            ev = np.sort(np.abs(np.linalg.eigvalsh(M)))
            gap = next((x for x in ev if x > 1e-9), float('nan'))
            sr = GT.sum_rule_residual(bm, n)
            assert sr < 1e-8, f"sum rule failed at {name}: {sr}"
            rows.append((gap, th, bm))
        graded = [r for r in rows if r[2]['graded']]
        s0_not = [r for r in rows if not r[2]['graded'] and r[2]['S_mmm'] < 1e-9]
        print(f"{name}: dim invariant subspace = {len(BS)}, converged {len(rows)}/{STARTS}")
        print(f"   passing the FULL grading test: {len(graded)}")
        print(f"   S_mmm ~ 0 but UNGRADED: {len(s0_not)}"
              f"   <- what a one-condition test would wrongly accept")
        if graded:
            g = min(graded, key=lambda r: r[0])
            print(f"   smallest gap among GRADED: {g[0]:.8f} at theta = {g[1]:.6f}")
            print(f"      against the named floor {NAMED_FLOOR_N6:.8f} -> "
                  f"{'BELOW IT, FALSIFIER' if g[0] < 0.99 * NAMED_FLOOR_N6 else 'floor holds'}")
            overall.append((g[0], g[1], name))
        else:
            print("   no graded point found in this cone")
        if s0_not:
            w = min(s0_not, key=lambda r: r[0])
            print(f"   the smallest-gap such point: theta={w[1]:.6f} gap={w[0]:.4e} "
                  f"S_hhm={w[2]['S_hhm']:.4f}")
        rec = recovery_control(BW, name, A, TH33, W33)
        if not graded and rec and any(h > 0 for _, h in rec):
            print("   READ THIS: the solver recovers a graded point when started ON one,")
            print("   and random starts found none.  So the count above is a statement")
            print("   about the sampler's reach, not about the graded set.")
        print()

    print("=" * 78)
    if overall:
        g, th, nm = min(overall)
        print(f"smallest gap over every GRADED point found, all cones: {g:.8f}")
        print(f"   at theta = {th:.6f}, in {nm}")
        print(f"   named-family floor: {NAMED_FLOOR_N6:.8f}")
        print("   VERDICT:", "FLOOR FALSIFIED" if g < 0.99 * NAMED_FLOOR_N6 else
              "no falsifier -- the floor survives every cone swept here")
    else:
        print("no graded critical point was found in any cone, so this sweep")
        print("constrains the floor in neither direction.  That is a coverage")
        print("statement about the search, not a fact about the graded set.")
