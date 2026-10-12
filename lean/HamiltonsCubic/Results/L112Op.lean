import Mathlib
import HamiltonsCubic.Results.L112Statement
import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.L31Statement

set_option linter.style.longLine false

/-!
# L112 at the operator: relations (A) and (B) from the Weyl operator, `T = c²` in its eigenframe

[L112Statement.lean](L112Statement.lean) proves L112, *"`λ` is a `-1/(n-2)`-eigenvector of a symmetric
hollow doubly stochastic matrix"*, from relations (A) and (B) taken as hypotheses on an abstract
`T`, and owes *"(A) and (B) in this `T`-form from the layer's `I#I = (n-2)I` and `W#I = -W`, and
`T_abc = c²_abc` built from the structure constants in `W`'s eigenbasis"*. This file discharges both
at every Weyl eigenframe:

* `rowA_frame`: `∑_b S_xb = 2(n-2)`, `S_xb = ∑_c c²_xbc`, from L41Statement's `killing_frame` (the
  Killing row, `I#I = (n-2)I`);
* `rowB_frame`: `∑_b S_xb λ_b = -2 λ_x`, from `aW2` (`W#I = -W`, the record's `A(W) = 2W`) read in the
  frame by `innerOp_frame`;
* `S_symm`, `S_hollow`: `S` symmetric and hollow, from the antisymmetry of `c`;
* `L112_at_frame`: so `Ŝ = S/(2(n-2))` is doubly stochastic, hollow, and has `λ` as a
  `-1/(n-2)`-eigenvector, at every Weyl operator on `ℝⁿ`, `n > 2`, with any orthonormal eigenframe;
* `L112_op`: at every linear Weyl operator on `ℝⁿ`, `n ≥ 3`, through the spectral frame of
  `eigenFrame_exists`;
* `hatS_pair_cap`: the pair cap `Ŝ_ab ≤ 1/(n-2)`, L112's constructive consequence, from `brnorm_frame`
  and L31's bracket cap; and `hatS_symm`.
-/

namespace HamiltonsCubic.L112Op

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement
  HamiltonsCubic.L41Statement.Frame HamiltonsCubic.L112Statement

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {Γ : Type*} [Fintype Γ] [DecidableEq Γ]
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}

/-- `T_abc = c²_abc`, the squared structure constants of the frame. -/
noncomputable def Tc (v : Γ → Matrix ι ι ℝ) : Γ → Γ → Γ → ℝ := fun a b c => cst v a b c ^ 2

/-- **Relation (A) in the frame**: `∑_b S_xb = 2(n-2)`. -/
theorem rowA_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) (x : Γ) :
    ∑ b, Smat (Tc v) x b = 2 * ((Fintype.card ι : ℝ) - 2) := by
  unfold Smat Tc
  exact killing_frame hW hf x

/-- The pairing of a frame combination under `W`: `⟨W(∑ d_b v_b), ∑ d_b v_b⟩ = ∑ λ_b d_b²`. -/
theorem frame_quad (hW : IsWeyl W) (hf : EigenFrame W v lam) (d : Γ → ℝ) :
    inner2 (W (∑ b, d b • v b)) (∑ b, d b • v b) = ∑ b, lam b * d b ^ 2 := by
  rw [weyl_lin hW Finset.univ d v hf.skew]
  simp only [hf.eigen, smul_smul, inner2_sum_l, inner2_sum_r, inner2_smul_l, inner2_smul_r,
    hf.orthonormal, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq',
    Finset.mem_univ, if_true]
  exact Finset.sum_congr rfl fun b _ => by ring

/-- **Relation (B) in the frame**: `∑_b S_xb λ_b = -2 λ_x`, from `aW2`. -/
theorem rowB_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) (x : Γ) :
    ∑ b, Smat (Tc v) x b * lam b = -2 * lam x := by
  have h := aW2 hW (v x) (hf.skew x)
  have hF : ∀ c : Γ → ℝ, (fun Y => W (br (v x) Y)) (∑ γ, c γ • v γ)
      = ∑ γ, c γ • (fun Y => W (br (v x) Y)) (v γ) := fun c => by
    simp only
    rw [br_sum_r, weyl_lin hW Finset.univ c _ (fun γ => br_skew (hf.skew x) (hf.skew γ))]
  have hG : ∀ c : Γ → ℝ, (fun Y => br (v x) Y) (∑ γ, c γ • v γ)
      = ∑ γ, c γ • (fun Y => br (v x) Y) (v γ) := fun c => br_sum_r _ _ _ _
  have e1 : (1 / 2) * ∑ i, ∑ j, inner2 (W (br (v x) (phi i j))) (br (v x) (phi i j))
      = innerOp (fun Y => W (br (v x) Y)) (fun Y => br (v x) Y) := rfl
  rw [e1, innerOp_frame hf _ _ hF hG] at h
  -- each frame term
  have hterm : ∀ γ, inner2 (W (br (v x) (v γ))) (br (v x) (v γ)) = ∑ b, lam b * cst v x γ b ^ 2 := by
    intro γ
    have hY := hf.complete _ (br_skew (hf.skew x) (hf.skew γ))
    rw [hY]
    exact frame_quad hW hf _
  have hrhs : inner2 (W (v x)) (v x) = lam x := by
    rw [hf.eigen x, inner2_smul_l, hf.orthonormal, if_pos rfl, mul_one]
  simp only [hterm, hrhs] at h
  rw [Finset.sum_comm] at h
  unfold Smat Tc
  rw [← h]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [cst_swap23 hf x b c]
  ring

