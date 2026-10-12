import Mathlib

set_option linter.style.longLine false

/-!
# L90, evaluation is injective on the image, STATED

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L90, quoted verbatim:

> **Why `40` equations give an identity, which is the load-bearing step and was nowhere in the
> record.** Satisfying the map's equations at `40` points is agreement of polynomials at `40`
> places, not equality, unless evaluation is injective on the image. Writing `μ` for the
> Gram-to-sextic map and `ev` for evaluation, `ker(ev ∘ μ) ⊇ ker μ` always, while
> `rank(ev ∘ μ) = 13 = rank μ` is measured at four primes. Equal dimensions force equal kernels,
> so `ev` is injective on the image and a sextic there is pinned by those `40` values. `F₅` lies
> in the image, so the unique element agreeing with it at those points **is** `F₅`.

together with the audit's replacement of the printed route:

> **THE STATED PROOF ASSUMES WHAT IT PROVES.** It argues from *"`rank(ev ∘ μ) = 13 = rank μ` is
> measured at four primes"*, **only the first is measured, and sampling's inequality runs
> `rank(ev ∘ μ) ≤ rank μ`, from the measured side to the unmeasured one.**
>
> **THE REPAIR SITS TWELVE LINES BELOW, UNUSED.** Importing [L62](../../../findings/sym3-blocks.md)'s
> order-1 cap gives `13 ≤ rank(ev ∘ μ) ≤ rank μ ≤ 13`, **one measurement and one theorem, not
> two measurements**.

## What is typed, and it is the conclusion rather than the argument

