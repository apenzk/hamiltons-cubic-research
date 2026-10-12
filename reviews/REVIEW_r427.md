# Reviewer r427, [Lemma L138](../findings/route-a.md) and [Lemma L139](../findings/route-a.md)

**Verdict: REFUTED, both lemmas, on three independent defects, and the dimension range is wrong by a wide margin.** The load-bearing failure is upstream, in [Lemma L136](../findings/route-a.md#lemma-l136-the-competitor-cross-term-is-nonpositive-on-the-equality-cone-so-delta_2lelvert-g_1rvert2)(a): the self-dual branch of the cross term is computed with the wrong sign convention *and* with the eigenvector tilt omitted, so the term the record reports as a large negative quantity is in truth **exactly zero** on the stated domain. That propagates: [Lemma L137](../findings/route-a.md#lemma-l137-withdrawn-the-closed-form-cross-term-bound-in-hs-blocks)'s boxed inequality is **violated by an explicit unit Weyl tensor in $\{F=0\}\cap T_u\mathcal O^\perp$** that I constructed, L138(c)'s "exact cancellation" is a cancellation between two quantities that both vanish identically on the domain, and L139(a) is false, I exhibit a Weyl tensor on the cone with $\mathrm{Alt}(P_0HP_0)\ne0$, $98\%$ of whose mass sits **off** the distinguished $4$-set.

**The chain is nonetheless repairable, and I give the repair.** The corrected accounting is shorter than the record's, needs no analogue of L139 at all, and yields
$$\Delta_2\;\le\;\lVert g_1\rVert^2\;\le\;2\big(\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2\big)+\lVert(P_0HP_0)_-\rVert^2\;\le\;1\qquad\text{on }\{F=0\}\cap T_u\mathcal O^\perp,$$
whence **I3 for even $n$ with $12\le n\le18$**, not $31$, and not $30$ either.

*Analysis-only footing observed and inherited. Every finding below is derived by hand from the definitions; the screens reported are seconds of `numpy` on objects I built for the purpose, and they appear only as confirmation of claims I had already derived, never as evidence for a positive claim.*

## Note added on delivery, the record moved while this review was being written

**[findings/route-a.md](../findings/route-a.md) was rewritten mid-review.** When I began, L136–L139 stood as described in my brief. On delivery, L137, L138 and L139 are marked **WITHDRAWN**, L136 has been replaced by a corrected version, and a new [Lemma L140](../findings/route-a.md#lemma-l140-lvert-g_1rvert2letfrac14-for-every-unit-weyl-direction-and-i3-closes-for-every-nge12) claims $\lVert g_1\rVert^2\le\tfrac14$ for every unit Weyl direction. **I have left this review exactly as derived, against the versions I was briefed on**, because an independent attack that reaches the same root causes from a cold start is worth more than one edited to agree after the fact.

**Where I concur with the replacement**, reached independently, before reading it: the convention $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$ is forced (§1); $\operatorname{tr}(\Pi_EX_2)=+\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)$ with **no** $CC^\top$ term, the eigenvalue deepening cancelling the eigenvector tilt exactly (§3); $B_{12}=B_{13}=0$ on $T_u\mathcal O^\perp$ (§5); $\rho$ enters subtracted, so $c_1$ can only help (§4); $\Delta_2\le\lVert g_1\rVert^2$ on the cone (§4); and L139(a) is false, its proof confusing *disjoint from a plane of $\Lambda^2\mathbb R^4$* with *contained in $\mathbb R^4$* (§7).

**What this review adds beyond the replacement.** (i) A closed-form witness fixing the sign with no numerics at all, $H=\tfrac1{\sqrt2}(\hat\omega_1\hat\omega_2^{\mathsf T}+\hat\omega_2\hat\omega_1^{\mathsf T})$ gives $\delta^2(t)=\tfrac19+\tfrac29t^2B_{12}^2$ exactly, and it is a genuine Weyl tensor whose orbit-tangency independently forces the same number (§3). (ii) A one-line proof that $\operatorname{tr}(\Pi_AX_2)\ge0$ on the cone, from $\varphi\ge0$ and $\varphi(0)=0$ alone, needing neither Hansen–Pedersen nor the existence of $\mathcal E_D$ (§4), an independent route to the nonpositivity the new L136 boxes. (iii) The defect in L138(b)'s *displayed* inequality, which the withdrawal notice does not mention because it calls L138's structural halves sound: $\mathrm{Alt}$ is applied to one summand and not the other, and the two share $4$-sets. The repair is $\lVert\mathrm{Alt}(Z)\rVert\le\lVert Z'\rVert$ (§6). (iv) An explicit unit Weyl tensor on the cone with $\lVert\mathrm{Alt}(P_0HP_0)\rVert=0.1445$ and zero coefficient on the distinguished $4$-set (§7), agreeing with [r428](REVIEW_r428.md). (v) The corrected dimension range that the sum-of-squares chain actually supports, $12\le n\le18$ (§9), now superseded by L140 if L140 holds, but it is the number that should have replaced $31$.

**One flag on the replacement, outside my brief.** The new L136's second identity, $\operatorname{tr}(\Pi_AX_2)=\mathcal K+\sqrt6(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2)$, is strictly stronger than the $\ge0$ I proved, and my argument does not reach it. It needs its own Gate 2.

## Verdict table

| # | claim | verdict |
| --- | --- | --- |
| 1 | L138(a), divided differences $\{0,\tfrac13,1\}$; $0$ on $(\hat\omega_1,\hat\omega_1)$ and $(\hat\omega_1,K)$; $\tfrac13$ on $(\hat\omega_1,\hat\omega_{2,3})$; $(K,K)$ carried by the kink $D_-$ | **CONFIRMED** in magnitude, with a convention note |
| 2 | L138(a), "$c_1$ contributes nothing to $Z$ at all" | **CONFIRMED** |
| 3 | L138(b), $\Lambda^4\mathbb R^4$ one-dimensional, $\mathrm{Alt}$ its orthogonal projection, $\star$ block-diagonal across $E\oplus A$ | **CONFIRMED** |
| 4 | L138(b) ($B_{11}=0$ and $B_{33}=-B_{22}$ on $\{F=0\}$, from L17(d) | **CONFIRMED**) and it needs $B_{\mathrm{ASD}}=0$, which the cone does supply |
| 5 | L138(b), $\langle Z,\star\rangle=0$ on the cone | **CONFIRMED**, but it is $\langle g_0,g_1\rangle=0$, i.e. $F=0$ restated, no new content |
| 6 | L138(b), the displayed $\lVert g_1\rVert^2\le2(\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2)+\lVert\mathrm{Alt}(D_-)\rVert^2$ | **REFUTED as an argument**, $\mathrm{Alt}$ applied to one summand and not the other, and the two summands share $4$-sets; a valid variant is given below |
| 7 | L136(a)/L137, the self-dual branch is $-\sqrt6[(CC^\top)_{22}+(CC^\top)_{33}]-\tfrac{\sqrt6}3[B_{12}^2+B_{13}^2]\le0$ | **REFUTED**, the truth is $+\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)$, and that is $0$ on $T_u\mathcal O^\perp$ |
| 8 | L137 (the boxed inequality on $\{F=0\}\cap T_u\mathcal O^\perp$ | **REFUTED**), explicit witness, $\Delta_2=+0.012776$ against a right-hand side of $-0.043822$ |
| 9 | L138(c), the $B_{12},B_{13}$ terms cancel exactly against L137's $-\tfrac29$ | **REFUTED, and vacuous besides**, $B_{12}=B_{13}=0$ identically on $T_u\mathcal O^\perp$ |
| 10 | L138(c), the displayed $\Delta_2\le\tfrac43(\lVert c_2\rVert^2+\lVert c_3\rVert^2)+\lVert\mathrm{Alt}(D_-)\rVert^2+\tfrac13\lVert c_1\rVert^2$ | **REFUTED as derived**, every input to it is defective |
| 11 | L138(c), $\lVert c_1\rVert^2\le\tfrac12$, $\lVert c_2\rVert^2+\lVert c_3\rVert^2\le\tfrac12$ | **CONFIRMED** |
| 12 | L139(a), $\mathrm{Alt}(N)=0$ on $\{F=0\}$, supported on the distinguished $4$-set with coefficient $-\tfrac16\operatorname{tr}(B)$ | **REFUTED**, support claim false; explicit unit Weyl witness on the cone with $\lVert\mathrm{Alt}(N)\rVert=0.1445$ and zero coefficient on $\{1,2,3,4\}$ |
| 13 | L139(a), the coefficient $-\tfrac16\operatorname{tr}(B)$ on the distinguished $4$-set, and $\operatorname{tr}(B)=0$ there | **CONFIRMED** (that one coefficient is right, and does vanish) |
| 14 | L139(b), $\lVert\mathrm{Alt}(M_-)\rVert^2\le\tfrac14\lVert M\rVert^2$ given $\mathrm{Alt}(M)=0$, using Bianchi only through $\mathrm{Alt}(M)=0$ | **CONFIRMED**, the two-line proof is correct and uses nothing else |
| 15 | L139(b) (that hypothesis holds for $N=P_0HP_0$ | **REFUTED**), it is exactly claim 12 |
| 16 | L139(c), the ratios $\tfrac23,\tfrac14,\tfrac16$ and the maximum $\tfrac23$, given L138(c) | **CONFIRMED as arithmetic** on inputs that are themselves refuted |
| 17 | L139(c), $\tfrac23\le\tfrac19+\theta^*/(2\lvert\kappa_n\rvert)\iff\lvert\kappa_n\rvert\le1.1022\iff\theta_0(n)\le1.34722\iff n\lesssim31.7$ | **CONFIRMED as arithmetic**; the even endpoint is $30$, not $31$ |
| 18 | L139(c), "I3 holds for $12\le n\le31$" | **REFUTED**; corrected to $12\le n\le18$ |

