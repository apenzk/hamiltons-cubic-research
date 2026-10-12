# Gate 2 brief: the Lean proof of kappa_r <= r + 2 (r1154)

**One reviewer: the round compares Lean declarations against a statement already audited** ([r1152](REVIEW_r1152.md), [r1153](REVIEW_r1153.md) on the prose proof in the L237 block of [second-order.md](../findings/second-order.md)). Analysis-only; builds run in the background from `lean/`. Model: opus.

## What to compare

| claim | declaration |
|---|---|
| For loopless edges `f i ≠ g i`, each unordered pair carried at most twice, `∑ᵢ (a(f i) + a(g i))² ≤ (|I| + 2) ∑_{u touched} a u²` | `graph_load` (with `amgm`, `deg_other_le`, `load_le`) in [L237GraphLoad.lean](../lean/HamiltonsCubic/Results/L237GraphLoad.lean) |
| Counts `P_ab, M_ab ≤ 2` of `(s_a ± s_b)²` per ordered block pair and `F_c` of `s_c²`, totalling at most `r`, sum to at most `(r + 2) ∑ s²` | `counts_bound` (with `pair_split`, `pair_regroup`, `sum_edges`, `card_edges`, `edges_par`) |
| Each slot's eigenvalue is a function of its class (cross pair with sign, block-free block, null); a cross class holds at most two slots of any set; any slot set `S` sums to at most `(|S| + 2) ∑ s²` | `slotCls`, `clsVal`, `slotμ_eq_val`, `cls_card_le_two`, `cls_lt`, `slot_set_bound` in [L237SlotCounts.lean](../lean/HamiltonsCubic/Results/L237SlotCounts.lean) |
| At `X = O N.X Oᵀ`, `O` orthogonal, any `r ≥ 1` orthonormal skew `yⱼ` have `∑ⱼ ⟨yⱼ, -ad_X² yⱼ⟩ ≤ (r + 2) ∑_c s_c²` | `kappa_cap` |

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis? In particular: does `graph_load`'s parallel hypothesis match "multiplicity at most 2", does `slotμ_eq_val` agree with `slotμ` on every branch (including `a > b`, where the key is reversed and the sign read at the other endpoint), and is `kappa_cap`'s right side stated in the normal form's weights rather than in `X`'s norm (say so as a scope note)?
2. Is anything in the INDEX row for L237 or the L237 block's Lean sentence claimed beyond these declarations?
3. Build `HamiltonsCubic.Results.L237SlotCounts` in the background and run `python3 scripts/misc/axiom_audit.py --only L237GraphLoad` and `--only L237SlotCounts`; report axioms and completeness.

## Protocol

Log to `agent_logs/r1154.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1154.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
