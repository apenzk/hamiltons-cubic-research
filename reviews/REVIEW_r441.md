# Review r441, the I2 tube, second audit: asymmetry, analyticity radius, remainder constant

*Reviewer r441, 2026-09-03, cold brief. Target: the three claims of the [I2](../plan.md) item **in their corrected form**, (1) the kernel-free asymmetry with the divided-difference exception, (2) the analyticity radius $g_n$, (3) $C_P=O(n)$, the Riesz and Cauchy steps, $M=O(g_n)$, $(\delta^2)'''=O(n)$ and $r_n=\Omega(n^{-2})$. Supporting material: [Lemma L133](../findings/second-order.md), [Lemma L141](../findings/second-order.md), [Lemma L107](../findings/bounds.md), [route-a.md](../findings/route-a.md). **Second audit**: [r439](REVIEW_r439.md) filed on the pre-correction text; I formed every verdict before reading it and compare at the end. **Analysis only**: every derivation below is by hand. One numerical screen re-evaluates closed forms I had already derived and is reported as a screen. Working: [agent_logs/r441-tube.log](../agent_logs/r441-tube.log).*

## Verdicts

| claim | verdict | one line |
| --- | --- | --- |
| **(1) asymmetry** | **CONFIRMED** | both halves hold in the corrected form; the atom, kink and one-sidedness are exactly the zero-eigenvalue locus's, the ball of radius $g_n$ is genuinely free of it, and the divided-difference blow-up is genuinely a gap phenomenon at rate $n$, I computed the rate |
| **(2) analyticity radius** | **CONFIRMED** | recomputed from the product-of-spheres curvature operator; every multiplicity, the norm identity, the comparison, the closed form and $g_{12}$ check, and "gap at $0$" is the right quantity for the reason the item gives |
| **(3) remainder constant** | **PLAUSIBLE** | $r_n=\Omega(n^{-2})$ is right and I re-derived every constant, but the written chain omits three load-bearing steps and one of its paragraphs asserts $C_\delta=O(n^3)$ and $C_\delta=O(n)$ side by side |
| **[Lemma L141](../findings/second-order.md)(b) monotonicity step** | **CONFIRMED, and it closes the gap** | the displayed $s$-formula is *exact*, not an estimate; but the sentence immediately above it is invalid in **two** independent ways and must be struck |

**The one sentence that matters.** Every number in this item is correct and I could break none of them; what the item still has is the second failure shape the brief names (a correct conclusion whose written chain does not reach it), in four separate places, one of which is a paragraph of I2 that contradicts a paragraph of I2 three lines above it.

---

## Claim (2), the spectrum and the gap. CONFIRMED.

Recomputed from the product-of-spheres Weyl tensor with [Lemma L133](../findings/second-order.md) unopened.

**Unnormalised.** Unit factors give $\mathcal R=\mathrm{id}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ and $0$ on the $m^2$ mixed planes. $\mathop{\mathrm{tr}}_{\Lambda^2}\mathcal R=m(m-1)$, so $s=2m(m-1)$, which is the two factors' scalar curvatures summed, an independent check. The metric is Einstein, so the traceless-Ricci term drops and $W^*=\mathcal R-\tfrac s{n(n-1)}\mathrm{id}=\mathcal R-\tfrac{m-1}{2m-1}\mathrm{id}$: eigenvalue $\tfrac m{2m-1}$ at multiplicity $2\binom m2=m(m-1)$, eigenvalue $-\tfrac{m-1}{2m-1}$ at multiplicity $m^2$, trace $0$.

**Normalised.** $\lVert W^*\rVert_F^2=\tfrac{m^2(m-1)}{2m-1}$, so the normaliser is $m\sqrt{\tfrac{m-1}{2m-1}}$ and

$$\lambda_+=\frac1{\sqrt{(m-1)(2m-1)}},\qquad \lambda_-=-\frac1m\sqrt{\frac{m-1}{2m-1}}.$$

| check | my value | claim |
| --- | --- | --- |
| multiplicities | $m(m-1)+m^2=m(2m-1)=\binom{2m}2$ | full, no kernel ✓ |
| $\sum\lambda^2$ | $\tfrac m{2m-1}+\tfrac{m-1}{2m-1}=1$ | exact, and in the item's own two-term form ✓ |
| $\lvert\lambda_-\rvert/\lambda_+$ | $\tfrac{m-1}m<1$ | ✓ so the gap at $0$ is $\lvert\lambda_-\rvert$ |
| $g_n$ | $\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}\to\tfrac{\sqrt2}n$ | ✓ |
| $g_{12}$ | $\tfrac16\sqrt{5/11}=0.1123666$ | ✓ |

**Is "gap at $0$" the right quantity for an analyticity radius? Yes, and for a sharper reason than the item gives.** The function applied is $f(x)=x\mathbf1_{x<0}$, whose only non-analyticity is at $0$. On any open set of symmetric tensors missing the zero-eigenvalue locus, the Riesz projection onto $\mathop{\mathrm{spec}}\cap(-\infty,0)$ is real-analytic, hence so are $W_-$ and $\delta^2$. Weyl's inequality with $\lVert H\rVert_{\mathrm{op}}\le\lVert H\rVert_F$ makes the *Frobenius* ball of radius $\min_a\lvert\lambda_a\rvert=g_n$ safe. Spectral degeneracy is irrelevant, individual eigenvectors are not analytic under multiplicity, but the cluster projection is.

---

## Claim (1), the asymmetry. CONFIRMED, both halves.

**$\mathrm{Alt}(W^*_-)=0$, re-derived.** $W^*_-$ is a multiple of $\Pi_{\text{mixed}}=\mathrm{id}_{\Lambda^2}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2}$. The first is the round sphere's curvature operator; the other two are the curvature operators of $S^m\times\mathbb R^m$. All three are genuine curvature tensors, so all three satisfy the first Bianchi identity and have zero $\Lambda^4$ part. Correct.

**The atom is confined to the zero-eigenvalue locus, and the record's assertion survives the brief's attack.** [route-a.md](../findings/route-a.md) gives the atom density as $2\lvert\lambda'\rvert\,\mathrm{Alt}(W_-)(v,v)$ for $v\in\ker W$. The brief asks whether an eigenvalue crossing *near* $W^*$ can reinstate one. It cannot, for two reasons I checked separately:

- **Same-sign collisions are invisible.** A collision of two negative eigenvalues (abundant here, the multiplicities are $m(m-1)$ and $m^2$) leaves the cluster projection untouched, and $W_-=W\Pi_-(W)$ depends on the cluster, not on the individual branches. $\delta^2$ stays real-analytic through it.
- **Opposite-sign collisions force a zero crossing.** If $\lambda_a<0<\lambda_b$ meet at value $v$ along a path, then $v>0$ sends $\lambda_a$ through $0$, $v<0$ sends $\lambda_b$ through $0$, and $v=0$ sends both. So inside the kernel-free ball no opposite-sign collision can occur at all.

**The exception is real, and I computed its rate.** For $f(x)=x_-$ the *first* divided difference over $(\lambda_-,\lambda_+)$ is $\tfrac{m-1}{2m-1}\to\tfrac12$, bounded, no blow-up. The *second* is

$$f^{[2]}(\lambda_-,\lambda_-,\lambda_+)=\frac{f'(\lambda_-)-f^{[1]}(\lambda_-,\lambda_+)}{\lambda_--\lambda_+}=-\frac{m^2\sqrt{(m-1)(2m-1)}}{(2m-1)^2}\;\sim\;-\frac{\sqrt2}4\,m\;=\;\Theta(n),$$

and the third is $\Theta(n^2)$, since each further divided difference of a piecewise-linear function over two points costs one power of $\lambda_+-\lambda_-=\Theta(1/n)$. So the blow-up is a **gap** phenomenon, present at $W^*$ at rate $n$ per derivative, and it is exactly the $A'''=O(n^2)$ that claim (3) pays. The item's corrected statement is right on both sides of the line it draws.