## 1. The sign convention, pinned before anything else

The record uses two incompatible conventions for $W_-$ and the whole cross term turns on which one is meant.

- [Lemma L135](../findings/route-a.md#lemma-l135-the-competitors-second-order-defect-coefficient-is-a-straight-line-quantity-minus-tfrac19-and-the-target-is-the-records-own-universal-ceiling)(c) writes $W_-=\tfrac12(W-\lvert W\rvert)$, i.e. $f(x)=\min(x,0)$, which is **negative** semidefinite.
- Everything load-bearing requires the other one. $g_0=\mathrm{Alt}(u_-)=+a\star$ with $a=+\tfrac1{3\sqrt6}$ needs $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, since $\mathrm{Alt}(\hat\omega_i\hat\omega_i^{\mathsf T})=\tfrac16\star$ and $u$'s negative eigenvalue is $-\tfrac1{\sqrt6}$. So does [Lemma L17](../findings/route-a.md#lemma-l17-first-order-protection-at-the-rival-maximizer)'s chain: with $H_{22}+H_{33}=\tfrac23\operatorname{tr}(B_{\mathrm{ASD}})$ and $B=B_+-B_-$ in the PSD convention, $F\ge\tfrac23\operatorname{tr}(B_+)-\tfrac23\operatorname{tr}(B_-)+\operatorname{tr}(B_-)=\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)$ exactly as recorded. Under $\min(x,0)$ the same algebra returns $\tfrac23\operatorname{tr}B_++\tfrac53\operatorname{tr}B_-$, which is not $\ge0$.

