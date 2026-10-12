import HamiltonsCubic.Base.SelfDual

set_option linter.style.longLine false

/-!
# L196, two complex structures with a common self-wedge agree up to sign

**The record's statement**, [diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L196,
Gate 2 passed by [r836](../../../reviews/REVIEW_r836.md) and [r837](../../../reviews/REVIEW_r837.md):

> Let `J₁, J₂` be orthogonal complex structures on `ℝ^{2m}` with `ω₁ ∧ ω₁ = ω₂ ∧ ω₂`.
> Then `J₂ = ±J₁` at every `m ≥ 3`.

## The split, and why it falls where it does

**Step 1, the difference of squares, is `ready` and is proved below.** *Equal self-wedges is
`α ∧ β = 0` at `α = ω₁ - ω₂` and `β = ω₁ + ω₂`, which is bilinearity of the wedge and nothing else.*

**Step 2, that `L : Λ² → Λ⁴` is injective at `m ≥ 3`, is `out`.** *The record proves it by hard
Lefschetz on a symplectic vector space, where `L`, contraction with the inverse bivector and their
commutator form an `𝔰𝔩₂`. Mathlib carries no hard Lefschetz. It DOES carry the
`𝔰𝔩₂` machinery, in `Mathlib/Algebra/Lie/Sl2.lean`: `IsSl2Triple`, `HasPrimitiveVectorWith` and
`toLieSubalgebra`, which is the representation-theoretic input such an argument runs on. What is
absent is the theorem, not the algebra, and an earlier version of this sentence said `only
SymplecticGroup`, naming a wider scope than it had searched.* **A reviewer's elementary Darboux argument reaches the same injectivity and
would be the route**, and it is recorded in the block as unaudited.

**Step 3, that both factors cannot degenerate at once, is `ready` and is NOT proved here.** *At
`T = -J₁J₂` one has `J₁TJ₁⁻¹ = T⁻¹`, so `E± = ker(T ∓ I)` are `J₁`-invariant, `α` annihilates `E₊`
and `β` annihilates `E₋`.* It is linear algebra throughout and needs no Lefschetz.

## Scope

`IsComplexStructure` is defined at `Fin 6` only, which is `m = 3`: the smallest case the lemma
covers and exactly where it first bites, `m = 2` being a genuine counterexample the block records.
-/

namespace HamiltonsCubic.L196Statement

open HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Step 1, the difference of squares.** *`wedgeSelf` is a quadratic form for the bilinear
`wedge2`, so the difference of two self-wedges is the wedge of the sum with the difference.*
**This needs no skewness, no orthogonality and no dimension.** -/
theorem wedgeSelf_sub_wedgeSelf (X Y : Matrix ι ι ℝ) :
    wedgeSelf X - wedgeSelf Y = wedge2 (X - Y) (X + Y) := by
  funext a b c d
  simp only [wedgeSelf, wedge2, halfw, Pi.sub_apply, Pi.add_apply,
    Matrix.sub_apply, Matrix.add_apply]
  ring

/-- **Equal self-wedges IS the vanishing of the cross wedge**, which is step 1 as the record uses
it: an iff rather than an implication. -/
theorem wedgeSelf_eq_iff (X Y : Matrix ι ι ℝ) :
    wedgeSelf X = wedgeSelf Y ↔ wedge2 (X - Y) (X + Y) = 0 := by
  rw [← wedgeSelf_sub_wedgeSelf]
  constructor
  · intro h; rw [h]; abel
  · intro h
    have := sub_eq_zero.mp h
    exact this

end HamiltonsCubic.L196Statement
