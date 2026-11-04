# Verifier v153, Lemma L35's chain $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$, its dual weight L42, and the two cases the statement covers that the argument does not reach

I read [BRIEF_L35.md](BRIEF_L35.md) cold, worked from [conventions.md](../findings/conventions.md)'s definitions, and re-derived every hand-checkable step of the chain from the definitions rather than from the block's own account of it. **No numerical work was done. Every value below is exact**, the surds are surds, the two decimal figures I quote ($1.017217$, $1.067666$) are quoted from the record and are not checked here, and the four points where I compare two exact expressions are arithmetic on numbers I wrote down for that comparison and are labelled as screens. Log: [agent_logs/verify-L35-v153.log](../agent_logs/verify-L35-v153.log).

## Claims attacked

| # | claim | verdict | reason |
|---|---|---|---|
| 1 | the eigenframe identity $\theta=\sum\lambda^3+3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$, coefficient $3$, at $\lVert W\rVert=1$ | **CONFIRMED** | rederived from $\langle W,W^\#\rangle=\tfrac12\sum_{\text{ordered}}T\lambda\lambda\lambda$; $6/2=3$; a third route disjoint from the block's two |
| 2 | $\theta\le\mathrm{LP}\le G$, each relaxation in the enlarging direction | **CONFIRMED** | the true $T$ is feasible for LP; dropping equality marginals enlarges; both arrows point the claimed way |
| 3 | $G$ decouples **exactly**, $G=\sum_P\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ | **CONFIRMED** | $(+++)$/$(+--)$ consume disjoint pair caps, $(++-)$ zeroed by sign, $(---)$ empty; $bc=(s^2+u-1)/2$ rederived |
| 4 | L42, $3M(\lambda_P)\le h(s^2-u)$, and its sharpness | **CONFIRMED** | dual correctly transposed, product weight feasible iff $c\ge H/3$, $t=2/(k-2)$ attains it at $k\ge3$ |
| 5 | $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$ | **CONFIRMED** | harmonic $\le$ max, and harmonic-of-two $\le$ quadratic-of-two under $\lambda_2^2+\lambda_3^2\le d$ |
| 6 | $R(A,s,u)$ strictly increasing in $s$ and $u$, so both sit at $s^2=2-2u$, forcing $b=c$ | **CONFIRMED AS ALGEBRA** | $\partial_uR\ge\tfrac32s+2A>0$ and $\partial_sR=2s\min(A,K_0\sqrt d)+6sA+3bc>0$ both reproduce, **but $R$ is displayed nowhere in [findings/](../findings/)** |
| 7 | the reduction to $g(A)+\psi(t)$ and the endpoint constants | **CONFIRMED** | every constant exact: $g(A_0)=\tfrac{\sqrt6}2$, $g'(A_0)=0$, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$, $\alpha(A_0-\varepsilon)=3\sqrt3\varepsilon$, $\beta(A_0)=-\tfrac34\sqrt6$, $t^*=\sqrt2\varepsilon$, $\psi^*=\tfrac32\sqrt6\varepsilon^2$ |
| 8 | the band $(0,\tfrac13]$ closes at $\le\tfrac89$, peaking at $A=\tfrac13$ | **CONFIRMED at the peak, exactly** | $g(\tfrac13)=\tfrac13$ and $\alpha T=\tfrac59$ sum to exactly $\tfrac89$; $\beta(\tfrac13)=0$ from $A^2=\tfrac19$ |
| 9 | **"the cases of one and two positive eigenvalues close in closed form"** | **HYPOTHESIS-DEBT** | $k=1$ closes (L29's $f(t)$, rederived exactly); **$k=2$ has no argument on file** and L29's own block says so and names L35 as unable to discharge it |
| 10 | **"at most two negative"**, the one-negative case | **HYPOTHESIS-DEBT** | the block says it is "owed a line"; the line is still owed |
| 11 | the two statement forms differ over $\lVert W\rVert=1$ | **CONFIRMED AS ALGEBRA, one edge open** | $\theta$ is scale-invariant so the forms agree at $W\ne0$; at $W=0$ (all $m\le3$) [results.md](../results.md)'s form asserts a bound on $0/0$ |
| 12 | "$G$… $\sum\lambda^3$" is the same $\sum\lambda^3$ as the identity display's | **REFUTED AS STATED** | in $G$ it runs over the **positives only**; the natural reading gives $1.088662$ at $(2,-1,-1)/\sqrt6$ instead of $\sqrt{3/2}$ |
| 13 | the $(0.7,A_0]$ band carries margin $\tfrac34\sqrt6$ | **REFUTED AS STATED** | the block's own withdrawal three sections later retires that certificate; the summary paragraph still presents it |
| 14 | $\ker W\ne0$ reaches the argument | **CONFIRMED harmless** | kernel indices contribute $0$ to the objective and dropping their cap load is a relaxation; the equality case *is* a padded object |
| 15 | $(\tfrac13,0.7096]$ by $200$-bit interval arithmetic | **OUTSIDE THIS LOOP'S FOOTING** | neither confirmed nor refuted here; the record already says it is not hand-checkable |

**One line the round can act on:** every hand-checkable step of L35 reproduces exactly, including all seven endpoint surds and the $8/9$, but the statement's $k=2$ case rests on a two-parameter maximisation that L29's own block records as owed and as undischargeable by L35, so L35 is not proved as stated, and the debt is circular rather than merely missing.

## 0. Conventions, fixed once

From [conventions.md](../findings/conventions.md), quoted:

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> $A$, $d$, $G$, $A_0$ | in the two-negative relaxation: $A=\lambda_1$, $d=u-\lambda_1^2$, $G$ the pair-capped fractional triangle packing that the chain's bound **is**, and $A_0$ the interior maximiser of $g$. **None was defined in [findings/](.)** … **$d$ collides with the negative-eigenvalue count in [bounds-relaxations.md](bounds-relaxations.md)**, under which reading [L35](stratum-two-negative.md)'s bound would read $h\le3/2$ and be vacuous

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.

> **Sums over pairs are over ORDERED pairs** unless the line says otherwise.

> The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is **[Lemma L31](stratum-two-negative.md)**, proved with its equality case characterised. The row marginal is **[Lemma L153](bounds.md)**, in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ … **The marginal has two readings and consumers use both**: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered pairs, $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=n-2$ over unordered

> A skew matrix's norm … $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$.

> $\Theta_n$ | the diagonal maximum; equals $\theta_0(n)$ at even $n$ … $\theta_0(n)^2=2(n-1)(n-2)/n^2$

The last of these fixes $\Theta_4=\sqrt3/2$, which section 8 uses.

Local to the two-negative stratum, and used below with the block's own meanings: $\lambda_P$ the positive part of the spectrum, $s=\sum_P\lambda$, $u=\sum_P\lambda^2$, $-b$ and $-c$ the two negative eigenvalues ($b,c>0$), $k=\lvert\lambda_P\rvert$, $K_0=3/(2\sqrt2)$, $N=\binom m2$.

## 1. The hypothesis inventory

**A pass with no inventory is not a pass**, so this is the whole of it: every hypothesis the two statement forms carry, every hypothesis of every imported theorem, and whether the written proof uses it.

### 1a. Hypotheses the statement carries

| hypothesis | in [results.md](../results.md) | in the proof block | used by the proof? |
|---|---|---|---|
| $W\in\mathrm{Weyl}_m$ | yes | yes | **only through trace-freeness.** The block says so itself and is right, see §2 |
| $\lVert W\rVert=1$ | **absent** | **present** | **used**, three times: the identity display, $b^2+c^2=1-u$, and $s^2\le2-2u$ |
| at most two negative eigenvalues | yes | yes | used, and only the *exactly two* case is argued (§6) |
| any number of positive ones | yes | yes | **the $k=2$ case is not reached** (§5) |
| any $m$ | yes | yes | used only to say the bound is $m$-free, which $G$ delivers (§4) |
| $W\ne0$ | **absent from both** | implied by unit norm | needed for $\theta$ to be defined (§7) |

**A hypothesis stated and never used:** the row marginal $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=m-2$. The block is explicit and correct about this (***"So this lemma states the row marginal and then discards it"***) and I confirm the discard is total: $G$'s definition names nonnegativity, total symmetry and the pair caps and nothing else, so the bound survives [L153](../findings/bounds.md) being false. **No finding.** The reading is also right: unordered $m-2$ against L153's ordered $2(m-2)$, matching [conventions.md](../findings/conventions.md)'s own conversion line.

**A step using a hypothesis never stated:** the $(+--)$ transport step needs $\lambda_1$ to be the **largest** positive eigenvalue, which is an ordering convention the block never fixes. It is harmless, the step is $\max_\alpha\lambda_\alpha$ and the block's later use of $A=\lambda_1$ in $d=u-\lambda_1^2$ and $h\le\lambda_1$ requires the same ordering, but it is nowhere written down. **Minor finding**, recorded here and not pursued.

### 1b. Hypotheses of the imported theorems, each checked against the object it is applied to

| import | its hypotheses | the object it is applied to | verdict |
|---|---|---|---|
| **[L31](../findings/stratum-two-negative.md)**, pair cap $\le2$ | $X,Y\in\mathfrak{so}(n)$ **orthonormal** | $v_\alpha,v_\beta$, eigenvectors of $W$ on $\Lambda^2$ | **holds.** Distinct eigenvalues give orthogonality, a degenerate eigenspace admits an orthonormal choice, and the norm is the record's half-trace one, which is exactly the normalisation L31's own proof consumes as $\sum_is_i^2=1$ |
| **[L153](../findings/bounds.md)**, row marginal | any $v\in\mathfrak{so}(n)$, any $n\ge2$ | every $v_\alpha$, kernel indices included | **holds**, and is then dropped |
| **[L42](../findings/stratum-two-negative.md)**, dual weight | **at least three positive entries**; all entries $>0$ | $\lambda_P$ | **holds at $k\ge3$ and fails at $k\le2$**, where no triple exists and $h$ has no value. L42's own block states this. It is the hinge of §5 |
| **LP weak duality** | a feasible dual point | $z_{\alpha\beta}=\tfrac h3\lambda_\alpha\lambda_\beta$ | **holds**; feasibility rederived in §3 |
| **the envelope theorem** | the inner maximiser selected and the max attained | $\psi^*(A)=\max_{[0,T]}\psi(\cdot,A)$ | **holds on $(0,A_0)$**: $\gamma<0$ and $\alpha>0$ make the roots' product $\alpha/(3\gamma)<0$, so $\psi'$ has exactly one positive root; the $C^1$ check at the branch switch is correct (§9) |
| **Cauchy–Schwarz**, twice | none | $s^2\ge u$ on the positives, $(b+c)^2\le2(b^2+c^2)$ on the negatives | **holds.** The block's correction *(i)* that this is Cauchy–Schwarz and not the curvature identity is right |
| **convexity of $y\mapsto y^{3/2}$** | $y\ge0$ | $(X-2t^2)^{3/2}\ge X^{3/2}-3t^2\sqrt X$ at $X=2-2A^2$ | **holds**, and $X-2t^2=2-2u\ge0$ since $u\le\tfrac23$ |

None of the imports is a unital-algebra-shaped trap: L31 and L153 are statements about $\mathfrak{so}(n)$ under the record's own normalisation, and I checked that normalisation against [conventions.md](../findings/conventions.md) rather than assuming it.

## 2. The chain identity, and what it really needs

$P(W)=\langle W,W^2+W^\#\rangle=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$. In the eigenbasis, $\langle W,W^\#\rangle=\sum_\alpha\lambda_\alpha W^\#_{\alpha\alpha}=\tfrac12\sum_{\alpha,\gamma,\delta}\lambda_\alpha c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta$, the sum over **ordered** triples. $T=c^2$ is totally symmetric and vanishes on repeated indices, so the ordered sum is $3!=6$ times the unordered one, and

$$\langle W,W^\#\rangle=\tfrac12\cdot6\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma.$$

**The coefficient $3$ is confirmed by a third route**, disjoint from the block's two. The derivation used the ad-invariance of the inner product (for total antisymmetry of $c$) and nothing else, so the block's claim that the identity needs no first Bianchi identity is right, and its claim that the result therefore holds for any trace-free symmetric operator on $\Lambda^2$ with the stated sign pattern is right too, with the qualification that **trace-freeness is genuinely used**, at $b+c=s$, so "no Weyl hypothesis" means "no Bianchi", not "no hypothesis".

$\theta=P(W)$ requires $\lVert W\rVert=1$. The block flags this correction and is correct to.

## 3. L42, the dual weight, CONFIRMED in all four parts

**The transpose.** Each $t_{\alpha\beta\gamma}$ appears in exactly three pair constraints with coefficient $1$; each constraint has right-hand side $2$. So the dual is $\min2\sum_{\alpha<\beta}z_{\alpha\beta}$ subject to $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$, $z\ge0$, as written.

**Feasibility.** With $z_{\alpha\beta}=c\lambda_\alpha\lambda_\beta$ and every $\lambda>0$, dividing the triple constraint by $\lambda_\alpha\lambda_\beta\lambda_\gamma$ gives $c(\lambda_\alpha^{-1}+\lambda_\beta^{-1}+\lambda_\gamma^{-1})\ge1$, i.e. $c\ge H/3$. $H$ is increasing in each argument, so the binding triple is the three largest and $c=h/3$ is feasible.

**Weak duality.** $M\le2\cdot\tfrac h3\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta=2\cdot\tfrac h3\cdot\tfrac{s^2-u}2=\tfrac h3(s^2-u)$, so $3M\le h(s^2-u)$.

**Sharpness.** At $k$ equal positives, $t_{\alpha\beta\gamma}=2/(k-2)$ has pair marginal $(k-2)\cdot\tfrac2{k-2}=2$ and total $\binom k3\tfrac2{k-2}=\tfrac{k(k-1)}3$, so $3M\ge k(k-1)\lambda^3=h(s^2-u)$. Equality, and the constant cannot be improved. Valid from $k=3$, where it degenerates correctly to $t=2$ on the single triple.

The block's own two corrections to the superseded chain, that $\mu\ge2/(3\sum\lambda^{-1})$ rather than $\mu\ge2/\sum\lambda^{-1}$, and that the gloss "at least the harmonic mean" is $\tfrac92$ times the true threshold, are both right, and neither touches the boxed inequality. **No finding.**

## 4. $\theta\le\mathrm{LP}\le G$, and $G$'s decoupling

$\theta\le\mathrm{LP}$: the actual $T$ is nonnegative, totally symmetric, has row marginals exactly $m-2$ and pair caps $\le2$, so it is feasible for LP and $\theta\le\mathrm{LP}$. $\mathrm{LP}\le G$: the marginals are equalities, so dropping them enlarges the feasible set. Both arrows point the claimed way.

**The decoupling is an identity, as claimed.** With positives $\lambda_P$ and negatives $-b,-c$: $(---)$ is empty; $(++-)$ carries objective coefficient $\lambda_\alpha\lambda_\beta(-b)<0$ against $t\ge0$ and consumes caps, so it is zero at every optimum; $(+++)$ consumes only $(++)$ pair caps; $(+--)$ consumes the single $(--)$ cap and two $(+-)$ caps. **The two live blocks share no constraint**, so the LP splits exactly. The $(+--)$ block puts its whole mass $2$ on the largest positive, worth $2bc\lambda_1$, feasible because each $(+-)$ cap then carries load $2\le2$.

Hence $G=\sum_P\lambda^3-b^3-c^3+3\,\mathrm{FTP}(\lambda_P)+6bc\lambda_1$, and $b^3+c^3=s^3-3bcs$ turns it into the block's display. $bc=(s^2+u-1)/2$ follows from $b+c=s$ and $b^2+c^2=1-u$ by $2bc=(b+c)^2-(b^2+c^2)$.

**$G$ is free of $m$**, since the objective is supported on the nonzero spectrum and restricting the caps' $\gamma$-range to the support is itself a relaxation.

### 4a. Discrepancy, $\sum\lambda^3$ carries two ranges inside one lemma

1. **Located.** The identity display reads "$\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$", the sum over the whole spectrum. Eleven lines later, "$G=\sum\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$", where the same symbol must mean $\sum_P\lambda^3$, over the positives only.
2. **Exhibited.** Read with the display's range, $G$ acquires the term $-s^3+3bcs$ twice. At $(2,-1,-1)/\sqrt6$, where $s=2/\sqrt6$ and $bc=1/6$, that term is $-\tfrac{8}{6\sqrt6}+3\cdot\tfrac16\cdot\tfrac2{\sqrt6}=-\tfrac4{3\sqrt6}+\tfrac1{\sqrt6}=-\tfrac1{3\sqrt6}$. So the mis-read $G$ is $\sqrt{3/2}-\tfrac1{3\sqrt6}$, a screen puts that at $1.088662$ against the true $1.224745$, and the equality point stops being an equality point.
3. **Argued the opposite.** The charitable reading is available and is the author's: [r63](../reviews/REVIEW_r63.md)'s L1 writes the same identity as `G = Σ_Pλ³ − b³ − c³ + 6Abc + 3M(λ_P)`, unambiguously. So this is a **notation defect and not a mathematical error**, but it is one that silently costs a reader the lemma's own anchor point, and the block's whole rhetorical weight rests on that anchor reproducing $\sqrt{3/2}$.

## 5. The $k=2$ case, the debt, and it is circular

**This is the finding.** The block's proof ends: *"The cases of one and two positive eigenvalues close in closed form."* It gives neither, and L42 (the closing lemma), is undefined at $k\le2$ by its own hypothesis.

1. **Located.** $k=1$ is genuinely closed: L29's chain gives $\theta\le\lambda_1^3-a^3-b^3+6\lambda_1ab$, and with $\lambda_1=a+b$, $t=b/a$, $a^{-2}=2(t^2+t+1)$ this collapses to $f(t)=9\sqrt2\,t(t+1)/(4(t^2+t+1)^{3/2})$ with $f(1)=\sqrt{3/2}$, **I rederived $f$ exactly**, including the $9a^3t(1+t)$ intermediate, and it is right. **$k=2$ is not.** Its only statement on the record is the development paragraph at [stratum-two-negative.md](../findings/stratum-two-negative.md) line 37: *"maximising the resulting bound over the whole two-parameter family returns $\sqrt{3/2}$ again"*, a maximisation, asserted, with no derivation beside it.
2. **Exhibited.** The record says so itself, at L29's canonical block: *"It reaches $k=2$ as well … **though the two-parameter maximisation that carries the $k=2$ claim appears on no site, here or elsewhere, and is owed; [Lemma L35] cannot discharge it, its own proof consuming this lemma at $k\le2$.**"* So L35 routes $k=2$ to L29, and L29 routes it back while naming L35 as unable to take it. **The two sites close a loop with nothing in it.** [INDEX-results.md](../findings/INDEX-results.md) row 29 records "The scope is $k\le2$, not $k=1$" as Gate-2 confirmed, which is the claim, not the proof.
3. **Argued the opposite.** The most charitable reading is that "closes in closed form" refers not to a separate argument but to the same relaxation $R$ read at $k\le2$, where $M=0$. That reading is available and may well be sound, but **it is not what the block says**, and it is not what L29's block says either; both send the reader to a maximisation that does not exist. Under the loop's rule I do not write the missing step.

**What would have to be proved, exactly.** Either

- **(a)** $\max\{\lambda_1^3+\lambda_2^3-b^3-c^3+6\lambda_1bc\}=\sqrt{3/2}$ subject to $\lambda_1\ge\lambda_2>0$, $b,c>0$, $\lambda_1+\lambda_2=b+c$ and $\lambda_1^2+\lambda_2^2+b^2+c^2=1$, the two-parameter maximisation L29 owes; or
- **(b)** that $R(A,s,u)\ge G(\lambda)$ continues to hold at $k\le2$, which would let the $k\ge3$ argument absorb both cases and retire (a) entirely.

I record without pursuing it that (a) is a boundary maximum, the value $\sqrt{3/2}$ sits at the degenerate corner $\lambda_2\to0$, not at an interior stationary point, which is why it is not the one line the phrase "closes in closed form" implies.

## 6. Exactly one negative eigenvalue, still owed

The statement says *at most* two. The block says: *"The argument below is written for exactly two negative eigenvalues; the one-negative case is the $c\to0$ boundary and is owed a line."* [INDEX-results.md](../findings/INDEX-results.md) row 35 records the same. **The line is still owed**, and this verifier does not write it.

What the line must establish, named so the next round does not have to find it: that the parametrisation survives $c=0$, $bc=(s^2+u-1)/2$ reads $0=0$ there, and the point sits strictly inside $s^2\le2-2u$ rather than on the boundary the argument pushes to, so the $b=c$ forcing cannot be invoked at it, and that $G$ does not jump as the index leaves the support. Neither is written anywhere.

## 7. The two forms of the statement

[results.md](../results.md) omits $\lVert W\rVert=1$; the proof block carries it.

**They agree wherever $\theta$ is defined.** $P$ is a cubic form and $\lVert\cdot\rVert^3$ is homogeneous of the same degree, so $\theta=P(W)/\lVert W\rVert^3$ is invariant under $W\mapsto tW$, $t>0$. The unit-norm hypothesis is therefore a *normalisation for the proof*, not a restriction on the statement, and [results.md](../results.md)'s form is the stronger and correct one for $W\ne0$.

**The one place they part is $W=0$.** The block's parenthetical (*"zero negative eigenvalues is impossible by trace-freeness"*), is false at $W=0$, where trace-freeness says nothing. Under [results.md](../results.md)'s form, $W=0$ satisfies "at most two negative eigenvalues" and the conclusion asserts a bound on $0/0$. This bites at every $m\le3$, where $\dim\mathcal W_m=m(m-3)(m+1)(m+2)/12=0$ makes $W=0$ the only member. The repair is a hypothesis, $W\ne0$ or $\lVert W\rVert=1$, and the choice between them is a matter of taste. **Reported at low severity**; it changes no value.

## 8. $\ker W\ne0$, and the structured families

**$\ker W\ne0$ (the record's recurring obstruction), does not reach this lemma, and I checked rather than assumed it.** A padded object is not an exception here but the *typical* case: at every $m\ge5$ the equality point $(2,-1,-1)/\sqrt6$ has $\binom m2-3$ zero eigenvalues. Two places the kernel could have bitten, both clean:

- **the objective**: any triple containing a kernel index contributes $0$, so restricting $\mathrm{FTP}$ to the support changes nothing;
- **the caps**: restricting each pair cap's $\gamma$-range to the support drops nonnegative load, which is a relaxation in the enlarging direction.

So $G$ is a function of the nonzero spectrum alone, which is exactly what makes it $m$-free. **No finding.** This is a marked contrast with [W4](../findings/INDEX-traps.md), where the gradedness screen goes vacuous at $\ker W\ne0$; here the kernel is inert rather than fatal.

**One object from each structured family the record names, in closed form:**

| family | at most two negative eigenvalues? | verdict |
|---|---|---|
| **coordinate-diagonal** $W$, any $m$ | **only if supported on a $4$-plane** | Let $S\in\mathcal D_m$ carry the $\Lambda^2$ spectrum as its entries, hollow with $S\mathbf1=0$. Let $\mathcal N$ be the indices meeting a negative entry, $\lvert\mathcal N\rvert\le4$. For $a\notin\mathcal N$, row $a$ is nonnegative and sums to $0$, so it vanishes; hence $S$ lives on $\mathcal N$. $\mathcal D_3=0$, so the support is exactly $4$ and $\theta\le\Theta_4=\sqrt3/2<\sqrt{3/2}$. **No falsifier here, at any $m$.** |
| **balanced sphere product** $S^{m}\times S^{m}$, $n=2m$ | **no**, $m^2$ of them | The metric is Einstein with $R_{abab}=1$ within a block and $0$ across, so $W_{abab}=\tfrac{m}{2m-1}>0$ on the $m(m-1)$ same-block pairs and $-\tfrac{m-1}{2m-1}<0$ on the $m^2$ mixed ones. At $n=12$: $30$ positive, $36$ negative. Outside the hypothesis, which is what lets $\theta_0(12)=\sqrt{220}/12>\sqrt{3/2}$ coexist with L35. |
| **$\mathbb{CP}^2$, padded** | **yes, exactly two** | $\theta=\sqrt{3/2}$ exactly. The equality case, not a falsifier, and the whole reason the constant is predicted rather than fitted. |
| **subalgebra-Casimir and torus points** | **not tested in closed form** | I could construct no member with $\le2$ negative eigenvalues without a search, which this loop does not run. Recorded as untested rather than cleared. |

## 9. The edges of the stated ranges

- **$A=\tfrac13$.** $\beta=\tfrac34\sqrt{2-2A^2}-3A=0\iff2-2A^2=16A^2\iff A^2=\tfrac19$, as claimed. And the band's value there is **exactly $\tfrac89$**: $g(\tfrac13)=\tfrac1{27}-\tfrac{16}{27}+\tfrac{24}{27}=\tfrac13$ (using $(8/9)^{3/2}/\sqrt2=16/27$), and $\alpha T=K_0(2-3A^2)\cdot\tfrac{2\sqrt2}3A=\tfrac3{2\sqrt2}\cdot\tfrac53\cdot\tfrac{2\sqrt2}9=\tfrac59$, so $g+\alpha T+\beta T^2=\tfrac13+\tfrac59+0=\tfrac89$. The recorded margin $\sqrt{3/2}-\tfrac89=+0.3359$ matches the block's $+0.336$. **Confirmed at the peak.** That $\tfrac13$ *is* the peak of the band is asserted rather than argued; I did not check it and say so.
- **$A_0=\sqrt{2/3}$.** $g(A_0)=\tfrac53A_0-\tfrac1{3\sqrt6}=\tfrac{5\sqrt6}9-\tfrac{\sqrt6}{18}=\tfrac{\sqrt6}2$. $g'(A)=3-6A^2+\tfrac32A\sqrt{2-2A^2}$ gives $g'(A_0)=-1+1=0$. $g''(A_0)=-12A_0+\tfrac32(A_0-2A_0)=-\tfrac{27}2A_0=-\tfrac{9\sqrt6}2$, so $-\tfrac12g''(A_0)=\tfrac94\sqrt6$. **All three exact, all three reproduce.**
- **$\alpha,\beta,t^*,\psi^*$ at $A_0-\varepsilon$.** $2-3A^2=6A_0\varepsilon+O(\varepsilon^2)$ gives $\alpha=K_0\cdot6A_0\varepsilon=3\sqrt3\varepsilon$; $\beta(A_0)=\tfrac34A_0-3A_0=-\tfrac94A_0=-\tfrac34\sqrt6$; $t^*=\alpha/(2\lvert\beta\rvert)=\sqrt2\varepsilon$, inside the cap $T=\tfrac{2\sqrt2}3A$; $\psi^*=\alpha^2/(4\lvert\beta\rvert)=\tfrac{27\varepsilon^2}{3\sqrt6}=\tfrac32\sqrt6\varepsilon^2$. **All exact.** Dropping $\gamma t^3\le0$ to get $\psi^*\le\alpha^2/(4\lvert\beta\rvert)$ is in the safe direction since $\gamma=1-3K_0<0$.
- **$A=0.4463$, the branch switch.** The $C^1$ argument is right: at $t_c=T$ the capped branch's extra term is $\psi_t(A,T)T'$ and $\psi_t(A_{\rm sw},T)=0$ by the definition of $t_c$, so the one-sided derivatives agree. The uniqueness of $t_c$ is also right, $\gamma<0$ and $\alpha>0$ make the roots' product $\alpha/(3\gamma)<0$, and the stated root $t_c=(-\beta-\sqrt{\beta^2-3\gamma\alpha})/(3\gamma)$ is the positive one. **No finding.** The value $0.4463$ itself is numerical and not checked.
- **$A=0.7$ and $A=0.7096$, and the whole of $(\tfrac13,A_0]$.** Closed by $200$-bit interval arithmetic and bisection. **Outside this loop's footing**, I neither confirm nor refute, and the record already labels it "not hand-checkable". §10 records one bookkeeping inconsistency in how the bands are described.
- **The smallest admissible $m$.** $m=4$, where $N=6$ and $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ carries $(2,-1,-1)/\sqrt6$ on $\Lambda^+$ with $\Lambda^-=0$, three negative-free zero eigenvalues, so the smallest admissible dimension already has $\ker W\ne0$. Nothing in the chain degrades there. **No finding.** $m\le3$ is the $W=0$ edge of §7.
- **Odd $m$.** *No finding: $G$ carries no $m$ at all, and no step distinguishes the parities.* This is the one place the discarded row marginal earns its keep, had it been retained, $m$ would sit in the bound and the $\Theta_n$ parity split of [conventions.md](../findings/conventions.md) would have to be checked against it.

## 10. Two internal inconsistencies in the block's own bookkeeping

**(a) The withdrawn endpoint certificate is still presented as the argument.** The block's "residual inequality" paragraph closes $(0.7,A_0]$ *"at the endpoint, where $g(A_0)=\sqrt6/2$, $g'(A_0)=0$ and $-\tfrac12g''(A_0)=\tfrac94\sqrt6$ against $\psi^*=\tfrac32\sqrt6\varepsilon^2$, a margin of $\tfrac34\sqrt6$."* Three sections later the same file withdraws exactly that: *"The second-order expansion has every constant exactly right but **carries no remainder bound and points the wrong way** … certifies nothing outside an unspecified neighbourhood."* The constants are right (I verified every one in §9) and the *conclusion* survives through bisection, but the paragraph a reader meets first offers a certificate the file itself has retired. **REFUTED AS STATED**, repairable by one clause.

**(b) The bands are described three ways and they do not line up.** "$(\tfrac13,0.7096]$ closes by $200$-bit interval arithmetic … and $[0.7,0.7096]$ by bisection" (summary); "$F<\sqrt{3/2}$ on $(0,0.7096]$ in $73$ boxes, $Q<0$ on $[0.7096,A_0]$ in $21$" (Gate 2 section); "$Q$ genuinely fails at $A=0.70$, so $[0.7,0.7096]$ goes to direct bisection instead" (repair section). The **union is covered** and I record no gap in coverage, but $[0.7,0.7096]$ is claimed by two different methods in two places, and the summary's "$(\tfrac13,0.7096]$" leaves $(0.7096,A_0]$ unattributed until a later section supplies it. Also noted: $F'>0$ is certified on $[10^{-12},0.8164]$ while $A_0=0.8164965\ldots$, so the monotonicity certificate stops short of $A_0$, harmless, since that sliver is inside the $Q<0$ band, but worth stating rather than leaving to the reader.

## 11. Where the proof actually lives, and where the record says it does

The block's load-bearing sentence is: *"With $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$ and two further elementary bounds, $G$ is dominated by a three-parameter relaxation strictly increasing in $s$ and $u$."* **The two further bounds are not named, and the relaxation is not displayed, anywhere in [findings/](../findings/) or [results.md](../results.md).** They are in [REVIEW_r63.md](../reviews/REVIEW_r63.md): $\sum_P\lambda^3\le A^3+\min(A,\sqrt d)d$ and $d\le\sigma^2$, giving

$$R(A,s,u)=A^3+\min(A,\sqrt d)d+\min(A,K_0\sqrt d)(s^2-u)-s^3+3bc(s+2A).$$

I checked r63's steps at source rather than taking them:

- $h\le\lambda_1$ (harmonic $\le$ max) and $h\le3\lambda_2\lambda_3/(\lambda_2+\lambda_3)=\tfrac32H_2(\lambda_2,\lambda_3)\le\tfrac32\sqrt{d/2}=K_0\sqrt d$, using harmonic $\le$ quadratic on two arguments under $\lambda_2^2+\lambda_3^2\le d$. ✔
- $\partial_uR\ge0-A+\tfrac32(s+2A)=\tfrac32s+2A>0$, using $s^2\ge u$ so that $(s^2-u)\partial_u\min(\cdot)\ge0$. ✔
- $\partial_sR=2s\min(A,K_0\sqrt d)-3s^2+3s(s+2A)+3bc=2s\min(\cdot)+6sA+3bc>0$. ✔
- At the boundary $s=\sqrt{2-2u}$: $s^2-u=2-3u$ and $-s^3+\tfrac32(1-u)\sqrt{2-2u}=-\tfrac14(2-2u)^{3/2}$, giving r63's $R2$. ✔
- In the region $K_0\sqrt d\le A$, with $t=\sqrt d$ and the convexity step, $R2\le g(A)+\alpha t+\beta t^2+\gamma t^3$ with $\alpha=K_0(2-3A^2)$, $\beta=\tfrac34\sqrt{2-2A^2}-3A$, $\gamma=1-3K_0<0$ and $0\le t\le\tfrac{2\sqrt2}3A$. ✔ Every coefficient reproduces.

So the mathematics is sound where I can reach it, the verdict on claim 6 is **CONFIRMED AS ALGEBRA**. But **the record's canonical block does not carry it**, and [r570](../reviews/REVIEW_r570.md) logged the same: *"The one link left unchecked is the monotonicity of the three-parameter relaxation $R(A,s,u)$ in $s$ and $u$, whose proof is in reviews/ rather than on the record."* A reader of [findings/](../findings/) alone cannot follow L35 from $G$ to $g+\psi$, and a reviews file is a report, not the record.

## 12. Symbol collisions inside this one lemma

[conventions.md](../findings/conventions.md) names the collisions across files; these are inside a single block, which is worse.

| symbol | sense 1, in the block | sense 2, in the same block | consequence |
|---|---|---|---|
| $T$ | $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$, the bracket tensor the whole chain is about | $T=\tfrac{2\sqrt2}3A$, the cap on $t$ in $\max_{0\le t\le T}\psi(t)$ | two objects, twelve lines apart, one letter |
| $\alpha,\beta,\gamma$ | eigenvalue indices in $\sum_{\alpha<\beta<\gamma}$ | the coefficients of $\psi(t)=\alpha t+\beta t^2+\gamma t^3$ | the same three letters, same block |
| $\psi$ |, | the cubic in $t$ | a **third** sense: [conventions.md](../findings/conventions.md) tables $\psi$ as "the polarisation. **Undefined anywhere on the record**, and its two readings differ by a factor $2$" |
| $\sum\lambda^3$ | over the whole spectrum | over the positives only | §4a, costs the reader the anchor point |
| $d$ | never named in the block | [conventions.md](../findings/conventions.md) fixes it as $u-\lambda_1^2$ | under the [bounds-relaxations.md](../findings/bounds-relaxations.md) reading ($d=$ negative-eigenvalue count $=2$) the block's own bound reads $h\le K_0\sqrt2=\tfrac32$ and is **vacuous**, the trap [conventions.md](../findings/conventions.md) tables, and the block still does not say which $d$ it means |
| $\mathrm{FTP}$ | the positives' triangle packing |, | undefined on the record; it is L42's $M(\lambda_P)$ under a second name |

$s$ is safe: $s=\sum_P\lambda$ and $s=b+c$ are numerically the same number by trace-freeness, so the two readings coincide.

## 13. Withdrawn candidates

Three lines that looked like findings and are not. Each is recorded so the next verifier does not spend an adjudication on it.

- **"The $(+--)$ transport double-counts the $(+-)$ pair caps."** The triple $\{\alpha,n_1,n_2\}$ loads the caps at $(\alpha,n_1)$ and $(\alpha,n_2)$ as well as at $(n_1,n_2)$, so putting the full mass $2$ on $\lambda_1$ might have been infeasible. **Withdrawn**: each $(+-)$ cap then carries exactly $2$, which meets the cap with equality. Feasible.
- **"Dropping the row marginal breaks the $m$-freeness claim."** If the marginals were inequalities $\le m-2$ rather than equalities, dropping them would still enlarge; and the objective's support argument, not the marginal, is what removes $m$. **Withdrawn**: the claim is right and its reason is right.
- **"The claim that the chain never uses the first Bianchi identity is false, since $\mathrm{Alt}(W)=0$ enters somewhere."** I looked for it in the identity, in L31 and in the trace-free relations and found no use. **Withdrawn**, but see §2: trace-freeness *is* used, so "no Weyl hypothesis" overstates it by one property.

## 14. What would falsify the statement, and what I did to look for it

**A falsifier is:** a $W\in\mathrm{Weyl}_m$, any $m$, whose spectrum on $\Lambda^2\mathbb R^m$ has at most two strictly negative entries and $P(W)/\lVert W\rVert^3>\sqrt{3/2}$. Equivalently, since every step of the chain is in the enlarging direction, a spectrum with $\lambda_1+\cdots-b-c=0$, $\sum\lambda^2=1$ and $G(\lambda)>\sqrt{3/2}$ **that is realised by an actual bracket tensor**, a spectrum with $G>\sqrt{3/2}$ alone would falsify only the relaxation, not the lemma, and a realisability argument would still be owed.

**What I did.** I checked the diagonal locus in closed form and proved the hypothesis confines it to a $4$-plane, where the maximum is $\Theta_4=\sqrt3/2$, comfortably under. I computed the balanced sphere product's Weyl spectrum in closed form and found $m^2$ negative eigenvalues at $n=2m$, so the one family known to beat $\sqrt{3/2}$ from $n=12$ is excluded by the hypothesis rather than by the bound, which is the reassuring answer. I checked $\mathbb{CP}^2$ padded and found the equality case. I ran no search, no sweep and no sampling; the subalgebra-Casimir and torus families I could not reach in closed form and I have marked them untested rather than cleared.

**Where a falsifier would have to hide.** Not in the relaxation, $\sup G=\sqrt{3/2}$ is the record's claim at every $k$ and the corner $A=A_0$, $d=0$, $b=c$ is exactly the padded $\mathbb{CP}^2$ point, so the relaxation is tight at the right place. It would have to hide in the two cases the argument does not reach: **$k=2$ with two negatives**, and **exactly one negative eigenvalue**. Both are the debts of §5 and §6, and both are cases where the record currently asserts a maximisation nobody has written down. That coincidence (that the unproved cases are the ones nobody has checked), is the reason to discharge them rather than to assume them.

## Verdict

**HYPOTHESIS-DEBT.**

Every hand-checkable step reproduces exactly, and several of them are better than the block claims: the coefficient $3$ has a third independent derivation, L42 is right in all four of its parts, the decoupling is a genuine identity, $R$'s monotonicity is correct in both variables, and all seven endpoint constants, $g(A_0)=\tfrac{\sqrt6}2$, $g'(A_0)=0$, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$, $\alpha=3\sqrt3\varepsilon$, $\beta=-\tfrac34\sqrt6$, $t^*=\sqrt2\varepsilon$, $\psi^*=\tfrac32\sqrt6\varepsilon^2$, plus the band value $\tfrac89$ at $A=\tfrac13$ come out on the nose in exact arithmetic.

**Two cases of the statement have no argument on file, and one of them is circular.**

1. **$k=2$ positive eigenvalues.** L35 says it "closes in closed form" and routes it to L29; L29's own block says the maximisation "appears on no site, here or elsewhere, and is owed" and names L35 as unable to discharge it. What is owed is stated exactly in §5: either the two-parameter maximisation (a), or the domination (b) that would absorb $k\le2$ into the main chain.
2. **Exactly one negative eigenvalue.** Owed a line, by the block's own admission and by [INDEX-results.md](../findings/INDEX-results.md) row 35. §6 names what the line must establish.

Alongside them, four repairs that change no value: the $\sum\lambda^3$ range collision (§4a), the withdrawn endpoint certificate still standing as the $(0.7,A_0]$ argument (§10a), the band bookkeeping (§10b), and the relaxation $R$ living only in [reviews/](../reviews/) (§11). And the closing inequality on $(\tfrac13,A_0]$ remains a certified numerical step that this loop cannot check either way.
