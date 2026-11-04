# Gate 2 review r376, [I18](../plan.md)'s five claims: [Corollary L128.1](../findings/second-order.md), the band, the perturbation route, the Gershgorin attempt, the Dirichlet restatement

Brief: attack the five claims recorded in the tail of [ATTEMPTS.md](../ATTEMPTS.md) and in [plan.md](../plan.md)'s I18 item, working from the definitions. Everything in §0 was derived before any of the author's text was opened. **Analysis only**, the one numerical act was a seconds-long arithmetic screen of closed forms I had already derived by hand, reported as a screen; no search, sweep or census was opened.

**Verdicts.**

| claim | verdict | one line |
|---|---|---|
| 1. [Corollary L128.1](../findings/second-order.md), every $S^p\times S^q$ at $n\ge12$ clears the criterion | **CORRECTED** | it silently assumes $p,q\ge3$: its $\mathcal D_n$ leg is [Lemma L27](../findings/nondegeneracy.md)'s summand list, whose statement opens "Let $p,q\ge3$" and whose decomposition [Lemma L126](../findings/second-order.md) records as **over-counting at $p=2$** ($86$ against $84$). At $p=2$ the $\mathcal D_n$ leg has no support. **Harmless to I18**, and the repair is one line: every sphere product with $\theta\ge\sqrt{3/2}$ has $\min(p,q)\ge5$ |
| 2. the band $[\sqrt{3/2},\Theta_n]$ from [Lemma L57](../findings/problem.md) | **CONFIRMED** | L57 is stated and proved as an inequality on the **whole** diagonal locus, for every diagonal $W$ at every $n\ge4$, not at maximisers. The band is legitimate as used. The odd form is the right one and the route does need it |
| 3. the perturbation route closed uniformly in $n$ | **CORRECTED** | the two facts (margin $\sim1/n$, band $\to0.189$) are right and the binding block is right for $m\ge5$, but the within-factor pair block is **tied**, not uniquely binding: $\mathcal D_n$ carries the identical $\lambda_p=(p-2)/(2(p-1))$, and the table omits it. "Provably not enough" overstates: the value-to-distance conversion it needs is an unproved quantitative L57. "Asymptotically a branch point" imports exactly the reading [Lemma L127](../findings/second-order.md) withdrew |
| 4. the Gershgorin attempt fails at the balanced product "by one unit of $\lvert\gamma\rvert$" | **REFUTED** | $M_{jk}=\alpha$ for a within-factor pair and $\alpha$ is **positive**. The condition $\lVert M_i\rVert_1<\theta+M_{jk}$ **holds** at $S^m\times S^m$ in every orbit-free block, at every $m\ge2$, with slack $\lvert\gamma\rvert/(m-1)$. The recorded failure drops $M_{jk}$ from the right-hand side; the hand-check three paragraphs later carries a compensating sign error that flips $\alpha$ |
| 5. the Dirichlet restatement, and the word "forced" | **CORRECTED** | the split the brief suspected is real. $\Delta^{(jk)}o=-(\theta+M_{jk})o$ holds at **every** diagonal critical point from criticality and zero row sums alone (I derive it below) so "forced" is right for the eigenvector. The **inequality** is [Lemma L24](../findings/second-order.md) and needs maximality, so "strictly, except along the orbit" is the open goal, not a fact, and off a maximiser the orbit need not be the minimiser at all |

One free-standing confirmation: the signed-weight question the brief posed. The identity $x^\top\Delta x=\tfrac12\sum_{i,l}w_{il}(x_i-x_l)^2$ uses only symmetry of $w$; positivity is never invoked. **What signs break is $\Delta\succeq0$, never the identity.** The record's Dirichlet form is therefore exactly right as an identity and exactly as hard as it says as an inequality.

---

## 0. What I derived before reading the record

Recorded first so the agreements below are agreements and not readings.

**The sectional matrix and $\theta$ at $S^p\times S^q$, from the definitions.** Write $\alpha,\beta,\gamma$ for the within-$F_1$, within-$F_2$ and cross entries. Zero row sums give $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$, so $\alpha=-q\gamma/(p-1)$, $\beta=-p\gamma/(q-1)$. Diagonal criticality on a **cross** pair reads $\gamma^2+\big[(p-1)\alpha\gamma+(q-1)\beta\gamma\big]=\theta\gamma$, i.e.

