import Mathlib
import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# L264 (1) in full: the maximiser's idempotent is positive definite on its support

[findings/second-order.md](../../../findings/second-order.md), Lemma L264 (1): *"Let $X$ maximise $F$ on the unit
sphere of $\operatorname{Sym}^2\mathfrak{so}(n)$, taken positive semidefinite by L260 (1). Then $C=X/F(X)$ is an
idempotent, positive definite on the semisimple subalgebra $\mathfrak h$ it is supported on, and stable."*
[I117Statements.lean](I117Statements.lean) proves idempotency and stability (`L264_maximiser_stable`, with
`0 < F(X)` a hypothesis) and, separately, L260 (2) (`L260_range_subalgebra`); the L264 row owes *"(1)'s positive
definiteness of C on its support, which is L260 (2)"*. This file composes them and discharges `0 < F(X)`:

* `normSq2_id_pos`: `‖I‖² > 0` for `n ≥ 2`;
* `maximiser_pos`: at `n ≥ 3` a maximiser of `F` on the unit sphere of self-adjoint operators has `F(X) > 0`,
  since `F(I/‖I‖) = (n - 2)/‖I‖ > 0` (`Ftri_id`);
* `L264_one`: at a positive semidefinite such maximiser, `C = X/F(X)` is idempotent, stable, self-adjoint,
  positive semidefinite, its range is closed under the bracket and spanned by brackets of its elements (a perfect
  subalgebra), and `C` is positive definite on it;
* `L264_one_exists`: a positive semidefinite maximiser exists (`exists_sa_maximiser`, `L260_psd_cone`), and
  `L264_one_some` is the combined existence form.

A perfect subalgebra of the compact `𝔰𝔬(n)` is semisimple, which is the record's wording; that step is prose.
-/

namespace HamiltonsCubic.L264Support

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem normSq2_id_pos (hn : 2 ≤ Fintype.card ι) : 0 < normSq2 (idOp : CurvOp2 ι) := by
  obtain ⟨i, j, hij⟩ := Fintype.exists_pair_of_one_lt_card (by omega : 1 < Fintype.card ι)
  have hid0 : normSq2 (idOp : CurvOp2 ι) ≠ 0 := by
    intro h
    have h0 := normSq2_eq_zero h
    have := congrArg (fun R : CurvOp2 ι => ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) j i) h0
    simp [phi, hij, Ne.symm hij] at this
  exact lt_of_le_of_ne (normSq2_nonneg _) (Ne.symm hid0)

