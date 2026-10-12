# REVIEW r575, Observation L25

Reviewer r575, independent adversarial audit. Target: **Observation L25, every ungraded critical point on file fails the second-order bound**, at [findings/second-order.md](../findings/second-order.md), block lines 247–257, read with the section preamble at lines 239–243 that carries its attributions.

Standing rule honoured: analysis only. Every number below is either derived by hand in this report or quoted from the record with its location. No sweep, census, search or falsifier hunt was run, and no screen was needed.

## Overall verdict: REFUTED

**A structured ungraded critical point on record satisfies $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$**, and a second, independent contradiction sits between two consecutive sentences of the block itself. Two of the six defects below are repairable in place; the headline one is not, and what a repair owes is named in §7.

| # | defect | verdict |
| --- | --- | --- |
| D1 | $W_{\mathbb{CP}^2}$ at $n=4$ is ungraded, structured, on record, and has $\lambda_{\max}=\tfrac12$ exactly | **REFUTED** |
| D2 | the range $[1.17,\,96.3]$ is contradicted by the block's own next sentence | **REFUTED** |
| D3 | the heading promises a proof for an Observation, and there is no proof | **CONFIRMED** |
| D4 | "$K$-invariant directions are multiples of $W$" is false, and the record says so | **REFUTED** |
| D5 | the population is not enumerable, and $\theta>0$ is an omitted hypothesis | **CONFIRMED** |
| D6 | the $\mathfrak u(m)$ entry is unscoped; the graded-violator list is complete only for native points | **REPAIRED** |
|, | the reported `L7 -> L25` and `L51 -> L25` edges | **artefact, cleared** |

## 1. D1, the refutation, derived by hand

The block claims that across its population **none satisfies $\lambda_{\max}\le\tfrac12$**. Take $W_{\mathbb{CP}^2}$ at $n=4$. It is on record, it is the record's canonical structured point, and the record calls it ungraded three times, twice inside the file under audit:

- [second-order.md:241](../findings/second-order.md), the preamble to L25's own section: *"$W_{\mathbb{CP}^2}$ is the first nondegenerate ungraded critical point on record."*
- [second-order.md:123](../findings/second-order.md): padded $W_{\mathbb{CP}^2}$ *"is ungraded"*.
- [bounds.md:59](../findings/bounds.md), inside [Lemma L7](../findings/bounds.md)'s block, and this is the decisive one because it is structural rather than a screen: at $W_{\mathbb{CP}^2}$, $n=4$, $\dim E_+=1$, $\dim E_-=2$, $\dim\ker W=3$, so $E_+\oplus E_-$ is three-dimensional inside a six-dimensional $\mathfrak{so}(4)$ and **there is no $\mathbb Z_2$-grading at all**.

### The value, from the definitions

I take the point from [conventions.md](../findings/conventions.md) and the anchor at [second-order.md:296](../findings/second-order.md): $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4$, with $\theta=\sqrt{3/2}$.

At $n=4$, $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ and $\mathcal W_4=\mathrm{Sym}_0(\Lambda^+)\oplus\mathrm{Sym}_0(\Lambda^-)$, dimension $5+5=10=\dim\mathcal W_4$. The two $\mathfrak{su}(2)$ factors commute, so no structure constant couples them and $Q$ acts blockwise. On each $3\times3$ block $\#$ is a multiple of the adjugate, since $\mathrm{adj}(X)_{ab}=\tfrac12\epsilon_{a\gamma\epsilon}\epsilon_{b\delta\zeta}X_{\gamma\delta}X_{\epsilon\zeta}$. **I pin that multiple against the record's own $\theta$ rather than assuming a normalisation.** With $\langle X,Y\rangle=\operatorname{tr}(XY)$ on operators, the pairing [conventions.md](../findings/conventions.md) fixes by $\operatorname{tr}(W^2)=1$, the $\tfrac12$ sitting at the $\Lambda^2$ level, writing $Q(W)=W^2+c\,\mathrm{adj}(W)$ blockwise gives $\operatorname{tr}(W^3)=1/\sqrt6$ and $\operatorname{tr}(W\,\mathrm{adj}(W))=3\det(W_+)=1/\sqrt6$, so $\theta=\sqrt{3/2}$ forces $c=2$:

$$Q(W)=\big(W_+^2+2\,\mathrm{adj}(W_+),\ W_-^2+2\,\mathrm{adj}(W_-)\big).$$

