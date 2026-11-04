# VERIFY v21, Lemma L146: the Weyl image of $S^2_0(\mathbb R^m)$ at the balanced product, its Frobenius identity, its operator norm, and the range $[\Theta(n^{-1}),\Theta(n^{-1/2})]$

*Cold brief, worked from the definitions. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation in closed form. Log: [agent_logs/verify-L146-v21.log](../agent_logs/verify-L146-v21.log). Statement and proof under review: [findings/second-order.md](../findings/second-order.md) lines 1125–1152, quoted in [verification/ROUND_L146.md](ROUND_L146.md).*

## Claim table

| # | claim, as written | verdict |
| --- | --- | --- |
| 1 | the corrected embedding: $\alpha h_a$ on $e_a\wedge e_b$, $-\beta(h_a+h_{a'})$ on $e_a\wedge e_{a'}$, $0$ inside $B_2$, with $\alpha=\frac{m-2}{2(m-1)}$, $\beta=\frac m{2(m-1)}$ | **CONFIRMED**, re-derived from the record's own projector; $\alpha+\beta=1$, $\mathrm{Ric}=0$ and the row sums check |
| 2 | $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ | **CONFIRMED** in the record's Frobenius normalisation, which I pinned independently against [Lemma L145](../findings/second-order.md)'s $g_n$ |
| 3 | $\lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, "the in-block branch always winning" | **CONFIRMED AS ALGEBRA** for every $m\ge3$, but the dominance is asserted with **no argument on file**; the inequality it needs is supplied in §4 |
| 4 | supremum $1/\sqrt{m-1}$, attained at the pair-concentrated $h$ | **CONFIRMED**, exactly, and it is a maximum |
| 5 | "in order, $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$" | **CONFIRMED**; the exact lower bound is $\frac1{m-1}$, which reconciles the two reviewer figures the entry records as disagreeing |
| 6 | "the claimed minimiser (the even split) is wrong in either reading" | **CONFIRMED AS STATED ONLY AT $m\le7$.** True and witnessed at $m=6,7$; **unproven at $m\ge8$**, where the even split beats every competitor I could name |
| 7 | downstream: $\lVert H_s\rVert_{op}\le a_0n^{-1/2}$, $a_0=\sqrt{2n/(n-2)}$ | **CONFIRMED**, an exact identity with claim 4, and sharp |
| 8 | downstream: the same bound on the **joint two-copy** $S^2_0(\mathbb R^m)$ eigenspace | **REFUTED AS A READING OF L146.** The written statement gives strictly **less**: it prices one copy. The extension is true and I verify it in §7, but it is nowhere in L146's text |
| 9 | the missing hypothesis $m\ge3$ | **HYPOTHESIS-DEBT.** At $m=2$ the Weyl image is identically zero, so $\lVert H\rVert_F=1$ is unattainable and the displayed supremum is a supremum of the empty set |

**Summary the round can act on.** *Every mathematical assertion in L146 is true and I confirmed each by exact hand computation, including the two the previous Gate 2 left disputed. Three things are owed: the hypothesis $m\ge3$, which is nowhere stated and is needed for the statement to be non-vacuous; the in-block dominance inequality, which is asserted with no proof anywhere on the record; and the two-copy statement, which is what [Lemma L149](../findings/second-order.md) actually consumes and which L146 does not say. The one claim that overreaches is the parenthetical refutation of the even split, which is established only for $m\le7$.*

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), not restated.

- $n=2m$, $V=\mathbb R^n=V_1\oplus V_2$ with $\dim V_i=m$; $B_1=\{e_a\}_{a\le m}$, $B_2=\{e_b\}_{b>m}$. $g_p$, $g_q$ are the metrics of the two factors, i.e. the orthogonal projectors onto $V_1$, $V_2$ read as symmetric $2$-tensors, and $g=g_p+g_q$.
- Kulkarni–Nomizu: $(A\owedge B)_{ijkl}=A_{ik}B_{jl}+A_{jl}B_{ik}-A_{il}B_{jk}-A_{jk}B_{il}$, and $\mathrm{KN}(h)=\tfrac12(h\owedge g)$, the record's own projector convention at [findings/nondegeneracy.md:375](../findings/nondegeneracy.md).
- **The pair matrix.** For a curvature operator diagonal on coordinate $2$-planes, the only sense of "diagonal" this record uses, per [conventions.md](../findings/conventions.md), write $w_{ij}$ for its eigenvalue on $e_i\wedge e_j$. [findings/problem.md:30](../findings/problem.md) fixes $W(e_i\wedge e_j)=w_{ij}\,e_i\wedge e_j$ with Weyl $\iff\sum_iw_{ij}=0$, so $w_{ij}=R_{ijij}$.
- **The Frobenius norm.** [conventions.md](../findings/conventions.md) gives "the $\Lambda^2$ and $n\times n$ Frobenius pairings differ by a factor $2$", i.e. $\lVert W\rVert^2=\sum_{i<j}w_{ij}^2$. **I pinned this independently rather than taking it**, see §1.1, because claim 2 is the one display in the lemma that is convention-dependent, and a factor $2$ there would move the supremum by $\sqrt2$.
- $\lVert\cdot\rVert_{op}$ is the operator norm on $\Lambda^2V$; for a coordinate-diagonal tensor it is $\max_{i<j}\lvert w_{ij}\rvert$. It carries the same global scale as $\lVert\cdot\rVert_F$, so the ratio in claims 4–5 is convention-free even though claim 2 is not.
- $h\in S^2_0(\mathbb R^m)$ is supported on $V_1$ and traceless there: $\sum_{a\le m}h_a=0$ in a frame diagonalising it.

