# Review r733, Lemma L162's composed binding constant, and two Gate-2 repairs

**Reviewer r733, Gate 2, 2026-09-07.** Cold brief: [gate2-L162](../agent_logs/review-r733.log) names three items, [L162](../findings/second-order.md)'s composed constant $F(w_0)$, the [L01](../findings/problem.md) repair at the Cauchy–Schwarz edge, and the $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ criticality resolution at [findings/target.md](../findings/target.md).

**Status: in progress.** Verdicts are appended as each item settles.

## Item 1, Lemma L162, **PLAUSIBLE**: every constant and value CONFIRMED, the owed monotonicity **PROVED here**, and one clause of the statement **REFUTED for even $n\ge16$**

### What reproduces cold

Every closed form in the statement was rebuilt from [L156](../findings/second-order.md)'s own hypotheses rather than checked against the printed numeral.

- **$\alpha^*=\frac{n-1}{n-2}$ is right.** [L156](../findings/second-order.md) gives $\alpha^*=\frac D2=\frac{2m-1}{2(m-1)}$ on $W^*=S^m\times S^m$; the balanced product has $n=2m$, which [L156](../findings/second-order.md)'s own line *"Numbers at $n=12$ ($m=6$)"* fixes, and $\frac{2m-1}{2(m-1)}=\frac{n-1}{n-2}$.
- **$C(n)=\frac{2(2n-3)}{n-1}$ is right, and by the route the lemma names.** $C(\alpha,\gamma)=\frac{\alpha(1+\alpha)}{d(d-\gamma)}$ at $\alpha=d=\frac D2$, $\gamma=\frac D4$ collapses to $\frac{4+2D}{D}=2+\frac4D$, and $D=2\alpha^*=\frac{2(n-1)}{n-2}$ gives $2+\frac{2(n-2)}{n-1}=\frac{2(2n-3)}{n-1}$. It agrees with [L156](../findings/second-order.md)'s independently written $C^*=2+\frac{4(m-1)}{2m-1}$, returns $\frac{42}{11}$ at $n=12$, and rises to $4$.
- **The two $J$'s are one $J$, and the brief's suspicion is unfounded.** $J$ is *defined* as $C/\gamma$ in [L156](../findings/second-order.md), so $J\gamma=C$ is an identity, not an assumption, and [L157](../findings/second-order.md)'s $t=\lambda s/(2J\gamma)$ is $\lambda s/(2C)$ at every $(\alpha,\gamma)$. As a cross-check the same substitution returns $J^*=\frac{4(2n-3)(n-2)}{(n-1)^2}=\frac{840}{121}=6.9421$ at $n=12$, which is [L156](../findings/second-order.md)'s printed value.
- **$1-\eta^*=\frac2{\sqrt{4t+1}+1}$ and the collapse to $F$.** $t(1-\eta)^2=\eta$ gives $1-\eta^*=\frac{\sqrt{4t+1}-1}{2t}=\frac2{\sqrt{4t+1}+1}$, so $G=(1-\eta^*)^2s=\frac{4s}{(\sqrt{4\beta s+1}+1)^2}$ with $t=\beta s$. The displayed $F$ is exactly this at $w_0$.
- **The values.** At $n=12$, $\theta_0=\frac{\sqrt{55}}6$, $c_p=\frac{\sqrt{55}}{20}$, $\rho^{\mathrm{eff}}_{12}=\sqrt6-\frac{7\sqrt{55}}{30}$, $w_0=\frac23$, $C=\frac{42}{11}$, $\lvert\kappa_{12}\rvert=\frac{3\sqrt{55}-9\sqrt6}{2}$; carried to 40 digits this gives $F(w_0)=0.3867277$ and the limit $F_\infty=\frac{4s_\infty}{(\sqrt{4\beta_\infty s_\infty+1}+1)^2}=0.9030352$ with $s_\infty=\sqrt{\sqrt6-\frac{\sqrt2}2}$, $\beta_\infty=\frac{\lambda_\infty}8$. **Both printed figures are right.**
- **The range is exactly right, and for a reason the lemma does not give.** $\lambda$ is real iff $\theta_0(n)>\sqrt{3/2}$, i.e. $2(n-1)(n-2)/n^2>3/2$, i.e. $n^2-12n+8>0$, i.e. $n>6+2\sqrt7=11.29$. **$n\ge12$ is not a convention here; it is the smallest integer at which the composed constant exists at all**, and $\lambda\to\infty$ as $n$ falls to that root, which is why $n=12$ is the extreme dimension.

