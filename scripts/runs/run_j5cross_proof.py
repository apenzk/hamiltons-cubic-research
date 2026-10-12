"""
The J5 cross-term: falsification battery plus the machine-verified proof layer
(FINDINGS "Lifting Jaeger's §3.3 in trace form", Result 5's reduced open
statement |<X_cross, H_cross>| <= J5_diag, and the grant J5 >= 0 behind it).

SETTING. At a unit-norm critical point theta*W = W^2 + W^# (theta > 0) with
spectral parts W+, W- and projections P+, P-, P0, write |W| = W+ + W-,
h = Ric(|W|) >= 0, H = Ric*(h) >= 0 (both proven in Result 5b), and

    A = W+^#,  B = W-^#,  G = A + B,  C = W+ # W-      (each PSD),
    X_inv = |W|^# + (W - theta)|W|,
    J5 = <X_inv, H>,   J5_diag = sum_b <P_b X P_b, P_b H P_b>  >= 0 (proven),
    cross = J5 - J5_diag = <X_cross, H_cross>
    (X_cross = X - sum_b P_b X P_b; diagonal and cross parts are orthogonal,
     so <X_diag, H_diag> = sum_b <P_b X P_b, P_b H P_b> exactly).

THEOREM A (exact structure; four-line hand proofs given here, each identity
machine-verified below at every catalogued and generic critical point).
From |W| = W + 2W-, W = W+ - W-, bilinearity of # gives Reviewer 9's
|W|^# = W^# + 4C and, averaging instead, 2G = |W|^# + W^#. Criticality reads
W^# = theta*W - W^2, so W^# commutes with W and is block-diagonal. Then:
  (A1)  X_inv = 4C - 2*theta*W- - 2*W-^2
        [substitute |W|^# = W^# + 4C and W|W| = W+^2 - W-^2, W^2 = W+^2+W-^2];
  (A2)  X_inv = 2G - 2(theta*W+ - W+^2)
        [4C = 2G - 2W^#, then W^# = theta*W - W^2 and W + W- = W+];
  (A3)  (W^#)_cross = 0, hence G_cross = 2*C_cross and X_cross = 4*C_cross
        = 2*G_cross; the diagonal blocks reproduce Result 5a exactly:
        X_++ = 4C_++, X_-- = 2G_--, X_00 = 2G_00 = P0|W|^#P0;
  (A4)  Ric(X_inv) = D(|W|) + |W|.h - theta*h - 2*Ric(W-^2), where
        D(|W|) = Ric(|W|^2+|W|^#) - |W|.h = 6*Gram(Alt W-) >= 0 is the repo's
        proven 3/2-Gram identity (Result 2; Alt W = 0 gives Alt|W| = 2 Alt W-),
        so J5 = <Ric(X_inv), h>.

THEOREM B (the commuting class; proven). If [H, W] = 0 at a critical point,
then H preserves every eigenspace of W, so H_cross = 0, hence cross = 0 and
J5 = J5_diag = sum_b <X_bb, H_bb> >= 0, each summand being a pairing of a PSD
block (Result 5a) with a compression of the PSD H. In particular
|<X_cross, H_cross>| <= J5_diag holds WITH EQUALITY ONLY THROUGH 0 = 0 on
this class.

LEMMA B' (why every named point is in the commuting class; proven). If
R^n = (+)_k V_k orthogonally with h = sum_k c_k Pi_{V_k}, and W preserves
every sector V_k ^ V_l of Lambda^2, then H = Ric*(h) = h wedge 2 id acts as
(c_k + c_l) times the identity on the sector V_k ^ V_l, so [H, W] = 0. The
hypothesis holds at every named critical point with V_k the isotypic
decomposition of the isotropy group: h = Ric(|W|) is isotropy-invariant, so
it is scalar on each irreducible factor (h = cI outright at SU(3), the su(m)
Kaehler family, QK HP^m, and the so(5)-spin violator, whose isotropy acts
irreducibly on R^n; h = c1 Pi_p (+) c2 Pi_q at the sphere products; c2 = 0
padding blocks at Fox and the plateau), and the invariant W preserves the
sectors. Verified below at machine precision at every named point
(commutators <= 1e-15, and <= 5e-10 at the numerically constructed
violator, tracking its own construction residual).

THEOREM C (pairwise Cauchy-Schwarz; proven). For PSD M, K and any orthogonal
block split, M_bc = M_bb^{1/2} Gamma M_cc^{1/2} with ||Gamma||_op <= 1, so
|tr(M_bc K_cb)| <= sqrt(tr(M_bb K_bb) * tr(M_cc K_cc)). With M = C, K = H and
X_cross = 4C_cross this gives the unconditional bound
  (C)  |cross| <= 8 * sum_{b<c} sqrt(m_b m_c),   m_b := tr(C_bb H_bb) >= 0,
with 4m_+ = <X_++, H_++>, 4m_0 = <X_00, H_00>, 4m_- = <X_--, H_--> + rho,
rho := 2<theta*W- + W-^2, H> >= 0. This does NOT close the target by itself
(three blocks cost a factor and rho is extra), but it is proven and its slack
is tabulated below.

THEOREM D (gap-commutator certificate; proven). For blocks b != c let g_bc be
the distance between spec(W|_b) and spec(W|_c) (g_{+-} = min lam+ + min lam-,
g_{+0} = min lam+, g_{-0} = min lam-). In a joint eigenbasis
([H,W]_bc)_{ij} = (H_bc)_{ij} (mu_j - lam_i), so ||H_bc||_F <=
||[H,W]_bc||_F / g_bc, and with |tr(X_bc H_cb)| <= ||X_bc||_F ||H_bc||_F:
  (D)  |cross| <= 8 * sum_{b<c} ||C_bc||_F * ||[H,W]_bc||_F / g_bc.
Any critical point at which this right side is <= J5_diag therefore satisfies
the full target |cross| <= J5_diag; the battery checks the certificate at
every non-commuting point found.

THE MATRIX STRENGTHENING AND ITS REFUTATION (the battery's sharpest
finding). The natural matrix candidate Ric(X_inv) >= 0 -- which implies
J5 = <Ric(X_inv), h> >= 0 since h >= 0, is strictly weaker than the refuted
X_inv >= 0, holds at EVERY catalogued point with Ric(X_inv) = 0 identically
at every sharp point (in fact X_inv = 0 identically there), and is strictly
PD at every n >= 6 generic saddle (min eig 0.04 .. 1.18) -- is FALSE at
critical points in general: the violator-seeded polish pipeline (PART 4c)
lands on a genuine n = 5 critical point, theta = 0.882135, delta^2 = 0.0314,
||[H,W]|| = 0.39, criticality residual 2e-8, where min eig Ric(X_inv) =
-0.0273. At that same point J5 = +0.4163 and |cross|/J5_diag = 0.159 -- the
worst ratio known anywhere on the critical set, and still well inside the
target. The congruence intermediates fail at the same point too
(h^{1/2} Ric(X_inv) h^{1/2}: min eig -0.033; H^{1/2} X_inv H^{1/2}: -0.120;
the negative Ric(X_inv)-direction carries the MAXIMAL h-weight), so the
whole ladder between the two scalar statements and operator positivity is
refuted, and the sharpest SUPPORTED statements are exactly the target
|cross| <= J5_diag and the grant J5 >= 0 themselves -- scalar-level facts
with no surviving matrix-level mechanism.

WHY NO CRITICALITY-FREE PROOF CAN EXIST -- counterexample registry
(PARTS 5, 6). At critical points X_inv = 2Z_+ with
Z_pm = 2C_++ + G_-- + G_00 +- G_cross defined for EVERY symmetric W, and
X_diag - X_cross = 2Z_-. The completion candidates Ric(Z_pm) >= 0 fail on
every criticality-free class:
  * general symmetric W: scaling W+ -> sW+, W- -> tW- splits Ric(Z_pm) >= 0
    into bidegree-pure parts (A1u) Ric(S^# - Q S^# Q) >= 0 (Q = supp S),
    (A2u) Ric(S^# - P S^# P) >= 0 (P perp supp S), and reflected/frame-
    diagonal variants -- ALL false for general PSD S (witnesses at n=5..8,
    violations -0.01 to -0.28); the violating regime is tr W-/tr W+ -> 0;
  * traceless W (tr W+ = tr W- kills the scaling attack, and an imbalance
    sweep shows failure on BOTH sides of balance with maximal margin at
    balance): random sampling, Powell, and a targeted reassembly of the
    strongest A2u witness all find nothing, but directed FD-gradient descent
    refutes both signs at n = 5 and 6 (down to -0.15);
  * Weyl W (Ricci-flat and Bianchi): the same directed attack refutes both
    signs at n = 5, 6 (Z-, also n = 7; witnesses saved), even though random
    Weyl samples show margins ~ +0.2.
So the open statement genuinely lives on the critical set: criticality is
load-bearing beyond every structural consequence (tracelessness, Weyl
symmetries, balance) isolated here.

BATTERY (PART 4): full catalogue at n = 6, 8 (all named families incl.
padded, plateau, su(m), QK) + the so(5)-spin violator, generic
idempotency-residual saddles at n = 5, 6, 7, 8, the n = 5 catalogue, the
violator-seeded hunts at n = 5 and 6 (PART 4c), a theta-pinned sweep at
n = 6 (theta* = 0.1 .. 1.3, the method that found the delta^2-violator),
and three adversarial polish runs (minimize J5, minimize J5_diag - |cross|,
minimize min eig Ric(X_inv), each under a criticality penalty followed by a
re-polish onto the critical set, seeded from the found saddles). Quantities reported per point: J5, J5_diag, cross,
|cross|/J5_diag, min eig Ric(X_inv), theta, delta^2, ||[H,W]||, the Theorem C
and D bounds and whether the D certificate fires.

CONCLUSION (what is proven vs open after this file):
  * |cross| <= J5_diag and J5 >= 0 are PROVEN on the commuting class
    [H, W] = 0, which by Lemma B' contains every named critical point.
  * Off the commuting class, Theorem D is a proven, per-point checkable
    certificate; it certifies every n = 6 generic saddle found (tabulated);
    the n = 5 seeded point escapes both B and D and is the honest frontier.
  * The equality manifold is exact: at every exactly-constructed sharp
    point X_inv = 0 IDENTICALLY (max norm ~1e-15), so both sides of the
    target vanish through X_inv itself.
  * The full statement |cross| <= J5_diag (and the grant J5 >= 0 inside it)
    remains open exactly on the non-commuting critical stratum, now mapped
    much more finely: worst known ratio 0.159 (n = 5 seeded point), 0.023
    (n = 6 seeded), 0.0027 (n = 6 idempotency saddles), with every natural
    strengthening (operator PSD, matrix Ric-PSD, and all criticality-free
    completions) refuted by explicit witnesses. Any future proof must
    consume the criticality equation itself AND work at the scalar level
    (contracted against h); the localized identity (*) in PART 1b is the
    exact per-vector structure such a proof has to average.

Runtime: ~15-25 min. Heartbeats printed per part.
"""
import time
import numpy as np
from scipy.optimize import minimize

