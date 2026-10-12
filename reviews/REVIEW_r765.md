# Review 765, whether [conventions.md](../findings/conventions.md) closes the ordered-pair hazard, and whether [Lemma L174](../findings/second-order.md) cites it soundly, Gate 2

**Cold brief.** [BRIEF-g2-ordered.md](BRIEF-g2-ordered.md) was read in full before any file of the record was opened. **No numerical work was done**, no sweep, census or falsifier hunt. Every value below is exact, rational or symbolic; the one exact-rational screen is named as a screen where it appears and carries no positive claim on its own. Log: [agent_logs/g2-ordered-r765.log](../agent_logs/g2-ordered-r765.log).

| # | claim | verdict |
|---|---|---|
| 1 | [conventions.md](../findings/conventions.md) tables the ordered reading, and the quoted sentence is on file as quoted | **CONFIRMED**, line 136 tables it, line 138 carries the sentence verbatim including its punctuation |
| 2 | The quoted inconsistency argument is sound | **REFUTED AS QUOTED, CONFIRMED IN ITS BOX**, the sentence alone assumes the numeral it tests, and the record machine-checks the contrary general principle in [L114.lean](../lean/HamiltonsCubic/Results/L114.lean); the two sentences L174 did not quote carry the whole of the refutation |
| 3 | [L94](../findings/bispectral.md)'s $t$ is [conventions.md](../findings/conventions.md)'s $t$, so the citation transfers | **CONFIRMED, and more strongly than the claim says**, L94's constant $2$ **is** the ordered doubling, so L94 is itself an anchor for the reading |
| 4 | Under the ordered reading $t=2$ exactly at coordinate-diagonal, verified at a concrete unit $W$ | **CONFIRMED** exactly, in closed form, at $S^m\times S^m$ for $n=4,6,8,12$: ordered $2$, unordered $1$, from the record's own weights |
| 5 | Nothing on the record consumes $t$ under the other reading | **CONFIRMED**, six consumers checked; [diagonal-half.md](../findings/diagonal-half.md) carries both index forms twelve lines apart with the factor right, and the one real mismatch on file was caught and its lemma withdrawn |
| 6 | The hazard is *"closed"* | **CONFIRMED for the reading, GAP for the citation**, the reading is closed for every consumer checked; what L174 quotes is the half of the box that does not close it |
| 7 | What would reopen it | answered, four routes, and the live one runs through the letter $M$ rather than the index set |

**Actionable summary.** Replace L174's quotation with the sentence that actually does the work, *"in operator terms $t=2\lVert\operatorname{diag}W\rVert^2$ … so $t\le2$ is Cauchy–Schwarz against $\lVert W\rVert=1$"*, or, cheaper, cite [L94](../findings/bispectral.md)'s own factor $2$, which is the ordered doubling and cannot be rescaled away.

## 0. Conventions, fixed once

Fixed from [conventions.md](../findings/conventions.md) by line, before anything below was derived.

- **$K$ and $t$** (line 136): $K$ is the symmetric hollow $n\times n$ sectional matrix, $K_{ab}=W_{abab}$ for all $a\ne b$, and $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, the sum over **ordered** pairs; $t\le2$ with $t=2$ iff $W$ is coordinate-diagonal in some frame.
- **$t$ against $t_F$** (line 23 and line 140): $t=t_F=\lVert K(F)\rVert_F^2$ per frame and $\kappa^2=\max_Ft_F$; the extremal reading belongs to $\kappa^2$ alone.
- **$M$ on $\Lambda^2$** (line 92): $\mu=\operatorname{spec}(M)$ at $\lVert M\rVert_F=1$, with $\sum\mu=0$ and $\sum\mu^2=1$.
- **$M$ as the sectional matrix** (line 153): the second object the letter carries, where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor. *The two norms differ by $\sqrt2$, and the table says so.*
- **"Diagonal"** (line 69): diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$, which is strictly stronger than diagonal as an operator on $\Lambda^2$.
- **The bivector norm** (line 88): the record runs at $\lVert\varphi_{ab}\rVert^2=1$, the half-trace pairing, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal.
- **The two Frobenius pairings** (line 90): the $\Lambda^2$ and $n\times n$ pairings differ by a factor $2$.

