# Verifier v12, Lemma L149's uniformity claim, its two inputs, the $\rho_n^{\mathrm{eff}}$ display, and the closed-form minimiser

**Standfirst.** The brief was cold: I read [ROUND_L149.md](ROUND_L149.md)'s dispatched block first and worked from the definitions, taking the imported lemmas at source ([Lemma L27](../findings/nondegeneracy.md), [Lemma L146](../findings/second-order.md), [Lemma L147](../findings/second-order.md), [Lemma L148](../findings/second-order.md)) and the constants from [conventions.md](../findings/conventions.md) and [route-a.md](../findings/route-a.md). **I did no numerical work, no script was run, and every value below is an exact evaluation of a closed form the record itself states.** Log: [agent_logs/verify-L149-v12.log](../agent_logs/verify-L149-v12.log). The dispatched fence was two lines short of the proof's $\square$; the coordinator supplied [findings/second-order.md](../findings/second-order.md):1214–1215 mid-round and those two lines are checked in §9.1.

## The claim table

| # | Claim as written | Verdict | Reason |
|---|---|---|---|
| 1 | Two $S^2_0(\mathbb R^m)$ summands at $p=q=m$, both carrying $\lambda_m$; $w$ is the weight outside both | **CONFIRMED** | L27's list at $p=q$ gives two non-isomorphic copies; the swap fixes $W^*$ and commutes with $L_e$, so the scalars coincide |
| 2 | $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ | **CONFIRMED AS ALGEBRA** | inequality holds; the stated reason for owing no $\sqrt2$ (Hilbert–Schmidt orthogonality), does not imply it, and the substitute comparison is exhibited at $n=12$ alone |
| 3 | $c(H)\ge c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$ | **CONFIRMED** | the coefficient derives exactly as (smallest off-summand margin) $-\,c_p$; sharp, with equality on an exhibited two-summand family, but two hypotheses are used and not stated |
| 4 | "**It is unsafe exactly on $n\in\{12,14\}$**" | **REFUTED AS STATED** | the stated range $m\ge5$ contains $n=10$, where the coefficient is $0.45$; and $\rho^{\mathrm{eff}}_{16}=0.98564<1$ by the block's own number |
| 5 | $\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big)$; the four $\rho_n^{\mathrm{eff}}$ values | **REFUTED AS STATED** | the four values reproduce exactly, but the identity has a negative right-hand side at $n=10$, which is in range |
| 6 | "the stationary point is outside $[0,1]$ at every dimension in range, and it also exceeds $w_0=(n-4)/n$" | **REFUTED** | $w^*=2\sqrt n/(n-8)$ is $0.745356$ at $n=20$ against $w_0=0.8$: inside the interval and below the kink, for every $n\ge18$ |
| 7 | the closed form "remains a **valid but lossy** lower bound, $15.5\%$ low at $n=12$" | **REFUTED AS STATED** | under the block's own penalised coefficient it *exceeds* the branch-2 minimum at $n=14$ ($0.0630546$ against $0.0614300$) and by $7.0\%$ asymptotically; and $15.5\%$ is not reproducible from the block's formulas under any of four readings |
| 8 | "At $\rho=0$, which is $m=4$, branch 2 degrades to $\Theta(n^{-3/2})$, so $m\ge5$ is load-bearing for the exponent" | **CONFIRMED AS ALGEBRA** | the counterfactual algebra is right; $m=4$ is the single dimension $n=8$, at which an asymptotic order is not defined, and $m\ge5$ is implied by the record's own $n\ge12$ |
| 9 | $\operatorname{sign}g'(w)=\operatorname{sign}(wA-Bc)$, single interior minimum at $w^*=Bc/A$, $g(w^*)=\sqrt c/\sqrt{A^2+B^2c}=\tfrac1n\sqrt{\kappa/(1+\kappa)}$, endpoints $\sqrt\kappa/n$ and $\asymp1/n$ | **CONFIRMED AS ALGEBRA** | every line is exact, but the whole proof is executed at coefficient $1$ (the form the block itself calls unsafe at $n\in\{12,14\}$) and the repaired case is delegated to the blockquote refuted in §7 |
| 10 | **LEMMA L149**, branch 2 $\Omega(n^{-1})$ uniformly in $w\in[0,1]$, branch 1 minimised at $w=0$, validity branch $\Omega(n^{-1})$, hence $r_n\gtrsim n^{-1-\beta}$ | **CONFIRMED** | every branch checks, and no minimum was distributed wrongly, but three hypotheses are used and not stated, and the positivity of $\rho^{\mathrm{eff}}_n$ over the range is asserted from four values |
| 11 | the headline chain $\lVert A''\rVert=\Theta(n)\Rightarrow\lVert H\rVert_{op}=\Theta(1)\Rightarrow w=\Theta(1)\Rightarrow c(H)=\Theta(1)$ | **CONFIRMED** | each arrow follows from the two bullets plus L147's $\lVert A''\rVert=O(1/\rho)$ and L145's $\rho\gtrsim\min(1,g_n/\lVert H\rVert_{op})$ |

## One-line summary

**The boxed conclusion stands and no direction falsifies it, but no written argument in the block bounds the repaired branch 2 below, the proof proves the disowned coefficient-$1$ form and the blockquote's closed form sits *above* the true minimum from $n=14$ on, and the smallest admissible dimension $n=10$ is mishandled three times.**

## 0. Conventions, fixed once

Quoted or fixed from the brief and the files it names.

