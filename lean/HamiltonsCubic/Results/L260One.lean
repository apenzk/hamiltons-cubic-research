import Mathlib
import HamiltonsCubic.Results.I117G2
import HamiltonsCubic.Results.OddTorus

set_option linter.style.longLine false

/-!
# L260 (1): `F(X) ≤ ½(F(|Xᵀ|) + F(|X|))` for every operator, through a singular value decomposition

[findings/second-order.md](../../../findings/second-order.md), Lemma L260 (1): *"For every
$X\in\operatorname{End}(\mathfrak{so}(n))$, $F(X)\le\tfrac12\big(F(|X^{\mathsf T}|)+F(|X|)\big)$"*, with $F$ extended
off $\operatorname{Sym}^2$ by contracting both row indices of the three factors in one structure constant, which is
`Ftri X Xᵀ X` here and `Ftri X X X` at self-adjoint $X$. This file:

* `Ftri_rk1_sum`: $F\big(\sum_ac_au_au_a^{\mathsf T}\big)=\tfrac12\sum c_bc_dc_a\langle[u_b,u_d],u_a\rangle^2$ for any
  family $u$;
* `onb_expand`, `onb_inner`, `sum_rk1_sa`, `sum_rk1_psd`: expansion in an orthonormal basis of $\mathfrak{so}(n)$, and
  weighted sums of rank-one operators are self-adjoint, and positive semidefinite for nonnegative weights;
* `adj_left`, `gram_sa`: with $X^{\mathsf T}$ given by $\langle XY,Z\rangle=\langle Y,X^{\mathsf T}Z\rangle$,
  $X^{\mathsf T}X$ is self-adjoint;
* `amgm`: $pq\le\tfrac12(sp^2+tq^2)$ when $st=1$ or $q=0$;
* `L260_one`: in the eigenbasis $v$ of $X^{\mathsf T}X$ with eigenvalues $\sigma_a^2$ and $w_a=Xv_a$,
  $|X|=\sum\sigma_av_av_a^{\mathsf T}$ and $|X^{\mathsf T}|=\sum\sigma_a^{-1}w_aw_a^{\mathsf T}$ are the positive
  semidefinite square roots of $X^{\mathsf T}X$ and $XX^{\mathsf T}$, and
  $F(X,X^{\mathsf T},X)=\tfrac12\sum\langle[v_b,v_d],v_a\rangle\langle[w_b,w_d],w_a\rangle$ is bounded termwise.

The layer's `Ftri X X X` at non-symmetric $X$ is the other extension, under which the inequality fails (a screen
recorded on the L260 row), so the convention is part of the statement.
-/

namespace HamiltonsCubic.L260One

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem i2_sum_l {κ : Type*} (s : Finset κ) (g : κ → Matrix ι ι ℝ) (M : Matrix ι ι ℝ) :
    inner2 (∑ l ∈ s, g l) M = ∑ l ∈ s, inner2 (g l) M := by
  unfold inner2; rw [Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]

/-- **`F` of a weighted sum of rank-one operators**: `F(∑ c_a u_a u_aᵀ) = ½ ∑ c_a c_b c_d ⟨[u_b, u_d], u_a⟩²`. -/
theorem Ftri_rk1_sum {N : ℕ} (c : Fin N → ℝ) (u : Fin N → skewSub ι) :
    Ftri (∑ a, c a • rk1 (u a)) (∑ a, c a • rk1 (u a)) (∑ a, c a • rk1 (u a))
      = (1 / 2) * ∑ b, ∑ d, ∑ a, c b * c d * c a
          * inner2 ((brS (u b) (u d) : skewSub ι) : Matrix ι ι ℝ) (u a : Matrix ι ι ℝ) ^ 2 := by
  unfold Ftri
  rw [phiTri_sum_mid]
  simp only [phiTri_smul_mid, phiTri_sum_right, phiTri_smul_right, phiTri_rk1]
  have hR : ∀ b d, inner2 (((∑ a, c a • rk1 (u a)) (brS (u b) (u d)) : skewSub ι) : Matrix ι ι ℝ)
      ((brS (u b) (u d) : skewSub ι) : Matrix ι ι ℝ)
      = ∑ a, c a * inner2 ((brS (u b) (u d) : skewSub ι) : Matrix ι ι ℝ) (u a : Matrix ι ι ℝ) ^ 2 := fun b d => by
    rw [_root_.sum_apply, Submodule.coe_sum, i2_sum_l]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [_root_.smul_apply, rk1_apply, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_l,
      HamiltonsCubic.L33Statement.inner2_comm (u a : Matrix ι ι ℝ)]
    ring
  simp only [hR, Finset.mul_sum, mul_neg, Finset.sum_neg_distrib, neg_mul, neg_neg]
  exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun a _ => by ring