$$\theta=\gamma+(p-1)\alpha+(q-1)\beta=\gamma(1-p-q)=-(n-1)\gamma .$$

Criticality on a **within** pair is then an identity, not a second condition: $(p-1)\alpha^2+q\gamma^2=q\gamma^2(n-1)/(p-1)=\theta\alpha$ by the same substitution. So every $S^p\times S^q$ with $p,q\ge2$ is a pure critical point, and $\theta>0$ forces $\gamma<0$, hence $\alpha,\beta>0$.

**That sign is geometry, not convention.** The Weyl sectional curvature of the product of two unit round spheres is $1-(m-1)/(n-1)=m/(2m-1)>0$ inside a factor and $-(m-1)/(2m-1)<0$ across it, at $p=q=m$. **The within-factor entry is positive and the cross entry negative.** This is the fact claim 4 turns on.

**Normalisation and $\Theta_n$.** With $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^\top X)=\sum_{i<j}M_{ij}^2$, the constraint $\lVert W\rVert=1$ gives $\gamma^2=2(p-1)(q-1)/\big(pq(n-1)(n-2)\big)$ (the numerator collapsing through $p^2+q^2+2pq-3p-3q+2=(n-1)(n-2)$), hence

$$\theta_{p,q}=\sqrt{\frac{2(n-1)(p-1)(q-1)}{pq\,(n-2)}} .$$

$(1-1/p)(1-1/q)$ is log-concave in $p$ at fixed $p+q$, so the balanced split maximises, giving $\Theta_n^2=2(n-1)(n-2)/n^2$ at even $n$ and $\Theta_n^2=2(n-1)(n-3)/\big((n+1)(n-2)\big)$ at odd $n$, both $\to2$. **Both match [Lemma L57](../findings/problem.md) exactly**, and $\sqrt2-\sqrt{3/2}=0.18947$ is the record's $0.189$.

**The pair block, from [Lemma L122](../findings/second-order.md)'s form.** For a **within-$F_1$** pair $\{j,k\}$ the block $\tfrac12\big[\mathop{\mathrm{diag}}(M_{ji}+M_{ki})-M_{jk}\mathrm{Id}+M^{(jk)}\big]$ has three eigenvector types on $\mathbf1^\perp$, and $\alpha-\gamma=-\gamma(n-1)/(p-1)=\theta/(p-1)$ gives the full spectrum in $L_e$ units:

$$\Big\{\underbrace{\tfrac{p-2}{2(p-1)}}_{\text{simple}},\ 0^{\,p-3},\ \Big[-\tfrac{1}{2(n-1)}\big(2+\tfrac q{p-1}+\tfrac p{q-1}\big)\Big]^{q-1}\Big\},\qquad\text{total }n-3 .$$

For a **cross** pair the diagonal is constant at $\alpha+\gamma$ and the block collapses to $\{\tfrac12\ \text{simple},\ 0^{\,n-4}\}$, the $\tfrac12$ on $x_i=M_{ki}-M_{ji}$. **Both agree with [Lemma L127](../findings/second-order.md)**, and the cross-factor derivation goes through at $p=2$ unchanged.

**One correction to the within-factor row while I am here.** At $p=2$ the first and third eigenvector types are empty (there is no $F_1\setminus\{j,k\}$ and the constant-on-parts mode is killed by the Ricci cut) so the block is the single value $\tfrac12(2\gamma-\alpha-\beta)<0$ with multiplicity $n-3$, and the quoted top $(p-2)/(2(p-1))=0$ is **not** in the spectrum. Harmless as an upper bound; inaccurate as a spectrum, and [Lemma L127](../findings/second-order.md)'s table states the row without a $p\ge3$ qualifier.

**The four-set block, independently.** A $(2,2)$-split has $A=\alpha+\beta$, $B=C=2\gamma$, so $\Sigma=(A-B)^2$ and $\mu=\lvert\alpha+\beta-2\gamma\rvert/(2\theta)=(n-2)/\big(2(p-1)(q-1)\big)$; every other split has $A=B=C$ and gives $0$. So $\mu=\tfrac12\iff(p-1)(q-1)=n-2\iff p=q=3$. **Confirms [Lemma L126](../findings/second-order.md) at every $p,q\ge2$, $p=2$ included.**

---

## 1. [Corollary L128.1](../findings/second-order.md), CORRECTED

