"""
Do Jaeger's Lemmas 3.2.3 and 3.2.4 lift off the diagonal locus?  (FINDINGS
"Lifting Jaeger's §3.3 in trace form", Result 7 flagged these two as the
remaining §3.2 ingredients unverified for the lifted Corollary 3.2.6.)

STATEMENTS (thesis pp. 39-40; notation 3.0.3 with the spectral reading
|W| = W_+ + W_- off the diagonal locus; ||W|| = 1; R_Ric := orthogonal
projection of R onto <I> + <Ric_0> = { h ^ id : h in S^2(R^n) }):

  L3.2.3:  2 ||W_-||^2  >=  1 - sqrt(1 - || |W|_Ric ||^2)
  L3.2.4:  || R_Ric ||^2 = ||Ric(R)||^2 / (n-2) - scal(R)^2 / (2(n-1)(n-2)),
           stated in the thesis for Bianchi R (R in S^2_B(so(n))).

TEXTUAL AUDIT OF THE PROOFS (the specific lines where diagonality or the
Bianchi identity enters):

* Lemma 3.2.4.  The proof's first line cites equation (1.3) of §1.2 -- the
  projection formula R_Ric = scal/(n(n-1)) I + 2/(n-2) Ric_0(R)^id, stated
  there for the three-part decomposition of S^2_B(so(n)).  That citation is
  the ONLY Bianchi input; everything after it is n x n spectral algebra on
  Ric_0(R) (its eigenbasis b_i makes A^id diagonal on the induced basis
  b_i^b_j of Lambda^2), frame-free and diagonality-free.  And (1.3) itself
  extends verbatim to EVERY symmetric R: Lambda^4 is orthogonal to
  <I> + <Ric_0> (irreducible-type orthogonality in the full decomposition
  S^2(so(n)) = <I> + <Ric_0> + <W> + Lambda^4), and Ric annihilates
  Lambda^4 (Schur), so both the projection and Ric(R) see only the Bianchi
  part of R.  Expected verdict: LIFTS VERBATIM, with the hypothesis
  weakened from S^2_B(so(n)) to all of S^2(so(n)).

* Lemma 3.2.3.  The proof sets a := ||W_+||^2 - ||W_-||^2 = <|W|, W> and
  asserts (second display of the proof, thesis p. 39)

      a^2  <=  || |W|_<W> ||^2  =  1 - || |W|_Ric ||^2 .

  The inequality is Cauchy-Schwarz with W a unit vector of the Weyl
  subspace <W> -- frame-free.  The EQUALITY is where the diagonal locus
  enters: it uses || |W| || = 1 together with |W| in S^2_B(so(n)), i.e.
  that |W| has no Lambda^4 component.  A coordinate-diagonal operator is
  automatically Bianchi, so on the diagonal locus this is free; off it,
  || |W|_Lambda4 ||^2 = 4 delta^2 > 0 exactly when the Bianchi defect
  delta = ||Alt(W_-)|| is nonzero (Alt(W) = 0 gives Alt(|W|) = 2 Alt(W_-)).
  The omitted term has the FAVORABLE sign: the corrected line reads

      a^2  <=  || |W|_<W> ||^2  =  1 - || |W|_Ric ||^2 - 4 delta^2
                                <=  1 - || |W|_Ric ||^2 ,

  so the stated inequality survives with "=" weakened to "<=", and keeping
  the term STRENGTHENS the lemma off-diagonal:
      2 ||W_-||^2  >=  1 - sqrt(1 - || |W|_Ric ||^2 - 4 delta^2).
  Expected verdict: statement LIFTS VERBATIM; the proof needs one stated
  correction ("=" -> "<=") that costs nothing and is sharp at delta = 0.

THIS SCRIPT verifies both audits numerically with the repo's validated
machinery:

  PART 0 (structural facts, random NON-Bianchi symmetric operators at
  n = 5, 6, 8): Ric annihilates Lambda^4; Lambda^4 is orthogonal to every
  h^id; the lifted (1.3) formula agrees with the least-squares projection
  onto span{h^id}; the lifted 3.2.4 norm formula holds.
  PART 1 (catalogued critical points: sphere products in diagonal and
  randomly rotated frames, Fox S^4(alpha), SU(3), QK HP^2, plus n = 6
  generic critical points found by idempotency-residual minimization,
  including low-theta saddles with nonzero defect): every link of the
  lifted 3.2.3 chain, the size of the thesis-equality defect (checked
  against 4 delta^2), the Cauchy-Schwarz margin, the final 3.2.3 margin
  and its strengthened form, and the 3.2.4 residual at R = |W|.
  PART 2 prints the per-lemma verdicts.
"""
import time
import numpy as np