Criticality reproduces exactly: $W_+^2+2\,\mathrm{adj}(W_+)=\mathrm{diag}(-3,-3,6)/6=\mathrm{diag}(-1,-1,2)/2=\theta W_+$, and $Q_-=0=\theta W_-$.

Polarising, $X\circ Y=\tfrac12(XY+YX)+2\,\mathrm{Adj}(X,Y)$ with $\mathrm{Adj}$ the polarised adjugate. For $3\times3$ matrices $\mathrm{adj}(X)=X^2-\operatorname{tr}(X)X+\tfrac12[(\operatorname{tr}X)^2-\operatorname{tr}(X^2)]I$, so $\mathrm{Adj}(X,Y)=\tfrac12(XY+YX)-\tfrac12(\operatorname{tr}(X)Y+\operatorname{tr}(Y)X)+\tfrac12[\operatorname{tr}X\operatorname{tr}Y-\operatorname{tr}(XY)]I$. Two consequences:

- **On $\mathrm{Sym}_0(\Lambda^-)$ the operator vanishes identically.** $e_-=0$ and $\mathrm{Adj}(0,Y)=0$, so $L_e$ is zero on a five-dimensional space.
- **On $\mathrm{Sym}_0(\Lambda^+)$**, with $E:=e_+=W_+/\theta=\mathrm{diag}(-1,-1,2)/3$ (idempotent, since $E^2+2\,\mathrm{adj}(E)=\mathrm{diag}(-3,-3,6)/9=E$), both traces drop and

$$L_E(Y)=\tfrac32(EY+YE)-\operatorname{tr}(EY)\,I .$$

Diagonalising with $\epsilon=(-1,-1,2)/3$: the off-diagonal $Y=E_{ab}+E_{ba}$ give $\lambda=\tfrac32(\epsilon_a+\epsilon_b)$, that is $-1$ at $(1,2)$ and $\tfrac12$ twice at $(1,3)$ and $(2,3)$; the trace-free diagonals give $\lambda=-1$ at $(1,-1,0)$ and $\lambda=1$ at $(1,1,-2)\propto E$. So

$$\operatorname{spec}\big(L_e\big)=\big\{1^{(1)},\ \tfrac12^{(2)},\ 0^{(5)},\ (-1)^{(2)}\big\},\qquad \boxed{\lambda_{\max}\big(L_e\vert_{W^\perp}\big)=\tfrac12 .}$$

### Four checks the construction had no freedom to pass

| check | source | result |
| --- | --- | --- |
| $\operatorname{tr}(L_e)=0$ | [second-order.md:217](../findings/second-order.md) | $1+1+0-2=0$ |
| $\operatorname{tr}(L_e^2)=\kappa_W/\theta^2$, $\kappa_W=(2n-1)(n-1)/4$ | [second-order.md:217](../findings/second-order.md) | $1+\tfrac12+2=\tfrac72=(21/4)/(3/2)$ |
| $\dim E(\tfrac12)=\dim\mathcal O$ | [second-order.md:241](../findings/second-order.md)'s $\binom n2-4-\binom{n-4}2$; and $\dim\mathcal O=2$ measured at [r297](REVIEW_r297.md) | $2=2$ |
| $\dim E_+=1$, $\dim E_-=2$, $\dim\ker W=3$ | [bounds.md:59](../findings/bounds.md) | $2/\sqrt6$ once, $-1/\sqrt6$ twice, $0$ on all of $\Lambda^-$ |

### The same conclusion in one line, sharing nothing with the derivation

[conventions.md](../findings/conventions.md) records $M(4)=\sqrt{3/2}$ (the global maximum of $P$ on the unit sphere of $\mathcal W_4$) and $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$. So $W_{\mathbb{CP}^2}$ **is** the $n=4$ maximiser, and [Lemma L24](../findings/second-order.md) forces $\lambda_{\max}\le\tfrac12$ at it directly. The hand computation says the value is exactly $\tfrac12$; the maximiser argument says it is at most $\tfrac12$. Either alone refutes the block.

### Corroboration the block could have had, and the reach of the failure

[second-order.md:123](../findings/second-order.md), one hundred and twenty-four lines **above** the block, states the same failure at the padded point and draws the same conclusion in bold: *"Padded $W_{\mathbb{CP}^2}$ at $n=5$ … has $\lambda_{\max}(L_e|_{W^\perp})=0.5000000000$. So 'ungraded $\Rightarrow\lambda_{\max}>\tfrac12$' is false"*, with [:127](../findings/second-order.md) adding that the value is on record at $n=5$ **and** $n=8$. The block was written past a sentence in its own file that contradicts it. [ELIM-secondorder.md](ELIM-secondorder.md) §W4 found this and the block is unrepaired.