**So the record's convention is $W_-\succeq0$, and L135(c)'s displayed formula is a slip.** Fix it before reading anything downstream. The divided differences of $f(x)=\max(-x,0)$ are then $\{0,-\tfrac13,-1\}$ where the record writes $\{0,\tfrac13,1\}$; since they enter $\lVert g_1\rVert^2$ only through squares and enter $Z$ consistently with $D_-$, **L138(a) is unaffected and correct**, but L136(a) is computed in the *other* convention, which is half of what is wrong with it.

## 2. L138(a), CONFIRMED

With $u$'s spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$ and $0$ on $K$, and $f(x)=\max(-x,0)$:

| pair | $f^{[1]}$ | record |
| --- | --- | --- |
| $(\hat\omega_1,\hat\omega_1)$ | $0$ | $0$ ✓ |
| $(\hat\omega_1,K)$ | $\dfrac{f(2/\sqrt6)-f(0)}{2/\sqrt6}=0$ | $0$ ✓ |
| $(\hat\omega_1,\hat\omega_{2,3})$ | $\dfrac{0-1/\sqrt6}{3/\sqrt6}=-\tfrac13$ | $\tfrac13$ ✓ in magnitude |
| $(\hat\omega_{2,3},\hat\omega_{2,3})$, $(\hat\omega_{2,3},K)$ | $-1$ | $1$ ✓ in magnitude |
| $(K,K)$ | undefined, $f$ has its kink at $0$ | carried by $D_-$ ✓ |

