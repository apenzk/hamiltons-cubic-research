import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.L74Statement

set_option linter.style.longLine false

/-!
# L70 in the unit-norm reading

[EigenFrameExist.lean](EigenFrameExist.lean)'s `L70_bound_exists` bounds the multiplier `θ` in
`Q(W) = θW`. At a unit-norm critical point that multiplier is `P(W) = P(W)/‖W‖³`, the record's
`θ(W)` ([L74Statement.lean](L74Statement.lean)'s `theta_of_critical_unit`), so:

- `L70_bound_unit`: **`θ(W) ≤ λ_min + (n−2)λ_max`** for a unit-norm critical linear Weyl operator,
  at a unit skew eigenvector of `λ_min < 0` and any `λ_max ≥ 0` bounding the spectrum of `M` above;
- `corner_eq_iff`: on `[λ_min, λ_max]²` with `λ_min < 0 < λ_max`, `xy = λ_min λ_max` exactly at
  `{x, y} = {λ_min, λ_max}`;
- `L70_equality_support`: **equality holds exactly when every pair carrying bracket mass `b_ab`
  has one class at `λ_min` and the other at `λ_max`**, the record's support on `E_min ⊗ E_max`, at
  `λ_max > 0`, and `L70_equality_support_unit` the same on `θ(W)` at unit norm.
-/

namespace HamiltonsCubic.L70Unit

open HamiltonsCubic.RealLayer HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind

variable {n : ℕ}

/-- **L70's bound at a unit-norm critical point, on `θ(W) = P(W)/‖W‖³` itself.** -/
theorem L70_bound_unit (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (hn : normSq W = 1) (x : Matrix (Fin n) (Fin n) ℝ)
    (hx : IsSkew x) (hunit : inner2 x x = 1) (lmin lmax : ℝ) (hxe : W x = lmin • x)
    (hneg : lmin < 0) (hmax : 0 ≤ lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax) :
    theta W ≤ lmin + ((n : ℝ) - 2) * lmax := by
  rw [HamiltonsCubic.L74Statement.theta_of_critical_unit hc hn]
  exact L70_bound_exists W hW θ hc x hx hunit lmin lmax hxe hneg hmax hlo hhi

/-- **The corner is attained only at the corners**: with `λ_min < 0 < λ_max` and `x, y` in
`[λ_min, λ_max]`, `xy = λ_min λ_max` iff `{x, y} = {λ_min, λ_max}`. -/
theorem corner_eq_iff {lmin lmax x y : ℝ} (hneg : lmin < 0) (hpos : 0 < lmax)
    (hx1 : lmin ≤ x) (hx2 : x ≤ lmax) (hy1 : lmin ≤ y) (hy2 : y ≤ lmax) :
    x * y = lmin * lmax ↔ (x = lmin ∧ y = lmax) ∨ (x = lmax ∧ y = lmin) := by
  constructor
  · intro h
    have hprod : x * y < 0 := by rw [h]; exact mul_neg_of_neg_of_pos hneg hpos
    rcases lt_or_ge x 0 with hx | hx
    · have hy : 0 < y := by
        by_contra hy; push Not at hy; nlinarith
      left
      have e1 : x * y ≥ lmin * y := by nlinarith
      have e2 : lmin * y ≥ lmin * lmax := by nlinarith
      have ex : x = lmin := by
        have : (x - lmin) * y = 0 := by nlinarith
        rcases mul_eq_zero.mp this with h0 | h0
        · linarith
        · linarith
      refine ⟨ex, ?_⟩
      subst ex
      have : x * (y - lmax) = 0 := by nlinarith
      rcases mul_eq_zero.mp this with h0 | h0
      · linarith
      · linarith
    · have hy : y < 0 := by
        by_contra hy; push Not at hy; nlinarith
      right
      have ey : y = lmin := by
        have : x * (y - lmin) = 0 := by nlinarith
        rcases mul_eq_zero.mp this with h0 | h0
        · subst h0; simp at hprod
        · linarith
      refine ⟨?_, ey⟩
      subst ey
      have : (x - lmax) * y = 0 := by nlinarith
      rcases mul_eq_zero.mp this with h0 | h0
      · linarith
      · linarith
  · rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · rfl
    · ring

/-- **L70's equality case as support on `E_min ⊗ E_max`, for the multiplier**: at `λ_max > 0`, the
multiplier `θ` of `Q(W) = θW` attains the bound iff every class pair carrying bracket mass is
`(λ_min, λ_max)` or `(λ_max, λ_min)`. `L70_equality_support_unit` states it for `θ(W)`. -/
theorem L70_equality_support {r K : ℕ}
    (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • HamiltonsCubic.L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin lmax : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ i, lmin ≤ lam i) (hhi : ∀ i, lam i ≤ lmax) :
    θ = lmin + ((n : ℝ) - 2) * lmax ↔
      ∀ a b, HamiltonsCubic.L244RowA.bAB ψ cls a b x ≠ 0 →
        (lam a = lmin ∧ lam b = lmax) ∨ (lam a = lmax ∧ lam b = lmin) := by
  rw [HamiltonsCubic.L70Weyl.L70_equality W hW θ hc ψ hψS hψ cls lam hWP x hx hunit lmin lmax hxe
    hneg hpos.le hlo hhi]
  constructor
  · intro h a b hb
    have := h a b
    rcases mul_eq_zero.mp this with h0 | h0
    · exact (corner_eq_iff hneg hpos (hlo a) (hhi a) (hlo b) (hhi b)).mp (by linarith)
    · exact absurd h0 hb
  · intro h a b
    by_cases hb : HamiltonsCubic.L244RowA.bAB ψ cls a b x = 0
    · rw [hb, mul_zero]
    · have := (corner_eq_iff hneg hpos (hlo a) (hhi a) (hlo b) (hhi b)).mpr (h a b hb)
      rw [this, sub_self, zero_mul]

/-- **L70's equality case on `θ(W) = P(W)/‖W‖³`** at a unit-norm critical point. -/
theorem L70_equality_support_unit {r K : ℕ}
    (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (hn : normSq W = 1) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • HamiltonsCubic.L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin lmax : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ i, lmin ≤ lam i) (hhi : ∀ i, lam i ≤ lmax) :
    theta W = lmin + ((n : ℝ) - 2) * lmax ↔
      ∀ a b, HamiltonsCubic.L244RowA.bAB ψ cls a b x ≠ 0 →
        (lam a = lmin ∧ lam b = lmax) ∨ (lam a = lmax ∧ lam b = lmin) := by
  rw [HamiltonsCubic.L74Statement.theta_of_critical_unit hc hn]
  exact L70_equality_support W hW θ hc ψ hψS hψ cls lam hWP x hx hunit lmin lmax hxe hneg hpos
    hlo hhi

end HamiltonsCubic.L70Unit
