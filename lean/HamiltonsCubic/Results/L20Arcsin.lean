import HamiltonsCubic.Results.L20Statement

set_option linter.style.longLine false

/-!
# L20's radius is `arcsin s*`, and the expansion step as its own statement

[findings/route-a.md](../../../findings/route-a.md), Lemma L20. [TubeRadius.lean](TubeRadius.lean) works over `ℚ`, where
the cubic `s³ + s² + s - 1` has no root, and brackets where the real root lies. [L20Statement.lean](L20Statement.lean)
runs the chain at `sin φ ≤ 0.54368`. **This file builds the real root `s*` and proves the identifications the L20 row
owed**:

* **`expansion_step`**: `m = cos³φ + 3 cos φ sin²φ α + sin³φ γ` with `α ≤ 1/3`, `γ ≤ m` and `cos φ, sin φ ≥ 0` gives
  `m ≤ cos φ + m sin³φ`, the step [L20Statement.lean](L20Statement.lean)'s `max_le_one_of_sin_le` runs inside its proof;
* **`psi_one_iff_cubic`**: for `s ∈ (0, 1)`, `√(1 - s²) + s³ = 1` exactly when `s³ + s² + s - 1 = 0`, squaring giving
  `s²(s - 1)(s³ + s² + s - 1) = 0`;
* **`radius_is_arcsin`**: at `φ = arcsin s`, `cos φ + sin³ φ = 1` (`ψ(φ) = 1`) exactly when `s` is the cubic's root;
* **`sStar_exists_unique`**, **`sStar`**, **`radius_eq_sStar`**: the cubic has exactly one real root `s*` in `(0, 1)`,
  and `ψ(arcsin s) = 1` there exactly at `s = s*`, so the radius is `arcsin s*`;
* **`cubic_lt`**, **`psi_le_one_iff`**: the exact reduction, `√(1 - s²) + s³ ≤ 1` on `(0, 1)` exactly when `s ≤ s*`;
* **`max_le_one_exact`**: the chain at the exact radius, `m ≤ 1` whenever `0 < sin φ ≤ s*`.
-/

namespace HamiltonsCubic.L20Statement

/-- **The expansion step.** -/
theorem expansion_step {m φ α γ : ℝ} (hcos : 0 ≤ Real.cos φ) (hsin : 0 ≤ Real.sin φ)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) : m ≤ Real.cos φ + m * Real.sin φ ^ 3 := by
  have hpyth : Real.cos φ ^ 2 = 1 - Real.sin φ ^ 2 := by
    have := Real.sin_sq_add_cos_sq φ; linarith
  have h1 : 3 * Real.cos φ * Real.sin φ ^ 2 * α ≤ 3 * Real.cos φ * Real.sin φ ^ 2 * (1 / 3) := by
    have : (0:ℝ) ≤ 3 * Real.cos φ * Real.sin φ ^ 2 := by positivity
    nlinarith
  have hsin3 : 0 ≤ Real.sin φ ^ 3 := by positivity
  have h2 : Real.sin φ ^ 3 * γ ≤ Real.sin φ ^ 3 * m := by nlinarith
  have h3 : Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * (1 / 3) = Real.cos φ := by
    nlinarith [hpyth]
  nlinarith

/-- **`ψ(φ) = 1` in the sine variable is the cubic.** -/
theorem psi_one_iff_cubic {s : ℝ} (h0 : 0 < s) (h1 : s < 1) :
    Real.sqrt (1 - s ^ 2) + s ^ 3 = 1 ↔ s ^ 3 + s ^ 2 + s - 1 = 0 := by
  have hs3 : 0 ≤ 1 - s ^ 3 := by
    have : s ^ 3 ≤ 1 := pow_le_one₀ h0.le h1.le
    linarith
  have hs2 : 0 ≤ 1 - s ^ 2 := by nlinarith
  constructor
  · intro h
    have hsq : Real.sqrt (1 - s ^ 2) = 1 - s ^ 3 := by linarith
    have := congrArg (· ^ 2) hsq
    simp only [Real.sq_sqrt hs2] at this
    have hfac : s ^ 2 * (s - 1) * (s ^ 3 + s ^ 2 + s - 1) = 0 := by nlinarith
    rcases mul_eq_zero.mp hfac with h' | h'
    · rcases mul_eq_zero.mp h' with h'' | h''
      · exact absurd h'' (by positivity)
      · exact absurd h'' (by linarith)
    · exact h'
  · intro h
    have hsq : 1 - s ^ 2 = (1 - s ^ 3) ^ 2 := by nlinarith
    rw [hsq, Real.sqrt_sq hs3]; ring

