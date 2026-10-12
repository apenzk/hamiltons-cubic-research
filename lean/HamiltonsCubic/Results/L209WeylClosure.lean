import Mathlib.Tactic
import HamiltonsCubic.Results.L209BianchiHalf

/-!
# Lemma L209, the closure: `Q(𝒲ₙ) ⊆ 𝒲ₙ` and `X, Y ∈ 𝒲ₙ ⇒ X ∘ Y ∈ 𝒲ₙ`

[findings/curvature-invariants.md](../../../findings/curvature-invariants.md), the L209 block.

**The statement, quoted from the record**: "$Q(R)=R^2+R^\#$ carries $S^2_B(\mathfrak{so}(n))$ into
itself [...] so $Q(\mathcal W_n)\subseteq\mathcal W_n$ and, by polarisation,
$X,Y\in\mathcal W_n\Rightarrow X\circ Y\in\mathcal W_n$."

## What is typed here

* `sharpBil_add_right`, `sharpBil_smul_right`, `sharpBil_sum_right` and `sharpBil_comm`: the
  polarised `#` is bilinear and symmetric at linear `R`, read off `sharpBil_expand`.
* `inner2_sharpOp`: `⟨R# X, Y⟩ = sharpBil R X Y` at skew `Y`, so `sharpOp` is self-adjoint on
  bivectors; `sharpOp_isSkew` and `sharpOp_isLinOp` give the rest of `S²_B` membership.
* `Qop_isWeylOp`: **`Q(𝒲ₙ) ⊆ 𝒲ₙ`**, over the record's `IsWeylOp` (linear plus WeylReal's four
  clauses), from the two halves `bianchi_Qop` and `ric_Qop_flat`.
* `isWeylOp_add`, `isWeylOp_smul` and `foxProd_isWeylOp`: **the polarised closure**, on FoxProduct's
  `foxProd`, the record's `X ∘ Y = ½(Q(X+Y) − Q(X) − Q(Y))`.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.Results