- $n=2m$ at $p=q=m$; the statement's range $m\ge5$ is therefore even $n\ge10$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, [conventions.md](../findings/conventions.md), "*the closed form … and nothing more*". Exact values used: $\theta_0(10)=\tfrac{12}{10}=1.2$, $\theta_0(12)=\sqrt{220}/12=1.2360331$, $\theta_0(14)=\sqrt{312}/14=1.2616801$, $\theta_0(16)=\sqrt{420}/16=1.2808689$, $\theta_0(18)=\sqrt{544}/18=1.2957671$, $\theta_0(\infty)=\sqrt2$.
- $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, [route-a.md](../findings/route-a.md):196, negative for $n\ge12$, with $\lvert\kappa_{12}\rvert=0.1015938$ and $\lvert\kappa_n\rvert\uparrow9(\sqrt2-\sqrt{3/2})=1.705218$.
- $\lambda_m=(m-2)/(2(m-1))$ on $S^2_0(\mathbb R^m)$; $\mu=(n-2)/(2(p-1)(q-1))$, which at $p=q=m$ is $1/(m-1)$, [Lemma L26](../findings/nondegeneracy.md), [Lemma L27](../findings/nondegeneracy.md).
- $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$, [Lemma L146](../findings/second-order.md)'s Setting, "*Both reviewers confirmed the margin is exactly L145's $c_p$*".
- $\kappa$ in the brief's "$c=\kappa/n$": forced by $c=c_p$ to be $\kappa=3\theta_0n/(n-2)$, giving $\kappa_{12}=4.4497192$, $\kappa_{14}=4.4158804$, $\kappa\downarrow3\sqrt2=4.2426407$. **This is a different quantity from $\lvert\kappa_n\rvert$ above**, and the block uses the same letter for both.
- $\rho:=3\theta_0\frac{m-4}{2(m-1)}=3\theta_0\frac{n-8}{2(n-2)}$, the bullet's $w^2$-coefficient; $\rho_n^{\mathrm{eff}}:=\rho-\tfrac29\lvert\kappa_n\rvert$, the penalised one. $\rho(H)$ (a third use of the letter), is the analyticity radius, $\asymp\min(1,g_n/\lVert H\rVert_{op})$ with $g_n=\Theta(n^{-1})$.
- $g(w)=\sqrt{c+\rho w^2}/(A+Bw)$ with $A=n^{1/2}$, $B=n$; $S=\sup\lvert P\rvert=\Theta(n^\beta)$.

## The hypothesis inventory

**Carried by the statement.**

| Hypothesis | Used where | Status |
|---|---|---|
| $m\ge5$ | twice: it makes $\rho>0$, and it is exactly L146's own condition $\lambda_m>\mu$ | **used, and it is the same condition twice**, $\lambda_m>\mu\iff m-2>2$, so L146's range and $\rho>0$ coincide at $m=5$, which the block does not notice |
| $w\in[0,1]$ | the uniformity claim | used; forced by $w=\lVert H_r\rVert$ and $\lVert H\rVert_F=1$ |
| $p=q=m$ (balanced) | the two-copy set-up, $c_p$, $\rho$, L146's $n=2m$ | used throughout; the lemma has no content at $p\ne q$ |

**Imported, with their own hypotheses checked against the object.**

| Import | Its hypotheses | Checked at $p=q=m\ge5$ |
|---|---|---|
| [Lemma L27](../findings/nondegeneracy.md) | $p,q\ge3$, $(p,q)\ne(3,3)$ | satisfied ($m\ge5$); its ten-summand list and its scalar-per-summand conclusion are what the convex-combination bullet rests on |
| [Lemma L146](../findings/second-order.md) | $H$ the Weyl image of **one** $h\in S^2_0(\mathbb R^m)$, $\lVert H\rVert_F=1$, $n=2m$, and its own box's "$m\ge5$, where $\lambda_m>\mu$" | satisfied for one copy; **applied to the two-copy joint eigenspace**, which is outside its statement, see §2 |
| [Lemma L147](../findings/second-order.md) | $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)$ from a Cauchy estimate with $M=O(\rho)$ | used in the "Hence" line; hypotheses are internal to L147 and are not re-checked here |
| [Lemma L145](../findings/second-order.md) | $\rho(H)\asymp\min(1,g_n/\lVert H\rVert_{op})$, $g_n=\Theta(n^{-1})$ | used for the validity branch and for the headline chain's first arrow |
| [Lemma L148](../findings/second-order.md) | the defect vanishes identically on the margin summand | **not used, and it makes branch 2 vacuous at $w=0$**, harmless, since a slack branch inside a $\min$ is still a lower bound |

**Used but not stated.**

1. $H\perp W^*$. L27's list carries $\langle W\rangle$ at $L_e=1$, i.e. margin $3\theta_0(\tfrac12-1)=-\tfrac32\theta_0<0$. The bullet says "each summand of L27", and $\langle W\rangle$ is one of the ten.
2. $H\perp T_{W^*}\mathcal O$. The orbit summand carries margin $0$. The block writes "*The orbit summand is excluded cleanly, $E(\tfrac12)$ equals the orbit tangent by L27*", which establishes that the orbit is the **only** zero-margin summand; it does not exclude a direction from having a component there.
3. $\beta\ge0$. The conclusion $r_n\gtrsim n^{-1-\beta}$ needs branch 1 to be the smallest of the three; at $\beta<0$ it is the largest and the true bound is $\Omega(n^{-1})$, so the stated conclusion would be false. $\beta\ge0$ is [Lemma L147](../findings/second-order.md)'s ("$\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$ forces $\beta\ge0$") and is not restated here.

**Stated and never binding.** $m\ge5$ excludes $m=3,4$, i.e. $n=6,8$, both below the record's own $n\ge12$ threshold. Inside the range the record actually uses, the hypothesis is automatic.

**Asserted with no argument on file.** That $\rho^{\mathrm{eff}}_n>0$ for every even $n$ in range. The block gives four values and the word "**increasing**". Positivity is what makes branch 2 $\Omega(n^{-1})$ rather than $\Theta(n^{-3/2})$, by the block's own §"WHAT THE COEFFICIENT DOES BUY", so this is load-bearing. **This claim has no argument on file.**

## 1. The set-up: two copies, and $w$ as the weight outside both, CONFIRMED

