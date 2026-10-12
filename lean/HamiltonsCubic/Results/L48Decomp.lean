import Mathlib
import HamiltonsCubic.Results.L48Const
import HamiltonsCubic.Results.L56Weyl

set_option linter.style.longLine false

/-!
# L48's factorwise decomposition `‖W‖² = Σ_a ‖W_a‖² + B`, at the product's curvature operator

[findings/problem.md](../../../findings/problem.md), Lemma L48: *"Then $R$ is block-diagonal on
$\Lambda^2$ and zero on the mixed terms ... so factorwise
$\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, $B=\sum_af(n_a)-\frac n{8(n-1)}$, $f(m)=\frac m{8(m-1)}$"*,
each factor Einstein with the same constant, normalised to `λ = ½`. [L48.lean](L48.lean) takes the
decomposition and computes with `B`; this file proves it.

A product is a labelling `β : ι → κ` of the coordinates by factor, `p_i = bs β i` the size of `i`'s
factor. The curvature operator `R` is an algebraic curvature operator with `Ric R = ρ δ` and zero on
mixed bivectors, `R φ_ij = 0` when `β i ≠ β j`. With `c = ρ/(n-1)` and `c_i = ρ/(p_i - 1)` (the factor's
own scalar, L48Const's `c` at the factor):

* `Wfac`: `½ Σ_{β i = β j} ‖R φ_ij - c_i φ_ij‖²`, the sum over factors of `‖R_a - c_a Id‖²`, which is
  `Σ_a ‖W_a‖²` because each factor's operator is Einstein with the same `ρ` (`hmix` removes the mixed
  terms of its Ricci) and so has Weyl part `R_a - c_a Id` by [L48Const.lean](L48Const.lean)'s
  `einstein_weylPart` and L2SphereWeyl's `weylPart_unique` at the factor. That identification is read,
  not typed; the bound uses only `Wfac ≥ 0` and the attainment only `Wfac_eq_zero_iff`;
* `normSq_decomp`: for any split `R = W + K` (`W` linear Weyl, `K` orthogonal to every Ricci-flat linear
  operator), `normSq W = Wfac + (ρ²/2) Σ_i (1/(p_i - 1) - 1/(n-1))`;
* `B_half`: at `ρ = ½` the second term is `Σ_i 1/(8(p_i-1)) - n/(8(n-1))`, which is L48's
  `B = Σ_a f(n_a) - n/(8(n-1))`, each factor's `n_a` indices carrying `f(n_a)/n_a = 1/(8(n_a-1))`;
* `Wfac_eq_zero_iff`: `Wfac = 0` exactly when every factor has constant curvature, `R φ_ij = c_i φ_ij`
  within each factor.
-/

namespace HamiltonsCubic.L48Decomp

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L2SphereWeyl
  HamiltonsCubic.L48Const HamiltonsCubic.L56Weyl

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {κ : Type*} [DecidableEq κ]

/-- The factor's own scalar `c_i = ρ/(p_i - 1)`. -/
noncomputable def cb (β : ι → κ) (ρ : ℝ) (i : ι) : ℝ := ρ / ((bs β i : ℝ) - 1)

