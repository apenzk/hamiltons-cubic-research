# REVIEW r396, Gate 2 on "the four-set discrepancy is built from the pair clause's own orbit vectors": one sign is wrong, the assignment is one of eight, and the crude chain is off by a factor of eight

*Adversarial review of the last section of [ATTEMPTS.md](../ATTEMPTS.md). Everything in §0–§2 was derived cold from the definitions before the section was opened: the three orbit-vector representations and their multiplicity, the two-factor family in closed form with its $\theta$, $\Sigma$ at all three four-subset types, and a criticality identity for $\Sigma$ that the record does not hold. Analysis only, and the rule was inherited: one arithmetic screen was run, on numbers this review derived by hand, and it is reported as a screen.*

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $A-B=o^{(jk)}_l-o^{(jk)}_i$ | **CONFIRMED**, re-derived cold |
| 2 | $B-C=o^{(kl)}_j-o^{(kl)}_i$ | **CONFIRMED**, re-derived cold |
| 3 | $C-A=o^{(jl)}_k-o^{(jl)}_i$ | **REFUTED as written, sign error.** With the section's own $o^{(jk)}_i=M_{ki}-M_{ji}$, that expression is $A-C$. **CORRECTED:** $C-A=o^{(lj)}_k-o^{(lj)}_i$, which makes the trio cyclic in $(j,k,l)$ |
| 4 | "each pairwise difference is a difference of two entries of **one** orbit vector" | **CORRECTED, of either of two.** Each difference has exactly **two** representations, and there are $2^3=8$ admissible triples: the $4$ triangles and $4$ stars of $K_4$. The section presents one as if forced |
| 5 | $\Sigma=\tfrac12\big[(\cdot)^2+(\cdot)^2+(\cdot)^2\big]$ in the orbit entries | **CONFIRMED**, the sign error is squared away, so the displayed $\Sigma$ survives claim 3's failure |
| 6 | (i) $\Sigma=0$ when all three pairings are twin pairs | **CONFIRMED but far from sharp**, and it does not cover the case it is invoked for: the $(3,1)$ four-sets of $S^p\times S^q$ have three non-twin pairs and $\Sigma=0$ anyway |
| 6b | its converse | **REFUTED, two witnesses.** In band: the $(3,1)$ four-set of $S^5\times S^{43}$, $\Sigma=0$ with three cross pairs non-twin. Stronger: at the triangular graph $T(6)=\mathrm{SRG}(15,8,4,4)$ a $K_4$ gives $\Sigma=0$ with **no** twin pair at all |
| 7 | (ii) two of [I18](../plan.md)'s clauses are "statements about the same family of $n(n-1)/2$ vectors" | **REFUTED as stated**, it is the observation that both are built from $M$'s entries, with the vectors in two different roles (eigenvector vs. matrix entry). **A real version exists and the section misses it**: [post F47](../findings/INDEX-traps.md)'s exact eigen-equation constrains the very coordinates $\Sigma$ is made of |
| 8 | (iii) the crude chain gives $\Sigma\le6\max\lVert o\rVert^2\le12$ | **CORRECTED twice.** The $12$ silently assumes $\theta M_{jk}\ge0$, **false at every cross pair of every sphere product**; the honest crude cap is $24$. And the *correct* use of the same input is $\Sigma\le\tfrac32\sigma_s-\theta\sigma\le3-\theta\sigma$, **a factor of eight better than the number the section reports against itself** |
| 9 | "it does not yet give a bound … the same order-of-magnitude failure the mass route began with" | **REFUTED.** It gives a bound, and the bound is an $m_4$-free concentration criterion that [post F50](../findings/INDEX-traps.md)'s witnesses **pass**: $\Sigma<\tfrac32$ whenever $m_4-m_{\text{far}}<\tfrac23\theta\sigma$. The gap to the target is a factor of $2$, not of $8$ |
| 10 | "a successor bounds the entry-spread of $o^{(jk)}$" | **Misdirection.** The entry-spread is *strictly less* information than the six entries of $M$ on $S$, which already determine $\Sigma$ exactly. The only thing the reformulation imports is [Lemma L68](../findings/diagonal-half.md)'s pricing of $\lVert o\rVert$, and that step is lossy by construction |
| 11 | the identity is new | **CONFIRMED.** No form of it is in [findings/](../findings/); the record has $\Sigma=\tfrac12[(A-B)^2+\dots]$ ([Lemma L121](../findings/second-order.md)) and $o^{jk}$ ([Lemma L122](../findings/second-order.md)) and never joins them |

