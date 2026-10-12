# VERIFY v82, L149's uniformity theorem, its $\tfrac29$ identity, its penalty coefficient, and the three clauses its box asserts

*Cold read of [findings/second-order.md](../findings/second-order.md):1211–1264 as dispatched in [ROUND_L149r2.md](ROUND_L149r2.md). No script was run and no numerical work was done: every value below is an exact hand evaluation from the constants the entry itself names, and each is marked reproduced or not. Log: [agent_logs/verify-L149r2-v82.log](../agent_logs/verify-L149r2-v82.log).*

## Claim table

| # | Claim as the entry makes it | Verdict |
|---|---|---|
| C1 | The uniformity theorem: $\inf_{w\in[0,1]}g_\rho\ge\tfrac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$, equal to $0.7197978/n$ at $n=12$ and minimal there | **PROVEN** |
| C2 | $\rho^{\mathrm{eff}}_n=\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$, positive and strictly increasing on $n\ge12$ | **PROVEN** |
| C3 | The $\tfrac29$ is an identity, not a bound, and the entry uses it as one | **PROVEN, and it is an identity** |
| C4 | $c(H)\ge c_p+\rho^{\mathrm{eff}}_nw^2$ as a convex combination over L27's summands, margin and penalty on one summand | **PROVEN** |
| C5 | Box clause: "the first is minimised at $w=0$" | **OWED, the entry says so itself** |
| C6 | Box clause: "the validity branch is $\Omega(n^{-1})$ as well" | **NO ARGUMENT ON FILE, one line from the entry's own material** |
| C7 | "The penalty term": net coefficient $\tfrac32\theta_0-\lvert\kappa_n\rvert\to0.416$, "positive by 20%" | **BROKEN AS WRITTEN, the excluded coefficient-$1$ reading; conclusion survives** |
| C8 | "$K<1$ by better than an order of magnitude" | **NOT REPRODUCED, $K\approx0.3$, a factor of $3$** |
| C9 | The box carries the lemma's hypotheses | **NO, all four sit outside it** |
| C10 | The record's other forms of L149 agree with this one | **NO, [plan.md](../plan.md) and [L158](../findings/second-order.md) each differ** |

**Summary in one line.** The uniformity theorem and the $\tfrac29$ identity are both correct and both reproduce to the last digit the entry prints, but the box asserts three clauses and the entry proves one; the penalty paragraph still carries the coefficient-$1$ arithmetic the $\tfrac29$ box declares excluded; and three neighbouring files carry L149 in three incompatible forms. **Verdict: `GAP`.**

## 0. Conventions, fixed once

$n=2m$; $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$; $L_e$'s ten summand values are [L27](../findings/nondegeneracy.md)'s; the margin of a summand at $L_e$-value $\lambda$ is $3\theta_0(\tfrac12-\lambda)$; $\mu=\mu_{m,m}=\tfrac2{n-2}=\tfrac1{m-1}$ and $\lambda_m=\tfrac{m-2}{2(m-1)}$; $c_p$ is the margin on the two $S^2_0(\mathbb R^m)$ copies; $w=\lVert H_r\rVert_F$ on $\lVert H\rVert_F=1$; $\kappa:=nc_p$; $\kappa_n:=9(\sqrt{3/2}-\theta_0(n))$ is [L133](../findings/second-order.md)'s signed constant, negative for $n\ge12$, so the entry's $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ is its negation. All decimals are hand evaluations of these closed forms.

## 1. The hypothesis inventory

**Hypotheses the statement carries.** One: $m\ge6$.

**Hypotheses the written proof uses.**

| Hypothesis | Where it is used | Where the entry states it |
|---|---|---|
| The base point is $W^*=S^m\times S^m$ | every constant in the entry | the section title and the provenance line, **not the box** |
| $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, i.e. $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ | excludes $\langle W\rangle$'s negative margin and the orbit's zero margin from the convex combination | the **HYPOTHESES THE CHAIN USES** box, three boxes below the statement |
| $\lVert H\rVert_F=1$ | the convex-combination step and $w\in[0,1]$ | nowhere |
| $\ker W^*=0$ | analyticity of $W\mapsto W_-$, hence branches 2 and 3 have a domain at all | the **HYPOTHESES** box |
| $m\ge6$ | the sign of $\kappa_n$ | the box, and the bullet's aside |

**Hypotheses of every imported result, checked against the object.**

