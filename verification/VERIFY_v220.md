# VERIFY_v220, Lemma L1, the granted diagonal case repaired at $n=12,14$

**Cold read of [BRIEF_L01.md](BRIEF_L01.md), sections A–D, against [problem.md](../findings/problem.md), [INDEX.md](../findings/INDEX.md), [INDEX-results.md](../findings/INDEX-results.md), [LEDGER.md](../findings/LEDGER.md), [conventions.md](../findings/conventions.md), [ATTEMPTS.md](../ATTEMPTS.md), [lean/INDEX.md](../lean/INDEX.md) and the source at [references/jaeger-2016-diagonal-case/](../references/jaeger-2016-diagonal-case/). No numerical work of any kind was done: no script was run, no Sage, no Python, no floating-point evaluation. Every arithmetic statement below is exact rational or polynomial algebra done by hand; the two places where I estimated rather than computed exactly are labelled SCREEN and carry no weight in any verdict. Log: `agent_logs/verify-L01-v220.log`.**

## Claim table

| # | claim under check | verdict |
| --- | --- | --- |
| 1 | The status row: which of A, C, D the mathematics supports | **D**; A and C are STALE, and each is falsified by the record's own files |
| 2 | *"nothing in this project depends on Lemma L1"* | **CONFIRMED**, no proof on the record consumes L1; one scope sentence cites it where [L57](../findings/problem.md) would serve |
| 3 | **Two** dimension constraints carry Theorem A | **CONFIRMED AT SOURCE**, the $n\ge15$ pair inside Lemma 3.5.6, and Assumption 1's $m\ge8$ at extraction line 5080 |
| 4 | The census as it now stands | **CONFIRMED AS A CENSUS**, every literal count checks against the thesis |
| 5 | The two sentences the block declares false | **STILL STANDING, VERBATIM**, ten and sixteen lines above the block that refutes them, in the same file, and again in the reference card |
| 6 | The rounding-slack account: $E(n)$, the clearing $41n-57\ge0$, the direction, the cost | **CONFIRMED, derived in full by hand**, and $E(12)=709/4680$ recovered independently |
| 7 | *"valid at every $n\ge2$"* | **IMPRECISE, INHERITED**, true of the polynomial, false of the rational inequality below $n=4$; harmless in context |
| 8 | The $n=12$ moment-body step, and the corner | **CONFIRMED IN SUBSTANCE**, and located at extraction line 4239ff |
| 9 | *"**The edge itself is $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$**"* | **REFUTED**, that edge admits the corner in question; the other one excludes it, and Jäger already prints the first |
| 10 | The two load-bearing hypotheses, $S\succeq0$ and unit norm | **CONFIRMED, and load-bearing more sharply than the record says**, without the support cap the dual does not merely weaken, it collapses |
| 11 | *"weak duality alone licenses it … the convexity appealed to here is surplus"* | **CONFIRMED**, with one wording correction: what weak duality returns is a minorant, not a supporting line |
| 12 | *"the endpoint evaluation is licensed by the source's own convexity, $\mathrm{RHS}''\ge0$ … survives at $n=12,14$"* | **CONFIRMED VERBATIM AND DERIVED**, the licence holds at every $n\ge1$ |
| 13 | The interval-arithmetic step | **GAP**, the certificate is not on the record, and the substitution it performs rests on an unstated monotonicity |
| 14 | *"both dimensions are machine-checked"* | **OVERSTATED**, the interval script is hard-coded at $N=12$ |
| 15 | The count of sharpenings | **UNDERSTATED**, the block names three of the four the script records, omitting the one that carries $n\ge13$ |
| 16 | Result 5b: what it is, where it is, what L1 loses without it | **FOUND** at [ATTEMPTS.md:629](../ATTEMPTS.md); and its *necessity* is asserted, not established |
| 17 | Symbol collisions: $S$, $E(n)$, $F$, $\lambda$, $\mu$ | **ALL FIVE LIVE, NONE TABLED**, and $S$ is the dangerous one |
|, | **Lemma L1 overall** | **GAP** |

**One line.** Every claim L1 makes *about Jäger's thesis* reproduces exactly against the thesis, the two dimension constraints, the census, the algebra of $E(n)$, the convexity licence, the corner, but the three steps that do the closing are carried by scripts and not by the record, the block names the wrong Cauchy–Schwarz edge as its own contribution, and the two sentences Gate 2 refuted are still standing verbatim in the section that frames the block.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

> **$\tilde\theta_0$ and $\hat\theta_0$ are Jäger's, and neither is $\Theta_n$.** $\tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-3)}{(n+1)(n-2)}}$ (Notation 3.0.3, the $S^m\times S^{m+1}$ value) and $\hat\theta_0(n)=\frac{n-2}{n-3}\tilde\theta_0(n)$; they are the endpoints of his Assumption-2 interval.

> $\theta_0(n)$, **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.**

> **$\#$ and $\mathrm{Ric}$, and why they belong here.** $\#$ is the halved Böhm–Wilking product … and $\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$, with $\lVert\mathrm{Ric}\rVert$ the Frobenius norm of the resulting symmetric matrix.

> **"Diagonal" means diagonal in coordinate $2$-planes $e_i\wedge e_j$** of an orthonormal frame of $\mathbb R^n$, *not* diagonal as an operator on $\Lambda^2\mathbb R^n$.

The third of these is what makes L1's normalisation readable at all. $S=\mathrm{Ric}(\lvert W\rvert)/\lVert\mathrm{Ric}(\lvert W\rvert)\rVert$ therefore has $\mathop{\mathrm{tr}}S^2=1$, **not** $\mathop{\mathrm{tr}}S=1$, and that is the only reading under which $\mu=\sum\lambda_i^2\delta_{\lambda_i}$ is a probability measure. The block asserts the probability claim and never says which norm; the convention supplies it.

## 1. Hypothesis inventory

**A pass with no inventory is not a pass.** Everything L1 needs, where it is stated, and whether it is used.

