# What the relaxations cannot do, the LP, the marginals, and the pinned programme

**Split out of [bounds.md](bounds.md) on 2026-09-02.** [bounds.md](bounds.md) answers *what bounds $\theta$*; this file answers the different question of *what a method provably cannot deliver*, every LP, marginal relaxation and transportation argument the record has closed, with what a successor to each must clear. Conventions: [conventions.md](conventions.md). Ids: [INDEX-results.md](INDEX-results.md).

Holds **Lemmas L104, L105, L109, L110, L114, L115, L116, L119** and **posts F15, F16, F17, F18, F28**.

## Post F28, the product route is CLOSED, because $\Pi/4=\theta$ identically wherever the problem is hard, so the bound relaxes nothing and is strictly harder off $\{\Delta=0\}$

#### The product route is CLOSED, and the reason is that it is the target restated

**$\Pi/4=\theta$ identically wherever the problem is hard**, so "$\Pi\le2\sqrt6$" and "$\theta\le\sqrt{3/2}$" are the same statement there, and the bound relaxes nothing.

**The slack is exact and both its terms are signed.** From $4\theta=\sum_{\mathfrak m}\lvert\lambda_\gamma\rvert g_\gamma-\sum_{\mathfrak p}\lambda_\gamma g_\gamma$,

$$\Pi-4\theta=\underbrace{\sum_{\mathfrak m}\big(\lvert\lambda_{\min}\rvert-\lvert\lambda_\gamma\rvert\big)g_\gamma}_{\ge0}\;+\;\underbrace{\sum_{\mathfrak p}\lambda_\gamma g_\gamma}_{\ge0},$$

so **the slack vanishes exactly when $\Delta=0$ and $g$ is carried by the $\lambda_{\min}$ eigenspace within $\mathfrak m$.** Every catalogued point where the conjecture is tight satisfies both: $\Delta=0$ at all four balanced products, at every $\mathbb{CP}^m$, at all three frontier points sitting at $\sqrt{3/2}$, and at the balanced product at $\theta_0$. Measured slack over that whole catalogue: $\le1.7\times10^{-15}$.

**So the reduction is nowhere easier than the target and strictly harder off $\{\Delta=0\}$**, where it must hold at points the target says nothing about. Reviewer 118 stated this as "the tautology" and it is the correct closure; the $\perp$-sum unboundedness is a true fact about a family the supremum never visits and was the wrong reason.

#### Where the slack vanishes is exactly where Conjecture A is already proved

**The tautology has a boundary, and locating it is what the slack identity is actually for.** $\Pi-4\theta=0$ needs $\Delta=0$ *and* $g$ carried by the $\lambda_{\min}$ eigenspace within $\mathfrak m$. Since $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$, the second condition says every eigenvector outside that eigenspace **is an infinitesimal symmetry**. Read off at the two competitor families:

| | $\dim\mathfrak{so}(n)$ | $\#\{g_\gamma=0\}$ | $\lambda_{\min}$ multiplicity |
|---|---|---|---|
| $\mathbb{CP}^m$, $m=2,3,4,5$ | $6,15,28,45$ | $4,9,16,25=m^2$ | $2,6,12,20=m(m-1)$ |
| $S^k\times S^k$, $k=3,4,5$ | $15,28,45$ | $6,12,20$ | $9,16,25=k^2$ |

**In every case the symmetries are exactly the complement of the $\lambda_{\min}$ eigenspace**, and the two dimensions are the isotropy and the tangent space of the symmetric pair, $m^2=\dim\mathfrak u(m)$ against $m(m-1)$, and $\dim(\mathfrak{so}(k)\oplus\mathfrak{so}(k))$ against $k^2$. *This corroborates the record's observation that $\dim\mathfrak p$ equals the isotropy dimension at those points, and sharpens it: the kernel joins $\mathfrak p$ on the symmetry side, and $\mathfrak m$ carries a **single** eigenvalue.*

**Hence the vanishing locus sits inside the GRADED half.** With $S=0$, trivial kernel and $\Delta=0$ the record's lemma gives a $\mathbb Z_2$-grading, so

$$\text{slack}=0\ \wedge\ S=0\ \Longrightarrow\ W\text{ is graded, with }\mathfrak m\text{ a single eigenvalue.}$$

**Two steps are weaker than they look.** *(i)* Slack $=0$ does **not** force two eigenvalues overall, it forces only that $\mathfrak m$ carries one, while $\mathfrak p$ may carry several. $\mathbb{CP}^m$ is the standing witness: **three** distinct eigenvalues at $m=3,4,5$ with slack $\le1.1\times10^{-15}$. *(ii)* Graded does **not** imply symmetric, gradedness is strictly broader, Jensen's metric on $S^3\times S^3$ being the record's own witness, so [Lemma L48](graded-half.md) does not close the locus and was wrongly invoked.

**What the partition does say, and it is still sharp.** The product bound is a **tautology exactly on the graded half**, where step **H** is the machinery that applies, and it is **strictly slack on the ungraded half**, which is step (G), the crux. So "the reduction is nowhere easier" holds precisely where the problem is not hard, and a *slack-aware* bound on the ungraded half is not excluded by it. **CANDIDATE, Gate 2 in flight, cited nowhere as settled**, the fourth revision of this route's status in one cycle.

#### What survives, and it is one line each

- **The sharpening** $\theta\le[\Pi-\lambda^+_{\min}\Delta]/4$ is valid and **inert**: its gain is $0$ at every $\Delta=0$ point, which is every point that matters. The manoeuvre is [Petersen–Wink Prop 1.3](../references/petersen-wink-2021-tachibana-special-holonomy/notes.md) in any case.
- **$\Pi(\text{padded }W_{\mathbb{CP}^2})=2\sqrt6$ for every $n$** stands as a theorem, proved above and confirmed at Gate 2 to $9\times10^{-16}$ at eight dimensions. It is now a fact about a point rather than a sharpness case for a live bound.
- **$\Pi/4=\theta_0(n)$ at any two-eigenvalue critical point with $\Delta=0$** stands, with the crossover corollary.
- **The bound does not fail entirely at $\Delta=0$.** The $\perp$-sum witnesses have $\Delta>0$ and fail anyway.

#### Lemma L109, the per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$

*Constructed by Reviewers 109 and 110 while refuting [post F25](fence-posts.md), **construction, so it was never audited until now**, an author being no reviewer. **Gate 2, [r593](../reviews/REVIEW_r593.md) and [r594](../reviews/REVIEW_r594.md) on identical briefs, both CONFIRMED the inequality**; the constant, the exponent and the derivation all hold, and the marginal $2(n-2)$ checks two independent ways. The claims around it did not, and are corrected below. Provenance checked against `git` and **TRUE**.*

Substituting [Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) into a **single** $g_\gamma$ rather than into the $\lambda$-weighted sum, and using $T\ge0$ with the row marginal $\rho_\alpha=2(n-2)$, **[Lemma L153](bounds.md)**, gives

$$g_\gamma\ \le\ 2(n-2)\,(\lambda_{\max}-\lambda_{\min})^2 .$$

**THE CAP IS UNCONDITIONAL.** It consumes no criticality, no Bianchi identity, no trace-freeness and no unit norm, three lines of Hölder against the row marginal. *The block stated no hypotheses at all, which read as an oversight and is in fact the strongest form of the statement.* The single-$g_\gamma$ substitution is legitimate where the weighted-sum one was not, because the outer weight $\lambda_\gamma$ changes sign while $T\ge0$ does not.

This is **outside** $\{g\ge0,\ \sum g=4(n-1)\}$, which is the information the recorded bound uses, from $s^2\le2$, giving $C\le4(n-2)$.

> **THE WATER-FILLING SENTENCE WAS A NON SEQUITUR, AND BOTH REVIEWERS SAID SO.** *"The cap is smaller than $4(n-1)$, so mass is forced off the bottom eigenvalue"* is unconditionally true ($C\le4(n-2)<4(n-1)$ at every unit $W$) so it forces nothing. **The condition that does the work is $\dim E_{\min}\cdot C<4(n-1)-\Delta-G_0$**, and at $S^k\times S^k$ the two sides are *exactly equal*. The conclusion stands; the reason given for it did not. [r109](../reviews/REVIEW_r109.md) carried both a single-direction hypothesis and the hedge *"generically"*, and the block dropped both.

> **SATURATION IS A THEOREM, AND WAS RECORDED AS A MEASUREMENT.** $g_\gamma=C$ holds *exactly* at every mixed row of $S^k\times S^k$, with $C=g_\gamma=4(2k-1)/k^2$, **derived three times across the pair**, from symmetric-pair brackets, from $SO(k)^2$-irreducibility with $\sum g=4(n-1)$, and from the equality case *"$\mathrm{ad}(v_\gamma)$ supported on $E_{\min}\otimes E_{\max}$"*, which is verbatim [Lemma L71](bounds.md)'s hypothesis and so forces the balanced sphere product. *The recorded "slack $0.0000$" and "returns $\theta_0(2k)$ to machine precision" were two-line identities reported as measurements.* The sources tested $k=3,4,5,6,8,10$, not $k=3,\dots,10$.

| | sharpening |
|---|---|
| against the a priori bound | $15$–$25\%$ (110); $8$–$15\%$ at $n=5,6,7,8$ (109) |
| against the $\Delta$-aware bound | $2$–$12\%$ |
| at the maximiser | **costs nothing**, the cap is saturated *exactly* on $S^k\times S^k$ for $k=3,\dots,10$, and the capped bound returns $\theta_0(2k)$ to machine precision |

**Stacked with the recorded sharpening, all four of 109's random-point maxima fall below $\sqrt{3/2}$**, the deficiency [target.md](target.md) flags.

> **THE EXCLUDED-INDEX SHARPENING IS VOID WHERE IT WOULD MATTER.** $T$ vanishes on repeated indices, so row $\gamma$'s support omits $\gamma$ and the spread may be taken over the restricted spectrum. **The record's bite condition is right**, it bites exactly when $\lambda_\gamma$ is a *simple* extreme eigenvalue, so it touches at most $2$ of the $\binom n2$ rows. **It is provably void at every saturating row**, for all $n\ge4$: saturation forces $\min(\dim E_{\max},\dim E_{\min})\ge(n-2)/2$ from the pair cap $R_{\gamma\alpha}\le2$ with the marginal, the L109 analogue of [Lemma L70](bounds.md)'s dimension theorem, so no extreme eigenvalue there is simple. *This upgrades the block's measured "costs nothing at the maximiser" to a theorem about every saturating point.* **And the sharpened cap as written in [LEDGER.md](LEDGER.md) is invalid**: it uses $(\sigma_\gamma-\ell_\gamma)^2$ in [Lemma L107](bounds.md)'s symbols, means of the two largest and two smallest away from $\gamma$, which is *strictly smaller* than the derivable $(\lambda^{\hat\gamma}_{\max}-\lambda^{\hat\gamma}_{\min})^2$. **L107 maximises a mean of two indices; L109 maximises a difference, and the analogy breaks exactly there.** [Lemma L107](bounds.md) already carries this effect in a stronger pair form, and L109 cites neither it nor [L70](bounds.md).

**But it cannot close, and the reason is not new.** The cap is built from $T\ge0$ and a row marginal, so it lives in the class [Reviewers 67/68 closed](target.md) with a ceiling of $1.60$/$2.29$/$2.49$ at $n=6,8,12$.

> **THE TWO REVIEWERS DISAGREE ABOUT THIS CEILING, SO EXACTLY ONE IS WRONG AND SETTLING IT IS AN OPEN TASK.** [r593](../reviews/REVIEW_r593.md) holds that $1.60$ is the *withdrawn* figure (this file elsewhere calls it "an under-converged ascent") so the block should read $1.4136$/$2.2585$, with no updated counterpart at $n=12$. [r594](../reviews/REVIEW_r594.md) holds that the staleness charge is itself the error: $1.60/2.29/2.49$ and $1.413614/2.2585$ belong to **different constraint sets**, and only the first contains L109's inputs. *The question is which constraint set each figure was computed under, which the record does not currently say beside either number.* **The conclusion is unaffected either way**, "it cannot close" survives every figure on the record, the tightest being $1.306498$ against $\sqrt{3/2}=1.224745$. It sharpens pointwise and stops there. *Both reviewers state the limit unprompted:* random Weyl tensors are not the live band, and the cap is slack at $\Delta=0$.

**One refinement attempted and it does not sharpen, recorded so it is not retried.** Expanding $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ with $Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$ turns the first term into a **two-moment problem**, maximise $\sum\lambda_\alpha^2R_{\gamma\alpha}$ subject to $R_{\gamma\cdot}\ge0$, $\sum_\alpha R_{\gamma\alpha}=2(n-2)$, and $\sum_\alpha\lambda_\alpha R_{\gamma\alpha}=-2\lambda_\gamma$, the **per-row identity used as a constraint** rather than as a collapsing step. Its optimum puts mass on two eigenvalues and gives $\mathbb E[\lambda^2]\le(\lambda_{\min}+\lambda_{\max})\bar\mu-\lambda_{\min}\lambda_{\max}$, which is a genuine gain and makes the cap **$\gamma$-dependent**, as a per-direction cap should be.

**The gain is cancelled, but only when the two terms are bounded *separately*, so it is not weaker in every reading.** *Gate 2, Reviewers 111 and 112, agreeing.* The cancellation has an exact closed form, $\mathrm{Rf}_\gamma-U=(a-b)(\lambda_{\max}^2-\lambda_{\min}^2)$ to $4\times10^{-15}$, explained rather than measured. And the refinement is **strictly stronger** at every unbalanced product and every padded $W_{\mathbb{CP}^2}$: ratios $0.857$ at $S^3\times S^5$, $0.917$ at $S^4\times S^6$, $0.945$ at $S^5\times S^7$, $0.926$–$0.944$ at padded $W_{\mathbb{CP}^2}$. The recorded claim tested only balanced products and random points, exactly where it happens to be flat. **Spending both moments jointly does dominate:** one LP over the pair masses beats both caps and can never be weaker than the uniform one, gaining $17$–$33\%$. *It changes nothing where it matters*, the gain is exactly $0$ at the maximiser, even the sharp two-moment cap equalling the uniform cap at $S^k\times S^k$ for $n=6,8,10$, and the LP sits inside [post F10](fence-posts.md)'s closed class. **The route stays closed; the sentence closing it was wrong.** *And the "available and unused" constraint was neither:* $\sum_\alpha u_{\gamma\alpha}=-2\lambda_\gamma$ is $\sum_\beta\lambda_\beta R_{\gamma\beta}$ identically, the per-row identity re-summed.

**And there is no room where it matters most.** The uniform cap is **exactly saturated** at every balanced sphere product, slack $0.0000$ at $n=6,8,10$, so no sharpening can gain anything at the maximiser, which is where both reviewers found it costs nothing. All the slack is at random points ($+3.8$ to $+4.7$), which are not the live band. *So a per-direction cap must beat the crude one strictly inside the band, and the term to attack is $Q_\gamma$, not the second moment.* One constraint on it is already available and unused: $\sum_\alpha u_{\gamma\alpha}=-2\lambda_\gamma$ where $u_{\gamma\alpha}=\sum_\beta\lambda_\beta T_{\gamma\alpha\beta}$, again from the per-row identity.


#### Lemma L110, the per-direction identity, whose slack is exactly $g_\gamma/(4\lambda_\gamma)$

**ANSWERED: at a critical point the sharpest per-direction statement is an IDENTITY, and being an identity is exactly why it cannot close.** $Q_\gamma$ needs no cap there, it is *determined*. Per row, $Q_\gamma=2(W^\#)_{\gamma\gamma}$, and criticality gives $(W^\#)_{\gamma\gamma}=\theta\lambda_\gamma-\lambda_\gamma^2$, so the decomposition solves for $\theta$ outright:

$$\theta=\frac{\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}}{2\lambda_\gamma}+\lambda_\gamma-\frac{g_\gamma}{4\lambda_\gamma}\qquad\text{for every }\gamma\text{ with }\lambda_\gamma>0,$$

residual $\le2\times10^{-15}$ at $S^6\times S^6$, $S^5\times S^7$, $\mathbb{CP}^3$, $\mathbb{CP}^4$ and the $C_5$ blow-up, **so it holds off the diagonal locus, which the [Lemma L68](diagonal-half.md) form does not.** Dropping $g_\gamma\ge0$ gives the per-direction bound, whose slack at $\gamma$ is therefore **exactly $g_\gamma/(4\lambda_\gamma)$**. Summed over $\mathfrak p$ that slack is $\Delta$ divided through, so the bound carries the symmetry defect and nothing else.

**Hence it is an equality at every $\Delta=0$ critical point**, every balanced product, every unbalanced one, every $\mathbb{CP}^m$, measured slack $0$ against $2.012$ at the $C_5$ blow-up. So the bound carries the symmetry defect and nothing else, and the only freedom left in its right-hand side is $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$, the two-moment quantity maximised above.

