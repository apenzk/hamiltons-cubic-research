import Mathlib
import HamiltonsCubic.Base.WeylReal

/-!
# L61, `M(5) = √(3/2)`, the global maximum on `𝒲₅`, STATED

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L61, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> On `𝒲₅` the sextic `F₅ = (3/2)‖W‖⁶ − 9 tr(W³)²` is a sum of squares of cubic forms, each
> vanishing on the `O(5)`-orbit of `W₀`, the zero-padding of `W_{ℂP²}`, with an exact rational
> certificate. Since `⟨W, W#⟩ = 2 tr(W³)` on `𝒲₅` (the cubic collapses to one spectrum, Lemma
> L50), `P(W) = 3 tr(W³)` there and the certificate gives `|θ| ≤ √(3/2)` for every unit
> `W ∈ 𝒲₅`, with equality on the orbit of `W₀`; the equality set is not identified. The bound is
> on the whole sphere, and it is the one dimension at which the programme holds a complete
> certificate.

The block's own heading is the object: **`M(5)`, the global maximum on `𝒲₅`**, *not* `Θ₅`,
which is `2√2/3 = 0.9428`. The record files that confusion as warning **W5**, so the name is
carried carefully below: nothing here is called `Θ₅`.

**What [L61.lean](L61.lean) already carries and this file does not repeat**: the numerical
anchors of the certificate run. **What that file never states is the bound.** The bound and its
equality clause are typed here.

## What the `sorry` is

