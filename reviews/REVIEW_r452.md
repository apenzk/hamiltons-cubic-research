# Review r452, adversarial audit of [Lemma L149](../findings/second-order.md): the $w$-sweep, the margin bound it rests on, and the branch it drops

*Reviewer r452, 2026-09-03, cold adversarial brief. Target: [Lemma L149](../findings/second-order.md), the sweep over $w=\lVert H_r\rVert$ that claims to remove the quantifier error which refuted [Lemma L147](../findings/second-order.md). Read in full: [Lemma L149](../findings/second-order.md), [Lemma L148](../findings/second-order.md), [Lemma L147](../findings/second-order.md), [Lemma L146](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md), [Lemma L143](../findings/bounds.md), [conventions.md](../findings/conventions.md), [REVIEW_r447.md](REVIEW_r447.md), [REVIEW_r450.md](REVIEW_r450.md), [REVIEW_r451.md](REVIEW_r451.md). **Analysis only** ([analysis-only.md](../.claude/rules/analysis-only.md)): every derivation below is by hand. One screen is reported, built from the defining expressions and checked against closed forms derived separately, so it could have failed; it is evidence for nothing. Working: [agent_logs/r452-L149.log](../agent_logs/r452-L149.log).*

## Verdicts, per claim

| # | claim | verdict |
|---|---|---|
| 1 | $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$ | **CONFIRMED.** [Lemma L146](../findings/second-order.md)'s bound is homogeneous, so $\lVert H_s\rVert_F=\sqrt{1-w^2}<1$ only helps; the split is applied to a *norm*, never to the nonlinear map, so no additivity of $W\mapsto\mathrm{Alt}(W_-)$ is being assumed (B1) |
| 2 | $c(H)\gtrsim c_p+w^2$, from $L_e$ scalar on each summand with off-summand eigenvalues bounded below | **PLAUSIBLE, and FALSE as literally written.** "The margin summand $S^2_0(\mathbb R^m)$" is singular; there are **two** copies, and with $H_r$ containing the second copy the bound fails by a factor $n$ at $w=1$. Under the two-copy reading of [r450](REVIEW_r450.md) D2 and [r451](REVIEW_r451.md) A1 it holds, with an absolute constant, **for $m\ge5$ only** (B2, B3) |
| 3 | $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$ | **CONFIRMED as an upper bound**, inherited unchanged from [r450](REVIEW_r450.md) D1 and [r451](REVIEW_r451.md) A2; the Riesz decomposition survives the enlarged disc (B4) |
| 4 | $\operatorname{sign}g'(w)=\operatorname{sign}(wA-Bc)$, single interior minimum at $w^*=Bc/A$ | **CONFIRMED**, re-derived cold (B5) |
| 5 | the displayed $g(w^*)=\sqrt{c+c^2}\big/\big(A+Bc/A\cdot B/B\big)=\tfrac1n\sqrt{\kappa/(1+\kappa)}$ | **REFUTED as displayed, CONFIRMED as valued.** The denominator is $A+Bc/A=A+w^*$ where it must be $A+Bw^*=A+B^2c/A$; the written denominator returns $\sqrt{\kappa(1+\kappa)}/n$, larger by $(1+\kappa)\approx5.2$. The numerator $\sqrt{c+c^2}$ is also wrong ($c+w^{*2}=c+B^2c^2/A^2$, which equals $c+c^2$ only because $B^2/A^2=n$ cancels one $n$). **The stated value is right**, and the clean form is $g(w^*)=\sqrt c\big/\sqrt{A^2+B^2c}$ (B5) |
| 6 | the second branch is $\Theta(n^{-1})$ **uniformly in $w\in[0,1]$** | **CONFIRMED for the displayed surrogate, REFUTED as a statement about the chain's branch.** The formula $\sqrt{c_p+w^2}/(n^{1/2}+nw)$ has $n$-independent max/min ratio $2.29$ on $[0,1]$. But at $w=0$ [Lemma L148](../findings/second-order.md) gives $A\equiv0$, so the chain's actual second branch $\sqrt{c(H)}/\lVert A''\rVert$ is **unbounded** there, not $\Theta(n^{-1})$. Only $\Omega$ is proved, and the direction of the gap is the one that could raise the ceiling (B6) |
| 7 | the elimination of $u$ is valid and holds uniformly in $w$ | **CONFIRMED.** $f(u^*)=2c/(S+\sqrt{S^2+a^2c})$ exactly, hence $\Theta(\min(c/S,\sqrt c/a))$ with **absolute** constants; iterated infima over a product domain commute; and the true domain $u\lesssim w$ is *smaller*, so the relaxation is conservative (B7) |
| 8 | the chain is "the two-branch chain" | **REFUTED.** The validity branch $\rho/2$ is missing. [r450](REVIEW_r450.md) item 6 and [r451](REVIEW_r451.md) item 6 both instructed that it be added; **dropping a branch from a $\min$ in a lower bound is not conservative** (B8) |
| 9 | $r_n\gtrsim n^{-1-\beta}$ over **all** directions, with $\Theta(n^{-1})$ the ceiling | **CONFIRMED as an $\Omega$**, under the repairs of B2 and B8, and the ceiling is unconditional from $c_p/S\le3/(n-2)$. This is the lemma's real content and it does close [r451](REVIEW_r451.md)'s counterexample (B9) |
| 10 | $w^*$ "is exactly the direction that refuted [Lemma L147](../findings/second-order.md)" | **PLAUSIBLE, on a conflation.** [r451](REVIEW_r451.md)'s counterexample is $u\asymp n^{-1/2}$; $w^*$ is a weight in a different decomposition. The substantive point is sound and stronger than stated (B9) |
| 11 | vacuity | **UNCHANGED from [r447](REVIEW_r447.md) F6**, and L149 records none of it although both parent reviews asked for a line (B10) |

