# Review r715, Gate 2 on [Lemma L158](../findings/second-order.md)'s "THE MINIMISER IS THE KINK" blockquote

*Reviewer r715, 2026-09-05, cold brief, analysis-only. The shape results below are hand algebra, the elasticity identity in the first section is exact and parameter-free. The only computation is a re-evaluation of closed forms already on the record ($c_p$, $\kappa$, $a_0$, $g_n$, $J^*$, $\gamma^*$, $\eta^*(t)$, $\lvert\kappa_{12}\rvert$) at $n=12$, on objects built for that purpose, reported as a screen and never as evidence for a positive claim. No sweep, census, optimisation or falsifier hunt was opened.*

## Verdicts

| claim | verdict |
|---|---|
| **C1**, $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$, so the envelope is $\min(a_0n^{-1/2}+w,1)$ and the triangle term is inadmissible for $w>1-a_0n^{-1/2}$ | **REFUTED as stated; the elementary inequality itself CONFIRMED.** The normalisation is Frobenius and $\lVert H\rVert_{op}\le1$ is right. But $H=H_s+H_r$ is an *orthogonal* split with $w=\lVert H_r\rVert_F$, so $\lVert H_s\rVert_F=\sqrt{1-w^2}$, and [Lemma L146](../findings/second-order.md)'s homogeneity, which [Lemma L149](../findings/second-order.md) states and then discards, gives the admissible envelope $\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\,1\big)$. Its kink is at $w=\tfrac{1-a^2}{1+a^2}=\tfrac23$, not $1-a=0.5528$ |
| **C2**, branch 2 falls on $[0,w^*]$ and rises after, so the minimiser is $w^*=1-a_0n^{-1/2}=0.5528$; r713 right, r714 lossy | **Shape CONFIRMED and strengthened; location REFUTED.** The rise above the kink is *exact and $\lambda$-free*: $\mathrm d\log N/\mathrm d\log s=1/\sqrt{4t+1}\in(0,1)$, so $K(w)\sqrt{c_p+w^2}$ strictly increases for every $\lambda,J,\gamma$, r714's dispute of the rise is settled against it, without arithmetic. But the minimiser is $w^*=\tfrac23$ at $\lambda(12)$, and r714's endpoint is the correct minimiser *of the envelope r714 was handed* |
| **C3**, the correct minimum is $0.2793$ against $0.2209$, so the admissible bound is $26\%$ better | **REFUTED numerically; CONFIRMED in direction.** Neither number reproduces from the record's own constants. At $\lambda(12)=6.2748$, $J^*=6.9421$, $\gamma^*=0.55$ the pair is $0.2459$ / $0.2017$, a gain of $21.9\%$; with the *corrected* envelope it is $0.2579$ / $0.2017$, a gain of $27.8\%$. The claim's own construction gives $22\%$, not $26\%$, and its absolute values are unaccounted for |
| **C4**, $0.829$ is [L149](../findings/second-order.md)'s interior minimum $Bc/A$, above the kink and unreachable | **CONFIRMED, and understated twice.** $Bc/A$ *as L149 writes it* ($A=n^{1/2}$) is $\kappa n^{-1/2}=1.2845$, not $0.829$; $0.829$ is the repair L158 itself supplies, $c_p/(a_0n^{-1/2})=3\sqrt{n-1}/n$. And "unreachable because above the kink" is too weak: once $K(w)$ is carried at $\lambda(12)$, branch 2 under the crude envelope has **no interior stationary point at all** on $w>0$ |

**One-line verdict: the blockquote wins its argument against [r714](REVIEW_r714.md) and then puts the kink in the wrong place. $\lVert H\rVert_{op}\le1$ is true but is not the sharp constraint, the record's own $\lVert H_s\rVert_F=\sqrt{1-w^2}$ is, it moves the kink from $0.5528$ to $\tfrac23$, and at $w=1$ it makes the triangle bound exactly $1$ with no $\min$ needed, because the component the triangle bound is pricing is not there.**

## The defect: $H_s$ and $H_r$ are orthogonal, so $\lVert H_s\rVert_F$ is not $1$

**[Lemma L149](../findings/second-order.md) fixes the split and the record fixes the norm.** L149 writes $H=H_s+H_r$ with $H_s$ in the joint $\lambda_m$-eigenspace of $L_e$ (both $S^2_0(\mathbb R^m)$ copies) and $H_r$ the part outside both, and sets $w:=\lVert H_r\rVert$. These are distinct eigenspaces of the self-adjoint $L_e$, hence orthogonal in the record's Frobenius inner product; L149's own calibration ("a unit vector in that copy has $w=1$"), fixes $\lVert\cdot\rVert$ as Frobenius and $H$ as normalised. So

