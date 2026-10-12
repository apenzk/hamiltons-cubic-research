# Round L03, the balanced product is a local maximum at every even $n\ge8$

**Id:** L03 · **Date:** 2026-09-14 · **Verifiers:** v277, v278, v279 · **Brief:** [BRIEF_L03.md](BRIEF_L03.md) · **Logs:** `agent_logs/verify-L03-v277.log`, `agent_logs/verify-L03-v278.log`, `agent_logs/verify-L03-v279.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement and proof | [findings/second-order.md](../findings/second-order.md) lines 31-35, 41, 49 |
| the canon | [results.md](../results.md) lines 114 and 404 |
| Lemma L24, given | [second-order.md](../findings/second-order.md) lines 57-59, 63, 65, [results.md](../results.md) line 320 |
| Lemma L27, given | [nondegeneracy.md](../findings/nondegeneracy.md) lines 496-498, 511-518, [results.md](../results.md) line 154 |
| the Lean file | [L3.lean](../lean/HamiltonsCubic/Results/L3.lean) |

**Withheld**: [second-order.md](../findings/second-order.md) lines 37-39 and 43-47, Gate 2 notes, and every index row.

## The findings from phase 0

**The step from a transverse negative definite Hessian to a local maximum is one clause.** Brief item 1.

**The constant $-6\theta/(n-2)$ appears in the statement and nowhere in the proof.** Brief item 4.

**The last line names a second local maximum.** Brief item 7.

## Adjudication

**Verdicts: [v277](VERIFY_v277.md) `GAP`, [v278](VERIFY_v278.md) `GAP`, [v279](VERIFY_v279.md) `HYPOTHESIS-DEBT`. Round verdict: `GAP`, repaired, impact `NARROWS`, the repair audited `PROVEN` by v280 and v281.** *Unanimous on every finding: the Hessian is right and the proof stops at it.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the step from the Hessian to a local maximum | a Hessian zero along the orbit and negative definite transverse to it gives a local maximum only through a Morse–Bott or slice argument, neither written nor cited | v277, v278 (`GAP`), v279 (`GAP`) | **confirmed**, a tubular-neighbourhood argument written into the proof, under audit |
| C2 | L24's hypothesis $\theta>0$ at $W^*$ | no source in the passages, and the sign decides between a maximum at $W^*$ and a minimum at $-W^*$, $e$ being unchanged under $W\mapsto-W$ | v277, v278, v279 (`HYPOTHESIS-DEBT`) | **confirmed**, cited to Nienhaus's Proposition 2.25, $\theta_{m,m}>0$ |
| C3 | "transverse Hessian $\le-6\theta/(n-2)$" | correct from L27's values, $\mu=\frac1{m-1}$ and the top transverse value $\lambda_m$ with a tie at $m=4$, and written nowhere | v277, v278, v279 (`CONFIRMED AS ALGEBRA`, owed) | **confirmed**, the derivation written, under audit |
| C4 | "not merely within $\mathcal D_n$" | L27 covers all of $W^{*\perp}$ | v277, v278, v279 (`CONFIRMED`) | **confirmed** |
| C5 | "at $n=6$ the statement is false", $P$ rising at cubic order | the nine null directions follow from L27, and the rise needs $P\ne0$ on that null space, argued nowhere | v277, v278, v279 (`HYPOTHESIS-DEBT`) | **narrowed** to "the argument stops" |
| C6 | "$n\ge12$ is about which of two local maxima wins" | the second local maximum is argued nowhere in the passages | v277, v278, v279 (`HYPOTHESIS-DEBT`) | **rewritten** to the balanced product's local maximality and the open global question |
| C7 | the canon's Schur remark on the $\mathbb{CP}^2$-type competitor | no argument in the passages | v277, v279 (`HYPOTHESIS-DEBT`), v277 confirming the L27 half | **removed** |
| C8 | the Lean file | scope arithmetic and $\varepsilon^3>0$, no statement of L3 | v277 (`CONFIRMED AS ALGEBRA`), v278 (`REFUTED AS STATED`), v279 (`REFUTED`) | **filed** under *out* with its binders |

**No adjudication pair was spent.** *Every finding is unanimous.*

### Withdrawn

- **v277: a circular use of L24.** L24's Hessian identity holds at every critical point, so its necessary-condition corollary is not what the proof uses.
- **v277, v278, v279: a padded object near $W^*$.** $W^*$ has trivial kernel.
- **v278: S²₀ read with $m=n$.** L27's $\lambda_m$ is at $m\in\{p,q\}$, which is the reading the constant needs.
- **v277, v278, v279: docstring overstatements in the Lean file.** Withdrawn on the charitable reading.

### Dependents

- **[nondegeneracy.md](../findings/nondegeneracy.md) line 584**, *"$S^3\times S^3$ ... not a local maximum either, by Lemma L3 at cubic order"*. **UNSUPPORTED** by the corrected statement. **Narrowed in the same commit** to: undecided at second order, a third-order question.
- **The report's status table**, *"False at $n=6$"*. **Corrected** in [09-status.tex](../report/sections/09-status.tex) to open at $n=6$. *The PDF is not rebuilt.*
- **[graded-half.md](../findings/graded-half.md) line 270** and **[nondegeneracy.md](../findings/nondegeneracy.md) line 82** name the former Observation L3 in passing. **Mentions.** Line 270 sits in L09's block, whose round is next.

**Impact `NARROWS`**: the $n=6$ claim is withdrawn to a scope statement, and one dependent narrowed with it.

### What changed

- [second-order.md](../findings/second-order.md): the Gate 2 notes replaced by the statement with its neighbourhood, and a proof in three parts, sign, Hessian with the constant, and the tubular-neighbourhood step. The $n=6$ paragraph and last line restated.
- [results.md](../results.md): both entries restated. [lean/INDEX.md](../lean/INDEX.md): the row's debt and an *out* entry.
- [ATTEMPTS.md](../ATTEMPTS.md): the removed block and canon, quoted.

### The repair's audit

**Two fresh verifiers, [v280](VERIFY_v280.md) and [v281](VERIFY_v281.md), on [BRIEF_L03_repair.md](BRIEF_L03_repair.md), both `PROVEN`.** *Each confirmed the sign argument, every value quoted from L27, $\mu=\frac1{m-1}$, the tie at $m=4$, the constant with its attainment, and each link of the tubular-neighbourhood step, including that $\rho$, $K$ and $\rho'$ are chosen once for the whole orbit by $O(n)$-invariance.*

**One finding, shared: the closing line's range.** *"So at $n\ge12$" dropped the parity and read as the lemma's scope, which is every even $n\ge8$.* **Repaired** to "at every even $n\ge12$, the range the conjecture concerns", in the findings file and the canon.

**Withdrawn by the audit**: the orbit's submanifold structure left uncited (standard for a compact group), $K=0$ (replaceable by any larger bound), equality at the $m=4$ tie also holding on $\Lambda^2\otimes\Lambda^2$ (the line claims no uniqueness), and the identification of $W^*$ with Nienhaus's $W_{S_{m,m}}$ left implicit.
