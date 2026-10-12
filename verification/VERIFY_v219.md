# VERIFY v219, Lemma L1, the granted diagonal case repaired at $n=12,14$

Cold read of [BRIEF_L01.md](BRIEF_L01.md) by verifier v219, against [problem.md](../findings/problem.md), [conventions.md](../findings/conventions.md) and Jäger's thesis at source. **No numerical work was done**, no script, no Sage, no Python, no numeric evaluation. [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py) sits on disk and was read, never run; the same for [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py) and [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py). Every figure below is exact rational arithmetic done by hand on an object constructed for the purpose, reported as a screen. Log: [agent_logs/verify-L01-v219.log](../agent_logs/verify-L01-v219.log).

## Claim table

| # | Claim under check | Verdict |
| --- | --- | --- |
| 1 | The status contradiction: which of A, C, D the mathematics supports | **D IS RIGHT; A IS HALF-FALSE; C IS HALF-FALSE** |
| 2 | Does anything on the record depend on L1? | **NO, CONFIRMED INDEPENDENTLY** |
| 3 | *"**Two** dimension constraints carry Theorem A"* | **CONFIRMED AT SOURCE, one qualification** |
| 4 | The census as it now stands | **THE CENSUS IS RIGHT; THE SECTION QUOTING IT IS STILL FALSE, VERBATIM** |
| 5 | The rounding-slack account: $E(n)\le16/(8n+9)$, cleared to $41n-57\ge0$ | **PROVEN, derived independently, direction correct** |
| 6 | The $n=12$ moment-body step: the corner does not exist | **CONFIRMED, but the stated mechanism is not what closes it** |
| 7 | The two moment-problem hypotheses ($S\succeq0$, unit norm) | **BOTH LOAD-BEARING AND BOTH TRUE OF THE OBJECT** |
| 8 | *"Weak duality alone licenses it … the convexity is surplus"* | **PROVEN, and convexity is surplus, as stated** |
| 9 | The interval-arithmetic step: what it establishes | **HYPOTHESIS-DEBT, no reader-checkable argument on file** |
| 10 | Result 5b: what it is, where it is, what L1 loses without it | **FOUND, AND THE LABEL COLLIDES WITH A SECOND RESULT 5b** |
| 11 | Jäger's Theorem A as an import: hypotheses against the object | **CHECKED AT SOURCE, they hold** |
| 12 | Symbol collisions: $S$, $E(n)$, $F$, $\lambda$, $\varphi$ | **FOUR OF L1's FIVE WORKING SYMBOLS ARE UNTABLED** |
| 13 | Traps: $\ker W$, odd $n$, $n=12/14/16$, $6+2\sqrt7$, subfamily, unused hypothesis, witnessless universal | **ANSWERED, one live** |

**Verdict: `HYPOTHESIS-DEBT`.** Everything I could check by hand reproduces exactly, including three constants I rebuilt from scratch. What L1 lacks is not correctness but discharge: it rests on Result 5b, an unnumbered paragraph in [ATTEMPTS.md](../ATTEMPTS.md) whose only recorded warrant is exhaustive brute force at $n=4,5,6$ (three to eight dimensions below where it is used) and on two machine steps whose reader-checkable form is absent from the record.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\theta_0(n)$: *"**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** … the target of Problem P is $\Theta_n$."*
- Norm: *"**This record's norm is $\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$, so $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$**."*
- $\mathcal D_n$: *"$\{S$ symmetric, hollow, $S\mathbf 1=0\}$ (the vertex matrices of coordinate-diagonal W…"*), **this is a different $S$ from L1's.**
- *"Theorem A"*: *"**names four distinct objects on this record.** … **Always name the file.**"*, L1's is [Jäger's](../references/jaeger-2016-diagonal-case/README.md), a fifth sense, and the table does not list it.

From the source, [diss_jaeger_florian.txt:1741-1760](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), verbatim: *"$|W| := W_+ + W_-$, $\mathrm{Ric} := \mathrm{Ric}(|W|)$ … $r := \lVert\mathrm{Ric}\rVert$ … $S := \mathrm{Ric}/r$."* So L1's $S$ is Jäger's normalised Ricci, and its normalisation is **Frobenius**: $\operatorname{tr}S^2=1$.

## 1. The hypothesis inventory

A pass with no inventory is not a pass. Every hypothesis L1's argument consumes, whether or not the block states it.

| # | Hypothesis | Stated where | Used where | Load-bearing? |
| --- | --- | --- | --- | --- |
| H1 | $n$ even, $n=2m$ | Jäger's Assumption 1 | throughout Chapter 3 | **Yes**, this is why *"odd $n$ is untouched"* |
| H2 | $m\ge8$, i.e. $n\ge16$ | Jäger's Assumption 1, [txt:1705](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) | §3.6 ideal induction, [txt:5080](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) | **Yes**, and L1 must *remove* it; Result 5b is the removal |
| H3 | $\lVert W\rVert=1$, $W^2+W^\#=\theta W$, $\theta\ge\theta_0(n)$ | Jäger's Assumption 1 | everywhere | Yes |
| H4 | $k\ge12$ in Lemma 3.5.4 | [txt:3894](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) | Lemma 3.5.5's chain, instantiated at $k=n$ | **Yes, and binds exactly at the target $n=12$** |
| H5 | $x=n\operatorname{tr}S^4-1\in[0,\tfrac{n-2}n]$ | Lemma 3.5.4's statement | same | Yes, and it needs $n\ge9$ (§5 below) |
| H6 | $S\succeq0$ | the block; **not in the printed moment problem** | the support $(0,1]$ | **Yes, the block says so and is right** |
| H7 | $\operatorname{tr}S^2=1$ | the block, as *"unit norm"* | $\mu$ is a probability measure, and $\lambda\le1$ | **Yes** |
| H8 | $\beta\ge0$ in the dual certificate | the script's docstring only | the step $\mathbb E[\lambda^{-2}]\le n\Rightarrow\beta\mathbb E[\lambda^{-2}]\le n\beta$ | **Yes, and it is stated in no findings file** |
| H9 | Lemmas 3.6.7–3.6.8 survive at $n=12,14$ | [ATTEMPTS.md:629](../ATTEMPTS.md) | Result 5b *"replaces §3.6 after Lemma 3.6.10"* | **Yes, and it holds; see §10** |
| H10 | Result 5b itself | [ATTEMPTS.md:629](../ATTEMPTS.md), unnumbered | discharging H2 | **Yes, this is the debt** |

