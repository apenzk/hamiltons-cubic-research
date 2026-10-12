import HamiltonsCubic.Results.L50Coord
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false

/-!
# L50, the collapse fails at every `n ≥ 6`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50: the collapse `θ = 3 tr W³` holds on `𝒲ₙ` for
`n ≤ 5` "and only there". [L50Coord.lean](L50Coord.lean) proves the first half. This file proves the second with one
witness per `n`: the diagonal operator of `S³ × S³`, in-block weight `3` and cross weight `−2`, padded by zeros.

- `R4_diagOp`: a diagonal operator has `W_{ijkl} = w_{ij}(δ_{ik}δ_{jl} − δ_{jk}δ_{il})`;
- `alphaW_diagOp`, `betaW_diagOp`: `α = 4 ∑ w_{ij}³` and `β = ∑ w_{ij} w_{im} w_{jm}` over ordered indices;
- `L50_converse`: for every `n ≥ 6` a linear Weyl operator on `Fin n` with `P ≠ 3 tr M³`, the gap being
  `P − 3 tr M³ = (β − α/2)/2 = 630`.
-/

namespace HamiltonsCubic.SecondKind

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.FamilyLayer HamiltonsCubic.L50Spectra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section diag
variable (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a)
include hw

/-- **The tensor of a diagonal operator.** -/
theorem R4_diagOp (i j k l : ι) :
    R4 (diagOp w) i j k l = w i j * ((if i = k ∧ j = l then 1 else 0) - (if j = k ∧ i = l then 1 else 0)) := by
  unfold R4; rw [diagOp_phi w hw, FamilyLayer.inner2_smul_left, inner2_phi_phi]

/-- **Contracting a diagonal tensor's second pair**: `∑_{m,n} W_{ijmn} f(m,n) = w_{ij}(f(i,j) − f(j,i))`. -/
theorem sum_R4_diagOp (i j : ι) (f : ι → ι → ℝ) :
    ∑ m, ∑ n, R4 (diagOp w) i j m n * f m n = w i j * (f i j - f j i) := by
  simp only [R4_diagOp w hw, ite_and, mul_sub, sub_mul, mul_ite, ite_mul, mul_one, mul_zero, zero_mul,
    Finset.sum_sub_distrib]
  simp [Finset.sum_ite_irrel, Finset.sum_ite_eq]

variable (hh : ∀ a, w a a = 0)
include hh

/-- **`α = 4 ∑ w_{ij}³`** on a diagonal operator. -/
theorem alphaW_diagOp : alphaW (diagOp w) = 4 * ∑ i, ∑ j, w i j ^ 3 := by
  unfold alphaW; rw [Finset.mul_sum]
  refine sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]
  refine sum_congr rfl fun j _ => ?_
  have h1 : ∀ k l, ∑ m, ∑ n, R4 (diagOp w) i j k l * R4 (diagOp w) i j m n * R4 (diagOp w) k l m n
      = R4 (diagOp w) i j k l * (w i j * (R4 (diagOp w) k l i j - R4 (diagOp w) k l j i)) := by
    intro k l
    rw [← sum_R4_diagOp w hw i j (fun m n => R4 (diagOp w) k l m n), Finset.mul_sum]
    refine sum_congr rfl fun m _ => ?_
    rw [Finset.mul_sum]
    exact sum_congr rfl fun n _ => by ring
  simp only [h1]
  rw [sum_R4_diagOp w hw i j (fun k l => w i j * (R4 (diagOp w) k l i j - R4 (diagOp w) k l j i))]
  by_cases hij : i = j
  · subst hij; simp [hh]
  · simp only [R4_diagOp w hw, hw j i]
    simp [hij, Ne.symm hij]
    ring

/-- **`β = ∑ w_{ij} w_{im} w_{jm}`** on a diagonal operator. -/
theorem betaW_diagOp : betaW (diagOp w) = ∑ i, ∑ j, ∑ m, w i j * w i m * w j m := by
  unfold betaW
  refine sum_congr rfl fun i _ => ?_
  refine sum_congr rfl fun j _ => ?_
  have h1 : ∀ k l, ∑ m, ∑ n, R4 (diagOp w) i j k l * R4 (diagOp w) i m k n * R4 (diagOp w) j m l n
      = R4 (diagOp w) i j k l * ∑ m, ∑ n, R4 (diagOp w) i m k n * R4 (diagOp w) j m l n := by
    intro k l
    rw [Finset.mul_sum]
    refine sum_congr rfl fun m _ => ?_
    rw [Finset.mul_sum]
    exact sum_congr rfl fun n _ => by ring
  simp only [h1]
  rw [sum_R4_diagOp w hw i j (fun k l => ∑ m, ∑ n, R4 (diagOp w) i m k n * R4 (diagOp w) j m l n)]
  by_cases hij : i = j
  · subst hij; simp [hh]
  · simp only [R4_diagOp w hw]
    simp [hij, Ne.symm hij, ite_and, Finset.sum_ite_eq, Finset.mul_sum]
    refine sum_congr rfl fun x _ => ?_
    by_cases hxi : x = i
    · subst hxi; simp [hh]
    by_cases hxj : x = j
    · subst hxj; simp [hh]
    simp [hxi, hxj, mul_ite, ite_mul, Finset.sum_ite_eq]
    ring

