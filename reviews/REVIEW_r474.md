# Review r474, Conjecture L16, the defect-penalty inequality

**Status: REFUTED (scoped), see Verdict.** Reviewer r474, adversarial audit, analysis only.

Findings appended as reached.

## Log

## Phase A, the statement, read against [conventions.md](../findings/conventions.md)

**The statement audited** ([problem.md](../findings/problem.md) §"Conjecture L16", duplicated verbatim at [results.md](../results.md) §"Conjecture L16"):

> $P(W)\le\theta_0(n)+\kappa_n\delta^2$ on $\{|W|=1\}$, with $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, $\delta^2=\|\mathrm{Alt}(W_-)\|^2$, $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$.

### A1, the arithmetic all checks (CONFIRMED, no defect)

Recomputed by hand from [conventions.md](../findings/conventions.md) alone:

- **The competitor's defect is $1/9$.** $W_{\mathbb{CP}^2}$ unit-normalised is $\mathrm{diag}(2s,-s,-s)$ on $\Lambda^+$, $0$ on $\Lambda^-$, with $6s^2=1$. Then $W_-=\tfrac12(|W|-W)=\mathrm{diag}(0,s,s)$ on $\Lambda^+$, $0$ on $\Lambda^-$. With $\mathrm{Alt}=$ projection onto $\mathrm{span}(\star)$ and $\|\star\|^2=6$: $\langle W_-,\star\rangle=2s$, so $\mathrm{Alt}(W_-)=(s/3)\star=\tfrac1{3\sqrt6}\star$, **exactly conventions.md's $a=\tfrac1{3\sqrt6}$**, and $\delta^2=a^2\cdot6=1/9$. Padding is defect-preserving because $W_-$ is supported on the $\Lambda^2\mathbb R^4$ block and every cyclic term of $\mathrm{Alt}$ vanishes off it, so "in every ambient dimension" is right.
- **$\kappa_n$ is pinned correctly**: equality at the competitor forces $\sqrt{3/2}=\theta_0+\kappa_n/9$, i.e. $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$.
- **The crossover is right**: $\theta_0(n)>\sqrt{3/2}\iff 4(n-1)(n-2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7\approx11.29$.
- **[Lemma L133](../findings/second-order.md)'s comparison reproduces.** $\kappa_{12}^{\mathrm{Hess}}=\tfrac{27}2(1.23600)(0.2-0.5)=-5.0058$ against $\kappa_{12}=9(1.224745-1.235998)=-0.101$: ratio $49.3$. As $n\to\infty$, $-\tfrac{27}4\sqrt2=-9.5459$ against $9(\sqrt{3/2}-\sqrt2)=-1.70522$: ratio $5.598$. Both figures in the record are exact.

### A2, the sign convention on $W_-$ is INERT for L16 (and the record only half-says so)

$\mathrm{Alt}$ annihilates every Weyl tensor, so $\mathrm{Alt}(W_-)=\tfrac12\mathrm{Alt}(|W|)=\mathrm{Alt}(W_+)$. Two consequences:

- The $W_-$ sign trap conventions.md flags as having "refuted four lemmas in one day" **cannot bite L16's statement**, since $\delta^2$ is a squared norm and the flip only negates $\mathrm{Alt}(W_-)$. It bites [Lemma L17](../findings/route-a.md)'s $d^+\delta^2=-2aF$, which is one-sided. The record should say which.
- $\delta^2\le\tfrac14$ **universally**, since $\||W|\|=\|W\|=1$ and $\mathrm{Alt}$ is an orthogonal projection. So the penalty term is capped: $\kappa_n\delta^2\ge\kappa_n/4$, and L16 never claims more than $P\le\theta_0(n)$ (upper) or $P\ge$ anything (it is one-sided). This is the value-level twin of [Lemma L140](../results.md)'s derivative-level $\tfrac12$-contraction; the record has the derivative form and not the value form.

*(The $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$ identity is already on the record, at [results.md](../results.md)'s Observation L15 correction. Recorded here as confirmation, not as a new finding.)*

## Phase B, the claimed consequence. **THIS IS WHERE IT BREAKS.**

### B1, DEFECT. L16 does not settle the conjecture at ODD $n\ge12$, on the record's own Lemma L57

Four canon locations assert the implication without a parity restriction:

| location | wording |
| --- | --- |
| [problem.md](../findings/problem.md) §L16 | "If true for $n\ge12$ it settles your conjecture outright" |
| [results.md](../results.md) §L16 | same sentence, verbatim |
| [routes.md](../routes.md) R17 | "[Conjecture L16] $P\le\theta_0(n)+\kappa_n\delta^2$ settles the conjecture outright" |
| [plan.md](../plan.md) I4 | "which **settles the conjecture outright** for $n\ge12$" |

**It does not, at odd $n$.** For $n\ge12$ the penalty is nonpositive, so all L16 delivers is $P\le\theta_0(n)$. The conjecture ([README.md](../README.md)) is that $P$ is *maximised on the Weyl tensor of products of spheres*. The record's own [Lemma L57](../results.md) gives that maximum as $\Theta_n$, with

$$\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}\ (\text{even}),\qquad \Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}\ (\text{odd}),$$

