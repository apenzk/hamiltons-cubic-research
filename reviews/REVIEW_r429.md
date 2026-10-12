# REVIEW r429, Lemma L140, $\lVert g_1\rVert^2\le\tfrac14$ and the I3 closure

**Target.** [Lemma L140](../findings/route-a.md), with [Lemma L136](../findings/route-a.md), [Lemma L135](../findings/route-a.md), [Lemma L134](../findings/route-a.md) and [Lemma L17](../findings/route-a.md) read as context. Brief: break it. Standing rule inherited: analysis only; the two numerical passages below are screens of claims I was about to record, run on objects I constructed for that purpose, and are reported as screens.

**VERDICT: CONFIRMED** for the boxed inequality $\lVert g_1\rVert^2\le\tfrac14$, **with corrections** to four surrounding statements, one of which is the lemma's own headline. **The immunity claim against both root causes of [r425](REVIEW_r425.md)/[r426](REVIEW_r426.md) is upheld**, but for a different reason than the lemma gives, and the sign collision that caused root cause (i) is *still live in the record*, in the very lemma that supplies $g_1$.

---

## 1. What I could not break

### 1.1 $\mathrm{Alt}$ is the orthogonal projection, and it kills $H$

$S^2(\Lambda^2\mathbb R^n)=\ker b\oplus\Lambda^4$ is an orthogonal, $GL(n)$-irreducible-summand decomposition, the two summands being non-isomorphic, so the $O(n)$-invariant complement is unique and $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$. A Weyl tensor lies in $\ker b$ by first Bianchi, so $\mathrm{Alt}(H)=0$ and $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$. Both steps of "$g_1=\mathrm{Alt}(Z+\mu H)$ for every $\mu$, hence $\lVert g_1\rVert\le\inf_\mu\lVert Z+\mu H\rVert$" are legitimate. $Z+\tfrac12H$ is symmetric, so it is in the domain where this holds.

**Pinned against the record's own constants rather than taken on trust.** $u_-=\tfrac1{\sqrt6}(\Pi_2+\Pi_3)$; $\star$ is $+1$ on $E$, $-1$ on $A$, so $\operatorname{tr}(u_-\star)=\tfrac2{\sqrt6}$ and the orthogonal projection of $u_-$ onto $\operatorname{span}(\star)$ is $\tfrac{2/\sqrt6}{6}\star=\tfrac1{3\sqrt6}\star$. That reproduces [Lemma L135](../findings/route-a.md)'s $g_0=a\star$, $a=\tfrac1{3\sqrt6}$, $\lVert\star\rVert^2=6$, $\delta^2(u)=\tfrac19$ **exactly**, so the record's $\mathrm{Alt}$ is the orthogonal projection in the record's own normalisation, and not a Bianchi sum with a stray factor.

### 1.2 Every multiplier, recomputed from $f$ and $u$'s spectrum

$f(x)=\tfrac12(\lvert x\rvert-x)$, so $f\equiv0$ on $[0,\infty)$ and $f(x)=-x$ on $(-\infty,0]$; $\lambda_1=2/\sqrt6$, $\lambda_{2,3}=-1/\sqrt6$, $\lambda_K=0$.

| entry | divided difference | value | table |
| --- | --- | --- | --- |
| $(\hat\omega_1,\hat\omega_1)$ | $f'(2/\sqrt6)$ | $0$ | $0$ ✓ |
| $(\hat\omega_1,\hat\omega_{2,3})$ | $\dfrac{0-1/\sqrt6}{2/\sqrt6+1/\sqrt6}$ | $-\tfrac13$ | $-\tfrac13$ ✓ |
| among $\hat\omega_2,\hat\omega_3$ | $f'(-1/\sqrt6)$ (equal eigenvalues, diagonal **and** off-diagonal) | $-1$ | $-1$ ✓ |
| $(\hat\omega_1,K)$ | $\dfrac{f(2/\sqrt6)-f(0)}{2/\sqrt6-0}=\dfrac{0-0}{2/\sqrt6}$ | $0$ | $0$ ✓ |
| $(\hat\omega_{2,3},K)$ | $\dfrac{1/\sqrt6-0}{-1/\sqrt6-0}$ | $-1$ | $-1$ ✓ |