**The one-line verdict: PLAUSIBLE, the headline survives as an $\Omega$, and the step the brief trusts least is sound only under a reading the lemma does not write.** The margin bound is correct when "the margin summand" means both $S^2_0$ copies and $m\ge5$; as written, with one copy, it is false by a factor $n$. The calculus is right, its display is not. The uniformity is right for the formula displayed and wrong for the branch it stands in for, because [Lemma L148](../findings/second-order.md) (eight lines above), makes that branch vacuous at $w=0$. And a branch that both parent reviews ordered added is still absent.

---

## B1, the triangle inequality step, and why the nonlinearity objection does not bite

Three separate things are asked of this step and all three pass.

- **Homogeneity.** [Lemma L146](../findings/second-order.md) gives $\lVert H\rVert_{op}\le\lVert H\rVert_F/\sqrt{m-1}$ for $H$ in the summand. That is a homogeneous inequality in $H$, so at $\lVert H_s\rVert_F=\sqrt{1-w^2}\le1$ it reads $\lVert H_s\rVert_{op}\le\sqrt{1-w^2}/\sqrt{m-1}\le\Theta(n^{-1/2})$. **The sub-unit Frobenius norm makes the bound smaller, never larger**; the brief's worry runs the safe way. The same holds if $H_s$ is spread over both copies: $\lVert H_1\rVert_{op}+\lVert H_2\rVert_{op}\le(\lVert H_1\rVert_F+\lVert H_2\rVert_F)/\sqrt{m-1}\le\sqrt2\,\lVert H_s\rVert_F/\sqrt{m-1}$, still $\Theta(n^{-1/2})$.
- **$\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F=w$** is the whole of the second term, as the brief says, and it is used only as an upper bound on $\lVert H\rVert_{op}$, hence a lower bound on $\rho$, hence an upper bound on $\lVert A''\rVert$, hence a lower bound on $r(H)$. **Every inequality in the chain points the same way**, so the looseness costs nothing but sharpness.
- **The additive split is on the norm, not on the map.** $W\mapsto\mathrm{Alt}(W_-)$ is nowhere decomposed. What is decomposed is the single scalar $\lVert H\rVert_{op}$, which enters only through the spectral-separation condition $\lvert z\rvert\lVert H\rVert_{op}<g_n/2$ defining the disc. The nonlinearity is handled entirely by Cauchy on that disc. **So the objection the brief raises is answered by the structure of the argument rather than by an estimate.**

**Does [Lemma L148](../findings/second-order.md) remove [Lemma L146](../findings/second-order.md) as an input?** No, and the two are about different quantities. [Lemma L148](../findings/second-order.md) says the *defect* vanishes on the margin summand; [Lemma L146](../findings/second-order.md) prices the *operator norm* there. In the mixed case the defect does not vanish, and $\lVert H\rVert_{op}$ still governs $\rho$ through $H_s$'s contribution. [Lemma L146](../findings/second-order.md)'s own closing note ("*it prices a quantity that is not present*"), is about its use inside the summand-local substitution of [Lemma L147](../findings/second-order.md), not about its use here. **[Lemma L149](../findings/second-order.md) uses it legitimately, and it is the one place in the chain where L146 is not displaced.** L148 bites elsewhere, at B6.

## B2, the margin bound: the eigenvalue sweep, summand by summand

$L_e$ is scalar on each of [Lemma L27](../findings/nondegeneracy.md)'s ten summands, the summands are mutually orthogonal, and the margin is $c(H)=3\theta_0\big\langle(\tfrac12-L_e)H,H\big\rangle=\sum_j3\theta_0(\tfrac12-\lambda_j)\lVert H_j\rVert^2$. At the balanced point $p=q=m$, $n=2m$, [Lemma L27](../findings/nondegeneracy.md)'s displayed identity $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ gives $\tfrac12-\mu=\frac{m-3}{2(m-1)}$, hence $\mu=\frac1{m-1}$, and $\tfrac12-\lambda_m=\frac1{2(m-1)}=\frac1{n-2}$. The complete list:

| summand | $\lambda$ | margin $3\theta_0(\tfrac12-\lambda)$ | status |
|---|---|---|---|
| $\langle W\rangle$ | $1$ | $-\tfrac32\theta_0$ | **excluded** by $T_{W^*}S$ (radial) |
| $\mathbb R^p\otimes\mathbb R^q$ | $\tfrac12$ | $0$ | **excluded** by $T_{W^*}\mathcal O^\perp$, this *is* the orbit tangent |
| $S^2_0(\mathbb R^p)$ | $\lambda_m=\frac{m-2}{2(m-1)}$ | $\dfrac{3\theta_0}{n-2}=c_p=\Theta(1/n)$ | the margin summand |
| $S^2_0(\mathbb R^q)$ | $\lambda_m$ | $c_p=\Theta(1/n)$ | **the second copy, see B3** |
| $S^2_0\otimes S^2_0$ | $+\mu=\frac1{m-1}$ | $3\theta_0\frac{m-3}{2(m-1)}\to\tfrac32\theta_0$ | smallest off-summand margin |
| $\Lambda^2\otimes\Lambda^2$ | $-\mu$ | $3\theta_0\frac{m+1}{2(m-1)}\to\tfrac32\theta_0$ | |
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $0$ | $\tfrac32\theta_0$ | the four $L_e=0$ summands |

**The orbit summand is properly excluded.** [Lemma L27](../findings/nondegeneracy.md) proves $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ is *attained exactly on the orbit tangent* and $\dim E(\tfrac12)=pq=\dim\mathcal O$, so the zero-margin eigenspace is precisely $T_{W^*}\mathcal O$ and the domain $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ removes all of it and nothing else. **Eight summands remain, and every one has strictly positive margin for $m\ge4$.**

**So the "nonnegative combination" claim is true**, and with $C:=\min_{j\ne s}3\theta_0(\tfrac12-\lambda_j)=3\theta_0\frac{m-3}{2(m-1)}$,

$$c(H)\;=\;c_p(1-w^2)+\sum_{j\ne s}3\theta_0(\tfrac12-\lambda_j)\lVert H_j\rVert^2\;\ge\;c_p+(C-c_p)w^2\;\ge\;\min\!\big(1,\tfrac C2\big)\,(c_p+w^2)$$

for $n$ large enough that $c_p\le C/2$. **The bound holds with an absolute constant, and the smallest off-summand margin is the $+\mu$ summand $S^2_0\otimes S^2_0$**, which is what the brief asks be named.

**The $(3,3)$ question, answered.** At $m=3$, $\mu=\tfrac12$ exactly, the $+\mu$ summand's margin is **zero**, and $C=0$: the bound $c(H)\gtrsim c_p+w^2$ **fails outright** at $n=6$. That case is excluded by [Lemma L27](../findings/nondegeneracy.md)'s own hypothesis $(p,q)\ne(3,3)$, and it is excluded for exactly this reason, the eigenvalue coincidence is a theorem there, not an artefact. **At $m=4$ the constant degenerates a second way**: $\lambda_4=\mu=\tfrac13$, so the $+\mu$ summand *ties* with $S^2_0$ at margin $c_p$, and $C=c_p=\Theta(1/n)$ rather than $\Theta(1)$. The bound then gives only $c(H)\gtrsim c_p$, losing the $w^2$. **From $m\ge5$ onwards $C\ge0.9$ and rises to $\tfrac32\theta_0$**, which is [Lemma L146](../findings/second-order.md)'s own $m\ge5$ condition arriving here for a second reason. Since the claim is asymptotic this costs nothing, but **the lemma states the bound with no range at all**, and it is false at $n=6$ and vacuous at $n=8$.

