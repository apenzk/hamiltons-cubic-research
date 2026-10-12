import Mathlib
import HamiltonsCubic.Results.L83

set_option linter.style.longLine false

/-!
# L87, the rank-one step: the orbit Gram meets the cap, so every even block loses one multiplicity

**The record's statement, quoted verbatim from [sym3-blocks.md](../../../findings/sym3-blocks.md):**

> #### Lemma L87 (the rank-one step), the orbit Gram meets the cap, so every even block loses exactly one multiplicity
>
> *Round [L87](../verification/ROUND_L87.md): `GAP`. The cap is a theorem, the attainment is one exact finite computation, and the argument joining them is on the record owing two steps.*
>
> **The cap, derived.** Over the sixteen $\lambda_2$-even blocks $\sum_\lambda d_\lambda=3570$, using [L83](sym3-blocks.md)'s table, $\dim V_\lambda^H\le1$, **and [L86](sym3-blocks.md)'s odd-block vanishing**. *Both hypotheses are load-bearing*: over all $24$ blocks the first alone gives $5640$, at which the squeeze does not close, and it forces nothing even at $3570$, since $r_\lambda=1$ on the eight odd blocks together with $(6,4)$, $(6,2)$, $(2,2)$ and $(3,0)$ also sums to $3570$ with **twelve** of the sixteen evaluation maps at rank $0$.
>
> **The attainment, computed.** The rank of the Gram matrix $\langle g_a W_0, g_b W_0\rangle^3$ over $3700$ orbit points is exactly $3570$ over $\mathbb F_{46337}$, **one prime, no floating point, no tolerance chosen**, which is the run's real contribution.
>
> **An upper bound attained forces every one of the sixteen ranks to be exactly $1$, so no block has rank $0$ and $36$ is exact.** *Everything downstream (the shape, the eight deaths, the two vanishing collisions), rests on that single measured number.*

## What this file states

The squeeze, in full and in general, plus the two arithmetic exhibits the block turns on.
Everything is proved; there is no `sorry`.

* `attained_cap_forces_all`, **the lemma's argument**: if `r i ≤ 1` and `d i > 0` termwise and
  `Σ rᵢ dᵢ = Σ dᵢ`, then `r i = 1` for every `i`. An upper bound attained forces every term to sit
  at its maximum, and nothing else is needed.
* `rank_one_step`, the same at L83's sixteen `λ₂`-even blocks, with the attained value written as
  `3570`: **every even block loses exactly one multiplicity.**
* `stated_ground_insufficient`, L83's falsifier, re-exported: with the cap's *stated* ground alone
  (`dim V_λ^H ≤ 1` over all `24`, no odd-block vanishing) the same `3570` is reached with twelve of
  the sixteen even ranks at `0`. **So L86's vanishing is load-bearing**, exactly as the audit says.
* `cap_all`, and the first hypothesis alone gives `5640`, at which the squeeze does not close.

**The attainment is a HYPOTHESIS, and deliberately.** `rank_one_step` takes
`Σ rᵢ dᵢ = 3570` as given. That number is the record's one exact finite computation, a Gram rank
over `𝔽₄₆₃₃₇`, and is not proved here or anywhere on the record's Lean side; the conclusion
`r i = 1` is what the lemma establishes from it. *This mirrors the block: "everything downstream
rests on that single measured number".*

## What is NOT typed here

