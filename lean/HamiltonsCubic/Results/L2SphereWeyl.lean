import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false

/-!
# L2's family, identified: `diagOp(sphereWeight S)` is the Weyl part of `S^p × S^q`

[findings/problem.md](../../../findings/problem.md), Lemma L2, is about `θ` at the Weyl tensor of `S^p × S^q`.
[Families.lean](../Base/Families.lean) takes `diagOp (t • sphereWeight S)` as the family's definition, and
[L2Operators.lean](L2Operators.lean) proves L2 at those operators; this file proves the definition right.

The unit-sphere product's curvature operator is the identity on `Λ²ℝᵖ ⊕ Λ²ℝ^q` and zero on mixed bivectors,
`diagOp (sectProd S)`. Its Weyl part is its orthogonal projection onto `𝒲ₙ`, and `𝒲ₙ^⊥` is spanned by the
Kulkarni–Nomizu products `h ⊙ g`, which on the diagonal locus are the weights `h_a + h_b` (`knWeight`).

- `innerOp_knWeight`: `⟨diagOp(knWeight h), R⟩ = ∑ h_a Ric(R)_{aa}`, so a Kulkarni–Nomizu part is orthogonal to
  every linear Ricci-flat operator;
- `sectProd_split`: `sectProd S = c · sphereWeight S + knWeight h` entry by entry, with
  `c = 1/(1 + ½(q/(p−1) + p/(q−1))) > 0` and `h` constant on each block;
- **`sphereProduct_weylPart`**: `diagOp(sectProd S) = c · diagOp(sphereWeight S) + diagOp(knWeight h)`, the first
  summand a Weyl operator and the second orthogonal to every Weyl operator;
- **`weylPart_unique`** and **`sphereProduct_weylPart_unique`**: a split into a linear Weyl operator and a part
  orthogonal to every linear Ricci-flat operator is unique on bivectors, the difference being orthogonal to itself,
  so `c · diagOp(sphereWeight S)` is the Weyl part of `S^p × S^q`.
-/

namespace HamiltonsCubic.L2SphereWeyl

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The sectional-curvature weight of the unit-sphere product `S^p × S^q`**: `1` on pairs inside a block, `0`
across. `diagOp (sectProd S)` is its curvature operator, the identity on `Λ²ℝᵖ ⊕ Λ²ℝ^q` and zero on the mixed
bivectors. -/
def sectProd (S : Finset ι) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a = b then 0 else if (a ∈ S ↔ b ∈ S) then 1 else 0

/-- The Kulkarni–Nomizu weight `h_a + h_b` of a diagonal symmetric `h`. -/
def knWeight (h : ι → ℝ) : Matrix ι ι ℝ := Matrix.of fun a b => if a = b then 0 else h a + h b

/-- **A Kulkarni–Nomizu part is orthogonal to every Ricci-flat linear operator**: `⟨KN(h), R⟩ = ∑ h_a Ric_aa`. -/
theorem innerOp_knWeight (h : ι → ℝ) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) :
    innerOp (diagOp (knWeight h)) R = ∑ a, h a * Ric R a a := by
  have hsym : ∀ a b, knWeight h a b = knWeight h b a := fun a b => by
    unfold knWeight; by_cases hab : a = b
    · subst hab; rfl
    · simp [hab, Ne.symm hab, add_comm]
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = -R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hswap : ∀ i j, inner2 (R (phi j i)) (phi j i) = inner2 (R (phi i j)) (phi i j) := fun i j => by
    rw [phi_swap j i, hneg]
    unfold inner2; simp [Matrix.transpose_neg]
  have hc : ∀ i j, inner2 (phi i j) (R (phi i j)) = inner2 (R (phi i j)) (phi i j) := fun i j => inner2_comm _ _
  unfold innerOp Ric
  simp only [diagOp_phi _ hsym, FamilyLayer.inner2_smul_left, hc]
  have e : ∀ i j, knWeight h i j * inner2 (R (phi i j)) (phi i j)
      = h i * inner2 (R (phi i j)) (phi i j) + h j * inner2 (R (phi i j)) (phi i j) := fun i j => by
    unfold knWeight
    by_cases hij : i = j
    · subst hij
      have : phi i i = 0 := by unfold phi; simp
      simp [this, inner2]
    · simp [hij]; ring
  simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum]
  rw [Finset.sum_comm (f := fun i j => h j * inner2 (R (phi i j)) (phi i j))]
  simp only [← Finset.mul_sum]
  have e2 : ∀ j, ∑ i, inner2 (R (phi i j)) (phi i j) = ∑ i, inner2 (R (phi j i)) (phi j i) := fun j =>
    Finset.sum_congr rfl fun i _ => hswap j i
  simp only [e2]
  ring