**Headline for the parent.** *The observation is real and it is new, and it is worth more than the section claims, but not in the direction the section points.* Fix the sign, replace the arbitrary triple by the choice-free sum over all six pairs, and the same [Lemma L68](../findings/diagonal-half.md) input that the section reports as reaching $12$ actually reaches $\tfrac32\sigma_s-\theta\sigma$. That is an $m_4$-**free** sufficient criterion for the four-set clause, so it escapes [post F50](../findings/INDEX-traps.md)'s refutation, and it is satisfied at every recorded in-band point, including the $(4,0)$ and $(2,2)$ four-sets of the $S^5\times S^{43}$ witness, where it is exactly tight. **It still does not close the clause**, because $\sigma_s$ can reach $2$; the gap is a factor of $2$, which is where a successor should be told the work is.

---

## 0. Cold derivation, the representations and their multiplicity

Write $o^{(xy)}_a=M_{ya}-M_{xa}$ for $a\notin\{x,y\}$, the section's own convention, and $S=\{i,j,k,l\}$ with $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$.

**The mechanism.** $A-B$ is the anti-invariant of the transposition that exchanges the matchings $\{ij|kl\}$ and $\{ik|jl\}$. In $S_4$ **two** transpositions do that ($(jk)$ and $(il)$) and they are exactly the two pairs of the **third** matching $C=\{il|jk\}$. So:

$$A-B=o^{(jk)}_l-o^{(jk)}_i=o^{(il)}_k-o^{(il)}_j,\qquad B-C=o^{(kl)}_j-o^{(kl)}_i=o^{(ij)}_l-o^{(ij)}_k,\qquad C-A=o^{(lj)}_k-o^{(lj)}_i=o^{(ik)}_j-o^{(ik)}_l.$$

Each is checked by expansion; the third one is where the section's version fails. **The rule**: the difference of two of the three opposite-pair sums is carried by the orbit vector at *either* pair of the matching that was not used, evaluated at the two indices *not* in that pair. Choosing one pair from each matching gives $2^3=8$ triples, and in $K_4$ those are the $4$ triangles and the $4$ stars. **The assignment is not forced.**

**The sign error, in full.** The section writes $C-A=o^{(jl)}_k-o^{(jl)}_i$. With its own definition, $o^{(jl)}_k=M_{lk}-M_{jk}=M_{kl}-M_{jk}$ and $o^{(jl)}_i=M_{li}-M_{ji}=M_{il}-M_{ij}$, so

$$o^{(jl)}_k-o^{(jl)}_i=(M_{ij}+M_{kl})-(M_{il}+M_{jk})=A-C .$$

The repair is one character: the superscript is the **ordered** pair $(l,j)$, not $(j,l)$. Then $o^{(lj)}_k-o^{(lj)}_i=(M_{il}+M_{jk})-(M_{ij}+M_{kl})=C-A$, and the trio reads

$$A-B=o^{(jk)}_l-o^{(jk)}_i,\qquad B-C=o^{(kl)}_j-o^{(kl)}_i,\qquad C-A=o^{(lj)}_k-o^{(lj)}_i,$$

**cyclic in $(j,k,l)$ with $i$ the fixed apex**, the triangle presentation, one of the four. That the corrected version is cyclic and the printed one is not is itself the tell.

**The form that should be recorded instead**, because it has no choice and no orientation in it: for each of the six pairs $\{p,q\}\subset S$ with complement $\{x,y\}=S\setminus\{p,q\}$,

$$\boxed{\;4\,\Sigma\;=\;\sum_{\{p,q\}\subset S}\big(o^{(pq)}_x-o^{(pq)}_y\big)^2\;}$$

