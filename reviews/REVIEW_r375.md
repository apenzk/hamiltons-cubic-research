# REVIEW r375, Gate 2 on route [R16](../routes.md), item [I18](../plan.md): the five claims of the five-commit tail

*Cold adversarial review, 2026-09-02. Every block value, eigenvector and margin below was re-derived from the definitions before the author's argument was read; the two places where I could only reproduce the author's route are named as such. **Analysis only**, nothing here was computed, and no screen was run.*

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | [Corollary L128.1](../findings/second-order.md) (every two-block sphere product at $n\ge12$ meets the criterion | **CORRECTED**), holds at $p,q\ge3$; the $\mathcal D_n$ clause has a scope gap at $p=2$ and an incomplete summand list |
| 2 | the band $[\sqrt{3/2},\Theta_n]$, width $0.0113$ at $n=12$ | **CONFIRMED**, every number and every scope step checks |
| 3 | the perturbation route is closed uniformly in $n$ | **CORRECTED**, the conclusion stands and is stronger than argued; two of its three supporting statements are wrong or overstated |
| 4 | the Gershgorin attempt "fails at the balanced product by one unit of $\lvert\gamma\rvert$" | **REFUTED**, it *succeeds* there, by $\lvert\gamma\rvert/(m-1)$; the comparison dropped the $M_{jk}$ term of its own sufficient condition |
| 5 | the Dirichlet restatement and its $m=6$ hand check | **CORRECTED**, one sign error ($\theta=(2m-1)\gamma$ against the record's own $\gamma<0$) moves both displayed eigenvalues; the slack and the margin survive |

---

## The ground I re-derived first, and it is the arithmetic the last three claims run on

At $S^p\times S^q$ with $n=p+q$, sectional entries $\alpha$ within $F_1$, $\beta$ within $F_2$, $\gamma$ across, Ricci-flatness gives $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$. **Criticality fixes the signs, and this is the fact the tail gets wrong.** The within-factor criticality relation $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$ reads
$$(p-1)\alpha^2+q\gamma^2=\theta\alpha,$$
whose left side is positive, so $\theta\alpha>0$; with $\theta>0$ this forces $\alpha>0$ and hence $\gamma<0$. [Lemma L127](../findings/second-order.md) reaches the same conclusion independently, its constant-on-parts block value $-\tfrac12(n-1)\gamma$ must equal $\theta/2$, so $\theta=-(n-1)\gamma=(n-1)\lvert\gamma\rvert$.

$$\boxed{\ \alpha=\frac{q\lvert\gamma\rvert}{p-1},\qquad \beta=\frac{p\lvert\gamma\rvert}{q-1},\qquad \gamma=-\lvert\gamma\rvert,\qquad \theta=(n-1)\lvert\gamma\rvert\ }$$

I checked $\theta$ against [Lemma L57](../findings/problem.md) rather than taking it: normalising $\lVert W\rVert^2=\binom p2\alpha^2+\binom q2\beta^2+pq\gamma^2=1$ at $p=q=m$ gives $\gamma^2=(m-1)/(m^2(2m-1))$ and $\theta=(2m-1)\lvert\gamma\rvert=\sqrt{(2m-1)(m-1)}/m$, which is exactly $\Theta_{2m}$ from L57's even-$n$ formula. **Agreement, from two directions.**

**The three $\Delta^{(jk)}$-eigenvector types, computed directly.** For a within-factor pair $\{j,k\}\subset F_1$, [Lemma L122](../findings/second-order.md)'s Laplacian on $(F_1\setminus\{j,k\})\cup F_2$ has, on $\mathbf1^\perp$:

| eigenvector | eigenvalue of $\Delta^{(jk)}$ | multiplicity | $L_e$ value |
|---|---|---|---|
| sum-zero on $F_1\setminus\{j,k\}$ | $-\alpha$ | $p-3$ | $0$ |
| sum-zero on $F_2$ | $-\gamma\dfrac{p+2q-2}{q-1}>0$ | $q-1$ | $<0$ |
| constant on each part | $(n-2)\gamma=-(n-2)\lvert\gamma\rvert$ | $1$ | $\dfrac{p-2}{2(p-1)}$ |

The third row is the one that matters and I derived it from scratch: $\lambda=(n-2)\gamma$, and $\big(-\lambda-\alpha\big)/(2\theta)=\big((n-2)(p-1)-q\big)/\big(2(n-1)(p-1)\big)=(p-2)/(2(p-1))$ after $(n-2)(p-1)-q=(p-2)(n-1)$. **This reproduces [Lemma L127](../findings/second-order.md)'s within-factor top by a route independent of it.** I also re-derived the four-set value: on a $(2,2)$-split, $A=\alpha+\beta$, $B=C=2\gamma$, so $\Sigma=(\alpha+\beta-2\gamma)^2$ and $\sqrt\Sigma/(2\theta)=(n-2)/(2(p-1)(q-1))=\mu_{p,q}$, with $\Sigma=0$ on every other split. **Both of [Lemma L126](../findings/second-order.md)'s and [Lemma L127](../findings/second-order.md)'s block values are confirmed from the definitions.**

Hence, at the balanced product $p=q=m$:
$$\lambda_{\min}\big(\Delta^{(jk)}\big|_{\mathbf1^\perp}\big)=\min\big(-\alpha,\ (n-2)\gamma\big)=-2(m-1)\lvert\gamma\rvert,\qquad -(\theta+\alpha)=-\frac{2m^2-2m+1}{m-1}\lvert\gamma\rvert .$$
At $m=6$: $\alpha=1.2\lvert\gamma\rvert$, $\theta=11\lvert\gamma\rvert$, $\lambda_{\min}=-10\lvert\gamma\rvert$, $-(\theta+\alpha)=-12.2\lvert\gamma\rvert$.

---

## Claim 1, [Corollary L128.1](../findings/second-order.md): **CORRECTED**

**The four-set clause is right, and its Diophantine step is more robust than the corollary needs.** $\tfrac12$ is a four-set $L_e$-eigenvalue iff $\Sigma=\theta^2$ iff $\mu_{p,q}=\tfrac12$ iff $\tfrac1{p-1}+\tfrac1{q-1}=1$. Writing $u=p-1$, $v=q-1$, the solutions in positive integers are $u=v=2$ alone, and [Lemma L126](../findings/second-order.md) explicitly disposes of $u=1$, so this clause covers $p=2$ as well.

**The pair clause is right at $p,q\ge3$ and its formula degenerates at $p=2$, harmlessly.** At $p=2$ the part $F_1\setminus\{j,k\}$ is empty, the constant-on-parts eigenvector does not exist on $\mathbf1^\perp$, and the single within-$F_1$ block is the weighted Laplacian of $K_q$ with weight $\beta>0$: its whole $\mathbf1^\perp$-spectrum is $\{q\beta\}$, so every $L_e$ value there is $(-q\beta-\alpha)/(2\theta)<0$. [Lemma L127](../findings/second-order.md)'s $(p-2)/(2(p-1))=0$ is then an upper bound that is not attained. **The conclusion survives; the cited formula does not apply.**

**The $\mathcal D_n$ clause is where the corollary is short, in two distinct ways.**

*(a) The summand list is incomplete, and the omission is the interesting one.* [Lemma L27](../findings/nondegeneracy.md) gives ten summands carrying $\{1,\tfrac12,\lambda_p,\lambda_q,-\mu,+\mu,0,0,0,0\}$. L128.1 lists $\{\lambda_p,\lambda_q,-\mu,0\}$, it drops $+\mu$, which is the only value in the list that can equal $\tfrac12$. **And $+\mu$ is $\mu_{p,q}$:** from L27's own display $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, so $\mu=\frac{p+q-2}{2(p-1)(q-1)}=\mu_{p,q}$, the four-set top. The corollary's phrase "all $\ne\tfrac12$ by the same two inequalities" is therefore *literally* true ($(p-2)(q-2)=1$ and $\tfrac1{p-1}+\tfrac1{q-1}=1$ are the same condition) but the list it is attached to does not contain the value the inequality is about. In fact $+\mu$'s summand is $\Lambda^2\otimes\Lambda^2$, which sits in the **four-set** blocks (at $S^3\times S^3$ its nine dimensions are exactly [Lemma L121](../findings/second-order.md)'s nine $(2,2)$-split blocks), so it is right to keep it out of the $\mathcal D_n$ row, but then the corollary should say so rather than silently omit it.

