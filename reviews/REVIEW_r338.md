# Reviewer 338, the per-row family, I24 steps 1–3, and the sphere-product block spectrum

**Method**: analysis only. Every verdict below is closed-form algebra done from the definitions. One arithmetic screen was taken, on spectra I constructed, purely to guard against transcription slips in figures I quote; it is marked as a screen and carries no positive claim.

| claim | verdict |
|---|---|
| **U5** the family's value | **REFUTED AS STATED / PART-CONFIRMED**, the premise "its positive half is the $\Pi$-bound" is **false**; the positive row is an independent bound, and neither it nor $\Pi$ dominates. The family is a genuine advance in that one respect and a repackaging in the other |
| **U1** the block spectrum and its consequences | **CONFIRMED** in every step, with an independent tracelessness check |
| **U2** "Lemma L73 is the whole of what the row calculus gives on $\mathcal W_n$" | **REFUTED AS STATED**, the split (A),(B) vs (C) is right; "the whole of" is not. The complete content of (A)+(B) is a doubly-stochastic eigenvector condition, of which Lemma L73 is the one-index shadow |
| **U3** $\lambda_{\max}$ optimal on the positive side | **REFUTED AS STATED, with repair**, the monotonicity argument is valid only on $(0,\sqrt c)$, and **at the record's own flagship witness $S^2\times S^{n-2}$ the argument's hypothesis fails**. Explicit spectrum given where the conclusion itself fails |
| **U4** tight negative / slack by $n/(n-2)$ positive at the balanced product, and the inference | **CONFIRMED**, both halves and the inference, with one over-reading flagged |

---

## U5, is the per-row family worth anything the record does not already have?

### The premise the brief hands me is false: the positive half is **not** the $\Pi$-bound

Both are read at the row $a=\arg\max$. Both bound the same quantity, $\mathbb E_{\mu_a}[Y]=\lambda_a(\theta-\lambda_a)/(n-2)$ with $Y=\lambda_b\lambda_c$. **They bound it by two different relaxations, and neither relaxation dominates the other.**

- **$\Pi$'s route**: $Y\le X^2$ with $X=\tfrac{\lambda_b+\lambda_c}2$, then $\mathbb E[X^2]\le(\lambda_{\min}+\lambda_{\max})\mathbb E[X]-\lambda_{\min}\lambda_{\max}$, feeding in the *pinned first moment* $\mathbb E[X]=-\lambda_a/(n-2)$ from (B). It uses the **global** eigenvalue range and never looks at which indices the row excludes.
- **The family's route**: $\mathbb E[Y]\le M_a:=\max_{b\ne c,\;b,c\ne a}\lambda_b\lambda_c$ directly. It uses the **excluded-index support** and never looks at the first moment.

That they differ is settled by evaluating both at the two points that matter.

**At the balanced product** ($\lambda_{\max}=h$, $\lambda_{\min}=-m$, $h=mn/(n-2)$): the family's positive row gives $h+(n-2)h^2/h=(n-1)h$, while $\Pi$ gives $(n-1)m$. Since $h>m$, **$\Pi$ is strictly stronger, by exactly $n/(n-2)$**.

**At padded $W_{\mathbb{CP}^2}$** (spectrum $(2a,-a,-a,0^{N-3})$, $a=1/\sqrt6$): $M_{\arg\max}=\max\{(-a)(-a),0\}=a^2$, so the family's positive row gives $2a+(n-2)a^2/(2a)=\tfrac{n+2}2a$, while $\Pi$ gives $(n-1)a$. **The family is stronger, by a factor $2(n-1)/(n+2)\to2$.**

So the two are incomparable, and the record's line *"both of this record's standing spectral bounds are one system read twice"* is correct about which **rows** are read and wrong if it is taken to mean the family reproduces them.

### Exactly when the positive row beats $\Pi$, a closed criterion

Suppose $M_{\arg\max}=\lambda_{\min}^2$ (which holds whenever $\lambda_{\min}$ has multiplicity $\ge2$ and no two remaining positives multiply above $m^2$). Write $s=\lambda_{\max}$, $m=\lvert\lambda_{\min}\rvert$. Then

$$s+\frac{(n-2)m^2}{s}<(n-1)m\iff s^2-(n-1)ms+(n-2)m^2<0\iff (s-m)\big(s-(n-2)m\big)<0\iff m<s<(n-2)m.$$

