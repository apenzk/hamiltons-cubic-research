# VERIFY v18, Lemma L149, the proof of the uniformity

*Verifier v18, cold brief, on the section headed **"Proof of the uniformity"** in [findings/second-order.md](../findings/second-order.md) (line 1209 ff.) together with the two blockquotes immediately above it, **"THE MARGIN COEFFICIENT"** (line 1203 ff.) and **"HYPOTHESES THE CHAIN USES"** (line 1207). **No numerical work was done**: no script was run, and every value below is an exact hand evaluation of a closed form, carried to seven digits and reported to the precision the record uses. Log: [agent_logs/verify-L149r-v18.log](../agent_logs/verify-L149r-v18.log).*

## Claim table

| # | Claim under review | Verdict |
| --- | --- | --- |
| 1 | $\inf_{w\ge0}g_\rho=\frac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$ | **CORRECT**, derived below; the stationary point is a genuine global minimum on $[0,\infty)$ |
| 2 | $\inf_{[0,1]}g_\rho\ge\inf_{w\ge0}g_\rho$ used without case analysis | **CORRECT AND LEGITIMATE**, a subset inequality; no attainment is needed, and the loss is $0.217\%$ at $n=12$ |
| 3 | "the right-hand side is increasing in $n$" | **FALSE OF THE OBJECT NAMED; TRUE AND UNPROVED OF THE ONE THE PROOF NEEDS**, the displayed right-hand side is $\Theta(n^{-1})$ and decreasing; its $n$-free coefficient is increasing, and no derivation of either is on file |
| 4 | $0.71980/n$ at $n=12$, and $n=12$ is the minimum over the range | **CORRECT**, exact hand value $0.7197978$; minimal over even $n\ge12$ once claim 3 is read as the coefficient |
| 5 | $a_0=\sqrt{2n/(n-2)}$ as the coefficient of $n^{1/2}$ in the denominator | **CORRECT**, $a_0n^{1/2}+nw=n\big(\lVert H_s\rVert_{op}^{\text{bd}}+w\big)$ with L146's $1/\sqrt{m-1}$, and $1/g_n=n\kappa/6$ carries the rest into the prefactor |
| 6 | The three hypotheses listed are the ones the chain uses | **INCOMPLETE**, all three are used, and five more are used and unlisted; the lemma's own "$m\ge5$" contradicts the block's "$m\ge6$" |
| 7 | $\rho^{\mathrm{eff}}_n>0$, increasing from $0.71904$ | **TRUE, NO ARGUMENT ON FILE**, verified at $n=12,14,16$ and in the limit; the monotonicity is asserted |
| 8 | "Hence branch 2 is $\ge0.7198/n$" | **OVERSTATED**, $0.7198/n$ bounds $g_\rho$, and the same file writes branch $2=K\cdot g_\rho$ with $K$ well below $1$ |
| 9 | The $\tfrac29$ in $\rho^{\mathrm{eff}}_n$ | **SOURCED BUT UNCITED**, it is L141(b)'s $\sigma\le\tfrac29$ on the $(2,2)$ four-set block; three other passages of the same file price the same constant at $1$ or record it as unknown |

**Verdict: `GAP`.** Every number in the block is exactly right and the inequality chain is valid, but the two monotonicity facts the constant $0.7198$ rests on are asserted with no derivation anywhere on the record, one of them of the wrong object; and the final sentence transports a bound on $g_\rho$ to "branch 2", which the same file gives a prefactor.

**One line the round can act on.** The mathematics survives; what is owed is three lines, that $\sqrt2\,n/\big(3\sqrt{(n-1)(n-2)}\big)$ and $(\kappa/6)(1+16/n)$ are both decreasing, whence $\rho^{\mathrm{eff}}_n$ rises and the $n$-free coefficient rises with it, plus a correction of "the right-hand side" to "its coefficient", a hypothesis box that lists $\lVert H\rVert_F=1$, $n=2m$ and $m\ge6$, and a sentence saying that $0.7198$ is the constant of $g_\rho$ rather than of branch 2.

## 0. Conventions, fixed once

All of these are read off the record, not chosen here.

