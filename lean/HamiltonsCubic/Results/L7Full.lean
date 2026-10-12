import HamiltonsCubic.Results.L7Record
import HamiltonsCubic.Results.L15Polar

set_option linter.style.longLine false

/-!
# L7 in the record's form: `θ tr W₋ + tr W₋² ≤ ‖Ric(W₋)‖² + 6‖Alt(W₋)‖²`

[L7Record.lean](L7Record.lean) proves L7 with its right side as `cross2`, the frame form of
`2 tr(W₊ # W₋)`. [L15Polar.lean](L15Polar.lean) proves L15 polarised at two operators. **This file
joins them**, for a Weyl `W` with an orthonormal eigenframe:

- `diagFrame v d = ∑ d_α ⟨·, v_α⟩ v_α`, linear, symmetric and preserving bivectors; at
  `d = posP ∘ λ` and `d = negP ∘ λ` it is `W₊ = ∑_{λ>0} λ ⟨·, v⟩ v` and `W₋ = ∑_{λ<0} |λ| ⟨·, v⟩ v`,
  with `W₊ − W₋ = W` on bivectors (`sub_eq_W`) and `⟨W₊, W₋⟩ = 0`;
- `sharpX_frame`: **`sharpX A C η = ½ ∑_{α,β} c_α a_β ⟨[η, v_α], v_β⟩²`** for `A`, `C` sharing the
  frame with eigenvalues `a`, `c`, the two-operator form of `sharpQF_frame_lin`;
- `sharpTraceX_frame`: `sharpTraceX A C = ½ ∑_{α,β} c_α a_β ∑_γ ω_{αβγ}²`, by ad-invariance and
  Parseval;
- `cross2_eq`: **`cross2 = ‖Ric(W₋)‖² + 6‖Alt(W₋)‖²`**, from `L15_polar` at `(W₊, W₋)`, the
  Ricci contraction and `Alt` of `W₊ − W₋ = W` vanishing;
- `L7_full`: **L7 as the record states it**, `θ tr W₋ + tr W₋² ≤ ‖Ric(W₋)‖² + 6‖Alt(W₋)‖²` at every
  critical Weyl `W` with an eigenframe, and `L7_full_equality`, equality iff the frame is graded.
-/

namespace HamiltonsCubic.L41Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement.Frame HamiltonsCubic.L7Frame
  HamiltonsCubic.L15Statement HamiltonsCubic.AltLayer

variable {ι : Type} [Fintype ι] [DecidableEq ι] {Γ : Type} [Fintype Γ] [DecidableEq Γ]

/-- The positive part of an eigenvalue. -/
noncomputable def posP (x : ℝ) : ℝ := if 0 < x then x else 0

/-- The size of the negative part of an eigenvalue. -/
noncomputable def negP (x : ℝ) : ℝ := if x < 0 then -x else 0

theorem posP_sub_negP (x : ℝ) : posP x - negP x = x := by
  unfold posP negP; split_ifs with h1 h2 h2 <;> linarith

theorem posP_mul_negP (x : ℝ) : posP x * negP x = 0 := by
  unfold posP negP; split_ifs with h1 h2 h2 <;> first | (exfalso; linarith) | simp

/-- An operator diagonal in the frame with coefficients `d`. -/
noncomputable def diagFrame (v : Γ → Matrix ι ι ℝ) (d : Γ → ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => ∑ a, (d a * inner2 X (v a)) • v a

omit [DecidableEq Γ] in
theorem diagFrame_lin (v : Γ → Matrix ι ι ℝ) (d : Γ → ℝ) : IsLinearOp (diagFrame v d) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · unfold diagFrame
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner2_add_l, mul_add, add_smul]
  · unfold diagFrame
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner2_smul_l, smul_smul]; ring_nf

omit [DecidableEq Γ] in
theorem diagFrame_skew {v : Γ → Matrix ι ι ℝ} (hv : ∀ a, IsSkew (v a)) (d : Γ → ℝ) :
    ∀ X, IsSkew X → IsSkew (diagFrame v d X) := fun _ _ =>
  isSkew_sum Finset.univ _ v hv

omit [DecidableEq Γ] in
theorem diagFrame_sym (v : Γ → Matrix ι ι ℝ) (d : Γ → ℝ) : IsSymmetricOp (diagFrame v d) := by
  intro X Y _ _
  unfold diagFrame
  rw [inner2_sum_l, inner2_comm X, inner2_sum_l]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [inner2_smul_l, inner2_smul_l, inner2_comm (v a) Y, inner2_comm (v a) X]; ring

theorem diagFrame_eigen {v : Γ → Matrix ι ι ℝ}
    (horth : ∀ a b, inner2 (v a) (v b) = if a = b then 1 else 0) (d : Γ → ℝ) (b : Γ) :
    diagFrame v d (v b) = d b • v b := by
  unfold diagFrame
  simp only [horth, mul_ite, mul_one, mul_zero, ite_smul, zero_smul]
  simp [Finset.sum_ite_eq]

