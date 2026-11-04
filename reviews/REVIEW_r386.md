# Review r386, Gate 2 (twin B) on the last three sections of ATTEMPTS.md

*2026-09-02. Adversarial review, derived cold from the definitions before the author's text was opened. **Analysis only**, no computation was approved for this task; the numbers below are screens on objects built for the screen (closed-form sphere-product matrices), reported as screens and never as evidence for a positive claim. Every algebraic verdict is exact algebra done by hand and stated as such. Log: [agent_logs/gate2-twin-B.log](../agent_logs/gate2-twin-B.log).*

## Verdict table

| # | Claim (section, line) | Verdict |
|---|---|---|
| 1 | $\theta^2=2-\tfrac3m+\tfrac1{m^2}$, $\theta\alpha=\tfrac1m$, $\alpha^2=\tfrac1{(m-1)(2m-1)}$, $\gamma^2=\tfrac{m-1}{m^2(2m-1)}$ (L3325) | **CONFIRMED**, all four re-derived cold |
| 2 | $T^2-\tfrac{2E}D=\tfrac3{m(2m-3)}+\tfrac1{m^2}+\tfrac1{(m-1)(2m-1)}>0$ (L3329) | **CONFIRMED** exactly, for every $m\ge2$ |
| 3 | The two displayed equivalences reducing $L\le T$ to that comparison (L3320–3322) | **CONFIRMED**, but the first needs an **unstated sign hypothesis** $DT+2M_{jk}\ge0$, see §3 |
| 4 | "the trace bound clears at every balanced product" | **CONFIRMED** |
| 5 | "an explicit $O(1/m^2)$ margin, the item's remaining question is no longer *does the instrument survive $n\to\infty$*" | **CORRECTED.** The margin is $O(1/m^2)$ **against a true slack of $O(1/m)$**: the bound keeps a fraction $\tfrac3{2m}\to0$ of the available room |
| 6 | "the trace bound on $\mathbf1^\perp$ is a **different instrument** from $(\dagger)$, and a better one here" (L3304) | **REFUTED.** It is $(\dagger)$ with the $\mathbf1$-direction deleted, $d\to d-1$. At $S^5\times S^{40}$ it beats $(\dagger)$ by $0.00077$, i.e. $0.06\%$, and the two have the *same* $n\to\infty$ condition |
| 7 | "$S^5\times S^{40}$ … is one of [r382](REVIEW_r382.md)'s seven $(\dagger)$ failures" (L3312) | **REFUTED as written**, a label collision. $(\dagger)$ as *defined* (L3152) gives $1.32266<T=1.55058$ there and **clears** |
| 8 | "the residue named in the previous section is covered by this bound at the point that defined it" (L3312) | **CORRECTED**, true of the boxed joint estimate's residue, false of $(\dagger)$'s |
| 9 | "Does not close: the general twin pair, since $\alpha,\theta,f$ were used in their balanced-product closed forms" (L3332) | **CORRECTED, far more is open than *not yet done*.** The general computation goes through in closed form and the conclusion is **FALSE** for $p\ge q+3$. Witness: $S^8\times S^5$, pair in the $8$-block, $\theta=1.235829$ (in band), bound $1.322565>T=1.309390$ |
| 10 | The complementarity table (L3285–3288) and "together they leave one named residue" | **NOT AIRTIGHT.** The twin row needs its own two-instrument split, and the section states neither half |
| 11 | $\widetilde Nu=(\theta-M_{jk})u+u\circ u$ at a twin pair (L3302) | **CONFIRMED**, and it has three consequences the section did not take, one of them a slack ceiling that explains every tightness this line has met |
| 12 | "$u$ is an eigenvector exactly when $u\circ u\parallel u$, i.e. $u$ constant on its support" | **CONFIRMED** |
| 13 | $f=\lVert\widetilde N\rVert_F^2=2-\lVert o\rVert^2-2M_{jk}^2$, twin case $2-2M_{jk}^2$ | **CONFIRMED**, exact at every pair of every pure critical point with $\lVert M\rVert_F^2=2$ |
| 14 | [r384](REVIEW_r384.md)'s within-factor slack $\theta\big(1+\tfrac q{p-1}\big)/(n-1)$ (L3258) | **CONFIRMED**, it equals $\theta/(p-1)$, and equals my independent $a(n-1)/q$ |