/-- `Σ_a ‖W_a‖²`: half the sum over within-factor ordered pairs of `‖R φ_ij - c_i φ_ij‖²`. -/
noncomputable def Wfac (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (β : ι → κ) (ρ : ℝ) : ℝ :=
  (1 / 2) * ∑ i, ∑ j, if β j = β i then
    inner2 (R (phi i j) - cb β ρ i • phi i j) (R (phi i j) - cb β ρ i • phi i j) else 0

theorem inner2_quad (A B : Matrix ι ι ℝ) (t : ℝ) :
    inner2 (A - t • B) (A - t • B) = inner2 A A - 2 * t * inner2 A B + t ^ 2 * inner2 B B := by
  rw [inner2_sub_l, inner2_sub_r', inner2_sub_r', inner2_smul_l', inner2_smul_l', inner2_smul_r',
    inner2_smul_r', inner2_comm B A]
  ring

theorem inner2_phi_self (i j : ι) : inner2 (phi i j) (phi i j) = if i = j then 0 else 1 := by
  rw [inner2_phi_phi]
  by_cases h : i = j
  · subst h; simp
  · simp [h, Ne.symm h]

/-- **The pair-level split**: at every ordered pair, `‖(R - c)φ‖²` is the factor term plus
`2(c_i - c)⟨Rφ, φ⟩` plus a scalar multiple of `‖φ‖²`. -/
theorem pair_split (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (β : ι → κ) (ρ c : ℝ)
    (hmix : ∀ i j, β i ≠ β j → R (phi i j) = 0) (i j : ι) :
    inner2 (R (phi i j) - c • phi i j) (R (phi i j) - c • phi i j) =
      (if β j = β i then
        inner2 (R (phi i j) - cb β ρ i • phi i j) (R (phi i j) - cb β ρ i • phi i j) else 0)
      + 2 * (cb β ρ i - c) * inner2 (R (phi i j)) (phi i j)
      + (c ^ 2 - (if β j = β i then cb β ρ i ^ 2 else 0)) * inner2 (phi i j) (phi i j) := by
  rw [inner2_quad]
  by_cases h : β j = β i
  · rw [if_pos h, if_pos h, inner2_quad]; ring
  · rw [if_neg h, if_neg h, hmix i j (Ne.symm h)]
    simp only [inner2_eq_sum, Matrix.zero_apply, zero_mul, mul_zero, Finset.sum_const_zero]
    ring

/-- **The factorwise decomposition.** -/
theorem normSq_decomp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hb : ∀ i j k l, bianchi R i j k l = 0)
    (ρ : ℝ) (hE : ∀ a b, Ric R a b = ρ * (if a = b then 1 else 0))
    (β : ι → κ) (hbs : ∀ i, 2 ≤ bs β i) (hn : 2 ≤ Fintype.card ι)
    (hmix : ∀ i j, β i ≠ β j → R (phi i j) = 0)
    (W K : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W)
    (hK : ∀ R', IsLinOp R' → (∀ a b, Ric R' a b = 0) → innerOp K R' = 0)
    (hsplit : ∀ X, R X = W X + K X) :
    normSq W = Wfac R β ρ
      + (ρ ^ 2 / 2) * ∑ i, (1 / ((bs β i : ℝ) - 1) - 1 / ((Fintype.card ι : ℝ) - 1)) := by
  set c : ℝ := ρ / ((Fintype.card ι : ℝ) - 1) with hc
  have hD := einstein_weylPart R hR hskew hsa hb ρ hE hn
  have hu : ∀ i j, W (phi i j) = R (phi i j) - c • phi i j :=
    weylPart_unique (K₂ := fun X => c • X) hW hD hK (fun R' hR' hRic => scalar_orth c R' hR' hRic)
      (fun X => by show W X + K X = (R X - c • X) + c • X; rw [sub_add_cancel, hsplit X])
  have hnR : (2 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
  -- row sums
  have hric : ∀ i, ∑ j, inner2 (R (phi i j)) (phi i j) = ρ := fun i => by
    have := hE i i; simp only [if_true, mul_one] at this
    rw [← this]; rfl
  have hcnt : ∀ i, ∑ j, (c ^ 2 - (if β j = β i then cb β ρ i ^ 2 else 0)) * inner2 (phi i j) (phi i j)
      = c ^ 2 * ((Fintype.card ι : ℝ) - 1) - cb β ρ i ^ 2 * ((bs β i : ℝ) - 1) := fun i => by
    have e : ∀ j, (c ^ 2 - (if β j = β i then cb β ρ i ^ 2 else 0)) * inner2 (phi i j) (phi i j)
        = c ^ 2 - (if i = j then c ^ 2 else 0) - ((if β j = β i then cb β ρ i ^ 2 else 0)
          - (if i = j then cb β ρ i ^ 2 else 0)) := fun j => by
      rw [inner2_phi_self]
      by_cases h : i = j
      · subst h; simp
      · simp [h]
    simp only [e, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
      Finset.sum_ite_eq, Finset.mem_univ, if_true]
    rw [Finset.sum_ite, Finset.sum_const_zero, add_zero, Finset.sum_const, nsmul_eq_mul]
    have hp : ((Finset.univ.filter fun j => β j = β i).card : ℝ) = bs β i := rfl
    rw [hp]
    ring
  have hrow : ∀ i, ∑ j, inner2 (W (phi i j)) (W (phi i j)) =
      (∑ j, if β j = β i then
        inner2 (R (phi i j) - cb β ρ i • phi i j) (R (phi i j) - cb β ρ i • phi i j) else 0)
      + (ρ ^ 2 / ((bs β i : ℝ) - 1) - ρ ^ 2 / ((Fintype.card ι : ℝ) - 1)) := fun i => by
    simp only [hu, pair_split R β ρ c hmix i, Finset.sum_add_distrib, ← Finset.mul_sum, hric i, hcnt i]
    have hb2 : (2 : ℝ) ≤ bs β i := by exact_mod_cast hbs i
    have h1 : (bs β i : ℝ) - 1 ≠ 0 := by linarith
    have h2 : (Fintype.card ι : ℝ) - 1 ≠ 0 := by linarith
    rw [hc, cb]
    field_simp
    ring
  unfold normSq innerOp Wfac
  simp only [hrow, Finset.sum_add_distrib]
  rw [mul_add]
  congr 1
  rw [Finset.mul_sum, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => by ring

omit [DecidableEq ι] in
/-- **L48's `B` at `ρ = ½`**: `(ρ²/2) Σ_i (1/(p_i-1) - 1/(n-1)) = Σ_i 1/(8(p_i-1)) - n/(8(n-1))`. -/
theorem B_half (β : ι → κ) :
    ((1 / 2 : ℝ) ^ 2 / 2) * ∑ i, (1 / ((bs β i : ℝ) - 1) - 1 / ((Fintype.card ι : ℝ) - 1)) =
      ∑ i, 1 / (8 * ((bs β i : ℝ) - 1)) - (Fintype.card ι : ℝ) / (8 * ((Fintype.card ι : ℝ) - 1)) := by
  have e : (Fintype.card ι : ℝ) / (8 * ((Fintype.card ι : ℝ) - 1))
      = ∑ _i : ι, 1 / (8 * ((Fintype.card ι : ℝ) - 1)) := by
    rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]; ring
  rw [e, ← Finset.sum_sub_distrib, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => by simp only [one_div, mul_inv]; ring

/-- **`Σ_a ‖W_a‖² = 0` exactly at constant curvature on every factor.** -/
theorem Wfac_eq_zero_iff (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (β : ι → κ) (ρ : ℝ) :
    Wfac R β ρ = 0 ↔ ∀ i j, β j = β i → R (phi i j) = cb β ρ i • phi i j := by
  have hnn : ∀ X : Matrix ι ι ℝ, 0 ≤ inner2 X X := fun X => by
    rw [inner2_eq_sum]
    exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _)
  have hnn' : ∀ i j, 0 ≤ (if β j = β i then
      inner2 (R (phi i j) - cb β ρ i • phi i j) (R (phi i j) - cb β ρ i • phi i j) else 0) :=
    fun i j => by split_ifs <;> simp [hnn]
  constructor
  · intro h i j hij
    unfold Wfac at h
    have hs : ∑ a, ∑ b, (if β b = β a then
        inner2 (R (phi a b) - cb β ρ a • phi a b) (R (phi a b) - cb β ρ a • phi a b) else 0) = 0 := by
      linarith
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ => Finset.sum_nonneg fun b _ => hnn' a b).mp hs i
      (Finset.mem_univ _)
    have hz := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => hnn' i b).mp h1 j (Finset.mem_univ _)
    rw [if_pos hij, inner2_eq_sum] at hz
    have hs2 : ∑ a, ∑ b, (R (phi i j) - cb β ρ i • phi i j) a b * (R (phi i j) - cb β ρ i • phi i j) a b
        = 0 := by linarith
    rw [← sub_eq_zero]
    ext a b
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _).mp
      hs2 a (Finset.mem_univ _)
    have h3 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => mul_self_nonneg _).mp h2 b (Finset.mem_univ _)
    simpa using mul_self_eq_zero.mp h3
  · intro h
    unfold Wfac
    refine mul_eq_zero_of_right _ (Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => ?_)
    split_ifs with hij
    · rw [h i j hij, sub_self]; simp [inner2_eq_sum]
    · rfl

end HamiltonsCubic.L48Decomp
