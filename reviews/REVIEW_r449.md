# Review r449, adversarial audit of [Lemma L146](../findings/second-order.md), the operator norm on the margin summand

*Reviewer r449, 2026-09-03, cold adversarial brief. Target: [Lemma L146](../findings/second-order.md) and the decision it claims to make between [r446](REVIEW_r446.md) and [r447](REVIEW_r447.md). Read in full: [Lemma L146](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md), [conventions.md](../findings/conventions.md), [REVIEW_r446.md](REVIEW_r446.md), [REVIEW_r447.md](REVIEW_r447.md). **Analysis only** ([analysis-only.md](../.claude/rules/analysis-only.md)), every result below is derived by hand; two numeric screens on self-constructed objects are reported as screens and are evidence for nothing. Working: [agent_logs/r449-L146.log](../agent_logs/r449-L146.log).*

## Verdict

| # | claim | verdict |
|---|---|---|
| 1 | $h\in S^2_0(\mathbb R^m)$ enters as the Weyl image of $h\owedge g_q$, **diagonal on coordinate $2$-planes** | **CONFIRMED**, diagonality survives the Weyl projection (V1) |
| 2 | the eigenvalue is $h_a$ on mixed planes and **zero on planes inside either block** | **REFUTED.** The Ricci projection term survives: mixed planes carry $\tfrac{m-2}{2(m-1)}h_a$, and planes inside the **first** block carry $-\tfrac{m}{2(m-1)}(h_a+h_b)\ne0$ (V1) |
| 3 | $\lVert H\rVert_{op}=\max_a\lvert h_a\rvert$ | **REFUTED.** $\lVert H\rVert_{op}=\tfrac m{2(m-1)}\max_{a\ne b}\lvert h_a+h_b\rvert$, the in-block branch winning at every $m$ (V2) |
| 4 | $\lVert H\rVert_F^2\propto m\lVert h\rVert^2$, used with implicit constant $1$ | **REFUTED as used.** $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$; the constant is $\to\tfrac12$, not $1$ (V2) |
| 5 | $\lVert H\rVert_{op}\le\sqrt{m-1}/m$ at $\lVert H\rVert_F=1$ | **REFUTED.** The true maximum is $1/\sqrt{m-1}$, larger by $m/(m-1)$ (V3) |
| 6 | $\lVert H\rVert_{op}\ge1/m$, "attained at the even split $h_a=\pm1/\sqrt m$" | **PLAUSIBLE as an inequality, REFUTED as stated.** $1/m$ holds at every $m$ screened but is not the minimum and is attained nowhere; the true minimum is $\approx\sqrt2/m$ (V3) |
| 7 | $L_e$ is a scalar on $S^2_0(\mathbb R^m)$, so the margin is constant across the summand, and it is L145's margin | **CONFIRMED**, and sharply: $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)=c_p$ **identically** (V4) |
| 8 | $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$, so the disc is $\Omega(n^{-1/2})$, a factor $\sqrt n$ | **CONFIRMED at the level of orders**, and it survives the corrected embedding intact (V3) |
| 9 | "r447 is right that they do not move the answer; an infimum is set by the worst direction" | **REFUTED as reasoning.** It answers an argument [r446](REVIEW_r446.md) did not make, and the lemma's own computation refutes [r447](REVIEW_r447.md)'s ceiling (V5) |
| 10 | the infimum over $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ is attained on $S^2_0(\mathbb R^m)$ | **PLAUSIBLE, unargued.** I can close the summand-by-summand half of it; the mixed directions are unpriced (V6) |
| 11 | the closing screen | **VACUOUS**, and it misreports its own target (V7) |

**The one-line verdict: the conclusion survives and the derivation does not.** Every structural statement L146 makes about the element $H$ is wrong, and the order-level conclusion, worst-case $\lVert H\rVert_{op}=\Theta(n^{-1/2})$, disc $\Omega(n^{-1/2})$, a factor $\sqrt n$ over the direction-blind radius, is nevertheless correct, because the two errors move the numerator and the denominator of $\lVert H\rVert_{op}/\lVert H\rVert_F$ by the same order. **The lemma should be rewritten, not withdrawn.**

