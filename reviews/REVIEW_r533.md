# Review r533, Lemma L126

**Target.** Lemma L126, "the four-set $\tfrac12$-threshold, met in the two-factor family only at $S^3\times S^3$", [findings/second-order.md](../findings/second-order.md), lines 710–724 (`#### Lemma L126` down to `#### Lemma L127`).

**Reviewer.** r533, cold, adversarial. Analysis-only footing honoured: every value below was derived by hand first; the one computation run was an exact-arithmetic screen of claims already written, reported as a screen in §8 and never as evidence for a positive claim.

**VERDICT: CONFIRMED.** Every mathematical claim in the block reproduces from the definitions, $DF(M)=\theta(2L_e-\mathrm{Id})$, the kernel identification, $\mu_{p,q}$, the two equivalences, the $(2,2)$-split restriction, orbit-freeness, and all four printed values. Two repairs are owed, both in the subsidiary boxes and neither touching the statement: **G1**, the box asserts "no branch emanates" flatly where its source names a remaining gap; **G2**, the unit-norm hypothesis is unstated. The brief's suspicion about a missing $\langle M\rangle$ cut is **mistaken**, §2 shows the cut is automatic here.

---

## 1. $DF(M)=\theta(2L_e-\mathrm{Id})$, derived, CONFIRMED

$Q$ is homogeneous quadratic, so by the record's own polarisation $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ ([conventions.md](../findings/conventions.md)) we get $DQ(M)[X]=2M\circ X$. The trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric ([Lemma L24](../findings/second-order.md), from [r285](REVIEW_r285.md) Claim 1), so $DP(M)[X]=3\langle Q(M),X\rangle$. Hence, at a critical $M$ of unit norm with $Q(M)=\theta M$ and $P(M)=\theta$,

$$DF(M)[X]\;=\;2M\circ X\;-\;3\langle Q(M),X\rangle M\;-\;P(M)X\;=\;\theta(2L_e-\mathrm{Id})X\;-\;3\theta\langle M,X\rangle M .$$

The last term dies on $M^\perp$, which is exactly the block's qualifier "**On the tangent space**". **Both terms of $F=Q-PW$ contribute as the brief asks**: the $Q$ part gives $2M\circ(\cdot)=2\theta L_e$, and the $P(W)W$ part gives *two* pieces, $-P(M)X=-\theta X$ through $W$, and $-3\theta\langle M,X\rangle M$ through $DP$. The $\mathrm{Id}$ in the record's formula is the second of these; the $DP$ piece is what the restriction removes. Correct as written.

**Cross-check against the record, and it closes.** [Lemma L128](../findings/second-order.md)'s proof of (iii) writes $F=3(Q-PW)$ and says $dF_W$ "sends $W\mapsto-6\theta W$". My formula gives $DF(M)[M]=2Q(M)-3\theta M-\theta M=-2\theta M$, and $3\times(-2\theta)=-6\theta$. Exact agreement. Likewise $\mathrm{Hess}(P|_S)_M=6\theta(L_e-\tfrac12\mathrm{Id})$ ([Lemma L24](../findings/second-order.md)) is $3\,DF|_{M^\perp}$, which is the identity [Lemma L128](../findings/second-order.md)'s reinstatement box asserts. Three independent statements, one operator.

## 2. The kernel claim, and the brief's suspicion is WRONG

The block says "$\ker DF(M)$ is the $\tfrac12$-eigenspace of $L_e$". Both halves of the brief's worry resolve in the record's favour:

- **Is $\mathbb R M$ in the kernel?** No. $DF(M)[M]=-2\theta M\ne0$ since $\theta>0$. The kernel is disjoint from $\langle M\rangle$ by computation, not by fiat.
- **Is a cut by $\langle M\rangle$ owed, as in the [Lemma L120](../findings/second-order.md) audit?** **No, and this is the finding.** $L_e$ is self-adjoint and $L_eM=Q(M)/\theta=M$, so $M$ is a $1$-eigenvector. Distinct eigenvalues of a self-adjoint operator have orthogonal eigenspaces, hence $E_{L_e}(\tfrac12)\subseteq M^\perp$ **automatically**. The ambient kernel and the tangent-space kernel therefore coincide, and $\ker DF(M)=E_{L_e}(\tfrac12)$ is exact with no cut.

