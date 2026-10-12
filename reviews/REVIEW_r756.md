# r756, L172: whether Jäger's Assumption 1 binds at $n=12,14$

*Cold review of the brief [BRIEF-g2-l172.md](BRIEF-g2-l172.md): the source was read before the finding, and the finding's own text ([problem.md](../findings/problem.md) §L172) was opened only after every verdict below was fixed. **No numerical work was done.** Two integer polynomial evaluations appear, and both are exact-integer screens of a claim recorded here, checked against values the source itself prints. Log: [agent_logs/g2-l172-r756.log](../agent_logs/g2-l172-r756.log).*

| # | Claim as written | Verdict |
|---|---|---|
| C1 | *"the hypothesis $m\ge8$ of Assumption 1 is invoked at exactly one step"* of Chapter 3 | **REFUTED** |
| C2 | *"Every other constraint in $m$ is $m\ge2$ or $m\ge3$"* | **TRUE OF THE STRINGS, FALSE OF THE HYPOTHESES** |
| C3 | *"that step needs only $m\ge5$"* | **CONCLUSION SOUND, JUSTIFICATION CIRCULAR**, what is available there gives $m\ge4$ |
| C4 | $\#A=m(m-1)$ is the count the sentence cites and not the count the choice needs | **CONFIRMED** |
| C5 | $l$ must avoid at most four indices, and $\lvert A_k\rvert$ is the set it draws from | **CONFIRMED** |
| C6 | the source's *"$a\ne c$ and $a\ne d$ can be assumed"* is genuinely w.l.o.g. | **CONFIRMED, and it costs nothing in the count** |
| C7 | the induction from $s$ to $s-1$ that the sentence sits inside | **NO ARGUMENT ON FILE** |
| C8 | *"The separate $n\ge15$ pair inside Lemma 3.5.6 is a different hypothesis and is untouched"* | **REFUTED, it is not a hypothesis, and for even $n$ it *is* $m\ge8$** |
| C9 | **"So Assumption 1 does not bind at $n=12$ or $n=14$"** | **REFUTED** |
| C10 | *"Result 5b … is not required for this purpose"* | **OVERSTATED as the lemma's title reads it** |
| C11 | [lean/HamiltonsCubic/Results/L172.lean](../lean/HamiltonsCubic/Results/L172.lean) states what the lemma needs | **NO, the statements are true and idle, and the docstring carries C1 and C8 forward** |
| C12 | $m\ge8$ is used outside Chapter 3 | **NOT USED, the scope claim is confirmed** |

**Overall verdict: BROKEN.**

**Actionable summary.** Chapter 3 consumes $m\ge8$ at four places, only one of which spells it in $m$: the tight one is Lemma 3.5.6, whose two contradictions both read *"$g(n)<0$ for all $n\ge15$"* and *"$h(n)<0$ for all $n\ge15$"*, and $n=2m$ makes $n\ge15$ **exactly** $m\ge8$, with $g(12)=194169>0$, $g(14)=89095>0$, $h(12)=2232117>0$, $h(14)=1224567>0$, so the contradiction the lemma is built on is unavailable at both dimensions the finding claims to free.

---

## 0. Conventions, fixed once

- **The source** is [references/jaeger-2016-diagonal-case/](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), the `pdftotext -layout` extraction; line numbers below are absolute in that file. Chapter 3 runs from line 1635 to line 5106; the bibliography begins at line 5108.
- $n=2m$ throughout, $m$ a positive integer, so **$n$ is even** and every threshold in $n$ translates to $\lceil\cdot\rceil$ in $m$: $n\ge15\iff n\ge16\iff m\ge8$.
- $\mathfrak k=\operatorname{Im}(I_+)$, $A\subset\{(i,j):i<j\}$ with $\mathfrak k=\bigoplus_{(i,j)\in A}\langle e_i\wedge e_j\rangle$, $A_k:=\{j:e_k\wedge e_j\in\mathfrak k\}$, $\mathfrak i_k:=\bigoplus_{a,b\in A_k,\,a<b}\langle e_a\wedge e_b\rangle$, all as defined in the proof of Theorem 3.0.2 at lines 5046–5059.
- The bracket relation used throughout is the source's own (line 5061): $[e_a\wedge e_b,e_c\wedge e_d]=\delta_{bc}e_a\wedge e_d-\delta_{ac}e_b\wedge e_d+\delta_{ad}e_b\wedge e_c-\delta_{bd}e_a\wedge e_c$.
- All arithmetic below is over $\mathbb Z$ and exact.
- **Notation trap.** The extraction renders the Fraktur $\mathfrak k$ of the Lie algebra and the running index $k$ identically as `k`, and the source uses both in the same sentence. Section 3 disambiguates where it matters.