- **[L27](../findings/nondegeneracy.md)** needs $p,q\ge3$, $(p,q)\ne(3,3)$. At $p=q=m\ge6$: satisfied. Its multiplicity-freeness is what makes $L_e$ a scalar per summand and hence makes the margin a genuine quadratic form with one coefficient per summand, the whole of C4 rests on it.
- **[L26](../findings/nondegeneracy.md)/L27's separation of $\mu$** needs $\mu\notin\{1,\tfrac12,\lambda_m,0,-\mu\}$. Computed: $\mu=\tfrac1{m-1}$, so $\mu=\tfrac12$ at $m=3$ and $\mu=\lambda_m$ at $m=4$; separation holds from $m\ge5$. The entry's "$m\ge5$" for this step is **exactly right**, neither loose nor tight.
- **[L146](../findings/second-order.md)** is stated for the Weyl image of a **single** $h$ at $m\ge3$, with $\lVert H\rVert_{op}\le1/\sqrt{m-1}$ at $\lVert H\rVert_F=1$. I re-derived the extremal: the pair-concentrated $h=c(1,1,-\tfrac2{m-2},\dots)$ has $\lVert h\rVert^2=2c^2\tfrac m{m-2}$, so $\lVert H\rVert_F=1$ forces $c=\sqrt{m-1}/m$ and $\tfrac m{2(m-1)}\cdot2c=1/\sqrt{m-1}$, attained, as L146 says. L149 applies it to the **joint two-copy** eigenspace; L146's own box licenses that explicitly, the cross-plane branch capping at $\sqrt{m-2}/m$ against $1/\sqrt{m-1}$ because $(m-1)(m-2)<m^2$. **Hypothesis met, and the licence is on file rather than assumed.**
- **[L133](../findings/second-order.md)** needs $n=2m\ge12$; met.
- **[L148](../findings/second-order.md)** supplies the vanishing of the defect on the joint margin summand; used for $u\le w$ and for the $\Omega$-not-$\Theta$ remark.
- **[L147](../findings/second-order.md)/[L145](../findings/second-order.md)** supply $\lVert A''\rVert=O(1/\rho)$ through $M=O(\rho)$. **Inherited defect, recorded here because the entry is silent on it:** the source's own box at [second-order.md](../findings/second-order.md):1206 records that L147 justifies $M=O(\rho)$ by "$x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm", that the cited source states this **on Hermitian operators** and that those three words are dropped, and that "the entry cited the wrong one of its two" derivations. L149's entire denominator rests on that step and never mentions it. Per the record's own note the conclusion is not in doubt (a complex-valid resolvent derivation exists in the same review) so this is an uncited dependency on a known-defective citation, not a debt.

**Which hypotheses the written proof uses that the statement omits: four.** Base point, domain, $\lVert H\rVert_F=1$, $\ker W^*=0$. See §7.

## 2. The uniformity theorem, C1, derived in full

Write $g_\rho(w)=\sqrt{c_p+\rho w^2}\big/(a_0n^{1/2}+nw)$, $c_p=\kappa/n$.

Minimising $F=g_\rho^2$: $F'=0$ gives $\rho w(a_0\sqrt n+nw)=n(c_p+\rho w^2)$, so $\rho wa_0\sqrt n=nc_p$ and
$$w^*=\frac{\sqrt n\,c_p}{\rho a_0}=\frac{\kappa}{\rho a_0\sqrt n}.$$
Then $c_p+\rho w^{*2}=\tfrac\kappa n\cdot\tfrac{\rho a_0^2+\kappa}{\rho a_0^2}$ and $a_0\sqrt n+nw^*=\sqrt n\cdot\tfrac{\rho a_0^2+\kappa}{\rho a_0}$, whence
$$F(w^*)=\frac{\kappa\rho}{n^2(\rho a_0^2+\kappa)},\qquad g_\rho(w^*)=\frac1n\sqrt{\frac{\rho\kappa}{\rho a_0^2+\kappa}}.$$
**The displayed formula is exactly right.** It is the global minimum on $[0,\infty)$: $F(w^*)/F(0)=\rho a_0^2/(\rho a_0^2+\kappa)<1$ and $F(w^*)/F(\infty)=\kappa/(\rho a_0^2+\kappa)<1$. And $\inf_{[0,1]}\ge\inf_{[0,\infty)}$ is trivial, so **"no case analysis on the location of the stationary point is needed" is correct for this $g_\rho$.**

**The $n$-free coefficient.** $n\cdot\inf=\big(a_0^2/\kappa+1/\rho\big)^{-1/2}$. With $a_0^2=2n/(n-2)$ and $\kappa=3\sqrt{2(n-1)/(n-2)}$,
$$\frac{a_0^2}{\kappa}=\frac{2n}{3(n-2)}\sqrt{\frac{n-2}{2(n-1)}}=\frac{\sqrt2\,n}{3\sqrt{(n-1)(n-2)}},$$
**exactly the entry's expression.** It decreases in $n$, since $n^2/((n-1)(n-2))=\big(1-\tfrac3n+\tfrac2{n^2}\big)^{-1}$ and $\tfrac3n-\tfrac2{n^2}$ decreases for $n\ge2$; and $1/\rho$ decreases by C2. So the coefficient **increases** in $n$, proved, as claimed.

**The numeral.** $\theta_0(12)=\sqrt{55}/6=1.2360331$; $\kappa=3\sqrt{22/10}=4.4497190$; $a_0^2/\kappa=4/\sqrt{55}=0.5393599$; $\rho=\rho^{\mathrm{eff}}_{12}=0.7190434$, so $1/\rho=1.3907366$; sum $=1.9300965$; $(\cdot)^{-1/2}=0.7197978$. **Reproduced to all seven printed digits.**