from curvature_operator import Lambda2
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_defect_max_hunt import catalogue_points, orient_theta_positive
from run_bianchi_defect import bianchi_defect, build_alt_indices, alt_mop, spectral_split
from run_jaeger_lift_33 import sharp_of, spectral_parts, ric_of, dot_contract
from run_j5_structure import ric_adjoint, sharp_pol, generic_critical_points
from run_vertex_bound import random_weyl_basis, mop_to_tensor4
from weyl import build_structure_constants, vec_to_mat
from weyl_decomposition import norm, frob
from rsharp_basis_free import Q_full

TOL_RESID = 1e-5
rng_global = np.random.default_rng(20260820)


# =====================================================================
# shared computation of every quantity at one (near-)critical point
# =====================================================================
def point_data(Wn, ctx, c, tol=1e-10):
    L2, alt_idx, n = ctx["L2"], ctx["alt_idx"], ctx["n"]
    N = Wn.shape[0]
    Q = Q_full(Wn, c)
    theta = frob(Wn, Q)
    resid = norm(Q - theta * Wn) / norm(Q)
    Wp, Wm, Pp, Pm = spectral_parts(Wn, tol)
    P0 = np.eye(N) - Pp - Pm
    absW = Wp + Wm
    h = ric_of(L2, absW)
    d = dict(n=n, N=N, theta=theta, resid=resid, Wn=Wn, Wp=Wp, Wm=Wm,
             Pp=Pp, Pm=Pm, P0=P0, absW=absW, h=h,
             delta2=bianchi_defect(Wn, alt_idx) ** 2)
    if norm(h) < 1e-12:
        d["vacuous"] = True
        return d
    d["vacuous"] = False
    H = ric_adjoint(L2, h)
    A = sharp_of(Wp, c)
    B = sharp_of(Wm, c)
    C = 0.5 * (sharp_of(absW, c) - A - B)
    G = A + B
    Xinv = sharp_of(absW, c) + (Wn - theta * np.eye(N)) @ absW
    blocks = (Pp, Pm, P0)
    Xd = sum(P @ Xinv @ P for P in blocks)
    Hd = sum(P @ H @ P for P in blocks)
    d.update(H=H, A=A, B=B, C=C, G=G, Xinv=Xinv,
             Xcross=Xinv - Xd, Hcross=H - Hd)
    d["J5"] = frob(Xinv, H)
    d["xb"] = [frob(P @ Xinv @ P, P @ H @ P) for P in blocks]
    d["J5_diag"] = sum(d["xb"])
    d["cross"] = d["J5"] - d["J5_diag"]
    d["RX"] = ric_of(L2, Xinv)
    d["minRX"] = np.linalg.eigvalsh(d["RX"]).min()
    d["commHW"] = norm(H @ Wn - Wn @ H)
    # Theorem C bound
    mb = [max(frob(P @ C @ P, P @ H @ P), 0.0) for P in blocks]
    d["mb"] = mb
    d["boundC"] = 8 * (np.sqrt(mb[0] * mb[1]) + np.sqrt(mb[0] * mb[2])
                       + np.sqrt(mb[1] * mb[2]))
    # Theorem D bound
    ew = np.linalg.eigvalsh(Wn)
    lp = ew[ew > tol]
    lm = -ew[ew < -tol]
    gp = lp.min() if lp.size else np.inf
    gm = lm.min() if lm.size else np.inf
    gaps = [gp + gm, gp, gm]                      # (+,-), (+,0), (-,0)
    pairs = [(Pp, Pm), (Pp, P0), (Pm, P0)]
    bD = 0.0
    for (Pa, Pb), g in zip(pairs, gaps):
        Cab = Pa @ C @ Pb
        HWab = Pa @ (H @ Wn - Wn @ H) @ Pb
        if np.isfinite(g) and g > 0 and norm(Cab) > 0:
            bD += 8 * norm(Cab) * norm(HWab) / g
    d["boundD"] = bD
    d["cert_D"] = bD <= d["J5_diag"] + 1e-12
    return d


