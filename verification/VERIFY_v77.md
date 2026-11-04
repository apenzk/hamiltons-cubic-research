# Verifier v77, the orbit Gram's mod-$p$ rank, the $3570$ cap, and the three conclusions the squeeze is said to yield

I worked from a cold brief and from the definitions at source: [findings/sym3-blocks.md](../findings/sym3-blocks.md), [findings/conventions.md](../findings/conventions.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [results.md](../results.md), and the two measurement scripts read **as text**. **I did no numerical work of any kind, no script, no Sage, no numerics, and I wrote none.** Every value below is exact arithmetic done by hand and reproducible by hand. Log: [agent_logs/verify-L87-v77.log](../agent_logs/verify-L87-v77.log).

## Claim table

| # | claim, as the record states it | verdict | reason |
|---|---|---|---|
| C1 | the computed object is the Gram $\langle g_aW_0,g_bW_0\rangle^3$ over $3700$ orbit points over $\mathbb F_{46337}$ | **CONFIRMED** | [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) computes exactly that, with $p=46337$ prime and $N=3700$ |
| C2 | the reported value of that rank is $3570$ | **HYPOTHESIS-DEBT** | no stored output anywhere in the repo; the number reaches the record only through [REVIEW_r178.md](../reviews/REVIEW_r178.md)'s prose |
| C3 | *"a mod-$p$ rank is a lower bound for the characteristic-zero span"*, applied to this matrix | **REFUTED AS STATED** | the $g_a$ are Cayley transforms of skew matrices drawn **in** $\mathbb F_p$, so the Gram is the reduction of nothing; the repairing lift is named nowhere in [findings/](../findings/) |
| C4 | $3570=\sum_\lambda d_\lambda$ over the $\lambda_2$-even blocks | **CONFIRMED** | re-derived by hand from [L83](../findings/sym3-blocks.md)'s table, sixteen terms, exactly $3570$ |
| C5 | *"using $\dim V_\lambda^H\le1$"* establishes that cap | **REFUTED AS STATED** | that hypothesis alone gives $\sum_{\text{all }24}d_\lambda=5640$; the restriction to even $\lambda_2$ is [L86](../findings/sym3-blocks.md)'s vanishing, uncited here |
| C6 | the squeeze's two ends are ranks of the same thing | **CONFIRMED AS ALGEBRA** | four links, all pointing the right way, but link one needs the integral lift C3 lacks |
| C7 | *"the span is exactly $3570$"* | **CONFIRMED AS ALGEBRA** | follows from C2 + C4 + C6, hence conditional on one unstored machine value and one unwritten lift |
| C8 | *"every one of the sixteen evaluation maps is nonzero"* | **CONFIRMED AS ALGEBRA** | an attained upper bound with each summand capped at $1$ forces every summand to be $1$; one block has an independent closed-form witness |
| C9 | *"every even block loses exactly one multiplicity"* | **CONFIRMED AS ALGEBRA** | needs one further import, uncited in L87: that the orbit constraint on $M_\lambda$ is the vanishing of a **single** linear functional |
| C10 | attribution, *"reviewer 174 measured $3570$"* ([sym3-blocks.md:120](../findings/sym3-blocks.md)) | **REFUTED** | [REVIEW_r174.md](../reviews/REVIEW_r174.md) *derives* the cap and calls $3570$ *"the record's measured span"*; the measurement is [r173](../reviews/REVIEW_r173.md)'s |
| C11 | *"174's 'measured' $3570$ is independently reproduced"* | **REFUTED AS STATED** | [orbit_span.sage:2](../scripts/reviewers/r178/orbit_span.sage) writes the target $3570$ into the script's own header before the run |
| C12 | [results.md:23](../results.md)'s use of L87 | **REFUTED AS STATED** | it says *"a sampled mod-$p$ rank is a rigorous lower bound … so L87's rank and L62's value are proofs rather than measurements"*, true of [L62](../findings/sym3-blocks.md), false of L87 as written |
| C13 | four hypotheses the argument uses and the block never states | **HYPOTHESIS-DEBT** | complete reducibility in characteristic zero; $H$ fixes $W_0^3$; [L83](../findings/sym3-blocks.md)'s block list; [L86](../findings/sym3-blocks.md)'s parity rule |

## One-line summary

**The mathematics is right and the numbers are exactly right, I re-derived $3570$, $5640$, $16$, $25$, $36$, the eight deaths and the $(2,3\times3)+(5,2\times2)+(9,1)$ shape by hand, but the sentence that carries the lower bound is a non sequitur about the matrix that was actually formed, the cap's stated ground gives $5640$ rather than $3570$, the machine value it is squeezed against is stored nowhere in the repo, and the attribution names the wrong reviewer for the wrong act.**

## 0. Conventions, fixed once

Quoted from the brief:

- $\mathcal W_5$: algebraic Weyl curvature operators at $n=5$, the $O(5)$-irreducible $[2,2]$, dimension $35$.
- $W_0$: the zero-padding into $\mathcal W_5$ of the $\mathbb{CP}^2$ Weyl operator; $g_aW_0$ are points of its $O(5)$-orbit.
- The blocks are the $O(5)$-constituents of $\mathrm{Sym}^3\mathcal W_5$; $\lambda_2$ is the second part of the highest weight; $d_\lambda$ is a constituent's dimension; $V_\lambda^H$ is the subspace fixed by the stabiliser $H$ of $W_0$.

Two readings the record admits, and the one I adopted in each case.

- **The weight-label basis.** [L83](../findings/sym3-blocks.md)'s own provenance note records that the table is in the $e$-basis while the prose above it is in the $\omega$-basis. **I read every $\lambda$ in the $e$-basis**, which is forced: the table's $(4,2)$ carries dimension $220$, and Weyl's $B_2$ formula $\tfrac16(2a{+}3)(2b{+}1)(a{-}b{+}1)(a{+}b{+}2)$ gives $\tfrac16\cdot11\cdot5\cdot3\cdot8=220$ at $(a,b)=(4,2)$ in the $e$-basis against $260$ in the $\omega$-basis. In the $\omega$-basis the parity rule and hence the whole even/odd split would be a different partition of the $24$.
- **"The span".** The statement's *"the characteristic-zero span"* has no antecedent inside the statement. **I read it as $C:=\mathop{\mathrm{span}}_{\mathbb R}\{(gW_0)^{\otimes3}:g\in O(5,\mathbb R)\}\subseteq\mathrm{Sym}^3\mathcal W_5$**, the $O(5)$-submodule generated by $W_0^3$. This is forced by the surrounding block, which at [sym3-blocks.md:120](../findings/sym3-blocks.md) writes *"$\sum_\lambda(\mathrm{rank}_\lambda\cdot d_\lambda)$ is the dimension of the $O(5)$-submodule generated by $W_0^3$"*, and it is the only reading under which the number $3570$ is a cap on anything.
- **$C$ versus $K$.** The complementary object $K=C^\perp$, of dimension $7770-3570=4200$, is [L91](../findings/sym3-blocks.md)'s. L87 is about $C$, not $K$; I checked nothing about $K$.

## 1. Hypothesis inventory

### 1.1 What the statement carries explicitly

| hypothesis, as written | is it true of the object it is applied to | is it used |
|---|---|---|
| the Gram is $\langle g_aW_0,g_bW_0\rangle^3$ | yes, [orbit_span.sage:46–47](../scripts/reviewers/r178/orbit_span.sage) forms $MM^{\mathsf T}$ then cubes entrywise | yes, load-bearing |
| $3700$ orbit points | yes, and $3700>3570$ is *necessary*: a rank cannot reach $3570$ from fewer rows | yes |
| the field is $\mathbb F_{46337}$ | $46337$ is prime (trial division to $\lfloor\sqrt{46337}\rfloor=215$ clears it) | yes |
| "a mod-$p$ rank is a lower bound for the characteristic-zero span" | **false of this matrix**, §3 | yes, load-bearing, this is the entire lower bound |
| $\dim V_\lambda^H\le1$ | true, by [L86](../findings/sym3-blocks.md) | yes, but insufficient alone, §2 |
| the sum runs over the $\lambda_2$-even blocks | true, but this *is* [L86](../findings/sym3-blocks.md)'s odd-block vanishing smuggled into a summation range | yes, load-bearing, and uncited |

### 1.2 Hypotheses of imported results, checked against the object

- **[L86](../findings/sym3-blocks.md), $\dim V_\lambda^H=1\iff\lambda_2$ even.** Its $H$ is $\mathrm{Stab}_{O(5)}(W_0)$ for the **padded** $W_0$, identity component $U(2)\subset SO(4)$, two components, times the reflection on the padding axis ([sym3-blocks.md:110](../findings/sym3-blocks.md)). The object L87 applies it to is that same padded $W_0$. **Hypotheses match.** L87 imports both halves (the $\le1$ and the $=0$ at odd $\lambda_2$) and cites neither.
- **[L83](../findings/sym3-blocks.md), the $24$-block table.** L87's $3570$ is a sum over that table's weight list and dimension column. It does **not** touch the multiplicity column: swapping the two dimension-$35$ blocks' multiplicities leaves $3570$ fixed, which the record itself records at [sym3-blocks.md:154](../findings/sym3-blocks.md). **Hypotheses match; the citation is absent.**
- **Complete reducibility of $\mathrm{Sym}^3\mathcal W_5$ as an $O(5)$-module.** Never stated. It is what licenses the isotypic decomposition the cap is a sum over. It holds over $\mathbb R$ ($O(5)$ compact, characteristic zero) and **fails over $\mathbb F_p$**: $|SO(5,\mathbb F_p)|=p^4(p^2-1)(p^4-1)$, so $p$ divides the group order for every $p$ and the module is not semisimple there. The record notes this at [sym3-blocks.md:130](../findings/sym3-blocks.md); L87's own paragraph does not.
- **$H$ fixes $W_0^3$.** Never stated in L87. Without it the $\lambda$-component of $W_0^3$ need not lie in $M_\lambda\otimes V_\lambda^H$ and $\dim V_\lambda^H\le1$ bounds nothing. [conventions.md:44](../findings/conventions.md) flags this exact step as *"the load-bearing step of the reduction to one condition"* and records that $W_0$ and $H$ *"were defined nowhere in findings/"*.

### 1.3 A hypothesis stated and never used

**None.** Every clause in the statement is consumed. The nearest thing is the redundant orthogonality guard at [orbit_span.sage:39](../scripts/reviewers/r178/orbit_span.sage) (a Cayley transform of a skew matrix is orthogonal identically, so the test never fires) but that is a belt-and-braces line in a script, not a hypothesis in the lemma.

### 1.4 Steps using a hypothesis nobody stated

Four, listed in C13 and detailed in §1.2. The two that would change the verdict if false are complete reducibility (which fails in the characteristic the run lives in) and the $H$-fixedness of $W_0^3$.

## 2. The cap, what it caps, and whether the stated ground reaches it

### 2.1 The arithmetic, re-derived

From [L83](../findings/sym3-blocks.md)'s table, the blocks with $\lambda_2$ even, by multiplicity row:

| $m$ | even-$\lambda_2$ blocks | dimensions |
|---|---|---|
| $4$ | $(4,2)$, $(2,2)$ | $220$, $35$ |
| $3$ | $(3,2)$ | $105$ |
| $2$ | $(5,2)$, $(4,4)$, $(4,0)$, $(3,0)$, $(2,0)$ | $390$, $165$, $55$, $30$, $14$ |
| $1$ | $(6,6)$, $(6,4)$, $(6,2)$, $(6,0)$, $(5,4)$, $(5,0)$, $(1,0)$, $(0,0)$ | $455$, $810$, $625$, $140$, $429$, $91$, $5$, $1$ |

$2+1+5+8=16$ blocks, and

$$220+35+105+390+165+55+30+14+455+810+625+140+429+91+5+1=3570 .$$

Running total: $255,360,750,915,970,1000,1014,1469,2279,2904,3044,3473,3564,3569,3570$. **$3570$ confirmed exactly.** It agrees term for term with [REVIEW_r174.md:88](../reviews/REVIEW_r174.md)'s independent list.

The odd-$\lambda_2$ blocks are $(4,3)_{231}$, $(4,1)_{154}$, $(3,1)_{81}$, $(2,1)_{35}$, $(6,3)_{770}$, $(5,3)_{455}$, $(5,1)_{260}$, $(3,3)_{84}$, summing to $2070$. So $\sum_{\text{all }24}d_\lambda=3570+2070=5640$. **The record's $5640$ is confirmed.**

### 2.2 What the cap is a cap on

It is a cap on $\dim_{\mathbb R}C$, $C$ the $O(5)$-submodule of $\mathrm{Sym}^3\mathcal W_5$ generated by $W_0^3$. The derivation the record supports, in full:

1. $\mathrm{Sym}^3\mathcal W_5=\bigoplus_\lambda M_\lambda\otimes V_\lambda$, $M_\lambda$ the multiplicity space. **Needs complete reducibility.**
2. $W_0$ is $H$-fixed, so $W_0^3$ is $H$-fixed, so $W_0^3\in\bigoplus_\lambda M_\lambda\otimes V_\lambda^H$. **Needs the unstated $H$-fixedness.**
3. $\dim V_\lambda^H\le1$, so the $\lambda$-component is a **pure** tensor $a_\lambda\otimes v_\lambda$ with $v_\lambda$ spanning $V_\lambda^H$. **This is where $\dim V_\lambda^H\le1$ enters, and it is the only place.**
4. The submodule generated by a pure tensor $a_\lambda\otimes v_\lambda$ is $\mathbb R a_\lambda\otimes V_\lambda$, of dimension $r_\lambda d_\lambda$ with $r_\lambda=[a_\lambda\neq0]\in\{0,1\}$; and the submodule generated by a sum equals the sum of the submodules generated by its isotypic parts, the isotypic projectors lying in the image of the group algebra.
5. $r_\lambda=0$ whenever $V_\lambda^H=0$, i.e. whenever $\lambda_2$ is odd. **This is [L86](../findings/sym3-blocks.md)'s vanishing half, and it is the step that turns $5640$ into $3570$.**
6. Hence $\dim C=\sum_{\lambda_2\text{ even}}r_\lambda d_\lambda\le3570$.

### 2.3 Discrepancy: the stated ground is too weak, three-step record

- **Locate.** The clause *"$3570$ is the theoretical cap, $\sum_\lambda d_\lambda$ over the $\lambda_2$-even blocks, using $\dim V_\lambda^H\le1$"* at [sym3-blocks.md:140](../findings/sym3-blocks.md). It names one hypothesis and needs two.
- **Exhibit.** Step 5 above is not an instance of $\dim V_\lambda^H\le1$; it is $\dim V_\lambda^H=0$. A reader who has only the stated hypothesis derives $\dim C\le\sum_{\text{all }24}d_\lambda=5640$. Concretely at $\lambda=(3,3)$: $\lambda_2=3$ is odd, $d_\lambda=84$, and $\dim V_{(3,3)}^H\le1$ is perfectly consistent with $\dim V_{(3,3)}^H=1$ and $r_{(3,3)}=1$, contributing $84$ to a cap the statement's sum excludes. **At $5640$ the squeeze does not close**: a measured $3570$ against a cap of $5640$ forces nothing, and in particular does not force any $r_\lambda=1$.
- **Argue the opposite.** The strongest reading the words support: *"over the $\lambda_2$-even blocks"* is a summation range, and a summation range is itself an assertion, that the odd blocks contribute zero. On that reading the sentence is not false, merely compressed, and *"using $\dim V_\lambda^H\le1$"* names the one hypothesis doing work **within** the range. **This reading is available and I think it is what the author meant.** It does not dissolve the finding, because the compressed assertion is exactly [L86](../findings/sym3-blocks.md)'s conclusion and L87 cites [L86](../findings/sym3-blocks.md) nowhere, the block carries no links at all. **Recorded as REFUTED AS STATED with the charitable reading on the face of it**, and the repair is one citation, not a number.

## 3. The squeeze, every inequality, its direction, and what each rank is the rank of

### 3.1 The chain, written out

Write $K^{(p)}$ for the $3700\times3700$ matrix the script forms, $K^{(p)}_{ab}=\langle W_a,W_b\rangle^3$ with $W_a=\Lambda^2(g_a)\,W_0\,\Lambda^2(g_a)^{\mathsf T}$ and $g_a\in SO(5,\mathbb F_p)$.

| link | inequality | direction | what it relates |
|---|---|---|---|
| (a) | $\mathop{\mathrm{rank}}_{\mathbb F_p}K^{(p)}\le\mathop{\mathrm{rank}}_{\mathbb Q}\widetilde K$ | reduction under-counts | an $\mathbb F_p$ matrix to a $\mathbb Q$ matrix reducing to it, **requires such a $\widetilde K$ to exist** |
| (b) | $\mathop{\mathrm{rank}}_{\mathbb Q}\widetilde K=\dim_{\mathbb Q}\mathop{\mathrm{span}}\{\widetilde W_a^{\otimes3}\}$ | equality | Gram rank to span dimension, valid because the form is positive definite over $\mathbb R\supseteq\mathbb Q$ |
| (c) | $\dim\mathop{\mathrm{span}}\{\widetilde W_a^{\otimes3}\}\le\dim C$ | sampling under-counts | finitely many orbit cubes to the whole submodule |
| (d) | $\dim C\le3570$ | $\dim V_\lambda^H\le1$ over-counts | §2.2 |

**Every direction is right, and the conclusion consumes each the right way round**: (a)–(c) give $3570\le\dim C$ from below, (d) gives $\dim C\le3570$ from above, and equality collapses (c) and (d) simultaneously.

Two remarks on the algebra, both of which I checked and both of which hold.

- **The Veronese identity.** $\langle v^{\otimes3},w^{\otimes3}\rangle=\langle v,w\rangle^3$ exactly, so the entrywise cube of the ordinary Gram *is* the Gram of the cubes. [orbit_span.sage:46–47](../scripts/reviewers/r178/orbit_span.sage) is the honest implementation of this, and no $7770$-dimensional object is ever built.
- **Over $\mathbb F_p$ a Gram rank can fall short of the span dimension** (isotropic vectors). That is the safe direction here (it makes link (a)'s composite an under-count, never an over-count) so it is a reason the argument is sound rather than a defect.

### 3.2 Discrepancy: the two ends are ranks of different objects, three-step record

- **Locate.** *"A mod-$p$ rank is a lower bound for the characteristic-zero span"*, [sym3-blocks.md:140](../findings/sym3-blocks.md). This is link (a), and it presupposes a characteristic-zero matrix $\widetilde K$ whose reduction is $K^{(p)}$.
- **Exhibit.** [orbit_span.sage:32–38](../scripts/reviewers/r178/orbit_span.sage) fixes $p=46337$ **first**, then draws each entry as `a = F.random_element()` (an element of $\mathbb F_p$, not of $\mathbb Z$) and sets $g=(I-A)(I+A)^{-1}$ inside $\mathbb F_p$. So $g_a\in SO(5,\mathbb F_p)$, $K^{(p)}$ is formed natively in characteristic $p$, and **there is no $\widetilde K$ in the chain at all**: link (a) relates $\mathop{\mathrm{rank}}_{\mathbb F_p}K^{(p)}$ to nothing. The left end of the squeeze is the rank of a matrix over $\mathbb F_p$ built from $\mathbb F_p$-points; the right end is the dimension of a real $O(5,\mathbb R)$-submodule. **They are ranks of different objects, and as written nothing connects them.** The escape of reading the whole argument in characteristic $p$ is closed independently: $p\mid|SO(5,\mathbb F_p)|=p^4(p^2-1)(p^4-1)$ for every $p$, so $\mathrm{Sym}^3\mathcal W_5$ is not semisimple over $\mathbb F_p$ and the isotypic decomposition step (1) of §2.2 needs does not exist there.
- **Argue the opposite.** The strongest reading: the author may have meant *"lift, then reduce"*, and the lift is real. Take representatives in $\{-(p-1)/2,\dots,(p-1)/2\}$ for the strict upper triangle of $A$ and set $\tilde A$ skew over $\mathbb Z$. For real skew $\tilde A$ the eigenvalues of $I+\tilde A$ are $1\pm is_j$ in conjugate pairs, so $\det(I+\tilde A)=\prod_j(1+s_j^2)\ge1$ and $\tilde g=(I-\tilde A)(I+\tilde A)^{-1}\in O(5,\mathbb Q)$ genuinely. It is $p$-integral because $\det(I+\tilde A)\equiv\det(I+A)\not\equiv0$, the run having discarded the singular draws at [orbit_span.sage:37](../scripts/reviewers/r178/orbit_span.sage). $W_0$ lifts too, its entries in $\{0,\pm1,\pm2\}$ by [orbit_span.sage:21–24](../scripts/reviewers/r178/orbit_span.sage). Reduction being a ring homomorphism, $\widetilde K$ then exists and reduces to $K^{(p)}$, and links (a)–(d) run. **So the conclusion survives, and the finding stands, because the lemma does not say this.** I searched [findings/sym3-blocks.md](../findings/sym3-blocks.md) and [results.md](../results.md) for the lift and it is present only as the half-sentence *"repairable in two lines by an integral lift"* in the audit note four lines **above** the lemma, which itself says *"that lift is nowhere on the record"*. **REFUTED AS STATED, repairable, and the repair is two lines nobody has written into the lemma.**

### 3.3 A second, smaller mismatch of objects

The Cayley transform reaches only $SO(5,\mathbb F_p)$, and only its subset with $-1$ not an eigenvalue; the statement says *"orbit points"* without qualification, and the cap is an $O(5)$-cap. **This is inert**, and I record it as checked rather than as a finding: $-I$ acts trivially on $\mathcal W_5$ and hence on $\mathrm{Sym}^3\mathcal W_5$, and at $n=5$ we have $O(5)=SO(5)\times\{\pm I\}$, so the $SO(5)$- and $O(5)$-submodules generated by $W_0^3$ coincide. The record states the $-I$ half at [sym3-blocks.md:111](../findings/sym3-blocks.md).

## 4. The three conclusions

### 4.1 *"The span is exactly $3570$"*

**Follows**, from the four links of §3.1 with equality at both ends, given the lift of §3.2 and given the machine value of §5.2. It is the dimension of $C$, not of $K$ and not of any sampled matrix.

### 4.2 *"Every one of the sixteen evaluation maps is nonzero"*

**Follows, and the step is clean.** $\dim C=\sum_{\lambda_2\text{ even}}r_\lambda d_\lambda$ with each $r_\lambda\in\{0,1\}$ and $\sum_{\lambda_2\text{ even}}d_\lambda=3570$. If any single $r_\mu$ were $0$ then $\dim C\le3570-d_\mu<3570$, since every $d_\mu\ge1$. So $\dim C=3570$ forces $r_\lambda=1$ for all sixteen. **The smallest block is the load-bearing case and it is fine**: $d_{(0,0)}=1$, so even the trivial block's death would drop the total to $3569$ and be detected.

**"Evaluation map" is not defined in L87.** I read $\mathrm{ev}_\lambda:M_\lambda\to V_\lambda^H$, the map whose non-vanishing is $a_\lambda\neq0$ in §2.2 step 4; this is the reading [sym3-blocks.md:118](../findings/sym3-blocks.md) sets up (*"Frobenius reciprocity bounds the evaluation map $M_\lambda\to V_\lambda^H$"*) and the one [REVIEW_r178.md](../reviews/REVIEW_r178.md) uses. Under it, nonzero and onto coincide, $V_\lambda^H$ being a line.

**A witness from a structured family, in closed form, independent of the run.** Take $\lambda=(0,0)$, the trivial block, $m=1$, $d=1$, $\lambda_2$ even. The unique cubic invariant on $\mathcal W_5$ is $\mathop{\mathrm{tr}}(W^3)$, the file's own remark that at $n\le5$, $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ makes the cubic invariant space one-dimensional, so $r_{(0,0)}=1$ iff $\mathop{\mathrm{tr}}(W_0^3)\neq0$. At the script's own unnormalised $W_0$, whose $\Lambda^2$-spectrum is $(4,-2,-2,0^7)$ by [orbit_span.sage:24–26](../scripts/reviewers/r178/orbit_span.sage),

$$\lVert W_0\rVert^2=16+4+4=24,\qquad \mathop{\mathrm{tr}}(W_0^3)=64-8-8=48,$$

$$\tfrac32\lVert W_0\rVert^6=\tfrac32\cdot 13824=20736,\qquad 9\mathop{\mathrm{tr}}(W_0^3)^2=9\cdot2304=20736 .$$

**$F_5(W_0)=0$ exactly, in integers, at the script's normalisation**, which simultaneously confirms that the script's $W_0$ is the right point and that $\mathop{\mathrm{tr}}(W_0^3)=48\neq0$. So $r_{(0,0)}=1$, **proved without the run**; and the argument is forced rather than lucky, since $F_5(W_0)=0$ with $W_0\neq0$ makes $\mathop{\mathrm{tr}}(W_0^3)^2=\lVert W_0\rVert^6/6\neq0$ automatic. Normalising to $\lVert W_0\rVert=1$ gives $\mathop{\mathrm{tr}}(W_0^3)=\pm1/\sqrt6$, matching the value [REVIEW_r178.md](../reviews/REVIEW_r178.md) lists among what it did not check.

**For the other fifteen I have no closed-form witness and neither does the record.** Exhibiting one means constructing the covariant $\sigma_\lambda$ and evaluating it at $W_0$, which is computation this task carries no approval for. The nearest thing on the record is [sym3-blocks.md:122](../findings/sym3-blocks.md)'s proposal (evaluate the $41$ highest-weight vectors at a handful of orbit points) which the block itself says was never run, this lemma having substituted a better measurement instead.

### 4.3 *"Every even block loses exactly one multiplicity"*

**Follows only with one further import, uncited.** From $r_\lambda=1$ we get that the $\lambda$-component of $W_0^3$ is $a_\lambda\otimes v_\lambda$ with $a_\lambda\neq0$. The step to *"loses exactly one multiplicity"* is: the orbit constraint restricted to $M_\lambda$ is precisely $\langle\,\cdot\,,a_\lambda\rangle=0$, a **single** nonzero linear functional, hence $M'_\lambda=a_\lambda^\perp$ has $\dim M'_\lambda=m_\lambda-1$. That the constraint is one functional and not $m_\lambda$ of them is the *"reduction to one condition"* of [sym3-blocks.md:110](../findings/sym3-blocks.md), resting on $\dim V_\lambda^H\le1$ applied to the $H$-invariant $W_0^3$. **L87's paragraph asserts the conclusion and does not carry the step.** It is one line, it is true, and it is [L86](../findings/sym3-blocks.md)'s, which L87 does not cite.

**The downstream arithmetic all reproduces**, which I checked by hand as a consistency test of the reading:

- surviving multiplicities $41-16=25$;
- $m'$: $(4,2)$ and $(2,2)$ drop $4\to3$; $(3,2)$ drops $3\to2$; the five even $m=2$ blocks drop to $1$; the eight even $m=1$ blocks drop to $0$; all eight odd blocks keep $m$;
- shape: two $3\times3$ (the ex-$4$s), five $2\times2$ (the ex-$3$ plus the four odd $m=2$ blocks $(4,3),(4,1),(3,1),(2,1)$), nine scalars (the five ex-$2$ evens plus the four odd $m=1$ blocks $(6,3),(5,3),(5,1),(3,3)$);
- unknowns $2\cdot6+5\cdot3+9\cdot1=12+15+9=36$, and multiplicities $2\cdot3+5\cdot2+9\cdot1=25$, **the two totals agree with the record independently**;
- the eight deaths are exactly the even $m=1$ blocks: $(0,0)$, $(1,0)$, $(5,0)$, $(5,4)$, $(6,0)$, $(6,2)$, $(6,4)$, $(6,6)$, matching [sym3-blocks.md:116](../findings/sym3-blocks.md) as a set.

## 5. What the measurement is a measurement of

Read as text: [scripts/reviewers/r178/orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), $49$ lines, and for comparison [scripts/reviewers/r173/r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py).

### 5.1 The object, precisely

| ingredient | what the script actually does |
|---|---|
| ring | $\mathbb F_{46337}$ throughout; **no floating point and no tolerance anywhere** |
| $W_0$ | a $10\times10$ symmetric matrix on $\Lambda^2\mathbb F_p^5$, $2w_1w_1^{\mathsf T}-w_2w_2^{\mathsf T}-w_3w_3^{\mathsf T}$ with $w_1=e_{01}+e_{23}$, $w_2=e_{02}-e_{13}$, $w_3=e_{03}+e_{12}$, the self-dual $2$-forms of the $\mathbb R^4$ block, so the $\Lambda^2$-spectrum is $(4,-2,-2,0^7)$, the $\mathbb{CP}^2$ Weyl operator at twice the projector scale, zero on the seven directions involving $e_5$ |
| group elements | $3700$ Cayley transforms $g=(I-A)(I+A)^{-1}$ of skew $A$ with entries drawn by `F.random_element()`, **in $\mathbb F_p$**; singular $I+A$ discarded; seed $178$ |
| the action | $L=\Lambda^2 g$ as a $10\times10$ matrix in the $e_i\wedge e_j$ basis, $W_g=LW_0L^{\mathsf T}$, the correct action on $\mathrm{Sym}^2(\Lambda^2)$, and $L$ is orthogonal for $g$ orthogonal |
| rows of $M$ | $3700$ rows, each the $100$ flattened entries of $W_g$ |
| columns | $100$; the row space lands in the $35$-dimensional $\mathcal W_5$ |
| the matrix ranked | $K=(MM^{\mathsf T})^{\circ3}$, i.e. $K_{ab}=\langle W_a,W_b\rangle^3$ with $\langle\cdot,\cdot\rangle$ the Frobenius form, $3700\times3700$ |
| what is printed | `K.rank()` beside the string `theoretical cap = 3570` |

**So the statement's description of the computation is accurate in every particular**: the matrix, its size, its entries and its field are exactly as the lemma says. The one thing the description omits is the one thing that matters, that the $g_a$ are $\mathbb F_p$-points.

### 5.2 The value is not in the repository

`K.rank()` is printed to stdout and **no output file exists**: [scripts/reviewers/r178/](../scripts/reviewers/r178/) holds seven `.py`/`.sage` files and no `out*`, no `.txt`, no `.json`. I searched the repo for a stored transcript and found none. The number $3570$ reaches the record through [REVIEW_r178.md](../reviews/REVIEW_r178.md)'s prose alone. **HYPOTHESIS-DEBT**: the lemma's entire lower bound is one unstored machine value, and the lemma links to neither the script nor the review, the block carries no links at all, so a reader cannot reach the run and therefore cannot notice §3.2 either.

### 5.3 The corroborations, and what they are worth

[r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py) builds $W_0$ independently (from the $\mathbb{CP}^2$ curvature tensor through a Weyl projector, normalised), samples $4800$ Haar points of $SO(5,\mathbb R)$, and reads the rank of the same cubed Gram off an eigenvalue gap, reporting $3570$ stably from relative tolerance $10^{-6}$ to $10^{-12}$ ([REVIEW_r173.md](../reviews/REVIEW_r173.md)). [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) reproduces it again over $\mathbb R$ and calls itself a **screen**. **These use genuine characteristic-zero points, exactly what §3.2 says the cited run lacks, and are floating point, exactly what the cited run avoids.** The two defects are complementary, which is the real epistemic situation and which the lemma does not describe.

## 6. Attribution and provenance

- **Who derived the cap.** [REVIEW_r174.md:14](../reviews/REVIEW_r174.md): *"The orbit multiplicities $k_\lambda$ … are **forced** … Summing the dimensions over that rule gives $3570$ **on the nose**, which derives the record's measured span rather than reproducing it."* r174 derived it, and [r178](../reviews/REVIEW_r178.md) derived it again by Frobenius reciprocity on $\mathop{\mathrm{Fun}}(G/H)$.
- **Who measured the span.** [r173](../reviews/REVIEW_r173.md), over $\mathbb R$. r174's own words (*"the record's measured span"*), place the measurement **before** r174.
- **What the record says.** [sym3-blocks.md:120](../findings/sym3-blocks.md): *"which reviewer 174 measured at $3570$"*. **Wrong on both halves**: r174 did not measure, and the measurement is r173's. There is no `scripts/reviewers/r174/` directory. **REFUTED.**
- **"Independently reproduced".** [sym3-blocks.md:140](../findings/sym3-blocks.md) says *"174's 'measured' $3570$ is independently reproduced"*. [orbit_span.sage:2](../scripts/reviewers/r178/orbit_span.sage) reads *"Upper bound from theory … = 3570"* and line 49 prints *"theoretical cap = 3570"*, so the target was in the script before the run. The construction of $W_0$ is genuinely independent of r173's; the **number** was not blind. **REFUTED AS STATED**, and the honest form is "reproduced from an independent construction of $W_0$", which is what [REVIEW_r178.md](../reviews/REVIEW_r178.md) itself writes.
- **The heading.** *"SETTLED, AND THE RANK IS NOW PROVED RATHER THAN MEASURED"* is contradicted by its own paragraph, which measures a rank; [INDEX-results.md:102](../findings/INDEX-results.md) already carries this as the Gate 2 verdict and I confirm it independently.

## 7. Is L87 cited more strongly than its proof reaches

**Yes, once, and it is the canon.** [results.md:23](../results.md): *"A sampled mod-$p$ rank is a rigorous lower bound, and under an exact cap a lower bound is all that is needed, so [L87]'s rank and [L62]'s value are proofs rather than measurements."*

- The premise is true of [L62](../findings/sym3-blocks.md), whose points are drawn over $\mathbb Q$ and then reduced.
- It is **false of L87 as written**, for the reason in §3.2: nothing was reduced.
- The sentence lumps the two together and is [results.md](../results.md)'s **only** mention of L87, the result has no statement in the canon at all, so the one place a canon reader meets it is the place that over-claims it. **REFUTED AS STATED.**

Downstream uses inside [findings/](../findings/) are all within reach of the proof: [L88](../findings/sym3-blocks.md)'s $47=36+11$ transports the rank-one step correctly; [L91](../findings/sym3-blocks.md)'s $4200=7770-3570$ is the complement; [L84](../findings/sym3-blocks.md)'s note that L87 kills two of three Casimir collisions is a consequence of the eight deaths; [L90](../findings/sym3-blocks.md)'s audit at [sym3-blocks.md:299](../findings/sym3-blocks.md) explicitly flags the chain as carrying **two** measured links, which is the accurate description. Two files also **consume L87 without citing it**: [sym3-blocks.md:301](../findings/sym3-blocks.md) records that, and [VERIFY_v67.md](VERIFY_v67.md) records the assembly code assuming the pure-tensor form at a named line without citation.

## 8. The named traps

| trap | finding |
|---|---|
| $\ker W_0\neq0$ | **No finding.** $W_0$ is padded and its $\Lambda^2$-kernel is seven-dimensional, but no step of L87 or of the results it imports assumes a trivial kernel. The padding is *constitutive* rather than incidental: it is what makes $H\supseteq U(2)\times\{\text{reflection on }e_5\}$, and [L86](../findings/sym3-blocks.md)'s stabiliser is derived for the padded object, so hypothesis and object match. The one place the kernel could bite (the Frobenius form over $\mathbb F_p$ degenerating on the span), is in the safe direction (§3.1). |
| boundary of a stated range, smallest admissible dimension | **No finding, and the boundary case is the sharp one.** The cap's smallest summand is $d_{(0,0)}=1$; the squeeze is tight enough to detect even that block's death (§4.2), and I have an independent closed-form proof that it does not die. The smallest even block after it is $d_{(1,0)}=5$. |
| odd $n$ | **No finding, and $n=5$ odd is load-bearing in L87's favour.** Using $SO(5)$ labels as an $O(5)$ block table needs $\det(-I)=-1$, true only at odd $n$; the record states this at [L83](../findings/sym3-blocks.md)'s provenance note and the $\varepsilon$-redundancy at [sym3-blocks.md:111](../findings/sym3-blocks.md). L87 claims nothing beyond $n=5$. |
| a claim proven on a subfamily and cited in general | **No finding inside L87**, but §7's [results.md:23](../results.md) is the same shape one level up: a property true of L62's sampling asserted of both. |
| hypothesis stated and never used | **No finding**, §1.3. |
| step using a hypothesis never stated | **Four**, §1.2 and §1.4. |
| universal claim with no witness | **Partly answered.** "Every even block" has one witness in closed form, $(0,0)$ (§4.2), and fifteen resting on the run. |
| imported theorem whose hypotheses were never checked | **The live one is complete reducibility**, which the argument needs and which fails in the characteristic the run lives in, the same shape as the unital-algebra route the brief cites, and the record catches it at [sym3-blocks.md:130](../findings/sym3-blocks.md) while the lemma does not. |

## 9. Withdrawn candidates

Each of these looked like a defect and does not survive the three-step test. Recorded with the reason.

- **"The script's $W_0$ has spectrum $(4,-2,-2)$ where the record's is $(2,-1,-1)/\sqrt6$, so it is a different point."** *Withdrawn.* Scaling $W_0$ scales every spanning vector of $C$ by the same factor and moves no dimension; and $2\neq0$ in $\mathbb F_{46337}$, so the rescaling is invertible. My own $F_5(W_0)=0$ computation in §4.2 goes through at the script's scale, which is positive evidence that the two are the same point.
- **"The vector block $(1,0)$ can carry no cubic covariant, since $-I\in O(5)$ acts by $-1$ on $\mathbb R^5$ and trivially on any cubic in $W$, so $\mathrm{ev}_{(1,0)}=0$ and the claim is false at a named block."** *Withdrawn, and it is the sharpest thing I tried.* The $O(5)$-constituent labelled $(1,0)$ in this table is $\mathbb R^5\otimes\det$, not $\mathbb R^5$: every constituent of $\mathrm{Sym}^3\mathcal W_5$ has $-I$ acting trivially, and $-I$ acts on $\mathbb R^5\otimes\det$ by $(-1)\cdot\det(-I)=(-1)(-1)=+1$. The covariant is pseudo-vector-valued and the parity obstruction evaporates. The record states the mechanism at [sym3-blocks.md:111](../findings/sym3-blocks.md) and the $\det$-twist convention in [L83](../findings/sym3-blocks.md)'s provenance note. Consistency check: $V_{(1,0)}^H=\mathbb R e_5$ is one-dimensional, matching [L86](../findings/sym3-blocks.md)'s hand-check *"$(1,0)\mapsto1$, realised by $e_5$"*.
- **"Cayley reaches only $SO(5)$, so the sample misses half of $O(5)$ and cannot bound an $O(5)$-cap."** *Withdrawn*, §3.3: the two submodules coincide because $-I$ acts trivially.
- **"The $3700$ draws may repeat, so the effective sample is smaller than stated."** *Withdrawn.* Repeats can only lower a rank, and the run's role is a lower bound; a repeat would make the achieved $3570$ harder, not easier.
- **"$\Lambda^2 g$ as coded is not the induced action, or the Frobenius form is not $O(5)$-invariant."** *Withdrawn.* [orbit_span.sage:11–16](../scripts/reviewers/r178/orbit_span.sage) is $(\Lambda^2g)_{(ij),(kl)}=g_{ik}g_{jl}-g_{il}g_{jk}$, the matrix of $\Lambda^2g$ in the orthonormal $e_i\wedge e_j$ basis; it is orthogonal for orthogonal $g$, and $\mathop{\mathrm{tr}}(W_aW_b)$ is therefore invariant under $W\mapsto LWL^{\mathsf T}$.
- **"$3700<3570$ would make the rank unreachable."** *Withdrawn*, $3700>3570$, and I note it only because the margin is $130$ rows, thin enough that the sample size is a real design choice rather than a formality.
- **"$46337$ might not be prime, so $\mathbb F_{46337}$ is not a field."** *Withdrawn.* Trial division by every prime up to $215>\sqrt{46337}$ leaves a remainder each time; $46337$ is prime, and it is the standard choice as the largest prime below $46341$, the smallest integer whose square exceeds $2^{31}$.

## 10. Verdict for the result as a whole

**GAP, the theorem is true, the proof as written is not a proof, and the citation in [results.md](../results.md) is stronger than either.**

- **Every number is exactly right.** $3570$, $5640$, $16$, $2070$, $25$, $36$, the eight deaths, the two-$3\times3$/five-$2\times2$/nine-scalar shape: all re-derived here by hand from [L83](../findings/sym3-blocks.md)'s table, none of them taken from the record.
- **Every inequality points the right way**, and the two ends of the squeeze become ranks of the same object **once the integral lift is inserted**, which takes two lines and which nobody has written into the lemma.
- **Three things are owed and none of them moves a number**: the lift (§3.2); citations to [L83](../findings/sym3-blocks.md) and [L86](../findings/sym3-blocks.md), the second of which is what turns $5640$ into $3570$ (§2.3); and a link to [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) plus a stored transcript of its output (§5.2).
- **Two things are simply wrong and should be corrected in place**: *"reviewer 174 measured"* (§6) and *"proofs rather than measurements"* at [results.md:23](../results.md) (§7).
- **The label.** This block is the same shape as [L62](../findings/sym3-blocks.md), which the record already split into a `Lemma` for the cap and an `Observation` for the value. **The cap $\dim C\le3570$ is a theorem and deserves the `Lemma`; the value $\mathop{\mathrm{rank}}_{\mathbb F_p}=3570$ is one unstored, unlinked machine number and is an `Observation`.** Everything downstream (the $36$, the eight deaths, the two vanishing Casimir collisions), currently rests on the `Observation` half while being written as if it rested on the `Lemma` half.

## 11. The falsifier

**The object that would falsify L87 is a $\lambda_2$-even block $\mu$ with $r_\mu=0$**, equivalently, a nonzero $O(5)$-equivariant cubic covariant $\sigma_\mu:\mathcal W_5\to V_\mu$ with $\mu_2$ even and $\sigma_\mu(W_0)=0$. Its existence would give $\dim C\le3570-d_\mu\le3569$, contradicting the measured rank, collapsing "every even block loses exactly one multiplicity" to "at most one", turning the $36$ back into a lower bound, and making the eight block deaths (including the $(5,0)$, $(5,4)$ and $(6,2)$ on which *"only one pair needs the quartic"* rests), conditional again.

**What I did to look for one.**

- **I tested the trivial block in closed form and it is not a falsifier.** $\sigma_{(0,0)}=\mathop{\mathrm{tr}}(W^3)$, the unique cubic invariant, and $\mathop{\mathrm{tr}}(W_0^3)=48\neq0$ at the script's normalisation. Better, non-vanishing is *forced*: $F_5(W_0)=0$ and $W_0\neq0$ give $\mathop{\mathrm{tr}}(W_0^3)^2=\lVert W_0\rVert^6/6>0$. I verified $F_5(W_0)=0$ in integers ($\tfrac32\cdot24^3=20736=9\cdot48^2$) so this witness is independent of every run on the record.
- **I checked the parity obstruction at $(1,0)$, the smallest nontrivial even block**, since a covariant forced to vanish identically would be a falsifier for free. It is not one: the constituent is $\mathbb R^5\otimes\det$ and $-I$ acts trivially on it (§9).
- **For the remaining fourteen even blocks I found no falsifier and can offer no closed-form test.** Deciding $\sigma_\mu(W_0)=0$ means constructing the highest-weight vector of $M_\mu\otimes V_\mu$ inside the $7770$-dimensional $\mathrm{Sym}^3\mathcal W_5$ and evaluating it, the check [sym3-blocks.md:122](../findings/sym3-blocks.md) proposes and records as never run. **That is computation, this task carries no approval for it, and I ran nothing.** Recorded as the run that would retire L87's dependence on a machine number: evaluating the $41$ highest-weight vectors at a handful of points $g\cdot W_0$ settles all sixteen at once and needs only the inner product on $\mathcal W_5$ in the weight basis. All sixteen nonzero would make the rank-one step a theorem with no measurement in it; any one vanishing refutes L87.
