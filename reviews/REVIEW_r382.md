# Review r382, Gate 2 on the joint estimate and its closed form

*2026-09-02. Adversarial review of the last three sections of [ATTEMPTS.md](../ATTEMPTS.md), "The rank-one split", "The joint estimate clears, and by a wide margin", "The joint estimate in closed form: the pair clause follows from one scalar inequality". The band count, the $2\times2$ closed form, and the exact spectrum of $\widetilde N$ at $S^m\times S^m$ were derived from the definitions before the author's text was opened; the order of work is in [agent_logs/gate2-joint-B.log](../agent_logs/gate2-joint-B.log). Analysis only: the one numerical run below is a screen of a claim already proved by hand, on objects constructed for that purpose, and is reported as a screen.*

## Verdicts

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | The maximisation is exactly $\lambda_{\max}\begin{psmallmatrix}a&k\\k&b\end{psmallmatrix}=\tfrac{a+b}2+\sqrt{(\tfrac{a-b}2)^2+k^2}$ | **CONFIRMED**, re-derived cold, same $a,b,k$ |
| 2 | $\lVert D\hat w\rVert^2\le(T-a)(T-b)$ is the clause's sufficient condition, side conditions $a<T$, $b<T$ | **CONFIRMED as an equivalence**, given the side conditions |
| 3 | The estimate's ingredients and arithmetic at $S^6\times S^6$, within-factor pair | **CONFIRMED exactly**, every one of $a=9.76g$, $b=2.4g$, $k^2=4.704g^2$, $10.3516g$, $3.5\%$ reproduced cold |
| 4 | **$\lVert D\hat w\rVert^2\le(T-a)(T-b)$ holds at an arbitrary pure critical point in the band** | **REFUTED.** False at **every** cross pair of **every** $S^p\times S^q$, with a closed-form witness; and false again, with both side conditions holding, at within-factor pairs of $S^5\times S^q$, $q\ge34$ |
| 5 | "At most one direction can violate the clause" | **CONFIRMED**, but **conditional on $b<T$**, which is unproved, see #7 |
| 6 | That claim depends on $\lambda_1$ being simple | **CORRECTED**, it does depend on it, and simplicity is **free in the band**, not a hypothesis |
| 7 | "One of the two side conditions is already general": $b<T$ | **CORRECTED, overstatement.** Checked at sphere products only. It is in fact a *consequence* of the clause ($b=\max_i\widetilde N_{ii}\le\lambda_{\max}\widetilde N$), so it cannot be falsified, and it is not proved either |
| 8 | Orbit-free: $u=v\Rightarrow$ the swap fixes $M$, $w_j=w_k$, $u\!\cdot\!\Pi w=(\lambda_1-M_{jk})w_0$, $N\Pi w=\lambda_1\Pi w-2w_0u$ | **CONFIRMED**, all four, with one **silently used hypothesis** supplied below |
| 9 | "The cross term … is negative-going" | **REFUTED as written**, the cross term is a positive cost the joint bound pays |
| 10 | Free improvement not taken: $k^2$ may be replaced by $\lVert D\hat w\rVert^2-(\hat w^\top D\hat w)^2$ | **NEW**, strictly sharper, costs nothing |
| 11 | Free lemma not on the record: the **sum** companion to [Lemma L68](../findings/diagonal-half.md), $4M_{jk}^2-2\theta M_{jk}-(s_j+s_k)\le0$ | **NEW**, it is exactly the lower bound on $\theta+M_{jk}$ the section says it lacks, and it is near-sharp at the balanced product |

---

## 1. Cold derivations, before the text was opened

**The band count, and it needs far less than the band.** If $k$ eigenvalues of $M$ are $\ge\theta$ then $k\theta^2\le\sum\lambda_i^2=\lVert M\rVert_F^2=2$, so $k\le2/\theta^2$. This is $<2$ already for $\theta>1$; at $\theta\ge\sqrt{3/2}$ it gives $k\le4/3$. **At most one eigenvalue $\ge\theta$, and its multiplicity is therefore $1$.** With the gap, which I re-derived as $M^2-\theta M=\operatorname{diag}(s)-M\!\circ\!M=L(M\!\circ\!M)\succeq0$, the weighted graph Laplacian of the Hadamard square, the identity [diagonal-half.md](../findings/diagonal-half.md) already carries, every eigenvalue is $\le0$ or $\ge\theta$, and $\operatorname{tr}M=0$ with $M\ne0$ forces $\lambda_1>0$. So $M=\lambda_1ww^\top-K$ with $K\succeq0$ and $\lambda_1$ **simple**, at every pure critical point in the band.

