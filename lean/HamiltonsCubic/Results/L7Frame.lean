import HamiltonsCubic.Results.L155Frame

set_option linter.style.longLine false

/-!
# L7 in a frame: the slack is `½ tr X_inv`, so the bound holds and its equality class is graded

[findings/bounds.md](../../../findings/bounds.md), Lemma L7: at a critical point `Q(W) = θW`,
tracing against `Π₋` gives `θ tr W₋ + tr W₋² = −tr(Π₋ W^#)`, and dropping three nonnegative terms
leaves `≤ 2 tr(W₊ # W₋)`. [r699](../../../reviews/REVIEW_r699.md) identifies the slack as
`½ tr X_inv`.

**In an orthonormal eigenframe** `W = ∑ λ_α v_α v_αᵀ` with `ω_{αβγ} = ⟨[v_α, v_β], v_γ⟩`
([L155Frame.lean](L155Frame.lean)), rank-one positivity gives
`⟨W^# v_γ, v_γ⟩ = ½ ∑_{α,β} λ_α λ_β ω_{αβγ}²` and
`2 tr(W₊ # W₋) = ∑_γ ∑_{λ_α > 0 > λ_β} λ_α |λ_β| ω_{αβγ}²` (`cross2`). **This file proves, over any
finite frame and any real array `ω` with `ω_{αβγ}² = ω_{βαγ}²`:**

- `slack_eq`: **if the diagonal criticality equations** `½ ∑ λ_α λ_β ω_{αβγ}² = θ λ_γ − λ_γ²` hold,
  then `cross2 − θ tr W₋ − tr W₋² = ½ tr X_inv`, with `tr W₋ = ∑_{λ_γ<0} |λ_γ|` and
  `tr W₋² = ∑_{λ_γ<0} λ_γ²`. The kernel directions balance exactly because criticality at `λ_γ = 0`
  equates their same-sign and mixed-sign masses;
- `L7_frame`: **`θ tr W₋ + tr W₋² ≤ 2 tr(W₊ # W₋)`**, from `Xinv_diag_nonneg`;
- `L7_equality_frame`: **equality iff the frame is graded** (`Graded`), by L154 (i) and L155.

**Not typed here**: the identification `2 tr(W₊ # W₋) = ‖Ric(W₋)‖² + 6δ²` by polarising L15, which is
the last step of the record's proof.
-/

namespace HamiltonsCubic.L7Frame

open Finset HamiltonsCubic.L155Frame

variable {κ : Type*} [Fintype κ]

/-- `2 tr(W₊ # W₋)` in the frame. -/
noncomputable def cross2 (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) : ℝ :=
  ∑ γ, ∑ α, ∑ β, (if 0 < lam α ∧ lam β < 0 then lam α * (-lam β) else 0) * ω α β γ ^ 2

/-- `tr W₋ = ∑_{λ<0} |λ|`. -/
noncomputable def negTr (lam : κ → ℝ) : ℝ := ∑ γ, if lam γ < 0 then -lam γ else 0

/-- `tr W₋² = ∑_{λ<0} λ²`. -/
noncomputable def negTr2 (lam : κ → ℝ) : ℝ := ∑ γ, if lam γ < 0 then lam γ ^ 2 else 0

/-- The mixed-sign weight, both orders. -/
noncomputable def mixW (x y : ℝ) : ℝ :=
  (if 0 < x ∧ y < 0 then x * (-y) else 0) + (if x < 0 ∧ 0 < y then (-x) * y else 0)

/-- `|xy| − xy` is twice the mixed weight. -/
theorem abs_sub_eq_mix (x y : ℝ) : |x * y| - x * y = 2 * mixW x y := by
  unfold mixW
  rcases lt_trichotomy x 0 with hx | hx | hx <;> rcases lt_trichotomy y 0 with hy | hy | hy
  · have : 0 < x * y := mul_pos_of_neg_of_neg hx hy
    simp [abs_of_pos this, not_lt.mpr hx.le, not_lt.mpr hy.le]
  · subst hy; simp
  · have : x * y < 0 := mul_neg_of_neg_of_pos hx hy
    simp [abs_of_neg this, hx, hy, not_lt.mpr hx.le]; ring
  · subst hx; simp
  · subst hx; simp
  · subst hx; simp
  · have : x * y < 0 := mul_neg_of_pos_of_neg hx hy
    simp [abs_of_neg this, hx, hy, not_lt.mpr hy.le]; ring
  · subst hy; simp
  · have : 0 < x * y := mul_pos hx hy
    simp [abs_of_pos this, not_lt.mpr hx.le, not_lt.mpr hy.le]

/-- The diagonal entry of `X_inv`, rewritten by the sign of `λ_γ`. -/
theorem Xinv_diag_eq (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) (γ : κ) :
    Xinv lam ω γ γ = (1 / 2) * ∑ α, ∑ β, ω α β γ ^ 2 *
      (|lam α * lam β| - (if 0 < lam γ then lam α * lam β else 0)
        + (if lam γ < 0 then lam α * lam β else 0)) := by
  unfold Xinv wt
  congr 1
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  simp only [and_self, sq]
  split_ifs <;> ring

