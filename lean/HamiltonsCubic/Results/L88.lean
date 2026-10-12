import HamiltonsCubic.Results.L83
import Mathlib.Tactic.Ring

/-!
# L88, the restricted counts, and where they come from

`47 = 36 + 11` is the orbit-restricted form of `89 = 65 + 24`. The record states
the identity and calls it *"the same theorem, transported through L86's parity rule
and L87's rank-one step"*, and argues the transport nowhere.

This file does the arithmetic half of that sentence and leaves the other half owed,
exactly where round [L62](../../../verification/ROUND_L62.md) placed it.

**The restricted shape is not retyped.** `certShape` below is the `shape` field of
[scripts/runs/n5_certificate.json](../../../scripts/runs/n5_certificate.json), the
stored certificate the whole `n = 5` route rests on.

**What the agreement is worth.** The producer applies the parity subtraction itself, at
[run_n5_assemble.py:660](../../../scripts/runs/run_n5_assemble.py),
`SURV = {lam: len(ADAPTED[lam]) - (1 if lam[1] % 2 == 0 else 0) ...}`, so the stored
shape cannot disagree about which blocks lose a multiplicity, and this file does not
witness the rank-one step. What it does witness is L83's **multiplicity column**, which
enters the certificate as the independently constructed `len(ADAPTED[lam])`: the two
agree block by block, which they could have failed to do. [CertShape](CertShape.lean)
carries that comparison over the `blocks` field, which this file does not read.

Everything is `decide`, kernel-checked, no `native_decide`.
-/

namespace HamiltonsCubic.Blocks

/-- The multiplicity a block keeps under the orbit constraint: an odd-`b` block
survives whole, an even-`b` block loses exactly one, L86's parity rule together
with L87's rank-one step. -/
def Block.restricted (B : Block) : ℕ := if B.evenSecond then B.mult - 1 else B.mult

/-- The blocks that survive the orbit constraint with something left. -/
def restrictedTable : List Block :=
  table.filter (fun B => 0 < B.restricted)

/-- The `shape` field of `scripts/runs/n5_certificate.json`, verbatim. -/
def certShape : List ℕ := [3, 3, 2, 1, 2, 1, 2, 1, 2, 2, 1, 1, 1, 1, 1, 1]

/-! ## The rank-one step predicts the stored certificate's shape -/

/-- Sixteen blocks survive, which is the number of Hermitian blocks the certificate
carries. -/
theorem card_restricted : restrictedTable.length = 16 := by decide

theorem card_certShape : certShape.length = 16 := by decide

/-- Both lists take values in `{1, 2, 3}` only. -/
theorem values_small :
    (restrictedTable.map Block.restricted).all (fun m => 1 ≤ m && m ≤ 3)
      && certShape.all (fun m => 1 ≤ m && m ≤ 3) := by decide

/-- **The predicted shape is the stored one, as multisets**: two `3`s, five `2`s,
nine `1`s on each side. With `values_small` and the two length counts, matching
multiplicities at `1`, `2` and `3` is multiset equality. The certificate's own
ordering is its block order and carries no content here. -/
theorem shape_matches :
    ((restrictedTable.map Block.restricted).count 3,
     (restrictedTable.map Block.restricted).count 2,
     (restrictedTable.map Block.restricted).count 1)
      = (certShape.count 3, certShape.count 2, certShape.count 1) := by decide

/-- Spelled out: `(2, 5, 9)`. -/
theorem shape_profile :
    (certShape.count 3, certShape.count 2, certShape.count 1) = (2, 5, 9) := by decide

/-! ## The three counts, restricted -/

/-- `Σ m'² = 47`, the Hermitian unknowns, and the number of coordinates the stored
certificate point actually has. -/
theorem restricted_hermitian :
    (restrictedTable.map (fun B => B.restricted * B.restricted)).sum = 47 := by decide

/-- `Σ C(m'+1,2) = 36`, the real symmetric unknowns, the count the record's prose
uses. -/
theorem restricted_symmetric :
    (restrictedTable.map (fun B => B.restricted * (B.restricted + 1) / 2)).sum = 36 := by
  decide

/-- `Σ C(m',2) = 11`, the antisymmetric directions. -/
theorem restricted_antisym :
    (restrictedTable.map (fun B => B.restricted * (B.restricted - 1) / 2)).sum = 11 := by
  decide

/-- **`47 = 36 + 11`**, the restricted form of `89 = 65 + 24`. -/
theorem restricted_split :
    (restrictedTable.map (fun B => B.restricted * B.restricted)).sum
      = (restrictedTable.map (fun B => B.restricted * (B.restricted + 1) / 2)).sum
        + (restrictedTable.map (fun B => B.restricted * (B.restricted - 1) / 2)).sum := by
  decide

/-- The same identity holds termwise for any multiplicity, `C(m+1,2) + C(m,2) = m²`,
so neither split can catch an error in the multiplicity column. The record says this
of the unrestricted case and the restricted case inherits it. -/
theorem pascal_termwise (k : ℕ) : (k + 1) * (k + 2) + (k + 1) * k = 2 * ((k + 1) * (k + 1)) := by
  ring

/-! ## What stays owed

The counts above are dimensions. The record's sentence claims more, that the
antisymmetric directions are **gauge**, so that ranking `47` Hermitian columns computes
the rank of the map on the `36` real unknowns. That is a statement about a map, not a
count, and no part of this file reaches it.

Round [L62](../../../verification/ROUND_L62.md) filed exactly that as its
`HYPOTHESIS-DEBT`, and this file narrows it: the count half is now decided, and what
remains owed is the transport of the gauge property, stated unrestricted and used
restricted.
-/

end HamiltonsCubic.Blocks