At $p=q=m$, [Lemma L27](../findings/nondegeneracy.md)'s list contains $S^2_0(\mathbb R^p)$ and $S^2_0(\mathbb R^q)$ as separate summands, carrying $\lambda_m$ each. They are non-isomorphic as $O(m)\times O(m)$-representations ($S^2_0\boxtimes\mathbf1$ against $\mathbf1\boxtimes S^2_0$), so multiplicity-freeness survives and $L_e$ is a scalar on each; the swap of the factors fixes $W^*$ and conjugates $L_e$ to itself, so the two scalars are equal. Reading $H_s$ as the component in the direct sum and $w=\lVert H_r\rVert$ as the weight outside both is therefore the reading under which $w=0$ forces $c(H)=c_p$ exactly.

The block's own account of the earlier error is correct as far as it goes: with the second copy in $H_r$, the unit vector in that copy has $w=1$ and margin exactly $c_p=3\theta_0/(n-2)=\Theta(1/n)$.

## 2. Bullet 1, $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$, CONFIRMED AS ALGEBRA

$\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F=w$ and $\lVert H_s\rVert_{op}\le\lVert H_s\rVert_F/\sqrt{m-1}\le1/\sqrt{m-1}=\Theta(n^{-1/2})$ give the inequality, and the homogeneity remark ("$\lVert H_s\rVert_F<1$ only helps") is right.

### 2.1 Discrepancy, the reason given for owing no $\sqrt2$ does not support it

**Locate.** The parenthetical input line: "*L146 prices **one** $S^2_0(\mathbb R^m)$ copy and is applied here to the **joint** two-copy eigenspace; no $\sqrt2$ is owed, **the two images being Hilbert–Schmidt orthogonal** and the cross-plane branch reaching only $\sqrt{m-2}/m=0.333$ against $1/\sqrt{m-1}=0.447$ at $n=12$*".

**Exhibit.** Hilbert–Schmidt orthogonality places no constraint on how operator norms combine. In closed form, on $\mathbb R^2$: $X=\begin{pmatrix}1&0\\0&-1\end{pmatrix}$, $Y=\begin{pmatrix}0&1\\1&0\end{pmatrix}$ are symmetric with $\langle X,Y\rangle_{HS}=0$, $\lVert X\rVert_{op}=\lVert Y\rVert_{op}=1$, $\lVert X\rVert_F=\lVert Y\rVert_F=\sqrt2$, and $\lVert X+Y\rVert_{op}=\sqrt2=\sqrt2\max(\lVert X\rVert_{op},\lVert Y\rVert_{op})$. So the full $\sqrt2$ is attainable between HS-orthogonal symmetric operators, and the named property cannot be what rules it out here.

**Argue the opposite.** The sentence's second clause is doing the real work: the comparison $\sqrt{m-2}/m$ against $1/\sqrt{m-1}$ is a statement that the branch on which the two images *add* is below the branch on which they do not. That comparison is exhibited at one dimension, $n=12$, for a claim the lemma uses at every $m\ge5$; the general inequality is not on file. The block itself says the step is "recorded because the step was silent", which is an acknowledgement that it was never written.

**Consequence.** A factor $\sqrt2$ on a $\Theta(n^{-1/2})$ term. Every order-level conclusion of the lemma is unchanged either way, so this is a defect in the written justification and not in the bound.

## 3. Bullet 2, the convex combination, CONFIRMED, and sharp

On $\lVert H\rVert_F=1$ with $H=\sum_iH_i$ over L27's summands, $c(H)=\sum_i3\theta_0(\tfrac12-\lambda_i)\lVert H_i\rVert^2$ is a convex combination of the summand margins, as claimed. The margins at $p=q=m$, all exact:

| Summand | $L_e$ | margin $3\theta_0(\tfrac12-\lambda)$ |
|---|---|---|
| $\langle W\rangle$ | $1$ | $-\tfrac32\theta_0$ |
| $\mathbb R^m\otimes\mathbb R^m$ (orbit) | $\tfrac12$ | $0$ |
| $S^2_0(\mathbb R^m)$, two copies | $\lambda_m=\frac{m-2}{2(m-1)}$ | $\frac{3\theta_0}{2(m-1)}=\frac{3\theta_0}{n-2}=c_p$ |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu=\frac1{m-1}$ | $3\theta_0\frac{m-3}{2(m-1)}$ |
| $S^2_0\otimes S^2_0$ | $-\mu$ | $3\theta_0\frac{m+1}{2(m-1)}$ |
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $0$ | $\tfrac32\theta_0$ |

So the block's "*the smallest off-summand margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$*" is right, and its three checkpoints are exact: zero at $m=3$; equal to $c_p=3\theta_0/(2(m-1))$ at $m=4$; $\tfrac34\theta_0$ at $m=5$.

### 3.1 Candidate withdrawn, the $(m-4)$ against the $(m-3)$

I opened this as a discrepancy: the bullet's coefficient is $(m-4)$ while the margin the sentence names is $(m-3)$. **Withdrawn.** The convex combination gives $c(H)\ge(1-w^2)c_p+w^2\cdot\min_{\text{off}}$, i.e. $c_p+(\min_{\text{off}}-c_p)w^2$, and
$$\min\nolimits_{\text{off}}-c_p=3\theta_0\frac{(m-3)-1}{2(m-1)}=3\theta_0\frac{m-4}{2(m-1)}$$
exactly. The coefficient is the *excess* of the smallest off-summand margin over $c_p$, which is why it vanishes at $m=4$ where the two tie. The step is correct and the two numbers are the same computation read at two places.

### 3.2 Discrepancy, two summands must be excluded and only one is

**Locate.** "*the margin being $3\theta_0(\tfrac12-\lambda)$ on **each summand** of Lemma L27 … so on $\lVert H\rVert_F=1$ it is a **convex combination** of the summand margins*", with the exclusion sentence covering the orbit alone.