*(b) The corollary does not say why the $\tfrac12$-carrying summand misses $\mathcal D_n$, and the reason is a cleaner argument than the one given.* The only summand at $\tfrac12$ is $\mathbb R^p\otimes\mathbb R^q$, which has dimension $pq=\dim\mathcal O$ and contains $T_W\mathcal O$, hence **equals** it. By [Lemma L128](../findings/second-order.md)(i), $T_W\mathcal O\subseteq\bigoplus_{\{j,k\}}V_{jk}$, and $\mathcal D_n$ is the trivial-character block, disjoint from every $V_{jk}$. **So $\mathbb R^p\otimes\mathbb R^q\cap\mathcal D_n=0$ and $\mathcal D_n\cap W^\perp$ avoids $\tfrac12$ outright**, no inspection of which other summands meet $\mathcal D_n$ is needed, and the corollary's own $\{\lambda_p,\lambda_q,-\mu,0\}$ list, which would require exactly that inspection, is not needed either. *The list as printed is not derivable from L27 without knowing $\mathcal D_n$'s intersection with each summand; none of the four summands lies inside $\mathcal D_n$, $S^2_0(\mathbb R^m)$ alone has dimension $m^2+m-2$ against $\dim\mathcal D_{2m}=2m^2-3m$ for the two copies together, and $S^2_0\otimes S^2_0$ is of order $m^4$.*

