# REVIEW r548, Observation L40, "the surviving target, measured"

**Reviewer:** r548 (independent, cold). **Target:** `Observation L40` in [findings/target.md](../findings/target.md), at the `#### Observation L40` heading, down to the next heading of any level.

**Why it matters:** L40 is the measurement standing behind the residual statement $\sup\{\theta : Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}\le\theta^*$, the one inequality that would close every even $n\ge12$. It is cited 6 times.

**Footing:** analysis-only. No searches, sweeps, censuses or falsifier hunts were run. Screening compute, if any, is labelled as a screen and never cited as evidence for a positive claim.

## Phase plan

- P1 fix conventions against the record's anchors
- P2 read L40 verbatim, in full
- P3 read its input L37 verbatim
- P4 attack points: quantifier direction; L37's use; mangled LaTeX; the $-6.7\times10^{-16}$ margin; the diagonal controls
- P5 the six citations, classified
- P6 restatements elsewhere in `findings/`; later sections of `target.md`
- P7 verdict

## Findings

(appended as found)

### The block, verbatim

> Over the catalogued critical points, decided by Lemma L37 rather than by frame inspection, $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\thstar$, **attained at $W_{\CP^2**$ and at every padding of it} (margin $-6.7\times10^{-16}$). Diagonal controls are correctly excluded, $S^5\times S^7$ at $1.228239$ among them. Three independent hunts agree: a $26$-space symmetric-space sweep, and closure sweeps at $n=6$ and $n=8$ both topping out at padded $\CP^2$.

Preceded by the italic provenance line:

> *Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is in this file under "The totally-summed vertex equation is an identity, and the reason is p"**.*

### F1, the measurement runs as a LOWER bound on the residual supremum, and the displayed formula does not say so

**The direction.** Let $\mathcal C$ be the catalogue and $\mathcal N=\{W:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}$ the residual set. $\mathcal C\cap\mathcal N\subseteq\mathcal N$, so

$$\sup_{\mathcal C\cap\mathcal N}\theta\ \le\ \sup_{\mathcal N}\theta .$$

L40 measures the left side and finds it $=\theta^*$. What that yields for the residual is $\sup_{\mathcal N}\theta\ \ge\ \theta^*$, **a lower bound**. The residual statement the abstract needs is $\sup_{\mathcal N}\theta\le\theta^*$, **the opposite direction**. L40 therefore supplies the *equality half that is already known from $W_{\CP^2}$ alone*, and supplies nothing at all towards the half that would close the conjecture.

**Whether the block says so.** It does not. The scoping lives entirely in the prefatory adverbial *"Over the catalogued critical points"*; the displayed object is written as

> $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\thstar$

with **no restriction to the catalogue inside the braces**. Read as written (and the set-builder is the only formal object in the sentence), this is verbatim the residual statement of the abstract, asserted as an *equality*, i.e. asserted **including the $\le$ direction that is open**. The warrant covers $\mathcal C\cap\mathcal N$; the notation quantifies over $\mathcal N$. This is the precise failure mode the brief names: a supremum over a catalogue presented in the notation of a supremum over everything.

**This is a scope/label defect, not an arithmetic one.** Every number in the block is, as far as I can check it, right. The object the numbers are attached to is larger than the numbers cover.