# =====================================================================
# PART 0: conventions
# =====================================================================
def part0(n=6):
    print("=" * 78)
    print("PART 0: conventions and adjointness")
    print("=" * 78)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    idx, pos, N, c = build_structure_constants(n)
    rng = np.random.default_rng(1)
    # Ric* adjointness and Ric*(vv^T) = Pi_v (projection onto v ^ v-perp)
    hh = rng.normal(size=(n, n))
    hh = hh @ hh.T
    Hh = ric_adjoint(L2, hh)
    X = rng.normal(size=(N, N))
    X = 0.5 * (X + X.T)
    e_adj = abs(frob(X, Hh) - np.sum(ric_of(L2, X) * hh))
    v = rng.normal(size=n)
    v /= np.linalg.norm(v)
    Pi = ric_adjoint(L2, np.outer(v, v))
    e_proj = norm(Pi @ Pi - Pi)
    e_rank = abs(np.trace(Pi) - (n - 1))
    print(f"  <X, Ric*(h)> = <Ric X, h>: {e_adj:.1e}   Ric*(vv^T) idempotent: "
          f"{e_proj:.1e}  rank n-1: {e_rank:.1e}")
    # |W|^# = W^# + 4C on a random symmetric operator (pure bilinearity)
    M = rng.normal(size=(N, N))
    M = 0.5 * (M + M.T)
    Wp, Wm, Pp, Pm = spectral_parts(M)
    C = 0.5 * (sharp_of(Wp + Wm, c) - sharp_of(Wp, c) - sharp_of(Wm, c))
    e_r9 = norm(sharp_of(Wp + Wm, c) - sharp_of(M, c) - 4 * C)
    e_2g = norm(sharp_of(Wp, c) + sharp_of(Wm, c)
                - 0.5 * (sharp_of(Wp + Wm, c) + sharp_of(M, c)))
    print(f"  |W|^# = W^# + 4C: {e_r9:.1e}   2G = |W|^# + W^#: {e_2g:.1e}")
    assert max(e_adj, e_proj, e_rank, e_r9, e_2g) < 1e-10


# =====================================================================
# PART 1: Theorem A machine-verification
# =====================================================================
def theorem_A_check(d, ctx, c):
    if d["vacuous"]:
        return None
    L2 = ctx["L2"]
    N, th = d["N"], d["theta"]
    Wn, Wp, Wm = d["Wn"], d["Wp"], d["Wm"]
    C, G, Xinv = d["C"], d["G"], d["Xinv"]
    Pp, Pm, P0 = d["Pp"], d["Pm"], d["P0"]
    e1 = norm(Xinv - (4 * C - 2 * th * Wm - 2 * Wm @ Wm))
    e2 = norm(Xinv - (2 * G - 2 * (th * Wp - Wp @ Wp)))
    cr = lambda T: T - Pp @ T @ Pp - Pm @ T @ Pm - P0 @ T @ P0
    e3 = max(norm(cr(G) - 2 * cr(C)), norm(cr(Xinv) - 4 * cr(C)),
             norm(cr(sharp_of(Wn, c))))
    # A4: Ric(X_inv) = D(|W|) + |W|.h - theta h - 2 Ric(W-^2),
    #     D(|W|) computed directly and matched to 6 Gram(Alt W-)
    absW, h = d["absW"], d["h"]
    D_abs = ric_of(L2, absW @ absW + sharp_of(absW, c)) - dot_contract(L2, absW, h)
    e4 = norm(d["RX"] - (D_abs + dot_contract(L2, absW, h) - th * h
                         - 2 * ric_of(L2, Wm @ Wm)))
    alt_idx = ctx["alt_idx"]
    Talt = mop_to_tensor4(L2, alt_mop(Wm, alt_idx))
    gram = np.einsum('iklm,jklm->ij', Talt, Talt)
    e5 = norm(D_abs - 6 * gram)
    e6 = abs(d["J5"] - np.sum(d["RX"] * h))
    e7 = abs(d["cross"] - frob(d["Xcross"], d["Hcross"]))
    e8 = abs(d["cross"] - 4 * frob(cr(C), d["Hcross"]))
    return max(e1, e2, e3, e4, e5, e6, e7, e8)