/-- `diagFrame` shares the frame. -/
theorem diagFrame_frame {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (d : Γ → ℝ) : EigenFrame (diagFrame v d) v d where
  skew := hf.skew
  orthonormal := hf.orthonormal
  eigen := diagFrame_eigen hf.orthonormal d
  complete := hf.complete

/-- **The two-operator frame form of the mixed sharp.** -/
theorem sharpX_frame {A C : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {a c : Γ → ℝ}
    (hAl : IsLinearOp A) (_hAk : ∀ X, IsSkew X → IsSkew (A X)) (hCl : IsLinearOp C)
    (hfA : EigenFrame A v a) (hfC : EigenFrame C v c) (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    sharpX A C η = (1 / 2) * ∑ α, ∑ β, c α * a β * inner2 (br η (v α)) (v β) ^ 2 := by
  set F : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => br η (A (br η (C X))) with hF
  have hlin : ∀ d : Γ → ℝ, F (∑ α, d α • v α) = ∑ α, d α • F (v α) := by
    intro d
    simp only [hF]
    rw [Proof.lin_sum hCl, br_sum_r, Proof.lin_sum hAl, br_sum_r]
  have hid : ∀ d : Γ → ℝ, (fun X : Matrix ι ι ℝ => X) (∑ α, d α • v α) = ∑ α, d α • (fun X => X) (v α) :=
    fun d => rfl
  have hQ : sharpX A C η = -(1 / 2) * innerOp F (fun X => X) := by
    unfold sharpX innerOp; simp only [hF]; ring
  rw [hQ, innerOp_frame hfA F (fun X => X) hlin hid]
  have hFa : ∀ α, inner2 (F (v α)) (v α)
      = -(c α * ∑ β, a β * inner2 (br η (v α)) (v β) ^ 2) := by
    intro α
    have hAs : A (c α • br η (v α)) = c α • A (br η (v α)) := hAl.2 _ _
    have hexp := hfA.complete _ (br_skew hη (hfA.skew α))
    have hAb : A (br η (v α)) = ∑ β, (inner2 (br η (v α)) (v β) * a β) • v β := by
      conv_lhs => rw [hexp]
      rw [Proof.lin_sum hAl]
      exact Finset.sum_congr rfl fun β _ => by rw [hfA.eigen β, smul_smul]
    have hc : ∀ β, inner2 (br η (v β)) (v α) = -inner2 (br η (v α)) (v β) := fun β => by
      rw [adinv _ hη (hfA.skew β), inner2_comm]
    simp only [hF, hfC.eigen α, br_smul_r, hAs, hAb, br_sum_r, inner2_smul_l, inner2_sum_l, hc]
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun β _ => by ring
  simp only [hFa, Finset.mul_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  ring

/-- `⟨[φ_ij, v_α], v_β⟩ = ⟨φ_ij, [v_α, v_β]⟩`, by ad-invariance. -/
theorem br_phi_frame {v : Γ → Matrix ι ι ℝ} (hv : ∀ a, IsSkew (v a)) (i j : ι) (α β : Γ) :
    inner2 (br (phi i j) (v α)) (v β) = inner2 (br (v α) (v β)) (phi i j) := by
  have e : br (phi i j) (v α) = -br (v α) (phi i j) := by unfold br; abel
  have hn : inner2 (-br (v α) (phi i j)) (v β) = -inner2 (br (v α) (phi i j)) (v β) := by
    unfold inner2; simp [Matrix.transpose_neg, Matrix.trace_neg]
  rw [e, hn, adinv _ (hv α) (phi_isSkew i j), neg_neg, inner2_comm]

/-- **The mixed sharp trace in the frame.** -/
theorem sharpTraceX_frame {A C : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {a c : Γ → ℝ}
    (hAl : IsLinearOp A) (hAk : ∀ X, IsSkew X → IsSkew (A X)) (hCl : IsLinearOp C)
    (hfA : EigenFrame A v a) (hfC : EigenFrame C v c) :
    sharpTraceX A C = (1 / 2) * ∑ α, ∑ β, c α * a β * ∑ γ, omegaF v α β γ ^ 2 := by
  unfold sharpTraceX
  simp only [sharpX_frame hAl hAk hCl hfA hfC _ (phi_isSkew _ _), br_phi_frame hfA.skew]
  have hpar : ∀ α β, (1 / 2) * ∑ i, ∑ j, inner2 (br (v α) (v β)) (phi i j) ^ 2
      = ∑ γ, omegaF v α β γ ^ 2 := by
    intro α β
    have h := parseval (br (v α) (v β)) (br (v α) (v β)) (br_skew (hfA.skew α) (hfA.skew β))
      (br_skew (hfA.skew α) (hfA.skew β))
    simp only [← sq] at h
    rw [h, brnorm_frame hfA]
    rfl
  have h4 : ∀ f : ι → ι → Γ → Γ → ℝ,
      ∑ i, ∑ j, ∑ α, ∑ β, f i j α β = ∑ α, ∑ β, ∑ i, ∑ j, f i j α β := by
    intro f
    calc ∑ i, ∑ j, ∑ α, ∑ β, f i j α β
        = ∑ p : ι × ι, ∑ q : Γ × Γ, f p.1 p.2 q.1 q.2 := by
          simp only [Fintype.sum_prod_type]
      _ = ∑ q : Γ × Γ, ∑ p : ι × ι, f p.1 p.2 q.1 q.2 := Finset.sum_comm
      _ = ∑ α, ∑ β, ∑ i, ∑ j, f i j α β := by simp only [Fintype.sum_prod_type]
  have hr : ∀ α β, c α * a β * ∑ γ, omegaF v α β γ ^ 2
      = ∑ i, ∑ j, (1 / 2) * (c α * a β * inner2 (br (v α) (v β)) (phi i j) ^ 2) := by
    intro α β
    rw [← hpar]
    simp only [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  simp only [hr]
  rw [← h4]
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  simp only [Finset.mul_sum]

/-- **`negTr` is `tr W₋`**: the trace of `diagFrame v (negP ∘ λ)` on `Λ²`. -/
theorem traceOp_diagFrame {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (d : Γ → ℝ) : traceOp (diagFrame v d) = ∑ γ, d γ := by
  have hF : ∀ c : Γ → ℝ, diagFrame v d (∑ γ, c γ • v γ) = ∑ γ, c γ • diagFrame v d (v γ) :=
    fun c => Proof.lin_sum (diagFrame_lin v d) _ _ _
  have hid : ∀ c : Γ → ℝ, (fun X : Matrix ι ι ℝ => X) (∑ γ, c γ • v γ) = ∑ γ, c γ • (fun X => X) (v γ) :=
    fun c => rfl
  have e : traceOp (diagFrame v d) = innerOp (diagFrame v d) (fun X => X) := by
    unfold traceOp innerOp; rfl
  rw [e, innerOp_frame hf _ _ hF hid]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [diagFrame_eigen hf.orthonormal, inner2_smul_l, hf.orthonormal γ γ, if_pos rfl, mul_one]

/-- **`negTr2` is `tr W₋²`**, the squared norm of `diagFrame v (negP ∘ λ)`. -/
theorem normSq_diagFrame {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (d : Γ → ℝ) : normSq (diagFrame v d) = ∑ γ, d γ ^ 2 := by
  have hF : ∀ c : Γ → ℝ, diagFrame v d (∑ γ, c γ • v γ) = ∑ γ, c γ • diagFrame v d (v γ) :=
    fun c => Proof.lin_sum (diagFrame_lin v d) _ _ _
  unfold normSq
  rw [innerOp_frame hf _ _ hF hF]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [diagFrame_eigen hf.orthonormal, inner2_smul_l, inner2_smul_r, hf.orthonormal γ γ, if_pos rfl]
  ring

theorem negTr_eq {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) : negTr lam = traceOp (diagFrame v fun a => negP (lam a)) := by
  rw [traceOp_diagFrame hf]; rfl

theorem negTr2_eq {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) : negTr2 lam = normSq (diagFrame v fun a => negP (lam a)) := by
  rw [normSq_diagFrame hf]
  unfold negTr2 negP
  refine Finset.sum_congr rfl fun γ _ => ?_
  split_ifs <;> ring

section W

variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
  (hf : EigenFrame W v lam)
include hW hf

/-- **`W₊ − W₋ = W` on bivectors.** -/
theorem sub_eq_W (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    subOp (diagFrame v fun a => posP (lam a)) (diagFrame v fun a => negP (lam a)) X = W X := by
  unfold subOp diagFrame
  rw [← Finset.sum_sub_distrib]
  conv_rhs => rw [hf.complete X hX, weyl_lin hW _ _ _ hf.skew]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [hf.eigen a, smul_smul, ← sub_smul, ← sub_mul, posP_sub_negP, mul_comm]

/-- **`2 tr(W₊ # W₋) = ‖Ric(W₋)‖² + 6‖Alt(W₋)‖²`**, with the left side in its frame form. -/
theorem cross2_eq :
    cross2 lam (omegaF v) =
      ricNormSq (diagFrame v fun a => negP (lam a)) + 6 * altNormSq (diagFrame v fun a => negP (lam a)) := by
  set P := diagFrame v fun a => posP (lam a) with hPdef
  set N := diagFrame v fun a => negP (lam a) with hNdef
  have hfP : EigenFrame P v fun a => posP (lam a) := diagFrame_frame hf _
  have hfN : EigenFrame N v fun a => negP (lam a) := diagFrame_frame hf _
  have hPl : IsLinearOp P := diagFrame_lin v _
  have hNl : IsLinearOp N := diagFrame_lin v _
  have hPk : ∀ X, IsSkew X → IsSkew (P X) := diagFrame_skew hf.skew _
  have hNk : ∀ X, IsSkew X → IsSkew (N X) := diagFrame_skew hf.skew _
  have hsub : ∀ i j, subOp P N (phi i j) = W (phi i j) := fun i j => sub_eq_W hW hf _ (phi_isSkew i j)
  have hRic : ∀ a b, Ric P a b = Ric N a b := by
    intro a b
    have h := Ric_sub P N a b
    have h0 : Ric (subOp P N) a b = 0 := by
      unfold Ric; simp only [hsub]; exact hW.2.2.2 a b
    linarith
  have hAlt : ∀ i j k l, altCoeff P i j k l = altCoeff N i j k l := by
    intro i j k l
    have h := altCoeff_sub P N i j k l
    have h0 : altCoeff (subOp P N) i j k l = 0 := by
      rw [altCoeff_eq_third_bianchi]
      unfold bianchi; simp only [hsub]
      have := hW.2.2.1 i j k l; unfold bianchi at this; rw [this, mul_zero]
    linarith
  have hpol := L15_polar hPl (diagFrame_sym v _ : IsSymmetricOp P) hPk hNl (diagFrame_sym v _ : IsSymmetricOp N) hNk hRic hAlt
  have hinner : innerOp P N = 0 := by
    have hPf : ∀ d : Γ → ℝ, P (∑ γ, d γ • v γ) = ∑ γ, d γ • P (v γ) := fun d => Proof.lin_sum hPl _ _ _
    have hNf : ∀ d : Γ → ℝ, N (∑ γ, d γ • v γ) = ∑ γ, d γ • N (v γ) := fun d => Proof.lin_sum hNl _ _ _
    rw [innerOp_frame hf P N hPf hNf]
    refine Finset.sum_eq_zero fun γ _ => ?_
    rw [hfP.eigen γ, hfN.eigen γ, inner2_smul_l, inner2_smul_r, ← mul_assoc, posP_mul_negP, zero_mul]
  have hTP := sharpTraceX_frame hPl hPk hNl hfP hfN
  have hTN := sharpTraceX_frame hNl hNk hPl hfN hfP
  rw [hinner, mul_zero, add_zero, hTP, hTN] at hpol
  have hswap : ∑ α, ∑ β, negP (lam α) * posP (lam β) * ∑ γ, omegaF v α β γ ^ 2
      = ∑ α, ∑ β, posP (lam α) * negP (lam β) * ∑ γ, omegaF v α β γ ^ 2 := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
    simp only [omegaF_sq_swap v x y]
    ring
  have hite : ∀ x y : ℝ, (if 0 < x ∧ y < 0 then x * -y else 0) = posP x * negP y := by
    intro x y; unfold posP negP
    by_cases hx : 0 < x <;> by_cases hy : y < 0 <;> simp [hx, hy]
  have hcross : cross2 lam (omegaF v)
      = ∑ α, ∑ β, posP (lam α) * negP (lam β) * ∑ γ, omegaF v α β γ ^ 2 := by
    unfold cross2
    simp only [hite, Finset.mul_sum]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun α _ => ?_
    rw [Finset.sum_comm]
  rw [hswap] at hpol
  rw [hcross]
  linarith

/-- **L7 AS THE RECORD STATES IT**: `θ tr W₋ + tr W₋² ≤ ‖Ric(W₋)‖² + 6‖Alt(W₋)‖²`. -/
theorem L7_full (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) :
    θ * negTr lam + negTr2 lam ≤
      ricNormSq (diagFrame v fun a => negP (lam a)) + 6 * altNormSq (diagFrame v fun a => negP (lam a)) := by
  rw [← cross2_eq hW hf]
  exact L7_record (fun s c x hx => weyl_lin hW s c x hx) hW.1 hf θ hc

/-- **L7's equality class in the record's form**: equality iff the frame is graded. -/
theorem L7_full_equality (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) :
    θ * negTr lam + negTr2 lam =
      ricNormSq (diagFrame v fun a => negP (lam a)) + 6 * altNormSq (diagFrame v fun a => negP (lam a))
      ↔ HamiltonsCubic.L155Frame.Graded lam (omegaF v) := by
  rw [← cross2_eq hW hf]
  exact L7_equality_record (fun s c x hx => weyl_lin hW s c x hx) hW.1 hf θ hc

end W

end HamiltonsCubic.L41Statement
