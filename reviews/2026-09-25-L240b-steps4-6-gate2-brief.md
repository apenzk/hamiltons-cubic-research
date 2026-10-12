# Gate 2 brief: the Lean for L240 piece (b), steps 4 to 6 (r1139)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Any Lean build or `lake env lean` runs in the background. Model: opus.

## What to compare, in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)

1. **Step 4**: `NormalForm.Free`, `br_X_one`, `slot_kernel_general`, `slot_free_null`. **Claim**: for $X=\sum_cs_c\varphi_{p_cq_c}$ in normal form and an index $w$ outside every block, $-\mathrm{ad}_X^2\varphi_{p_aw}=s_a^2\varphi_{p_aw}$; for two such indices, $\varphi_{ww'}$ is null.
2. **Step 5**: `i2_subL`, `i2_addL`, `i2_subR`, `i2_addR`, `S1` to `S4`, `pair_gram`. **Claim**: the four slot vectors of a block pair $a\ne b$, $\varphi_{p_ap_b}\mp\varphi_{q_aq_b}$ and $\varphi_{p_aq_b}\pm\varphi_{q_ap_b}$, have Gram matrix $2I$ under `inner2`.
3. **Step 6**: `NormalForm.InBlk`, `same_block`, `phi_orth`, `cross_phi`, `cross_comb`. **Claim**: slot bivectors (and any two-term combinations of them) from different ordered block pairs $(a,b)\ne(c,d)$ with $a<b$, $c<d$ are orthogonal.

## Items

1. Does each declaration state its claim: right objects, quantifiers, no weakening or vacuity? Exhibit one `NormalForm` with a free index to show step 4 is not vacuous.
2. Run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis` (after a background build) and report the axioms.
3. Do the file's docstring and [lean/INDEX.md](../lean/INDEX.md)'s L240 row claim anything the declarations do not deliver?

## Protocol

Log to `agent_logs/r1139.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes, last line opening with `DONE` or `FAILED`). Commit a skeleton `reviews/REVIEW_r1139.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any Lean file. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