All five in $[-1,0]$, so $\lvert m+\tfrac12\rvert\le\tfrac12$. **The table is complete**, those five blocks plus $K\times K$ and their transposes exhaust $\Lambda^2\times\Lambda^2$. The two entries the brief singled out are the two I re-derived a second way (§1.3): $(\hat\omega_1,K)=0$ and $(\hat\omega_{2,3},K)=-1$ are both correct.

### 1.3 $Z$ is the first-order coefficient, re-derived independently, and the moving eigenvectors are fully counted

This is the step where root cause (ii) would live, so I derived $Z$ from scratch rather than reading it. Block-diagonalise $W(t)=u+tH$ by $T=e^{tS}$ with $S$ skew and off-diagonal, $S_{EK}=-\Lambda^{-1}C$. Then $W_-=T\operatorname{diag}\big((\tilde W_{EE})_-,(\tilde W_{KK})_-\big)T^{\mathsf T}$, and with $M=\operatorname{diag}(\Lambda_-,0)$ the $t$-coefficient is
$$Z=\begin{pmatrix}\mathcal D_\Lambda[B]&0\\0&D_-\end{pmatrix}+\big(SM+MS^{\mathsf T}\big),\qquad SM+MS^{\mathsf T}=\begin{pmatrix}0&\Lambda_-\Lambda^{-1}C\\ C^{\mathsf T}\Lambda^{-1}\Lambda_-&0\end{pmatrix}.$$

- $\Lambda_-\Lambda^{-1}=\operatorname{diag}(0,-1,-1)$. **The conjugation's contribution, the eigenvectors' tilt, i.e. exactly the thing the previous refutation said had been dropped, reproduces the cross-block multipliers $0,-1,-1$ on the nose.** It is not an omitted term; it *is* the $(\hat\omega_i,K)$ column of the table.
- $(SM+MS^{\mathsf T})_{EE}=0$ because $S_{EE}=0$, so $Z_{EE}=\mathcal D_\Lambda[B]$ with $\Lambda$'s spectrum away from $0$ and $f$ analytic there.
- $(SM+MS^{\mathsf T})_{KK}=0$ because $M_{KK}=0$, and $t[W,S]_{KK}=O(t^2)$, so **$Z_{KK}=D_-$ exactly, not merely to leading order.** The brief's question here has a clean answer: the Schur term $C^{\mathsf T}\Lambda^{-1}C$ that muddies the $K$-block enters at $t^2$, and a first-order coefficient never sees it.

**Screen (seconds of compute, objects constructed for the purpose, reported as a screen and not as evidence).** In four random orthonormal bases of a $15$-dimensional $\Lambda^2$ with $u=\operatorname{diag}(2,-1,-1,0,\dots)/\sqrt6$ and random unit symmetric $H$, $\big\lVert\big((u+tH)_--u_-\big)/t-Z\big\rVert\approx2\times10^{-7}$ at $t=10^{-6}$, falling linearly in $t$. The stated $Z$ is the one-sided first-order coefficient. The same screen returned $\lVert Z+\tfrac12H\rVert\in[0.4935,0.499994]$ against the bound $0.5$.

### 1.4 The Frobenius bookkeeping

$\lVert\,\lvert D\rvert\,\rVert_F=\lVert D\rVert_F$ (same absolute eigenvalues), and $Z_{KK}+\tfrac12H_{KK}=\tfrac12(\lvert D\rvert-D)+\tfrac12D=\tfrac12\lvert D\rvert$ ✓. On the other blocks the bound is entrywise, $\lvert(m+\tfrac12)H_{ij}\rvert\le\tfrac12\lvert H_{ij}\rvert$, so summing squares over **all** entries (off-diagonal blocks counted twice on the left and twice on the right, symmetrically), gives $\lVert Z+\tfrac12H\rVert_F^2\le\tfrac14\lVert H\rVert_F^2$. The mixed entrywise/blockwise argument is sound because Frobenius is an entry sum and the $K\times K$ estimate is an equality of block norms. The norm is Frobenius on the $\Lambda^2$ operator matrix, per [conventions.md](../findings/conventions.md), and $u$'s spectrum $(2,-1,-1)/\sqrt6$ has $\sum\lambda^2=1$ in it, so no factor-of-two trap is open here.

### 1.5 Convention immunity, the claim is true

