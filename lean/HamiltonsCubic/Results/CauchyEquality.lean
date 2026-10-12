import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# Cauchy–Schwarz with its equality case, the last owed item this layer can reach

[L47](L47.lean) records as owed *"the Cauchy–Schwarz step, the implication to `‖W‖² ≥ 1/6`, and
the equality case"*, and [L108](L108.lean) *"the Cauchy–Schwarz step itself"*. The inequality is
`Finset.sum_mul_sq_le_sq_mul_sq`; **the equality case is not in the library and is proved here**.

**The route is the discriminant, made constructive.** For any `t`, `Σ(f + tg)² ≥ 0`. Choosing
`t = -(Σfg)/(Σg²)` makes that sum exactly `Σf² - (Σfg)²/Σg²`, which equality in Cauchy–Schwarz
sends to zero. A vanishing sum of squares is termwise zero, so `f = -t·g` **pointwise on the
index set**, proportionality, with the constant exhibited rather than merely asserted to exist.

**What this closes and what it does not.** Both entries name this step and it is now available in
full. `L47`'s other two items, the implication to `‖W‖² ≥ 1/6` and what the equality case says
about `W`, remain: they are about the tensors the sums come from, not about the inequality.
-/

namespace HamiltonsCubic.CauchyEquality

open Finset

variable {ι : Type*} [DecidableEq ι]

/-! ## The inequality -/

/-- **Cauchy–Schwarz on a `Finset`**, from the library. -/
theorem cauchy_schwarz (s : Finset ι) (f g : ι → ℝ) :
    (∑ i ∈ s, f i * g i) ^ 2 ≤ (∑ i ∈ s, f i ^ 2) * ∑ i ∈ s, g i ^ 2 :=
  Finset.sum_mul_sq_le_sq_mul_sq s f g

/-! ## The equality case -/

/-- **The quadratic identity the proof turns on.** For every `t`,
`Σ(f + tg)² = Σf² + 2tΣfg + t²Σg²`. -/
theorem expand (s : Finset ι) (f g : ι → ℝ) (t : ℝ) :
    ∑ i ∈ s, (f i + t * g i) ^ 2
      = (∑ i ∈ s, f i ^ 2) + 2 * t * (∑ i ∈ s, f i * g i) + t ^ 2 * ∑ i ∈ s, g i ^ 2 := by
  rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **Equality forces proportionality, with the constant exhibited.** If Cauchy–Schwarz is tight
and `g` is not null on `s`, then `f = -t·g` pointwise for `t = -(Σfg)/(Σg²)`. -/
theorem equality_forces_proportional (s : Finset ι) (f g : ι → ℝ)
    (hg : (∑ i ∈ s, g i ^ 2) ≠ 0)
    (heq : (∑ i ∈ s, f i * g i) ^ 2 = (∑ i ∈ s, f i ^ 2) * ∑ i ∈ s, g i ^ 2) :
    ∀ i ∈ s, f i + (-(∑ i ∈ s, f i * g i) / (∑ i ∈ s, g i ^ 2)) * g i = 0 := by
  set A := ∑ i ∈ s, f i ^ 2 with hA
  set B := ∑ i ∈ s, f i * g i with hB
  set C := ∑ i ∈ s, g i ^ 2 with hC
  set t : ℝ := -B / C with ht
  have hzero : ∑ i ∈ s, (f i + t * g i) ^ 2 = 0 := by
    rw [expand s f g t, ← hA, ← hB, ← hC, ht]
    field_simp
    nlinarith [heq]
  have hnn : ∀ i ∈ s, 0 ≤ (f i + t * g i) ^ 2 := fun i _ => sq_nonneg _
  intro i hi
  have := (Finset.sum_eq_zero_iff_of_nonneg hnn).1 hzero i hi
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.1 this

/-- **So the equality case is proportionality on the index set**, the constant is
`(Σfg)/(Σg²)`, and it is produced rather than asserted to exist. -/
theorem equality_gives_constant (s : Finset ι) (f g : ι → ℝ)
    (hg : (∑ i ∈ s, g i ^ 2) ≠ 0)
    (heq : (∑ i ∈ s, f i * g i) ^ 2 = (∑ i ∈ s, f i ^ 2) * ∑ i ∈ s, g i ^ 2) :
    ∃ c : ℝ, ∀ i ∈ s, f i = c * g i := by
  refine ⟨(∑ i ∈ s, f i * g i) / (∑ i ∈ s, g i ^ 2), fun i hi => ?_⟩
  have h := equality_forces_proportional s f g hg heq i hi
  have : (-(∑ i ∈ s, f i * g i) / (∑ i ∈ s, g i ^ 2))
      = -((∑ i ∈ s, f i * g i) / (∑ i ∈ s, g i ^ 2)) := by ring
  rw [this] at h
  linarith [h]

end HamiltonsCubic.CauchyEquality