**The family's positive row strictly beats the $\Pi$-bound on the whole open interval $\lvert\lambda_{\min}\rvert<\lambda_{\max}<(n-2)\lvert\lambda_{\min}\rvert$, and ties exactly at the two endpoints**, the lower one being $\lambda_{\max}=\lvert\lambda_{\min}\rvert$ and the upper one being **the saturation locus of Lemma L73 itself**. Padded $W_{\mathbb{CP}^2}$ has $s=2a$, $m=a$, sitting strictly inside for every $n\ge5$. The balanced product escapes the criterion for the other reason: there $\lambda_{\max}$ has multiplicity $\ge3$, so $M=h^2$ rather than $m^2$, and the comparison inverts.

### The triple, settled

The record's $2.041241$ / $4.490731$ / $2.857738$ **is** internally consistent, at $n=8$. From the padded $\mathbb{CP}^2$ spectrum, in closed form:

$$\text{row}^{+}=\tfrac{n+2}2a,\qquad \text{row}^{-}=(2n-5)a=\lambda_{\min}+(n-2)\lambda_{\max}=\text{Lemma L70},\qquad \Pi=(n-1)a.$$

| $n$ | row-min $=\tfrac{n+2}2a$ | Lemma L70 $=(2n-5)a$ | $\Pi=(n-1)a$ | $\theta_0(n)$ | true $\theta$ |
|---|---|---|---|---|---|
| $6$ | $1.632993$ | $2.857738$ | $2.041241$ | $1.054093$ | $1.224745$ |
| $8$ | $\mathbf{2.041241}$ | $\mathbf{4.490731}$ | $\mathbf{2.857738}$ | $1.145644$ | $1.224745$ |
| $12$ | $2.857738$ | $7.756718$ | $4.490731$ | $1.236033$ | $1.224745$ |

The $n=8$ row reproduces the record's triple **in the record's own order**, $2.041241$ against $4.490731$ (Lemma L70) and $2.857738$ ($\Pi$). Two things follow. First, the qualitative claim stands: **the family beats both standing bounds at this point, at every $n$**, since $\tfrac{n+2}2<n-1$ for $n>4$ and $\tfrac{n+2}2<2n-5$ for $n>4$. Second, the standing dispute in the record, [r335](REVIEW_r335.md) calling the triple "mixed across $n$" against [r336](REVIEW_r336.md) calling it the $n=8$ figures, **is settled in r336's favour**, by closed form rather than by measurement. r335's own table is what mislabels: at $n=6$ it reports Lemma L70 $=2.857738$ and $\Pi=2.041241$, which is correct, and then reads the record's triple as if the second and third slots were $\Pi$ and Lemma L70 in that order.

Note also, from the same closed form, that the row-min is the **positive** row at padded $W_{\mathbb{CP}^2}$ for every $n\ge4$ ($\tfrac{n+2}2\le 2n-5$), the opposite of the balanced product, where it is the negative row. **The family's two halves change places between the two catalogued points**, which is the sharpest single statement of why it is not a repackaging of either standing bound.

### The negative half, and the excluded-index question the brief asks

The negative row at $a=\arg\min$ reads $\theta\le\lambda_{\min}+(n-2)m_a/\lambda_{\min}$ with $m_a=\min_{b\ne c,\;b,c\ne a}\lambda_b\lambda_c$. Lemma L70 as recorded uses $m_a\ge\lambda_{\min}\lambda_{\max}$, which is the value of $m_a$ **only if a second index carrying $\lambda_{\min}$ survives the deletion**. When $\lambda_{\min}$ is simple, $m_a=\lambda_{\max}\lambda_{\min}^{(2)}$ with $\lambda_{\min}^{(2)}$ the second-smallest eigenvalue, and the gain is exactly

$$\text{(recorded)}-\text{(sharp)}=(n-2)\lambda_{\max}\cdot\frac{\lambda_{\min}-\lambda^{(2)}_{\min}}{\lambda_{\min}}=(n-2)\lambda_{\max}\cdot\frac{\lambda^{(2)}_{\min}-\lambda_{\min}}{\lvert\lambda_{\min}\rvert}>0.$$

