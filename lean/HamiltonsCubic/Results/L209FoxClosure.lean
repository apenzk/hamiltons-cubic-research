import Mathlib.Tactic
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Results.L208RicciFoxSquare
import HamiltonsCubic.Base.SharpDiag
import HamiltonsCubic.Base.Families

/-!
# Lemma L209, the Fox square preserves the Weyl module

[findings/curvature-invariants.md](../../../findings/curvature-invariants.md), the L209 block.

**The statement, quoted from the record**: for a linear self-adjoint bivector operator `R`
satisfying first Bianchi,
`Ric(Q(R))_ab = ∑_{c,d} R_{ac,bd} Ric(R)_cd`, where `R_{ij,kl} = ⟨R φ_ij, φ_kl⟩`.
Ricci-flatness of `R` then gives Ricci-flatness of `Q(R)`, and with the Bianchi half this is
closure of the Fox product on `𝒲ₙ`.

## What is typed here, and what is not

* `R4` is the four-index reading `R_{ij,kl}` on the record's own `inner2` and `phi`.
* `ric_Qop_eq` is **the statement**, over the record's `Ric`, `Qop` and `bianchi`, with the four
  hypotheses the prose proof uses and no Ricci-flatness. **It is PROVED, with no `sorry`**, from
  `ric_Qop_split`, `ric_compOp_eq` (the `R²` half, self-adjointness alone) and `ric_sharpOp_eq`, the
  `#` half `Ric(R#)_ab = ∑ R_{ac,bd} Ric(R)_cd - ∑_c ⟨R φ_ac, R φ_bc⟩`. That half runs in three
  steps: `ric_sharpOp_eq_sum` reduces it to `∑_c sharpBil R φ_ac φ_bc`, `T_eq` writes the quartic
  trace of `sharpBil_expand` in four-index form, and `quad_bianchi` is the one use of first Bianchi.
* `ric_Qop_id` and `rhs_id` are **the two `id` anchors, proved**: both sides are `(n-1)²δ` at
  `R = id`, which is what pins the `+` sign of the identity against BW08's eigenframe form.
* **Not typed**: the Bianchi half `b(Q(R)) = 0`, and the polarisation to `X ∘ Y ∈ 𝒲ₙ`.
-/

set_option linter.style.longLine false
set_option linter.unusedDecidableInType false

namespace HamiltonsCubic.Results

open Finset RealLayer FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The four-index reading of a bivector operator**, `R_{ij,kl} = ⟨R φ_ij, φ_kl⟩`. -/
noncomputable def R4 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) : ℝ :=
  inner2 (R (phi i j)) (phi k l)