/-- **The radius is `arcsin s*`**: at `φ = arcsin s`, `cos φ + sin³ φ = 1` exactly at the cubic's root. -/
theorem radius_is_arcsin {s : ℝ} (h0 : 0 < s) (h1 : s < 1) :
    Real.cos (Real.arcsin s) + Real.sin (Real.arcsin s) ^ 3 = 1 ↔ s ^ 3 + s ^ 2 + s - 1 = 0 := by
  rw [Real.cos_arcsin, Real.sin_arcsin (by linarith) h1.le]
  exact psi_one_iff_cubic h0 h1

/-- **`s*` exists and is unique in `(0, 1)`**: the cubic is continuous, `-1` at `0` and `2` at `1`, and strictly
increasing on `s ≥ 0`. -/
theorem sStar_exists_unique : ∃! s : ℝ, 0 < s ∧ s < 1 ∧ s ^ 3 + s ^ 2 + s - 1 = 0 := by
  set f : ℝ → ℝ := fun s => s ^ 3 + s ^ 2 + s - 1 with hf
  have hcont : ContinuousOn f (Set.Icc 0 1) := by rw [hf]; fun_prop
  have hmem : (0 : ℝ) ∈ Set.Icc (f 0) (f 1) := by simp [hf]
  obtain ⟨s, ⟨hs0, hs1⟩, hfs⟩ := intermediate_value_Icc (by norm_num : (0:ℝ) ≤ 1) hcont hmem
  have hs : s ^ 3 + s ^ 2 + s - 1 = 0 := hfs
  have hpos : 0 < s := by
    rcases eq_or_lt_of_le hs0 with h | h
    · rw [← h] at hs; norm_num at hs
    · exact h
  have hlt : s < 1 := by
    rcases eq_or_lt_of_le hs1 with h | h
    · rw [h] at hs; norm_num at hs
    · exact h
  refine ⟨s, ⟨hpos, hlt, hs⟩, fun t ⟨ht0, _, ht⟩ => ?_⟩
  by_contra hne
  rcases lt_or_gt_of_ne hne with h | h
  · nlinarith [mul_pos ht0 ht0, mul_pos hpos hpos, sq_nonneg (t - s), mul_pos ht0 hpos]
  · nlinarith [mul_pos ht0 ht0, mul_pos hpos hpos, sq_nonneg (t - s), mul_pos ht0 hpos]

/-- The real root `s*` of `s³ + s² + s - 1` in `(0, 1)`. -/
noncomputable def sStar : ℝ := sStar_exists_unique.exists.choose

theorem sStar_spec : 0 < sStar ∧ sStar < 1 ∧ sStar ^ 3 + sStar ^ 2 + sStar - 1 = 0 :=
  sStar_exists_unique.exists.choose_spec

/-- **The radius is `arcsin s*`**: on `(0, 1)`, `ψ(arcsin s) = 1` exactly at `s = s*`. -/
theorem radius_eq_sStar {s : ℝ} (h0 : 0 < s) (h1 : s < 1) :
    Real.cos (Real.arcsin s) + Real.sin (Real.arcsin s) ^ 3 = 1 ↔ s = sStar := by
  rw [radius_is_arcsin h0 h1]
  constructor
  · intro h; exact sStar_exists_unique.unique ⟨h0, h1, h⟩ sStar_spec
  · rintro rfl; exact sStar_spec.2.2

