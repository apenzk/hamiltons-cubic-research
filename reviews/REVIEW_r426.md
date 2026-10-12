# Review r426, Lemma L136 and Lemma L137

*Adversarial audit, cold brief, 2026-09-03. Targets: [Lemma L136](../findings/route-a.md) and [Lemma L137](../findings/route-a.md) in [route-a.md](../findings/route-a.md), read against [Lemma L135](../findings/route-a.md), [Lemma L134](../findings/route-a.md), [Lemma L17](../findings/route-a.md) (canonical formula in [ATTEMPTS.md](../ATTEMPTS.md), line 825) and [Post F59](../findings/route-a.md).*

**Standing rule inherited and observed:** this programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). Everything below is derived by hand. One **screen** was run (seconds of compute on block matrices constructed for the purpose), to check the two perturbation identities I was about to record. It is reported as a screen and is not offered as evidence for any positive claim; the analytic derivation stands on its own and is given in full.

## Verdict

| claim | verdict |
| --- | --- |
| **L136(a)**, $\operatorname{tr}(\Pi_EX_2)=-\sqrt6[(CC^\top)_{22}+(CC^\top)_{33}]-\tfrac{\sqrt6}3[B_{12}^2+B_{13}^2]\le0$ | **REFUTED.** The $C$-term does not exist, and the $B$-term has the wrong sign. The true value is $+\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)\ \ge 0$. |
| **L136(b)**, $\operatorname{tr}(\Pi_AX_2)=-\operatorname{tr}(\Pi_A\mathcal E_D[C^\top\Lambda^{-1}C])$ | **REFUTED.** A second-order term $+\sqrt6(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2)$ is missing. Separately, $\mathcal E_D$ **never exists on $\{F=0\}$**. |
| **L136(c)**, the reduction | **REFUTED**, inherits (a) and (b). |
| **L137**, $\Delta_2\le\lVert g_1\rVert^2+\tfrac13\lVert c_1\rVert^2-\tfrac23(\lVert c_2\rVert^2+\lVert c_3\rVert^2)-\tfrac29(B_{12}^2+B_{13}^2)$ | **REFUTED.** Fails on the mixed/vector-isotype directions, which are precisely the open case the lemma exists to serve. |
| L137's Hansen–Pedersen step, its hypotheses, $\Pi_AH\Pi_A=0$ on $\{F=0\}$, $\Pi_A\le P_0$, the factors of $t$, $\Lambda^{-1}$, subadditivity of $X\mapsto\operatorname{tr}(X_+)$, the $2a$ arithmetic | **CONFIRMED**, each individually. |
| the direction in which $\rho$ enters the assembly | **REFUTED.** $\rho$ enters with a minus sign; the $+\tfrac13\lVert c_1\rVert^2$ term is spurious. |
| L137's padded-flat sharpness check | **CONFIRMED but empty**, every term the lemma adds is zero there. |
| L137's "one order lower reproduces L17's chain" | **PLAUSIBLE, overstated**, the compression supplies one of the chain's two ingredients. |