Under $W_-=\tfrac12(W-\lvert W\rvert)$: $f$ has slopes $0$ and $+1$, every divided difference negates into $[0,1]$, $\mu=-\tfrac12$ gives $\lvert m-\tfrac12\rvert\le\tfrac12$, and $Z_{KK}-\tfrac12H_{KK}=\tfrac12(D-\lvert D\rvert)-\tfrac12D=-\tfrac12\lvert D\rvert$ of norm $\tfrac12\lVert D\rVert$. Same bound. The lemma's reason (the multiplier range has length one in either sign), is the right reason. And $\Delta_2$'s cross term $2\langle g_0,g_2\rangle$ is convention-invariant because $g_0$ and $g_2$ flip together, so nothing downstream moves either.

### 1.6 The arithmetic and the scope

- $\lvert\kappa_{12}\rvert=9(1.236033-1.224745)=0.101567$, $\theta^*/(2\lvert\kappa_{12}\rvert)=6.029$ ✓. $\theta_0(n)^2=2(1-3/n+2/n^2)$ is increasing in $n$, so $\lvert\kappa_n\rvert$ increases to $9(\sqrt2-\sqrt{3/2})=1.705218$ and the threshold **decreases** to $0.359115$. So $\theta^*/(2\lvert\kappa_n\rvert)\ge0.3591$ for every $n\ge12$ ✓, and $\tfrac5{36}=0.13889<0.3591$ ✓.
- $\tfrac19+\tfrac5{36}=\tfrac14$ ✓; $\tfrac14<0.4702=\tfrac19+0.3591$, the binding form of [Lemma L136](../findings/route-a.md)'s "what is left" ✓, with margin $1.88$.
- Resulting per-direction margin: $\tfrac12\Phi''(0^+)\le-0.612372+1.705218\cdot\tfrac5{36}=-0.3755$, a factor $2.59$.
- **The $\lVert g_1\rVert^2\le\tfrac14$ statement really does need neither the cone nor orthogonality**, the proof uses only $\mathrm{Alt}(H)=0$, $u$'s spectrum, and $\lVert H\rVert=1$. And the *conclusion* is correctly stated on $\{F=0\}\cap T_u\mathcal O^\perp$, so there is no scope creep of the kind the brief anticipated.
- **Not vacuous.** The a priori bound from Moreau nonexpansiveness plus $\lVert\mathrm{Alt}\rVert\le1$ is $\lVert g_1\rVert^2\le1$; $\tfrac14$ is a factor-four improvement, and my screen reached $\lVert Z+\tfrac12H\rVert=0.499994$, so the intermediate estimate is attained and $\mu=\tfrac12$ is the best centring.
- **The mechanism is the record's own**, which is the strongest evidence for it: $\lVert\mathrm{Alt}(N_-)\rVert^2\le\tfrac14\lVert N\rVert^2$ is the same recentring, $\mathrm{Alt}(N_-)=\mathrm{Alt}(N_-+\tfrac12N)=\mathrm{Alt}(\tfrac12\lvert N\rvert)$, and it is what gives $\delta^2\le\tfrac14$ unconditionally. L140 is that identity differentiated, and [Lemma L141](../findings/second-order.md)(a) is it stated for a general base point.

### 1.7 The downstream dependency, screened

Not strictly my target, but the conclusion rests on it, so I screened [Lemma L136](../findings/route-a.md)'s two corrected identities on constructed objects ($N=12$, $E$ = coords $0$–$2$, $A$ = $3$–$5$, $K'$ = $6$–$11$, $X_2$ by Richardson from $t=4\cdot10^{-3}$ down to $5\cdot10^{-4}$):

- $\operatorname{tr}(\Pi_EX_2)=\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)$: predicted $0.020256$, measured $0.020271\to0.020256$ as $t\downarrow$. Sign **and** coefficient confirmed; with $B_{12}=B_{13}=0$ it returns $0$ to $5\times10^{-5}$.
- $\operatorname{tr}(\Pi_AX_2)-\sqrt6(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2)=\mathcal K$ came out **positive and convergent in all five trials** ($+0.111$, $+0.010$, $+0.117$, $+0.008$, $+0.030$), consistent with $\mathcal K\ge0$. And $2a\sqrt6=\tfrac23$, matching the boxed $-\tfrac23(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2)$ exactly.

So the cross term's **sign** (the thing that inverted last time), screens clean, and $\Delta_2\le\lVert g_1\rVert^2$ follows on $T_u\mathcal O^\perp$ as claimed. *This is a screen, not a proof of L136, which is still Gate 2 owed.*

---

## 2. Corrections required

### C1, "It uses no perturbation theory" is false, and this is the one place the lemma hides an import

