# Gate 2 brief: the pairing, `pf6`'s closed form, and the discharged `sorry`

You are an adversarial reviewer. **ONE reviewer, not two, and deliberately.** The mathematics here was audited over three previous rounds and confirmed, so what remains is whether the Lean statements say what the result says. *There is no reasoning to sample: the comparison is a single act, and two readers would perform it identically and report it in different words.*

**You MAY read [I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean), [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean) and [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean).** Those are the objects under review. Do not read the findings files or the screens.

## The definitions, quoted so you can work from them alone

On $\mathbb R^6$, with $\varepsilon$ the Levi-Civita symbol on six indices and $X$, $Z$ real $6\times6$ matrices:

$$(\star T)_{ab}=\tfrac1{24}\sum_{cdef}\varepsilon_{abcdef}T_{cdef},\qquad (X\wedge X)_{abcd}=2\big(X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc}\big),$$
$$\mathrm{triple}(X,Y,Z)=\tfrac1{48}\sum\varepsilon_{abcdef}X_{ab}Y_{cd}Z_{ef},\qquad \mathrm{Pf}(X)=\mathrm{triple}(X,X,X),\qquad \sigma(X)=\tfrac12\star(X\wedge X).$$

Write $A=\sum\varepsilon_{abcdef}Z_{ab}X_{cd}X_{ef}$, $B=\sum\varepsilon Z_{ab}X_{ce}X_{df}$ and $C=\sum\varepsilon Z_{ab}X_{cf}X_{de}$.

**GIVEN, on the record and not audited here.** The adjugate law $X\,\sigma(X)=-\mathrm{Pf}(X)\,\mathrm{Id}$ holds at every skew $X$, proved symbolically and confirmed independently by three reviewers, and all thirty-six of its entries are typed and Gate 2 passed. **The fifteen entries $\sigma(X)_{ij}$, $i<j$, are the signed Pfaffian of the complementary four-set**, typed and passed.

## The claims to attack, one row per claim, with the Lean declaration

| # | claim | Lean |
|---|---|---|
| 1 | $\varepsilon$ is antisymmetric in its fourth and fifth slots, and in its fifth and sixth | `levi6_swap_de`, `levi6_swap_ef` in [I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean) |
| 2 | $B=-A$ | `relabel_de` |
| 3 | $C=-B$ | `relabel_fe` |
| 4 | $C=+A$, **the substitution being the EVEN cycle $(d,e,f)\mapsto(f,d,e)$ rather than the odd reversal $(f,e,d)$** | `relabel_df` |
| 5 | $\sum_{a,b}\big(\star(X\wedge X)\big)_{ab}Z_{ab}=12\,\mathrm{triple}(Z,X,X)$ at EVERY $X,Z$, **with no hypothesis, skewness included** | `star_wedge_pairing` |
| 6 | $\mathrm{Pf}(X)$ equals the explicit cubic in the fifteen free entries, at every skew $X$ | `pf6_eq` in [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean) |
| 7 | the adjugate law is PROVED, with no `sorry` and no added hypothesis beyond skewness | `adjugate_law` in [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) |
| 8 | `StarWedgeIdentity` now follows from ONE input, $\mathrm{Pf}(J)=\pm1$, rather than two | `starWedge_of_pf` |
| 9 | all of the above rest on the three standard axioms | `#print axioms` on each |
| 10 | **NOT stated, deliberately**: $\mathrm{Pf}(X)^2=\det X$, and $\mathrm{pf6}(J)=\pm1$ at a complex structure | none, **and this is the row to check hardest** |

## What to do

1. **Row 6 first, and it is the one that would make the whole chain worthless if wrong.** The right-hand side of `pf6_eq` is a written-out cubic. **Check it IS the Pfaffian** and not some other cubic that happens to make the entries provable. *A file that types a true statement about the wrong polynomial passes every other row here.* Recompute $\mathrm{Pf}$ of a skew $6\times6$ yourself, from the definition above, and compare term by term including signs.
2. **Row 5's CONSTANT is the second most likely defect.** Derive the $12$ yourself: the three wedge terms collapse under $\varepsilon$'s antisymmetry, and the $\tfrac1{24}$ meets the $\tfrac1{48}$. **Say whether the constant is $12$ over $\sum_{a,b}$ or over $\sum_{a<b}$**, and check which one the Lean statement writes. *A factor of two here is invisible to every other row.*
3. **Row 4 is where the parent already got a sign wrong once.** Verify the parity claim independently: is the substitution carrying $C$ to $A$ even or odd, and does the Lean proof's two swaps match its parity?
4. **Rows 5, 6 and 7 all claim ABSENCE of hypotheses.** Check the signatures: `star_wedge_pairing` should take no skewness at all, `pf6_eq` and `adjugate_law` should take `IsSkew` and nothing else. **Check that no proof smuggles in an extra assumption.**
5. **Row 10 is where a file like this overclaims.** Confirm no docstring or theorem asserts that `StarWedgeIdentity` is proved outright, or that $\mathrm{Pf}^2=\det$ is available. Say whether each file's own *What is NOT stated* section is accurate.
6. **Vacuity.** `IsSkew` must be satisfiable by something with $\mathrm{Pf}\ne0$, and `star_wedge_pairing` must not be trivially true with both sides zero. Exhibit one object for each.
7. **Say what this chain leaves owed**, in one sentence, so the record can copy it.
8. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r993.md`, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r993.md`. Never `git add -A`, never `git commit -a`, never amend. **Do not write to reviews/INDEX.md.**

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to `agent_logs/r993-pairing-pf6.log`: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
