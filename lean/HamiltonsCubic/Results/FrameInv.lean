import HamiltonsCubic.Base.Frames
import HamiltonsCubic.Results.L41Statement

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.style.multiGoal false

/-!
# The frame change in the operator model: basis sums, the Weyl conditions and eigenframes

Milestones 1 and 3 of [the frame-invariance plan](../../../reviews/2026-09-26-lean-frame-invariance-plan.md). Every
quantity the layer defines on an operator is a sum over the basis bivectors `φ_{ij}`, and a frame change
`X ↦ Uᵀ X U` replaces that basis by `ψ_{ij} = Uᵀ φ_{ij} U`:

* **`inner2_conj`**: `⟨Uᵀ X U, Uᵀ Y U⟩ = ⟨X, Y⟩` for orthogonal `U`;
* **`br_conj`**: `[Uᵀ X U, Uᵀ Y U] = Uᵀ [X, Y] U`;
* **`phiSum_conj`**: for `F`, `G` linear on bivectors, `Σ_{ij} ⟨F ψ_{ij}, G ψ_{ij}⟩ = Σ_{ij} ⟨F φ_{ij}, G φ_{ij}⟩`,
  from the `φ`-expansion of `ψ_{ij}` and polarised Parseval;
* **`psi_expand`**, **`C_conj`**, **`bianchi_conj`**, **`ric_conj`**, **`isWeyl_conj`**: `ψ_{ab} = Σ U_{ap} U_{bq} φ_{pq}`,
  so the curvature components, first Bianchi and Ricci transform as tensors and a frame change keeps an
  operator Weyl (milestone 3);
* **`eigenFrame_conj`**, **`cst_conj`**: a frame change carries an eigenframe to one with the same eigenvalues
  and structure constants, which [FrameTheta.lean](FrameTheta.lean) uses for `θ`.
-/

namespace HamiltonsCubic.FrameLayer

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement.Frame

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem isOrth_transpose {U : Matrix ι ι ℝ} (hU : IsOrth U) : IsOrth Uᵀ := by
  obtain ⟨h1, h2⟩ := hU
  exact ⟨by rw [Matrix.transpose_transpose]; exact h2, by rw [Matrix.transpose_transpose]; exact h1⟩

/-- **`inner2` is invariant under a frame change.** -/
theorem inner2_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) (X Y : Matrix ι ι ℝ) :
    inner2 (Uᵀ * X * U) (Uᵀ * Y * U) = inner2 X Y := by
  unfold inner2
  congr 1
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose]
  calc (Uᵀ * (Xᵀ * U) * (Uᵀ * Y * U)).trace = (Uᵀ * (Xᵀ * (U * Uᵀ) * Y) * U).trace := by
        simp only [Matrix.mul_assoc]
    _ = (Xᵀ * Y).trace := by
        rw [hU.2, Matrix.mul_one, Matrix.trace_mul_comm, ← Matrix.mul_assoc, hU.2, Matrix.one_mul]

/-- **The bracket commutes with a frame change.** -/
theorem br_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) (X Y : Matrix ι ι ℝ) :
    br (Uᵀ * X * U) (Uᵀ * Y * U) = Uᵀ * br X Y * U := by
  unfold br
  have e : ∀ A B : Matrix ι ι ℝ, Uᵀ * A * U * (Uᵀ * B * U) = Uᵀ * (A * B) * U := fun A B => by
    calc Uᵀ * A * U * (Uᵀ * B * U) = Uᵀ * A * (U * Uᵀ) * B * U := by simp only [Matrix.mul_assoc]
      _ = Uᵀ * (A * B) * U := by rw [hU.2, Matrix.mul_one]; simp only [Matrix.mul_assoc]
  rw [e, e, ← Matrix.sub_mul, ← Matrix.mul_sub]

/-- The conjugated basis bivector. -/
def psi (U : Matrix ι ι ℝ) (i j : ι) : Matrix ι ι ℝ := Uᵀ * phi i j * U

theorem psi_skew (U : Matrix ι ι ℝ) (i j : ι) : IsSkew (psi U i j) := isSkew_conj (phi_isSkew i j)