**The route stays shut, and BOTH reasons first recorded here were wrong.** *Gate 2, Reviewers 293 and 294, on identical briefs; they agree on every number and differ only in what they graded, 294 the claim as stated and 293 its conclusion.*

- **It is not the same constraint set.** Pinning $Q_\gamma$ adds exactly $N-2$ independent equations beyond the two contractions the class carries, **$N=\binom n2=\dim\Lambda^2\mathbb R^n$** so the count is $n(n-1)/2-2$, $13$ at $n=6$, $26$ at $n=8$, and $64$ at $n=12$ ([PinCount.lean](../lean/HamiltonsCubic/Results/PinCount.lean)), and unlike those it is *violated* by $0.19$–$0.51$ at random Weyl tensors, so it is genuinely outside the list.
- **"Equality at the maximiser, therefore no escape" was a non sequitur.** Sharpness at the maximiser is a property every proof of a sharp bound has. The pin bites $23\%$ at one class maximiser and $34\%$ at another, turns two random spectra infeasible outright, and cuts exactly $0\%$ at every real Weyl critical spectrum, those coexist, which is precisely what the inference denied.
- **What actually closes it: the ceiling relocates rather than falls.** With the pin the $n=6$ supremum moves only to $\approx1.40$, $1.3993$ and $1.4005$ from two independent builds, against $\sqrt{3/2}=1.224745$, a residual gap of $14\%$; $n=8$ goes $2.29\to1.93$. *A pointwise bite at $n=12$ reaching $1.212$ appears in one reviewer's intermediate log and does NOT survive as a ceiling.*

**And the ceiling this file quotes at $1.60/2.29/2.49$ is stale in two places, by its own later paragraph**, which records $1.413614$ at $n=6$ and $2.2585$ at $n=8$ once the vector identity is carried. *One discrepancy left open:* the reviewers' independent encodings return $1.6089$ and $1.4212$ for the two regimes against this file's $1.7227$ and $1.4136$, so the constraint encodings are not identical and the third digit is not settled.


**The $Q_\gamma$ term, mapped.** Writing $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ with $Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$, two exact constraints hold ([run_q_structure.py](../scripts/runs/run_q_structure.py), $10^{-16}$ at $n=5,6,7,8$):

$$\sum_\gamma Q_\gamma=-2\lVert W\rVert^2,\qquad \sum_\gamma\lambda_\gamma Q_\gamma=2\langle W^\#,W\rangle .$$

**They are definitional, and weaker than that.** Both reviewers note the identities hold at *random* Weyl tensors too, so **criticality contributes nothing**, and $\sum_\gamma\lambda_\gamma Q_\gamma=2\langle W^\#,W\rangle$ is the definition of $W^\#$ in the eigenbasis. The **per-row identity is the only Weyl-specific input**, residual $10^{-15}$ on $\mathrm{Weyl}_n$ against $1.07$, $3.17$, $2.58$ on generic, Ricci-part and constant-curvature operators, *and it is weaker than the record treats it*: $\Pi_{\mathcal W}(\mathrm{ad}(v)^2)=-2\,\Pi_{\mathcal W}(vv^{\mathsf T})$ holds for **every** unit $v\in\mathfrak{so}(n)$, eigenvector or not. One linear identity on $\mathcal W_n$, a restatement of trace-freeness, rather than something strictly stronger than the trace the LP class carries. Contracted against weight $1$ they return $\sum g=4(n-1)$; against weight $\lambda$ they return $\sum\lambda g=-4\theta$. Both are recovered exactly, so the $Q$ decomposition carries nothing the record does not already hold, which is the *correct* version of what [withdrawn post F25](fence-posts.md) was reaching for, restricted to **equalities** as [Reviewer 109's category point](../reviews/REVIEW_r109.md) requires.

**So sharpening must come from an inequality on $Q_\gamma$, and the natural one is fenced.** $Q_\gamma=\lambda^{\mathsf T}A\lambda$ for $A=T_{\gamma\cdot\cdot}\ge0$ symmetric with row sums $R_{\gamma\cdot}$ and total $2(n-2)$; minimising that over such $A$ is a **transportation problem**, matching positive against negative eigenvalues subject to marginals. That is exactly [fence post F10](fence-posts.md)'s class (*"a route that relaxes alignment into marginals is already dead"*) and the class [Reviewers 67/68 ceilinged](target.md) at $1.60$/$2.29$/$2.49$.

**Which is why the reviewers' cap behaves as it does:** it sharpens pointwise by $15$–$25\%$ and cannot close, and both said so unprompted. *The per-direction-cap question is therefore exhausted from inside this structure*: the equalities are definitional, and the inequalities are the closed class. **Whether that exhausts item 3 as a whole is a route-status claim and is NOT decided here**, six such claims this session were drawn from correct computations and every one was wrong.


## Post F18, SCOPED: only the *unweighted* generator sum of Prop 1.7 is inert, it needs $n\ge5$, and the very next weight returns $\theta$ itself

#### Fence post F18, CONFIRMED at Gate 2 as scoped, with two hypotheses added

[Petersen–Wink 1908.09958](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7 gives $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$, one equation per generator. Summing over an orthonormal basis of $\mathfrak{so}(n)$ makes the left side the Casimir quadratic form on $\mathrm{Sym}^2(\Lambda^2)$, a scalar because $\mathrm{Weyl}_n$ is irreducible, equal to $c_{\mathcal W}(n)=4(n-1)$ exactly ($0$ on the scalar module, $2n$ on $\mathrm{Sym}^2_0$) ([b_casimir_second_moment.py](../scripts/route-b/b_casimir_second_moment.py)). *That value is not new information:* the Killing form $\mathop{\mathrm{tr}}(\mathrm{ad}X\,\mathrm{ad}Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ ([conventions.md](conventions.md)) makes every row marginal $\rho_\alpha=2(n-2)$, **[Lemma L153](bounds.md)**, which needs only $\lVert v_\alpha\rVert=1$ and holds off $\mathrm{Weyl}_n$ too, and $A(W)=2W$ gives $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta R_{\alpha\beta}=-2\lVert W\rVert^2$; expanding, $2\cdot2(n-2)+4=4(n-1)$. **Two hypotheses Gate 2 added.** (i) **$n\ge5$.** "A generator-independent invariant contraction must be a scalar" needs the adjoint of $\mathfrak{so}(n)$ irreducible, which fails at $n=4$: tracing $g$ separately over $\Lambda^2_\pm$ gives $(2.75,9.25)$, $(8.73,3.27)$, $(7.18,4.82)$ on three random $\mathrm{Weyl}_4$ points while the total stays pinned at $12$. (ii) **Only the *unweighted* sum is inert**, the scoped sentence below is correct, but "the summed second moment is inert" is not. Both reviewers independently produced the witness: $$\sum_\gamma\lambda_\gamma\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2=-4\,\theta(W)$$ exactly, verified to 12 digits at $n=5,6,7,8,10$, proved in two lines from $A(W)=2W$ and the definition of $\#$. **So any contraction of Prop 1.7 against a $\gamma$-independent weight recovers only Lemma L30/31, and the very next weight returns $\theta$ itself.** **Its published form is now named, so the next cycle recognises it on sight:** [Petersen–Wink 2105.09290](../references/petersen-wink-2021-tachibana-special-holonomy/) Prop 1.3 states exactly this contraction, as $g(\mathcal R(R_{\mathfrak g}),R_{\mathfrak g})=2\sum_I\Lambda_{\alpha\beta\gamma}\,g([\Xi_\alpha,\Xi_\beta],\Xi_\gamma)^2$ with $\Lambda_{\alpha\beta\gamma}=\lambda_\alpha(\lambda_\beta-\lambda_\gamma)^2+\lambda_\beta(\lambda_\gamma-\lambda_\alpha)^2+\lambda_\gamma(\lambda_\alpha-\lambda_\beta)^2$, the $\lambda$-weighted Prop 1.7 sum, whose value here is $-4\theta$. **Combining it with $\theta=\sum\lambda^3+3\sum T\lambda\lambda\lambda$ yields nothing**, because $\Lambda_{\alpha\beta\gamma}+6\lambda_\alpha\lambda_\beta\lambda_\gamma=\sum_{i\ne j}\lambda_i\lambda_j^2$ exactly, so the combination collapses to $\sum_I\big(\sum_{i\ne j}\lambda_i\lambda_j^2\big)T_{\alpha\beta\gamma}=-2\sum\lambda^3$, a linear consequence of the two inputs rather than a new constraint. *Attempted and closed on 2026-08-26.* The one part of Prop 1.3 that is **not** a contraction is its sign conclusion $\Lambda_{\alpha\beta\gamma}\ge0$, and that needs $R$ **2-nonnegative**, which a Weyl tensor is not, since $\mathop{\mathrm{tr}}W=0$ forces $\lambda_{\min}<0$. *Also recorded by Reviewer 70:* $A(W)=2W$ is a **per-row** identity, $\sum_\beta\lambda_\beta R_{\alpha\beta}=-2\lambda_\alpha$ for every $\alpha$ (residual $3\times10^{-15}$ on $\mathrm{Weyl}_n$, $1.0$ off it), strictly stronger than the trace the record used, and stronger than anything the LP class carries; and $\sum\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=2\langle W,W^\#\rangle$ holds **off** $\mathrm{Weyl}_n$, free of Bianchi and Ricci-flatness.

## Post F17, no LP argument on this constraint set proves item B's bound, and the LP is blind to $S=0$ only where $S=0$ is slack

#### Fence post F17, the LP is blind only where $S=0$ is slack

*The original statement and its reasoning were wrong.* It claimed that $(---)$ triples carry $\lambda_\alpha\lambda_\beta\lambda_\gamma<0$ so a maximiser empties them, making $S=0$ inert. That is a sign argument that ignores the row marginals: at the LP's own maximising spectrum at $n=6$, value $1.722739$, twelve of fifteen eigenvalues negative, the $(---)$ mass is **$12.000000$**, and imposing $S=0$ renders that spectrum **infeasible**. With most indices negative, the marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ forces mass into $(---)$ because a negative index has nowhere else to put it. *Reviewers 65 and 66 disagreed here and the disagreement located the boundary*: Reviewer 65's $40/40$ spectra with $S=0$ changing the optimum by $<10^{-7}$ were all in the slack regime, and never reached the extremal spectrum Reviewer 66 examined.

#### Lemma L114, the block-mass identity $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$, and its $\mathfrak h$-row twin

*Gate 2, [r639](../reviews/REVIEW_r639.md) and [r640](../reviews/REVIEW_r640.md) on identical briefs, **both CONFIRMED, agreeing on every point including what the record should do next**.*

> **THE IDENTITY IS A THEOREM, AND WIDER THAN ITS HYPOTHESIS SAYS.** It holds at every $n$, every $d$ and **every** orthogonal two-block split of $\mathfrak{so}(n)$ (no criticality, no Weyl symmetries, no isotropy) so *"the negative eigenspace"* overstates what is needed. **The $10^{-13}$ figures are a check, not the evidence.** The coefficients are slot-occupancy counts, $3\times2$, $2\times2$, $1\times2$, and hollowness of $T$ is load-bearing for them and uncited.

> **THE CONVENTION IS SETTLED: THIS BLOCK COUNTS UNORDERED TRIPLES, AND THE REST OF THE RECORD COUNTS ORDERED SLOTS.** The reading is stated nowhere here and **contradicts [conventions.md](conventions.md)'s own default** (*sums are over ordered pairs unless the line says otherwise*, and this line does not) while the only written definition of $S_{XYZ}$ anywhere on the record is ordered. **`git` shows both source reviewers stated the reading and the fold-in commit dropped it.** Witness, by hand at $n=6$, $d=6$: the display returns $48=2d(n-2)$ unordered and $144$ ordered. **The conversion is per pattern**, $S^{\mathrm{ord}}=6S^{\mathrm{unord}}$ on $\mathfrak{mmm}$ and $\mathfrak{hhh}$, $\times2$ on the mixed ones, *not a global constant.*

> **BOTH REVIEWERS RECOMMEND ADOPTING ORDERED SLOTS, AND NO NUMBER ON THE RECORD CHANGES, SIX DISPLAYS DO.** Ordered is the only written definition, it is a projector contraction well posed without hollowness, it makes the coefficients plain multinomials, and it is the consistent extension of a rule the record already states. *[ungraded-slack.md](ungraded-slack.md) and [nondegeneracy.md](nondegeneracy.md) do not move.*

> **THIS CLOSES THE [L77](isotropy-cap.md) DISPUTE WITH BOTH ITS REVIEWERS CORRECT.** $\gamma=S_{\mathfrak{mhh}}$ ordered, $\gamma=2S_{\mathfrak{mhh}}$ unordered, and the general law is $\gamma=S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}$. **Neither reviewer erred; the record had two conventions and named neither.**

> **THIS IDENTITY IS [LEMMA L36](isotropy-cap.md)'S KILLING BLOCK IDENTITY, RE-DERIVED AS A SEPARATE LEMMA IN A DIFFERENT FILE**, cross-referenced neither way. *And L114 with its twin **sum** to [nondegeneracy.md](nondegeneracy.md)'s $1/3/3/1$ identity, which therefore carries strictly less information, it cannot resolve $d$.*

> **"BOTH REVIEWERS REJECTED THE INFERENCE" IS FALSE.** One rejected it; the other **accepted it**, rescoped to the relaxation. *That rescue also fails, a constraint cannot raise a maximum, and a fence post twenty lines above shows the optimum dropping under $S=0$.* The withdrawal itself is correct, and nothing on the record still cites the withdrawn inference.

*The $\mathfrak h$-row twin is named in the heading and stated ten lines below it under a different hypothesis; $\mathfrak h:=\mathfrak m^\perp$ is assumed and never said, making the display false under [conventions.md](conventions.md)'s $\mathfrak h=E_{\max}$ sense; and the row marginal $2(n-2)$ carried no result number despite four consumers until [Lemma L153](bounds.md), numbered 2026-09-04 and cited here from 2026-09-05.*

#### The block-mass identity stands; the inference once drawn from it does not

With the negative eigenspace $\mathfrak m$ of dimension $d$, total symmetry of $T$ and the row marginal $2(n-2)$ (**[Lemma L153](bounds.md)**) give

$$6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2),$$

exact to $10^{-13}$ at $n=5,6,7$ and confirmed independently by both reviewers, multiplicities included. **What is withdrawn is the conclusion drawn from it**, that $S=0$ frees the $(---)$ mass into $(+--)$ and so mechanically raises $\theta$. The identity constrains only the weighted total $2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}$ and says nothing about how mass distributes between those two blocks, one of which enters $\theta$ positively and the other negatively. Both reviewers rejected the inference while confirming the identity.

#### Tested against the fuller constraint set, and the conclusion holds

Reviewer 66 flagged that its LP omitted the vector identity $R\lambda=-2\lambda$. Re-run here with both that identity and $S=0$ imposed, the optimum still reaches $1.306498$ at eight negative eigenvalues against $\sqrt{3/2}=1.224745$, down from $1.5305$ on marginals alone, but over. At the padded $W_{\mathbb{CP}^2}$ spectrum, where $S=0$ is vacuous, all four variants return $\sqrt{3/2}$ exactly. **So no LP argument on this constraint set proves item B's bound**, which is the fence post's operational content and it survives.

#### On $\{S=0\}$ the block structure is a one-parameter family, and that is all it is

Summing the row marginal $2(n-2)$ (**[Lemma L153](bounds.md)**) over $\mathfrak m$-rows and over $\mathfrak h$-rows gives two identities, both verified to $10^{-14}$ at $n=5,6,7$:

$$6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2),\qquad 6S_{\mathfrak{hhh}}+4S_{\mathfrak{mhh}}+2S_{\mathfrak{mmh}}=2(N-d)(n-2).$$

With $S_{\mathfrak{mmm}}=0$ they solve to $S_{\mathfrak{mmh}}=\tfrac12[d(n-2)-S_{\mathfrak{mhh}}]$ and $S_{\mathfrak{hhh}}=\tfrac16[(n-2)(2N-3d)-3S_{\mathfrak{mhh}}]$, so at fixed $n$ and $d$ every block mass is determined by $S_{\mathfrak{mhh}}$ alone.

#### Carrying the eigenvalues alongside the masses gives a bound tight at the maximiser

The proof of Lemma L36 bounds the positive block's mass two-sidedly, $4d^2/n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$, and the second marginal identity caps $6S_{\mathfrak{hhh}}\le(n-2)(2N-3d)$ since $S_{\mathfrak{mhh}}\ge0$. With $(++-)\le0$ on $\{S=0\}$ and the eigenvalue factors taken at their extremes,

$$\theta\le\sum_\alpha\lambda_\alpha^3+\tfrac32\lambda_1b^2(n-2)d+\tfrac12\lambda_1^3(n-2)(2N-3d),\qquad b=\max_{\mathfrak m}|\lambda| .$$

#### It is exact at every balanced sphere product