**A repaired lemma survives, and it is stronger than the one claimed**, see [the replacement](#the-replacement) below: on $\{F=0\}\cap T_u\mathcal O^\perp$ the cross term is **nonpositive outright**, so $\Delta_2\le\lVert g_1\rVert^2$, with no $\lVert c_1\rVert^2$ term to fight.

## 1. The convention collision that generates the sign errors

The record carries **two incompatible definitions of $W_-$**, and L136/L137 use one for the framing and the other for the values.

- [Lemma L135](../findings/route-a.md) states $W_-=\tfrac12(W-\lvert W\rvert)\preceq0$.
- $g_0=\mathrm{Alt}(u_-)=+a\star$ with $a=\tfrac1{3\sqrt6}>0$ and $\star=\Pi_{SD}-\Pi_{ASD}$ requires the **other** sign. With $u_-=\tfrac12(u-\lvert u\rvert)=-\tfrac1{\sqrt6}(\hat\omega_2\hat\omega_2^\top+\hat\omega_3\hat\omega_3^\top)$ and [r9](REVIEW_r9.md)'s hand identity $\mathrm{Alt}(\hat\omega_i\hat\omega_i^\top)=\tfrac16\star$, one gets $\mathrm{Alt}(u_-)=-\tfrac1{3\sqrt6}\star=-a\star$.

So the operative convention, the one under which $g_0=+a\star$, under which $\mathrm{Alt}(W_-)\vert_{\ker W}=-a\Pi_{ASD}$, and under which [Lemma L17](../findings/route-a.md)'s $d^+\delta^2(H)=-2aF(H)$ with $F\ge\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ge0$ comes out, is

$$W_-:=\tfrac12(\lvert W\rvert-W)\ \succeq\ 0 .$$

I verified this by recomputing the first order in it: $\operatorname{tr}(\Pi_EX_1)=-(H_{22}+H_{33})$ and $\operatorname{tr}(\Pi_AX_1)=\operatorname{tr}(\Pi_AD_-)$, so $\langle\star,X_1\rangle=-F(H)$ and $d^+\delta^2=2a\langle\star,X_1\rangle=-2aF(H)$, [L17](../findings/route-a.md) exactly. The opposite convention reproduces $d^+\delta^2$ too (both $g_0$ and $g_1$ flip), which is why the collision has survived: it is invisible at first order and only bites when a **one-sided inequality** is applied, as L137 does.

**Everything below is in the $W_-\succeq0$ convention**, and $X_2$ means the $t^2$-coefficient of $\tfrac12(\lvert u+tH\rvert-(u+tH))$. This is forced: the record writes $2\langle g_0,g_2\rangle=2a\langle\star,X_2\rangle$ with $g_0=a\star$, so its $X_2$ must be this one.

The identification the brief asks about is otherwise sound: $u$'s spectrum is $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$ and $0$ on $K$, so the nonzero eigenspace **is** the self-dual $3$-space, $\Pi_{SD}=\Pi_E$, $\Pi_{ASD}=\Pi_A\subset K$, and $\star=\Pi_E-\Pi_A$ extended by zero on $K\ominus A$. **CONFIRMED.**

## 2. L136(a), the error is that $\Pi_E$ is a fixed projection and the eigenvectors leave it

The proof's load-bearing sentence is *"$\operatorname{tr}(\Pi_EW_-(t))$ is the sum of the two eigenvalues continuing from $-\tfrac1{\sqrt6}$"*. That is **false at exactly the order the lemma works at**. $\Pi_E$ is fixed; the spectral projection $P_g(t)$ of the group tilts into $K$ by $O(t)$, so $\operatorname{tr}(\Pi_E\Pi_{\nu_i})=1-O(t^2)$, and multiplying by $\lvert\nu_i\rvert=O(1)$ leaves an omitted $O(t^2)$ term. This is the "conjugation by $I+O(t)$" contribution the brief asks about, and it is not mentioned in the proof.

**The eigenvalue arithmetic itself is right.** The trace of an isolated group is analytic (Kato), so the degenerate pair is no obstacle, and the second-order shift of the group's trace is
$$\underbrace{\frac{B_{12}^2+B_{13}^2}{\lambda_2-\lambda_1}}_{\lambda_2-\lambda_1=-3/\sqrt6}+\underbrace{\frac{(CC^\top)_{22}+(CC^\top)_{33}}{\lambda_2-0}}_{=-\sqrt6[\cdots]}\;=\;-\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)-\sqrt6\big[(CC^\top)_{22}+(CC^\top)_{33}\big],$$
the gap $3/\sqrt6$ and both coefficients as claimed, and both shifts downward. **CONFIRMED as a statement about eigenvalues.**

**The correction.** With $P^{(1)}=-(SHP^0+P^0HS)$, $S=\sum_{j\notin g}\Pi_j/(\lambda_j-\lambda_g)$ and $S\Pi_K=\sqrt6\,\Pi_K$,
$$\operatorname{tr}(\Pi_EWP_g)-\operatorname{tr}(WP_g)=-t\operatorname{tr}(\Pi_KHP_g)\ \Longrightarrow\ \text{$t^2$-coefficient }=-\operatorname{tr}(\Pi_KHP^{(1)})=+\sqrt6\big[(CC^\top)_{22}+(CC^\top)_{33}\big].$$
**The $C$-term cancels exactly.** The reason is structural: the level pushed against sits at $\lambda_j=0$, and for a group at $\lambda_g$ mixing with a level at $\lambda_j$ the change in *(eigenvalue) $\times$ (overlap retained)* is $-t^2\lvert H_{gj}\rvert^2\lambda_j/(\lambda_g-\lambda_j)^2$, which vanishes identically when $\lambda_j=0$. The $B_{1i}$ repulsion survives in full because $\hat\omega_1\in E$, tilting toward it loses no $E$-overlap.