| # | hypothesis | stated where | used where | status |
| --- | --- | --- | --- | --- |
| H1 | $W\in\langle W\rangle_d$, $\lVert W\rVert=1$, $W^2+W^\#=\theta W$ | Jäger Assumption 1, extraction L1705 | throughout | stated at source, **not in the L1 block** |
| H2 | $\theta\ge\theta_0(n)$ | Assumption 1 | §3.6 only; §§3.2–3.5 need only $\theta\ge\tilde\theta_0(n)$ | stated at source, **not in the block** |
| H3 | $n=2m$, $m\ge8$ | Assumption 1, *both clauses* | $m\ge8$ once genuinely, at L5080; evenness at §3.6 | the block names $m\ge8$ and **never names the evenness clause** |
| H4 | Assumption 2, $\mathop{\mathrm{scal}}\le(n-3)\tilde\theta_0(n)$ | extraction L2212 | the contradiction hypothesis of Lemma 3.5.6 | used, unstated in the block |
| H5 | $S\succeq0$ | block, after r497/r498 | the dual, and $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ | **stated and load-bearing** (§6) |
| H6 | $\mathop{\mathrm{tr}}S^2=1$, hence spectrum in $[0,1]$ | block ("unit norm") | probability measure; support cap | **stated and load-bearing** (§6) |
| H7 | $\mathbb E[\lambda^{-2}]=\mathop{\mathrm{rank}}S\le n$ | block, as a constraint | the dual's $-\beta n$ term | stated; its *meaning* (it is the rank) is nowhere |
| H8 | $\mathop{\mathrm{tr}}S\le\sqrt n$ | **nowhere** | needed to turn $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ into $\mathop{\mathrm{tr}}S^3\ge n^{-1/2}$ | **step using a hypothesis never stated** |
| H9 | $f(y)=\frac{(\mathop{\mathrm{tr}}S^4)^2-y^2}{1-y}$ is decreasing in $y$ (Jäger (3.16)) | **nowhere on the record** | licenses substituting the *lower* bound $\varphi(v)^2$ for $y$ in step 3 | **step using a hypothesis never stated**, the sharpest instance |
| H10 | $\varphi(v)^2\in[\tfrac1n,\tfrac2n-\tfrac2{n^2}]$ across the swept range | **nowhere** | H9 is proved only on that interval | **unstated side condition** |
| H11 | $\mathrm{Ric}(\lvert W\rvert)\ne0$, so the normalisation is defined | **nowhere** | the definition of $S$ | unstated; **true**, see §9 |
| H12 | Result 5b replaces Jäger's §3.6 after Lemma 3.6.10 | [ATTEMPTS.md:629](../ATTEMPTS.md) | discharges H3's $m\ge8$ at $m=6,7$ | **unnumbered, unindexed, no Gate 2** |

**No hypothesis is stated and then unused.** I checked H5, H6, H7 and H4 individually and each carries weight. The failures are all in the other direction: H8, H9, H10, H11 are used and never stated.

## 2. The status contradiction, D is what the mathematics supports

**A** ([problem.md:450](../findings/problem.md)) says *"NEVER AUDITED, and OUT OF SCOPE"*, *"nothing in this project depends on Lemma L1"*, *"not worth reviewer time"*.
**C** ([INDEX.md:19](../findings/INDEX.md)) says the diagonal case is *proved outright at every $n\ge4$*, that $n=12,14$ are *closed by Lemma L1*, and that *"that proof lives only in [results.md](../results.md), not in [findings/](../findings/), and has no ledger row, so its Gate 2 status is unrecorded"*.
**D** ([INDEX.md:45](../findings/INDEX.md)) says *"audited, and conditional on Result 5b"*.

- **A's "NEVER AUDITED" is false against the record.** [LEDGER.md:424–450](../findings/LEDGER.md) carries a section headed *"L1, independent validation of r498, while r497 runs"*, and [INDEX-results.md:16](../findings/INDEX-results.md) carries the verdict *"Gate 2: the mathematics reproduces; three of the block's load-bearing sentences did not (r497, r498, identical briefs, both PLAUSIBLE)"*. A is stale text left in place after the audit it denies.
- **A's "not worth reviewer time" is refuted by the outcome of spending it**: the audit found a second dimension hypothesis the block denied existed, and a moment problem that was false as printed. The same sentence survives at [LEDGER.md:52](../findings/LEDGER.md) as *"Do not spend reviewers on it."*
- **C's status clause is false on both counts.** The proof block sits at [problem.md:468](../findings/problem.md), moved there on 2026-08-31, the block's own first line says so. And it has a ledger row ([LEDGER.md:52](../findings/LEDGER.md)) *and* an audit section *and* a recorded Gate 2 verdict. C also omits the Result 5b conditionality that both the block and D carry, so a reader taking C alone reads L1 as unconditional.
- **C contradicts itself inside one cell**: it opens *"Proved outright at every $n\ge4$, odd included"* and closes *"Odd $n$ open"*. The two clauses are about different things (the record's own theorem, and the published literature) and nothing in the cell says so.
- **A's conclusion survives even though A's reasoning does not.** A says nothing depends on L1 because the *grant* is what the project depends on; C says the grant is no longer load-bearing because [L57](../findings/problem.md) proves the diagonal case outright. Both routes end at "L1 is not a dependency", and §3 confirms that independently.

**Verdict: D.** *audited, and conditional on Result 5b* is the only one of the three that is true as written today.

## 3. Does anything depend on L1?

I searched for consumers rather than trusting any of the three rows: every `L1` occurrence in [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md), [plan-verification.md](../plan-verification.md) and [lean/INDEX.md](../lean/INDEX.md).

- **No proof consumes it.** [LEDGER.md:430](../findings/LEDGER.md) already records *"L1 cites no numbered result at all … it is a leaf over Jäger plus three scripts"*, and the converse holds too: no numbered result's proof cites L1. The apparent L18/L20 edges were a scanner artefact, explained at [LEDGER.md:433](../findings/LEDGER.md).
- **One live scope citation.** [diagonality.md:77](../findings/diagonality.md) reads *"Jäger's Theorem A is even $n\ge16$; [results.md](../results.md)'s Lemma L1 covers $n=12,14$; odd $n$ is untouched and route R6 inherits nothing there."* That sentence rests route R6's $n$-range on L1 at exactly the two dimensions the programme cares about, where [L57](../findings/problem.md) would carry it unconditionally and at both parities. It also points at [results.md](../results.md) for a block that lives in [problem.md](../findings/problem.md).
- **So the answer to the brief's question is: nothing on the record depends on L1 for a proof**, and one file states a range through it that L57 would serve better. A's conclusion stands; A's reason does not.

## 4. How many dimension constraints carry Theorem A, read at source

The block says **two**. I checked the count against the thesis directly, by enumerating every numeric dimension hypothesis in Chapter 3 of [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf).

**Constraint 1, the $n\ge15$ pair inside Lemma 3.5.6.** The lemma is stated at extraction line 4178 and its proof closes at 4398. Its two case branches end at 4341 (*"Thus, $g(n)<0$ for all $n\ge15$, which is a contradiction"*) and 4397 (*"Thus, $h(n)<0$ for all $n\ge15$, which is a contradiction"*). With $n$ even this is $n\ge16$, which is Theorem A's threshold.

**Constraint 2, Assumption 1's $m\ge8$, used genuinely in §3.6.** The literal string `m ≥ 8` occurs exactly three times in the extraction: line 1668 (Theorem 3.0.2's statement), line 1705 (Assumption 1), and line 5080, inside §3.6:

> "choose $l\in A_k$ with $l\notin\{a,b,c,d\}$ which is possible because $m\ge8$ and $\#A=m(m-1)$ by lemma 3.6.7"

That is the ideal-induction step. **So the count of two is right, and the block's identification of both is right.** The section-A framing that says otherwise is §5.