/-- `⟨ψ_{ij}, φ_{ab}⟩ = ⟨φ_{ij}, U φ_{ab} Uᵀ⟩`. -/
theorem inner2_psi {U : Matrix ι ι ℝ} (hU : IsOrth U) (i j a b : ι) :
    inner2 (psi U i j) (phi a b) = inner2 (phi i j) (U * phi a b * Uᵀ) := by
  have := inner2_conj hU (phi i j) (U * phi a b * Uᵀ)
  rw [← this]
  unfold psi
  congr 1
  calc phi a b = (Uᵀ * U) * phi a b * (Uᵀ * U) := by rw [hU.1, Matrix.one_mul, Matrix.mul_one]
    _ = Uᵀ * (U * phi a b * Uᵀ) * U := by simp only [Matrix.mul_assoc]

/-- **The pair sum of the conjugated basis**: `Σ_{ij} ⟨ψ_{ij}, φ_{ab}⟩⟨ψ_{ij}, φ_{cd}⟩ = 2 ⟨φ_{ab}, φ_{cd}⟩`. -/
theorem psi_pair {U : Matrix ι ι ℝ} (hU : IsOrth U) (a b c d : ι) :
    ∑ i, ∑ j, inner2 (psi U i j) (phi a b) * inner2 (psi U i j) (phi c d) = 2 * inner2 (phi a b) (phi c d) := by
  simp only [inner2_psi hU]
  have hUt := isOrth_transpose hU
  have hs1 : IsSkew (U * phi a b * Uᵀ) := by
    have := isSkew_conj (U := Uᵀ) (phi_isSkew a b); rwa [Matrix.transpose_transpose] at this
  have hs2 : IsSkew (U * phi c d * Uᵀ) := by
    have := isSkew_conj (U := Uᵀ) (phi_isSkew c d); rwa [Matrix.transpose_transpose] at this
  have hp := parseval _ _ hs1 hs2
  have hc := inner2_conj hUt (phi a b) (phi c d)
  rw [Matrix.transpose_transpose] at hc
  rw [hc] at hp
  rw [← hp, Finset.mul_sum]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_comm (phi i j), inner2_comm (phi i j)]; ring

