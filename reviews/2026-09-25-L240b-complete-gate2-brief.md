# Gate 2 brief: the Lean for L240 piece (b), assembly, completeness and Ky Fan (r1145)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Every Lean build or `lake env lean` runs in the background. Model: opus.

## What to compare

All in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean), commits f7d6f1ad and b397e053.

| claim | declaration |
|---|---|
| A cross slot (a pair $i<j$ whose indices lie in two different blocks) is the normalised pair slot $(\sqrt2)^{-1}$ `pairSlot N c d x y` of its ordered block pair $c<d$, with $x\in c$, $y\in d$ | `slotφ_of_cross` |
| Two cross slots are orthonormal: `inner2 (slotφ N ij) (slotφ N kl) = if ij = kl then 1 else 0` | `slot_orth_cc` |
| The whole slot family on the pairs $i<j$ is orthonormal | `slot_orthonormal` |
| A skew matrix $X$ equals $\sum_{i<j}\langle\varphi_{ij},X\rangle\varphi_{ij}$ | `phi_expand_ordered` |
| Every slot is skew | `slotφ_isSkew` |
| The slot family expands every skew $Y$: $Y=\sum_{ij}\langle\text{slot}_{ij},Y\rangle\,\text{slot}_{ij}$ | `slot_complete` |
| Each slot is an eigenvector of `negAdSq N.X` with eigenvalue `slotμ` | `negAdSq_slot` |
| **Ky Fan at a general normal form**: for orthonormal skew $y_1,\dots,y_r$ and any real $c$, $\sum_j\langle y_j,-\mathrm{ad}_X^2y_j\rangle\le rc+\sum_{ij}\max(\mu_{ij}-c,0)$, $\mu=$ `slotμ`, $X=$ `N.X` | `slot_kyFan` |

Givens (already audited, r1138 to r1144): `slot_eigen`, `slot_orth_nn`, `slot_orth_nc`, `pairSlot_orth_same`, `pairSlot_orth_diff`, `transfer_expansion`, `kyFan_eigen` (in KyFanPackaging / the Results namespace).

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis? In particular: is `slot_kyFan`'s inner product the one `kyFan_eigen` uses (`inner2 A B`, with `-br X (br X Y)` equal to $-\mathrm{ad}_X^2Y$), is the orthonormality hypothesis on the $y_j$ the right one, and is `r` unconstrained (does the statement hold, and is it meaningful, when $r$ exceeds the dimension of the skew matrices)?
2. Does `slot_complete` range over exactly the skew matrices, and does its index set (`{x : ι × ι // x.1 < x.2}`) match the family `slot_orthonormal` covers?
3. Build `lake build HamiltonsCubic.Results.L240SlotBasis` in the background, then run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis`; report the axioms and whether every declaration was found (no "AUDIT INCOMPLETE").
4. Do the file docstring and [lean/INDEX.md](../lean/INDEX.md)'s L240 row claim anything not delivered, and is "piece (b) is done" accurate against the round's stated bound ("(b) with the normal form as a hypothesis, the smallest version that lets `kyFan_eigen` act at a general $X$")?

## Protocol

Log to `agent_logs/r1145.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with the word DONE or FAILED, nothing before it. Commit a skeleton `reviews/REVIEW_r1145.md` first and update it, committing only that file by path (`git commit -- reviews/REVIEW_r1145.md`). Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
