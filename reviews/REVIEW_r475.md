# REVIEW r475, Lemma L17, first-order protection at the rival maximizer

**Verdict: CONFIRMED as an inequality, REFUTED as stated in two places.** The mechanism is sound and I re-derived it independently from the record's convention file and from [Lemma L134](../findings/route-a.md)'s block expansion, without reading the notebook first; it then matched [ATTEMPTS.md](../ATTEMPTS.md) Result 6 line for line. What fails is the *statement*: the canonical block carries no statement and no proof, the canon entry drops the dimension hypothesis, and the equality-case list is not the equality set.

Prior status: [INDEX-results.md](../findings/INDEX-results.md) row 17, *"Gate 2: no verdict on the record."* This is the first adversarial verdict on L17.

---

## 1. What L17 actually is, reconstructed

*Sources used, in order: [conventions.md](../findings/conventions.md); [route-a.md](../findings/route-a.md) §L134 proof of (c) and §L136's Setting; then [ATTEMPTS.md](../ATTEMPTS.md) Result 6 as a cross-check after the derivation was closed.*

Write $u$ for the unit $\mathbb{CP}^2$-type competitor, $\Lambda^2\mathbb R^n=E\oplus K$ with $E$ the self-dual $3$-space carrying $u|_E=\tfrac1{\sqrt6}\operatorname{diag}(2,-1,-1)$ and $K=\ker u=A\oplus K'$, $A$ the anti-self-dual $3$-space; $P_0=\Pi_K$, $D=P_0HP_0$, $B=\Pi_AH\Pi_A$, $g(W)=\mathrm{Alt}(W_-)$, $\delta^2=\lVert g\rVert^2$, $g_0=g(u)=a\star$, $a=\tfrac1{3\sqrt6}$. Then for every $H\in\mathcal W_n$ with $\lVert H\rVert=1$, $\langle H,u\rangle=0$:

$$d^+\delta^2(u;H)=-2a\,F(H),\qquad F(H)=(H_{22}+H_{33})+\operatorname{tr}\big(\Pi_A D_-\big)\ \ge\ \tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ \ge\ 0,$$

and since $u$ is a critical point of $P|_S$, $d^+\Phi(u;H)=-\kappa_n\,d^+\delta^2=2a\kappa_nF(H)$, which is $\le0$ exactly when $\kappa_n\le0$.

**Four ingredients, each checked here.**

| step | what it needs | status |
| --- | --- | --- |
| smooth branch $=-2a(H_{22}+H_{33})$ | Daleckii–Krein on the $E$-block; the block-diagonalising rotation is $O(t)$ and purely off-diagonal, so $\mathrm{tr}(\Pi_E\,\cdot)$ and $\mathrm{tr}(\Pi_A\,\cdot)$ are unmoved at first order | holds, DK multipliers at $u$ are $0$ on $(\hat\omega_1,\cdot)$ and $-1$ on $(\hat\omega_{2,3},\hat\omega_{2,3})$, so only $-H_{22}-H_{33}$ survives the pairing with $\star$ |
| kink branch $=2\langle g_0,\mathrm{Alt}(D_-)\rangle=-2a\operatorname{tr}(\Pi_AD_-)$ | $\star=\Pi_E-\Pi_A$ vanishes off $\Lambda^2\mathbb R^4$, so $g_0|_K=-a\Pi_A$; $K$-block is $t D_-+O(t^2)$ by degree-one homogeneity | holds |
| Jensen's trace inequality | Hansen–Pedersen for $f(x)=x_-$, convex with $f(0)=0$, at the projection $\Pi_A\le P_0$: $\operatorname{tr}(\Pi_AD_-)\ge\operatorname{tr}(B_-)$ | holds |
| Bianchi + tangency | $\mathrm{Alt}(H)=0\Rightarrow\langle H,\star\rangle=0\Rightarrow H_{11}+H_{22}+H_{33}=\operatorname{tr}(B)$; $\langle H,u\rangle=0\Rightarrow2H_{11}=H_{22}+H_{33}$; hence $H_{22}+H_{33}=\tfrac23\operatorname{tr}(B)$ | holds |

Combining: $F\ge\tfrac23\operatorname{tr}(B)+\operatorname{tr}(B_-)=\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ge0$. **The coefficient $\tfrac23$ is what carries the argument**, the chain needs the Bianchi/tangency coefficient in $[0,1]$, and $\tfrac23$ has room on both sides. It is fixed by the $2{:}{-}1{:}{-}1$ spectrum, so a competitor with a different SD spectrum would not be protected by this mechanism.

