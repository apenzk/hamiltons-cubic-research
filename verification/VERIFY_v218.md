# VERIFY_v218, Lemma L1, the granted diagonal case repaired at $n=12,14$

Cold read of [BRIEF_L01.md](BRIEF_L01.md), sections A–D, against [problem.md](../findings/problem.md), [findings/INDEX.md](../findings/INDEX.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/LEDGER.md](../findings/LEDGER.md), [results.md](../results.md), [ATTEMPTS.md](../ATTEMPTS.md), [04-granted-hypothesis.tex](../report/sections/04-granted-hypothesis.tex), the two Lean files, the three scripts read as text, and Jäger's thesis at source ([diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf)). **No numerical work was done.** No script was run, [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py) in particular was read and not executed, no Sage, no Python, no sweep. Six screens are reported below as screens: seconds of arithmetic on objects built to test a sentence I was about to write down, never offered as evidence for a positive claim. Log: [agent_logs/verify-L01-v218.log](../agent_logs/verify-L01-v218.log).

## Claim table

| # | claim under check | verdict |
| --- | --- | --- |
| 1 | The row's status: A *"never audited, out of scope, nothing depends on it"*, C *"proved outright at $n\ge4$; $n=12,14$ closed by L1; proof lives only in results.md"*, D *"audited, and conditional on Result 5b"* | **D IS RIGHT ON BOTH CLAUSES; A IS STALE ON "NEVER AUDITED" AND RIGHT ON "NOTHING DEPENDS"; C's LOCATION CLAUSE IS FALSE.** And the record states the status **five** ways, not three |
| 2 | *"Nothing in this project depends on Lemma L1"* | **CONFIRMED**, no numbered result cites it; searched, not taken on trust |
| 3 | **Two** dimension constraints carry Theorem A | **CONFIRMED AS A COUNT**, Lemma 3.5.6's quartics and Assumption 1's $m\ge8$ are the two that reach above $n=12$; every other numeric hypothesis in Chapter 3 clears at $n\le9$ |
| 4 | The census as it now stands | **REFUTED AS PRINTED, IN FOUR PLACES**, [problem.md:462](../findings/problem.md), [ATTEMPTS.md:799](../ATTEMPTS.md), [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py)'s docstring and [notes.md](../references/jaeger-2016-diagonal-case/notes.md) still carry the headline the block calls false |
| 5 | The rounding-slack account: $E(n)\le16/(8n+9)$ clears to $41n-57\ge0$ | **CONFIRMED, DIRECTION CORRECT, WITH ONE FALSE RANGE CLAUSE**, *"valid at every $n\ge2$"* fails at $n=5/2$ and is undefined at $n=2,3$; the Lean theorem correctly assumes $4\le n$ |
| 6 | The $n=12$ moment-body step: the box corner does not exist | **CONFIRMED**, both Cauchy–Schwarz inequalities and the equality case re-derived here |
| 7 | Its two hypotheses ($S\succeq0$, unit norm) are load-bearing | **CONFIRMED, AND BOTH ARE SATISFIED**, but *"unit norm"* is unqualified where the argument needs Frobenius, and the displayed $F(v)$ still omits the support constraint from its braces |
| 8 | *"Weak duality alone licenses it, so no constraint qualification is owed and the convexity appealed to here is surplus"* | **CONFIRMED**, the multiplier sign is the only thing the direction of use requires |
| 9 | The interval-arithmetic step | **HYPOTHESIS-DEBT**, a validated enclosure of a *transcribed* expression; the transcription, and the reduction to Jäger's Lemma 3.5.5, are owed on the record's own admission |
| 10 | Result 5b, what it is, and what L1 loses without it | **FOUND, at [ATTEMPTS.md:629](../ATTEMPTS.md); ITS STATED NECESSITY IS UNSUPPORTED**, Jäger's §3.6 step needs five indices, not sixteen, so it does not bind at $m=6,7$ |
| 11 | L1's headline (*"Jäger's Theorem A holds for even $n=12$ and $n=14$ as well"* | **GAP**), what is established is Lemma 3.5.6 at those $n$, plus a census whose discharge of Assumption 1 is not on the record |

**One line.** The mathematics L1 derives is sound where I could check it (the clearing, the moment body, the equality case and the duality all hold as written) but the statement L1 makes is a statement about Theorem A, and Theorem A's second dimension hypothesis is discharged on the record by a sentence about Jäger's §3.6 that the source does not support: **HYPOTHESIS-DEBT**.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

> $\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$* … the target of Problem P is $\Theta_n$.

> **The letter $M$ carries two objects, and their norms differ by $\sqrt2$.** $M$ (or $K$) is the $n\times n$ **sectional** matrix in [diagonal-half.md](../findings/diagonal-half.md), where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor; $W$ is the operator on $\Lambda^2$, where $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$.

> $\lambda_{\max}$ **CARRIES THREE SENSES INSIDE [results.md](../results.md), AT THE CLOSEST SIX LINES APART.**

**The four symbols the brief names are live, and none of them is tabled.** I grepped [conventions.md](../findings/conventions.md) for table rows under $S$, $E$, $F$ and $\lambda$: there is no row for any of them, while all four are in use in L1.

- **$S$.** In L1, $S=\mathop{\mathrm{Ric}}(\lvert W\rvert)/\lVert\mathop{\mathrm{Ric}}(\lvert W\rvert)\rVert$, an $n\times n$ symmetric matrix. Elsewhere on the record $S$ is [routes.md](../routes.md)'s compactness constant in *"isolated graded orbits $\Rightarrow$ ungraded part compact $\Rightarrow S\ge c>0$"*, and $S_{22}$ in [conventions.md](../findings/conventions.md)'s $g_k$ row is Hamilton's calculus. Three objects, one letter, no table row.
- **$E(n)$.** L1's $E(n)=(8n^2-41n+49)/(4(n+1)(n-2)(n-3))$ collides with [conventions.md](../findings/conventions.md)'s $E_{\max}$ (line 30) and with Jäger's own $e=\lVert E\rVert$ of his Notation 3.0.3, *the source object $E$ appears in the same chapter L1 is reading*, which is the collision most likely to mislead.
- **$F$.** L1's $F(v)=\min\{\mathbb E[\lambda]:\dots\}$ collides with [Lauret–Will's](../references/lauret-will-2006-einstein-solvmanifolds-moment-map/notes.md) $F(\mu)=16\mathop{\mathrm{tr}}R_\mu^2/\lVert\mu\rVert^4$ and with $F_u$, $F_\lambda$ in [conventions.md](../findings/conventions.md)'s competitor bullet.
- **$\lambda$.** In L1's moment problem $\lambda$ is an eigenvalue of $S$ and the integration variable; [conventions.md](../findings/conventions.md) records it as *"the Einstein constant against Petersen–Stanfield's block eigenvalues **inside one citation**"*, and $\lambda_{\max}$ carries three further senses.

**None of these collisions changes a truth value inside L1**, the block is self-contained enough that each letter is readable from its own sentence. They are recorded because the table exists precisely so a reader need not make that judgement.

## 1. Hypothesis inventory, every hypothesis L1's proof uses, where it is stated, and whether it is used

*A pass with no inventory is not a pass. This is the list.*

