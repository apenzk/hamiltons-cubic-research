import HamiltonsCubic.Base.WeylReal

/-!
# Completing an orthonormal family of bivectors to a frame

`extend_frame`: every orthonormal family of skew matrices, orthonormal for the layer's `inner2`,
extends to a complete orthonormal family, one through which every bivector expands.

*The construction puts `inner2` on `𝔰𝔬(ι)` as an `InnerProductSpace`, on the type synonym `SkewSp`
so that it carries no Pi topology to clash with, and hands the extension to Mathlib's
`Orthonormal.exists_orthonormalBasis_extension`.* This is what a result stated on a PARTIAL frame
needs before [L41Statement.lean](L41Statement.lean)'s frame formulas, which ask for a complete one,
apply to it.
-/

set_option linter.unusedSectionVars false

namespace HamiltonsCubic.FrameExtension

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem inner2_add_l' (X Y Z : Matrix ι ι ℝ) : inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  unfold inner2; rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

theorem inner2_smul_l' (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  unfold inner2; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring

theorem skew_add' {x y : Matrix ι ι ℝ} (hx : IsSkew x) (hy : IsSkew y) : IsSkew (x + y) := by
  unfold IsSkew at *; rw [Matrix.transpose_add, hx, hy, neg_add]
theorem skew_smul' (c : ℝ) {x : Matrix ι ι ℝ} (hx : IsSkew x) : IsSkew (c • x) := by
  unfold IsSkew at *; rw [Matrix.transpose_smul, hx, smul_neg]

/-- `𝔰𝔬(ι)` as a submodule. -/
def soSub (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (Matrix ι ι ℝ) where
  carrier := {A | IsSkew A}
  add_mem' := fun ha hb => skew_add' ha hb
  zero_mem' := by show IsSkew (0 : Matrix ι ι ℝ); unfold IsSkew; simp
  smul_mem' := fun c _ ha => skew_smul' c ha

/-- A type synonym carrying the `inner2` inner product, free of the Pi topology. -/
def SkewSp (ι : Type*) [Fintype ι] [DecidableEq ι] : Type _ := soSub ι

instance : AddCommGroup (SkewSp ι) := inferInstanceAs (AddCommGroup (soSub ι))
instance : Module ℝ (SkewSp ι) := inferInstanceAs (Module ℝ (soSub ι))
instance : FiniteDimensional ℝ (SkewSp ι) := inferInstanceAs (FiniteDimensional ℝ (soSub ι))

def toM (x : SkewSp ι) : Matrix ι ι ℝ := (show soSub ι from x).1
def ofM (A : Matrix ι ι ℝ) (hA : IsSkew A) : SkewSp ι := (⟨A, hA⟩ : soSub ι)

theorem toM_skew (x : SkewSp ι) : IsSkew (toM x) := (show soSub ι from x).2
@[simp] theorem toM_ofM (A : Matrix ι ι ℝ) (hA : IsSkew A) : toM (ofM A hA) = A := rfl
@[simp] theorem toM_add (x y : SkewSp ι) : toM (x + y) = toM x + toM y := rfl
@[simp] theorem toM_smul (c : ℝ) (x : SkewSp ι) : toM (c • x) = c • toM x := rfl
@[simp] theorem toM_zero : toM (0 : SkewSp ι) = 0 := rfl
theorem toM_injective : Function.Injective (toM (ι := ι)) := fun x y h =>
  (Subtype.ext h : (show soSub ι from x) = (show soSub ι from y))
theorem toM_sum {κ : Type*} (s : Finset κ) (f : κ → SkewSp ι) : toM (∑ k ∈ s, f k) = ∑ k ∈ s, toM (f k) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, toM_add, ih]

theorem inner2_self_nonneg (X : Matrix ι ι ℝ) : 0 ≤ inner2 X X := by
  unfold inner2
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply]
  exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
    mul_self_nonneg _)

theorem inner2_self_eq_zero {X : Matrix ι ι ℝ} (h : inner2 X X = 0) : X = 0 := by
  unfold inner2 at h
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply] at h
  have h' : ∑ i, ∑ j, X j i * X j i = 0 := by linarith
  ext a b
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => Finset.sum_nonneg fun j _ =>
    mul_self_nonneg (X j i))).mp h' b (Finset.mem_univ b)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => mul_self_nonneg (X j b))).mp h1 a
    (Finset.mem_univ a)
  simpa using mul_self_eq_zero.mp h2