Hence, with $W_-\succeq0$ so that the group contributes $-WP_g$,
$$\boxed{\ \operatorname{tr}(\Pi_EX_2)\;=\;+\tfrac{\sqrt6}3\big(B_{12}^2+B_{13}^2\big)\;\ge\;0\ }$$
$K$-branch eigenvalues contribute only at $O(t^3)$ (magnitude $O(t)$ times $E$-overlap $O(t^2)$), so nothing else enters.

**A two-line hand check that needs no machine.** Take $H$ with $B_{12}=b$ the only nonzero entry. The $(1,2)$ block has diagonal $(2/\sqrt6,\,-1/\sqrt6)$ and off-diagonal $tb$, so $\nu_2=-\tfrac1{\sqrt6}-\tfrac{\sqrt6}3t^2b^2$ and $\nu_3=-\tfrac1{\sqrt6}$. Every eigenvector stays self-dual and $\mathrm{Alt}(vv^\top)=\tfrac16\star$ for every unit self-dual $v$, so $\delta^2=\tfrac16(\lvert\nu_2\rvert+\lvert\nu_3\rvert)^2=\tfrac19+\tfrac29t^2b^2$. So $\Delta_2=+\tfrac29B_{12}^2$, while L136(a) and L137 assert $\Delta_2\le-\tfrac29B_{12}^2$. The sign is unambiguous.

**Equality case.** L136(a)'s *"equality exactly when $C$ has no component on $\hat\omega_2,\hat\omega_3$ and $B$ does not couple $\hat\omega_1$ to them"* is wrong on both halves: the true condition is $B_{12}=B_{13}=0$ alone, with $C$ unconstrained.

**And the commentary must be withdrawn.** *"Every direction with $C$ or $B$ coupling into $\hat\omega_2,\hat\omega_3$ makes $\Delta_2$ smaller"* and *"the hardest directions are the ones that couple least"* both invert the truth: $C$-coupling into $\hat\omega_2,\hat\omega_3$ is neutral in this branch, and $B$-coupling raises $\Delta_2$.

## 3. L136(b), a missing term, and an object that does not exist where it is used

**The missing term.** $\Pi_A\subset K$ is also fixed, and the *negative* members of the $E$-group leak into it. Since $\Pi_Au=0$, the whole of $\operatorname{tr}(\Pi_AWP_g)$ starts at order $t^2$:
$$\operatorname{tr}(\Pi_AWP_g)\big\vert_{t^2}=\operatorname{tr}(\Pi_AHP^{(1)})=-\sqrt6\big(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2\big),$$
so, with $W_-\succeq0$,
$$\boxed{\ \operatorname{tr}(\Pi_AX_2)\;=\;\mathcal K\;+\;\sqrt6\big(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2\big),\qquad \mathcal K:=\tfrac{d}{dt}\Big\vert_{0^+}\operatorname{tr}\big(\Pi_A(D-tC^\top\Lambda^{-1}C)_-\big).\ }$$
$\hat\omega_1$ contributes nothing, its eigenvalue being positive. L136(b) records only $\mathcal K$ (as $-\operatorname{tr}(\Pi_A\mathcal E_D[C^\top\Lambda^{-1}C])$). The Schur-complement sign on the $K$ side is right ($tD+t^2C^\top(z-\Lambda)^{-1}C\big\vert_{z\approx0}=t(D-tC^\top\Lambda^{-1}C)$), **CONFIRMED**, as is the degree-one homogeneity $(tD_s)_-=t(D_s)_-$.

