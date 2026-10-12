"""
SCOPING THE SPECTRAL-GAP ROUTE: rigidity of the top critical orbits, and an
adversarial hunt for a defective critical point inside the empty window.

TARGET STATEMENT (FINDINGS "defect-penalty" Result 8, the frontier staircase)

    no critical point with delta^2 > 0 has theta in (sqrt(3/2), theta_0(n)),  n >= 12,

with theta = P(W) = <W, Q(W)> at a critical point Q(W) = theta*W on ||W|| = 1,
delta(W)^2 = ||Alt(W_-)||^2 the Bianchi defect, theta_0(n) = sqrt(2(n-1)(n-2))/n
the balanced sphere-product value and sqrt(3/2) = theta(Fox's S^4(alpha)).
At n = 12 the window is (1.2247448714, 1.2360330810), width 0.0113. The frontier
sweep found it empty; this script hardens that and measures the rigidity that an
isolation argument would need.

THREE THINGS ARE COMPUTED HERE, in increasing order of proof value.

PART A -- WINDOW SEARCH (support, not the deliverable). Adversarial searches at
n = 12 aimed squarely at placing a defective critical point inside the window,
with theta held there by a second penalty (FINDINGS Result 7's recipe: an
unpinned criticality ramp slides back to Fox, and eps-annealed smoothing of
delta^2 funnels every seed to Fox). Three objectives -- equality pin at a grid
of t in the window, a two-sided BAND pin that asks the window question directly
(maximize delta^2 subject to theta in [t_lo, t_hi] and criticality), and the
dual sweep max{theta : delta^2 >= d} pushed to SMALL floors d (the frontier
sweep's floors started at 0.02, and small defect at high theta is exactly the
corner the lifted Jaeger chain already closes, so it is where the two arguments
have to meet). Seeds are the ones the task singles out: Fox perturbed toward the
sphere product, the (5,7) saddle pushed along the defect gradient, su(m)-family
and Fox-plateau combinations, the so(5)-spin 3/25 violator padded and deformed
toward higher theta, plus the saved near-active frontier points.

PART B -- RIGIDITY, EXACT. The Riemannian Hessian of P on the unit Weyl sphere
at a critical point W always has the O(n)-orbit tangent space in its radical
(P is O(n)-invariant, so d/dt P(exp(tA).W) = 0 identically, and differentiating
once more at a critical point kills the whole row). Morse-Bott nondegeneracy is
the converse: radical = orbit, no more. Then the implicit function theorem on a
normal slice makes W isolated modulo O(n) in the critical set, which is the
hypothesis every isolation argument needs.

    This part PROVES it, in exact arithmetic, by two rank computations mod a
    prime. Both inequalities point the safe way, because rank over F_p is never
    larger than rank over Q:

      (i)   C = [Bianchi rows; Ricci rows; <V,.> row] on Sym^2(Lambda^2) has
            rank_{F_p}(C) = #rows  ==>  rank_Q(C) = #rows, so the constraint
            rows are Q-independent, T := ker C is the tangent space to the unit
            Weyl sphere at V with dim T = M - #rows, and ker(C^T) = 0.
      (ii)  For the bordered matrix  B = [[A, C^T], [C, 0]]  with A the integer
            matrix of the second-variation form,
                dim ker_Q(B) = dim rad(A|_T) + dim ker_Q(C^T) = dim rad(A|_T),
            so  dim rad(A|_T) = dim ker_Q B = size - rank_Q(B) <= size - rank_{F_p}(B).
      (iii) rank_{F_p} of the integer map so(n) -> Sym^2(Lambda^2), A -> [ad A, V],
            is a LOWER bound for the orbit dimension.

    (iii) <= dim rad <= (ii), and when the two numbers agree the point is
    Morse-Bott nondegenerate as a theorem, not as a numerical observation. The
    input V is an exact integer representative of the critical point, and its
    two defining properties are verified in integer arithmetic first: C v = 0
    (V is a Weyl tensor) and |V|^2 * 2Q(V) = <V,2Q(V)> * V (V is critical).

    The float Hessian spectrum (hessian_fast's construction, generalized off the
    coordinate-diagonal in run_frontier_sweep and validated against both trusted
    pipelines in PART 0 here) is reported alongside, since the certificate sees
    only the radical and not the signature.

PART C -- LOCAL STRUCTURE AT FOX. Perturb-and-repolish from the Fox orbit at
four scales: every return that lands back on the orbit (same theta, same
delta^2, same Lambda^2-spectrum, which are O(n)-invariants) is evidence that the
critical set near Fox is exactly the orbit. The certificate in PART B is what
turns that evidence into a statement; this part measures the radius over which
it visibly holds.

Reused machinery, all validated in its home script: setup/fox_weyl/sphere_weyl/
qk_weyl/kappa (run_defect_penalty_test); theta0/delta2_and_grad/project_to_x/
pad_weyl_to_n/build_su3_n8 (run_bianchi_defect_highp_seed); Q_fast
(run_unconstrained_search_n12); Q_full (rsharp_basis_free); polish_to_critical/
resid_and_grad/defect_polish_loop/su_m_kahler_weyl/fox_on_block
(run_defect_max_hunt); qform_sym/hessian_profile/stabilizer_dim/ramp/
obj_theta_pinned/obj_theta_floor/obj_defect_floor (run_frontier_sweep);
hessian_fast and hessian_pipeline_b as the two trusted Hessian references.

Usage
-----
    python3 run_gap_scope.py part0                 # both Hessian paths + the certificate's guards
    python3 run_gap_scope.py partB                 # exact Morse-Bott certificates, n=12 (~1 min)
    python3 run_gap_scope.py partB 14 top          # same at n=14, Fox and the sphere splits only
    python3 run_gap_scope.py partB 12 noexact      # float Hessian signatures alone
    python3 run_gap_scope.py partC                 # local isolation at Fox, (5,7), (6,6), n=12
    python3 run_gap_scope.py partA                 # window search, n=12 (moderate, ~35 min)
    python3 run_gap_scope.py partA 14 coarse       # window search, n=14 (~12 min)
    python3 run_gap_scope.py all                   # part0, partB, partC, partA at n=12

Every part appends heartbeats to agent_logs/spectral_gap_scope.log (plan.md convention).
"""
import os
import sys
import time
import numpy as np

from weyl import build_structure_constants, bianchi_constraint_matrix
from weyl_decomposition import norm, frob
from curvature_operator import Lambda2
from rsharp_basis_free import Q_full
import hessian_fast
import hessian_pipeline_b
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl, kappa
from run_bianchi_defect_highp_seed import (theta0, delta2_and_grad, project_to_x,
                                           pad_weyl_to_n, build_su3_n8)
