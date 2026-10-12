# Review r431, Lemma L141

*Adversarial audit, cold brief, 2026-09-03. Target: [Lemma L141](../findings/second-order.md) in [second-order.md](../findings/second-order.md), read against [Lemma L133](../findings/second-order.md), [Lemma L24](../findings/second-order.md) and [Lemma L120](../findings/second-order.md)/[Lemma L127](../findings/second-order.md) in the same file, [Lemma L27](../findings/nondegeneracy.md) in [nondegeneracy.md](../findings/nondegeneracy.md), [Lemma L140](../findings/route-a.md) and [Lemma L17](../findings/route-a.md) in [route-a.md](../findings/route-a.md), [Conjecture L16](../findings/problem.md) in [problem.md](../findings/problem.md), and [conventions.md](../findings/conventions.md).*

**Standing rule inherited and observed:** this programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). Every argument below is by hand. Two **screens** were run (seconds of arithmetic on closed forms I constructed for the purpose), to check numbers I was about to record: the ratio $\lvert\kappa_n^{\mathrm{Hess}}\rvert/\lvert\kappa_n\rvert$ across $n$, and the per-block value of $Q$ at $W^*$. They are reported as screens and are not offered as evidence for any positive claim; each claim below stands on its derivation.

## Verdict

| claim | verdict |
| --- | --- |
| **(a)** $\lVert D(\mathrm{Alt}W_-)_V[H]\rVert\le\tfrac12\lVert H\rVert$ for $V$ with differentiable spectral parts, $H\in\mathcal W_n$ | **CONFIRMED** as stated. Every step survives: the multiplier range, the centring, the entrywise-to-Frobenius transfer, $\mathrm{Alt}(H)=0$, and the projection step. Convention-robust, as claimed. |
| **(a)'s scope**, the title's "at every critical point", and "it holds at the competitor, where the spectrum is degenerate, … by the same three lines" | **REFUTED.** The differentiability hypothesis is exactly $\ker V=0$, and the competitor has a kernel. At a kernel the multiplier does not exist, the derivative is not linear, and [Lemma L140](../findings/route-a.md) needs a **fourth** line for the $K\times K$ block. As written, (a) is the restriction of L140 to the non-degenerate case, not a generalisation of it. |
| **(a)** vacuity | **CONFIRMED non-vacuous.** $D(\mathrm{Alt}W_-)[H]\ne0$ on the $(2,2)$ four-set blocks at $W^*$; the attainable ratio there is $\sqrt{2/9}=0.4714$, close to $\tfrac12$ and nonzero. |
| **(b)** $Q(H)\le-c_n\lVert H\rVert^2$ with $c_n=2.464\,\theta_0/(n-2)>0$ | **CONFIRMED**, conclusion and constant, subject to the domain correction below. Both input bounds are correctly quoted and correctly signed; the arithmetic $2.464=3\cdot4.598/5.598$ is right. |
| **(b)'s domain** as written, $T_{W^*}\mathcal O^\perp$ | **REFUTED as literally stated**, repaired in one symbol. The radial direction $H=W^*$ lies in $T_{W^*}\mathcal O^\perp$ taken in $\mathcal W_n$ and gives $Q(W^*)=+3\theta_0>0$. Must read $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$. |
| **(b)'s monotonicity clause**, "the first bound decreases in $\sigma$ and the second increases in $-\sigma$" | **REFUTED.** The first bound **increases** in $\sigma$. Read literally the clause gives the maximum of the minimum at the *endpoints*, not at the crossing, so the stated justification does not support the stated conclusion. The conclusion is nevertheless true, on the reversed monotonicity. |
| **(a)'s role in (b)**, "it also gives $\sigma\le\tfrac14$ everywhere, which is what makes the crossing argument in (b) finite" | **REFUTED.** The crossing value bounds $\min(B_1,B_2)$ for **every** $\sigma\ge0$; no ceiling on $\sigma$ is used or needed. (a) is not used in (b) at any point. At $n=12$ the crossing sits at $\sigma^*=0.652$, outside $[0,\tfrac14]$ altogether. |
| the sign of $\kappa_n$, at every place it enters | **CONFIRMED.** No collision. $\kappa_n<0$ for $n\ge12$ and only for $n\ge12$; $-\kappa_n d^2$ is handled as $+\lvert\kappa_n\rvert d^2$ throughout, in both bounds. |
| $\lvert\kappa_n^{\mathrm{Hess}}\rvert\ge5.598\lvert\kappa_n\rvert$ is L133's infimum, used in the right direction | **CONFIRMED.** |
| [Lemma L27](../findings/nondegeneracy.md) gives $L_e\le\lambda_m=\tfrac{m-2}{2(m-1)}$ off the orbit at $S^m\times S^m$ | **CONFIRMED**, and $\lambda_m$ is genuinely the off-orbit maximum for $m\ge5$, beating L26's $\mu=2/(n-2)$. |
| $\tfrac12\mathrm{Hess}=3\theta_0\langle(L_e-\tfrac12)H,H\rangle$ | **CONFIRMED** against [Lemma L24](../findings/second-order.md). |
| $Q\le-c_n\lVert H\rVert^2$ is what the tube needs | **CONFIRMED.** It is the second-order coefficient of $\theta_0+\kappa_n\delta^2-P$ along any curve in $S$ through $W^*$, and the sign is the one that makes [Conjecture L16](../findings/problem.md) hold locally. |
| $c_n$ vacuously small | **NO.** $c_n$ is $82.1\%$ of the Hessian's own off-orbit gap $3\theta_0/(n-2)$, which is the intrinsic scale; the $1/n$ decay is the gap's, not the argument's. |

