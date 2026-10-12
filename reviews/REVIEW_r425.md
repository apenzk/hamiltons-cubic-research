# Review r425, Lemma L136 and Lemma L137 (adversarial)

*Reviewer r425, 2026-09-03, cold brief. Target: [Lemma L136](../findings/route-a.md) and [Lemma L137](../findings/route-a.md) in [route-a.md](../findings/route-a.md), read against [Lemma L135](../findings/route-a.md), [Lemma L134](../findings/route-a.md), [Lemma L17](../findings/route-a.md) and [Post F59](../findings/route-a.md). Standing rule inherited: analysis only. The one numerical run below is a **screen** of claims stated here, on matrices built for that purpose, and is reported as a screen; every verdict rests on the derivation beside it.*

## Verdict table

| Claim | Verdict |
| --- | --- |
| L136, $\Pi_{SD}=\Pi_E$, $\star=\Pi_{SD}-\Pi_{ASD}$ | **CONFIRMED** |
| L136(a) (closed form for $\operatorname{tr}(\Pi_EX_2)$ | **REFUTED**), the $CC^\top$ term is spurious, and the sign as used in the cross term is inverted |
| L136(a) ("$\le0$, and the self-dual branch works for the bound" | **REFUTED**), the true self-dual contribution to $\Delta_2$ is $+\tfrac29(B_{12}^2+B_{13}^2)\ge0$, and it is identically zero on the lemma's own domain |
| L136(b), $\operatorname{tr}(\Pi_AX_2)=-\operatorname{tr}(\Pi_A\mathcal E_D[C^\top\Lambda^{-1}C])$ | **REFUTED**, omits the $E$-branch eigenvector tilt into $A$, and $\mathcal E_D$ exists nowhere on $\{F=0\}$ |
| L136(c) (the reduction | **REFUTED**), inherits both sign defects |
| L137 (the boxed bound | **REFUTED**), all three coefficients are wrong: sign, sign, and support |
| L137, Hansen–Pedersen statement as written | **CONFIRMED**, under the convention $N_-\succeq0$; **FALSE** under the convention [Lemma L135](../findings/route-a.md)(c) declares |
| L137, $\Pi_A\le P_0$, $\Pi_AD\Pi_A=\Pi_AH\Pi_A$, $\Pi_AH\Pi_A=0$ on $\{F=0\}$ | **CONFIRMED**, and strengthened: $\{F=0\}$ forces $A\subseteq\ker D$ |
| L137 (the homogeneity / order-matching step | **PLAUSIBLE as written, CONFIRMED once repaired**), it needs the $t^1$ coefficients to agree, which only the *full* $\{F=0\}$ supplies |
| L137, subadditivity, $\Lambda^{-1}$, dropping the PSD group, the $2a$ arithmetic | **CONFIRMED** as inequalities, but used in the direction that is not needed |
| L137 (the padded-flat sharpness check | **VACUOUS**), every disputed coefficient vanishes there |
| L137 (the "one order lower reproduces L17" check | **CONFIRMED but inert**), it cannot see a second-order sign error, and it renames $B$ |

## 1. The one identification that survives

$u=W_{\mathbb{CP}^2}$ has spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on $\Lambda^2_+(\mathbb R^4)$ and $W^-=0$, so $u$'s nonzero eigenspace **is** the self-dual $3$-space and $\Pi_{SD}=\Pi_E$, $\Pi_{ASD}=\Pi_A\subset K$. With $\star$ the Hodge star of the distinguished $\mathbb R^4$ extended by zero, $\star=\Pi_E-\Pi_A$ and $\lVert\star\rVert^2=6$. Consistency check that pins the normalisation of $\mathrm{Alt}$: $\mathrm{Alt}(M)=\tfrac16\langle M,\star\rangle\star$ on that block reproduces both $\lvert a\rvert=\tfrac1{3\sqrt6}$ and $\delta^2(u)=6a^2=\tfrac19$, and reproduces [Lemma L17](../findings/route-a.md)'s smooth branch $-2a(H_{22}+H_{33})$. This part of the setting is sound.

## 2. The sign convention is split across the lemma chain, and the split is load-bearing

Two conventions for the negative part are in use:

- **(N)** $W_-=\tfrac12(W-\lvert W\rvert)\preceq0$, declared verbatim in [Lemma L135](../findings/route-a.md)(c), and used in L136(a)'s proof, which reads $\operatorname{tr}(\Pi_EW_-)$ as "**the sum** of the two eigenvalues continuing from $-\tfrac1{\sqrt6}$".
- **(P)** $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, required by $g_0=a\star$ with $a=+\tfrac1{3\sqrt6}$, since $\mathrm{Alt}(u_-^{(N)})=\tfrac16\langle u_-^{(N)},\star\rangle\star=-a\star$.