**Everything else in Chapter 3 has threshold $\le12$.** The numeric hypotheses I found are: $n\ge8$ at 3541 (from $n^2-10n+18\ge0$, i.e. $n\ge5+\sqrt7$), $n\ge9$ at 4113 and 4396, $n\ge6$ at 3386, $n\ge5$ at 4626 and 4851, $n\ge4$ at 4051, 4354 and 4835, $n\ge3$ at 2602, 3579, 4375 and 4657, $n\ge2$ at 2524, 4331, 4377 and 4670, $n\ge1$ at 4260, and $k\ge12$ in Lemma 3.5.4 at 3894. All are satisfied at $n=12$ and $n=14$.

**One of them is exactly tight and the block never says so.** Lemma 3.5.4 requires $k\ge12$; at its point of application (extraction 4100, *"By (3.12) and lemma 3.5.4, this can only be true if …"*) the bound variable is $k=n$, since the displayed inequality at 4088–4098 is Lemma 3.5.4's with $k\to n$ and $x=n\mathop{\mathrm{tr}}S^4-1$. So the entire $n=12$ repair sits on the boundary of a hypothesis of the source. It is satisfied, but had Jäger written $k\ge13$, L1's $n=12$ half would not exist, and the block records no margin at all here.

I also verified Jäger's (3.13), the side condition that puts $x$ in Lemma 3.5.4's range: $16n^2-2(8n+9)(n-1)=16n^2-(16n^2+2n-18)=-2n+18\le0$ ⟺ $n\ge9$. Exact, matches the printed line.

## 5. The census as it now stands, and the two refuted sentences that are still standing

The census itself is at [ATTEMPTS.md:799](../ATTEMPTS.md) and again in the header of [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py). Read as a *census* it is accurate: I reproduced every one of its counts against the thesis in §4, including the "three times" for $m\ge8$ and the "$k\ge12$ in Lemma 3.5.4, satisfied and exactly the dimension in question". **The census found the right thing.** What was wrong was the sentence reporting it, and the block says so.

**But both refuted sentences are still standing, verbatim, in the same file as the block that refutes them.**

- [problem.md:456](../findings/problem.md), sixteen lines above the block: *"**Every dimension constraint in Theorem A flows from Lemma 3.5.6**, which needs a single quantity negative and bounds it through a chain of rational roundings."*
- [problem.md:462](../findings/problem.md), ten lines above the block: *"**Scope.** A census of every dimension hypothesis in Jäger's Chapter 3 confirms nothing else binds above $n=12$."*

Against the block's own warning at [problem.md:474](../findings/problem.md): *"THE FIRST VERSION READ 'every dimension constraint flows from one lemma', AND THE CENSUS BELOW READ 'nothing else binds above $n=12$', BOTH FALSE."* The correction was written into the canonical block and never applied to the section that frames it. **A reader arriving at the section heading meets both false sentences first, and the block's phrase "the census below" now points at nothing, because the census sentence is above it rather than below.**

**And the same pair survives in the reference card**, which is where a consumer goes to read what the source says:

- [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md), under *"Where the dimension threshold actually comes from"*: *"Every dimension constraint in Theorem A flows from **one lemma**"* and *"A census of every dimension hypothesis in Chapter 3 confirms nothing else binds above $n=12$."*
- [references/jaeger-2016-diagonal-case/README.md](../references/jaeger-2016-diagonal-case/README.md), Verdict: *"This project closed $n=12,14$ by showing the threshold is rational rounding slack inside **one lemma**"*, stated flatly, with no mention of Result 5b or of the conditionality.

**Three files carry the refuted count; one file carries the correction.** This is the heaviest finding of the round.

## 6. The rounding-slack account, derived in full

The claim: $\mathop{\mathrm{tr}}S^4\le E(n)=\dfrac{8n^2-41n+49}{4(n+1)(n-2)(n-3)}$, rounded to $\dfrac{16}{8n+9}$, the cleared inequality being $41n-57\ge0$, costing $(41n-57)$ over a quartic, $0.000885$ at $n=12$.

**Where it is in the source.** Lemma 3.3.6, extraction lines 2485–2524. The lemma is *"Let assumptions 1 and 2 hold. Then $\mathop{\mathrm{tr}}S^4\le\frac{16}{8n+9}$"*, and its proof passes through $E(n)$ exactly as the record says.

**The derivation of $E(n)$, in full.** Jäger reaches

$$\mathop{\mathrm{tr}}S^4\le1-\frac{\tilde\theta_0(n)^2}{2}\left(1+\frac1{2(n-3)}\right)^2 .$$

With $\tilde\theta_0(n)^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ from [conventions.md](../findings/conventions.md), the first factor is $\frac{(n-1)(n-3)}{(n+1)(n-2)}$, and $1+\frac1{2(n-3)}=\frac{2n-5}{2(n-3)}$, so

$$\mathop{\mathrm{tr}}S^4\le1-\frac{(n-1)(n-3)}{(n+1)(n-2)}\cdot\frac{(2n-5)^2}{4(n-3)^2}=1-\frac{(n-1)(2n-5)^2}{4(n+1)(n-2)(n-3)} .$$

Now $4(n+1)(n-2)(n-3)=4n^3-16n^2+4n+24$ and $(n-1)(2n-5)^2=(n-1)(4n^2-20n+25)=4n^3-24n^2+45n-25$; subtracting,

$$4(n+1)(n-2)(n-3)-(n-1)(2n-5)^2=8n^2-41n+49 ,$$

which is $E(n)$'s numerator. **The formula is exactly right.**

**The clearing.** $(8n^2-41n+49)(8n+9)=64n^3-256n^2+23n+441$, and $16\cdot4(n+1)(n-2)(n-3)=64n^3-256n^2+64n+384$. The difference is

$$64\,(n+1)(n-2)(n-3)-(8n^2-41n+49)(8n+9)=41n-57 ,$$

so $E(n)\le\frac{16}{8n+9}$ ⟺ $41n-57\ge0$ **whenever both denominators are positive.** This is Jäger's own line 2522, written there as $-41n+57\le0$. **The record transcribes the source correctly.**

**The direction.** $E(n)\le16/(8n+9)$, so the replacement *weakens* the upper bound on $\mathop{\mathrm{tr}}S^4$, the rounding loses, which is what "rounding slack" must mean for the repair to consist of undoing it. **Direction correct.**

**The cost.**

$$\frac{16}{8n+9}-E(n)=\frac{41n-57}{4(n+1)(n-2)(n-3)(8n+9)} ,$$

linear over a quartic, matching *"costing $(41n-57)$ over a quartic"*. At $n=12$: numerator $492-57=435$; denominator $4\cdot13\cdot10\cdot9\cdot105=491400$; and $435/491400=0.00088522\ldots$ **The figure $0.000885$ is right.**