## The hypothesis inventory

### What the statement carries

| hypothesis | stated? | used? |
| --- | --- | --- |
| $H$ is the Weyl image of $h\in S^2_0(\mathbb R^m)$, i.e. $H=P_{\mathcal W}(h\owedge g_q)$ | stated | used, it is the content |
| $n=2m$ | stated | **used**, and load-bearing: it turns the projector's $\frac2{n-2}$ into $\frac1{m-1}$ and so produces $\beta=\frac m{2(m-1)}$ |
| $\lVert H\rVert_F=1$ | stated | used for claims 4 and 5 only; **not** used by either display, both of which are homogeneous in $h$ |
| $m\ge3$ | **NOT stated** | **used**, silently, at three separate steps (§6) |
| $m\ge4$, so that $W^*$ is one of [Lemma L27](../findings/nondegeneracy.md)'s nondegenerate points | not stated | not used by the algebra; needed for the *setting* |
| $m\ge5$ | stated, in the order-level block only | used there, correctly (§6.2) |
| $n$ even | implied by $n=2m$, never said | see §6.3 |

### What the proof imports, each checked against the object it is applied to

| import | its hypotheses | checked at $h\owedge g_q$? |
| --- | --- | --- |
| the record's Weyl projector $P(X)=Y-\frac2{n-2}\mathrm{KN}(\rho_0)-\frac1{n(n-1)}s\,\mathrm{KN}(g)$, $Y=X-\mathrm{Alt}(X)$, from [nondegeneracy.md:375](../findings/nondegeneracy.md) | $X$ an algebraic curvature operator; $\rho_0$ its trace-free Ricci, $s$ its scalar curvature | **YES.** $h\owedge g_q$ is a KN product of symmetric $2$-tensors, so first Bianchi holds and $\mathrm{Alt}(X)=0$, $Y=X$. $\mathrm{Ric}=m\,h$ is trace-free, so $s=0$ and the third term drops. Both hypotheses met; **and I verified the output is genuinely Weyl** rather than trusting the projector, §1 |
| $\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$, the sentence the correction turns on | none beyond $\mathrm{tr}\,h=0$ and $h g_q=0$ | **YES**, §1, exact |
| [Lemma L27](../findings/nondegeneracy.md), for "the margin maximum is on the two $S^2_0(\mathbb R^m)$ summands" and $L_e=\lambda_m$ there | $p,q\ge3$ and $(p,q)\ne(3,3)$; at $p=q=m$ this is $m\ge4$ | **checked, and it is not stated in L146.** L146's own $m\ge5$ is stronger, so nothing downstream is harmed; but the setting is false as written at $m=3$ |
| the identification of $\{P_{\mathcal W}(h\owedge g_q)\}$ with L27's $S^2_0(\mathbb R^p)$ summand | multiplicity-freeness of the ten-summand decomposition | **not argued on file.** It follows from equivariance plus L27's own multiplicity-freeness (§2.2). The choice of $g_q$ over $g_p$ is immaterial: $P_{\mathcal W}(h\owedge g)=0$, so the two differ by a sign |

### Unused hypotheses, reported because silence is not a verdict

**The whole Setting paragraph is context, not hypothesis.** Neither display uses that $L_e$ is the scalar $\lambda_m$, nor that the margin equals $c_p=3\theta_0/(n-2)$, nor [Lemma L145](../findings/second-order.md)'s $g_n$. The two formulas are pure linear algebra about the Weyl image. This is a finding in the *favourable* direction: the lemma's algebra is independent of everything spectral around it, so a later correction to L27's eigenvalues would leave claims 1–5 standing.

*A margin identity I checked in passing, and it is exact.* $\tfrac12-\lambda_m=\tfrac12-\frac{m-2}{2(m-1)}=\frac1{2(m-1)}=\frac1{n-2}$, so $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ as the Setting says. **CONFIRMED.**

## 1. The corrected embedding, claim 1, re-derived

For $A,B$ diagonal in a common frame, $(A\owedge B)_{ijij}=a_ib_j+a_jb_i$ and every other component with $\{i,j\}\ne\{k,l\}$ vanishes, so $A\owedge B$ is coordinate-diagonal with $w_{ij}=a_ib_j+a_jb_i$. Also
$$\mathrm{Ric}(A\owedge B)=(\mathop{\mathrm{tr}}A)B+(\mathop{\mathrm{tr}}B)A-AB-BA .$$

**The pre-projection object.** $\mathrm{Ric}(h\owedge g_q)=0\cdot g_q+m\,h-0-0=m\,h\ne0$: the entry's opening sentence, confirmed. Its pair matrix is $h_a$ on cross planes and $0$ on both in-block families, which is exactly the eigenvalue list the entry attributes to the withdrawn first version. **The entry's diagnosis of its own earlier error is correct.**