- $n=2m$, $W^*$ the unit-norm Weyl tensor of $S^m\times S^m$, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ ([findings/second-order.md](../findings/second-order.md) line 887).
- $c_p=3\theta_0/(n-2)$, the margin on the $\lambda_m$ summand (line 1129), and $\kappa:=nc_p=3\sqrt{2(n-1)/(n-2)}$, so $\kappa^2=18(n-1)/(n-2)$ (line 1261). This $\kappa$ is the margin scale; $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ is the penalty constant, an unrelated symbol, as line 1276 records.
- $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, positive exactly for $n\ge12$ ([findings/route-a.md](../findings/route-a.md) line 196).
- $L_e$ at $S^m\times S^m$ has $\lambda_m=(m-2)/(2(m-1))$ on the two $S^2_0(\mathbb R^m)$ copies, $\pm\mu$ with $\mu=\mu(m,m)=(n-2)/\big(2(m-1)^2\big)=1/(m-1)=2/(n-2)$, then $\tfrac12$ on the orbit tangent and $1$ on $W^*$ ([findings/nondegeneracy.md](../findings/nondegeneracy.md) line 700; reproduced in L133 step 2).
- Margin $=3\theta_0(\tfrac12-\lambda)$ per summand; $w:=\lVert H_r\rVert_F$ is the weight outside **both** $S^2_0$ copies; $\lVert H\rVert_F=1$.
- $g_n=\sqrt{2(n-2)}/\big(n\sqrt{n-1}\big)$, equivalently $1/g_n=n^2c_p/6=n\kappa/6$ (lines 1207 and 1286).
- Exact values used throughout, at $n=12$: $\theta_0=\sqrt{220}/12=1.2360331$, $\kappa=\sqrt{19.8}=4.4497191$, $c_p=\kappa/12=0.3708266$, $a_0^2=24/10=2.4$, $a_0n^{1/2}=12/\sqrt5=5.3665631$, $\lvert\kappa_{12}\rvert=0.1015939$, $\sqrt{3/2}=1.2247449$, $\sqrt6=2.4494897$.

## The hypothesis inventory

**Stated in the block, and used.**

| Hypothesis | Where it bites |
| --- | --- |
| $H\perp W^*$ | Removes the $L_e$-eigenvalue $1$, whose margin $-\tfrac32\theta_0$ is negative; without it the convex combination has no positive floor |
| $H\perp T_{W^*}\mathcal O$ | Removes the eigenvalue $\tfrac12$, margin $0$; without it $c_{\min}=0$ and $\rho^{\mathrm{eff}}_n<0$ |
| $\ker W^*=0$ | Makes $W\mapsto W_-$ analytic at $W^*$, so branch 2 has a domain at all. Holds, with gap $g_n$ |

Nothing stated is unused.

**Used and not stated.**

| Hypothesis | Where it is used | Where it lives on the record |
| --- | --- | --- |
| $\lVert H\rVert_F=1$ | Twice: it makes the margin a convex combination, and it is what puts $w$ in $[0,1]$ rather than $[0,\infty)$ | Line 1194's "on $\lVert H\rVert_F=1$" |
| $n=2m$, $W^*$ the **balanced** product | The whole spectral input; $\mu(m,m)$, the two $S^2_0$ copies and the swap symmetry are all balanced-case facts | Line 887 |
| $m\ge6$ | The block's own body demands it; the boxed **LEMMA L149** still says $m\ge5$ | Line 1191 against line 1200 |
| $\lambda_m>\mu$ | This is what makes $c_p$ the *smallest* margin, so that $H_s$ is the low-margin block and $w$ the safe direction. It fails for $m\le4$ | L146's closing box, "holds for $m\ge5$" |
| $\sigma\le\tfrac29$ on the $(2,2)$ four-set block | The $\tfrac29$ in $\rho^{\mathrm{eff}}_n$ | Line 949–950 and 958, quoting L133 step 2 |
| $\lVert A''\rVert\lesssim\lVert H\rVert_{op}/g_n$ with $M=O(\rho_{\text{disc}})$ | The entire denominator $a_0n^{1/2}+nw$ | L145, L146, and r450/r451 as recorded at line 1160 ff. |

