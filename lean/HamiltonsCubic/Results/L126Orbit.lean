import HamiltonsCubic.Results.L121Block

set_option linter.style.longLine false

/-!
# L126's orbit-freeness: the orbit tangent at a diagonal `M` is orthogonal to every four-set operator

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *"The four-set blocks are orbit-free: the
orbit tangent for the `(j,k)` generator lies in the `{j,k}` pair block, so the orbit's tangent space lies in the span
of the pair blocks."* The orbit of `M` under `SO(n)` has tangent `T_{jk} = [ad φ_jk, M]`,
`Y ↦ [φ_jk, M Y] − M [φ_jk, Y]`. This file proves the consequence L126 spends:

* **`innerOp_rk2`**: `⟨F, U ⊙ V⟩ = ⟨F V, U⟩ + ⟨F U, V⟩` for a linear `F` and bivectors `U`, `V`;
* **`orbit_perp_pair`**: at a diagonal `M`, `⟨T_{jk} φ_cd, φ_ab⟩ = 0` whenever `{a,b}` and `{c,d}` are disjoint, since
  `[φ_jk, φ_cd]` is spanned by bivectors carrying an index of `{c,d}`;
* **`orbit_perp_fourSet`**: so `⟨T_{jk}, φ_ab ⊙ φ_cd⟩ = 0` for every generator `(j,k)` and every pair of disjoint
  pairs, in particular for the three operators spanning each four-set block.

* **`orbit_in_pairBlock`**: the record's stronger form, `T_{jk} = ∑_i (w_ji − w_ki) (φ_ji ⊙ φ_ki)` on bivectors at
  `j ≠ k`, so the orbit tangent lies in the `{j,k}` pair block.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The orbit tangent of `M` along the generator `φ_jk`. -/
noncomputable def orbitTan (M : CurvOp ι) (j k : ι) : CurvOp ι :=
  fun Y => br (phi j k) (M Y) - M (br (phi j k) Y)

omit [Fintype ι] [DecidableEq ι] in
theorem lin_sum (F : CurvOp ι) (hF : IsLinOp F) {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ) :
    F (∑ x ∈ s, f x) = ∑ x ∈ s, F (f x) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    have := hF.2 0 0
    simp only [zero_smul] at this
    simpa using this
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, hF.1, ih]

/-- **The pairing against `U ⊙ V`**: `⟨F, U ⊙ V⟩ = ⟨F V, U⟩ + ⟨F U, V⟩`. -/
theorem innerOp_rk2 (F : CurvOp ι) (hF : IsLinOp F) {U V : Matrix ι ι ℝ} (hU : IsSkew U) (hV : IsSkew V) :
    innerOp F (rk2 U V) = inner2 (F V) U + inner2 (F U) V := by
  have key : ∀ {P : Matrix ι ι ℝ} (_ : IsSkew P) (Q : Matrix ι ι ℝ),
      ∑ i : ι, ∑ j : ι, inner2 P (phi i j) * inner2 (F (phi i j)) Q = 2 * inner2 (F P) Q := by
    intro P hP Q
    conv_rhs => rw [← skew_expand P hP]
    rw [hF.2, lin_sum F hF, ip_smul_l, ip_sum_l]
    simp only [lin_sum F hF, ip_sum_l, hF.2, ip_smul_l]
    rw [← mul_assoc]; norm_num
  unfold innerOp rk2
  simp only [ip_add_r, ip_smul_r, Finset.sum_add_distrib, key hV, key hU]
  ring