**$\mathcal E_D$ does not exist on $\{F=0\}$, ever.** Unwinding [L17](../findings/route-a.md)'s equality case: $F=0$ forces $\operatorname{tr}(B_+)=\operatorname{tr}(B_-)=0$, hence $B=\Pi_AH\Pi_A=0$, and then $F=\operatorname{tr}(\Pi_AD_-)=0$. With $D_-\succeq0$ that gives $D_-\Pi_A=0$, so $A$ lies in $D$'s nonnegative spectral subspace with zero compression, i.e. $A\subseteq\ker D$. **So on $\{F=0\}$ the block $D$ is singular on $K$ with kernel of dimension at least $3$, always.** The record's own caveat *"the live obstacle remains that $\mathcal E_D$ exists only where $D$ is nonsingular on $K$"* is therefore not a caveat about a thin bad set: it voids the formula on the entire domain L136(c) and L137 apply it to. **Would this be true vacuously? Worse, it is the identity that is vacuous.**

The object is repairable: $t\mapsto\operatorname{tr}(\Pi_A(D-tM)_-)$ is piecewise-analytic, so the one-sided derivative $\mathcal K$ exists; what fails is the Daleckii–Krein Schur-multiplier *formula*, whose $(0,0)$ block needs $f'(0)$ for $f(x)=x\mathbf 1_{x<0}$, and that is exactly the jump. A correct expansion carries a **kink** term $\operatorname{tr}\big(\Pi_A(\Pi_{\ker D}(-M)\Pi_{\ker D})_-\big)$ alongside the multiplier part, the same structure L17 meets at $u$, one order up.

## 4. L137, the parts that hold

Taken one at a time, most of the machinery is sound.

- **Hansen–Pedersen.** The correct statement: for $f$ convex with $f(0)\le0$ and $A^*A\le1$, $\operatorname{tr}f(A^*XA)\le\operatorname{tr}(A^*f(X)A)$. With $A$ the isometric inclusion $A\hookrightarrow K$ and $f(x)=\max(-x,0)$ (convex, $f(0)=0 $), this is $\operatorname{tr}(\Pi_AN_-)\ge\operatorname{tr}((\Pi_AN\Pi_A)_-)$. **CONFIRMED, in the $W_-\succeq0$ convention only.** In L135's stated convention $f(x)=x\mathbf 1_{x<0}$ is *concave* and the inequality runs the other way. L137 states the convex-convention direction while evaluating in the concave-convention values; that hybrid is the mechanism of the error in §5.
- **$\Pi_A$ is a legitimate compression** and $\Pi_A\le P_0$ because $A\subset K=\ker u$, so $\Pi_AD\Pi_A=\Pi_AH\Pi_A$. **CONFIRMED.**
- **$\Pi_AH\Pi_A=0$ on $\{F=0\}$.** **CONFIRMED**, by the unwinding in §3.
- **The factors of $t$.** $(\Pi_AD_s\Pi_A)_-=(-t\Pi_AC^\top\Lambda^{-1}C\Pi_A)_-=t(-\Pi_AC^\top\Lambda^{-1}C\Pi_A)_-$ for $t>0$. **CONFIRMED.** The passage to a $t^2$-coefficient also silently needs $\operatorname{tr}(\Pi_AD_-)=0$, true on $\{F=0\}$, but unstated; it should be stated, since without it the argument gives nothing.
- **$\Lambda^{-1}=\sqrt6\operatorname{diag}(\tfrac12,-1,-1)$** and $C^\top\Lambda^{-1}C=\tfrac{\sqrt6}2c_1^\top c_1-\sqrt6(c_2^\top c_2+c_3^\top c_3)$. **CONFIRMED.** (The wording *"whose second group is positive semidefinite"* describes $c_2^\top c_2+c_3^\top c_3$, which enters with a minus sign; the sentence reads as if the summand were PSD. Cosmetic.)
- **$\rho\le\tfrac{\sqrt6}2\lVert\Pi_Ac_1^\top\rVert^2\le\tfrac{\sqrt6}2\lVert c_1\rVert^2$.** Subadditivity of $X\mapsto\operatorname{tr}(X_+)=\max_{0\preceq P\preceq I}\operatorname{tr}(PX)$ holds (a max of linear functionals is convex and positively homogeneous), the negative-semidefinite group has zero positive part, and a rank-one PSD term has trace equal to its squared norm. **CONFIRMED.**
- **The $2a$ arithmetic.** $2a=\tfrac2{3\sqrt6}$, so $2a\sqrt6=\tfrac23$, $2a\tfrac{\sqrt6}3=\tfrac29$, $2a\tfrac{\sqrt6}2=\tfrac13$. **CONFIRMED.**