$$\lVert H_s\rVert_F^2+w^2=1,\qquad w\in[0,1].$$

**C1's premise is therefore right and its conclusion is loose.** [Lemma L146](../findings/second-order.md) bounds $\lVert H_s\rVert_{op}\le\lVert H_s\rVert_F/\sqrt{m-1}$, and $\sqrt{2/(n-2)}=1/\sqrt{m-1}=a_0n^{-1/2}$ with $a_0=\sqrt{2n/(n-2)}$, the two records agree, and $a_0n^{-1/2}$ *is* an operator-norm bound per unit Frobenius norm, so mixing $op$ and $F$ across the sum is legitimate ($\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F=w$ is the trivial direction of the same inequality). Writing $a:=a_0n^{-1/2}=1/\sqrt5=0.447214$ at $n=12$:

$$\lVert H\rVert_{op}\;\le\;\Phi(w):=\min\big(a\sqrt{1-w^2}+w,\ 1\big).$$

**L149 states the refinement and drops it in the same clause** (*"which is homogeneous so $\lVert H_s\rVert_F<1$ only helps"*) and L158's blockquote inherits the dropped version. The cost is not uniform:

| $w$ | crude $a+w$ | refined $a\sqrt{1-w^2}+w$ | $\min(\cdot,1)$ |
|---|---|---|---|
| $0$ | $0.4472$ | $0.4472$ | $0.4472$ |
| $0.5528$ | $1.0000$ | $0.9255$ | $0.9255$ |
| $2/3$ | $1.1139$ | $1.0000$ | $1.0000$ |
| $1$ | $1.4472$ | $1.0000$ | $1.0000$ |

**The crossing is at $w=\tfrac{1-a^2}{1+a^2}$.** $a\sqrt{1-w^2}\le1-w\iff a^2(1+w)\le1-w$, which at $a^2=\tfrac15$ is $w\le\tfrac23$. *So the triangle term is inadmissible on $(\tfrac23,1]$, not on $(0.5528,1]$, and C1's kink is wrong by $0.114$, about $21\%$ of the interval it is trying to name.*

> **AND AT THE ENDPOINT THE $\min$ IS NOT NEEDED AT ALL.** At $w=1$, $H_s=0$: the refined bound returns exactly $1$ on its own. **[r714](REVIEW_r714.md)'s $1.4472$ is not merely "lossy", it prices an $H_s$ that the constraint $\lVert H\rVert_F=1$ has already emptied.** *That is a stronger and more elementary objection than the one C1 makes, and it does not need $\lVert H\rVert_{op}\le\lVert H\rVert_F$ at all.*

**One further exposure, in the same direction.** [Lemma L146](../findings/second-order.md) computes the Weyl image of a *single* $h\in S^2_0(\mathbb R^m)$; L149's $H_s$ spans **both** copies. A term-by-term triangle estimate over the two copies would carry a factor $\sqrt2$, giving $a=0.6325$, and would move both kinks down again, the crude to $0.3675$, the refined to $0.4286$. *The block structure L146 exhibits (in-block planes disjoint between copies, cross planes shared) suggests the max rather than the sum governs, so this is an open constant rather than a refutation; it is recorded because every resolution of it moves the kink away from $0.5528$.*

## C2's shape is right, and the proof of it is exact and carries no constants

**Write branch 2 as $N(w)/\big(n\Phi(w)\big)$ with $N(w)=K(w)\sqrt{c_p+w^2}$, $K=\lambda(1-\eta^*)^2/(\sqrt2J)$, $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$.** Rationalising [Lemma L157](../findings/second-order.md)'s root,

$$1-\eta^*(t)=\frac{\sqrt{4t+1}-1}{2t}=\frac2{\sqrt{4t+1}+1}=:\psi(t).$$

Put $s=\sqrt{c_p+w^2}$ and $u=\sqrt{4t+1}$, so $t=\beta s$ with $\beta=\lambda/(2J\gamma)$ and $4t=(u-1)(u+1)$. Then $\log\psi=\log2-\log(u+1)$ gives $\dfrac{\mathrm d\log\psi}{\mathrm d\log t}=-\dfrac{2t}{u(u+1)}=-\dfrac{u-1}{2u}$, and hence