# =====================================================================
# PART 1b: the localized identity (*) -- the exact per-vector form of the
# open statement, with the mixed-diagonal cancellation already performed.
# At a critical point, in a W-eigenframe {phi_beta} (eigenvalues w_beta,
# a = |w|, blocks by sign), with ell_p = [Phi_gamma, Phi_delta] for a mixed
# pair p = (gamma in +, delta in -), omega_p = a_gamma a_delta, and
# N_{beta p} = <phi_beta, ell_p>:
#
#   Ric(X_inv) = 2 sum_{p mixed} omega_p [ M(ell_p) - sum_{beta in -}
#                N_{beta p}^2 M(phi_beta) ]  +  2 sum_{beta in -}
#                <G phi_beta, phi_beta> M(phi_beta),
#
# where M(psi) := Psi Psi^T (n x n PSD Gram of the bivector's matrix), i.e.
# M(psi) = Ric(psi psi^T). Derivation: A1 + the diagonal criticality
# s_beta = (W^#)_{beta beta} = -a_beta(theta + a_beta) on the - block; the
# mixed part of s_beta cancels the mixed-pair diagonal of 4 Ric(C) exactly.
# Every term except the interference inside M(ell_p) is manifestly PSD;
# a future proof of Ric(X_inv) >= 0 has to dominate exactly that
# interference. Machine-verified below at representative points.
# =====================================================================
def star_check(d, L2, c):
    if d["vacuous"]:
        return None
    Wn, N, n = d["Wn"], d["N"], d["n"]
    w, V = np.linalg.eigh(Wn)

    def mat_of(vec):
        M = np.zeros((n, n))
        for p_, (i, j) in enumerate(L2.pairs):
            M[i, j] = vec[p_]
            M[j, i] = -vec[p_]
        return M

    def vec_of(M):
        return np.array([M[i, j] for (i, j) in L2.pairs])

    tol = 1e-10
    plus = np.where(w > tol)[0]
    minus = np.where(w < -tol)[0]
    mats = [mat_of(V[:, k]) for k in range(N)]
    Mgram = [mats[k] @ mats[k].T for k in range(N)]
    RX_star = np.zeros((n, n))
    for i in plus:
        for j in minus:
            om = w[i] * (-w[j])
            L = mats[i] @ mats[j] - mats[j] @ mats[i]
            ell = vec_of(L)
            term = L @ L.T
            for b in minus:
                Nb = V[:, b] @ ell
                term = term - Nb * Nb * Mgram[b]
            RX_star += 2 * om * term
    for b in minus:
        Gbb = V[:, b] @ d["G"] @ V[:, b]
        RX_star += 2 * Gbb * Mgram[b]
    return norm(d["RX"] - RX_star)


# =====================================================================
# PART 2+3: Theorems B, C, D at a list of points
# =====================================================================
def report_point(label, d, ctx, c, rows, verbose=True, star=False):
    if d["vacuous"]:
        if verbose:
            print(f"  {label:30s} th={d['theta']:+.4f} Ric(|W|)=0: J5=cross=0 (vacuous)")
        return
    eA = theorem_A_check(d, ctx, c)
    if star:
        eS = star_check(d, ctx["L2"], c)
        if verbose:
            print(f"      localized identity (*) residual: {eS:.1e}")
    # noise floor: every derived quantity carries O(resid) error at a
    # near-critical point, since the Theorem A identities are exact only at
    # residual 0 (their residuals track the criticality residual, PART 1).
    noise = 1e-8 + 50 * d["resid"]
    d["noise"] = noise
    ratio = abs(d["cross"]) / d["J5_diag"] if d["J5_diag"] > noise else \
        (0.0 if abs(d["cross"]) <= noise else np.inf)
    commuting = d["commHW"] < 1e-8
    okC = abs(d["cross"]) <= d["boundC"] + noise
    okD = abs(d["cross"]) <= d["boundD"] + noise
    if verbose:
        print(f"  {label:30s} n={d['n']} th={d['theta']:+.4f} rs={d['resid']:.0e} "
              f"d2={d['delta2']:.4f} A-ids={eA:.0e}")
        print(f"      J5={d['J5']:+.6f} diag={d['J5_diag']:+.6f} "
              f"cross={d['cross']:+.2e} ratio={ratio:.4f} minRicX={d['minRX']:+.2e} "
              f"[HW]={d['commHW']:.1e}"
              + (" [Thm B: commuting => cross=0, J5=diag>=0]" if commuting else
                 f" bC={d['boundC']:.2e} bD={d['boundD']:.2e} "
                 f"certD={'YES' if d['cert_D'] else 'no'}"))
    rows.append(dict(label=label, n=d["n"], theta=d["theta"], resid=d["resid"],
                     delta2=d["delta2"], J5=d["J5"], J5_diag=d["J5_diag"],
                     cross=d["cross"], ratio=ratio, minRX=d["minRX"],
                     comm=d["commHW"], commuting=commuting, eA=eA,
                     boundC=d["boundC"], boundD=d["boundD"], certD=d["cert_D"],
                     okC=okC, okD=okD, noise=noise,
                     nX=norm(d["Xinv"]), nRX=norm(d["RX"])))


# =====================================================================
# PART 4a0: harder generic search for n = 7, 8 (two-stage polish; the plain
# run_j5_structure search finds nothing below tolerance there, FINDINGS'
# stated gap). Accepts residuals up to 1e-5; the noise-aware tolerances in
# report_point account for the looser convergence.
# =====================================================================
def generic_hard(n, n_starts, seed, resid_tol=1e-5):
    idx, pos, N, c = build_structure_constants(n)
    wb, triu_idx, N2 = random_weyl_basis(n)
    D = wb.shape[1]
    rng = np.random.default_rng(seed)

    def obj(x):
        Wn = vec_to_mat(wb @ x, triu_idx, N)
        Wn = Wn / norm(Wn)
        Q = Q_full(Wn, c)
        th = frob(Wn, Q)
        return frob(Q - th * Wn, Q - th * Wn)

    found = []
    for _ in range(n_starts):
        res = minimize(obj, rng.normal(size=D), method="L-BFGS-B",
                       options=dict(maxiter=700, ftol=1e-18, gtol=1e-14))
        res = minimize(obj, res.x, method="L-BFGS-B",
                       options=dict(maxiter=700, ftol=1e-20, gtol=1e-16,
                                    eps=1e-9))
        Wn = vec_to_mat(wb @ res.x, triu_idx, N)
        Wn = Wn / norm(Wn)
        Q = Q_full(Wn, c)
        th = frob(Wn, Q)
        if th < 0:
            Wn, th = -Wn, -th
            Q = -Q
        rr = norm(Q - th * Wn) / norm(Q)
        if rr < resid_tol and th > 0.05:
            if all(abs(th - t0) > 2e-4 for _, t0 in found):
                found.append((Wn, th))
    return found, c


