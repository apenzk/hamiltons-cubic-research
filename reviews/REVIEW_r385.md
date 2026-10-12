# Review r385, Gate 2 on the twin-pair sections: the twin identity, the trace bound on $\mathbf1^\perp$, and the balanced-product theorem

*2026-09-02. Adversarial, cold brief. The trace bound, the twin identity and the four balanced-product identities were re-derived from the definitions before the author's text was opened; the order of work is in [agent_logs/gate2-twin-A.log](../agent_logs/gate2-twin-A.log). **Analysis only.** Three numerical passes appear below; each screens a claim I derived by hand first, on matrices I constructed for the purpose, and each is labelled as a screen. The two counterexamples in §6 are exact and hand-checkable, and are not screens.*

## Verdicts

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | Complementarity: the ordering theorem and $(\dagger)$ cover disjoint sets, the estimate failing at every non-twin pair and clearing at twin pairs | **CONFIRMED as a reading of [r381](REVIEW_r381.md)/[r382](REVIEW_r382.md), with two corrections.** "Fails at every non-twin pair" is proved in closed form only at *cross pairs of sphere products*; and the two sets are not a partition of the difficulty, **a third complementarity exists inside the twin case** (§6.1) |
| 2 | Twin specialisation $\widetilde Nu=(\theta-M_{jk})u+u\circ u$, so $u$ is an eigenvector only when constant on its support | **CONFIRMED**, re-derived independently from criticality alone, and cross-checked two ways |
| 3 | The trace bound on $\mathbf1^\perp$ | **CONFIRMED, the derivation is correct and the bookkeeping is right.** One statement-precision defect: it bounds $\lambda_{\max}(\widetilde N|_{\mathbf1^\perp})$, and the display writes $\lambda_{\max}(\widetilde N)$ |
| 4 | The two evaluations | **BOUNDS CONFIRMED** to every digit ($1.288471$, $1.321892$). **Three reported constants are wrong in the 5th–6th decimal**, $T$ at $S^6\times S^6$, and $\theta$ and $T$ at $S^5\times S^{40}$. $S^5\times S^{40}$ **is** one of [r382](REVIEW_r382.md)'s seven. **"Within-factor" is ambiguous at $p\ne q$ and the other reading is where the bound fails** |
| 5 | The exact balanced-product theorem | **CONFIRMED, every identity, the equivalence and the margin.** $\theta\alpha=1/m$ exactly, $2E/D=2-2/(2m-3)$, and $T^2-2E/D=3/(m(2m-3))+1/m^2+1/((m-1)(2m-1))$ all hold. **One unstated step**: the squaring needs $DT+2\alpha>0$, which is true and one line, and is not written |
| 6 | Scope: the theorem is claimed only at balanced products, the general twin pair open | **HONEST BUT UNDERSTATED, and the natural generalisation is REFUTED.** Two counterexamples, one exact and one with an exact asymptotic law: the trace bound **fails** at the within-larger-factor twin pair of every in-band $S^p\times S^q$ with $\lvert p-q\rvert\ge3$, and **fails, while being exactly tight, at every padded pair** |
| 7 | *New, and the most valuable thing here.* The statement the whole twin-case programme is trying to prove ($\lambda_{\max}(\widetilde N)\le T$), is **FALSE** at padded pairs of in-band pure critical points, while [I18](../plan.md)'s actual clause survives there | **NEW FENCE POST**, see §7 |

**The headline.** *The mathematics of all three sections is correct, I could not break a single derivation.* What is wrong is the picture around them. The trace bound is not a general twin-pair instrument that happens to be proved only at balanced products: it has an **explicitly characterised failure region**, it covers a razor-thin neighbourhood of balance, and on the residue the record most cares about (the padded sub-case), the bound is *exactly tight* and still exceeds $T$, so **no sharpening can ever reach it, because the target inequality is itself false there**.

---

## 1. What I derived before opening the text