**What is genuinely checked, and by how much.** Two of the three legs I re-derived above hold at every $p,q\ge2$: the four-set leg ($\Sigma=\theta^2$ only at $(3,3)$) and both pair legs. The third leg is $\mathcal D_n\cap W^\perp$, and there the corollary says only "carries $\{\lambda_p,\lambda_q,-\mu,0\}$ from [Lemma L27](../findings/nondegeneracy.md)'s summand list".

**[Lemma L27](../findings/nondegeneracy.md)'s statement opens "Let $p,q\ge3$ with $(p,q)\ne(3,3)$".** The corollary's scope is "every two-block sphere product at $n\ge12$", which includes $p=2$; $S^2\times S^{n-2}$ is a pure critical point by §0 and [Lemma L126](../findings/second-order.md) discusses it by name. At $p=2$ the ten-summand decomposition does not merely lack a proof, the record already knows it is **wrong**: [Lemma L126](../findings/second-order.md) records $86$ against $\dim\mathrm{Weyl}_6=84$ at $S^2\times S^4$, and the excess is exactly $\dim S^2_0(\mathbb R^2)=2$. So the $\mathcal D_n$ leg at $p=2$ rests on a decomposition the record has already flagged as failing there.

**And at $p=2$ that leg is the whole question.** By §0 the cross-factor blocks contribute exactly $pq=\dim\mathcal O$ copies of $\tfrac12$; the four-set blocks contribute none; the $F_1$ within-pair block sits at a single negative value and the $F_2$ ones top at $(q-2)/(2(q-1))<\tfrac12$. **So nondegeneracy of $S^2\times S^q$ reduces exactly to the diagonal second-order condition on $\mathcal D_n$, and nothing in the record decides it.**

**Two further overstatements in the same sentence.** The list $\{\lambda_p,\lambda_q,-\mu,0\}$ is an assertion about *which* $O(p)\times O(q)$-summands meet the $\Gamma$-block $\mathcal D_n$, and the two decompositions are not compatible: at $(3,3)$ the value $-\mu=-\tfrac12$ has multiplicity $25=\dim S^2_0\otimes S^2_0$, of which only $9$ sit in four-set blocks, $12$ in within-factor pair blocks and $4$ in $\mathcal D_n$, which is [Lemma L127](../findings/second-order.md)'s $(-\mu)^{(p-1)(q-1)}$ on the nose. The assignment is therefore real but it is L127's, and L127 says in its own box that the $\mathcal D_n$ row **is** L27's. Second, the list omits $+\mu$, which needs excluding rather than assuming absent; for $p,q\ge3$ at $n\ge12$ it is $<\tfrac12$ anyway, but at $p=2$ it is $(n-2)/(2(n-3))>\tfrac12$.

**And for $p,q\ge3$ the corollary proves less than it appears to.** [Lemma L27](../findings/nondegeneracy.md) already states $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ attained **exactly** on the orbit tangent, which is [Lemma L128](../findings/second-order.md)(ii) verbatim. The block-by-block check adds attribution, not the conclusion. The corollary's genuine novelty is (iii)'s isolation, correctly credited.

**The repair, and it costs one line.** I18 does not need every sphere product, it needs those with $\theta\ge\sqrt{3/2}$. From $\theta_{p,q}$ in §0:

- $p=2$: $\theta=\sqrt{(n-1)(n-3)}/(n-2)<1$ at every $n$, since $(n-1)(n-3)=(n-2)^2-1$;
- $p=3$: $\theta^2=4(n-1)(n-4)/\big(3(n-3)(n-2)\big)\nearrow\tfrac43<\tfrac32$;
- $p=4$: $\theta^2>\tfrac32\iff(n-1)(n-5)>(n-4)(n-2)\iff5>8$, **false at every $n$**, the family approaches $\sqrt{3/2}$ strictly from below;
- $p=5$: $\theta^2>\tfrac32\iff n^2-7n-54>0\iff n\ge12$.

**So every $S^p\times S^q$ with $\theta\ge\sqrt{3/2}$ has $\min(p,q)\ge5$, at every $n\ge12$**, and [Lemma L27](../findings/nondegeneracy.md)'s hypothesis is satisfied with room. *Screened: at $n=12,13$ the clearing splits are $p\in\{5,6\}$ only; $p=4$ gives $1.201561,1.218349,1.224550,1.224743$ at $n=12,20,100,1000$.* The corollary should be restated with the threshold in it, or with $p,q\ge3$ declared; as written it claims a case it does not hold.

