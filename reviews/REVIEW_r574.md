# REVIEW r574, Lemma L105

Reviewer r574, independent adversarial audit of `Lemma L105, every two-eigenvalue critical point has $\theta\le\theta_0(n)$, from $T\ge0$ alone`, [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) lines 333–350, with its section preamble at lines 310–312.

Everything below is derived from the definitions in [findings/conventions.md](../findings/conventions.md) and the three per-index relations quoted in [findings/bounds.md](../findings/bounds.md) line 235. **Analysis only**, no computation was run; every number here is arithmetic done by hand and reproducible in one line.

## Overall verdict: CONFIRMED as an inequality, REPAIRED in scope, REFUTED in two adjoining claims

| # | claim | verdict |
| --- | --- | --- |
| V1 | the block states its heading's claim and the argument is present | CONFIRMED |
| V2 | [Lemma L104](../findings/bounds-relaxations.md)'s reduced system (A$_i$)(B$_i$)(C$_i$), re-derived from scratch | CONFIRMED |
| V3 | branch one: multiplier $(x-u)(x+w)$ on the class-$1$ rows gives $\theta\le(n-1)w$ | CONFIRMED |
| V4 | branch two: multiplier $(x-u)^2$ on the class-$2$ rows gives $\theta\le[(n-2)u^2-2uw-w^2]/w$ | CONFIRMED |
| V5 | the normalisation $ru=(N-r)w$, $\delta^2=N/(r(N-r))$, $w=\sqrt{r/(N(N-r))}$ | CONFIRMED |
| V6 | the crossing $(n-2)\rho^2-2\rho-n=0$ at $\rho=n/(n-2)$, value $\theta_0(n)$, parity | CONFIRMED |
| V7 | branch one increasing in $r$, branch two decreasing, **asserted with no proof** | CONFIRMED, gap filled below |
| V8 | $t_{111}\ge0$ and $t_{122}\ge0$ give lower bounds and never bind above | CONFIRMED |
| V9 | the hypothesis "both multiplicities at least $3$" | REPAIRED, redundant at $n\ge5$, the scope is all of $d=2$ |
| V10 | the hypothesis $n\ge5$ | unused by the proof; inherited, not consumed |
| V11 | brief (1b): $T\ge0$ forces $u/w\le n-2$, i.e. $r\ge n/2$ | CONFIRMED, and it sharpens neither branch nor the crossing |
| V12 | "no sum of squares, no Lie theory and no hypothesis that $E_+$ is closed under bracket" | **REFUTED on the first and third clauses** |
| V13 | the two same-file anchors to L70 and L71 | **REFUTED, both broken; L70 and L71 live in [bounds.md](../findings/bounds.md)** |
| V14 | "same conclusion, without Lemma L70 or Lemma L71" | CONFIRMED, with two scope corrections |
| V15 | what the block leans on that is still undefined | $\psi$, the sense of $\Pi$, and $E_+$ |
| V16 | [findings/INDEX-results.md](../findings/INDEX-results.md) row 105's equality clause | overstated relative to the block |
| V17 | propagation | the V12 defect is repeated verbatim at [ATTEMPTS.md](../ATTEMPTS.md) line 2774 |

**The lemma's own inequality is true and its proof is sound.** The three defects are in the paragraphs around it: an over-claimed independence list, two broken links, and a hypothesis narrower than the theorem.

---

## V2, the reduced system, re-derived

Row $a$ in class $i$; sums over **ordered** pairs $(\beta,\gamma)$ with $T$ hollow as a $3$-tensor, so $\beta\ne\gamma$ and both $\ne a$. Writing $\mu_j=m_j-\delta_{ij}$: a cross pair $\{j,k\}$, $j\ne k$, contributes $\mu_j\mu_k$ ordered pairs each way; a same-class pair contributes $\mu_j(\mu_j-1)$. Feeding the weights $1$, $\lambda_\beta$, $\lambda_\beta\lambda_\gamma$ of (A), (B), (C) gives the block's three displays exactly, the $(\nu_j+\nu_k)$ of (B$_i$) against the $2$ of (A$_i$) and (C$_i$) being the two orders of a mixed pair carrying different weights. **CONFIRMED, coefficient by coefficient.**