The cross term $2\langle g_0,g_2\rangle$ is itself convention-free, because $g_0$ and $X_2$ flip together. What is **not** free is the record's assembled formula. In (P) the chain $2\langle g_0,g_2\rangle=2a\langle\star,X_2\rangle=2a[\operatorname{tr}(\Pi_EX_2)-\operatorname{tr}(\Pi_AX_2)]$ is correct; in (N) the correct chain is $-2a[\operatorname{tr}(\Pi_EX_2)-\operatorname{tr}(\Pi_AX_2)]$. **L136 computes $\operatorname{tr}(\Pi_EX_2)$ in (N) and feeds it to the (P) formula**, so the entire self-dual branch enters $\Delta_2$ with the wrong sign. The same split shows in [Lemma L135](../findings/route-a.md)(c), whose $2a\langle\star,X_2\rangle=-a\langle\star,Y_2\rangle$ is a (N) identity paired with a (P) value of $g_0$.

**The elementary witness.** Take $H$ with $B_{12}=B_{21}=\beta$ and nothing else. Then $\lambda_2$ is repelled *downwards* by $-\tfrac{\sqrt6}{3}\beta^2t^2$, the negative part therefore *grows*, and

$$\delta^2(t)=\tfrac16\Big(\tfrac2{\sqrt6}+\tfrac{\sqrt6}3t^2\beta^2\Big)^2+O(t^4)=\tfrac19+\tfrac29\beta^2t^2+O(t^4),$$

so $\Delta_2=+\tfrac29\beta^2$. [Lemma L137](../findings/route-a.md) states $-\tfrac29(B_{12}^2+B_{13}^2)$. The sign is inverted, and the mechanism is not subtle: deepening a negative eigenvalue increases the defect.

## 3. L136(a), the $CC^\top$ term does not exist

Three separate defects.

**(i) The displayed effective operator is ill-typed.** $C=H_{EK}$ is $3\times\dim K$ and $\Lambda^{-1}$ is $3\times3$, so "$\Lambda+tB+t^2C\Lambda^{-1}C^\top$" is not conformable. The correct Feshbach $E$-block at energy $z$ is $\Lambda+tB+t^2C(z-tD)^{-1}C^\top=\Lambda+tB+t^2z^{-1}CC^\top+O(t^3)$, and the trace the proof actually extracts, $\big[(CC^\top)_{22}+(CC^\top)_{33}\big]/(-1/\sqrt6)$, is the right reading of that. So the coefficient $-\sqrt6$ is what degenerate perturbation theory gives **for the eigenvalue sum**, and the Schur sign is right: the $K$-block sits at $0$ and $\lambda_{2,3}<0$, so the shift is negative.

**(ii) The "trace of the group" argument is valid, and it is not the quantity wanted.** The sum of the two eigenvalues continuing from $-\tfrac1{\sqrt6}$ equals $\operatorname{tr}\!\big(W(t)P_{23}(t)\big)$ with $P_{23}$ the Riesz projection, analytic through the degeneracy, so no multiplicity-lifting hypothesis is needed. But $\operatorname{tr}(\Pi_EW_-)$ uses the **fixed** projection $\Pi_E$, and $\operatorname{tr}(\Pi_EW_-)=\operatorname{tr}(W P_{23})-\operatorname{tr}(\Pi_KWP_{23})$. The subtracted term is exactly the contribution the proof does not mention (the conjugation by $I+O(t)$ that the brief asks about) and at order $t^2$ it is

$$\operatorname{tr}(\Pi_KWP_{23})\big|_{t^2}=\sum_{i=2,3}\sum_{k\in K}\frac{C_{ik}^2}{\lambda_i}=-\sqrt6\big[(CC^\top)_{22}+(CC^\top)_{33}\big],$$

**identical to the Schur term**. Hence

$$\boxed{\ \operatorname{tr}(\Pi_EX_2^{(N)})=-\tfrac{\sqrt6}{3}\big(B_{12}^2+B_{13}^2\big)\ }$$

