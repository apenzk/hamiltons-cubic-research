# Brief, round L59

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement and argument as the findings file carries them ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 299-303, under the heading at line 281)

Let $K$ be the span cut out by the orbit constraint and let $\mathrm{ANN}$ be the invariant sextics $F$ with $\mathrm{Cat}_F(K,K)=0$. Apolarity gives $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, so, for $\mu_K$ the restriction of $\mu$ to the invariants supported on $K$,
\[
\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN},\qquad F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN}.
\]
$\mathrm{Cat}$ is injective on the invariant sextics --- the unrestricted $\mu$ is surjective, so its adjoint is injective --- placing a copy of the $14$ inside the $65$ invariant symmetric forms on $\mathrm{Sym}^3$. The forms vanishing on $K\times K$ number $29$, counted block by block: an odd-$\lambda_2$ block dies entirely, $K$ containing all of $M_\lambda$; an even one keeps $u\otimes v+v\otimes u$, $K$ having codimension $1$ there. So $65=36+29$ splits the invariant forms into those supported on $K$ --- the unknowns --- and those killing $K\times K$.

## Passage B, the canonical statement, landscape form ([results.md](../results.md) line 216)

- **Lemma L59 (direct). The certificate's necessary condition is one dimension count.** With $K$ the span cut out by the orbit constraint and $\mathrm{ANN}$ the invariant sextics $F$ with $\mathrm{Cat}_F(K,K)=0$, apolarity gives $\mathrm{rank}=14-\dim\mathrm{ANN}$ and $F_5\in\mathrm{image}$ iff $F_5\perp\mathrm{ANN}$; the $65$ invariant forms split as $36+29$.

## Passage C, the canonical statement, detail form ([results.md](../results.md) line 741, under the heading at line 739)

In the sum-of-squares certificate at $n=5$, let $K$ be the span of cubics cut out by the orbit constraint and let $\mathrm{ANN}$ be the $O(5)$-invariant sextics $F$ whose catalecticant satisfies $\mathrm{Cat}_F(K,K)=0$. Apolarity, $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, gives $\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN}$ on the $14$-dimensional space of invariant sextics and $F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN}$, where $\mu_K$ is the restriction of $\mu$ to the invariants supported on $K$. $\mathrm{Cat}$ is injective on the invariant sextics because the unrestricted $\mu$ is surjective, placing the $14$ inside the $65$ invariant symmetric forms on $\mathrm{Sym}^3$; the forms vanishing on $K\times K$ number $29$, counted block by block (an odd-$\lambda_2$ block dies entirely, an even one keeps $u\otimes v+v\otimes u$) so $65=36+29$ splits the invariant forms into the unknowns supported on $K$ and those killing $K\times K$. The count is the necessary condition; Lemma L62 shows it is met.

## Passage D, the module and its normalisation ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 5-13)

## The Weyl module and the group action

$\mathcal W_5$ is the $O(5)$-irreducible $[2,2]$, of dimension $35$, realised as $\Lambda^2\mathbb R^5\to\mathrm{Sym}^2(\Lambda^2)\to$ first Bianchi $\to$ Ricci-traceless. **The highest weight is $4\omega_2$ rather than $2\omega_2$**: in $B_2=\mathfrak{so}(5)$ the fundamental weight $\omega_2$ is the *spin* weight, so $[2,2]=2e_1+2e_2$ solves to $4\omega_2$. A dimension check cannot separate this from $\omega_1+2\omega_2=[2,1]$, which also has dimension $35$; the Casimir does, at $16$ against $12$.

$\mathfrak{so}(5)$ acts by derivation, and the action is exact over $\mathbb Q$ in [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py): the homomorphism holds on all $45$ generator pairs with residual $0$, and the Casimir is $16\cdot\mathrm{Id}$ with every off-diagonal entry exactly zero.

**The Casimir value alone does not establish that the action is an action, and there is a proof rather than an anecdote.** *Reviewer 177.* **$C=-\sum_a\rho(A_a)^2$ depends only on the squares, so negating a single generator leaves $C=16\cdot\mathrm{Id}$ exactly while breaking $12$ of the $45$ Lie relations**, a two-line construction, reproduced in [negated_generator.py](../scripts/reviewers/r177/negated_generator.py). **The bracket check is what tests the action.** The eigenvalue is a similarity invariant and survives a change of basis, so it likewise carries no information about orthonormality.

