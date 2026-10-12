# Review r716, Gate 2 on [Lemma L158](../findings/second-order.md)'s "THE MINIMISER IS THE KINK" blockquote: is the kink where it is said to be?

*Cold brief, analysis-only. The only compute below is one screen of the branch-2 objective at $n=12$ on functions I construct here from the definitions, run to place a minimiser I had already located by hand; it is reported as a screen and it is not the evidence for any positive claim. No search, sweep, census or optimisation was run.*

| Claim | Verdict |
| --- | --- |
| **C1**, $H$ is a unit normal direction, so $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$, whence $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}+w,1)$ and the triangle term is inadmissible for $w>1-a_0n^{-1/2}$ | **PREMISE CONFIRMED, ENVELOPE REFUTED.** The normalisation is right and the two norms are compatible, I re-derived [Lemma L146](../findings/second-order.md)'s $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ and it comes out **only** on the Hilbert–Schmidt norm of the $\Lambda^2$ operator, so $\lVert H\rVert_{op}\le\lVert H\rVert_F$ is legitimate and $w\in[0,1]$. But $\min(a_0n^{-1/2}+w,1)$ is **not** the admissible envelope: $H_s\perp H_r$ forces $\lVert H_s\rVert_F=\sqrt{1-w^2}$, and L146 is homogeneous, so $\lVert H\rVert_{op}\le a_0n^{-1/2}\sqrt{1-w^2}+w$ holds at every $w$ and is **never larger**. Its crossing with $1$ is at $w_0=\tfrac{n-4}n=\tfrac23$ at $n=12$, not $1-a_0n^{-1/2}=0.5528$ |
| **C2**, with that kink branch 2 falls on $[0,w^*]$ and rises after, so the minimiser is $w^*=1-a_0n^{-1/2}=0.5528$ at $n=12$ | **REFUTED.** The *shape* claim survives, the objective falls, then rises, but the turning point is $w_0=(n-4)/n=0.6667$, wrong by $21\%$ in C2. At $\lambda(12)=6.275$ the minimiser is exactly $w_0$; at the record's $\lambda=1.53$ it is $0.648$, interior and just below $w_0$. **Neither is $0.5528$, and the gap is not an artefact of $\lambda$** |
| **C3**, the correct minimum is $0.2793$ against r714's unkinked $0.2209$, so the admissible bound is $26\%$ better | **REFUTED in both numbers and in the percentage.** Neither value is reproducible from the record's constants at either $\lambda$, and the pair is not consistent with any single $\lambda$. The improvement over r714's endpoint is $27.8\%$ at $\lambda(12)=6.275$ and $19.4\%$ at $\lambda=1.53$; C1's own kink yields $21.9\%$ and $11.1\%$. **And C1's minimum understates the true admissible one by $4.9\%$**, the same lossiness C2 charges against r714 |
| **C4**, the $0.829$ cited by [Lemma L157](../findings/second-order.md), [r709](REVIEW_r709.md) and [r712](REVIEW_r712.md) is [Lemma L149](../findings/second-order.md)'s interior minimum $Bc/A$, which lies above the kink and is unreachable | **CONFIRMED, and under-stated.** $Bc/A=c_p/(a_0n^{-1/2})=0.370810/0.447214=0.82916$ exactly, and it lies above **both** candidate kinks. It fails for a second, independent reason as well: with $(1-\eta^*)^2$ inside the minimisation it is not the minimiser of the *unkinked* objective either ([r714](REVIEW_r714.md)), which is the endpoint. **$0.829$ minimises $\sqrt{c_p+w^2}/(a_0n^{-1/2}+w)$ and nothing the chain minimises** |

## The normalisation, settled from the definitions

