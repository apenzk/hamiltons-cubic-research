import Mathlib
import HamiltonsCubic.Results.L2SphereWeyl
import HamiltonsCubic.Results.L208RicciFoxSquare

set_option linter.style.longLine false

/-!
# L48's last step: an Einstein curvature operator has zero Weyl part exactly at constant curvature

[findings/problem.md](../../../findings/problem.md), Lemma L48: *"Each $\lVert W_a\rVert^2\ge0$ vanishes
exactly when that factor has constant curvature"*. [L48.lean](L48.lean) and
[ReducibleConvexity.lean](ReducibleConvexity.lean) carry the arithmetic and the two-point convexity,
[L48Decomp.lean](L48Decomp.lean) the factorwise decomposition and [L48Jensen.lean](L48Jensen.lean) the
multi-point Jensen step and the assembly. The pointwise content of the clause is algebra about one
curvature operator, proved here:

* `bianchi_id`: the identity on `Λ²` (sectional curvature `1`) is first-Bianchi;
* `einstein_weylPart`: at a linear, bivector-preserving, self-adjoint, first-Bianchi `R` on `ℝᵐ`,
  `m ≥ 2`, with `Ric R = ρ δ`, the operator `R - c·Id`, `c = ρ/(m-1)`, is a linear Weyl operator;
* `scalar_orth`: `c·Id` is orthogonal to every Ricci-flat linear operator, being L2SphereWeyl's
  Kulkarni–Nomizu part of the constant `c/2` on bivectors;
* `normSq_eq_zero_iff`: `normSq W = 0` exactly when `W` vanishes on every `φ_ij`;
* `L48_weyl_zero_iff`: for any split `R = W + K` with `W` a linear Weyl operator and `K` orthogonal to
  every Ricci-flat linear operator, `normSq W = 0 ↔ ∀ i j, R φ_ij = c φ_ij`, that is, `R` has constant
  sectional curvature `c`.

The Einstein constant `ρ` has any sign here.
-/

namespace HamiltonsCubic.L48Const

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L2SphereWeyl

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The identity on `Λ²` is first-Bianchi.** -/
theorem bianchi_id (i j k l : ι) : bianchi (id : Matrix ι ι ℝ → Matrix ι ι ℝ) i j k l = 0 := by
  simp only [bianchi, id, inner2_phi_phi]
  grind

theorem inner2_smul_l' (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  simp only [inner2_eq_sum, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring

theorem inner2_smul_r' (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 X (c • Y) = c * inner2 X Y := by
  rw [inner2_comm, inner2_smul_l', inner2_comm]

theorem inner2_sub_r' (A B C : Matrix ι ι ℝ) : inner2 A (B - C) = inner2 A B - inner2 A C := by
  rw [inner2_comm, inner2_sub_l, inner2_comm B, inner2_comm C]

/-- **`R - c·Id` is a linear Weyl operator** at an Einstein curvature operator, `c = ρ/(m-1)`. -/
theorem einstein_weylPart (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hb : ∀ i j k l, bianchi R i j k l = 0)
    (ρ : ℝ) (hE : ∀ a b, Ric R a b = ρ * (if a = b then 1 else 0))
    (hm : 2 ≤ Fintype.card ι) :
    IsWeylOp (fun X => R X - (ρ / ((Fintype.card ι : ℝ) - 1)) • X) := by
  set c : ℝ := ρ / ((Fintype.card ι : ℝ) - 1) with hc
  have hmR : (2 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hm
  refine ⟨⟨fun X Y => ?_, fun t X => ?_⟩, fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_,
    fun a b => ?_⟩
  · simp only [hR.1, smul_add]; abel
  · simp only [hR.2, smul_sub, smul_comm t c X]
  · unfold IsSkew at hX ⊢
    have h := hskew X hX; unfold IsSkew at h
    rw [Matrix.transpose_sub, h, Matrix.transpose_smul, hX, smul_neg, neg_sub_neg, neg_sub]
  · simp only
    rw [inner2_sub_l, inner2_smul_l', hsa X Y hX hY, inner2_sub_r', inner2_smul_r']
  · have h1 := hb i j k l
    have h2 := bianchi_id (ι := ι) i j k l
    unfold bianchi at h1 h2 ⊢
    simp only [id] at h2
    simp only [inner2_sub_l, inner2_smul_l']
    linear_combination h1 - c * h2
  · have h1 := hE a b
    have h2 := HamiltonsCubic.Results.Ric_id_eq (ι := ι) a b
    unfold Ric at h1 h2 ⊢
    simp only [id] at h2
    simp only [inner2_sub_l, inner2_smul_l', Finset.sum_sub_distrib, ← Finset.mul_sum]
    rw [h1, h2, hc]
    have hne : (Fintype.card ι : ℝ) - 1 ≠ 0 := by linarith
    field_simp
    ring

/-- **`c·Id` is orthogonal to every Ricci-flat linear operator**: on bivectors it is
`diagOp (knWeight (c/2))`. -/
theorem scalar_orth (c : ℝ) (R' : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR' : IsLinOp R')
    (hRic : ∀ a b, Ric R' a b = 0) :
    innerOp (fun X => c • X) R' = 0 := by
  set h : ι → ℝ := fun _ => c / 2
  have hsym : ∀ a b, knWeight h a b = knWeight h b a := fun a b => by
    unfold knWeight; by_cases hab : a = b
    · subst hab; rfl
    · simp only [Matrix.of_apply, if_neg hab, if_neg (Ne.symm hab)]; exact add_comm _ _
  have e : ∀ i j : ι, c • phi i j = diagOp (knWeight h) (phi i j) := fun i j => by
    rw [diagOp_phi _ hsym]
    by_cases hij : i = j
    · subst hij; simp [phi]
    · simp only [knWeight, Matrix.of_apply, if_neg hij, h]
      congr 1; ring
  have : innerOp (fun X => c • X) R' = innerOp (diagOp (knWeight h)) R' := by
    unfold innerOp
    simp only [e]
  rw [this, innerOp_knWeight h R' hR']
  simp [hRic]

/-- **A norm vanishes exactly on the zero operator on bivectors.** -/
theorem normSq_eq_zero_iff (W : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    normSq W = 0 ↔ ∀ i j, W (phi i j) = 0 := by
  have hnn : ∀ X : Matrix ι ι ℝ, 0 ≤ inner2 X X := fun X => by
    rw [inner2_eq_sum]
    exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _)
  constructor
  · intro h i j
    unfold normSq innerOp at h
    have hs : ∑ a, ∑ b, inner2 (W (phi a b)) (W (phi a b)) = 0 := by linarith
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ => Finset.sum_nonneg fun b _ => hnn _).mp hs i
      (Finset.mem_univ _)
    have hz := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => hnn _).mp h1 j (Finset.mem_univ _)
    rw [inner2_eq_sum] at hz
    have hs2 : ∑ a, ∑ b, W (phi i j) a b * W (phi i j) a b = 0 := by linarith
    ext a b
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _).mp hs2 a
      (Finset.mem_univ _)
    have h3 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => mul_self_nonneg _).mp h2 b (Finset.mem_univ _)
    simpa using mul_self_eq_zero.mp h3
  · intro h
    unfold normSq innerOp
    simp [h, inner2_eq_sum]

/-- **L48's pointwise step**: at an Einstein curvature operator on `ℝᵐ`, `m ≥ 2`, the Weyl summand of
any split `R = W + K` (`W` linear Weyl, `K` orthogonal to every Ricci-flat linear operator) has
`normSq W = 0` exactly when `R` is `c·Id` on bivectors, `c = ρ/(m-1)`: constant sectional curvature. -/
theorem L48_weyl_zero_iff (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hb : ∀ i j k l, bianchi R i j k l = 0)
    (ρ : ℝ) (hE : ∀ a b, Ric R a b = ρ * (if a = b then 1 else 0))
    (hm : 2 ≤ Fintype.card ι)
    (W K : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W)
    (hK : ∀ R', IsLinOp R' → (∀ a b, Ric R' a b = 0) → innerOp K R' = 0)
    (hsplit : ∀ X, R X = W X + K X) :
    normSq W = 0 ↔ ∀ i j, R (phi i j) = (ρ / ((Fintype.card ι : ℝ) - 1)) • phi i j := by
  set c : ℝ := ρ / ((Fintype.card ι : ℝ) - 1) with hc
  have hD := einstein_weylPart R hR hskew hsa hb ρ hE hm
  have hu : ∀ i j, W (phi i j) = R (phi i j) - c • phi i j :=
    weylPart_unique (K₂ := fun X => c • X) hW hD hK (fun R' hR' hRic => scalar_orth c R' hR' hRic)
      (fun X => by show W X + K X = (R X - c • X) + c • X; rw [sub_add_cancel, hsplit X])
  rw [normSq_eq_zero_iff]
  simp only [hu, sub_eq_zero]

end HamiltonsCubic.L48Const