---

## 2. The band, CONFIRMED

**The brief's key question has a clean answer.** [Lemma L57](../findings/problem.md) reads "$\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ **for every diagonal $W$ at every $n\ge4$**", with equality exactly at the balanced product. It is a bound on the whole diagonal locus. A pure critical point is diagonal in its eigenframe and $P$ is $O(n)$-invariant, so $\theta\le\Theta_n$ follows for every pure critical point with no maximality anywhere. **The band is legitimate as used, and everything built on it stands.** My independent $\Theta_n$ in §0 reproduces both parity forms exactly, and $\Theta_{12}=\sqrt{55}/6=1.236033$ against $\sqrt{3/2}=1.224745$ gives the recorded width $0.011286$.

**The odd form is the right one, and the route needs it.** I18 is stated at $n\ge12$ with no parity restriction, and by [findings/INDEX.md](../findings/INDEX.md) odd $n$ is the half still open, so odd $n$ is in scope. The odd $\Theta_n$ is the max of $\theta_{p,q}$ over $p+q=n$ at $p=(n-1)/2$, which I re-derived to $2(n-1)(n-3)/\big((n+1)(n-2)\big)$ independently. Using the even form at odd $n$ would be a false narrowing: $\Theta_{13}=1.248376>\Theta_{12}=1.236033$, so the odd band is **wider** than its even predecessor, not narrower. Bounding odd $n$ by $\Theta_{n+1}$ would be valid but weaker still.

**One consequence the record has not drawn.** At odd $n$ the L57 equality case is the **unbalanced** $S^{(n-1)/2}\times S^{(n+1)/2}$, so a perturbation route at odd $n$ perturbs off an unbalanced product, whose binding within-factor margin is the smaller factor's $1/(2(p-1))=1/(n-3)$. The [ATTEMPTS.md](../ATTEMPTS.md) table is written at $S^m\times S^m$ only. The conclusion is unchanged (still $\Theta(1/n)$) but the table's "value at $S^m\times S^m$" column does not cover half the range the item claims.

**Two silent hypotheses inside L57's own proof, in the "Step 1 is PROVED" derivation.** The contraction $\sum_{i<j}(v_i-v_j)^2=n\sum v^2-(\sum v)^2=n$ needs $\sum_iv_i=0$, which follows from $v\perp\mathbf1$ only when $\mu\ne0$; and the final division of $\lambda\mu\le\tfrac{n-1}n\mu^2$ by $\mu$ needs $\mu>0$. Both hold at the intended $\mu=\mu_{\max}$ and neither is stated. I re-derived $(*)$ and the two contractions from the definitions and they are correct.

---

## 3. The perturbation route, CORRECTED

**The two facts are right.** The four-set $(2,2)$ margin at $S^m\times S^m$ is $\tfrac12-\tfrac1{m-1}=(m-3)/(2(m-1))$ and the within-factor pair margin is $1/(2(m-1))$; both follow from §0. The band tends to $0.189$. Both re-derived.

**"Is the within-factor pair block really binding at every $m$?", no, and the table is missing a row.** The margins are $(m-3)/(2(m-1))$ against $1/(2(m-1))$, so the within-factor block binds iff $m>4$: at $m=4$ the two **tie** at $\tfrac16$, and at $m=3$ the four-set block binds at margin $0$ ($S^3\times S^3$). For $n\ge12$ the item's claim holds. But [Lemma L127](../findings/second-order.md)'s $\mathcal D_n$ row carries $\lambda_p=(p-2)/(2(p-1))$ (**the identical value**) and [Lemma L121](../findings/second-order.md) says so explicitly in its "attribution dispute" paragraph. So the binding margin is attained in **two** block families and the table lists one. That does not change the number; it does mean the route's obstruction sits in $\mathcal D_n$ too, which is the clause I18(d) has not started, so the two are the same obstruction and should be recorded as one.