/-- **The `R²` half of `Ric(Q R)`, proved**: `Ric(R²)_ab = ∑_c ⟨R φ_ac, R φ_bc⟩`, from
self-adjointness on bivectors alone. -/
theorem ric_compOp_eq (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (a b : ι) :
    Ric (compOp R) a b = ∑ c, inner2 (R (phi a c)) (R (phi b c)) := by
  unfold Ric compOp
  exact Finset.sum_congr rfl fun c _ =>
    hsym (R (phi a c)) (phi b c) (hskew _ (phi_isSkew a c)) (phi_isSkew b c)

/-- **`Ric` is additive across `Q R = R² + R#`.** -/
theorem ric_Qop_split (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b : ι) :
    Ric (Qop R) a b = Ric (compOp R) a b + Ric (sharpOp R) a b := by
  unfold Ric Qop
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun c _ => by
    simp [inner2, Matrix.trace_add, Matrix.transpose_add, Matrix.add_mul]; ring

theorem inner2_neg_left'' (X Y : Matrix ι ι ℝ) : inner2 (-X) Y = - inner2 X Y := by
  simp [inner2, Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]

theorem inner2_neg_right'' (X Y : Matrix ι ι ℝ) : inner2 X (-Y) = - inner2 X Y := by
  simp [inner2, Matrix.mul_neg, Matrix.trace_neg]

/-- `sharpBil` is odd in its second slot, for a linear `R`. -/
theorem sharpBil_neg_right (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (X Y : Matrix ι ι ℝ) :
    sharpBil R X (-Y) = - sharpBil R X Y := by
  rw [sharpBil_expand R hR, sharpBil_expand R hR]
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hbr1 : ∀ A B : Matrix ι ι ℝ, br (-A) B = - br A B := fun A B => by simp [br]; abel
  have hbr2 : ∀ A B : Matrix ι ι ℝ, br A (-B) = - br A B := fun A B => by simp [br]; abel
  simp only [hbr1, hbr2, hneg, inner2_neg_left'']
  simp only [Finset.sum_neg_distrib, ← neg_add]
  ring

/-- **Step 1 of L209's `#` half**: `Ric(R#)_ab = ∑_c sharpBil R φ_ac φ_bc`, by orthonormality of the
`φ` family and the oddness of `sharpBil` in its second slot. -/
theorem ric_sharpOp_eq_sum (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (a b : ι) :
    Ric (sharpOp R) a b = ∑ c, sharpBil R (phi a c) (phi b c) := by
  unfold Ric sharpOp
  refine Finset.sum_congr rfl fun c _ => ?_
  have hlin : ∀ (s : Finset ι) (f : ι → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ),
      inner2 (∑ i ∈ s, f i) Y = ∑ i ∈ s, inner2 (f i) Y := by
    intro s f Y; simp [inner2, Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]
  have hsm : ∀ (r : ℝ) (X Y : Matrix ι ι ℝ), inner2 (r • X) Y = r * inner2 X Y := by
    intro r X Y; simp [inner2, Matrix.transpose_smul, Matrix.trace_smul]; ring
  rw [hsm, hlin]
  simp only [hlin, hsm, inner2_phi_phi]
  simp only [mul_sub, mul_ite, mul_one, mul_zero, ite_and, Finset.sum_sub_distrib,
    Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have hcol : ∀ F : ι → ι → ℝ,
      (∑ x, ∑ y, if x = b then (if y = c then F x y else 0) else 0) = F b c := by
    intro F
    rw [Fintype.sum_eq_single b (fun x hx => by simp [hx])]
    simp
  rw [hcol (fun x y => sharpBil R (phi a c) (phi x y))]
  try rw [phi_swap b c, sharpBil_neg_right R hR]
  ring

/-- **`[φ_bc, M]` in coordinates**, for skew `M`: `∑_s ⟨M, φ_bs⟩ φ_cs - ∑_s ⟨M, φ_cs⟩ φ_bs`. -/
theorem br_phi_skew (b c : ι) (M : Matrix ι ι ℝ) (hM : IsSkew M) :
    br (phi b c) M = (∑ s, (inner2 M (phi b s)) • phi c s) - ∑ s, (inner2 M (phi c s)) • phi b s := by
  have hji : ∀ i j, M j i = - M i j := by
    intro i j
    have := congrFun (congrFun hM i) j
    simpa [Matrix.transpose_apply] using this
  simp only [inner2_phi M hM]
  ext p q
  simp only [br, phi, Matrix.sub_apply, Matrix.mul_apply, Matrix.single_apply, Matrix.sum_apply,
    Matrix.smul_apply, smul_eq_mul, ite_and, mul_sub, sub_mul, mul_ite, ite_mul, mul_one, one_mul,
    mul_zero, zero_mul, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, if_true]
  have hs2 : ∀ (P : Prop) [Decidable P] (a : ι) (g : ι → ℝ),
      (∑ x, if P then (if a = x then g x else 0) else 0) = if P then g a else 0 := by
    intro P _ a g; split_ifs <;> simp
  have hs3 : ∀ (P : Prop) [Decidable P] (a : ι) (g : ι → ℝ),
      (∑ x, if P then (if x = a then g x else 0) else 0) = if P then g a else 0 := by
    intro P _ a g; split_ifs <;> simp
  simp only [hs2, hs3]
  rw [hji p b, hji p c]
  split_ifs <;> ring

theorem inner2_br_skew (X A B : Matrix ι ι ℝ) (hX : IsSkew X) :
    inner2 (br X A) B = - inner2 A (br X B) := by
  unfold IsSkew at hX
  unfold inner2 br
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hX]
  simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.neg_mul, Matrix.mul_neg, Matrix.trace_sub,
    Matrix.trace_neg, Matrix.mul_assoc]
  have h1 : (X * (A.transpose * B)).trace = (A.transpose * (B * X)).trace := by
    rw [Matrix.trace_mul_comm X, Matrix.mul_assoc]
  rw [h1]; ring

theorem br_isSkew_real (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) : IsSkew (br X Y) := by
  unfold IsSkew at *
  unfold br
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hX, hY]
  simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg, neg_sub]

