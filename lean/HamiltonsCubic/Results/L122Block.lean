import HamiltonsCubic.Results.L121Block

set_option linter.style.longLine false

/-!
# L122's bracketed form: the pair block of `L_M` is `½[diag(M_ji + M_ki) − M_jk Id + M^{(jk)}]`

[findings/second-order.md](../../../findings/second-order.md), Lemma L122: *"Let `M` be a coordinate-diagonal Weyl
operator with sectional matrix `M_ab`, and fix a pair `{j,k}`. In the basis `f_i = e_ji ⊙ e_ki`, `i ∉ {j,k}`, the pair
block of `L_M` is `½[diag(M_ji + M_ki) − M_jk Id + M^{(jk)}]`"*, with `M^{(jk)}` the hollow submatrix on the other
indices. *"The bracketed form needs diagonality alone."* [L122Statement.lean](L122Statement.lean) proves the Kirchhoff
rewriting of this matrix; this file proves that it is the block, from [L121Block.lean](L121Block.lean)'s closed form
of the polarised `#` against a rank-two operator:

* **`bracket_pair`**: at distinct `j, k, i` and a bivector `X`, the bracket half is
  `[φ_ji, W[X,φ_ki]] + [φ_ki, W[X,φ_ji]] = −w_jk f_i X + ∑_{i'} w_ii' f_i' X`, the terms at `i' ∈ {j, k, i}`
  vanishing because `φ_jj = φ_kk = 0` and `w` is hollow;
* **`pairBlock`**: `M ∘ f_i = ½((w_ji + w_ki − w_jk) f_i + ∑_{i'} w_ii' f_i')` on every bivector, the record's matrix
  column by column, at a symmetric hollow weight.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

open HamiltonsCubic.FamilyLayer in
/-- **THE PAIR-BLOCK BRACKET.** -/
theorem bracket_pair (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) {j k i : ι}
    (hjk : j ≠ k) (hji : j ≠ i) (hki : k ≠ i) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    br (phi j i) (diagOp w (br X (phi k i))) + br (phi k i) (diagOp w (br X (phi j i)))
      = -(w j k) • rk2 (phi j i) (phi k i) X + ∑ q, w i q • rk2 (phi j q) (phi k q) X := by
  have hp : ∀ p q, inner2 (phi p q) X = - X p q := fun p q => by rw [inner2_comm, inner2_phi X hX]
  simp only [rk2, hp]
  have hX2 : X = (1 / 2 : ℝ) • (X - Xᵀ) := by
    have : Xᵀ = -X := hX
    rw [this, sub_neg_eq_add, ← two_smul ℝ X, smul_smul]; norm_num
  rw [hX2]
  clear hX hp hX2
  ext a b
  simp only [br, phi, diagOp, Matrix.of_apply, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply,
    Matrix.mul_apply, Matrix.single_apply, Matrix.transpose_apply, Matrix.mul_sub, Matrix.sub_mul, smul_eq_mul,
    Matrix.sum_apply, Matrix.neg_apply, neg_smul, Matrix.neg_apply]
  simp only [ite_and, mul_ite, ite_mul, mul_one, one_mul, mul_zero, zero_mul, Finset.sum_ite_eq,
    Finset.mem_univ, if_true]
  rcases (show j = a ∨ k = a ∨ i = a ∨ (a ≠ j ∧ a ≠ k ∧ a ≠ i ∧ j ≠ a ∧ k ≠ a ∧ i ≠ a) by tauto)
    with ha | ha | ha | ha <;> (try subst ha) <;>
  rcases (show j = b ∨ k = b ∨ i = b ∨ (b ≠ j ∧ b ≠ k ∧ b ≠ i ∧ j ≠ b ∧ k ≠ b ∧ i ≠ b) by tauto)
    with hb | hb | hb | hb <;> (try subst hb) <;>
  simp_all [hjk.symm, hji.symm, hki.symm] <;> ring_nf

open HamiltonsCubic.FamilyLayer in
/-- **L122'S BRACKETED FORM**: at a symmetric hollow weight and distinct `j, k, i`,
`M ∘ f_i = ½((w_ji + w_ki − w_jk) f_i + ∑_{i'} w_ii' f_i')` on every bivector, `f_i = φ_ji ⊙ φ_ki`, which is column
`i` of `½[diag(M_ji + M_ki) − M_jk Id + M^{(jk)}]`. -/
theorem pairBlock (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) {j k i : ι}
    (hjk : j ≠ k) (hji : j ≠ i) (hki : k ≠ i) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    foxProd (diagOp w) (rk2 (phi j i) (phi k i)) X
      = (1 / 2 : ℝ) • ((w j i + w k i - w j k) • rk2 (phi j i) (phi k i) X
          + ∑ q, w i q • rk2 (phi j q) (phi k q) X) := by
  have hR := isLinOp_diagOp w
  rw [foxProd_split _ _ hR.1 (isLinOp_rk2 _ _).1]
  change jordanProd (diagOp w) (rk2 (phi j i) (phi k i)) X + sharpCross (diagOp w) (rk2 (phi j i) (phi k i)) X = _
  rw [sharpCross_rk2 (diagOp w) hR (fun A B => diagOp_selfAdjoint w A B) (fun A hA => diagOp_skew w hw A hA)
    (phi_isSkew j i) (phi_isSkew k i) hX, bracket_pair w hw hh hjk hji hki hX]
  unfold jordanProd rk2
  rw [hR.1, hR.2, hR.2, diagOp_phi w hw, diagOp_phi w hw, ← diagOp_selfAdjoint w (phi k i),
    ← diagOp_selfAdjoint w (phi j i), diagOp_phi w hw, diagOp_phi w hw, ip_smul_l, ip_smul_l]
  simp only [smul_add, Finset.smul_sum]
  module

end HamiltonsCubic.L121Block