$1.0541$, $1.1456$, $1.2000$, $1.2360$ against $\theta_0(n)$ at $n=6,8,10,12$, agreeing to six digits. That is structural rather than lucky: at a graded point $S_{\mathfrak{mhh}}=0$ makes both mass bounds equalities, and the two-valued spectrum makes every eigenvalue factor attained. **So the mass-plus-eigenvalue argument closes at the cap without invoking the rigidity classification at all.**

#### Taking the minimum of two valid bounds gives one expression exact at BOTH families, and it still cannot cross the band

Each block admits two independent upper bounds, one from the pair caps and one from the marginals with isotropy, so their minimum is valid:

$$\theta\le\sum_\alpha\lambda_\alpha^3+\min\!\big[h(s^2-u),\ \tfrac12\lambda_1^3(n-2)(2N-3d)\big]+\min\!\big[3\lambda_1(s^2-v),\ \tfrac32\lambda_1b^2(n-2)d\big].$$

#### It is exact at all eight test points

$1.224745$ at padded $W_{\mathbb{CP}^2}$ and $1.0541,1.1456,1.2000,1.2360$ at the balanced sphere products, ratio $1.00$ throughout, so a single expression reproduces both $\sqrt{3/2}$ and $\theta_0(n)$. **And taking the minimum circumvents the non-composability above rather than violating it**: nothing is swapped, both bounds stand, and each is tight where the other is loose.

#### But maximised over the open band it reaches $8.16$, $11.13$, $13.78$ at $n=8,10,12$

attained at $d=15,23,33$, just under the cap, against targets near $1.2$. So exactness at two families says nothing about the region between them, and the failure is not in the bound's form: both components are valid. **Gate 2: the class of bounds is closed for good, not merely unexplored (Reviewer 67).** All three bounds are **confirmed valid**, with proofs of each step, and exact to $2.2\times10^{-16}$ where claimed; the spectral form additionally needs $\mathop{\mathrm{tr}}W=0$, witness $(1,-1,-1)/\sqrt3$, where $\theta=0.9623$ against a formula value of $-0.7698$, and conversely does **not** need $S=0$, bounding every traceless operator. The $\gamma=2S_{\mathfrak{mhh}}$ identity likewise needs $S_{\mathfrak{mmm}}=0$ as a standing hypothesis, the general law being $2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$. But the decisive point is structural: (a), (b) and (c) all use the same short list of linear facts about $T$, and **the LP maximising $\theta$ over every $T$ satisfying exactly that list is the class ceiling**, $1.6038$ at $n=6$ and $2.2913$ at $n=8$, against a target of $1.2247$. At the $n=8$ witness the spectral bound already **equals that ceiling to five digits**, so there is not one digit of room left to sharpen. *Frame-realisability is not the missing ingredient; it is the only ingredient left.*

#### And the graded stratum is a finite list, capped below target

$S_{\mathfrak{mhh}}=S_{\mathfrak{mmm}}=0$ says exactly that $(\mathfrak h,\mathfrak m)$ is a **symmetric pair**, so that stratum is $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$, plus $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $n=8$ where triality adds them ([trap W2](INDEX-traps.md)), a finite list. **But the maximisation over that list must be restricted to its Ricci-flat members, and the reviewer's numbers were not.** The operator $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ is Ricci-flat only under hypothesis (F2), $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, which **fails for unbalanced splits** because the two block projections are separately invariant. Measured Ricci residuals: $0.474$ at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, $0.359$ at $\mathfrak{so}(4)\oplus\mathfrak{so}(6)$, $0.288$ at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$, against $10^{-16}$ at every balanced split. **So the reported $1.1654$, $1.2041$ and the side finding that the balanced product is not the maximiser are values of non-Weyl operators**, and Lemma L23 (the maximum over the family being $\theta_0(n)$ at the balanced product), stands unaffected.

*This matters more than a bookkeeping correction.* At $n=12$ the same construction gives $\theta=1.238486$ at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ against $\theta_0(12)=1.236033$, a number that reads as a refutation of Conjecture A until the Ricci residual $0.288$ is checked. **Two reviewers in one cycle reported relaxation points as Weyl values**, in different contexts, and the same check settles both: a $K$-invariant two-eigenvalue operator is a Weyl tensor only when the isotropy leaves no invariant symmetric $2$-tensor beyond the identity.

#### Two sharper valid bounds exist and still do not suffice

A knapsack refinement, spend each block's mass budget on the largest triple products, at most $2$ per triple by the pair cap, dominates both halves of the minimum at once, since $\lambda_1^3\times$mass is the knapsack with every product replaced by its maximum and $h_3(s^2-u)$ is the knapsack with the budget removed. A per-row refinement uses $\sum_{b<g}T_{abg}=n-2$ as an identity at *every* index rather than in aggregate. Both stay exact at all eight test points and roughly halve the band maxima, still far above target. *(Implementation warning from the reviewer: the knapsack candidate list must not be truncated to the top few eigenvalues, since a pair $(1,k+1)$ can beat $(k-1,k)$; truncation under-estimates the knapsack, and an under-estimated knapsack is not an upper bound.)*

#### And the recorded band maxima were under-converged

: the true maximum of the min-bound at $n=8$ is $10.3085$, not $8.16$ (about $26\%$ low), with $d=15$ confirmed, and likewise $\ge15.81$ at $n=10$ and $\ge22.75$ at $n=12$. My own maximisation was a random sweep, hence a lower bound on a maximum, which is the direction error the record already warns about.

#### And the obvious repair fails: the realisability filter is too weak

The vector identity supplies a *computable* necessary condition on a spectrum, that some $R\ge0$, symmetric, zero-diagonal, with row sums $2(n-2)$ and entries $\le2$, satisfies $R\lambda=-2\lambda$, checkable as an LP in the $R$ entries. *A caution about that filter, learned the hard way.* It is an **equality**-constrained LP, so it is exquisitely sensitive to perturbations of $\lambda$: a candidate spectrum typed from a log rounded to five decimals returned **infeasible**, and the same spectrum reconstructed exactly returned **feasible** with row sums $8.000000$, max entry $2.0$ and $\|R\lambda+2\lambda\|=10^{-15}$. The two spectra differ by $9\times10^{-7}$. **A rounded spectrum fed to this test gives a meaningless answer**, and the accompanying positive control passes either way, lending the error false credibility. **And it does not constrain generic spectra**: $88\%$ of random draws pass, the band maximiser is among them, and filtered and unfiltered maxima agree exactly, $4.6079$ at $n=6$ and $7.3323$ at $n=8$. So restricting the maximisation to spectra that survive the strongest linear realisability test on record changes nothing, confirming fence post F15's claim for that test specifically.

#### What is missing is which spectra an $S=0$ Weyl tensor can actually have

That is frame-realisability, which fence post F15 already records as beyond any finite list of linear conditions, now confirmed for this strictly stronger constraint set.

#### A fully spectral dual is exact at small $d$ and dimension-free, but ignores the pair cap

Generalising Lemma L35's construction to all $\binom d2$ negative pairs, $(+++)$ covered by $z_{\alpha\beta}=h\lambda_\alpha\lambda_\beta$ with $h$ the harmonic mean of the three largest positives, $(+--)$ by $z_{\beta\gamma}=3\lambda_1|\lambda_\beta||\lambda_\gamma|$, and $(++-)$ free since its right-hand side is negative, gives

$$\theta\le\sum_\alpha\lambda_\alpha^3+h(s^2-u)+3\lambda_1(s^2-v),\qquad v=\textstyle\sum_{\mathfrak m}\lambda^2=1-u,$$

with **no $n$ in it**. It is exact at padded $W_{\mathbb{CP}^2}$ at every $n$ tested, $1.224745$, ratio $1.00$, recovering Lemma L35's reach without the $G$ reduction. **But it is $3.88$ to $6.95$ times over at the balanced sphere products, worsening with $n$**, because $3\lambda_1(s^2-v)$ charges every one of the $\binom d2$ negative pairs at full weight while the pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$ bounds their total. **So the missing ingredient is named: the $(+--)$ dual must respect the pair cap, and none of the three bounds on record does.**

#### The two bounds do not compose, and that is a fence post for the middle band

The obvious interpolation, keep the new $(+--)$ mass bound, replace the crude $(+++)\le\lambda_1^3S_{\mathfrak{hhh}}$ by Lemma L35's sharp harmonic-mean dual $h(s^2-u)$, is **dominated by the minimum $\min(a,b)$ and tight at neither end**: $1.67\times$ to $3.67\times$ over at padded $W_{\mathbb{CP}^2}$ and $1.72\times$ to $2.49\times$ at the balanced sphere products. *("Worse than either parent everywhere" was wrong, at padded $W_{\mathbb{CP}^2}$ the swap beats parent (a) by $14\times$.)* The reason is that each bound's exactness is a property of the **pairing** of its two halves, not of the halves separately: at the sphere product $S_{\mathfrak{mhh}}=0$ makes the mass bound an equality *and* the two-valued spectrum makes $\lambda_1^3S_{\mathfrak{hhh}}$ attained on every triple, while at padded $W_{\mathbb{CP}^2}$ the pair cap $2bc\lambda_1$ on $(+--)$ is attained where a mass bound growing with $n$ is not. **So term-swapping between the two cannot produce a bound for the middle band**, and a third variant of the same shape is not worth building.

#### And it is useless at small $d$

: $23\times$ to $284\times$ over at padded $W_{\mathbb{CP}^2}$ for $n=6\ldots12$, because with $d=2$ it charges every $(+++)$ triple at $\lambda_1^3$ while the true spectrum has one large eigenvalue and the rest zero. **So this bound and Lemma L35 are exactly complementary** (Lemma L35 is tight at $d\le2$ and useless at large $d$, this one the reverse) and the open middle band is precisely where neither is tight.

#### A monotonicity read off that is REFUTED

Since $S_{\mathfrak{mhh}}$ feeds the $(++-)$ block, which enters $\theta$ negatively, and raising it lowers both $S_{\mathfrak{mmh}}$ and $S_{\mathfrak{hhh}}$, which feed positive blocks, it is tempting to conclude $\theta$ is maximised at $S_{\mathfrak{mhh}}=0$, the graded case. **False.** Padded $W_{\mathbb{CP}^2}$ has $S_{\mathfrak{mhh}}=4,8,12,16$ at $n=6,8,10,12$ with $\theta=\sqrt{3/2}$ throughout, while the balanced sphere product has $S_{\mathfrak{mhh}}=0$ and $\theta=1.054,1.146,1.200,1.236$: below the crossover the point with the *larger* $S_{\mathfrak{mhh}}$ has the *higher* $\theta$. The identities constrain masses; $\theta$ weights them by eigenvalues, and the two points differ in $d$ by $2$ against $36$. **This is the third mass-based inference to fail on this item**, after fence post F17 and the $6/4/2$ argument, and the reason is the same each time.

#### What survives, and it is weaker

On spectra with few negative eigenvalues the $(---)$ block is genuinely slack and $S=0$ is inert there, which still explains why B0's stratum ($\dim\mathfrak m\le2$, where $(---)$ is empty outright) is the regime the relaxation handles. But the general claim that no LP argument can use $S=0$ is **withdrawn**: at spectra with many negative eigenvalues the constraint bites hard enough to remove them from the feasible set entirely.

## Post F16, the two-negative full-support stratum is measure zero, so no sampling method can census it

#### Fence post F16: the two-negative full-support stratum is measure zero, so no sampling method can census it

With the two negative eigenvectors fixed, existence is an exact convex feasibility problem, and random draws over every rank profile at $m=6$ return $0/36$ feasible, **including the rank $4+4$ profile where a witness demonstrably exists**. Penalised nonconvex searches are worse than uninformative here: one such search reported full-support two-negative witnesses at $m=6,8,10$ with a nondegenerate most-negative eigenvector, and none survived exact kernel-locking, their extra negative eigenvalues being asymptotic with a floor of $-10^{-10}$ at residual $5\times10^{-20}$; another failed to recover the known $m=6$ witness at all. Objects in this stratum must be constructed, and any negative result from a search over it is a statement about the search.

## Post F15, $\lambda_{\max}(M)$ cannot be certified from $T$'s marginals, and the reason is not that the constraint list was complete

#### Fence post F15: $\lambda_{\max}(M)$ cannot be certified from $T$'s marginals, and the reason is not that the constraint list was complete

$M$ depends on $W$ only through the pair $(\lambda,T)$ with $T_{\alpha\beta\gamma}=c'^2_{\alpha\beta\gamma}$. *The earlier claim that the bracket-transportation LP "carries every constraint $T$ is known to satisfy" was wrong*: the vector identity $R\lambda=-2\lambda$ is $N$ linear equations in $T$, of which the recorded $\mathop{\mathrm{tr}}(W^\#)=-1$ is the single $\lambda$-contraction, and the LP carried only that one. Adding the other $N-1$ moves the optimum from $1.722739$ to $1.413614$ at $n=6$ (an $18\%$ cut), **and the tightening does not scale**: at $n=8$ it moves $2.290283$ to $2.2585$, about $1.4\%$, while the overshoot itself grows from $1.63\,\theta_0$ to $2.00\,\theta_0$. So the route stays closed, on better evidence than before. *Two corrections to the recorded numbers*: the LP optimum on the old constraint set is $1.7227$ at $n=6$, not $1.6059$ (that figure was an under-converged ascent, reproduced here as one start among four) and at the padded $W_{\mathbb{CP}^2}$ spectrum the LP returns exactly $\sqrt{3/2}$ under both constraint sets at $n=6,8$, so **the relaxation is tight at the point that matters and the whole overshoot sits at spectra that are not Weyl spectra** ([b0_transport_lp_vector.py](../scripts/route-b/b0_transport_lp_vector.py)). Since $\lambda_{\max}(M)\ge\langle\lambda,M\lambda\rangle$ at unit $\lambda$, **that LP optimum is a feasible point where $\lambda_{\max}(M)$ exceeds $\theta_0$ by $52\%$.** No marginal-only argument can close B3; frame-realizability has to enter.

#### Lemma L116, $b(W^\#)=-b(W^2)$ on every curvature operator

#### A correction the literature forces, before it was used

Böhm–Wilking define $S^2_B(\mathfrak{so}(n))$ as the self-adjoint endomorphisms satisfying Bianchi, and state Hamilton's principle for the ODE $\dot R=R^2+R^\#$ on it, so **the sum** preserves Bianchi. $R^\#$ alone does not, and the inference "$Q(W)=\theta W$ is Bianchi, hence $b(W^2)=0$" is therefore false. What holds on every curvature operator is the cancellation