**Exhibit.** Two closed-form directions in L27's own list break the bullet as literally written.
- $H=W^*/\lVert W^*\rVert$: this lies outside both $S^2_0$ copies, so $w=1$, and $c(H)=-\tfrac32\theta_0<0$, against an asserted $c(H)\ge c_p+\rho>0$. At $n=12$ the asserted floor is $0.37081+0.71904=1.08985$ and the true value is $-1.85405$.
- $H$ a unit vector in $\mathbb R^m\otimes\mathbb R^m$: $w=1$ and $c(H)=0$, again against $c_p+\rho$.

**Argue the opposite.** The record works throughout on $T_{W^*}S$, [Lemma L27](../findings/nondegeneracy.md) is stated on $W^\perp$, and [Lemma L133](../findings/second-order.md)'s neighbourhood states that "the reduction to the orbit's normal space is licensed by the $O(n)$-invariance of $P$ and of $\delta^2$". Under that standing convention both directions are outside the domain and the bullet is correct. So the finding is that **the hypotheses $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ are used and not stated**, and that the lemma's own conclusion says "over **every** direction", which the convention contradicts. The orbit exclusion is *mentioned*, but the sentence given ("$E(\tfrac12)$ equals the orbit tangent") proves that the orbit is the only zero-margin summand rather than that $H$ avoids it.

### 3.3 The bound is sharp, and the witness set is exhibited

Taking $H=\sqrt{1-w^2}\,h_s+w\,h_\mu$ with $h_s$ a unit vector in one $S^2_0(\mathbb R^m)$ copy and $h_\mu$ a unit vector in $\Lambda^2\otimes\Lambda^2$ gives $c(H)=c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$ with **equality at every $w$**. So the bullet cannot be improved, and this family is the object any falsifier would have to beat.

## 4. The range sentence and $n=10$, REFUTED AS STATED

**Locate.** "*the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$. **It is unsafe exactly on $n\in\{12,14\}$***."

**Exhibit.** The lemma is stated for $m\ge5$, i.e. even $n\ge10$. At the smallest admissible dimension the block's own coefficient is
$$\rho_{10}=3\theta_0(10)\frac{10-8}{2(10-2)}=3\cdot1.2\cdot\tfrac{2}{16}=0.45,$$
which is below $1$, so the discarded form $c(H)\gtrsim c_p+w^2$ is unsafe at $n=10$ as well. Under the penalised coefficient the block prints $\rho^{\mathrm{eff}}_{16}=0.98564<1$, so $n=16$ is unsafe too and "reaching $1$ only from $n=16$" holds for $\rho$ and fails for $\rho^{\mathrm{eff}}$. The set is $\{10,12,14\}$ under $\rho$ and $\{10,12,14,16\}$ under $\rho^{\mathrm{eff}}$; it is $\{12,14\}$ under neither.

**Argue the opposite.** The record's operating regime is $n\ge12$ ([Conjecture A](../findings/problem.md)'s threshold), so a reader may take "in range" to mean $n\ge12$. But the lemma states $m\ge5$, not $m\ge6$, and its own numbers at $n=10$ ($w^*=3.16$) are quoted, so $n=10$ is inside the block's own working range. **The repair is one character ($m\ge6$) or one clause naming $n=10$.**

I checked the four printed $\rho^{\mathrm{eff}}$ values against the definitions and **all four reproduce exactly**: $0.7416199-0.0225764=0.7190435$; $0.9462601-0.0738704=0.8723897$; $1.0978876-0.1122480=0.9856396$; and $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.7423785$. Likewise $\kappa/\rho=2n/(n-8)=6$ at $n=12$ against $\kappa/\rho^{\mathrm{eff}}=4.4497192/0.7190435=6.18809$, and the asymptotic $4.2426407/1.7423785=2.43499$, the block's "$6.188$ against $6$" and "$2.435$ against $2$" are right to every digit printed.

## 5. The $\lvert\kappa_n\rvert$ identity at $n=10$, REFUTED AS STATED

**Locate.** "$\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big)$".

**Exhibit.** [route-a.md](../findings/route-a.md):196 defines $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, which is negative for $n\ge12$ and **positive below the crossover $n=6+2\sqrt7=11.29$**. At $n=10$, in range by $m\ge5$: $\theta_0(10)=1.2<\sqrt{3/2}=1.2247449$, so the displayed right-hand side is $9(-0.0247449)=-0.2227041$, while a modulus cannot be negative. The true value is $\lvert\kappa_{10}\rvert=0.2227041$.

**Argue the opposite.** The identity is correct for every $n\ge12$, which is where the rest of the constant chain lives, and reading it as $\lvert\kappa_n\rvert=9\lvert\theta_0(n)-\sqrt{3/2}\rvert$ costs nothing. Consequence for the lemma: none at order level, with the sign taken correctly $\rho^{\mathrm{eff}}_{10}=0.45-\tfrac29(0.2227041)=0.4005102>0$, and with the displayed sign $0.4995$; positive either way.

## 6. The stationary point is not outside $[0,1]$, REFUTED

**Locate.** "*So the stationary point is outside $[0,1]$ at **every dimension in range**, and it also exceeds L158's saturation kink $w_0=(n-4)/n$ under every reading of $A$, **the minimiser sits where the operator-norm envelope has saturated and neither the interior nor the endpoint expression applies**.*"

**Exhibit.** The block's own closed form is $w^*=2\sqrt n/(n-8)$, and two lines earlier it says $w^*$ "reaches $1$ only at $n=16$", i.e. $w^*\le1$ from $n=16$ on. At $n=20$, which is in range ($m=10\ge5$):
$$w^*=\frac{2\sqrt{20}}{12}=0.745356,\qquad w_0=\frac{20-4}{20}=0.8 .$$
So $w^*\in[0,1]$ and $w^*<w_0$: the stationary point is interior **and below the kink**, so the interior expression is exactly what applies. This holds for every $n\ge18$, and $w^*\to2/\sqrt n\to0$ while $w_0\to1$, so the gap widens.