The $(K,K)$ block is genuinely the kink and not a multiplier: the whole of $K$ sits at the eigenvalue $0$ where $f$ is not differentiable, and degenerate first-order perturbation theory on that group returns the positively-homogeneous $(P_0HP_0)_-$, exactly as [Lemma L17](../findings/route-a.md#lemma-l17-first-order-protection-at-the-rival-maximizer) has it at first order. **And the multiplier on $(\hat\omega_1,K)$ is $0$, so $c_1$ does not enter $Z$**, the one claim of (a) that the rest of the chain uses. Confirmed.

## 3. L136(a) is wrong twice over, and it is the defect that sinks the chain

The record's identity is $\operatorname{tr}(\Pi_EX_2)=-\sqrt6[(CC^\top)_{22}+(CC^\top)_{33}]-\tfrac{\sqrt6}3[B_{12}^2+B_{13}^2]\le0$. **The truth is**
$$\boxed{\ \operatorname{tr}(\Pi_EX_2)\;=\;+\tfrac{\sqrt6}3\big(B_{12}^2+B_{13}^2\big)\;\ge\;0\ }$$
with **no $C$-term at all**. Two independent errors produce the discrepancy.

**Error 1, the sign.** $\Pi_E$ and $\Pi_A$ come from $\star=\Pi_E-\Pi_A$, and $X_2$ is the $t^2$-coefficient of $(u+tH)_-$ in the same convention as $g_0=+a\star$, i.e. the PSD one. The record computes the second-order shift of the two *eigenvalues* continuing from $-\tfrac1{\sqrt6}$, which is the $\min(x,0)$ quantity, and inserts it unchanged. Deepening a negative eigenvalue *increases* $\operatorname{tr}(\Pi_EW_-)$ in the PSD convention.

**A witness that settles the sign in closed form, with no numerics.** Take $H=\tfrac1{\sqrt2}(\hat\omega_1\hat\omega_2^{\mathsf T}+\hat\omega_2\hat\omega_1^{\mathsf T})$, so $\lVert H\rVert=1$, $B_{12}=\tfrac1{\sqrt2}$ and every other block is zero. Then $u+tH$ is supported on $E$, the negative eigenvalue is $\lambda_-(t)=-\tfrac1{\sqrt6}-\tfrac{\sqrt6}3t^2B_{12}^2$ exactly to second order, and its eigenvector rotates inside $E$. Since $\mathrm{Alt}(vv^{\mathsf T})=\tfrac16\star$ for **every** unit self-dual $v$, the cross term $\mathrm{Alt}(\hat\omega_1\hat\omega_2^{\mathsf T}+\hat\omega_2\hat\omega_1^{\mathsf T})$ vanishes because $\omega_1\wedge\omega_2=0$, the rotation is invisible and
$$\mathrm{Alt}(W_-(t))=\Big(\lvert\lambda_-(t)\rvert+\tfrac1{\sqrt6}\Big)\tfrac{\star}6,\qquad \delta^2(t)=\tfrac16\Big(\tfrac2{\sqrt6}+\tfrac{\sqrt6}3t^2B_{12}^2\Big)^2=\tfrac19+\tfrac29t^2B_{12}^2 .$$
So $\Delta_2=+\tfrac29B_{12}^2$, while $g_1=0$; the record's L137 predicts $\Delta_2\le-\tfrac29B_{12}^2$. **The sign is reversed.** *(This $H$ is a genuine unit Weyl tensor with $F=0$; it is excluded from L137's domain only because it is an orbit tangent (see §5) and on an orbit tangent $c_2=0$ forces $\Delta_2=\tfrac19$, which is what the great-circle reading of $\Delta_2=\tfrac29B_{12}^2+\lVert g_1\rVert^2$ at $B_{12}^2=\tfrac12$ returns. Two independent routes to the same number.)*

**Error 2, the eigenvector tilt is dropped, and it kills the $C$-term entirely.** $\operatorname{tr}(\Pi_EX_2)$ is a trace against the **fixed** projection $\Pi_E$, not the trace of the perturbed eigenvalue group. A $C$-block coupling deepens the eigenvalue at $-\tfrac1{\sqrt6}$ by $-\sqrt6t^2\lVert c_i\rVert^2$ *and* tilts its eigenvector out of $E$ by the angle $\theta=\sqrt6\,t\lVert c_i\rVert$. The two cancel to the last digit:
$$\Big(\tfrac1{\sqrt6}+\sqrt6t^2\lVert c_i\rVert^2\Big)\big(1-6t^2\lVert c_i\rVert^2\big)\;=\;\tfrac1{\sqrt6}+O(t^4).$$
The $E$-branch therefore sees nothing of $c_2,c_3$. (For $c_1$ there is nothing to see in the first place: $\hat\omega_1$'s eigenvalue is positive.) The Schur complement $-t^2C^\top\Lambda^{-1}C$ that the $C$-block pushes into $K$ is where the $c$'s do reappear, and that is the anti-self-dual branch, treated in §4.

**Screen.** Random symmetric unit $H$ at $n=8$, quadratic fit of $\operatorname{tr}(\Pi_E(u+tH)_-)$ over $t\in\{4,2,1,0.5\}\times10^{-3}$, four trials: measured $\operatorname{tr}(\Pi_EX_2)=+0.00846,+0.00075,+0.00632,+0.00031$ against $+\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)=+0.00824,+0.00051,+0.00606,+0.00019$ (residual at fit-truncation level) and against the record's values $-0.16539,-0.16416,-0.18113,-0.13167$. Reported as a screen of a claim already derived above.

## 4. The anti-self-dual branch is favourable, and simpler than L137 makes it