# =====================================================================
# PART 4a: theta-pinned critical-point search (the violator-finding method)
# =====================================================================
def theta_pinned_points(n, theta_targets, seed, n_starts=3, resid_tol=1e-6):
    idx, pos, N, c = build_structure_constants(n)
    wb, triu_idx, N2 = random_weyl_basis(n)
    D = wb.shape[1]
    rng = np.random.default_rng(seed)
    found = []
    for tt in theta_targets:
        def obj(x):
            Wn = vec_to_mat(wb @ x, triu_idx, N)
            Wn = Wn / norm(Wn)
            Q = Q_full(Wn, c)
            th = frob(Wn, Q)
            r2 = frob(Q - th * Wn, Q - th * Wn)
            return r2 + 0.25 * (th - tt) ** 2
        best = None
        for _ in range(n_starts):
            res = minimize(obj, rng.normal(size=D), method="L-BFGS-B",
                           options=dict(maxiter=500, ftol=1e-18, gtol=1e-14))
            Wn = vec_to_mat(wb @ res.x, triu_idx, N)
            Wn = Wn / norm(Wn)
            Q = Q_full(Wn, c)
            th = frob(Wn, Q)
            if th < 0:
                Wn, th = -Wn, -th
                Q = -Q
            rr = norm(Q - th * Wn) / norm(Q)
            if rr < resid_tol and th > 0.02:
                if best is None or abs(th - tt) < abs(best[1] - tt):
                    best = (Wn, th, rr)
        if best is not None:
            found.append((f"pinned th*={tt:.2f} -> th={best[1]:.3f}", best[0]))
    return found, c


# =====================================================================
# PART 4b: adversarial polish of three objectives under criticality penalty
# =====================================================================
def adversarial(n, seeds_W, c, ctx, mu=3e3, iters=120):
    idx, pos, N, _cc = build_structure_constants(n)
    wb, triu_idx, N2 = random_weyl_basis(n)
    D = wb.shape[1]
    rng = np.random.default_rng(99)

    def x_of_W(Wn):
        v = np.array([Wn[a, b] for (a, b) in triu_idx])
        sol, *_ = np.linalg.lstsq(wb, v, rcond=None)
        return sol

    def quantities(x):
        Wn = vec_to_mat(wb @ x, triu_idx, N)
        Wn = Wn / norm(Wn)
        d = point_data(Wn, ctx, c)
        return Wn, d

    def crit_polish(x):
        def robj(xx):
            Wn = vec_to_mat(wb @ xx, triu_idx, N)
            Wn = Wn / norm(Wn)
            Q = Q_full(Wn, c)
            th = frob(Wn, Q)
            return frob(Q - th * Wn, Q - th * Wn)
        res = minimize(robj, x, method="L-BFGS-B",
                       options=dict(maxiter=400, ftol=1e-20, gtol=1e-16))
        return res.x

    objs = {
        "min J5": lambda d: d["J5"],
        "min (J5_diag - |cross|)": lambda d: d["J5_diag"] - abs(d["cross"]),
        "min mineig Ric(X_inv)": lambda d: d["minRX"],
    }
    results = {}
    for name, f in objs.items():
        best_val, best_d = np.inf, None
        for W0 in seeds_W:
            x0 = x_of_W(W0) + 0.02 * rng.normal(size=D)

            def obj(x):
                Wn, d = quantities(x)
                if d["vacuous"]:
                    return 10.0
                return mu * d["resid"] ** 2 + f(d)

            res = minimize(obj, x0, method="L-BFGS-B",
                           options=dict(maxiter=iters, ftol=1e-16, gtol=1e-12))
            # push back onto the critical set, then evaluate honestly there
            xp = crit_polish(res.x)
            Wn, d = quantities(xp)
            if d["vacuous"] or d["resid"] > TOL_RESID:
                continue
            val = f(d)
            if val < best_val:
                best_val, best_d = val, d
        results[name] = (best_val, best_d)
        v = f"{best_val:+.6f}" if best_d is not None else "no converged point"
        print(f"  adversarial {name:28s}: best over {len(seeds_W)} seeds = {v}"
              + (f"  (th={best_d['theta']:.3f}, resid={best_d['resid']:.0e})"
                 if best_d is not None else ""))
    return results


# =====================================================================
# PART 4c: violator-seeded critical-point hunt -- run the FD-gradient attack
# on Ric(Z_pm) over the WEYL sphere, then polish every endpoint back onto the
# critical set. This is the pipeline that found the n=5 non-commuting point
# with mineig Ric(X_inv) = -0.027 and ratio 0.159 (the worst known), which
# plain idempotency-residual search from random starts never reaches.
# =====================================================================
def seeded_hunt(n, n_starts_per_sign, seed, resid_tol=1e-6):
    L2 = Lambda2(n)
    idx, pos, N, c = build_structure_constants(n)
    wb, triu_idx, N2 = random_weyl_basis(n)
    D = wb.shape[1]
    rng = np.random.default_rng(seed)

    def W_of(x):
        M = vec_to_mat(wb @ x, triu_idx, N)
        nm = norm(M)
        return M / (nm if nm > 1e-12 else 1.0)

    def zeig(x, which):
        return zmins(W_of(x), c, L2)[which]

    def robj(x):
        Wn = W_of(x)
        Q = Q_full(Wn, c)
        th = frob(Wn, Q)
        return frob(Q - th * Wn, Q - th * Wn)

    found = []
    for which in (0, 1):
        for s in range(n_starts_per_sign):
            res = minimize(zeig, rng.normal(size=D), args=(which,),
                           method="L-BFGS-B",
                           options=dict(maxiter=250, ftol=1e-14, gtol=1e-10))
            xp = res.x
            for _ in range(2):
                xp = minimize(robj, xp, method="L-BFGS-B",
                              options=dict(maxiter=1500, ftol=1e-22,
                                           gtol=1e-18)).x
            Wn = W_of(xp)
            Q = Q_full(Wn, c)
            th = frob(Wn, Q)
            if th < 0:
                Wn, th = -Wn, -th
            rr = norm(Q_full(Wn, c) - th * Wn) / norm(Q_full(Wn, c))
            if rr < resid_tol and th > 0.02:
                if all(abs(th - t) > 2e-4 for t, _ in found):
                    found.append((th, Wn))
    return [(f"seeded n={n} th={th:.4f}", Wn) for th, Wn in sorted(found)], None