*(c) The scope claim "**every** two-block sphere product at $n\ge12$" over-reaches to $p=2$, and the record says so in the paragraph the corollary is built on.* [Lemma L126](../findings/second-order.md)'s own box records that **[Lemma L27](../findings/nondegeneracy.md)'s decomposition over-counts at $p=2$ ($86$ against $\dim\mathrm{Weyl}_6=84$**) and that is precisely the input L128.1's $\mathcal D_n$ clause cites. $S^2\times S^{10}$ is a two-block sphere product at $n=12$; it is critical (criticality gives $\theta=(q+1)\lvert\gamma\rvert$ there too); and the $\mathcal D_n$ clause is not established at it by the cited route. The orbit-summand argument in (b) also uses L27, so it does not repair $p=2$ either; the only cover is [Lemma L11](../findings/nondegeneracy.md), which is numerical and verified only to $n=14$.

**Correction to record.** L128.1 should read "*every $S^p\times S^q$ with $p,q\ge3$ and $n\ge12$*", should give the $\mathcal D_n$ clause as the orbit-summand argument of (b), and should note that $+\mu=\mu_{p,q}$ lives in the four-set blocks. **This costs [I18](../plan.md)(b) nothing that matters**: at $n=12$ only $(5,7)$ and $(6,6)$ lie in the band at all, I computed $\theta^2=(n-1)^2\big/\big(pq[\tfrac q{2(p-1)}+\tfrac p{2(q-1)}+1]\big)$, giving $\theta=0.995,\ 1.1418,\ 1.2015,\ 1.2283,\ 1.2361$ at $(2,10),(3,9),(4,8),(5,7),(6,6)$, so $S^2\times S^{10}$ sits far below $\sqrt{3/2}$ and I18's hypothesis never reaches it. **The corollary is over-broad, not wrong where it is used.**

## Claim 2, the band: **CONFIRMED**

- **Does [Lemma L57](../findings/problem.md) apply to every diagonal $W$ or only maximisers?** *Every diagonal $W$.* The statement is $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ "for every diagonal $W$ at every $n\ge4$", with no criticality and no maximality hypothesis; the equality case is what is restricted to the balanced product. I checked the proof status too: the block's pointer to *"[What remains owed: steps 1 and 3](../findings/problem.md)"* is stale in its wording, that section now records **step 3 closed at both parities by two independent Gate-2 proofs** and step 1 as the file's own Dirichlet-energy step, and its summary line reads "Steps 1, 2 and 3 are proved, both equality cases are proved, and every constant is symbolic in $n$." **The lemma is not owing anything.**
- **Does "pure" coincide with "diagonal"?** *Yes.* $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$; a pure $W$ has $M$ hollow symmetric, and $M\mathbf1=0$ is Ricci-flatness, which every Weyl operator has. The one step the tail leaves silent is that "pure" means diagonal in *some* frame while L57 is stated in the coordinate frame, bridged by $O(n)$-equivariance of $Q$, so $P$ and $\lVert\cdot\rVert$ are both frame-blind. **Sound.**
- **Is $\Theta_{12}=\sqrt{55}/6$?** $\Theta_n^2=2(n-1)(n-2)/n^2=2\cdot11\cdot10/144=220/144=55/36$. ✓ $\Theta_{12}=1.2360330$.
- **Is the width right?** $1.2360330-1.2247449=0.0112881$. ✓ $0.0113$.
- **Is the asymptotic width right?** $\Theta_n^2\to2$, so $\Theta_n\to\sqrt2$ and the width $\to1.4142136-1.2247449=0.1894687$. ✓ $0.189$.