**The split, and the closed form is the sharper one.** Write $x=s\hat w+y$, $\hat w=\Pi w/\rho$, $\rho=\lVert\Pi w\rVert$, and extend $x$ by zero to $\tilde x\in\mathbb R^n$, so $\langle\tilde x,w\rangle=\rho s$. Then $\tilde x^\top M\tilde x\le\lambda_1\rho^2s^2+\lambda_2(1-\rho^2s^2)$ and $x^\top Dx=s^2\hat w^\top D\hat w+2s\,(D\hat w)\!\cdot\!y+y^\top Dy$, where $(D\hat w)\!\cdot\!y$ is a pairing against a vector **orthogonal to $\hat w$**. Hence

$$x^\top\widetilde Nx\ \le\ a\,s^2+b\,(1-s^2)+2q\lvert s\rvert\sqrt{1-s^2},\qquad a=\lambda_2+(\lambda_1-\lambda_2)\rho^2+\hat w^\top D\hat w,\quad b=\lambda_2+\mu^+,\quad q^2=\lVert D\hat w\rVert^2-(\hat w^\top D\hat w)^2,$$

whose maximum over $s$ is exactly $\lambda_{\max}\begin{psmallmatrix}a&q\\q&b\end{psmallmatrix}$. **The author's form is this with $\lambda_2\to0$ (legitimate, $\lambda_2\le0$ in the band) and $q\to\lVert D\hat w\rVert$ (lossy).** Claim #1 and claim #2 are confirmed; claim #10 is the free half a line the section left on the table.

**Exact data at $S^m\times S^m$, within-factor pair, $\gamma=-g$, $\alpha=mg/(m-1)$, $\theta=(2m-1)g$, $g^2=\frac{m-1}{m^2(2m-1)}$.** All by hand:

| quantity | value | at $m=6$ |
| --- | --- | --- |
| $\operatorname{spec}(M)$ | $\{2mg,\ 0,\ -\alpha^{(2m-2)}\}$ | $\{12g,0,-1.2g^{(10)}\}$ |
| $\lambda_1$, $\lambda_2$ | $2mg$ (simple), $0$ | $1.348400$, $0$ |
| $\rho^2=\lVert\Pi w\rVert^2$ | $(m-1)/m$ | $5/6$ |
| $\hat w^\top D\hat w$ | $-\alpha/(m-1)=-mg/(m-1)^2$ | $-0.24g$ |
| $\lVert D\hat w\rVert^2$ | $2mg^2(2m^2-4m+1)/(m-1)^3$ | $4.704g^2$ |
| $\mu^+=\max_i(u_i+v_i)$ | $2\alpha=2mg/(m-1)$ | $2.4g$ |
| $T=\theta+M_{jk}$ | $g(2m^2-2m+1)/(m-1)$ | $12.2g$ |
| **true $\lambda_{\max}(\widetilde N)$** | $\mathbf{2(m-1)g}$ | $10g=1.123667$ |

The $2\times2$ quotient on the equitable partition has **determinant identically zero**, which is why the truth is $2(m-1)g$ on the nose. Note also $\lambda_1\rho^2=2(m-1)g$ **equals** the true $\lambda_{\max}(\widetilde N)$ here, the rank-one term alone is already the answer, and everything the estimate adds is loss. Every number the author reports at $m=6$ reproduces: $a=9.76g$, $b=2.4g$, $k^2=4.704g^2$, bound $10.3516g$, ratio $1.0352$. **Claim #3 CONFIRMED.**

---

## 2. The decisive question: the boxed condition is REFUTED, and by the record's own objects

### 2a. The structural reason, general at every pure critical point