- **The $E$-side Schur notation is ill-typed.** $C\Lambda^{-1}C^\top$ does not compose ($C$ is $3\times\dim K$, $\Lambda^{-1}$ is $3\times3$); the correct object is $C(z-tD)^{-1}C^\top\approx z^{-1}CC^\top$. The diagonal entries the proof then uses are the right ones, so this is notation rather than mathematics, but it should be fixed, because it is what makes the $E$- and $K$-side corrections look symmetric when they are not.

## 5. L137, where it breaks, and by how much

**Break 1, $\rho$ enters with the wrong sign.** In the $W_-\succeq0$ convention, $(-\Pi_AC^\top\Lambda^{-1}C\Pi_A)_-=(\Pi_AC^\top\Lambda^{-1}C\Pi_A)_+$, so Hansen–Pedersen gives $\operatorname{tr}(\Pi_A(D_s)_-)\ge t\rho$ with $\rho\ge0$, and since $\operatorname{tr}(\Pi_AD_-)=0$ on $\{F=0\}$,
$$\mathcal K\;\ge\;+\rho\qquad\text{hence}\qquad \operatorname{tr}(\Pi_AX_2)\;\ge\;+\rho .$$
L137 concludes $\operatorname{tr}(\Pi_AX_2)\ge-\rho$: it takes the inequality direction from the convex convention and the value $-\rho$ from the concave one. Because $\langle\star,X_2\rangle=\operatorname{tr}(\Pi_EX_2)-\operatorname{tr}(\Pi_AX_2)$, $\rho$ must be **subtracted**, and the term $+\tfrac13\lVert c_1\rVert^2$ is spurious. It is a positive term in an upper bound, so on its own it only weakens the statement, it is not what falsifies the lemma. But it is the whole of L137's closing narrative (*"only $\lVert c_1\rVert^2$ enters with a positive sign"*, *"a direction whose weight sits in $c_1$ has correspondingly little left"*), and that narrative is empty.

**Break 2, the $\lVert c_2\rVert^2,\lVert c_3\rVert^2$ term is too strong, and this is fatal.** Combining §2 and §3,
$$\langle\star,X_2\rangle\;=\;\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)\;-\;\mathcal K\;-\;\sqrt6\big(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2\big).$$
The negative $C$-contribution is governed by $\Pi_Ac_i^\top$ (the part of the coupling that lands in the **anti-self-dual** $3$-space), not by the full row norms. L137 claims the full norms. Since $\lVert\Pi_Ac_i^\top\rVert\le\lVert c_i\rVert$ with equality only when $c_i\subset A$, the claimed bound is strictly stronger than the truth whenever $C$ reaches into $K\ominus A$.

**Break 3, the $B$ term.** $-\tfrac29(B_{12}^2+B_{13}^2)$ should be $+\tfrac29(B_{12}^2+B_{13}^2)$. **But it is vacuous on the stated domain.** For $X\in\mathfrak{su}(2)_+\subset\mathfrak{so}(4)$, $[X,u]$ is supported on $S^2(E)$ and equals $[X_{EE},\Lambda]$, whose entries are $(\lambda_j-\lambda_i)X_{ij}$, nonzero exactly at $(1,2)$ and $(1,3)$. So $T_u\mathcal O\supset\mathrm{span}\{\hat\omega_1\odot\hat\omega_2,\hat\omega_1\odot\hat\omega_3\}$ and **$H\perp T_u\mathcal O$ forces $B_{12}=B_{13}=0$**. The term the lemma displays is identically zero on $\{F=0\}\cap T_u\mathcal O^\perp$, so its sign error costs the bound nothing, and its presence in the statement is misleading, since it advertises a mechanism that cannot fire.

### The refuting family, and it is the open case