**H8 is a hypothesis used and never stated.** The brief asks for one by name and this is it: $\beta\ge0$ is what turns $\mathbb E[\lambda^{-2}]\le n$ into a usable bound, and it lives only in [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)'s docstring. The block records that *"the hypotheses lived in the scripts' docstrings and in no statement"* for H6 and H7, and then repairs those two and leaves this third one where it found it.

**And a hypothesis stated but never used**: I found none. Every clause of the block is consumed somewhere.

## 2. The status contradiction, which one the mathematics supports

**D is the one that survives.** *"Lemma L1 … audited, and conditional on Result 5b"* is exactly what [LEDGER.md:424-450](../findings/LEDGER.md) records: [r497](../reviews/REVIEW_r497.md) and [r498](../reviews/REVIEW_r498.md) ran on identical briefs, both returned PLAUSIBLE, and the conditionality on Result 5b was their heaviest finding.

**A is half-false.** Its *"NEVER AUDITED"* is false against that ledger row, and its *"it is not worth reviewer time"* has been overtaken by five reviewers. Its *"nothing in this project depends on Lemma L1"* is **true**, and is the half the mathematics supports (§3).

**C is half-false.** *"Proved outright at every $n\ge4$, odd included, by this record's own diagonal theorem"* is supported: [INDEX-results.md:72](../findings/INDEX-results.md) carries L57 as *"Gate 2: the theorem is true and the argument rebuilt cold by both reviewers"*. But C's trailing clause, *"that proof lives only in [results.md](../results.md), not in [findings/](../findings/), and has no ledger row, so its Gate 2 status is unrecorded"*, is **false on all three counts**: the proof is at [problem.md:468-483](../findings/problem.md), the ledger row is [LEDGER.md:424](../findings/LEDGER.md), and the Gate 2 verdict is [INDEX-results.md:16](../findings/INDEX-results.md). C describes the record as it stood before the 2026-08-31 move, which the block itself dates.

**A fourth statement exists and the brief does not list it.** [LEDGER.md:52](../findings/LEDGER.md) still reads *"**NEVER AUDITED, and OUT OF SCOPE, which is why it stays that way** … **Do not spend reviewers on it.**"*, in the same file, 372 lines above the row recording the audit. That is four incompatible statuses, not three.

**The same staleness in a fifth place**: [LEDGER.md:19](../findings/LEDGER.md) says L1's proof *"sits in [results.md](../results.md) rather than in … [findings/](../findings/)"*.

## 3. Does anything depend on L1?, searched, not trusted

I searched the record for consumers rather than accepting any of the three claims.

- **No numbered result cites L1 as an input.** [LEDGER.md:430](../findings/LEDGER.md) records the same finding and its cause: *"L1 cites no numbered result at all. Its block names only itself; it is a leaf over Jäger plus three scripts"*, the earlier "inputs are L18 and L20" having come from a `####`/`###` scanning bug.
- **L1 is a leaf on the other side too.** Its only appearances outside its own block are status lines: [results.md:84](../results.md), [results.md:830](../results.md) (*"superseded as a dependency by Lemma L57"*), [LEDGER.md:19](../findings/LEDGER.md), [LEDGER.md:52](../findings/LEDGER.md), the two index rows, and reviewer reports.
- **The load it once carried is carried elsewhere.** [L57](../findings/problem.md) proves $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for every diagonal Weyl tensor at every $n\ge4$, both parities, with Gate 2 landed. That subsumes the diagonal case at $n=12,14$ without routing through Jäger at all.

**So: nothing on the record depends on L1.** A's scope sentence is right, and it is the single most important true thing in the section.

## 4. How many dimension constraints carry Theorem A

I read the source rather than the record. Every numeric dimension hypothesis I located in Chapter 3, by line of [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf):

| Line | Hypothesis | Binds above $n=12$? |
| --- | --- | --- |
| 1705 | Assumption 1: $m\ge8$, $n=2m$, standing over all of Chapter 3 | **Yes, $n\ge16$** |
| 5080 | *"choose $l\in A_k$ with $l\notin\{a,b,c,d\}$ which is possible **because $m\ge8$**"* | **Yes, the genuine use** |
| 3894, 3934, 3963 | Lemma 3.5.4: $k\ge12$ | Binds **at** $n=12$, satisfied with zero margin |
| 3541 | *"$n(n^2-10n+18)\ge0$ for $n\ge8$"* | No |
| 4340 | *"$\le0$ for $n\ge8$"* | No |
| 3386 | *"for all $n\ge6$"* | No |
| 4823, 4830 | Lemma 3.6.7: $f$ positive on $[7,\infty)$; $g$ positive for $n\ge5$ | No |
| §3.5 chain | the two $n\ge15$ conclusions, cleared by exact evaluation | **Yes, $n\ge15\Rightarrow$ even $n\ge16$** |