---

## Claim (3), the remainder constant. PLAUSIBLE.

### $C_P=O(n)$, the chain holds, with one link the item does not state.

$P(W)=T(W,W,W)$ is a symmetric cubic ([problem.md](../findings/problem.md)), so $P(-W)=-P(W)$ and $\sup\lvert P\rvert=\sup P$ on the unit sphere with no argument at all. The sphere is compact, so $\sup P$ is attained; a maximiser is a critical point with $Q(W)=\theta W$, $\theta=P(W)$; and [Lemma L107](../findings/bounds.md) gives $\theta\le(n-1)\lvert\lambda_{\min}\rvert\le n-1$ because $\sum\lambda^2=1$.

**The unstated link.** [bounds.md](../findings/bounds.md)'s own box says relation (C) "holds only at critical points", so L107 is a critical-point bound. The chain is legitimate *only* because the supremum is attained at a critical point, which the item does not say. It is a link, not an error, and a second route makes it moot: [bounds.md](../findings/bounds.md) records a *pointwise at unit norm* $\theta\le\sqrt y+(n-2)y$ with $y=\lVert\lambda\rVert_4^2\le1$, giving $n-1$ unconditionally.

**Do the trigonometric tails contribute more than claimed? No.** Along $W(t)=\cos t\,W^*+\sin t\,H$,

