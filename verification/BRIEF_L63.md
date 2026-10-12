# Brief, round L63

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement as the findings file carries it ([findings/sym3-stability.md](../findings/sym3-stability.md) line 58, under the heading at line 44)

$\dim\Weyl_{12}=1638$, the irreducible of highest weight $(2,2,0,0,0,0)$ for $D_6$. $\mathrm{Sym}^3(\Weyl_{12})$ carries $77$ $SO(12)$ constituents with $191$ multiplicities; twelve are chiral, in six pairs with $\lambda_6\ne0$ at multiplicities $2,1,1,1,1,1$, and an orientation-reversing element fuses each pair into one $O(12)$ block. So $O(12)$ sees $\mathbf{71}$ blocks and $\mathbf{184}$ multiplicities, with $\sum m_\lambda d_\lambda=\binom{1640}3=733\,813\,080$.

## Passage B, the canonical statement, landscape form ([results.md](../results.md) line 222)

- **Lemma L63 (direct). The $n=12$ block table.** $\dim\mathcal W_{12}=1638$, the $D_6$ irreducible of highest weight $(2,2,0,0,0,0)$; $\mathrm{Sym}^3(\mathcal W_{12})$ carries $77$ $SO(12)$ constituents with $191$ multiplicities, and orientation reversal fuses six chiral pairs so that $O(12)$ sees $71$ blocks and $184$ multiplicities, with $\sum m_\lambda d_\lambda=\binom{1640}3$.

## Passage C, the canonical statement, detail form ([results.md](../results.md) line 759, under the heading at line 757)

$\mathcal W_{12}$ is the irreducible $D_6$-module of highest weight $(2,2,0,0,0,0)$ and dimension $1638$. Its symmetric cube carries $77$ $SO(12)$-constituents with total multiplicity $191$; twelve of them are chiral, in six pairs with $\lambda_6\ne0$ and multiplicities $2,1,1,1,1,1$, and an orientation-reversing element of $O(12)$ fuses each pair into one block, so $O(12)$ sees $71$ blocks with $184$ multiplicities and $\sum_\lambda m_\lambda d_\lambda=\binom{1640}3=733\,813\,080$. The table is the size of the certificate problem at the threshold dimension; it supplies the unknowns and no certificate.

## Passage D, the argument section the block's pointer names ([findings/sym3-stability.md](../findings/sym3-stability.md) lines 3-36)

## What is claimed

The decomposition of $\mathrm{Sym}^3(\mathcal W_n)$ into $O(n)$-irreducibles (which blocks occur, with which multiplicities), is **the same for every $n\ge12$**, and $n=12$ is exactly where that begins. At $n\ge12$ the table is $71$ blocks, $184$ multiplicities, $477$ unknowns; at $n=10$ it is $64$, $182$, $493$.

## The argument

1. **Six rows.** $\mathcal W_n$ is the $O(n)$-irreducible labelled by the partition $(2,2)$, which has two rows. In the stable range the $O(n)$ tensor product is the **Newell–Littlewood** rule (it carries the trace contractions that Littlewood–Richardson lacks) and it cannot raise the row count above the sum of its inputs'. So every constituent of $\mathrm{Sym}^3(\mathcal W_n)$ has $\lambda'_1\le 6$.

2. **The labelling condition.** A partition $\lambda$ labels an irreducible of $O(n)$ exactly when $\lambda'_1+\lambda'_2\le n$, the first two **column** lengths, boundary inclusive. Outside that range Littlewood's modification rules rewrite or cancel the label, which is what makes small-$n$ decompositions move.

3. **The maximum is $12$.** Over the constituents, $\max(\lambda'_1+\lambda'_2)=12$, attained at $(2,2,2,2,2,2)$ (six rows of length two, so both column lengths are $6$), with multiplicity $1$. *The bound is two lines: $\lambda'_2\le\lambda'_1\le6$ gives $\le12$, and equality forces $\lambda'_1=\lambda'_2=6$, six parts each at least two, which at total weight $12$ makes every part exactly two, so the attaining label is unique. It is inadmissible at $n=11$ and admissible at $n=12$, while every other constituent is already admissible at $11$: the threshold turns on this one label ([Sym3Threshold.lean](../lean/HamiltonsCubic/Results/Sym3Threshold.lean)).*

4. **From labels to multiplicities.** **Koike–Terada**: the universal character ring maps onto $R(O(n))$ by a *ring* homomorphism commuting with $\mathrm{Sym}^3$, so a decomposition computed once in the stable ring specialises to every $n$ above the threshold. Without this step, stability of the label *set* would not give stability of the *multiplicities*.