> **Screen** (self-constructed, seconds; evidence for nothing, and it can fail, the margins are built from [Lemma L27](../findings/nondegeneracy.md)'s displayed $\tfrac12-\mu$ expression, not from the closed forms $\mu=\frac1{m-1}$ and $\tfrac12-\lambda_m=\frac1{n-2}$ they are compared against). Minimum off-summand margin: $0$ at $m=3$; $0.5728=c_p$ at $m=4$; $0.900$ at $m=5$; $1.112$ at $m=6$; $1.526$ at $m=10$; $2.004$ at $m=50$, against $\tfrac32\theta_0\to2.121$. The $S^2_0$ column reproduces $3\theta_0/(n-2)$ to machine precision at every $m$, which is the check that the two routes to $c_p$ agree.

## B3, the load-bearing defect: there are two $S^2_0$ copies and the lemma names one

[Lemma L149](../findings/second-order.md) writes: *"Write $H=H_s+H_r$ with $H_s$ in the margin summand $S^2_0(\mathbb R^m)$ and $H_r$ its complement."* **Singular.** [Lemma L27](../findings/nondegeneracy.md)'s decomposition carries $S^2_0(\mathbb R^p)$ **and** $S^2_0(\mathbb R^q)$, both at eigenvalue $\lambda_m$ when $p=q=m$. [Lemma L146](../findings/second-order.md), four entries above in the same file, says so explicitly: *"the two $S^2_0(\mathbb R^m)$ summands"*. So does [r450](REVIEW_r450.md) D2 (*"outside the two $S^2_0(\mathbb R^m)$ copies"*) and so does [r451](REVIEW_r451.md) A1 (*"$H_s$ in the joint $\lambda_m$-eigenspace"*). **[Lemma L149](../findings/second-order.md) is the only one of the four that writes one summand.**

**Taken literally the bound is false, and by the full factor $n$.** Let $H$ lie entirely in $S^2_0(\mathbb R^q)$, the copy the singular reading puts inside $H_r$. Then $w=1$ and $c(H)=c_p=\Theta(1/n)$, against a claimed $c(H)\gtrsim c_p+1=\Theta(1)$. **The margin bound fails by $\Theta(n)$ on a direction of the sphere, and the failure is not marginal, it is the whole of the improvement the lemma claims.**

**The conclusion survives the repair, and it survives even the literal reading, for a reason worth recording.** On that same direction $\lVert H\rVert_{op}=O(n^{-1/2})$ by [Lemma L146](../findings/second-order.md) (it is a margin-summand direction) so $\lVert A''\rVert=O(n^{1/2})$ and the second branch is $\sqrt{c_p}/n^{1/2}=\Theta(n^{-1})$, while the first is $c_p/S=\Theta(n^{-1-\beta})$. **The direction that breaks the margin bound is caught by the operator-norm bound instead**, and it happens to land on exactly the same values. This is luck, not structure: the lemma's two facts are stated as independent and one of them is false, and if a successor re-uses the margin bound anywhere else the coincidence will not be there.

**The repair is one word.** Read $H_s$ as the projection onto the joint $\lambda_m$-eigenspace $S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)$, which is what both parent reviews wrote and what B2's sweep uses. **Under that reading the claim is CONFIRMED for $m\ge5$.**

## B4, a third margin, unstated: the chain needs the net margin, not the Hessian margin

$\kappa_n<0$ for $n\ge12$, so the tube functional is $F(t)=P-\theta_0+\lvert\kappa_n\rvert\delta^2$ and the penalty **works against** the margin at second order: with $\lVert A(t)\rVert\le ut+O(t^2)$ the $t^2$ coefficient of $F$ is $-c(H)+\lvert\kappa_n\rvert u^2$, not $-c(H)$. [r447](REVIEW_r447.md) F2 handles this by carrying $u\le\tfrac{\sqrt2}3v$ from [Lemma L133](../findings/second-order.md) step 2 and checking that the $(2,2)$-block margin beats $\tfrac29\lvert\kappa_n\rvert$, the computation returning $-2.06$ to $-1.71$ at $n=200$.

**[Lemma L149](../findings/second-order.md) states only the Hessian margin $3\theta_0(\tfrac12-\lambda)$ and never mentions the subtraction.** To inherit [r447](REVIEW_r447.md)'s bookkeeping it needs $u\lesssim v\lesssim w$, the first from [Lemma L133](../findings/second-order.md), the second because $v=0$ on the margin summand ([Lemma L146](../findings/second-order.md)'s diagonality) so $v$ is supported in the complement. [r451](REVIEW_r451.md) A1 asserts the chain "$u\le\tfrac{\sqrt2}3v\lesssim w$" in one clause without proving the second link; **[Lemma L149](../findings/second-order.md) drops the clause entirely.** Numerically it is comfortable, $\tfrac29\lvert\kappa_n\rvert\to0.379$ against $C\ge0.9$ at $m\ge5$, so the net margin is still $\gtrsim c_p+w^2$. **The step is sound and undeclared**, which matters because it is the only place the two decompositions of $H$ (by [Lemma L27](../findings/nondegeneracy.md) summand, and by $(2,2)$-block weight $v$) have to be compared, and nobody has compared them on the record.

**The Cauchy input itself I could not break.** $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert=O(\rho)$ survives the enlarged disc: the Riesz decomposition of [r450](REVIEW_r450.md) D1 and [r451](REVIEW_r451.md) A2 gives $O(\rho)\cdot O(1)+\Theta(g_n)\cdot O(\rho/g_n)$, and the second factor $\lVert\Pi(z)-\Pi(0)\rVert_F=O(\rho/g_n)=O(1/\lVert H\rVert_{op})$ is $O(n^{1/2})$ on the margin summand, large, but a projection difference in Frobenius norm may be as large as $O(n)$, so nothing is violated, and multiplying by $\lVert W^*\rVert_{op}=\Theta(g_n)$ returns $O(\rho)$. The Neumann condition $\rho\lVert H\rVert_{op}<g_n/2$ is what defines $\rho$, so it holds by construction. **The $1$-Lipschitz argument for $M$ is the one that does *not* transfer** ($W(z)$ is complex symmetric rather than Hermitian off the real axis) but the Riesz route needs no such thing and is the one both parents actually used.