At $d=2$, with $u>0$ of multiplicity $r$ and $-w<0$ of multiplicity $s=N-r$:

- class $1$: $\mu_1=r-1$, $\mu_2=s$, variables $t_{111},t_{112},t_{122}$;
- class $2$: $\mu_1=r$, $\mu_2=s-1$, variables $t_{112},t_{122},t_{222}$.

## V3, V4, the two branches

Combine the three rows of one class with multipliers $(\alpha,\beta,\gamma)$, so that $\varphi(x)=\gamma x^2+\beta x+\alpha$. A same-class variable $t_{ijj}$ picks up $\mu_j(\mu_j-1)\varphi(\nu_j)$; the cross variable picks up $2\mu_1\mu_2\,\psi(\nu_1,\nu_2)$ with $\psi$ the **polarisation** $\psi(x,y)=\gamma xy+\tfrac\beta2(x+y)+\alpha$, which satisfies $\psi(x,x)=\varphi(x)$.

**Branch one.** $\varphi(x)=(x-u)(x+w)$ has $\varphi(u)=\varphi(-w)=0$, killing $t_{111}$ and $t_{122}$, and $\psi(u,-w)=-2uw+\tfrac{(w-u)(u-w)}2=-\tfrac12(u+w)^2$. So the coefficient of $t_{112}$ is $2(r-1)s\cdot(-\tfrac12)(u+w)^2=-(r-1)(N-r)(u+w)^2$. With $\gamma=1,\ \beta=w-u,\ \alpha=-uw$ the right side is
$$-2(n-2)uw-2uw+2u^2+2u\theta-2u^2=2u\theta-2(n-1)uw.$$
Both sides reproduce the block **verbatim**, and $t_{112}\ge0$ with $u>0$ is exactly $\theta\le(n-1)w$, the $\Pi$-bound of [Lemma L107](../findings/bounds.md), since $w=\lvert\lambda_{\min}\rvert$. **CONFIRMED.** Uses $r\ge2$.

*The block's parenthetical "$\psi(u,-w)=-\tfrac12(u+w)^2$" is consistent with its own display only under the normalised polarisation above, and $\psi$ is defined nowhere on the record, see V15. Under the unnormalised reading the display is off by a factor $2$.*

**Branch two.** $\varphi(x)=(x-u)^2$ has $\varphi(u)=0$ and $\psi(x,y)=(x-u)(y-u)$, so $\psi(u,-w)=0$: $t_{112}$ and $t_{122}$ both die. The survivor is $(s-1)(s-2)\varphi(-w)=(N-r-1)(N-r-2)(u+w)^2$, and with $\gamma=1,\ \beta=-2u,\ \alpha=u^2$ the right side is
$$2(n-2)u^2-4uw-2w^2-2w\theta.$$
Again **verbatim**, and $t_{222}\ge0$ is $\theta\le[(n-2)u^2-2uw-w^2]/w$. **CONFIRMED.** Uses $s\ge3$.

**A strengthening of the derivation's footing that the block does not claim.** Neither branch needs [Lemma L104](../findings/bounds-relaxations.md)'s $G$-averaging or the LP at all. Take the point's **own** $T$ and let $\bar t_{ijk}$ be the average of $T_{abc}$ over the class-multiset; averaging (A), (B), (C) over $a$ in class $i$ reproduces (A$_i$), (B$_i$), (C$_i$) with $\bar t$ in place of $t$, because each right side depends on $a$ only through $\nu_i$. And $\bar t\ge0$ as an average of nonnegatives. So **both branch inequalities hold at every $d=2$ critical point directly**, with the $\Pi(\lambda)$ machinery needed only for the converse reading ("returns $\theta_0(n)$ and no more").

## V5, V6, V7, the normalisation, the crossing, and the missing monotonicity proof

Tracelessness $ru=(N-r)w=:c$ and $\lVert\lambda\rVert^2=ru^2+(N-r)w^2=c(u+w)=c\delta=1$ give $ru\delta=1$, hence $u=\delta(N-r)/N$, $w=\delta r/N$, $\delta^2=N/(r(N-r))$ and $w=\sqrt{r/(N(N-r))}$. **CONFIRMED.** The norm is [conventions.md](../findings/conventions.md)'s $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$ on $\Lambda^2$; the block is in the record's pairing.

