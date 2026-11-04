# VERIFY v15, Lemma L149's "Proof of the uniformity" runs at a coefficient the lemma's own inputs do not supply

*The brief was cold: the block was read here from [findings/second-order.md](../findings/second-order.md) lines 1181–1221 and rebuilt from the definitions before any other text was consulted. **No script was run.** Every number below is an exact evaluation performed by hand from $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and the record's $c_p=3\theta_0(n)/(n-2)$; each is shown with the algebra that produces it. Log: [agent_logs/verify-L149-v15.log](../agent_logs/verify-L149-v15.log).*

## Claim table

| # | claim as written | verdict |
|---|---|---|
| 1 | the margin bullet's $3\theta_0\tfrac{m-4}{2(m-1)}$ and the blockquote's $3\theta_0\tfrac{n-8}{2(n-2)}$ are the same quantity | **CONFIRMED**, identical under $n=2m$, and both equal $c_{\min}-c_p$ exactly |
| 2 | the proof's $w^2$ coefficient $1$ is one of those quantities | **REFUTED**, it is neither; it exceeds both at $n\in\{12,14,16\}$ |
| 3 | the value computed at coefficient $1$ bounds the true branch minimum from below | **REFUTED**, it bounds it from **above**, by $14.85\%$ at $n=12$ |
| 4 | "$g$ has a single interior minimum at $w^*=Bc/A=\kappa n^{-1/2}$" on $w\in[0,1]$ | **REFUTED**, $w^*>1$ exactly for $n\le19$; $w^*(12)=1.284574$ |
| 5 | the blockquote's $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ is "a valid but lossy lower bound" for the branch $\rho_n^{\mathrm{eff}}$ defines | **REFUTED**, it exceeds the true $[0,1]$-minimum at $n=14$, $n=16$ and asymptotically; it holds at $n=12$ alone |
| 6 | the boxed conclusion: branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$ for the coefficient the inputs define | **TRUE, BY AN ARGUMENT THE BLOCK DOES NOT CONTAIN**, one line of unimodality supplies it; branch $2\ \ge\ 0.7841/n$ for every $n\ge12$ |
| 7 | the stated range $m\ge5$ | **HYPOTHESIS-DEBT**, $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$ is negative at $m=5$; $\theta_0(10)=1.2$ exactly against $\sqrt{3/2}=1.224745$ |
| 8 | the penalty magnitude | **INDETERMINATE IN THE BLOCK**, line 1204 charges $\tfrac29\lvert\kappa_n\rvert$, line 1219 charges $\lvert\kappa_n\rvert$; the two asymptotes are $1.74238$ and $0.41610$ |

**One line the round can act on: the boxed claim is true and the written proof does not prove it, replace the ρ=1 computation with `inf_{[0,1]} g_ρ ≥ inf_{w≥0} g_ρ = (1/n)√(ρκ/(ρ+κ))`, evaluate at ρ=ρ_n^eff, and withdraw the blockquote's sentence calling √(κ(n−8)/(3n−8))/n a valid lower bound.**

## 0. Conventions, fixed once

All of these are the record's own, gathered here so every later line is checkable without leaving this file.

- $n=2m$ throughout, $W^*=S^m\times S^m$ ([second-order.md line 1104](../findings/second-order.md), [line 1129](../findings/second-order.md)).
- $\theta_0(n)=\dfrac{\sqrt{2(n-1)(n-2)}}{n}$ ([bounds.md, Lemma L117](../findings/bounds.md)). Exactly: $\theta_0(10)=\tfrac{12}{10}=1.2$, $\theta_0(12)=\tfrac{\sqrt{220}}{12}=1.23603308$, $\theta_0(14)=\tfrac{\sqrt{312}}{14}=1.26168010$, $\theta_0(16)=\tfrac{\sqrt{420}}{16}=1.28086884$, $\theta_0(\infty)=\sqrt2$.
- $c_p=3\theta_0(n)(\tfrac12-\lambda_m)=\dfrac{3\theta_0(n)}{n-2}$, $\lambda_m=\dfrac{m-2}{2(m-1)}$ ([second-order.md line 1129](../findings/second-order.md)).
- $\kappa:=nc_p=3\sqrt{\dfrac{2(n-1)}{n-2}}$, **decreasing** to $3\sqrt2=4.24264069$ ([second-order.md line 1261](../findings/second-order.md)). $\kappa(12)=3\sqrt{2.2}=4.44971910$, $\kappa(14)=3\sqrt{13/6}=4.41588034$, $\kappa(16)=3\sqrt{15/7}=4.39155031$.
- $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, negative for $n\ge12$ ([route-a.md line 196](../findings/route-a.md)), so $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$ **there and only there**. $\lvert\kappa_{12}\rvert=9(1.23603308-1.22474487)=0.10159$, $\lvert\kappa_\infty\rvert=9(\sqrt2-\sqrt{3/2})=1.70521824$.
- $\rho_n:=3\theta_0(n)\dfrac{n-8}{2(n-2)}$, the block's margin coefficient before the penalty; $\rho_n^{\mathrm{eff}}:=\rho_n-\tfrac29\lvert\kappa_n\rvert=\rho_n-2(\theta_0(n)-\sqrt{3/2})$.
- $g_\rho(w):=\dfrac{\sqrt{c+\rho w^2}}{A+Bw}$, $c=c_p=\kappa/n$, $A=n^{1/2}$, $B=n$. The block's displayed $g$ is $g_1$.