**One free consistency check the tail does not claim but which supports it.** The band is empty below $n=12$: $\Theta_{10}=1.2$, $\Theta_{11}=\sqrt{160/108}=1.2172$, both under $\sqrt{3/2}$; $\Theta_{12}=1.2360$ and $\Theta_{13}=1.2484$ are over. **The threshold $n\ge12$ is exactly where I18 stops being vacuous**, and it matches [Conjecture L16](../findings/problem.md)'s crossover $n=6+2\sqrt7=11.29$.

## Claim 3, the perturbation route closed uniformly in $n$: **CORRECTED**

**The conclusion stands.** But two of the three statements carrying it need repair, and the repair strengthens the conclusion.

**(a) The within-factor pair block is not the sole binding family, $\mathcal D_n$ ties it, and the record already says so.** The margins at $S^m\times S^m$ are

| family | $L_e$ value | margin to $\tfrac12$ |
|---|---|---|
| four-set, $(2,2)$-split | $\mu=\tfrac1{m-1}$ | $\tfrac12-\tfrac1{m-1}$, $\to\tfrac12$ |
| pair, within-factor | $\tfrac{m-2}{2(m-1)}$ | $\tfrac1{2(m-1)}$ |
| $\mathcal D_n$, the $S^2_0(\mathbb R^m)$ scalars $\lambda_m$ | $\tfrac{m-2}{2(m-1)}$ | $\tfrac1{2(m-1)}$ |
| $\mathcal D_n$, the $-\mu$ scalar | $-\tfrac1{m-1}$ | $\tfrac12+\tfrac1{m-1}$ |

$\lambda_m$ and the within-factor pair top are the *same number*, which [Lemma L121](../findings/second-order.md) records in as many words, "the value $(p-2)/(2(p-1))$ tops each within-factor pair block *and* occurs inside $\mathcal D_n$". **So the binding margin $1/(2(m-1))=1/(n-2)$ is right and its attribution is not**; the table in the tail omits the row that ties it. *This is not cosmetic: it means a perturbation argument must control $\mathcal D_n$ at the same $1/n$ margin, and $\mathcal D_n$ is the clause [I18](../plan.md)(d) already flags as untouched by the four-set and pair calculus.* On the ordering the tail does claim: $\tfrac1{2(m-1)}<\tfrac12-\tfrac1{m-1}\iff m>4$, so the pair family is strictly binding against the four-sets from $n\ge10$ and a fortiori at $n\ge12$, **correct as used**, with a tie at $m=4$ and the $S^3\times S^3$ degeneracy at $m=3$.

**(b) "A decaying margin kills the route" is under-argued as written, and the missing step makes it true a fortiori.** The tail's argument is: margin $\sim1/n$, band width $\to0.189$, so the two move against each other. **That is not yet a closure**, because the confinement radius is $d\lesssim\sqrt{(\Theta_n-\sqrt{3/2})/c_n}$ and nothing in the tail bounds the hypothetical deficit constant $c_n$; if $c_n$ grew like $n^2$ the window would stay open at every $n$. **The gap closes because $c_n$ decays too, and for the same reason the margin does.** The deficit is the Hessian of $P|_{S\cap\mathcal D_n}$ at the balanced product, $6\theta(L_e-\tfrac12)$ restricted to $\mathcal D_n\cap W^\perp$; its least-negative eigenvalue is $6\theta(\lambda_m-\tfrac12)=-3\theta/(m-1)$, from the very $S^2_0(\mathbb R^m)$ scalars of (a). So any deficit inequality valid near the orbit has
$$c_n\ \lesssim\ \frac{3\Theta_n}{2(m-1)}\ \sim\ \frac1m,\qquad\text{hence}\qquad d\ \gtrsim\ \sqrt{\tfrac{0.189\cdot2(m-1)}{3\sqrt2}}\ \sim\ \sqrt m .$$
**The confinement radius grows like $\sqrt n$ while the margin decays like $1/n$, so the window closes like $n^{3/2}$, not like $n$.** *The route is closed harder than the tail argues, and the same block ($S^2_0(\mathbb R^m)$ inside $\mathcal D_n$), is what closes both ends of it.*

