import Mathlib.Tactic
import HamiltonsCubic.Results.L209FoxClosure

/-!
# Lemma L209, the Bianchi half: the Fox square preserves first Bianchi

[findings/curvature-invariants.md](../../../findings/curvature-invariants.md), the L209 block, Steps 2 and 3.

**The statement, quoted from the record**: "Cyclically summing $Q(R)_{ij,kl}$ over $(j,k,l)$ produces
twelve $B$ terms that cancel in pairs identically, by relabelling alone with no symmetry of $B$
used, so $b(Q(R))=0$ for every $R\in S^2_B$."

## What is typed here

* `B4` is the block's `B_{ijkl} = ∑_{p,q} R_{ip,kq} R_{jp,lq}` on the record's `R4`.
* `sharpBil_phi_B` is Step 2's `#` half, `(R#)_{ij,kl} = B_{ijkl} - B_{ijlk}`, spending linearity,
  bivector preservation and self-adjointness only, through `T_eq4`, the quartic trace of
  `sharpBil_expand` with four free indices. `R4_sharpOp` reads `sharpOp` in four indices.
* `R4_compOp_B` is Step 2's `R²` half, `(R²)_{ij,kl} = B_{ikjl} - B_{iljk}`, by first Bianchi twice.
* `bianchi_Qop` is **the Bianchi half, proved**: the three `hQ` rewrites leave twelve `B4` atoms and
  `ring` cancels them, which is the block's "by relabelling alone".
* `ric_Qop_flat` joins it to the Ricci half: a Ricci-flat `R` has Ricci-flat `Q(R)`.
* **Not typed**: `IsWeyl (Qop R)` as one proposition, which also owes self-adjointness of `Qop R`
  on bivectors, and the polarisation to `X ∘ Y ∈ 𝒲ₙ`.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.Results

open Finset RealLayer FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The four-index tensor `B_{ijkl} = ∑_{p,q} R_{ip,kq} R_{jp,lq}`** of the L209 block, Step 2. -/
noncomputable def B4 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) : ℝ :=
  ∑ p, ∑ q, R4 R i p k q * R4 R j p l q