From [r378](REVIEW_r378.md)'s $Bu=M_{jk}(u+v)-u\!\circ\!v$ with $B=T\,\mathrm{Id}-\widetilde N$, and the same computation with $j\leftrightarrow k$ giving $Bv=M_{jk}(u+v)-u\!\circ\!v$, one gets $B(u-v)=0$, that is

$$\widetilde N\,o=T\,o,\qquad o=v-u,\qquad\textbf{at every pure critical point and every pair.}$$

So **whenever $o\ne0$, $T$ is an eigenvalue of $\widetilde N$**, hence $\lambda_{\max}(\widetilde N)\ge T$ and *the pair clause is an equality there*. The record states this for the trace–Frobenius bound (item (iv) of the previous Gate 2 round). **It applies verbatim to the joint estimate, and the section did not carry it forward.** An estimate that is strictly loose (and the joint estimate is strictly loose whenever $k\ne0$), can never certify an equality. **The joint estimate's domain is therefore confined to orbit-free pairs, and at a pure critical point with no transposition symmetry there are none.**

### 2b. The closed-form witness family

Take $S^p\times S^q$, a **cross** pair $j\in A$, $k\in B$. With $\gamma=-g$, $\alpha=-q\gamma/(p-1)$, $\beta=-p\gamma/(q-1)$, $\theta=-(n-1)\gamma$, $n=p+q$:

- $\widetilde N$ decomposes over the equitable partition $\{A\setminus\{j\},B\setminus\{k\}\}$ into the quotient $\gamma\begin{psmallmatrix}-(q-1)&q-1\\p-1&-(p-1)\end{psmallmatrix}$, of determinant $0$ and trace $(n-2)g$, plus $\gamma$ on both zero-sum blocks. So $\lambda_{\max}(\widetilde N)=(n-2)g=T$ **exactly**, attained on $o$.
- $w=(q\text{ on }A,\ -p\text{ on }B)/\sqrt{pqn}$, $\lambda_1=ng$, $\rho^2=1-(p^2+q^2)/(pqn)$, so $\lambda_1\rho^2=T-g(p-q)^2/(pq)$; and $\hat w^\top D\hat w=g\,[\,n(p-q)^2+p^2+q^2\,]/[\,pqn-p^2-q^2\,]$.

Adding and simplifying, with $s=p^2+q^2$ and $d=(p-q)^2$:

$$\boxed{\;a-T\;=\;\frac{g\,s\,(d+pq)}{pq\,(pqn-s)}\;>\;0\;}\qquad\text{for every }p,q\ge2 .$$

**The side condition $a<T$ fails at every cross pair of every sphere product**, so $(T-a)(T-b)<0$ and $\lVert D\hat w\rVert^2\le(T-a)(T-b)$ is false. At $p=q=m$ this is $a-T=g/(m-1)$, a relative excess of $1/(2(m-1)^2)$, $2\%$ at $m=6$. The estimate itself returns $\ge a>T$ and never clears.

**$S^6\times S^6$, cross pair, in the band at $\theta=1.236033$**, is a complete falsifier on its own: $T=1.123666$, true $\lambda_{\max}(\widetilde N)=1.123666$, $a=1.146140$, $b=k=0.022473$, $(T-a)(T-b)=-0.024747$, estimate $=1.146589>T$. This is the record's own extremal point, at the very pair count $m^2=36$ out of $\binom{12}2=66$.

**And no sharpening of the ingredients rescues it.** Using $\lambda_2$ in place of $0$ gains nothing ($\lambda_2=0$, forced, since $M\mathbf1=0$). Using the largest eigenvalue on $\{w,\mathbf1\}^\perp$ makes $a=T$ exactly at the balanced cross pair, and then the boxed condition demands $k=0$, which is false. The obstruction is #2a, not the arithmetic.

### 2c. A second, independent failure mode, both side conditions hold and the inequality still fails

At **within-factor** pairs of $S^5\times S^q$ with $q\ge34$ (in the band, $\theta=1.2629\ldots\to1.2634$), $a<T$ and $b<T$ both hold and $\lVert D\hat w\rVert^2>(T-a)(T-b)$:

| point | $\theta$ | $T$ | true $\lambda_{\max}\widetilde N$ | $a$ | $b$ | $k^2$ | $(T-a)(T-b)$ | estimate |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| $S^5\times S^{34}$ | $1.262898$ | $1.545389$ | $1.229664$ | $1.284828$ | $0.564981$ | $0.257238$ | $0.255456$ | $1.546823$ |
| $S^5\times S^{40}$ | $1.263439$ | $1.550585$ | $1.234725$ | $1.298095$ | $0.574291$ | $0.273515$ | $0.246504$ | $1.572186$ |

The clause has **$20\%$ genuine slack** at these points and the estimate still overshoots. So the method fails on orbit-free pairs too, once the product is unbalanced enough, the $S^6\times S^6$ verification is a balanced-case artefact, not a representative one.

### 2d. Screen

A screen over all $S^p\times S^q$ with $3\le p\le q\le40$ and $\theta\ge\sqrt{3/2}$, objects constructed for this purpose, seconds of arithmetic, reported as a screen and not as evidence, returns: **cross pairs, $664$ of $664$ fail**; within-$A$ pairs, $7$ fail, all $S^5\times S^q$ with $q\ge34$; within-$B$ pairs, none fail. Criticality residual, hollowness, $M\mathbf1=0$ and $\lVert M\rVert_F^2=2$ were asserted to $10^{-10}$ at every point. This screens §2b, which is proved in closed form above, and §2c, which is not, **§2c is a screen result and is stated as one.**

---

## 3. Where the $3.5\%$ goes (priority 2)

At $S^6\times S^6$, within-factor, the true optimiser has $s=0.979796$ ($s^2=0.96$), and it is orthogonal to $\mathbf1$. Decomposing the gap of $0.3516g$ between the estimate's $10.3516g$ and the truth $10g$:

| step | loss | share | is it recoverable? |
| --- | --- | --- | --- |
| $z^\top Mz\le\lambda_2\lVert z\rVert^2$ (equivalently, dropping $\Pi K\Pi\succeq0$) | $0.240g$ | $68.3\%$ | **No, not with $\lambda_2$.** $\lambda_2=0$ is forced by $M\mathbf1=0$; the truth is $z^\top Mz=-\alpha\lVert z\rVert^2$ because $z$ lands in the $-\alpha$ eigenspace. Recovering it needs $\lambda_3$ **and** control of $\langle x,\Pi\mathbf1\rangle$ |
| $y^\top Dy\le\mu^+\lVert y\rVert^2$ | $0.070g$ | $20.0\%$ | Partly. $\mu^+=2\alpha$ is attained on the within-factor block while the optimal $y$ has most of its mass on the other factor, where the diagonal is $2\gamma<0$ |
| Cauchy–Schwarz on the cross term | $0.005g$ | $1.5\%$ | **Yes, free**: replace $k^2=\lVert D\hat w\rVert^2$ by $\lVert D\hat w\rVert^2-(\hat w^\top D\hat w)^2$, which moves the bound from $10.3516g$ to $10.3448g$ |
| the estimate's optimal $c\approx0.9714$ against the truth's $s=0.9798$ | $0.036g$ | $10.2\%$ | No, this is what a two-parameter relaxation costs |

**The single dominant step is the PSD drop, and it is structural.** The sharpened form is $\tilde x^\top M\tilde x\le\lambda_1t^2+\lambda_3'(1-t^2-\sigma^2)$ with $\lambda_3'=\lambda_{\max}(M|_{\{w,\mathbf1\}^\perp})\le0$, $t=\rho c$, $\sigma=\langle x,\Pi\mathbf1\rangle/\sqrt n$; at the balanced cross pair $\sigma=0$ and this is **exact**. It is a three-parameter maximisation rather than a $2\times2$ eigenvalue, and $\sigma$ is a new quantity needing its own bound. **That is the shape the successor has to take, and the price is the closed form.**

---

## 4. "At most one direction can violate the clause" (priority 3)