## Hypothesis inventory

What the derivations below consume, and where each is discharged.

| hypothesis | discharged at |
| --- | --- |
| $\{\varphi_{ab}\}_{a<b}$ is an orthonormal basis of $\Lambda^2$ | [conventions.md](../findings/conventions.md) line 88 |
| $\lVert W\rVert=1$ in that basis, equivalently $\lVert M\rVert_F=1$ with $\sum\mu^2=1$ | [conventions.md](../findings/conventions.md) line 92 |
| At a coordinate-diagonal $W$, $\operatorname{spec}(M)=\{K_{ab}\}_{a<b}$ | [conventions.md](../findings/conventions.md) line 153, [bispectral.md](../findings/bispectral.md) line 480 |
| $K\mathbf1=0$, Ricci-flatness of the Weyl tensor | [diagonal-half.md](../findings/diagonal-half.md) line 15 |
| $\lVert K\rVert_F$ means the Frobenius norm of the $n\times n$ **matrix** | [conventions.md](../findings/conventions.md) line 136, definitional |

## 1. What [conventions.md](../findings/conventions.md) says, quoted

**The reading is tabled, in its own section, in the claim's own words.** [conventions.md](../findings/conventions.md) line 136, opening the section headed *"The vertex matrix"*:

> **$K$ is the symmetric hollow $n\times n$ **sectional matrix**, $K_{ab}=W_{abab}$ for all $a\ne b$, and $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, the sum over **ordered** pairs. Then $t\le2$ with **$t=2$ iff $W$ is coordinate-diagonal in some frame**, and $t$ is the coordinate the bi-spectral relaxation is swept in.

**And the quoted sentence is there, verbatim.** Line 138, the box immediately below, in full, the claim quotes its second clause and stops:

> **THE ORDERED SUM IS THE WHOLE OF THE NORMALISATION AND WAS AMBIGUOUS HERE.** Writing $K$ as $(W_{abab})_{a<b}$ reads as an index set over *unordered* pairs, whose square sum is $\tfrac t2\le1$, so the bound $t\le2$ and that reading are inconsistent. *Checked: at a unit-norm coordinate-diagonal $W$ the unordered sum is $1$ and the ordered sum is $2$, and the record's $t=2$ is the ordered one.* In operator terms $t=2\lVert\operatorname{diag}W\rVert^2$ with the diagonal taken in the pair basis, so $t\le2$ is Cauchy–Schwarz against $\lVert W\rVert=1$, with equality exactly when $W$ is diagonal.

So on item 1 the claim is right on both halves: the file tables the ordered reading in the word *"ordered"* and in the index set $\sum_{a\ne b}$, and the sentence the claim quotes is on file with the force it is given. **The finding here is not in what was quoted but in what was left out**, and that is section 2.

## 2. The inconsistency argument: a rescaling as quoted, a refutation in its box

**The quoted clause, isolated, is circular.** It reads: the unordered index set gives a square sum of $\tfrac t2\le1$, therefore the bound $t\le2$ and that reading are inconsistent. Every occurrence of the letter $t$ in that sentence already denotes the ordered value (the fraction $\tfrac t2$ is only meaningful if $t$ is the ordered sum) so the sentence exhibits that the two readings differ by a factor $2$ and then convicts the second of disagreeing with a numeral computed under the first. **That is a difference, not a contradiction.** A reader who adopted the unordered reading throughout would write $t'\le1$, $\kappa'^2=1$ at coordinate-diagonal, and [L94](../findings/bispectral.md) as $\kappa'^2\le\lVert M\rVert_F^2$; nothing in the sentence rules that out.

**The record itself machine-checks the principle that defeats the sentence as quoted.** [L114.lean](../lean/HamiltonsCubic/Results/L114.lean) carries, in its docstring, *"The convention change moves no number. Ordered against unordered rescales each pattern by its own arrangement count, and both sides scale together"*, and states it as a theorem:

```
theorem convention_invertible (c S : ℚ) (hc : c ≠ 0) : c * S / c = S
```

That file is about the block-mass identity rather than about $t$, so it is not a counter-claim; **it is the record's own statement of the standard the argument at line 138 has to beat**, and the quoted clause does not beat it.

**What does beat it is the definitional half of the same line.** $t$ is not introduced as an abstract symbol constrained by a bound; it is *defined* as $\lVert K\rVert_F^2$ where $K$ is an $n\times n$ **matrix** (line 136). The Frobenius norm of a matrix runs over all index pairs. So $\sum_{a<b}K_{ab}^2$ is not an alternative reading of $\lVert K\rVert_F^2$, it is a different quantity, half of it, and the ambiguity the box confesses is one of *notation for $K$* (writing the object as a family $(W_{abab})_{a<b}$ rather than as a matrix), not of the norm. **On that reading the box is refuting a mis-typing of $K$, and the refutation is airtight and needs no constant.**

**And the anchoring half is the third sentence, which the claim does not quote.** *"In operator terms $t=2\lVert\operatorname{diag}W\rVert^2$ with the diagonal taken in the pair basis, so $t\le2$ is Cauchy–Schwarz against $\lVert W\rVert=1$."* Here the numeral $2$ is **derived**, from a normalisation ($\lVert W\rVert=1$, tabled independently at [conventions.md](../findings/conventions.md) lines 88 and 92) that no choice about pair ordering can move. Spelled out: in the orthonormal pair basis $\{\varphi_{ab}\}_{a<b}$ the diagonal entries of $W$ are $\langle\varphi_{ab},W\varphi_{ab}\rangle=W_{abab}=K_{ab}$, so

$$\lVert\operatorname{diag}W\rVert^2=\sum_{a<b}K_{ab}^2=\tfrac12\sum_{a\ne b}K_{ab}^2=\tfrac t2\le\lVert W\rVert^2=1,$$

whence $t\le2$ with equality iff $W$ is diagonal in the pair basis. **The constant is a consequence of a fixed normalisation, so it is held fixed and the reading that disagrees with it is refuted rather than rescaled.**

**Verdict on item 2, stated exactly.** The convention is closed, and it is closed by the box; the sentence L174 lifts out of the box is the one part of it that does not close anything. *Locating the defect:* [second-order.md](../findings/second-order.md) line 1600, which quotes line 138's second clause and drops its third. *The failure concretely:* under the unordered convention adopted uniformly, every statement quoted in that box remains true with $1$ in place of $2$, so a reader who has only L174's quotation has been given no reason to prefer either. *The opposite reading, at its strongest:* the box's own opening words, *"THE ORDERED SUM IS THE WHOLE OF THE NORMALISATION"*, signal that the whole box is the argument and the middle clause is a summary of it, on that reading L174 abbreviated rather than misquoted. **That is the reading I take**, which is why this is a citation defect and not a broken claim.

## 3. [Lemma L94](../findings/bispectral.md) uses the ordered reading, and its constant proves it

**The objects match at the definition.** [bispectral.md](../findings/bispectral.md) line 219 defines $\kappa(W):=\max_F\lVert K(F)\rVert_F$ over orthonormal frames. That is $\lVert K\rVert_F$ (the same matrix Frobenius norm line 136 tables), maximised over frames, so $\kappa^2=\max_Ft_F$, which is exactly [conventions.md](../findings/conventions.md) line 23. **The letters, the norm and the quantifier all agree.**

**And L94's numeral is the ordered doubling itself, which is a stronger anchor than the bound $t\le2$.** L94 states $\kappa^2\le2\lVert M\rVert_F^2$. With $M$ the $\Lambda^2$ operator at $\lVert M\rVert_F=1$ ([conventions.md](../findings/conventions.md) line 92), the one-line proof both [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md) gave is the Cauchy–Schwarz of section 2, and the factor $2$ in front of $\lVert M\rVert_F^2$ **is** the conversion from $\sum_{a<b}$ to $\sum_{a\ne b}$. Under the unordered reading L94 would have to read $\kappa'^2\le\lVert M\rVert_F^2$, with no factor at all. **So L94 was derived under the ordered reading and the citation transfers**; and had L174 cited L94's constant instead of line 138's sentence, the hazard would have been closed by a number the record already proves rather than by a numeral the reading is free to move.

