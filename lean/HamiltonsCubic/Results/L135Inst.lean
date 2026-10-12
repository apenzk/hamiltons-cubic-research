import HamiltonsCubic.Results.L135Statement

set_option linter.style.longLine false

/-!
# L135(a) at the competitor, as one theorem

[findings/route-a.md](../../../findings/route-a.md), Lemma L135(a): `c₂(H) = Δ₂(H) - 1/9`, `c₂` the second-order coefficient
of `δ²` along the great circle `cos τ u + sin τ H` and `Δ₂` along the line `u + tH`. [L135Statement.lean](L135Statement.lean)
proves both halves: `line_eq`, the reparametrisation relation `h(t) = (1 + t²) k(arctan t)` for any positively
`2`-homogeneous `δ²`, and `coeff_identity`, `c₂ = Δ₂ - A` from that relation. **This file composes them at the
competitor's value**:

* **`L135_at_competitor`**: for `D` positively `2`-homogeneous (which `δ²(W) = ‖Alt(W₋)‖²` is), with the two one-sided
  second-order expansions about the value `1/9` (`D(u)`, the expansions' constant term) defining `c₂` and `Δ₂`,
  `c₂ = Δ₂ - 1/9`.

*Untyped*: `δ²` as a function on operators. The layer's [AltPart.lean](../Base/AltPart.lean) `defectSq` takes the
spectral data `(λ, ω)`, so the operator-level `δ²`, its homogeneity, and the two expansions at the competitor enter
here as hypotheses.
-/

namespace HamiltonsCubic.L135Statement

open Filter Topology

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-- **L135(a) at the competitor**: for `D` positively `2`-homogeneous, expanded about the value `D(u) = 1/9` along both
paths, the great-circle coefficient is the straight-line one minus `1/9`. -/
theorem L135_at_competitor (D : V → ℝ) (hD : ∀ c : ℝ, 0 ≤ c → ∀ x, D (c • x) = c ^ 2 * D x) (u H : V) {B c₂ Δ₂ : ℝ}
    (hk : Tendsto (fun τ => (D (Real.cos τ • u + Real.sin τ • H) - 1 / 9 - B * τ) / τ ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 c₂))
    (hh : Tendsto (fun t => (D (u + t • H) - 1 / 9 - B * t) / t ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 Δ₂)) :
    c₂ = Δ₂ - 1 / 9 :=
  coeff_identity (h := fun t => D (u + t • H)) (k := fun τ => D (Real.cos τ • u + Real.sin τ • H))
    (fun t _ => line_eq D hD u H t) hk hh

end HamiltonsCubic.L135Statement