**An independent corroboration I did not expect.** $E(12)=\frac{1152-492+49}{4680}=\frac{709}{4680}$. That rational is the hard-coded upper limit `VHI` of the interval script, so the sweep's upper endpoint *is* Jäger's unrounded bound, which is precisely what *"keep Lemma 3.3.6 in the exact form he derives, before he rounds it"* has to mean. The record never says this, and the two ends meet exactly.

**The one place the account is imprecise (claim 7).** *"valid at every $n\ge2$"* is true of the polynomial $41n-57\ge0$ (which holds from $n\ge57/41=1.3902$) but not of the rational inequality it clears: at $n=2$ and $n=3$ the denominator $4(n+1)(n-2)(n-3)$ vanishes and $E(n)$ does not exist, and on $2<n<3$ it is negative, which would assert $\mathop{\mathrm{tr}}S^4<0$. The honest range for the rounding is $n\ge4$. This is inherited verbatim from Jäger's *"for all $n\ge2$"* at line 2524 and is harmless, Assumption 1 forces $n\ge16$ at that point in his text, and $\dim\mathcal W_n=0$ for $n\le3$ here, but the block, [lean/INDEX.md:247](../lean/INDEX.md) and [JaegerRounding.lean](../lean/HamiltonsCubic/Results/JaegerRounding.lean) all repeat *"holds from $n=2$ on"* as though it were a fact about the rounding. **Recorded as imprecision, not as a defect.**

**Not checkable from the record.** *"about a sixty-fourth of Step 2's residual there"* rests on the residual $+0.05627$ at $n=12$ and $-0.01741$ at $n=14$, which [lean/INDEX.md:247](../lean/INDEX.md) itself lists as **owed** (*"the feasible-region evaluation behind $\pm0.05627$ and $-0.01741$"*). I did not evaluate it and record it as unverified.

## 7. The $n=12$ moment-body step, and the corner

### 7.1 What the source actually does, located

The corner is at extraction line 4239 and the display beneath it. Jäger writes

$$\tfrac1n\le(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4\le\tfrac{16}{8n+9}\le\tfrac2n-\tfrac2{n^2},$$

then introduces $f(y)=\frac{(\mathop{\mathrm{tr}}S^4)^2-y^2}{1-y}$ on $y\in[\frac1n,\frac2n-\frac2{n^2}]$ with $y=(\mathop{\mathrm{tr}}S^3)^2$, proves $f'\le0$ via (3.16), and concludes

$$\sqrt{\frac{(\mathop{\mathrm{tr}}S^4)^2-(\mathop{\mathrm{tr}}S^3)^4}{1-(\mathop{\mathrm{tr}}S^3)^2}}\le\sqrt{\frac{\frac4{n^2}-\frac1{n^2}}{1-\frac1n}}=\sqrt{\frac3{n(n-1)}}\le\frac{\sqrt3}{n-1}.$$

**That last step is the corner.** He evaluates at $y=\frac1n$ (the *floor* of $(\mathop{\mathrm{tr}}S^3)^2$) while simultaneously replacing $\mathop{\mathrm{tr}}S^4$ in the numerator by its *ceiling* $\frac2n$. Two independent substitutions of two extremes of one spectrum. **The record's description of the step is exactly right, and I locate it here.**

### 7.2 The corner really is empty, confirmed

With $S\succeq0$, $\mathop{\mathrm{tr}}S^2=1$ and at most $n$ nonzero eigenvalues:

- $(\sum\lambda_i^2)^2\le r\sum\lambda_i^4$ with $r=\mathop{\mathrm{rank}}S\le n$ gives $\mathop{\mathrm{tr}}S^4\ge\frac1n$, equality iff the nonzero spectrum is flat **and** $r=n$;
- $(\sum\lambda_i^2)^2=(\sum\lambda_i^{1/2}\lambda_i^{3/2})^2\le(\sum\lambda_i)(\sum\lambda_i^3)$ (this needs $\lambda_i\ge0$ to take the roots at all), gives $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$, and with $\mathop{\mathrm{tr}}S\le\sqrt n$ (H8) gives $\mathop{\mathrm{tr}}S^3\ge n^{-1/2}$, i.e. $y\ge\frac1n$, equality iff flat;
- at the flat spectrum $\lambda_i=n^{-1/2}$ one has $\mathop{\mathrm{tr}}S^3=n^{-1/2}$ and $\mathop{\mathrm{tr}}S^4=\frac1n$, **both at their floors together.**

So $y=\frac1n$ forces $\mathop{\mathrm{tr}}S^4=\frac1n$, never $\frac2n$. **"The floor forces the flat spectrum, which drags the ceiling down with it" is correct**, and it is the mechanism the script's own docstring states.

### 7.3 But the block names the wrong edge, REFUTED

[problem.md:476](../findings/problem.md): *"**The edge itself is $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$**, with $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ beside it; a box bounding the two traces separately admits $(\tfrac12,\tfrac15)$, which the edge excludes."* [L1.lean](../lean/HamiltonsCubic/Results/L1.lean)'s docstring is sharper still: *"**the first** is precisely the corner elimination the record describes in words."*

**Locate.** [problem.md:476](../findings/problem.md); [lean/INDEX.md:202](../lean/INDEX.md); [L1.lean](../lean/HamiltonsCubic/Results/L1.lean) header.

**Exhibit, in closed form.** Take the point $(\mathop{\mathrm{tr}}S^3,\mathop{\mathrm{tr}}S^4)=\left(\tfrac1{\sqrt{12}},\ \tfrac{709}{4680}\right)$ at $n=12$, the corner Jäger's estimate actually visits, with $\mathop{\mathrm{tr}}S^4$ at Jäger's own exact ceiling $E(12)$.

- Against the named edge: $(\mathop{\mathrm{tr}}S^3)^2=\tfrac1{12}=\tfrac{390}{4680}\le\tfrac{709}{4680}=\mathop{\mathrm{tr}}S^4$. **The edge is satisfied. It does not exclude the corner.**
- Against the other one: $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ needs $\mathop{\mathrm{tr}}S\ge\sqrt{12}$, while $\mathop{\mathrm{tr}}S\le\sqrt{12}$ always holds; so $\mathop{\mathrm{tr}}S=\sqrt{12}$ exactly, which forces the flat spectrum, which forces $\mathop{\mathrm{tr}}S^4=\tfrac1{12}\ne\tfrac{709}{4680}$. **This edge, and only this one, excludes the corner.**

And the illustrative point the block offers, $(\tfrac12,\tfrac15)$, violates $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ in the *opposite* direction ($\tfrac14>\tfrac15$): it has $\mathop{\mathrm{tr}}S^3$ far above its floor, which is a region the argument never visits.

**Argue the opposite, three ways, all failing.**
1. *Perhaps "the edge" loosely names the pair.* The sentence names one *"the edge itself"* and the other *"beside it"*, and [L1.lean](../lean/HamiltonsCubic/Results/L1.lean) says *"the first"*. Every reading makes the first primary, and the first is the one that does no work here.
2. *Perhaps $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ is the record's contribution regardless.* It is not: **Jäger prints it at extraction line 4239** and uses it to fix the domain of $y$. So *"Jäger bounds $\mathop{\mathrm{tr}}S^3$ and $\mathop{\mathrm{tr}}S^4$ separately"* is false if read as "he lacks the joint inequality"; it is true only if read as "he substitutes extremes of each independently inside one expression", which is the reading §7.1 confirms. The block does not say which it means, and [lean/INDEX.md:202](../lean/INDEX.md)'s *"neither is available to a box that bounds the two traces separately"* commits to the false reading for both edges.
3. *Perhaps the equality case is what is meant.* Both edges have the flat spectrum as their equality case, so an equality-case reading does not distinguish them, but the one that *starts* from $y=\frac1n$ and *derives* flatness is the second, since the first bounds $\mathop{\mathrm{tr}}S^4$ from below and cannot drag it down from a ceiling. **The arrow of the first edge points the wrong way.**

**All three legs clear. Recorded as a defect.** It is a defect in the block's account of its own new step, not in the closure: the quantitative work is done by the certified line $\varphi$, which is neither edge.

### 7.4 What actually does the work

The line $\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}\le\mathop{\mathrm{tr}}S^3$ is *increasing* in $v=\mathop{\mathrm{tr}}S^4$, that is the whole point, and it is the property neither Cauchy–Schwarz edge has. At the ceiling $v=\tfrac16$ it returns $\varphi=\tfrac7{60}+\tfrac{8647}{38000}=\tfrac{39241}{114000}$, whose square is $\tfrac{1539855081}{12996000000}$ against the floor $\tfrac1{12}=\tfrac{1083000000}{12996000000}$, larger by a factor of about $1.42$. **That** is "the ceiling of $\mathop{\mathrm{tr}}S^4$ drags $\mathop{\mathrm{tr}}S^3$ off its floor", and it is a genuinely new inequality. The block's prose describes the qualitative mechanism through the wrong object and never says that $\varphi$ is the operative statement.