**And $\kappa=3\theta_0n/(n-2)=3\sqrt{2(n-1)/(n-2)}$**, the two forms agree because $\sqrt{2(n-1)(n-2)}/(n-2)=\sqrt{2(n-1)/(n-2)}$. At $n=12$, $4.4497$. **Reproduced.** The warning line reproduces too: $\lvert\kappa_{12}\rvert=9(1.2360331-1.2247449)=0.1015939$, ratio $4.4497190/0.1015939=43.80$ against the printed $43.8$; substituting it gives $(2.4/0.1015939+1.3907366)^{-1/2}=(25.0142)^{-1/2}=0.199943$ against the printed $0.19994$; and with the **signed** $\kappa_{12}<0$ the radicand $\rho\kappa/(\rho a_0^2+\kappa)$ is negative since $\rho a_0^2+\kappa=1.7257-0.1016>0$. **All three reproduced.**

**One live fact the entry does not state, and it is favourable.** At $n=12$, $w^*=\kappa/(\rho a_0\sqrt n)=4.4497190/(0.7190434\times1.5491933\times3.4641016)=1.15313>1$. So $g_\rho$ is **decreasing throughout $[0,1]$** and its infimum there sits at $w=1$, worth $\sqrt{c_p+\rho}/(a_0\sqrt{12}+12)=1.0439603/17.3665631=0.0601133$, i.e. coefficient $0.72136$. The claimed $0.71979$ is a valid non-tight relaxation. **No finding, the relaxation is what makes the case analysis unnecessary, and its direction is the safe one.**

## 3. Positivity and monotonicity, C2, derived in full

$$\rho^{\mathrm{eff}}_n=3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\cdot9(\theta_0-\sqrt{3/2})=\theta_0\Big[\tfrac{3(n-8)}{2(n-2)}-2\Big]+2\sqrt{3/2}=\sqrt6-\theta_0\tfrac{n+16}{2(n-2)},$$
since $3(n-8)-4(n-2)=-(n+16)$ and $2\sqrt{3/2}=\sqrt6$. **The closed form is derived, not asserted.**

**Monotonicity.** $\theta_0\tfrac{n+16}{2(n-2)}=\tfrac{n+16}{2n}\sqrt{\tfrac{2(n-1)}{n-2}}=\tfrac{n+16}{6n}\kappa$, and $\tfrac{n+16}{6n}=\tfrac16+\tfrac{8}{3n}$ and $\kappa=3\sqrt{1+\tfrac1{n-2}}$ are both positive and strictly decreasing. **The factorisation is exact and the argument is correct.**

**Positivity.** $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac{\sqrt{55}}6\cdot\tfrac75=\sqrt6-\tfrac{7\sqrt{55}}{30}$; squaring, $6>\tfrac{49\cdot55}{900}$, i.e. $5400>2695$. **Reproduced.** The cubic: $12n^2(n-2)-(n-1)(n+16)^2=12n^3-24n^2-(n^3+31n^2+224n-256)=11n^3-55n^2-224n+256$, worth $19008-7920-2688+256=8656$ at $n=12$. **Both reproduced exactly.**

**The endpoints.** $\rho^{\mathrm{eff}}_{12}=2.4494897-1.7304463=0.7190434$ against the printed $0.71904$; the limit is $\sqrt6-\tfrac{\sqrt2}2=1.7423829$, and the entry's $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})$ is the same number rearranged. **Both reproduced.**

**The range this proof is valid on.** The closed form is monotone and positive for every real $n>2$, but it coincides with the penalised margin only where $\theta_0(n)\ge\sqrt{3/2}$, i.e. where $n^2-12n+8\ge0$, i.e. $n\ge6+2\sqrt7=11.2915$. So $n\ge12$ is the exact edge, and the lemma is stated there. **No finding, the proof is used precisely in range.** *The entry never names $6+2\sqrt7$; [plan.md](../plan.md):137 does, as $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$'s pole.*

## 4. The $\tfrac29$, pre-registered question 2, answered

**It is an identity, it is proved to be one, and the entry uses it as one.**

From [L133](../findings/second-order.md) step 2, in the signed coordinates of a $(2,2)$ four-set block, $\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac\gamma3x^2$ and $\lVert H\rVert^2=\gamma(x^2+y^2+z^2)$, with $\mathrm{Alt}\,DW_-$ vanishing identically on $(3,1)$ and $(4,0)$ blocks and on all diagonal and pair blocks. So the entry's $\sigma=x^2/\big(3(x^2+y^2+z^2)\big)$ is exactly the block ratio, $\gamma$ cancelling.

**The bound.** On $x+y+z=0$, minimising $y^2+z^2$ at fixed $x$ gives $y=z=-x/2$ and $y^2+z^2=x^2/2$, so $x^2/(x^2+y^2+z^2)\le\tfrac23$ and $\sigma\le\tfrac29$, with equality exactly on $\mathbb R(2,-1,-1)$. **Reproduced.**