## B5, the calculus: the sign is right, the displayed value is not, and the value it displays is

**The sign.** For $g(w)=\sqrt{c+w^2}/(A+Bw)$,

$$g'(w)=\frac{\frac{w}{\sqrt{c+w^2}}(A+Bw)-B\sqrt{c+w^2}}{(A+Bw)^2},$$

and multiplying the numerator by $\sqrt{c+w^2}>0$ gives $w(A+Bw)-B(c+w^2)=wA-Bc$. **$\operatorname{sign}g'=\operatorname{sign}(wA-Bc)$, CONFIRMED**, with the single interior stationary point $w^*=Bc/A$, a minimum since the sign changes $-\to+$. At $c=\kappa/n$, $A=n^{1/2}$, $B=n$: $w^*=\kappa n^{-1/2}$, as the lemma says.

**The displayed value.** The lemma writes

$$g(w^*)=\frac{\sqrt{c+c^2}}{A+Bc/A\cdot B/B}.$$

Both halves are wrong. The denominator is $A+Bw^*=A+B^2c/A$; what is written, $A+Bc/A$, is $A+w^*$, the $B/B$ cancels the factor that must survive. The numerator is $\sqrt{c+w^{*2}}=\sqrt{c+B^2c^2/A^2}$, which coincides with $\sqrt{c+c^2}$ only through the accident $B^2/A^2=n$ cancelling one power of $n$ in $c^2$. **Evaluated as displayed, the expression returns $\sqrt{\kappa(1+\kappa)}/n$, larger than the truth by the factor $1+\kappa\approx5.2$.**

**Recomputed from scratch, and the stated value is correct.** For any $A,B,c>0$,

$$c+w^{*2}=c\,\frac{A^2+B^2c}{A^2},\qquad A+Bw^*=\frac{A^2+B^2c}{A},\qquad\text{hence}\qquad \boxed{\;g(w^*)=\frac{\sqrt c}{\sqrt{A^2+B^2c}}\;}$$

At $c=\kappa/n$, $A=n^{1/2}$, $B=n$: $A^2+B^2c=n(1+\kappa)$ and $g(w^*)=\tfrac1n\sqrt{\kappa/(1+\kappa)}$, **the lemma's stated value, confirmed.** The closed form is also the right thing to record, because it shows the conclusion is insensitive to the unpinned constants: with $A=C_1n^{1/2}$ and $B=C_2n$ it reads $\tfrac1n\sqrt{\kappa/(C_1^2+C_2^2\kappa)}$, still $\Theta(1/n)$ for any fixed $C_1,C_2>0$. **The endpoints check too**: $g(0)=\sqrt\kappa/n$ and $g(1)=\sqrt{1+c}/(n^{1/2}+n)\sim1/n$.

> **Screen** (self-constructed, seconds; evidence for nothing, and it *can* fail, $g$ is built from its defining expression on a $4\times10^6$-point grid and compared against a closed form derived independently, so a wrong closed form would show). At $n\in\{10^2,10^3,10^4\}$ with $\kappa=3\theta_0=4.243$: the grid argmin equals $Bc/A$ to six digits, the grid minimum equals both $\sqrt c/\sqrt{A^2+B^2c}$ and $\tfrac1n\sqrt{\kappa/(1+\kappa)}$ to six digits, and the lemma's displayed denominator returns $4.72\times10^{-2}$ against a true $9.00\times10^{-3}$ at $n=100$. The ratio $\max_{[0,1]}g/\min_{[0,1]}g=2.28968$ **at every $n$**, which is the uniformity.

## B6, the uniformity claim is right about the formula and wrong about the branch, and [Lemma L148](../findings/second-order.md) is what breaks it

**As a statement about the displayed surrogate, CONFIRMED.** $g(w)=\sqrt{c_p+w^2}/(n^{1/2}+nw)$ never leaves $\Theta(1/n)$ on $[0,1]$: minimum $\tfrac1n\sqrt{\kappa/(1+\kappa)}$, maximum $\sqrt\kappa/n$ at $w=0$, ratio $n$-independent. That is one sign computation and it is correct.

**As a statement about the chain's second branch, REFUTED at $w=0$.** The branch is $\sqrt{c(H)}/\lVert A''(H)\rVert$, and $g(w)$ is a *lower bound* for it obtained by replacing $\lVert A''\rVert$ with an upper bound. At $w=0$ the direction lies in the margin summand, and [Lemma L148](../findings/second-order.md), **eight lines above [Lemma L149](../findings/second-order.md) in the same file**, proves $\mathrm{Alt}(W(t)_-)=0$ identically along the whole segment, so $A\equiv0$, $u=0$, $A''=0$ **exactly**. The defect branch is not $\Theta(n^{-1})$ there; it is absent, and the local radius is $c_p/\sup\lvert P\rvert$ outright ([r451](REVIEW_r451.md) A8 says precisely this). **The lemma asserts a $\Theta$ for a quantity its own immediate predecessor proves is unbounded.**

