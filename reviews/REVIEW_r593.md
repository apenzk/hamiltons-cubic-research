# Review r593, Lemma L109, the per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$

**Verdict: CONFIRMED as an inequality, the cap is true, the constant $2(n-2)$ and the exponent $2$ are right, and the derivation is valid. Four of the block's surrounding claims are defective**: the water-filling justification is a non sequitur whose premise is unconditionally true and therefore vacuous; the saturation claim is reported as a machine-precision measurement where the record already carries it as a theorem two files away; the excluded-index question the block leaves open is answered in closed form at [Lemma L107](../findings/bounds.md) and is provably **void at every saturating row**; and the quoted class ceiling is not merely stale but the withdrawn number. The conclusion *"it cannot close"* survives every reading.

Reviewer A of an independent pair. Analysis only: nothing below was computed. Every number is derived in closed form and cross-checked against two identities the record already carries.

---

## 1. The cap, re-derived from scratch, CONFIRMED

**Inputs, named.**

| input | statement | where it enters |
|---|---|---|
| [Petersen–Wink Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) | $g_\gamma:=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$, ordered pairs | the object being bounded |
| $T\ge0$ | $T_{\gamma\alpha\beta}=c_{\gamma\alpha\beta}^2$ ([conventions.md](../findings/conventions.md)) | licenses the termwise substitution to aggregate |
| the chord | $(\lambda_\alpha-\lambda_\beta)^2\le(\lambda_{\max}-\lambda_{\min})^2$ for every $\alpha,\beta$ | the substitution itself |
| the row marginal | $\rho_\gamma=\sum_{\alpha\beta}T_{\gamma\alpha\beta}=\sum_\alpha\lVert[v_\gamma,v_\alpha]\rVert^2=2(n-2)$ | the mass spent |

Three lines: $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\le(\lambda_{\max}-\lambda_{\min})^2\sum_{\alpha\beta}T_{\gamma\alpha\beta}=2(n-2)(\lambda_{\max}-\lambda_{\min})^2$.

**The marginal, confirmed twice.** $\mathrm{ad}(v_\gamma)$ is skew for the ad-invariant pairing, so $\sum_\alpha\lVert[v_\gamma,v_\alpha]\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{ad}(v_\gamma)^2)$; [conventions.md](../findings/conventions.md)'s Killing form $\mathop{\mathrm{tr}}(\mathrm{ad}X\,\mathrm{ad}Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ with $\mathop{\mathrm{tr}}(v^2)=-2$ at a unit bivector gives $2(n-2)$. Independently, in the coordinate basis $\varphi_{ab}=E_{ab}-E_{ba}$ the only nonzero structure constants are the triangles, $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ with $c_{ab,bc,ac}=1$ under the half-trace pairing, so row $\varphi_{ab}$ has exactly one ordered pair $(\varphi_{ac},\varphi_{bc})$ and its transpose for each of the $n-2$ remaining indices $c$, $2(n-2)$ pairs of weight $1$. **The constant is right and needs no eigenbasis.**

**Why the substitution is legitimate here and was not in the weighted sum.** In $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ the outer weight $\lambda_\gamma$ changes sign, so a termwise *upper* bound on $g_\gamma$ does not aggregate to an upper bound on the sum, it is reversed on $\mathfrak m$, which is exactly the half that carries the mass. At a single $\gamma$ there is no outer weight, and $T\ge0$ makes the termwise chord aggregate. **That is the whole of the difference, and the block states it correctly.**

**One free consequence the block does not draw.** At $\lVert W\rVert=1$, $(\lambda_{\max}-\lambda_{\min})^2\le2(\lambda_{\max}^2+\lambda_{\min}^2)\le2\sum\lambda^2=2$, so

$$c:=2(n-2)(\lambda_{\max}-\lambda_{\min})^2\ \le\ 4(n-2)\ <\ 4(n-1)\quad\text{unconditionally.}$$

This is the sentence that sinks §4 below.

---

## 2. The excluded-index sharpening, the record's reading is RIGHT, and the record already proves it

**Where the effect comes from.** $T$ is hollow in the $3$-tensor sense ([conventions.md](../findings/conventions.md)): $T_{\gamma\alpha\beta}=0$ whenever two indices coincide. So row $\gamma$'s pair support omits $\gamma$ itself, and more generally lies inside $S_\gamma:=\{\alpha:\lVert[v_\gamma,v_\alpha]\rVert>0\}$. Since the marginal $2(n-2)$ is *already* the mass on that support, the spread may be taken over the support at no cost:

$$g_\gamma\ \le\ 2(n-2)\max\{(\lambda_\alpha-\lambda_\beta)^2:T_{\gamma\alpha\beta}>0\}\ \le\ 2(n-2)\big(\lambda^{\hat\gamma}_{\max}-\lambda^{\hat\gamma}_{\min}\big)^2 ,$$

$\hat\gamma$ meaning the spectrum with one copy of $\lambda_\gamma$ deleted. **Both inequalities are valid; the middle term is the sharp one and the right-hand one is the spectral shadow of it.**

**When the right-hand one bites, in closed form.** Deleting one index moves an extreme only if that index carries it alone, so the gain is

$$\text{gain}_\gamma=2(n-2)\Big[(\lambda_{\max}-\lambda_{\min})^2-\big(\lambda^{\hat\gamma}_{\max}-\lambda^{\hat\gamma}_{\min}\big)^2\Big]=\begin{cases}2(n-2)(\lambda_{\max}-\lambda^{(2)})(\lambda_{\max}+\lambda^{(2)}-2\lambda_{\min}), & \lambda_\gamma=\lambda_{\max},\ \dim E_{\max}=1,\\[2pt] 2(n-2)(\lambda_{(2)}-\lambda_{\min})(2\lambda_{\max}-\lambda_{\min}-\lambda_{(2)}), & \lambda_\gamma=\lambda_{\min},\ \dim E_{\min}=1,\\[2pt] 0 & \text{otherwise,}\end{cases}$$

with $\lambda^{(2)}$ the second largest and $\lambda_{(2)}$ the second smallest eigenvalue. **So the record's reading (the effect bites exactly when the extreme eigenvalue at $\gamma$ has multiplicity one), is CONFIRMED**, and it is the same criterion [Lemma L70](../findings/bounds.md)'s blockquote states for the sibling bound (*"the excluded-index effect reaches this bound only when $\dim E_{\min}=1$"*).

**But the sharpening is void wherever the cap is doing work, and this is a theorem rather than an observation.** §3 shows the cap saturates at row $\gamma$ exactly when $\mathrm{ad}(v_\gamma)$ is supported on $E_{\min}\otimes E_{\max}$. That is [Lemma L70](../findings/bounds.md)'s equality case, and the dimension theorem recorded beneath it, Gate 2, [r565](REVIEW_r565.md) and [r566](REVIEW_r566.md), from the pair cap [Lemma L31](../findings/stratum-two-negative.md) and the Killing marginal alone, gives $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$ there. The saturating row sits in $E_{\min}$, whose dimension is then $\ge n/2\ge2$, so deleting it removes neither extreme:

> **At every row where the cap is saturated, the excluded-index gain is identically $0$, for every $n\ge4$.**

**So the answer to the audit's main question is: real, closed-form, and vacuous exactly where it would have to bite.** It is real at multiplicity-one extremes; it is $0$ at every catalogued critical point, where the extreme multiplicities are $k^2$ and $k(k-1)$ at $S^k\times S^k$ and $m(m-1)$ and $m^2-1$ at $\mathbb{CP}^m$; and in the one family where a multiplicity-one extreme does occur (the pure rows $\gamma\in\Lambda^2V_1$ of a product $S^p\times S^q$ with $p=2$), the affected row has $g_\gamma=0$ against a positive cap, so the sharpening improves a bound that is already infinitely slack.

**Two further points the block owes.**

- **The record has this already, in a stronger form, for the sibling bound.** [Lemma L107](../findings/bounds.md) carries the same effect through the *pair* variable, *"$T$ vanishes on repeated indices, so in row $a$ the variable $X=\tfrac{\lambda_b+\lambda_c}2$ ranges over means of two distinct eigenvalues indexed away from $a$"*, with the sharpened chord $\theta\le\lambda_{\max}-\ell_a-\sigma_a-(n-2)\ell_a\sigma_a/\lambda_{\max}$, proved to dominate unconditionally, Gate 2 confirmed at [r563](REVIEW_r563.md)/[r564](REVIEW_r564.md). L109 quoting neither that lemma nor the multiplicity criterion it establishes is the single largest omission in the block.
- **The support form is strictly sharper than the spectral form, and the block conflates them.** At a *pure* row of $S^k\times S^k$ the support $S_\gamma$ contains both extremes, so the spectral form gives the full cap while $g_\gamma=0$; the pair form gives $0$ exactly, since every triangle through a pure $\varphi_{ab}$ has both other edges in the same eigenspace. The pair form is not a spectral quantity, so it leaves the LP class, which is a live remark the block does not make.

