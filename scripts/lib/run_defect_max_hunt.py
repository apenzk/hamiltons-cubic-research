"""
Adversarial hunt for the DEFECT CEILING:

    delta(W)^2 := ||Alt(W_-)||^2  <=  1/9      at every critical point of P,

where W ranges over unit-norm Weyl operators on Lambda^2 R^n, W_- is the
negative spectral part of W, Alt is the orthogonal projection onto Lambda^4,
and "critical" means Q(W) = theta*W with Q(W) = W^2 + W^# (theta > 0
orientation). Fox's S^4(alpha) has delta^2 = 1/9 exactly, so 1/9 was the
conjectured ceiling and S^4(alpha) the conjectured maximizer. The quantity is
the one the whole defect program is written in: FINDINGS "The defect-penalty
candidate inequality" (kappa_n * delta^2 is the entire penalty term) and
"Lifting Jaeger's §3.3 in trace form" (J_4 <= 24*delta^2*lambda_max(Ric|W|)).
A ceiling on delta^2 would turn every one of those penalties into a number.

VERDICT: REFUTED at n >= 8, by an explicit exactly-critical point with
theta > 0 and delta^2 = 3/25 (item 1 below). The C7 defect-penalty candidate
is untouched by it -- that point has P = 0.387, so its C7 margin is +0.84 at
n = 12 -- but any argument that wants "delta^2 <= 1/9 at critical points" as a
lemma has to add a hypothesis, and theta >= theta_0(n) is the natural one.

WHAT THIS SCRIPT ESTABLISHES (verdicts printed at the end)

  1. THE CONJECTURE IS FALSE, at n = 8 and hence (by zero-padding, which
     preserves both quantities exactly) at every n >= 8. PART 3c produces

         W = a*Pi_4 - b*Pi_6,   a = 3/(2 sqrt15),  b = 1/sqrt15,

     a projection pair on a 10-dimensional subalgebra of so(8) = Lambda^2 R^8,
     with 4a = 6b and 4a^2 + 6b^2 = 1 (trace-free and unit norm). It is a
     genuine Weyl operator (Bianchi and Ricci-flat to 4e-16), EXACTLY critical
     with theta = sqrt(3/20) = 0.3872983346 > 0 (residual 7e-9 absolute,
     2e-8 relative, under two independent Q implementations), and

         delta^2 = 3/25 = 0.12  >  1/9 = 0.1111...,

     an 8% excess. Padded to n = 12, 14, 16 it keeps theta and delta^2 to ten
     digits. The theta = 0 stratum {Q(W) = 0} goes further still, to
     delta^2 = 1/8 at n = 8 (PART 3b), so no orientation clause rescues the
     statement. Both points are saved to .npy when found.

     What the searches DO support, and what 1/9 really is: it is the ceiling
     for every family the program actually cares about -- all named
     competitors, the whole Fox plateau, the su(m) Kaehler family -- and the
     maximum over the high-theta part of the critical set. The violators live
     at low theta (0.387 and 0), far below theta_0(n), where P is nowhere near
     the maximum. So a defect bound conditioned on theta >= some threshold may
     well survive; the unconditional-at-critical-points version does not.

  2. Criticality is ESSENTIAL to it, which is the part that was nearly missed.
     Dropping criticality, the maximum of delta^2 over the unit Weyl sphere is
     strictly ABOVE 1/9 and grows with n -- 0.1142 (n=6), 0.1250 (n=8), 0.1454
     (n=12, and 0.1474 in a longer run) -- attained at points with idempotency
     residual of order 1 (PART 2). Ricci-flatness is not what stops it either:
     the same excess appears, larger, over the space of algebraic curvature
     operators {Alt(R) = 0}: 0.1238, 0.1355, 0.1456 at those n, rising to
     0.1617 at n=16 (PARTS 2b, 2c). The onset is sharp: that maximum is
     exactly 1/9 at n=4 and n=5 and exceeds it from n=6 on -- precisely where
     m = floor(n/2) reaches 3 and c_1(n) (item 6d) passes its R^4 value.
     So the ceiling at critical points is a genuine consequence of
     Q(W) = theta*W, not a property of the defect functional on its own.

     METHOD WARNING, recorded because it produced the opposite answer first:
     delta^2 is non-smooth at every zero eigenvalue of W, and smoothing it by
     the annealed spectral objective (eps: 0.3 -> 0) makes every random start
     converge to Fox and report the unconstrained maximum as exactly 1/9 --
     24/24 seeds at n=6,8 and 8/8 at n=12, a unanimous and wrong consensus.
     Raw subgradient ascent from the very same seeds already beats it at n=12.
     What this script uses instead (defect_polish_loop) is raw ascent with
     short SMALL-eps interruptions, which crosses kinks without flattening the
     landscape; the trapped value is still printed next to the real one.

  3. 1/9 is attained on a positive-dimensional PLATEAU, not only on the Fox
     orbit: any weighted direct sum of Fox blocks on disjoint R^4's has
     delta^2 = 1/9 exactly, and the BALANCED k-block sum is itself a critical
     point with theta = sqrt(3/2)/sqrt(k) (PART 5f). So "S^4(alpha) is the
     maximizer" is true for the value and false for uniqueness -- and what
     criticality does to the plateau is thin it to isolated points, not lower
     its value.

  4. The runner-up is the m=3 member of a new INFINITE FAMILY of critical
     points that PART 4's census turned up at n=6 and that the repo's catalogue
     does not contain (the earlier n=6 searches were gradient ascent; these are
     saddles): the su(m) Ricci-flat Kaehler points on R^{2m} = C^m, built in
     closed form here (su_m_kahler_weyl) and exactly critical to 1e-15, with
         theta(m) = sqrt(m(m+1)/((m+2)(m-1))),  delta^2(m) = (m+2)/(12(m+1)).
     Fox's S^4(alpha) is its m=2 member, and delta^2(m) decreases strictly from
     1/9 to 1/12, so the family maximizes its defect exactly at the champion.
     Everything else critical sits at delta^2 <= 0.048.

  5. n=4 is PROVEN outright (PART 5h), and there the ceiling really is
     unconditional: the chirality splitting Lambda^2 = Lambda^2_+ (+) Lambda^2_-
     makes every Weyl operator two traceless 3x3 blocks and
     delta = |tr A_- - tr B_-|/sqrt6, which is at most 1/3 with equality only on
     the Fox orbit. The excess in item 2 therefore switches on somewhere in
     4 < n <= 6, which is also where c_1(n) (item 6d) first exceeds its R^4
     value -- the 4-forms get room to spread.

  6. Analytic structure (PART 5), each ingredient verified to 1e-16:
       (a) Alt(W_+) = Alt(W_-) =: A for every Bianchi W  [Alt(W) = 0], hence
           delta = ||Alt(|W|)||/2 and delta(W) = delta(-W): the defect is
           blind to the orientation the rest of the program has to track.
       (b) delta^2 = <A, W_+> = <A, W_-> = <A,|W|>/2  <=  ||A||*|| |W| ||/2,
           i.e. the PROVEN unconditional bound delta^2 <= 1/4.
       (c) the Fox-sharp chain delta^4 <= lambda_max(A)^2 * r_+ r_-/(r_+ + r_-),
           an equality at S^4(alpha) in all four of its constituent steps.
       (d) lambda_max(A)/||A|| <= c_1(n) = sqrt((m-1)/3m), m = floor(n/2),
           from ||Alt(v v^T)||^2 = (2/3) e_2(lambda^2) in the bivector normal
           form -- exact, and the reason (c) alone does not close: c_1(n)
           exceeds the R^4 value 1/sqrt6 that Fox realises.
       (e) on the self-dual 3-space of one R^4, Alt(Z) = (tr Z/6)*star, which
           makes the ceiling EXACTLY PROVABLE inside the hyper-Kaehler ansatz:
           max delta^2 = 1/9, attained only by Fox's 2:1:1 spectrum.
       (f) the plateau, and the law behind it: on disjoint index blocks the
           Lambda^4 components are orthogonal, so delta^2 of a direct sum is
           the CONVEX COMBINATION of the blocks' delta^2 -- assembling copies
           of a champion can never beat it, which is both why the Fox plateau
           is flat and why the obvious "build a bigger counterexample from
           known pieces" route is closed.

METHOD (each part reuses validated machinery; nothing here re-implements it)

  PART 0  validation of the two new gradients (residual, smoothed delta^2)
          against central finite differences, plus the 1/9 anchor.
  PART 1  catalogue: theta, delta^2, spectral profile at every named critical
          point (sphere splits, Fox, SU(3), QK HP^2, HP^3).
  PART 2  CONTROL: unconstrained max of delta^2 by raw ascent with small-eps
          polish loops, over W_n (2), over {Alt(R)=0} (2b), and over {Alt(R)=0}
          at n = 4,5,7,9,10,14,16 (2c -- the basis-free ascent makes odd and
          large n cheap). The trapped large-eps value is printed beside it.
  PART 3  CONSTRAINED HUNT: maximize delta^2 - mu*||Q - theta W||^2 with mu
          ramped 0.3 -> 1e4, seeded from PART 2's unconstrained maximizers
          (which sit above 1/9), from perturbed Fox, from the PSD Alt-fraction
          maximizers, and at random; then L-BFGS polish onto the critical set
          and re-read delta^2 there, reporting the max at three residual
          tolerances. A point with residual < 1e-6 and delta^2 > 1/9 + 1e-6 is
          a refutation and is saved to .npy.
  PART 3b THE THETA = 0 STRATUM: drive ||Q(W)||^2 (absolute, since the relative
          residual is 0/0 there) to zero while holding delta^2 up. This is
          where the literal statement fails; it is also invisible to every
          relative-residual filter used elsewhere in the repo.
  PART 4  CENSUS: idempotency-residual minimization with analytic gradients
          (reaches saddles, unlike ascent), delta^2 read off at every critical
          point found, including the theta ~ 0 population which the conjecture
          as stated does not orient.
  PART 5  the analytic facts above, checked term by term: (a)-(e) the identity
          and bound chain, (f) the Fox plateau, (g) the su(m) Kaehler family
          against its closed forms, (h) the n=4 proof.

Reused verbatim: alt_mop/spectral_split (run_bianchi_defect, where Alt is
validated against the exact scal(R^2+R^#) identity and both anchors),
delta2_and_grad/project_to_x/build_su3_n8/pad_weyl_to_n
(run_bianchi_defect_highp_seed), setup/fox_weyl/sphere_weyl/qk_weyl
(run_defect_penalty_test, which carries the Q_fast/Weyl-basis plumbing),
qk_tensor (run_hpm_qk), cp2_block_st_tensor (run_cp2_ricci_flat).
New here: the smoothed spectral objective, the analytic gradient of the
idempotency residual (which makes the census of PART 4 cost O(1) rather than
O(D) Q-evaluations per gradient, the reason run_j5_structure's
finite-difference generic_critical_points found nothing at n=8), the
Bianchi-space (basis-free) ascent, the PSD Alt-fraction solver, and the
multi-block Fox constructor.

Usage
-----
    python3 run_defect_max_hunt.py            # n=6 and n=8 batteries + n=12 spot check
    python3 run_defect_max_hunt.py 12         # single-dimension battery at n=12
"""
import sys
import time
import numpy as np
from scipy.optimize import minimize