## 1. Hypothesis inventory for the lemma as stated

The lemma has no mathematical hypotheses of its own; it is a reading of a fixed text. What it *asserts* about that text, and what each assertion is worth, is the table above. Two premises are used implicitly and neither is stated:

- **P1.** *Every dimension constraint Chapter 3 imposes is written as a constraint in $m$.* This is the premise that makes a string census of "$m\ge8$" a census of invocations. **It is false**, §2.
- **P2.** *$\lvert A_k\rvert=m$ is available at the point of the sentence.* This is the premise that turns "avoid four indices" into "$m\ge5$". **It is available only as the conclusion of the passage the sentence belongs to**, §4.

**Unused hypotheses.** None; the lemma has none to leave unused. The one input it does not use, and should, is Lemma 3.5.6.

## 2. C1, C2, the census, which is the load-bearing claim

I enumerated every numeric threshold in $n$, $m$, $k$ or $s$ over lines 1635–5107, in both directions (`X ≥ c` and `c ≤ X`), rather than searching for the string $m\ge8$. Four are non-trivial consumptions of Assumption 1's dimension bound.

| Where | As written in the source | In $m$ | Binds at $n=12,14$? |
|---|---|---|---|
| Proof of Lemma 3.5.5, eq. (3.13), lines 4111–4113 | *"$16n^2-2(8n+9)(n-1)=-2n+18\le0$ for all $n\ge9$"* | $m\ge5$ | no |
| Proof of Lemma 3.5.5, line 4100, applying Lemma 3.5.4 with $k=n$ | Lemma 3.5.4's own *"Let $k\ge12$"* (line 3894) | $m\ge6$ | no |
| Proof of Lemma 3.5.6, Case 1, line 4341 | *"$g(n)<0$ for all $n\ge15$, which is a contradiction"* | $m\ge8$ | **YES** |
| Proof of Lemma 3.5.6, Case 2, line 4397 | *"$h(n)<0$ for all $n\ge15$, which is a contradiction"* | $m\ge8$ | **YES** |

Add to these the one the finding found, lines 5079–5081, inside the proof of Theorem 3.0.2, and the count of *invocations* is **five**, not one.

**C1 is refuted.** The census counted occurrences of a string. Chapter 3 states its results in $m$ and argues them in $n$, so a constraint that is invoked can be spelled either way, and the two Lemma 3.5.6 invocations are spelled in $n$.

**C2 is refuted in the sense it is used.** *"Every other constraint in $m$ is $m\ge2$ or $m\ge3$"* is literally true of the strings written with the letter $m$: the only others are Lemma 3.0.1 (line 1655), the odd-dimensional Remark (line 1687) and §3.1 (line 1775), all $m\ge2$. It is false as a statement about what Chapter 3 assumes, which is what the finding then infers from it.

**Arguing the opposite.** The strongest reading of the finding's sentence is that $n\ge15$ is a *separate* dimension constraint, so a census restricted to Assumption 1's own hypothesis is entitled to set it aside. §5 disposes of this: $n\ge15$ has no warrant in Chapter 3 other than Assumption 1.

## 3. C5, C6, what the step at lines 5079–5081 actually requires

The sentence, in full (lines 5077–5082):

