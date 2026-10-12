import HamiltonsCubic.Results.L120Diag
import Mathlib.Data.Sym.Card

set_option linter.style.longLine false

/-!
# `dim 𝒟ₙ = n(n − 3)/2`

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: `𝒟ₙ` has dimension `n(n − 3)/2`, *"Ricci-
flatness cuts the trivial block by its `n` row sums"*. [L120Diag.lean](L120Diag.lean) identifies `𝒟ₙ` with the diagonal
operators of weights. This file counts it, at `n = |ι| ≥ 3`:

* **`symHollow`**, **`finrank_symHollow`**: the symmetric hollow matrices, in linear bijection with the functions on the
  off-diagonal unordered pairs, have dimension `binom n 2`;
* **`rowSumL`**, **`rowSumL_surj`**: the row sums are onto `ℝⁿ` at `n ≥ 3`, by the explicit preimage
  `w_{ab} = (v_a + v_b)/(n − 2) − S/((n − 1)(n − 2))`, `S = ∑ v`;
* **`finrank_weights`**: the weights, the kernel of the row sums, have dimension `binom n 2 − n`;
* **`diagSummand_finrank`**: `w ↦ diagOp w` is injective on them, so the trivial summand has dimension
  `binom n 2 − n`, and **`two_mul_choose_two_sub`**, `2 (binom n 2 − n) = n(n − 3)`, together
  **`diagSummand_finrank_closed`**, `2 dim 𝒟ₙ = n(n − 3)`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.WeylRadical

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The symmetric hollow matrices. -/
def symHollow (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (Matrix ι ι ℝ) where
  carrier := {w | (∀ a b, w a b = w b a) ∧ ∀ a, w a a = 0}
  add_mem' {w v} hw hv := ⟨fun a b => by simp [hw.1 a b, hv.1 a b], fun a => by simp [hw.2 a, hv.2 a]⟩
  zero_mem' := ⟨fun _ _ => rfl, fun _ => rfl⟩
  smul_mem' c w hw := ⟨fun a b => by simp [hw.1 a b], fun a => by simp [hw.2 a]⟩

/-- A symmetric hollow matrix read on the off-diagonal unordered pairs. -/
noncomputable def toOff : symHollow ι →ₗ[ℝ] ({z : Sym2 ι // ¬ z.IsDiag} → ℝ) where
  toFun w z := Sym2.lift ⟨fun a b => (w : Matrix ι ι ℝ) a b, w.2.1⟩ z.1
  map_add' w v := by
    funext ⟨z, _⟩
    induction z using Sym2.ind with
    | h x y => simp [Sym2.lift_mk]
  map_smul' c w := by
    funext ⟨z, _⟩
    induction z using Sym2.ind with
    | h x y => simp [Sym2.lift_mk]

theorem toOff_bij : Function.Bijective (toOff (ι := ι)) := by
  constructor
  · intro w v h
    apply Subtype.ext
    ext a b
    by_cases hab : a = b
    · subst hab; rw [w.2.2 a, v.2.2 a]
    · have hz : ¬ (s(a, b) : Sym2 ι).IsDiag := by rwa [Sym2.mk_isDiag_iff]
      have := congrFun h ⟨s(a, b), hz⟩
      simpa [toOff, Sym2.lift_mk] using this
  · intro f
    refine ⟨⟨Matrix.of fun a b => if h : a = b then 0 else f ⟨s(a, b), by rwa [Sym2.mk_isDiag_iff]⟩,
      fun a b => ?_, fun a => by simp⟩, ?_⟩
    · simp only [Matrix.of_apply]
      by_cases hab : a = b
      · subst hab; rfl
      · rw [dif_neg hab, dif_neg (Ne.symm hab)]
        congr 2
        exact Sym2.eq_swap
    · funext ⟨z, hz⟩
      induction z using Sym2.ind with
      | h x y =>
        have hxy : x ≠ y := by rwa [Sym2.mk_isDiag_iff] at hz
        simp [toOff, Sym2.lift_mk, hxy]

/-- **The symmetric hollow matrices have dimension `binom n 2`.** -/
theorem finrank_symHollow : Module.finrank ℝ (symHollow ι) = (Fintype.card ι).choose 2 := by
  rw [LinearEquiv.finrank_eq (LinearEquiv.ofBijective _ toOff_bij), Module.finrank_fintype_fun_eq_card,
    Sym2.card_subtype_not_diag]

/-- The row sums of a symmetric hollow matrix. -/
def rowSumL : symHollow ι →ₗ[ℝ] (ι → ℝ) where
  toFun w a := ∑ c, (w : Matrix ι ι ℝ) a c
  map_add' w v := by funext a; simp [Finset.sum_add_distrib]
  map_smul' c w := by funext a; simp [Finset.mul_sum]

/-- **The row sums are onto at `n ≥ 3`.** -/
theorem rowSumL_surj (hn : 3 ≤ Fintype.card ι) : Function.Surjective (rowSumL (ι := ι)) := by
  intro v
  have h3 : (3 : ℝ) ≤ (Fintype.card ι : ℝ) := by exact_mod_cast hn
  set N : ℝ := (Fintype.card ι : ℝ)
  set S := ∑ c, v c
  have hN2 : N - 2 ≠ 0 := by linarith
  have hN1 : N - 1 ≠ 0 := by linarith
  let g : ι → ι → ℝ := fun a b => (v a + v b) / (N - 2) - S / ((N - 1) * (N - 2))
  refine ⟨⟨Matrix.of fun a b => if a = b then 0 else g a b, fun a b => ?_, fun a => by simp⟩, ?_⟩
  · simp only [Matrix.of_apply, g]
    by_cases hab : a = b
    · subst hab; rfl
    · rw [if_neg hab, if_neg (Ne.symm hab), add_comm (v a)]
  · funext a
    change ∑ c, (if a = c then 0 else g a c) = v a
    have e : ∑ c, (if a = c then 0 else g a c) = ∑ c, g a c - g a a := by
      have t : ∀ c, (if a = c then 0 else g a c) = g a c - (if a = c then g a c else 0) := fun c => by
        split_ifs <;> ring
      rw [Finset.sum_congr rfl (fun c _ => t c), Finset.sum_sub_distrib, Finset.sum_ite_eq,
        if_pos (Finset.mem_univ a)]
    rw [e]
    have hsum : ∑ c, g a c = (N * v a + S) / (N - 2) - N * S / ((N - 1) * (N - 2)) := by
      simp only [g, Finset.sum_sub_distrib, ← Finset.sum_div, Finset.sum_add_distrib, Finset.sum_const,
        Finset.card_univ, nsmul_eq_mul]
      ring
    rw [hsum]
    simp only [g]
    field_simp
    ring

/-- **The weights, the kernel of the row sums, have dimension `binom n 2 − n`** at `n ≥ 3`. -/
theorem finrank_weights (hn : 3 ≤ Fintype.card ι) :
    Module.finrank ℝ (LinearMap.ker (rowSumL (ι := ι))) = (Fintype.card ι).choose 2 - Fintype.card ι := by
  have h := LinearMap.finrank_range_add_finrank_ker (rowSumL (ι := ι))
  rw [LinearMap.range_eq_top.mpr (rowSumL_surj hn), finrank_top, Module.finrank_fintype_fun_eq_card,
    finrank_symHollow] at h
  omega

/-- A kernel element of the row sums is a weight. -/
theorem isWeight_of_ker (w : LinearMap.ker (rowSumL (ι := ι))) : IsWeight ((w : symHollow ι) : Matrix ι ι ℝ) where
  symm := (w : symHollow ι).2.1
  hollow := (w : symHollow ι).2.2
  rowSum a := congrFun (LinearMap.mem_ker.mp w.2) a

/-- The weight-to-operator map on the weights. -/
noncomputable def weightOp : LinearMap.ker (rowSumL (ι := ι)) →ₗ[ℝ] CurvLin ι where
  toFun w := diagS ((w : symHollow ι) : Matrix ι ι ℝ)
  map_add' w v := by
    apply LinearMap.ext; intro Y
    change diagOp _ _ = diagOp _ _ + diagOp _ _
    ext p q; simp [diagOp, add_mul]
  map_smul' c w := by
    apply LinearMap.ext; intro Y
    change diagOp _ _ = c • diagOp _ _
    ext p q; simp [diagOp, mul_assoc]

/-- **The trivial summand is the image of the weights**: its members are exactly the members of `weylModuleS` fixed by
the whole sign group. -/
theorem diagSummand_mem (R : CurvLin ι) :
    R ∈ LinearMap.range (weightOp (ι := ι))
      ↔ R ∈ weylModuleS ι ∧ ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) R = R := by
  constructor
  · rintro ⟨w, rfl⟩
    have hw := isWeight_of_ker w
    exact ⟨diagS_mem hw, fun ε hε => diagS_signMat hw ε hε⟩
  · rintro ⟨hR, hiso⟩
    obtain ⟨w, hw, rfl⟩ := (diagSummand_iff R hR).mp hiso
    exact ⟨⟨⟨w, hw.symm, hw.hollow⟩, LinearMap.mem_ker.mpr (funext hw.rowSum)⟩, rfl⟩

/-- **`dim 𝒟ₙ = binom n 2 − n`**, which is `n(n − 3)/2`, at `n ≥ 3`. -/
theorem diagSummand_finrank (hn : 3 ≤ Fintype.card ι) :
    Module.finrank ℝ (LinearMap.range (weightOp (ι := ι))) = (Fintype.card ι).choose 2 - Fintype.card ι := by
  have hinj : Function.Injective (weightOp (ι := ι)) := by
    intro w v h
    apply Subtype.ext; apply Subtype.ext
    ext a b
    have hw := isWeight_of_ker w
    have hv := isWeight_of_ker v
    by_cases hab : a = b
    · subst hab; rw [hw.hollow a, hv.hollow a]
    · have e := congrArg (fun F : CurvLin ι => coord F a b a b) h
      change coord (diagS _) a b a b = coord (diagS _) a b a b at e
      rw [coord_diagS hw.symm, coord_diagS hv.symm, inner2_phi_phi, if_pos ⟨rfl, rfl⟩,
        if_neg (fun h => hab h.1)] at e
      simpa using e
  rw [LinearMap.finrank_range_of_inj hinj, finrank_weights hn]

/-- **`2 (binom n 2 − n) = n(n − 3)`** at `n ≥ 3`, so `diagSummand_finrank` is `n(n − 3)/2`. -/
theorem two_mul_choose_two_sub {n : ℕ} (hn : 3 ≤ n) : 2 * (n.choose 2 - n) = n * (n - 3) := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 3 := ⟨n - 3, by omega⟩
  have hC : 2 * (m + 3).choose 2 = (m + 3) * (m + 2) := by
    rw [Nat.choose_two_right, show m + 3 - 1 = m + 2 by omega]
    rw [show (m + 3) * (m + 2) = (m + 2) * (m + 2 + 1) by ring]
    exact Nat.mul_div_cancel' (Nat.even_mul_succ_self (m + 2)).two_dvd
  have hge : m + 3 ≤ (m + 3).choose 2 := by nlinarith
  rw [show m + 3 - 3 = m by omega]
  zify [hge] at hC ⊢
  linear_combination hC

/-- **`2 dim 𝒟ₙ = n(n − 3)`** at `n ≥ 3`, in one statement. -/
theorem diagSummand_finrank_closed (hn : 3 ≤ Fintype.card ι) :
    2 * Module.finrank ℝ (LinearMap.range (weightOp (ι := ι))) = Fintype.card ι * (Fintype.card ι - 3) := by
  rw [diagSummand_finrank hn, two_mul_choose_two_sub hn]

end HamiltonsCubic.Results
