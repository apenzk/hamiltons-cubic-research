import HamiltonsCubic.Results.PhiSphere

set_option linter.style.longLine false

/-!
# `Φ` sends the unit sphere of `Λ²` into a sphere, at every dimension

[conventions.md](../../../findings/conventions.md): *"`tr(ω⁴) + ‖ω ∧ ω‖²_⊥ = 2⟨ω, ω⟩²` at every skew `ω` and every
`n`"*, with `‖·‖_⊥` the multi-index-orthonormal norm on `Λ⁴`. [PhiSphere.lean](PhiSphere.lean) proves it at `n = 4` and
`n = 6`. This file proves it at every `n` by relabelling four-index sums, with no `Λ⁴` and no normal form, in the
`‖·‖_⊥` normalisation. [L204AltBound.lean](L204AltBound.lean)'s `wedge_normSq` is the same identity in the record's
`¼ ∑` norm on `Λ⁴`, `‖ω ∧ ω‖² = 12‖ω‖⁴ − 6 tr ω⁴`, proved earlier by the same relabellings.

- `w4n`: `ω_ab ω_cd − ω_ac ω_bd + ω_ad ω_bc`, so `ω ∧ ω = 2 w4n` and `‖ω ∧ ω‖²_⊥ = 4 ∑_{i<j<k<l} w4n² = (1/6) ∑ w4n²`
  over all index quadruples;
- `sum4_swap_bc`, `sum4_swap_cd`, `sum4_prod`, `trace_pow_four_eq`: the relabellings, and `tr(ω⁴)` as the cyclic sum
  `Q = ∑ ω_ab ω_bc ω_cd ω_da`;
- **`phi_sphere`**: with `S = ∑ ω_ab²`, the three squares each sum to `S²` and the three cross terms to `Q`, `−Q`, `Q`
  under skewness, so `∑ w4n² = 3S² − 6Q` and `tr(ω⁴) + (1/6) ∑ w4n² = S²/2 = 2⟨ω, ω⟩²`.
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {n : ℕ}

/-- The `Λ⁴` component `ω_ab ω_cd − ω_ac ω_bd + ω_ad ω_bc`, half of `(ω ∧ ω)_abcd`, at every dimension. -/
def w4n (w : Matrix (Fin n) (Fin n) ℝ) (a b c d : Fin n) : ℝ := w a b * w c d - w a c * w b d + w a d * w b c

section Relabel
variable (f : Fin n → Fin n → Fin n → Fin n → ℝ)

theorem sum4_swap_bc : ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ b, ∑ c, ∑ d, f a c b d :=
  Finset.sum_congr rfl fun _ _ => Finset.sum_comm

theorem sum4_swap_cd : ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ b, ∑ c, ∑ d, f a b d c :=
  Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm

theorem sum4_prod (g h : Fin n → Fin n → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, g a b * h c d = (∑ a, ∑ b, g a b) * ∑ c, ∑ d, h c d := by
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.mul_sum]

end Relabel

variable {w : Matrix (Fin n) (Fin n) ℝ}

/-- `tr(ω⁴)` as a cyclic four-index sum. -/
theorem trace_pow_four_eq (w : Matrix (Fin n) (Fin n) ℝ) :
    (w ^ 4).trace = ∑ a, ∑ b, ∑ c, ∑ d, w a b * w b c * w c d * w d a := by
  simp only [Matrix.trace, Matrix.diag, pow_succ, pow_zero, Matrix.one_mul, Matrix.mul_apply, Finset.sum_mul]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  rw [Finset.sum_congr rfl fun y _ => Finset.sum_comm]
  rw [Finset.sum_comm]

theorem skew_entry (hw : IsSkew w) (a b : Fin n) : w b a = -w a b := by
  have := congrFun (congrFun hw a) b; simpa [Matrix.transpose_apply] using this

/-- **`tr(ω⁴) + ‖ω ∧ ω‖² = 2⟨ω, ω⟩²` at every dimension**, with `‖ω ∧ ω‖² = (1/6) ∑ w4²` the `Λ⁴` norm of
`ω ∧ ω = 2 w4` over all index quadruples: `Φ` sends the unit sphere of `Λ²` into a sphere. -/
theorem phi_sphere (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsSkew w) :
    (w ^ 4).trace + (1 / 6) * ∑ a, ∑ b, ∑ c, ∑ d, w4n w a b c d ^ 2 = 2 * (inner2 w w) ^ 2 := by
  have hs := skew_entry hw
  set Q := ∑ a, ∑ b, ∑ c, ∑ d, w a b * w b c * w c d * w d a with hQ
  set S := ∑ a, ∑ b, w a b ^ 2 with hS
  have hin : inner2 w w = S / 2 := by
    simp only [inner2, Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, hS]
    rw [Finset.sum_comm]; simp only [sq]; ring
  -- the three squares
  have E1 : ∑ a, ∑ b, ∑ c, ∑ d, (w a b * w c d) ^ 2 = S ^ 2 := by
    simp only [mul_pow]; rw [sum4_prod, sq]
  have E2 : ∑ a, ∑ b, ∑ c, ∑ d, (w a c * w b d) ^ 2 = S ^ 2 := by
    rw [sum4_swap_bc]; simp only [mul_pow]; rw [sum4_prod, sq]
  have E3 : ∑ a, ∑ b, ∑ c, ∑ d, (w a d * w b c) ^ 2 = S ^ 2 := by
    rw [sum4_swap_cd, sum4_swap_bc]; simp only [mul_pow]; rw [sum4_prod, sq]
  -- the three cross terms
  have X1 : ∑ a, ∑ b, ∑ c, ∑ d, w a b * w c d * (w a c * w b d) = Q := by
    rw [sum4_swap_cd, hQ]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
      Finset.sum_congr rfl fun d _ => ?_
    rw [hs c d, hs a d]; ring
  have X2 : ∑ a, ∑ b, ∑ c, ∑ d, w a b * w c d * (w a d * w b c) = -Q := by
    rw [hQ, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [hs a d]; ring
  have X3 : ∑ a, ∑ b, ∑ c, ∑ d, w a c * w b d * (w a d * w b c) = Q := by
    rw [sum4_swap_bc, hQ]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
      Finset.sum_congr rfl fun d _ => ?_
    rw [hs c b, hs a d]; ring
  have hexp : ∀ a b c d, w4n w a b c d ^ 2 = (w a b * w c d) ^ 2 + (w a c * w b d) ^ 2 + (w a d * w b c) ^ 2
      - 2 * (w a b * w c d * (w a c * w b d)) + 2 * (w a b * w c d * (w a d * w b c))
      - 2 * (w a c * w b d * (w a d * w b c)) := fun a b c d => by unfold w4n; ring
  have hsum : ∑ a, ∑ b, ∑ c, ∑ d, w4n w a b c d ^ 2 = 3 * S ^ 2 - 6 * Q := by
    simp only [hexp, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
    rw [E1, E2, E3, X1, X2, X3]; ring
  rw [trace_pow_four_eq, ← hQ, hsum, hin]; ring

end HamiltonsCubic.RealLayer
