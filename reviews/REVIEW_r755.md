# Reviewer r755, L172: whether Jäger's Assumption 1 binds at $n=12,14$

**Cold review.** The brief [BRIEF-g2-l172.md](BRIEF-g2-l172.md) was read first and in full; the source [diss_jaeger_florian.pdf](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) and its layout extraction [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) were read directly, and [notes.md](../references/jaeger-2016-diagonal-case/notes.md) was left unread. The record's own finding for L172 was left unread until every verdict below had been formed. **No numerical work was done.** One screen was run, five integer evaluations of the two quartics the source itself displays, in exact integer arithmetic, to confirm a claim I was about to record; it is reported as a screen in §3 and the same values are recomputable by hand. Every value in this report is exact. Log: [agent_logs/g2-l172-r755.log](../agent_logs/g2-l172-r755.log).

## Claim table

| # | Claim as the record states it | Verdict |
|---|---|---|
| 1 | *"In Jäger's Chapter 3 the hypothesis $m\ge8$ is invoked at exactly one step"* | **REFUTED** |
| 2 | *"So Assumption 1 does not bind at $n=12$ or $n=14$"* | **REFUTED** |
| 3 | *"the unnumbered Result 5b that was supposed to remove it is not required for this purpose"* | **REFUTED, does not follow** |
| 4 | *"The separate $n\ge15$ pair inside Lemma 3.5.6 is a different hypothesis and is untouched"* | **REFUTED, it is the same hypothesis, exactly** |
| 5 | *"Every other constraint in $m$ is $m\ge2$ or $m\ge3$"* | **REFUTED**, the binding ones are written in $n$ and in $k$, and reach $m\ge8$ |
| 6 | *"that step needs only $m\ge5$"* (the displayed choice of $l$, taken alone) | **CONFIRMED**, and $m\ge4$ suffices in the branch it sits in |
| 7 | $\#A=m(m-1)$, and it is not the count the choice needs | **CONFIRMED** |
| 8 | $\lvert A_k\rvert=m$, $k\in A_k$ | **CONFIRMED for the final configuration; WRONG in the branch where the step occurs** |
| 9 | *"$a\ne c$ and $a\ne d$ can be assumed"* is genuinely without loss of generality | **CONFIRMED**, and it does not change the count |
| 10 | The worst case is $a,b,c,d$ all in one block | **CONFIRMED** |
| 11 | The induction from $s$ vectors to $s-1$ | **HYPOTHESIS-DEBT, no argument on file, in the source or in the record** |
| 12 | $m\ge8$ is unused outside Chapter 3 | **CONFIRMED** |
| 13 | Theorem 3.0.2's $m\ge8$ is inherited from Assumption 1 | **CONFIRMED, one constraint, stated twice** |
| 14 | [L172.lean](../lean/HamiltonsCubic/Results/L172.lean) states what the lemma needs | **REFUTED**, four arithmetic tautologies, and the docstring records the fatal error as a disclaimer |

**Overall verdict: BROKEN.**

**One-line actionable summary.** Under Assumption 1 $n=2m$, so the $n\ge15$ that Lemma 3.5.6 consumes twice *is* $m\ge8$ and nothing else, and the two quartics it turns on are **positive at $n=12$ and at $n=14$**, so Assumption 1 binds at exactly the two dimensions the lemma claims it does not; withdraw L172 and reinstate the requirement that Result 5b, or some replacement for Lemma 3.5.6, be supplied.

## 0. Conventions, fixed once

Line numbers cite the layout extraction [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf). Chapter 3 begins at line 1635 and ends at line 5107, the bibliography starting at line 5108. $m$ and $n$ are the source's, tied by $n=2m$ from Assumption 1 onward, this tie is the axis of the whole review. $\mathfrak k=\operatorname{Im}(I_+)$, $A\subset\{(1,2),\dots,(n-1,n)\}$ is the index set with $\mathfrak k=\bigoplus_{(i,j)\in A}\langle e_i\wedge e_j\rangle$ (line 5046), and $A_k:=\{j\in\{1,\dots,n\}\mid e_k\wedge e_j\in\mathfrak k\}$ (line 5052). The bracket is the source's own (line 5061):

