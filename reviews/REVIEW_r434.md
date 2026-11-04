# Review r434, Lemma L135 and Post F59

*Adversarial audit, cold brief, 2026-09-03. Targets: [Lemma L135](../findings/route-a.md#lemma-l135-the-competitors-second-order-defect-coefficient-is-a-straight-line-quantity-minus-tfrac19-and-the-target-is-the-records-own-universal-ceiling) and [Post F59](../findings/route-a.md#post-f59-three-named-routes-to-c_2-fail-and-why-each-fails), read against the corrected [Lemma L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2), [Lemma L134](../findings/route-a.md#lemma-l134-the-competitor-side-second-order-margin-and-i3-reduced-to-one-bound-on-the-defect), [Lemma L17](../findings/route-a.md#lemma-l17-first-order-protection-at-the-rival-maximizer), [Lemma L140](../findings/route-a.md#lemma-l140-lvert-g_1rvert2letfrac14-for-every-unit-weyl-direction-and-i3-closes-for-every-nge12) and Result 7's by-products in [ATTEMPTS.md](../ATTEMPTS.md).*

**Standing rule inherited and observed.** This programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). **Everything below is derived by hand, no computation of any kind was run, not even a screen.** The two places where the record's own numbers are load-bearing are audited as *provenance* questions, not re-measured.

## Verdict

