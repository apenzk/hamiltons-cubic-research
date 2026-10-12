import Mathlib
import HamiltonsCubic.Results.L131Four
import HamiltonsCubic.Results.L131Whole
import HamiltonsCubic.Results.L131Lin
import HamiltonsCubic.Results.FoxBridge

set_option linter.style.longLine false

/-!
# L131: the four-set elements span `Λ⁴`

[findings/isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L131, and
[L131Four.lean](L131Four.lean)'s header: *"the elements `v = lam4 i j k l` over `i < j < k < l` are the
standard basis of `Λ⁴`"*, which the row owes as a declaration. Here `Λ⁴` is read as the curvature
operators whose coefficient tensor `C_{abcd} = ⟨R φ_ab, φ_cd⟩` is **totally antisymmetric** (the
complement of the Bianchi cut), and:

* `lam4_span`: every linear `R` preserving bivectors with `C` totally antisymmetric is
  `(1/24) Σ_{ijkl} C_{ijkl} · lam4 i j k l` on bivectors, so the `lam4` span `Λ⁴`;
  the `1/24` is the `4!` orderings of each four-set, each `lam4` being alternating in its indices.
* `alt_zero`, `sum_dist`, `sharpCross_lam4_all`: `R # I = 2R` on bivectors for every such `R`, L131's
  fourth entry on the whole `Λ⁴` summand, the repeated-index terms vanishing.
-/

namespace HamiltonsCubic.L131Lam4

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block
  HamiltonsCubic.L131Diag

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Two bivectors with the same pairings against every `φ_cd` are equal. -/
theorem eq_of_pairings {Y Y' : Matrix ι ι ℝ} (hY : IsSkew Y) (hY' : IsSkew Y')
    (h : ∀ c d, inner2 Y (phi c d) = inner2 Y' (phi c d)) : Y = Y' := by
  rw [HamiltonsCubic.L41Statement.Frame.phi_expand Y hY,
    HamiltonsCubic.L41Statement.Frame.phi_expand Y' hY']
  simp only [h]

theorem inner2_rk2_phi (U V : Matrix ι ι ℝ) (a b c d : ι) :
    inner2 (rk2 U V (phi a b)) (phi c d)
      = inner2 V (phi a b) * inner2 U (phi c d) + inner2 U (phi a b) * inner2 V (phi c d) := by
  unfold rk2
  rw [FamilyLayer.inner2_add_left, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_left]

/-- **`Λ⁴` is spanned by the four-set elements.** -/
theorem lam4_span (R : CurvOp ι) (hR : IsLinOp R) (hsk : ∀ X, IsSkew X → IsSkew (R X))
    (hA1 : ∀ a b c d, inner2 (R (phi b a)) (phi c d) = -inner2 (R (phi a b)) (phi c d))
    (hA2 : ∀ a b c d, inner2 (R (phi a b)) (phi d c) = -inner2 (R (phi a b)) (phi c d))
    (hA3 : ∀ a b c d, inner2 (R (phi a c)) (phi b d) = -inner2 (R (phi a b)) (phi c d))
    {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    R X = (1 / 24 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l,
      inner2 (R (phi i j)) (phi k l) • lam4 i j k l X := by
  set C : ι → ι → ι → ι → ℝ := fun a b c d => inner2 (R (phi a b)) (phi c d) with hC
  have hF : IsLinOp (fun Y => (1 / 24 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, C i j k l • lam4 i j k l Y) := by
    refine ⟨fun Y Z => ?_, fun r Y => ?_⟩
    · simp only [(lam4_lin _ _ _ _).1, smul_add, Finset.sum_add_distrib]
    · simp only [(lam4_lin _ _ _ _).2, smul_comm (C _ _ _ _) r, ← Finset.smul_sum,
        smul_comm (1 / 24 : ℝ) r]
  show R X = (fun Y => (1 / 24 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, C i j k l • lam4 i j k l Y) X
  refine eq_on_skew_of_phi hR hF (fun a b => ?_) hX
  have hskF : IsSkew ((1 / 24 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, C i j k l • lam4 i j k l (phi a b)) := by
    have h : ∀ i j k l, (C i j k l • lam4 i j k l (phi a b))ᵀ = -(C i j k l • lam4 i j k l (phi a b)) :=
      fun i j k l => by rw [Matrix.transpose_smul, lam4_skew i j k l _, smul_neg]
    unfold IsSkew
    simp only [Matrix.transpose_smul, Matrix.transpose_sum, h, Finset.sum_neg_distrib, smul_neg]
  refine eq_of_pairings (hsk _ (phi_isSkew a b)) hskF fun c d => ?_
  simp only [FamilyLayer.inner2_smul_left, HamiltonsCubic.Results.inner2_sumL]
  simp only [lam4, FamilyLayer.inner2_add_left, inner2_rk2_phi, inner2_phi_phi]
  simp only [mul_sub, mul_add, mul_ite, mul_one, mul_zero,
    Finset.sum_add_distrib, Finset.sum_sub_distrib, ite_and, Finset.sum_ite_eq',
    Finset.mem_univ, if_true, Finset.sum_const_zero, Finset.sum_ite_irrel]
  show C a b c d = _
  linarith [hA1 a b c d, hA2 a b c d, hA3 a b c d, hA1 a b d c, hA2 a b d c, hA3 a b d c, hA1 a c b d, hA2 a c b d, hA3 a c b d, hA1 a c d b, hA2 a c d b, hA3 a c d b, hA1 a d b c, hA2 a d b c, hA3 a d b c, hA1 a d c b, hA2 a d c b, hA3 a d c b, hA1 b a c d, hA2 b a c d, hA3 b a c d, hA1 b a d c, hA2 b a d c, hA3 b a d c, hA1 b c a d, hA2 b c a d, hA3 b c a d, hA1 b c d a, hA2 b c d a, hA3 b c d a, hA1 b d a c, hA2 b d a c, hA3 b d a c, hA1 b d c a, hA2 b d c a, hA3 b d c a, hA1 c a b d, hA2 c a b d, hA3 c a b d, hA1 c a d b, hA2 c a d b, hA3 c a d b, hA1 c b a d, hA2 c b a d, hA3 c b a d, hA1 c b d a, hA2 c b d a, hA3 c b d a, hA1 c d a b, hA2 c d a b, hA3 c d a b, hA1 c d b a, hA2 c d b a, hA3 c d b a, hA1 d a b c, hA2 d a b c, hA3 d a b c, hA1 d a c b, hA2 d a c b, hA3 d a c b, hA1 d b a c, hA2 d b a c, hA3 d b a c, hA1 d b c a, hA2 d b c a, hA3 d b c a, hA1 d c a b, hA2 d c a b, hA3 d c a b, hA1 d c b a, hA2 d c b a, hA3 d c b a]

omit [Fintype ι] [DecidableEq ι] in
/-- **An alternating coefficient tensor vanishes at a repeated index.** -/
theorem alt_zero (C : ι → ι → ι → ι → ℝ)
    (hA1 : ∀ a b c d, C b a c d = -C a b c d) (hA2 : ∀ a b c d, C a b d c = -C a b c d)
    (hA3 : ∀ a b c d, C a c b d = -C a b c d) (a b c d : ι)
    (h : a = b ∨ a = c ∨ a = d ∨ b = c ∨ b = d ∨ c = d) : C a b c d = 0 := by
  have hab : ∀ x y z, C x x y z = 0 := fun x y z => by linarith [hA1 x x y z]
  have hcd : ∀ x y z, C x y z z = 0 := fun x y z => by linarith [hA2 x y z z]
  have hbc : ∀ x y z, C x y y z = 0 := fun x y z => by linarith [hA3 x y y z]
  rcases h with rfl | rfl | rfl | rfl | rfl | rfl
  · exact hab a c d
  · linarith [hA3 a a b d, hab a b d]
  · linarith [hA2 a b a c, hA3 a a b c, hab a b c]
  · exact hbc a b d
  · linarith [hA2 a b b c, hbc a b c]
  · exact hcd a b c

/-- Distinct quadruples, the index set of `sharpCross_lam4_span`. -/
def Dist (ι : Type*) := {t : ι × ι × ι × ι // t.1 ≠ t.2.1 ∧ t.1 ≠ t.2.2.1 ∧ t.1 ≠ t.2.2.2 ∧
  t.2.1 ≠ t.2.2.1 ∧ t.2.1 ≠ t.2.2.2 ∧ t.2.2.1 ≠ t.2.2.2}

instance : Fintype (Dist ι) := by unfold Dist; infer_instance

/-- **The span over every quadruple is the span over distinct ones**, the repeated-index
coefficients vanishing. -/
theorem sum_dist (C : ι → ι → ι → ι → ℝ)
    (hA1 : ∀ a b c d, C b a c d = -C a b c d) (hA2 : ∀ a b c d, C a b d c = -C a b c d)
    (hA3 : ∀ a b c d, C a c b d = -C a b c d) (W : Matrix ι ι ℝ) :
    (1 / 24 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, C i j k l • lam4 i j k l W
      = ∑ t : Dist ι, (C t.1.1 t.1.2.1 t.1.2.2.1 t.1.2.2.2 / 24) •
          lam4 t.1.1 t.1.2.1 t.1.2.2.1 t.1.2.2.2 W := by
  set f : ι × ι × ι × ι → Matrix ι ι ℝ := fun t =>
    (C t.1 t.2.1 t.2.2.1 t.2.2.2 / 24) • lam4 t.1 t.2.1 t.2.2.1 t.2.2.2 W with hf
  have h4 : (1 / 24 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, C i j k l • lam4 i j k l W = ∑ t, f t := by
    simp only [hf, Fintype.sum_prod_type, Finset.smul_sum, smul_smul]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
      Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    congr 1; ring
  rw [h4]
  have hz : ∀ t, ¬(t.1 ≠ t.2.1 ∧ t.1 ≠ t.2.2.1 ∧ t.1 ≠ t.2.2.2 ∧ t.2.1 ≠ t.2.2.1 ∧
      t.2.1 ≠ t.2.2.2 ∧ t.2.2.1 ≠ t.2.2.2) → f t = 0 := by
    intro t ht
    have hrep : t.1 = t.2.1 ∨ t.1 = t.2.2.1 ∨ t.1 = t.2.2.2 ∨ t.2.1 = t.2.2.1 ∨
        t.2.1 = t.2.2.2 ∨ t.2.2.1 = t.2.2.2 := by tauto
    simp only [hf, alt_zero C hA1 hA2 hA3 _ _ _ _ hrep, zero_div, zero_smul]
  rw [← Finset.sum_filter_of_ne (p := fun t => t.1 ≠ t.2.1 ∧ t.1 ≠ t.2.2.1 ∧ t.1 ≠ t.2.2.2 ∧
      t.2.1 ≠ t.2.2.1 ∧ t.2.1 ≠ t.2.2.2 ∧ t.2.2.1 ≠ t.2.2.2) (fun t _ hne => by
        by_contra hp; exact hne (hz t hp))]
  exact Finset.sum_subtype _ (fun t => by simp) f

/-- **L131's fourth entry on all of `Λ⁴`**: every linear `R` preserving bivectors with totally
antisymmetric coefficients has `R # I = 2R` on bivectors ([r1698](../../../reviews/REVIEW_r1698.md) O3). -/
theorem sharpCross_lam4_all (R : CurvOp ι) (hR : IsLinOp R) (hsk : ∀ X, IsSkew X → IsSkew (R X))
    (hA1 : ∀ a b c d, inner2 (R (phi b a)) (phi c d) = -inner2 (R (phi a b)) (phi c d))
    (hA2 : ∀ a b c d, inner2 (R (phi a b)) (phi d c) = -inner2 (R (phi a b)) (phi c d))
    (hA3 : ∀ a b c d, inner2 (R (phi a c)) (phi b d) = -inner2 (R (phi a b)) (phi c d))
    {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    sharpCross R (fun X => X) Z = (2 : ℝ) • R Z := by
  set C : ι → ι → ι → ι → ℝ := fun a b c d => inner2 (R (phi a b)) (phi c d) with hC
  set G : CurvOp ι := fun W => ∑ t : Dist ι, (C t.1.1 t.1.2.1 t.1.2.2.1 t.1.2.2.2 / 24) •
    lam4 t.1.1 t.1.2.1 t.1.2.2.1 t.1.2.2.2 W with hG
  have hRG : ∀ X, IsSkew X → R X = G X := fun X hX => by
    rw [lam4_span R hR hsk hA1 hA2 hA3 hX, hG]
    exact sum_dist C hA1 hA2 hA3 X
  set I : CurvOp ι := fun X => X with hI
  have hsum : ∀ X, IsSkew X → (R + I) X = (G + I) X := fun X hX => by
    simp only [Pi.add_apply, hRG X hX]
  have hskS : ∀ X, IsSkew X → IsSkew ((R + I) X) := fun X hX => by
    simp only [Pi.add_apply, hI]
    unfold IsSkew at *
    rw [Matrix.transpose_add, hsk X hX, hX, neg_add]
  have hc : sharpCross R I Z = sharpCross G I Z := by
    unfold sharpCross
    rw [HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew hskS hsum Z hZ,
      HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew hsk hRG Z hZ]
  rw [hc, hRG Z hZ]
  exact sharpCross_lam4_span Finset.univ (fun t : Dist ι => C t.1.1 t.1.2.1 t.1.2.2.1 t.1.2.2.2 / 24)
    (fun t => t.1.1) (fun t => t.1.2.1) (fun t => t.1.2.2.1) (fun t => t.1.2.2.2) (fun t => t.2) hZ

end HamiltonsCubic.L131Lam4
