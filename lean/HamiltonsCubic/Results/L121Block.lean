import HamiltonsCubic.Base.SharpDiag
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.FoxBilinear

set_option linter.style.longLine false

/-!
# L121's four-set block: `L_M` on the four-set space is `½G`

[findings/second-order.md](../../../findings/second-order.md), Lemma L121: *"in signed coordinates `L_M` restricted to
the `4`-set space is `½G` with `G = [[A,C,B],[C,B,A],[B,A,C]]`"*, with `A = M_ij + M_kl`, `B = M_ik + M_jl`,
`C = M_il + M_jk` the opposite-pair sums of a pair-diagonal `M`. [L121.lean](L121.lean) proves `G`'s spectrum, and
this file proves that `G` is the block.

**The polarised `#` against a rank-two operator has a closed form**, and that is the whole mechanism:

* **`sharpCross_rk2`**: for `R` linear, self-adjoint and preserving bivectors, and `U`, `V` bivectors,
  `R # (U ⊙ V)` sends a bivector `X` to `½([U, R[X,V]] + [V, R[X,U]])`, where `U ⊙ V` is `rk2 U V`,
  `X ↦ ⟨V,X⟩U + ⟨U,X⟩V`;
* **`foxProd_diag_rk2`**: at `R = diagOp w` the Fox product `M ∘ (U ⊙ V)` is the Jordan half
  `½(w_U + w_V)(U ⊙ V)` on basis bivectors plus that bracket;
* **`bracket_four`**: at four distinct indices the bracket half is `B (φ_il ⊙ φ_jk) − C (φ_ik ⊙ φ_jl)`;
* **`fourSet_block`**: at four distinct indices, `M ∘ H_A = ½(A H_A − C H_B + B H_C)` on every bivector, with
  `H_A = φ_ij ⊙ φ_kl`, `H_B = φ_ik ⊙ φ_jl`, `H_C = φ_il ⊙ φ_jk`, the Jordan half giving `½A H_A`;
* **`fourSet_G`**: in the signed basis `(H_A, −H_B, H_C)` the three columns of the block are `½(A,C,B)`,
  `½(C,B,A)` and `½(B,A,C)`, the record's matrix and its `diag(1,−1,1)` sign flip;
* **`fourSet_span`**: through `∘`'s linearity in its second slot ([FoxBilinear.lean](../Base/FoxBilinear.lean)'s
  `foxProd_add_right` and `foxProd_smul_right`), `M ∘ (x a + y b + z c) = ½((Ax + Cy + Bz) a + (Cx + By + Az) b +
  (Bx + Ay + Cz) c)`, **so the four-set span is invariant under `L_M = M ∘ ·` and `L_M` acts on it as `½G`**.

`M` is the diagonal operator `diagOp w` of a symmetric weight `w`, and the argument uses diagonality alone, as the block says (*"the block and its spectrum need diagonality alone"*): hollowness, Ricci-flatness and
criticality are free.

* **`fourSet_bianchi`**: first Bianchi AT THE TUPLE `(i,j,k,l)` reads `x + y + z` on `x a + y b + z c`, which is the
  record's `𝟏^⊥`. Every other tuple is [L121Bianchi.lean](L121Bianchi.lean)'s `fourSet_bianchi_iff`.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The pairing and the bracket -/

omit [DecidableEq ι] in
theorem ip_add_l (A B C : Matrix ι ι ℝ) : inner2 (A + B) C = inner2 A C + inner2 B C := by
  unfold inner2; rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

omit [DecidableEq ι] in
theorem ip_add_r (A B C : Matrix ι ι ℝ) : inner2 A (B + C) = inner2 A B + inner2 A C := by
  unfold inner2; rw [Matrix.mul_add, Matrix.trace_add]; ring

