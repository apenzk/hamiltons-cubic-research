import HamiltonsCubic.Base.Pfaffian6

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# I67: the `levi6` middle-slot swaps, and both relabellings of the pairing

## What this file is

The pairing `Σ_{ab} (star6 (wedgeSelf X))_{ab} Z_{ab} = 12 · triple6 Z X X` is the last route to
`pf6`'s closed form, every other one having closed: direct expansion of `triple6 X X X` exceeds
`simp`'s step ceiling, staging does not help, and `triple6` cannot be evaluated even at a single
CONCRETE basis triple, so the obstacle is the sum's arity rather than the generality of its
arguments.

**The pairing is proved by RELABELLING rather than by expanding**, which is why it can work where
the others cannot: the proofs below reindex, so the arity never matters. Writing

* `A = Σ ε Z_{ab} X_{cd} X_{ef}`,
* `B = Σ ε Z_{ab} X_{ce} X_{df}`,
* `C = Σ ε Z_{ab} X_{cf} X_{de}`,

the wedge's three terms are `A - B + C`, and this file proves `B = -A` and `C = A`, so the whole
contracts to `3A`.

## What is proved

* `levi6_swap_de` and `levi6_swap_ef`: antisymmetry of `levi6` in its middle slots, each one line,
  the same shape as the layer's own `levi6_swap01`.
* `relabel_de`: `B = -A`, by `Finset.sum_comm` on the `d,e` sums plus `levi6_swap_de`.
* `relabel_fe`: `C = -B`, the same motion one level deeper, on the `e,f` sums.
* `relabel_df`: `C = A`, the two composed.
* `star_wedge_pairing`: the pairing itself, at EVERY `X` and `Z`, with no hypothesis.

*`C = A` is reached as a CYCLE rather than as the reversal `(d,e,f) ↦ (f,e,d)`. The substitution
that carries `C` to `A` is `(d,e,f) ↦ (f,d,e)`, which is even, so the two sign flips cancel and the
two neighbour swaps `Finset.sum_comm` supplies are exactly enough.*

## What this leaves owed

**Nothing in this file.** *The pairing is `star_wedge_pairing` below, and with it `pf6`'s closed form
follows at `Z = X` in [I67Pf6.lean](I67Pf6.lean) and [L193](L193Statement.lean)'s `sorry` is
discharged.*

**What the CHAIN still owes is `pf6 J = 1 or -1` at a complex structure**, which needs
`Pf(X)^2 = det X` together with `det J = 1`. *Both are stated in
[I67PfSquared.lean](I67PfSquared.lean) with named `sorry`s.*

**GATE 2 PASSED**, r993, sole reviewer by design, all ten rows CONFIRMED.
-/

namespace HamiltonsCubic.I67Relabel

open HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer

/-- **`levi6` is antisymmetric in its fourth and fifth slots.** -/
theorem levi6_swap_de (a b c d e f : Fin 6) :
    levi6 a b c e d f = - levi6 a b c d e f := by
  unfold levi6; rw [sgnR_swap e d]; ring

/-- **`levi6` is antisymmetric in its fifth and sixth slots.** -/
theorem levi6_swap_ef (a b c d e f : Fin 6) :
    levi6 a b c d f e = - levi6 a b c d e f := by
  unfold levi6; rw [sgnR_swap f e]; ring

/-- **The first relabelling, `B = -A`.** *Proved by reindexing, so nothing is expanded and the
arity of the sum never enters.* -/
theorem relabel_de (X Z : Matrix (Fin 6) (Fin 6) ℝ) :
    (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * X c e * X d f)
      = -(∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * X c d * X e f) := by
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun d _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun e _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun f _ => ?_
  rw [levi6_swap_de]
  ring

/-- **The second relabelling, `C = -B`.** *The same motion as `relabel_de`, one level deeper: the
swap is of the innermost pair of sums, so `levi6_swap_ef` carries the sign.* -/
theorem relabel_fe (X Z : Matrix (Fin 6) (Fin 6) ℝ) :
    (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * X c f * X d e)
      = -(∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * X c e * X d f) := by
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun d _ => ?_
  rw [Finset.sum_comm]
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun e _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun f _ => ?_
  rw [levi6_swap_ef]
  ring

/-- **The third term equals the first, `C = A`.** *The substitution carrying `C` to `A` is the
CYCLE `(d,e,f) ↦ (f,d,e)`, which is even: the two sign flips cancel.* -/
theorem relabel_df (X Z : Matrix (Fin 6) (Fin 6) ℝ) :
    (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * X c f * X d e)
      = ∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * X c d * X e f := by
  rw [relabel_fe, relabel_de, neg_neg]

/-- **The pairing, `⟪star6 (wedgeSelf X), Z⟫ = 12 · triple6 Z X X`, at EVERY `X` and `Z`.**
*No hypothesis whatever, skewness included. The wedge's three terms are `A - B + C`, the
relabellings make that `3A`, and the `1/24 · 2 · 3` on the left meets the `12 · 1/48` on the
right at `A/4`.* -/
theorem star_wedge_pairing (X Z : Matrix (Fin 6) (Fin 6) ℝ) :
    (∑ a : Fin 6, ∑ b : Fin 6, star6 (wedgeSelf X) a b * Z a b) = 12 * triple6 Z X X := by
  have expand : ∀ a b : Fin 6, star6 (wedgeSelf X) a b * Z a b
      = ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
          (1/12 : ℝ) * (levi6 a b c d e f * Z a b * X c d * X e f
            - levi6 a b c d e f * Z a b * X c e * X d f
            + levi6 a b c d e f * Z a b * X c f * X d e) := by
    intro a b
    rw [star6_apply, mul_comm, ← mul_assoc, Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun e _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun f _ => ?_
    rw [wedgeSelf_apply]
    ring
  simp only [expand, ← Finset.mul_sum, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [relabel_de, relabel_df]
  unfold triple6
  ring

end HamiltonsCubic.I67Relabel
