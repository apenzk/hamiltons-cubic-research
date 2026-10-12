import Mathlib

set_option linter.style.longLine false

/-!
# L59, the certificate's necessary condition is one dimension count

## The record's statement, verbatim

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s *Lemma L59, the certificate's necessary
condition is one dimension count*:

> Let $K$ be the span cut out by the orbit constraint and let $\mathrm{ANN}$ be the invariant
> sextics $F$ with $\mathrm{Cat}_F(K,K)=0$. Apolarity gives
> $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, so, for $\mu_K$ the restriction of
> $\mu$ to the invariants supported on $K$,
> $$\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN},\qquad F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN}.$$
> $\mathrm{Cat}$ is injective on the invariant sextics --- the unrestricted $\mu$ is surjective,
> so its adjoint is injective --- placing a copy of the $14$ inside the $65$ invariant symmetric
> forms on $\mathrm{Sym}^3$. The forms vanishing on $K\times K$ number $29$, counted block by
> block: an odd-$\lambda_2$ block dies entirely, $K$ containing all of $M_\lambda$; an even one
> keeps $u\otimes v+v\otimes u$, $K$ having codimension $1$ there. So $65=36+29$ splits the
> invariant forms into those supported on $K$ --- the unknowns --- and those killing
> $K\times K$.

with, from the same block's audit, the block-by-block arithmetic both reviewers rebuilt by hand:

> $8+3+10+8=29$, $65=20+6+27+12$, $36=20+16$, the shape *two $3\times3$, five $2\times2$, nine
> scalars*, and all eight dying blocks. **Even blocks carry $29$ of the $41$ multiplicities, odd
> carry $12$.**

## How this is typed

The lemma's mathematical content is a statement of finite-dimensional linear algebra with an
inner product, and that is exactly how it is typed: a linear map `muK : B →ₗ[ℝ] V` into a
`14`-dimensional inner product space `V` of invariant sextics, together with its adjoint `Cat`,
presented by **the adjunction itself**, `⟪F, muK b⟫ = ⟪Cat F, b⟫`, which the audit records is
*"the definition of the adjoint, not a theorem"*. `ANN` is `ker Cat`, and the audit's correction
that *"`ANN` is the adjoint's kernel, not `μ`'s"* is what makes that the right definition.

**The pairing is left abstract**, which is the block's own recorded defect (*"the pairing is
never named, and that is the defect"*). The two conclusions are scale-free, so any inner product
on `V` and on `B` compatible with the adjunction gives them; nothing below picks a normalisation.

**The rank equation is stated as an addition, `rank + dim ANN = 14`, rather than as the
subtraction `14 - dim ANN`**, because `finrank` lands in `ℕ` where subtraction is truncated and
the subtracted form would be true for the wrong reason if `dim ANN` ever exceeded `14`.

## What is NOT typed here

**The identification of `V` with the invariant sextics and of `K` with the orbit-constraint
span.** `Sym³𝒲₅`, the `O(5)`-invariants, the Weyl-integration `14` of
[L85](../../../findings/sym3-blocks.md), the catalecticant `Cat_F` as a bilinear form, and `F₅`
as the specific sextic `(3/2)‖W‖⁶ − 9 tr(W³)²` all lack a Lean layer here, the real Weyl layer
carries `IsWeyl`, `Pcubic`, `theta` and no symmetric-power or invariant-theory apparatus. So
`V`, `B`, `muK`, `Cat` and the element `F₅` are free below, and what is proved is everything the
block derives from the adjunction.

**The step the audit calls genuinely absent**, passing from *"`Cat_F` kills every **invariant**
form on `K`"* to *"`Cat_F(K,K)=0`"*, which needs equivariance plus isotypic pairing. That is a
statement about the `O(5)`-action, which is not in scope.

**The `29` and the `36` as block counts.** Their *arithmetic* is checked below; that the blocks
have those multiplicities is representation theory of `Sym³` under `O(5)`.
-/

namespace HamiltonsCubic.L59Statement

open Submodule FiniteDimensional

variable {B V : Type*}
  [NormedAddCommGroup B] [InnerProductSpace ℝ B]
  [NormedAddCommGroup V] [InnerProductSpace ℝ V]

local notation "⟪" x ", " y "⟫" => (inner ℝ x y : ℝ)

/-! ## The apolarity adjunction, and what it says about `ANN`

*"`ANN` is the adjoint's kernel, not `μ`'s"*, so the first thing to prove is that the kernel of
`Cat` is the orthogonal complement of the image of `μ_K`. -/