**The brief's worry is half right and half backwards.** It is right that the sharpening is identically zero wherever $\lambda_{\min}$ has multiplicity $\ge2$, hence at every catalogued saturating point, the balanced products ($\dim E_{\min}=n^2/4$), $S^2\times S^{n-2}$ ($\dim E_{\min}=2(n-2)$), padded $W_{\mathbb{CP}^2}$ ($\dim E_{\min}=2$). It is backwards in inferring that the sharpening is therefore worthless where the conjecture is open. **The conjecture is open at generic critical points, and the record's own evidence is that those have simple eigenvalues**, [T10](../plan.md)'s two Newton-solved generic critical points of $\mathcal W_6$ carry $10$ and $15$ distinct eigenvalues out of $15$. So the sharpening is active exactly on the open regime and inert exactly on the settled one. That is the correct shape for a sharpening; **what limits it is magnitude, not location**, the gain is proportional to the gap $\lambda^{(2)}_{\min}-\lambda_{\min}$, which at a spectrum with $N=n(n-1)/2$ spread eigenvalues is one spacing, i.e. $O(1/N)$ relative to the bound. It will not turn a factor-$2$ slack into closure.

### Verdict on U5

**A genuine advance in one statable respect, a repackaging in the other, and it cannot close I24.**

- **Advance**: the positive row is an *independent* bound, not the $\Pi$-bound, and strictly beats **both** standing bounds on the explicitly characterized region $\lvert\lambda_{\min}\rvert<\lambda_{\max}<(n-2)\lvert\lambda_{\min}\rvert$ with $M_{\arg\max}=\lambda_{\min}^2$. That region contains padded $W_{\mathbb{CP}^2}$ at every $n$, **including $n\ge12$ where the conjecture is open and the point is a genuine critical point**: at $n=12$ it returns $2.857738$ where the best previously recorded was $\Pi$'s $4.490731$, an improvement of $1.57\times$. The record should carry $\min(\text{row family},\Pi)$, not the family alone and not $\Pi$ alone.
- **Repackaging**: the negative row is Lemma L70 with an excluded-index sharpening that vanishes at every point where Lemma L70 is currently tight and is $O$(eigenvalue spacing) elsewhere.
- **No closure**: at padded $W_{\mathbb{CP}^2}$, $n=12$, the family's minimum over rows is $2.857738$ against $\theta_0(12)=1.236033$, slack by $2.31\times$, at a critical point in the open regime. A family that overshoots by a factor $2.3$ at a catalogued critical point is not going to force $\theta\le\theta_0$. This is consistent with, and weaker than, T9's finding that the full pinned system already overshoots.

---

## U1, the closed-form block spectrum of $S^p\times S^q$

Every step checks, and I add a tracelessness identity the record does not carry, which pins all three block values at once.

**Einstein normalisation.** For $S^p(r_1)$ the sectional curvature is $k_1=1/r_1^2$ and $\mathrm{Ric}=(p-1)k_1\,g$; likewise $(q-1)k_2$. The Ricci tensor of a Riemannian product is the direct sum of the factors' Ricci tensors, so the product is Einstein **iff** $(p-1)k_1=(q-1)k_2=:\mu$, which is the record's $(p-1)/r_1^2=(q-1)/r_2^2=\mu$. Hence $k_1=\mu/(p-1)$, $k_2=\mu/(q-1)$, and $\mathrm{scal}=\mathrm{tr}(\mu g)=n\mu$. **Confirmed.** (This needs $p,q\ge2$; at $p=1$ the normalisation divides by zero and $\Lambda^2V_1=0$.)

**$R$ on the three blocks.** As an operator on $\Lambda^2\mathbb R^n$: a space form of curvature $k$ has curvature operator $k\cdot\mathrm{Id}$ on $\Lambda^2$; the curvature tensor of a product has no mixed-index components, so $R$ is block diagonal, equal to $k_1\mathrm{Id}$ on $\Lambda^2V_p$, $k_2\mathrm{Id}$ on $\Lambda^2V_q$, and **$0$ on the mixed block $V_p\otimes V_q$**, mixed $2$-planes are flat. **Confirmed.**

**The Weyl decomposition, and whether the Ricci part vanishes.** $R=W+\tfrac1{n-2}\,\mathrm{Ric}_0\owedge g+\tfrac{\mathrm{scal}}{2n(n-1)}\,g\owedge g$. The product is Einstein by construction, so $\mathrm{Ric}_0=0$ and **the Ricci part vanishes identically**, the one step where the Einstein normalisation is doing real work rather than bookkeeping. The scalar part as an operator on $\Lambda^2$ is $\tfrac{\mathrm{scal}}{n(n-1)}\mathrm{Id}=\tfrac{n\mu}{n(n-1)}\mathrm{Id}=\tfrac{\mu}{n-1}\mathrm{Id}$. So $W=R-\tfrac{\mu}{n-1}\mathrm{Id}$. **Confirmed.**