The reason L120 needs its cut and L126 does not is that L120's is a statement about $\lambda_{\max}$ over a *block* ($\mathcal D_n$, which contains $M$ and so contains the eigenvalue $1$), while L126's is a statement about a *single eigenvalue* $\tfrac12\ne1$. The brief's attack point is a false lead; recording it as such per the brief's instruction.

**The L121 hand-off is right too.** [Lemma L121](../findings/second-order.md) gives the four-set block of $L_M$ as $\tfrac12G$ with spectrum $\pm\tfrac12\sqrt\Sigma$ on the Bianchi subspace $\mathbf1^\perp$. Dividing by $\theta$ for $L_e$: the block meets $\tfrac12$ iff $\sqrt\Sigma/(2\theta)=\tfrac12$ iff $\Sigma=\theta^2$. The negative root cannot reach $+\tfrac12$ because $\theta>0$, and $\Sigma=0$ gives the zero block. Exactly the block's claim. Note L121's block needs **diagonality alone**, which is all L126 assumes, the necessary-condition half of L121, the half needing a maximiser, is not invoked here.

## 3. $\mu_{p,q}$, derived from scratch, CONFIRMED, and it is an $L_e$ value

Write $\alpha,\beta,\gamma$ for the within-$F_1$, within-$F_2$ and cross sectional entries; Ricci-flatness is $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$ ([Lemma L127](../findings/second-order.md)).

**Which four-sets are nonzero.** With $A,B,C$ the three opposite-pair sums of [Lemma L121](../findings/second-order.md):

| split | $A,B,C$ | $\Sigma$ |
|---|---|---|
| $(4,0)$ | $2\alpha,2\alpha,2\alpha$ | $0$ |
| $(3,1)$ | $\alpha+\gamma$ three times | $0$ |
| $(2,2)$ | $\alpha+\beta,\ 2\gamma,\ 2\gamma$ | $(\alpha+\beta-2\gamma)^2$ |

So the nonzero blocks are the $(2,2)$-splits and their value is common, as the block says. This also matches [second-order.md:892](../findings/second-order.md), "$(3,1)$ and $(4,0)$: $L_e=0$, since $A=B=C$ there".

**The value.** $\alpha+\beta-2\gamma=-\gamma\big[\tfrac q{p-1}+\tfrac p{q-1}+2\big]$, and the bracket's numerator over $(p-1)(q-1)$ is $q(q-1)+p(p-1)+2(p-1)(q-1)=(p+q)^2-3(p+q)+2=(n-1)(n-2)$. Hence $\sqrt\Sigma=|\gamma|\,\frac{(n-1)(n-2)}{(p-1)(q-1)}$. With $\theta=(n-1)|\gamma|$,