from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, norm, frob
from weyl import build_structure_constants
from run_unconstrained_search_n12 import Q_fast, build_Cflat
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect import alt_mop, spectral_split
from run_bianchi_defect_highp_seed import (delta2_and_grad, build_su3_n8,
                                           pad_weyl_to_n, project_to_x)
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_hpm_qk import qk_tensor

D0_EXACT = 1.0 / 9.0
SQRT32 = np.sqrt(1.5)


# =====================================================================
# NEW PIECE 1: the smoothed spectral defect and its exact gradient.
# g_eps(w) = (sqrt(w^2+eps^2) - w)/2 -> max(-w,0) as eps -> 0, so
# delta^2_eps -> delta^2 while being SMOOTH: the Loewner divided-difference
# gradient is then a true gradient rather than the subgradient
# delta2_and_grad returns at the kink. Annealing eps -> 0 is what lets the
# ascent cross the zero-eigenvalue kinks that stall the raw ascent.
# =====================================================================
def smooth_delta2_and_grad(Wmat, alt_idx, eps):
    w, V = np.linalg.eigh(Wmat)
    g = 0.5 * (np.sqrt(w * w + eps * eps) - w)
    Wminus = (V * g) @ V.T
    A = alt_mop(Wminus, alt_idx)
    d2 = frob(A, A)
    diff = w[:, None] - w[None, :]
    gdiff = g[:, None] - g[None, :]
    safe = np.where(np.abs(diff) < 1e-12, 1.0, diff)
    gprime = 0.5 * (w / np.sqrt(w * w + eps * eps) - 1.0)
    Dmat = np.where(np.abs(diff) < 1e-12,
                    0.5 * (gprime[:, None] + gprime[None, :]), gdiff / safe)
    M = V.T @ A @ V
    return d2, 2.0 * (V @ (Dmat * M) @ V.T)


def defect_value_grad(Wmat, alt_idx, eps):
    if eps <= 0.0:
        return delta2_and_grad(Wmat, alt_idx)
    return smooth_delta2_and_grad(Wmat, alt_idx, eps)


# =====================================================================
# NEW PIECE 2: the idempotency residual and its analytic gradient.
# On ||W||=1, ||Q(W) - <W,Q(W)>W||^2 = ||Q||^2 - P^2 =: Rres(W). Q is
# quadratic, Q(W) = B(W,W) with B(A,C) = (Q(A+C)-Q(A)-Q(C))/2, and the
# trilinear form <B(A,C),Y> is fully symmetric (rsharp_basis_free), so
# d/dW ||Q||^2 = 4 B(W,Q) and d/dW P^2 = 6 P Q. Cost: three Q evaluations.
# =====================================================================
def resid_and_grad(Wmat, Qmat, P, Qfun):
    R = frob(Qmat, Qmat) - P * P
    B = 0.5 * (Qfun(Wmat + Qmat) - Qfun(Wmat) - Qfun(Qmat))
    return R, 4.0 * B - 6.0 * P * Qmat


def state_of(x, Eflat, N, Qfun):
    W = (x @ Eflat).reshape(N, N)
    W = 0.5 * (W + W.T)
    Q = Qfun(W)
    return W, Q, frob(W, Q)


def orient_theta_positive(W, Qfun):
    """Q(-W) = Q(W), so -W is critical with theta -> -theta: flipping is how
    the theta>0 branch is selected. delta^2 is unchanged by the flip (PART 5a),
    which is why the theta>0 restriction costs the conjecture nothing."""
    Q = Qfun(W)
    P = frob(W, Q)
    return (-W, Q, -P) if P < 0 else (W, Q, P)