/-- **`S` is symmetric**, `c_abc = -c_bac`. -/
theorem S_symm (hf : EigenFrame W v lam) (a b : Γ) : Smat (Tc v) a b = Smat (Tc v) b a := by
  unfold Smat Tc
  exact Finset.sum_congr rfl fun c _ => by rw [cst_swap12 hf a b c]; ring

/-- **`S` is hollow**, `c_aac = 0`. -/
theorem S_hollow (hf : EigenFrame W v lam) (a : Γ) : Smat (Tc v) a a = 0 := by
  unfold Smat Tc
  refine Finset.sum_eq_zero fun c _ => ?_
  have := cst_swap12 hf a a c
  have h0 : cst v a a c = 0 := by linarith
  rw [h0]; ring

/-- **The pair cap** ([r1704](../../../reviews/REVIEW_r1704.md) G1), L112's *"one constructive
consequence"*: `Ŝ_ab ≤ 1/(n-2)` at every Weyl eigenframe, since `S_ab = ‖[v_a, v_b]‖²`
(`brnorm_frame`) is at most `2` by L31's bracket cap (`L31_cap_unit`). It does not follow from (A)
and (B) on an abstract `T`, and it does follow at the operator. -/
theorem hatS_pair_cap (hf : EigenFrame W v lam) (hn : 0 < (Fintype.card ι : ℝ) - 2) (a b : Γ) :
    hatS (Smat (Tc v)) (Fintype.card ι) a b ≤ 1 / ((Fintype.card ι : ℝ) - 2) := by
  have hS : Smat (Tc v) a b ≤ 2 := by
    unfold Smat Tc
    rw [← brnorm_frame hf a b]
    exact HamiltonsCubic.L31Statement.L31_cap_unit _ _ (hf.skew a) (hf.skew b)
      (by rw [hf.orthonormal, if_pos rfl]) (by rw [hf.orthonormal, if_pos rfl])
  simp only [hatS, Matrix.of_apply]
  rw [div_le_div_iff₀ (by positivity) hn]
  nlinarith

/-- **`Ŝ` is symmetric** ([r1704](../../../reviews/REVIEW_r1704.md) O2). -/
theorem hatS_symm (hf : EigenFrame W v lam) (n : ℝ) (a b : Γ) :
    hatS (Smat (Tc v)) n a b = hatS (Smat (Tc v)) n b a := by
  simp only [hatS, Matrix.of_apply, S_symm hf a b]

/-- **L112 at every Weyl eigenframe.** -/
theorem L112_at_frame (hW : IsWeyl W) (hf : EigenFrame W v lam)
    (hn : 0 < (Fintype.card ι : ℝ) - 2) :
    hatS (Smat (Tc v)) (Fintype.card ι) ∈ doublyStochastic ℝ Γ ∧
      (∀ a, hatS (Smat (Tc v)) (Fintype.card ι) a a = 0) ∧
      ∀ a, ∑ b, hatS (Smat (Tc v)) (Fintype.card ι) a b * lam b
        = -(1 / ((Fintype.card ι : ℝ) - 2)) * lam a :=
  ⟨hatS_doublyStochastic hn (Smat_nonneg fun _ _ _ => sq_nonneg _) (S_symm hf) (rowA_frame hW hf),
    hatS_hollow (S_hollow hf), hatS_eigenvector hn (rowB_frame hW hf)⟩

open HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind in
/-- **L112 at every linear Weyl operator on `ℝⁿ`, `n ≥ 3`**, in its spectral frame: `λ` is a
`-1/(n-2)`-eigenvector of the symmetric hollow doubly stochastic `Ŝ` built from `T = c²`. -/
theorem L112_op {n : ℕ} (hn : 3 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) :
    let v := frameVec W hW.1 hW.2.1 hW.2.2.1
    let lam := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
    hatS (Smat (Tc v)) n ∈ doublyStochastic ℝ (Pairs n) ∧
      (∀ a, hatS (Smat (Tc v)) n a a = 0) ∧
      ∀ a, ∑ b, hatS (Smat (Tc v)) n a b * lam b = -(1 / ((n : ℝ) - 2)) * lam a := by
  intro v lam
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  have hn' : 0 < ((Fintype.card (Fin n) : ℕ) : ℝ) - 2 := by
    simp only [Fintype.card_fin]
    have : (3 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have := L112_at_frame hW.2 hf hn'
  simpa only [Fintype.card_fin] using this

end HamiltonsCubic.L112Op