**Two symbols collide inside one block and the record knows it**: $\kappa=nc_p$ in the proof display and $\kappa_n$ the quartic-tail penalty in the blockquote are unrelated ([second-order.md line 1276](../findings/second-order.md) records the collision). They are kept apart above.

## 1. Which coefficient each part uses, and whether they are the same quantity

Three sites, and they carry two distinct values, not one.

**Site A, the margin bullet, [line 1194](../findings/second-order.md):**

> $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}\,w^2$, the margin being $3\theta_0(\tfrac12-\lambda)$ on each summand of Lemma L27 and the form quadratic, so on $\lVert H\rVert_F=1$ it is a **convex combination** of the summand margins.

**Site B, the chain display, [line 1198](../findings/second-order.md):** $r(H)\gtrsim\min\big(\tfrac{c_p+w^2}{S},\ \tfrac{\sqrt{c_p+w^2}}{n^{1/2}+nw},\ \tfrac{\rho(H)}2\big)$, coefficient $1$, in both branches.

**Site C, the blockquote, [line 1204](../findings/second-order.md):** $\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$.

**Sites A and C are the same quantity up to the penalty, and the identification is exact.** Substituting $m=n/2$ into Site A,
$$\frac{m-4}{2(m-1)}=\frac{\tfrac n2-4}{2(\tfrac n2-1)}=\frac{(n-8)/2}{n-2}=\frac{n-8}{2(n-2)},$$
so Site A **is** $\rho_n$, written in $m$. Site C is $\rho_n$ minus the penalty. Site B's coefficient is $1$ and is neither.

**The bullet's coefficient is also correctly derived, which is worth recording because two of the block's sentences look inconsistent and are not.** [Line 1194](../findings/second-order.md) says the smallest off-summand margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$, *larger* than the coefficient it then uses. The convex combination resolves it. With weights $1-w^2$ on the joint $\lambda_m$ eigenspace (margin $c_p$) and $w^2$ outside (margin $\ge c_{\min}$),
$$c(H)\ \ge\ (1-w^2)c_p+w^2c_{\min}\ =\ c_p+(c_{\min}-c_p)w^2,$$
and with $c_{\min}=3\theta_0\frac{m-3}{2(m-1)}$, $c_p=\frac{3\theta_0}{n-2}=\frac{3\theta_0}{2(m-1)}$,
$$c_{\min}-c_p=\frac{3\theta_0\big[(m-3)-1\big]}{2(m-1)}=3\theta_0\frac{m-4}{2(m-1)}=\rho_n .$$
Exactly the bullet's coefficient. Three of the block's incidental assertions fall out of this and all check: it vanishes at $m=4$ ("ties with $c_p$ at $m=4$", and "at $\rho=0$, which is $m=4$" at [line 1209](../findings/second-order.md)); it is zero for the $+\mu$ margin itself at $m=3$; and $c_{\min}$ corresponds to $\mu=\tfrac1{m-1}$, whence $\lambda_m>\mu\iff m>4$, which is [Lemma L146](../findings/second-order.md)'s stated reason for $m\ge5$. The two named summands also agree: [nondegeneracy.md line 700](../findings/nondegeneracy.md) gives $+\mu$ at multiplicity $c_pc_q$, which is the $\Lambda^2\!\otimes\!\Lambda^2$ summand the blockquote names.