| # | hypothesis | stated where | used where | status |
| --- | --- | --- | --- | --- |
| H1 | $W\in\langle W\rangle_d$, coordinate-diagonal Weyl operator, i.e. hollow symmetric $(w_{ij})$ with vanishing row sums | Jäger Assumption 1; [notes.md](../references/jaeger-2016-diagonal-case/notes.md) | everywhere; it is what makes $\mathop{\mathrm{Ric}}(\lvert W\rvert)$ diagonal | **STATED AND USED** |
| H2 | $\lVert W\rVert=1$ and $W^2+W^\#=\theta W$ with $\theta\ge\theta_0(n)$ | Jäger Assumption 1 | Lemma 3.3.4 onward | **STATED AND USED** |
| H3 | $n=2m$ with $m\ge8$, Assumption 1's dimension clause | Jäger Assumption 1, line 1705 | §3.6 ideal induction, line 5080 | **STATED; ITS ONLY EXPLICIT USE HAS SLACK, §10** |
| H4 | Assumption 2, $\mathop{\mathrm{scal}}\le(n-3)\tilde\theta_0(n)$, the contradiction hypothesis | Jäger Assumption 2, line 2212 | Lemmas 3.3.6, 3.3.7, 3.5.5, 3.5.6 | **STATED AND USED** |
| H5 | $S\succeq0$ | the L1 block, as prose beside the moment problem, **not inside the braces of $F(v)$** | the two Cauchy–Schwarz steps and the support $(0,1]$ | **USED; SATISFIED (§7); STATED ADJACENT RATHER THAN IN THE STATEMENT** |
| H6 | $\mathop{\mathrm{tr}}S^2=1$, Frobenius unit norm | the block says only *"unit norm"* | makes $\mu$ a probability measure; makes $\lambda_i\le1$; both Cauchy–Schwarz normalisations | **USED; THE NORM SENSE IS UNQUALIFIED, §7** |
| H7 | $S$ has at most $n$ eigenvalues | nowhere in the block; in the script docstring as *"at most n eigenvalues in [0,1]"* | the constraint $\mathbb E[\lambda^{-2}]\le n$ and the floor $\mathop{\mathrm{tr}}S\le\sqrt n$ | **USED, STATED ONLY IN A DOCSTRING** |
| H8 | $\mathrm{RHS}$ is convex in $t$, so its max over the $\mathop{\mathrm{scal}}$-interval sits at an endpoint | the block, attributed to the source | Step 2 and both scripts, which evaluate only at $t\in\{\hat\theta_0/v,\ (n-3)\tilde\theta_0\}$ | **STATED, USED, AND CONDITIONAL ON A RANGE THE RECORD NEVER NAMES, §6** |
| H9 | $\mathrm{RHS}$ is strictly decreasing in $y$ | the report's Step 1, attributed to the source | Step 4's *"the inequality points the safe way"* | **STATED, USED, NOT RE-DERIVED HERE OR ON THE RECORD** |
| H10 | Result 5b, the six-line graph replacement for §3.6 after Lemma 3.6.10 | [ATTEMPTS.md:629](../ATTEMPTS.md), unnumbered | discharging H3 | **STATED; NEVER GATE 2'd; AND §10 FINDS IT UNNEEDED AT $m=6,7$** |
| H11 | The transcription of $\mathrm{RHS}(t,v,y)$ into the scripts faithfully reproduces the end of Jäger's Lemma 3.5.5 proof | nowhere as a claim | everything downstream of Step 2 | **USED, NEVER STATED, NEVER CHECKED, §9** |

**Two entries are the report's own verdict on itself**, and I record that they are honest: [lean/INDEX.md:202](../lean/INDEX.md) lists as *"Owed"* exactly *"the reduction to Jäger's expression, the dual construction, and Result 5b"*, and [lean/INDEX.md:247](../lean/INDEX.md) lists *"the feasible-region evaluation behind $\pm0.05627$ and $-0.01741$"*. H11 and the Step-2 numbers are debts the record already books.

## 2. The status contradiction, the record states it five ways, and the brief found three

The brief names A, C and D. Two more are live.

| where | what it says |
| --- | --- |
| **A**, [problem.md:450](../findings/problem.md) | *"**NEVER AUDITED, and OUT OF SCOPE.** … **So nothing in this project depends on Lemma L1** … it is not worth reviewer time."* |
| **C**, [findings/INDEX.md:19](../findings/INDEX.md) | *"$n=12,14$ are closed by Lemma L1 … **But that proof lives only in [results.md](../results.md), not in [findings/](../findings/), and has no ledger row, so its Gate 2 status is unrecorded.**"* |
| **D**, [findings/INDEX.md:45](../findings/INDEX.md) | *"**audited, and conditional on Result 5b.**"* |
| **E**, [findings/INDEX-results.md:16](../findings/INDEX-results.md) | *"**Gate 2: the mathematics reproduces; three of the block's load-bearing sentences did not** ([r497](../reviews/REVIEW_r497.md), [r498](../reviews/REVIEW_r498.md) … both PLAUSIBLE). **Conditional on Result 5b** … **Not load-bearing for the programme**."* |
| **F**, [findings/LEDGER.md:52](../findings/LEDGER.md) | *"**NEVER AUDITED, and OUT OF SCOPE, which is why it stays that way.** … **Do not spend reviewers on it.**"*, and [LEDGER.md:19](../findings/LEDGER.md): *"whose proof sits in [results.md](../results.md)"* |

**What the mathematics supports, clause by clause.**