**Argue the opposite.** "In range" could be meant as "in the dimensions this entry tabulates", which are $n=10,12,14$. But the lemma's conclusion is an asymptotic order with "$\Theta(n^{-1})$ the ceiling of the method", so large $n$ is unavoidably in scope, and the sentence sits two lines after the block's own "reaches $1$ only at $n=16$", which contradicts it directly.

**Consequence.** The order conclusion is unaffected (the interior minimum is $\Theta(n^{-1})$ (§7)) but the sentence is the one that would otherwise rescue §7's lower-bound claim, and it does not.

## 7. The closed form is not a lower bound from $n=14$ on, REFUTED AS STATED

**Locate.** "*What the closed form $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ remains is a **valid but lossy lower bound**, $15.5\%$ low at $n=12$, and that is what carries $\Theta(n^{-1})$ and this lemma's conclusion.*"

**Exhibit.** The closed form is $\min_{w\ge0}g_\rho(w)$ computed with the **unpenalised** $\rho$: with $X=B^2c/(\rho A^2)=\kappa/\rho=2n/(n-8)$,
$$\min_{w\ge0}g_\rho=\frac{\sqrt c}{A\sqrt{1+X}}=\frac{\sqrt\kappa}{n}\sqrt{\frac{n-8}{3n-8}},$$
which is the printed expression. Since $g_\rho(w)$ is increasing in $\rho$ pointwise, replacing $\rho$ by the smaller $\rho^{\mathrm{eff}}$ **lowers** the branch, so a value computed at $\rho$ is an over-estimate of the branch computed at $\rho^{\mathrm{eff}}$. Exact arithmetic, all from the block's own formulas:

| $n$ | closed form | branch-2 minimum on $[0,1]$ at $\rho^{\mathrm{eff}}$ | verdict |
|---|---|---|---|
| $12$ | $\tfrac1{12}\sqrt{4.4497192\cdot\tfrac4{28}}=0.0664408$ | $w^*_{\mathrm{eff}}=1.78659>1$, so at $w=1$: $\sqrt{1.08985343}/15.4641016=0.0675078$ | lower bound holds, $1.58\%$ low |
| $14$ | $\tfrac1{14}\sqrt{4.4158804\cdot\tfrac6{34}}=0.0630546$ | $w^*_{\mathrm{eff}}=1.35276>1$, so at $w=1$: $\sqrt{1.18780973}/17.7416574=0.0614300$ | **fails**, the closed form is $2.65\%$ **above** the minimum |
| $\to\infty$ | $\tfrac1n\sqrt{\kappa/3}=1.18921/n$ | interior at $w^*_{\mathrm{eff}}\to2.435/\sqrt n$: $\sqrt\kappa/(n\sqrt{1+2.43499})=1.11135/n$ | **fails**, $7.00\%$ above |

The asymptotic failure is not rescued by the saturation envelope, because $w^*_{\mathrm{eff}}\to0$ while the kink $w_0=(n-4)/n\to1$, so the interior minimum is attained strictly below the kink, which is §6's point.

**Argue the opposite.** The most charitable reading is that branch 2 carries the **unpenalised** $\rho$, the block saying "*This entry charges itself with the penalty … and did not carry it into the margin*". Under that reading the closed form is a valid lower bound: $0.0630546$ against $g_\rho(1)=\sqrt{1.26168013}/17.7416574=0.0633057$ at $n=14$ (a margin of $0.40\%$), and it is exactly the minimum asymptotically. **So the block does not decide which coefficient branch 2 carries, and the two readings disagree on whether its own closed form is a lower bound.** The proof line writes "$\rho_n$", the blockquote defines "$\rho_n^{\mathrm{eff}}$", and the block insists the penalty is real ("*it does **not** cancel once the penalty is carried*").

**And $15.5\%$ is not reproducible.** Four readings of "how low is the closed form", each exact at $n=12$:

| comparison | value | closed form is |
|---|---|---|
| endpoint $w=1$, penalised $\rho^{\mathrm{eff}}$ | $0.0675078$ | $1.58\%$ low |
| endpoint $w=1$, unpenalised $\rho$ | $0.0681977$ | $2.58\%$ low |
| envelope kink $w_0=\tfrac23$, penalised | $0.0724781$ | $8.33\%$ low |
| envelope kink $w_0=\tfrac23$, unpenalised | $0.0730031$ | $8.99\%$ low |

None is $15.5\%$, and §9.1 adds a fifth reading, against the proof's own $\rho=1$ value $0.0753006$, giving $11.77\%$. Likewise the four ratios "$0.9008$ and $0.9794$, and $0.9215$ and $0.9840$" have **no stated referent** in the block (neither what is divided by what, nor at which dimensions) so a reader cannot check them, and the nearest value I can construct ($0.91011$) matches none. I report this as unreproducible from the dispatched block rather than as false: the referent may be defined in [Lemma L158](../findings/second-order.md), which the brief does not carry.

## 8. "$m\ge5$ is load-bearing for the exponent", CONFIRMED AS ALGEBRA

Setting $\rho=0$ gives $g(w)=\sqrt{c_p}/(n^{1/2}+nw)$, decreasing, minimised at $w=1$ with value $\Theta(n^{-1/2})/\Theta(n)=\Theta(n^{-3/2})$. The algebra is right.

As a statement about dimensions it does not survive: $\rho=0$ is $m=4$, which is the **single** dimension $n=8$, and an asymptotic order in $n$ is not defined at one $n$. The correct content is the counterfactual (*if* the $w^2$ coefficient were $0$ the branch would be $\Theta(n^{-3/2})$) and that is what the sentence should say. The hypothesis $m\ge5$ excludes only $n\in\{6,8\}$, both already outside the record's $n\ge12$ regime.

## 9. The proof of the uniformity, CONFIRMED as algebra, and proved for the wrong coefficient

