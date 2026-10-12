# Reviewer 337, the per-row family (I24 steps 1–3), and the closed-form block spectrum

Cold brief, definitions only, analysis. Every number below is derived by hand first; a scipy screen ([screen_rowhull.py](../scripts/reviewers/r337/screen_rowhull.py)) reproduces the hand values and is reported as a screen, never as evidence for a positive claim.

**Units used throughout for sphere products:** scale so the mixed block sits at $\lambda=-1$. Then $\Lambda^2V_p$ carries $q/(p-1)$, $\Lambda^2V_q$ carries $p/(q-1)$, and (proved in §U4 below), $\theta=n-1$ at **every** $S^p\times S^q$.

## Verdicts

| claim | verdict |
|---|---|
| **U5** the family is worth having | **CONFIRMED, but the record's reasons are wrong in both directions**, the positive half is *not* the $\Pi$-bound, and the family is *not* the end of the row calculus |
| **U1** the closed-form block spectrum and its consequences | **CONFIRMED**, every step, with two unstated hypotheses ($p,q\ge2$; $\mu>0$) |
| **U2** Lemma L73 is the whole of the row calculus on $\mathcal W_n$ | **REFUTED AS STATED**, three separate counters, one of them the record's own sharpening |
| **U3** $\lambda_{\max}$ is optimal on the positive side | **REFUTED AS STATED** (repair below); the negative side is **CONFIRMED**, by an argument the record does not give |
| **U4** balanced tightness, positive slack $n/(n-2)$, and the inference | **CONFIRMED** (both halves); the inference is valid but nearly vacuous |

---

## U5, is the family worth anything? Lead finding

### The family is one of *two* one-dimensional projections of a two-dimensional per-row condition, and the projection the record never took is exact where both of its projections are worst

Row $a$ carries **two** pinned moments against the same probability measure $\mu_a=T_{a\bullet\bullet}/2(n-2)$. Writing $X=\tfrac{\lambda_b+\lambda_c}2$ and $Y=\lambda_b\lambda_c$ over the pair set $S_a=\{(b,c):b\ne c,\ b\ne a,\ c\ne a\}$,

$$\mathbb E_{\mu_a}[X]=\frac{-\lambda_a}{n-2}\quad\text{(B)},\qquad \mathbb E_{\mu_a}[Y]=\frac{\lambda_a(\theta-\lambda_a)}{n-2}\quad\text{(C)}.$$

The **complete** per-row necessary condition is that the point $\big(\tfrac{-\lambda_a}{n-2},\ \tfrac{\lambda_a(\theta-\lambda_a)}{n-2}\big)$ lie in $\operatorname{conv}\{(X,Y):(b,c)\in S_a\}$. The record reads two one-dimensional shadows of it and never the thing itself:

- the **family** ([bounds.md](../findings/bounds.md)) drops (B) and keeps only $\mathbb E[Y]\in[m_a,M_a]$;
- the **$\Pi$-bound** keeps (B) but replaces $Y$ by the relaxation $Y\le X^2$ before using it.

**By hand at padded $W_{\mathbb{CP}^2}$, and the gap is unbounded.** Unit-norm $W_{\mathbb{CP}^2}$ has $\lambda=2\varepsilon$ (simple), $-\varepsilon$ (twice), $0$ elsewhere, with $\varepsilon=1/\sqrt6$ (from $\lVert W\rVert^2=\tfrac19+\tfrac2{36}=\tfrac16$ on the raw eigenvalues $\tfrac13,-\tfrac16,-\tfrac16$). Take $a=\arg\max$. Deleting $a$, the pairs carry only three distinct $(X,Y)$ values:

$$(u,u)\mapsto(-\varepsilon,\ \varepsilon^2),\qquad (u,0)\mapsto(-\tfrac\varepsilon2,\ 0),\qquad (0,0)\mapsto(0,\ 0).$$

(B) reads $-\varepsilon w_1-\tfrac\varepsilon2 w_2=\tfrac{-2\varepsilon}{n-2}$, i.e. $w_1+\tfrac{w_2}2=\tfrac2{n-2}$, so $w_1\le\tfrac2{n-2}$ and