**The same identity is stated a third time, independently, and correctly.** [stratum-two-negative.md](../findings/stratum-two-negative.md) line 363: *"the $e_a\wedge e_b$ are orthonormal, so $\|K\|_F^2=2\sum_{a<b}K_{ab}^2\le2\|W\|^2=2$, with equality exactly when $W$ is coordinate-diagonal."* That is the ordered/unordered conversion written out with the bound derived rather than assumed, in a file that is not [conventions.md](../findings/conventions.md).

**One caveat, and it is about the letter $M$ rather than about $t$.** [conventions.md](../findings/conventions.md) carries $M$ in two senses (the $\Lambda^2$ operator at line 92 and the $n\times n$ sectional matrix at line 153) and the table flags the collision. L94's $M$ is the line-92 sense; read in the line-153 sense, $\lVert M\rVert_F^2=2$ at a unit Weyl tensor and L94 would give $\kappa^2\le4$. [L174](../findings/second-order.md)'s own last box records this. **The reading of $t$ is safe; the reading of $M$ is where a factor $2$ can still be lost**, and section 7 files it as the live reopening route.

## 4. The equality case, verified exactly

**Object.** The balanced sphere product $S^m\times S^m$ at $n=2m$, which is coordinate-diagonal (the curvature operator is diagonal in the coordinate pair basis of the product-adapted frame) and is the record's own witness ([diagonal-half.md](../findings/diagonal-half.md) line 21, [stratum-two-negative.md](../findings/stratum-two-negative.md) line 363).

**Derivation, in closed form.** For round factors of equal radius the sectional curvatures are $R_{abab}=1$ within a factor and $0$ across, with $\operatorname{Ric}_{aa}=m-1$ for every $a$ and scalar curvature $2m(m-1)$. Then

$$K_{ab}=W_{abab}=R_{abab}-\frac{\operatorname{Ric}_{aa}+\operatorname{Ric}_{bb}}{n-2}+\frac{\mathrm{scal}}{(n-1)(n-2)}=R_{abab}-1+\frac m{2m-1},$$

so $K_{ab}=\dfrac m{2m-1}$ within a factor and $-\dfrac{m-1}{2m-1}$ across. **Row sums vanish**: $(m-1)\cdot\frac m{2m-1}+m\cdot\frac{-(m-1)}{2m-1}=0$, so this is a genuine Weyl tensor. Counting $2\binom m2=m(m-1)$ unordered within-factor pairs and $m^2$ across,

$$\sum_{a<b}K_{ab}^2=\frac{m(m-1)m^2+m^2(m-1)^2}{(2m-1)^2}=\frac{m^2(m-1)}{2m-1},\qquad \sum_{a\ne b}K_{ab}^2=\frac{2m^2(m-1)}{2m-1}.$$

**Normalising to $\lVert W\rVert^2=\sum_{a<b}K_{ab}^2=1$ divides both by the first**, giving

$$\boxed{\ \sum_{a\ne b}K_{ab}^2=2\ \text{ exactly},\qquad \sum_{a<b}K_{ab}^2=1\ \text{ exactly},\ }$$

**for every $m$, with the $(2m-1)$'s cancelling identically.** So the ordered reading attains the recorded $t=2$ and the unordered reading would give $1$ at the same point, which is precisely what line 138's *"Checked"* sentence asserts, now derived rather than measured.