**The failure reaches the block's motivating sentence too.** *"Conjecture A needs only one direction: that an ungraded critical point with $\theta\ge\theta_0(n)$ cannot be a maximizer."* At $n=4$, $\theta_0(4)=\sqrt{3/4}=0.866$ and $W_{\mathbb{CP}^2}$ has $\theta=1.2247\ge\theta_0(4)$, is ungraded, and **is** the maximiser. The sentence is false as quantified, and the reason is on the record: [problem.md:445](../findings/problem.md) records that Conjecture A *"carries an explicit $\mathbb{CP}^2$ exception at $8\le n\le11$ and drops it at $n\ge12$"*. The block states the conjecture without the exception the conjecture carries.

## 2. D2, the range is refuted by the next sentence

The claim and its successor sentence are consecutive:

> Across 155 converged critical points at $n=6$ (all ungraded), **together with every structured ungraded point on record**, $\lambda_{\max}(L_e|_{W^\perp})$ ranges over $[1.17,\,96.3]$ … On the subalgebra family … the values are exact rationals: $\tfrac34$ at the $\mathfrak{su}(3)$ bi-invariant and at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, $\tfrac56$ at the $\mathfrak{so}(5)$ adjoint, and $1$ across the multi-block products.

$\tfrac34$, $\tfrac56$ and $1$ are all below $1.17$. The section preamble at [:243](../findings/second-order.md) names those same points as **ungraded** (*"Ungraded points violate by a wide margin), excess $\tfrac14$ at the $\mathfrak{su}(3)$ bi-invariant, at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ … $\tfrac13$ at the $\mathfrak{so}(5)$ adjoint"*, and they are structured and on record. There is no reading that saves both halves:

- if the union is the population, $\min\lambda_{\max}\le\tfrac34<1.17$ and the range is false;
- if the range is scoped to the $155$ alone, the sentence says otherwise and the structured half of the population then carries no stated range at all.

The floor $1.17$ describes the $n=6$ solver output, and only that. Note that the independent runs on record floor higher still, $[1.479500,\,96.291798]$ at [r299](REVIEW_r299.md), $[1.670152,\,96.291798]$ at [r300](REVIEW_r300.md), which is consistent with $1.17$ being a sampling artefact rather than a bound.

## 3. D3, heading versus label

The heading reads *"canonical statement and proof"*. **The block contains no proof and cannot contain one**: its content is a range over an enumerated population, which is evidence. The label `Observation` is right and the heading is wrong; the three words *"and proof"* come out.

**A downgrade is not available here as a repair, because the label is already the weaker one.** What the heading change owes is the opposite of the usual debt, nothing is demoted, so nothing becomes owed by that edit alone. What D1 and D2 owe is set out in §7.

## 4. D4, the three eliminations

> Three candidate constructions of the violating direction are already eliminated, rank-two directions are capped at $0$, $K$-invariant directions are multiples of $W$, and the slack's own subspace $\mathrm{Sym}^2(\mathfrak m)$ is strictly negative.

| construction | status | evidence |
| --- | --- | --- |
| rank-two directions capped at $0$ | **unsupported**, the sentence is the only occurrence of the phrase in [findings/](../findings/); no proof, no measurement, no citation |, |
| $K$-invariant directions are multiples of $W$ | **REFUTED, by the record** | [diagonal-half.md:181](../findings/diagonal-half.md) |
| $\mathrm{Sym}^2(\mathfrak m)$ strictly negative | measured, and the operator is never named | [nondegeneracy.md:29](../findings/nondegeneracy.md), [:31](../findings/nondegeneracy.md) |

**The second is the substantive one.** [diagonal-half.md:181](../findings/diagonal-half.md) records that the obstruction *"is a property of SYMMETRIC points only"*, and gives the witness: at an $n=8$ point with $\Delta=11.16$ and $\lvert\mathrm{Aut}(M)\rvert=2$, the top eigenspace is one-dimensional, its eigenvector is fixed pointwise with deviation $0$, and **invariant directions reach the full $\lambda_{\max}$**. So a $K$-invariant direction that is not a multiple of $W$ exists and attains the violation. What survives is the narrower statement that file states, a *uniform* equivariant recipe fails, because it must also fire at the symmetric points, where the maximum invariant Rayleigh quotient is $0.000$ against $\theta/2=0.335$. The block asserts the refuted general form.

**The third is measured, not proved, and its object is ambiguous.** [nondegeneracy.md:29](../findings/nondegeneracy.md) reports the ungradedness form $F(C)=\sum C_{ij}C_{kl}\langle M_{ik},M_{jl}\rangle$ on $\mathrm{Sym}^2(\mathfrak m)$ as **indefinite**, range $[-2.000,\,4.000]$ at the $\mathfrak{su}(3)$ bi-invariant and $[-0.200,\,1.200]$ at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$. If "strictly negative" names $F$ it is false at both points the block itself uses; if it names $L_e-\tfrac12$ there it is a two-point measurement, and [:31](../findings/nondegeneracy.md) records that the construction *"does not survive the generic population"*. The block names no operator, so the reader cannot tell which claim is being made.

**Corroboration the block is entitled to and does not take.** Three places on the record reproduce its ceiling $96.291798$ from implementations that never read it, [second-order.md:603](../findings/second-order.md), [bounds.md:82](../findings/bounds.md), [r299:137](REVIEW_r299.md) and [r300:13](REVIEW_r300.md). That is the strongest support the census has, it is independent, and the block cites none of it.

## 5. D5, the population, the quantifier, and the missing hypothesis

**What set does the claim quantify over?** Two pieces, and neither is enumerable today.

- **The $155$.** No script, no data file, no reviewer number, no residual tolerance and no sampling method appear in the block, and nothing else in [findings/](../findings/) carries the figure. A reader cannot reconstruct the set, so the range cannot be checked and a claimed counterexample cannot be tested for membership. [ELIM-secondorder.md](ELIM-secondorder.md) §W4 adds the structural point: [nondegeneracy.md:332–339](../findings/nondegeneracy.md) proves a residual-cutoff root-finder reaches only *nondegenerate* zeros, so the population is the ungraded nondegenerate set by construction rather than by observation. [ELIM-canon.md](ELIM-canon.md) §W2 adds that it lives entirely below the $\theta$ crossover.
- **"Every structured ungraded point on record."** *Structured* has no definition anywhere, including [conventions.md](../findings/conventions.md); *on record* moves with every commit. The claim is therefore not falsifiable as written (a witness can always be argued out of the population) while §1 shows it is false under every reading that admits the points the block's own preamble names.

**The quantifier is over both $n$ and the population.** The census half is at $n=6$; the structured half ranges over $n=4,5,8,9,10,\dots$, since the block's own examples include $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ at $n=5$. So a single ungraded structured point at any $n$ with $\lambda_{\max}\le\tfrac12$ falsifies it, which is what §1 supplies.

**The omitted hypothesis is $\theta>0$, and it is load-bearing.** The section preamble states it in bold at [:23](../findings/second-order.md), *"at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses"*, because $e=W/\theta$ flips sign with $\theta$. L25 carries no such hypothesis, while [r298:119](REVIEW_r298.md) records a converged critical point at $\theta=-0.088829$. Any $\theta<0$ point inside the $155$ is being scored against a criterion that reverses there.

**What else the block leans on that is undefined.** *Graded*, which [conventions.md](../findings/conventions.md) says carries three incomparable senses (C), (A), (B), and the sense is load-bearing here, since the block calls $W_{\mathbb{CP}^3}$ graded while its own preamble calls $W_{\mathbb{CP}^2}$ ungraded, both members of the $\mathfrak u(m)\subset\mathfrak{so}(2m)$ family. Also *converged*, *primitive* (in *"the value $1$ records that the idempotent is not primitive"*), and *structured*.

**The norm is used correctly.** $\lambda_{\max}(L_e\vert_{W^\perp})$ takes $L_e=e\circ(\cdot)$ with $\circ$ as [conventions.md](../findings/conventions.md) fixes it, $W^\perp$ in sense (i) of the four objects under $\Pi$, and the operator-level pairing $\operatorname{tr}(XY)$, which is what makes $\operatorname{tr}(L_e^2)=\kappa_W/\theta^2$ come out at $\tfrac72$ in §1. No normalisation defect found.

## 6. D6, the "what it does not say" list

Both named graded violators check out exactly against results audited independently.

| family | L25's value | independent source | verdict |
| --- | --- | --- | --- |
| $\mathfrak u(m)\subset\mathfrak{so}(2m)$ | $\frac{m+2}{2(m+1)}$ | [Lemma L28](../findings/nondegeneracy.md) states $\lambda_{\max}(L_e\vert_{W^\perp})=\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)}$ | **matches, for $m\ge3$** |
| $S^2\times S^{n-2}$ | $\tfrac12+\frac1{2(n-3)}$ | [Lemma L126](../findings/second-order.md) gives $\mu_{2,q}=\frac q{2(q-1)}$; at $q=n-2$ that is $\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}$ | **matches identically** |

