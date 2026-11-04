# Verification v206, Lemma L13, the spectral-moment ceiling

*Verifier v206 of the verification loop, cold on [BRIEF_L13.md](BRIEF_L13.md). **No numerical work was done**: no script, no Sage, no Python, no numeric evaluation. Every figure below is exact rational arithmetic or a square-root bracket done by hand on an object constructed for the purpose, and every such bracket is reported as a screen. Log: [agent_logs/verify-L13-v206.log](../agent_logs/verify-L13-v206.log).*

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | Section A, [results.md:577-579](../results.md), the canonical entry | **STATES NO RESULT** |
| 2 | The ceiling $\theta\le2-o(1)$, derived at every $n$ from criticality | **PROVEN at even $n$, hypotheses corrected**; the Peirce cap is not used, and is not usable |
| 3 | $\kappa_n=(n-1)(2n-1)/4$ | **PROVEN at $n=4$ and even $n\ge6$; A FIT at odd $n$** |
| 4 | The margin $58.9\times$ at $n=12$ | **ARITHMETICALLY CORRECT, AND IT MEASURES THE WRONG BOUND** |
| 5 | *"reaching $58.9$ needs $k_0\ge74>66$"* | **FALSE, a mis-transcription of a clause about $49.7$** |
| 6 | *"$49.7$ is out of range"* ([L13.lean](../lean/HamiltonsCubic/Results/L13.lean)) | **BROKEN, the argument would refute the conjectured true value too** |
| 7 | The asymptotic margin $3.09\times$ | **CONFIRMED** |
| 8 | *"attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$"* | **REFUTED, and the refutation is right** |
| 9 | *"only 'at least' is used downstream"* | **CONFIRMED** |
| 10 | Section B, *"the wrong invariant for this problem"* | **OVER-CLAIM, section C's annotation is right, with one qualification** |
| 11 | *"a hard ceiling that no refinement of it escapes"* | **FALSE AS WRITTEN; true under ATTEMPTS' own narrower wording** |
| 12 | *"the fourth moment reaches only $14\times$ even granting an oracle"* | **OBSERVATION at $n=12$, arithmetic confirmed** |
| 13 | Section C's three-way split | **RIGHT IN OUTLINE, WRONG IN ONE PIECE** |
| 14 | Symbols $B$, $u$, $\lambda$, $k_0$ | **$B$ and $u$ are load-bearing collisions; the annotation undercounts $B$** |
| 15 | Range boundaries: smallest $n$, odd $n$, $n=6+2\sqrt7$ | **THE CROSSOVER IS UNSTATED AND IT IS WHY THE TABLE STARTS AT $n=12$** |

**Verdict: `GAP`.** The surviving core ($\theta^2(1+k_0/4)\le\kappa_n$ at every critical point, and the ceiling $\theta<2$ that follows), is correct, and I rebuilt it in full below. But it has **no proof in a file the record permits one in**: the canonical entry is empty, the block is byte-identical to its own statement, and the derivation sits in [ATTEMPTS.md](../ATTEMPTS.md), which the record bars. On top of that the block carries one false sentence introduced by its own correction (claim 5), one over-claim it inherits from the landscape line (claim 11), and a margin that measures a weaker bound than the one the record used to print (claim 4).

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- $\theta$, *"$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$"*.
- $\theta_0(n)$, *"**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** It is the value at the balanced sphere product **at even $n$ only**"*.
- $\Theta_n$, *"the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$"*.
- $M(n)$, *"**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$"*.
- $\dim\mathcal W_n$ (*"$\frac{n(n-3)(n+1)(n+2)}{12}$), $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$"*.
- $N$, *"$\binom n2=\dim\Lambda^2\mathbb R^n$"*.
- $T$, third sense, *"**the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined at all"*.
- the Killing constant, *"**The algebra's Killing constant** is $\kappa_n=(2n-1)(n-1)/4$. It has appeared under two symbols inside one file."*
- $B$, third sense, *"$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point … This is a third object under the letter $B$ in this record"*.
- Morse–Bott nondegeneracy, *"Via [L24](../findings/second-order.md)'s $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ that kernel is the eigenspace **at** $\tfrac12$"*.

And from [second-order.md](../findings/second-order.md), the criterion the block calls the Peirce cap:

> *"At a critical point $Q(W)=\theta W$ with $\theta>0$, put $e=W/\theta$ … $\text{$W$ a maximizer}\Longrightarrow\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$."*

with its scope, stated in the same file: *"**The hypothesis that cannot be weakened is *maximiser* rather than *critical point*, and the witness is closed-form**"*, the $S^2\times S^2$ splitting in $\mathcal W_4$.

## The hypothesis inventory

Every hypothesis the block's chain uses, and where the block states it.

| # | hypothesis | used at | stated in the block? |
| --- | --- | --- | --- |
| H1 | $W$ is a critical point of $P$ on the unit sphere: $Q(W)=\theta W$ | the eigenvalue $\theta$ on $\langle W\rangle$, and the orbit eigenvalue $\theta/2$ | yes, *"from criticality alone"* |
| H2 | $\lVert W\rVert=1$ | the step from $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$ to $\lambda^2(1+k_0/4)\le\kappa_n$ | **no**, the block writes the $\lVert W\rVert^2$ in the identity and drops it in the conclusion |
| H3 | $L_W$ is self-adjoint, so its spectrum is real and $\mathop{\mathrm{tr}}(L_W^2)=\sum_i\mu_i^2$ | the whole compression argument, which is a sum of squares | **no**, it is [conventions.md](../findings/conventions.md)'s $T$, third sense |
| H4 | $O(n)$-equivariance of $Q$, differentiated along the orbit | $L_Wo=\tfrac\theta2 o$ for every orbit tangent $o$ | **no**, the block names the *Peirce cap* instead, which is a different statement |
| H5 | orbit tangents are orthogonal to $W$ | so that $\langle W\rangle$ and the orbit space contribute disjointly to $\mathop{\mathrm{tr}}(L_W^2)$ | **no**, true because $O(n)$ acts by isometries |
| H6 | $k_0=\dim(O(n)\cdot W)\le\binom n2$ | the ceiling | yes |
| H7 | Fox's Theorem 1.3: $\mathop{\mathrm{tr}}(L_XL_Y)=\kappa_n\langle X,Y\rangle$ on $\mathcal W_n$ | the constant $\kappa_n$ | the value is quoted; the theorem, its source and its hypothesis (irreducibility under isometric automorphisms, $O(n)$ and not $SO(n)$) are not |
| H8 | $n>6+2\sqrt7$ | the *excess* figure, whose denominator $\theta_0(n)-\sqrt{3/2}$ is $\le0$ below that | **no**, see §7 |
| H9 | $n$ even | $\kappa_n$ is a theorem only there; and $\theta_0(n)=\Theta_n$ only there | **no**, see §4 |
| H10 | $W$ is a **local maximum** | the Peirce cap, if it were used | **no**, and the block says the opposite: *"from criticality alone"* |

**H10 is stated-and-never-used and H4 is used-and-never-stated, and they are the same slot.** The block names the Peirce cap as an ingredient. The cap is false at a mere critical point, [second-order.md](../findings/second-order.md)'s $S^2\times S^2$ witness in $\mathcal W_4$ has an exact $1$-eigenvector of $L_e$ inside $W^\perp$, so under the block's own *"from criticality alone"* the ingredient it names is unavailable. What the chain actually consumes is H4, the *attainment* on the orbit, which holds at every critical point and which the block never states as such.

**And the direction is wrong as well as the hypothesis.** A cap is an upper bound on the eigenvalues off $\langle W\rangle$. Nothing follows from an upper bound about $\mathop{\mathrm{tr}}(L_W^2)$ being **large**, which is the inequality's whole content. Only attainment ($k_0$ eigenvalues *equal to* $\theta/2$), lower-bounds the second moment. So the block credits its result to an ingredient that is unavailable under its stated hypothesis and that could not deliver the conclusion if it were available.

## 1. Section A states no result, and what the canonical statement would have to be

[results.md:577-579](../results.md) is a heading and a proof pointer with nothing between them:

```markdown
##### Lemma L13, spectral-moment method

**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)
```

Nine lines below it, in the same file, sits [L14](../results.md), withdrawn at Gate 2 on exactly this ground: *"**The heading promised a bound and the block displays no inequality**"*. L13's entry is the stronger case of the same defect, it displays neither an inequality nor a sentence.

**The statement the argument supports, and therefore the one that belongs there:**

> **Lemma L13.** Let $W\in\mathcal W_n$ be a critical point of $P$ on the unit sphere, $Q(W)=\theta W$, and let $k_0=\dim(O(n)\cdot W)$ be its orbit dimension. Then
> $$\theta^2\Big(1+\frac{k_0}{4}\Big)\ \le\ \kappa_n=\frac{(n-1)(2n-1)}{4}.$$
> Since $k_0\le\binom n2$, the strongest bound this chain can yield at any critical point is
> $$\theta^2\ \le\ \frac{\kappa_n}{1+\tfrac18n(n-1)}=\frac{2(n-1)(2n-1)}{n^2-n+8}\ <\ 4,$$
> the right side increasing to $4$. So the chain cannot bound $\theta$ below $2$ at any $n$, against a conjectured $\Theta_n<\sqrt2$.

That is a genuine lemma, it is what the block's own display asserts once $\lambda$ is read as $\theta$, and it is what §2 below proves. The words *"spectral-moment method"* name a method, not a result, and no reader of [results.md](../results.md) can recover the inequality from them.

## 2. The ceiling, derived, and the Peirce cap is not used

Write $X\circ Y=\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)$ and $L_W=W\circ(\cdot)$, which is the block's $H\mapsto B(W,H)$. By [conventions.md](../findings/conventions.md)'s $T$, third sense, $\langle X\circ Y,Z\rangle$ is fully symmetric, so $L_W$ is **self-adjoint** on $\mathcal W_n$ and its spectrum is real (H3).

