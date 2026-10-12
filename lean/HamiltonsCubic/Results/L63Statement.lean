import Mathlib

/-!
# L63, the `n = 12` block table, STATED as far as it can be

[sym3-stability.md](../../../findings/sym3-stability.md)'s Lemma L63, quoted verbatim:

> `dim 𝒲₁₂ = 1638`, the irreducible of highest weight `(2,2,0,0,0,0)` for `D₆`.
> `Sym³(𝒲₁₂)` carries `77` `SO(12)` constituents with `191` multiplicities; twelve are chiral,
> in six pairs with `λ₆ ≠ 0` at multiplicities `2,1,1,1,1,1`, and an orientation-reversing
> element fuses each pair into one `O(12)` block. So `O(12)` sees **71** blocks and **184**
> multiplicities, with `∑ m_λ d_λ = C(1640,3) = 733 813 080`.

**The record grades the two halves differently, and this file follows that grading.** Its own
audit note: *"`dim 𝒲₁₂ = 1638` at highest weight `(2,2,0,0,0,0)` is derivable, confirmed by two
independent closed forms, and stays a `Lemma`. The census, `77` constituents, `191`
multiplicities, the six chiral pairs at `2,1,1,1,1,1`, and `C(1640,3) = 733 813 080`, rests on
a decomposition run with no argument on the record, so it is an `Observation` at `n = 12`."*

## What is NOT typed here

**The census.** That `Sym³(𝒲₁₂)` decomposes into `77` `SO(12)`-constituents with total
multiplicity `191`, and that exactly twelve of them are chiral in six `±` pairs, is a statement
about the decomposition of the symmetric cube of an irreducible `SO(12)`-module. **Mathlib
carries no machinery for the irreducible representations of `SO(n)`, their highest weights, or
plethysms of them**, so the census cannot be stated here at all, not weakened, not with a
`sorry`: there is no proposition to write. Writing it against an abstract multiplicity function
would produce a statement satisfied by numbers chosen to satisfy it, which is not the census.

**What is typed is everything the record derives from the census once its four figures are
given**, plus the `Lemma` half in full:

* `dim 𝒲₁₂ = 1638`, from **both** closed forms the audit names, the Weyl-tensor dimension
  `n(n+1)(n+2)(n-3)/12` and Weyl's dimension formula for `D₆` at `(2,2,0,0,0,0)`. *The second
  is what pins the label, which the audit calls the part that was wrong.*
* `dim Sym³(𝒲₁₂) = C(1640,3) = 733 813 080`, which is what `∑ m_λ d_λ` must equal.
* The fusion arithmetic `77 → 71` and `191 → 184`, from the six chiral pairs at multiplicities
  `2,1,1,1,1,1`. *The record calls this chain **exceptionally tight**, it uses all four
  reported figures and breaks under any single transcription error, which is why it is worth
  typing even though the figures entering it are measured.*

## The chiral multiplicity list

The record's heading list and the list below it disagree on **where** the `2` sits, the block
records the discrepancy and notes that totals are unaffected. `chiralMults` below is the
multiset `{2,1,1,1,1,1}`, which is all the fusion arithmetic reads, so the file is invariant
under that ambiguity.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L63Statement

/-! ## `dim 𝒲₁₂ = 1638`, the `Lemma` half, by two closed forms -/

/-- The dimension of the space of algebraic Weyl tensors on `ℝⁿ`: `n(n+1)(n+2)(n-3)/12`. -/
def weylDim (n : ℕ) : ℕ := n * (n + 1) * (n + 2) * (n - 3) / 12

/-- **First closed form.** `dim 𝒲₁₂ = 1638`. -/
theorem weylDim_twelve : weylDim 12 = 1638 := by decide

/-- Weyl's dimension formula for `D₆`, numerator and denominator kept separate so no division
enters: in the `ℓ = λ + ρ` coordinates the dimension is `wdim ℓ / wdim ρ`, with
`ρ = (5,4,3,2,1,0)`. -/
def wdim (l0 l1 l2 l3 l4 l5 : ℤ) : ℤ :=
  (l0 ^ 2 - l1 ^ 2) * (l0 ^ 2 - l2 ^ 2) * (l0 ^ 2 - l3 ^ 2) * (l0 ^ 2 - l4 ^ 2) * (l0 ^ 2 - l5 ^ 2) *
  ((l1 ^ 2 - l2 ^ 2) * (l1 ^ 2 - l3 ^ 2) * (l1 ^ 2 - l4 ^ 2) * (l1 ^ 2 - l5 ^ 2)) *
  ((l2 ^ 2 - l3 ^ 2) * (l2 ^ 2 - l4 ^ 2) * (l2 ^ 2 - l5 ^ 2)) *
  ((l3 ^ 2 - l4 ^ 2) * (l3 ^ 2 - l5 ^ 2)) *
  (l4 ^ 2 - l5 ^ 2)