**The block's "two" is right.** Exactly two things force $n\ge16$: Assumption 1's $m\ge8$, and the §3.5 chain. Every other hypothesis clears at $n\le12$.

**One qualification the block owes.** Lemma 3.5.4's $k\ge12$ is a live numeric dimension hypothesis and it binds **exactly at the target**. It is satisfied, Jäger's own proof takes $f(12)=-67518<0$ and $g$ nonpositive on $[10,\infty)$, so $k=12$ is inside the range, but the repair has *zero margin* there, and one dimension lower the whole §3.5 apparatus fails outright. The block says *"Two"* and stops; the census at [ATTEMPTS.md:799](../ATTEMPTS.md) does record it. **The block should carry the $k\ge12$ line, because it is the reason $n=12$ and not $n=10$.**

## 5. The census, the finding the brief asks for, and it is not where the brief expects

**The census itself is honest.** [ATTEMPTS.md:799](../ATTEMPTS.md) reads, verbatim: *"$n\ge1,\dots,9$ (all satisfied); $k\ge12$ in Lemma 3.5.4, satisfied and exactly the dimension in question; the two $n\ge15$ conclusions replaced here; and $m\ge8$ three times, twice as the statement of Theorem 3.0.2 and Assumption 1, and **once as a genuine use, the ideal-induction step in §3.6**. That step is precisely the one the six-line graph argument … (Result 5b) already replaces."* Its headline *"nothing else binds above $n=12$"* is consistent with that body **given** Result 5b, and the body names the discharge in the same sentence.

**So *"THE CENSUS REPORTED THE OPPOSITE OF WHAT IT FOUND"* is too strong**, and I record it as a candidate discrepancy that fails the "argue the opposite" test: the census reported the finding and its discharge together. Reported as `withdrawn`, with that reason.

**What is genuinely false is the section that quotes the census.** [problem.md:464](../findings/problem.md) reads: *"**Scope.** A census of every dimension hypothesis in Jäger's Chapter 3 confirms nothing else binds above $n=12$."*, the headline stripped of the body, with no mention of $m\ge8$, of §3.6, or of Result 5b.

**And the refuted sentence still stands too.** [problem.md:456](../findings/problem.md) reads, in the current file: *"Every dimension constraint in Theorem A flows from Lemma 3.5.6."* The block sixteen lines below declares that sentence false. **The file states a claim and its refutation, sixteen lines apart, both unqualified.**

**The spread is wider than [problem.md](../findings/problem.md).** The same refuted sentence survives in two more places, uncorrected:

| File | Text |
| --- | --- |
| [notes.md](../references/jaeger-2016-diagonal-case/notes.md) | *"Every dimension constraint in Theorem A flows from **one lemma**"* and *"A census … confirms nothing else binds above $n=12$"* |
| [README.md](../references/jaeger-2016-diagonal-case/README.md) | *"This project closed $n=12,14$ by showing the threshold is rational rounding slack **inside one lemma**"* |

Both are the reference card a future reader consults first.

## 6. The rounding-slack account, derived independently

The block: $\operatorname{tr}S^4\le E(n)=(8n^2-41n+49)/(4(n+1)(n-2)(n-3))$ rounded to $16/(8n+9)$, *"valid at every $n\ge2$ since the cleared inequality is $41n-57\ge0$"*.

**Source check.** [txt:2529](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), Lemma 3.3.6, ends: *"where the last inequality follows from $(8n^2-41n+49)(8n+9)-64(n+1)(n-2)(n-3)=-41n+57\le0$ for all $n\ge2$."* Same polynomial, same root, opposite sign convention.

**The clearing, derived here from scratch.** Denominators are positive for $n\ge4$, so $E(n)\le16/(8n+9)$ is equivalent to $(8n^2-41n+49)(8n+9)\le64(n+1)(n-2)(n-3)$.

$$(8n^2-41n+49)(8n+9)=64n^3+72n^2-328n^2-369n+392n+441=64n^3-256n^2+23n+441.$$
$$(n+1)(n-2)(n-3)=(n^2-n-2)(n-3)=n^3-4n^2+n+6,\qquad 64\cdot(\;\cdot\;)=64n^3-256n^2+64n+384.$$

The cubic and quadratic terms cancel identically, leaving

$$\mathrm{LHS}-\mathrm{RHS}=(23-64)n+(441-384)=-41n+57.$$

So the inequality holds iff $n\ge57/41=1.3902\ldots$, i.e. **at every integer $n\ge2$**. ✓ Exactly as stated.

**Direction of the rounding.** $E(n)\le16/(8n+9)$, so $16/(8n+9)$ is the **weaker** bound and Jäger discards slack by using it. The repair keeps $E(n)$, which is the tighter side. **The direction is right**, and it is the only direction that could help, a rounding that tightened an upper bound would be unsound rather than merely lossy.

**The cost, screened exactly.** The gap is

$$\frac{16}{8n+9}-E(n)=\frac{41n-57}{4(n+1)(n-2)(n-3)(8n+9)},$$

linear over a quartic. At $n=12$: numerator $492-57=435$; denominator $4\cdot13\cdot10\cdot9\cdot105=491400$; so $435/491400=0.00088522\ldots$ ✓ matching the block's $0.000885$.

**The "sixty-fourth" is a comparison against a figure I cannot check.** [JaegerRounding.lean](../lean/HamiltonsCubic/Results/JaegerRounding.lean) supplies the other half, *"The report's Step 2 residual at `n = 12` is `+0.05627`"*, and $0.05627/0.000885=63.6$. But [lean/INDEX.md:247](../lean/INDEX.md) itself records the debt: *"**Owed**: the feasible-region evaluation behind $\pm0.05627$ and $-0.01741$."* So the ratio is right *given* a number the record marks as unproved. **Recorded as such, not as a defect.**

