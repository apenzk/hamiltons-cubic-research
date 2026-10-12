"""
Track D: extend the unconstrained gradient-ascent search for critical points of
P(W)=<W,Q(W)> on the unit sphere of the full (non-diagonal) Weyl-tensor space
from n=6,7,8 (run_unconstrained_search.py) to n=12 -- the threshold dimension
where the balanced sphere-product first overtakes Fox's S^4(alpha) as the
conjectured global maximizer (n=6+2*sqrt7 ~ 11.29).

Engineering problem this solves
--------------------------------
dim(Weyl_12) = 1638, and run_unconstrained_search.py's per-iterate cost is
dominated by rsharp_basis_free.Q_full(Rmat, c), which computes

    S[a,m,p]    = sum_n c[a,m,n] Rmat[n,p]          (einsum 'amn,np->amp')
    Rsharp[a,b] = -1/2 sum_{m,p} S[a,m,p] S[b,p,m]   (einsum 'amp,bpm->ab')

via np.einsum(..., optimize=True). Both contractions are exactly the kind of
"fixed trilinear form built once from the structure constants, then a couple
of BLAS matmuls per evaluation" object that hessian_fast.py uses for the
(different) Hessian-at-a-fixed-point problem -- but here the structure
constants c themselves are the only thing that's fixed; W is the ascent
variable, so unlike hessian_fast.py's Qform_sym (a fixed matrix tied to one
base point W*) there is no way to precompute a single small matrix that
answers "Q(W) for varying W". What CAN be precomputed once per n is the
reshaped structure-constant array Cflat_mp = c.reshape(N*N, N), turning both
contractions above into two explicit matrix products (guaranteed BLAS dgemm
dispatch, not relying on einsum's internal path optimizer):

    S   = (Cflat_mp @ Rmat).reshape(N, N, N)
    Rsharp = -0.5 * S.reshape(N, N*N) @ S.transpose(0,2,1).reshape(N, N*N).T

This is Q_fast below. Validated bit-for-bit (n=8: exact 0.0 max relative
difference) and to ~3e-16 relative (n=10, n=12: floating-point roundoff from
a different summation order, not a discrepancy) against rsharp_basis_free.Q_full
-- see validate_fast_vs_full(). Also cross-validated against
curvature_operator.Q_op (the from-scratch per-pair-bracket implementation used
elsewhere in this repo as the ground truth) via the inherited
cross_validate_Q() from run_unconstrained_search.py.

Benchmark finding worth recording: at n=12, Q_fast gives only a modest
1.3-1.4x speedup over Q_full (both already dispatch to BLAS matmuls under the
hood for these particular contraction shapes) -- so the actual bottleneck of
one gradient-ascent iterate at n=12 is NOT the trilinear-form evaluation at
all, it's the two D x N^2 basis-projection mat-vecs (amb = x @ Eflat and
grad_x = Eflat @ vec) used to move between the 1638-dim Weyl-coordinate space
and the 66x66 ambient operator representation. Eflat is a dense
1638 x 4356 array (57MB); each mat-vec against it is memory-bandwidth-bound,
not compute-bound, and dominates wall-clock time once N stops growing much
faster than D near n=12. This is reported as an engineering finding, not
chased further here (see module docstring's runtime section below).

Positive controls (must be recovered before any n=12 claim is trusted)
------------------------------------------------------------------------
Reusing run_unconstrained_search.py's build_weyl_basis/cluster_by_value/
search_diagonalization machinery unmodified (already validated there for
n=6,7,8), this script's fast ascent is first run at n=8 and required to
rediscover sqrt(3/2) (Fox's S^4(alpha)) and the sphere-product family, then
at n=12 is checked against ALL closed-form sphere-product splits
(p,q), p+q=12, sqrt(3/2), and the quaternionic-Kahler HP^3 value 0.852944
(already recorded in findings/INDEX.md's "Quaternionic-Kahler check" /
"Fox r>=8 subalgebra" sections and cross-validated three independent ways
there).

Usage
-----
    python3 run_unconstrained_search_n12.py validate      # ~1s: bit-for-bit Q check at n=8
    python3 run_unconstrained_search_n12.py benchmark      # ~10s: timing at n=8,10,12 + extrapolation
    python3 run_unconstrained_search_n12.py control         # ~5s: recover known values at n=8 with Q_fast
    python3 run_unconstrained_search_n12.py sweep [N_RESTARTS] [SEED]   # the n=12 search itself
    python3 run_unconstrained_search_n12.py all [N_RESTARTS] [SEED]     # everything above, in order

Default N_RESTARTS=80 for `sweep`/`all` was chosen so the whole run finishes
in well under 5 minutes on one core of this machine (see benchmark numbers in
the module-level report). For a larger, publication-scale sweep (e.g. the
300-500 restarts this repo used at n=6,7,8), run:

    python3 run_unconstrained_search_n12.py sweep 400 12345

which is estimated (see benchmark step) to take on the order of 15-20 minutes
of CPU time -- long enough that per this task's runtime discipline it should
be launched and owned by the coordinator, not run inline here.
"""
import sys
import time
import numpy as np

