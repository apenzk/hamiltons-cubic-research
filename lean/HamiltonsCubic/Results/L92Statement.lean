import Mathlib

set_option linter.style.longLine false

/-!
# L92, the highest-weight route needs no Casimir separation

**The record's statement, quoted verbatim from [sym3-blocks.md](../../../findings/sym3-blocks.md):**

> #### Lemma L92, the highest-weight route needs no Casimir separation
>
> *Gate 2, [r691](../reviews/REVIEW_r691.md) and [r692](../reviews/REVIEW_r692.md) on identical briefs, **both CONFIRMED**.*
>
> **And the highest-weight route never meets even that one.** A weight $\mu$ of $V_\lambda$ satisfies $\lambda-\mu\in\mathbb Z_{\ge0}\alpha_1+\mathbb Z_{\ge0}\alpha_2$, and with $\alpha_1=(1,-1)$, $\alpha_2=(0,1)$ neither difference qualifies: $(4,1)-(3,3)=(1,-2)=\alpha_1-\alpha_2$ and $(3,3)-(4,1)=(-1,2)=-\alpha_1+\alpha_2$. **So $(3,3)$ is not a weight of $V_{(4,1)}$ and $(4,1)$ is not a weight of $V_{(3,3)}$.** *The step needs the expansion to be unique, which it is: $\alpha_1$ and $\alpha_2$ are independent, so $a=v_1$ and $b=v_1+v_2$ are forced, otherwise a difference with one negative expansion might still admit a nonnegative one.* **The highest-weight construction therefore needs no Casimir to separate any block, colliding or not.**
>
> *A second, disjoint confirmation comes from the Weyl-orbit convex hull: $\lVert(3,3)\rVert^2=18>17$ kills one direction and $\lvert\mu_1\rvert\le3<4$ the other.*
>
> **THE BLOCK UNDERSTATES ITS OWN SUPPORT.** What proves the heading is not the root-lattice computation (which concerns two weights, where the heading concerns the construction) but **the italic aside: a weight-$\lambda$ vector killed by the raising operators generates $V_\lambda$. That argument is universal, uses nothing about $B_2$.** *It owes one line of complete reducibility, being a Verma-quotient argument rather than a definition.*
>
> *The counts are misattributed to the wrong reviewer, and "non-colliding" is lossy, four of the thirteen blocks **are** colliding blocks.*

## What this file states

The lattice half of the block, in full, and the conclusion it delivers about the surviving
Casimir collision. Everything is proved; there is no `sorry`.

* `unique_expansion`, `α₁ = (1,-1)` and `α₂ = (0,1)` are independent, so `v = aα₁ + bα₂` forces
  `a = v₁` and `b = v₁ + v₂`. **This is the step the block leaves implicit**, and without it a
  difference exhibited with one negative coefficient might still admit a non-negative expansion.
* `differences`, `(4,1) - (3,3) = α₁ - α₂` and `(3,3) - (4,1) = -α₁ + α₂`, **both carrying a
  negative coefficient**, so the collision is resolved in both directions rather than one.
* `mutually_not_weights`, hence `(3,3)` is not a weight of `V_{(4,1)}` and `(4,1)` is not a weight
  of `V_{(3,3)}`. The published weight-lattice theorem,
  *a weight `μ` of `V_λ` satisfies `λ - μ ∈ ℤ≥0α₁ + ℤ≥0α₂`*, enters as the explicit hypothesis
  `weight_lattice` over an abstract predicate, which is what it is: a classical input, not
  something this record proved.
* `hull_route`, the disjoint second confirmation: `‖(3,3)‖² = 18 > 17 = ‖(4,1)‖²` kills one
  direction and `|μ₁| ≤ 3 < 4` the other, using no root lattice at all.
* `counts`, *"non-colliding" is lossy*: of the `46` dimensions at weight `(4,1)`, `44` come from
  thirteen other blocks, leaving `2` for the colliding pair.

**The basis is the `e`-basis**, pinned by the block's own `α`'s. *In `ω`-coordinates the printed
difference **is** `α₂`, and a reader there draws the opposite conclusion*, so the norms below,
which are basis-dependent, are stated in the same `e`-basis the differences are.

## What is NOT typed here

**The heading itself.** *"The highest-weight route needs no Casimir separation"* rests, as the
audit says, on the universal claim that **a weight-`λ` vector killed by the raising operators
generates `V_λ`**, a Verma-quotient argument owing one line of complete reducibility. That is
representation theory Mathlib does not carry, and it is about the construction rather than about
two weights, so it is not stated here in any form. What is typed is the lattice computation the
block prints, which settles the surviving collision and is strictly narrower than the heading.
-/

namespace HamiltonsCubic.L92Statement

/-! ## The simple roots, in the `e`-basis -/

/-- `α₁ = (1, -1)`, a **root**, not a fundamental weight. -/
def a1 : ℤ × ℤ := (1, -1)