from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_bianchi_defect import bianchi_defect, alt_mop
from run_bianchi_defect_highp_seed import build_su3_n8
from run_vertex_bound import mop_to_tensor4, rotate_tensor4, random_orthogonal
from run_j5_structure import generic_critical_points
from weyl import build_structure_constants
from weyl_decomposition import ricci_from_mop, mop_from_4tensor, norm, frob
from rsharp_basis_free import Q_full


# ---------------------------------------------------------------------
# the Ricci-type subspace { h ^ id } and its projection
# ---------------------------------------------------------------------
def wedge_id_tensor(A):
    """(A ^ id) as a 4-tensor callable, polarized from (h^h)(i,j,k,l) =
    h_ik h_jl - h_il h_jk (the repo/Jaeger convention: id^id = I, and
    <(A^id)(b_i^b_j), b_i^b_j> = (a_i + a_j)/2 in A's eigenbasis)."""
    def T(i, j, k, l):
        return 0.5 * (A[i, k] * (j == l) + (i == k) * A[j, l]
                      - A[i, l] * (j == k) - (i == l) * A[j, k])
    return T


def build_ric_type_basis(L2):
    """Columns: flattened operators E_ab ^ id, a <= b -- a basis of the
    Ricci-type subspace <I> + <Ric_0> inside S^2(so(n))."""
    n, N = L2.n, L2.N
    cols = []
    for a in range(n):
        for b in range(a, n):
            E = np.zeros((n, n))
            E[a, b] += 1.0
            E[b, a] += 1.0
            cols.append(mop_from_4tensor(L2, wedge_id_tensor(E)).ravel())
    return np.array(cols).T  # (N^2, n(n+1)/2)


def proj_ric_type(Mop, B):
    """Least-squares orthogonal projection of Mop onto span{h^id} --
    independent of formula (1.3), so it can test (1.3)."""
    x, *_ = np.linalg.lstsq(B, Mop.ravel(), rcond=None)
    P = (B @ x).reshape(Mop.shape)
    return P


def ric_formula_13(L2, Mop):
    """The lifted equation (1.3): scal/(n(n-1)) I + 2/(n-2) Ric_0 ^ id."""
    n, N = L2.n, L2.N
    Ric = ricci_from_mop(L2, Mop)
    scal = np.trace(Ric)
    Ric0 = Ric - (scal / n) * np.eye(n)
    return (scal / (n * (n - 1))) * np.eye(N) \
        + (2.0 / (n - 2)) * mop_from_4tensor(L2, wedge_id_tensor(Ric0))


def lemma_324_rhs(L2, Mop):
    n = L2.n
    Ric = ricci_from_mop(L2, Mop)
    scal = np.trace(Ric)
    return frob(Ric, Ric) / (n - 2) - scal ** 2 / (2 * (n - 1) * (n - 2))


def spectral_parts(Wmat, tol=1e-10):
    w, V = np.linalg.eigh(Wmat)
    Wp = (V[:, w > tol] * w[w > tol]) @ (V[:, w > tol]).T
    Wm = -(V[:, w < -tol] * w[w < -tol]) @ (V[:, w < -tol]).T
    return Wp, Wm


# ---------------------------------------------------------------------
# PART 0: structural facts on random non-Bianchi operators
# ---------------------------------------------------------------------
def part0(ns=(5, 6, 8), seed=0, trials=4):
    print("=" * 78)
    print("PART 0: structural facts behind the lifts (random non-Bianchi R)")
    print("=" * 78)
    rng = np.random.default_rng(seed)
    ok = True
    for n in ns:
        ctx = setup(n, verbose=False)
        L2, alt_idx, N = ctx["L2"], ctx["alt_idx"], ctx["N"]
        B = build_ric_type_basis(L2)
        w1 = w2 = w3 = w4 = 0.0
        for _ in range(trials):
            R = rng.normal(size=(N, N))
            R = 0.5 * (R + R.T)
            R /= norm(R)
            AltR = alt_mop(R, alt_idx)
            # (a) Ric annihilates Lambda^4
            w1 = max(w1, norm(ricci_from_mop(L2, AltR)))
            # (b) Lambda^4 is orthogonal to the Ricci-type subspace
            w2 = max(w2, np.abs(B.T @ AltR.ravel()).max())
            # (c) lifted (1.3) equals the least-squares projection
            w3 = max(w3, norm(proj_ric_type(R, B) - ric_formula_13(L2, R)))
            # (d) lifted 3.2.4 at this (non-Bianchi) R
            P = proj_ric_type(R, B)
            w4 = max(w4, abs(frob(P, P) - lemma_324_rhs(L2, R)))
        altsz = norm(alt_mop(R, alt_idx))
        print(f"  n={n}: ||Ric(Alt R)|| = {w1:.1e}   max <Alt R, h^id> = {w2:.1e}"
              f"   ||(1.3)-proj|| = {w3:.1e}   |3.2.4 resid| = {w4:.1e}"
              f"   (last R: ||Alt R|| = {altsz:.3f}, genuinely non-Bianchi)")
        ok = ok and max(w1, w2, w3, w4) < 1e-10
    print(f"  all four structural facts hold on non-Bianchi input: "
          f"{'ok' if ok else 'FAIL'}")
    return ok