theorem G_eq4 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (y d i j p s : ι) :
    inner2 (br (phi y d) (R (phi i j))) (R (phi p s))
      = ∑ t, (R4 R i j y t * R4 R p s d t - R4 R i j d t * R4 R p s y t) := by
  rw [br_phi_skew y d _ (hskew _ (phi_isSkew i j)), inner2_sub_left', inner2_sum_left',
    inner2_sum_left', ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun t _ => ?_
  rw [FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_left, inner2_comm (phi d t),
    inner2_comm (phi y t)]
  rfl

theorem term_eq4 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (x c y d i j : ι) :
    inner2 (br (phi x c) (R (br (phi y d) (R (phi i j))))) (phi i j)
      = -((∑ s, inner2 (phi i j) (phi x s) * inner2 (br (phi y d) (R (phi i j))) (R (phi c s)))
          - ∑ s, inner2 (phi i j) (phi c s) * inner2 (br (phi y d) (R (phi i j))) (R (phi x s))) := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hsub : ∀ A B : Matrix ι ι ℝ, R (A - B) = R A - R B := fun A B => by
    rw [sub_eq_add_neg, hR.1, hneg, sub_eq_add_neg]
  have hW : IsSkew (br (phi y d) (R (phi i j))) :=
    br_isSkew_real _ _ (phi_isSkew y d) (hskew _ (phi_isSkew i j))
  rw [inner2_br_skew _ _ _ (phi_isSkew x c),
    hsym _ _ hW (br_isSkew_real _ _ (phi_isSkew x c) (phi_isSkew i j)),
    br_phi_skew x c _ (phi_isSkew i j), hsub, linOp_sum R hR, linOp_sum R hR,
    inner2_sub_right', inner2_sum_right, inner2_sum_right]
  simp only [hR.2, FamilyLayer.inner2_smul_right]

/-- **The quartic trace with four free indices**, `T_eq` with the shared index released. -/
theorem T_eq4 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (x c y d : ι) :
    ∑ i, ∑ j, inner2 (br (phi x c) (R (br (phi y d) (R (phi i j))))) (phi i j)
      = -4 * ∑ s, ∑ t, (R4 R x s y t * R4 R c s d t - R4 R x s d t * R4 R c s y t) := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hR4a : ∀ i j k l, R4 R j i k l = - R4 R i j k l := by
    intro i j k l; unfold R4; rw [phi_swap, hneg, inner2_neg_left'']
  simp only [term_eq4 R hR hskew hsym x c y d, Finset.sum_neg_distrib, Finset.sum_sub_distrib]
  have c1 := phi_collapse x (fun i j s => inner2 (br (phi y d) (R (phi i j))) (R (phi c s)))
  have c2 := phi_collapse c (fun i j s => inner2 (br (phi y d) (R (phi i j))) (R (phi x s)))
  try simp only at c1 c2
  rw [c1, c2]
  have key : ∀ s,
      (inner2 (br (phi y d) (R (phi x s))) (R (phi c s))
        - inner2 (br (phi y d) (R (phi s x))) (R (phi c s)))
      - (inner2 (br (phi y d) (R (phi c s))) (R (phi x s))
        - inner2 (br (phi y d) (R (phi s c))) (R (phi x s)))
      = 4 * ∑ t, (R4 R x s y t * R4 R c s d t - R4 R x s d t * R4 R c s y t) := by
    intro s
    simp only [G_eq4 R hskew y d]
    simp only [← Finset.sum_sub_distrib, Finset.mul_sum]
    refine Finset.sum_congr rfl fun t _ => ?_
    simp only [hR4a x s, hR4a c s]; ring
  rw [← Finset.sum_sub_distrib, Finset.sum_congr rfl fun s _ => key s, ← Finset.mul_sum]
  simp only [Finset.sum_sub_distrib]
  ring

section bianchiHalf
variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0)
include hR hskew hsym

/-- **Step 2 of the L209 block, the `#` half**: `(R#)_{ij,kl} = B_{ijkl} - B_{ijlk}`, no Bianchi. -/
theorem sharpBil_phi_B (i j k l : ι) :
    sharpBil R (phi i j) (phi k l) = B4 R i j k l - B4 R i j l k := by
  have hP := R4_pair R hR hskew hsym
  rw [sharpBil_expand R hR]
  simp only [Finset.sum_add_distrib]
  rw [T_eq4 R hR hskew hsym i j k l, T_eq4 R hR hskew hsym k l i j]
  have hswap : ∑ s, ∑ t, (R4 R k s i t * R4 R l s j t - R4 R k s j t * R4 R l s i t)
      = ∑ s, ∑ t, (R4 R i s k t * R4 R j s l t - R4 R i s l t * R4 R j s k t) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun s _ => Finset.sum_congr rfl fun t _ => ?_
    rw [hP k t i s, hP l t j s, hP k t j s, hP l t i s]; ring
  rw [hswap]
  unfold B4
  simp only [Finset.sum_sub_distrib]
  ring

omit hskew hsym in
/-- **`R#` read in four indices is `sharpBil` on the basis pair.** -/
theorem R4_sharpOp (i j k l : ι) : R4 (sharpOp R) i j k l = sharpBil R (phi i j) (phi k l) := by
  unfold R4 sharpOp
  have hlin : ∀ (s : Finset ι) (f : ι → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ),
      inner2 (∑ i ∈ s, f i) Y = ∑ i ∈ s, inner2 (f i) Y := by
    intro s f Y; simp [inner2, Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]
  have hsm : ∀ (r : ℝ) (X Y : Matrix ι ι ℝ), inner2 (r • X) Y = r * inner2 X Y := by
    intro r X Y; simp [inner2, Matrix.transpose_smul, Matrix.trace_smul]; ring
  rw [hsm, hlin]
  simp only [hlin, hsm, inner2_phi_phi]
  simp only [mul_sub, mul_ite, mul_one, mul_zero, ite_and, Finset.sum_sub_distrib,
    Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have hcol : ∀ (u v : ι) (F : ι → ι → ℝ),
      (∑ x, ∑ y, if x = u then (if y = v then F x y else 0) else 0) = F u v := by
    intro u v F
    rw [Fintype.sum_eq_single u (fun x hx => by simp [hx])]
    simp
  rw [hcol k l (fun x y => sharpBil R (phi i j) (phi x y))]
  try rw [hcol l k (fun x y => sharpBil R (phi i j) (phi x y))]
  try rw [phi_swap k l, sharpBil_neg_right R hR]
  ring

include hB in
/-- **Step 2 of the L209 block, the `R²` half**: `(R²)_{ij,kl} = B_{ikjl} - B_{iljk}`, by first Bianchi twice. -/
theorem R4_compOp_B (i j k l : ι) : R4 (compOp R) i j k l = B4 R i k j l - B4 R i l j k := by
  have hP := R4_pair R hR hskew hsym
  have hA2 := R4_anti2 R hR
  have hBi2 : ∀ a b c d, R4 R a b c d = R4 R a c b d - R4 R a d b c := by
    intro a b c d; have := hB a b c d; unfold bianchi at this
    have h := hA2 a c b d; unfold R4 at *; linarith
  have hsq : R4 (compOp R) i j k l = (1/2) * ∑ p, ∑ q, R4 R i j p q * R4 R k l p q := by
    unfold R4 compOp
    rw [hsym _ _ (hskew _ (phi_isSkew i j)) (phi_isSkew k l)]
    conv_lhs => rw [← skew_expand (R (phi k l)) (hskew _ (phi_isSkew k l))]
    rw [FamilyLayer.inner2_smul_right, inner2_sum_right]
    congr 1
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [inner2_sum_right]
    refine Finset.sum_congr rfl fun q _ => ?_
    rw [FamilyLayer.inner2_smul_right, inner2_comm (R (phi i j))]; ring
  have e : ∀ p q, R4 R i j p q * R4 R k l p q
      = R4 R i p j q * R4 R k p l q - R4 R i p j q * R4 R l p k q
        - R4 R i q j p * R4 R k p l q + R4 R i q j p * R4 R l p k q := by
    intro p q
    have h1 := hBi2 i j p q
    have h2 : R4 R k l p q = R4 R k p l q - R4 R l p k q := by
      rw [hBi2 k l p q, hP k q l p]
    rw [h1, h2]; ring
  have t3 : ∑ p, ∑ q, R4 R i q j p * R4 R k p l q = ∑ p, ∑ q, R4 R i p j q * R4 R l p k q := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    rw [hP k q l p]
  have t4 : ∑ p, ∑ q, R4 R i q j p * R4 R l p k q = ∑ p, ∑ q, R4 R i p j q * R4 R k p l q := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    rw [hP l q k p]
  rw [hsq]
  simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [t3, t4]
  unfold B4
  ring

include hB in
/-- **LEMMA L209, THE BIANCHI HALF**: `Q(R)` satisfies first Bianchi, the twelve `B` terms of the
cyclic sum cancelling in pairs. -/
theorem bianchi_Qop (i j k l : ι) : bianchi (Qop R) i j k l = 0 := by
  have hQ : ∀ a b c d, inner2 (Qop R (phi a b)) (phi c d)
      = (B4 R a c b d - B4 R a d b c) + (B4 R a b c d - B4 R a b d c) := by
    intro a b c d
    unfold Qop
    rw [FamilyLayer.inner2_add_left]
    have h1 := R4_compOp_B R hR hskew hsym hB a b c d
    have h2 := R4_sharpOp R hR a b c d
    rw [sharpBil_phi_B R hR hskew hsym] at h2
    unfold R4 at h1 h2
    rw [h1, h2]
  unfold bianchi
  rw [hQ, hQ, hQ]
  ring

include hB in
/-- **L209's closure on Ricci-flatness**: a Ricci-flat `R` has Ricci-flat `Q(R)`. -/
theorem ric_Qop_flat (hRic : ∀ a b, Ric R a b = 0) (a b : ι) : Ric (Qop R) a b = 0 := by
  rw [ric_Qop_eq R hR hskew hsym hB]
  simp [hRic]

end bianchiHalf

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.T_eq4           -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.sharpBil_phi_B  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.R4_compOp_B     -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.bianchi_Qop     -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.ric_Qop_flat    -- [propext, Classical.choice, Quot.sound]