**The trace bound, from scratch.** $\widetilde N$ is symmetric on $\mathbb R^I$, $\lvert I\rvert=d=n-2$, with $\widetilde N\mathbf1=0$. So $\mathbb R^I=\mathbb R\mathbf1\oplus\mathbf1^\perp$ is $\widetilde N$-invariant, $\dim\mathbf1^\perp=d-1=:D$, and both moments carry over unchanged: the eigenvalue on $\mathbb R\mathbf1$ is $0$, so $\operatorname{tr}(\widetilde N|_{\mathbf1^\perp})=\operatorname{tr}\widetilde N=-2M_{jk}=:t$ and $\lVert\widetilde N|_{\mathbf1^\perp}\rVert_F^2=\lVert\widetilde N\rVert_F^2=f$. List the $D$ eigenvalues on $\mathbf1^\perp$ with multiplicity, let $\lambda$ be a largest, and apply Cauchy–Schwarz to the remaining $D-1=d-2=:E$:

$$(t-\lambda)^2=\Big(\sum_{i\ge2}\lambda_i\Big)^2\le E\sum_{i\ge2}\lambda_i^2=E(f-\lambda^2)\ \Longrightarrow\ (1+E)\lambda^2-2t\lambda+(t^2-Ef)\le0 ,$$

and $1+E=D>0$, so $\lambda$ lies between the roots and

$$\lambda\ \le\ \frac{t+\sqrt{E\big[Df-t^2\big]}}{D}\ =\ \frac{-2M_{jk}+\sqrt{(d-2)\big[(d-1)f-4M_{jk}^2\big]}}{d-1}.$$

**Identical to the recorded display.** The three bookkeeping questions the brief asks all answer in the author's favour, and one of them answers a question the text does not raise:

- **The working dimension is $D=d-1$ and the Cauchy–Schwarz count is $E=d-2$.** Both correct, and they are *different* numbers doing different jobs, $D$ is the dimension of $\mathbf1^\perp$, $E$ is the number of non-maximal eigenvalues in it. The recorded formula uses each in its right place.
- **Trace and Frobenius are unchanged on $\mathbf1^\perp$**, because $\mathbf1$ is a $0$-eigenvector rather than merely an invariant direction. If $\widetilde N\mathbf1$ were any other multiple of $\mathbf1$ the trace would shift.
- **Repeated eigenvalues are harmless.** The argument never needs a distinct maximum: it picks one entry of the multiplicity-counted list and bounds the other $E$. A repeated top is the equality case of the Cauchy–Schwarz, not a failure of it.
- **The radicand is automatically non-negative**, a point the text does not make and which a reader would otherwise have to check. Cauchy–Schwarz on all $D$ eigenvalues gives $t^2\le Df$, so $Df-t^2\ge0$ with no extra hypothesis. There is no hidden side condition here.
- **Small $d$.** $E\ge1$ needs $d\ge3$. At $d=2$ ($D=1$, $E=0$) the formula returns $\lambda\le t$, which is *exact*, the single eigenvalue on $\mathbf1^\perp$ **is** the trace. At $d\le1$ the formula divides by $D=0$ and is undefined. The band forces $n\ge12$, so nothing here bites.

> **The one defect: the bound is on $\mathbf1^\perp$, and the display is not.** What is proved is $\lambda_{\max}(\widetilde N|_{\mathbf1^\perp})\le L$. Since $0\in\operatorname{spec}\widetilde N$, the honest global statement is $\lambda_{\max}(\widetilde N)\le\max(0,L)$. It is harmless in every use, because $T>0$ makes $\lambda_{\max}(\widetilde N)\le T$ follow from $L\le T$ either way, but the display as written is literally false whenever $L<0$, and the fix is to write $\widetilde N|_{\mathbf1^\perp}$.

**The twin identity, from criticality alone.** For $a\in I$, splitting $(M^2)_{aj}=\sum_{b\in I}M_{ab}M_{bj}+M_{aj}M_{jj}+M_{ak}M_{kj}$ and using hollowness gives $(Nu)_a=(M^2)_{aj}-M_{jk}v_a$. Off-diagonal criticality at $(a,j)$ gives $(M^2)_{aj}=\theta u_a-u_a^2$. At a twin pair $v=u$ and $\widetilde N=N+2\operatorname{diag}(u)$, so

$$(\widetilde Nu)_a=\theta u_a-u_a^2-M_{jk}u_a+2u_a^2=(\theta-M_{jk})u_a+u_a^2 .$$