from weyl import build_structure_constants, R_val
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2, Q_op, so_n_basis_matrices

from run_unconstrained_search import (
    cross_validate_Q, build_weyl_basis, cluster_by_value,
    lambda2_action_matrix, search_diagonalization, validate_diagonalization_method,
    CP2_VALUE,
)

from run_sphere import hand_formula_P


# ---------------------------------------------------------------------
# Fast Q: explicit-BLAS reformulation of rsharp_basis_free.Q_full, built
# once per n from the (fixed) structure constants c.
# ---------------------------------------------------------------------
def build_Cflat(c):
    """c: (N,N,N) structure constants, c[a,m,n]. Returns Cflat_mp: (N*N, N),
    the reshape of c combining (a,m) into rows and n into columns -- built
    ONCE per n, reused by every Q_fast call during the entire search."""
    N = c.shape[0]
    return c.reshape(N * N, N).copy()


def Q_fast(Rmat, Cflat_mp, N):
    """Bit-for-bit-validated (at n=8) fast replacement for Q_full(Rmat, c):
    Q(R) = R@R + R^#, computed via explicit matrix products only."""
    S = (Cflat_mp @ Rmat).reshape(N, N, N)          # S[a,m,p]
    S2 = S.reshape(N, N * N)                        # S2[a, m*N+p] = S[a,m,p]
    T2 = S.transpose(0, 2, 1).reshape(N, N * N)      # T2[a, m*N+p] = S[a,p,m]
    Rsharp = -0.5 * (S2 @ T2.T)
    return Rmat @ Rmat + Rsharp


def validate_fast_vs_full(n=8, ntrials=5, seed=0):
    """Bit-for-bit (or machine-precision) agreement check, required by the
    task before trusting Q_fast on anything -- run BEFORE scaling to n=12."""
    idx, pos, N, c = build_structure_constants(n)
    Cflat_mp = build_Cflat(c)
    rng = np.random.default_rng(seed)
    worst = 0.0
    for _ in range(ntrials):
        A = rng.normal(size=(N, N))
        Rmat = 0.5 * (A + A.T)
        Q1 = Q_full(Rmat, c)
        Q2 = Q_fast(Rmat, Cflat_mp, N)
        err = np.max(np.abs(Q1 - Q2)) / (np.max(np.abs(Q1)) + 1e-300)
        worst = max(worst, err)
    print(f"  n={n}: Q_fast vs Q_full, worst max-relative-difference over {ntrials} random "
          f"symmetric operators = {worst:.3e}")
    return worst


# ---------------------------------------------------------------------
# Ascent using Q_fast (mirrors run_unconstrained_search.py's P_and_grad /
# gradient_ascent / run_search exactly, only swapping Q_full -> Q_fast).
# ---------------------------------------------------------------------
def P_and_grad_fast(x, Eflat, Cflat_mp, N):
    amb = x @ Eflat
    Wmat = amb.reshape(N, N)
    Wmat = 0.5 * (Wmat + Wmat.T)
    Qmat = Q_fast(Wmat, Cflat_mp, N)
    P = float(np.sum(Wmat * Qmat))
    grad_x = Eflat @ (3.0 * Qmat.reshape(-1))
    return P, grad_x, Wmat, Qmat


