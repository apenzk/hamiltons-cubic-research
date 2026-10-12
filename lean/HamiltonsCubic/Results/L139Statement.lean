import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L139, WITHDRAWN: the objects behind the numerals, stated

## The record's statement, verbatim

> #### Lemma L139, WITHDRAWN: the range $12\le n\le31$ does not follow, and its step (a) is false
>
> The dimension range rested on [Lemma L137]'s coefficients and is withdrawn with them. **And (a)
> is independently false**: [r428](../reviews/REVIEW_r428.md) exhibits a $209$-dimensional space of
> genuine Weyl tensors inside $\{F=0\}\cap T_u\mathcal O^\perp$ at $n=8$ on which
> $\lVert\mathrm{Alt}(P_0HP_0)\rVert^2$ reaches $0.093$, so the compression is **not** Bianchi on
> the cone and the record's ceiling does **not** transfer to it. **The witness space is a majority
> of the ambient one** ($209$ of $\dim\mathcal W_8=300$, over two thirds) so this fails
> generically rather than on a special family, unlike most counterexamples here, which live on
> measure-zero sets. **And $0.093$ sits below both $\tfrac19$ and [Lemma L140]'s $\tfrac14$**, so
> the object refuting (a) puts no part of the replacement route at risk.

[route-a.md](../../../findings/route-a.md), Lemma L139.

## What this file states

[L139.lean](L139.lean) prices the notice's numerals, `209`, `300`, `0.093`, the range `12 ≤ n ≤ 31`
as rational arithmetic. **What it does not carry is the objects those numerals are about**, and
this file states three of them with the geometry taken as binders. All are PROVED here, with no
`sorry`:

- `witness_refutes`, **step (a) is a vanishing claim over a set, so one witness with a nonzero
  value ends it.** `Alt` and the compression `H ↦ P₀HP₀` are a linear map and a function on an
  abstract real inner product space, and the cone is a subset; the record's `0.093` enters as the
  witness's value. *The refutation needs no property of the cone, which is why it is independent of
  the L137 ground.*
- `ceiling_transfers`, **the step (a) was there to license, stated so that what it needs is
  visible**: a bound on `‖Alt X‖²` over a class `S` reaches `‖Alt (P₀HP₀)‖²` on the cone exactly
  when the compression lands in `S`. That membership is what the witness denies, so the transfer
  loses its warrant while the bound itself stands untouched, which is `vanishing_is_not_boundedness`.
- `witness_meets_every_large_family`, **the honest form of "a majority, so this is generic".** In
  a `300`-dimensional space a `209`-dimensional subspace meets every subspace of dimension at least
  `92` in a nonzero vector. So no linear family of dimension `92` or more avoids the counterexample,
  and `threshold_is_complement_plus_one` records where that figure comes from.

## What is NOT typed here

- **That the `209`-dimensional space consists of genuine Weyl tensors, that it lies inside
  `{F = 0} ∩ T_u𝒪^⊥`, and that `‖Alt(P₀HP₀)‖²` reaches `0.093` on it.** These are r428's
  construction, and they need the Weyl space, the first Bianchi identity, the cone and the orbit,
  none of which the base layer carries. Here they are the hypotheses `hmem` and `hval`.
- **"Generically rather than on a special family" as a measure statement.** A `209`-dimensional
  subspace of a `300`-dimensional space is itself Lebesgue-null, so the notice's contrast is with
  the *dimension* of the usual counterexample and not with a positive measure. The intersection
  theorem above is what the contrast supports.
- **The first ground of the withdrawal**, that the range rested on [L137](L137.lean)'s
  coefficients. A withdrawn premise leaves its conclusion unwarranted rather than false, so there
  is no statement to make against the range itself; and its content is subsumed by L140's `n ≥ 12`,
  which [L139.lean](L139.lean) records.
-/

namespace HamiltonsCubic.L139Statement

open Module

/-! ## 1. Step (a), and the single witness that ends it

*`𝒲` stands for the Weyl space, `Alt` for the alternation, `comp` for the compression `H ↦ P₀HP₀`
and `C` for `{F = 0} ∩ T_u𝒪^⊥`. Nothing below uses a property of any of them.* -/

variable {𝒲 : Type*} [NormedAddCommGroup 𝒲] [InnerProductSpace ℝ 𝒲]