**The minimal repair** is to put the scope inside the braces and the direction in the sentence, e.g. $\sup\{\theta:W\in\mathcal C,\ Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\theta^*$, *hence $\sup_{\mathcal N}\theta\ge\theta^*$; the reverse inequality is the open residual.*


### F2, the single "=" fuses a THEOREM with a MEASUREMENT, at different epistemic status

The equality has two halves, and they are not the same kind of statement.

| half | what it rests on | status |
| --- | --- | --- |
| $\sup_{\mathcal N}\theta\ \ge\ \theta^*$, attainment at $W_{\mathbb{CP}^2}$ and every padding | exact algebra: [target.md:397](../findings/target.md#L397) gives the $m=2$ member of the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family as Ricci-flat, Bianchi, critical, non-diagonal, $S=0$, with the closed form $\theta^2=\mathbf{3/2}$ *exactly*; [conventions.md](../findings/conventions.md) gives "padding commutes with $Q$, and preserves both the norm and $\theta$" | **proved**, at every $n\ge4$, with no catalogue in it |
| $\sup_{\mathcal C\cap\mathcal N}\theta\ \le\ \theta^*$, nothing catalogued beats it | the census | **measured**, over a catalogue |

The block writes one "=" over both. The reader cannot tell that the direction carrying the conjecture is the measured one and the direction that is proved is the one that was never in doubt.

### F3, the mangled LaTeX, what it was meant to say, and the value that never renders

Verbatim: **attained at $W_{\CP^2**$ and at every padding of it}

Two independent breakages:

1. **Delimiter/brace swap.** The `}` closing the subscript and the `**` closing the bold were transposed. The intended source is `**attained at $W_{\mathbb{CP}^2}$ and at every padding of it**`. As written, the math span `$W_{\CP^2**$` carries an unclosed `{` and a `**` inside math mode, and the stray `}` lands in prose after "of it", so the formula is malformed and the emphasis spans the wrong text.
2. **Report-only macros.** `\thstar` and `\CP` are defined in [report/report.tex](../report/report.tex) and nowhere in [findings/](../findings/). **So the one number the Observation exists to report ($\theta^*$), does not render at all.** A reader of [findings/target.md](../findings/target.md) sees the residual asserted equal to an undefined control sequence. The block never prints $\sqrt{3/2}$ or $1.224745$ anywhere.

**Is the intended claim supported?** Yes, but by F2's exact algebra, not by the block's measurement. Attainment at $W_{\mathbb{CP}^2}$ and at every padding is a theorem of the record.

Prior logging: [ELIM-target.md:189](ELIM-target.md#L189) and [REVIEW_r521.md:135](REVIEW_r521.md#L135) both recorded this fragment. It is **still unfixed**, and the neighbouring L38 block carries the twin `$W_{\CP^2**$ itself.}` ([REVIEW_r546.md:154](REVIEW_r546.md#L154)).

### F4, the margin $-6.7\times10^{-16}$: what it certifies, and what it does not

$\epsilon_{\mathrm{mach}}\cdot\theta^*\approx2.22\times10^{-16}\times1.2247\approx2.7\times10^{-16}$, so $6.7\times10^{-16}$ is **about three ulps**.

**It certifies:** the arithmetic reproducing $\theta$ at the best catalogue point agrees with $\sqrt{3/2}$ to double-precision round-off. That is a self-consistency check on the pipeline.

**It does not certify:**

- **Attainment.** Attainment is F2's exact algebra. Worse, the *sign* points the other way: read literally as $(\sup_{\mathcal C\cap\mathcal N}\theta)-\theta^*$, a **negative** margin says the catalogue's best fell *short* of $\theta^*$, non-attainment. The block writes "$=$" and "attained" while parenthesising a number whose sign contradicts both. Both readings sit inside round-off, which is the point: **this is a failure to separate, not a measurement of equality**, and the block presents round-off as though it were a finding.
- **Any separation from a violator.** A non-diagonal critical $S=0$ point exceeding $\theta^*$ by $10^{-6}$ (nine orders of magnitude above this margin), would be entirely invisible to it. The margin resolves the arithmetic, not the conjecture, and quoting it beside a supremum invites the reader to take $10^{-16}$ as the confidence in the *bound*.

**And it is untraceable.** The block cites **no script and no run**. The figure $-6.7\times10^{-16}$ occurs twice more in the record attached to unrelated quantities, [ATTEMPTS.md:835](../ATTEMPTS.md#L835), where it is the worst margin of the $(\theta,\delta^2)$ frontier against Conjecture L10's line and its on-line points are Fox and the balanced $(6,6)$ sphere rather than $\mathbb{CP}^2$; and [route-a.md:389](../findings/route-a.md#L389) for $\sqrt{5/6}$. *I do not claim it was imported*, three ulps is a common magnitude and coincidence is likely. I claim only that **nothing in the record ties this number to L40.**

### F5, the use of Lemma L37 is WITHIN what L37 gives, including at the attainer. Clean.

This attack point resolves in L40's favour, and I checked it four ways.

- **The hypotheses hold.** [L37](../findings/target.md#L632) "needs neither criticality nor $W\in\mathcal W_n$", is $O(n)$-invariant ($\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$), and needs only $n\ge3$ for the converse. Every catalogued point qualifies.
- **The block's stated reason is the correct one.** It says diagonality is *"decided by Lemma L37 rather than by frame inspection"*, decidability without a frame search. That is exactly what [INDEX-results.md:52](../findings/INDEX-results.md#L52) records L37 as buying, and it **does not repeat the report's false "well posed" reason**; the non-diagonal set is $O(n)$-invariant by construction and needs no lemma to be well posed. L40 is on the right side of that correction.
- **The dangerous direction is guarded by a hard certificate.** Certifying *non*-diagonality can only inflate the measured supremum; certifying *diagonality* removes a point, and a wrong removal would delete a violator. Removal therefore needs the full equivalence, not the corollary. [b_frame_independent_diagonality.py:104](../scripts/lib/b_frame_independent_diagonality.py#L104) implements the equivalence: $\dim\ker\Phi_W<n$ returns `NON-DIAG (proved, ker<n)`; otherwise it draws Gaussian $A$ from $\ker\Phi_W$ and returns `diagonal (frame found)` on the first with distinct sums. **Exclusion is by an exhibited frame.**
- **The attainer is exactly the case where the corollary is silent.** [target.md:510](../findings/target.md#L510): *"Implementing only the dimension corollary was not enough, that wrongly called padded $W_{\mathbb{CP}^2}$ diagonal, contradicting its own rank-4 simple eigenvector; the distinct-sums search is load-bearing."* L40's champion survives only because the equivalence was used. The brief's worry lands on the one point the record had already fixed.

**I verified L37's decidability argument cold, since it is what licenses the sampled branch.** Set $D(A)=\prod_{\{i<j\}\ne\{k<l\}}\big((a_i+a_j)-(a_k+a_l)\big)^2$. Any permutation of the $a_i$ permutes the multiset $\{a_i+a_j\}_{i<j}$, hence permutes the factors, so $D$ is symmetric in the $a_i$, hence a polynomial in the elementary symmetric functions, hence a genuine polynomial in the entries of $A$; and $D(A)\ne0$ exactly when the pair-sums are distinct. Restricted to the linear (hence irreducible), space $\ker\Phi_W$, $D$ either vanishes identically or is non-zero on a dense Zariski-open set, which a Gaussian draw meets with probability $1$. **The dichotomy is real and the sampling implements it.**

**Two residual caveats, numerical rather than logical.**

- The kernel is taken at `tol=1e-8`. An $A$ only *approximately* in $\ker\Phi_W$ yields an approximate frame, so a point could in principle be excluded as diagonal on a near-kernel direction, the one direction that would hide a violator. Unquantified in the record.
- The `NON-DIAG (no distinct-sum A in 200 draws)` verdict is probability-$1$, not proof. It runs in the inflating direction, so it cannot conceal a violator; and since the measured supremum landed *at* $\theta^*$ rather than above it, no false NON-DIAG misfired above the threshold.

### F6, "Three independent hunts agree" is false on *independent*, and provably so

The block: *"Three independent hunts agree: a $26$-space symmetric-space sweep, and closure sweeps at $n=6$ and $n=8$ both topping out at padded $\CP^2$."*

**Hunt 1** is Reviewer 80's hunt over 26 named symmetric and homogeneous spaces ([REVIEW_r80.md:32](REVIEW_r80.md#L32)). It is the only one [target.md:419](../findings/target.md#L419) leaves standing. It is a **biased sample by construction**, highly symmetric points only.

**Hunts 2 and 3 are forced, not observed.** A closure sweep is a function of the catalogue, and on the record's own theorems its outcome was fixed before it ran:

- padding preserves $\theta$ ([conventions.md](../findings/conventions.md));
- for $\circ$-orthogonal sums, $\tfrac1{\theta^2}=\tfrac1{\theta_1^2}+\tfrac1{\theta_2^2}$, hence $|\theta|<\min(|\theta_1|,|\theta_2|)$ **strictly** ([target.md:415](../findings/target.md#L415)).

**So the supremum of $\theta$ over the closure of a catalogue under padding and $\circ$-sums *equals* the supremum over the catalogue, a theorem.** "Both topping out at padded $\mathbb{CP}^2$" could not have come out any other way. As corroboration the two sweeps carry **zero** information, and the count of three is reached by splitting one forced re-derivation across two dimensions.

**And an $n=6$ enumeration is disavowed in the same file.** [target.md:419](../findings/target.md#L419) strikes Reviewer 78's $\sim20$-subalgebra sweep and 3000-start Newton run for having no artefact, records that its stated *"154 distinct critical values at $n=6$, none with $S=0$"* is **false** ($\mathbb{CP}^3$ is such a point, $\theta^2=10/9$ exactly), and concludes: *"**Random-start Newton on $\mathrm{Weyl}_6$ does not reach the high-$\theta$ basin, so such an enumeration is evidence of completeness in neither direction.**"*

The record's own traps say this generally: [INDEX-traps.md](../findings/INDEX-traps.md) row 9, *"Enumeration cannot close the problem, a bound is needed, not a census"*, and row M10, *"a single search method is not a census"*. **After F6 there is one hunt, and it is a symmetric-space list.**

*A reliability note on that one hunt.* [REVIEW_r80.md:32](REVIEW_r80.md#L32) reports $S=0$ *"only at $\mathbb{CP}^m$ and $\mathbb{HP}^2$"* across the 26 spaces, and $SU(q)/SO(q)$ is in its list, yet [target.md:429–433](../findings/target.md#L429) tabulates $(\mathfrak{su}(3),\mathfrak{so}(3))$, $(\mathfrak{su}(5),\mathfrak{so}(5))$ and $(\mathfrak{su}(6),\mathfrak{so}(6))$ as non-diagonal with $S_{\mathfrak{mmm}}\sim10^{-30}$. The summary undercounts the $S=0$ set the same file tabulates. It does not move L40's number, those points sit at $1.0954$, $1.0351$, $1.0247$, all below $\theta^*$, but the surviving hunt's own tally is internally inconsistent.

### F7, the measurement is empty above $n=12$, and the block gives no dimension range

The residual statement must hold at **every even $n\ge12$**. L40's evidence:

| source | dimensions reached |
| --- | --- |
| the non-diagonal $S=0$ census, [target.md:429–433](../findings/target.md#L429) | $n=6,8,10,12$, a single point at $n=12$, $(\mathfrak{su}(6),\mathfrak{so}(6))$ at $1.0247$ |
| the closure sweeps | $n=6$ and $n=8$ only |
| the 26-space hunt | $\mathbb{CP}^{2..5}$, $\mathbb{HP}^{1..4}$, small Grassmannians, bounded, and unstated |

**Nothing above $n=12$ is measured at all**, and $n\ge12$ is precisely where [target.md:278](../findings/target.md#L278) shows the hypothesis-free form of this same supremum to be *false*. The block states no dimension range, so a reader takes the supremum as ranging over all $n$.

### F8, the block's pointer to its own argument is wrong, and it cites no artefact

The provenance line sends the reader to *"The totally-summed vertex equation is an identity, and the reason is p"*. That heading is [target.md:25](../findings/target.md#L25) and concerns the $\operatorname{tr}(W^\#)$ identity; **it contains no census and no measurement**. The material L40 summarises is at [target.md:425–445](../findings/target.md#L425). The pointer text is also truncated mid-word, "the reason is p" for "…is published".

Combined with F4's absent script link, **Observation L40 as it stands in [findings/](../findings/) has no warrant a reader can reach**: wrong pointer, no run, no artefact, and its value hidden behind an undefined macro. Prior logging at [ELIM-target.md:181](ELIM-target.md#L181), unfixed.

### F9, a passage in the same file states a stronger form of this supremum that the file itself refutes

[target.md:444](../findings/target.md#L444) closes the section "The bound is untouched" with, in bold:

> **$\sup\{\theta:S=0,\text{ non-diagonal}\}=\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$, survives.**

**No catalogue scope, and criticality dropped from the set-builder.** In that exact form it is refuted 166 lines above, at [target.md:278](../findings/target.md#L278):

> Written as $\sup\{\theta:S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$ over the unit sphere, which is how this file, [findings/INDEX.md](INDEX.md), [plan.md](../plan.md) and [bounds.md](bounds.md) all carried it, the claim is **false at every even $n\ge12$**.

with an explicit witness: an $834$-dimensional $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$-graded subspace of $\mathrm{Weyl}_{12}$ on which $S\equiv0$, containing a non-diagonal point at $\theta=1.236031>\sqrt{3/2}$. And [target.md:444](../findings/target.md#L444)'s stated warrant (Reviewer 78's search, including the "154 distinct critical values … **none** with $S=0$" figure), is struck as **false** 25 lines earlier at [target.md:419](../findings/target.md#L419).

**L40 is an improvement on this line**: it restores $Q(W)=\theta W$ to the set-builder and adds the catalogue preamble. But the refuted line still stands, unmarked, in the file the Observation lives in, and a reader arriving at L40 through the census section meets it first.

### F10, the six citations, classified. None makes the second move.

Grepped across the repository.

| citation | takes the sup as… | verdict |
| --- | --- | --- |
| [plan-verification.md:96](../plan-verification.md#L96) | a checklist row, no claim | neutral |
| [results.md:31](../results.md#L31), *"every non-diagonal critical point **on the record** sits at or below $\sqrt{3/2}$ (Observation L40)"* | over the catalogue | **correct**, scoped twice, "on the record" |
| [results.md:65](../results.md#L65), *"Everything measured agrees (Observation L40) and **nothing proves it**"* | over the catalogue | **correct**, explicitly denies the $\le$ |
| [results.md:166](../results.md#L166), *"Over every catalogued critical point … $\sup\{\ldots\}=\sqrt{3/2}$"* | over the catalogue | **acceptable**, scoped in the preamble, but reproduces the unrestricted set-builder and drops the caveat |
| [results.md:470](../results.md#L470), *"the criterion by which Observation L40 separates the two sides"* | cites L37's consumer only | **correct** |
| [results.md:486–488](../results.md#L486), the canonical statement | over the catalogue | **correct, and the model for the fix** |

**No citation asserts L40 as the residual statement.** The overstatement is confined to the block's own notation in [findings/target.md:666](../findings/target.md#L666). *The damage is contained*, which is the one piece of good news here, and it means the repair is local.

**And the record already contains the missing sentence.** [results.md:488](../results.md#L488) ends:

> This is a measurement over a catalogue and proves nothing about points outside it.

**The [findings/](../findings/) block (the canonical location), is the only statement of L40 in the record that drops it.**

### F11, the diagonal controls do exactly what the block claims, and it is the right control

Attack point 5 resolves in L40's favour. The full sentence is *"Diagonal controls are correctly excluded, $S^5\times S^7$ at $1.228239$ among them."*

- **The number checks out over $\mathbb Q$.** $\theta^2=2\cdot\tfrac45\cdot\tfrac67\cdot\tfrac{11}{10}=\tfrac{264}{175}=1.5085714$, so $\theta=1.2282392$ against $\theta^*=\sqrt{3/2}=1.2247449$, **above $\theta^*$ by $0.0035$**, and below $\theta_0(12)=\sqrt{220}/12=1.236033$ as an unbalanced product must be.
- **It is the strongest possible control**, not a decorative one: it is a diagonal point *strictly above the threshold*, so it is exactly the point whose misclassification would break the measurement outright.
- **It broke two earlier criteria.** [b_frame_independent_diagonality.py](../scripts/lib/b_frame_independent_diagonality.py) records that Reviewer 80's eigenspace-rank test *"called it NON-DIAG"* because random draws from its 35-dimensional eigenspace return the generic rank rather than the minimum. The L37 criterion is what fixed it.
- **Its exclusion is a hard certificate**: coordinate-diagonal by construction, so the diagonal matrices $\sum_i2^if_if_i^{\mathsf T}$ lie in $\ker\Phi_W$ with pairwise-distinct sums, and the code returns `diagonal (frame found)`.

*Minor:* "controls" is plural and one is named, with no count given.

---

## VERDICT: PLAUSIBLE

**The measurement is sound; the label and the notation overstate its scope, and the corroboration is overcounted.**

**What is right.** The use of [Lemma L37](../findings/target.md#L632) is squarely within what L37 grants, including at the attainer, where the corollary alone is silent and would give the wrong answer (F5). The diagonal controls are correct and are the strongest available (F11). The attainment half is a theorem of the record, not a measurement (F2). No citation elsewhere takes L40 for the residual statement (F10).

**The gaps, in order of weight.**

1. **Direction, unstated (F1).** A supremum over a catalogue is a **lower** bound on the supremum over everything. L40 therefore yields $\sup_{\mathcal N}\theta\ge\theta^*$, while the abstract's residual needs $\sup_{\mathcal N}\theta\le\theta^*$, **the opposite direction**. The block never says which way its measurement runs, and the displayed set-builder carries **no restriction to the catalogue**, so read as written it asserts the open residual as an equality. The scope survives only in the prefatory adverbial "Over the catalogued critical points".
2. **"Three independent hunts" is one hunt (F6).** The two closure sweeps are functions of the catalogue whose outcome is *forced* by the record's own theorems (padding preserves $\theta$, $\circ$-sums strictly decrease it) so the supremum over the closure equals the supremum over the catalogue by proof, and their agreement carries no information. What remains is one biased symmetric-space list whose own $S=0$ tally contradicts the census table ten lines below it.
3. **Silent above $n=12$ (F7)**, which is exactly the range the conjecture lives in and exactly where the hypothesis-free form of this supremum is *false*.
4. **No reachable warrant (F8, F4).** The pointer names a section about the $\operatorname{tr}(W^\#)$ identity; no script or run is cited; the margin figure is traceable to nothing.
5. **The margin is round-off presented as a finding (F4)**, a failure to separate, with a sign that literally reads as non-attainment, and no bearing whatever on separation from a violator.
6. **The block does not render (F3)**, and the value $\theta^*$ never appears in it.
7. **A sibling passage states a false form of the same supremum (F9)**, unmarked, in the same file.

**The repair is local and the record already contains it.** Move the scope inside the braces, state the direction, and restore [results.md:488](../results.md#L488)'s closing sentence:

> Over the catalogued critical points, with diagonality decided by [Lemma L37](../findings/target.md#L632) rather than by frame inspection, $\sup\{\theta:W\in\mathcal C,\ Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\theta^*=\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$ and at every padding of it, attainment being exact ($\theta^2=3/2$), the agreement of the census with it being numerical to round-off. **Hence $\sup_{\mathcal N}\theta\ge\sqrt{3/2}$; the reverse inequality is the open residual, and this is a measurement over a catalogue that proves nothing about points outside it.** The catalogue reaches $n=12$; nothing above $n=12$ is measured. Corroboration is one symmetric-space hunt; the closure sweeps at $n=6$ and $n=8$ are forced by [target.md:415](../findings/target.md#L415) and are not independent evidence.

Additionally: fix the `$W_{\CP^2**$` fragment and expand `\thstar`/`\CP`; repoint the provenance line at [target.md:425](../findings/target.md#L425); and strike or scope [target.md:444](../findings/target.md#L444).

**Not REFUTED**, because the content (nothing catalogued exceeds $\sqrt{3/2}$), is consistent with the census table I read, and the attainment half is proved. **Not CONFIRMED**, because the statement as displayed asserts an open conjecture, its corroboration count is demonstrably wrong, and no artefact in the record supports its one quoted figure.

*Analysis-only footing observed throughout: no searches, sweeps, censuses or falsifier hunts were run. The arithmetic in F4 and F11 is closed-form checking of numbers already in the record, not measurement.*