/-- The scale of the Weyl part, `c = 1/(1 + ½(q/(p−1) + p/(q−1)))`. -/
noncomputable def cW (S : Finset ι) : ℝ :=
  1 / (1 + ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1) + (S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) / 2)

/-- The Kulkarni–Nomizu coefficient, constant on each block. -/
noncomputable def hW (S : Finset ι) (a : ι) : ℝ :=
  if a ∈ S then (1 - cW S * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))) / 2
  else (1 - cW S * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1))) / 2

theorem cW_pos (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) : 0 < cW S := by
  have hp' : (2 : ℝ) ≤ S.card := by exact_mod_cast hp
  have hq' : (2 : ℝ) ≤ Sᶜ.card := by exact_mod_cast hq
  unfold cW
  have h1 : 0 < (Sᶜ.card : ℝ) / ((S.card : ℝ) - 1) := div_pos (by linarith) (by linarith)
  have h2 : 0 < (S.card : ℝ) / ((Sᶜ.card : ℝ) - 1) := div_pos (by linarith) (by linarith)
  positivity

/-- **THE CURVATURE WEIGHT OF `S^p × S^q` SPLITS AS `c · sphereWeight + KN(h)`**, entry by entry. -/
theorem sectProd_split (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (a b : ι) :
    sectProd S a b = cW S * sphereWeight S a b + knWeight (hW S) a b := by
  have hp' : (2 : ℝ) ≤ S.card := by exact_mod_cast hp
  have hq' : (2 : ℝ) ≤ Sᶜ.card := by exact_mod_cast hq
  have hc : cW S * (1 + ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1) + (S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) / 2) = 1 := by
    unfold cW
    have h1 : 0 < (Sᶜ.card : ℝ) / ((S.card : ℝ) - 1) := div_pos (by linarith) (by linarith)
    have h2 : 0 < (S.card : ℝ) / ((Sᶜ.card : ℝ) - 1) := div_pos (by linarith) (by linarith)
    field_simp
  by_cases hab : a = b
  · subst hab; simp [sectProd, knWeight, sphereWeight_hollow]
  by_cases ha : a ∈ S <;> by_cases hb : b ∈ S
  · rw [sphereWeight_in S ha hb hab]; simp [sectProd, knWeight, hW, hab, ha, hb]
  · rw [sphereWeight_cross S ha hb]; simp [sectProd, knWeight, hW, hab, ha, hb]; linarith
  · rw [sphereWeight_symm, sphereWeight_cross S hb ha]; simp [sectProd, knWeight, hW, hab, ha, hb]; linarith
  · rw [sphereWeight_out S ha hb hab]; simp [sectProd, knWeight, hW, hab, ha, hb]