## 1. What the cold derivation gives, and it is more than the section uses

Everything below is exact and was obtained before the record was opened.

**The general $S^p\times S^q$ point.** Row sums force $(p-1)a=-qc$ and $(q-1)b=-pc$, so a *single* within-factor value forces $p=q$, the unbalanced points need $a\ne b$. Criticality on a cross pair gives $\theta=-(n-1)c$; criticality on a within pair is then **implied** by the row sums and carries no new information. The Frobenius normalisation collapses:

$$2=\frac{a^2p(p-1)}{q(q-1)}\Big[q(q-1)+p(p-1)+2(p-1)(q-1)\Big],\qquad \text{and the bracket is }(n-1)(n-2)\ \textbf{at every split}.$$

Hence, with the pair inside the block of size $p$,

$$a^2=\frac{2q(q-1)}{p(p-1)(n-1)(n-2)},\qquad \theta^2=\frac{2(n-1)(p-1)(q-1)}{pq(n-2)},\qquad \theta a=\frac{2(q-1)}{p(n-2)} .$$

At $p=q=m$ these are exactly the section's three values, so claim 1 is confirmed by an independent route.

**The exact spectrum of $\widetilde N$, which the record does not have.** With $I'=$ block-$1\setminus\{j,k\}$ (size $p-2$) and block $2$ (size $q$),

| eigenvalue | multiplicity |
|---|---|
| $a$ | $p-3$ |
| $2c-b$ | $q-1$ |
| $\dfrac{(p-1)(n-2)}{q}\,a$ | $1$ |
| $0$ (the vector $\mathbf1$) | $1$ |

Total $n-2=d$; $\widetilde N\mathbf1=0$ falls out, confirming the section's premise. So

$$\lambda_{\max}(\widetilde N)=a\max\Big(1,\tfrac{(p-1)(n-2)}q\Big),\qquad T=\frac{a\big[(n-1)(p-1)+q\big]}q,\qquad \boxed{\ T-\lambda_{\max}=\frac{a(n-1)}{q}=\frac\theta{p-1}\ }$$

**positive at every split**, the pair clause is *true* at every within-factor twin pair of every sphere product, so nothing below is a counterexample to the statement, only to instruments.

**The twin Frobenius identity, derived independently.** For $u=v$ the diagonal addition $\lVert u+v\rVert^2=4\lVert u\rVert^2$ exactly cancels the $-2\lVert u\rVert^2-2\lVert v\rVert^2$ lost with rows $j,k$, so $f=2-2M_{jk}^2$. Cross-checked against the eigenvalue sum: $\sum\lambda^2=2m(2m-3)\alpha^2=2-2\alpha^2$ at the balanced point. The general form $f=2-\lVert o\rVert^2-2M_{jk}^2$ follows the same way and holds at every pair.

**The sharpest bound of the stated kind.** From trace, Frobenius and dimension alone the extremal bound is Wolkowicz–Styan, tight exactly when the $D-1$ non-maximal eigenvalues coincide. On $\mathbf1^\perp$ with $D=d-1$, $S=-2M_{jk}$:

$$\lambda_{\max}\le\frac SD+\sqrt{\frac{D-1}D\Big(f-\frac{S^2}D\Big)}=\frac{-2M_{jk}+\sqrt{E\big[Df-4M_{jk}^2\big]}}{D},\qquad E=D-1 .$$

That is the section's displayed bound **verbatim**, so the instrument is correctly identified and correctly stated. *A structural check that both formulas are right: at $p=3$ the spectrum above has exactly $D-1$ equal eigenvalues on $\mathbf1^\perp$, the Wolkowicz–Styan equality case, and the bound is then exact, the screen reproduces this ($S^3\times S^3$ and $S^3\times S^{42}$ both give bound $=\lambda_{\max}$ to all digits).*

## 2. The exact theorem, confirmed, and the balanced closed form is the boundary case of a family

Every algebraic step of §"The second-order comparison" is right. Reproduced cold:

$$T^2=\theta^2+2\theta\alpha+\alpha^2=2-\frac1m+\frac1{m^2}+\frac1{(m-1)(2m-1)},\qquad \frac{2E}D=2-\frac2{2m-3},$$
$$T^2-\frac{2E}D=\Big(\frac2{2m-3}-\frac1m\Big)+\frac1{m^2}+\frac1{(m-1)(2m-1)}=\frac3{m(2m-3)}+\frac1{m^2}+\frac1{(m-1)(2m-1)}>0 .$$

The second displayed equivalence also checks term by term: dividing $2ED-2EDM^2-4EM^2\le D^2T^2+4DTM+4M^2$ by $D^2$ gives exactly $\tfrac{2E}D\le T^2+\tfrac{4TM}D+\tfrac{4M^2(E+1)+2EDM^2}{D^2}$.

**Independent confirmation of the conclusion by a second route.** Clearing the bound at $S^m\times S^m$ is equivalent to $C^2>m^2A$ with

$$A=(2m-4)\big[2m(2m-3)^2-4\big]=16m^4-80m^3+132m^2-80m+16,\qquad C=4m^3-10m^2+10m-3,$$
$$C^2-m^2A=48m^4-144m^3+144m^2-60m+9=48m^3(m-3)+\big(144m^2-60m+9\big)>0\quad(m\ge3),$$
and $81>0$ at $m=2$. So the section's conclusion survives a route that never touches $2E/D$.

## 3. The silently used hypothesis

**The first equivalence is not an "iff" unconditionally.** "$L\le T$ **iff** $E[Df-4\alpha^2]\le(DT+2\alpha)^2$" is the step $\sqrt X\le Y\iff X\le Y^2$, which requires $Y=DT+2M_{jk}\ge0$. At $S^m\times S^m$ it holds ($T>0$, $M_{jk}=\alpha>0$), so **the theorem is unaffected**; but the section states it as an unconditional equivalence and the general twin extension it proposes must carry the hypothesis.

**It is dischargeable on the record, which is why this is a hypothesis to state rather than a hole.** $M_{jk}\ge0$ at every twin pair is proved twice over (L3269–3273: the eigenvector $e_j-e_k$ at $-M_{jk}$ against the spectral gap; and $M_{jk}(\theta-M_{jk})=\lVert u\rVert^2$), and $T\ge\sqrt{3/2}-1>0$ is free from $\lVert M\rVert_F^2=2$ (Gate-2 item (2) at L3245). Together $DT+2M_{jk}>0$.

**A second, smaller one.** "every term after $T^2$ being positive" uses $T>0$ *and* $M_{jk}>0$. At a padded twin pair ($M_{jk}=0$) all three of those terms vanish identically and the condition degenerates to $\theta^2\ge2-\tfrac2{n-3}$, consistent with the record's item (5) at L3247, but the section's phrase "the remaining right-hand terms only help" is where that degeneration hides.

## 4. How much slack the bound spends, the pattern repeats a fifth time

This is the sharpest finding of the review.

| quantity at $S^m\times S^m$, within-factor | exact | asymptotic |
|---|---|---|
| true slack $T-\lambda_{\max}$ | $\dfrac{(2m-1)\alpha}m$ | $\sqrt2/m$ |
| bound margin $T-L$ | $\dfrac{\alpha\,(48m^4-144m^3+144m^2-60m+9)}{m(2m-3)\,(C+m\sqrt A)}$ | $\dfrac{3\alpha}m\sim\dfrac{3}{\sqrt2\,m^2}$ |
| **fraction of the slack retained** |, | $\boxed{\dfrac3{2m}\to0}$ |

Screened: $m=5$ retains $0.429$, $m=10$ $0.177$, $m=20$ $0.081$, $m=50$ $0.031$, $m=100$ $0.0152$, against $3/(2m)=0.15,\,0.075,\,0.03,\,0.015$.