**(c) "The granted maximiser is asymptotically a branch point" is an OVERSTATEMENT.** What is true: the Hessian's spectral gap at $S^m\times S^m$ closes, $6\theta(\tfrac12-\lambda_m)=3\theta/(m-1)\to0$ with $\theta\to\sqrt2$ fixed, and it closes on $\Theta(n^2)$ directions at once, the $2\binom m2$ within-factor pair blocks plus the two $S^2_0$ summands. What is not true: $\tfrac12$ is never attained at finite $m$, so [Lemma L128](../findings/second-order.md)(ii) holds at every $m\ge4$ and (iii) isolates the orbit at every one of them. And "branch point" carries a stronger meaning in this record than a vanishing gap: [Lemma L126](../findings/second-order.md)'s box and [Lemma L11](../findings/nondegeneracy.md) both state that **the obstruction proves no branch when it fails, rather than a branch when it vanishes**, and here it does not even vanish. **The defensible sentence is "the granted maximiser's Hessian gap closes like $1/n$ on order $n^2$ directions", which is what the argument uses.**

## Claim 4, the Gershgorin attempt: **REFUTED**

**The mechanics are all correct.** $\Delta=\mathop{\mathrm{diag}}(N\mathbf1)-N$ with $N=M^{(jk)}$ hollow, so $\Delta_{ii}=\sum_lN_{il}$ and $\lvert\Delta_{il}\rvert=\lvert N_{il}\rvert$; Gershgorin's lower envelope $\min_i(\Delta_{ii}-R_i)$ is a valid lower bound on **every** eigenvalue, so it bounds $\lambda_{\min}$ on $\mathbf1^\perp$ as well. **Direction correct.** And $\sum_lN_{il}-\sum_l\lvert N_{il}\rvert=(P_i-S_i)-(P_i+S_i)=-2S_i$, so $\lambda\ge-2s_i$ with $s_i$ the negative mass. **Correct.** Zero row sums give $\sum_lM_{il}=0$, hence positive mass $=$ negative mass $=\tfrac12\lVert M_i\rVert_1$ **for a row of $M$**. **Correct.**

**One step is unstated and is needed.** The negative mass is taken on $N$, not $M$; the two differ by the deleted entries $M_{ij},M_{ik}$, and $\sum_lN_{il}=-M_{ij}-M_{ik}\ne0$ in general, so the exact identity does *not* hold for $N$. What holds is $s_i(N)\le s_i(M)=\tfrac12\lVert M_i\rVert_1$, deletion removing at most negative mass, which is enough for the sufficient condition, and is the step the paragraph skips.

**The balanced-product arithmetic is wrong, and it drops a term of its own stated condition.** The sufficient condition is $\lVert M_i\rVert_1<\theta+M_{jk}$. At $S^m\times S^m$ with a **within-factor** pair, $M_{jk}=\alpha=m\lvert\gamma\rvert/(m-1)$, and
$$\lVert M_i\rVert_1=(m-1)\alpha+m\lvert\gamma\rvert=2m\lvert\gamma\rvert,\qquad \theta+M_{jk}=(2m-1)\lvert\gamma\rvert+\frac{m\lvert\gamma\rvert}{m-1}=\frac{2m^2-2m+1}{m-1}\lvert\gamma\rvert .$$
**The tail compares $2m\lvert\gamma\rvert$ against $\theta=(2m-1)\lvert\gamma\rvert$ alone, discarding $M_{jk}$.** With the term kept,
$$2m<(2m-1)+\frac m{m-1}\iff 1<\frac m{m-1}\iff m-1<m,$$
**true at every $m$.** At $m=6$: $12\lvert\gamma\rvert<12.2\lvert\gamma\rvert$. The margin is $\lvert\gamma\rvert/(m-1)=\theta/\big((m-1)(2m-1)\big)$.