`F5_nonneg`, and only it: that `F₅ ≥ 0` on `𝒲₅`. That is the sum-of-squares certificate, and
the record is explicit about what it rests on (*"an SDP point lifted to `ℚ`), 47 Hermitian
parameters in a `ℚ(i)` highest-weight basis a reader must rebuild by machine before checking
anything"*, exact and **unverifiable by hand even in principle**. It is the record's own claim,
not a published one, so it stays a `sorry` rather than moving into a binder.

Everything the certificate is *for* is proved below: `bound_of_F5_nonneg` is the step from
`F₅ ≥ 0` to `|θ| ≤ √(3/2)`, and it is an equivalence rather than an implication, `F₅` being
exactly `(3/2)‖W‖⁶ − P²`.

## Two readings of `F₅`, and why only one is typed

The record writes `F₅ = (3/2)‖W‖⁶ − 9 tr(W³)²`; `F5` below is `(3/2)‖W‖⁶ − P(W)²`. **The two
agree on `𝒲₅` and only there**, by the record's Lemma L50, `⟨W, W#⟩ = 2 tr(W³)` on `𝒲₅`, whence
`P(W) = tr(W³) + 2 tr(W³) = 3 tr(W³)` and `P² = 9 tr(W³)²`. *That identification is L50's and is
`F5_eq_record` in [L61Witness.lean](L61Witness.lean)*; the `P` reading is the one the conclusion is
about, so it is the one carried.

## The equality clause, as the record states it and no further

The record's clause is **equality holds on the orbit of `W₀`**, with *"the equality set is not
identified"* said in the same sentence, and the reviewers add that no certificate of this shape
can identify it, `F₅` being even, so `Z(F₅)` always contains the orbit of `−W₀` as well.
`L61` below therefore states attainment (`IsGreatest`), which is what *"the global maximum is
`√(3/2)`"* means, and **does not** state that the equality set is that one orbit.

## Scope

The bound is at `n = 5`. `padding_scope` below records the direction the record insists on: the
*witness* transfers up, so `M(n) ≥ √(3/2)` at every `n ≥ 5`, while the *bound* transfers down
only, it is false at `n ≥ 12`, where `θ₀(12)² = 220/144 > 3/2`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L61Statement

open HamiltonsCubic.RealLayer

/-- Weyl tensors at `n = 5`, as operators on bivectors of `ℝ⁵`. -/
abbrev W5 := Matrix (Fin 5) (Fin 5) ℝ → Matrix (Fin 5) (Fin 5) ℝ

/-- **`F₅ = (3/2)‖W‖⁶ − P(W)²`**, the sextic the certificate is about. On `𝒲₅` this is the
record's `(3/2)‖W‖⁶ − 9 tr(W³)²`, by Lemma L50's `P = 3 tr(W³)`. -/
noncomputable def F5 (W : W5) : ℝ := 3 / 2 * normSq W ^ 3 - Pcubic W ^ 2

/-! ## The certificate

The one thing this file does not prove. -/

/-- **The sum-of-squares certificate**: `F₅ ≥ 0` on all of `𝒲₅`, critical or not.

*This is the exact rational SDP certificate of the block. `F₅` is homogeneous of degree `6`, so
the statement on the whole cone is the statement on the unit sphere; the record states it on the
sphere and the certificate proves it on the cone.* -/
theorem F5_nonneg (W : W5) (hW : IsWeyl W) : 0 ≤ F5 W := by
  sorry

/-! ## What the certificate buys, proved -/

/-- **The step from the certificate to the bound**, and it is reversible. For a unit `W`,
`F₅(W) ≥ 0` is exactly `|θ(W)| ≤ √(3/2)`.

*Two-sided because `F₅` is even in `W`: the certificate bounds `P²`, not `P`.* -/
theorem bound_of_F5_nonneg {W : W5} (hnorm : normSq W = 1) (h : 0 ≤ F5 W) :
    |Pcubic W| ≤ Real.sqrt (3 / 2) := by
  have hsq : Pcubic W ^ 2 ≤ 3 / 2 := by
    unfold F5 at h
    rw [hnorm] at h
    nlinarith
  calc |Pcubic W| = Real.sqrt (Pcubic W ^ 2) := (Real.sqrt_sq_eq_abs _).symm
    _ ≤ Real.sqrt (3 / 2) := Real.sqrt_le_sqrt hsq

/-- **And the converse**, which is why `F₅ ≥ 0` is the right object to certify: on the unit
sphere the bound gives the certificate back. -/
theorem F5_nonneg_of_bound {W : W5} (hnorm : normSq W = 1)
    (h : |Pcubic W| ≤ Real.sqrt (3 / 2)) : 0 ≤ F5 W := by
  have h2 : Pcubic W ^ 2 ≤ 3 / 2 := by
    nlinarith [sq_abs (Pcubic W), abs_nonneg (Pcubic W),
      Real.sq_sqrt (show (0:ℝ) ≤ 3 / 2 by norm_num),
      Real.sqrt_nonneg (3 / 2 : ℝ)]
  unfold F5
  rw [hnorm]
  nlinarith

/-! ## The bound on the whole sphere -/

/-- **The bound.** `|θ| ≤ √(3/2)` for every unit `W ∈ 𝒲₅`, critical or not, the record's *"the
bound is on the whole sphere"*. -/
theorem L61_bound (W : W5) (hW : IsWeyl W) (hnorm : normSq W = 1) :
    |Pcubic W| ≤ Real.sqrt (3 / 2) :=
  bound_of_F5_nonneg hnorm (F5_nonneg W hW)

/-! ## The statement itself: `M(5) = √(3/2)` -/

/-- **L61.** `√(3/2)` is the **greatest** value of `P` on the unit sphere of `𝒲₅`, the global
maximum `M(5)`.

*The attainment half is the witness `hW₀`, built in [L61Witness.lean](L61Witness.lean) as `Wc 5`
(`M5_attained`, and `L61_M5` is this theorem with it discharged): `W₀`, the zero-padding of `W_{ℂP²}` into
`𝒲₅`, is a unit Weyl tensor with `P(W₀) = √(3/2)`
([Nienhaus](../../../references/nienhaus-2023-second-best-einstein/notes.md) Thm 4.14(a) at
`n = 4`, then zero-padding). The bound half is `L61_bound`, which rests on `F5_nonneg`.*

**The record's *"with equality on the orbit of `W₀`"* is the attainment clause and nothing more:
the equality set is not identified here, because the record does not identify it either.** -/
theorem L61 (hW₀ : ∃ W : W5, IsWeyl W ∧ normSq W = 1 ∧ Pcubic W = Real.sqrt (3 / 2)) :
    IsGreatest {t : ℝ | ∃ W : W5, IsWeyl W ∧ normSq W = 1 ∧ Pcubic W = t}
      (Real.sqrt (3 / 2)) := by
  obtain ⟨W₀, hW₀weyl, hW₀norm, hW₀P⟩ := hW₀
  constructor
  · exact ⟨W₀, hW₀weyl, hW₀norm, hW₀P⟩
  · rintro t ⟨W, hW, hnorm, rfl⟩
    exact le_of_abs_le (L61_bound W hW hnorm)

/-! ## Non-vacuity, and scope

The set `L61` takes the greatest element of is non-empty by the witness `M5_attained` of
[L61Witness.lean](L61Witness.lean); below is the cheaper check that `𝒲₅` itself is inhabited, so the quantifier in
`L61_bound` is not empty. -/

/-- **The zero operator is a Weyl tensor**, so `IsWeyl` is inhabited at `n = 5` and the
universally quantified `L61_bound` is not vacuous. *It is not a point of the unit sphere; the
unit witness is `Wc 5`, in [L61Witness.lean](L61Witness.lean).* -/
theorem zero_isWeyl : IsWeyl (fun _ => 0 : W5) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro X _; simp [IsSkew]
  · intro X Y _ _; simp [inner2]
  · intro i j k l; simp [bianchi, inner2]
  · intro a b; simp [Ric, inner2]

/-- **The bound transfers down only.** At `n = 12` the sphere-product value already exceeds
`√(3/2)`: `θ₀(12)² = 220/144 > 3/2`. So `L61` licenses nothing at `n ≥ 12` beyond the statement
that no maximiser there has five-dimensional support. -/
theorem padding_scope : (3 : ℝ) / 2 < 2 * (12 - 1) * (12 - 2) / (12 : ℝ) ^ 2 := by norm_num

end HamiltonsCubic.L61Statement