theorem linOp_sum (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) {κ : Type*} (s : Finset κ)
    (f : κ → Matrix ι ι ℝ) : R (∑ k ∈ s, f k) = ∑ k ∈ s, R (f k) := by
  classical
  have hzero : R 0 = 0 := by have := hR.2 0 0; simpa using this
  induction s using Finset.induction_on with
  | empty => simp [hzero]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, hR.1, ih]

theorem inner2_sum_left' {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) :
    inner2 (∑ k ∈ s, f k) Y = ∑ k ∈ s, inner2 (f k) Y := by
  rw [inner2_comm, inner2_sum_right]
  exact Finset.sum_congr rfl fun k _ => inner2_comm _ _

theorem inner2_sub_left' (A B Y : Matrix ι ι ℝ) : inner2 (A - B) Y = inner2 A Y - inner2 B Y := by
  rw [sub_eq_add_neg, FamilyLayer.inner2_add_left, inner2_neg_left'', sub_eq_add_neg]

theorem inner2_sub_right' (X A B : Matrix ι ι ℝ) : inner2 X (A - B) = inner2 X A - inner2 X B := by
  rw [sub_eq_add_neg, inner2_add_right, inner2_neg_right'', sub_eq_add_neg]

/-- The inner bracket paired against a second `R`-image, in four-index form. -/
theorem G_eq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (y c i j p s : ι) :
    inner2 (br (phi y c) (R (phi i j))) (R (phi p s))
      = ∑ t, (R4 R i j y t * R4 R p s c t - R4 R i j c t * R4 R p s y t) := by
  rw [br_phi_skew y c _ (hskew _ (phi_isSkew i j)), inner2_sub_left', inner2_sum_left',
    inner2_sum_left', ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun t _ => ?_
  rw [FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_left, inner2_comm (phi c t), inner2_comm (phi y t)]
  rfl

theorem term_eq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (x y c i j : ι) :
    inner2 (br (phi x c) (R (br (phi y c) (R (phi i j))))) (phi i j)
      = -((∑ s, inner2 (phi i j) (phi x s) * inner2 (br (phi y c) (R (phi i j))) (R (phi c s)))
          - ∑ s, inner2 (phi i j) (phi c s) * inner2 (br (phi y c) (R (phi i j))) (R (phi x s))) := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hsub : ∀ A B : Matrix ι ι ℝ, R (A - B) = R A - R B := fun A B => by
    rw [sub_eq_add_neg, hR.1, hneg, sub_eq_add_neg]
  have hW : IsSkew (br (phi y c) (R (phi i j))) :=
    br_isSkew_real _ _ (phi_isSkew y c) (hskew _ (phi_isSkew i j))
  rw [inner2_br_skew _ _ _ (phi_isSkew x c),
    hsym _ _ hW (br_isSkew_real _ _ (phi_isSkew x c) (phi_isSkew i j)),
    br_phi_skew x c _ (phi_isSkew i j), hsub, linOp_sum R hR, linOp_sum R hR,
    inner2_sub_right', inner2_sum_right, inner2_sum_right]
  simp only [hR.2, FamilyLayer.inner2_smul_right]

theorem phi_collapse (p : ι) (F : ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ s, inner2 (phi i j) (phi p s) * F i j s = ∑ s, (F p s s - F s p s) := by
  have e1 : ∀ i j, ∑ s, inner2 (phi i j) (phi p s) * F i j s
      = (if i = p then F i j j else 0) - (if j = p then F i j i else 0) := by
    intro i j
    simp only [inner2_phi_phi, sub_mul, ite_mul, one_mul, zero_mul, Finset.sum_sub_distrib]
    congr 1
    · by_cases h : i = p <;> simp [h]
    · by_cases h : j = p <;> simp [h]
  have h1 : ∑ i, ∑ j, (if i = p then F i j j else 0) = ∑ s, F p s s := by
    rw [Finset.sum_comm]; simp
  have h2 : ∑ i, ∑ j, (if j = p then F i j i else 0) = ∑ s, F s p s := by simp
  simp only [e1, Finset.sum_sub_distrib, h1, h2]

/-- **Step 2b of L209's `#` half**: the quartic trace in `sharpBil_expand`, at `X = φ_xc`, `Y = φ_yc`,
in four-index form. Needs linearity, bivector preservation and self-adjointness, not Bianchi. -/
theorem T_eq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (x y c : ι) :
    ∑ i, ∑ j, inner2 (br (phi x c) (R (br (phi y c) (R (phi i j))))) (phi i j)
      = -4 * ∑ s, ∑ t, (R4 R x s y t * R4 R c s c t - R4 R x s c t * R4 R c s y t) := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hR4a : ∀ i j k l, R4 R j i k l = - R4 R i j k l := by
    intro i j k l; unfold R4; rw [phi_swap, hneg, inner2_neg_left'']
  simp only [term_eq R hR hskew hsym x y c, Finset.sum_neg_distrib, Finset.sum_sub_distrib]
  have c1 := phi_collapse x (fun i j s => inner2 (br (phi y c) (R (phi i j))) (R (phi c s)))
  have c2 := phi_collapse c (fun i j s => inner2 (br (phi y c) (R (phi i j))) (R (phi x s)))
  try simp only at c1 c2
  rw [c1, c2]
  have key : ∀ s,
      (inner2 (br (phi y c) (R (phi x s))) (R (phi c s))
        - inner2 (br (phi y c) (R (phi s x))) (R (phi c s)))
      - (inner2 (br (phi y c) (R (phi c s))) (R (phi x s))
        - inner2 (br (phi y c) (R (phi s c))) (R (phi x s)))
      = 4 * ∑ t, (R4 R x s y t * R4 R c s c t - R4 R x s c t * R4 R c s y t) := by
    intro s
    simp only [G_eq R hskew y c]
    simp only [← Finset.sum_sub_distrib, Finset.mul_sum]
    refine Finset.sum_congr rfl fun t _ => ?_
    simp only [hR4a x s, hR4a c s]; ring
  rw [← Finset.sum_sub_distrib, Finset.sum_congr rfl fun s _ => key s, ← Finset.mul_sum]
  simp only [Finset.sum_sub_distrib]
  ring

section step3
variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0)
include hR hskew hsym

theorem R4_pair (i j k l : ι) : R4 R i j k l = R4 R k l i j := by
  unfold R4; rw [hsym _ _ (phi_isSkew i j) (phi_isSkew k l), inner2_comm]

omit hskew hsym in
theorem R4_anti2 (i j k l : ι) : R4 R i j l k = - R4 R i j k l := by
  unfold R4; rw [phi_swap k l, inner2_neg_right'']

include hB in
/-- **The first-Bianchi quadratic identity**: `∑ R_{as,ct} R_{cs,bt} = ∑_c ⟨R φ_ac, R φ_bc⟩`. -/
theorem quad_bianchi (a b : ι) :
    ∑ c, ∑ s, ∑ t, R4 R a s c t * R4 R c s b t = ∑ c, inner2 (R (phi a c)) (R (phi b c)) := by
  have hBi : ∀ i j k l, R4 R i j k l = - R4 R i k l j - R4 R i l j k := by
    intro i j k l; have := hB i j k l; unfold bianchi at this; unfold R4; linarith
  have hA2 := R4_anti2 R hR
  have hP := R4_pair R hR hskew hsym
  set M := ∑ p, ∑ q, ∑ r, R4 R a p q r * R4 R b q p r with hM
  have e1 : ∑ c, ∑ s, ∑ t, R4 R a s c t * R4 R b s c t
      = ∑ c, ∑ s, ∑ t, R4 R a c s t * R4 R b c s t := Finset.sum_comm
  have e2 : ∑ c, ∑ s, ∑ t, R4 R a s c t * R4 R b c s t = M := Finset.sum_comm
  have e3 : ∑ c, ∑ s, ∑ t, R4 R a t c s * R4 R b c t s = M := by
    rw [Finset.sum_congr rfl fun c _ => Finset.sum_comm]; exact Finset.sum_comm
  have hL : ∑ c, ∑ s, ∑ t, R4 R a s c t * R4 R c s b t
      = ∑ c, ∑ s, ∑ t, (R4 R a s c t * R4 R b s c t - R4 R a s c t * R4 R b c s t) := by
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun s _ =>
      Finset.sum_congr rfl fun t _ => ?_
    rw [hP c s b t, hBi b t c s, hA2 b s c t]; ring
  have hB2 : ∑ c, ∑ s, ∑ t, R4 R a c s t * R4 R b c s t
      = ∑ c, ∑ s, ∑ t, (R4 R a s c t * R4 R b c s t + R4 R a t c s * R4 R b c t s) := by
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun s _ =>
      Finset.sum_congr rfl fun t _ => ?_
    rw [hBi a c s t, hA2 a s c t, hA2 b c t s]; ring
  have hR2 : ∀ c, inner2 (R (phi a c)) (R (phi b c))
      = (1/2) * ∑ s, ∑ t, R4 R a c s t * R4 R b c s t := by
    intro c
    conv_lhs => rw [← skew_expand (R (phi b c)) (hskew _ (phi_isSkew b c))]
    rw [FamilyLayer.inner2_smul_right, inner2_sum_right]
    congr 1
    refine Finset.sum_congr rfl fun s _ => ?_
    rw [inner2_sum_right]
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [FamilyLayer.inner2_smul_right]; unfold R4; ring
  simp only [hR2, ← Finset.mul_sum]
  rw [hL, hB2]
  simp only [Finset.sum_sub_distrib, Finset.sum_add_distrib]
  rw [e1, hB2]
  simp only [Finset.sum_add_distrib]
  rw [e2, e3]; ring

include hB in
/-- **L209's `#` half**, discharged. -/
theorem ric_sharpOp_eq' (a b : ι) :
    Ric (sharpOp R) a b
      = (∑ c, ∑ d, R4 R a c b d * Ric R c d) - ∑ c, inner2 (R (phi a c)) (R (phi b c)) := by
  have hA2 := R4_anti2 R hR
  have hP := R4_pair R hR hskew hsym
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hA1 : ∀ i j k l, R4 R j i k l = - R4 R i j k l := by
    intro i j k l; unfold R4; rw [phi_swap, hneg, inner2_neg_left'']
  rw [ric_sharpOp_eq_sum R hR, ← quad_bianchi R hR hskew hsym hB a b]
  simp only [sharpBil_expand R hR, Finset.sum_add_distrib, T_eq R hR hskew hsym]
  have hRic : ∀ c d, Ric R c d = ∑ e, R4 R c e d e := fun c d => rfl
  simp only [hRic, Finset.mul_sum]
  have P2 : ∑ c, ∑ s, ∑ t, R4 R b s a t * R4 R c s c t = ∑ c, ∑ s, ∑ t, R4 R a s b t * R4 R c s c t := by
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun s _ => Finset.sum_congr rfl fun t _ => ?_
    rw [hP b t a s, hP c t c s]
  have Q2 : ∑ c, ∑ s, ∑ t, R4 R b s c t * R4 R c s a t = ∑ c, ∑ s, ∑ t, R4 R a s c t * R4 R c s b t := by
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun s _ => Finset.sum_congr rfl fun t _ => ?_
    rw [hP b t c s, hP c t a s]; ring
  have P1 : ∑ c, ∑ s, ∑ t, R4 R a s b t * R4 R c s c t
      = ∑ c, ∑ d, ∑ e, R4 R a c b d * R4 R c e d e := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun s _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun t _ => Finset.sum_congr rfl fun c _ => ?_
    rw [hA1 s c c t, hA2 s c t c]
    ring
  have hsplit : ∀ c : ι,
      -(1 / 8) *
        (∑ s, ∑ t, -4 * (R4 R a s b t * R4 R c s c t - R4 R a s c t * R4 R c s b t) +
          ∑ s, ∑ t, -4 * (R4 R b s a t * R4 R c s c t - R4 R b s c t * R4 R c s a t))
      = ∑ s, ∑ t, ((1/2) * (R4 R a s b t * R4 R c s c t) + (1/2) * (R4 R b s a t * R4 R c s c t)
          - (1/2) * (R4 R a s c t * R4 R c s b t) - (1/2) * (R4 R b s c t * R4 R c s a t)) := by
    intro c
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_congr rfl fun s _ => ?_
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_congr rfl fun t _ => ?_
    ring
  rw [Finset.sum_congr rfl fun c _ => hsplit c]
  simp only [Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum]
  rw [P2, Q2, P1]
  conv_rhs => simp only [Finset.mul_sum]
  ring

end step3

/-- **THE `#` HALF, proved.** *`Ric(R#)_ab = ∑ R_{ac,bd} Ric(R)_cd - ∑_c ⟨R φ_ac, R φ_bc⟩` under the four
hypotheses.* Step 1 is `ric_sharpOp_eq_sum`, step 2 is `T_eq` (the quartic trace in four-index form, by
`br_phi_skew` and the ad-invariance `inner2_br_skew`), and step 3 is `quad_bianchi`, the first-Bianchi
identity `∑ R_{as,ct} R_{cs,bt} = ∑_c ⟨R φ_ac, R φ_bc⟩`; `ric_sharpOp_eq'` assembles them. -/
theorem ric_sharpOp_eq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hlin : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0) (a b : ι) :
    Ric (sharpOp R) a b
      = (∑ c, ∑ d, R4 R a c b d * Ric R c d) - ∑ c, inner2 (R (phi a c)) (R (phi b c)) :=
  ric_sharpOp_eq' R hlin hskew hsym hB a b

/-- **LEMMA L209, THE RICCI HALF.** *For `R` linear, bivector-preserving, self-adjoint and
first-Bianchi, `Ric(Q R) = ∑ R_{ac,bd} Ric(R)_cd`.* **It is `ric_Qop_split`, `ric_compOp_eq` and the
`ric_sharpOp_eq`**, all three proved, so L209's Ricci half carries no `sorry`. -/
theorem ric_Qop_eq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hlin : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0) (a b : ι) :
    Ric (Qop R) a b = ∑ c, ∑ d, R4 R a c b d * Ric R c d := by
  rw [ric_Qop_split, ric_compOp_eq R hskew hsym, ric_sharpOp_eq R hlin hskew hsym hB]
  ring