> *Let $\mathfrak i\ne\{0\}$ now be any ideal in $\mathfrak k$ and suppose that there exists a linear combination $x=x_1e_a\wedge e_b+x_2e_c\wedge e_d$ in $\mathfrak i$ with $(a,b),(c,d)\in A$. Without loss of generality, $a\ne c$ and $a\ne d$ can be assumed. Further, choose $l\in A_k$ with $l\notin\{a,b,c,d\}$ which is possible because $m\ge8$ and $\#A=m(m-1)$ by lemma 3.6.7. Since $\mathfrak i$ is an ideal, $x_1e_l\wedge e_b=[e_l\wedge e_a,x]\in\mathfrak i$, which implies that $\mathfrak i=\mathfrak k$.*

**The bracket, computed.** With the source's own relation, and $l\notin\{a,b\}$, $a\ne b$:
$$[e_l\wedge e_a,\;e_a\wedge e_b]=\delta_{aa}e_l\wedge e_b-\delta_{la}e_a\wedge e_b+\delta_{lb}e_a\wedge e_a-\delta_{ab}e_l\wedge e_a=e_l\wedge e_b,$$
$$[e_l\wedge e_a,\;e_c\wedge e_d]=\delta_{ac}e_l\wedge e_d-\delta_{lc}e_a\wedge e_d+\delta_{ld}e_a\wedge e_c-\delta_{ad}e_l\wedge e_c=0\quad\text{when }a\notin\{c,d\}\text{ and }l\notin\{c,d\}.$$
So $[e_l\wedge e_a,x]=x_1\,e_l\wedge e_b$ exactly, and **the constraint on $l$ is $l\notin\{a,b,c,d\}$, four indices, no more.** C5's count is confirmed.

**And $e_l\wedge e_a$ must itself lie in $\mathfrak k$**, since $\mathfrak i$ is an ideal *in $\mathfrak k$* and the bracket is taken there. That is $(l,a)\in A$, i.e. $l\in A_a$. The source writes $l\in A_k$; under the assumption in force (§4) $A_a=A_k$, so the two agree. The brief's *"must $l$ share a block with $a$"* is answered **yes**, and the source's $A_k$ is the right set.

**C6, the w.l.o.g.** $(a,b)$ and $(c,d)$ are distinct elements of $A$, so $\{a,b\}$ and $\{c,d\}$ are distinct $2$-sets and $\lvert\{a,b\}\cap\{c,d\}\rvert\le1$. The available relabellings are $a\leftrightarrow b$ (absorbing the sign into $x_1$, since $e_b\wedge e_a=-e_a\wedge e_b$) and $c\leftrightarrow d$. If the sets are disjoint, $a\notin\{c,d\}$ already. If they meet in one index $p$, orient the first pair so that $b=p$; then $a\notin\{c,d\}$. **Genuinely without loss of generality**, and it does not change the count: the worst case remains $\#\{a,b,c,d\}=4$, and when the pairs overlap only three indices must be avoided. Confirmed.

## 4. C3, C4, why $m\ge5$, and the premise that is not available

**C4 is confirmed.** Lemma 3.6.7 (line 4797) gives $d_+=\tfrac{n(n-2)}4$, and $d_+=\operatorname{tr}I_+=\dim\mathfrak k=\#A$, so $\#A=\tfrac{2m(2m-2)}4=m(m-1)$, matching $\dim(\mathfrak{so}(m)\oplus\mathfrak{so}(m))=2\binom m2$. This is a count of **pairs**; the choice of $l$ is a choice of an **index** in $A_k$. The cited quantity is the wrong one, exactly as the finding says.

**C3's justification does not stand where it is placed.** The sentence sits inside a branch opened four lines earlier (lines 5074–5076): *"Assume now that there exists $1\le k\le n$ with $\mathfrak i_k=\mathfrak k$. In particular, $\{(a,b)\mid a,b\in A_k\text{ and }a<b\}=A$, which implies that for every $1\le j\le n$ either $\mathfrak i_j=\mathfrak k$ or $\mathfrak i_j=\{0\}$."* That branch closes only at line 5087 with *"which is of course a contradiction to $\mathfrak k\simeq\mathfrak{so}(m)\oplus\mathfrak{so}(m)$"*, and the step *"$x_1e_l\wedge e_b\in\mathfrak i$, which implies that $\mathfrak i=\mathfrak k$"* uses precisely the branch's dichotomy, since it needs $\mathfrak i\supseteq\mathfrak i_b\ne\{0\}\Rightarrow\mathfrak i_b=\mathfrak k$. So the sentence is inside the branch.