omit [DecidableEq ι] in
/-- Moving two outer sums inside four. -/
theorem sw6 (f : ι → ι → ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ a, ∑ b, ∑ c, ∑ d, f i j a b c d = ∑ a, ∑ b, ∑ c, ∑ d, ∑ i, ∑ j, f i j a b c d := by
  calc ∑ i, ∑ j, ∑ a, ∑ b, ∑ c, ∑ d, f i j a b c d
      = ∑ i, ∑ a, ∑ b, ∑ c, ∑ d, ∑ j, f i j a b c d := by
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun b _ => ?_
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun c _ => ?_
        rw [Finset.sum_comm]
    _ = ∑ a, ∑ b, ∑ c, ∑ d, ∑ i, ∑ j, f i j a b c d := by
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun b _ => ?_
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun c _ => ?_
        rw [Finset.sum_comm]

omit [DecidableEq ι] in
/-- Swapping two pairs of sums. -/
theorem sw4 (f : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ c, ∑ d, ∑ a, ∑ b, f a b c d := by
  calc ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ c, ∑ d, ∑ b, f a b c d := by
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun c _ => ?_
        rw [Finset.sum_comm]
    _ = ∑ c, ∑ d, ∑ a, ∑ b, f a b c d := by
        rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun c _ => ?_
        rw [Finset.sum_comm]

/-- **The basis sum is invariant under a frame change**: for `F`, `G` linear on bivectors,
`Σ_{ij} ⟨F ψ_{ij}, G ψ_{ij}⟩ = Σ_{ij} ⟨F φ_{ij}, G φ_{ij}⟩`. -/
theorem phiSum_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) (F G : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hF : ∀ c : ι → ι → ℝ, F (∑ a, ∑ b, c a b • phi a b) = ∑ a, ∑ b, c a b • F (phi a b))
    (hG : ∀ c : ι → ι → ℝ, G (∑ a, ∑ b, c a b • phi a b) = ∑ a, ∑ b, c a b • G (phi a b)) :
    ∑ i, ∑ j, inner2 (F (psi U i j)) (G (psi U i j)) = ∑ i, ∑ j, inner2 (F (phi i j)) (G (phi i j)) := by
  have hψ : ∀ i j, psi U i j = ∑ a, ∑ b, ((1 / 2) * inner2 (psi U i j) (phi a b)) • phi a b :=
    fun i j => phi_expand _ (psi_skew U i j)
  have e : ∀ i j, inner2 (F (psi U i j)) (G (psi U i j))
      = ∑ a, ∑ b, ∑ c, ∑ d, (1 / 2) * inner2 (psi U i j) (phi a b) * ((1 / 2) * inner2 (psi U i j) (phi c d))
          * inner2 (F (phi a b)) (G (phi c d)) := by
    intro i j
    have hFψ := congrArg F (hψ i j); rw [hF] at hFψ
    have hGψ := congrArg G (hψ i j); rw [hG] at hGψ
    rw [hFψ, hGψ]
    simp only [inner2_sum_l, inner2_sum_r, inner2_smul_l, inner2_smul_r, Finset.mul_sum]
    rw [sw4]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
    ring
  simp only [e]
  rw [sw6]
  have hq : ∀ a b c d, ∑ i, ∑ j, (1 / 2) * inner2 (psi U i j) (phi a b) * ((1 / 2) * inner2 (psi U i j) (phi c d))
      * inner2 (F (phi a b)) (G (phi c d))
      = (1 / 2) * inner2 (phi a b) (phi c d) * inner2 (F (phi a b)) (G (phi c d)) := by
    intro a b c d
    have := psi_pair hU a b c d
    calc _ = (1 / 4) * (∑ i, ∑ j, inner2 (psi U i j) (phi a b) * inner2 (psi U i j) (phi c d))
            * inner2 (F (phi a b)) (G (phi c d)) := by
          rw [Finset.mul_sum, Finset.sum_mul]
          refine Finset.sum_congr rfl fun i _ => ?_
          rw [Finset.mul_sum, Finset.sum_mul]
          exact Finset.sum_congr rfl fun j _ => by ring
      _ = _ := by rw [this]; ring
  simp only [hq]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  have hGe := congrArg G (phi_expand (phi a b) (phi_isSkew a b)); rw [hG] at hGe
  rw [hGe, inner2_sum_r]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [inner2_sum_r]
  refine Finset.sum_congr rfl fun d _ => ?_
  rw [inner2_smul_r]

/-! ## The Weyl conditions transform as tensors -/

/-- The entries of `ψ_{ab} = Uᵀ φ_{ab} U`. -/
theorem psi_entry (U : Matrix ι ι ℝ) (a b x y : ι) : psi U a b x y = U b x * U a y - U a x * U b y := by
  simp only [psi, Matrix.mul_apply, Matrix.transpose_apply, phi, Matrix.sub_apply, Matrix.single_apply, ite_and,
    mul_sub, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib, Finset.sum_ite_eq,
    Finset.mem_univ, if_true, sub_mul, ite_mul, zero_mul]

theorem phiSum_entry (U : Matrix ι ι ℝ) (a b x y : ι) :
    (∑ p, ∑ q, (U a p * U b q) • phi p q) x y = U b x * U a y - U a x * U b y := by
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply, Matrix.single_apply,
    ite_and, mul_sub, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib, Finset.sum_ite_eq',
    Finset.mem_univ, if_true]
  have h : (∑ x_1, ∑ x_2, if x_1 = x then if x_2 = y then U a x_1 * U b x_2 else 0 else 0) = U a x * U b y := by
    rw [Finset.sum_eq_single x (fun x1 _ h => by simp [h]) (by simp)]
    simp
  rw [h]; ring

/-- **`ψ_{ab} = Σ_{pq} U_{ap} U_{bq} φ_{pq}`.** -/
theorem psi_expand (U : Matrix ι ι ℝ) (a b : ι) : psi U a b = ∑ p, ∑ q, (U a p * U b q) • phi p q := by
  ext x y
  rw [psi_entry, phiSum_entry]

theorem conj_back {U : Matrix ι ι ℝ} (hU : IsOrth U) (M : Matrix ι ι ℝ) : U * (Uᵀ * M * U) * Uᵀ = M := by
  calc U * (Uᵀ * M * U) * Uᵀ = (U * Uᵀ) * M * (U * Uᵀ) := by simp only [Matrix.mul_assoc]
    _ = M := by rw [hU.2, Matrix.one_mul, Matrix.mul_one]