I also checked [lean/INDEX.md:202](../lean/INDEX.md)'s two numerical claims exactly. $\varphi(1)=\tfrac7{10}+\tfrac{8647}{38000}=\tfrac{26600+8647}{38000}=\tfrac{35247}{38000}$ ✓, and the gap to $-1$ is $\tfrac{73247}{38000}>1$ ✓. The straddle: $\varphi(1/12)=\tfrac{32591}{114000}$ with $32591^2=1062173281<1083000000=\tfrac1{12}\cdot114000^2$, so **below** $1/\sqrt{12}$; $\varphi(1/10)=\tfrac{11307}{38000}$ with $11307^2=127848249>120333333.\overline3=\tfrac1{12}\cdot38000^2$, so **above**. ✓ Both confirmed by exact integer comparison, no radicals.

## 8. The duality step

**Claim.** *"Weak duality alone licenses it, so no constraint qualification is owed and the convexity appealed to here is surplus."*

**Weak duality suffices, CONFIRMED.** For multipliers $\alpha\in\mathbb R$ on $\mathbb E[\lambda^2]=v$ and $\beta\ge0$ on $\mathbb E[\lambda^{-2}]\le n$, every feasible $\mu$ satisfies

$$\mathbb E[\lambda]=\mathbb E\!\left[\lambda-\alpha\lambda^2+\beta\lambda^{-2}\right]+\alpha v-\beta\,\mathbb E[\lambda^{-2}]\ \ge\ \min_{\lambda\in(0,1]}\!\left(\lambda-\alpha\lambda^2+\beta\lambda^{-2}\right)+\alpha v-\beta n ,$$

the last step using $\beta\ge0$ with $\mathbb E[\lambda^{-2}]\le n$. This is affine in $v$ with slope $\alpha$, and it is a **lower** bound, which is the only direction the argument consumes. Weak duality is exactly the inequality just displayed; no strong duality, no Slater condition, no constraint qualification enters. **The record is right, and right for the right reason.**

**The convexity is genuinely surplus, CONFIRMED, with a caveat about a second convexity.** The convexity of $F$ (as the value function of a linear programme over measures with a linear right-hand side) would be needed only to claim the dual bound is *tight*. Nothing downstream needs tightness: step 3 substitutes $\varphi(v)$ for $\mathop{\mathrm{tr}}S^3$ and needs only $\varphi\le F$. **But the block's other convexity appeal (Jäger's $\mathrm{RHS}''\ge0$), is not surplus at all**, and the block says so correctly in a different sentence. Two convexities, one surplus and one load-bearing, are discussed eight lines apart under the same word.

**One wording correction.** What weak duality returns is a **minorant**, not a *supporting line*: a supporting line touches. Section A calls it *"a supporting line valid at every value at once"* and the block repeats *"supporting line"*. Nothing breaks (the argument uses only $\varphi\le F$) but the word claims tightness that the licence does not provide, and tightness is exactly what strong duality would have been needed for. **The word should be "minorant" or "certified lower line".**

**What is not on the record.** The multiplier $\beta$, the Lagrangian, the quartic, and the root isolation are all absent; only `run_jaeger_e5_certificate.py` is cited, and [lean/INDEX.md:202](../lean/INDEX.md) lists *"the dual construction"* among what is **owed**. So the constant $\tfrac{8647}{38000}$ is asserted on the record with no argument attached. **SCREEN (non-evidential, and reported as a screen only because I was about to record a claim about it):** with $\alpha=\tfrac7{10}$ the best achievable constant $\max_{\beta\ge0}\left[\min_{(0,1]}(\lambda-\tfrac7{10}\lambda^2+\beta\lambda^{-2})-12\beta\right]$ appears to sit near $0.2298$, above the claimed $0.22755$, with the minimum contested between an interior point near $\lambda\approx0.27$ and the endpoint $\lambda=1$. That is consistent with $\varphi$ being a valid but slightly slack dual line. **This screen is not a check and I do not rest any verdict on it.**

## 9. The two load-bearing hypotheses

**Both stated, both load-bearing, CONFIRMED, and one of them more sharply than the record says.**

$S=\mathrm{Ric}(\lvert W\rvert)/\lVert\mathrm{Ric}(\lvert W\rvert)\rVert$ is Jäger's own $S$, defined at extraction line 1760 as $S:=\mathrm{Ric}/r$ with $\mathrm{Ric}=\mathrm{Ric}(\lvert W\rvert)$, $r=\lVert\mathrm{Ric}\rVert$. **The record's transcription is verbatim correct.**

