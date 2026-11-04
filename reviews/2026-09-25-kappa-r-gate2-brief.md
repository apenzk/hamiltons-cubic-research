# Gate 2 brief: kappa_r <= r + 2, a uniform proof of the Ky Fan bracket cap (r1152, r1153)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of computation on objects you construct are allowed only as a screen or to hunt a counterexample, never as evidence for a positive claim. Model: opus.

## The claim, verbatim from [second-order.md](../findings/second-order.md) at 9b6a0ad7

> **A uniform proof, and $\kappa_r\le r+2$ at every $r$** (derived 2026-09-25, Gate 2 pending). The eigenvalues of $-\mathrm{ad}_X^2$ at $X=\sum_cs_c\varphi_{p_cq_c}$ are $(s_a+s_b)^2$ and $(s_a-s_b)^2$, each twice, per block pair, $s_a^2$ per block and free index, and $0$. Take any $r$ of them, write $a_c=\lvert s_c\rvert$, and on each block pair split the chosen slots into $m$ opposite-sign pairs and $e=\lvert P-M\rvert\le2$ same-sign leftovers. **An opposite-sign pair sums to exactly $2(a_u^2+a_v^2)$**; a leftover is at most $(a_u+a_v)^2$; a kernel slot is $a_c^2$. The leftovers form a multigraph $G$ with $E$ edges and multiplicities $m_{uv}\le2$, and the degree-weighted inequality $(a_u+a_v)^2\le(1+d_v/d_u)a_u^2+(1+d_u/d_v)a_v^2$ charges block $u$ the load $d_u+\sum_{e\ni u}d_v/d_u$. **Since $d_v\le(E-d_u)+m_{uv}$ and $\sum_vm_{uv}^2\le2d_u$, that load is at most $E+2$**, so block $u$'s total coefficient is at most (its opposite-sign slots) $+$ (its kernel slots) $+E+2\le r+2$, and the chosen eigenvalues sum to at most $(r+2)\sum_ca_c^2$. *Tight at $r=2,4,6$ (the values $4,6,8$ above), with equality at the doubled triangle and the doubled star, where every load is exactly $r+2$; it replaces the enumeration of three-slot configurations.* [L237Cap.lean](../lean/HamiltonsCubic/Results/L237Cap.lean) reduces the cap to exactly this bound on slot sets.

## Givens

- $\kappa_r(X)$ is the sum of the top $r$ eigenvalues of $-\mathrm{ad}_X^2$ on $\mathfrak{so}(n)$ with $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}XY$; $\kappa_r=\max_{\lVert X\rVert=1}\kappa_r(X)$. A unit $X$ has normal form $X=\sum_cs_c\varphi_{p_cq_c}$ with $\sum_cs_c^2=1$ ($\varphi_{pq}=e_q e_p^{\mathsf T}-e_pe_q^{\mathsf T}$ up to the record's convention).
- The spectrum of $-\mathrm{ad}_X^2$ (the slot spectrum, Lean-typed as `slotμ` with `slot_eigen`, `slot_orthonormal`, `slot_complete` in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)): per block pair $a<b$, $(s_a+s_b)^2$ twice and $(s_a-s_b)^2$ twice; per block $a$ and free index, $s_a^2$ twice (once per side $p_a,q_a$); $0$ on Cartan and free-free slots.
- The record's values $\kappa_1,\kappa_2,\kappa_4,\kappa_6=2,4,6,8$.

## Lean

| claim | declaration |
|---|---|
| the reduction of the row cap to a bound on every set of at most $r$ slot eigenvalues | `exists_c_topSum`, `rowSum_le_of_slotSets` in [L237Cap.lean](../lean/HamiltonsCubic/Results/L237Cap.lean), audited by [r1151](REVIEW_r1151.md) |
| the bound on slot sets itself (this claim) | none yet: the multigraph and degree bookkeeping over a slot set is not typed |

## Items

1. Is the slot spectrum used correctly (values, multiplicities, the kernel slots per free index)?
2. Does the split into opposite-sign pairs and leftovers hold, with $e\le2$, and is "an opposite-sign pair sums to exactly $2(a_u^2+a_v^2)$" right whatever the signs of $s_u,s_v$?
3. The degree-weighted inequality and the load: is $d_v\le(E-d_u)+m_{uv}$ right, is $\sum_vm_{uv}^2\le2d_u$ right, and does the load bound $E+2$ follow? Does the final coefficient bound $r+2$ follow (check that a block's opposite-sign and kernel slots and $E$ are not double counted beyond $r$)?
4. Is $\kappa_r\le r+2$ true at every $r$ and $n$? Hunt for a counterexample (a normal form and $r$ slots exceeding $(r+2)\sum s^2$), and check the tightness claims (doubled triangle, doubled star; which $r$).

## Protocol

Reviewer N (1152 or 1153) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any other file; do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
