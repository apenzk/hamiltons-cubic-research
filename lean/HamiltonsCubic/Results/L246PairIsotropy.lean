import Mathlib

/-!
# L246, the pair isotropy inequality

## The record's statement, quoted from [second-order.md](../../../findings/second-order.md)

"Let $W$ be a Weyl tensor with three eigenvalues and isotropy matrices $A_c$. They commute, and for any two
classes $a\ne b$ let $\beta_1,\dots,\beta_n$ be the eigenvalues of $A_a+A_b$ on a common eigenbasis. Then for
every $j$, $\beta_j\le\sum_{i\ne j}\min(1,\beta_i)$."

## What is typed

The scalar steps and one matrix step. `capped_trace`: a trace split along a projector, each part capped, gives the capped
sum (the matrix facts `M_a(e)+M_b(e) ⪯ I − eeᵀ` and `M_c(e) ⪯ A_c` enter as the part bounds).
`star_impossible_at_zero` and `star_sign`: the corollary that an extreme eigenspace which is a star forces `λ₁ < 0`, as the contradiction at `λ₁ = 0`
and the sign at `λ₁ > 0`. `M_le_A`: `M_c(e) ⪯ A_c` at every `z`, by skew-symmetry and
Cauchy–Schwarz.

## What is NOT typed

`∑_c M_c(e) = I − eeᵀ`, the commutation of the `A_c` and the spectral projector; they enter as the
hypotheses.
-/

namespace HamiltonsCubic.L246PairIsotropy

/-- **The capped trace.** `tr X = tQ + tR` with `tQ ≤ tr Q` (from `X ⪯ I`) and `tR ≤ ν_small`
(from `X ⪯ Â` off `Q`), so `tr X ≤ #{ν ≥ 1} + ∑_{ν<1} ν = ∑ min(1, ν)`. -/
theorem capped_trace (trX tQ tR rankQ nuSmall : ℝ) (h : trX = tQ + tR) (hQ : tQ ≤ rankQ)
    (hR : tR ≤ nuSmall) : trX ≤ rankQ + nuSmall := by linarith

/-- **At `λ₁ = 0` a star `E₀ = e ∧ U` is impossible.** On `Z = (e ⊕ U)^⊥` the pair `(0,2)` has `β = 0`,
on `U` each `min(1, β) ≤ 1`, and at `e` `β = p + α₂(e)` with `α₂(e) = |λ₀|p/λ₂ > 0`. -/
theorem star_impossible_at_zero (p l0 l2 : ℝ) (hp : 0 < p) (h0 : l0 < 0) (h2 : 0 < l2)
    (hcap : p + (-l0) * p / l2 ≤ p) : False := by
  have : 0 < (-l0) * p / l2 := div_pos (mul_pos (by linarith) hp) h2
  linarith

/-- **And `λ₁ > 0` is impossible for a star `E₀`**: on `Z`, `A₀ = 0` and `Ric(W) = 0` give
`(λ₂ − λ₁)A₂ = −λ₁(n − 1)`, negative, against `A₂ ⪰ 0`, whenever `Z ≠ 0`. -/
theorem star_sign (n l1 l2 a2 : ℝ) (hn : 1 < n) (h12 : l1 < l2) (hpsd : 0 ≤ a2)
    (hric : (l2 - l1) * a2 = -l1 * (n - 1)) : l1 ≤ 0 := by
  by_contra h; push Not at h
  have : (l2 - l1) * a2 ≥ 0 := mul_nonneg (by linarith) hpsd
  nlinarith

/-- **The support count's arithmetic** (the count itself is `dim E₀ + dim E₂ ≤ dim Λ²S`, needing no
inequality; this is the form through L246's caps). With `αmax ≤ (s − 1)/(1 + r)` (each of at most `s − 1` other
nonzero eigenvalues capped at `1/(1 + r)`) and `2p = tr A₀ ≤ s · αmax`: `s(s − 1) ≥ 2(1 + r)p`. -/
theorem support_bound (s p r amax : ℝ) (hs : 0 ≤ s) (hr : 0 < r)
    (hcap : (1 + r) * amax ≤ s - 1) (htr : 2 * p ≤ s * amax) : 2 * (1 + r) * p ≤ s * (s - 1) := by
  nlinarith [mul_le_mul_of_nonneg_left hcap hs]

/-- Non-vacuity, sharpness: at `S⁵ × S⁷` the pair of classes of multiplicity `10` and `35` has
`β = 11` on `ℝ⁵` and `5` on `ℝ⁷`, and at an `ℝ⁵` direction `11 ≤ 4·1 + 7·1`, with equality. -/
example : (11 : ℝ) = 4 * min 1 11 + 7 * min 1 5 := by norm_num

/-! ## The matrix step `M_c(e) ⪯ Â_c`, typed

`⟨M_c(e) z, z⟩ = ∑_ψ ⟨ψe, z⟩²` and `⟨A_c z, z⟩ = ∑_ψ |ψz|²`, so the Loewner step is the termwise
inequality below: skew-symmetry swaps `⟨ψe, z⟩ = −⟨e, ψz⟩`, then Cauchy–Schwarz with `|e| = 1`. -/

open Matrix in
/-- A skew matrix is anti-self-adjoint for the dot product. -/
theorem skew_swap {n : ℕ} (X : Matrix (Fin n) (Fin n) ℝ) (hX : Xᵀ = -X) (u v : Fin n → ℝ) :
    X.mulVec u ⬝ᵥ v = -(u ⬝ᵥ X.mulVec v) := by
  have h : X.mulVec u ⬝ᵥ v = u ⬝ᵥ (Xᵀ).mulVec v := by
    rw [Matrix.mulVec_transpose, dotProduct_comm, Matrix.dotProduct_mulVec, dotProduct_comm]
  rw [h, hX, Matrix.neg_mulVec, dotProduct_neg]

open Matrix in
/-- **`M_c(e) ⪯ A_c`, evaluated at `z`**: for skew `ψ_i` and unit `e`,
`∑ᵢ ⟨ψᵢe, z⟩² ≤ ∑ᵢ |ψᵢz|²`. -/
theorem M_le_A {n m : ℕ} (ψ : Fin m → Matrix (Fin n) (Fin n) ℝ) (hψ : ∀ i, (ψ i)ᵀ = -ψ i)
    (e z : Fin n → ℝ) (he : e ⬝ᵥ e = 1) :
    ∑ i, ((ψ i).mulVec e ⬝ᵥ z) ^ 2 ≤ ∑ i, ((ψ i).mulVec z ⬝ᵥ (ψ i).mulVec z) := by
  apply Finset.sum_le_sum
  intro i _
  rw [skew_swap _ (hψ i), neg_sq]
  have cs := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ e ((ψ i).mulVec z)
  have h1 : ∑ j, e j ^ 2 = 1 := by simpa [dotProduct, pow_two] using he
  have h2 : ∑ j, (ψ i).mulVec z j ^ 2 = (ψ i).mulVec z ⬝ᵥ (ψ i).mulVec z := by
    simp [dotProduct, pow_two]
  calc (e ⬝ᵥ (ψ i).mulVec z) ^ 2 = (∑ j, e j * (ψ i).mulVec z j) ^ 2 := rfl
    _ ≤ (∑ j, e j ^ 2) * ∑ j, (ψ i).mulVec z j ^ 2 := cs
    _ = _ := by rw [h1, one_mul, h2]

end HamiltonsCubic.L246PairIsotropy