/-- **THE SLACK IDENTITY**: under the diagonal criticality equations,
`2 tr(W₊ # W₋) − θ tr W₋ − tr W₋² = ½ tr X_inv`. -/
theorem slack_eq (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) (θ : ℝ)
    (hω : ∀ α β γ, ω β α γ ^ 2 = ω α β γ ^ 2)
    (hcrit : ∀ γ, (1 / 2) * ∑ α, ∑ β, lam α * lam β * ω α β γ ^ 2 = θ * lam γ - lam γ ^ 2) :
    cross2 lam ω - θ * negTr lam - negTr2 lam = (1 / 2) * ∑ γ, Xinv lam ω γ γ := by
  -- per `γ`: both sides as sums over `α, β`
  set A : κ → ℝ := fun γ => ∑ α, ∑ β, |lam α * lam β| * ω α β γ ^ 2 with hA
  set B : κ → ℝ := fun γ => ∑ α, ∑ β, lam α * lam β * ω α β γ ^ 2 with hB
  set Cc : κ → ℝ := fun γ => ∑ α, ∑ β,
    (if 0 < lam α ∧ lam β < 0 then lam α * (-lam β) else 0) * ω α β γ ^ 2 with hC
  -- the mixed mass is `A − B`, counted as twice one order
  have hmix : ∀ γ, A γ - B γ = 4 * Cc γ := by
    intro γ
    have e1 : A γ - B γ = ∑ α, ∑ β, 2 * mixW (lam α) (lam β) * ω α β γ ^ 2 := by
      simp only [hA, hB, ← Finset.sum_sub_distrib]
      refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
      rw [← sub_mul, abs_sub_eq_mix]
    have e2 : ∑ α, ∑ β, (if lam α < 0 ∧ 0 < lam β then (-lam α) * lam β else 0) * ω α β γ ^ 2
        = Cc γ := by
      rw [Finset.sum_comm]
      simp only [hC]
      refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
      rw [hω β α γ]
      split_ifs with h1 h2 h2
      · ring
      · exact absurd ⟨h1.2, h1.1⟩ h2
      · exact absurd ⟨h2.2, h2.1⟩ h1
      · ring
    rw [e1]
    unfold mixW
    simp only [mul_add, add_mul, Finset.sum_add_distrib]
    have e3 : ∑ α, ∑ β, 2 * (if 0 < lam α ∧ lam β < 0 then lam α * -lam β else 0) * ω α β γ ^ 2
        = 2 * Cc γ := by
      simp only [hC, Finset.mul_sum]; refine Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
    have e4 : ∑ α, ∑ β, 2 * (if lam α < 0 ∧ 0 < lam β then -lam α * lam β else 0) * ω α β γ ^ 2
        = 2 * Cc γ := by
      rw [← e2, Finset.mul_sum]
      refine Finset.sum_congr rfl fun _ _ => by rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun _ _ => by ring
    rw [e3, e4]; ring
  -- the diagonal entry by the sign of `λ_γ`
  have hX : ∀ γ, Xinv lam ω γ γ = (1 / 2) * (A γ - (if 0 < lam γ then B γ else 0)
      + (if lam γ < 0 then B γ else 0)) := by
    intro γ
    rw [Xinv_diag_eq]
    congr 1
    simp only [hA, hB]
    split_ifs <;> simp only [add_zero, sub_zero, ← Finset.sum_sub_distrib,
      ← Finset.sum_add_distrib] <;>
      refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => by ring
  -- criticality at each `γ`
  have hB' : ∀ γ, B γ = 2 * (θ * lam γ - lam γ ^ 2) := fun γ => by
    have := hcrit γ; simp only [hB]; linarith
  -- assemble per `γ`
  have key : ∀ γ, Cc γ - θ * (if lam γ < 0 then -lam γ else 0) - (if lam γ < 0 then lam γ ^ 2 else 0)
      = (1 / 2) * Xinv lam ω γ γ := by
    intro γ
    rw [hX γ]
    have hm := hmix γ
    have hb := hB' γ
    rcases lt_trichotomy (lam γ) 0 with hl | hl | hl
    · simp only [hl, if_true, not_lt.mpr hl.le, if_false]
      nlinarith [hm, hb]
    · simp only [hl, lt_irrefl, if_false] at *
      have : B γ = 0 := by rw [hb]; ring
      nlinarith [hm, this]
    · simp only [hl, if_true, not_lt.mpr hl.le, if_false]
      nlinarith [hm, hb]
  unfold cross2 negTr negTr2
  rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun γ _ => key γ

/-- **L7 IN THE FRAME**: `θ tr W₋ + tr W₋² ≤ 2 tr(W₊ # W₋)`. -/
theorem L7_frame (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) (θ : ℝ)
    (hω : ∀ α β γ, ω β α γ ^ 2 = ω α β γ ^ 2)
    (hcrit : ∀ γ, (1 / 2) * ∑ α, ∑ β, lam α * lam β * ω α β γ ^ 2 = θ * lam γ - lam γ ^ 2) :
    θ * negTr lam + negTr2 lam ≤ cross2 lam ω := by
  have h := slack_eq lam ω θ hω hcrit
  have hnn : 0 ≤ ∑ γ, Xinv lam ω γ γ := Finset.sum_nonneg fun γ _ => Xinv_diag_nonneg lam ω γ
  linarith

/-- **L7's EQUALITY CLASS IN THE FRAME**: equality iff the frame is graded. -/
theorem L7_equality_frame (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) (θ : ℝ)
    (hω : ∀ α β γ, ω β α γ ^ 2 = ω α β γ ^ 2)
    (hcrit : ∀ γ, (1 / 2) * ∑ α, ∑ β, lam α * lam β * ω α β γ ^ 2 = θ * lam γ - lam γ ^ 2) :
    θ * negTr lam + negTr2 lam = cross2 lam ω ↔ Graded lam ω := by
  have h := slack_eq lam ω θ hω hcrit
  rw [← L155_frame, ← L154_frame]
  constructor
  · intro heq; linarith
  · intro htr; linarith

end HamiltonsCubic.L7Frame