omit [DecidableEq ι] in
theorem ip_smul_l (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 (c • A) B = c * inner2 A B := by
  unfold inner2; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring

omit [DecidableEq ι] in
theorem ip_smul_r (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 A (c • B) = c * inner2 A B := by
  unfold inner2; rw [Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]; ring

theorem ip_sum_l {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    inner2 (∑ k ∈ s, f k) X = ∑ k ∈ s, inner2 (f k) X := by
  rw [inner2_comm, inner2_sum_right]
  exact Finset.sum_congr rfl fun k _ => inner2_comm _ _

omit [DecidableEq ι] in
/-- **`ad` is skew for the pairing**: `⟨[X,Y],Z⟩ = −⟨Y,[X,Z]⟩` at a bivector `X`. -/
theorem ip_br_left {X : Matrix ι ι ℝ} (hX : IsSkew X) (Y Z : Matrix ι ι ℝ) :
    inner2 (br X Y) Z = - inner2 Y (br X Z) := by
  unfold inner2 br
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hX]
  have h1 : (X * (Yᵀ * Z)).trace = (Yᵀ * (Z * X)).trace := by
    rw [Matrix.trace_mul_comm, Matrix.mul_assoc]
  simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.trace_sub, Matrix.neg_mul, Matrix.mul_neg,
    Matrix.trace_neg, Matrix.mul_assoc, h1]
  ring

omit [DecidableEq ι] in
theorem br_skew {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) : IsSkew (br X Y) := by
  unfold IsSkew at *
  unfold br
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hX, hY]
  simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg, neg_sub]

omit [DecidableEq ι] in
theorem br_anti (X Y : Matrix ι ι ℝ) : br Y X = - br X Y := by unfold br; abel

/-- **The `φ` family resolves the pairing**: `∑_{pq} ⟨V,φ_pq⟩⟨Z,φ_pq⟩ = 2⟨V,Z⟩` at a bivector `V`. -/
theorem resolve {V : Matrix ι ι ℝ} (hV : IsSkew V) (Z : Matrix ι ι ℝ) :
    ∑ p : ι, ∑ q : ι, inner2 V (phi p q) * inner2 Z (phi p q) = 2 * inner2 V Z := by
  conv_rhs => rw [← skew_expand V hV]
  rw [ip_smul_l, ip_sum_l]
  simp only [ip_sum_l, ip_smul_l]
  rw [← mul_assoc]
  norm_num
  exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => by rw [inner2_comm Z]

/-! ## The rank-two operator `U ⊙ V` and the polarised `#` against it -/

/-- `U ⊙ V`, the operator `X ↦ ⟨V,X⟩U + ⟨U,X⟩V`. -/
noncomputable def rk2 (U V : Matrix ι ι ℝ) : CurvOp ι := fun X => inner2 V X • U + inner2 U X • V

omit [DecidableEq ι] in
theorem isLinOp_rk2 (U V : Matrix ι ι ℝ) : IsLinOp (rk2 U V) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · simp only [rk2, ip_add_r, add_smul]; abel
  · simp only [rk2, ip_smul_r, mul_smul, smul_add]

/-- The mixed term of `sharpBil_expand`, one ordering of the two operators. -/
noncomputable def T (R S : CurvOp ι) (X Y : Matrix ι ι ℝ) : ℝ :=
  ∑ p : ι, ∑ q : ι, inner2 (br X (R (br Y (S (phi p q))))) (phi p q)

/-- **Polarising `sharpBil` in the operator**: the cross terms are the four `T`s. -/
theorem sharpBil_mixed (R S : CurvOp ι) (hR : IsLinOp R) (hS : IsLinOp S) (X Y : Matrix ι ι ℝ) :
    sharpBil (R + S) X Y - sharpBil R X Y - sharpBil S X Y
      = -(1 / 8 : ℝ) * (T R S X Y + T S R X Y + T R S Y X + T S R Y X) := by
  have hRS : IsLinOp (R + S) :=
    ⟨fun A B => by simp only [Pi.add_apply, hR.1, hS.1]; abel,
     fun c A => by simp only [Pi.add_apply, hR.2, hS.2, smul_add]⟩
  rw [sharpBil_expand _ hRS, sharpBil_expand _ hR, sharpBil_expand _ hS]
  unfold T
  simp only [Pi.add_apply, br_add_right, hR.1, hS.1, ip_add_l, Finset.sum_add_distrib]
  ring