**The finding that changes what the record says is V5.** L146's arithmetic, corrected, gives $\lVert A''\rVert=O(1)$ on the very directions where the margin is $c_p$, which is exactly the input [r447](REVIEW_r447.md) names as the one thing a successor would have to break. So L146 **confirms** [r446](REVIEW_r446.md)'s D6 and **refutes** [r447](REVIEW_r447.md)'s strengthening, where its own box says the opposite.

---

## V1, the embedding: diagonality survives, the eigenvalues do not, and the in-block block is not zero

The record's Weyl projector is fixed in [nondegeneracy.md](../findings/nondegeneracy.md) line 375: $P(X)=Y-\tfrac2{n-2}\mathrm{KN}(\rho_0)-\tfrac1{n(n-1)}s\,\mathrm{KN}(g)$ with $\mathrm{KN}(h)=\tfrac12(h\owedge g)$, i.e. the classical

$$R=W+\tfrac1{n-2}\Big(\mathrm{Ric}-\tfrac{s}{n}g\Big)\owedge g+\tfrac{s}{2n(n-1)}\,g\owedge g,\qquad (h\owedge k)_{ijkl}=h_{ik}k_{jl}+h_{jl}k_{ik}-h_{il}k_{jk}-h_{jk}k_{il}.$$

**The projection term does not vanish.** Contracting the Kulkarni–Nomizu product gives $\mathrm{Ric}(h\owedge k)=(\mathop{\mathrm{tr}}h)k+(\mathop{\mathrm{tr}}k)h-hk-kh$. With $h\in S^2_0(\mathbb R^m)$ supported on the first block $B_1$ and $k=g_q$ the metric of the second block $B_2$: $\mathop{\mathrm{tr}}h=0$, $\mathop{\mathrm{tr}}g_q=m$, and $hg_q=g_qh=0$ by disjoint support. Hence

$$\mathrm{Ric}(h\owedge g_q)=m\,h\ \ne\ 0,\qquad s=0 .$$

So $h\owedge g_q$ is **not** a Weyl tensor, and the Weyl image is

$$\boxed{\ H=(1-c)\,h\owedge g_p^{\,\perp}-c\,h\owedge g_p,\qquad c=\frac{m}{n-2}=\frac{m}{2(m-1)},\qquad 1-c=\frac{m-2}{2(m-1)}\ }$$

writing $g_p$ for the first block's metric and $g_p^\perp=g_q$ for the second's. **Diagonality survives**, both $h\owedge g_q$ and $h\owedge g_p$ are diagonal in the coordinate $2$-plane basis of a frame diagonalising $h$, with $(h\owedge g_q)$ carrying $h_a$ on $e_a\wedge e_b$, $a\in B_1$, $b\in B_2$, and $(h\owedge g_p)$ carrying $h_a+h_b$ on $e_a\wedge e_b$, $a,b\in B_1$. **The eigenvalues do not**:

| plane | L146 | truth |
|---|---|---|
| $a\in B_1$, $b\in B_2$ | $h_a$ | $\dfrac{m-2}{2(m-1)}\,h_a$ |
| $a,b\in B_1$ | $0$ | $-\dfrac{m}{2(m-1)}\,(h_a+h_b)$ |
| $a,b\in B_2$ | $0$ | $0$ |

Two consistency checks the corrected form passes and the lemma's does not. **Ricci-flatness**: $\mathrm{Ric}(h\owedge g)=(n-2)h$, so $\mathrm{Ric}(H)=mh-\tfrac{m}{n-2}(n-2)h=0$; the lemma's $H$ has $\mathrm{Ric}=mh\ne0$ and is therefore not in $\mathrm{Weyl}_n$ at all. **Vanishing $\Lambda^2$ trace**: $m(1-c)\sum_ah_a-c\sum_{a<b}(h_a+h_b)=0-c(m-1)\sum_ah_a=0$.

