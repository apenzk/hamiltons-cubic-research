# Gate 2 review r1131: Lean proofs of L238 (i) and L243, and R39's spread caps

Brief: [2026-09-25-gate2-lean-spread-brief.md](2026-09-25-gate2-lean-spread-brief.md). Log: [agent_logs/r1131.log](../agent_logs/r1131.log). Analysis only, plus two seconds-long screens on objects constructed here.

| Item | Verdict |
|---|---|
| 1. A, statements | CONFIRMED |
| 2. A, completeness | PLAUSIBLE, wording repair below |
| 3. B, mean-spread identity | CONFIRMED |
| 4. B, Jensen step | CONFIRMED, with two precisions |
| 5. B, scope | CONFIRMED, with one caveat on how the screen may be cited |

## Build

`lake env lean` on a file importing [GaussianRankStep.lean](../lean/HamiltonsCubic/Results/GaussianRankStep.lean) with `#print axioms` for `L243_frame` and `frame_gaussian_form` elaborates in 50 s and reports only `propext`, `Classical.choice`, `Quot.sound`. Neither file contains `sorry` or `native_decide`.

## 1. A, statements: CONFIRMED

- `frame_gaussian_form`: the left side is the ordered sum over `i ≠ j` of `-(1/2) tr([X_i,X_j]^2)`, which is the record's norm of the bracket. The integrand is `∑_{i≠j} (G_ii G_jj − G_ij^2)` with `G_ij = ⟨X_i v, X_j v⟩` and `v` standard Gaussian on `ℝ^d` (`Measure.pi` of `gaussianReal 0 1`). The constant is `4k(k−1)`. This is L238 (i) summed, at every `k` (the empty frame gives `0 = 0`).
- `hskew`, `hnorm : tr(X_i X_i) = −2`, `horth : tr(X_i X_j) = 0` for `i ≠ j` are exactly orthonormality in `⟨X,Y⟩ = −½ tr XY`. Nothing stronger is assumed.
- `L243_frame`: `P = ∑ X_iᵀ X_i = ∑(−X_i^2)`, the record's `P`. `tr P = 2k` is derived inside the proof (`htrP`), never assumed. The factor is `1 − 1/(n−1)`, the record's `r = n−1` branch.
- `hn : 2 ≤ n` is harmless: at `n = 1` there is no unit skew matrix, and at `n = 2` the right side is `−4k(k−1)`, which is correct since `so(2)` admits `k ≤ 1` only. The hypotheses are satisfiable (any `k = 1` frame), so nothing is vacuous.

## 2. A, completeness: PLAUSIBLE

- Mathematically nothing the record claims is left unproved, but the `r = k` branch lives in a different file and a different form than the lean/INDEX row says.
- The `r = k` cap is `frame_bound` in [FrameGaussianBound.lean](../lean/HamiltonsCubic/Results/FrameGaussianBound.lean): `frameT X ≤ 2(1 − 1/k) tr P^2` for skew `X_i`, `0 < k`. Expanding, `(1 − 1/k)(4k^2 + 2 tr P^2) − 4k(k−1) = 2(1 − 1/k) tr P^2` identically, with no use of `tr P`. So L243 at `r = k` is `frame_bound`, and `frameT` equals the ordered bracket total because `tr(X^2Y^2) − tr(XYXY) = ‖[X,Y]‖^2` in the record's norm and the diagonal terms vanish.
- `trace_sq_le_k` is only the pointwise inequality `(tr G)^2 ≤ k‖G‖_F^2`. It is never integrated, so it is not "the rank-k version" of the cap as [lean/INDEX.md](../lean/INDEX.md) row L243 reads. It is also unnecessary, since `frame_bound` already carries the branch.
- The assembled statement at `r = min(k, n−1)` is not one declaration. Because `1 − 1/r` increases in `r`, it is the smaller of the two proved bounds, a two-line corollary that nobody has typed.
- **Corrections.** (a) The docstring of `L243_frame` says "L243, fully in Lean": it should say "L243 at `r = n−1`". (b) lean/INDEX row L243 should name `frame_bound` as the `r = k` branch instead of `trace_sq_le_k`, or a corollary `L243_frame_min` should be added. With either, "proved at frame level" is accurate for the full `min(k, n−1)` statement.

## 3. B, the mean-spread identity: CONFIRMED