### The owed monotonicity, **proved**, for every real $n\ge12$

Write $q=\sqrt{4\beta s_0+1}$, so that $F=\frac{q-1}{\beta(q+1)}=\frac1\beta\big(1-\frac2{q+1}\big)$.

1. **$F$ is strictly decreasing in $\beta$ at fixed $s_0$**, immediate from $F=\frac{4s_0}{(q+1)^2}$ with $q$ increasing in $\beta$.
2. **$F$ is strictly increasing in $s_0$ at fixed $\beta$**, from $F=\frac1\beta(1-\frac2{q+1})$, increasing in $q$, and $q$ increasing in $s_0$.
3. **$\beta$ strictly decreases.** $\theta_0^2=2(1-\frac3n+\frac2{n^2})$ has derivative $\frac{2(3n-4)}{n^3}>0$, so $\theta_0\uparrow$ and $\lambda=2/\sqrt{9(\theta_0-\sqrt{3/2})}\downarrow$; and $C=4-\frac2{n-1}\uparrow$. Hence $\beta=\lambda/(2C)\downarrow$.
4. **$s_0$ strictly increases.** Substituting $\theta_0=\frac{\sqrt{2(n-1)(n-2)}}n$ collapses $s_0^2$ to a two-term form,
   $$s_0^2=\sqrt6\Big(\frac{n-4}n\Big)^2-\frac{P(n)}{\sqrt2\,n^3}\sqrt{\frac{n-1}{n-2}},\qquad P(n)=(n+16)(n-4)^2-6n^2=n^3+2n^2-112n+256 .$$
   $P>0$ and $v=\sqrt{\frac{n-1}{n-2}}$ decreases for $n\ge12$, so with $u=P/n^3$ we have $(uv)'\le u'v$ and $v\le\sqrt{11/10}$. Since $u'=\frac{-2(n^2-112n+384)}{n^4}$, the required $\frac{8\sqrt6(n-4)}{n^3}>\frac1{\sqrt2}(uv)'$ is implied by
   $$8\sqrt6\,n(n-4)>\sqrt{\tfrac{11}5}\,(112n-n^2-384),$$
   i.e. by $21.0791\,n^2-244.5065\,n+569.564>0$, whose larger root is $8.3705$. **It holds for every $n\ge9$**, and for $n\ge108.5$ the right side is negative and the claim is trivial.

By 1–4, $F(w_0)$ is strictly increasing in $n$ on $[12,\infty)$ as a function of a real variable, so a fortiori at even integers. **The lemma's "screened at twenty-five even dimensions and not proved" is discharged**, and the proof route is the one the lemma guessed at ($\rho^{\mathrm{eff}}_n\uparrow$ against $c_p,\lambda,\beta\downarrow$), with the one step it called *"the four do not obviously compose"* supplied: $c_p$ and $\rho^{\mathrm{eff}}_nw_0^2$ compose because their sum has the closed form above, in which only $P(n)/n^3$ can run the wrong way and it is dominated.

### The clause that is false, **$w_0$ is the minimiser only at $n=12$ and $n=14$**

The statement calls $F(w_0)$ *"the binding value of L158's envelope-free $G$ at its minimiser"* and the Scope repeats *"$w_0$ … is the minimiser there"*, for all even $n\ge12$. **That is false from $n=16$.**

