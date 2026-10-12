# Reviewer r734, Gate 2 on L162 and two applied corrections

**Brief:** `gate2-L162.md`. Three items: (1) [L162](../findings/second-order.md), the composed binding constant $F(w_0)$; (2a) the [problem.md](../findings/problem.md) correction on the $(\tfrac12,\tfrac15)$ corner; (2b) the [target.md](../findings/target.md) / [results.md](../results.md) correction on $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ and criticality.

**Verdicts.** Item 1 **REFUTED AS STATED**, the arithmetic is exact and reproduces, the minimiser claim fails from $n=16$, and the monotonicity the lemma calls for points the opposite way from the quantity the chain binds on. Item 2(a) **CONFIRMED**, with two precision defects. Item 2(b) **CONFIRMED**, with one clause **REFUTED**.

Analysis only. Every figure below is exact rational or symbolic arithmetic carried to seven digits on objects constructed for the check; nothing was swept or searched.

---

## Item 1, Lemma L162

### What reproduces, and is confirmed

**$C(n)=\frac{2(2n-3)}{n-1}$, CONFIRMED, and its derivation is sound.** [L156](../findings/second-order.md) gives $\alpha^*=\tfrac{2m-1}{2(m-1)}$ and $D=\tfrac{2m-1}{m-1}$ on $W^*=S^m\times S^m$, so $D=2\alpha^*$ is L156's own relation and not an assumption. At $n=2m$, $\alpha^*=\tfrac{n-1}{n-2}$, $D=\tfrac{2(n-1)}{n-2}$ and $C=2+\tfrac4D=\tfrac{2(n-1)+2(n-2)}{n-1}=\tfrac{2(2n-3)}{n-1}$, which is $\tfrac{42}{11}$ at $n=12$ and rises to $4$, matching L156's printed value and its corollary interval $\tfrac{42}{11}\le C^*<4$ at both ends.

**$C$'s $J$ and the $J$ inside $t$ are the same constant, CONFIRMED.** $J:=C/\gamma$ by definition, so $J\gamma=C$ identically, and at the optimum $J^*\gamma^*=\tfrac{6.9421\cdot11}{20}=\tfrac{42}{11}=C^*$. L156 states $\alpha$ and $\gamma$ in one hypothesis, so the two are the same contour. The composition is safe here: $F$ depends on the contour only through $\beta=\lambda/(2C)$, and the $J$ that divides $K$ in [L158](../findings/second-order.md)'s branch-2 display never enters $F$.

**$\rho^{\mathrm{eff}}_n$, CONFIRMED as identically L149's penalised margin.** $3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert$ with $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ gives $\tfrac29\lvert\kappa_n\rvert=2\theta_0-\sqrt6$, so the expression is $\sqrt6+\theta_0\big[\tfrac{3(n-8)}{2(n-2)}-2\big]=\sqrt6-\theta_0\tfrac{n+16}{2(n-2)}$. The two forms are one expression, not two agreeing evaluations.

**Both headline values, CONFIRMED to the printed digits.** At $n=12$: $\theta_0=\tfrac{\sqrt{55}}6=1.2360331$, $c_p=0.3708099$, $\rho^{\mathrm{eff}}=\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434$, $s_0=0.8308940$, $\lvert\kappa_{12}\rvert=0.1015939$, $\lambda=6.2747210$, $\beta=\tfrac{11\lambda}{84}=0.8216950$, $q_0=1.9315700$, **$F=0.3867310$**. In the limit: $\rho^{\mathrm{eff}}\to\sqrt6-\tfrac{\sqrt2}2=1.7423830$, $s_0\to1.3199936$, $\lambda\to1.5315714$, $\beta\to0.1914464$, **$F\to0.9030360$**.

### REFUTED, the statement's own object

**"the binding value of L158's envelope-free $G$ at its minimiser" is false: $w_0$ is not $G$'s minimiser, and $G$ has no interior one.** From $q^2=4\beta s+1$, $\tfrac{\mathrm d\log(q+1)}{\mathrm d\log s}=\tfrac{2\beta s}{q(q+1)}=\tfrac{q-1}{2q}$, so