/-- `⟨c • X, Y⟩ = c ⟨X, Y⟩`, spelled out so no other file's lemma of the same name is needed. -/
theorem inner2_smul_left' (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  simp [inner2, Matrix.transpose_smul, Matrix.trace_smul, smul_eq_mul]
  ring

/-- **The left side at `R = id`: `Ric(Q(id)) = (n-1)² δ`.** *`Qop_id_eq` gives `Q(id) = (n-1)·id` on
bivectors, and `Ric_id_eq` gives `Ric(id) = (n-1)δ`.* -/
theorem ric_Qop_id (a b : ι) :
    Ric (Qop (fun Z : Matrix ι ι ℝ => Z)) a b
      = ((Fintype.card ι : ℝ) - 1) ^ 2 * (if a = b then 1 else 0) := by
  have h : ∀ c, inner2 (Qop (fun Z : Matrix ι ι ℝ => Z) (phi a c)) (phi b c)
      = ((Fintype.card ι : ℝ) - 1) * inner2 (phi a c) (phi b c) := by
    intro c
    rw [Qop_id_eq _ (phi_isSkew a c), inner2_smul_left']
  have hR := Ric_id_eq (ι := ι) a b
  simp only [Ric, id_eq] at hR
  simp only [Ric]
  rw [Finset.sum_congr rfl (fun c _ => h c), ← Finset.mul_sum, hR]
  ring

/-- **The right side at `R = id`: `∑ R_{ac,bd} Ric(id)_cd = (n-1)² δ`.** *`Ric(id)_cd = (n-1)δ_cd`
collapses the inner sum to `(n-1) ∑_c ⟨φ_ac, φ_bc⟩ = (n-1) Ric(id)_ab`.* -/
theorem rhs_id (a b : ι) :
    (∑ c, ∑ d, R4 (fun Z : Matrix ι ι ℝ => Z) a c b d * Ric (fun Z : Matrix ι ι ℝ => Z) c d)
      = ((Fintype.card ι : ℝ) - 1) ^ 2 * (if a = b then 1 else 0) := by
  have hR : ∀ c d, Ric (fun Z : Matrix ι ι ℝ => Z) c d
      = ((Fintype.card ι : ℝ) - 1) * (if c = d then 1 else 0) := fun c d => by
    have := Ric_id_eq (ι := ι) c d
    simpa [Ric, id_eq] using this
  have hinner : ∀ c, (∑ d, R4 (fun Z : Matrix ι ι ℝ => Z) a c b d
      * (((Fintype.card ι : ℝ) - 1) * (if c = d then 1 else 0)))
      = ((Fintype.card ι : ℝ) - 1) * inner2 (phi a c) (phi b c) := by
    intro c
    simp [R4, mul_ite, Finset.sum_ite_eq]
    ring
  simp only [hR]
  rw [Finset.sum_congr rfl (fun c _ => hinner c), ← Finset.mul_sum]
  have hab := Ric_id_eq (ι := ι) a b
  simp only [Ric, id_eq] at hab
  rw [hab]
  ring

/-- **The two anchors agree**, so the `+` reading is the one the record's definitions carry. -/
theorem anchors_agree (a b : ι) :
    Ric (Qop (fun Z : Matrix ι ι ℝ => Z)) a b
      = ∑ c, ∑ d, R4 (fun Z : Matrix ι ι ℝ => Z) a c b d * Ric (fun Z : Matrix ι ι ℝ => Z) c d := by
  rw [ric_Qop_id, rhs_id]

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.ric_Qop_id     -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.rhs_id         -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.anchors_agree  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.ric_compOp_eq  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.ric_Qop_split  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.ric_sharpOp_eq_sum  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.br_phi_skew  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.ric_sharpOp_eq  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.T_eq  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.quad_bianchi  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.ric_Qop_eq     -- [propext, Classical.choice, Quot.sound]