With $\rho=u/w=(N-r)/r$ one gets $w=\rho^{-1/2}/\sqrt N$, so the two branches are
$$\text{br}_1=\frac{(n-1)\rho^{-1/2}}{\sqrt N},\qquad \text{br}_2=\frac{\rho^{-1/2}}{\sqrt N}\big[(n-2)\rho^2-2\rho-1\big],$$
and $\text{br}_1\le\text{br}_2\iff(n-2)\rho^2-2\rho-n\ge0$. That quadratic factors exactly: its roots are $\rho=\frac{1\pm(n-1)}{n-2}$, namely $\rho=n/(n-2)$ and $\rho=-1$, since the discriminant is $4+4n(n-2)=4(n-1)^2$. **The crossing is confirmed, and the brief's identity check is confirmed:** $\frac{n^2}{n-2}-\frac{2n}{n-2}-n=\frac{n^2-2n-n^2+2n}{n-2}=0$.

$\rho=n/(n-2)$ gives $(N-r)/r=n/(n-2)$, hence $r(2n-2)=(n-2)N$ and $r=n(n-2)/4$, $N-r=n^2/4$. Then $w=\rho^{-1/2}/\sqrt N=\frac1n\sqrt{2(n-2)/(n-1)}$ and $\theta=(n-1)w=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$. **CONFIRMED, and matching [conventions.md](../findings/conventions.md)'s $\theta_0(n)^2=2(n-1)(n-2)/n^2$.**

**V7, the block asserts the monotonicity and proves nothing.** "The first branch is then increasing in $r$ and the second decreasing" is the load-bearing step of the whole $\le\theta_0(n)$ chain and carries no argument. It is true, and here is the proof. $\text{br}_1$ is $(n-1)\rho^{-1/2}/\sqrt N$, strictly decreasing in $\rho$, i.e. strictly increasing in $r$. For $\text{br}_2$ put $g(\rho)=(n-2)\rho^{3/2}-2\rho^{1/2}-\rho^{-1/2}$; then
$$g'(\rho)=\rho^{-3/2}\Big[\tfrac32(n-2)\rho^2-\rho+\tfrac12\Big],$$
whose bracket has discriminant $1-3(n-2)<0$ for every $n\ge3$, so $g'>0$ on all of $(0,\infty)$: $\text{br}_2$ is strictly increasing in $\rho$, i.e. strictly decreasing in $r$, **with no restriction on the range**. *This matters: the naive reading ($\text{br}_2=w[(n-2)\rho^2-2\rho-1]$ with $w$ rising and $\rho$ falling), is a product of one rising and one falling factor and settles nothing. The $-\rho^{-1/2}$ term is what supplies the $+\tfrac12\rho^{-3/2}$ that makes $g'$ positive everywhere.*

Hence for $\rho\ge n/(n-2)$ the minimum is $\text{br}_1$, decreasing in $\rho$, so at most its value at $\rho=n/(n-2)$; for $\rho\le n/(n-2)$ it is $\text{br}_2$, increasing in $\rho$, so again at most that same value. **$\min\{\text{br}_1,\text{br}_2\}\le\theta_0(n)$ for every $\rho>0$, with equality only at $\rho=n/(n-2)$.**

**Parity.** $n$ even, $n=2k$: $r=k(k-1)\in\mathbb Z$. $n$ odd: $n(n-2)$ is odd, so $n(n-2)/4\notin\mathbb Z$ and $r$ cannot reach the crossing; the inequality is strict. **CONFIRMED.**

*On warning `W5`.* No conflict. $\Theta_n<\theta_0(n)$ at odd $n$, cross-multiplying $\frac{n-3}{(n+1)(n-2)}$ against $\frac{n-2}{n^2}$ gives $n^3-3n^2$ against $n^3-3n^2+4$, so the strict bound $\theta<\theta_0(n)$ that L105 delivers at odd $n$ is consistent with the diagonal value sitting strictly below it. The block does not claim $\Theta_n$ anywhere, and it should not be repaired to.

## V8, the two lower constraints

