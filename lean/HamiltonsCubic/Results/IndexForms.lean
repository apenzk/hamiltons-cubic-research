import Mathlib.Tactic.NormNum

/-!
# The value index's own arithmetic

[INDEX-values.md](../../../findings/INDEX-values.md) carries twelve rows that give both a
decimal and an exact form, `d = √(a/b)`. **Nothing checks one against the other**, and the
index is the file the record tells readers to consult before calling a number new, so an
error here would propagate to every search that used it.

All twelve check. Each is bracketed below: `d⁻² < a/b < d⁺²`, with `d∓` the printed value
moved one unit in its last place.

The index also pairs one value with a closed form, `0.836660 = √(7/10)` is
*"`𝔰𝔲(3)` adjoint; also the Type II closed form `θ² = 4(n-1)/(n(n-3))` at `n = 8`"*, and
that evaluation is checked too.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.IndexForms

/-- A printed decimal `d` agrees with `a/b` when `a/b` lies between the squares of `d`
moved one unit down and up in its last printed place. -/
def agrees (lo hi a b : ℚ) : Prop := lo ^ 2 < a / b ∧ a / b < hi ^ 2

theorem r_1_228239 : agrees 1.228238 1.228240 264 175 := by
  constructor <;> norm_num [agrees]

theorem r_1_224745 : agrees 1.224744 1.224746 3 2 := by
  constructor <;> norm_num [agrees]

theorem r_1_115547 : agrees 1.115546 1.115548 56 45 := by
  constructor <;> norm_num [agrees]

theorem r_1_095445 : agrees 1.095444 1.095446 6 5 := by
  constructor <;> norm_num [agrees]

theorem r_0_836660 : agrees 0.836659 0.836661 7 10 := by
  constructor <;> norm_num [agrees]

theorem r_0_720082 : agrees 0.720081 0.720083 14 27 := by
  constructor <;> norm_num [agrees]

theorem r_0_596068 : agrees 0.596067 0.596069 275 774 := by
  constructor <;> norm_num [agrees]

theorem r_0_759555 : agrees 0.759554 0.759556 15 26 := by
  constructor <;> norm_num [agrees]

theorem r_0_699379 : agrees 0.699378 0.699380 45 92 := by
  constructor <;> norm_num [agrees]

theorem r_0_686607 : agrees 0.686606 0.686608 33 70 := by
  constructor <;> norm_num [agrees]

theorem r_0_852944 : agrees 0.852943 0.852945 275 378 := by
  constructor <;> norm_num [agrees]

theorem r_0_745356 : agrees 0.745355 0.745357 5 9 := by
  constructor <;> norm_num [agrees]

/-! ## The Type II closed form at `n = 8` -/

/-- `θ² = 4(n-1)/(n(n-3))` at `n = 8` is `28/40 = 7/10`, the index's `𝔰𝔲(3)` adjoint
value, reached from a formula rather than from the point. -/
theorem type_two_at_8 : 4 * ((8 : ℚ) - 1) / (8 * (8 - 3)) = 7 / 10 := by norm_num

/-- So the index's pairing holds: two different constructions give one value. -/
theorem type_two_matches : 4 * ((8 : ℚ) - 1) / (8 * (8 - 3)) = 7 / 10 ∧
    agrees 0.836659 0.836661 7 10 := by
  refine ⟨by norm_num, ?_⟩
  constructor <;> norm_num [agrees]

/-! ## Two of the forms are cleaner than they look

`√(5/9) = √5/3` and `√(3/2)` aside, `√(275/378)` and `√(275/774)` share a numerator,
`Gr_ℂ(2,3)` at `n = 12` and the `0.852944` row, which the index does not remark on.
-/

theorem shared_numerator : (275 : ℚ) / 378 ≠ 275 / 774 := by norm_num

theorem ratio_of_the_two : (275 : ℚ) / 378 / (275 / 774) = 774 / 378 := by norm_num

theorem ratio_reduced : (774 : ℚ) / 378 = 43 / 21 := by norm_num

/-- `√(5/9)` is `√5/3`, a form the index writes as a quotient of non-squares. -/
theorem five_ninths : (5 : ℚ) / 9 = 5 / 3 ^ 2 := by norm_num

/-! ## What this settles

**Settled**: that all twelve of the index's decimal-and-form pairs agree, each to the
last place printed; that its one closed-form pairing evaluates correctly at `n = 8`; and
that two of its forms share the numerator `275`, in a ratio of `43/21`, which it does not
remark on.

**Why it matters**: the index is the file the record directs readers to before calling a
number new, and its preamble records three refutations missed by searching the wrong way.
**Nothing else checks its arithmetic.**
-/

end HamiltonsCubic.IndexForms