$$\mu_{p,q}\;=\;\frac{\sqrt\Sigma}{2\theta}\;=\;\frac{n-2}{2(p-1)(q-1)}\qquad\text{the record's value, and it is an }L_e\text{ eigenvalue.}$$

**$\theta=(n-1)|\gamma|$ is not taken on trust.** Four independent confirmations: (a) at $S^3\times S^3$ the ordered-pair normalisation $6\alpha^2+6\beta^2+18\gamma^2=2$ gives $\gamma^2=\tfrac2{45}$ and $\theta=5\sqrt{2/45}=\sqrt{10}/3=\theta_0(6)$, the brief's anchor, **exactly**; (b) $p=3$ gives $\theta\to2/\sqrt3$, (c) $p=4$ gives $\theta\to\sqrt{3/2}$ from below and (d) $p=2$ gives $\theta\uparrow1$ from below, the three asymptotics [Corollary L128.1](../findings/second-order.md) prints. A fifth: [Lemma L26](../findings/nondegeneracy.md) computes $e\circ X=\lambda X$ with $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ from the structure constants (that is $(\alpha+\beta-2\gamma)/(2\theta)$, my expression, by a route sharing nothing with mine) and its normalisation $\theta=\tfrac{n-1}{pq}$ at $\gamma=1/(pq)$ is $\theta=(n-1)|\gamma|$ again.

**The four printed values all check.** $\mu_{2,2}=1$, $\mu_{2,4}=\tfrac23$, $\mu_{2,6}=\tfrac35$, $\mu_{3,3}=\tfrac12$. And $\mu_{2,2}=1$ is a *non-trivial* cross-check: [Lemma L24](../findings/second-order.md)'s own $n=4$ box says $\lambda_{\max}(L_e|_{W^\perp})=1$ at $S^2\times S^2$ because $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is $\circ$-orthogonal, so the four-set block at $n=4$ is where the second idempotent lives. Two files, two mechanisms, one number.

## 4. The Diophantine step, both equivalences derived, CONFIRMED

With $u=p-1$, $v=q-1$ and $n-2=u+v$:

$$\mu_{p,q}=\frac{u+v}{2uv}=\tfrac12\iff u+v=uv\iff\frac1u+\frac1v=1 ,$$

the last division legitimate because $uv\ne0$. **Second equivalence.** $uv-u-v=0\iff(u-1)(v-1)=1$, so over $\mathbb Z$ either $u-1=v-1=1$ or $u-1=v-1=-1$; the latter is $u=v=0$, excluded by the denominator. Hence $(u,v)=(2,2)$, i.e. $(p,q)=(3,3)$, is the **only integer solution**, stronger than the record's "only integer solution" needs, since it holds without assuming positivity.

**Boundary cases, and nothing is silently excluded.**

- $p=2$ ($u=1$) is *in* scope and the record handles it by name: $\tfrac11+\tfrac1v=1$ forces $\tfrac1v=0$, no solution, matching $\mu_{2,q}=\tfrac q{2(q-1)}>\tfrac12$ strictly.
- $p=1$ ($u=0$) makes $\mu$ undefined, and the exclusion is **structural rather than hypothesised**: at $p=1$ Ricci-flatness reads $0\cdot\alpha+q\gamma=0$, so $\gamma=0$, then $\beta=0$, the whole sectional matrix vanishes and there is no member of the family to test. The formula's domain $p,q\ge2$ is the family's own.

**One presentational gap.** The block's justification reads *"since $u=1$ forces $\tfrac1v=0$ and $u=v=2$ is the only integer solution"*, the second clause is asserted, not argued. It is true, and $(u-1)(v-1)=1$ proves it in one line; adding that line would close the only place the block reasons by assertion.

## 5. Scope, and the division of labour with L27, coherent, worth stating

| | $p=2$ | $(3,3)$ | $p,q\ge3$, $(p,q)\ne(3,3)$ |
|---|---|---|---|
| $\mu_{p,q}$ vs $\tfrac12$ | $>\tfrac12$ | $=\tfrac12$ | $<\tfrac12$ |
| [Lemma L27](../findings/nondegeneracy.md) | **refuses** (decomposition over-counts) | **refuses** (excluded by hypothesis) | covers |
| L126 | covers (kills local maximality | covers), the exact-$\tfrac12$ case | agrees with L27 |

**L126's content is precisely the two cases L27 refuses, and that is a clean division rather than a clash.** The block never states $p,q\ge3$, and correctly so: its own second box lives at $p=2$. $(3,3)$ is inside L126's hypothesis and outside L27's.

**The $86$-against-$84$ claim is CONFIRMED, and I can say exactly why.** Summing L27's ten summand dimensions at $(p,q)=(2,4)$: $\langle W\rangle\,1$, $\mathrm{Weyl}_2\,0$, $\mathrm{Weyl}_4\,10$, $\mathbb R^2\!\otimes\!\mathbb R^4\,8$, $S^2_0(\mathbb R^2)\,2$, $S^2_0(\mathbb R^4)\,9$, $S^2_0\!\otimes\!S^2_0\,18$, $\Lambda^2\!\otimes\!\Lambda^2\,6$, $X_2\!\otimes\!\mathbb R^4\,0$, $X_4\!\otimes\!\mathbb R^2\,32$, total $86$ against $\dim\mathcal W_6=84$. The excess is exactly $2$, and it is exactly the gap between $\dim\mathcal W_2=0$ and the value $-2$ that $\tfrac{n(n-3)(n+1)(n+2)}{12}$ returns at $n=2$. L27's "the ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$" is a *polynomial* identity that stops being a dimension count at $p=2$. The box is right and its diagnosis is available.

**Orbit-freeness, CONFIRMED.** $[\rho(E_{jk}),M]$ has entries $(M_\beta-M_\alpha)\rho(E_{jk})_{\alpha\beta}$, supported on $\{e_{ji}\odot e_{ki}\}$, which is [Lemma L122](../findings/second-order.md)'s basis of $V_{jk}$; linearity over $A=\sum a_{jk}E_{jk}$ then puts $T_M\mathcal O\subseteq\bigoplus V_{jk}$. Four-set blocks carry no orbit direction. This is the clause [Lemma L128](../findings/second-order.md)(i) credits back to L126, and it holds.

## 6. The withdrawn reading, no residue in the block, one overstatement in a box

**Nothing in the block depends on the withdrawn "branch direction" reading.** The bolded statement asserts only $\ker DF(M)=E_{L_e}(\tfrac12)$ and orbit-freeness; the Diophantine paragraph is pure arithmetic; the second box argues *non-maximality at $p=2$ from [Lemma L24](../findings/second-order.md)*, which is a Hessian-sign statement and needs no branch. Clean.

> **G1, THE BOX SAYS FLATLY WHAT ITS SOURCE SAYS WITH A NAMED GAP.** L126 writes: *"**At $S^3\times S^3$ no branch emanates**, by [nondegeneracy.md](../findings/nondegeneracy.md)'s third-order obstruction $\Psi_1=-0.5929271$, constant on the zero cone."* The source, [nondegeneracy.md:576](../findings/nondegeneracy.md), writes: *"On the zero cone $\Psi_1=-0.5929271$, **constant across 300 samples and 120 constrained restarts** … So no branch emanates, but for a third-order reason"*, and closes with *"**Remaining gap: Puiseux arcs with leading exponent $\ge2$ contribute order-three cross terms that were not excluded.**"* Two things are dropped in transit: the constancy is **sampled, not proved**, and the conclusion carries an **unexcluded arc class**. The logical direction is sound ($\Psi_1\ne0$ proves *no* branch, which is the way the one-sided obstruction runs) so this is an overstatement, not an error. *Repair*: "no branch emanates along the zero cone, on the record's third-order obstruction $\Psi_1\ne0$, up to [nondegeneracy.md](../findings/nondegeneracy.md)'s unexcluded Puiseux arcs".

> **G2, THE UNIT-NORM HYPOTHESIS IS UNSTATED.** L126 opens *"Let $M$ be a diagonal critical point with $\theta>0$."* The identity $DF(M)=\theta(2L_e-\mathrm{Id})$ needs $P(M)=\theta$, which by [conventions.md](../findings/conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$ holds only at $\lVert M\rVert=1$. [Lemma L24](../findings/second-order.md) and [Lemma L128](../findings/second-order.md) both say "unit norm" in their statements; L126 inherits it silently. One word.

## 7. The nine citations, what each takes

| # | site | what it takes | sound? |
|---|---|---|---|
| 1 | [second-order.md:734](../findings/second-order.md), [L127](../findings/second-order.md)'s block table, four-set row | the **Diophantine conclusion** ("only at $(3,3)$") and the value $\mu_{p,q}$ | yes; the table is at $n=p+q$ |
| 2 | [second-order.md:773](../findings/second-order.md), [L128](../findings/second-order.md) proof of (i) | **attribution only**, for orbit-freeness | yes |
| 3 | [second-order.md:781](../findings/second-order.md), L128 "assembly vs new" | **attribution only** (both halves of (i)) | yes |
| 4 | [second-order.md:787](../findings/second-order.md), [Corollary L128.1](../findings/second-order.md) | the **Diophantine conclusion**, to clear the four-set clause at $n\ge12$; and the box's $p=2$ over-count | yes; scope is $p+q=n\ge12$, unpadded |
| 5 | [second-order.md:908](../findings/second-order.md) | the **value** $\mu=\tfrac12$ at $n=6$, as a consistency check | yes |
| 6 | [second-order.md:970](../findings/second-order.md), post F50 | a **strengthening**: $\Sigma=\tfrac32\!\sum\!A^2-\tfrac12\sigma^2$ reproves the threshold | identity verified; equality corrected to the *balanced* $(2,2)$ splits at [r400](REVIEW_r400.md) |
| 7 | [LEDGER.md:170](../findings/LEDGER.md) | status row, records the withdrawal | yes |
| 8 | [ATTEMPTS.md:3409](../ATTEMPTS.md) | the same **strengthening**, "reproves L126 in three lines" | the attempt log carries the *uncorrected* "equality on the whole two-factor family"; superseded at [second-order.md:970](../findings/second-order.md) |
| 9 | [references/krasnov-tkachev-2018-idempotent-geometry/README.md](../references/krasnov-tkachev-2018-idempotent-geometry/README.md) | a **pointer**: L126 is what the literature was searched against | yes; the search returned nothing covering it |

**No citation over-applies the heading.** The heading's phrase "the two-factor family" is looser than the statement's "$n=p+q$", and §8 shows the looseness would bite, but every one of the nine sites is at $n=p+q$.

## 8. One thing the block's own caveat is protecting against, and it is real

The block closes: *"Stated at $n=p+q$: under padding the nonzero blocks are no longer only the $(2,2)$-splits."* That caveat is load-bearing, and sharper than it says.

**Take a four-set of two $F_1$ indices, one $F_2$ index and one padded index.** Then $A=\alpha$, $B=C=\gamma$, so $\sqrt\Sigma=|\alpha-\gamma|=|\gamma|\tfrac{n_0-1}{p-1}$ with $n_0=p+q$, and the $L_e$ value is

$$\frac{\sqrt\Sigma}{2\theta}=\frac1{2(p-1)}\ \le\ \tfrac12,\qquad\text{with equality exactly at }p=2 .$$

**So every padded $S^2\times S^q$ carries four-set blocks at exactly $\tfrac12$, at every $q$**, a case the unpadded lemma reports as $\mu_{2,q}>\tfrac12$, i.e. *not* met. Padding moves the value from above the threshold to on it. This corroborates [nondegeneracy.md:409](../findings/nondegeneracy.md)'s "Padding does **not** preserve nondegeneracy" with a closed form, and it is exactly why L126's final italic must stay. *Suggested addition to that italic, one clause: "and a padded $S^2\times S^q$ carries four-set blocks at exactly $\tfrac12$, value $\tfrac1{2(p-1)}$."*

## 9. Cross-file sweep, no contradiction found

| statement | source | agrees? |
|---|---|---|
| $\mu=\tfrac{n-2}{2(p-1)(q-1)}$, $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$, at $p,q\ge2$ | [Lemma L26](../findings/nondegeneracy.md) | yes, and it is an $L_e$ eigenvalue, $e\circ X=\mu X$ |
| $\mu<\tfrac12$ iff $(p-2)(q-2)>1$; fails only at $\min(p,q)=2$ and $(3,3)$ | [nondegeneracy.md:442](../findings/nondegeneracy.md), [L11](../findings/nondegeneracy.md) | yes |
| $\tfrac12-\mu=\tfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ for $p,q\ge3$, $(p,q)\ne(3,3)$ | [Lemma L27](../findings/nondegeneracy.md) | yes |
| "only solutions are $p=2$ and $(3,3)$" | [nondegeneracy.md:694–696](../findings/nondegeneracy.md) | yes |
| $(2,2)$-split $\pm\mu=\pm\tfrac2{n-2}$; $(3,1)$ and $(4,0)$ give $L_e=0$ | [second-order.md:891–892](../findings/second-order.md) | yes |
| $\dim E(\tfrac12)=18$ at $S^3\times S^3$ = nine cross-factor pair blocks + nine four-set blocks | [L121](../findings/second-order.md), [L127](../findings/second-order.md) | yes; $\binom32^2=9=\dim(\Lambda^2\!\otimes\!\Lambda^2)$ at $(3,3)$, the summand L27 puts $+\mu$ on |
| $S^2\times S^4$ is nondegenerate yet $\mu_{2,4}=\tfrac23>\tfrac12$ | [L11](../findings/nondegeneracy.md), [L128](../findings/second-order.md) box | yes, nondegenerate and a saddle are compatible; L128(ii) excludes the *value* $\tfrac12$, and $\tfrac23\ne\tfrac12$ |

**Sections of [second-order.md](../findings/second-order.md) after line 724 contradict nothing in the block.** [second-order.md:896](../findings/second-order.md)'s "every block has $L_e<\tfrac12$ strictly off the orbit" is at the balanced product with $n\ge8$, where $\mu=\tfrac2{n-2}<\tfrac12$, consistent.

**One live symbol collision, already tabled.** $\mu$ is the four-set $L_e$ eigenvalue here and in [L26](../findings/nondegeneracy.md)/[L27](../findings/nondegeneracy.md), and the scalar $-\min\omega$ in [bispectral.md](../findings/bispectral.md) and [target.md](../findings/target.md). [conventions.md](../findings/conventions.md) already records this; L126 is on the correct side of it throughout.

## 10. Computation run

**One exact-arithmetic screen of claims written above, permitted by the [analysis-only rule](../.claude/rules/analysis-only.md)'s screening allowance and reported as a screen.** In `Fraction` arithmetic: $\mu_{p,q}$ from the first-principles route of §3 against the record's closed form at every $2\le p\le q\le9$ (identical at all $28$); $\theta$ at $S^3\times S^3$ against $\sqrt{10}/3$ ($1.0540925533894598$ both); the ten-summand sum at $(2,4)$ ($86$, against $\dim\mathcal W_6=84$ and the formula's $\dim\mathcal W_2=-2$); and the padded value of §8 ($\tfrac12$ at $(2,4)$ and $(2,6)$, $\tfrac14$ at $(3,5)$). **No search, sweep, census or falsifier hunt was run**, and nothing above rests on the screen, each line was derived by hand first and the screen only agreed.

## 11. Repairs owed

1. **G1**, soften the branch box to carry [nondegeneracy.md](../findings/nondegeneracy.md)'s own two qualifications: the constancy of $\Psi_1$ is sampled, and Puiseux arcs of leading exponent $\ge2$ are unexcluded.
2. **G2**, add "of unit norm" to the opening hypothesis.
3. **Optional, and it closes the block's only assertion**, replace "$u=v=2$ is the only integer solution" with "$(u-1)(v-1)=1$, so $u=v=2$", which proves it and covers $\mathbb Z$ rather than $\mathbb Z_{>0}$.
4. **Optional**, extend the padding italic with the closed form $\tfrac1{2(p-1)}$ of §8, since it is the case where padding lands *on* the threshold.