**The press-point about $F$ versus $op$ dissolves, and I checked it rather than assumed it.** [Lemma L146](../findings/second-order.md) gives the Weyl image of $h\in S^2_0(\mathbb R^m)$ as diagonal on coordinate $2$-planes with $\alpha h_a$ on the $m^2$ cross planes, $-\beta(h_a+h_{a'})$ on the $\binom m2$ in-block planes and $0$ inside the other block, $\alpha=\tfrac{m-2}{2(m-1)}$, $\beta=\tfrac m{2(m-1)}$. Summing squares over $a<b$, and using $\sum_ah_a=0$ to turn $\sum_{a<a'}(h_a+h_{a'})^2$ into $(m-2)\lVert h\rVert^2$:

$$m\alpha^2+(m-2)\beta^2=\frac{m(m-2)\big[(m-2)+m\big]}{4(m-1)^2}=\frac{m(m-2)}{2(m-1)},$$

which is L146's stated $\lVert H\rVert_F^2/\lVert h\rVert^2$ **exactly**. So $\lVert\cdot\rVert_F$ in this chain is the Hilbert–Schmidt norm of the same $\Lambda^2$ operator whose $op$ norm appears beside it, and $\lVert H\rVert_{op}\le\lVert H\rVert_F$ is the ordinary comparison rather than a mixing of two conventions. *The same computation returns $\lVert H\rVert_{op}/\lVert H\rVert_F=1/\sqrt{m-1}$ at the pair-concentrated $h$, confirming L146's supremum and, with it, that $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$ is one quantity written two ways.* **So C1's premise is sound, and $w=\lVert H_r\rVert_F\le\lVert H\rVert_F=1$ makes $[0,1]$ the right range with $w=1$ attained.**

## The defect: the record's own homogeneity remark relocates the kink

> **THE ADMISSIBLE ENVELOPE IS $a_0n^{-1/2}\sqrt{1-w^2}+w$, AND [LEMMA L149](../findings/second-order.md) SAYS SO IN THE SAME BULLET IT WRITES THE WEAKER FORM IN.** Its text reads *"by the triangle inequality and [Lemma L146](../findings/second-order.md), which is homogeneous so $\lVert H_s\rVert_F<1$ only helps"*, and $H_s$ and $H_r$ are components in orthogonal eigenspaces of the self-adjoint $L_e$, so $\lVert H_s\rVert_F=\sqrt{1-w^2}$ is not a bound but an identity. Homogeneity then gives
> $$\lVert H\rVert_{op}\;\le\;B_h(w):=\frac{\sqrt{1-w^2}}{\sqrt{m-1}}+w\;\le\;\frac1{\sqrt{m-1}}+w,$$
> *with equality at the two ends only.* **$B_h$ is admissible at every $w$, and the trivial bound overtakes it at $\alpha^2(1+w)=1-w$, i.e.**
> $$w_0=\frac{1-\alpha^2}{1+\alpha^2}=\frac{n-4}n,\qquad \alpha^2=\frac2{n-2},$$
> **which is $\tfrac23$ at $n=12$ against C1's $1-\alpha=0.5528$, and $\tfrac{n-4}n$ against $1-\sqrt{2/(n-2)}$ at every $n$.** *C1's envelope is therefore lossy on the whole of $(0,w_0)$ (it is $\min(B_t,1)$ where $\min(B_h,1)$ was available) and its kink is in the wrong place.*

**Why the location moves the verdict rather than decorating it.** The minimiser of branch $2$ is the point the record quotes every constant "at the binding direction" from. Under C1's envelope it is $0.5528$; under the admissible one it is $\tfrac23$ or a whisker below. *Three entries already carry a wrong binding direction from the same class of slip.*

## Redoing the minimisation, since both parties are being audited

**The objective, from the definitions.** Branch $2=\lambda\sqrt{c(H)}/\lVert A''\rVert$ with $\lVert A''\rVert\le2J\lVert H\rVert_{op}/\big((1-\eta^*)^2g_n\big)$ ([Lemma L156](../findings/second-order.md), [Lemma L157](../findings/second-order.md)), so

$$\text{branch }2=\frac{\lambda g_n}{2J}\cdot\Phi(w),\qquad \Phi(w)=\frac{(1-\eta^*(t(w)))^2\sqrt{c(w)}}{B(w)},\qquad t(w)=\frac{\lambda\sqrt{c(w)}}{2C},$$

with $1-\eta^*=\tfrac2{1+\sqrt{4t+1}}$, an algebraic simplification of [Lemma L157](../findings/second-order.md)'s root, since $\eta^*=1-\tfrac{s-1}{2t}$ and $2t=\tfrac{s^2-1}2$ for $s=\sqrt{4t+1}$. **Only $B$ and $c$ are in dispute; the prefactor $\lambda g_n/(2J)$ is $w$-free and cannot move a minimiser.** *At $n=12$: $\theta_0=1.236033$, $c_p=0.370810$, $g_n=0.1123666$, $C^*=\tfrac{42}{11}$, $J^*=6.94215$, $\alpha=0.4472136$. Reproducing [r714](REVIEW_r714.md) as a control, its $\inf_w\text{branch }2=0.0070074$ and bracket $0.565306$ come back to six figures, so I am minimising the same function it did.*

| envelope $B$ | $\lambda=1.53154$ | $\lambda(12)=6.2749$ |
| --- | --- | --- |
| $a_0n^{-1/2}+w$ ([r714](REVIEW_r714.md)) | $0.56531$ at $w=1$ | $0.31565$ at $w=1$ |
| $\min(a_0n^{-1/2}+w,\,1)$ (**C1/C2**) | $0.62824$ at $w=0.5528$ | $0.38468$ at $w=0.5528$ |
| $\min(a_0n^{-1/2}\sqrt{1-w^2}+w,\,1)$ (**admissible**) | $0.67486$ at $w=0.6484$ | $\mathbf{0.40347}$ at $w=\tfrac23$ |

**Three readings of the same paragraph.** *C2's qualitative claim is right and its quantitative one is not*: with any of the three envelopes the objective falls and then rises or falls monotonically, and the sign of the effect C2 identifies is correct, using $\lVert H\rVert_{op}\le1$ **does** raise the bound. **What is wrong is where, and by how much.** The minimum is $0.40347$, not C1's $0.38468$; the improvement over [r714](REVIEW_r714.md) is $27.8\%$ at $\lambda(12)$ and $19.4\%$ at $\lambda=1.53$, never the claimed $26\%$ at either; and C1's own figure is $4.9\%$ below the achievable one. *So C2 is right against [r714](REVIEW_r714.md) and lossy against the record's own homogeneity remark, which is precisely the charge C2 lays.*

> **$0.2793$ AND $0.2209$ ARE NOT REPRODUCIBLE, AND THEY ARE NOT CONSISTENT WITH EACH OTHER.** Every $w$-free prefactor cancels from a ratio, so $0.2793/0.2209=1.2644$ is a claim about $\Phi$ alone. $\Phi$ returns $1.2187$ at $\lambda(12)$ and $1.1113$ at $\lambda=1.53$ under C1's own envelope, and $1.2782$/$1.1938$ under the admissible one. **Forcing the pair through $\text{branch }2=\lambda ng_n\Phi/(2J)$ needs $\lambda=7.48$ for the first number and $\lambda=7.21$ for the second**, no single constant produces both. *I cannot say which chain produced them; I can say the record should not carry them.*

## Two further defects, neither party's

> **$c(H)\gtrsim c_p+w^2$ IS FALSE AS A CONSTANT AT $n=12$ AND $n=14$, AND IT ERRS UPWARD.** [Lemma L24](../findings/second-order.md) makes the margin the quadratic form $3\theta_0\sum_j(\tfrac12-\lambda_j)\lVert H_j\rVert^2$, so on $\lVert H\rVert_F=1$ it is a **convex combination** of the summand margins and the honest bound is
> $$c(H)\;\ge\;c_p(1-w^2)+c_{\min,r}w^2\;=\;c_p+3\theta_0\frac{m-4}{2(m-1)}\,w^2,$$
> with $c_{\min,r}=3\theta_0\tfrac{m-3}{2(m-1)}$, [Lemma L149](../findings/second-order.md)'s own smallest off-summand margin, quoted in the bullet directly below the one carrying $c_p+w^2$. **The coefficient is $0.74162$ at $n=12$ and $0.94626$ at $n=14$, reaching $1$ only at $n=16$.** *So at the two smallest dimensions in scope the record's numerator overstates a lower bound (by $23\%$ in $c$ and $11\%$ in $\sqrt c$ at $w=1$) which is a lower bound stated upward, the direction [Lemma L157](../findings/second-order.md) has twice been corrected for.* **Repairing it leaves every verdict above intact and moves the minimiser onto $w_0=\tfrac23$ at both $\lambda$**, so it strengthens the case against C2 rather than rescuing it.

> **[LEMMA L146](../findings/second-order.md) PRICES ONE COPY AND [LEMMA L149](../findings/second-order.md) APPLIES IT TO TWO, WHICH IS A GAP THAT HAPPENS TO CLOSE.** L149 puts $H_s$ in the **joint** $\lambda_m$-eigenspace of both $S^2_0(\mathbb R^m)$ summands; L146's $1/\sqrt{m-1}$ is derived for the image of a single $h$. A bare triangle inequality across the two copies would cost $\sqrt2$ and move $w_0$ to $\tfrac{1-2\alpha^2}{1+2\alpha^2}=0.4286$. **It is not needed.** The two images are orthogonal in Hilbert–Schmidt (their supports meet only on the cross planes, where the inner product is $\alpha^2(\sum_ah_a)(\sum_bh'_b)=0$), and the joint operator stays diagonal, so its $op$ norm is a maximum over planes: the in-block branch sees one copy only, and the cross branch, which L146 never considers, reaches $\sqrt{m-2}/m=0.3333$ at $m=6$ against $1/\sqrt{m-1}=0.4472$. *Concentrating in a single copy is best and L146's constant survives on the joint space, but the record should say so, since the direction it is applied in is not the direction it was proved in.*

## What I did not settle

- **$1$ is a crude envelope near $w=1$.** $\lVert H\rVert_{op}=\lVert H\rVert_F$ demands a rank-one $\Lambda^2$ operator, which the first Bianchi identity and tracelessness will generally forbid; a sharper universal constant would move $w_0$ again and improve every party's minimum. *Naming it is analytical work, not a screen.*
- **Whether $\lvert\kappa_n\rvert$ is the right object inside $\lambda$** is [Lemma L157](../findings/second-order.md)'s, Gate-2'd by [r709](REVIEW_r709.md) and [r710](REVIEW_r710.md), and I inherited it. *I evaluated at both $\lvert\kappa_{12}\rvert=0.10159$ ([Lemma L133](../findings/second-order.md)'s printed value, giving $\lambda=6.2749$) and the asymptote $1.7053$, and no verdict above turns on the choice.*
- **The threshold on $S$** is untouched here; branch $2$ still binds at $n=12$ under every envelope, by a factor between $10$ and $23$ against [Lemma L143](../findings/bounds.md)'s $S\le4.162$, so no reading of this paragraph makes branch $1$ or [I31](../plan.md) load-bearing at $n=12$.

**Inherited without re-derivation**: [Lemma L156](../findings/second-order.md)'s $C(\alpha,\gamma)$ and $(\alpha^*,\gamma^*,J^*)$; [Lemma L157](../findings/second-order.md)'s fixed point and the placement of $\lambda$; [Lemma L141](../findings/second-order.md)'s $c_p=3\theta_0/(n-2)$; [Lemma L27](../findings/nondegeneracy.md)'s summand eigenvalues; $g_n$ and $\theta_0$ from [conventions.md](../findings/conventions.md). **Re-derived here**: L146's Frobenius identity, its $1/\sqrt{m-1}$, its extension to the joint eigenspace, the envelope $B_h$ and its crossing $w_0=(n-4)/n$, the convex-combination form of $c(H)$, and the closed form $1-\eta^*=2/(1+\sqrt{4t+1})$.

## Recommended repairs to the audited blockquote

1. **Replace the envelope.** $\lVert H\rVert_{op}\le\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\;1\big)$, admissible at every $w$ because $\lVert H_s\rVert_F=\sqrt{1-w^2}$ exactly and [Lemma L146](../findings/second-order.md) is homogeneous.
2. **Move the kink and the minimiser** to $w_0=(n-4)/n$, $=\tfrac23$ at $n=12$; state that the minimiser is $w_0$ at $\lambda(12)$ and $0.648$ at $\lambda=1.53$, so it is at or just below the kink rather than at it by definition.
3. **Withdraw $0.2793$, $0.2209$ and "$26\%$"** and record $0.40347$ against $0.31565$, an improvement of $27.8\%$ at $\lambda(12)=6.2749$ and $19.4\%$ at $\lambda=1.53$, with the $\lambda$ named beside each.
4. **Keep C4** and add [r714](REVIEW_r714.md)'s independent reason: $0.829$ minimises the prefactor-free $\sqrt{c_p+w^2}/(a_0n^{-1/2}+w)$ and no objective the chain actually minimises.
5. **Repair $c(H)$** to $c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$, noting that the coefficient falls below $1$ exactly at $n=12$ and $n=14$.
6. **Say that [Lemma L146](../findings/second-order.md)'s constant is being used on the joint two-copy eigenspace**, and record the cross-plane branch that makes it survive there.