**Step 1, the radial eigenvalue.** $Q$ is quadratic, so $W\circ W=Q(W)$. At a critical point of unit norm, $L_WW=Q(W)=\theta W$. So $\theta\in\mathop{\mathrm{spec}}(L_W)$ with eigenvector $W$.

**Step 2, the orbit eigenvalue, from equivariance and nothing else.** $Q$ is $O(n)$-equivariant: $Q(g\cdot X)=g\cdot Q(X)$. Differentiate at $g=\mathrm{id}$ along $A\in\mathfrak{so}(n)$, writing $o_A=A\cdot W$ for the induced action on $\mathcal W_n$:
$$DQ_W(o_A)=A\cdot Q(W)=\theta\,o_A .$$
And $DQ_W(H)=2\,W\circ H=2L_WH$ by the polarisation. Hence
$$L_W\,o_A=\tfrac\theta2\,o_A\qquad\text{for every }A\in\mathfrak{so}(n).$$
**This is an equality, it holds at every critical point, and it uses no second-order information.** It is [second-order.md](../findings/second-order.md)'s own statement, *"Differentiating the equivariance $Q(gW)=gQ(W)$ along a one-parameter subgroup shows the orbit tangent lies in the $\tfrac12$-eigenspace at every critical point"*, and it is H4.

**Step 3, orthogonality.** $O(n)$ acts by isometries, so $\langle o_A,W\rangle=\tfrac{d}{dt}\big|_0\tfrac12\lVert e^{tA}\cdot W\rVert^2=0$. The span of $\{o_A\}$ has dimension $k_0$ by definition of the orbit, and meets $\langle W\rangle$ only in $0$.

**Step 4, compression.** $L_W$ is self-adjoint, so $\mathop{\mathrm{tr}}(L_W^2)=\sum_i\mu_i^2$ over its real spectrum, and restricting to any orthogonal set of eigenvectors gives a lower bound. Steps 1–3 supply $1+k_0$ of them:
$$\mathop{\mathrm{tr}}(L_W^2)\ \ge\ \theta^2+k_0\cdot\Big(\frac\theta2\Big)^2=\theta^2\Big(1+\frac{k_0}{4}\Big).$$

**Step 5, the constant.** $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2=\kappa_n$ at unit norm (H2, H7). Combining,
$$\boxed{\ \theta^2\Big(1+\frac{k_0}{4}\Big)\le\kappa_n=\frac{(n-1)(2n-1)}{4}\ }$$

which is the block's display with $\lambda$ read as $\theta$. **The Peirce cap appears nowhere in Steps 1–5.** Confirmed: the block's *"a Peirce cap at $\lambda/2$ on $u^\perp$ attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$"* is two claims glued, a cap, which is unused and unavailable, and an attainment, which is Step 2 and is the whole engine.

**Step 6, the ceiling.** $k_0\le\dim\mathfrak{so}(n)=\binom n2=\tfrac12n(n-1)$, so $1+k_0/4\le1+\tfrac18n(n-1)=\tfrac{n^2-n+8}{8}$ and
$$\theta^2\ \le\ \frac{(n-1)(2n-1)/4}{(n^2-n+8)/8}=\frac{2(n-1)(2n-1)}{n^2-n+8}=\frac{4n^2-6n+2}{n^2-n+8}.$$
Subtract $4$: the numerator becomes $(4n^2-6n+2)-4(n^2-n+8)=-2n-30<0$ for every $n\ge4$. So **the bound is strictly below $4$ at every $n$ and increases to $4$**, giving $\theta\le2-o(1)$ exactly as claimed, with the $o(1)$ approaching from below. At $n=12$: $\kappa_{12}=\tfrac{11\cdot23}{4}=\tfrac{253}{4}$, $\binom{12}2=66$, $1+\tfrac{66}4=\tfrac{35}2$, and
$$\theta^2\le\frac{253/4}{35/2}=\frac{253}{70},$$
reproducing the annotation's number exactly.

