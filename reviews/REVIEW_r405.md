# Review r405, Gate 2 on the I7 spectral-gap opening and what the gap would buy

*Adversarial review of the last two sections of [ATTEMPTS.md](../ATTEMPTS.md), 2026-09-03, run cold. The normalisation was re-derived from [conventions.md](../findings/conventions.md) and from the record's own `normalize()` before the sections were opened; the trace of the criticality equation was taken by hand before any file was consulted. Analysis only, inherited: every figure below is exact evaluation at four named critical points that this review constructed for the purpose, reported as a **screen**, and each verdict also carries a one-line proof that needs no run at all.*

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1 | $W^2-\theta W=-W^\#$, hence $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$ on eigenvectors | **CORRECT** as algebra (screened to $10^{-16}$ at five points), **and it is ON RECORD three times**, as relation (C) of [bounds.md](../findings/bounds.md), as $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$, and as $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$ in [stratum-two-negative.md](../findings/stratum-two-negative.md). **[Route R14](../routes.md) is CLOSED on exactly this identity.** The novelty claim is withdrawn |
| 2 | $\theta\operatorname{tr}W=1$ at every critical point | **REFUTED.** $\operatorname{tr}W=0$ for every Weyl operator, so $\theta\operatorname{tr}W=0$. Screened at $S^3\times S^3$, $S^4\times S^4$, $S^2\times S^4$, $S^6\times S^6$ and padded $W_{\mathbb{CP}^2}$: $\theta\operatorname{tr}W\le2\times10^{-15}$ everywhere. The error is a factor-$2$ collision, $\sum\lambda^2=2$ against $\operatorname{tr}W^\#=-1$, **the exact trap [conventions.md](../findings/conventions.md) names by name** |
| 3 | conditional on $\operatorname{spec}(W)\cap(0,\theta)=\varnothing$: $p\theta^2\le2$, $p=1$, $W=\lambda_1vv^{\mathsf T}-K$ | **REFUTED, and the hypothesis is IMPOSSIBLE.** $\sum\lambda^2=1$, so the count reads $p\le1/\theta^2\le\tfrac23$, giving $p=0$, and $p=0$ with $\operatorname{tr}W=0$ forces $W=0$. Unconditionally: $\lambda_{\max}\in(0,1)$ and $\theta>1$ in the band, so $\operatorname{spec}(W)\cap(0,\theta)\ne\varnothing$ at **every** unit Weyl operator in the band. Screened: $30$ of $66$ eigenvalues of $S^6\times S^6$ lie in $(0,\theta)$ |
| 4 | $\lambda_1\ge1/\theta$, $\lambda_1\le\sqrt2$, so the gap yields only $\theta\le\sqrt2$ | **REFUTED in both halves.** $\lambda_1\ge1/\theta$ falls with claim 2; $\lambda_1\le\sqrt2$ is $\lambda_1<1$ in the record's normalisation. Nothing follows from a contradictory hypothesis, $\sqrt2$ included |
| 5 | first handle on I7; gap necessary and not sufficient; the residue is the distance between the two competitors | **REFUTED.** Not first (R14 is the same identity, closed); not necessary (it is false in the band); and $\sqrt2$ is **not a competitor**, it is $\lim_n\theta_0(n)$, attained at no $n$, with $\theta_0(12)=1.236033>\sqrt{3/2}$ already |

**The one thing that survives, and it is worth keeping.** The rearrangement $W^\#=\theta W-W^2$ *is* the right way to read criticality on the $\Lambda^2$ spectrum, and it says something sharp, but the sign it gives is the opposite of the one the section wants: $\langle v,W^\#v\rangle>0$ on **every** positive eigendirection of every in-band critical point, and the record's own $\#$-positivity calculus therefore cannot deliver the gap. *The section's boxed equivalence is the proof that its own programme is empty.*

## §0 The normalisation, settled before anything else, because both refutations are it

**The record works at $\lVert W\rVert_F=1$ on the pair matrix, so $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$.** [conventions.md](../findings/conventions.md) states it: *"The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level. The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix."* The $\tfrac12$ makes the pair bivectors $\varphi_{ij}$ orthonormal; operators expressed in that orthonormal basis are then paired plainly. Four independent confirmations, none of them the sentence:

- **The record's own code.** [review_r30_core.py](../scripts/lib/review_r30_core.py)'s `normalize` divides by $\sqrt{\langle W,W\rangle_F}$, and [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py) computes $\theta$ as `tensordot(W, Q(W))`, plain Frobenius at both ends.
- **The catalogued values come out only in that convention.** $\theta(S^3\times S^3)=1.054092553389=\theta_0(6)=\sqrt{10}/3$ and $\theta(S^6\times S^6)=1.236033081183=\theta_0(12)$ exactly, with $\operatorname{tr}(W^2)=1$.
- **[b_apriori_bound.py](../scripts/lib/b_apriori_bound.py) quotes $\lVert\lambda\rVert_4^2=0.7071$ at padded $W_{\mathbb{CP}^2}$**, which holds for the spectrum $(0.816497;-0.408248^{\times2})$ at $\sum\lambda^2=1$ and for no rescaling of it.
- **$\operatorname{tr}(W^\#)=-1$ itself.** [target.md](../findings/target.md) proves $\operatorname{tr}(W^\#)=-\lVert W\rVert^2$ from $W\# I=-W$; screened here as $-1.000000000000$ at every point, alongside $\operatorname{tr}(W^2)=+1.000000000000$.

> **AND CONVENTIONS.MD NAMES THIS FAILURE IN ADVANCE.** *"Applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$, and has cost a cycle."* The section's $\sum_\alpha\lambda_\alpha^2=2\lVert W\rVert^2=2$ is that operator-level $\tfrac12$ exactly. **It then multiplies the resulting $2$ against $\operatorname{tr}W^\#=-1$, which is quoted from a file working in the other convention**, and the $-1$ and the $2$ are the same quantity read twice, once with the factor and once without. Every downstream number in both sections is that collision.

## §1 Claim 1, correct, and closed

**The algebra.** $Q(W)=\theta W$ gives $W^\#=\theta W-W^2$; applied to a unit eigenvector $Wv=\lambda v$, $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$. **No factor of $2$ enters**, and the reason is structural rather than lucky: it is a Rayleigh quotient, so rescaling the metric on $\Lambda^2$ scales numerator and denominator alike, and $\lambda$, $\theta$ and the sign of $\langle v,W^\#v\rangle$ are all metric-independent. *The identity is the one statement in these two sections that does not depend on §0.* Screened: $\max_\alpha\lvert\langle v_\alpha,W^\#v_\alpha\rangle-\lambda_\alpha(\theta-\lambda_\alpha)\rvert\le10^{-15}$ at $S^3\times S^3$, $S^4\times S^4$, $S^2\times S^4$ and padded $W_{\mathbb{CP}^2}$ at $n=6,8$.

**It is on the record, three times, and the section's screen missed all three.**

| where | the statement |
| --- | --- |
| [bounds.md](../findings/bounds.md), relation **(C)** | $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$, *this is claim 1 for every index $k$*, since $\langle\varphi_k,W^\#\varphi_k\rangle=\tfrac12\sum\lambda_\beta\lambda_\gamma c_{k\beta\gamma}^2$ |
| [bounds.md](../findings/bounds.md), the R14 box | *"At a critical point $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$ for $v\in E_{\min}$"* |
| [stratum-two-negative.md](../findings/stratum-two-negative.md) | *"the three non-kernel rows of $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$"* |

**And [plan.md](../plan.md) opens with it.** *"The three per-index relations on $T_{abc}=c_{abc}^2$ are COMPLETE, no fourth exists. (A) Killing row mass, (B) the per-row identity, (C) criticality. That is the session's durable structural result."* Claim 1 **is** (C).

> **[ROUTE R14](../routes.md) IS CLOSED ON THIS IDENTITY, AND ITS SUCCESSOR RULE IS THE ONE THIS SECTION BROKE.** R14 read the same relation as a reduction and died because *"$D$ is a function of $(\theta,\lambda_{\min},\lambda_{\max})$ and carries no bracket information at all"* ([Reviewer 323](REVIEW_r323.md)). The register's clearance requirement is: **"eliminate before reducing. Substitute criticality into any proposed new quantity and check what free variables survive, one line, and it closes this route before the cycle starts."** Applied here: $\langle v,W^\#v\rangle$ substituted from criticality is a function of $(\lambda,\theta)$ alone, so the boxed equivalence *"$\lambda\in(0,\theta)\iff\langle v,W^\#v\rangle>0$"* has no content beyond $\lambda\in(0,\theta)\iff\lambda(\theta-\lambda)>0$. **It is a restatement of the arithmetic of a downward parabola, not a $\#$-positivity question.**

**And the "right generalisation" reading is a category error [conventions.md](../findings/conventions.md) also flags.** [Lemma L129](../findings/diagonal-half.md) is a statement about $K$, the **$n\times n$ hollow sectional matrix** $K_{ab}=W_{abab}$ with $\lVert K\rVert_F^2=t\le2$, not about $W$ on $\Lambda^2$. *"'Diagonal' means diagonal in coordinate $2$-planes, not diagonal as an operator on $\Lambda^2\mathbb R^n$."* The two objects have different spectra, different traces and different norms, and **the $2$ in the section's $\sum\lambda^2=2$ is $L129$'s $t\le2$, transplanted onto an operator whose norm is $1$.** That is the provenance of the error, and it is why "the same rearrangement holds verbatim" is false: what holds verbatim is $W^\#=\theta W-W^2$, which is trivial; what L129 needs is that the right side is a **Laplacian with nonnegative weights**, and $W^\#$ is not one.

## §2 Claim 2, refuted, at every named critical point

**One line kills it: $\operatorname{tr}W=0$.** A Weyl operator is totally trace-free, so $\operatorname{tr}_{\Lambda^2}W=\sum_{i<j}W_{ijij}=\mathrm{scal}/2=0$. The record holds this explicitly, [ad-form-attempt.md](../findings/ad-form-attempt.md): *"$\operatorname{tr}$ is the ordinary trace ($=\mathrm{scal}/2$)"*; [bounds-relaxations.md](../findings/bounds-relaxations.md): *"a Weyl tensor is not 2-nonnegative, since $\operatorname{tr}W=0$ forces $\lambda_{\min}<0$"*, and *"the spectral form additionally needs $\operatorname{tr}W=0$"*. **So $\theta\operatorname{tr}W=0$, and $\operatorname{tr}W=1/\theta$ asserts $0=1/\theta$.**

**The correct trace of the criticality equation is $0=0$.** Taking the ordinary trace of $W^2+W^\#=\theta W$ gives $\operatorname{tr}(W^2)+\operatorname{tr}(W^\#)=\theta\operatorname{tr}W$, i.e. $1+(-1)=0$. *Both sides vanish, and the identity is vacuous.* Indeed $\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$ is forced, with no convention input at all: $\operatorname{tr}(W^\#)$ is an $O(n)$-invariant quadratic form on the irreducible $\mathcal W_n$, hence a multiple of $\operatorname{tr}(W^2)$, and the trace of criticality at any one critical point fixes the multiple at $-1$. **So $\operatorname{tr}W^\#=-\lVert W\rVert^2$ and $\sum\lambda^2=\lVert W\rVert^2$ are the same normalisation, and no consistent reading produces a nonzero right-hand side.**

**The screen, at four critical points and the target's own attaining point**, objects constructed here from [review_r30_core.py](../scripts/lib/review_r30_core.py) and [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py), with $\#$ from the independent [r125_lib.py](../scripts/reviewers/r125_lib.py) (two implementations agreeing to $10^{-17}$), criticality residual $\le1.5\times10^{-15}$ throughout:

| point | $n$ | $\theta$ | $\operatorname{tr}W$ | $\operatorname{tr}W^2$ | $\operatorname{tr}W^\#$ | $\theta\operatorname{tr}W$ |
| --- | --- | --- | --- | --- | --- | --- |
| $S^3\times S^3$ | $6$ | $1.054092553389$ | $-1.2\times10^{-16}$ | $1.000000000000$ | $-1.000000000000$ | $-1.2\times10^{-16}$ |
| $S^4\times S^4$ | $8$ | $1.145643923739$ | $+7\times10^{-17}$ | $1.000000000000$ | $-1.000000000000$ | $+6.4\times10^{-17}$ |
| $S^2\times S^4$ | $6$ | $0.968245836552$ | $-2\times10^{-16}$ | $1.000000000000$ | $-1.000000000000$ | $-2.2\times10^{-16}$ |
| $S^6\times S^6$ | $12$ | $1.236033081183$ | $\approx0$ | $1.000000000000$ | $-1.000000000000$ | $\approx0$ |
| padded $W_{\mathbb{CP}^2}$ | $6$ | $1.224744871392$ | $+5.3\times10^{-16}$ | $1.000000000000$ | $-1.000000000000$ | $+6.5\times10^{-16}$ |
| padded $W_{\mathbb{CP}^2}$ | $8$ | $1.224744871392$ | $+1.7\times10^{-15}$ | $1.000000000000$ | $-1.000000000000$ | $+2.1\times10^{-15}$ |

**Claim 2 asserts $1$ in the last column. The measured value is zero to machine precision at every point, the two the section names included.** *And "in particular $\operatorname{tr}W>0$, so $W$ has a positive eigenvalue at every critical point" is a true conclusion reached from a false premise: $W$ does have a positive eigenvalue, because $\operatorname{tr}W=0$ and $W\ne0$.*

## §3 Claim 3, the hypothesis is not open, it is contradictory

**The count, redone.** With $\sum_\alpha\lambda_\alpha^2=1$ and $p=\#\{\alpha:\lambda_\alpha\ge\theta\}$, the section's own argument gives $p\theta^2\le1$, so in the band $\theta^2\ge\tfrac32$ forces $p\le\tfrac23$, i.e. **$p=0$**. *The section's $p=1$ needs the phantom $2$; with the record's normalisation the same inequality deletes the rank-one direction it was invoked to produce.*

**And $p=0$ is fatal to the hypothesis, not to the structure.** $p=0$ plus $\operatorname{spec}(W)\cap(0,\theta)=\varnothing$ puts every eigenvalue in $(-\infty,0]$; with $\operatorname{tr}W=0$ that forces $\lambda\equiv0$, i.e. $W=0$, against $\lVert W\rVert=1$.

> **SO THE GAP IS FALSE IN THE BAND, AND THE PROOF NEEDS NEITHER CRITICALITY NOR THE BAND'S SHARP CONSTANT.** For any $W\in\mathcal W_n$ with $\lVert W\rVert=1$: $\sum\lambda^2=1$ gives $\lambda_{\max}\le1$, and $\operatorname{tr}W=0$ with $W\ne0$ gives $\lambda_{\max}>0$ and rules out $\lambda_{\max}=1$. **Hence $\lambda_{\max}\in(0,1)$, and $\theta>1$ implies $\operatorname{spec}(W)\cap(0,\theta)\ne\varnothing$.** Every point of the band has $\theta\ge\sqrt{3/2}>1$. $\square$

**Screened at the record's own points, where the failure is not marginal but total:**

| point | $\theta$ | $\operatorname{spec}(W)$ with multiplicity | in $(0,\theta)$ | $p=\#\{\lambda\ge\theta\}$ |
| --- | --- | --- | --- | --- |
| $S^3\times S^3$ | $1.054093$ | $-0.21081851^{\times9}$, $+0.31622777^{\times6}$ | **$6$ of $15$** | $0$ |
| $S^6\times S^6$ | $1.236033$ | $-0.11236664^{\times36}$, $+0.13483997^{\times30}$ | **$30$ of $66$** | $0$ |
| padded $W_{\mathbb{CP}^2}$, $n=6$ | $1.224745$ | $-0.40824829^{\times2}$, $0^{\times12}$, $+0.81649658^{\times1}$ | **$1$ of $15$** | $0$ |
| padded $W_{\mathbb{CP}^2}$, $n=8$ | $1.224745$ | $-0.40824829^{\times2}$, $0^{\times25}$, $+0.81649658^{\times1}$ | **$1$ of $28$** | $0$ |

*$S^6\times S^6$ is in the band ($1.236033>\sqrt{3/2}$) and is the record's own conjectured maximiser; padded $W_{\mathbb{CP}^2}$ is the point the live target is attained at. **Every positive eigenvalue of every one of them lies in $(0,\theta)$, and none of them has a single eigenvalue $\ge\theta$.*** The one true reading of "$\lambda_{\max}$ is far below $\theta$" is the opposite of the section's: $\lambda_{\max}\le1<\theta$ is **automatic** in the band, so $p=0$ always and the "rank-one-minus-PSD" conclusion never arises from this count.

**The conclusion is separately false as a description.** $W=\lambda_1vv^{\mathsf T}-K$ with one positive direction holds at padded $W_{\mathbb{CP}^2}$ (one eigenvalue $+0.816$) and **fails at $S^3\times S^3$ and $S^6\times S^6$**, which carry $6$ and $30$ positive eigenvalues. *So the structure the section says the gap "would deliver" is not a property of in-band critical points at all.*

## §4 Claim 4, nothing follows, and the two bounds are separately wrong

- **$\lambda_1\ge1/\theta$** rests on $\operatorname{tr}W=1/\theta$ and falls with claim 2. The true statement is $\sum_\alpha\lambda_\alpha=0$, which bounds $\lambda_1$ **below** by nothing and is what makes $\lambda_{\min}<0$.
- **$\lambda_1\le\sqrt2$** is $\lambda_1\le\lVert W\rVert=1$, strictly $\lambda_1<1$. Measured: $0.316$, $0.135$, $0.816$ at the three points above, the largest, at padded $W_{\mathbb{CP}^2}$, is $\sqrt{2/3}$.
- **"$\theta\ge1/\sqrt2$ comes free"** and **"$\theta\le\sqrt2$ is all the gap alone yields"** are both derived inside a hypothesis that has no models in the band. *From a contradiction one derives $\theta\le\sqrt2$, $\theta\le\sqrt{3/2}$ and $\theta\le0$ alike; the section's choice of the first is not a measurement of the method's strength.*

## §5 Claim 5, the framing

**"The first thing in the session to touch I7."** [I7](../plan.md) is *the value on the compact non-pure set*. What §1 shows is that the section's instrument is relation (C), which has been on the record since before this session and on which [R14](../routes.md) was opened and closed. **A closed route re-entered is not a first handle**, and the register's clearance note is the one-line test that would have caught it.

**"The gap is necessary and not sufficient."** It is neither. **Not necessary**: §3 proves it false at every unit Weyl operator with $\theta>1$, so no in-band critical point satisfies it. **Not sufficient**: vacuously so, there being nothing to be sufficient about.

**"The remaining $\sqrt2\to\sqrt{3/2}$ is exactly the gap between the two competitors."** [INDEX-values.md](../findings/INDEX-values.md) puts $\sqrt2=1.414214$ as *"limit of $\theta_0(n)$, $n\to\infty$"*, **a limit of the diagonal family, attained at no $n$ and by no competitor.** The two objects that are actually in play at fixed $n$ are $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}=1.224745$, which is *inside* the target, and the balanced sphere product at $\theta_0(n)<\sqrt2$, which is excluded by diagonality and **already exceeds $\sqrt{3/2}$ from $n=12$** ($\theta_0(12)=1.236033$). *So "closing the distance to $\sqrt{3/2}$" would have to exclude a point the conjecture's own maximiser sits above, which no bound on all of $\mathcal W_n$ can do, diagonality has to enter, exactly as [findings/INDEX.md](../findings/INDEX.md) says: "the load-bearing hypothesis is diagonality, not $S$. Any argument must carry it to the end."* The section's spectral count carries no diagonality anywhere.

