# Round L46, at a locally symmetric Einstein space the Weyl part is critical

**Id:** L46 · **Date:** 2026-09-14 · **Verifiers:** v239, v240, v241 · **Brief:** [BRIEF_L46.md](BRIEF_L46.md) · **Logs:** `agent_logs/verify-L46-v239.log`, `agent_logs/verify-L46-v240.log`, `agent_logs/verify-L46-v241.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the findings statement | [findings/problem.md](../findings/problem.md) lines 628-635, under the heading at line 610 |
| the proof as the block writes it | [findings/problem.md](../findings/problem.md) lines 614-622 |
| the landscape statement | [results.md](../results.md) line 106 |
| the canonical entry | [results.md](../results.md) lines 386-390 |
| the four-line proof and its consequence | [findings/graded-half.md](../findings/graded-half.md) lines 210-214 and 220-224 |
| the Lean statement | [L46Statement.lean](../lean/HamiltonsCubic/Results/L46Statement.lean), whole file, no `sorry` |

## The findings from phase 0

**Step (A) cites Richard–Seshadri Lemma 4.1 beyond its statement.** At source the lemma is for a *non-negatively curved Einstein symmetric* space with $\lambda>0$; the block applies it to *locally* symmetric Einstein spaces with $\lambda$ of either sign. *The source's proof runs through Brendle's Einstein identity $\Delta R+2Q(R)=\lambda R$ and parallelism, which is local and sign-free, and the filed note says so; but that identity's source is not in [references/](../references/).* Brief item 1.

**$W\ne0$ is used and stated nowhere in the statement or the canon**: the round sphere is locally symmetric Einstein with $\lambda>0$ and $W=0$. *The block's own annotation records this and the statement below it was never changed.* Brief item 3.

**The canon's detail entry says *compact* and prints $\theta^2=\frac1{4(\lVert R\rVert^2-(\operatorname{tr}R)^2/N)}$ before it normalises $\lambda=\tfrac12$**, while the block states it only in Petersen–Stanfield's normalisation. Brief items 5 and 6.

**The block is an annotation stack ending in a sentence fragment**, *"The statement is below; the section it used to point at is"*. Brief item 11.

## Adjudication

**Verdicts: [v239](VERIFY_v239.md) and [v241](VERIFY_v241.md) `HYPOTHESIS-DEBT`, [v240](VERIFY_v240.md) `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *The split was on one step and is settled inline by derivation below; every other finding is common to all three.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | step (A) cited to Richard–Seshadri Lemma 4.1 | stated for non-negatively curved symmetric spaces with $\lambda>0$; $H^2\times H^2$ ($\lambda=-1$) and $\Sigma\times\Sigma$ are in the lemma's scope and outside the citation; its proof rests on the unfiled [Bre10a] and prints a factor-$2$ error | v239, v240, v241 | **confirmed as a citation defect**; the step is re-founded, see the split |
| C2 | step (A) on the Ricci-flow route written beside the citation | Hamilton's equation (filed, no compactness) along the explicit homothety | v240 `CONFIRMED`; v239, v241 did not credit it | **split, settled for the route**, below |
| C3 | the hypothesis $\lambda\ne0$ | the conclusion needs $W\ne0$; the round sphere has $\lambda=n-1$, $W=0$ | v239, v240, v241 | **confirmed**, $W\ne0$ written into every statement |
| C4 | the $\lambda=0$ flatness argument | rests on material the brief did not quote | v239, v240, v241 (`HYPOTHESIS-DEBT`, not load-bearing) | **dissolved**: with $W\ne0$ as the hypothesis the statement no longer needs it, and it is removed |
| C5 | the canon's $\theta^2$ display | printed before $\lambda=\tfrac12$; $S^2\times S^2$ at curvature $\tfrac14$ gives $\theta^2=\tfrac34$ against the display's $3$ | v239, v240, v241 | **confirmed**, moved after the normalisation |
| C6 | the canon's "compact" | the proof uses no compactness | v239, v240, v241 | **confirmed**, dropped |
| C7 | the flow route called "weaker", needing short-time existence | the homothety is written down, no existence theorem | v240, v241 | **confirmed**, the route is now the proof |
| C8 | Lean docstrings | stale verbatim quote naming Cartan–Ambrose–Hicks; "no operator $Q$" while `Qop` exists; `hpos` glossed as $\lambda\ne0$; the non-vacuity example exhibits two of six hypotheses | v239, v240, v241 | **confirmed**, refreshed |
| C9 | record text | the block's closing fragment, its pointer sentence, and the canon's truncated landscape line | v239, v240, v241 | **confirmed**, rewritten |

### The split on step (A), settled by derivation

**The route holds, and every import is filed.** *(i)* [Richard–Seshadri](https://arxiv.org/abs/1308.1190) lines 258–264 state Hamilton's equation $\partial_tR_{g(t)}=\Delta_{g(t)}R_{g(t)}+2Q(R_{g(t)})$ for a Ricci flow, with no compactness, in the record's $Q$. *(ii)* $g(t)=(1-2\lambda t)g$ has $\mathrm{Ric}(g(t))=\lambda g$ and $\partial_tg=-2\lambda g=-2\mathrm{Ric}(g(t))$ for $1-2\lambda t>0$, at either sign. *(iii)* The $(0,4)$ tensor scales by $s=1-2\lambda t$ and an orthonormal frame by $s^{-1/2}$, so the operator on orthonormal bivectors is $R/s$, derivative $2\lambda R$ at $t=0$. *(iv)* Each $g(t)$ is locally symmetric, so $\Delta R=0$, and $Q(R)=\lambda R$. **v239 and v241 found a real defect in the citation and were right to book it; the step's conclusion is reached by the route the block also wrote, and that route is now the proof.**

### Dependents

- **[L47](../results.md) and [L48](../results.md) SURVIVE**: both carry $W\ne0$ and apply L46 at $\lambda=\tfrac12$, exactly the corrected scope.
- **[graded-half.md](../findings/graded-half.md)'s one-liner** carried $\lambda\ne0$ and "shrinks"; repaired to $W\ne0$ and the explicit homothety.
- **[The Richard–Seshadri notes](../references/richard-seshadri-2013-noncoercive-cones/notes.md)** asserted the identity for every locally symmetric Einstein metric on the strength of the unfiled source; they now name the factor error and point at the flow route.

### What was changed

- [problem.md](../findings/problem.md): the annotation stack replaced by the statement with $W\ne0$ and either sign of $\lambda$, and a three-step proof resting (A) on Hamilton's equation along the homothety.
- [results.md](../results.md): the landscape line rewritten whole, the detail entry without "compact", with $W\ne0$, and with the $\theta^2$ display after $\lambda=\tfrac12$.
- [graded-half.md](../findings/graded-half.md), the Richard–Seshadri notes, and [L46Statement.lean](../lean/HamiltonsCubic/Results/L46Statement.lean)'s docstring, as above.

### The round's own defects

**The brief did not say that annotation lines 623–624 lay between the quoted ranges**, so v241 read one annotation while checking item 11. *It disclosed this, and its $W=0$ counterexample predates the display.* **The rewritten block removes the stack.**
