import Mathlib.Tactic.NormNum
import Mathlib.Tactic.DeriveFintype

/-!
# L83, L86, L87, the 24-block table and everything the record counts on it

The table is read from [findings/sym3-blocks.md](../../../findings/sym3-blocks.md)'s
`## The 24 blocks`, whose weights and multiplicities are the imported content; the
dimension column is arithmetic, and this file **derives it** from Weyl's `B₂` formula
rather than trusting the printed entries.

Everything below is `decide`/`norm_num`, kernel-checked. `native_decide` is not used.

The point of the file: three rounds of the record's own audits re-summed these numbers
by hand, and the arithmetic exhibit that [L87](../../../findings/sym3-blocks.md)'s cap
rests on was produced by a single reader. Here the sums are the kernel's.
-/

namespace HamiltonsCubic.Blocks

/-- A block of `Sym³ 𝒲₅`: a highest weight `(a, b)` for `B₂` with its multiplicity. -/
structure Block where
  a : ℕ
  b : ℕ
  mult : ℕ
deriving DecidableEq, Repr

/-- Weyl's dimension formula for `B₂ = so(5)`, in the `e`-basis:
`dim V₍ₐ,♭₎ = (2a+3)(2b+1)(a-b+1)(a+b+2) / 6`.

Stated with `a ≥ b` in mind; every block of the table satisfies it, checked below. -/
def dim (a b : ℕ) : ℕ := (2 * a + 3) * (2 * b + 1) * (a - b + 1) * (a + b + 2) / 6

/-- The 24 blocks, exactly as the record's table lists them. -/
def table : List Block :=
  [ ⟨4, 2, 4⟩, ⟨2, 2, 4⟩,
    ⟨3, 2, 3⟩,
    ⟨5, 2, 2⟩, ⟨4, 3, 2⟩, ⟨4, 4, 2⟩, ⟨4, 1, 2⟩, ⟨3, 1, 2⟩, ⟨4, 0, 2⟩, ⟨2, 1, 2⟩,
      ⟨3, 0, 2⟩, ⟨2, 0, 2⟩,
    ⟨6, 6, 1⟩, ⟨6, 4, 1⟩, ⟨6, 3, 1⟩, ⟨6, 2, 1⟩, ⟨6, 0, 1⟩, ⟨5, 4, 1⟩, ⟨5, 3, 1⟩,
      ⟨5, 1, 1⟩, ⟨5, 0, 1⟩, ⟨3, 3, 1⟩, ⟨1, 0, 1⟩, ⟨0, 0, 1⟩ ]

/-- The dimension the formula gives for a block. -/
def Block.d (B : Block) : ℕ := dim B.a B.b

/-- second entry even, the parity rule that selects the blocks L86's vanishing applies to. -/
def Block.evenSecond (B : Block) : Bool := B.b % 2 == 0

theorem card_table : table.length = 24 := by decide

/-! ## L83, the four closures, and the dimension column derived rather than read -/

/-- The dimension column reproduces the printed entries, all 24, from the formula. -/
theorem dims_match :
    table.map Block.d =
      [220, 35, 105, 390, 231, 165, 154, 81, 55, 35, 30, 14,
       455, 810, 770, 625, 140, 429, 455, 260, 91, 84, 5, 1] := by decide

/-- `Σ mλ dλ = 7770`, and it is `C(37,3)`, the one externally anchored closure,
`dim Sym³ 𝒲₅` with `dim 𝒲₅ = 35`. -/
theorem sum_mult_dim : (table.map (fun B => B.mult * B.d)).sum = 7770 := by decide

theorem seven_seven_seven_zero : 37 * 36 * 35 / 6 = 7770 := by norm_num

/-- The three moments of the multiplicity column: `Σ m⁰ = 24`, `Σ m = 41`,
`Σ C(m+1,2) = 65`. The record calls these four independent closures; they are one
column read three ways, which is why `7770` is the only external one. -/
theorem sum_mult : (table.map Block.mult).sum = 41 := by decide

theorem sum_unknowns : (table.map (fun B => B.mult * (B.mult + 1) / 2)).sum = 65 := by decide

/-- `Σ C(m,2) = 24` and `Σ m² = 89`, the antisymmetric and Hermitian counts of L88. -/
theorem sum_antisym : (table.map (fun B => B.mult * (B.mult - 1) / 2)).sum = 24 := by decide

theorem sum_hermitian : (table.map (fun B => B.mult * B.mult)).sum = 89 := by decide

/-- The twelve multiplicity-one dimensions sum to `4125`. -/
theorem sum_mult_one :
    ((table.filter (fun B => B.mult == 1)).map Block.d).sum = 4125 := by decide