The last row is the largest omission: the box is headed "hypotheses the chain uses" and the denominator's provenance is not among them.

**A notation hazard, unflagged.** $\rho$ denotes the analyticity radius in the display at line 1198 (branch 3 is $\rho(H)/2$, and $\lVert A''\rVert=O(1/\rho)$ four lines above) and the margin coefficient $\rho^{\mathrm{eff}}_n$ in the proof at line 1209. The block flags the $\kappa$/$\kappa_n$ collision and not this one.

## 1. The closed form is correct, and the stationary point sits outside $[0,1]$ at $n=12$

Write $A=a_0n^{1/2}$, $B=n$, so $g_\rho(w)=\sqrt{c_p+\rho w^2}/(A+Bw)$ with $A,B,c_p,\rho>0$. Then

$$\frac{\mathrm d}{\mathrm dw}g_\rho^2=\frac{2\rho w(A+Bw)^2-2B(A+Bw)(c_p+\rho w^2)}{(A+Bw)^4}=\frac{2\big(\rho Aw-Bc_p\big)}{(A+Bw)^3},$$

the $\rho Bw^2$ terms cancelling. The bracket is strictly increasing and vanishes once, at

$$w_*=\frac{Bc_p}{\rho A},$$

so $g_\rho$ decreases on $[0,w_*)$ and increases on $(w_*,\infty)$: $w_*$ is the global minimum on $[0,\infty)$, attained. Substituting,

$$c_p+\rho w_*^2=\frac{c_p\big(\rho A^2+B^2c_p\big)}{\rho A^2},\qquad A+Bw_*=\frac{\rho A^2+B^2c_p}{\rho A},$$

$$g_\rho(w_*)^2=\frac{c_p\big(\rho A^2+B^2c_p\big)}{\rho A^2}\cdot\frac{\rho^2A^2}{\big(\rho A^2+B^2c_p\big)^2}=\frac{\rho c_p}{\rho A^2+B^2c_p}.$$

With $A^2=a_0^2n$, $B^2=n^2$ and $c_p=\kappa/n$ the denominator is $n(\rho a_0^2+\kappa)$ and the numerator $\rho\kappa/n$, giving

$$\inf_{w\ge0}g_\rho=\frac1n\sqrt{\frac{\rho\kappa}{\rho a_0^2+\kappa}}\qquad\textbf{exactly as displayed.}$$

**Where the stationary point sits.** $w_*=Bc_p/(\rho A)=\kappa/\big(\rho a_0n^{1/2}\big)$, and since $a_0n^{1/2}=n\sqrt{2/(n-2)}$ and $\kappa=3\sqrt2\sqrt{(n-1)/(n-2)}$,

$$w_*=\frac{3\sqrt{n-1}}{\rho\,n}.$$

At $\rho=1$ this is line 1274's $3\sqrt{n-1}/n=0.8291562$ at $n=12$, which is that line's $0.82916$, a useful cross-check that the two entries are describing one function. At $\rho=\rho^{\mathrm{eff}}_{12}=0.7190434$ it is $9.9498744/8.6285212=1.153136$, **outside $[0,1]$**; at $n=14$, $\rho=0.8723896$ gives $0.885640$, inside. So $n=12$ is the one dimension in the range where the relaxation is doing real work, and the sentence "no case analysis on the location of the stationary point is needed" is not idle.

## 2. The relaxation is legitimate, and cheap

$[0,1]\subset[0,\infty)$, so $\inf_{[0,1]}g_\rho\ge\inf_{[0,\infty)}g_\rho$ is the subset inequality and nothing more. It needs **only** boundedness below, never attainment; that the right-hand infimum happens to be attained at $w_*$ is a bonus of the derivation, not a hypothesis of the step.

The price, at $n=12$, where the true minimum over $[0,1]$ sits at the endpoint $w=1$ because $w_*>1$:

$$g_\rho(1)=\frac{\sqrt{0.3708266+0.7190434}}{5.3665631+12}=\frac{1.0439684}{17.3665631}=0.0601137,$$

