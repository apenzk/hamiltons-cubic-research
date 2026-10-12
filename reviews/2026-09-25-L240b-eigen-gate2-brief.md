# Gate 2 brief: the Lean for L240 piece (b), slot_eigen, pair_orthonormal and the index simp lemmas (r1142)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Every Lean build or `lake env lean` runs in the background. Model: opus.

## What to compare, in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)

1. **`pairSlot_eigen`, `cartan_eigen`, `slot_eigen`**. **Claim**: every member `slotφ ij` of the slot family on the pairs $i<j$ is an eigenvector of $-\mathrm{ad}_X^2$, $X$ the normal form's matrix, with eigenvalue `slotμ ij` ($(s_a\pm s_b)^2$ on cross-block pairs as paired in RootSlots, $0$ on Cartan and free-free pairs, $s_a^2$ on kernel pairs). Check the case split covers every pair and that the eigenvalue in each case is the intended one.
2. **`i2_smul_smul`, `pair_orthonormal`**. **Claim**: the normalised pair slots $(1/\sqrt2)S_1,\dots,(1/\sqrt2)S_4$ each have `inner2`-norm $1$. Note what is and is not stated (the off-diagonal zeros).
3. **`p_eq_p_iff`, `q_eq_q_iff`, `p_eq_q_false`, `q_eq_p_false`, `p_ne_free`, `q_ne_free`** (the `@[simp]` ones especially). **Claim**: they decide equalities between block and free indices. Check that tagging them `@[simp]` is sound and did not silently change any earlier proof's meaning.

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis?
2. Run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis` after a background build and report the axioms.
3. Do the file's docstring and [lean/INDEX.md](../lean/INDEX.md)'s L240 row claim anything the declarations do not deliver?

## Protocol

Log to `agent_logs/r1142.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes, last line opening with `DONE` or `FAILED`). Commit a skeleton `reviews/REVIEW_r1142.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any Lean file. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