since each of the three matching-differences appears twice, once for each pair of the complementary matching. This is immune to the sign slip and it is what the useful bound comes out of (§3).

## 1. Cold derivation, the two-factor family, and $\Sigma$ at each four-subset type

Nothing below was read off the record. With $F_1$ of size $p$, $F_2$ of size $q$, $n=p+q$, and $M_{ab}=\alpha,\beta,\gamma$ within $F_1$, within $F_2$, across: zero row sums give $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$; the cross criticality equation collapses to $\gamma(1-n)=\theta$; and the two within-factor equations are then automatic. So

$$\gamma=-\frac\theta{n-1},\qquad \alpha=\frac{\theta q}{(n-1)(p-1)},\qquad \beta=\frac{\theta p}{(n-1)(q-1)},\qquad \operatorname{tr}M^2=2\iff \theta^2=\frac{2(n-1)(p-1)(q-1)}{pq\,(n-2)} .$$

At $(p,q)=(5,43)$ this gives $\theta^2=15792/9890$, $\theta=1.2636315$, and $m_4=6\alpha^2=0.5012032$ on a $(4,0)$ four-set, **the record's $1.263631$ and $0.501203$, reproduced from the definitions alone.**

| four-subset | $A,B,C$ | $\Sigma$ | orbit differences |
| --- | --- | --- | --- |
| $(4,0)$ | $A=B=C=2\alpha$ | $0$ | all three $0$; in fact all six $o^{(pq)}$ **vanish identically** |
| $(3,1)$ | $A=B=C=\alpha+\gamma$ | $0$ | all three $0$; three of the six pairs are non-twin |
| $(2,2)$ | $(\alpha+\beta,\,2\gamma,\,2\gamma)$ | $(\alpha+\beta-2\gamma)^2=\dfrac{\theta^2(n-2)^2}{(p-1)^2(q-1)^2}$ | two are $\pm(\alpha+\beta-2\gamma)$, one is $0$ |

Both routes agree: the $A,B,C$ definition and the orbit form give the same three numbers at every type. The $(2,2)$ value squares with [Lemma L126](../findings/second-order.md), whose $\mu_{p,q}=\tfrac{n-2}{2(p-1)(q-1)}$ is $\sqrt\Sigma/(2\theta)$, [Lemma L121](../findings/second-order.md)'s block spectrum $\pm\tfrac12\sqrt\Sigma$ in $L_e$ units, so $\mu=\tfrac12\iff\Sigma=\theta^2\iff\tfrac1{p-1}+\tfrac1{q-1}=1$, as recorded.

**The brief's third question, answered.** At $S^5\times S^{43}$, $(4,0)$ inside the $5$-factor: **all three orbit-vector differences are $0$ and $\Sigma=0$**, and for a stronger reason than the differences vanishing. Every pair inside $F_1$ is twin, so $o^{(pq)}\equiv0$ as a vector, not merely at the two coordinates that enter. That is what makes the section's consequence (i) true here.

## 2. A criticality identity for $\Sigma$ the record does not have

Summing criticality $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ over the six pairs of $S$ and splitting $(M^2)_{ab}$ at $S$: the inside part is $\sum_{T\subset S,|T|=3}e_2(\text{edges of }T)=AB+BC+CA$, the four triangles reassemble exactly into the three cross terms. With $\sigma=A+B+C$, $m_4=\sum_{a<b\in S}M_{ab}^2$ and $X=\sum_{a<b\in S}\sum_{c\notin S}M_{ac}M_{bc}$, and $AB+BC+CA=(\sigma^2-\Sigma)/3$:

$$\boxed{\;\Sigma\;=\;3m_4+\sigma^2-3\theta\sigma+3X\;}\qquad\text{at every critical point and every four-subset.}$$

*Screen (seconds of arithmetic, on the closed forms derived above, reported as a screen and not as evidence): at the $(2,2)$ four-set of $S^5\times S^{43}$ the two sides agree to six digits, $0.1197121$ against $0.1197115$. At the $(4,0)$ set the identity reduces exactly, by hand, to the within-factor criticality equation $(p-1)\alpha^2+q\gamma^2=\theta\alpha$.*