**The three eigenvalues.**

$$\Lambda^2V_p:\ \frac{\mu}{p-1}-\frac{\mu}{n-1}=\frac{\mu(n-p)}{(p-1)(n-1)},\qquad \Lambda^2V_q:\ \frac{\mu(n-q)}{(q-1)(n-1)},\qquad \text{mixed}:\ -\frac{\mu}{n-1}.$$

**Independent check the record does not carry.** $W$ must be trace-free on $\Lambda^2$. With $\dim\Lambda^2V_p=\tfrac{p(p-1)}2$, $\dim\Lambda^2V_q=\tfrac{q(q-1)}2$, $\dim(\text{mixed})=pq$, and $n-p=q$, $n-q=p$:

$$\mathrm{tr}\,W=\frac{\mu}{n-1}\left[\frac{p(p-1)}2\cdot\frac{q}{p-1}+\frac{q(q-1)}2\cdot\frac{p}{q-1}-pq\right]=\frac{\mu}{n-1}\left[\frac{pq}2+\frac{pq}2-pq\right]=0$$

**exactly, for every $p,q$.** Tracelessness is one linear condition on three unknowns and it is satisfied identically, which is a real check on the arithmetic rather than a restatement of it.

**$\lambda_{\min}$ is always the mixed block.** For $\mu>0$ and $p,q\ge2$ the two $\Lambda^2$ values are strictly positive and the mixed value is strictly negative. **Confirmed, unconditionally.**

**$p=2$: $\lambda_{\max}$ sits on $\Lambda^2V_2$.** The two positive values are $\tfrac{\mu(n-2)}{n-1}$ and $\tfrac{2\mu}{(n-3)(n-1)}$, so the comparison is $n-2$ against $2/(n-3)$:

$$n-2>\frac2{n-3}\iff n^2-5n+6>2\iff n^2-5n+4>0\iff (n-1)(n-4)>0\iff n\ge5.$$

**Confirmed**, with $n=4$ the equality case, which is the balanced product $S^2\times S^2$, as it should be.

**The ratio is $n-2$ exactly.**

$$\frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac{\mu(n-2)/(n-1)}{\mu/(n-1)}=n-2,$$

with the $\mu/(n-1)$ cancelling identically, so it holds at every radius and every $n\ge5$, odd and even. **$S^2\times S^{n-2}$ saturates Lemma L73 at every $n\ge5$. Confirmed.** The other half of Lemma L73 is slack there: $\lvert\lambda_{\min}\rvert/\lambda_{\max}=1/(n-2)$.

**Balanced cross-check.** $p=q=n/2$ gives $\lambda_{\max}=\tfrac{\mu(n/2)}{(n/2-1)(n-1)}=\tfrac{\mu n}{(n-2)(n-1)}$ and $\lvert\lambda_{\min}\rvert=\tfrac{\mu}{n-1}$, ratio $n/(n-2)$, **matches the record's independent hold.** And it is genuinely slack against $n-2$ for $n\ge5$, which is exactly why "slack at every sphere product" looked true: the family of ratios runs from $n/(n-2)$ at the balanced end up to $n-2$ at the extreme unbalanced end, and only the endpoint saturates.

**A consequence worth recording, which falls out of the same normalisation.** Imposing $\lVert W\rVert=1$ at the balanced product: with $h=\lambda_{\max}$, $m=\lvert\lambda_{\min}\rvert$, $h=mn/(n-2)$, and multiplicities $\tfrac{n(n-2)}4$ and $\tfrac{n^2}4$,

$$1=\frac{n(n-2)}4h^2+\frac{n^2}4m^2=m^2\frac{n^2}4\left[\frac{n}{n-2}+1\right]=m^2\frac{n^2(n-1)}{2(n-2)}\ \Longrightarrow\ m=\frac1n\sqrt{\frac{2(n-2)}{n-1}},$$

so $\lambda_{\min}+(n-2)\lambda_{\max}=-m+mn=(n-1)m=\tfrac1n\sqrt{2(n-1)(n-2)}=\theta_0(n)$ **identically**. The same computation gives $(n-1)\lvert\lambda_{\min}\rvert=\theta_0(n)$, so **Lemma L70 and the $\Pi$-bound coincide at the balanced product**, worth stating, because it is the reason the two look interchangeable there and are not.

**U1 verdict: CONFIRMED, every step.**

---