Take $H$ in the **vector (mixed) isotype** of $\mathcal W_n$ under $SO(4)\times SO(n-4)$ (exactly one index in $\mathbb R^{n-4}$) and inside it the $SU(2)_+$-type piece whose $\Lambda^2\mathbb R^4$ leg is self-dual (the $(4,2)\otimes\mathbb R^{n-4}$ summand of $\Lambda^2_\pm\otimes\mathbb R^4\otimes\mathbb R^{n-4}$). Then:

- $B=0$, so $H_{22}+H_{33}=0$;
- $C$ is supported on $\mathbb R^4\wedge\mathbb R^{n-4}\subset K\ominus A$, so $\Pi_Ac_i^\top=0$ for every $i$;
- the $\Lambda^2_-\to$ mixed block of $D$ vanishes, so $\Pi_AD=0$, hence $\operatorname{tr}(\Pi_AD_-)=0$ and $\Pi_AH\Pi_A=0$;
- therefore $F(H)=0$, so $H\in\{F=0\}$;
- $H\perp u$ and $H\perp T_u\mathcal O$ by Schur: the orbit's vector-isotype tangents come from $X\in\mathbb R^4\otimes\mathbb R^{n-4}$ and carry $SO(4)$-type $(2,2)$, distinct from $(4,2)$.

On this family $\Pi_AM=0$ for $M=C^\top\Lambda^{-1}C$, so every $A$-entry of $M$ vanishes in $D$'s eigenbasis and both the multiplier part and the kink part of the directional derivative have zero $A$-block: $\mathcal K=0$. Hence
$$\langle\star,X_2\rangle=0,\qquad \Delta_2=\lVert g_1\rVert^2\quad\text{exactly},$$
while L137 asserts $\Delta_2\le\lVert g_1\rVert^2+\tfrac13\lVert c_1\rVert^2-\tfrac23(\lVert c_2\rVert^2+\lVert c_3\rVert^2)$. The bound is violated whenever $2(\lVert c_2\rVert^2+\lVert c_3\rVert^2)>\lVert c_1\rVert^2$, which is the generic situation in an $SU(2)_+$-invariant space of $C$'s (mass spread over the three rows gives a ratio near $4$). **L137 REFUTED.**

**This is not a vacuous refutation.** The family is the mixed/vector isotype, the one [L134](../findings/route-a.md) and [L135](../findings/route-a.md) both name as the *only* remaining open class, the padded flat and the hyper-Kähler class already being closed. L137 fails precisely where it was needed.

## 6. The two checks L137 offers

- **The padded flat is not circular, but it is empty.** There $B=0$, $C=0$ and $H$ has disjoint index support from $u$, so *every* term the lemma adds is zero and the bound degenerates to $\Delta_2\le\lVert g_1\rVert^2$, which [L135](../findings/route-a.md) gives independently. A check that switches off all three of the lemma's new terms cannot detect an error in any of them, and indeed it detects none of the three found here. The claim *"nothing was thrown away on the one family where the answer is known"* is true and carries no information about the family that matters.
- **"One order lower reproduces L17's chain" is overstated.** The compression supplies only $\operatorname{tr}(\Pi_AD_-)\ge\operatorname{tr}(B_-)$. L17's chain $F\ge\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)$ additionally needs the first Bianchi balance $\langle H,\star\rangle=0$ together with unit-norm tangency $2H_{11}=H_{22}+H_{33}$, giving $H_{22}+H_{33}=\tfrac23\operatorname{tr}(B)$, an input with no analogue at second order. The sentence should say the *compression* is used inside its recorded domain, which is true, rather than that the chain is reproduced.

## 7. Scope

Both lemmas are stated for $H$ of unit norm; L136 inherits L135's domain $H\in T_uS$, L137 restricts to $\{F=0\}\cap T_u\mathcal O^\perp$. Two mismatches:

- **L136 is stated on all of $T_uS$ but its part (b) is only ever meaningful off $\{F=0\}$**, where the record does not need it; on $\{F=0\}$, where L136(c) and L137 consume it, $\mathcal E_D$ does not exist (§3). The lemma should carry its domain explicitly and replace $\mathcal E_D$ by the one-sided directional derivative with its kink term.
- **L137 uses $\{F=0\}$ twice but declares it once.** Beyond $\Pi_AH\Pi_A=0$ it also needs $\operatorname{tr}(\Pi_AD_-)=0$ for the $t^2$-coefficient extraction. Both follow from $F=0$; only the first is stated.
- $T_u\mathcal O^\perp$ is used nowhere in L137's proof, and its only effect is to annihilate the $B$-term the lemma displays.

