import Mathlib.Tactic
import HamiltonsCubic.Results.L209WeylClosure

/-!
# Ricci removal onto `𝒲ₙ`: the Kulkarni–Nomizu part of a first-Bianchi operator

The Ricci half of the orthogonal projection onto the record's `𝒲ₙ`, which L234's split and the
`Λ⁴` constant need ([lean/INDEX.md](../../INDEX.md), the L234 row).

## What is typed here

* `knOp h`, the Kulkarni–Nomizu product `h ⊙ g` as the bivector operator `X ↦ hX + Xh`, with
  `knOp_isLinOp`, `knOp_isSkew` and `knOp_sym` at symmetric `h`.
* `R4_knOp`, its four-index entries, and from them `bianchi_knOp` (first Bianchi) and `ric_knOp`,
  `Ric(h ⊙ g) = (n − 2) h + tr(h) g`, screened at `n = 6` to `2 × 10⁻¹⁵` before typing.
* `knCorr R = (Ric R − tr Ric/(2(n−1)) g)/(n − 2)` and `weylOfBianchi R = R − knCorr R ⊙ g`.
* `weylOfBianchi_isWeylOp`: **for linear, bivector-preserving, self-adjoint, first-Bianchi `R` at
  `n ≥ 3`, `R − knCorr R ⊙ g` is in `𝒲ₙ`.**
* **The rest of the orthogonal projection** is the `Λ⁴` removal `weylProj_isWeylOp` in
  [WeylProjection.lean](WeylProjection.lean) and its orthogonality `weylProj_orth` in
  [WeylOrthogonal.lean](WeylOrthogonal.lean).
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.Results

open Finset RealLayer FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The Kulkarni–Nomizu product `h ⊙ g` as a bivector operator**, `X ↦ hX + Xh`. -/
def knOp (h : Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => h * X + X * h

section kn
variable (h : Matrix ι ι ℝ) (hh : h.transpose = h)

omit [DecidableEq ι] in
theorem knOp_isLinOp : IsLinOp (knOp h) :=
  ⟨fun X Y => by simp only [knOp, Matrix.mul_add, Matrix.add_mul]; abel,
   fun c X => by simp only [knOp, Matrix.mul_smul, Matrix.smul_mul, smul_add]⟩

include hh
omit [DecidableEq ι] in
theorem knOp_isSkew (X : Matrix ι ι ℝ) (hX : IsSkew X) : IsSkew (knOp h X) := by
  unfold IsSkew at *; unfold knOp
  rw [Matrix.transpose_add, Matrix.transpose_mul, Matrix.transpose_mul, hX, hh]
  simp only [Matrix.neg_mul, Matrix.mul_neg]; abel

omit [DecidableEq ι] in
theorem knOp_sym (X Y : Matrix ι ι ℝ) : inner2 (knOp h X) Y = inner2 X (knOp h Y) := by
  unfold inner2 knOp
  rw [Matrix.transpose_add, Matrix.transpose_mul, Matrix.transpose_mul, hh]
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.trace_add, Matrix.mul_assoc]
  rw [Matrix.trace_mul_comm h (X.transpose * Y), Matrix.mul_assoc X.transpose Y h]

omit hh in
theorem one_symm (a b : ι) : (1 : Matrix ι ι ℝ) a b = (1 : Matrix ι ι ℝ) b a := by
  by_cases hab : a = b
  · subst hab; rfl
  · simp [Matrix.one_apply, hab, Ne.symm hab]

omit hh in
theorem ite_one (a b : ι) (x : ℝ) : (if a = b then x else 0) = x * (1 : Matrix ι ι ℝ) a b := by
  simp [Matrix.one_apply]

omit hh in
theorem sum_mul_one_apply (f : ι → ℝ) (a : ι) : ∑ x, f x * (1 : Matrix ι ι ℝ) a x = f a := by
  simp [Matrix.one_apply]

omit hh in
theorem sum_one_mul_apply (f : ι → ℝ) (a : ι) : ∑ x, (1 : Matrix ι ι ℝ) a x * f x = f a := by
  simp [Matrix.one_apply]

omit hh in
theorem single_one_apply (a b x y : ι) :
    (Matrix.single a b (1 : ℝ)) x y = (1 : Matrix ι ι ℝ) a x * (1 : Matrix ι ι ℝ) b y := by
  by_cases h1 : a = x <;> by_cases h2 : b = y <;> simp [Matrix.single_apply, Matrix.one_apply, h1, h2]

omit hh in
theorem mul_phi_apply (i j k l : ι) :
    (h * phi i j) k l = h k j * (1 : Matrix ι ι ℝ) l i - h k i * (1 : Matrix ι ι ℝ) l j := by
  unfold phi
  rw [Matrix.mul_sub, Matrix.sub_apply, Matrix.mul_apply, Matrix.mul_apply]
  simp only [single_one_apply, ← mul_assoc, ← Finset.sum_mul, sum_mul_one_apply]
  rw [one_symm i l, one_symm j l]

omit hh in
theorem phi_mul_apply (i j k l : ι) :
    (phi i j * h) k l = (1 : Matrix ι ι ℝ) k j * h i l - (1 : Matrix ι ι ℝ) k i * h j l := by
  unfold phi
  rw [Matrix.sub_mul, Matrix.sub_apply, Matrix.mul_apply, Matrix.mul_apply]
  simp only [single_one_apply, mul_assoc, ← Finset.mul_sum, sum_one_mul_apply]
  rw [one_symm j k, one_symm i k]