/-- **THE WEYL PART OF `S^p × S^q` IS `c · diagOp(sphereWeight)`**: the curvature operator `diagOp(sectProd S)` is
`c · diagOp(sphereWeight S)`, a Weyl operator with `c > 0`, plus `diagOp(KN(h))`, which is orthogonal to every
linear Ricci-flat operator. The decomposition `𝒲ₙ ⊕ 𝒲ₙ^⊥` is orthogonal, so the first summand is the Weyl
projection. -/
theorem sphereProduct_weylPart (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    (∀ X, diagOp (sectProd S) X = diagOp (cW S • sphereWeight S) X + diagOp (knWeight (hW S)) X) ∧
    0 < cW S ∧ IsWeylOp (diagOp (cW S • sphereWeight S)) ∧
    ∀ R : Matrix ι ι ℝ → Matrix ι ι ℝ, IsLinOp R → (∀ a b, Ric R a b = 0) →
      innerOp (diagOp (knWeight (hW S))) R = 0 := by
  refine ⟨fun X => ?_, cW_pos S hp hq, ⟨isLinOp_diagOp _, diagOp_isWeyl ((sphereWeight_isWeight S hp hq).smul _)⟩,
    fun R hR hRic => ?_⟩
  · ext a b
    simp only [diagOp, Matrix.of_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, sectProd_split S hp hq a b]
    ring
  · rw [innerOp_knWeight _ R hR]; simp [hRic]

theorem inner2_sub_l (A B C : Matrix ι ι ℝ) : inner2 (A - B) C = inner2 A C - inner2 B C := by
  simp only [inner2_eq_sum, Matrix.sub_apply, sub_mul, Finset.sum_sub_distrib, mul_sub]

/-- **THE WEYL PART IS UNIQUE**: if `W₁ + K₁ = W₂ + K₂` with `W₁, W₂` linear Weyl operators and `K₁, K₂` orthogonal
to every linear Ricci-flat operator, then `W₁ = W₂` on bivectors. The difference `W₁ − W₂ = K₂ − K₁` is a linear
Ricci-flat operator orthogonal to itself. -/
theorem weylPart_unique {W₁ W₂ K₁ K₂ : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW₁ : IsWeylOp W₁) (hW₂ : IsWeylOp W₂)
    (hK₁ : ∀ R, IsLinOp R → (∀ a b, Ric R a b = 0) → innerOp K₁ R = 0)
    (hK₂ : ∀ R, IsLinOp R → (∀ a b, Ric R a b = 0) → innerOp K₂ R = 0)
    (hsum : ∀ X, W₁ X + K₁ X = W₂ X + K₂ X) (i j : ι) : W₁ (phi i j) = W₂ (phi i j) := by
  set D : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => W₁ X - W₂ X with hDdef
  have hDK : ∀ X, D X = K₂ X - K₁ X := fun X => by
    simp only [hDdef]; have := hsum X; rw [sub_eq_sub_iff_add_eq_add, this, add_comm]
  have hDlin : IsLinOp D := ⟨fun X Y => by simp only [hDdef, hW₁.1.1, hW₂.1.1]; abel,
    fun c X => by simp only [hDdef, hW₁.1.2, hW₂.1.2, smul_sub]⟩
  have hDric : ∀ a b, Ric D a b = 0 := fun a b => by
    have h1 := hW₁.2.2.2.2 a b
    have h2 := hW₂.2.2.2.2 a b
    unfold Ric at h1 h2 ⊢
    simp only [hDdef, inner2_sub_l, Finset.sum_sub_distrib]; rw [h1, h2, sub_zero]
  have hDD : innerOp D D = 0 := by
    have e : innerOp D D = innerOp K₂ D - innerOp K₁ D := by
      unfold innerOp
      rw [← mul_sub, ← Finset.sum_sub_distrib]
      congr 1
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [← Finset.sum_sub_distrib]
      refine Finset.sum_congr rfl fun b _ => ?_
      rw [hDK (phi a b), inner2_sub_l]
    rw [e, hK₂ D hDlin hDric, hK₁ D hDlin hDric, sub_zero]
  -- `innerOp D D` is a sum of squares
  have hnn : ∀ X : Matrix ι ι ℝ, 0 ≤ inner2 X X := fun X => by
    rw [inner2_eq_sum]
    exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _)
  have hzero : inner2 (D (phi i j)) (D (phi i j)) = 0 := by
    unfold innerOp at hDD
    have hs : ∑ a, ∑ b, inner2 (D (phi a b)) (D (phi a b)) = 0 := by linarith
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ => Finset.sum_nonneg fun b _ => hnn _).mp hs i
      (Finset.mem_univ _)
    exact (Finset.sum_eq_zero_iff_of_nonneg fun b _ => hnn _).mp h1 j (Finset.mem_univ _)
  have hD0 : D (phi i j) = 0 := by
    rw [inner2_eq_sum] at hzero
    have hs : ∑ a, ∑ b, D (phi i j) a b * D (phi i j) a b = 0 := by linarith
    ext a b
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _).mp hs a
      (Finset.mem_univ _)
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => mul_self_nonneg _).mp h1 b (Finset.mem_univ _)
    simpa using mul_self_eq_zero.mp h2
  simp only [hDdef, sub_eq_zero] at hD0
  exact hD0

/-- **The sphere product's Weyl part, as a LINEAR Weyl operator, and unique**: every split of `diagOp(sectProd S)`
into a linear Weyl operator and a part orthogonal to every linear Ricci-flat operator has Weyl part
`c · diagOp(sphereWeight S)` on bivectors. -/
theorem sphereProduct_weylPart_unique (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card)
    (W K : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W)
    (hK : ∀ R, IsLinOp R → (∀ a b, Ric R a b = 0) → innerOp K R = 0)
    (hsplit : ∀ X, diagOp (sectProd S) X = W X + K X) (i j : ι) :
    W (phi i j) = diagOp (cW S • sphereWeight S) (phi i j) := by
  obtain ⟨h1, -, h3, h4⟩ := sphereProduct_weylPart S hp hq
  refine weylPart_unique hW h3 hK h4 (fun X => ?_) i j
  rw [← hsplit X, h1 X]

end HamiltonsCubic.L2SphereWeyl