/-- `⟨U M Uᵀ, φ_{cd}⟩ = ⟨M, ψ_{cd}⟩`. -/
theorem inner2_back {U : Matrix ι ι ℝ} (hU : IsOrth U) (M : Matrix ι ι ℝ) (c d : ι) :
    inner2 (U * M * Uᵀ) (phi c d) = inner2 M (psi U c d) := by
  have h := inner2_conj (isOrth_transpose hU) M (psi U c d)
  rw [Matrix.transpose_transpose] at h
  rw [← h]
  congr 1
  unfold psi
  exact (conj_back hU (phi c d)).symm

/-- **The curvature components transform as a tensor**:
`⟨(U·R) φ_{ab}, φ_{cd}⟩ = Σ U_{ap} U_{bq} U_{cr} U_{ds} ⟨R φ_{pq}, φ_{rs}⟩`. -/
theorem C_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) (a b c d : ι) :
    inner2 (conjOp U R (phi a b)) (phi c d)
      = ∑ p, ∑ q, ∑ r, ∑ s, U a p * U b q * U c r * U d s * inner2 (R (phi p q)) (phi r s) := by
  have h1 : conjOp U R (phi a b) = U * R (psi U a b) * Uᵀ := rfl
  rw [h1, inner2_back hU, psi_expand U a b, psi_expand U c d,
    weyl_lin2 hW (fun p q => U a p * U b q) phi (fun p q => phi_isSkew p q)]
  simp only [inner2_sum_l, inner2_sum_r, inner2_smul_l, inner2_smul_r, Finset.mul_sum]
  rw [sw4]
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ =>
    Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun s _ => ?_
  ring

theorem inner2_move {U : Matrix ι ι ℝ} (hU : IsOrth U) (M Y : Matrix ι ι ℝ) :
    inner2 (U * M * Uᵀ) Y = inner2 M (Uᵀ * Y * U) := by
  have h := inner2_conj (isOrth_transpose hU) M (Uᵀ * Y * U)
  rw [Matrix.transpose_transpose] at h
  rw [← h, conj_back hU Y]

omit [DecidableEq ι] in
theorem sumrot1 (g : ι → ι → ι → ℝ) : ∑ q, ∑ r, ∑ s, g q r s = ∑ s, ∑ q, ∑ r, g q r s := by
  calc ∑ q, ∑ r, ∑ s, g q r s = ∑ q, ∑ s, ∑ r, g q r s :=
        Finset.sum_congr rfl fun q _ => Finset.sum_comm
    _ = ∑ s, ∑ q, ∑ r, g q r s := Finset.sum_comm

omit [DecidableEq ι] in
theorem sumrot2 (g : ι → ι → ι → ℝ) : ∑ q, ∑ r, ∑ s, g q r s = ∑ r, ∑ s, ∑ q, g q r s := by
  calc ∑ q, ∑ r, ∑ s, g q r s = ∑ r, ∑ q, ∑ s, g q r s := Finset.sum_comm
    _ = ∑ r, ∑ s, ∑ q, g q r s := Finset.sum_congr rfl fun r _ => Finset.sum_comm

/-- **First Bianchi transforms as a tensor.** -/
theorem bianchi_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R)
    (i j k l : ι) :
    bianchi (conjOp U R) i j k l
      = ∑ p, ∑ q, ∑ r, ∑ s, U i p * U j q * U k r * U l s * bianchi R p q r s := by
  unfold bianchi
  rw [C_conj hU hW, C_conj hU hW, C_conj hU hW]
  simp only [mul_add, Finset.sum_add_distrib]
  congr 1
  congr 1
  · refine Finset.sum_congr rfl fun p _ => ?_
    rw [sumrot1]
    refine Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun s _ => ?_
    ring
  · refine Finset.sum_congr rfl fun p _ => ?_
    rw [sumrot2]
    refine Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun s _ => ?_
    ring

