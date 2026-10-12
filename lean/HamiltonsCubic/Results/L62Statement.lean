import Mathlib

set_option linter.style.longLine false

/-!
# L62, `dim ann = 1`, so the rank is `13`

## The record's statement, verbatim

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s *Lemma L62, `dim ann = 1`, so the rank is
`13`*:

> Order-$1$ vanishing at $W_0$ caps the restricted rank at $13$: a product of two cubics of $K$
> vanishes at $W_0$, and evaluation there is a nonzero functional on the $14$. A sampled rank is
> bounded above by the true one, and reducing modulo $p$ can only lower it further --- the $40$
> evaluation points being exact rationals fixed before any prime is chosen, so what is reduced is
> the reduction of a rational matrix --- so a sampled rank *attaining* $13$ forces equality. It
> attains it, at four primes, and exactly over $\mathbb Q$. Hence $\dim\mathrm{ANN}=1$, spanned by
> $A(W_0^6)$, and $F_5\perp\mathrm{ANN}$.

with, from the same block's round,

> $\lVert W\rVert^6$ is an invariant sextic with $\lVert W_0\rVert^6=1$, so evaluation at $W_0$ is
> a **nonzero** functional on [L85](sym3-blocks.md)'s $14$; every product of two cubics of $K$
> vanishes at $W_0$, so the image lies in its kernel, of dimension $13$.

and

> $\operatorname{rank}_{\mathbb F_p}\le\operatorname{rank}_{\mathbb Q}\le\operatorname{rank}(\mathrm{ev}_{40}\circ\mu_K)\le\operatorname{rank}(\mu_K)\le13$.
> **Attaining the cap collapses it**, so $\dim\mathrm{ANN}=1$ and $F_5\in\operatorname{image}$
> follow. [...] **One prime already closes the squeeze**, a mod-$p$ rank of $13$ forcing $\ge13$
> over $\mathbb Q$ against the derived cap of $\le13$.

## How this is typed

Three separable pieces, all proved here with no `sorry`:

1. **The cap `rank(μ_K) ≤ 13`**, which the round calls *"a theorem, in six lines"*: the image of
   `μ_K` lies in the kernel of a nonzero linear functional on a `14`-dimensional space.
2. **The squeeze**, as the chain of five `ℕ`-inequalities with the mod-`p` rank equal to `13` at
   one end and the derived cap at the other. It collapses every link to `13`. *The record's four
   primes are redundancy, not four inequalities, one closes it, which is what is typed.*
3. **The consequence**, read through [L59](L59Statement.lean)'s rank equation
   `rank + dim ANN = 14`: `dim ANN = 1`, and `F₅ ⊥ ANN` once `ANN` is spanned by a single element
   that `F₅` pairs to zero against.

The rank equation is consumed in its **additive** form. `finrank` lands in `ℕ`, where `14 - r`
is truncated; the addition carries the same content and cannot be true for the wrong reason.

## What is NOT typed here

**Everything that identifies the objects.** `𝒲₅ = V_{(2,2)}`, the `14` invariant sextics,
`W₀` as the padded `W_{ℂP²}`, `K` as the orbit-constraint span, the apolarity operator
`A(W₀⁶)`, and `F₅ = (3/2)‖W‖⁶ − 9 tr(W³)²` have no Lean layer here, so the space `V`, the map
`muK`, the functional `ev` and the elements `g` and `F5` are free below.

**The rank-`13` measurement itself.** *"It attains it, at four primes, and exactly over `ℚ`"* is
a machine computation on a `40 × 47` matrix over `𝔽_p`; it enters below as the hypothesis
`hp : rankFp = 13`, which is the honest placement, the squeeze is what L62 proves, and the
measurement is its input.

**The `HYPOTHESIS-DEBT` the round names**: that `image(μ̃_K) = image(μ_K)`, the `11` extra
Hermitian directions costing no rank. That is a statement about the complexification of the
sampled matrix and is not represented here at all.
-/

namespace HamiltonsCubic.L62Statement

open Submodule

variable {B V : Type*} [AddCommGroup B] [Module ℝ B] [AddCommGroup V] [Module ℝ V]

/-! ## The cap: order-`1` vanishing at `W₀` puts the image inside a hyperplane -/

/-- **A nonzero functional on a `14`-dimensional space has a `13`-dimensional kernel.** -/
theorem finrank_ker_of_ne_zero [FiniteDimensional ℝ V] (ev : V →ₗ[ℝ] ℝ) (hev : ev ≠ 0)
    (hV : Module.finrank ℝ V = 14) :
    Module.finrank ℝ (LinearMap.ker ev) = 13 := by
  have hsurj : LinearMap.range ev = ⊤ := by
    rw [LinearMap.range_eq_top]
    intro c
    obtain ⟨x, hx⟩ : ∃ x, ev x ≠ 0 := by
      by_contra hcon
      push Not at hcon
      exact hev (LinearMap.ext hcon)
    exact ⟨(c / ev x) • x, by rw [map_smul, smul_eq_mul, div_mul_cancel₀ _ hx]⟩
  have hrn := LinearMap.finrank_range_add_finrank_ker ev
  rw [hsurj, hV] at hrn
  simp only [finrank_top, Module.finrank_self] at hrn
  omega