$$\mathbb E[Y]\le\frac{2\varepsilon^2}{n-2}\ \Longrightarrow\ \frac{2\varepsilon(\theta-2\varepsilon)}{n-2}\le\frac{2\varepsilon^2}{n-2}\ \Longrightarrow\ \boxed{\ \theta\le3\varepsilon=\sqrt{3/2}\ }\quad\text{for every }n\ge4,$$

which is **exactly $\theta$** at that point. The family's own projection takes $w_1=1$, i.e. $\mathbb E[Y]\le M_a=\varepsilon^2$, and returns $\theta\le2\varepsilon+\tfrac{(n-2)\varepsilon}2=\tfrac{n+2}2\varepsilon$. So at padded $W_{\mathbb{CP}^2}$

$$\frac{\text{family}}{\text{true }\theta}=\frac{n+2}{6}\ \longrightarrow\ \infty .$$

At $n=12$ that is $\tfrac{14}6=2.3\overline{3}$: $2.857738$ against $1.224745$. The one line of algebra above closes the whole gap.

*Screen* ([screen_rowhull.py](../scripts/reviewers/r337/screen_rowhull.py)), minimising the two-moment row bound over rows: exact at padded $W_{\mathbb{CP}^2}$ for $n=6,8,10,12$, at the balanced products for $n=6,8,12$, and at $S^2\times S^{n-2}$ for $n=5,6,8,12$, in every case returning $\theta$ to the digit while the family returns $1.63/2.04/2.45/2.86$ at the four padded points.

**This is the direct answer to [I24](../plan.md).** I24 step 1's sentence "the per-row family is the whole of what the row calculus says at critical points" is false: the family is what *one moment* of one row says. The two-moment row condition is closed-form, needs no LP, and is strictly stronger. It does **not** close the conjecture, it is dominated by the full pinned system, which [r324](REVIEW_r324.md) measured ceilinging at $1.5$–$3.7\times\theta_0(n)$, but it is the object I24 should have been reading, and it is exact at every catalogued point tested.

### The positive half is NOT the $\Pi$-bound, the identification is refuted in both directions

[bounds.md](../findings/bounds.md) states "both of this record's standing spectral bounds are one system read twice, Lemma L70 at the $\lambda_{\min}$ row, the $\Pi$-bound at the $\lambda_{\max}$ row", and I24 step 2 repeats it as "the row the $\Pi$-bound already reads". Neither direction holds.

| point ($\lambda_{\text{mix}}=-1$ units, or unit norm for padded $\mathbb{CP}^2$) | $\theta$ | family at $\arg\max$ | $\Pi$-bound |
|---|---|---|---|
| balanced $S^{n/2}\times S^{n/2}$ | $n-1$ | $(n-1)\tfrac n{n-2}$ | $n-1$ **(exact)** |
| padded $W_{\mathbb{CP}^2}$, $n=12$ | $1.224745$ | $2.857738$ | $4.490731$ |

At the balanced product the $\Pi$-bound is **exactly tight** and the family's positive half is slack by exactly $n/(n-2)$; at padded $W_{\mathbb{CP}^2}$, $n=12$, the family beats the $\Pi$-bound by $1.57\times$. **Neither dominates**, so they are genuinely different consequences of the same row, the family spends (C) alone, the $\Pi$-bound spends (B) as well but pays $Y\le X^2$ for it. Merging them is exactly the two-moment condition above, which dominates both.

*A corollary worth recording, two lines from §U4:* since $\theta=n-1$ and $\lvert\lambda_{\min}\rvert=1$ at **every** $S^p\times S^q$, the $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ is **exactly tight on the whole sphere-product family**, balanced and unbalanced alike. The record notes its tightness at the balanced products only.

### The padded-$W_{\mathbb{CP}^2}$ triple is right, at $n=8$