open Finset RealLayer FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem isSkew_sum' {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ)
    (h : ∀ k ∈ s, IsSkew (f k)) : IsSkew (∑ k ∈ s, f k) := by
  simp only [IsSkew] at h ⊢
  rw [Matrix.transpose_sum, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl h

section sharpLin
variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
include hR

theorem sharpBil_add_right (X Y₁ Y₂ : Matrix ι ι ℝ) :
    sharpBil R X (Y₁ + Y₂) = sharpBil R X Y₁ + sharpBil R X Y₂ := by
  simp only [sharpBil_expand R hR, br_add_left, br_add_right, hR.1,
    FamilyLayer.inner2_add_left, Finset.sum_add_distrib]
  ring

theorem sharpBil_smul_right (c : ℝ) (X Y : Matrix ι ι ℝ) :
    sharpBil R X (c • Y) = c * sharpBil R X Y := by
  simp only [sharpBil_expand R hR, br_smul_left, br_smul_right, hR.2,
    FamilyLayer.inner2_smul_left, ← mul_add, ← Finset.mul_sum]
  ring

theorem sharpBil_zero_right (X : Matrix ι ι ℝ) : sharpBil R X 0 = 0 := by
  have := sharpBil_smul_right R hR 0 X 0
  simpa using this

theorem sharpBil_sum_right {κ : Type*} (s : Finset κ) (X : Matrix ι ι ℝ) (f : κ → Matrix ι ι ℝ) :
    sharpBil R X (∑ k ∈ s, f k) = ∑ k ∈ s, sharpBil R X (f k) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [sharpBil_zero_right R hR]
  | insert a s ha ih =>
    rw [Finset.sum_insert ha, Finset.sum_insert ha, sharpBil_add_right R hR, ih]

theorem sharpBil_comm (X Y : Matrix ι ι ℝ) : sharpBil R X Y = sharpBil R Y X := by
  rw [sharpBil_expand R hR, sharpBil_expand R hR]
  congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => add_comm _ _

/-- **`⟨R# X, Y⟩ = sharpBil R X Y` at skew `Y`**, the operator reassembled by `sharpOp` pairing back
to its polarised form. -/
theorem inner2_sharpOp (X Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    inner2 (sharpOp R X) Y = sharpBil R X Y := by
  unfold sharpOp
  conv_rhs => rw [← skew_expand Y hY]
  rw [sharpBil_smul_right R hR, sharpBil_sum_right R hR, FamilyLayer.inner2_smul_left,
    inner2_sum_left']
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [sharpBil_sum_right R hR, inner2_sum_left']
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [sharpBil_smul_right R hR, FamilyLayer.inner2_smul_left, inner2_comm (phi i j)]
  ring

omit hR in
theorem sharpOp_isSkew (X : Matrix ι ι ℝ) : IsSkew (sharpOp R X) := by
  unfold sharpOp
  exact isSkew_smul _ (isSkew_sum' _ _ fun i _ => isSkew_sum' _ _ fun j _ =>
    isSkew_smul _ (phi_isSkew i j))

theorem sharpOp_isLinOp : IsLinOp (sharpOp R) := by
  constructor
  · intro X Y
    unfold sharpOp
    simp only [sharpBil_comm R hR _ (phi _ _), sharpBil_add_right R hR, add_smul,
      Finset.sum_add_distrib, smul_add]
  · intro c X
    unfold sharpOp
    simp only [sharpBil_comm R hR _ (phi _ _), sharpBil_smul_right R hR, mul_smul,
      Finset.smul_sum]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    module

end sharpLin

/-- **LEMMA L209, THE CLOSURE ITSELF**: `Q` carries the record's `𝒲ₙ` into itself. -/
theorem Qop_isWeylOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (h : IsWeylOp R) : IsWeylOp (Qop R) := by
  obtain ⟨hR, hskew, hsym, hB, hRic⟩ := h
  have hlin : IsLinOp (Qop R) := by
    have hs := sharpOp_isLinOp R hR
    constructor
    · intro X Y; unfold Qop compOp; rw [hR.1, hR.1, hs.1]; abel
    · intro c X; unfold Qop compOp; rw [hR.2, hR.2, hs.2, smul_add]
  refine ⟨hlin, ?_, ?_, bianchi_Qop R hR hskew hsym hB, ric_Qop_flat R hR hskew hsym hB hRic⟩
  · intro X hX
    unfold Qop compOp
    exact isSkew_add (hskew _ (hskew _ hX)) (sharpOp_isSkew R X)
  · intro X Y hX hY
    unfold Qop compOp
    rw [FamilyLayer.inner2_add_left, inner2_add_right, inner2_sharpOp R hR X Y hY,
      hsym _ _ (hskew _ hX) hY, hsym _ _ hX (hskew _ hY), inner2_comm X (sharpOp R Y),
      inner2_sharpOp R hR Y X hX, sharpBil_comm R hR]


theorem isWeylOp_add (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsWeylOp A) (hB : IsWeylOp B) :
    IsWeylOp (A + B) := by
  obtain ⟨⟨hA1, hA2⟩, hAs, hAy, hAb, hAr⟩ := hA
  obtain ⟨⟨hB1, hB2⟩, hBs, hBy, hBb, hBr⟩ := hB
  refine ⟨⟨fun X Y => ?_, fun c X => ?_⟩, fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_,
    fun a b => ?_⟩
  · simp only [Pi.add_apply, hA1, hB1]; abel
  · simp only [Pi.add_apply, hA2, hB2, smul_add]
  · exact isSkew_add (hAs X hX) (hBs X hX)
  · simp only [Pi.add_apply, FamilyLayer.inner2_add_left, inner2_add_right, hAy X Y hX hY,
      hBy X Y hX hY]
  · have h1 := hAb i j k l; have h2 := hBb i j k l
    unfold bianchi at *
    simp only [Pi.add_apply, FamilyLayer.inner2_add_left]
    linarith
  · have h1 := hAr a b; have h2 := hBr a b
    unfold Ric at *
    simp only [Pi.add_apply, FamilyLayer.inner2_add_left, Finset.sum_add_distrib, h1, h2, add_zero]

theorem isWeylOp_smul (c : ℝ) (A : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsWeylOp A) :
    IsWeylOp (c • A) := by
  obtain ⟨⟨hA1, hA2⟩, hAs, hAy, hAb, hAr⟩ := hA
  refine ⟨⟨fun X Y => ?_, fun d X => ?_⟩, fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_,
    fun a b => ?_⟩
  · simp only [Pi.smul_apply, hA1, smul_add]
  · simp only [Pi.smul_apply, hA2, smul_comm c d]
  · exact isSkew_smul c (hAs X hX)
  · simp only [Pi.smul_apply, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right,
      hAy X Y hX hY]
  · have h1 := hAb i j k l
    unfold bianchi at *
    simp only [Pi.smul_apply, FamilyLayer.inner2_smul_left]
    rw [← mul_add, ← mul_add, h1, mul_zero]
  · have h1 := hAr a b
    unfold Ric at *
    simp only [Pi.smul_apply, FamilyLayer.inner2_smul_left, ← Finset.mul_sum, h1, mul_zero]

/-- **LEMMA L209'S POLARISED FORM**: `X, Y ∈ 𝒲ₙ ⇒ X ∘ Y ∈ 𝒲ₙ`, the product the second-order
apparatus uses. -/
theorem foxProd_isWeylOp (X Y : Matrix ι ι ℝ → Matrix ι ι ℝ) (hX : IsWeylOp X) (hY : IsWeylOp Y) :
    IsWeylOp (foxProd X Y) := by
  have hsum := Qop_isWeylOp _ (isWeylOp_add X Y hX hY)
  have hQX := Qop_isWeylOp _ hX
  have hQY := Qop_isWeylOp _ hY
  have e : foxProd X Y = (1/2 : ℝ) • (Qop (X + Y) + ((-1 : ℝ) • Qop X + (-1 : ℝ) • Qop Y)) := by
    funext Z
    simp only [foxProd, Pi.smul_apply, Pi.add_apply]
    module
  rw [e]
  exact isWeylOp_smul _ _ (isWeylOp_add _ _ hsum
    (isWeylOp_add _ _ (isWeylOp_smul _ _ hQX) (isWeylOp_smul _ _ hQY)))

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.inner2_sharpOp     -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.Qop_isWeylOp       -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.foxProd_isWeylOp   -- [propext, Classical.choice, Quot.sound]
