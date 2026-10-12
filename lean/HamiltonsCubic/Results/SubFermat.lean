import Mathlib
import HamiltonsCubic.Results.WeylMaximiser
import HamiltonsCubic.Results.L221Ops

set_option linter.style.longLine false

/-!
# Criticality of a maximiser on a `Q`-closed subspace, and L220's step 1 in full

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 1: *$\mathcal S_Q$ is a subalgebra, so the maximum
of $P$ on its unit sphere satisfies $Q(W)=\theta W$ in $\mathcal W_n$.* [WeylMaximiser.lean](WeylMaximiser.lean)'s Fermat argument
runs along a curve through $a$ in the plane of $a$ and $y$, which stays in any linear subspace containing both, so it holds on
the unit sphere of every subspace $S$ of self-adjoint operators; when $S$ is closed under $Q$, $Q(a)-\lambda a$ lies in $S$ and
is orthogonal to it, hence zero:

* `fermat_sub`: a local maximiser $a$ on $S$'s unit sphere has $\langle y,Q(a)\rangle=0$ at every $y\in S$, $y\perp a$;
* **`crit_sub`**: when $S$ is closed under $Q$, $Q(a)=P(a)\,a$;
* `SW`: $\mathcal S_t\cap\mathcal W_n$ as a submodule, closed under $Q$ by [BlockSub.lean](BlockSub.lean)'s `S_mul`;
* **`L220_step1_crit`**: a local maximiser of $P$ on the unit sphere of $\mathcal S_t\cap\mathcal W_n$ satisfies $Q(W)=P(W)\,W$, so it is
  critical in $\mathcal W_n$, at every index set $t$ and so at L220's four-set $Q$.
-/

namespace HamiltonsCubic.SubFermat

open HamiltonsCubic.RealLayer HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L222Op
  HamiltonsCubic.BlockSub HamiltonsCubic.L221Ops
open scoped NNReal Matrix.Norms.Frobenius OperatorNorm

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Fermat on the unit sphere of a subspace of self-adjoint operators.** -/
theorem fermat_sub (S : Submodule ℝ (CurvOp2 ι)) (hSa : ∀ R ∈ S, IsSelfAdjoint2 R) {a : CurvOp2 ι}
    (ha : normSq2 a = 1) (haS : a ∈ S) (hmax : IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ S} a)
    {y : CurvOp2 ι} (hyS : y ∈ S) (hy : innerOp2 a y = 0) : innerOp2 y (Qop2 a) = 0 := by
  have hd : HasFDerivWithinAt Pcubic2 (PcubicDiffS a) {R | normSq2 R = 1 ∧ R ∈ S} a :=
    (hasFDerivAt_Pcubic2 (hSa a haS)).hasFDerivWithinAt
  have hneg : (-y : CurvOp2 ι) = (-1 : ℝ) • y := by module
  have hyneg : innerOp2 a (-y) = 0 := by rw [hneg, innerOp2_smul_right, hy, mul_zero]
  have hcurve : ∀ z : CurvOp2 ι, z ∈ S → innerOp2 a z = 0 → ∀ t,
      sphereCurve a z t ∈ {R | normSq2 R = 1 ∧ R ∈ S} := fun z hzS hz t =>
    ⟨sphereCurve_mem ha hz t, by unfold sphereCurve; exact S.smul_mem _ (S.add_mem haS (S.smul_mem t hzS))⟩
  have h1 := hmax.hasFDerivWithinAt_nonpos hd (mem_posTangentConeAt_of_curve (hcurve y hyS hy))
  have h2 := hmax.hasFDerivWithinAt_nonpos hd (mem_posTangentConeAt_of_curve (hcurve (-y) (S.neg_mem hyS) hyneg))
  have h1' : 3 * innerOp2 y (Qop2 a) ≤ 0 := h1
  have h2' : 3 * innerOp2 (-y) (Qop2 a) ≤ 0 := h2
  have hlin : innerOp2 (-y) (Qop2 a) = -innerOp2 y (Qop2 a) := by rw [hneg, innerOp2_smul_left]; ring
  rw [hlin] at h2'
  linarith

/-- **Criticality on a `Q`-closed subspace**: a local maximiser on its unit sphere has `Q(a) = P(a) a`. -/
theorem crit_sub (S : Submodule ℝ (CurvOp2 ι)) (hSa : ∀ R ∈ S, IsSelfAdjoint2 R) (hSQ : ∀ R ∈ S, Qop2 R ∈ S)
    {a : CurvOp2 ι} (ha : normSq2 a = 1) (haS : a ∈ S) (hmax : IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ S} a) :
    Qop2 a = Pcubic2 a • a := by
  set lam : ℝ := innerOp2 a (Qop2 a) with hlam
  set z : CurvOp2 ι := Qop2 a - lam • a with hz
  have haa : innerOp2 a a = 1 := ha
  have hza : innerOp2 z a = 0 := by
    rw [hz, innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm (Qop2 a) a, ← hlam, haa]
    ring
  have haz : innerOp2 a z = 0 := by rw [innerOp2_comm]; exact hza
  have hzS : z ∈ S := by rw [hz]; exact S.sub_mem (hSQ a haS) (S.smul_mem lam haS)
  have hzq : innerOp2 z (Qop2 a) = 0 := fermat_sub S hSa ha haS hmax hzS haz
  have hzz : normSq2 z = 0 := by
    show innerOp2 z z = 0
    nth_rewrite 1 [hz]
    rw [innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm (Qop2 a) z, hzq, haz]
    ring
  have hz0 : z = 0 := normSq2_eq_zero hzz
  rw [hz] at hz0
  rw [Pcubic2_eq_innerOp2, ← hlam]
  exact sub_eq_zero.mp hz0

/-- **`𝒮_t ∩ 𝒲ₙ` as a submodule.** -/
def SW (t : Finset ι) : Submodule ℝ (CurvOp2 ι) where
  carrier := {R | IsWeyl2 R ∧ InS t R}
  add_mem' := by
    rintro x y ⟨hxW, D, ν, hD, hν, rfl⟩ ⟨hyW, D', ν', hD', hν', rfl⟩
    exact ⟨isWeyl2_add hxW hyW, D + D', ν + ν', signChar_add hD hD', signChar_add hν hν', by abel⟩
  zero_mem' := ⟨isWeyl2_zero, 0, 0, signChar_zero _, signChar_zero _, by abel⟩
  smul_mem' := by
    rintro c x ⟨hxW, D, ν, hD, hν, rfl⟩
    exact ⟨isWeyl2_smul c hxW, c • D, c • ν, signChar_smul hD c, signChar_smul hν c, by module⟩

theorem SW_Qop2 (t : Finset ι) : ∀ R ∈ SW t, Qop2 R ∈ SW t := by
  rintro _R ⟨hRW, hR⟩
  refine ⟨isWeyl2_Qop2 hRW, ?_⟩
  rw [← foxProd2_self]
  exact S_mul hR hR

/-- **L220 (1), the maximiser clause**: a local maximiser of `P` on the unit sphere of `𝒮_t ∩ 𝒲ₙ` satisfies
`Q(W) = P(W) W`, so it is critical in `𝒲ₙ`. -/
theorem L220_step1_crit (t : Finset ι) {W : CurvOp2 ι} (hW1 : normSq2 W = 1) (hWS : W ∈ SW t)
    (hmax : IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ SW t} W) : Qop2 W = Pcubic2 W • W :=
  crit_sub (SW t) (fun R hR => hR.1.isSelfAdjoint2) (SW_Qop2 t) hW1 hWS hmax

end HamiltonsCubic.SubFermat