**Verdict on claim 2: the derivation is correct**, the block's *"from criticality alone"* is correct **of the inequality**, and the block's ingredient list is wrong in the two ways §the-inventory records. This is `PROVEN, hypotheses corrected`, conditional on $\kappa_n$, which is §4.

**Where the slack is, stated because the block does not.** Steps 1–3 account for $1+k_0$ of the $\dim\mathcal W_n$ eigenvalues, at $n=12$, at most $67$ of $1638$. Everything else is thrown away as $\ge0$. That, and not any property of $\theta$, is why the ceiling sits at $2$.

## 3. $\kappa_n=(n-1)(2n-1)/4$, proven at even $n$, a fit at odd $n$, and the annotation's repair is the circular one

**What exists.** [algebra.md](../findings/algebra.md) boxes $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ and states its provenance plainly: *"**This is a number Fox does not have: his Remark 1.4 explicitly leaves $\kappa$ uncomputed for $\dim V>4$.** It is anchored at the one dimension he does compute: at $n=4$ the formula gives $21/16$, matching his Theorem 1.5(2)."* The evidence offered there is *"$\mathop{\mathrm{tr}}(F_W^2)=\kappa_F(n)$ holds at roughly 90 points across $n=4\ldots14,16$ … with maximum deviation $4\times10^{-13}$"*, verification, not proof.

**What Fox's theorem does give, and it is enough for the existence.** *"$\mathop{\mathrm{tr}}L(x)=0$ and $\mathop{\mathrm{tr}}(L(x)L(y))=\kappa_F\langle x,y\rangle$"*, the constant *exists* because $\mathop{\mathrm{tr}}(L_xL_y)$ is an invariant symmetric bilinear form on an irreducible module, which is [second-order.md](../findings/second-order.md)'s own one-line reason. That step is fine at every $n$. What is at issue is only the **value**.

**The even-$n$ derivation, and I checked it.** [nondegeneracy.md](../findings/nondegeneracy.md)'s [Lemma L28](../findings/nondegeneracy.md) gives, at $W_{\mathbb{CP}^m}\in\mathcal W_{2m}$ for $m\ge3$, seven $L_e$-eigenvalues with multiplicities, and $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$. Summing the squares off that table, with $\lambda=1$ on the line, $\frac{m+2}{2(m+1)}$ on the $\mathfrak{su}(m)$ adjoint of dimension $m^2-1$, $\tfrac12$ on the $m(m-1)$-dimensional orbit, $\frac2{m+1}$ on the $\frac{m^2(m+1)(m-3)}4$-dimensional piece, $0$ on two pieces, and $-\frac3{m+1}$ on the $\frac{m^2(m^2-1)}6$-dimensional piece:

$$\mathop{\mathrm{tr}}(L_e^2)=1+\frac{(m-1)(m+2)^2}{4(m+1)}+\frac{m(m-1)}4+\frac{m^2(m-3)}{m+1}+\frac{3m^2(m-1)}{2(m+1)}=\frac{12m^3-15m^2+3m}{4(m+1)}=\frac{3m(m-1)(4m-1)}{4(m+1)},$$

the numerator factoring as $3m(4m-1)(m-1)$. Against $\lVert e\rVert^2=1/\theta^2=\frac{3m(m-1)}{(m+1)(2m-1)}$ this reads
$$\mathop{\mathrm{tr}}(L_e^2)=\frac{(4m-1)(2m-1)}{4}\cdot\lVert e\rVert^2=\kappa_F(2m)\,\lVert e\rVert^2 .$$
**So the value is derived at $n=2m$ for every $m\ge3$**, i.e. at every even $n\ge6$, and $n=4$ is anchored by Fox's own Theorem 1.5(2) and independently by [L25](../findings/second-order.md)'s $W_{\mathbb{CP}^2}$ spectrum $\{1,\tfrac12^{(2)},0^{(5)},(-1)^{(2)}\}$, which gives $\mathop{\mathrm{tr}}L_e^2=\tfrac72=\tfrac{21/4}{3/2}$. **At odd $n$ there is no such point and no such derivation**, [nondegeneracy.md](../findings/nondegeneracy.md) says so itself: *"the closed form is a fit, so the second identity **derives** $\kappa_F$ at even $n$ rather than testing the table against it."*

**Verdict on claim 3.** Proven at $n=4$ and at even $n\ge6$; a fit at odd $n$, supported by exact-arithmetic verification at $n=5,7,9,11,13$ and nothing more. Section C's annotation says *"proven at even $n\ge6$ only"* and is right, missing only the separate $n=4$ anchor.

**Where this bites, and it is not where the annotation says.** The annotation writes *"and remains a fit at odd $n$, which the $n\ge12$ range contains"*. The margin table is at $n=12,14,20,100$, all even, so no printed number depends on the fit. What depends on it is the **ceiling as a statement at every $n$**: $\theta\le2-o(1)$ *"derived at every $n$"* inherits Observation status at every odd $n$, and so does the asymptotic $3.09\times$, which is a limit taken along all $n$.

**The annotation's proposed repair is the one the record has already ruled circular.** It says *"closing it is one analytic lemma, $\kappa_n\dim\mathcal W_n=\lVert T\rVert^2$ for the symmetric trilinear form, one contraction and no run."* [second-order.md](../findings/second-order.md) answers that in its own words:

> *"**It is a corollary of the second identity, not an independent route**: summing $\mathop{\mathrm{tr}}(L_{B_i}L_{B_i})=\kappa_W\langle B_i,B_i\rangle$ over an orthonormal basis gives $\|T\|^2=\kappa_WD$ directly … So it restates the constant rather than proving it … **A proof still requires evaluating $\|T\|^2$ directly** as a contraction of the $\mathfrak{so}(n)$ structure constants against the Weyl projector."*

I screened the three exact values that paragraph offers against [conventions.md](../findings/conventions.md)'s $\dim\mathcal W_n$: $D=35,84,168$ at $n=5,6,7$ and $\kappa_n=9,\tfrac{55}4,\tfrac{39}2$, giving $\lVert T\rVert^2=315$, $1155$, $3276$, the recorded triple, exactly. So the identity is true and it is circular, precisely as recorded. **The debt is the contraction, not the identity**, and the annotation names the identity.

## 4. The margin at $n=12$, what $58.9$ is a ratio of, and why it measures the wrong bound

**The reading.** From [problem.md](../findings/problem.md), which turns on the same number without naming L13: *"**That width is $\theta_0(12)-\sqrt{3/2}$, between $0.0112$ and $0.0113$**, and it is the denominator [Lemma L13](../findings/curvature-invariants.md) divides by for its excess figure, so the two blocks turn on one number."* So

$$\text{excess}(n)=\frac{\text{bound}(n)-\theta_0(n)}{\theta_0(n)-\sqrt{3/2}} .$$