**"Provably not enough" overstates what is proved.** The argument needs to convert a *value* gap $\Theta_n-\sqrt{3/2}$ into an $M$-*distance* $d$ from the balanced orbit, and the conversion is the quantitative L57 deficit inequality $\theta\le\Theta_n-c_nd^2$ that the same paragraph calls for and does not have. Without a lower bound on $c_n$, nothing rules out $\theta\ge\sqrt{3/2}$ itself forcing $d=O(1/n)$, in which case the window never closes. Comparing $0.189$ against $1/(2(m-1))$ directly compares two quantities in different units. **The route is abandoned on a heuristic, and the heuristic is a good one, but it is not a proof and [plan.md](../plan.md) should not say "provably".** *Screened for size: the band width first exceeds the margin between $n=16$ ($0.05612$ against $0.07143$) and $n=18$ ($0.07102$ against $0.0625$), so even the heuristic gives the route only $n\lesssim16$ before any Lipschitz constant is charged.*

**"The granted maximiser is asymptotically a branch point", REFUTED as phrasing.** At every finite $n$ the balanced product is Morse–Bott nondegenerate ([Lemma L27](../findings/nondegeneracy.md)), and points at different $n$ live in different spaces, so no limiting object degenerates. What is true is that the Hessian's condition number on $W^\perp$ grows like $n$: the least-magnitude non-orbit eigenvalue is $6\theta/(2(m-1))=\Theta(\theta/n)$ while the bulk sits at $\Theta(\theta)$. **A nondegenerate point with a small margin is nondegenerate**, and worse, "branch point" is precisely the reading [Lemma L127](../findings/second-order.md)'s own box withdrew: "the obstruction proves no branch when it fails, rather than a branch when it vanishes". The sentence re-imports a withdrawn implication as an aside. Correct phrasing: *the second-order margin at the balanced product degrades like $1/n$ relative to the rest of the spectrum.*

---

## 4. The Gershgorin attempt, REFUTED, with the witness

**The sign question the brief asked, answered.** For a within-factor pair $\{j,k\}\subset F_1$, $M_{jk}=\alpha$, and $\alpha=-q\gamma/(p-1)$ with $\gamma<0$, so **$\alpha>0$**, confirmed twice over in §0, once from criticality and once from the Weyl sectional curvature of the product metric. The sign decides the claim.

**The recorded failure drops a term.** The sufficient condition is $\lVert M_i\rVert_1<\theta+M_{jk}$. At $S^m\times S^m$, with $\lvert\gamma\rvert=-\gamma$:

$$\lVert M_i\rVert_1=(m-1)\alpha+m\lvert\gamma\rvert=2m\lvert\gamma\rvert,\qquad \theta+M_{jk}=(2m-1)\lvert\gamma\rvert+\frac{m\lvert\gamma\rvert}{m-1}=\frac{2m^2-2m+1}{m-1}\lvert\gamma\rvert,$$

$$\frac{2m^2-2m+1}{m-1}-2m=\frac{1}{m-1}\;>\;0 .$$

**The condition holds, at every $m\ge2$, with slack $\lvert\gamma\rvert/(m-1)$.** [ATTEMPTS.md](../ATTEMPTS.md) compares $2m\lvert\gamma\rvert$ against $\theta=(2m-1)\lvert\gamma\rvert$ **alone** and reports a shortfall of one $\lvert\gamma\rvert$; the missing $M_{jk}=\alpha=m\lvert\gamma\rvert/(m-1)$ more than covers it. The sharp form is better still: Gershgorin sees the negative mass of a row of $N=M^{(jk)}$, not of $M$, and deleting columns $j,k$ removes two **positive** entries from each $F_1$ row and two **negative** entries from each $F_2$ row, giving $\lambda_{\min}\ge-2\max(q,p-2)\lvert\gamma\rvert$, which at $p=q=m$ is the same $2m\lvert\gamma\rvert$ and at $p=7,q=5$ turns a failure into a pass.

**The compensating sign error.** The hand-check three paragraphs later writes $\theta=(2m-1)\gamma$ together with $\alpha=-m\gamma/(m-1)$, which forces $\alpha<0$, the opposite of the truth, and inconsistent with $\theta>0$, since criticality gives $\theta=-(n-1)\gamma$. Its numbers follow: it reports $\lambda_{\min}=-7.6\gamma$ against $-(\theta+\alpha)=-9.8\gamma$ at $m=6$, where the correct values are $\lambda_{\min}=-2(m-1)\lvert\gamma\rvert=-10\lvert\gamma\rvert$ and $-(\theta+\alpha)=-12.2\lvert\gamma\rvert$. **The recorded margin survives** only because $\lambda_{\min}=-\alpha-\theta\frac{p-2}{p-1}$ and $-(\theta+\alpha)$ are both linear in $\alpha$ with the same coefficient, so the slack $\theta/(p-1)$ (and hence $1/(2(p-1))$ after dividing by $2\theta$), is independent of $\alpha$'s sign. The conclusion is right for a reason the derivation does not have.