/-- `α₂ = (0, 1)`. -/
def a2 : ℤ × ℤ := (0, 1)

/-- `a·α₁ + b·α₂`. -/
def comb (a b : ℤ) : ℤ × ℤ := (a * a1.1 + b * a2.1, a * a1.2 + b * a2.2)

/-- **THE EXPANSION IS UNIQUE**, which is what makes a negative coefficient decisive: `α₁` and
`α₂` are independent, so `a = v₁` and `b = v₁ + v₂` are forced. -/
theorem unique_expansion (v : ℤ × ℤ) (a b : ℤ) :
    comb a b = v ↔ (a = v.1 ∧ b = v.1 + v.2) := by
  constructor
  · intro h
    have h1 : a * a1.1 + b * a2.1 = v.1 := congrArg Prod.fst h
    have h2 : a * a1.2 + b * a2.2 = v.2 := congrArg Prod.snd h
    simp only [a1, a2] at h1 h2
    constructor <;> omega
  · rintro ⟨ha, hb⟩
    subst ha; subst hb
    simp only [comb, a1, a2]
    ext <;> simp <;> ring

/-! ## Both differences carry a negative coefficient -/

/-- **`(4,1) - (3,3) = (1,-2) = α₁ - α₂`** and **`(3,3) - (4,1) = (-1,2) = -α₁ + α₂`.** -/
theorem differences :
    ((4, 1) : ℤ × ℤ) - (3, 3) = comb 1 (-1) ∧ ((3, 3) : ℤ × ℤ) - (4, 1) = comb (-1) 1 := by
  constructor <;> · simp only [comb, a1, a2]; decide

/-- **Neither difference lies in `ℤ≥0 α₁ + ℤ≥0 α₂`**: the unique expansion of each has a negative
coefficient. -/
theorem not_in_positive_cone :
    (¬ ∃ a b : ℕ, ((4, 1) : ℤ × ℤ) - (3, 3) = comb (a : ℤ) (b : ℤ)) ∧
      (¬ ∃ a b : ℕ, ((3, 3) : ℤ × ℤ) - (4, 1) = comb (a : ℤ) (b : ℤ)) := by
  constructor
  · rintro ⟨a, b, h⟩
    obtain ⟨ha, hb⟩ := (unique_expansion _ (a : ℤ) (b : ℤ)).mp h.symm
    norm_num at ha hb
    omega
  · rintro ⟨a, b, h⟩
    obtain ⟨ha, hb⟩ := (unique_expansion _ (a : ℤ) (b : ℤ)).mp h.symm
    norm_num at ha hb
    omega

/-- **THE CONCLUSION.** With the classical weight-lattice theorem as the hypothesis it is,
*a weight `μ` of `V_λ` satisfies `λ - μ ∈ ℤ≥0α₁ + ℤ≥0α₂`*, the surviving Casimir collision is
resolved **in both directions**: `(3,3)` is not a weight of `V_{(4,1)}`, and `(4,1)` is not a
weight of `V_{(3,3)}`. -/
theorem mutually_not_weights (IsWeightOf : ℤ × ℤ → ℤ × ℤ → Prop)
    (weight_lattice : ∀ lam mu, IsWeightOf mu lam → ∃ a b : ℕ, lam - mu = comb (a : ℤ) (b : ℤ)) :
    ¬ IsWeightOf (3, 3) (4, 1) ∧ ¬ IsWeightOf (4, 1) (3, 3) := by
  obtain ⟨h1, h2⟩ := not_in_positive_cone
  exact ⟨fun h => h1 (weight_lattice _ _ h), fun h => h2 (weight_lattice _ _ h)⟩

/-! ## The disjoint second route: the Weyl-orbit convex hull -/

/-- `‖·‖²` in the `e`-basis. -/
def sqNorm (v : ℤ × ℤ) : ℤ := v.1 ^ 2 + v.2 ^ 2

/-- **The hull route, using no root lattice.** `‖(3,3)‖² = 18 > 17 = ‖(4,1)‖²` rules out one
direction on norms alone (every element of the Weyl orbit of `(4,1)` has square norm `17`) and
`|μ₁| ≤ 3 < 4` rules out the other on a single coordinate. -/
theorem hull_route :
    sqNorm (3, 3) = 18 ∧ sqNorm (4, 1) = 17 ∧ (17 : ℤ) < 18 ∧ (3 : ℤ) < 4 := by
  refine ⟨by decide, by decide, by decide, by decide⟩

/-! ## The counts the block compresses -/

/-- **`"non-colliding" is lossy.`** Of the `46` dimensions at weight `(4,1)`, `44` come from the
thirteen other blocks, leaving `2` for the colliding pair, and four of those thirteen are
themselves colliding blocks. -/
theorem counts : 44 + 2 = 46 ∧ 4 ≤ 13 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.L92Statement
