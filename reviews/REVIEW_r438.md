# Review r438, Corollary L140.2

*Adversarial audit, cold brief, 2026-09-03. Target: **Corollary L140.2** in [route-a.md](../findings/route-a.md), read against [Lemma L140](../findings/route-a.md), [Corollary L140.1](../findings/route-a.md), [Lemma L136](../findings/route-a.md), [Lemma L134](../findings/route-a.md), [Lemma L17](../findings/route-a.md), [Lemma L141](../findings/second-order.md) and [conventions.md](../findings/conventions.md). The author flagged this corollary's constants as unpinned; every one of them is re-derived below from the definitions, assuming nothing.*

**Standing rule inherited and observed.** This programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). Every result below is derived by hand. **One screen was run**, a finite-difference check, on $9\times9$ symmetric matrices constructed for the purpose, of the $1/g$ blow-up law in [§6](#6-why-continuity-cannot-be-repaired-phi_omega-is-unbounded-near-u), and it is reported as a screen, supporting a closed form that is itself derived here. The refutation in [§5](#5-claim-5-is-refuted-by-an-explicit-family-and-it-is-the-fourth-occurrence-of-the-same-error) uses no computation at all.

## Verdict

| claim | verdict |
| --- | --- |
| **1.** $\tfrac{d^2}{dt^2}\delta^2=\tfrac12\sum(\phi'_\Omega)^2+\tfrac12\sum\phi_\Omega\phi''_\Omega$ | **PLAUSIBLE, correct but domainless.** The algebra is right wherever $\phi''_\Omega$ exists; $\lvert W\rvert$ is not twice differentiable on $\{\det W=0\}$, a codimension-one set that passes through $u$, and across it $\tfrac{d^2}{dt^2}\delta^2$ carries a singular term the split omits. That term is exactly what semiconcavity is sensitive to. See [§2](#2-claim-1-is-right-where-it-is-defined-and-it-is-nowhere-said-where-that-is) and [§7](#7-the-omitted-singular-term-and-why-it-is-the-one-that-decides-semiconcavity). |
| **2.** $\sum(\phi'_\Omega)^2=\lVert D(\mathrm{Alt}\lvert W\rvert)[H]\rVert^2=4\lVert D(\mathrm{Alt}W_-)[H]\rVert^2\le1$, first half $\le\tfrac12$ | **CONFIRMED.** Every equality checks, the factor $4$ is right, $H$ *is* Weyl, and the $\le1$ is [Lemma L141](../findings/second-order.md)(a) applied legitimately. Two omissions of hypothesis ($\lVert H\rVert=1$; $W\in\mathcal W_n$) and no new content beyond its inputs. See [§3](#3-claim-2-checks-in-full-and-adds-nothing-to-its-inputs). |
| **3.** the budget is $C=\theta^*/\lvert\kappa_n\rvert$, binding at $0.718$ | **CONFIRMED.** Re-derived from [Lemma L134](../findings/route-a.md)(a) and the definition of $\Phi$: $C=\theta^*/\lvert\kappa_n\rvert$, decreasing in $n$ to $0.7182299$. It cross-checks against L134(b)'s $0.3591$ at exactly a factor $2$. The budget governs $\tfrac{d^2}{dt^2}\delta^2$, so the comparison is the right one. See [§4](#4-claim-3s-budget-re-derived-0718-is-right-and-the-comparison-is-the-right-one). |
| **3.** "It fits, with room" | **PLAUSIBLE as arithmetic, misleading as a position.** The $0.218$ of remaining budget has to absorb the second half, which [§5](#5-claim-5-is-refuted-by-an-explicit-family-and-it-is-the-fourth-occurrence-of-the-same-error) shows is bounded by nothing, and the $P$-side cubic remainder, which needs the inequality strict. |
| **4.** $\mathrm{Alt}(\lvert u\rvert)=2a\star$, $\phi_\Omega(u)=0$ for $\Omega\perp\star$, $\sum\phi_\Omega(u)^2=\tfrac49$ | **CONFIRMED**, and independently anchored: $a=\tfrac1{3\sqrt6}$, $\delta^2(u)=\tfrac19$ and the $+$ sign of $\star$ all fall out of one computation. See [§1](#1-the-constants-re-derived-from-nothing). |
| **4/5.** the surviving term written as $\tfrac12\phi_\star\phi_\star''$ with $\phi_\star=\mathop{\mathrm{tr}}(\lvert W\rvert\star)$ | **REFUTED, a factor $6$.** The sum runs over an **orthonormal** basis, so the surviving term is $\tfrac12\phi_{\Omega_\star}\phi''_{\Omega_\star}$ with $\Omega_\star=\star/\sqrt6$. Written with the unnormalised $\star$ the term is six times too large: $\phi_\star(u)^2=\tfrac83$ against the $\tfrac49$ the same paragraph derives. See [§1](#1-the-constants-re-derived-from-nothing). |
| **5.** "by continuity the second half is dominated near $u$ by its $\star$-term" | **REFUTED**, by an explicit family built from the record's own lemmas, at every distance $d>0$. On it the $\star$-term is **identically zero** and the whole second half sits on $\Omega\perp\star$. See [§5](#5-claim-5-is-refuted-by-an-explicit-family-and-it-is-the-fourth-occurrence-of-the-same-error). |
| **5.** "what is needed is an upper bound on $\phi_\star''$" | **REFUTED** with it. The residual obligation is not one scalar. |
| **5.** $\phi_\star>0$ near $u$, and the sign convention on $\star$ | **CONFIRMED.** $\phi_{\Omega_\star}(u)=\tfrac23$ and Moreau gives $\lvert\phi_{\Omega_\star}(W)-\tfrac23\rvert\le2d$, so positive for $d<\tfrac13$. The $+$ sign agrees with [conventions.md](../findings/conventions.md) and [Lemma L136](../findings/route-a.md). |
| **vacuity** | **Claim 2 is not vacuous** (Moreau alone gives only $\le4$, so the $\tfrac12$-contraction earns a factor $4$), **but it is not new**: at $u$ the split *is* [Lemma L136](../findings/route-a.md)'s decomposition doubled. See [§3](#3-claim-2-checks-in-full-and-adds-nothing-to-its-inputs) and [§8](#8-vacuity-what-the-corollary-would-still-say-if-its-inputs-were-empty). |

**Summary in one line.** The constants are right except one factor of $6$, the budget is right, the first half is genuinely discharged, and the sentence that carries the corollary's whole purpose is false, for the fourth time on this route and by the same mechanism as the previous three.

---

## 1. The constants, re-derived from nothing

$u$'s spectrum on the self-dual $3$-space $E\subset\Lambda^2\mathbb R^4$ is $\tfrac1{\sqrt6}(2,-1,-1)$ and $0$ on $K=\ker u$. Hence $\lvert u\rvert=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(2,1,1)$ on $E$ and $0$ on $K$, and with $\star=\Pi_{SD}-\Pi_{ASD}$ supported on $\Lambda^2\mathbb R^4$,

$$\phi_\star(u)=\mathop{\mathrm{tr}}(\Pi_{SD}\lvert u\rvert)-\mathop{\mathrm{tr}}(\Pi_{ASD}\lvert u\rvert)=\tfrac{2+1+1}{\sqrt6}-0=\tfrac4{\sqrt6}.$$

Since $\lvert u\rvert$ is supported on $\Lambda^2\mathbb R^4$ and $\Lambda^4\mathbb R^4$ is one-dimensional, $\mathrm{Alt}(\lvert u\rvert)$ is a multiple of $\star$; matching against $\lVert\star\rVert^2=6$ gives $\mathrm{Alt}(\lvert u\rvert)=\tfrac{4/\sqrt6}{6}\star=\tfrac2{3\sqrt6}\star=2a\star$ with $a=\tfrac1{3\sqrt6}$, and $\delta^2(u)=\lVert a\star\rVert^2=6a^2=\tfrac19$. **So $a$, the $+$ sign, $\lVert\star\rVert^2=6$ and $\delta^2(u)=\tfrac19$ are one computation and are mutually consistent.** The pairing under which this closes is the plain operator trace $\mathop{\mathrm{tr}}(AB)$ on $S^2(\Lambda^2)$, the normalisation [conventions.md](../findings/conventions.md) warns about is thereby pinned by the $\delta^2(u)=\tfrac19$ anchor rather than assumed.

**The factor $6$.** The corollary's sum is over an orthonormal basis $\{\Omega\}$ of $\Lambda^4$, so the unit $4$-form in the distinguished block is $\Omega_\star=\star/\sqrt6$, and

$$\phi_{\Omega_\star}(u)=\langle2a\star,\star/\sqrt6\rangle=2a\sqrt6=\tfrac23,\qquad \phi_{\Omega_\star}(u)^2=\tfrac49=4\delta^2(u),$$

exactly as the corollary's own sentence requires. But the sentence that follows names the surviving term $\tfrac12\phi_\star\phi_\star''$ and then *defines* $\phi_\star(W)=\mathop{\mathrm{tr}}(\lvert W\rvert\star)$ with the unnormalised $\star$, for which $\phi_\star(u)^2=\tfrac{16}6=\tfrac83$, not $\tfrac49$. The two displays are inconsistent by a factor $6$:

$$\tfrac12\phi_{\Omega_\star}\phi''_{\Omega_\star}=\tfrac16\cdot\tfrac12\phi_\star\phi''_\star .$$

Nothing about the *sign* question changes, so the corollary's "the sign of $\phi_\star''$ decides directly" survives; what does not survive is any budget arithmetic that spends the term as written. **This is the fourth constant this route has had to correct, and it is of the same kind as the other three.**

**Consistency check that passes.** Writing $\lvert W\rvert=\lvert u\rvert+tY_1+t^2Y_2+\dots$ and using $X_2=\tfrac12Y_2$ from [Lemma L136](../findings/route-a.md)'s setting, the correctly normalised term is $\tfrac12\phi_{\Omega_\star}\phi''_{\Omega_\star}=\tfrac13\phi''_{\Omega_\star}=\tfrac4{3\sqrt6}\langle X_2,\star\rangle=4a\langle\star,X_2\rangle$, which is exactly twice L136's cross term. See [§3](#3-claim-2-checks-in-full-and-adds-nothing-to-its-inputs).

## 2. Claim 1 is right where it is defined, and it is nowhere said where that is

With $\phi_\Omega=\langle\lvert W\rvert,\Omega\rangle$, $\delta^2=\tfrac14\sum\phi_\Omega^2$ differentiates to $\tfrac12\sum(\phi'_\Omega)^2+\tfrac12\sum\phi_\Omega\phi''_\Omega$. That is arithmetic and it is correct.

**The identity behind it needs $W$ Bianchi, and that is satisfied.** $\lvert W\rvert=W_++W_-$ and $W=W_+-W_-$, so $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)+\mathrm{Alt}(W)$, and the corollary's $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ holds **exactly on $\{\mathrm{Alt}(W)=0\}\supseteq\mathcal W_n$**. Then $\delta^2=\tfrac14\lVert\mathrm{Alt}\lvert W\rvert\rVert^2=\tfrac14\sum_\Omega\langle\lvert W\rvert,\Omega\rangle^2$, using $\mathrm{Alt}$ self-adjoint and idempotent and $\Omega\in\Lambda^4$. **The ambient space is $\mathcal W_n$ throughout**, [Corollary L140.1](../findings/route-a.md)(i) integrates inside $\mathcal W_n$, the tube is in $\mathcal W_n$, and $H=W-u'$ is a difference of Weyl tensors, and $\mathcal W_n$ is a *linear* subspace, so every segment used stays inside it. **So the identity is safe, and the corollary is simply silent about the hypothesis it uses.** *This half of the brief's suspicion does not land: no point of the argument evaluates $\delta^2=\tfrac14\sum\phi_\Omega^2$ off $\mathcal W_n$.*

**What is missing is the domain in $t$.** $x\mapsto\lvert x\rvert$ is analytic away from $0$, so $W\mapsto\lvert W\rvert$ is real-analytic on invertible $W$ and $\phi''_\Omega$ exists there. It does not exist on $\{\det W=0\}$, which has codimension one in $\mathcal W_n$ and **contains $u$**, whose kernel has dimension $\binom n2-3$. The corollary writes $\tfrac{d^2}{dt^2}$ unqualified. [§7](#7-the-omitted-singular-term-and-why-it-is-the-one-that-decides-semiconcavity) shows the omitted term is not a technicality: it is the term semiconcavity stands or falls on.

## 3. Claim 2 checks in full, and adds nothing to its inputs

$\phi'_\Omega=\langle D\lvert W\rvert[H],\Omega\rangle=\langle\mathrm{Alt}(D\lvert W\rvert[H]),\Omega\rangle$, so summing squares over an orthonormal basis of $\Lambda^4$ gives $\sum(\phi'_\Omega)^2=\lVert D(\mathrm{Alt}\lvert W\rvert)[H]\rVert^2$, Parseval, plus $\mathrm{Alt}$ self-adjoint with $\mathrm{Alt}\Omega=\Omega$, plus linearity of $\mathrm{Alt}$. **Correct.**

The factor $4$ is $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ differentiated, legitimate because the identity holds along the whole segment, not just at the base point. **Correct.**

The $\le1$ is [Lemma L141](../findings/second-order.md)(a), $\lVert D(\mathrm{Alt}W_-)_V[H]\rVert\le\tfrac12\lVert H\rVert$ at **every** base point $V\in\mathcal W_n$ in every Weyl direction. The brief asks whether $H$ is Weyl here: **it is**, in the tube statement the direction is $W-u'$ with both endpoints in $\mathcal W_n$. So $4\cdot\tfrac14\lVert H\rVert^2=1$ at $\lVert H\rVert=1$, and the first half is $\le\tfrac12$. **Correct.**

**Two hypotheses are dropped from the display**: $\lVert H\rVert=1$ (without it the bound is $\lVert H\rVert^2$), and $W\in\mathcal W_n$ (§2).

**And it is a restatement.** At $u$ the split is [Lemma L136](../findings/route-a.md)'s decomposition with both sides doubled. Along the straight line $u+tH$, $\tfrac{d^2}{dt^2}\delta^2=2\Delta_2$ and L136's setting gives $\Delta_2=\lVert g_1\rVert^2+2a\langle\star,X_2\rangle$, so

$$\underbrace{\tfrac12\sum(\phi'_\Omega)^2}_{\text{first half}}=2\lVert g_1\rVert^2,\qquad \underbrace{\tfrac12\sum\phi_\Omega\phi''_\Omega}_{\text{second half}}=4a\langle\star,X_2\rangle .$$

The first is [Lemma L140](../findings/route-a.md)'s $\lVert g_1\rVert^2\le\tfrac14$; the second is L136's cross term. **The corollary's "first half already discharged" is L140 at $u$ and L141(a) elsewhere, re-packaged.** That is legitimate for a corollary; it means the corollary's only new content is claim 5.

## 4. Claim 3's budget, re-derived: $0.718$ is right, and the comparison is the right one

$\Phi=P-\kappa_n\delta^2$ with $\kappa_n=9(\theta^*-\theta_0(n))<0$ for $n\ge12$, so $\Phi=P+\lvert\kappa_n\rvert\delta^2$ and $\lvert\kappa_n\rvert=9(\theta_0-\theta^*)$. At $u$: $\Phi(u)=\theta^*+\tfrac{\lvert\kappa_n\rvert}9=\theta^*+(\theta_0-\theta^*)=\theta_0$, so the conjecture is an equality there. Semiconcavity with constant $C$ plus [Lemma L17](../findings/route-a.md)'s nonpositive one-sided derivatives gives $\delta^2(W)\le\tfrac19+\tfrac C2d^2$; [Lemma L134](../findings/route-a.md)(a) gives $P(W)\le\theta^*-\tfrac{\theta^*}2d^2+O(d^3)$ off the orbit. Hence

$$\Phi(W)-\theta_0\;\le\;\Big(\tfrac{\lvert\kappa_n\rvert C}{2}-\tfrac{\theta^*}2\Big)d^2+O(d^3),\qquad\text{so }\ C\le\frac{\theta^*}{\lvert\kappa_n\rvert}.$$

**The budget is a budget on $\delta^2$, not on $\Phi$** (it caps $\tfrac{d^2}{dt^2}\delta^2$) so the corollary compares the right two things.

**The number.** $\theta^*=\sqrt{3/2}=1.2247449$; $\theta_0(n)^2=2(n-1)(n-2)/n^2$ increases in $n$ to $2$, so $\lvert\kappa_n\rvert$ increases to $9(\sqrt2-\sqrt{3/2})=1.7052182$ and $C=\theta^*/\lvert\kappa_n\rvert$ **decreases**, binding at

$$C_\infty=\frac{1.2247449}{1.7052182}=0.7182299 .$$

At $n=12$, $\theta_0=1.2360331$, $\lvert\kappa_{12}\rvert=0.1015938$ (the record's $0.10159$) and $C_{12}=12.055$. **$0.718$ is correct**, and it cross-checks at exactly twice L134(b)'s threshold $\theta^*/(2\lvert\kappa_n\rvert)=0.3591$, as it must since $c_2=\tfrac12\tfrac{d^2}{dt^2}\delta^2$. *Two independent routes to the same constant; this one is pinned.*

**Two caveats on "it fits, with room".**

- **Great circle against chord.** $\delta^2$ is $2$-homogeneous, so along $\cos t\,u+\sin t\,H$ its second derivative is the ambient Hessian minus $2\delta^2(u)=\tfrac29$. The corollary never says which path $\tfrac{d^2}{dt^2}$ is taken along; the budget $0.718$ is the great-circle one, the ambient one is $0.940$. The first half is the same in both readings, so **the slip is in the conservative direction**, but it is a slip, and it is the kind this route has been paying for.
- **Strictness.** The $P$-side remainder is exactly $\sin^3t\,P(H)$, an uncontrolled $O(d^3)$ at the budget's boundary. $C\le\theta^*/\lvert\kappa_n\rvert$ must be strict, with the margin absorbing $\max_{\lVert X\rVert=1}\lvert P(X)\rvert\cdot d$.

## 5. Claim 5 is REFUTED by an explicit family, and it is the fourth occurrence of the same error

**The family.** $n\ge12$, so the complementary $\mathbb R^{n-4}$ has dimension at least $8$. Let $u'$ be a $\mathbb{CP}^2$-type unit competitor supported on that complementary $\mathbb R^{n-4}$, let $d>0$, and put

$$W_d=u+d\,u'\in\mathcal W_n,\qquad \lVert W_d-u\rVert=d,$$

with the direction $H$ any unit Weyl tensor of the same complementary $\mathbb R^{n-4}$.

**(a) The $\star$-term is identically zero on the whole family.** $\lvert d\,u'+tH\rvert$ is supported on $\Lambda^2\mathbb R^{n-4}$ and $\star$ is supported on $\Lambda^2\mathbb R^4$, so for every $d$ and every $t$

$$\phi_{\Omega_\star}(W_d+tH)=\langle\lvert u\rvert,\Omega_\star\rangle=\tfrac23\quad\text{(constant)},\qquad\text{hence}\qquad \phi''_{\Omega_\star}\equiv0 .$$

**(b) The second half is not zero.** By [Lemma L134](../findings/route-a.md)(c)'s direct-sum rule, $\delta^2(u+V)=\tfrac19+\delta^2(V)$ for $V$ on the complement, and $\delta^2$ is $2$-homogeneous, so

$$\tfrac{d^2}{dt^2}\Big|_{0^+}\delta^2(W_d+tH)=2\Delta_2^{(u')}(H)\qquad\text{independently of }d,$$

and splitting it as the corollary does gives first half $=2\lVert g_1(u',H)\rVert^2$ and

$$\text{second half}=2\Delta_2^{(u')}-2\lVert g_1\rVert^2=4a\langle\star',X_2\rangle,$$

which is [Lemma L136](../findings/route-a.md)'s cross term at $u'$, the object that lemma exists to sign, generically nonzero (L136 itself evaluates it as $-\tfrac23(\lVert\Pi_Ac_2\rVert^2+\lVert\Pi_Ac_3\rVert^2)$ on the cone). Every $4$-form carrying it lies in $\Lambda^4\mathbb R^{n-4}$, hence **orthogonal to $\star$**.

**(c) Conclusion.** At points arbitrarily close to $u$, the entire second half is carried by $\Omega\perp\star$ and the $\star$-term contributes **nothing at all**. So:

> "By continuity the second half is dominated near $u$ by its $\star$-term $\tfrac12\phi_\star\phi_\star''$" is **FALSE**, and shrinking the neighbourhood does not repair it, $d$ being free. With it falls "what is needed is an upper bound on $\phi_\star''$": the residual obligation is not one scalar.

**Why the "by continuity" step was never available.** $\phi_\Omega(u)=0$ for $\Omega\perp\star$ gives $\phi_\Omega=O(d)$ at distance $d$, indeed $\big(\sum_{\Omega\perp\star}\phi_\Omega^2\big)^{1/2}\le\lVert\lvert W\rvert-\lvert u\rvert\rVert\le\sqrt2\,d$. Continuity of the *factor* $\phi_\Omega$ is all that is established. The **other** factor $\phi''_\Omega$ is bounded by nothing in the record, and §6 shows it is genuinely unbounded, of size $O(1/d)$ at distance $d$. A product of a factor that vanishes at $u$ and a factor that blows up there is not controlled by continuity, **and the number of such terms is $\binom n4-1$, growing with $n$, where the $\star$-term is one.**

**This is the same error, a fourth time.** [Lemma L134](../findings/route-a.md)(d) took a per-direction bound for a uniform one; L140.1(vi)'s display took per-ray $\limsup$s for a neighbourhood ceiling and was refuted by an explicit curve; L140.1(v)'s kink argument took a fact at $u$ for a fact near $u$. Here a fact **at the base point $u$** (that $\mathrm{Alt}(\lvert u\rvert)$ is supported on one $4$-form), is transported to base points near $u$, and fails for the same reason: the record's own [Corollary L140.1](../findings/route-a.md)(v) already says *"any real obstruction therefore lives at base points NEAR $u$, where L17 says nothing"*, and L140.2 is precisely a claim about base points near $u$.

## 6. Why continuity cannot be repaired: $\phi''_\Omega$ is unbounded near $u$

Let $W$ have an opposite-sign eigenvalue pair $\alpha>0$, $-\beta<0$ on a $2$-dimensional invariant subspace with projection $\Pi$, and write $m=\tfrac{\alpha-\beta}2$, $g=\tfrac{\alpha+\beta}2$. Perturbing by $t$ inside that block, the block's two eigenvalues are $m\pm s$ with $s=\sqrt{g^2+t^2}$, and since $s\ge g>\lvert m\rvert$,

$$\lvert A\rvert\big|_{\text{block}}=\tfrac ms\,A+\tfrac{s^2-m^2}{s}\,\Pi .$$

With $s(0)=g$, $s'(0)=0$, $s''(0)=1/g$ this gives, for the block's contribution,

$$\boxed{\ \phi''_\Omega=\tfrac1g\Big(1+\tfrac{m^2}{g^2}\Big)\langle\Pi,\Omega\rangle-\tfrac{m}{g^3}\langle A_0,\Omega\rangle\ }$$

**so $\phi''_\Omega$ blows up like $1/g$, where $g$ is the mean of the two moduli, it does not require the eigenvalues to be equal, only both small.** Near $u$ every eigenvalue on the kernel block $K$ is $O(d)$ and $D=P_0HP_0$ is generically indefinite, so **$g=O(d)$ automatically and $\phi''_\Omega=O(1/d)$**. Against $\phi_\Omega=O(d)$ the product is $O(1)$, the same order as the $\star$-term, with $\binom n4-1$ of them.

*Screen (constructed objects, seconds, reported as a screen and not as evidence): finite differences of $\mathop{\mathrm{tr}}(\lvert W+tH\rvert\Omega)$ on $9\times9$ symmetric $W$ with a $(1.3g,-0.7g)$ pair and $O(1)$ remaining spectrum give $g\cdot\phi''\to0.0418$ over $g=10^{-1},10^{-2},10^{-3},10^{-4}$, the $1/g$ law, four decades of it.*

## 7. The omitted singular term, and why it is the one that decides semiconcavity

Semiconcavity with constant $C$ is $D^2f\le C$ **in the distributional sense**. Across a simple eigenvalue crossing zero along the path, $\phi_\Omega$ has a kink: the jump in $\phi'_\Omega$ is $2\lvert\lambda'\rvert\langle P_\lambda,\Omega\rangle$, so $\tfrac{d^2}{dt^2}\delta^2$ acquires an atom of density

$$\sum_\Omega\phi_\Omega\cdot2\lvert\lambda'\rvert\langle P_\lambda,\Omega\rangle=2\lvert\lambda'\rvert\,\langle\mathrm{Alt}\lvert W\rvert,P_\lambda\rangle=4\lvert\lambda'\rvert\,\langle\mathrm{Alt}(W_-),P_\lambda\rangle .$$

*This is the smeared limit of §6's formula: as $g\to0$ the $\tfrac1g\langle\Pi,\Omega\rangle$ term is the Dirac forming.*

- **At $u$ the atom is nonpositive**: $\langle a\star,P_\lambda\rangle=-a\lVert\Pi_Av\rVert^2\le0$, because $\star$ is supported on $\Lambda^2\mathbb R^4$ and the crossing eigenvectors lie in $K$, where $\star$ acts as $-\Pi_{ASD}$. **This is exactly [Lemma L17](../findings/route-a.md)'s mechanism**, and it is why $u$ is protected.
- **At base points near $u$ it is not signed.** For a crossing eigenvector in $K'$ (outside the distinguished $\mathbb R^4$), the leading term is $0$ and the sign is decided by the $O(d)$ correction to $\mathrm{Alt}(W_-)$, which nothing in the record signs. **A single positive atom, however small its density, refutes semiconcavity for every constant $C$.**

**The corollary's split cannot see this.** It computes classical second derivatives; the first half stays $\le\tfrac12$ almost everywhere and the atom lands entirely in the second half. So "the whole obligation is the second half" is *more* true than the corollary means it, and the obligation includes signing a term the corollary does not name.

*This is an objection to the corollary's framing and to [Corollary L140.1](../findings/route-a.md)(iii)'s reduction jointly; it is stated as a gap, not a refutation, the sign of $\langle\mathrm{Alt}(W_-),P_\lambda\rangle$ at $K'$-crossings near $u$ is undetermined here, and settling it either way is now the load-bearing question.*

## 8. Vacuity: what the corollary would still say if its inputs were empty

- **Claim 2 is not vacuously true.** Moreau's nonexpansiveness of $W\mapsto W_-$ alone gives $\sum(\phi'_\Omega)^2\le4$ and a first half of $\le2$, which does **not** fit in $0.718$. The $\tfrac12$-contraction is doing a factor of $4$ of real work. *The bound is, however, exactly its two inputs restated, see [§3](#3-claim-2-checks-in-full-and-adds-nothing-to-its-inputs).*
- **Claim 3 is not vacuous.** $0.718$ is the infimum over $n\ge12$ of a strictly decreasing sequence, approached but never attained; it is the right binding value and it is independently reachable from L134(b).
- **Claim 4 is not vacuous**, but its content is one line of support-counting: $\lvert u\rvert$ lives in $\Lambda^2\mathbb R^4$ and $\Lambda^4\mathbb R^4$ is one-dimensional.
- **Claim 5 is where the corollary's value was supposed to be**, and it is false. What remains after §5 is claims 1–4, none of which is new, plus the observation that the second half is the whole obligation, which [Lemma L136](../findings/route-a.md) already said, on the cone, at $u$.

## 9. What a repair would have to do

1. **Fix the factor $6$**: the surviving term is $\tfrac12\phi_{\Omega_\star}\phi''_{\Omega_\star}$ with $\Omega_\star=\star/\sqrt6$, equal to $\tfrac16\cdot\tfrac12\phi_\star\phi''_\star$.
2. **State the domain**: the split holds on $\{W\in\mathcal W_n:\det W\ne0\}$, and say what happens on $\{\det W=0\}$ ([§7](#7-the-omitted-singular-term-and-why-it-is-the-one-that-decides-semiconcavity)).
3. **Say which path** $\tfrac{d^2}{dt^2}$ runs along; the great-circle and ambient budgets differ by $2\delta^2(u)=\tfrac29$.
4. **Replace claim 5** with a bound on the whole vector $(\phi''_\Omega)_\Omega$, the honest form of the obligation is
   $$\tfrac12\sum_\Omega\phi_\Omega\phi''_\Omega\;\le\;\tfrac12\Big[\phi_{\Omega_\star}\phi''_{\Omega_\star}+\sqrt2\,d\,\big\lVert(\phi''_\Omega)_{\Omega\perp\star}\big\rVert\Big],$$
   and §6 shows $\lVert(\phi''_\Omega)_{\Omega\perp\star}\rVert$ is $O(1/d)$, so the bracket's second term does not vanish with $d$. Any repair must control it, not wish it away.
5. **Sign the atom** of §7 at $K'$-crossings near $u$, or accept that $\delta^2$ may fail to be semiconcave at any constant.
