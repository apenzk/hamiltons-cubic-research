# REVIEW r1134: Gate 2 on L246, the pair isotropy inequality

Log: [agent_logs/r1134.log](../agent_logs/r1134.log)

Brief: [2026-09-25-L246-gate2-brief.md](2026-09-25-L246-gate2-brief.md). Analysis by hand; one seconds-long screen reported as a screen.

| item | claim | verdict |
|---|---|---|
| 1 | the pair inequality, proof step by step | CONFIRMED |
| 2 | corollary: sign of lambda_1 for a star, lambda_1=0 contradiction | CONFIRMED (one wording fix) |
| 3 | sharpness at S^5xS^7 and the n=4 Hodge star | REFUTED in part: S^5xS^7 confirmed, the Hodge star point is degenerate and not a Weyl tensor |
| 4 | scope: only Ric(W)=0, symmetric family | CONFIRMED, with the remark that the inequality itself uses less |
| 5 | non-triviality against L245 | CONFIRMED against the givens, PLAUSIBLE against L245's ceiling (not in the givens) |
| 6 | What it does: F77 window, near-star heuristic | PLAUSIBLE |

## Item 1: CONFIRMED

- Commuting. From the two identities, $A_1=(n-1)I-A_0-A_2$ and $(\lambda_2-\lambda_1)A_2=-\lambda_1(n-1)I+(\lambda_1-\lambda_0)A_0$. So $A_1,A_2$ are affine in $A_0$ and all commute.
- $\sum_cM_c(e)=I-ee^{\mathsf T}$. $M(e)=\sum_\psi(\psi e)(\psi e)^{\mathsf T}$ is basis independent (the form $z\mapsto\sum_\psi\langle\psi e,z\rangle^2$ is the squared norm of the representer of a linear functional). In the basis $e_i\wedge e_j$ with $e_1=e$, only $e_1\wedge e_j$ contributes, with $\psi e=-e_j$. The sum is $\sum_{j\ge2}e_je_j^{\mathsf T}$.
- $M_c(e)\preceq\hat A_c$. $\langle\psi e,z\rangle=-\langle e,\psi z\rangle$ by skew symmetry, then Cauchy–Schwarz with $\lvert e\rvert=1$, then sum over $E_c$. Correct.
- Compression eigenvalues. $e$ is an eigenvector of $A_a+A_b$, so $e^\perp$ is invariant and the compression carries the multiset $\{\beta_i\}_{i\ne j}$ (one copy of $\beta_j$ removed when it is repeated). Correct.
- Capped trace. $\mathop{\mathrm{tr}}X=\mathop{\mathrm{tr}}QXQ+\mathop{\mathrm{tr}}(I-Q)X(I-Q)$ holds for any projector. The first part is at most $\mathop{\mathrm{rank}}Q$ by $X\preceq I-ee^{\mathsf T}$, the second at most $\sum_{\beta_i<1}\beta_i$ by $X\preceq\hat A_a+\hat A_b$ and $[Q,\hat A_a+\hat A_b]=0$. Correct.
- $\mathop{\mathrm{tr}}X=\beta_j$. $\mathop{\mathrm{tr}}M_c(e)=\sum\lvert\psi e\rvert^2=\langle A_ce,e\rangle$. Correct.
- Remark. The argument never uses that $E_a,E_b$ are eigenspaces or that the $A_c$ commute: for ANY subspace $V\subseteq\Lambda^2$ and any eigenvector $e$ of $A_V$, $\alpha_j\le\sum_{i\ne j}\min(1,\alpha_i)$. L246 is this subspace inequality applied to $V=E_a\oplus E_b$. Screen: 1200 random subspaces at $n=4..7$, largest excess $9\cdot10^{-15}$ (a screen only).

## Item 2: CONFIRMED, one wording fix

- On $Z=(e\oplus U)^\perp$, $A_0=p\,ee^{\mathsf T}+P_U$ vanishes, $Z$ is invariant under $A_2$ (affine in $A_0$), and $(\lambda_2-\lambda_1)A_2=-\lambda_1(n-1)I$ there. With $\lambda_2>\lambda_1$, $n>1$ and $Z\ne0$ this forces $\lambda_1\le0$. $p\le n-2$ is exactly $Z\ne0$.
- At $\lambda_1=0$: $\lambda_2A_2=-\lambda_0A_0$, so $A_2=rA_0$ with $r=\lvert\lambda_0\rvert/\lambda_2>0$ ($\lambda_0<0<\lambda_2$ follows from $\sum_c\lambda_c\dim E_c=0$, the trace of Ric). The pair $(0,2)$ has $\beta=(1+r)p$ at $e$, $1+r$ on $U$, $0$ on $Z$. The inequality at $e$ reads $(1+r)p\le p$, false. Complete. The contradiction does not need $Z\ne0$.
- $E_2$: apply the corollary to $-W$ (still Ric-free, spectrum $-\lambda_2<-\lambda_1<-\lambda_0$). Correct.
- $p=n-1$ is excluded at every $\lambda_1$ by $A_1\succeq0$ at $e$ ($\langle A_1e,e\rangle=-(n-1)\lvert\lambda_0\rvert/(\lambda_2-\lambda_1)<0$), so the bold sentence "no extreme eigenspace is a star" holds with no restriction on $p$.
- Wording fix: the star needs $U\subseteq e^\perp$. Replace "$E_0=e\wedge U$ with $\dim U=p\le n-2$" by "$E_0=e\wedge U$ with $U\subseteq e^\perp$, $\dim U=p\le n-2$".

