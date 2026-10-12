import Mathlib
import HamiltonsCubic.Results.L224Eq
import HamiltonsCubic.Results.L57Equality
import HamiltonsCubic.Results.L57OddEq

set_option linter.style.longLine false

/-!
# L57's equality case on Weyl operators of character `1`, in homogeneous form

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 5: *$W'$ is an L57 maximiser $B'$*.
[L57Equality.lean](L57Equality.lean)'s `L57_unit_eq` and [L57OddEq.lean](L57OddEq.lean)'s `L57_unit_eq_odd` state L57's equality
case for a weight normalised to `fro S = 2` with `diagP S = Θ_n`. This file carries them to any nonzero Weyl operator of
character $1$ attaining $P=\Theta_n\lVert\cdot\rVert^3$, which is the form [L224Eq.lean](L224Eq.lean)'s $W'$ arrives in.

* `unit_rescale`: a nonzero weight attaining $P(\mathrm{diagOp}\,w)=\Theta\lVert\mathrm{diagOp}\,w\rVert^3$ rescales by $c>0$ to
  `fro (c • w) = 2` and `diagP (c • w) = Θ`;
* **`charOne_eq_even`**: at $P(W)=\theta_0(n)\lVert W\rVert^3$, $W\ne0$ of character $1$ is $\mathrm{diagOp}\,w$ with
  $w=t\,Z'(v)$ for a balanced $v$ ($v_a^2=1/n$, $\sum v=0$, $t>0$), and $n$ is even;
* **`charOne_eq_odd`**: at odd $n\ge5$ and $P(W)=\Theta_n\lVert W\rVert^3$, $W=\mathrm{diagOp}\,w$ with $w=t\,Z'(v)$, $t>0$,
  $\sum v=0$, $\sum v^2=1$, and $v$ two-valued on two sets whose sizes differ by one.
-/

namespace HamiltonsCubic.L57Bridge

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.FamilyLayer HamiltonsCubic.L57Critical HamiltonsCubic.L224Bound

variable {n : ℕ}

theorem norm_diagOp (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w) :
    RealLayer.norm (diagOp w) = Real.sqrt (fro w / 2) := by
  unfold RealLayer.norm
  rw [diagOp_normSq w hw.symm hw.hollow]
  congr 1; unfold fro; ring

/-- **Rescaling to L57's unit normalisation.** -/
theorem unit_rescale {Θ : ℝ} (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w) (h0 : 0 < fro w)
    (heq : Pcubic (diagOp w) = Θ * RealLayer.norm (diagOp w) ^ 3) :
    ∃ c : ℝ, 0 < c ∧ IsWeight (c • w) ∧ fro (c • w) = 2 ∧ diagP (c • w) = Θ := by
  set F := fro w with hF
  set c := Real.sqrt (2 / F) with hc
  have hc0 : 0 < c := Real.sqrt_pos.mpr (by positivity)
  have hc2 : c ^ 2 = 2 / F := Real.sq_sqrt (by positivity)
  have hcr : c * Real.sqrt (F / 2) = 1 := by
    rw [hc, ← Real.sqrt_mul (by positivity)]
    rw [show 2 / F * (F / 2) = 1 by field_simp]
    exact Real.sqrt_one
  refine ⟨c, hc0, hw.smul c, ?_, ?_⟩
  · rw [fro_smul, hc2, ← hF]; field_simp
  · rw [L57Critical.diagP_smul, ← diagCubicFormula w hw, heq, norm_diagOp w hw, ← hF]
    calc c ^ 3 * (Θ * Real.sqrt (F / 2) ^ 3) = Θ * (c * Real.sqrt (F / 2)) ^ 3 := by ring
      _ = Θ := by rw [hcr]; ring

/-- A nonzero character-`1` operator's weight has positive Frobenius mass. -/
theorem charOne_weight {W : CurvOp2 (Fin n)} (hW : IsWeyl2 W) (h1 : SignChar (fun _ => 1) W) :
    ∃ w : Matrix (Fin n) (Fin n) ℝ, ∃ hw : IsWeight w, W = restrict (diagOp_isWeyl hw) ∧
      Pcubic2 W = Pcubic (diagOp w) ∧ normSq2 W = fro w / 2 := by
  obtain ⟨w, hw, rfl⟩ := (L120Ident.trivial_block_iff W hW).mp h1
  refine ⟨w, hw, rfl, Pcubic2_restrict (isLinOp_diagOp w) _, ?_⟩
  rw [normSq2_restrict (isLinOp_diagOp w) _, diagOp_normSq w hw.symm hw.hollow]
  unfold fro; ring