`L90` below is `Set.InjOn ev (range μ)` (evaluation injective on the image) and its corollary
`pinned`, that an element of the image is determined by its `ev`-values. The route is the
repaired one: `rank_squeeze` runs the two inequalities in the directions they actually hold,
`ker_comp_eq_of_finrank_range_eq` turns the rank equality into the kernel equality (rank–nullity
plus `Submodule.eq_of_le_of_finrank_eq`, the step the record calls *"equal dimensions force equal
kernels"*), and `injOn_of_ker_eq` finishes.

## What is NOT typed here

**The concrete instance.** `μ` is the multiplication map carrying an invariant Gram on the
restricted cubics `K ⊆ Sym³𝒲₅` to its sextic, `ev` is evaluation at the `40` stored orbit points,
and neither is constructed here, `𝒲₅`, `Sym³`, the `O(5)`-action and the point list are all
absent, so this file types L90 over an interface rather than at its object.

**The two numbers.** `rank(ev ∘ μ) = 13`, exact over `ℚ` at four primes, is a measurement of the
record; `rank μ ≤ 13` is [L62](../../../findings/sym3-blocks.md)'s order-1 cap. They enter
`L90` as named hypotheses `hmeasured` and `hcap` because they are inputs L90's proof consumes
from elsewhere, and neither is L90's own conclusion. **A reader checking this file against the
record must check those two elsewhere.**

**`F₅ ∈ image μ`.** The last sentence of the record's block, that `F₅` lies in the image, so the
element agreeing with it at the `40` points is `F₅` itself, is a fact about `F₅` and the
certificate, not about injectivity; `pinned_of_mem` states the implication with membership as a
hypothesis and does not establish it.
-/

namespace HamiltonsCubic.L90Statement

open Module

variable {K V W X : Type*} [Field K]
  [AddCommGroup V] [Module K V] [AddCommGroup W] [Module K W] [AddCommGroup X] [Module K X]

/-! ## The kernel inclusion that always holds -/

/-- `ker μ ⊆ ker (ev ∘ μ)`, with no hypothesis, the containment the record notes is free. -/
theorem ker_le_ker_comp (μ : V →ₗ[K] W) (ev : W →ₗ[K] X) :
    LinearMap.ker μ ≤ LinearMap.ker (ev ∘ₗ μ) := by
  intro x hx
  simp only [LinearMap.mem_ker, LinearMap.coe_comp, Function.comp_apply] at *
  rw [hx, map_zero]

/-! ## Equal ranks force equal kernels -/

/-- **"Equal dimensions force equal kernels."** Rank–nullity turns the rank equality into equal
kernel dimensions, and a containment of subspaces at equal finite dimension is an equality. -/
theorem ker_comp_eq_of_finrank_range_eq [FiniteDimensional K V] (μ : V →ₗ[K] W) (ev : W →ₗ[K] X)
    (h : finrank K (LinearMap.range (ev ∘ₗ μ)) = finrank K (LinearMap.range μ)) :
    LinearMap.ker (ev ∘ₗ μ) = LinearMap.ker μ := by
  have h1 : finrank K (LinearMap.range (ev ∘ₗ μ)) + finrank K (LinearMap.ker (ev ∘ₗ μ))
      = finrank K V := LinearMap.finrank_range_add_finrank_ker _
  have h2 : finrank K (LinearMap.range μ) + finrank K (LinearMap.ker μ) = finrank K V :=
    LinearMap.finrank_range_add_finrank_ker _
  have hdim : finrank K (LinearMap.ker μ) = finrank K (LinearMap.ker (ev ∘ₗ μ)) := by omega
  exact (Submodule.eq_of_le_of_finrank_eq (ker_le_ker_comp μ ev) hdim).symm

/-- **Equal kernels make `ev` injective on the image**, which is the conclusion L90 names. -/
theorem injOn_of_ker_eq (μ : V →ₗ[K] W) (ev : W →ₗ[K] X)
    (h : LinearMap.ker (ev ∘ₗ μ) = LinearMap.ker μ) :
    Set.InjOn ev (LinearMap.range μ) := by
  rintro _ ⟨a, rfl⟩ _ ⟨b, rfl⟩ hab
  have hmem : a - b ∈ LinearMap.ker (ev ∘ₗ μ) := by
    simp only [LinearMap.mem_ker, LinearMap.coe_comp, Function.comp_apply, map_sub]
    rw [hab, sub_self]
  rw [h, LinearMap.mem_ker, map_sub, sub_eq_zero] at hmem
  exact hmem

/-! ## The repaired route: one measurement and one theorem -/

/-- **`13 ≤ rank(ev ∘ μ) ≤ rank μ ≤ 13`.** The measurement bounds the composite from below, the
free inequality carries it to `rank μ`, and [L62](../../../findings/sym3-blocks.md)'s order-1 cap
closes from above, so the two ranks are equal without a second measurement. -/
theorem rank_squeeze {a b : ℕ} (hmeasured : a = 13) (hsampling : a ≤ b) (hcap : b ≤ 13) :
    a = b := by omega

/-! ## The statement -/

/-- **L90.** Let `μ` be the Gram-to-sextic map and `ev` evaluation at the sample points. If the
composite's rank is the measured `13` and `rank μ` is at most [L62](../../../findings/sym3-blocks.md)'s
order-1 cap `13`, then **`ev` is injective on the image of `μ`**.

*The rank of the composite is the measured quantity and the cap is the imported theorem; the
free inequality `rank(ev ∘ μ) ≤ rank μ` (which the withdrawn argument ran backwards), is
supplied here by `Submodule.finrank_map_le` rather than assumed.* -/
theorem L90 [FiniteDimensional K V] (μ : V →ₗ[K] W) (ev : W →ₗ[K] X)
    (hmeasured : finrank K (LinearMap.range (ev ∘ₗ μ)) = 13)
    (hcap : finrank K (LinearMap.range μ) ≤ 13) :
    Set.InjOn ev (LinearMap.range μ) := by
  have hsampling : finrank K (LinearMap.range (ev ∘ₗ μ)) ≤ finrank K (LinearMap.range μ) := by
    rw [LinearMap.range_comp]
    exact Submodule.finrank_map_le ev (LinearMap.range μ)
  exact injOn_of_ker_eq μ ev
    (ker_comp_eq_of_finrank_range_eq μ ev (rank_squeeze hmeasured hsampling hcap))

/-- **"A sextic there is pinned by those `40` values."** Two elements of the image agreeing under
`ev` are equal, the corollary that turns agreement at the sample points into an identity. -/
theorem pinned_of_mem [FiniteDimensional K V] (μ : V →ₗ[K] W) (ev : W →ₗ[K] X)
    (hmeasured : finrank K (LinearMap.range (ev ∘ₗ μ)) = 13)
    (hcap : finrank K (LinearMap.range μ) ≤ 13)
    {F G : W} (hF : F ∈ LinearMap.range μ) (hG : G ∈ LinearMap.range μ) (h : ev F = ev G) :
    F = G :=
  L90 μ ev hmeasured hcap hF hG h

/-! ## The hypotheses are inhabited

The two rank conditions can hold together, so `L90` is not vacuous: the identity on a
`13`-dimensional space realises both, and `ev` is then injective outright. -/

example : ∃ (μ : (Fin 13 → ℚ) →ₗ[ℚ] (Fin 13 → ℚ)) (ev : (Fin 13 → ℚ) →ₗ[ℚ] (Fin 13 → ℚ)),
    finrank ℚ (LinearMap.range (ev ∘ₗ μ)) = 13 ∧ finrank ℚ (LinearMap.range μ) ≤ 13 := by
  refine ⟨LinearMap.id, LinearMap.id, ?_, ?_⟩
  · rw [LinearMap.id_comp, LinearMap.range_id, finrank_top]
    simp
  · rw [LinearMap.range_id, finrank_top]
    simp

/-! ## The direction the withdrawn argument ran backwards

Sampling gives `rank(ev ∘ μ) ≤ rank μ`. Knowing the left side alone leaves the right side free
above it, so the printed proof could not reach `rank μ = 13` from its own measurement. -/

theorem sampling_runs_one_way : ∃ a b : ℕ, a ≤ b ∧ a = 13 ∧ b ≠ 13 :=
  ⟨13, 14, by omega, rfl, by omega⟩

end HamiltonsCubic.L90Statement