Isolating $t_{111}$ needs $\varphi(-w)=0$ and $\psi(u,-w)=0$, i.e. $\varphi(x)=(x+w)^2$, which returns $(r-1)(r-2)(u+w)^2t_{111}=2(n-2)w^2-4uw-2u^2+2u\theta$, so
$$t_{111}\ge0\iff\theta\ \ge\ \frac{u^2+2uw-(n-2)w^2}{u}=w\Big[\rho+2-\frac{n-2}\rho\Big].$$
Isolating $t_{122}$ needs $\varphi(x)=(x-u)^2$ on the class-$1$ rows, returning $s(s-1)(u+w)^2t_{122}=2(n-1)u^2+2u\theta$, i.e. $\theta\ge-(n-1)u$, vacuous at $\theta\ge0$. **Both are lower bounds. CONFIRMED.**

*A check of the block's own numeric claim, by hand and exactly.* At $n=6$, $N=15$, the balanced $r=6$: $w=\sqrt{6/135}=\sqrt{2/45}$, upper end $(n-1)w=5\sqrt{2/45}=\sqrt{10}/3=\theta_0(6)$, lower end $w[\rho+2-(n-2)/\rho]$ at $\rho=3/2$ is $\tfrac56w=\sqrt{10}/18$. **The recorded segment $[\sqrt{10}/18,\ \sqrt{10}/3]$ is exact, and its lower endpoint is the $t_{111}\ge0$ facet.**

## V9, the multiplicity hypothesis is redundant at $n\ge5$: REPAIRED

The hypothesis "both multiplicities at least $3$" does two things and only one is needed. **Branch two needs $s\ge3$**, the coefficient $(s-1)(s-2)$ vanishes below it, and $t_{222}$ is not even an admissible type. **Branch one needs only $r\ge2$.** The $r\ge3$ half is used nowhere in the block's own argument; it is used in V11's derived fact, which the block does not invoke.

More to the point, **every excluded case is infeasible at $n\ge5$**, so the lemma's conclusion holds on the whole $d=2$ stratum. Each of the four is one line from (A) and (B) of a single row plus tracelessness.

| case | derivation | verdict at $n\ge5$ |
| --- | --- | --- |
| $r=1$ | row $1$ has $\mu_1=0$, so only $t_{122}$ survives; (A$_1$) and (B$_1$) force $u=(n-2)w$, while $\rho=N-1$; so $\binom n2-1=n-2$, i.e. $n=2$ | infeasible |
| $s=1$ | symmetric at row $2$: $w=(n-2)u$ with $\rho=1/(N-1)$, again $n=2$ | infeasible |
| $r=2$ | (A$_1$),(B$_1$) give $2s\,t_{112}=4[(n-2)w-u]/(u+w)$, so $t_{112}\ge0$ needs $\rho\le n-2$; but $\rho=(N-2)/2$, and $(N-2)/2\le n-2$ is $(n-1)(n-4)\le0$ | infeasible |
| $s=2$ | (A$_2$),(B$_2$) give $r\,t_{122}=2[(n-2)u-w]/(u+w)$, so $t_{122}\ge0$ needs $r\le2(n-2)$; but $r=N-2$, and $N-2\le2n-4$ is again $(n-1)(n-4)\le0$ | infeasible |

**Independent confirmation of L104's own witness.** At $n=8$, $s=2$: $N=28$, $r=26$, $\rho=1/13$, so $r\,t_{122}=2(6u-13u)/(14u)=-1$ and $t_{122}=-1/26$. That is L104's recorded value, reached here from row $2$'s (A) and (B) alone.

**Consequence.** L105's conclusion is true of *every* two-eigenvalue critical point at $n\ge5$, with no multiplicity hypothesis. The block states less than it proves, and a consumer applying it to "the two-eigenvalue stratum" without checking multiplicities is right for a reason the block does not supply.

## V10, $n\ge5$ is not consumed

No step above uses $n\ge5$. The monotonicity needs $n\ge3$; the branch identities need only that (A), (B), (C) hold; the crossing arithmetic is valid at $n=4$, where $r=n(n-2)/4=2$ and $s=4$ satisfy $s\ge3$. The hypothesis is inherited from the surrounding programme, [Lemma L71](../findings/bounds.md) genuinely needs it, and is harmless, but it is not a hypothesis of this lemma. *It should stay only if a consumer needs the uniformity.*

## V11, brief (1b): $\rho\le n-2$, i.e. $r\ge n/2$: CONFIRMED, and it changes nothing here