/-- **`T R (U ⊙ V)`**: `−2(⟨R[Y,U],[X,V]⟩ + ⟨R[Y,V],[X,U]⟩)`. -/
theorem T_R_rk2 (R : CurvOp ι) (hR : IsLinOp R) {U V X : Matrix ι ι ℝ} (hU : IsSkew U) (hV : IsSkew V)
    (hX : IsSkew X) (Y : Matrix ι ι ℝ) :
    T R (rk2 U V) X Y = -2 * (inner2 (R (br Y U)) (br X V) + inner2 (R (br Y V)) (br X U)) := by
  unfold T rk2
  simp only [br_add_right, br_smul_right, hR.1, hR.2, ip_add_l, ip_smul_l, Finset.sum_add_distrib]
  rw [resolve hV, resolve hU, inner2_comm V, inner2_comm U, ip_br_left hX, ip_br_left hX]
  ring

/-- **`T (U ⊙ V) R`** has the same value, at a self-adjoint `R` preserving bivectors. -/
theorem T_rk2_R (R : CurvOp ι) (hsa : ∀ A B, inner2 (R A) B = inner2 A (R B))
    (hsk : ∀ A, IsSkew A → IsSkew (R A)) {U V X Y : Matrix ι ι ℝ} (hU : IsSkew U) (hV : IsSkew V)
    (_hX : IsSkew X) (hY : IsSkew Y) :
    T (rk2 U V) R X Y = -2 * (inner2 (R (br Y U)) (br X V) + inner2 (R (br Y V)) (br X U)) := by
  unfold T rk2
  simp only [br_add_right, br_smul_right, ip_add_l, ip_smul_l, Finset.sum_add_distrib]
  have e : ∀ (W : Matrix ι ι ℝ) (p q : ι), inner2 W (br Y (R (phi p q))) = - inner2 (R (br Y W)) (phi p q) := by
    intro W p q
    rw [inner2_comm, ip_br_left hY, hsa, inner2_comm]
  simp only [e, neg_mul, Finset.sum_neg_distrib]
  rw [resolve (hsk _ (br_skew hY hV)), resolve (hsk _ (br_skew hY hU))]
  ring

/-- **The mixed `sharpBil` against `U ⊙ V`, as a pairing with `Y`**:
`⟨Y, [U, R[X,V]] + [V, R[X,U]]⟩`. -/
theorem mixed_rk2 (R : CurvOp ι) (hR : IsLinOp R) (hsa : ∀ A B, inner2 (R A) B = inner2 A (R B))
    (hsk : ∀ A, IsSkew A → IsSkew (R A)) {U V X Y : Matrix ι ι ℝ} (hU : IsSkew U) (hV : IsSkew V)
    (hX : IsSkew X) (hY : IsSkew Y) :
    sharpBil (R + rk2 U V) X Y - sharpBil R X Y - sharpBil (rk2 U V) X Y
      = inner2 Y (br U (R (br X V)) + br V (R (br X U))) := by
  rw [sharpBil_mixed R _ hR (isLinOp_rk2 U V), T_R_rk2 R hR hU hV hX, T_R_rk2 R hR hU hV hY,
    T_rk2_R R hsa hsk hU hV hX hY, T_rk2_R R hsa hsk hU hV hY hX]
  -- every pairing becomes `⟨Y, [U or V, R[X, V or U]]⟩`
  have k : ∀ {P : Matrix ι ι ℝ} (_ : IsSkew P) (Z : Matrix ι ι ℝ), inner2 (br Y P) Z = inner2 Y (br P Z) := by
    intro P hP Z
    rw [br_anti, show -br P Y = (-1 : ℝ) • br P Y by simp, ip_smul_l, ip_br_left hP]; ring
  rw [hsa (br Y U), hsa (br Y V), k hU, k hV, inner2_comm (R (br X U)), inner2_comm (R (br X V)), k hV, k hU,
    ip_add_r]
  ring

