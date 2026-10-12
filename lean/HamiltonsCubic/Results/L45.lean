import Mathlib.Tactic.NormNum
import Mathlib.Tactic.DeriveFintype
import Mathlib.Tactic.Ring
import Mathlib.Data.Rat.Defs

/-!
# L45, the ten triples, and the multiplicities the canon had wrong

[target.md](../../../findings/target.md)'s Lemma L45. Its bookkeeping is combinatorics on
the ten multisets of size three drawn from `{I, Y, W}`, and every count the audit corrects is
decided here.

**The corrected multiplicities.** [results.md](../../../results.md) recorded the survivors as
carrying `1, 3, 3, 6`. They carry `1, 3, 1, 3, 1` (five numbers, not four) and **no survivor
has weight `6`**: the only weight-`6` triple is the all-distinct `(I,Y,W)`, which is a
vanisher.

**The mechanism count.** `Φ(I,W) = 0` annihilates exactly the triples containing **both** an
`I` and a `W`, and there are **three** of them. The remaining two vanishers `(I,I,Y)` and
`(Y,W,W)` contain no `I`–`W` pair at all, so they need a different mechanism, which the
block does not name.

**The partition.** `18 + 9 = 27 = 3³`.
-/

namespace HamiltonsCubic.Triples

/-- A triple, as the counts of `I`, `Y` and `W`. -/
structure T where
  i : ℕ
  y : ℕ
  w : ℕ
deriving DecidableEq, Repr

/-- The multinomial weight `3!/(i! y! w!)`. -/
def T.mult (t : T) : ℕ :=
  Nat.factorial 3 / (Nat.factorial t.i * Nat.factorial t.y * Nat.factorial t.w)

/-- The ten multisets of size three from three symbols. -/
def all : List T :=
  [ ⟨3, 0, 0⟩, ⟨0, 3, 0⟩, ⟨0, 0, 3⟩,
    ⟨2, 1, 0⟩, ⟨2, 0, 1⟩, ⟨1, 2, 0⟩, ⟨0, 2, 1⟩, ⟨1, 0, 2⟩, ⟨0, 1, 2⟩,
    ⟨1, 1, 1⟩ ]

theorem card_all : all.length = 10 := by decide

theorem all_sum_three : all.all (fun t => t.i + t.y + t.w == 3) = true := by decide

/-- Every ordered triple is accounted for: the weights sum to `3³ = 27`. -/
theorem weights_total : (all.map T.mult).sum = 27 := by decide

/-! ## Which five survive -/

/-- The survivors, read off the block's displayed decomposition:
`c³(n-1)‖I‖²`, `3c⟨I,Φ(Y)⟩`, `⟨Y,Φ(Y)⟩`, `3⟨W,Φ(Y)⟩`, `⟨W,Q(W)⟩`. -/
def survivors : List T := [⟨3, 0, 0⟩, ⟨1, 2, 0⟩, ⟨0, 3, 0⟩, ⟨0, 2, 1⟩, ⟨0, 0, 3⟩]

def vanishers : List T := all.filter (fun t => ¬ survivors.contains t)

theorem card_survivors : survivors.length = 5 := by decide

theorem card_vanishers : vanishers.length = 5 := by decide

/-- **The multiplicities are `1, 3, 1, 3, 1`**, in the display's own order, five numbers,
against the canon's four. -/
theorem survivor_multiplicities : survivors.map T.mult = [1, 3, 1, 3, 1] := by decide

/-- **No survivor carries weight `6`.** -/
theorem no_survivor_six : survivors.all (fun t => ¬ (t.mult == 6)) = true := by decide

/-- **The only weight-`6` triple is the all-distinct one, and it is a vanisher.** -/
theorem six_is_all_distinct : all.filter (fun t => t.mult == 6) = [⟨1, 1, 1⟩] := by decide

theorem all_distinct_vanishes : vanishers.contains ⟨1, 1, 1⟩ = true := by decide

/-- **The partition: `18 + 9 = 27`.** -/
theorem partition : (vanishers.map T.mult).sum = 18 ∧ (survivors.map T.mult).sum = 9 := by
  constructor <;> decide

/-! ## One mechanism kills three, and two are left unexplained -/

/-- A triple pairs `I` with `W` exactly when it contains both. -/
def T.pairsIW (t : T) : Bool := 0 < t.i && 0 < t.w

/-- **`Φ(I,W) = 0` annihilates exactly three triples**, by the total symmetry of `T`,
`(I,I,W)`, `(I,W,W)` and `(I,Y,W)`. -/
theorem three_killed_by_mechanism :
    (all.filter T.pairsIW) = [⟨2, 0, 1⟩, ⟨1, 0, 2⟩, ⟨1, 1, 1⟩] := by decide

/-- **And all three are vanishers**, so the mechanism explains three of the five. -/
theorem mechanism_within_vanishers :
    (all.filter T.pairsIW).all (fun t => vanishers.contains t) = true := by decide

/-- **The remaining two vanishers carry no `I`–`W` pair**: `(I,I,Y)` has no `W` and
`(Y,W,W)` has no `I`, so neither is reachable by that mechanism. -/
theorem two_unexplained :
    vanishers.filter (fun t => ¬ t.pairsIW) = [⟨2, 1, 0⟩, ⟨0, 1, 2⟩] := by decide

/-! ## Parity, the `W`-even and `W`-odd split -/

/-- The `W`-even survivors are exactly the three with no `W`; the `W`-odd two are the ones
the display groups with `⟨W,Q(W)⟩`. -/
theorem even_survivors :
    survivors.filter (fun t => t.w % 2 == 0) = [⟨3, 0, 0⟩, ⟨1, 2, 0⟩, ⟨0, 3, 0⟩] := by decide

theorem odd_survivors :
    survivors.filter (fun t => t.w % 2 == 1) = [⟨0, 2, 1⟩, ⟨0, 0, 3⟩] := by decide

/-- The two weight-`3` survivors are exactly the ones the display prints with a leading `3`,
so the `3` is the multinomial weight and not part of the constant. -/
theorem weight_three_survivors :
    survivors.filter (fun t => t.mult == 3) = [⟨1, 2, 0⟩, ⟨0, 2, 1⟩] := by decide

end HamiltonsCubic.Triples