/-- **Ricci transforms as a tensor**: `Ric(U·R)_{ab} = Σ U_{ap} U_{br} Ric(R)_{pr}`. -/
theorem ric_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) (a b : ι) :
    Ric (conjOp U R) a b = ∑ p, ∑ r, U a p * U b r * Ric R p r := by
  unfold Ric
  simp only [C_conj hU hW]
  have horth : ∀ q s : ι, ∑ c, U c q * U c s = if q = s then 1 else 0 := fun q s => by
    have := congrFun (congrFun hU.1 q) s
    simpa [Matrix.mul_apply, Matrix.one_apply] using this
  calc ∑ c, ∑ p, ∑ q, ∑ r, ∑ s, U a p * U c q * U b r * U c s * inner2 (R (phi p q)) (phi r s)
      = ∑ p, ∑ q, ∑ r, ∑ s, (∑ c, U c q * U c s) * (U a p * U b r * inner2 (R (phi p q)) (phi r s)) := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun p _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun q _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun r _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun s _ => ?_
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun c _ => by ring
    _ = ∑ p, ∑ r, U a p * U b r * ∑ q, inner2 (R (phi p q)) (phi r q) := by
        simp only [horth, ite_mul, one_mul, zero_mul, Finset.sum_ite_eq, Finset.mem_univ, if_true]
        refine Finset.sum_congr rfl fun p _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun r _ => ?_
        rw [Finset.mul_sum]

theorem isSkew_back {U X : Matrix ι ι ℝ} (hX : IsSkew X) : IsSkew (U * X * Uᵀ) := by
  have := isSkew_conj (U := Uᵀ) hX; rwa [Matrix.transpose_transpose] at this

/-- **A frame change carries Weyl operators to Weyl operators.** -/
theorem isWeyl_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) :
    IsWeyl (conjOp U R) := by
  refine ⟨fun X hX => isSkew_back (hW.1 _ (isSkew_conj hX)), fun X Y hX hY => ?_,
    fun i j k l => ?_, fun a b => ?_⟩
  · unfold conjOp
    rw [inner2_move hU, hW.2.1 _ _ (isSkew_conj hX) (isSkew_conj hY), inner2_comm, ← inner2_move hU, inner2_comm]
  · rw [bianchi_conj hU hW]
    simp [hW.2.2.1]
  · rw [ric_conj hU hW]
    simp [hW.2.2.2]

variable {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

open HamiltonsCubic.L41Statement in
/-- **A frame change carries an eigenframe to an eigenframe**, with the same eigenvalues. -/
theorem eigenFrame_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) {R : Matrix ι ι ℝ → Matrix ι ι ℝ}
    {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hf : EigenFrame R v lam) :
    EigenFrame (conjOp U R) (fun γ => U * v γ * Uᵀ) lam where
  skew γ := isSkew_back (hf.skew γ)
  orthonormal γ δ := by
    have h := inner2_conj (isOrth_transpose hU) (v γ) (v δ)
    rw [Matrix.transpose_transpose] at h
    rw [h, hf.orthonormal]
  eigen γ := by
    change U * R (Uᵀ * (U * v γ * Uᵀ) * U) * Uᵀ = lam γ • (U * v γ * Uᵀ)
    have : Uᵀ * (U * v γ * Uᵀ) * U = v γ := by
      calc Uᵀ * (U * v γ * Uᵀ) * U = (Uᵀ * U) * v γ * (Uᵀ * U) := by simp only [Matrix.mul_assoc]
        _ = v γ := by rw [hU.1, Matrix.one_mul, Matrix.mul_one]
    rw [this, hf.eigen, Matrix.mul_smul, Matrix.smul_mul]
  complete X hX := by
    have h := hf.complete _ (isSkew_conj (U := U) hX)
    have hX' : X = U * (Uᵀ * X * U) * Uᵀ := (conj_back hU X).symm
    conv_lhs => rw [hX', h]
    rw [Matrix.mul_sum, Matrix.sum_mul]
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [Matrix.mul_smul, Matrix.smul_mul, inner2_comm, ← inner2_move hU, inner2_comm]

theorem cst_conj {U : Matrix ι ι ℝ} (hU : IsOrth U) (v : Γ → Matrix ι ι ℝ) (a b c : Γ) :
    HamiltonsCubic.L41Statement.Frame.cst (fun γ => U * v γ * Uᵀ) a b c
      = HamiltonsCubic.L41Statement.Frame.cst v a b c := by
  unfold HamiltonsCubic.L41Statement.Frame.cst
  have hb := br_conj (isOrth_transpose hU) (v a) (v b)
  rw [Matrix.transpose_transpose] at hb
  rw [hb]
  have h := inner2_conj (isOrth_transpose hU) (br (v a) (v b)) (v c)
  rw [Matrix.transpose_transpose] at h
  exact h

end HamiltonsCubic.FrameLayer