## 7. The $n=12$ moment-body step

**The claim.** Jäger bounds $\operatorname{tr}S^3$ and $\operatorname{tr}S^4$ separately; the worst case wants $\operatorname{tr}S^4$ at its ceiling with $\operatorname{tr}S^3$ at its floor; *"that corner does not exist"*.

**The shape is right.** Reading Lemma 3.5.5's right-hand side at [txt:3990](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), the term $2\sqrt{\operatorname{tr}S^4+\sqrt{((\operatorname{tr}S^4)^2-(\operatorname{tr}S^3)^4)/(1-(\operatorname{tr}S^3)^2)}}$ grows with $\operatorname{tr}S^4$ and shrinks with $\operatorname{tr}S^3$, so the adversarial corner is exactly (ceiling, floor). A lower bound on $\operatorname{tr}S^3$ that *rises with* $\operatorname{tr}S^4$ is what deletes it. That is what $\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}$ is.

**The two Cauchy–Schwarz relations are correct.** With $\operatorname{tr}S^2=1$ and eigenvalues $\lambda_i$:

$$(\operatorname{tr}S^3)^2=\Big(\sum\lambda_i\cdot\lambda_i^2\Big)^2\le\Big(\sum\lambda_i^2\Big)\Big(\sum\lambda_i^4\Big)=\operatorname{tr}S^4,$$
$$1=(\operatorname{tr}S^2)^2=\Big(\sum\lambda_i^{1/2}\cdot\lambda_i^{3/2}\Big)^2\le(\operatorname{tr}S)(\operatorname{tr}S^3)\quad(\lambda_i\ge0).$$

Both as the block states, and the second needs $S\succeq0$ for the half-powers to exist, H6 again. The box point $(\operatorname{tr}S^3,\operatorname{tr}S^4)=(\tfrac12,\tfrac15)$ is excluded because $(\tfrac12)^2=\tfrac14>\tfrac15$. ✓ Equality in the first holds at the flat spectrum: $\lambda_i=n^{-1/2}$ gives $\operatorname{tr}S^3=n^{-1/2}$, $\operatorname{tr}S^4=n^{-1}$, and $(n^{-1/2})^2=n^{-1}$. ✓

**But the stated mechanism does not close $n=12$, and this is the round's substantive finding.** The two Cauchy–Schwarz relations alone give, with $\operatorname{tr}S\le\sqrt{n\operatorname{tr}S^2}=\sqrt n$,

$$\operatorname{tr}S^3\ \ge\ \frac1{\operatorname{tr}S}\ \ge\ \frac1{\sqrt n}=\frac1{\sqrt{12}}=0.288675\ldots$$

The record's own documented requirement for the contradiction at $n=12$ is $0.31517$ ([run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py), *"requirement for the contradiction 0.31517"*). And $\tfrac1{\sqrt{12}}<0.31517$ because $\tfrac1{12}=0.08\overline{3}<0.099332=0.31517^2$. **The edge falls short by about $0.027$.** What clears the requirement is the certified line: at $v=E(12)=709/4680$,

$$\varphi(E(12))=\tfrac7{10}\cdot\tfrac{709}{4680}+\tfrac{8647}{38000}=\tfrac{4963}{46800}+\tfrac{8647}{38000}=0.106047+0.227553=0.333600,$$

which clears $0.31517$ with about $0.018$ to spare. So the closure rests on the **dual certificate**, which consumes $\mathbb E[\lambda^{-2}]\le n$ and is an estimate (the rationalisation *"costs only 0.002 of margin"*).

**Therefore the block's *"the corner elimination is a genuine equality case rather than an estimate"* overstates.** The Cauchy–Schwarz edge is a genuine equality case and it is genuinely invisible to a box; it is not what closes $n=12$. [lean/INDEX.md:202](../lean/INDEX.md) is the honest version, it proves the edge and lists *"**Owed**: the reduction to Jäger's expression, the dual construction, and Result 5b"*. **The block's prose is stronger than its own Lean row.**

*Discrepancy protocol.* Located: [problem.md:481](../findings/problem.md). Exhibited: $1/\sqrt{12}=0.288675<0.31517$, closed form, no computation. Argued opposite: one could read *"the corner elimination"* as naming only the qualitative fact that the box is strictly larger than the moment body, which the $(\tfrac12,\tfrac15)$ witness establishes and which is true. **I keep the finding**, because the sentence sits where a reader takes it as the reason $n=12$ closes, and the record has no other sentence saying the dual is load-bearing.

**And the narrative sentence conflates two floors.** *"The floor forces the flat spectrum, which drags the ceiling down with it"*, the floor that forces the flat spectrum is $\operatorname{tr}S^4\ge1/n$, a floor on the *fourth* moment; the corner at issue puts the *third* moment at its floor. Two different floors, one sentence.

## 8. The two hypotheses, and whether they are load-bearing

**Both are, and the block is right about both.**

**H7, unit norm.** $\mu:=\sum_i\lambda_i^2\delta_{\lambda_i}$ has total mass $\sum\lambda_i^2=\operatorname{tr}S^2$, so $\mu$ is a probability measure **iff $\operatorname{tr}S^2=1$**. And $\lambda_i^2\le\sum_j\lambda_j^2=1$ gives $\lambda_i\le1$. So unit norm delivers both *"probability measure"* and the right-hand endpoint of $(0,1]$.