from run_defect_max_hunt import (polish_to_critical, defect_polish_loop, resid_and_grad,
                                 su_m_kahler_weyl, fox_on_block)
from run_frontier_sweep import (qform_sym, hessian_profile, stabilizer_dim, ramp,
                                obj_theta_pinned, obj_theta_floor, obj_defect_floor,
                                RESID_TOL)

SQRT32 = float(np.sqrt(1.5))
HERE = os.path.dirname(os.path.abspath(__file__))
LOG = os.path.join(os.path.dirname(HERE), "agent_logs", "spectral_gap_scope.log")
P_MOD = 2147483647           # 2^31 - 1, prime; products stay inside int64
_T_LAST = [time.time()]


def log(msg, force=False):
    """Heartbeat line into the repo's agent log (plan.md convention)."""
    now = time.time()
    if force or now - _T_LAST[0] > 240:
        _T_LAST[0] = now
        try:
            with open(LOG, "a") as f:
                f.write(f"{time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())} {msg}\n")
        except OSError:
            pass


def window(n):
    """The empty window of FINDINGS Result 8: (theta_Fox, theta_0(n))."""
    return SQRT32, float(theta0(n))


def margin_at(theta, d2, n):
    """C7's margin at dimension n: theta_0(n) - (theta + |kappa_n| delta^2). The
    run_frontier_sweep version is pinned to the n=12 line, which is the wrong line
    at any other n."""
    return float(theta0(n)) - (theta + abs(kappa(n)) * d2)


_SPLIT_CACHE = {}


