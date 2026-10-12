# Gate 2 brief: the Lean for L240 piece (b), steps 1 to 3, and L246's matrix step (r1138)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Model: opus.

## What to compare

1. **[L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)**, the committed declarations `br_phi_disjoint`, `br_jacobi`, `br_sum_left`, `NormalForm`, `NormalForm.X`, `br_X_two`, `slot_plus_general`, `block_disj`, `reduce_two`, `hc_pair`, `slot_plus2_general`, `slot_minus_general`, `slot_minus2_general`, `slot_null_general`. **The claim they are meant to carry**: for a skew matrix in normal form $X=\sum_cs_c\varphi_{p_cq_c}$ ($2k$ distinct indices), the six bivectors of each block pair $a\ne b$ are eigenvectors of $-\mathrm{ad}_X^2$: $\varphi_{p_ap_b}\mp\varphi_{q_aq_b}$ and $\varphi_{p_aq_b}\pm\varphi_{q_ap_b}$ with eigenvalues $(s_a\pm s_b)^2$ as paired in [RootSlots.lean](../lean/HamiltonsCubic/Results/RootSlots.lean), and $\varphi_{p_aq_a}$ null.
2. **[L246PairIsotropy.lean](../lean/HamiltonsCubic/Results/L246PairIsotropy.lean)**, `skew_swap` and `M_le_A`. **The claim**: $M_c(e)\preceq\hat A_c$, i.e. $\sum_i\langle\psi_ie,z\rangle^2\le\sum_i\lvert\psi_iz\rvert^2$ for skew $\psi_i$ and unit $e$.

## Items

1. Does each declaration state the claim beside it: right objects, right quantifiers, no hypothesis that makes it weaker than claimed or vacuous? In particular, is `NormalForm` satisfiable (exhibit one with $k\ge2$), and do the plus/minus pairings match RootSlots' eigenvalues?
2. Run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis` and `--only L246PairIsotropy` (both background-safe, seconds after a build) and report the axioms.
3. Is anything claimed in the file's docstrings or in [lean/INDEX.md](../lean/INDEX.md)'s L240 and L246 rows that the declarations do not deliver?

## Protocol

Log to `agent_logs/r1138.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes, last line opening with `DONE` or `FAILED`). Commit a skeleton `reviews/REVIEW_r1138.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any Lean file. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