**What is actually true about Gershgorin, stated positively.** The condition passes in every **orbit-free** block at the balanced product and necessarily fails in every cross-factor block, where equality genuinely holds along the orbit, no sufficient condition can succeed there, so the cross-factor failure is information about the instrument's scope, not its strength. It does fail at unbalanced products: at $p=5,q=7$, $n=12$, a pair inside the smaller factor gives $2\max(q,p-2)=14$ against $\theta+\alpha=12.75$. **So Gershgorin is still not a proof, but the recorded reason is wrong and the conclusion drawn from it, "the row-sum lever alone reproduces the same asymptotic thinness the perturbation route died of", does not follow from the balanced product.** The lever is thin ($\text{slack}/\theta\sim1/n^2$ there) but on the right side of zero, and the correct counterexample is the unbalanced product, which is the case odd $n$ hands the route anyway.

---

## 5. The Dirichlet restatement, CORRECTED

**The signed-weight identity is sound.** $x^\top\Delta x=\sum_i(\sum_lw_{il})x_i^2-\sum_{i,l}w_{il}x_ix_l=\tfrac12\sum_{i,l}w_{il}(x_i^2+x_l^2-2x_ix_l)$ uses symmetry of $w$ and nothing else. Positivity enters only in the *conclusion* $\Delta\succeq0$. So the record's framing, "the weights are signed, so $\Delta\succeq0$ is unavailable and the negative entries of $M$ carry the whole question", is exactly right, and the display is a valid rewriting.

**The eigenvector half is criticality alone, and I proved it by hand.** With $N=M^{(jk)}$, $(N\mathbf1)_i=-M_{ij}-M_{ik}$ by the zero row sums, and $o_i=M_{ki}-M_{ji}$:

$$\sum_{l\notin\{j,k\}}M_{il}o_l=\big[(M^2)_{ik}-M_{ij}M_{jk}\big]-\big[(M^2)_{ij}-M_{ik}M_{jk}\big] =o_i\big(\theta+M_{jk}\big)-o_i\big(M_{ij}+M_{ik}\big),$$

the last step substituting $(M^2)_{ik}=\theta M_{ik}-M_{ik}^2$ and $(M^2)_{ij}=\theta M_{ij}-M_{ij}^2$. Hence

$$\big(\Delta^{(jk)}o\big)_i=-(M_{ij}+M_{ik})o_i-\sum_lN_{il}o_l=-\big(\theta+M_{jk}\big)o_i .$$

**Only diagonal criticality and zero row sums are used; maximality never appears.** The same two facts give $\sum_io_i=-M_{jk}+M_{jk}=0$, so $o$ lies in the Ricci cut automatically. So the word "forced" is **correct** for the eigenvector and its eigenvalue, and equivalently for $L_eo^{jk}=\tfrac12o^{jk}$, which the invariance argument also gives, by differentiating $Q(W_t)=\theta W_t$ along the orbit, again at any critical point.

**The inequality half needs maximality, and the phrasing hides it.** The display asserts

$$\tfrac12\sum_{i,l}M_{il}(x_i-x_l)^2>-(\theta+M_{jk})\lVert x\rVert^2\quad\text{"strictly, except along the orbit vector where equality is forced"},$$

which presumes $\ge$ holds so that the orbit is an equality *case*. But $\ge$ is $\lambda_{\min}(\Delta^{(jk)}|_{\mathbf1^\perp})\ge-(\theta+M_{jk})$, which is [Lemma L122](../findings/second-order.md)'s consequence, which is [Lemma L24](../findings/second-order.md) applied to the block, and **L24 is second-order optimality, it needs maximality.** The record knows this and says so three paragraphs later; the display does not carry it.

