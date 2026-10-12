# Review r557, Lemma L44 ($n\ge12$ is necessary, not merely sufficient)

Reviewer r557, independent adversarial audit. Brief: audit Lemma L44 in [findings/problem.md](../findings/problem.md) from the definitions alone. Analysis-only footing: no computation beyond screening a claim about to be recorded, and any screen is reported as a screen.

Status: **complete**, overall verdict REPAIRED. The conclusion holds and was rebuilt from the definitions; four defects listed at the foot, one of them a false sentence in the canonical block.

## Verdicts

### 1. The claim, restated from the definitions

[findings/problem.md:194](../findings/problem.md#L194) is the canonical block. Its whole content is one sentence and a $\square$:

> Placing the problem inside Böhm–Wilking's cone formulation, the zero-padded $W_{\mathbb{CP}^2}$ keeps $\theta=\sqrt{3/2}$ at every $n$ and lies on $\partial\Omega_0$, so the invariance criterion fails there exactly when $\theta_0(n)<\sqrt{3/2}$, i.e. $n^2-12n+8<0$. Hence $\Omega_0$ is **provably non-invariant for $4\le n\le11$**.

The pieces, each traced to a definition rather than to the block:

| piece | where it is fixed | status |
| --- | --- | --- |
| $\Omega_0=\{\operatorname{scal}(R)>0\}\cap\{\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2\}$ | [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md), quoted at [problem.md:44](../findings/problem.md#L44) | as quoted |
| the criterion on the Einstein slice collapses to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ | [Lemma L43](../results.md), [problem.md:56](../findings/problem.md#L56) | rebuilt below |
| $c(n-1)=\theta_0(n)$ on $\partial\Omega_0$ | same | rebuilt below |
| $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$, padding-stable | [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md), [problem.md](../findings/problem.md) | rebuilt below, by structure constants |

### 2. VERDICT, the arithmetic: CONFIRMED

Rebuilt cold, without the block's numbers.

**The pinned $c$.** On $\partial\Omega_0$ with $R=cI+W$, $\lVert W\rVert=1$: $R_I=cI$, $R_W=W$, so $c^2\lVert I\rVert^2=\tfrac{n-2}n$. With $\lVert I\rVert^2=\dim\Lambda^2=\tfrac{n(n-1)}2$ this is $c^2=\tfrac{2(n-2)}{n^2(n-1)}$, whence

$$c(n-1)=\sqrt{\frac{2(n-1)^2(n-2)}{n^2(n-1)}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

**The polynomial.** $\theta_0(n)^2<\tfrac32\iff 4(n-1)(n-2)<3n^2\iff 4n^2-12n+8<3n^2\iff n^2-12n+8<0$, roots $6\pm2\sqrt7$, i.e. $0.7085\dots$ and $11.2915\dots$. So over integers $n\ge4$ the failure range is exactly $4\le n\le11$, and $n=12$ is the first integer clear of it ($144-144+8=8>0$; at $n=11$, $121-132+8=-3<0$). **The range as printed is right**, and matches [Lemma L2](../results.md)'s $6+2\sqrt7$ exactly.

### 3. VERDICT, the witness, $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ and its padding-stability: CONFIRMED, by a route sharing nothing with the block's

The block cites Nienhaus. I rebuilt it from $Q=W^2+W^\#$ and the $\mathfrak{so}(4)$ structure constants instead.

**The object.** $W=\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4$, supported on $\Lambda^+$ and trace-free there. Unit norm: $(1+1+4)/6=1$. It is a genuine Weyl operator: trace-free (so $\operatorname{scal}=0$), trace-free on each of $\Lambda^\pm$ separately (so $\operatorname{ric}=0$), and $\langle W,\star\rangle=\operatorname{tr}(W|_{\Lambda^+})-\operatorname{tr}(W|_{\Lambda^-})=0$, so the $\Lambda^4$ component vanishes and the first Bianchi identity holds.

**The structure constant.** With [conventions.md](../findings/conventions.md)'s pairing, $\varphi_{ab}=E_{ab}-E_{ba}$ is a unit bivector and $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$. Taking $\omega_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, $\omega_2=(\varphi_{13}-\varphi_{24})/\sqrt2$, $\omega_3=(\varphi_{14}+\varphi_{23})/\sqrt2$ as the orthonormal basis of $\Lambda^+$, the four brackets give $[\omega_1,\omega_2]=-\tfrac12\big(2\varphi_{23}+2\varphi_{14}\big)=-\sqrt2\,\omega_3$. So $c_{123}^2=2$.

**Hence $W^\#$ and $\theta$.** For $W$ diagonal in $\{\omega_i\}$ and zero on $\Lambda^-$, $W^\#_{11}=\tfrac12\sum_{\gamma\delta}c_{1\gamma\delta}^2w_\gamma w_\delta=\tfrac12\cdot2\cdot c_{123}^2\,w_2w_3=2w_2w_3$, cyclically. With $(w_1,w_2,w_3)=(-1,-1,2)/\sqrt6$: $W^2=(1,1,4)/6$ and $W^\#=2(-2,-2,1)/6$, so $Q(W)=(-3,-3,6)/6=(-\tfrac12,-\tfrac12,1)$. Against $\sqrt{3/2}\,W=\tfrac{\sqrt3}{\sqrt2\sqrt6}(-1,-1,2)=\tfrac12(-1,-1,2)$, **identical**. So $Q(W)=\sqrt{3/2}\,W$, $W$ is critical, and $P(W)=\theta\lVert W\rVert^2=\sqrt{3/2}$.

**Padding.** $[\mathfrak{so}(4),\mathfrak{so}(4)]\subseteq\mathfrak{so}(4)$, so for $W$ supported on $\Lambda^2\mathbb R^4\subset\Lambda^2\mathbb R^n$ every term of $W^\#_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$ needs $\gamma,\delta,\varepsilon,\zeta\in\mathfrak{so}(4)$ and hence $\alpha,\beta\in\mathfrak{so}(4)$. So $W^\#$, $W^2$, the norm and $\theta$ are all unchanged by the padding, which is [conventions.md](../findings/conventions.md)'s "padding commutes with $Q$" specialised. And the padded operator is still Ricci-flat, so it is still Weyl in $\mathbb R^n$. **The witness holds at every $n\ge4$.**

### 4. VERDICT, "lies on $\partial\Omega_0$": REFUTED as written, REPAIRABLE in four words

**$W_{\mathbb{CP}^2}$ does not lie on $\partial\Omega_0$, and does not lie in the closure of $\Omega_0$ at all.** $\Omega_0$ carries $\operatorname{scal}(R)>0$; a Weyl operator has $\operatorname{scal}=0$. Worse, the boundary equation at $R=W$ reads $\tfrac{n-2}n\cdot1=\lVert R_I\rVert^2=0$, false at every $n\ge3$. Nor is it a limit point: a point of $\partial\Omega_0$ with $\lVert R_I\rVert\to0$ has $\lVert R_W\rVert\to0$ with it, so no unit-norm Weyl operator is in $\overline{\Omega_0}$.

The point that is on $\partial\Omega_0$ is $R=cI+W_{\mathbb{CP}^2}$ at the single pinned $c=\tfrac1n\sqrt{\tfrac{2(n-2)}{n-1}}>0$, which has $R_{\mathrm{ric}_0}=0$ (Ricci-flat $W$, and $I$ contributes only trace) and $\operatorname{scal}=c\operatorname{scal}(I)>0$. **[results.md:282](../results.md#L282) states it correctly**, "the curvature operator $cI+W$ it defines lies on $\partial\Omega_0$". The canonical block, [problem.md:66](../findings/problem.md#L66), [results.md:102](../results.md#L102) and [report/sections/05-landscape.tex:72](../report/sections/05-landscape.tex#L72) all carry the elided form.

This is not pedantry against the record's own standards: [r90](REVIEW_r90.md) already corrected exactly this sentence-shape in [the Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md), *"A pure Weyl operator has $\operatorname{scal}=0$, so it lies outside $\operatorname{scal}^+=\operatorname{dom}(F)$ and is not a point of any $\Omega_a$."* The canonical block reintroduces the error that review removed elsewhere.

**Repair:** replace "the zero-padded $W_{\mathbb{CP}^2}$ ... lies on $\partial\Omega_0$" with "the curvature operator $cI+W_{\mathbb{CP}^2}$ lies on $\partial\Omega_0$ at the pinned $c=\theta_0(n)/(n-1)$". The conclusion is untouched.

### 5. VERDICT, the cone criterion, rebuilt cold: CONFIRMED, and it has no parity in it

The block leans on [Lemma L43](../results.md) without restating it. Rebuilt here from the definitions:

$F=\lVert R\rVert^2/\lVert\operatorname{ric}R\rVert^2$ gives $dF_R(S)=\tfrac2{\lVert\operatorname{ric}R\rVert^2}\big(\langle R,S\rangle-F(R)\langle\operatorname{ric}R,\operatorname{ric}S\rangle\big)$, so $G(R):=dF_R(\Phi(R))\le0\iff\langle R,\Phi(R)\rangle\le F(R)\langle\operatorname{ric}R,\operatorname{ric}\Phi(R)\rangle$.

At $R=cI+W$ with $W$ unit Weyl: $\Phi(cI,W)=c(W+I\#W)=0$ by [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.1, so $\Phi(R)=c^2(n-1)I+Q(W)$. Then $\langle W,I\rangle=0$ and $\operatorname{tr}Q(W)=0$ (Hamilton's $\operatorname{scal}(Q(R))=2\lVert\operatorname{ric}R\rVert^2$), giving

$$\text{LHS}=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle,\qquad \text{RHS}=\frac{c^2\lVert I\rVert^2+1}{c^2\lVert\operatorname{ric}I\rVert^2}\cdot c^3(n-1)\lVert\operatorname{ric}I\rVert^2=c(n-1)\big(c^2\lVert I\rVert^2+1\big),$$

so $G\le0\iff\langle W,Q(W)\rangle\le c(n-1)$. **Exact, no residue, and $\lVert\operatorname{ric}I\rVert^2$ never needed a value.** I also checked the two cone forms agree: $\tfrac{n-2}4\lVert R\rVert^2\le\lVert\operatorname{ric}R\rVert^2$ with $\lVert\operatorname{ric}R\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$ rearranges to $\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$ identically; and $F(I)=2/(n-1)$ matches the $a=n/4$ threshold $4/(n-2+n)$, so $\lVert I\rVert^2=\binom n2$ is the right normalisation on both sides.

**Answering the brief's item (1).** The constant the criterion compares against is $c(n-1)=\theta_0(n)$, and it comes from $\lVert I\rVert^2=\tfrac{n(n-1)}2$ and the boundary equation, **algebraic in $n$, with no parity anywhere**. $\Theta_n$ is the *diagonal* maximum ([conventions.md](../findings/conventions.md), warning [W5](../findings/INDEX-traps.md)) and plays no role in this lemma. So **$n^2-12n+8$ is the correct and only polynomial for the block's own (cone) statement at both parities**, and the brief's suspected parity defect is not a defect of L44 as written. The odd-$n$ polynomial $n^2-13n+18$ belongs to a different comparison, and [Lemma L2](../results.md) already records it.

### 6. VERDICT, "exactly when", and what the block does with it: CONFIRMED, with a wording defect in the heading

**The biconditional is legitimate and fully proved.** "Fails *there*" scopes to the one point $R=cI+W_{\mathbb{CP}^2}$, and at that point the collapse of §5 is an *equivalence*: $G(R)>0\iff\sqrt{3/2}>\theta_0(n)$. No statement about the rest of $\partial\Omega_0$ is made or needed.

**The step the block does not state, and it is needed.** From "$G(R)>0$ at one $R\in\partial\Omega_0$" to "$\Omega_0$ is non-invariant" requires the *necessity* direction, whereas [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4 supplies only sufficiency. It does hold, in two lines: $\Omega_0=\{F\le\tfrac4{n-2}\}\cap\{\operatorname{scal}>0\}$, $F$ is smooth at $R$ since $\operatorname{scal}(R)>0$, and $\tfrac d{dt}F(R(t))\big|_0=G(R)>0$ puts the solution outside $\{F\le\tfrac4{n-2}\}$ immediately. **[problem.md:86](../findings/problem.md#L86) records that this direction is owed; the canonical block records neither the gap nor its closure.** Repair: one clause, or a pointer to that line. (I note in passing that [r91](REVIEW_r91.md) reached for Beitz Lemma 6.3.12, $dF_R\ne0$, to license this, it is not needed, since $G(R)>0$ already forces $dF_R\ne0$.)

**The heading presupposes what the programme has not got.** *"$n\ge12$ is necessary, not merely sufficient"* reads, on the surface, as though sufficiency were established, which is the open conjecture itself. [results.md:284](../results.md#L284) carries the guard the canonical block lacks: *"It says nothing about whether the cone is invariant at $n\ge12$, which is the conjecture itself."* **Defect: verbal, in the most-cited string of the lemma.** A truthful heading is "$n\ge12$ is forced: $\Omega_0$ is non-invariant below it".

### 7. VERDICT, necessary for the problem, or for the method: REPAIRED, both are true, and the block takes the long road to the weaker one

Brief item (3). Two readings, and they are different statements.

| reading | what is proved | what it needs |
| --- | --- | --- |
| **method / cone**, Beitz Remark 6.3.15's conjecture, *"for $n\ge12$ the cones $\Omega_a$ are invariant"* | $\Omega_0$ is non-invariant for $4\le n\le11$, so the $n\ge12$ in that conjecture is forced at the $a=0$ end | the whole L43 apparatus |
| **problem**, this repository's Goal, *"$P$ on the unit sphere is maximised on sphere products when $n\ge12$"* | that conclusion is **false** for $4\le n\le11$ | one comparison of two numbers |

**The elementary route, which the block does not take.** The maximum of $\theta$ over sphere products $S^p\times S^q$, $p+q=n$, is $\theta(p,q)^2=\tfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ maximised at the balanced split: $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$ at even $n$, and $\tfrac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$. Padded $W_{\mathbb{CP}^2}$ is a unit Weyl operator with $\theta=\sqrt{3/2}$ at every $n\ge4$ (§3). Comparing:

- even $n$: $\theta_0(n)^2<\tfrac32\iff n^2-12n+8<0\iff 4\le n\le11$;
- odd $n$: $\tfrac{2(n-1)(n-3)}{(n-2)(n+1)}<\tfrac32\iff n^2-13n+18<0\iff n\le11$ (upper root $\tfrac{13+\sqrt{97}}2=11.4244$).

So at every $4\le n\le11$ a non-sphere-product beats every sphere product, and at $n=12,13$ it no longer does ($\tfrac{220}{144}$ and $\tfrac{240}{154}$, both $>\tfrac32$). **Necessity for the problem is one line and uses no cone theory at all.**

**Where the parity does bite.** It bites *here*, not in the block: this elementary route needs both polynomials, and the block prints only $n^2-12n+8$. The integer threshold $12$ is unchanged, so nothing downstream moves, but a reader taking the block's polynomial as the problem-level criterion is applying the even-$n$ formula at odd $n$. [Lemma L2](../results.md) already carries the correction; **L44 should cite it rather than reprint the even-$n$ form alone.**

**Is the cone framing carrying weight?** For the *problem* reading, none. For the *method* reading, real weight: [Beitz's own notes](../references/beitz-2018-bianchi-convexity/notes.md) end *"Whatever forces $n\ge12$ lives elsewhere"*, and this locates it at the $a=0$ end. **The lemma is sound; its heading advertises the elementary consequence and its proof establishes the cone one.**

### 8. Attribution, CONFIRMED verbatim against the stored sources

The brief's item (6). [Beitz's notes](../references/beitz-2018-bianchi-convexity/notes.md) do not carry the equation numbers, so I checked the stored thesis text directly.

| block's claim | what the source says | verdict |
| --- | --- | --- |
| Beitz (6.24) defines $F=\lVert R\rVert^2/\lVert\operatorname{ric}R\rVert^2$ | (6.24) on p. 97: *"$F:\mathrm{scal}^+\to\mathbb R:R\mapsto\frac{\lVert R\rVert^2}{\lVert\mathrm{ric}(R)\rVert^2}$"* | holds |
| Beitz (6.25) gives $dF_R(S)$ | (6.25): $dF_R(S)=\tfrac2{\lVert\mathrm{ric}R\rVert^2}\big(\langle R,S\rangle-F(R)\langle\mathrm{ric}R,\mathrm{ric}S\rangle\big)$, then re-expanded via (1.6) | holds, and it is the form §5 uses |
| Beitz Lemma 6.3.16 for the criterion $dF_R(\Phi(R))\le0$ | its proof opens *"we consider the function $G:\mathrm{scal}^+\to\mathbb R:R\mapsto dF_R(\Phi(R))$"* | holds, though 6.3.16 is the $a\to n/4$ **endpoint** result, and the invariance *criterion* itself is her Lemma 2.3.4 |
| Xu (3.1)–(3.4) | (3.1) is $dF_R(S)$, (3.2) is $dF_R(Q(R))$, (3.3) is $dF_R(Q(R))\le0\ \forall R\in\partial\Omega(a)$, and (3.4) is introduced with *"the main task"* | holds verbatim |
| the five-term expansion is Huisken's, via Xu Lemma 2.8 | Xu's (2.34); [the Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) record Lemma 2.8 as *"Huisken's identity, reproduced because it is not an independent lemma in [16]"* | holds, **but L44's argument never forms that expansion**; it belongs to [Lemma L45](../results.md), and crediting it here overstates what this block imports |

One convention hazard, checked and harmless here: Xu's $\mathrm{Ric}$ is twice Beitz's $\mathrm{ric}$, so Xu's threshold reads $\tfrac1{n-2+4a}$ against Beitz's $\tfrac4{n-2+4a}$. It cancels in $F\langle\mathrm{ric},\mathrm{ric}\,\Phi\rangle$, and the record already flags it at [problem.md:92](../findings/problem.md#L92).

### 9. Quantifier, exceptional cases, and the norm

- **"at every $n$" should be "at every $n\ge4$".** $\mathcal W_3=0$ by $\dim\mathcal W_n=\tfrac{n(n-3)(n+1)(n+2)}{12}$, so there is no witness and no padding below $n=4$. The *conclusion* prints the range correctly as $4\le n\le11$, and the lower root $6-2\sqrt7=0.7085$ is below every admissible $n$, so nothing is lost, only the statement is loose.
- **The norm is [conventions.md](../findings/conventions.md)'s.** $\lVert W_{\mathbb{CP}^2}\rVert^2=(1+1+4)/6=1$ under plain Frobenius on $\Lambda^2$, which is the pairing in which $\lVert I\rVert^2=\dim\Lambda^2=\binom n2$, the same one the boundary equation is evaluated in. Both sides of the comparison are in one normalisation, so the $\sqrt2$ trap the conventions file records does not fire. Cross-check: Beitz's own $F(I)=\tfrac2{n-1}$ needs exactly $\lVert I\rVert^2=\tfrac{n(n-1)}2$, so the source agrees with the record here.
- **Consumers, checked against the hypotheses.** [results.md:37](../results.md#L37), [results.md:280](../results.md#L280), [report/sections/01-introduction.tex:49](../report/sections/01-introduction.tex#L49), [report/sections/09-status.tex:68](../report/sections/09-status.tex#L68), [report/sections/05-landscape.tex:71](../report/sections/05-landscape.tex#L71), [r285](REVIEW_r285.md), [r484](REVIEW_r484.md), [ELIM-fenceposts.md](ELIM-fenceposts.md). **Every one states the conclusion as $\Omega_0$ non-invariance on $4\le n\le11$, which is inside the hypotheses.** No consumer reads necessity-for-the-method as necessity-for-the-problem in a place where it does work; [results.md:282](../results.md#L282) is the only one that asserts the problem-level reading, and there it is true for the independent reason set out in §7.
- **Two index defects, reported rather than fixed.** [INDEX-results.md:59](../findings/INDEX-results.md#L59) carries the row's short name truncated to *"$n\ge12$ is necessary, not merely sufficient) · (D"*, an unbalanced parenthesis from a generation pass, and row 47 has the same shape. And the row reads **"Gate 2: no verdict on the record"** while the kind column reads **Lemma**, which that file defines as *"proven, Gate 1 and Gate 2 passed"*. The audits that exist ([r90](REVIEW_r90.md), [r91](REVIEW_r91.md), [r92](REVIEW_r92.md)) predate the numbering and are not recorded against the number.

## Overall verdict, REPAIRED

**The mathematics of Lemma L44 stands.** Its conclusion, $\Omega_0$ is not invariant under the Hamilton ODE for $4\le n\le11$, witnessed by $cI+W_{\mathbb{CP}^2}$, is correct, and I rebuilt every step of it from the definitions: the witness's $\theta=\sqrt{3/2}$ and its criticality from the $\mathfrak{so}(4)$ structure constants (§3), the criterion's collapse and the pinning $c(n-1)=\theta_0(n)$ from the quotient rule and $\lVert I\rVert^2=\binom n2$ (§5), and the polynomial and its integer range from the two closed forms (§2). The attribution is verbatim in the stored sources (§8).

**Four defects, none touching the conclusion.**

| # | defect | severity | repair |
| --- | --- | --- | --- |
| 1 | *"the zero-padded $W_{\mathbb{CP}^2}$ ... lies on $\partial\Omega_0$"*, false: a Weyl operator has $\operatorname{scal}=0$ and lies outside $\overline{\Omega_0}$ entirely (§4) | statement false as printed; the record's own [r90](REVIEW_r90.md) corrected this sentence-shape elsewhere | name the point: "the curvature operator $cI+W_{\mathbb{CP}^2}$, at the pinned $c=\theta_0(n)/(n-1)$", in [problem.md:200](../findings/problem.md#L200), [problem.md:66](../findings/problem.md#L66), [results.md:102](../results.md#L102) and [05-landscape.tex:72](../report/sections/05-landscape.tex#L72) |
| 2 | the block never states that *invariance $\Rightarrow G\le0$* is the direction it needs, which Beitz's Lemma 2.3.4 does not supply (§6) | gap in a "canonical statement and proof" block | one clause: $F$ is smooth at $R$ and $\tfrac d{dt}F>0$ ejects the solution immediately; or cite [problem.md:86](../findings/problem.md#L86) |
| 3 | the heading *"necessary, not merely sufficient"* presupposes sufficiency, which is the open conjecture; and the block omits the guard [results.md:284](../results.md#L284) carries (§6) | verbal, in the string 24 consumers cite | rename, or carry the guard into the block |
| 4 | only the even-$n$ polynomial is printed, and the problem-level reading of the heading needs $n^2-13n+18$ at odd $n$ (§7) | benign, the integer threshold $12$ is the same at both parities | cite [Lemma L2](../results.md), which already records both roots |

**Two things the block claims that are wider than what it does.** It credits Huisken's five-term expansion, which its argument never forms (§8), and it routes a one-line elementary fact through the whole cone apparatus (§7). The elementary form (padded $W_{\mathbb{CP}^2}$ beats every sphere product at $4\le n\le11$, at both parities), is stronger for the repository's stated Goal and is not in the record as a statement of L44. **Recommendation: state both, and let the cone version be what it is, a result about Beitz's conjecture rather than about $P$.**

### Compute

**None.** Every number in this report was derived by hand from the definitions; the only files opened were the record's own and the two stored source texts, read with `grep`/`sed`. No screen was run, so nothing here rests on one.
