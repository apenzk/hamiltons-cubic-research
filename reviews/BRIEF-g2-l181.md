# Gate 2 brief, L181, Ricci and Bianchi as the two halves of one matrix

**Cold brief. Work from the definitions, givens and statement below and nothing else.** Do not read [findings/](../findings/) for the answer.

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden: searches, sweeps, optimisations, censuses, falsifier hunts. **A refutation must be exhibited in closed form or it is not a refutation.**

## Conventions and constants, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: the Riemann symmetries, the first Bianchi identity, and total trace-freeness $\sum_bW_{abcb}=0$. **It is a linear subspace, so $0\in\mathcal W_n$.**
- $\Lambda^2\mathbb R^n$ carries the inner product making $\{f_a\wedge f_b\}_{a<b}$ orthonormal; a $2$-form is also read as a skew matrix, and $\lVert\omega\rVert^2=-\tfrac12\operatorname{tr}(\omega^2)$.
- $W$ acts self-adjointly on $\Lambda^2$, and **in spectral form $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$** over an orthonormal eigenbasis, $\omega\otimes\omega$ meaning $\eta\mapsto\langle\omega,\eta\rangle\omega$. The sum runs over the **nonzero** eigenvalues, $r$ of them.
- **The conjecture's range is $n\ge12$**, its threshold is $\sqrt{3/2}=1.224745$, $\theta_0(12)=1.236033$, and the crossover the record watches is $n=6+2\sqrt7$. **None of these should appear in the proof; say so if one does.**

## The two givens, both audited, both passed, use them freely

**Given A (Ricci).** For $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$, total trace-freeness is exactly $\sum_i\lambda_i\,\omega_i^2=0$ as an identity in $S^2(\mathbb R^n)$.

**Given B (Bianchi).** The first Bianchi identity is exactly $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4$, the zero eigenvalues dropping out. *This is the vanishing of the $\Lambda^4$ component under the orthogonal splitting $\mathrm{Sym}^2(\Lambda^2V)=\mathrm{Sym}^2_B(\Lambda^2V)\oplus\Lambda^4V$; the projection's constant is immaterial to a vanishing statement.*

## The claim

Fix an orthogonal decomposition $\mathbb R^n=P_1\oplus\dots\oplus P_m\oplus P_0$ with each $P_j$ a plane, and let $\varepsilon_j$ be the unit area-form of $P_j$. Call $W\in\mathcal W_n$ **simultaneously block-diagonal** for this splitting when every eigen-$2$-form with nonzero eigenvalue is a real combination of the $\varepsilon_j$. **Then $W=0$.**

**Proof as written.** Write $\omega_i=\sum_{j=1}^mM_{ij}\varepsilon_j$ for the $r$ eigenforms with $\lambda_i\ne0$, and $\Lambda=\operatorname{diag}(\lambda)$. Orthonormality of the $\omega_i$ is $MM^{\mathsf T}=I_r$, the $\varepsilon_j$ being orthonormal.

*Ricci is the diagonal.* As a skew matrix $\varepsilon_j$ is supported on $P_j$, so $\omega_i\omega_i^{\mathsf T}$ is block-diagonal with $M_{ij}^2\,\mathrm{Id}_{P_j}$ on the $j$-th plane. Given A then reads $\sum_i\lambda_iM_{ij}^2=0$ for each $j$, which is $\operatorname{diag}(M^{\mathsf T}\Lambda M)=0$.

*Bianchi is the off-diagonal.* $\varepsilon_j\wedge\varepsilon_j=0$, so $\omega_i\wedge\omega_i=2\sum_{j<k}M_{ij}M_{ik}\,\varepsilon_j\wedge\varepsilon_k$, and the $\varepsilon_j\wedge\varepsilon_k$ are linearly independent in $\Lambda^4$. Given B then reads $\sum_i\lambda_iM_{ij}M_{ik}=0$ for each $j<k$, which is $(M^{\mathsf T}\Lambda M)_{j\ne k}=0$.

*So $M^{\mathsf T}\Lambda M=0$.* Multiplying on the left by $M$ and the right by $M^{\mathsf T}$ and using $MM^{\mathsf T}=I_r$ gives $\Lambda=M(M^{\mathsf T}\Lambda M)M^{\mathsf T}=0$, contradicting $\lambda_i\ne0$ unless there are no such eigenvalues.

