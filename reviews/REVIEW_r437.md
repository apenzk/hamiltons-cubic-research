# Review r437, Corollary L140.2

*Adversarial audit, cold brief, 2026-09-03. Target: **Corollary L140.2** in [route-a.md](../findings/route-a.md), read against [conventions.md](../findings/conventions.md), [Lemma L140](../findings/route-a.md), [Corollary L140.1](../findings/route-a.md), [Lemma L136](../findings/route-a.md), [Lemma L134](../findings/route-a.md), [Lemma L17](../findings/route-a.md) and [Lemma L141](../findings/second-order.md). Log: [r437-L140-2.log](../agent_logs/r437-L140-2.log).*

**Standing rule inherited and observed.** This programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). **Nothing below was computed, no run, no sweep, not even a screen.** Every constant is re-derived by hand from the definitions, and the record's own anchors ($a=\tfrac1{3\sqrt6}$, $\lVert\star\rVert^2=6$, $\delta^2(u)=\tfrac19$, $\lvert\kappa_{12}\rvert=0.10159$) are reproduced rather than quoted, since the author asked for the constants to be re-derived assuming nothing.

## Verdict

| claim | verdict |
| --- | --- |
| **(1)** the split $\tfrac{d^2}{dt^2}\delta^2=\tfrac12\sum(\phi'_\Omega)^2+\tfrac12\sum\phi_\Omega\phi''_\Omega$ | **CONFIRMED as algebra**, on two hypotheses the corollary never states, ambient $\mathcal W_n$, and twice-differentiability of $\phi_\Omega$. See [§1](#1-the-split-is-right-and-carries-two-unstated-hypotheses). |
| **(1)** the split as an instrument for semiconcavity | **INADEQUATE.** It is a pointwise identity, and semiconcavity is decided by a *distributional* atom on the zero-eigenvalue locus that no pointwise identity can see. That locus passes through $u$ itself. See [§5](#5-the-split-is-blind-to-the-part-that-decides-semiconcavity). |
| **(2)** $\sum_\Omega(\phi'_\Omega)^2=\lVert D(\mathrm{Alt}\lvert W\rvert)[H]\rVert^2=4\lVert D(\mathrm{Alt}W_-)[H]\rVert^2\le1$ | **CONFIRMED**, every link, including the factor $4$ and the $\le1$. $H$ is Weyl here and that is all the factor $4$ needs. See [§2](#2-claim-2s-chain-is-correct-link-by-link). |
| **(2)** as a use of the $\tfrac12$-contraction | **VACUOUS.** The same $\le1$ falls out of $\lvert\,\lvert x\rvert-\lvert y\rvert\,\rvert\le\lvert x-y\rvert$ alone. The deepest input cited buys exactly nothing. See [§3](#3-claim-2-is-vacuous-relative-to-the-input-it-cites). |
| **(3)** $C=\theta^*/\lvert\kappa_n\rvert$, binding at $0.718$ | **CONFIRMED, re-derived from scratch.** $\theta^*/\lvert\kappa_n\rvert\downarrow1.224745/1.705218=0.718234$. And the comparison against $\tfrac{d^2}{dt^2}\delta^2$ is the right one. See [§4](#4-the-budget-re-derived-the-constant-is-right-the-inequality-is-not). |
| **(3)** the budget as a **non-strict** bound $C\le\theta^*/\lvert\kappa_n\rvert$ | **REFUTED.** At equality the $d^2$ term cancels exactly and the $P$-side's *exact* cubic $\sin^3t\,P(H)$ is left unpaid, so I3 fails. The budget must be strict, with slack $O(r)$ on a ball of radius $r$. See [§4](#4-the-budget-re-derived-the-constant-is-right-the-inequality-is-not). |
| **(3)** "It fits, with room" | **OVER-STATED.** $0.5$ of $0.718$ is $70\%$ of the budget spent; what the residue $0.218$ must then cover is [§7](#7-the-split-tightens-the-obligation-it-was-meant-to-halve). |
| **(4)** $\mathrm{Alt}(\lvert u\rvert)=2a\star$, $\phi_\Omega(u)=0$ for $\Omega\perp\star$, $\sum\phi_\Omega(u)^2=\tfrac49$ | **CONFIRMED** in the orthonormal reading $\Omega_\star=\star/\sqrt6$, where $\phi_{\Omega_\star}(u)=\tfrac23$. |
| **(4) against (5)** the displayed $\phi_\star(W)=\mathop{\mathrm{tr}}(\lvert W\rvert\star)$ | **INCONSISTENT with (4) by a factor $\sqrt6$.** The display is the *un-normalised* $\star$: $\mathop{\mathrm{tr}}(\lvert u\rvert\star)=4/\sqrt6=1.6330$ against the $\tfrac23$ that $\sum\phi^2=\tfrac49$ requires. The retained term is inflated $6\times$ if the two are read together. See [§6](#6-the-sqrt6-slip-between-claim-4-and-claim-5). |
| **(5)** "by continuity the second half is dominated near $u$ by its $\star$-term" | **REFUTED.** Explicit family at distance $d$ from $u$, arbitrarily small, on which $\phi''_\star=0$ *exactly* and the off-$\star$ terms carry $100\%$ of the second half. See [§7](#7-the-split-tightens-the-obligation-it-was-meant-to-halve). |
| **(5)** "what is needed is an upper bound on $\phi''_\star$" | **REFUTED even in the narrowest reading that could save (5).** What is needed is $\lVert\phi''_\perp\rVert=o(1/t)$, a statement of exactly the same class as the one it reduces to. See [§8](#8-the-narrow-reading-and-why-it-does-not-rescue-the-argument). |
| **(5)** $\phi_\star>0$ near $u$, and $\star$'s sign convention | **CONFIRMED.** One continuous function with $\phi_\star(u)>0$, the one place "by continuity" is a legitimate argument. No sign collision: $W_-=\tfrac12(\lvert W\rvert-W)$, $E$ self-dual, $\mathop{\mathrm{tr}}(\lvert u\rvert\Pi_{SD})=4/\sqrt6>0$, $\mathrm{Alt}(u_-)=+a\star$ with $a>0$, all consistent. |

**Is this vacuously true anywhere?** Yes, in one place and it matters: claim 2 ([§3](#3-claim-2-is-vacuous-relative-to-the-input-it-cites)). And claim 5's "domination" is *degenerately* true on the padded flat, where both sides of the comparison are zero, which is why the family that discriminates had to be built off it.

---

## 1. The split is right, and carries two unstated hypotheses

$\tfrac{d^2}{dt^2}\big(\tfrac14\sum_\Omega\phi_\Omega^2\big)=\tfrac14\sum_\Omega\big(2(\phi'_\Omega)^2+2\phi_\Omega\phi''_\Omega\big)=\tfrac12\sum(\phi'_\Omega)^2+\tfrac12\sum\phi_\Omega\phi''_\Omega$. Correct, and path-independent: $\phi',\phi''$ may be taken along any curve.

**Hypothesis one, the ambient space.** The identity $\delta^2=\tfrac14\sum_\Omega\phi_\Omega^2$ needs $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$, which needs $\mathrm{Alt}(W)=0$, i.e. $W$ Bianchi, **at every point of the path** and not only at $u$. The corollary never says where it lives. It is nonetheless safe on this route: $\mathcal W_n$ is a linear subspace, $u\in\mathcal W_n$ and every direction considered is a Weyl tensor, so $u+tH\subset\mathcal W_n$; and [Corollary L140.1](../findings/route-a.md)(i) and (iv) are both explicitly on $\mathcal W_n$. **The identity does fail off $\mathcal W_n$**, for a general symmetric $W$ the right-hand side is $\tfrac14\lVert\mathrm{Alt}(W)+2\mathrm{Alt}(W_-)\rVert^2$, not $\delta^2$, so nothing in this route may be evaluated at a non-Weyl base point. Recording the ambient space explicitly costs one clause and closes the question.

The rest of the identity checks against the record's own anchors. $\phi_\Omega=\langle\lvert W\rvert,\Omega\rangle=\langle\mathrm{Alt}\lvert W\rvert,\Omega\rangle$ needs $\mathrm{Alt}$ self-adjoint and idempotent and $\Omega\in\Lambda^4$, both given in [conventions.md](../findings/conventions.md); and $\mathrm{Alt}\lvert W\rvert\in\Lambda^4$, so Parseval over an orthonormal basis of $\Lambda^4$ is exact. Independently: $u_-=\tfrac1{\sqrt6}(0,1,1)$ on $E$, so $\langle u_-,\star\rangle=\mathop{\mathrm{tr}}(u_-\Pi_{SD})=\tfrac2{\sqrt6}$ and $a=\tfrac2{6\sqrt6}=\tfrac1{3\sqrt6}$, $\delta^2(u)=6a^2=\tfrac19$. Both of the record's constants reproduce.

**Hypothesis two, twice-differentiability.** $\phi''_\Omega$ exists only where $\lvert W\rvert$ is twice differentiable, i.e. where $W$ has no zero eigenvalue. $u$ has a kernel of dimension $N-3$. So the display is *false at $u$* and on a hypersurface through every neighbourhood of it. This is not pedantry: it is where the whole question lives, and [§5](#5-the-split-is-blind-to-the-part-that-decides-semiconcavity) is the consequence.

## 2. Claim 2's chain is correct, link by link

$\sum_\Omega(\phi'_\Omega)^2=\sum_\Omega\langle\tfrac{d}{dt}\mathrm{Alt}\lvert W\rvert,\Omega\rangle^2=\lVert D(\mathrm{Alt}\lvert W\rvert)[H]\rVert^2$, Parseval again, legitimate because $\mathrm{Alt}$ is a *fixed* linear projection so the derivative stays in $\Lambda^4$.

The factor $4$: $\mathrm{Alt}\lvert W\rvert=\mathrm{Alt}(W)+2\mathrm{Alt}(W_-)$ holds for **every** symmetric $W$, Bianchi or not, since $\lvert W\rvert=W+2W_-$ identically. Differentiating in direction $H$ gives $D(\mathrm{Alt}\lvert W\rvert)[H]=\mathrm{Alt}(H)+2D(\mathrm{Alt}W_-)[H]$, and $\mathrm{Alt}(H)=0$ because $H$ is Weyl. **So the factor $4$ needs $H$ Bianchi and does not need $W$ Bianchi**, the opposite of what one might fear, and the brief's worry "is $H$ Weyl here" answers itself: the directions are directions in $\mathcal W_n$, which is the space the semiconcavity statement is about.

The $\le1$ then follows from $\lVert D(\mathrm{Alt}W_-)[H]\rVert\le\tfrac12\lVert H\rVert$ at $\lVert H\rVert=1$. **The corollary never says $\lVert H\rVert=1$**; without it the bound is $\lVert H\rVert^2$.

## 3. Claim 2 is vacuous relative to the input it cites

The bound is presented as a consequence of the $\tfrac12$-contraction, [Lemma L140](../findings/route-a.md) at $u$, [Lemma L141](../findings/second-order.md)(a) elsewhere, the latter flagged in [Corollary L140.1](../findings/route-a.md) as *"repaired in place without re-review"*. **It needs neither.**

In the eigenbasis of $W$ the Daleckii–Krein derivative of $x\mapsto\lvert x\rvert$ is $D\lvert W\rvert[H]_{ij}=m_{ij}H_{ij}$ with $m_{ij}=\frac{\lvert\lambda_i\rvert-\lvert\lambda_j\rvert}{\lambda_i-\lambda_j}$, and $\lvert m_{ij}\rvert\le1$ because $\lvert\cdot\rvert$ is $1$-Lipschitz. Hence $\lVert D\lvert W\rvert[H]\rVert_F\le\lVert H\rVert_F=1$, and $\mathrm{Alt}$ is a projection, so $\sum_\Omega(\phi'_\Omega)^2\le1$ **directly**.

The two routes give the identical number: $4\times\tfrac14=1$ and $1^2=1$. So the $\tfrac12$-contraction, the deepest and most contested input the corollary cites, contributes no sharpening whatever, and the entire "first half is already discharged" rests on nothing beyond the triangle inequality for the absolute value. *One useful consequence: claim 2 is immune to whatever is wrong with L141(a)'s repaired generality clause, it never needed it.*

## 4. The budget, re-derived: the constant is right, the inequality is not

**The constant.** $\kappa_n=9(\theta^*-\theta_0(n))$ with $\theta^*=\sqrt{3/2}=1.2247449$ and $\theta_0(n)^2=2(n-1)(n-2)/n^2\uparrow2$. So $\lvert\kappa_n\rvert\uparrow9(\sqrt2-\sqrt{3/2})=1.7052182$, and $\theta^*/\lvert\kappa_n\rvert\downarrow1.2247449/1.7052182=0.7182348$. **$0.718$ is correct and the binding case is $n\to\infty$.** Cross-check at $n=12$: $\theta_0(12)=\sqrt{220}/12=1.2360331$, $\kappa_{12}=9(-0.0112882)=-0.1015938$, $\theta^*/(2\lvert\kappa_{12}\rvert)=6.028$, reproducing [Lemma L134](../findings/route-a.md)(b)'s $6.03$.

**The derivation, done independently rather than quoted.** Let $W$ be unit with nearest orbit point $u$, $d=\lVert W-u\rVert$, so $\cos t=\langle W,u\rangle=1-\tfrac{d^2}2$ and $W-u\perp T_u\mathcal O$. $P$ is a *cubic*, so the expansion along the great circle is exact:
$$P(W)=\theta^*\cos^3t+3\cos t\sin^2t\,\langle F_uH,H\rangle+\sin^3t\,P(H).$$
[Lemma L134](../findings/route-a.md)(a) gives $\langle F_uH,H\rangle\le\tfrac13\theta^*$ off the orbit, and $\cos^3t+\cos t\sin^2t=\cos t$ collapses the first two terms exactly:
$$P(W)\;\le\;\theta^*\cos t+\sin^3t\,P(H)\;=\;\theta^*-\tfrac{\theta^*}2d^2+\sin^3t\,P(H).$$
Semiconcavity with constant $C$ plus $d^+\delta^2(u;\cdot)\le0$ ([Lemma L17](../findings/route-a.md)) gives $\delta^2(W)\le\tfrac19+\tfrac C2d^2$. With $\Phi=P+\lvert\kappa_n\rvert\delta^2$ and $\Phi(u)=\theta^*+\tfrac{\lvert\kappa_n\rvert}9=\theta_0$,
$$\Phi(W)\;\le\;\theta_0-\tfrac12\big(\theta^*-\lvert\kappa_n\rvert C\big)d^2+\sin^3t\,P(H).$$
So $C=\theta^*/\lvert\kappa_n\rvert$ is exactly the break-even. **The constant is confirmed.**

**The inequality must be strict, and the corollary (with L140.1(iii)) states it non-strictly.** At $C=\theta^*/\lvert\kappa_n\rvert$ the $d^2$ term vanishes *identically* and what remains is $+\sin^3t\,P(H)$, which is positive in every direction with $P(H)>0$. **I3 then fails.** The correct budget is $C\le\theta^*/\lvert\kappa_n\rvert-c\,r$ on a ball of radius $r$, the slack paying the exact cubic remainder. This is small but it is a constant, and the author asked for the constants.

**Is the comparison the right one?** Yes. A semiconcavity constant caps $\tfrac{d^2}{dt^2}$ of $\delta^2$ along unit-speed **straight lines** in $\mathcal W_n$, and that is precisely the quantity claim 1 splits. No conversion factor is missing. *The apparent tension with [Lemma L134](../findings/route-a.md)(b)'s per-direction threshold $\Delta_2\le\tfrac19+0.3591=0.4702$, i.e. line second derivative $\le0.9404$, is not a contradiction: the neighbourhood constant is stronger because it cannot spend the exact value $\delta^2(u)=\tfrac19$, and $0.9404-0.718=\tfrac29$ is exactly the two-homogeneity term $\Delta_2-c_2=\tfrac19$ doubled.*

## 5. The split is blind to the part that decides semiconcavity

$\delta^2$ is not $C^2$, and semiconcavity with constant $C$ means $(\delta^2)''\le C$ **in the distributional sense** along lines. A positive atom on the zero-eigenvalue locus destroys semiconcavity for *every* finite $C$, and a pointwise identity valid almost everywhere (which is all claim 1 is), cannot see an atom.

The atom is explicit. Across a simple zero-crossing of an eigenvalue $\lambda(t)$ with eigenvector $v$, $\phi_\Omega$ picks up $\lvert\lambda(t)\rvert\,\Omega(v,v)$, so $\mathrm{jump}(\phi'_\Omega)=2\lvert\lambda'\rvert\,\Omega(v,v)$ and the singular part of $\tfrac{d^2}{dt^2}\delta^2$ is
$$\tfrac12\sum_\Omega\phi_\Omega\,\mathrm{jump}(\phi'_\Omega)\;=\;\lvert\lambda'\rvert\,\big(\mathrm{Alt}\lvert W\rvert\big)(v,v)\;=\;2\lvert\lambda'\rvert\,\big(\mathrm{Alt}(W_-)\big)(v,v).$$
**So semiconcavity near $u$ requires $\big(\mathrm{Alt}(W_-)\big)(v,v)\le0$ for every $v\in\ker W$ at every $W$ near $u$.** At $u$ itself this holds and *is* [Lemma L17](../findings/route-a.md)'s mechanism: $\mathrm{Alt}(u_-)=a\star$ and $v$ lies in the anti-self-dual $3$-space, so $\langle a\star v,v\rangle=-a<0$, the record's own $\mathrm{Alt}(W_-)\rvert_{\ker W}=-a\Pi_{ASD}$. Near $u$ there is no L17, and by [§7](#7-the-split-tightens-the-obligation-it-was-meant-to-halve)'s family the crossing can be pushed into the complementary block where the sign is that of $\big(\mathrm{Alt}(V_-)\big)(v,v)$ for an arbitrary Weyl $V$, constrained by nothing in the record.

*Stated as what it is: the sign test above is the decisive question for the whole semiconcavity route, and I do not claim to have found a $W$ where it is positive, that would need a construction, and this reviewer is on the analysis-only footing.* What is established is that **L140.2's split cannot address it**, and that [Corollary L140.1](../findings/route-a.md)(v)'s own sentence, *"Any real obstruction therefore lives at base points NEAR $u$, where L17 says nothing"*, names exactly this and the corollary then proceeds past it.

## 6. The $\sqrt6$ slip between claim 4 and claim 5

$\{\Omega\}$ is stipulated **orthonormal**, so the $\star$-direction's basis element is $\Omega_\star=\star/\sqrt6$ and
$$\phi_{\Omega_\star}(u)=\langle2a\star,\star/\sqrt6\rangle=2a\sqrt6=\tfrac23,\qquad\textstyle\sum_\Omega\phi_\Omega(u)^2=\tfrac49=4\delta^2(u).\ \checkmark$$
But claim 5 displays $\phi_\star(W)=\mathop{\mathrm{tr}}(\lvert W\rvert\star)=\mathop{\mathrm{tr}}(\Pi_{SD}\lvert W\rvert)-\mathop{\mathrm{tr}}(\Pi_{ASD}\lvert W\rvert)$, the **un-normalised** $\star$, whose value at $u$ is $2a\lVert\star\rVert^2=4/\sqrt6=1.6330$, larger by $\sqrt6=2.449$.

The two cannot feed one budget. The retained term $\tfrac12\phi_\star\phi''_\star$ read with the displayed $\star$ is $6\times$ the term that belongs in the sum whose value at $u$ is $\tfrac49$. Nothing in the corollary's conclusion changes sign, but every number does, and this is exactly the class of slip the author flagged. **Fix: write $\phi_\star:=\tfrac1{\sqrt6}\mathop{\mathrm{tr}}(\lvert W\rvert\star)$, or drop the orthonormality of $\{\Omega\}$ and carry $\lVert\Omega\rVert^2$ through the Parseval step.**

## 7. The split tightens the obligation it was meant to halve

**The family.** Let $n\ge8$, $\mathbb R^n=\mathbb R^4\oplus\mathbb R^{n-4}$ with $u$ the padded competitor on $\mathbb R^4$. Let $V$ be a unit Weyl tensor of the complementary $\mathbb R^{n-4}$, zero-padded and invertible on $\Lambda^2\mathbb R^{n-4}$, the record's own class, used in [Lemma L134](../findings/route-a.md)(c) and throughout [Lemma L136](../findings/route-a.md)'s padded-flat discussion. Put
$$W_0=\cos s\,u+\sin s\,V\in\mathcal W_n,\qquad d=\lVert W_0-u\rVert=2\sin\tfrac s2,$$
and let $H$ be a *different* unit Weyl tensor of $\mathbb R^{n-4}$, padded. $V$ is orthogonal to $T_u\mathcal O$ (the pure-$\mathbb R^{n-4}$ component of $A\!\cdot\!u$ vanishes, since $u_{pjkl}$ needs all four indices inside $\mathbb R^4$), so $u$ **is** the nearest orbit point and $W_0$ sits at distance $d$ from $\mathcal O$, arbitrarily small.

**What happens on it.** $W(t)=W_0+tH$ is block-diagonal on $\Lambda^2\mathbb R^4\oplus(\mathbb R^4\wedge\mathbb R^{n-4})\oplus\Lambda^2\mathbb R^{n-4}$, so $\lvert W(t)\rvert=\lvert\cos s\,u\rvert\oplus0\oplus\lvert\sin s\,V+tH\rvert$. Then:

- $\star$ is supported on $\Lambda^2\mathbb R^4$, so $\phi_\star(W(t))=\tfrac23\cos s$ is **constant in $t$**: $\phi'_\star=\phi''_\star=0$ exactly, and the retained term $\tfrac12\phi_\star\phi''_\star$ is **identically zero**.
- A $4$-form with two indices inside $\mathbb R^4$ and two outside pairs with an off-diagonal block of $\lvert W(t)\rvert$, which is $0$. So the only surviving $\phi_\Omega$ besides $\phi_\star$ are those with $\Omega\in\Lambda^4\mathbb R^{n-4}$, every one of them orthogonal to $\star$.
- Hence **$100\%$ of the second half comes from $\Omega\perp\star$**, and it is generically nonzero, $\phi_\Omega(W)=\mathop{\mathrm{tr}}(\lvert W\rvert\Omega)$ being non-affine in $W$.

**"Dominated near $u$ by its $\star$-term" is therefore false**, at base points arbitrarily close to $u$, and an upper bound on $\phi''_\star$ is worth nothing there.

**The order-counting the brief asked for, and why it does not decay.** By two-homogeneity of $\delta^2$, with $\sigma=\sin s$,
$$\delta^2(\sigma V+tH)=\sigma^2\delta^2\big(V+\tfrac t\sigma H\big)\;\Longrightarrow\;\frac{d^2}{dt^2}\Big|_{t=0}=\frac{d^2}{d\tau^2}\Big|_{\tau=0}\delta^2(V+\tau H),$$
**independent of $\sigma$, hence of the distance $d$.** Termwise this is exactly the cancellation the brief predicted: $\phi_\Omega(W_0)=\sigma\langle\lvert V\rvert,\Omega\rangle=O(d)$, consistent with the general bound $\lVert\phi_\perp\rVert\le d$ that [Corollary L140.1](../findings/route-a.md)(i) supplies, while $\phi''_\Omega=\sigma^{-1}\times(\text{its value at }V)=\Theta(1/d)$. **The small factor and the large factor cancel exactly, and their product is $\Theta(1)$ at every distance.** This is the per-direction-to-neighbourhood error in its product form, and **yes, it has recurred a fourth time on this route.**

**The reduction inverts.** A neighbourhood of $u$ contains scaled copies of the entire unit sphere of $\mathcal W_{n-4}$, and the split is scale-invariant on them. So *"$\delta^2$ semiconcave near $u$ with constant $C$"*, the hypothesis [Corollary L140.1](../findings/route-a.md)(iii) states, in its standard sense of a neighbourhood and all directions, **entails $\delta^2$ semiconcave with the same $C$ at every unit Weyl tensor of $\mathbb R^{n-4}$, at every scale.** Near $u$ it is not one scalar; it is the same global question one dimension-block down. And with the first half spending $0.5$ of $0.718$, the residue left to cover that global question is $0.218$. **The split does not halve the obligation; it hands the harder half a budget shrunk by $70\%$.**

## 8. The narrow reading, and why it does not rescue the argument

Triple-checking cuts both ways, so: the implication in [Corollary L140.1](../findings/route-a.md)(iii) does **not** actually need semiconcavity on a full neighbourhood. Concavity of $\delta^2-\tfrac C2\lVert\cdot\rVert^2$ **along the single segment $[u,W]$** already gives $\delta^2(W)\le\tfrac19+\tfrac C2d^2$, because $d^+\delta^2(u;H)\le0$ and $\langle u,H\rangle=-\tfrac d2$ on the unit sphere. That narrow form is $\sup_H\sup_{0<t<r}\tfrac{d^2}{dt^2}\delta^2(u+tH)\le C$ with $r$ uniform, which is exactly what [Corollary L140.1](../findings/route-a.md)(vi) says the genuine statement needs, and it is *not* the per-ray $\limsup$ that [r436](REVIEW_r436.md) refuted.

**My family degenerates under that narrow reading**, and I say so rather than let it stand: along a segment *from $u$*, the complementary block of $u+tH$ is $tH_{KK}$, a ray from the origin, so $\lvert\cdot\rvert$ is positively homogeneous there and every $\phi_\Omega$ is affine in $t$. On the padded flat the second half is then $0=0$ and claim 5's "domination" is *degenerately* true. **Two things follow.**

- **The corollary's own words do not carry the narrow reading.** It says "near $u$", and it is written to serve a hypothesis stated as semiconcavity. In that reading it is refuted by [§7](#7-the-split-tightens-the-obligation-it-was-meant-to-halve).
- **Even in the narrow reading the stated argument is invalid.** Continuity gives $\lVert\phi_\perp(t)\rVert=O(t)$ and says *nothing* about $\phi''_\perp$. Cauchy–Schwarz gives $\big\lvert\sum_{\Omega\perp\star}\phi_\Omega\phi''_\Omega\big\rvert\le\lVert\phi_\perp\rVert\lVert\phi''_\perp\rVert\le t\,\lVert\phi''_\perp\rVert$, so what must be shown is $\lVert\phi''_\perp\rVert=o(1/t)$, a second-derivative bound for $\lvert\cdot\rvert$ at a base point with a large kernel, which is a statement **of exactly the same class as the bound on $\phi''_\star$ it is being traded for.** So the reduction from $\binom n4$ scalars to one scalar saves nothing; it renames the difficulty.

*What would make the narrow reading real is an explicit $\lVert\phi''_\perp(t)\rVert\le K$ along segments from $u$, with $K$ uniform in $H$. That is a derivable statement, the kernel block along such a segment is $t(D-tS)$ with $S=C^\top\Lambda^{-1}C$, so the whole complementary contribution is $O(t^2)$ with the Schur term supplying the only curvature, and it is the thing to write down. It is not what the corollary says, and "by continuity" is not a proof of it.*

## What survives

- The split, the chain, and the budget constant $0.718$ are all **correct**, and the last is now independently re-derived.
- The budget inequality must be **strict**.
- The first half's bound is **real but free**, it costs nothing more than $1$-Lipschitzness of $\lvert\cdot\rvert$, and nothing it cites was needed.
- Claim 5 is **wrong as written and unproved as intended**, and the corollary's closing sentence (that the constants should be re-derived before anything is built on the margin), was the right instinct: there is a $\sqrt6$ in claim 5's display and a strictness in claim 3's inequality.