**The $\mathrm{Alt}$ factor $\tfrac13$ is right, and it is over-determined.** $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$, so on $\Lambda^2\mathbb R^4$ it is $X\mapsto\frac{\langle X,\star\rangle}{6}\star$. With $u_-=\tfrac1{\sqrt6}\operatorname{diag}(0,1,1)$ on $E$, $\langle u_-,\star\rangle=\tfrac2{\sqrt6}$, giving $a=\tfrac2{6\sqrt6}=\tfrac1{3\sqrt6}$ and $\delta^2(u)=6a^2=\tfrac19$, the record's independently-stated defect value at the competitor. Two anchors, one answer. I also checked idempotence directly: $\tfrac13(\epsilon_{ijkl}+\epsilon_{iklj}+\epsilon_{iljk})=\epsilon_{ijkl}$, both index rotations being even.

## 2. The sign of $W_-$, the expected break point, and it does not break

**The conclusion is convention-free; only the display is not.** $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ is a squared norm, and the opposite convention replaces $W_-$ by $-W_-$, so $\delta^2$ is *literally the same function* and $d^+\delta^2$ is the same number. $g_0$ and $g_1$ flip together, exactly as [conventions.md](../findings/conventions.md) says.

**Where a collision would bite, precisely.** Under $W_-\preceq0$ one has $a'=-a$, so the displayed identity becomes $d^+\delta^2=-2a'F'$ with $F'=-F\le0$, and the two one-sided steps invert with it: $\operatorname{tr}(\Pi_AD_-)\ge0$ becomes $\le0$, and Jensen's $f(x)=x_-$ becomes concave-side. So **"$F\ge0$" is a convention-bound statement while "$d^+\Phi\le0$" is not**, and any file importing the *inequality* $F\ge0$ into a build using $W_-\preceq0$ inverts it. This is the same collision that killed [L137](../findings/route-a.md) and was caught in [L134](../findings/route-a.md)'s Setting note. L17 as written is in the record's convention ($W_-\succeq0$, $g_0=+a\star$, $g_0|_K=-a\Pi_A$) and is internally consistent throughout. **Nothing here refutes L17 under either convention.**

## 3. Is it vacuous? No, and here is a hand witness

Let $\bar u$ be the anti-self-dual copy of $u$: $\bar u|_A=\tfrac1{\sqrt6}\operatorname{diag}(2,-1,-1)$, zero elsewhere. It is a Weyl tensor (the ASD half of a $4$-dimensional Weyl tensor), unit norm, and $\langle\bar u,u\rangle=0$ by disjoint blocks. Then:

- **By the formula.** $B=\Pi_A\bar u\Pi_A$ has $\operatorname{tr}B=0$, $D=\bar u$, $\operatorname{tr}(\Pi_AD_-)=\tfrac2{\sqrt6}$, $H_{22}+H_{33}=0$, so $F=\tfrac2{\sqrt6}$ and $d^+\delta^2=-2\cdot\tfrac1{3\sqrt6}\cdot\tfrac2{\sqrt6}=-\tfrac29$.
- **Directly.** $(u+t\bar u)_-=u_-+t\bar u_-$ by disjoint support; $\mathrm{Alt}(\bar u_-)=\frac{\langle\bar u_-,\star\rangle}{6}\star=-a\star$ since $\star|_A=-1$. So $g(t)=a(1-t)\star$ and $\delta^2(t)=\tfrac19(1-t)^2$, whence $\tfrac{d}{dt}\big|_{0^+}=-\tfrac29$.

**They agree exactly.** The same check at $H=-\bar u$ also gives $F=\tfrac2{\sqrt6}$ and $-\tfrac29$, both signs decrease, which is the kink doing its job and is the non-oddness of $d^+$ made visible. *This is pen-and-paper on objects built for the check; no computation was run.*

## 4. DEFECT 1, the canonical block contains neither a canonical statement nor a proof

[route-a.md](../findings/route-a.md) line 45 is headed **"Lemma L17 (first-order protection at the rival maximizer), canonical statement and proof"**, and the block under it is a single narrative paragraph, **verbatim identical** to the canon entry at [results.md](../results.md) line 640. There is no displayed inequality, no $F$, no $a$, no hypothesis list, no proof step. The note at line 47 says the argument was *"moved here from results.md, where the argument was the only copy"*, but what was moved is the prose, not the argument.