## U2, "Lemma L73 is the whole of what the row calculus says on $\mathcal W_n$"

### The split itself is right

(A) is basis-independent Lie algebra: $\sum_{b,c}c_{abc}^2=\sum_b\lVert[v_a,v_b]\rVert^2=-\mathrm{tr}(\mathrm{ad}(v_a)^2)=-B(v_a,v_a)=-(n-2)\mathrm{tr}(v_a^2)=2(n-2)$ for a unit $v_a\in\mathfrak{so}(n)$. No curvature hypothesis anywhere. (B) is $W\#I=-W$, Böhm–Wilking's Ricci-flat first-Bianchi identity, holding on all of $\mathcal W_n$. (C) is literally the diagonal of $W^\#=\theta W-W^2$ and is a critical-point statement. **The classification of the three relations by where they hold is CONFIRMED**, and I add two consistency checks that pass: summing (B) over $a$ gives $\sum_b\lambda_b\cdot2(n-2)=0=-2\sum_a\lambda_a$ by tracelessness; and summing (C) over $a$ gives $-2\lVert W\rVert^2$ on both sides once total symmetry of $T$ is used to re-index. Two independent relations agreeing on their common contraction is not a proof of either, but a sign error in either would have shown here.

### "The whole of" does not survive

**Objection 1, it is not even the whole of *one* row.** The complete content of row $a$ of (A)+(B) is that $-\lambda_a/(n-2)$ lies in the range of the averaged quantity, and the averaged quantity is $\tfrac{\lambda_b+\lambda_c}2$ over pairs with $b\ne c$, $b\ne a$, $c\ne a$. Its minimum is the mean of the **two smallest eigenvalues excluding $a$**, not $\lambda_{\min}$. Lemma L73's boxed statement uses $\lambda_{\min}$ and $\lambda_{\max}$, so it is the *weakened* per-row condition. The record knows this (the sharpening is stated in the adjacent block) but then writes "Lemma L73 is the whole of what the row calculus says", which contradicts it two paragraphs above.

**Objection 2, the substantive one, the rows are coupled, and the coupling is a doubly-stochastic condition.** Set $S_{ab}:=\sum_cT_{abc}$. Total symmetry of $T$ makes $S$ symmetric; $T$ vanishing on repeated indices makes $S_{aa}=0$; $T\ge0$ makes $S\ge0$ entrywise. Then (A) reads $\sum_bS_{ab}=2(n-2)$ for every $a$ and (B) reads $\sum_b\lambda_bS_{ab}=-2\lambda_a$ for every $a$. Normalising $P:=S/(2(n-2))$:

> **The complete content of (A)+(B) at the pair level is: $\lambda$ is an eigenvector of eigenvalue $-\tfrac1{n-2}$ of some symmetric, entrywise-nonnegative, hollow, doubly stochastic $N\times N$ matrix $P$, where $N=n(n-1)/2$.**

Lemma L73 is the **single-index** reading of this: $(P\lambda)_a$ is a convex combination of $\{\lambda_b:b\ne a\}$, so $-\lambda_a/(n-2)\in[\min_{b\ne a}\lambda_b,\max_{b\ne a}\lambda_b]$. **But the same object gives a block version the record does not have.** For any index set $A$, put $w_b:=\sum_{a\in A}P_{ab}$. Symmetry and unit column sums give $w_b\in[0,1]$, and $\sum_bw_b=|A|$. Hence

$$-\frac1{n-2}\sum_{a\in A}\lambda_a=\sum_bw_b\lambda_b\in\Big[\textstyle\sum_{k=1}^{|A|}\lambda_{(k)},\ \sum_{k=1}^{|A|}\lambda_{(N-k+1)}\Big],$$

$\lambda_{(1)}\le\cdots\le\lambda_{(N)}$ being the sorted spectrum. **A whole family of purely spectral necessary conditions on $\mathcal W_n$, one per subset size, indexed by partial sums rather than by single entries**; $|A|=1$ recovers Lemma L73's weak form. This is a strictly larger body of consequences of the same two relations, obtained without touching (C), so **"Lemma L73 is the whole of what the row calculus says on $\mathcal W_n$" is refuted by construction**, and I24's step 1 loses its stopping argument.

**Objection 3, the record refutes itself on the critical-set half too.** The parallel claim, "the per-row family is the whole of what it says at critical points", is contradicted two paragraphs later: *"The full system is strictly stronger, since it reads every row and both moments at once; that is why r331's screen returns the true $\theta$ where Lemma L70 alone is slack by $2.1$."* A measured slack of $2.1$ between the union of rows and the joint system is precisely a refutation of "the whole of".