**The identity.** Writing $H=\alpha(2,-1,-1)+\beta(0,1,-1)$ (the whole of $\mathbf1^\perp$, as L133 step 4 does), gives $x=2\alpha$, $\lVert H\rVert^2=\gamma(6\alpha^2+2\beta^2)$ and $\lVert\Pi_{\mathbb RX}H\rVert^2=6\gamma\alpha^2$. Then
$$\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac\gamma3(2\alpha)^2=\tfrac{4\gamma\alpha^2}3,\qquad \tfrac29\lVert\Pi_{\mathbb RX}H\rVert^2=\tfrac29\cdot6\gamma\alpha^2=\tfrac{4\gamma\alpha^2}3.$$
**Equal, for every $\alpha,\beta,\gamma$, $\beta$ drops from both sides and $\gamma$ from neither side's ratio.** That is precisely the entry's "$\gamma$ and $\beta$ cancelling", and it is right. Summing over blocks and using that both sides vanish off the $(2,2)$ blocks gives $\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2=\tfrac29\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2$ on all of $\mathcal W_n$. **PROVEN.**

**And the identity is what the entry needs, not the bound.** The bound $\sigma\le\tfrac29$ alone would license $\rho^{\mathrm{eff}}_n\le c_{\min}-c_p-\tfrac29\lvert\kappa_n\rvert$ only if the penalty were known to be concentrated where the margin is smallest. The identity supplies exactly that: the penalty is **zero** on every summand other than $\Lambda^2\otimes\Lambda^2$, so the per-summand coefficients are $c_j$ for $j\ne\Lambda^2\otimes\Lambda^2$ and $c_{\min}-\tfrac29\lvert\kappa_n\rvert$ there, and the minimum over surviving summands is the latter. **The convex combination has the form the entry claims it has.** A quantity merely bounded would leave open a summand where the penalty is $\tfrac29\lvert\kappa_n\rvert$ and the margin larger but not larger by enough, the identity closes that.

**The identification $E_{L_e}(\mu)=\Lambda^2\otimes\Lambda^2=\bigoplus_{(2,2)}\mathbb RX_{ijkl}$.** $X_{ijkl}=(1,0,0)-\tfrac13(1,1,1)=\tfrac13(2,-1,-1)$ is the orthogonal projection of the coordinate line onto the Bianchi plane, and L133 step 3 names $(2,-1,-1)$ as the $+\mu$ eigenvector; there is one per $(2,2)$ four-set, i.e. $\binom m2^2$ of them, pairwise orthogonal because distinct four-set blocks are; and L27 gives $\dim E_{L_e}(\mu)=\dim(\Lambda^2\otimes\Lambda^2)=\binom m2^2$ once $\mu$ is separated from the other nine values, which holds from $m\ge5$ (§1). Equal dimensions inside a containment force equality. **Every step checks.**

## 5. The convex combination and $\rho^{\mathrm{eff}}$, C4

L27's values give the margins $3\theta_0(\tfrac12-\lambda)$:

| summand | $L_e$ | margin | status |
|---|---|---|---|
| $\langle W\rangle$ | $1$ | $-\tfrac32\theta_0$ | excluded by $H\perp W^*$ |
| $\mathbb R^p\otimes\mathbb R^q$ (orbit) | $\tfrac12$ | $0$ | excluded by $H\perp T_{W^*}\mathcal O$, and $E(\tfrac12)$ **equals** the orbit tangent by L27 |
| $S^2_0(\mathbb R^m)$, both copies | $\lambda_m$ | $3\theta_0\tfrac1{2(m-1)}=c_p$ | the margin summand |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu$ | $3\theta_0\tfrac{m-3}{2(m-1)}=c_{\min}$ | smallest surviving |
| $S^2_0\otimes S^2_0$ | $-\mu$ | $3\theta_0\tfrac{m+1}{2(m-1)}$ | larger |
| the remaining four | $0$ | $\tfrac32\theta_0=3\theta_0\tfrac{m-1}{2(m-1)}$ | larger |

**Three consistency checks that all pass exactly.** (i) $c_p=3\theta_0/(2(m-1))=3\theta_0/(n-2)$ agrees with $\kappa=nc_p=3\theta_0n/(n-2)$, independently derived in §2, so the entry's $c_p$ and its $\kappa$ are one quantity. (ii) $c_{\min}-c_p=3\theta_0\tfrac{m-4}{2(m-1)}$, the bullet's coefficient, and under $n=2m$ this is $3\theta_0\tfrac{n-8}{2(n-2)}$, the box's, **the two forms are the same quantity, as claimed.** (iii) $c_{\min}$ is smallest among survivors because $m-3<m-1$ and $m-3<m+1$.

Then $c(H)=c_p\lVert H_s\rVert^2+\sum_{j\ne s}c_j\lVert\Pi_jH\rVert^2\ge c_p(1-w^2)+c_{\min}w^2$, and subtracting the penalty, which by §4 lands on $\Lambda^2\otimes\Lambda^2$ alone, gives $c_p+\rho^{\mathrm{eff}}_nw^2$. **PROVEN.** The three "range matters" claims reproduce: $3\theta_0\tfrac{m-3}{2(m-1)}$ is $0$ at $m=3$, ties $c_p$ at $m=4$ (both $\tfrac{3\theta_0}6$), and equals $\tfrac34\theta_0$ at $m=5$ exactly.