$$b(W^\#)=-\,b(W^2)=-\sum_\alpha\lambda_\alpha^2\,(v_\alpha\wedge v_\alpha),$$

with both sides genuinely nonzero, $0.962$ at $\mathbb{CP}^3$, $0.953$ at $\mathbb{CP}^4$. **This is a relation between $\lambda$ and the frame that no marginal of $T$ can see, so it is the handle fence post F15 says is missing.**

#### What $M$ actually is

Let $X=\sum_\alpha x_\alpha v_\alpha\otimes v_\alpha$ be the symmetric operator carrying $W$'s eigenframe with eigenvalues $x$. Böhm–Wilking's formula (4), evaluated on that frame, gives $X^\#=\tfrac12\sum_{\alpha\beta}x_\alpha x_\beta\,b_{\alpha\beta}\otimes b_{\alpha\beta}$, so

$$\langle x,Mx\rangle=\langle W,X^2+X^\#\rangle=\langle W\circ X,X\rangle=\langle L_WX,X\rangle,$$

and therefore

$$\lambda_{\max}(M)=\max\{\langle L_WX,X\rangle:\|X\|=1,\ X\ \text{diagonal in the eigenframe}\}$$

**the top eigenvalue of $L_W$ on a maximal abelian subspace of $W$'s commutant.** That is an operator the programme already computes: at the $C_5$ blow-up the ratio $\lambda_{\max}(M)/\theta$ is $1.206011$, matching the recorded $\lambda_{\max}(L_e|_{W^\perp})$ there to seven digits.

#### Lemma L115, $\theta>\max_\alpha\lambda_\alpha$ at every global maximiser, and $\lambda_{\max}(M)=\theta$ on the coordinate-diagonal locus

*Audited in [ROUND_L115](../verification/ROUND_L115.md): `PROVEN, hypotheses corrected`.*

**Statement.** Let $W\in\mathcal W_n$, $n\ge4$, be a unit Weyl tensor with spectrum $\lambda$ on $\Lambda^2$, and let $M=M(\lambda)$ be the matrix of [second-order.md](second-order.md), formed in an orthonormal eigenbasis.

1. If $W$ is a global maximiser, $\theta-\lambda_\alpha\ge\sqrt{3/2}-1>0$ for every $\alpha$.
2. If $W$ is a coordinate-diagonal global maximiser and $M$ is formed in the coordinate frame, $\lambda_{\max}(M)=\theta$. At the unit Weyl tensor of $S^m\times S^m$, $m\ge2$, with $M$ formed in its coordinate frame, $\lambda_{\max}(M)=\theta=\theta_0(2m)$ with no maximality assumed.

**Proof.** *Part 1.* $\lambda_\alpha\le\lVert\lambda\rVert=1$, and $\theta=M(n)\ge P(\text{padded }W_{\mathbb{CP}^2})=\sqrt{3/2}$.

*Part 2.* At a critical point $M\lambda=\theta\lambda$, so $\theta\le\lambda_{\max}(M)$ and it remains to show $q(S)\le\theta\lvert D_S\rvert^2$ for every hollow symmetric $S$, where $D_S=\sum_{i<j}S_{ij}\,e_{ij}\otimes e_{ij}$ and $q(S)=\langle s,Ms\rangle$ for the vector $s$ of its entries. With $W=D_\Lambda$, in the coordinate frame $q(S)=\tfrac12\sum_{i,j}\Lambda_{ij}S_{ij}^2+\tfrac12\mathop{\mathrm{tr}}(\Lambda S^2)$. $D_S$ is a Weyl tensor exactly when $S\mathbf 1=0$, the orthogonal complement is $\{U:U_{ij}=u_i+u_j\}$, and the bilinear form of $q$ vanishes between the two parts, using only $\Lambda\mathbf1=0$ and $S\mathbf1=0$. On the complement, with $s=\sum_iu_i$,
$$\frac{q(U)}{\lvert D_U\rvert^2}=\frac{(n-2)\,u^{\mathsf T}\Lambda u}{2\big((n-2)\lvert u\rvert^2+s^2\big)}\le\tfrac12\lambda_{\max}(\Lambda)<\frac1{\sqrt2},$$
the last because $\Lambda$ is traceless with $\lVert\Lambda\rVert_F^2=2$ and $\Lambda\mathbf1=0$. On the Weyl part write $A=aW+A'$ with $A'\in\mathcal W_n\cap W^\perp$: the cross term is $\theta\langle W,A'\rangle=0$, and [Lemma L24](second-order.md) gives $q(A')\le\tfrac\theta2\lvert A'\rvert^2$, so $q(A)\le\theta\lvert A\rvert^2$. A global maximiser supplies both L24's local maximality and $\theta\ge\sqrt{3/2}>1/\sqrt2$. At $S^m\times S^m$, $n=2m$, $\Lambda=\kappa L$ with $L=m\,E_{\rm same}-(m-1)E_{\rm mix}$ and $\kappa=1/\big(m\sqrt{(m-1)(2m-1)}\big)$, so $\theta=\theta_0(2m)$. Writing $S=\begin{pmatrix}X&Y\\Y^{\mathsf T}&Z\end{pmatrix}$ with $S\mathbf1=0$, $q(S)=\kappa(2m-1)\big(\lVert X\mathbf1\rVert^2+\lVert Y^{\mathsf T}\mathbf1\rVert^2-\lVert Y\rVert_F^2\big)$, and Cauchy–Schwarz along each row gives $q(S)\le\theta\lvert D_S\rvert^2$ on the Weyl part with no appeal to L24, while the complement's cap is $\kappa m(m-1)=\sqrt{(m-1)/(2m-1)}<\theta$ ([L115.lean](../lean/HamiltonsCubic/Results/L115.lean)). $\square$

**Open.** *$\lambda_{\max}(M)=\theta$ at every global maximiser is not proved. It follows from a cap $\langle Q(Z),W\rangle\le\theta\lVert Z\rVert^2$ on the part of $\mathcal D$ orthogonal to $\mathcal W_n$ inside the symmetric operators on $\Lambda^2$, since $L_W$ preserves $\mathcal W_n$ and L24 caps the Weyl part, and that cap is nowhere on the record. It also depends on the eigenbasis when eigenvalues repeat: at $n=4$ the unit tensor with $W^+=\mathop{\mathrm{diag}}(0,\tfrac1{\sqrt2},-\tfrac1{\sqrt2})$ and $W^-=0$ gives $\lambda_{\max}(M)=\sqrt{3/2}$ in one eigenbasis and $1$ in another, 45° apart inside its kernel, so a statement at every maximiser needs the eigenbasis fixed or a supremum over eigenbases.*

**The target $\sup_W\lambda_{\max}(M)\le\theta_0(n)$.** By $\theta\le\lambda_{\max}(M)$ it implies Conjecture A at even $n\ge12$, and not at odd $n\ge13$, where Conjecture A's constant is $\Theta_n<\theta_0(n)$. It is false at $n\le11$, padded $W_{\mathbb{CP}^2}$ giving $\sqrt{3/2}>\theta_0(n)$ there. Nothing on file shows it strictly stronger than Conjecture A: the $C_5$ blow-up's $\lambda_{\max}(M)=0.809017$ lies below $\theta_0(n)$ at every $n\ge4$. The converse direction, from Conjecture A to the pointwise bound at maximisers, needs the open equality.

#### A degenerate point that would have confirmed the false version