| claim | verdict |
| --- | --- |
| **L135(a)**, $c_2(H)=\Delta_2(H)-\tfrac19$ | **CONFIRMED**, and true more generally than stated. A one-line exact identity replaces both printed proofs; see [§1](#1-a-is-true-and-both-printed-proofs-are-the-same-proof). |
| **L135(a)**, the claim that the two proofs are independent | **REFUTED.** They share their only load-bearing ingredient. |
| **L135(b)**, the arithmetic | **CONFIRMED**, every figure recomputed. |
| **L135(b)**, "the record's own unconditional ceiling $\delta^2\le\tfrac14$, asked of a second-order coefficient rather than of a value" | **REFUTED as an identity, PLAUSIBLE as a heuristic.** $\Delta_2$ is not $\delta^2$ of any tensor except on the padded flat. Second over-reading of the same $\tfrac14$ inside the same lemma. |
| **L135(c)**, the cross term $2\langle g_0,g_2\rangle=-a\langle\star,Y_2\rangle$ | **REFUTED.** The sign is inverted; the correct value is $+a\langle\star,Y_2\rangle$. (c) prints $W_-=\tfrac12(W-\lvert W\rvert)$, contradicting its own Setting and [L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2)'s operative convention. |
| **L135(c)**, the two-branch account of the second order | **REFUTED as complete.** It omits the frame-tilt term, the same omission that killed [L137](REVIEW_r425.md), and it is void on $\{F=0\}$ by L136's own finding. |
| $\Delta_2=\lVert g_1\rVert^2+2\langle g_0,g_2\rangle$, $\langle g_0,X\rangle=a\langle\star,X\rangle$, $\mathrm{Alt}$ an orthogonal projection with $\mathrm{Alt}(\star)=\star$, $\lVert\star\rVert^2=6$, $a=\tfrac1{3\sqrt6}$, $\delta^2(u)=\tfrac19$ | **CONFIRMED**, each recomputed from the definitions. |
| $c_2$ is a genuine one-sided second derivative; Rellich applies | **CONFIRMED.** |
| **the hyper-Kähler class: $c_2\le0$** | **CONFIRMED**, and sharpened to $c_2=-\tfrac19$, $\Delta_2=0$ exactly. The class is one direction modulo the orbit and the stabiliser. |
| **the padded-flat check** | **CONFIRMED as an identity**; its independence claim **REFUTED**. |
| "the record's census gives $\max\delta^2=0.125$ on $\mathbb R^8$, so $c_2\le0.0139$ there" | **REFUTED.** A search maximum used as an upper bound; the evidence supports the opposite inequality. |
| **F59**, the slack mechanism | **CONFIRMED.** |
| **F59**, "concavity of $\delta$ is impossible" | **The proof is correct and fences the wrong statement.** A replacement fence, which does hold, is supplied in [§6](#6-f59s-concavity-bullet-proves-the-wrong-statement). |
| **F59**, "$u$ is not a local maximum of $\delta^2$ on $\{F=0\}$" | **CONFIRMED**, and the numerical input is used in the legitimate direction. |
| **F59**, "no bound on $\delta^2$ **alone** can do it" | **REFUTED, over-reach.** The sought conclusion is itself a bound on $\delta^2$ alone. |

**Nothing downstream falls.** [L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2) and [L140](../findings/route-a.md#lemma-l140-lvert-g_1rvert2letfrac14-for-every-unit-weyl-direction-and-i3-closes-for-every-nge12) use the correct sign and never touch $Y_2$; L135(a), the piece [L140](../findings/route-a.md#lemma-l140-lvert-g_1rvert2letfrac14-for-every-unit-weyl-direction-and-i3-closes-for-every-nge12) actually consumes, is sound. What is defective is L135(c) and three claims of independence.

## 1. (a) is true, and both printed proofs are the same proof

**The identity holds, and needs neither $H\perp u$ nor $\lVert H\rVert=1$.** For $\lvert t\rvert<\pi/2$ we have $\cos t>0$, so

$$\cos t\,u+\sin t\,H=\cos t\,\big(u+\tan t\,H\big)$$

is an identity of curvature operators. $W\mapsto W_-$ is positively homogeneous of degree one, $\mathrm{Alt}$ is linear, so $\delta^2$ is $2$-homogeneous and

$$\boxed{\ \delta^2(\cos t\,u+\sin t\,H)\;=\;\cos^2t\;\delta^2(u+\tan t\,H)\ }$$

**exactly**, for every $H$ and both signs of $t$. Writing $\tau=\tan t=t+\tfrac{t^3}3+O(t^5)$ and $\delta^2(u+\tau H)=\tfrac19+\Delta_1\tau+\Delta_2\tau^2+O(\tau^3)$, and $\cos^2t=1-t^2+O(t^4)$,

$$\delta^2(t)=\tfrac19+\Delta_1t+\big(\Delta_2-\tfrac19\big)t^2+O(t^3),\qquad\text{so } c_2=\Delta_2-\tfrac19 .$$

The $O(t^3)$ in $\tau$ cannot reach the $t^2$ coefficient, because $\tau^2=t^2+O(t^4)$ and the $\Delta_1\tau$ term feeds it only at $t^3$. **CONFIRMED**, and the brief's worry about $\arctan$ feedback is answered: it is one order too high in both directions.

**The first printed proof elides a step.** It says the great circle differs from the straight line by $\mathcal D_u\big[-\tfrac{t^2}2u\big]=-\tfrac{t^2}2u_-$, justified by "positive homogeneity, so the derivative at $u$ in the direction $u$ is $u_-$". That is Euler's relation along the ray through $u$, and it is correct, but the perturbation $-\tfrac{t^2}2u$ is applied at $u+tH$, not at $u$, and $W\mapsto W_-$ is not differentiable at $u$. The repair is one line and is not written down: with $V=u+tH$ and $\varepsilon=\tfrac{t^2}2$, $V-\varepsilon u=(1-\varepsilon)V+\varepsilon tH$, so by homogeneity and Moreau nonexpansiveness $(V-\varepsilon u)_-=(1-\varepsilon)V_-+O(t^3)=V_--\tfrac{t^2}2u_-+O(t^3)$. The conclusion stands.

**The two proofs are not independent.** The lemma says the homogeneity route "shares nothing with the block expansion, no spectral perturbation theory, no branch analysis". That is true of *technique* and false of *content*: the $2$-homogeneity of $\delta^2$ used in proof 2 is *derived from* the degree-one positive homogeneity of $W\mapsto W_-$, which is proof 1's only load-bearing ingredient, everything else in proof 1 (the Daleckii–Krein term, the sliver remark) is the same fact dressed as perturbation theory. Proof 2 is proof 1 with the inessential machinery deleted, and the exact identity above is proof 2 with the $\arctan$ deleted. **The lemma banks a corroboration it does not have.** The ingredient is trivially true, so nothing breaks; the claim of independence is what is refuted.

**$c_2$ is well defined and Rellich does apply.** $t\mapsto W(t)$ is affine hence real-analytic, and symmetric on $\Lambda^2\mathbb R^n$, so Rellich gives real-analytic eigenvalues $\lambda_i(t)$ and eigenprojections through $t=0$. For each $i$ either $\lambda_i\equiv0$ or $\lambda_i$ has a fixed sign on some $(0,\varepsilon)$, so $\lvert\lambda_i(t)\rvert=\pm\lambda_i(t)$ there and $W(t)_-=\sum_i(\lambda_i)_-(t)\,P_i(t)$ extends analytically to $[0,\varepsilon)$. One-sided derivatives of every order exist at $0^+$; both $c_2$ and $\Delta_2$ are genuine coefficients, and no $t^2\log t$ can appear. **CONFIRMED.** The exact identity above also shows the one-sidedness of $c_2$ is entirely inherited from the straight line, the great circle adds none of its own.

## 2. (b), the arithmetic is right, the identification is not

Recomputed from the definitions, in this order: $\theta_0(12)=\sqrt{2\cdot11\cdot10}/12=\sqrt{220}/12=1.2360331$; $\lvert\kappa_{12}\rvert=9(\theta_0(12)-\sqrt{3/2})=9\cdot0.0112882=0.1015940$; $\theta^*/(2\lvert\kappa_{12}\rvert)=1.2247449/0.2031880=6.0276$, the lemma's $6.03$. In the limit $\theta_0\uparrow\sqrt2$, $\lvert\kappa_\infty\rvert=9(\sqrt2-\sqrt{3/2})=1.7052182$ and $\theta^*/(2\lvert\kappa_\infty\rvert)=0.3591135$; $\theta_0$ increases in $n$, so the threshold decreases and the limit binds. $\tfrac19+0.3591=0.47022$, and $0.47022/0.25=1.881$, the lemma's factor $1.88$. And $\tfrac19+\tfrac5{36}=\tfrac4{36}+\tfrac5{36}=\tfrac9{36}=\tfrac14$. **All CONFIRMED.**

**The $\tfrac14$ ceiling is real, and I re-proved it.** For a Weyl tensor $W$ the first Bianchi identity is $\mathrm{Alt}(W)=0$, so $\mathrm{Alt}(W_-)=\tfrac12\mathrm{Alt}(\lvert W\rvert)-\tfrac12\mathrm{Alt}(W)=\tfrac12\mathrm{Alt}(\lvert W\rvert)$, whence $\delta(W)=\tfrac12\lVert\mathrm{Alt}(\lvert W\rvert)\rVert\le\tfrac12\lVert W\rVert$ because $\mathrm{Alt}$ is an orthogonal projection and $\lVert\,\lvert W\rvert\,\rVert=\lVert W\rVert$. This reproduces Result 7's by-product $\delta^2=\tfrac12\langle\mathrm{Alt}(W_-),\lvert W\rvert\rangle\le\tfrac14$ exactly. **And [L140](../findings/route-a.md#lemma-l140-lvert-g_1rvert2letfrac14-for-every-unit-weyl-direction-and-i3-closes-for-every-nge12)'s $\lVert g_1\rVert\le\tfrac12$ is the same instrument at the derivative level**, $\mathrm{Alt}(H)=0$, shift by $\tfrac12H$, use $\lVert\mathrm{Alt}\rVert\le1$. So there is a genuine shared mechanism behind the two $\tfrac14$'s, and the lemma is right that the target is not arbitrary.

**But the boxed sentence claims more than that, and is false as stated.** $\Delta_2=\lVert g_1\rVert^2+2\langle g_0,g_2\rangle$ is not $\delta^2$ of any tensor: the cross term has no $\delta^2$ reading, and $\Delta_2$ carries no a-priori sign, whereas every $\delta^2$ value is nonnegative. The identification "$\Delta_2\le\tfrac14$ **is** the ceiling $\delta^2\le\tfrac14$ asked of a coefficient" holds **only on the padded flat**, where $g_2=0$ and $\Delta_2=\delta^2(H)$ literally, which is exactly what the lemma's own check establishes and nothing more. Everywhere else it is an analogy between two applications of one instrument.

That matters because the lemma **already withdrew one over-reading of this same $\tfrac14$** (the claim that the flat attains $\tfrac5{36}$, caught by both of L134's reviewers). This is a second over-reading of the same number, and it sits **inside the boxed statement** rather than in the commentary. The honest form: *the ceiling $\Delta_2\le\tfrac14$ is reachable by the instrument that proves $\delta^2\le\tfrac14$, and coincides with it on the padded flat.*

## 3. (c), the convention is inverted, and the cross-term sign with it

**The operative convention, re-derived here from scratch rather than taken from L136.** $u$ has spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on the self-dual $3$-space $E$ and $0$ on $K$. With $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$:

$$\lvert u\rvert=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(2,1,1),\qquad u_-=\tfrac12(\lvert u\rvert-u)=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(0,1,1)\ \succeq0 .$$

$\mathrm{Alt}$ restricted to $S^2(\Lambda^2\mathbb R^4)$ is the orthogonal projection onto the line spanned by the Hodge operator $\star=\Pi_{SD}-\Pi_{ASD}$, with $\lVert\star\rVert^2=\mathop{\mathrm{tr}}(\star^2)=6$; so $\mathrm{Alt}(\star)=\star$, and $\langle g_0,\mathrm{Alt}(X)\rangle=a\langle\star,X\rangle$ for every $X$, **the two hypotheses the brief asks about are both satisfied**, and the second follows from $g_0$ being an $\mathrm{Alt}$-image rather than being an extra assumption. Then

$$\langle u_-,\star\rangle=\mathop{\mathrm{tr}}(u_-\star)=\tfrac1{\sqrt6}(0+1+1)=\tfrac2{\sqrt6},\qquad g_0=\mathrm{Alt}(u_-)=\tfrac{\langle u_-,\star\rangle}{6}\,\star=\tfrac1{3\sqrt6}\,\star=+a\star,$$

and $\delta^2(u)=6a^2=\tfrac6{54}=\tfrac19$. **Every constant in the Setting is confirmed, and confirmed only under $W_-=\tfrac12(\lvert W\rvert-W)$.**

**(c) prints the other convention.** Its words are: *"the line being affine, $W_-=\tfrac12(W-\lvert W\rvert)$ puts the entire second order into $\lvert W\rvert$"*. Under that sign, $u_-=-\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(0,1,1)$ and $g_0=-a\star$, contradicting L135's own Setting one paragraph above.

**And the contradiction is not cosmetic, it inverts the cross term.** With $V(t)=u+tH$ affine and $\lvert V(t)\rvert=\lvert u\rvert+tY_1+t^2Y_2+O(t^3)$, the $V$ term contributes nothing at second order, so

$$X_2=\tfrac12Y_2\quad\text{(operative)},\qquad\text{hence}\qquad 2\langle g_0,g_2\rangle=2a\langle\star,X_2\rangle=+a\langle\star,Y_2\rangle .$$

L135(c) writes $-a\langle\star,Y_2\rangle$, which is what $X_2=-\tfrac12Y_2$ gives, the printed, wrong convention. A minimal check of the sign of $X_2$ against $Y_2$, done by hand on a $2\times2$ block: $u=\mathop{\mathrm{diag}}(1,-1)$, $H$ the off-diagonal swap $H_{12}=H_{21}=1$ gives $\lvert u+tH\rvert=\sqrt{1+t^2}\,I$, so $Y_2=\tfrac12I$; and $(u+tH)_-=\tfrac12(\sqrt{1+t^2}\,I-(u+tH))$ has $t^2$-coefficient $\tfrac14I=\tfrac12Y_2$. **REFUTED.**

**This is the same collision that refuted [L137](REVIEW_r425.md).** [r426](REVIEW_r426.md) §1 named it in L135 explicitly; [L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2) was then corrected and now opens with the convention "stated first because the refutation turned on it", **and L135 was left as it was.** Its statement (c) is the piece a successor picks up when it goes after the cross term, and it hands them the wrong sign for the one quantity [L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2) exists to sign.

**Impact is local.** [L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2) writes $\Delta_2=\lVert g_1\rVert^2+2a\langle\star,X_2\rangle$ (the correct sign) and works through $\mathop{\mathrm{tr}}(\Pi_EX_2)$ and $\mathop{\mathrm{tr}}(\Pi_AX_2)$, never through $Y_2$. [L140](../findings/route-a.md#lemma-l140-lvert-g_1rvert2letfrac14-for-every-unit-weyl-direction-and-i3-closes-for-every-nge12) uses only $\mathrm{Alt}(H)=0$ and the multiplier range. **Nothing inherits the error.**

**Everything else in (c) that I could check is right.** $\Delta_2=\lVert g_1\rVert^2+2\langle g_0,g_2\rangle$ is the $t^2$ coefficient of $\lVert g_0+tg_1+t^2g_2+\cdots\rVert^2$; the Schur complement is standard second-order degenerate perturbation theory, $tD+(tC)^\top(0-\Lambda)^{-1}(tC)=t\big(D-tC^\top\Lambda^{-1}C\big)$; the $K$-block's negative part is $t(D_s)_-$ for $t>0$ by degree-one homogeneity; and the statement that on an affine line the whole second order sits in $\lvert W\rvert$ is true, once the sign is fixed.

**The branch account of $g_2$ is nevertheless incomplete, in the L137 way.** The block-diagonalising map $U(t)=I+tX+t^2Y+O(t^3)$ is orthogonal on $\Lambda^2\mathbb R^n$ but does **not** come from $SO(n)$, while $\mathrm{Alt}$ is only $SO(n)$-equivariant. From $W_-=U\big[(M_E)_-\oplus t(D_s)_-\big]U^\top$ one gets frame-tilt contributions $t^2\mathrm{Alt}([X,M_-^{(1)}])$ and $t^2\mathrm{Alt}([Y,u_-])$ to $g_2$, which (c) does not mention: it names only "the Schur complement $C^\top\Lambda^{-1}C$ fed through the derivative of $N\mapsto N_-$ at $D$". **That is the same shape as the omission (moving eigenvectors traced against a fixed projector), on which [r425](REVIEW_r425.md) and [r426](REVIEW_r426.md) refuted L137.** The $\lvert W\rvert$-route in the same sentence is basis-free and safe, so (c) offers two accounts of $g_2$ that do not agree. And by [L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2)'s own surviving structural fact, $\mathcal E_D$ **exists nowhere on $\{F=0\}$**, so (c)'s branch account is void on precisely the set it is written for. L135's closing paragraph still says $\mathcal E_D$ "exists only where $D$ is nonsingular on $K$", which is the weaker, now superseded reading.

## 4. The padded-flat check, right, and not independent

The identity is right and I verified it directly rather than through the direct-sum rule's statement. With $H$ supported on $\Lambda^2\mathbb R^{n-4}$ and $u$ on $\Lambda^2\mathbb R^4$, for $t>0$

$$(u+tH)_-=u_-\oplus tH_-,\qquad \mathrm{Alt}(u_-)\in\Lambda^4\mathbb R^4,\quad \mathrm{Alt}(H_-)\in\Lambda^4\mathbb R^{n-4},$$

which are orthogonal, so $\delta^2(u+tH)=\tfrac19+t^2\delta^2(H)$ **exactly**: $g_2=0$ outright, not merely $\langle g_0,g_2\rangle=0$. Hence $\Delta_2=\delta^2(H)$ and $c_2=\delta^2(H)-\tfrac19$, recovering [L134](../findings/route-a.md#lemma-l134-the-competitor-side-second-order-margin-and-i3-reduced-to-one-bound-on-the-defect)(c). **CONFIRMED.**

**"Recovered from a route that shares nothing with the direct-sum rule that first produced it" is false.** The route's own proof *is* the direct-sum rule: disjoint index support gives $(u+tH)_-=u_-\oplus tH_-$ and the orthogonality of the two $\mathrm{Alt}$-images. What changed is that the rule is applied in its proof rather than quoted in its statement. This is the second of three independence claims in the lemma that do not survive contact.

**And the numerical line inside this paragraph runs the wrong way.** The lemma withdraws the claim that the flat attains $\tfrac5{36}$ with: *"it does not, the record's census gives $\max\delta^2=0.125$ on $\mathbb R^8$, so $c_2\le0.0139$ there at $n=12$"*. Result 7's by-products in [ATTEMPTS.md](../ATTEMPTS.md) state that "unconstrained over all unit Weyl tensors the max exceeds $1/9$ from $n=6$ on and grows ($0.125$ at $n=8$, $0.145$ at $n=12$)", **ascent output, an attained value, hence a lower bound.** It supports $c_2\ge0.0139$ on the flat and says nothing about $c_2\le0.0139$. The arithmetic $0.125-\tfrac19=0.013889$ is right; the inequality direction is not. **REFUTED**, in a direction that costs nothing (the proven ceiling on the flat remains $\tfrac5{36}$ via $\delta^2\le\tfrac14$) but the sentence turns a search maximum into a theorem, which is the trap this record keeps rediscovering.

## 5. The hyper-Kähler class, CONFIRMED, and it is exactly computable

I did not take Result 7's by-product on trust; I re-proved it, and then computed the coefficient it is used to bound.

**The ansatz is a linear subspace.** The one-$\mathbb R^4$ hyper-Kähler ansatz is the space of self-dual Weyl tensors of $\mathbb R^4$ (trace-free symmetric operators on $\Lambda^2_+$, extended by zero) which is Fox's $5$-dimensional $\mathbb B$, and the record's [Lemma L17](../findings/route-a.md#lemma-l17-first-order-protection-at-the-rival-maximizer) equality list names its tangents as "supported on the self-dual space". Being linear, it is smooth at $u$, and a great circle with $H$ inside it stays inside it and stays unit-norm. **All four of the brief's structural questions answered affirmatively.**

**$\max\delta^2=\tfrac19$ on the ansatz, attained at $u$.** For $V$ with $\Lambda^2_+$-spectrum $\lambda=(\lambda_1,\lambda_2,\lambda_3)$, $\sum\lambda_i=0$: $V_-$ has spectrum $(\lambda_i)_-$ and $\mathrm{Alt}(V_-)=\tfrac{\langle V_-,\star\rangle}6\star=\tfrac{\sum_i(\lambda_i)_-}6\star$, so

$$\delta^2(V)=\tfrac16\Big(\sum_i(\lambda_i)_-\Big)^2=\tfrac1{24}\lVert\lambda\rVert_1^2,$$

using $\sum(\lambda_i)_-=\tfrac12\lVert\lambda\rVert_1$ when $\sum\lambda_i=0$. Maximising $\lVert\lambda\rVert_1$ on $\{\sum\lambda_i=0,\ \lVert\lambda\rVert_2=1\}$: the two vertex types give $\tfrac1{\sqrt2}(1,-1,0)\mapsto\sqrt2=1.41421$ and $\tfrac1{\sqrt6}(2,-1,-1)\mapsto\tfrac4{\sqrt6}=1.63299$, and the latter is the maximum. Then $\delta^2=\tfrac1{24}\cdot\tfrac{16}6=\tfrac19$. **CONFIRMED, by hand.**

**$c_2\le0$ follows, and the first-order hypothesis is free.** Because the ansatz is linear, $\pm H$ both lie in it, so a two-sided maximum forces $c_1=0$ with no appeal to $\{F=0\}$, the record's argument is self-contained here, though it does not say so.

**The class is inside $\{F=0\}$ and off the orbit, so this is not vacuous.** For $H$ in the ansatz with $H\perp u$: trace-freeness gives $H_{11}+H_{22}+H_{33}=0$ and $\langle H,u\rangle=\tfrac1{\sqrt6}(2H_{11}-H_{22}-H_{33})=0$, so $H_{11}=0$ and $H_{22}+H_{33}=0$; and $P_0HP_0=0$ since $u$ is nonsingular on $E$, killing the kink branch. So $F(H)=0$. Orbit tangents $[\xi,u]$ have zero diagonal in $u$'s eigenbasis, so the spectrum-deforming direction is orthogonal to $T_u\mathcal O$. **Both hypotheses of [L134](../findings/route-a.md#lemma-l134-the-competitor-side-second-order-margin-and-i3-reduced-to-one-bound-on-the-defect)(d) hold.**

**The exact coefficient, which the lemma leaves as an inequality.** Take $H=\tfrac1{\sqrt2}\mathop{\mathrm{diag}}(0,1,-1)$. Along the great circle, $\lambda(t)=\cos t\,\tfrac1{\sqrt6}(2,-1,-1)+\sin t\,\tfrac1{\sqrt2}(0,1,-1)$ has $\lambda_2<0$ for $0<t<\pi/6$, so $\lVert\lambda(t)\rVert_1=\tfrac4{\sqrt6}\cos t$ and

$$\delta^2(t)=\tfrac19\cos^2t\quad\Longrightarrow\quad c_2=-\tfrac19 .$$

Along the straight line, $\lambda=\big(\tfrac2{\sqrt6},\,-\tfrac1{\sqrt6}+\tfrac t{\sqrt2},\,-\tfrac1{\sqrt6}-\tfrac t{\sqrt2}\big)$ has $\lVert\lambda\rVert_1=\tfrac4{\sqrt6}$ **constant** for $\lvert t\rvert<1/\sqrt3$, so $\delta^2(u+tH)\equiv\tfrac19$ and $\Delta_2=0$. **These two are an independent check of L135(a) on a direction where nothing is trivial: $c_2=-\tfrac19=\Delta_2-\tfrac19=0-\tfrac19$. It passes.**

**How large the class is.** The ansatz meets $u^\perp$ in $4$ dimensions: the two off-diagonal directions $H_{12},H_{13}$ are orbit tangents ($[\xi,\Lambda]$ has entries $(\lambda_i-\lambda_j)\xi_{ij}$, and $\lambda_2=\lambda_3$ kills the $(2,3)$ entry), leaving $2$ dimensions all conjugate under the stabiliser to the single direction above. **So "the hyper-Kähler class" is one direction modulo the orbit and the stabiliser**, genuine, but the record's presentation as one of "three classes" of cone direction overstates its size relative to the padded flat's $\dim\mathcal W_{n-4}$ and the mixed block's $4(n-4)$.

## 6. F59's concavity bullet proves the wrong statement

**The printed proof is correct.** $\delta$ is nonnegative and $1$-homogeneous, and it is even on $\mathcal W_n$, the record's own by-product $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$ for Bianchi $W$ is exactly $\delta(-W)=\delta(W)$, since $\mathrm{Alt}(W)=0$ makes $W_+=W_-+W$ have the same $\mathrm{Alt}$-image. (Evenness genuinely needs the Bianchi identity: off $\mathcal W_n$, $\mathrm{Alt}(W_+)-\mathrm{Alt}(W_-)=\mathrm{Alt}(W)\ne0$.) Concavity on $\mathcal W_n$ would then give $0=\delta(0)\ge\tfrac12\big(\delta(W)+\delta(-W)\big)=\delta(W)\ge0$, so $\delta\equiv0$, contradicting $\delta(u)=\tfrac13$. **Correct.**

**It fences the wrong object.** The route F59 is closing is stated in its own words as "letting $t\to\infty$ against $\delta^2(u+tH)/t^2\to\delta^2(H)$", that is concavity of the **one-variable** function $h_H(t)=\delta^2(u+tH)$ along an affine line that does **not** pass through the origin. Global non-concavity of $\delta$ on $\mathcal W_n$ says nothing about concavity of $h_H$: the argument's whole force comes from evaluating at $0$ and at $-W$, and neither point is on the line. **A $2$-homogeneous nonnegative even function can perfectly well be concave along an affine line off the origin**, $f(x,y)=x^2$ is constant, hence concave, along $x=1$.

**The fence stands, and here is an argument that actually establishes it.** $\delta^2$ is continuous and $2$-homogeneous, so $h_H(t)/t^2=\delta^2(u/t+H)\to\delta^2(H)$ as $t\to\infty$. A concave function on $[0,\infty)$ is bounded above by an affine function, so it cannot grow quadratically. Hence:

> $h_H$ is concave on $[0,\infty)$ **only if** $\delta^2(H)=0$, and in that case, with $h_H'(0^+)=0$ on $\{F=0\}$, concavity gives $h_H(t)\le h_H(0)$, so $\Delta_2\le0$, which is stronger than the target.

So concavity is impossible in every direction where it would have said something new, and where it is not excluded it delivers the bound for free. This is line-specific, needs no evenness, and is what F59's bullet should say. Grade: **conclusion CONFIRMED by replacement, printed proof REFUTED as a fence.**

The convexity half is right as stated ($f$ convex with $f'(0)=0$ gives $\Delta_2\ge0$ and no upper bound) and the operator-convexity remark is right in kind, since $\mathop{\mathrm{tr}}(\Pi f(W))$ needs $f$ operator convex where $\mathop{\mathrm{tr}}f(W)$ needs only scalar convexity. F59's "need not be convex" is the correct hedge; [L135](../findings/route-a.md#lemma-l135-the-competitors-second-order-defect-coefficient-is-a-straight-line-quantity-minus-tfrac19-and-the-target-is-the-records-own-universal-ceiling)'s parallel sentence hardens it to "is not convex", which is not demonstrated anywhere.

## 7. F59's other two bullets, and where it over-reaches

**The slack mechanism: CONFIRMED.** On $\{F=0\}$, $\delta^2(t)=\tfrac19+c_2t^2+O(t^3)$, and $\delta^2\le C$ with $C>\tfrac19$ reads $c_2t^2\le(C-\tfrac19)+O(t^3)$, satisfied by every real $c_2$ once $t$ is small. Correct, and not vacuous, it is exactly why the three named instruments fail.

**"$u$ is not a local maximum of $\delta^2$ on $\{F=0\}$": CONFIRMED, and the numerics are used correctly.** The padded flat is in the cone ([L17](../findings/route-a.md#lemma-l17-first-order-protection-at-the-rival-maximizer)'s equality list, found by Reviewer 9) and orthogonal to $T_u\mathcal O$ (orbit tangents $[\xi,u]$ meet the distinguished $\mathbb R^4$; $H$ does not), and $\delta^2(\cos t\,u+\sin t\,H)=\cos^2t\cdot\tfrac19+\sin^2t\cdot\delta^2(H)$ exceeds $\tfrac19$ for $t>0$ as soon as $\delta^2(H)>\tfrac19$. **All this bullet needs is a witness**, and Result 7 supplies one, the $\theta=0$ stratum reaches $\delta^2=1/8$ at $n=8$. A search maximum is a legitimate *lower* bound, so the use here is sound where the use in [§4](#4-the-padded-flat-check-right-and-not-independent) is not. Worth stating in F59 that $0.125$ is a witness, not a maximum, so the next reader does not reuse it as a ceiling.

**"No bound on $\delta^2$ **alone** can do it", REFUTED as over-reach.** The three sub-arguments cover (i) constant ceilings $\delta^2\le C$, (ii) global concavity, and (iii) sharpness of the form $\delta^2\le\tfrac19$ near $u$ on the cone. They do not cover a **local quadratic** bound

$$\delta^2(W)\ \le\ \tfrac19+\beta\,d(W,u)^2+o\big(d(W,u)^2\big)\qquad\text{on }\{F=0\}\cap T_u\mathcal O^\perp,$$

which is a bound on $\delta^2$ alone, is compatible with $u$ failing to be a local maximum, and with $\beta\le\tfrac5{36}$ **is** [I3](../plan.md). The sought conclusion is itself of that form, so the closing sentence is self-undermining. The same sentence is contradicted two paragraphs earlier by F59's own hyper-Kähler exception, which is a bound on $\delta^2$ alone that does work. **The honest fence: no bound on $\delta^2$ that is a constant ceiling, and no bound not sharp at $u$ to first order, can constrain $c_2$.** As stated, F59 also appears to fence a bound on $\delta^2$ restricted to a subvariety or combined with a second quantity, neither of which its arguments touch.

**Would any of this be true vacuously?** Checked at each step. (a)'s identity has content because $\Delta_2\ne c_2$ (the hyper-Kähler direction gives $0$ against $-\tfrac19$). The hyper-Kähler class is non-empty modulo the orbit and lies in $\{F=0\}\cap T_u\mathcal O^\perp$, verified above. F59's padded-flat witness is non-empty for $n\ge12$, which is the regime in question. The one place the vacuity question bites is (c)'s branch account, which is void on $\{F=0\}$ because $\mathcal E_D$ does not exist there.

## What the record should change

1. **[L135](../findings/route-a.md#lemma-l135-the-competitors-second-order-defect-coefficient-is-a-straight-line-quantity-minus-tfrac19-and-the-target-is-the-records-own-universal-ceiling)(c): replace $W_-=\tfrac12(W-\lvert W\rvert)$ with $W_-=\tfrac12(\lvert W\rvert-W)$ and the cross term with $+a\langle\star,Y_2\rangle$.** Carry [L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2)'s convention paragraph into L135 so the two lemmas state one convention.
2. **Replace both proofs of (a) with the exact identity** $\delta^2(\cos t\,u+\sin t\,H)=\cos^2t\,\delta^2(u+\tan t\,H)$, which holds for every $H$ and both signs of $t$, and drop the claim that the two routes are independent.
3. **Withdraw "$c_2\le0.0139$ there"**, the census figure is a witness, and supports the reverse inequality. The flat's proven ceiling is $\tfrac5{36}$ from $\delta^2\le\tfrac14$.
4. **Restate (b)'s $\tfrac14$ identification** as "reachable by the same instrument, and literally the same quantity on the padded flat".
5. **Record $c_2=-\tfrac19$ and $\Delta_2=0$ on the hyper-Kähler class**, with its size stated: one direction modulo the orbit and the stabiliser.
6. **Replace F59's concavity proof** with the line-specific one of [§6](#6-f59s-concavity-bullet-proves-the-wrong-statement), and **narrow its closing sentence** to constant and non-sharp ceilings, a local quadratic bound on $\delta^2$ is what the programme is looking for, and F59 currently reads as fencing it out.
