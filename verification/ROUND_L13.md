# Round L13, the spectral-moment ceiling, and what it does and does not close

**Id:** L13 · **Date:** 2026-09-07 · **Verifiers:** v206, v207, v208 · **Brief:** [BRIEF_L13.md](BRIEF_L13.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 577-579 |
| the landscape statement | [results.md](../results.md) line 186 |
| the block | [findings/curvature-invariants.md](../findings/curvature-invariants.md) lines 62-79 |

## The findings from phase 0

**The canonical entry states no result, the third such row this audit has met.** [results.md](../results.md) line 577 is a heading and a proof pointer with nothing between them, exactly as at [L21](ROUND_L21.md) and, by that block's own text, at L20. **A pattern of three is a defect of the file rather than of a row**, and the round records it as such.

**The block is five annotations before its prose**, four of them correcting the text below, which is [L21](ROUND_L21.md)'s shape repeated. *One of them refutes the block's own headline; another says the label is wrong in both directions and the block splits three ways.* **The round is asked whether the split is right and what each piece's label should be**, not to inherit the annotation's answer.

**The block names four symbols it never defines** ($B$, $u$, $\lambda$, $k_0$) and its own note says its $\lambda$ is the record's $\theta$ while the record's $\lambda$ is a $\Lambda^2$ eigenvalue, and its $B$ is a fourth sense of a letter already flagged live.

**And the landscape line and the block disagree about what was shown.** The line says the method *"is the wrong invariant for this problem"*; an annotation inside the block says that reading is **backwards**, the moments determining $\theta$ exactly. Both go to the verifiers unlabelled.

## What the verifiers are asked beyond the standing list

Whether the ceiling $\theta\le2-o(1)$ is derived at every $n$ by compression from criticality, and whether it needs the Peirce cap; whether $\kappa_n=(n-1)(2n-1)/4$ is proven or fitted, and at which parities; whether the excess at $n=12$ is $58.9\times$ under the block's own denominator; whether *"attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$"* is refuted and whether only *"at least"* is consumed downstream; and **whether the moments are complete invariants for $\theta$, which would invert the headline**.

## Adjudication

**Verdicts: [v206](VERIFY_v206.md) `GAP`, [v207](VERIFY_v207.md) `BROKEN`, [v208](VERIFY_v208.md) `BROKEN`. Round verdict: `BROKEN`, repaired, impact `CONTAINED`.** The three converged on one mechanism: **a find-and-replace ran through the argument it was correcting**, and every reader after it inherited a paragraph that refutes its own headline.

**The inequality itself is right and four lines long, and all three derived it.** Criticality gives $L_WW=\theta W$; differentiating $O(n)$-equivariance makes every orbit tangent an exact $\theta/2$-eigenvector orthogonal to $W$; self-adjointness turns $\operatorname{tr}(L_W^2)$ into a sum of squares. **The Peirce cap is stated as an input and is not one** (the step is a *lower* bound on a sum of squares, where a cap supplies nothing), *and its Jordan language does not transfer, $\mathcal W_n$ having no unit and its $L_W$ spectrum reading $1,\tfrac12,\tfrac14,0,-\tfrac12$ at $S^3\times S^3$.* **The trap the loop carries by name fired here.**

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | the canonical entry | a heading and a proof pointer, no statement | 3/3 | `BROKEN`, statement written |
| **C2** | the displayed chain | independent re-derivation | 3/3 | `CONFIRMED` |
| **C3** | the Peirce cap as an input | a cap cannot lower-bound a sum of squares | 3/3 | **`REFUTED`**, and the unital-algebra trap fires |
| **C4** | *"reaching $58.9$ needs $k_0\ge74>66$"* | a substitution ran over the clause being corrected | 3/3 | **`BROKEN`**, struck |
| **C5** | the same argument in its original form | reads an upper bound as a determination | 2/3 | **`BROKEN`**, struck in the Lean docstring too |
| **C6** | $\kappa_n=(n-1)(2n-1)/4$ | summed at the balanced sphere product, which exists only at even $n$ | 3/3 | `HYPOTHESIS-DEBT`, even $n\ge6$ and $n=4$ proven, odd $n\le13$ verified, odd $n\ge15$ open |
| **C7** | *"the method's ceiling is $\theta\le2-o(1)$"* | the best conceivable output sold as a delivered bound | 1/3 | `CONFIRMED`, witness below |
| **C8** | *"no refinement of it escapes"* | universal claim with witnesses against it | 2/3 | **`REFUTED`** |
| **C9** | *"the wrong invariants"* against the annotation calling it backwards | | 3/3 | **both wrong**, see below |
| **C10** | *"attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$"* | | 3/3 | `REFUTED` at critical points, **open at local maxima**; only *"at least"* consumed, harmless |
| **C11** | the three-way split | | 2/3 | the annotation's count is wrong; the block was rewritten rather than split |

### C4 and C5, and the substitution is visible in the arithmetic

**Screened here, exactly.** $\kappa_{12}=\tfrac{253}4$; at $k_0=66$ the bound is $1.901127$ and the ratio $58.92$; at $k_0=74$ the bound is $1.800997$ and the ratio $50.05$. **So $58.9$ is precisely what $k_0=66$ gives, and the sentence saying it needs $k_0\ge74$ is false.** The record's table carries a level-3 bound of $1.7974$, never displayed beside the chain, whose ratio is $49.73$, **and $253/(4\cdot1.7974^2)-1$, times four, is $74.31$.** *The $74$ is the orbit dimension needed to force the level-3 figure out of the level-2 formula, and it belongs to the clause about $49.7$ that the substitution overwrote.* The block was left asserting, in three consecutive sentences, that the figure lies in $(58,59)$, that $58.9$ is unreachable, and that the figure is $58.9$.

**And the overwritten argument was invalid in its own right.** It reads $\theta^2(1+k_0/4)\le\kappa_n$ as a determination: a smaller $\theta$ never forces a larger $k_0$, because the chain is an inequality. *Applied to $\theta_0(12)$ it would demand $k_0\ge162$ and refute $S^6\times S^6$, which the record lists as a critical point.* **So $49.7$ was never wrong (it measured a tighter bound) and the correction that replaced it deleted the better figure.** Both are now on the record with the bound each measures.

### C7, with its witness

**A larger orbit gives a stronger bound**, so $\theta\le2-o(1)$ is what the method yields *if* the orbit is maximal. **At padded $W_{\mathbb{CP}^2}$ at $n=12$ (a local maximum with orbit $34$), the same inequality gives only $\theta\le\sqrt{253/38}=2.58$, above the printed ceiling.** *The qualifier is in [ATTEMPTS.md](../ATTEMPTS.md) and the block dropped it.* The ceiling is a limit on the method's power, which is the useful reading and is now what the block says.

### C9, where the headline and its rebuttal are both wrong

**The landscape line said the moments are the wrong invariants; an annotation said that is backwards because the moment sequence determines $\theta$ exactly. Neither survives.** For a *known* $L_W$ the sequence is complete (at a local maximum $\theta=\lambda_{\max}(L_W)$ is simple and Newton's identities recover it) so the headline is wrong as stated. **But the method does not have the sequence.** It has three universal identities, of which the second is constant in $W$ and carries nothing beyond the norm, and the record establishes there is no third independent one. *So what is closed is a truncation result*: three moments do not separate $\theta$, and the fourth reaches only $14\times$ granting an oracle, **which is the level-4 figure $1.3951$ in [ATTEMPTS.md](../ATTEMPTS.md), screened here at $14.09$**, and which one verifier reported as sourceless. **That candidate is withdrawn; the source exists and the block failed to cite it.**

### What is not repaired here

**C6 is the research loop's and is filed in [plan.md](../plan.md)**: $\kappa_n$ at odd $n\ge15$. *The closure the block proposed for it is not one*, $\kappa_n\dim\mathcal W_n=\lVert T\rVert^2$ is recorded in [second-order.md](../findings/second-order.md) as a corollary of the second trace identity rather than an independent route. **C10's open half is filed with it**: both refuting witnesses are non-maximal critical points, so the multiplicity clause is untested at local maxima, which is where the lemma is used.

### One process finding

**A verifier on this round staged with `git add -A` and swept another's report into its commit**, against the standing instruction in every brief. *No content was lost and the displaced verdict is carried by a later commit.* Filed to [skill-proposals.md](../.claude/skill-proposals.md).