**Screen** (exact rational, [Fraction](https://docs.python.org/3/library/fractions.html), seconds; recorded as a screen and not as evidence): at $m=2,3,4,6$ the row sums are $0$ and the normalised ordered sum is $2$ with the normalised unordered sum $1$, all as exact rationals. The normalised entries at $n=6$ are $K_{ab}^2=\tfrac1{10}$ within a factor and $\tfrac2{45}$ across.

**Cross-check against the record's own weight, which is written in a different normalisation.** [diagonal-half.md](../findings/diagonal-half.md) line 21 gives the balanced product as $1/(p(p-1))$ inside the blocks and $-1/(pq)$ across; at $p=q=m$ the ratio of magnitudes is $\frac{1/(m(m-1))}{1/m^2}=\frac m{m-1}$, which is exactly the ratio $\frac{m}{2m-1}\big/\frac{m-1}{2m-1}$ derived above. **The two agree up to scale, as they must.** And [stratum-two-negative.md](../findings/stratum-two-negative.md) line 363's measured $2.0000$ at $S^3\times S^3$ is the $m=3$ case of the boxed identity.

## 5. Every other consumer of $t$, and what each reads

**Six checked, by object rather than by string.**

| consumer | what it writes | reading |
| --- | --- | --- |
| [conventions.md](../findings/conventions.md) line 23 | $\kappa^2\le2\lVert M\rVert_F^2$, hence $t_F\le2$ | ordered |
| [bispectral.md](../findings/bispectral.md) line 308 | $t=\lVert K\rVert_F^2\le2$, $\sum d_\varphi^2=t/2$, $\sum d^2=3t/2$; at $t=2$, $\sum d_\varphi^2=1=\sum\mu^2$ | ordered, with the halving explicit and $\sum\mu^2=1$ as the anchor |
| [diagonal-half.md](../findings/diagonal-half.md) lines 15 and 27 | $\sum_{a<b}w_{ab}^2=1$ at line 15, $\operatorname{tr}M^2=2$ at line 27 | **both forms, twelve lines apart, with the factor right** |
| [diagonal-half.md](../findings/diagonal-half.md) line 273 | $\sum\kappa^2=\lVert K\rVert_F^2=t\le2$ over $K$'s eigenvalues | ordered, and correct, since $\sum_i\lambda_i(K)^2=\lVert K\rVert_F^2$ |
| [target.md](../findings/target.md) line 17 | $\sum R=1-t/2$, with $R=0$ at a diagonal point | ordered, the identity forces $t=2$ there |
| [target.md](../findings/target.md) line 50 | $K$ trace-free on $\mathbf1^\perp$ with Frobenius square $t\le2$, giving $\mu_1\le\sqrt{t(n-2)/(n-1)}$ | ordered, the eigenvalue bound needs the full matrix norm |

**The [diagonal-half.md](../findings/diagonal-half.md) row is the interesting one and it is not a defect.** That file states its normalisation as $\sum_{a<b}w_{ab}^2=1$ (the unordered sum, equal to $1$) and then, twelve lines later, the same constraint as $\operatorname{tr}M^2=2$, the ordered sum, equal to $2$. **The two are the same constraint and the file converts correctly**, which is what a consumer under a settled convention looks like. Its header says so: *"Definitions and normalisations are quoted from [conventions.md](../findings/conventions.md)"*.

**The one genuine mismatch on the record was caught, and it is filed as such.** [second-order.md](../findings/second-order.md) line 1397, among the defects of the **withdrawn** [Lemma L150](../findings/second-order.md): *"The norm was wrong. [conventions.md](../findings/conventions.md) fixes $\lVert K\rVert_F^2=2$ over ordered pairs, so '$\lVert M\rVert\le\lVert W\rVert=1$' is false as written; only the explicitly unordered sum keeps the stated threshold."* **So the convention has already been used, once, in anger, to refute a lemma**, which is the strongest available evidence that the record holds it fixed rather than merely tabling it.

**Two derived quantities also check out under the ordered reading, and would not under the other.** $\kappa^2(\mathbb{CP}^m)=3/(m+1)$ ([L95](../findings/bispectral.md)) equals $\frac{2m+1}2$ times the recorded generic value $\mathbb E_F\lVert K(F)\rVert_F^2=\frac{12}{(n+1)(n+2)}\lVert M\rVert_F^2$ at $n=2m$: $\frac{2m+1}2\cdot\frac{12}{(2m+1)(2m+2)}=\frac3{m+1}$, an identity. **Both formulas therefore share one reading**, and $\kappa^2(\mathbb{CP}^2)=1$ matches the $\kappa^2=1$ recorded for padded $W_{\mathbb{CP}^2}$ at [second-order.md](../findings/second-order.md) line 1604. Under the unordered reading each would have to be halved.

## 6. Whether *"closed"* is the right status

**For the reading: yes, and on more support than the claim cites.** The reading is tabled with the index set spelled out (line 136), derived from a fixed normalisation (line 138's third sentence), restated independently with the conversion written out ([stratum-two-negative.md](../findings/stratum-two-negative.md) line 363), consumed consistently by six blocks (section 5), and already exercised once to refute a lemma (section 5). **Under the ordered reading $\kappa^2=2$ is attained at every coordinate-diagonal $W$ (section 4), so the hazard's conclusion (*"$\kappa^2=2$ holds nowhere"*), is false, and [I36](../plan.md) is not refuted by a convention.**

**For the citation: no, and this is the review's finding.** L174's box says *"[conventions.md](../findings/conventions.md) tables the ordered reading and shows the other is inconsistent with the bound itself"* and then quotes the one clause of the box that shows no such thing. **A reader auditing L174 by following its quotation lands on a circular argument**, and the record's own [L114.lean](../lean/HamiltonsCubic/Results/L114.lean) tells that reader that ordered-against-unordered is an invertible rescaling. *The remedy is one clause long*: quote line 138's operator sentence, or cite L94's factor $2$.

**And the claim's closing sentence (*"what L174 owed was the citation rather than the argument"*), is right in outcome and wrong in detail.** L174 owed the citation; the citation it then supplied points at the wrong sentence. **GAP**, not BROKEN: the mathematics is untouched.

## 7. What would reopen it

1. **The letter $M$, which is the live one.** L94's $\kappa^2\le2\lVert M\rVert_F^2$ is safe only under [conventions.md](../findings/conventions.md) line 92's sense of $M$ ($\Lambda^2$ operator, $\lVert M\rVert_F=1$). If a future edit resolves the line 92/line 153 collision toward the sectional sense, L94 reads $\kappa^2\le4$, L174's *"at unit norm that reads $\kappa^2=2$"* becomes false, and the factor $2$ is lost through the norm instead of through the index set. **The record notes the debt**, [second-order.md](../findings/second-order.md) line 1060, *"[conventions.md](../findings/conventions.md) flags the letter $B$ and owes a row for $M$"*, **and it is still owed.**
2. **A consumer writing $t$ or $\kappa^2$ against an unordered index set with a numeral and no conversion**, which is what [L150](../findings/second-order.md) did. The tell is a bare $\sum_{a<b}$ next to a $2$, or a $t\le1$.
3. **An edit to line 136 that drops $\sum_{a\ne b}$ and leaves only $\lVert K\rVert_F^2$ with $K$ written as a family $(W_{abab})_{a<b}$**, the exact ambiguity the box confesses. The word *"matrix"* on line 136 is load-bearing and should stay.
4. **A new consumer citing L94 without its norm sense**, since L94's own factor $2$ is the doubling and is the cheapest anchor the record has.

## Overall verdict

**PROVEN, hypotheses corrected.** The ordered reading is what [conventions.md](../findings/conventions.md) tables, it is what [L94](../findings/bispectral.md) was derived under, $t=2$ is attained exactly at coordinate-diagonal, verified in closed form at $S^m\times S^m$, and no block on the record consumes $t$ under the other reading. **The hazard is real and closed, and [I36](../plan.md) is not refuted by a convention.** What is corrected is the ground: the quoted sentence assumes the constant it tests and is a rescaling argument as it stands; the refutation lives in the definitional reading of $\lVert K\rVert_F^2$ as a matrix norm, in line 138's unquoted operator sentence, and in L94's own factor $2$.
