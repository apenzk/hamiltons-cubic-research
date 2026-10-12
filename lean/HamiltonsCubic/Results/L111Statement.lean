import Mathlib

set_option linter.style.longLine false

/-!
# L111, criticality in bracket coordinates, and how much weaker the bracket form is

## The record's statement, as audited in [ROUND_L111](../../../verification/ROUND_L111.md)

[bounds.md](../../../findings/bounds.md)'s Lemma L111, over an orthonormal eigenbasis of `W` on
`Λ²` with `M_{kl} = tr(ad(φ_k) W ad(φ_l) W)`:

> 1. $M_{kl}=-2(W^\#)_{kl}$ for every symmetric $W$ on $\Lambda^2$. Hence $Q(W)=\theta W$ if and
>    only if $M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl}$ for all $k,l$.
> 2. The bracket form, $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$
>    whenever $\lambda_k\ne\lambda_l$, is $[W,Q(W)]=0$. Criticality implies it, and it is strictly
>    weaker.

The record's witness for strictness is the coordinate-diagonal Weyl tensor with
$w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, $w_{14}=w_{23}=0$, whose $Q(W)$ is diagonal with entries
$1,1,1,1,-2,-2$ against $W$'s $1,1,-1,-1,0,0$.

## What is typed here

Everything is stated in the eigenbasis of `W = diag(λ)` on `Λ²`, with `Ws` an arbitrary symmetric
array standing for `W#` in that basis, `Qmat = W² + W#` and `Mmat = -2 W#`:

* `matrix_form_is_criticality`, **the equivalence, both directions**: `Q(W) = θW` holds iff
  `M_{kl} = 2λ_k(λ_k - θ)δ_{kl}`. *The `δ_{kl}` is on the right of the `iff` and in no hypothesis,
  which is the record's "it is a conclusion".*
* `commutes_iff_bracket_form`, the bracket form **is** `[W, Q(W)] = 0`: `Q(W)` commutes with `W`
  exactly when its entries vanish across distinct eigenvalues.
* `critical_forces_all_offdiagonal`, the corrected clause: criticality kills every off-diagonal
  entry, including those between equal eigenvalues.
* `critical_imp_bracket_form` and `bracket_form_strictly_weaker`, one implication holds and its
  converse fails, with an explicit two-index witness satisfying the bracket form that **no** `θ`
  makes critical.
* `dropped_count_identity`, `∑_i C(m_i+1, 2) = ½(∑_i m_i² + N)` when `∑_i m_i = N`, the count of
  conditions the bracket form drops.
* `counts_at_balanced_products`, that count evaluated at the balanced products, against the total
  `C(N+1, 2)`: `66` of `120` at `n = 6` with multiplicities `(6, 9)`, and `1131` of `2211` at
  `n = 12` with multiplicities `(30, 36)`.

Everything is proved; there is no `sorry`.

## What is NOT typed here

**`M = -2W#` is not proved.** The record derives it from total antisymmetry of `c` on any symmetric
operator on `Λ²`; that needs `ad(φ_k)`, `tr` on `Λ²` and the structure constants, none of which
[WeylReal.lean](../Base/WeylReal.lean) carries in coordinates. Here `Mmat` is *defined* as `-2 Ws`
and `Ws` is quantified over, so nothing is assumed about the record's identity, the file proves
the equivalence for an arbitrary symmetric array and leaves the identification of that array with
the bracket matrix untyped.

**The strictness witness here is an array, not a Weyl tensor.** `bracket_form_strictly_weaker` uses
`λ = (1, -1)` on `Fin 2` with `W# = 0`, which is the eigendata of no Weyl tensor, so it shows the
implication fails for free arrays. The Weyl witness above, with `W#` computed from `W`, is the
record's, and typing it would need `#` in coordinates.

**The convention on the factor `2` is not settled here.** The record records it as dependent on
`W#` being read in the half-sum convention, "pinned by three occurrences on the record and tabled
in none". The `2` below is the record's; a different convention rescales `Mmat` and the statement
travels with it.

**Two arithmetic readings in the record's own strictness figures disagree, and this file records
both rather than choosing.** The `n = 12` pair `1130 of 2210` nets one condition off each side,
the single normalisation condition, while the `n = 6` pair `66 of 120` does not; the un-netted
`n = 12` pair is `1131 of 2211`. Under either reading the fractions are `66/120 = 55%` and
`1130/2210 ≈ 51.1%`, so the block's summary band *"45–51%"* does not contain its own `n = 6`
figure. *Only the arithmetic is typed; which reading the record intends is not decided here.*