/-- **`⟨T_{jk} φ_cd, φ_ab⟩ = 0` for disjoint pairs**, at a diagonal `M`. -/
theorem orbit_perp_pair (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (j k a b c d : ι) (hac : a ≠ c) (had : a ≠ d)
    (hbc : b ≠ c) (hbd : b ≠ d) :
    inner2 (orbitTan (diagOp w) j k (phi c d)) (phi a b) = 0 := by
  have hbr : inner2 (br (phi j k) (phi c d)) (phi a b) = 0 := by
    rw [br_phi_phi]
    simp only [ip_add_l, ip_smul_l, inner2_sub_left, inner2_phi_phi]
    simp [hac.symm, had.symm, hbc.symm, hbd.symm]
  unfold orbitTan
  rw [diagOp_phi w hw, br_smul_right, inner2_sub_left, ip_smul_l, diagOp_selfAdjoint, diagOp_phi w hw,
    ip_smul_r, hbr]
  ring

theorem isLinOp_orbitTan (M : CurvOp ι) (hM : IsLinOp M) (j k : ι) : IsLinOp (orbitTan M j k) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · unfold orbitTan; rw [hM.1, br_add_right, br_add_right, hM.1]; abel
  · unfold orbitTan; rw [hM.2, br_smul_right, br_smul_right, hM.2, smul_sub]

/-- **THE FOUR-SET OPERATORS ARE ORBIT-FREE**: at a diagonal `M`, the orbit tangent along every generator `φ_jk` is
orthogonal to `φ_ab ⊙ φ_cd` for every two disjoint pairs, in particular to each of the three operators spanning a
four-set block (`fourSet_G`). -/
theorem orbit_perp_fourSet (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (j k a b c d : ι) (hac : a ≠ c)
    (had : a ≠ d) (hbc : b ≠ c) (hbd : b ≠ d) :
    innerOp (orbitTan (diagOp w) j k) (rk2 (phi a b) (phi c d)) = 0 := by
  rw [innerOp_rk2 _ (isLinOp_orbitTan _ (isLinOp_diagOp w) j k) (phi_isSkew a b) (phi_isSkew c d),
    orbit_perp_pair w hw j k a b c d hac had hbc hbd,
    orbit_perp_pair w hw j k c d a b hac.symm hbc.symm had.symm hbd.symm, add_zero]

/-- **THE ORBIT TANGENT LIES IN THE `{j,k}` PAIR BLOCK**, the record's form: at a diagonal `M` and `j ≠ k`,
`T_{jk} X = ∑_i (w_ji − w_ki) (φ_ji ⊙ φ_ki) X` on every bivector `X`. The terms at `i = j` and `i = k` vanish, since
`φ_jj = φ_kk = 0`, so the sum runs over the pair block's basis `f_i = φ_ji ⊙ φ_ki`, `i ∉ {j,k}`. -/
theorem orbit_in_pairBlock (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) {j k : ι} (hjk : j ≠ k)
    {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    orbitTan (diagOp w) j k X = ∑ i, (w j i - w k i) • rk2 (phi j i) (phi k i) X := by
  have hp : ∀ p q, inner2 (phi p q) X = - X p q := fun p q => by rw [inner2_comm, inner2_phi X hX]
  simp only [rk2, hp]
  have hX2 : X = (1 / 2 : ℝ) • (X - Xᵀ) := by
    have : Xᵀ = -X := hX
    rw [this, sub_neg_eq_add, ← two_smul ℝ X, smul_smul]; norm_num
  rw [hX2]
  clear hX hp hX2
  ext a b
  simp only [orbitTan, br, phi, diagOp, Matrix.of_apply, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply,
    Matrix.mul_apply, Matrix.single_apply, Matrix.transpose_apply, Matrix.mul_sub, Matrix.sub_mul, smul_eq_mul,
    Matrix.sum_apply]
  simp only [ite_and, mul_ite, ite_mul, mul_one, one_mul, mul_zero, zero_mul, Finset.sum_ite_eq,
    Finset.mem_univ, if_true]
  rcases (show j = a ∨ k = a ∨ (a ≠ j ∧ a ≠ k ∧ j ≠ a ∧ k ≠ a) by tauto) with ha | ha | ha <;> (try subst ha) <;>
  rcases (show j = b ∨ k = b ∨ (b ≠ j ∧ b ≠ k ∧ j ≠ b ∧ k ≠ b) by tauto) with hb | hb | hb <;> (try subst hb) <;>
  simp_all [mul_ite, Finset.sum_ite_eq, hjk.symm] <;> ring_nf

end HamiltonsCubic.L121Block