Inside the branch, $A$ is $\{$all pairs from $A_k\}$, so $\binom{\lvert A_k\rvert}2=\#A=m(m-1)$, and $\lvert A_k\rvert=m$ is **not** what holds there. The block decomposition into two sets of size $m$ (the finding's stated reason for $\lvert A_k\rvert=m$), is derived at lines 5097–5099, *"since $\dim(\mathfrak i_a)=\dim(\mathfrak i_c)=\tfrac{m(m-1)}2$, which implies $\#A_a=\#A_c=m$"*, from the conclusion of the very passage the sentence belongs to. **P2 is circular.**

**The conclusion survives with the right premise.** What the step needs is $\lvert A_k\rvert\ge5$. Inside the branch $\binom{\lvert A_k\rvert}2=m(m-1)$, so $\lvert A_k\rvert\ge5\iff m(m-1)\ge\binom52=10\iff m\ge4$. Outside the branch, on the block reading, $\lvert A_k\rvert=m$ and the requirement is $m\ge5$. **Either way the step is far short of $m\ge8$**, so C3's *conclusion* is sound and only its *reason* is wrong, and the honest bound is $m\ge4$, not $m\ge5$.

**Item 4 of the brief, on whether $a,b,c,d$ may lie in different blocks.** On the block reading, if $\{a,b\}$ and $\{c,d\}$ lie in different blocks then $l$ ranges over $A_a$, which contains neither $c$ nor $d$, so only two indices must be avoided and $m\ge3$ suffices. **All four in one block is therefore the worst case**, and the finding takes it correctly. Inside the branch the question does not arise: there is a single $A_k$ and all four lie in it.

## 5. C8, the $n\ge15$ pair, which is the claim that breaks the lemma

**Lemma 3.5.6 has exactly one hypothesis** (line 4178): *"Let assumption 1 hold. Then $\operatorname{scal}\ge(n+1)\tilde\theta_0(n)$."* There is no dimension hypothesis to be *"separate"* from Assumption 1. The $n\ge15$ of its proof is a **step**, and its only warrant is $n=2m\ge16$ from Assumption 1's $m\ge8$.

Both cases of the proof reduce to the sign of a quartic and both close the same way.

- **Case 1**, line 4337: $0\le-40n^4+588n^3+127n^2-943n+573=:g(n)$, then *"$g(15)=-25497$, $g'(15)=-140233$, and $g''(n)=-480n^2+3528n+254\le0$ for $n\ge8$, which implies that $g$ is monotonically decreasing on $[15,\infty)$. Thus, $g(n)<0$ for all $n\ge15$, which is a contradiction."*
- **Case 2**, line 4393: $0\le-662n^4+13111n^3-54261n^2+98703n-67311=:h(n)$, then *"$h(15)=-59616$, $h'(15)=-1616202$, and $h''(n)=-7944n^2+78666n-108522\le0$ for $n\ge9$ … $h(n)<0$ for all $n\ge15$, which is a contradiction."*

**Screen of the transcription** (integer arithmetic, exact; this is a screen of a claim recorded here, not evidence for a positive claim). My $g$ and $h$ reproduce the source's own printed values: $g(15)=-25497$, $g'(15)=-160\cdot3375+1764\cdot225+3810-943=-140233$, $h(15)=-59616$, $h'(15)=-2648\cdot3375+39333\cdot225-1627830+98703=-1616202$. All four match the text, so the polynomials are transcribed correctly. Then

| $n$ | 12 | 13 | 14 | 15 | 16 |
|---|---|---|---|---|---|
| $g(n)$ | $194169$ | $159173$ | $89095$ | $-25497$ | $-194995$ |
| $h(n)$ | $2232117$ | $1943204$ | $1224567$ | $-59616$ | $-2061055$ |

