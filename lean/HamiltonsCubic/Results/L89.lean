import HamiltonsCubic.Results.L83
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L89, `rank(μ|inv) = 14`, nullity `51`

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L89. The exactness argument is
algebra and stays imported; the counting and the two bound-direction findings are here.

**The rank-nullity closes against [L83](L83.lean)'s stored `65`**, so the two numbers L89
prints are one number and the table's, not an independent pair: `14 + 51 = 65`, and `65` is
the multiplicity moment `Σ C(m+1,2)` of the 24-block table.

**The same wrong-direction defect appears here and in [L90](L90.lean), in one file.** L90
infers an unmeasured rank from a measured one through `≤`; L89's display reads
`rank(A) = 14` *exactly* while the surrounding text calls `A` the **sampled** matrix with
`rank ≤ 14`. A sampled rank bounds from below what it measures and from above nothing, so no
reading of `A` supports the display. Recording it once as a class rather than twice as an
incident is what the two rounds together buy.

**And no measured link drops, for a reason about directions.** [L62](L62.lean)'s `≥ 13` is a
**lower** bound on the *restricted* map; full-space surjectivity gives an **upper** bound on
the *full* one. Those never combine, and the certificate route consumes `13`, not `14`, so
the `≤ 14` that transversality supplies is weaker than what is already proved.
-/

namespace HamiltonsCubic.Exactness

open HamiltonsCubic.Blocks

/-! ## The counts close against the table -/

/-- **`14 + 51 = 65`**, so the rank and nullity L89 prints partition the table's own
`Σ C(m+1,2)`. -/
theorem rank_nullity : 14 + 51 = 65 := by decide

/-- And `65` is exactly L83's multiplicity moment, not a separate measurement. -/
theorem sixty_five_from_table :
    (table.map (fun B => B.mult * (B.mult + 1) / 2)).sum = 65 := by decide

/-- So the nullity is determined by the rank once the table is fixed. -/
theorem nullity_determined {r : ℕ} (hr : r ≤ 65) (h : r = 14) : 65 - r = 51 := by omega

/-! ## Surjectivity is elementary -/

/-- **Every exponent at most `6` splits with both halves at most `3`.** A per-coordinate split:
the surjectivity of multiplication needs a split of the whole exponent vector into two of total
degree `3`, which this does not give (at `x₁⋯x₆` it returns degrees `6` and `0`). -/
theorem split_exists (e : ℕ) (he : e ≤ 6) : ∃ x y, x + y = e ∧ x ≤ 3 ∧ y ≤ 3 :=
  ⟨min e 3, e - min e 3, by omega, by omega, by omega⟩

/-! ## The bound directions never combine -/

/-- **A lower bound on the restricted map and an upper bound on the full one determine
neither.** Both `13` and `14` remain available, so nothing drops. -/
theorem directions_dont_combine :
    ∃ rres rfull : ℕ, 13 ≤ rres ∧ rres ≤ rfull ∧ rfull ≤ 14 ∧ rres = 13 := by
  exact ⟨13, 14, by omega, by omega, by omega, rfl⟩

theorem directions_dont_combine' :
    ∃ rres rfull : ℕ, 13 ≤ rres ∧ rres ≤ rfull ∧ rfull ≤ 14 ∧ rres = 14 := by
  exact ⟨14, 14, by omega, by omega, by omega, rfl⟩

/-- **The route consumes `13`, and `≤ 14` does not deliver it**: the bound leaves `14`
available, which the proved value excludes. So transversality is weaker than what is already
on the record. -/
theorem transversality_weaker : ∃ r : ℕ, r ≤ 14 ∧ r ≠ 13 := ⟨14, by omega, by omega⟩

/-! ## The display's direction -/

/-- **A sampled rank supports `≥`, never `=`.** So `rank(A) = 14` cannot be read off a
sampled `A` with `rank ≤ 14`: the two together leave `A`'s rank anywhere in `[0,14]` unless
the sample attains the cap, which is a separate statement. -/
theorem sampled_no_equality :
    ∃ rsample rtrue : ℕ, rsample ≤ rtrue ∧ rtrue ≤ 14 ∧ rsample ≠ 14 := by
  exact ⟨0, 14, by omega, by omega, by omega⟩

/-- What *does* license the equality is the sample attaining the cap, the same squeeze
[L90](L90.lean) needs. -/
theorem attained_cap {rsample rtrue : ℕ} (hs : rsample ≤ rtrue) (hcap : rtrue ≤ 14)
    (hatt : 14 ≤ rsample) : rsample = 14 ∧ rtrue = 14 := by
  constructor <;> omega

end HamiltonsCubic.Exactness
