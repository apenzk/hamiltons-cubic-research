import HamiltonsCubic.Results.L143

set_option linter.style.longLine false

/-!
# L143's first term and its assembly: `λ_max p + B₅ ≤ 1 + √(n − 2)` at every Weyl eigenframe

[findings/bounds.md](../../../findings/bounds.md), Lemma L143: *"The first term is bounded by `1` outright:
`p ≤ ∑_α λ_α² = 1` and `λ_max ≤ 1`"*, and the second term is [L143.lean](L143.lean)'s `B5_frame`. This file closes
the two steps between them and the statement:

* **`first_term_le`**: at a unit spectrum `∑ λ² = 1`, every eigenvalue `ℓ` has `ℓ · p ≤ 1`, with
  `p = ∑_{λ > 0} λ²`, so in particular `λ_max p ≤ 1`;
* **`B5_le_sqrt`**: `B₅ = ½(∑_α ⟨T_αμ, μ⟩²)^{1/2} ≤ √(n − 2)` at `μ = |λ|`, the square root taken from `B5_frame`;
* **`L143_at_frame`**: the right-hand side `λ_max p + B₅` of the second-order bound is at most `1 + √(n − 2)`;
* **`L143_of_second_order`**: granting that bound, `θ ≤ λ_max p + B₅`, the critical value obeys
  `θ ≤ 1 + √(n − 2)`.

*Owed*: the second-order bound itself, imported from [second-order.md](../../../findings/second-order.md) and taken
here as the binder `hso`; and that `sup |P|` is attained at a critical point, where `P = θ`.
-/

namespace HamiltonsCubic.L143

open Finset

variable {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

/-- `p = ∑_{λ > 0} λ²`, the positive part's squared mass. -/
noncomputable def posMass (lam : Γ → ℝ) : ℝ := ∑ a, if 0 < lam a then lam a ^ 2 else 0

omit [DecidableEq Γ] in
/-- **The first term**: at a unit spectrum every eigenvalue `ℓ` has `ℓ · p ≤ 1`, since `ℓ ≤ 1` and `0 ≤ p ≤ 1`. -/
theorem first_term_le (lam : Γ → ℝ) (hunit : ∑ a, lam a ^ 2 = 1) (a : Γ) : lam a * posMass lam ≤ 1 := by
  have hp0 : 0 ≤ posMass lam := Finset.sum_nonneg fun b _ => by split_ifs <;> positivity
  have hp1 : posMass lam ≤ 1 := by
    rw [← hunit]
    exact Finset.sum_le_sum fun b _ => by split_ifs <;> first | exact le_rfl | positivity
  have hsq : lam a ^ 2 ≤ 1 := by
    rw [← hunit]
    exact Finset.single_le_sum (f := fun b => lam b ^ 2) (fun b _ => sq_nonneg _) (Finset.mem_univ a)
  have hl : lam a ≤ 1 := by nlinarith [sq_nonneg (lam a - 1)]
  rcases le_or_gt (lam a) 0 with h | h
  · nlinarith
  · nlinarith

/-- **`B₅ ≤ √(n − 2)`** at every Weyl eigenframe, with `μ = |λ|` at a unit spectrum. -/
theorem B5_le_sqrt {ι : Type*} [Fintype ι] [DecidableEq ι] {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hW : HamiltonsCubic.RealLayer.IsWeyl W)
    (hf : HamiltonsCubic.L41Statement.EigenFrame W v lam) (hunit : ∑ a, lam a ^ 2 = 1) :
    (1 / 2) * Real.sqrt (∑ a, (∑ b, ∑ c, HamiltonsCubic.L41Statement.Frame.cst v a b c ^ 2 * |lam b| * |lam c|) ^ 2)
      ≤ Real.sqrt ((Fintype.card ι : ℝ) - 2) := by
  have h := B5_frame hW hf (fun b => |lam b|) (fun b => abs_nonneg _) (by simpa only [sq_abs] using hunit)
  have h4 : Real.sqrt 4 = 2 := by
    rw [show (4 : ℝ) = 2 ^ 2 by norm_num]; exact Real.sqrt_sq (by norm_num)
  have := Real.sqrt_le_sqrt h
  rw [Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 4), h4] at this
  linarith

/-- **The right-hand side of the second-order bound is at most `1 + √(n − 2)`**, at every Weyl eigenframe of unit
spectrum and every eigenvalue `ℓ = λ_a`, `λ_max` among them. -/
theorem L143_at_frame {ι : Type*} [Fintype ι] [DecidableEq ι] {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hW : HamiltonsCubic.RealLayer.IsWeyl W)
    (hf : HamiltonsCubic.L41Statement.EigenFrame W v lam) (hunit : ∑ a, lam a ^ 2 = 1) (a : Γ) :
    lam a * posMass lam
        + (1 / 2) * Real.sqrt (∑ a, (∑ b, ∑ c, HamiltonsCubic.L41Statement.Frame.cst v a b c ^ 2 * |lam b| * |lam c|) ^ 2)
      ≤ 1 + Real.sqrt ((Fintype.card ι : ℝ) - 2) := by
  have := first_term_le lam hunit a
  have := B5_le_sqrt hW hf hunit
  linarith

/-- **L143, granting the second-order bound**: a critical value `θ` with `θ ≤ λ_max p + B₅` obeys
`θ ≤ 1 + √(n − 2)`. -/
theorem L143_of_second_order {ι : Type*} [Fintype ι] [DecidableEq ι] {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hW : HamiltonsCubic.RealLayer.IsWeyl W)
    (hf : HamiltonsCubic.L41Statement.EigenFrame W v lam) (hunit : ∑ a, lam a ^ 2 = 1) (amax : Γ) (θ : ℝ)
    (hso : θ ≤ lam amax * posMass lam
        + (1 / 2) * Real.sqrt (∑ a, (∑ b, ∑ c, HamiltonsCubic.L41Statement.Frame.cst v a b c ^ 2 * |lam b| * |lam c|) ^ 2)) :
    θ ≤ 1 + Real.sqrt ((Fintype.card ι : ℝ) - 2) :=
  hso.trans (L143_at_frame hW hf hunit amax)

end HamiltonsCubic.L143