**Numerically, at the dimensions in range** (using $\rho_n=3\theta_0(n-8)/(2(n-2))$ and $\rho^{\mathrm{eff}}_n=\rho_n-2(\theta_0-\sqrt{3/2})$):

| $n$ | $\rho_n$ | $\rho_n^{\mathrm{eff}}$ | Site B's coefficient |
|---|---|---|---|
| 12 | $0.6\,\theta_0(12)=0.74161985$ | $0.71904343$ | $1$ |
| 14 | $0.75\,\theta_0(14)=0.94626008$ | $0.87238964$ | $1$ |
| 16 | $\tfrac67\theta_0(16)=1.09788758$ | $0.98563975$ | $1$ |
| $\to\infty$ | $\tfrac32\sqrt2=2.12132034$ | $1.74238288$ | $1$ |

All four $\rho^{\mathrm{eff}}$ values reproduce the block's own $0.71904$, $0.87239$, $0.98564$, $1.74238$ character for character. The closed form behind the column is
$$\rho_n^{\mathrm{eff}}=2\sqrt{\tfrac32}-\theta_0(n)\frac{n+16}{2(n-2)},$$
from $\frac{3(n-8)}{2(n-2)}-2=\frac{3n-24-4n+8}{2(n-2)}=-\frac{n+16}{2(n-2)}$.

**Answer to check 1.** Sites A and C are one quantity, in two variables, with and without the penalty. Site B (the coefficient the proof is executed at), is a third value that the block's inputs never supply, and it is strictly larger than either at $n=12,14,16$.

## 2. Whether the conclusion at coefficient $1$ bounds the branch the inputs define

**The direction is derived, not assumed.** For any $\rho>0$,
$$\frac{\mathrm d}{\mathrm dw}\log g_\rho=\frac{\rho w}{c+\rho w^2}-\frac{B}{A+Bw},\qquad \mathop{\mathrm{sign}}g_\rho'=\mathop{\mathrm{sign}}\big[\rho w(A+Bw)-B(c+\rho w^2)\big]=\mathop{\mathrm{sign}}(\rho Aw-Bc),$$
the $\rho Bw^2$ cancelling. So $g_\rho$ is strictly decreasing on $[0,w^*_\rho)$ and strictly increasing after, with
$$w^*_\rho=\frac{Bc}{\rho A}=\frac{\kappa}{\rho\sqrt n}.$$
At the stationary point, $c+\rho w^{*2}=c\big(1+\tfrac{B^2c}{\rho A^2}\big)$ and $A+Bw^*=\tfrac{\rho A^2+B^2c}{\rho A}$, so
$$\boxed{\ \min_{w\ge0}g_\rho=\frac{\sqrt{\rho c}}{\sqrt{\rho A^2+B^2c}}=\frac1n\sqrt{\frac{\rho\kappa}{\rho+\kappa}}=\frac1n\Big(\frac1\rho+\frac1\kappa\Big)^{-1/2}\ }$$
using $\rho A^2+B^2c=\rho n+n\kappa=n(\rho+\kappa)$ and $\rho c=\rho\kappa/n$. At $\rho=1$ this is $\tfrac1n\sqrt{\kappa/(1+\kappa)}$, which is the block's displayed value, so the block's algebra at $\rho=1$ is correct as algebra.

**The harmonic form settles the comparison in one line.** $\rho\mapsto(1/\rho+1/\kappa)^{-1/2}$ is **strictly increasing**. Hence for $\rho<1$ the true minimum is strictly **below** the value computed at $\rho=1$: the block's computation is an **upper** bound on the quantity the lemma needs bounded below.

Exactly, at $n=12$ with $\kappa=4.44971910$:

| coefficient | $\big(1/\rho+1/\kappa\big)^{-1/2}$ | $n\cdot\min_{w\ge0}g_\rho$ |
|---|---|---|
| $\rho=1$ (as written) | $(1+0.22473310)^{-1/2}$ | $0.90360617$ |
| $\rho=\rho_{12}=0.74161985$ | $(1.34840775+0.22473310)^{-1/2}$ | $0.79729177$ |
| $\rho=\rho_{12}^{\mathrm{eff}}=0.71904343$ | $(1.39073560+0.22473310)^{-1/2}$ | $0.78677479$ |

The displayed value **overstates the true minimum by $14.85\%$** ($0.90360617/0.78677479=1.14849$); equivalently the truth is $12.93\%$ below what is displayed. This is the precise failure mode the block itself polices two paragraphs earlier, [line 1194](../findings/second-order.md), *"a lower bound stated upward"*, committed in its own proof.