**What it is a ratio of, stated plainly since neither the block nor the annotation says it.** The numerator is how far the method's output sits **above the conjectured extremal value** $\theta_0(n)$. The denominator is the **width of the window Conjecture A must resolve**, the gap between $\theta_0(n)$ and the padded-$\mathbb{CP}^2$ competitor $\sqrt{3/2}=M(4)$, which by [conventions.md](../findings/conventions.md) is a lower bound on $M(n)$ at every $n$. So the excess is *overshoot measured in units of the decision it has to make*, and $58.9$ says the method is off by fifty-nine times the width it would have to resolve. That is the right functional to quote, and it is the only one under which $3.09$ and $58.9$ come from one formula.

**The arithmetic, screened by hand in exact form.** With $a=\sqrt{253/70}$, $b=\theta_0(12)=\sqrt{55}/6$, $c=\sqrt{3/2}=\sqrt6/2$:

- $a$: $1.90112^2=3.61425725<\tfrac{253}{70}=3.6142857\ldots<3.61429550=1.90113^2$, so $a\in(1.90112,1.90113)$.
- $b$: $\sqrt{55}\in(7.4161984,7.4161986)$ since $7.4162^2=55.000022$; so $b\in(1.2360330,1.2360332)$.
- $c$: $1.224744^2<\tfrac32<1.224745^2$, so $c\in(1.224744,1.224745)$.
- $b-c\in(0.0112880,0.0112892)$ and $a-b\in(0.6650868,0.6650970)$.
- Hence $\dfrac{a-b}{b-c}\in\Big(\dfrac{0.6650868}{0.0112892},\dfrac{0.6650970}{0.0112880}\Big)\subset(58.91,58.93)$.

**So $58.9\times$ is correct to the digits printed**, and it is what the block's own inequality gives at the admissible maximum $k_0=66$. The asymptotic figure is the same formula with $\text{bound}\to2$ and $\theta_0\to\sqrt2$: $\frac{2-\sqrt2}{\sqrt2-\sqrt{3/2}}=\frac{0.5857864}{0.1894687}\in(3.091,3.092)$, matching the record's *"strictly between $3.09$ and $3.10$"*. Claim 7 **CONFIRMED**.

**But the number measures the level-2 ceiling, and the record used to print the level-3 margin.** [ATTEMPTS.md](../ATTEMPTS.md)'s Result 4 table reads

| $n$ | $\theta_0(n)$ | gap\* | best bound | excess / gap\* |
|---|---|---|---|---|
| 12 | 1.23603 | 0.01129 | 1.7974 | **49.7** |
| 14 | 1.26168 | 0.03694 | 1.8308 | 15.4 |
| 20 | 1.30767 | 0.08292 | 1.8856 | 7.0 |
| 100 | 1.39298 | 0.16824 | 1.9705 | 3.4 |
| $\infty$ | $\sqrt2$ | $\sqrt2-\sqrt{3/2}$ | $2$ | 3.09 |

I screened every finite row against the level-2 ceiling $\sqrt{2(n-1)(2n-1)/(n^2-n+8)}$ of §2:

| $n$ | table's *"best bound"* | level-2 ceiling | table below the ceiling? |
|---|---|---|---|
| 12 | $1.7974$ | $\sqrt{253/70}=1.90113$ | yes |
| 14 | $1.8308$ | $\sqrt{351/95}=1.9222$ | yes |
| 20 | $1.8856$ | $\sqrt{741/194}=1.9544$ | yes |
| 100 | $1.9705$ | $\sqrt{19701/4954}=1.99419$ | yes |
| $\infty$ | $2$ | $2$ | equal |

**Every finite row is strictly below the level-2 ceiling, and the infinite row sits exactly on it.** That is the signature of a strictly stronger bound whose advantage vanishes asymptotically, which is what [ATTEMPTS.md](../ATTEMPTS.md)'s own diagnosis predicts of level 3: *"Level 2 therefore spreads a fixed $O(n^2)$ budget over $O(n^4)$ eigenvalues … level 3 sees it only at $O(n)$ scale."* Section C's annotation identifies it correctly: *"The margins are **measured at $n=12,14,20,100$** by grid search on a level-3 bound this block never displays."*

**So $49.7$ and $58.9$ are not two readings of one bound; they are one reading of two bounds.** $49.7$ is the excess of the level-3 bound $1.7974$, $58.9$ the excess of the level-2 ceiling $1.90113$. The correction replaced a measured margin for the method's *best available* bound with the margin for its *weakest* one, and the record now states the larger number as though it were the method's shortfall.

**What the block should say, and does not.** The method's actual shortfall at $n=12$ is $49.7\times$; the ceiling no refinement of the *level-2 chain* escapes is $58.9\times$. Both are true, they answer different questions, and the block prints one figure with no level attached.

## 5. The sentence that is false: *"reaching $58.9$ needs $k_0\ge74>66$"*

**Located.** [curvature-invariants.md](../findings/curvature-invariants.md) line 72, final clause of the excess annotation:

> *"And $58.9$ is not a competing reading but an unreachable one: $\lambda^2(1+\tfrac{k_0}4)\le\tfrac{(n-1)(2n-1)}4$ with the admissible maximum $k_0=\binom{12}2=66$ gives $\lambda^2\le\tfrac{253}{70}$, and larger $k_0$ only lowers $\lambda$, so reaching $58.9$ needs $k_0\ge74>66=\dim\mathfrak{so}(12)$. **The figure is now $58.9\times$ throughout the record.**"*

**Exhibited concretely.** The sentence contradicts the two sentences before it and the one after it. Two clauses earlier the same annotation says *"Applied at $n=12$ that same formula gives strictly between $58$ and $59$"*; one clause later it says the figure **is** $58.9$. A number cannot be simultaneously what the formula gives, unreachable, and the record's figure.

The arithmetic settles which clause is wrong. §4 brackets the excess at the admissible maximum $k_0=66$ at $58.91<\text{excess}<58.93$. So $58.9$ is reached **at $k_0=66$ itself**, needing nothing above the cap. And $k_0=74$ does not produce $58.9$: $1+\tfrac{74}4=\tfrac{39}2$, $\lambda^2\le\tfrac{253/4}{39/2}=\tfrac{253}{78}$, $\lambda\le1.80100$, and $\frac{1.80100-1.23603}{0.011288}=50.05$, nowhere near $58.9$.

**The provenance.** [L13.lean](../lean/HamiltonsCubic/Results/L13.lean) carries the same sentence about a different number: *"And `49.7` is not merely a different reading; it is out of range … Reaching `49.7` needs `λ` smaller still, which needs `k₀ ≥ 74`"*, and its theorem `k0_required_exceeds_cap` is stated at $\lambda=1.7971$, which is $49.7$'s $\lambda$. [ATTEMPTS.md](../ATTEMPTS.md)'s own round note says the same: *"$49.7$ needs $k_0\ge74$ against the cap $\binom{12}2=66$."* **The findings block substituted $58.9$ for $49.7$ inside a clause whose whole content was about $49.7$**, the correcting round replaced the figure everywhere including where the figure was the thing being argued against.

