# Gate 2 brief, L176, the coordinate-diagonal locus's minimum degree

**Cold brief. Work from the definitions below and nothing else.** Do not read [findings/](../findings/) for the answer; the statement and its proof are quoted here in full.

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden here: searches, sweeps, optimisations, censuses, falsifier hunts. **A refutation must be exhibited in closed form or it is not a refutation.**

## Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: $W_{abcd}$ with the Riemann symmetries, the first Bianchi identity, and totally trace-free ($\sum_b W_{abcb}=0$).
- $W$ acts on $\Lambda^2\mathbb R^n$ as a self-adjoint operator. Its **$\Lambda^2$-rank** is the rank of that operator.
- $W$ is **coordinate-diagonal in a frame** $\{f_a\}$ when $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$. Its **sectional matrix** is $K_{ab}=W_{abab}$, symmetric and hollow.
- The record states the coordinate-diagonal locus as *hollow symmetric matrices with vanishing row sums*: $\sum_b K_{ab}=0$ for each $a$.

## The claims

**L176.** Let $W\ne0$ be coordinate-diagonal in some frame, and let $G$ be the graph on $\{1,\dots,n\}$ with edges $\{a,b\}$ where $K_{ab}\ne0$. Then every vertex of $G$ has degree $0$ or $\ge2$, and $\lvert E(G)\rvert\ge4$; equivalently $\operatorname{rank}(W:\Lambda^2\to\Lambda^2)\ge4$.

**The proof as written.** On the locus $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$, so the eigenvalues are the $K_{ab}$ and the rank is $\lvert E(G)\rvert$. *Degree:* a vertex $a$ of degree $1$ with sole neighbour $b$ has $0=\sum_c K_{ac}=K_{ab}$, contradiction. *Edges:* $W\ne0$ gives $\lvert E\rvert\ge1$. At $\lvert E\rvert\le2$ the degree sum is $\le4$, so at most two vertices carry support and a simple graph on two vertices has one edge, whose endpoints have degree $1$. At $\lvert E\rvert=3$ the degree sum is $6$ with every support degree $\ge2$, forcing exactly three vertices of degree exactly two, so $G=K_3$; its row sums $K_{ab}+K_{ac}=0$, $K_{ab}+K_{bc}=0$, $K_{ac}+K_{bc}=0$ give $K_{ac}=K_{bc}=-K_{ab}$ and then $K_{ab}=0$.

**Sharpness.** At $n\ge4$, $K$ on the cycle $12,23,34,41$ with values $c,-c,c,-c$ has every row sum cancelling in pairs, giving $\Lambda^2$-rank exactly four.

**Corollary 1.** A Weyl tensor of $\Lambda^2$-rank $\le3$ is coordinate-diagonal in no frame.

**Corollary 2.** Padded $W_{\mathbb{CP}^2}\in\mathcal W_n$ is coordinate-diagonal in no frame. *Reason given: $\mathbb{CP}^2$ is self-dual Einstein so $W^-=0$; its $W^+$ has eigenvalues proportional to $(2,-1,-1)$ on $\Lambda^+$, all nonzero; so the $\Lambda^2$-rank is three at $n=4$ and padding adds zero eigenvalues alone.*

**Corollary 3.** $\kappa^2(W)<2\lVert W\rVert^2$ strictly at every Weyl tensor of $\Lambda^2$-rank $\le3$, since $\kappa^2\le2\lVert M\rVert_F^2$ holds with equality **exactly** at coordinate-diagonal.

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each of the following explicitly, including where you found nothing.

1. **Every hypothesis**, of the statement and of anything the proof imports, checked against the object. Which are used, which are stated and unused, which are used and unstated.
2. **The locus characterisation.** Is *hollow symmetric with vanishing row sums* actually the coordinate-diagonal locus, does the first Bianchi identity impose anything further on a diagonal $W$, and is the trace-free condition really $\sum_b K_{ab}=0$ rather than something with a factor or an extra term?
3. **The eigenvalue identity.** Is $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$ right on the locus, under which normalisation of the $\Lambda^2$ action, and does any convention put a factor of $2$ or $\tfrac12$ where it would change the count of *nonzero* eigenvalues? *A factor cannot change a count, but a wrong identification of the operator could.*
4. **The degree-sum counting.** $\lvert E\rvert\le2$ and $\lvert E\rvert=3$ are handled by counting alone. Check both, including whether multi-edges, loops or a vertex outside the support could break the count.
5. **The triangle system.** Is it genuinely nonsingular, and did the proof state all three of its equations correctly?
6. **The sharpness witness.** Is the four-cycle example actually in $\mathcal W_n$ (Riemann symmetries, first Bianchi, and *totally* trace-free) or does it satisfy the row-sum condition while failing something else? **This is the item most likely to break**: the row sums are one consequence of trace-freeness and the brief may be quoting a necessary condition as if it were sufficient.
7. **$\mathbb{CP}^2$'s spectrum.** Is $W^-=0$, and is $W^+$'s spectrum really $(2,-1,-1)$ up to scale with no zero eigenvalue? Read a source rather than recalling one, and fetch it into [references/](../references/) with a `notes.md`.
8. **The padding.** Does embedding $W_{\mathbb{CP}^2}$ into $\mathcal W_n$ by zero keep it a Weyl tensor, and does it truly add zero eigenvalues alone on $\Lambda^2\mathbb R^n$ rather than mixing?
9. **The kernel.** $\ker W\ne0$ is this record's recurring obstruction and the padded tensor is almost all kernel. Does any step assume otherwise?
10. **Corollary 3's import.** It uses an equality clause quoted as an "iff". Check the direction actually needed.
11. **The boundary.** $n=4$ exactly, $n=5$, odd $n$, and $n$ below the conjecture's range.
12. **Scope.** Does anything in the block claim more than the proof reaches, in particular about padded $\mathbb{HP}^2$, which the block says it does not reach?

**Name what would break it.** End by naming the object that, if it existed, would falsify L176, and say what you did to look for it.

**Do not supply a missing argument.** Where a claim has no proof on file the finding is *"this claim has no argument on file"*, verdict `HYPOTHESIS-DEBT`, naming precisely what would have to be proved.

## Output

Write `reviews/REVIEW_r<N>.md` with your number, in this order: title; a standfirst saying the brief was cold and that **no numerical work was done and every value is exact**, with your log path; **the claim table before any prose**, one row per claim with a verdict in caps (`CONFIRMED`, `REFUTED`, `REFUTED AS STATED`, `CONFIRMED AS ALGEBRA`, `GAP`, `HYPOTHESIS-DEBT`); a one-line summary someone can act on; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections one per claim carrying the derivation in full; the overall verdict.

Log to `agent_logs/g2-l176-r<N>.log`: first line with PID and phase plan, a line per phase, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before any long stretch of reasoning what you are about to derive.

Commit your own report alone, `review(L176): r<N> <verdict>`. Nothing else.