**Claim 2 CONFIRMED**, and the conclusion follows: $u\circ u=cu$ forces $u_a\in\{0,c\}$, so $u$ is an eigenvector exactly when it is constant on its support, and then at the eigenvalue $\theta-M_{jk}+c$, *note $\theta-M_{jk}$, not $T=\theta+M_{jk}$*, which the text has right and which is worth stating, since the natural misreading would make $u$ a second $T$-eigenvector and hand the ordering argument the thing it lacks.

> **Two cross-checks the identity passes, neither on the record.**
>
> **(a) Its $\mathbf1$-component *is* the recorded quadratic.** Pairing with $\mathbf1$ and using $\widetilde N\mathbf1=0$ gives $0=(\theta-M_{jk})(\mathbf1\!\cdot\!u)+\lVert u\rVert^2$; and $\mathbf1\!\cdot\!u=\sum_{i\in I}M_{ij}=-M_{jk}$ by the zero row sum. That is $\lVert u\rVert^2=\theta M_{jk}-M_{jk}^2$, [r378](REVIEW_r378.md)'s identity, recovered as one coordinate of the new one. *So the identity is consistent with everything already proved, and it is strictly more information than the quadratic.*
>
> **(b) Direct check at $S^6\times S^6$, within-factor.** On an $F_1$ component the identity predicts $9.8g\cdot1.2g+1.44g^2=13.2g^2$; summing $\widetilde N$ by hand gives $3\alpha^2+6\gamma^2+2\alpha^2=4.32g^2+6g^2+2.88g^2=13.2g^2$. On an $F_2$ component it predicts $-9.8g^2+g^2=-8.8g^2$; by hand, $4\gamma\alpha+5\alpha\gamma+2\gamma^2=-4.8g^2-6g^2+2g^2=-8.8g^2$. Both exact.

---

## 2. Claim 5, the balanced-product theorem. CONFIRMED, every identity

**The three exact values.** From $\gamma^2=\frac{m-1}{m^2(2m-1)}$, $\alpha=\frac m{m-1}\lvert\gamma\rvert$, $\theta=(2m-1)\lvert\gamma\rvert$:

| identity | check | verdict |
| --- | --- | --- |
| $\theta^2=2-\frac3m+\frac1{m^2}$ | $(2m-1)^2\gamma^2=\frac{(2m-1)(m-1)}{m^2}=\frac{2m^2-3m+1}{m^2}$ | **exact** |
| $\theta\alpha=\frac1m$ | $\frac{(2m-1)m}{m-1}\gamma^2=\frac{(2m-1)m}{m-1}\cdot\frac{m-1}{m^2(2m-1)}=\frac1m$ | **exact, and the cancellation is total** |
| $\alpha^2=\frac1{(m-1)(2m-1)}$ | $\frac{m^2}{(m-1)^2}\cdot\frac{m-1}{m^2(2m-1)}$ | **exact** |
| $T^2=2-\frac1m+\frac1{m^2}+\frac1{(m-1)(2m-1)}$ | sum of the three | **exact** |

*$\theta\alpha=1/m$ is the load-bearing one and it is exactly right: the $(2m-1)$ and the $(m-1)$ both cancel outright, which is why the two competing $1/m$ terms in the comparison fail to cancel each other.* Cross-check against [r381](REVIEW_r381.md)'s independent $T=g(2m^2-2m+1)/(m-1)$: squaring gives $T^2=(2m^2-2m+1)^2/(m^2(2m-1)(m-1))$, which at $m=6$ is $3721/1980=1.879293$, agreeing with $2-\frac16+\frac1{36}+\frac1{55}$ to every digit. **Two independent closed forms for $T^2$ agree.**

**$2E/D=2-\frac2{2m-3}$.** $\frac{4m-8}{2m-3}$ against $\frac{2(2m-3)-2}{2m-3}=\frac{4m-8}{2m-3}$. **Exact.**

**The margin.** $\frac2{2m-3}-\frac1m=\frac{2m-(2m-3)}{m(2m-3)}=\frac3{m(2m-3)}$, so

$$T^2-\frac{2E}D=\frac3{m(2m-3)}+\frac1{m^2}+\frac1{(m-1)(2m-1)}>0\qquad(m\ge2).$$

**Exact, and strictly positive from $m=2$ up**, one better than the stated $m\ge3$.