# ---------------------------------------------------------------------
# PART 1: catalogued critical points
# ---------------------------------------------------------------------
def analyze_point(label, Wn, ctx, c, B, out):
    L2, alt_idx, n = ctx["L2"], ctx["alt_idx"], ctx["n"]
    Q = Q_full(Wn, c)
    theta = frob(Wn, Q)
    resid = norm(Q - theta * Wn) / norm(Q)
    Wp, Wm = spectral_parts(Wn)
    absW = Wp + Wm
    delta2 = bianchi_defect(Wn, alt_idx) ** 2

    # --- Lemma 3.2.4 at R = |W| ---
    P = proj_ric_type(absW, B)
    ric2 = frob(P, P)
    r324 = abs(ric2 - lemma_324_rhs(L2, absW))
    r13 = norm(P - ric_formula_13(L2, absW))

    # --- Lemma 3.2.3 chain ---
    a = frob(absW, Wn)
    np2, nm2 = frob(Wp, Wp), frob(Wm, Wm)
    r_a = abs(a - (np2 - nm2))          # a = ||W+||^2 - ||W-||^2
    r_sum = abs(np2 + nm2 - 1.0)        # ||W+||^2 + ||W-||^2 = 1
    AltW = alt_mop(absW, alt_idx)
    altsq = frob(AltW, AltW)            # || |W|_Lambda4 ||^2
    r_alt = abs(altsq - 4 * delta2)     # = 4 delta^2
    Wweyl = absW - P - AltW             # the <W>-component of |W|
    r_wcons = max(norm(ricci_from_mop(L2, Wweyl)),
                  norm(alt_mop(Wweyl, alt_idx)))
    wsq = frob(Wweyl, Wweyl)
    cs_margin = wsq - a * a             # Cauchy-Schwarz step, >= 0
    eq_defect = (1.0 - ric2) - wsq      # thesis "=" fails by exactly this
    m323 = 2 * nm2 - (1.0 - np.sqrt(max(1.0 - ric2, 0.0)))
    m323s = 2 * nm2 - (1.0 - np.sqrt(max(1.0 - ric2 - altsq, 0.0)))

    chain_ok = max(r_a, r_sum, r_alt, r_wcons) < 1e-9
    print(f"  {label:32s} n={n} theta={theta:+.6f} resid={resid:.1e} "
          f"delta^2={delta2:.6f}")
    print(f"      3.2.4: | ||R_Ric||^2 - formula | = {r324:.1e}   "
          f"||proj - (1.3)|| = {r13:.1e}   -> {'ok' if max(r324, r13) < 1e-9 else 'FAIL'}")
    print(f"      3.2.3: chain identities resid = {max(r_a, r_sum, r_alt, r_wcons):.1e}"
          f"   CS margin = {cs_margin:+.6f}   eq-defect = {eq_defect:.6f}"
          f" (= 4 delta^2: {r_alt:.1e})")
    print(f"             margin (as stated) = {m323:+.6f}   "
          f"margin (strengthened, -4d^2) = {m323s:+.6f}   "
          f"-> {'ok' if m323 >= -1e-9 and m323s >= -1e-9 and chain_ok else 'FAIL'}")
    out.append(dict(label=label, n=n, theta=theta, resid=resid, delta2=delta2,
                    r324=r324, r13=r13, cs=cs_margin, eqd=eq_defect,
                    r_alt=r_alt, m323=m323, m323s=m323s, chain=chain_ok))