**"None of the conditions carrying `θ` survive" is not typed.** It is a statement about which
symbols occur in a family of equations, not about their solutions.
-/

namespace HamiltonsCubic.L111Statement

open Finset

variable {κ : Type*} [DecidableEq κ]

/-! ## The objects, in the eigenbasis of `W = diag(λ)` -/

/-- `W = diag(λ)` on `Λ²`. -/
def diagW (lam : κ → ℝ) (k l : κ) : ℝ := if k = l then lam k else 0

/-- `Q(W) = W² + W#`, with `W²` diagonal because `W` is. -/
def Qmat (lam : κ → ℝ) (Ws : κ → κ → ℝ) (k l : κ) : ℝ :=
  (if k = l then lam k ^ 2 else 0) + Ws k l

/-- `M = -2 W#`, the bracket matrix in the record's normalisation. -/
def Mmat (Ws : κ → κ → ℝ) (k l : κ) : ℝ := -2 * Ws k l

/-- **Criticality**: `Q(W) = θ W`, read entrywise in the eigenbasis. -/
def IsCriticalHere (lam : κ → ℝ) (Ws : κ → κ → ℝ) (θ : ℝ) : Prop :=
  ∀ k l, Qmat lam Ws k l = θ * diagW lam k l

/-- **The bracket form**: the entries vanish across distinct eigenvalues. -/
def BracketForm (lam : κ → ℝ) (Ws : κ → κ → ℝ) : Prop :=
  ∀ k l, lam k ≠ lam l → Ws k l = 0

/-- **`[W, Q(W)] = 0`**, entrywise: `W` is diagonal, so the commutator's `(k,l)` entry is
`(λ_k - λ_l) Q(W)_{kl}`. -/
def CommutesWithW (lam : κ → ℝ) (Ws : κ → κ → ℝ) : Prop :=
  ∀ k l, lam k * Qmat lam Ws k l = Qmat lam Ws k l * lam l

/-! ## The matrix form is criticality, both directions -/

/-- **THE MATRIX FORM IS CRITICALITY.** `Q(W) = θW` holds exactly when
`M_{kl} = 2λ_k(λ_k - θ)δ_{kl}`. *The `δ_{kl}` appears only in the conclusion.* -/
theorem matrix_form_is_criticality (lam : κ → ℝ) (Ws : κ → κ → ℝ) (θ : ℝ) :
    IsCriticalHere lam Ws θ ↔
      ∀ k l, Mmat Ws k l = 2 * lam k * (lam k - θ) * (if k = l then 1 else 0) := by
  unfold IsCriticalHere Qmat Mmat diagW
  constructor
  · intro h k l
    have hkl := h k l
    by_cases he : k = l
    · subst he
      simp only [ite_true] at hkl ⊢
      linarith
    · simp only [if_neg he] at hkl ⊢
      linarith
  · intro h k l
    have hkl := h k l
    by_cases he : k = l
    · subst he
      simp only [ite_true] at hkl ⊢
      linarith
    · simp only [if_neg he] at hkl ⊢
      linarith

/-! ## The bracket form is the commutator, and is strictly weaker -/

/-- **THE BRACKET FORM IS `[W, Q(W)] = 0`.** -/
theorem commutes_iff_bracket_form (lam : κ → ℝ) (Ws : κ → κ → ℝ) :
    CommutesWithW lam Ws ↔ BracketForm lam Ws := by
  unfold CommutesWithW BracketForm Qmat
  constructor
  · intro h k l hne
    have hkl := h k l
    have hkne : k ≠ l := fun he => hne (by rw [he])
    simp only [if_neg hkne] at hkl
    have : (lam k - lam l) * Ws k l = 0 := by linarith [hkl]
    rcases mul_eq_zero.mp this with h1 | h2
    · exact absurd (by linarith : lam k = lam l) hne
    · exact h2
  · intro h k l
    by_cases hne : lam k = lam l
    · by_cases he : k = l
      · subst he; ring
      · simp only [if_neg he]; rw [hne]; ring
    · have hkne : k ≠ l := fun he => hne (by rw [he])
      simp only [if_neg hkne, h k l hne]
      ring

