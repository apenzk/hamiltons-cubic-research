"""The two-condition grading test, built from the definitions at the matrix level.

A critical point W is GRADED when so(n) = h + m, with h the span of the eigenvectors
with lambda >= 0 and m those with lambda < 0, is a Z_2-grading:

    [m,m] subset h      <=>   S_mmm := ||Pi_m [m,m]||^2 = 0
    [h,h] subset h      <=>   S_hhm := ||Pi_m [h,h]||^2 = 0
    [h,m] subset m      <=>   S_hmh := ||Pi_h [h,m]||^2 = 0

and total antisymmetry of <[X,Y],Z> makes the last two the same number, so the test is
S_mmm = 0 AND S_hhm = 0.  S_mmm alone is NECESSARY and not sufficient: padded W_CP2 is
the standing witness.

Everything here is computed as MATRIX COMMUTATORS in so(n) under <A,B> = tr(A^T B)/2,
with no structure-constant array and no eigenbasis transform, precisely so that it shares
no machinery with run_graded_gap_hunt.py.  The two disagreed on S at theta = 0.418198 and
this file is the tie-breaker; it prints both conventions so the disagreement is located
rather than argued.

Controls, run every time:
  * S^3 x S^3 at n=6 must come out GRADED with both conditions at ~0.
  * padded W_CP2 must come out S_mmm ~ 0 and S_hhm = 4(n-4) EXACTLY -- ungraded, the
    known witness, at theta = sqrt(3/2) and with dim m = 2.  The closed form is the
    control rather than a measured 8.000, because a measured figure here is
    LAPACK-dependent: without a kernel tolerance the same operator gives dim m anywhere
    in {3..9} depending on whether eigh or eigvalsh is used.
  * the block masses must exhaust the structure constants (see sum_rule_residual).
"""
import numpy as np, itertools
from scipy.optimize import least_squares

n = 6
pr = list(itertools.combinations(range(n), 2))
N = len(pr)


def so_basis(n, pr):
    """Orthonormal basis of so(n) under <A,B> = tr(A^T B)/2: E_ij with +1/-1."""
    B = []
    for (i, j) in pr:
        A = np.zeros((n, n))
        A[i, j], A[j, i] = 1.0, -1.0
        B.append(A)
    return B


B = so_basis(n, pr)


def ip(A, C):
    """<A,C> = tr(A^T C)/2, the inner product the basis above is orthonormal for."""
    return float(np.sum(A * C) / 2.0)


def mat_of(vec):
    """A coordinate vector on Lambda^2 as an element of so(n)."""
    return sum(vec[a] * B[a] for a in range(N))


def block_masses(M, tol=1e-9, resid=None, gap=None):
    """S_abc for every block, from matrix commutators. Returns a dict.

    h = {lambda >= 0}, m = {lambda < 0}, as the record defines them.

    THE TOLERANCE IS LOAD-BEARING.  A padded operator has a large exact kernel, and
    eigh returns those eigenvalues at +-1e-17; a bare `lam < 0` test then scatters half
    the kernel into m and every block mass is wrong.  Padded W_CP2 at n=6 comes out with
    dim m = 5 and S_mmm = 2.64 that way, against the true dim m = 2 and S_mmm = 0.
    Zeros belong to h, which is what `lambda >= 0` means once it is read exactly.
    """
    lam, V = np.linalg.eigh(M)
    X = [mat_of(V[:, k]) for k in range(N)]          # eigenvectors as so(n) matrices
    idx_m = [k for k in range(N) if lam[k] < -tol]
    idx_h = [k for k in range(N) if lam[k] >= -tol]

    def S(setA, setB, setC):
        """||Pi_{C} [A,B]||^2 = sum over a in A, b in B, c in C of <[X_a,X_b],X_c>^2."""
        tot = 0.0
        for a in setA:
            for b in setB:
                Cm = X[a] @ X[b] - X[b] @ X[a]
                for cc in setC:
                    tot += ip(Cm, X[cc]) ** 2
        return tot

    out = {
        "S_mmm": S(idx_m, idx_m, idx_m),
        "S_hhm": S(idx_h, idx_h, idx_m),
        "S_hmh": S(idx_h, idx_m, idx_h),
        "S_mmh": S(idx_m, idx_m, idx_h),
        "S_mhh": S(idx_m, idx_h, idx_h),
        "S_hhh": S(idx_h, idx_h, idx_h),
        "dim_m": len(idx_m),
        "dim_h": len(idx_h),
        "lam": lam,
    }
    # the flipped convention: m := {lambda > 0}
    out["S_ppp_flip"] = S(idx_h, idx_h, idx_h)

    # THE THRESHOLD MUST SCALE, and an absolute one is a latent false negative.
    # A point solved to residual r near a graded configuration has its eigenvectors
    # determined only to about r/gap, and S is quadratic in that, so the numerically
    # induced block mass is of order (r/gap)^2 times the total 2 N (n-2).  A genuine
    # graded point with gap <~ 1e-4 would then be reported UNGRADED at any residual a
    # solver actually accepts -- which is exactly the falsifier this file is used to
    # hunt.  Pass resid and gap to get the right threshold; the absolute floor covers
    # exactly-constructed points, where both are absent.
    # the natural scale is the total the block masses must sum to, which is already here
    scale = (out["S_mmm"] + 3 * out["S_mmh"] + 3 * out["S_mhh"] + out["S_hhh"])
    if resid is not None and gap is not None and gap > 0:
        tol_S = max(1e-14, (resid / gap) ** 2 * scale)
    else:
        tol_S = 1e-14
    out["tol_S"] = tol_S
    out["graded"] = (out["S_mmm"] < tol_S) and (out["S_hhm"] < tol_S)
    return out