- **$S\succeq0$**: $\lvert W\rvert=W_++W_-\succeq0$ (Notation 3.0.3), and $\mathrm{Ric}$ maps the PSD cone into itself. On the diagonal locus this is visible: $\mathrm{Ric}(\lvert W\rvert)=\mathop{\mathrm{diag}}\!\left(\sum_j\lvert w_{ij}\rvert\right)$, manifestly PSD.
- **Unit norm**: by [conventions.md](../findings/conventions.md), $\lVert\mathrm{Ric}\rVert$ is Frobenius, so $\mathop{\mathrm{tr}}S^2=1$, hence $\lambda_i^2\le\sum_j\lambda_j^2=1$ and the spectrum lies in $[0,1]$. Together with PSD this is the support constraint $(0,1]$ on the atoms of positive mass.
- **The measure is a probability measure** exactly because $\sum\lambda_i^2=\mathop{\mathrm{tr}}S^2=1$; and $\mathbb E[\lambda^{-2}]=\#\{i:\lambda_i\ne0\}=\mathop{\mathrm{rank}}S\le n$, so the third constraint is the rank bound. **The record states the constraint and never says it is the rank**, which is the one line that would make it self-evidently true.
- **$r>0$, so $S$ is defined** (H11): $\mathop{\mathrm{tr}}\mathrm{Ric}(\lvert W\rvert)=\mathop{\mathrm{scal}}(\lvert W\rvert)>0$ for $W\ne0$. Unstated everywhere; true.

**The support cap does not merely weaken the problem, without it the dual does not exist.** The record's blockquote argues that an atom at large $\lambda$ pins the value near $1/\sqrt{12}$. The stronger and shorter statement: on $(0,\infty)$, $\min_\lambda(\lambda-\tfrac7{10}\lambda^2+\beta\lambda^{-2})=-\infty$ for every $\beta$, because $-\tfrac7{10}\lambda^2$ dominates. **So without $\lambda\le1$ there is no dual line of any slope, not just a wrong one.** The record's own witness $\delta_{-1}$ (feasible without $S\succeq0$, giving $\mathbb E[\lambda]=-1$ against $\varphi(1)=\tfrac{35247}{38000}$) is correct and I confirmed its arithmetic in §7.4.

## 10. The interval-arithmetic step, what a validated-interval discharge establishes

**I did not run [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py). I read it.** The question the brief poses is not whether the run is right.

**What it would establish.** A finite list of subintervals covering $[10/81,\ 709/4680]$, each carrying a machine-verified enclosure whose upper end is negative, is a *certificate*: a third party can re-check each box independently, and the method is proof-grade in kind. [LEDGER.md:450](../findings/LEDGER.md) is right that this is no reason to demote.

**What it assumes, none of it stated on the record.**
1. **The reduction to one dimension.** The script evaluates `RHS(v, phi(v)^2)` with `coeff = (2*sqrt(2)/TH0)*sqrt(1-v)` standing in for $\lVert\mathrm{Ric}\wedge\mathrm{Ric}\rVert$. That reduction from Jäger's (3.14) is nowhere on the record; [lean/INDEX.md:202](../lean/INDEX.md) lists *"the reduction to Jäger's expression"* as **owed**. **Everything else is downstream of an unproved reduction.**
2. **A monotonicity that licenses the substitution (H9).** Substituting the *lower* bound $\varphi(v)^2$ for $y=(\mathop{\mathrm{tr}}S^3)^2$ gives an upper bound on RHS only because $f(y)$ is *decreasing* in $y$, Jäger's (3.16). Without that, the substitution is a guess in an unknown direction. **The record never states it.** I checked it holds: (3.16) is proved for all $n\ge1$ via $\tilde f(n)=-n^3+4n^2-8n+4$ with $\tilde f(1)=-1$ and $\tilde f'<0$.
3. **A side condition on the range (H10).** (3.16) is proved on $y\in[\frac1n,\frac2n-\frac2{n^2}]=[0.08333,0.15278]$ at $n=12$. Across the swept range $\varphi(v)^2$ runs over roughly $[0.0986,0.1113]$, inside it. **Nowhere stated.**
4. **The two "cases" are the endpoints of the $t$-interval**, which is legitimate only under Jäger's $\mathrm{RHS}''\ge0$ (§11), and the script's lower endpoint `TH0/v` is the *unrounded* form of Corollary 3.3.7's $\frac{8n+9}{16}\hat\theta_0(n)$. Shrinking a convex function's domain preserves the endpoint principle, so this is sound, but it is the second undone rounding, and the block never names it.
5. **`VLO = 10/81`** is exactly where $\hat\theta_0/v\le(n-3)\tilde\theta_0$ becomes solvable: $v\ge\frac{n-2}{(n-3)^2}=\frac{10}{81}$ at $n=12$. I derived this by hand and it matches the docstring's stated reason. ✓
6. **The toolchain.** `mpmath`'s `iv` type, its rounding directions, `iv.dps = 40`, and the transcription of RHS into Python are all trusted. This is the ordinary cost of a validated computation and is acceptable *if declared*. It is not declared.

**What the record may stand a proof on.** A validated-interval discharge is admissible as a proof step when the certificate is carried, so that a reader can re-verify the boxes without the original program. **The record carries no certificate** (no subdivision, no bounds, no output), only the sentence *"ten subintervals, each with a proven negative bound"*. And "ten" is an artefact of an adaptive recursion (`maxdepth=60`), so it would change with the precision setting; it is a run log, not a mathematical fact. **This step is a GAP on the record even though the method is sound.**

**Claim 14, *"So both dimensions are machine-checked rather than swept."*** The interval script is hard-coded `N = 12`; $n=14$ rests on step 1's exact evaluation alone. [REVIEW_r498.md:122](../reviews/REVIEW_r498.md) already recommended marking *"the $n=14$ half … as evaluated at Jäger's corner pending the E5a run at $N=14$"*. The sentence is defensible if "machine-checked" is read to cover the symbolic evaluation at $n=14$, but as printed it invites the reading that both went through interval arithmetic. **Overstated.**

## 11. The convexity licence, confirmed verbatim and derived

The block's most specific claim about the source is *"the endpoint evaluation is licensed by the source's own convexity, $\mathrm{RHS}''\ge0$, rather than by anything this record adds, and the licence survives at $n=12,14$."* At extraction lines 4213–4232 Jäger writes

> "The second derivative $\mathrm{RHS}''(t)=-\frac{263}{72}\frac{n-3}{n^2(n-2)}\left(1-\frac{3t}{n\hat\theta_0(n)}\right)$ is nonnegative since $\frac{3t}{n\hat\theta_0(n)}\ge3\frac{8n+9}{16n}\ge1$ … Thus, RHS is convex, and hence, it attains its maximum on the boundary."

**Verbatim as the block says.** And the licence survives everywhere: $3\frac{8n+9}{16n}\ge1$ ⟺ $24n+27\ge16n$ ⟺ $8n+27\ge0$, true at every $n\ge0$, so a fortiori at $n=12$ and $n=14$. **CONFIRMED by derivation, not by citation.**

## 12. Result 5b, what it is, where it is, what L1 loses without it

**It is at [ATTEMPTS.md:629](../ATTEMPTS.md)**, as part (b) of an unnumbered "Result 5", and reads:

> "Jäger's §3.6 endgame (~5 pages of symmetric-space classification and ideal induction) is replaceable by a six-line graph argument, his Lemma 3.6.10's two vanishing traces say exactly that the positive-entry graph $G$ is a disjoint union of cliques and $\bar G$ is triangle-free, forcing two blocks, with the degree count forcing them equal. Verified by exhaustive brute force over all graphs at $n=4,5,6$: exactly $2^{n-1}$ graphs satisfy both trace conditions … the route still consumes Lemmas 3.6.7–3.6.8, so it replaces §3.6 *after* Lemma 3.6.10 rather than the whole section."

**Its status.** Unnumbered, absent from [INDEX-results.md](../findings/INDEX-results.md), no Gate 2 verdict, and its recorded warrant is a brute-force check at $n=4,5,6$, three dimensions, none of them $12$ or $14$. **The block's description of its status is accurate.**

**What L1 loses without it.** Assumption 1's $m\ge8$ binds at extraction line 5080, inside §3.6, and $n=12,14$ mean $m=6,7$. Without a replacement for that step, Theorem A's conclusion is unavailable at $m=6,7$ **however sharp the §3.5 estimates become**, steps 1–3 all live in §§3.3–3.5 and reach only as far as contradicting Assumption 2. So L1 loses its conclusion entirely, not a constant. **The conditionality is real and correctly stated.**

**But its *necessity* is asserted, not established, a second, smaller finding.** The step at line 5080 needs only to *"choose $l\in A_k$ with $l\notin\{a,b,c,d\}$"*, where $a\ne c$ and $a\ne d$ are already assumed, so $\{a,b,c,d\}$ has at most four elements. If $\lvert A_k\rvert=m$, as the surrounding text suggests, the choice is possible for every $m\ge5$, and $m\ge8$ is not tight there. **I do not supply the argument**, whether $\lvert A_k\rvert=m$, and whether $m\ge8$ is consumed elsewhere in §3.6 through Lemmas 3.6.7, 3.6.8 or 3.6.13, is not settled by the passage I can read. What I record is that the block calls this use *"genuine"*, which is a claim that it binds, and the printed justification does not establish that it binds at $m=6,7$. **If it does not bind, L1's conditionality on Result 5b is over-caution and could be discharged directly; if it does, Result 5b needs a number and a Gate 2.** Either way the record currently states as established something it has not shown.

## 13. The traps, each answered by name

**$\ker W\ne0$ and padded objects.** Answered, and the trap is real but benign here. $\mathrm{Ric}(\lvert W\rvert)=\mathop{\mathrm{diag}}(\sum_j\lvert w_{ij}\rvert)$ has a zero eigenvalue exactly when a row of $W$ vanishes, which is precisely what padding produces, a $W$ padded from $\mathbb R^{n_0}$ into $\mathbb R^n$ gives $\mathop{\mathrm{rank}}S=n_0<n$. The constraint $\mathbb E[\lambda^{-2}]=\mathop{\mathrm{rank}}S\le n$ is then slack, so padding **relaxes** the binding constraint and the bound computed with $n$ remains valid. The floor $\mathop{\mathrm{tr}}S^4\ge1/\mathop{\mathrm{rank}}S$ *rises*, which also helps. **The trap does not bite, and the reason is nowhere on the record.**

**The boundary of every stated range.**
- **$n=12$**, the tightest point in the whole result. Lemma 3.5.4's hypothesis $k\ge12$ is satisfied *with equality* (§4); the crossover below makes $n=12$ the first even dimension where the hypothesis $\theta\ge\theta_0(n)$ excludes the competitor; and it is the only dimension needing the moment body. Three boundaries at one dimension, none of them flagged in the block.
- **$n=14$**, reached by step 1 alone; **not covered by the interval script** (§10, claim 14).
- **$n=16$**, Theorem A's threshold, confirmed verbatim at extraction line 113 and as $m\ge8,\ n=2m$ at 1668. It is $n\ge15$ (Lemma 3.5.6) plus evenness, exactly as the record says.
- **Odd $n$**, *"untouched"*, and correctly so. Assumption 1 is *"Let $m\ge8$ be an integer, and let $n=2m$"*, so evenness is a standing hypothesis of the whole chapter and the repair does not even parse at odd $n$. Jäger's own remark at 1697 notes §§3.2–3.5 run under $\tilde\theta_0$ and would cover both parities, with only the endgame needing $\theta_0$ and $n=2m$, so the *sharpenings* are parity-blind while the *closure* is not. The record's [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py) docstring states this correctly; the L1 block states only *"Odd $n$ is untouched"* and never mentions the evenness clause of Assumption 1. **No overreach found.**
- **The crossover $n=6+2\sqrt7=11.2915\ldots$**, it plays no role inside L1's argument, but it is why $n=12$ is where the question starts: $\theta_0(n)>\sqrt{3/2}$ exactly for $n>6+2\sqrt7$, so at $n=12$ the padded competitor's $\theta=\sqrt{3/2}=1.224745$ falls just below $\theta_0(12)=1.236033$ and stops being a counterexample to Theorem A's hypothesis. The margin is $0.0113$. **Checked; nothing broken; the block does not mention it.**

**A claim proven on a subfamily and used in general.** Looked for; **not found**. The sharpenings are proved for the same objects Jäger's lemmas are stated for, and the closure is claimed only at even $n=12,14$.

**A hypothesis stated but never used.** Looked for across H1–H12; **not found**. Every stated hypothesis carries weight.