The brief's $2.041241$ against $4.490731$ and $2.857738$ is the $n=8$ row exactly: row-family minimum $\tfrac{5}{\sqrt6}=2.041241$, Lemma L70 $\tfrac{11}{\sqrt6}=4.490731$, $\Pi$-bound $\tfrac7{\sqrt6}=2.857738$. Hand check of the first: $M_{\arg\max}=\varepsilon^2$ so the bound is $2\varepsilon+6\varepsilon/2=5\varepsilon=5/\sqrt6$. So [r336](REVIEW_r336.md)'s "CONFIRMED, it is the $n=8$ figure" is right and [r335](REVIEW_r335.md)'s S5 verdict ("the three numbers are mixed across $n$"), is **refuted**: r335 evaluated at $n=6$ and $n=12$ and never at $n=8$. The numbers do coincide across roles ($5\varepsilon$ is simultaneously the $n=8$ row-min and the $n=6$ $\Pi$-bound, since $2\varepsilon+\tfrac{(n-2)\varepsilon}{2}=(n-1)\varepsilon$ at $n=6$ only by arithmetic accident), which is what made r335's reading look forced.

### Is the excluded-index sharpening worth having? Yes, on the *positive* side, where the record does not look

The brief asks about the negative side, where the sharpening is inert whenever $\lambda_{\min}$ has multiplicity $\ge2$. That is correct and it does make the negative sharpening near-worthless at the catalogue. **But the same exclusion on the positive side is decisive**, and at the record's own new headline witness:

At $S^2\times S^{n-2}$ the maximum sits on the **one-dimensional** $\Lambda^2V_2$, so deleting the row index removes $\lambda_{\max}$ from the pair set entirely:

$$M_{\arg\max}=\max\Big(\tfrac4{(n-3)^2},\,1\Big)=1\ (n\ge5)\ \Longrightarrow\ \theta\le(n-2)+\frac{(n-2)\cdot1}{n-2}=n-1=\theta\ \textbf{exactly},$$

whereas without the exclusion $M=\lambda_{\max}\lambda_{(2)}=\tfrac{2(n-2)}{n-3}$ and the bound degrades to $(n-2)+\tfrac{2(n-2)}{n-3}$, $12.2\overline2$ against $11$ at $n=12$. So the exclusion converts a slack bound into an exact one, by exactly the mechanism ($E_{\max}$ one-dimensional hence abelian) that the record already credits for Lemma L73's saturation there. **The sharpening is worth having, and the place to argue for it is the positive half, not the negative one.**

The multiplicity objection also cuts the other way. The record's own standing rule is that the catalogue is a biased sample; [T10](../plan.md)'s closure rests on generic critical points of $\mathcal W_6$ having $10$ and $15$ **distinct** eigenvalues, i.e. $\lambda_{\min}$ simple. The sharpening is non-trivial exactly there, which is exactly where the pinned LP was measured to fail by $+0.23$.

### Where the family dies, and the record's stated reason is out of scope

[bounds.md](../findings/bounds.md) kills the row conditions with $\mathbb{CP}^3$, an $n=6$ point, against a conjecture stated for $n\ge12$, the scope error this record has been caught on repeatedly. A clean **in-scope** witness is available and the record already carries its numbers: at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$, a genuine critical point, the family's minimum over rows is $2.857738$ against $\theta_0(12)=1.236033$, a factor $2.31$. Use that one.

---

## U1, the closed-form block spectrum. CONFIRMED, every step

**Einstein normalisation.** $S^p(r_1)\times S^q(r_2)$, $n=p+q$, sectional curvatures $k_1=r_1^{-2}$ on the first factor, $k_2=r_2^{-2}$ on the second, $0$ on mixed planes. $\operatorname{Ric}=(p-1)k_1g$ on $V_p$ and $(q-1)k_2g$ on $V_q$, so the product is Einstein **iff** $(p-1)k_1=(q-1)k_2=:\mu$, which needs $p,q\ge2$ and $\mu>0$ (at $p=1$ the condition forces $\mu=0$). Neither hypothesis is stated in the record. Then $\operatorname{scal}=n\mu$. ✓

**The Ricci part vanishes and $R$ kills the mixed block.** Einstein means $\operatorname{Ric}_0=0$, so the $\operatorname{Ric}_0\owedge g$ term of the Weyl decomposition is identically zero, no residual Ricci part. ✓ The curvature of a Riemannian product vanishes unless all four arguments lie in one factor, so $R_{i\alpha j\beta}=0$ for $i,j\in V_p$, $\alpha,\beta\in V_q$, and $R$ annihilates $V_p\otimes V_q$ outright. ✓