The normalisation is $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$, which is *positive* definite on the compact real form ($\mathop{\mathrm{tr}}(X^2)=-2$ for $X=E_{12}-E_{21}$) so $\{E_{ij}-E_{ji}\}$ is $B$-orthonormal and self-dual, each $\rho(X_a)$ is skew, and $\rho(X_a)^2$ is negative semi-definite. **The minus in $C=-\sum_a\rho(A_a)^2$ is what makes $\langle\lambda,\lambda+2\rho\rangle=+16$ come out positive.** Neighbouring conventions give $32$, $8$, $8/3$ and $4$; the $8/3$ is [Killing](../findings/conventions.md), since $B_K=(N-2)\mathop{\mathrm{tr}}=3\mathop{\mathrm{tr}}=-6B$ and the Casimir scales inversely.

## Passage E, the orbit constraint that defines $K$ ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 108-122)

## The orbit constraint

$F_5$ vanishes on the whole $O(5)$-orbit of the padded $W_{\mathbb{CP}^2}$, so every covariant entering a certificate vanishes there, and by equivariance that is the single condition $\sigma_\lambda(W_0)=0$. $\mathrm{Stab}_{O(5)}(W_0)$ has identity component $U(2)\subset SO(4)$, two components, times the reflection on the padding axis; and the rule has a mechanism rather than a bracket. *Reviewer 178, deriving it independently of 174.*

**Branching $\mathfrak{so}(5)\to\mathfrak{so}(4)=\mathfrak{su}(2)_L\oplus\mathfrak{su}(2)_R$ leaves exactly one constituent with $j_L=0$, namely $(\mu_1,\mu_2)=(\lambda_2,-\lambda_2)$, so $j_R=\lambda_2$.** The $U(2)$-invariants are therefore *always* one-dimensional, and what decides is the extra component: $\sigma$ is the $\mathfrak{su}(2)_R$ Weyl element, which acts on the $m=0$ vector of spin $j$ by $(-1)^j$. **Hence $\dim V_\lambda^H=1$ iff $\lambda_2$ is even.** *Hand-checks: $(1,0)\mapsto1$, realised by $e_5$; $(1,1)\mapsto0$, the complex structure flipping sign; $(2,0)\mapsto1$; $(2,2)\mapsto1$.*

**The reflection $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$ is redundant**, every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ has $-\mathrm{Id}$ acting trivially, so $\varepsilon$ acts as $\mathrm{diag}(-1,-1,-1,-1,1)\in SO(5)$, which is already the scalar $-1$ in $U(2)$.

That rule selects **exactly $16$** blocks, whose dimensions sum to **$3570$**. Each loses one multiplicity, leaving **$25$ surviving multiplicities and $36$ unknowns**, shaped as **two $3\times3$, five $2\times2$ and nine scalars**. Eight of the twelve multiplicity-$1$ blocks die outright: $(0,0)$, $(1,0)$, $(5,0)$, $(5,4)$, $(6,0)$, $(6,2)$, $(6,4)$, $(6,6)$.

**THE RANK-ONE STEP IS AN INEQUALITY, AND WHAT PROMOTES IT TO AN IDENTITY IS A MEASUREMENT.** *Reviewer 177.* Frobenius reciprocity bounds the evaluation map $M_\lambda\to V_\lambda^H$ by $\dim V_\lambda^H=1$; **it does not force rank $1$ rather than rank $0$.** Taken alone, "each block loses one multiplicity" makes $36$ a *lower* bound on the unknowns, and the eight block deaths ($(5,0)$, $(5,4)$ and $(6,2)$ among them, which is where "only one pair needs the quartic" rests), become conditional.