with no $C$ at all. The cancellation is structural, not accidental: for a level at $\lambda_j$ the repulsion shift $V_{ij}^2/(\lambda_i-\lambda_j)$ and the weight loss $\lambda_iV_{ij}^2/(\lambda_i-\lambda_j)^2$ combine to $\frac{V_{ij}^2}{\lambda_i-\lambda_j}\cdot\frac{-\lambda_j}{\lambda_i-\lambda_j}$, which vanishes identically when $\lambda_j=0$, and the whole of $K$ sits at $0$. The $B_{12},B_{13}$ term survives only because its partner $\hat\omega_1$ lies inside $E$, where $\Pi_E$ sees no loss.

**(iii) The surviving term is zero on the lemma's own domain.** For $A\in\mathfrak{so}(4)$ in the self-dual $\mathfrak{su}(2)$, the orbit tangent $[\hat A,u]$ is supported in $E$ with entries $(\lambda_j-\lambda_i)\hat A_{ij}$, so $\langle H,[\hat A,u]\rangle=2(\lambda_2-\lambda_1)B_{12}\hat A_{12}$ and $\lambda_2-\lambda_1=-\tfrac3{\sqrt6}\ne0$. **$H\perp T_u\mathcal O$ therefore forces $B_{12}=B_{13}=0$** ($B_{23}$ is unconstrained, the eigenvalues being equal). Asked of the brief's test, *would this be true vacuously?*, L136(a) is: on $\{F=0\}\cap T_u\mathcal O^\perp$ its right-hand side is identically $0$, so both the inequality "$\le0$" and the stated equality case ("exactly when $C$ has no component on $\hat\omega_2,\hat\omega_3$ and $B$ does not couple $\hat\omega_1$ to them") are empty. Adding [Lemma L17](../findings/route-a.md)'s Bianchi-plus-tangency balance, $H_{EE}$ on that set is the single traceless block $\operatorname{diag}$-free $\{2,3\}$ pair: $B_{11}=0$, $B_{33}=-B_{22}$, $B_{12}=B_{13}=0$.

## 4. L136(b), one term is missing and the instrument is undefined where it is used

The $K$-side is right as far as it goes: the Feshbach $K$-block is $tD-t^2C^\top\Lambda^{-1}C+O(t^3)$ (this one **is** conformable, and the sign is right, $(z-\Lambda)^{-1}\approx-\Lambda^{-1}$), and $(tD_s)_-=t(D_s)_-$ by positive homogeneity. What is missing is that $\Pi_A$ also sees the **self-dual branch**: the eigenvectors continuing from $-\tfrac1{\sqrt6}$ tilt into $K$, and the part of that tilt landing in $A$ carries eigenvalue $\lambda_i$ with it. That contributes $\sum_{i=2,3}\lambda_i\cdot\lVert\Pi_Ac_i^\top\rVert^2/\lambda_i^2$, so the correct statement is

$$\operatorname{tr}(\Pi_AX_2^{(N)})=-\sqrt6\big(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2\big)\;+\;\big[t^2\big]\,t\operatorname{tr}\big(\Pi_A(D_s)_-\big).$$

A coincidence worth naming, because it is what let the error survive: $2a\sqrt6=\tfrac23$, so the record's spurious self-dual $C$-term and this genuine anti-self-dual one carry the **same numerical coefficient**. They differ in support ($\lVert c_i\rVert^2$ against $\lVert\Pi_Ac_i\rVert^2$) and for any direction whose $c_2,c_3$ reach outside the distinguished $4$-plane the record over-counts.

**And $\mathcal E_D$ does not exist on $\{F=0\}$.** [Lemma L17](../findings/route-a.md)'s equality case is $\Pi_AH\Pi_A=0$ *together with* $\operatorname{tr}(\Pi_AD_-)=0$; the second gives $\Pi_AD_-=0$ (trace of a product of positive semidefinite operators), so for $v\in A$, $Dv=D_+v$ and $\langle D_+v,v\rangle=0$, whence $D_+v=0$. **Therefore $A\subseteq\ker D$ on the whole of $\{F=0\}$**, and $D$ is singular on $K$ at every point of the set. The lemma names the non-existence of $\mathcal E_D$ at singular $D$ as "the live obstacle"; the sharper statement is that the obstacle is total, the representation in (b) is empty on its own domain, and the correct object is the negative part compressed to $\ker D$.

## 5. L137, the boxed bound is false