**U2 verdict: the split is CONFIRMED; "the whole of" is REFUTED AS STATED.** The honest form is *"all that has been extracted so far, by reading rows one at a time"*. **Repair**: replace it with the doubly-stochastic eigenvector statement above, and note that its subset-sum corollary is unexplored. Consequence for the plan: I24's step (1) does not bound the item in the way [plan.md](../plan.md) records; it bounds only the single-row reading.

---

## U3, which row is optimal

### The two bounds are derived correctly

Row $a$ of (C) reads $\mathbb E_{\mu_a}[\lambda_b\lambda_c]=\lambda_a(\theta-\lambda_a)/(n-2)\in[m_a,M_a]$. For $\lambda_a>0$, $\lambda_a(\theta-\lambda_a)/(n-2)\le M_a$ gives $\theta\le\lambda_a+(n-2)M_a/\lambda_a$. For $\lambda_a<0$, $m_a\le\lambda_a(\theta-\lambda_a)/(n-2)$ and division by the negative $\lambda_a$ **flips** to give $\theta\le\lambda_a+(n-2)m_a/\lambda_a$. **Both correct**, including the flip. Rows with $\lambda_a=0$ give $0=0$ and are vacuous, worth stating, since padded $W_{\mathbb{CP}^2}$ at $n=12$ has $63$ of its $66$ rows in that state.

### The negative side: the record's conclusion is right, and robustly so

Write $\lambda_a=-x$, $x>0$, $m_a=-y$, $y>0$. The bound is $g(x)=-x+(n-2)y/x$, **monotonically decreasing in $x$ for every fixed $y>0$**, both terms decrease. There is no turning point and no unimodality to get wrong. So larger $\lvert\lambda_a\rvert$ is strictly stronger, and $\lambda_{\min}$ is optimal. The row-dependence of $y$ reinforces rather than threatens this: if $\lambda_{\min}$ is simple then $y_{\arg\min}=\lambda_{\max}\lvert\lambda^{(2)}_{\min}\rvert<\lambda_{\max}\lvert\lambda_{\min}\rvert=y_a$ for the other negative rows, so **the $\arg\min$ row wins on both factors at once.** **CONFIRMED, and on a sounder footing than the record gives it.**

### The positive side: the withdrawal replaced one error with an unproved claim

The record's argument is: with $c=(n-2)M_a>0$, $f(x)=x+c/x$ has $f'(x)=1-c/x^2<0$ for $x<\sqrt c$, so $f$ decreases and $\lambda_{\max}$ is optimal. **The inference is valid only if every positive eigenvalue lies in $(0,\sqrt c)$, i.e. only if $\lambda_{\max}^2\le(n-2)M_a$**, and the record never checks it. The brief is right that the withdrawal did not address this.

**It fails at the record's own flagship witness.** At $S^2\times S^{n-2}$, in units $\mu/(n-1)=1$: $h=n-2$ (multiplicity $1$), $t=2/(n-3)$, mixed $=-1$. Deleting the single $\arg\max$ index leaves $\{t,-1\}$, so $M_{\arg\max}=\max(t^2,1)=1$ for $n\ge5$, hence $c=n-2$ and

$$\lambda_{\max}^2=(n-2)^2\;>\;n-2=c\qquad\text{for every }n\ge4.$$

**So $f$ is strictly *increasing* at $\lambda_{\max}$ at the very point the record advertises as Lemma L73's saturating witness, and the monotonicity argument does not apply there at all.**

### The correct criterion, and it repairs the conclusion at that point

