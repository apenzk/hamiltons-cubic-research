import Mathlib

/-!
# Statement H on a simple subalgebra asks only for a lower bound on the trace

[The working note](../../../reviews/2026-09-28l-I117-g2-torus.md) on I117, "H on a simple
subalgebra asks only for a trace lower bound". Pairing `C # C = C` with `I` and splitting `C` into
its isotypic components `C_V`, on which `I #` acts by the scalar `γ_V = c − Cas_V / 4` (L265), gives
`τ = c τ² / d + ∑_V γ_V ‖C_V‖²` with `τ = tr C` and `‖C‖² = τ² / d + ∑_V ‖C_V‖²`.

**Typed**: the scalar core (`norm_ge_of_pairing`), that the pairing forces
`τ − (c − γ*) τ² / d ≤ γ* ‖C‖²` for `γ*` the largest nontrivial scalar, and its instance on `𝔤₂`
(`g2_threshold`): `c = 4`, `d = 14`, `γ* = 5/3`, so every `#`-idempotent with `tr C ≥ 12/7` has
`‖C‖² ≥ 36/49`, which is H's `N/(n−2)²` at `n = 9`. **Not typed**: the pairing identity itself,
which enters as a hypothesis (the representation theory of L265), as in L259's `idem_norm_ge`.
-/

namespace HamiltonsCubic.TraceThreshold

/-- **The scalar core.** If `τ = c τ²/d + ∑ γ_i n_i` and `q = τ²/d + ∑ n_i` with every `n_i ≥ 0` and
every `γ_i ≤ γ*`, then `τ − (c − γ*) τ²/d ≤ γ* q`. -/
theorem norm_ge_of_pairing {ι : Type*} [Fintype ι] (c d gstar τ q : ℝ) (n γ : ι → ℝ)
    (hn : ∀ i, 0 ≤ n i) (hγ : ∀ i, γ i ≤ gstar)
    (hpair : τ = c * τ ^ 2 / d + ∑ i, γ i * n i) (hq : q = τ ^ 2 / d + ∑ i, n i) :
    τ - (c - gstar) * τ ^ 2 / d ≤ gstar * q := by
  have hsum : ∑ i, γ i * n i ≤ gstar * ∑ i, n i := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun i _ => mul_le_mul_of_nonneg_right (hγ i) (hn i)
  have h1 : τ - c * τ ^ 2 / d = ∑ i, γ i * n i := by linarith
  have e : τ - (c - gstar) * τ ^ 2 / d = (τ - c * τ ^ 2 / d) + gstar * (τ ^ 2 / d) := by ring
  rw [e, h1, hq, mul_add]
  linarith

/-- **`𝔤₂`'s threshold.** With `γ* = 5/3`, `c = 4`, `d = 14`, the scalar core reads
`(5/3) q ≥ τ − τ²/6`; with Cauchy–Schwarz `τ² ≤ 14 q`, every trace `τ ≥ 12/7` gives `q ≥ 36/49`. -/
theorem g2_threshold (τ q : ℝ) (hcore : τ - (4 - 5 / 3) * τ ^ 2 / 14 ≤ 5 / 3 * q)
    (hcs : τ ^ 2 ≤ 14 * q) (hτ : 12 / 7 ≤ τ) : 36 / 49 ≤ q := by
  by_cases h : τ ≤ 30 / 7
  · nlinarith [mul_nonneg (sub_nonneg.mpr hτ) (sub_nonneg.mpr h)]
  · have h' := (not_le.mp h).le
    nlinarith

/-- The window is sharp at its lower end: `τ = 12/7` with `q = 36/49` meets the core with equality. -/
example : (12 / 7 : ℝ) - (4 - 5 / 3) * (12 / 7) ^ 2 / 14 = 5 / 3 * (36 / 49) := by norm_num

end HamiltonsCubic.TraceThreshold
