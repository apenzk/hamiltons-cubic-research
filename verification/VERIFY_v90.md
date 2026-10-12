# VERIFY v90, L00 r2: the cone bridge at $a=0$, the identification of "Conjecture A", and the diagonal grant

*Verifier v90, cold brief, on [findings/problem.md](../findings/problem.md):9–111 as dispatched in [ROUND_L00r2.md](ROUND_L00r2.md). **No numerical work was done**: no script was run, and every value below is an exact hand evaluation or a string read out of a stored source. Line numbers cite [problem.md](../findings/problem.md); the round file reproduces the block with a uniform offset of $+13$, verified at three anchors, so round line $\ell$ is source line $\ell-13$. Log: [agent_logs/verify-L00r2-v90.log](../agent_logs/verify-L00r2-v90.log). Sources read from [references/](../references/) rather than from memory: [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf), [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404), [boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187), [xu-2412.13633.txt](https://arxiv.org/abs/2412.13633). No other verifier's report was opened.*

## Verdict table

| # | Claim, as a consumer would cite it | Verdict |
| --- | --- | --- |
| D1 | *"That is the bridge, and it had not been derived"* ([problem.md](../findings/problem.md):104) | **REFUTED, and refuted eight lines above itself** |
| D2 | *"Why this project's $P$ is that conjecture rather than a relative of it"* (:100) and *"right about the wording and wrong about the content"* (:104) | **CONTRADICTED by the block's own :94** |
| D3 | The quotation of Beitz Remark 6.3.15 (:32) | **ELIDES THE $n\ge12$ HYPOTHESIS present in the source** |
| D4 | *"It is Böhm–Wilking's 'Conjecture A' … attributed to a PhD thesis by Beitz"* (:11) | **MISATTRIBUTED, the name and the statement are Nienhaus's, and they differ** |
| D5 | *"also referred to as 'Conjecture L1' in the surrounding literature"* (:11) | **RESTS ON AN UNREAD SOURCE, no such name anywhere in [references/](../references/)** |
| D6 | The $a=0$ cone, as printed (:47–:57, :61–:75) | **HYPOTHESIS DROPPED: $\operatorname{scal}(R)>0$, hence the sign of $c$** |
| D7 | *"this **is** the diagonal-case maximization result"* (:21) | **STEP NOT NAMED: needs $Q(\mathcal D_n)\subseteq\mathcal D_n$; the argument is on file 301 lines below** |
| D8 | *"$n=12$ and $n=14$ are open **even in the diagonal case**"* (:24) and *"the gap it papers over … sits exactly at the threshold under study"* (:29) | **STALE in the record's own terms, [Lemma L57](../findings/problem.md) closes both parities at every $n\ge4$** |
| D9 | *"What is settled is that the target constant is right"* (:94) | **CITATION HAZARD, false at odd $n$ read alone, scoped correctly 26 lines above** |
| (| The $a=0$ collapse to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ | **NO FINDING), rebuilt by hand, exact, no residue** |
| (| $n^2-12n+8<0\iff n\le11$, and the odd-$n$ sphere values | **NO FINDING), exact** |
| (| Every citation of BW08, Xu and Jäger | **NO FINDING), verbatim against the stored extractions** |

**Verdict: `GAP`.** The derivation the block performs is correct and I reproduced it by hand end to end. What the block does not establish is the thing its own heading promises (that Problem $P$ and the Böhm–Wilking conjecture are one statement) and two of its citable sentences assert an identity that a third sentence, twelve lines earlier, denies. Read alone, as a consumer would, this section licenses four claims the record has already refuted.

## 0. Conventions, fixed once

- $\Lambda^2=\mathfrak{so}(n)$, $I$ the identity operator on it, $\lVert I\rVert^2=\dim\Lambda^2=\binom n2=\tfrac{n(n-1)}2$. This is the block's convention at :73 and I adopt it throughout.
- $Q(X)=X^2+X^\#$; $\Phi=Q$; $\Phi(A,B)=\tfrac12(AB+BA)+A\#B$ is its polarization, so $Q(A+B)=Q(A)+2\Phi(A,B)+Q(B)$.
- $P(W)=\langle W,Q(W)\rangle$, this project's normalisation. [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/) write $P(R)=\tfrac13\operatorname{tr}(R^3+RR^\#)=\tfrac16\operatorname{tri}(R,R,R)$ (read at extraction line 198) so theirs is a third of this one. The block records the factor at :96.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. $\Theta_n$ is [conventions.md](../findings/conventions.md)'s **diagonal maximum**: $\Theta_n=\theta_0(n)$ at even $n$, $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$. **The block under review never names $\Theta_n$.**
- $R=R_I+R_{\mathrm{ric}_0}+R_W$; $Y:=R_{\mathrm{ric}_0}$; $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$; $G(R)=dF_R(\Phi(R))$.
- $\mathcal D_n$ is the diagonal locus; Jäger's $\langle W\rangle_d$ is its counterpart, defined in the source as the operators diagonal **with respect to the standard basis** $e_1\wedge e_2,\dots,e_{n-1}\wedge e_n$.

## 1. The hypothesis inventory

A pass without this is not a pass, so it comes before the sections.

### 1.1 Hypotheses the block carries in its own voice

| Hypothesis | Where it appears | Used by the written argument? |
| --- | --- | --- |
| $\lVert W\rVert=1$ | :73 | **Yes**, pins $c$ and turns $c(n-1)$ into a constant |
| $W$ is Weyl, i.e. $\mathrm{ric}(W)=0$ | :65–:67 | **Yes**, kills $\langle W,I\rangle$, $\langle I,Q(W)\rangle$ and $\Phi(I,W)$ |
| $R_{\mathrm{ric}_0}=0$ (the slice) | :61 | **Yes**, the whole $\theta_0$ derivation is on it |
| $R$ lies on $\partial\Omega_0$ | :67, :73 | **Yes**, the equality is what makes $c$ a function of $n$ |
| $n\ge12$ | :66 | **Derived, not assumed**, see §5 |
| Even $n$ | :25 | Carried only for Jäger's theorem, not for the block's own derivation |
| $\Phi$ preserves the first Bianchi identity | :83 | **Yes**, and the block names it as an input it had not named |
| Invariance $\Rightarrow G\le0$ | :83 | **Yes**, and the block names it, correctly identifying it as the converse of what the source supplies |

### 1.2 Hypotheses of every imported result, checked against the object

| Import | What the source actually assumes | Does the object satisfy it? |
| --- | --- | --- |
| [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.1 (extraction :216), *"$R+R\#I=(n-1)R_I+\tfrac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}$"* | $R\in S^2_B(\mathfrak{so}(n))$, the **Bianchi** subspace | Yes; $W$ and $I$ are both Bianchi |
| [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6) (:203) | Stated for the $\mathrm{Ric}$-eigenbasis $e_1,\dots,e_n$ | Yes; $\mathrm{Ric}(W)=0$ makes the frame vacuous |
| [BW08](../references/boehm-wilking-2008-space-forms/) eq. (5) (:186), $\operatorname{tri}(R_1,R_2,R_3)=\operatorname{tr}((R_1R_2+R_2R_1+2R_1\#R_2)R_3)$ | none beyond $S^2_B$ | Yes, and the block correctly says at :85 that this symmetry is **not** load-bearing here |
| [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) cone, p. 96 | $\Omega_a=\{R\in\mathcal A_n:(\tfrac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}(R)\rVert^2$ **and** $\operatorname{scal}(R)>0\}$ | **The second clause is dropped by the block**, D6 |
| [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4 | gives $G\le0\Rightarrow$ invariance | The block needs the converse and says so, :83, no debt |
| [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Prop. 2.7, Lemma 2.8 (extraction :491, :519) | $R\in S^2(\mathfrak{so}(n))$ | Yes |
| [Jäger](../references/jaeger-2016-diagonal-case/) Theorem A (extraction :113) | $n\ge16$ **even**; $W\in\langle W\rangle_d$; $\lVert W\rVert=1$; **$W^2+W^\#=\theta W$**, i.e. criticality; $\theta\ge\theta_0(n)$ | Diagonality and criticality are both hypotheses; see D7 |
| [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Conjecture A (extraction :212) | $W$ a **critical point** of $P$ on $\mathrm{Weyl}^1_n$; **either $n\ge12$ or $8\le n\le11$ with $W\notin SO(n)\cdot W_{\mathbb{CP}^2}$** | **Neither hypothesis appears anywhere in the block**, D4 |

### 1.3 Hypotheses the block uses without stating

- $\lVert\mathrm{ric}(R)\rVert\ne0$, so that $F$ is defined. On the slice $R=cI+W$ this needs $c\ne0$, which the block's own boundary equation supplies but never says. [Lemma L43](../findings/problem.md) states it in the sharper form: the ratio $c/\lVert W\rVert$ is pinned to $\theta_0(n)/(n-1)$, a **single nonzero** value, so $c=0$ forces $\lVert W\rVert=0$, which is why the slice is the Einstein one and not the Ricci-flat one. The block under review says neither.
- $c>0$. See D6.
- $G\le0$ is demanded **on $\partial\Omega_0$**, not on all of $\Omega_0$. The block writes flatly *"Invariance is $G\le0$"* (:100). The derivation only ever evaluates on the boundary, so nothing downstream breaks, but the statement as printed is stronger than what invariance gives.
- $Q(\mathcal D_n)\subseteq\mathcal D_n$. See D7.

## 2. Quantifier order, scope, and the edges of every range

- **Order.** The correct reading of the derivation is: *for every* $n$, *for every* unit Weyl $W$, setting $c=c(n)$ from the boundary equation, invariance of $\Omega_0$ forces $\langle W,Q(W)\rangle\le c(n-1)$. The block's :73 phrases this as *"Normalising $\lVert W\rVert=1$, the $\partial\Omega_0$ constraint … gives $c$"*, which is the right order: $c$ depends on $n$ alone once $W$ is normalised, and each unit $W$ is therefore tested against one constant. [Lemma L43](../findings/problem.md) says this explicitly (*"$\partial\Omega_0$ meets the slice at one ratio"*); the block leaves it to be inferred.
- **Smallest admissible dimension.** The derivation needs $n\ge3$ for $\theta_0(n)>0$ and $n\ge4$ for $\langle W\rangle\ne0$. Nothing in the block fails at $n=4$: the $\mathbb{CP}^2$ witness lives there, and the block's non-invariance range starts there. No finding.
- **Odd $n$.** The collapse is parity-free, no step of §4 below uses parity. The block says so at :68. What is parity-dependent is *attainment*, and the block says that too. **This passage is the block's strongest**, and it is the passage [INDEX-results.md](../findings/INDEX-results.md) records as having stood 389 lines above [Lemma L0](../findings/problem.md)'s refuted constant. No finding against it, see instead D9, which is the same block's later unscoped restatement.
- **Reducible and non-compact cases.** The block is algebraic throughout: $\mathcal W_n$ is a vector space of algebraic curvature operators and no manifold, compactness or irreducibility hypothesis enters the $a=0$ derivation. The reducible/irreducible split belongs to [Lemmas L46–L48](../results.md), not here. Stated for completeness: **no finding**, the block uses no manifold hypothesis it omits.
- **$\ker W\ne0$.** The derivation nowhere inverts $W$, and the padded $W_{\mathbb{CP}^2}$ of :66 has $\ker W\supseteq\Lambda^2(\mathbb R^{n-4})\ne0$ at every $n>4$, so the block's own witness is a kernel-carrying operator and the argument is designed for it. **No finding.**
- **The one range edge that does bite** is $8\le n\le11$: [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md)'s Conjecture A is a two-clause statement whose second clause covers exactly that band with $SO(n)\cdot W_{\mathbb{CP}^2}$ removed, and that clause is live, $\theta_0(10)^2=\tfrac{36}{25}<\tfrac32$. The block never mentions it. This is one of the three scope conditions [Lemma L0](../findings/problem.md) carries and the block does not.

## 3. The three forms compared

I checked four, since [lean/INDEX.md](../lean/INDEX.md) names two rows bearing on the block and both were asked for.

| Form | Constant | Criticality hypothesis | $\mathbb{CP}^2$ clause | Parity treated | What it carries that the others do not |
| --- | --- | --- | --- | --- | --- |
| The block, [problem.md](../findings/problem.md):9–111 | $\theta_0(n)$, called *"the Conjecture A bound"* at :68 | **absent** | **absent** | once, at :68 | the derivation itself; the literature census; the convention reconciliation; the off-slice expansion and the parity argument |
| [results.md](../results.md):11 | $\Theta_n$ | *"at every critical point"* | absent from the row | *"Proven at both parities"* | the correct constant, and the explicit note *refuted at $\theta_0(n)$* |
| [Lemma L0](../findings/problem.md):470ff | $\Theta_n$, split by parity in the statement | explicit, with the Lagrange condition written out | explicit, *"'Conjecture A' means its $n\ge12$ clause alone"* | explicit | all three scope conditions; the $\Leftarrow$ direction's honest weakening to $\sup\le\Theta_n$; the missing lower-half witness |
| [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) | `theta0Sq`, `ThetaOddSq`, both over `ℚ` | **none, every binder is a rational** | `ten_clause_live` | `gap_positive`, `values_at_thirteen` | machine-checked arithmetic that the two constants differ |

**What the Lean layer does and does not check.** Every binder in [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) is `ℚ`: there is no Weyl tensor, no $P$, no criticality. `backward_gives_only_le {P Θ s : ℚ} (hcrit : P ≤ Θ) (hmax : s = P) : s ≤ Θ` is the whole of the $\Leftarrow$ direction, stripped to arithmetic. The row itself says *"the Lagrange condition stays imported"*, and [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean) says its own half *"None of the three concerns $P$, Weyl tensors or $n$"*. So the Lean layer **does not check the identity of the two statements at all**, it checks that $\theta_0(n)\ne\Theta_n$ at odd $n$, which is the reason the identity failed once. [L43.lean](../lean/HamiltonsCubic/Results/L43.lean) is `partial` and its row says the owed part is *"the collapse itself, which needs Böhm–Wilking's $F$ and Beitz's cone, the base layer has no types for either"*. **Nothing formal stands behind the block's central claim.** The binder rule cuts here in the direction of caution: the binders are honest, and what they say is that the formalisation is about constants, not about statements.

**What each form carries that the block does not:** the constant $\Theta_n$; the criticality hypothesis; the $8\le n\le11$ clause; the distinction between *the maximum value* and *the maximiser*. **What the block carries that no other form does:** the entire cone derivation, the source census, and the off-slice accounting, none of which is reproduced anywhere else in prose.

## 4. The derivation, rebuilt by hand, no finding

I record this in full because a pass has to show what it checked.

**(a) The cone in decomposition form is consistent with the $F$-sublevel form.** $\Omega_a$ is $F\le\tfrac4{n-2+4a}$, i.e. $(n-2+4a)\lVert R\rVert^2\le4\lVert\mathrm{ric}(R)\rVert^2$. Substituting $\lVert R\rVert^2=\lVert R_I\rVert^2+\lVert Y\rVert^2+\lVert R_W\rVert^2$ and the block's $4\lVert\mathrm{ric}(R)\rVert^2=2(n-1)\lVert R_I\rVert^2+(n-2)\lVert Y\rVert^2$ gives coefficients $n-2+4a-2(n-1)=4a-n$ on $\lVert R_I\rVert^2$, $n-2+4a-(n-2)=4a$ on $\lVert Y\rVert^2$, and $n-2+4a$ on $\lVert R_W\rVert^2$, exactly four times the block's displayed inequality at :49. **The display and the normalisation it pins are mutually consistent.**

**(b) The endpoint checks.** At $a=\tfrac n4$ the threshold is $\tfrac4{2n-2}=\tfrac2{n-1}$, and $F(I)=\tfrac{n(n-1)/2}{\lVert\mathrm{ric}(I)\rVert^2}$ with $\lVert\mathrm{ric}(I)\rVert^2=\tfrac{n-1}2\cdot\tfrac{n(n-1)}2=\tfrac{n(n-1)^2}4$ gives $F(I)=\tfrac2{n-1}$. **The block's independent check at :87 reproduces.** At $a=0$ the condition is $-\tfrac n4\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_W\rVert^2\le0$, i.e. $\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$, the table row at :57, and equivalently $\lVert R_W\rVert^2\le\tfrac n{n-2}\lVert R_I\rVert^2$, the form used at :104. **Consistent.**

**(c) $\Phi(I)=(n-1)I$ and $\Phi(I,W)=0$.** Lemma 2.1 at $R=I$ reads $I+I\#I=(n-1)I$, so $Q(I)=(n-1)I$; at $R=W$ it reads $W+W\#I=0$, so $W\#I=-W$ and $\Phi(I,W)=\tfrac12(IW+WI)+W\#I=W-W=0$. **Both as printed at :65.**

**(d) The cubic collapses.** $\Phi(cI+W)=c^2(n-1)I+2c\Phi(I,W)+Q(W)=c^2(n-1)I+Q(W)$. Hence
$$\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+c^2(n-1)\langle W,I\rangle+c\langle I,Q(W)\rangle+\langle W,Q(W)\rangle,$$
and $\langle W,I\rangle=\operatorname{tr}W=0$ while $\langle I,Q(W)\rangle=\operatorname{tr}Q(W)=0$ because $Q(W)$ is again Weyl by eq. (6). **Two terms die, as printed.**

**(e) The right-hand side, and the cancellation.** $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$ and $\mathrm{ric}(\Phi(R))=c^2(n-1)\mathrm{ric}(I)$, so $\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle=c^3(n-1)\lVert\mathrm{ric}(I)\rVert^2$; and $F(R)=(c^2\lVert I\rVert^2+\lVert W\rVert^2)/(c^2\lVert\mathrm{ric}(I)\rVert^2)$. Their product is $c(n-1)(c^2\lVert I\rVert^2+\lVert W\rVert^2)$, **$\lVert\mathrm{ric}(I)\rVert^2$ cancels identically**, which is exactly the block's claim at :69 and the reason the Beitz/BW08 factor-$\tfrac12$ on $\mathrm{ric}$ costs nothing here. Subtracting, the criterion is
$$\langle W,Q(W)\rangle\ \le\ c(n-1)\lVert W\rVert^2,$$
with the $c^3(n-1)\lVert I\rVert^2$ term common to both sides. **No residue, exactly as claimed, and the cancellation never used the boundary equation**, so the collapse is an identity on the whole slice, which is what [Lemma L43](../findings/problem.md) says and the block does not.

**(f) The constant.** On $\partial\Omega_0$ with $\lVert W\rVert=1$: $\tfrac{n-2}n=c^2\cdot\tfrac{n(n-1)}2$, so $c^2=\tfrac{2(n-2)}{n^2(n-1)}$ and $c=\tfrac1n\sqrt{\tfrac{2(n-2)}{n-1}}$, whence
$$c(n-1)=\frac{n-1}n\sqrt{\frac{2(n-2)}{n-1}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$
**Exact, and it reproduces the block's :73–:75 line for line.** The one silent step is the positive square root, D6.

**(g) The threshold arithmetic.** $\theta_0(n)^2<\tfrac32\iff4(n-1)(n-2)<3n^2\iff n^2-12n+8<0$, whose roots are $6\pm2\sqrt7$; $6+2\sqrt7$ lies strictly between $11$ and $12$ since $2\sqrt7=\sqrt{28}\in(5,6)$. At $n=12$, $144-144+8=8>0$. **So the integer range is exactly $4\le n\le11$, as printed at :66.**

**(h) The odd-$n$ values.** $\tfrac{2(n-1)(n-3)}{(n-2)(n+1)}$ gives $\tfrac{2\cdot10\cdot8}{9\cdot12}=\tfrac{160}{108}=\tfrac{40}{27}$ at $n=11$; $\tfrac{2\cdot12\cdot10}{11\cdot14}=\tfrac{240}{154}=\tfrac{120}{77}$ at $n=13$; $\tfrac{2\cdot14\cdot12}{13\cdot16}=\tfrac{336}{208}=\tfrac{21}{13}$ at $n=15$. Against $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$: $\tfrac{180}{121}$, $\tfrac{264}{169}$, $\tfrac{364}{225}$. Each odd value is strictly smaller, at $n=13$, $\tfrac{264}{169}-\tfrac{120}{77}=\tfrac{264\cdot77-120\cdot169}{13013}=\tfrac{20328-20280}{13013}=\tfrac{48}{13013}$. **All three printed values are exact, and the strict inequality is exact.**

**(i) The convention reconciliation.** $F$ scales as $s^{-2}$ under $\mathrm{ric}\mapsto s\,\mathrm{ric}$, so $s=2$ divides $F$ by $4$: Beitz's $\tfrac2{n-1}$ becomes Xu's $\tfrac1{2(n-1)}$. **Exact.** And $F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$ scales as $s^{-2}\cdot s^2=1$, so the block's claim at :87 that the factor cancels is correct.

**(j) The Xu agreement.** [Xu](../references/xu-2024-ricci-flow-invariant-conditions/) Lemma 2.8, extraction line 519, reads term for term as the block's :101 display, including $\tfrac3{n-2}\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle$ and $-\tfrac2{(n-2)^2}\langle(\mathrm{Ric}_0^2)_0,\mathrm{Ric}_0\rangle$, and the sentence above it reads *"this identity … was derived by Huisken in his proof of the Theorem 3.3 in [16]. Since this identity was not written down as an independent lemma in [16]…"*, **the block's attribution sentence at :103 is faithful to the source.**

**No finding in §4.** Every step of the block's own derivation reproduces exactly.

## 5. The two pre-registered questions

### Q1, are the two statements the same, or does one grant what the other assumes?

**What the granted half covers in print.** [Jäger](../references/jaeger-2016-diagonal-case/) Theorem A, read at extraction line 113 and reproduced here verbatim from that file:

> "Theorem A. Let n ≥ 16 be an even integer, and let W ∈ ⟨W⟩d with ‖W‖ = 1 be given such that W² + W# = θW for a θ ≥ θ0(n). Then θ = θ0(n), and W is the normalized Weyl curvature of S^{n/2} × S^{n/2}."

Four hypotheses: $n\ge16$; $n$ even; $W\in\langle W\rangle_d$, defined in the source as diagonal **in the standard basis**; and $W^2+W^\#=\theta W$, a criticality equation. The next sentence, at extraction line 119, is *"The conjecture is that this is also true for all even integers n ≥ 12 and all operators W ∈ ⟨W⟩."* **The block's quotation of both is verbatim.**

**What the conjecture needs.** [Nienhaus](../references/nienhaus-2023-second-best-einstein/) Conjecture A, extraction line 212: $W$ a unit Weyl operator **that is a critical point** of $P(R)=\langle R^2+R^\#,R\rangle$; *"If either n ≥ 12 or 8 ⩽ n ⩽ 11 and W ∉ SO(n).W_{CP²}"*; conclusion $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$, the value at $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$, **which is $\Theta_n$, not $\theta_0(n)$.**

**The gap, item by item:** the whole non-diagonal half; $n=12,14$; all odd $n$; and, at odd $n$, the constant itself.

**Is the gap stated where a reader would look?** Partly, and the parts are in three different places.
- Diagonality, $n\ge16$ and even-$n$-only: **stated in the block**, at :23–:25, clearly.
- The constant: **stated in the block once**, at :68 (*"sharp at even $n$ only"*), and then restated without the scope 26 lines later at :94, D9.
- The criticality hypothesis and the $8\le n\le11$ clause: **stated nowhere in the block.** They are in [Lemma L0](../findings/problem.md) at :470ff, 359 lines below, where the round that repaired L0 supplied them.
- That the diagonal gap is now closed by the record's own theorem: **stated nowhere in the block**, D8.

**So the answer to Q1 is: they are not the same, and the block says so once and denies it twice.** The block's own :94 gives the correct account, *"the full cone conjecture is strictly more than Conjecture A; Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice"*, and the section heading at :100 and the sentence at :104 assert the opposite. See D2.

**What the block does establish, and it is worth stating positively.** One implication, cleanly: *invariance of $\Omega_0$ implies $P(W)\le\theta_0(n)$ for every unit Weyl $W$, at both parities.* Given any unit Weyl $W$, the pinned $c$ puts $cI+W$ on $\partial\Omega_0$, and §4(e)–(f) then force the bound. The converse fails, by the block's own off-slice accounting at :89–:94.

### Q2, does the $n\ge12$ threshold come from the same place in both?

**No, and the block's quotation is what hides the answer.** In both published statements $n\ge12$ is a **hypothesis**:

- [Beitz](../references/beitz-2018-bianchi-convexity/) Remark 6.3.15, extraction line 5626, verbatim: *"An unpublished conjecture of Christoph Böhm and Burkhard Wilking is that **for n ≥ 12** the cones Ω_a are invariant under the ordinary differential equation (2.4) for a ∈ [0, n/4]."*
- [Nienhaus](../references/nienhaus-2023-second-best-einstein/) Conjecture A carries it as the first disjunct of a two-clause condition.

In the block it is a **conclusion**: :66 derives that $\Omega_0$ is non-invariant for $4\le n\le11$, so the hypothesis is necessary rather than assumed.

**The two agree, and the reason is arithmetic**: both turn on $n^2-12n+8$, which [Crossover.lean](../lean/HamiltonsCubic/Results/Crossover.lean) records as *"one inequality carr[ying] three headline results, stated independently in three files"*. **So the threshold is one threshold, not two**, but with a caveat the block does not carry: what the block proves necessary is $n\ge12$ **for cone invariance at $a=0$**, where there is no exception clause. For Nienhaus's Conjecture A, $n\ge12$ is *not* necessary, because the $8\le n\le11$ clause survives with $SO(n)\cdot W_{\mathbb{CP}^2}$ removed, and $W_{\mathbb{CP}^2}$ is precisely the block's own witness. A consumer citing :66 for "the conjecture's dimension hypothesis is forced" is citing a true statement about the cone and a false one about Conjecture A as published.

## 6. The discrepancies, three steps each

### D1, *"it had not been derived"* stands eight lines below the correction that refutes it

**Locate.** [problem.md](../findings/problem.md):104: *"…is what the criterion needs bounded there. **That is the bridge, and it had not been derived**: the earlier note that the thesis gives the conjecture 'not [in] the $P(W)$-maximization formulation' is right about the wording and wrong about the content."*

**Exhibit.** :96, in the same block: *"**ATTRIBUTION, corrected by Reviewer 91: the bridge below is PUBLISHED, twice, in sources this project already held.** … **An earlier version of this section called the bridge a derivation the project had never made; that was wrong**, and the Beitz sentence had been read and quoted in the same session."* And the object of that correction is on disk: [references/beitz-2018-bianchi-convexity/notes.md](../references/beitz-2018-bianchi-convexity/notes.md), line 21, already reads *"so **this project's cubic form $P$ is exactly the left-hand side of Böhm–Wilking's invariance criterion**"*, the bridge, written into a reference note the block itself cites two lines earlier. The refuted sentence and its refutation are eight lines apart, and the refuted one is the later.

**Argue the opposite.** The most charitable reading is temporal: *"it had not been derived [before this section derived it]"*, a statement about the record's history rather than about the literature. But that is verbatim the claim :96 says *"was wrong"*, and :96 gives the reason, the source sentence had been read in the same session. The charitable reading is the one already refuted.

**Stands.** And it is the round's named trap in its exact form: the correction landed **beside** the statement, and the statement was left standing, in the paragraph whose heading answers the round's central question.

### D2, the block asserts an identity its own scope paragraph denies

**Locate.** :100, a section heading: *"**Why this project's $P$ is that conjecture rather than a relative of it.**"* And :104: *"the earlier note that the thesis gives the conjecture 'not [in] the $P(W)$-maximization formulation' is right about the wording and **wrong about the content**."*

**Exhibit.** :94, twelve lines earlier: *"$a=0$ leaves $R_{\mathrm{ric}_0}$ **unconstrained**, so the full cone conjecture is **strictly more** than Conjecture A; Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice. What is settled is that the target constant is right, **not that the two statements coincide**."* And the block's own off-slice section at :89–:94 exhibits the difference concretely: the coupling $(Y,Y,W)=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ survives off the slice, so at $Y\ne0$ the criterion is a two-sided bound on $\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}$ and not on $\langle W,Q(W)\rangle$ alone. Beitz's conjecture quantifies over **all** $a\in[0,\tfrac n4]$ and all $R\in\mathcal A_n$; the $P$-maximization is one slice of one endpoint. **A sentence saying the wording differs but the content does not is false at every $a>0$ and false at $a=0$ off the slice.**

**Argue the opposite.** *"That conjecture"* in the heading could denote the $a=0$ slice statement rather than Beitz's Remark 6.3.15, in which case the heading is a true claim about $P$ being the criterion's left-hand side, which §4(e) confirms. But :104's sentence names the thesis explicitly and rules the wording/content distinction *wrong*, and :94 rules it right. **Two sentences of the same block cannot both be cited.**

**Stands.**

### D3, the quotation of Remark 6.3.15 drops the hypothesis the round asks about

**Locate.** :32: *"It states the conjecture once, as Remark 6.3.15, in the *cone-invariance* formulation (\"the cones $\Omega_a$ are invariant under the ODE for $a\in[0,\tfrac n4]$\")…"*

**Exhibit.** The source, [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) line 5626, reads *"…is that **for n ≥ 12** the cones Ω_a are invariant under the ordinary differential equation (2.4) for a ∈ [0, n/4]."* The quoted span begins one clause too late. The consequence is concrete: at :66 the block writes *"The conjecture's dimension hypothesis is therefore forced by an explicit witness rather than assumed"*, and inside the block, **the conjecture as quoted has no dimension hypothesis**, so the sentence has no antecedent a reader can check.

**Argue the opposite.** A partial quotation of a clause is not a misquotation, and the paragraph's subject is the *formulation* (cone-invariance versus $P$-maximization), not the threshold. Granted, but the block later makes the threshold the subject, and the elided clause is the whole of Q2's answer.

**Stands**, as a scope defect rather than an error.

### D4, "Conjecture A" is attributed to the wrong source, and the two statements differ

**Locate.** :11: *"It is **Böhm–Wilking's \"Conjecture A\"** … attributed to a PhD thesis by Beitz … It is referenced in passing in a 2023 paper, [Towards Finding the Second Best Einstein Metric in Low Dimensions]…"*

**Exhibit.** [Nienhaus](https://arxiv.org/abs/2311.02404), extraction line 212, is where the name is defined, and it states the conjecture in full, critical-point hypothesis, two-clause dimension condition, conclusion at $P(W^{\mathrm{crit}}_{\mathrm{sym}})$. The record's own card, [references/nienhaus-2023-second-best-einstein/README.md](../references/nienhaus-2023-second-best-einstein/README.md), calls it *"The single most load-bearing source. States the conjecture verbatim as **Conjecture A**"*. Beitz never uses the name (she writes *"An unpublished conjecture of Christoph Böhm and Burkhard Wilking"*) and states a different proposition. So the block's :11 gets the name's origin backwards (*"referenced in passing"* for the source, *"attributed to"* for the thesis that gives it no name) and, by identifying Conjecture A with the cone conjecture, drops both of Conjecture A's hypotheses at once.

**Argue the opposite.** Both statements are Böhm–Wilking's in origin, and Nienhaus's Conjecture A is plausibly the $a=0$ slice of Beitz's remark, so calling them one conjecture under two formulations is defensible **as a research hypothesis**. But the block presents it as the section's settled finding under the heading *"Identity of the conjecture"*, and its own :94 says the two do not coincide.

**Stands.**

### D5, *"Conjecture L1"* rests on an unread source

**Locate.** :11: *"(also referred to as \"Conjecture L1\" in the surrounding literature)"*.

**Exhibit.** A recursive search of [references/](../references/), every `.md` and every `.txt` extraction, returns no occurrence of the string "Conjecture L1". The only matches anywhere in the repository are this record's own lemma names (Conjecture L14, Conjecture L16), which are internal numbering and not "the surrounding literature".

**Argue the opposite.** The name may exist in a source not held here, and the block's own **Confidence** paragraph at :106 explicitly warns that search-tool prose was treated as a lead. But that warning is scoped to the $\mathbb{CP}^2$ fabrication it names, and this parenthesis is stated flatly as fact in the first sentence of the block.

**Stands**, as a claim resting on a source the record has not read.

### D6, the cone's $\operatorname{scal}(R)>0$ clause is dropped, and with it the sign of $c$

**Locate.** :47–:57 print the cone only through the decomposition inequality; :61–:75 derive $c$ from $c^2=\tfrac{2(n-2)}{n^2(n-1)}$ and take the positive root without comment.

**Exhibit.** Beitz's own definition, transcribed at [references/beitz-2018-bianchi-convexity/notes.md](../references/beitz-2018-bianchi-convexity/notes.md) line 11, is $\Omega_a:=\{R\in\mathcal A_n\mid(\tfrac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}(R)\rVert^2\ \text{and}\ \operatorname{scal}(R)>0\}$. Without the second clause $F$ is even in $R$, the sublevel set is a double cone, and the $c<0$ nappe runs the same derivation to $\langle W,Q(W)\rangle\le-\theta_0(n)\lVert W\rVert^3$, **false at every sphere product**, since $\theta_{p,q}^2=\tfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}>0$ for all $p,q\ge2$ and every member of the family has $\theta>0$. [Lemma L43](../findings/problem.md) records exactly this, and [L43.lean](../lean/HamiltonsCubic/Results/L43.lean) machine-checks the nappe violation. **The block under review carries neither the clause nor the warning.**

**Argue the opposite.** A reader who takes $\Omega_0$ to consist of curvature operators of positive scalar curvature (which the notation $\mathcal A_n$ and the name suggest), supplies $c>0$ without being told. But the block never names $\mathcal A_n$, prints the cone in a form from which the clause has been removed, and is the section [Lemma L43](../findings/problem.md) points at as its argument.

**Stands.**

### D7, *"this **is** the diagonal-case maximization result"* omits its own step

**Locate.** :21: *"Since $P(W)=\theta$ at a critical point and every maximizer is critical, this *is* the diagonal-case maximization result."*

**Exhibit.** Jäger's hypothesis is the unrestricted equation $W^2+W^\#=\theta W$. A maximiser of $P$ over the unit sphere of $\langle W\rangle_d$ is critical **for the restriction to $\langle W\rangle_d$**, whose Lagrange condition is $\Pi_{\langle W\rangle_d}Q(W)=\theta W$. Upgrading that to Jäger's equation needs $Q$ to preserve the diagonal locus. The record supplies precisely this, 301 lines below at [problem.md](../findings/problem.md):405: *"**$Q$ preserves $\mathcal D_n$**, so that restricted criticality is the equation the chain solves … **Assembled at audit; the record had every ingredient and this sentence nowhere.**"* [INDEX-results.md](../findings/INDEX-results.md) row 57 lists it as one of six repairs, *"the bridge from critical points to every diagonal $W$"*.

**Argue the opposite.** Given the step, the inference is clean and needs no more: if $\theta^*=P(W^*)\ge\theta_0(n)$ then Theorem A forces $\theta^*=\theta_0(n)$, and otherwise $\theta^*<\theta_0(n)$; either way $P\le\theta_0(n)$ on the diagonal locus. The block's one-clause version is therefore repairable by citation rather than by argument.

**Stands** as a hypothesis debt of exactly one named step, discharged elsewhere on the record and unpointed here.

### D8, the diagonal-gap claims are stale in the record's own terms

**Locate.** :24: *"So $n=12$ and $n=14$ are open **even in the diagonal case**, precisely the dimensions where the conjecture first bites."* And :29: *"the gap it papers over ($n=12,14$, and all odd $n$) sits exactly at the threshold under study."*

**Exhibit.** [results.md](../results.md) line 35: *"**The diagonal case is a theorem at every $n\ge4$, both parities, by this record's own argument** (Lemma L57) … The published grant is Jäger's Theorem A at even $n\ge16$, and the dependence on it is gone."* [Lemma L57](../findings/problem.md) sits at :542 of the very file the block is in; [Lemma L1](../findings/problem.md) at :407 and :427 addresses $n=12,14$ against Jäger's own argument. **A consumer reading the block alone learns that the record's diagonal side is open at exactly the dimensions where it is closed.**

**Argue the opposite.** The subsection is headed *"The diagonal case: located in the literature, and it covers less than assumed"*, which scopes it to print, and as a statement about print, *"$n=12$ and $n=14$ are open"* is true, since [Lemma L1](../findings/problem.md) is unpublished and itself conditional on an unnumbered Result 5b. **This is the strongest counter-argument of the nine and I record it as such.** But :29's *"the gap it papers over … sits exactly at the threshold under study"* is a claim about the programme rather than about print, and it is the sentence a consumer takes.

**Stands**, narrowly, and only for :29 and the unqualified *"are open"* of :24.

### D9, *"the target constant is right"*, unscoped

**Locate.** :94: *"What is settled is that the target constant is right, not that the two statements coincide."*

**Exhibit.** The target of Problem $P$ is $\Theta_n$ ([conventions.md](../findings/conventions.md)), and $\theta_0(n)^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}>0$ at odd $n$. Witness $n=13$: $\theta_0(13)^2=\tfrac{264}{169}$ against $\Theta_{13}^2=\tfrac{120}{77}$, difference $\tfrac{48}{13013}$, hand-evaluated in §4(h). This is verbatim the substitution [Lemma L0](../findings/problem.md) was Gate-2 refuted for, twice, on identical briefs.

**Argue the opposite.** *"The target constant"* can mean the constant the $a=0$ criterion demands, which is $\theta_0(n)$ at both parities, correct, and [INDEX-results.md](../findings/INDEX-results.md) row 44 says so explicitly (*"the criterion demands $c(n-1)=\theta_0(n)$ at both parities, $\Theta_n$ being what the diagonal locus attains"*). The block also scopes it correctly 26 lines earlier at :68. **The charitable reading is available and the words support it.**

**Stands as a citation hazard rather than an error**, because the sentence is the block's own summary line and carries no scope of its own.

### Withdrawn candidates

- *"$n\ge12$ IS NECESSARY, NOT MERELY SUFFICIENT"* (:66) reads, alone, as though sufficiency were established. **Withdrawn**: the phrase is a comparison of two roles a hypothesis can play, and no sentence of the paragraph claims sufficiency. It fails step three.
- *"the same polynomial a fifth time"* (:66) against the record's second threshold polynomial $n^2-13n+18$. **Withdrawn**: the block's subject is cone non-invariance, where $\theta_0$ is what the criterion demands at both parities, so $n^2-12n+8$ is the right polynomial and the count is about that one.
- The factor-3 tension between :96 (*"BW08 defines $P=\tfrac13\langle R,Q(R)\rangle$"*) and :104 (*"$P$ **is** the left-hand side"*). **Withdrawn**: verified at [boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187) line 198 that BW08's $P$ is $\tfrac13\operatorname{tr}(R^3+RR^\#)$; the criterion's left-hand side is $\langle R,\Phi(R)\rangle$, this project's $P$, and the note eight lines above warns of the difference. Consistent when read together.
- *"Invariance is $G\le0$"* (:100), which should say *on the boundary*. **Withdrawn**: nothing downstream uses more than the boundary, and step two (a concrete failure), cannot be exhibited.

## 7. What a reader may take from this block

**Takeable, and I checked each by hand or against the stored source:**

1. Jäger's Theorem A verbatim, with its four hypotheses, and the sentence leaving $n\ge12$ conjectural.
2. The $a=0$ collapse to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$, at both parities, **once $\operatorname{scal}(R)>0$ is restored**, §4.
3. $\Omega_0$ is non-invariant for $4\le n\le11$, witnessed by padded $W_{\mathbb{CP}^2}$, the witness being Nienhaus's.
4. The agreement with Xu Lemma 2.8, term for term including $\tfrac3{n-2}$, and Xu's own attribution of it to Huisken.
5. The convention accounting between Beitz, Xu and BW08, and the fact that it cancels in this derivation only.

**Not takeable:**

1. That Problem $P$ and the Böhm–Wilking/Beitz cone conjecture are one statement, D2, and the block's own :94.
2. That the bridge had not been derived, D1.
3. That "Conjecture A" is Beitz's, or that it carries no criticality hypothesis and no $\mathbb{CP}^2$ clause, D4.
4. That $\theta_0(n)$ is Conjecture A's constant at odd $n$, D9.
5. That the diagonal case is open at $n=12,14$ or at odd $n$ in this record, D8.

## 8. What would falsify the block, and what I did to look for it

**The objects that would break it.** (i) A unit Weyl operator $W$ at some $n\ge12$ with $P(W)>\theta_0(n)$, this would refute the $a=0$ invariance the whole bridge is conditional on, and with it the block's claim that $\theta_0$ is forced. (ii) A passage in [Beitz](../references/beitz-2018-bianchi-convexity/) stating the conjecture in $P$-maximization form, which would rescue :104 and refute D1/D2 together. (iii) A source in [references/](../references/) using the name "Conjecture L1", which would close D5. (iv) A source giving Jäger's Theorem A without the diagonality hypothesis, which would close most of Q1's gap.

**What I did.** For (ii) I read Remark 6.3.15 and Lemma 6.3.16 verbatim in [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) (lines 5626–5645) and the thesis's own cone definition in the transcription: both are cone-invariance, and Lemma 6.3.16's proof opens on $G:R\mapsto dF_R(\Phi(R))$ exactly as the block says at :96, **so the block's own :96 is right and its :104 is wrong, and the source settles it against :104.** For (iii) I searched every file under [references/](../references/), both notes and raw extractions: no occurrence. For (iv) I read Theorem A and the four lines around it, including the definition of $\langle W\rangle_d$ as the standard-basis-diagonal subspace: the hypothesis is there. For (i) I did **nothing**, hunting a falsifier is a search, the standing rule bars it, and the block's conclusion is conditional on a conjecture in any case, so a hunt would decide nothing this round.

---

**Verdict: `GAP`.** The mathematics reproduces exactly and the sources are quoted faithfully with one elision (D3). What is missing is the argument for the block's headline: the identity of the two statements is asserted in a heading and a closing sentence, denied twelve lines earlier by the same block, and settled against the block by the source it cites. Five hypotheses of the imported statements, criticality, the $8\le n\le11$ clause, $\operatorname{scal}(R)>0$, $c>0$, and $Q(\mathcal D_n)\subseteq\mathcal D_n$, appear nowhere in it, four of them discharged elsewhere on the record and none pointed at from here.