**The equivalence.** Re-derived rather than checked. $L\le T\iff\sqrt{E[Df-4\alpha^2]}\le DT+2\alpha$; squaring and dividing by $D^2$,

$$\frac{Ef}D-\frac{4E\alpha^2}{D^2}\le T^2+\frac{4T\alpha}D+\frac{4\alpha^2}{D^2},$$

and substituting $f=2-2\alpha^2$ so that $\frac{Ef}D=\frac{2E}D-\frac{2E\alpha^2}D$ and moving that term right,

$$\frac{2E}D\le T^2+\frac{4T\alpha}D+\frac{4\alpha^2(E+1)+2ED\alpha^2}{D^2}.$$

**Character for character the recorded display**, including the $2ED\alpha^2$, which is $\frac{2E\alpha^2}D$ put over $D^2$. And the conclusion follows: every added term is positive for $T,\alpha,D,E>0$, and $T^2-2E/D>0$.

> **The one unstated step, and the brief was right to ask.** Squaring is an equivalence only with $DT+2\alpha\ge0$, which the text asserts nowhere. It is true and takes one line: $D=2m-3>0$; $T=\theta+M_{jk}>0$ since $\theta>0$ and $M_{jk}=\alpha>0$; hence $DT+2\alpha>0$. **At a general twin pair the same line still works**, $M_{jk}\ge0$ is on the record (twice: from $\theta M_{jk}=M_{jk}^2+\lVert u\rVert^2$, and from the $e_j-e_k$ eigenvector), and $T\ge\theta>0$. *Only the reverse direction needs it; the forward direction is free, since $L\le T$ makes $DT+2\alpha\ge DL+2\alpha=\sqrt{\cdots}\ge0$ automatically.* **Not a defect in the result, a gap in the write-up.**

---

## 3. Claim 4, the two evaluations, recomputed from scratch

**$S^6\times S^6$, within-factor.** $m=6$, $n=12$, $d=10$, $D=9$, $E=8$. $\gamma^2=5/396$, $\alpha^2=1/55$, $\alpha=0.13483997$, $\theta=\sqrt{605/396}=1.23603308$.

$f=2-\frac2{55}=1.96363636$; $Df-4\alpha^2=18-\frac{18}{55}-\frac4{55}=18-\frac{22}{55}=17.6$ exactly; $E[\cdot]=140.8$; $\sqrt{140.8}=11.86591758$;

$$L=\frac{11.86591758-0.26967994}9=\mathbf{1.28847090}.$$

**Recorded $1.28847$, exact.**

**$S^5\times S^{40}$, within-factor.** The general $S^p\times S^q$ closed forms, re-derived: with $\gamma=-g$, $\alpha=qg/(p-1)$, $\beta=pg/(q-1)$, $\theta=(n-1)g$, $n=p+q$, the zero row sum and criticality at a cross pair are identities, and $\lVert M\rVert_F^2=2$ reads $g^2pq\big[\tfrac q{p-1}+\tfrac p{q-1}+2\big]=2$ whose bracket collapses to $\frac{(n-1)(n-2)}{(p-1)(q-1)}$, so

$$g^2=\frac{2(p-1)(q-1)}{pq(n-1)(n-2)},\qquad \theta\,M_{jk}=\frac{2(q-1)}{p(n-2)}\ \text{for a pair inside the $p$-factor.}$$

*The second reduces to $\theta\alpha=1/m$ at $p=q=m$, which is the balanced identity of §2 obtained a second way.* At $p=5,q=40,n=45$: $g^2=\frac{312}{378400}=\frac{39}{47300}$, $g=0.02871453$, $\theta=44g=\mathbf{1.26343938}$, $M_{jk}=10g=0.28714530$, $T=\mathbf{1.55058470}$. Then $d=43$, $D=42$, $E=41$, $f=1.83509514$, $Df-4M_{jk}^2=76.74418$, $E[\cdot]=3146.5116$, $\sqrt{\cdot}=56.093776$, and

$$L=\frac{56.093776-0.574291}{42}=\mathbf{1.32189249}.$$

**Recorded $1.32188$, exact to the digits given.** Both verdicts ("clears") stand, at $S^6\times S^6$ with $6.0\%$ of $T$ to spare and at $S^5\times S^{40}$ with $14.8\%$.