**Answer to check 2.** Neither "from below" nor "neither": **from above**, strictly, whenever $\rho<1$, which is every $n\le16$ under $\rho^{\mathrm{eff}}$ and every $n\le15$ under $\rho_n$.

## 3. Whether $w^*$ lies in $[0,1]$

**At coefficient $1$, as the proof writes it.** $w^*_1=\kappa n^{-1/2}\le1\iff\kappa^2\le n\iff\frac{18(n-1)}{n-2}\le n\iff18n-18\le n^2-2n$, i.e.
$$\boxed{\ w^*_1\le1\iff n^2-20n+18\ge0\iff n\ \ge\ 10+\sqrt{82}=19.05539\ }$$
so $w^*_1>1$ for **every** $n\le19$. At $n=12$: $w^*_1=4.44971910/\sqrt{12}=4.44971910/3.46410162=1.28457$. (This matches [Lemma L158](../findings/second-order.md)'s [line 1274](../findings/second-order.md), which already charges it: *"$w^*=\kappa n^{-1/2}$ exceeds $1$ for every $n\le19$"*.)

**At the coefficient the inputs give.** $w^*_{\rho_n}=\dfrac{\kappa}{\rho_n\sqrt n}$; substituting $\kappa=\frac{3n\theta_0}{n-2}$ and $\rho_n=\frac{3\theta_0(n-8)}{2(n-2)}$, the $\theta_0$ and $(n-2)$ both cancel:
$$w^*_{\rho_n}=\frac{3n\theta_0}{n-2}\cdot\frac{2(n-2)}{3\theta_0(n-8)\sqrt n}=\frac{2\sqrt n}{\,n-8\,},\qquad w^*_{\rho_n}\le1\iff n-2\sqrt n-8\ge0\iff(\sqrt n-4)(\sqrt n+2)\ge0\iff n\ge16 .$$
Values $3.16228$, $1.73205$, $1.24722$, $1$ at $n=10,12,14,16$, the blockquote's own numbers, confirmed exactly.

**With the penalty carried**, $\rho^{\mathrm{eff}}<\rho_n$ pushes $w^*$ further out: $w^*_{\rho^{\mathrm{eff}}}=1.786455$, $1.352787$, $1.113879$ at $n=12,14,16$, still outside at $n=16$ where the uncorrected value sits exactly at the endpoint.

**Answer to check 3.** The stationary point lies outside $[0,1]$ at every dimension of interest. The range condition is $n\ge10+\sqrt{82}$ for the written proof's $w^*$, $n\ge16$ for $\rho_n$'s, and later still for $\rho^{\mathrm{eff}}$'s. **The block asserts the opposite in the proof and the correct thing eight lines above it**, [line 1213](../findings/second-order.md): *"so $g$ has a single interior minimum at $w^*=Bc/A=\kappa n^{-1/2}$"*, against [line 1207](../findings/second-order.md): *"So the stationary point is outside $[0,1]$ at every dimension in range."* The block contradicts itself inside twelve lines.

*A note in the block's favour that it does not make.* [Line 1286](../findings/second-order.md) corrects $A$ to $a_0n^{1/2}$ with $a_0=\sqrt{2n/(n-2)}$. Under that $A$, $w^*_1=\kappa/(a_0\sqrt n)=3\sqrt{n-1}/n$ exactly, which is $0.82916$ at $n=12$ and **is** interior, that is [Lemma L157](../findings/second-order.md)'s $0.829$. But with the corrected coefficient it moves back out: $w^*_{\rho^{\mathrm{eff}}}(12)=1.786455/1.549=1.15330>1$. So the corrected $A$ does not rescue the interiority claim once the corrected $\rho$ is carried; the two corrections pull opposite ways and the coefficient wins.

## 4. What the minimum on $[0,1]$ actually is, and whether the block computes it

Since $\mathop{\mathrm{sign}}g_\rho'=\mathop{\mathrm{sign}}(\rho Aw-Bc)$ has a single sign change, $g_\rho$ is unimodal, so
$$\min_{[0,1]}g_\rho=\begin{cases}g_\rho(w^*_\rho)&w^*_\rho\le1\\[2pt] g_\rho(1)=\dfrac{\sqrt{c_p+\rho}}{\sqrt n+n}&w^*_\rho>1,\end{cases}$$
and in the range of interest the second case holds throughout. Exactly, with $c_p=\kappa/n$:

| $n$ | $c_p$ | $\rho^{\mathrm{eff}}$ | $n\cdot g_{\rho^{\mathrm{eff}}}(1)$ | $n\cdot\min_{w\ge0}g_{\rho^{\mathrm{eff}}}$ | block's closed form $\sqrt{\tfrac{\kappa(n-8)}{3n-8}}$ |
|---|---|---|---|---|---|
| 12 | $0.37080993$ | $0.71904343$ | $0.810103$ | $0.786775$ | $0.797292$ |
| 14 | $0.31542003$ | $0.87238964$ | $0.860017$ | $0.853508$ | $0.882764$ |
| 16 | $0.27447189$ | $0.98563975$ | $0.898038$ | $0.897204$ | $0.937182$ |

*Sample derivation, $n=12$:* $c_p+\rho^{\mathrm{eff}}=0.37080993+0.71904343=1.08985336$; $\sqrt{\cdot}=1.0439604$; $\sqrt{12}+12=15.4641016$; $12\times1.0439604/15.4641016=0.810103$. The unconstrained column is $\big(1/\rho^{\mathrm{eff}}+1/\kappa\big)^{-1/2}$: at $n=12$, $(1.390736+0.224733)^{-1/2}=1.615469^{-1/2}=0.786775$.

*Sample derivation, $n=16$:* $c_p+\rho^{\mathrm{eff}}=0.27447189+0.98563975=1.26011164$; $\sqrt{\cdot}=1.12254694$; $4+16=20$; quotient $0.05612735$; $\times16=0.898038$. Here $w^*_{\rho^{\mathrm{eff}}}=1.113879$ is only just outside $[0,1]$, which is why the endpoint and the unconstrained infimum agree to three places.

**The block does not compute this.** Its only endpoint sentence, [line 1215](../findings/second-order.md), reads *"The endpoints give $\sqrt\kappa/n$ and $\asymp1/n$, so the branch never leaves that order"*, both evaluated at $\rho=1$ ($g_1(0)=\sqrt c/A=\sqrt\kappa/n$; $g_1(1)=\sqrt{1+\kappa/n}/(n+\sqrt n)$), and the endpoint that decides the lemma is given as $\asymp1/n$ with no constant. So the value that is in fact the minimum over $[0,1]$ at every $n$ in range appears nowhere in the block.

**And the blockquote's closed form is not a lower bound for the branch the blockquote itself defines.** First the identity, which is exact:
$$\frac{\rho_n\kappa}{\rho_n+\kappa}=\frac{\dfrac{3\theta_0(n-8)}{2(n-2)}\cdot\dfrac{3n\theta_0}{n-2}}{\dfrac{3\theta_0}{n-2}\cdot\dfrac{(n-8)+2n}{2}}=\frac{3n\theta_0(n-8)}{(n-2)(3n-8)}=\frac{\kappa(n-8)}{3n-8},$$
so $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ is precisely $\min_{w\ge0}g_{\rho_n}$, the **uncorrected** coefficient's unconstrained infimum. Since $\rho^{\mathrm{eff}}<\rho_n$ strictly for $n\ge12$ and $\rho\mapsto\min_{w\ge0}g_\rho$ is strictly increasing, that closed form **always exceeds** $\min_{w\ge0}g_{\rho^{\mathrm{eff}}}$. Compared against the quantity the lemma actually needs ($\min_{[0,1]}g_{\rho^{\mathrm{eff}}}$), the table's last two columns give
$$0.797292<0.810103\ (n=12),\qquad 0.882764>0.860017\ (n=14),\qquad 0.937182>0.898038\ (n=16),$$
and asymptotically $\sqrt{\kappa/3}\to\sqrt{4.24264069/3}=1.18920712$ against $\big(1/1.74238288+1/4.24264069\big)^{-1/2}=1.11134$. **So [line 1207](../findings/second-order.md)'s *"a valid but lossy lower bound … and that is what carries $\Theta(n^{-1})$ and this lemma's conclusion"* is false at $n=14$, $n=16$ and in the limit; it happens to hold at $n=12$ only, and there by $1.6\%$.**

*The charitable reading, argued.* Read "the closed form" as attached to $\rho_n$ rather than to $\rho^{\mathrm{eff}}$, and "valid lower bound" as a claim about the pre-penalty branch. Under that reading the sentence is exactly right, the identity above makes it an equality, not a bound. But the sentence sits inside the paragraph that has just carried the penalty (*"it does **not** cancel once the penalty is carried"*), and it is the sentence that assigns responsibility for the lemma's conclusion, so the narrow reading leaves the conclusion unsupported rather than making the sentence true. Reported as a real discrepancy at the level of the constant; it is order-neutral.

## 5. Whether $\Omega(n^{-1})$ survives, and by what argument

**It does, and the argument is one line the block does not write.** $g_\rho$ is unimodal with global minimum at $w^*_\rho$, therefore for every $\rho>0$ and every $w\in[0,1]$,
$$g_\rho(w)\ \ge\ \min_{w\ge0}g_\rho=\frac1n\Big(\frac1\rho+\frac1\kappa\Big)^{-1/2},$$
**whether or not $w^*_\rho$ lies in $[0,1]$**. So the interiority question of §3 is irrelevant to the order, and the endpoint check of §4 is not needed either. The bound is then uniform in $n$ because both inputs are:

- $\kappa=3\sqrt{2(n-1)/(n-2)}$ is **decreasing** in $n$, so $\kappa\ge3\sqrt2=4.24264069$ for every $n$.
- $\rho_n^{\mathrm{eff}}=2\sqrt{3/2}-\tfrac{\sqrt2}{2}\big(1+\tfrac{16}{n}\big)\sqrt{\tfrac{n-1}{n-2}}$ is **increasing** in $n$: both $1+16/n$ and $\sqrt{1+1/(n-2)}$ decrease, so the subtracted term decreases. Hence $\rho^{\mathrm{eff}}_n\ge\rho^{\mathrm{eff}}_{12}=0.71904343$ for every $n\ge12$.

Therefore, for every $n\ge12$ and every $w\in[0,1]$,
$$g_{\rho^{\mathrm{eff}}}(w)\ \ge\ \frac1n\Big(\frac1{0.71904343}+\frac1{4.24264069}\Big)^{-1/2}=\frac1n\,(1.39073560+0.23570226)^{-1/2}=\frac{0.78411722}{n}.$$

**And it survives the block's own ambiguity about the penalty.** [Line 1219](../findings/second-order.md) charges the full $\lvert\kappa_n\rvert$ rather than $\tfrac29\lvert\kappa_n\rvert$: *"the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.416$"*. Under that harsher reading $\rho^{\mathrm{harsh}}_n=9\sqrt{3/2}-\tfrac{3\theta_0(5n-4)}{2(n-2)}$, which is $0.64002590$ at $n=12$ and **decreases** to $0.41610210$; taking the infimum $0.41610210$ gives
$$g_{\rho^{\mathrm{harsh}}}(w)\ \ge\ \frac1n\big(2.40325+0.23570\big)^{-1/2}=\frac{0.61557}{n}.$$
So branch 2 is $\ge0.6156/n$ for every $n\ge12$ under either accounting. **The boxed $\Omega(n^{-1})$ stands.**

**Answer to check 5.** Yes, and the surviving argument uses none of the three steps the written proof spends its lines on. What the written proof needed was the unconstrained infimum as a *bound*; what it did was compute it as a *value*, at the wrong coefficient, and then assert it was attained.

## 6. Hypothesis inventory

| # | hypothesis the proof uses | stated in the block? |
|---|---|---|
| H1 | $m\ge5$, i.e. $n\ge10$ | **yes**, the box and the inputs heading |
| H2 | $W^*=S^m\times S^m$ balanced, $n=2m$ | **partly**, "at $p=q=m$" at [line 1189](../findings/second-order.md); the relation $n=2m$ is not restated and is needed to read the $m$-form and $n$-form coefficients as one |
| H3 | $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$ | **yes**, [line 1183](../findings/second-order.md) and the bullet |
| H4 | $w=\lVert H_r\rVert$, the weight outside **both** $S^2_0(\mathbb R^m)$ copies | **yes**, and the block records the earlier singular reading as the error it was |
| H5 | $\ker W^*=0$ | **no**, inherited silently |
| H6 | $\rho(H)=\Theta\!\big(\min(1,g_n/\lVert H\rVert_{op})\big)$ with $g_n=\Theta(1/n)$ | **no**, inherited from [Lemma L145](../findings/second-order.md) / [Lemma L146](../findings/second-order.md) |
| H7 | $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert=O(\rho)$, whence $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)$ | **no**, from [Lemma L147](../findings/second-order.md) [line 1163](../findings/second-order.md) |
| H8 | $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})\ge0$, i.e. $n\ge12$ | **no**, used at [line 1204](../findings/second-order.md), incompatible with H1 |
| H9 | $u\le w$ in the penalty accounting | **stated with a reason** at [line 1219](../findings/second-order.md); the constant is unpinned ([line 1352](../findings/second-order.md)) |
| H10 | $S=\sup\lvert P\rvert=\Theta(n^\beta)$, $\beta\in[0,\tfrac12]$ | **$S$ yes, the range of $\beta$ no**, the range is [Lemma L147](../findings/second-order.md)'s, [line 1161](../findings/second-order.md) |