$$P(W(t))=\cos^3t\,\theta_0+3\cos^2t\sin t\,B(W^*,W^*,H)+3\cos t\sin^2t\,B(W^*,H,H)+\sin^3t\,P(H),$$

with $B(W^*,W^*,H)=0$ by criticality and $H\perp W^*$. Each trigonometric monomial of total degree $3$ has $\lvert d^3/dt^3\rvert\le27$, and $\lvert B(W^*,H,H)\rvert\le\tfrac{3^3}{3!}\sup\lvert P\rvert$ by the symmetric-multilinear polarisation constant. So $C_P\le 27\big(\theta_0+O(1)+O(\sup\lvert P\rvert)\big)=O(n)$, with an absolute constant. The tails are $O(1)$ and the $\sin^3t\,P(H)$ term is what carries the $n$.

### The Riesz step, $\rho<g_n$ is sufficient, and the reason generalises.

The item asserts holomorphy on $\lvert z\rvert<\rho<g_n$ without giving the separating-contour argument. Here it is, and it is stronger than the two-valued case needs.

- **Localisation.** $W^*$ is Hermitian hence normal, so Bauer–Fike is exact with condition number $1$: every eigenvalue of $W^*+zH$ lies within $\lvert z\rvert\lVert H\rVert_{\mathrm{op}}\le\rho$ of $\{\lambda_+,\lambda_-\}$.
- **Separation, in general.** For *any* real spectrum, (smallest positive) $-$ (largest negative) $\ge 2\mathop{\mathrm{dist}}(\mathop{\mathrm{spec}},0)$. So $\rho<\mathop{\mathrm{dist}}(\mathop{\mathrm{spec}},0)$ always leaves the two perturbed clusters strictly separated by the imaginary axis, and $\mathop{\mathrm{dist}}(\Gamma,\mathop{\mathrm{spec}})\ge g_n-\rho$, matching the item's $O(1/(g_n-\rho))$. **$\rho<g_n$ is therefore sufficient at every base point in the tube, not only at $W^*$ by the accident of a two-valued spectrum.**
- **Diagonalisability is not needed and does not hold.** A complex symmetric matrix can be defective. Nothing in the argument uses diagonalisability: $\Pi=\tfrac1{2\pi i}\oint_\Gamma(w-A)^{-1}dw$ is defined and holomorphic whenever $\Gamma$ misses the spectrum.
- **The projection stays bounded, with a caveat on the constant.** With $\Gamma$ the circle of radius $g_n/2$ about $\lambda_-$ and $\rho=g_n/4$, the Neumann ratio is $\tfrac12$, the resolvent is $\le4/g_n$ and $\lVert\Pi\rVert\le2$. **The item's stated choice $\rho=g_n/2$ is borderline** (it makes the Neumann ratio exactly $1$ against a contour at distance $g_n/2$) and needs either a smaller $\rho$ or a contour at radius $\approx(\lambda_+-\lambda_-)/2$. A constant, not an exponent. $\Pi$ is **not** orthogonal off the Hermitian locus, so $\lVert\Pi\rVert\le1$ would be false; the item does not claim it.

