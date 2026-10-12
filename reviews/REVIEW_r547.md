# REVIEW r547, Observation L40, "the surviving target, measured"

**Target:** `findings/target.md`, `#### Observation L40` (line 662) down to the next heading of any level.
**Reviewer:** r547, cold, adversarial. Analysis-only footing inherited: no searches, sweeps, censuses or falsifier hunts; screening only, labelled as screening.

## Phase plan

1. Fix conventions against the record's anchors.
2. Read L40 verbatim; read its input L37 verbatim.
3. Audit the six attack points.
4. Grep `findings/` for restatements of the supremum and for later passages contradicting the block.
5. Verdict.

## Findings

(appended as found)

(verdict at the end of this file)

---

## The block, verbatim

> Over the catalogued critical points, decided by Lemma L37 rather than by frame inspection, $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\thstar$, **attained at $W_{\CP^2**$ and at every padding of it} (margin $-6.7\times10^{-16}$). Diagonal controls are correctly excluded, $S^5\times S^7$ at $1.228239$ among them. Three independent hunts agree: a $26$-space symmetric-space sweep, and closure sweeps at $n=6$ and $n=8$ both topping out at padded $\CP^2$.

Conventions fixed first: $\theta^*=\sqrt{3/2}=1.2247449$ ([report.tex:68](../report/report.tex#L68), [03-setup.tex:23](../report/sections/03-setup.tex#L23)), **not** the deflated $\sqrt3/2=0.8660$. $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. Padding preserves $\theta$ ([conventions.md](../findings/conventions.md)).

---

## F1, The displayed supremum is the residual's, unrestricted; only the prose is scoped, and the direction is never stated

**The set-builder inside the block is character-identical to the residual statement's.** Compare:

| where | the object |
| --- | --- |
| [00-abstract.tex:7](../report/sections/00-abstract.tex#L7), the open problem | `\sup\big\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\big\}\le\thstar` |
| [06-shape.tex:49](../report/sections/06-shape.tex#L49), the open problem | the same, verbatim |
| [target.md:666](../findings/target.md#L666), **Observation L40** | `\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\thstar` |

The catalogue restriction lives **only** in the prose preamble *"Over the catalogued critical points"*. The displayed formula quantifies over the whole set and asserts **equality**. So the block asserts, in symbols, a statement strictly stronger than the inequality the abstract calls open, a reader who lifts the display (which is exactly what lifting is invited by its being the same string) gets the residual settled.

**And the direction is never stated.** A supremum over a catalogue $\mathcal C$ contained in the true set $\mathcal N$ satisfies $\sup_{\mathcal C}\theta\le\sup_{\mathcal N}\theta$. What L40 measures is therefore a **lower bound** on the residual's supremum: it establishes $\sup_{\mathcal N}\theta\ge\theta^*$ and **nothing whatever in the $\le$ direction**. The block never says this. Its title (*"the surviving target, measured"*), says the opposite: the target is the $\le$ statement, and it is not what was measured.

**The record's own canonical statement of L40 gets this right and the findings block does not.** [results.md:488](../results.md#L488) closes with a sentence that has no counterpart in [target.md:666](../findings/target.md#L666):

> This is a measurement over a catalogue and proves nothing about points outside it.

That sentence is the whole of the correction. Its absence from the findings block is the defect.

**Screen (exact, no floating point):** the $\ge$ direction is real. $W_{\mathbb{CP}^2}$ is Ricci-flat on its $4$-plane and stays so under zero-padding, so $\theta=\theta^*$ at every $n\ge4$ ([05-landscape.tex:24](../report/sections/05-landscape.tex#L24)), and it is non-diagonal with $S=0$. So $\sup_{\mathcal N}\theta\ge\theta^*$ is a theorem. **The measurement adds nothing to that direction, and reaches the other direction not at all.**

## F2, "Three independent hunts agree" is contradicted by this file 247 lines above it, and by the report's own status table

The block's evidential clause is:

> Three independent hunts agree: a $26$-space symmetric-space sweep, and closure sweeps at $n=6$ and $n=8$ both topping out at padded $\CP^2$.

**[target.md:419](../findings/target.md#L419), in the same file, strikes the $n=6$ enumeration outright:**

> `reviews/REVIEW_r78.md` was **never written**, and this file linked to it twice, so the $\sim20$-subalgebra sweep and the 3000-start Newton run have no artefact. […] Reviewer 80 reproduced the artefact, 1200 starts, 651 converged, maximum $\theta$ found $0.408$, $\mathbb{CP}^3$ never appearing. **Random-start Newton on $\mathrm{Weyl}_6$ does not reach the high-$\theta$ basin, so such an enumeration is evidence of completeness in neither direction.** *The bound still stands on Reviewer 80's own 26-space hunt, where $S=0$ holds only at $\mathbb{CP}^m$ and $\mathbb{HP}^2$ and nothing exceeds $\sqrt{3/2}$.*

Note the last clause: **one** hunt, not three.

**[report/sections/09-status.tex:120](../report/sections/09-status.tex#L120) records the same withdrawal as a struck row:**

> The $\sim20$-subalgebra sweep and the $3000$-start Newton run & \textbf{Struck}, their evidence being unreproducible; the two claims resting on them are withdrawn, and the census's bound stands instead on a $26$-space hunt

**And the two "closure sweeps" have no artefact anywhere.** The string *"closure sweep"* occurs in exactly three places in the repository, [target.md:666](../findings/target.md#L666), [results.md:488](../results.md#L488), [07-gradedness-split.tex:808](../report/sections/07-gradedness-split.tex#L808), all three being the same sentence. No script in [scripts/INDEX.md](../scripts/INDEX.md) carries one; the nearest, [b_critpoint_hunt.py](../scripts/route-b/b_critpoint_hunt.py), is indexed as running at $n=10$ and $n=12$ and as *"explicitly not evidence of absence"*.

**Independently, the word "independent" fails on its own terms.** [ELIM-target.md:161](ELIM-target.md#L161) already logged this: *"A symmetric-space sweep is a biased sample by construction, and closures of catalogued points are the catalogue. Two of the three are not independent of each other."* The closure of a catalogue under padding and $\circ$-orthogonal sums is a construction *from* the catalogue, so it cannot corroborate the catalogue.

**Verdict on this clause: the claim of three independent agreeing hunts is unsupported, and one of the three is explicitly withdrawn by the same file.** The defensible sentence is the one at [target.md:419](../findings/target.md#L419): the bound stands on the $26$-space hunt alone.

## F3, The mangled LaTeX, and what it was meant to say

The block reads

> **attained at $W_{\CP^2**$ and at every padding of it}

Two defects compound. The bold delimiter `**` has been swallowed into the math subscript in place of the closing brace: the intended text is `**attained at $W_{\CP^2}$ and at every padding of it**`, which is what [07-gradedness-split.tex:808](../report/sections/07-gradedness-split.tex#L808) and [results.md:488](../results.md#L488) both carry correctly. Separately `\CP` and `\thstar` are `report/` macros with no Markdown definition ([report.tex:68](../report/report.tex#L68)), so the whole sentence renders as literal source. Already logged at [ELIM-target.md:189](ELIM-target.md#L189) and [REVIEW_r521.md:135](REVIEW_r521.md#L135); **still present**.

**Is the intended claim supported?** The two halves separate:

- *"attained at $W_{\mathbb{CP}^2}$"*, **supported, and by proof rather than measurement.** $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ exactly ([05-landscape.tex:24](../report/sections/05-landscape.tex#L24), [03-setup.tex:23](../report/sections/03-setup.tex#L23)).
- *"and at every padding of it"*, **supported, and also by proof**: padding commutes with $Q$ and preserves norm and $\theta$ ([conventions.md](../findings/conventions.md)). But *"every padding"* is an infinite family, so this half of the sentence is **not** a statement over the catalogue at all. A sentence whose frame is *"Over the catalogued critical points"* is here carrying a clause about infinitely many uncatalogued ones.

## F4, The margin $-6.7\times10^{-16}$ certifies a failure to separate, not an equality

At $\theta^*=1.2247449$ the machine epsilon of double precision is $2.2\times10^{-16}$, so $6.7\times10^{-16}$ is **three ulp**. What that number can and cannot support:

| claim | does the margin support it |
| --- | --- |
| no catalogued non-diagonal $S=0$ point was *computed* above $\theta^*$ | **yes**, that is exactly what it says |
| no catalogued non-diagonal $S=0$ point *is* above $\theta^*$ | **no**, an excess anywhere below $\sim10^{-15}$ is invisible to it |
| the supremum is *attained* at $W_{\mathbb{CP}^2}$ | **no, and it is not needed**, attainment is the exact value $\sqrt{3/2}$ (F3), a theorem |
| the supremum *equals* $\theta^*$ rather than exceeding it | **no**, see the row above it |

**The block presents a theorem and a measurement as one measurement.** The $\ge\theta^*$ half is exact and needs no margin; the $\le\theta^*$ half over the catalogue is the only part the margin bears on, and there it certifies *agreement to roundoff*, which is the weakest reading of a two-sided numerical comparison. The block's negative sign compounds the ambiguity: it does not say what the margin is a margin *of*, the gap from the runner-up to $\theta^*$, or roundoff at the maximiser itself. Under the second reading (and the paddings of $W_{\mathbb{CP}^2}$ all sit at $\theta^*$ exactly, so the "runner-up" is a tie) it says nothing about separation from any other point at all.

**Contrast the record's own standard for a value at this margin.** [target.md:494](../findings/target.md#L494) reports $S^5\times S^7$ as built over $\mathbb Q$, with $\theta^2=264/175$ and excess $3/350$, explicitly noting *"no floating point is load-bearing"*. L40's headline number is held to no such standard.

## F5, The diagonal controls check out; the sentence is sound

Full sentence, read whole:

> Diagonal controls are correctly excluded, $S^5\times S^7$ at $1.228239$ among them.

**Screen (exact rationals, seconds of arithmetic, reported as a screen).** The record's closed form, derived independently by two reviewers at [target.md:494](../findings/target.md#L494), is $\theta^2(S^p\times S^q)=\frac{2(p-1)(q-1)(n-1)}{pq(n-2)}$. I re-derived it from the record's own anchor rather than taking it: at $p=q=n/2$ it must return $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and it does. Then

- $S^5\times S^7$, $n=12$: $\theta^2=\frac{2\cdot4\cdot6\cdot11}{35\cdot10}=\frac{264}{175}$, $\theta=1.2282392$. Excess over $3/2$ is $3/350$. ✓ block's $1.228239$.
- $S^4\times S^8$: $\frac{2\cdot3\cdot7\cdot11}{32\cdot10}=1.44375$, $\theta=1.201561$ ✓ [07-gradedness-split.tex:121](../report/sections/07-gradedness-split.tex#L121)'s $1.20156$.
- $S^3\times S^9$: $\theta=1.141799$ ✓ its $1.14179$.

So the control is real: $S^5\times S^7$ has $S=0$ and $\theta>\theta^*$, and only diagonality removes it. **This is the block's strongest sentence**, it establishes that diagonality, not $S$, is the load-bearing hypothesis, and it does so on an exactly-computed witness. It is also the one part of the block that is a genuine *negative* control on the measurement.

## F6, The use of Lemma L37 is within what L37 gives, but the decision is tolerance-dependent and the block does not say so

**The equivalence, restated from [results.md:470](../results.md#L470):** with $\delta_A(X)=AX+XA$ and $\Phi_W(A)=[W,\delta_A]$, $W$ is diagonal in some orthonormal frame **iff** $\ker\Phi_W$ contains an $A$ whose eigenvalue sums $a_i+a_j$ are pairwise distinct. Corollary: $\dim\ker\Phi_W<n\Rightarrow$ non-diagonal.

**Derived cold, both directions.** If such an $A$ exists, $\delta_A$ has $\binom n2$ distinct eigenvalues on $\Lambda^2$ in $A$'s eigenframe, so its eigenlines are exactly the $\varphi_{ij}$; $[W,\delta_A]=0$ then forces $W$ to preserve each, i.e. $W$ diagonal in that frame. Conversely if $W$ is diagonal in a frame, take $A=\operatorname{diag}(1,2,4,\dots,2^{n-1})$ there (binary expansions give pairwise-distinct sums) and $\Phi_W(A)=0$. Sound.

**The block uses the equivalence, not the corollary, and says so**, *"decided by Lemma L37 rather than by frame inspection"*. That is the direction the record's earlier reviewers also cleared ([REVIEW_r522.md:79](REVIEW_r522.md#L79): *"L40 needs the iff, not the corollary, and says so"*).

**At $\dim\ker\Phi_W\ge n$, where the corollary is silent, the equivalence still decides, and the record does it correctly.** [target.md:454](../findings/target.md#L454) works exactly this case for $\mathbb{CP}^2{+}\mathbb{CP}^2$ at $n=12$, where $\dim\ker\Phi=12=n$: every $A$ in the kernel has $a_1=a_2=a_3=a_4$, hence $a_1+a_2=a_3+a_4$ identically, so no distinct-sum $A$ exists and the point is non-diagonal. **Structurally this is right**: $\ker\Phi_W$ is a linear subspace and the distinct-sums condition fails on a finite union of hyperplanes $\{a_i+a_j=a_k+a_l\}$, so either the subspace lies inside one (no $A$ exists, non-diagonal) or a generic element avoids all of them. **The predicate is decidable from one generic draw.** No frame search is needed, which is what L37 supplies. Within scope.

**Where it thins.** *"Decided by Lemma L37"* reads as exact. In execution the decision is a numerical kernel plus a numerical distinct-sums test, and the record documents that exact test producing a **false non-diagonal**: [target.md:213 region / scripts index:213](../scripts/INDEX.md#L213) records the certificate *"removed"* after *"a diagonal Weyl tensor with an eigenvalue gap of $3\times10^{-9}$, rotated, read as NON-DIAG"*. That error mode is precisely the one that would break L40: a diagonal sphere product misread as non-diagonal drops a $\theta>\theta^*$ point onto the non-diagonal side and falsifies the $=\theta^*$. The hole was corrected, but **a claim whose margin is three ulp rests on a tolerance-based classifier that has demonstrably mis-classified once**, and the block does not mention the tolerance at all.

## F7, The six citations: five safe, and the overstatement sits outside them

| citation | what it takes from L40 | verdict |
| --- | --- | --- |
| [results.md:31](../results.md#L31) | *"every non-diagonal critical point **on the record** sits at or below $\sqrt{3/2}$"* | **safe**, scoped to the record |
| [results.md:65](../results.md#L65) | *"Everything measured agrees (Observation L40) and **nothing proves it**"* | **safe**, states the gap outright |
| [results.md:166](../results.md#L166) | *"Over **every catalogued** critical point…"* | **safe** |
| [results.md:470](../results.md#L470) (L37's block) | *"the criterion by which Observation L40 separates the two sides"* | **safe**, about the criterion, not the value |
| [results.md:486–488](../results.md#L488) | the full block, closing *"This is a measurement over a catalogue and proves nothing about points outside it"* | **safe, and the model statement** |
| [plan-verification.md:96](../plan-verification.md#L96) | a checklist row | **safe** |

**No citation makes the second move.** The overstatement is not in the citations, **it is in the block itself (F1) and in one untagged restatement in the abstract.**

### The abstract's clause

[00-abstract.tex:9](../report/sections/00-abstract.tex#L9), two lines below the display calling the residual open:

> It is well posed because non-diagonality is $O(n)$-invariant, and \emph{decidable} without a frame search (Lemma~37), and under it **the supremum is \emph{attained}, at $W_{\CP^2}$**.

**Read literally, this asserts the residual.** "The supremum" here has no catalogue qualifier and can only mean $\sup_{\mathcal N}\theta$ over the set displayed two lines above. If that supremum is attained at $W_{\mathbb{CP}^2}$ then it equals $\theta^*$, and the inequality declared open is proved. **The abstract offers as a reason the statement is well posed a claim that would settle it.**

**And attainment is a substantive open claim, not a compactness triviality.** The diagonal locus is compact, hence closed, so $\{W\text{ non-diagonal}\}$ is **open**; intersected with the closed set $\{Q(W)=\theta W,\ S=0\}$ on the unit sphere it is **not compact**. A sequence of non-diagonal critical $S=0$ points may converge to a diagonal one, and the record supplies exactly the endpoints that would matter, $S^6\times S^6$ at $\theta_0(12)=1.236033>\theta^*$. **Nothing in the record rules that out**; ruling it out *is* the residual.

*The charitable reading* ("the bound is sharp, $\theta^*$ being realised inside the set by $W_{\mathbb{CP}^2}$"), is true and provable. But the words say the supremum is attained, and the same paragraph already corrected its neighbouring "well posed" reason once today. **This clause needs the same treatment**: replace with "and the bound would be sharp, $W_{\mathbb{CP}^2}$ lying in the set at exactly $\theta^*$."

## F8, An unscoped restatement inside `target.md` itself

[target.md:445](../findings/target.md#L445), 221 lines above the block, under the heading *"The bound is untouched"*:

> **$\sup\{\theta:S=0,\text{ non-diagonal}\}=\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$, survives.**

**No catalogue qualifier, in bold, asserted as equality.** It is the residual with criticality dropped as well, and [00-abstract.tex:9](../report/sections/00-abstract.tex#L9) records that dropping criticality makes the statement **false at every even $n\ge12$**. Read as written this line is refuted by the record's own witness. Read as intended (criticality implicit, catalogue implicit) it is F1 again, in a stronger form.

Related: **the block's argument pointer is wrong.** It names *"The totally-summed vertex equation is an identity, and the reason is p"* as where its argument lives; that section is the $\operatorname{tr}(W^\#)$ identity at [target.md:27](../findings/target.md#L27) and has nothing to do with the census. The supporting material is at [target.md:419–466](../findings/target.md#L419). Already logged at [ELIM-target.md:181](ELIM-target.md#L181); still present.

## F9, NEW: the point at which the supremum is "attained" satisfies $S=0$ only vacuously, by the record's own trap W4

[INDEX-traps.md:22](../findings/INDEX-traps.md#L22), warning **W4**, names L40's maximiser by name:

> **W4** | **the gradedness screen is vacuous when $\ker W\ne0$** | it traces only over $E_\pm$, so a point whose kernel carries most of $\mathfrak{so}(n)$ reports $S=0$ while admitting no grading; **padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$**. Trust it only at $\ker W=0$

And [conventions.md](../findings/conventions.md) makes the warning mandatory: *"$S(W)$, the gradedness slack. **Read [W4](INDEX-traps.md) before using it**: the screen is vacuous when $\ker W\ne0$."*

**So the very points L40 names as attaining the supremum ($W_{\mathbb{CP}^2}$ and *every* padding of it), are the points at which the record says $S=0$ carries no information.** At $n=12$ the reported $S=0$ is a trace over $3$ of $66$ dimensions.

**How far this bites.** If $S$ is read as the literal traced slack, membership is fine and this is a caveat on interpretation rather than a defect in the set. But it means:

- L40's headline says nothing about the **graded** half of the critical set, which is where [Lemma L69](../report/sections/00-abstract.tex#L5) does its work, the measurement's maximiser is graded in no sense W4 will certify.
- *"attained at $W_{\mathbb{CP}^2}$ and at every padding of it"* is the **weakest available witness** for "the supremum over $\{S=0\}$ is attained": every point in the attaining family satisfies the defining constraint vacuously.
- **The block cites neither W4 nor the kernel**, though [conventions.md](../findings/conventions.md) requires W4 to be read before $S$ is used at all, and the block uses $S$ in its central display.

*This was not raised on L40 by [r521](REVIEW_r521.md), [r522](REVIEW_r522.md) or [ELIM-target.md](ELIM-target.md).*

## F10, Two smaller items, recorded in passing

**A seventh unqualified "attained".** [findings/INDEX.md:23](../findings/INDEX.md#L23) carries *"**Open**, well posed since the $\ker\Phi_W$ test; attained at $W_{\mathbb{CP}^2}$"* with no catalogue qualifier, the same move as [00-abstract.tex:9](../report/sections/00-abstract.tex#L9) (F7). It needs the same fix.

**A latent basis trap on L40's own maximiser.** [03-setup.tex:23](../report/sections/03-setup.tex#L23) writes $W_{\mathbb{CP}^2}$ as *"$\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\R^4$"*. That is the self-dual/anti-self-dual basis, **not** the coordinate pair basis, and [conventions.md](../findings/conventions.md) warns in terms: *"'Diagonal' means diagonal in coordinate $2$-planes $e_i\wedge e_j$ … not diagonal as an operator on $\Lambda^2$."* Read literally in the pair basis, that display makes $W_{\mathbb{CP}^2}$ **diagonal**, which would empty L40's set of its maximiser outright. The correct fact is the one at [target.md:510](../findings/target.md#L510): the simple top eigenvector is $(e_1\wedge e_2+e_3\wedge e_4)/\sqrt2$, of bivector rank $4$, hence non-diagonal in every frame. The setup section should say which basis it is writing in.

**A digit inconsistency.** [findings/INDEX.md:23](../findings/INDEX.md#L23) gives the even-$n$ falsifier at $\theta=1.236031$; $\theta_0(12)=\sqrt{220}/12=1.23603308$, and [06b-bispectral.tex:123](../report/sections/06b-bispectral.tex#L123) gives $1.236033$. Cosmetic, outside the target, noted only because it is the value that decides F8.

---

## What survives, and what does not

| clause of the block | status |
| --- | --- |
| $\sup$ over the catalogue $=\theta^*$ | **likely true**, standing on the $26$-space hunt alone; the *displayed* form asserts it over the full set (F1) |
| attained at $W_{\mathbb{CP}^2}$ and every padding | **true, and a theorem rather than a measurement** (F3, F4); but the attaining family satisfies $S=0$ only vacuously (F9) |
| margin $-6.7\times10^{-16}$ | **three ulp**, certifies agreement to roundoff, not separation, and the block does not say what it is a margin of (F4) |
| diagonal controls correctly excluded, $S^5\times S^7$ at $1.228239$ | **CONFIRMED exactly** over $\mathbb Q$: $\theta^2=264/175$, excess $3/350$ (F5) |
| decided by Lemma L37 rather than by frame inspection | **within scope**, equivalence not corollary, sound at $\dim\ker\Phi_W\ge n$ (F6); silent about the tolerance the decision actually runs on |
| "Three independent hunts agree" | **FALSE as written**, the $n=6$ run is struck by [target.md:419](../findings/target.md#L419) and [09-status.tex:120](../report/sections/09-status.tex#L120); the two "closure sweeps" have no artefact anywhere; and the three are not independent ([ELIM-target.md:161](ELIM-target.md#L161)) (F2) |
| title, *"the surviving target, measured"* | **overstates**, the target is the $\le$ statement; a catalogue supremum bounds the true supremum from **below** and reaches the $\le$ direction not at all (F1) |

## The single sentence that fixes the block

Replace the block with [results.md:488](../results.md#L488)'s wording, which already carries the disclaimer, and cut the evidential clause to what stands:

> Over the catalogued critical points of $\mathcal W_n$ (Reviewer 80's $26$-space symmetric-space hunt), with diagonality decided by the equivalence of Lemma L37 rather than by frame inspection, the largest $\theta$ among non-diagonal points with $S=0$ is $\sqrt{3/2}$, agreeing with the exact value at $W_{\mathbb{CP}^2}$ to three ulp. That value is attained there and at every zero-padding, by the exact computation rather than by this measurement; **at all of those points $\ker W\ne0$, so trap W4 applies and $S=0$ is vacuous there**. Diagonal points are excluded by the criterion, $S^5\times S^7$ at $\theta^2=264/175$ among them, which is why diagonality rather than $S=0$ is the load-bearing hypothesis. **A supremum over a catalogue bounds the residual's supremum from below; this measurement proves nothing in the $\le$ direction and nothing about points outside the catalogue.**

And at [00-abstract.tex:9](../report/sections/00-abstract.tex#L9), replace *"and under it the supremum is attained, at $W_{\CP^2}$"* with *"and the bound would be sharp, $W_{\CP^2}$ lying in the set at exactly $\thstar$"*, likewise at [findings/INDEX.md:23](../findings/INDEX.md#L23).

---

VERDICT: PLAUSIBLE

**The measurement is sound; the label, the display and the warrant all overstate it.**

- **Sound:** the diagonal control is exact and correct (F5); the use of Lemma L37 is inside what L37 gives, including where its corollary is silent (F6); attainment at $W_{\mathbb{CP}^2}$ and its paddings is a theorem (F3); no citation of L40 takes the catalogue supremum for the residual (F7).
- **Named gaps, in order of severity:**
  1. **The evidential clause is false.** *"Three independent hunts agree"*, two of the three are struck or unsourced by the record itself (F2). This is a broken step inside the block, not a scope quibble.
  2. **The displayed set-builder is the residual's, unrestricted, with $=$ rather than $\le$** (F1). The catalogue qualifier sits in prose beside a formula that contradicts it, and the direction (catalogue supremum is a **lower** bound on the residual's), is stated nowhere in the block, though [results.md:488](../results.md#L488) states it plainly.
  3. **The attaining family satisfies $S=0$ vacuously by trap W4** (F9), which [conventions.md](../findings/conventions.md) requires be read before $S$ is used, and which the block does not cite. New here.
  4. **The margin is three ulp** and certifies failure to separate rather than equality (F4).
  5. **Outside the block:** [00-abstract.tex:9](../report/sections/00-abstract.tex#L9)'s *"under it the supremum is attained, at $W_{\CP^2}$"* asserts, as a reason the residual is well posed, a claim that would **settle** the residual, and attainment is genuinely open, the non-diagonal set being open and its intersection with the critical set therefore non-compact, with $S^6\times S^6$ at $\theta_0(12)=1.236033>\theta^*$ sitting on the diagonal boundary (F7).

**Not REFUTED**, because the headline value over the catalogue survives on the $26$-space hunt, which the record has not withdrawn, and every number in the block that can be checked exactly checks out. **Not CONFIRMED**, because a sentence of the block is false against the record's own status table and the block's title claims a direction the measurement cannot run.