$$\frac{\mathrm d\log G}{\mathrm d\log s}=1-\frac{q-1}{q}=\frac1q=\frac1{\sqrt{4\beta s+1}}\in(0,1),$$

which is L158's own settled display. $s(w)=\sqrt{c_p+\rho^{\mathrm{eff}}w^2}$ is strictly increasing, so **$G$ is strictly increasing on $[0,1]$ and its minimiser is $w=0$**, where $G=4\sqrt{c_p}/(\sqrt{4\beta\sqrt{c_p}+1}+1)^2$. The minimiser $w_0$ belongs to $F=G/\phi$, and the Scope paragraph says so; the Statement says otherwise. This is the composition failure the brief names (an optimum taken for one objective and attached to another) and it is visible inside the lemma, between its own two paragraphs.

### REFUTED, $w_0$ is not $F$'s minimiser either, from $n=16$ up

$\phi=\min(\psi,1)$ with $\psi(w)=\sqrt{2/(n-2)}\,\sqrt{1-w^2}+w$, and $\psi=1$ exactly at $w_0=\tfrac{n-4}n$ and at $w=1$, with $\psi\le1$ below and $\ge1$ between, so $\phi=\psi$ on $[0,w_0]$ and $\phi\equiv1$ on $[w_0,1]$. Since $1-w_0^2=\tfrac{8(n-2)}{n^2}$,

$$\phi'(w_0)=1-\sqrt{\tfrac2{n-2}}\cdot\frac{(n-4)/n}{2\sqrt2\sqrt{n-2}/n}=1-\frac{n-4}{2(n-2)}=\frac n{2(n-2)},$$

which is L158's $\tfrac35$ at $n=12$ in closed form and falls to $\tfrac12$. Because $\phi(w_0)=1$, $w_0$ is a local minimum of $F$ from the left exactly when $(\log G)'(w_0)\le\tfrac n{2(n-2)}$. Against $(\log G)'=\tfrac1q\cdot\tfrac{\rho^{\mathrm{eff}}w}{s^2}$:

| $n$ | $(\log G)'(w_0)$ | $\phi'(w_0)=\tfrac n{2(n-2)}$ | $w_0$ a minimum? |
| --- | --- | --- | --- |
| 12 | $0.359463$ | $0.600000$ | yes |
| 14 | $0.510800$ | $0.583333$ | yes |
| **16** | **$0.584856$** | **$0.571429$** | **no** |
| 20 | $0.655470$ | $0.555556$ | no |

Above $w_0$ the envelope is constant and $F=G$ rises. So **at $n\ge16$ $F$ rises through $w_0$ from both sides and $w_0$ is not a minimum of anything**; the minimum is interior and strictly to its left. Screened at $n=20$: $F(w_0)=0.639162$ against $F(0.70)=0.636122$, the minimum, **$0.48\%$ lower**. At $n=16$ the crossing is at $w\approx0.740$ and the deficit is $0.010\%$.

**The direction is unsafe.** Branch 2 is proportional to $F$ and enters as a *lower* bound on the tube radius, so a value read at $w_0$ where the infimum sits lower **overstates the bound**.

**L158 flags exactly this and L162 imports the conclusion without the restriction.** L158's settled box says the kink argument is *"$n$-local and is not claimed beyond $n=12$"*, giving the reason, $\tfrac1{2\sqrt{c_p}}\sim0.243\sqrt n$ grows while $\phi'(w_0)\downarrow\tfrac12$. The record's uniform bound $(\log G)'\le\tfrac{\sqrt{\rho^{\mathrm{eff}}}}{2\sqrt{c_p}\,q_{\min}}$ (its "$s_{\min}$" is $q_{\min}=\sqrt{4\beta\sqrt{c_p}+1}$, a third use of the letter $s$ in the chain) is $0.401881$ at $n=12$ and already $0.586045>\tfrac{7}{12}$ at $n=14$, the sufficient condition fails one dimension after it is proved, and the conclusion survives at $n=14$ only on the sharper reading above.