### The Cauchy step, $M=O(g_n)$ is right, and it does survive complexification.

Take $\Gamma$ the circle of radius $g_n/2$ about $\lambda_-$ (contour-independent from the half-plane choice; the same eigenvalues are enclosed). Then $\lvert\Gamma\rvert=O(g_n)$, $\max_{w\in\Gamma}\lvert w\rvert\le\lvert\lambda_-\rvert+g_n/2=O(g_n)$, $\lVert R_w\rVert_{\mathrm{op}}\le2/g_n$. Expanding $W_-(z)-W^*_-$ in Neumann terms and **spending the Frobenius norm once, on $H$, and never on the resolvent**:

$$\text{term }k\;\le\;\frac{\lvert\Gamma\rvert}{2\pi}\max_w\lvert w\rvert\;\lVert R_w\rVert_{\mathrm{op}}^{k+1}\rho^k\lVert H\rVert_F\lVert H\rVert_{\mathrm{op}}^{k-1}\;=\;\tfrac32 g_n\cdot2^{-k},\qquad k\ge1,$$

summing to $\le\tfrac32 g_n$. **The zeroth term is the only one that must spend the Frobenius norm on the resolvent itself**, $\lVert R_w\rVert_F=O(m/g_n)$, giving $O(mg_n)=O(1)$, in exact agreement with the true value $\lVert W^*_-\rVert_F=\sqrt{\tfrac{m-1}{2m-1}}\to\tfrac1{\sqrt2}$. So the zeroth term is the unique $\Theta(1)$ term, and $\mathrm{Alt}$ annihilates it. **$M=O(g_n)$, confirmed, and the mechanism is exactly the one claimed.**

**It survives complexification** because $\mathrm{Alt}(W^*_-)=0$ is a statement at $z=0$ about the base point, and the zeroth Neumann term is $W^*_-$ for every $z$; $\mathrm{Alt}$ complexifies to a Hermitian idempotent of norm $1$. Cauchy then gives $\lVert A'''(0)\rVert\le6M/\rho^3=O(g_n^{-2})=O(n^2)$, matching the third divided difference independently computed above.

### Passing to $\delta^2$, the exponent does improve, and the counterfactual confirms it.

$(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$. At $t=0$, $A(0)=\mathrm{Alt}(W^*_-)=0$ kills the first term; $\lVert A'\rVert\le\tfrac12$ is [Lemma L141](../findings/second-order.md)(a) and $\lVert A''(0)\rVert\le2M/\rho^2=O(n)$. So $(\delta^2)'''(0)=O(n)$.

**Counterfactual, as a consistency test.** Had $\mathrm{Alt}(W^*_-)$ been nonzero, $M=\Theta(1)$ would give $A'''=O(n^3)$, $\lVert A\rVert=O(1)$, $\lVert A''\rVert=O(n^2)$, $\lVert A'\rVert=O(n)$, hence $(\delta^2)'''=O(n^3)$ and $r_n=\Omega(n^{-4})$, precisely the figure the record says it first carried. The two accountings differ exactly by the two uses of the vanishing, one power each. The story is internally consistent.

### FINDING 1, the Taylor remainder needs a supremum over the interval, and the chain closes only by an unstated bootstrap.