**The projection.** $\mathrm{Alt}=0$ and $s=0$, so with $\rho_0=m\,h$,
$$H=P_{\mathcal W}(h\owedge g_q)=h\owedge g_q-\tfrac2{n-2}\cdot\tfrac12\big(m\,h\owedge g\big)=h\owedge g_q-\tfrac m{2(m-1)}\,h\owedge g .$$
Splitting $g=g_p+g_q$ and writing $\beta=\frac m{2(m-1)}$, $\alpha=1-\beta=\frac{m-2}{2(m-1)}$,
$$H=\alpha\,(h\owedge g_q)-\beta\,(h\owedge g_p).$$
Reading off the pair matrix: $h\owedge g_q$ gives $h_a$ on $e_a\wedge e_b$ and $0$ elsewhere; $h\owedge g_p$ gives $h_a+h_{a'}$ on $e_a\wedge e_{a'}$ and $0$ elsewhere. Hence
$$w_{ab}=\alpha h_a\ (a\in B_1,b\in B_2),\qquad w_{aa'}=-\beta(h_a+h_{a'}),\qquad w_{bb'}=0 .$$
**CONFIRMED, exactly as displayed, including both constants.** That $\alpha=\lambda_m$ is a coincidence of the two contexts, not an input.

**Two independent checks that the object is a Weyl tensor**, which the entry does not perform:
- $\mathrm{Ric}(H)=\alpha\,mh-\beta\,(m-2)h=\frac{m(m-2)}{2(m-1)}h-\frac{m(m-2)}{2(m-1)}h=0$.
- Row sums: for $a\in B_1$, $-\beta\big[(m-1)h_a+(-h_a)\big]+m\alpha h_a=h_a\big[-\beta(m-2)+m\alpha\big]=0$; for $b\in B_2$, $\alpha\sum_ah_a=0$. Tracelessness of $h$ is used in both.

### 1.1 Pinning the Frobenius convention, since claim 2 depends on it

Claim 2 changes by a factor $2$ under the two normalisations the record has confused before, so I fixed it against an object with an independently recorded value rather than against the convention file alone. $S^m\times S^m$ has sectional curvature $1$ in-block and $0$ on cross planes, so $\mathrm{Ric}=(m-1)\mathrm{Id}$, $\rho_0=0$, $s=n(m-1)$, and $\mathrm{KN}(g)$ is the identity on every plane. Hence
$$W^*=\frac m{2m-1}\ \text{in-block},\qquad -\frac{m-1}{2m-1}\ \text{on cross planes},$$
row sums zero. Under $\lVert W\rVert^2=\sum_{i<j}w_{ij}^2$,
$$\lVert W^*\rVert^2=2\binom m2\frac{m^2}{(2m-1)^2}+m^2\frac{(m-1)^2}{(2m-1)^2}=\frac{m^2(m-1)}{2m-1},$$
so the normalised negative eigenvalue has modulus $\dfrac{m-1}{2m-1}\cdot\dfrac{\sqrt{2m-1}}{m\sqrt{m-1}}=\dfrac{\sqrt{m-1}}{m\sqrt{2m-1}}$.

[Lemma L145](../findings/second-order.md) records $g_n=\lvert\lambda_-\rvert=\frac2n\sqrt{\frac{n-2}{2(n-1)}}$, which at $n=2m$ is $\frac1m\sqrt{\frac{m-1}{2m-1}}=\frac{\sqrt{m-1}}{m\sqrt{2m-1}}$. **Exact match.** The convention is $\lVert W\rVert^2=\sum_{i<j}w_{ij}^2$, and claim 2 is stated in it. *This also confirms $\ker W^*=0$, which is [Lemma L149](../findings/second-order.md)'s stated hypothesis, both eigenvalues are non-zero at every $m\ge2$.*

## 2. The Frobenius identity, claim 2

$$\lVert H\rVert_F^2=\underbrace{\sum_{a\in B_1}\sum_{b\in B_2}\alpha^2h_a^2}_{=\,m\alpha^2\lVert h\rVert^2}+\beta^2\sum_{a<a'}(h_a+h_{a'})^2+0 .$$
For the second sum, tracelessness gives $\sum_{a\ne a'}2h_ah_{a'}=2\big[(\textstyle\sum h_a)^2-\lVert h\rVert^2\big]=-2\lVert h\rVert^2$, so
$$\sum_{a<a'}(h_a+h_{a'})^2=\tfrac12\big[(m-1)\lVert h\rVert^2+(m-1)\lVert h\rVert^2-2\lVert h\rVert^2\big]=(m-2)\lVert h\rVert^2 .$$
Therefore, with $D=4(m-1)^2$,
$$\lVert H\rVert_F^2=\big[m\alpha^2+(m-2)\beta^2\big]\lVert h\rVert^2=\frac{m(m-2)\big[(m-2)+m\big]}{D}\lVert h\rVert^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2 .$$
**CONFIRMED exactly.** Note the identity is what makes $\lVert H\rVert_F=0$ at $m=2$, see §6.1.

### 2.1 A wording defect in the statement, argued the other way and kept as a note only