**So the section's "explicit $O(1/m^2)$ margin" is arithmetically right and rhetorically misleading.** The margin is $O(1/m^2)$ *against a slack of $O(1/m)$*. The instrument survives $m\to\infty$ only because two $1/m$ terms fail to cancel by a constant; it has spent everything else. Concretely, a perturbation depressing $T$ by a relative $\tfrac34m^{-2}$ (or any deviation from the *exact* balanced-product closed forms of that order), flips the sign. The section's "the item's remaining question is no longer *does the instrument survive $n\to\infty$*" is true; the question it should have raised instead, *does the instrument survive leaving the balanced product*, is answered **no** in §5.

**And the instrument has the defect [r379](REVIEW_r379.md) already fenced against $(\dagger)$, unnoticed.** Sending $D\to\infty$ in the section's own second display leaves the necessary condition $\theta^2+2\theta M_{jk}+3M_{jk}^2\ge2$, which is *exactly* $(\dagger)$'s limit, and which in the band ($\theta^2\ge3/2$) demands $M_{jk}\ge0.204$, an absolute constant against an $M_{jk}$ that decays like $1/n$. The record's own words for $(\dagger)$, "demands $\theta\ge\Theta_n(1-O(1/n))$, which is the conclusion rather than a hypothesis" (L3163), apply verbatim here, with a **worse** constant than $(\dagger)$'s $0.169$.

## 5. Generalisation to $p\ne q$, the exact computation goes through and the conclusion fails

The closed forms of §1 make the general comparison exact. Writing $G:=\tfrac{n-2}2\big(T^2-\tfrac{2E}D\big)$,

$$G(p,q)=\frac{n-2}{n-3}-\frac{(n-1)^2}{pq}+1+\frac{2(q-1)}{p}+\frac{q(q-1)}{p(p-1)(n-1)} ,$$

which reproduces $\tfrac{2}{n-2}G=\tfrac3{m(2m-3)}+\tfrac1{m^2}+\tfrac1{(m-1)(2m-1)}$ at $p=q=m$. With $x=p/n$ fixed and $n\to\infty$,

$$G\longrightarrow 2-\frac1{x(1-x)}+\frac{2(1-x)}x=\frac{1-2x}{x(1-x)} .$$

**So the balanced split is precisely the zero of the leading term.** That is the structural reason the section's margin came out $O(1/m^2)$ rather than $O(1)$: the balanced product is not a comfortable interior point of the method's domain, it is the boundary of it, and the $O(1/m^2)$ is the subleading correction that happens to sit on the good side.

**And the sign is wrong on the other side.** $G<0$ for $x>1/2$: the sufficient condition fails whenever the pair sits in the **larger** factor. Screening the actual bound (not the sufficient condition) over in-band within-factor twin pairs with $p,q\le40$:

- **$561$ of $1293$ fail**, and the failure set is exactly $p\ge q+3$ (equivalently: first failing $p$ is $n/2+2$ at $n=20,30,60,100,200,300$ and $n/2+1.5$ at $n=13,45$).
- **No failure with $p\le q$** in $p,q\le60$.

**Named witness, in the band, at a catalogued pure critical point.** $S^8\times S^5$, pair inside the $8$-block:

$$\theta=1.235829\ (\ge\sqrt{3/2}),\qquad T=1.309390,\qquad \lambda_{\max}(\widetilde N)=1.132843,\qquad L=1.322565 .$$

The clause is **true** with slack $0.176547$; the bound **overshoots $T$ by $0.013175$**. Larger witnesses: $S^{25}\times S^{20}$ ($+0.00351$), $S^{40}\times S^5$ ($+0.12997$), $S^{12}\times S^9$ ($+0.00291$).

*Verdict.* The section's "does not close: the general twin pair, since $\alpha,\theta,f$ were used in their balanced-product closed forms" reads as bookkeeping, the general closed forms exist, and using them **refutes** the generalisation rather than leaving it open. The correct sentence is: *the instrument holds at $p\le q+2$ and fails at $p\ge q+3$, and the balanced point sits two steps inside its boundary.*

## 6. $S^5\times S^{40}$, and the label collision

The section's arithmetic is right and its attribution is not.

| object | value at $S^5\times S^{40}$ |
|---|---|
| $\theta$ | $1.263439$ |
| $T$ | $1.550585$ |
| true $\lambda_{\max}(\widetilde N)$ | $1.234725$ |
| the section's $\mathbf1^\perp$ bound | $1.321892$, the record's $1.32188$, **confirmed** |
| **$(\dagger)$ as defined at L3152**, with $\lVert o\rVert=0$ | $\mathbf{1.322663}$, **also clears**, by $0.228$ |

