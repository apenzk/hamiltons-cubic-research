import Mathlib
import HamiltonsCubic.Results.L264Three

set_option linter.style.longLine false

/-!
# L264 (3) and L270 (3): statement H from U$_s'$ on simple subalgebras alone

[findings/second-order.md](../../../findings/second-order.md), Lemma L264 (3): *"statement H at $n\ge9$ follows from*
**U$_{\mathrm s}$**: *on a compact simple $\mathfrak h$, every stable positive-definite idempotent equals $I/c$"*, and
Lemma L270 (3), which weakens U$_{\mathrm s}$ to U$_{\mathrm s}'$, the norm bound. [I117Statements.lean](I117Statements.lean)'s
`L270_H_of_Us'` takes the bound at every stable positive semidefinite idempotent of $\mathfrak{so}(n)$, the reduction to
simple subalgebras being prose. This file removes that prose:

* `L270_H_of_Us_simple`: statement H at $n\ge9$ follows from the bound $\lVert C\rVert^2\ge N/(n-2)^2$ at the stable
  positive semidefinite idempotents $C\ne0$ whose range is a **simple** subalgebra, the maximiser's idempotent being
  one of them by [L264Three.lean](L264Three.lean)'s `L264_three_simple`. Stability passes from $\mathfrak{so}(n)$ to
  $\mathfrak h$ in the direction the reduction uses: `IsStable` quantifies over every self-adjoint $H\perp C$, and those
  supported on $\mathfrak h$ are among them.
* `L270_H_of_bound`, the converse: statement H gives the bound at every nonzero self-adjoint idempotent, since
  $F(C,C,C)=\lVert C\rVert^2$ there. So `L270_H_iff_Us_simple` holds, and what the reduction adds is where a
  counterexample to H must live, on a stable positive semidefinite idempotent with simple range.

The bound in the hypothesis is U$_{\mathrm s}'$ composed with L256's comparison $d/c^2\ge N/(n-2)^2$, which stays with
the record.
-/

namespace HamiltonsCubic.L270Simple

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.CompactSemisimple

