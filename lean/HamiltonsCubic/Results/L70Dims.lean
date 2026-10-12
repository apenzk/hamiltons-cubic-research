import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Results.L31Statement

set_option linter.style.longLine false

/-!
# L70's saturation forces `dim E_min ≥ n/2` and `dim E_max ≥ (n−2)/2`

[findings/bounds.md](../../../findings/bounds.md), Lemma L70: *saturation forces `dim E_min ≥ n/2` and
`dim E_max ≥ (n−2)/2`, from the pair cap Lemma L31 and the Killing marginal alone.* At saturation
`ad(v)` is supported on `E_min ⊗ E_max` ([L70Unit.lean](L70Unit.lean)'s `L70_equality_support`).
**This file proves the dimension theorem from that support condition**, in an orthonormal eigenframe
with the unit eigenvector taken to be a frame vector `v_{γ₀}`, `c_{γ₀ab} = ⟨[v_{γ₀}, v_a], v_b⟩`:

- the Killing marginal `∑_{a,b} c_{γ₀ab}² = 2(n−2)` (`killing_frame`) sits on `E_min × E_max` and its
  mirror, so `2(n−2) = 2 ∑_{a ∈ E_min, b ∈ E_max} c²`;
- each `b ∈ E_max` carries `∑_a c_{γ₀ab}² = ‖[v_{γ₀}, v_b]‖² ≤ 2` (`L31_cap_unit`), so
  **`n − 2 ≤ 2 dim E_max`**;
- each `a ∈ E_min` carries at most `2`, and `a = γ₀` carries `0`, so **`n ≤ 2 dim E_min`**.
-/

namespace HamiltonsCubic.L41Statement.Frame

open HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {Γ : Type*} [Fintype Γ] [DecidableEq Γ]
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}

/-- `‖[v_x, v_a]‖² ≤ 2` for frame vectors. -/
theorem brnorm_le_two (hf : EigenFrame W v lam) (x a : Γ) : ∑ b, cst v x a b ^ 2 ≤ 2 := by
  rw [← brnorm_frame hf x a]
  have h1 : inner2 (v x) (v x) = 1 := by rw [hf.orthonormal, if_pos rfl]
  have h2 : inner2 (v a) (v a) = 1 := by rw [hf.orthonormal, if_pos rfl]
  exact HamiltonsCubic.L31Statement.L31_cap_unit _ _ (hf.skew x) (hf.skew a) h1 h2