## <a id="the-replacement"></a>8. The replacement

Everything above assembles into a correct lemma, and it is cleaner than the one it replaces.

> **On $\{F=0\}\cap T_u\mathcal O^\perp$, with $W_-=\tfrac12(\lvert W\rvert-W)$ and $g_0=a\star$:**
> $$\operatorname{tr}(\Pi_EX_2)=\tfrac{\sqrt6}3\big(B_{12}^2+B_{13}^2\big)=0,\qquad \operatorname{tr}(\Pi_AX_2)=\mathcal K+\sqrt6\big(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2\big),\qquad \mathcal K\ge\rho\ge0,$$
> **hence the cross term is nonpositive and**
> $$\Delta_2\;\le\;\lVert g_1\rVert^2\;-\;\tfrac23\big(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2\big)\;\le\;\lVert g_1\rVert^2 .$$
> Off $T_u\mathcal O^\perp$ the same argument gives $\Delta_2\le\lVert g_1\rVert^2+\tfrac29(B_{12}^2+B_{13}^2)-\tfrac23(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2)$.

**What this changes for [L16$\beta$](../plan.md).** The reduction is now $\lVert g_1\rVert^2\le\tfrac14+\tfrac23(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2)$, i.e. essentially $\lVert g_1\rVert^2\le\tfrac14$, a bound on the first-order defect derivative alone, with no $\lVert c_1\rVert^2$ obstruction and no spectral perturbation theory left. It is a *better* position than L137's, because the crude $\lVert g_1\rVert\le1$ now has to be improved by a factor $2$ rather than beaten against a competing positive term. It is also a *harder* position than L137 advertised, because the helpful $-\tfrac23(\lVert c_2\rVert^2+\lVert c_3\rVert^2)$ shrinks to its anti-self-dual part, which vanishes on the open family.

## 9. The screen

Reported as a screen, on block matrices built for this purpose ($\dim E=3$, $\dim K=6$, $\dim A=3$, $\Lambda=\tfrac1{\sqrt6}\operatorname{diag}(2,-1,-1)$, random symmetric $B$, $C$, $D$, unit-normalised $H$), fitting the $t^2$-coefficient of $\operatorname{tr}(\Pi\,\tfrac12(\lvert u+tH\rvert-(u+tH)))$ over $t\in[0.002,0.016]$. They are **not** Weyl tensors; the screen tests the perturbation identities of §2 and §3 and nothing else, and the admissibility argument of §5 is analytic.

- $\operatorname{tr}(\Pi_EX_2)$: fitted matches $+\tfrac{\sqrt6}3(B_{12}^2+B_{13}^2)$ to $10^{-8}$ on every sample; L136(a)'s expression differs by one to two orders of magnitude and by sign.
- $\operatorname{tr}(\Pi_AX_2)$: fitted matches $\mathcal K+\sqrt6(\lVert\Pi_Ac_2^\top\rVert^2+\lVert\Pi_Ac_3^\top\rVert^2)$ to $10^{-8}$; L136(b)'s $\mathcal K$ alone does not.
- On $\{F=0\}$-type samples ($\Pi_AD=0$) the Hansen–Pedersen margin $\mathcal K-\rho$ was $\ge0$ on every sample, tight to $10^{-4}$, confirming the $+\rho$ direction of §5.
- On the refuting configuration ($\Pi_AD=0$, $C$ supported off $A$): $\langle\star,X_2\rangle$ fitted to $0$ within $4\times10^{-7}$, against L137's asserted upper bound of $-0.37$ to $-1.00$ on the same samples.

The first-order identities $\operatorname{tr}(\Pi_EX_1)=-(H_{22}+H_{33})$ and $\operatorname{tr}(\Pi_AX_1)=\operatorname{tr}(\Pi_AD_-)$ came out on every sample, which is the check that the convention of §1 is the record's own.