**The instrument.** In Hansen–Pedersen form, for $f$ convex on an interval containing $0$ with $f(0)\le0$ and $A$ a contraction, $\operatorname{tr}f(A^*XA)\le\operatorname{tr}A^*f(X)A$. With $f(x)=\max(-x,0)$ (convex, $f(0)=0$) and the orthogonal projection $\Pi_A$, this is exactly $\operatorname{tr}(\Pi_AN_-)\ge\operatorname{tr}\big((\Pi_AN\Pi_A)_-\big)$ **in convention (P)**. In convention (N) the function is $\min(x,0)$, which is *concave*, and the inequality runs the other way. So the statement as written in L137 is true, and true only under the convention L135(c) does not use. $\Pi_A\le P_0$ holds because $A\subseteq\ker u$, and $\Pi_AD\Pi_A=\Pi_AH\Pi_A$ follows; both are correct.

**The homogeneity step needs more than it claims.** $\operatorname{tr}(\Pi_A(D_s)_-)\ge\operatorname{tr}((\Pi_AD_s\Pi_A)_-)$ is an inequality between functions of $t$; reading off $t^2$ coefficients is licensed only when the $t^0$ and $t^1$ coefficients agree. Here the $t^1$ coefficients are $\operatorname{tr}(\Pi_AD_-)$ on the left and $0$ on the right. The proof cites only $\Pi_AH\Pi_A=0$, which does **not** give that. It is rescued by the other half of L17's equality case, $\operatorname{tr}(\Pi_AD_-)=0$, which the lemma mentions in passing and then does not use. A screen on directions satisfying only $\Pi_AH\Pi_A=0$ breaks the step outright; on the full $\{F=0\}$ it holds. **Repairable, and the repair belongs in the proof.**

**The positive-part bound is correct and is not the bound needed.** $X\mapsto\operatorname{tr}(X_+)=\max_{0\preceq P\preceq I}\operatorname{tr}(PX)$ is a supremum of linear functionals, hence subadditive; $(-Y)_+=0$ for $Y\succeq0$, so dropping $-\sqrt6(c_2^\top c_2+c_3^\top c_3)$ is legitimate; $\Lambda^{-1}=\sqrt6\operatorname{diag}(\tfrac12,-1,-1)$ is right, as is $C^\top\Lambda^{-1}C=\tfrac{\sqrt6}2c_1^\top c_1-\sqrt6(c_2^\top c_2+c_3^\top c_3)$; and $\rho\le\tfrac{\sqrt6}2\lVert\Pi_Ac_1^\top\rVert^2\le\tfrac{\sqrt6}2\lVert c_1\rVert^2$ is correct. The $2a$ arithmetic is correct too: $2a\sqrt6=\tfrac23$, $2a\tfrac{\sqrt6}3=\tfrac29$, $2a\tfrac{\sqrt6}2=\tfrac13$. **But with the signs fixed, $\rho$ enters $\Delta_2$ as $-2a\rho\le0$, so what is wanted is a lower bound on $\rho$, and $\rho\ge0$ already supplies it.** An upper bound on $\rho$ does no work.

**The correct statement.** Assembling §3, §4 and Hansen–Pedersen on the full $\{F=0\}$:

$$\Delta_2\;\le\;\lVert g_1\rVert^2\;+\;\tfrac29\big(B_{12}^2+B_{13}^2\big)\;-\;\tfrac23\big(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2\big)\;-\;\tfrac2{3\sqrt6}\rho ,$$

and on $\{F=0\}\cap T_u\mathcal O^\perp$ the $B$ term vanishes by §3(iii), leaving

$$\Delta_2\;\le\;\lVert g_1\rVert^2-\tfrac23\big(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2\big)-\tfrac2{3\sqrt6}\rho\;\le\;\lVert g_1\rVert^2 .$$

Term by term against the boxed claim: $+\tfrac13\lVert c_1\rVert^2$ should be $-\tfrac2{3\sqrt6}\rho\le0$, of magnitude at most $\tfrac13\lVert\Pi_Ac_1\rVert^2$, **the right size with the wrong sign**; $-\tfrac23(\lVert c_2\rVert^2+\lVert c_3\rVert^2)$ should be $-\tfrac23(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2)$, i.e. strictly weaker; $-\tfrac29(B_{12}^2+B_{13}^2)$ should be $+\tfrac29(B_{12}^2+B_{13}^2)$, and is zero on the domain either way. **The headline ("only $\lVert c_1\rVert^2$ enters with a positive sign"), is exactly inverted: $c_1$ is the one block that can only help, and the residual obligation the lemma hands to its successor is built on it.**

## 6. The two checks