$$[e_a\wedge e_b,\;e_c\wedge e_d]=\delta_{bc}\,e_a\wedge e_d-\delta_{ac}\,e_b\wedge e_d+\delta_{ad}\,e_b\wedge e_c-\delta_{bd}\,e_a\wedge e_c.$$

## Hypothesis inventory

The lemma under review is a statement *about* Jäger's Chapter 3, so its hypotheses are the source's.

| Hypothesis | Where it enters | Used? |
|---|---|---|
| $m\ge8$ an integer | Assumption 1, line 1705; restated in Theorem 3.0.2, line 1668 | **Yes, in Lemma 3.5.6, sharply, and there only** |
| $n=2m$ | Assumption 1, line 1705 | **Yes, it is what converts every $n$-constraint in Chapter 3 into an $m$-constraint, and the lemma's census ignores it** |
| $\theta\ge\theta_0(n)$ | Assumption 1 | Yes, at the end of §3.5 and in §3.6 |
| $W\in\langle\mathcal W\rangle^n_d$, $\lVert W\rVert=1$, $W^2+W^\#=\theta W$ | Assumption 1 | Yes throughout |
| Assumption 2 ($\operatorname{scal}\le(n-3)\tilde\theta_0(n)$) | line 2212 | Yes, the contradiction hypothesis of §§3.3–3.5 |

Unused by the lemma as the record states it: **$n=2m$**. That omission is the whole defect.

## 1. What the census actually is, and why a census of the string is the wrong census

The record's census is of the literal string $m\ge8$, and as a census of that string it is accurate. I checked it: across lines 1635–5107 the string occurs at exactly three places, Theorem 3.0.2 (line 1668), Assumption 1 (line 1705), and the choice of $l$ inside the proof of Theorem 3.0.2 (line 5080). There is no fourth occurrence, and the extraction renders the inequality consistently, so the string search is not defeated by typography.

**But Chapter 3 is not written in $m$.** From Notation 3.0.3 onward the entire apparatus, $\theta_0(n)$, $\tilde\theta_0(n)$, $\hat\theta_0(n)$, $\operatorname{tr}S^3$, $\operatorname{tr}S^4$, $\bar\lambda$, every estimate of §§3.2–3.5, is written in $n$. Assumption 1 supplies $n=2m$ as a standing identity, so **every dimension threshold Chapter 3 asserts in $n$ is a threshold in $m$**, consumed silently by every result that says "let assumption 1 hold". The record's own brief anticipates exactly this trap (*"enumerate what Chapter 3's results assume, not what its prose spells"*) and the census does not do it.

Enumerating the thresholds instead of the spellings, the $n$-constraints Chapter 3 actually consumes are, in ascending order of what they cost in $m$:

| Threshold in the source | Location | Cost in $m$, via $n=2m$ |
|---|---|---|
| $n\ge2,3,4,5,6$ | passim (lines 2524, 2602, 3386, 3542, 4051, …) | $m\ge3$ |
| $n\ge7$, $n\ge8$, $n\ge9$ | Lemma 3.6.7 (line 4835), Corollary 3.4.15 (line 3541), Lemma 3.5.5 (line 4113), Lemma 3.6.4 (line 4694) | $m\ge5$ |
| $k\ge12$, applied at $k:=n$ | Lemma 3.5.4 (lines 3894, 3934, 3963), applied in Lemma 3.5.5 (line 4100) | $m\ge6$ |
| **$n\ge15$, twice** | **Lemma 3.5.6, Case 1 (line 4341) and Case 2 (line 4397)** | **$m\ge8$** |

The maximum is $n\ge15$. Under $n=2m$ that is $2m\ge15$, i.e. $m\ge7.5$, i.e. **$m\ge8$**, exactly Assumption 1, with nothing to spare. It is also exactly why Theorem A in the introduction (line 113) reads *"let $n\ge16$ be an even integer"*: $16=2\cdot8$.

**So the answer to "where is $m\ge8$ invoked" is: in Lemma 3.5.6, where it is spelled $n\ge15$, and where it is sharp.** The single occurrence the census found (the choice of $l$), is the one place the hypothesis is invoked *by name* and, as §4 shows, the one place it is not needed.

Claims 1 and 5 are **REFUTED**.

## 2. Claim 4: the $n\ge15$ in Lemma 3.5.6 is not a separate hypothesis

The record's scope clause says the $n\ge15$ pair *"is a different hypothesis and is untouched"*. Lemma 3.5.6 reads, at line 4178:

> **Lemma 3.5.6.** Let assumption 1 hold. Then $\operatorname{scal}\ge(n+1)\tilde\theta_0(n)$.

**It has exactly one hypothesis: Assumption 1.** There is no separate hypothesis to be different from. The $n\ge15$ appears inside the proof, as the range on which the two quartics are negative, and the only thing in scope that could supply it is $m\ge8$ together with $n=2m$. Reading it as "different and untouched" inverts the logical relation: it is not a side condition sitting beside $m\ge8$, it is **the consumption of $m\ge8$**, and it is the only one in the chapter.

Arguing the opposite, as the brief requires. The strongest reading the record's words support is that $n\ge15$ and $m\ge8$ are formally distinct inequalities, so that a proof of Chapter 3 at $m=6$ would leave $n\ge15$ standing as an independent obstruction to be dealt with separately. That reading is coherent as bookkeeping and useless as mathematics: the two inequalities are equivalent over the integers with $n=2m$, since $2m\ge15\iff m\ge8$. There is no configuration in which one holds and the other fails. The distinction the record draws has no models.

Claim 4 is **REFUTED**.

## 3. Claim 2: the two dimensions at issue are exactly the two the proof fails at

Lemma 3.5.6's proof reduces, in each of its two boundary cases, to the sign of an explicit quartic in $n$ with integer coefficients. From the source verbatim:

**Case 1** (line 4337): multiplying through by $88n^3(n-1)$,
$$g(n)=-40n^4+588n^3+127n^2-943n+573,$$
and the contradiction is *"$g(n)<0$ for all $n\ge15$"*.

**Case 2** (line 4393): multiplying through by $72n^3(n+1)(n-1)$,
$$h(n)=-662n^4+13111n^3-54261n^2+98703n-67311,$$
and the contradiction is *"$h(n)<0$ for all $n\ge15$"*.

**Screen** (exact integer arithmetic, five evaluations, on the two polynomials just transcribed; run to check a claim I was about to record, and reproducible by hand):

| $n$ | $g(n)$ | $h(n)$ | contradiction available? |
|---|---|---|---|
| $12$ | $+194169$ | $+2232117$ | **no** |
| $14$ | $+89095$ | $+1224567$ | **no** |
| $15$ | $-25497$ | $-59616$ | yes |
| $16$ | $-194995$ | $-2061055$ | yes |
| $18$ | $-745077$ | $-8901981$ | yes |

Two independent confirmations that the transcription is faithful: the source itself states $g(15)=-25497$ (line 4340) and $h(15)=-59616$ (line 4396), and both match.

**Both quartics are positive at $n=12$ and at $n=14$, and both change sign between $14$ and $15$.** So the threshold $n\ge15$ is not slack padding around a weaker true bound, it is the exact integer threshold at which the argument as written first works, in *both* cases independently. The two dimensions the lemma under review claims are free, $n=12$ and $n=14$, are precisely the two even dimensions below it.

What this does and does not show. It shows that **Lemma 3.5.6's proof fails at $n=12$ and $n=14$**, hence that Assumption 1 binds there in the strongest available sense: remove $m\ge8$ and Chapter 3 has a step with no argument. It does **not** show that Theorem A is false at $n=12,14$, $g(n)<0$ is a sufficient condition reached through a chain of lossy estimates (the $\tfrac{263}{144}\ge\tfrac{20}{11}$, $2\sqrt3\le\tfrac{305}{88}$, $x\le\tfrac{n-2}{n}$ replacements at line 4332, and their Case 2 analogues at line 4386), so a sharper accounting could conceivably recover the two dimensions. That is a research task nobody on this record has performed, and it is the opposite of *"Assumption 1 does not bind"*.

Claim 2 is **REFUTED**.

## 4. Claim 6: the displayed step, and how many indices $l$ must avoid

Here the record is right, and its reasoning needs one correction.

The step is at line 5079. In the branch under discussion, $\mathfrak i\ne\{0\}$ is an ideal in $\mathfrak k$ containing $x=x_1e_a\wedge e_b+x_2e_c\wedge e_d$ with $(a,b),(c,d)\in A$, and one chooses $l\in A_k$, $l\notin\{a,b,c,d\}$, and forms $[e_l\wedge e_a,x]$.