**$\ker W^*$ (H5).** The branch-2 numerator is $\sqrt{c(H)}$ and its denominator is a Cauchy estimate on the analyticity disc of $W\mapsto W_-$, whose radius is the spectral gap $g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$. That is a gap only because **the spectrum at $W^*$ is two-valued with no kernel**, [Lemma L145](../findings/second-order.md)'s step 1, *"the spectrum is two-valued with no kernel, so $g_n=\lvert\lambda_-\rvert$"*, CONFIRMED there and recomputed cold twice. With a kernel, $x\mapsto x_-$ is not analytic at $W^*$ at all and $A''$ is undefined, so the entire second branch collapses. **L149 never says this.** It is true at the balanced product, so this is inherited debt rather than a defect, but a reader of L149 alone cannot see that branch 2 has a domain of definition.

**The smallest admissible dimension (H1 against H8).** The box says $m\ge5$. At $m=5$, $n=10$ and $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=\sqrt{144}/10=1.2$ **exactly**, against $\sqrt{3/2}=1.22474487$. So $9(\theta_0(10)-\sqrt{3/2})=-0.22270$: the blockquote's display equates an absolute value to a negative number. [route-a.md line 196](../findings/route-a.md) is explicit ($\kappa_n=9(\sqrt{3/2}-\theta_0(n))<0$ *for $n\ge12$*) so at $m=5$ the penalised functional's constant has the opposite sign and $\rho_n^{\mathrm{eff}}$ has no definition as written. **The order conclusion is not endangered**: at $n=10$, $\rho_{10}=3(1.2)(2)/(2\cdot8)=0.45$, and both readings of the penalty ($0.45+0.04949=0.49949$, or $0.45-0.04949=0.40051$) leave it positive, so branch 2 is still $\Omega(n^{-1})$ there. Recorded as hypothesis-debt: **the block's honest range is $m\ge6$ (equivalently $n\ge12$), which is also the only range the programme lives in** ([Lemma L44](../findings/problem.md)). $m\ge5$ is load-bearing for the *exponent*, at $m=4$, $\rho=0$ and $g_0(w)=\sqrt c/(A+Bw)$ is decreasing with minimum $\sqrt{\kappa/n}/(n+\sqrt n)=\Theta(n^{-3/2})$, confirming [line 1209](../findings/second-order.md) exactly, but the *stated* threshold and the *usable* threshold differ by one.