*Screen (self-constructed $4$-tensors at $m=3,4,5,6,8$, seconds, evidence for nothing): $\mathrm{Ric}(H)$ vanishes to $4\times10^{-16}$, the first Bianchi identity holds exactly, the $\Lambda^2$ operator matrix is exactly diagonal in the coordinate-plane basis, and the two closed forms below reproduce $\lVert H\rVert_F$ and $\lVert H\rVert_{op}$ to machine precision.*

**A curiosity worth one line, since a successor will notice it.** $1-c=(m-2)/(2(m-1))=\lambda_m$, the [Lemma L27](../findings/nondegeneracy.md) eigenvalue of $L_e$ on this very summand. It is the same rational function appearing twice and carries no content here.

**Degenerate ends.** At $m=2$ the whole summand dies: $c=1$, and $h\owedge g_p$ has eigenvalue $h_1+h_2=0$, so $H=0$, the $S^2_0$ part of $h\owedge g_q$ is pure Ricci at $n=4$. [Lemma L27](../findings/nondegeneracy.md) in any case needs $p,q\ge3$ with $(p,q)\ne(3,3)$, which at $p=q=m$ is $m\ge4$; **L146 states no hypothesis on $m$ and inherits one.**

## V2, the norms, and the convention question falls the safe way

The ratio $\lVert H\rVert_{op}/\lVert H\rVert_F$ is convention-independent here, and the brief's $\sqrt2$ trap is not sprung, for a reason worth stating: **both norms are read off the same object**, the diagonal of the $\Lambda^2$ operator in the coordinate-plane basis. [conventions.md](../findings/conventions.md) puts the $\tfrac12$ at the $\Lambda^2$ level, making $e_a\wedge e_b$ unit and $\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2$ a sum over **unordered** planes, once each. Any rescaling of the basis rescales both norms alike. The place a $\sqrt2$ could enter, counting ordered pairs in $\lVert H\rVert_F$ while taking $\max$ over unordered ones in $\lVert H\rVert_{op}$, is not entered by either the lemma or this audit.

**Frobenius.** At $\lVert h\rVert^2=\sum_ah_a^2=1$, the mixed planes contribute $m(1-c)^2$ and the $B_1$ planes contribute $c^2\sum_{a<b}(h_a+h_b)^2=c^2(m-2)$, using $\sum_{a\ne b}h_ah_b=(\sum h)^2-\sum h^2=-1$. Hence

$$\lVert H\rVert_F^2=m(1-c)^2+(m-2)c^2=\frac{m(m-2)^2+m^2(m-2)}{4(m-1)^2}=\frac{m(m-2)}{2(m-1)}\ \lVert h\rVert^2 .$$

So the lemma's $\propto m$ is right in order and its implicit constant is wrong by $\tfrac{m-2}{2(m-1)}\to\tfrac12$, the proof's step "dividing by $\sqrt m$" uses $\lVert H\rVert_F=\sqrt m\,\lVert h\rVert$, which is the naive $h\owedge g_q$ answer and is out by $\sqrt2$ asymptotically.

**Operator.** $\lVert H\rVert_{op}=\max\{(1-c)\max_a\lvert h_a\rvert,\ c\max_{a\ne b}\lvert h_a+h_b\rvert\}$, and **the second branch always wins**. Let $h_a$ be of largest modulus, say $h_a>0$. Since $\sum_{b\ne a}h_b=-h_a$, some $b\ne a$ has $h_b\ge-h_a/(m-1)$, so $\max_{a\ne b}\lvert h_a+h_b\rvert\ge\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert$; and $c\cdot\tfrac{m-2}{m-1}=\tfrac{m(m-2)}{2(m-1)^2}>\tfrac{(m-1)(m-2)}{2(m-1)^2}=1-c$. Hence

$$\lVert H\rVert_{op}=\frac{m}{2(m-1)}\ \max_{a\ne b}\lvert h_a+h_b\rvert .$$

**This is the load-bearing correction.** The quantity that controls the analyticity disc is a maximum over *pairs*, on planes L146 believes carry nothing.

## V3, the extremal problem: the lemma solves the wrong one, and the parity is in a different place