---

## 3. Saturation at $S^k\times S^k$, EXACT, and derivable in five lines

**The block's "slack $0.0000$" and "to machine precision" are measurements of an identity.** Here is the identity.

Balanced product, $n=2k$, $V=V_1\oplus V_2$. The metric is Einstein, so $W=R-\tfrac{s}{n(n-1)}\mathrm{Id}$ with $R=\mathrm{Id}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ and $0$ on $V_1\wedge V_2$, and $\tfrac{s}{n(n-1)}=\tfrac{k-1}{2k-1}$. Hence

$$\lambda_{\max}=\tfrac{k}{2k-1}\ \ (\text{mult }k(k-1)),\qquad \lambda_{\min}=-\tfrac{k-1}{2k-1}\ \ (\text{mult }k^2),\qquad \lambda_{\max}-\lambda_{\min}=1,\qquad \lVert W\rVert^2=\tfrac{k^2(k-1)}{2k-1},$$

trace-free by inspection, and the multiplicities are the record's own table. At unit norm the cap is therefore

$$c=2(n-2)\cdot\frac{1}{\lVert W\rVert^2}=\frac{4(k-1)(2k-1)}{k^2(k-1)}=\frac{4(2k-1)}{k^2}=\frac{4(n-1)}{k^2}.$$

Now take $\gamma=\varphi_{ab}$ **mixed** ($a\in V_1$, $b\in V_2$), so $\lambda_\gamma=\lambda_{\min}$. Its $2(n-2)$ triangles are indexed by $c\ne a,b$: for $c\in V_1$ the pair is $(\varphi_{ac},\varphi_{bc})=(\text{pure},\text{mixed})$, and for $c\in V_2$ it is $(\text{mixed},\text{pure})$. **Every one of the $2(n-2)$ units of bracket mass therefore sits on a pair with one index at $\lambda_{\max}$ and one at $\lambda_{\min}$**, so every chord is used at its maximum and

$$g_\gamma=2(n-2)(\lambda_{\max}-\lambda_{\min})^2=c\qquad\text{exactly, for every }k\ge2\text{ and every mixed }\gamma .$$

For $\gamma$ **pure**, both other edges of every triangle lie in the same eigenspace, so $g_\gamma=0$.

**Cross-checked against two identities the record carries, both exact.** $\sum_\gamma g_\gamma=k^2c=4(2k-1)=4(n-1)$ ✓. And $\sum_\gamma\lambda_\gamma g_\gamma=k^2c\lambda_{\min}=-\tfrac4k\sqrt{(k-1)(2k-1)}$, so $\theta=\tfrac1k\sqrt{(k-1)(2k-1)}$, which is $\theta_0(2k)$ from $\theta_0(n)^2=2(n-1)(n-2)/n^2$ ✓. **Two independent anchors reproduced exactly, so the spectrum, the structure constants and the normalisation above are all the record's.**

**What is structurally true, and what the block says instead.**

| the block | the correct statement |
|---|---|
| *"the cap is saturated **exactly** on $S^k\times S^k$"* | Saturation at row $\gamma$ $\iff$ **every $T$-triangle through $\gamma$ joins an $E_{\max}$ index to an $E_{\min}$ index**, i.e. $\mathrm{ad}(v_\gamma)$ is supported on $E_{\min}\otimes E_{\max}$. Imposed on the whole of $E_{\min}$ this reads $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$, verbatim [Lemma L71](../findings/bounds.md)'s hypothesis, which forces a symmetric pair and hence the balanced sphere product. **So "exactly on $S^k\times S^k$" is a theorem the record already owns, not a measurement at ten values of $k$.** |
| *"for $k=3,\dots,10$"* | The sources checked $k=3,4,5,6,8,10$ ([r110](REVIEW_r110.md) §3c); $k=7$ and $k=9$ were never run. The claim is nonetheless true for **all** $k\ge2$, by the display above. |
| *"slack $0.0000$ at $n=6,8,10$"* | Slack $0$ on the $k^2$ mixed rows; slack $c=4(n-1)/k^2$ on the $k(k-1)$ pure rows. The quoted $0$ is $\min_\gamma$ slack, i.e. a statement about $g_{\max}/c$, and the block does not say so. |