against the bound $0.7197978/12=0.0599831$. The relaxation loses $0.217\%$. Nothing downstream can turn on it.

## 3. The monotonicity claim names the wrong object, and neither version is derived on file

The sentence reads, verbatim (line 1213):

> and the right-hand side is increasing in $n$, equal to $0.71980/n$ at $n=12$.

**The failure, concretely.** The right-hand side of the display is $\frac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$. Its second clause fixes what "the right-hand side" denotes, the whole expression, $1/n$ included, since that is what equals $0.71980/n$. As $n\to\infty$, $\rho\to\sqrt6-\tfrac{\sqrt2}2=1.7423829$, $a_0^2\to2$ and $\kappa\to3\sqrt2$, so the square root tends to $0.9781$ and the right-hand side tends to $0$ like $0.98/n$. It is $0.0599831$ at $n=12$ and below $0.05$ from $n=20$: **strictly decreasing, not increasing.**

**The charitable reading, which is the one the conclusion uses.** The next sentence concludes "branch 2 is $\ge0.7198/n$ for every even $n\ge12$", and that inference needs exactly one thing: that the $n$-free coefficient

$$c(n):=\sqrt{\frac{\rho\kappa}{\rho a_0^2+\kappa}}$$

is minimised at $n=12$. Read as a claim about $c(n)$ the sentence is true, and the argument goes through. So this is a defect of wording, not of mathematics, but the wording is the argument's only statement of its own load-bearing step.

**And the true statement is nowhere derived, here or elsewhere on the record.** It is a two-line fact and I record it as a check rather than as a repair. Invert:

$$\frac1{c(n)^2}=\frac{\rho a_0^2+\kappa}{\rho\kappa}=\frac{a_0^2}{\kappa}+\frac1\rho,\qquad \frac{a_0^2}{\kappa}=\frac{2n/(n-2)}{3\sqrt{2(n-1)/(n-2)}}=\frac{\sqrt2\,n}{3\sqrt{(n-1)(n-2)}}.$$

The first term decreases, because $n^2/\big((n-1)(n-2)\big)=\big(1-3/n+2/n^2\big)^{-1}$ and $\tfrac{\mathrm d}{\mathrm dn}\big(1-3/n+2/n^2\big)=(3n-4)/n^3>0$. The second decreases with $\rho=\rho^{\mathrm{eff}}_n$ increasing, which is section 7. Hence $1/c^2$ decreases and $c$ increases, over the reals from $n=12$ upward and so over the even integers. Both terms attain their maximum at $n=12$ simultaneously, so the bound is exactly $c(12)$ and not merely an estimate of it.

## 4. $0.71980$ at $n=12$ is exact, and it is the minimum

$\rho^{\mathrm{eff}}_{12}$ first, from the box's own formula, using $\tfrac29\lvert\kappa_n\rvert=2\big(\theta_0-\sqrt{3/2}\big)$:

$$3\theta_0\frac{n-8}{2(n-2)}\bigg|_{n=12}=0.6\,\theta_0=0.7416198,\qquad \tfrac29\lvert\kappa_{12}\rvert=2(1.2360331-1.2247449)=0.0225764,$$

$$\rho^{\mathrm{eff}}_{12}=0.7416198-0.0225764=0.7190434,$$

which is the box's $0.71904$. Then

$$\rho\kappa=0.7190434\times4.4497191=3.1995413,\qquad \rho a_0^2+\kappa=1.7257042+4.4497191=6.1754233,$$

$$\frac{\rho\kappa}{\rho a_0^2+\kappa}=0.5181088,\qquad c(12)=\sqrt{0.5181088}=0.7197978 .$$

Cross-checked by the reciprocal route of section 3: $a_0^2/\kappa=2.4/4.4497191=0.5393589$ and $1/\rho=1.3907366$ sum to $1.9300955$, whose reciprocal square root is $1/1.3892791=0.7197977$. So the record's $0.71980$ is right to all five digits it prints, and $0.7198$ to four.

Minimality over the stated range follows from section 3's monotonicity and nothing else. Two remarks worth keeping:

- $0.71980$ and $0.71904$ sit eight lines apart and differ by a transposition of digits. They are genuinely different quantities, the second is $\rho^{\mathrm{eff}}_{12}$, the first is $\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$ at that $\rho$, and both are correct. The near-coincidence is arithmetic accident and a transcription hazard.
- The coefficient rises only from $0.71980$ to $0.9781$ across the whole range, so the bound is within $36\%$ of its ceiling at the worst dimension.

## 5. $a_0$ belongs where it is placed

The denominator is $n$ times the record's bound on $\lVert H\rVert_{op}$:

$$a_0n^{1/2}+nw=n\left(\sqrt{\frac2{n-2}}+w\right),\qquad a_0n^{1/2}=n\sqrt{\frac2{n-2}}\iff a_0=\sqrt{\frac{2n}{n-2}},$$

and $\sqrt{2/(n-2)}=1/\sqrt{m-1}$ is exactly **LEMMA L146**'s supremum for $\lVert H_s\rVert_{op}$, attained at the pair-concentrated $h$; $\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F=w$ supplies the second term. So $a_0$ is the right constant and the right power of $n$ accompanies it.

The factor that converts an operator-norm bound into $\lVert A''\rVert$ is $1/g_n=n\kappa/6$, so

$$\lVert A''\rVert\;\lesssim\;\frac{\lVert H\rVert_{op}}{g_n}\;\le\;\frac\kappa6\big(a_0n^{1/2}+nw\big),$$

which is why $n$, and not $n^{3/2}$, multiplies $w$: $g_n^{-1}=\Theta(n)$, not $\Theta(n^{3/2})$. The residual $\kappa/6$ is $n$-dependent, $0.7416$ at $n=12$, falling to $\sqrt2/2$, and is absorbed into the prefactor, where it *helps*, since $6/\kappa\ge1.3484$ throughout. That absorption is legitimate for an $\Omega(n^{-1})$ statement and is the subject of section 8 for the numeral.

**Two suppressed constants both run the safe way**, which is worth recording since neither is mentioned:

- the envelope is unkinked, $\lVert H\rVert_{op}\le\sqrt{2/(n-2)}+w$ rather than line 1288's homogeneous $\sqrt{2/(n-2)}\sqrt{1-w^2}+w$ or line 1286's $\min(\cdot,1)$; a larger denominator gives a smaller lower bound, so the loss is conservative;
- the numerator uses $\rho^{\mathrm{eff}}_n=0.7190$ rather than the bullet's penalty-free $3\theta_0\frac{m-4}{2(m-1)}=0.7416$ at $n=12$; smaller is again conservative.

## 6. Hypotheses: the range, and the coefficient's provenance

The inventory above is the finding. Two items deserve their own derivation, because I checked them against the objects rather than taking them on the block's word.

**The coefficient is $c_{\min}-c_p$, and the arithmetic is exact.** The margin is $3\theta_0(\tfrac12-\lambda)$ per $L_e$-summand and quadratic, so on $\lVert H\rVert_F=1$ it is the convex combination $c(H)=\sum_jc_j\lVert H_j\rVert^2\ge c_p(1-w^2)+c_{\min}w^2=c_p+(c_{\min}-c_p)w^2$. With $W^*$ and the orbit tangent excluded by the two stated hypotheses, the surviving eigenvalues are $\lambda_m$, $\pm\mu$ and $0$, whose margins in units of $3\theta_0/\big(2(m-1)\big)$ are $1$, $m-3$, $m+1$ and $m-1$. The smallest is the $+\mu$ one, so $c_{\min}=3\theta_0\frac{m-3}{2(m-1)}$ and

$$c_{\min}-c_p=3\theta_0\frac{(m-3)-1}{2(m-1)}=3\theta_0\frac{m-4}{2(m-1)}=3\theta_0\frac{n-8}{2(n-2)},$$