$$\boxed{\ \frac{\mathrm d\log N}{\mathrm d\log s}\;=\;1+2\,\frac{\mathrm d\log\psi}{\mathrm d\log t}\;=\;1-\frac{u-1}{u}\;=\;\frac1{\sqrt{4t+1}}\;\in\;(0,1).\ }$$

> **THIS SETTLES THE r713/r714 DISPUTE WITHOUT ARITHMETIC.** $N$ is **strictly increasing** in $s$, hence in $w$, for **every** $\lambda>0$, $J>0$, $\gamma>0$. *Above the kink $\Phi\equiv1$, so branch 2 there is $N/n$ and strictly rises.* **[r714](REVIEW_r714.md)'s claim that $K(w)$'s decrease can overturn the rise is refuted in general, not at $n=12$ only**, $\psi^2$ falls like $t^{-1}$ at worst, and $t\propto s$, so the product $\psi^2s$ can never fall.

**Below the kink it falls, and the threshold is $c_p/a$.** With $\Phi=a+w$, $\mathop{\mathrm{sign}}\frac{\mathrm d}{\mathrm dw}\log(\text{branch }2)=\mathop{\mathrm{sign}}\big(w(a+w)-u\,(c_p+w^2)\big)$, and since $u>1$ this is negative whenever $w(a+w)\le c_p+w^2$, i.e. **whenever $w\le c_p/a=0.8292$**. The kink lies well inside that, so branch 2 is strictly decreasing on $[0,\tfrac23]$ under either envelope. *The refined envelope was checked at the tightest point, $w=\sqrt{c_p}=0.6089$: $\mathrm d\log N/\mathrm dw=0.4195$ against $\Phi'/\Phi=0.6814$.*

**So the shape claim in C2 is right and the minimiser is the kink, the correct kink.**

$$w^*=\tfrac23\ \text{(at }\lambda(12)\text{)},\qquad\text{not }0.5528 .$$

*A screen over $w$ on a grid of $2000$ points returns the minimiser at $0.6665$ for $\lambda(12)=6.2748$ and at $0.6485$ for the asymptotic $\lambda=1.5315$, interior and just below the kink in the latter case, because a smaller $\lambda$ pushes the elasticity toward $1$. The location is therefore $\lambda$-dependent, which C2 does not say.*

## C3, the numbers do not reproduce, and the corrected gain is larger

**Constants, all read as quantities from their defining relations at $n=12$ rather than matched by letter.**

| constant | defining relation | value at $n=12$ |
|---|---|---|
| $\kappa=nc_p$ | $3\theta_0(\tfrac12-\lambda_m)\cdot n$, i.e. $3\sqrt{2(n-1)/(n-2)}$ ([L158](../findings/second-order.md)) | $4.44972$ |
| $c_p$ | $\kappa/n$ | $0.370810$ |
| $a_0$ | $\sqrt{2n/(n-2)}$ ([L158](../findings/second-order.md)); $a_0n^{-1/2}=1/\sqrt{m-1}$ ([L146](../findings/second-order.md)) | $1.549193$; $a=0.447214$ |
| $J^*$ | $4(1+\alpha^*)/\alpha^{*2}$, $\alpha^*=\tfrac{2m-1}{2(m-1)}$ ([L156](../findings/second-order.md)) | $6.9421$ |
| $\gamma^*$ | $D/4$ ([L156](../findings/second-order.md)) | $0.55$, so $C=J\gamma=3.8182$ |
| $\lambda$ | $2/\sqrt{\lvert\kappa_n\rvert}$ with $\lvert\kappa_{12}\rvert=0.10159$ ([L158](../findings/second-order.md)) | $6.27487$ (the asymptote gives $1.53155$) |

**Values of $n\cdot\text{branch }2$ at its minimum.**

