import HamiltonsCubic.Results.L193Statement
import HamiltonsCubic.Results.I67AdjugateLaw

set_option linter.style.longLine false

/-!
# L193's corollary: `σ ∘ σ = Pf · id`, frame-free

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L193, says the adjugate law is *"STRICTLY STRONGER than
[L187](../../../findings/diagonal-half.md), giving `σ ∘ σ = Pf · id` in five lines"*. [L187Statement.lean](L187Statement.lean)
proves `σ ∘ σ = Pf · id` on the three plane coordinates of a normal form (`sigma_sigma`). This file proves it at
every bivector of `ℝ⁶`, with no normal form:

* **`sigma6_skew`**: `σ₆(X)` is a bivector, for every `X`;
* **`sigma6_sigma6`**: **`σ₆(σ₆(X)) = Pf(X) · X`** at every skew `X`, the degree-four polynomial identity in the
  fifteen free entries, read off [I67AdjugateLaw.lean](I67AdjugateLaw.lean)'s fifteen entry theorems applied twice.

*The route is the entries, not the record's five lines*: those pass through `σ(X) = -Pf(X) X⁻¹` at invertible `X`,
which needs `Pf(σ(X)) = Pf(X)²` and a density step for singular `X`, and the entry route needs neither.
-/

namespace HamiltonsCubic.L193Statement

open HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer

set_option maxHeartbeats 4000000

/-- **`σ₆(X)` is a bivector** at every `X`. -/
theorem sigma6_skew (X : Matrix (Fin 6) (Fin 6) ℝ) : IsSkew (sigma6 X) := by
  have h := star6_isSkew (wedgeSelf X)
  unfold IsSkew at h ⊢
  unfold sigma6
  rw [Matrix.transpose_smul, h, smul_neg]