*The dispatched fence originally ended mid-sentence at "…$w^*=Bc/A=\kappa n^{-1/2}$, **where**". The coordinator supplied the two closing lines from [findings/second-order.md](../findings/second-order.md):1214–1215 as part of the brief, and §9.1 below checks them. Nothing above changed as a result; §9.1 sharpens claim 9 and hardens the verdict.*

$$\frac{d}{dw}\frac{\sqrt{c+\rho w^2}}{A+Bw}=\frac{\rho w(A+Bw)-B(c+\rho w^2)}{\sqrt{c+\rho w^2}\,(A+Bw)^2}=\frac{\rho wA-Bc}{\sqrt{c+\rho w^2}\,(A+Bw)^2},$$
so $\operatorname{sign}g'=\operatorname{sign}(\rho wA-Bc)$, which is the block's display at $\rho=1$ and its parenthetical "the repaired form carries $\rho_n$ on the $w^2$" otherwise; the stationary point is $w^*=Bc/(\rho A)$, a single sign change from $-$ to $+$, hence a minimum. With $c=\kappa/n$, $A=n^{1/2}$, $B=n$: $w^*=\kappa/(\rho\sqrt n)$, and at $\rho=1$ this is $\kappa n^{-1/2}$ as printed; with $\rho=3\theta_0\frac{n-8}{2(n-2)}$ and $\kappa=3\theta_0\frac n{n-2}$ the $\theta_0$ cancels and $w^*=2\sqrt n/(n-8)$, which is $3.162$, $1.732$, $1.247$, $1$ at $n=10,12,14,16$, every printed value exact.

**A finding on the notation.** **$\kappa$ carries two values inside one block.** In "$c=\kappa/n$" it is $3\theta_0n/(n-2)\approx4.45$; in "$\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$" it is $0.1016$ at $n=12$. Both appear within twelve lines of each other, and both closed forms ($\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ and $\tfrac1n\sqrt{\kappa/(1+\kappa)}$), are checkable only under the first reading. A second collision follows in §9.1: $w^*$ also names two different numbers.

### 9.1 The two closing lines, exact, and about the coefficient the block disowns

**The algebra is right, line for line.** With $w^*=Bc/A$,
$$c+w^{*2}=c\,\frac{A^2+B^2c}{A^2},\qquad A+Bw^*=\frac{A^2+B^2c}{A},\qquad\text{so}\qquad g(w^*)=\frac{\sqrt c\,\sqrt{A^2+B^2c}}{A}\cdot\frac{A}{A^2+B^2c}=\frac{\sqrt c}{\sqrt{A^2+B^2c}},$$
and with $c=\kappa/n$, $A^2=n$, $B^2c=n\kappa$ this is $\sqrt{\kappa/n}/\sqrt{n(1+\kappa)}=\tfrac1n\sqrt{\kappa/(1+\kappa)}$, the display, exactly. The endpoints are $g(0)=\sqrt c/A=\sqrt\kappa/n$ and $g(1)=\sqrt{c+1}/(n^{1/2}+n)\asymp1/n$, both as stated, and since $\kappa\in[4.2426,4.5]$ over $n\ge10$ the factor $\sqrt{\kappa/(1+\kappa)}\in[0.8994,0.9045]$ is bounded away from $0$ and $\infty$, so "the branch never leaves that order" holds with a constant free of $n$. **Confirmed as algebra, with no step needing repair.**

**What it is a proof about.** Every line of it is executed at $\rho=1$, the coefficient the block's own bullet calls "*a lower bound stated upward*" and "*unsafe exactly on $n\in\{12,14\}$*", and the parenthetical delegates the rest: "*the repaired form carries $\rho_n$ on the $w^2$, treated in the blockquote above*". So **the only fully written proof in the block establishes the order for a function that the block elsewhere says is not a valid lower bound on branch 2 at the dimensions that matter**, and the repaired case rests entirely on the blockquote whose closed form §7 refutes. Exact, at $n=12$:

| quantity | value at $n=12$ | relation to the true branch-2 minimum on $[0,1]$ at $\rho^{\mathrm{eff}}$ ($0.0675078$) |
|---|---|---|
| the proof's $\tfrac1{12}\sqrt{4.4497192/5.4497192}=\tfrac1{12}\sqrt{0.8165033}$ | $0.0753006$ | $11.54\%$ **above** it |
| the blockquote's $\tfrac1{12}\sqrt{4.4497192\cdot\tfrac4{28}}$ | $0.0664408$ | $1.58\%$ below it |

At $n=14$ the proof's value is $\tfrac1{14}\sqrt{4.4158804/5.4158804}=0.0644980$, against a minimum of $0.0614300$, $4.99\%$ above. So the closing display is not a lower bound on the branch the lemma is about at either of the two dimensions the block singles out; it is a lower bound on the branch with the coefficient set to $1$.

**And $w^*$ names two numbers.** At $\rho=1$ the proof's $w^*=\kappa n^{-1/2}$ is $1.28453$, $1.18018$, $1.09803$, $1.03078$, $0.97469$ at $n=12,14,16,18,20$, so the minimum is "interior" to $(0,\infty)$ but outside $[0,1]$ until $n=20$. The blockquote's $w^*=2\sqrt n/(n-8)$ is the $\rho$-carrying one and crosses $1$ at $n=16$. The block uses one symbol for both and makes a structural claim about where "the" stationary point sits (§6), which is false for the $\rho$-version from $n=18$ and for this one from $n=20$. Using $g(w^*)$ as a lower bound is nonetheless sound in both cases, since $w^*$ minimises over all $w\ge0$ and $[0,1]\subset[0,\infty)$, **the proof's logic survives the fact that its minimiser is not in the domain.**

