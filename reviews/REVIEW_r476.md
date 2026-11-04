# REVIEW r476, Lemma L17, first-order protection at the rival maximizer

**VERDICT: CONFIRMED as an inequality, with four defects in what surrounds it, one of them a wrongly-withdrawn true fact that the record still leans on.**

Claim audited: [Lemma L17](../findings/route-a.md), the first-order statement at the $\mathbb{CP}^2$-type competitor $u$, cited by [Conjecture L16](../findings/problem.md), [Lemma L134](../findings/route-a.md), [Lemma L136](../findings/route-a.md), [Lemma L140](../findings/route-a.md), [plan.md](../plan.md) item I3 and the canon at [results.md](../results.md).

---

## 0. Where the proof actually is, and it is not in [findings/](../findings/)

[route-a.md](../findings/route-a.md)'s block headed "**Lemma L17, canonical statement and proof**" is a single prose paragraph, **byte-identical** to the canon entry at [results.md](../results.md) apart from the heading and the `Proof:` trailer. It carries no formula, no definition of $F$, no $a$, no branch decomposition. Its own note says the argument "was the only copy" in results.md and was moved here, **the move copied the summary and left the proof behind.**

The closed formula and its four ingredients live in [ATTEMPTS.md](../ATTEMPTS.md), Result 6:

$$d^+\delta^2(H)=-2a\,F(H),\qquad F(H)=H_{22}+H_{33}+\mathop{\mathrm{tr}}\!\big(\Pi_{ASD}(P_0HP_0)_-\big)\;\ge\;\tfrac23\mathop{\mathrm{tr}}(B_+)+\tfrac13\mathop{\mathrm{tr}}(B_-)\;\ge\;0 .$$

**So the record's own "canonical proof" location is empty**, and every downstream lemma that quotes "L17's $d^+\delta^2=-2aF$", [conventions.md](../findings/conventions.md) and [Lemma L136](../findings/route-a.md) both do, quotes a formula that appears nowhere in [findings/](../findings/). This is a structural defect, not a mathematical one, but it is why the two errors in §3 and §4 below survived.

---

## 1. The mathematics: every step rebuilt from definitions, and every step holds

All of the following was re-derived here, not read off.

| step | independent check | verdict |
| --- | --- | --- |
| $u$'s data: $\lVert u\rVert=1$, spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on the self-dual $3$-space $E$, kernel elsewhere | $\sum\lambda^2=6/6=1$ | holds |
| $\theta^*=P(u)=\sqrt{3/2}$ | $\mathop{\mathrm{tr}}(u^3)=1/\sqrt6$; $\langle u,u^\#\rangle=\tfrac12\cdot6\cdot T_{123}\lambda_1\lambda_2\lambda_3=2/\sqrt6$ with $T_{123}=c_{123}^2=2$ from $[A_1,A_2]=-\sqrt2A_3$ on the self-dual triple; total $3/\sqrt6=\sqrt{3/2}$ | holds, **exactly** |
| $\mathrm{Alt}(u_-)=a\star$, $a=\tfrac1{3\sqrt6}$ | $u_-$ is supported in $\Lambda^2\mathbb R^4$, so its $\Lambda^4$ part lies on the line $\mathbb R\star$; $a=\langle u_-,\star\rangle/\lVert\star\rVert^2=(2/\sqrt6)/6$ | holds |
| $\delta^2(u)=\tfrac19$ | $a^2\lVert\star\rVert^2=\tfrac1{54}\cdot6$ | holds |
| $\mathrm{Alt}(u_-)\rvert_{\ker u}=-a\Pi_{ASD}$ | $\star=\Pi_{SD}-\Pi_{ASD}$ restricted to $\ker u=A\oplus K'$ | holds |
| the $\tfrac13$ in $\mathrm{Alt}$ | $\mathrm{Alt}(\epsilon)_{ijkl}=\tfrac13(\epsilon_{ijkl}+\epsilon_{iklj}+\epsilon_{iljk})=\epsilon_{ijkl}$, since $ijkl\to iklj$ is a $3$-cycle on $\{j,k,l\}$ and hence even, so $\mathrm{Alt}$ is idempotent on $\star$ and the orthogonal-projection formula used above is the right one | holds |
| smooth branch $\Rightarrow-(H_{22}+H_{33})$ | $d^+\delta^2=2\langle\mathrm{Alt}(u_-),\mathrm{Alt}(\dot W_-)\rangle=2a\langle\star,\dot W_-\rangle$ (Alt self-adjoint idempotent, $\mathrm{Alt}\star=\star$); $\star$ is block-diagonal for $E\oplus A\oplus K'$, so only diagonal blocks survive and all Daleckii–Krein off-diagonal and $E$–$K$ tilt terms pair to zero **without needing any claim about eigenvector rotations**; $f(x)=x_-$ gives $f'(2/\sqrt6)=0$, $f'(-1/\sqrt6)=-1$ | holds |
| kink branch $\Rightarrow-\mathop{\mathrm{tr}}(\Pi_A(P_0HP_0)_-)$ | kernel eigenvalues move as $t\cdot\mathop{\mathrm{spec}}(P_0HP_0)$; $\star\rvert_A=-\Pi_{ASD}$; the trace is basis-free so the degeneracy of $\ker u$ costs nothing | holds |
| Bianchi: $H_{11}+H_{22}+H_{33}=\mathop{\mathrm{tr}}(B)$, $B=\Pi_{ASD}H\Pi_{ASD}$ | $\star\in\Lambda^4$, so $\langle H,\star\rangle=\langle\mathrm{Alt}H,\star\rangle=0$ for Weyl $H$ | holds |
| tangency: $2H_{11}=H_{22}+H_{33}$, hence $H_{22}+H_{33}=\tfrac23\mathop{\mathrm{tr}}(B)$ | $\langle H,u\rangle=\tfrac1{\sqrt6}(2H_{11}-H_{22}-H_{33})$ | holds |
| Jensen/Hansen–Pedersen: $\mathop{\mathrm{tr}}(\Pi_A N_-)\ge\mathop{\mathrm{tr}}(B_-)$ | $f(x)=x_-$ convex with $f(0)=0$, $\Pi_A\le P_0$ a contraction, $B=V^*NV$ | holds, **direction correct** |
| the chain $F\ge\tfrac23\mathop{\mathrm{tr}}B_++\tfrac13\mathop{\mathrm{tr}}B_-\ge0$ | $\tfrac23(\mathop{\mathrm{tr}}B_+-\mathop{\mathrm{tr}}B_-)+\mathop{\mathrm{tr}}B_-$ | holds |