**A sharpening is available from the same inputs and costs one line** (see [§6](#6-the-constant-is-2464-when-it-could-be-3)), replacing $2.464$ by $3$: $c_n=3\theta_0(n)/(n-2)$, which is the exact value of $\min Q/\lVert H\rVert^2$ at $W^*$ and therefore unimprovable.

## 1. Part (a): the multiplier, recomputed for a general pair

The claim is that the Daleckii–Krein multiplier of $f(x)=\tfrac12(\lvert x\rvert-x)$ has every entry in $[-1,0]$. Here $f(x)=0$ for $x\ge0$ and $f(x)=-x$ for $x<0$, so $f$ is piecewise linear with slopes $0$ and $-1$ and is Lipschitz. The multiplier is $f^{[1]}(\lambda,\mu)=(f(\lambda)-f(\mu))/(\lambda-\mu)$ off the diagonal and $f'(\lambda)$ on it. Since $f(\lambda)-f(\mu)=\int_\mu^\lambda f'$, **every divided difference is an average of $f'$ over an interval**, hence in $[\min f',\max f']=[-1,0]$. The record's one-clause justification is therefore correct, and it is correct precisely because $f$ is Lipschitz with slopes in that range, no case analysis is needed. For the record, the cases the brief asks for, each checked directly:

| pair | value | in $[-1,0]$ |
| --- | --- | --- |
| $\lambda,\mu>0$ | $0$ | yes |
| $\lambda,\mu<0$ | $-1$ | yes |
| $\lambda>0>\mu$ | $\mu/(\lambda-\mu)=-\lvert\mu\rvert/(\lambda+\lvert\mu\rvert)$ | yes, and strictly interior |
| $\lambda=\mu>0$ | $f'=0$ | yes |
| $\lambda=\mu<0$ | $f'=-1$ | yes |
| $\lambda=0$, $\mu>0$ | $0$ | yes |
| $\lambda=0$, $\mu<0$ | $-1$ | yes |
| $\lambda=\mu=0$ | **undefined** ($f$ has left slope $-1$ and right slope $0$ at $0$ |), |

**Only the $(0,0)$ block is undefined**, and that is exactly the kernel block. This is §2.

**The centring is right.** With $m_{\alpha\beta}\in[-1,0]$ and $DW_-[H]_{\alpha\beta}=m_{\alpha\beta}H_{\alpha\beta}$ in $V$'s eigenbasis, $\big(DW_-[H]+\tfrac12H\big)_{\alpha\beta}=(m_{\alpha\beta}+\tfrac12)H_{\alpha\beta}$ with $\lvert m_{\alpha\beta}+\tfrac12\rvert\le\tfrac12$. The record's wording "at most half the corresponding entry" should read "at most half in absolute value"; the argument uses the absolute-value form.

## 2. Part (a) and the kernel, the scope claim is false, and the repair is L140's own fourth line

**The hypothesis "$V$ at which the spectral parts are differentiable" is exactly $\ker V=0$.** If $0\notin\operatorname{spec}(V)$ there is a spectral gap at $0$ and $W\mapsto W_-$ is real-analytic near $V$, this is L133's Step 1 argument at $W^*$, and it is general. If $\ker V=K\ne0$, the directional derivative along $H$ carries, on the $K\times K$ block, the map $D\mapsto D_-=\tfrac12(\lvert D\rvert-D)$ with $D=P_KHP_K$. That map is positively homogeneous of degree one and **not linear** (it is linear only if $D$ is semidefinite for every $H$, which fails as soon as $\dim K\ge1$ and $H$ ranges over $\mathcal W_n$). So the derivative is one-sided and $V$ is not a point of differentiability. The record says the same thing elsewhere in its own voice: [Lemma L17](../findings/route-a.md)'s $d^+\delta^2$, L135's "**one-sided** second-order coefficient", L133's "$\delta^2$ has a kink" at the competitor, and L140's "$\delta^2$, having no third derivative at $u$".

**Consequences, and they run against two of L141's own sentences.**

- The title, "the defect's derivative is a $\tfrac12$-contraction **at every critical point**", is false. Critical points with kernel are not exceptional in this record: the competitor $u$ has $\ker u=K$ with $\dim K=\dim\Lambda^2-3$, and [conventions.md](../findings/conventions.md) records that **padding commutes with $Q$**, so every padded critical point has a large kernel. The hypothesis in the statement excludes all of them.
- "No spectral data of the base point enters, so it holds at the competitor, where the spectrum is degenerate, exactly as at the balanced product … and by the same three lines" is false twice. It does not hold at the competitor *under the stated hypothesis*, and it is not the same three lines: [Lemma L140](../findings/route-a.md) needs a fourth, which it states explicitly, "On the $K\times K$ block, where the multiplier does not exist because $u$ is degenerate at $0$, the exact value is $Z_{KK}=D_-$", giving $Z_{KK}+\tfrac12H_{KK}=\tfrac12\lvert D\rvert$ of norm $\tfrac12\lVert D\rVert=\tfrac12\lVert H_{KK}\rVert$.
- So the framing "Part (a) is [Lemma L140](../findings/route-a.md)'s recentring stated once, for every base point rather than only at the competitor" **inverts the containment**. As written, (a) is L140's argument with its hardest block deleted by hypothesis.

**The repair is free and makes the advertised claim true.** State (a) for the one-sided directional derivative at an arbitrary $V\in\mathcal W_n$, with the kernel clause imported verbatim: off the kernel, the multiplier lies in $[-1,0]$ and centring at $\mu=\tfrac12$ contracts each entry by $\tfrac12$; on $K\times K$ the exact value is $D_-$, and $D_-+\tfrac12D=\tfrac12\lvert D\rvert$ has norm $\tfrac12\lVert D\rVert$. Both blocks then satisfy the same bound, the blocks are orthogonal, $\mathrm{Alt}$ is an orthogonal projection, and the conclusion holds at **every** $V$, which is what the lemma wants to say.

## 3. Part (a): the remaining three steps, each checked

**The entrywise-to-Frobenius step is genuine, not a norm confusion.** $V$ is symmetric for the $\Lambda^2$ inner product, so it has an **orthonormal** eigenbasis $\{v_\alpha\}$ of $\Lambda^2$; the matrix entries $H_{\alpha\beta}$ are taken in that basis, and the record's norm on operators on $\Lambda^2$ is a fixed multiple of the Frobenius norm, which is unitarily invariant. Hence
$$\big\lVert DW_-[H]+\tfrac12H\big\rVert^2=\sum_{\alpha\beta}\big(m_{\alpha\beta}+\tfrac12\big)^2H_{\alpha\beta}^2\ \le\ \tfrac14\sum_{\alpha\beta}H_{\alpha\beta}^2=\tfrac14\lVert H\rVert^2 .$$
No operator-norm step is used and none is needed. The $\Lambda^2$-versus-pair-matrix factor of [conventions.md](../findings/conventions.md) cancels between the two sides, so the $\tfrac12$ is convention-free in that sense too.

**$\mathrm{Alt}(H)=0$ is right.** $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto its $\Lambda^4$ summand, [problem.md](../findings/problem.md) ("$\mathrm{Alt}$ being the projection onto $\Lambda^4$"), [route-a.md](../findings/route-a.md) ("$\mathrm{Alt}$ is an orthogonal projection"), and L133's Step 2 uses it as the orthogonal projection onto $\mathbf1$ in the signed four-set coordinates, where first Bianchi is $x+y+z=0$, consistently the projection **with** its $\tfrac13$, not the unnormalised antisymmetriser. A tensor satisfying the first Bianchi identity has zero $\Lambda^4$ component by definition of that summand, so $\mathrm{Alt}(H)=0$ for $H\in\mathcal W_n$, and $\mathrm{Alt}$ being idempotent and self-adjoint gives $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$. Both uses are correct. *Had the record used the unnormalised antisymmetriser anywhere the constant would be $\tfrac32$, not $\tfrac12$; it does not.*

**$D(\mathrm{Alt}\,W_-)=\mathrm{Alt}\circ DW_-$** since $\mathrm{Alt}$ is linear and base-point-independent. Fine.

**The sign convention genuinely does not bite, and this is the one place the earlier refuted chain died.** In the opposite convention $W_-=\tfrac12(W-\lvert W\rvert)$ the multiplier of $f(x)=\tfrac12(x-\lvert x\rvert)$ has range $[0,1]$, centring at $\mu=-\tfrac12$ gives the same $\tfrac12$, and $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ and $\lVert D(\mathrm{Alt}W_-)[H]\rVert$ are both invariant under $W_-\mapsto-W_-$. **The estimate is a two-sided norm bound, and a two-sided bound cannot collide with a sign**, which is exactly what distinguishes it from [Lemma L136](../findings/route-a.md)/[Lemma L137](../findings/route-a.md), where a *one-sided* inequality was applied. The lemma's own sentence to this effect is correct.

## 4. Part (b): the two input bounds

**The spectral bound is correctly quoted.** [Lemma L27](../findings/nondegeneracy.md) gives ten $O(p)\times O(q)$ summands on which $L_e$ is a scalar, with values $1$ on $\langle W\rangle$, $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (the orbit), $\lambda_m=(m-2)/(2(m-1))$ on each $S^2_0(\mathbb R^m)$, $\pm\mu$ on the two tensor summands, and $0$ on the remaining four. At $p=q=m$, $\tfrac12-\mu=\frac{(m-2)^2-1}{2(m-1)^2}=\frac{m-3}{2(m-1)}$ gives $\mu=\frac1{m-1}=\frac2{n-2}$, and
$$\lambda_m-\mu=\frac{m-2}{2(m-1)}-\frac{2}{2(m-1)}=\frac{m-4}{2(m-1)}>0\quad\text{for }m\ge5 ,$$
so at $n=2m\ge12$ the off-orbit maximum **is** $\lambda_m$, not $\mu$. The hypotheses $p,q\ge3$ and $(p,q)\ne(3,3)$ are satisfied with room at $m\ge6$. Then $\tfrac12-\lambda_m=\frac1{2(m-1)}=\frac1{n-2}$ and [Lemma L24](../findings/second-order.md)'s $\mathrm{Hess}(P|_S)=6\theta_0(L_e-\tfrac12\mathrm{Id})$ gives $\tfrac12\mathrm{Hess}\le3\theta_0(\lambda_m-\tfrac12)\lVert H\rVert^2=-\tfrac{3\theta_0}{n-2}\lVert H\rVert^2$. **CONFIRMED**, normalisation included.

**The pencil bound is correctly quoted and correctly directed.** $\kappa_n^{\mathrm{Hess}}$ is a **supremum** of a ratio whose numerator is $\le0$ and whose denominator is $>0$ on the admissible set, so $\tfrac12\mathrm{Hess}\le\kappa_n^{\mathrm{Hess}}d(H)^2$ is the correct reading, and taking the sup over the larger set $T_{W^*}S$ rather than over $T_{W^*}\mathcal O^\perp$ is conservative, hence safe. *Screened*: $\lvert\kappa_n^{\mathrm{Hess}}\rvert/\lvert\kappa_n\rvert$ falls monotonically from $49.27$ at $n=12$ to $5.598$ in the limit, so $\lvert\kappa_n^{\mathrm{Hess}}\rvert\ge5.598\lvert\kappa_n\rvert$ holds for every $n\ge12$, strictly, with $5.598$ an infimum never attained. **CONFIRMED.**

**The sign of $\kappa_n$, traced through every occurrence.** $\theta_0(n)^2\ge\tfrac32$ is $n^2-12n+8\ge0$, i.e. $n\ge6+2\sqrt7=11.29$, so $\kappa_n=9(\sqrt{3/2}-\theta_0(n))<0$ **exactly** on the range $n\ge12$ the lemma is stated for, the restriction and the sign are the same fact. Then $-\kappa_nd^2=+\lvert\kappa_n\rvert d^2\ge0$, a positive contribution to $Q$, and both bounds carry it that way: $Q\le(-\tfrac{3\theta_0}{n-2}+\lvert\kappa_n\rvert\sigma)\lVert H\rVert^2$, and $\kappa_n^{\mathrm{Hess}}-\kappa_n=-\lvert\kappa_n^{\mathrm{Hess}}\rvert+\lvert\kappa_n\rvert\le-4.598\lvert\kappa_n\rvert$. **No collision.** The refuted chain's failure mode is absent here for a structural reason: $\kappa_n$ enters only through $\lvert\kappa_n\rvert$ multiplying a squared norm.

## 5. Part (b): the crossing, and two false clauses around a true conclusion

**The arithmetic is right.** At $\sigma^*=\frac{3\theta_0}{5.598\lvert\kappa_n\rvert(n-2)}$ both bounds equal
$$-\frac{3\theta_0}{n-2}\Big(1-\frac1{5.598}\Big)\lVert H\rVert^2=-\frac{3\cdot4.598}{5.598}\cdot\frac{\theta_0}{n-2}\lVert H\rVert^2=-\frac{2.4641\,\theta_0}{n-2}\lVert H\rVert^2 .$$
**CONFIRMED**, both by substitution into $B_1$ and into $B_2$.

**The monotonicity clause is backwards.** Write $B_1(\sigma)=-\tfrac{3\theta_0}{n-2}+\lvert\kappa_n\rvert\sigma$ and $B_2(\sigma)=-4.598\lvert\kappa_n\rvert\sigma$. $B_1$ is **increasing** in $\sigma$ and $B_2$ is decreasing. The record writes "the first bound decreases in $\sigma$ and the second increases in $-\sigma$". Read literally that is $B_1$ decreasing and $B_2$ decreasing, under which the minimum is largest at an endpoint and the crossing has no role, the stated reason does not deliver the stated conclusion. **The conclusion is true on the correct monotonicity**: with $B_1$ up and $B_2$ down, the lower envelope $\min(B_1,B_2)$ rises along $B_1$ to the crossing and falls along $B_2$ after it, so $\min(B_1(\sigma),B_2(\sigma))\le B_1(\sigma^*)=B_2(\sigma^*)$ for every $\sigma\ge0$. The clause needs replacing, not the conclusion. *This is worth fixing rather than tolerating: the labels "useful when $\sigma$ is small" and "useful when $\sigma$ is large" are the correct statement of the same fact three lines earlier, so the file contradicts itself in the space of one paragraph.*

**The $\sigma\le\tfrac14$ clause is false, and (a) is unused in (b).** The envelope inequality above holds for **all** $\sigma\ge0$; no ceiling enters. The record's "it also gives $\sigma\le\tfrac14$ everywhere, which is what makes the crossing argument in (b) finite" therefore attributes to (a) a role it does not play, and the two parts of L141 are independent results sharing a page. *Screened*: at $n=12$, $\sigma^*=0.652$, the crossing is **outside** $[0,\tfrac14]$ entirely, so if a ceiling were load-bearing the argument would break at the smallest dimension in scope rather than be rescued there. What $\sigma\le\tfrac14$ would actually do, if used, is **improve** the constant at small $n$: the true worst case over $\sigma\in[0,\tfrac14]$ is $B_1(\tfrac14)=-0.34541$ at $n=12$ against the crossing's $-0.30456$.

**The domain needs one symbol.** $Q$ is asserted on "$T_{W^*}\mathcal O^\perp$". [Lemma L24](../findings/second-order.md) states $\mathrm{Hess}(P|_S)_{W^*}=6\theta_0(L_e-\tfrac12\mathrm{Id})$ as a formula on all of $\mathcal W_n$, and under that reading $H=W^*$ is orthogonal to $T_{W^*}\mathcal O$ (the orbit lies on the unit sphere), with $L_eW^*=W^*$, $\delta^2$ constant along the ray so $d(W^*)=0$, and
$$Q(W^*)=3\theta_0(1-\tfrac12)\lVert W^*\rVert^2=+\tfrac32\theta_0\cdot2=+3\theta_0\ >\ 0 ,$$
a direct counterexample to the literal statement. The intended domain is $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, on which both input bounds are valid ($L_e\le\lambda_m$ needs $H\perp W^*$ **and** $H\perp T_{W^*}\mathcal O$). **State it.**

**The tube direction is the one claimed.** Along any $C^2$ curve $W(t)\subset S$ with $W(0)=W^*$, $\dot W(0)=H$: the tangential acceleration pairs with $\nabla(P|_S)=0$ and the radial part contributes $-3\theta_0\lVert H\rVert^2$, giving $P(W(t))-\theta_0=\tfrac{t^2}2\mathrm{Hess}(P|_S)[H,H]+O(t^3)$; and since $\mathrm{Alt}(W^*_-)=0$, the second-order coefficient of $\delta^2$ is $\lVert D(\mathrm{Alt}W_-)[H]\rVert^2$ **independently of the curve's acceleration**, because that acceleration multiplies the vanishing zeroth-order term. *This is why the great-circle-versus-straight-line distinction that [Lemma L135](../findings/route-a.md) has to carry at the competitor does not arise at $W^*$.* Hence
$$\theta_0+\kappa_n\delta^2-P\;=\;-t^2Q(H)+O(t^3),$$
and $Q\le-c_n\lVert H\rVert^2$ is exactly what makes [Conjecture L16](../findings/problem.md) hold on a tube of radius $c_n/C$. **The inequality is in the right direction and on the right quantity.**

## 6. The constant is $2.464$ when it could be $3$

The crossing argument discards the coupling between $\sigma$ and the Hessian, and at $W^*$ that coupling is total. $Q$ is **additive over [Lemma L120](../findings/second-order.md)'s blocks**: $\mathrm{Hess}$ is block-diagonal, $D W_-$ is entrywise in the coordinate-plane eigenbasis hence block-preserving, and the blocks are mutually orthogonal. L133's Step 2 then gives $\sigma_b=0$ on every block except the $(2,2)$-split four-set blocks, and on those, with $\lVert H\rVert^2=\gamma(x^2+y^2+z^2)$, $x+y+z=0$ and $d^2=\tfrac\gamma3x^2$, minimising $y^2+z^2$ at $y=z=-x/2$ gives
$$\sigma\ \le\ \frac{x^2/3}{x^2+x^2/2}\ =\ \frac29\qquad\text{on }(2,2)\text{ blocks},\qquad \sigma=0\text{ elsewhere},$$
attained on L133's own maximiser $(2,-1,-1)$. So per block, with $\mu=\tfrac2{n-2}$:

| block | $\max L_e$ off orbit | $\max\sigma$ | $\max Q/\lVert H\rVert^2$ |
| --- | --- | --- | --- |
| $(2,2)$ four-set | $\mu=\tfrac2{n-2}$ | $\tfrac29$ | $3\theta_0(\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert$ |
| pair, four-set $(3,1)$ and $(4,0)$, diagonal | $\lambda_m=\tfrac{m-2}{2(m-1)}$ | $0$ | $-\dfrac{3\theta_0}{n-2}$ |

*Screened* across $n=12,\dots,10^6$: the first row is between $-1.09$ and $-1.74$ while the second is $-3\theta_0/(n-2)$, so **the pair block binds at every $n\ge12$** and
$$\boxed{\ \min_{H}\,Q(H)/\lVert H\rVert^2\;=\;-\frac{3\theta_0(n)}{n-2}\ }$$
exactly, attained on the within-factor $S^2_0$ direction where $d(H)=0$. The lemma's $c_n=2.464\theta_0/(n-2)$ is therefore valid, is $82.1\%$ of the truth, and can be replaced by $3\theta_0/(n-2)$, **unimprovable**, since it is attained. The block argument needs no crossing, no $\kappa_n^{\mathrm{Hess}}$ and no part (a).

*Two things follow for the record.* The pencil bound is not the binding constraint at $W^*$ at all, it is needed only to control the $(2,2)$ blocks, where the Hessian is an order of magnitude more negative than the constant being proved, so [Lemma L133](../findings/second-order.md)'s whole apparatus is spent buying a factor the spectral bound already had. And the $1/n$ decay the lemma warns about is **intrinsic**: it is $\tfrac12-\lambda_m=\tfrac1{n-2}$, the balanced product's own off-orbit spectral gap, so no sharpening of L141 removes it and the radius question is entirely about the third-order constant $C$.

## 7. What I could not break

- The $\tfrac12$ in (a) is not an artefact of the multiplier's range being *centred* by luck: the range has length $1$ in either convention, and the bound is the half-length. A different $f$ with a longer multiplier range would give a different constant, and none of the record's alternatives has one.
- (a) is not vacuous. $D(\mathrm{Alt}W_-)[H]$ is nonzero on the $(2,2)$ blocks at $W^*$ with ratio $\sqrt{2/9}=0.4714$, and [Lemma L140](../findings/route-a.md) exhibits a family where $\lVert Z+\tfrac12H\rVert^2=\tfrac14\lVert H\rVert^2$ exactly, so the estimate before $\mathrm{Alt}$'s own loss is tight.
- L133's Step 4 mediant step ("a ratio of sums with nonpositive numerators and nonnegative denominators is at most the largest per-block ratio") is correct, blocks with zero denominator included: they add a nonpositive quantity to the numerator and nothing to the denominator.
- $\kappa_n^{\mathrm{Hess}}$'s sup over $T_{W^*}S$ equals its sup over $T_{W^*}\mathcal O^\perp$, since orbit directions have both $\mathrm{Hess}=0$ and $d=0$ and the decomposition is orthogonal, so nothing is lost or illegitimately gained in transferring L133 to (b)'s domain.

## 8. Required corrections, in the order they should be made

1. **(a)'s statement**: replace "any tensor whose spectral parts are differentiable at it" with "any $V\in\mathcal W_n$", state the bound for the one-sided directional derivative, and add [Lemma L140](../findings/route-a.md)'s $K\times K$ line, $Z_{KK}+\tfrac12H_{KK}=\tfrac12\lvert D\rvert$ with $D=P_KHP_K$. Without it the lemma is strictly weaker than L140; with it, it is the generalisation the title advertises.
2. **(a)'s title and its "What (a) buys" paragraph**: as they stand they claim coverage the hypothesis denies, at the competitor and at every padded critical point. Correction 1 makes them true; short of it, they must be withdrawn.
3. **(b)'s domain**: "$T_{W^*}S\cap T_{W^*}\mathcal O^\perp$". The radial direction is a live counterexample otherwise.
4. **(b)'s monotonicity clause**: "$B_1$ increases in $\sigma$ and $B_2$ decreases, so the lower envelope peaks at the crossing."
5. **Delete the claim that $\sigma\le\tfrac14$ is what makes (b) finite.** (a) is not used in (b). If a role for $\sigma$'s ceiling is wanted, the honest one is $\sigma\le\tfrac29$ at $W^*$ from L133's Step 2, which is a strictly better ceiling and which does sharpen the constant.
6. **Optional but cheap**: replace $2.464$ by $3$ per [§6](#6-the-constant-is-2464-when-it-could-be-3), and record that the minimum is attained, so $c_n=3\theta_0(n)/(n-2)$ is the exact off-orbit definiteness constant of the penalised form at the balanced orbit.

## Screens run

Both are arithmetic on closed forms already in the record, run to check numbers I was about to write down, and neither is offered as evidence for a positive claim.

1. $\lvert\kappa_n^{\mathrm{Hess}}\rvert/\lvert\kappa_n\rvert$ at $n=12,14,\dots,10^6$ from $\kappa_n^{\mathrm{Hess}}=\tfrac{27}2\theta_0(\tfrac2{n-2}-\tfrac12)$ and $\kappa_n=9(\sqrt{3/2}-\theta_0)$: monotone $49.27\to5.598$, confirming L133's infimum and the direction of its use; and $\sigma^*$ at $n=12$ equal to $0.652$.
2. The per-block table of [§6](#6-the-constant-is-2464-when-it-could-be-3) at the same $n$, confirming that the pair block binds at every $n\ge12$.
