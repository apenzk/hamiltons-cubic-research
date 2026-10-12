import HamiltonsCubic.Results.L83

/-!
# The stored `n=5` certificate's shape, against L83's table

[scripts/runs/n5_certificate.json](../../../scripts/runs/n5_certificate.json) stores two
fields that were never checked against each other or against the record: `blocks`, sixteen
`B₂` highest weights, and `shape`, their multiplicities. This file transcribes both and
asks what they confirm.

**What they confirm.** The stored pair is exactly [L83](../../../findings/sym3-blocks.md)'s
24-block table with one multiplicity removed from each `λ₂`-even block, block by block, with
the eight even blocks of multiplicity one falling out entirely. The multiplicity column of
that table is therefore cross-checked against the pipeline's independently constructed
adapted basis, and the coordinate count `47` is `Σ m²` over the survivors.

**What they do not confirm.** The producer applies the parity rule itself, at
[run_n5_assemble.py:660](../../../scripts/runs/run_n5_assemble.py),
`SURV = {lam: len(ADAPTED[lam]) - (1 if lam[1] % 2 == 0 else 0) ...}`. So the certificate
cannot disagree about *which* blocks lose a multiplicity, and neither the `16`, the `3570`,
the `25`/`36` shape nor `dim K = 4200` is independently witnessed here. This is the defect
class the record already books at `65 = 36 + 29`: an identity that holds for any input
because the input was built by the identity.

`dim K = 4200` is recorded at [sym3-blocks.md:249](../../../findings/sym3-blocks.md) as a
free identity from apolarity. It is `7770 - 3570`, and both summands are L83's arithmetic,
so it is derived here rather than confirmed.

Everything below is `decide`, kernel-checked. `native_decide` is not used.
-/

namespace HamiltonsCubic.Blocks

/-- The certificate's `blocks` and `shape` fields, paired in stored order. -/
def stored : List Block :=
  [ ⟨2, 2, 3⟩, ⟨4, 2, 3⟩, ⟨3, 2, 2⟩, ⟨2, 0, 1⟩, ⟨2, 1, 2⟩, ⟨3, 0, 1⟩, ⟨3, 1, 2⟩,
    ⟨4, 0, 1⟩, ⟨4, 1, 2⟩, ⟨4, 3, 2⟩, ⟨4, 4, 1⟩, ⟨5, 2, 1⟩, ⟨3, 3, 1⟩, ⟨5, 1, 1⟩,
    ⟨5, 3, 1⟩, ⟨6, 3, 1⟩ ]

/-- L83's table after the parity subtraction, keeping the blocks that survive it. -/
def derived : List Block :=
  (table.map (fun B => ⟨B.a, B.b, B.mult - (if B.evenSecond then 1 else 0)⟩)).filter
    (fun B => 0 < B.mult)

/-! ## The stored fields are L83's table minus the parity rule -/

theorem derived_in_stored : derived.all (fun B => stored.contains B) = true := by decide

theorem stored_in_derived : stored.all (fun B => derived.contains B) = true := by decide

theorem lengths_agree : derived.length = stored.length := by decide

/-- Sixteen blocks survive: the eight `λ₂`-even blocks of multiplicity one vanish. -/
theorem card_stored : stored.length = 16 := by decide

theorem eight_vanish :
    ((table.filter (fun B => B.evenSecond)).filter (fun B => B.mult == 1)).length = 8 := by
  decide

/-! ## `3570` and `4200` -/

/-- `dim K = 4200`, the complement of L83's `cap_even`, from the surviving multiplicities. -/
theorem sum_mult_dim_stored : (stored.map (fun B => B.mult * B.d)).sum = 4200 := by decide

/-- The complement is exact: `4200 + 3570 = 7770 = dim Sym³ 𝒲₅`. This is the apolar
decomposition `Δ_K + Δ_C = ‖W‖⁶` at the level of dimensions, and it is arithmetic on
L83's one table, so the two summands are not independent measurements. -/
theorem apolar_complement :
    (stored.map (fun B => B.mult * B.d)).sum
      + ((table.filter (fun B => B.evenSecond)).map Block.d).sum
      = (table.map (fun B => B.mult * B.d)).sum := by decide

end HamiltonsCubic.Blocks