I checked this against the exact spectrum rather than only the bound. The worst row is $i\in F_1\setminus\{j,k\}$, whose negative entries are the $m$ cross $\gamma$'s (deletion removes two positive $\alpha$'s), giving $-2s_i=-2m\lvert\gamma\rvert=-12\lvert\gamma\rvert$ at $m=6$; rows in $F_2$ give $-2(m-2)\lvert\gamma\rvert=-8\lvert\gamma\rvert$. **So Gershgorin returns $\lambda_{\min}\ge-12\lvert\gamma\rvert$ against the true $-10\lvert\gamma\rvert$ and the target $-12.2\lvert\gamma\rvert$, lossy, and still sufficient.**

**What the correction changes.** The sentence *"the row-sum lever alone reproduces the same asymptotic thinness the perturbation route died of, and an argument that closes this clause must beat a bound that is wrong by one row entry"* is withdrawn. The correct statement is that the row-sum lever **closes the within-factor pair clause at the balanced product**, with a margin of $\lvert\gamma\rvert/(m-1)$ that is $\Theta(1/n^2)$ relative to $\theta$, thinner than the true margin's $\Theta(1/n)$, but positive.

**And the honest bad news for the route is a different point, which the tail does not make.** Running the same condition at an unbalanced product, $\max_i\lVert M_i\rVert_1=2\max(p,q)\lvert\gamma\rvert$ and $\theta+\alpha=\big[(n-1)+\tfrac q{p-1}\big]\lvert\gamma\rvert$; at $S^5\times S^7$, $n=12$, this is $14\lvert\gamma\rvert$ against $12.75\lvert\gamma\rvert$ (pair in $F_1$) or $12.83\lvert\gamma\rvert$ (pair in $F_2$). **Gershgorin fails at $S^5\times S^7$, which is in the band, $\theta=1.2283\ge\sqrt{3/2}$, while the true $\lambda_{\min}=(n-2)\gamma=-10\lvert\gamma\rvert$ clears $-(\theta+\alpha)$ with slack $\theta/(p-1)$.** *So the row-sum lever is genuinely insufficient, at an in-band object the record already possesses, and that is the fence post the paragraph was reaching for.* **Cross-factor pairs are not a counterexample to anything**: there $M_{jk}=\gamma<0$ and $\theta+\gamma=(n-2)\lvert\gamma\rvert$ is beaten by $2\max(p,q)\lvert\gamma\rvert$ only when $\max(p,q)>\tfrac{n-2}2$, but those blocks carry the orbit's $\tfrac12$ by design and the clause there is simplicity, not exclusion, a sufficient condition that excludes $\tfrac12$ **must** fail on them.

## Claim 5, the Dirichlet-form restatement and its hand check: **CORRECTED**

**The identity is right, signed weights and all.** For symmetric $N$ with $\Delta=\mathop{\mathrm{diag}}(N\mathbf1)-N$,
$$x^\top\Delta x=\sum_i\Big(\sum_lN_{il}\Big)x_i^2-\sum_{i,l}N_{il}x_ix_l=\tfrac12\sum_{i,l}N_{il}\big(x_i^2+x_l^2-2x_ix_l\big)=\tfrac12\sum_{i,l}N_{il}(x_i-x_l)^2,$$
with no positivity used. ✓ And the clause's direction is right: $\lambda_{\min}(\Delta|_{\mathbf1^\perp})>-(\theta+M_{jk})$ is exactly $\tfrac12\sum M_{il}(x_i-x_l)^2>-(\theta+M_{jk})\lVert x\rVert^2$ on $\mathbf1^\perp\setminus0$. ✓

**"Equality is forced along the orbit vector" is right, and for the reason the brief suspects is unavailable.** [Lemma L122](../findings/second-order.md) supplies two separate things: the **eigenvector** fact $\Delta^{(jk)}o=-(\theta+M_{jk})o$ for $o_i=M_{ki}-M_{ji}$, which is derived from criticality alone and needs no maximality; and the **inequality** $\lambda_{\min}\ge-(\theta+M_{jk})$, which is [Lemma L24](../findings/second-order.md) and does need maximality. Equality at $o$ follows from the first alone ($o^\top\Delta o=-(\theta+M_{jk})\lVert o\rVert^2$ exactly) so *"forced"* is correct. **What does not transfer is the $\ge$ off $o$**, and hence the "strictly" in the clause is the *target*, not a consequence: at a non-maximiser the eigenvector fact gives only $\lambda_{\min}\le-(\theta+M_{jk})$. The paragraph's own framing ("only its equality *shape* transfers") is close to this but the working-form display reads as an inequality already in hand. **Restate the clause as a target with the equality at $o$ as a known obstruction to its improvement.**

