# Gate 2 brief: the typed obligation, and the r993 fold

You are an adversarial reviewer. **ONE reviewer, not two, and deliberately.** Nothing here is an argument being made. Both halves are comparisons against something already fixed: a Lean file against the result it claims, and a fold against the report it answers. *Two readers would perform the same comparison and report it in different words.*

**You MAY read [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean), [I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean), [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean), [REVIEW_r993.md](REVIEW_r993.md), [reviews/INDEX.md](INDEX.md), [lean/INDEX.md](../lean/INDEX.md), [findings/LEDGER.md](../findings/LEDGER.md) and [findings/diagonal-half.md](../findings/diagonal-half.md).** Those are the objects under review.

**SCOPE.** Exactly two commits: `f886591a`, which types three declarations, and `baec9b71`, the fold of [r993](REVIEW_r993.md). *Three other commits in the same window, `334b329f`, `0d383099` and `7313f09c`, are another session's report-graph work and are OUTSIDE this round. Do not review them.*

## The definitions, quoted so you can work from them alone

On $\mathbb R^6$, $X$ is **skew** when $X^{\mathsf T}=-X$, and $J$ is a **complex structure** when $J$ is skew and $J^2=-\mathrm{Id}$. With $\varepsilon$ the Levi-Civita symbol on six indices:

$$\mathrm{triple}(X,Y,Z)=\tfrac1{48}\sum\varepsilon_{abcdef}X_{ab}Y_{cd}Z_{ef},\qquad \mathrm{Pf}(X)=\mathrm{triple}(X,X,X),\qquad \sigma(X)=\tfrac12\star(X\wedge X).$$

**GIVEN, proved and Gate 2 passed, not audited here.** The adjugate law $X\,\sigma(X)=-\mathrm{Pf}(X)\,\mathrm{Id}$ at every skew $X$; the pairing $\sum_{a,b}\big(\star(X\wedge X)\big)_{ab}Z_{ab}=12\,\mathrm{triple}(Z,X,X)$ at every $X,Z$ with no hypothesis; and $\mathrm{Pf}(X)$ equal to an explicit cubic in the fifteen free entries. All three carry the three standard axioms and no `sorryAx`.

## The claims to attack, one row per claim, with the Lean declaration

| # | claim | Lean |
|---|---|---|
| 1 | $\mathrm{Pf}(X)^2=\det X$ is STATED for skew $X$, and carries a `sorry` | `pf_sq_eq_det` in [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) |
| 2 | $\det J=1$ is STATED at a complex structure, and carries a `sorry` | `det_complex_structure` |
| 3 | $\mathrm{pf6}(J)=1\lor\mathrm{pf6}(J)=-1$ is PROVED from rows 1 and 2 and nothing else | `pf6_complex_structure` |
| 4 | those two `sorry`s are the ONLY gaps in that file, with no third hidden behind a name | `#print axioms` on all three |
| 5 | **composing `starWedge_of_pf` with `pf6_complex_structure` yields a term concluding `StarWedgeIdentity` that CARRIES `sorryAx`** | `starWedge_of_pf`, `pf6_complex_structure`; **no declaration composes them, which is the claim** |
| 6 | the [r993](REVIEW_r993.md) row in [reviews/INDEX.md](INDEX.md) says what that report actually returned | **none can exist: an index row against a prose report is a text comparison the kernel cannot type** |
| 7 | the [lean/INDEX.md](../lean/INDEX.md) rows and the [LEDGER.md](../findings/LEDGER.md) entry say what [r993](REVIEW_r993.md) returned, including that it PASSED | **none can exist: same reason, a record entry against a report** |
| 8 | [r993](REVIEW_r993.md)'s two docstring corrections were actually applied, and neither file now contradicts itself | `star_wedge_pairing`, `starWedge_of_adjugate`, and the module docstrings that describe them |
| 9 | **NOT claimed anywhere**: that `StarWedgeIdentity` is proved, or that $\mathrm{Pf}^2=\det$ is available | none, deliberately, **and this is the row to check hardest** |

## What to do

1. **Row 5 first, and it is the one that would mislead a later reader worst.** Both `starWedge_of_pf` and `pf6_complex_structure` are theorems, so the composition type-checks and its conclusion IS `StarWedgeIdentity`. **Verify the composed term carries `sorryAx`**, by forming it and running `#print axioms` on it. Then check the record says so: the trap should appear in [diagonal-half.md](../findings/diagonal-half.md), [lean/INDEX.md](../lean/INDEX.md) and [plan.md](../plan.md). *A trap recorded in one place out of three is a trap the next reader meets in the other two.*
2. **Row 3 asks whether the proof is honest.** `pf6_complex_structure` should use its two hypotheses and no further input. **Check no step smuggles in an extra fact**, and that the `∨` is genuinely derived rather than assumed.
3. **Rows 1 and 2 are statements, so check the STATEMENTS.** Is $\mathrm{Pf}(X)^2=\det X$ stated with the right hypothesis class, and is it TRUE as stated at $\dim 6$? Is $\det J=1$ true at every complex structure on $\mathbb R^6$, or only up to sign? **A `sorry` under a FALSE statement is worse than no statement**, because the record then carries a debt that can never be paid.
4. **Rows 6 and 7 are the fold.** Read [REVIEW_r993.md](REVIEW_r993.md) and then the record entries that claim to summarise it. **Does any entry attribute to r993 a verdict it did not give, or drop one it did?** In particular, r993 returned ten rows CONFIRMED with corrections; check that the record does not read as an unqualified pass.
5. **Row 9 is where a fold overclaims.** Confirm no file now asserts `StarWedgeIdentity` is proved.
6. **Vacuity.** Row 3 is worthless if no complex structure exists on $\mathbb R^6$. Exhibit one, and confirm the layer carries it.
7. **Say what this leaves owed**, in one sentence, so the record can copy it.
8. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r994.md`, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r994.md`. Never `git add -A`, never `git commit -a`, never amend. **Do not write to reviews/INDEX.md.**

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to `agent_logs/r994-pfsquared-fold.log`: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
