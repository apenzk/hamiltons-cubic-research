# Review r608, Lemma L55, the min-entry bound

**Reviewer B of a pair on identical briefs, r607 being the other. Derived cold from the definitions in [conventions.md](../findings/conventions.md); the block's own reasoning was read only after the derivation closed.**

**Standing rule observed: analysis only.** Everything below is derived by hand. One screen was run (arithmetic on matrices I constructed for the purpose) and it is labelled as a screen where it appears; nothing positive rests on it.

## Verdict

**CONFIRMED, the statement is true and, in [diagonal-half.md](../findings/diagonal-half.md#L400), proved, uniqueness half included.** The supplied proof did land: it is present, it is the right argument, and it establishes both halves. Six defects surround it, none of them touching the truth of the display.

| # | what | where | severity |
| --- | --- | --- | --- |
| 1 | The false pointer the repair was meant to remove **is still there**, two lines above the proof that contradicts it | [diagonal-half.md:402](../findings/diagonal-half.md#L402) | the block asserts two incompatible provenances |
| 2 | *"the mathematics has always been in this file"* is **false**, it has never been in that file | [diagonal-half.md:402](../findings/diagonal-half.md#L402) | provenance |
| 3 | The result carries **two numbers**: L55 here and [L93](../findings/bispectral.md#L347) in another file, same statement, both live, both marked *"Gate 2: no verdict"* | [INDEX-results.md](../findings/INDEX-results.md) rows 55 and 93 | duplicate number |
| 4 | [report/](../report/)'s proof of L55 proves **attainment only**, while its statement says *"exactly"* | [06b-bispectral.tex:155](../report/sections/06b-bispectral.tex#L155) | the report cites more than it proves |
| 5 | *"the row-level equality configuration … is not what symmetry permits a vertex matrix to have"* is **false**, and the same file's sharpness paragraph refutes it | [bispectral.md](../findings/bispectral.md#L347), [06b-bispectral.tex:165](../report/sections/06b-bispectral.tex#L165) | a pre-correction sentence left standing beside its correction |
| 6 | Odd $n$: the record has three measured ratios and no closed form; one of the three is wrong, and **the sharp odd-$n$ constant is elementary**, derived in §4 below | [bispectral.md](../findings/bispectral.md#L347), [06b-bispectral.tex:159](../report/sections/06b-bispectral.tex#L159) | an under-claim plus one wrong digit-string |

## 1. The inequality, re-derived

Write $m:=\lvert\min_{a\ne b}K_{ab}\rvert$, and $s_a:=\sum_{b\ne a}K_{ab}^2$.

**Step 1, the row polytope.** Hollowness makes the $a$-th row's off-diagonal entries the whole row, so $K\mathbf1=0$ reads $\sum_{b\ne a}K_{ab}=0$; and $K_{ab}\ge-m$ by the definition of $m$. Hence $x:=(K_{ab})_{b\ne a}$ lies in $P_m:=\{x\in\mathbb R^{n-1}:\sum_bx_b=0,\ x_b\ge-m\}$. $P_m$ is bounded, since $x_b=-\sum_{c\ne b}x_c\le(n-2)m$, and it is a simplex with $n-1$ vertices, the $j$-th having $x_j=(n-2)m$ and the others $-m$.

**Step 2, the row bound.** $x\mapsto\lVert x\rVert^2$ is convex, so its maximum over $P_m$ sits at a vertex, and every vertex gives the same value: $s_a\le(n-2)^2m^2+(n-2)m^2=(n-1)(n-2)m^2$.

**Step 3, summing.** Hollowness again: $\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2=\sum_as_a$, the sum over **ordered** pairs that [conventions.md](../findings/conventions.md) fixes as the meaning of $t$. So $t\le n(n-1)(n-2)m^2$, i.e.

$$m\ \ge\ \sqrt{\frac t{n(n-1)(n-2)}}. \qquad\blacksquare$$

**The constant checks out**, and it checks out *because* $t$ is the ordered sum. Under the unordered reading the same three steps give $t_{\text{unord}}\le\tfrac12n(n-1)(n-2)m^2$ and the display would carry a $2$. The two readings differ by exactly the factor the brief warned about, and the record's convention is the one the display is written in, confirmed independently below, where the extremiser at $t=2$ reproduces the catalogued $n=6$ torus entries $4/\sqrt{60}$ and $-1/\sqrt{60}$ digit for digit.

### Which hypotheses are consumed

| hypothesis | used in the inequality? | where |
| --- | --- | --- |
| hollow | **yes, twice** | step 1 (the row's constraint is $\sum_{b\ne a}K_{ab}=-K_{aa}=0$) and step 3 ($\lVert K\rVert_F^2$ has no diagonal contribution) |
| zero row sums | **yes** | step 1 |
| symmetric | **no** | consumed only by the equality case, §3 |

**So the inequality is strictly stronger than stated**: it holds for every hollow $K$ with zero row sums, symmetric or not. That is not a defect in the display, but it is where the parity phenomenon comes from, and the block never says so. Without symmetry the constant stays sharp at **every** $n\ge3$: take any fixed-point-free $\sigma:[n]\to[n]$ and set $K_{a\sigma(a)}=(n-2)c$, $K_{ab}=-c$ otherwise. At $n=3$ with $\sigma$ the $3$-cycle this is hollow, has zero row sums, has $t=6c^2=n(n-1)(n-2)c^2$ and $m=c$, equality, at an odd $n$. **Symmetry is exactly the hypothesis that turns $\sigma$ into an involution and so imposes the parity obstruction.**

### The absolute value

$\lvert\cdot\rvert$ is cosmetic but harmless. Hollowness plus $K\mathbf1=0$ make each row's off-diagonal entries sum to zero, so **every** row containing a nonzero entry contains a negative one; hence $\min_{a\ne b}K_{ab}<0$ whenever $K\ne0$, and $=0$ when $K=0$, where the display reads $0\ge0$. The sharper sign-carrying form $\min_{a\ne b}K_{ab}\le-\sqrt{t/(n(n-1)(n-2))}$ is therefore available and is what §4 uses.

## 2. Attainment at even $n$, arithmetic closes

Let $n$ be even, $\sigma$ a fixed-point-free involution, $K_{ab}=(n-2)c$ for $b=\sigma(a)$ and $-c$ otherwise, $c>0$.

- **hollow** by construction; **symmetric** because $\sigma=\sigma^{-1}$; **row sums** $(n-2)c+(n-2)(-c)=0$ for every $a$.
- $s_a=(n-2)^2c^2+(n-2)c^2=(n-1)(n-2)c^2$ for every $a$, so $t=n(n-1)(n-2)c^2$.
- $\min_{a\ne b}K_{ab}=-c$ for $n\ge3$, so $m=c=\sqrt{t/(n(n-1)(n-2))}$. **Equality.**

**One precision defect in the statement.** The sign of $c$ is load-bearing and the block leaves it free. At $c<0$ the same matrix has $m=(n-2)\lvert c\rvert$ against a bound of $\lvert c\rvert$ and is **not** an extremiser. The statement should read $c>0$.

**And the even-$n$ extremiser is an object the record already holds.** At $t=2$, $c=\sqrt{2/(n(n-1)(n-2))}$, which at $n=6$ is $1/\sqrt{60}$ with $(n-2)c=4/\sqrt{60}$, entry for entry the $\mathrm{SRG}(6,4,2,4)$ $a<0$ branch of [Lemma L74](../findings/diagonal-half.md), i.e. the maximal torus $\mathfrak{so}(2)^{n/2}$, as [r340](REVIEW_r340.md) already noted. **The min-entry bound is attained at a genuine critical point**, not merely at an admissible $K$. The L55 block does not say this; [r340](REVIEW_r340.md) does.

## 3. Uniqueness, present, and one clause short of airtight

The equality analysis the brief asks after **is** in the block, and it is the right one. Equality in step 3 forces $s_a=(n-1)(n-2)m^2$ for **every** $a$; equality in step 2 forces each row to a vertex of $P_m$. Two things carry that and neither is stated:

- **Strict convexity.** "The maximum of a convex functional sits at a vertex" is the direction step 2 needs; the equality case needs the converse, *only* at a vertex, which is strict convexity of $\lVert\cdot\rVert^2$: writing $x=\sum\lambda_iv_i$, $\lVert x\rVert^2\le\sum\lambda_i\lVert v_i\rVert^2$ with equality iff $x$ is one of the $v_i$. One clause.
- **Symmetry, which is where it finally enters.** Each row $a$ has a unique column $\sigma(a)\ne a$ with $K_{a\sigma(a)}=(n-2)m$. Symmetry gives $K_{\sigma(a)a}=(n-2)m$, and row $\sigma(a)$ is also a vertex, so its unique large entry is at $\sigma(\sigma(a))$; since $(n-2)m\ne-m$ for $m>0$, $\sigma(\sigma(a))=a$. So $\sigma$ is a fixed-point-free involution, which exists iff $n$ is even. The block writes *"which pairs the rows into a fixed-point-free involution"* and skips this; it is two lines and it is the only place symmetry is used in the whole lemma.

$m>0$ is needed and is free: $t>0$ forces it, and $t=0$ is the degenerate $K=0$ that the "exactly the perfect matchings" clause should exclude.

**With those two clauses the uniqueness half is complete.** This is the half [report/](../report/) does not have, see §5.

## 4. Odd $n$: true, unattained, and the sharp constant is elementary

**True and strict.** The inequality never used symmetry, so it holds at every $n$; equality would force a fixed-point-free involution on an odd set, so it is unattainable. [results.md:556](../results.md#L556) states this correctly (*"at odd $n$ the bound is strict"*); the [findings block](../findings/diagonal-half.md#L400) and the [report](../report/sections/06b-bispectral.tex#L147) leave it to be inferred from the sharpness clause.

**The record treats the sharp odd constant as a measured quantity**, [bispectral.md](../findings/bispectral.md#L347) and the report's [certificate](../report/sections/06b-bispectral.tex#L159) carry *"ratios $\sqrt{5/3}$, $1.16024$, $1.11153$ at $n=5,7,9$"* and nothing else. **It is not measured; it is a two-step exercise.**

**Reduction.** Fix $m=1$ and maximise $t$; the bound's constant is $C_n:=\max\{t:K\ \text{hollow, symmetric},\ K\mathbf1=0,\ K_{ab}\ge-1\}$, since $K/m$ is feasible for any $K$ and $t/m^2\le C_n$ gives $m^2\ge t/C_n$, sharply. Substitute $B_{ab}:=K_{ab}+1\ge0$ off the diagonal. Then $B$ is symmetric, hollow, nonnegative with every row sum $n-1$, and

$$t=\sum_{a\ne b}(B_{ab}-1)^2=\lVert B\rVert_F^2-2n(n-1)+n(n-1)=\lVert B\rVert_F^2-n(n-1).$$

So $C_n=\max\lVert B\rVert_F^2-n(n-1)$, and $x:=B/(n-1)$ ranges over exactly the **fractional perfect matching polytope of $K_n$**, $\{x\ge0:\sum_{e\ni v}x_e=1\ \forall v\}$.

**Its vertices, proved in place rather than cited.** Let $x$ be extreme and $S$ its support. (i) $S$ has no even cycle, alternate $\pm\varepsilon$ around it, every degree preserved, contradicting extremality. (ii) $S$ has no two cycles in one component, either they share the parity to make an even cycle, or a path joins two odd cycles and $\pm\varepsilon$ along the path with $\mp\varepsilon/2$ around each cycle is again a perturbation. (iii) A tree component has a leaf, whose single edge carries $x=1$; its other endpoint then has all its remaining edges at $0$, so the component is that edge alone. Hence every component is a single edge at $x=1$ or a single odd cycle, on which the degree constraints force $x\equiv1/2$. **So a vertex is a matching plus disjoint odd cycles covering everything.**

**Evaluate.** If the odd cycles cover $c$ vertices they carry $c$ edges, and the matching covers the other $n-c$, so $\sum_ex_e^2=\tfrac{n-c}2+\tfrac c4=\tfrac n2-\tfrac c4$ and $\lVert B\rVert_F^2=2(n-1)^2\big(\tfrac n2-\tfrac c4\big)=(n-1)^2\big(n-\tfrac c2\big)$, **decreasing in $c$**, and $c\equiv n\bmod2$ with $c=0$ or $c\ge3$.

$$\boxed{\ C_n=n(n-1)(n-2)\ \ (n\text{ even},\ c=0),\qquad C_n=\tfrac12(n-1)(2n-1)(n-3)\ \ (n\text{ odd},\ c=3).\ }$$

The even value **re-derives the lemma's own constant by a second route**, and its maximisers are exactly the perfect matchings, an independent confirmation of §3's uniqueness. The odd value gives the sharp odd-$n$ statement:

$$\Big\lvert\min_{a\ne b}K_{ab}\Big\rvert\ \ge\ \sqrt{\frac{2t}{(n-1)(2n-1)(n-3)}}\qquad(n\ \text{odd},\ n\ge5),$$

attained by $K=(n-1)x-\mathbf{1}\mathbf{1}^{\mathsf T}$ off the diagonal at $x$ the triangle-plus-matching vertex: **$K=n-3$ on the matching, $K=\tfrac{n-3}2$ on the triangle, $-1$ elsewhere**, up to positive scale. At $n=3$ the polytope is the single triangle, $C_3=0$, and indeed $\mathcal D_3=\{0\}$, the three row-sum equations force every entry to vanish.

**The ratio to the recorded bound is therefore $\sqrt{C_n^{\text{even formula}}/C_n}$, in closed form**

$$\frac{\min\lvert\min K\rvert}{\text{L55 bound}}=\sqrt{\frac{2n(n-2)}{(2n-1)(n-3)}}\qquad(n\ \text{odd}).$$

| $n$ | closed form | record's value |
| --- | --- | --- |
| $5$ | $\sqrt{5/3}=1.290994$ | $\sqrt{5/3}$, **agrees exactly** |
| $7$ | $\sqrt{35/26}=1.160239$ | $1.16024$, **agrees exactly** |
| $9$ | $\sqrt{21/17}=1.111438$ | $1.11153$, **wrong in the fourth decimal** |

**The $n=9$ entry is an optimiser artifact and errs in the direction a stalled optimiser errs**: too *high*, because a search that fails to reach the true minimiser of $\lvert\min K\rvert$ reports a larger one. The same block warns about *"stalled-optimiser output"* in its own correction paragraph. **The value to carry is $\sqrt{21/17}=1.1114378$**, and the general closed form above retires the three-number table.

**Screen** (constructed objects, seconds, reported as a screen and load-bearing for nothing): the even extremisers at $n=4,6,8,12$ return $\lvert\min\rvert/\text{bound}=1.000000000000$ and $t=n(n-1)(n-2)c^2$ exactly; the triangle-plus-matching configurations at $n=5,7,9,11$ return $t=36,156,408,840$, matching $\tfrac12(n-1)(2n-1)(n-3)$ exactly, with ratios $1.290994$, $1.160239$, $1.111438$, $1.085620$ against the closed form to twelve digits. A hill-climb over $\mathcal D_n$ at $m=1$ reached $35.70$ of $36$ at $n=5$ and stalled well below at $n=7,9$, which is what a convex maximum does to a local method, and is why the derivation rather than the climb is the evidence here.

## 5. What it feeds, and at what strength

**Its one consumer needs the inequality only.** [report/](../report/sections/06b-bispectral.tex#L163) states the use: combined with [L54](../findings/bispectral.md)'s $\psi$-block identity $d_\psi=-\mathop{\mathrm{spec}}(K\vert_{\mathbf1^\perp})$, the bound forces $\max d$ away from zero at every vertex matrix, so the $\omega$-side Okumura extremiser fails majorization at $j=1$ *for a reason* rather than in sampled cells, once $t>12(n-2)/((n+2)(n^2+n-4))$. That is the display alone; the equality case enters nowhere in it. **I did not re-derive that threshold**, it belongs to L54's audit, and re-deriving it needs the Okumura side, not this lemma.

**The equality case is cited once, and only its attainment half**: [r340](REVIEW_r340.md) uses the matching extremiser to identify the $\mathrm{SRG}(v,1,0,0)$ member with the maximal torus. **Nothing on the record cites the uniqueness half.** So the record does not over-cite this lemma, the *report* under-proves it, which is the opposite failure.

## 6. Provenance and pointers, checked rather than assumed

**Defect 1, the false pointer survived its own repair.** The block still reads, at [line 402](../findings/diagonal-half.md#L402):

> *the argument is in this file under "It does NOT survive off the diagonal locus, and the failure is systema"*

and eight lines later, in the proof it introduces, reads:

> *the block's pointer named a truncated section title containing no min-entry argument, so the proof was absent from the record*

**Both sentences are in the block simultaneously.** I read [the named section](../findings/diagonal-half.md#L257) in full: it is the $K^2-\lambda K\succeq0$ material (the Laplacian identity, the effective weights $K_{ab}^2+U_{ab}$, the off-locus refutation) and contains no min-entry argument, exactly as [ELIM-halves W5](ELIM-halves.md#L154) said. The repair added the proof and left the pointer that motivated it. **A reader who stops at the italic line is sent to the same wrong place as before the repair.**

**Defect 2, "the mathematics has always been in this file" is false.** Checked against `git log -S`, in both directions as the brief instructs:

- The min-entry mathematics entered the record at [b1117290](../findings/bispectral.md) *"feat(bispectral): the min-entry lemma, derived rather than swept"* (2026-08-26), in [bispectral.md](../findings/bispectral.md#L347).
- `-S` on the min-entry strings against [diagonal-half.md](../findings/diagonal-half.md) returns only two commits: 86621751, which added the heading and the statement with no argument, and 18a0ace6, the repair. **The argument has never been in diagonal-half.md before the repair.**
- The other half of the same sentence, *"the result was numbered in report/"*, is **true**, [06b-bispectral.tex](../report/sections/06b-bispectral.tex#L147) carries `\begin{Lem}{55}`.

**Defect 3, the result carries two numbers.** [Lemma L93](../findings/bispectral.md#L347) is the same statement with the same constant and the same extremiser, in a different file, with its own proof. [INDEX-results.md](../findings/INDEX-results.md) lists both, both as *"Gate 2: no verdict on the record"*, while [ATTEMPTS.md](../ATTEMPTS.md) item 114 records Gate 2 landing on this lemma through reviewers 105 and 106, and [ELIM-halves](ELIM-halves.md#L204) records a verdict too. **One result, two numbers, two files, and an index that says no verdict where two exist.** L55's block should point at L93 or one of them should be struck; that is a record decision rather than a mathematical one.

**Defect 5, a refuted sentence still standing.** [bispectral.md](../findings/bispectral.md#L347) and [the report](../report/sections/06b-bispectral.tex#L165) both say the row-level equality configuration *"is not what symmetry permits a vertex matrix to have"*. **It is exactly what symmetry permits**: the perfect-matching extremiser has that row shape at every row, is a genuine coordinate-diagonal Weyl tensor at $t=2$, and is the maximal torus. The sharpness paragraph in the same file refutes the sentence three paragraphs later without removing it, the same shape of defect as Defect 1.

**All pointers in the block resolve** apart from the one in Defect 1: [ELIM-halves.md](ELIM-halves.md) exists and §S4 carries the proof the block says it supplies; [report/](../report/) carries the number; the neighbouring [L74](../findings/diagonal-half.md), [L96](../findings/diagonal-half.md) and [L129](../findings/diagonal-half.md) blocks are where they are named.

## 7. Hedging clauses, per the checklist

| clause | verdict |
| --- | --- |
| *"the extremizers being **exactly** the perfect matchings"* | **honest**, the findings proof does earn "exactly", modulo the two unstated clauses of §3. The report does not. |
| *"sharp for even $n$"* | **honest**, and the qualifier is real: strictness at odd $n$ is a theorem, and the sharp odd constant is §4's. |
| *"existing exactly for even $n$"* (of the involution) | **honest.** |
| *"the mathematics has always been in this file"* | **false**, Defect 2. |
| *"the entire loss is in the single-row step"* (L93, report) | **overstated**: at the sphere product's own $K$ the max-row step is tight, so the sentence is true *there* and is written as a property of the bound. |

## What the record may cite after this review

- **The inequality: freely, at every $n$, and without symmetry.** Hollow plus zero row sums suffice.
- **The equality case at even $n$: freely, both directions**, citing [diagonal-half.md](../findings/diagonal-half.md#L400), with $c>0$, and with the two clauses of §3 written in.
- **The equality case out of [report/](../report/): attainment only** until its proof is completed.
- **At odd $n$: the bound is true and strict**, and the sharp constant is $\tfrac12(n-1)(2n-1)(n-3)$, contributed here.