# =====================================================================
# NEW PIECE 3: Riemannian ascent of  delta^2_eps - mu * Rres  on the unit
# sphere of the Weyl basis, with an (mu, eps) schedule. mu = 0 gives the
# unconstrained control of PART 2; ramping mu drives the iterate onto the
# critical set while holding as much defect as it can.
# =====================================================================
def sphere_ascent(x0, Eflat, N, alt_idx, Qfun, schedule, iters=400, tol=1e-14):
    x = x0 / np.linalg.norm(x0)

    def vg(xx, mu, eps):
        W = (xx @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        d2, Gd = defect_value_grad(W, alt_idx, eps)
        if mu == 0.0:
            return d2, Eflat @ Gd.reshape(-1)
        Q = Qfun(W)
        P = frob(W, Q)
        R, GR = resid_and_grad(W, Q, P, Qfun)
        return d2 - mu * R, Eflat @ (Gd - mu * GR).reshape(-1)

    for mu, eps in schedule:
        f, gx = vg(x, mu, eps)
        step = 0.05
        for _ in range(iters):
            g = gx - np.dot(gx, x) * x
            if np.linalg.norm(g) < tol:
                break
            accepted = False
            for _ in range(60):
                xn = x + step * g
                xn /= np.linalg.norm(xn)
                fn, gn = vg(xn, mu, eps)
                if fn > f - 1e-16:
                    accepted = True
                    break
                step *= 0.5
            if not accepted:
                break
            x, f, gx = xn, fn, gn
            step = min(step * 1.4, 1.0)
    return x


def defect_polish_loop(x0, Eflat, N, alt_idx, Qfun, rounds=3, iters=300):
    """The defect maximizer that is actually reliable: raw (eps = 0) ascent to
    ride the kink ridges, interrupted by short small-eps passes that step across
    them, repeated. THE TRAP THIS REPLACES, recorded because it produced a wrong
    answer here first: annealing eps downward from a LARGE value (0.3) smooths
    the landscape so much that every start funnels into Fox and reports the
    unconstrained maximum as exactly 1/9 -- 24/24 seeds at n=6,8 and 8/8 at
    n=12, a false consensus. Raw ascent from the same n=12 seeds already beats
    it (0.1188 > 1/9), and this loop reaches 0.147."""
    x = x0 / np.linalg.norm(x0)
    for _ in range(rounds):
        x = sphere_ascent(x, Eflat, N, alt_idx, Qfun, ((0.0, 0.0),), iters=iters)
        x = sphere_ascent(x, Eflat, N, alt_idx, Qfun,
                          ((0.0, 0.01), (0.0, 0.003), (0.0, 0.0)), iters=iters)
    return x


def bianchi_polish_loop(W0, alt_idx, rounds=3, iters=300):
    """defect_polish_loop's counterpart on {Alt(R) = 0}, basis-free."""
    W = W0
    for _ in range(rounds):
        W, _ = bianchi_ascent(W, alt_idx, (0.0,), iters=iters)
        W, _ = bianchi_ascent(W, alt_idx, (0.01, 0.003, 0.0), iters=iters)
    return W, delta2_and_grad(W, alt_idx)[0]


def polish_to_critical(x0, Eflat, N, alt_idx, Qfun):
    """L-BFGS on the RELATIVE idempotency residual (analytic gradient), so the
    reported delta^2 is read at a point that is critical to 1e-8, not merely
    near-critical. Returns the theta>0 orientation."""
    def fg(xx):
        nx = np.linalg.norm(xx)
        u = xx / nx
        W = (u @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        Q = Qfun(W)
        P = frob(W, Q)
        qq = frob(Q, Q)
        R, GR = resid_and_grad(W, Q, P, Qfun)
        f = R / (qq + 1e-300)
        # d(R/||Q||^2): quotient rule, with d||Q||^2/dW = 4 B(W,Q)
        GQ2 = 4.0 * 0.5 * (Qfun(W + Q) - Qfun(W) - Qfun(Q))
        G = (GR * qq - R * GQ2) / (qq * qq + 1e-300)
        gx = Eflat @ G.reshape(-1)
        gx = (gx - np.dot(gx, u) * u) / nx
        return f, gx

    res = minimize(fg, x0, jac=True, method="L-BFGS-B",
                   options=dict(maxiter=3000, ftol=1e-20, gtol=1e-16))
    x = res.x / np.linalg.norm(res.x)
    W = (x @ Eflat).reshape(N, N)
    W = 0.5 * (W + W.T)
    W, Q, theta = orient_theta_positive(W, Qfun)
    rel = norm(Q - theta * W) / (norm(Q) + 1e-300)
    d2 = delta2_and_grad(W, alt_idx)[0]
    return x, W, theta, rel, d2


# =====================================================================
# NEW PIECE 4: ascent over the BIANCHI space {Alt(R) = 0} with no basis at
# all -- Alt is an orthogonal projection, so R -> R - Alt(R) projects any
# symmetric operator into the space. This searches a strictly larger set
# than W_n (no Ricci-flatness), at any n, with no D x N^2 basis matrix.
# =====================================================================
def bianchi_ascent(W0, alt_idx, eps_schedule, iters=500):
    W = W0 - alt_mop(W0, alt_idx)
    W /= norm(W)
    for eps in eps_schedule:
        f, G = defect_value_grad(W, alt_idx, eps)
        step = 0.2
        for _ in range(iters):
            Gp = G - alt_mop(G, alt_idx)
            Gp = Gp - frob(Gp, W) * W
            if norm(Gp) < 1e-14:
                break
            accepted = False
            for _ in range(60):
                Wn = W + step * Gp
                Wn = Wn - alt_mop(Wn, alt_idx)
                Wn /= norm(Wn)
                fn, Gn = defect_value_grad(Wn, alt_idx, eps)
                if fn > f - 1e-16:
                    accepted = True
                    break
                step *= 0.5
            if not accepted:
                break
            W, f, G = Wn, fn, Gn
            step = min(step * 1.4, 1.0)
    return W, delta2_and_grad(W, alt_idx)[0]


# =====================================================================
# NEW PIECE 5: f(n) = max{ ||Alt(Z)||^2 : Z >= 0, ||Z|| = 1 }, the PSD
# Alt-fraction. Since ||Alt Z||^2 = <Z, Alt Z> (Alt is an orthogonal
# projection) this is a convex quadratic maximized over the PSD cone
# intersected with the unit sphere: projected gradient ascent, whose
# fixed points are exactly the KKT points. Used twice: as the constant in
# the bound delta^2 <= f(n)/4, and as a source of structured seeds.
# =====================================================================
def psd_alt_fraction(N, alt_idx, trials=6, seed=3, iters=3000):
    rng = np.random.default_rng(seed)
    best, bestZ = 0.0, None
    for _ in range(trials):
        M = rng.normal(size=(N, N))
        Z = M @ M.T
        Z /= norm(Z)
        for _ in range(iters):
            G = 2.0 * alt_mop(Z, alt_idx)
            S = Z + 0.25 * G
            w, V = np.linalg.eigh(0.5 * (S + S.T))
            Zn = (V * np.clip(w, 0, None)) @ V.T
            nz = norm(Zn)
            if nz < 1e-14:
                break
            Zn /= nz
            done = norm(Zn - Z) < 1e-13
            Z = Zn
            if done:
                break
        val = frob(Z, alt_mop(Z, alt_idx))
        if val > best:
            best, bestZ = val, Z.copy()
    return best, bestZ


# =====================================================================
# NEW PIECE 6: Fox's S^4(alpha) on a chosen 4-element index block of R^n,
# so that direct sums of Fox blocks on DISJOINT blocks can be built. Uses
# cp2_block_st_tensor at n=4 (the validated champion constructor) and
# re-embeds it, exactly the zero-padding recipe of pad_weyl_to_n.
# =====================================================================
def fox_on_block(L2_big, block, Qfun=None):
    L2_4 = Lambda2(4)
    W4, _, _ = weyl_from_mop(L2_4, mop_from_4tensor(L2_4, cp2_block_st_tensor(4, 1.0, -1.0)))
    W4 = W4 / norm(W4)
    inv = {v: k for k, v in enumerate(block)}

    def T(i, j, k, l):
        if i not in inv or j not in inv or k not in inv or l not in inv:
            return 0.0
        a, b, c, d = inv[i], inv[j], inv[k], inv[l]
        if a == b or c == d:
            return 0.0
        s1 = 1.0
        if a > b:
            a, b, s1 = b, a, -1.0
        s2 = 1.0
        if c > d:
            c, d, s2 = d, c, -1.0
        return s1 * s2 * W4[L2_4.idx[(a, b)], L2_4.idx[(c, d)]]

    W = mop_from_4tensor(L2_big, T)
    W /= norm(W)
    if Qfun is not None and frob(W, Qfun(W)) < 0:
        W = -W
    return W


# =====================================================================
# NEW PIECE 7: the su(m) Ricci-flat KAEHLER family of critical points, whose
# m=3 member PART 4's census turns up at n=6 and which the repo's catalogue
# does not contain (the earlier n=6 searches were gradient ascent; these are
# saddles). Closed form on R^{2m} = C^m with J: e_k <-> e_{k+m}, inside
# Lambda^2 R^{2m} = so(2m), using the Cartan decomposition of the symmetric
# pair (SU(m), SO(m)),
#     su(m) = so(m) (+) p,
#     so(m) = {[[B,0],[0,B]] : B antisymmetric},        dim r1 = m(m-1)/2,
#     p     = {[[0,-S],[S,0]] : S symmetric traceless}, dim r2 = (m-1)(m+2)/2,
#     W(m)  = a*Pi_{so(m)} - b*Pi_p,   r1*a = r2*b,  r1*a^2 + r2*b^2 = 1
# (the two conditions are tr W = 0 and ||W|| = 1). Every member is Ricci-flat,
# Bianchi and EXACTLY critical (residual ~1e-16), with closed forms verified
# here for m = 2..6:
#     theta(m)  = sqrt( m(m+1) / ((m+2)(m-1)) ),
#     delta^2(m) = (m+2) / (12(m+1)),
# so delta^2 decreases strictly from 1/9 at m=2 to 1/12 as m -> infinity, and
# theta decreases from sqrt(3/2) to 1. The m=2 member IS Fox's S^4(alpha):
# su(2) = Lambda^2_+ R^4 and the 1:2 rank split is exactly its 2:(-1):(-1)
# spectrum -- so this family EXPLAINS the champion as the first term of a
# sequence and shows the sequence never beats it. m=3 (theta = sqrt(6/5),
# delta^2 = 5/48 = (15/16)/9) is the runner-up defect anywhere on the critical
# set; everything else critical sits at delta^2 <= 0.048. Each member is
# Kaehler: W(omega_J) = 0, ker W = R*omega_J (+) the non-u(m) part.
# Caution against a numerical coincidence: theta(3) = 1.0954451 equals the
# n=7 balanced sphere-product value in FINDINGS' table, and theta(4) equals
# theta_0(6) -- different points, both of which have delta = 0.
# =====================================================================
def su_m_kahler_weyl(L2, m):
    n = L2.n
    assert n == 2 * m and m >= 2, "the su(m) Kaehler point lives on R^{2m} = C^m"

    def bivec(M):
        v = L2.matrix_to_vec(M)
        return v / np.linalg.norm(v)

    so_m = []
    for i in range(m):
        for j in range(i + 1, m):
            B = np.zeros((m, m))
            B[i, j], B[j, i] = -1.0, 1.0
            M = np.zeros((n, n))
            M[:m, :m] = B
            M[m:, m:] = B
            so_m.append(bivec(M))
    Ss = []
    for i in range(m):
        for j in range(i + 1, m):
            S = np.zeros((m, m))
            S[i, j] = S[j, i] = 1.0
            Ss.append(S)
    for k in range(1, m):
        d = np.zeros(m)
        d[:k] = 1.0
        d[k] = -float(k)
        Ss.append(np.diag(d) / np.linalg.norm(d))
    p_part = []
    for S in Ss:
        M = np.zeros((n, n))
        M[:m, m:] = -S
        M[m:, :m] = S
        p_part.append(bivec(M))
    B1, B2 = np.array(so_m), np.array(p_part)
    r1, r2 = len(so_m), len(p_part)
    G = np.vstack([B1, B2])
    assert np.linalg.norm(G @ G.T - np.eye(r1 + r2)) < 1e-10, "su(m) frame not orthonormal"
    b = np.sqrt(r1 / (r2 * (r1 + r2)))
    a = r2 * b / r1
    return a * (B1.T @ B1) - b * (B2.T @ B2)


_LIGHT_CTX = {}


def light_ctx(n):
    """Q and Alt at dimension n without the D x N^2 Weyl basis -- enough to
    evaluate a CONSTRUCTED tensor (PART 5g builds su(m) points at their own
    n = 2m, where the full setup() basis would be pure overhead)."""
    if n not in _LIGHT_CTX:
        L2 = Lambda2(n)
        idx, pos, N, c = build_structure_constants(n)
        Cflat = build_Cflat(c)
        _LIGHT_CTX[n] = dict(n=n, L2=L2, N=N, alt_idx=build_alt_indices(L2),
                             Qfun=lambda W, Cflat=Cflat, N=N: Q_fast(W, Cflat, N))
    return _LIGHT_CTX[n]


def su_m_theta(m):
    return np.sqrt(m * (m + 1.0) / ((m + 2.0) * (m - 1.0)))


def su_m_delta2(m):
    return (m + 2.0) / (12.0 * (m + 1.0))


# =====================================================================
# PART 0 -- validation
# =====================================================================
def part0_validate(ctxs):
    print("=" * 78)
    print("PART 0: validation of the new gradients and the 1/9 anchor")
    print("=" * 78)
    rng = np.random.default_rng(20260820)
    for n, ctx in ctxs.items():
        N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
        # (a) 1/9 anchor at both orientations
        Wf = fox_weyl(ctx)
        d2p = delta2_and_grad(Wf, alt_idx)[0]
        d2m = delta2_and_grad(-Wf, alt_idx)[0]
        # (b) Alt(W_+) = Alt(W_-) on random Weyl tensors
        worst_alt = 0.0
        for _ in range(50):
            x = rng.normal(size=D)
            x /= np.linalg.norm(x)
            W = (x @ Eflat).reshape(N, N)
            W = 0.5 * (W + W.T)
            Wm = spectral_split(W)
            worst_alt = max(worst_alt, norm(alt_mop(Wm + W, alt_idx) - alt_mop(Wm, alt_idx)))
        # (c) residual gradient vs central differences
        worst_r = 0.0
        for _ in range(4):
            x = rng.normal(size=D)
            x /= np.linalg.norm(x)
            v = rng.normal(size=D)
            v -= np.dot(v, x) * x
            v /= np.linalg.norm(v)
            W, Q, P = state_of(x, Eflat, N, Qfun)
            R, G = resid_and_grad(W, Q, P, Qfun)
            gx = Eflat @ G.reshape(-1)
            an = np.dot(gx - np.dot(gx, x) * x, v)
            h = 1e-6

            def Rat(xx):
                xx = xx / np.linalg.norm(xx)
                W2, Q2, P2 = state_of(xx, Eflat, N, Qfun)
                return frob(Q2, Q2) - P2 * P2
            fd = (Rat(x + h * v) - Rat(x - h * v)) / (2 * h)
            worst_r = max(worst_r, abs(fd - an) / (abs(fd) + abs(an) + 1e-300))
        # (d) smoothed defect gradient vs central differences, and eps -> 0
        worst_s, worst_lim = 0.0, 0.0
        for _ in range(4):
            x = rng.normal(size=D)
            x /= np.linalg.norm(x)
            W = (x @ Eflat).reshape(N, N)
            W = 0.5 * (W + W.T)
            H = rng.normal(size=(N, N))
            H = 0.5 * (H + H.T)
            H /= norm(H)
            d2e, Ge = smooth_delta2_and_grad(W, alt_idx, 0.05)
            h = 1e-6
            fd = (smooth_delta2_and_grad(W + h * H, alt_idx, 0.05)[0]
                  - smooth_delta2_and_grad(W - h * H, alt_idx, 0.05)[0]) / (2 * h)
            an = frob(Ge, H)
            worst_s = max(worst_s, abs(fd - an) / (abs(fd) + abs(an) + 1e-300))
            worst_lim = max(worst_lim, abs(smooth_delta2_and_grad(W, alt_idx, 1e-9)[0]
                                           - delta2_and_grad(W, alt_idx)[0]))
        ok = (abs(d2p - D0_EXACT) < 1e-12 and abs(d2m - D0_EXACT) < 1e-12
              and worst_alt < 1e-12 and worst_r < 1e-5 and worst_s < 1e-5 and worst_lim < 1e-9)
        print(f"  n={n}: delta^2(Fox)={d2p:.10f} / antipode {d2m:.10f} (1/9={D0_EXACT:.10f})")
        print(f"        max ||Alt(W_+)-Alt(W_-)|| over 50 random Weyl = {worst_alt:.1e}   "
              f"resid-grad err={worst_r:.1e}  smooth-grad err={worst_s:.1e}  "
              f"|delta^2_eps - delta^2| at eps=1e-9: {worst_lim:.1e}   {'PASS' if ok else 'FAIL'}")
        assert ok, "validation failed -- stop"


# =====================================================================
# PART 1 -- catalogue
# =====================================================================
def catalogue_points(n, ctx):
    """(label, W) for every named critical point available at this n."""
    pts = [(f"sphere ({p},{n-p})", sphere_weyl(ctx, p)) for p in range(2, n // 2 + 1)]
    pts.append(("Fox S^4(alpha)", fox_weyl(ctx)))
    if n == 8:
        L2_8, Wsu3 = build_su3_n8()
        pts.append(("SU(3) bi-invariant", Wsu3))
        pts.append(("QK HP^2", qk_weyl(ctx, 2)))
    elif n > 8:
        L2_8, Wsu3 = build_su3_n8()
        pts.append((f"SU(3) padded 8->{n}", pad_weyl_to_n(L2_8, Wsu3, n)[1]))
        L2_8b = Lambda2(8)
        Whp2 = weyl_from_mop(L2_8b, mop_from_4tensor(L2_8b, qk_tensor(8, 2, 1.0, 1.0)))[0]
        pts.append((f"QK HP^2 padded 8->{n}", pad_weyl_to_n(L2_8b, Whp2 / norm(Whp2), n)[1]))
        if n >= 12:
            pts.append(("QK HP^3", qk_weyl(ctx, 3)))
    if n >= 8:
        k = n // 4
        blocks = [list(range(4 * i, 4 * i + 4)) for i in range(k)]
        Wsum = sum(fox_on_block(ctx["L2"], b, ctx["Qfun"]) for b in blocks) / np.sqrt(k)
        pts.append((f"balanced {k}-block Fox sum", Wsum))
    L2_6 = Lambda2(6)
    Wsu3k = su_m_kahler_weyl(L2_6, 3)
    pts.append(("su(3) Kaehler m=3" if n == 6 else f"su(3) Kaehler padded 6->{n}",
                Wsu3k if n == 6 else pad_weyl_to_n(L2_6, Wsu3k, n)[1]))
    if n % 2 == 0 and n >= 8:
        pts.append((f"su({n//2}) Kaehler m={n//2}", su_m_kahler_weyl(ctx["L2"], n // 2)))
    return pts


def part1_catalogue(n, ctx):
    print(f"\n  -- PART 1: catalogue at n={n} (theta>0 orientation) --")
    worst = -np.inf
    for label, W in catalogue_points(n, ctx):
        W, Q, theta = orient_theta_positive(W, ctx["Qfun"])
        rel = norm(Q - theta * W) / (norm(Q) + 1e-300)
        d2 = delta2_and_grad(W, ctx["alt_idx"])[0]
        w = np.linalg.eigvalsh(W)
        rp = int(np.sum(w > 1e-9))
        rm = int(np.sum(w < -1e-9))
        flag = "  <-- ABOVE 1/9" if d2 > D0_EXACT + 1e-9 else ("  (ties 1/9)" if d2 > D0_EXACT - 1e-9 else "")
        print(f"    {label:26s} theta={theta:+.6f} delta^2={d2:.8f} resid={rel:.1e} "
              f"(r+,r-)=({rp},{rm}) tr|W|={np.sum(np.abs(w)):.4f}{flag}")
        worst = max(worst, d2)
    print(f"    max catalogue delta^2 = {worst:.8f}   (1/9 = {D0_EXACT:.8f})")
    return worst


# =====================================================================
# PART 2 -- the unconstrained control
# =====================================================================
EPS_ANNEAL = (0.3, 0.1, 0.03, 0.01, 0.003, 0.001, 0.0)


def part2_unconstrained(n, ctx, n_seeds=16, iters=300, seed=101, rounds=3, keep=4):
    """Returns (max delta^2, [maximizing x's]) -- the x's seed PART 3."""
    print(f"\n  -- PART 2: unconstrained max of delta^2 over the unit Weyl sphere (n={n}) --")
    N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
    rng = np.random.default_rng(seed)
    t0 = time.time()
    best, trapped_best = [], -np.inf
    for k in range(n_seeds):
        x0 = rng.normal(size=D)
        if k < 3:  # the large-eps annealing that got this wrong first time round
            xt = sphere_ascent(x0, Eflat, N, alt_idx, Qfun,
                               tuple((0.0, e) for e in EPS_ANNEAL), iters=iters)
            Wt = (xt @ Eflat).reshape(N, N)
            trapped_best = max(trapped_best, delta2_and_grad(0.5 * (Wt + Wt.T), alt_idx)[0])
        x = defect_polish_loop(x0, Eflat, N, alt_idx, Qfun, rounds=rounds, iters=iters)
        W = (x @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        best.append((delta2_and_grad(W, alt_idx)[0], k, W, x))
    best.sort(key=lambda r: -r[0])
    print(f"    {n_seeds} random seeds, raw+small-eps polish loops [{time.time()-t0:.0f}s]")
    for d2, k, W, _ in best[:3]:
        w = np.linalg.eigvalsh(W)
        nz = w[np.abs(w) > 1e-6]
        Wo, Qo, theta = orient_theta_positive(W, Qfun)
        rel = norm(Qo - theta * Wo) / (norm(Qo) + 1e-300)
        print(f"      seed{k:2d}: delta^2={d2:.9f}  theta={theta:+.6f}  idemp_resid={rel:.1e}  "
              f"{len(nz)} nonzero eigenvalues, tr|W|={np.sum(np.abs(w)):.4f}")
    print(f"    max delta^2 = {best[0][0]:.9f}   vs 1/9 = {D0_EXACT:.9f}   "
          f"EXCESS = {best[0][0]-D0_EXACT:+.6f}")
    print(f"    [the same seeds under eps-annealing from eps=0.3 report only "
          f"{trapped_best:.9f}: large-eps smoothing funnels every start into Fox, "
          f"which is how\n     a first pass here wrongly concluded the unconstrained "
          f"maximum was 1/9]")
    return best[0][0], [b[3] for b in best[:keep]]


def part2b_bianchi(n, alt_idx, N, n_seeds=12, seed=202, iters=400):
    print(f"\n  -- PART 2b: same maximum over ALL algebraic curvature operators "
          f"{{Alt(R)=0}} (n={n}) --")
    rng = np.random.default_rng(seed)
    t0 = time.time()
    best, bestW = -np.inf, None
    for _ in range(n_seeds):
        S = rng.normal(size=(N, N))
        S = 0.5 * (S + S.T)
        S = S - alt_mop(S, alt_idx)
        S /= norm(S)
        W, d2 = bianchi_polish_loop(S, alt_idx, rounds=2, iters=iters)
        if d2 > best:
            best, bestW = d2, W
    w = np.linalg.eigvalsh(bestW)
    nz = np.sort(w[np.abs(w) > 1e-6])[::-1]
    print(f"    {n_seeds} random seeds [{time.time()-t0:.0f}s]  max delta^2={best:.9f}  "
          f"(1/9={D0_EXACT:.9f}, excess={best-D0_EXACT:+.6f})")
    print(f"    argmax spectrum ({len(nz)} nonzero)="
          f"{np.array2string(nz[:12], precision=5, max_line_width=200)}"
          f"{' ...' if len(nz) > 12 else ''}")
    return best


# =====================================================================
# PART 3 -- the constrained hunt
# =====================================================================
def part5h_n4_proof(n_random=200, seed=707):
    """n = 4 is PROVEN outright, and the proof is two lines. On Lambda^2 R^4 =
    Lambda^2_+ (+) Lambda^2_-, a Weyl operator is block diagonal with both
    blocks traceless (the off-diagonal block is the traceless Ricci part, the
    block traces are the scalar curvature) -- verified below on random Weyl
    tensors. Write W = A (+) B, ||A||^2 + ||B||^2 = 1. Lambda^4 R^4 = R*star
    with star = Pi_+ - Pi_-, so
        delta = ||Alt(W_-)|| = |<W_-, star>| / ||star|| = |tr A_- - tr B_-| / sqrt6.
    For a traceless symmetric 3x3 matrix of norm alpha, tr(A_-) = tr(A_+) =
    ||A||_1 / 2 <= 2*alpha/sqrt6 (the extreme spectra being alpha*(2,-1,-1)/sqrt6
    and its negative), and tr(B_-) >= 0, so delta <= (2/sqrt6)/sqrt6 = 1/3 with
    equality iff B = 0 and A has spectrum proportional to (2,-1,-1). That is
    exactly Fox's S^4(alpha) and its antipode. Hence delta^2 <= 1/9 at n = 4,
    for every unit Weyl operator, critical or not, with equality only there."""
    print("\n" + "=" * 78)
    print("PART 5h: the n=4 case, proven -- chirality blocks force delta^2 <= 1/9")
    print("=" * 78)
    ctx = setup(4, verbose=False)
    L2, N, D, Eflat, alt_idx = ctx["L2"], ctx["N"], ctx["D"], ctx["Eflat"], ctx["alt_idx"]

    def bv(i, j, s=1.0):
        e = np.zeros(N)
        e[L2.idx[(i, j)]] = s
        return e
    sd = [(bv(0, 1) + bv(2, 3)) / np.sqrt(2), (bv(0, 2) - bv(1, 3)) / np.sqrt(2),
          (bv(0, 3) + bv(1, 2)) / np.sqrt(2)]
    asd = [(bv(0, 1) - bv(2, 3)) / np.sqrt(2), (bv(0, 2) + bv(1, 3)) / np.sqrt(2),
           (bv(0, 3) - bv(1, 2)) / np.sqrt(2)]
    Pp = sum(np.outer(u, u) for u in sd)
    Pm = sum(np.outer(u, u) for u in asd)
    rng = np.random.default_rng(seed)
    worst_off, worst_tr, worst_d = 0.0, 0.0, 0.0
    for _ in range(n_random):
        x = rng.normal(size=D)
        x /= np.linalg.norm(x)
        W = (x @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        worst_off = max(worst_off, norm(Pp @ W @ Pm))
        worst_tr = max(worst_tr, abs(np.trace(Pp @ W @ Pp)), abs(np.trace(Pm @ W @ Pm)))
        Wm = spectral_split(W)
        d = np.sqrt(delta2_and_grad(W, alt_idx)[0])
        pred = abs(np.trace(Pp @ Wm @ Pp) - np.trace(Pm @ Wm @ Pm)) / np.sqrt(6)
        worst_d = max(worst_d, abs(d - pred))
    print(f"  dim(Weyl_4)={D} (= 5+5);  over {n_random} random unit Weyl tensors: "
          f"max ||Pi_+ W Pi_-||={worst_off:.1e},")
    print(f"  max |tr(block)|={worst_tr:.1e}, and max |delta - |tr A_- - tr B_-|/sqrt6| "
          f"= {worst_d:.1e}")
    print(f"  => delta <= (2/sqrt6)/sqrt6 = 1/3, i.e. delta^2 <= 1/9 at n=4, "
          f"equality only on the Fox orbit.  [PROVEN]")


def part2c_dimension_sweep(ns=(4, 5, 7, 9, 10, 14, 16), n_seeds=4, seed=909, iters=300):
    """The Bianchi-space ascent needs no Weyl basis, so the unconstrained
    maximum can be tracked at dimensions where building one would dominate the
    cost -- including odd n, which the rest of the program mostly skips.
    {Alt(R)=0} contains W_n, so this upper-bounds the Weyl-sphere maximum.
    The measured onset: the maximum is exactly 1/9 at n=4 and n=5 and exceeds
    it from n=6 up, growing monotonically -- the same place c_1(n) first
    exceeds its R^4 value 1/sqrt6, i.e. where m = floor(n/2) reaches 3 and a
    4-form gets room to spread over more than one pair of 2-planes."""
    print("\n" + "=" * 78)
    print("PART 2c: dimension sweep of the unconstrained maximum over {Alt(R)=0}")
    print("=" * 78)
    for n in ns:
        t0 = time.time()
        L2 = Lambda2(n)
        alt_idx = build_alt_indices(L2)
        best = part2b_bianchi(n, alt_idx, L2.N, n_seeds=n_seeds, seed=seed + n, iters=iters)
        tag = ("ceiling holds WITHOUT criticality" if best <= D0_EXACT + 1e-7
               else "above 1/9 -- so at this n only criticality bounds delta^2")
        print(f"    [n={n}: {time.time()-t0:.0f}s]  {tag}")


def part3_hunt(n, ctx, n_random=10, iters=300, seed=303, uncon_seeds=(),
               mus=(0.3, 1.0, 3.0, 10.0, 30.0, 1e2, 3e2, 1e3, 1e4)):
    """Slide the unconstrained maximizers -- which sit ABOVE 1/9 (PART 2) --
    onto the critical set by ramping the penalty, and read delta^2 there. No
    smoothing anywhere in this part: eps = 0 throughout, since PART 2 showed
    smoothing biases the defect landscape toward Fox."""
    print(f"\n  -- PART 3: constrained hunt, max delta^2 subject to criticality (n={n}) --")
    N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
    rng = np.random.default_rng(seed)
    schedule = [(mu, 0.0) for mu in mus]

    seeds = [(f"uncon-max {k}", x.copy()) for k, x in enumerate(uncon_seeds)]
    xf, _ = project_to_x(fox_weyl(ctx), Eflat, N)
    seeds.append(("Fox(exact)", xf.copy()))
    for s in (0.05, 0.2, 0.5, 1.0):
        d = rng.normal(size=D)
        d /= np.linalg.norm(d)
        seeds.append((f"Fox(pert s={s})", xf + s * d))
    f_psd, Zs = psd_alt_fraction(N, alt_idx)
    w, V = np.linalg.eigh(Zs)
    order = np.argsort(-w)
    w, V = w[order], V[:, order]
    k = int(np.sum(w > 1e-8))
    for split in range(1, min(k, 6)):
        sgn = np.ones(N)
        sgn[split:] = -1.0
        Wc = (V * (w * sgn)) @ V.T
        x0 = Eflat @ Wc.reshape(-1)
        if np.linalg.norm(x0) > 1e-9:
            seeds.append((f"PSD-Altmax split@{split}", x0))
    for r in range(n_random):
        seeds.append((f"random {r}", rng.normal(size=D)))

    t0 = time.time()
    rows = []
    for label, x0 in seeds:
        x = sphere_ascent(x0, Eflat, N, alt_idx, Qfun, schedule, iters=iters)
        xp, W, theta, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
        rows.append((d2, rel, theta, label, W))
    rows.sort(key=lambda r: -r[0])
    print(f"    PSD Alt-fraction f({n})={f_psd:.6f} -> bound delta^2 <= f/4 = {f_psd/4:.6f}")
    print(f"    {len(seeds)} seeds ({len(uncon_seeds)} unconstrained maximizers + 1 exact Fox "
          f"+ 4 perturbed + {min(k,6)-1} structured + {n_random} random) "
          f"[{time.time()-t0:.0f}s]")
    for d2, rel, theta, label, W in rows[:8]:
        flag = "  <-- REFUTATION" if (d2 > D0_EXACT + 1e-6 and rel < 1e-6) else ""
        print(f"      delta^2={d2:.8f}  theta={theta:+.6f}  resid={rel:.1e}  seed={label}{flag}")
    viol = [r for r in rows if r[0] > D0_EXACT + 1e-6 and r[1] < 1e-6]
    for d2, rel, theta, label, W in viol:
        fn = f"scripts/data/defect_violation_n{n}_{d2:.6f}.npy"
        np.save(fn, W)
        print(f"      SAVED violating critical point to {fn}")
    for tol in (1e-6, 1e-4, 1e-3):
        conv = [r for r in rows if r[1] < tol]
        print(f"    residual < {tol:.0e}: {len(conv)}/{len(rows)} seeds, max delta^2 = "
              f"{max((r[0] for r in conv), default=float('nan')):.8f}  "
              f"({'<= 1/9' if max((r[0] for r in conv), default=0.0) <= D0_EXACT + 1e-6 else 'ABOVE 1/9'})")
    print(f"    strict violations (resid < 1e-6 and delta^2 > 1/9 + 1e-6): {len(viol)}")
    return rows


def part3c_theta_frontier(n, ctx, th_targets=(0.05, 0.15, 0.25, 0.35, 0.45, 0.55,
                                              0.7, 0.85, 1.0, 1.15),
                          n_seeds=3, seed=808, rounds=2, iters=200):
    """THE PART THAT REFUTES THE CONJECTURE, and the reason it is here: sweeping
    a theta TARGET as a second penalty term, so the search is pinned at a chosen
    theta while it maximizes delta^2, reaches critical points that a plain
    penalty ramp never visits. The plain ramp always slid back to Fox; pinned at
    theta ~ 0.4 it lands instead on

        W = a*Pi_4 - b*Pi_6  on a 10-dimensional subspace of Lambda^2 R^8,
        a = 3/(2 sqrt15),  b = 1/sqrt15   (forced by ||W||=1 and tr W = 0),

    which is EXACTLY critical -- theta = sqrt(3/20) = 0.3872983346, residual
    7e-9 absolute under two independent Q implementations, Bianchi and
    Ricci-flat to 4e-16 -- and carries delta^2 = 3/25 = 0.12, eight percent
    ABOVE the conjectured 1/9. Same two-projection shape as Fox itself (1,2),
    as the su(m) Kaehler family ((3,5), (6,9)) and as the theta=0 point (5,5);
    the rank pair (4,6) is simply one the catalogue never contained."""
    print(f"\n  -- PART 3c: theta-pinned frontier of max delta^2 (n={n}) --")
    N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
    rng = np.random.default_rng(seed)

    def pieces(xx):
        u = xx / np.linalg.norm(xx)
        W = (u @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        Q = Qfun(W)
        return u, W, Q, frob(W, Q)

    def obj_factory(mu, nu, tt):
        def fg(xx):
            nx = np.linalg.norm(xx)
            u, W, Q, P = pieces(xx)
            d2, Gd = delta2_and_grad(W, alt_idx)
            R = frob(Q, Q) - P * P
            B = 0.5 * (Qfun(W + Q) - Qfun(W) - Qfun(Q))
            GR = 4.0 * B - 6.0 * P * Q
            g = Eflat @ (-Gd + mu * GR + nu * 2 * (P - tt) * 3.0 * Q).reshape(-1)
            return -d2 + mu * R + nu * (P - tt) ** 2, (g - np.dot(g, u) * u) / nx
        return fg

    t0 = time.time()
    out = []
    for tt in th_targets:
        for _ in range(n_seeds):
            x = defect_polish_loop(rng.normal(size=D), Eflat, N, alt_idx, Qfun,
                                   rounds=rounds, iters=iters)
            for mu in (1.0, 10.0, 1e2, 1e3, 1e4, 1e5):
                x = minimize(obj_factory(mu, mu, tt), x, jac=True, method="L-BFGS-B",
                             options=dict(maxiter=600, ftol=1e-20, gtol=1e-16)).x
                x /= np.linalg.norm(x)
            xp, W, theta, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
            out.append((d2, theta, rel, W))
    good = [r for r in out if r[2] < 1e-6 and r[1] > 1e-3]
    good.sort(key=lambda r: -r[0])
    print(f"    {len(th_targets)}x{n_seeds} runs [{time.time()-t0:.0f}s]; "
          f"{len(good)}/{len(out)} converged to residual < 1e-6 with theta > 0")
    seen = []
    for d2, th, rel, W in good:
        if any(abs(th - t) < 1e-4 and abs(d2 - d) < 1e-6 for d, t in seen):
            continue
        seen.append((d2, th))
        w = np.linalg.eigvalsh(W)
        rp, rm = int(np.sum(w > 1e-8)), int(np.sum(w < -1e-8))
        flag = "  <<< ABOVE 1/9 -- REFUTATION" if d2 > D0_EXACT + 1e-6 else ""
        print(f"      delta^2={d2:.9f} theta={th:.9f} resid={rel:.1e} "
              f"(r+,r-)=({rp},{rm}){flag}")
        if len(seen) >= 10:
            break
    viol = [r for r in good if r[0] > D0_EXACT + 1e-6]
    if viol:
        d2, th, rel, W = viol[0]
        fn = f"scripts/data/defect_violation_n{n}_{d2:.6f}.npy"
        np.save(fn, W)
        print(f"    *** REFUTATION at n={n}: a critical point with theta={th:.9f} > 0 and")
        print(f"    *** delta^2={d2:.9f} > 1/9 = {D0_EXACT:.9f} (residual {rel:.1e}). "
              f"Saved to {fn}.")
    mx = max((r[0] for r in good), default=float("nan"))
    print(f"    max delta^2 over converged theta>0 critical points: {mx:.9f}")
    return mx, good


def part3b_theta_zero(n, ctx, n_seeds=8, seed=616, rounds=2, iters=250):
    """THE theta = 0 STRATUM {Q(W) = 0}, where the conjecture as literally
    stated fails. Those W are genuine critical points of P on the unit sphere
    -- the tangential gradient is 3(Q - P W) = 3Q = 0 -- with critical value
    P = 0, and no theta > 0 orientation exists at them, so the conjecture's own
    orientation clause is what excludes them.

    They are invisible to the usual RELATIVE residual ||Q - theta W||/||Q||,
    which is 0/0 there and evaluates to 1: PART 2's n=8 maximizer prints
    'residual 1.0' while being exactly critical. This part therefore drives
    ||Q(W)||^2 itself to zero (absolute, the only meaningful measure at
    theta = 0) while holding delta^2 up, and reports what the stratum carries.

    Measured: at n=8 it contains unit Weyl operators with Q(W) = 0 to 1e-12,
    spectrum (1/sqrt10)*(+1,+1,+1,+1,+1,-1,-1,-1,-1,-1) and delta^2 = 1/8
    EXACTLY -- above 1/9. Confirmed with the independent Q_op implementation."""
    print(f"\n  -- PART 3b: the theta=0 stratum {{Q(W)=0}} (n={n}) --")
    N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
    rng = np.random.default_rng(seed)

    def state(xx):
        u = xx / np.linalg.norm(xx)
        W = (u @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        return u, W, Qfun(W)

    def qnorm_fg(xx):
        nx = np.linalg.norm(xx)
        u, W, Q = state(xx)
        G = 4.0 * 0.5 * (Qfun(W + Q) - Qfun(W) - Qfun(Q))
        g = Eflat @ G.reshape(-1)
        return frob(Q, Q), (g - np.dot(g, u) * u) / nx

    t0 = time.time()
    rows = []
    for _ in range(n_seeds):
        x = defect_polish_loop(rng.normal(size=D), Eflat, N, alt_idx, Qfun,
                               rounds=rounds, iters=iters)
        for mu in (1.0, 10.0, 1e2, 1e3, 1e4):
            def fg(xx, mu=mu):
                nx = np.linalg.norm(xx)
                u, W, Q = state(xx)
                d2, Gd = delta2_and_grad(W, alt_idx)
                G = 4.0 * 0.5 * (Qfun(W + Q) - Qfun(W) - Qfun(Q))
                g = Eflat @ (mu * G - Gd).reshape(-1)
                return mu * frob(Q, Q) - d2, (g - np.dot(g, u) * u) / nx
            x = minimize(fg, x, jac=True, method="L-BFGS-B",
                         options=dict(maxiter=800, ftol=1e-20, gtol=1e-16)).x
            x /= np.linalg.norm(x)
        x = minimize(qnorm_fg, x, jac=True, method="L-BFGS-B",
                     options=dict(maxiter=2000, ftol=1e-22, gtol=1e-18)).x
        x /= np.linalg.norm(x)
        u, W, Q = state(x)
        rows.append((delta2_and_grad(W, alt_idx)[0], norm(Q), W))
    rows.sort(key=lambda r: -r[0])
    print(f"    {n_seeds} seeds [{time.time()-t0:.0f}s]; best five delta^2: "
          f"{np.array2string(np.array([r[0] for r in rows[:5]]), precision=9)}")
    d2, qn, W = rows[0]
    w = np.linalg.eigvalsh(W)
    nz = np.sort(w[np.abs(w) > 1e-7])[::-1]
    print(f"    best: delta^2={d2:.9f}  ||Q(W)||={qn:.2e}  ||W||={norm(W):.10f}  "
          f"{len(nz)} nonzero eigenvalues, ||W_-||^2={frob(spectral_split(W), spectral_split(W)):.6f}")
    good = [r for r in rows if r[1] < 1e-7]
    mx = max((r[0] for r in good), default=float("nan"))
    print(f"    {len(good)}/{len(rows)} reached ||Q(W)|| < 1e-7; max delta^2 there = {mx:.9f}")
    if good and mx > D0_EXACT + 1e-6:
        fn = f"scripts/data/defect_theta0_n{n}_{mx:.6f}.npy"
        np.save(fn, good[0][2])
        print(f"    *** ABOVE 1/9 AT AN EXACTLY CRITICAL POINT (theta = 0). Saved to {fn}.")
        print(f"    *** The conjecture is refuted as literally stated and survives only")
        print(f"    *** with its theta > 0 clause, which is therefore load-bearing.")
    return mx if good else float("nan")


# =====================================================================
# PART 4 -- the critical-point census (saddles included)
# =====================================================================
def critical_census(n, ctx, n_starts=30, seed=404, theta_min=0.02):
    """Minimize the relative idempotency residual with ANALYTIC gradients from
    random starts. Unlike ascent this reaches saddles, and unlike
    run_j5_structure.generic_critical_points' finite-difference L-BFGS it costs
    O(1) Q-evaluations per gradient rather than O(D)."""
    N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
    rng = np.random.default_rng(seed)
    found, near_zero = [], []
    for _ in range(n_starts):
        x, W, theta, rel, d2 = polish_to_critical(rng.normal(size=D), Eflat, N, alt_idx, Qfun)
        if rel >= 1e-6:
            continue
        rec = (theta, d2, W)
        if theta < theta_min:
            near_zero.append(rec)
        elif all(abs(theta - t) > 2e-4 or abs(d2 - d) > 2e-5 for t, d, _ in found):
            found.append(rec)
    found.sort(key=lambda r: -r[1])
    near_zero.sort(key=lambda r: -r[1])
    return found, near_zero


def part4_census(n, ctx, n_starts=30, seed=404):
    print(f"\n  -- PART 4: critical-point census by residual minimization (n={n}) --")
    t0 = time.time()
    found, near_zero = critical_census(n, ctx, n_starts=n_starts, seed=seed)
    print(f"    {n_starts} starts -> {len(found)} distinct critical points with theta>0.02, "
          f"{len(near_zero)} with theta~0 [{time.time()-t0:.0f}s]")
    for theta, d2, W in found[:8]:
        print(f"      theta={theta:+.6f}  delta^2={d2:.8f}")
    if near_zero:
        print(f"      theta~0 population: max delta^2={max(r[1] for r in near_zero):.8f} "
              f"at theta={near_zero[0][0]:.2e}  (Q(W)=0 points; the theta>0 orientation "
              f"the conjecture asks for does not exist there)")
    allpts = found + near_zero
    mx = max((r[1] for r in allpts), default=0.0)
    print(f"    max delta^2 over the census = {mx:.8f}")
    return found, near_zero


# =====================================================================
# PART 5 -- the analytic structure
# =====================================================================
def part5_analytic(n, ctx):
    print(f"\n  -- PART 5: analytic structure at n={n} --")
    N, D, Eflat, Qfun, alt_idx, L2 = (ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"],
                                      ctx["alt_idx"], ctx["L2"])
    rng = np.random.default_rng(505)
    m = n // 2

    # (a) delta = ||Alt(|W|)||/2 and orientation blindness
    worst_half, worst_flip = 0.0, 0.0
    for _ in range(30):
        x = rng.normal(size=D)
        x /= np.linalg.norm(x)
        W = (x @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        Wm = spectral_split(W)
        d = np.sqrt(delta2_and_grad(W, alt_idx)[0])
        worst_half = max(worst_half, abs(d - norm(alt_mop(Wm + Wm + W, alt_idx)) / 2))
        worst_flip = max(worst_flip, abs(delta2_and_grad(W, alt_idx)[0]
                                         - delta2_and_grad(-W, alt_idx)[0]))
    print(f"    (a) delta = ||Alt(|W|)||/2: worst err {worst_half:.1e};  "
          f"delta^2(W)=delta^2(-W): worst err {worst_flip:.1e}   [PROVEN: Alt(W)=0 "
          f"=> Alt(W_+)=Alt(W_-)]")

    # (b) the unconditional 1/4 bound
    worst_q = 0.0
    for _ in range(30):
        x = rng.normal(size=D)
        x /= np.linalg.norm(x)
        W = (x @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        Wm = spectral_split(W)
        A = alt_mop(Wm, alt_idx)
        d2 = frob(A, A)
        worst_q = max(worst_q, d2 - 0.25)
    print(f"    (b) delta^2 <= 1/4 (Cauchy-Schwarz on delta^2 = <A,|W|>/2): worst excess "
          f"{worst_q:+.4f} over 30 random Weyl   [PROVEN]")

    # (c) c_1(n) and the normal-form identity
    worst_e2 = 0.0
    for _ in range(20):
        lam = rng.normal(size=m)
        v = np.zeros(N)
        for k in range(m):
            v[L2.idx[(2 * k, 2 * k + 1)]] = lam[k]
        v /= np.linalg.norm(v)
        p = (lam ** 2) / np.sum(lam ** 2)
        e2 = 0.5 * (np.sum(p) ** 2 - np.sum(p ** 2))
        worst_e2 = max(worst_e2, abs(frob(alt_mop(np.outer(v, v), alt_idx),
                                          alt_mop(np.outer(v, v), alt_idx)) - (2.0 / 3.0) * e2))
    c1 = np.sqrt((m - 1) / (3.0 * m))
    best_rank1 = 0.0
    for _ in range(200):
        u = rng.normal(size=N)
        u /= np.linalg.norm(u)
        best_rank1 = max(best_rank1, norm(alt_mop(np.outer(u, u), alt_idx)))
    print(f"    (c) ||Alt(vv^T)||^2 = (2/3)e_2(lambda^2): worst err {worst_e2:.1e}; "
          f"c_1({n})=sqrt((m-1)/3m)={c1:.6f}; 200 random rank-1 probes max {best_rank1:.6f}")

    # (d) the Fox-sharp chain, tested at the catalogue
    print(f"    (d) chain  delta^4 <= lambda_max(A)^2 * r_+ r_-/(r_+ + r_-):")
    for label, W in catalogue_points(n, ctx)[:12]:
        W, _, theta = orient_theta_positive(W, Qfun)
        Wm = spectral_split(W)
        A = alt_mop(Wm, alt_idx)
        d2 = frob(A, A)
        if d2 < 1e-14:
            continue
        w = np.linalg.eigvalsh(W)
        rp, rm = int(np.sum(w > 1e-9)), int(np.sum(w < -1e-9))
        lam = np.linalg.eigvalsh(A).max()
        rhs = lam ** 2 * rp * rm / (rp + rm)
        print(f"        {label:26s} delta^4={d2*d2:.3e} <= {rhs:.3e}  ratio={d2*d2/rhs:.6f}  "
              f"lambda_max(A)/||A||={lam/np.sqrt(d2):.6f} (R^4 value 1/sqrt6={1/np.sqrt(6):.6f})")

    # (e) the self-dual block: Alt(Z) = (tr Z/6) star, hence the exact 1/9
    def bv(i, j):
        e = np.zeros(N)
        e[L2.idx[(i, j)]] = 1.0
        return e
    sd = [(bv(0, 1) + bv(2, 3)) / np.sqrt(2), (bv(0, 2) - bv(1, 3)) / np.sqrt(2),
          (bv(0, 3) + bv(1, 2)) / np.sqrt(2)]
    asd = [(bv(0, 1) - bv(2, 3)) / np.sqrt(2), (bv(0, 2) + bv(1, 3)) / np.sqrt(2),
           (bv(0, 3) - bv(1, 2)) / np.sqrt(2)]
    star = sum(np.outer(u, u) for u in sd) - sum(np.outer(u, u) for u in asd)
    B = np.array(sd)
    worst_sd = 0.0
    for _ in range(20):
        C = rng.normal(size=(3, 3))
        C = 0.5 * (C + C.T)
        Z = B.T @ C @ B
        worst_sd = max(worst_sd, norm(alt_mop(Z, alt_idx) - (np.trace(Z) / 6.0) * star))
    print(f"    (e) Alt(Z) = (tr Z/6)*star on Sym^2(Lambda^2_+ R^4): worst err {worst_sd:.1e}, "
          f"||star||=sqrt6={norm(star):.6f}")
    print(f"        => inside that block delta^2 = t^2/6 with t = tr W_+ = tr W_-, and "
          f"min(||W_+||^2+||W_-||^2) = t^2(1/r_+ + 1/r_-) forces r_+ r_- = 1*2, t^2 = 2/3, "
          f"delta^2 = 1/9 EXACTLY -- Fox's 2:1:1 spectrum, PROVEN maximal in the ansatz")

    # (f) the Fox plateau: weighted direct sums of Fox blocks
    if n >= 8:
        k = n // 4
        blocks = [list(range(4 * i, 4 * i + 4)) for i in range(k)]
        Ws = [fox_on_block(L2, b, Qfun) for b in blocks]
        print(f"    (f) Fox plateau at n={n} ({k} disjoint R^4 blocks):")
        for weights in ([1.0] + [0.0] * (k - 1), [1.0 / np.sqrt(k)] * k,
                        [0.9] + [np.sqrt((1 - 0.81) / max(k - 1, 1))] * (k - 1)):
            Wsum = sum(c * Wi for c, Wi in zip(weights, Ws))
            Wsum = Wsum / norm(Wsum)
            Wsum, Q, theta = orient_theta_positive(Wsum, Qfun)
            rel = norm(Q - theta * Wsum) / (norm(Q) + 1e-300)
            d2 = delta2_and_grad(Wsum, alt_idx)[0]
            print(f"        weights={np.array2string(np.array(weights), precision=4)}: "
                  f"delta^2={d2:.9f}  theta={theta:+.6f}  resid={rel:.1e}"
                  f"{'   <-- critical, ties 1/9' if rel < 1e-8 and abs(d2-D0_EXACT) < 1e-9 else ''}")
        print(f"        balanced k-block sum: theta = sqrt(3/2)/sqrt(k) = "
              f"{SQRT32/np.sqrt(k):.6f} predicted")
        # the general law behind the plateau: on disjoint index blocks the
        # Lambda^4 components are orthogonal, so delta^2 of a direct sum is the
        # CONVEX COMBINATION of the blocks' delta^2 -- assembling copies can
        # never beat the best single block. Demonstrated on two blocks with
        # different defects (su(3) Kaehler on 0..5, Fox on the last four).
        if n >= 10:
            Wa = pad_weyl_to_n(Lambda2(6), su_m_kahler_weyl(Lambda2(6), 3), n)[1]
            Wb = fox_on_block(L2, list(range(n - 4, n)), Qfun)
            da, db = (delta2_and_grad(Wa, alt_idx)[0], delta2_and_grad(Wb, alt_idx)[0])
            for s in (0.4, 0.6, 0.8):
                Wmix = s * Wa + np.sqrt(1 - s * s) * Wb
                dmix = delta2_and_grad(Wmix / norm(Wmix), alt_idx)[0]
                print(f"        mix s={s:.1f}: delta^2={dmix:.9f}  vs convex combination "
                      f"{s*s*da + (1-s*s)*db:.9f}  (blocks {da:.6f}, {db:.6f})")

    # (g) the su(m) Kaehler family: closed forms, and Fox as its m=2 member
    print(f"    (g) su(m) Kaehler family (built at its own n=2m; delta^2 and theta are "
          f"padding-invariant):")
    print(f"        {'m':>3s} {'n=2m':>5s} {'theta':>12s} {'pred':>12s} {'delta^2':>12s} "
          f"{'pred':>12s} {'resid':>9s} {'C7 margin at n=' + str(n):>20s}")
    for mm in range(2, 7):
        c2 = light_ctx(2 * mm)
        Wk = su_m_kahler_weyl(c2["L2"], mm)
        Wk, Qk, th = orient_theta_positive(Wk, c2["Qfun"])
        rel = norm(Qk - th * Wk) / (norm(Qk) + 1e-300)
        dk = delta2_and_grad(Wk, c2["alt_idx"])[0]
        t0 = np.sqrt(2.0 * (n - 1) * (n - 2)) / n
        margin = t0 + 9.0 * (SQRT32 - t0) * dk - th
        print(f"        {mm:>3d} {2*mm:>5d} {th:>12.8f} {su_m_theta(mm):>12.8f} "
              f"{dk:>12.8f} {su_m_delta2(mm):>12.8f} {rel:>9.1e} {margin:>20.6f}")
    print(f"        m=2 is Fox's S^4(alpha) itself (su(2) = Lambda^2_+ R^4); delta^2(m) "
          f"decreases in m,\n        so the family's defect is maximized exactly at the "
          f"champion, and the C7 candidate\n        P <= theta_0 + kappa_n*delta^2 survives "
          f"every member with the margins above.")


# =====================================================================
# batteries
# =====================================================================
def full_battery(n, unc_seeds=16, hunt_random=6, census_starts=30, iters=300,
                 hunt_iters=250, uncon_rounds=3, theta0_seeds=8, frontier_seeds=3,
                 th_targets=(0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.7, 0.85, 1.0, 1.15)):
    t0 = time.time()
    ctx = setup(n)
    part0_validate({n: ctx})
    cat = part1_catalogue(n, ctx)
    unc, unc_x = part2_unconstrained(n, ctx, n_seeds=unc_seeds, iters=iters,
                                     rounds=uncon_rounds)
    bia = part2b_bianchi(n, ctx["alt_idx"], ctx["N"], iters=iters)
    rows = part3_hunt(n, ctx, n_random=hunt_random, iters=hunt_iters, uncon_seeds=unc_x)
    frontier_max, frontier_rows = part3c_theta_frontier(
        n, ctx, th_targets=th_targets, n_seeds=frontier_seeds,
        rounds=2 if n < 12 else 1, iters=200 if n < 12 else 120)
    viol = next((r[3] for r in frontier_rows if r[0] > D0_EXACT + 1e-6), None)
    th0 = part3b_theta_zero(n, ctx, n_seeds=theta0_seeds,
                            rounds=2 if n < 12 else 1, iters=250 if n < 12 else 150)
    found, near_zero = part4_census(n, ctx, n_starts=census_starts)
    part5_analytic(n, ctx)
    crit_max = max([r[0] for r in rows if r[1] < 1e-6]
                   + [d for _, d, _ in found] + [d for _, d, _ in near_zero]
                   + [cat, frontier_max], default=0.0)
    print()
    print("=" * 78)
    print(f"VERDICT at n={n}   [{time.time()-t0:.0f}s]")
    print("=" * 78)
    print(f"  max delta^2 at critical points with THETA > 0:             {crit_max:.9f}")
    print(f"  max delta^2 on the THETA = 0 stratum {{Q(W)=0}}:             {th0:.9f}")
    print(f"  max delta^2 UNCONSTRAINED over the Weyl sphere:            {unc:.9f}")
    print(f"  max delta^2 UNCONSTRAINED over {{Alt(R)=0}}:                 {bia:.9f}")
    print(f"  conjectured ceiling 1/9 =                                  {D0_EXACT:.9f}")
    print(f"  CONJECTURE delta^2 <= 1/9 at theta>0 critical points: "
          f"{'HELD (nothing found above it)' if crit_max <= D0_EXACT + 1e-6 else 'REFUTED'}"
          f"{'' if crit_max <= D0_EXACT + 1e-6 else f' by {crit_max-D0_EXACT:+.6f}'}")
    print(f"  criticality still constrains the defect: the unconstrained maximum is "
          f"{unc:.6f},\n    a further {unc-crit_max:+.6f} above the critical maximum")
    return dict(n=n, crit=crit_max, unc=unc, bianchi=bia, theta0=th0, viol=viol)


def main():
    t_start = time.time()
    print("=" * 78)
    print("DEFECT-CEILING HUNT: is delta^2 = ||Alt(W_-)||^2 <= 1/9 at critical points?")
    print(f"  1/9 = {D0_EXACT:.10f}   (Fox S^4(alpha) value; QK HP^2 is 0.031746)")
    print("=" * 78)
    out = []
    for n in (6, 8):
        print(f"\n{'#'*78}\n# n={n}\n{'#'*78}")
        out.append(full_battery(n))
    print(f"\n{'#'*78}\n# n=12 spot check (reduced seed counts)\n{'#'*78}")
    # n=12 is trimmed on measured cost, not on doubt: at D=1638 one polish loop
    # runs ~9s and the census's residual minimization from a random start does
    # not reach 1e-6 at all (0/10 in a 272s run), so its budget goes to PART 2/3.
    out.append(full_battery(12, unc_seeds=8, hunt_random=4, census_starts=3,
                            iters=200, hunt_iters=150, uncon_rounds=2, theta0_seeds=3,
                            frontier_seeds=2, th_targets=(0.15, 0.4, 0.7, 1.0)))
    part5h_n4_proof()
    part2c_dimension_sweep()

    print()
    print("=" * 78)
    print("SUMMARY")
    print("=" * 78)
    print(f"  {'n':>4s} {'crit, theta>0':>16s} {'crit, theta=0':>16s} "
          f"{'unconstrained':>16s} {'over Alt(R)=0':>16s}")
    for r in out:
        print(f"  {r['n']:>4d} {r['crit']:>16.9f} {r['theta0']:>16.9f} "
              f"{r['unc']:>16.9f} {r['bianchi']:>16.9f}")
    worst = max(r["crit"] for r in out)
    # nan means the theta=0 solver did not reach ||Q|| < 1e-7 at that n (it does
    # not at n=12, where the same point is reached only to 6e-7); drop those.
    worst0 = max([r["theta0"] for r in out if not np.isnan(r["theta0"])], default=float("nan"))
    print(f"\n  VERDICT: delta^2 <= 1/9 at critical points with theta > 0 is "
          f"{'HELD in every search here' if worst <= D0_EXACT + 1e-6 else 'REFUTED'}"
          f" -- worst = {worst:.9f} vs 1/9 = {D0_EXACT:.9f}")
    print(f"  The refutation is PART 3c's theta-pinned point at n=8: "
          f"W = a*Pi_4 - b*Pi_6 with a = 3/(2 sqrt15),\n  b = 1/sqrt15, exactly critical "
          f"with theta = sqrt(3/20) = 0.3872983 and delta^2 = 3/25 = 0.12.")
    print(f"  The theta=0 stratum {{Q(W)=0}} goes further, to {worst0:.9f} = 1/8 at n>=8, "
          f"so no\n  orientation clause rescues the statement either.")
    print(f"  What survives: 1/9 is the ceiling for the FAMILIES the program cares about "
          f"(all\n  named competitors, the Fox plateau, the su(m) Kaehler family) and for "
          f"the high-theta\n  part of the critical set -- both violators sit at low theta, "
          f"0.387 and 0. And\n  criticality does still constrain the defect: the "
          f"unconstrained maxima in the third\n  column are higher again and grow with n, "
          f"at points whose idempotency residual is\n  of order 1.")
    viol = next((r["viol"] for r in out if r["viol"] is not None), None)
    if viol is not None:
        print(f"\n  The violator zero-pads, so the n=12 row's {D0_EXACT:.6f} reflects search "
              f"coverage at\n  D=1638, not a ceiling -- padding the n=8 point upward:")
        L2_8 = Lambda2(8)
        for n in (12, 14, 16):
            c2 = light_ctx(n)
            Wp = pad_weyl_to_n(L2_8, viol, n)[1]
            Q = c2["Qfun"](Wp)
            th = frob(Wp, Q)
            print(f"    n={n}: theta={th:.9f}  delta^2={delta2_and_grad(Wp, c2['alt_idx'])[0]:.9f}"
                  f"  residual={norm(Q - th * Wp):.1e} absolute, "
                  f"{norm(Q - th * Wp)/norm(Q):.1e} relative")
    print(f"\ntotal runtime: {time.time()-t_start:.0f}s")


if __name__ == "__main__":
    if len(sys.argv) > 1:
        full_battery(int(sys.argv[1]))
    else:
        main()