L146's extremal problem ($\max_a\lvert h_a\rvert$ over $\sum h_a=0$, $\sum h_a^2=1$), is correctly solved as stated at the maximum: $\sqrt{(m-1)/m}$, at one entry against $m-1$ equal ones. Its minimum claim carries the parity defect the brief predicts, but in a statement that does not matter: $\min\max_a\lvert h_a\rvert$ is $1/\sqrt m$ for even $m$ and $1/\sqrt{m-1}$ for odd $m$ (put $(m-1)/2$ entries at each of $\pm t$ and one at $0$; the vertex enumeration below confirms no better configuration). **Both are irrelevant, because by V2 the operator norm is governed by $\max_{a\ne b}\lvert h_a+h_b\rvert$.**

The right extremal problem, at $\lVert H\rVert_F=1$:

- **Maximum.** $\max_{a\ne b}(h_a+h_b)$ over $\{\sum h=0,\sum h^2=1\}$ is the norm of $e_a+e_b$ projected off $\mathbf 1$, namely $\sqrt{2-4/m}$. Then $$\lVert H\rVert_{op}^{\max}=\frac{m}{2(m-1)}\sqrt{\frac{2(m-2)}{m}}\Big/\sqrt{\frac{m(m-2)}{2(m-1)}}=\frac1{\sqrt{m-1}} .$$ **L146's upper bound $\sqrt{m-1}/m$ is FALSE**, being smaller by $m/(m-1)$: at $m=3$ the true maximum is $0.7071$ against a claimed $0.4714$, at $m=20$ it is $0.22942$ against $0.21794$. The two agree to leading order, which is why the conclusion survives.
- **Minimum.** Writing $V_m=\max\{\sum h^2:\sum h=0,\ \lvert h_a+h_b\rvert\le1\}$ (a convex maximum over a polytope, so attained at a vertex), the minimum is $\tfrac{m}{2(m-1)}V_m^{-1/2}/\lVert H\rVert_F$. The competing vertices are $(1,0,\dots,0,-1)$ with $V=2$; the balanced split at $\pm\tfrac12$ with $V=m/4$ for even $m$ and $(m-1)/4$ for odd $m$ (the parity, relocated); and the concentrated $\big(\tfrac{m-1}{m-2},-\tfrac1{m-2},\dots\big)$ with $V=\tfrac{m(m-1)}{(m-2)^2}$. Asymptotically $V_m=m/4$ or $(m-1)/4$ and $$\lVert H\rVert_{op}^{\min}\longrightarrow\sqrt{\frac{2}{(m-1)(m-2)}}\ \approx\ \frac{\sqrt2}{m}.$$

*Screen (LP vertex enumeration for $V_m$, self-constructed, seconds, evidence for nothing): $\lVert H\rVert_{op}^{\min}$ runs $0.612,\,0.333,\,0.306,\,0.274,\,0.242,\,0.218,\,0.200,\,0.167,\,0.135,\,0.0765,\,0.0743$ at $m=3,\dots,10,12,20,21$, against $1/m=0.333,\dots,0.0476$; $\lVert H\rVert_{op}^{\max}=1/\sqrt{m-1}$ reproduces at every $m$ to machine precision.*

**So the lower bound $1/m$ is true and unearned.** It holds at every $m$ screened, with slack running from $1.33$ at $m=3$ to $1.56$ at $m=21$ and $\sqrt2$ in the limit, but it is not the minimum, it is attained nowhere, and "attained at the even split $h_a=\pm1/\sqrt m$" is false: the even split gives $\tfrac{\sqrt m}{m-1}\big/\lVert H\rVert_F=\sqrt{2/((m-1)(m-2))}$, not $1/m$. **The lemma's displayed interval and the true interval are disjoint at $m=3$** ($[0.333,0.471]$ against $[0.612,0.707]$) and merely offset thereafter.

**What survives.** $\lVert H\rVert_{op}\in[\Theta(n^{-1}),\Theta(n^{-1/2})]$ at unit Frobenius norm, so the disc $g_n/\lVert H\rVert_{op}$ with $g_n=\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}$ is $\Omega(n^{-1/2})$ throughout the summand and $\Theta(1)$ at the best directions. **Claim 8 of the table is CONFIRMED**, on the corrected element, with the worst-case disc $g_n\sqrt{m-1}=\tfrac{m-1}{m}\sqrt{\tfrac1{2m-1}}\to(2n)^{-1/2}$.