and at odd $n$ **$\Theta_n<\theta_0(n)$ strictly**, because $\theta_0(n)$ is the balanced value at a splitting $n/2+n/2$ that does not exist. So at odd $n$ L16's bound overshoots the target by $\theta_0(n)-\Theta_n$:

| $n$ | $\Theta_n$ | $\theta_0(n)$ | **gap L16 leaves** | the $n=12$-style window $\theta_0-\sqrt{3/2}$ |
| --- | --- | --- | --- | --- |
| 13 | 1.2483756 | 1.2498521 | **0.0014765** | 0.0251 |
| 15 | 1.2709778 | 1.2719189 | **0.0009411** | 0.0472 |
| 17 | 1.2881224 | 1.2887590 | **0.0006366** | 0.0640 |
| 31 | 1.3454906 | 1.3455906 | **0.0001000** | 0.1208 |

The gap shrinks but **is never zero**, so the shortfall is not an asymptotic technicality, it is present at every odd $n$. R17 is the programme's primary route; as stated it reaches only the even half of a problem the record itself declares parity-open ([results.md](../results.md), "Scope note: parity", *"What remains conjectural at odd $n$ is the non-diagonal half, as at even $n$"*).

**The available defence and why it costs.** That same scope note says *"the headline statement is an even-$n$ one"*. If L16 inherits that, the inequality is fine, but then **every one of the four locations above is overstated**, none carries the restriction, and [plan.md](../plan.md)'s grade-3 parent item I4 is a route to half the problem. The record cannot have both readings.

### B2, DEFECT. The equality set is misstated, and it is empty on the $\delta^2=0$ slice at odd $n$

[results.md](../results.md) §L16: *"equality exactly at the sphere product and at the $\mathbb{CP}^2$-type competitor"*; [problem.md](../findings/problem.md): *"equality holds at both named maximizers by construction"*.

- At **even** $n\ge12$ both are equalities, verified in A1.
- At **odd** $n\ge13$ the sphere product has $\delta^2=0$ and $P=\Theta_n<\theta_0(n)$, so it **misses** equality by the table above. Conjecturally nothing attains $\theta_0(n)$ at odd $n$, so **the equality set on $\{\delta^2=0\}$ is empty** and L16 is a conjecture with slack there, not one tight at its own maximisers.

The brief asks whether the equality set is recorded. It is recorded, and it is wrong on the odd branch.

### B3, the repair, and it is free at the crossover

State L16 with $\Theta_n$ in place of $\theta_0(n)$:

$$P(W)\le\Theta_n+\kappa_n\delta^2,\qquad \kappa_n=9\big(\sqrt{3/2}-\Theta_n\big).$$