Assembling: $u$ is a critical point of $P\rvert_S$ ($Q(u)=\theta^*u$), so $dP=0$ on $T_uS$ and

$$d^+\Phi(u;H)\;=\;-\kappa_n\,d^+\delta^2(u;H)\;=\;2a\,\kappa_n\,F(H)\;\le\;0\quad\text{whenever }\kappa_n\le0 .$$

**The lemma is true, and it is well posed**: the derivative is the one-sided directional derivative of $\Phi=P-\kappa_n\delta^2$ at $u$ along $\cos t\,u+\sin t\,H$, quantified over every $H\in T_uS\cap\mathcal W_n$, so $H$ and $-H$ are both covered and no two-sided derivative is ever claimed. $u$ is critical for $P$ but **not** for $\Phi$: off the equality cone the one-sided derivatives are strictly negative in both directions, which is a kink, not a critical point. The record states this correctly.

## 2. The sign of $W_-$, the expected break point, and it does not break

Under the record's convention $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$ everything above is as displayed: $a>0$, $F\ge0$, $\mathop{\mathrm{tr}}(B_\pm)\ge0$, the Hansen–Pedersen inequality points the stated way, and $\tfrac23\mathop{\mathrm{tr}}B_++\tfrac13\mathop{\mathrm{tr}}B_-\ge0$.

**Under the opposite convention the lemma's conclusion is unchanged.** $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ is a *square*, so flipping $W_-\mapsto-W_-$ leaves $\delta^2$, $d^+\delta^2$ and $d^+\Phi$ pointwise identical; what flips is $a\mapsto-a$ **and** $F\mapsto-F$ together, the product $-2aF$ being invariant. So:

- [conventions.md](../findings/conventions.md)'s "**this is forced by the rest of the record**" is **too strong as applied to L17**. What L17 forces is only that the *displayed intermediate* ($a>0$ **with** $F\ge0$) is stated in the $\succeq0$ convention. The lemma's conclusion is convention-free. The genuinely forcing uses are the one-sided ones downstream ([Lemma L136](../findings/route-a.md)'s $\Delta_2$ bound, the Daleckii–Krein multiplier range), exactly as that same line says two sentences later.
- **The load-bearing hypothesis in this lemma is not the sign of $W_-$; it is the first Bianchi identity.** Drop it and the lemma is false: $H=-\star$ has $H_{22}=H_{33}=-1$ and $(P_0HP_0)_-=(\Pi_A)_-=0$, giving $F=-2<0$. So "in any direction" must read *in any direction of $\mathcal W_n$*, never of $S^2(\Lambda^2)$.

## 3. DEFECT, [Lemma L136](../findings/route-a.md)'s first withdrawal is wrong, and the withdrawn fact is true

L136 records: *"the claim that $\mathcal E_D$ exists nowhere on $\{F=0\}$ because the equality case forces $A\subseteq\ker D$. **It does not**: $F=0$ forces $\Pi_AD_-=0$, which puts $A$ in $D$'s nonnegative spectral subspace, not in its kernel, witness $D=\varepsilon\Pi_A\oplus D'$ with $\varepsilon>0$ ([r429](REVIEW_r429.md))."*

**The witness is not on the cone.** For $D=\varepsilon\Pi_A\oplus D'$ the anti-self-dual compression is $B=\Pi_AD\Pi_A=\varepsilon\Pi_A$, so $\mathop{\mathrm{tr}}(B)=3\varepsilon$ and $\Pi_AD_-=0$, giving

$$F=\tfrac23\mathop{\mathrm{tr}}(B)+\mathop{\mathrm{tr}}(\Pi_AD_-)=2\varepsilon>0 .$$

The withdrawal used only *half* of what $F=0$ delivers. $F=0$ forces the whole chain to be tight, hence **both** $\mathop{\mathrm{tr}}(B_+)=\mathop{\mathrm{tr}}(B_-)=0$ (so $B=0$, a positive-semidefinite pair with zero trace), **and** $\mathop{\mathrm{tr}}(\Pi_AD_-)=\mathop{\mathrm{tr}}(B_-)=0$, so $\Pi_AD_-=0$. For $v\in A$ the second gives $D_-v=0$, hence $Dv=D_+v$; the first gives $\langle D_+v,v\rangle=0$ with $D_+\succeq0$, hence $D_+v=0$. **So $A\subseteq\ker D$ after all.**

*Consequences.* [route-a.md](../findings/route-a.md) still cites the withdrawn fact, "on $\{F=0\}$ it is void anyway by Lemma L136's own finding that $\mathcal E_D$ never exists there", so the record currently contains a claim and its retraction, and **the claim is the correct one**. Nothing breaks either way: L136's own bound uses only the weaker $\Pi_AD_-=0$, and using less information can only weaken an upper bound.

## 4. The equality cone is a LINEAR SUBSPACE, and it is far larger than the record says

The same computation classifies $\{F=0\}$ outright. $F=0\iff A\subseteq\ker(P_0HP_0)\iff P_0H\,\Pi_A=0$, the converse being immediate, since $A\subseteq\ker D$ kills both $B$ and $\Pi_AD_-$. So

$$\{F=0\}\;=\;\{H\in T_uS\cap\mathcal W_n\;:\;P_0H\Pi_A=0\},$$

**a linear subspace**, not merely a cone. Its defining conditions are the $H_{AA}$ block ($6$ equations) and the $H_{K'A}$ block ($3\dim K'$ equations), so at $n=12$, where $\dim K'=60$, the codimension is **at most $186$** inside $T_uS$ of dimension $1637$, the cone occupies at least $1451$ directions, roughly $89\%$ of the tangent space.

This is a substantive correction to the canon. [results.md](../results.md) presents the equality set as a classification, *"with the equality cases being the competitor's own orbit, its hyper-Kähler rotations, and … every Weyl tensor of the complementary $\mathbb R^{n-4}$"*, a list of at most $34+300+\dots$ directions at $n=12$. The record's own [Lemma L136](../findings/route-a.md) already names a fourth family outside that list (the mixed/vector isotype $(4,2)\otimes\mathbb R^{n-4}$), so the list was known to be incomplete when it was written.

**So L17 is not vacuous, but it is close to it.** $F>0$ generically, so the lemma has content; on the overwhelming majority of tangent directions the first-order term vanishes identically and the second order decides. That is exactly the load [Lemma L134](../findings/route-a.md), [Lemma L136](../findings/route-a.md) and [Lemma L140](../findings/route-a.md) carry, and the record is honest about it, but the canon's phrasing understates by two orders of magnitude how much of the work is left.

## 5. DEFECT, the canon's summary line contradicts itself

[results.md](../results.md)'s summary list reads: *"the penalized functional cannot increase to first order in any direction, **in any dimension**, and below the crossover the same formula reverses sign."* Both halves cannot hold. $d^+\Phi=2a\kappa_nF$ with $a>0$, $F\ge0$, so the sign is the sign of $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, which is **positive** for $n\le11$ ($\kappa_{11}=+0.0457$). The correct hypothesis is $n\ge12$, i.e. $n>6+2\sqrt7$, and the fuller entry lower in the same file states it correctly. **The one-line canon entry must gain "for every $n\ge12$".**

## 6. DEFECT, $\kappa_n$ is now defined two ways across the record

[results.md](../results.md)'s [Conjecture L16](../findings/problem.md) entry has been repaired to run against $\Theta_n$ rather than $\theta_0(n)$, because at odd $n$ the sphere-product maximum is $\Theta_n<\theta_0(n)$. L17 and [Lemma L134](../findings/route-a.md) still pin $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$. At $n=13$ the two differ by $6\%$, $-0.21268$ against $-0.22596$, so [Lemma L134](../findings/route-a.md)'s threshold $\theta^*/(2\lvert\kappa_n\rvert)$ is stated at odd $n$ for a constant [Conjecture L16](../findings/problem.md) no longer uses.

**L17 itself survives the repair**: its conclusion needs only $\kappa_n<0$, and $\Theta_n>\sqrt{3/2}$ still holds exactly for $n\ge12$. The asymptotic $\lvert\kappa_n\rvert\uparrow9(\sqrt2-\sqrt{3/2})=1.705218$ is also unaffected, both sequences tending to $\sqrt2$. Only the odd-$n$ thresholds move, and they move in the safe direction ($\lvert\kappa_n\rvert$ smaller, threshold larger).

## 7. SCREEN, "$F$ is convex" is false, and unneeded

[ATTEMPTS.md](../ATTEMPTS.md) justifies the numerical certification of $\inf F=0$ by "*$F$ is convex and $1$-homogeneous on the tangent space, so directed subgradient descent certifies the sign globally*". $1$-homogeneity holds. Convexity does not: $N\mapsto\mathop{\mathrm{tr}}(\Pi N_-)$ for a fixed projector $\Pi$ is **not** convex, $x\mapsto x_-$ is convex but not *operator* convex, and a weighted trace needs the latter. *Screen, reported as a screen*: over $2\times10^4$ random symmetric $4\times4$ pairs with $\Pi$ of rank $2$, the largest violation $f(\tfrac{A+B}2)-\tfrac12(f(A)+f(B))$ was $+0.175$. The screen is on unrestricted symmetric $N$; whether the Weyl restriction happens to restore convexity is unchecked. **Nothing depends on it**, $F\ge0$ is proved analytically by the chain in §1, so the subgradient argument is redundant rather than load-bearing.

---

## Verdict

**CONFIRMED.**

**Hypotheses it actually needs**, all of which the proof uses and only some of which the record states:

1. $H\in\mathcal W_n$, **the first Bianchi identity is load-bearing**, and the lemma is false without it ($F(-\star)=-2$).
2. $\langle H,u\rangle=0$, tangency, used to eliminate $H_{11}$.
3. $u$ critical for $P\rvert_S$, i.e. $Q(u)=\theta^*u$, otherwise $d^+\Phi\ne-\kappa_nd^+\delta^2$.
4. $u$'s exact structure: unit norm, spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on the self-dual $3$-space, kernel elsewhere. The coefficients $\tfrac23$ and $\tfrac13$ are this spectrum meeting the self-dual/anti-self-dual balance; no other competitor inherits them.
5. $\kappa_n\le0$, i.e. **$n\ge12$**, missing from the canon's one-line entry.
6. $\Pi_{ASD}\le P_0$, i.e. the anti-self-dual $3$-space lies inside $\ker u$, the contraction Hansen–Pedersen needs.

**The convention it actually requires:** none, for the conclusion, $\delta^2$ is a square and $d^+\Phi$ is invariant under $W_-\mapsto-W_-$. The displayed intermediate $d^+\delta^2=-2aF$ with $a>0,F\ge0$ requires $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$; under the other sign it reads $a<0$, $F\le0$, same product. **[conventions.md](../findings/conventions.md) overstates when it says L17 forces the sign.**

**Repairs owed** (none of them to the inequality):

| # | where | repair |
| --- | --- | --- |
| 1 | [route-a.md](../findings/route-a.md) L17 block | it is a summary, not a proof, move the formula, the four ingredients and $F$'s definition in from [ATTEMPTS.md](../ATTEMPTS.md) |
| 2 | [Lemma L136](../findings/route-a.md) | un-withdraw structural fact #1: $A\subseteq\ker D$ **does** hold on $\{F=0\}$; [r429](REVIEW_r429.md)'s witness has $F=2\varepsilon>0$ |
| 3 | [results.md](../results.md) and [Lemma L134](../findings/route-a.md) | record $\{F=0\}=\{P_0H\Pi_A=0\}$, a linear subspace of codimension $\le186$ at $n=12$; the three-family "equality cases" list is not a classification |
| 4 | [results.md](../results.md) summary line | add "for every $n\ge12$"; "in any dimension" contradicts the next clause |
| 5 | L17 / [Lemma L134](../findings/route-a.md) | reconcile $\kappa_n$ with [Conjecture L16](../findings/problem.md)'s $\Theta_n$ repair (odd $n$ only) |
| 6 | [conventions.md](../findings/conventions.md) | L17 is convention-free at the level of its conclusion; cite the one-sided downstream uses as what forces the sign |
