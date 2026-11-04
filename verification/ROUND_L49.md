# Round L49, the collapse space, and its dimension

**Id:** L49 · **Date:** 2026-09-14 · **Verifiers:** v242, v243, v244 · **Brief:** [BRIEF_L49.md](BRIEF_L49.md) · **Logs:** `agent_logs/verify-L49-v242.log`, `agent_logs/verify-L49-v243.log`, `agent_logs/verify-L49-v244.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the findings statement | [findings/target.md](../findings/target.md) line 775, under the heading at line 759 |
| the landscape statement | [results.md](../results.md) line 188 |
| the canonical entry | [results.md](../results.md) line 655 |
| the Lean statement and proof | [L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean), whole file, no `sorry` |

## The findings from phase 0

**The block is an annotation stack of six Gate 2 notes above an unchanged statement, and the canon still carries three clauses those notes call false or unproved**: the inference that for $n\ge5$ the cubic is spectral at no critical point, the group $O(n)$, and non-realisation of constant $T$ by every $\mathfrak{so}(n)$. *The notes are withheld from the brief as prior verdicts; brief items 4 to 6 ask the questions they answer.*

**The block carries no proof of anything**: its dimension argument lives only inside a verdict annotation, and the eigenframe display has no derivation quoted. *The third form now proves the dimension claim*, [L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean)'s `collapse_space_is_the_constants`, discharged this session with no threshold used, so the brief hands it over as the one written proof.

**The canonical and findings forms disagree**: the findings statement stops before the $n\ge5$ inference and the $n=4$ clause that the canon carries. Brief item 8.

## Adjudication

**Verdicts: [v242](VERIFY_v242.md) `HYPOTHESIS-DEBT`, [v243](VERIFY_v243.md) and [v244](VERIFY_v244.md) `GAP`. Round verdict: `GAP`, narrowed, impact `NARROWS`.** *Unanimous on every claim: the characterisation Lean types is proved, and everything the statement built on it is either wrong as written or argued nowhere.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the collapse space is the constants | proved by hand and in Lean, at every $N\ge3$, the threshold unused | v242, v243, v244 | **confirmed**, stated at $N\ge3$ |
| C2 | the quantifier over spectra | Passages A and B omit "every spectrum", and at one spectrum the dimension claim is false | v243; v242, v244 through the Lean statement | **confirmed**, written in |
| C3 | the eigenframe display's coefficient $3$ | right at $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}$ with Böhm–Wilking's $\#$, $6$ under $-\mathop{\mathrm{tr}}$; no derivation quoted | v242, v243 (`CONFIRMED AS ALGEBRA`), v244 (`HYPOTHESIS-DEBT`) | **confirmed**, normalisation stated; derivation routed below |
| C4 | trace conditions counted as irreducible summands "under $O(n)$" | $\mathcal W_4$ is $O(4)$-irreducible, a reflection swapping $\mathcal W^\pm$; the count is unargued under either group | v242, v243, v244 | **confirmed**, moved to open under $SO(n)$ |
| C5 | constant $T$ realised by no $\mathfrak{so}(n)$ | no argument quoted; needs "on distinct triples" and $n\ge4$ | v242, v243, v244 | **confirmed**, moved to open |
| C6 | "for $n\ge5$ the cubic is spectral at no critical point" | the lemma fixes $T$ over every trace-free spectrum, which a frame's Weyl spectra do not fill; at $n=4$ a non-constant $T$ still gives a spectral cubic | v242, v243, v244 (`GAP`) | **confirmed**, deleted from the canon |
| C7 | "at $n=4$ the cubic is spectral" | no argument, and not from the lemma | v242, v243, v244 | **confirmed**, moved to open |
| C8 | the Lean note "at one fixed $\lambda$, codimension $1$" | $c$ is free, so every $T$ collapses wherever $p_3(\lambda)\ne0$; witnesses at $N=4$ | v242, v243, v244 | **confirmed**, corrected |

**No adjudication pair was spent**: *every finding is unanimous, and the refutations carry closed-form witnesses (the $O(4)$ reflection, a spike spectrum with $p_3\ne0$).*

### Dependents

**None.** *No result outside L49's own block and canon entries cites it, checked by number across the findings, the canon, the plan, the route register and the report.*

### What was changed

- [target.md](../findings/target.md): the annotation stack and the four-clause statement replaced by the proved characterisation, its normalisation and quantifier, and an explicit list of what is open.
- [results.md](../results.md): both entries narrowed the same way; the $n\ge5$ and $n=4$ corollaries removed.
- [L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean): docstring quote refreshed and the codimension sentence corrected.

### Routed

**The eigenframe display's derivation at $-\tfrac12\mathop{\mathrm{tr}}$** is filed under *Support owed* in [plan-verification.md](../plan-verification.md): it is foundational and derived in no quoted passage, and three verifiers each rebuilt it, which a round may not adopt as proof.