/-- **`ANN = image(μ_K)^⊥`.** The annihilator of the image, computed from the adjunction alone.
*This is the audit's correction made precise: `ker Cat` is a subspace of the sextics `V`, where
`ker μ_K` is a subspace of the forms `B`, and the two are not comparable.* -/
theorem ker_adj_eq_range_orthogonal (muK : B →ₗ[ℝ] V) (Cat : V →ₗ[ℝ] B)
    (hadj : ∀ (F : V) (b : B), ⟪F, muK b⟫ = ⟪Cat F, b⟫) :
    LinearMap.ker Cat = (LinearMap.range muK)ᗮ := by
  ext F
  constructor
  · intro hF
    rw [Submodule.mem_orthogonal']
    rintro _ ⟨b, rfl⟩
    rw [hadj F b, LinearMap.mem_ker.mp hF]
    simp
  · intro hF
    rw [LinearMap.mem_ker]
    have hzero : ∀ b : B, ⟪Cat F, b⟫ = 0 := by
      intro b
      rw [← hadj F b]
      exact (Submodule.mem_orthogonal' _ _).mp hF _ ⟨b, rfl⟩
    have := hzero (Cat F)
    exact inner_self_eq_zero.mp this

/-! ## The two conclusions -/

/-- **`rank(μ_K) = 14 − dim ANN`**, stated as `rank(μ_K) + dim ANN = 14`. -/
theorem rank_add_dim_ann [FiniteDimensional ℝ V] (muK : B →ₗ[ℝ] V) (Cat : V →ₗ[ℝ] B)
    (hadj : ∀ (F : V) (b : B), ⟪F, muK b⟫ = ⟪Cat F, b⟫)
    (hV : Module.finrank ℝ V = 14) :
    Module.finrank ℝ (LinearMap.range muK) + Module.finrank ℝ (LinearMap.ker Cat) = 14 := by
  rw [ker_adj_eq_range_orthogonal muK Cat hadj, ← hV]
  exact (LinearMap.range muK).finrank_add_finrank_orthogonal

/-- **`F₅ ∈ image(μ_K) ⟺ F₅ ⊥ ANN`**, the block's second display. -/
theorem mem_range_iff_orthogonal_ann [FiniteDimensional ℝ V] (muK : B →ₗ[ℝ] V) (Cat : V →ₗ[ℝ] B)
    (hadj : ∀ (F : V) (b : B), ⟪F, muK b⟫ = ⟪Cat F, b⟫) (F5 : V) :
    F5 ∈ LinearMap.range muK ↔ ∀ G ∈ LinearMap.ker Cat, ⟪F5, G⟫ = 0 := by
  rw [ker_adj_eq_range_orthogonal muK Cat hadj]
  constructor
  · intro hF5 G hG
    rw [real_inner_comm]
    exact (Submodule.mem_orthogonal' _ _).mp hG _ hF5
  · intro h
    have : F5 ∈ (LinearMap.range muK)ᗮᗮ := by
      rw [Submodule.mem_orthogonal]
      intro G hG
      rw [real_inner_comm]
      exact h G hG
    rwa [Submodule.orthogonal_orthogonal] at this

/-- **`Cat` is injective on the invariant sextics**, from the surjectivity of the unrestricted
`μ`: an adjoint of a surjection is injective. *This is what places a copy of the `14` inside the
`65`.* -/
theorem cat_injective_of_mu_surjective (mu : B →ₗ[ℝ] V) (Cat : V →ₗ[ℝ] B)
    (hadj : ∀ (F : V) (b : B), ⟪F, mu b⟫ = ⟪Cat F, b⟫)
    (hsurj : Function.Surjective mu) :
    Function.Injective Cat := by
  rw [← LinearMap.ker_eq_bot]
  rw [ker_adj_eq_range_orthogonal mu Cat hadj]
  have hr : LinearMap.range mu = ⊤ := LinearMap.range_eq_top.mpr hsurj
  rw [hr, Submodule.top_orthogonal_eq_bot]

/-! ## The block-by-block arithmetic

*"`65 = 36 + 29` is the strongest part of the block, and both reviewers verified it by hand."*
The counts are checked here as arithmetic; the multiplicities they count are representation
theory and are not typed. -/

/-- **The `29`, the `65` and the `36`**, in the four decompositions the reviewers rebuilt:
`8+3+10+8 = 29`, `65 = 20+6+27+12`, `36 = 20+16`, and `65 = 36+29`. -/
theorem block_counts :
    8 + 3 + 10 + 8 = 29 ∧ (65 : ℕ) = 20 + 6 + 27 + 12 ∧ (36 : ℕ) = 20 + 16 ∧
      (65 : ℕ) = 36 + 29 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **The shape of the `36`**: *"two `3×3`, five `2×2`, nine scalars"*, `2·9 + 5·4 + 9·1 = 47`
Hermitian coordinates against `36` real-symmetric unknowns, `2·6 + 5·3 + 9·1 = 36`. -/
theorem block_shape : 2 * 6 + 5 * 3 + 9 * 1 = 36 ∧ 2 * 9 + 5 * 4 + 9 * 1 = 47 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **The multiplicity split**: *"Even blocks carry `29` of the `41` multiplicities, odd carry
`12`."* -/
theorem multiplicity_split : 29 + 12 = 41 := by norm_num

/-! ## Non-vacuity

The hypotheses of the two conclusions are satisfiable, so neither statement is empty. -/

/-- **A witness**: `V = EuclideanSpace ℝ (Fin 14)`, `B = V`, `μ_K = 0` and `Cat = 0` satisfy the
adjunction, `V` has dimension `14`, and the rank equation reads `0 + 14 = 14`. -/
example :
    Module.finrank ℝ (EuclideanSpace ℝ (Fin 14)) = 14 ∧
      ∀ (F b : EuclideanSpace ℝ (Fin 14)),
        (inner ℝ F ((0 : EuclideanSpace ℝ (Fin 14) →ₗ[ℝ] EuclideanSpace ℝ (Fin 14)) b) : ℝ)
          = (inner ℝ ((0 : EuclideanSpace ℝ (Fin 14) →ₗ[ℝ] EuclideanSpace ℝ (Fin 14)) F) b : ℝ) := by
  refine ⟨by simp, fun F b => by simp⟩

end HamiltonsCubic.L59Statement
