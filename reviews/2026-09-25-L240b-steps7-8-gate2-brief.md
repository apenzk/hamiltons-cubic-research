# Gate 2 brief: the Lean for L240 piece (b), steps 7, 8a and 8b (r1140)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Every Lean build or `lake env lean` runs in the background. Model: opus.

## What to compare, in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)

1. **Step 7**: `free_ne_blk`, `cartan_pair`, `cartan_cartan`, `kernel_blk`, `kernel_kernel`, `free_blk`. **Claim**: for a normal form, the Cartan slots $\varphi_{p_cq_c}$, the kernel slots $\varphi_{xw}$ ($x$ in a block, $w$ free) and the free-free slots $\varphi_{ww'}$ are each orthogonal under `inner2` to every slot of another type and to one another on different index pairs.
2. **Step 8a**: `span_pp`, `span_qq`, `span_pq`, `span_qp`. **Claim**: $\varphi_{p_ap_b}=\tfrac12(S_1+S_3)$, $\varphi_{q_aq_b}=\tfrac12(S_3-S_1)$, $\varphi_{p_aq_b}=\tfrac12(S_2+S_4)$, $\varphi_{q_ap_b}=\tfrac12(S_2-S_4)$.
3. **Step 8b**: `transfer_expansion`. **Claim**: for a bilinear form $B$, a family $\varphi$ on a finite index set that expands every vector of a predicate-defined set $S$, and an orthonormal family $b$ on the same index set with each $b_k\in S$, every $y\in S$ satisfies $y=\sum_kB(b_k,y)\,b_k$. Check that no hypothesis is missing for this to be true (the proof uses $R R^{\mathsf T}=1\Rightarrow R^{\mathsf T}R=1$ for a square real matrix), and whether it is vacuous or trivially weaker than intended.

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis?
2. Run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis` after a background build and report the axioms.
3. Do the file's docstring and [lean/INDEX.md](../lean/INDEX.md)'s L240 row claim anything the declarations do not deliver?

## Protocol

Log to `agent_logs/r1140.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes, last line opening with `DONE` or `FAILED`). Commit a skeleton `reviews/REVIEW_r1140.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any Lean file. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