**The scalar part and the three blocks.** A constant-curvature $k$ operator is $k\,\mathrm{Id}$ on $\Lambda^2$ with $\operatorname{scal}=n(n-1)k$, so the scalar term is $\tfrac{\operatorname{scal}}{n(n-1)}\mathrm{Id}=\tfrac{\mu}{n-1}\mathrm{Id}$ and $W=R-\tfrac{\mu}{n-1}\mathrm{Id}$. ✓ With $k_1=\tfrac{\mu}{p-1}$, $k_2=\tfrac\mu{q-1}$ and $n-p=q$, $n-q=p$:

$$\Lambda^2V_p:\ \frac{\mu(n-p)}{(p-1)(n-1)}=\frac{\mu q}{(p-1)(n-1)},\qquad \Lambda^2V_q:\ \frac{\mu p}{(q-1)(n-1)},\qquad \text{mixed}:\ -\frac{\mu}{n-1}.$$

**Arithmetic check by trace.** $\tfrac{p(p-1)}2\cdot\tfrac{\mu q}{(p-1)(n-1)}+\tfrac{q(q-1)}2\cdot\tfrac{\mu p}{(q-1)(n-1)}-pq\cdot\tfrac\mu{n-1}=\tfrac{\mu}{n-1}\big[\tfrac{pq}2+\tfrac{qp}2-pq\big]=0$. ✓

**Independent check by relation (B)**, which no arithmetic slip could survive, see §U4; it holds at both row types for all $p,q\ge2$.

**$\lambda_{\min}$ is always mixed.** Both $\Lambda^2$ blocks are strictly positive ($\mu>0$, $p,q\ge2$) and the mixed block is strictly negative. ✓

**$p=2$ and the ratio.** Ratios to $\lvert\lambda_{\min}\rvert$ are $q/(p-1)$ and $p/(q-1)$; at $p=2$ these are $n-2$ and $\tfrac2{n-3}$, and

$$n-2>\frac2{n-3}\iff(n-2)(n-3)>2\iff(n-1)(n-4)>0\iff n\ge5 .$$