/-- **L57's equality case on a character-`1` Weyl operator, even form.** -/
theorem charOne_eq_even (hn : 4 ≤ n) {W : CurvOp2 (Fin n)} (hW : IsWeyl2 W) (h1 : SignChar (fun _ => 1) W)
    (hne : normSq2 W ≠ 0)
    (heq : Pcubic2 W = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) * Real.sqrt (normSq2 W) ^ 3) :
    ∃ w : Matrix (Fin n) (Fin n) ℝ, ∃ hw : IsWeight w, W = restrict (diagOp_isWeyl hw) ∧
      (∃ (v : Fin n → ℝ) (t : ℝ), 0 < t ∧ (∀ a, v a ^ 2 = 1 / (n : ℝ)) ∧ ∑ a, v a = 0 ∧
        ∀ a b, w a b = t * Zp v (n : ℝ) a b) ∧ Even n := by
  obtain ⟨w, hw, rfl, hP, hN⟩ := charOne_weight hW h1
  refine ⟨w, hw, rfl, ?_⟩
  have hF : 0 < fro w := by
    rw [hN] at hne
    rcases (fro_nonneg w).lt_or_eq with h | h
    · exact h
    · exfalso; apply hne; rw [← h]; ring
  have heq' : Pcubic (diagOp w) = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ)
      * RealLayer.norm (diagOp w) ^ 3 := by
    rw [← hP, heq, hN, norm_diagOp w hw]
  obtain ⟨c, hc0, hcw, hcf, hcd⟩ := unit_rescale w hw hF heq'
  have hcard : Fintype.card (Fin n) = n := Fintype.card_fin n
  obtain ⟨⟨v, t, ht, hv2, hvs, hS⟩, hev⟩ :=
    L57_unit_eq hcw (by rw [hcard]; exact hn) hcf (by rw [hcard]; exact hcd)
  rw [hcard] at hv2 hS hev
  refine ⟨⟨v, t / c, div_pos ht hc0, hv2, hvs, fun a b => ?_⟩, hev⟩
  have := hS a b
  simp only [Matrix.smul_apply, smul_eq_mul] at this
  field_simp
  linarith

/-- **L57's equality case on a character-`1` Weyl operator, odd form.** -/
theorem charOne_eq_odd (hn : 5 ≤ n) (hodd : ¬ Even n) {W : CurvOp2 (Fin n)} (hW : IsWeyl2 W)
    (h1 : SignChar (fun _ => 1) W) (hne : normSq2 W ≠ 0)
    (heq : Pcubic2 W = Real.sqrt (thetaOddSq (n : ℝ)) * Real.sqrt (normSq2 W) ^ 3) :
    ∃ w : Matrix (Fin n) (Fin n) ℝ, ∃ hw : IsWeight w, W = restrict (diagOp_isWeyl hw) ∧
      ∃ (v : Fin n → ℝ) (t x y : ℝ), 0 < t ∧ ∑ a, v a = 0 ∧ ∑ a, v a ^ 2 = 1 ∧ x ≠ y ∧
        (∀ a, v a = x ∨ v a = y) ∧
        (((Finset.univ.filter fun a => v a = x).card : ℤ) - (Finset.univ.filter fun a => v a = y).card) ^ 2 = 1 ∧
        ∀ a b, w a b = t * Zp v (n : ℝ) a b := by
  obtain ⟨w, hw, rfl, hP, hN⟩ := charOne_weight hW h1
  refine ⟨w, hw, rfl, ?_⟩
  have hF : 0 < fro w := by
    rw [hN] at hne
    rcases (fro_nonneg w).lt_or_eq with h | h
    · exact h
    · exfalso; apply hne; rw [← h]; ring
  have heq' : Pcubic (diagOp w) = Real.sqrt (thetaOddSq (n : ℝ)) * RealLayer.norm (diagOp w) ^ 3 := by
    rw [← hP, heq, hN, norm_diagOp w hw]
  obtain ⟨c, hc0, hcw, hcf, hcd⟩ := unit_rescale w hw hF heq'
  have hcard : Fintype.card (Fin n) = n := Fintype.card_fin n
  obtain ⟨v, t, x, y, ht, hvs, hv2, hxy, hv, hcardxy, hS⟩ :=
    L57_unit_eq_odd hcw (by rw [hcard]; exact hn) (by rw [hcard]; exact hodd) hcf (by rw [hcard]; exact hcd)
  rw [hcard] at hS
  refine ⟨v, t / c, x, y, div_pos ht hc0, hvs, hv2, hxy, hv, hcardxy, fun a b => ?_⟩
  have := hS a b
  simp only [Matrix.smul_apply, smul_eq_mul] at this
  field_simp
  linarith

end HamiltonsCubic.L57Bridge