The fact is real and I reach it by a route the block does not use. Compatibility of the $t_{111}\ge0$ lower bound with the $t_{112}\ge0$ upper bound requires
$$w\Big[\rho+2-\frac{n-2}\rho\Big]\le(n-1)w\iff\rho^2-(n-3)\rho-(n-2)\le0,$$
whose discriminant is $(n-3)^2+4(n-2)=(n-1)^2$, giving roots $\rho=n-2$ and $\rho=-1$. So $\rho\le n-2$, and $(N-r)/r\le n-2$ is $N\le(n-1)r$, i.e. $r\ge N/(n-1)=n/2$. **CONFIRMED.** It needs $r\ge3$ for $t_{111}$ to exist.

**It does not sharpen either branch or the crossing.** The crossing sits at $\rho=n/(n-2)$, which is inside the admitted range: $n/(n-2)\le n-2\iff(n-1)(n-4)\ge0$, true for every $n\ge4$. So the maximum of $\min\{\text{br}_1,\text{br}_2\}$ over the *restricted* domain is still $\theta_0(n)$, attained at the same $r$. What the fact does is cut the branch-one side of the picture ($\rho$ large, $r$ small), which is the side where the bound is already below $\theta_0$. **The block's branch analysis respects it and gains nothing from it.**

## V12, "no sum of squares, no Lie theory and no hypothesis that $E_+$ is closed under bracket": REFUTED, twice

The claim is that branch two *is* [Lemma L23](../results.md)'s dimension cap $r\le n(n-2)/4$, delivered from $t_{222}\ge0$ under that three-item list. Two of the three items are false, and the identification itself needs a hypothesis the list denies.

**(a) "no sum of squares" is false.** L23's cap comes from $S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2\ge0$. In reduced variables $S_{\mathfrak{mmm}}=(N-r)(N-r-1)(N-r-2)\,t_{222}$, and $T_{abc}=c_{abc}^2$ by [conventions.md](../findings/conventions.md). **$t_{222}\ge0$ is that same sum of squares, divided by a positive integer.** The block replaces a sum of squares by the identical sum of squares in other coordinates and reports the replacement as an elimination.

**(b) "no hypothesis that $E_+$ is closed under bracket" is false, and the record already suspects it**, [findings/LEDGER.md](../findings/LEDGER.md) line 1405 files the third clause as "under audit, the third clause looks false". Here is the derivation that settles it. Substituting $\theta=(n-1)w$ into branch two's identity:
$$2(n-2)u^2-4uw-2w^2-2(n-1)w^2=2w^2\big[(n-2)\rho^2-2\rho-n\big],$$
and with $(u+w)^2=w^2(\rho+1)^2$, $\rho+1=N/r$ and $(n-2)\rho^2-2\rho-n=(n-2)(\rho+1)\big(\rho-\tfrac n{n-2}\big)$,
$$S_{\mathfrak{mmm}}=\frac{(N-r)\cdot2w^2(n-2)(\rho+1)\big(\rho-\tfrac n{n-2}\big)}{w^2(\rho+1)^2}=(N-r)\Big[2(n-2)-\frac{4(n-1)r}{N}\Big],$$
which is L23's closed form exactly. **The substitution $\theta=(n-1)w$ is $\Pi$-saturation, which is $t_{112}=0$, which is $\langle[E_+,E_+],E_-\rangle=0$, precisely "$E_+$ is closed under bracket".** *(That $\theta=(n-1)w$ holds on L23's family is checkable in one line: $(n-1)w=(n-1)\sqrt{r/(N(N-r))}$ and L23's $\theta=\tfrac2n\sqrt{rN/(N-r)}$ differ by the factor $n(n-1)/(2N)=1$.)*

Without $t_{112}=0$, $t_{222}\ge0$ gives a bound on $\theta$ and **no cap on $r$ at all**: for $\rho$ just below $n/(n-2)$ (so $r$ just above $n(n-2)/4$), branch two is just below $\theta_0(n)$ and still positive, the binding lower bound $w[\rho+2-(n-2)/\rho]$ is negative there, and the segment is nonempty. So $r>n(n-2)/4$ is feasible in $\Pi(\lambda)$ at a smaller $\theta$. **"Branch two *is* the dimension cap" is true on the $\Pi$-saturated locus and false off it.**