**$\beta$ (H10).** $\beta$ enters neither branch 2 nor the boxed uniformity claim: $S$ appears only in branch 1 and in the final display $r_n\gtrsim n^{-1-\beta}$. So $\beta$ is irrelevant to the question asked, and the block's failure to restate $\beta\in[0,\tfrac12]$ costs the boxed second-branch claim nothing. It does cost the final display, which is only meaningful with $\beta$'s range attached and gets it from [Lemma L147](../findings/second-order.md) two entries above.

## 7. Discrepancy protocol, the four findings, each with its counter-case

**D1, the proof is executed at a coefficient the block's inputs contradict.** *Located:* [line 1211](../findings/second-order.md), "With $g(w)=\sqrt{c+w^2}/(A+Bw)$". *Exhibited:* §2, $0.90360617/n$ computed against $0.78677479/n$ true at $n=12$, an overstatement of $14.85\%$, with the monotonicity of $\rho\mapsto(1/\rho+1/\kappa)^{-1/2}$ giving the direction. *Argued the other way:* the parenthetical on the same line (*"the repaired form carries $\rho_n$ on the $w^2$, treated in the blockquote above"*), is an explicit delegation, and the derivation's shape does transfer, $\mathop{\mathrm{sign}}g_\rho'=\mathop{\mathrm{sign}}(\rho Aw-Bc)$ having the same form for every $\rho$. The delegation fails only because the delegate (D2) is itself wrong at the coefficient it declares. **Reported.**