Working the bracket out from the source's own formula:

$$[e_l\wedge e_a,\;e_a\wedge e_b]=\delta_{aa}e_l\wedge e_b-\delta_{la}e_a\wedge e_b+\delta_{lb}e_a\wedge e_a-\delta_{ab}e_l\wedge e_a=e_l\wedge e_b$$

provided $l\ne a$ and $l\ne b$ (the last also being what keeps $e_l\wedge e_b\ne0$, so the conclusion $\mathfrak i\ni x_1e_l\wedge e_b\ne0$ is nontrivial), and

$$[e_l\wedge e_a,\;e_c\wedge e_d]=\delta_{ac}e_l\wedge e_d-\delta_{lc}e_a\wedge e_d+\delta_{ld}e_a\wedge e_c-\delta_{ad}e_l\wedge e_c,$$

which vanishes iff $a\notin\{c,d\}$ **and** $l\notin\{c,d\}$. So $l$ must avoid **exactly** $\{a,b,c,d\}$, four indices, no more. The record's count is right.

**Two further requirements the record does not state, both satisfied.** First, $e_l\wedge e_a$ must itself lie in $\mathfrak k$ for $[e_l\wedge e_a,x]$ to lie in the ideal $\mathfrak i$; this holds because $l\in A_k$ gives $A_l=A_k$ (line 5052), and $a\in A_k$ because $(a,b)\in A$, so $a\in A_l$, i.e. $e_l\wedge e_a\in\mathfrak k$. Second, $l$ must lie in $A_a$, not merely in $A_k$, again free, since $A_l=A_k=A_a$. **So $l$ must share a block with $a$**, which is the brief's attack item 3 answered: the constraint is exactly "an index of $a$'s block, outside four".

**The correction.** The record derives sufficiency from $\lvert A_k\rvert=m$. That value is established at line 5098, from $\dim\mathfrak i_a=\tfrac{m(m-1)}2$, and it holds in the **final** configuration $\mathfrak k=\mathfrak i_a\oplus\mathfrak i_c$. The step under review sits somewhere else: inside *"Assume now that there exists $1\le k\le n$ with $\mathfrak i_k=\mathfrak k$"* (line 5074), where the source's very next sentence records $\{(a,b)\mid a,b\in A_k,\ a<b\}=A$. In that branch $\binom{\lvert A_k\rvert}2=\#A=m(m-1)$, so $\lvert A_k\rvert(\lvert A_k\rvert-1)=2m(m-1)$ and $\lvert A_k\rvert=\tfrac{1+\sqrt{1+8m(m-1)}}2\approx\sqrt2\,m$, larger than $m$, not equal to it. The record's stated value is the wrong one for the branch the step is in.