So $\lambda_{\max}$ sits on $\Lambda^2V_2$ and $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n-2$ **exactly**, saturating [Lemma L73](../findings/bounds.md) at every $n\ge5$, odd and even. ✓ (At $n=4$ the two coincide at $2=n-2$, so $S^2\times S^2$ saturates too; below $n=5$ the record's ordering claim is an equality, not an inequality.)

**Balanced cross-check.** $p=q=n/2$: ratio $=\tfrac{n/2}{n/2-1}=\tfrac n{n-2}$. ✓ **And $(n-p)/(p-1)$ is strictly decreasing in $p$**, so $S^2\times S^{n-2}$ is not merely *a* saturating member but the **unique maximiser of the ratio over the entire sphere-product family**, a strengthening the record does not state and which explains why "slack at every sphere product" survived so long: the claim is true at every $p\ge3$.

---

## U2, "Lemma L73 is the whole of what the row calculus gives on $\mathcal W_n$". REFUTED AS STATED

**The split itself is right and is trivial.** (A) is the Killing form (row mass $2(n-2)$, verified directly: for $v_a=E_{12}$ the only non-vanishing brackets are $[E_{12},E_{1k}]=\pm E_{2k}$ and $[E_{12},E_{2k}]=\mp E_{1k}$, $k=3\dots n$, giving exactly $2(n-2)$ ordered pairs of weight $1$). (B) is $W\#I=-W$, a Weyl identity. (C) is the diagonal of $W^\#=\theta W-W^2$ and is criticality. So a bound that spends (C) cannot be asserted off the critical set. ✓ **CONFIRMED**, and it is a restatement of the definitions rather than a result.

**"The whole of" is false, three ways.**

1. **The record's own sharpening.** Two paragraphs above the claim, [bounds.md](../findings/bounds.md) records $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ over the two smallest eigenvalues excluding $\arg\max$, calls it "strictly stronger when $\lambda_{\min}$ is simple", and measures the gain ($0.272166\to0.136083$ at padded $W_{\mathbb{CP}^2}$). That is the same row calculus, strictly stronger than boxed Lemma L73. The document contradicts itself across two paragraphs.
2. **Rows are coupled.** The $\mu_a$ are marginals of **one** totally symmetric $T\ge0$, so joint feasibility across all $N$ rows strictly exceeds the union of the per-row conditions. [bounds.md](../findings/bounds.md) says so itself, "the question is precisely whether the full system read **jointly across all rows** is stronger than the union of its rows", and then calls the union "the whole of".
3. **The row calculus bounds the objective itself off the critical set.** Off criticality set $q_a:=\langle v_a,Q(W)v_a\rangle=\lambda_a^2+\tfrac12\sum_{bc}\lambda_b\lambda_cT_{abc}$. Relation (A) alone gives $\tfrac12\sum_{bc}T_{abc}=n-2$, so $q_a\in[\lambda_a^2+(n-2)m_a,\ \lambda_a^2+(n-2)M_a]$, and since $P(W)=\langle W,Q(W)\rangle=\sum_a\lambda_aq_a$,

$$P(W)\ \le\ \sum_a\lambda_a^3+(n-2)\Big[\sum_{\lambda_a>0}\lambda_aM_a+\sum_{\lambda_a<0}\lambda_am_a\Big]\qquad\text{on all of }\mathcal W_n .$$

That is a per-row bound on the conjecture's actual objective, valid without criticality, and it is not Lemma L73. *It is not new as a class*, it sits inside [post F10](../findings/fence-posts.md)'s marginal relaxation, which the record already owns, but that is the point: the record's own post F10 is a counterexample to its own "the whole of".

**Repair.** Replace with: *Lemma L73 is all that a **single row in isolation**, reading (A) and (B) alone, yields as a $\theta$-free spectral condition.* Everything else in I24 step 1 stands.

---

## U3, "$\lambda_{\max}$ and $\lambda_{\min}$ are the optimal rows". Positive side REFUTED AS STATED

**The derivation of the family is correct.** $\mathbb E_{\mu_a}[Y]=\tfrac{\lambda_a(\theta-\lambda_a)}{n-2}\in[m_a,M_a]$; for $\lambda_a>0$ divide by $\lambda_a$; for $\lambda_a<0$ use the lower end and flip the inequality on dividing. Both stated forms are right. ✓

**The withdrawal's replacement argument is unsound.** [bounds.md](../findings/bounds.md) argues: "with $c=(n-2)M_a>0$, $f'(x)=1-c/x^2<0$ for $x<\sqrt c$, so $f$ is decreasing". $f(x)=x+c/x$ is decreasing **only on $(0,\sqrt c)$**; nothing checks that $\lambda_{\max}$ lies there, and it does not at the record's own headline witness. At $S^2\times S^{n-2}$,

$$\lambda_{\max}=n-2,\qquad M_{\arg\max}=1,\qquad c=(n-2)M_{\arg\max}=n-2,\qquad \lambda_{\max}=n-2\ >\ \sqrt{n-2}=\sqrt c\ (n\ge4),$$

so $\arg\max$ sits strictly in the **increasing** branch. The conclusion survives there only because $M_a$ is *not* constant across rows, the very assumption the argument silently makes. And $M_a<0$ is possible outright (all eigenvalues but $a$ of the same sign in the surviving pairs), in which case $f$ is increasing on all of $(0,\infty)$.

**Correct criterion.** For $x_1>x_2>0$ against a **common** $c$: $f(x_1)\le f(x_2)\iff x_1x_2\le c$. So $\arg\max$ beats row $b$ iff $\lambda_{\max}\lambda_b\le(n-2)M$, a condition on the *product*, not on $\lambda_{\max}^2$.

**Counterexample to the conclusion.** $n=6$, $N=15$, spectrum $\{1.2,\ 0.8,\ -1.4,\ (-0.05)^{\times12}\}$. Trace $=0$; Lemma L73 holds ($1.2\le4\cdot1.4$ and $1.4\le4\cdot1.2$); every row of (B) is feasible ($-\lambda_a/4$ lies inside the pair-mean range for each of the four eigenvalues). Both positive rows see the same $M_a=(-1.4)(-0.05)=0.07$, so $c=0.28$, and $\lambda_1\lambda_2=0.96>0.28$:

$$f_{\arg\max}=1.2+\frac{0.28}{1.2}=1.4\overline3,\qquad f_{(0.8)}=0.8+\frac{0.28}{0.8}=1.15 .$$

The **smaller** positive eigenvalue gives the strictly stronger bound. This is a spectrum satisfying every necessary condition the record knows; whether it is realizable is open ([LIT-spectra](LIT-spectra.md) records that no realizability criterion exists), so it refutes the *argument* and the *general claim*, not the claim restricted to the catalogue.

**The negative side is CONFIRMED, by an argument the record does not give.** Write $g(x)=x+c'/x$ on $x<0$ with $c'=(n-2)m_a$. Where $m_a<0$, which holds whenever some pair excluding $a$ has opposite signs, i.e. everywhere the conjecture is live, $g'(x)=1+\lvert c'\rvert/x^2>0$ **everywhere on $(-\infty,0)$**, with no branch to check, so the most negative $\lambda_a$ gives the smallest bound. And $m_{\arg\min}\ge m_b$ for every other row (deleting $\arg\min$ can only raise a minimum), so $\arg\min$ wins on *both* factors simultaneously. This is robust in a way the positive side is not; the record's one-line $f'<0$ argument does not apply here at all, since $c'<0$.

**Repaired U3, for the plan:** *$\lambda_{\min}$ is the optimal negative row unconditionally (given $m_{\arg\min}<0$). On the positive side $\arg\max$ is optimal against row $b$ iff $\lambda_{\max}\lambda_b\le(n-2)M$ under a common $M$; the record's monotonicity argument is invalid and the claim fails on spectra passing every known necessary condition.*

---

## U4, the balanced product. CONFIRMED, both halves, with $\theta_0$ re-derived

**Setup, from U1 with $\mu/(n-1)=1$:** $E_{\max}=\Lambda^2V_p\oplus\Lambda^2V_q$ at $h=\tfrac n{n-2}$ with $\dim=\tfrac{n(n-2)}4$; $E_{\min}=$ mixed at $-1$ with $\dim=\tfrac{n^2}4$.

**Relation (B) at both row types, for general $p,q$**, an independent check of the U1 spectrum. For $v_a\in\mathfrak{so}(p)$ the row mass splits $2(p-2)$ inside $\mathfrak{so}(p)$ and $2q$ inside $\mathfrak m$ (the $\mathfrak{so}(p)\times\mathfrak m$ pairs vanish since $[\mathfrak{so}(p),\mathfrak{so}(p)]\perp\mathfrak m$):

$$\sum_{bc}\lambda_bT_{abc}=\frac{q}{p-1}\cdot2(p-2)+(-1)\cdot2q=2q\Big[\frac{p-2}{p-1}-1\Big]=\frac{-2q}{p-1}=-2\lambda_a .\ \checkmark$$

For $v_a=e_i\wedge f_\alpha\in\mathfrak m$ the partners are $p-1$ elements of $\mathfrak{so}(p)$, $q-1$ of $\mathfrak{so}(q)$ and $n-2$ of $\mathfrak m$:

$$\sum_{bc}\lambda_bT_{abc}=\Big[(p-1)\tfrac q{p-1}+(q-1)\tfrac p{q-1}\Big]+(n-2)(-1)=(q+p)-(n-2)=2=-2(-1).\ \checkmark$$

**Relation (C) at both row types gives $\theta=n-1$ for every $S^p\times S^q$.** From the $\mathfrak m$ row, $2\big[(p-1)\tfrac q{p-1}+(q-1)\tfrac p{q-1}\big](-1)=-2n$ must equal $2(-1)(\theta+1)$, so $\theta=n-1$. The $\Lambda^2V_p$ row then requires $\tfrac{2q}{(p-1)^2}\big[q(p-2)+(p-1)^2\big]=\tfrac{2q}{(p-1)^2}\big[(p+q-1)(p-1)-q\big]$, and $(p+q-1)(p-1)-q=(p-1)^2+q(p-2)$ identically. ✓ **Both rows agree, so $S^p\times S^q$ is critical with $\theta=n-1$ in these units.**

**Negative side, tight.** $E_{\min}$ has dimension $n^2/4\ge2$, so deleting one index leaves another; $m_a=\min\{h^2,-h,1\}=-h$, unchanged. Hence $\theta\le-1+(n-2)h=n-1$, **exact**. ✓

**And this re-derives $\theta_0(n)$ from scratch.** $\lVert W\rVert^2=\tfrac{n(n-2)}4h^2+\tfrac{n^2}4=\tfrac{n^2(n-1)}{2(n-2)}$, so

$$\theta_{\text{unit}}=\frac{n-1}{\lVert W\rVert}=\frac{(n-1)}{n}\sqrt{\frac{2(n-2)}{n-1}}=\frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n).\ \checkmark$$