> **The block says "positive semidefinite of unit norm" and the norm is not named.** Under the operator norm $\lVert S\rVert_{\mathrm{op}}=1$ the support statement still holds but $\mu$ is **not** a probability measure and $\mathbb E[\lambda^2]=v$ is not $\operatorname{tr}S^4$. The next sentence of the block repairs it (*"$S\succeq0$ with $\operatorname{tr}S^2=1$"*) and [conventions.md:29](../findings/conventions.md) makes the ambiguity a live one on this record. **Name the norm in the summary sentence, not only in the sentence after.**

**H6, positive semidefiniteness.** It delivers the left-hand end: $\lambda_i\ge0$, so $\operatorname{supp}\mu\subseteq[0,1]$, and $\mu$ gives zero mass to $\lambda=0$, so $\operatorname{supp}\mu\subseteq(0,1]$. The block's demonstration that it is load-bearing is correct and I reproduce its arithmetic: $\delta_{-1}$ is feasible for the printed problem at $v=1$ and gives $\mathbb E[\lambda]=-1$, against

$$\varphi(1)=\tfrac7{10}+\tfrac{8647}{38000}=\tfrac{26600}{38000}+\tfrac{8647}{38000}=\tfrac{35247}{38000},$$

a gap of $\tfrac{35247}{38000}+1=\tfrac{73247}{38000}>1$. ✓ Both figures in [lean/INDEX.md:202](../lean/INDEX.md) are exactly right.

**And the straddle is right too.** $\varphi(1/12)=\tfrac7{120}+\tfrac{8647}{38000}=0.058333+0.227553=0.285886<0.288675=1/\sqrt{12}$, while $\varphi(1/10)=0.07+0.227553=0.297553>1/\sqrt{12}$. ✓ The line crosses $1/\sqrt{12}$ between $v=1/12$ and $v=1/10$, exactly as recorded.

**Is $S\succeq0$ true of the object?** Yes, and it is checkable at source: $S=\mathrm{Ric}(\lvert W\rvert)/r$ with $\lvert W\rvert=W_++W_-\succeq0$ by [txt:1741](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), and $\mathrm{Ric}$ of a positive-semidefinite curvature operator is a positive-semidefinite matrix. So **H6 and H7 hold for the object and are not merely assumed.**

## 9. The duality step

**The block: *"weak duality alone licenses it, so no constraint qualification is owed and the convexity appealed to here is surplus."* This is correct, and here is the whole argument.**

Suppose $h(\lambda):=\lambda-\alpha\lambda^2+\beta\lambda^{-2}\ge\gamma$ pointwise on $(0,1]$, with $\beta\ge0$. Let $\mu$ be any feasible measure: a probability measure on $(0,1]$ with $\mathbb E[\lambda^2]=v$ and $\mathbb E[\lambda^{-2}]\le n$. Integrating the pointwise inequality against $\mu$,

$$\mathbb E[\lambda]-\alpha v+\beta\,\mathbb E[\lambda^{-2}]\ \ge\ \gamma .$$

Since $\beta\ge0$ and $\mathbb E[\lambda^{-2}]\le n$, we have $\beta\,\mathbb E[\lambda^{-2}]\le n\beta$, hence

$$\mathbb E[\lambda]\ \ge\ \gamma+\alpha v-n\beta\ =:\ \varphi(v).$$

**Three integrations and one sign. No convexity of $F$, no Slater condition, no strong duality, no attainment.** The argument bounds every feasible $\mu$ directly and never mentions the value function. Convexity would be needed only to claim the line is *tight*, and nothing downstream uses tightness.

**Screened the certificate's arithmetic by hand.** With $\alpha=\tfrac7{10}$, $\beta=\tfrac1{152}$, $\gamma=\tfrac{613}{2000}$, $n=12$:

$$\gamma-n\beta=\tfrac{613}{2000}-\tfrac{12}{152}=\tfrac{613}{2000}-\tfrac{3}{38}=\tfrac{613\cdot19-3\cdot1000}{38000}=\tfrac{11647-3000}{38000}=\tfrac{8647}{38000}.$$

**Exactly the block's constant**, rebuilt from the three rationals without running anything. And the quartic's endpoint, $q(\lambda)=(h(\lambda)-\gamma)\lambda^2$ at $\lambda=1$:

$$-\tfrac7{10}+1-\tfrac{613}{2000}+\tfrac1{152}=\tfrac{-26600+38000-11647+250}{38000}=\tfrac{3}{38000}>0.$$

A margin of $3/38000$ at the right endpoint, **thin, but positive, and exact.** This is a screen of a claim I record, not evidence for a positive claim: what I have not checked is that $q$ has no root in the open interval, which is the root-isolation step.

> **The surplus convexity survives in the script.** [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)'s docstring still gives the *reason* as *"F is CONVEX in v … so a Lagrangian dual certificate computed at a single v is a supporting line valid for every v"*, and [problem.md:459](../findings/problem.md) still says *"That problem is convex, so its Lagrangian dual gives a supporting line valid at every value at once"*. **The block corrected this and the two places a reader looks did not.**

## 10. Result 5b, found, and the label collides

**Where it is.** [ATTEMPTS.md:629](../ATTEMPTS.md), inside a paragraph headed *"Result 5, two by-products, both independently confirmed"*, as part (b).

**What it states**, verbatim: *"Jäger's §3.6 endgame (~5 pages of symmetric-space classification and ideal induction) is replaceable by a six-line graph argument, his Lemma 3.6.10's two vanishing traces say exactly that the positive-entry graph $G$ is a disjoint union of cliques and $\bar G$ is triangle-free, forcing two blocks, with the degree count forcing them equal."*

**Its recorded warrant**, verbatim: *"Verified by exhaustive brute force over all graphs at $n=4,5,6$: exactly $2^{n-1}$ graphs satisfy both trace conditions, matching the prediction term by term."*

