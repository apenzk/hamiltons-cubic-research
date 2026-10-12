# Gate 2 brief, Lemma L225 (the per-block cubic)

**Cold brief. The block is quoted verbatim from the record with its source. You are asked to break it.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per item. You are reviewer **r947**, alone on this round: the Lean file claims to prove the whole vector statement, so the round compares that file against the block and reads the prose chain once.

**Analysis only.** Argue from the definitions. You may run a computation of a few seconds on an object you construct to screen a step you are about to report, and you must report it as a screen, never as evidence for a positive claim. No sweeps, no optimisation, no open-ended search.

**Read the written chain link by link before deriving anything.** For every step ask: does this follow from the line above it and from the hypotheses actually stated? A step whose conclusion is right and whose written justification does not establish it is a finding (a gap), distinct from the result being wrong.

## The claim under attack ([findings/second-order.md](../findings/second-order.md) lines 933-951)

#### Lemma L225, the per-block cubic: $\operatorname{tr}(M^0)^3\le\frac{k-2}{\sqrt{k(k-1)}}\lvert M^0\rvert^3$ for a trace-free symmetric $k\times k$ matrix, with equality exactly at one positive eigenvalue and one of multiplicity $k-1$

*Gate 2 owed. Derived 2026-09-15 for [I105](../plan.md), the tool [I106](../plan.md) consumes. **A confirmation of [Case–Tyrrell](../references/trace-free-cubic-2023-newton/notes.md)'s bound** ([arXiv:2305.03861](https://arxiv.org/abs/2305.03861), the norm form of their Proposition 2.2), proved here by a tangent cubic in place of their $\lambda$-method from sharp Newton. At $k=3$ it is step 5 of [L178](diagonal-half.md) in other coordinates. Kernel-checked in [L225Statement.lean](../lean/HamiltonsCubic/Results/L225Statement.lean).*

**Statement.** *Let $k\ge2$, $c=\sqrt{k(k-1)}$, and $\lambda\in\mathbb R^k$ with $\sum_i\lambda_i=0$ and $\sum_i\lambda_i^2=1$. Then $\sum_i\lambda_i^3\le\frac{k-2}c$, with equality exactly when one entry is $\frac{k-1}c$ and the other $k-1$ entries are $-\frac1c$. Applied to the eigenvalues of a trace-free symmetric $k\times k$ matrix $M^0$ with Frobenius norm $\lvert M^0\rvert$, this reads $\operatorname{tr}(M^0)^3\le\frac{k-2}{\sqrt{k(k-1)}}\lvert M^0\rvert^3$, with equality exactly when $M^0=\lvert M^0\rvert\big(\tfrac kc\,uu^{\mathsf T}-\tfrac1cI\big)$ for a unit vector $u$. At $k=3$: $\operatorname{tr}(M^0)^3\le\tfrac1{\sqrt6}\lvert M^0\rvert^3$, with equality exactly at nonnegative multiples of $\operatorname{diag}(2,-1,-1)$ in some orthonormal frame.*