**Positive side, slack by exactly $n/(n-2)$.** $\dim E_{\max}=\tfrac{n(n-2)}4\ge2$ for $n\ge6$, so deleting one index leaves $M_a=\max(h^2,1)=h^2$ (as $h=\tfrac n{n-2}>1$). Hence $\theta\le h+(n-2)h=(n-1)h$, and $(n-1)h\big/(n-1)=h=\tfrac n{n-2}$. ✓ **Both halves of U4 confirmed.**

**The inference is valid but nearly vacuous, and the record draws the wrong moral.** "A bound returning $\tfrac n{n-2}\theta_0>\theta_0$ at a point where $\theta=\theta_0$ cannot alone prove $\theta\le\theta_0$" is correct, and is true of *any* bound not tight at the maximiser, so it carries no information specific to this family. What the same computation actually shows is the **opposite** of how the plan reads it: the family's **minimum over rows equals $\theta_0$ exactly** at the balanced product, which is the necessary condition every candidate proof must pass and which most of this record's bounds fail. The real obstruction is not the positive-half slack; it is the $2.31\times$ overshoot at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$ (§U5).

---

## What to change in the record

1. **[bounds.md](../findings/bounds.md), the row family**, add the two-moment per-row condition and its one-line padded-$W_{\mathbb{CP}^2}$ derivation ($\theta\le3\varepsilon=\sqrt{3/2}$, all $n$); it strictly dominates both halves and the family's slack there is $(n+2)/6$, unbounded.
2. **[bounds.md](../findings/bounds.md)**, strike "the $\Pi$-bound at the $\lambda_{\max}$ row"; the two are incomparable, with the $\Pi$-bound exact at the balanced product and beaten by $1.57\times$ at padded $W_{\mathbb{CP}^2}$, $n=12$. Add: the $\Pi$-bound is exact at **every** $S^p\times S^q$.
3. **[bounds.md](../findings/bounds.md), the withdrawal block**, the $f'(x)<0$ argument is invalid; replace with the product criterion $\lambda_{\max}\lambda_b\le(n-2)M$, note that $\arg\max$ sits in the increasing branch at $S^2\times S^{n-2}$, and give the negative side its own (stronger) argument.
4. **[plan.md](../plan.md), I24 step 1**, "the whole of what the calculus gives" → "all that a single row in isolation gives"; I24 step 2 → the repaired criterion; I24 step 3 → keep the arithmetic, drop "so its positive half cannot close the conjecture" as vacuous and cite the $n=12$ padded witness instead of $\mathbb{CP}^3$.
5. **[REVIEW_r335.md](REVIEW_r335.md) S5**, mark refuted; the triple is the $n=8$ row and r335 never evaluated $n=8$.
6. **[bounds.md](../findings/bounds.md), U1 block**, add the hypotheses $p,q\ge2$ and $\mu>0$, and the strengthening that $S^2\times S^{n-2}$ is the *unique* ratio-maximiser over the sphere-product family, since $(n-p)/(p-1)$ decreases in $p$.