**(c) "no Lie theory" survives**, the branch-two inequality itself is three linear relations and a sign, with no bracket-closure or subalgebra input. That clause stands.

**Suggested repair, keeping the true content.** Replace the sentence with: *branch two is the inequality $S_{\mathfrak{mmm}}\ge0$ read at a general two-eigenvalue point; on the $\Pi$-saturated locus $t_{112}=0$ (equivalently, where $E_+$ is a subalgebra), it reduces to L23's closed form and its cap $r\le n(n-2)/4$, and off that locus it is a bound on $\theta$ rather than on $r$.* The genuinely new content, which is real and which this repair keeps, is that **the $\theta\le\theta_0(n)$ conclusion no longer needs the subalgebra hypothesis, even though the dimension cap does.**

**And the list is missing what the record's audits keep finding missing.** Branch two's *inequality* is scale-covariant and needs neither unit norm nor tracelessness; the chain **to the number $\theta_0(n)$** needs both, and the block does use both in its second paragraph. They are in the lemma statement, so this is exposition rather than a defect, but the list should say what the lemma does need: (A) the Killing marginal, (B) Ricci-flatness with first Bianchi, (C) criticality, $T\ge0$, unit norm, tracelessness, and $s\ge3$.

## V13, the anchors: REFUTED

Nine links leave the block. Seven resolve: [../results.md](../results.md), [graded-half.md](../findings/graded-half.md), [fence-posts.md](../findings/fence-posts.md) twice (post F40 is at its line 324), [../reviews/DERIVE-t11.md](DERIVE-t11.md), [../reviews/REVIEW_r334.md](REVIEW_r334.md), [../plan.md](../plan.md) (I15 at line 169).

**Two do not.** Line 345 writes `[Lemma L70](../findings/LEDGER.md#lemma-l70-the-deficiency-identity-and-what-saturates-it)` and `[Lemma L71](../findings/bounds.md#lemma-l71-saturation-forces-the-balanced-sphere-product-with-no-two-eigenvalue-hypothesis)` as **same-file** anchors, from inside [bounds-relaxations.md](../findings/bounds-relaxations.md). Neither heading exists in that file; both are in [bounds.md](../findings/bounds.md), at lines 185 and 450. The slugs themselves are correct for those headings, so the fix is to prefix the file:

- `[Lemma L70](bounds.md#lemma-l70-the-deficiency-identity-and-what-saturates-it)`
- `[Lemma L71](bounds.md#lemma-l71--saturation-forces-the-balanced-sphere-product-with-no-two-eigenvalue-hypothesis)`

*The correct form is already in the same file twice, lines 360 and 454 write `[Lemma L70](bounds.md)`, so this is a transcription slip, not a convention the file holds.*

## V14, the relation to Theorem A: CONFIRMED, with two corrections

[DERIVE-t11.md](DERIVE-t11.md) §1's Theorem A is $\theta\le B_n(\rho)=\min\{n-1,\ (n-2)\rho-1\}/\sqrt{N\rho}\le\theta_0(n)$, built from [Lemma L70](../findings/bounds.md) and the $\Pi$-bound. L105's bound is $\min\{\Pi,\ (n-2)\rho^2-2\rho-1\}\cdot m$, whose second branch is that same file's **Corollary B2 (iii)**, the tangent bound. Corollary B2 proves $\min\{\Pi,(\mathrm{iii})\}\le$ L70 with equality iff $\rho=n/(n-2)$.