> **Three reported constants are wrong, all in the same direction, too many digits, and the last two of them false.**
>
> | quantity | recorded | correct | error |
> | --- | --- | --- | --- |
> | $T$ at $S^6\times S^6$ | $1.370864$ | $\mathbf{1.3708731}$ | $9.2\times10^{-6}$ |
> | $\theta$ at $S^5\times S^{40}$ | $1.26346$ | $\mathbf{1.2634394}$ | $2.1\times10^{-5}$ |
> | $T$ at $S^5\times S^{40}$ | $1.55061$ | $\mathbf{1.5505847}$ | $2.5\times10^{-5}$ |
>
> The $S^6\times S^6$ value of $T$ is checkable three ways without any arithmetic beyond the record, $12.2g$ ([r381](REVIEW_r381.md)), $g(2m^2-2m+1)/(m-1)$ ([r381](REVIEW_r381.md)), and $\sqrt{3721/1980}$ (§2 above), and all three give $1.3708731$. The two $S^5\times S^{40}$ values disagree with **[r382](REVIEW_r382.md)'s own table** ($1.263439$, $1.550585$), which the section cites in the same paragraph. *No verdict moves; the margins are $6\%$ and $15\%$. But a table that reports five and six significant figures should carry them, and here the fifth is wrong in the two places where the record already held the right value.*

**Is $S^5\times S^{40}$ one of [r382](REVIEW_r382.md)'s seven? YES.** [r382](REVIEW_r382.md) §2c tabulates it by name, §2d gives "$7$ fail, all $S^5\times S^q$ with $q\ge34$" (which is $q\in\{34,\dots,40\}$ at the screen's ceiling $q\le40$, exactly seven) and the quoted $k^2=0.2735$ against $(T-a)(T-b)=0.2465$ reproduces [r382](REVIEW_r382.md)'s $0.273515$ and $0.246504$. **The citation is accurate.**

> **But "within-factor" is not a well-defined pair type at $p\ne q$**, and the ambiguity is not cosmetic. $S^5\times S^{40}$ has *two* within-factor pair types. The one meant is the pair inside the $5$-factor ($M_{jk}=10g$), which is the one my recomputation matches and the one [r382](REVIEW_r382.md)'s $(\dagger)$ failure lives at. **The pair inside the $40$-factor is where the trace bound fails**, §6.1. *So the section's two-row table names, without saying so, exactly the two pair types on which the instrument works, at a point that also carries one on which it does not.*

---

## 4. Claim 1, complementarity. CONFIRMED as a reading, with two corrections

**Checked against the two reviews line by line, and the table's cells are supported:**

| cell | supported by | verdict |
| --- | --- | --- |
| $(\dagger)$ fails at every cross pair, $a>T$ in closed form | **[r382](REVIEW_r382.md)** §2b's boxed $a-T=\frac{gs(d+pq)}{pq(pqn-s)}>0$; [r381](REVIEW_r381.md) claim 6 has the balanced case only | supported, **but attributed to [r381](REVIEW_r381.md)**, the closed form at general $p,q$ is [r382](REVIEW_r382.md)'s |
| $(\dagger)$ clears at $S^6\times S^6$ "by a factor of five" | $k^2=4.704g^2$ against $(T-a)(T-b)=2.44\cdot9.8\,g^2=23.912g^2$, ratio $5.08$ | **exact**, it is the factor in the boxed inequality, not in the bound, and the text should say which |
| "except one family" | [r382](REVIEW_r382.md) §2d: within-$A$, $7$ fail, all $S^5\times S^q$, $q\ge34$; within-$B$, none | **exact** |
| ordering theorem: $o\ne0$, $T$ simple, needs only $\theta\ge1$ | [r383](REVIEW_r383.md)/[r384](REVIEW_r384.md) | **exact** |

