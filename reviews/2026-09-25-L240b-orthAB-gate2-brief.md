# Gate 2 brief: the Lean for L240 piece (b), slot orthonormality cases (A) and (B) (r1143)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Every Lean build or `lake env lean` runs in the background. Model: opus.

## What to compare, in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)

1. **`IsCross`, `slotφ_of_not_cross`**. **Claim**: a pair $i<j$ is cross-block when its indices lie in different blocks, and off those pairs `slotφ` is $\varphi_{ij}$ itself.
2. **Case (A)**: `phi_orthonormal_ordered`, `slot_orth_nn`. **Claim**: on ordered pairs, `inner2 φ_{ij} φ_{kl} = [ij = kl]`, hence two non-cross slots are orthonormal.
3. **Case (B)**: `blockOf_of_inBlk`, `phi_orth_of_not_cross`, `phi_orth_pairSlot`, `i2_smulR`, `slot_orth_nc`. **Claim**: a non-cross slot is orthogonal to every cross slot.

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis? In particular, is `IsCross` the right notion (so that cases (A), (B) and the owed case (C) partition all pairs of pairs)?
2. Run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis` after a background build and report the axioms.
3. Do the file's docstring and [lean/INDEX.md](../lean/INDEX.md)'s L240 row claim anything the declarations do not deliver?

## Protocol

Log to `agent_logs/r1143.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes, last line opening with `DONE` or `FAILED`). Commit a skeleton `reviews/REVIEW_r1143.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any Lean file. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