**Arguing the opposite.** Could *"unreachable"* mean $58.9$ **exactly**, as opposed to $\ge58.9$? Under that reading the sentence is true and vacuous: $k_0=66$ gives $58.919\ldots$ and $k_0=67$ gives $\frac{\sqrt{253/71}-b}{b-c}=\frac{1.88769-1.23603}{0.011288}=57.7$, so no integer $k_0$ lands on $58.900$. But the $k_0$ that would be needed is between $66$ and $67$, not $\ge74$, so the figure in the sentence is wrong under that reading too. Could the annotation mean a different denominator? No, it names the block's inequality explicitly and derives $\tfrac{253}{70}$ from it, which is the level-2 chain. **The clause fails under every reading.** Claim 5 **FALSE**.

## 6. The refutation of *"49.7 is out of range"*, the argument would refute the conjecture as well

**Located.** [L13.lean](../lean/HamiltonsCubic/Results/L13.lean)'s docstring and `k0_required_exceeds_cap`, and by inheritance the *"no critical point produces it"* line in [ATTEMPTS.md](../ATTEMPTS.md)'s round note.

**Exhibited concretely.** The chain $\lambda^2(1+k_0/4)\le\kappa_n$ is an **inequality**, not a determination of $\lambda$ from $k_0$. It says: given $k_0$, no critical point exceeds $\sqrt{\kappa_n/(1+k_0/4)}$. It says nothing whatever against a *smaller* upper bound obtained by other means. So the inference

> $49.7$ corresponds to $\lambda\le1.7971$; that $\lambda$ would need $k_0\ge74$; $74>66$; therefore $49.7$ is out of range

reads the inequality backwards. Concretely, the same argument applied to the conjectured true value $\theta_0(12)=1.236033$ gives $\lambda^2=\tfrac{55}{36}$, hence $1+\tfrac{k_0}4\ge\tfrac{253/4}{55/36}=\tfrac{253\cdot 9}{55}=\tfrac{2277}{55}=41.4$, hence $k_0\ge161.6$, over twice $\dim\mathfrak{so}(12)$. **The argument therefore "proves" that no critical point attains Conjecture A's own value**, which is absurd. Any bound below the level-2 ceiling triggers the same false alarm, and a bound below the ceiling is exactly what a refinement of the method is *for*.

**Arguing the opposite.** Could $1.7974$ simply be an error in [ATTEMPTS.md](../ATTEMPTS.md)'s table? Three things say no. Its other rows show the same pattern (every finite row strictly under the level-2 ceiling, converging to it (§4)) which an arithmetic slip would not produce. Its $\infty$ row sits exactly on the level-2 limit, so the table knows what level 2 gives. And Result 5's oracle figure lands in the same family: the level-4 oracle bound $1.3951$ gives $\frac{1.3951-1.23603}{0.011288}=14.09$, the recorded $14\times$, under the identical denominator. **One coherent table, one denominator, two levels.**

**Verdict.** Claim 6 **BROKEN**. The correcting round was right that the block's $49.7$ sat inconsistently beside the block's $3.09$ (those are level-3 and level-2 figures in one sentence) and wrong about why. The repair the record needs is a level label on each figure, not the deletion of one of them.

## 7. The refuted clause, and what is consumed downstream

**The refutation is right.** *"attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$"* is contradicted twice inside the record. [second-order.md](../findings/second-order.md): *"The multiplicity can exceed the orbit dimension ($18$ against $9$ at $S^3\times S^3$, and $60$ against $21$ at $S^2\times S^3\times S^3$) but the inclusion itself is a theorem."* I screened both orbit dimensions against [conventions.md](../findings/conventions.md)'s convention that $S^p\times S^q$ sits at $n=p+q$:

- $S^3\times S^3$, $n=6$: $\dim\mathfrak{so}(6)-\dim\big(\mathfrak{so}(3)\oplus\mathfrak{so}(3)\big)=15-(3+3)=9$. ✓
- $S^2\times S^3\times S^3$, $n=8$: $\dim\mathfrak{so}(8)-\dim\big(\mathfrak{so}(2)\oplus\mathfrak{so}(3)\oplus\mathfrak{so}(3)\big)=28-(1+3+3)=21$. ✓

Two further screens land: the balanced $S^6\times S^6$ at $n=12$ has $66-(15+15)=36$, which is [ATTEMPTS.md](../ATTEMPTS.md)'s recorded $36$; and $\mathcal S^4(\alpha)$ with isotropy $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ has $\binom n2-4-\binom{n-4}2=4n-14$, its recorded value. So the dimensions the refutation rests on are the record's own and they are right.

**And the over-claim's provenance is legible.** [ATTEMPTS.md](../ATTEMPTS.md) states it as *"Verified numerically that the multiplicity at the cap equals the orbit dimension exactly at both known families for $n=8,10,12$"*, two families, generalised to *"exactly"* for all critical points, and refuted by a third family ($S^2\times S^3\times S^3$) and by $n=6$. That is the trap **a claim proven on a subfamily and used in general**, hit here in its purest form. Claim 8 **REFUTED, refutation upheld**.

**And it is genuinely harmless.** §2 Step 4 needs $\dim E(\theta/2)\ge k_0$ and nothing more: extra $\theta/2$-eigenvectors only make $\mathop{\mathrm{tr}}(L_W^2)$ larger, which strengthens the inequality in the direction already being used. The block's own conclusion would in fact improve if written with $\dim E(\theta/2)$ in place of $k_0$, at $S^3\times S^3$ it would read $1+\tfrac{18}4$ rather than $1+\tfrac94$. So *"Only 'at least' is used downstream"* is **CONFIRMED**, and I checked the only other consumer: [second-order.md](../findings/second-order.md)'s *"The multiplicity relation is $\mathop{\mathrm{mult}}(\tfrac12)\ge\dim\mathcal O$, an inequality rather than an identity"*, which is the corrected form and already carries the retraction of the identity reading. No consumer of the *"exactly"* form survives on the record.

## 8. Completeness, the moments do determine $\theta$, and what *"wrong invariant"* can still mean

**Section C's annotation is right on the mathematics.** At a local maximum, $L_W$ is self-adjoint with $L_WW=\theta W$ and, by [L24](../findings/second-order.md), every eigenvalue on $W^\perp$ is $\le\theta/2<\theta$ once $\theta>0$. So $\theta=\lambda_{\max}(L_W)$ **and it is simple**. The moment sequence $\mathop{\mathrm{tr}}(L_W^k)$, $k=1,\dots,\dim\mathcal W_n$, determines the characteristic polynomial by Newton's identities, hence the spectrum with multiplicities, hence $\lambda_{\max}$, hence $\theta$. **The moments are complete invariants for $\theta$ at a local maximum**, and section B's *"Proven to be the wrong invariant for this problem"* is over-claimed in exactly the way the annotation says.

**Two qualifications the annotation does not make, and they are what let the block's instinct survive.**