**The padded flat is vacuous as a check.** There $B=0$ and $C=0$, so all three disputed coefficients multiply zero and both the record's bound and the corrected one collapse to $\Delta_2\le\lVert g_1\rVert^2=\delta^2(H)$. It is not circular, it does test the $\lVert g_1\rVert^2$ term against [Lemma L135](../findings/route-a.md)'s independent evaluation, but it discriminates nothing about the cross term, which is the whole content of L136 and L137. A check that cannot fail on the family it is run on is not evidence for the coefficients.

**The first-order check is inert.** "The same compression one order lower reproduces L17's chain" is a restatement of L17's own proof, and it is true; but a first-order identity cannot detect a sign that enters only at second order, the smooth branch's derivative $-2a(H_{22}+H_{33})$ is convention-free in a way $\operatorname{tr}(\Pi_EX_2)$ is not. It also silently renames: the "$B$" in $F\ge\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)$ is $\Pi_AH\Pi_A$, while the "$B$" of L136/L137 is $H_{EE}$. Two different objects under one letter inside a single lemma.

## 7. Scope

Everything is stated on $\{F=0\}\cap T_u\mathcal O^\perp$, and the set is used at less than its strength and at one point beyond it:

- **Used correctly**: $\Pi_AH\Pi_A=0$.
- **Available and not used, though needed**: $\operatorname{tr}(\Pi_AD_-)=0$, without which the order-matching in the homogeneity step fails (§5).
- **Available and not used, and it changes the picture**: $A\subseteq\ker D$, which voids the $\mathcal E_D$ representation (§4); $B_{12}=B_{13}=0$ from orbit-orthogonality, which voids L136(a) (§3); and $B_{11}=0$, $B_{33}=-B_{22}$ from Bianchi-plus-tangency, which leaves $H_{EE}$ two free entries.

Nothing in either lemma needs more than the stated set. The failures are of derivation, not of hypothesis.

## 8. Screen

*Reported as a screen of the claims above, not as evidence for them.* A synthetic symmetric operator on $\mathbb R^{3}\oplus\mathbb R^{3}\oplus\mathbb R^{4}$ modelling $E\oplus A\oplus(K\setminus A)$, with $u=\tfrac1{\sqrt6}\operatorname{diag}(2,-1,-1,0,\dots)$ and $\star=\operatorname{diag}(1,1,1,-1,-1,-1,0,\dots)$, and the cross term read off as the $t^2$-coefficient of $\tfrac16\langle W(t)_-,\star\rangle^2$ minus $\lVert g_1^{\parallel}\rVert^2$. The L136/L137 claims are claims about an arbitrary symmetric $H$ in blocks, so the model is faithful to them; it does not impose the Weyl constraint, which is why the report's refutations are stated as derivations and the screen only agrees with them.

- §3's corrected $\operatorname{tr}(\Pi_EX_2)$ and §4's corrected $\operatorname{tr}(\Pi_AX_2)$ reproduced the cross term on every sample to $3\times10^{-6}$ (finite-difference truncation); the record's version disagreed by up to a factor of seven.
- On the pure-$B_{12}$ direction: truth $+0.0200$, record $-0.0200$.
- On $c_2$ pointing into $K\setminus A$: truth $0$, record $-0.1067$.
- On $c_1$ pointing into $A$: truth $-0.0533$, record $+0.0533$, the sign inversion of §5, at the predicted magnitude $\tfrac13\lVert\Pi_Ac_1\rVert^2$.
- On directions satisfying the full $\{F=0\}$ ($A\subseteq\ker D$): the corrected bound held on all $14$ samples, at equality to $5\times10^{-5}$; the record's boxed right-hand side was violated on $10$ of them.

## 9. Downstream

[Lemma L138](../findings/route-a.md)(c) carries L137's $+\tfrac13\lVert c_1\rVert^2$ forward and cancels its $-\tfrac29(B_{12}^2+B_{13}^2)$ against a $\tfrac19$ from the divided differences, and [Lemma L139](../findings/route-a.md)(c) draws the range $12\le n\le31$ from the resulting $\Delta_2\le\tfrac23$. Two corrections propagate. The $c_1$ term should be **dropped, not added**, which improves that chain, since [Lemma L138](../findings/route-a.md)(a) already shows $c_1$ contributes nothing to $Z$. The $-\tfrac23$ discount, however, applies only to $\lVert\Pi_Ac_i\rVert^2$, so the $E\times K'$ family loses it entirely and L138(c)'s $\tfrac43$ becomes $2$, paying $1$ per unit of norm budget rather than $\tfrac23$. **L139(c)'s dimension range therefore does not follow as written and needs rederiving.** Both are outside this brief and are flagged, not adjudicated.