/-- **A maximiser has `F(X) > 0`** at `n ≥ 3`. -/
theorem maximiser_pos (hn : 3 ≤ Fintype.card ι) (X : CurvOp2 ι)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X) :
    0 < Ftri X X X := by
  have hI := normSq2_id_pos (ι := ι) (by omega)
  set s := 1 / Real.sqrt (normSq2 (idOp : CurvOp2 ι)) with hs
  have hr0 : 0 < Real.sqrt (normSq2 (idOp : CurvOp2 ι)) := Real.sqrt_pos.mpr hI
  have hs0 : 0 < s := one_div_pos.mpr hr0
  have hr2 : Real.sqrt (normSq2 (idOp : CurvOp2 ι)) ^ 2 = normSq2 (idOp : CurvOp2 ι) := Real.sq_sqrt hI.le
  have hn1 : normSq2 (s • (idOp : CurvOp2 ι)) = 1 := by
    rw [normSq2_smul', hs, div_pow, one_pow, hr2]; exact one_div_mul_cancel hI.ne'
  have hF : Ftri (s • (idOp : CurvOp2 ι)) (s • idOp) (s • idOp)
      = s ^ 3 * (((Fintype.card ι : ℝ) - 2) * normSq2 (idOp : CurvOp2 ι)) := by
    rw [Ftri_smul_left, Ftri_smul_mid, Ftri_smul_right, Ftri_id]
    unfold normSq2; ring
  have hn2 : (0 : ℝ) < (Fintype.card ι : ℝ) - 2 := by
    have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    linarith
  have hpos : 0 < Ftri (s • (idOp : CurvOp2 ι)) (s • idOp) (s • idOp) := by
    rw [hF]; positivity
  exact lt_of_lt_of_le hpos (hmax _ (isSelfAdjoint2_smul idOp_isSelfAdjoint2 s) hn1)

/-- **L264 (1) in full.** -/
theorem L264_one (hn : 3 ≤ Fintype.card ι) (X : CurvOp2 ι) (hX : IsSelfAdjoint2 X) (hXp : IsPSD2 X)
    (hunit : normSq2 X = 1)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X) :
    let C := (1 / Ftri X X X) • X
    IsIdem C ∧ IsStable C ∧ IsSelfAdjoint2 C ∧ IsPSD2 C ∧
    (∀ A B : skewSub ι, A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) →
        B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) →
        brS A B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι)) ∧
    LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι)
      = Submodule.span ℝ {Z | ∃ A B, A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧
          B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧ Z = brS A B} ∧
    (∀ A : skewSub ι, A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) → A ≠ 0 →
        0 < inner2 ((C A : skewSub ι) : Matrix ι ι ℝ) ((A : skewSub ι) : Matrix ι ι ℝ)) := by
  intro C
  have hpos := maximiser_pos hn X hmax
  obtain ⟨hidem, hstab⟩ := L264_maximiser_stable X hX hunit hmax hpos
  have hCsa : IsSelfAdjoint2 C := isSelfAdjoint2_smul hX _
  have hCp : IsPSD2 C := isPSD2_smul hXp (le_of_lt (one_div_pos.mpr hpos))
  obtain ⟨h1, h2, h3⟩ := L260_range_subalgebra C hCsa hCp hidem
  exact ⟨hidem, hstab, hCsa, hCp, h1, h2, h3⟩

/-- **A positive semidefinite maximiser exists** at `n ≥ 2`. -/
theorem L264_one_exists (hn : 2 ≤ Fintype.card ι) :
    ∃ X : CurvOp2 ι, IsSelfAdjoint2 X ∧ IsPSD2 X ∧ normSq2 X = 1 ∧
      ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X := by
  obtain ⟨X, hX, hX1, hmax⟩ := exists_sa_maximiser (ι := ι) hn
  obtain ⟨Y, hY, hYp, hYn, hXY⟩ := L260_psd_cone X hX
  rw [hX1] at hYn
  exact ⟨Y, hY, hYp, hYn, fun W hW hW1 => (hmax W hW hW1).trans hXY⟩

/-- **L264 (1), existence form**: at `n ≥ 3` some `C = X/F(X)`, `X` a positive semidefinite unit maximiser, is
an idempotent, stable, self-adjoint and positive semidefinite, positive definite on its range, a perfect
subalgebra. -/
theorem L264_one_some (hn : 3 ≤ Fintype.card ι) :
    ∃ C : CurvOp2 ι, IsIdem C ∧ IsStable C ∧ IsSelfAdjoint2 C ∧ IsPSD2 C ∧
      (∀ A B : skewSub ι, A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) →
        B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) →
        brS A B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι)) ∧
      LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι)
        = Submodule.span ℝ {Z | ∃ A B, A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧
          B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧ Z = brS A B} ∧
      (∀ A : skewSub ι, A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) → A ≠ 0 →
        0 < inner2 ((C A : skewSub ι) : Matrix ι ι ℝ) ((A : skewSub ι) : Matrix ι ι ℝ)) := by
  obtain ⟨X, hX, hXp, hX1, hmax⟩ := L264_one_exists (ι := ι) (by omega)
  exact ⟨_, L264_one hn X hX hXp hX1 hmax⟩

end HamiltonsCubic.L264Support