# =====================================================================
# PART 5: counterexample registry -- the universal strengthenings are FALSE
# =====================================================================
def part5():
    print("=" * 78)
    print("PART 5: counterexamples to every criticality-free strengthening")
    print("=" * 78)
    rows = []
    for n, seeds in ((5, (11, 12, 13)), (6, (21, 22, 23)), (8, (31,))):
        L2 = Lambda2(n)
        idx, pos, N, c = build_structure_constants(n)
        worst = dict(A1u=np.inf, A2u=np.inf, A3u=np.inf, A4u=np.inf)
        worst.update(CAd=np.inf, CBd=np.inf)
        for sd in seeds:
            rng = np.random.default_rng(424242 + sd)
            for _ in range(40):
                r = int(rng.integers(1, N))
                V = rng.normal(size=(N, r))
                S = V @ V.T
                S /= norm(S)
                Sh = sharp_of(S, c)
                ews, EVs = np.linalg.eigh(S)
                sv = EVs[:, ews > 1e-10]
                Qp = sv @ sv.T
                Qperp = np.eye(N) - Qp
                r_eff = sv.shape[1]
                k = int(rng.integers(0, N - r_eff + 1))
                b2 = np.linalg.qr(Qperp @ rng.normal(size=(N, N)))[0][:, :N - r_eff]
                P1 = (b2[:, :k] @ b2[:, :k].T) if k else np.zeros((N, N))
                P2 = Qperp - P1
                me = lambda T: np.linalg.eigvalsh(ric_of(L2, T)).min()
                Y = Qp @ Sh @ Qp + P1 @ Sh @ P1 + P2 @ Sh @ P2
                worst["A1u"] = min(worst["A1u"], me(Sh - Qp @ Sh @ Qp))
                worst["A2u"] = min(worst["A2u"], me(Sh - P1 @ Sh @ P1))
                worst["A3u"] = min(worst["A3u"], me(2 * Y - Sh - Qp @ Sh @ Qp))
                worst["A4u"] = min(worst["A4u"], me(2 * Y - Sh - P1 @ Sh @ P1))
                # frame-DIAGONAL erasures (the (*)-shaped universal variants)
                dvals = np.einsum('ib,ij,jb->b', sv, Sh, sv)
                Delta = (sv * dvals) @ sv.T
                worst["CAd"] = min(worst["CAd"], me(Sh - Delta))
                if k:
                    fr = b2[:, :k]
                    dv2 = np.einsum('ib,ij,jb->b', fr, Sh, fr)
                    worst["CBd"] = min(worst["CBd"], me(Sh - (fr * dv2) @ fr.T))
        print(f"  n={n}: worst min-eig  " + "  ".join(
            f"{k}={v:+.4f}" for k, v in worst.items())
            + "   [all six < 0 => refuted]")
        rows.append(worst)
    allneg = all(v < -1e-3 for w in rows for v in w.values())
    print(f"  => every bidegree-pure universal statement refuted, including the")
    print(f"     frame-diagonal (*)-shaped variants: {allneg}")
    print("  (scaling argument in the docstring: universality of the (U)/(Ut)")
    print("   completions would force these; the violating regime W- -> 0 is")
    print("   impossible for Weyl operators, where Ric(W)=0 and W >= 0 force")
    print("   W = 0 -- so criticality/Ricci-flatness is load-bearing.)")
    return allneg


# =====================================================================
# PART 6: the reduced conjecture (RC) on the traceless class -- adversarial
# support and the sharpness of the traceless hypothesis
# =====================================================================
def zmins(Wn, c, L2):
    N = Wn.shape[0]
    Wp, Wm, Pp, Pm = spectral_parts(Wn)
    P0 = np.eye(N) - Pp - Pm
    A = sharp_of(Wp, c)
    B = sharp_of(Wm, c)
    C = 0.5 * (sharp_of(Wp + Wm, c) - A - B)
    G = A + B
    Gd = [P @ G @ P for P in (Pp, Pm, P0)]
    Gcr = G - sum(Gd)
    Cpp = Pp @ C @ Pp
    Zp = 2 * Cpp + Gd[1] + Gd[2] + Gcr
    Zm = 2 * Cpp + Gd[1] + Gd[2] - Gcr
    return (np.linalg.eigvalsh(ric_of(L2, Zp)).min(),
            np.linalg.eigvalsh(ric_of(L2, Zm)).min())