**The bullet's other numerals.** $3\theta_0\tfrac{m-4}{2(m-1)}$ is $\tfrac{\sqrt{55}}{10}=0.7416198$ at $n=12$, $3\cdot\tfrac{\sqrt{312}}{14}\cdot\tfrac14=0.9462601$ at $n=14$, and $3\cdot\tfrac{\sqrt{420}}{16}\cdot\tfrac27=1.0978875$ at $n=16$, so it first reaches $1$ at $n=16$ and is below $1$ exactly on $n\in\{12,14\}$. **All reproduced.** The L146 cross-check reproduces too: $\sqrt{m-2}/m=\tfrac26=0.3333$ against $1/\sqrt{m-1}=1/\sqrt5=0.4472$ at $m=6$.

## 6. The named trap, where each factor is read

*The uniformity proof consumes a numerator and a denominator established at different points of the same variable. Every place the entry evaluates a branch:*

| place | numerator, read at | denominator / coefficient, read at |
|---|---|---|
| branch 2, $g_\rho(w)$ | $c(H)\ge c_p+\rho^{\mathrm{eff}}_nw^2$: **general $w$**, its two constants being the $w=0$ and $w=1$ endpoints of one convex combination | $\lVert H_r\rVert_{op}\le w$ at **general $w$**; $\lVert H_s\rVert_{op}\le a_0n^{-1/2}\lVert H_s\rVert_F$ at **$\lVert H_s\rVert_F=1$, i.e. $w=0$** |
| the infimum | both at $w^*=\kappa/(\rho a_0\sqrt n)$, one function | same |
| the numeral | $\rho,\kappa,a_0$ all at $n=12$ | same |
| $\rho^{\mathrm{eff}}_n$ | $c_{\min},c_p,\lvert\kappa_n\rvert$ all at the same $n$ | same |
| branch 1, $f'(0)=-ac_p/S^2$ | $c_p$ at $u=0$ | $a,S$ constants; **correct**, $f'(u)=[2u(S+au)-a(c_p+u^2)]/(S+au)^2$ |
| the reader-reported minimisation of $(c_p+w^2)/(S+n\max(n^{-1/2},w)w)$ | $u$ **substituted by** $w$ | the entry's own italic four lines above says "$u$ … is **not** $w$"; flagged unadjudicated |
| **"The penalty term" paragraph** | $\tfrac32\theta_0$ at **$n\to\infty$** | $\lvert\kappa_n\rvert$ at **$n\to\infty$**, and coefficient $1$ rather than $\tfrac29$, see §8 |

**The trap is present in branch 2 and it is disclosed.** The numerator is read at general $w$ while the denominator's first term is read at $w=0$. Its direction is the safe one (a larger denominator gives a smaller $g_\rho$ and the claim is a lower bound) and the entry says so in the bullet: "which is homogeneous so $\lVert H_s\rVert_F<1$ only helps." **No defect. But see §9: [L158](../findings/second-order.md) charges L149 with exactly this drop, and the corrected text has not answered the charge.**

## 7. Pre-registered question 1, does the entry state one thing about its own conclusion?

**Internally, yes; against its neighbours, no.**

The box asserts three clauses. (a) The second branch is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$, proved, §2. (b) "the first is minimised at $w=0$", the same sentence declares it "does not follow and is owed", and the box below upholds [ROUND_L149-F](ROUND_L149F.md)'s F12 on the same point. (c) "the validity branch is $\Omega(n^{-1})$ as well", see below. The second box withdraws only the *refutation* of $r_n\gtrsim n^{-1-\beta}$, on the correct ground that a lower bound is not falsifiable by a smaller lower bound, while keeping F12; and the display attributes $r_n\gtrsim n^{-3/2}$ to L145 rather than to this chain. **Those four statements are mutually consistent.** The apparent clash between "$c_{\min}$'s numerator is $m-3$" and "the coefficient's is $m-4$" is likewise real and resolved: the coefficient is the difference $c_{\min}-c_p$, verified exactly in §5.

**Candidate D1, the box's third clause has no argument anywhere in the entry.** *Locate:* "and the validity branch is $\Omega(n^{-1})$ as well." *Exhibit:* the entry gives branch 3 as $\rho(H)/2$ and nowhere bounds $\rho$ below. *Argue the opposite:* the entry's own line "$\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$" gives $\rho\gtrsim(a_0n^{1/2}+n)^{-1}=\Omega(n^{-1})$ uniformly on $w\in[0,1]$, so the clause is one line from material the entry has written down. **The candidate survives as a writing gap, not as a debt**, the argument exists in the entry's own symbols and is not written.

