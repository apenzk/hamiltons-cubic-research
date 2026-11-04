# Review r436, Lemma L142 and Corollary L140.1

*Adversarial audit, cold brief, 2026-09-03. Targets: [Lemma L142](../findings/bounds.md#lemma-l142-withdrawn-dominated-by-bounds-already-on-the-record) and [Corollary L140.1](../findings/route-a.md), read against [conventions.md](../findings/conventions.md), [post F11](../findings/second-order.md#post-f11-splitting-p-into-its-two-terms-cannot-deliver-mnlesqrt3) and the two bounds recorded immediately after it in [second-order.md](../findings/second-order.md), [Lemma L140](../findings/route-a.md), [Lemma L134](../findings/route-a.md) and [Lemma L17](../findings/route-a.md).*

**Standing rule inherited and observed.** This programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). **Everything below is derived by hand, no computation of any kind was run, not even a screen.** The record's own numbers at $S^6\times S^6$ are used as *anchors* to test conventions, and are reproduced from closed forms derived here rather than re-measured.

## Verdict

| claim | verdict |
| --- | --- |
| **L142**, the inequality $\lvert P(X)\rvert\le1+(n-2)\lVert\lambda\rVert_\infty\le n-1$ | **CONFIRMED as true.** Every step of the proof is sound in the record's own conventions; see [§1](#1-l142s-algebra-is-correct-and-anchored). |
| **L142**, "the record carries no proved bound at all", its whole reason for existing | **REFUTED.** [second-order.md](../findings/second-order.md) already carries two proved pointwise bounds on $P$, both strictly stronger, one of them twenty lines below the post F11 that L142 cites. See [§2](#2-the-novelty-claim-is-false-and-l142-is-dominated-term-by-term). |
| **L142**, the statement as displayed | **Weaker than its own proof.** The proof yields $\lvert P\rvert\le(n-1)\lVert\lambda\rVert_\infty$; the display gives away the trace term. See [§3](#3-the-display-is-weaker-than-the-proof-that-precedes-it). |
| **L142**, the "where it is loose" note | **PARTLY REFUTED.** The row-mass step is near-sharp, not the lossy one; $\lVert\lambda\rVert_\infty\le1$ is where everything is lost. See [§4](#4-the-losses-are-in-the-other-place). |
| **L140.1(i)**, $\delta$ is $\tfrac12$-Lipschitz on $\mathcal W_n$ | **CONFIRMED as true, REFUTED as cited.** [Lemma L140](../findings/route-a.md) is proved at $u$ only; the general statement rests on a Daleckii–Krein fact the record nowhere states. See [§5](#5-i-is-true-and-l140-does-not-prove-it). |
| **L140.1(i)**, "the strongest global statement the route has produced" | **Over-stated.** $\delta$ is $1$-Lipschitz for free by Moreau, already recorded inside [Lemma L134](../findings/route-a.md). (i) halves a known constant. |
| **L140.1(ii)**, the arithmetic | **CONFIRMED.** Both the algebra and the direction of $\lVert W_1-W_2\rVert\le d$ check. |
| **L140.1(iii)**, the semiconcavity implication | **REFUTED as stated.** The convex-analysis step is right; the implication silently uses the $P$-side Hessian bound in *every* direction, and [Lemma L134](../findings/route-a.md)(d) proves that exact uniformity false. See [§7](#7-iii-drops-the-orthogonality-l134d-proves-cannot-be-dropped). |
| **L140.1(iv)**, $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ and $\delta^2=\tfrac14\sum_\Omega\mathop{\mathrm{tr}}(\lvert W\rvert\Omega)^2$ | **CONFIRMED**, and independently anchored: it returns $\delta^2(u)=\tfrac19$ from $a=\tfrac1{3\sqrt6}$ and $\lVert\star\rVert^2=6$ exactly. See [§8](#8-iv-is-correct-and-anchors-itself). |
| **L140.1(v)**, the double eigenvalue is harmless | **CONFIRMED.** |
| **L140.1(v)**, "the kernel contributes the exactly homogeneous $t\lvert D\rvert$, whose second derivative in $t$ vanishes" | **REFUTED as complete.** [Lemma L140](../findings/route-a.md)'s own sentence puts the Schur term at $t^2$, the order $c_2$ lives at. See [§9](#9-v-disposes-of-the-obstruction-at-first-order-only). |
| **L140.1(vi)**, the displayed $\sup_H\limsup_{t\to0^+}$ statement is "exactly" the item | **REFUTED.** It bounds the per-ray coefficients and supplies no uniform radius; the item needs $\sup$ over $t$, not $\limsup$ as $t\to0^+$. See [§10](#10-vi-gives-away-the-uniformity-it-claims-to-keep). |
| **L140.1(vi)**, "semiconcavity is strictly stronger than needed" | **REFUTED as argued.** The two-sidedness half is right; the conclusion conflates it with uniformity in $t$, which is the half semiconcavity was supplying. |
| **L140.1(vi)**, "on the kernel block [the radius] cannot [degenerate]" | **REFUTED.** The reason given is a non sequitur, and the kernel block is where the radius is *most* at risk. See [§11](#11-the-kernel-block-is-where-the-radius-does-degenerate). |

**Nothing here is vacuous in the trivial sense**, L142's inequality has content and (i) is a real improvement on a real constant. What is vacuous is L142's *reason for being recorded*, and what is over-claimed is the reduction in (vi).

---

## 1. L142's algebra is correct, and anchored

Each step, checked against [conventions.md](../findings/conventions.md) rather than against the lemma's own restatement of it.

- **Total symmetry of $T$.** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric because the inner product is ad-invariant ([conventions.md](../findings/conventions.md)), so $T=c^2$ is totally symmetric and vanishes when two indices coincide. **Correct.**
- **The row mass, and the ordered/unordered question the brief raises.** [conventions.md](../findings/conventions.md) records $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2$ and $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, and the file's default is that pair sums are over **ordered** pairs. Composing gives $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered $(\beta,\gamma)$, which is the form L142 uses. It is also independently derivable and basis-free: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=-\mathop{\mathrm{tr}}(\mathrm{ad}\,v_\alpha)^2=-B(v_\alpha,v_\alpha)=-(n-2)\mathop{\mathrm{tr}}(v_\alpha^2)=2(n-2)$, using the Killing form $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ and $\mathop{\mathrm{tr}}(v^2)=-2$ at unit norm. **Correct, in the record's convention, over ordered pairs.** The basis-freeness matters and is not stated in the lemma: the structure constants are transported to $X$'s eigenbasis, which is generic, and the row mass survives that transport precisely because it is a trace.
- **AM–GM and the symmetry step.** $\lvert\lambda_\alpha\lambda_\beta\lambda_\gamma\rvert\le\tfrac13(\lvert\lambda_\alpha\rvert^3+\lvert\lambda_\beta\rvert^3+\lvert\lambda_\gamma\rvert^3)$ is the standard three-term inequality, and total symmetry of $T$ makes the three resulting sums equal, so the factor $\tfrac13$ cancels against three copies. **Correct**, the AM–GM step *needs* the total symmetry and gets it.
- **$\sum_\alpha\lvert\lambda_\alpha\rvert^3\le\lVert\lambda\rVert_\infty$ given $\sum\lambda^2=1$.** $\sum\lvert\lambda\rvert^3\le\lVert\lambda\rVert_\infty\sum\lambda^2=\lVert\lambda\rVert_\infty$. **Correct.** And $\lVert\lambda\rVert_\infty\le1$ likewise. **Correct.**
- **The $\tfrac12$.** It is the $\#$-convention's, and it is anchored by the record's own numbers rather than by assertion. Deriving the balanced product's spectrum from scratch, $S^m\times S^m$ at $n=2m$ is Einstein, so $W=R-\tfrac{s}{n(n-1)}\mathrm{Id}$ with $\tfrac{s}{n(n-1)}=\tfrac{m-1}{2m-1}$, giving at unit norm

$$\hat\lambda_+=\frac1{\sqrt{(2m-1)(m-1)}}\ \ (\text{mult }m(m-1)),\qquad\hat\lambda_-=-\frac{\sqrt{m-1}}{m\sqrt{2m-1}}\ \ (\text{mult }m^2),$$

  whence $\mathop{\mathrm{tr}}W^3=\tfrac1{m\sqrt{(2m-1)(m-1)}}$ and $\langle W,W^\#\rangle=\theta_0-\mathop{\mathrm{tr}}W^3=\tfrac{2m-3}{\sqrt{(2m-1)(m-1)}}$. At $m=6$ these are $0.022474$ and $1.213560$ against post F11's $0.0225$ and $1.2136$, with $\theta_0(12)=\sqrt{55}/6=1.236034$. **The identity $\langle X,X^\#\rangle=\tfrac12\sum T\lambda\lambda\lambda$ and its $\tfrac12$ are therefore consistent with the record's anchor to four decimals**, and the same identity is independently printed in [second-order.md](../findings/second-order.md) with the same $\tfrac12$.

**So the inequality is true.** Everything that follows concerns what it is worth.

## 2. The novelty claim is false, and L142 is dominated term by term

L142 exists, by its own header note, because "**the record carries no proved bound at all**, only post F11's statement that splitting $P$'s two terms cannot get below $1+\sqrt2$, and a numerical supremum for a related quantity."

**That sentence is false, and the counterexample is in the same file as the post F11 it cites, roughly twenty lines below it.** [second-order.md](../findings/second-order.md), in the section "The eigenvalue identity for $\langle W,W^\#\rangle$, and why flatness alone cannot cap $M(n)$", records with $y=\lVert\lambda\rVert_4^2$:

$$\langle W,W^\#\rangle\le(n-2)\,y,\qquad\mathop{\mathrm{tr}}W^3\le\lVert\lambda\rVert_\infty\le\sqrt y,\qquad\text{so}\qquad\theta\le\sqrt y+(n-2)y .$$

These are pointwise inequalities at $\lVert W\rVert=1$, proved by Cauchy–Schwarz, holding at every unit Weyl tensor and not only at critical points; and $P$ is an odd cubic ($P(-X)=-P(X)$, since $(-X)^\#=X^\#$), so a one-sided bound over $\mathcal W_n$ is automatically two-sided. Now, at $\sum\lambda^2=1$,

$$\sum_\alpha\lvert\lambda_\alpha\rvert^3\;\le\;\Big(\sum\lambda^4\Big)^{1/2}=y\;\le\;\lVert\lambda\rVert_\infty\;\le\;1 ,$$

the first by Cauchy–Schwarz on $\lambda^2\cdot\lvert\lambda\rvert$ and the second by $\sum\lambda^4\le\lVert\lambda\rVert_\infty^2\sum\lambda^2$. Hence:

| | L142 | already recorded |
| --- | --- | --- |
| sharp term | $(n-2)\lVert\lambda\rVert_\infty$ | $(n-2)y$, **and $y\le\lVert\lambda\rVert_\infty$** |
| trace term | $1$ | $\sqrt y\le1$ |
| worst case over the admissible range | $n-1$ | $\sqrt y+(n-2)y\le n-1$, **attained only at $y=1$** |
| at $S^6\times S^6$ | $2.3484$ | $0.3537+1.2512=1.6049$ |

**The recorded bound is strictly stronger in both terms and delivers the identical constant $n-1$.** The check at $S^6\times S^6$ also confirms the identification: $y=\lVert\lambda\rVert_4^2=0.125116$ from the closed forms above, against the $0.1251$ that section prints.

**A second recorded bound dominates L142 as well.** The same file's "A bound that survives both regimes" section proves $\langle W,W^\#\rangle\le B_5$ and $\mathop{\mathrm{tr}}W^3\le\lambda_{\max}p$ with $p=\sum_{\lambda>0}\lambda^2$, hence $\theta\le\lambda_{\max}p+B_5$; and it further proves $B_5\le(n-2)\lVert\lambda\rVert_4^2$, adding in the record's own words that "**the flatness bound can be dropped outright**". Since $\lambda_{\max}p\le\lVert\lambda\rVert_\infty$, this chain gives $\lvert P\rvert\le\lVert\lambda\rVert_\infty+(n-2)y\le(n-1)\lVert\lambda\rVert_\infty\le n-1$, again strictly inside L142's display, again with the same final constant. And [second-order.md](../findings/second-order.md) additionally carries the boxed $\theta\le\lambda_{\max}(M(\lambda))$.

**What L142 actually is**: the recorded flatness argument with its last Cauchy–Schwarz omitted. Its chain runs $\lvert\langle X,X^\#\rangle\rvert\le(n-2)\sum\lvert\lambda\rvert^3$, and then replaces $\sum\lvert\lambda\rvert^3$ by $\lVert\lambda\rVert_\infty$ where the record replaces it by the smaller $y$.

**Consequence for the ledger.** [INDEX-results.md](../findings/INDEX-results.md) row 142 calls it "the record's first **proved** bound on $P$". That is wrong twice over (it is neither first nor the strongest) and the row should be corrected whatever else is done with the lemma.

**One thing L142 does own, and it is small.** Its intermediate $(n-2)\sum_\alpha\lvert\lambda_\alpha\rvert^3$ is *tighter* than the recorded $(n-2)y$, by the same Cauchy–Schwarz. If anything is worth keeping from this lemma it is that one line, folded into the existing section, not a new numbered result.

## 3. The display is weaker than the proof that precedes it

The proof establishes $\lvert\mathop{\mathrm{tr}}X^3\rvert\le\lVert\lambda\rVert_\infty$ and then, in the very next line of the statement, uses $1$ for that term while keeping $\lVert\lambda\rVert_\infty$ in the other. The honest sum of its own two estimates is

$$\lvert P(X)\rvert\;\le\;(n-1)\,\lVert\lambda\rVert_\infty ,$$

which is strictly stronger than $1+(n-2)\lVert\lambda\rVert_\infty$ whenever $\lVert\lambda\rVert_\infty<1$, that is, everywhere on $\mathcal W_n$, since $\lVert\lambda\rVert_\infty=1$ forces rank one, and a rank-one $\omega\otimes\omega$ is Bianchi only for decomposable $\omega$, where it fails Ricci-flatness. At $S^6\times S^6$ the two read $1.4832$ against the printed $2.3484$. **The lemma as displayed throws away a factor of $1.58$ at the record's own reference point, for nothing.**

## 4. The losses are in the other place

L142's "where it is loose" note says "the step that costs everything is replacing $\lvert\lambda_\alpha\lambda_\beta\lambda_\gamma\rvert$ by cubes and then using the row mass $2(n-2)$". **On the record's own reference family that step costs almost nothing.** From §1's closed forms, at $S^m\times S^m$,

$$\langle W,W^\#\rangle=\frac{2m-3}{\sqrt{(2m-1)(m-1)}},\qquad (n-2)\lVert\lambda\rVert_\infty=\frac{2m-2}{\sqrt{(2m-1)(m-1)}} ,$$

so the row-mass bound on the sharp term is *saturated up to exactly one $\lVert\lambda\rVert_\infty$*: $\langle W,W^\#\rangle=(n-3)\lVert\lambda\rVert_\infty$ against a bound of $(n-2)\lVert\lambda\rVert_\infty$, both tending to $\sqrt2$ as $n\to\infty$, the bound from above and the truth from below. The AM–GM step alone costs $2.6\%$ there ($1.2136$ against $(n-2)\sum\lvert\lambda\rvert^3=1.2463$).

**The step that costs everything is $\lVert\lambda\rVert_\infty\le1$**, a factor of $7.4$ at $S^6\times S^6$ and unbounded in $n$. This matters practically: the useful object is the $\lVert\lambda\rVert_\infty$-graded (or $y$-graded) form, and the successor note points a reader at the wrong term to sharpen.

**Is $n-1$ vacuous?** Not formally: it is finite, and [I8](../plan.md) asks for an explicit $C_n$, so a dimension-growing constant yields a legitimate radius $r_n=c_n/C_n$. But it is $n-1$ against a numerically observed supremum of $\approx1.545$ that is flat in $n$, and post F11 caps any two-term split at $1+\sqrt2$, so no repair inside this argument reaches a dimension-free constant. **The $n$ in the answer is structural to the method, not an artefact of slack.**

## 5. (i) is true, and L140 does not prove it

**What L140 proves.** Its statement fixes the base point: "$g_1=\mathrm{Alt}(\mathcal D_u[H]+D_-)$ … along $u+tH$", and its proof's load-bearing object is a five-column table of Daleckii–Krein multipliers computed from **$u$'s own spectrum**, $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$ and $0$ on $K$. Nothing in it quantifies over base points. **(i)'s "holds at every base point" is therefore not an integration of L140; it is an unproved generalisation of it**, and the corollary's own header ("its input is Lemma L140, which passed") presents it as inherited.

**The generalisation is nevertheless true, by a fact the record does not state.** For $f(x)=\tfrac12(\lvert x\rvert-x)$ every divided difference is in $[-1,0]$ **at every spectrum**, not only at $u$'s:

$$\frac{f(a)-f(b)}{a-b}=\begin{cases}0,&a,b>0\\-1,&a,b<0\\ \dfrac{b}{a-b}\in(-1,0),&a>0>b\end{cases}\qquad f'(a)=\begin{cases}0,&a>0\\-1,&a<0.\end{cases}$$

So at any nonsingular base point $W$ the derivative is $D(W_-)[H]=M\circ H$ in $W$'s eigenbasis with $M$ entrywise in $[-1,0]$, hence $\lvert M+\tfrac12\rvert\le\tfrac12$ entrywise, hence $\lVert D(W_-)[H]+\tfrac12H\rVert\le\tfrac12\lVert H\rVert$; and $\mathrm{Alt}$ being linear with $\mathrm{Alt}(H)=0$ for Weyl $H$, $\lVert D(\mathrm{Alt}\,W_-)[H]\rVert\le\tfrac12\lVert H\rVert$. **At a singular base point the same estimate holds for the one-sided coefficient**, by L140's own kernel-block argument transplanted: the $(E,K)$ multipliers are $f(a)/a\in\{0,-1\}$, and the $K\times K$ block gives $Z_{KK}+\tfrac12H_{KK}=\tfrac12\lvert D\rvert$ of norm $\tfrac12\lVert D\rVert=\tfrac12\lVert H_{KK}\rVert$. **So (i) is TRUE and its citation is wrong.** The general Daleckii–Krein observation is the actual content and belongs on the record as its own line.

**The brief's question, does the integration cross base points where the kernel identity is needed?** It can cross nothing but such points: a segment between two tensors sharing a kernel (two zero-padded tensors, say) is singular at *every* interior point, so an "a.e. nonsingular" reading fails outright there. The estimate above covers those points directly, so the conclusion survives; but the corollary as written does not say so.

## 6. The fundamental theorem of calculus step, and what actually licenses it

(i) integrates a bound on a map that is only one-sidedly differentiable. Two remarks.

- **As written it needs an argument it does not give.** A bound on one-sided derivatives does not by itself give a Lipschitz estimate for a function that could jump; some regularity must come first.
- **The regularity is free, and the record already has it.** $W\mapsto W_-$ is nonexpansive in Frobenius norm by Moreau's decomposition, stated inside [Lemma L134](../findings/route-a.md)'s closing paragraph, and $\mathrm{Alt}$ is an orthogonal projection, so $\delta=\lVert\mathrm{Alt}(W_-)\rVert$ is $1$-Lipschitz on $\mathcal W_n$ before any of this. Given continuity, a one-sided (Dini) upper derivative bounded by $\tfrac12$ along the segment in both directions gives $\lvert\delta(W_1)-\delta(W_2)\rvert\le\tfrac12\lVert W_1-W_2\rVert$ by the standard mean-value argument for Dini derivatives, no Rademacher, no absolute continuity, no a.e. differentiability needed.

**So the conclusion stands, and (i)'s claim to be "the strongest global statement the route has produced" does not.** $\delta$ being $1$-Lipschitz was already in the record; (i) halves the constant.

## 7. (iii) drops the orthogonality L134(d) proves cannot be dropped

**The convex-analysis kernel of (iii) is correct.** With $g=f-\tfrac C2\lVert\cdot\rVert^2$ concave and $v=W-u$, concavity gives $g(u+v)\le g(u)+g'(u;v)$, and expanding $\lVert u+v\rVert^2$ the quadratic cross terms cancel exactly:

$$f(W)\;\le\;f(u)+f'(u;v)+\tfrac C2\lVert v\rVert^2 .$$

One-sided derivatives are positively homogeneous, so "nonpositive on unit directions" gives "nonpositive on all directions", and [Lemma L17](../findings/route-a.md) does supply $d^+\Phi\le0$ **in every direction** at $u$, not merely on the cone. **The arithmetic of the constant also checks**: $\tfrac12\mathrm{Hess}(P\vert_S)\le-\tfrac{\theta^*}2$ means $P$'s semiconcavity constant is $-\theta^*$, so $\Phi=P+\lvert\kappa_n\rvert\delta^2$ has $C_\Phi\le-\theta^*+\lvert\kappa_n\rvert C_{\delta^2}$, and $C_{\delta^2}\le\theta^*/\lvert\kappa_n\rvert$ gives $C_\Phi\le0$, consistent with [Lemma L134](../findings/route-a.md)(b)'s $c_2\le\theta^*/(2\lvert\kappa_n\rvert)$, the factor two being $C=2c_2$.

**And that is exactly where it fails.** [Lemma L134](../findings/route-a.md)(a) proves $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]\le-\tfrac{\theta^*}2$ **only for $H$ orthogonal to $T_u\mathcal O$**. L134(d) then records, in a paragraph headed "Why the orthogonality in (d) cannot be dropped" and attributed to both of its Gate 2 reviewers: for $H=\alpha H_{\mathrm{orb}}+\beta H_\perp$ the $P$-margin is $-\beta^2\theta^*/2$, "**the $P$-side margin degrades with $\beta^2$ while $c_2(H)$ need not**, so a threshold uniform over all of $\{F=0\}$ is false."

**Semiconcavity is by definition a bound with no direction excluded.** Feeding a single constant $C_{\delta^2}=\theta^*/\lvert\kappa_n\rvert$ into the display above requires the $P$-side constant $-\theta^*$ in every direction too. In orbit directions $\mathrm{Hess}(P\vert_S)$ vanishes identically, the orbit is the $\tfrac12$-eigenspace of $L_e$, on which $\mathrm{Hess}(P\vert_S)=6\theta^*(L_e-\tfrac12)$ is zero, so there

$$C_\Phi\;\le\;0+\lvert\kappa_n\rvert\cdot\frac{\theta^*}{\lvert\kappa_n\rvert}\;=\;+\theta^*\;>\;0,$$

and the conclusion is $\Phi(W)\le\theta_0+\tfrac{\theta^*}2d^2$, a **positive** slack, which is not [I3](../plan.md). **(iii) is the uniform threshold L134(d) refutes, restated in a vocabulary that hides the hypothesis.**

**Can it be rescued?** Partly, and the rescue changes the statement. If $u$ is taken to be the *nearest orbit point* to $W$, then $v=W-u$ is normal to $\mathcal O$ by the first-order condition, so the direction the display is applied in is the one L134(a) covers. But the semiconcavity is then used at the intermediate points $u+tv$, $0<t<1$, where $v$ is no longer normal to the orbit through that point and where no Hessian bound is on the record at all. **What is actually needed is one-dimensional semiconcavity of $\Phi$ along normal rays with a constant valid along the whole ray, not semiconcavity of $\delta^2$ with a constant at $u$**, and stating it that way makes visible that the missing ingredient is a neighbourhood statement about $P$ as well as about $\delta^2$. As printed, (iii) reads as though $P$'s side were finished.

## 8. (iv) is correct, and anchors itself

$\lvert W\rvert=W_++W_-$ and $W=W_+-W_-$ under [conventions.md](../findings/conventions.md)'s $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$; $\mathrm{Alt}(W)=0$ gives $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, hence $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ and $\delta=\tfrac12\lVert\mathrm{Alt}(\lvert W\rvert)\rVert$. **Correct.** $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, so $\lVert\mathrm{Alt}(X)\rVert^2=\sum_\Omega\langle X,\Omega\rangle^2$ over an orthonormal basis, and $\langle\lvert W\rvert,\Omega\rangle=\mathop{\mathrm{tr}}(\lvert W\rvert\Omega)$ since both are symmetric and the operator-level pairing is plain Frobenius. **The factor $\tfrac14$ is right.**

**An independent anchor, which the corollary does not give and which is worth having.** At $u$, [conventions.md](../findings/conventions.md) fixes $\mathrm{Alt}(u_-)=a\star$ with $a=\tfrac1{3\sqrt6}$ and $\lVert\star\rVert^2=6$; then $\delta^2(u)=a^2\lVert\star\rVert^2=\tfrac6{54}=\tfrac19$, which is [Lemma L134](../findings/route-a.md)'s value exactly. Three conventions confirm each other in one line.

**One live trap the display invites.** $\{\Omega\}$ must be orthonormal in the operator Frobenius norm. Inside $\Lambda^2\mathbb R^4$, $\Lambda^4$ is spanned by $\star$ with $\lVert\star\rVert^2=6$, so the basis element is $\star/\sqrt6$; writing $\mathop{\mathrm{tr}}(\lvert W\rvert\star)^2$ inflates by $6$. The display is right and one substitution away from being wrong.

## 9. (v) disposes of the obstruction at first order only

**The double eigenvalue: confirmed.** $u$'s repeated $-\tfrac1{\sqrt6}$ has both copies strictly on the negative axis, where $\lvert\cdot\rvert$ is affine, so every divided difference among them is $-1$ and every second divided difference vanishes. The pairings of that eigenvalue with $\tfrac2{\sqrt6}$ and with $0$ have nonzero denominators. **No blow-up from the coalescence at $-\tfrac1{\sqrt6}$.**

**The kernel: the claim overreaches.** $u$'s kernel $K$ has dimension $N-3$, the coalescence there is enormous, and it sits at $0$, the one point where $\lvert\cdot\rvert$ has no derivative, so the obstruction *does* fire there. (v)'s answer is that the kernel contributes "the exactly homogeneous $t\lvert D\rvert$, whose second derivative in $t$ vanishes". That is the **leading** term only, and [Lemma L140](../findings/route-a.md) says so in its own words: "$Z_{KK}=D_-$ **exactly** … the Schur term $C^\top\Lambda^{-1}C$ **enters at $t^2$** and a first-order coefficient never sees it."

**$c_2$ is a second-order coefficient, so it sees it.** The kernel block is $tD+t^2S+O(t^3)$ with $S=-C^\top\Lambda^{-1}C$, and

$$\lvert tD+t^2S\rvert\;\ne\;t\lvert D\rvert ,$$

the correction being $t^2\,\mathrm{D}\lvert\cdot\rvert_D[S]$, a derivative that **does not exist when $D=P_0HP_0$ is singular**, which is not a rare event on a block of dimension $N-3$. Homogeneity kills the $t$-dependence of the leading term and says nothing about the correction. **So (v) is correct about the double eigenvalue and incomplete about the kernel: it retires the obstruction at the order [Lemma L140](../findings/route-a.md) needed and leaves it standing at the order the item needs.** This is the same shape as the omission that refuted [L137](REVIEW_r425.md), a term invisible at first order and load-bearing at second.

## 10. (vi) gives away the uniformity it claims to keep

(vi) says the item is "exactly"

$$\sup_{\lVert H\rVert=1}\ \limsup_{t\to0^+}\ \frac{\delta^2(\gamma_H(t))-\tfrac19}{t^2}\ \le\ \beta,\qquad\text{"with the supremum outside".}$$

**Putting the supremum outside the $\limsup$ does not make the radius uniform.** What that display asserts is a bound on the per-ray *coefficients*: for each $H$ and each $\epsilon>0$ there is some $t_H>0$ with $\delta^2(\gamma_H(t))-\tfrac19\le(\beta+\epsilon)t^2$ for $t<t_H$. The quantifier on $t_H$ is inside, and $\inf_{\lVert H\rVert=1}t_H$ may be $0$. The ceiling the item needs is

$$\sup_{\lVert H\rVert=1}\ \sup_{0<t<r}\ \frac{\delta^2(\gamma_H(t))-\tfrac19}{t^2}\ \le\ \beta\quad\text{for some }r>0,$$

with a **supremum over $t$**, not a limit. These are not equivalent, and the gap is the classical one: a function can satisfy a second-order bound along every ray through a point and fail $O(d^2)$ on every ball, the excess living on a set that touches each ray only at a scale depending on the ray. **Compactness of the unit sphere of $\mathcal W_n$ does not close it**, the coefficient function $H\mapsto\limsup_t(\cdot)$ is at best upper semicontinuous, and upper semicontinuity of a limit gives no uniform radius.

**The two-sidedness half of (vi) is right, and is not the same half.** It is correct that the ceiling quantifies over a neighbourhood, that the unit-direction set is symmetric, that $-H$ is a direction in its own right, and that every punctured-ball point is $\gamma_H(t)$ for some $H$ and some $t>0$; so a one-sided kink in one direction is indeed not by itself fatal. **But the sentence "semiconcavity is strictly stronger than what is wanted" then draws the wrong conclusion**, because semiconcavity was supplying two things at once (two-sidedness *and* a bound valid at every $t$ in an interval) and the replacement keeps only a bound as $t\to0^+$. **The item as displayed is strictly weaker than the item.**

**Two further notes on the display.**

- **It has no cone and no orthogonality.** Quantifying over all $\lVert H\rVert=1$ rather than over $\{F=0\}\cap T_u\mathcal O^\perp$ reintroduces §7's defect. Off the cone the display is *vacuously* satisfied rather than false, [Lemma L17](../findings/route-a.md) gives $d^+\Phi\le0$ and $d^+P=0$ at the critical $u$, hence $d^+\delta^2\le0$, and a strictly negative first-order term sends the quotient to $-\infty$, so the content sits entirely on the cone and the display's apparent generality is empty. On directions with an orbit component, a single $\beta$ is L134(d)'s refuted uniform threshold again.
- **The kink is first order, not second.** The term (v) discusses, $\lvert t\rvert\mathop{\mathrm{tr}}(\Pi\lvert D\rvert)$, is $O(\lvert t\rvert)$; divided by $t^2$ it diverges. It is harmless only because L17 cancels the whole first order on the cone, that is, the kink is disposed of by the cone hypothesis the display omits, not by the symmetry of the direction set.

## 11. The kernel block is where the radius does degenerate

(vi) closes by reassuring that the analyticity radius cannot degenerate on the kernel block: "the effective operator is $tD_s$ with $D_s\to D$, its negative part is $t(D_s)_-$ by positive homogeneity, and $N\mapsto N_-$ is Lipschitz, so no branch radius shrinks there."

**The reason is a non sequitur.** Lipschitz continuity of $N\mapsto N_-$ is a statement about continuity; a Rellich radius is the distance to the nearest crossing of analytic eigenvalue branches. Lipschitzness of the negative-part map bears on neither the location of those crossings nor the radius of convergence of the branches, and a Lipschitz function of an analytic family is in general not analytic at all.

**And the conclusion points the wrong way.** On the kernel block the branches are $\lambda_i(t)=t\mu_i+O(t^2)$ with $\mu_i\in\mathop{\mathrm{spec}}(D)$, $D=P_0HP_0$. The one-sided analyticity of $t\mapsto\lvert\lambda_i(t)\rvert$ near $0^+$ persists only up to the next zero of $\lambda_i$. **When $D$ is singular ($\mu_i=0$ for some $i$), the location of that zero is fixed by the $O(t^2)$ terms and can be $o(t)$-close to the origin, and as $H$ varies over a family approaching a singular $D$ the radius goes to zero.** The set of $H$ with $P_0HP_0$ singular is not exceptional on a block of dimension $N-3$; it is where a generic family of directions passes. **So the kernel block is the first place to look for the degeneration (vi) declares impossible there, and the corollary's one piece of positive evidence for the reduction is the piece that fails.**

*Symmetrically*, the reassurance would be worth something if it were made about $D_s$'s **spectral gaps** rather than about the Lipschitz constant of $N\mapsto N_-$; that is the quantity a Rellich radius is controlled by, and it is exactly what is unbounded below as $D$ approaches singularity.

---

## What should change

**On L142.** The inequality is true and may stay, but not as it is framed.

1. The header note "the record carries no proved bound at all" is false and should be struck; [second-order.md](../findings/second-order.md) carries $\theta\le\sqrt y+(n-2)y$ and $\theta\le\lambda_{\max}p+B_5$, both proved, both pointwise, both stronger, and the first one is twenty lines below the post F11 the note cites.
2. [INDEX-results.md](../findings/INDEX-results.md) row 142's "the record's first **proved** bound on $P$" should be corrected on the same ground.
3. If the lemma is kept, its display should be $\lvert P(X)\rvert\le(n-1)\lVert\lambda\rVert_\infty$ (what its own proof gives) and its "where it is loose" note should name $\lVert\lambda\rVert_\infty\le1$ rather than the row-mass step, which is saturated to one $\lVert\lambda\rVert_\infty$ on the balanced sphere products.
4. The one genuinely new line, $\lvert\langle X,X^\#\rangle\rvert\le(n-2)\sum_\alpha\lvert\lambda_\alpha\rvert^3$, is a marginal sharpening of a recorded bound and belongs folded into that section.

**On L140.1.**

1. (i) is true; its proof is not the integration of [Lemma L140](../findings/route-a.md) that it claims, and the general Daleckii–Krein fact (every divided difference of $\tfrac12(\lvert x\rvert-x)$ lies in $[-1,0]$ at every spectrum), should be recorded as the actual input. The Lipschitz claim's regularity comes from Moreau, already in [Lemma L134](../findings/route-a.md), and should be cited.
2. (iii) must carry the orthogonality-to-$T_u\mathcal O$ hypothesis, and must say that the $P$-side Hessian bound is being assumed on a neighbourhood rather than at $u$. Without both it is the threshold L134(d) refutes.
3. (v)'s kernel sentence should be restricted to first order, with the $t^2$ Schur term named as unresolved.
4. (vi)'s display should be rewritten with $\sup_{0<t<r}$ in place of $\limsup_{t\to0^+}$, over $\{F=0\}\cap T_u\mathcal O^\perp$; and the kernel-block reassurance should be withdrawn, the branch radius there being governed by $\mathop{\mathrm{spec}}(P_0HP_0)$ and degenerating exactly where that spectrum touches zero.

*Reviewer r436, 2026-09-03. Log: [r436-L142.log](../agent_logs/r436-L142.log).*