The item proves $(\delta^2)'''$ at the base point. The remainder needs $\sup_{\lvert t\rvert\le r}$, where $\lVert A(t)\rVert\le\tfrac12\lvert t\rvert$ makes $\langle A''',A\rangle=O(n^2r)$. That is $O(n)$ only if $r=O(1/n)$, and $r$ is what is being derived. The chain closes as a bootstrap: assume $r\le1/n$, obtain $C=O(n)$, obtain $r=6c_n/C=\Omega(n^{-2})\le1/n$, consistent. **The conclusion survives; the step is nowhere written.**

### FINDING 2, one paragraph of I2 asserts two incompatible values for $C_\delta$.

[plan.md](../plan.md) line 80 reads "$C_\delta=O(g_n^{-3})=O(n^3)$" and, two sentences later in the same paragraph, "**Both are $O(n)$**". The superseded sentence was never struck. A reader taking the paragraph at face value cannot tell which figure the item stands behind.

### FINDING 3, the relative-gap error is still live in three places, one of them inside I2 itself.

The absolute gap the resolvent needs is $g_n=\Theta(1/n)$; $\tfrac{m-1}{2m-1}\to\tfrac12$ is the gap of the *unnormalised* operator, i.e. a relative gap, and reading it as the resolvent's gap overstates the radius by a factor $n$. The item states the correct $g_n$ at [plan.md](../plan.md) line 76 and the correction is recorded at [plan.md](../plan.md) line 128 and warned about at [second-order.md](../findings/second-order.md) line 896. Three occurrences survive:

| location | text | status |
| --- | --- | --- |
| [plan.md](../plan.md) line 84, **inside I2, eight lines below the correct $g_n$** | "the defect's is the harder half, controlled through the spectral gap $\tfrac{m-1}{2m-1}$ by the resolvent" | live |
| [plan.md](../plan.md) line 51 | "Daleckii–Krein … needs a spectral gap at $0$; the balanced product has gap $(m-1)/(2m-1)$" | live |
| [second-order.md](../findings/second-order.md) line 900, [Lemma L141](../findings/second-order.md)'s closing paragraph | the same sentence, *and* "its own remainder along a great circle is **exactly** $\sin^3t\,P(H)$" | live, both |

The "exactly $\sin^3t\,P(H)$" error was corrected in [plan.md](../plan.md) line 84 and left standing in the lemma it came from.

---

## [Lemma L141](../findings/second-order.md)(b), the monotonicity step. CONFIRMED, and the sentence above it must go.

**The step is exact, not an estimate.** On a $(2,2)$-split four-set block the first Bianchi identity makes the block $\mathbf1^\perp$, two-dimensional, spanned by $(2,-1,-1)$ at $L_e=+\mu$ and $(0,1,-1)$ at $L_e=-\mu$. Write $H=\alpha(2,-1,-1)+\beta(0,1,-1)$ and $s=6\alpha^2/(6\alpha^2+2\beta^2)$. Then, using $\tfrac12\mathrm{Hess}=3\theta_0(L_e-\tfrac12)$ and [Lemma L133](../findings/second-order.md)'s $\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac\gamma3x^2$ with $x=2\alpha$:

$$\frac{\tfrac12\mathrm{Hess}}{\lVert H\rVert^2}=3\theta_0\big(2\mu s-\mu-\tfrac12\big),\qquad \frac{\lVert\mathrm{Alt}\,DW_-[H]\rVert^2}{\lVert H\rVert^2}=\frac29 s,$$