- **"Without Lemma L70": CONFIRMED.** L105 replaces L70 by the strictly sharper (iii) everywhere off the balanced ratio, and the two bounds agree only at the crossing.
- **"Without Lemma L71": CONFIRMED, but only because L105 claims less.** Theorem A's equality case identifies $W$ as the Weyl tensor of $S^{n/2}\times S^{n/2}$, and that step is L71. L105's equality case reaches "the balanced sphere product's **spectrum**" and stops. **These are not the same statement**: L105 is sharper as an inequality and weaker as a rigidity claim, on the same set.
- **The block's closing "the unique point where both facets bind" asserts more than it proves.** $t_{112}=t_{222}=0$ gives $[E_+,E_+]\subseteq E_+$ and $[E_-,E_-]\subseteq E_+$, i.e. a symmetric pair with $\dim E_+=n(n-2)/4$; *uniqueness* then needs the classification step that L23 carries ($\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone, $n=8$ included via triality). The conclusion is right; the word "unique" is borrowed.
- **A correction to the brief's own premise.** The brief says ATTEMPTS.md's Theorem A "now has four claimants, L66, L99 and this". That conflates two different theorems. [ATTEMPTS.md](../ATTEMPTS.md) line 985's Theorem A is the **direct-sum saddle lemma**, which is what [Lemma L66](../findings/support-dichotomy.md) and [Lemma L99](../findings/diagonal-half.md) point at ([diagonal-half.md](../findings/diagonal-half.md) line 175 records that join as owed). L105 points at [DERIVE-t11.md](DERIVE-t11.md)'s Theorem A, the two-eigenvalue bound, and **its link is correct**. The real hazard is that "Theorem A" now names at least four distinct objects on this record, Jäger's ([ATTEMPTS.md](../ATTEMPTS.md) line 780), the structure theorem (line 926), the saddle lemma (line 985), and DERIVE-t11's, which belongs in [conventions.md](../findings/conventions.md) beside $\Pi$, $B$, $M$ and $d$.

## V15, what the block leans on that is still undefined

- **$\psi$, the polarisation.** Used as the mechanism of both branches, defined nowhere in the block, nowhere in [L104](../findings/bounds-relaxations.md), and nowhere in [conventions.md](../findings/conventions.md). It is the one symbol here where the two natural readings differ by a factor $2$, and the block's own display fixes the normalised one. **This is the sharpest gap.**
- **The letter $\Pi$, at two of its four tabled senses inside one section.** L104 one heading above uses sense (iv), $\Pi(\lambda)$, the LP feasible set; L105 writes "**the $\Pi$-bound**", which is sense (ii), [post F40](../findings/fence-posts.md)'s $4(n-1)\lvert\lambda_{\min}\rvert$ with $\theta\le\Pi/4$. Neither use says which. [conventions.md](../findings/conventions.md)'s $\Pi$ row says "Sense (i) is meant below", which is about that file, so it gives a reader no help here.
- **$E_+$.** Used in the sentence V12 refutes. [conventions.md](../findings/conventions.md) tables $\mathfrak m=E_{\min}$ and $\mathfrak h=E_{\max}$; $E_+$ appears in neither. At $d=2$ it is unambiguous, which is why it has survived.
- **$r$.** The block's $r$ is the multiplicity of the positive eigenvalue; [conventions.md](../findings/conventions.md) tables $\mathfrak r$ for "everything else, kernel included" at a critical point. Different objects, one letter apart, both live in this argument's vocabulary.
- **"hollow" of a $3$-tensor** is now tabled and is the sense used. ✔
- **$d$** as the distinct-eigenvalue count is now tabled and is the sense used. ✔

## V16, V17, the index row and the propagation

**[findings/INDEX-results.md](../findings/INDEX-results.md) row 105** reads "*equality only at the balanced product*". The block proves equality only at the balanced product's **spectrum**; the point-level statement is true but needs L23's or L71's classification, which the block does not run. The row should say "equality only at the balanced spectrum, $n$ even" or the block should complete the step.

**[ATTEMPTS.md](../ATTEMPTS.md) line 2774** repeats V12's over-claim verbatim: "*the second is Lemma L23's dimension cap $r\le n(n-2)/4$ obtained from $T\ge0$ alone*". The same repair applies there.

**[results.md](../results.md) carries no L105.** So do L104, L107, L109, L114, L115, L116 and L119, a systemic backlog of the recent block, not a defect of this lemma. Noted, not charged here.

## What a REFUTED needs, supplied

The two refutations above are carried by derivations sharing nothing with the block's route: the $S_{\mathfrak{mmm}}$ closed form is reached by substituting $\Pi$-saturation into branch two and factoring the crossing polynomial, and the anchor failure is a file-level fact checkable with one grep of [bounds.md](../findings/bounds.md).

## Closing

**The lemma is true, its two branch identities are exact, its crossing and parity claims are exact, and its scope is wider than stated.** What needs work is the paragraph after the proof, two links, and a symbol.