**So $S^5\times S^{40}$ is not a failure of $(\dagger)$.** The seven failures are failures of the *boxed joint-estimate reduction* $\lVert D\hat w\rVert^2\le(T-a)(T-b)$, [r382](REVIEW_r382.md) says so in as many words, and the record's own quoted figures ($k^2=0.2735$ against $0.2465$) are that reduction's, not $(\dagger)$'s. The complementarity table at L3285 heads its second column "joint estimate $(\dagger)$", binding the symbol $(\dagger)$ to a *second* object; the trace-bound section then inherits the collision and reads the joint estimate's residue as $(\dagger)$'s.

**The consequence is not cosmetic.** It underwrites the claim that the new bound is "a different instrument from $(\dagger)$, and a better one here". It is neither:

- **Same instrument.** $(\dagger)$ is Wolkowicz–Styan on the full $d$-space with $f=2-\lVert o\rVert^2-2M_{jk}^2$; the new bound is Wolkowicz–Styan with the same $f$ on $\mathbf1^\perp$. The only difference is $d\to d-1$, bought with $\widetilde N\mathbf1=0$.
- **Better by $0.06\%$.** $1.322663\to1.321892$ at $S^5\times S^{40}$; the two agree to three decimals everywhere screened, and coincide in the limit.

*Recommendation:* give the two objects different names before either is cited again. Suggested: $(\dagger)$ for the trace–Frobenius ceiling as originally defined, $(\dagger^\perp)$ for its $\mathbf1^\perp$ refinement, and $(\ddagger)$ for the boxed joint-estimate reduction.

## 7. Complementarity, the two-row table is one row short

The dichotomy $o\ne0$ / $o=0$ **is** exhaustive, and row 1 is sound: the ordering theorem proves the clause at every $o\ne0$ pair, on hypotheses Gate 2 has already checked. The defect is entirely in row 2, and it is that the twin row carries **two** instruments with **disjoint** failure sets that the record never puts side by side.