**And L109's saturation condition is the *sharp* member of the pair.** [Lemma L70](../findings/bounds.md)'s blockquote flags its own equality case ($\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$ on the support) as the **weakened** form of the right condition. L109's ($\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$) implies it and is strictly stronger, needs neither $\lambda_{\min}<0<\lambda_{\max}$ nor criticality, and feeds L71's Lie-theoretic unwinding directly. **That is a positive finding for L109 and the block draws none of it.**

---

## 4. The two saturation statements, compatible, but the block's stated reason is a NON SEQUITUR

The block writes: *"Since $\sum_{\mathfrak m}g=4(n-1)-\Delta-G_0$ exactly and the cap is smaller than $4(n-1)$, mass is forced off the bottom eigenvalue."*

**The premise is unconditionally true and therefore carries no information.** §1 gives $c\le4(n-2)<4(n-1)$ at every unit $W$, every $n$, Weyl or not. A statement true everywhere cannot force anything anywhere, and in particular cannot be what distinguishes the maximiser from a random point.

**The correct condition, and it is one line.** Water-filling pours the mass $M=4(n-1)-\Delta-G_0$ onto the most negative eigenvalues subject to $g_\gamma\le c$. It gains over the recorded step $\lambda_\gamma\ge\lambda_{\min}$ **iff the bottom eigenspace cannot absorb the mass**:

$$\dim E_{\min}\cdot c\ <\ M .$$

At $S^k\times S^k$: $\dim E_{\min}=k^2$, $c=4(n-1)/k^2$, $\Delta=G_0=0$, so $\dim E_{\min}\cdot c=4(n-1)=M$, **equality, exactly**. So the cap forces nothing there and the sharpening costs nothing, which is precisely the block's own second statement. **The two statements are compatible**, and the reason is this identity rather than the inequality the block gives.

**The source had the hypothesis and the block dropped it.** [r109](REVIEW_r109.md) §3(c) reads *"Where a single $\lambda_{\min}$ direction cannot absorb $m$, and it **generically** cannot, since $c\le4(n-2)<4(n-1)$"*. The single-direction hypothesis $\dim E_{\min}=1$ and the hedge *"generically"* are both in the source and both absent from the block, which is what turns a correct sentence into a non sequitur.

**One structural remark worth carrying forward.** The condition for the water-filling to bite ($\dim E_{\min}=1$, in the crude reading the block inherits) and the condition for the excluded-index sharpening to bite ($\dim E_{\min}=1$) are the **same** condition, and the dimension theorem $\dim E_{\min}\ge n/2$ rules it out at every saturating point. So the two mechanisms are void together, for one reason.

---

## 5. The stale ceiling, the quoted number is not merely stale, it is the withdrawn one

| where | $n=6$ | $n=8$ | $n=12$ |
|---|---|---|---|
| the L109 block | $1.60$ | $2.29$ | $2.49$ |
| the same file, later ([bounds-relaxations.md](../findings/bounds-relaxations.md), marginals-only) | $1.7227$ | $2.290283$ |, |
| the same file, later (vector identity $R\lambda=-2\lambda$ carried) | $1.413614$ | $2.2585$ |, |

Two things follow, both from the file itself.

- **The block should carry $1.4136$ / $2.2585$.** The file states outright that *"the LP optimum on the old constraint set is $1.7227$ at $n=6$, not $1.6059$, that figure was an under-converged ascent"*. So $1.60$ is not the superseded value of the old constraint set; it is the **withdrawn** value of it. The block reproduces a number the file has retracted, and the [L110](../findings/bounds-relaxations.md) block four paragraphs down already says so.
- **The $n=12$ entry has no updated counterpart**, so $2.49$ should be flagged as untested against the vector identity rather than quoted alongside two numbers that were.