*Asymptotically the kink recovers its status as the global minimum but never as a local one:* $(\log G)'(w_0)\to1/\sqrt{4\beta\sqrt{\rho^{\mathrm{eff}}}+1}=0.70522$ against $\phi'(w_0)\to\tfrac12$, so the boundary-layer minimum sits at $1-w\approx11.5/n$ against $w_0$'s $4/n$, and the deficit is $O(1/n)$.

**Falsifier for this finding:** any $w\in(0,w_0)$ at $n=16$ or $n=20$ with $F(w)\ge F(w_0)$ throughout, or a reading of the envelope on which $\phi(w_0)\ne1$.

### REFUTED, the monotonicity box's reason, though not its claim

The box argues the monotonicity is wanted because *"that $n=12$ is the worst case is what lets a bound established there carry to every even $n$ above it"*. **It does not.** L158's own branch-2 display makes branch 2 $=\tfrac{\lambda}{\sqrt2\,J\,n}\cdot\tfrac{G}{\phi}$, so the chain's quantity is $n\cdot\text{branch }2=\tfrac{\lambda}{\sqrt2 J}F$, and the factor L162 drops moves against $F$ four times as fast:

| $n$ | $\lambda$ | $J^*=\tfrac{4(1+\alpha^*)}{\alpha^{*2}}$ | $F(w_0)$ | $n\cdot\text{branch }2$ |
| --- | --- | --- | --- | --- |
| 12 | $6.274721$ | $6.942149$ | $0.386731$ | $0.247156$ |
| 14 | $3.468880$ | $7.100592$ | $0.514412$ | $0.177700$ |
| $\infty$ | $1.531571$ | $8$ | $0.903036$ | $0.122246$ |

$0.247156/12=0.020596$ at $n=12$ is L158's own printed $0.0206$, which confirms the reading. **So $n=12$ is the *best* case for the chain and the worst case for $F$**, and proving $F$ increasing delivers the opposite of what the box says it delivers. Falsifier: a reading on which branch 2 carries $\lambda$ and $J$ at fixed values rather than at the dimension in hand, which is the error L158 charges against the $17$–$19$ band and against $\lambda(\infty)$.

### The monotonicity, partly proved, and its load-bearing consequence proved outright

$F$ depends on $n$ only through $s_0$ and $\beta$, and $\partial\log F/\partial\log s_0=1/q>0$ while $\partial\log F/\partial\log\beta=-\tfrac{q-1}q<0$. So **$s_0$ increasing and $\beta$ decreasing suffice**, which reduces the box's four constants to two.

**$\beta$ is strictly decreasing, proved.** $\theta_0^2=2\big(1-\tfrac3n+\tfrac2{n^2}\big)$ has derivative $\tfrac{2(3n-4)}{n^3}>0$, so $\theta_0\uparrow$, so $\theta_0-\sqrt{3/2}\uparrow$ and $\lambda=\tfrac2{3\sqrt{\theta_0-\sqrt{3/2}}}\downarrow$; and $C=4-\tfrac2{n-1}\uparrow$. Hence $\beta=\lambda/(2C)$ is strictly decreasing on $n\ge12$.