For two positive rows with a common $M$, $f(\lambda_a)-f(\lambda_{a'})=(\lambda_a-\lambda_{a'})\big(1-c/(\lambda_a\lambda_{a'})\big)$, so

$$f(\lambda_{\max})\le f(\lambda_a)\iff\lambda_{\max}\lambda_a\le c.$$

Since $\lambda_a\le\lambda_{(2)}$, the second-largest positive eigenvalue:

> **$\lambda_{\max}$ is the optimal positive row iff $\lambda_{\max}\lambda_{(2)}\le(n-2)M$.** The record's condition $\lambda_{\max}^2\le(n-2)M$ is *sufficient* and strictly stronger than necessary.

At $S^2\times S^{n-2}$: $\lambda_{\max}\lambda_{(2)}=ht=2(n-2)/(n-3)\le n-2\iff n\ge5$. **So the conclusion survives at that point, by the corrected criterion, for exactly the dimensions the record claims, but not for the reason the record gives.** (Direct check, allowing $M_a$ to vary: the $h$-row gives $n-1$; the $t$-row has $M_a=\max(ht,1)=2(n-2)/(n-3)$ and gives $t+(n-2)^2$; the $-1$-row gives $(n-2)^2-1$. The $h$-row wins by a wide margin.)

### And the conclusion itself is false in general

Take $n=6$ ($N=15$) and the traceless spectrum

$$\lambda=(0.7,\ 0.42,\ -1,\ \underbrace{-0.01,\dots,-0.01}_{12}),\qquad \textstyle\sum\lambda=0.$$

It satisfies Lemma L73 in both directions: $\lambda_{\max}=0.7\le(n-2)\lvert\lambda_{\min}\rvert=4$ and $\lvert\lambda_{\min}\rvert=1\le(n-2)\lambda_{\max}=2.8$. Deleting either positive index leaves the other positive together with all negatives, so in both rows the maximal product is the product of the **two most negative**, $M=1\times0.01=0.01$, hence $c=(n-2)M=0.04$ and $\sqrt c=0.2$. Both positive eigenvalues lie **above** $\sqrt c$:

$$f(0.7)=0.7+\frac{0.04}{0.7}=0.757143,\qquad f(0.42)=0.42+\frac{0.04}{0.42}=0.515238.$$

**The smaller positive row is strictly stronger, by $0.24$.** Equivalently $\lambda_{\max}\lambda_{(2)}=0.294>0.04=c$. **So "among positive rows $\lambda_{\max}$ is optimal" is false as an unconditional statement about spectra.** The mechanism is exactly the one the withdrawal skipped: a simple, isolated $\lambda_{\max}$ together with a $\lambda_{\min}$ that is itself nearly isolated drives $M$ down until $\sqrt c$ falls below the whole positive part.

*Scope*: this is a spectrum, not an exhibited Weyl tensor, so it refutes the **general claim about the family** rather than exhibiting a Weyl tensor at which $\lambda_{\max}$ loses. Given that the record has no realizability criterion for Weyl spectra ([LIT-spectra](LIT-spectra.md)), that is the strongest statement available by algebra, and it is enough: the claim as written in [plan.md](../plan.md) ("$\lambda_{\max}$ and $\lambda_{\min}$ are the **optimal** rows on their sides"), is a claim about the family and it is false.

**U3 verdict: REFUTED AS STATED, with repair.** The negative half is confirmed and is unconditional. The positive half needs the side condition $\lambda_{\max}\lambda_{(2)}\le(n-2)M$; that condition holds at both catalogued points but fails on admissible spectra, and the record's own condition $\lambda_{\max}<\sqrt c$ **fails at $S^2\times S^{n-2}$**. This is the *second* inversion in this one paragraph: the first claim was wrong, the withdrawal's replacement is unproved and false in general.

---

## U4, the balanced product

**Negative side, tight.** $E_{\min}$ has multiplicity $n^2/4$ and $E_{\max}$ multiplicity $n(n-2)/4$. Deleting one index from $E_{\min}$ leaves at least one further $E_{\min}$ index whenever $n^2/4\ge2$, i.e. $n\ge3$, and leaves $E_{\max}$ untouched. So a $(b,c)$ pair with $\lambda_b=h$, $\lambda_c=-m$ survives and $m_a=\min\{h^2,-hm,m^2\}=-hm$, unchanged from the global minimum. Then

$$\theta\le\lambda_a+\frac{(n-2)m_a}{\lambda_a}=-m+\frac{(n-2)(-hm)}{-m}=-m+(n-2)h=-m+(n-2)\frac{mn}{n-2}=(n-1)m=\theta_0(n)$$

using the unit-norm value $m=\tfrac1n\sqrt{2(n-2)/(n-1)}$ derived in U1. **Exactly $\theta_0$. CONFIRMED.**

**Positive side, slack by exactly $n/(n-2)$.** Deleting one index from $E_{\max}$ leaves $n(n-2)/4-1\ge1$ further $E_{\max}$ indices for $n\ge4$, so both $h^2$ and $m^2$ are available and $M_a=\max(h^2,m^2)=h^2$ since $h/m=n/(n-2)>1$. Then

$$\theta\le h+\frac{(n-2)h^2}{h}=(n-1)h=(n-1)m\cdot\frac{n}{n-2}=\theta_0(n)\cdot\frac{n}{n-2}.$$

**Exactly $n/(n-2)$. CONFIRMED.** The record's alternative phrasing $\theta_0=(n-2)h(n-1)/n$ is the same identity. Note $n/(n-2)\to1$: the slack is $2/(n-2)$ relative, so at $n=12$ it is $20\%$, small, but a factor above $1$ is a factor above $1$.

**The inference.** "A family slack at the extremum on its positive half cannot close the conjecture through that half" is **valid, and elementary**: the positive half is a valid upper bound $B^+$ with $B^+(W_{\text{bal}})=\theta_0\cdot n/(n-2)>\theta_0$, and no valid upper bound that exceeds $\theta_0$ at an admissible point can establish $\theta\le\theta_0$ everywhere. **CONFIRMED.**

**Two flags on how it is used.** First, the family is $\min$ over **all** rows, and that minimum *is* exactly $\theta_0$ at the extremum, the family as a whole does **not** overshoot there, which is the necessary condition a closing bound must satisfy and which the family passes. The plan's summary reads as though the slack disqualifies the family; it disqualifies one half of it. Second, "cannot close the conjecture through that half" is true only for the positive half **acting alone**. A bound slack solely at the maximiser and tight elsewhere would still be the more useful half of a two-case argument, the extremum being handled by [Lemma L71](../findings/bounds.md)'s rigidity. That case split is not addressed, and the record's phrasing forecloses it.

---

## What I would change in the record

1. **[findings/bounds.md](../findings/bounds.md), the row-family block**, strike *"its positive half is the $\Pi$-bound"*. State instead that the two are different relaxations of the same row, that neither dominates, and that the positive row strictly beats $\Pi$ **iff** $\lvert\lambda_{\min}\rvert<\lambda_{\max}<(n-2)\lvert\lambda_{\min}\rvert$ when $M_{\arg\max}=\lambda_{\min}^2$. Record $\min(\text{row family},\Pi)$ as the standing bound.
2. **The triple**, fix it as the **$n=8$** figures, in the record's own order: row-min $2.041241$, Lemma L70 $4.490731$, $\Pi$ $2.857738$. Add the closed forms $\tfrac{n+2}2a$, $(2n-5)a$, $(n-1)a$ with $a=1/\sqrt6$, which make the dimension explicit and settle the r335/r336 dispute in **r336's** favour.
3. **The monotonicity paragraph**, the withdrawal is itself defective. Replace "$f$ is decreasing, so $\lambda_{\max}$ is optimal" with the criterion $\lambda_{\max}\lambda_{(2)}\le(n-2)M$, and record that $\lambda_{\max}^2>(n-2)M_{\arg\max}$ **at $S^2\times S^{n-2}$**, together with the $n=6$ spectrum above where the conclusion fails outright. Note that the negative side needs no such condition.
4. **[plan.md](../plan.md), I24 step (1) and the bounds.md line that feeds it**, "Lemma L73 is the whole of what the row calculus gives on $\mathcal W_n$" is false. Replace with the doubly-stochastic eigenvector characterisation of (A)+(B), and open its subset-sum corollary as the unexplored consequence. I24's step (1) does not bound the item.
5. **[plan.md](../plan.md), I24 step (2)**, "$\lambda_{\max}$ and $\lambda_{\min}$ are the optimal rows on their sides" needs the side condition attached or the claim narrowed to the two catalogued points.
6. **[plan.md](../plan.md), I24 step (3)**, say "its positive half alone", and record that the family's $\min$ over rows is exactly $\theta_0$ at the extremum.
7. **The excluded-index sharpening**, record that it is inert exactly where the conjecture is settled and active exactly where it is open (generic critical points have simple eigenvalues), and that its size is $(n-2)\lambda_{\max}(\lambda^{(2)}_{\min}-\lambda_{\min})/\lvert\lambda_{\min}\rvert$, one eigenvalue spacing.

## Screen taken

One arithmetic evaluation, seconds, on spectra I wrote down myself: the padded $\mathbb{CP}^2$ table above, the two values $f(0.7)$ and $f(0.42)$, and $\lambda_{\max}^2$ versus $(n-2)M_a$ at $S^2\times S^{n-2}$ for $n=5,6,8,12$. Every figure agrees with the closed forms derived above; the screen is transcription insurance and is not evidence for any claim here. It also records the boundary case $n=5$, where $ht=3=c$ exactly and the two positive rows tie.
