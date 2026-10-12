# Review r1143: L240 piece (b), slot orthonormality cases (A) and (B)

Brief: [2026-09-25-L240b-orthAB-gate2-brief.md](2026-09-25-L240b-orthAB-gate2-brief.md). Log: agent_logs/r1143.log. File: [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean) at commit f6ac67f6 (the committed file matched HEAD, with no uncommitted changes). Background `lake build HamiltonsCubic.Results.L240SlotBasis` succeeded (8733 jobs, 0 errors, no `sorry` warnings).

## Item 1. Statements match claims, and `IsCross` partitions: CONFIRMED

- `IsCross ij := ∃ a b, blockOf i = some a ∧ blockOf j = some b ∧ a ≠ b`. This is exactly the branch of `slotφ` that returns `(√2)⁻¹ • pairSlot`: `slotφ` matches `blockOf i, blockOf j` and uses `pairSlot` only on `some a, some b` with `a ≠ b`. Every other branch (`a = b`, or either side `none`) returns `phi i j`. So `IsCross` is the right notion.
- `slotφ_of_not_cross`: under `¬ IsCross N ij`, `slotφ N ij = phi i j`. It holds for all ordered pairs `i < j` with no further hypothesis. It is not vacuous: every Cartan, kernel and free-free pair satisfies it.
- Case (A). `phi_orthonormal_ordered` states `inner2 φ_{ij} φ_{kl} = if ij = kl then 1 else 0` for all ordered pairs. The swapped coincidence is excluded by `i < j`, `k < l`. The normalisation is right: `inner2 = ½ tr(Aᵀ B)` and `inner2_phi_phi` gives `1` on the diagonal. `slot_orth_nn` transfers this to two non-cross slots, with both hypotheses as the claim requires.
- Case (B). `slot_orth_nc` gives `inner2 (slotφ ij) (slotφ kl) = 0` under `¬ IsCross ij`, `IsCross kl`, and it covers both orientation branches (`c < d` and `d < c`) of the cross slot. The helpers are correctly stated: `blockOf_of_inBlk`, `phi_orth_of_not_cross` (hypothesis `c ≠ d` present, and both orientations of the index coincidence refuted), `phi_orth_pairSlot` (all four `S₁…S₄` branches, arbitrary `x y`) and `i2_smulR`. None is weakened.
- Partition. With `IsCross` a proposition on each pair, every pair of pairs `(ij, kl)` is exactly one of: (A) both non-cross; (B) exactly one cross; (C) both cross. The cases are exhaustive and exclusive. One note: `slot_orth_nc` fixes the non-cross slot on the left. The mirror order `inner2 (cross) (non-cross)` follows from symmetry of `inner2`, which the assembly will need to cite explicitly. It is not a gap in the claim as briefed.

## Item 2. Axiom audit: CONFIRMED (standard three), with a tooling defect

- `python3 scripts/misc/axiom_audit.py --only L240SlotBasis`: 67/67 parsed declarations clean, resting on `propext`, `Classical.choice` and `Quot.sound`. It reported **AUDIT INCOMPLETE** for one name, `HamiltonsCubic.L240SlotBasis.slot`.
- Cause: the script's `DECL` regex (`[A-Za-z_][A-Za-z0-9_.'!?₀-₉]*`, [axiom_audit.py](../scripts/misc/axiom_audit.py) line 82) stops at `φ`, so `slotφ_of_not_cross` was read as `slot`. The same thing will happen to any theorem whose name contains a Greek letter. **Correction for the tool's owner**: widen the identifier class to Unicode letters.
- Closed directly: a background `lake env lean` with `#print axioms` on all eleven named declarations plus `slotφ` and `slotμ` reports `[propext, Classical.choice, Quot.sound]` for each. In the file, `sorry` appears in no declaration of this round.

## Item 3. Docstring and lean/INDEX.md L240 row: PLAUSIBLE, one docstring overstatement

- **lean/INDEX.md L240 row**: accurate. Every name it lists for cases (A) and (B) exists with the stated content. It records case (C), two cross slots, as still owed. The index-equality lemmas it names (`p_eq_p_iff` and the rest, `p_ne_free`, `q_ne_free`) exist at lines 497 to 504. Its final sentence ("Still owed for (b): the normalised slot family indexed like the φ basis …") is stale because `slotφ` is that family. That sentence understates what is delivered and makes no false claim.
- **File docstring (lines 10 to 12)**: "*Orthogonality of all slot types is here (steps 5 to 7, for basis bivectors; the slot combinations follow by bilinearity)*". At the level of the combination vectors (steps 5 to 7) this is true. At the level of the family `slotφ` that `kyFan_eigen` will consume, orthonormality is proved only for cases (A) and (B). Case (C) is owed. The step list ends at 9c and names neither `IsCross` nor the case (A) and (B) theorems. **Correction**: add a Step 9d line naming `IsCross`, `slotφ_of_not_cross`, `slot_orth_nn` and `slot_orth_nc`, and state that orthonormality of `slotφ` is proved for cases (A) and (B), with case (C) still owed.

## Verdicts

| Item | Verdict |
|---|---|
| 1. Statements, `IsCross` partition | CONFIRMED |
| 2. Axioms | CONFIRMED (standard three; audit script misparses `φ`, closed by direct `#print axioms`) |
| 3. Docstring and INDEX row | PLAUSIBLE (INDEX accurate, last sentence stale; docstring should record case (C) as owed at the `slotφ` level) |