**Candidate D2, the citable box carries none of the lemma's hypotheses.** *Locate:* "**LEMMA L149.** *For $m\ge6$, …*". *Exhibit:* $\ker W^*=0$ is load-bearing (the HYPOTHESES box says that without it "branches 2 and 3 have no domain") and a reader applying the box as written at the record's own $W_{\mathbb{CP}^2}$, whose $\Lambda^2$-spectrum is $(2,-1,-1,0,0,0)$ so $\dim\ker W=3$ ([fence-posts.md](../findings/fence-posts.md):51), would assert branch 2 where $W\mapsto W_-$ is not analytic. Likewise $\lVert H\rVert_F=1$, without which $w\in[0,1]$ is meaningless, appears nowhere in the entry at all. *Argue the opposite:* the entry is one block and the HYPOTHESES box is four lines below the statement. **The candidate survives**, because the record set its own standard one lemma earlier: [second-order.md](../findings/second-order.md):1200 records for L148 that "the scope corrections are in the statement above, **which is where a citation reads them**" and that writing them into the surrounding boxes left "the citable sentence still carr[ying] a singular copy, a fixed frame, no dimension floor". L149's box has the dimension floor and nothing else.

*Note on the trailing display.* "$r_n\gtrsim n^{-3/2}$ **over every direction**" scopes over directions at $W^*$, not over critical points; $W_{\mathbb{CP}^2}$ lies outside the claim entirely. **No finding, but the phrase is one word from being read as a global statement.**

## 8. The penalty paragraph, the one broken passage

**Candidate D3.** *Locate:* "**The penalty term, which had no account.** $-\kappa_n\delta^2$ contributes $\lvert\kappa_n\rvert u^2t^2$ **against** the margin. … $u\le w$, and the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.416>0$, **positive by 20%**".

*Exhibit, in closed form.* Under the identity of §4, $\delta^2=t^2\cdot\tfrac29\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2\le\tfrac29w^2t^2$, so the net coefficient is $\tfrac32\theta_0-\tfrac29\lvert\kappa_n\rvert\to\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=\sqrt6-\tfrac{\sqrt2}2=1.7423829$, not $0.416$. The two differ by the factor $\tfrac92$ on the penalty: $9(\sqrt2-\sqrt{3/2})=1.7052183$ against $2(\sqrt2-\sqrt{3/2})=0.3789374$. The entry's own box **AND BOTH ARE CONDITIONAL ON THE $\tfrac29$** names $0.4161$ as the coefficient-$1$ endpoint, this paragraph's $0.416$, and the box after it says "**The coefficient-$1$ reading is excluded rather than disfavoured**". **The paragraph asserts, unhedged, a number the entry declares excluded two boxes above it.**

*Second exhibit, "positive by 20%" is not uniform in $n$ either way.* $0.416/2.1213=19.6\%$ is the $n\to\infty$ ratio. At finite $n$ the margin coefficient is $3\theta_0\tfrac{n-8}{2(n-2)}$, not $\tfrac32\theta_0$: at $n=12$ these are $0.7416198$ and $1.8540496$. The finite-$n$ ratios are $0.6400265/0.7416198=86.3\%$ under coefficient $1$ and $0.7190434/0.7416198=96.9\%$ under $\tfrac29$. **Neither is $20\%$.** This is the failure mode the round's own warning names, a constant read at $n\to\infty$ and quoted as though uniform.

*Argue the opposite.* The paragraph could be meant as an a-fortiori remark: *even* at the crude $u\le w$ the net stays positive. That reading rescues the sign but not the words: it is written as "the net coefficient **is**", it attributes the inequality to [r453](../reviews/REVIEW_r453.md) (a pre-identity review) and "positive by 20%" is a quantitative claim with no true reading. **The candidate survives all three steps.**

*Impact.* The true coefficient is larger, so no conclusion in the entry falls, and $\rho^{\mathrm{eff}}_n$ itself is computed with the correct $\tfrac29$ everywhere it is used. The cost is that the entry now prints both readings' arithmetic side by side with only one marked. **The record has already been bitten by exactly this pair:** [plan-verification.md](../plan-verification.md):174 records L157's fatal D6 as "$t$ carried the coefficient $1$ on $w^2$ where L149's repaired numerator carries $\rho^{\mathrm{eff}}_{12}=0.7190434$."

**Candidate D4, withdrawn.** *Locate:* "*The $m$-form $3\theta_0\tfrac{m-4}{2(m-1)}$ of the bullet above and this $n$-form are the same quantity under $n=2m$, both equal to $c_{\min}-c_p$*", placed immediately under the display of $\rho_n^{\mathrm{eff}}$. *Exhibit:* if "this $n$-form" is $\rho^{\mathrm{eff}}_n$ the sentence is false, the exact gap being $\tfrac{\sqrt{55}}3-\sqrt6=0.0225765=\tfrac29\lvert\kappa_{12}\rvert$ at $n=12$. *Argue the opposite:* "this $n$-form" reads naturally as the display's first summand, under which the sentence is exactly true (§5) and $c_{\min}-c_p$ is the right identification. **Withdrawn**, but it is the sentence that would license substituting the bullet's coefficient for the display's, which is D3's error and L157's D6, and it names neither the subtraction nor the summand it belongs to.