1. **"Never audited" (A, F) is false.** [REVIEW_r497.md](../reviews/REVIEW_r497.md) and [REVIEW_r498.md](../reviews/REVIEW_r498.md) are on file, on identical briefs, both `PLAUSIBLE`, both explicitly auditing this block (r497 with eleven numbered sections including *"§6 The census), REFUTED as written, and this is the block's most serious concealment"*. The block itself cites them. So A and F contradict a review pair the block beside them names, and F's *"do not spend reviewers on it"* is an instruction the record has already disobeyed to its own benefit.
2. **"Nothing in this project depends on Lemma L1" (A) is true**, and is the one clause of A that survives, §3 below.
3. **C's location clause is false.** I grepped [results.md](../results.md) for `L1`: the hits are line 84 (*"a correction offered to the setter"*) and line 830 (the audit-owed list). **There is no proof of L1 in [results.md](../results.md).** The proof is the block at [problem.md:468](../findings/problem.md), whose own italic header says *"Moved here from [results.md](../results.md) on 2026-08-31"*. C's *"lives only in results.md, not in findings/"* is exactly backwards, and [LEDGER.md:19](../findings/LEDGER.md) repeats it. [r498](../reviews/REVIEW_r498.md)'s §9 called this out under *"Stale location"* and listed four such pointers; two of the four are still standing.
4. **C's "has no ledger row, so its Gate 2 status is unrecorded" is false.** [INDEX-results.md:16](../findings/INDEX-results.md) is the row and it records the Gate 2 verdict in full.
5. **C's "proved outright at every $n\ge4$ … so the grant is no longer load-bearing" is consistent with the rest** and is a statement about [Lemma L57](../findings/problem.md), not about L1. It does not conflict with L1 being separately true; it conflicts only with the *urgency* A and F assign.
6. **D is right on both clauses**, modulo §10: L1 *has* been audited, and the record *does* declare it conditional on Result 5b. Whether that conditionality is well-founded is §10's question, and I find the stated ground unsupported.

**Verdict on the contradiction.** D and E are the accurate statements. A's first sentence, F entirely, and C's third sentence are stale and each is refuted by a file the same record owns.

## 3. Does anything depend on L1?

**No.** I searched rather than trusting any of the three statements:

- `grep -rn "L1\b" --include='*.md'` over the repository returns, outside the L1 block and the verification/review files, only descriptive mentions: [results.md:84](../results.md), [results.md:830](../results.md) (*"superseded as a dependency by Lemma L57"*), [findings/INDEX.md:19](../findings/INDEX.md), [findings/LEDGER.md:19](../findings/LEDGER.md), [lean/INDEX.md:202](../lean/INDEX.md).
- **No numbered result cites L1**, and L1 cites no numbered result, [r497](../reviews/REVIEW_r497.md)'s §"L1 cites L18 and L20" independently found the same, by `sed` over both blocks.
- The dependency runs *outward from* Jäger, not through L1: [L18](../findings/problem.md) and [L19](../findings/problem.md) consume Jäger's chapters directly.

So L1 is a **leaf**. Its failure would cost the correction offered to the setter and nothing else. That is A's claim, and it is right.

## 4. How many dimension constraints carry Theorem A, checked at source

**The block says two. As a count of constraints that reach above $n=12$, that is right.** Read at source, the numeric dimension hypotheses in Chapter 3 are:

| where | constraint | binds above $n=12$? |
| --- | --- | --- |
| Theorem 3.0.2, line 1668 | $m\ge8$ | statement, not a use |
| Assumption 1, line 1705 | $m\ge8$, $n=2m$ | standing hypothesis |
| line 3541 | *"because $n(n^2-10n+18)\ge0$ for $n\ge8$"* | no |
| line 4111 | $16n^2-2(8n+9)(n-1)=-2n+18\le0$, needs $n\ge9$ | no |
| Lemma 3.3.6, line 2521 | $-41n+57\le0$ | no ($n\ge2$ as a polynomial sign) |
| Lemma 3.6.7 proof, line 4820 | $f(n)=n^4-7n^3+4n^2-3n+3>0$ on $[7,\infty)$; $g(n)=n^4-5n^3+4n^2-3n+3>0$ for $n\ge5$ | no |
| Lemma 3.5.6 via 3.5.5 | the two quartics, largest real roots $14.811$ and $14.963$ | **yes**, this is the one L1 moves |
| §3.6 line 5080 | *"choose $l\in A_k$ with $l\notin\{a,b,c,d\}$ which is possible because $m\ge8$"* | **the only explicit re-use of $m\ge8$ in the thesis**, and §10 finds it slack |

`grep -nE "m *(\\ge|≥) *8"` over the 5140-line extraction returns exactly three hits: lines 1668, 1705, 5080. So *"$m\ge8$ three times, twice as the statement … and once as a genuine use"* is a correct count of occurrences. **The word carrying the weight is "genuine", and §10 disputes it.**

**Note also the parity clause.** Assumption 1 does not merely say $m\ge8$; it says $n=2m$. **Evenness is a third dimension hypothesis**, and it is the one that makes odd $n$ untouchable by this route at all, L1 cannot say anything at odd $n$, which every statement of it correctly reports. Counting it, Theorem A carries three; the block's "two" is a count of the *numeric* constraints, which is the reading the census uses, and I read it that way.

## 5. The census as it now stands, refuted as printed, in four places

The census is [ATTEMPTS.md:799](../ATTEMPTS.md), headed **"Result 5, nothing else in the proof binds above $n=12$"**. Its body enumerates: $n\ge1,\dots,9$ all satisfied; $k\ge12$ in Lemma 3.5.4, satisfied; the two $n\ge15$ conclusions replaced; and *"$m\ge8$ three times, twice as the statement … and once as a genuine use, the ideal-induction step in §3.6."*

**The block's charge is correct: the headline asserts the negation of what the body found.** A body reporting one genuine use of a hypothesis that binds at $n=12$ cannot head itself *"nothing else in the proof binds above $n=12$"*. The body's own escape (*"That step is precisely the one the six-line graph argument … already replaces"*), makes the headline conditional, which is a different sentence.

**And the refuted headline is still standing in four places**, only one of which is the block that refutes it:

| file | line | what still stands |
| --- | --- | --- |
| [findings/problem.md](../findings/problem.md) | 456 | *"**Every** dimension constraint in Theorem A flows from Lemma 3.5.6"* |
| [findings/problem.md](../findings/problem.md) | 462 | *"**Scope.** A census of every dimension hypothesis in Jäger's Chapter 3 confirms nothing else binds above $n=12$."* |
| [ATTEMPTS.md](../ATTEMPTS.md) | 799 | the headline itself |
| [scripts/lib/run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py) | docstring | *"WHY NOTHING ELSE IN THE PROOF BLOCKS n=12,14"* |
| [references/…/notes.md](../references/jaeger-2016-diagonal-case/notes.md) | *"Where the dimension threshold actually comes from"* | **both** refuted sentences, in the reference notes |

**[problem.md](../findings/problem.md) contradicts itself at six lines' distance**: 456 and 462 say what 472 and 474 call false, inside one file, under one heading. A reader of section A never reaches the correction. **And the reference-notes copy is worse than stale**: [r498](../reviews/REVIEW_r498.md) flagged it as a *"Provenance hazard"*, the record's own conclusion written into the source's notes in the record's own words, so a reader checking L1 against the notes finds L1 again. That flag is unactioned.

**Discrepancy protocol.** Located: five line numbers above. Exhibited: the two sentences are the negation of the block's two, verbatim, in the same repository. Argued the opposite: one could read 456/462 as *"nothing else binds, given Result 5b"*, but neither sentence carries the conditional, 462 is headed **Scope**, and the block twenty lines below says in capitals that both are false. **Recorded.**

## 6. The rounding-slack account, derived here in full

**The clearing.** $E(n)\le\dfrac{16}{8n+9}$ with $4(n+1)(n-2)(n-3)>0$ and $8n+9>0$ is equivalent to

$$(8n^2-41n+49)(8n+9)\ \le\ 64(n+1)(n-2)(n-3).$$

Expanding both sides:

$$(8n^2-41n+49)(8n+9)=64n^3+72n^2-328n^2-369n+392n+441=64n^3-256n^2+23n+441,$$
$$64(n+1)(n-2)(n-3)=64(n^3-4n^2+n+6)=64n^3-256n^2+64n+384.$$

Subtracting, the cubic and quadratic terms cancel identically and

$$(8n^2-41n+49)(8n+9)-64(n+1)(n-2)(n-3)=-41n+57.$$

So the cleared inequality is $41n-57\ge0$. **This is exactly Jäger's own line 2521–2523**, which prints $=-41n+57\le0$ and adds *"for all $n\ge2$"*. The record reproduces it with the sign flipped, which is the same statement.

**The direction of the rounding.** $16/(8n+9)-E(n)=\dfrac{41n-57}{4(n+1)(n-2)(n-3)(8n+9)}\ \ge0$ on $n\ge4$. So $16/(8n+9)$ is the **larger** number and Jäger replaces his exact ceiling on $\mathop{\mathrm{tr}}S^4$ by a **weaker** one. **That is the correct direction for a rounding to cost slack rather than to be unsound**, and it means keeping $E(n)$ exact can only help. Confirmed.

**The cost.** The record's *"costing $(41n-57)$ over a quartic"* is exactly the display above, linear numerator, quartic denominator, so $\Theta(n^{-3})$. Screen: at $n=12$ the numerator is $435$ and the denominator $4\cdot13\cdot10\cdot9\cdot105=491400$, giving $0.000885$; at $n=14$, $517/958320=0.000539$. Both reproduce the recorded figures. *Reported as a screen.*

**The false clause, and it is the boundary trap the brief names.** *"Valid at every $n\ge2$"* is a claim about the rounding, and it is false:

- At $n=2$ the denominator $4(n+1)(n-2)(n-3)=4\cdot3\cdot0\cdot(-1)=0$ and at $n=3$ it is $4\cdot4\cdot1\cdot0=0$. **$E(n)$ does not exist at either endpoint of the stated range.**
- At $n=5/2$: numerator $8\cdot\tfrac{25}4-41\cdot\tfrac52+49=50-102.5+49=-3.5$; denominator $4\cdot\tfrac72\cdot\tfrac12\cdot(-\tfrac12)=-3.5$. So $E(5/2)=1$, while $16/(8\cdot\tfrac52+9)=\tfrac{16}{29}<1$. **$E>R$, the rounding fails, in closed form, inside the stated range.** The mechanism is that $(n-2)(n-3)<0$ on $(2,3)$ flips the cross-multiplication.

**Discrepancy protocol.** Located: [problem.md:456](../findings/problem.md), [ATTEMPTS.md:4581](../ATTEMPTS.md), [lean/INDEX.md:247](../lean/INDEX.md), and [JaegerRounding.lean](../lean/HamiltonsCubic/Results/JaegerRounding.lean)'s docstring, all four say *"valid at every $n\ge2$"* or *"holds from $n=2$ on"*. Exhibited: $n=5/2$ above. Argued the opposite: **Jäger's own sentence is about the polynomial**, $-41n+57\le0$ for $n\ge2$, which is true; and the record's four sites are about the rounding, which is not. The claim is also harmless in use, since $\dim\mathcal W_n=0$ for $n\le3$ and every $n$ the argument touches is $\ge12$. **Recorded as a precision defect, not a break.**

**And the Lean file gets it right where the prose does not.** [JaegerRounding.lean](../lean/HamiltonsCubic/Results/JaegerRounding.lean)'s `rounding_valid` carries the hypothesis `(hn : 4 ≤ n)` and its proof opens with `hb : 0 < n - 2` and `hc : 0 < n - 3`, the exact positivity the prose drops. **The docstring above that theorem says $n\ge2$ and the theorem says $n\ge4$**, so the file disagrees with itself. The comment is what the record quotes.

**What the Lean file establishes and what it does not.** `cleared` and `gap_form` are `ring`/`field_simp` identities and are as strong as they look. `gap_values`, `residual_dwarfs_rounding` and `step_two_sign_change` are `norm_num` on decimal literals: they establish that **$0.05627/0.000885$ is between $63$ and $64$** and that **$+0.05627>0>-0.01741$**. They establish nothing whatever about the Step-2 residual actually being $0.05627$, that is [lean/INDEX.md:247](../lean/INDEX.md)'s own *"Owed"*. The theorem names promise more than the theorems say, and a reader taking `step_two_sign_change` as a proof that Step 2 changes sign would be taking arithmetic on two literals for a fact about Jäger's expression.

**The conclusion the record draws is nonetheless right.** $0.000885$ against a residual of $0.05627$ means this rounding cannot be what moves the threshold; *"the slack is cumulative"* is the correct reading of its own figures.

## 7. The $n=12$ moment-body step, the corner, and the two hypotheses

**Setup, re-derived.** $S\succeq0$ with $\mathop{\mathrm{tr}}S^2=1$ and at most $n$ eigenvalues. Push forward to $\mu=\sum_i\lambda_i^2\delta_{\lambda_i}$. Then $\mu$ is a **probability** measure precisely because $\sum\lambda_i^2=\mathop{\mathrm{tr}}S^2=1$; $\mathbb E_\mu[\lambda]=\mathop{\mathrm{tr}}S^3$; $\mathbb E_\mu[\lambda^2]=\mathop{\mathrm{tr}}S^4=v$; and

$$\mathbb E_\mu[\lambda^{-2}]=\sum_{\lambda_i\ne0}\lambda_i^2\lambda_i^{-2}=\#\{i:\lambda_i\ne0\}=\mathop{\mathrm{rank}}S\ \le\ n.$$

**This is where the $\ker W\ne0$ trap is answered, and it is answered correctly.** $\mu$ assigns zero mass to $\lambda=0$, so $\lambda^{-2}$ is $\mu$-integrable however large the kernel is; and a rank-deficient $S$ makes the true constraint *tighter* than $\le n$, so relaxing to $n$ is the safe direction. Padded objects enter nowhere: $\lvert W\rvert$ is built on the diagonal locus, where $\mathop{\mathrm{Ric}}(\lvert W\rvert)$ is diagonal with entries $\sum_j\lvert w_{ij}\rvert$.

**The corner elimination, in full.**

- **Floor for $y=(\mathop{\mathrm{tr}}S^3)^2$.** Cauchy–Schwarz on $(\lambda^{1/2},\lambda^{3/2})$ (legitimate because $S\succeq0$), gives $(\sum\lambda^2)^2\le(\sum\lambda)(\sum\lambda^3)$, i.e. $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$. With $\mathop{\mathrm{tr}}S\le\sqrt{n\mathop{\mathrm{tr}}S^2}=\sqrt n$ this gives $\mathop{\mathrm{tr}}S^3\ge1/\sqrt n$ and $y\ge1/n$. **That is Jäger's floor, and the block's second stated inequality is exactly this.**
- **Equality forces the flat spectrum.** $\mathop{\mathrm{tr}}S=\sqrt n$ is equality in Cauchy–Schwarz against $\mathbf1$, so all $n$ eigenvalues are equal; with $\mathop{\mathrm{tr}}S^2=1$ they are $\lambda_i=1/\sqrt n$.
- **Which drags the ceiling down.** At the flat spectrum $v=\mathop{\mathrm{tr}}S^4=n\cdot n^{-2}=1/n$. At $n=12$ that is $1/12=0.0833$ against the ceiling $16/105=0.1524$, or $709/4680=0.1515$ exactly. **The corner $(y,v)=(1/n,\ \text{ceiling})$ does not exist.** Confirmed.
- **The edge itself.** Cauchy–Schwarz on $(\lambda,\lambda^2)$: $(\sum\lambda^3)^2\le(\sum\lambda^2)(\sum\lambda^4)=\mathop{\mathrm{tr}}S^4$. So $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$, which is the block's *"the edge itself"*. **Equality holds iff $\lambda^2\propto\lambda$ on the support, i.e. iff all nonzero eigenvalues coincide**, the flat spectrum again, where $\mathop{\mathrm{tr}}S^4$ sits at its floor $1/n$ (Cauchy–Schwarz $(\sum\lambda^2)^2\le n\sum\lambda^4$). **So the block's *"a genuine equality case rather than an estimate"* is right.**
- **The excluded box point.** $(\mathop{\mathrm{tr}}S^3,\mathop{\mathrm{tr}}S^4)=(\tfrac12,\tfrac15)$ satisfies $\tfrac1{12}\le(\tfrac12)^2=\tfrac14$ and $\tfrac15\le\tfrac{16}{105}$?, $\tfrac15=0.2>0.1524$, so it is not in the $n=12$ box; read as a schematic box point it fails the edge outright, since $(\tfrac12)^2=\tfrac14>\tfrac15$. **The exclusion the block claims holds.** *(The block does not say which $n$'s box it means; the exclusion is $n$-free, so the sentence is true under any reading.)*

**The two hypotheses, and both are load-bearing and satisfied.**

- **$S\succeq0$ is used four times**, for $\lambda^{1/2}$ to exist, for the support to lie in $(0,1]$, for $\mathop{\mathrm{tr}}S^3>0$ so that squaring the line is legitimate, and for the pointwise dual inequality to be tested on $(0,1]$ rather than on $\mathbb R$. **It is satisfied**: on the diagonal locus $\mathop{\mathrm{Ric}}(\lvert W\rvert)$ is the diagonal matrix with entries $\sum_j\lvert w_{ij}\rvert\ge0$.
- **Unit norm is used** to make $\mu$ a probability measure and to force $\lambda_i^2\le\sum_j\lambda_j^2=1$, hence $\lambda_i\in(0,1]$. **It is satisfied**, $S$ being a normalisation.
- **The record's demonstration that they are load-bearing is exact and correct.** Without the support constraint, $\delta_{-1}$ meets $\mathbb E[\lambda^2]=1$ and $\mathbb E[\lambda^{-2}]=1\le n$ and gives $\mathbb E[\lambda]=-1$ against $\varphi(1)=35247/38000$, a gap of $73247/38000>1$, larger than the range of the quantity bounded. That is [L1.lean](../lean/HamiltonsCubic/Results/L1.lean)'s `delta_refutes`, kernel-checked, and I confirm the arithmetic: $\varphi(1)=7/10+8647/38000=26600/38000+8647/38000=35247/38000$.

**The defect that remains, and it is the "hypothesis stated but never used" trap in its mirror image.** The block **displays** $F(v)=\min\{\mathbb E[\lambda]:\mathbb E[\lambda^2]=v,\ \mathbb E[\lambda^{-2}]\le n\}$ (with no support constraint inside the braces) and then says in a following paragraph that two hypotheses are load-bearing. **A reader who copies the displayed formula copies the false one.** [r498](../reviews/REVIEW_r498.md)'s recommendation was *"$S\succeq0$, $\lambda\in(0,1]$ written into the moment problem"*; it has been written *beside* it. The formula still needs $\mu$ supported in $(0,1]$ in its own braces.

**And "unit norm" is unqualified where the sense decides the truth.** $\lVert S\rVert=1$ in the operator sense gives neither $\mathop{\mathrm{tr}}S^2=1$ nor a probability measure, and the whole pushforward collapses. [conventions.md](../findings/conventions.md) records a norm collision of exactly this kind, *"$\lVert K\rVert_F^2=2$ at a unit Weyl tensor; $W$ is the operator on $\Lambda^2$, where $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$"*, and asks that the sense be said. Here it is not said. **Write $\mathop{\mathrm{tr}}S^2=1$.**

## 8. The duality step, weak duality does suffice

**What is drawn from it.** A *lower* bound on $\mathop{\mathrm{tr}}S^3$ at every $v$ at once: the certified line $\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}\le\mathop{\mathrm{tr}}S^3$.

**Derivation, from weak duality alone.** Take $\alpha\in\mathbb R$ and $\beta\ge0$, and suppose the pointwise inequality

$$h(\lambda):=\lambda-\alpha\lambda^2+\beta\lambda^{-2}\ \ge\ \gamma\qquad\text{for all }\lambda\in(0,1].$$

Integrating against any feasible $\mu$ supported in $(0,1]$,

$$\mathop{\mathrm{tr}}S^3-\alpha v+\beta\,\mathbb E[\lambda^{-2}]\ \ge\ \gamma,$$

and since $\beta\ge0$ and $\mathbb E[\lambda^{-2}]\le n$, the middle term obeys $\beta\mathbb E[\lambda^{-2}]\le\beta n$, so

$$\mathop{\mathrm{tr}}S^3\ \ge\ \gamma+\alpha v-\beta n\ =:\ \varphi(v).$$

**Every step is one inequality applied in one direction.** No strong duality, no Slater point, no attainment, no constraint qualification, and **no convexity of $F$**, the argument never asks that the bound be tight, only that it be valid. **The block's *"weak duality alone licenses it, so no constraint qualification is owed and the convexity appealed to here is surplus"* is correct**, and the surplus convexity is visible: [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)'s docstring argues *"F is CONVEX in v … so a Lagrangian dual certificate computed at a single v is a supporting line valid for every v"*, and its own next paragraph then gives the weak-duality derivation that needs none of it.

**The sign of $\beta$ is the whole content, and the record has it right.** The script's docstring writes `h(lam) := lam - alpha*lam^2 + beta*lam^-2 >= gamma on (0,1], beta >= 0`, the $+\beta\lambda^{-2}$ with $\beta\ge0$ is exactly what turns $\mathbb E[\lambda^{-2}]\le n$ into a usable bound. **Had the sign gone the other way the line would be unlicensed**, and this is the one place a reader should check. It is right.

**The constants reconcile.** $\alpha=7/10$, $\beta=1/152$, $\gamma=613/2000$ give $\gamma-n\beta=\tfrac{613}{2000}-\tfrac{12}{152}=\tfrac{11647}{38000}-\tfrac{3000}{38000}=\tfrac{8647}{38000}$, which is the block's intercept exactly. *Reported as a screen.*

**What is not checked here, and is not checkable analytically at reasonable cost.** That $h(\lambda)\ge\gamma$ on $(0,1]$, the script turns it into a quartic nonnegativity by multiplying by $\lambda^2$ and settles it by `sympy.real_roots`. That is exact root isolation and I accept its *form*; I did not run it and record it as unverified here.

## 9. The interval-arithmetic step, what a validated discharge establishes, and what it assumes

**The script was read, not run.** [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py) uses `mpmath`'s `iv` interval type at 40 digits, evaluates an enclosure of $\mathrm{RHS}(v,\varphi(v)^2)$ over subintervals of $[10/81,\ 709/4680]$, and accepts a subinterval when the **upper** end of its enclosure is negative, bisecting otherwise to depth 60.

**What such a discharge establishes.** *A theorem about the function the script transcribed*, to the reliability of directed rounding in `mpmath.iv`, on the interval covered, and nothing about Jäger's Lemma 3.5.5. It is a proof in the same sense a `native_decide` is: a machine-checked implication whose antecedent is the transcription.

**What it assumes, in order of how much weight each carries.**

1. **H11, the transcription.** The record nowhere claims the transcription is faithful, and [lean/INDEX.md:202](../lean/INDEX.md) books *"the reduction to Jäger's expression"* as **Owed**. From the `pdftotext` extraction I can confirm only the shape: line 4184ff shows $-\tfrac{263}{144}\tfrac{n-3}{n^2(n-2)}(\dots)-2\tilde\theta_0(\tfrac{2n-9}{4n^3}+\tfrac{3x}{8n^2})t+\dots+\sqrt{\tfrac{(\mathop{\mathrm{tr}}S^4)^2-(\mathop{\mathrm{tr}}S^3)^4}{1-(\mathop{\mathrm{tr}}S^3)^2}}$, which matches the script's `(v**2 - y**2)/(1 - y)` under $y=(\mathop{\mathrm{tr}}S^3)^2$ and the coefficient block term for term. **The OCR is too damaged to certify the full expression, and this is the single largest unchecked link in L1.**
2. **The trusted computing base**, `mpmath.iv` and Python floats at `iv.mpf([lo, hi])` construction. Not audited anywhere on the record.
3. **The two case endpoints exhaust the maximum in $t$**, H8, Jäger's convexity, discussed below.
4. **Termination.** `verify` returns `False` at `maxdepth` rather than raising, so a partial cover would print `NOT proved` rather than a wrong `PROVED`. **That failure mode is safe.**

**Three things in the script are conservative in the right direction, and I record them because they could easily have gone the other way.**

- `verify(VLO.a, VHI.b)` takes the **lower** end of the enclosure of $10/81$ and the **upper** end of the enclosure of $709/4680$, so the interval verified strictly contains the interval required. ✓
- The two-case hull `iv.mpf([min(out.a, e.a), max(out.b, e.b)])` upper-bounds the max over cases. ✓
- It evaluates both $t=\hat\theta_0/v$ and $t=(n-3)\tilde\theta_0$ **without** the feasibility guard that [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py) applies (`if sp.N(t - (N-3)*T0) > 1e-12: continue`). Including an infeasible endpoint only enlarges the maximum. ✓

**One divergence between the two scripts, and it is safe only by an argument neither makes.** The certificate script sets `y = sp.Min((ALPHA*v + C)**2, v)`; the interval script sets `y = phi**2` with the `Min` dropped. Since $\mathrm{RHS}$ is *decreasing* in $y$, the larger $y$ gives the smaller $\mathrm{RHS}$, so dropping the `Min` is the **unsafe** direction unless $\varphi(v)^2\le v$ throughout. **It does hold**: $\varphi$ is increasing and $\varphi(709/4680)=\tfrac{4963}{46800}+\tfrac{8647}{38000}<0.334$, so $\varphi(v)^2<0.112<10/81\le v$ on the whole range. *Reported as a screen.* **The record nowhere states this, and the two scripts differ on it silently.**

**And H8's convexity is range-conditional, which the record does not say.** With $\mathrm{RHS}$'s $t$-dependence $-K(t^2-t^3/(n\hat\theta_0))-Lt+\text{const}$, $K,L>0$,

$$\frac{\partial^2\mathrm{RHS}}{\partial t^2}=-K\Big(2-\frac{6t}{n\hat\theta_0}\Big)\ \ge0\iff t\ \ge\ \frac{n\hat\theta_0}{3}.$$

**So "convex in $t$, hence the max is at an endpoint" holds on a half-line, not everywhere**, and the licence survives only if the $\mathop{\mathrm{scal}}$-interval sits inside it. Screen at the two dimensions: $\tilde\theta_0(12)=\sqrt{198/130}=1.23413$, $\hat\theta_0(12)=\tfrac{10}9\tilde\theta_0=1.37126$, threshold $n\hat\theta_0/3=5.485$, against $t\in[\hat\theta_0/v,\ 9\tilde\theta_0]\subseteq[9.05,\ 11.11]$; at $n=14$, $\tilde\theta_0=\sqrt{286/180}=1.26051$, $\hat\theta_0=1.37492$, threshold $6.416$, against $t\ge\hat\theta_0/E(14)=1.37492/(1043/7920)=10.44$. **Both clear, comfortably.** *Reported as a screen.* The block's *"the licence survives at $n=12,14$"* is therefore **true**, and true for a reason the block does not give, it reads as if convexity were unconditional.

## 10. Result 5b, found, and its stated necessity is unsupported at $m=6,7$

**What it is and where.** [ATTEMPTS.md:629](../ATTEMPTS.md), inside *"Result 5, two by-products"*, item **(b)**:

> *A shortcut, confirmed:* Jäger's §3.6 endgame (~5 pages of symmetric-space classification and ideal induction) is replaceable by a six-line graph argument, his Lemma 3.6.10's two vanishing traces say exactly that the positive-entry graph $G$ is a disjoint union of cliques and $\bar G$ is triangle-free, forcing two blocks, with the degree count forcing them equal. Verified by exhaustive brute force over all graphs at $n=4,5,6$ … the route still consumes Lemmas 3.6.7–3.6.8, so it replaces §3.6 *after* Lemma 3.6.10 rather than the whole section. It removes the only $m\ge8$ invocation there but does not lower the threshold, which lives in §3.5.

**So the block's characterisation of Result 5b's status is accurate.** It is unnumbered, unindexed, has no Gate 2 verdict, and its recorded warrant is *"exhaustive brute force over all graphs at $n=4,5,6$"*, **a claim checked on a subfamily and used at $n=12,14$**, which is one of the traps this brief names. The graph argument itself is dimension-free as stated (a union of $k$ cliques has complete $k$-partite complement, and triangle-freeness forces $k\le2$), so the brute force is corroboration rather than proof; but the proof has never been written out past six lines.

**Its own precision note carries a second debt the block does not repeat.** *"The route still consumes Lemmas 3.6.7–3.6.8"*, and **both are stated *"Let assumption 1 hold"***, so $m\ge8$ re-enters through them unless their proofs are checked. I checked 3.6.7 at source, lines 4797–4845: its proof needs $f(n)=n^4-7n^3+4n^2-3n+3>0$ on $[7,\infty)$ and $g(n)=n^4-5n^3+4n^2-3n+3>0$ for $n\ge5$. **Neither binds at $n=12,14$.** Corollary 3.6.8 is algebra from 3.6.7. So that particular re-entry is clean, **but the record never says so**, and a reader taking Result 5b at its word inherits an undischarged Assumption 1.

**Now the finding.** The block, [INDEX-results.md:16](../findings/INDEX-results.md), the report's Step 6, [ATTEMPTS.md:799](../ATTEMPTS.md) and the census all rest the conditionality on one sentence: $m\ge8$ *"is used again and genuinely at its §3.6 ideal-induction step"*. The report even names the mechanism, *"which selects an index outside a four-element set"*. **The source's line is, verbatim (line 5080):**

> Further, choose $l\in A_k$ with $l\notin\{a,b,c,d\}$ which is possible because $m\ge8$ and $\#A=m(m-1)$ by lemma 3.6.7.

**Selecting one index of $A_k$ outside a four-element set requires $\#A_k\ge5$ and nothing more.** Jäger's own §3.6 closing paragraph fixes $\#A_a=\#A_c=m$ (*"$\dim(i_a)=\dim(i_c)=\tfrac{m(m-1)}2$, which implies $\#A_a=\#A_c=m$"*), so $\#A_k\ge5$ is $m\ge5$. Under the branch's own hypothesis $i_k=\mathfrak k$, which forces $\binom{\#A_k}2=\#A=m(m-1)$ and hence $\#A_k(\#A_k-1)=2m(m-1)$, $\#A_k\ge5$ is $m(m-1)\ge10$, i.e. $m\ge4$. **Either way $m=6$ and $m=7$ (that is $n=12$ and $n=14$), clear it.**

**And the surrounding machinery clears too.** The step's conclusion needs $\mathfrak k\cong\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ to have exactly two nontrivial ideals, which needs $\mathfrak{so}(m)$ simple, true at $m=6$ ($\cong\mathfrak{su}(4)$) and $m=7$, failing only at $m=4$. Lemma 3.6.13's classification appeal identifies a symmetric space $\mathrm{Spin}(n)/K$ of dimension $m^2$; $p(2m-p)=m^2$ has the unique root $p=m$, so the identification is not degenerate at $m=6,7$.

**Discrepancy protocol, all three cleared.**

1. **Located.** [problem.md:472](../findings/problem.md) (*"used again and genuinely at its §3.6 ideal-induction step"*), [findings/INDEX-results.md:16](../findings/INDEX-results.md) (*"a second dimension hypothesis, $m\ge8$, binds at the source's §3.6"*), [04-granted-hypothesis.tex](../report/sections/04-granted-hypothesis.tex) Step 6 and its certificate, [ATTEMPTS.md:799](../ATTEMPTS.md), [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py)'s docstring.
2. **Exhibited in closed form.** The step needs an element of $A_k$ outside $\{a,b,c,d\}$; $\#A_k=m$ by Jäger's own count; $m-4\ge1$ at $m=6,7$. There is no inequality here to evaluate numerically, it is a counting statement and it is decided by $6>4$.
3. **Argued the opposite.** *(i)* Assumption 1 is standing, so §3.6's other lemmas may use $m\ge8$ tacitly even where they do not name it. I checked 3.6.7, 3.6.8 and 3.6.13; I did **not** check 3.6.2–3.6.6 or 3.6.10 line by line, and the OCR of those pages is poor. **So a full discharge of Assumption 1 across §3.6 is not something this round can certify, and the record does not carry one either.** *(ii)* One could read *"because $m\ge8$"* as covering more than the index choice, but the sentence names its purpose, and the purpose is the index choice. *(iii)* Jäger, writing under $m\ge8$ throughout, had no reason to state the sharp constant; that his bound is loose is unremarkable of him and consequential only for a record that repairs his threshold.

**Verdict on Result 5b.** *What L1 loses without it*: **on the record's own account, §3.6's endgame, and hence Theorem A rather than merely Lemma 3.5.6, at $n=12,14$. On the source as read here, nothing**, the step Result 5b replaces does not bind at $m=6,7$. **I do not supply the replacement argument, and I am not asserting Assumption 1 is discharged.** What I record is that **the record's stated reason for the conditionality is not supported by the passage it cites**, and that the conditionality therefore stands on an unexamined foundation in *both* directions. `HYPOTHESIS-DEBT`: what would have to be proved is *"no lemma of Jäger's §§3.2–3.6 uses Assumption 1's $m\ge8$ at a strength exceeding $m\ge6$"*, a per-lemma audit, currently on file only as a headline that its own body contradicts.

## 11. The remaining named traps, each answered

- **$\ker W\ne0$ and padded objects.** Answered in §7: the pushforward gives zero mass to zero eigenvalues, $\mathbb E[\lambda^{-2}]=\mathop{\mathrm{rank}}S\le n$ is the tighter true constraint, and the relaxation to $n$ is safe. Padded objects (padded $W_{\mathbb{CP}^2}$, Fox's $\mathcal S^4(\alpha)$) are off the diagonal locus and cannot enter a statement quantified over $\langle W\rangle_d$. **Nothing found.**
- **$n=12$.** The hardest case, and the one carrying the new mathematics. Checked in §7 and §9. The convexity licence and $\varphi^2\le v$ both hold there by margin.
- **$n=14$.** **Weaker than $n=12$ on the record.** It rests on Step 2/Step 3's exact evaluation, i.e. on [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py) and the figure $-0.01741$, and **not** on the E5/E5a certificates, which are hard-coded `N = 12`. [r498](../reviews/REVIEW_r498.md) recorded the same, *"the $n=14$ half marked as evaluated at Jäger's corner pending the E5a run at $N=14$"*. So the two dimensions L1 names are discharged by **different** machinery of **different** strength, and no statement of L1 anywhere says so; *"So both dimensions are machine-checked rather than swept"* reads as if one certificate covered both. **Recorded as a scope defect.**
- **$n=16$.** No gap: Theorem A begins at $16$, L1 supplies $12$ and $14$, and $m\ge8$ is exactly $n=16$. The boundary abuts cleanly.
- **Odd $n$.** Untouched, and correctly so at every site, Assumption 1 stipulates $n=2m$, so this route cannot reach odd $n$ whatever the threshold does. **Nothing found; the record is consistent here.** *(Jäger's own remark, extraction line 1690, notes §§3.2–3.5 run under $\tilde\theta_0$ and cover both parities, and only §3.6 needs evenness, so the honest odd-$n$ statement is that §3.6 blocks it, which [ATTEMPTS.md](../ATTEMPTS.md) Result 6 says and the L1 block does not repeat.)*
- **The crossover $n=6+2\sqrt7\approx11.2915$.** L1 never invokes it, and does not need to: it repairs a threshold at $12$ and $14$, and $6+2\sqrt7<12$. **The two thresholds coincide numerically and have unrelated causes**, the crossover is $\theta_0(n)^2\ge\tfrac32\iff n^2-12n+8\ge0$ ([graded-half.md:146](../findings/graded-half.md)), while Jäger's $16$ is rounding slack. Conflating them would be a real error and **L1 does not commit it**. *(Note for the record: [findings/INDEX-traps.md](../findings/INDEX-traps.md) post F7 requires every candidate inequality to see the crossover; L1 is a repair to a source's threshold rather than a candidate inequality, so F7 does not apply to it.)*
- **A claim proven on a subfamily and used in general.** **Found, twice.** Result 5b's warrant is brute force at $n=4,5,6$, applied at $n=12,14$ (§10). And the E5/E5a certificates are `N = 12` only, applied in a sentence covering both dimensions (above).
- **A hypothesis stated but never used.** **Found: the convexity of $F$** in [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)'s docstring, which the block itself correctly calls *"surplus"* (§8). Also H10 as read here.
- **A step using a hypothesis never stated.** **Found, three.** H7 ($S$ has at most $n$ eigenvalues) lives only in a docstring; H11 (the transcription) is nowhere; and the range condition $t\ge n\hat\theta_0/3$ behind H8 is nowhere (§9).
- **A universal claim with no witness.** L1's statement is a uniqueness claim, so the witness that matters is a *counter*witness, §13.
- **An imported theorem whose hypotheses were never checked against the object.** This is Jäger's Theorem A, and the whole of §4, §5 and §10 is that check. **The hypotheses were checked, and one of them (Assumption 1's $m\ge8$), is checked on the record by a sentence the source does not support.**
- **Symbol collisions.** §0. Four live, none tabled, none changing a truth value inside L1.

## 12. Verdict

**`HYPOTHESIS-DEBT`.**

**What holds, and I checked each by re-derivation rather than by reading.** The clearing $41n-57\ge0$ and the direction of the rounding (§6). The moment-body corner elimination, its two Cauchy–Schwarz inequalities, its equality case at the flat spectrum, and the exclusion of $(\tfrac12,\tfrac15)$ (§7). That the two hypotheses are load-bearing and are satisfied by $S=\mathop{\mathrm{Ric}}(\lvert W\rvert)/\lVert\mathop{\mathrm{Ric}}(\lvert W\rvert)\rVert$ (§7). That weak duality alone licenses the supporting line and the convexity is surplus (§8). That the endpoint licence survives at $n=12,14$ (§9). That nothing on the record depends on L1 (§3).

**What the debt is.**

1. **The headline exceeds the proof.** L1 states *"Jäger's Theorem A holds for even $n=12$ and $n=14$"*. What is established is *Lemma 3.5.6 at those $n$*, plus a census. The bridge is the discharge of Assumption 1 across Chapter 3, and that discharge is on file only as a headline its own body contradicts (§5).
2. **The one hypothesis the census calls genuine is not genuine at $m=6,7$** (§10), so the record's stated conditionality has an unsupported basis, and the honest replacement is not "L1 is unconditional" but "no per-lemma audit of Assumption 1 exists in either direction".
3. **H11, the transcription of $\mathrm{RHS}$, is unstated and unchecked** and carries everything downstream of Step 2 (§9). The record books it as owed; it is the largest single link.
4. **The two dimensions are discharged by machinery of different strength**, and no statement says so ($n=14$ has no certificate; the E5/E5a scripts are $N=12$).
5. **Four sites still print the refuted census** and two still misplace the proof in [results.md](../results.md) (§2, §5); one of the four is inside the reference notes, where it reads as a fact about the source.

**Not `GAP`**, because the gap is not in a derivation, every derivation I could reach closes. **Not `BROKEN`**, because nothing I found refutes the conclusion; the $n=5/2$ witness kills a range clause, not the lemma. **Not `UNRESOLVED, needs computation`**, because no run would settle any of the five debts: they are a per-lemma reading of a source, a transcription check, and five stale sentences.

## 13. What would falsify it, and what I did to look

**The object.** A coordinate-diagonal Weyl operator $W\in\langle W\rangle_d$ on $\mathbb R^{12}$ or $\mathbb R^{14}$ with $\lVert W\rVert=1$ and $W^2+W^\#=\theta W$ for some $\theta\ge\theta_0(n)$, which is **not** the normalised Weyl curvature of $S^{n/2}\times S^{n/2}$. Equivalently, a hollow symmetric matrix with vanishing row sums realising such a $\theta$ off the balanced two-block form. **One such matrix at either dimension refutes L1's conclusion outright**, and, since $\theta_0(n)$ is the diagonal maximum the whole programme rests on, would refute [Lemma L57](../findings/problem.md) with it.

**A second, weaker falsifier**, which would break L1's *proof* without touching its conclusion: a pair $(v,y)$ with $y$ at Jäger's floor $1/n$ and $v$ near the ceiling $E(n)$ realised by an actual PSD $S$ with $\mathop{\mathrm{tr}}S^2=1$, the corner §7 says does not exist. **§7 shows why none exists**: $y=1/n$ forces equality in $\mathop{\mathrm{tr}}S\le\sqrt n$, hence the flat spectrum, hence $v=1/n$. The equality analysis is a proof of nonexistence, not a search.

**A third**: a lemma in Jäger's §§3.2–3.6 whose proof needs $m\ge7$ or more. That would restore the conditionality §10 removes and would make L1 genuinely dependent on Result 5b or on something stronger.

**What I did to look, analytically only.** I read Theorem A, Assumption 1, Theorem 3.0.2, Lemma 3.3.6 with its proof, Corollary 3.3.7, Lemma 3.5.6's statement and the opening of its proof, and §3.6 in full from Notation 3.6.1 through the end of the proof of Theorem 3.0.2, at source in the extraction. I grepped the whole 5140-line extraction for every occurrence of $m\ge8$, $n\ge16$, $n\ge15$, $n\ge12$ and "Assumption", and read the surrounding argument at each hit. I re-derived the clearing, the two Cauchy–Schwarz inequalities and their equality cases, the weak-duality bound, and the convexity condition in $t$, by hand. I read all three scripts as text and both Lean files in full. **I ran nothing.** For the first falsifier I did not and could not search, that is a computation, and the standing [analysis-only rule](../.claude/rules/analysis-only.md) reserves it; I record instead that the record's own prior sweeps ([ATTEMPTS.md](../ATTEMPTS.md) Result 8 at $n=12$, and the DGK strongly-regular-graph family closed analytically at [routes.md](../routes.md) R15) report no diagonal critical point in the band other than the balanced product, and that those are searches rather than proofs.

## 14. Repairs owed, in the order a reader is misled

1. **[problem.md:456](../findings/problem.md) and [problem.md:462](../findings/problem.md)**, delete or condition the two sentences the block twenty lines below calls false. A file that refutes itself at six lines' distance misleads every reader who stops at the section.
2. **[references/…/notes.md](../references/jaeger-2016-diagonal-case/notes.md)**, move *"Where the dimension threshold actually comes from"* under an explicit *"this record's claim about the source"* heading, and correct the two sentences. [r498](../reviews/REVIEW_r498.md) asked for this and it is unactioned.
3. **[findings/INDEX.md:19](../findings/INDEX.md) and [findings/LEDGER.md:19](../findings/LEDGER.md)**, the proof is at [problem.md:468](../findings/problem.md), and the ledger row is [INDEX-results.md:16](../findings/INDEX-results.md). Both clauses are false as printed.
4. **[findings/LEDGER.md:52](../findings/LEDGER.md)**, *"NEVER AUDITED … Do not spend reviewers on it"* contradicts [r497](../reviews/REVIEW_r497.md)/[r498](../reviews/REVIEW_r498.md) and [INDEX-results.md:16](../findings/INDEX-results.md).
5. **The $m\ge8$ sentence**, at all five sites in §10's list, it asserts of the source something the source's own line refutes.
6. **"Valid at every $n\ge2$"**, at four sites, say $n\ge4$, which is what [JaegerRounding.lean](../lean/HamiltonsCubic/Results/JaegerRounding.lean)'s theorem proves and what the denominators allow.
7. **Write $\mathop{\mathrm{tr}}S^2=1$ and $\mathop{\mathrm{supp}}\mu\subseteq(0,1]$ into the braces of $F(v)$**, rather than into the paragraph after it.
8. **Say that $n=14$ has no E5a certificate**, wherever *"both dimensions are machine-checked"* appears.
9. **Table $S$, $E(n)$, $F$ and $\lambda$** in [conventions.md](../findings/conventions.md).