$\Pi_AW_-(t)=t\,\Pi_A(D_s)_-$ with $D_s=D-tC^\top\Lambda^{-1}C$, so with $\varphi(t):=\operatorname{tr}\big(\Pi_A(D_s(t))_-\big)$ the $t^2$-coefficient of $\operatorname{tr}(\Pi_AW_-)$ is $\varphi'(0^+)$. Now $\varphi\ge0$ everywhere, being the trace of a product of two positive semidefinite operators, and $\varphi(0)=\operatorname{tr}(\Pi_AD_-)=0$ on $\{F=0\}$, that is exactly the cone's zero-ASD-trace condition. **A nonnegative function vanishing at $0$ has nonnegative right derivative**, so
$$\operatorname{tr}(\Pi_AX_2)\;\ge\;0,\qquad\text{hence}\qquad -2a\operatorname{tr}(\Pi_AX_2)\;\le\;0 .$$
That is one line, it needs no Hansen–Pedersen, no Schur multiplier $\mathcal E_D$ and no nonsingularity of $D$ on $K$, retiring the "live obstacle" L135 and L136 both name. It is also strictly sharper than L137's route, which bounds the same quantity by $-\rho\ge-\tfrac{\sqrt6}2\lVert c_1\rVert^2$ and pays $+\tfrac13\lVert c_1\rVert^2$ for it. **L137's $+\tfrac13\lVert c_1\rVert^2$ term is real but unnecessary; its $-\tfrac23(\lVert c_2\rVert^2+\lVert c_3\rVert^2)$ and $-\tfrac29(B_{12}^2+B_{13}^2)$ terms are spurious.** Combining with §3, on $\{F=0\}\cap T_u\mathcal O^\perp$
$$\Delta_2\;=\;\lVert g_1\rVert^2+2a\big[\operatorname{tr}(\Pi_EX_2)-\operatorname{tr}(\Pi_AX_2)\big]\;\le\;\lVert g_1\rVert^2+\tfrac29\big(B_{12}^2+B_{13}^2\big)\;=\;\lVert g_1\rVert^2 ,$$
the last step by §5.

## 5. $B_{12}=B_{13}=0$ on $T_u\mathcal O^\perp$, so L138(c)'s "exact cancellation" is between two zeros

Decompose $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$. For $A\in\mathfrak{su}(2)_+$, $\rho(A)$ preserves $E$, $A$ and $K'$ separately, and acts trivially on $A$; since $u=\Pi_Eu\Pi_E$, the orbit tangent $[\rho(A),u]$ is supported **entirely in the $E\times E$ block**, where $([\,\cdot\,]) _{ij}=X_{ij}(\lambda_j-\lambda_i)$ picks out precisely the $(1,2)$ and $(1,3)$ positions, the $(2,3)$ position dies because $\lambda_2=\lambda_3$. So $T_u\mathcal O$ contains the two symmetric matrices carrying $B_{12}$ and $B_{13}$ alone, and orthogonality to them reads
$$B_{12}=B_{13}=0\qquad\text{for every }H\in T_u\mathcal O^\perp .$$
*(Consistency: $\mathfrak{su}(2)_-$ and $\mathfrak{so}(n-4)$ contribute nothing, mixed generators contribute $4(n-4)$ dimensions in the $E\times K'$ block, and $2+4(n-4)=4n-14=\dim\mathcal O$, matching [Lemma L134](../findings/route-a.md#lemma-l134-the-competitor-side-second-order-margin-and-i3-reduced-to-one-bound-on-the-defect)'s own count.)*

**Consequence for L138(c).** The claim "the multiplier $\tfrac13$ squares to $\tfrac19$ and enters $\lVert Z\rVert^2$ twice, against L137's $-\tfrac29$" is doubly defective. The factor-of-two bookkeeping is right in itself (the $(1,2)$ and $(2,1)$ entries each contribute $(B_{12}/3)^2$) but (i) it contradicts (b), which has just established that the whole $\Lambda^2\mathbb R^4$ block of $Z$ reaches $\mathrm{Alt}$ only through $\langle Z,\star\rangle=0$, so those entries are not in $\lVert g_1\rVert^2$ at all; (ii) L137's $-\tfrac29$ is spurious per §3, so there is nothing to cancel against; and (iii) **both sides are identically zero on the stated domain**. *Asked of this finding: would it be true vacuously? Yes, and that is the finding. A cancellation of $0$ against $0$ is being reported as the step that makes the bound work.*

## 6. L138(b), the structure is right, the displayed inequality is not

**Confirmed.** $\Lambda^4\mathbb R^4$ is one-dimensional; $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto the $\Lambda^4$ summand, so on $\Lambda^2\mathbb R^4$ it is $S\mapsto\tfrac{\langle S,\star\rangle}6\star$ with $\lVert\star\rVert^2=6$; and $\star=\Pi_E-\Pi_A$ is block-diagonal across $E\oplus A$, so $E\times A$ entries of $Z$ are invisible to $\mathrm{Alt}$. Hence the restriction of $c_2,c_3$ to $K'$ is legitimate.

**Confirmed, from L17(d) exactly as claimed.** Bianchi gives $\langle H,\star\rangle=0$, i.e. $B_{11}+B_{22}+B_{33}=\operatorname{tr}(B_{\mathrm{ASD}})$; unit-norm tangency $\langle H,u\rangle=0$ gives $2B_{11}=B_{22}+B_{33}$. On $\{F=0\}$ the equality case of L17 forces $B_{\mathrm{ASD}}=\Pi_AH\Pi_A=0$, so $3B_{11}=0$ and $B_{22}+B_{33}=0$. The index reading L138 assumes is the right one: L17's "$H_{11},H_{22},H_{33}$" are the $E$-diagonal entries, i.e. L138's $B_{ii}$, while L17's "$B$" is $B_{\mathrm{ASD}}$, a name collision the record navigates correctly. **And $\langle Z,\star\rangle=0$ then follows.** *It is worth saying plainly that this is $\langle g_0,g_1\rangle=0$, which is $F=0$ itself: (b)'s cone identity restates the hypothesis rather than adding to it.*