/-- **`σ₆(σ₆(X)) = Pf(X) · X` at every bivector of `ℝ⁶`**, L187's identity without a normal form. -/
theorem sigma6_sigma6 (X : Matrix (Fin 6) (Fin 6) ℝ) (hX : IsSkew X) :
    sigma6 (sigma6 X) = pf6 X • X := by
  have hY := sigma6_skew X
  have hZ := sigma6_skew (sigma6 X)
  have s01 := HamiltonsCubic.I67AdjugateLaw.sigma_0_1 X hX
  change sigma6 X 0 1 = _ at s01
  have s02 := HamiltonsCubic.I67AdjugateLaw.sigma_0_2 X hX
  change sigma6 X 0 2 = _ at s02
  have s03 := HamiltonsCubic.I67AdjugateLaw.sigma_0_3 X hX
  change sigma6 X 0 3 = _ at s03
  have s04 := HamiltonsCubic.I67AdjugateLaw.sigma_0_4 X hX
  change sigma6 X 0 4 = _ at s04
  have s05 := HamiltonsCubic.I67AdjugateLaw.sigma_0_5 X hX
  change sigma6 X 0 5 = _ at s05
  have s12 := HamiltonsCubic.I67AdjugateLaw.sigma_1_2 X hX
  change sigma6 X 1 2 = _ at s12
  have s13 := HamiltonsCubic.I67AdjugateLaw.sigma_1_3 X hX
  change sigma6 X 1 3 = _ at s13
  have s14 := HamiltonsCubic.I67AdjugateLaw.sigma_1_4 X hX
  change sigma6 X 1 4 = _ at s14
  have s15 := HamiltonsCubic.I67AdjugateLaw.sigma_1_5 X hX
  change sigma6 X 1 5 = _ at s15
  have s23 := HamiltonsCubic.I67AdjugateLaw.sigma_2_3 X hX
  change sigma6 X 2 3 = _ at s23
  have s24 := HamiltonsCubic.I67AdjugateLaw.sigma_2_4 X hX
  change sigma6 X 2 4 = _ at s24
  have s25 := HamiltonsCubic.I67AdjugateLaw.sigma_2_5 X hX
  change sigma6 X 2 5 = _ at s25
  have s34 := HamiltonsCubic.I67AdjugateLaw.sigma_3_4 X hX
  change sigma6 X 3 4 = _ at s34
  have s35 := HamiltonsCubic.I67AdjugateLaw.sigma_3_5 X hX
  change sigma6 X 3 5 = _ at s35
  have s45 := HamiltonsCubic.I67AdjugateLaw.sigma_4_5 X hX
  change sigma6 X 4 5 = _ at s45
  have t01 := HamiltonsCubic.I67AdjugateLaw.sigma_0_1 (sigma6 X) hY
  change sigma6 (sigma6 X) 0 1 = _ at t01
  have t02 := HamiltonsCubic.I67AdjugateLaw.sigma_0_2 (sigma6 X) hY
  change sigma6 (sigma6 X) 0 2 = _ at t02
  have t03 := HamiltonsCubic.I67AdjugateLaw.sigma_0_3 (sigma6 X) hY
  change sigma6 (sigma6 X) 0 3 = _ at t03
  have t04 := HamiltonsCubic.I67AdjugateLaw.sigma_0_4 (sigma6 X) hY
  change sigma6 (sigma6 X) 0 4 = _ at t04
  have t05 := HamiltonsCubic.I67AdjugateLaw.sigma_0_5 (sigma6 X) hY
  change sigma6 (sigma6 X) 0 5 = _ at t05
  have t12 := HamiltonsCubic.I67AdjugateLaw.sigma_1_2 (sigma6 X) hY
  change sigma6 (sigma6 X) 1 2 = _ at t12
  have t13 := HamiltonsCubic.I67AdjugateLaw.sigma_1_3 (sigma6 X) hY
  change sigma6 (sigma6 X) 1 3 = _ at t13
  have t14 := HamiltonsCubic.I67AdjugateLaw.sigma_1_4 (sigma6 X) hY
  change sigma6 (sigma6 X) 1 4 = _ at t14
  have t15 := HamiltonsCubic.I67AdjugateLaw.sigma_1_5 (sigma6 X) hY
  change sigma6 (sigma6 X) 1 5 = _ at t15
  have t23 := HamiltonsCubic.I67AdjugateLaw.sigma_2_3 (sigma6 X) hY
  change sigma6 (sigma6 X) 2 3 = _ at t23
  have t24 := HamiltonsCubic.I67AdjugateLaw.sigma_2_4 (sigma6 X) hY
  change sigma6 (sigma6 X) 2 4 = _ at t24
  have t25 := HamiltonsCubic.I67AdjugateLaw.sigma_2_5 (sigma6 X) hY
  change sigma6 (sigma6 X) 2 5 = _ at t25
  have t34 := HamiltonsCubic.I67AdjugateLaw.sigma_3_4 (sigma6 X) hY
  change sigma6 (sigma6 X) 3 4 = _ at t34
  have t35 := HamiltonsCubic.I67AdjugateLaw.sigma_3_5 (sigma6 X) hY
  change sigma6 (sigma6 X) 3 5 = _ at t35
  have t45 := HamiltonsCubic.I67AdjugateLaw.sigma_4_5 (sigma6 X) hY
  change sigma6 (sigma6 X) 4 5 = _ at t45
  have hp := HamiltonsCubic.I67Pf6.pf6_eq X hX
  have up : ∀ i j : Fin 6, i < j → sigma6 (sigma6 X) i j = pf6 X * X i j := by
    intro i j hij
    rw [hp]
    fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] at hij ⊢ <;>
      first
        | (exfalso; revert hij; decide)
        | (simp only [t01, t02, t03, t04, t05, t12, t13, t14, t15, t23, t24, t25, t34, t35, t45, s01, s02, s03, s04, s05, s12, s13, s14, s15, s23, s24, s25, s34, s35, s45]; ring)
  have skewAt : ∀ (M : Matrix (Fin 6) (Fin 6) ℝ), IsSkew M → ∀ a b, M b a = -M a b := fun M hM a b => by
    have := congrFun (congrFun hM a) b
    simpa [Matrix.transpose_apply] using this
  ext i j
  rw [Matrix.smul_apply, smul_eq_mul]
  rcases lt_trichotomy i j with h | h | h
  · exact up i j h
  · subst h
    have h1 := skewAt _ hZ i i
    have h2 := skewAt _ hX i i
    rw [show sigma6 (sigma6 X) i i = 0 by linarith, show X i i = 0 by linarith, mul_zero]
  · rw [skewAt _ hZ j i, skewAt _ hX j i, up j i h]; ring

end HamiltonsCubic.L193Statement