**One referent identified, partially.** $\sqrt{\rho^{\mathrm{eff}}_\infty}=\sqrt{1.7423785}=1.31999$, which is the $w=1$ endpoint of the repaired branch 2 times $n$. That is very likely the source of the "$1.32$ asymptote" the blockquote says "was right", but the blockquote calls it a **ratio**, and $1.32$ is a single branch value rather than a ratio of two, so the referent of that sentence, and of the four ratios beside it, remains undetermined. Adding the proof's own $\rho=1$ value as a fifth reading of "$15.5\%$ low at $n=12$" gives $0.0664408/0.0753006=0.88234$, i.e. $11.77\%$, still not $15.5\%$.

## 10. The boxed lemma, CONFIRMED, with the three hypotheses of the inventory

**Branch 2, uniformly in $w\in[0,1]$.** Unimodal with a single interior stationary point, so the minimum on $[0,1]$ is at $w^*$ if $w^*\le1$ and at $w=1$ otherwise. Both values are $\Theta(n^{-1})$: at the endpoint, $\sqrt{c_p+\rho}/(\sqrt n+n)$ with $c_p+\rho=\Theta(1)$; at the interior, $\sqrt\kappa/(n\sqrt{1+\kappa/\rho})$ with $\kappa\in[4.2426,4.5]$ over $n\ge10$ and $\kappa/\rho=2n/(n-8)\in[2,11]$. **The constant is free of both $w$ and $n$**, which is what "uniformly" requires. This depends on $\rho>0$ across the range, which is the debt named in the inventory.

**Branch 1 minimised at $w=0$.** $(c_p+\rho w^2)/S$ is increasing in $w$ with $S$ free of $w$, so the minimum is $c_p/S=\Theta(n^{-1})/\Theta(n^\beta)=\Theta(n^{-1-\beta})$. No contradiction with [Lemma L147](../findings/second-order.md)'s "$u=0$ is never its minimum": that is a different function, $(c_p+u^2)/(S+au)$, whose denominator carries $u$.

**Validity branch.** $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ gives $\rho(H)\gtrsim\min(1,g_n)=\Theta(n^{-1})$, so $\rho(H)/2=\Omega(n^{-1})$. This branch needs neither bullet.

**The minimum over branches.** $\inf_w\min_i f_i(w)\ge\min_i\inf_wf_i(w)$, so bounding each branch's infimum separately is a valid lower bound on the whole, **no $\min$ was distributed in the direction that would break it.** Combining, $r_n\gtrsim\min(\Theta(n^{-1-\beta}),\Omega(n^{-1}))$, which is $\Omega(n^{-1-\beta})$ **because $\beta\ge0$**, the third unstated hypothesis.

**The ceiling clause.** "$\Theta(n^{-1})$ the ceiling of the method" is asserted here and derived in [Lemma L147](../findings/second-order.md). Within the dispatched block **this clause has no argument on file**; it is an import, and I record it as such rather than as a defect.

## 11. The headline chain, CONFIRMED given its imports

$\lVert A''\rVert\le C/\rho$ with $\lVert A''\rVert\ge cn$ forces $\rho\le(C/c)n^{-1}$; with $\rho\gtrsim\min(1,g_n/\lVert H\rVert_{op})$ and $g_n=\Theta(n^{-1})$ this forces $\lVert H\rVert_{op}=\Omega(1)$. Then bullet 1 gives $w\ge\lVert H\rVert_{op}-\Theta(n^{-1/2})=\Omega(1)$ for large $n$, and bullet 2 gives $c(H)\ge c_p+\rho w^2=\Omega(1)$ for $m\ge5$. So no direction is both low-margin and high-operator-norm, and the counterexample direction the block names (margin $\Theta(1/n)$ with $\lVert A''\rVert=\Theta(n)$), is excluded. **One caveat on the second arrow at small $n$:** the implicit constant in $\Theta(n^{-1/2})$ is $1/\sqrt{m-1}=0.447$ at $n=12$, so at that dimension $\lVert H\rVert_{op}=0.4$ is compatible with $w=0$; the arrow is asymptotic and the block does not say so.

## The trap sweep, item by item

