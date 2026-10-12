import Mathlib.Tactic
import HamiltonsCubic.Results.WeylProjection

/-!
# `weylProj` is the orthogonal projection onto `𝒲ₙ`

[WeylProjection.lean](WeylProjection.lean) shows `weylProj R ∈ 𝒲ₙ`; this file shows that what it
removes is orthogonal to `𝒲ₙ`, so it is the orthogonal projection L234's split uses.

## What is typed here

* `innerOp_eq_sum4`: `⟨A, S⟩ = ¼ Σ A_{ijkl} S_{ijkl}` at bivector-preserving `S`.
* `innerOp_knOp_ricciFlat`: `h ⊙ g ⟂ S` for every linear, bivector-preserving, Ricci-flat `S`, by
  moving `knOp` across (`knOp_sym`) so the pairing contracts to `Σ h_ip Ric(S)_ip` and its mirror.
* `innerOp_opOf_bianchi`: an operator whose array is pair-antisymmetric and cyclic in its last three
  indices is orthogonal to every first-Bianchi `S`, by cyclic relabelling (`sum3_cycle`).
* `weylProj_orth`: **for linear self-adjoint `R` and every `S` in the record's `𝒲ₙ`,
  `⟨R − weylProj R, S⟩ = 0`.** With `weylProj_isWeylOp` this is the orthogonal projection.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.Results

