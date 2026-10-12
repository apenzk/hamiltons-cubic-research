import Mathlib
import HamiltonsCubic.Results.L71Cor
import HamiltonsCubic.Results.L117Frame

set_option linter.style.longLine false

/-!
# L71's odd-`n` clause: no critical point saturates at odd `n ≥ 5`

[findings/bounds.md](../../../findings/bounds.md), Lemma L71: *"... and no critical point saturates at
odd $n\ge5$, since $\dim\mathfrak m=n^2/4\notin\mathbb Z$."* The record counts it from relations
(A), (B) and tracelessness once $\mathfrak r=0$, and this file takes the same route
([r1717](../../../reviews/REVIEW_r1717.md) Q7, [r1719](../../../reviews/REVIEW_r1719.md) Q5):

* `L71_dim_m`: at a saturating critical point `4 dim 𝔪 = n²` and `4 dim 𝔥 = n(n-2)`, counted as
  frame multiplicities, from [L117Frame.lean](L117Frame.lean)'s `L117_counts` and
  [L71Cor.lean](L71Cor.lean)'s two-valuedness;
* `L71_odd_vacuous`: at odd `n ≥ 5` the hypotheses of [L71Sat.lean](L71Sat.lean)'s `L71_saturated`
  cannot all hold, since `L71_corollaries` makes the spectrum two-valued and L117Frame's
  `L117_no_eq_odd` forbids that at odd `n`.
-/

namespace HamiltonsCubic.L71Odd

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind
  HamiltonsCubic.L71Cor

variable {n : ℕ}

/-- **The multiplicities at a saturating point**: `4 dim 𝔪 = n²`, `4 dim 𝔥 = n(n-2)`. -/
theorem L71_dim_m (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin) :
    4 * (univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmin).card
        = n ^ 2 ∧
      4 * (univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmax).card
        = n * (n - 2) := by
  obtain ⟨γ, hγ⟩ := hex
  have htwo := (L71_corollaries hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat ⟨γ, hγ⟩).1
  have h := L117_counts (by omega) W hW θ hc γ lmin lmax hγ hneg hpos hlo hhi hsat htwo
  exact ⟨h.2, h.1⟩

/-- **No critical point saturates at odd `n ≥ 5`**: `L71_saturated`'s hypotheses are inconsistent there. -/
theorem L71_odd_vacuous (hn : 5 ≤ n) (hodd : ¬ Even n)
    (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin) : False := by
  obtain ⟨γ, hγ⟩ := hex
  exact L117_no_eq_odd (by omega) hodd W hW θ hc γ lmin lmax hγ hneg hpos hlo hhi hsat
    (L71_corollaries hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat ⟨γ, hγ⟩).1

end HamiltonsCubic.L71Odd