The header says the lemma uses no perturbation theory. The entire content of $Z$ (the multiplier table and $Z_{KK}=D_-$), **is** the first-order perturbation expansion of $W\mapsto W_-$ at a point with a kernel. The statement's phrasing, "let $g_1=\mathrm{Alt}(\mathcal D_u[H]+D_-)$ **be** the first-order coefficient", asserts that identity rather than proving it; the proof of it is [Lemma L135](../findings/route-a.md)(c), which is Gate 2 owed. I re-derived it in §1.3 and it holds, so no number moves, but the previous chain died on assembly, and "no perturbation theory is used" is exactly the sentence under which an imported step goes unchecked.

**Correction.** State it as: *the bound is unconditional given $Z$; the identification of $Z$ as the first-order coefficient is [Lemma L135](../findings/route-a.md)(c), and the eigenvector tilt enters it as the cross-block multipliers $\Lambda_-\Lambda^{-1}=\operatorname{diag}(0,-1,-1)$ rather than as a separate term.* The last clause is the sentence that actually answers root cause (ii), and it is missing.

### C2, root cause (i) is still live in [Lemma L135](../findings/route-a.md)(c), the source of $g_1$

[Lemma L136](../findings/route-a.md) fixes $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$ and L140 uses $f(x)=\tfrac12(\lvert x\rvert-x)$ to match. But [Lemma L135](../findings/route-a.md)(c) (the lemma that *defines* $g_1=\mathrm{Alt}(\mathcal D_u[H]+D_-)$), writes, in its own text, "the line being affine, $W_-=\tfrac12(W-\lvert W\rvert)$ puts the entire second order into $\lvert W\rvert$". Under that convention its "$D_-$" is $-\tfrac12(\lvert D\rvert-D)$, the **negative** of L140's. **The exact sign collision that refuted L137–L139 is still in the record, in the definition L140 inherits.**

It changes no number here, $\lVert g_1\rVert^2$ is sign-invariant and the cross term is invariant under flipping $g_0$ and $g_2$ together, which is precisely why it survived. **Correction: repair L135(c) to $W_-=\tfrac12(\lvert W\rvert-W)$**, or have it quote [Lemma L136](../findings/route-a.md)'s convention paragraph, per [conventions.md](../findings/conventions.md)'s own rule that conventions are quoted and never restated.

### C3, [Lemma L138](../findings/route-a.md)'s surviving half states the multipliers with the opposite sign

L138 is withdrawn but the record says its structural halves stand: "the Daleckii–Krein multiplier at $u$ takes only the values $\{0,\tfrac13,1\}$". Positive. L140's table is $\{0,-\tfrac13,-1\}$, and §1.2 confirms the negative signs are the correct ones in the record's convention. **Three statements of the same table now sit in the record in two sign conventions.** Correction: delete or re-sign the L138 line.

### C4, "$A\subseteq\ker D$, so $D$ is singular there always" is false

[Lemma L136](../findings/route-a.md)'s surviving structural fact. From §1.3 the first-order coefficient of $\delta^2$ is $2\langle g_0,g_1\rangle=2a\big[\operatorname{tr}_E Z-\operatorname{tr}_A Z\big]=-2a\big[(B_{22}+B_{33})+\operatorname{tr}(\Pi_AD_-)\big]$, so $F(H)=(B_{22}+B_{33})+\operatorname{tr}(\Pi_AD_-)$, which independently confirms L136's convention paragraph. On the cone with $B_{22}+B_{33}=0$, $F=0$ forces $\operatorname{tr}(\Pi_AD_-)=0$ with $D_-\succeq0$, hence $\Pi_AD_-=0$: **$A$ lies in $D$'s nonnegative spectral subspace, not in its kernel.** Witness: $D=\varepsilon\Pi_A\oplus D'$ with $\varepsilon>0$ has $F=0$ and $A\cap\ker D=0$. Nothing in L140 depends on this, and L136 itself says so.

---

## 3. Does the conclusion overstate? Yes, in two ways, one of them unnamed

### O1, the headline