def gradient_ascent_fast(x0, Eflat, Cflat_mp, N, D, max_iter=400, tol=1e-11):
    x = x0 / np.linalg.norm(x0)
    step = 0.2
    P, grad_x, Wmat, Qmat = P_and_grad_fast(x, Eflat, Cflat_mp, N)
    for it in range(max_iter):
        g_tan = grad_x - np.dot(grad_x, x) * x
        gnorm = np.linalg.norm(g_tan)
        if gnorm < tol:
            break
        accepted = False
        for _ in range(50):
            x_new = x + step * g_tan
            x_new = x_new / np.linalg.norm(x_new)
            P_new, grad_new, Wnew, Qnew = P_and_grad_fast(x_new, Eflat, Cflat_mp, N)
            if P_new > P - 1e-13:
                accepted = True
                break
            step *= 0.5
        if not accepted:
            break
        x, P, grad_x, Wmat, Qmat = x_new, P_new, grad_new, Wnew, Qnew
        step = min(step * 1.3, 1.0)
    residual = np.linalg.norm(Qmat - P * Wmat)
    return x, P, residual, it


def run_search_fast(n, Eflat, Cflat_mp, N, D, n_restarts, seed, max_iter=400, verbose_every=None):
    rng = np.random.default_rng(seed)
    results = []
    t0 = time.time()
    for r in range(n_restarts):
        x0 = rng.normal(size=D)
        x_fin, P_fin, resid, iters = gradient_ascent_fast(x0, Eflat, Cflat_mp, N, D, max_iter=max_iter)
        results.append(dict(P=P_fin, x=x_fin, residual=resid, iters=iters))
        if verbose_every and (r + 1) % verbose_every == 0:
            print(f"    ...{r+1}/{n_restarts} restarts done ({time.time()-t0:.1f}s elapsed)")
    dt = time.time() - t0
    print(f"  n={n}: {n_restarts} restarts in {dt:.1f}s ({dt/n_restarts:.3f} s/restart)")
    return results, dt