Spot-checks against measurements taken elsewhere agree: $\mathbb{CP}^3$ at $\tfrac58=0.625$, $\mathbb{CP}^4$ at $0.600$, $S^2\times S^4$ at $\tfrac23=0.666667$, all in [r297:86](REVIEW_r297.md).

Two corrections, both cheap:

- **The $\mathfrak u(m)$ entry needs its $m\ge3$**, which is where [L28](../findings/nondegeneracy.md) states it. At $m=2$ the value is not $\tfrac23$: §1 derives $\tfrac12$. The $\mathbb{CP}^m$ table two paragraphs below the block flags the same boundary in its own way, at $m=2$ the summand $V_{(1,1);(1,1)}$ has formal dimension $\frac{m^2(m+1)(m-3)}4=-3$, so the table's carrier of $\frac2{m+1}$ is absent and the $\mathfrak{su}(m)$ adjoint that carries $\lambda_{\max}$ is not there either. **Unscoped, the entry asserts a violation at exactly the point that refutes the block.**
- **The list is complete for native points and incomplete once padding enters.** [r297:86](REVIEW_r297.md) records padded $S^3\times S^3$ at $n=8$ with $\lambda_{\max}=0.600000$, a violator in neither named family, since $S^3\times S^3$ is a $p,q\ge3$ split which the preamble at [:241](../findings/second-order.md) says has $\lambda_{\max}$ **exactly** $\tfrac12$. [Lemma L126](../findings/second-order.md) independently shows padding moves the four-set values: a four-set with two indices from the first factor, one from the second and one padded carries $\frac1{2(p-1)}$. *Flagged rather than asserted*: this point's gradedness rests on a screen that [conventions.md](../findings/conventions.md) and [W4](../findings/INDEX-traps.md) call vacuous when $\ker W\ne0$, and padding is exactly how the kernel grows.