so the bullet's $m$-form and the box's $n$-form are one quantity, as the box says, and the box's attribution of $c_{\min}$ to the $\Lambda^2\!\otimes\!\Lambda^2$ summand is right: $+\mu$ carries multiplicity $c_mc_m=\binom m2^2$, which is the $(2,2)$-split four-sets. A candidate discrepancy, that the bullet names $\frac{m-3}{2(m-1)}$ as the smallest margin while the coefficient used is $\frac{m-4}{2(m-1)}$, is **withdrawn**: the second is the first minus the $\lambda_m$ margin, exactly as a convex combination requires.

**The $\tfrac29$ is sourced, and the record contradicts itself about it.** L141(b), at line 949, prices the penalty on the $(2,2)$ four-set block as $+\tfrac29\lvert\kappa_n\rvert s$ with $s$ the defect-active weight fraction, "that is, at $\sigma=\tfrac29$, L133's own step-2 bound", and line 958 repeats that $\sigma\le\tfrac29$ holds "on the only block where $\sigma\ne0$". Since the defect-active block is the $(2,2)$ four-sets, which lie in $H_r$, this gives $u^2\le\tfrac29w^2$ and hence $\rho^{\mathrm{eff}}_n=(c_{\min}-c_p)-\tfrac29\lvert\kappa_n\rvert$. So the constant is right. But **three passages of the same file say otherwise**: line 1219, eight lines below the proof, prices the same penalty at coefficient $1$ from $u\le w$ and reports the net as $\tfrac32\theta_0-\lvert\kappa_n\rvert\to0.4161$; line 1352 calls "the $u\lesssim w$ dependency" a constant "unknown under the route L149 actually cites"; line 1413 records it as unknown, crediting r452 B4. Had the coefficient been $1$ the consequences would be large and I state them so the choice is visible: $\rho$ would read $9\sqrt{3/2}-\theta_0\frac{15n-12}{2(n-2)}$, that is $0.6400259$ at $n=12$ and $0.6138328$ at $n=14$, **decreasing** to $9\sqrt{3/2}-\tfrac{15\sqrt2}2=11.0226938-10.6066017=0.4160921$; the coefficient would read $0.689771$ at $n=12$ and fall, with a uniform floor of $0.582938$ from $a_0^2/\kappa\le0.5393589$ and $\rho\ge0.4160921$. The $\Omega(n^{-1})$ conclusion survives either reading. The numeral $0.7198$, and the direction of the monotonicity in $n$, do not.

**The range.** The boxed lemma says "For $m\ge5$"; the body six lines above says $m\ge6$, and L146's own condition $\lambda_m>\mu$, which is what puts the minimum margin on the $S^2_0$ summands, and so what makes $w$ the safe coordinate, first holds at $m=5$. The smallest admissible dimension for the proof as written is therefore $m=6$, that is $n=12$: at $m=5$ the block's stated reason ($\lvert\kappa_{10}\rvert<0$, since $\theta_0(10)=6/5<\sqrt{3/2}$) is a sign-convention failure rather than an undefinedness, $3\theta_0\frac{m-4}{2(m-1)}-2(\theta_0-\sqrt{3/2})$ evaluates to $0.4994898$ at $n=10$, but the conclusion is unaffected, since $n\ge12$ is forced independently by $\theta_0(n)>\sqrt{3/2}$. **The lemma statement's "$m\ge5$" is stale and should read $m\ge6$.**

## 7. $\rho^{\mathrm{eff}}_n>0$ across the range: true, asserted, and needed

Substituting $\tfrac29\lvert\kappa_n\rvert=2\theta_0-2\sqrt{3/2}$ and $\theta_0/(n-2)=\kappa/(3n)$,

$$\rho^{\mathrm{eff}}_n=\theta_0\left[\frac{3(n-8)}{2(n-2)}-2\right]+2\sqrt{\tfrac32}=2\sqrt{\tfrac32}-\theta_0\frac{n+16}{2(n-2)}=\sqrt6-\frac\kappa6\left(1+\frac{16}n\right).$$