**D2, the blockquote's closed form is not a lower bound for the branch it defines.** *Located:* [line 1207](../findings/second-order.md), "What the closed form $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ remains is a **valid but lossy lower bound**". *Exhibited:* §4, $0.882764>0.860017$ at $n=14$ and $0.937182>0.898038$ at $n=16$, with the identity $\rho_n\kappa/(\rho_n+\kappa)=\kappa(n-8)/(3n-8)$ showing the closed form is the *uncorrected* branch's value. *Argued the other way:* §4's charitable reading, under which the sentence is about $\rho_n$ and is then an exact identity, but then it does not carry the conclusion it says it carries. **Reported, order-neutral.**

**D3, "a single interior minimum" is false on $[0,1]$ at every dimension in range.** *Located:* [line 1213](../findings/second-order.md). *Exhibited:* §3, $w^*_1>1\iff n^2-20n+18<0\iff n\le19$; $w^*_1(12)=1.28457$. *Argued the other way:* the block states the correct fact at [line 1207](../findings/second-order.md) and [Lemma L158](../findings/second-order.md) records it at [line 1274](../findings/second-order.md), so nothing on the record is misled by it; and with [line 1286](../findings/second-order.md)'s corrected $A=a_0n^{1/2}$ the coefficient-$1$ stationary point $3\sqrt{n-1}/n=0.829$ *is* interior. That last rescue fails once the corrected coefficient is also carried. **Reported as an internal contradiction rather than a new error.**