| envelope | $\lambda(12)=6.2748$ | asymptotic $\lambda=1.5315$ |
|---|---|---|
| crude $a+w$ (r714's) | $0.20174$ at $w=1$ | $0.08819$ at $w=1$ |
| $\min(a+w,1)$ (the blockquote's) | $0.24588$ at $w=0.5530$ | $0.09801$ at $w=0.5525$ |
| $\min(a\sqrt{1-w^2}+w,1)$ (correct) | $0.25788$ at $w=0.6665$ | $0.10528$ at $w=0.6485$ |

- **$0.2793$ and $0.2209$ are not reproducible** from any combination of the record's own constants I could form. At $\lambda(12)$ the blockquote's own pair is $0.2459/0.2017$; at the asymptotic $\lambda$ it is $0.0980/0.0882$. Solving backwards for the $\lambda$ that would return $0.2793$ at $w=0.5528$ gives $\lambda\approx8.1$, which is on no page of the record.
- **$26\%$ is wrong for the blockquote's own construction**, which gives $21.9\%$; the correct envelope gives $27.8\%$. *The blockquote's figure is close to the right answer for the wrong object, which is the least useful kind of agreement.*
- **The direction is right and survives every correction**: the admissible envelope is smaller, so the branch-2 lower bound is larger, so r714's form understates the radius. That much of C3 is **CONFIRMED**.

**And the minimisation is over branch 2 alone, legitimately.** Against [Lemma L143](../findings/bounds.md)'s $S\le4.162$, branch 1 $\ge(c_p+w^2)/(S+aw)$ is at least $0.0891$ at $w=0$ and rises, while branch 2 at its minimiser is $0.25788/12=0.02149$, smaller by a factor $\ge4$ across $[0,1]$, so $\min(\text{branch }1,\text{branch }2)=\text{branch }2$ throughout and **branch 1 does not overtake near the kink**. *An upper bound on $S$ gives a lower bound on branch 1, which is the admissible direction here. [L157](../findings/second-order.md)'s "$58\times$" is not what the record's constants return; the separation is about $4$–$9\times$.*

## C4, right conclusion, and the reason on offer is not the strongest one

- **$Bc/A$ as [Lemma L149](../findings/second-order.md) literally writes it is $\kappa n^{-1/2}=1.2845$**, since L149 sets $A=n^{1/2}$, $B=n$, $c=c_p$. That exceeds $1$ and is what [Lemma L158](../findings/second-order.md) already flags. **$0.829$ is the *repaired* value** $c_p/a=3\sqrt{n-1}/n$, obtained by putting L146's $a_0$ into $A$. C4 attributes to L149 a number L149 does not contain.
- **It is above both kinks**, $0.5528$ and $\tfrac23$, so C4's conclusion, that $0.829$ is not the minimiser, is **CONFIRMED**.
- **The stronger reason: at $\lambda(12)$ it is not a stationary point of branch 2 at all.** With $K(w)$ carried, stationarity under the crude envelope needs $w(a+w)=\sqrt{4t+1}\,(c_p+w^2)$, and at $\lambda(12)$ the right side exceeds the left for every $w>0$ (at $w=1$: $1.4472$ against $3.0186$; at $w=2$: $4.894$ against $12.264$; and the right side grows like $w^{5/2}$ against the left's $w^2$). **So under the crude envelope branch 2 is strictly decreasing on all of $(0,\infty)$ and $0.829$ is a stationary point only of the $K$-free surrogate.** *This is also why [r714](REVIEW_r714.md) reached the endpoint: given the envelope it was handed, the endpoint is correct.*

## What the entry should say

- The envelope is $\lVert H\rVert_{op}\le\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\,1\big)$, from $\lVert H_s\rVert_F^2+w^2=1$ and [Lemma L146](../findings/second-order.md)'s homogeneity; its kink is $w=\tfrac{1-a^2}{1+a^2}$, which is $\tfrac23$ at $n=12$.
- The branch-2 minimiser is at or just below that kink, $0.6665$ at $\lambda(12)$, $0.6485$ at the asymptotic $\lambda$, so the location is $\lambda$-dependent and should be quoted with its $\lambda$.
- The rise above the kink needs no numbers: $\mathrm d\log\big(K\sqrt{c_p+w^2}\big)/\mathrm d\log\sqrt{c_p+w^2}=1/\sqrt{4t+1}>0$ for every $\lambda,J,\gamma$.
- $n\cdot\text{branch }2$ at the minimum is $0.2579$ at $\lambda(12)$ against r714's $0.2017$, a gain of $27.8\%$; $0.2793$, $0.2209$ and $26\%$ should be withdrawn.
- $0.829$ is [L158](../findings/second-order.md)'s repaired $3\sqrt{n-1}/n$, not [L149](../findings/second-order.md)'s $Bc/A$, and it is not a stationary point of branch 2 once $K(w)$ is carried.
- The two-copy constant in $a_0$ is open: [Lemma L146](../findings/second-order.md) prices one $S^2_0(\mathbb R^m)$ copy and [Lemma L149](../findings/second-order.md)'s $H_s$ spans both.

*[Lemma L148](../findings/second-order.md) empties $w=0$ of branch 2, so the domain is $w\in(0,1]$; the minimiser being interior, nothing above depends on the endpoint $w=0$.*