**Both quartics are positive at $n=12$ and $n=14$ and negative from $n=15$**, so each threshold is sharp at exactly the place the source puts it, and at $n=12,14$ neither case yields a contradiction: Assumption 2 stands, Lemma 3.5.6 fails, and with it Lemma 3.6.3 (line 4495, *"by lemma 3.5.6"*) and everything §3.6 builds on it.

**$n\ge15$ is $m\ge8$, not a weaker cousin of it.** For even $n$, $n\ge15\iff m\ge7.5\iff m\ge8$. The coincidence of *both* sharp thresholds with the stated hypothesis is the reason Assumption 1 says $8$: **this is where the $8$ comes from.** C8 is refuted on both halves, $n\ge15$ is not a hypothesis, and it is not separate.

## 6. C9, C10, the conclusion and its corollary

**C9 is refuted.** *"Assumption 1 does not bind at $n=12$ or $n=14$"* is exactly the assertion §5 falsifies. What §§3–4 do establish is the narrower true statement: **the one step where Chapter 3 spells $m\ge8$ out does not bind at $n=12,14$; the step that does is Lemma 3.5.6's, and there $m\ge8$ is tight.**

**C10 is overstated as the lemma's title reads it**, *"so [L1](../findings/problem.md) needs no Result 5b for it"*. The reading under which C10 survives is the narrow one: whatever Result 5b was to do about the *index-choice* step is unnecessary, because that step needs $m\ge4$. But the finding's own closing note concedes the $n\ge15$ constraint and says the record closes it *"by exact interval arithmetic rather than by argument"*, and [problem.md](../findings/problem.md) line 462 already carries a scope note saying a census of Chapter 3 finds **two** dimension hypotheses carrying Theorem A. **The record therefore contradicts itself between line 462 and line 624**, and line 624's census is the wrong one.

## 7. C12, scope outside Chapter 3

Assumption 1 is declared at line 1705, inside Chapter 3, and Chapter 3 is the last chapter before the bibliography (line 5108). No result in Chapters 1 or 2 can assume it, and none does. **The scope claim is confirmed.**

**Is Theorem 3.0.2's own $m\ge8$ independent of Assumption 1's?** No. Theorem 3.0.2 (line 1668) states the hypotheses; Assumption 1 (line 1705) repackages them verbatim as standing hypotheses (*"The following will be supposed to be true for the rest of the present work"*) and the proof of 3.0.2 runs under Assumption 1. They are one constraint written twice, so neither is independent evidence for the other, and the finding is right to treat them as one.

## 8. C7, the induction, which has no argument on file

The sentence the finding audits is a base case. What follows it is one sentence (lines 5082–5086):

> *Analogously, if any ideal $\mathfrak i$ in $\mathfrak k$ contains a linear combination of $s$ different basis vectors of the form $e_a\wedge e_b$ for $(a,b)\in A$ and $1\le s\le n$, it can be shown that $\mathfrak i$ also contains a linear combination of $s-1$ vectors of that form.*

**This claim has no argument on file** (*"it can be shown"* is the whole of it) so there is nothing here to audit, and the verdict on C7 is that.

What can be said about the shape of the gap, since the brief asks whether the bound accumulates. Take $x=\sum_{t=1}^s x_t\,e_{a_t}\wedge e_{b_t}$ and the literal extension of the base case, bracketing with $e_l\wedge e_{a_1}$ for an $l$ outside the support of $x$. Killing every $t\ge2$ needs $a_1\notin\{a_t,b_t\}$ **and** $l\notin\{a_t,b_t\}$ for all $t\ge2$, so $l$ must avoid up to $2s$ indices and the requirement is $\lvert A_k\rvert\ge2s+1$. Since $s$ runs up to $\#A=m(m-1)$ while $\lvert A_k\rvert$ is $m$ (block reading) or $O(m)$ (branch reading), **the literal extension fails for every $m$**, not past some threshold. So the induction supplies no support for $m\ge8$ either: raising $m$ does not repair it. The conclusion the induction is reaching for is true ($\mathfrak{so}(N)$ is simple for $N\ge5$) but that theorem is not what the page argues, and it is not what the finding checked.