**Refuted, the displayed bound.** The step wants
$$\lVert\mathrm{Alt}(Z)\rVert^2\;\le\;\underbrace{2\big(\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2\big)}_{=\lVert Z_C\rVert^2}\;+\;\lVert\mathrm{Alt}(Z_D)\rVert^2 ,$$
with $\mathrm{Alt}$ applied to the $D$-summand and not to the $C$-summand. That is not a valid inequality: $\mathrm{Alt}(Z)=\mathrm{Alt}(Z_C)+\mathrm{Alt}(Z_D)$ and the two summands **share $4$-sets**, so only $(\lVert Z_C\rVert+\lVert\mathrm{Alt}(Z_D)\rVert)^2$ is available, and its cross term is not small. Concretely, a $4$-set with three indices inside the distinguished $\mathbb R^4$ and one outside (say $\{1,2,3,5\}$), is fed by $E\times K'$ entries (through $Z_C$) *and* by $A\times K'$ entries (through $Z_D$); a $4$-set with two in and two out is fed by $\Lambda^2\mathbb R^4\times K'$ entries and by $K'\times K'$ entries.

**The repair, and it is free.** On the cone $\mathrm{Alt}$ annihilates the whole $\Lambda^2\mathbb R^4$ block of $Z$, so with $Z'=Z-\Pi_{\Lambda^2\mathbb R^4}Z\Pi_{\Lambda^2\mathbb R^4}$ one has $\mathrm{Alt}(Z)=\mathrm{Alt}(Z')$ and $\lVert\mathrm{Alt}(Z)\rVert\le\lVert Z'\rVert$, where $\lVert Z'\rVert^2$ *is* an honest sum of squares. On $\{F=0\}$, $\Pi_AD_-=0$ kills both the $A\times A$ and the $A\times K'$ parts of $Z_D$, so
$$\lVert g_1\rVert^2\;\le\;2\big(\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2\big)+\lVert D_-\rVert^2 .$$
The coefficient $2$ is right, a cross block is counted twice in the Frobenius norm and the multipliers on rows $2,3$ have magnitude $1$, and $\lVert D_-\rVert$ replaces $\lVert\mathrm{Alt}(D_-)\rVert$. **This is the version that survives, and it needs no L139.**

## 7. L139(a), REFUTED, with an explicit witness on the cone

The proof asserts that "a pairing involving $E$ needs its partner inside $\mathbb R^4$ too", so that the only $4$-set reached is $\{1,2,3,4\}$. **That is false.** $\hat\omega_1\propto e_{12}+e_{34}$ has a summand $e_{12}$ disjoint from $e_{35}$, so the pairing $(\hat\omega_1,e_{35})$ reaches the $4$-set $\{1,2,3,5\}$. The record confuses *disjoint from a plane of $\Lambda^2\mathbb R^4$* with *contained in $\mathbb R^4$*. This is the same error the author is recorded as having made and withdrawn once already in L138(b); it survives here.

Working the $4$-set $T=\{1,2,3,5\}$ from $\mathrm{Alt}(H)=0$ alone gives the exact correction:
$$\mathrm{Alt}(N)_T\;=\;-\tfrac1{\sqrt2}\Big[c_1(e_{35})-c_2(e_{25})+c_3(e_{15})\Big],\qquad c_i(\beta):=\langle\hat\omega_i,H\beta\rangle .$$
Nothing on $\{F=0\}$ constrains the $E\times K'$ block, so $\mathrm{Alt}(N)$ does not vanish. Note also that $c_1$ appears here even though L138(a) has just established that $c_1$ is invisible to $Z$, the two blocks are not the same object.

**Screen, at $n=8$.** (i) For a random symmetric $H$ with $\mathrm{Alt}(H)=0$, the identity above matches the computed $\mathrm{Alt}(N)_{\{1,2,3,5\}}$ to $2\times10^{-16}$, and only $1.8\%$ of $\lVert\mathrm{Alt}(N)\rVert^2$ sits on $\{1,2,3,4\}$. (ii) A genuine witness: alternating projection onto $\{\mathrm{Alt}=0\}\cap\{\mathrm{Ric}=0\}\cap\{\Pi_AH=0\}$, normalised, gives a unit Weyl tensor with $\Pi_AH=0$, hence $B_{\mathrm{ASD}}=0$ and $\Pi_AD_-=0$, hence $F(H)=3.8\times10^{-17}$, i.e. **on the cone**, for which $\lVert\mathrm{Alt}(N)\rVert=0.1445$ against $\lVert N\rVert=0.8785$, with the $\{1,2,3,4\}$ coefficient equal to $2.6\times10^{-18}$. **The mass of $\mathrm{Alt}(N)$ is entirely off the distinguished $4$-set, which is where L139(a) says all of it is.** Reported as a screen of a claim derived above.