This is worth more than the section's (iii): it is exact, it uses criticality where the recorded $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ uses none, and it isolates the **entire** dependence on the complement of $S$ in one term $X=\tfrac12\big[\sum_{c\notin S}r_c^2-m_{\text{out}}\big]$, $r_c=\sum_{a\in S}M_{ac}$, with $\sum_{c\notin S}r_c=-2\sigma$ from the zero row sums. It also shows the recorded inequality $\Sigma\le3m_4-\tfrac12\sigma^2$ is exactly the statement $X\le\theta\sigma-\tfrac12\sigma^2$.

## 3. Point 3, does the reformulation buy anything?

**The structural fact first, and it caps what is possible.** $A,B,C$ depend only on the six entries of $M$ on $S$; the orbit vectors have $n-2$ coordinates of which only two ever enter. So the reformulation carries **no** information that the six entries do not, and every coordinate beyond those two is noise. Outside information can enter at exactly one place: the step that replaces two coordinates of $o$ by $\lVert o\rVert$, priced by [Lemma L68](../findings/diagonal-half.md). That step is lossy by construction. **So the section's (iii) ("no new quantity enters"), is right, and stronger than it says.**

**But the section misuses its own instrument.** Its chain is $\lvert A-B\rvert\le2\lVert o\rVert_\infty$, then three times the maximum. Two defects:

- **The number $12$ is not proved.** It needs $\max\lVert o^{(jk)}\rVert^2\le2$, i.e. $s_j+s_k-2\theta M_{jk}\le2$, and while $s_j+s_k\le\operatorname{tr}M^2=2$ the term $-2\theta M_{jk}$ is dropped as if non-positive. **At every cross pair of every sphere product $M_{jk}=\gamma=-\theta/(n-1)<0$**, so the dropped term is positive on precisely the family the section's own witnesses come from. From $\lVert o\rVert^2\le2(s_j+s_k)\le4$ the honest crude cap is $\Sigma\le24$.
- **Three-times-the-maximum is the wrong contraction.** Use the boxed six-pair form of §0 with $(o_x-o_y)^2\le2(o_x^2+o_y^2)\le2\lVert o\rVert^2$ on each pair, and [Lemma L68](../findings/diagonal-half.md) on each:

$$4\Sigma\;\le\;2\sum_{\{p,q\}\subset S}\lVert o^{(pq)}\rVert^2\;=\;2\big[3\sigma_s-2\theta\sigma\big],\qquad \sigma_s:=\sum_{a\in S}s_a,$$

$$\boxed{\;\Sigma\;\le\;\tfrac32\sigma_s-\theta\sigma\;}$$

and $\sigma_s=2m_4+m_{\text{out}}=1+m_4-m_{\text{far}}\le2$, since $m_4+m_{\text{out}}+m_{\text{far}}=1$. So $\Sigma\le3-\theta\sigma$, and since the clause needs $\Sigma\ne\theta^2$ with $\theta^2\ge\tfrac32$:

$$m_4-m_{\text{far}}<\tfrac23\theta\sigma\;\Longrightarrow\;\Sigma<\tfrac32\le\theta^2\;\Longrightarrow\;\text{the four-set clause holds at }S .$$

**This is the section's own instrument, used correctly, and it is a factor of eight better than the number the section reports.** It is also an $m_4$-free criterion (the outside mass $m_{\text{far}}$ and the entry sum $\sigma$ both enter) so [post F50](../findings/INDEX-traps.md)'s refutation of *mass-only* criteria does not reach it. At the $S^5\times S^{43}$ witness it clears with room: $(4,0)$ gives $m_4-m_{\text{far}}=0.4609$ against $\tfrac23\theta\sigma=1.461$, and the bound $\tfrac32\sigma_s-\theta\sigma$ is **exactly $0$** there, because $6[(p-1)\alpha^2+q\gamma^2-\theta\alpha]=0$ is the within-factor criticality equation; the $(2,2)$ set clears in the equivalent form $\sigma_s<1+\tfrac23\theta\sigma$, $0.7385$ against $1.1556$.