- **The threshold is unchanged.** $\Theta_n>\sqrt{3/2}$ iff $n\ge12$: $\Theta_{10}^2=1.44$, $\Theta_{11}^2=160/108=1.4815$, both $<3/2$; $\Theta_{12}^2=220/144=1.5278$ and $\Theta_{13}^2=240/154=1.5584$, both $>3/2$. So $\kappa_n<0$ for exactly $n\ge12$, as before, and $n=11$ stays excluded.
- **Both equality cases return at both parities**, the unbalanced product at $\delta^2=0$, Fox at $\delta^2=1/9$.
- **Honest cost.** The $\Theta_n$-form is strictly *stronger* on $\{\delta^2<1/9\}$ (the region every high-$\theta$ point occupies) and strictly *weaker* on $\{\delta^2>1/9\}$ (where the record's highest known point sits at $P=0.387$, margin $+0.83$). It is a different conjecture on the odd branch and would need its own second-order check: [Lemma L133](../findings/second-order.md)'s balanced-orbit computation is set at $n=2m$ and says nothing about the unbalanced orbit.

### B4, DEFECT. [plan.md](../plan.md) I7's implication is false, and provably so

I7 reads: *"the destination: $\theta\le\sqrt{3/2}$ on the compact non-pure set … [Conjecture L16] would give it outright"*.

**L16 implies $\theta\le\sqrt{3/2}$ on exactly $\{\delta^2\ge1/9\}$ and nowhere else.** Solve: $\theta_0(n)+\kappa_n\delta^2\le\sqrt{3/2}\iff\theta_0-\sqrt{3/2}\le9(\theta_0-\sqrt{3/2})\delta^2\iff\delta^2\ge\tfrac19$ (the factor $\theta_0-\sqrt{3/2}>0$ cancels, so the condition is $n$-free). On $\{\delta^2<1/9\}$, which contains the whole zero-defect set and, by the record's own frontier sweep, *every* catalogued critical point with $\theta\ge1$, L16's bound sits **strictly above** $\sqrt{3/2}$. So it gives I7 nothing on the region I7 is about.

The underlying geometry, worth stating once: **L16's bounds form a pencil of lines hinged at the fixed point $(\delta^2,P)=(1/9,\sqrt{3/2})$**, with $\delta^2=0$ intercept $\theta_0(n)$ and slope $\kappa_n$. Every member passes through Fox; $n$ only rotates the line about it. That is why $\{\delta^2\ge1/9\}$ is the exact region where L16 beats $\sqrt{3/2}$, in every dimension at once.

*Charitable reading:* if "it" in I7 means the conjecture rather than I7's own displayed theorem, the sentence is still wrong at odd $n$ by B1.

## Phase C, the two halves, the notation, and the near-misses

### C1, DEFECT. The split into "grant + global closure" is not exhaustive for the statement as written

[routes.md](../routes.md) R17: L16 *"owes two steps: the grant $J_5\ge0$ **at critical points** … and the global closure"*. [plan.md](../plan.md) I4 states the same two halves, (a) and (b).

**The third thing neither half names is the quantifier.** L16 is stated over the whole unit sphere, and the block advertises exactly that, *"zero-defect points fall under it with no criticality hypothesis"*. The lifted Jäger chain that R17 would run is a critical-point argument end to end ([Lemma L18](../findings/problem.md): *"every critical point clearing the threshold has either …"*), and half (a) is explicitly a grant *at critical points*. So R17 at full success delivers L16 restricted to $\mathrm{Crit}(P)\cap S$, never L16.

Three reasons this is a real gap rather than pedantry:

1. **The evidence base is off the critical set.** The record's own battery tests L16 at random and gradient-ascent points; [ATTEMPTS.md](../ATTEMPTS.md) calls that *"strictly stronger because the bound is tested off the critical set too"*. The tested object and the provable object are different objects.
2. **The one recorded violation is non-critical.** The $n\le11$ refutation is *"at a non-critical kink point"*. A refutation of the all-$W$ form is not a refutation of the critical-set form; the record does not say which form it refuted.
3. **The record already draws the distinction elsewhere and does not carry it here.** [ATTEMPTS.md](../ATTEMPTS.md) Result 8 reports the frontier sweep as *"Conjecture L10 restricted to the critical set, holding with exact equality"*, i.e. the critical-set form, named as such, in the same document that states the all-$W$ form as the conjecture.

*Would this be true vacuously?* No, the two forms genuinely differ, and the weaker (critical-set) one still settles the conjecture, since $P$ is continuous on a compact sphere and its maximiser is critical. **So the honest repair is to state L16 on $\mathrm{Crit}(P)\cap S$**, which loses nothing toward the goal, matches what R17 can prove, and removes the mismatch between the statement and its route.

### C2, DEFECT. $\kappa_n$ is doubly booked, against a rule [conventions.md](../findings/conventions.md) states for other letters

[conventions.md](../findings/conventions.md) already flags two letters as ambiguous, *"THE LETTER $B$ MEANS TWO THINGS, live"* and *"The letter $M$ carries two objects"*. $\kappa$ is worse and is not flagged:

| symbol | meaning | where |
| --- | --- | --- |
| $\kappa$ | $2(n-2)$, the Killing form in an orthonormal basis | [conventions.md](../findings/conventions.md), normalisations |
| **$\kappa_n$** | $(2n-1)(n-1)/4$, "the algebra's Killing constant" ($=\kappa_F$ of [algebra.md](../findings/algebra.md)) | [conventions.md](../findings/conventions.md), last bullet of the structure-constants block |
| **$\kappa_n$** | $9(\sqrt{3/2}-\theta_0(n))$, L16's penalty | [problem.md](../findings/problem.md), [results.md](../results.md), [plan.md](../plan.md), [routes.md](../routes.md), [route-a.md](../findings/route-a.md), [second-order.md](../findings/second-order.md) |
| $\kappa(\mathrm{Ric}(\lvert W\rvert))$ | a condition number | [second-order.md](../findings/second-order.md) post F54, [ATTEMPTS.md](../ATTEMPTS.md) |

The two middle rows are the same glyph with the same subscript and opposite signs at the dimensions that matter, $\kappa_{12}=+30.25$ under conventions.md, $-0.1016$ under L16. **conventions.md is the file whose whole purpose is that definitions are quoted rather than restated, and it does not carry L16's $\kappa_n$ at all.** A reader who follows the record's own rule and looks $\kappa_n$ up in conventions.md gets the wrong constant with the wrong sign.

### C3, DEFECT. $\{|W|=1\}$ is, read against [conventions.md](../findings/conventions.md), the wrong sphere, and $|W|$ carries two senses inside L16's own definitional chain

The canonical statement in [problem.md](../findings/problem.md) and [results.md](../results.md) is *"on $\{|W|=1\}$"* with single bars, while $\delta^2=\|\mathrm{Alt}(W_-)\|^2$ in the same clause uses double bars.

- conventions.md fixes single bars: **"$\lvert W\rvert^2=4\lVert W\rVert_F^2$ relates the two $\Lambda^2$ normalisations in use."** Under that reading $\{|W|=1\}$ is $\lVert W\rVert=\tfrac12$, where $P$ (a cubic), is $\tfrac18$ of its unit-sphere value. The asserted equality $P=\theta_0(n)$ at the sphere product then fails by a factor $8$.
- The same bars mean the **operator absolute value** two symbols later, since $W_-:=\tfrac12(\lvert W\rvert-W)$ is conventions.md's own definition of the object $\delta^2$ is built from.
- **This is a transcription defect introduced by the move.** [ATTEMPTS.md](../ATTEMPTS.md)'s original statement of the same inequality reads *"for all $W\in\mathcal W_n$ with $\|W\|=1$"*, double bars, the right sphere. The canon's copy silently swapped them.

Intent is not in doubt; the written statement is wrong, and this is exactly the class of error conventions.md exists to catch.

### C4, collateral defects in [conventions.md](../findings/conventions.md) found while checking L16's constants

- **$\Theta_n$'s odd formula has lost its square.** The table row reads *"equals $\theta_0(n)$ at even $n$, and $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$"*, the first a value, the second a square. [Lemma L57](../results.md) states it correctly as $\Theta_n^2$. As written, conventions.md makes $\Theta_{13}=1.5584>\theta_0(13)=1.2499$, i.e. the odd *diagonal* maximum exceeding the balanced value, which is impossible. The correct value is $\Theta_{13}=1.2484$.
- **$\Theta_5$ has two values in the canon.** conventions.md defines $\Theta_n$ as *the diagonal maximum*; [Lemma L57](../results.md) then gives $\Theta_5=\sqrt{8/9}=0.9428$, while [Lemma L61](../results.md) and the summary table at [results.md](../results.md) give *"$\Theta_5=\sqrt{3/2}$ … on all of $\mathcal W_5$"*. Both facts are right; the symbol is overloaded, against conventions.md's own definition.

### C5, the record's $n\le11$ quarantine holds, but by $0.0044$, and the margin is nowhere on the record

[problem.md](../findings/problem.md) and [results.md](../results.md): *"the analogous interpolation statement for $n\le11$ is refuted by an explicit violation at $n=8$, and the refutation needs the penalty's other sign, so it leaves the $n\ge12$ claim untouched."*

Padding preserves $\lVert W\rVert$, $P$ and $\delta^2$ (conventions.md; and [ATTEMPTS.md](../ATTEMPTS.md) states the defect's padding-invariance explicitly), so the $n=8$ violator is a point of $\mathcal W_{12}$ and the quarantine is a claim, not a definition. Checked, on the record's own recorded coordinates $P=1.221305$, $\delta^2=0.101301$:

| | value |
| --- | --- |
| $n=8$: $\Phi=P-\kappa_8\delta^2$ | $1.149188$ vs $\theta_0(8)=1.145644$, violation $+0.003544$ ✓ reproduces |
| $n=12$: L16 RHS $=\theta_0(12)+\kappa_{12}\delta^2$ | $1.2257415$ vs $P=1.2213050$, **margin $+0.0044365$** |
| $n=14$ | margin $+0.0067009$ |

**So the claim is true and the reasoning is sound**, but the surviving margin is $39\%$ of the $n=12$ window $\theta_0(12)-\sqrt{3/2}=0.011288$, and comes from $\theta_0(12)-\theta_0(8)=0.0904$ beating the penalty swing $(\kappa_8-\kappa_{12})\delta^2=0.0824$, not from any structural feature of "the other sign". The record states the conclusion and records neither the margin nor the mechanism. **A fence post is owed here**: the $n=8$ ascent produces the closest thing the record has to a counterexample at $n\ge12$, and it is filed as irrelevant.

### C6, the asymptotic soft spot is real and is confined to [ATTEMPTS.md](../ATTEMPTS.md)

L16 is a pencil hinged at $(1/9,\sqrt{3/2})$ (B4), so raising $n$ **tightens** it on $\{\delta^2>1/9\}$, to the limit $P\le\sqrt2-1.7052\,\delta^2$; at the universal ceiling $\delta^2\le\tfrac14$ that demands $P\le0.9879$. [ATTEMPTS.md](../ATTEMPTS.md) records that the unconstrained defect maximum *grows* with $n$ ($0.125$ at $n=8$, $0.145$ at $n=12$) and names the soft spot itself: *"the asymptotic regime is untested … large-$n$ failure would first appear at moderate-defect, moderate-$P$ points that no catalogued family currently occupies"*.

**None of the four canon locations carries that caveat.** They say only *"survived adversarial falsification at $n=12$ and $n=14$"*, true, and silent on the direction in which the conjecture gets harder. ATTEMPTS.md is the attempts log, not the canon.

### C7, "the shape is forced, not fitted" is an overclaim, and today's L15 audit sharpens the point

The sentence is self-refuting in place: *"The shape is forced, not fitted: equality holds at both named maximizers **by construction**"*. Two points determine a line only after affineness in $\delta^2$ is assumed, and nothing in the record derives that.

More substantially: [LEDGER.md](../findings/LEDGER.md)'s audit of **Observation L15, dated 2026-09-04**, records L15 **REFUTED as stated**, the Bianchi defect is *not* the only obstruction to lifting; $X_{\mathrm{inv}}\succeq0$ is a second, *"free on the diagonal locus by the entrywise triangle inequality and refuted off it"*. L16 prices the first obstruction as $\kappa_n\delta^2$ and prices the second at nothing, because the second is not a function of $\delta^2$. **So the single-scalar shape is not licensed by the lifting analysis that motivates it**, and the L15 audit's own obligation (*"either a replacement for it off the diagonal locus or a proof that none exists"*), sits upstream of L16 unmentioned in L16's block.

## Phase D, labelling audit: CLEAN

Grepped [findings/](../findings/), [plan.md](../plan.md), [routes.md](../routes.md), [results.md](../results.md), [ATTEMPTS.md](../ATTEMPTS.md), [README.md](../README.md) and [verification/](../verification/).

- **Every occurrence names it "Conjecture L16"**; [INDEX-results.md](../findings/INDEX-results.md) row 16 reads `Conjecture`. No bare "L16" is used as an established fact.
- **No Lemma takes L16 as a hypothesis.** L133, L134, L135–L141 are *about* L16 (its scenario constants and stability thresholds); they take it as a target, not an input. [LEDGER.md](../findings/LEDGER.md)'s two-level citation-radius pass names L16 as a *dependant* of the corrected results, not as anything's support.
- **The one conditional result derived from it was withdrawn cleanly.** [ATTEMPTS.md](../ATTEMPTS.md)'s *"Conjecture L16 now holds in a tube about the competitor's orbit for $12\le n\le31$"* is followed by an explicit Gate 2 retraction: *"L136 and L137 REFUTED, L138 and L139 withdrawn with them. The range $12\le n\le31$ is withdrawn."*
- **One soft edge**: [results.md](../results.md)'s at-a-glance table row reads *"The diagonal proof lifted off the diagonal locus | **Proven**, defect priced to one term (Lemmas 15, 17–19)"*. The same cell says the closing inequality is a conjecture, and the L15 audit above has since removed "one term". The word **Proven** in that cell should go.

So the brief's first question (*what is cited as though proved*), comes back clean. **The failure is not in the labelling; it is in the implication.**

## Verdict, **REFUTED**, scoped

*The inequality is not refuted. The block's assertions about it are.*

| assertion | verdict |
| --- | --- |
| the inequality $P\le\theta_0(n)+\kappa_n\delta^2$ at **even** $n\ge12$ | **PLAUSIBLE**, every constant re-derived and exact (A1); tight at both named maximisers; not refuted at either by [L133](../findings/second-order.md), reproduced independently here |
| "settles your conjecture outright" for $n\ge12$ | **REFUTED at odd $n$** (B1). Leaves $\theta_0(n)-\Theta_n>0$ at every odd $n$, on the record's own [Lemma L57](../results.md) |
| "equality exactly at the sphere product and at the $\mathbb{CP}^2$-type competitor" | **REFUTED at odd $n$** (B2). The $\delta^2=0$ equality is missed, and conjecturally unattained |
| [plan.md](../plan.md) I7's "would give it outright" ($\theta\le\sqrt{3/2}$ on the non-pure set) | **REFUTED** (B4). L16 gives $\theta\le\sqrt{3/2}$ on exactly $\{\delta^2\ge1/9\}$, which excludes every catalogued point with $\theta\ge1$ |
| the two-half split (a) grant + (b) global closure is exhaustive | **REFUTED** (C1). The quantifier is the third thing: the route proves a critical-set statement, the canon states an all-$W$ one |
| well-posedness of the written statement | **REFUTED** (C3). $\{\lvert W\rvert=1\}$ is the wrong sphere under conventions.md, by a factor $8$ in $P$ |
| labelling | **CONFIRMED clean** (Phase D), one word to remove |

**Ranked repairs.**

1. Restate L16 with $\Theta_n$ for $\theta_0(n)$ and $\kappa_n=9(\sqrt{3/2}-\Theta_n)$, the crossover $n\ge12$ survives untouched (B3), both equality cases return at both parities, and the odd branch of R17 opens. Flag that the odd-$n$ second-order check is then owed, [L133](../findings/second-order.md) being an even-$n$ computation.
2. Restore $\lVert W\rVert=1$ in both canon copies (C3).
3. Add L16's $\kappa_n$ to [conventions.md](../findings/conventions.md) with the collision against the Killing constant named, in the style of the standing $B$ and $M$ warnings (C2).
4. State whether L16 is the all-$W$ or the critical-set statement, and correct R17 to match (C1).
5. Fix $\Theta_n$'s missing square and the $\Theta_5$ overload in [conventions.md](../findings/conventions.md) (C4).
6. Record the padded $n=8$ point's $n\ge12$ margins as a fence post (C5); carry ATTEMPTS.md's asymptotic caveat into the canon (C6); drop "forced, not fitted" and note the L15 audit upstream (C7); drop **Proven** from the at-a-glance row (D).

**Nothing here required a source from [references/](../references/).** All constants were re-derived from [conventions.md](../findings/conventions.md) and the canon.

*Reviewer r474. Analysis only; the sole compute was arithmetic on figures already recorded (C5, B1 tables), a screen of claims recorded here, never evidence for a positive claim.*