**Why this is not merely cosmetic.** The gap runs in the direction that could *raise* the ceiling. If $\lVert A''\rVert$ is $o(n^{1/2}+nw)$ near $w=0$ (and it is, since it is zero at $w=0$ and $A$ is continuous in $H$) then the second branch exceeds $\Theta(n^{-1})$ on a neighbourhood of the margin summand, and $\Theta(n^{-1})$ is not the *branch's* ceiling there. [r451](REVIEW_r451.md)'s closing note names this as the one live resource: *"on a direction of small off-summand weight $w$ the true $M$ may be $O(w\rho)$, which would raise the ceiling above $n^{-1}$. Nobody has tried it."* **[Lemma L149](../findings/second-order.md) writes $\Theta$ over exactly that opening.** The *route's* ceiling is unaffected, because it comes from the $P$-side branch (B9), but the lemma's sentence "the second branch is $\Theta(n^{-1})$ uniformly" is the wrong quantifier on the wrong object, and it is the third time this record has written $\Theta$ where only $\Omega$ is proved ([Lemma L145](../findings/second-order.md) step 4, [Lemma L147](../findings/second-order.md), here).

## B7, two variables, and the order of minimisation is fine

The brief's objection, *"a minimum over two variables is not the minimum over one then the other unless the order is justified"*, does not bite, for three reasons stated in increasing order of importance.

- **Iterated infima commute on a product domain.** $\inf_{(u,w)\in U\times W}F=\inf_w\inf_uF=\inf_u\inf_wF$, always. There is no order to justify.
- **The domain is *not* a product, and the relaxation is conservative.** $u$ and $w$ are both functions of $H$, with $u\le\tfrac{\sqrt2}3v\lesssim w$ (B4). Minimising over the product $[0,\tfrac12]\times[0,1]$ enlarges the feasible set, so the resulting infimum is **smaller**, and a lower bound on it is still a lower bound on $r_n$. **The looseness runs the safe way.** It is visible: at $w\ll\sqrt{c_p}$ the unconstrained $u^*\le\sqrt{c_p}$ can exceed $Cw$, so the true minimum over $u\in[0,Cw]$ sits at the endpoint and is *larger* than $f(u^*)$.
- **The $u$-elimination's constants are absolute, hence uniform in $w$.** From $2u^*(S+au^*)=a(c+u^{*2})$,
  $$f(u^*)=\frac{2u^*}{a}=\frac{2\big(\sqrt{S^2+a^2c}-S\big)}{a^2}=\frac{2c}{S+\sqrt{S^2+a^2c}},$$
  the last form by rationalising, and since $S+\sqrt{S^2+a^2c}\in\big[\max(2S,a\sqrt c),\,2S+a\sqrt c\,\big]$,
  $$\min\!\Big(\frac c{2S},\frac{\sqrt c}a\Big)\;\le\;f(u^*)\;\le\;2\min\!\Big(\frac c{2S},\frac{\sqrt c}a\Big).$$
  **The $\Theta$ in [r450](REVIEW_r450.md) D3's collapse carries constants $1$ and $2$, independent of $c$, $S$, $a$ and therefore of $w$.** So the two-branch form $\min(c/S,\sqrt c/a)$ is legitimate at every $w$ simultaneously, and the outer minimisation $\min_w\min(F,G)=\min(\min_wF,\min_wG)$ is elementary. **CONFIRMED.**

## B8, the chain is missing a branch, and both parent reviews ordered it added

[r450](REVIEW_r450.md) D7 and [r451](REVIEW_r451.md) A4 both establish that the Cauchy remainder at intermediate base points needs $t\le\rho/2$, so the honest chain carries a third argument:

$$r(H)\;\gtrsim\;\min\Big(\frac{c(H)}{S},\ \frac{\sqrt{c(H)}}{\lVert A''\rVert},\ \frac{\rho(H)}2\Big).$$

[r450](REVIEW_r450.md)'s item 6 (*"Add the validity branch $\rho/2$"*) and [r451](REVIEW_r451.md)'s item 6 (*"Add the validity cap $r_n\le\rho/2$ as a third argument of the $\min$"*), are the same instruction, given twice. **[Lemma L149](../findings/second-order.md) writes "the two-branch chain reads" and omits it.** Dropping an argument from a $\min$ inside a **lower** bound is not a conservative simplification: it makes the asserted lower bound larger than what is proved.

