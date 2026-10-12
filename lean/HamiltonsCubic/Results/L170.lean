import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L170, the half-eigenspace at a critical point

[second-order.md](../../../findings/second-order.md)'s Lemma L170. At any critical point with
`θ ≠ 0`, `E(1/2) = ker Hess(P|_S)_W`, so [L13](../../../findings/curvature-invariants.md)'s clause
*"the ½-eigenspace is exactly the orbit tangent"* **is Morse–Bott nondegeneracy**, a
hypothesis, not a theorem awaiting proof.

**What is checked here.** The pointwise content, once `Hess = 6θ(L_e - ½·Id)` is diagonalised:
under `θ > 0` and `λ ≤ ½`, a direction is in the Hessian kernel exactly when `λ = ½`. And the
[L128](../../../findings/second-order.md) sharpening: at a maximum, excluding `½` from a block
is the strict inequality.

**Where the rest lives.** `Hess(P|_S)_W = 6θ(L_e - ½·Id)` on `W^⊥` is `hessQ_op` and `hessB_op` in
[L24HessOp.lean](L24HessOp.lean), and `L_e W = W` is `Le_self` in [L24Eigen.lean](L24Eigen.lean).
The identification of `ker Hess` with `T_W𝒪` is owed. **The lemma's content is an equivalence
between two structural properties, so this file records its arithmetic core and names the
rest.**
-/

namespace HamiltonsCubic.HalfEigenspace

/-! ## The pointwise content of the Hessian identity -/

/-- **Under `θ > 0`, a direction with `L_e`-eigenvalue `λ` lies in `ker Hess` exactly when
`λ = ½`.** This is `6θ(λ - ½) = 0 ↔ λ = ½`, and it is the whole of the displayed equality
once the Hessian is diagonalised. **Maximality is not used**: `L_e` preserves `W^⊥` and is
self-adjoint there, so the kernel is the `0`-eigenspace of `L_e - ½` whatever the sign of the
form, and `θ ≠ 0` is all that is required. *An earlier docstring here made maximality the
reason the kernel is the whole eigenspace; both audits refuted that inference.* -/
theorem kernel_is_half_eigenspace (θ lam : ℚ) (hθ : 0 < θ) :
    6 * θ * (lam - 1 / 2) = 0 ↔ lam = 1 / 2 := by
  constructor
  · intro h
    have : lam - 1 / 2 = 0 := by
      rcases mul_eq_zero.mp h with h1 | h2
      · exfalso; rcases mul_eq_zero.mp h1 with h3 | h4
        · norm_num at h3
        · linarith
      · exact h2
    linarith
  · intro h; rw [h]; ring

/-- Second-order optimality gives `Hess ⪯ 0` on `W^⊥`, which under `θ > 0` is `λ ≤ ½`. -/
theorem maximality_bounds_spectrum (θ lam : ℚ) (hθ : 0 < θ) (h : 6 * θ * (lam - 1 / 2) ≤ 0) :
    lam ≤ 1 / 2 := by nlinarith

/-! ## The [L128](../../../findings/second-order.md) sharpening at a maximum -/

/-- **At a local maximum, excluding `½` from a four-set block is the strict `μ < ½`.** Those
blocks lie in `W^⊥`, where `L_e ⪯ ½`, so the criterion's exclusion and a strict inequality
coincide, *and the repair that weakened a downstream obligation from `Σ < θ²` to `Σ ≠ θ²` is
right for critical points and unnecessary at maxima.* -/
theorem exclusion_is_strict (mu : ℚ) (hle : mu ≤ 1 / 2) : mu ≠ 1 / 2 ↔ mu < 1 / 2 := by
  constructor
  · intro h; exact lt_of_le_of_ne hle h
  · intro h; exact ne_of_lt h

/-- The witness the criterion's own audit names, showing a block **above** `½` is admissible
at a critical point: `S² × S⁴` at `n = 6` has `μ_{2,4} = 2/3 > 1/2`. **That branch is what
maximality closes.** -/
theorem block_above_half_at_critical : (1 : ℚ) / 2 < 2 / 3 := by norm_num

/-! ## Why the two recorded witnesses never bore on the clause -/

/-- `S³ × S³` gives `18` against an orbit of `9`, and `S² × S³ × S³` gives `60` against `21`.
**Both are degenerate critical points and neither is a local maximum**, so both are consistent
with the statement, and a degenerate local maximum would refute the clause while contradicting
nothing on the record, which is why no proof of it is available. -/
theorem witnesses_are_degenerate : (9 : ℕ) < 18 ∧ (21 : ℕ) < 60 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.HalfEigenspace