/-! ## L86, L87, the parity rule, the cap, and what the cap's stated ground gives -/

/-- The parity rule selects exactly sixteen blocks. -/
theorem card_even : (table.filter Block.evenSecond).length = 16 := by decide

/-- **The cap.** The sixteen `λ₂`-even blocks have dimensions summing to `3570`. -/
theorem cap_even : ((table.filter Block.evenSecond).map Block.d).sum = 3570 := by decide

/-- **The cap's stated ground, alone, gives `5640`**, the sum over all 24 blocks,
which is what `dim V_λ^H ≤ 1` yields without L86's odd-block vanishing. At `5640`
the squeeze does not close. -/
theorem cap_all : (table.map Block.d).sum = 5640 := by decide

/-- The eight `λ₂`-odd blocks carry `2070`, and `3570 + 2070 = 5640`. -/
theorem odd_blocks : ((table.filter (fun B => !B.evenSecond)).map Block.d).sum = 2070 := by decide

theorem card_odd : (table.filter (fun B => !B.evenSecond)).length = 8 := by decide

/-! ## The falsifier

Under `dim V_λ^H ≤ 1` alone the attained value `3570` forces nothing. Take
`r_λ = 1` on all eight odd blocks together with `(6,4)`, `(6,2)`, `(2,2)` and `(3,0)`,
and `r_λ = 0` elsewhere: the weighted sum is again `3570`, with **twelve** of the
sixteen even evaluation maps at rank `0`.

This is the exhibit [L87](../../../findings/sym3-blocks.md) now carries. It was
produced by one reader's hand arithmetic; here it is decided.
-/

/-- The falsifying support: the odd blocks, plus four even ones. -/
def falsifier (B : Block) : Bool :=
  !B.evenSecond || (B.a == 6 && B.b == 4) || (B.a == 6 && B.b == 2)
            || (B.a == 2 && B.b == 2) || (B.a == 3 && B.b == 0)

/-- The falsifying assignment reaches the same `3570`. -/
theorem falsifier_sum : ((table.filter falsifier).map Block.d).sum = 3570 := by decide

/-- …with twelve of the sixteen even blocks contributing nothing. -/
theorem falsifier_kills_twelve :
    (table.filter (fun B => B.evenSecond && !falsifier B)).length = 12 := by decide

/-- So attaining `3570` is consistent with twelve even blocks at rank `0`:
**the written hypothesis does not force "every even block loses exactly one
multiplicity"**, and the conclusion needs L86's vanishing, which the block
consumed and did not cite. -/
theorem stated_ground_insufficient :
    ((table.filter falsifier).map Block.d).sum = ((table.filter Block.evenSecond).map Block.d).sum
      ∧ (table.filter (fun B => B.evenSecond && !falsifier B)).length = 12 := by decide

/-! ## L86's surviving shape: 25 multiplicities and 36 unknowns -/

/-- The multiplicity surviving the orbit constraint at rank one: one less on each `λ₂`-even block. -/
def Block.surv (B : Block) : ℕ := if B.evenSecond then B.mult - 1 else B.mult

/-- **25 multiplicities survive**, L86's count at rank one on every even block. -/
theorem surviving_25 : (table.map Block.surv).sum = 25 := by decide

/-- **The shape**: two `3×3`, five `2×2` and nine scalar blocks, and eight blocks die outright. -/
theorem surviving_shape :
    (table.filter (fun B => B.surv == 3)).length = 2 ∧ (table.filter (fun B => B.surv == 2)).length = 5 ∧
      (table.filter (fun B => B.surv == 1)).length = 9 ∧ (table.filter (fun B => B.surv == 0)).length = 8 := by
  decide

/-- **36 unknowns**, the symmetric Gram entries of the surviving blocks, and `65 = 36 + 29`. -/
theorem unknowns_36 : (table.map (fun B => B.surv * (B.surv + 1) / 2)).sum = 36 := by decide

theorem split_65 : (table.map (fun B => B.mult * (B.mult + 1) / 2)).sum
    = (table.map (fun B => B.surv * (B.surv + 1) / 2)).sum + 29 := by decide

/-- **The eight dead blocks are exactly the record's**: `(0,0)`, `(1,0)`, `(5,0)`, `(5,4)`, `(6,0)`, `(6,2)`, `(6,4)`,
`(6,6)`, in table order. -/
theorem dead_blocks : (table.filter (fun B => B.surv == 0)).map (fun B => (B.a, B.b))
    = [(6, 6), (6, 4), (6, 2), (6, 0), (5, 4), (5, 0), (1, 0), (0, 0)] := by decide

end HamiltonsCubic.Blocks
