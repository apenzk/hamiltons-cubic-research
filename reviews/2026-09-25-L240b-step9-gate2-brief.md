# Gate 2 brief: the Lean for L240 piece (b), steps 9a to 9c (r1141)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Every Lean build or `lake env lean` runs in the background. Model: opus.

## What to compare, in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)

1. **Step 9a**: `classify`, `p_ne_q_side`, `p_not_free`, `q_not_free`. **Claim**: every index of a normal form is the $p$-side of a block, the $q$-side of a block, or free, and these are exclusive.
2. **Step 9b**: `NormalForm.blockOf`, `blockOf_spec`, `blockOf_of_p`, `blockOf_of_q`, `blockOf_none`. **Claim**: `blockOf x` is the unique block containing $x$ when there is one, and `none` exactly for free $x$.
3. **Step 9c**: `pairSlot`, `pairMu`, `slotφ`, `slotμ`, `negAd_smul`, `cartan_null`, `negAd_phi_swap`. **Claims**: `slotφ` on a pair $i<j$ is the normalised pair slot ($S_1$ to $S_4$ times $1/\sqrt2$, chosen by the $p$/$q$ roles and the block order) for cross-block pairs and $\varphi_{ij}$ otherwise; `slotμ` is its intended eigenvalue ($(s_a\pm s_b)^2$ on pair slots, $0$ on Cartan and free-free, $s_a^2$ on kernel slots); `cartan_null` states $[X,\varphi_{p_aq_a}]=0$ at every $k$; `negAd_phi_swap` transfers an eigen relation across $\varphi_{xy}=-\varphi_{yx}$. **Check in particular** whether `pairSlot`'s role selection and `pairMu` agree with the eigenvalues of steps 2 and 3 (`slot_plus_general` and its siblings), since `slot_eigen`, still owed, will rely on that agreement.

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis, and do the definitions encode what the claims say?
2. Run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis` after a background build and report the axioms.
3. Do the file's docstring and [lean/INDEX.md](../lean/INDEX.md)'s L240 row claim anything the declarations do not deliver?

## Protocol

Log to `agent_logs/r1141.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes, last line opening with `DONE` or `FAILED`). Commit a skeleton `reviews/REVIEW_r1141.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any Lean file. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
