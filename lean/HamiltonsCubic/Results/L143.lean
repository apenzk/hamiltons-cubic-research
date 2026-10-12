import HamiltonsCubic.Results.L70Symmetric
import HamiltonsCubic.Results.L31Statement

set_option linter.style.longLine false

/-!
# L143, `B₅ ≤ √(n − 2)` from the two recorded marginals

[findings/bounds.md](../../../findings/bounds.md), Lemma L143: `sup|P| ≤ 1 + √(n − 2)`, from the second-order bound
`θ ≤ λ_max p + B₅` at a critical point and the estimate `B₅ ≤ √(n − 2)`, where
`B₅ = ½(∑_α ⟨T_αμ, μ⟩²)^{1/2}`, `T_{αβγ} = c_{αβγ}²` and `μ = |λ|`. The estimate uses the **pair cap**
`∑_γ T_{αβγ} = ‖[v_α, v_β]‖² ≤ 2` ([L31](L31Statement.lean)) and the **Killing row mass**
`∑_{βγ} T_{αβγ} = 2(n − 2)` ([L41Statement.lean](L41Statement.lean)'s `killing_frame`).

- `form_le_mass`, `form_le`: AM–GM gives `0 ≤ ⟨T_αμ, μ⟩ ≤ ∑_β μ_β² ∑_γ T_{αβγ} ≤ 2` at unit `μ ≥ 0`;
- `B5_sq_le`: then `∑_α ⟨T_αμ, μ⟩² ≤ 2 ∑_α ⟨T_αμ, μ⟩ ≤ 2M` with `M` the row mass;
- **`B5_frame`**: at every Weyl eigenframe, `∑_α ⟨T_αμ, μ⟩² ≤ 4(n − 2)`, i.e. `B₅ ≤ √(n − 2)`.

The first term `λ_max p ≤ 1` and the second-order bound `θ ≤ λ_max p + B₅` are the lemma's other inputs.
-/

namespace HamiltonsCubic.L143

open Finset

variable {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

/-- **AM–GM against a symmetric nonnegative tensor**: `∑_{bc} T_{abc} μ_b μ_c ≤ ∑_b μ_b² ∑_c T_{abc}`. -/
theorem form_le_mass (T : Γ → Γ → Γ → ℝ) (hT : ∀ a b c, 0 ≤ T a b c) (hs : ∀ a b c, T a b c = T a c b)
    (μ : Γ → ℝ) (a : Γ) : ∑ b, ∑ c, T a b c * μ b * μ c ≤ ∑ b, μ b ^ 2 * ∑ c, T a b c := by
  have amgm : ∀ b c, T a b c * μ b * μ c ≤ T a b c * ((μ b ^ 2 + μ c ^ 2) / 2) := fun b c => by
    have := hT a b c
    nlinarith [sq_nonneg (μ b - μ c)]
  have e : ∑ b, ∑ c, T a b c * μ c ^ 2 = ∑ b, ∑ c, T a b c * μ b ^ 2 := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun b _ => by rw [hs]
  have hsplit : ∑ b, ∑ c, T a b c * ((μ b ^ 2 + μ c ^ 2) / 2)
      = (∑ b, ∑ c, T a b c * μ b ^ 2 + ∑ b, ∑ c, T a b c * μ c ^ 2) / 2 := by
    rw [← Finset.sum_add_distrib, Finset.sum_div]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_add_distrib, Finset.sum_div]
    exact Finset.sum_congr rfl fun c _ => by ring
  calc ∑ b, ∑ c, T a b c * μ b * μ c ≤ ∑ b, ∑ c, T a b c * ((μ b ^ 2 + μ c ^ 2) / 2) :=
        Finset.sum_le_sum fun b _ => Finset.sum_le_sum fun c _ => amgm b c
    _ = ∑ b, μ b ^ 2 * ∑ c, T a b c := by
        rw [hsplit, e, ← two_mul, mul_div_cancel_left₀ _ (two_ne_zero)]
        simp only [Finset.mul_sum]
        exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by ring

/-- **The quadratic forms of a nonnegative tensor with capped pair sums**: with `T ≥ 0`, symmetric in its last two
slots, `∑_γ T_{αβγ} ≤ 2` and `μ ≥ 0`, `0 ≤ ⟨T_αμ, μ⟩ ≤ 2 ∑ μ²`. -/
theorem form_le (T : Γ → Γ → Γ → ℝ) (hT : ∀ a b c, 0 ≤ T a b c) (hs : ∀ a b c, T a b c = T a c b)
    (hcap : ∀ a b, ∑ c, T a b c ≤ 2) (μ : Γ → ℝ) (a : Γ) :
    ∑ b, ∑ c, T a b c * μ b * μ c ≤ 2 * ∑ b, μ b ^ 2 := by
  have amgm : ∀ b c, T a b c * μ b * μ c ≤ T a b c * ((μ b ^ 2 + μ c ^ 2) / 2) := fun b c => by
    have := hT a b c
    nlinarith [sq_nonneg (μ b - μ c)]
  have hsplit : ∑ b, ∑ c, T a b c * ((μ b ^ 2 + μ c ^ 2) / 2) = ∑ b, μ b ^ 2 * ∑ c, T a b c := by
    have e : ∑ b, ∑ c, T a b c * μ c ^ 2 = ∑ b, ∑ c, T a b c * μ b ^ 2 := by
      rw [Finset.sum_comm]
      exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun b _ => by rw [hs]
    have : ∑ b, ∑ c, T a b c * ((μ b ^ 2 + μ c ^ 2) / 2)
        = (∑ b, ∑ c, T a b c * μ b ^ 2 + ∑ b, ∑ c, T a b c * μ c ^ 2) / 2 := by
      rw [← Finset.sum_add_distrib, Finset.sum_div]
      refine Finset.sum_congr rfl fun b _ => ?_
      rw [← Finset.sum_add_distrib, Finset.sum_div]
      exact Finset.sum_congr rfl fun c _ => by ring
    rw [this, e, ← two_mul, mul_div_cancel_left₀ _ (two_ne_zero)]
    simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by ring
  calc ∑ b, ∑ c, T a b c * μ b * μ c ≤ ∑ b, ∑ c, T a b c * ((μ b ^ 2 + μ c ^ 2) / 2) :=
        Finset.sum_le_sum fun b _ => Finset.sum_le_sum fun c _ => amgm b c
    _ = ∑ b, μ b ^ 2 * ∑ c, T a b c := hsplit
    _ ≤ ∑ b, μ b ^ 2 * 2 := Finset.sum_le_sum fun b _ => mul_le_mul_of_nonneg_left (hcap a b) (sq_nonneg _)
    _ = 2 * ∑ b, μ b ^ 2 := by rw [← Finset.sum_mul]; ring

/-- **`B₅² ≤ n − 2`, abstractly**: for a nonnegative fully symmetric `T` with pair cap `∑_c T_{abc} ≤ 2` and row
mass `∑_{ac} T_{bac} = M`, and `μ ≥ 0` of unit length, `∑_a ⟨T_aμ, μ⟩² ≤ 2M`. -/
theorem B5_sq_le (T : Γ → Γ → Γ → ℝ) (hT : ∀ a b c, 0 ≤ T a b c) (hs23 : ∀ a b c, T a b c = T a c b)
    (hs12 : ∀ a b c, T a b c = T b a c) (hcap : ∀ a b, ∑ c, T a b c ≤ 2) (M : ℝ)
    (hrow : ∀ b, ∑ a, ∑ c, T b a c = M) (μ : Γ → ℝ) (hμ : ∀ b, 0 ≤ μ b) (hunit : ∑ b, μ b ^ 2 = 1) :
    ∑ a, (∑ b, ∑ c, T a b c * μ b * μ c) ^ 2 ≤ 2 * M := by
  set x : Γ → ℝ := fun a => ∑ b, ∑ c, T a b c * μ b * μ c with hx
  have hx0 : ∀ a, 0 ≤ x a := fun a => Finset.sum_nonneg fun b _ => Finset.sum_nonneg fun c _ =>
    mul_nonneg (mul_nonneg (hT a b c) (hμ b)) (hμ c)
  have hx2 : ∀ a, x a ≤ 2 := fun a => by
    have := form_le T hT hs23 hcap μ a; rw [hunit] at this; simpa [hx] using this
  have hsum : ∑ a, x a ≤ M := by
    calc ∑ a, x a ≤ ∑ a, ∑ b, μ b ^ 2 * ∑ c, T a b c := Finset.sum_le_sum fun a _ => form_le_mass T hT hs23 μ a
      _ = ∑ b, μ b ^ 2 * ∑ a, ∑ c, T b a c := by
          rw [Finset.sum_comm]
          refine Finset.sum_congr rfl fun b _ => ?_
          rw [Finset.mul_sum]
          exact Finset.sum_congr rfl fun a _ => by
            rw [Finset.mul_sum, Finset.mul_sum]
            exact Finset.sum_congr rfl fun c _ => by rw [hs12]
      _ = M := by simp only [hrow, ← Finset.sum_mul, hunit, one_mul]
  calc ∑ a, x a ^ 2 ≤ ∑ a, 2 * x a := Finset.sum_le_sum fun a _ => by nlinarith [hx0 a, hx2 a]
    _ = 2 * ∑ a, x a := by rw [Finset.mul_sum]
    _ ≤ 2 * M := by linarith

open HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame in
/-- **L143's `B₅ ≤ √(n − 2)` AT EVERY WEYL EIGENFRAME**: with `T_{αβγ} = c_{αβγ}²` the frame's structure constants,
`∑_α ⟨T_αμ, μ⟩² ≤ 4(n − 2)` for every `μ ≥ 0` of unit length, so `B₅ = ½(∑_α ⟨T_αμ, μ⟩²)^{1/2} ≤ √(n − 2)`. -/
theorem B5_frame {ι : Type*} [Fintype ι] [DecidableEq ι] {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hW : IsWeyl W) (hf : EigenFrame W v lam)
    (μ : Γ → ℝ) (hμ : ∀ b, 0 ≤ μ b) (hunit : ∑ b, μ b ^ 2 = 1) :
    ∑ a, (∑ b, ∑ c, cst v a b c ^ 2 * μ b * μ c) ^ 2 ≤ 4 * ((Fintype.card ι : ℝ) - 2) := by
  have h := B5_sq_le (fun a b c => cst v a b c ^ 2) (fun a b c => sq_nonneg _)
    (fun a b c => by rw [cst_swap23 hf a b c]; ring)
    (fun a b c => by rw [cst_swap12 hf a b c]; ring)
    (fun a b => by
      have hc := HamiltonsCubic.L31Statement.L31_cap_unit _ _ (hf.skew a) (hf.skew b)
        (by rw [hf.orthonormal, if_pos rfl]) (by rw [hf.orthonormal, if_pos rfl])
      rw [brnorm_frame hf a b] at hc
      exact hc)
    (2 * ((Fintype.card ι : ℝ) - 2)) (fun b => killing_frame hW hf b) μ hμ hunit
  linarith

end HamiltonsCubic.L143
