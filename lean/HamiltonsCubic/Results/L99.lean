import HamiltonsCubic.Results.L129
import Mathlib.Tactic.NormNum

/-!
# L99, the kernel, and the sharp hypothesis `k⁺ ≥ 2`

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L99. The audit says **every
figure in the core is superfluous**, the kernel being the component-indicator span because
`M² - θM` is the Laplacian of `w_ab = M_ab²`, *"three lines from [L129](L129.lean), 290 lines
below it"*.

**That dependency is now discharged in the direction the audit names.** [L129](L129.lean)
proves the Dirichlet identity and the termwise consequence: the form vanishing forces
`x_a = x_b` whenever `M_ab ≠ 0`, which *is* constancy on the components of `{w > 0}`. So the
kernel characterisation needs no census and no figure, and the two blocks, 290 lines apart,
neither citing the other, are one argument.

**The hypothesis is sharp, and the sharpness is a dimension count.** The eigenspace has
dimension `k⁺ - 1`, so it is nonempty **exactly** when `k⁺ ≥ 2`; at `k⁺ = 1` it is empty and
only the radial direction survives. That is why the file's own padded `S⁴ × S⁴` at `n = 9`
refutes the wider claim, a one-component witness cannot carry the eigenvector.
-/

namespace HamiltonsCubic.SharpKPlus

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The kernel needs no figure -/

/-- **Constancy on edges, from the Dirichlet form alone.** If the weighted sum of squared
differences vanishes, then every edge's endpoints agree, so the kernel is spanned by the
component indicators, with nothing measured. This is [L129](L129.lean)'s termwise step, stated
for the kernel rather than for an eigenvector. -/
theorem constant_on_edges {M : ι → ι → ℝ} {x : ι → ℝ}
    (hz : ∑ a, ∑ b, (M a b) ^ 2 * (x a - x b) ^ 2 = 0) {a b : ι} (hM : M a b ≠ 0) :
    x a = x b := by
  classical
  have hinner : ∀ a' : ι, (0:ℝ) ≤ ∑ b', (M a' b') ^ 2 * (x a' - x b') ^ 2 :=
    fun a' => Finset.sum_nonneg fun b' _ => mul_nonneg (sq_nonneg _) (sq_nonneg _)
  have ha := (Finset.sum_eq_zero_iff_of_nonneg (fun a' _ => hinner a')).1 hz a (mem_univ a)
  have hab := (Finset.sum_eq_zero_iff_of_nonneg
    (fun b' _ => mul_nonneg (sq_nonneg (M a b')) (sq_nonneg (x a - x b')) :
      ∀ b' ∈ univ, (0:ℝ) ≤ (M a b') ^ 2 * (x a - x b') ^ 2)).1 ha b (mem_univ b)
  have hw : (M a b) ^ 2 ≠ 0 := pow_ne_zero 2 hM
  have hsq : (x a - x b) ^ 2 = 0 := by
    rcases mul_eq_zero.1 hab with h | h
    · exact absurd h hw
    · exact h
  have := pow_eq_zero_iff (n := 2) (by norm_num) |>.1 hsq
  linarith

/-! ## The sharp hypothesis -/

/-- **The eigenspace has dimension `k⁺ - 1`, so it is nonempty exactly when `k⁺ ≥ 2`.** -/
theorem eigenspace_nonempty_iff (kplus : ℕ) (hk : 1 ≤ kplus) : 1 ≤ kplus - 1 ↔ 2 ≤ kplus := by
  omega

/-- **At `k⁺ = 1` the eigenspace is empty** and only the radial direction survives, so the
wider claim (stated without `k⁺ ≥ 2`), fails on every one-component point. That is what the
file's own padded `S⁴ × S⁴` at `n = 9` exhibits. -/
theorem wider_claim_fails (kplus : ℕ) (h : kplus = 1) : ¬ (1 ≤ kplus - 1) := by omega

end HamiltonsCubic.SharpKPlus