**Its own two precision notes**, verbatim: *"Jäger's $I_+$ indicates $\{w_{ij}\ge0\}$ rather than $\{>0\}$ (harmless, the argument runs verbatim), and the route still consumes Lemmas 3.6.7–3.6.8, so it replaces §3.6 after Lemma 3.6.10 rather than the whole section. It removes the only $m\ge8$ invocation there but does not lower the threshold, which lives in §3.5."*

**Does the "after 3.6.10" restriction survive at $n=12,14$?** Yes, and I checked at source. The lemmas Result 5b still consumes carry no $m\ge8$ of their own: Lemma 3.6.7's proof at [txt:4823](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) needs *"$f$ restricted to $[7,\infty)$ is positive"* and *"$g(n)$ … positive for $n\ge5$"*; Corollary 3.6.8 is algebra; Lemma 3.6.10 uses $a=1/(n-1)$, $C_\#\ge0$ and $X(W)\ge0$ from §3.2, whose dimension needs are the $n\le9$ entries of the census. **So the structural claim holds: replacing §3.6 after 3.6.10 does remove the last $m\ge8$ use.**

### What L1 loses without Result 5b

**Everything.** Without it, Assumption 1's $m\ge8$ stands, so $n\ge16$ stands, so Jäger's Theorem A is unavailable at $n=12,14$ and L1's conclusion has no proof at all, the §3.5 repair would then have cleared a constraint that was never the binding one. **L1 is not weakened by the loss of Result 5b; it is emptied.**

### Three defects in Result 5b's standing

1. **Its warrant is numerical and below the range of use.** *"Exhaustive brute force over all graphs at $n=4,5,6$"* is a check at three dimensions, used at $n=12$ and $n=14$. The graph statement (a union of cliques whose complement is triangle-free has at most two parts), is a two-line argument ($\bar G$ complete multipartite, so $k\ge3$ parts give a triangle), and [r497](../reviews/REVIEW_r497.md) says so: *"the argument looks right to me"*. **But the record's stated warrant is the brute force, not the argument.** *This is the trap "a claim proven on a subfamily and used in general", and it is live here.*
2. **The label collides.** [ATTEMPTS.md:888](../ATTEMPTS.md) carries a *different* "Result 5(b)": *"$J_5=\langle X_{\mathrm{inv}},H\rangle$ with $H=\mathrm{Ric}^*(\mathrm{Ric}(\lvert W\rvert))$"*, and [run_j5cross_proof.py](../scripts/runs/run_j5cross_proof.py) and [review_c8_independent.py](../scripts/misc/review_c8_independent.py) both cite "Result 5b" meaning **that** one. **L1's block names "Result 5b" with no link and no file line, and the name resolves to two objects.** [conventions.md:41](../findings/conventions.md) already legislates for this case (*"Always name the file"*) and L1 does not.
3. **It is unnumbered, unindexed, and has never been through Gate 2**, as the block says. [r497](../reviews/REVIEW_r497.md)'s recommendation 7 (*"Number Result 5b, or state in L1 that it is unnumbered"*), has been half-taken: L1 states it, and 5b remains unnumbered.

## 11. The interval-arithmetic step, what a validated-interval discharge establishes

**I did not run [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py).** I read it. My question is what the discharge establishes, what it assumes, and whether the record may stand a proof on it.

**What it would establish if run and correct.** The script covers $v\in[10/81,\,709/4680]$ by adaptive bisection, evaluating Jäger's RHS with `mpmath`'s `iv` interval type and accepting a subinterval when the enclosure's **upper** end is negative. That is the right test, an upper bound on an enclosure of a maximum is a valid certificate of negativity, and it is a genuine proof method, not sampling.

**What it assumes, and every item is unstated in the block.**

| Assumption | Where it lives |
| --- | --- |
| `mpmath.iv` produces true outward-rounded enclosures for `sqrt`, `**`, `/`, i.e. the library is sound | nowhere on the record |
| The expression coded in `rhs_enclosure` **is** Jäger's Lemma 3.5.5 RHS at $n=12$ | nowhere; the reduction is listed as *"Owed"* in [lean/INDEX.md:202](../lean/INDEX.md) |
| The max-over-cases really is over $t\in\{\hat\theta_0/v,\ (n-3)\tilde\theta_0\}$ only, that the two endpoints bound the interior | the block calls this *"licensed by the source's own convexity, $\mathrm{RHS}''\ge0$"*; **no derivation of $\mathrm{RHS}''\ge0$ is on the record** |
| The lower limit $10/81=(n-2)/(n-3)^2$ is where Assumption 2 is already contradicted | the script's docstring only |
| $\varphi$ is a valid lower bound on $\operatorname{tr}S^3$, i.e. §9's certificate | the block; the root isolation is not on file |

**The certificate is not on file.** The block says *"ten subintervals, each with a proven negative bound"*, but the script computes the subdivision at run time and prints only a count and a worst-case bound. **There is no list of ten intervals with ten bounds anywhere in the record.** A validated-interval proof is exactly its certificate; without the certificate the record has the *claim* that a certificate exists, which is a different thing and is not independently checkable. Re-running the script is not a check, it is a re-assertion by the same code.

**May the record stand a proof on it?** On a *validated-interval computation*, yes, [LEDGER.md:450](../findings/LEDGER.md) is right that *"exact root isolation and validated interval arithmetic are proof-grade methods, so the interval finish is no reason to demote"*, and this record has done it properly before ([INDEX-results](../findings/INDEX-results.md) records the B0 residual closed *"in 94 boxes with no floating-point-only step"*). On *this* one, not yet: three of its five assumptions have no derivation anywhere, and the certificate it produces is not recorded. **`HYPOTHESIS-DEBT`, and the debt is nameable: publish the subdivision, and derive $\mathrm{RHS}''\ge0$.**