"I3 closes for every $n\ge12$" is the section title, and the boxed display ends "so I3 holds for every $n\ge12$". The qualifier "granting the remainder step [Lemma L134](../findings/route-a.md) still owes" carries the whole weight and appears once, after the box. What is proved is: **for each unit $H\in\{F=0\}\cap T_u\mathcal O^\perp$, the one-sided second-order coefficient of $\Phi$ is $\le-0.3755$.** I3 is a statement on a tube of positive radius. The gap is not cosmetic: $P$'s remainder is exactly $\sin^3t\,P(H)$ and uniform, but $\delta^2$'s comes off a Rellich branch whose radius depends on $H$, and $\delta^2$ has no third derivative at $u$. **Correction: retitle to what is proved**, "$\lVert g_1\rVert^2\le\tfrac14$, and I3's per-direction second-order coefficient is negative for every $n\ge12$", and move the caveat inside the box.

### O2, the near-cone regime, which no lemma in the chain names

[Lemma L134](../findings/route-a.md)(b) and [Lemma L136](../findings/route-a.md) both hold **on** $\{F=0\}$. Off it, $d^+\Phi=-2a\lvert\kappa_n\rvert F(H)<0$, so first order protects, but the margin is $O(F)\cdot t$ against a second-order term of size $O(t^2)$, so the admissible $t$ shrinks as $F\downarrow0$, and **[Lemma L136](../findings/route-a.md)'s $\Delta_2\le\lVert g_1\rVert^2$ is not established off the cone at all** (its proof consumes $B_{12}=B_{13}=0$ and the equality case). A tube of uniform radius needs the first- and second-order estimates run jointly on a neighbourhood of the cone, not on the cone and its complement separately. **This is a third gap, distinct from L134(d)'s orthogonality hypothesis and from the third-order remainder**, and it is currently unrecorded.

### O3, collateral, in [Lemma L141](../findings/second-order.md)

L141(a)'s hypothesis is "any tensor whose spectral parts are differentiable at it", which **excludes $u$**; its commentary then says the estimate "holds at the competitor, where the spectrum is degenerate, exactly as at the balanced product, and by the same three lines". It does not: at $u$ the $K\times K$ block has no multiplier and needs L140's separate $Z_{KK}+\tfrac12H_{KK}=\tfrac12\lvert D\rvert$ computation, a fourth line. Correction: either widen L141(a)'s hypothesis to cover a kernel by importing that fourth line, or drop the "by the same three lines" claim.

---

## 4. Vacuity audit

Asked of each finding, as the brief requires.

| finding | vacuous? |
| --- | --- |
| $\lVert g_1\rVert^2\le\tfrac14$ | No. A priori bound is $1$; $\tfrac14$ improves it fourfold, the intermediate estimate is attained ($0.499994$ in screen), and the set it quantifies over ($\{F=0\}\cap T_u\mathcal O^\perp$ downstream), contains the mixed/vector isotype, the open case. |
| $\mathcal K\ge0$ screen | No. $\mathcal K$ was nonzero in all five trials, so the inequality is not being confirmed on a family where the term vanishes, which is the failure mode [Lemma L136](../findings/route-a.md) itself records. |
| C2 (live convention collision) | Not vacuous as a record defect, **but it is currently harmless as mathematics**: $\lVert g_1\rVert^2$ and the cross term are both sign-invariant. Recorded as a repair, not as a refutation. |
| C4 ($A\subseteq\ker D$) | Not vacuous (there is an explicit witness) but nothing downstream consumes it. |
| O2 (near-cone gap) | Not vacuous: $\{F=0\}$ has positive codimension, so its neighbourhood is where almost every tube direction lives. |

---

## 5. Summary

**The mathematics of L140 is correct.** Every multiplier recomputes; $\mathrm{Alt}$ is the orthogonal projection in the record's own normalisation; $Z_{KK}=D_-$ is exact rather than leading-order; the Frobenius assembly is sound; the convention-immunity claim is true and true for the right reason; the arithmetic and the thresholds all check. The lemma is **immune to both root causes of the previous refutation**, (ii) because the eigenvector tilt is not a dropped term but is literally the cross-block multiplier $-1$, which I verified by an independent block-diagonalisation and by a numerical screen; (i) because the estimate is a recentring on the midpoint of a range of length one, which no sign choice moves.

**What must change is the framing, not the bound**: the "no perturbation theory" claim (C1) hides the one imported step; the source of $g_1$ still carries the opposite sign convention (C2); the multiplier table appears twice more in the record with a third sign (C3); one surviving structural fact is false (C4); and the headline claims a tube statement from a per-direction one, with a third gap (the near-cone regime (O2)) that no lemma in the chain currently names.

**Recommended record action.** Keep L140 with the boxed bound intact. Retitle. Apply C1–C4. Add O2 to [plan.md](../plan.md) beside the remainder constants.
