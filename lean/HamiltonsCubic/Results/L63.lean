import Mathlib.Tactic.NormNum
import Mathlib.Tactic.DeriveFintype
import Mathlib.Data.Nat.Choose.Basic

/-!
# L63, the `n = 12` block table

[results.md](../../../results.md)'s Lemma L63. The dimension arithmetic and the chirality
bookkeeping are decided here; the constituent count itself is representation theory the base
layer has no types for and stays imported.

**A constraint the record states nowhere.** L63 gives four numbers, `77` `SO(12)`
constituents with `191` multiplicities, fusing to `71` blocks with `184` under orientation
reversal, and separately says **twelve** constituents are chiral. Those are not independent.
Six chiral pairs fuse, so `77 - 6 = 71` fixes the pair count; and each pair's two members
carry equal multiplicity `m`, contributing `2m` before fusion and `m` after, so
`191 - 184 = 7` forces the twelve chiral constituents to carry **total multiplicity `14`**.
That number appears nowhere on the record, and it is what the four printed ones require.

**The scale the file exists to justify.** `dim Sym³(𝒲₁₂) = C(1640,3) = 733,813,080` against
`7770` at `n = 5`, the reason [run_n12_weights.py](../../../scripts/runs/run_n12_weights.py)
works through the weight system rather than through matrices.
-/

namespace HamiltonsCubic.BlockTable12

/-! ## Dimensions -/

/-- `dim 𝒲ₙ = n(n+1)(n+2)(n-3)/12`, giving `1638` at `n = 12`. -/
theorem dim_weyl_twelve : 12 * 13 * 14 * 9 / 12 = 1638 := by norm_num

/-- The same formula at `n = 5` returns `35`, the dimension [L83](L83.lean) counts on. -/
theorem dim_weyl_five : 5 * 6 * 7 * 2 / 12 = 35 := by norm_num

/-- `dim Sym³(𝒲₁₂) = C(1640,3) = 733,813,080`. -/
theorem sym3_dim : 1640 * 1639 * 1638 / 6 = 733813080 := by norm_num

/-- The `n = 5` counterpart, `C(37,3) = 7770`. -/
theorem sym3_dim_five : 37 * 36 * 35 / 6 = 7770 := by norm_num

/-- The gap is five orders of magnitude, which is what rules out the matrix route. -/
theorem scale_gap : 7770 * 90000 < 1640 * 1639 * 1638 / 6 := by norm_num

/-- `Sym²(Λ²ℝ¹²)` has dimension `2211`, and `Λ²ℝ¹²` has `66`, the two sizes the script
names as the prototype's cost. -/
theorem lambda2_twelve : 12 * 11 / 2 = 66 := by norm_num

theorem sym2_lambda2_twelve : 67 * 66 / 2 = 2211 := by norm_num

/-! ## The chirality bookkeeping, and the number it forces -/

/-- **Six pairs fuse.** `77 - 6 = 71` fixes the pair count from the two block totals. -/
theorem pairs_fused : 77 - 6 = 71 := by decide

/-- **Twelve chiral constituents make six pairs.** -/
theorem chiral_pairs : 12 = 2 * 6 := by decide

/-- **And the multiplicity drop forces their total.** Each chiral pair carries `m` on each
member, `2m` before fusion and `m` after, so the drop is the sum of the six `m`s. With
`191 - 184 = 7`, the twelve chiral constituents carry total multiplicity `14`. -/
theorem multiplicity_drop : 191 - 184 = 7 := by decide

theorem chiral_total_multiplicity : 2 * (191 - 184) = 14 := by decide

/-- The constraint stated as one equation in the record's four printed numbers: writing `p`
for the number of fused pairs and `T` for the chiral constituents' total multiplicity,
`77 - p = 71` and `191 - T/2 = 184`. -/
theorem constraint (p T : ℕ) (hp : 77 - p = 71) (hp' : p ≤ 77) (hT : 191 - T / 2 = 184)
    (hT' : T / 2 ≤ 191) : p = 6 ∧ T / 2 = 7 := by
  omega

/-- Total multiplicity `14` across twelve chiral constituents exceeds `12`, so **they are not
all multiplicity-one blocks**, at least one chiral constituent repeats. -/
theorem some_chiral_repeats : 12 < 14 := by decide

end HamiltonsCubic.BlockTable12
