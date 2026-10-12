import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L137, WITHDRAWN: the closed-form cross-term bound in `H`'s blocks

## The record's statement, verbatim

> #### Lemma L137, WITHDRAWN: the closed-form cross-term bound in $H$'s blocks
>
> **REFUTED at Gate 2** (r425, r426, identical briefs, agreeing on every root cause). Three
> defects: a convention collision on $W_-$ that inverted the $B$-term's sign, a $CC^\top$ term that
> does not exist once the fixed projector's own motion is counted, and $\rho$ added where it must
> be subtracted, which made $\lVert c_1\rVert^2$ look like an obstruction when it can only help.
> **Superseded by the corrected Lemma L136**, whose bound is stronger. *The Hansen–Pedersen
> compression, $\Pi_A\le P_0$, the factors of $t$, $\Lambda^{-1}$, the subadditivity of
> $X\mapsto\operatorname{tr}(X_+)$ and the $2a$ arithmetic were each confirmed individually; the
> lemma failed on assembly.* **Two of the three defects are structurally invisible to stepwise
> checking**, which is why. The phantom $CC^\top$ is positive semidefinite, so including it leaves
> every upper bound in the chain *true*, no inequality step can detect a term that only loosens.
> And the $\rho$ sign is an inversion rather than a loosening: $X-\rho$ and $X+\rho$ straddle $X$
> and differ by $2\rho$, so $\lVert c_1\rVert^2$ changes role rather than magnitude.

[route-a.md](../../../findings/route-a.md), Lemma L137.

## What this file states

**L137 is a refutation notice, so what there is to state is its two structural claims**, the
reasons stepwise checking could not have caught the failure. Both are PROVED here, with no `sorry`:

- `phantom_only_loosens`: for any real matrices `A` and `P` with `P` positive semidefinite, the
  quadratic form of `A` is bounded by that of `A + P` at every vector. So an upper bound proved for
  the chain **with** a phantom PSD term still bounds the true quantity: every inequality step
  remains true, and **no inequality check anywhere in the chain can see the term**. `phantom_ccT`
  supplies the notice's own instance, `P = CCᵀ`.
- `inversion_is_not_a_loosening`: `X − ρ ≤ X ≤ X + ρ` with `(X + ρ) − (X − ρ) = 2ρ`, the two
  straddle `X` rather than sitting on one side of it, so a sign error on a nonnegative term costs
  twice that term.
- `inversion_breaks_lower_bounds`: and it reverses the term's role. A bound established against
  `X + ρ` need not hold against `X − ρ`, which is exactly what turned `‖c₁‖²` from something that
  can only help into something that looked like an obstruction.

## What is NOT typed here

- **The withdrawn bound itself**, the closed-form cross-term bound in `H`'s blocks. It needs `W₋`,
  the Hansen–Pedersen compression, `Π_A`, `P₀`, `Λ` and `c₁`, none of which the `RealLayer`
  carries; the file therefore states no cross-term inequality, correct or otherwise.
- **The first defect**, the convention collision on `W₋` that inverted the `B`-term's sign. It is a
  claim about which sign convention two sources use, not an arithmetic statement.
- **That the corrected Lemma L136's bound is stronger**, and that the individually confirmed steps
  (`Π_A ≤ P₀`, the factors of `t`, `Λ⁻¹`, subadditivity of `X ↦ tr(X₊)`, the `2a` arithmetic) are
  each sound. The claim here is only about how a chain of sound steps can fail on assembly.
-/

namespace HamiltonsCubic.L137Statement

open Matrix

/-! ## The phantom PSD term is invisible to any check that only bounds -/

/-- **A positive semidefinite summand can only raise a quadratic form**, so every upper bound in a
chain that carries a phantom PSD term remains *true*. That is why no inequality step could detect
the `CCᵀ` that does not exist. -/
theorem phantom_only_loosens {n : Type*} [Fintype n] [DecidableEq n]
    (A P : Matrix n n ℝ) (hP : P.PosSemidef) (x : n → ℝ) :
    x ⬝ᵥ (A *ᵥ x) ≤ x ⬝ᵥ ((A + P) *ᵥ x) := by
  have h := hP.dotProduct_mulVec_nonneg x
  simp only [star_trivial] at h
  rw [Matrix.add_mulVec, dotProduct_add]
  linarith

/-- **And an upper bound proved with the phantom still bounds the truth**: no step of the chain is
false, so stepwise checking cannot find it. -/
theorem phantom_bound_still_sound {n : Type*} [Fintype n] [DecidableEq n]
    (A P : Matrix n n ℝ) (hP : P.PosSemidef) (x : n → ℝ) (b : ℝ)
    (h : x ⬝ᵥ ((A + P) *ᵥ x) ≤ b) : x ⬝ᵥ (A *ᵥ x) ≤ b :=
  le_trans (phantom_only_loosens A P hP x) h

/-- The notice's own instance: `CCᵀ` is positive semidefinite. -/
theorem phantom_ccT {n : Type*} [Fintype n] [DecidableEq n] (C : Matrix n n ℝ) :
    (C * Cᵀ).PosSemidef := by
  simpa using Matrix.posSemidef_conjTranspose_mul_self Cᵀ

/-! ## The sign error is an inversion, not a loosening -/

/-- **`X − ρ` and `X + ρ` straddle `X` and differ by `2ρ`.** A sign error on a nonnegative term
costs twice that term, which is why it is an inversion rather than a loosening. -/
theorem inversion_is_not_a_loosening {X ρ : ℝ} (hρ : 0 ≤ ρ) :
    X - ρ ≤ X ∧ X ≤ X + ρ ∧ (X + ρ) - (X - ρ) = 2 * ρ :=
  ⟨by linarith, by linarith, by ring⟩

/-- **And it reverses the term's role.** A bound holding against `X + ρ` need not hold against
`X − ρ`: the term that can only help becomes one that looks like an obstruction. -/
theorem inversion_breaks_lower_bounds :
    ∃ X ρ b : ℝ, 0 < ρ ∧ b ≤ X + ρ ∧ ¬ (b ≤ X - ρ) :=
  ⟨0, 1, 1, by norm_num, by norm_num, by norm_num⟩

/-! ## A witness, so the hypotheses are not empty

*The identity matrix is positive semidefinite, so `phantom_only_loosens` has a satisfied
antecedent.* -/

example {n : Type*} [Fintype n] [DecidableEq n] (A : Matrix n n ℝ) (x : n → ℝ) :
    x ⬝ᵥ (A *ᵥ x) ≤ x ⬝ᵥ ((A + 1) *ᵥ x) :=
  phantom_only_loosens A 1 Matrix.PosSemidef.one x

end HamiltonsCubic.L137Statement