[L158](../findings/second-order.md)'s envelope is $\phi(w)=\min\big(\epsilon\sqrt{1-w^2}+w,\,1\big)$ with $\epsilon=\sqrt{2/(n-2)}$, and the object minimised is $F=G/\phi$. Above $w_0$ the envelope is flat and $F=G$ rises. Below $w_0$,
$$\frac{\mathrm d\log F}{\mathrm dw}=\frac1q\cdot\frac{\rho^{\mathrm{eff}}_nw}{s^2}-\frac{\phi'}{\phi},\qquad \phi'(w_0)=1-\frac{n-4}{2(n-2)}=\frac n{2(n-2)} .$$
So $w_0$ is a local minimum only if $\frac1{q_0}\frac{\rho^{\mathrm{eff}}_nw_0}{s_0^2}<\frac n{2(n-2)}$. The two sides, in exact algebraic numbers carried to 40 digits:

| $n$ | $\frac1{q_0}\frac{\rho w_0}{s_0^2}$ | $\frac n{2(n-2)}$ | kink |
| --- | --- | --- | --- |
| 12 | 0.35947 | 0.60000 | minimum |
| 14 | 0.51080 | 0.58333 | minimum |
| **16** | **0.58486** | **0.57143** | **not a minimum** |
| 20 | 0.65544 | 0.55556 | not a minimum |
| 100 | 0.71373 | 0.51020 | not a minimum |
| $\infty$ | $1/q_\infty=0.70520$ | $0.50000$ | not a minimum |

**At $n=16$ this is a certificate, not a screen**: $\rho^{\mathrm{eff}}_{16}=\sqrt6-\frac{\sqrt{105}}7$, $w_0=\frac34$, $c_p=\frac{3\sqrt{105}}{112}$, $C=\frac{58}{15}$, and the left side exceeds $\frac47$ by $2.35\%$, a gap of order $10^{-2}$ against arithmetic carried to $10^{-40}$. **At $n=\infty$ it is also a proof**: $c_p\to0$, $w_0\to1$, $\rho^{\mathrm{eff}}_n\to\sqrt6-\frac{\sqrt2}2$, so $\frac{\rho w_0}{s_0^2}\to1$ while $q_0\to q_\infty=1.41804$, giving $0.70520>\frac12$. **Only the dimensions between 16 and the asymptotic regime rest on the screened row.**

Consequently $F$ rises through the kink from below for even $n\ge16$, its minimum sits strictly inside $(0,w_0)$, and $F(w_0)$ **overstates** the binding value. Screened deficits: $0.19\%$ at $n=18$, $0.47\%$ at $n=20$, $1.44\%$ at $n=30$, $0.66\%$ at $n=100$. **The error runs the unsafe way**, the chain's radius is proportional to $\min_wF$, so the lemma's number is an over-estimate of a lower bound.

**Repair.** Two words. Restate as *"the value of $G$ at [L158](../findings/second-order.md)'s homogeneity kink $w_0$"*, and confine *"and the minimiser"* to $n\in\{12,14\}$, which is where [L158](../findings/second-order.md) itself confines it, the lemma's Scope reads [L158](../findings/second-order.md)'s *"the sufficient condition is $n$-local and is not claimed beyond $n=12$"* as a gap in the proof of a true statement, where it is in fact the true statement's boundary. **The headline value $0.38673$ at $n=12$ is untouched by this**, $n=12$ being one of the two dimensions where the kink really is the minimiser.

### On "is $F$ the right object at all", it is, and the brief's suspicion resolves in the lemma's favour

[L157](../findings/second-order.md)'s crossing identity is $\eta^*\gamma=\frac{\lambda s}{2J}(1-\eta^*)^2$, and the reach is $r=\eta^*\rho=\eta^*\gamma g_n/\lVert H\rVert_{op}$. Since $\lVert H\rVert_{op}\le\phi(w)$,
$$r\;=\;\frac{\lambda g_n}{2J}\cdot\frac{G(w)}{\phi(w)}\;=\;\frac{\lambda g_n}{2J}\,F(w),$$
with $\lambda$, $J$ and $g_n$ all free of $w$. **So $F$ is exactly the $w$-dependent factor of the reach**, and minimising it over $w$ is the chain's own problem. Three consequences:

- **The Scope's disclaimer is correct and its converse is not.** $F$ is not a radius, but it is not priced for a quantity the chain skips either: the missing factor is $\frac{\lambda g_n}{2J}$, a single number at each $n$.
- **The title's "binding constant" is loose in the direction the record has already been burnt by.** [L158](../findings/second-order.md)'s own box says of the same object *"neither is branch 2, which carries a further $\lambda/(\sqrt2J)$ and $1/n$ and is $0.0206$ at $w_0$"* and *"what was wrong is the label, not the value"*. $F(w_0)=0.38673$ is a factor $18.8$ above the branch-2 value at $n=12$; the title invites the same misreading the record retracted.
- **The $n$-monotonicity of $F$ does not transfer to the chain.** $r\propto\frac{\lambda g_n}{2J}F$, and $\lambda\downarrow$, $g_n=\Theta(n^{-1})$, so the radius falls while $F$ rises. The lemma's box says *"that $n=12$ is the worst case is what lets a bound established there carry to every even $n$ above it"*; **that is true of $F$ and false of the radius**, and the sentence does not say which it means.

### The optimum taken for one objective and reused for another, real, and conservative

$\beta=\lambda/(2C)$ is evaluated at $C=C(\alpha^*,\gamma^*)$, the minimiser of $J$, while [L156](../findings/second-order.md) states in terms *"the quantity the chain wants is the reach $r=\sigma\rho$, and minimising $J$ is not the same problem"* and locates the reach's own $\gamma^\dagger>\gamma^*$. $C$ is strictly increasing in $\gamma$ and $F$ is strictly increasing in $C$, so **$F(w_0)$ evaluated at $\gamma^*$ is not stationary in $\gamma$ and is not a maximum**: as $\gamma\uparrow d$ one has $C\to\infty$, $\beta\to0$ and $F\to s_0=0.83089$ at $n=12$, more than double the printed figure. The direction is safe ($\gamma^*<\gamma^\dagger$ understates both $F$ and $r$) but **$F(w_0)$ is not determined by $n$ alone**, as *"in closed form in $n$"* implies; it is determined by $n$ together with a contour choice made for a different objective, and the lemma never says so.

### Parity, and the one citation slip

Nothing in the composition is parity-dependent beyond the setup itself: $w_0=\frac{n-4}n$, $c_p$, $C$, $\lambda$ and $\rho^{\mathrm{eff}}_n$ are rational or algebraic in $n$ with no parity. **The parity enters once, at the top**: $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is the balanced-product value *at even $n$ only* ([conventions.md](../findings/conventions.md)), and $W^*=S^m\times S^m$ needs $m=n/2\in\mathbb Z$. The stated scope is therefore exactly right.

**Citation slip, cosmetic.** The lemma's first box cites [L149](../findings/second-order.md)'s bullet as *"the margin coefficient … that bullet records $0.74162$ at $n=12$"* and then uses $\rho^{\mathrm{eff}}_{12}=0.71904$. These are two different coefficients: [L149](../findings/second-order.md)'s bullet carries $3\theta_0\frac{m-4}{2(m-1)}=3\theta_0\frac{n-8}{2(n-2)}$, and $\rho^{\mathrm{eff}}_n$ is that **minus** $2(\theta_0-\sqrt{3/2})=\frac29\lvert\kappa_n\rvert$. The lemma prints both outcomes ($0.38673$ and $0.38817$) and picks the smaller, so the choice is sound; the sentence that reaches for the bullet as the authority for the number it does not use is the only thing wrong.

### Verdict and falsifier

**PLAUSIBLE.** Every constant, every identity and both printed values CONFIRMED cold; the owed monotonicity now proved; one clause of the statement REFUTED for even $n\ge16$; two labelling defects.

**What would falsify my refutation:** a single even $n\ge16$ at which $\frac1{q_0}\frac{\rho^{\mathrm{eff}}_nw_0}{s_0^2}<\frac n{2(n-2)}$, or a demonstration that the object minimised over $w$ is $G$ rather than $G/\phi$, in which case $w_0$ would be irrelevant, $G$ being monotone in $w$ and minimised at $w=0$, where [L148](../findings/second-order.md) empties the branch.

**What would falsify my monotonicity proof:** an $n\ge12$ at which $P(n)=n^3+2n^2-112n+256$ is negative, or at which $\sqrt{\frac{n-1}{n-2}}>\sqrt{11/10}$, both checkable in one line.

## Item 2(a), the Cauchy–Schwarz edge repair at [problem.md](../findings/problem.md), **CONFIRMED, every clause**

Standing hypotheses in the block: $S\succeq0$, $\mathop{\mathrm{tr}}S^2=1$, $n=12$ eigenvalues. Both edges rebuilt from those alone.

| clause | check | verdict |
| --- | --- | --- |
| the working edge $\mathop{\mathrm{tr}}S^3\ge1/\sqrt{12}$ | $1=(\mathop{\mathrm{tr}}S^2)^2=\big(\sum\lambda^{1/2}\lambda^{3/2}\big)^2\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$, and $\mathop{\mathrm{tr}}S\le\sqrt n\,(\mathop{\mathrm{tr}}S^2)^{1/2}=\sqrt{12}$ | holds |
| the companion edge $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ | $\big(\sum\lambda\cdot\lambda^2\big)^2\le(\mathop{\mathrm{tr}}S^2)(\mathop{\mathrm{tr}}S^4)=\mathop{\mathrm{tr}}S^4$ | holds |
| $(\tfrac12,\tfrac15)$ **excluded** by the companion edge | $\tfrac14>\tfrac15$ | correct |
| $(\tfrac12,\tfrac15)$ **admitted** by the working edge | $\tfrac12\ge\tfrac1{\sqrt{12}}=0.28868$ | correct |
| the corner sits **on** the working edge with equality | its first coordinate is the floor $1/\sqrt{12}$ by construction | correct |
| the companion edge **admits** the corner | $\tfrac1{12}=0.08333\le\tfrac{709}{4680}=0.15150$ | correct |
| the equality case forces the flat spectrum | see below | correct, and the equality case is unique |
| the flat spectrum gives $\mathop{\mathrm{tr}}S^4=\tfrac1{12}$, against $E(12)$ | $12\lambda^4$ at $\lambda=12^{-1/2}$ is $\tfrac1{12}=\tfrac{390}{4680}<\tfrac{709}{4680}$ | correct |

**The equality case is unique to the flat spectrum, which is the clause the brief asked about.** The floor is reached through two links, $\mathop{\mathrm{tr}}S^3\ge\frac1{\mathop{\mathrm{tr}}S}\ge\frac1{\sqrt{12}}$. If $\mathop{\mathrm{tr}}S^3=\frac1{\sqrt{12}}$ then $\frac1{\mathop{\mathrm{tr}}S}\le\frac1{\sqrt{12}}\le\frac1{\mathop{\mathrm{tr}}S}$, so $\mathop{\mathrm{tr}}S=\sqrt{12}$; and $\mathop{\mathrm{tr}}S=\sqrt n\,(\mathop{\mathrm{tr}}S^2)^{1/2}$ is the equality case of Cauchy–Schwarz against $\mathbf1$, which forces $\lambda_1=\dots=\lambda_{12}$, hence $\lambda_i=12^{-1/2}$ and $\mathop{\mathrm{tr}}S^4=\tfrac1{12}$. **A rank drop cannot substitute**: if $r<12$ eigenvalues are nonzero then $\mathop{\mathrm{tr}}S\le\sqrt r<\sqrt{12}$ and the second link is strict. So no non-flat spectrum reaches the floor, and the corner $(\frac1{\sqrt{12}},\frac{709}{4680})$ is outside the moment body.

**One loose word, not a defect.** The sentence *"a box bounding the two traces separately admits $(\tfrac12,\tfrac15)$"* is true of the naive box $[\tfrac1{\sqrt{12}},1]\times[\tfrac1{12},1]$, whose corners come from $\mathop{\mathrm{tr}}S^3\le(\mathop{\mathrm{tr}}S^2)^{3/2}$ and $\mathop{\mathrm{tr}}S^4\le(\mathop{\mathrm{tr}}S^2)^2$; it is false of a box whose ceiling is $E(12)$, since $\tfrac15>\tfrac{709}{4680}$. The witness's job in that sentence is only to separate the two edges, which it does, so nothing downstream turns on it, but *"a box"* should read *"the naive box"*.

**Verdict: CONFIRMED.** *Falsifier:* a positive semidefinite $S$ with $\mathop{\mathrm{tr}}S^2=1$, a non-constant spectrum, and $\mathop{\mathrm{tr}}S^3=1/\sqrt{12}$, which the argument above shows cannot exist.

## Item 2(b), $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ needs no criticality, **CONFIRMED**, derived cold, with one false clause in the explanation

### The derivation, and where criticality could have entered

Write $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, totally antisymmetric, so $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ is totally symmetric ([conventions.md](../findings/conventions.md)).

1. **(B)**, [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Proposition 1.7 at $L=v_\gamma$: $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$. Its hypothesis is an orthonormal basis diagonalising $R\in\mathrm{Sym}^2(\Lambda^2V)$, **every** $W\in\mathcal W_n$ has one.
2. Expand the square and use $T$'s symmetry to fold the $\lambda_\beta^2$ term onto the $\lambda_\alpha^2$ term:
   $$\sum_\gamma\lambda_\gamma g_\gamma=2\underbrace{\sum_{\gamma\alpha\beta}\lambda_\gamma\lambda_\alpha^2T_{\gamma\alpha\beta}}_{\Sigma_1}-2\underbrace{\sum_{\gamma\alpha\beta}\lambda_\gamma\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}}_{Y}.$$
3. **(A′)**, the Weitzenböck identity $\sum_\gamma\lambda_\gamma\mathrm{ad}(v_\gamma)^2=2W$, [Petersen–Wink notes](../references/petersen-wink-2019-bochner-technique/notes.md), consuming first Bianchi **and** Ricci-flatness, i.e. exactly $W\in\mathcal W_n$. Summing $\beta$ out of $\Sigma_1$ gives $\sum_\beta c_{\gamma\alpha\beta}^2=\lVert[v_\gamma,v_\alpha]\rVert^2=-\langle\mathrm{ad}(v_\gamma)^2v_\alpha,v_\alpha\rangle$, so
   $$\Sigma_1=-\sum_\alpha\lambda_\alpha^2\big\langle\big(\textstyle\sum_\gamma\lambda_\gamma\mathrm{ad}(v_\gamma)^2\big)v_\alpha,v_\alpha\big\rangle=-2\sum_\alpha\lambda_\alpha^3=-2\mathop{\mathrm{tr}}W^3 .$$
4. **The cubic identity** is Hamilton's $\#$ in a Lie-algebra basis, $(W^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}c_{\gamma\alpha\beta}^2\lambda_\alpha\lambda_\beta$, so $Y=2\langle W,W^\#\rangle$.

Together, $\sum_\gamma\lambda_\gamma g_\gamma=-4\mathop{\mathrm{tr}}W^3-4\langle W,W^\#\rangle=-4\langle W,W^2+W^\#\rangle=-4P(W)$. **Criticality enters at no step.** *The same three ingredients give the first identity too, with the Killing row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=-B(v_\alpha,v_\alpha)=2(n-2)$ ([L153](../findings/bounds.md)) in place of step 4: $\sum_\gamma g_\gamma=4(n-2)\lVert W\rVert^2-2\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\lVert[v_\alpha,v_\beta]\rVert^2$, and (A′) turns the second sum into $-2\lVert W\rVert^2$, giving $4(n-1)\lVert W\rVert^2$.* **So the block's "the first identity additionally consumes [L153](../findings/bounds.md)" is exactly right, and the second genuinely does not need it.**

### A non-critical witness, in closed form

Both identities are polynomial in $W$, $\sum_\gamma\lambda_\gamma g_\gamma=\mathop{\mathrm{tr}}(\hat\Phi W)$ for the quadratic form $\Phi(v)=\lVert[\mathrm{ad}(v),W]\rVert^2$, so it does not depend on which orthonormal eigenbasis is chosen even at repeated eigenvalues. To close the question by exhibition rather than by derivation, take $n=4$ and a self-dual $W=W^+\oplus0$ with $W^+=\mathop{\mathrm{diag}}(a,b,c)$, $a+b+c=0$, in the basis $L_i$ of $\Lambda^+$. There $[L_1,L_2]=-\sqrt2L_3$ and cyclically, so $T=2$ on the six permutations of $(1,2,3)$ and on those of $(4,5,6)$, and zero elsewhere; the Killing check $\sum_{\beta\gamma}T_{1\beta\gamma}=4=2(n-2)$ holds.

- $g_1=4(b-c)^2$, $g_2=4(a-c)^2$, $g_3=4(a-b)^2$, $g_4=g_5=g_6=0$.
- $\sum_\gamma g_\gamma=4\sum(a-b)^2=12\lVert W\rVert^2=4(n-1)\lVert W\rVert^2$ **✓**.
- $\sum_\gamma\lambda_\gamma g_\gamma=4\big[a(b-c)^2+b(c-a)^2+c(a-b)^2\big]=4(-3abc-6abc)=-36abc$.
- $(W^\#)_{11}=\tfrac12(T_{123}bc+T_{132}cb)=2bc$, so $\langle W,W^\#\rangle=6abc$ and $P(W)=3abc+6abc=9abc$, giving $-4P(W)=-36abc$ **✓**.

**The $\#$ normalisation is anchored independently, not fitted.** At $(a,b,c)=\mu(2,-1,-1)$ with $\lVert W\rVert=1$, i.e. $\mu=1/\sqrt6$, this is padded $W_{\mathbb{CP}^2}$, and $P=9abc=18\mu^3=3/\sqrt6=\sqrt{3/2}$, **the record's own $\theta^*=\sqrt{3/2}$** ([conventions.md](../findings/conventions.md)). The same $W$ has $Q(W)=3\mu W$, so it *is* critical; but $(a,b,c)=\mu(3,-1,-2)$ has $Q(W)^+=\mu^2(13,-11,-2)$, which is not a multiple of $\mu(3,-1,-2)$, so **it is not critical, and both identities hold there verbatim.** That is the falsifier the brief asked for, and it comes out on the repair's side.

### The clause that is false

> *"What criticality was ever for is writing $\theta$ in place of $P(W)$, which needs $Q(W)=\theta W$ and unit norm."*

**$\theta$ is defined as $P(W)/\lVert W\rVert^3$ at every $W$** ([conventions.md](../findings/conventions.md)), so substituting $\theta$ for $P(W)$ needs $\lVert W\rVert=1$ and nothing else. What $Q(W)=\theta W$ buys is that the *same number* is $Q$'s eigenvalue, a different statement, and one the identity never uses.

**The block contradicts itself two paragraphs apart on this.** Its own preceding sentence says the withdrawn forms *"hold at $\lVert W\rVert=1$ alone"*, which is the correct account; the box then re-attaches criticality to the very substitution that sentence had freed. **The repair removed criticality from the identity and left it standing on the identity's corollary**, and the sentence that does it is precisely the one a reader consults to decide whether they need a critical point.

**Repair, one clause:** *"What criticality is for is reading $\theta$ as $Q$'s eigenvalue; writing $\theta$ for $P(W)$ needs unit norm alone."*

### Cross-copy consistency

[results.md](../results.md) carries L41 twice, at the summary line and in the full statement, and both now say *"on all of $\mathcal W_n$"*, both attach the bound to $\lVert W\rVert=1$, and both give the equality class as $E_{\lambda_{\min}}\oplus\ker W$. **The three copies agree**, and they agree with [conventions.md](../findings/conventions.md)'s table, which is what the previous Gate 2 found them contradicting. The one asymmetry left is cosmetic: [results.md](../results.md) writes *"critical or not"* after the first identity and not after the second.

**Verdict: CONFIRMED**, with one clause of the explanation refuted. *Falsifier:* a $W\in\mathcal W_n$ at which $\sum_\gamma\lambda_\gamma g_\gamma\ne-4P(W)$, impossible, since steps 1–4 use only membership in $\mathcal W_n$; or a definition of $\theta$ on the record that is not $P(W)/\lVert W\rVert^3$, which would rescue the clause I refute.

## Summary of the three items

| item | verdict | what moves |
| --- | --- | --- |
| **1, [L162](../findings/second-order.md)** | **PLAUSIBLE** | every constant and both values CONFIRMED cold; **monotonicity in $n$ now proved**, discharging the lemma's own open item; **"at its minimiser" REFUTED for even $n\ge16$**, $F(w_0)$ overstating the true minimum by up to $1.4\%$ in the unsafe direction; the title's *"binding constant"* repeats a label [L158](../findings/second-order.md) retracted; $F$ is not determined by $n$ alone, $\gamma^*$ being an optimum of $J$ and not of $F$ |
| **2(a), [problem.md](../findings/problem.md)** | **CONFIRMED** | every clause holds and the equality case is unique to the flat spectrum; *"a box"* should read *"the naive box"* |
| **2(b), [target.md](../findings/target.md), [results.md](../results.md)** | **CONFIRMED** | the identity derived cold from (A′), (B) and Hamilton's $\#$, with a non-critical $n=4$ witness; **one clause of the explanation is false**, writing $\theta$ for $P(W)$ needs unit norm, not criticality, as the block's own previous sentence says |

**This reviewer did not confirm everything.** One clause of item 1 and one clause of item 2(b) are refuted, and item 1's owed monotonicity is supplied.