## §6 What should be recorded

1. **A fence post, and it is the useful residue of the whole opening.** *At every $W\in\mathcal W_n$ with $\lVert W\rVert=1$ and $\theta>1$ (hence at every point of the band, critical or not), $\operatorname{spec}(W)\cap(0,\theta)\ne\varnothing$, because $\operatorname{tr}W=0$ forces $0<\lambda_{\max}<1<\theta$.* **So no generalisation of [Lemma L129](../findings/diagonal-half.md) to the $\Lambda^2$ operator can exist**, and the $\#$-positivity programme the section proposes (proving $\langle v,W^\#v\rangle\le0$ on eigenvectors), is closed on arrival: by claim 1's own identity, $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)>0$ on every positive eigendirection, of which there is always at least one.
2. **The normalisation trap gets a third entry.** [conventions.md](../findings/conventions.md) already carries the operator-level $\tfrac12$ and the [post F33](../findings/fence-posts.md)/[bispectral.md](../findings/bispectral.md) $p_2(\omega)$ mismatch. **Add: $\operatorname{tr}W^\#=-1$ and $\sum\lambda^2=1$ are the SAME normalisation; pairing the $-1$ with $\sum\lambda^2=2$ manufactures a trace out of nothing.** The tell is cheap and should be in the trap file: *any relation asserting $\operatorname{tr}W\ne0$ is wrong before it is read.*
3. **Both sections of [ATTEMPTS.md](../ATTEMPTS.md) should be marked withdrawn** rather than corrected. Nothing survives claim 1's demotion to relation (C) except the observation in item 1 above, which is a closure and not an opening.

*Screening disclosure, per [analysis-only.md](../.claude/rules/analysis-only.md): every figure in this review is exact evaluation, at objects constructed here, of quantities whose values are already determined by the closed forms above. No search, sweep or optimisation was run, and no positive claim rests on a run, each verdict is proved in the accompanying line.*