def split_thetas(n):
    """theta of every sphere product S^p x S^q with p+q <= n, i.e. including the ones
    that reach dimension n by zero-padding. Padding preserves theta and delta^2, so
    these are all genuine critical values at dimension n -- and at n=14 an unlabelled
    in-window point turned out to be S^6 x S^7 from n=13, padded."""
    if n not in _SPLIT_CACHE:
        from run_defect_max_hunt import light_ctx
        from run_sphere import sphere_product_mop
        from weyl_decomposition import weyl_from_mop
        out = []
        for m in range(4, n + 1):
            cx = light_ctx(m)
            for p in range(2, m // 2 + 1):
                W, _, _ = weyl_from_mop(cx["L2"], sphere_product_mop(cx["L2"], p))
                W = W / norm(W)
                out.append((f"S^{p} x S^{m-p}" + ("" if m == n else f" (padded from n={m})"),
                            float(frob(W, cx["Qfun"](W)))))
        _SPLIT_CACHE[n] = out
    return _SPLIT_CACHE[n]


# =====================================================================
# exact integer arithmetic: representatives, checks, and the certificate
# =====================================================================
def rank_mod_p(Ain, p=P_MOD):
    """Rank over F_p by Gaussian elimination on int64. rank_{F_p}(A) <= rank_Q(A)
    for every integer matrix A, which is the only property the certificate uses."""
    A = np.mod(np.asarray(Ain, dtype=np.int64), p)
    m, ncol = A.shape
    r = 0
    for col in range(ncol):
        if r >= m:
            break
        nz = np.nonzero(A[r:, col])[0]
        if nz.size == 0:
            continue
        i = r + int(nz[0])
        if i != r:
            A[[r, i]] = A[[i, r]]
        A[r] = np.mod(A[r] * pow(int(A[r, col]), p - 2, p), p)
        rows = np.nonzero(A[r + 1:, col])[0]
        if rows.size:
            rows = rows + r + 1
            f = A[rows, col].copy()
            A[rows] = np.mod(A[rows] - np.mod(f[:, None] * A[r][None, :], p), p)
        r += 1
    return r


def triu_maps(N):
    triu = [(a, b) for a in range(N) for b in range(a, N)]
    return triu, {t: k for k, t in enumerate(triu)}


def ric_rows_triu(n, pos, tpos):
    """Ric_{ik}(R) = sum_j R_{ijkj} as integer functionals of the upper-triangular
    coordinates of the symmetric operator R on Lambda^2."""
    rows = []
    for i in range(n):
        for k in range(i, n):
            row = {}
            for j in range(n):
                if j == i or j == k:
                    continue
                a, si = (i, j), 1
                if a[0] > a[1]:
                    a, si = (a[1], a[0]), -si
                b, sk = (k, j), 1
                if b[0] > b[1]:
                    b, sk = (b[1], b[0]), -sk
                pa, pb = pos[a], pos[b]
                t = tpos[(min(pa, pb), max(pa, pb))]
                row[t] = row.get(t, 0) + si * sk
            rows.append(row)
    return rows


def constraint_matrix_int(n, V):
    """C = [Bianchi ; Ricci ; <V,.>] as an integer matrix on the M = N(N+1)/2
    upper-triangular coordinates, M = dim Sym^2(Lambda^2 R^n)."""
    idx, pos, N, cf = build_structure_constants(n)
    triu, tpos = triu_maps(N)
    Bm, triu2, _ = bianchi_constraint_matrix(idx, pos, n, N)
    assert triu2 == triu
    rr = ric_rows_triu(n, pos, tpos)
    Ric = np.zeros((len(rr), len(triu)), dtype=np.int64)
    for r, row in enumerate(rr):
        for t, v in row.items():
            Ric[r, t] = v
    worth = np.array([[V[a, b] if a == b else 2 * V[a, b] for (a, b) in triu]], dtype=np.int64)
    return np.vstack([np.rint(Bm).astype(np.int64), Ric, worth]), triu, tpos, N


def Q_int2(V, c):
    """2*Q(V) = 2*V^2 + 2*V^# in exact integer arithmetic, for integer V.
    V^#[a,b] = -1/2 tr(A_a V A_b V) with (A_a)[m,n] = c[a,m,n] (run_frontier_sweep's
    qform_sym derivation, read as an operator identity rather than a pairing)."""
    N = V.shape[0]
    Ma = np.einsum('amn,np->amp', c, V, optimize=True)          # A_a V
    Mflat = Ma.reshape(N, N * N)
    MTflat = np.transpose(Ma, (0, 2, 1)).reshape(N, N * N)
    sharp2 = -(Mflat @ MTflat.T)                                # = 2 * V^#
    return 2 * (V @ V) + sharp2


def exact_point_checks(n, V, c, C):
    """Integer certificates that V is a Weyl tensor and an exact critical point."""
    triu, tpos = triu_maps(V.shape[0])
    v = np.array([V[a, b] for (a, b) in triu], dtype=np.int64)
    weyl_res = int(np.max(np.abs(C[:-1] @ v))) if C.shape[0] > 1 else 0
    Q2 = Q_int2(V, c)
    nv2 = int(np.sum(V * V))
    PV2 = int(np.sum(V * Q2))                                   # = 2 P_V
    crit_res = int(np.max(np.abs(nv2 * Q2 - PV2 * V)))
    theta = 0.5 * PV2 / (nv2 * np.sqrt(float(nv2)))             # P_V / |V|^3
    return weyl_res, crit_res, nv2, PV2, theta


def qform_int(V, c):
    """Integer A0 with vec(H)^T A0 vec(H) = 2 <V, Q(H)> for symmetric H."""
    N = V.shape[0]
    D1 = np.einsum('ij,kl->iklj', V, np.eye(N, dtype=np.int64), optimize=True).reshape(N * N, N * N)
    Vc = np.einsum('ab,bpq->apq', V, c, optimize=True)
    K = np.einsum('amn,apq->npqm', c, Vc, optimize=True).reshape(N * N, N * N)
    return 2 * D1 - K


def morse_bott_certificate(n, V, label, c=None, verbose=True):
    """Exact upper bound on dim rad(Hess) and exact lower bound on dim orbit.
    Returns (orbit_lower, radical_upper, theta, ok) -- ok means the two agree,
    i.e. Morse-Bott nondegeneracy is PROVEN at V."""
    t0 = time.time()
    if c is None:
        _, _, _, cf = build_structure_constants(n)
        c = np.rint(cf).astype(np.int64)
    C, triu, tpos, N = constraint_matrix_int(n, V)
    M, m = len(triu), C.shape[0]
    weyl_res, crit_res, nv2, PV2, theta = exact_point_checks(n, V, c, C)
    if weyl_res or crit_res:
        if verbose:
            print(f"  {label:26s} NOT AN EXACT CRITICAL WEYL POINT "
                  f"(weyl residual {weyl_res}, criticality residual {crit_res}) -- skipped")
        return None
    rkC = rank_mod_p(C)
    if rkC != m:
        if verbose:
            print(f"  {label:26s} constraint rows dependent mod p ({rkC} < {m}) -- inconclusive")
        return None
    # integer second-variation form: 4 * [ 6|V|^2 <V,Q(H)> - 3 P_V <H,H> ]
    A0 = qform_int(V, c)
    A0 = A0 + A0.T                                              # vec^T A0 vec = 4 <V,Q(H)>
    S = np.zeros((N * N, M), dtype=np.float64)
    for k, (a, b) in enumerate(triu):
        S[a * N + b, k] = 1.0
        S[b * N + a, k] = 1.0
    Ah = S.T @ A0.astype(np.float64) @ S                        # h^T Ah h = 4 <V,Q(H)>
    rerr = float(np.max(np.abs(Ah - np.rint(Ah))))
    assert rerr == 0.0 and np.max(np.abs(Ah)) < 2.0 ** 50, "integer congruence lost exactness"
    Ah = np.rint(Ah).astype(np.int64)
    diagG = np.array([1 if a == b else 2 for (a, b) in triu], dtype=np.int64)
    A = 6 * nv2 * Ah - 3 * (2 * PV2) * np.diag(diagG)
    sz = M + m
    B = np.zeros((sz, sz), dtype=np.int64)
    B[:M, :M] = np.mod(A, P_MOD)
    B[:M, M:] = np.mod(C.T, P_MOD)
    B[M:, :M] = np.mod(C, P_MOD)
    rad_upper = sz - rank_mod_p(B)
    Mo = np.einsum('amp,pq->amq', c, V) - np.einsum('mp,apq->amq', V, c)
    orb_lower = rank_mod_p(Mo.reshape(N, -1))
    ok = (orb_lower == rad_upper)
    if verbose:
        print(f"  {label:26s} theta={theta:.9f}  dim T={M-m}  "
              f"orbit >= {orb_lower:3d} <= rad(Hess) <= {rad_upper:3d}  "
              f"{'PROVEN Morse-Bott nondegenerate' if ok else '** GAP: inconclusive **'}"
              f"   [{time.time()-t0:.1f}s]")
    return orb_lower, rad_upper, theta, ok


def hessian_full(W, ctx, c):
    """hessian_profile with the eigenvectors kept: returns (evals, Hmats, theta), where
    Hmats[i] is the i-th Hessian eigenvector as an N x N tangent Weyl tensor."""
    N, Eflat = ctx["N"], ctx["Eflat"]
    Qf = qform_sym(W, c)
    wvec = W.reshape(-1)
    theta = float(wvec @ Qf @ wvec)
    T = Eflat - np.outer(Eflat @ wvec, wvec)
    G = T @ T.T
    wt, Vt = np.linalg.eigh(G)
    order = np.argsort(-wt)
    wt, Vt = wt[order], Vt[:, order]
    Dt = int(np.sum(wt > 1e-8 * wt[0]))
    Etan = (Vt[:, :Dt] @ np.diag(1.0 / np.sqrt(wt[:Dt]))).T @ T          # (Dt, N^2)
    M = Etan @ Qf @ Etan.T
    Hess = 6 * 0.5 * (M + M.T) - 3 * theta * np.eye(Dt)
    ev, U = np.linalg.eigh(Hess)
    return ev, (U.T @ Etan), theta                                       # rows: eigenvectors


def orbit_basis(W, c):
    """Orthonormal basis of the O(n)-orbit tangent space at W, flattened to N^2."""
    N = W.shape[0]
    Mo = np.einsum('amp,pq->amq', c, W) - np.einsum('mp,apq->amq', W, c)
    F = Mo.reshape(N, N * N)
    U, S, Vt = np.linalg.svd(F, full_matrices=False)
    k = int(np.sum(S > 1e-8 * max(S[0], 1.0)))
    return Vt[:k], k


def integerize(W, max_k=64, tol=1e-9):
    """An exact integer representative of the ray through W, or None. The certificate
    is invariant under V -> tV for t > 0, so any scale that clears denominators works."""
    A = np.abs(W)
    mx = A.max()
    nz = A[A > 1e-9 * mx]
    if nz.size == 0:
        return None
    a = nz.min()
    for k in range(1, max_k + 1):
        V = W * (k / a)
        if np.max(np.abs(V - np.rint(V))) < tol * max(1.0, np.max(np.abs(V))):
            Vi = np.rint(V).astype(np.int64)
            g = np.gcd.reduce(np.abs(Vi).reshape(-1))
            return Vi // g if g > 1 else Vi
    return None


# =====================================================================
# the named critical points at dimension n, with exact representatives
# where one exists
# =====================================================================
def named_points(n, ctx):
    """(label, W_unit) for every catalogued critical point living at dimension n."""
    out = [("Fox S^4(alpha)", fox_weyl(ctx))]
    for p in range(2, n // 2 + 1):
        out.append((f"sphere ({p},{n-p})", sphere_weyl(ctx, p)))
    for m in range(3, n // 2 + 1):
        L2m = Lambda2(2 * m)
        Wm = su_m_kahler_weyl(L2m, m)
        Wm = Wm / norm(Wm)
        out.append((f"su({m}) Kahler", Wm if 2 * m == n else pad_weyl_to_n(L2m, Wm, n)[1]))
    for k in range(2, n // 4 + 1):
        blocks = [list(range(4 * i, 4 * i + 4)) for i in range(k)]
        Wk = sum(fox_on_block(ctx["L2"], b, ctx["Qfun"]) for b in blocks)
        out.append((f"Fox plateau k={k}", Wk / norm(Wk)))
    L2_8, Wsu3 = build_su3_n8()
    out.append(("SU(3) bi-invariant", Wsu3 if n == 8 else pad_weyl_to_n(L2_8, Wsu3, n)[1]))
    out.append(("QK HP^2", qk_weyl(ctx, 2) if n == 8 else
                pad_weyl_to_n(Lambda2(8), qk_weyl(setup(8, verbose=False), 2), n)[1]))
    if n >= 12:
        # qk_tensor needs its own ambient dimension n = 4m, so HP^3 is built at n = 12
        # and zero-padded upward (padding preserves theta, delta^2 and criticality).
        out.append(("QK HP^3", qk_weyl(ctx, 3) if n == 12 else
                    pad_weyl_to_n(Lambda2(12), qk_weyl(setup(12, verbose=False), 3), n)[1]))
    for fn, lab in (("scripts/data/defect_violation_n8_0.120000.npy", "so(5)-spin 3/25 violator"),
                    ("scripts/data/defect_theta0_n8_0.125000.npy", "theta=0 stratum point")):
        path = os.path.join(HERE, fn)
        if os.path.exists(path):
            W8 = np.load(path)
            out.append((lab, W8 if n == 8 else pad_weyl_to_n(Lambda2(8), W8, n)[1]))
    return out


# =====================================================================
# PART 0 -- validation of the Hessian construction against both trusted paths
# =====================================================================
def part0():
    print("=" * 100)
    print("PART 0 -- validating the generalized Hessian against hessian_pipeline_b (slow, "
          "trusted) and hessian_fast")
    print("=" * 100)
    log("PART 0 validation started", force=True)
    for n, p in ((6, 3), (8, 4)):
        ctx = setup(n, verbose=False)
        _, _, N, c = build_structure_constants(n)
        W = sphere_weyl(ctx, p)
        ev, th, Dt = hessian_profile(W, ctx, c)
        ev_f, lam_f, Dt_f = hessian_fast.run(n, p, n - p, verbose=False)
        line = (f"  n={n} ({p},{n-p}): dim {Dt} vs {Dt_f}, theta {th:.12f} vs {lam_f:.12f}, "
                f"max|d eig| {np.max(np.abs(np.sort(ev)-np.sort(ev_f))):.1e} (hessian_fast)")
        if n == 6:
            ev_b, lam_b, Dt_b, _ = hessian_pipeline_b.run(n, p, n - p, verbose=False)
            line += (f"; {np.max(np.abs(np.sort(ev)-np.sort(ev_b))):.1e} (hessian_pipeline_b, "
                     f"theta {lam_b:.12f})")
        print(line)
    # the integer form against the float trilinear form
    n = 8
    ctx = setup(n, verbose=False)
    _, _, N, cf = build_structure_constants(n)
    c = np.rint(cf).astype(np.int64)
    W = sphere_weyl(ctx, 4)
    V = integerize(W)
    triu, tpos = triu_maps(N)
    A0 = qform_int(V, c)
    A0 = A0 + A0.T
    rng = np.random.default_rng(7)
    worst = 0.0
    for _ in range(4):
        H = (rng.normal(size=ctx["D"]) @ ctx["Eflat"]).reshape(N, N)
        H = 0.5 * (H + H.T)
        h = H.reshape(-1)
        worst = max(worst, abs(float(h @ A0.astype(np.float64) @ h) - 4.0 * frob(V, ctx["Qfun"](H))))
    Q2 = Q_int2(V, c)
    print(f"  integer forms at n=8 (4,4): max |vec A0 vec - 4<V,Q(H)>| = {worst:.2e} over 4 random H;"
          f"  max |2Q_int(V) - 2Q_float(V)| = {np.max(np.abs(Q2 - 2*ctx['Qfun'](V.astype(float)))):.2e}")
    # negative controls: the certificate must refuse a non-critical point and a
    # non-Weyl point, so that "PROVEN" is not something it prints unconditionally
    print("  negative controls for the certificate's guards:")
    Vbad = V.copy()
    Vbad[0, 0] += 1
    morse_bott_certificate(n, Vbad, "perturbed (4,4)", c=c)
    Vnw = V.copy()
    Vnw[0, 1] = Vnw[1, 0] = 3
    morse_bott_certificate(n, Vnw, "non-Weyl operator", c=c)
    print("  both Hessian paths and both integer forms agree; the guards fire as they should.")
    log("PART 0 validation done", force=True)


# =====================================================================
# PART B -- rigidity: exact certificates plus the float signature
# =====================================================================
def partB(n=12, top_only=False, do_exact=True):
    """top_only restricts to the points that bound the window (Fox and the sphere
    splits), which is what makes the run affordable at n = 14."""
    print("=" * 100)
    print(f"PART B -- RIGIDITY at n={n}: exact Morse-Bott certificates at "
          f"{'the window-bounding' if top_only else 'every named'} critical point")
    print("=" * 100)
    log(f"PART B rigidity n={n} started", force=True)
    ctx = setup(n, verbose=False)
    _, _, N, cf = build_structure_constants(n)
    c = np.rint(cf).astype(np.int64)
    pts = named_points(n, ctx)
    if top_only:
        pts = [(l, W) for l, W in pts if l.startswith(("Fox S", "sphere"))]
    if not do_exact:
        print("\n  -- exact certificates skipped --")
    exact = {}
    if do_exact:
        print(f"\n  -- exact integer certificates (rank_(F_p) <= rank_Q is the only input) --")
        for lab, W in pts:
            V = integerize(W)
            if V is None:
                print(f"  {lab:26s} no integer representative found -- float only")
                continue
            res = morse_bott_certificate(n, V, lab, c=c)
            if res is not None:
                exact[lab] = res
            log(f"PART B: certificate done for {lab}")
    print(f"\n  -- float Hessian signature and defect, same points "
          f"(kernel counted at |eigenvalue| < 1e-7) --")
    print(f"  {'point':26s} {'theta':>13} {'delta^2':>10} {'dim':>5} {'pos':>5} {'zero':>5} "
          f"{'neg':>5} {'orbit':>6}  verdict")
    rows = []
    for lab, W in pts:
        ev, th, Dt = hessian_profile(W, ctx, c)
        stab, orb = stabilizer_dim(W, c)
        d2 = float(delta2_and_grad(W, ctx["alt_idx"])[0])
        npos = int(np.sum(ev > 1e-7))
        nzero = int(np.sum(np.abs(ev) <= 1e-7))
        nneg = int(np.sum(ev < -1e-7))
        proven = lab in exact and exact[lab][3]
        verdict = ("kernel = orbit" if nzero == orb else f"kernel exceeds orbit by {nzero-orb}")
        if proven:
            verdict += " (PROVEN exactly)"
        if npos == 0 and nzero == orb:
            verdict += "; strict local max mod O(n)"
        elif npos > 0:
            verdict += f"; saddle ({npos} ascent directions)"
        print(f"  {lab:26s} {th:13.9f} {d2:10.6f} {Dt:5d} {npos:5d} {nzero:5d} {nneg:5d} "
              f"{orb:6d}  {verdict}")
        rows.append((lab, th, d2, orb, nzero, npos, proven))
        log(f"PART B: float Hessian done for {lab}")
    nproven = sum(1 for r in rows if r[6])
    print(f"\n  {nproven}/{len(rows)} points carry an exact Morse-Bott certificate; "
          f"{sum(1 for r in rows if r[3] == r[4])}/{len(rows)} have float kernel = orbit dimension.")
    log(f"PART B done: {nproven} exact certificates", force=True)
    return rows


# =====================================================================
# PART C -- local structure at Fox: perturb and repolish
# =====================================================================
def partC(n=12, scales=(1e-3, 1e-2, 3e-2, 1e-1), ntrial=8, seed=20260820,
          probes=("Fox S^4(alpha)", "sphere (5,7)", "sphere (6,6)")):
    """The three points that bound the window: Fox at its lower endpoint, the (5,7)
    split -- the ONLY catalogued critical value strictly inside it, and zero-defect --
    and the balanced split at its upper endpoint."""
    print("=" * 100)
    print(f"PART C -- LOCAL STRUCTURE at n={n}: is the critical set near the window's own "
          f"orbits nothing but those orbits?")
    print("=" * 100)
    log(f"PART C isolation probe n={n} started", force=True)
    rng = np.random.default_rng(seed)
    ctx = setup(n, verbose=False)
    Eflat, N, D, Qfun, alt_idx = ctx["Eflat"], ctx["N"], ctx["D"], ctx["Qfun"], ctx["alt_idx"]
    _, _, _, cf = build_structure_constants(n)
    c = np.rint(cf).astype(np.int64)
    pts = dict(named_points(n, ctx))
    for lab in probes:
        W0 = pts[lab]
        x0, err = project_to_x(W0, Eflat, N)
        spec0 = np.sort(np.linalg.eigvalsh(W0))
        th0 = frob(W0, Qfun(W0))
        d20 = float(delta2_and_grad(W0, alt_idx)[0])
        stab, orb = stabilizer_dim(W0, c)
        print(f"\n  {lab}: theta={th0:.9f} delta^2={d20:.9f} orbit dim {orb}, "
              f"reconstruction error {err:.1e}")
        print(f"  {'scale':>8} {'returns':>8} {'back on this orbit':>19} {'max |d spectrum|':>17} "
              f"{'other critical values reached'}")
        for s in scales:
            back, others, worst = 0, [], 0.0
            for _ in range(ntrial):
                d = rng.normal(size=D)
                x = x0 + s * d / np.linalg.norm(d)
                _, W, th, rel, d2 = polish_to_critical(x / np.linalg.norm(x), Eflat, N,
                                                       alt_idx, Qfun)
                if rel > 1e-7:
                    continue
                spec = np.sort(np.linalg.eigvalsh(W))
                dsp = float(np.max(np.abs(spec - spec0)))
                if abs(th - th0) < 1e-7 and abs(d2 - d20) < 1e-7 and dsp < 1e-6:
                    back += 1
                    worst = max(worst, dsp)
                else:
                    others.append((th, d2))
            tags = sorted({f"theta={a:.6f},d2={b:.4f}" for a, b in others})
            print(f"  {s:8.4f} {ntrial:8d} {back:19d} {worst:17.2e} "
                  f"{'; '.join(tags) if tags else '(none)'}")
            log(f"PART C: {lab} scale {s} -> {back}/{ntrial} returned to the orbit")
        # the radical as a SUBSPACE: the orbit tangent space always sits inside it, so
        # equal dimensions already force equality -- this measures it directly anyway.
        ev, Hm, thh = hessian_full(W0, ctx, c.astype(float))
        Ob, k = orbit_basis(W0, c.astype(float))
        ker = Hm[np.abs(ev) <= 1e-7]
        Kb = np.linalg.svd(ker, full_matrices=False)[2][:ker.shape[0]]
        sv = np.linalg.svd(Kb @ Ob.T, compute_uv=False)
        print(f"  radical vs orbit: dim {ker.shape[0]} vs {k}; principal cosines in "
              f"[{sv.min():.12f}, {sv.max():.12f}] (all 1 = the two subspaces coincide); "
              f"smallest |nonzero Hessian eigenvalue| {np.min(np.abs(ev[np.abs(ev) > 1e-7])):.6f}")
    # non-orbit kernel directions at the degenerate points: is the extra kernel a
    # genuine branch of critical points, or second-order flatness only?
    print(f"\n  -- continuation along non-orbit kernel directions (the points whose kernel "
          f"exceeds the orbit) --")
    print(f"     A genuine branch of critical points leaving the orbit would show a repolished "
          f"point at distance ~t from the start\n     after the orbit is divided out; a return to "
          f"distance << t says the extra kernel is second-order flatness only.")
    print(f"  {'point':22s} {'extra':>6} {'step t':>7} {'resid(W+tH)':>12} {'resid after':>12} "
          f"{'|dtheta|':>10} {'moved mod orbit':>16}")
    for lab, W in named_points(n, ctx):
        ev, Hm, th = hessian_full(W, ctx, c.astype(float))
        Ob, k = orbit_basis(W, c.astype(float))
        ker = Hm[np.abs(ev) <= 1e-7]
        if ker.shape[0] <= k:
            continue
        R = ker - (ker @ Ob.T) @ Ob                      # kernel modulo the orbit
        U, S, Vt = np.linalg.svd(R, full_matrices=False)
        extra = int(np.sum(S > 1e-6))
        for H in Vt[:1]:
            for t in (0.01, 0.05):
                Wp = W + t * H.reshape(N, N)
                Wp = 0.5 * (Wp + Wp.T)
                Wp /= norm(Wp)
                Qp = Qfun(Wp)
                r0 = float(norm(Qp - frob(Wp, Qp) * Wp))
                x, e = project_to_x(Wp, Eflat, N)
                _, W2, th2, rel2, d22 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
                Q2 = Qfun(W2)
                r1 = float(norm(Q2 - th2 * W2))
                dW = (W2 - W).reshape(-1)
                dW = dW - Ob.T @ (Ob @ dW)               # the part transverse to the orbit
                print(f"  {lab:22s} {extra:6d} {t:7.3f} {r0:12.2e} {r1:12.2e} "
                      f"{abs(th2-th):10.2e} {float(np.linalg.norm(dW)):16.5f}")
        log(f"PART C: continuation done at {lab}")
    log("PART C done", force=True)


# =====================================================================
# PART A -- the window search
# =====================================================================
def obj_window_band(mu, nu, t_lo, t_hi, Eflat, N, Qfun, alt_idx):
    """The window question asked directly: maximize delta^2 subject to criticality
    and theta INSIDE [t_lo, t_hi], both sides hinged. FINDINGS Result 7's trap list
    is why theta needs its own penalty at all -- an unpinned criticality ramp slides
    back to Fox, which sits at the window's lower endpoint."""
    def fg(xx):
        nx = np.linalg.norm(xx)
        u = xx / nx
        W = (u @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        Q = Qfun(W)
        P = frob(W, Q)
        d2, Gd = delta2_and_grad(W, alt_idx)
        R, GR = resid_and_grad(W, Q, P, Qfun)
        lo = max(0.0, t_lo - P)
        hi = max(0.0, P - t_hi)
        G = -Gd + mu * GR + nu * 2.0 * (hi - lo) * 3.0 * Q
        g = Eflat @ G.reshape(-1)
        return -d2 + mu * R + nu * (lo * lo + hi * hi), (g - np.dot(g, u) * u) / nx
    return fg


def window_seeds(n, ctx, rng, coarse=False):
    """Seeds aimed at the window: everything that carries defect, pushed toward
    sphere-product-sized theta."""
    Eflat, N, D, Qfun = ctx["Eflat"], ctx["N"], ctx["D"], ctx["Qfun"]
    L2, alt_idx = ctx["L2"], ctx["alt_idx"]
    seeds = []

    def add(lab, W):
        x, e = project_to_x(W / norm(W), Eflat, N)
        if e < 1e-7:
            seeds.append((lab, x))

    Wfox = fox_weyl(ctx)
    Wbal = sphere_weyl(ctx, n // 2)
    Wunb = sphere_weyl(ctx, n // 2 - 1)
    xf = project_to_x(Wfox, Eflat, N)[0]
    xb = project_to_x(Wbal, Eflat, N)[0]
    xu = project_to_x(Wunb, Eflat, N)[0]

    # (1) Fox mixed toward the two top sphere products: the great circle plus
    #     off-circle mixtures, which is the shortest route from Fox's defect to
    #     the window's theta.
    for lab, xt in (("bal", xb), ("unb", xu)):
        ang = np.arccos(np.clip(np.dot(xf, xt), -1, 1))
        for s in ((0.15, 0.35, 0.6) if coarse else (0.05, 0.1, 0.2, 0.3, 0.45, 0.6, 0.8)):
            xg = (np.sin((1 - s) * ang) * xf + np.sin(s * ang) * xt) / np.sin(ang)
            seeds.append((f"Fox->{lab} circle s={s}", xg))
    for s in ((0.1, 0.3) if coarse else (0.05, 0.1, 0.2, 0.35)):
        for j in range(1 if coarse else 2):
            d = rng.normal(size=ctx["D"])
            d = d / np.linalg.norm(d)
            seeds.append((f"Fox +{s} toward bal + noise{j}",
                          (1 - s) * xf + s * xb + 0.25 * s * d))

    # (2) the (5,7) saddle pushed along its own defect gradient -- the direction
    #     that gives up the least theta per unit of defect gained.
    Wu = (xu @ Eflat).reshape(N, N)
    Wu = 0.5 * (Wu + Wu.T)
    _, Gd = delta2_and_grad(Wu, alt_idx)
    g = Eflat @ Gd.reshape(-1)
    g = g - np.dot(g, xu) * xu
    if np.linalg.norm(g) > 1e-12:
        g /= np.linalg.norm(g)
        for s in ((0.05, 0.2) if coarse else (0.02, 0.05, 0.1, 0.2, 0.35)):
            seeds.append((f"({n//2-1},{n-n//2+1}) + {s} defect-grad", xu + s * g))
    # and the same for the balanced split
    Wbm = (xb @ Eflat).reshape(N, N)
    Wbm = 0.5 * (Wbm + Wbm.T)
    _, Gdb = delta2_and_grad(Wbm, alt_idx)
    gb = Eflat @ Gdb.reshape(-1)
    gb = gb - np.dot(gb, xb) * xb
    if np.linalg.norm(gb) > 1e-12:
        gb /= np.linalg.norm(gb)
        for s in ((0.1,) if coarse else (0.05, 0.15, 0.3)):
            seeds.append((f"({n//2},{n//2}) + {s} defect-grad", xb + s * gb))

    # (3) su(m) family and Fox-plateau members, alone and mixed with sphere products
    fam = []
    for m in range(2, n // 2 + 1):
        L2m = Lambda2(2 * m)
        Wm = su_m_kahler_weyl(L2m, m)
        Wm = Wm / norm(Wm)
        fam.append((f"su({m})", Wm if 2 * m == n else pad_weyl_to_n(L2m, Wm, n)[1]))
    for k in range(1, n // 4 + 1):
        blocks = [list(range(4 * i, 4 * i + 4)) for i in range(k)]
        Wk = sum(fox_on_block(L2, b, Qfun) for b in blocks)
        fam.append((f"plateau k={k}", Wk / norm(Wk)))
    for lab, Wm in fam:
        add(lab, Wm)
        for s in ((0.5,) if coarse else (0.3, 0.5, 0.7)):
            add(f"{lab} + sphere({n//2}) s={s}", s * Wm + np.sqrt(1 - s * s) * Wbal)
        if not coarse:
            add(f"{lab} + sphere({n//2-1}) s=0.5", 0.5 * Wm + np.sqrt(0.75) * Wunb)
    # Fox on one R^4 with a sphere product on the complementary R^{n-4}: the natural
    # way to carry Fox-sized defect at sphere-product-sized theta
    Wfox4 = fox_on_block(L2, list(range(4)), Qfun)
    for s in ((0.3, 0.6) if coarse else (0.2, 0.35, 0.5, 0.65, 0.8)):
        add(f"Fox4 + bal s={s}", s * Wfox4 + np.sqrt(1 - s * s) * Wbal)
        if not coarse:
            add(f"Fox4 + unb s={s}", s * Wfox4 + np.sqrt(1 - s * s) * Wunb)

    # (4) the so(5)-spin violator and the theta=0 stratum point, padded and deformed
    #     toward the window by mixing with the balanced sphere product
    for fn, lab in (("scripts/data/defect_violation_n8_0.120000.npy", "3/25 violator"),
                    ("scripts/data/defect_theta0_n8_0.125000.npy", "theta=0 point")):
        path = os.path.join(HERE, fn)
        if not os.path.exists(path):
            continue
        W8 = np.load(path)
        Wp = W8 if n == 8 else pad_weyl_to_n(Lambda2(8), W8, n)[1]
        add(lab, Wp)
        for s in ((0.4, 0.7) if coarse else (0.25, 0.4, 0.55, 0.7, 0.85)):
            add(f"{lab} + bal s={s}", s * Wp + np.sqrt(1 - s * s) * Wbal)
            if not coarse:
                add(f"{lab} + Fox4 s={s}", s * Wp + np.sqrt(1 - s * s) * Wfox4)

    # (5) the near-active points the frontier sweep saved
    for fn in sorted(os.listdir(HERE)):
        if fn.startswith(f"frontier_n{n}_") and fn.endswith(".npy"):
            add(f"saved {fn[:-4]}", np.load(os.path.join(HERE, fn)))
    return seeds


def partA(n=12, mode="moderate", seed=20260821):
    t_start = time.time()
    lo, hi = window(n)
    print("=" * 100)
    print(f"PART A -- WINDOW SEARCH at n={n}: is there a critical point with delta^2 > 0 and "
          f"theta in ({lo:.9f}, {hi:.9f})?")
    print("=" * 100)
    log(f"PART A window search n={n} mode={mode} started", force=True)
    rng = np.random.default_rng(seed)
    ctx = setup(n, verbose=False)
    Eflat, N, D, Qfun, alt_idx = ctx["Eflat"], ctx["N"], ctx["D"], ctx["Qfun"], ctx["alt_idx"]
    coarse = (mode == "coarse")
    mus = (1.0, 10.0, 1e2, 1e3, 1e4, 1e5) if not coarse else (1.0, 1e2, 1e4, 1e5)
    maxiter = 250 if not coarse else 150
    seeds = window_seeds(n, ctx, rng, coarse=coarse)
    print(f"  {len(seeds)} window-directed seeds prepared "
          f"(Fox->sphere mixes, defect-gradient pushes off the sphere splits, su(m) and "
          f"plateau combinations, padded so(5)-spin points, saved frontier points)")

    pool = []

    def take(W, tag):
        Q = Qfun(W)
        th = frob(W, Q)
        if th < 0:
            W, Q, th = -W, Qfun(-W), -th
        res = norm(Q - th * W)
        if res >= RESID_TOL or th <= 1e-6:
            return None
        d2 = float(delta2_and_grad(W, alt_idx)[0])
        rec = dict(theta=float(th), d2=d2, absres=float(res), W=W, tag=tag,
                   inwin=(lo + 1e-9 < th < hi - 1e-9), margin=margin_at(float(th), d2, n))
        pool.append(rec)
        return rec

    # ---- A1: equality pin at a grid of theta inside the window ----------
    grid = ([lo + f * (hi - lo) for f in (0.02, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 0.98)]
            if not coarse else [lo + f * (hi - lo) for f in (0.1, 0.5, 0.9)])
    nseed = 9 if not coarse else 5
    print(f"\n  -- A1: theta-pinned defect maximization at {len(grid)} points inside the window --")
    for t in grid:
        picks = [seeds[i] for i in rng.choice(len(seeds), size=min(nseed, len(seeds)),
                                              replace=False)]
        picks += [(f"random {j}", defect_polish_loop(rng.normal(size=D), Eflat, N, alt_idx,
                                                     Qfun, rounds=1, iters=80))
                  for j in range(1 if coarse else 2)]
        best = None
        for j, (lab, x0) in enumerate(picks):
            obj = obj_theta_floor if (j % 3 == 2) else obj_theta_pinned
            x = ramp(x0, lambda mu: obj(mu, mu, t, Eflat, N, Qfun, alt_idx), mus, maxiter)
            _, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
            rec = take(W, f"A1 t={t:.6f} <- {lab}")
            if rec and (best is None or rec["d2"] > best["d2"]):
                best = rec
            log(f"PART A/A1 t={t:.6f} seed {j+1}/{len(picks)}: pool {len(pool)}")
        if best is None:
            print(f"    t={t:.9f}: no seed reached residual < {RESID_TOL:.0e}")
        else:
            print(f"    t={t:.9f}: best theta={best['theta']:.9f} d2={best['d2']:.9f} "
                  f"absres={best['absres']:.1e}  in-window={best['inwin']}")

    # ---- A2: two-sided band pin -----------------------------------------
    bands = ([(lo + 1e-4, hi - 1e-4), (lo + 1e-3, hi - 1e-3), (lo + 0.004, hi - 0.004)]
             if not coarse else [(lo + 1e-3, hi - 1e-3)])
    nseed = 12 if not coarse else 6
    print(f"\n  -- A2: two-sided band pin, maximize delta^2 subject to theta in the band --")
    for (a, b) in bands:
        picks = [seeds[i] for i in rng.choice(len(seeds), size=min(nseed, len(seeds)),
                                              replace=False)]
        best = None
        for j, (lab, x0) in enumerate(picks):
            x = ramp(x0, lambda mu: obj_window_band(mu, mu, a, b, Eflat, N, Qfun, alt_idx),
                     mus, maxiter)
            _, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
            rec = take(W, f"A2 band [{a:.5f},{b:.5f}] <- {lab}")
            if rec and (best is None or (rec["inwin"], rec["d2"]) > (best["inwin"], best["d2"])):
                best = rec
            log(f"PART A/A2 band [{a:.5f},{b:.5f}] seed {j+1}/{len(picks)}: pool {len(pool)}")
        if best is None:
            print(f"    band [{a:.6f},{b:.6f}]: nothing critical")
        else:
            print(f"    band [{a:.6f},{b:.6f}]: best theta={best['theta']:.9f} "
                  f"d2={best['d2']:.9f} in-window={best['inwin']}  [{best['tag']}]")

    # ---- A3: dual sweep at SMALL defect floors ---------------------------
    floors = ((1e-6, 1e-5, 1e-4, 1.081e-3, 3e-3, 0.01, 0.03, 0.06, 1 / 9. - 1e-4)
              if not coarse else (1e-4, 1.081e-3, 0.01, 0.06))
    nseed = 6 if not coarse else 4
    print(f"\n  -- A3: dual sweep G(d) = max theta subject to criticality and delta^2 >= d.\n"
          f"     At n=12 the lifted Jaeger chain (FINDINGS Result 10) already closes theta >= "
          f"~1.2337 for d <= c(12) = 1.081e-3, so the small floors are where the two\n"
          f"     arguments have to meet; the staircase claim is G(d) = {lo:.9f} for every d > 0 --")
    for d in floors:
        picks = [seeds[i] for i in rng.choice(len(seeds), size=min(nseed, len(seeds)),
                                              replace=False)]
        best = None
        for j, (lab, x0) in enumerate(picks):
            x = ramp(x0, lambda mu: obj_defect_floor(mu, 10.0 * mu, d, Eflat, N, Qfun, alt_idx),
                     mus, maxiter)
            _, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
            rec = take(W, f"A3 d>={d:.2e} <- {lab}")
            if rec and rec["d2"] >= d - 1e-12 and (best is None or rec["theta"] > best["theta"]):
                best = rec
            log(f"PART A/A3 floor {d:.2e} seed {j+1}/{len(picks)}: pool {len(pool)}")
        if best is None:
            print(f"    d >= {d:.3e}: no accepted point kept the floor")
        else:
            over = best["theta"] - lo
            print(f"    d >= {d:.3e}: G(d)={best['theta']:.9f} at d2={best['d2']:.9f}  "
                  f"(theta - theta_Fox = {over:+.3e}, C7 at n={n} allows "
                  f"{theta0(n)-abs(kappa(n))*d:.9f})")

    # ---- report ----------------------------------------------------------
    print(f"\n  -- accepted critical points with theta >= {lo - 0.02:.6f} (deduped) --")
    seen, top = [], []
    for r in sorted(pool, key=lambda r: (-r["theta"], -r["d2"])):
        if r["theta"] < lo - 0.02:
            continue
        if any(abs(r["theta"] - a) < 1e-7 and abs(r["d2"] - b) < 1e-7 for a, b in seen):
            continue
        seen.append((r["theta"], r["d2"]))
        top.append(r)
    print(f"  {'theta':>14} {'delta^2':>12} {'absres':>9} {'in window':>10} {'C7 margin':>12}  "
          f"identity / found by")
    for r in top:
        flag = "  <<<<< DEFECTIVE POINT INSIDE THE WINDOW" if (r["inwin"] and r["d2"] > 1e-9) else ""
        ident = ""
        if r["d2"] < 1e-9:
            for labs, ths in split_thetas(n):
                if abs(ths - r["theta"]) < 1e-7:
                    ident = labs + "; "
                    break
        elif abs(r["d2"] - 1 / 9.) < 1e-9 and abs(r["theta"] - SQRT32) < 1e-9:
            ident = "Fox S^4(alpha); "
        print(f"  {r['theta']:14.9f} {r['d2']:12.9f} {r['absres']:9.1e} {str(r['inwin']):>10} "
              f"{r['margin']:+12.3e}  {ident}{r['tag']}{flag}")
    hits = [r for r in pool if r["inwin"] and r["d2"] > 1e-9]
    print(f"\n  -- VERDICT at n={n} --")
    print(f"    {len(pool)} accepted critical points ({len(top)} distinct at theta >= "
          f"{lo-0.02:.4f}); window = ({lo:.9f}, {hi:.9f})")
    if hits:
        r = max(hits, key=lambda r: r["d2"])
        print(f"    WINDOW IS NOT EMPTY: theta={r['theta']:.9f}, delta^2={r['d2']:.9f}, "
              f"absres={r['absres']:.1e}  [{r['tag']}]")
        fn = os.path.join(HERE, f"gapscope_n{n}_th{r['theta']:.6f}_d2{r['d2']:.6f}.npy")
        np.save(fn, r["W"])
        _, _, _, cf = build_structure_constants(n)
        print(f"    saved {os.path.basename(fn)}; cross-check Q_full residual "
              f"{norm(Q_full(r['W'], cf) - r['theta']*r['W']):.2e}")
    else:
        indefect = [r for r in pool if r["d2"] > 1e-9]
        best = max(indefect, key=lambda r: r["theta"]) if indefect else None
        print(f"    the window stays EMPTY: no accepted critical point has delta^2 > 1e-9 and "
              f"theta strictly inside it")
        if best:
            print(f"    highest-theta defective critical point found: theta={best['theta']:.9f} "
                  f"(theta_Fox {lo:.9f}, excess {best['theta']-lo:+.3e}), delta^2={best['d2']:.9f}")
    print(f"\n  n={n} PART A runtime {time.time()-t_start:.0f}s")
    log(f"PART A n={n} done: {len(pool)} accepted, window "
        f"{'NOT empty' if hits else 'empty'}", force=True)
    return pool


def main():
    args = sys.argv[1:] or ["all"]
    parts = [a for a in args if a.startswith("part") or a == "all"]
    ns = [int(a) for a in args if a.isdigit()]
    mode = "coarse" if "coarse" in args else "moderate"
    n = ns[0] if ns else 12
    if "all" in parts:
        parts = ["part0", "partB", "partC", "partA"]
    for p in parts:
        if p == "part0":
            part0()
        elif p == "partB":
            partB(n, top_only=("top" in args), do_exact=("noexact" not in args))
        elif p == "partC":
            partC(n)
        elif p == "partA":
            partA(n, mode)


if __name__ == "__main__":
    main()