Both factors of the subtrahend are positive and strictly decreasing ($\kappa^2=18\big(1+1/(n-2)\big)$ and $1+16/n$) so $\rho^{\mathrm{eff}}_n$ is **strictly increasing**, with limit $\sqrt6-\tfrac{3\sqrt2}6=\sqrt6-\tfrac{\sqrt2}2=1.7423829$, which is the box's $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})$. Hand values: $0.7190434$ at $n=12$, $0.8723896$ at $n=14$ (from $\theta_0(14)=\sqrt{312}/14=1.2616801$ and $\tfrac{30}{24}=1.25$), $0.9856396$ at $n=16$ (from $\theta_0(16)=\sqrt{420}/16=1.2808688$ and $\tfrac{32}{28}$). Every one agrees with the record.

**No argument for this is on file**, the box asserts "increasing from $0.71904$ … to $1.74238$" and stops. The conclusion needs more than positivity: positivity alone gives $\Omega(n^{-1})$ with an unnamed constant, while the numeral $0.71980$ and the phrase "for every even $n\ge12$" need the infimum of $\rho^{\mathrm{eff}}_n$ to sit at $n=12$. So the missing derivation is load-bearing for the headline and not for the order.

## 8. "Branch 2 is $\ge0.7198/n$" is a statement about $g_\rho$

What the proof bounds is $g_\rho$. What the same file calls branch 2 is, at line 1279,

$$\text{branch }2=\underbrace{\frac{\lambda(1-\eta^*)^2}{\sqrt2\,J}}_{K}\cdot\frac{\sqrt{c_p+w^2}}{a_0n^{1/2}+nw},$$

with $(1-\eta^*)^2\to0.808$ and $6.9421\le J^*<8$ in scope, so $K$ is smaller than $1$ by better than an order of magnitude. The closing sentence therefore transports a constant across a factor the file records elsewhere.

**The charitable reading, which I accept as far as it goes.** The chain at line 1198 is written with $\gtrsim$, so "branch 2" there names the displayed quotient with constants suppressed, and the sentence is then a statement about that surrogate. It is fair as an order statement. It is unsafe the moment the numeral is used quantitatively, and it is: L158's branch comparison at line 1254 ff. turns on the *ratio* of the branch infima, where a suppressed $K$ in one branch and not the other decides the answer.

## What would break this, and what I did to look for it

**The object.** An admissible direction $H$ (unit Frobenius norm, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, at $n=12$), supported on the $(2,2)$-split four-sets with defect response $u>\sqrt{2/9}\,w=0.4714\,w$. Any such direction lowers $\rho^{\mathrm{eff}}_{12}$ below $0.7190434$ and the constant below $0.7197978$, and one with $u$ near $w$ drops the constant to $0.689771$ and reverses the monotonicity in $n$. The block's own line 1219 asserts only $u\le w$, which permits it.

**What I did.** I traced the $\tfrac29$ to L141(b) at line 949–950 and its citation of L133 step 2, and read L133 step 2's support-table argument: $\mathrm{Alt}\circ DW_-$ is supported on the $(2,2)$ four-set blocks alone, with maximiser set the span of the $\binom m2^2$ L26 directions, which is where the L149 penalty is said to land, so the two agree on the block. I did **not** re-derive $\sigma\le\tfrac29$ itself; it rests on L133's step-2 bound, which is the outstanding dependency. I then grepped [findings/](../findings/) for every statement about the $u$-to-$w$ constant and found the three passages of section 6 that price it at $1$ or record it as unknown. No direction exhibiting $u>0.4714\,w$ is on the record, and none was constructed here.

**A second object, cheaper to find.** Any $n$ in the range at which $\sqrt2\,n/\big(3\sqrt{(n-1)(n-2)}\big)+1/\rho^{\mathrm{eff}}_n$ exceeds its value $1.9300955$ at $n=12$ would falsify claim 4's minimality. Both summands are decreasing by section 3 and section 7, so none exists; the check is closed in closed form rather than by search.

## Disclosure

Two lines of [verification/ROUND_L149.md](ROUND_L149.md) surfaced in a grep for the numerals $0.71904$ and $0.71980$ before I could exclude the file, and they carried $\rho^{\mathrm{eff}}$ at $n=14$ and $n=16$. Both values had already been derived here from the closed form and are reported above as my own hand evaluations. No verifier report was opened.