**Candidate D5, withdrawn.** *Locate:* "*$m\ge5$ was overstated: at $n=10$, $\theta_0=6/5<\sqrt{3/2}$, so $\lvert\kappa_n\rvert$ is negative and $\rho^{\mathrm{eff}}$ has no definition.*" *Exhibit:* $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=\tfrac{12}{10}$ exactly, so the aside's arithmetic is right; but the entry's own closed form gives $\rho^{\mathrm{eff}}_{10}=\sqrt6-\tfrac65\cdot\tfrac{26}{16}=\sqrt6-\tfrac{39}{20}=0.4994897>0$, and the correctly-signed penalty at $n=10$ gives $0.45-\tfrac29\cdot9(\sqrt{3/2}-\tfrac65)=0.4005043>0$, defined and positive both ways. What actually happens at $n=10$ is that $\kappa_{10}>0$, so $-\kappa_n\delta^2$ **helps** the margin rather than penalising it. *Argue the opposite:* the notation $\lvert\kappa_n\rvert:=9(\theta_0-\sqrt{3/2})$ is self-contradictory where that quantity is negative, so "$\rho^{\mathrm{eff}}$ has no definition" is a fair statement about the displayed formula. **Withdrawn.** The floor $m\ge6$ is correct and conservative; the exact boundary is $\theta_0(n)=\sqrt{3/2}$, i.e. $n^2-12n+8=0$, i.e. $n=6+2\sqrt7=11.2915$, which the entry never names.

## 9. The two forms, item 5

**results.md carries no canonical Lemma L149, and that is consistent with its neighbours.** [results.md](../results.md) has canonical headings for L154–L158 and for L140, and none for L141–L153; L145–L149 are all absent alike. [findings/INDEX.md](../findings/INDEX.md) indexes [second-order.md](../findings/second-order.md) by theme rather than lemma by lemma. **So the absence is the file's convention, not an omission specific to L149.** Item 5 answered: the absence is correct.

**But L149's content appears in three other places, and each differs.**

- **[results.md](../results.md):363, inside L158.** Agrees that branch 2's infimum is order $n^{-1}$ and reproduces $\kappa=3\sqrt{2(n-1)/(n-2)}\approx4.45$ and $c_p=3\theta_0/(n-2)$. **Differs on branch 2's shape**: it carries the envelope $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ and puts the minimum at the homogeneity kink $w_0=(n-4)/n$. I verified $w_0$ in closed form: with $s^2=2/(n-2)$, $s\sqrt{1-w^2}+w=1$ gives $s^2(1+w)=1-w$, so $w=\tfrac{1-s^2}{1+s^2}=\tfrac{n-4}{n}$, which is $\tfrac23$ at $n=12$. **Reproduced.** It also records that branch 1's infimum order "is not settled here" and that "the $\Theta(n^{-3/2})$ recorded briefly against it read the numerator and the coefficient at two different points", where L149 says instead that a reader reports $\Theta(n^{-1-\beta})$ attained at $w=0$ and that it is "unadjudicated". **Two different characterisations of the same open question, neither citing the other.** I checked results.md's branch-1 algebra and it is right: $au^{*2}+2Su^*-ac_p=0$ gives $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ and $f(u^*)=2u^*/a$, with $u^*\le\sqrt{c_p}$ since $\sqrt{S^2+a^2c_p}\le S+a\sqrt{c_p}$.

- **[L158](../findings/second-order.md), in the same file.** L158 states outright that L149's envelope is the wrong one: "$H_s\perp H_r$ makes $\lVert H_s\rVert_F=\sqrt{1-w^2}$ an *identity* and L146 is homogeneous (**L149 says so in the very bullet that then drops it**) so the admissible envelope is $\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$", with Gate 2 behind it. **The L149 text under audit still carries $a_0n^{1/2}+nw$, still says no case analysis is needed, and never mentions the charge.** Concretely at $n=12$ the two disagree at $w=1$, denominator $17.3666$ against $12$, and their minimisers differ, $w=1$ (coefficient $0.72136$) against $w_0=\tfrac23$ (coefficient $\sqrt{0.3708099+0.3195748}=0.8308939$). **Finding of difference. Not a defect:** L149's envelope is the larger one, so its $\Omega(n^{-1})$ holds a fortiori, and its box disclaims pricing branch 2.

- **[plan.md](../plan.md):71 and :135.** Both still read "$r_n\gtrsim n^{-1-\beta}$ holds over every direction at **$m\ge5$**". Both halves are superseded: the entry narrows the range to $m\ge6$, and [plan-verification.md](../plan-verification.md):168 records F12 upheld unanimously, replacing the boxed $n^{-1-\beta}$ by $n^{-3/2}$; :182 records "range narrowed to $m\ge6$" as one of L149's applied corrections. plan.md's **I31** entry at :137 *has* been updated with the withdrawal; **I33** at :135 and the page note at :71 have not. **Finding, the correction was written in one file and not its neighbour, which is this block's documented failure mode.**

## 10. The one numeral I could not reproduce