1. **The completeness needs local maximality, and so is unavailable at a general critical point.** Without it $\theta$ need not be $\lambda_{\max}$, [second-order.md](../findings/second-order.md)'s $S^2\times S^2$ witness in $\mathcal W_4$ has an exact $1$-eigenvector of $L_e$, i.e. a $\theta$-eigenvector of $L_W$, inside $W^\perp$. So on the class the method actually ranges over (critical points), the moments determine only the *spectrum*, and the identification of which eigenvalue is $\theta$ needs a separate argument.
2. **Completeness is about the moments as numbers; the method has only their universal closed forms.** [ATTEMPTS.md](../ATTEMPTS.md) records exactly three: $\mathop{\mathrm{tr}}(L_W)=0$, $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$, $\mathop{\mathrm{tr}}(L_W^3)=-\tfrac{5n-1}8s+\tfrac{n(n-5)}8t$, and that level 4 needs seven invariants of which the record spans five. Knowing all $\dim\mathcal W_n$ moments determines $\theta$; knowing three of them as functions of $\lVert W\rVert$, $\mathop{\mathrm{tr}}(W^3)$ and $\langle W^\#,W\rangle$ determines a bound and not much of one.

**So the surviving reading of *"the wrong invariant"* is a statement about truncation, not about the invariant class:**

> The **second moment carries no information beyond the norm**, since $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$ identically. The low-order truncations available in closed form are therefore too coarse to separate $\theta$ from the bulk of a $\dim\mathcal W_n$-dimensional spectrum.

That is a **Lemma** in its first sentence, one line from the trace identity, and a **Conjecture** in its second, since nothing on the record proves that no computable finite truncation reaches $\sqrt2$. The block's *"a proof about the method rather than about the bound"* is what a proof of that second sentence would be, and it is not on file.

**A corollary of the same identity the block does not draw**, and it strengthens its own case: [fence-posts.md](../findings/fence-posts.md) uses $\mathop{\mathrm{tr}}(L_u)=0$ to show that *"The Weyl algebra has no unit"*, *"A unit $u$ would satisfy $L_u=\mathrm{Id}$ and hence $\mathop{\mathrm{tr}}(L_u)=D=\dim\mathcal W_n>0$, contradicting the identity"*, which is what bars the sharpest extremal-idempotent theorems and is a real by-product of L13's first moment.

## 9. *"A hard ceiling that no refinement of it escapes"*

**Located.** [results.md:186](../results.md), the landscape line, and the block's *"the method's ceiling is $\lambda\le2-o(1)$"*.

**False as written.** [ATTEMPTS.md](../ATTEMPTS.md)'s own table gives $1.7974<1.90113$ at $n=12$ (a refinement of the method that escapes the ceiling the block prints) and its Result 5 gives $1.3951$ under a level-4 oracle, below $2$ outright. So *"no refinement escapes"* has two witnesses against it inside the same file the derivation lives in.

**True under the narrower wording the source actually uses.** [ATTEMPTS.md](../ATTEMPTS.md)'s Result 4 says *"the method's best conceivable bound is $\lambda\le2-o(1)$, against the true $\theta_0(n)\to\sqrt2$. **No choice of isotropy can push it below $2$.**"* That is a statement about varying $k_0$ inside the level-2 chain, and it is exactly what §2 Step 6 proves. **The landscape line dropped the qualifier and turned a theorem about one parameter into a claim about every refinement.** Claim 11: `HYPOTHESIS-DEBT`, the general form needs a lower bound on what *every* finite moment truncation can give, and the record's own confidence note rates the level-4 assessment *"Moderate … reported as a recommendation rather than a theorem."*

**Claim 12, the fourth moment.** *"the fourth moment reaches only $14\times$ even granting an oracle"*, screened: $\frac{1.3951-1.23603}{0.011288}=14.09$, so the figure is right under the section's own denominator, at $n=12$ only. It rests on *"pretending $\max_u\mathop{\mathrm{tr}}(L_u^4)$ is attained at $W^*$"*, and the record's honest figure is $30\times$. **Observation at $n=12$**, and it is *not* evidence for the ceiling, being below $2$, it is evidence against the unqualified form of claim 11.

## 10. The symbols, every occurrence read in the right sense, and where the block gets it wrong

The block's own footnote: *"Symbols this block leaves undefined: $B$, $u$, $\lambda$ and $k_0$. Its $B$ is a fourth sense of a letter [conventions.md](../findings/conventions.md) already flags as live, and its $\lambda$ is the record's $\theta$ while the record's $\lambda$ is a $\Lambda^2$ eigenvalue."*

**$B$, the block's is the polarisation, and *"fourth"* undercounts.** From [ATTEMPTS.md](../ATTEMPTS.md)'s setup, *"$B(X,Y)=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ the polarization of $Q$"*, which is [conventions.md](../findings/conventions.md)'s $X\circ Y$ under a different letter. Live senses already tabled: the Killing form $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$; [L47](../findings/problem.md)'s $B$; [L48](../findings/problem.md)'s partition scalar, of which conventions says *"a fourth or fifth object under that letter depending on how one counts"*; $B=\tfrac\theta2\mathrm{Id}-L_W$, of which conventions says *"This is a third object under the letter $B$ in this record"*; and [L121](../findings/second-order.md)'s opposite-pair sum $B=M_{ik}+M_{jl}$. **The block's is at least the sixth.**

**And one of those collisions is inside this block's own subject.** $B=\tfrac\theta2\mathrm{Id}-L_W$ is defined *at a critical point*, out of $L_W$, in the same calculus. A reader resolving *"$L_u\colon H\mapsto B(u,H)$"* against the tabled $B$ reads an operator where a bilinear map is meant, and gets $L_u$ defined circularly in terms of $L_u$. **This is the collision most likely to cost a reader an hour, and the block flags a different one.** The repair is to write $\circ$, which conventions already tables, and drop the letter entirely, the record's own rule being *"definitions and conventions are quoted, never restated"*.

**$u$, three live senses, and the wrong one changes the theorem.** The block means an arbitrary critical point. [conventions.md](../findings/conventions.md) tables two others: *"the orbit acceleration $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$"*, and, in the competitor's normalisation, *"$u=W_{\mathbb{CP}^2}$ padded to unit norm"*. Under the second reading $\dim(O(n)\cdot u)$ is a **fixed** number ($\binom n2-\binom{n-4}2-4$, which is $34$ at $n=12$) so *"$k_0\le\binom n2$"* would be replaced by $k_0=34$ and the ceiling would read $\theta\le\sqrt{253/38}=2.5803$ rather than $2$. **The load-bearing quantifier of the lemma disappears under a reading conventions itself licenses.**

**$\lambda$, the block's is $\theta$, and the cap is quoted in the wrong normalisation.** The block writes *"a Peirce cap at $\lambda/2$"*. The record's canonical cap is [L24](../findings/second-order.md)'s $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, in the $L_e=L_W/\theta$ normalisation. The two agree only after multiplying by $\theta$, and the block **never says it works with $L_W$ rather than $L_e$** while quoting a cap whose canonical form is a bare $\tfrac12$. A reader carrying $\tfrac12$ across gets $\theta^2(1+k_0/4)\le\kappa_n$ replaced by $\theta^2+\tfrac{k_0}4\le\kappa_n$, which is false dimensionally.

