import Mathlib.Tactic

/-!
# Lemma L215, the quadratic map's norm bound, and the isolation radius it gives

[findings/second-order.md](../../../findings/second-order.md), the L215 block.

**What the block proves.** `‖X♯‖ ≤ (n-2)‖X‖²` and hence `‖Q X‖ ≤ (n-1)‖X‖²`, from the Casimir
identity `∑ₐ Aₐᵀ Aₐ = 2(n-2) Id` on `Λ²`, and with it a positive explicit isolation radius
`2θ₀/((n-2)(n-1))`.

## What is typed here

**The two inequality chains, over abstract nonneg reals**, which is where the content is once the
Casimir identity is granted: `sharp_bound` is the Cauchy-Schwarz chain of step 2 and
`quadratic_bound` adds step 1's `‖X²‖ ≤ ‖X‖²`. Then `isolation_radius` is the estimate the block
draws: from `γ‖N‖ ≤ κ‖N‖²` with `κ ≤ n-1`, either `N = 0` or `‖N‖ ≥ γ/(n-1)`.

**Not typed**: the Casimir identity itself, which is Schur's lemma plus the count
`∑ c² = n(n-1)(n-2)` and needs `Λ²` with its `𝔰𝔬(n)` action; and `‖X²‖ ≤ ‖X‖²`, which is
`∑λ⁴ ≤ (∑λ²)²` and needs the spectral decomposition. Both enter as hypotheses, named so a reader
sees exactly what the arithmetic is granted.
-/

namespace HamiltonsCubic.Results

/-- **Step 2's chain.** With `s² ≤ (c‖X‖²)²/4` the Cauchy-Schwarz output and `c = 2(n-2)`, the
sharp part is bounded by `(n-2)‖X‖²`. *Stated over the squares, which is how both inequalities
arrive, so no square root is taken of anything unsigned. Only `0 ≤ cas` is needed: the compiler
found the signs of `s` and `x` redundant, so they are not asked for.* -/
theorem sharp_bound {s x cas : ℝ} (hcas : 0 ≤ cas)
    (hchain : s ^ 2 ≤ (cas * x ^ 2) ^ 2 / 4) :
    s ≤ cas * x ^ 2 / 2 := by
  nlinarith [sq_nonneg s, sq_nonneg (cas * x ^ 2), mul_nonneg hcas (sq_nonneg x)]

/-- **The two halves together.** `‖Q X‖ ≤ ‖X²‖ + ‖X♯‖ ≤ ‖X‖² + (n-2)‖X‖² = (n-1)‖X‖²`. -/
theorem quadratic_bound {q sq sh x n : ℝ}
    (htri : q ≤ sq + sh) (hsq : sq ≤ x ^ 2) (hsh : sh ≤ (n - 2) * x ^ 2) :
    q ≤ (n - 1) * x ^ 2 := by
  nlinarith [sq_nonneg x]

/-- **THE DICHOTOMY, AND IT IS ABOUT ONE SCALAR INEQUALITY.** `hchain` is
`γ‖N‖ ≤ (n-1)‖N‖²`, which is what the off-diagonal equation plus the bound above deliver once
the gap is available; the conclusion is that `‖N‖` vanishes or is at least `γ/(n-1)`.

**AN EARLIER DOCSTRING NAMED THREE HYPOTHESES, `hlin`, `heq` AND `hquad`, THAT THIS THEOREM DOES
NOT CARRY** ([r929](../../../reviews/REVIEW_r929.md)). *It carries `hchain` alone, so the
composition of the gap with the equation and the bound happens in the prose and not here.*

**AND THE GEOMETRIC STATEMENT THIS WAS WRITTEN FOR IS FALSE IN A FIXED FRAME**, refuted by
rotating the balanced product along a gauge direction: those are genuine critical points at
`‖N‖` as small as one likes. *The dichotomy below is still true of the scalars, and what it needs
to mean anything is `N` transverse to the gauge orbit.* -/
theorem isolation_radius {nrm gam n : ℝ} (hnrm : 0 ≤ nrm) (hn : 1 < n)
    (hchain : gam * nrm ≤ (n - 1) * nrm ^ 2) :
    nrm = 0 ∨ gam / (n - 1) ≤ nrm := by
  rcases eq_or_lt_of_le hnrm with h | h
  · exact Or.inl h.symm
  · refine Or.inr ?_
    rw [div_le_iff₀ (by linarith)]
    nlinarith [hchain, h]

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.sharp_bound
#print axioms HamiltonsCubic.Results.quadratic_bound
#print axioms HamiltonsCubic.Results.isolation_radius