**Two non-vacuity checks the block claims.** $W_{\mathbb{CP}^2}$ escapes, because two of its self-dual eigenforms are $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$ but $\tfrac1{\sqrt2}(e_{13}-e_{24})$ and $\tfrac1{\sqrt2}(e_{14}+e_{23})$ are not block-diagonal in that splitting or any other. A coordinate-diagonal $W$ escapes, its eigenforms being the $e_{ab}$, which no splitting into $\lfloor n/2\rfloor$ planes contains.

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each explicitly, including where you find nothing.

1. **Every hypothesis**, of the statement and of the two givens as applied. Used, stated-and-unused, used-and-unstated.
2. **$MM^{\mathsf T}=I_r$.** Is orthonormality of the $\omega_i$ really that, and does it need the $\varepsilon_j$ orthonormal, are they, given the $P_j$ are orthogonal planes? **Is $M$ real, and is $r\le m$ forced?**
3. **The Ricci half.** Is $\omega_i\omega_i^{\mathsf T}$ block-diagonal with exactly $M_{ij}^2\mathrm{Id}_{P_j}$, with no cross terms between planes and no factor? Check by writing $\varepsilon_j$ as a matrix.
4. **The Bianchi half.** Is $\omega_i\wedge\omega_i=2\sum_{j<k}M_{ij}M_{ik}\varepsilon_j\wedge\varepsilon_k$, and **are the $\varepsilon_j\wedge\varepsilon_k$ linearly independent in $\Lambda^4$**, including when $m$ is large, and including any interaction with $P_0$?
5. **The final step.** $M^{\mathsf T}\Lambda M=0$ with $MM^{\mathsf T}=I_r$ giving $\Lambda=0$: check the matrix sizes and that the multiplication is legitimate for a **non-square** $M$ ($r\times m$ with $r\le m$).
6. **Degenerate eigenvalues.** The eigenbasis is not unique when an eigenvalue repeats. **Does "every eigenform is a combination of the $\varepsilon_j$" depend on which basis of a degenerate eigenspace is chosen, and does the proof need it not to?**
7. **$P_0$ and odd $n$.** The splitting need not exhaust $\mathbb R^n$. Does anything break when $P_0\ne0$, or when $n$ is odd?
8. **The kernel.** $\ker W\ne0$ is this record's recurring obstruction. Does any step assume otherwise? *The zero eigenvalues are dropped at the outset, is that legitimate under both givens?*
9. **The two non-vacuity checks.** Are they right? **In particular: is it true that no splitting into planes contains all the $e_{ab}$, and that $W_{\mathbb{CP}^2}$ is block-diagonal for no splitting whatever?** *The second is a claim about all splittings and the block gives no argument for it, say so if it is unsupported.*
10. **Scope.** The block says the result holds "at every $n$, every rank and every number of blocks". Is that entailed?
11. **The boundary.** $m=1$, $r=1$, $r=m$, $n=4$, odd $n$, and $n$ below $12$.

**Name what would break it.** End by naming the object that, if it existed, would falsify the claim, and say what you did to look for it. **A nonzero simultaneously-block-diagonal Weyl tensor is the most valuable thing you could exhibit.**

**Do not supply a missing argument.** Where a claim has no proof on file the finding is *"this claim has no argument on file"*, verdict `HYPOTHESIS-DEBT`.

## Output

`reviews/REVIEW_r<N>.md`: title; standfirst saying the brief was cold and **no numerical work was done, every value exact**, with your log path; **the claim table before any prose**, verdicts in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with derivations in full; the overall verdict. **Use your own verdict vocabulary, the fold records your word, not a kinder one.**

Log to `agent_logs/g2-l181-r<N>.log` with PID, a line per phase, live state at every tool round, and a closing `DONE <verdict>`.

**Commit your report alone. Do NOT edit [reviews/INDEX.md](INDEX.md), the fold writes every row after both reports land, so that neither of you reads the other's verdict.** If the commit gate refuses an unindexed report, say so in your report and leave the report uncommitted rather than indexing it. **Leave any reference folder you fetch uncommitted and say so.**