| twin pair, in band | joint estimate $\lVert D\hat w\rVert^2\le(T-a)(T-b)$ | $\mathbf1^\perp$ trace bound |
|---|---|---|
| pair in the **smaller** factor | **fails at 7**, $S^5\times S^q$, $q\ge34$ ([r382](REVIEW_r382.md)) | **clears** at every point screened |
| pair in the **larger** factor | **clears**, [r382](REVIEW_r382.md)'s "within-$B$ pairs, none fail" | **fails at 561**, every $p\ge q+3$ |
| balanced | clears | **clears, proved exactly** (the section's theorem) |

Two readings follow, and the record states neither.

1. **The good news the section missed.** Over the screened family the two instruments *are* complementary inside the twin class and together cover it. That is a stronger statement than the record makes and it is the one worth recording.
2. **The bad news it also missed.** Neither instrument covers the twin class alone, and the section's sentence "the residue named in the previous section is covered by this bound" reads as if the trace bound *subsumed* the joint estimate. It does not; it fails on $43\%$ of the in-band twin configurations screened, and the section never says the bound fails anywhere.

**Is the combination airtight?** No, on three counts, in increasing order of seriousness:

- Row 2 is a **screen over sphere products**, both halves, at every split except the balanced one. Only the balanced diagonal is a theorem, and that is the section's own contribution.
- Both twin instruments' asymptotic conditions demand $M_{jk}$ bounded below by an absolute constant while $M_{jk}\sim1/n$, so neither survives $n\to\infty$ off the closed forms, and the complementarity as screened is a finite-$n$ artefact of $O(1/n)$ terms.
- The residue's third member, **the padded sub-case $M_{jk}=0$**, is covered by neither, as the record's item (5) already says: there the trace bound's condition is $\theta^2\ge2-\tfrac2{n-3}$, i.e. the conclusion.

## 8. The twin identity, confirmed, and three consequences left on the table

**Derived cold.** For $i\in I$, $(M^2)_{ij}=\sum_{l\in I}M_{il}M_{lj}+v_iM_{jk}$, so criticality $(M^2)_{ij}=\theta u_i-u_i^2$ gives $\sum_{l\in I}M_{il}M_{lj}=\theta u_i-u_i^2-M_{jk}u_i$ at a twin pair, and adding the diagonal $2u_i^2$:

$$\widetilde N u=(\theta-M_{jk})\,u+u\circ u .\qquad\textbf{CONFIRMED}$$

It is equivalent to the record's $Bu=2M_{jk}u-u\circ u$ with $B=T\,\mathrm{Id}-\widetilde N$, so the two forms agree. The section's reading of it ("$u$ is an eigenvector exactly when $u$ is constant on its support"), is right ($u\circ u=\lambda u$ forces $u_i\in\{0,\lambda\}$), and its conclusion "a twin pair supplies no second eigenvector this way" is right. But it stops there, and the identity gives three more things.

**(a) A Rayleigh floor.** Taking $\langle\cdot,u\rangle$,

$$\lambda_{\max}(\widetilde N)\;\ge\;R(u)=(\theta-M_{jk})+\frac{\sum_iu_i^3}{\lVert u\rVert^2}.$$

**(b) A slack ceiling, this is the consequence that matters.** Since $T=\theta+M_{jk}$,

$$\boxed{\;T-\lambda_{\max}(\widetilde N)\;\le\;2M_{jk}-\frac{\sum_iu_i^3}{\lVert u\rVert^2}\;}$$

**at every twin pair, from criticality alone.** At $S^6\times S^6$ it gives $0.26095$ against a true slack of $0.24720$, tight to $5.6\%$. This is a *positive* statement of exactly how much room any instrument has at a twin pair, and it explains every tightness this line has met: the room is $\le2M_{jk}$, and $2M_{jk}=2\alpha\sim\sqrt2/m$ at the balanced product. It converts "the bound is uncomfortably tight" from an observation into a theorem, and it is the natural companion to $M_{jk}(\theta-M_{jk})=\lVert u\rVert^2$, which rewrites the ceiling as $2M_{jk}-\sum u_i^3/\big(M_{jk}(\theta-M_{jk})\big)$.

**(c) An eigenvalue localisation.** The residual bound for symmetric matrices gives

$$\mathop{\mathrm{dist}}\big(\theta-M_{jk},\ \mathop{\mathrm{spec}}\widetilde N\big)\;\le\;\frac{\lVert u\circ u\rVert}{\lVert u\rVert},$$

i.e. an eigenvalue of $\widetilde N$ within $0.12388$ of $1.10119$ at $S^6\times S^6$ (true: $\lambda_{\max}=1.12367$). This is a **second** located point of the spectrum, alongside $\mathbf1\mapsto0$, the record's L3294 says "what is missing is a second known eigenvector of $\widetilde N$; a twin pair supplies only $\mathbf1$", and while this supplies an approximate eigenvector rather than an exact one, an ordering argument that only needs a *lower* bound on a second eigenvalue can use it. That is the concrete next step this section should have named.

## 9. What should change in the record

1. **Rename $(\dagger)$** into three distinct symbols before either estimate is cited again (§6).
2. **Add the $S^8\times S^5$ witness** as a fence post: *the $\mathbf1^\perp$ trace bound holds at $p\le q+2$ and fails at $p\ge q+3$; the balanced product is two steps inside its boundary, not in its interior.*
3. **Record $G(p,q)$ and its limit $(1-2x)/(x(1-x))$**, it turns "the balanced margin is small" into "the balanced split is the zero of the leading term", which is the honest reason.
4. **Record the slack ceiling $T-\lambda_{\max}\le2M_{jk}-\sum u_i^3/\lVert u\rVert^2$** (§8b), it is a cheap consequence of an identity already on the record and it bounds what any successor instrument can achieve.
5. **Record the exact $\widetilde N$ spectrum at $S^p\times S^q$** (§1) and the closed slack $\theta/(p-1)$, so that no future instrument has to be screened against a black box.
6. **Rewrite the complementarity table** with the twin row split by which factor holds the pair, and state that both halves are screens over sphere products (§7).