- **$\ker W\ne0$.** *No finding of falsity; a finding of scope.* The lemma lives entirely at $W^*=S^m\times S^m$, whose kernel is trivial, and every input is specific to that point: [Lemma L27](../findings/nondegeneracy.md)'s ten summands are a $p+q=n$ sphere-product decomposition, [Lemma L146](../findings/second-order.md)'s embedding is a Kulkarni–Nomizu computation on two coordinate blocks, and $c_p$, $\rho$, $\lambda_m$, $\mu$ are all balanced-product constants. At a padded object, the $\mathbb{CP}^2$-type competitor of [Lemma L17](../findings/route-a.md), where the record itself records that "$W$ has a kernel and $\delta^2$ has a kink", **none of $c_p$, $\rho$ or the $\Theta(n^{-1/2})$ has a meaning**, so the lemma neither holds nor fails there: it says nothing. The phrase "**over every direction**" in the boxed conclusion quantifies over $H$ at one base point and carries no quantifier over base points; a reader taking $r_n$ as a radius valid at every critical point would be reading in a claim the block does not make.
- **Boundary of every stated range.** $m=5$ ($n=10$) breaks three sentences, §4 (the "unsafe exactly on $\{12,14\}$" set), §5 (the $\lvert\kappa_n\rvert$ identity's sign), and the $\rho^{\mathrm{eff}}$ table, which starts at $n=12$ and never prints the smallest admissible dimension. $w=0$ and $w=1$ both check out (§10). $n=16$ is the boundary of "reaching $1$", and it is on the wrong side of it under $\rho^{\mathrm{eff}}$. $n=18$ is where §6's claim first fails.
- **Smallest admissible dimension.** $n=10$; see above. Every numeric statement in the block except $w^*=3.16$ starts at $n=12$.
- **Odd $n$.** *No finding.* $n=2m$ by construction, so odd $n$ is out of scope, and the parity hazard the record carries elsewhere ($\Theta_n<\theta_0(n)$ at odd $n$), cannot arise, since $c_p=3\theta_0/(n-2)$ is a margin at an even-$n$ balanced product rather than a bound on a maximum.
- **A claim proven on a subfamily and used in general.** [Lemma L146](../findings/second-order.md) is proven for one $S^2_0$ copy and used on the two-copy joint eigenspace (§2.1). That is the only instance I found.
- **A hypothesis stated but never used.** $m\ge5$ is used, twice, but is never binding inside the record's own $n\ge12$ regime; there is no unused hypothesis.
- **A step using a hypothesis never stated.** Three: $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, $\beta\ge0$ (inventory, §3.2, §10).
- **A universal claim with no witness, one object from each structured family.** The families here are directions, since the base point is fixed. I tried one from each of L27's summand families: the two $S^2_0$ copies ($w=0$, $c=c_p$, and by [Lemma L148](../findings/second-order.md) the defect vanishes identically there, so branch 2 is vacuous and only branches 1 and 3 bind, consistent); $\Lambda^2\otimes\Lambda^2$ ($w=1$, $c=3\theta_0\frac{m-3}{2(m-1)}$, **equality in bullet 2**); $S^2_0\otimes S^2_0$ and the four zero-summands ($w=1$, $c$ larger, bullet 2 slack); the mixed two-summand family of §3.3 (equality at every $w$); the orbit tangent and $\langle W\rangle$ (both break bullet 2, both excluded by the unstated hypotheses). Diagonal, subalgebra-Casimir, $\mathbb{CP}^m$, sphere-product and torus objects are *base points*, and the lemma is a statement at one base point, so what they test is the scope note above, not the inequality.
- **An imported theorem whose hypotheses were never checked.** L27's $p,q\ge3$, $(p,q)\ne(3,3)$ hold at $m\ge5$ and the block never checks them, but they are satisfied. L146's own $m\ge5$ condition ($\lambda_m>\mu$) coincides exactly with the lemma's $m\ge5$, a coincidence the block does not remark on, and which means the hypothesis is doing two jobs. L147's Cauchy estimate is used without restatement.

## What would falsify it, and what I did to look

**The falsifier.** A unit direction $H$ at some even $n\ge10$, normal to $W^*$ and to the orbit, with $w=\Theta(1)$ and margin $c(H)=O(1/n)$, equivalently, a summand of $L_e$ at $W^*$ other than $\mathbb R^m\otimes\mathbb R^m$ whose eigenvalue is within $O(1/n)$ of $\tfrac12$. Such a direction would carry $\lVert A''\rVert$ up to $\Theta(n)$ at margin $\Theta(1/n)$, which is exactly [Lemma L147](../findings/second-order.md)'s mixed direction, and branch 2 would return $\Theta(n^{-3/2})$.

**Where I looked.** Through all ten summands of L27's list at $p=q=m$, with their eigenvalues in closed form (§3). The eigenvalues are $1$, $\tfrac12$, $\lambda_m$ twice, $\pm\mu$, and $0$ four times; the gaps to $\tfrac12$ are $-\tfrac12$, $0$, $\tfrac1{2(m-1)}$, $\tfrac{m-3}{2(m-1)}$, $\tfrac{m+1}{2(m-1)}$, $\tfrac12$. **The only gap that is $O(1/n)$ is the $S^2_0$ one**, which is $w=0$ by construction, and the only zero gap is the orbit's. Every other direction is a convex combination and so at least the smallest of these. So no falsifier exists inside the lemma's scope, and the way to one is to leave it: an unbalanced $p\ne q$, the $(3,3)$ point where $\mu=\tfrac12$ exactly, $p=2$ where the record records L27's decomposition over-counting ($86$ against $84$ at $S^2\times S^4$), or a base point with $\ker W\ne0$. **None of these is a direction, so none of them refutes this lemma; each of them is a place the lemma does not reach.**

## Verdict

**GAP.**

The boxed conclusion survives every test I ran: branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$ with a constant free of $w$ and $n$, branch 1 is minimised at $w=0$, the validity branch is $\Omega(n^{-1})$, the branch-wise minimisation is in the safe direction, and no direction in the ten-summand decomposition is both low-margin and high-operator-norm. The two inputs are correct, and bullet 2's coefficient is exact and sharp.

What is not proven is the route the block says carries it. Specifically:

1. **The closed form is not a lower bound under the block's own penalised coefficient**, failing at $n=14$ by $2.65\%$ and asymptotically by $7.00\%$, and the block does not decide which coefficient branch 2 carries (§7). What would have to be proved: that branch 2 carries $\rho$ rather than $\rho^{\mathrm{eff}}$, or a replacement closed form at $\rho^{\mathrm{eff}}$.
2. **$\rho^{\mathrm{eff}}_n>0$ for every even $n$ in range has no argument on file**, four values and the word "increasing". This is what separates $\Omega(n^{-1})$ from $\Theta(n^{-3/2})$ by the block's own reckoning.
3. **Three hypotheses are used and not stated**: $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, $\beta\ge0$.
4. **Four clauses are refuted as stated** and are repairable in place without touching the conclusion: the $\{12,14\}$ set (§4), the $\lvert\kappa_n\rvert$ identity's sign at $n=10$ (§5), the "outside $[0,1]$ at every dimension in range" claim (§6, false for every $n\ge18$), and the $15.5\%$/four-ratio figures, which have no reproducible referent (§7).
5. **The only fully written proof in the block is about the wrong coefficient.** "Proof of the uniformity" is exact line for line but is executed at $w^2$-coefficient $1$, which the block itself calls unsafe at $n\in\{12,14\}$; its closing value $\tfrac1n\sqrt{\kappa/(1+\kappa)}$ is $11.54\%$ **above** the branch-2 minimum at $n=12$ and $4.99\%$ above at $n=14$, and the repaired case is delegated to the blockquote that item 1 refutes (§9.1). **So no written argument in the block bounds the repaired branch 2 below, and that is the gap.** The order-level conclusion is nevertheless unrefuted, by §10.