**A step using a hypothesis never stated.** **Found, four times**: H8 ($\mathop{\mathrm{tr}}S\le\sqrt n$), H9 (the monotonicity in $y$, the sharpest, since without it step 3's substitution has no justified direction), H10 (the range condition for H9), H11 ($r>0$). See §1.

**A universal claim with no witness.** **Found**: *"A census of every dimension hypothesis in Jäger's Chapter 3 confirms nothing else binds above $n=12$"*, the very sentence the block declares false, still standing at [problem.md:462](../findings/problem.md) and twice in the reference folder (§5).

**An imported theorem whose hypotheses were never checked against the object.** Read at source, as instructed. Theorem A's hypotheses are $W\in\langle W\rangle_d$, $\lVert W\rVert=1$, $W^2+W^\#=\theta W$, $\theta\ge\theta_0(n)$, $n=2m$, $m\ge8$. **The L1 block states none of them.** It names $m\ge8$ only as the thing to be removed. A reader of [problem.md:468–483](../findings/problem.md) alone cannot tell that Theorem A assumes criticality, or diagonality, or $\theta\ge\theta_0(n)$, and $\theta\ge\theta_0(n)$ is exactly the hypothesis the crossover makes delicate at $n=12$. **Recorded as hypothesis debt on the import.**

**Symbol collisions from [conventions.md](../findings/conventions.md).** All four named symbols are live, and none of L1's senses is tabled.
- **$S$, the dangerous one.** [conventions.md](../findings/conventions.md) already carries $S_{XYZ}$, $S(W)$ (the gradedness slack, itself flagged as *"vacuous when $\ker W\ne0$"*, which collides with this section's own kernel trap), and $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf1=0\}$. **L1's $S$ is a fourth object, and it is incompatible with the third**: $\mathcal D_n$'s $S$ is hollow with zero row sums, so $\mathop{\mathrm{tr}}S=0$ and it is never PSD unless zero, whereas L1's $S$ is PSD with $\mathop{\mathrm{tr}}S^2=1$. A reader resolving $\mathop{\mathrm{tr}}S^3$, $\mathop{\mathrm{tr}}S^4$ against $\mathcal D_n$'s vertex matrix gets a different object with different signs. **Untabled and consequential.**
- **$E(n)$**, collides with the eigenspaces $E_{\max}$, $E_{\min}$ and, worse, with Jäger's own $E\in S^2_{B,d}(\mathfrak{so}(n))$ of Notation 3.0.3, defined at extraction line 1748 with $e=\lVert E\rVert$. **The collision is inside the one source L1 quotes.** Untabled.
- **$F$**, collides with $F_u(h)$, $F_\lambda$ and the cone threshold $F=\frac4{n-2+4a}$. Untabled.
- **$\lambda$**, the table already flags three senses plus $\lambda_{\max}$'s three; L1's is an eigenvalue of $S$ and the integration variable. Untabled.
- **$\mu$**, which the brief does not name but which the table flags as carrying three senses: **L1's $\mu=\sum\lambda_i^2\delta_{\lambda_i}$ is a fourth, and it is a measure rather than a spectrum or a scalar.** Untabled.

## 14. What would falsify it, and what I did to look

**The object.** A diagonal Weyl operator $W$ on $\mathbb R^{12}$ or $\mathbb R^{14}$ (hollow symmetric $(w_{ij})$ with vanishing row sums, in Jäger's own coordinates), with $\lVert W\rVert=1$ and $W^2+W^\#=\theta W$ for some $\theta\ge\theta_0(n)$, that is **not** the normalised Weyl curvature of $S^{n/2}\times S^{n/2}$.

**The nearest thing to it, and why it is not one.** The padded competitors are the only catalogued objects reaching into this range, and they fail the hypothesis rather than the conclusion: at $n=12$, $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}=1.224745<1.236033=\theta_0(12)$, a margin of $0.0113$ that exists only because $12>6+2\sqrt7$. They are also not diagonal, so they are outside $\langle W\rangle_d$ twice over.

**The internal falsifier, and I closed it in closed form.** A spectrum of $S$ realising the corner Jäger's estimate visits ($(\mathop{\mathrm{tr}}S^3)^2=\tfrac1{12}$ together with $\mathop{\mathrm{tr}}S^4=\tfrac{709}{4680}$), would make the moment-body step false and put the $n=12$ closure back where Jäger left it. **No such spectrum exists**: $(\mathop{\mathrm{tr}}S^3)^2=\tfrac1{12}$ forces equality in $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ with $\mathop{\mathrm{tr}}S=\sqrt{12}$, hence the flat spectrum, hence $\mathop{\mathrm{tr}}S^4=\tfrac1{12}\ne\tfrac{709}{4680}$ (§7.2, §7.3). This is exact and needs no computation.

**How I looked.** I read Theorem A, Assumption 1, Notation 3.0.3, Lemma 3.3.6, Corollary 3.3.7, Lemma 3.5.4, Lemma 3.5.6 and the §3.6 ideal induction at source; enumerated every `n ≥ k` and every `m ≥ 8` in the extraction; swept the record for consumers of L1; and read the three scripts and two Lean files without executing any of them. **What I could not look for, because it would need computation the round forbids: whether the certified line $\varphi$ is genuinely a minorant of $F$, and whether the ten interval boxes cover and close.** Those are §8 and §10's gaps, and they are named as gaps rather than assumed away.

## Verdict

**GAP.**

Everything L1 says *about the thesis* survives a cold read at source: the two dimension constraints, the census counts, the algebra of $E(n)$ and its clearing, the convexity licence, the definition of $S$, the corner Jäger's estimate visits, and the emptiness of that corner. Several of these I re-derived from scratch and they came out exactly, including $E(12)=709/4680$ meeting the interval script's upper limit independently.

**What is missing is the proof of the three steps that do the closing.** Named precisely, this is what would have to be proved for L1 to become `PROVEN`:

1. **The reduction of Jäger's (3.14) to the one-dimensional $\mathrm{RHS}(v,\varphi(v)^2)$**, including the replacement of $\lVert\mathrm{Ric}\wedge\mathrm{Ric}\rVert$ by $\sqrt2\sqrt{1-v}$. Nothing on the record; [lean/INDEX.md:202](../lean/INDEX.md) already books it as owed.
2. **The dual construction behind $\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}$**, the multiplier $\beta$, the Lagrangian, the quartic and its root isolation. Nothing on the record.
3. **The interval certificate**, the subdivision of $[10/81,\,709/4680]$ and the negative upper bound on each box, carried on the record rather than regenerable only by rerunning a script; plus the two unstated conditions H9 and H10 that license the substitution being enclosed.
4. **Result 5b**, numbered, indexed and through Gate 2, *or* a demonstration that Jäger's line-5080 use of $m\ge8$ does not bind at $m=6,7$, which would remove the need for it.

**And one correction is owed to a sentence that is currently wrong**, §7.3: *"The edge itself is $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$"* names an inequality that Jäger already prints and that admits the corner in question; the corner is excluded by $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ together with $\mathop{\mathrm{tr}}S\le\sqrt n$. The same misattribution is in [lean/INDEX.md:202](../lean/INDEX.md) and in [L1.lean](../lean/HamiltonsCubic/Results/L1.lean)'s header.

**Three further repairs, in descending order of weight.**

- **[problem.md:456](../findings/problem.md) and [problem.md:462](../findings/problem.md) still carry both sentences the block declares false**, and [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md) and [README.md](../references/jaeger-2016-diagonal-case/README.md) carry them again. The correction reached the block and nothing else.
- **The status rows.** [problem.md:450](../findings/problem.md)'s *"NEVER AUDITED"* and [LEDGER.md:52](../findings/LEDGER.md)'s *"Do not spend reviewers on it"* are stale; [INDEX.md:19](../findings/INDEX.md)'s claim that the proof lives only in [results.md](../results.md) with no ledger row is false and its cell contradicts itself on odd $n$.
- **The count of sharpenings.** The block names three of the four that [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py) records, omitting the one, keeping Lemma 3.5.5's coefficient $C=(2\sqrt2/\hat\theta_0)\sqrt{1-v}$ before it is rounded up to $2$, that carries $n\ge13$. Without it the moment body would have to cover $14\to12$ rather than $13\to12$, so the omission understates what the new step is standing on.