open Finset RealLayer FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`⟨A, S⟩ = ¼ Σ A_{ijkl} S_{ijkl}`** at bivector-preserving `S`. -/
theorem innerOp_eq_sum4 (A S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hS : ∀ X, IsSkew X → IsSkew (S X)) :
    innerOp A S = (1/4) * ∑ i, ∑ j, ∑ k, ∑ l, R4 A i j k l * R4 S i j k l := by
  unfold innerOp
  rw [Finset.mul_sum]
  have h : ∀ i j, inner2 (A (phi i j)) (S (phi i j))
      = (1/2) * ∑ k, ∑ l, R4 A i j k l * R4 S i j k l := by
    intro i j
    conv_lhs => rw [← skew_expand (S (phi i j)) (hS _ (phi_isSkew i j))]
    rw [FamilyLayer.inner2_smul_right, inner2_sum_right]
    congr 1
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [inner2_sum_right]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [FamilyLayer.inner2_smul_right]; unfold R4; ring
  simp only [h, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  ring

/-- **The Kulkarni–Nomizu part is orthogonal to every Ricci-flat `S`.** -/
theorem innerOp_knOp_ricciFlat (h : Matrix ι ι ℝ) (hh : h.transpose = h)
    (S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hlin : IsLinOp S) (hS : ∀ X, IsSkew X → IsSkew (S X))
    (hRic : ∀ a b, Ric S a b = 0) : innerOp (knOp h) S = 0 := by
  have hneg : ∀ Z : Matrix ι ι ℝ, S (-Z) = - S Z := fun Z => by
    have := hlin.2 (-1) Z; simpa using this
  have hA1 : ∀ i j k l, R4 S j i k l = - R4 S i j k l := by
    intro i j k l; unfold R4; rw [phi_swap i j, hneg, inner2_neg_left'']
  have hA2 : ∀ i j k l, R4 S i j l k = - R4 S i j k l := by
    intro i j k l; unfold R4; rw [phi_swap k l, inner2_neg_right'']
  have hent : ∀ i j p q, (S (phi i j)) p q = - R4 S i j p q := by
    intro i j p q; unfold R4; rw [inner2_phi _ (hS _ (phi_isSkew i j))]; ring
  have hterm : ∀ i j, inner2 (knOp h (phi i j)) (S (phi i j))
      = ∑ p, (h i p * R4 S i j p j + R4 S i j i p * h p j) := by
    intro i j
    rw [knOp_sym h hh, inner2_comm, inner2_phi _ (knOp_isSkew h hh _ (hS _ (phi_isSkew i j)))]
    simp only [knOp, Matrix.add_apply, Matrix.mul_apply, hent, ← Finset.sum_add_distrib,
      ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun p _ => ?_
    ring
  unfold innerOp
  simp only [hterm, Finset.sum_add_distrib]
  have t1 : ∑ i, ∑ j, ∑ p, h i p * R4 S i j p j = 0 := by
    have : ∀ i, ∑ j, ∑ p, h i p * R4 S i j p j = ∑ p, h i p * Ric S i p := by
      intro i; rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun p _ => ?_
      rw [← Finset.mul_sum]; rfl
    simp only [this, hRic, mul_zero, Finset.sum_const_zero]
  have t2 : ∑ i, ∑ j, ∑ p, R4 S i j i p * h p j = 0 := by
    rw [Finset.sum_comm]
    have : ∀ j, ∑ i, ∑ p, R4 S i j i p * h p j = ∑ p, Ric S j p * h p j := by
      intro j; rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun p _ => ?_
      rw [← Finset.sum_mul]
      congr 1
      unfold Ric
      refine Finset.sum_congr rfl fun i _ => ?_
      have e1 := hA1 i j i p; have e2 := hA2 j i p i
      unfold R4 at e1 e2 ⊢
      linarith
    simp only [this, hRic, zero_mul, Finset.sum_const_zero]
  rw [t1, t2]; ring

omit [DecidableEq ι] in
theorem sum3_cycle (G : ι → ι → ι → ℝ) : ∑ j, ∑ k, ∑ l, G k l j = ∑ j, ∑ k, ∑ l, G j k l := by
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_comm

/-- **The `Λ⁴` part is orthogonal to every first-Bianchi `S`**, `C` being antisymmetric in each
pair and cyclic in its last three indices. -/
theorem innerOp_opOf_bianchi (C : ι → ι → ι → ι → ℝ)
    (hA1 : ∀ i j k l, C j i k l = - C i j k l) (hA2 : ∀ i j k l, C i j l k = - C i j k l)
    (hcyc : ∀ i j k l, C i j k l = C i k l j)
    (S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hS : ∀ X, IsSkew X → IsSkew (S X))
    (hB : ∀ i j k l, bianchi S i j k l = 0) : innerOp (opOf C) S = 0 := by
  rw [innerOp_eq_sum4 _ _ hS]
  simp only [comp_opOf C hA1 hA2]
  have r1 : ∀ i, ∑ j, ∑ k, ∑ l, C i j k l * R4 S i k l j = ∑ j, ∑ k, ∑ l, C i j k l * R4 S i j k l := by
    intro i
    rw [show (∑ j, ∑ k, ∑ l, C i j k l * R4 S i k l j) = ∑ j, ∑ k, ∑ l, C i k l j * R4 S i k l j from
      Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
        rw [hcyc i j k l]]
    exact sum3_cycle (fun a b c => C i a b c * R4 S i a b c)
  have r2 : ∀ i, ∑ j, ∑ k, ∑ l, C i j k l * R4 S i l j k = ∑ j, ∑ k, ∑ l, C i j k l * R4 S i j k l := by
    intro i
    rw [show (∑ j, ∑ k, ∑ l, C i j k l * R4 S i l j k) = ∑ j, ∑ k, ∑ l, C i l j k * R4 S i l j k from
      Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
        rw [hcyc i j k l, hcyc i k l j]]
    exact (sum3_cycle (fun a b c => C i c a b * R4 S i c a b)).symm
  have hsum : ∀ i, ∑ j, ∑ k, ∑ l, C i j k l * (R4 S i j k l + R4 S i k l j + R4 S i l j k) = 0 := by
    intro i
    refine Finset.sum_eq_zero fun j _ => Finset.sum_eq_zero fun k _ => Finset.sum_eq_zero fun l _ => ?_
    have := hB i j k l; unfold bianchi at this; unfold R4; rw [this, mul_zero]
  have h3 : ∀ i, 3 * ∑ j, ∑ k, ∑ l, C i j k l * R4 S i j k l = 0 := by
    intro i
    have := hsum i
    simp only [mul_add, Finset.sum_add_distrib, r1, r2] at this
    linarith
  have : ∀ i, ∑ j, ∑ k, ∑ l, C i j k l * R4 S i j k l = 0 := fun i => by linarith [h3 i]
  simp only [this, Finset.sum_const_zero, mul_zero]

theorem innerOp_add_left (A B S : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    innerOp (fun X => A X + B X) S = innerOp A S + innerOp B S := by
  unfold innerOp
  simp only [FamilyLayer.inner2_add_left, Finset.sum_add_distrib, mul_add]

open HamiltonsCubic.AltLayer in
/-- **`weylProj` IS THE ORTHOGONAL PROJECTION**: what it removes is orthogonal to all of `𝒲ₙ`. -/
theorem weylProj_orth (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hWS : IsWeylOp S) :
    innerOp (fun X => R X - weylProj R X) S = 0 := by
  obtain ⟨hSl, hSs, hSy, hSb, hSr⟩ := hWS
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hA1 := altCoeff_antisym_first R hneg hsym
  have hmid := altCoeff_antisym_mid R
  have hcyc : ∀ a b c d, altCoeff R a b c d = altCoeff R a c d b := fun a b c d => by
    unfold altCoeff alt4; ring
  have hA2 : ∀ a b c d, altCoeff R a b d c = - altCoeff R a b c d := fun a b c d => by
    linarith [hcyc a b d c, hmid a c d b, hcyc a b c d]
  have hP : ∀ a b c d, altCoeff R c d a b = altCoeff R a b c d := fun a b c d => by
    linarith [hcyc c d a b, hA1 a c b d, hmid a b c d]
  have hsym' : ∀ X Y, IsSkew X → IsSkew Y →
      inner2 ((fun Z => R Z - opOf (altCoeff R) Z) X) Y = inner2 X ((fun Z => R Z - opOf (altCoeff R) Z) Y) := by
    intro X Y hX hY
    show inner2 (R X - opOf (altCoeff R) X) Y = inner2 X (R Y - opOf (altCoeff R) Y)
    rw [inner2_sub_left', inner2_sub_right', hsym X Y hX hY, opOf_sym (altCoeff R) hP]
  have hh := knCorr_transpose (fun Z => R Z - opOf (altCoeff R) Z) hsym'
  have e : (fun X => R X - weylProj R X)
      = fun X => opOf (altCoeff R) X + knOp (knCorr (fun Z => R Z - opOf (altCoeff R) Z)) X := by
    funext X; unfold weylProj weylOfBianchi; rw [sub_sub, sub_sub_cancel]
  rw [e, innerOp_add_left, innerOp_opOf_bianchi (altCoeff R) hA1 hA2 hcyc S hSs hSb,
    innerOp_knOp_ricciFlat _ hh S hSl hSs hSr]
  ring

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.innerOp_knOp_ricciFlat  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.innerOp_opOf_bianchi    -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.weylProj_orth           -- [propext, Classical.choice, Quot.sound]