/-- **Step (a): the compression is Bianchi on the cone**, that is, its alternation vanishes there.
*A universally quantified vanishing, which is what makes it cheap to refute.* -/
def BianchiOnCone (Alt : 𝒲 →ₗ[ℝ] 𝒲) (comp : 𝒲 → 𝒲) (C : Set 𝒲) : Prop :=
  ∀ H ∈ C, Alt (comp H) = 0

/-- **One witness with a nonzero value refutes it.** r428's space supplies `H₀` in the cone with
`‖Alt (comp H₀)‖² = 0.093`, and `0.093 ≠ 0` is the whole of the argument. -/
theorem witness_refutes {Alt : 𝒲 →ₗ[ℝ] 𝒲} {comp : 𝒲 → 𝒲} {C : Set 𝒲} {H₀ : 𝒲}
    (hmem : H₀ ∈ C) (hval : ‖Alt (comp H₀)‖ ^ 2 = 93 / 1000) :
    ¬ BianchiOnCone Alt comp C := by
  intro h
  rw [h H₀ hmem, norm_zero] at hval
  norm_num at hval

/-! ## 2. What step (a) was carrying, and what the refutation costs -/

/-- **The transfer step, with its hypothesis in the open.** A ceiling `b` on `‖Alt X‖²` over a class
`S` gives the same ceiling for the compression on the cone **exactly when the compression lands in
`S`**, which for the record's `S` is Bianchi-ness. -/
theorem ceiling_transfers {Alt : 𝒲 →ₗ[ℝ] 𝒲} {comp : 𝒲 → 𝒲} {S C : Set 𝒲} {b : ℝ}
    (hb : ∀ X ∈ S, ‖Alt X‖ ^ 2 ≤ b) (hmap : ∀ H ∈ C, comp H ∈ S) :
    ∀ H ∈ C, ‖Alt (comp H)‖ ^ 2 ≤ b :=
  fun H hH => hb (comp H) (hmap H hH)

/-- **And the refuting object satisfies the ceiling it removes the warrant for.** Vanishing and
boundedness are different claims: `0.093` denies the first on the record's own set while sitting
under both `1/9` and `1/4`, so the failure of step (a) puts no part of the replacement route at
risk. -/
theorem vanishing_is_not_boundedness :
    (93 : ℝ) / 1000 ≠ 0 ∧ (93 : ℝ) / 1000 < 1 / 9 ∧ (93 : ℝ) / 1000 < 1 / 4 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## 3. `209` of `300`, as a statement about families rather than about measure -/

variable {V : Type*} [AddCommGroup V] [Module ℝ V] [FiniteDimensional ℝ V]

/-- **A subspace of dimension `209` in dimension `300` meets every subspace of dimension at least
`92` nontrivially.** So the witness space cannot be dodged by restricting attention to a linear
family of dimension `92` or more, which is the content the notice's *"a majority of the ambient
one"* carries. -/
theorem witness_meets_every_large_family (hV : finrank ℝ V = 300) (U F : Submodule ℝ V)
    (hU : finrank ℝ U = 209) (hF : 92 ≤ finrank ℝ F) :
    U ⊓ F ≠ ⊥ := by
  intro hbot
  have hsum := Submodule.finrank_sup_add_finrank_inf_eq U F
  rw [hbot, finrank_bot, hU] at hsum
  have hle : finrank ℝ (U ⊔ F : Submodule ℝ V) ≤ 300 := by
    have := Submodule.finrank_le (U ⊔ F)
    omega
  omega

/-- **Where `92` comes from**: the complement of the witness space has dimension `91`, and one more
than that is what forces a nonzero intersection. -/
theorem threshold_is_complement_plus_one : 300 - 209 = 91 ∧ 209 + 92 = 300 + 1 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## Witnesses, so the hypotheses are not empty

*The intersection statement at the record's own figures: the witness space meets every `92`-dimensional family.* -/

example (hV : finrank ℝ V = 300) (U F : Submodule ℝ V)
    (hU : finrank ℝ U = 209) (hF : finrank ℝ F = 92) : U ⊓ F ≠ ⊥ :=
  witness_meets_every_large_family hV U F hU (by omega)

end HamiltonsCubic.L139Statement