> **Correction 1, "fails at *every* non-twin pair" overstates what is proved.** Two arguments are being run together. The closed-form witness ([r382](REVIEW_r382.md) §2b) covers cross pairs of sphere products, a family. The general argument ([r382](REVIEW_r382.md) §2a) is structural, $\widetilde No=To$ makes the clause an *equality* at $o\ne0$, so any **strictly loose** bound fails, and it is conditional on strict looseness, which [r382](REVIEW_r382.md) itself qualifies as "whenever $k\ne0$". *The honest cell is "fails at every cross pair of every sphere product, in closed form, and at every non-twin pair where the estimate is strictly loose".* The distinction matters because the residue includes non-sphere-product points where nothing is known either way.
>
> **Correction 2, the two rows are not the whole difficulty, and the section's own next instrument proves it.** The table's second row reads as though the twin case were a single object on which $(\dagger)$ works up to one family. It is not: **the twin case splits again**, and the split is invisible from the two rows. See §6.1.

---

## 5. Claim 6, scope. Honest, and understated

**The sentence "*Does not close: the general twin pair, since $\alpha,\theta,f$ were used in their balanced-product closed forms*" is honest.** It does not claim the general case and it names the reason correctly.

**It is understated in one respect that matters.** "Open" and "outside the instrument's reach" are different states, and this is the second. §6 exhibits the failure region explicitly, and it is not a thin exceptional set: on the screened grid the trace bound fails at $1431$ of $1539$ within-larger-factor in-band twin pairs, and at **every** padded pair. *The record's standing rule (a sphere-product verification is not a general statement), applies to the instrument's success here just as [r382](REVIEW_r382.md) applied it to $(\dagger)$'s.*

---

## 6. The two counterexamples

### 6.1 The trace bound fails at the within-**larger**-factor twin pair of every in-band $S^p\times S^q$ with $\lvert p-q\rvert\ge3$

**The exact instance, hand-checkable, at the section's own point.** $S^5\times S^{40}$, pair inside the $40$-factor. Same $g^2=39/47300$ as §3, but now $M_{jk}=\dfrac{5g}{39}=0.00368135$ and

$$T=\theta+M_{jk}=\frac{1721}{39}g=\mathbf{1.26712073},\qquad L=\frac{-0.00736270+\sqrt{41\,[42f-4M_{jk}^2]}}{42}=\frac{58.6778233}{42}=\mathbf{1.39709104}.$$

$L$ **exceeds $T$ by $10.3\%$.** The bound certifies nothing there.

**The clause itself still holds, and the equitable partition gives the truth exactly.** On $I$, split into the $5$-block and the $38$ survivors of the $40$-block, $\widetilde N$ has quotient $g\begin{psmallmatrix}38&-38\\-5&5\end{psmallmatrix}$ (determinant $0$, trace $43g$) plus $-12g$ on the $5$-block's zero-sum space and $\tfrac5{39}g$ on the $38$-block's, so

$$\operatorname{spec}\widetilde N=\{43g,\ 0,\ (-12g)^{(4)},\ (\tfrac5{39}g)^{(37)}\},\qquad \lambda_{\max}=43g=1.23472485<T .$$

*Consistency, both exact: the trace is $43g-48g+\tfrac{185}{39}g=-\tfrac{10}{39}g=-2M_{jk}$, and the sum of squares is $g^2(1849+576+\tfrac{925}{1521})=2-2M_{jk}^2=f$.* **So the bound overshoots the genuine slack $T-\lambda_{\max}=0.032396$ by a factor of $5.0$.**

**The extent, screened.** *Screen: closed forms in $(p,q)$ evaluated over $3\le p\le q\le60$ with $\theta^2\ge3/2$, seconds of arithmetic on objects constructed for the purpose, reported as a screen and not as evidence.* Balanced points: $55$ screened, **all clear**, smallest margin $6.07\times10^{-4}$ at the top of the range, consistent with §2's $O(m^{-2})$. Within-**smaller**-factor pairs: $1539$ screened, **none fail**. Within-**larger**-factor pairs: $1539$ screened, **$1431$ fail**, and the boundary is sharp and $p$-independent, for every $p$ from $5$ to $57$, the bound clears at $q-p\le2$ and fails from $q-p=3$ on.

**And the boundary has an exact asymptotic law, which is analysis, not screening.** Write $P$ for the pair's own factor, $Q$ for the other, $n=P+Q$, $D=n-3$, $E=n-4$, and let $G$ be the margin of §2's equivalence, so that $L\le T\iff G\ge0$. With $g\sim\sqrt2/n$, $\theta\to\sqrt2$, $M_{jk}\sim\frac QP\frac{\sqrt2}n$ and $\theta M_{jk}=\frac{2(Q-1)}{P(n-2)}$,