**It is harmless at the level of orders, and only there.** $\rho(H)=\Theta(g_n)/\lVert H\rVert_{op}\ge\Theta(g_n)/(\Theta(n^{-1/2})+w)$, so $\inf_{w\in[0,1]}\rho/2=\Theta(g_n)=\Theta(n^{-1})$, attained at $w\asymp1$. The three-branch minimum is therefore $\min(\Theta(n^{-1-\beta}),\Theta(n^{-1}),\Theta(n^{-1}))=\Theta(n^{-1-\beta})$ for $\beta\ge0$, the lemma's stated conclusion. **But at $\beta=0$ all three branches are $\Theta(n^{-1})$ and the constants decide**, and the lemma's closing paragraph acknowledges only the Cauchy constants, not the third constraint that shares the value. *The lemma is right that the ceiling does not depend on the constants; it is silent on the fact that whether anything at all is proved at $\beta=0$ depends on three of them at once.*

## B9, what the lemma actually establishes, which is more than its wording

**The ceiling is unconditional, and the lemma's reason for it is correct.** $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$ and $c_p=3\theta_0/(n-2)$ give $c_p/S\le3/(n-2)=\Theta(n^{-1})$ at every $n$, with no bound on $P$ needed. **CONFIRMED**, as in [r450](REVIEW_r450.md) D4 and [r451](REVIEW_r451.md) A4.

**The counterexample that refuted [Lemma L147](../findings/second-order.md) is genuinely closed, and by a sharper argument than the one written.** [r451](REVIEW_r451.md) A1's direction is *"a direction whose defect modulus is $u\asymp n^{-1/2}$ while its margin is still $\Theta(1/n)$, at which $\lVert A''\rVert=\Theta(n)$ would restore $n^{-3/2}$."* The sweep kills it by showing the pairing is unreachable:

$$\lVert A''\rVert=\Theta(n)\ \Longrightarrow\ \lVert H\rVert_{op}=\Theta(1)\ \Longrightarrow\ w=\Theta(1)\ \Longrightarrow\ c(H)=\Theta(1),$$

the second implication by the triangle inequality $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ and the third by B2. **A direction cannot have a $\Theta(1/n)$ margin and a $\Theta(n)$ second derivative at once**, so the feared $\sqrt{c}/a=\Theta(n^{-1/2})/\Theta(n)=\Theta(n^{-3/2})$ never occurs; at $w=\Theta(1)$ the branch is $\Theta(1)/\Theta(n)=\Theta(n^{-1})$. **This is the lemma's real content and it is correct.**

**The lemma's own gloss on it is a conflation.** *"$w^*=\Theta(n^{-1/2})$ is [r451](REVIEW_r451.md)'s mixed direction"* identifies a weight in the [Lemma L27](../findings/nondegeneracy.md)-summand decomposition with [r451](REVIEW_r451.md)'s defect modulus $u$, different quantities in different decompositions, related only through the unstated $u\lesssim w$ of B4. Worse, at $w^*=\Theta(n^{-1/2})$ the sweep gives $\lVert A''\rVert=O(n^{1/2})$, whereas [r451](REVIEW_r451.md)'s direction was hypothesised to carry $\lVert A''\rVert=\Theta(n)$. **They are not the same direction; the sweep's point is that [r451](REVIEW_r451.md)'s direction does not exist.** Saying so is stronger than what the lemma says, and does not require the identification.

## B10, vacuity: unchanged, and not recorded

**Not vacuous logically.** $\kappa_n<0$ for $n\ge12$ makes the tube statement $P+\lvert\kappa_n\rvert\delta^2\le\theta_0$ strictly stronger than local maximality, so the balanced orbit is a genuine equality case ([r447](REVIEW_r447.md) F6). [Lemma L149](../findings/second-order.md) changes nothing here.

**Vacuous as a gain, exactly as before, and the three comparisons the brief asks for all come out the same way.**

| comparand | order | what the $\Theta(n^{-1})$ tube does |
|---|---|---|
| nearest other critical orbit $S^{m-1}\times S^{m+1}$ | $\Theta(1)$ ([I20](../plan.md)) | contains no competitor, as a tube of radius $n^{-3/2}$ did not, and as [r443](REVIEW_r443.md) D6 notes one of radius $\tfrac12$ would not |
| coverage of the sphere | orbit $\dim\Theta(n^2)$ inside $S^{\Theta(n^4)}$ | vanishing fraction at $n^{-1}$ and at $n^{-3/2}$ alike |
| spectral gap $g_n$ | $\Theta(n^{-1})$ | **the tube now has the order of $g_n$ itself**, a fixed fraction of the smallest analyticity disc, which is where the Cauchy constants stop being absolute |

**The third row is the one thing [Lemma L149](../findings/second-order.md) changes relative to [r447](REVIEW_r447.md) F6**, and it changes it for the worse: at $n^{-3/2}$ the tube was strictly inside the disc by a factor $n^{-1/2}\to0$; at $n^{-1}$ it is not. The lemma's closing paragraph says this correctly. **What it omits is that both parent reviews asked for a line on what the exponent buys**, [r450](REVIEW_r450.md) D8 and [r451](REVIEW_r451.md) A9, the latter as its item 8, and there is none. *A lemma whose Gate 2 is owed should not silently drop the two findings its own parents flagged as the reason the result matters less than it looks.*