end diag
/-- The weight of `S³ × S³` on the first six indices, padded by zeros: `3` inside a block, `−2` across. -/
noncomputable def g6 (i j : ℕ) : ℝ :=
  if i = j ∨ 6 ≤ i ∨ 6 ≤ j then 0 else if (decide (i < 3)) = (decide (j < 3)) then 3 else -2

/-- **The padded witness** on `Fin n`. -/
noncomputable def wS (n : ℕ) : Matrix (Fin n) (Fin n) ℝ := Matrix.of fun a b => g6 a.val b.val

theorem g6_symm (i j : ℕ) : g6 i j = g6 j i := by
  unfold g6; by_cases h1 : i = j <;> by_cases h2 : 6 ≤ i <;> by_cases h3 : 6 ≤ j <;>
    by_cases h4 : i < 3 <;> by_cases h5 : j < 3 <;> simp [h1, h2, h3, h4, h5, eq_comm]

theorem g6_zero (i j : ℕ) (h : 6 ≤ i ∨ 6 ≤ j) : g6 i j = 0 := by unfold g6; simp [h]

/-- A sum over `Fin n` of a function of the index vanishing from `6` on is a sum over `range 6`. -/
theorem sum_fin_six {n : ℕ} (hn : 6 ≤ n) (F : ℕ → ℝ) (hF : ∀ k, 6 ≤ k → F k = 0) :
    ∑ b : Fin n, F b.val = ∑ k ∈ range 6, F k := by
  rw [Fin.sum_univ_eq_sum_range F n]
  refine (Finset.sum_subset (fun k hk => ?_) fun k _ hk => hF k ?_).symm
  · simp at hk ⊢; omega
  · simp at hk; omega

theorem wS_isWeight {n : ℕ} (hn : 6 ≤ n) : IsWeight (wS n) where
  symm a b := g6_symm _ _
  hollow a := by simp [wS, g6]
  rowSum a := by
    simp only [wS, Matrix.of_apply]
    rw [sum_fin_six hn (fun k => g6 a.val k) fun k hk => g6_zero _ _ (Or.inr hk)]
    by_cases ha : 6 ≤ a.val
    · simp [g6_zero _ _ (Or.inl ha)]
    · have : a.val < 6 := by omega
      interval_cases a.val <;> simp [Finset.sum_range_succ, g6] <;> norm_num

theorem wS_cube {n : ℕ} (hn : 6 ≤ n) : ∑ i, ∑ j, wS n i j ^ 3 = 180 := by
  simp only [wS, Matrix.of_apply]
  rw [sum_fin_six hn (fun i => ∑ j : Fin n, g6 i j.val ^ 3) fun k hk => by simp [g6_zero _ _ (Or.inl hk)]]
  rw [Finset.sum_congr rfl fun i _ => sum_fin_six hn (fun j => g6 i j ^ 3) fun k hk => by
    simp [g6_zero _ _ (Or.inr hk)]]
  simp [Finset.sum_range_succ, g6]; norm_num

theorem wS_tri {n : ℕ} (hn : 6 ≤ n) : ∑ i, ∑ j, ∑ m, wS n i j * wS n i m * wS n j m = 1620 := by
  simp only [wS, Matrix.of_apply]
  rw [sum_fin_six hn (fun i => ∑ j : Fin n, ∑ m : Fin n, g6 i j.val * g6 i m.val * g6 j.val m.val)
    fun k hk => by simp [g6_zero _ _ (Or.inl hk)]]
  rw [Finset.sum_congr rfl fun i _ => sum_fin_six hn (fun j => ∑ m : Fin n, g6 i j * g6 i m.val * g6 j m.val)
    fun k hk => by simp [g6_zero _ _ (Or.inl hk), g6_zero _ _ (Or.inr hk)]]
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    sum_fin_six hn (fun m => g6 i j * g6 i m * g6 j m) fun k hk => by simp [g6_zero _ _ (Or.inr hk)]]
  simp [Finset.sum_range_succ, g6]; norm_num

/-- **THE COLLAPSE FAILS AT EVERY `n ≥ 6`**: the padded `S³ × S³` operator is a linear Weyl operator with
`P = 900`, `tr M³ = 90` and `⟨M#, M⟩ = 810`, so `P ≠ 3 tr M³` and `⟨M#, M⟩ ≠ 2 tr M³`. -/
theorem L50_converse (n : ℕ) (hn : 6 ≤ n) :
    ∃ R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ,
      IsWeylOp R ∧ Pcubic R ≠ 3 * trCube R ∧ sharpPair R ≠ 2 * trCube R := by
  have hw := wS_isWeight hn
  have hW := diagOp_isWeyl hw
  have hL := isLinOp_diagOp (wS n)
  refine ⟨diagOp (wS n), ⟨hL, hW⟩, ?_, ?_⟩
  · rw [Pcubic_eq_alpha_beta _ hL hW.1 hW.2.1, trCube_eq_alpha _ hW.1 hW.2.1,
      alphaW_diagOp _ hw.symm hw.hollow, betaW_diagOp _ hw.symm hw.hollow, wS_cube hn, wS_tri hn]
    norm_num
  · rw [sharpPair_eq_beta _ hL hW.1 hW.2.1, trCube_eq_alpha _ hW.1 hW.2.1,
      alphaW_diagOp _ hw.symm hw.hollow, betaW_diagOp _ hw.symm hw.hollow, wS_cube hn, wS_tri hn]
    norm_num

end HamiltonsCubic.SecondKind