*Located:* the statement carries "$\lVert H\rVert_F=1$" as a hypothesis and then displays a formula **for** $\lVert H\rVert_F^2$. *Charitable reading, which the words support:* the first display is the homogeneity relation, and the hypothesis fixes $\lVert h\rVert^2=\frac{2(m-1)}{m(m-2)}$, which is how claims 4 and 5 must be read for them to be true. Under that reading everything is consistent, and [Lemma L149](../findings/second-order.md) relies on exactly this homogeneity ("which is homogeneous so $\lVert H_s\rVert_F<1$ only helps"), correctly, both displays being homogeneous of degree $1$ in $h$. **Reported as presentation, not as a defect.**

### 2.2 The step that identifies the image with L27's summand, unargued, and repairable from L27's own input

*Located:* "the Weyl image of $h\in S^2_0(\mathbb R^m)$", the entry never says why $P_{\mathcal W}(h\owedge g_q)$ **is** L27's $S^2_0(\mathbb R^p)$ summand rather than some vector meeting it. *Argued the other way:* the map is linear, $O(m)\times O(m)$-equivariant with $O(m)$ acting on $h$ and on $V_1$, and injective for $m\ge3$ by §2; L27's decomposition is multiplicity-free for all $p,q\ge3$, so by Schur the image is that summand. The alternative $g_p$ gives the same image, since $P_{\mathcal W}(h\owedge g)=0$, check: $\mathrm{Ric}(h\owedge g)=(n-2)h$, so $P_{\mathcal W}(h\owedge g)=h\owedge g-\frac2{n-2}\cdot\frac12(n-2)(h\owedge g)=0$. **The step is sound but is not on file; two sentences would close it.**

## 3. The operator norm, claim 3, the pointwise identity

$H$ is coordinate-diagonal, so $\lVert H\rVert_{op}=\max_{i<j}\lvert w_{ij}\rvert=\max\Big\{\alpha\max_a\lvert h_a\rvert,\ \beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\Big\}$. The displayed formula is the second branch alone, so the identity holds **iff** the in-block branch dominates pointwise. That is claim 3's "always winning", and it has no argument in the entry.

## 4. The in-block dominance, the one real gap in the written argument, and what closes it

*Located:* "the in-block branch always winning", [second-order.md:1137](../findings/second-order.md). *What it needs and lacks:* an inequality comparing $\max_a\lvert h_a\rvert$ with $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$ over traceless $h$. Nothing on the record supplies one; the entry states the conclusion.