**CONFIRMED as a derivation, with two riders.** On $(\Pi w)^\perp$ the rank-one term vanishes and $x^\top\widetilde Nx=-x^\top\Pi K\Pi x+x^\top Dx\le\mu^+\lVert x\rVert^2$, so if $\mu^+<T$ then no direction orthogonal to $\Pi w$ violates the clause. Correct.

- **It does depend on $\lambda_1$ being simple**, it needs $M=\lambda_1ww^\top-K$ with $K\succeq0$ and the rank-one part rank *one*. A degenerate $\lambda_1$ would leave a $\ge2$-dimensional exceptional subspace. But **degeneracy is impossible in the band**: multiplicity $2$ would give two eigenvalues $\ge\theta$ against $k\theta^2\le2$. So the caveat "when $\lambda_1$ is simple" that the section attaches to the *orbit-free* relations is vacuous, and stating it as a hypothesis understates what the band already gives. **CORRECTED in the strengthening direction.**
- **The conclusion is conditional on $\mu^+<T$, i.e. on $b<T$, which is not proved.** The section presents the $(\Pi w)^\perp$ statement and the side condition $b<T$ as two things, one of which "reuses" the other. They are one statement, verified once, at sphere products. See §5.

---

## 5. "$b<T$ is already general", CORRECTED, an overstatement (priority 4)

**It is not general; it is a sphere-product check, and the displayed reduction is narrower still.** The text writes "at every $S^p\times S^q$ it reduces to $2m\le2m^2-2m+1$", an inequality in a single $m$, so it is the **balanced** computation, not the $S^p\times S^q$ one it is said to be.

**But no falsifier exists, and here is why.** $b=\max_i(u_i+v_i)=\max_i\widetilde N_{ii}=\max_ie_i^\top\widetilde Ne_i\le\lambda_{\max}(\widetilde N)$. So $b\le T$ is a **consequence** of the pair clause. It can never be refuted while the clause holds, and it can never be assumed while proving the clause without begging a piece of it. **The honest status is: strictly weaker than the clause, unproved, and open.** Calling it "already general" is the third instance in this item of a sphere-product verification promoted to a general statement, the pattern Gate 2 has now corrected on the asymptotic claim of $(\dagger)$, on the "unconditionally true at $\theta=\Theta_n$" claim, and here.

---

## 6. The orbit-free relations, and degeneracy (priority 5)

All four **CONFIRMED**, re-derived from the definitions:

1. $u=v\iff$ the transposition $\tau=(jk)$ satisfies $P_\tau MP_\tau=M$. Immediate on the four block cases, using hollowness for $M_{jj}=M_{kk}=0$.
2. $w_j=w_k$. Since $\lambda_1$ is simple (free in the band, §1), $P_\tau w=\pm w$. **The minus branch is not excluded in the text, this is a silently used hypothesis.** It is excludable: $P_\tau w=-w$ forces $w=(e_j-e_k)/\sqrt2$ and $\lambda_1=-M_{jk}$, while an orbit-free block has $\theta M_{jk}=M_{jk}^2+\lVert u\rVert^2$ and hence $M_{jk}>0$ unless $u=0$; and $u=0$ forces $M_{jk}\in\{0,\theta\}$, both giving $\lambda_1\le0$. Contradiction with $\lambda_1\ge\theta>0$. **So the claim stands, once that step is written down.**
3. $u\!\cdot\!\Pi w=(\lambda_1-M_{jk})w_0$, from row $j$ of $Mw=\lambda_1w$: $\sum_{i\in I}u_iw_i+M_{jk}w_k=\lambda_1w_j$. Verified against $S^m\times S^m$: both sides equal $mg(2m-3)/[(m-1)\sqrt{2m}]$.
4. $N\Pi w=\lambda_1\Pi w-2w_0u$, from row $i\in I$ of the same equation.

**"What if the top eigenvalue is degenerate, does the whole construction fail?"** It cannot be degenerate in the band, so no. The construction is safe on this point, and the section is more cautious than it needs to be here while being less cautious than it needs to be in §5.

---

## 7. Silently used hypotheses, collected