/-- **`R # (U ⊙ V)` IN CLOSED FORM**: on a bivector `X`, `½([U, R[X,V]] + [V, R[X,U]])`. -/
theorem sharpCross_rk2 (R : CurvOp ι) (hR : IsLinOp R) (hsa : ∀ A B, inner2 (R A) B = inner2 A (R B))
    (hsk : ∀ A, IsSkew A → IsSkew (R A)) {U V X : Matrix ι ι ℝ} (hU : IsSkew U) (hV : IsSkew V)
    (hX : IsSkew X) :
    sharpCross R (rk2 U V) X = (1 / 2 : ℝ) • (br U (R (br X V)) + br V (R (br X U))) := by
  set Z := br U (R (br X V)) + br V (R (br X U)) with hZ
  have hZs : IsSkew Z := by
    have h1 := br_skew hU (hsk _ (br_skew hX hV))
    have h2 := br_skew hV (hsk _ (br_skew hX hU))
    unfold IsSkew at *; rw [hZ, Matrix.transpose_add, h1, h2, neg_add]
  unfold sharpCross sharpOp
  have hsum : ∀ p q : ι, sharpBil (R + rk2 U V) X (phi p q) - sharpBil R X (phi p q)
      - sharpBil (rk2 U V) X (phi p q) = inner2 Z (phi p q) := fun p q => by
    rw [mixed_rk2 R hR hsa hsk hU hV hX (phi_isSkew p q), inner2_comm]
  have e : (1 / 2 : ℝ) • ((1 / 2 : ℝ) • ∑ i, ∑ j, sharpBil (R + rk2 U V) X (phi i j) • phi i j
      - (1 / 2 : ℝ) • ∑ i, ∑ j, sharpBil R X (phi i j) • phi i j
      - (1 / 2 : ℝ) • ∑ i, ∑ j, sharpBil (rk2 U V) X (phi i j) • phi i j)
      = (1 / 2 : ℝ) • ((1 / 2 : ℝ) • ∑ i, ∑ j, inner2 Z (phi i j) • phi i j) := by
    rw [← smul_sub, ← smul_sub, ← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
    simp only [← Finset.sum_sub_distrib, ← sub_smul, hsum]
  rw [e, skew_expand Z hZs]

/-! ## The four-set -/

open HamiltonsCubic.FamilyLayer in
/-- **THE FOUR-SET BRACKET**: at four distinct indices and a bivector `X`,
`[φ_ij, W[X,φ_kl]] + [φ_kl, W[X,φ_ij]] = B (φ_il ⊙ φ_jk) X − C (φ_ik ⊙ φ_jl) X`, `W = diagOp w`,
`B = w_ik + w_jl`, `C = w_il + w_jk`. *Entrywise, after writing `X` as `½(X − Xᵀ)` so that the identity is a
polynomial one, and splitting each output index over `i, j, k, l` and the rest.* -/
theorem bracket_four (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k)
    (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    br (phi i j) (diagOp w (br X (phi k l))) + br (phi k l) (diagOp w (br X (phi i j)))
      = (w i k + w j l) • rk2 (phi i l) (phi j k) X - (w i l + w j k) • rk2 (phi i k) (phi j l) X := by
  have hp : ∀ p q, inner2 (phi p q) X = - X p q := fun p q => by rw [inner2_comm, inner2_phi X hX]
  simp only [rk2, hp]
  have hX2 : X = (1 / 2 : ℝ) • (X - Xᵀ) := by
    have : Xᵀ = -X := hX
    rw [this, sub_neg_eq_add, ← two_smul ℝ X, smul_smul]; norm_num
  rw [hX2]
  clear hX hp hX2
  ext a b
  simp only [br, phi, diagOp, Matrix.of_apply, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply,
    Matrix.mul_apply, Matrix.single_apply, Matrix.transpose_apply, Matrix.mul_sub, Matrix.sub_mul, smul_eq_mul]
  simp only [ite_and, mul_ite, ite_mul, mul_one, one_mul, mul_zero, zero_mul,
    Finset.sum_ite_eq, Finset.mem_univ, if_true]
  rcases (show i = a ∨ j = a ∨ k = a ∨ l = a ∨ (a ≠ i ∧ a ≠ j ∧ a ≠ k ∧ a ≠ l ∧ i ≠ a ∧ j ≠ a ∧ k ≠ a ∧ l ≠ a) by tauto)
    with ha | ha | ha | ha | ⟨a1, a2, a3, a4, a5, a6, a7, a8⟩ <;> (try subst ha) <;>
  rcases (show i = b ∨ j = b ∨ k = b ∨ l = b ∨ (b ≠ i ∧ b ≠ j ∧ b ≠ k ∧ b ≠ l ∧ i ≠ b ∧ j ≠ b ∧ k ≠ b ∧ l ≠ b) by tauto)
    with hb | hb | hb | hb | ⟨b1, b2, b3, b4, b5, b6, b7, b8⟩ <;> (try subst hb) <;>
  simp [hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, hkl.symm, *] <;>
  (try rw [hw]) <;> ring_nf

open HamiltonsCubic.FamilyLayer in
/-- **`M ∘ H_A` ON THE FOUR-SET, `½(A H_A − C H_B + B H_C)`**, at a symmetric weight `w`, four distinct indices
and every bivector `X`, with `H_A = φ_ij ⊙ φ_kl`, `H_B = φ_ik ⊙ φ_jl`, `H_C = φ_il ⊙ φ_jk` and the opposite-pair
sums `A = w_ij + w_kl`, `B = w_ik + w_jl`, `C = w_il + w_jk`. The Jordan half gives `½A H_A` and the polarised
`#` gives `½(B H_C − C H_B)`. -/
theorem fourSet_block (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k)
    (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    foxProd (diagOp w) (rk2 (phi i j) (phi k l)) X
      = (1 / 2 : ℝ) • ((w i j + w k l) • rk2 (phi i j) (phi k l) X
          - (w i l + w j k) • rk2 (phi i k) (phi j l) X + (w i k + w j l) • rk2 (phi i l) (phi j k) X) := by
  have hR := isLinOp_diagOp w
  rw [foxProd_split _ _ hR.1 (isLinOp_rk2 _ _).1]
  change jordanProd (diagOp w) (rk2 (phi i j) (phi k l)) X + sharpCross (diagOp w) (rk2 (phi i j) (phi k l)) X = _
  rw [sharpCross_rk2 (diagOp w) hR (fun A B => diagOp_selfAdjoint w A B) (fun A hA => diagOp_skew w hw A hA)
    (phi_isSkew i j) (phi_isSkew k l) hX, bracket_four w hw hij hik hil hjk hjl hkl hX]
  unfold jordanProd rk2
  rw [hR.1, hR.2, hR.2, diagOp_phi w hw, diagOp_phi w hw, ← diagOp_selfAdjoint w (phi k l),
    ← diagOp_selfAdjoint w (phi i j), diagOp_phi w hw, diagOp_phi w hw, ip_smul_l, ip_smul_l]
  module

omit [DecidableEq ι] in
theorem rk2_neg_right (U V X : Matrix ι ι ℝ) : rk2 U (-V) X = - rk2 U V X := by
  unfold rk2; rw [show -V = (-1 : ℝ) • V by simp, ip_smul_l]; module

omit [DecidableEq ι] in
theorem rk2_neg_left (U V X : Matrix ι ι ℝ) : rk2 (-U) V X = - rk2 U V X := by
  unfold rk2; rw [show -U = (-1 : ℝ) • U by simp, ip_smul_l]; module

omit [DecidableEq ι] in
theorem rk2_comm (U V X : Matrix ι ι ℝ) : rk2 U V X = rk2 V U X := by unfold rk2; abel

open HamiltonsCubic.FamilyLayer in
/-- **THE BLOCK IS `½G`, ALL THREE COLUMNS**, in the signed basis `a = φ_ij ⊙ φ_kl`, `b = φ_ki ⊙ φ_jl`,
`c = φ_il ⊙ φ_jk` (`b` is `−(φ_ik ⊙ φ_jl)`, the record's sign flip): `M ∘ a = ½(A a + C b + B c)`,
`M ∘ b = ½(C a + B b + A c)`, `M ∘ c = ½(B a + A b + C c)` on every bivector, which is
`G = [[A,C,B],[C,B,A],[B,A,C]]` column by column. *The second and third columns are `fourSet_block` at the index
tuples `(k,i,j,l)` and `(i,l,j,k)`.* -/
theorem fourSet_G (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k)
    (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    foxProd (diagOp w) (rk2 (phi i j) (phi k l)) X = (1 / 2 : ℝ) • ((w i j + w k l) • rk2 (phi i j) (phi k l) X
        + (w i l + w j k) • rk2 (phi k i) (phi j l) X + (w i k + w j l) • rk2 (phi i l) (phi j k) X)
      ∧ foxProd (diagOp w) (rk2 (phi k i) (phi j l)) X = (1 / 2 : ℝ) • ((w i l + w j k) • rk2 (phi i j) (phi k l) X
        + (w i k + w j l) • rk2 (phi k i) (phi j l) X + (w i j + w k l) • rk2 (phi i l) (phi j k) X)
      ∧ foxProd (diagOp w) (rk2 (phi i l) (phi j k)) X = (1 / 2 : ℝ) • ((w i k + w j l) • rk2 (phi i j) (phi k l) X
        + (w i j + w k l) • rk2 (phi k i) (phi j l) X + (w i l + w j k) • rk2 (phi i l) (phi j k) X) := by
  refine ⟨?_, ?_, ?_⟩
  · rw [fourSet_block w hw hij hik hil hjk hjl hkl hX, phi_swap k i, rk2_neg_left]
    module
  · rw [fourSet_block w hw hik.symm hjk.symm hkl hij hil hjl hX, rk2_comm (phi k l) (phi i j),
      rk2_comm (phi k j) (phi i l), phi_swap k j, rk2_neg_right, hw k i, hw k j, hw k l]
    module
  · rw [fourSet_block w hw hil hij hik hjl.symm hkl.symm hjk hX, phi_swap l k, rk2_neg_right,
      phi_swap l j, rk2_neg_right, phi_swap k i, rk2_neg_left, hw l k, hw l j]
    module

open HamiltonsCubic.FamilyLayer in
/-- **FIRST BIANCHI AT `(i,j,k,l)` IS `x + y + z`**: on `x a + y b + z c` in the signed basis of `fourSet_G`, the
layer's `bianchi` at the tuple `(i,j,k,l)` is `x + y + z`, the record's `𝟏^⊥`. Every other tuple is
[L121Bianchi.lean](L121Bianchi.lean)'s `fourSet_bianchi_iff`. -/
theorem fourSet_bianchi {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (x y z : ℝ) :
    bianchi (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y + z • rk2 (phi i l) (phi j k) Y)
      i j k l = x + y + z := by
  unfold bianchi rk2
  simp only [ip_add_l, ip_smul_l, inner2_phi_phi]
  simp [hij, hik, hil, hjk, hjl, hkl, hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, hkl.symm]

open HamiltonsCubic.FamilyLayer in
/-- **THE FOUR-SET SPAN IS INVARIANT AND `L_M` ACTS ON IT AS `½G`**: `M ∘ (x a + y b + z c)` is
`½((Ax + Cy + Bz) a + (Cx + By + Az) b + (Bx + Ay + Cz) c)` on every bivector, from `fourSet_G` and `∘`'s linearity
in its second slot. -/
theorem fourSet_span (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k)
    (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) {X : Matrix ι ι ℝ} (hX : IsSkew X) (x y z : ℝ) :
    foxProd (diagOp w) (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y
        + z • rk2 (phi i l) (phi j k) Y) X
      = (1 / 2 : ℝ) • (((w i j + w k l) * x + (w i l + w j k) * y + (w i k + w j l) * z) • rk2 (phi i j) (phi k l) X
        + ((w i l + w j k) * x + (w i k + w j l) * y + (w i j + w k l) * z) • rk2 (phi k i) (phi j l) X
        + ((w i k + w j l) * x + (w i j + w k l) * y + (w i l + w j k) * z) • rk2 (phi i l) (phi j k) X) := by
  have he := isLinOp_diagOp w
  have sm : ∀ (c : ℝ) (U V : Matrix ι ι ℝ), IsLinOp (fun Y => c • rk2 U V Y) := fun c U V =>
    ⟨fun P Q => by simp only [(isLinOp_rk2 U V).1, smul_add],
     fun d P => by simp only [(isLinOp_rk2 U V).2, smul_comm c d]⟩
  have s2 : IsLinOp (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y) :=
    ⟨fun P Q => by simp only [(sm x _ _).1, (sm y _ _).1]; abel,
     fun d P => by simp only [(sm x _ _).2, (sm y _ _).2, smul_add]⟩
  rw [foxProd_add_right _ _ _ he s2 (sm z _ _), foxProd_add_right _ _ _ he (sm x _ _) (sm y _ _),
    foxProd_smul_right _ _ _ he (isLinOp_rk2 _ _), foxProd_smul_right _ _ _ he (isLinOp_rk2 _ _),
    foxProd_smul_right _ _ _ he (isLinOp_rk2 _ _)]
  obtain ⟨h1, h2, h3⟩ := fourSet_G w hw hij hik hil hjk hjl hkl hX
  rw [h1, h2, h3]
  module

end HamiltonsCubic.L121Block