Hence for $n\ge12$ every constituent is already a legitimate $O(n)$ label, no modification rule fires, and the table cannot move. **$n=12$ is the threshold itself.**

## Why $n=10$ differs, by three mechanisms

Seven blocks are missing at $n=10$, and the failed label accounts for one of them. Two come from the modification rule ($(2,2,2,2,2,2)$ and the $(2,2,2,2,2)$ block it cancels against) and five from **associate identification**, where $\lambda$ and its associate become the same $O(10)$ irreducible. Neither mechanism operates at $n\ge12$.

## Verification

Two reviewers, independently, on identical briefs, by routes sharing no code with the derivation or with each other.

| route | result |
|---|---|
| Littlewood's inverse restriction formula in the ring of symmetric functions, no modification rule | $71/184/477$, and $64/182/493$ at $n=10$ |
| Weyl character formula, block by block | $n=11\to70/183$, $n=12\to77/191$ (SO), $n=13\to71/184$, zero mismatches |
| $\sum m_\lambda\dim_{O(n)}[\lambda]=\binom{\dim\mathcal W_n+2}{3}$ on one fixed table | holds at $n=12,13,14,16,18$; **fires** at $n=10$ |
| the same identity for $\mathrm{Sym}^2$ at $n=8$ and $\mathrm{Sym}^4$ at $n=16$ | the $n=4k$ boundary confirmed at $k=2,3,4$ |

The $n=12$ count of $77$ rather than $71$ is the six six-row labels splitting at $\ell=n/2$, so the self-associate boundary labels are present as full $O(12)$ irreducibles. The boundary is pinned by the Weyl tensor itself: $\dim\mathcal W_3=0$ where $\lambda'_1+\lambda'_2=n+1$, and $\dim\mathcal W_4=10=n$, no room for an off-by-one in either direction.

[run_n12_stability.py](../scripts/runs/run_n12_stability.py), [REVIEW_r224.md](../reviews/REVIEW_r224.md), [REVIEW_r225.md](../reviews/REVIEW_r225.md).

## Passage E, the Lean statement ([lean/HamiltonsCubic/Results/L63Statement.lean](../lean/HamiltonsCubic/Results/L63Statement.lean), whole file, 161 lines)

```lean
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

```

## Definitions

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$ under $O(n)$ and $SO(n)$; $D_6=\mathfrak{so}(12)$ weights are written in the standard orthogonal coordinates $(\lambda_1,\dots,\lambda_6)$; a constituent is chiral when $\lambda_6\ne0$.
- **This loop does no numerical work.** A decomposition obtained by running a program, and a table reporting such runs, are evidence the brief quotes, not arguments; say which claims rest on them.

## What to attack, beyond the standing list

1. **$\dim\mathcal W_{12}=1638$ and the highest weight $(2,2,0,0,0,0)$**: which argument on file establishes each, by hand.
2. **The census**: $77$ constituents, $191$ multiplicities, twelve chiral in six pairs at multiplicities $2,1,1,1,1,1$. **Whether any passage derives it**, or whether it rests on a run, and what label that makes the claim.
3. **The fusion**: that an orientation-reversing element fuses each chiral pair into one $O(12)$ block, and the arithmetic $77\to71$, $191\to184$, given the census.
4. **$\sum_\lambda m_\lambda d_\lambda=\binom{1640}3$**: that $\binom{1640}3=\dim\mathrm{Sym}^3\mathcal W_{12}$, and whether the sum over the table is shown equal to it or asserted.
5. **Passage D against Passage A**: whether the named section's argument (the row bound, the labelling condition, the maximum, Koike–Terada) proves any of Passage A's figures, or proves a different statement, stability of the table for $n\ge12$.
6. **Passage D's steps**, as far as they bear on Passage A: the Newell–Littlewood row bound, the labelling condition $\lambda'_1+\lambda'_2\le n$, and the specialisation of multiplicities by Koike–Terada, **each against a filed source or its absence named**.
7. **Passage C's sentence** "the table is the size of the certificate problem at the threshold dimension; it supplies the unknowns and no certificate".
8. **Passage E against Passages A and C**: what is typed, what the file says cannot be stated, and whether the label it follows matches the canon's.
9. The boundary: $n=10,11,12,13$ as Passage D reports them, and the self-associate labels at $\ell=n/2$.