**One more.** The script's final print asserts *"with the exhaustive Chapter 3 dimension census, Jaeger's Theorem A extends to even $n=12$ and $n=14$"*, but it runs at `N = 12` only. **The $n=14$ half has no interval run**, which is exactly what [r498](../reviews/REVIEW_r498.md) recommended flagging: *"with the $n=14$ half marked as evaluated at Jäger's corner pending the E5a run at $N=14$"*. That flag is in the review and not in the block.

## 12. Jäger's Theorem A as an import, hypotheses checked against the object

The brief names this as the import whose hypotheses were never checked. I checked them at source.

| Theorem A's hypothesis, [txt:113](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) | Against L1's object |
| --- | --- |
| $n\ge16$ even | **This is the hypothesis L1 attacks.** Even is retained; $\ge16$ is what the repair moves to $\ge12$ |
| $W\in\langle W\rangle_d$ | the diagonal locus, matches, and [notes.md](../references/jaeger-2016-diagonal-case/notes.md) records the vertex-matrix dictionary |
| $\lVert W\rVert=1$ | matches |
| $W^2+W^\#=\theta W$ with $\theta\ge\theta_0(n)$ | matches [conventions.md](../findings/conventions.md)'s $\theta$ and $\theta_0(n)$ |

**And the derived object.** $S=\mathrm{Ric}(\lvert W\rvert)/r$ with $r=\lVert\mathrm{Ric}\rVert$ (Frobenius), giving $\operatorname{tr}S^2=1$ and $S\succeq0$, which is precisely H6 and H7. **The import's hypotheses hold of the object, and the normalisation the moment problem needs is the source's own.** This is the one trap on the brief's list where the record comes out clean.

**A loose invocation at the one place $m\ge8$ is used.** At [txt:5080](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) the justification is *"choose $l\in A_k$ with $l\notin\{a,b,c,d\}$ which is possible because $m\ge8$"*, but the combinatorial need is only $\#A_k\ge5$. So the printed reason appears far stronger than the step requires. **I do not build a finding on this**: the extraction is lossy ([txt:2539](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) carries a spurious factor $\tfrac14$ on the very identity §6 verifies), and Result 5b removes the step regardless, so nothing in L1 turns on it. *Reported as `withdrawn` under the discrepancy protocol, with the reason.*

## 13. Symbol collisions

**Four of L1's five working symbols are tabled nowhere**, and three of the four collide with objects [conventions.md](../findings/conventions.md) does table.

| Symbol | L1's sense | Collides with |
| --- | --- | --- |
| $S$ | Jäger's normalised Ricci $\mathrm{Ric}(\lvert W\rvert)/r$ | $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf1=0\}$ ([conventions.md:47](../findings/conventions.md)); $S_{XYZ}$ ([:20](../findings/conventions.md)); $S(W)$ the gradedness slack ([:48](../findings/conventions.md)) |
| $E(n)$ | $(8n^2-41n+49)/(4(n+1)(n-2)(n-3))$ | Jäger's own $E$, the operator with $\lVert E\rVert=e$ at [txt:1750](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), **a collision inside the source L1 is reading**, and $e\le\sqrt{3/2n}$ is used in the same chain |
| $F$ | the moment-problem value function $F(v)$ | $\partial\Omega_a$ at $F=\tfrac4{n-2+4a}$ ([conventions.md:32](../findings/conventions.md)); [L17](../findings/route-a.md)'s $F\ge0$ ([:117](../findings/conventions.md)); $F_u$, $F_\lambda$ ([:63](../findings/conventions.md)) |
| $\lambda$ | a spectral variable of $S$ under $\mu$ | the Einstein constant ([conventions.md:30](../findings/conventions.md)); $\bar\lambda=\mathrm{scal}/n$ and $\lambda_i=\mathrm{Ric}_{ii}$ in Jäger's own notation at [txt:1745](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), **so $\lambda$ means two different things inside the argument L1 is quoting** |
| $\varphi$ | the certified line | untabled |

**And "Theorem A" itself.** [conventions.md:41](../findings/conventions.md) says the phrase *"names four distinct objects on this record"* and lists two by file. **Jäger's is a fifth and the row does not carry it**, though L1 is the block that uses the phrase most.

## 14. The remaining traps, each answered

- **$\ker W\ne0$ and padded objects.** *Not a trap here, and worth stating why.* Under $\mu=\sum\lambda_i^2\delta_{\lambda_i}$, zero eigenvalues carry zero mass, and $\mathbb E[\lambda^{-2}]=\sum_{\lambda_i\ne0}\lambda_i^2\lambda_i^{-2}=\#\{i:\lambda_i\ne0\}=\operatorname{rank}S$. **So the constraint $\mathbb E[\lambda^{-2}]\le n$ is literally "$S$ has at most $n$ nonzero eigenvalues" (automatic) and a kernel makes it slack, which only helps.** The record nowhere says this, and it is the cleanest reading of the third constraint.
- **Odd $n$.** Untouched, and correctly so: Jäger's Assumption 1 fixes $n=2m$, so nothing in Chapter 3 is available at odd $n$ and L1 claims nothing there. [notes.md](../references/jaeger-2016-diagonal-case/notes.md) records the source's own remark at [txt:4176](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf): *"if the odd dimensional version of the theorem is also true, then better estimates will be needed."* **No defect.**
- **$n=12$.** The tightest boundary on the record. Lemma 3.5.4's $k\ge12$ binds with zero margin; the quartic certificate's endpoint margin is $3/38000$; the requirement is cleared by $0.018$. **All three positive, all three thin, and only the first is recorded outside a script.**
- **$n=14$.** Reached by exact endpoint evaluation, not by the interval run, §11. **The block does not say so.**
- **$n=16$.** Theorem A's published threshold. No overlap defect: L1 claims $12,14$ and Theorem A covers $\ge16$, so the two are disjoint and jointly give even $n\ge12$.
- **The crossover $n=6+2\sqrt7$.** Belongs to [L2](../results.md) and [L44](../findings/problem.md), not to L1; L1's argument does not evaluate anything there. **Checked and not live for this row.**
- **A claim proven on a subfamily and used in general.** **Live, Result 5b, brute-forced at $n=4,5,6$ and used at $n=12,14$.** §10.
- **A hypothesis stated but never used.** None found.
- **A step using a hypothesis never stated.** **Live, $\beta\ge0$ (H8).** §1.
- **A universal claim with no witness.** The universal claims here are negative ($q$ has no root in $(0,1]$; RHS $<0$ on the range), so a witness would be a *falsifier*; see §15.