**Confirmed, narrowly.** The one part of (a) that is right: on $\{1,2,3,4\}$ the coefficient is $\tfrac{\langle\Pi_EH\Pi_E,\star\rangle}6=\tfrac{\operatorname{tr}(B)}6$ using $\star\vert_E=+1$ and $\lVert\star\rVert^2=6$, and it does vanish on the cone. The sign the record writes, $-\tfrac16\operatorname{tr}(B)$, follows from $\mathrm{Alt}(N)=-\mathrm{Alt}(H-N)$; either way it is zero.

## 8. L139(b), CONFIRMED as an implication, vacated by (a)

$\mathrm{Alt}(M)=0$ gives $\mathrm{Alt}(M_+)=\mathrm{Alt}(M_-)$, hence $\mathrm{Alt}(\lvert M\rvert)=2\mathrm{Alt}(M_-)$, hence
$$\lVert\mathrm{Alt}(M_-)\rVert^2=\big\langle\mathrm{Alt}(M_-),\tfrac12\mathrm{Alt}(\lvert M\rvert)\big\rangle=\tfrac12\big\langle\mathrm{Alt}(M_-),\lvert M\rvert\big\rangle\le\tfrac12\lVert\mathrm{Alt}(M_-)\rVert\,\lVert M\rVert .$$
This uses only that $\mathrm{Alt}$ is a self-adjoint idempotent and $\lVert\,\lvert M\rvert\,\rVert=\lVert M\rVert$. **No Ricci-flatness, no unit norm, no pair symmetry beyond $M=M^{\mathsf T}$, and Bianchi enters only as $\mathrm{Alt}(M)=0$**, exactly as the record claims. The implication is sound; its hypothesis at $N=P_0HP_0$ is not.

*A partial repair exists for anyone who wants one: without $\mathrm{Alt}(N)=0$ the same computation gives $\lVert\mathrm{Alt}(N_-)\rVert\le\tfrac12\big(\lVert N\rVert+\lVert\mathrm{Alt}(N)\rVert\big)$, and $\lVert\mathrm{Alt}(N)\rVert$ is controlled by the $C$-block. It buys nothing here, because §9's optimum is already reached without touching $D$.*

## 9. L139(c), the arithmetic is right and the answer is wrong

**The ratios, checked against the constraint $\lVert B\rVert^2+2\sum_i\lVert c_i\rVert^2+\lVert D\rVert^2=1$.** Given L138(c)'s displayed bound, the $c_2,c_3$ family pays $\tfrac43/2=\tfrac23$, the $D$ family $\tfrac14/1=\tfrac14$, the $c_1$ family $\tfrac13/2=\tfrac16$, and $B$ pays $0$; the maximum over the simplex of a linear functional is at a vertex, so it is $\tfrac23$. **Correct as arithmetic.**

**The threshold, checked digit by digit.** $\tfrac23-\tfrac19=\tfrac59$, so $\theta^*/(2\lvert\kappa_n\rvert)\ge\tfrac59\iff\lvert\kappa_n\rvert\le\tfrac{9\theta^*}{10}=1.1022704$; with $\kappa_n=9(\theta^*-\theta_0(n))$ this is $\theta_0(n)\le\theta^*+\tfrac{\theta^*}{10}=1.3472194$. And $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is confirmed against [conventions.md](../findings/conventions.md); $\theta_0(31)=1.3455906$ and $\theta_0(32)=1.3477412$, so the last integer clearing is $31$ and the crossing is at $n=31.75$. **All confirmed.**