noncomputable def core : InnerProductSpace.Core ℝ (SkewSp ι) where
  inner x y := inner2 (toM x) (toM y)
  conj_inner_symm x y := by simp [inner2_comm]
  re_inner_nonneg x := inner2_self_nonneg _
  add_left x y z := by
    show inner2 (toM (x + y)) (toM z) = _
    rw [toM_add, inner2_add_l']
  smul_left x y r := by
    show inner2 (toM (r • x)) (toM y) = _
    rw [toM_smul, inner2_smul_l']; simp
  definite x h := toM_injective (by rw [inner2_self_eq_zero h, toM_zero])

noncomputable instance : NormedAddCommGroup (SkewSp ι) := core.toNormedAddCommGroup
noncomputable instance : InnerProductSpace ℝ (SkewSp ι) := InnerProductSpace.ofCore core.toCore

theorem inner_def (x y : SkewSp ι) : (inner ℝ x y) = inner2 (toM x) (toM y) := rfl

/-- **Any orthonormal family of bivectors extends to a complete orthonormal family.** -/
theorem extend_frame {Γ0 : Type*} [Fintype Γ0] [DecidableEq Γ0] (f : Γ0 → Matrix ι ι ℝ) (hskew : ∀ a, IsSkew (f a))
    (hon : ∀ a b, inner2 (f a) (f b) = if a = b then 1 else 0) :
    ∃ (r : ℕ) (g : Fin r → Matrix ι ι ℝ), (∀ c, IsSkew (g c)) ∧
      (∀ c d, inner2 (g c) (g d) = if c = d then 1 else 0) ∧ (∀ a c, inner2 (f a) (g c) = 0) ∧
      (∀ X, IsSkew X → X = ∑ a, inner2 X (f a) • f a + ∑ c, inner2 X (g c) • g c) := by
  classical
  let F : Γ0 → SkewSp ι := fun a => ofM (f a) (hskew a)
  have hFon : Orthonormal ℝ F := by
    rw [orthonormal_iff_ite]; intro a b; exact hon a b
  have hFinj : Function.Injective F := hFon.linearIndependent.injective
  have hset : Orthonormal ℝ ((↑) : Set.range F → SkewSp ι) := by
    rw [orthonormal_iff_ite]
    rintro ⟨_, a, rfl⟩ ⟨_, b, rfl⟩
    rw [(orthonormal_iff_ite.mp hFon) a b]
    by_cases h : a = b
    · subst h; simp
    · rw [if_neg h, if_neg]; exact fun h' => h (hFinj (congrArg Subtype.val h'))
  obtain ⟨u, b, hsub, hb⟩ := hset.exists_orthonormalBasis_extension
  let w : Finset (SkewSp ι) := u.filter (fun x => x ∉ Set.range F)
  let e := w.equivFin
  refine ⟨w.card, fun c => toM (e.symm c).1, fun c => toM_skew _, fun c d => ?_, fun a c => ?_,
    fun X hX => ?_⟩
  · have hu : Orthonormal ℝ ((↑) : u → SkewSp ι) := hb ▸ b.orthonormal
    have hw : ∀ c, (e.symm c).1 ∈ u := fun c => (Finset.mem_filter.mp (e.symm c).2).1
    have := (orthonormal_iff_ite.mp hu) ⟨_, hw c⟩ ⟨_, hw d⟩
    rw [← inner_def]
    rw [this]
    simp only [Subtype.mk.injEq]
    by_cases h : c = d
    · simp [h]
    · have : (e.symm c).1 ≠ (e.symm d).1 := fun h' => h (e.symm.injective (Subtype.ext h'))
      simp [h, this]
  · have hu : Orthonormal ℝ ((↑) : u → SkewSp ι) := hb ▸ b.orthonormal
    have hFa : F a ∈ u := hsub (Set.mem_range_self a)
    have hw := Finset.mem_filter.mp (e.symm c).2
    have := (orthonormal_iff_ite.mp hu) ⟨_, hFa⟩ ⟨_, hw.1⟩
    rw [show inner2 (f a) (toM (e.symm c).1) = inner ℝ (F a) (e.symm c).1 from rfl, this]
    have hne : F a ≠ (e.symm c).1 := fun h => hw.2 (h ▸ Set.mem_range_self a)
    simp [hne]
  · have hx := b.sum_repr (ofM X hX)
    have hx2 : X = ∑ i ∈ u, inner2 (toM i) X • toM i := by
      have := congrArg toM hx
      rw [toM_sum] at this
      simp only [toM_smul, toM_ofM, OrthonormalBasis.repr_apply_apply, hb] at this
      conv_lhs => rw [← this]
      exact Finset.sum_coe_sort u (fun i => inner2 (toM i) X • toM i)
    rw [← Finset.sum_filter_add_sum_filter_not u (fun x => x ∈ Set.range F)] at hx2
    have himg : u.filter (fun x => x ∈ Set.range F) = Finset.univ.image F := by
      ext y
      simp only [Finset.mem_filter, Finset.mem_image, Finset.mem_univ, true_and, Set.mem_range]
      constructor
      · rintro ⟨_, a, rfl⟩; exact ⟨a, rfl⟩
      · rintro ⟨a, rfl⟩; exact ⟨hsub (Set.mem_range_self a), a, rfl⟩
    rw [himg, Finset.sum_image (fun a _ b _ h => hFinj h)] at hx2
    rw [← Finset.sum_coe_sort w (fun i => inner2 (toM i) X • toM i), ← e.symm.sum_comp] at hx2
    conv_lhs => rw [hx2]
    simp only [F, toM_ofM, inner2_comm X]

end HamiltonsCubic.FrameExtension
