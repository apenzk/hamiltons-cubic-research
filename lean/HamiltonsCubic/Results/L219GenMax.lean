import Mathlib
import HamiltonsCubic.Results.L219Gen
import HamiltonsCubic.Results.L219Max

set_option linter.style.longLine false

/-!
# L219's bound at every unit `u`, at a global maximiser as the record states it

[findings/second-order.md](../../../findings/second-order.md), Lemma L219: *at a unit global maximiser,
$\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$.* [L219Gen.lean](L219Gen.lean)'s `odd_mass_gen` takes the eigen-equation
$Q(W)=\theta W$ and $\theta>0$ as hypotheses. Both hold at every global maximiser on the unit Weyl sphere at $n\ge4$, as in
[L219Max.lean](L219Max.lean)'s `odd_mass_global`: $Q(W)=P(W)\,W$ by Fermat (`Qop2_eq_smul_weyl`) and
$P(W)\ge\sqrt{3/2}>0$ by the maximiser's own competitor (`exists_weyl_maximiser`).

* **`odd_mass_gen_global`**: at a global maximiser $W$ of $P$ on the unit Weyl sphere, $n\ge4$, and every unit $u$,
  $\lVert\tfrac12(W-\sigma_uW)\rVert^2\le\tfrac34$.
-/

namespace HamiltonsCubic.L219GenMax

open HamiltonsCubic.RealLayer HamiltonsCubic.L214Op HamiltonsCubic.FrameOp2 HamiltonsCubic.L219Gen

/-- **L219's bound at a global maximiser, at every unit `u`**, with no criticality or sign hypothesis. -/
theorem odd_mass_gen_global {n : ℕ} (hn : 4 ≤ n) (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) (W : CurvOp2 (Fin n))
    (hW : W ∈ weylSphereSet (Fin n)) (hmax : IsMaxOn Pcubic2 (weylSphereSet (Fin n)) W) :
    normSq2 ((1 / 2 : ℝ) • (W - rotR (Su u) W)) ≤ 3 / 4 := by
  have hQ := Qop2_eq_smul_weyl hW.1 hW.2 hmax.localize
  obtain ⟨a, ha, -, hpa⟩ := exists_weyl_maximiser hn
  have hθ : 0 < Pcubic2 W := by
    have h1 : Pcubic2 a ≤ Pcubic2 W := hmax ha
    have h2 : 0 < Real.sqrt (3 / 2) := Real.sqrt_pos.mpr (by norm_num)
    linarith
  exact odd_mass_gen u hu W hW.2 hW.1 hQ hθ fun R hR hR1 => hmax ⟨hR1, hR⟩

end HamiltonsCubic.L219GenMax