| where | what is assumed without statement |
| --- | --- |
| $M=\lambda_1ww^\top-K$, $K\succeq0$ | the **gap** $\operatorname{spec}(M)\cap(0,\theta)=\varnothing$, on top of the band count. The count alone gives $\lambda_2<\theta$, not $\lambda_2\le0$ |
| "at most one direction can violate" | $\mu^+<T$, unproved in general (§5) |
| $w_j=w_k$ | $P_\tau w=+w$ rather than $-w$ (§6.2) |
| the boxed condition's usefulness | $o=0$. The section's own earlier round proved $\widetilde No=To$; the joint estimate inherits the same blindness and the text does not say so |
| "the estimate is within $3.5\%$ of the truth" | at **one** pair of **one** point. §2c shows it exceeds $100\%$ of the available slack at $S^5\times S^{40}$, an orbit-free pair in the band |

---

## 8. Two things offered back

**(a) The sharper cross term, free.** $k^2=\lVert D\hat w\rVert^2-(\hat w^\top D\hat w)^2$, because $(D\hat w)$ is paired against $y\perp\hat w$. At $S^6\times S^6$ it moves $10.3516g\to10.3448g$. It does not rescue anything in §2, and it costs nothing.

**(b) The sum companion to [Lemma L68](../findings/diagonal-half.md), a lower bound on $M_{jk}$, which is precisely what the section says it lacks.** L68 uses $\lVert M_j-M_k\rVert^2\ge2M_{jk}^2$ and yields the cap $2\theta M_{jk}\le s_j+s_k$. The **sum** carries the same coordinate argument: $(M_j+M_k)_j=(M_j+M_k)_k=M_{jk}$, so $\lVert M_j+M_k\rVert^2\ge2M_{jk}^2$, and with $(M^2)_{jk}=\theta M_{jk}-M_{jk}^2$,

$$\boxed{\;4M_{jk}^2-2\theta M_{jk}-(s_j+s_k)\;\le\;0\;}\qquad\Longleftrightarrow\qquad M_{jk}\ \ge\ \frac{\theta-\sqrt{\theta^2+4(s_j+s_k)}}4,$$

with equality exactly when $u+v=0$. Hence, unconditionally in the band, using $s_j+s_k\le\lVert M\rVert_F^2=2$,

$$T=\theta+M_{jk}\ \ge\ \frac{5\theta-\sqrt{\theta^2+8}}4\ \ge\ 0.760379\ >\ 0 .$$

**It is near-sharp where it matters.** At the $S^6\times S^6$ cross pair, $s_j+s_k=1/3$ and the bound gives $M_{jk}\ge-0.113862$ against the true $\gamma=-0.112367$, tight to $1.3\%$, as it should be, since $u+v$ there is the uniform $g/(m-1)$, small but nonzero. Together with L68 this **brackets** every off-diagonal entry of a pure critical point between two explicit roots in $(\theta,s_j+s_k)$.

---

## 9. What a successor must clear

1. **It must be exact on pairs with $u\ne v$**, because $\widetilde No=To$ makes the clause an equality there and generically every pair is of that kind. Any bound of the form "estimate $\le T$" is dead on arrival outside orbit-free pairs. The joint estimate is the second instrument fenced by this same fact.
2. **Even restricted to orbit-free pairs it must beat $S^5\times S^{40}$**, where the boxed condition fails with $20\%$ of genuine slack unclaimed and both side conditions satisfied.
3. **The PSD drop is $68\%$ of the loss** and is not removable with $\lambda_2$; a successor needs $\lambda_3$ together with a bound on $\langle x,\Pi\mathbf1\rangle$, at the cost of the closed form.
4. **$b<T$ is owed** and is a strictly weaker sub-problem than the clause, not a settled side condition.

**Status of the item after five attempts.** Perturbation (fenced), variational ascent (fenced, circular), trace–Frobenius (fenced, inconsistent with the normalisation), rank-one split (short by $1.5\%$ at one point, and conditional on the unproved $b<T$), joint estimate (**refuted as a general instrument**, by a closed-form family and by a second, independent mode). *The one durable gain across all five is structural: $\lambda_1$ is simple in the band, $\lambda_2\le0$, and $\widetilde No=To$ pins the clause to an equality on every non-orbit-free pair.*