**D4, the penalty magnitude is charged twice, at two magnitudes.** *Located:* [line 1204](../findings/second-order.md) ($\tfrac29\lvert\kappa_n\rvert$) against [line 1219](../findings/second-order.md) ($\lvert\kappa_n\rvert$). *Exhibited:* the asymptotes $\tfrac32\sqrt2-\tfrac29\lvert\kappa_\infty\rvert=1.74238288$ and $\tfrac32\sqrt2-\lvert\kappa_\infty\rvert=0.41610210$, a factor $4.187$ apart. *Argued the other way:* the two price the penalty against different quantities, [line 1219](../findings/second-order.md) against the whole $\tfrac32\theta_0$ margin, [line 1204](../findings/second-order.md) against the differential coefficient, and [second-order.md line 949](../findings/second-order.md) independently carries $\tfrac29\lvert\kappa_n\rvert$, which favours the blockquote. Both are positive, so §5 shows the order conclusion is insensitive to the choice. **Reported as a constant-level indeterminacy, not a defect.**

*One candidate was tested and is **withdrawn**: that the bullet's $3\theta_0\frac{m-4}{2(m-1)}$ contradicts the same line's $3\theta_0\frac{m-3}{2(m-1)}$ for the smallest off-summand margin. §1 shows the first is $c_{\min}-c_p$ with $c_{\min}$ the second, exactly, so the two are consistent and the block's arithmetic is right. It fails the "exhibit the failure" test outright.*

## Verdict

**GAP.**

The boxed claim is **true**, branch 2 is $\ge0.7841/n$ for every $n\ge12$ and every $w\in[0,1]$, under the block's own $\rho^{\mathrm{eff}}$, and $\ge0.6156/n$ under its alternative penalty accounting. The block does not prove it. Its "Proof of the uniformity" minimises the wrong function ($\rho=1$, giving a value $14.85\%$ above the truth at $n=12$, in the direction that makes a lower bound worthless), locates that minimum at a point outside $[0,1]$ at every dimension in the range, and never evaluates the endpoint that is in fact the minimum there. The blockquote that is nominated to repair it supplies the corrected $w^*=2\sqrt n/(n-8)$ correctly, but its closing bound is stated for the pre-penalty coefficient and **fails as a lower bound at $n=14$, $n=16$ and asymptotically** for the coefficient it has just declared. No other text in the block supplies the missing step, which is a single line of unimodality: $\inf_{[0,1]}g_\rho\ge\inf_{w\ge0}g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho+\kappa)}$, with $\kappa\ge3\sqrt2$ and $\rho^{\mathrm{eff}}$ increasing in $n$.

Secondary: **HYPOTHESIS-DEBT** on the range, the stated $m\ge5$ admits $n=10$, where $\theta_0(10)=1.2<\sqrt{3/2}$ makes $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ negative and $\rho_n^{\mathrm{eff}}$ undefined as written; the honest range is $m\ge6$. And $\ker W^*=0$, on which the whole second branch depends for its existence, is used and never stated.
