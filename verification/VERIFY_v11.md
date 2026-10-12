# Verifier v11, L149: the uniformity of the tube-radius branch bound, its two inputs, its closed forms and its stated range

The brief was cold: [ROUND_L149.md](ROUND_L149.md)'s fenced block was read first, and every input was then checked at its own source, [Lemma L24](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md), [Lemma L145](../findings/second-order.md), [Lemma L146](../findings/second-order.md), [Lemma L147](../findings/second-order.md), [Lemma L148](../findings/second-order.md), rather than taken on the brief's word. **No numerical work of any kind was done: no script was run, no file under [scripts/](../scripts/) was opened, and every value below is a closed form or a decimal evaluation of an explicit surd carried out by hand.** Log: [agent_logs/verify-L149-v11.log](../agent_logs/verify-L149-v11.log).

## The claim table

| # | claim, as the brief states it | verdict | reason |
|---|---|---|---|
| 1 | two $S^2_0(\mathbb R^m)$ summands both carry $\lambda_m$; $H_s$ is the **joint** eigenspace, $w$ the weight outside **both** | **CONFIRMED** | [L27](../findings/nondegeneracy.md) lists both; $\lambda_m$ separates from $\mu,-\mu,0,\tfrac12,1$ for every $m\ge5$, so the joint eigenspace is exactly those two |
| 2 | $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$, no $\sqrt2$ owed, cross-plane branch $\sqrt{m-2}/m$ | **CONFIRMED** | the constant $\sqrt{m-2}/m$ reproduces exactly from [L146](../findings/second-order.md)'s embedding, and $(m-2)(m-1)<m^2$ makes it lose to $1/\sqrt{m-1}$ at every $m\ge3$ |
| 3 | $c(H)\ge c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$, by convex combination of the summand margins | **REFUTED AS STATED** | the enumeration runs over all ten of [L27](../findings/nondegeneracy.md)'s summands, one of which ($\langle W\rangle$, $L_e$-eigenvalue $1$), carries margin $-\tfrac32\theta_0$; $H\perp W^*$ is used and never stated |
| 4 | the smallest off-summand margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$, zero at $m=3$, tying $c_p$ at $m=4$, $\ge\tfrac34\theta_0$ from $m=5$ | **CONFIRMED** | $\mu=1/(m-1)$ at $p=q=m$ gives $\tfrac12-\mu=\frac{m-3}{2(m-1)}$; all three boundary readings are exact |
| 5 | $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$ | **CONFIRMED** | follows from [L145](../findings/second-order.md)'s direction-blind radius and [L147](../findings/second-order.md)'s $M=O(\rho)$, neither cited in the brief |
| 6 | the "no direction is both low-margin and high-operator-norm" chain, and the refutation of the $\Theta(1/n)$-margin/$\Theta(n)$-norm direction | **CONFIRMED** | each arrow is the contrapositive of an upper bound already proven; the parenthetical $w\lesssim n^{-1/2}\Rightarrow\lVert A''\rVert=O(n^{1/2})$ also checks |
| 7 | branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$ | **CONFIRMED AS ALGEBRA** | $\min_{[0,1]}g\ge g(w^*)=\tfrac1n\sqrt{\kappa\rho/(\kappa+\rho)}$, a positive constant over $n$ for every $m\ge5$; the brief's own quoted proof stops one line before this |
| 8 | branch 1 is minimised at $w=0$; the validity branch is $\Omega(n^{-1})$ | **CONFIRMED** | $S$ is $w$-free by its own definition, and $\rho(H)=\Omega(g_n)$ since $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ |
| 9 | $r_n\gtrsim n^{-1-\beta}$ over every direction | **REFUTED AS STATED** | needs $\beta\ge0$, which the brief neither states nor imports; at $\beta<0$ the min is branch 2 and the claim is strictly stronger than what is proved |
| 10 | $\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert$ with $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, and its four values | **REFUTED AS STATED** | the four values are exact, but $9(\theta_0-\sqrt{3/2})$ is **negative** at $n=10$, which is $m=5$, the statement's own smallest admissible dimension |
| 11 | the $c_p+w^2$ display "is unsafe exactly on $n\in\{12,14\}$" | **REFUTED** | the brief prints the counterexample three lines later: $\rho^{\mathrm{eff}}_{16}=0.98564<1$. Under the entry's own penalised coefficient the first safe dimension is $n=18$ |
| 12 | the stationary point $w^*=2\sqrt n/(n-8)$ sits outside $[0,1]$ at every dimension in range, and exceeds L158's kink $w_0=(n-4)/n$ under every reading | **REFUTED** | $w^*<1$ for every $n\ge18$ and $w^*<w_0$ for every $n\ge20$, while the lemma is stated for all $m\ge5$ |
| 13 | the closed form $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ is a valid lower bound | **CONFIRMED** | it is $g(w^*)$ for the $\rho$-repaired $g$, and $\min_{[0,1]}g\ge g(w^*)$ whether or not $w^*\in[0,1]$; the algebra reproduces exactly |
| 14 | "$15.5\%$ low at $n=12$"; the ratios $0.9008$, $0.9794$, $0.9215$, $0.9840$ | **HYPOTHESIS-DEBT** | no argument on file in the brief, and the objects compared are undefined in it |
| 15 | at $\rho=0$, which is $m=4$, branch 2 degrades to $\Theta(n^{-3/2})$, so $m\ge5$ is load-bearing for the exponent | **REFUTED AS STATED** | at $m=4$ the entry's own recipe folds $\Lambda^2\otimes\Lambda^2$ into the joint $\lambda_4$-eigenspace, giving $\rho=\theta_0>0$; and $m=4$ is one dimension, not a family in which $\Theta(n^{-3/2})$ has meaning |

## The one-line summary