**And the consequence is sharper than a missing hypothesis.** At a non-maximal critical point $L_e$ can exceed $\tfrac12$ on a block, $S^2\times S^4$ does it in a four-set block at $\tfrac23$, which is the record's own witness for the same distinction in [Lemma L128](../findings/second-order.md)(ii). Where that happens in a pair block, $\Delta^{(jk)}$ has an eigenvalue **below** $-(\theta+M_{jk})$ and the orbit vector is **not** the minimiser of the Rayleigh quotient at all. So [Lemma L122](../findings/second-order.md)'s "the lemma's content is that the orbit direction minimises the Rayleigh quotient on $\mathbf1^\perp$" is a maximiser statement, and the restatement's "strictly, except along the orbit" is, at a general critical point, **two open claims wearing one sentence**: that the orbit is a minimiser, and that it is the only one. Only the second is I18's target; the first is currently unproved and is the harder of the two.

**Positive restatement of what I18's pair clause actually is.** *At a pure critical point with $\theta\ge\sqrt{3/2}$ and $n\ge12$, in every orbit-free pair block, $-(\theta+M_{jk})$ is not an eigenvalue of $\Delta^{(jk)}|_{\mathbf1^\perp}$.* That is a non-membership statement about one point of the spectrum, [Lemma L128](../findings/second-order.md)(ii)'s $\ne$ form, and it neither asserts nor needs the orbit to be extremal. The record's own repair to L128(ii) applies verbatim here and has not been carried across.

---

## Hypotheses used silently, collected

| where | hypothesis | status |
|---|---|---|
| [Corollary L128.1](../findings/second-order.md), $\mathcal D_n$ leg | $p,q\ge3$, inherited from [Lemma L27](../findings/nondegeneracy.md) | **unstated**; false-by-record at $p=2$, harmless once the $\sqrt{3/2}$ threshold is written in ($\min(p,q)\ge5$) |
| [Corollary L128.1](../findings/second-order.md), $\mathcal D_n$ leg | that $+\mu$ does not meet $\mathcal D_n$ | unstated; true for $p,q\ge3$ at $n\ge12$, needed at $p=2$ where $\mu>\tfrac12$ |
| [Lemma L127](../findings/second-order.md), within-factor row | $p\ge3$ for the quoted top to be in the spectrum | unstated; the bound survives at $p=2$, the spectrum does not |
| [Lemma L57](../findings/problem.md), step 1 | $\mu\ne0$ (for $\sum v_i=0$) and $\mu>0$ (to divide) | unstated; both hold at $\mu_{\max}$ |
| the band | L57's full proof, whose $n=12,14$ leg [findings/INDEX.md](../findings/INDEX.md) records as living outside [findings/](../findings/) with Gate 2 status unrecorded | named dependency, not a defect |
| the perturbation route | a quantitative L57 with $c_n$ bounded below in $n$ | **does not exist**; it is what makes "provably not enough" not provable |
| the Dirichlet restatement | maximality, for $\lambda_{\min}\ge-(\theta+M_{jk})$ | **unstated in the display**, stated three paragraphs later |
| [ATTEMPTS.md](../ATTEMPTS.md) hand-check at $S^m\times S^m$ | $\gamma>0$, hence $\alpha<0$ | **wrong**; $\gamma<0$, $\alpha>0$. Margin survives by an accident of linearity |

## What a successor must clear

1. **Restate [Corollary L128.1](../findings/second-order.md) with the threshold in it.** "Every $S^p\times S^q$ at $n\ge12$ with $\theta\ge\sqrt{3/2}$" is provable as it stands and has $\min(p,q)\ge5$ for free; "every $S^p\times S^q$ at $n\ge12$" is not, and the gap is a named object, $S^2\times S^{n-2}$, whose nondegeneracy is **exactly** the diagonal second-order condition on $\mathcal D_n$ and nothing else.
2. **Delete the recorded Gershgorin failure and record the pass.** The instrument clears the balanced product's orbit-free blocks at every $m$; its real counterexample is the unbalanced product, and that is the case odd $n$ forces on the route anyway.
3. **Merge the $\mathcal D_n$ clause into the pair clause in the margin bookkeeping.** They carry the same $\lambda_p=(p-2)/(2(p-1))$, so I18(d) is not a third independent obstruction at the sphere products, it is the same one.
4. **Write I18's pair clause as non-membership, not as strictness.** The $\ne$ repair [Lemma L128](../findings/second-order.md)(ii) already took has not reached the Dirichlet restatement, which still asks for a strict inequality whose non-strict form is itself unavailable off a maximiser.

**Nothing here needed a run, and no line of numerical work was opened.** The two bracketed screens are arithmetic evaluations of closed forms derived above and are reported as screens.