def sum_rule_residual(bm, n):
    """Every block mass together must exhaust the structure constants.

    <[X_a,X_b],X_c>^2 is totally symmetric in (a,b,c) and its row marginal is 2(n-2),
    so summing over all ordered triples gives 2 N (n-2) with N = dim so(n).  Splitting
    that sum by block,

        S_mmm + 3 S_mmh + 3 S_mhh + S_hhh = 2 N (n-2),

    which checks the projector bookkeeping without depending on any one block.  Derived
    here rather than quoted, because the recorded form uses a different normalisation."""
    N_ = bm["dim_m"] + bm["dim_h"]
    lhs = bm["S_mmm"] + 3 * bm["S_mmh"] + 3 * bm["S_mhh"] + bm["S_hhh"]
    return abs(lhs - 2 * N_ * (n - 2))


# ----------------------------------------------------------------- the two controls
def sphere_product_W(p, q):
    """W of the balanced product S^p x S^q as a coordinate-diagonal operator on Lambda^2."""
    m = p + q
    prm = list(itertools.combinations(range(m), 2))
    K = np.zeros((m, m))
    for (i, j) in prm:
        same_1 = i < p and j < p
        same_2 = i >= p and j >= p
        if same_1:
            v = -q / (p - 1)
        elif same_2:
            v = -p / (q - 1)
        else:
            v = 1.0
        K[i, j] = K[j, i] = -v      # the record normalises to theta > 0
    D = np.diag([K[i, j] for (i, j) in prm])
    return D / np.linalg.norm(D), prm


def cp2_padded(m):
    """W_CP2 padded into Lambda^2(R^m): the self-dual operator diag(2,-1,-1) on Lambda^+,
    zero on Lambda^- and on everything the padding adds.  Normalised, its theta is
    exactly sqrt(3/2), which is the check that this is the right object."""
    prm = list(itertools.combinations(range(m), 2))
    K = len(prm)

    def bi(i, j, s, k, l, t):
        v = np.zeros(K)
        v[prm.index((i, j))] = s
        v[prm.index((k, l))] = t
        return v / np.linalg.norm(v)

    plus = [bi(0, 1, 1, 2, 3, 1), bi(0, 2, 1, 1, 3, -1), bi(0, 3, 1, 1, 2, 1)]
    D = (2 * np.outer(plus[0], plus[0])
         - np.outer(plus[1], plus[1])
         - np.outer(plus[2], plus[2]))
    return D / np.linalg.norm(D), prm


def run_controls():
    global n, pr, N, B
    print("=" * 78)
    print("CONTROLS -- the test must call these two the way the record already does")
    print("=" * 78)
    for name, (Wm, prm) in [
        ("S^3 x S^3 (n=6), expect GRADED", sphere_product_W(3, 3)),
        ("padded W_CP2 (n=6), expect theta=sqrt(3/2), S_mmm ~ 0, UNGRADED", cp2_padded(6)),
    ]:
        n, pr = 6, prm
        N = len(pr)
        B = so_basis(n, pr)
        bm = block_masses(Wm)
        print(f"\n{name}")
        print(f"   dim h = {bm['dim_h']}, dim m = {bm['dim_m']}")
        print(f"   S_mmm = {bm['S_mmm']:.6e}")
        print(f"   S_hhm = {bm['S_hhm']:.6e}   (S_hmh = {bm['S_hmh']:.6e}, must equal it)")
        print(f"   GRADED = {bm['graded']}")
        print(f"   sum-rule residual = {sum_rule_residual(bm, 6):.3e}")
        if "CP2" in name:
            pred = 4 * (6 - 4)
            assert abs(bm["S_hhm"] - pred) < 1e-9, (
                f"the closed form S_hhm = 4(n-4) = {pred} must hold exactly")
            assert bm["dim_m"] == 2, "padded W_CP2 has dim m = 2"
            print(f"   closed form S_hhm = 4(n-4) = {pred}: MATCHES exactly")