It does not change the conclusion, and makes it weaker still: $\lvert A_k\rvert\ge5$ holds as soon as $\binom52=10\le m(m-1)$, i.e. **$m\ge4$**. Under either reading ($\lvert A_k\rvert=m$ giving $m\ge5$, or the branch's own count giving $m\ge4$), the step is a very long way below $8$.

*Aside, recorded because it bears on the source's shape and not on the verdict:* for $m\ge4$ the equation $\lvert A_k\rvert(\lvert A_k\rvert-1)=2m(m-1)$ has no integer solution ($1+8m(m-1)$ is $97,161,241,337,449,577,721$ at $m=4,\dots,10$, none a square), so the branch's hypothesis is already refutable by counting alone. The source instead refutes it by the simplicity argument. Both routes end in a contradiction, so nothing is lost.

Claim 6 is **CONFIRMED**; claim 8 is **CONFIRMED for the final configuration and wrong in the branch cited**.

## 5. Claim 9: the "without loss of generality"

The source writes *"Without loss of generality, $a\ne c$ and $a\ne d$ can be assumed"* (line 5079). It is genuine. The two pairs $(a,b),(c,d)\in A$ are distinct, so they share at most one index, and $e_a\wedge e_b=-e_b\wedge e_a$ lets either index of a pair play the role of $a$, while $x$ is symmetric under swapping its two terms.

- **Pairs disjoint.** Any naming satisfies $a\notin\{c,d\}$.
- **Pairs share exactly one index $s$.** Write the pairs as $\{p,s\}$ and $\{s,q\}$ with $p\ne q$ (else the pairs coincide). Take $a:=p$, $b:=s$; then $\{c,d\}=\{s,q\}$ and $a\notin\{c,d\}$ since $a\ne s$ and $a\ne q$.

It costs no extra index: the set $\{a,b,c,d\}$ that $l$ must avoid has $4$ elements in the disjoint case and $3$ in the shared case, so the count is $\le4$ either way. Claim 9 is **CONFIRMED**, and the count is unchanged.

## 6. Claim 10: whether $a,b,c,d$ can lie in different blocks, and which case is worst

In the final configuration $A$ is the set of within-block pairs of two blocks of size $m$, so $(a,b)$ lies inside one block and $(c,d)$ inside one block, possibly the other one.

- **All four in one block.** $l$ must lie in $A_a$ (that block, $m$ indices) and avoid up to $4$ of them: needs $m\ge5$.
- **$(c,d)$ in the other block.** Then $a\notin\{c,d\}$ is automatic (the "without loss of generality" costs nothing) and $l\in A_a$ automatically avoids $c,d$, so $l$ need only avoid $\{a,b\}$: needs $m\ge3$.

So the split case is **strictly easier**, and the record correctly takes all four in one block as the worst case. Claim 10 is **CONFIRMED**.

*A remark on scope.* In the branch where the step actually sits there is only one relevant index set $A_k$ and the split case does not arise, so the worst case is the only case there; the analysis above is the one that applies once $\mathfrak k\cong\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ is in force. Both give a threshold far below $8$.

## 7. Claim 11: the induction, which is where the source is thinnest

The source continues (line 5081):

> Analogously, if any ideal $\mathfrak i$ in $\mathfrak k$ contains a linear combination of $s$ different basis vectors of the form $e_a\wedge e_b$ for $(a,b)\in A$ and $1\le s\le n$, **it can be shown that** $\mathfrak i$ also contains a linear combination of $s-1$ vectors of that form.

**This claim has no argument on file**, neither in the source, which asserts it, nor in the record, which does not address it. Per the brief, that is the finding, full stop.

What can be said about the shape of the missing argument, because it bears on whether the record's $m\ge5$ is the right threshold for the whole passage. Take $x=\sum_{i=1}^{s}x_ie_{a_i}\wedge e_{b_i}$ and bracket with $e_l\wedge e_{a_1}$. For the two middle $\delta$-terms of every $i\ge2$ to die, $l$ must avoid $\{a_i,b_i\}$ for all $i$, up to $2s$ indices, and $s$ ranges up to $\#A=m(m-1)$. The threshold demanded by the naive analogue is therefore $\lvert A_k\rvert>2s$, not $\lvert A_k\rvert>4$.

**This cuts against the record's framing without rescuing $m\ge8$.** In the branch the step lives in, $\lvert A_k\rvert\approx\sqrt2\,m$ while $2s$ reaches $2m(m-1)$, so **$m\ge8$ does not make the naive induction work either**, the gap is quadratic in $m$ and no constant threshold closes it. Whatever repairs this passage, it is not the hypothesis the census is arguing about. The honest statement is that the source's induction is unproved at every $m$, and that the record's *"that step needs only $m\ge5$"* is a claim about one displayed line and not about the passage it opens.

I note without pursuing it that a repair exists in the literature-standard direction (an ideal of a direct sum of simple ideals is a sub-sum), but building it is not this review's job.

Claim 11 is **HYPOTHESIS-DEBT**. What would have to be proved: *for every ideal $\mathfrak i\ne\{0\}$ of $\mathfrak k=\bigoplus_{(i,j)\in A}\langle e_i\wedge e_j\rangle$ and every $x\in\mathfrak i$ with $s\ge2$ nonzero coordinates, $\mathfrak i$ contains some $y\ne0$ with at most $s-1$ nonzero coordinates.*

## 8. Claims 12 and 13: the reach of $m\ge8$

**Outside Chapter 3.** Assumption 1 is introduced at line 1705, inside Chapter 3, as *"the following will be supposed to be true for the rest of the present work"*. Everything after line 1705 is Chapter 3 and the bibliography. Chapters 1 and 2 precede it; I checked their thresholds and they are of the shape *"for a prime $p$ with $4\mid p-1$"* and *"for integers $3\le n<m$"*, unrelated. So $m\ge8$ has no life outside Chapter 3. **CONFIRMED.**

**Theorem 3.0.2's own $m\ge8$.** Theorem 3.0.2 (line 1668) states $m\ge8$; Assumption 1 (line 1705) restates the identical hypothesis and the proof of 3.0.2 runs entirely under Assumption 1, concluding at line 5100 (*"which concludes the proof of theorem 3.0.2"*). It is one constraint written twice, inherited rather than independent. **CONFIRMED**, and this matters, because it means lowering Assumption 1 to $m\ge5$ would lower Theorem 3.0.2 to $m\ge5$, and Theorem 3.0.2 at $m=6,7$ is precisely what Lemma 3.5.6 cannot deliver.

## 9. Claim 3: whether Result 5b is dispensable

The record concludes that *"the unnumbered Result 5b that was supposed to remove it is not required for this purpose"*. It fails twice over, once through each of the two things Result 5b is supposed to cover.

**Through the census.** The conclusion is an inference from claims 1 and 2, both refuted in §§1–3, so it inherits their fate. Stated positively: **Jäger's Chapter 3 at $n=12$ and $n=14$ requires a replacement for Lemma 3.5.6**, because both quartics are positive there. §12 records what the surrounding record does about that and why it does not rescue L172's sentence.

**Through what Result 5b actually replaces.** [Lemma L1](../findings/problem.md) describes Result 5b as *"this record's own replacement for that step, the six-line graph argument"*, the step being the **§3.6 ideal-induction step**, not the single displayed choice of $l$, but the induction that choice opens. §7 shows that induction is asserted in the source with *"it can be shown"* and carries no argument at any $m$: the naive analogue of the displayed bracket demands a free index outside up to $2s$ others, with $s$ ranging to $\#A=m(m-1)$, a gap quadratic in $m$ that no constant threshold closes. **So establishing $m\ge5$ for the displayed line does not discharge the step Result 5b stands in for.** A replacement is still required, for the induction, and now visibly *not* because of $m\ge8$, which was never what made the induction work.

**REFUTED.**

## 10. Claim 14: the machine-checked statement

[L172.lean](../lean/HamiltonsCubic/Results/L172.lean) carries four theorems. Each is true and each is trivial:

| Statement | What it says | What the lemma needs it to say |
|---|---|---|
| `free_index_exists (m : ℕ) (hm : 5 ≤ m) : 1 ≤ m - 4` | $5\le m\Rightarrow1\le m-4$ in $\mathbb N$ | that $A_k$ has an element outside $\{a,b,c,d\}$, $A_k$ does not appear |
| `threshold_dimensions : (5:ℕ) ≤ 6 ∧ (5:ℕ) ≤ 7` | $5\le6$ and $5\le7$ | that $n=12,14$ are admissible, nothing about $n$ appears |
| `pair_count (m : ℚ) : 2 * (m * (m-1) / 2) = m * (m-1)` | a ring identity over $\mathbb Q$ | that $\#A=\dim\mathfrak k=m(m-1)$, no $A$, no $\mathfrak k$ |
| `cited_count_is_larger (m : ℕ) (hm : 3 ≤ m) : m ≤ m * (m-1)` | $m\le m(m-1)$ for $m\ge3$ | that the cited count exceeds the needed one, the needed count is not defined |

**None of the four can be false, and none of the four could have caught the defect.** The load-bearing content of L172 is a negative census over a document, and no statement here quantifies over anything in that document. The file is a certificate that $5\le6$; it is not evidence about Jäger's Chapter 3.

**The docstring is worse than the statements**, and the brief is right that it is part of what I audit. It reads:

> **What is not.** The reading of the source, which is prose, and the separate `n ≥ 15` constraint inside Lemma 3.5.6, **which this lemma leaves untouched**.

That sentence is the defect, written down and filed as a disclaimer. The $n\ge15$ constraint is not separate and cannot be left untouched: under $n=2m$ it **is** the $m\ge8$ the lemma claims to have eliminated. A reader auditing the Lean file would read the exclusion as a scoping decision and move on, which is the failure mode the disclaimer creates.

The docstring also asserts *"a block of size $m$"* for $A_k$ at the step, which §4 shows is the wrong set in that branch.

**REFUTED.**

**Addendum, written at the end of this review.** [L172.lean](../lean/HamiltonsCubic/Results/L172.lean) was rewritten on disk while I was drafting §12, the audit above is of the version the brief quotes, and the replacement now states `thresholds_agree (m : ℕ) : 15 ≤ 2 * m ↔ 8 ≤ m`, which is the identity §1 turns on, and records $g$ and $h$ positive at $n=12,14$ with the same four integers I screened independently in §3. The docstring's *"leaves untouched"* is gone. Two remarks on the replacement, neither a blocker: `g_positive` and `h_positive` assert that four numerals are positive rather than that $g(12)=194169$, so the link from the polynomial to the numeral still lives in prose; and `free_index_exists` is retained and labelled *"true and idle"*, which is the right label given §4, though the file states it against a block of size $m$, and §4's correction (the branch's $A_k$ is not that block) has not reached it.

## 11. What would break the record's claim, and what did

The brief asks me to name what, in the source, would show $m\ge8$ genuinely needed. The answer is the one that materialised: **a threshold in $n$, at or above $15$, consumed by a result whose only hypothesis is Assumption 1.** Lemma 3.5.6 is exactly that, twice over, and the thresholds are sharp integers rather than round numbers, which is the signature of a bound that was pushed as low as the estimates allowed.

The converse (what would have saved the record's claim), is also worth stating: if the maximum $n$-threshold in Chapter 3 had been $n\ge12$ (the $k\ge12$ of Lemma 3.5.4, applied at $k=n$), the claim would have survived at $n=12,14$ with $m\ge6$ substituted for the stated $m\ge5$. It is the two quartics of §3.5, and nothing else, that decide the matter.

## 12. What the surrounding record already knows, read after every verdict above was fixed

Per the brief I formed all fourteen verdicts before opening [problem.md](../findings/problem.md). Reading it afterwards changes nothing above and adds one thing worth recording, because it makes the defect sharper rather than softer.

**[Lemma L1](../findings/problem.md) already says what L172 denies.** Its opening line reads: *"**Two** dimension constraints carry Theorem A. One is a lemma needing a single quantity to be negative, which it bounds through a chain of rational roundings, enough accumulated slack to cost four dimensions … The other is **Assumption 1, $m\ge8$**."* The "chain of rational roundings" is exactly the chain of §3 above, and *"enough accumulated slack to cost four dimensions"* is exactly $15$ against $11$. So L1 knows Lemma 3.5.6 is the binding site and that its threshold is soft; and L1 closes it by **evaluating Jäger's RHS exactly at his own case endpoints** (this record's own work, licensed by the source's convexity $\mathrm{RHS}''\ge0$), plus a moment-body repair at $n=12$, with a validated interval certificate.

**That repair belongs to L1, not to Jäger's Chapter 3, and it is not what L172 claims.** L172 does not say *"Lemma 3.5.6's constraint is soft and L1 has already closed it, so the only remaining site is the ideal step"*; it says the hypothesis *"is invoked at exactly one step"* and that the $n\ge15$ pair *"is a different hypothesis and is untouched by this"*. The first is false about the source, and the second is false as arithmetic, $n\ge15$ under $n=2m$ **is** $m\ge8$, not a neighbour of it. Two consumption sites, one inequality.

**The practical consequence is smaller than the epistemic one, and both are real.** Because L1 carries its own repair of Lemma 3.5.6, the record is not left with Theorem A unsupported at $n=12,14$, it is left with L172 asserting, in the record's own voice and with a Lean file behind it, a census that a reader will take as licence to stop looking. The correct replacement sentence is available and costs one clause: *Chapter 3 consumes $m\ge8$ at two sites, Lemma 3.5.6, where it is spelled $n\ge15$ and where L1 has already closed it by exact endpoint evaluation, and the §3.6 ideal step, where only $m\ge5$ is needed.*

## Overall verdict

**BROKEN.** The census is a census of a string in a chapter written in a different variable; the constraint it is looking for is spelled $n\ge15$, sits in Lemma 3.5.6, is equivalent to $m\ge8$ under Assumption 1's own $n=2m$, and is sharp, the two quartics it turns on are positive at exactly $n=12$ and $n=14$. The subsidiary claims about the displayed choice of $l$ hold, with the set's size corrected; the induction that follows is unproved at every $m$; and the Lean file certifies arithmetic that has no bearing on any of it.
