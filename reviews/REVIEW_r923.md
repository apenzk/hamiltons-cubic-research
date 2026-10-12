# Review r923, does Lemma L212 establish $\theta=1/(2\lVert W\rVert)$ on the multi-block family with no Einstein hypothesis?

**The round read a written derivation link by link and asked of each step whether it follows from the one above it and from the hypotheses actually stated.** Read: the L212 block and the census block above it in [findings/graded-half.md](../findings/graded-half.md), the whole of [findings/conventions.md](../findings/conventions.md), the [L46](../findings/problem.md), [L48](../findings/problem.md) and [L57](../findings/problem.md) blocks of [findings/problem.md](../findings/problem.md), the vertex-system and closed-form paragraphs of [findings/ungraded-slack.md](../findings/ungraded-slack.md), [verification/VERIFY_v158.md](../verification/VERIFY_v158.md), [verification/ROUND_L05.md](../verification/ROUND_L05.md), [reviews/REVIEW_r653.md](../reviews/REVIEW_r653.md), the canon entries at [findings/INDEX-results.md](../findings/INDEX-results.md) row 212 and [results.md](../results.md), [scripts/runs/screen_l212_vertex.py](../scripts/runs/screen_l212_vertex.py), and [lean/HamiltonsCubic/Results/L212VertexTheta.lean](../lean/HamiltonsCubic/Results/L212VertexTheta.lean), which I also built. **Every value below is exact rational or symbolic.** No sweep, census or search was run. Log: [agent_logs/gate2-l212-r923.log](../agent_logs/gate2-l212-r923.log).

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | $t_F=2$ in the vertex frame | GAP | true, because the vertex configuration is coordinate-diagonal in the block frame, which the block never states and the *"in some frame"* clause it cites does not give |
| 2 | $t$ a function of $K$ alone, the factor 4 | REFUTED | $\lVert W\rVert^2=t/2$ on the diagonal locus forces $\lVert W\rVert^2=4R$ at step 2's scale, so step 4's $\lVert W\rVert^2=R$ is a second representative, not a pair-basis normalisation |
| 3 | Step 2's arithmetic, $t=8R$ | CONFIRMED | proved here symbolically at every $k$ and every partition, not only screened, and checked at $(S^2)^5$, the record's smallest uncovered case, where both sides are $80/9$ |
| 4 | Step 1's Ricci-flatness | GAP | the row sums do exhaust $\operatorname{Ric}$ on the diagonal locus, which [L57](../findings/problem.md) proves, so step 1 establishes membership in $\mathcal W_n$, and the sentence about where the Einstein hypothesis went is false |
| 5 | What is $\theta_g$, and the scaling claim | GAP | $\theta_g$ is undefined in the block, it is simultaneously the Einstein constant and the criticality eigenvalue, and the scaling claim is true of the second reading only |
| 6 | Is the vertex solution critical | GAP | criticality is needed and is never asserted, and it is exactly the step [L46](../findings/problem.md) was supplying, with the two-line proof given in section 6 |
| 7 | Same $W$ in identity and step 2 | REFUTED | step 2's representative sits at $\theta_g=1$ and the identity's at $\theta_g=\tfrac12$, a factor $2$ in scale and $4$ in norm-squared |
| 8 | The bound's strictness | CONFIRMED | strict at every $k\ge2$ from two strict inequalities, and $k=1$ gives $R=0$, where the scale equation has no solution and the bound is ill-posed |
| 9 | The hypotheses actually dropped | REFUTED | the $2$ in $\theta=1/(2\lVert W\rVert)$ is $1/\lambda$ at $\lambda=\tfrac12$, so that hypothesis is carried by the conclusion's own form, while the other three are not premises and hold of every object in range |
| 10 | Padding | CONFIRMED | $t$, $\lVert W\rVert$ and $\theta$ are all padding-invariant and the block reads $n=\sum_an_a$, so the conclusion transports and the recorded failure is the ambient-$n$ substitution, a different operation |
| 11 | Already on the record | REFUTED as new | the value is [ungraded-slack.md](../findings/ungraded-slack.md)'s closed form, the route was queued as [ROUND_L05](../verification/ROUND_L05.md) F3, and the general-$k$ reconciliation is [VERIFY_v158.md](../verification/VERIFY_v158.md) §1 |
| 12 | What would break it | CONFIRMED | four falsifiers named, three tested and cleared, the fourth being the scale reading that section 2 refutes |

**One line:** the value $\theta=1/(2\sqrt R)$ and the bound $\theta<\sqrt{2/(k-1)}$ are correct and now proved at every $k$, and the block reaches them by omitting the criticality step L46 was for, by mis-scaling the norm it imports, and by claiming to have dropped the $\lambda=\tfrac12$ normalisation that its own headline formula is.