**$k_0$, undefined, recoverable, and one clause away.** It occurs first in the display, its meaning sitting unlabelled in the preceding clause as $\dim(O(n)\cdot u)$. [ATTEMPTS.md](../ATTEMPTS.md) names it; the block does not.

**And $W$ against $u$ inside one sentence.** *"$L_u\colon H\mapsto B(u,H)$ gives $\mathop{\mathrm{tr}}(L_W)=0$, $\mathop{\mathrm{tr}}(L_W^2)=\ldots$, and a Peirce cap at $\lambda/2$ on $u^\perp$"*, the reader must work out unaided that the two trace identities hold at **every** $W\in\mathcal W_n$ with no criticality, while the third clause holds only at a critical (indeed maximal) $u$. That distinction is the difference between an algebra identity and a variational one, and the letter change is the only signal of it.

## 11. The traps, each answered by name

**$\ker W\ne0$ and padded objects, does not fire, and here is why.** $L_W$ acts on $\mathcal W_n$, not on $\Lambda^2\mathbb R^n$, and $\mathop{\mathrm{tr}}(L_XL_Y)=\kappa_n\langle X,Y\rangle$ is bilinear in its arguments and holds at every $X,Y\in\mathcal W_n$, padded or not, degenerate or not. [conventions.md](../findings/conventions.md)'s $\ker W\ne0$ trap is attached to $S(W)$, the gradedness slack, which L13 never uses. What padding *does* change is $k_0$: padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$ has isotropy $\mathfrak{so}(8)\oplus\mathfrak{stab}_{\mathfrak{so}(4)}$, dimension $28+4=32$, so $k_0=34$ and the chain gives only $\theta\le\sqrt{253/38}=2.5803$. **The ceiling is unaffected because it uses the largest $k_0$, which is the sound direction for a negative result.**

**A universal claim with no witness, this one fires, and harmlessly.** $k_0=\binom n2$ needs a critical point with **trivial isotropy algebra**, and the record exhibits none: the balanced $S^6\times S^6$ at $n=12$ has $k_0=66-30=36$, $\mathcal S^4(\alpha)$ has $4n-14=34$, padded $\mathbb{CP}^2$ has $34$. Since the ceiling asserts the method's *weakness*, taking the most favourable unattained $k_0$ only strengthens the negative conclusion, so the missing witness costs nothing. **But it means $58.9\times$ is nobody's shortfall.** At the record's own conjectured maximiser, $k_0=36$ gives $\theta\le\sqrt{253/40}=2.5150$ and an excess of $\frac{2.5150-1.23603}{0.011288}=113.3\times$, about twice the printed figure. The block prints the best case and calls it the margin.

**The boundary of every stated range.**
- *Smallest admissible $n$.* $\mathcal W_n\ne0$ needs $n\ge4$, and the chain is not vacuous there: $\kappa_4=\tfrac{21}4$, $\binom42=6$, $\theta^2\le\tfrac{21/4}{5/2}=\tfrac{21}{10}$, $\theta\le1.4491$ against $M(4)=\sqrt{3/2}=1.2247$, an overshoot of $18\%$, the method's **best** performance at any dimension. The block never says the method degrades with $n$; its own ceiling formula says so, increasing monotonically to $2$.
- *The crossover $n=6+2\sqrt7$, and it is the unstated hypothesis H8.* The excess denominator $\theta_0(n)-\sqrt{3/2}$ is positive exactly when $2(n-1)(n-2)/n^2>3/2$, i.e. $4(n^2-3n+2)>3n^2$, i.e. $n^2-12n+8>0$, i.e. $n>6+2\sqrt7=11.2915\ldots$, so **the first admissible dimension is $n=12$, and that is why the table starts there.** At $n=11$, $\theta_0(11)^2=\tfrac{180}{121}<\tfrac32$ and the ratio is negative; at $n\le11$ the excess figure is not merely large, it is meaningless. Neither the block nor the annotation states this, and it is the sole reason for the range.
- *Odd $n$.* Two separate failures. First, $\kappa_n$ is a fit there (§3). Second, the excess divides by $\theta_0(n)-\sqrt{3/2}$, but at odd $n$ [conventions.md](../findings/conventions.md) is explicit that *"the target of Problem P is $\Theta_n$"* and $\Theta_n<\theta_0(n)$. The correct odd-$n$ denominator is $\Theta_n-\sqrt{3/2}$, which is smaller, so the true excess is **larger** than the formula would report. The odd crossover is its own number: $\Theta_n^2=\tfrac32$ gives $n^2-13n+18=0$, $n=\tfrac{13+\sqrt{97}}2=11.4244\ldots$, so the first odd dimension in range is $n=13$, where the two denominators are $\sqrt{120/77}-\sqrt{3/2}=0.02363$ and $\theta_0(13)-\sqrt{3/2}=0.02509$, a $6\%$ divergence in a figure quoted to three significant figures. **No printed number is affected, because every row of the table is even.**

**A hypothesis stated but never used, and a step using one never stated.** Both, in the same slot: H10 and H4 of the inventory. This is the block's central structural defect and §2 settles it.

**A claim proven on a subfamily and used in general.** §7: the *"exactly"* clause, verified at two families and three dimensions, asserted universally, refuted by a third family. And §3: the parity split, $\kappa_n$ derived at even $n$ and used at all $n$.

**An imported theorem whose hypotheses were never checked, the block imports two and cites neither.** Fox's Theorem 1.3 supplies $\kappa_n$'s existence; its hypothesis, per [algebra.md](../findings/algebra.md), is that *"the group acting irreducibly by isometric automorphisms is $O(n)$, not $SO(n)$"*, and [second-order.md](../findings/second-order.md) records that $\mathcal W_n$ is absolutely irreducible under $SO(n)$ only from $n=5$, *"with $n=4$ returning $2$ as a control"*, so at the anchor dimension the full $O(4)$ is needed, and it is available. Checked, and it holds. The Peirce cap is Krasnov–Tkachev Proposition 6.6, and here the record's standing trap is live: [fence-posts.md](../findings/fence-posts.md) records that *"Tkachev's characterisation of minimal algebras … assumes a **unital** Euclidean metrised algebra"* and that $\mathcal W_n$ has none, but it also records that Proposition 6.6 is among *"the parts of that literature not needing a unit … which is this project's Lemma L24"*. **So the trap does not fire on L13.** It cannot be seen not to fire from the block, which cites nothing: no [L24](../findings/second-order.md), no Fox, no Krasnov–Tkachev.

## 12. What pieces the block contains, and what each should be labelled

Under the record's literal rule, `Lemma` asserts a proof, `Observation` asserts numerical verification at the dimensions named, `Conjecture` a candidate, I reach a three-way split that differs from section C's in one piece.