$$T^2-\frac{2E}D=\frac4n\Big(\frac QP-1\Big)+O(n^{-2}),\qquad \frac{4TM_{jk}}D+\frac{4M_{jk}^2(E+1)+2EDM_{jk}^2}{D^2}=O(n^{-2}),$$

so at a *fixed* split $P-Q=k$ the leading term is itself $O(n^{-2})$ and the correction terms compete with it at the same order. Expanding both,

$$\boxed{\;n^2G\ \longrightarrow\ 24-8\,(P-Q)\;}$$

positive for $P-Q\le2$, negative for $P-Q\ge4$, and zero at $P-Q=3$, where the sign is decided at $O(n^{-3})$ and the screen says it is negative at every $p$ tested. *Two independent confirmations: at $P=Q=m$ the law gives $G\to24/n^2=6/m^2$, and §2's exact margin plus the two correction terms gives $\tfrac3{m^2}+\tfrac2{m^2}+\tfrac1{m^2}=\tfrac6{m^2}$, the same constant; and a high-precision evaluation of the exact rational $G$ at $n$ up to $2\times10^5$ returns $24.000,\,8.000,\,-8.001,\,-24.001$ at $P-Q=0,2,4,6$.*

> **What this does to the theorem's standing.** The balanced-product theorem is not a first instalment on a general twin-pair result. It is the $P=Q$ case of a law that **changes sign at $P-Q=3$**, and the theorem's whole content (the margin $6/m^2$), is the value of that law at $k=0$. *The instrument covers $\lvert p-q\rvert\le2$ and no more.*
>
> **And this is a third complementarity, invisible from the section's two-row table.** At $S^5\times S^{40}$: the cross pairs go to the ordering theorem; the within-$5$ pair fails $(\dagger)$ and is caught by the trace bound; the within-$40$ pair fails the trace bound and is caught by $(\dagger)$ ([r382](REVIEW_r382.md) §2d: within-$B$, none fail). **Neither twin-case instrument dominates the other, and the point that motivated the trace bound is also the point that bounds it.** *That is the useful shape here, and it is the same lesson the section drew one level up.*

### 6.2 The trace bound fails at every padded pair, while being exactly tight

**The construction.** Take $M'$ = the $S^6\times S^6$ point at $n'=12$ and pad with two zero rows to $n=14$. Every hypothesis in the setup holds: $M$ is hollow and symmetric, $M\mathbf1=0$, $\lVert M\rVert_F^2=\lVert M'\rVert_F^2=2$, and criticality at a padded index is $0+0=\theta\cdot0$. $\theta=11g=1.23603308\ge\sqrt{3/2}$, **in band**, and $n=14\ge12$.

At the pair $\{13,14\}$: $u=v=0$, so it is a **twin** pair, $o=0$, $M_{jk}=0$, $T=\theta$, and $\widetilde N=M'$. With $d=12$, $D=11$, $E=10$, $f=2$,

$$L=\frac{\sqrt{10\cdot11\cdot2}}{11}=\frac{\sqrt{220}}{11}=\mathbf{1.34840},\qquad T=\theta=\mathbf{1.23603}.$$

**And $L$ is exactly $\lambda_{\max}$.** $\operatorname{spec}(M')=\{12g,\ 0,\ (-1.2g)^{(10)}\}$, so on $\mathbf1^\perp$ the ten non-maximal eigenvalues are *all equal* (the equality case of Cauchy–Schwarz) and $L=12g=\lambda_{\max}(\widetilde N|_{\mathbf1^\perp})$ **on the nose**.

> **This is not a loose bound. It is a tight bound on a false statement**, and it generalises: at any padded pair $\widetilde N=M'$, and $\lambda_{\max}(M')=\lambda_1\ge\theta=T$ by the gap $\operatorname{spec}(M)\cap(0,\theta)=\varnothing$ together with $\operatorname{tr}M'=0$, $M'\ne0$, **strictly whenever $\lambda_1>\theta$, which holds at every sphere product.** *So $\lambda_{\max}(\widetilde N)\le T$ is FALSE at every padded pair of every in-band point with $\lambda_1>\theta$.*

