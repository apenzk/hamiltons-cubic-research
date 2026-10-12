import HamiltonsCubic.Results.SecondKind
import HamiltonsCubic.Results.L209WeylClosure

set_option linter.style.longLine false

/-!
# L50, the potential is a function of two spectra

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50: with `μ` the `Λ²` spectrum and
`ω` that of the second-kind operator,
`θ = ⟨W, Q(W)⟩ = (3/2) p₃(μ) − (1/2) p₃(ω)`, `∑μ² = 1`, `∑ω² = 3`.

The record's proof runs through two contractions, `α = W_{tpsq} W_{tpkl} W_{sqkl}` and
`β = W_{tspq} W_{tjpl} W_{sjql}`, and two links it states without derivation, `α = 8 tr M³` and
`β = 2⟨M#, M⟩`. **This file proves both links against the layer's own `trCube` and `sharpPair`**:

- `trCube_eq_alpha`: `tr R³ = α/8`, by expanding the pairing in the `φ` family, for a linear `R`
  that preserves bivectors and is self-adjoint on them;
- `sharpPair_eq_beta`: `⟨R, R#⟩ = β/2`, from `sharpBil_phi_B`'s `(R#)_{ij,kl} = B_{ijkl} − B_{ijlk}`
  and one relabelling, under the same hypotheses;
- `Pcubic_eq_alpha_beta`: `P = α/8 + β/2`, which needs no Bianchi;
- `L50_bispectral`: with first Bianchi, **`P = (3/2) tr R³ − (1/2) tr_{S²} W̊³`**, by
  [SecondKind.lean](SecondKind.lean)'s `tr_{S²} W̊³ = α/8 − β`;
- `L50_norm`: `tr_{S²} W̊² = 3 ‖R‖²`, the record's `∑ω² = 3` at unit norm.

**The traces are traces of operators, and the spectra enter by reading them.** `trCube R` is
`tr M³ = p₃(μ)` for `M` the operator on `Λ²`. `trS2` is the trace over all of `S²`, and at a
Ricci-flat `R` it equals the trace over `S²₀`, since `W̊ g = −Ric = 0` (`ringW_one`) and `W̊` maps
`S²` into `S²₀` (`trace_ringW`), so `g` spans an invariant line carrying eigenvalue zero. **Not
typed**: the eigen-decompositions themselves, so `p₃(μ)` and `p₃(ω)` appear as the traces they equal.
-/