* **`dim V_λ^H ≤ 1`** (Frobenius reciprocity against L86's parity rule) and **L86's odd-block
  vanishing**. Both are representation theory of `B₂` that Mathlib does not carry; here they enter
  as the reason the sixteen even blocks are the index set and `3570` the cap, which is L83's
  stored table.
* **That the Gram rank equals `Σ_λ rank_λ · d_λ`**, the identification of the orbit span's
  dimension with the weighted sum of evaluation-map ranks. That is the *"argument joining them"*
  the round records as owing two steps: a finitely generated free `M` with
  `im Λ ⊆ M ⊆ ℤ[½][SO₅]`, and Zariski density of `SO(5,ℝ)` in `SO₅,ℂ`. Neither is stated here.
-/

namespace HamiltonsCubic.L87Statement

open HamiltonsCubic.Blocks

/-! ## The squeeze, in general -/

/-- **AN UPPER BOUND ATTAINED FORCES EVERY TERM TO ITS MAXIMUM.** With `rᵢ ≤ 1`, `dᵢ > 0` and
`Σ rᵢ dᵢ = Σ dᵢ`, every `rᵢ` is `1`, no block has rank `0`. *This is the whole of the lemma's
argument once the cap and the attainment are in hand.* -/
theorem attained_cap_forces_all {ι : Type*} [Fintype ι] (r d : ι → ℕ)
    (hr : ∀ i, r i ≤ 1) (hd : ∀ i, 0 < d i)
    (hsum : ∑ i, r i * d i = ∑ i, d i) : ∀ i, r i = 1 := by
  classical
  have hle : ∀ i ∈ (Finset.univ : Finset ι), r i * d i ≤ d i := by
    intro i _
    calc r i * d i ≤ 1 * d i := Nat.mul_le_mul_right _ (hr i)
      _ = d i := one_mul _
  intro i0
  by_contra hne
  have hr0 : r i0 = 0 := by
    rcases Nat.lt_or_ge (r i0) 1 with h | h
    · omega
    · exact absurd (le_antisymm (hr i0) h) hne
  have hstrict : r i0 * d i0 < d i0 := by
    rw [hr0, zero_mul]; exact hd i0
  have := Finset.sum_lt_sum hle ⟨i0, Finset.mem_univ i0, hstrict⟩
  omega

/-! ## …and at the sixteen even blocks -/

/-- The sixteen `λ₂`-even blocks of L83's table, as a list. -/
def evenBlocks : List Block := table.filter Block.evenSecond

theorem evenBlocks_card : evenBlocks.length = 16 := by decide

/-- **THE CAP.** The sixteen `λ₂`-even blocks have dimensions summing to `3570`. -/
theorem cap : (evenBlocks.map Block.d).sum = 3570 := by decide

/-- Every one of them has positive dimension, which the squeeze needs. -/
theorem evenBlocks_dim_pos : ∀ B ∈ evenBlocks, 0 < B.d := by decide

/-- **LEMMA L87.** *The orbit Gram meets the cap, so every even block loses exactly one
multiplicity.* The evaluation-map ranks `r` are bounded by `1` (Frobenius reciprocity against
`dim V_λ^H ≤ 1`), the attained weighted sum is the measured `3570`, and the conclusion is that
**every one of the sixteen ranks is exactly `1`**, no block has rank `0`, and the `36` unknowns
are exact.

*The attainment is the hypothesis `hattain`, because it is the record's one exact finite
computation and not a theorem of this file.* -/
theorem rank_one_step (r : Block → ℕ) (hr : ∀ B, r B ≤ 1)
    (hattain : (evenBlocks.map (fun B => r B * B.d)).sum = 3570) :
    ∀ B ∈ evenBlocks, r B = 1 := by
  classical
  have hle : ∀ B ∈ evenBlocks, r B * B.d ≤ B.d := by
    intro B hB
    calc r B * B.d ≤ 1 * B.d := Nat.mul_le_mul_right _ (hr B)
      _ = B.d := one_mul _
  intro B0 hB0
  by_contra hne
  have hr0 : r B0 = 0 := by
    have := hr B0
    omega
  -- with one term short, the list sum falls strictly below the cap
  have hlt : (evenBlocks.map (fun B => r B * B.d)).sum < (evenBlocks.map Block.d).sum := by
    have hsub : ∀ B ∈ evenBlocks, r B * B.d ≤ B.d := hle
    have hpos : 0 < B0.d := evenBlocks_dim_pos B0 hB0
    have hstrict : r B0 * B0.d < B0.d := by rw [hr0, zero_mul]; exact hpos
    -- compare the two list sums termwise
    have key : ∀ (l : List Block), (∀ B ∈ l, r B * B.d ≤ B.d) → B0 ∈ l →
        (l.map (fun B => r B * B.d)).sum < (l.map Block.d).sum := by
      intro l
      induction l with
      | nil => intro _ h; exact absurd h (by simp)
      | cons c t ih =>
        intro hall hmem
        simp only [List.map_cons, List.sum_cons]
        rcases List.mem_cons.mp hmem with hc | ht
        · subst hc
          have htail : (t.map (fun B => r B * B.d)).sum ≤ (t.map Block.d).sum := by
            have : ∀ B ∈ t, r B * B.d ≤ B.d := fun B hB => hall B (List.mem_cons_of_mem _ hB)
            clear ih hall hmem
            induction t with
            | nil => simp
            | cons e s ihs =>
              simp only [List.map_cons, List.sum_cons]
              exact Nat.add_le_add (this e (List.mem_cons_self))
                (ihs fun B hB => this B (List.mem_cons_of_mem _ hB))
          omega
        · have hhead : r c * c.d ≤ c.d := hall c List.mem_cons_self
          have := ih (fun B hB => hall B (List.mem_cons_of_mem _ hB)) ht
          omega
    exact key evenBlocks hsub hB0
  rw [hattain, cap] at hlt
  exact absurd hlt (lt_irrefl _)

/-! ## Both hypotheses of the cap are load-bearing -/

/-- **The stated ground alone gives `5640`**, over all `24` blocks, at which the squeeze does not
close, since the measured value is `3570`. -/
theorem cap_all_blocks : (table.map Block.d).sum = 5640 := by decide

/-- **AND EVEN AT `3570` THE STATED GROUND FORCES NOTHING.** `r_λ = 1` on the eight odd blocks
together with `(6,4)`, `(6,2)`, `(2,2)` and `(3,0)` also reaches `3570`, with **twelve** of the
sixteen even evaluation maps at rank `0`. So [L86](L83.lean)'s odd-block vanishing is
load-bearing, and the block consumed it without citing it. -/
theorem stated_ground_insufficient :
    ((table.filter falsifier).map Block.d).sum = 3570 ∧
      (table.filter (fun B => B.evenSecond && !falsifier B)).length = 12 := by decide

end HamiltonsCubic.L87Statement