---

## 7. The fence post this leaves, and it is the report's main content

**[r383](REVIEW_r383.md) and the section's Gate-2 note (5) both flag the padded pair, and both flag it as a place where *the argument* degenerates**, "the orbit-free budget degenerates to $\theta^2\ge2$ and fails". **The correct statement is stronger and changes what a successor may attempt: at a padded pair the *target inequality itself* is false.** §6.2 exhibits it, and exhibits it at a point where the trace bound is exactly tight, so *no sharpening of any moment-based instrument can reach it.*

**What survives, and it is the reason [I18](../plan.md) is not damaged.** [I18](../plan.md)'s pair clause is a **simplicity** statement, not a bound, [Lemma L128](../findings/second-order.md)(ii) excludes the *value* $\tfrac12$ rather than bounding the spectrum, and through [Lemma L122](../findings/second-order.md) that is "$T\notin\operatorname{spec}(\widetilde N|_{\mathbf1^\perp})$ off the orbit direction". At the padded pair of §6.2 the orbit direction is $o=0$ (the pair contributes none) and $T=\theta=11g$ is **not** in $\{12g,(-1.2g)^{(10)}\}$. **So the clause holds there while the bound fails.**

> **The consequence, stated positively.** *The twin-case programme has been proving a sufficient condition that is strictly stronger than what [I18](../plan.md) needs, and that sufficient condition is false on a sub-case [I18](../plan.md) must cover.* Two ways forward, and they are the only two:
>
> 1. **Prove $T\notin\operatorname{spec}(\widetilde N|_{\mathbf1^\perp})$ directly**, abandoning $\lambda_{\max}\le T$. This is what the clause asks and it is what survives padding. It is a *separation* question, not an extremal one, and no moment argument bounds it, the padded pair has $T$ sitting strictly inside the spectrum's convex hull.
> 2. **Add the hypothesis that excludes padding**, no zero row of $M$, equivalently $s_i>0$ for all $i$, equivalently $\circ$-indecomposability ([support-dichotomy.md](../findings/support-dichotomy.md)), and then $\lambda_{\max}\le T$ is at least not known to be false. *This hypothesis is free at a maximiser and is exactly what a maximiser has that a critical point does not*, which is the same seam [r376](REVIEW_r376.md) identified when it split the clause into an unconditional half and a maximality-needing half.
>
> **Either way the current instrument's target statement needs restating before more effort goes into it**, and that is a cheaper correction now than after a third estimate is built on it.

---

## 8. What a successor must clear

1. **It must handle padded pairs, or exclude them by a stated hypothesis.** $\lambda_{\max}(\widetilde N)\le T$ is false there and the trace bound is tight there, the two facts together close the whole moment-based class on that sub-case. (§6.2, §7)
2. **It must not be a balanced-product argument in disguise.** $n^2G\to24-8(P-Q)$ shows the trace bound's reach is $\lvert p-q\rvert\le2$; any successor should be tested at $S^5\times S^8$ (the smallest in-band failure), before anything else. (§6.1)
3. **It may not assume the twin case is one case.** Within-smaller-factor and within-larger-factor twin pairs are covered by *different* instruments, and neither instrument covers both. (§6.1)
4. **It must state $DT+2M_{jk}>0$ if it squares**, and it should write $\widetilde N|_{\mathbf1^\perp}$ where it means the restriction. (§2, §1)

**Status of the twin case after this round.** The twin identity is **correct and free**, with the bonus that its $\mathbf1$-component reproves the recorded quadratic. The trace bound is **correct, sharp at its equality case, and confined to $\lvert p-q\rvert\le2$ plus whatever a general proof of $T^2\ge2-2/(d-1)$ would add**; that clean general sufficient condition, $\lVert M\rVert_F^2-T^2\le\frac2{d-1}$, is the form the section should state and does not. The balanced-product theorem is **proved, every identity exact**. And the residue is smaller in one direction and larger in another than the record says: smaller, because $\lvert p-q\rvert\le2$ is now closed at sphere products by two instruments between them; larger, because the padded sub-case is not open but **false**, and needs a hypothesis rather than an argument.