**$F(n)>F(12)$ at every even $n\ge14$, proved.** Writing $s_0^2=c_p+\rho^{\mathrm{eff}}_nw_0^2$, the product $\rho^{\mathrm{eff}}_nw_0^2$ is two positive increasing factors ($\rho^{\mathrm{eff}}$ increasing is L149's), so $\rho^{\mathrm{eff}}_nw_0^2\ge\rho^{\mathrm{eff}}_{20}w_0(20)^2=0.730765>0.690385=s_0^2(12)$ for every $n\ge20$, whence $s_0^2(n)>s_0^2(12)$ there without needing $c_p$ at all; and $s_0^2$ is $0.760517$, $0.828895$, $0.891890$ at $n=14,16,18$, each above $0.690385$. With $\beta$ decreasing, $F(s_0(n),\beta(n))\ge F(s_0(12),\beta(n))\ge F(s_0(12),\beta(12))$. **What remains owed is full monotonicity, and it is now one statement ($s_0(n)$ increasing), not four.** Its closed form is

$$s_0^2=\frac{\sqrt6\,(n-4)^2}{n^2}-\frac{\theta_0(n)\,(n^3+2n^2-112n+256)}{2n^2(n-2)},$$

whose derivative I check positive at $n=12$ ($+0.034164$, from $+0.064503$ on the first group and $-0.030339$ on the second) and whose expansion is $1.742383-21.36/n+O(n^{-2})$, so the two ends run the right way.

### Two further defects

**The title reinstates a label the record struck.** L158's settled box says of this very number: *"It was recorded as a lower bound on the tube radius. **It is $G$**, branch 2 without its $\lambda/(\sqrt2J)$ and $1/n$, which is $0.0206$ at $w_0$ … **What was wrong is the label, not the value.**"* L162's heading calls $F(w_0)$ **the binding constant of the tube chain**. The Scope paragraph disowns it in the next breath, so the file contradicts its own heading, and the heading is what an index propagates.

**$\gamma^*$ optimises a third objective.** $\gamma^*=D/4$ is $\arg\min_\gamma J$; L156 records that the *reach* wants a larger $\gamma^\dagger$. Branch 2 wants neither: it is proportional to $\tfrac{(1-\eta^*)^2}J=\tfrac{\gamma(\alpha^*-\gamma)}{1+\alpha^*}(1-\eta^*)^2$, in which raising $\gamma$ lowers $C$'s reciprocal *and* raises $(1-\eta^*)^2$. Screened at $n=12$, $\alpha^*=1.1$: the objective is $0.0670458$ at $\gamma^*=0.55$, $0.0709505$ at $\gamma=0.75$ and $0.0716630$ at $\gamma=0.70$, **$6.9\%$ of headroom left on the table**. The direction is conservative, as L156 says of the reach, but $F(w_0)$ is therefore the value at a contour chosen for a quantity the chain does not use, and the lemma calls it *the* binding constant.

### Two cautions

**$\theta_0(n)$ is used with no pointer to [conventions.md](../findings/conventions.md)**, on the one constant whose retired gloss $\sqrt{2(n-1)/(n-2)}$ has misled three reviewers in two days. Under that gloss the same formulas give $c_p=0.4449719$, $\rho^{\mathrm{eff}}_{12}=0.3729541$, $\lambda=1.3112430$ and **$F(12)=0.623200$**, a different lemma.

**$F$ is badly conditioned in $\theta_0$ at $n=12$.** $\theta_0-\sqrt{3/2}=0.0112882$ against $\theta_0=1.2360331$, so a relative perturbation of $\theta_0$ is amplified $109.5\times$ in $\lvert\kappa_n\rvert$; through $\lambda$ alone $\mathrm d\log F/\mathrm d\log\theta_0=+26.4$. The closed form is exact and the printed five digits are right, but they require $\theta_0$ to eight significant figures, which is worth saying where the record's habit is to quote values.

### Parity

**Everything in the lemma is even-$n$, and $w_0$ is the piece with the *least* claim to be the reason.** $\alpha^*=\tfrac{2m-1}{2(m-1)}$, $D$, $C$ and $J$ are functions of $m$ re-parametrised through $m=n/2$; $\theta_0(n)$ equals the target $\Theta_n$ at even $n$ only ([conventions.md](../findings/conventions.md)); and $W^*=S^m\times S^m$ has no odd-$n$ member at all, so L156's hypotheses do not merely weaken off the even integers, they are undefined. By contrast $w_0$ comes from $\sqrt{2/(n-2)}$, a formula in $n$ that happens to equal $1/\sqrt{m-1}$. The Scope sentence's *"the parity of the balanced sphere product; $w_0=\tfrac{n-4}n$ is …"* attaches the restriction to the one constant that does not need it.

---

## Item 2(a), the $(\tfrac12,\tfrac15)$ corner at [problem.md](../findings/problem.md)

**CONFIRMED, clause by clause, with two precision defects.**

$E(12)$ reproduces exactly from the block's own $E(n)=\tfrac{8n^2-41n+49}{4(n+1)(n-2)(n-3)}$: numerator $1152-492+49=709$, denominator $4\cdot13\cdot10\cdot9=4680$, so $E(12)=\tfrac{709}{4680}=0.1514957$.

| clause | verdict |
| --- | --- |
| $(\tfrac12,\tfrac15)$ excluded by $(\operatorname{tr}S^3)^2\le\operatorname{tr}S^4$ | **true**: $\tfrac14>\tfrac15$ |
| $(\tfrac12,\tfrac15)$ admitted by $\operatorname{tr}S^3\ge1/\sqrt{12}$ | **true**: $\tfrac12>0.2886751$ |
| the corner sits on the working edge with equality | **true by construction**, its first coordinate being the floor |
| the Cauchy–Schwarz edge admits the corner | **true**: $\tfrac1{12}=0.0833333\le\tfrac{709}{4680}=0.1514957$ |
| equality forces the flat spectrum | **true, and by a shorter route than the block gives** |
| the flat spectrum forces $\operatorname{tr}S^4=\tfrac1{12}<E(12)$ | **true**: $12\cdot12^{-2}=\tfrac1{12}$ |

**The equality case is unique to the flat spectrum, CONFIRMED, and the block understates its own argument.** The working edge is a chain of two: $\operatorname{tr}S^3\ge\tfrac{(\operatorname{tr}S^2)^2}{\operatorname{tr}S}=\tfrac1{\operatorname{tr}S}\ge\tfrac1{\sqrt n}$, the first from $\sum\lambda^2=\sum\lambda^{1/2}\lambda^{3/2}$ and the second from $\sum\lambda\cdot1\le\sqrt n\sqrt{\sum\lambda^2}$, both needing $S\succeq0$ and $\operatorname{tr}S^2=1$ and nothing else. Equality at the end forces equality in **both**, and the second alone has equality iff $(\lambda_i)\parallel(1,\dots,1)$, the flat spectrum, with no appeal to the first. Then $\lambda_i\equiv12^{-1/2}$ and $\operatorname{tr}S^4=\tfrac1{12}$, which is simultaneously the floor of $\operatorname{tr}S^4$ under $\operatorname{tr}S^2=1$.

**Defect 1, "the Cauchy–Schwarz equality binds only at the flat spectrum" is false of one of the two Cauchy–Schwarz inequalities the same paragraph names.** For $(\operatorname{tr}S^2)^2\le(\operatorname{tr}S)(\operatorname{tr}S^3)$ the equality case is $(\lambda_i^{1/2})\parallel(\lambda_i^{3/2})$, i.e. *all non-zero eigenvalues equal*, which admits every rank-$k$ flat spectrum $\lambda=(k^{-1/2},\dots,k^{-1/2},0,\dots,0)$. Those are excluded from the corner only downstream, by $\operatorname{tr}S^3=1/\sqrt k>1/\sqrt{12}$ for $k<12$. The block should name which inequality it means; it names both four lines apart.

**Defect 2, the witness pair lies outside the box it is offered to describe.** *"A box bounding the two traces separately admits $(\tfrac12,\tfrac15)$"* is false of Jäger's box at $n=12$: $\tfrac15=0.2$ exceeds the ceiling $E(12)=0.1514957$, so that box already excludes the pair on the $\operatorname{tr}S^4$ coordinate and neither edge is required. The pair also fails under the transposed reading, $\tfrac12>E(12)$. The two edges' division of labour is correctly described; the illustration is of a hypothetical box, not of the one the paragraph is about.

**Falsifier for the confirmation:** a PSD $S$ on $\mathbb R^{12}$ with $\operatorname{tr}S^2=1$, $\operatorname{tr}S^3=1/\sqrt{12}$ and a non-flat spectrum.

---

## Item 2(b), $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ and criticality

**CONFIRMED. I derive it cold, and criticality enters at no step.** One clause is **REFUTED**.

Write $R_{\alpha\beta}=\lVert[v_\alpha,v_\beta]\rVert^2=\sum_\gamma T_{\alpha\beta\gamma}$ in an orthonormal eigenbasis of $W$. The inputs are [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7, $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$; the total symmetry of $T_{abc}=c_{abc}^2$, which [conventions.md](../findings/conventions.md) derives from ad-invariance; the per-row identity $A(W)=2W$, i.e. $\sum_\beta\lambda_\beta R_{\alpha\beta}=-2\lambda_\alpha$; and the definition of $\#$, which gives $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}T_{\alpha\gamma\delta}\lambda_\gamma\lambda_\delta$ and hence $\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=2\langle W,W^\#\rangle$. Then

$$\sum_\gamma\lambda_\gamma g_\gamma=\sum_{\gamma\alpha\beta}\lambda_\gamma(\lambda_\alpha^2+\lambda_\beta^2-2\lambda_\alpha\lambda_\beta)T_{\gamma\alpha\beta}=2\sum_\alpha\lambda_\alpha^2\Big(\sum_\gamma\lambda_\gamma R_{\alpha\gamma}\Big)-2\cdot2\langle W,W^\#\rangle$$
$$=-4\sum_\alpha\lambda_\alpha^3-4\langle W,W^\#\rangle=-4\langle W,W^2+W^\#\rangle=-4P(W).$$

The companion falls out of the same two contractions with the weight removed: $\sum_\gamma g_\gamma=2\sum_\alpha\lambda_\alpha^2\cdot2(n-2)-2\sum_\alpha\lambda_\alpha(-2\lambda_\alpha)=4(n-1)\lVert W\rVert^2$, using [Lemma L153](../findings/bounds.md)'s row mass $\sum_\beta R_{\alpha\beta}=2(n-2)$.

**Where criticality could have entered, and does not.** Prop 1.7 needs an orthonormal eigenbasis of $W$, which exists at every symmetric $W$; $T$'s symmetry needs only ad-invariance of the inner product; $\#$'s expansion holds off $\mathcal W_n$ entirely; $A(W)=2W$ needs first Bianchi *and* Ricci-flatness, i.e. exactly $W\in\mathcal W_n$, which is the stated hypothesis and not a criticality one. Every term on both sides is homogeneous of degree three, so the identity is scale-covariant as written, which is what [target.md:702](../findings/target.md) fixed. **The repair's headline is right.**

**REFUTED, *"What criticality was ever for is writing $\theta$ in place of $P(W)$, which needs $Q(W)=\theta W$ and unit norm"*.** [conventions.md](../findings/conventions.md) defines $\theta:=P(W)/\lVert W\rVert^3$ and records $Q(W)=\theta W$ as what additionally *holds at a critical point*. Under that definition $\theta=P(W)$ at $\lVert W\rVert=1$ **by definition**, at every $W\in\mathcal W_n$ critical or not, and criticality buys nothing. The clause reads $\theta$ in the second, critical-eigenvalue sense that conventions.md subordinates, a sense [r724](REVIEW_r724.md) has already recorded parting company with the first, and does so in the one sentence whose purpose is to say what criticality is for. **The correct residue is: criticality is for nothing here; the $\theta$ form needs unit norm and the definition, and the $-4P(W)$ form needs neither.** The block's own rule is that conventions are quoted rather than restated, and this clause restates one and gets it wrong.

**Consistency across the three sites, CONFIRMED.** [conventions.md](../findings/conventions.md)'s $g_k$ row, [target.md:700](../findings/target.md) and [results.md:605](../results.md) now all carry $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ on all of $\mathcal W_n$, and both copies of the equality clause read $E_{\lambda_{\min}}\oplus\ker W$. The contradiction the prior Gate 2 flagged is gone.

**Falsifier for the refuted clause:** a $W\in\mathcal W_n$ with $\lVert W\rVert=1$, non-critical, at which $\theta(W)\ne P(W)$. None exists under [conventions.md](../findings/conventions.md)'s definition; one exists under every reading in which $\theta$ names the critical eigenvalue, and that reading has no value off the critical set at all, which is the point.

---

## Summary

| item | verdict |
| --- | --- |
| 1, L162 | **REFUTED AS STATED.** All constants and both values confirmed exactly; $w_0$ is not $G$'s minimiser and not $F$'s from $n=16$; the monotonicity's stated purpose is refuted, the property itself reduced to one owed statement and its consequence proved |
| 2(a), the corner | **CONFIRMED**, every clause, with the equality case unique and provable from the second link alone; two precision defects |
| 2(b), the $\lambda$-weighted identity | **CONFIRMED** and derived cold; the clause naming what criticality is for is **REFUTED** against [conventions.md](../findings/conventions.md) |