local notation "SKι" => skewSub ι
local notation "Mι" => Matrix ι ι ℝ

/-- **Expansion in an orthonormal basis of `𝔰𝔬(n)`.** -/
theorem onb_expand {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) (Z : skewSub ι) :
    Z = ∑ a, inner2 (Z : Matrix ι ι ℝ) ((ofSk (b a) : skewSub ι) : Matrix ι ι ℝ) • ofSk (b a) := by
  conv_lhs => rw [← ofSk_toSk Z, ← b.sum_repr' (toSk Z)]
  rw [ofSk_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [ofSk_smul]
  congr 1
  rw [real_inner_comm]
  rfl

theorem onb_inner {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) (a c : Fin N) :
    inner2 ((ofSk (b a) : skewSub ι) : Matrix ι ι ℝ) ((ofSk (b c) : skewSub ι) : Matrix ι ι ℝ) = if a = c then 1 else 0 := by
  have h := orthonormal_iff_ite.mp b.orthonormal a c
  rw [HamiltonsCubic.FrameExtension.inner_def] at h
  exact h

theorem rk1_sa (u : skewSub ι) : IsSelfAdjoint2 (rk1 u) := fun Y Z => by
  simp only [rk1_apply, Submodule.coe_smul, i2_smul_l, i2_smul_r]
  rw [HamiltonsCubic.L33Statement.inner2_comm (u : Mι) (Z : Mι)]; ring

theorem i2_sum_r {κ : Type*} (s : Finset κ) (M : Matrix ι ι ℝ) (g : κ → Matrix ι ι ℝ) :
    inner2 M (∑ l ∈ s, g l) = ∑ l ∈ s, inner2 M (g l) := by
  unfold inner2; rw [Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]

theorem sum_rk1_sa {N : ℕ} (c : Fin N → ℝ) (u : Fin N → skewSub ι) : IsSelfAdjoint2 (∑ a, c a • rk1 (u a)) :=
  fun Y Z => by
    simp only [_root_.sum_apply, _root_.smul_apply, rk1_apply, Submodule.coe_sum,
      Submodule.coe_smul, i2_sum_l, i2_sum_r, i2_smul_l, i2_smul_r]
    exact Finset.sum_congr rfl fun a _ => by
      rw [HamiltonsCubic.L33Statement.inner2_comm (u a : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)]; ring

theorem sum_rk1_psd {N : ℕ} (c : Fin N → ℝ) (hc : ∀ a, 0 ≤ c a) (u : Fin N → skewSub ι) :
    IsPSD2 (∑ a, c a • rk1 (u a)) := fun Z => by
  simp only [_root_.sum_apply, _root_.smul_apply, rk1_apply, Submodule.coe_sum,
    Submodule.coe_smul, i2_sum_l, i2_smul_l]
  refine Finset.sum_nonneg fun a _ => ?_
  rw [HamiltonsCubic.L33Statement.inner2_comm (u a : Mι) (Z : Mι)]
  exact mul_nonneg (hc a) (mul_self_nonneg _)

section SVD

variable (X Xt : CurvOp2 ι) (hXt : ∀ Y Z : skewSub ι, inner2 ((X Y : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
    = inner2 (Y : Matrix ι ι ℝ) ((Xt Z : skewSub ι) : Matrix ι ι ℝ))

include hXt in
theorem adj_left (Y Z : skewSub ι) : inner2 ((Xt Y : SKι) : Mι) (Z : Mι) = inner2 (Y : Mι) ((X Z : SKι) : Mι) := by
  rw [HamiltonsCubic.L33Statement.inner2_comm, ← hXt, HamiltonsCubic.L33Statement.inner2_comm]

include hXt in
theorem gram_sa : IsSelfAdjoint2 (Xt.comp X) := fun Y Z => by
  show inner2 ((Xt (X Y) : SKι) : Mι) (Z : Mι) = inner2 (Y : Mι) ((Xt (X Z) : SKι) : Mι)
  rw [adj_left X Xt hXt, hXt]

/-- The termwise step: `pq ≤ ½(s p² + t q²)` when `st = 1` or `q = 0`, for `s, t ≥ 0`. -/
theorem amgm (s t p q : ℝ) (hs : 0 ≤ s) (ht : 0 ≤ t) (h : s * t = 1 ∨ q = 0) :
    p * q ≤ (1 / 2) * (s * p ^ 2 + t * q ^ 2) := by
  rcases h with h | h
  · have h' : t * s = 1 := by rw [mul_comm]; exact h
    have e : t * (s * p - q) ^ 2 = s * p ^ 2 - 2 * (p * q) + t * q ^ 2 := by
      linear_combination (s * p ^ 2 - 2 * (p * q)) * h'
    nlinarith [mul_nonneg ht (sq_nonneg (s * p - q))]
  · rw [h]; nlinarith [mul_nonneg hs (sq_nonneg p)]

include hXt in
/-- **L260 (1) in the rows-together convention.** For every `X` with adjoint `Xᵀ`, the positive semidefinite square
roots `|X| = √(XᵀX)` and `|Xᵀ| = √(XXᵀ)` satisfy `F(X, Xᵀ, X) ≤ ½(F(|Xᵀ|) + F(|X|))`, `F(X, Xᵀ, X)` being the
extension of `F` off `Sym²` that contracts both row indices in one structure constant; at self-adjoint `X` it is
`F(X, X, X)`. -/
theorem L260_one : ∃ P Q : CurvOp2 ι, IsSelfAdjoint2 P ∧ IsPSD2 P ∧ P.comp P = Xt.comp X ∧
    IsSelfAdjoint2 Q ∧ IsPSD2 Q ∧ Q.comp Q = X.comp Xt ∧
    Ftri X Xt X ≤ (1 / 2) * (Ftri P P P + Ftri Q Q Q) := by
  classical
  have hT := opSk_symm (gram_sa X Xt hXt)
  let v := hT.eigenvectorBasis (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl
  let μ := hT.eigenvalues (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl
  have hv : ∀ a, Xt (X (ofSk (v a))) = μ a • ofSk (v a) := fun a => by
    have h := hT.apply_eigenvectorBasis (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl a
    have h2 : Xt (X (ofSk (v a))) = ofSk (opSk (Xt.comp X) (v a)) := rfl
    rw [h2, h, ofSk_smul]
    rfl
  have hon := onb_inner v
  have hw : ∀ a c, inner2 ((X (ofSk (v a)) : SKι) : Mι) ((X (ofSk (v c)) : SKι) : Mι) = if a = c then μ a else 0 :=
    fun a c => by
      rw [hXt, hv, Submodule.coe_smul, i2_smul_r, hon]
      split_ifs with h
      · subst h; ring
      · ring
  have hμ : ∀ a, 0 ≤ μ a := fun a => by
    have := hw a a; rw [if_pos rfl] at this; rw [← this]; exact HamiltonsCubic.FrameExtension.inner2_self_nonneg _
  set σ : _ → ℝ := fun a => Real.sqrt (μ a) with hσdef
  have hσσ : ∀ a, σ a * σ a = μ a := fun a => Real.mul_self_sqrt (hμ a)
  have hσ0 : ∀ a, 0 ≤ σ a := fun a => Real.sqrt_nonneg _
  have hwz : ∀ a, σ a = 0 → X (ofSk (v a)) = 0 := fun a h =>
    skew_zero_of_inner' _ (by rw [hw, if_pos rfl, ← hσσ, h, mul_zero])
  have hP : ∀ b, (∑ c, σ c • rk1 (ofSk (v c))) (ofSk (v b)) = σ b • ofSk (v b) := fun b => by
    simp only [_root_.sum_apply, _root_.smul_apply, rk1_apply, hon, ite_smul, one_smul,
      zero_smul, smul_ite, smul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have hQ : ∀ Y : SKι, (∑ c, (σ c)⁻¹ • rk1 (X (ofSk (v c)))) Y
      = ∑ c, ((σ c)⁻¹ * inner2 (Y : Mι) ((X (ofSk (v c)) : SKι) : Mι)) • X (ofSk (v c)) := fun Y => by
    simp only [_root_.sum_apply, _root_.smul_apply, rk1_apply, smul_smul]
  refine ⟨∑ a, σ a • rk1 (ofSk (v a)), ∑ a, (σ a)⁻¹ • rk1 (X (ofSk (v a))), sum_rk1_sa _ _, sum_rk1_psd _ hσ0 _,
    ?_, sum_rk1_sa _ _, sum_rk1_psd _ (fun a => inv_nonneg.mpr (hσ0 a)) _, ?_, ?_⟩
  · refine ContinuousLinearMap.ext fun Z => ?_
    show (∑ a, σ a • rk1 (ofSk (v a))) ((∑ a, σ a • rk1 (ofSk (v a))) Z) = Xt (X Z)
    conv_lhs => rw [onb_expand v Z]
    conv_rhs => rw [onb_expand v Z]
    simp only [map_sum, map_smul, hP, hv, smul_smul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [mul_assoc, hσσ]
  · refine ContinuousLinearMap.ext fun Z => ?_
    show (∑ a, (σ a)⁻¹ • rk1 (X (ofSk (v a)))) ((∑ a, (σ a)⁻¹ • rk1 (X (ofSk (v a)))) Z) = X (Xt Z)
    have hXXt : X (Xt Z) = ∑ a, inner2 (Z : Mι) ((X (ofSk (v a)) : SKι) : Mι) • X (ofSk (v a)) := by
      conv_lhs => rw [onb_expand v (Xt Z)]
      rw [map_sum]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [map_smul, adj_left X Xt hXt]
    rw [hXXt, hQ, hQ]
    refine Finset.sum_congr rfl fun c _ => ?_
    by_cases h : σ c = 0
    · rw [hwz c h]; simp
    · congr 1
      rw [Submodule.coe_sum, i2_sum_l]
      simp only [Submodule.coe_smul, i2_smul_l, hw, mul_ite, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
      rw [← hσσ]
      field_simp
  · have hF : Ftri X Xt X = (1 / 2) * ∑ b, ∑ d, ∑ a,
        inner2 ((brS (ofSk (v b)) (ofSk (v d)) : SKι) : Mι) ((ofSk (v a) : SKι) : Mι)
          * inner2 ((brS (X (ofSk (v b))) (X (ofSk (v d))) : SKι) : Mι) ((X (ofSk (v a)) : SKι) : Mι) := by
      unfold Ftri
      rw [phiTri_onb v]
      simp only [adj_left X Xt hXt]
      have hk : ∀ b d, inner2 ((brS (X (ofSk (v b))) (X (ofSk (v d))) : SKι) : Mι)
          ((X (brS (ofSk (v b)) (ofSk (v d))) : SKι) : Mι)
          = ∑ a, inner2 ((brS (ofSk (v b)) (ofSk (v d)) : SKι) : Mι) ((ofSk (v a) : SKι) : Mι)
            * inner2 ((brS (X (ofSk (v b))) (X (ofSk (v d))) : SKι) : Mι) ((X (ofSk (v a)) : SKι) : Mι) := fun b d => by
        conv_lhs => rw [onb_expand v (brS (ofSk (v b)) (ofSk (v d)))]
        rw [map_sum, Submodule.coe_sum, i2_sum_r]
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [map_smul, Submodule.coe_smul, i2_smul_r]
      simp only [hk]
      ring
    rw [hF, Ftri_rk1_sum, Ftri_rk1_sum, ← mul_add]
    apply mul_le_mul_of_nonneg_left _ (by norm_num)
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_le_sum fun b _ => ?_
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_le_sum fun d _ => ?_
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_le_sum fun a _ => ?_
    have key := amgm (σ b * σ d * σ a) ((σ b)⁻¹ * (σ d)⁻¹ * (σ a)⁻¹)
      (inner2 ((brS (ofSk (v b)) (ofSk (v d)) : SKι) : Mι) ((ofSk (v a) : SKι) : Mι))
      (inner2 ((brS (X (ofSk (v b))) (X (ofSk (v d))) : SKι) : Mι) ((X (ofSk (v a)) : SKι) : Mι))
      (by have := hσ0 b; have := hσ0 d; have := hσ0 a; positivity)
      (by have := hσ0 b; have := hσ0 d; have := hσ0 a; positivity) ?_
    · exact key
    by_cases hb : σ b = 0
    · right; rw [hwz b hb]; simp [HamiltonsCubic.OddTorus.brS_zero_left, inner2]
    by_cases hd : σ d = 0
    · right; rw [hwz d hd]; simp [HamiltonsCubic.OddTorus.brS_zero_right, inner2]
    by_cases ha : σ a = 0
    · right; rw [hwz a ha]; simp [inner2]
    left; field_simp

end SVD

end HamiltonsCubic.L260One
