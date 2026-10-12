import HamiltonsCubic.Results.L187Statement

/-!
# L188, at `dim V = 8` both forms are full rank, and Bianchi factors

**Where this sits.** [L187](L187Statement.lean)'s Pfaffian route empties the
two-non-decomposable case at `dim V ∈ {4, 6}`, and [r802](../../../reviews/REVIEW_r802.md)'s `τ`
generalisation at `{10, 14, …}`. *It stops at `dim V ≡ 0 (mod 4)` because `ω^{m-1}` is then an odd
power.* **`dim V = 8` is the first open dimension, and this lemma is what can be said there.**

## Two facts

**(1) Both non-decomposable forms have full rank eight.** *Wedging Bianchi's `ω₁∧ω₁ = c·(ω₂∧ω₂)`
with itself gives `ω₁⁴ = c²·ω₂⁴`, that is `Pf(ω₁) = c²·Pf(ω₂)`.* If `rank ω₂ < 8` then
`Pf(ω₂) = 0`, so `Pf(ω₁) = 0` and `rank ω₁ < 8`, against
[L180](L180Statement.lean)(3), which puts `V = supp ω₁` at dimension eight.

**(2) Bianchi FACTORS.** *Two-forms commute under the wedge, `α∧β = β∧α`, since the degree product
is even, so the cross terms cancel and*

  `(ω₁ - √c·ω₂) ∧ (ω₁ + √c·ω₂) = ω₁∧ω₁ - c·(ω₂∧ω₂) = 0`.

**So with `α = ω₁ - √c ω₂` and `β = ω₁ + √c ω₂`, the open case reads `α ∧ β = 0`**, both nonzero,
since either vanishing makes `ω₁, ω₂` dependent against orthonormality, with
`‖α‖² = ‖β‖² = 1 + c` and `⟨α, β⟩ = 1 - c`.

*A QUADRATIC condition on one form has become a BILINEAR condition on two, which is the shape the
next attempt has to work with.*

## What is NOT typed here

- **The wedge itself at `dim 8`.** [SelfDual.lean](../Base/SelfDual.lean) carries `wedgeSelf` in
  components at general `n`, and `ω⁴`, `Pf` on `ℝ⁸` and `⋆ : Λ⁶ → Λ²` are not built. **What is
  typed below is the factoring identity in the one property it uses (commutativity) and the rank
  arithmetic.**
- **Whether `α ∧ β = 0` with these norms is satisfiable at all.** *Three lemmas of this line have
  now been correct about an empty class; this one states no emptiness and claims none.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L188Statement

variable {A : Type*} [CommRing A]

/-- **The factoring identity, in the one property it uses.** *`α ∧ β = β ∧ α` for two-forms because
the degree product is even, so the cross terms cancel, and nothing else about the wedge enters.* -/
theorem factor_of_comm (x y k : A) : (x - k * y) * (x + k * y) = x * x - k ^ 2 * (y * y) := by
  ring

/-- **So Bianchi at the two-non-decomposable case is a product of two forms vanishing.** *With
`k² = c`, the right side is exactly `ω₁∧ω₁ - c·(ω₂∧ω₂)`.* -/
theorem bianchi_factors {x y k : A} (h : x * x = k ^ 2 * (y * y)) :
    (x - k * y) * (x + k * y) = 0 := by
  rw [factor_of_comm, h, sub_self]

/-- **`(1 + c) - (1 - c) = 2c`, and nothing more.**

*It stands for the gap between the factors' squared norm `1 + c` and their inner product `1 - c` at
orthonormal unit `ωᵢ`, but those are claims about forms, and this is arithmetic on two reals. A
reviewer found the previous name, `factor_norms`, mentioning a norm the statement does not.* -/
theorem norm_minus_inner (c : ℝ) : (1 : ℝ) + c - (1 - c) = 2 * c := by ring

/-- **Full rank at `dim V = 8`.** *`Pf(ω₂) = 0` would force `Pf(ω₁) = 0` and so `rank ω₁ < 8`,
against `V = supp ω₁` at dimension eight.* -/
theorem full_rank_of_pf {p₁ p₂ c : ℝ} (hpf : p₁ = c ^ 2 * p₂) (h₂ : p₂ = 0) :
    p₁ = 0 := by
  rw [hpf, h₂, mul_zero]

/-! ## What Ricci-flatness says at `dim V = 8`

*The two facts above come from first Bianchi. Ricci-flatness adds a second, and it is sharp.*

With both forms full rank, `λ₁A₁ = |λ₂|A₂ + |λ₃|Π₃` says that **`λ₁A₁ - |λ₂|A₂` is positive
semidefinite of rank exactly two**, two positive definite matrices differing, up to scale, by a
rank-two term. *Reading it as a quadratic form at `x ⊥ P₃` kills the `Π₃` term:*

  `λ₁‖ω₁ x‖² = |λ₂|‖ω₂ x‖²`  for every `x` in the six-dimensional `P₃^⊥ ∩ V`.

**So `‖ω₁x‖ / ‖ω₂x‖` is the constant `√(|λ₂|/λ₁)` on a codimension-two subspace**, two full-rank
skew maps agreeing in norm up to one scalar, off a plane. *That is a strong condition on a pair
already constrained by `α ∧ β = 0`, and the two have not been used together.*

## What is NOT typed here

**Nothing above about `Π₃`'s rank or the six-dimensional subspace**; what is typed is the
quadratic-form step, that a positive-semidefinite difference vanishing at `x` forces the two forms
to agree there, which is the only step that is not bookkeeping.
-/

/-- **The quadratic-form step.** *At a vector the rank-two term annihilates, the two scaled norms
agree; this is that, with the `Π₃` contribution written as its value rather than its matrix.* -/
theorem norms_agree_off_plane {l₁ l₂ n₁ n₂ p : ℝ}
    (hric : l₁ * n₁ = l₂ * n₂ + p) (hp : p = 0) :
    l₁ * n₁ = l₂ * n₂ := by
  rw [hric, hp, add_zero]

/-- **So the ratio is constant off the plane.** *`‖ω₁x‖²/‖ω₂x‖² = |λ₂|/λ₁` wherever the projection
term vanishes, which is the six-dimensional `P₃^⊥ ∩ V`.* -/
theorem ratio_const {l₁ l₂ n₁ n₂ : ℝ} (hl₁ : l₁ ≠ 0) (hn₂ : n₂ ≠ 0)
    (h : l₁ * n₁ = l₂ * n₂) : n₁ / n₂ = l₂ / l₁ := by
  field_simp
  linarith [h]

end HamiltonsCubic.L188Statement