namespace HamiltonsCubic.L50Spectra

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.SecondKind

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The pairing of two bivectors in the `φ` family**, with the ordered-pair doubling. -/
theorem inner2_skew_expand (X Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    inner2 X Y = (1 / 2) * ∑ k, ∑ l, inner2 X (phi k l) * inner2 Y (phi k l) := by
  conv_lhs => rw [← RealLayer.skew_expand Y hY]
  rw [FamilyLayer.inner2_smul_right, inner2_sum_right]
  congr 1
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [inner2_sum_right]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [FamilyLayer.inner2_smul_right]; ring

/-- **`⟨R, S⟩ = ¼ ∑ R_{ijkl} S_{ijkl}`** when `S` maps bivectors to bivectors. -/
theorem innerOp_R4 (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hS : ∀ X, IsSkew X → IsSkew (S X)) :
    innerOp R S = (1 / 4) * ∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * R4 S i j k l := by
  unfold innerOp
  rw [show (1 / 4 : ℝ) = (1 / 2) * (1 / 2) by norm_num, mul_assoc]
  congr 1
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_skew_expand _ _ (hS _ (phi_isSkew i j)), Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun l _ => ?_
  unfold R4; ring

section links

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

omit hR in
/-- `(R²)_{ij,kl} = ½ ∑ R_{ijmn} R_{klmn}`, by self-adjointness and the `φ` expansion. -/
theorem R4_compOp_sum (i j k l : ι) :
    R4 (compOp R) i j k l = (1 / 2) * ∑ m, ∑ n, R4 R i j m n * R4 R k l m n := by
  unfold R4 compOp
  rw [hsym _ _ (hskew _ (phi_isSkew i j)) (phi_isSkew k l),
    inner2_skew_expand _ _ (hskew _ (phi_isSkew k l))]

omit hR in
/-- **`α = 8 tr M³`**: `tr R³ = α/8`. -/
theorem trCube_eq_alpha : trCube R = alphaW R / 8 := by
  unfold trCube
  rw [innerOp_comm_selfAdj, innerOp_R4 R (compOp R) (fun X hX => hskew _ (hskew X hX)), alphaW]
  simp only [R4_compOp_sum R hskew hsym, Finset.mul_sum, Finset.sum_div]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
    Finset.sum_congr rfl fun m _ => Finset.sum_congr rfl fun n _ => ?_
  ring
where
  innerOp_comm_selfAdj : innerOp (compOp R) R = innerOp R (compOp R) := by
    unfold innerOp
    congr 1
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    exact inner2_comm _ _

/-- **`β = 2⟨M#, M⟩`**: `⟨R, R#⟩ = β/2`. -/
theorem sharpPair_eq_beta : sharpPair R = betaW R / 2 := by
  have hA2 := R4_anti2 R hR
  have hSskew : ∀ X, IsSkew X → IsSkew (sharpOp R X) := fun X _ => sharpOp_isSkew R X
  unfold sharpPair
  rw [innerOp_R4 R (sharpOp R) hSskew]
  simp only [R4_sharpOp R hR, sharpBil_phi_B R hR hskew hsym]
  -- `∑ W_{ijkl} B_{ijlk} = −∑ W_{ijkl} B_{ijkl}`, relabelling `k ↔ l`
  have hswap : (∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * B4 R i j l k)
      = -∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * B4 R i j k l := by
    simp only [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    rw [hA2 i j k l]; ring
  have hsplit : (∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * (B4 R i j k l - B4 R i j l k))
      = (∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * B4 R i j k l)
        - ∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * B4 R i j l k := by
    simp only [← Finset.sum_sub_distrib, mul_sub]
  have hbeta : betaW R = ∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * B4 R i j k l := by
    unfold betaW B4
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
      Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    simp only [Finset.mul_sum]
    refine Finset.sum_congr rfl fun m _ => Finset.sum_congr rfl fun n _ => ?_
    ring
  rw [hsplit, hswap, hbeta]; ring

/-- **`P = α/8 + β/2`**, with no Bianchi. -/
theorem Pcubic_eq_alpha_beta : Pcubic R = alphaW R / 8 + betaW R / 2 := by
  unfold Pcubic
  rw [trCube_eq_alpha R hskew hsym, sharpPair_eq_beta R hR hskew hsym]

end links

section bispectral

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0)
include hR hskew hsym hB

/-- **L50's identity**: `P = (3/2) tr M³ − (1/2) tr_{S²} W̊³`, the record's
`θ = (3/2) p₃(μ) − (1/2) p₃(ω)` before normalising. -/
theorem L50_bispectral :
    Pcubic R = (3 / 2) * trCube R - (1 / 2) * trS2 (fun h => ringW R (ringW R (ringW R h))) := by
  rw [Pcubic_eq_alpha_beta R hR hskew hsym, trCube_eq_alpha R hskew hsym,
    trS2_ringW_cube R hR hskew hsym hB]
  ring

/-- **L50's norm relation**: `tr_{S²} W̊² = 3 ‖R‖²`, so `∑ω² = 3` at unit norm. -/
theorem L50_norm : trS2 (fun h => ringW R (ringW R h)) = 3 * normSq R := by
  rw [trS2_ringW_sq R hR hskew hsym hB, normSq, innerOp_R4 R R hskew, ← mul_assoc]
  norm_num
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun b _ => sq _

end bispectral

end HamiltonsCubic.L50Spectra