/-- **THE CAP.** *"Every product of two cubics of `K` vanishes at `W₀`, so the image lies in its
kernel, of dimension `13`."* -/
theorem rank_le_thirteen [FiniteDimensional ℝ V] (muK : B →ₗ[ℝ] V) (ev : V →ₗ[ℝ] ℝ)
    (hev : ev ≠ 0) (hV : Module.finrank ℝ V = 14)
    (hvanish : ∀ b : B, ev (muK b) = 0) :
    Module.finrank ℝ (LinearMap.range muK) ≤ 13 := by
  have hle : LinearMap.range muK ≤ LinearMap.ker ev := by
    rintro _ ⟨b, rfl⟩
    exact hvanish b
  calc Module.finrank ℝ (LinearMap.range muK)
      ≤ Module.finrank ℝ (LinearMap.ker ev) := Submodule.finrank_mono hle
    _ = 13 := finrank_ker_of_ne_zero ev hev hV

/-! ## The squeeze: attaining the cap collapses it -/

/-- **THE SQUEEZE.** With `rank_{𝔽ₚ} ≤ rank_ℚ ≤ rank(ev₄₀ ∘ μ_K) ≤ rank(μ_K) ≤ 13` and a mod-`p`
rank of `13`, every link is `13`. *One prime closes it; the record's four share one seed, one
point set and one code path, so they add no inequality.* -/
theorem squeeze (rankFp rankQ rankSample rankTrue : ℕ)
    (h1 : rankFp ≤ rankQ) (h2 : rankQ ≤ rankSample) (h3 : rankSample ≤ rankTrue)
    (h4 : rankTrue ≤ 13) (hp : rankFp = 13) :
    rankFp = 13 ∧ rankQ = 13 ∧ rankSample = 13 ∧ rankTrue = 13 := by
  omega

/-! ## The consequence, through L59's rank equation -/

/-- **`dim ANN = 1`.** Given [L59](L59Statement.lean)'s `rank(μ_K) + dim ANN = 14` and the value
`rank(μ_K) = 13` that the squeeze delivers. -/
theorem dim_ann_eq_one (rank dimAnn : ℕ) (hL59 : rank + dimAnn = 14) (hrank : rank = 13) :
    dimAnn = 1 := by omega

/-- **The whole chain at once**: the derived cap, the measured mod-`p` rank, and L59's equation
give `rank(μ_K) = 13` and `dim ANN = 1`. -/
theorem rank_thirteen_and_ann_one
    (rankFp rankQ rankSample rank dimAnn : ℕ)
    (hcap : rank ≤ 13)
    (h1 : rankFp ≤ rankQ) (h2 : rankQ ≤ rankSample) (h3 : rankSample ≤ rank)
    (hp : rankFp = 13)
    (hL59 : rank + dimAnn = 14) :
    rank = 13 ∧ dimAnn = 1 := by omega

/-! ## `F₅ ⊥ ANN`

*"`dim ANN = 1`, spanned by `A(W₀⁶)`"*, so orthogonality to the whole of `ANN` is one pairing
against one element. -/

/-- **`F₅ ⊥ ANN` from a single pairing.** Once `ANN` is the span of `g`, `⟪F₅, g⟫ = 0` gives
`F₅ ⊥ ANN`, and by [L59](L59Statement.lean)'s second display that is `F₅ ∈ image(μ_K)`. -/
theorem orthogonal_span_singleton {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]
    (F5 g : W) (hg : (inner ℝ F5 g : ℝ) = 0) :
    ∀ x ∈ Submodule.span ℝ ({g} : Set W), (inner ℝ F5 x : ℝ) = 0 := by
  intro x hx
  rw [Submodule.mem_span_singleton] at hx
  obtain ⟨c, rfl⟩ := hx
  rw [real_inner_smul_right, hg, mul_zero]

/-! ## Non-vacuity

The cap's hypotheses are satisfiable, so the statement is not empty. -/

/-- **A witness for the cap**: on `EuclideanSpace ℝ (Fin 14)`, the first coordinate functional is
nonzero and the zero map into it vanishes against it, so the cap reads `0 ≤ 13`. -/
example :
    Module.finrank ℝ (EuclideanSpace ℝ (Fin 14)) = 14 ∧
      (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 14)).toLinearMap ≠ 0 := by
  refine ⟨by simp, ?_⟩
  intro h
  have := congrArg (fun f => f (EuclideanSpace.single (0 : Fin 14) (1 : ℝ))) h
  simp at this

end HamiltonsCubic.L62Statement