At $S^3\times S^3$ both $b(W^2)$ and $b(W^\#)$ vanish outright, so a screen run only there returns zero twice and reads as confirmation of $b(W^2)=0$. The sample has to vary in the feature being tested. ([b_rayleigh_identities.py](../scripts/route-b/b_rayleigh_identities.py), [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md))

---

*Re-filed here 2026-09-02 from [second-order.md](second-order.md) by the parallel sort of [findings/](.). Conventions: [conventions.md](conventions.md).*

## The bracket-transportation relaxation, closed on both ends
*From findings/second-order.md. Belongs in bounds.md because bounds.md owns the LP and block-mass bounds, and this is the marginal LP relaxation behind fence post F10.*

#### The bracket-transportation relaxation, closed on both ends

**The bracket-transportation relaxation cannot bound $P$.** In the eigenframe, $P=\sum_aw_a^3+\tfrac12\sum w_aw_bw_c\,T_{abc}$ with $T_{abc}=c_{abc}^2$ nonnegative, totally symmetric, and constrained by the row marginal $\sum_{b,c}T_{abc}=2(n-2)$ (**[Lemma L153](bounds.md)**), the pair cap $\sum_cT_{abc}\le2$ (**[Lemma L31](stratum-two-negative.md)**), the maximum of $\|[X,Y]\|^2$ over orthonormal pairs, proven through $\|\mathrm{ad}_X\|_{\mathrm{op}}\le\sqrt2$, and $\mathop{\mathrm{tr}}(W^\#)=-1$, which holds because $Q$ preserves the trace-free Weyl space. Carrying **every** one of those constraints, the LP still returns $1.6059$ against $\theta_0(6)=1.0541$, and $1.7654\times$ at $n=9$, with $\mathrm{LP}/\sqrt{n-2}$ flat near $0.80$ (Reviewer 26). What the constraints omit is frame-realizability of $T$, which is the original problem rather than a finite list of linear conditions.

**Its one tight configuration.** On the two-block slice the same relaxation is **exactly tight**: with $\mathop{\mathrm{tr}}(W^\#)=-1$ imposed, the argmax is $p=m(m-1)$, the pure-bivector count of $S^m\times S^m$, and the value equals $\theta_0(n)$ to $2.2\times10^{-16}$ at $n=6,8,10,12$, strictly below at odd $n$, the LP recovers the sphere product with no geometry supplied.

**And that tightness does not extend, which closes the route completely.** On the two-block slice the certificate is small: every pair cap and every $|V_a|\le1$ constraint is inactive at the optimum, so the row marginals together with $\mathop{\mathrm{tr}}(W^\#)=-1$ return $\theta_0(n)$ on their own. Off the slice that fails, at random trace-free $w$ the pair caps become active, and even the full constraint set returns $1.012$, $1.261$ and $1.169$ against $\theta_0(6)=1.054$. The tightness belongs to the two-block configuration, not to the method. **Gate 2 pending** on this last part.

---

*Re-filed here 2026-09-02 from [target.md](target.md) by the parallel sort of [findings/](.). Conventions: [conventions.md](conventions.md).*

## The sharpened $\lambda$-weighted bound, its witnesses, and the ingredient it lacks
*From findings/target.md. Belongs in bounds.md because that file owns the $\lambda$-weighted bound, the symmetry defect $\Delta$ and the ingredient the bound lacks; the canonical Lemma L41 block stays in target.md.*

#### Thirty-two $\Delta>0$ witnesses, and nine in the band, the sharpened bound is real, but not yet shown to be *needed* there

The sharpening below rested on a single witness. [b_circulant_band_witnesses.py](../scripts/lib/b_circulant_band_witnesses.py) supplies more from a family the record already carries rather than from a search: solving criticality on the symmetric-circulant locus, where the $n\times n$ system $M^{\circ2}+M^2=\theta M+\mathrm{diag}(s_i)$ collapses to $\lfloor n/2\rfloor$ equations, and screening every solution for Weyl-ness **and** criticality. **The counts $37$ / $32$ / $9$ are WRONG, they are a 60-start search yield, not a census, and the true figures are $\ge73$ / $\ge61$ / $\ge22$** (Gate 2, [Reviewer 74](../reviews/REVIEW_r74.md), confirmed by [Reviewer 73](../reviews/REVIEW_r73.md) at 400 starts). *There is a proof of incompleteness needing no numerics:* $Q$ is **quadratic**, so $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$ and the critical locus is closed under $W\mapsto-W$, yet **nine of the recorded 37 have no negation partner in the list** ($-1.236033$, $-0.728136$, $-0.540062$, $-0.242685$, $-0.199761$, $-0.055176$, $-0.054876$, $+0.456435$, $+1.145644$), verified against the script's own output. **The 60-start run also misses the $C_5$ blow-up itself**, which is a member of this very family and is the single witness the sharpening rested on. What the run did find was $\{S=0,\ 3\le\dim\mathfrak m<\lfloor n^2/4\rfloor\}$.

- **The sharpened bound is never violated** across all 37, worst $\theta-\text{bound}=4.4\times10^{-16}$, i.e. equality, not violation.
- **At all band points both bounds give $\theta\le\sqrt{3/2}$, but the statement is largely vacuous.** Six of the recorded nine, and twelve of the true twenty-two, have $\theta\le0$, where "$\theta\le\sqrt{3/2}$" says nothing; only three of the nine have $\theta>0$, the largest $0.612372$. So this family does *not* show the sharpening is needed on the band, and it is weaker evidence than the count suggested.
- **It does show the sharpening is real.** At $\theta=0.728768$ ($n=12$, $\dim\mathfrak m=36$, $S=96$, outside the band) the recorded bound gives $1.348672>\sqrt{3/2}$ and proves nothing, while the sharpened one gives $1.123155$ and does.

*What this is evidence for:* the $\lambda$-weighted bound may already suffice on the band. *What it is not:* nine witnesses from one family, all circulant and all diagonal, so the non-diagonal half of the band (which is the whole point of item **B**), is untouched. **Gate 2 pending.**

#### Lemma L119, the sharpened $\lambda$-weighted bound $\theta\le[\lvert\lambda_{\min}\rvert M-\lambda_{\mathfrak p}^{\min}\Delta]/4$

*Gate 2, [r613](../reviews/REVIEW_r613.md) and [r614](../reviews/REVIEW_r614.md) on identical briefs, **both CONFIRMED**, both proving more than the block claimed and both deriving by hand the figure it reported as measured.*

> **THE BOUND HOLDS AT EVERY UNIT $W\in\mathcal W_n$, $n\ge4$, AND CONSUMES NO CRITICALITY.** *Machine-checked in the eigenframe: `L119_every` in [L107Frame.lean](../lean/HamiltonsCubic/Results/L107Frame.lean).* The identity $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ needs total symmetry of $T$ with the Bianchi and trace relations (that is, $W\in\mathrm{Weyl}_n$) and nothing more. Both discards raise the right-hand side, which is the only composable combination. **But the unit-norm hypothesis was dropped, in the very sentence widening the scope**: the right-hand side scales as $s^3$ while $\theta$ is scale-free, so the bound is false off $\lVert W\rVert=1$.

> **BOTH IMPROVEMENT CLAIMS ARE PROVED, AND THE SECOND IS FORCED.** *Never weaker*: the gap is $\lambda^{\min}_{\mathfrak p}\Delta\ge0$. *Strictly stronger wherever $\Delta>0$*: **no exceptional points exist**, because tracelessness keeps $\mathfrak p$ non-empty and $\mathfrak p$ is the *strictly* positive eigenspace, so $\lambda^{\min}_{\mathfrak p}>0$ always. **The gain is capped by $\Delta/(4\sqrt{\dim\mathfrak p})$**, from $\dim\mathfrak p\,(\lambda^{\min}_{\mathfrak p})^2\le1$: it is large only on coarsely degenerate spectra, and it recovers the *smaller* half of the slack, leaving the $\lvert\lambda_{\min}\rvert$ side untouched.

> **THE $C_5$ FIGURE IS DERIVABLE AND BOTH REVIEWERS DERIVED IT INDEPENDENTLY.** From the recorded entries $4:-2:+1$ with blocks $(2,2,2,2,2)$, the row sum and $180c^2=1$ give $c=1/(6\sqrt5)$, and [Lemma L68](diagonal-half.md)'s closed form gives $g=0/1.2/0.6$ on within-block, adjacent and non-adjacent pairs, reproducing $\Delta=12$, $M=24$, $\sum g=36=4(n-1)$, and $0.894427\to0.670820=\theta$ exactly. **The mechanism is that $\mathfrak m$ carries a single eigenvalue while the larger positive eigenvalue carries zero $g$-mass, same-block vertices being twins, so both discards are vacuous there.** *It is a fact about that point and not about the family*, this file's own $n=12$ entry has slack $0.394$.

> **IT IS NOT THE ONLY CATALOGUED CRITICAL POINT WITH $\Delta>0$.** It is contradicted ten lines above in this file, with at least $61$ witnesses, and in four other places. **Worse for the block's own case, a better second witness sits twenty lines above**, where this bound carries $1.348672$ to $1.123155$, *across $\Theta_{12}=1.236033$*. The hedge about resting on one witness was honest and its premise was stale.

> **DEFECTS OF ATTRIBUTION AND SYMBOL.** The identity is **Petersen–Wink Prop 1.3**, named 188 lines above in this file while the block cites only a script. The $\mathfrak m/\mathfrak p/\ker$ splitting is uncited, and **under [conventions.md](conventions.md)'s tabled $\mathfrak m=E_{\min}$ the identity $4\theta=A-B$ is false**, the needed sense is the one in [curvature-invariants.md](curvature-invariants.md). The bare $M$ in the heading collides with $M(n)$, the global maximum. And *"that is, everywhere in the band not already handed to step H"* reinstates a converse [target.md](target.md) explicitly withdrew; only the inclusion holds, which is all the claim needs.

> **TWO FINDINGS THAT REACH BEYOND THIS BLOCK.** [Lemma L41](target.md) and its canon copy **state their equality case wrongly**, *"equality exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace"* is refuted by padded $W_{\mathbb{CP}^2}$, which attains equality with $16$ of $28$ in the kernel; it should read $E_{\min}\oplus\ker W$. And **[post F28](#) carries this identical inequality** 270 lines above, graded *"valid and inert"* and correctly attributed, one of the two must become a cross-reference.

#### SHARPENED, and the discarded term turns out to be the $\Delta$ term

([b_sharpened_lambda_bound.py](../scripts/route-b/b_sharpened_lambda_bound.py)). Splitting $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ over $\mathfrak m$, $\mathfrak p$ and $\ker$ is an **identity**, not an inequality:

$$4\theta=A-B,\qquad A:=\sum_{\gamma\in\mathfrak m}|\lambda_\gamma|g_\gamma,\qquad B:=\sum_{\gamma\in\mathfrak p}\lambda_\gamma g_\gamma,$$

residual $\le1.5\times10^{-15}$ at ten catalogued critical points, **and it is not a criticality statement**: both reviewers found it holds at non-critical Weyl tensors too ($\le3\times10^{-15}$) and fails off $\mathrm{Weyl}_n$ ($0.20$). Since $\sum_\gamma g_\gamma=4(n-1)$ is likewise an identity on $\mathrm{Weyl}_n$, **the sharpened bound is valid at every Weyl tensor**, not only at critical ones; the record tied it to critical points unnecessarily. It can be negative, but never vacuously, the bound dominates $\theta$ by construction, so a negative bound forces $\theta<0$. The recorded bound discarded $B$, and since $\lambda_\gamma>0$ strictly on $\mathfrak p$, **$B=0$ exactly when $\Delta=0$**. So the term thrown away is precisely the one carrying the symmetry defect, which is *why* the bound attained equality at all nine $\Delta=0$ points and nowhere else. Keeping it, via $B\ge\lambda_{\mathfrak p}^{\min}\Delta$:

$$\theta\ \le\ \frac{|\lambda_{\min}|\,M-\lambda_{\mathfrak p}^{\min}\,\Delta}{4},\qquad M=4(n-1)-\Delta-G_0 .$$

Never weaker than the recorded bound, strictly stronger wherever $\Delta>0$, that is, everywhere in the band not already handed to step **H**. At the $C_5$ blow-up it recovers **all** of the slack: $0.894427\to0.670820=\theta$ exactly. **The evidence for the size of the improvement rests on one witness**, since $C_5$ is the only catalogued critical point with $\Delta>0$; the identity and the two inequality steps are solid, the claim about how much it buys on the band is not. *Gate 2 pending.*

#### Reproduced in the tree

([b_lambda_weighted_bound.py](../scripts/route-b/b_lambda_weighted_bound.py)): the identity holds at residual $\le4\times10^{-15}$ over 14 points, the bound is never violated (worst margin $7\times10^{-16}$), and **equality holds at all nine symmetric-space points**, the four sphere products, $\mathbb{CP}^{2,3,4}$ and both padded points, the last two with $G_0=16$ and $8$. At the balanced product the bound returns $1.236033=\theta_0(12)$ exactly, so **it is sharp at the conjectured maximiser**. Slack is $0.224$ at the $C_5$ blow-up ($0.671$ against $0.894$) and $1.2$–$1.4$ at random Weyl tensors. *What it does not yet give:* at random points the bound exceeds $\sqrt{3/2}$, reaching $1.367$ at $n=8$, so it does not close the band on its own, the missing ingredient is control of $|\lambda_{\min}|$ on $\{S=0,\ 3\le\dim\mathfrak m<\lfloor n^2/4\rfloor\}$.

## The pinned programme at a fixed spectrum, and the two-eigenvalue stratum closed

**The maximisation of $\theta$ over the pinned class at a fixed spectrum is a linear programme in $\binom{d+2}3$ variables, and at two eigenvalues it returns $\theta_0(n)$ and no more.** *Gate 2, [r341](../reviews/REVIEW_r341.md) and [r342](../reviews/REVIEW_r342.md) on identical briefs; the reduction and Lemma L105 confirmed by both, and each reviewer reached Lemma L105 independently of the other and of the brief. The session validated Lemma L105 by a third route (the two branch multipliers, derived as the polynomials that annihilate the other variables), before recording it.*

#### Lemma L104, the value-type reduction

**Fix a unit $W\in\mathcal W_n$ and its spectrum as a multiset: distinct values $\nu_1,\dots,\nu_d$ with multiplicities $m_1,\dots,m_d$ summing to $N=\binom n2$ and **$\sum_im_i\nu_i=0$ by tracelessness**, *both the unit norm and this centring are load-bearing below and neither was stated; a first screen that centred $\nu$ as $\sum_i\nu_i=0$ returned wrong ranks at mixed multiplicities.* The relations (A), (B), (C) are those of [bounds.md](bounds.md), cited from nowhere in this file until now. Let $\Pi(\lambda)=\{(T,\theta):T\ge0$ totally symmetric and hollow, satisfying (A), (B), (C) at every row$\}$. Then $\Pi(\lambda)$ is a compact polyhedron in the pair $(T,\theta)$, and $\theta^\ast(\lambda):=\sup\{\theta:(T,\theta)\in\Pi(\lambda)\}$ (with the value $-\infty$ when $\Pi(\lambda)=\varnothing$), is attained at a $T$ constant on the orbits of $G=S_{m_1}\times\cdots\times S_{m_d}$, hence a function $t_{ijk}\ge0$ on the *admissible* class-multisets of size $3$.** Every $\theta$-critical point with that spectrum satisfies $\theta\le\theta^\ast(\lambda)$.

**Proof.** $G$ permutes indices inside eigenvalue classes, so $\lambda_{ga}=\lambda_a$; substituting into (A), (B), (C) row by row shows $\Pi(\lambda)$ is $G$-stable with $\theta$ untouched, and $\Pi(\lambda)$ is convex, so the average $\lvert G\rvert^{-1}\sum_gg\cdot T$ of a maximiser is a $G$-invariant maximiser. $G$ acts transitively on the triples of pairwise-distinct indices carrying a given class-multiset, for $\{i,i,j\}$ and $\{i,i,i\}$ because $S_{m_i}$ is transitive on ordered pairs and ordered triples of distinct elements, so a $G$-invariant hollow totally symmetric $T$ is exactly a function on those multisets. Compactness: $T\ge0$ with row sum $2(n-2)$ gives $0\le T_{abc}\le2(n-2)$, and (C) at a row with $\lambda_a\ne0$ then bounds $\theta$. $\square$

**The admissibility caveat is load-bearing.** A type $\{i,i,j\}$ exists only when $m_i\ge2$ and $\{i,i,i\}$ only when $m_i\ge3$, so the variable count is $\binom{d+2}3$ **only when every $m_i\ge3$**; at a generic spectrum, every $m_i=1$ and the count is $\binom d3$.

**The reduced system.** With $a$ in class $i$ and $\mu_j=m_j-\delta_{ij}$, the $3N$ equalities collapse to $3d$:
$$\text{(A}_i)\ \sum_{j<k}2\mu_j\mu_k t_{ijk}+\sum_j\mu_j(\mu_j-1)t_{ijj}=2(n-2),\qquad \text{(B}_i)\ \sum_{j<k}\mu_j\mu_k(\nu_j+\nu_k)t_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_jt_{ijj}=-2\nu_i,$$
$$\text{(C}_i)\ \sum_{j<k}2\mu_j\mu_k\nu_j\nu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_j^2t_{ijj}=2\nu_i(\theta-\nu_i).$$
The factor $(\nu_j+\nu_k)$ in (B$_i$), against the $2$ in the other two, is the two orders of a mixed pair carrying different weights. **Every coefficient was re-derived independently by both reviewers and the whole system checked at the $n=6$ balanced product, where both rows return $\theta_0(6)=\sqrt{10}/3$.**

**Rank $3d-2$, and the hypothesis $m_i\ge3$ guards only the variable count.** *The rank is $3d-2$ at the generic all-simple spectrum too, where only distinct-class triples are admissible; and the two dependencies below hold at **every** spectrum, since a linear relation among rows holds column by column and deleting columns cannot break it.* **The proof of \"only two\" is in this file and the block asserted it**: the double-root section below derives the annihilating multipliers as exactly the two-parameter family $\varphi_i(x)=m_i(x-\nu_i)(\beta-\kappa x)$, which is a description of $\ker M^{\mathsf T}$. Two dependencies, and only two: $\sum_im_i\nu_i(\text{A}_i)=\sum_im_i(\text{B}_i)$ and $\sum_im_i(\text{C}_i)=\sum_im_i\nu_i(\text{B}_i)$, the second with the $\theta$ terms cancelling by tracelessness, which is why neither pins $\theta$. So the feasible affine set has dimension $V+1-(3d-2)$ with $V$ the admissible-type count: $1$ at $d=2$, $4$ at $d=3$, $11$ at $d=4$. **At $d=2$, a class of multiplicity $2$ drops the dimension to $0$ and forces $\theta$**, $n=8$ with multiplicities $(26,2)$ is the witness. *The restriction to $d=2$ is load-bearing and was lost in transcription: both Gate 2 reviewers stated it there only, and at $d=3$ with multiplicities $(m_1,m_2,2)$ there are nine equations in ten unknowns, so the set is never a point, the dimension formula one sentence above gives $3$.* **And that witness proves more than it was credited with**: the reduced system forces $t_{122}=-\tfrac1{26}<0$, so $\Pi(\lambda)$ is **empty** there and no critical Weyl tensor has that spectrum at all. **With a class of multiplicity $1$ at $d=2$ the system is infeasible at every $n\ge3$** (from (A) and (B) alone, stronger than the $n\ge5$ recorded) so no Weyl tensor has a two-valued spectrum with a simple eigenvalue. *A further fact the system yields and the record does not hold: at $d=2$, $T\ge0$ forces $u/w\le n-2$, that is $r\ge n/2$, below which the segment is empty.*

**Dual certificates are complete.** Multipliers $(\alpha_i,\beta_i,\gamma_i)$ on the three rows of class $i$, summed, give an upper bound on $\theta$ whenever every accumulated type coefficient is $\le0$ and $\sum_i\gamma_i\nu_i>0$; by LP strong duality **every** valid bound at a fixed spectrum arises this way, **scoped to bounds valid on $\Pi(\lambda)$, and requiring the primal to be feasible.** *Both hypotheses were unstated and both bind: $\Pi(\lambda)$ drops the proved pair cap of [Lemma L31](stratum-two-negative.md), so a bound valid on the true feasible set need not arise here; and at the $(26,2)$ spectrum below the reduced system forces $t_{122}=-\tfrac1{26}<0$, so $\Pi(\lambda)$ is **empty** and no critical Weyl tensor has that spectrum, where completeness has nothing to be complete about.* *The stronger rider that every spectral bound on this record is such a certificate is false: [Lemma L73](bounds.md#lemma-l73-a-purely-spectral-necessary-condition-on-all-of-mathcal-w_n) carries no $\theta$, and [Lemma L35](stratum-two-negative.md#lemma-l35-at-most-two-negative-eigenvalues-caps-theta-at-sqrt32-unconditionally) consumes the pair cap, which $\Pi(\lambda)$ omits.*

**$\Pi(\lambda)$ is not the full pinned relaxation.** The proved pair cap $\sum_cT_{abc}=\lVert[v_a,v_b]\rVert^2\le2$ ([conventions.md](conventions.md)) is a valid linear constraint that $\Pi(\lambda)$ drops, so $\theta^\ast$ as defined here is an upper bound for the relaxation [r324](../reviews/REVIEW_r324.md) measured. In reduced variables the cap is the $G$-invariant family $\sum_k\mu_k^{(ij)}t_{ijk}\le2$, available at no cost. *At $d=2$ it is inert, which is why Lemma L105 does not need it.*

#### Lemma L105, every two-eigenvalue critical point has $\theta\le\theta_0(n)$, from $T\ge0$ alone

**Let $W$ be a $\theta$-critical point of unit norm whose spectrum takes exactly two values, $u>0$ with multiplicity $r$ and $-w<0$ with multiplicity $N-r$. Then**
$$\theta\ \le\ \min\Big\{(n-1)w,\ \frac{(n-2)u^2-2uw-w^2}{w}\Big\}\ \le\ \theta_0(n),$$
**with equality in the second inequality exactly at $r=n(n-2)/4$, which forces $u/w=n/(n-2)$ and $n$ even, the balanced sphere product's spectrum. At odd $n$ the inequality is strict.**

*Typed in full in Lean: the inequality at the operator as `L105_op` and `L105_branches` in [L105Op.lean](../lean/HamiltonsCubic/Results/L105Op.lean), through a per-vector proof that bypasses the route below through $T_{abc}=c^2$ ([r1735](../reviews/REVIEW_r1735.md)), and the equality case and odd-$n$ strictness in [L105Eq.lean](../lean/HamiltonsCubic/Results/L105Eq.lean) (`L105_eq_iff`, `L105_mult`, `L105_odd`, and at the operator `L105_op_eq`, `L105_op_odd`).*

*Two hypotheses came off at Gate 2. **Both multiplicities $\ge3$** guarded the route below (segment against point) and not the conclusion: at the degenerate multiplicities the coefficients sit on the left and force equality in one branch, so the displayed inequality survives. **And $n\ge5$ is never used**; it was inherited from Conjecture A's failure at $n=4$. *This matters because [ATTEMPTS.md](../ATTEMPTS.md) already cites the lemma for the whole two-eigenvalue stratum, a use outside the recorded hypotheses that is nonetheless sound.**

**The block understates its own footing.** Class-averaging the point's own $T$ satisfies the reduced system with $\bar t\ge0$, so **both branches hold at every $d=2$ critical point directly**, no $G$-averaging and no linear programme. *The route below is one way to reach them, not the only one.*

**Proof.** The $d=2$ feasible set is a segment for multiplicities at least $3$ ([Lemma L104](#lemma-l104-the-value-type-reduction)), and $\theta$ is affine along it, so $\theta^\ast$ is where the first nonnegativity constraint binds. Take the class-$1$ rows against the multiplier polynomial $\varphi(x)=(x-u)(x+w)$: it annihilates the coefficients of $t_{111}$ and $t_{122}$, and the polarisation $\psi(u,-w)=-\tfrac12(u+w)^2$ leaves $-(r-1)(N-r)(u+w)^2t_{112}=2u\theta-2(n-1)uw$, so $t_{112}\ge0$ is exactly $\theta\le(n-1)w$, **the $\Pi$-bound.** Take the class-$2$ rows against $\varphi(x)=(x-u)^2$: it annihilates $t_{112}$ and $t_{122}$, leaving $(N-r-1)(N-r-2)(u+w)^2t_{222}=2(n-2)u^2-4uw-2w^2-2w\theta$, so $t_{222}\ge0$ is $\theta\le[(n-2)u^2-2uw-w^2]/w$, **the tangent bound.** The remaining two constraints, $t_{111}\ge0$ and $t_{122}\ge0$, give lower bounds on $\theta$ and never bind above.

Tracelessness $ru=(N-r)w$ with $\lVert\lambda\rVert=1$ gives $ru\delta=(N-r)w\delta=1$ for $\delta=u+w$, hence $\delta^2=N/(r(N-r))$ and $w=\sqrt{r/(N(N-r))}$. The first branch is increasing in $r$ and the second decreasing, *the block asserted this and proved nothing, and the naive reading is a rising times a falling factor, which settles nothing.* **Proof**: $g'(\rho)=\rho^{-3/2}\big[\tfrac32(n-2)\rho^2-\rho+\tfrac12\big]$, whose bracket has discriminant $1-3(n-2)<0$, so $g'>0$ throughout.  writing $\rho=u/w=(N-r)/r$ they cross where $(n-2)\rho^2-2\rho-n=0$, i.e. $\rho=n/(n-2)$, i.e. $r=n(n-2)/4$. There $N-r=n^2/4$, $w=\tfrac1n\sqrt{2(n-2)/(n-1)}$ and $\theta=(n-1)w=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$. Since $r$ is an integer and $n(n-2)/4$ is an integer only for even $n$, the crossing is unattained at odd $n$. $\square$

**What this supplies that [Lemma L23](../results.md) needed a subalgebra for, stated exactly.** Branch two gives $r\le n(n-2)/4$ **and it is L23's cap reached by the same object under another name, not by avoiding it**. *Two of the three claims that stood here are refuted.* **\"No sum of squares\" is false**: $T_{abc}=c_{abc}^2$ is the sum of squares, and $S_{\mathfrak{mmm}}=(N-r)(N-r-1)(N-r-2)\,t_{222}$ is its normalisation over ordered distinct triples, L23's closed form falls out of the $t_{222}$ identity at $\theta=(n-1)w$. **\"No hypothesis that $E_+$ is closed under bracket\" is false**: the cap needs $t_{112}=0$, and $T\ge0$ alone gives only $r\le\frac{n(n-2)\sqrt{n-1}}{2(\sqrt{n-1}+1)}$, $r\le8$ at $n=6$ against the true $r\le6$. **What survives is the third clause**: no Lie theory enters the derivation itself. *Gate 2, [r573](../reviews/REVIEW_r573.md) and [r574](../reviews/REVIEW_r574.md).* **[graded-half.md](graded-half.md) records $\theta\le\theta_0(n)$ as the conjecture rather than a theorem on this stratum; on the two-eigenvalue stratum it is now a theorem.** Consistency with [post F40](fence-posts.md), whose $\dim E_+$ extension is false in general: its witness, padded $W_{\mathbb{CP}^2}$, has a kernel and three distinct eigenvalues, so it lies outside $d=2$, and a two-eigenvalue traceless $W$ has trivial kernel automatically.

**Relation to [Theorem A](../reviews/DERIVE-t11.md).** Same conclusion on the same stratum, reached without [Lemma L70](bounds.md) or [Lemma L71](bounds.md): the two branches here are the $\Pi$-bound and Corollary B2's tangent bound, and Lemma L105 shows they are the two facets of one polytope rather than two estimates that happen to cross.

**The pinned class is exactly strong enough at $d=2$ and not above it.** Restricted to two eigenvalues it returns $\theta_0(n)$ and no more, attained by the balanced product's own $T$ at the unique point where both facets bind. **The exactness is a property of which facet binds, not of the segment being short**, the $S^3\times S^3$ segment runs $\theta\in[\sqrt{10}/18,\sqrt{10}/3]$, a factor of six, matching [r334](../reviews/REVIEW_r334.md)'s recorded interval. *A session claim that small $d$ makes the LP tight because the feasible set is small is refuted by exactly that measurement.*

**The first facet has a structural reading, and it explains a correction the record already holds.** $t_{112}=0$ with $T\ge0$ says $\langle[E_{\max},E_{\max}],E_{\min}\rangle=0$, i.e. **$E_{\max}$ is a subalgebra**, so the $\Pi$-bound is saturated at *every* member of the subalgebra family, the $n=8$ torus at $0.540062$ and $\mathrm{ad}(\mathfrak{su}(3))$ at $0.836660$ among them. [Post F40](fence-posts.md) records that correction already, reached by a different audit; what the facet adds is *why*. **The balanced product is singled out not by saturating one bound but by being the unique point where both facets bind at once**, which is $t_{112}=t_{222}=0$: $E_{\max}$ a subalgebra and $E_{\min}$ bracket-orthogonal to itself, the two halves of a symmetric pair. *That is the grading statement [I15](../plan.md) asks for, proved at $d=2$.*


## Post F43, no per-row condition can close three or more eigenvalues, so the remaining content is cross-row

*Gate 2, [r343](../reviews/REVIEW_r343.md) and [r344](../reviews/REVIEW_r344.md) on identical briefs; the post is r344's, and it is agreement with two things this record already held rather than a new measurement.*

**The two facts, both on the record, and their consequence.** [Theorem B of DERIVE-t11](../reviews/DERIVE-t11.md) is the **complete** per-row condition at every $d$: the row point $(\mathbb E_a[X],\mathbb E_a[Y])$ must lie in the triangle cut by the chord and the two tangents, which is [r337](../reviews/REVIEW_r337.md)'s hull whenever the reduced extremes have multiplicity $\ge2$. And that same file's §5 exhibits the $n=12$ spectrum with multiplicities $(30,20,16)$ and values $(-m,1.2m,0.375m)$ **passing every row of it at $\theta=1.2917>\theta_0(12)=1.2360$.**

> **So the per-row family is spent at $d\ge3$: no inequality derived one row at a time can force $\theta\le\theta_0(n)$ there, because a spectrum satisfying all of them already exceeds the target.** *What a successor must clear:* a route through the pinned relaxation at three or more eigenvalues has to **couple rows**, the $\Sigma$-budget of Theorem C, the vertex enumeration of [DERIVE-sp3](../reviews/DERIVE-sp3.md), or a relation the per-index calculus does not carry at all. Naming a new per-row bound is not a route.

**AND THE WITNESS IS NOT REALISABLE, WHICH LEAVES THIS POST STANDING AND SHARPENS IT.** *[I24a](../plan.md) put the $(30,20,16)$ spectrum under the full pinned system, the three relations of [DERIVE-t11](../reviews/DERIVE-t11.md) with $T\ge0$ over all $\binom{66}3=45{,}760$ triples, where it returns $\max\theta=0.9242643$ against $\theta_0(12)=1.2360331$, the exact value being $\theta=\tfrac{74239}{10280}m$ with $\theta^2=\tfrac{501039011}{586515120}$ against $\theta_0(12)^2=\tfrac{55}{36}$.* **Gate 2, [r1056](../reviews/REVIEW_r1056.md) and [r1057](../reviews/REVIEW_r1057.md) on identical briefs, both CONFIRMED and both reached the exact rational independently.* **The post's conclusion is untouched by that**, and the reason is the whole point of it: a per-row route is closed by a spectrum that passes every per-row condition, whether or not any tensor realises it. *A per-row argument cannot see realisability, which is exactly the content the cross-row system carries.* **ONE WITNESS, NOT THE CLASS.** *[r1057](../reviews/REVIEW_r1057.md) screened the same multiplicities with the third eigenvalue moved and got LP maxima of $1.3193$, $1.3102$ and $1.2904$, all ABOVE $\theta_0(12)$, so nearby spectra survive the relaxation and the obstruction class is open.* **AND $1.2917$ IS NOT THE PER-ROW VALUE**, [DERIVE-t11](../reviews/DERIVE-t11.md) saying in its own words that the budget *recovers part of that pinning ($1.2917$ against the per-row $1.4078$)*, so the budget is already a CROSS-ROW relation. *The per-row maximum at this spectrum is $1.4078288$, and what the full system adds over the per-row family is $1.4078288$ against $0.9242643$, a factor of $1.5232$.*

**Why it is worth a post rather than a remark.** The per-row calculus is where every recorded spectral bound lives, [Lemma L70](bounds.md), the $\Pi$-bound, [Lemma L73](bounds.md), the triangle family, so it is the natural place to reach for, and its exhaustion is invisible from inside it: each new row inequality is true, provable and useless against this witness. **The parameter count [DERIVE-sp3](../reviews/DERIVE-sp3.md) first gave as its motivation is the weaker statement**; this is why the vertex route exists.

**Two structural facts recorded with it.** *(i)* The per-row multiplier is a **line** in the $(X,Y)$ plane, where $P_{jj}$ lies on the parabola $Y=X^2$ and $P_{jk}$ is the intersection of the tangents at $\nu_j$ and $\nu_k$; a line meets at most $d$ pair-points if it is a tangent and at most $2$ otherwise, while isolating a type needs $\binom{d+1}2-1$. That is $\le\max(d,2)$ only at $d=2$, **so $d=2$'s isolability is the arithmetic accident $3-1=2$ and not a genericity fact**, the unconditional form of [DERIVE-sp3](../reviews/DERIVE-sp3.md)'s obstruction. *(ii)* Across all rows the multiplier image has dimension $3d-2$ by [Lemma L104](#lemma-l104-the-value-type-reduction)'s two dependencies, so every type is isolable exactly when $3d-2=\binom{d+2}3$: true at $d\le2$, false at every $d\ge3$.

**And what does still generalise.** Annihilating a row's whole six-type support, rather than isolating one type, is six conditions on a seven-dimensional effective space and is therefore always solvable; strong duality then gives the closed-form $\theta$ at a named support without solving for $t$. **At $d=3$, saturating the $\Pi$-bound forces five named zeros**, whose realised meaning is that $E_{\max}$ and $E_{\mathrm{mid}}$ are commuting subalgebras whose sum is a subalgebra, the successor to "$t_{112}=0$ says $E_{\max}$ is a subalgebra" at [Lemma L105](#lemma-l105-every-two-eigenvalue-critical-point-has-thetaletheta_0n-from-tge0-alone), and consistent with the symmetric-pair vertex of [DERIVE-sp3b](../reviews/DERIVE-sp3b.md).

**Caveats carried, both recorded nowhere else.** $\Pi(\lambda)$ drops the proved pair cap, which at $d=3$ is six further inequalities; restoring it **breaks the four-zeros count**, so the vertex reading belongs to $\Pi(\lambda)$ as defined and not to the full pinned relaxation. And a $\theta$-saturating $W$ need not sit at a vertex unless the optimum is unique.

**The rank question both reviewers left blocked is settled by their own lemma, and $\theta$ is not forced.** Write the reduced system as $M t=b+\theta v$, so $M$ is $3d\times V$ and $v$ is the $\theta$-column. [r343](../reviews/REVIEW_r343.md) and [r344](../reviews/REVIEW_r344.md) both prove that a multiplier vector annihilating **every** type coefficient is exactly $\varphi_i(x)=m_i(x-\nu_i)(\beta-\kappa x)$, a two-parameter family, but that is precisely a description of the **left null space of $M$**, so $\dim\ker M^{\mathsf T}=2$ and $\mathop{\mathrm{rank}}M=3d-2$. Since $\mathop{\mathrm{rank}}[M\mid v]=3d-2$ as well, $v$ lies in the column span of $M$, so **no combination of the equations pins $\theta$, at a spectrum where $V\ge3d-2$**. *That hypothesis was missing here and is load-bearing: the argument needs $\mathop{\mathrm{rank}}M=3d-2$, which fails as soon as a class has multiplicity at most $2$, and [Lemma L104](#lemma-l104-the-value-type-reduction) forty-three lines above exhibits exactly such a spectrum where $\theta$ **is** forced.* So the two passages agree once each is read at its own multiplicities: the feasible set has dimension $V+1-(3d-2)$ with $\theta$ non-constant on it, and the vertex enumeration is necessary rather than an artefact. *Both reviewers recorded this as a rank check needing a computation; it is the corollary of a lemma each of them had already proved, read against the right matrix.*

#### The $T$-weighted contraction of Jacobi is an identity, and the mechanism says which contractions can escape

**I15 asks whether Jacobi has any consequence expressible in $T$ alone.** The first natural candidate (contract the Jacobi-derived identity against $c_{abg}$, so that every $c$ appears squared), **returns an identity and no constraint.**

**The mechanism, in one step.** Writing $A_a=\mathrm{ad}(v_a)$, antisymmetry of $c$ in its first two slots gives $\sum_{ab}c_{abg}A_aA_b=\tfrac12\sum_{ab}c_{abg}[A_a,A_b]$, and Jacobi (that $\mathrm{ad}$ is a homomorphism), turns the bracket into $\sum_dc_{abd}A_d$. The **Killing collapse** $\sum_{ab}c_{abg}c_{abd}=2(n-2)\delta_{gd}$ then leaves
$$\sum_{a,b}c_{abg}A_aA_b\;=\;(n-2)\,A_g .$$
*Verified exactly at $n=6,7,8$.* Contracting the criticality identity against $c_{abg}$ therefore collapses **both** sides to $2(n-2)\mathop{\mathrm{tr}}(W^\#)$ (checked at four sphere products, agreeing to machine zero) so the relation is vacuous.

> **THE GENERALISATION DOES NOT HOLD.** *[r357](../reviews/REVIEW_r357.md) and [r358](../reviews/REVIEW_r358.md), independently.* It claimed that **any** contraction pairing each $c$ with itself loses Jacobi's content. **False, and the counterexamples are the record's own relations.** Because $c$ is totally antisymmetric there are no distinguished bracket slots, so every such contraction is $\Sigma_{gd}[x]=\sum_{ab}x_{ab}c_{abg}c_{abd}$, and at $x\equiv1$ it is $2(n-2)\delta_{gd}$, at $x_{ab}=\lambda_a$ it is $-2\lambda_g\delta_{gd}$ which is **relation (B)**, and at $x_{ab}=\lambda_a\lambda_b$ it is $2(W^\#)_{gd}$ which is **relation (C)**. *Verified here: the $\lambda_a\lambda_b$ shadow equals $2(W^\#)_{gg}$ to machine precision at $S^3\times S^3$, with spread $[-0.53,0.47]$, plainly not a multiple of the identity.* **So squaring forces the Killing form only in the unweighted case**, and the true mechanism is that $\sum_{ab}c_{abg}c_{abd}=2(n-2)\delta_{gd}$ returns $2(n-2)$ times the **trace** of whatever it is applied to.

> **AND THE PHRASE "PAIR ACROSS DIFFERENT INDEX SLOTS" WAS WRONG TOO.** The escape terms displayed alongside it pair over the *same* slots with different third indices. **The real distinction is same-triple versus different-triple** ([r357](../reviews/REVIEW_r357.md)).

> **[POST F18](#) WAS SCOPED FOR EXACTLY THIS SLIP** ("only the *unweighted* generator sum is inert … the very next weight returns $\theta$ itself") and this section restated the unscoped form. *A fence post that names a trap is worth nothing if the next cycle walks into it from a different direction.*

**What survives, as PLAUSIBLE and unproved.** Two repairs are on offer ([r357](../reviews/REVIEW_r357.md)): by Schur, only an **ad-invariant** weight forces the Killing form; and a same-triple pairing returns a marginal of $T$, which is a *definition* rather than a constraint. **Neither is proved here, so I15 is not settled by this argument**, and the [r331](../reviews/REVIEW_r331.md) citation over-claims, r331 proves completeness at **linear order in $T$** and says so.

**And the vacuity check was weaker than it looked.** The contraction's collapse comes from relation (A)'s $g$-independence, and what comes out is $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$, which follows from (B) at **every** Weyl tensor, so **the four sphere-product checks could not have failed**, whatever the claim ([r357](../reviews/REVIEW_r357.md)).

**A convention trap recorded with it.** $\mathrm{ad}$ is a homomorphism for $(A_a)_{mn}=c_{anm}$ and **not** for $(A_a)_{mn}=c_{amn}$, the two differ by a transpose, hence by a sign, and $[A_a,A_b]=\sum_dc_{abd}A_d$ holds for one and fails for the other. *A first attempt at the contraction above used the wrong one; the step-1 identity then failed by a factor and the numerical check caught it before anything was recorded.* [adversarial_check1.py](../scripts/lib/adversarial_check1.py)'s $Q$ implementation, **not** [conventions.md](conventions.md), which carries no such line, and citing it there was a defect, uses $(A_a)_{bg}=c_{abg}$ with $A_a$ skew. That is immune only because $W^\#$ is **quadratic** in $\mathrm{ad}$; in that convention the collapse above reads $-(n-2)A_g$, but the homomorphism direction must be fixed before Jacobi is used.

#### The double-root multipliers: a second cut family, and the sign information the first one lacked

**The row identities of [DERIVE-sp3c](../reviews/DERIVE-sp3c.md) used $\varphi(x)=(x-\nu_a)(x-\nu_b)$, which annihilates two types and leaves four.** The unexplored companion is the **double root** $\varphi(x)=(x-\nu_r)^2$: it annihilates **every type containing $r$**, leaving only **three**, and it is the family that carries sign information, since $\varphi\ge0$ pointwise and its polarisation $\psi(\nu_j,\nu_k)=(\nu_j-\nu_r)(\nu_k-\nu_r)$ is positive or negative according to whether $\nu_j,\nu_k$ lie on the same side of $\nu_r$.

> **NINE IDENTITIES, EACH FORBIDDING A THREE-SUBSET**, hence all seven four-subsets containing it, where the first family forbade one apiece. Three carry the clean right-hand side $2\nu_i\big[(n-1)\nu_i+\theta\big]$, and **two of those are unconditional on a kernel-free spectrum with $\theta>0$**: at $\nu_1,\nu_2>0$ it cannot vanish. The third, at $\nu_3<0$, vanishes exactly at $\theta=(n-1)\lvert\nu_3\rvert$, the $\Pi$-bound attained, the same degeneracy the first family showed.

| forbidden three-subset | unless |
|---|---|
| $\{122,123,133\}$ | $\nu_1\big[(n-1)\nu_1+\theta\big]=0$, **unconditional** |
| $\{112,123,233\}$ | $\nu_2\big[(n-1)\nu_2+\theta\big]=0$, **unconditional** |
| $\{113,123,223\}$ | $\theta=(n-1)\lvert\nu_3\rvert$, i.e. $\Pi$ attained |
| six more | quadratic conditions in $(\nu,\theta)$, not analysed here |

**The cut, with its hypotheses.** *[r359](../reviews/REVIEW_r359.md), [r360](../reviews/REVIEW_r360.md).*

| hypotheses | supports |
|---|---|
| none beyond criticality and kernel-freeness | $210\to206\to199\to\mathbf{192}$ |
| $+\ \nu_2>0$ | $\to\mathbf{173}$ |
| $+\ \Pi$ strict and the six quadratic right-hand sides nonzero | $\to130$ |

> **$\nu_2>0$ WAS ASSUMED AND NOT PROVED, AND THAT IS A REGRESSION.** With $\nu_2<0$ the right-hand side $2\nu_2[(n-1)\nu_2+\theta]$ vanishes at $\theta=(n-1)\lvert\nu_2\rvert$, **strictly inside** the $\Pi$-bound, and [Lemma L35](stratum-two-negative.md) does not exclude that stratum at $d=3$. *[DERIVE-sp3c](../reviews/DERIVE-sp3c.md) had already corrected exactly this error once.* **The sign-hypothesis-free figure is $192$**; the chain to $173$ carries $\nu_2>0$ and must say so.

> **AND THE CREDIT WAS BACKWARDS.** The *truly unconditional* three-subset $\{122,123,133\}$ removes **zero** new supports, every four-subset containing it already contains $\{123,133\}$ and fell to the pair cut. **All six removals come from $\{112,123,233\}$, the one needing $\nu_2>0$.** *Verified here: $0$ against $6$. So this family reproduces exactly the pattern it claimed to have escaped, the proved identity cuts nothing and the cutting one is unproved.*

**A cheap repair is available** ([r360](../reviews/REVIEW_r360.md)): adding *second-$\Pi$-strictness*, $\theta\ne(n-1)\lvert\nu_2\rvert$, rescues the $\nu_2$ row, two of the six clean four-subsets, and the pair cut, all of which degenerate at the same point. **Two of the six quadratic right-hand sides are sign-determined with no hypothesis on $\nu_2$, derived independently here, not taken on report.** Writing $\rho_1=\nu_1/\lvert\nu_3\rvert$:

- *Row 3, double root $\nu_1$*, forbidding $\{223,233,333\}$: the right-hand side is $2[(n-2)\nu_1^2+2\nu_1\nu_3-\nu_3^2+\nu_3\theta]$, and substituting the $\Pi$-bound $\theta\le(n-1)\lvert\nu_3\rvert$ makes it $\ge2(\rho_1+1)\big[(n-2)\rho_1-n\big]\lvert\nu_3\rvert^2$, **positive exactly when $\rho_1>\tfrac n{n-2}$.**
- *Row 1, double root $\nu_3$*, forbidding $\{111,112,122\}$: the right-hand side is $2[(n-2)\nu_3^2-\nu_1^2+2\nu_1\nu_3+\nu_1\theta]$, and dropping the nonnegative $\nu_1\theta$ leaves $2[(n-2)-\rho_1^2-2\rho_1]\lvert\nu_3\rvert^2$, **positive when $\rho_1<\sqrt{n-1}-1$.**

**The two ranges cover everything at $n\ge7$**, $\sqrt{n-1}-1\ge\tfrac n{n-2}$ there, and **not at $n=6$**, where $1.2361<1.5$ leaves a genuine gap. *So at every $d=3$ spectrum with $n\ge7$, one of these two three-subsets falls with no sign hypothesis on $\nu_2$ at all, removing seven supports.*

> **THE CLASSIFICATION IN THIS SECTION WAS MADE BY THE WRONG CRITERION, AND THREE COUNTS FOLLOWED IT DOWN.** *[r361](../reviews/REVIEW_r361.md) and [r362](../reviews/REVIEW_r362.md), independently.* **The forbidding argument needs the right-hand side to be NONZERO, not signed**, [DERIVE-sp3c](../reviews/DERIVE-sp3c.md) states exactly that, and the table here classified by positivity anyway. So $2\nu_2[(n-1)\nu_1+\theta]$, filed as "needs the sign of $\nu_2$", is **hypothesis-free**: the bracket is a sum of positives and $\nu_2\ne0$ by kernel-freeness. *All three figures this record has carried for the free count ($192$, $201$, $195$), are the same failure.*

> **THE COUNTS IN THIS SECTION ARE ENUMERATIONS, AND THE ARGUMENTS ARE THE RESULTS.** $194$, $178$–$179$ and $141$ are obtained by enumerating the $\binom{10}4$ four-subsets against a list of forbidden type-sets. They are finite and a reader can recheck them, but **they are computations, not arguments**, and they are recorded as scaffolding rather than as findings. *What carries independently of them: the classification of right-hand sides by their bracket, the dichotomy on $(n-1)\nu_2+\theta$, and the exhaustion of the multiplier space, each an argument, and each is what the counts were built to test.* **The scaffolding has done its work: it established that the per-row calculus is spent ([post F45](INDEX-traps.md)), and the target is now a constraint from outside it.**

**The corrected classification.** Both families' right-hand sides factor as $(\text{a nonzero eigenvalue})\times(\text{a bracket})$, and **the bracket $(n-1)\nu_j+\theta$ depends only on $j$; the factor $\nu_i$ never obstructs.** So:

| bracket | status | four-type members | double-root diagonal |
|---|---|---|---|
| $j=1$: $(n-1)\nu_1+\theta$ | **always nonzero**, free | $2$ | $i=r=1$ |
| $j=3$: $(n-1)\nu_3+\theta$ | zero iff $\Pi$ attained | $2$ | $i=r=3$ |
| $j=2$: $(n-1)\nu_2+\theta$ | sign of $\nu_2$ unresolved | $2$ | $i=r=2$ |

**Hypothesis-free: $210\to209\to208\to201\to\mathbf{194}$**, both reviewers independently, recounting from the definitions rather than from the recorded free set. *The discrepancy is closed: recomputing with the **corrected** free set, the two four-type identities with bracket $j=1$, then the free three-subset $\{122,123,133\}$, then whichever $\rho_1$ condition holds at $n\ge7$, this session reaches $210\to208\to201\to194$ as well. The earlier $192$ used the pre-correction free set.* **All three parties now agree at $194$.**

| step | supports |
|---|---|
| the two four-type identities with bracket $j=1$ | $210\to208$ |
| the free three-subset $\{122,123,133\}$ | $\to201$ |
| whichever $\rho_1$ condition holds ($n\ge7$) | $\to\mathbf{194}$ |

> **AND TWO FURTHER ROWS OF THIS SECTION ARE WITHDRAWN.** The $\nu_2>0$ figure is $178$–$179$, **not $173$**, only four identities are actually bought by the sign, not the nine the columns promised. And **$130$ is unreachable**: taking *all eighteen* identities nonzero floors at $141$, so that row drew on something outside the family (Jacobi, or the pair cuts over $28$ subsets), without saying so.



#### The $\nu_2$ sign: an unconditional dichotomy, replacing the branch and the repair

**The sign of $\nu_2$ is undetermined**, tracelessness gives only $\nu_1>0>\nu_3$, and [Lemma L35](stratum-two-negative.md) does not reach it at $d=3$, a negative $\nu_2$ still leaving $m_2+m_3\ge6$ negative eigenvalues. **But it need not be branched on at all** ([r362](../reviews/REVIEW_r362.md)):

> **DICHOTOMY, with no hypothesis anywhere.** Either $(n-1)\nu_2+\theta>0$, so the $j=2$ bracket is nonzero and its three identities apply; **or** $(n-1)\nu_2+\theta\le0$, which forces $\nu_2\le-\theta/(n-1)<0$ and hence $\theta\le(n-1)\lvert\nu_2\rvert<(n-1)\lvert\nu_3\rvert$ (**$\Pi$ strict**) so the three $j=3$ identities apply instead. *The whole of the step is $\lvert\nu_2\rvert<\lvert\nu_3\rvert$ whenever $\nu_3<\nu_2<0$, verified here.* **Either way three identities are bought, and neither alternative assumes anything.**

> **THE "SECOND-$\Pi$-STRICTNESS" REPAIR RECORDED HERE IS WITHDRAWN ON BOTH HALVES.** It is **unnecessary** (the dichotomy needs no such condition) and **insufficient**: it permits $\theta<(n-1)\lvert\nu_2\rvert$, where the pair cut's direction reverses, and it never reaches the double-root identity at row $2$ root $1$. *The $\nu_2<0$ branch costs **four** identities, not the one recorded.*

> **AND THE NAME IMPORTED LEGITIMACY THE OBJECT LACKS.** [Lemma L71](bounds.md) characterises saturation of [Lemma L70](bounds.md), **not** of the $\Pi$-bound, and [Lemma L107](bounds.md)'s derivation has no analogue at $\nu_2$, needing $\lambda_{\min}$ as the support endpoint. *There is no second $\Pi$-bound; "second-$\Pi$-saturation" is a coincidence locus and inherits no rigidity.* **[conventions.md](conventions.md) warns that a quantity's name is not its definition; this section coined a name and then reasoned from it.**

**A screen run here was worthless and is reported as such.** A sampler meant to classify the nine right-hand sides drew $\theta\in(0,3)$ while the constraint boundaries sit at $\theta=(n-1)\lvert\nu_i\rvert\ge6$, so it never reached the boundary it existed to detect. *Fifth of this session; the classification above owes it nothing.*

## Post F45, the per-row multiplier calculus is a plane geometry, and it cannot close $d=3$

*Gate 2, [r363](../reviews/REVIEW_r363.md) and [r364](../reviews/REVIEW_r364.md), independently on identical briefs. **Both refuted the first version of this post, by the same mechanism, found separately.** It is replaced.*

### The calculus, stated as what it is

Write a row multiplier as an affine functional $\ell(X,Y)=c_0+c_1X+c_2Y$. It **annihilates** exactly those types whose point lies on the line $\ell=0$, where
$$P_{jj}=(\nu_j,\ \nu_j^2)\quad\text{on the parabola }Y=X^2,\qquad P_{jk}=\big(\tfrac{\nu_j+\nu_k}2,\ \nu_j\nu_k\big)\ \text{strictly below it},$$
and its **right-hand side is $(n-2)\,\ell(R_i)$** for the row point $R_i=\big(\tfrac{-\nu_i}{n-2},\ \tfrac{\nu_i(\theta-\nu_i)}{n-2}\big)$. *So "the right-hand side is nonzero" is "the line misses $R_i$", and the whole per-row family is six points, one row point, and the lines between them.*

> **THE APPARATUS IS $27$ IDENTITIES, NOT THE $18$ THIS POST FIRST CLAIMED.** Only a line through $\ge2$ of the six points can forbid a four-subset, and there are $\binom62=15$; the tangent at $\nu_r$ carries $P_{rr},P_{ra},P_{rb}$ and so consumes $3$ apiece, $9$ in all. **Six remain: the three chords $\{P_{aa},P_{bb}\}$ the record has, and three secants $\{P_{aa},P_{bc}\}$ ($P_{11}P_{23}$, $P_{22}P_{13}$, $P_{33}P_{12}$), it never listed.** Nine per row. *Hand-checked at $\nu=(2,1,-3)$: $\varphi=(3x-1)(x-2)$ annihilates exactly $\{i11\}$ and $\{i23\}$. r363's witness: $Z=\{112,113,122,133\}$ survives all eighteen and dies to $P_{11}P_{23}$ at row $1$, with right-hand side $\nu_1[(n-1)z+\theta]$, as usable as any recorded one.*

**One general form subsumes both recorded families** ([r363](../reviews/REVIEW_r363.md)): at row $i$, $\varphi=(x-\nu_i)(x-z)$ has right-hand side $\nu_i[(n-1)z+\theta]$.

### Non-closure, by union bound

**A tangent forbids a three-subset, which lies in $7$ four-subsets; a two-point line forbids a four-subset, which is $1$.** So the whole apparatus kills at most
$$9\times7+18\times1=81\ \text{of the }210,\qquad\text{leaving at least }\mathbf{129}\ \text{supports}.$$

> **THE PER-ROW MULTIPLIER METHOD CANNOT CLOSE $d=3$.** *This is a counting bound on the identities themselves. It uses no enumeration of what they cut.*

**The exact figure is $132$** ([r363](../reviews/REVIEW_r363.md), by hand): killed $=45$ four-type-in-one-row $+\,33$ tangent triples, the latter $36-3$ by inclusion–exclusion. Consistent with the bound, and it carries a cross-check worth stating: **dropping the nine omitted secants returns exactly $141$**, so *the first version's arithmetic was right and its family was wrong.*

### Two limits of the method

**$141$ was never a floor.** It was the survivor count of the eighteen-identity subfamily. **So this post's retrospective conviction of the withdrawn $130$ row ("$130<141$, below the floor"), is void**, and that withdrawal must rest on its own reasons.

**Spanning was the wrong completeness criterion** ([r363](../reviews/REVIEW_r363.md)). The span argument proves too much: it would make the two-root family redundant, which the record denies by *using* that family.

**"Grant every right-hand side nonzero" is not the strongest the method can be** ([r364](../reviews/REVIEW_r364.md)). With $T\ge0$ the coefficients can be mixed in sign, and a nonzero right-hand side then forbids more than annihilation gives: at the row-$2$ tangent a positive one forbids the **pair** $\{112,233\}$ ($28$ four-subsets) and a negative one the **singleton** $\{123\}$, which is $84$. [Lemma L104](#lemma-l104-the-value-type-reduction)'s duality paragraph states the certificate as coefficients $\le0$, not $=0$. *The first version instrumented the annihilation subfamily and called it the method.*

### Where the bar actually sits

> **THE COMPLETE PER-ROW CONDITION IS $R_i\in\mathop{\mathrm{conv}}(\text{used points})$**, [Theorem B of DERIVE-t11](../reviews/DERIVE-t11.md) restated ([r363](../reviews/REVIEW_r363.md)). **The annihilation identities are its affine shadow.** So the first version's "a successor must clear a per-row constraint of no multiplier form" is set at the wrong place: the complete condition is already on the record, and it is a convex-hull membership rather than a line.

**And a per-row constraint of no multiplier form was already recorded** ([r364](../reviews/REVIEW_r364.md)): the **pair cap** $\sum_cT_{abc}\le2$, in [conventions.md](conventions.md), discussed two sections above this post.

> **WHAT CLOSES THE PER-ROW ROUTE IS [post F43](#post-f43-no-per-row-condition-can-close-three-or-more-eigenvalues-so-the-remaining-content-is-cross-row), NOT ANY COUNT.** The $n=12$, $(30,20,16)$ witness does it. *This post's surviving content is the plane geometry above and the union bound; its headline was count-dependent and the count was wrong.*


#### Lemma L173, the pinned class cannot bound $\theta$ once a kernel is allowed, and the witness is exact

*Gate 2, [r757](../reviews/REVIEW_r757.md) and [r758](../reviews/REVIEW_r758.md), on identical briefs, **both `PROVEN, hypotheses corrected`**. Every one of the twenty-two checked quantities is exact; the defects were in the machine-checked file and in two words of the conclusion.*

> **THE WITNESS EXISTS AT EVERY $n\ge8$, NOT ONLY AT $n=12$.** *Taking $m_3=\binom n2-7$ gives the same family at every $n\ge8$, with $\theta=\tfrac{\sqrt{21}}2$ constant in $n$ against $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}<2$ always, a strengthening the lemma did not claim, and one reviewer's general formula reproduces $t_{333}=\tfrac{178}{32509}$ at $n=12$ by a route that does not read the record.* **And the kernel account is incomplete as stated**: at $n=8$ the $\{1,3,3\}$ term is zero and the witness still reaches $\tfrac{\sqrt{21}}2$, while the supply is linear in $m_3$ and needs $2n-16\le2m_3$, so *"merely $\ge3$"* is refuted.

**Statement.** At $n=12$, the spectrum with distinct values $\nu=(-a,\tfrac43a,0)$ and multiplicities $(4,3,59)$, where $a=\sqrt{3/28}$, admits a totally symmetric hollow $T\ge0$ satisfying relations (A), (B), (C) at every row and the pair cap at every pair, with

$$\theta=7a=\frac{\sqrt{21}}2=2.2912878\ldots\;>\;\theta_0(12)=\frac{\sqrt{220}}{12}.$$

**Hence no bound proved from (A), (B), (C), the pair cap, positivity and admissible support alone can close Conjecture A over all unit Weyl operators**, and every spectral item must be kernel-free or carry a relation that is non-vacuous on zero rows.

> **THE INGREDIENT LIST AND THE WORD "SUPPORT" BOTH NEEDED PINNING.** *The pair cap is used and was not listed; and "support" is read here in the **admissibility** sense (which types exist at the given multiplicities), not as a constraint on where $T$ is nonzero.* **Under the other reading the record's own next sentence contradicts the conclusion**, which is why the sense is now written down.

> **AND THE WITNESS IS PROVABLY NOT REALIZABLE, WHICH FORECLOSES THE ALARMING READING.** *The three tight class-averaged caps force all $21$ individual pairs among the seven $\nu_1/\nu_2$-eigenvectors tight; [Lemma L31](stratum-two-negative.md)'s equality case then gives each rank $4$ with a **common** image $V$, and seven orthonormal elements cannot live in $\mathfrak{so}(V)$, which has dimension $6$.* **So this is the redirect, not a counterexample to Conjecture A**: of the four outcomes [bounds.md](bounds.md) distinguishes for a relaxation witness, L173 is (ii) and (iv) is foreclosed. *A model refutes an implication whether or not it is realized, so the conclusion is untouched and sharpened, the lemma needs only soundness of the relaxation, never realizability of the witness.*

> **AND $\tfrac{\sqrt{21}}2$ IS THE EXACT MAXIMUM AT THIS SPECTRUM, NOT MERELY A FEASIBLE VALUE.** *(C$_1$) with the $(1,1)$ cap and $T\ge0$ alone give $\theta/a\le7-11t_{111}-236t_{113}-\tfrac{16}3t_{122}$, and row 2 returns $\le7$ independently*, **with (A) and (B) never invoked**, and the support pattern forced by the equality case.

> **THE TWO PLACES IT IS FRAGILE, RANKED.** *First the **ordered-pair** reading of (A): $2(n-2)=20$, and the unordered reading breaks every row.* **Second [L31](stratum-two-negative.md)'s cap constant $2$**, three caps sit exactly on it, and at a cap $c$ the ceiling reads $\theta/a\le4c-1$, so $c=1$ would put $\theta$ below $\theta_0(12)$ and the lemma would fail outright. *Both are inputs this block takes from elsewhere.*

**The parameters are forced.** $4+3+59=66=\binom{12}2$; tracelessness $-4a+3b=0$ gives $b=\tfrac43a$; unit norm $4a^2+3b^2=\tfrac{28}3a^2=1$ gives $a=\sqrt{3/28}$. Every $m_i\ge3$, so all $\binom{d+2}3=10$ value types of [Lemma L104](#lemma-l104-the-value-type-reduction) are admissible.

**The witness, in closed form.** Writing $t_{ijk}$ for the value-type variables,

$$t_{112}=\tfrac23,\qquad t_{222}=2,\qquad t_{133}=t_{233}=\tfrac4{1711},\qquad t_{333}=\tfrac{178}{32509},$$

with the remaining six zero. **All nine relations hold as exact rational identities** once $\nu$ is written as $a\cdot(-1,\tfrac43,0)$, which makes (B) rational and (C) rational in $\theta/a$. *Row 3's (B) and (C) both read $0=0$ because $\nu_3=0$; row 2's (B) closes because $174b=232a$ exactly.*

**Three pair caps are tight and three are slack**: $(1,1)$, $(1,2)$ and $(2,2)$ all equal $2$, while $(1,3)$ and $(2,3)$ read $\tfrac8{59}$ and $(3,3)$ reads $\tfrac{562}{1711}$. *The cap is what pins the witness, without it $t_{112}$ runs to $0.8985$ and $\theta$ to $3.2020$; the cap $(1,2)$ forces $t_{112}=\tfrac23$, and $\theta=9bt_{112}-a=6b-a=7a$.* $\square$

> **THE MECHANISM IS ONE COEFFICIENT.** *The type $\{1,3,3\}$ enters (A$_1$) with weight $\mu_3(\mu_3-1)=59\cdot58=3422$ against a right-hand side of $2(n-2)=20$, while $\nu_3=0$ removes it from (B$_1$) and (C$_1$) entirely.* **So a zero class of multiplicity $\ge3$ absorbs the row mass at negligible cost and pays nothing in the two relations that carry $\theta$.** It is why the same overshoot appears at $n=6$ with eight near-zero eigenvalues.

> **AND $\theta$ HAS A CLOSED FORM THE RECORD CARRIED AS A DECIMAL.** *$7a=7\sqrt{3/28}=\sqrt{147/28}=\sqrt{21}/2$, so the recorded $2.2913$ is that rounded.* **The ratio to the target is $\tfrac{\sqrt{21}}2\big/\theta_0(12)=1.8537\ldots$**, which is the size of the gap a kernel opens in the pinned class.


#### Lemma L241, off L173's ray the capped three-value class system still reaches above $\sqrt{3/2}$, with an exact witness

*Gate 2 by [r1124](../reviews/REVIEW_r1124.md), one reviewer on a witness check: items 1 to 5 CONFIRMED, scope and labelling PLAUSIBLE and repaired below, the witness moved off the $G_{02}\le m_0m_2$ boundary. Typed in [L241OffRayWitness.lean](../lean/HamiltonsCubic/Results/L241OffRayWitness.lean); verified in exact rational arithmetic by [verify_I73c_offray_witness.py](../scripts/misc/verify_I73c_offray_witness.py).*

**Statement.** At $n=12$, the three-value spectrum $e=(-\tfrac15,0,\tfrac15)$ with multiplicities $(7,52,7)$, so $\theta=5/\sqrt{14}\approx1.336>\sqrt{3/2}$, carries the class values $\tau_{002}=42$, $\tau_{011}=28$, $\tau_{012}=14$, $\tau_{111}=928$, $\tau_{122}=28$, $\tau_{222}=14$ (the other four zero) and the isotropy parameter $G_{12}=77$, which satisfy, in exact rational arithmetic, the per-index rows (A), (B), (C), $\tau\ge0$, the pair caps, the Ky Fan caps of [L237](second-order.md), the seven-frame cap of [L240](second-order.md) for every composition $(k_0,k_1,k_2)$, the Gram constraints, section 5's per-pair inequalities of [the summed-pair note](../reviews/2026-09-23-I73c-summed-pairs.md) and [L235](second-order.md)'s window. **Hence no argument using only the class-level system of [I73](../plan.md)'s sub-step (c), with every class-level constraint the record holds, excludes a three-value spectrum above $\sqrt{3/2}$ at $n=12$.**

**The numbers.** $\sum_am_ae_a^2=\tfrac{14}{25}=\theta^{-2}$ and $\tfrac{25}{14}>\tfrac32$. The per-pair bracket sums are $P_{00}=P_{22}=1$, $P_{02}=\tfrac87$, $P_{01}=P_{12}=\tfrac3{26}$, $P_{11}=\tfrac{239}{663}$, so every pair cap and every Ky Fan cap holds with room, $R\cdot\tfrac87\le\kappa_R$ for $2\le R\le6$. **The largest seven-frame class total is $\tfrac{318}7\approx45.43$**, at the compositions $(4,0,3)$ and $(3,0,4)$, against L240's $54.064$. The Gram from section 3 of the note is $G=\begin{pmatrix}\tfrac{77}2&77&\tfrac{77}2\\77&990&77\\\tfrac{77}2&77&\tfrac{77}2\end{pmatrix}$, positive semidefinite with $G_{aa}\ge\tfrac12\tau_{aa}$. **Rows $0$ and $2$ agree at every $G_{12}$**: $\mathop{\mathrm{Ric}}(e)=\sum_be_bA_b=0$ at a symmetric spectrum gives $A_0=A_2$, so Cauchy–Schwarz for $(0,2)$ is an equality, forced rather than chosen. *$G_{12}$ ranges over $[56,98]$ at this point, and $77$ keeps it off the endpoint $G_{02}=m_0m_2$, which [r1124](../reviews/REVIEW_r1124.md) shows no pair of orthogonal seven-dimensional eigenspaces of $\Lambda^2\mathbb R^{12}$ can realise.* Section 5 holds already at $\mathring\mu=1$, which is below the proved cap $\sqrt{3080}/55$, and its $\mathring\mu$ coefficient multiplies $G_{ab}-\tfrac12\tau_{ab}\ge0$. The window holds, checked in exact arithmetic by the script.

**Where it sits.** *[Post F76](fence-posts.md) recorded that a successor to the class-level test needs an ingredient [L173](#lemma-l173-the-pinned-class-cannot-bound-theta-once-a-kernel-is-allowed-and-the-witness-is-exact)'s witness violates, and named the seven-frame cap as one; L240 supplied it and it closes L173's ray.* **This witness is off the ray**: the spectrum is symmetric, so $\mathop{\mathrm{tr}}e^3=0$ and $\theta=\langle W,W^\#\rangle$ at unit $W$. At this spectrum the system has an exact point at $T_7=46$ as well, and a floating-point screen finds it infeasible at $T_7\le45$ ([verify_I73c_offray_witness.py](../scripts/misc/verify_I73c_offray_witness.py) with its $T_7$ argument; [r1124](../reviews/REVIEW_r1124.md) reproduced it), so a sharper seven-frame bound excludes this spectrum. *Whether any seven-frame constant closes the system is screened only*: with $T_7\le42$, the value the octonion frames attain, $190$ of the $2080$ triples at $n=12$ have a feasible direction at $\theta=1.2248$, on five directions per triple and without section 5.

**Scope.** *A point of the relaxation, not a Weyl tensor*: nothing here says a critical point with this spectrum exists, and the non-linear ingredients (L31's common image, realisability of the class values) are not tested. **At $n=12$ the live threshold is $\theta_0(12)=\sqrt{220}/12\approx1.23603$, not $\sqrt{3/2}$** ([trap W7](INDEX-traps.md): $S^5\times S^7$ is a three-value critical point at $1.228239$), and this point's $\theta\approx1.336$ clears it. *A bounded screen over all $2080$ multiplicity triples, five directions each, finds $190$ with a feasible direction at $\theta=1.2361$ with every constraint on file, [L243](second-order.md) included* ([screen_I73c_capped_offray.py](../scripts/misc/screen_I73c_capped_offray.py), `THETA=1.2361`); *the earlier counts, taken at $1.2248$ below $S^5\times S^7$'s value, are superseded.*


#### Lemma L242, the capped three-value class system reaches above $\sqrt{3/2}$ under every valid seven-frame cap

*Gate 2 by [r1125](../reviews/REVIEW_r1125.md), one reviewer: exactness, section 5 and the octonion value CONFIRMED; realisability REFUTED, which is recorded below as what the point teaches; scope PLAUSIBLE and repaired. Typed in [L242OffRayWitness.lean](../lean/HamiltonsCubic/Results/L242OffRayWitness.lean); verified in exact rational arithmetic by [verify_I73c_offray_witness.py](../scripts/misc/verify_I73c_offray_witness.py) with arguments `120 42 12,42,12 -3/20,0,3/20`.*

**Statement.** At $n=12$, the three-value spectrum $e=(-\tfrac3{20},0,\tfrac3{20})$ with multiplicities $(12,42,12)$, so $\theta^2=\tfrac{50}{27}$ and $\theta\approx1.361>\sqrt{3/2}$, carries the class values $\tau_{002}=104$, $\tau_{011}=8$, $\tau_{022}=24$, $\tau_{111}=808$, $\tau_{112}=8$, $\tau_{222}=80$ (the other four zero) and $G_{12}=120$, which satisfy, in exact rational arithmetic, every class-level constraint [L241](#lemma-l241-off-l173s-ray-the-capped-three-value-class-system-still-reaches-above-sqrt32-with-an-exact-witness) lists, **with every seven-frame class total at most $\tfrac{1172}{33}\approx35.5<42$**. *Orthonormal seven-frames attain $42$ (the octonion left multiplications, section 10 of [the summed-pair note](../reviews/2026-09-23-I73c-summed-pairs.md)), so no valid seven-frame cap is below $42$.* **Hence no sharpening of [L240](second-order.md), down to the best possible constant, lets the class-level system of [I73](../plan.md)'s (c) exclude a three-value spectrum above $\sqrt{3/2}$ at $n=12$.**

**The numbers.** $P_{00}=P_{22}=\tfrac{26}{33}$, $P_{02}=\tfrac89$, $P_{01}=P_{12}=\tfrac1{63}$, $P_{11}=\tfrac{412}{861}$; every Ky Fan cap holds since $R\cdot\tfrac89\le\kappa_R$. $G=\begin{pmatrix}72&120&72\\120&684&120\\72&120&72\end{pmatrix}$, rows $0$ and $2$ equal as $\mathop{\mathrm{Ric}}(e)=0$ forces at a symmetric spectrum, with no other Gram constraint tight. Section 5 is checked at $\mathring\mu=\tfrac{99}{100}$, below the proved cap $\sqrt{5940/6050}$, and is looser at the cap. The window holds, $I_1=-\tfrac{5901}{250}$.

**No eigenspace decomposition realises this point** ([r1125](../reviews/REVIEW_r1125.md), reproduced here by a separate argument). $\tau_{001}=\tau_{012}=\tau_{122}=0$ say $\langle[V_a,V_b],V_1\rangle=0$ for $a,b\in\{0,2\}$, so $V=V_0\oplus V_2$ is a $24$-dimensional subalgebra of $\mathfrak{so}(12)$, and its internal bracket mass is $\tau_{000}+3\tau_{002}+3\tau_{022}+\tau_{222}=464$ of the $24\cdot2(n-2)=480$ its elements carry. *By Dynkin indices a $24$-dimensional subalgebra of $\mathfrak{so}(12)$ keeps at most $240$ inside ($\mathfrak{su}(5)$ attains it); independently, the $16$ left over would make the $42$-dimensional complement an almost trivial module, while only the centraliser, of dimension at most about $6$, acts trivially.* **So the class-level statement stands and the point is not a configuration.** *What kills it is an ingredient the class system lacks: a cap on the bracket mass a $k$-dimensional subspace holds, linear in the class values, of which the seven-frame cap is the case $k=7$.*

**Scope.** A point of the relaxation, provably not realisable. *The bisected ceilings (about $1.43$ at $(12,42,12)$, about $1.24$ to $1.27$ at $(8,55,3)$ and $(20,42,4)$) are lower bounds from each triple's five sampled directions, at three of the $190$ survivors, and say nothing about the rest.*


#### Lemma L175, no Schur-convexity argument ON THE SPECTRUM reaches $\theta$

*Attempted 2026-09-07 as [I17](../plan.md) and **the general form was REFUTED at Gate 2 by [r767](../reviews/REVIEW_r767.md) and [r768](../reviews/REVIEW_r768.md)**, both breaking it on the same objection. What stands is the scoped claim, which is the one [plan-spectral](../reviews/plan-spectral.md) wrote and this block dropped.*

> **THE SCOPE WAS LOST IN TRANSCRIPTION, AND THAT IS THE RULE THIS RECORD PROMOTED THE SAME DAY.** *The source reads "no Schur-convexity argument **on the spectrum** reaches $\theta$"; the block, [INDEX-results.md](INDEX-results.md)'s row and the machine-checked file all dropped three words.* **The narrow claim is provable and the general one is false.**

**Statement.** $\theta$ is invisible to the spectrum $S$, the reason is [r649](../reviews/REVIEW_r649.md)'s, so no Schur-convexity argument **on the spectrum** reaches it. *In [Lemma L104](#lemma-l104-the-value-type-reduction)'s reduced system $\theta$ occurs in (C) and nowhere else, which both audits confirmed; that observation is true and is not the fence.*

> **WHY THE GENERAL FENCE IS FALSE, WHICH IS THE USEFUL PART.** *(C) is solvable for $\theta$: writing the three rows as one nonnegative measure and three moments gives $\theta=g_i(T)$ with $g_i$ **linear and $\theta$-free**.* **So a bound over the (A),(B)-feasible set of $g_i$ bounds $\theta$**, finite from (A) and $T\ge0$ alone, giving $\theta\le(n-1)\nu_{\max}$ in closed form. *The record's own $\Pi$-bound is the concrete counterexample: every inequality step in it is convexity on the (A),(B) marginals, with (C) entering once only to name what the expectation is.* **And [L104](#lemma-l104-the-value-type-reduction) proves $\Pi(\lambda)$ empty at $d=2$ from (A) and (B) alone, emptiness being the strongest $\theta$-bound there is.**

> **THE REFUTATION IS CONSTRUCTIVE, AND ITS EXHIBIT IS A BOUND.** *Taking (C) against (A) with the termwise AM–GM $\nu_q\nu_r\le V$, $V=\max_q\nu_q^2$, gives $\theta\le\nu_i+(n-2)V/\nu_i$ for each $i$ with $\nu_i>0$, the same algebra bounding $\theta$ from below at $\nu_i<0$*, **an explicit $\theta$-bound whose only inputs besides (C) are (A) and $T\ge0$** (kernel-checked as `theta_le` in [L175Bound.lean](../lean/HamiltonsCubic/Results/L175Bound.lean)), which is precisely what the fence says cannot exist. *At [L173](#lemma-l173-the-pinned-class-cannot-bound-theta-once-a-kernel-is-allowed-and-the-witness-is-exact)'s witness it returns $22\sqrt{21}/21\approx4.80$ against that lemma's own $\tfrac{\sqrt{21}}2$: **slack rather than competitive**, so the fence fails on existence while the record's sharper bounds keep their standing.*

> **THE CORRECT GENERAL FENCE IS ALREADY ON FILE, WITH A REASON THIS BLOCK DID NOT USE.** *[Lemma L73](bounds.md)'s block fences the spectral route on the ground that **(C) holds at critical points only**, so a relaxation carrying (C) has already assumed criticality and one dropping it has lost $\theta$.* **That is a statement about the hypothesis (C) needs, rather than about which variables it mentions**, and it survives (C) being solvable. *[L104](#lemma-l104-the-value-type-reduction)'s own compactness argument sits three sections above this one and is built from (A) and (B), which is the same lesson at a different address.*

> **AND (C) IS A MARGINAL TOO.** *The block claimed convexity arguments consume "the marginals, and the marginals are (A) and (B)".* **(C) is the second-moment marginal of the same rows**, so the claimed division of labour does not exist. *That the toolbox's objects are built from (A) and (B) alone remains **hypothesis-debt**: no argument is on file and none was sketched.*

> **WHAT SURVIVES INTACT.** *The majorisation half of [I17](../plan.md), that the subset-sum family is exactly $-\lambda/(n-2)\prec\lambda$, implied by the pinned LP at every fixed spectrum, with $\lvert A\rvert=1$ being [Lemma L73](bounds.md) in both directions, is a **recognition**, independent of the fence, and both audits confirmed it stands.*

---

## Working notes carried by the plan

*These were accumulated inside [plan.md](../plan.md)'s items, where a task list had grown into a second copy of the record. They are working notes rather than results: where one disagrees with a numbered block above, the block is the record.*

### From [I13](../plan.md)

**Where it stands.** [Lemma L104](bounds-relaxations.md) reduces the pinned class at a fixed spectrum to ten variables, feasible dimension $4$, and $\theta$ is not forced. The hypothesis-free support bound is $210\to194$. **The per-row multiplier route is closed**: [post F43](INDEX-traps.md) by the $n=12$, $(30,20,16)$ witness, and [post F45](INDEX-traps.md) by a union bound leaving at least $129$ of $210$ supports alive against the full $27$-identity apparatus. *The complete per-row condition is $R_i\in\mathop{\mathrm{conv}}(\text{used points})$, which [post F43](INDEX-traps.md) already covers.*

**What is owed, and it is one thing.** A constraint that is **cross-row**. The blocked alternative is [I13a](../plan.md#blocked). **Live sub-step**: the pair cap $\sum_cT_{abc}\le2$ is a per-row constraint of no multiplier form ([conventions.md](conventions.md)), ask what its cross-row analogue is, since it is the one recorded constraint the calculus does not generate.

**Searched** (inherited from I24): no realizability criterion for Weyl spectra exists in print for $n\ge5$ ([LIT-spectra](../reviews/LIT-spectra.md)); [Payne](../references/payne-2010-soliton-metrics/notes.md) covers the squares but not per-row moment ranges; and the hull condition is **moment-map convexity** ([Lauret–Will](../references/lauret-will-2006-einstein-solvmanifolds-moment-map/notes.md) Prop 3.2(i)) with Payne's linear system as its closest-point condition (Prop 3.3), *the group action whose moment map is the per-row system remains owed before that frame transfers as a theorem.*