**The record answers it, and the answer had never been stated as a dependency.** $\sum_\lambda(\mathrm{rank}_\lambda\cdot d_\lambda)$ is the dimension of the $O(5)$-submodule generated by $W_0^3$, which [r170](../reviews/REVIEW_r170.md) *measured* at $3570$ and [r178](../reviews/REVIEW_r178.md) recomputed exactly over $\mathbb F_{46337}$; the derived upper bound, [r174](../reviews/REVIEW_r174.md)'s, is the same $3570$. **The two ends are ranks of different objects, and what joins them is owed, see [L87](../findings/sym3-blocks.md).** **An upper bound attained forces every one of the sixteen ranks to be exactly $1$, so no block has rank $0$ and $36$ is exact.** *Everything downstream, the shape, the eight deaths, the two vanishing collisions, rests on that single measured number.*

**The check that would remove the dependency, now that the $41$ vectors exist:** a block has rank $1$ exactly when its highest-weight vector, read as a cubic polynomial, fails to vanish somewhere on the orbit of $W_0$. *Evaluating the $41$ at a handful of points $g\cdot W_0$ settles all sixteen at once, and needs only the inner product on $\mathcal W_5$ in the weight basis.*

## Passage F, the givens the statement consumes, as their headings state them

[findings/sym3-blocks.md](../findings/sym3-blocks.md) line 15: #### Lemma L83, the $24$-block table, with one external closure ($7770$)

[findings/sym3-blocks.md](../findings/sym3-blocks.md) line 68: #### Lemma L85, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, a machine count with three hand-checkable rungs

[findings/sym3-blocks.md](../findings/sym3-blocks.md) line 94: #### Lemma L86, the parity rule $\dim V_\lambda^H=1\iff\lambda_2$ even, and the $\ge36$ unknowns it leaves

[findings/sym3-blocks.md](../findings/sym3-blocks.md) line 124: #### Lemma L87, the rank-one step, the orbit Gram meets the cap, so every even block loses exactly one multiplicity

[findings/sym3-blocks.md](../findings/sym3-blocks.md) line 138: #### Lemma L88, $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ are gauge

## Passage G, the Lean statement ([lean/HamiltonsCubic/Results/L59Statement.lean](../lean/HamiltonsCubic/Results/L59Statement.lean), whole file, 179 lines)

```lean
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

```

## Scope of the brief

- **$\mu$, $\mathrm{Cat}_F$, $B$ and the space of "invariants supported on $K$" are not defined in any quoted passage beyond what Passages A and E say.** Say what each must be for Passage A to make sense, and whether the record supplies it, rather than choosing a definition and proving under it.
- The block tables behind $65$, $36$, $29$ and $14$ are [Lemma L83](../findings/sym3-blocks.md)'s table (lines 33-38 of that file, which you may read) and Passage E. **Their standing is not your question**; whether L59's argument follows from them is.

## What to attack, beyond the standing list

1. **The adjunction** $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$: on which spaces each pairing lives, whether it is a theorem or the definition of $\mathrm{Cat}$, and whether the pairing is named.
2. **$\mathrm{ANN}$**: whether "invariant sextics $F$ with $\mathrm{Cat}_F(K,K)=0$" is the kernel of the adjoint of $\mu_K$, **including the step from "$\mathrm{Cat}_F$ vanishes on every invariant form supported on $K$" to "$\mathrm{Cat}_F(K,K)=0$"**, and what that step needs.
3. **The two displays**: $\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN}$ and $F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN}$, from the adjunction, and which map, restricted or unrestricted, each sentence of Passage A means by $\mu$.
4. **Injectivity of $\mathrm{Cat}$** from surjectivity of the unrestricted $\mu$, and "a copy of the $14$ inside the $65$".
5. **The count $65=36+29$**: whether the block-by-block rule (odd-$\lambda_2$ blocks die entirely, even ones keep $u\otimes v+v\otimes u$) gives $29$ from L83's multiplicities, and whether the identity checks anything.
6. **"The count is the necessary condition; Lemma L62 shows it is met"** (Passage C): what is necessary for what, and what the positive-semidefinite half of a certificate adds that the count does not.
7. **Passage G against Passage A**: what the Lean file types (an abstract adjunction), what it declares untyped, and whether its theorems are faithful to the displays.
8. The boundary: $\dim\mathrm{ANN}=0$ and $=14$, and the case $K=\mathrm{Sym}^3$.