/-- **CRITICALITY KILLS EVERY OFF-DIAGONAL ENTRY**, not only those between distinct eigenvalues,
the record's correction to its own restriction `λ_k ≠ λ_l`. -/
theorem critical_forces_all_offdiagonal {lam : κ → ℝ} {Ws : κ → κ → ℝ} {θ : ℝ}
    (h : IsCriticalHere lam Ws θ) : ∀ k l, k ≠ l → Ws k l = 0 := by
  intro k l hne
  have hkl := h k l
  unfold Qmat diagW at hkl
  simp only [if_neg hne] at hkl
  linarith

/-- **Criticality implies the bracket form.** -/
theorem critical_imp_bracket_form {lam : κ → ℝ} {Ws : κ → κ → ℝ} {θ : ℝ}
    (h : IsCriticalHere lam Ws θ) : BracketForm lam Ws := by
  intro k l hne
  exact critical_forces_all_offdiagonal h k l (fun he => hne (by rw [he]))

/-- **THE BRACKET FORM IS STRICTLY WEAKER.** With `λ = (1, -1)` and `W# = 0` the bracket form holds
every off-diagonal entry is zero, while **no** `θ` makes the point critical, since the two
diagonal rows demand `θ = 1` and `θ = -1`. *This is the record's diagonal family in its smallest
instance: the screen that passed the false "equivalently" used random Weyl tensors, which are never
diagonal.* -/
theorem bracket_form_strictly_weaker :
    BracketForm (![1, -1] : Fin 2 → ℝ) (fun _ _ => 0) ∧
      ¬ ∃ θ : ℝ, IsCriticalHere (![1, -1] : Fin 2 → ℝ) (fun _ _ => 0) θ := by
  constructor
  · intro k l _; rfl
  · rintro ⟨θ, h⟩
    have h0 := h 0 0
    have h1 := h 1 1
    unfold Qmat diagW at h0 h1
    norm_num at h0 h1
    linarith

/-! ## How many conditions the bracket form drops -/

/-- **THE COUNT.** With `m` the `Λ²` multiplicities and `∑ m = N`, the conditions the bracket form
drops number `∑_i C(m_i+1, 2) = ½(∑_i m_i² + N)`. -/
theorem dropped_count_identity {ι : Type*} [Fintype ι] (m : ι → ℚ) (N : ℚ)
    (hN : ∑ i, m i = N) :
    ∑ i, m i * (m i + 1) / 2 = ((∑ i, m i ^ 2) + N) / 2 := by
  subst hN
  rw [eq_div_iff (by norm_num : (2 : ℚ) ≠ 0), Finset.sum_mul, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **THE COUNT AT THE BALANCED PRODUCTS.** At `n = 6` the `Λ²` multiplicities are `(6, 9)` with
`N = 15`, dropping `66` of `C(16,2) = 120`; at `n = 12` they are `(30, 36)` with `N = 66`,
dropping `1131` of `C(67,2) = 2211`. *The record's `n = 12` pair `1130 of 2210` is this pair with
the single normalisation condition netted off each side; the `n = 6` pair is not netted.* -/
theorem counts_at_balanced_products :
    ((6 : ℚ) + 9 = 15 ∧ 6 * 7 / 2 + 9 * 10 / 2 = 66 ∧ (15 : ℚ) * 16 / 2 = 120) ∧
    ((30 : ℚ) + 36 = 66 ∧ 30 * 31 / 2 + 36 * 37 / 2 = 1131 ∧ (66 : ℚ) * 67 / 2 = 2211) := by
  refine ⟨⟨by norm_num, by norm_num, by norm_num⟩, ⟨by norm_num, by norm_num, by norm_num⟩⟩

/-- **The two fractions, as the record's own figures give them.** `66/120` is `55%` exactly, and
`1130/2210` is between `51.1%` and `51.2%`. *`1130/2210` is `counts_at_balanced_products`'s
`1131` of `2211` with the single normalisation condition netted off both sides, and `66/120` is
not netted.* -/
theorem dropped_fractions :
    (66 : ℚ) / 120 = 11 / 20 ∧ (511 : ℚ) / 1000 < 1130 / 2210 ∧ (1130 : ℚ) / 2210 < 512 / 1000 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.L111Statement