**Two corrections even on the record's own inputs.** (i) $\theta_0(n)$ is the value at the *balanced sphere product*, which exists only at even $n$, [conventions.md](../findings/conventions.md) records the odd-$n$ diagonal maximum as a different expression, so the statement "every even $n$ with $12\le n\le31$" has an endpoint that no admissible $n$ attains. The honest even endpoint is $30$. (ii) Nothing in the chain needs $n$ large or small beyond $\kappa_n<0$ at $n\ge12$ and $K'\ne0$ at $n\ge5$; the one hidden $n$-dependence is inherited, in [Lemma L134](../findings/route-a.md#lemma-l134-the-competitor-side-second-order-margin-and-i3-reduced-to-one-bound-on-the-defect)(a)'s $\tfrac13$, whose four block spectra are tabulated at $n=10,12,14$ and asserted stable beyond. L139 adds no new one.

**The corrected range.** Assembling §4 and §6,
$$\Delta_2\;\le\;\lVert g_1\rVert^2\;\le\;2\big(\lVert c_2\rVert^2+\lVert c_3\rVert^2\big)+\lVert D\rVert^2\;\le\;1 ,$$
the last step because $2\lVert c_2\rVert^2+2\lVert c_3\rVert^2+\lVert D\rVert^2\le\lVert H\rVert^2=1$. Then $1\le\tfrac19+\theta^*/(2\lvert\kappa_n\rvert)$ requires $\lvert\kappa_n\rvert\le\tfrac{9\theta^*}{16}=0.6889190$, i.e. $\theta_0(n)\le1.3012914$. Since $\theta_0(18)=1.2957671$ and $\theta_0(19)=1.3020334$:

| chain | $\Delta_2$ ceiling | $\theta_0$ ceiling | largest $n$ | largest even $n$ |
| --- | --- | --- | --- | --- |
| record, as written | $\tfrac23$ | $1.3472194$ | $31$ | $30$ |
| **corrected (this review)** | $1$ | $1.3012914$ | $\mathbf{18}$ | $\mathbf{18}$ |
| corrected, if §6's repair is replaced by the Cauchy–Schwarz form $(\sqrt2s+d/2)^2$ with L139(b) granted | $1.5288$ | $1.2727384$ | $15$ | $14$ |

**So the range is $12\le n\le18$, and the corrected chain does not use L139 at all.** *(The third row is recorded to show that the cross-term route is worse than the sum-of-squares route; there is no repair of L139 that improves on $18$ without a sharper treatment of $\mathrm{Alt}$ on the $E\times K'$ entries, which is where the record already says the remaining factor sits.)*

## 10. What the conclusion can and cannot say

**The overstatement is real but the record half-flags it.** L134's own text names two gaps: the orthogonality hypothesis (present here, since the setting quantifies over $\{F=0\}\cap T_u\mathcal O^\perp$, good) and **a remainder step that L134 does not supply**, since (b) is a per-direction second-order statement while [Conjecture L16](../findings/problem.md) near $\mathcal O$ is a neighbourhood statement, and $\delta^2$ has no third derivative at $u$ at all. L139(c)'s boxed claim is about I3, which L134(b) defines per direction, so it is defensible as stated; the following paragraph's "Conjecture L16 holds in a tube about the competitor's orbit there" is not, and it says "granting the remainder step" in the same breath. **What a reader should take from the section heading alone is wrong, and the heading is what gets cited.** I would rewrite it as "I3's per-direction inequality holds for …".

**Not vacuous.** $\{F=0\}\cap T_u\mathcal O^\perp$ contains unit Weyl tensors with nonzero $c_2,c_3$ and nonzero $D$ (I built one) so the bounds are being asserted about a nonempty set, and the failures above are failures on that set rather than artefacts of an empty domain. The one genuinely vacuous item is L138(c)'s cancellation (§5).

## Corrections, in the order they should be applied

1. **L135(c):** $W_-=\tfrac12(\lvert W\rvert-W)$, not $\tfrac12(W-\lvert W\rvert)$. State the convention once, at the top of the L134–L139 block.
2. **L136(a):** replace with $\operatorname{tr}(\Pi_EX_2)=+\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)\ge0$, and record that the $C$-contribution cancels between eigenvalue deepening and eigenvector tilt. Withdraw "the self-dual branch works for the bound rather than against it" and its equality analysis.
3. **L136(b)/L137:** replace the $\mathcal E_D$ route by $\operatorname{tr}(\Pi_AX_2)=\varphi'(0^+)\ge0$ for $\varphi(t)=\operatorname{tr}(\Pi_A(D_s)_-)\ge0$, $\varphi(0)=0$. This retires the "live obstacle" of $D$'s singularity on $K$ that L135, L136 and L137 all name.
4. **L137:** the boxed inequality becomes $\Delta_2\le\lVert g_1\rVert^2+\tfrac29(B_{12}^2+B_{13}^2)$, and $B_{12}=B_{13}=0$ on $T_u\mathcal O^\perp$, so $\Delta_2\le\lVert g_1\rVert^2$.
5. **L138(b):** displayed bound becomes $\lVert g_1\rVert^2\le2(\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2)+\lVert D_-\rVert^2$, derived through $\lVert\mathrm{Alt}(Z)\rVert\le\lVert Z'\rVert$ rather than by adding $\mathrm{Alt}$'d and un-$\mathrm{Alt}$'d summands.
6. **L138(c):** delete. The cancellation it reports is $0=0$ on the stated domain.
7. **L139(a):** withdraw. The support claim is false; the surviving content is that the $\{1,2,3,4\}$ coefficient is $\tfrac{\operatorname{tr}B}6=0$.
8. **L139(b):** keep the implication verbatim (it is correct and its hypothesis analysis is correct) and delete the sentence that supplies the hypothesis from (a).
9. **L139(c):** $\Delta_2\le1$, threshold $\theta_0(n)\le1.3012914$, **even $n$ with $12\le n\le18$**. Restate the headline as a per-direction second-order statement, with L134's remainder step named in the same sentence.