## 15. What would break it, and what I did to look

**The object that would falsify L1's conclusion**: a $W\in\langle W\rangle_d$ at $n=12$ or $n=14$ with $\lVert W\rVert=1$ and $W^2+W^\#=\theta W$ for some $\theta\ge\theta_0(n)$, which is **not** the normalised Weyl curvature of $S^{n/2}\times S^{n/2}$.

**What I did.** I did not search for one, and I record why that is the right choice rather than a gap: [L57](../findings/problem.md) proves $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for every diagonal Weyl tensor at every $n\ge4$ with equality exactly at the balanced product, with Gate 2 landed on both reviewers. **Any such object would falsify L57 as well as L1**, so L1's conclusion has independent standing on this record and is not what is at risk.

**The object that would falsify L1's *proof*** (which is what is at risk), is smaller and I state it exactly: **a probability measure $\mu$ on $(0,1]$ with $\mathbb E[\lambda^{-2}]\le12$ and $\mathbb E[\lambda]<\tfrac7{10}\mathbb E[\lambda^2]+\tfrac{8647}{38000}$.**

**What I did to look for it.** I derived the weak-duality argument in full (§9) and it forecloses every such $\mu$ **provided** $q(\lambda)=-\tfrac7{10}\lambda^4+\lambda^3-\tfrac{613}{2000}\lambda^2+\tfrac1{152}\ge0$ on $(0,1]$. I screened the one point where a certificate of this shape most often fails (the right endpoint) and found $q(1)=3/38000>0$ exactly. **I did not verify root-freeness on the open interval**: that is the exact-root-isolation step, it is reserved under the analysis-only rule, and re-running the script would not check it anyway. **So the falsifier is confined to a single closed-form question about one quartic on one interval, and that question is the whole of what an independent check still owes.**

**A second, structural falsifier**: a union-of-cliques graph $G$ on $n=12$ vertices with $\bar G$ triangle-free and more than two parts. **None can exist** ($\bar G$ is then complete multipartite, and three or more parts furnish a triangle across them) so Result 5b's *mathematics* is safe even though its *warrant on the record* is a brute force at $n\le6$. **I supply no missing argument here; I record that the two-line argument is what the record should carry and does not.**

## 16. Verdict

**`HYPOTHESIS-DEBT`.**

**What holds.** The rounding derivation, rebuilt from scratch and matching the source line for line. The direction of the rounding. The count of two threshold-carrying constraints, verified against the thesis. The weak-duality licence, with convexity genuinely surplus. Both moment-problem hypotheses, load-bearing and true of the object. Three constants ($\tfrac{8647}{38000}$, $\tfrac{35247}{38000}$, $q(1)=\tfrac3{38000}$), rebuilt by hand from the underlying rationals. The import's hypotheses, checked at source. The structural claim that Result 5b removes the last $m\ge8$ use.

**What is owed, in the order it should be paid.**

1. **Delete the two refuted sentences from [problem.md:456](../findings/problem.md) and [problem.md:464](../findings/problem.md)**, and from [notes.md](../references/jaeger-2016-diagonal-case/notes.md) and [README.md](../references/jaeger-2016-diagonal-case/README.md). A file that states a claim and its refutation sixteen lines apart hands the reader a coin flip.
2. **Number Result 5b, give it the two-line graph argument as its warrant, and link it from L1's block by file and line**, the label currently resolves to two different objects.
3. **Record the ten subintervals.** A validated-interval proof is its certificate.
4. **Derive $\mathrm{RHS}''\ge0$**, or drop the claim that endpoint evaluation is licensed.
5. **State $\beta\ge0$** in the moment problem, beside $S\succeq0$ and $\operatorname{tr}S^2=1$, and **name the norm** in the summary sentence.
6. **Soften *"a genuine equality case rather than an estimate"***: the Cauchy–Schwarz edge gives $1/\sqrt{12}=0.2887$ against a requirement of $0.3152$; the dual certificate is what closes $n=12$.
7. **Say that $n=14$ has no interval run**, and add Lemma 3.5.4's $k\ge12$ to the block.
8. **Reconcile the four status statements**, [problem.md:450](../findings/problem.md), [LEDGER.md:52](../findings/LEDGER.md), [LEDGER.md:19](../findings/LEDGER.md), and [INDEX.md:19](../findings/INDEX.md), against the one the mathematics supports: **audited, conditional on Result 5b, and not load-bearing for the programme.**

**None of this touches the programme's footing.** [L57](../findings/problem.md) carries the diagonal case at every $n\ge4$ in both parities with Gate 2 landed, so L1 is a correction offered to the setter and nothing on the record depends on it, which is the one thing all four status statements should have said and only one of them does.