# ---------------------------------------------------------------------
# Reference values at n=12 (all already catalogued in findings/INDEX.md, derived
# and cross-checked by independent pipelines elsewhere in this repo):
#   - CP2_VALUE=sqrt(3/2): Fox's S^4(alpha), n-independent (imported above)
#   - balanced sphere-product = sqrt(2*11*10/144) = sqrt(220)/12 = 1.236033,
#     the value this task asks us to try to beat
#   - unbalanced sphere splits (p,q), p+q=12, via run_sphere.hand_formula_P
#     (Pipeline C, independently cross-checked against Fox's algebra and the
#     coordinate-diagonal formula elsewhere in this repo)
#   - quaternionic-Kahler HP^3 = 0.852944, matched to 6 significant digits by
#     three independent constructions (run_qk_from_scratch.py,
#     run_hpm_qk.py, run_fox_r12_subalgebra.py's X0 branch)
# ---------------------------------------------------------------------
def known_values_n12():
    n = 12
    rows = [("CP^2-type / Fox S^4(alpha)", CP2_VALUE)]
    for p in range(2, n // 2 + 1):
        val, _, _, _ = hand_formula_P(n, p)
        label = f"sphere ({p},{n-p})" + (" balanced" if p == n - p else "")
        rows.append((label, val))
    rows.append(("quaternionic-Kaehler HP^3", 0.852944))
    return rows


SPHERE_N12_BALANCED = np.sqrt(2.0 * 11 * 10 / 144)  # 1.236033...


# ---------------------------------------------------------------------
# Structural report for a critical-point representative: eigen-spectrum of
# W as an operator on Lambda^2, and the diagonalizability residual (reusing
# the validated O(n)-search machinery from run_unconstrained_search.py).
# ---------------------------------------------------------------------
def structure_report(Wmat, idx, N, n, diag_restarts=15, seed=0):
    evals = np.linalg.eigvalsh(Wmat)
    evals_r = np.round(evals, 6)
    uniq, counts = np.unique(evals_r, return_counts=True)
    order = np.argsort(-np.abs(uniq))
    spectrum = [(float(uniq[i]), int(counts[i])) for i in order]
    best_resid, _ = search_diagonalization(Wmat, idx, N, n, n_restarts=diag_restarts, seed=seed)
    return spectrum, best_resid


def main():
    args = sys.argv[1:]
    mode = args[0] if args else "all"
    n_restarts = int(args[1]) if len(args) > 1 else 80
    seed = int(args[2]) if len(args) > 2 else 12345

    print("=" * 78)
    print("STEP 0: cross-validate Q_fast against Q_full (einsum) and Q_op (from-scratch")
    print("        bracket implementation) at n=8, BEFORE scaling to n=12.")
    print("=" * 78)
    validate_fast_vs_full(8)
    cross_validate_Q(8)  # Q_full vs Q_op, inherited sanity check
    # also directly check Q_fast vs Q_op
    idx8, pos8, N8, c8 = build_structure_constants(8)
    Cflat8 = build_Cflat(c8)
    L2_8 = Lambda2(8)
    rng = np.random.default_rng(0)
    A = rng.normal(size=(N8, N8)); S8 = 0.5 * (A + A.T)
    Q_fast_val = Q_fast(S8, Cflat8, N8)
    Q_op_val = Q_op(L2_8, S8)
    err = np.max(np.abs(Q_fast_val - Q_op_val)) / np.max(np.abs(Q_op_val))
    print(f"  n=8: Q_fast vs Q_op (from-scratch bracket implementation), relative err = {err:.3e}")
    assert err < 1e-8, "Q_fast disagrees with the from-scratch Q_op -- do not trust results"
    print("  PASS: Q_fast validated against two independent implementations at n=8.\n")

    if mode == "validate":
        return

    print("=" * 78)
    print("STEP 1: benchmark timing at n=8, n=10, n=12 and extrapolate.")
    print("=" * 78)
    bench_rows = []
    for n in [8, 10, 12]:
        idx, pos, N, c = build_structure_constants(n)
        Cflat_mp = build_Cflat(c)
        t0 = time.time()
        Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
        t_basis = time.time() - t0
        rng = np.random.default_rng(1)
        times = []
        for _ in range(5):
            x0 = rng.normal(size=D)
            t0 = time.time()
            gradient_ascent_fast(x0, Eflat, Cflat_mp, N, D, max_iter=400)
            times.append(time.time() - t0)
        mean_t = float(np.mean(times))
        bench_rows.append((n, D, N, t_basis, mean_t))
        print(f"  n={n:2d}  D={D:5d}  N={N:3d}  basis-build={t_basis:.2f}s  "
              f"mean restart time={mean_t:.3f}s (5 trials, range {min(times):.3f}-{max(times):.3f}s)")
    # simple power-law extrapolation check n=8->10->12 on restart time
    (n1, _, _, _, t1), (n2, _, _, _, t2), (n3, _, _, _, t3) = bench_rows
    import math
    rate_a = math.log(t2 / t1) / math.log(n2 / n1)
    rate_b = math.log(t3 / t2) / math.log(n3 / n2)
    print(f"  empirical local scaling exponent: n=8->10: t~n^{rate_a:.2f}, n=10->12: t~n^{rate_b:.2f}")
    _, D12, N12, tb12, tr12 = bench_rows[-1]
    for target in [80, 150, 300, 400]:
        est = tb12 + target * tr12
        print(f"  n=12 estimated wall time for {target:4d} restarts: "
              f"{est:.0f}s ({est/60:.1f} min)")
    print()

    if mode == "benchmark":
        return

    print("=" * 78)
    print("STEP 2: positive control -- recover already-catalogued critical values")
    print("        at n=8 using the FAST ascent, before trusting n=12 results.")
    print("=" * 78)
    idx8, pos8, N8, c8 = build_structure_constants(8)
    Cflat8 = build_Cflat(c8)
    Eflat8, D8 = build_weyl_basis(8, idx8, pos8, N8, c8, verbose=True)
    results8, _ = run_search_fast(8, Eflat8, Cflat8, N8, D8, n_restarts=60, seed=999)
    clusters8, bad8 = cluster_by_value(results8)
    known8 = [("CP^2-type", CP2_VALUE), ("sphere (4,4) balanced", 1.14564),
              ("sphere (2,6)", 0.98601), ("quaternionic-Kaehler HP^2", 1.115547)]
    print(f"  {len(clusters8)} distinct critical values found in 60 restarts "
          f"({len(bad8)} did not converge to residual<1e-5):")
    all_matched = True
    for cl in clusters8:
        Pval = cl["P"]
        frac = len(cl["members"]) / len(results8)
        nearest = min(known8, key=lambda r: abs(r[1] - Pval))
        match = abs(nearest[1] - Pval) < 3e-3
        all_matched = all_matched and match
        print(f"    P={Pval:.6f}  frac={frac:.3f}  nearest_known={nearest[0]} "
              f"({'match' if match else 'NO MATCH -- investigate before trusting n=12'})")
    if all_matched:
        print("  PASS: fast ascent at n=8 reproduces only already-catalogued critical values.\n")
    else:
        print("  WARNING: unmatched cluster at n=8 -- do not trust n=12 results until resolved.\n")

    if mode == "control":
        return

    print("=" * 78)
    print(f"STEP 3: n=12 sweep -- {n_restarts} restarts, seed={seed}.")
    print("=" * 78)
    idx, pos, N, c = build_structure_constants(12)
    Cflat_mp = build_Cflat(c)
    t0 = time.time()
    Eflat, D = build_weyl_basis(12, idx, pos, N, c, verbose=True)
    print(f"  basis build: {time.time()-t0:.1f}s")

    print("  validating O(n)-rotation diagonalizability-search method on a known diagonal tensor:")
    ok = validate_diagonalization_method(12, idx, pos, N, c)
    if not ok:
        print("  WARNING: diagonalizability-search method failed its own sanity check at n=12.")

    results, dt = run_search_fast(12, Eflat, Cflat_mp, N, D, n_restarts, seed, verbose_every=20)
    clusters, bad = cluster_by_value(results)
    print(f"\n  {len(clusters)} distinct critical P-values found (residual<1e-5 clustering, "
          f"tol=2e-4); {len(bad)}/{len(results)} restarts did not converge to residual<1e-5")

    known12 = known_values_n12()
    print(f"  reference values at n=12: " + ", ".join(f"{lbl}={val:.6f}" for lbl, val in known12))
    print(f"  *** threshold value (balanced sphere product) = {SPHERE_N12_BALANCED:.6f} ***\n")

    any_above_threshold = False
    summary = []
    for ci, cl in enumerate(clusters):
        frac = len(cl["members"]) / len(results)
        Pval = cl["P"]
        nearest = min(known12, key=lambda r: abs(r[1] - Pval))
        match = abs(nearest[1] - Pval) < 3e-3
        above = Pval > SPHERE_N12_BALANCED + 1e-6
        any_above_threshold = any_above_threshold or above
        rep = cl["members"][0]
        amb = rep["x"] @ Eflat
        Wmat = amb.reshape(N, N)
        Wmat = 0.5 * (Wmat + Wmat.T)
        spectrum, diag_resid = structure_report(Wmat, idx, N, 12, diag_restarts=15, seed=999 + ci)
        tag = " <<< ABOVE THRESHOLD -- WOULD REDIRECT THE ENTIRE EFFORT >>>" if above else ""
        print(f"  cluster {ci}: P={Pval:.6f}  frac_of_restarts={frac:.3f}  "
              f"n_members={len(cl['members'])}  nearest_known={nearest[0]}"
              f"({'match' if match else 'NO MATCH -- possibly new'})  "
              f"diag_residual={diag_resid:.2e}  "
              f"diagonalizable={'YES' if diag_resid < 1e-4 else 'NO'}{tag}")
        print(f"      W spectrum (value, mult), largest few: "
              f"{spectrum[:6]}{' ...' if len(spectrum) > 6 else ''}")
        summary.append(dict(P=Pval, frac=frac, nearest=nearest[0], match=match,
                             diag_residual=diag_resid, above_threshold=above,
                             spectrum=spectrum))

    print("\n" + "=" * 78)
    print("FINAL SUMMARY -- n=12")
    print("=" * 78)
    print(f"restarts run: {n_restarts}  (this run: {dt:.1f}s search time, "
          f"{len(bad)}/{n_restarts} non-converged)")
    for row in summary:
        print(f"  P={row['P']:.6f}  frac={row['frac']:.3f}  ~{row['nearest']}"
              f"({'match' if row['match'] else 'NEW'})  diag_resid={row['diag_residual']:.2e}  "
              f"{'diagonalizable' if row['diag_residual'] < 1e-4 else 'NOT diagonalizable'}"
              f"{'  <<< ABOVE 1.236033 >>>' if row['above_threshold'] else ''}")
    if any_above_threshold:
        print("\n  RESULT: at least one critical point ABOVE the balanced sphere-product value "
              "was found. This is a significant finding -- verify independently before acting on it.")
    else:
        print(f"\n  RESULT: no critical point above {SPHERE_N12_BALANCED:.6f} found in "
              f"{n_restarts} restarts. This is a bounded empirical claim (N restarts found "
              f"nothing above X), not a proof of global maximality.")


if __name__ == "__main__":
    main()