**Is the improvement itself vacuous?** No. It removes a live counterexample (B9), and it converts a summand-local claim into a whole-space one, which is what [r450](REVIEW_r450.md) item 4 and [r451](REVIEW_r451.md) item 4 asked for. **The sweep is the right piece of work; the entry recording it overstates it in four places.**

---

## What I could not break

- **The eigenvalue sweep.** Every one of [Lemma L27](../findings/nondegeneracy.md)'s ten summands has been computed; the smallest off-summand margin is the $+\mu$ summand's $3\theta_0\frac{m-3}{2(m-1)}$, which is $\Theta(1)$ for $m\ge5$, and the orbit summand is removed exactly by $T_{W^*}\mathcal O^\perp$ with nothing else in the $\tfrac12$-eigenspace.
- **The triangle inequality and its homogeneity** (B1), including the objection about $\lVert H_s\rVert_F<1$ and the one about decomposing a nonlinear map.
- **The sign computation and the minimiser** (B5); and the *stated* value of $g(w^*)$, which is correct despite a display that is wrong twice.
- **The $u$-elimination**, with absolute constants, hence uniform in $w$; and the commutation of the iterated infima (B7).
- **The ceiling $\Theta(n^{-1})$**, unconditionally, from the $P$-side branch alone.
- **The closure of [r451](REVIEW_r451.md)'s counterexample** (B9), which is the lemma's purpose and which it achieves.

## What this audit did not check

[Lemma L27](../findings/nondegeneracy.md)'s multiplicity-freeness and the derivation of its ten eigenvalues, [Lemma L133](../findings/second-order.md)'s $u\le\tfrac{\sqrt2}3v$, [Lemma L141](../findings/second-order.md)'s $c_p$, [Lemma L143](../findings/bounds.md)'s proof, [Lemma L146](../findings/second-order.md)'s corrected extremal problem, and [Lemma L148](../findings/second-order.md)'s diagonality argument are taken as given; each carries its own Gate 2 except L148, whose Gate 2 is owed and which B6 leans on. Whether $\lVert A''\rVert$ is **saturated** at $O(M/\rho^2)$, [r443](REVIEW_r443.md)'s open item (iii), is untouched, so everything above bounds what this chain can prove and not the true tube radius. **The link $v\lesssim w$ between the two decompositions of $H$ (B4) is asserted nowhere on the record and is not proved here either**; it is needed for the $\lvert\kappa_n\rvert u^2$ subtraction and it is the one genuinely open input.

## What to change

1. **Write "the joint $\lambda_m$-eigenspace $S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)$", not "the margin summand $S^2_0(\mathbb R^m)$."** With one copy the margin bound is false by a factor $n$ on the second copy (B3). This is the only change that affects whether the lemma is true.
2. **State the range.** $c(H)\gtrsim c_p+w^2$ holds for $m\ge5$; the off-summand constant is **zero** at $m=3$ (where $\mu=\tfrac12$, [Lemma L27](../findings/nondegeneracy.md)'s excluded case) and degenerates to $c_p$ at $m=4$ (where $\lambda_4=\mu$) (B2).
3. **Fix the display of $g(w^*)$** and replace it with the closed form $g(w^*)=\sqrt c\big/\sqrt{A^2+B^2c}$, which is right for all $A,B,c$ and shows the value is insensitive to the unpinned Cauchy constants (B5).
4. **Downgrade the uniformity claim to $\Omega$, and say why.** The chain's second branch is *unbounded* at $w=0$ by [Lemma L148](../findings/second-order.md); $\Theta(n^{-1})$ describes the surrogate $\sqrt{c_p+w^2}/(n^{1/2}+nw)$, not the branch. Record that the slack near $w=0$ is [r451](REVIEW_r451.md)'s named live resource for raising the ceiling (B6).
5. **Add the validity branch $\rho/2$**, as [r450](REVIEW_r450.md) item 6 and [r451](REVIEW_r451.md) item 6 both instructed, and note that at $\beta=0$ all three branches coincide at $\Theta(n^{-1})$ (B8).
6. **Declare the $\lvert\kappa_n\rvert u^2$ subtraction** and the chain $u\le\tfrac{\sqrt2}3v\lesssim w$ it needs, marking $v\lesssim w$ as unproved (B4).
7. **Restate the counterexample closure as an impossibility**, $\lVert A''\rVert=\Theta(n)\Rightarrow\lVert H\rVert_{op}=\Theta(1)\Rightarrow w=\Theta(1)\Rightarrow c(H)=\Theta(1)$, rather than as an identification of $w^*$ with [r451](REVIEW_r451.md)'s $u$ (B9).
8. **Carry one line on what the exponent buys**, which is nothing ([r447](REVIEW_r447.md) F6, [r450](REVIEW_r450.md) D8, [r451](REVIEW_r451.md) A9), and one on the fact that at $\Theta(n^{-1})$ the tube first reaches the order of $g_n$ (B10).