**Proof.**
1. **Each entry is bounded.** For fixed $i$, $\sum_{j\ne i}\lambda_j=-\lambda_i$ and $\sum_{j\ne i}\lambda_j^2=1-\lambda_i^2$, so Cauchy–Schwarz over the other $k-1$ entries gives $\lambda_i^2\le(k-1)(1-\lambda_i^2)$, that is $k\lambda_i^2\le k-1$. Hence $\lambda_i\le\sqrt{(k-1)/k}=\frac{k-1}c=:\alpha$.
2. **The tangent cubic.** Put $\beta=\frac1c$. For $x\le\alpha$, $(x-\alpha)(x+\beta)^2\le0$. Summing over the entries, $$0\ge\sum_i(\lambda_i-\alpha)(\lambda_i+\beta)^2=\sum_i\lambda_i^3+(2\beta-\alpha)\sum_i\lambda_i^2+(\beta^2-2\alpha\beta)\sum_i\lambda_i-k\alpha\beta^2 .$$ With $\sum\lambda=0$, $\sum\lambda^2=1$ and $k\alpha\beta^2=\frac{k(k-1)}{c^3}=\frac1c=\beta$, this is $\sum_i\lambda_i^3\le\alpha-\beta=\frac{k-2}c$.
3. **Equality.** At equality the sum in step 2 is zero and each of its terms is $\le0$, so each term vanishes and every $\lambda_i$ is $\alpha$ or $-\beta$. With $m$ entries at $\alpha$, $\sum\lambda=0$ reads $m(k-1)-(k-m)=0$, so $m=1$. Conversely $(\alpha,-\beta,\dots,-\beta)$ has $\sum\lambda=\frac{(k-1)-(k-1)}c=0$, $\sum\lambda^2=\frac{(k-1)^2+(k-1)}{c^2}=1$ and $\sum\lambda^3=\frac{(k-1)^3-(k-1)}{c^3}=\frac{k(k-1)(k-2)}{c^3}=\frac{k-2}c$.
4. **Matrices.** In an orthonormal eigenframe of $M^0$, $\operatorname{tr}M^0=\sum\lambda_i$, $\lvert M^0\rvert^2=\sum\lambda_i^2$ and $\operatorname{tr}(M^0)^3=\sum\lambda_i^3$, so dividing by $\lvert M^0\rvert$ gives the matrix form, the case $M^0=0$ being trivial. The equality spectrum $(\alpha,-\beta,\dots,-\beta)$ is that of $\tfrac kc\,uu^{\mathsf T}-\tfrac1cI$ with $u$ the eigenvector of $\alpha$. $\square$

**The case $k=3$ as one identity.** With $\lambda=(a,b,-a-b)$, $\sum\lambda^2=2(a^2+ab+b^2)$ and $\sum\lambda^3=-3ab(a+b)$, and $$\Big(\sum\lambda^2\Big)^3-6\Big(\sum\lambda^3\Big)^2=2(a-b)^2(2a+b)^2(a+2b)^2\ge0,$$ which is the bound squared, with zero set the three lines on which two entries agree. *The right side is twice the discriminant $\prod_{i<j}(\lambda_i-\lambda_j)^2$, so this is [L178](diagonal-half.md)'s step 5, $\tfrac12-27e_3^2\ge0$ at $\sum\lambda^2=1$, written as a square.*