- Fourth moment on `S^{m−1}`: `E ξ_α^4 = 3/(m(m+2))`, `E ξ_α^2 ξ_β^2 = 1/(m(m+2))`, as stated.
- The three pairings give `∑_{α,γ} tr(Ψ_α^2 Ψ_γ^2) = tr A_c^2 = G_cc`, `∑_{α,β} tr(Ψ_αΨ_β^2Ψ_α) = G_cc`, and `∑_{α,β} tr(Ψ_αΨ_βΨ_αΨ_β)`. So `2G_cc + ∑ tr(ΨΨΨΨ)` is right.
- `∑Ψ_α^2 = −A_c` holds with the record's `A_a = ∑ Ψ_α Ψ_αᵀ` because `Ψᵀ = −Ψ`.
- `‖[X,Y]‖^2 = −½ tr([X,Y]^2) = tr(X^2Y^2) − tr(XYXY)`, so `tr(XYXY) = tr(X^2Y^2) − ‖[X,Y]‖^2` and the sum is `G_cc − ∑_{α,β}‖[Ψ_α,Ψ_β]‖^2`.
- `τ_{cc·} = ∑_d τ_{ccd} = ∑_{α,β∈c} ∑_γ c_{αβγ}^2 = ∑_{α,β∈c} ‖[Ψ_α,Ψ_β]‖^2` because the eigenbases of all classes together form an orthonormal basis of `so(n)`. It is the right class sum.
- `tr x^2 = −2∑s_i^2 = −2` for unit `x`, and `tr x^4 = 2∑s_i^4`.
- Screens (seconds): on a random 4-dimensional subspace of `so(6)` the formula gives 1.27636 against a 200000-sample mean of 1.27645. On the standard `so(5)` block in `so(12)`, `G = 80`, `τ = 60`, and `E∑s^4 = 0.75` against a sample mean of 0.7498. This matches the note's `(240 − 60)/240`.

## 4. B, the Jensen step: CONFIRMED

- If `κ_r(x) ≤ φ_r(σ(x))` for every unit `x` and `φ_r` is concave on `[1/6, 1]` (at `n = 12`), then `E κ_r ≤ E φ_r(σ) ≤ φ_r(E σ)`. Correct.
- **Precision 1.** `φ_r` has to be the least concave majorant of the EXACT supremum `q ↦ sup{κ_r(x) : σ(x) = q}`. The supremum alone is not concave (the note says so), and a majorant built from a lower estimate of the supremum is not a valid `φ_r`. The note's wording "concave upper envelope" is right, and this is what makes item 5 matter.
- LHS: `R_a(x) = ∑_b b_ab(x)` is a quadratic form in `x`, so `∑_{α∈c} R_a(ψ_α)` is the same for EVERY orthonormal basis of `E_c`. With `b_ab(ψ_α) = ½∑_{γ∈a,δ∈b} c_{γδα}^2` and `τ` symmetric under permuting its indices (`c` is totally antisymmetric by ad-invariance), `2∑_{α∈c} R_a(ψ_α) = τ_{a·c} = τ_{ca·}`. This agrees with the implementation, `lhs = ∑_d τ(c, a, d)`.
- **Precision 2.** The Haar-random basis is a device and can be dropped: averaging `2R_a(x) ≤ κ_r(x)` over uniform unit `x ∈ E_c` and multiplying by `m_c` gives the same inequality directly. The `r` is `m_a` for `a ≠ c` and `m_c − 1` for `a = c` (L244 (i)), and the script uses `r = m_a − [a = c]`, which matches.
- Linear caps: `q̄_c = (3G_cc − τ_{cc·})/(2m_c(m_c+2))` is affine in `(τ, G)` at fixed multiplicities. A concave `φ_r` lies below each of its supporting lines `ℓ`, so `τ_{ca·} ≤ m_c φ_r(q̄_c) ≤ m_c ℓ(q̄_c)` is valid for each `ℓ` separately. Together they are equivalent to the concave cap. The union version follows in the same way.

## 5. B, scope: CONFIRMED, with a caveat

- Nothing in the record is stated as proved on the strength of the envelope. The note labels its section "Screens throughout". [plan.md](../plan.md) gives "177 of 2080 (a screen)". The findings files and [lean/INDEX.md](../lean/INDEX.md) carry no spread cap. The Lean section of the brief correctly lists these as untyped.
- **Caveat on citing the 177.** [screen_I73c_spread_envelope.py](../scripts/misc/screen_I73c_spread_envelope.py) is not a certified majorant, and every error pushes it the unsafe way (too low):
  - It takes the maximum of SLSQP local optima from 40 starts, which is a lower estimate of the supremum.
  - It samples only 41 values of `q` and interpolates the hull linearly between them, which can sit below the true supremum between grid points.
  - The coefficients are rationalised with `limit_denominator`, against a slack of only `10^{-4}`.
- So the 13 triples the spread caps remove (190 to 177) are unsafe exclusions until `φ_r` is derived. The note's "Sound and modest" should read "sound on the one control" or be dropped. The S^5×S^7 control (worst slack 48.7) is evidence against gross error only.