/-- The cubic is strictly increasing on `s ≥ 0`. -/
theorem cubic_lt {a b : ℝ} (ha : 0 ≤ a) (hab : a < b) :
    a ^ 3 + a ^ 2 + a - 1 < b ^ 3 + b ^ 2 + b - 1 := by
  nlinarith [mul_pos (by linarith : (0:ℝ) < b - a) (by nlinarith : (0:ℝ) < a ^ 2 + a * b + b ^ 2 + a + b + 1)]

/-- **The exact reduction**: on `(0, 1)`, `√(1 - s²) + s³ ≤ 1` exactly when `s ≤ s*`, so the tube argument closes on
the whole of `(0, arcsin s*]`. -/
theorem psi_le_one_iff {s : ℝ} (h0 : 0 < s) (h1 : s < 1) :
    Real.sqrt (1 - s ^ 2) + s ^ 3 ≤ 1 ↔ s ≤ sStar := by
  obtain ⟨hS0, hS1, hS⟩ := sStar_spec
  have hs3 : 0 ≤ 1 - s ^ 3 := by
    have : s ^ 3 ≤ 1 := pow_le_one₀ h0.le h1.le
    linarith
  have hs2 : 0 ≤ 1 - s ^ 2 := by nlinarith
  have key : Real.sqrt (1 - s ^ 2) + s ^ 3 ≤ 1 ↔ s ^ 3 + s ^ 2 + s - 1 ≤ 0 := by
    rw [show Real.sqrt (1 - s ^ 2) + s ^ 3 ≤ 1 ↔ Real.sqrt (1 - s ^ 2) ≤ 1 - s ^ 3 by constructor <;> intro h <;> linarith,
      Real.sqrt_le_left hs3]
    constructor
    · intro h
      have hfac : 0 ≤ s ^ 2 * (1 - s) * (1 - (s ^ 3 + s ^ 2 + s)) := by nlinarith
      have hpos : 0 < s ^ 2 * (1 - s) := by positivity
      have := (mul_nonneg_iff_of_pos_left hpos).mp hfac
      linarith
    · intro h
      have : 0 ≤ s ^ 2 * (1 - s) * (1 - (s ^ 3 + s ^ 2 + s)) := by
        apply mul_nonneg; positivity; linarith
      nlinarith
  rw [key]
  constructor
  · intro h; by_contra hlt; push Not at hlt
    have := cubic_lt hS0.le hlt; linarith
  · intro h
    rcases eq_or_lt_of_le h with h' | h'
    · rw [h', hS]
    · have := cubic_lt h0.le h'; linarith

/-- **The chain at the exact radius**: with `0 < sin φ ≤ s*`, `cos φ ≥ 0`, the cubic expansion with `α ≤ 1/3` and
`γ ≤ m` gives `m ≤ 1`, so no maximiser lies within `arcsin s*` of the orbit. -/
theorem max_le_one_exact {m φ α γ : ℝ} (hcos : 0 ≤ Real.cos φ) (hsin : 0 < Real.sin φ)
    (hsS : Real.sin φ ≤ sStar)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) : m ≤ 1 := by
  have hs1 : Real.sin φ < 1 := lt_of_le_of_lt hsS sStar_spec.2.1
  have hcs : Real.cos φ = Real.sqrt (1 - Real.sin φ ^ 2) := by
    rw [← Real.cos_sq', Real.sqrt_sq hcos]
  have hpsi : Real.cos φ + Real.sin φ ^ 3 ≤ 1 := by
    rw [hcs]; exact (psi_le_one_iff hsin hs1).mpr hsS
  have hstep := expansion_step hcos hsin.le hexp hα hγ
  have hs3lt : Real.sin φ ^ 3 < 1 := by
    have : Real.sin φ ^ 3 < 1 ^ 3 := by gcongr
    simpa using this
  by_contra hcon
  push Not at hcon
  nlinarith [mul_pos (sub_pos.mpr hcon) (sub_pos.mpr hs3lt)]

end HamiltonsCubic.L20Statement