**The inequality, derived here from the tracelessness that is already a hypothesis.** Replacing $h$ by $-h$ changes neither side, so take the largest-modulus entry to be positive and call it $h_1=\max_a\lvert h_a\rvert$. Put $s=\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$. Then $h_1+h_a\le s$ for every $a\ne1$, i.e. $h_a\le s-h_1$, and summing against $\sum_ah_a=0$,
$$0=h_1+\sum_{a\ge2}h_a\le h_1+(m-1)(s-h_1)\quad\Longrightarrow\quad s\ \ge\ \frac{m-2}{m-1}\,h_1 .$$
Since $\alpha/\beta=\frac{m-2}m<\frac{m-2}{m-1}$ for every $m\ge3$,
$$\beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ \ge\ \beta\,\frac{m-2}{m-1}\max_a\lvert h_a\rvert\ >\ \alpha\max_a\lvert h_a\rvert\qquad(h\ne0).$$
**Claim 3 CONFIRMED, strictly, at every $m\ge3$.** The bound $\frac{m-2}{m-1}$ is sharp for $m\ge4$, at the spike $h\propto(m-1,-1,\dots,-1)$; at $m=3$ the ratio is $1$, since there $h_a+h_{a'}=-h_{a''}$ makes the two maxima equal.

*Exhibited concretely at $m=4$, where the gap is narrowest:* $h=(3,-1,-1,-1)$ has $\max_a\lvert h_a\rvert=3$ but $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert=2$, so the naive reading "the pair sum is at least the largest entry" is **false**; the correct comparison is the one weighted by $\alpha$ and $\beta$, giving $\beta\cdot2=\tfrac43$ against $\alpha\cdot3=1$. **This is precisely the object that would falsify claim 3 if $\alpha$ and $\beta$ were equal, and it is why the claim is not obvious.**

## 5. The supremum and the range, claims 4 and 5

### 5.1 The supremum, exactly

Maximising $h_1+h_2=\langle h,e_1+e_2\rangle$ over traceless unit $h$ gives the norm of the traceless part of $e_1+e_2$, namely $\sqrt{2-4/m}=\sqrt{2(m-2)/m}$. So $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert=\sqrt{2(m-2)/m}\,\lVert h\rVert$, and with $\lVert h\rVert^2=\frac{2(m-1)}{m(m-2)}$ from claim 2,
$$\lVert H\rVert_{op}=\frac m{2(m-1)}\sqrt{\frac{2(m-2)}m}\sqrt{\frac{2(m-1)}{m(m-2)}}=\frac m{2(m-1)}\cdot\frac2m\sqrt{m-1}=\frac1{\sqrt{m-1}} .$$
**CONFIRMED, and it is attained**, the maximiser is $h\propto(m-2,m-2,-2,\dots,-2)$, the "pair-concentrated $h$" the entry names, so "supremum" is in fact a maximum.

*Hand check at the smallest admissible dimension, $m=3$.* $h\propto(1,1,-2)$ normalised to $\lVert h\rVert^2=\tfrac43$ is $h=\frac{\sqrt2}3(1,1,-2)$; $\beta=\tfrac34$; $\max\lvert h_a+h_{a'}\rvert=\tfrac{2\sqrt2}3$; product $\tfrac34\cdot\tfrac{2\sqrt2}3=\tfrac{\sqrt2}2=1/\sqrt2=1/\sqrt{m-1}$. ✓

### 5.2 The lower end, and the reconciliation of the two reviewer figures the entry leaves open

From §2, $\sum_{a<a'}(h_a+h_{a'})^2=(m-2)\lVert h\rVert^2$ over $\binom m2$ planes, so
$$\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ \ge\ \lVert h\rVert\sqrt{\frac{2(m-2)}{m(m-1)}},\qquad\text{hence}\qquad \lVert H\rVert_{op}\ \ge\ \frac m{2(m-1)}\cdot\frac2m=\frac1{m-1},$$
the $\lVert h\rVert$ cancelling exactly against the normalisation. **This is r448's $1/(m-1)$, and it is a theorem.** The even split $h\propto(1,\dots,1,-1,\dots,-1)$ gives
$$\lVert H\rVert_{op}=\frac1{m-1}\sqrt{\frac{2(m-1)}{m-2}}\ \longrightarrow\ \frac{\sqrt2}{m-1},$$
**which is r449's $\approx\sqrt2/m$.** So the two figures were never in conflict: one is a lower bound over the whole summand and the other is the value at one $h$, and they bracket the minimum within a factor $\sqrt2$. Both are $\Theta(n^{-1})$ and the upper end is $\Theta(n^{-1/2})$ by §5.1, so **claim 5 is CONFIRMED as an order.** *The interval is asymptotic and is nearly invisible at the dimensions in play: at $n=12$ the two ends are $0.2$ and $1/\sqrt5=0.447$.*

### 5.3 Claim 6 overreaches, the even split is refuted as minimiser only at $m\le7$

*Located:* "the claimed minimiser (the even split) is wrong in either reading", [second-order.md:1139](../findings/second-order.md). *Exhibited, in closed form, at $m=6$ ($n=12$):* take $h\propto(1,-1,0,0,0,0)$, traceless, supported on a $2\times2$ sub-block. Then $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert/\lVert h\rVert=1/\sqrt2$, and
$$\lVert H\rVert_{op}=\tfrac12\sqrt{\frac m{(m-1)(m-2)}}=\tfrac12\sqrt{\tfrac6{20}}=\frac{\sqrt{30}}{20}=0.2738613\ <\ \frac1{\sqrt{10}}=0.3162278,$$
the last being the even split's value at $m=6$. The spike $h\propto(5,-1,-1,-1,-1,-1)$ also beats it, at $\frac{\sqrt{2(m-2)}}{2(m-1)}=\frac{\sqrt2}5=0.2828427$. **So the even split is not the minimiser at $n=12$, and the entry is right there.**

*Argued the other way, and this is where the claim fails.* Maximising $\lVert h\rVert$ subject to $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\le1$ over two-valued $h$ with $p$ entries positive: $p=1$ gives $\lVert h\rVert^2=\frac{m(m-1)}{(m-2)^2}$, and $p=q=m/2$ gives $\lVert h\rVert^2=m/4$, with every other split strictly worse than the balanced one. The spike beats the even split exactly when $4(m-1)>(m-2)^2$, i.e. $m<4+2\sqrt2=6.828$. **At $m\ge8$ the even split beats every competitor I constructed**, and the entry offers no witness against it there. Since $\lVert h\rVert^2\le\frac{m(m-1)}{2(m-2)}$ from §5.2, the even split is within $\sqrt2$ of optimal at every $m$, so no witness can be far away, but "wrong in either reading" is a universal claim and it is unproven above $m=7$. **Verdict: CONFIRMED AS STATED ONLY AT $m\le7$**; the sentence should carry that range.

*A structural remark that falls out and is worth the record's while:* the low end of the range is reached by $h$ with a **large kernel**, $h=(1,-1,0,\dots,0)$ has $m-2$ zero entries. A check run on generic or spike-like $h$ never reaches those, which is the same shape as this record's standing $\ker W\ne0$ trap, one level down.

## 6. Every range boundary, answered

### 6.1 $m=2$ ($n=4$), the statement is vacuous and its supremum is a supremum of nothing

At $m=2$, $\alpha=0$ and $h=(t,-t)$ gives $h_1+h_2=0$, so **every** entry of the pair matrix vanishes: $H\equiv0$. Claim 2 says the same, $\frac{m(m-2)}{2(m-1)}=0$. The hypothesis $\lVert H\rVert_F=1$ is then unsatisfiable, the domain is empty, and "supremum $1/\sqrt{m-1}=1$" is asserted over the empty set. *Argued the other way:* the Setting fixes $W^*=S^m\times S^m$ and the downstream blocks say $m\ge5$, so nothing on the record consumes $m=2$, [post F60](../findings/second-order.md) at line 1409 makes exactly this point. **Verdict: `HYPOTHESIS-DEBT`, small, the statement needs "for $m\ge3$" written into it**, and it is the one dimension where a reader could take a true-looking sentence off the record and have it be false.

### 6.2 The $m\ge5$ clause, CONFIRMED exactly

The order-level block claims $m\ge5$ is where $\lambda_m>\mu$ puts the margin on this summand. From [Lemma L27](../findings/nondegeneracy.md), $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, so at $p=q=m$,
$$\tfrac12-\mu=\frac{(m-1)(m-3)}{2(m-1)^2}=\frac{m-3}{2(m-1)},\qquad \mu=\frac1{m-1},$$
and $\lambda_m>\mu\iff\frac{m-2}{2(m-1)}>\frac1{m-1}\iff m>4$. **CONFIRMED, exactly.** At $m=4$ the two are equal ($\lambda_4=\mu=\tfrac13$), so the margin is *tied* rather than lost, the summand still carries a binding margin there, which is the charitable reading, and the entry's strict "$\lambda_m>\mu$" is the honest one. "$n\ge12$ is inside that" is correct, $n\ge12\Rightarrow m\ge6$. *Consistency check against [Lemma L149](../findings/second-order.md), which sharpens the chain's range to $m\ge6$ for an unrelated reason ($\rho^{\mathrm{eff}}$ undefined at $n=10$): the two ranges are compatible and $m\ge6$ is the binding one downstream.*

### 6.3 Odd $n$, the statement is empty, and this is nowhere said

$n=2m$ admits no odd $n$, and $S^m\times S^m$ exists only at even $n$; [conventions.md](../findings/conventions.md) records that at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$ and is a different object. **So L146 supplies nothing at odd $n$**, and any chain quantified over "$n\ge12$" that draws on it is silently restricted to even $n$. *Argued the other way:* [VERIFY_v14](VERIFY_v14.md) and [Lemma L149](../findings/second-order.md)'s uniformity proof both say "over even $n\ge12$", so the consumers are aware. **No defect; recorded because the lemma itself never says "even".**

### 6.4 $\ker W\ne0$, this record's recurring obstruction, answered at a padded object

Two distinct kernels have to be separated here.

- **$\ker W^*=0$**, computed in §1.1: the eigenvalues are $\frac m{2m-1}>0$ and $-\frac{m-1}{2m-1}<0$, so the trap does not bite at $W^*$ itself. This is [Lemma L149](../findings/second-order.md)'s stated hypothesis and it holds.
- **$\ker H\ne0$ always**, and by a lot: $H$ annihilates all of $\Lambda^2V_2$, a subspace of dimension $\binom m2=\Theta(n^2)$, and further annihilates every cross plane over $\{a:h_a=0\}$. **Claim 3 is untouched by this**, it is a max over a diagonal, and zeros do not compete. But any downstream step that converts between $\lVert H\rVert_{op}$ and $\lVert H\rVert_F$ by rank would be wrong to use $\binom n2$: the effective rank is at most $\binom n2-\binom m2$. I found no step doing so; [Lemma L145](../findings/second-order.md)'s "where the norm is spent" paragraph converts on $W_-$, not on $H$.
- **The padded object, which is what the trap asks for.** Pad $W^*$ from $\mathbb R^{2m}$ into $\mathbb R^{n'}$, $n'>2m$. Then $w_{ij}=0$ whenever $i$ or $j$ is a padding index, so $\ker W\ne0$ with dimension $\binom{n'}2-\binom{2m}2>0$, and $W\mapsto W_-$ loses analyticity at the zero-crossing, which is [Lemma L149](../findings/second-order.md)'s own stated hypothesis, failing. **What the statement says at a padded object is: nothing.** Its projector coefficient $\frac2{n'-2}$ would also change, so $\alpha$ and $\beta$ are not the padded values. *Argued the other way:* the Setting fixes "$W^*=S^m\times S^m$" with $n=2m$, so padding is out of scope by construction and no citation I found reaches for it. **Withdrawn as a defect; recorded as a scope boundary a successor must respect.**

### 6.5 A claim proven on a subfamily and cited in general

**The record already caught this once and the flag is correct.** [second-order.md:1167](../findings/second-order.md) records: "Lemma L146 bounds one summand; the chain's $\lVert A''\rVert$ ranges over all ten of Lemma L27's", with the counterexample direction being a mixed one. I confirm the quantifier reading: L146 is a statement about **one** of ten summands at **one** point, and it says nothing about the other nine. [Lemma L148](../findings/second-order.md) then removes even that, the defect being identically zero on this summand.

### 6.6 A universal claim with no witness, one object from each structured family the record names

The lemma's domain is a single point $W^*$ and a single summand, so the record's catalogue families are outside its scope by construction: **diagonal**, $W^*$ and every $H$ here are coordinate-diagonal, so the whole lemma lives inside the diagonal class and the family is the domain rather than a test of it; **sphere products**, $W^*$ is one, and it is the only one the lemma addresses, unbalanced $S^p\times S^q$ carrying $\lambda_p\ne\lambda_q$ and two different $\beta$'s; **padded**, §6.4, out of scope and would break the consumer's hypothesis; **subalgebra-Casimir**, [nondegeneracy.md:389](../findings/nondegeneracy.md) records that the only $S=0$ member is the balanced product itself, overlap $1.000000000$, so the family adds no new object here; **$\mathbb{CP}^m$** and **tori**, not critical points of the two-block form and carrying no $S^2_0(\mathbb R^m)\oplus S^2_0(\mathbb R^m)$ pair, so the statement is not defined at them. **The families I could test are the structured $h$'s inside the summand, and I tested four**: pair-concentrated (§5.1, the maximiser), spike (§4 and §5.3), even split (§5.3), and sub-block-supported (§5.3, the best minimiser I found at $m=6$). All obey claims 3 and 4; the fourth refutes claim 6's universality at $m\ge8$ only by its absence, not by its value.

## 7. What the lemma gives downstream, and where it gives less

### 7.1 $\lVert H_s\rVert_{op}\le a_0n^{-1/2}$ with $a_0=\sqrt{2n/(n-2)}$, the written statement gives this, exactly

$$\frac1{\sqrt{m-1}}=\sqrt{\frac2{n-2}}=\sqrt{\frac{2n}{n-2}}\cdot n^{-1/2}=a_0n^{-1/2}.$$
**CONFIRMED, and it is sharp**, being attained at the pair-concentrated $h$. The form [Lemma L149](../findings/second-order.md) uses, $a_0n^{1/2}+nw=n(\lVert H_s\rVert^{\mathrm{bd}}_{op}+w)$, follows since $n\cdot\frac1{\sqrt{m-1}}=n^{1/2}\sqrt{2n/(n-2)}$. *This is the one downstream consumer that L146 supports exactly as written.*

### 7.2 The joint two-copy eigenspace, the written statement gives strictly LESS

*Located:* the statement quantifies over "$H$ the Weyl image of $h\in S^2_0(\mathbb R^m)$", singular. [Lemma L149](../findings/second-order.md) writes $H_s$ for the element of the **joint** $\lambda_m$-eigenspace, "both copies", and applies L146's bound to it. **A general $H_s$ is not the Weyl image of any single $h$**, so the statement as written does not cover the object it is applied to.

*What is actually true, which I verified rather than assumed.* Write $H_s=H(h)+H'(k)$ with $k\in S^2_0$ on $V_2$; $H'(k)$ is $\alpha k_b$ on $e_a\wedge e_b$, $-\beta(k_b+k_{b'})$ in-$B_2$, $0$ in $B_1$. The sum is still coordinate-diagonal, in a frame diagonalising $h$ on $V_1$ and $k$ on $V_2$ independently, with
$$w_{ab}=\alpha(h_a+k_b),\qquad w_{aa'}=-\beta(h_a+h_{a'}),\qquad w_{bb'}=-\beta(k_b+k_{b'}).$$
Frobenius: the cross term $\sum_{a,b}2h_ak_b$ vanishes by tracelessness, so $\lVert H_s\rVert_F^2=\frac{m(m-2)}{2(m-1)}(\lVert h\rVert^2+\lVert k\rVert^2)$, the two images are orthogonal, no $\sqrt2$ is owed. The two in-block branches are then each bounded by $\frac1{\sqrt{m-1}}$ by §5.1 applied at $\lVert h\rVert\le$ the joint norm. The cross branch is new, and its exact maximum is
$$\alpha\max_{a,b}\lvert h_a+k_b\rvert=\alpha\sqrt{\tfrac{m-1}m}\big(\lVert h\rVert+\lVert k\rVert\big)\Big|_{\max}=\frac{m-2}{2(m-1)}\cdot\frac{2(m-1)}{m\sqrt{m-2}}=\frac{\sqrt{m-2}}m,$$
and $\frac{m-2}{m^2}<\frac1{m-1}$ for every $m$, so the cross branch never binds. **The joint maximum is $1/\sqrt{m-1}$, unchanged, attained at $k=0$.**

*Argued the other way, and this is the reason the verdict is on the citation rather than on the mathematics.* The extension is on the record, at [ROUND_L149.md:27](ROUND_L149.md) and again at [second-order.md:1191](../findings/second-order.md), crediting r716 with exactly the figure $\sqrt{m-2}/m=0.333$ against $1/\sqrt{m-1}=0.447$ at $n=12$, **which I reproduce exactly and which is the sharp value, not a bound.** So the chain is sound. **Verdict: `REFUTED AS STATED` for L146 as the citation, `CONFIRMED` for the mathematics.** *What is owed is one sentence in L146 extending the statement to the joint eigenspace, so that L149's citation reaches an object the lemma names.*

### 7.3 The order-level conclusion, and the fact that L148 makes it moot

$g_n/\lVert H\rVert_{op}\ge\Theta(n^{-1})/\Theta(n^{-1/2})=\Theta(n^{-1/2})$, a factor $\sqrt n$ above $g_n$: **CONFIRMED** as arithmetic, and the disc is $\Theta(\min(1,g_n/\lVert H\rVert_{op}))$ with the min taken by the second argument, correctly. The entry's own closing blocks then withdraw its consequence twice over, it meets only the $o(1)$ wording of r446's test rather than r446's mechanism, and [Lemma L148](../findings/second-order.md) has the defect vanishing identically on this summand, so the priced quantity is absent. **Both withdrawals are correct and I confirm the second directly**: §1 shows $W^*$ and $H$ are simultaneously coordinate-diagonal, hence so is $W^*+tH$ and hence so is its negative part, so $\mathrm{Alt}(W(t)_-)=0$ for every $t$. **What survives with content is §7.1 (the constant $a_0$) and nothing else.**

## 8. Withdrawn candidates

- **"$\lVert H\rVert_F^2$ is stated in the wrong normalisation."** *Withdrawn.* I pinned the record's Frobenius convention independently against [Lemma L145](../findings/second-order.md)'s $g_n$ (§1.1) and the displayed constant is right in it. A factor $2$ here would have moved the supremum by $\sqrt2$ and broken $a_0$; it does not.
- **"The projector's coefficients are only numerically verified, so claim 1 rests on numerics."** *Withdrawn.* [nondegeneracy.md:375](../findings/nondegeneracy.md) does lean on a numerical check, which is not evidence, but I did not use it: I verified at the object that $P_{\mathcal W}(h\owedge g_q)$ is Ricci-flat and Bianchi and that the discarded piece $\frac m{n-2}(h\owedge g)$ lies in the $\mathrm{KN}$ image, which is the orthogonal complement of Weyl in the classical decomposition. The application is sound independently of the check.
- **"The choice of $g_q$ rather than $g_p$ is unjustified and could change the answer."** *Withdrawn:* $P_{\mathcal W}(h\owedge g)=0$, so the two differ by a sign and no norm moves (§2.2).
- **"A $\sqrt2$ is owed on the two-copy eigenspace."** *Withdrawn*, the two images are Frobenius-orthogonal and the cross branch is strictly sub-dominant (§7.2). *Recorded because it is the natural first suspicion and the entry is silent about it.*
- **"$\ker H\ne0$ breaks the operator-norm claim."** *Withdrawn:* the norm is a max over a diagonal and the $\binom m2$ zeros never compete. It would matter only to a rank-based conversion, and no step performs one on $H$.

## 9. What would break it, and what I did to look

**The falsifiers, named.** *(a)* A traceless $h$ with $\alpha\max_a\lvert h_a\rvert>\beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, which would refute claim 3's pointwise identity. *(b)* A traceless $h$ with $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert>\sqrt{2(m-2)/m}\,\lVert h\rVert$, which would break the supremum $1/\sqrt{m-1}$ and with it $a_0$. *(c)* A pair $(h,k)$ on the joint eigenspace with $\alpha\max_{a,b}\lvert h_a+k_b\rvert>1/\sqrt{m-1}$, which would break L149's citation even under the corrected reading. *(d)* An $h$ with $\lVert H\rVert_{op}=o(1/m)$, which would break the $\Theta(n^{-1})$ end of the range.

**What I did.** (a) is impossible by the trace inequality of §4, which is sharp, so no witness exists at any $m\ge3$; I tested the tightest case $m=4$ by hand and the margin is $\tfrac43$ against $1$. (b) is impossible by Cauchy–Schwarz against the traceless projection of $e_1+e_2$, and the maximiser is exhibited. (c) is impossible: the cross branch's exact maximum is $\sqrt{m-2}/m$, and $(m-2)(m-1)<m^2$ at every $m$. (d) is impossible by the averaging bound $\lVert H\rVert_{op}\ge\frac1{m-1}$. **I found no falsifier for claims 1–5, 7 or 8's mathematics.** The one live falsifier is against **claim 6**, and it is the absence of one: at $m\ge8$ the even split beats the spike and every other configuration I could construct, so the entry's "the even split is wrong in either reading" has no witness above $m=7$ and should carry that range.

## Verdict

**`PROVEN, hypotheses corrected`**, with one clause cut back and one citation refuted.

- **Corrected hypotheses:** add $m\ge3$ to the statement (§6.1); note that the setting's appeal to [Lemma L27](../findings/nondegeneracy.md) needs $m\ge4$ and its margin claim $m\ge5$ (§6.2); note that $n$ is even throughout (§6.3).
- **The gap in the written argument** is the in-block dominance, asserted with no proof; §4 supplies the inequality it needs, from hypotheses the lemma already carries.
- **Cut back:** "the claimed minimiser (the even split) is wrong in either reading" holds at $m\le7$ and is unproven at $m\ge8$ (§5.3).
- **Refuted as a citation:** L146 prices one $S^2_0(\mathbb R^m)$ copy; [Lemma L149](../findings/second-order.md) applies it to the joint two-copy eigenspace. The extension is true and already on the record elsewhere, but the lemma does not state it (§7.2).
- **What the lemma actually supports downstream** is the constant $a_0=\sqrt{2n/(n-2)}$, exactly and sharply. Its order-level conclusion is real arithmetic whose consequence the entry itself withdraws twice, the second time by [Lemma L148](../findings/second-order.md), which I confirm directly.