attribute [local instance] LieRing.ofAssociativeRing LieAlgebra.ofAssociativeAlgebra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Statement H from U$_s'$ on simple subalgebras.** -/
theorem L270_H_of_Us_simple (hn : 9 ≤ Fintype.card ι)
    (hUs : ∀ C : CurvOp2 ι, IsSelfAdjoint2 C → IsPSD2 C → IsIdem C → C ≠ 0 → IsStable C →
      (∃ hbr : ∀ A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι), ∀ B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι),
          brS A B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι), LieAlgebra.IsSimple ℝ (lieOf _ hbr)) →
      (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 / ((Fintype.card ι : ℝ) - 2) ^ 2 ≤ normSq2 C) :
    StatementH ι := by
  have hn3 : 3 ≤ Fintype.card ι := by omega
  have hκ : 0 ≤ kappaN ι := by
    have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn3
    unfold kappaN; exact div_nonneg (by linarith) (Real.sqrt_nonneg _)
  refine statementH_of_unit hκ ?_
  obtain ⟨X, hX, hX1, hmax⟩ := exists_sa_maximiser (ι := ι) (by omega)
  intro Z hZ hZ1
  refine (hmax Z hZ hZ1).trans ?_
  rcases le_or_gt (Ftri X X X) 0 with hle | hpos
  · exact hle.trans hκ
  obtain ⟨Y, hY, hYp, hYn, hXY⟩ := L260_psd_cone X hX
  rw [hX1] at hYn
  have hYmax : ∀ W : CurvOp2 ι, IsSelfAdjoint2 W → normSq2 W = 1 → Ftri W W W ≤ Ftri Y Y Y :=
    fun W hW hW1 => (hmax W hW hW1).trans hXY
  have hYX : Ftri Y Y Y = Ftri X X X := le_antisymm (hmax Y hY hYn) hXY
  have hYpos : 0 < Ftri Y Y Y := by rw [hYX]; exact hpos
  obtain ⟨hidem, hstab⟩ := L264_maximiser_stable Y hY hYn hYmax hYpos
  have hCn : normSq2 ((1 / Ftri Y Y Y) • Y) = (1 / Ftri Y Y Y) ^ 2 := by rw [normSq2_smul', hYn, mul_one]
  have hC0 : (1 / Ftri Y Y Y) • Y ≠ 0 := by
    intro h0
    have hpos2 : 0 < normSq2 ((1 / Ftri Y Y Y) • Y) := by rw [hCn]; exact pow_pos (one_div_pos.mpr hYpos) 2
    have h00 : normSq2 (0 : CurvOp2 ι) = 0 := by
      have h := innerOp2_smul_left 0 (0 : CurvOp2 ι) 0
      rw [zero_smul_op, zero_mul] at h
      exact h
    rw [h0, h00] at hpos2
    exact lt_irrefl _ hpos2
  have hsimple := HamiltonsCubic.L264Three.L264_three_simple hn3 Y hY hYp hYn hYmax
  have hb := hUs ((1 / Ftri Y Y Y) • Y) (isSelfAdjoint2_smul hY _)
    (isPSD2_smul hYp (le_of_lt (one_div_pos.mpr hYpos))) hidem hC0 hstab hsimple
  rw [← hYX]
  exact maximiser_le_kappa hn3 hYpos hCn hb

/-- **The converse**: statement H gives `‖C‖² ≥ N/(n−2)²` at every nonzero self-adjoint `#`-idempotent, since
`F(C, C, C) = ‖C‖²` turns H into `‖C‖² ≤ κₙ ‖C‖³`. -/
theorem L270_H_of_bound (hn : 3 ≤ Fintype.card ι) (hH : StatementH ι) (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C)
    (hid : IsIdem C) (hC0 : C ≠ 0) :
    (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 / ((Fintype.card ι : ℝ) - 2) ^ 2 ≤ normSq2 C := by
  have hn' : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
  have hq0 := normSq2_nonneg C
  have hq : 0 < normSq2 C := by
    rcases hq0.lt_or_eq with h | h
    · exact h
    · exact absurd (normSq2_eq_zero h.symm) hC0
  have hF : Ftri C C C = normSq2 C := by rw [Ftri_idem hid]; rfl
  have hHC := hH C hC
  rw [hF] at hHC
  set r := Real.sqrt (normSq2 C) with hr
  have hr0 : 0 < r := Real.sqrt_pos.mpr hq
  have hr2 : r ^ 2 = normSq2 C := Real.sq_sqrt hq0
  have hpow : normSq2 C ^ ((3 : ℝ) / 2) = r ^ 3 := by
    rw [← hr2, ← Real.rpow_natCast r 2, ← Real.rpow_mul hr0.le]
    norm_num
  rw [hpow, ← hr2] at hHC
  have h1 : 1 ≤ kappaN ι * r := by
    have : r ^ 2 * 1 ≤ r ^ 2 * (kappaN ι * r) := by nlinarith
    exact le_of_mul_le_mul_left this (by positivity)
  set c := (Fintype.card ι : ℝ) - 2 with hc
  set N := (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 with hN
  have hc0 : 0 < c := by linarith
  have hN0 : 0 < N := by rw [hN]; nlinarith
  have hsN : 0 < Real.sqrt N := Real.sqrt_pos.mpr hN0
  have hsN2 : Real.sqrt N ^ 2 = N := Real.sq_sqrt hN0.le
  have hk : kappaN ι = c / Real.sqrt N := rfl
  rw [hk, div_mul_eq_mul_div, le_div_iff₀ hsN, one_mul] at h1
  rw [← hr2, div_le_iff₀ (by positivity)]
  nlinarith [mul_le_mul h1 h1 hsN.le (by positivity)]

/-- **At `n ≥ 9`, statement H is EQUIVALENT to the bound on stable positive semidefinite idempotents with simple
range.** -/
theorem L270_H_iff_Us_simple (hn : 9 ≤ Fintype.card ι) :
    StatementH ι ↔ ∀ C : CurvOp2 ι, IsSelfAdjoint2 C → IsPSD2 C → IsIdem C → C ≠ 0 → IsStable C →
      (∃ hbr : ∀ A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι), ∀ B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι),
          brS A B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι), LieAlgebra.IsSimple ℝ (lieOf _ hbr)) →
      (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 / ((Fintype.card ι : ℝ) - 2) ^ 2 ≤ normSq2 C :=
  ⟨fun hH C hC _ hid hC0 _ _ => L270_H_of_bound (by omega) hH C hC hid hC0, L270_H_of_Us_simple hn⟩

end HamiltonsCubic.L270Simple
