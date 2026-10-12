# Review r457, adversarial audit of [Lemma L151](../findings/second-order.md): the four-constant reduction, and the free parameter it calls forced

*Reviewer r457, 2026-09-03, cold adversarial brief. Target: [Lemma L151](../findings/second-order.md), "three of the four Cauchy constants are pinned, and the fourth is named". Read in full: [Lemma L151](../findings/second-order.md), [Lemma L149](../findings/second-order.md), [Lemma L148](../findings/second-order.md), [Lemma L147](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [conventions.md](../findings/conventions.md), [REVIEW_r450.md](REVIEW_r450.md), [REVIEW_r451.md](REVIEW_r451.md), [REVIEW_r452.md](REVIEW_r452.md), [REVIEW_r453.md](REVIEW_r453.md), and (found by the novelty screen), [REVIEW_r439.md](REVIEW_r439.md), [REVIEW_r441.md](REVIEW_r441.md), [REVIEW_r446.md](REVIEW_r446.md), [REVIEW_r447.md](REVIEW_r447.md). **Analysis only** ([analysis-only.md](../.claude/rules/analysis-only.md)): every derivation below is by hand, and no screen was run, the two places where a number was in doubt were settled by rebuilding the closed form from the defining data instead. Working: [agent_logs/r457-L151.log](../agent_logs/r457-L151.log).*

## Verdicts, per claim

| # | claim | verdict |
|---|---|---|
| 0 | novelty | **FAILED.** Four prior reviews and [Lemma L145](../findings/second-order.md)'s own table already carry the entry's two substantive rows, one of them as a *correction of exactly the value L151 re-asserts* (N) |
| 1 | exactly four absolute constants decide the radius at $\beta=0$ | **REFUTED.** At least nine enter [Lemma L149](../findings/second-order.md)'s chain; the list prices one of three branches that all share the value at $\beta=0$, and omits the one constant in the chain that is a *positivity* condition (R1) |
| 2 | the $\tfrac12$ in $\rho=g_n/(2\lVert H\rVert_{op})$ is "pinned by the geometry, not chosen" | **REFUTED, twice.** It is one of a two-parameter family of contour choices; and at the value written the resolvent bound diverges, so $C=+\infty$ there. The record corrected this same sentence in [r441](REVIEW_r441.md), [r446](REVIEW_r446.md), [r447](REVIEW_r447.md) and in [Lemma L145](../findings/second-order.md)'s own table (R2) |
| 3 | $C$ is an independent fourth constant, the only one owed | **REFUTED.** $C=C(\alpha,\gamma)$ is a *function of* the contour parameters row 3 freezes, and it blows up precisely at row 3's value. The two rows are one parameter read twice (R2) |
| 4 | the $2$ in $\lVert A''\rVert\le2M/\rho^2$ is pinned as $k!$ at $k=2$ | **REFUTED as used, CONFIRMED at the centre.** The chain needs $\lVert A''\rVert$ uniformly on the tube, where the constant is $2/(1-\eta)^2$; at [Lemma L149](../findings/second-order.md)'s own $\eta=\tfrac12$ it is **$8$** (R3) |
| 5 | $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$ | **CONFIRMED**, re-derived cold (R4) |
| 6 | the first term "vanishes at $A(0)=\mathrm{Alt}(W^*_-)=0$", so $2$ and $6$ are pinned | **REFUTED as a statement about the chain.** It vanishes at $t=0$ and nowhere else on the segment; [r441](REVIEW_r441.md)'s recommendation 4 already lists the missing bootstrap from $(\delta^2)'''(0)$ to $\sup_{\lvert t\rvert\le r_n}$, and it is still missing (R4) |
| 7 | $C=1$ on the real segment, from $A(0)=0$, $\lVert\mathrm{Alt}\rVert\le1$ and $1$-Lipschitzness | **CONFIRMED**, including $\lVert\mathrm{Alt}\rVert_{op}\le1$ against [conventions.md](../findings/conventions.md), the brief's suspicion about the $\tfrac13$ does not land (R5) |
| 8 | the reduction is a reduction | **REFUTED, it is a restatement**, and a lossy one: the estimate it defers is the one [r441](REVIEW_r441.md) recommendation 4 and [r446](REVIEW_r446.md) recommendation 2 both ordered written, and L151 declares fixed the very input that estimate has to choose (R6) |
| 9 | vacuity | **CONDITIONALLY VACUOUS and unflagged.** $\beta=0$ is [I31](../plan.md), an open item; at any $\beta>0$ the branches separate by a power and no constant decides anything (R7) |

**The one-line verdict: REFUTED. The lemma's whole content is the completeness of a list of four, and the list is neither complete nor a list of four independent things, its third and fourth entries are one free parameter written twice, and at the value the third entry freezes, the fourth is infinite.** The two rows that are correct as algebra ($k!$, and Leibniz) are correct at the base point and are used along the segment, which is the same shape of error the lemma correctly identifies in its own $C=1$ paragraph. And that paragraph is [r450](REVIEW_r450.md) D1 plus [r453](REVIEW_r453.md) E3, restated.

---

## N, the novelty screen, and why it fails

I screened by the pair the brief asks for, *the quantity bounded* ($M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$, and the admissible complex radius $\rho$) and *the information it is bounded from* (the spectral gap $g_n$, $\lVert H\rVert_{op}$, and a separating contour), rather than by lemma names. Both halves of L151's substance come back.

| L151 says | the record already says | where |
|---|---|---|
| $\rho=g_n/(2\lVert H\rVert_{op})$, "pinned by the geometry" | "the complex radius must be $\rho<g_n/2$, **not** $\rho=g_n/2$" | [Lemma L145](../findings/second-order.md), step 2 of its own table |
| "$\lvert z\rvert\lVert H\rVert_{op}\le g_n/2$ gives resolvent norm at most $2/g_n$" | "at the stated $\rho=g_n/2$ the correct bound $1/(g_n/2-\rho)$ **diverges**. Taking $\rho=g_n/4$ repairs it" | [r446](REVIEW_r446.md) D2 |
| the same | "the Neumann bound needs $\lVert E\rVert_{op}<g_n/2$, i.e. $\rho<g_n/2$ **strictly**" | [r447](REVIEW_r447.md) F3 |
| the $\tfrac12$ is not chosen | "the item's stated choice $\rho=g_n/2$ is **borderline** (it makes the Neumann ratio exactly $1$) and needs **either a smaller $\rho$ or a contour at radius $\approx(\lambda_+-\lambda_-)/2$**"; recommendation 5: "take $\rho=g_n/4$ rather than $g_n/2$" | [r441](REVIEW_r441.md) |
| "the factor $\lVert\mathrm{Alt}\rVert\le1$ then gives $C$ explicitly" | "$\Pi$ is **not** orthogonal off the Hermitian locus, so $\lVert\Pi\rVert\le1$ would be false" | [r441](REVIEW_r441.md) |
| "$C=1$ immediately on the real segment: $A(0)=0$, $\lVert\mathrm{Alt}\rVert\le1$, $x\mapsto x_-$ $1$-Lipschitz" | the identical three-step chain, displayed | [r450](REVIEW_r450.md) D1 |
| "$M$ is a supremum over the complex circle, where $W(z)$ is not Hermitian and the Lipschitz bound is unavailable" | "the $1$-Lipschitz argument is the one that does *not* transfer, $W(z)$ is complex symmetric rather than Hermitian" | [r452](REVIEW_r452.md) B4, [r453](REVIEW_r453.md) E3 |
| "what would pin it", one contour estimate | recommendation 4: "write the three missing steps: the separating-contour argument, the Neumann/contour estimate that carries $M$ into the complex disc, and the bootstrap from $(\delta^2)'''(0)$ to a supremum over $\lvert t\rvert\le r_n$. **All three close; none is written**"; and [r446](REVIEW_r446.md) recommendation 2, "number the Cauchy estimate as a lemma … the separating contour at radius $g_n/2$ with $\rho<g_n/2$" | [r441](REVIEW_r441.md) |

**So row 3 of L151's table re-asserts, as *pinned*, the exact value that three separate reviewers and the parent lemma's own table each recorded as wrong**, and the paragraph "why $C$ resists the obvious argument" is two prior reviews' finding with no citation of either. *This is the fourth appearance of one sentence; the record has a fence post for the failure mode ([Lemma L150](../findings/second-order.md), withdrawn the same day, for a screen that searched vocabulary rather than value), and the screen L151 needed was a search on $\rho$ and $g_n/2$, two symbols it prints itself.*

## R1, the enumeration: at least nine constants, and the list prices one branch of three

[Lemma L149](../findings/second-order.md)'s chain is
$$r(H)\;\gtrsim\;\min\!\left(\frac{c_p+w^2}{S},\ \frac{\sqrt{c_p+w^2}}{n^{1/2}+nw},\ \frac{\rho(H)}2\right),$$
and by [r450](REVIEW_r450.md) D7, [r451](REVIEW_r451.md) A4, [r452](REVIEW_r452.md) B8 and [r453](REVIEW_r453.md) E6 **all three arguments are $\Theta(n^{-1})$ at $\beta=0$**, so all three sets of constants decide the value. Here is every constant in the chain, with what L151 does with it.

| # | constant | where it enters | in L151's list? |
|---|---|---|---|
| 1 | $3$ and $\theta_0\to\sqrt2$ in $c_p=3\theta_0/(n-2)$ | numerator of branch 1 and inside branch 2 | **no** |
| 2 | $c_0=\min_{j\ne s}3\theta_0(\tfrac12-\lambda_j)\ge\tfrac34\theta_0$, and the $\min(1,c_0/2)$ that turns $c_p(1-w^2)+c_0w^2$ into $c_p+w^2$ | the margin lower bound ([r452](REVIEW_r452.md) B2, [r453](REVIEW_r453.md) E1) | **no** |
| 3 | $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.4161$ | the net margin after the $\lvert\kappa_n\rvert u^2$ penalty ([r453](REVIEW_r453.md) E5) | **no** |
| 4 | $\tfrac{\sqrt2}3$ in $u\le\tfrac{\sqrt2}3v$, and the constant in $v\lesssim w$ | the passage from the Hessian margin to the net margin | **no, and see below** |
| 5 | $1$ and $2$ in $\min(c/2S,\sqrt c/a)\le f(u^*)\le2\min(\cdots)$ | the $u$-elimination ([r452](REVIEW_r452.md) B7) | **no** |
| 6 | the value of $S=\sup\lvert P\rvert$ at $\beta=0$ | denominator of branch 1 | **no** |
| 7 | $\sqrt2$ in $\lVert H_s\rVert_{op}\le\lVert H_s\rVert_F\sqrt{2/(n-2)}$, and $\lVert H_r\rVert_{op}\le w$ | the triangle-inequality step | **no** |
| 8 | $\sqrt2$ in $g_n\to\sqrt2/n$; $\lVert W^*\rVert_{op}/g_n=m/(m-1)$ | $\rho$, and the second Riesz term | **no** |
| 9 | $\alpha$ (contour radius), $\gamma$ (disc radius), $\eta$ (tube fraction), and $\lVert\Pi(z)\rVert_{op}=\alpha/(\alpha-\gamma)$ | $\rho$, the uniform Cauchy bound, the validity branch, and $C$ | **partly, as two frozen numbers presented as three independent facts** |

**Two of these are worse than merely omitted.**

- **#3 is a positivity condition, not a scale.** The chain does not merely lose a factor if $\tfrac32\theta_0-\lvert\kappa_n\rvert$ were negative; the second-order coefficient changes sign and the tube statement fails outright. It clears by twenty per cent ([r453](REVIEW_r453.md) E5; I reproduced $1.5\sqrt2-9(\sqrt2-\sqrt{3/2})=0.41610$ by hand). L151's headline sentence (*"the radius at $\beta=0$ turns on $C$ alone, and on nothing else"*), is false with this on the record one entry above it.
- **#4 is the one the brief asks about, and its constant is not known to be absolute.** [r452](REVIEW_r452.md) B4 states it flatly: *"the link $v\lesssim w$ between the two decompositions of $H$ is asserted nowhere on the record and is not proved here either; it is the one genuinely open input."* [r453](REVIEW_r453.md) E3 supplies a repair for the *first* link, $A'(0)$ is linear and vanishes on the margin subspace by [Lemma L148](../findings/second-order.md), hence $u\le w$ directly, but that repair bypasses $v$ rather than pricing $v\lesssim w$, and [Lemma L149](../findings/second-order.md) writes the bypass without proof. **So the honest answer to "is its constant absolute?" is: under [r453](REVIEW_r453.md) E3's route, yes and it is $1$; under the route [Lemma L149](../findings/second-order.md) actually cites, unknown.** Either way it is a constant in the chain and it is not in the list.

**And the structural objection is decisive on its own.** A minimum of three arguments is decided by its smallest argument. Branch 1, $c_p/S$, contains **no Cauchy constant whatever** (it is $3\theta_0/((n-2)S)$) so no value of $C$ can make the tube radius larger than it. A lemma claiming that the radius "turns on $C$ alone" has asserted something a $\min$ cannot do.

## R2, the $\tfrac12$ is a free parameter, and $C$ is a function of it

**Set up the family the lemma suppresses.** By [Lemma L145](../findings/second-order.md) the spectrum of $W^*$ is two-valued with no kernel. Rebuilding it cold from trace, norm and multiplicities: $W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ puts the negative eigenspace on $V_1\wedge V_2$, $\dim=m^2$, and the positive on $\Lambda^2V_1\oplus\Lambda^2V_2$, $\dim=m(m-1)$, totalling $2m^2-m=\binom{2m}2$. Tracelessness gives $\lambda_+=\tfrac m{m-1}g_n$, and $\sum\lambda^2=1$ gives $g_n^2=\tfrac{m-1}{m^2(2m-1)}=\tfrac{2(n-2)}{n^2(n-1)}$, **the record's closed form exactly**, from an independent route. So $\lVert W^*\rVert_{op}=\lambda_+=\Theta(g_n)$, confirming the factor [r450](REVIEW_r450.md) D1 and [r451](REVIEW_r451.md) A2 use, and confirming [r439](REVIEW_r439.md)'s $(\lambda_+-\lambda_-)/2=\tfrac{2m-1}{2(m-1)}g_n$.

**The two-parameter family.** Let $\Gamma$ be the circle of radius $\alpha g_n$ about $\lambda_-$, $\alpha\in(0,1)$ so that $0$ and $\lambda_+$ stay outside, and let $\rho=\gamma g_n/\lVert H\rVert_{op}$. Then $\operatorname{dist}(\Gamma,\operatorname{spec}W^*)=\alpha g_n$, the Neumann condition is $\gamma<\alpha$, and

$$\lVert R(\zeta)\rVert\le\frac1{(\alpha-\gamma)g_n},\qquad \lVert\Pi(z)\rVert_{op}\le\frac{\lvert\Gamma\rvert}{2\pi}\lVert R\rVert=\frac\alpha{\alpha-\gamma},\qquad \lVert\Pi(z)-\Pi(0)\rVert_F\le\frac{\lvert\Gamma\rvert}{2\pi}\lVert R\rVert\lVert E\rVert_F\lVert R_0\rVert=\frac\rho{(\alpha-\gamma)g_n}.$$

Feeding these into the decomposition of [r447](REVIEW_r447.md) F1, $A(z)=\mathrm{Alt}\big(-\Pi(z)(W(z)-W^*)-(\Pi(z)-\Pi(0))W^*\big)$, and using $\lVert\mathrm{Alt}\rVert\le1$ and $\lVert W(z)-W^*\rVert_F=\rho$:

$$\boxed{\;M\;\le\;C(\alpha,\gamma)\,\rho,\qquad C(\alpha,\gamma)=\frac{\alpha+\frac m{m-1}}{\alpha-\gamma}\;}$$

**Three consequences, each fatal to a row of the table.**

- **$C$ is not an independent fourth constant.** It is a function of the contour parameters, one of which the table freezes in row 3 and the other of which the table never mentions. *Rows 3 and 4 are one free parameter written twice, and the lemma's arithmetic ("three pinned, one owed"), double-counts.*
- **At the lemma's own values, $C=+\infty$.** L151 writes $\rho=g_n/(2\lVert H\rVert_{op})$, i.e. $\gamma=\tfrac12$, and justifies it by a contour "at distance $g_n/2$", i.e. $\alpha=\tfrac12$. Then $\alpha-\gamma=0$. **The lemma has chosen the one point of the family at which the constant it says is owed does not exist**, and its own "what would pin it" paragraph repeats the divergence, "$\lvert z\rvert\lVert H\rVert_{op}\le g_n/2$ gives resolvent norm at most $2/g_n$" quotes the *unperturbed* bound where the Neumann-corrected one is $1/(g_n/2-\lvert z\rvert\lVert H\rVert_{op})$, unbounded at the stated endpoint. This is [r446](REVIEW_r446.md) D2 and [r447](REVIEW_r447.md) F3 verbatim, and [Lemma L145](../findings/second-order.md)'s table already carries the correction.
- **The optimisation the brief suspects is real, and $\tfrac12$ is its unattained supremum, not its value.** The defect branch scales as $\sqrt c\,\rho/C=\sqrt c\,g_n\gamma(\alpha-\gamma)/\big(\lVert H\rVert_{op}(\alpha+\tfrac m{m-1})\big)$. At fixed $\alpha$ this is maximised at $\gamma=\alpha/2$ (**half the contour radius, not half the gap**), with value $\propto\alpha^2/\big(4(\alpha+\tfrac m{m-1})\big)$, increasing in $\alpha$, so the supremum sits at $\alpha\to1$, $\gamma\to\tfrac12$ and is **not attained**. The lemma's $\tfrac12$ is the boundary of an open optimisation. *Calling it "pinned by the geometry, not chosen" is exactly wrong: it is chosen, it is chosen at a point outside the admissible set, and the admissible set is two-dimensional.*

**The "geometry" reason given is also the weaker of the two constraints on the record.** [r439](REVIEW_r439.md) settled that separating the two spectral clusters permits a contour of radius $\approx(\lambda_+-\lambda_-)/2>g_n$, and that the binding constraint is the *real* one (no eigenvalue may cross $0$, or the holomorphic continuation stops equalling $W_-$), giving $\rho<g_n$. **So "the contour must separate the negative spectrum from $0$" is not what forces anything**; it is one admissible choice among a family whose members the record has already written down ($g_n/4$, twice recommended; $(\lambda_+-\lambda_-)/2$).

## R3, Cauchy's $k!$ survives at the centre and not on the tube

$\lVert A^{(k)}(0)\rVert\le k!M/\rho^k$ is the estimate at the centre of the disc, and its $k!$ is correct there. **The chain needs $\lVert A''\rVert$ at every real base point $s$ of the segment**, and the disc available at $s$ has radius $\rho-\lvert s\rvert$, so

$$\lVert A''(s)\rVert\;\le\;\frac{2M}{(\rho-\lvert s\rvert)^2}\;\le\;\frac{2M}{(1-\eta)^2\rho^2}\qquad\text{for }\lvert s\rvert\le\eta\rho .$$

This is [r450](REVIEW_r450.md) D7 and [r451](REVIEW_r451.md) A4, which is where [Lemma L149](../findings/second-order.md)'s validity branch $\rho/2$ comes from: **$\eta=\tfrac12$ is already frozen inside the chain L151 is auditing.** At $\eta=\tfrac12$ the constant is $2/(1-\tfrac12)^2=8$, not $2$. So row 1 prices the wrong object by a factor $4$, and $\eta$ is a *fifth* frozen free parameter, trading the defect branch ($\propto(1-\eta)^2$) against the validity branch ($\propto\eta$), a trade-off with an interior optimum, again presented as no choice at all.

*The shrinkage factor is exactly what the brief asks about, and the answer is that it enters and that the lemma has not looked for it.*

## R4, the Leibniz identity is right and the vanishing is a base-point fact

**The identity, re-derived.** With $\delta^2=\langle A,A\rangle$: $(\delta^2)'=2\langle A',A\rangle$; $(\delta^2)''=2\langle A'',A\rangle+2\langle A',A'\rangle$; and

$$(\delta^2)'''=2\langle A''',A\rangle+2\langle A'',A'\rangle+4\langle A'',A'\rangle=2\langle A''',A\rangle+6\langle A'',A'\rangle .$$

**CONFIRMED**, coefficients and all.

**The vanishing is not identical.** $\mathrm{Alt}(W^*_-)=0$ gives $A(0)=0$, so $\langle A'''(0),A(0)\rangle=0$, **at $t=0$**. Along the segment $A(s)\ne0$ for $s>0$; indeed $A$ is precisely the quantity the whole chain exists to bound, and $\delta^2=\lVert A\rVert^2>0$ is what the penalty acts on. The term therefore contributes $2\lVert A'''(s)\rVert\lVert A(s)\rVert$, and with the uniform estimates of R3, $\lVert A'''(s)\rVert\le6M/((1-\eta)\rho)^3$ and $\lVert A(s)\rVert\le\lVert A'\rVert_\infty s\le Ms/((1-\eta)\rho)$, it is $O(M^2s/\rho^4)$ against the second term's $O(M^2/\rho^3)$: **the same order for $s\asymp\rho$, hence a contribution to the constant, not a vanishing one.**

*The record already knows this and says so.* [r441](REVIEW_r441.md)'s recommendation 4 lists, among "three missing steps … all three close; none is written", *"the bootstrap that upgrades $(\delta^2)'''(0)=O(n)$ to a supremum over $\lvert t\rvert\le r_n$"*; [r451](REVIEW_r451.md) records that *"the $C_\delta=6\langle A''(0),A'(0)\rangle$ of [Lemma L145](../findings/second-order.md) is evaluated at the base point"*; [r442](REVIEW_r442.md) writes the whole chain with an explicit $(0)$. **L151's row 2 takes a base-point identity and reports it as a pinned constant of a segment estimate**, the same substitution of a centre fact for a segment fact that the lemma's own closing paragraph correctly diagnoses in the $C=1$ argument. *It commits, one row above, the error it names.*

## R5, $C=1$ on the real segment holds, and the $\tfrac13$ does not bite

The brief's suggested attack fails, and it is worth saying why so that a successor does not re-open it.

- **$\lVert\mathrm{Alt}\rVert_{op}\le1$ is right.** [conventions.md](../findings/conventions.md) fixes $\mathrm{Alt}$ as *the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$*, with the $\tfrac13$ **inside the projector's formula** ($\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$) and states the consequence directly: *"So $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$, $\mathrm{Alt}$ is self-adjoint and idempotent."* An orthogonal projection has operator norm $1$. The $\tfrac13$ is what *makes* it idempotent rather than a factor multiplying the output. The file's other remark (inside $\Lambda^2\mathbb R^4$, $\lVert\star\rVert^2=6$), is the norm of the image *basis vector*, not of the operator, and is irrelevant here.
- **$x\mapsto x_-$ is $1$-Lipschitz in Frobenius on Hermitian arguments.** The scalar $x_-=\max(-x,0)$ is $1$-Lipschitz, and a scalar Lipschitz function is operator-Lipschitz with the same constant in the Hilbert–Schmidt norm. The record's $\Lambda^2$-level $\tfrac12$ in $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ rescales both sides equally and preserves the constant.
- **Hence $\lVert A(t)\rVert=\lVert\mathrm{Alt}(W(t)_--W^*_-)\rVert\le\lVert W(t)-W^*\rVert_F=\lvert t\rvert$** at $\lVert H\rVert_F=1$. **CONFIRMED.**

**It is [r450](REVIEW_r450.md) D1's argument, and the caveat is [r453](REVIEW_r453.md) E3's.** The observation that the Daleckii–Krein/Hermitian hypothesis fails on the complex circle is stated in both [r452](REVIEW_r452.md) B4 and [r453](REVIEW_r453.md) E3, the latter adding the point L151 omits: **the Riesz route needs no Lipschitz property and already delivers $M=O(\rho)$ on the complex circle**, in [r450](REVIEW_r450.md) D1, [r451](REVIEW_r451.md) A2, [r452](REVIEW_r452.md) B4 and [r453](REVIEW_r453.md) E3. *So $C<\infty$ is not owed at all, four reviewers have it. What is owed is its numerical value, at parameters the lemma has not chosen. Presenting the order and the value as one open question overstates what is missing and understates what has to be decided.*

## R6, reduction or restatement

**Restatement, on three counts.**

- **The estimate is not new work identified; it is old work deferred.** [r441](REVIEW_r441.md) recommendation 4 and [r446](REVIEW_r446.md) recommendation 2 both instruct that the separating-contour/Neumann estimate be written and numbered as a lemma; [r446](REVIEW_r446.md) adds that *"it is the only unaudited load-bearing input"*. L151 names that same estimate, declines to perform it, and records the naming as a result.
- **The inputs it calls "already fixed above" are the ones the estimate must choose.** R2 shows $C=C(\alpha,\gamma)$; L151 fixes $\gamma=\tfrac12$ by fiat, never introduces $\alpha$, and asserts the remaining computation is "bounded … with every input already fixed". At the fixed inputs the answer is $+\infty$. **A reduction that fixes its free parameters at an inadmissible point has not reduced the problem, it has mis-stated it.**
- **The factor it names as the second half of the estimate is the wrong one.** "*The contour length and the factor $\lVert\mathrm{Alt}\rVert\le1$ then give $C$ explicitly*" omits $\lVert\Pi(z)\rVert_{op}=\alpha/(\alpha-\gamma)$, which is the factor that diverges and the one [r441](REVIEW_r441.md) flagged with *"$\Pi$ is not orthogonal off the Hermitian locus, so $\lVert\Pi\rVert\le1$ would be false"*.

*The honest deliverable in this direction is not a list of pinned constants but a single optimisation: $\sup\{\gamma(1-\eta)^2(\alpha-\gamma)/(\alpha+\tfrac m{m-1})\}$ against $\eta\gamma$ over $0<\gamma<\alpha<1$, $\eta\in(0,1)$, three parameters, one number, and it is a page of calculus, not a table.*

## R7, vacuity

**Would this be true vacuously?** Partly, and in a way the entry does not flag.

- **The premise is an open item.** $\beta=0$ means $\sup\lvert P\rvert=\Theta(1)$, which [r450](REVIEW_r450.md) D6 records as *"[I31](../plan.md), an open plan item, not a value on the record"*, an aspiration. All anyone knows is $\beta\in[0,\tfrac12]$. **At any $\beta>0$ the branches separate by a power of $n$ and no absolute constant decides anything**, so the lemma is a statement about a regime nobody has reached, presented without that condition.
- **What it is not.** It is not logically vacuous: if $\beta=0$ were established, the constants would genuinely decide, since all three branches share the order ([r452](REVIEW_r452.md) B8). And it is not vacuous as a *concern*, [r451](REVIEW_r451.md)'s table already flags $\beta=0$ as *"$\Omega(n^{-1})$ with an unpinned constant, at the edge of validity … all four ceilings of A4 at once, so the constant decides whether the statement has content."* **Four ceilings; L151 prices the constants of one.**
- **And the tube it is about buys nothing either way.** $\Theta(n^{-1})=\Theta(g_n)$, no competitor inside at any exponent, vanishing coverage, [r447](REVIEW_r447.md) F6, [r450](REVIEW_r450.md) D8, [r452](REVIEW_r452.md) B10, [r453](REVIEW_r453.md) E7. L151 is now the fourth consecutive entry to omit the line.

---

## What I could not break

- **The Leibniz identity** $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$, coefficients confirmed cold (R4).
- **$C=1$ on the real segment**, all three of its ingredients, including $\lVert\mathrm{Alt}\rVert_{op}\le1$ against [conventions.md](../findings/conventions.md)'s $\tfrac13$-carrying projector (R5).
- **The diagnosis that the real-segment bound is unavailable on the complex circle.** It is correct, and it is [r452](REVIEW_r452.md) B4 and [r453](REVIEW_r453.md) E3.
- **$\lVert W^*\rVert_{op}=\Theta(g_n)$ and $g_n^2=2(n-2)/(n^2(n-1))$**, rebuilt cold from multiplicities, trace and norm; the record's closed form comes out exactly (R2).
- **That the finite-$C$ statement $M=O(\rho)$ holds on the complex circle.** Four reviewers derive it by Riesz; nothing here disturbs it.

## What this audit did not check

[Lemma L27](../findings/nondegeneracy.md)'s ten eigenvalues, [Lemma L141](../findings/second-order.md)'s $c_p$, [Lemma L133](../findings/second-order.md)'s $u\le\tfrac{\sqrt2}3v$, [Lemma L143](../findings/bounds.md), [Lemma L146](../findings/second-order.md)'s extremal problem and [Lemma L148](../findings/second-order.md)'s diagonality are taken as given. Whether $\lVert A''\rVert$ is *saturated* at $O(M/\rho^2)$, [r443](REVIEW_r443.md)'s open item (iii), is untouched, so everything above concerns what the chain can prove rather than the true tube radius. I did not evaluate the contour estimate; R2 gives its shape and its free parameters, not its optimum.

## What to change

1. **Withdraw the headline.** "Three of the four are absolute and already fixed; the radius turns on $C$ alone" is false in three independent ways: the list omits at least five constants (R1), branch 1 of a three-branch $\min$ contains no Cauchy constant at all (R1), and rows 3 and 4 are one parameter double-counted (R2).
2. **Delete row 3, or restate it as the free parameter it is.** $\rho<g_n/2$ **strictly**; at $\rho=g_n/2$ the resolvent bound diverges. This is [Lemma L145](../findings/second-order.md)'s own table, [r441](REVIEW_r441.md), [r446](REVIEW_r446.md) D2 and [r447](REVIEW_r447.md) F3, four prior corrections of the same sentence (N).
3. **Replace rows 3 and 4 with the single displayed formula** $C(\alpha,\gamma)=(\alpha+\tfrac m{m-1})/(\alpha-\gamma)$, and state the deliverable as an optimisation over $(\alpha,\gamma,\eta)$ rather than a constant (R2, R3).
4. **Correct row 1 to the uniform estimate** $\lVert A''(s)\rVert\le2M/((1-\eta)\rho)^2$, note that [Lemma L149](../findings/second-order.md) has already frozen $\eta=\tfrac12$ in its validity branch, and that the constant there is $8$ (R3).
5. **Correct row 2 to a base-point statement.** $\langle A''',A\rangle$ vanishes at $t=0$ only; the bootstrap to $\sup_{\lvert t\rvert\le r_n}$ is [r441](REVIEW_r441.md)'s recommendation 4 and is still unwritten (R4).
6. **Add the constants the list omits**, at minimum $\tfrac32\theta_0-\lvert\kappa_n\rvert=0.4161$ (a positivity condition, not a scale), $c_0\ge\tfrac34\theta_0$ with its $m\ge5$, and the unproved $v\lesssim w$ that [r452](REVIEW_r452.md) B4 calls the one genuinely open input (R1).
7. **Cite [r450](REVIEW_r450.md) D1 and [r453](REVIEW_r453.md) E3 for the $C=1$ paragraph**, and record that they already prove $C<\infty$ on the complex circle, so what is owed is a value and not an order (R5).
8. **State the condition.** $\beta=0$ is [I31](../plan.md), open; and carry the vacuity line that four consecutive entries have now dropped (R7).