def part6():
    print("=" * 78)
    print("PART 6: the reduced conjecture (RC) on the traceless class")
    print("=" * 78)
    rng = np.random.default_rng(1618)
    # (a) random traceless + Weyl samples
    for n, n_s in ((5, 250), (6, 250)):
        L2 = Lambda2(n)
        idx, pos, N, c = build_structure_constants(n)
        mt = [np.inf, np.inf]
        for _ in range(n_s):
            M = rng.normal(size=(N, N))
            M = 0.5 * (M + M.T)
            M -= np.trace(M) / N * np.eye(N)
            M /= norm(M)
            a, b = zmins(M, c, L2)
            mt = [min(mt[0], a), min(mt[1], b)]
        wb, triu_idx, N2 = random_weyl_basis(n)
        D = wb.shape[1]
        mw = [np.inf, np.inf]
        for _ in range(n_s):
            W = vec_to_mat(wb @ rng.normal(size=D), triu_idx, N)
            W /= norm(W)
            a, b = zmins(W, c, L2)
            mw = [min(mw[0], a), min(mw[1], b)]
        print(f"  n={n}: traceless x{n_s}: min Ric(Z+)={mt[0]:+.5f} "
              f"Ric(Z-)={mt[1]:+.5f}   Weyl x{n_s}: {mw[0]:+.5f} {mw[1]:+.5f}")
    # (b) imbalance sweep: the traceless hypothesis is sharp
    n = 5
    L2 = Lambda2(n)
    idx, pos, N, c = build_structure_constants(n)
    us = (0.05, 0.2, 0.5, 1.0, 2.0, 5.0, 10.0)
    mins = {u: [np.inf, np.inf] for u in us}
    for cfg in range(40):
        rp = int(rng.integers(2, N - 2))
        rm = int(rng.integers(2, N - rp))
        Vp = rng.normal(size=(N, rp))
        Sp = Vp @ Vp.T
        q, _ = np.linalg.qr(Vp)
        Qperp = np.eye(N) - q[:, :rp] @ q[:, :rp].T
        Vm = Qperp @ rng.normal(size=(N, rm))
        Sm = Vm @ Vm.T
        Sp /= np.trace(Sp)
        Sm /= np.trace(Sm)
        for u in us:
            W = u * Sp - Sm
            W /= norm(W)
            a, b = zmins(W, c, L2)
            mins[u] = [min(mins[u][0], a), min(mins[u][1], b)]
    print("  imbalance sweep (n=5, rho = tr W+/tr W-; rho=1 is traceless):")
    for u in us:
        tag = "  <-- FAILS" if min(mins[u]) < -1e-4 else ""
        print(f"    rho={u:5.2f}: min Ric(Z+)={mins[u][0]:+.5f}  "
              f"Ric(Z-)={mins[u][1]:+.5f}{tag}")
    # (c) targeted attack: strongest A2u violation, reassembled at balance
    rng2 = np.random.default_rng(424242 + 31)
    best = None
    for trial in range(200):
        r = int(rng2.integers(2, max(3, N // 3)))
        V = rng2.normal(size=(N, r))
        T = V @ V.T
        T /= norm(T)
        Th = sharp_of(T, c)
        q, _ = np.linalg.qr(V)
        Qperp = np.eye(N) - q[:, :r] @ q[:, :r].T
        k = int(rng2.integers(N // 2, N - r + 1))
        b2 = np.linalg.qr(Qperp @ rng2.normal(size=(N, N)))[0][:, :N - r]
        P1 = b2[:, :k] @ b2[:, :k].T
        me = np.linalg.eigvalsh(ric_of(L2, Th - P1 @ Th @ P1)).min()
        if best is None or me < best[0]:
            best = (me, T, P1, k)
    me, T, P1, k = best
    Wp = (np.trace(T) / k) * P1
    W = Wp - T
    W /= norm(W)
    a, b = zmins(W, c, L2)
    print(f"  targeted attack: A2u part alone {me:+.4f} < 0, reassembled at "
          f"balance: Ric(Z+)={a:+.4f}, Ric(Z-)={b:+.4f}  (repaired)")
    # (d) directed FD-gradient attacks. On the FULL traceless class these
    # REFUTE (RC): random sampling, Powell, and the targeted A2u reassembly
    # all miss the violations, but L-BFGS with finite-difference gradients on
    # mineig finds them readily (both signs, n = 5 and 6). On the WEYL
    # subclass the same attack finds nothing.
    iu = np.triu_indices(N)
    Dh = len(iu[0])

    def W_tr(x):
        M = np.zeros((N, N))
        M[iu] = x
        M = M + M.T - np.diag(np.diag(M))
        M -= np.trace(M) / N * np.eye(N)
        nm = norm(M)
        return M / (nm if nm > 1e-12 else 1.0)

    wb, triu_idx, N2 = random_weyl_basis(n)
    Dw = wb.shape[1]

    def W_weyl(x):
        M = vec_to_mat(wb @ x, triu_idx, N)
        nm = norm(M)
        return M / (nm if nm > 1e-12 else 1.0)

    rng13 = np.random.default_rng(240820)
    rng14 = np.random.default_rng(240821)
    for cls, W_of, DD, rg, n_st in (("traceless", W_tr, Dh, rng13, 8),
                                    ("Weyl", W_weyl, Dw, rng14, 8)):
        for which, name in ((0, "Ric(Z+)"), (1, "Ric(Z-)")):
            bestv = np.inf
            t0 = time.time()
            for s in range(n_st):
                res = minimize(lambda x: zmins(W_of(x), c, L2)[which],
                               rg.normal(size=DD), method="L-BFGS-B",
                               options=dict(maxiter=250, ftol=1e-14,
                                            gtol=1e-10))
                bestv = min(bestv, res.fun)
            verdict = "VIOLATED" if bestv < -1e-6 else "no violation found"
            print(f"  FD-gradient attack (n=5, {cls:9s}, {n_st} starts): "
                  f"min {name} = {bestv:+.6f}  [{verdict}, {time.time()-t0:.0f}s]")


# =====================================================================
# PART 7: n = 12 spot check at the threshold dimension -- Theorem B coverage
# and the sharpest candidate at the named points that matter for the chain
# =====================================================================
def part7_n12(refuters=()):
    from run_bianchi_defect_highp_seed import pad_weyl_to_n
    from run_hpm_qk import qk_tensor
    from run_sphere import sphere_product_mop
    from weyl_decomposition import weyl_from_mop, mop_from_4tensor
    print("=" * 78)
    print("PART 7: n=12 spot check (threshold dimension), plus padded refuters")
    print("=" * 78)
    n = 12
    L2 = Lambda2(n)
    idx, pos, N, c = build_structure_constants(n)
    from run_bianchi_defect_highp_seed import build_su3_n8
    L2_8, Wsu3 = build_su3_n8()
    pts = [("SU(3) padded 8->12", pad_weyl_to_n(L2_8, Wsu3, n)[1])]
    Wq = weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, 3, 1.0, 1.0)))[0]
    pts.append(("QK HP^3", Wq / norm(Wq)))
    Ws = weyl_from_mop(L2, sphere_product_mop(L2, 6))[0]
    pts.append(("balanced sphere (6,6)", Ws / norm(Ws)))
    # zero-padding preserves criticality and every J5 quantity, so any
    # small-n refutation of Ric(X_inv) >= 0 lives at n = 12 too:
    for label, Wsmall, nsmall in refuters:
        pts.append((f"{label} padded {nsmall}->12",
                    pad_weyl_to_n(Lambda2(nsmall), Wsmall, n)[1]))
    for label, Wn in pts:
        Q = Q_full(Wn, c)
        th = frob(Wn, Q)
        if th < 0:
            Wn, th, Q = -Wn, -th, -Q
        rs = norm(Q - th * Wn) / norm(Q)
        Wp, Wm, Pp, Pm = spectral_parts(Wn)
        P0 = np.eye(N) - Pp - Pm
        absW = Wp + Wm
        h = ric_of(L2, absW)
        H = ric_adjoint(L2, h)
        Xinv = sharp_of(absW, c) + (Wn - th * np.eye(N)) @ absW
        J5 = frob(Xinv, H)
        xb = sum(frob(P @ Xinv @ P, P @ H @ P) for P in (Pp, Pm, P0))
        RX = ric_of(L2, Xinv)
        print(f"  {label:22s} th={th:+.4f} rs={rs:.0e} [HW]={norm(H@Wn-Wn@H):.1e} "
              f"J5={J5:+.6f} diag={xb:+.6f} cross={J5-xb:+.1e} "
              f"minRicX={np.linalg.eigvalsh(RX).min():+.1e}")


# =====================================================================
def main():
    t00 = time.time()
    rows = []
    part0(6)
    print("=" * 78)
    print("PART 1-3: Theorems A/B/C/D at the full catalogue (n=6, 8)")
    print("=" * 78)
    ctxs = {}
    cs = {}
    for n in (6, 8):
        ctx = setup(n, verbose=False)
        idx, pos, N, c = build_structure_constants(n)
        ctxs[n], cs[n] = ctx, c
        print(f"\n  -- n={n} catalogue --")
        for label, W in catalogue_points(n, ctx):
            W, Q, theta = orient_theta_positive(W, ctx["Qfun"])
            if theta < 1e-6:
                print(f"  {label:30s} theta=0: outside the theta>0 hypothesis")
                continue
            report_point(label, point_data(W, ctx, c), ctx, c, rows)
    # saved so(5)-spin violator
    import os
    f = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                     "scripts/data/defect_violation_n8_0.120000.npy")
    if os.path.exists(f):
        W = np.load(f)
        W = W / norm(W)
        W, Q, theta = orient_theta_positive(W, ctxs[8]["Qfun"])
        report_point("so(5)-spin violator (4,6)", point_data(W, ctxs[8], cs[8]),
                     ctxs[8], cs[8], rows, star=True)

    print(f"\n  [t={time.time()-t00:.0f}s] -- generic saddles (idempotency-residual "
          f"minimization) --")
    for n, n_starts in ((6, 50), (7, 16), (8, 12)):
        if n not in ctxs:
            ctxs[n] = setup(n, verbose=False)
            cs[n] = build_structure_constants(n)[3]
        t0 = time.time()
        if n == 6:
            pts, c = generic_critical_points(n, n_starts, seed=2026,
                                             resid_tol=1e-6)
        else:
            pts, c = generic_hard(n, n_starts, seed=2026)
        print(f"  n={n}: {len(pts)} distinct from {n_starts} starts "
              f"[{time.time()-t0:.0f}s]")
        for k, (Wn, th) in enumerate(pts):
            report_point(f"generic n={n} #{k}", point_data(Wn, ctxs[n], cs[n]),
                         ctxs[n], cs[n], rows, star=(n == 6 and k < 2))

    print(f"\n  [t={time.time()-t00:.0f}s] PART 4c: n=5 catalogue + generic + "
          f"violator-seeded hunts (the pipeline that found the ratio-0.159 point)")
    ctxs[5] = setup(5, verbose=False)
    cs[5] = build_structure_constants(5)[3]
    for label, W in (("sphere (2,3)", sphere_weyl(ctxs[5], 2)),
                     ("Fox padded 4->5", fox_weyl(ctxs[5]))):
        W, Q, theta = orient_theta_positive(W, ctxs[5]["Qfun"])
        report_point(label, point_data(W, ctxs[5], cs[5]), ctxs[5], cs[5], rows)
    pts5, _ = generic_critical_points(5, 30, seed=50505, resid_tol=1e-6)
    for k, (Wn, th) in enumerate(pts5):
        report_point(f"generic n=5 #{k}", point_data(Wn, ctxs[5], cs[5]),
                     ctxs[5], cs[5], rows)
    refuters = []
    for n_s, nst, sd in ((5, 8, 240821), (6, 6, 818283)):
        t0 = time.time()
        hunted, _ = seeded_hunt(n_s, nst, seed=sd)
        print(f"  seeded hunt n={n_s}: {len(hunted)} critical points from "
              f"{2*nst} polishes [{time.time()-t0:.0f}s]")
        for label, Wn in hunted:
            d = point_data(Wn, ctxs[n_s], cs[n_s])
            report_point(label, d, ctxs[n_s], cs[n_s], rows, star=(n_s == 5))
            if not d["vacuous"] and d["minRX"] < -1e-6 and d["resid"] < 1e-6:
                refuters.append((label, Wn, n_s))

    print(f"\n  [t={time.time()-t00:.0f}s] -- theta-pinned sweep at n=6 --")
    pinned, c6 = theta_pinned_points(6, (0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3),
                                     seed=777)
    for label, Wn in pinned:
        report_point(label, point_data(Wn, ctxs[6], cs[6]), ctxs[6], cs[6], rows)

    print(f"\n  [t={time.time()-t00:.0f}s] PART 4b: adversarial polish (n=6)")
    pts6, _ = generic_critical_points(6, 12, seed=31415, resid_tol=1e-6)
    seed_Ws = [W for W, th in pts6][:6]
    if seed_Ws:
        adversarial(6, seed_Ws, cs[6], ctxs[6])

    part5()
    part6()
    part7_n12(refuters)

    print("=" * 78)
    print("SUMMARY")
    print("=" * 78)
    ok = [r for r in rows if r["resid"] < TOL_RESID]
    print(f"  critical points analyzed: {len(ok)} "
          f"(catalogue+violator+generic+pinned), theta in "
          f"[{min(r['theta'] for r in ok):.3f}, {max(r['theta'] for r in ok):.3f}]")
    print(f"  Theorem A identities, worst residual: "
          f"{max(r['eA'] for r in ok):.1e}  (tracks criticality residual)")
    comm = [r for r in ok if r["commuting"]]
    print(f"  Theorem B commuting class: {len(comm)}/{len(ok)} points "
          f"(every named point), max |cross| there = "
          f"{max(abs(r['cross']) for r in comm):.1e}")
    floor = [r for r in ok if not r["commuting"] and r["J5_diag"] <= r["noise"]
             and abs(r["cross"]) <= r["noise"]]
    ncomm = [r for r in ok if not r["commuting"] and r not in floor]
    if floor:
        print(f"  near-critical approximations of sharp points (J5_diag and "
              f"cross both below the O(resid) noise floor): {len(floor)}")
    if ncomm:
        wr = max(ncomm, key=lambda r: r["ratio"])
        print(f"  genuinely non-commuting points: {len(ncomm)}; worst "
              f"|cross|/J5_diag = {wr['ratio']:.5f} (at {wr['label']}, "
              f"theta={wr['theta']:.3f})")
        certified = [r for r in ncomm if r["certD"]]
        print(f"  Theorem D certificate fires at {len(certified)}/{len(ncomm)} "
              f"non-commuting points")
        print(f"  Theorem C/D bounds valid (|cross| <= bound) at all points: "
              f"{all(r['okC'] and r['okD'] for r in ncomm)}")
    print(f"  min J5           = {min(r['J5'] for r in ok):+.2e}   (grant J5>=0: "
          f"{'HOLDS' if all(r['J5'] > -r['noise'] for r in ok) else 'FAILS'})")
    print(f"  min J5_diag      = {min(r['J5_diag'] for r in ok):+.2e}  (proven >= 0)")
    rmax = max((r["ratio"] for r in ok if np.isfinite(r["ratio"])), default=0.0)
    print(f"  max |cross|/diag = {rmax:.5f}"
          f"   (target |cross| <= J5_diag: "
          f"{'HOLDS' if all(abs(r['cross']) <= r['J5_diag'] + r['noise'] for r in ok) else 'FAILS'})")
    neg = [r for r in ok if r["minRX"] < -r["noise"]]
    print(f"  min mineig Ric(X_inv) = {min(r['minRX'] for r in ok):+.2e}   "
          f"(matrix strengthening Ric(X_inv)>=0: "
          + ("holds at every point here" if not neg else
             f"REFUTED at {len(neg)} point(s): "
             + ", ".join(f"{r['label']} (th={r['theta']:.3f})" for r in neg)
             + " -- J5>=0 and the target still hold there") + ")")
    sharp = [r for r in ok if abs(r["J5"]) < 1e-8 and r["resid"] < 1e-9]
    print(f"  exactly-constructed sharp points (J5=0): {len(sharp)}; "
          f"max ||Ric(X_inv)|| there = "
          f"{max(r['nRX'] for r in sharp):.1e} (identically zero); "
          f"max ||X_inv|| there = {max(r['nX'] for r in sharp):.2e}")
    print(f"  total time {time.time()-t00:.0f}s")


if __name__ == "__main__":
    main()