**Where the argument actually lives:** [ATTEMPTS.md](../ATTEMPTS.md) Result 6, lines 823–827, which the record's own architecture treats as a notebook rather than a findings page. Fragments are also recoverable from [conventions.md](../findings/conventions.md)'s $W_-$ bullet, [L134](../findings/route-a.md)'s proof of (c), and [L136](../findings/route-a.md)'s Setting, but no findings file states L17.

**Consequence.** Every downstream user of $\{F=0\}$, [L134](../findings/route-a.md)(b), [L136](../findings/route-a.md), [L140](../findings/route-a.md), the semiconcavity reformulation of [I3](../plan.md), cites a cone whose defining function is not written down anywhere in [findings/](../findings/). **The repair is to paste Result 6's display and its four ingredients into the L17 block.**

## 5. DEFECT 2, the canon entry drops the dimension hypothesis and contradicts itself

[results.md](../results.md) line 222:

> *"at the $\mathbb{CP}^2$-type competitor, the penalized functional cannot increase to first order in any direction, **in any dimension**, and below the crossover the same formula reverses sign, which is exactly the escape the numerics see there."*

**The two halves of that sentence contradict each other**, and the first half is false. $d^+\Phi=2a\kappa_nF$, so the conclusion needs $\kappa_n=9(\sqrt{3/2}-\theta_0(n))\le0$, i.e. $n\ge6+2\sqrt7$, i.e. $n\ge12$. At $n\le11$ the same formula gives $d^+\Phi\ge0$, strictly wherever $F>0$, an *escape*, which is the second half. What does hold in every dimension is the intermediate identity $d^+\delta^2=-2aF\le0$; the misplaced quantifier attaches "in any dimension" to the $\Phi$ conclusion instead.

[route-a.md](../findings/route-a.md) line 49 and [ATTEMPTS.md](../ATTEMPTS.md) line 827 both say $n\ge12$ correctly. **The defect is confined to the canon entry.**

## 6. DEFECT 3, the equality-case list is not the equality set

Both [route-a.md](../findings/route-a.md) line 49 and [results.md](../results.md) line 640 read *"with the equality cases being the competitor's own orbit, its hyper-Kähler rotations, and … every Weyl tensor of the complementary $\mathbb R^{n-4}$"*, a closed list. **It is a list of sufficient families, not the equality set.**

**The actual cone, in closed form.** $F=0$ forces $\operatorname{tr}(B_+)=\operatorname{tr}(B_-)=0$, hence $B=0$, hence $\operatorname{tr}(\Pi_AD_-)=0$, hence $\Pi_AD_-=0$ ($D_-\succeq0$), hence $\Pi_AD_+=0$; so

$$\{F=0\}=\{H:\ \Pi_{ASD}\,H\,\Pi_{\ker u}=0\},$$

a **linear subspace**, equivalently, $H$ carries the anti-self-dual $3$-space into $E$. The three named families sit inside it ($D=0$ on the orbit and the hyper-Kähler tangents; $\Pi_AD=0$ on the padded flat), but so does every $H$ whose only nonzero block is the mixed $E$–$K$ coupling $C$, and every mixed combination of the two.

**The record's own downstream work knows this and the canonical statement does not.** [route-a.md](../findings/route-a.md) line 196 asks for a bound *"on the **mixed** directions of $\{F=0\}$"*; [L136](../findings/route-a.md)'s Setting takes $H\in\{F=0\}\cap T_u\mathcal O^\perp$ with a nonzero $C$ block; [ATTEMPTS.md](../ATTEMPTS.md) line 1370 opens a whole attempt on *"the mixed directions of the equality manifold $\{F=0\}$"*, and line 827 itself splits the second-order job into "the safe padded flat, the orbit/subalgebra flats, and the mixed directions". **So the canonical statement's list is contradicted three files over.** [ATTEMPTS.md](../ATTEMPTS.md) line 827 states the correct iff, *"equality holds iff $B=0$ and the sliver has zero ASD-trace"*, which is equivalent to the display above, and the lift into [findings/](../findings/) and [results.md](../results.md) is where the iff was lost.

*This is a statement defect, not an error in the inequality: nothing downstream assumes the list is exhaustive, and reading it as exhaustive would have made the open mixed-direction problem disappear.*

## 7. Citations checked against the hypotheses, all inside

