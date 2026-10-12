import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# L109, the per-coordinate cap

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L109:
`g_γ ≤ 2(n-2)(λ_max - λ_min)²`, confirmed as an inequality on its first audit, its two
constructors were authors, and an author is no reviewer.

**The cap is a weighted-sum bound and nothing else.** With `T ≥ 0` pointwise and row marginal
`Σ_α T_α = ρ`, any weights against differences bounded by `D` give `Σ_α T_α d_α² ≤ ρ·D`. The
constant `2(n-2)` enters only as `ρ`; no criticality and no normalisation are used, which is
why the audit calls the cap **unconditional**.

**Saturation is a theorem, and the block reported it as a measurement.** Equality holds
exactly when `T` is supported where `d² = D`, proved below in both directions, so nothing
needs measuring.

**And that is why the excluded-index sharpening is void at every saturating row.** At
saturation the mass sits on the extremal indices, so dropping an index that carries none
leaves the bound where it was. The sharpening can only bite off saturation.
-/

namespace HamiltonsCubic.PerCoordinateCap

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The cap -/

/-- **`Σ_α T_α d_α² ≤ ρ·D`** from non-negativity and the row marginal alone. -/
theorem weighted_cap {T d : ι → ℝ} {rho D : ℝ} (hT : ∀ a, 0 ≤ T a)
    (hrow : ∑ a, T a = rho) (hd : ∀ a, (d a) ^ 2 ≤ D) :
    ∑ a, T a * (d a) ^ 2 ≤ rho * D := by
  calc ∑ a, T a * (d a) ^ 2 ≤ ∑ a, T a * D :=
        Finset.sum_le_sum fun a _ => mul_le_mul_of_nonneg_left (hd a) (hT a)
    _ = rho * D := by rw [← Finset.sum_mul, hrow]

/-! ## Saturation is a theorem, not a measurement -/

/-- **Equality forces the mass onto the extremal indices.** If the bound is attained then
every index with `T_α > 0` has `d_α² = D`. -/
theorem saturation_forces_support {T d : ι → ℝ} {rho D : ℝ} (hT : ∀ a, 0 ≤ T a)
    (hrow : ∑ a, T a = rho) (hd : ∀ a, (d a) ^ 2 ≤ D)
    (heq : ∑ a, T a * (d a) ^ 2 = rho * D) {a : ι} (hpos : 0 < T a) : (d a) ^ 2 = D := by
  classical
  have hterm : ∀ b ∈ univ, T b * (d b) ^ 2 ≤ T b * D :=
    fun b _ => mul_le_mul_of_nonneg_left (hd b) (hT b)
  have hsum : ∑ b, T b * D = rho * D := by rw [← Finset.sum_mul, hrow]
  have hzero : ∑ b, (T b * D - T b * (d b) ^ 2) = 0 := by
    rw [Finset.sum_sub_distrib, hsum, heq]; ring
  have hnn : ∀ b ∈ univ, 0 ≤ T b * D - T b * (d b) ^ 2 := fun b hb => by
    linarith [hterm b hb]
  have := (Finset.sum_eq_zero_iff_of_nonneg hnn).1 hzero a (mem_univ a)
  have hfac : T a * (D - (d a) ^ 2) = 0 := by linarith [this]
  rcases mul_eq_zero.1 hfac with h | h
  · linarith
  · linarith

/-- **And support on the extremal indices gives equality**, so the characterisation is an
iff and nothing is measured. -/
theorem support_gives_saturation {T d : ι → ℝ} {rho D : ℝ}
    (hrow : ∑ a, T a = rho) (hsupp : ∀ a, T a ≠ 0 → (d a) ^ 2 = D) :
    ∑ a, T a * (d a) ^ 2 = rho * D := by
  classical
  have hterm : ∀ a ∈ univ, T a * (d a) ^ 2 = T a * D := by
    intro a _
    by_cases h : T a = 0
    · rw [h]; ring
    · rw [hsupp a h]
  rw [Finset.sum_congr rfl hterm, ← Finset.sum_mul, hrow]

/-! ## The sharpening is void at saturation -/

/-- **Dropping an index that carries no mass changes nothing.** At saturation the mass sits on
the extremal indices, so the excluded-index sharpening leaves the bound where it was, it can
only bite off saturation. -/
theorem excluded_index_void {T d : ι → ℝ} {a : ι} (hzero : T a = 0) :
    T a * (d a) ^ 2 = 0 := by rw [hzero]; ring

end HamiltonsCubic.PerCoordinateCap