/-- **Second closed form, and the one that pins the label.** At `λ = (2,2,0,0,0,0)` the shifted
weight is `ℓ = λ + ρ = (7,6,3,2,1,0)`, and Weyl's dimension formula for `D₆` returns `1638`. -/
theorem wdim_D6_two_two : wdim 7 6 3 2 1 0 = 1638 * wdim 5 4 3 2 1 0 := by decide

/-- **The two agree**, which is the audit's *"confirmed by two independent closed forms"*. -/
theorem closed_forms_agree :
    (weylDim 12 : ℤ) * wdim 5 4 3 2 1 0 = wdim 7 6 3 2 1 0 := by decide

/-! ## `∑ m_λ d_λ = C(1640,3)`

`Sym³` of a `d`-dimensional space has dimension `C(d+2,3)`, so the total over the table is
forced once `d = 1638` is. -/

/-- **`dim Sym³(𝒲₁₂) = C(1640,3) = 733 813 080`**, `Sym³` of a `1638`-dimensional space, the
total the table's `∑ m_λ d_λ` must meet. -/
theorem symCube_dim : Nat.choose (1638 + 2) 3 = 733813080 := by
  have h := Nat.descFactorial_eq_factorial_mul_choose 1640 3
  norm_num [Nat.descFactorial, Nat.factorial] at h ⊢
  omega

/-! ## The fusion arithmetic

Given the census figures, `O(12)`'s counts follow. -/

/-- The multiplicities of the six chiral pairs, as the record reports them. -/
def chiralMults : List ℕ := [2, 1, 1, 1, 1, 1]

/-- There are six pairs. -/
theorem chiral_pairs_count : chiralMults.length = 6 := by decide

/-- Their multiplicities sum to `7`. -/
theorem chiral_mult_sum : chiralMults.sum = 7 := by decide

/-- **The chiral mass is `14`**, being `2 · 7`, twelve chiral constituents carrying `7`
multiplicities on each side. -/
theorem chiral_mass : 2 * chiralMults.sum = 14 := by decide

/-- **`O(12)` sees `71` blocks**: the `77` `SO(12)`-constituents with each of the six chiral
pairs fused to one. -/
theorem blocks_fused : 77 - chiralMults.length = 71 := by decide

/-- **`O(12)` sees `184` multiplicities**: the `191` less the chiral mass `14`, plus the `7` the
fused pairs contribute once. -/
theorem mults_fused : 191 - 2 * chiralMults.sum + chiralMults.sum = 184 := by decide

/-- **The chain, assembled, exactly as the record states it**: `2+1+1+1+1+1 = 7`, chiral mass
`2·7 = 14`, `191 − 14 = 177` non-chiral, `177 + 7 = 184`, and `77 − 6 = 71`.

*The record calls this chain the reason the table is worth more than a recomputation: it uses
all four reported figures and would break under any single transcription error.* -/
theorem fusion_chain :
    chiralMults.sum = 7 ∧ 2 * chiralMults.sum = 14 ∧ 191 - 14 = 177 ∧ 177 + 7 = 184 ∧
      77 - chiralMults.length = 71 := by
  refine ⟨by decide, by decide, by decide, by decide, by decide⟩

/-! ## The `n = 10` corroboration

The audit records an independent check on the `n = 10` side: *"five associate merges lose `5`
blocks and `0` multiplicities, the modification rule loses `2` of each, giving exactly
`71 → 64` and `184 → 182`."* -/

/-- **The `n = 10` figures follow from the `n = 12` ones by the two recorded losses.** -/
theorem ten_corroboration : 71 - 5 - 2 = 64 ∧ 184 - 0 - 2 = 182 := by
  refine ⟨by decide, by decide⟩

/-! ## The statement, in the part that is a statement

`L63_dimension` is the `Lemma` half in full. The census half has no Lean proposition, for the
reason given at the head of this file. -/

/-- **L63, `Lemma` half.** `dim 𝒲₁₂ = 1638`, and that value is the dimension of the `D₆`
irreducible of highest weight `(2,2,0,0,0,0)`, the two closed forms returning the same
number. -/
theorem L63_dimension :
    weylDim 12 = 1638 ∧ wdim 7 6 3 2 1 0 = (1638 : ℤ) * wdim 5 4 3 2 1 0 :=
  ⟨weylDim_twelve, wdim_D6_two_two⟩

/-- **L63, the arithmetic the `Observation` half carries.** Given the census figures `77` and
`191` and the six chiral pairs at multiplicities `2,1,1,1,1,1`, the `O(12)` counts are `71` and
`184`, and the total `∑ m_λ d_λ` is `C(1640,3) = 733 813 080`.

**The census figures themselves are not derived here and cannot be stated here.** -/
theorem L63_fusion :
    77 - chiralMults.length = 71 ∧
    191 - 2 * chiralMults.sum + chiralMults.sum = 184 ∧
    Nat.choose (1638 + 2) 3 = 733813080 :=
  ⟨blocks_fused, mults_fused, symCube_dim⟩

end HamiltonsCubic.L63Statement
