import Mathlib

set_option linter.style.longLine false

/-!
# L155 and L154 (i) in a frame: `X_inv = 0` exactly on the graded subalgebras

[findings/bounds.md](../../../findings/bounds.md), Lemma L155: for a symmetric `W ≠ 0` on `Λ²`,
`X_inv = |W|^# − P₊W^#P₊ + P₋W^#P₋` vanishes **iff** `𝔭 = ran W₊`, `𝔪 = ran W₋` satisfy
`[𝔭,𝔭] ⊆ 𝔭`, `[𝔭,𝔪] ⊆ 𝔪`, `[𝔪,𝔪] ⊆ 𝔭`. And Lemma L154 (i): `tr X_inv = 0` iff `X_inv = 0`.

**In an orthonormal eigenframe `W = ∑ λ_α v_α v_αᵀ`**, rank-one positivity
`v vᵀ # w wᵀ = ½ [v,w][v,w]ᵀ` gives `W^# = ½ ∑ λ_α λ_β u_{αβ} u_{αβ}ᵀ` with `u_{αβ} = [v_α, v_β]`,
so in the frame `X_inv` has entries
`X_{γδ} = ½ ∑_{α,β} ω_{αβγ} ω_{αβδ} (|λ_αλ_β| − λ_αλ_β [γ,δ ∈ +] + λ_αλ_β [γ,δ ∈ −])`,
`ω_{αβγ} = ⟨[v_α,v_β], v_γ⟩`. **This file proves the lemmas for that matrix** (`Xinv`), over any
finite frame and any real array `ω`:

- `Xinv_diag_nonneg`: every diagonal entry is a sum of squares with nonnegative weights;
- `graded_of_diag_zero`: the diagonal vanishing forces the grading `Graded`, in which a nonzero
  `ω_{αβγ}` with `λ_αλ_β ≠ 0` has `λ_γ` of the sign of `λ_αλ_β`, which is the three inclusions and
  the closure into `ker W` at once;
- `Xinv_zero_of_graded`: the grading makes every entry vanish;
- `L155_frame`: **`X_inv = 0` iff `Graded`**, and `L154_frame`: **`tr X_inv = 0` iff `X_inv = 0`**.

The frame expansion, that the record's operator `X_inv` has these entries, is
[XinvFrame.lean](XinvFrame.lean)'s `XinvRec_eq`.
-/

namespace HamiltonsCubic.L155Frame

open Finset

variable {κ : Type*} [Fintype κ]

/-- The sign weight at `(γ, δ)` for the pair product `x = λ_αλ_β`. -/
noncomputable def wt (lam : κ → ℝ) (x : ℝ) (γ δ : κ) : ℝ :=
  |x| - x * (if 0 < lam γ ∧ 0 < lam δ then 1 else 0) + x * (if lam γ < 0 ∧ lam δ < 0 then 1 else 0)

/-- **`X_inv` in the eigenframe.** -/
noncomputable def Xinv (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) (γ δ : κ) : ℝ :=
  (1 / 2) * ∑ α, ∑ β, ω α β γ * ω α β δ * wt lam (lam α * lam β) γ δ

/-- **The grading**: a nonzero bracket coefficient between nonzero eigendirections lands on an
eigendirection of the sign of the product. -/
def Graded (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) : Prop :=
  ∀ α β γ, ω α β γ ≠ 0 → lam α ≠ 0 → lam β ≠ 0 →
    (0 < lam α * lam β → 0 < lam γ) ∧ (lam α * lam β < 0 → lam γ < 0)

/-- On the diagonal each weight is nonnegative. -/
theorem wt_diag_nonneg (lam : κ → ℝ) (x : ℝ) (γ : κ) : 0 ≤ wt lam x γ γ := by
  unfold wt
  by_cases hp : 0 < lam γ
  · have hn : ¬(lam γ < 0) := not_lt.mpr hp.le
    simp only [hp, and_self, if_true, hn, if_false, mul_one, mul_zero, add_zero]
    linarith [le_abs_self x]
  · by_cases hn : lam γ < 0
    · simp only [hp, and_self, if_false, hn, if_true, mul_one, mul_zero, sub_zero]
      linarith [neg_abs_le x]
    · simp only [hp, hn, and_self, if_false, mul_zero, sub_zero, add_zero]
      exact abs_nonneg x

/-- **Every diagonal entry of `X_inv` is nonnegative.** -/
theorem Xinv_diag_nonneg (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) (γ : κ) : 0 ≤ Xinv lam ω γ γ := by
  unfold Xinv
  refine mul_nonneg (by norm_num) (Finset.sum_nonneg fun α _ => Finset.sum_nonneg fun β _ => ?_)
  exact mul_nonneg (mul_self_nonneg _) (wt_diag_nonneg lam _ γ)