| citer | what it takes | inside? |
| --- | --- | --- |
| [L134](../findings/route-a.md)(b) | $d^+\delta^2=0$ on $\{F=0\}$, so $\Phi(t)-\theta_0$ starts at $t^2$ | yes, $F=0\Rightarrow d^+\delta^2=-2a\cdot0$ |
| [L136](../findings/route-a.md) | $\{F=0\}$ as a hypothesis on $H$; the $W_-\succeq0$ convention | yes, and it restates the convention explicitly |
| [L140](../findings/route-a.md)(ii)–(iii), the semiconcavity reformulation | *every* one-sided derivative of $\delta^2$ at $u$ is $\le0$ | yes, and **dimension-free**, this use never touches $\kappa_n$, so it is unaffected by Defect 2 |
| [route-a.md](../findings/route-a.md) lines 301, 317, 325 | "L17 says nothing at base points near $u$" | correct fence post; L17 is a statement at $u$ only |
| [plan.md](../plan.md) line 51 | "at the padded $\mathbb{CP}^2$ competitor only" | correct domain statement |
| [results.md](../results.md) line 222 | see Defect 2 | **no** |

**One further check, since [Conjecture L16](../findings/problem.md) has just been repaired.** [INDEX-results.md](../findings/INDEX-results.md) row 16 restates L16 against $\Theta_n$ rather than $\theta_0(n)$, which changes $\kappa_n$ to $9(\sqrt{3/2}-\Theta_n)$ at odd $n$. **L17 survives the repair**: its conclusion needs only $\kappa_n\le0$, and $\Theta_{11}=\sqrt{2\cdot10\cdot8/(12\cdot9)}=1.21716<\sqrt{3/2}<1.24838=\Theta_{13}$, so the crossover still falls at $n\ge12$. *This depends on the corrected odd-$n$ $\Theta_n$ with its square root; under the formula as it stood before 2026-09-04 the crossover would have moved.*

## 8. Would any of this be true vacuously?

- **$F\ge0$**, no. $F(\pm\bar u)=\tfrac2{\sqrt6}>0$ (§3), so the inequality has content and the protection is strict somewhere.
- **$d^+\Phi\le0$**, no, for the same reason, and strict wherever $F>0$ once $\kappa_n<0$.
- **The equality cone**, a proper subspace, since $\bar u\notin\{F=0\}$. But it is *large*: it contains the entire padded $\mathcal W_{n-4}$ (dimension $300$ at $n=12$ against the orbit's $34$) plus the mixed block, so "protection" leaves most of the tangent space to the second order. **The real question at $u$ is second order, and the record says so**, that is [L134](../findings/route-a.md), [L136](../findings/route-a.md), [L140](../findings/route-a.md), and fence post 59 in [INDEX-traps.md](../findings/INDEX-traps.md).

## 9. Verdict

**CONFIRMED**, $d^+\delta^2(u;H)=-2aF(H)$ with $F\ge0$, hence $d^+\Phi(u;H)\le0$, is correct.

**Hypotheses it actually needs**, none of them currently written in [findings/](../findings/):

1. $u$ is a critical point of $P|_S$ ($Q(u)=\theta^*u$), used to drop $dP$ from $d^+\Phi$.
2. $H$ tangent: $\langle H,u\rangle=0$, used for $2H_{11}=H_{22}+H_{33}$.
3. $H$ satisfies the first Bianchi identity, used for $\langle H,\star\rangle=0$.
4. $u$'s nonzero spectrum is $\tfrac1{\sqrt6}(2,-1,-1)$ on a **self-dual** $3$-space, so $\Pi_{ASD}\le\Pi_{\ker u}$ and the Jensen compression is legal.
5. **$\kappa_n\le0$, i.e. $n\ge12$**, for the $\Phi$ conclusion only; the $\delta^2$ identity is dimension-free.
6. Hansen–Pedersen's Jensen trace inequality for the convex $f(x)=x_-$ with $f(0)=0$.

**Convention it actually requires:** $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, for the *display* $F\ge0$ and for both one-sided steps. The *conclusion* $d^+\Phi\le0$ holds under either convention, $\delta^2$ being a squared norm.

**Three repairs owed:**

1. Write the statement and proof into the L17 block in [route-a.md](../findings/route-a.md), lift [ATTEMPTS.md](../ATTEMPTS.md) Result 6's display and its four ingredients.
2. Fix [results.md](../results.md) line 222: the $\Phi$ conclusion is for $n\ge12$; what holds in any dimension is $d^+\delta^2\le0$.
3. Replace the equality-case list with the iff: $F=0\iff\Pi_{ASD}H\Pi_{\ker u}=0$, and name the three families as members of that subspace rather than as its extent.

*Computation: none. Everything above is pen-and-paper on objects constructed for the check, per [analysis-only.md](../.claude/rules/analysis-only.md).*