**The verdict, plainly.** *The reformulation is not decorative and it is not a route.* It is the bridge from $\Sigma$ to the [Lemma L68](../findings/diagonal-half.md) budget, and that bridge yields a real, non-vacuous, F50-proof criterion. It does not close the clause: $\sigma_s\le2$ is the only cap available and $\tfrac32\cdot2=3$ is a factor of $2$ above the target $\tfrac32$. **The honest framing is "a criterion with a factor-two gap", not "opens a route" and not "the same order-of-magnitude failure as the mass route".** And note the recorded $\Sigma\le3m_4-\tfrac12\sigma^2$ is *also* exactly tight at the same witness, the two instruments are siblings, not an improvement of one over the other, and a successor should carry both plus §2's identity.

**Where the factor of two would have to come from.** Not from sharpening $(o_x-o_y)^2\le2\lVert o\rVert^2$, which is where all the loss is but which can only be closed by knowing the six entries, and knowing them gives $\Sigma$ outright. It has to come from a constraint on $\sigma_s$ at a critical point in the band, i.e. from a concentration bound of exactly the kind [post F50](../findings/INDEX-traps.md) refuted in its $m_4$ form. **That is the real state of the four-set clause and the section does not say it.**

## 4. Point 4, consequence (i) and its converse

**(i) is true and is not the sharp statement.** "All three pairings are twin pairs" reads as all six pairs of $S$ twin. From the boxed six-pair identity the sharp sufficient condition is far weaker: it is enough that **for each of the three matchings, at least one of its two pairs is twin** (three of the six pairs, forming a triangle or a star) and weaker still, that $o^{(pq)}_x=o^{(pq)}_y$ at one pair per matching, with $o^{(pq)}$ free to be nonzero. And $\Sigma=0\iff A=B=C$, which mentions no orbit vector at all.

**It also fails to cover its own use case.** The section offers (i) as "why $\Sigma$ vanishes on the sphere-product four-sets that [post F50](../findings/INDEX-traps.md)'s witnesses exhibit". It covers the $(4,0)$ sets, where all six pairs are twin. It does **not** cover the $(3,1)$ sets, where the three pairs meeting the singleton are cross pairs with $o\ne0$, and $\Sigma=0$ there too.

**The converse is false, twice.**

- **In band, from this review's own derivation.** The $(3,1)$ four-set of $S^5\times S^{43}$: $A=B=C=\alpha+\gamma$, so $\Sigma=0$, while $\{i,l\},\{j,l\},\{k,l\}$ are cross pairs with $o^{(il)}_a=\gamma-\alpha\ne0$ for $a\in F_1$. Three of the six pairs are non-twin.
- **With no twin pair at all.** Take the triangular graph $T(6)=\mathrm{SRG}(15,8,4,4)$, the line graph of $K_6$, as a diagonal critical point, *this leg uses the record's [r393](REVIEW_r393.md)/[r394](REVIEW_r394.md) result that every SRG is a diagonal critical point under $M=xA+y(J-I-A)$, and is flagged as a used hypothesis rather than re-derived here.* The five edges of $K_6$ at a fixed vertex are pairwise adjacent in $T(6)$; any four of them give a four-set with all six $M$-entries equal to $x$, hence $A=B=C=2x$ and $\Sigma=0$. No two vertices of $T(6)$ are twins ($\mu=4<k=8$, and explicitly $\{2,4\}$ separates $\{1,2\}$ from $\{1,3\}$). Here $\theta=\lvert1+\lambda-\mu\rvert\sqrt{2(v-1)/(vk(v-1-k))}=\sqrt{28/720}=0.197203\ne0$, so the point is not degenerate.

**So $\Sigma=0$ is not a twin phenomenon**, and (i) should be restated as the one-way implication it is, with the sharp condition given.

## 5. Point 5, is (ii) a structural claim?

**As written, no.** "$\Sigma$ is built from the same $n(n-1)/2$ vectors as the pair clause" is, unpacked, the statement that $A,B,C$ are built from entries of $M$, which every clause in [I18](../plan.md) is. Two specifics make it weaker than it sounds:

- **Only six numbers of the family enter, and they are the six entries of $M$ on $S$.** Per four-set the claim touches three of the $n(n-1)/2$ vectors and two coordinates of each; $o^{(jk)}_l-o^{(jk)}_i$ is $M_{kl}-M_{jl}-M_{ik}+M_{ij}$, four entries inside $S$. The count $n(n-1)/2$ is doing no work.
- **The two roles are different.** In the pair clause $o^{(jk)}$ is a **vector in the block space** $V_{jk}$ and the claim is spectral, simplicity of $T$ in $\operatorname{spec}(\widetilde N)$. In the four-set clause the same numbers are **entries of the matrix** $G$ of [Lemma L121](../findings/second-order.md) on a different block. The record has already fenced this exact species of transfer: *"L121 is about $L_M$ on $\mathrm{Sym}^2(\Lambda^2)$ and supplies no invariant plane of $W$ on $\Lambda^2$; reading one off it is a category error"* ([second-order.md](../findings/second-order.md)).

**But a real version exists, and the section walks past it.** [Post F47](../findings/INDEX-traps.md) records that $o^{(jk)}$ satisfies an **exact** eigen-equation at every pure critical point, $\Delta^{(jk)}o=-(\theta+M_{jk})o$ ([Lemma L122](../findings/second-order.md)). Reading it at the two coordinates that the four-set clause uses and subtracting:

$$(\theta+M_{jk})\,(A-B)\;=\;\sum_{b\notin\{j,k\}}M_{ib}\big(o_i-o_b\big)-\sum_{b\notin\{j,k\}}M_{lb}\big(o_l-o_b\big).$$

**That is a genuine bridge between the two clauses**, and unlike the [Lemma L68](../findings/diagonal-half.md) route it is an equality and it brings in rows $i$ and $l$ over *all* of $[n]$, the one mechanism found here by which information from outside $S$ can reach $\Sigma$ without being thrown away. Whether it is usable is open. It is what (ii) should have said.

## 6. Silently used hypotheses

| where | what is assumed and unstated |
| --- | --- |
| (iii), the step $\le12$ | $\theta M_{jk}\ge0$ at the maximising pair, **false at every cross pair of every $S^p\times S^q$**, where $M_{jk}=-\theta/(n-1)$ |
| the trio of identities | that the pair attached to each difference is **determined**; it is one of two, and the triple is one of eight |
| (i) | that "twin" is necessary as well as sufficient, the converse is used implicitly when (i) is offered as the explanation of the F50 witnesses, and it is false |
| (iii) | that $\lVert o\rVert_\infty\le\lVert o\rVert_2$ is the right contraction; summing over the six pairs is strictly better and uses the same lemma |
| throughout | $\theta>0$ and criticality at *every* pair of $S$, fine here, but [Lemma L68](../findings/diagonal-half.md) is a critical-point statement and the section's $\Sigma$ identity is not, so the two halves have different domains |

## 7. What to record

1. **Fix the sign** in the third identity and print the cyclic trio $(jk),(kl),(lj)$, or better the choice-free $4\Sigma=\sum_{\{p,q\}\subset S}(o^{(pq)}_x-o^{(pq)}_y)^2$.
2. **Strike $\Sigma\le12$**; replace with $\Sigma\le\tfrac32\sigma_s-\theta\sigma$ and the criterion $m_4-m_{\text{far}}<\tfrac23\theta\sigma\Rightarrow\Sigma<\tfrac32$, noting it is exactly tight at the $S^5\times S^{43}$ $(4,0)$ set and that it is not an $m_4$-only criterion.
3. **Restate (i)** one-way, with the sharp hypothesis (one twin pair per matching) and the two converse witnesses.
4. **Replace (ii)** with the eigen-equation bridge of §5.
5. **Add §2's criticality identity** $\Sigma=3m_4+\sigma^2-3\theta\sigma+3X$ to [second-order.md](../findings/second-order.md) next to the recorded $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$; it is exact, it is criticality-fed, and it localises the complement's contribution in one term.
6. **Change the framing** from "opens a route" to "a criterion with a factor-two gap, and the gap is a concentration bound on $\sigma_s$", which is the same obstruction [post F50](../findings/INDEX-traps.md) already identified, now in the right variable.
