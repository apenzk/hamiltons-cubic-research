import Mathlib
import HamiltonsCubic.Results.L52Frame
import HamiltonsCubic.Results.L52Remarks
import HamiltonsCubic.Results.L53CPm
import HamiltonsCubic.Results.L52
import HamiltonsCubic.Results.L50Traces

set_option linter.style.longLine false

/-!
# L52's one-line bound at the record's objects, and in its `θ` form

[L52Remarks.lean](L52Remarks.lean)'s `one_line_bound` is stated on abstract spectra
(`μ ≤ M₊`, `∑ μ² = 1`, `ω ≥ -m`, `∑ ω² = 3`). The L52 row owes *"the one-line bound in its $\theta$
form at the record's objects, `one_line_bound` composed with `L50_bispectral` and the trace lemmas as in
L52Frame"*. This file composes them as [L52Frame.lean](L52Frame.lean) composes the matrix bound:

* `one_line_record`: at a unit `R` that is linear, preserves and is self-adjoint on bivectors and is
  first-Bianchi, with `μ ≤ M₊` on the spectrum of `M` and `ω ≥ -m` on that of `W̊`,
  `P(R) ≤ (3/2)(M₊ + m)`;
* `one_line_theta`: at a critical such `R`, `Q(R) = θR`, the same bound reads `θ ≤ (3/2)(M₊ + m)`;
* `one_line_value`: the same bound on the value `θ = P/‖W‖³` at every unit `R`, critical or not;
* `one_line_strict`: at a Ricci-flat unit `R` the bound is strict, `P < (3/2)(M₊ + m)`, the equality step
  `μ_i ∈ {0, M₊}` with `∑ μ = 0` feeding L52's `strictly_loose` ([r1677](../../../reviews/REVIEW_r1677.md) G7).
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- **The one-line bound at the record's objects**: `P ≤ (3/2)(M₊ + m)` at a unit first-Bianchi `R`. -/
theorem one_line_record (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bmat_isHermitian R hR hskew hsym).eigenvalues j) :
    Pcubic R ≤ (3 / 2) * (Mp + m) := by
  have h := HamiltonsCubic.L52Remarks.one_line_bound _ _ Mp m hμ hω
    (by rw [sum_mu_sq R hR hskew hsym, hunit])
    (by rw [sum_omega_sq R hR hskew hsym hB, hunit]; ring)
  rw [sum_mu_cube R hR hskew hsym, sum_omega_cube R hR hskew hsym] at h
  rw [L50Spectra.L50_bispectral R hR hskew hsym hB]
  exact h

/-- **In its `θ` form**: at a critical unit `R`, `θ ≤ (3/2)(M₊ + m)`. -/
theorem one_line_theta (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (θ : ℝ)
    (hc : IsCritical R θ) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bmat_isHermitian R hR hskew hsym).eigenvalues j) :
    θ ≤ (3 / 2) * (Mp + m) := by
  have h := one_line_record R hR hskew hsym hB hunit Mp m hμ hω
  rw [HamiltonsCubic.L70CPm.Pcubic_eq_innerOp_Qop, HamiltonsCubic.L70CPm.innerOp_Qop_of_critical R θ hc,
    hunit, mul_one] at h
  exact h

/-- **The value reading** ([r1726](../../../reviews/REVIEW_r1726.md) G1): the record's `θ = P/‖W‖³` at every
unit `R`, critical or not, satisfies `θ ≤ (3/2)(M₊ + m)`, through Families' `theta_of_unit`. -/
theorem one_line_value (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bmat_isHermitian R hR hskew hsym).eigenvalues j) :
    theta R ≤ (3 / 2) * (Mp + m) := by
  rw [HamiltonsCubic.FamilyLayer.theta_of_unit R hunit]
  exact one_line_record R hR hskew hsym hB hunit Mp m hμ hω

/-- **Strictly loose at every unit Weyl tensor**, the record's *"the strict one-line bound"*
([bispectral.md](../../../findings/bispectral.md) L52, and [r1677](../../../reviews/REVIEW_r1677.md) G7): at a
Ricci-flat unit `R`, `P < (3/2)(M₊ + m)`. Equality would make `μ³ ≤ M₊ μ²` tight termwise, so every
`μ_i ∈ {0, M₊}`, and with `∑ μ = 0` (L50Traces' `sum_mu_zero`) and `∑ μ² = 1` that is L52's
`strictly_loose`. -/
theorem one_line_strict (hB : ∀ i j k l, bianchi R i j k l = 0) (hRic : ∀ a b, Ric R a b = 0)
    (hunit : normSq R = 1) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bmat_isHermitian R hR hskew hsym).eigenvalues j) :
    Pcubic R < (3 / 2) * (Mp + m) := by
  set μ := (Mpair_isHermitian R hR hskew hsym).eigenvalues with hμdef
  set ω := (Bmat_isHermitian R hR hskew hsym).eigenvalues with hωdef
  have hμ2 : ∑ j, μ j ^ 2 = 1 := by rw [hμdef, sum_mu_sq R hR hskew hsym, hunit]
  have hω2 : ∑ j, ω j ^ 2 = 3 := by rw [hωdef, sum_omega_sq R hR hskew hsym hB, hunit]; ring
  have hμ0 : ∑ j, μ j = 0 := sum_mu_zero R hR hskew hsym hRic
  have hP : Pcubic R = (3 / 2) * ∑ j, μ j ^ 3 - (1 / 2) * ∑ j, ω j ^ 3 := by
    rw [L50Spectra.L50_bispectral R hR hskew hsym hB, ← sum_mu_cube R hR hskew hsym,
      ← sum_omega_cube R hR hskew hsym]
  have t1 : ∀ j, 0 ≤ Mp * μ j ^ 2 - μ j ^ 3 := fun j => by nlinarith [sq_nonneg (μ j), hμ j]
  have t2 : ∀ j, 0 ≤ m * ω j ^ 2 + ω j ^ 3 := fun j => by nlinarith [sq_nonneg (ω j), hω j]
  have s1 : 0 ≤ ∑ j, (Mp * μ j ^ 2 - μ j ^ 3) := Finset.sum_nonneg fun j _ => t1 j
  have s2 : 0 ≤ ∑ j, (m * ω j ^ 2 + ω j ^ 3) := Finset.sum_nonneg fun j _ => t2 j
  have e1 : ∑ j, (Mp * μ j ^ 2 - μ j ^ 3) = Mp - ∑ j, μ j ^ 3 := by
    rw [Finset.sum_sub_distrib, ← Finset.mul_sum, hμ2, mul_one]
  have e2 : ∑ j, (m * ω j ^ 2 + ω j ^ 3) = 3 * m + ∑ j, ω j ^ 3 := by
    rw [Finset.sum_add_distrib, ← Finset.mul_sum, hω2]; ring
  rw [hP]
  by_contra hge
  push Not at hge
  have z1 : ∑ j, (Mp * μ j ^ 2 - μ j ^ 3) = 0 := by linarith
  have hz := (Finset.sum_eq_zero_iff_of_nonneg fun j _ => t1 j).mp z1
  have hval : ∀ j, μ j = 0 ∨ μ j = Mp := by
    intro j
    have h := hz j (Finset.mem_univ _)
    have : μ j ^ 2 * (Mp - μ j) = 0 := by linarith
    rcases mul_eq_zero.mp this with h' | h'
    · left; exact pow_eq_zero_iff (by norm_num) |>.mp h'
    · right; linarith
  exact HamiltonsCubic.SharedFrame.strictly_loose hval hμ0 hμ2

end HamiltonsCubic.SecondKind
