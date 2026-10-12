# Gate 2 brief: the thirty-six typed entries of the adjugate law

You are an adversarial reviewer. **ONE reviewer, not two, and deliberately.** This round compares a machine-checked file against a result already fixed: the mathematics was audited last round and confirmed by two independent readers, so what remains is whether the Lean statements say what the result says. *There is no reasoning to sample, and two readers would perform the same comparison in different words.*

**You MAY read `lean/HamiltonsCubic/Results/I67AdjugateEntries.lean` and `lean/HamiltonsCubic/Results/I67AdjugateLaw.lean`.** That is the object under review. Do not read the findings files or the screens.

## The result the file claims to type, quoted from the record

On $\mathbb R^6$, with $\varepsilon$ the Levi-Civita symbol on six indices and $X$ a skew $6\times6$ matrix:

$$(\star T)_{ab}=\tfrac1{4!}\sum_{cdef}\varepsilon_{abcdef}T_{cdef},\qquad (X\wedge X)_{abcd}=2\big(X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc}\big),$$
$$\sigma(X)=\tfrac12\star(X\wedge X),\qquad \mathrm{Pf}(X)=\tfrac1{48}\sum\varepsilon_{abcdef}X_{ab}X_{cd}X_{ef}.$$

**THE ADJUGATE LAW**: $X\,\sigma(X)=-\mathrm{Pf}(X)\,\mathrm{Id}$ at every skew $X$.

**Its status, and this is what makes the round a comparison rather than an audit.** The law was proved last round: [r990](REVIEW_r990.md) by multilinearity plus all $2^{15}$ cube vertices, [r991](REVIEW_r991.md) by exact rational expansion and the classical Pfaffian row expansion, and the parent validated by a third symbolic route. *What was NOT settled is whether Lean can carry it.*

## The claims to attack, one row per claim, with the Lean declaration

| # | claim | Lean |
|---|---|---|
| 1 | the file states the adjugate law ENTRY BY ENTRY, at all thirty-six $(i,j)$ | `adj_0_0` … `adj_5_5` in `I67AdjugateEntries.lean`, **thirty-six theorems** |
| 2 | the polynomial appearing on the six diagonal entries IS $\mathrm{Pf}(X)$, in the fifteen free entries | the right-hand side of `adj_i_i`; **no declaration relates it to `pf6`, which is the point of row 7** |
| 3 | the thirty off-diagonal entries assert the product vanishes | the right-hand side of `adj_i_j`, $i\ne j$ |
| 4 | each proof uses only the fifteen $\sigma_6$ entries and $X$'s skewness, no further hypothesis | the proof bodies; `sigma_0_1` … `sigma_4_5` in `I67AdjugateLaw.lean` |
| 5 | the fifteen $\sigma_6$ entries themselves are the signed Pfaffian of the complementary four-set | `sigma_0_1` … `sigma_4_5` |
| 6 | the file is `sorry`-free and rests on the three standard axioms | `#print axioms` on any `adj_i_j` |
| 7 | **the file does NOT state `pf6 X` = that polynomial, and says so** | none, deliberately, **and this is the row to check hardest** |

## What to do

1. **Row 2 first, and it is the one that would make the file worthless if wrong.** The diagonal right-hand side is a written-out cubic in $X_{01},\dots,X_{45}$. **Check it IS the Pfaffian** and not some other cubic that happens to make the entries provable. *A file that types thirty-six true statements about the wrong polynomial passes every other row here.* Recompute the Pfaffian of a skew $6\times6$ yourself and compare term by term, including signs.
2. **Row 7 is where a file like this usually overclaims.** Confirm the file does not assert, in a docstring or a theorem, that it has discharged `L193`'s `sorry`. **It has not**: `pf6` is never related to the polynomial. Say whether the file's own "What is NOT stated" section is accurate, and whether the index row is.
3. **Row 4 asks whether the proofs are honest.** The parent reports that five of six diagonal entries failed until $X$'s skewness was supplied, because row $0$ touches only upper-triangular entries. **Check that no proof smuggles in an extra hypothesis**, and that `IsSkew` is the only assumption.
4. **Row 1 is a count.** Thirty-six theorems, one per $(i,j)$. Verify none is missing and none is stated at the wrong index.
5. **Vacuity.** `IsSkew` must be satisfiable by something with $\mathrm{Pf}\ne0$, or every entry is a statement about nothing. Exhibit one.
6. **Say what this file leaves owed**, in one sentence, so the record can copy it.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct, and any run finishing in a few minutes on objects already in hand.

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r992.md`, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r992.md`. Never `git add -A`, never `git commit -a`, never amend. **Do not write to reviews/INDEX.md.**

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to `agent_logs/r992-adjugate-entries.log`: PID and phase plan on the first line, a line per phase, a heartbeat at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