This does not change the verdict on C1 or C9, which §§2 and 5 settle on their own.

## 9. C11, the machine-checked statement

[lean/HamiltonsCubic/Results/L172.lean](../lean/HamiltonsCubic/Results/L172.lean), state `partial`. I read it; I did not build it, since building is not a screen. Each of the four statements is elementary and visibly true. That is the difficulty.

| Declaration | What it says | Is it what the lemma needs? |
|---|---|---|
| `free_index_exists (m) (hm : 5 ≤ m) : 1 ≤ m - 4` | truncated-$\mathbb N$ arithmetic | A cardinality stand-in with no set, no $A_k$, no $\{a,b,c,d\}$. Honest as `partial`, but it does not carry the step. |
| `threshold_dimensions : (5:ℕ) ≤ 6 ∧ (5:ℕ) ≤ 7` | $5\le6$ and $5\le7$ | **Idle.** Neither $n$, nor $n=2m$, nor $12$, nor $14$ occurs in it. The link to the dimensions lives only in the docstring. |
| `pair_count (m : ℚ) : 2*(m*(m-1)/2) = m*(m-1)` | the cited count | Correct and correctly over $\mathbb Q$. It restates $\#A$, which §4 confirms is the count the step does **not** use. |
| `cited_count_is_larger (m) (hm : 3 ≤ m) : m ≤ m*(m-1)` | $m\le m(m-1)$ for $m\ge3$ | True. The `have h : 2 ≤ m - 1` is unused (the proof discharges the side goal with an inline `omega`) so it should go. |

**The docstring is the finding.** It opens *"The hypothesis `m ≥ 8` is invoked at exactly one step of Chapter 3"* (C1, refuted in §2) and its *"What is not"* paragraph names *"the separate `n ≥ 15` constraint inside Lemma 3.5.6, which this lemma leaves untouched"*, C8, refuted in §5. The file thus parks, as out of scope, the one thing that decides the lemma. `cited_count_is_larger`'s docstring adds *"the count the step needs, which is `|A_k| = m`, a single block"*, which §4 shows is available only as the conclusion of the passage. **The Lean file is not wrong; it is true about propositions that do not reach the claim, and its prose carries the refuted census forward into the machine-checked layer.** The row in [lean/INDEX.md](../lean/INDEX.md) repeats both.

## 10. What would show $m\ge8$ genuinely needed, and it does

The brief asks what, in the source, would break the finding. The answer is Lemma 3.5.6, and it is in the source:

1. a step of Chapter 3 whose warrant is Assumption 1 and whose constraint, translated through $n=2m$, is $m\ge8$, **lines 4341 and 4397**;
2. that step failing at $n=12,14$ rather than merely being stated conservatively, **$g(12),g(14),h(12),h(14)>0$**, §5;
3. that step being load-bearing for Theorem 3.0.2, Lemma 3.5.6 is consumed at **line 4495**, inside Lemma 3.6.3, which §3.6 needs.

All three hold. The finding's conclusion is not merely unsupported; **the source contains its refutation, in the lemma the finding set aside as a different hypothesis.**

## 11. Repair the finding could take

The salvage is a restatement, not a new argument, and it is already true:

> In Jäger's Chapter 3, Assumption 1's $m\ge8$ is consumed at five steps. At four of them a weaker bound suffices, $m\ge4$ at the index choice of the proof of Theorem 3.0.2, $m\ge5$ at (3.13), $m\ge6$ at the application of Lemma 3.5.4 with $k=n$. **The fifth is Lemma 3.5.6, whose two cases each need $n\ge15$, which for $n=2m$ is exactly $m\ge8$, and whose quartics are positive at $n=12$ and $n=14$.** So the sole obstruction to Theorem A at $n=12,14$ is Lemma 3.5.6, and whatever removes it removes Assumption 1 with it.

That is a strictly more useful statement than the one on file, it is consistent with [problem.md](../findings/problem.md) line 462, and it retires the "different hypothesis" framing. The lemma's title and its `## Statement` both need to change, as do the L172 docstring and the [lean/INDEX.md](../lean/INDEX.md) row.