**Does *"it cannot close"* survive?** Yes, on every reading. The class ceiling has to fall below $\sqrt{3/2}=1.224745$ to close the conjecture, and the smallest candidate is $1.413614$, a residual gap of $15\%$. **Carrying the corrected numbers makes the conclusion harder-won, not weaker.** Two caveats belong with it: these are LP optima, i.e. numerical, and the file records an open discrepancy ($1.6089$/$1.4212$ from the reviewers' encodings against $1.7227$/$1.4136$), so the third digit is not settled; and the [L110](../findings/bounds-relaxations.md) block flags a pointwise $n=12$ bite reaching $1.212$ that does **not** survive as a ceiling, which is the number to watch, since it is the only one below target.

---

## 6. Checklist

| item | finding |
|---|---|
| **Provenance** | **TRUE, the first of these to pass.** [REVIEW_r109.md](REVIEW_r109.md) §3(c) and [REVIEW_r110.md](REVIEW_r110.md) §3c both derive the cap, both are refutations of post F25, and r110 states an independent implementation with conventions fixed from its brief alone. Commits `eb31bc71` ("fence post 25 withdrawn; the refutation produced a sharpening") then `2d66938e`. The provenance line is accurate as written. |
| **The heading** | The numbered heading `#### Lemma L109, …` is compliant with [structure-check](../.claude/skills/structure-check/SKILL.md)'s rule. The immediately following `#### A per-coordinate cap on $g_\gamma$, found by two reviewers independently` is a **result-shaped heading with no id at the same level**, phase A of the check. Correct structure: the numbered heading alone, with the restatement folded into the bold lead sentence beneath it. *This is a file-wide pattern ([L114](../findings/bounds-relaxations.md) does the same), so it is a formatting note rather than an L109 defect.* |
| **Hedging clauses** | *"costs nothing"*, CONFIRMED, and provable (§3, §4). *"to machine precision"*, concealing an exact identity (§3). *"exactly on $S^k\times S^k$"*, a classification claim supported by six data points; true, but by L71 rather than by measurement. *"generically"*, present in the source, **dropped** by the block (§4). |
| **Numbers as identities** | Three. $g_\gamma=c$ at $S^k\times S^k$ (derived here, exact for all $k\ge2$); slack $0.0000$ (exact, on the mixed rows only); $\dim E_{\min}\cdot c=M$ at the maximiser (derived here, exact). All three are **observed** in the block and **derivable** in five lines. |
| **Does the file settle it?** | **Twice, and in a sibling file rather than this one.** [Lemma L107](../findings/bounds.md) settles the excluded-index sharpening; [Lemmas L70/L71](../findings/bounds.md) settle the saturation classification and supply the dimension theorem that makes the sharpening void. Neither is cited by L109. |
| **Pointers** | All resolve: [fence-posts.md](../findings/fence-posts.md), [target.md](../findings/target.md), [petersen-wink-2019 notes](../references/petersen-wink-2019-bochner-technique/notes.md), [run_q_structure.py](../scripts/runs/run_q_structure.py), [REVIEW_r109.md](REVIEW_r109.md). [INDEX-results.md](../findings/INDEX-results.md) row 109 correctly reads *"Gate 2: no verdict on the record"*. **One miss:** the brief and the block send the reader to [conventions.md](../findings/conventions.md) for $g_\gamma$, which has **no row for it**, $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ appears only in passing in two other blocks. By conventions.md's own rule (*definitions are quoted, never restated*) that row is owed. |
| **A misfiled table row** | *"against the a priori bound: $15$–$25\%$ (110); $8$–$15\%$ at $n=5,6,7,8$ (109)"*. r110's $15$–$25\%$ is measured against the a priori $\lvert\lambda_{\min}\rvert(n-1)$; r109's $7.9$–$15.1\%$ is measured against *"the recorded bound"* with the $\lambda^{\min}_{\mathfrak p}$ term switched off, a different baseline, sitting numerically between r110's two. The row asserts a commensurability the sources deny. |

---

## 7. What is owed

1. **Replace the water-filling sentence** with $\dim E_{\min}\cdot c<M$, and record that it is an equality at the balanced product. *Reachable, one line, §4.*
2. **Replace the saturation measurement with the derivation**, and connect the equality case to [L70](../findings/bounds.md)/[L71](../findings/bounds.md), noting that L109's condition is the sharp member of that pair. *Reachable, five lines, §3.*
3. **Record the excluded-index answer**: real, closed form as in §2, bites iff the extreme at $\gamma$ has multiplicity one, and **identically void at every saturating row** by the dimension theorem. Cite [L107](../findings/bounds.md). *Reachable, §2.*
4. **Correct the ceiling** to $1.4136$/$2.2585$ and flag $n=12$ as untested. *Reachable.*
5. **Fix $k=3,\dots,10$** to $k=3,4,5,6,8,10$, or better, to "every $k\ge2$, proved".
6. **Add a $g_\gamma$ row to [conventions.md](../findings/conventions.md).**

**Nothing here requires computation.** Every claim above is closed-form and anchored on $\sum_\gamma g_\gamma=4(n-1)$ and $\theta(S^k\times S^k)=\theta_0(2k)$, both of which the derivation of §3 reproduces exactly.