| piece | statement | label I reach | section C's annotation |
| --- | --- | --- | --- |
| (a) | $\theta^2(1+k_0/4)\le\kappa_n$ at every critical point, and the consequent ceiling $\theta^2\le\frac{2(n-1)(2n-1)}{n^2-n+8}<4$ | **Lemma at even $n$; Observation at odd $n$**, the parity entering only through $\kappa_n$ | Lemma, unqualified |
| (b) | the margins $58.9\times$, $49.7\times$, $15.4$, $7.0$, $3.4$, $3.09\times$, $14\times$ | **Observation at $n=12,14,20,100$ and in the limit**, and the level-3 bound must be displayed before any of them is citable | *"measured … by grid search on a level-3 bound this block never displays"*, unlabelled |
| (c) | $\mathop{\mathrm{tr}}(L_W^2)$ is constant in $W$, so the second moment carries nothing beyond the norm | **Lemma**, one line from the trace identity | *"What is genuinely proven concerns the second moment alone"* |
| (d) | spectral moments of $L_u$ are the wrong invariants; no refinement escapes | **Conjecture** | *"is backwards"* |

**Where I differ from section C.** It makes $\kappa_n$ the third piece, *"an **Observation** at the dimensions named"*. I do not think $\kappa_n$ is a piece of L13 at all: it is [algebra.md](../findings/algebra.md)'s boxed $\kappa_F(n)$, an existing claim in another file with its own status, and by the record's own rule (*"A findings file that needs one of these cites this file; it does not restate it"*), L13 should **cite** it and inherit its parity qualification as a hypothesis, not relabel it. That leaves L13 with (a) as its lemma, (b) as an observation, (c) as a one-line corollary, and (d) as the conjecture the block writes as if it were the theorem.

**And the split does not repair the block, because none of the four is proven *in a file the record permits*.** [INDEX-results.md](../findings/INDEX-results.md) states the position: *"**The block carried no proof, it was byte-identical to its own statement**, the derivation sitting in [ATTEMPTS.md](../ATTEMPTS.md), which the record bars from holding one."* That is still true of the block as it stands. Section C's first annotation calls the transcription *"owed"*, and it is still owed. Section C's own description of the defect has meanwhile gone stale: it says *"[results.md](../results.md) carries this paragraph **verbatim** and then points back here, a circular pointer"*, and [results.md:577-579](../results.md) now carries nothing at all. **The circular pointer was closed by emptying one end of it**, which is why section A states no result.

## 13. What would falsify it, and what I did to look for it

**The object.** A critical point $W\in\mathcal W_n$, $Q(W)=\theta W$, $\lVert W\rVert=1$, with
$$\theta^2\Big(1+\frac{\dim(O(n)\cdot W)}{4}\Big)>\frac{(n-1)(2n-1)}{4}.$$
Any such $W$ refutes (a) outright. Given the derivation, it would have to break one of exactly three things: the trace identity $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n$, so an **odd** $n$ is where to look, since that is where the constant is a fit; the orbit eigenvalue $L_Wo=\tfrac\theta2o$, which would need $Q$ to fail equivariance; or self-adjointness of $L_W$, which would need $\langle X\circ Y,Z\rangle$ to fail total symmetry.

**A second, weaker falsifier, for the ceiling as the landscape states it.** A refinement of the moment method producing a bound below $\sqrt2$ at some $n\ge12$ would refute *"a hard ceiling that no refinement of it escapes"*. **I found the first half of one on the record**: [ATTEMPTS.md](../ATTEMPTS.md)'s level-4 oracle bound $1.3951$ at $n=12$ is already below $2$, and its level-3 bound $1.7974$ is already below the printed ceiling $1.90113$. Neither reaches $\sqrt2$, so (a) survives; both refute the unqualified wording of §9.

**What I did to look.** Analytically only, in keeping with the standing rule. I re-derived the chain from the definitions and checked each of its five steps against an independent statement of the same fact in [second-order.md](../findings/second-order.md); I checked $\kappa_n$'s even-$n$ derivation by summing [L28](../findings/nondegeneracy.md)'s seven-row table by hand and factoring the result, which reproduced the recorded closed form exactly; I screened the four orbit dimensions the record quotes ($9$, $21$, $36$, $4n-14$) against $\binom n2$ minus the isotropy, all four exact; I screened $\lVert T\rVert^2=\kappa_nD$ at $n=5,6,7$ against $315$, $1155$, $3276$, all three exact; and I bracketed the two margin figures and the crossover $n^2-12n+8=0$ by hand in exact form. **I ran no search for a falsifier and none is permitted**; a search over odd $n$ for a failure of $\kappa_n$ is the one computation that would settle the parity gap, and it is not the right instrument either, the right instrument is the contraction $\lVert T\rVert^2$ that [second-order.md](../findings/second-order.md) already names as the owed work.

## Verdict

**`GAP`.**

The mathematics of the surviving core is correct and I rebuilt it in full: $\theta^2(1+k_0/4)\le\kappa_n$ holds at every critical point from equivariance and the second trace identity alone, and it caps the method at $\theta<2$ at every $n$, rising to $2$. What is missing is everything around it.

- **No proof in an admissible file.** The canonical entry states no result; the block is its own statement; the derivation is in [ATTEMPTS.md](../ATTEMPTS.md), which the record bars. The transcription that section C called *"owed"* is still owed, and the circular pointer it describes was closed by emptying the [results.md](../results.md) end rather than by filling the [curvature-invariants.md](../findings/curvature-invariants.md) one.
- **One false sentence, introduced by the block's own correction.** *"reaching $58.9$ needs $k_0\ge74$"* is a mis-transcription of a clause about $49.7$; $58.9$ is reached at $k_0=66$, and $k_0=74$ gives $50.05$.
- **One broken argument, in Lean.** *"$49.7$ is out of range"* reads the chain's inequality as a determination; the same reasoning would rule out $\theta_0(12)$ itself, which needs $k_0\ge161.6$.
- **One margin measuring the wrong bound.** $58.9$ is the level-2 ceiling's excess; $49.7$ was the level-3 bound's, and both are correct arithmetic under one denominator. The record replaced the second with the first and labelled neither.
- **Hypothesis debt at odd $n$.** $\kappa_n$ is a theorem at $n=4$ and even $n\ge6$ and a fit elsewhere; the ceiling *"at every $n$"* and the asymptotic $3.09\times$ both inherit that. The repair section C proposes, $\kappa_n\dim\mathcal W_n=\lVert T\rVert^2$, is the identity [second-order.md](../findings/second-order.md) has already shown to be circular; the owed work is the contraction.
- **Two over-claims.** *"the wrong invariant for this problem"* survives only as a statement about the truncations available in closed form, the moment sequence is complete for $\theta$ at a local maximum. *"a hard ceiling that no refinement of it escapes"* survives only in [ATTEMPTS.md](../ATTEMPTS.md)'s narrower wording, *"No choice of isotropy can push it below $2$"*.
- **One clause refuted, and the refutation is right and harmless.** Only *"at least"* is consumed, in the direction that would strengthen the bound.

The one thing the block gets exactly right and does not say out loud is that it uses the **attainment** of the cap and never the cap, so *"from criticality alone"* is true of the inequality even though every hypothesis it lists for that inequality is either unavailable under criticality or unnecessary.