/-- **The diagonal vanishing forces the grading.** -/
theorem graded_of_diag_zero (lam : κ → ℝ) (ω : κ → κ → κ → ℝ)
    (h : ∀ γ, Xinv lam ω γ γ = 0) : Graded lam ω := by
  intro α β γ hω ha hb
  have hterm : ω α β γ * ω α β γ * wt lam (lam α * lam β) γ γ = 0 := by
    have h0 := h γ
    unfold Xinv at h0
    have hs : ∑ α, ∑ β, ω α β γ * ω α β γ * wt lam (lam α * lam β) γ γ = 0 := by linarith
    have hnn : ∀ α' ∈ (Finset.univ : Finset κ),
        0 ≤ ∑ β', ω α' β' γ * ω α' β' γ * wt lam (lam α' * lam β') γ γ :=
      fun α' _ => Finset.sum_nonneg fun β' _ =>
        mul_nonneg (mul_self_nonneg _) (wt_diag_nonneg lam _ γ)
    have hrow := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hs α (Finset.mem_univ _)
    exact (Finset.sum_eq_zero_iff_of_nonneg fun β' _ =>
      mul_nonneg (mul_self_nonneg _) (wt_diag_nonneg lam _ γ)).mp hrow β (Finset.mem_univ _)
  have hw0 : wt lam (lam α * lam β) γ γ = 0 := by
    rcases mul_eq_zero.mp hterm with h1 | h1
    · exact absurd (mul_self_eq_zero.mp h1) hω
    · exact h1
  set x := lam α * lam β
  unfold wt at hw0
  constructor
  · intro hx
    by_contra hc
    push Not at hc
    have hnp : ¬(0 < lam γ) := not_lt.mpr hc
    by_cases hn : lam γ < 0
    · simp only [hnp, and_self, if_false, hn, if_true, mul_zero, sub_zero, mul_one,
        abs_of_pos hx] at hw0
      linarith
    · simp only [hnp, hn, and_self, if_false, mul_zero, sub_zero, add_zero, abs_of_pos hx] at hw0
      linarith
  · intro hx
    by_contra hc
    push Not at hc
    have hnn : ¬(lam γ < 0) := not_lt.mpr hc
    by_cases hp : 0 < lam γ
    · simp only [hp, and_self, if_true, hnn, if_false, mul_one, mul_zero, add_zero,
        abs_of_neg hx] at hw0
      linarith
    · simp only [hp, hnn, and_self, if_false, mul_zero, sub_zero, add_zero, abs_of_neg hx] at hw0
      linarith

/-- **The grading makes every entry vanish.** -/
theorem Xinv_zero_of_graded (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) (hg : Graded lam ω) (γ δ : κ) :
    Xinv lam ω γ δ = 0 := by
  unfold Xinv
  rw [Finset.sum_eq_zero fun α _ => Finset.sum_eq_zero fun β _ => ?_, mul_zero]
  by_cases hγ : ω α β γ = 0
  · rw [hγ]; ring
  by_cases hδ : ω α β δ = 0
  · rw [hδ]; ring
  by_cases ha : lam α = 0
  · simp [wt, ha]
  by_cases hb : lam β = 0
  · simp [wt, hb]
  have hx : lam α * lam β ≠ 0 := mul_ne_zero ha hb
  have gγ := hg α β γ hγ ha hb
  have gδ := hg α β δ hδ ha hb
  unfold wt
  rcases lt_or_gt_of_ne hx with hneg | hpos
  · have h1 := gγ.2 hneg
    have h2 := gδ.2 hneg
    have n1 : ¬(0 < lam γ ∧ 0 < lam δ) := fun h => absurd h.1 (not_lt.mpr h1.le)
    rw [if_neg n1, if_pos ⟨h1, h2⟩, abs_of_neg hneg]; ring
  · have h1 := gγ.1 hpos
    have h2 := gδ.1 hpos
    have n1 : ¬(lam γ < 0 ∧ lam δ < 0) := fun h => absurd h.1 (not_lt.mpr h1.le)
    rw [if_pos ⟨h1, h2⟩, if_neg n1, abs_of_pos hpos]; ring

/-- **L155 IN THE FRAME**: `X_inv = 0` iff the eigenspaces are graded. -/
theorem L155_frame (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) :
    (∀ γ δ, Xinv lam ω γ δ = 0) ↔ Graded lam ω :=
  ⟨fun h => graded_of_diag_zero lam ω fun γ => h γ γ, fun hg => Xinv_zero_of_graded lam ω hg⟩

/-- **L154 (i) IN THE FRAME**: `tr X_inv = 0` iff `X_inv = 0`. -/
theorem L154_frame (lam : κ → ℝ) (ω : κ → κ → κ → ℝ) :
    ∑ γ, Xinv lam ω γ γ = 0 ↔ ∀ γ δ, Xinv lam ω γ δ = 0 := by
  constructor
  · intro h
    have hd : ∀ γ, Xinv lam ω γ γ = 0 := fun γ =>
      (Finset.sum_eq_zero_iff_of_nonneg fun γ' _ => Xinv_diag_nonneg lam ω γ').mp h γ
        (Finset.mem_univ _)
    exact Xinv_zero_of_graded lam ω (graded_of_diag_zero lam ω hd)
  · intro h
    exact Finset.sum_eq_zero fun γ _ => h γ γ

end HamiltonsCubic.L155Frame