theorem R4_knOp (i j k l : ι) :
    R4 (knOp h) i j k l
      = -(h k j * (1 : Matrix ι ι ℝ) l i - h k i * (1 : Matrix ι ι ℝ) l j
          + (1 : Matrix ι ι ℝ) k j * h i l - (1 : Matrix ι ι ℝ) k i * h j l) := by
  unfold R4
  rw [inner2_phi _ (knOp_isSkew h hh _ (phi_isSkew i j))]
  simp only [knOp, Matrix.add_apply, mul_phi_apply, phi_mul_apply]
  ring

theorem bianchi_knOp (i j k l : ι) : bianchi (knOp h) i j k l = 0 := by
  have hs : ∀ a b, h a b = h b a := fun a b => by
    have := congrFun (congrFun hh b) a; simpa [Matrix.transpose_apply] using this
  have ds : ∀ a b, (1 : Matrix ι ι ℝ) a b = (1 : Matrix ι ι ℝ) b a := fun a b => by
    simp only [Matrix.one_apply, eq_comm]
  have e := R4_knOp h hh
  unfold R4 at e
  unfold bianchi
  rw [e, e, e, hs i k, hs i j, hs l i, ds l j, ds k l, ds j k]
  ring

theorem ric_knOp (a b : ι) :
    Ric (knOp h) a b = ((Fintype.card ι : ℝ) - 2) * h a b + h.trace * (1 : Matrix ι ι ℝ) a b := by
  have hs : ∀ a b, h a b = h b a := fun a b => by
    have := congrFun (congrFun hh b) a; simpa [Matrix.transpose_apply] using this
  have e := R4_knOp h hh
  unfold R4 at e
  unfold Ric
  simp only [e, Matrix.one_apply, Matrix.trace, Matrix.diag, mul_ite, ite_mul, mul_one, one_mul,
    mul_zero, zero_mul, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_add_distrib,
    Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, Finset.sum_const,
    Finset.card_univ, nsmul_eq_mul]
  rw [hs b a]
  by_cases hab : a = b
  · subst hab; simp; ring
  · simp [hab, Ne.symm hab]; ring

end kn

section ricRemoval
variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ)

/-- The Ricci tensor as a matrix. -/
noncomputable def ricMat : Matrix ι ι ℝ := Matrix.of fun a b => Ric R a b

/-- **The Kulkarni–Nomizu correction** `h(R) = (Ric − tr Ric/(2(n−1)) I)/(n−2)`, the symmetric
matrix whose `knOp` carries all of `R`'s Ricci tensor. -/
noncomputable def knCorr : Matrix ι ι ℝ :=
  (1 / ((Fintype.card ι : ℝ) - 2)) •
    (ricMat R - ((ricMat R).trace / (2 * ((Fintype.card ι : ℝ) - 1))) • (1 : Matrix ι ι ℝ))

/-- **Ricci removal**, `R − h(R) ⊙ g`. -/
noncomputable def weylOfBianchi : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => R X - knOp (knCorr R) X

theorem ricMat_transpose
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) :
    (ricMat R).transpose = ricMat R := by
  ext a b
  simp only [Matrix.transpose_apply, ricMat, Matrix.of_apply, Ric]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [hsym _ _ (phi_isSkew b c) (phi_isSkew a c), inner2_comm]

theorem knCorr_transpose
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) :
    (knCorr R).transpose = knCorr R := by
  unfold knCorr
  rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_smul, Matrix.transpose_one,
    ricMat_transpose R hsym]

theorem ric_sub (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b : ι) :
    Ric (fun X => A X - B X) a b = Ric A a b - Ric B a b := by
  unfold Ric
  simp only [inner2_sub_left', Finset.sum_sub_distrib]

/-- **Ricci removal lands in `𝒲ₙ`**: a linear, bivector-preserving, self-adjoint, first-Bianchi `R`
minus its Kulkarni–Nomizu part is in the record's `𝒲ₙ`, at `n ≥ 3`. -/
theorem weylOfBianchi_isWeylOp (hn : 3 ≤ Fintype.card ι) (hlin : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0) : IsWeylOp (weylOfBianchi R) := by
  have hh := knCorr_transpose R hsym
  have hk := knOp_isLinOp (knCorr R)
  refine ⟨⟨fun X Y => ?_, fun c X => ?_⟩, fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_,
    fun a b => ?_⟩
  · simp only [weylOfBianchi, hlin.1, hk.1]; abel
  · simp only [weylOfBianchi, hlin.2, hk.2, smul_sub]
  · have h1 := hskew X hX; have h2 := knOp_isSkew (knCorr R) hh X hX
    unfold IsSkew at *; unfold weylOfBianchi
    rw [Matrix.transpose_sub, h1, h2]; abel
  · unfold weylOfBianchi
    rw [inner2_sub_left', inner2_sub_right', hsym X Y hX hY, knOp_sym (knCorr R) hh]
  · have h1 := hB i j k l; have h2 := bianchi_knOp (knCorr R) hh i j k l
    unfold bianchi at *; unfold weylOfBianchi
    simp only [inner2_sub_left']; linarith
  · have hn2 : (Fintype.card ι : ℝ) - 2 ≠ 0 := by
      have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
      linarith
    have hn1 : (Fintype.card ι : ℝ) - 1 ≠ 0 := by
      have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
      linarith
    show Ric (fun X => R X - knOp (knCorr R) X) a b = 0
    rw [ric_sub, ric_knOp (knCorr R) hh]
    have hr : Ric R a b = ricMat R a b := rfl
    rw [hr]
    unfold knCorr
    simp only [Matrix.smul_apply, Matrix.sub_apply, smul_eq_mul, Matrix.trace_smul,
      Matrix.trace_sub, Matrix.trace_one]
    field_simp
    ring

end ricRemoval

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.bianchi_knOp            -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.ric_knOp                -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.weylOfBianchi_isWeylOp  -- [propext, Classical.choice, Quot.sound]