## 7. What the reported Lemma edges are, and what a repair owes

**`L7 -> L25` and `L51 -> L25` are both artefacts, and no Lemma depends on L25.** [check.py:170–173](../.claude/skills/structure-check/check.py) delimits a Lemma's block from one `^#### Lemma` heading to the **next `#### Lemma` heading**, rather than to the next heading of any level. So:

- [Lemma L7](../findings/bounds.md)'s scanned block runs from [bounds.md:43](../findings/bounds.md) to `Lemma L106` at [:106](../findings/bounds.md), swallowing three intervening `####` sections and with them the two mentions of L25 at [:80](../findings/bounds.md) and [:82](../findings/bounds.md), neither of which is inside L7's statement or proof.
- [Lemma L51](../findings/second-order.md)'s scanned block runs from [:185](../findings/second-order.md) to `Lemma L120` at [:613](../findings/second-order.md) (four hundred and twenty-eight lines), swallowing **the whole of Observation L25's block** at [:247–257](../findings/second-order.md) and the corroboration line at [:603](../findings/second-order.md).

Reading L7 and L51 as written, neither takes the census, the range, or anything else from L25. **The refutation therefore has no Lemma downstream of it.** The scanner over-reports generally, and the fix belongs to the checker rather than to either Lemma: the block should end at the next heading of any level.

**What is owed.** The blast radius is two sentences. [results.md:136](../results.md) restates the claim and inherits the refutation verbatim. Both need the true statement, which is narrower in three ways at once and which the record has the material to write today:

> On the $n=6$ converged population, $\lambda_{\max}$ ranges over $[1.17,\,96.3]$ and none satisfies $\lambda_{\max}\le\tfrac12$, with the population named by its generator and tolerance, not by a count. **Among structured ungraded points, the bound is violated everywhere except on the $SO(n)$-orbit of $W_{\mathbb{CP}^2}$ and its paddings, where $\lambda_{\max}=\tfrac12$ exactly.**

The exception is not an inconvenience to be excluded. It is the same exception Conjecture A itself carries at $8\le n\le11$ ([problem.md:445](../findings/problem.md)), and at $n=4$ it is the maximiser. [ELIM-secondorder.md](ELIM-secondorder.md) §W4's proposed repair (adding *"excluding the $\dim\mathfrak m\le2$ stratum"*), states the exception by a proxy; naming the orbit states it by the object, and ties it to the exception the conjecture already carries.