## 0. Conventions, fixed once

Quoted, never restated.

- $t=t_F=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ over **ordered** pairs, **per frame**, with $K_{ab}=W_{abab}$ ([conventions.md](../findings/conventions.md), the vertex-matrix section).
- $t=2\lVert\operatorname{diag}W\rVert^2$ with the diagonal in the pair basis, so $t\le2\lVert W\rVert^2$ by Cauchy-Schwarz, **with equality exactly when $W$ is coordinate-diagonal** (same section). Hence on the diagonal locus $\lVert W\rVert^2=t/2$ exactly, and that identity is what this review turns on.
- $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf1=0\}$, the vertex matrices of coordinate-diagonal Weyl operators, and the correspondence is a bijection with Ricci-flatness exactly $S\mathbf1=0$ ([L57](../findings/problem.md)'s block, *"asserted throughout the record and proved nowhere until this audit"*).
- $\Phi(M)=M^{\circ2}+M^2$ is the criticality map on the diagonal locus ([conventions.md](../findings/conventions.md), the $\Phi$ entry, sense (iii)).
- $\theta=P(W)/\lVert W\rVert^3$, and at a critical point $Q(W)=\theta W$. Criticality is $Q(W)=\theta W$ and nothing weaker.
- I write $\theta_g$ for the block's parameter, $R$ for the partition scalar, $D=n-1$, $u_a=\frac{n-n_a}{(n-1)(n_a-1)}$ for the within-block entry at $\theta_g=1$ and $v=-\frac1{n-1}$ for the across-block entry at $\theta_g=1$.

**The hypothesis inventory of the derivation as written**: the vertex solution's entry formula (imported from [r653](REVIEW_r653.md) and [ungraded-slack.md](../findings/ungraded-slack.md)), the multi-block norm identity $\lVert W\rVert^2=R$ (imported from the census block above it), $t=2$ on the diagonal locus (imported from [conventions.md](../findings/conventions.md)), every $n_a\ge2$, and the unstated coordinate-diagonality of the configuration. Sections 1 to 9 take these one at a time.

## 1. The normalisation, and what would have to be true for $t_F=2$

**Step 3 needs $t_F=2$ in the frame the vertex solution's $K$ is written in, and what it cites is the extremal clause.** The sentence quotes *"$t=2$ exactly on the diagonal locus, so a unit-norm coordinate-diagonal $W$ has $t=2$"*, and [conventions.md](../findings/conventions.md) states the equivalence with **coordinate-diagonal in some frame**, which is a statement about $\max_Ft_F$ over $O(n)$. The same file warns that substituting the extremal value into a formula meaning $t_F$ is unjustified. So the citation does not reach the step.

**What would have to be true, stated exactly.** $t_F=2$ at $\lVert W\rVert=1$ holds in the frame $F$ if and only if $W$ is coordinate-diagonal **in that frame**, since $t_F=2\lVert\operatorname{diag}_FW\rVert^2$ and $\lVert\operatorname{diag}_FW\rVert\le\lVert W\rVert$ with equality exactly when the off-diagonal pair-basis mass is zero.

**That is true of the vertex solution, and by construction.** The object the block names is a **sectional matrix** $K$, and a configuration presented by a sectional matrix alone is a coordinate-diagonal one: [L57](../findings/problem.md)'s block gives the bijection $\mathcal D_n\leftrightarrow$ the coordinate-diagonal part of $\mathcal W_n$, so specifying $K\in\mathcal D_n$ specifies a coordinate-diagonal Weyl operator and nothing else. [ungraded-slack.md](../findings/ungraded-slack.md) says the same of the family in words, *"on this family the operator is diagonal in coordinate 2-planes with entries depending only on the blocks the indices fall in"*.

**So the needed fact is available and the block does not state it.** Verdict GAP, repairable by one clause: *"the vertex solution is coordinate-diagonal in the block frame, so $t_F=2\lVert W\rVert^2$ in that frame and $t_F=2$ is exactly unit norm"*. Without the clause the step reads as the substitution the record warns against, and with it the step is exact.

## 2. Is $t$ a function of $K$ alone, and the factor of four

**The arithmetic the brief sets out is correct and it is not a normalisation.** On the diagonal locus all of $W$'s mass is on the pair-basis diagonal, so $\lVert W\rVert^2=t/2$ **exactly**. At the scale where step 2 computes $t=8R$ the configuration therefore has

$$\lVert W\rVert^2=\tfrac12\cdot 8R=4R,$$

while step 4 writes $\lVert W\rVert^2=R$. The two differ by $4$, and the unordered-against-ordered reading is not the explanation: that ambiguity is a factor $2$ between $\sum_{a<b}$ and $\sum_{a\ne b}$, and [conventions.md](../findings/conventions.md) has already fixed the ordered reading, under which $t=2$ at unit norm rather than $1$.

**The explanation is a difference of representative.** $K$ is linear in $\theta_g$, so $t=8R\theta_g^2$ and $\lVert W\rVert^2=4R\theta_g^2$ at parameter $\theta_g$. Then

$$\lVert W\rVert^2=R\iff\theta_g=\tfrac12 .$$

So step 2 is computed at $\theta_g=1$ and the imported identity holds at $\theta_g=\tfrac12$, and the factor $2$ in the headline $\theta=1/(2\lVert W\rVert)$ is exactly that conversion rather than a constant of the mathematics. **Read at one $W$ the headline is false**: at unit norm, where the record licenses reading the multiplier as $\theta$, it asserts $\theta=\tfrac12$ for every multi-block product, against $\theta=\sqrt{10}/3=1.054093$ at $(3,3)$.

**The canon carries the collapsed form of this.** [results.md](../results.md) states L212 as *"At unit norm $\theta=1/(2\lVert W\rVert)$ with $\lVert W\rVert^2=R$"*, whose two clauses are jointly satisfiable only at $R=1$, which no admissible partition gives. That is the defect in its shortest form.

**The scale-free statement, which is what the block should say.** With $\theta_g$ the criticality eigenvalue, $\theta=\theta_g/\lVert W\rVert$ at every scale, hence

$$\theta=\frac1{2\sqrt R},\qquad\text{equivalently}\qquad\theta^2=\frac1{4R},$$

a statement about the partition alone, with no representative to get wrong. Verdict REFUTED for the display, with the value intact.

## 3. Step 2's arithmetic, independently, and at every $k$

**The entry counts first.** A row in block $a$ has $n_a-1$ within-block and $n-n_a$ across-block entries, the ordered within-block pairs number $\sum_an_a(n_a-1)$ and the ordered across-block pairs $n^2-\sum_an_a^2$, so at $\theta_g=1$

$$t=\sum_an_a(n_a-1)u_a^2+\Big(n^2-\sum_an_a^2\Big)v^2=\sum_a\frac{n_a(n-n_a)^2}{(n-1)^2(n_a-1)}+\frac{n^2-\sum_an_a^2}{(n-1)^2},$$

which is the block's display, term for term.

**And it equals $8R$ at every $k$ and every partition, symbolically.** Using $\frac{n_a}{n_a-1}=1+\frac1{n_a-1}$,

$$tD^2=\sum_a(n-n_a)^2+\sum_a\frac{(n-n_a)^2}{n_a-1}+n^2-\sum_an_a^2=(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1},$$

the first and third groups collapsing because $\sum_a(n-n_a)^2=kn^2-2n^2+\sum_an_a^2$. Then from $(n-1)^2-(n-n_a)^2=(n_a-1)(2n-1-n_a)$ and $\sum_an_a=n$,

$$\sum_a\frac{(n-n_a)^2}{n_a-1}=D^2\sum_a\frac1{n_a-1}-\big(2kn-n-k\big),$$

so $tD^2=(k-1)n^2+D^2\sum_a\frac1{n_a-1}-2kn+n+k$, while $8RD^2=(k-1)D^2+D^2\sum_a\frac1{n_a-1}-D$ has constant part $(k-1)n^2-2(k-1)n+(k-1)-n+1=(k-1)n^2-2kn+n+k$. **The two agree identically**, so $t=8R$ at every $k$ and every partition with $n_a\ge2$, with no partition excluded.

**A partition the Gate 1 screen does not cover.** The screen's list stops at $(2,2,2,2,2)$, which is the record's named smallest uncovered case for the identity, so I took the next uncovered one, $(2,2,2,2,2,2,2)$ at $k=7$, $n=14$: $u_a=\frac{12}{13}$, $v=-\frac1{13}$, within-block ordered pairs $14$, across $196-28=168$, so $t=\frac{14\cdot144+168}{169}=\frac{2184}{169}=\frac{168}{13}$, against $8R=6+7-\frac1{13}=\frac{168}{13}$. Equal. I also reran the named case $(2,2,2,2,2)$ by hand: $R=\tfrac12+\tfrac18\cdot\tfrac{44}9=\tfrac{10}9$ and $t=\frac{10\cdot64+80}{81}=\frac{720}{81}=\frac{80}9=8R$.

**No factor of two is loose here.** Verdict CONFIRMED, and stronger than the block claims for it: this is a proof at every $k$, which retires the *"screened at nine partitions"* framing of step 2 and, with section 2's $\lVert W\rVert^2=t/2$, discharges the identity's own $k\ge5$ debt at the $\theta_g=\tfrac12$ representative. Section 11 says what of that was already on the record.

## 4. Step 1's Ricci-flatness, and what $\operatorname{Ric}$ contracts

**What $\operatorname{Ric}$ contracts.** For an algebraic curvature operator, $\operatorname{Ric}(R)_{ij}=\sum_kR_{ikjk}$, an $n\times n$ symmetric matrix, so it has $\binom{n+1}2$ components while the rows of $K$ give $n$ numbers. **In general the row sums are one contraction among many.** The off-diagonal components $i\ne j$ read the pair-basis entry $R_{(ik),(jk)}$, which is off-diagonal whenever $i\ne j$.

**On the diagonal locus they do exhaust it.** For a coordinate-diagonal $W$ every such off-diagonal entry vanishes, so $\operatorname{Ric}(W)=\operatorname{diag}\big(\sum_kK_{ik}\big)$ and $\operatorname{Ric}(W)=0$ is exactly $K\mathbf1=0$. The record proves this: [L57](../findings/problem.md)'s block gives *"Ricci-flatness is exactly $S\mathbf1=0$"* with the bijection onto $\mathcal D_n$. So step 1's computation is right, and it is right for the reason step 1 does not give, namely coordinate-diagonality again.

**But the conclusion drawn from it is false.** Every element of $\mathcal W_n$ is Ricci-flat by definition, the trace-free Ricci and scalar pieces being zero ([conventions.md](../findings/conventions.md), the $R_I,R_{\mathrm{ric}_0},R_W$ entry), so what step 1 establishes is that the vertex solution's $K$ lies in $\mathcal D_n$, that is, **that the configuration is a Weyl tensor at all**. That is a well-posedness check, and it discharges nothing. [L46](../findings/problem.md)'s Einstein hypothesis is a hypothesis on a **metric**, $\operatorname{Ric}=\lambda g$, and it is spent on getting $Q(R)=\lambda R$ out of [Richard-Seshadri](../references/richard-seshadri-2013-noncoercive-cones/notes.md) Lemma 4.1, that is, on **criticality**. Algebraic Ricci-flatness of $W$ and the Einstein condition on a metric are different statements, and the first cannot absorb the second.

**So the sentence *"that is where the Einstein hypothesis went: it was doing work the construction already does"* is false**, and the block's one named mechanism for removing the four hypotheses does not do it. Verdict GAP. What genuinely replaces L46 is the direct verification of criticality, which section 6 supplies and the block omits.

## 5. What $\theta_g$ is, and whether the scaling claim is earned

**$\theta_g$ is undefined in the block**, which calls it *"multiplier"* without saying multiplier of what. Two readings are in play and both turn out to name the same number on this family.

- **The Einstein constant.** For the product metric with $S^{n_a}$ of sectional curvature $c_a$, $\operatorname{Ric}=c_a(n_a-1)$ on block $a$, so the metric is Einstein with constant $\lambda$ exactly at $c_a=\lambda/(n_a-1)$. Its Weyl part is the coordinate-diagonal tensor with $K_{ij}=c_a-s$ within block $a$ and $-s$ across, where $s$ is pinned by $K\mathbf1=0$, that is $\lambda-(n-1)s=0$ and $s=\lambda/(n-1)$. This gives $K_{ij}=\lambda\frac{n-n_a}{(n_a-1)(n-1)}$ within and $-\frac\lambda{n-1}$ across, **which is the vertex solution with $\theta_g=\lambda$**.
- **The criticality eigenvalue.** Section 6 shows $Q(W)=\theta_gW$ for the same configuration. The two readings agree, as [L46](../findings/problem.md)'s own $Q(W)=\lambda W$ predicts they must.

**The scaling claim is true of the second reading only.** $Q$ is homogeneous of degree two, so $Q(cW)=c^2Q(W)=c\theta_g(cW)$ and the eigenvalue scales by $c$. Under the record's tabled $\theta=P(W)/\lVert W\rVert^3$ the quantity is scale-**invariant**, so had "multiplier" meant $\theta$ the claim would be false. **The block is entitled to the scaling claim**, and only because $\theta_g$ is the eigenvalue, which is the reading that needs criticality to exist at all. Verdict GAP: the claim holds, the definition that makes it hold is absent, and with it the block would have had to state criticality.

**The letter is a live hazard.** [ungraded-slack.md](../findings/ungraded-slack.md) and [r653](REVIEW_r653.md) write this same parameter as $\theta$, the tabled letter for the scale-invariant quantity, which is precisely the raw-eigenvalue trap [conventions.md](../findings/conventions.md) records at $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$. **Four representatives of one family are now in circulation**: $\theta_g=1$ (step 2), $\theta_g=\tfrac12$ (the norm identity, and L46's $\lambda$), $\theta_g=\frac{n-1}{pq}$ (conventions' raw $W_{p,q}$, which at $(3,3)$ has $\lVert W\rVert^2=\tfrac5{18}$ against the identity's $\tfrac9{40}$), and $\theta_g=1/(2\sqrt R)$ (unit norm). Renaming the parameter $\theta_g$ was right and leaving it undefined undoes the gain.

## 6. Is the vertex solution a critical point, and does the argument need it

**It is needed.** Step 4 reads the multiplier at unit norm as $\theta$, which the record licenses only at a critical point, $\theta$ being $P(W)/\lVert W\rVert^3$ otherwise and the bracket form $[W,Q(W)]=0$ being strictly weaker and satisfied by every diagonal Weyl tensor. Every use of $\theta_g$ as an eigenvalue, the scaling claim of section 5 included, needs it too. **The block never says the vertex solution is critical**, and this is the one step [L46](../findings/problem.md) was supplying, so its absence is the hole the repair was meant to fill.

**It is available, in two lines.** On the diagonal locus criticality is $\Phi(K)=\theta_gK$ off the diagonal with $\Phi(M)=M^{\circ2}+M^2$. At $\theta_g=1$, for $i\ne j$ in one block $a$,

$$\Phi_{ij}=u_a^2+(n_a-2)u_a^2+(n-n_a)v^2=\frac{n-n_a}{(n-1)^2}\Big[\frac{n-n_a}{n_a-1}+1\Big]=\frac{n-n_a}{(n-1)(n_a-1)}=u_a,$$

and for $i\in a$, $j\in b$ with $a\ne b$, using $(n_a-1)u_a=\frac{n-n_a}{n-1}$,

$$\Phi_{ij}=v\Big[v+\frac{n-n_a}{n-1}+\frac{n-n_b}{n-1}+(n-n_a-n_b)v\Big]=v\cdot\frac{-1+2n-n_a-n_b-n+n_a+n_b}{n-1}=v.$$

**So $\Phi(K)=\theta_gK$ at every partition with every $n_a\ge2$**, by homogeneity from $\theta_g=1$, and with $\mathcal D_n$'s bijection this is $Q(W)=\theta_gW$. The record corroborates it numerically, [ungraded-slack.md](../findings/ungraded-slack.md) calling the same solution *"an exact critical point at residual $10^{-16}$ against the full structure-constant $Q$"*.

**Verdict GAP, and this is the repair that matters**: two displays, no hypothesis beyond $n_a\ge2$, and with them the chain genuinely stops needing L46, Richard-Seshadri and the irreducible framing. As written the block claims that outcome without performing the step that delivers it.

## 7. Is the conclusion's $W$ the same $W$ whose $K$ was written

**No.** Section 2 settles it: step 2's representative has $\theta_g=1$ and $\lVert W\rVert^2=4R$, the identity's has $\lVert W\rVert^2=R$ and therefore $\theta_g=\tfrac12$, and the unit-norm one has $\theta_g=1/(2\sqrt R)$. **Three scales, one family, and the equality $\lVert W\rVert^2=R$ holds at a scale step 2 does not use.** Checked at $(3,3)$, where $n=6$ and $R=\tfrac9{40}$: at $\theta_g=1$ the entries are $\tfrac3{10}$ and $-\tfrac15$ with $t=\tfrac95$ and $\lVert W\rVert^2=\tfrac9{10}=4R$, at $\theta_g=\tfrac12$ they are $\tfrac3{20}$ and $-\tfrac1{10}$ with $\lVert W\rVert^2=\tfrac9{40}=R$, and at unit norm $\theta=\theta_g=\sqrt{10}/3$.

**The conclusion is true of the family and the sentence carrying it is not a statement about one configuration.** Verdict REFUTED for the identification, and the fix is to write $\theta^2=1/(4R)$, or to name the representative wherever $\lVert W\rVert$ appears.

## 8. The bound's strictness, and where it is vacuous

**At $k\ge2$ the bound is strict, for the reason given.** Each $n_a<n$ gives $\frac1{n_a-1}>\frac1{n-1}$ strictly, and there are $k\ge2$ such terms, so $\sum_a\frac1{n_a-1}-\frac1{n-1}>0$ and $R>\frac{k-1}8$ strictly, whence $\theta=\frac1{2\sqrt R}<\frac1{2}\sqrt{\frac8{k-1}}=\sqrt{\frac2{k-1}}$. **The block's own inequality $\frac1{n_a-1}\ge\frac1{n-1}$ is stated non-strictly and the conclusion needs it strict**, which $k\ge2$ supplies and which the block does say in the next clause.

**$k=1$.** There $n_1=n$, the inequality is an equality, $R=0$, and three things fail together: $\theta=1/(2\sqrt R)$ divides by zero, the scale equation $8Rc^2=2$ has no solution, and $\sqrt{2/(k-1)}$ is undefined. This is consistent rather than wrong, since at $k=1$ the vertex entries are $u_1=\frac{n-n}{\cdots}=0$, so $K=0$, $t=0$ and $W=0$, the configuration the record excludes throughout because $\theta$ is $0/0$ there. **The block's restriction to $k\ge2$ is therefore correct and unstated as a hypothesis of the conclusion.**

**Some $n_a=2$.** Nothing degenerates. $\frac1{n_a-1}=1$ is the largest term a block can contribute, the vertex entry is $u_a=\frac{n-2}{n-1}$, and $(S^2)^5$ and $(S^2)^7$ both satisfy $t=8R$ in section 3. **A singleton block, $n_a=1$, is what breaks the entry formula**, dividing by $n_a-1=0$, which is why $n_a\ge2$ is a hypothesis rather than a convenience.

Verdict CONFIRMED. **At $k=2$ the bound reads $\theta<\sqrt2$ and discriminates nothing**, and the consumed content begins at $k=3$, where it reads $\theta<1$.

## 9. The hypotheses actually dropped, item by item

**The inventory of what the new argument uses.** The vertex solution's entry formula, imported. Coordinate-diagonality of the configuration, unstated and needed twice, at sections 1 and 4. Criticality, unstated and needed, section 6. $\lVert W\rVert^2=t/2$ on the diagonal locus, unstated and needed, section 2. $t\le2$ with its equality case, imported. The norm identity $\lVert W\rVert^2=R$, imported, and at a representative the block does not name. Every $n_a\ge2$, and $k\ge2$.

**Against the four claimed dropped.**

| hypothesis | status under L212 |
|---|---|
| $\lambda=\tfrac12$ | **used.** [L46](../findings/problem.md)'s conclusion is $\theta=\lambda/\lVert W\rVert$, and $\theta=1/(2\lVert W\rVert)$ is that at $\lambda=\tfrac12$, the $2$ being $1/\lambda$. Section 2 shows independently that the identity's representative is $\theta_g=\tfrac12$, and [conventions.md](../findings/conventions.md) says of $B=\sum_af(n_a)-\frac n{8(n-1)}$, which is $R$ identically, that *"it depends on the partition alone only under the shared Einstein normalisation $\lambda=\tfrac12$"* |
| Einstein | **not a premise, and true of every object in range.** Section 5 shows the vertex solution is exactly the Weyl part of the $\lambda$-Einstein product metric at $\lambda=\theta_g$, so the condition has moved from the proof into the definition of the family. The gain is real and narrower than claimed: the derivation no longer needs the Einstein condition to reach criticality, provided section 6's computation is done |
| $\lambda\ne0$ | **still present, as $\theta_g\ne0$.** At $\theta_g=0$ the configuration is $W=0$ with $t=0$, and step 3's $8Rc^2=2$ excludes it, so the hypothesis is discharged by $t=2$ rather than absent |
| locally symmetric | **not a premise, and true of every object in range**, products of round spheres being symmetric spaces |

**The total is genuinely weaker in one respect and the same content in another.** Weaker: the route to criticality becomes two lines of algebra on the diagonal locus instead of Richard-Seshadri's lemma plus a decomposition theorem, and the objects need not be curvature operators of metrics at all, which is what the census's strongly-regular and $\mathfrak{su}(m)$ items needed. The same: the family is the Einstein one, the conclusion's form is the $\lambda=\tfrac12$ statement, and no object outside L46's reach gains a $\theta$ value from L212. **Verdict REFUTED for the $\lambda=\tfrac12$ clause**, with the other three confirmed as non-premises.

**And r653 assumes none of the four.** It presents the same entries as the solution of the vertex system, checks Ricci-flatness for every $n_a\ge2$, and uses them for spectral gaps. [ungraded-slack.md](../findings/ungraded-slack.md) obtains them by *"solving the vertex system by hand rather than through the sampling solver"*, which is criticality on the diagonal locus, not a symmetric-space input. So the import is clean on this point.

## 10. Padding

**What L212 asserts at a padded configuration.** Padding a vertex solution from $\mathbb R^n$ into $\mathbb R^{n'}$ leaves $K$ on the first $n$ indices and zero elsewhere. That configuration is still coordinate-diagonal, still has $K\mathbf1=0$ row by row, and is still critical at the same $\theta_g$: for $i$ in the support and $j$ in the padding, $\Phi_{ij}=K_{ij}^2+\sum_kK_{ik}K_{kj}=0=\theta_gK_{ij}$, since every $K_{kj}$ vanishes. **So L212 asserts at the padded copy exactly what it asserts at the original**, with $R$ read at the block sum.

**And that is consistent, because all three quantities are padding-invariant.** $t$ is unchanged, $\lVert W\rVert$ is unchanged, and $\theta$ is preserved by [L164](../findings/stratum-two-negative.md). The record's *"read at a padded copy the identity is false"* is about substituting the **ambient** dimension into the identity, which is a different operation from padding the configuration: at $(S^3)^3$ padded into $\mathbb R^{12}$ the true norm stays $\tfrac{27}{64}$, which is the formula at $n=9$, while the formula read at $n=12$ returns $\tfrac{75}{176}$. **No contradiction with padding-invariance arises, and the block is protected because it writes $n=\sum_an_a$ into its own hypothesis.**

**One hazard the block inherits.** At the padded copy the partition of the ambient $\mathbb R^{n'}$ has $n'-n$ singleton blocks, and reading it that way puts $n_a=1$ into the entry formula and into $\frac1{n_a-1}$. Verdict CONFIRMED, with the note that *"$n$ is the block sum"* is load-bearing rather than a remark.

## 11. Is any of it already on the record

**The value is.** [ungraded-slack.md](../findings/ungraded-slack.md) carries, for the same family,

$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}},$$

and section 3's identity $tD^2=(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}$ with $t=8R$ makes that denominator $8R(n-1)^2$, so the recorded closed form **is** $\theta^2=1/(4R)$, which is L212's conclusion. The census row two paragraphs above the L212 block already credits that file with closing the family *"in form"*.

**The route is.** [ROUND_L05](../verification/ROUND_L05.md) finding F3 records *"the conclusion is repairable from the vertex solution plus $t=2$ with no Einstein hypothesis at all"*, raised by v158 and v159, and its research-loop queue names *"the derivation of the norm-to-$\theta$ step from the vertex solution and $t=2$"*. L212 is that queued item executed, and the block presents the route as its own discovery.

**And the general-$k$ algebra is.** [VERIFY_v158.md](../verification/VERIFY_v158.md) §1 proves the identity and the closed form equivalent *"exact, for every $k$ and every partition"*, by the same step section 3 uses, $(n-1)^2-(n-n_a)^2=(n_a-1)(2n-1-n_a)$. **So step 2 is a rewriting of recorded algebra**, its content being the reading of that denominator as an ordered-pair second moment, and its Gate 1 screen at nine partitions is weaker than what the record already holds. The same v158 also records the $\lambda=\tfrac12$ dependence that section 9 refutes the block on, in the row *"$\lambda=\tfrac12$ needs Petersen-Stanfield's normalisation"*.

**What is actually new, and it is worth keeping.** Two things. First, $\lVert W\rVert^2=t/2$ on the diagonal locus turns section 3's $t=8R$ into a **proof of the multi-block norm identity at every $k$**, at the $\theta_g=\tfrac12$ representative, which retires the debt the census block records as undischarged from $k\ge5$ with $(S^2)^5$ as its smallest case. The block does not draw that conclusion, treating the identity as a given instead. Second, section 6's criticality computation removes L46 from the chain, which the block claims and does not do. Verdict REFUTED as new, with those two repairs standing as the round's product.

**The Lean layer types less than the block, and one declaration is an alias.** I built [L212VertexTheta.lean](../lean/HamiltonsCubic/Results/L212VertexTheta.lean) with `lake build`, and all three declarations replay `sorry`-free on `propext`, `Classical.choice` and `Quot.sound` alone. But `theta_eq_inv_two_norm` is `scale_of_t_eq_two` **character for character** in its statement, binders and hypotheses alike, and its proof is the term `scale_of_t_eq_two hR hc ht`, so the file carries two names for one theorem and the docstring's *"THE LEMMA'S ARITHMETIC CORE"* sits on a restatement. What type-checks is $8Rc^2=2$ with $R,c>0$ implies $c=1/(2\sqrt R)$, pure real arithmetic in which **no $\theta$, no $W$ and no norm occurs**. $\lVert W\rVert=\sqrt R$ enters only in the docstring, as does the identification of $c$ with $\theta$, so precisely the two identifications sections 2 and 6 find unestablished are the ones the layer does not type. `theta_lt_bound` is the bound step and is sound as stated.

## 12. What would break it, and what I did to look

**Named falsifiers, in the order they would bite.**

1. **A configuration in the family carrying off-diagonal pair-basis mass in the block frame.** Then $t_F<2\lVert W\rVert^2$, the step-3 scale equation no longer reads unit norm off $t=2$, and $\theta=1/(2\sqrt R)$ fails. *Looked for by asking what presents the configuration: a sectional matrix in $\mathcal D_n$ determines a coordinate-diagonal operator and only that, by [L57](../findings/problem.md)'s bijection, so within the block's own hypotheses none exists.*
2. **A reading of $\lVert W\rVert$ as the norm of the configuration whose $\theta$ is being stated.** That falsifies the headline at every partition, giving $\theta=\tfrac12$ against $\sqrt{10}/3$ at $(3,3)$. *This is section 2's finding, and it is the live one.*
3. **A partition with a singleton block, or $k=1$.** The entry formula divides by zero at $n_a=1$, and $k=1$ gives $R=0$ with no solvable scale equation. *Tested both in section 8.*
4. **A partition where $t\ne8R$.** That would move $\theta$ by the square root of the discrepancy, and a factor two there would move it by $\sqrt2$. *Tested by proving the identity symbolically at every $k$ in section 3, then by hand at $(2,2,2,2,2)$ and $(2,2,2,2,2,2,2)$, which the Gate 1 screen does not cover.*

**What I did to look for a falsifier of the value itself.** Three independent anchors, all exact. $1/(4R)$ against [L57](../findings/problem.md)'s two-block closed form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$: these agree identically, since $8R=\frac{(n-2)pq}{(p-1)(q-1)(n-1)}$ after clearing denominators with $n=p+q$. $1/(4R)$ against [ungraded-slack.md](../findings/ungraded-slack.md)'s multi-block closed form: identical, section 11. And $\theta=1/(2\sqrt R)$ at $(6,6)$ gives $\theta^2=\tfrac{55}{36}=\theta_0(12)^2$ and at $(2,10)$ gives $\theta^2=\tfrac{99}{100}$, both recorded. **No falsifier of the value exists among these**, which is why the verdict below separates the value from the derivation.

## Verdict for L212 as a whole

**GAP**, with two of the block's own claims REFUTED as written.

- **The value and the bound stand, and are now stronger than the block leaves them.** $\theta^2=1/(4R)$ at every partition with every $n_a\ge2$, $\theta<\sqrt{2/(k-1)}$ strictly at every $k\ge2$, and $t=8R$ proved symbolically at every $k$ rather than screened at nine partitions.
- **REFUTED, the headline's form.** $\theta=1/(2\lVert W\rVert)$ is a statement about two different representatives, false read at one, and [results.md](../results.md)'s *"at unit norm ... with $\lVert W\rVert^2=R$"* is unsatisfiable at every admissible partition. The scale-free form is $\theta^2=1/(4R)$.
- **REFUTED, the hypothesis claim, in one of its four items.** The $2$ is $1/\lambda$ at $\lambda=\tfrac12$, so that normalisation is carried by the conclusion rather than dropped, and the record's own note on $B=R$ says as much.
- **GAP, four times, three of them repairable in a clause and one in two displays.** Coordinate-diagonality of the configuration, unstated and needed at steps 1 and 3. $\lVert W\rVert^2=t/2$, unstated and needed at step 4. The definition of $\theta_g$, absent. **Criticality, absent, and it is the one step L46 was supplying**, so the block as written removes a hypothesis by removing the step that used it. Section 6 proves it in two lines at every partition.
- **The novelty claim does not hold.** The value is [ungraded-slack.md](../findings/ungraded-slack.md)'s recorded closed form, the route was queued at [ROUND_L05](../verification/ROUND_L05.md) F3, and the general-$k$ algebra is [VERIFY_v158.md](../verification/VERIFY_v158.md) §1. What is new and worth keeping is that $t=8R$ together with $\lVert W\rVert^2=t/2$ **proves the multi-block norm identity at every $k$**, discharging the $k\ge5$ debt the census block records, $(S^2)^5$ included.
- **The Lean layer is sound and narrower than advertised.** Three declarations build `sorry`-free on the three standard axioms, `theta_eq_inv_two_norm` is `scale_of_t_eq_two` under another name, and the two identifications this review finds unestablished are exactly the ones that live in the docstring.