**The $m=6$ arithmetic carries one sign error, and it is in $\theta$.** Ricci-flatness $\alpha=-m\gamma/(m-1)$ is right. $\theta=(2m-1)\gamma$ is **wrong**: criticality and [Lemma L127](../findings/second-order.md) both give $\gamma<0$ and $\theta=-(2m-1)\gamma$. The passage substitutes the correct $\alpha$ and the sign-flipped $\theta$, and the two displayed numbers are the result:

| quantity | as recorded | correct |
|---|---|---|
| $\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})$ | $\gamma\dfrac{-2m^2+6m-2}{m-1}=-7.6\gamma$ | $2\gamma(m-1)=10\gamma=-10\lvert\gamma\rvert$ |
| $-(\theta+\alpha)$ | $-\gamma\dfrac{2m^2-4m+1}{m-1}=-9.8\gamma$ | $\gamma\dfrac{2m^2-2m+1}{m-1}=12.2\gamma=-12.2\lvert\gamma\rvert$ |
| slack | $2.2\gamma$ | $\dfrac\theta{m-1}=2.2\lvert\gamma\rvert$ |
| slack$/(2\theta)$ | $0.1=\tfrac1{2(m-1)}$ | $0.1=\tfrac1{2(m-1)}$ ✓ |

**As literally written the check fails its own test.** With the record's $\gamma<0$, $-7.6\gamma=+7.6\lvert\gamma\rvert$ and $-9.8\gamma=+9.8\lvert\gamma\rvert$, so "$\lambda_{\min}>-(\theta+M_{jk})$" would read $7.6\lvert\gamma\rvert>9.8\lvert\gamma\rvert$, which is false, and "slack $2.2\gamma$" is negative. **Both displayed values shift by exactly $2\alpha=2.4\lvert\gamma\rvert$ (the flipped term) which is why the slack is unaffected.** *The conclusion survives intact; the two numbers on the page do not.*

**"Three independent routes" is one route.** The slack is $\theta+\alpha+\lambda_{\min}$, and the paragraph obtains $\lambda_{\min}$ *from* the top $L_e$ eigenvalue $(m-2)/(2(m-1))$ ("the block's top $L_e$-eigenvalue forces $\lambda_{\min}=\dots$"), so
$$\frac{\text{slack}}{2\theta}=\tfrac12-\lambda_{\max}(L_e|_{\text{block}})$$
is an **identity**, not an agreement: given the top eigenvalue, the margin $1/(2(m-1))$ follows with no content, and the Laplacian identity is the change of variables between them. *A margin recovered by inverting the formula it was read off is not a confirmation.* **The independent check the paragraph wanted is the one at the head of this review**: diagonalising $\Delta^{(jk)}$ directly by its three equitable-partition eigenvector types gives $\lambda_{\min}=\min(-\alpha,(n-2)\gamma)=-10\lvert\gamma\rvert$ at $m=6$ **without** using [Lemma L127](../findings/second-order.md)'s table, and it agrees. *With that substituted, the paragraph's claim of independent agreement becomes true.*

---

## Nothing was left unchecked, and nothing needed computation

Every figure above is hand arithmetic in $m$ or in $n$ at $n=12$: the two $\Theta_n$ evaluations, the five $\theta$ values across the $n=12$ splits, the three $\Delta^{(jk)}$ eigenvector types, the four-set $\Sigma=(\alpha+\beta-2\gamma)^2$, the $\ell^1$ row norms, and the $m=6$ column of claim 5's table. **No screen was run and none was needed.** *One item is stated as an asymptotic rather than an identity, the bound $c_n\lesssim3\Theta_n/(2(m-1))$ in claim 3(b) is the local Hessian's least-negative eigenvalue, hence an upper bound on any deficit constant valid near the orbit, and it is not a claim about the global shape of $\theta$ on $\mathcal D_n$.*