**L149's mathematical core (the two inputs, the branch-2 uniformity and the $\Omega(n^{-1})$ conclusion), is correct and the whole penalised-coefficient table reproduces exactly by hand, but four of its side-claims are stated over a range wider than they hold, including one the brief refutes with its own printed number ($\rho^{\mathrm{eff}}_{16}=0.98564<1$ against "unsafe exactly on $n\in\{12,14\}$"), and two hypotheses it uses ($H\perp W^*$ and $\beta\ge0$) appear nowhere in it.**

## 0. Conventions, fixed once

Quoted or fixed from the brief and from the sources it names:

- $n=2m$, $W^*$ the unit-norm Weyl tensor of $S^m\times S^m$, $e=W^*/\theta_0$, $L_e=e\circ(\cdot)$, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ ([conventions.md](../findings/conventions.md), [L141](../findings/second-order.md)'s setting).
- $H$ is a direction of unit Frobenius norm. $H=H_s+H_r$ with $H_s$ in the joint $\lambda_m$-eigenspace, both copies, and $w:=\lVert H_r\rVert$.
- $\lambda_m=(m-2)/(2(m-1))$; $\mu=\frac{n-2}{2(p-1)(q-1)}$, which at $p=q=m$ is $1/(m-1)$.
- Margin: $c(H)=3\theta_0\langle H,(\tfrac12-L_e)H\rangle$, from [L24](../findings/second-order.md)'s $\mathrm{Hess}(P|_S)=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$. $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$.
- $S:=\sup\lvert P\rvert=\Theta(n^\beta)$; $\rho$ carries **two** meanings in the brief, the analyticity radius in "$\lVert A''\rVert=O(1/\rho)$" and in the third branch $\rho(H)/2$, and the coefficient of $w^2$ in $\rho_n$, $\rho_n^{\mathrm{eff}}$ and "at $\rho=0$, which is $m=4$". Below, $\rho$ always means the coefficient and $\rho_{\mathrm{an}}$ the radius.
- $\kappa$ in the uniformity proof is fixed by $c=\kappa/n$ with $c=c_p$, so $\kappa=3\theta_0 n/(n-2)$. $\kappa_n$ in the penalty is the unrelated defect constant $9(\sqrt{3/2}-\theta_0(n))$ of [problem.md](../findings/problem.md). Two $\kappa$'s, two $\rho$'s.

## The hypothesis inventory

**Hypotheses the statement carries.**

| hypothesis | used? | where |
|---|---|---|
| $m\ge5$ | **yes**, twice | positivity of $\rho$ (via $\tfrac{m-4}{2(m-1)}>0$), and separation of $\lambda_m$ from $\mu$, which fails exactly at $m=4$ |
| $w\in[0,1]$ | **yes** | the uniformity is a claim about the closed interval; both endpoints are attained and both are tight |
| $\lVert H\rVert_F=1$ | **yes** | the convex-combination step and L146's homogeneity |
| $n=2m$ even | **yes**, silently | $W^*$ exists only at even $n$, and $\theta_0(n)$ is the attained value only at even $n$ ([problem.md](../findings/problem.md):347). The conclusion is written with a free $n$ |

**Hypotheses of imported theorems, checked against the object.**

| import | its hypotheses | met? |
|---|---|---|
| [L27](../findings/nondegeneracy.md), ten-summand decomposition, $L_e$ scalar on each | $p,q\ge3$, $(p,q)\ne(3,3)$; multiplicity-freeness | met at $p=q=m\ge5$. The two $S^2_0$ copies are $V\boxtimes1$ and $1\boxtimes V$, non-isomorphic as $O(m)\times O(m)$-representations, so multiplicity-freeness survives $p=q$ and the quadratic form has **no cross terms**, the step the brief needs and does not name |
| [L24](../findings/second-order.md), $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$ | $W$ critical, $\theta>0$, restriction to $W^\perp$ | $\theta_0(n)>0$ met. **$W^\perp$ is not met by anything the brief states**, see §3 |
| [L146](../findings/second-order.md), $\lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, sup $1/\sqrt{m-1}$ | $H$ the Weyl image of $h\in S^2_0(\mathbb R^m)$, $\lVert H\rVert_F=1$, $n=2m$; its own scope note says $m\ge5$ | met, and the brief's extension from one copy to two is proved rather than assumed, see §2 |
| [L145](../findings/second-order.md) / [L147](../findings/second-order.md), $\rho_{\mathrm{an}}=\Theta(\min(1,g_n/\lVert H\rVert_{op}))$, $M=O(\rho_{\mathrm{an}})$, $\lVert A''\rVert=O(M/\rho_{\mathrm{an}}^2)$ | analyticity of $W\mapsto W_-$ on the ball of radius $g_n$; two-valued spectrum with no kernel at $W^*$ | met at $W^*$. **Neither lemma is cited in the brief**, though the step "$\lVert A''\rVert=O(1/\rho)$" is entirely theirs |
| [L147](../findings/second-order.md), $\beta\in[0,\tfrac12]$ | $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$ and [L143](../findings/bounds.md) | met, but **not imported**: the brief writes $S=\Theta(n^\beta)$ with $\beta$ unrestricted |
| [L27](../findings/nondegeneracy.md), $E(\tfrac12)$ equals the orbit tangent | as above | met; this is what licenses the orbit exclusion |

**Hypotheses used and never stated:** $H\perp W^*$ (§3); $\beta\ge0$ (§7); $n$ even; $n\ge12$ for the sign of $\lvert\kappa_n\rvert$ (§6).

**Hypotheses stated and never used:** none. The swap-of-factors argument in the set-up is redundant, $\lambda_m=(m-2)/(2(m-1))$ depends on the block only through $m$, so both copies carry it by [L27](../findings/nondegeneracy.md)'s formula directly, but redundancy is not a defect and the swap argument is itself correct.

## 1. The substance chain, and the direction it says does not exist, CONFIRMED

The brief asserts $\lVert A''\rVert=\Theta(n)\Rightarrow\lVert H\rVert_{op}=\Theta(1)\Rightarrow w=\Theta(1)\Rightarrow c(H)=\Theta(1)$.

Each arrow is the contrapositive of an upper bound the record already holds, which is the only reading that makes the chain valid, and it is available:

- $\lVert H\rVert_{op}=o(1)\Rightarrow\rho_{\mathrm{an}}=\Theta(\min(1,g_n/\lVert H\rVert_{op}))=\omega(g_n)\Rightarrow\lVert A''\rVert=O(1/\rho_{\mathrm{an}})=o(n)$. So $\lVert A''\rVert=\Theta(n)$ forces $\lVert H\rVert_{op}=\Theta(1)$.
- $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ then forces $w\ge\lVert H\rVert_{op}-\Theta(n^{-1/2})=\Theta(1)$.
- $c(H)\ge c_p+\rho w^2$ with $\rho=\Theta(\theta_0)=\Theta(1)$ for $m\ge5$ then forces $c(H)=\Omega(1)$; boundedness above is free, since $c(H)\le3\theta_0(\tfrac12+\mu)$.

The parenthetical is also right. $c(H)=\Theta(1/n)$ with $c(H)\ge c_p+\rho w^2$ and $c_p=\Theta(1/n)$, $\rho=\Theta(1)$ gives $w=O(n^{-1/2})$; then $\lVert H\rVert_{op}=O(n^{-1/2})$, $\rho_{\mathrm{an}}=\Omega(n^{-1/2})$, $\lVert A''\rVert=O(n^{1/2})$, and branch 2 is $\Omega(n^{-1/2}/n^{1/2})=\Omega(n^{-1})$. Exactly as written.

**No finding**, beyond the notational one that $\Theta$ is written where $O$ and $\Omega$ are what is proved and what is needed; the implications run the right way regardless.

## 2. The first input: $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$, and the $\sqrt2$ that is not owed, CONFIRMED, and the brief's constant is exact

The naive extension of [L146](../findings/second-order.md) from one copy to two costs a $\sqrt2$: $\lVert H_s\rVert_{op}\le\lVert H^{(1)}\rVert_{op}+\lVert H^{(2)}\rVert_{op}\le\frac1{\sqrt{m-1}}(\lVert H^{(1)}\rVert_F+\lVert H^{(2)}\rVert_F)\le\frac{\sqrt2}{\sqrt{m-1}}$. The brief says none is owed and offers a number. I re-derived that number from L146's corrected embedding and it is exact.

Both images are diagonal on coordinate $2$-planes in the same frame. Copy 1, from $h\in S^2_0(\mathbb R^p)$ on block $B_1$, carries $\alpha h_a$ on $e_a\wedge e_b$ ($a\in B_1,b\in B_2$), $-\beta(h_a+h_{a'})$ inside $B_1$, and $0$ inside $B_2$; copy 2 is its mirror. So

$$\lVert H_s\rVert_{op}=\max\Big\{\beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert,\ \beta\max_{b\ne b'}\lvert h'_b+h'_{b'}\rvert,\ \alpha\max_{a,b}\lvert h_a+h'_b\rvert\Big\},$$

with $\alpha=\frac{m-2}{2(m-1)}$, $\beta=\frac m{2(m-1)}$. The first two branches are single-copy and are maximised by putting all the norm in one copy, returning L146's $1/\sqrt{m-1}$ unchanged. The third is the only one both copies feed. With $\lVert H_s\rVert_F^2=\frac{m(m-2)}{2(m-1)}(\lVert h\rVert^2+\lVert h'\rVert^2)=1$ and $\max h_a=\lVert h\rVert\sqrt{(m-1)/m}$ over traceless $h$,

$$\alpha\max(h_a+h'_b)\le\alpha\sqrt{\tfrac{m-1}m}\cdot\sqrt2\sqrt{\lVert h\rVert^2+\lVert h'\rVert^2}=\frac{m-2}{2(m-1)}\cdot\frac{2(m-1)}{m\sqrt{m-2}}=\frac{\sqrt{m-2}}m .$$

At $m=6$ that is $2/6=0.3333$ against $1/\sqrt5=0.4472$, **the brief's two figures, exactly.** And it loses at every $m\ge3$, since $\frac{m-2}{m^2}<\frac1{m-1}$ reduces to $m^2-3m+2<m^2$. So the in-block branch wins, no $\sqrt2$ is owed, and $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}=\Theta(n^{-1/2})$.

$\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F=w$ is the record's own $\lVert E\rVert_{op}\le\lVert E\rVert_F$. Homogeneity of L146 makes $\lVert H_s\rVert_F<1$ help, as the brief says.

**One wording finding, below the reporting bar and recorded as such.** The reason the brief gives ("the two images being Hilbert–Schmidt orthogonal"), is not by itself the reason: HS orthogonality bounds no operator norm. What does the work is **simultaneous diagonality** on coordinate $2$-planes, which is [L146](../findings/second-order.md)'s "Diagonality does survive" clause; HS orthogonality enters only to normalise. The step is correct and its stated ground is one lemma-clause short.

## 3. The second input, and the summand the enumeration does not exclude, REFUTED AS STATED

The convex-combination step is right in form. $L_e$ is scalar on each summand and the summands are pairwise non-isomorphic, so with $H=\sum_iH_i$ and $\sum\lVert H_i\rVert^2=1$,
$$c(H)=3\theta_0\sum_i(\tfrac12-\lambda_i)\lVert H_i\rVert^2\ \ge\ c_p(1-w^2)+c^r_{\min}w^2=c_p+(c^r_{\min}-c_p)w^2,$$
and with $c^r_{\min}=3\theta_0\frac{m-3}{2(m-1)}$ this is exactly the brief's $c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$, since $\frac{m-3}{2(m-1)}-\frac1{2(m-1)}=\frac{m-4}{2(m-1)}$. The arithmetic is clean.

**1. Locate.** The clause *"the margin being $3\theta_0(\tfrac12-\lambda)$ on **each summand of [Lemma L27](nondegeneracy.md)** and the form quadratic, so on $\lVert H\rVert_F=1$ it is a **convex combination** of the summand margins"*, together with the single exclusion the brief does make: *"The orbit summand is excluded cleanly."* [L27](../findings/nondegeneracy.md)'s decomposition has **ten** summands and the first of them is $\langle W\rangle$, on which $L_e$ acts as $1$.

**2. Exhibit.** Take $H=W^*$ (unit norm by construction). It lies wholly in $\langle W\rangle$, hence wholly outside both $S^2_0$ copies, so $w=1$; and
$$c(H)=3\theta_0(\tfrac12-1)=-\tfrac32\theta_0<0,$$
against the asserted $c_p+3\theta_0\frac{m-4}{2(m-1)}>0$. At $n=12$ that is $-1.854$ against $+1.112$. A convex combination over a set containing a negative summand margin is not bounded below by the smallest *non-negative* one, and the brief's minimum is taken over eight of the ten.

**3. Argue the opposite.** The record's convention supplies the missing clause and supplies it unambiguously: [L24](../findings/second-order.md) states the Hessian bound on $W^\perp$ and proves $W^\perp$ is $L_e$-invariant, [L27](../findings/nondegeneracy.md)'s statement is $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, and [results.md](../results.md):779 quantifies over $H\in T_{W^*}S=W^{*\perp}$. So the author meant $H\perp W^*$ throughout, the $\langle W\rangle$ summand is not in the tangent space, and the enumeration is over the nine summands of $W^\perp$ with the orbit one removed.

**Finding.** The step uses a hypothesis the brief never states, and the brief's own care in naming the orbit exclusion while passing over $\langle W\rangle$ is what makes it a finding rather than a typo. **The repair is one clause** ("for $H\in T_{W^*}S$ normal to the orbit") and it costs the lemma nothing.

## 4. The $+\mu$ margin and the three boundary readings, CONFIRMED

At $p=q=m$, $\mu=\frac{2m-2}{2(m-1)^2}=\frac1{m-1}$, so $\tfrac12-\mu=\frac{m-1-2}{2(m-1)}=\frac{m-3}{2(m-1)}$: the brief's expression, exactly. The three readings:

| $m$ | $\frac{m-3}{2(m-1)}$ | brief's word | verdict |
|---|---|---|---|
| $3$ | $0$ | "zero at $m=3$" | exact |
| $4$ | $\tfrac16$, against $c_p$'s $\frac1{2(m-1)}=\tfrac16$ | "ties with $c_p$ at $m=4$" | exact |
| $5$ | $\tfrac14$, so margin $\tfrac34\theta_0$ | "$\ge\tfrac34\theta_0$ only from $m=5$" | exact |

And the $m=4$ tie is more than a numerical coincidence: $\lambda_m=\mu$ reduces to $m-2=2$, so $m=4$ is the **only** $m$ at which any other summand shares the margin summand's eigenvalue. Checking the rest at $m\ge5$: $\lambda_m=-\mu$ needs $m=0$; $\lambda_m=0$ needs $m=2$; $\lambda_m<\tfrac12<1$ always. So for $m\ge5$ the joint $\lambda_m$-eigenspace is exactly the two $S^2_0$ copies and no more, which is precisely what claim 1 needs and what the brief asserts without proving. **No finding: the assertion is true, and the check it omits succeeds.**

## 5. $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$, and the three branches, CONFIRMED

$1/\rho_{\mathrm{an}}=O(\max(1,\lVert H\rVert_{op}/g_n))=O(1+n\lVert H\rVert_{op})=O(1+n^{1/2}+nw)=O(n^{1/2}+nw)$, using $g_n=\Theta(1/n)$ and the bound of §2. Correct, and correct in the safe direction: an upper bound on $\lVert H\rVert_{op}$ gives a lower bound on the radius and so an upper bound on $\lVert A''\rVert$.

Branch 1, $\frac{c_p+w^2}S$, has a $w$-free denominator by the brief's own definition $S:=\sup\lvert P\rvert$, so it is increasing in $w$ and minimised at $w=0$ at $c_p/S=\Theta(n^{-1-\beta})$. Branch 3, $\rho(H)/2$, is $\Omega(g_n)=\Omega(n^{-1})$ since $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ makes $\min(1,g_n/\lVert H\rVert_{op})\ge g_n$. Both as claimed.

### 5a. Withdrawn candidate, branch 1's minimiser against L147's $f(u)$

[L147](../findings/second-order.md) records that $f(u)=(c_p+u^2)/(S+au)$ has $f'(0)<0$, so "$u=0$ is **never** its minimum", and calls the opposite claim an error that had stood in the record. L149's branch 1 asserts the minimum *is* at $w=0$. **Withdrawn at step 3:** the two denominators are different objects (L147's carries $+au$, L149's does not) and $S=\sup\lvert P\rvert$ is a supremum over the disc, independent of the direction's decomposition, so $w$-freeness is what the definition gives. The candidate is recorded so the next verifier does not spend an adjudication on it.

## 6. The penalised coefficient: four exact values, one formula out of range, REFUTED AS STATED

Every printed value reproduces by hand. With $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and $\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-2(\theta_0-\sqrt{3/2})$:

| $n$ | $\theta_0(n)$ | $3\theta_0\frac{n-8}{2(n-2)}$ | $\tfrac29\lvert\kappa_n\rvert$ | $\rho_n^{\mathrm{eff}}$ | brief |
|---|---|---|---|---|---|
| $12$ | $\sqrt{220}/12=1.2360331$ | $0.7416199$ | $0.0225738$ | $0.7190460$ | $0.7416$, $0.71904$ |
| $14$ | $\sqrt{312}/14=1.2616801$ | $0.9462601$ | $0.0738705$ | $0.8723896$ | $0.9463$, $0.87239$ |
| $16$ | $\sqrt{420}/16=1.2808688$ | $1.0978876$ | $0.1122479$ | $0.9856396$ | $0.98564$ |
| $\infty$ | $\sqrt2$ | $\tfrac32\sqrt2=2.1213203$ | $2(\sqrt2-\sqrt{3/2})=0.3789374$ | $1.7423829$ | $1.74238$ |

The closed form of the limit is also right: $\rho^{\mathrm{eff}}_n=2\sqrt{3/2}-\theta_0(n)\frac{n+16}{2(n-2)}\to2\sqrt{3/2}-\tfrac{\sqrt2}2=\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})$. **Five exact hits out of five.**

**1. Locate.** The displayed definition $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, read against the statement's range *"For $m\ge5$"*, i.e. $n\ge10$.

**2. Exhibit.** At $m=5$, $n=10$: $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=\tfrac{12}{10}=\tfrac65$ **exactly**, and $\sqrt{3/2}=1.2247449>\tfrac65$. So the display returns $9(1.2-1.2247449)=-0.2227$, a negative number presented as an absolute value. The true $\lvert\kappa_{10}\rvert=9(\sqrt{3/2}-\tfrac65)=+0.2227$, and the displayed formula therefore *adds* the penalty at $n=10$ instead of subtracting it, giving $0.4995$ where the correct $\rho^{\mathrm{eff}}_{10}$ is $0.45-0.0495=0.4005$.

**3. Argue the opposite.** [problem.md](../findings/problem.md) fixes $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, which changes sign exactly at $n=6+2\sqrt7=11.29$, so the brief's form is the correct absolute value **for $n\ge12$ and only there**; and the surrounding chain ([L141](../findings/second-order.md)'s setting, Conjecture [L16](../findings/problem.md)'s clause) is stated at $n=2m\ge12$ throughout. So the author is working at $n\ge12$ and inherited "$m\ge5$" from [L146](../findings/second-order.md)'s structural range.

**Finding stands.** The statement's range and its proof's range differ by one dimension, and the entry does not merely brush $n=10$, it evaluates $w^*$ there ("$3.16$ … at $n=10$") and it argues about $m=4$, i.e. $n=8$. **The conclusion survives**: $\rho^{\mathrm{eff}}_{10}=0.4005>0$ under the correct sign, so branch 2 is still $\Omega(n^{-1})$ at $m=5$. What fails is the displayed formula, on the statement's own boundary.

### 6a. Withdrawn candidate, the $\tfrac29$ has no derivation in the brief

The brief carries $-\tfrac29\lvert\kappa_n\rvert$ and refers the account to a section it does not quote ("This entry charges itself with the penalty in 'The penalty term, which had no account'"). Within the brief, the coefficient $\tfrac29$ is an unexplained constant that all but cancels the $9$ in $\kappa_n$'s definition. **Withdrawn at step 2:** I can locate the gap but cannot exhibit a failure, because the quantity the $\tfrac29$ prices is not defined in the brief. Recorded as an item, not a defect: **the coefficient $\tfrac29$ has no argument on file in the brief.** *Read outside the brief and flagged as such:* the entry's own penalty paragraph charges $\lvert\kappa_n\rvert$ rather than $\tfrac29\lvert\kappa_n\rvert$ against the margin, a factor $4.5$ apart; under that accounting the net coefficient is $0.6400$ at $n=12$, $0.6138$ at $n=14$ and $\to0.4161$, always positive, so the $\Omega(n^{-1})$ conclusion is untouched either way while the constant is not.

## 7. "Unsafe exactly on $n\in\{12,14\}$", REFUTED, by a number the brief itself prints

**1. Locate.** *"the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$. **It is unsafe exactly on $n\in\{12,14\}$**"*, read against the displayed chain's $\frac{\sqrt{c_p+w^2}}{n^{1/2}+nw}$ and against the blockquote three lines later.

**2. Exhibit.** The display is safe at $n$ exactly when the true coefficient of $w^2$ is $\ge1$. The entry insists the true coefficient is the **penalised** one ("This entry charges itself with the penalty … and did not carry it into the margin") and prints its value at $n=16$: $\rho^{\mathrm{eff}}_{16}=0.98564<1$. So the display is unsafe at $n=16$ as well. Solving $\rho^{\mathrm{eff}}_n\ge1$, i.e. $\theta_0(n)\frac{n+16}{2(n-2)}\le2\sqrt{3/2}-1=1.4494897$:

| $n$ | $\theta_0(n)\frac{n+16}{2(n-2)}$ | $\rho^{\mathrm{eff}}_n$ | safe? |
|---|---|---|---|
| $16$ | $1.2808688\cdot\tfrac87=1.4638501$ | $0.9856396$ | no |
| $18$ | $1.2957671\cdot\tfrac{34}{32}=1.3767525$ | $1.0727372$ | yes |

**The first safe dimension is $n=18$, not $n=16$**, and the unsafe set is $\{12,14,16\}$.

**3. Argue the opposite.** "The coefficient" in the sentence can be read as the **uncorrected** $\rho_n=3\theta_0\frac{n-8}{2(n-2)}$, whose values are the $0.7416$ and $0.9463$ that same sentence quotes and which does reach $1$ at $n=16$ ($1.09789$). Under that reading the sentence is internally consistent. But the entry's next blockquote supersedes that coefficient with $\rho^{\mathrm{eff}}$, so the charitable reading survives only by ignoring the correction the entry makes to itself, and the printed $0.98564$ is the witness against it.

**Finding.** The unsafe set is understated by one dimension, and the correction is arithmetic. Impact is on the constant, not on the order: $\rho^{\mathrm{eff}}>0$ at every $n\ge10$ under the corrected sign of §6, so branch 2 is $\Omega(n^{-1})$ throughout regardless.

## 8. Where $w^*$ sits, REFUTED as a claim over the stated range

The algebra is right. For $g(w)=\sqrt{c+\rho w^2}/(A+Bw)$, multiplying the numerator of $g'$ by $\sqrt{c+\rho w^2}$ gives $\rho w(A+Bw)-B(c+\rho w^2)=\rho wA-Bc$, so $\operatorname{sign}g'=\operatorname{sign}(\rho wA-Bc)$ (the brief's $\operatorname{sign}(wA-Bc)$ at $\rho=1$) and $g$ falls then rises, a single interior minimum at $w^*=Bc/(\rho A)$. With $c=3\theta_0/(n-2)$, $\rho=3\theta_0\frac{n-8}{2(n-2)}$, $A=\sqrt n$, $B=n$, the $\theta_0$ cancels and
$$w^*=\frac{n\cdot\frac{3\theta_0}{n-2}}{3\theta_0\frac{n-8}{2(n-2)}\sqrt n}=\frac{2n}{(n-8)\sqrt n}=\frac{2\sqrt n}{n-8},$$
which is $\sqrt{10}=3.1623$, $\sqrt3=1.7321$ and $\sqrt{14}/3=1.2472$ at $n=10,12,14$, **the brief's $3.16$, $1.73$, $1.25$, exactly**, and $=1$ at $n=16$, since $n-8=2\sqrt n$ has the unique root $\sqrt n=4$. Likewise $\kappa/\rho=2n/(n-8)$ is $6$ at $n=12$ and $\to2$; carrying the penalty gives $\kappa/\rho^{\mathrm{eff}}=4.4497/0.71904=6.188$ at $n=12$ and $3\sqrt2/1.74238=2.435$ asymptotically, **both of the brief's contrast figures, exactly.**

**1. Locate.** *"So the stationary point is outside $[0,1]$ **at every dimension in range**, and it also exceeds [L158](../findings/second-order.md)'s saturation kink $w_0=(n-4)/n$ **under every reading of $A$**"*, read against the statement's *"For $m\ge5$"*.

**2. Exhibit.** $w^*=2\sqrt n/(n-8)$ is decreasing past $n=16$, so $w^*<1$ for **every even $n\ge18$**, at $n=18$, $w^*=2\sqrt{18}/10=0.84853$; at $n=100$, $w^*=20/92=0.21739$. And $w^*>w_0=(n-4)/n$ reduces to $2n^{3/2}>n^2-12n+32$, which holds at $n=18$ ($152.74>140$) and **fails at every even $n\ge20$** ($178.89<192$ at $n=20$; at $n=100$, $w^*=0.2174$ against $w_0=0.96$). So both clauses are false on all but a finite initial segment of the stated range.

**3. Argue the opposite.** "In range" can be read as the dimensions the sentence itself enumerates, $n\in\{10,12,14\}$, where both clauses hold. But the lemma's own range is $m\ge5$ with no upper bound, and its conclusion ($\Omega(n^{-1})$, with $\Theta(n^{-1})$ "the ceiling of the method"), is asymptotic, so large $n$ is the case the conclusion is about. This is a claim proven on a subfamily and stated in general.

**Finding, and it does not damage the conclusion.** The sentence it supports (that the closed form $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ is "a **valid but lossy lower bound**"), holds at every $n$ for a reason independent of where $w^*$ sits: $g$ has a single interior minimum on $[0,\infty)$, so $\min_{[0,1]}g\ge g(w^*)$ whether $w^*$ is inside $[0,1]$ or outside it. What changes past $n=18$ is only that the bound stops being lossy, becoming attained.

## 9. The closed form and the $\Omega(n^{-1})$ conclusion, CONFIRMED AS ALGEBRA

At the stationary point, $c+\rho w^{*2}=c\frac{\rho A^2+B^2c}{\rho A^2}$ and $A+Bw^*=\frac{\rho A^2+B^2c}{\rho A}$, so
$$g(w^*)=\frac{\sqrt{c\rho}}{\sqrt{\rho A^2+B^2c}}\ \xrightarrow{\ \rho=1\ }\ \frac{\sqrt c}{\sqrt{A^2+B^2c}}=\frac1n\sqrt{\frac\kappa{1+\kappa}},$$
and with $\rho=3\theta_0\frac{n-8}{2(n-2)}$, $\kappa=\frac{3\theta_0n}{n-2}$ one has $\rho+\kappa=\frac{3\theta_0(3n-8)}{2(n-2)}$ and $\frac{\kappa\rho}{\kappa+\rho}=\kappa\frac{n-8}{3n-8}$, giving
$$g(w^*)=\frac1n\sqrt{\frac{\kappa(n-8)}{3n-8}}$$
**the brief's closed form, reproduced exactly.** It is $\Theta(n^{-1})$: $\kappa\to3\sqrt2$ and $\frac{n-8}{3n-8}\to\tfrac13$, so $ng(w^*)\to2^{1/4}$. At the smallest admissible dimension $n=10$ it is positive too ($\kappa_{10}=4.5$, $\rho_{10}=0.45$, $g(w^*)=\tfrac1{10}\sqrt{4.5\cdot0.45/4.95}=0.0640$). So **branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$ for every $m\ge5$**, which is the headline. Both endpoints are tight for the input bound: at $w=0$ the bound $c(H)\ge c_p$ is attained on the margin summand, at $w=1$ the bound $c(H)\ge c_p+\rho$ is attained on $\Lambda^2\otimes\Lambda^2$.

### 9a. The brief's quotation of the proof stops one line short

The fenced block ends *"so $g$ has a single interior minimum at $w^*=Bc/A=\kappa n^{-1/2}$, **where**"*, mid-sentence, with no displayed value, no endpoint comparison and no $\square$. As dispatched, the proof of the lemma's headline clause has no final step. This is a defect of the brief rather than of the entry: the source continues at [findings/second-order.md](../findings/second-order.md):1213 with $g(w^*)=\sqrt c/\sqrt{A^2+B^2c}=\tfrac1n\sqrt{\kappa/(1+\kappa)}$ and "the endpoints give $\sqrt\kappa/n$ and $\asymp1/n$", both of which I have re-derived above and both of which are correct. **Recorded so the round knows what the verifiers were and were not given.**

## 10. $r_n\gtrsim n^{-1-\beta}$ needs $\beta\ge0$, REFUTED AS STATED

**1. Locate.** *"with $S:=\sup\lvert P\rvert=\Theta(n^\beta)$"* in the set-up, against the conclusion *"$r_n\gtrsim n^{-1-\beta}$ over every direction"*. No constraint on $\beta$ appears anywhere in the brief.

**2. Exhibit.** The conclusion is a minimum of three branches: $\Theta(n^{-1-\beta})$, $\Omega(n^{-1})$, $\Omega(n^{-1})$. At $\beta=-\tfrac12$ the minimum is $\Omega(n^{-1})$ while the asserted bound is $n^{-1/2}$, a bound the argument does not deliver, by a factor $n^{1/2}$. The step $\min(n^{-1-\beta},n^{-1})=n^{-1-\beta}$ is exactly the hypothesis $\beta\ge0$.

**3. Argue the opposite.** [L147](../findings/second-order.md) proves $\beta\ge0$ from $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$ and $\beta\le\tfrac12$ from [L143](../findings/bounds.md), and the brief's own conclusion quotes L147's shape. So the hypothesis is available and true; it is simply not imported.

**Finding: an unstated hypothesis, repairable by citation.** Paired with §3's $H\perp W^*$, these are the two places where the written proof leans on something it never writes down.

## 11. $m=4$, $\rho=0$, and the exponent, REFUTED AS STATED

**1. Locate.** *"At $\rho=0$, which is $m=4$, branch 2 degrades to $\Theta(n^{-3/2})$, so $m\ge5$ is load-bearing for the $\Omega(n^{-1})$ conclusion itself."*

**2. Exhibit.** Two things.

- The coefficient's vanishing at $m=4$ is an artefact of the two-copy recipe, not a fact about $m=4$. At $m=4$, $\lambda_4=\tfrac13=\mu$, so $\Lambda^2\otimes\Lambda^2$ **shares the margin summand's eigenvalue**. The entry's own definition ("$H_s$ in the **joint** $\lambda_m$-eigenspace") then puts three summands into $H_s$, and the residual minimum becomes the $\lambda=0$ margin $\tfrac32\theta_0$, so $\rho=\tfrac32\theta_0-c_p=\tfrac32\theta_0-\tfrac12\theta_0=\theta_0>0$, not $0$. (What genuinely fails at $m=4$ is the **first** input: [L146](../findings/second-order.md) prices $\lVert H\rVert_{op}$ on $S^2_0$ copies only, and says nothing on $\Lambda^2\otimes\Lambda^2$. The lemma has a real obstruction at $m=4$; the one it names is the wrong one.)
- $m=4$ is $n=8$, a single dimension. "$\Theta(n^{-3/2})$ at $m=4$" is an asymptotic statement evaluated at one point of a family, and $n^{-3/2}$ and $n^{-1}$ are not distinguishable there.

**3. Argue the opposite.** Read as a sensitivity remark on the inequality's shape, *if* the coefficient of $w^2$ were $0$, then $g(w)=\sqrt{c_p}/(A+Bw)$ is decreasing, minimised at $w=1$ at $\sqrt{c_p}/(\sqrt n+n)=\Theta(n^{-3/2})$, the sentence is correct algebra, and I confirm that computation. The defect is in attaching it to $m=4$ as a dimension rather than to $\rho\to0$ as a limit.

**Finding.** The conclusion "$m\ge5$ is load-bearing" is **right**, for a reason the entry does not give: at $m=4$ the joint eigenspace acquires a third summand on which [L146](../findings/second-order.md) has no operator-norm bound, and it is the *first* input that fails, not the second.

## 12. Item 14: no argument on file

The brief asserts the closed form is *"$15.5\%$ low at $n=12$"* and that *"at the attained minimum they are $0.9008$ and $0.9794$, and $0.9215$ and $0.9840$ under the admissible envelope"*. Neither "the attained minimum" nor "the admissible envelope" is defined in the brief, and no ratio's two members are named. **This claim has no argument on file, full stop.** For the record, and so the next verifier need not repeat it: under the two readings the brief's own symbols do support, comparing $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ at $n=12$ against $g(1)=\sqrt{c_p+\rho_{12}}/(\sqrt{12}+12)$, and against $g(w_0)$ at L158's kink $w_0=\tfrac23$, the shortfalls are $0.06644/0.06820=2.6\%$ and $0.06644/0.06974=4.7\%$, neither of which is $15.5\%$. I am **not** reporting that as a discrepancy: the definitions are absent, so a third reading may reconcile it, and the candidate fails step 3.

## 13. The trap sweep, every item answered

- **$\ker W\ne0$.** *No finding, and here is why the trap does not reach this statement.* The lemma quantifies over directions $H$ at the single object $W^*=S^m\times S^m$, whose Weyl operator [L145](../findings/second-order.md) records as two-valued **with no kernel**, that trivial kernel is what makes $g_n=\lvert\lambda_-\rvert$ a genuine analyticity radius and the whole chain available. A padded object, where the operator acquires a kernel of dimension $\binom n2-\binom{n_0}2$, has no $g_n$ of this kind and is **outside the statement entirely**; the lemma claims nothing there and must not be read as claiming anything there. The one thing to watch is that the conclusion is written as "$r_n$", with no $W$ and no $H$, which invites exactly that misreading.
- **Boundary of every stated range.** $m\ge5$: §6 finds the $\lvert\kappa_n\rvert$ formula invalid at $m=5$ itself, and §11 finds the $m=4$ reasoning misattributed. $w\in[0,1]$: both endpoints checked, both tight (§9). $\beta$: §10.
- **Smallest admissible dimension.** $m=5$, $n=10$. $\theta_0(10)=\tfrac65$ **exactly** is the witness for §6; $\rho_{10}=0.45$, $\kappa_{10}=4.5$, $g(w^*)=0.064$, the conclusion survives there.
- **Odd $n$.** *A finding, small.* $n=2m$ is forced even by $W^*$; the conclusion is nonetheless written with a free $n$ and an asymptotic ceiling. At odd $n$, [problem.md](../findings/problem.md):347 records that the sphere product does not exist and $\Theta_n\ne\theta_0(n)$, so nothing in the display transfers. One clause ("at even $n$") would close it.
- **Subfamily used in general.** §8, the $w^*$ location claims hold on $n\le16$ and are stated for $m\ge5$.
- **Hypothesis stated but never used.** None found; the swap-of-factors argument is redundant against [L27](../findings/nondegeneracy.md)'s formula but correct and harmless.
- **Step using a hypothesis never stated.** Two: $H\perp W^*$ (§3), $\beta\ge0$ (§10). Plus two uncited imports: [L145](../findings/second-order.md)/[L147](../findings/second-order.md) supply "$\lVert A''\rVert=O(1/\rho)$" and neither is named in the brief.
- **Universal claim with no witness, one object per structured family.** The claim is over directions at $W^*$, so I tested directions rather than tensors. $H=W^*$ itself: $w=1$, $c(H)=-\tfrac32\theta_0$, **the witness of §3**. $H$ in the orbit tangent: $w=1$, $c(H)=0$, excluded, and the exclusion is stated. $H$ in $\Lambda^2\otimes\Lambda^2$: $w=1$, $c(H)=c_p+\rho$ **exactly**, the extremiser, confirming the second input is tight. $H$ pair-concentrated in one $S^2_0$ copy: $w=0$, $\lVert H\rVert_{op}=1/\sqrt{m-1}$, the extremiser of the first input. Diagonal, padded and $\mathbb{CP}^m$-type directions decompose across [L27](../findings/nondegeneracy.md)'s summands and are covered by the convex combination with nothing new. Sphere products and tori as *objects* are out of scope, as above.
- **Imported theorem whose hypotheses were never checked.** See the inventory: [L24](../findings/second-order.md)'s $W^\perp$ restriction is the one that is imported and not checked, and it is exactly the gap of §3.
- **Quantifier order and scope.** The $\min$ over three branches is taken after each branch is bounded uniformly in $w$, which is the safe order and is what "uniformly in $w$" means here. The one place a $\min$ is distributed across terms sharing a variable is the second input, where $\min_i(\tfrac12-\lambda_i)$ is taken over the residual summands and then applied to the whole of $w^2$, legitimate, because $\sum_{i\in r}\lVert H_i\rVert^2=w^2$ exactly, so it is a convex combination and not a distribution. **No finding.**

## 14. What would falsify it, and what I did to look

**The object that would break the lemma** is a direction $H$ at $W^*$, of unit Frobenius norm, orthogonal to $W^*$ and to the orbit tangent, with $\lVert H\rVert_{op}=\Theta(1)$ and $c(H)=o(1)$, a direction that is both low-margin and high-operator-norm, which is precisely what the title denies.

**What I did to look for it.** The margin is a convex combination over [L27](../findings/nondegeneracy.md)'s finitely many summands, so such an $H$ must put $1-o(1)$ of its mass on summands of margin $o(1)$. I enumerated all ten margins at $p=q=m$, $-\tfrac32\theta_0$ on $\langle W\rangle$, $0$ on the orbit, $\tfrac32\theta_0$ on the four zero-eigenvalue summands, $c_p=\tfrac{3\theta_0}{n-2}$ on the two $S^2_0$ copies, $3\theta_0\frac{m-3}{2(m-1)}$ on $\Lambda^2\otimes\Lambda^2$, $3\theta_0(\tfrac12+\mu)$ on $S^2_0\otimes S^2_0$, and checked which can collide, finding that $\lambda_m$ meets another eigenvalue only at $m=4$. For $m\ge5$ the only margins that are $o(1)$ are $c_p$ itself, which forces $w=o(1)$ and hence $\lVert H\rVert_{op}=O(n^{-1/2})$, and the two excluded summands. **So no such direction exists for $m\ge5$, and the lemma's core is sound.** The two summands that *would* produce one are the two the argument removes, one by a stated exclusion, one by an exclusion it forgets to state.

## Verdict

**GAP.**

The headline, no direction is both low-margin and high-operator-norm; branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$; $r_n\gtrsim n^{-1-\beta}$, **is correct**, and every closed form and every one of the eleven numerical values I could check reproduces exactly by hand. What is defective is the perimeter:

1. **$H\perp W^*$ is used and unstated** (§3), witnessed by $H=W^*$ with $c(H)=-\tfrac32\theta_0$.
2. **$\beta\ge0$ is used and unstated** (§10).
3. **"Unsafe exactly on $n\in\{12,14\}$" is false** (§7): the entry's own $\rho^{\mathrm{eff}}_{16}=0.98564<1$; the first safe dimension is $n=18$.
4. **The $\lvert\kappa_n\rvert$ formula is out of range at $m=5$** (§6), the statement's own smallest admissible dimension, where $\theta_0(10)=\tfrac65<\sqrt{3/2}$.
5. **The $w^*$ location claims are a subfamily result stated in general** (§8): $w^*<1$ for $n\ge18$, $w^*<w_0$ for $n\ge20$.
6. **The $m=4$ argument names the wrong failure** (§11): the joint-eigenspace recipe gives $\rho=\theta_0>0$ there, and what actually fails is the operator-norm input.
7. **Two items carry no argument on file**, the $\tfrac29$ (§6a) and the $15.5\%$/four-ratio figures (§12).

Every one of these is repairable in place, none touches the $\Omega(n^{-1})$ order, and item 3 is the one the round can act on immediately, being arithmetic against a number the entry already prints.