both **exactly**, with $\gamma$ cancelling. Adding $-\kappa_n=+\lvert\kappa_n\rvert$ times the second reproduces the recorded $Q/\lVert H\rVert^2=3\theta_0(2\mu s-\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert s$, whose slope $6\theta_0\mu+\tfrac29\lvert\kappa_n\rvert$ is strictly positive. Maximum at $s=1$. **Verified.**

**And it closes the gap it was added for.** At $s=1$ the block value is $3\theta_0(\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert$; the requirement that it clear $-c_n=-3\theta_0/(n-2)$ is $\tfrac{9\theta_0}{n-2}+\tfrac29\lvert\kappa_n\rvert\le\tfrac32\theta_0$, which holds with room at $n=12$ ($1.135$ against $1.854$), at $n=20$ ($0.820$ against $1.962$) and in the limit ($0.379$ against $2.121$). So the pair block binds and $c_n=3\theta_0/(n-2)$ stands, attained on the within-factor pair block where $\tfrac12-\tfrac{m-2}{2(m-1)}=\tfrac1{n-2}$.

### FINDING 4, the sentence above the monotonicity paragraph is invalid in two independent ways.

It reads: *"so $Q\le(\kappa_n^{\mathrm{Hess}}-\kappa_n)d(H)^2\le-4.598\lvert\kappa_n\rvert\sigma\lVert H\rVert^2$ there with $\sigma\le\tfrac29$ …; that is more negative than $-\tfrac{3\theta_0}{n-2}$ at every $n\ge12$."*

- **The $\sigma$ bound runs the wrong way.** The quantity being bounded is negative and is multiplied by $\sigma$; bounding $\sigma$ from *above* by $\tfrac29$ does not make the product more negative, it makes it vanish as $\sigma\to0$. **This is fatal on its own, independently of which ratio is substituted**, and it is exactly the trade-off the monotonicity formula resolves: small $s$ means less defect response *and* a more negative Hessian, and only the exact $s$-formula sees that both move together.
- **The final comparison is false at $n=12$.** Screen (re-evaluating closed forms already derived by hand; reported as a screen):

| $n$ | written bound $-4.598\lvert\kappa_n\rvert\cdot\tfrac29$ | true block value at $s=1$ | $-c_n$ | written chain |
| --- | --- | --- | --- | --- |
| 12 | $-0.10381$ | $-1.08985$ | $-0.37081$ | **fails** |
| 14 | $-0.33966$ | $-1.18781$ | $-0.31542$ | holds |
| 20 | $-0.76258$ | $-1.35977$ | $-0.21795$ | holds |
| 100 | $-1.54711$ | $-1.66771$ | $-0.04264$ | holds |

*(The written chain also fails at $n=13$, at $-0.23089$ against $-0.34087$; I record it and then discount it, since [Lemma L141](../findings/second-order.md)(b) is stated at $n=2m$ and odd $n$ is outside its hypothesis.)*

The italic aside inside that same sentence **disowns** the infimum substitution while the main clause still **performs** it. **The lemma's conclusion is correct; that sentence proves nothing and should be struck, leaving the monotonicity paragraph as the whole of the proof of the $(2,2)$ block.**

---

## Vacuity

**Not vacuous, negligible as a covering, and the exponent is the method's ceiling rather than a lower bound.**

- **As a statement it is non-vacuous, and strictly so.** $\kappa_n<0$ for every $n\ge12$, so $\theta_0+\kappa_n\delta^2<\theta_0$ off the orbit: the tube inequality is *stronger* than $P\le\theta_0$ there, not a restatement of it. The tube is a nonempty open neighbourhood, and its analyticity radius $g_n=\Theta(1/n)$ comfortably exceeds $r_n=\Theta(n^{-2})$, so the construction is not self-defeating.
- **As a covering it is worth nothing.** $\dim\mathcal W_{12}=\tfrac{12\cdot13\cdot14\cdot9}{12}=1638$ and $\dim\mathcal O=\dim SO(12)-\dim(O(6)\times O(6))=66-30=36$, a codimension of $1602$; a tube of radius $r_{12}$ has relative volume of order $r_{12}^{1602}$. Scenario γ is the conjecture with an immeasurably small piece removed.
- **The exponent cannot be improved by sharpening either constant.** $c_n=3\theta_0/(n-2)=\Theta(1/n)$ is *attained*, and $C_\delta=\Theta(n)$ is forced by the second divided difference $f^{[2]}=\Theta(n)$ computed above, which is a property of the spectrum and not of the estimate. So $r_n=\Theta(n^{-2})$, absent an unproven cancellation in $\langle A'',A'\rangle$. **$\Omega(n^{-2})$ is the right order, not slack**, and the annulus immediately outside the tube carries the same $\Theta(1/n)$ Hessian gap, so nothing new is available there.
- **The item's own theorem statement is not yet met.** I2 promises "a tube of **explicit** radius $r_n$". An $\Omega$ with unpinned absolute constants is an order, not an explicit radius. The item says so; the theorem line does not.

---

## Where I differ from [r439](REVIEW_r439.md)

Read after forming every verdict above. r439 audited the **pre-correction** text; the corrections have since been folded into I2, so our verdict labels differ where the text differs. We agree on claim (2) in full, on claim (1)'s core, on $C_P=O(n)$, on $M=O(g_n)$, on $(\delta^2)'''=O(n)$, on $r_n=\Omega(n^{-2})$, on L141(b)'s $n=12$ failure, and on the vacuity accounting including $\dim\mathcal O=36$. Four places where I add or differ:

1. **L141(b)'s broken sentence has a second, independent defect.** r439's Finding F attributes it solely to substituting the $n\to\infty$ ratio $5.598$ where $49.27$ is available. The $\sigma\le\tfrac29$ direction error is separate and is not repaired by fixing the ratio. **Consequence: the sentence is unsalvageable, where r439's diagnosis implies it could be patched.**
2. **r439's own Cauchy derivation has the complexification gap the brief asks about.** Its first Neumann term is justified as "the Daleckii–Krein derivative, entrywise multipliers in $[0,1]$", a Hermitian-only fact, applied on the complex circle $\lvert z\rvert=\rho$ where $W^*+zH$ is not Hermitian. Its conclusion $M=O(g_n)$ is right; the contour/Neumann estimate above is what actually establishes it off the real axis.
3. **The $\rho<g_n$ sufficiency generalises.** r439 gets it from the two-valued separation $(\lambda_+-\lambda_-)/2>g_n$. The general fact (smallest positive minus largest negative is always at least twice the distance to $0$), matters because the tube argument is applied at base points other than $W^*$, where the spectrum is no longer two-valued.
4. **Three of r439's flagged errors are still live**, including one *inside* I2 (Finding 3 above), and its Finding B second bullet (the $\mathcal E_D$ listing) is now moot: the corrected text lists only the atom, the kink and the one-sidedness, all three of which I confirm are genuinely kernel phenomena.

## What a successor should fix

1. **Strike the sentence above [Lemma L141](../findings/second-order.md)(b)'s monotonicity paragraph.** It is invalid in the $\sigma$ direction as well as in the ratio, and the paragraph below it is a complete proof without it.
2. **Fix the three surviving relative-gap sentences**, [plan.md](../plan.md) lines 51 and 84, [second-order.md](../findings/second-order.md) line 900, and the "exactly $\sin^3t\,P(H)$" that line 900 still carries.
3. **Strike "$C_\delta=O(g_n^{-3})=O(n^3)$"** from I2's paragraph, which asserts $O(n)$ three sentences later.
4. **Write the three missing steps**: the separating-contour argument for $\rho<g_n$, the Neumann/contour estimate that carries $M=O(g_n)$ into the complex disc, and the bootstrap that upgrades $(\delta^2)'''(0)=O(n)$ to a supremum over $\lvert t\rvert\le r_n$. All three close; none is written.
5. **Take $\rho=g_n/4$ rather than $g_n/2$**, at which the Neumann ratio is $\tfrac12$ instead of $1$.
6. **State the exponent as $\Theta(n^{-2})$ and say what it costs**: $c_n$ is attained and $C_\delta$ is forced by the second divided difference, so this is the method's ceiling, and I2's promise of an *explicit* radius is still owed.

*r441, filed complete. Full working in [agent_logs/r441-tube.log](../agent_logs/r441-tube.log).*