## Item 3: REFUTED in part

- $S^5\times S^7$: $\sum_cA_c=11I$, traces $20,42,70$ match $2\cdot10,2\cdot21,2\cdot35$. Pair $10,35$: $A=11P_5+5P_7$, at an $\mathbb R^5$ direction $11\le4+7$, equality. Pair $21,35$: $A=7P_5+11P_7$, at an $\mathbb R^7$ direction $11\le6+5$, equality. CONFIRMED.
- Hodge star at $n=4$: REFUTED as a sharpness witness. The Hodge star has two eigenvalues, not three. The only pair is $\Lambda^+\oplus\Lambda^-=\Lambda^2$, whose isotropy is $(n-1)I$ for every operator, so "$3=3$" is the trivial full-space equality $n-1=(n-1)\cdot1$. The Hodge star is also not a Weyl tensor: its self-dual block is $I$, not trace-free (it fails the first Bianchi identity), although it is Ric-free. For a single class, $A_\pm=\tfrac32I$ gives $\tfrac32<3$, not equality.
- Correction, exact wording: delete "It is also sharp at $n=4$ for the Hodge star, where $A_\pm=\tfrac32I$ and $3=3$." and change Gate 1 "(a) and (c) by these two points" to "(a) and (c) by the two $S^5\times S^7$ pairs".

## Item 4: CONFIRMED

- The inequality uses no property of $W$ (item 1 remark). Ric$(W)=0$ and three eigenvalues enter the commuting statement and the corollary. Bianchi is never used, so everything holds for Ric-free self-adjoint operators with three eigenvalues.
- The symmetric family has $\lambda_1=0$ and is covered.
- Suggested clarification: "it holds at every $n$ with only $\mathop{\mathrm{Ric}}(W)=0$" is accurate for the corollary. The inequality itself holds for any subspace of $\Lambda^2$, so the coupling of two eigenspaces comes from $\mathop{\mathrm{Ric}}(W)=0$ through the corollary.

## Item 5: CONFIRMED against the givens, PLAUSIBLE against L245

- Configuration: $A_0=p\,ee^{\mathsf T}+P_U$, $A_2=rA_0$, $A_1=(n-1)I-(1+r)A_0$, $\lambda_1=0$. It satisfies both identities, all traces ($\dim E_2=rp$), and $A_c\succeq0$ iff $(1+r)p\le n-1$. At $r=1$ that is $p\le(n-1)/2$, matching the block.
- It passes $\beta_i\le n-1$ and the single-class form for each of $A_0,A_1,A_2$ (for $A_0$ and $A_2$ with equality at $e$). The pair form excludes it. So the inequality is not implied by those.
- L245's per-direction ceiling is outside the givens, so the claim that L245 admits these stars is PLAUSIBLE, not checked.
- Exact reduction worth recording: at $\lambda_1=0$ the pair $(0,2)$ has $A_0+A_2=(1+r)A_0$, so the inequality is exactly $\alpha_j\le\sum_{i\ne j}\min\big(\tfrac1{1+r},\alpha_i\big)$ for the eigenvalues $\alpha$ of $A_0$ (at $r=1$, $\min(\tfrac12,\alpha_i)$).

## Item 6: PLAUSIBLE

- F77's window as the brief describes it (stars $E_0=e\wedge U$, $9\le p\le\tfrac{n-1}2$, symmetric spectrum) lies inside the corollary's scope, which excludes every star at $\lambda_1=0$. The removal is correct if F77's window contains nothing else (F77 itself is outside the givens).
- Near-star margin: with the item 5 reduction, a near-star with $\alpha_e=p$, $\alpha_U=1$ needs $\sum_{Z}\alpha_i\ge\tfrac{r}{1+r}p$, which is margin $rp$ in $\beta$ units. The block's figure is right. It sits under "Owed" with $\approx$ but is not labelled a heuristic. Suggested wording: "Heuristic: a near-star at $\lambda_1=0$ has $\beta_e\approx(1+r)p$ against a capped remainder near $p$, a margin of $rp$ rather than L245's $p-h_c$; exactly, the small directions of $A_0$ must carry total isotropy at least $\tfrac r{1+r}p$."

## Lean

- `capped_trace`: matches the scalar step (linear arithmetic on the part bounds).
- `star_impossible_at_zero`: matches, with the capped sum bounded by $p$ and $\lambda_0<0<\lambda_2$ as hypotheses (derivable from the trace of Ric).
- `star_sign`: matches $\lambda_1\le0$ given the restriction to $Z$.
- The closing `example` proves only $11\le4\min(1,11)+7\min(1,5)$, so it does not certify equality although its docstring says "with equality". Adding `example : (11 : ℝ) = 4 * min 1 11 + 7 * min 1 5 := by norm_num` would.
- The module docstring names `star_forces`, which does not exist. The declarations are `star_impossible_at_zero` and `star_sign`.