**Gate 1.** (a) At $k=3$ the constant $\tfrac1{\sqrt6}$ and the equality spectrum $(2,-1,-1)/\sqrt6$ reproduce [L178](diagonal-half.md)'s step 5 and Case–Tyrrell's reading at $n=3$. (b) The $k=3$ bound is reached a second way by the identity above, which shares no step with the tangent cubic. (c) `cube_sum_attained` exhibits the equality vector at every $k\ge2$, and the file carries a witness at $k=2$. (d) At $k=2$ the bound is $0$, met identically on $(\lambda,-\lambda)$, which agrees with the vanishing of the traceless cubic on $2\times2$ blocks behind [L224](#lemma-l224-the-pair-block-subalgebra-carries-no-value-above-the-diagonal-sup-ptheta_n-on-mathcal-d_noplus-v_jk-attained-only-at-the-jk-rotations-of-l57s-maximisers).

**Lean.** `entry_sq_le` is step 1, `cube_sum_le` step 2, `cube_sum_eq` and `cube_sum_eq_card` the forward half of step 3, `cube_sum_attained` its converse, and `three_by_three` the $k=3$ identity. Step 4, the spectral theorem, is Mathlib's and stays in prose.

**What it gives.** **A sharp, rigid bound on each block's cubic $\operatorname{tr}(M_a^0)^3$ on $\mathcal S_J$, one block at a time.** *It relates no two frames: how the eigenframes of different $M_a$ and of $R_J$ sit against each other is the whole of [I106](../plan.md)'s remaining question, and the plan's abandon condition for [R27](../routes.md) is a bound assembled from L225 per block against separately bounded couplings, the decoupled shape [F67](fence-posts.md) fences.*

## Givens

- **Frobenius norm**: $\lvert M\rvert^2=\operatorname{tr}(M^{\mathsf T}M)=\sum_{p,q}M_{pq}^2$, which for symmetric $M$ is the sum of squared eigenvalues.
- **The source**: [references/trace-free-cubic-2023-newton/notes.md](../references/trace-free-cubic-2023-newton/notes.md) transcribes Case–Tyrrell, with the PDF text beside it in [tracefree-2305.03861.txt](https://arxiv.org/abs/2305.03861).
- **L178's step 5**, the $k=3$ comparison the block names, is in [findings/diagonal-half.md](../findings/diagonal-half.md) under `#### Lemma L178`.
- **The Lean file**: [lean/HamiltonsCubic/Results/L225Statement.lean](../lean/HamiltonsCubic/Results/L225Statement.lean). Build it with `cd lean && lake build HamiltonsCubic.Results.L225Statement` (about 30 seconds, this is permitted) and check axioms with a scratch file running `#print axioms` on each declaration.

## Items

1. **Step 1.** Cauchy–Schwarz over $k-1$ entries, and the use of $k\ge2$. Is $\alpha=\sqrt{(k-1)/k}=\frac{k-1}c$ right?
2. **Step 2.** The expansion of $(x-\alpha)(x+\beta)^2$, the substitution of both constraints, $k\alpha\beta^2=\beta$, and the final constant.
3. **Step 3.** The forcing of the two values, the count $m=1$, and the converse.
4. **Step 4 and the matrix statement.** The transfer to trace-free symmetric matrices, the equality form $\lvert M^0\rvert(\tfrac kc\,uu^{\mathsf T}-\tfrac1cI)$, the case $M^0=0$, and the heading's phrase "one positive eigenvalue and one of multiplicity $k-1$" at $k=2$ and $k\ge3$.
5. **The $k=3$ identity.** The two power sums, the polynomial identity, its relation to the discriminant and to L178's $\tfrac12-27e_3^2\ge0$. The identity bounds the square: say whether the block states what it gives correctly.
6. **Attribution.** Is the bound, with its equality case and sign, what Case–Tyrrell prove (read the source, not the notes alone)? Is the tangent cubic a genuinely different route from their $\lambda$-method? Is L178's step 5 correctly identified as the $k=3$ case?
7. **Lean against the block.** For each of `entry_sq_le`, `cube_sum_le`, `cube_sum_eq`, `cube_sum_eq_card`, `cube_sum_attained`, `three_by_three`: does the proposition say what the block's **Lean** paragraph claims, over the right type, with no hypothesis that weakens it or makes it vacuous? Are the axioms the standard three? Is `c` pinned by its hypotheses to $\sqrt{k(k-1)}$?
8. **Gate 1 and What it gives.** Are (a)-(d) true as written, and does the closing paragraph claim anything the lemma does not deliver?
9. **Counterexample hunt.** Any $\lambda$ or $M^0$ violating the statement, including at boundary $k$.

## Logging and report

- Log to `agent_logs/review-r947.log`: first line with your PID and the phase plan, a line per phase transition, a heartbeat carrying live state at least every ~3 minutes, and a closing line that OPENS with `DONE <summary>` or `FAILED <reason>` (at most a timestamp before the word), written last.
- **Phase 0**: write `reviews/REVIEW_r947.md` as a skeleton (title, the item table with every verdict `NOT REACHED`, the log path) and commit it alone by path, `git add reviews/REVIEW_r947.md` then `git commit -m "review(L225): r947 skeleton"` as a separate call. Overwrite one row per phase and commit again.
- **Do not edit [reviews/INDEX.md](../reviews/INDEX.md)**, the findings, the plan or the Lean file. The parent folds the round.
- Commit messages: summary line plus bullets, no trailers needed for `review(`. Never `git -C`, never amend. No em dashes, no semicolons joining clauses. Use the email placeholder aaa@aaa.com if any tool asks for one.