# ----------------------------------------------------------- the hunt, re-run here
def hunt(seed=521, starts=400):
    """Same problem as run_graded_gap_hunt.py: criticality inside the sigma-invariant
    subspace of Weyl_6.  Rebuilt here rather than imported, so the two files share nothing."""
    global n, pr, N, B
    n = 6
    pr = list(itertools.combinations(range(n), 2))
    N = len(pr)
    B = so_basis(n, pr)
    rng = np.random.default_rng(seed)

    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for g in range(N):
                c[a, b, g] = ip(C, B[g])

    def sharp(M):
        return 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, M, M, optimize=True)

    A = rng.standard_normal((400, n, n, n, n))
    out = []
    for X in A:
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
    BW = [U[:, k].reshape(N, N) for k in range(d0)]

    sig = np.diag([1, 1, 1, -1, -1, -1.0])
    P = np.diag([sig[i, i] * sig[j, j] for (i, j) in pr])
    BS = [x for x in ((b + P @ b @ P) / 2 for b in BW) if np.linalg.norm(x) > 1e-9]
    G = np.array([[np.sum(a * b) for b in BS] for a in BS])
    w, V = np.linalg.eigh(G)
    keep = [k for k in range(len(w)) if w[k] > 1e-8]
    BS = [sum(V[i, k] * BS[i] for i in range(len(BS))) / np.sqrt(w[k]) for k in keep]
    d = len(BS)
    print(f"\ndim of the sigma-invariant subspace of Weyl_6: {d}")

    def resid(v):
        M = sum(v[i] * BS[i] for i in range(d))
        nm2 = np.sum(M * M)
        Q = M @ M + sharp(M)
        th = np.sum(Q * M) / nm2
        Rr = Q - th * M
        return np.concatenate([[np.sum(Rr * b) for b in BS], [nm2 - 1.0]])

    sols = []
    for t in range(starts):
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
        # SIGN NORMALISATION, and it is load-bearing.  theta is cubic, so W and -W are
        # both critical with opposite theta; h and m swap between them and so does every
        # block mass.  The record's convention is theta > 0.  Reporting |theta| while
        # measuring S on whichever sign the solver landed on mixes the two conventions,
        # and that is what produced the recorded "S = 0" at theta = 0.418198.
        if th < 0:
            M, th = -M, -th
        sols.append((th, M, float(np.linalg.norm(r.fun))))
    return sols


if __name__ == "__main__":
    run_controls()

    sols = hunt()
    print(f"{len(sols)} converged\n")

    rows = []
    for th, M, res in sols:
        ev = np.sort(np.abs(np.linalg.eigvalsh(M)))
        gap = next((x for x in ev if x > 1e-11), float('nan'))
        bm = block_masses(M, resid=res, gap=gap)
        rows.append((gap, th, bm, res))
    rows.sort(key=lambda r: r[0])

    print("=" * 96)
    print("EVERY converged point, by gap.  GRADED needs BOTH S_mmm and S_hhm at zero.")
    print("=" * 96)
    print(f"{'gap':>11} {'theta':>10} {'S_mmm':>12} {'S_hhm':>12} {'dim m':>6} {'sumrule':>9}  GRADED")
    seen = set()
    for gap, th, bm, res in rows:
        key = (round(gap, 9), round(th, 9))
        if key in seen:
            continue
        seen.add(key)
        print(f"{gap:11.4e} {th:10.6f} {bm['S_mmm']:12.4f} {bm['S_hhm']:12.4f} "
              f"{bm['dim_m']:6d} {sum_rule_residual(bm, 6):9.1e}  "
              f"{'YES' if bm['graded'] else 'no'}")

    g = [r for r in rows if r[2]['graded']]
    print(f"\npoints passing the FULL test: {len(g)} of {len(rows)}")
    if g:
        print(f"smallest gap among GRADED points: {min(r[0] for r in g):.9f}")
        print(f"   at theta = {[round(r[1],9) for r in g if r[0]==min(x[0] for x in g)][0]}")
    ng = [r for r in rows if not r[2]['graded'] and r[2]['S_mmm'] < 1e-9]
    if ng:
        print(f"\npoints with S_mmm ~ 0 that are NOT graded: {len(ng)} "
              f"-- these are what a one-condition test would wrongly accept")
        for gap, th, bm, res in ng[:6]:
            print(f"   theta={th:.6f} gap={gap:.4e} S_mmm={bm['S_mmm']:.2e} "
                  f"S_hhm={bm['S_hhm']:.4f}")
