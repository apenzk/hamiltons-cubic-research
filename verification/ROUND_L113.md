# Round L113, moment analysis of the g-distribution and the pinned class

**Id:** L113 · **Date:** 2026-09-14 · **Verifiers:** v344, v345, v346 · **Brief:** [BRIEF_L113.md](BRIEF_L113.md) · **Logs:** `agent_logs/verify-L113-v344.log`, `agent_logs/verify-L113-v345.log`, `agent_logs/verify-L113-v346.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and the lemma | [findings/bounds.md](../findings/bounds.md) lines 508, 526 |
| the relations and $g$ | [findings/bounds.md](../findings/bounds.md) lines 258-264, [findings/conventions.md](../findings/conventions.md) line 50 |
| L107, given | [findings/bounds.md](../findings/bounds.md) lines 562, 566 |
| post F42 | [findings/fence-posts.md](../findings/fence-posts.md) lines 417, 419, 423 |
| L109, given | [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) lines 47, 51, 53 |
| the Lean files | [L113.lean](../lean/HamiltonsCubic/Results/L113.lean), [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean), declarations only |

**Withheld**: the Gate 2 stack under the L113 heading (lines 510-524), both Lean module docstrings and theorem docstrings, and every index row.

## The findings from phase 0

**The block carries no proof**: its body is one paragraph opening "The moral", under a `Lemma` heading. **L113.lean includes declarations that do not mention moments at all**, `unused_hypothesis` and `closure_with_content`. **No results.md entry exists.** Brief items 1, 3 and 8.

## Phase 2, clustering

**Verdicts: [v344](VERIFY_v344.md), [v345](VERIFY_v345.md), [v346](VERIFY_v346.md) all `GAP`.**

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| E1 | the bolded sentence and its lead-in, under a `Lemma` label | "pinned class", "built from" and "pinned conclusion" are undefined and admit readings with different content, "pair" is the wrong arity, and no proof is written, though the sound reading follows from `feasible_iff` in a paragraph | v344, v345, v346 (`GAP`) | **phase 3**, [ADJ_L113_E1.md](ADJ_L113_E1.md) |
| E3 | "a theorem-shaped extension of post F42" | F42's conclusion is withdrawn in both directions, and L113 is narrower than F42 | v344, v345, v346 (`REFUTED AS STATED`) | **phase 3**, [ADJ_L113_E3.md](ADJ_L113_E3.md) |
| E4 | "the only sources on the table are the Jacobi identity and first Bianchi" | L109's cap $g_\gamma\le2(n-2)\Delta^2\le4(n-2)<4(n-1)$ comes from (A) and $T\ge0$ alone and is invisible to positivity and support | v344, v345, v346 (`REFUTED AS STATED`) | **phase 3**, [ADJ_L113_E4.md](ADJ_L113_E4.md) |
| E5 | the feasibility equivalence without $\theta\ge0$ | fails at negative $\theta$ | v344, v345, v346 | **no finding against the record**: the wording is the brief's item 7, and `feasible_iff_theta` carries `hθ : 0 ≤ θ`. Unit norm is the record's convention for $m_0=4(n-1)$ |
| E6 | L113.lean's declarations | each is a scalar or propositional tautology that never mentions spectra, $g$ or elimination, and `reachable_convex` carries unused hypotheses | v344, v345, v346 (`REFUTED AS STATED` or `CONFIRMED AS ALGEBRA`, unrelated) | **phase 3**, [ADJ_L113_E6.md](ADJ_L113_E6.md) |
| C | (C) never enters $g\ge0$, $m_0$, $m_1$, and the two-atom feasibility characterisation under $\theta\ge0$, $\lVert W\rVert=1$ | direct | v344, v345, v346 (`CONFIRMED`) | no finding |

**Check 1, the brief against the source.** Every passage was copied off disk with its line asserted, and v345 reports each cited line matching the brief verbatim.

**Check 1b and 1c, the three forms.** [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean) types the reviewers' feasibility characterisation and the linearity of moments, not the bolded sentence. [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) is E6. [results.md](../results.md) has no L113 entry.

**Check 2, the whole record.** "Pinned class" appears in [bounds-relaxations.md](../findings/bounds-relaxations.md) lines 366 and 405 and in [Lemma L173](../findings/bounds-relaxations.md) as the relaxation's feasible set at a fixed spectrum, which is the inequality sense, and nowhere with a definition of "moment inequalities built from" positivity and support. No proof of the bolded sentence exists on file, and the unnumbered near-twin the block's own annotations mention is not findable under any of its wordings. [bounds.md](../findings/bounds.md) line 483 uses the same pinned moments for L108's Cauchy–Schwarz bound, which is a consumer of the data, not an argument for the sentence.

## Phase 3, adjudication

**Two fresh verifiers per finding, asked the step neutrally:** E1 to v347 and v348, E3 to v349 and v350, E4 to v351 and v352, E6 to v353 and v354.

| id | adjudicators | outcome |
| --- | --- | --- |
| E1 | [v347](VERIFY_v347.md) `VALID`, [v348](VERIFY_v348.md) `VALID`, both only under a written-out class | **withdrawn as a refutation, and the hypotheses enter the statement** |
| E3 | [v349](VERIFY_v349.md) `FAILS`, [v350](VERIFY_v350.md) `FAILS` | **confirmed** |
| E4 | [v351](VERIFY_v351.md) `FAILS`, [v352](VERIFY_v352.md) `FAILS` | **confirmed** |
| E6 | [v353](VERIFY_v353.md) `VALID` read as both files and `FAILS` as named, [v354](VERIFY_v354.md) `FAILS` | **split on scope, settled against the file as named: confirmed** |

**The defence of E1.** Take inequalities that hold for every nonnegative $g$ supported on the spectrum, and eliminate every free moment. A two-atom $g$ realises every $(m_0,m_1)$ with $\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0$, so every conclusion drawn holds wherever that condition does and follows from it, which at the pinned moments and $\theta\ge0$ is L107. Cauchy–Schwarz with the support bound eliminates $m_2$ to exactly that condition. Both adjudicators require the class written out, "pinned conclusion" read as implied by the pinned data, unit norm, and $\theta\ge0$ for the named form, and v347 notes the literal sentence is close to a tautology without them.

**E3.** Post F42's main claim, that no route through the pinned data closes the conjecture, is withdrawn in both directions at [fence-posts.md](../findings/fence-posts.md) line 423. The block's moral needs that claim, and what survives of F42, a definition and a census, is used by L113 and not extended.

**E4.** L109's cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2\le4(n-2)<4(n-1)$ comes from (A) and $T\ge0$ and excludes a two-atom $g$ on a simple $\lambda_{\min}$. v351 exhibits a critical point at $n=6$ with $\theta=8$, the padded $S^2\times S^3$ tensor, where positivity and support allow $G_2=8064$ and one row of (A), (B), (C) with $T\ge0$ forces $G_2\le7296$. v352 derives a floor $g_k\ge2(n-2)\delta^2$ at distinct eigenvalues from (A) alone. Neither uses Jacobi or first Bianchi.

**E6, the split settled.** The step names L113.lean, and both adjudicators find its five declarations are facts about real scalars or propositions that never mention $g$, $T$ or a moment, `unused_hypothesis` proving weakening, the direction opposite to elimination. v353's `VALID` reads "L113.lean" as both files, the component being `feasible_iff` in L113Statement.lean, which changes the step's subject. The finding is confirmed as stated.

## Phase 4, dependents

**No site links to L113's heading, and no result cites it by number.** [bounds.md](../findings/bounds.md) line 475, an annotation under L108, uses the same pinned moments and eliminates $m_2$ against the support bound, which is this lemma's attaining pair and agrees with the restatement: `SURVIVES`. The report's full dependency graph carries a node for L113 with no text. No route or fence post rests on "cannot leave the pinned class" or on "the single open door". **Impact `CONTAINED`.**

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`.** The added hypotheses are unit norm, the class of inequalities written out, every free moment eliminated, and $\theta\ge0$ for the form that reads as L107.

- **[bounds.md](../findings/bounds.md)**: the heading states what is proved, and the Gate 2 stack and the moral paragraph are replaced by a statement, a proof from the two-atom witness with the attaining pair, and a scope paragraph naming L109's cap as a further constraint. The F42 lineage and "the only sources ... the single open door" are gone.
- **[results.md](../results.md)**: a landscape line and a detail entry, the first L113 has had.
- **[INDEX-results.md](../findings/INDEX-results.md)** row 113 and both **[lean/INDEX.md](../lean/INDEX.md)** rows.
- **[L113.lean](../lean/HamiltonsCubic/Results/L113.lean)** replaced by `pair_eliminates`, `gap_sq_le_two` and `cap_below_mass`. **[L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean)** quotes the audited statement.
- **[ATTEMPTS.md](../ATTEMPTS.md)**: the removed passages and the round's account.

**The restated lemma is new text**, so L113 re-enters the queue for a repair audit.

## Phase 6

L113 keeps its box with a repair audit owed, one line goes under *Checked*, and the next id is L115.