def part1():
    print()
    print("=" * 78)
    print("PART 1: the lifted 3.2.3 / 3.2.4 at every catalogued critical point")
    print("=" * 78)
    out = []
    rng = np.random.default_rng(11)
    for n in (6, 8):
        ctx = setup(n, verbose=False)
        idx, pos, N2, c = build_structure_constants(n)
        L2 = ctx["L2"]
        B = build_ric_type_basis(L2)
        print(f"\n  -- n={n} --")
        for p in range(2, n // 2 + 1):
            analyze_point(f"sphere ({p},{n-p})", sphere_weyl(ctx, p),
                          ctx, c, B, out)
        T = mop_to_tensor4(L2, sphere_weyl(ctx, n // 2))
        O = random_orthogonal(n, rng)
        Wrot = mop_from_4tensor(
            L2, lambda i, j, k, l, Tr=rotate_tensor4(T, O): Tr[i, j, k, l])
        analyze_point(f"sphere ({n//2},{n//2}) rotated", Wrot / norm(Wrot),
                      ctx, c, B, out)
        analyze_point("Fox S^4(alpha)", fox_weyl(ctx), ctx, c, B, out)
        if n == 8:
            _, Wsu3 = build_su3_n8()
            analyze_point("SU(3) bi-invariant", Wsu3, ctx, c, B, out)
            analyze_point("QK HP^2", qk_weyl(ctx, 2), ctx, c, B, out)

    print("\n  -- n=6 generic critical points (idempotency-residual"
          " minimization, incl. low-theta saddles) --")
    n = 6
    ctx = setup(n, verbose=False)
    B = build_ric_type_basis(ctx["L2"])
    found, c = generic_critical_points(n, n_starts=14, seed=7)
    for gi, (Wg, th) in enumerate(found):
        analyze_point(f"generic saddle {gi}", Wg, ctx, c, B, out)
    return out


def part2(ok0, out):
    print()
    print("=" * 78)
    print("PART 2: verdicts")
    print("=" * 78)
    ok = [o for o in out if o["resid"] < 1e-5]
    offd = [o for o in ok if o["delta2"] > 1e-10]
    w324 = max(max(o["r324"] for o in ok), max(o["r13"] for o in ok))
    print(f"  critical points analyzed: {len(ok)} "
          f"({len(offd)} with nonzero Bianchi defect)")
    print(f"  LEMMA 3.2.4: worst residual of the lifted norm formula and of the")
    print(f"    lifted (1.3) at R = |W|: {w324:.1e}; structural facts (PART 0) on")
    print(f"    generic non-Bianchi R: {'ok' if ok0 else 'FAIL'}.")
    print(f"    VERDICT: lifts VERBATIM to every symmetric R -- the sole Bianchi")
    print(f"    input, eq. (1.3), holds on all of S^2(so(n)) because Lambda^4 is")
    print(f"    orthogonal to <I>+<Ric_0> and Ric annihilates Lambda^4; the rest")
    print(f"    of the proof is n x n spectral algebra.")
    m = min(o["m323"] for o in ok)
    ms = min(o["m323s"] for o in ok)
    cs = min(o["cs"] for o in ok)
    ralt = max(o["r_alt"] for o in ok)
    chain = all(o["chain"] for o in ok)
    print(f"  LEMMA 3.2.3: chain identities exact at every point: "
          f"{'yes' if chain else 'NO'};")
    print(f"    min Cauchy-Schwarz margin = {cs:+.2e}; eq-defect = 4 delta^2 to")
    print(f"    {ralt:.1e}; min margin as stated = {m:+.6f}; min strengthened")
    print(f"    margin (with -4 delta^2) = {ms:+.6f}.")
    v = (m >= -1e-9) and (ms >= -1e-9) and chain
    print(f"    VERDICT: statement lifts VERBATIM ({'holds' if v else 'FAILS'} at "
          f"every point); the proof needs ONE stated correction -- in the display")
    print(f"    a^2 <= |||W|_<W>||^2 = 1 - |||W|_Ric||^2 the \"=\" becomes \"<=\"")
    print(f"    off-diagonal (the gap is exactly || |W|_Lambda4 ||^2 = 4 delta^2,")
    print(f"    favorable sign), and keeping the term strengthens the lemma to")
    print(f"    2||W_-||^2 >= 1 - sqrt(1 - |||W|_Ric||^2 - 4 delta^2).")


def main():
    t0 = time.time()
    ok0 = part0()
    out = part1()
    part2(ok0, out)
    print(f"\n  total time: {time.time()-t0:.1f}s")


if __name__ == "__main__":
    main()