/-- **L70's DIMENSION THEOREM**: if `ad(v_{γ₀})` is supported on `E_min × E_max` and its mirror, with
`λ_{γ₀} = λ_min ≠ λ_max`, then `n − 2 ≤ 2 dim E_max` and `n ≤ 2 dim E_min`. -/
theorem saturation_dims (hW : IsWeyl W) (hf : EigenFrame W v lam) (γ₀ : Γ) (lmin lmax : ℝ)
    (hne : lmin ≠ lmax) (h0 : lam γ₀ = lmin)
    (hsupp : ∀ a b, cst v γ₀ a b ≠ 0 →
      (lam a = lmin ∧ lam b = lmax) ∨ (lam a = lmax ∧ lam b = lmin)) :
    (Fintype.card ι : ℝ) - 2 ≤ 2 * ((Finset.univ.filter fun a => lam a = lmax).card : ℝ) ∧
      (Fintype.card ι : ℝ) ≤ 2 * ((Finset.univ.filter fun a => lam a = lmin).card : ℝ) := by
  set c : Γ → Γ → ℝ := fun a b => cst v γ₀ a b ^ 2 with hc
  set I : Γ → Γ → ℝ := fun a b => if lam a = lmin ∧ lam b = lmax then c a b else 0 with hI
  have hK := killing_frame hW hf γ₀
  -- the mass sits on the two mirrored blocks
  have hsplit : ∀ a b, c a b = I a b + I b a := by
    intro a b
    simp only [hI, hc]
    by_cases hz : cst v γ₀ a b = 0
    · have hz' : cst v γ₀ b a = 0 := by rw [cst_swap23 hf, hz, neg_zero]
      simp [hz, hz']
    · have hswap : cst v γ₀ b a ^ 2 = cst v γ₀ a b ^ 2 := by rw [cst_swap23 hf γ₀ b a]; ring
      rcases hsupp a b hz with ⟨ha, hb⟩ | ⟨ha, hb⟩
      · have hn2 : ¬(lam b = lmin ∧ lam a = lmax) := fun h => hne (h.1 ▸ hb)
        rw [if_pos ⟨ha, hb⟩, if_neg hn2, add_zero]
      · have hn1 : ¬(lam a = lmin ∧ lam b = lmax) := fun h => hne (h.1 ▸ ha)
        rw [if_neg hn1, if_pos ⟨hb, ha⟩, zero_add, hswap]
  have hmass : ∑ a, ∑ b, c a b = 2 * ∑ a, ∑ b, I a b := by
    simp only [hsplit, Finset.sum_add_distrib]
    rw [Finset.sum_comm (f := fun a b => I b a)]
    ring
  have hK' : ∑ a, ∑ b, c a b = 2 * ((Fintype.card ι : ℝ) - 2) := hK
  have hc0 : ∀ a b, 0 ≤ c a b := fun a b => sq_nonneg _
  -- `E_max` bound: each column carries at most `2`
  have hmax : ∑ a, ∑ b, I a b ≤ 2 * ((Finset.univ.filter fun a => lam a = lmax).card : ℝ) := by
    rw [Finset.sum_comm]
    have hcol : ∀ b, ∑ a, I a b ≤ if lam b = lmax then 2 else 0 := by
      intro b
      split_ifs with hb
      · calc ∑ a, I a b ≤ ∑ a, c a b :=
              Finset.sum_le_sum fun a _ => by simp only [hI]; split_ifs <;> [exact le_refl _; exact hc0 a b]
          _ = ∑ a, cst v γ₀ b a ^ 2 := Finset.sum_congr rfl fun a _ => by
              simp only [hc]; rw [cst_swap23 hf γ₀ a b]; ring
          _ ≤ 2 := brnorm_le_two hf γ₀ b
      · exact le_of_eq (Finset.sum_eq_zero fun a _ => by simp only [hI]; rw [if_neg (fun h => hb h.2)])
    calc ∑ b, ∑ a, I a b ≤ ∑ b, (if lam b = lmax then (2 : ℝ) else 0) := Finset.sum_le_sum fun b _ => hcol b
      _ = 2 * ((Finset.univ.filter fun a => lam a = lmax).card : ℝ) := by
        rw [Finset.sum_ite, Finset.sum_const_zero, add_zero, Finset.sum_const, nsmul_eq_mul]; ring
  -- `E_min` bound: each row carries at most `2`, and the row of `γ₀` carries `0`
  have hmin : ∑ a, ∑ b, I a b ≤ 2 * (((Finset.univ.filter fun a => lam a = lmin).card : ℝ) - 1) := by
    have hrow : ∀ a, ∑ b, I a b ≤ (if lam a = lmin then 2 else 0) - (if a = γ₀ then 2 else 0) := by
      intro a
      by_cases hg : a = γ₀
      · subst hg
        rw [if_pos h0, if_pos rfl, sub_self]
        refine le_of_eq (Finset.sum_eq_zero fun b _ => ?_)
        simp only [hI, hc]
        have : cst v a a b = 0 := by
          unfold cst
          have hbr : br (v a) (v a) = 0 := by unfold br; simp
          rw [hbr]; unfold inner2; simp
        rw [this]; simp
      · rw [if_neg hg, sub_zero]
        split_ifs with ha
        · calc ∑ b, I a b ≤ ∑ b, c a b :=
                Finset.sum_le_sum fun b _ => by simp only [hI]; split_ifs <;> [exact le_refl _; exact hc0 a b]
            _ ≤ 2 := brnorm_le_two hf γ₀ a
        · exact le_of_eq (Finset.sum_eq_zero fun b _ => by simp only [hI]; rw [if_neg (fun h => ha h.1)])
    calc ∑ a, ∑ b, I a b ≤ ∑ a, ((if lam a = lmin then (2 : ℝ) else 0) - (if a = γ₀ then 2 else 0)) :=
          Finset.sum_le_sum fun a _ => hrow a
      _ = 2 * (((Finset.univ.filter fun a => lam a = lmin).card : ℝ) - 1) := by
        rw [Finset.sum_sub_distrib, Finset.sum_ite, Finset.sum_const_zero, add_zero, Finset.sum_const,
          nsmul_eq_mul, Finset.sum_ite_eq', if_pos (Finset.mem_univ γ₀)]
        ring
  constructor <;> linarith

end HamiltonsCubic.L41Statement.Frame