## V4, the scalar claim and the margin identity: CONFIRMED, and tighter than the lemma states

[Lemma L27](../findings/nondegeneracy.md) gives the scalar action by Schur, the ten summands are pairwise inequivalent as $O(p)\times O(q)$-representations, $e$ is invariant, $L_e$ is symmetric, so no $\mathbb C$ or $\mathbb H$ case arises, with $\lambda_m=(m-2)/(2(m-1))$ on $S^2_0(\mathbb R^m)$. **The margin is therefore constant across the summand, as L146 says.**

**And it is the same quantity L145's chain takes an infimum of.** At $p=q=m$, $n-2=2(m-1)$, so

$$3\theta_0\Big(\tfrac12-\lambda_m\Big)=3\theta_0\cdot\frac1{2(m-1)}=\frac{3\theta_0}{n-2}=c_p,$$

**identically**, the [Lemma L141](../findings/second-order.md) margin that [r446](REVIEW_r446.md) D4 and [r447](REVIEW_r447.md) F2 both carry as $c_p=\Theta(1/n)$. This is the check the brief asks for and it passes exactly, not merely in order. The competing off-orbit eigenvalue is $\mu=1/(m-1)$ at $p=q=m$ (from L27's $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$), whose margin is $3\theta_0\frac{m-3}{2(m-1)}=\Theta(1)$; the remaining six summands carry margin $\Theta(1)$ too. So $S^2_0(\mathbb R^m)$ is the unique $\Theta(1/n)$-margin summand for $m\ge5$, ties with the tensor summand at $m=4$, and at $m=3$ is superseded by $\mu=\tfrac12$, the excluded degenerate case.

**A structural bonus the lemma does not claim and should.** $H$ is diagonal in the coordinate $2$-plane basis (V1), so it has **no entries on four distinct indices**, hence zero weight $v$ on [Lemma L133](../findings/second-order.md)'s $(2,2)$ blocks, hence $u=\lVert A'(0)[H]\rVert=0$ by the support table's $u^2\le\tfrac29v^2$. **This is what makes the summand the $u=0$ branch** of [r446](REVIEW_r446.md) D4 and [r447](REVIEW_r447.md) F2, asserted by both reviewers and proved by neither. It survives the corrected embedding because diagonality does.

## V5, THE FINDING: the infimum argument answers an argument nobody made, and the computation refutes the reviewer it credits

L146's second bullet reads: *"[r446](REVIEW_r446.md) is right that directions with a $\Theta(1)$ disc exist … [r447](REVIEW_r447.md) is right that they do not move the answer. A tube radius is an infimum over directions, and those directions have the largest local radius."*

**The sign question first, because it is the one thing here that is right.** A larger analyticity disc $\rho$ gives $\lVert A^{(k)}\rVert\le k!M/\rho^k$ with $M=O(g_n)$ unchanged, hence *smaller* derivative bounds, hence a *smaller* denominator in $c(H)/C(H)$, hence a *larger* local radius. Nothing enters with the opposite sign, and an infimum is indeed set by the worst direction. **CONFIRMED.**

**But that is not [r446](REVIEW_r446.md)'s claim.** [r446](REVIEW_r446.md) D6 does not say the best directions lift the infimum. It says the radius $g_n$ is used *blindly on every direction alike*, asks for $\lVert H\rVert_{op}$ **on the $S^2_0$ summand specifically** ("which is where $c_p$ is attained and where $u=0$") and states the consequence in one sentence: *"If it is $o(1)$ there, the exponent is not $-3/2$ and [I31](../plan.md) should be re-promoted."* The claim is about the **worst** directions, not the best. L146 refutes a claim of best-direction optimism that [r446](REVIEW_r446.md) explicitly declines to make ("I make no claim about which way it goes").

**And L146's own arithmetic answers [r446](REVIEW_r446.md)'s question in the affirmative.** On the summand, $\lVert H\rVert_{op}=O(n^{-1/2})=o(1)$, so $\rho=\Omega(n^{-1/2})$ and

$$\lVert A''\rVert\;=\;O(M/\rho^2)\;=\;O(g_n\cdot n)\;=\;O(1)\qquad\text{in place of }O(n).$$

That is precisely the input [r447](REVIEW_r447.md) F2 identifies as its own single point of failure: *"the exponent $-3/2$ is pinned by the pair $(c_p=\Theta(1/n),\ \lVert A''\rVert=O(n))$ and by nothing else"*, and *"what a successor would have to break to go past $n^{-3/2}$: the Cauchy bound $\lVert A''\rVert=O(n)$."* **L146 breaks it.** Re-running [r447](REVIEW_r447.md)'s own three branches on the summand with $\lVert A''\rVert=O(1)$:

| branch | at $\sup\lvert P\rvert=\Theta(\sqrt n)$ | at $\sup\lvert P\rvert=O(1)$ ([I31](../plan.md)) |
|---|---|---|
| $P$-side, $u=0$: $c_p/\sup\lvert P\rvert$ | $\Theta(n^{-3/2})$ | $\Theta(n^{-1})$ |
| defect cubic: $(c_p+u^2)/(\sup\lvert P\rvert+u)$ | $\Theta(n^{-3/2})$ | $\Theta(n^{-1})$ |
| defect quartic: $\sqrt{c_p}/\lVert A''\rVert$ | $\Theta(n^{-1/2})$ (stops binding | $\Theta(n^{-1/2})$), stops binding |

So the correct reading is: **[r447](REVIEW_r447.md)'s bottom line survives and [r447](REVIEW_r447.md)'s strengthening does not.** The exponent is still $-3/2$ *at the present* $\sup\lvert P\rvert=\Theta(\sqrt n)$, but it is no longer pinned "unconditionally on $\sup\lvert P\rvert$", and [I31](../plan.md) now buys an exponent rather than a constant, [r446](REVIEW_r446.md) D6's conclusion, reached by L146's own numbers and reported by L146 as the opposite. **The verdict line "decides the disagreement, and against both readings" is a misassignment**, and it is the most consequential thing in the entry, because [plan.md](../plan.md) demotes [I31](../plan.md) on the strength of the claim L146 credits.

L146's third bullet already contains the refutation of its second: if *every* direction in the summand has a disc $\Omega(n^{-1/2})$, then the infimum **over the summand** improves, and the good directions were never the point. The lemma's own closing sentence ("the exponent below is a lower bound that has room in it"), is [r446](REVIEW_r446.md)'s position, stated three lines after [r446](REVIEW_r446.md) is ruled against.

**A consequential collision this creates with the entry above it.** [Lemma L145](../findings/second-order.md)'s step 4 reads "$r_n=\Omega(n^{-3/2})$, **CONFIRMED**, and it is an equality", and [r447](REVIEW_r447.md) F2 supplies that equality. L146 removes its only support and says so. **The two adjacent entries now assert incompatible things about the same number**, and neither is struck.

## V6, is the binding direction even in this summand? Half-closed, and the lemma closes neither half

L146 assumes $\inf_H c(H)/C(H)$ over all of $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ is attained on $S^2_0(\mathbb R^m)$. It argues only that the **margin** is smallest there, which is a different statement, since $C(H)$ varies over directions too, that being the lemma's own subject.

**The summand-by-summand half closes, and favourably.** By V4, $S^2_0(\mathbb R^m)$ is the only one of [Lemma L27](../findings/nondegeneracy.md)'s ten with margin $\Theta(1/n)$; the other seven off-orbit summands carry $\Theta(1)$. A direction in one of those, even at the worst possible $\lVert H\rVert_{op}=\Theta(1)$, attainable, since a low-rank Weyl tensor on $\mathbb R^m$ padded into $\mathrm{Weyl}_p$ has $\lVert\cdot\rVert_{op}/\lVert\cdot\rVert_F=\Theta(1)$, gives $\rho=\Theta(g_n)$, $\lVert A''\rVert=O(n)$ and a quartic branch $\sqrt{\Theta(1)}/n=\Theta(n^{-1})$, above $n^{-3/2}$. **So the finding is not vacuous: no other single summand undercuts the summand L146 prices.**

**The mixed half does not close, and the lemma does not touch it.** Write $w$ for the weight of a unit $H$ outside $S^2_0$. Then $c(H)\asymp c_p+w^2$ and $\lVert H\rVert_{op}\asymp\max(n^{-1/2},w)$, so $\lVert A''\rVert\asymp\max(n^{-1/2},w)^2\,n$. Sweeping $w$ through $[0,1]$, the cubic branch $(c_p+w^2)/(\sup\lvert P\rvert+\lVert A''\rVert w)$ is minimised at $w=0$ at either value of $\sup\lvert P\rvert$, and the quartic branch $\sqrt{c(H)}/\lVert A''\rVert\asymp1/(wn)$ is minimised at $w=1$ giving $\Theta(n^{-1})$. **The infimum is at $w=0$, on the summand**, which is what L146 needs. I record this as **PLAUSIBLE rather than CONFIRMED** because $c(H)\asymp c_p+w^2$ and $\lVert H\rVert_{op}\asymp\max(n^{-1/2},w)$ are interpolations I have not proved, only the endpoints being established; and because $\lVert A''\rVert$ is being tracked through an upper bound, so a direction on which Cauchy is not saturated is invisible to the sweep in either direction. **The lemma should carry this sweep, or say plainly that it prices one summand.**

## V7, the screen is circular

L146 closes with: *"The screen: $\max\lVert H\rVert_{op}/g_n$ at $m=6,10,20,50,200$ returns $3.32,4.36,6.25,9.95,19.98$, matching $\sqrt2\sqrt m$."*

$$\frac{\sqrt{m-1}/m}{g_n}=\frac{\sqrt{m-1}}m\cdot m\sqrt{\frac{2m-1}{m-1}}=\sqrt{2m-1},$$

and $\sqrt{2m-1}$ at those $m$ is $3.3166,\,4.3589,\,6.2450,\,9.9499,\,19.9750$, the reported figures to every digit. **The screen evaluates the lemma's own closed form against the lemma's own closed form**; it constructs no tensor, applies no Weyl projection, and could not have detected any error in V1, V2 or V3. It is exactly the shape the standing rule permits ("screening a claim you are about to record") applied to a claim it cannot reach. A screen that built $H$ (three lines, as in V1), would have returned $\tfrac{m\sqrt{2m-1}}{m-1}=3.98$ at $m=6$ against the reported $3.32$ and caught the whole entry.

**It also misreports its own target.** $\sqrt2\sqrt m$ at $m=6$ is $3.4641$, not $3.3166$; the sequence matches $\sqrt{2m-1}$, and $\sqrt{2m}$ is a different function that happens to agree to two digits by $m=200$. Recording this because "matching $X$" in a screen line is what a successor will quote.

## V8, vacuity

**The lemma is not vacuous**, it computes a real number about a real subspace, and the number decides something the plan acts on. Three checks:

- **The summand is nonempty and inside the domain.** $\dim S^2_0(\mathbb R^m)=\tfrac{(m-1)(m+2)}2$, positive for $m\ge2$; the summand is orthogonal to $\langle W\rangle$ (excluded by $T_{W^*}S$) and to $\mathbb R^p\otimes\mathbb R^q$ (the orbit tangent), so it lies in $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ as required. At $m=2$ its Weyl image degenerates to $0$ (V1) and the lemma is vacuous there; $m\ge4$ is forced anyway by [Lemma L27](../findings/nondegeneracy.md).
- **The bound is not vacuously satisfiable.** $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ holds for free, so a claimed upper bound is content only when $o(1)$; $\Theta(n^{-1/2})$ is. Symmetrically $\lVert H\rVert_{op}\ge\lVert H\rVert_F/\sqrt{\binom n2}\asymp g_n$ holds for free, and the lemma's lower bound $1/m$ is of that same order $\Theta(1/n)$, **so the lower half of the display is, to within a constant, the free bound**, and its only content is the constant, which V3 shows is not the one claimed.
- **The conclusion is used.** It is the input to a re-run of the L145 chain that L146 explicitly defers. Given V5, that re-run is not the constant-chasing the entry implies, it is the exponent.

---

## What I could not break

- **Diagonality on coordinate $2$-planes.** It survives the Weyl projection, because the projection subtracts $h\owedge g$, itself diagonal in the same frame. This is the one structural claim of "The element" that holds, and it is the one that does the work, it gives $v=0$, hence $u=0$, hence the identification of the summand with the $u=0$ branch (V4).
- **$L_e$ scalar on the summand**, and the margin identity $3\theta_0(\tfrac12-\lambda_m)=c_p$ exactly (V4). The brief's worry that L145's margin might be a different constant varying over the summand is unfounded.
- **The order-level conclusion.** $\lVert H\rVert_{op}=\Theta(n^{-1/2})$ at worst, disc $\Omega(n^{-1/2})$, a factor $\sqrt n$ over $g_n$. The corrected maximum $1/\sqrt{m-1}$ and the claimed $\sqrt{m-1}/m$ differ by $m/(m-1)\to1$.
- **The sign of the infimum argument** (V5, first paragraph): a larger disc really does give a larger local radius, and a tube radius really is an infimum.

## What would repair the entry

1. **Replace "The element" with the corrected embedding** ($H=(1-c)h\owedge g_q-c\,h\owedge g_p$, $c=m/(n-2)$) and state $\mathrm{Ric}(h\owedge g_q)=mh$ as the reason the projection term is there. Keep diagonality; delete "zero on planes inside either block".
2. **Restate the display as $\sqrt{2/((m-1)(m-2))}\lesssim\lVert H\rVert_{op}\le1/\sqrt{m-1}$**, with $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ and $\lVert H\rVert_{op}=\tfrac{m}{2(m-1)}\max_{a\ne b}\lvert h_a+h_b\rvert$, and note that the minimum's parity lives in $V_m=m/4$ against $(m-1)/4$. **The current upper bound is false and must not stand.**
3. **Reverse the verdict box.** [r446](REVIEW_r446.md) D6 is CONFIRMED by this computation; [r447](REVIEW_r447.md)'s bottom line stands at $\sup\lvert P\rvert=\Theta(\sqrt n)$ and its F2 strengthening ("$-3/2$ pinned unconditionally on $\sup\lvert P\rvert$"), is REFUTED, because $\lVert A''\rVert=O(1)$ on the binding summand. **Re-promote [I31](../plan.md)**, and strike "and it is an equality" from [Lemma L145](../findings/second-order.md) step 4.
4. **Add the hypothesis $m\ge4$**, inherited from [Lemma L27](../findings/nondegeneracy.md), and record that the summand's Weyl image vanishes at $m=2$.
5. **Replace the screen** with one that constructs $H$ and checks $\mathrm{Ric}(H)=0$, Bianchi, diagonality and both norms, or delete it. As it stands it certifies an identity, and the entry reads as if it certified the embedding.
6. **State the scope of "throughout"**: the disc bound is proved on one of ten summands. Either carry the $w$-sweep of V6 or say that one summand is priced.

## What this audit did not check

[Lemma L27](../findings/nondegeneracy.md)'s ten summand values and its multiplicity-freeness, [Lemma L133](../findings/second-order.md)'s support table (used only for $u^2\le\tfrac29v^2$), [Lemma L141](../findings/second-order.md)'s $c_p=3\theta_0/(n-2)$, [Lemma L143](../findings/bounds.md)'s $\sup\lvert P\rvert\le1+\sqrt{n-2}$, and the Cauchy/Neumann machinery of [r446](REVIEW_r446.md) D3 were taken as given; each carries its own Gate 2. I re-derived only what combines them: the Kulkarni–Nomizu contraction, the Weyl projection against the record's own projector, both norms, both extremal problems, the margin identity, and the three branches of V5. Whether $\lVert A''\rVert$ is **saturated** at $O(M/\rho^2)$ on these directions, [r443](REVIEW_r443.md)'s open item (iii), is untouched, and V5's table is an upper bound on the denominator throughout, so it establishes that the cap is **lost**, not that a better exponent is **attained**.