**Candidate D6.** *Locate:* "Branch 2 is $K\,g_\rho$ with $K=\lambda(1-\eta^*)^2/(\sqrt2 J)$ from L158, and **$K<1$ by better than an order of magnitude**."

*Exhibit.* From the record's own constants at $n=12$: $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ ([plan.md](../plan.md):137) $=2/\sqrt{0.1015939}=6.27474$; $J=C^*/\gamma^*$ with $C^*=2+\tfrac{4(m-1)}{2m-1}=\tfrac{42}{11}$ and $\gamma^*=\alpha^*/2=\tfrac{11}{20}$ ([L156](../findings/second-order.md)), so $J=\tfrac{840}{121}=6.94215$ and $K=6.27474(1-\eta^*)^2/(\sqrt2\cdot6.94215)=0.63912\,(1-\eta^*)^2$. **$K<0.1$ would require $\eta^*>0.6044$.** Cross-checking against L158's own threshold $T=\kappa\sqrt2J/\big(\lambda(1-\eta^*)^2s_\rho(w_0)\big)=\kappa/(Ks_\rho(w_0))=18.00$ at $n=12$, with $s_\rho(w_0)=0.8308939$ from §9, gives $K=4.4497190/(18.00\times0.8308939)=0.29752$.

*Argue the opposite.* I do not have L157's $t$ in hand, so I cannot pin $\eta^*$ directly, and the $T$ route depends on my reading of $s_\rho$. **I therefore record this as not reproduced rather than refuted:** every route I could take by hand puts $K$ near $0.3$, a factor of about three below $1$, where the sentence claims better than ten. *Impact is nil either way*, the box uses $K<1$ only to forbid reading $0.71979/n$ as a branch-2 floor, and $K\approx0.3$ serves that.

**Reproduced, for the record:** $0.71904$, $0.7416198$, $0.9462601$, $1.0978875$, $1.74238$, $0.1015939$, $4.4497190$, $43.8$, $0.19994$, $0.7197978$, $0.71980$, $5400>2695$, $8656$, $0.6400265$, $0.4161020$, $2.1213$, $1.7053$, $0.416$, $0.689771$, $0.589804$, $0.333$, $0.447$, $\tfrac23$, $6/5$. **Reproduced to four figures but not six:** $0.582938$, where I get $0.5829525$, a withdrawn historical value, so nothing rests on it. **Not reproduced:** "better than an order of magnitude".

## 11. What would falsify the statement, and what I did to look for it

**The object that would break C1** is a direction $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$ and $\sqrt{c(H)}/\lVert A''\rVert=o(1/n)$. Two routes exist and I closed both against the record.

- **Numerator route:** a summand of L27's decomposition, surviving the two exclusions, whose margin minus its penalty falls below $c_{\min}-\tfrac29\lvert\kappa_n\rvert$. I tabulated all ten (§5): the surviving margins are $c_p$, $c_{\min}$, $3\theta_0\tfrac{m+1}{2(m-1)}$ and $\tfrac32\theta_0$ (four times), and by §4 the penalty is **identically zero** off $\Lambda^2\otimes\Lambda^2$. So the minimum sits at $c_{\min}-\tfrac29\lvert\kappa_n\rvert$ and no such summand exists. There is no room outside the ten: L27's dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$.
- **Denominator route:** an $H$ with $\lVert H\rVert_{op}>a_0n^{-1/2}\lVert H_s\rVert_F+\lVert H_r\rVert_F$. Impossible, triangle inequality, L146 on $H_s$ (homogeneous, and licensed on the joint eigenspace by L146's own box), and $\lVert\cdot\rVert_{op}\le\lVert\cdot\rVert_F$ on $H_r$.

**What I did not close** is the constant relating $\lVert A''\rVert$ to $1/\rho$, which the entry disclaims pricing, and the Hermitian-versus-complex-symmetric step behind $M=O(\rho)$, which [second-order.md](../findings/second-order.md):1206 records as an open citation defect in L147 with a valid replacement derivation named. Neither is L149's to prove.

## Verdict

**`GAP`.** The uniformity theorem is proven, its infimum formula is exact, its $n$-free coefficient is derived correctly and reproduces to seven digits, $\rho^{\mathrm{eff}}_n$'s closed form and both its positivity and its monotonicity are proven, and the $\tfrac29$ is an identity and is proved to be one from L133's own step 2, a genuinely correct block. What keeps it from a pass: the box asserts three clauses and the entry proves one, with the third ("the validity branch is $\Omega(n^{-1})$ as well") carrying no written argument; the citable statement omits all four hypotheses the proof uses, against the standard the record set for L148 one lemma earlier; and the paragraph "The penalty term, which had no account" still computes the net coefficient at the coefficient-$1$ reading that the $\tfrac29$ box declares excluded, quoting a $20\%$ margin that holds at no dimension under either reading.

**Owed:** the one-line branch-3 bound written down; the four hypotheses moved into the box; the penalty paragraph recomputed at $\tfrac29$; [plan.md](../plan.md):71 and :135 brought to $m\ge6$ and to $n^{-3/2}$; and either L158's envelope adopted here or the divergence named.
