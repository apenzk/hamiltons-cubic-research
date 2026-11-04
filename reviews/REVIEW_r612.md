# Review r612, Conjecture L6 (the zero-defect set, and why it hides no rival)

Reviewer r612, independent adversarial audit. Target: `Conjecture L6` at [findings/curvature-invariants.md](../findings/curvature-invariants.md) lines 89–97 (the block runs to the end of the file), with its statement copy at [results.md](../results.md) lines 324–328 and its glance line at [results.md](../results.md) line 120. Worked from [findings/conventions.md](../findings/conventions.md) and the definitions alone; the record is not assumed correct. The concurrent reviewer on this brief (r611) was not read, nor their log or report.

Standing rule for this audit: **analysis only**. No sweep, census, optimisation or falsifier hunt was run. One screen appears below, a few seconds of closed-form arithmetic, run to check a threshold comparison I was about to record. It is reported as a screen and never as evidence for a positive claim. Every positive claim below is a derivation or a quotation of the record.

## Verdict

**REFUTED as written, on a notation collision the brief warned about.** The block sits under, and inherits, the definition of the **symmetry defect** $\Delta(W)=\sum_{\delta\in\mathfrak p}\lVert[\mathrm{ad}(v_\delta),W]\rVert^2$ displayed three lines above it. Every quantitative claim it makes, codimension $\binom n4$, the symmetric family, the symmetry-free remainder, the unitary-factor hinge, belongs to the **Bianchi defect** $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ of [Observation L15](../findings/problem.md), a different object. Under the defect the block's own file defines, the headline is refuted by a witness the record already holds; under the defect the block silently means, the codimension survives with three qualifiers stripped and the hinge has a hole at exactly the dimensions the conjecture is about.

| clause | reading forced by the file ($\Delta$) | reading the content means ($\delta^2$) |
| --- | --- | --- |
| "the defect vanishing is **exactly** the condition under which the diagonal argument transfers unchanged" | not the condition at all | **REFUTED**, this is what [Observation L15](../results.md) was refuted for at Gate 2 |
| "zero defect precisely on the diagonal orbit, is false" | does not parse: the diagonal locus is **not contained** in $\{\Delta=0\}$ | **CONFIRMED**, with witnesses on the record |
| "the set has codimension $\binom n4$" | **REFUTED**, codimension $4$ at $n=4$ against $\binom44=1$, and the set is not equidimensional | **CONFIRMED as a generic, numerically measured rank**; the block drops "generic", drops "measured", and drops the singularity at the diagonal locus |
| "all of them sit low … reaching $\sqrt{3/2}$ would demand … a unitary factor, which reintroduces the defect" | **REFUTED** by padded $W_{\mathbb{CP}^2}$: $\Delta=0$, $\theta=\sqrt{3/2}$ exactly | **GAP**, the subalgebra enumeration behind the hinge is incomplete at every even $n\ge12$ and again at $n=8$ |
| "for the symmetry-free remainder it is tested rather than proven" | the remainder is **empty** under $\Delta$ | **GAP**, correctly self-declared, but the sample size is suppressed |
| provenance note | **REFUTED in both clauses**, checked against `git` | same |
| heading "canonical statement and proof" | **no proof is present**, and the derivation sits in a file the record bars from holding one | same |

The label `Conjecture` is right for the bundle. The block is a mixture, and the strongest part of it (the codimension) is not a `Conjecture` but an `Observation` at the dimensions named.

## 0. Notation, fixed before deriving

[conventions.md](../findings/conventions.md) tables $\Delta$ as *"the symmetry defect. Discontinuous at eigenvalue zero-crossings, and traced over $\{\lambda>0\}$ only"*, sourced to [diagonal-half.md](../findings/diagonal-half.md). It is **not** $\delta^2$. The record carries two distinct defects:

- **$\Delta$, the symmetry defect.** $g_\gamma:=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$, [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7, traced over $\mathfrak p=\mathrm{span}\{v_\alpha:\lambda_\alpha>0\}$. This is the quantity defined in the three lines immediately above the L6 heading.
- **$\delta^2$, the Bianchi defect.** $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ with $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, from [Observation L15](../findings/problem.md).

They are different objects with different zero sets, and the difference is decided by a single point below (§3.1). [conventions.md](../findings/conventions.md) already tables $\Pi$, $B$, $M$, $\mathfrak m$, $d$ and $\mu$ as letters carrying more than one object; **$\Delta$ against $\delta$ is a seventh such collision and is not tabled.** It should be.

## 1. Is it a `Conjecture`, and does the heading's promise hold?

### 1.1 The proposition, stated properly

The block never states one. Reconstructed, in the reading its content forces:

> **Proposition (L6, as meant).** Let $\mathcal A_n:=\{W\in\mathcal W_n:\mathrm{Alt}(W_-)=0\}$. Then (i) $\mathcal A_n\supsetneq O(n)\cdot\{\text{coordinate-diagonal}\}$, strictly, and contains non-diagonalisable critical points; (ii) at a generic point of $\mathcal A_n$ the differential of $F(W)=\mathrm{Alt}(W_-)$ has full rank $\binom n4$, so $\dim\mathcal A_n=\dim\mathcal W_n-\binom n4$ there; (iii) **conjecturally**, $\sup\{P(W):Q(W)=\theta W,\ W\in\mathcal A_n,\ W\ \text{non-diagonal}\}<\Theta_n$ for $n\ge12$.

Clause (iii) is the whole content, it is the statement [LEDGER.md](../findings/LEDGER.md) records as *"the threshold form of the Jäger §3.2 dichotomy is unproven"*. Clauses (i) and (ii) are settled facts of a different grade. **Grading the bundle as one `Conjecture` hides that (i) is proven and (ii) is an `Observation` at $n=6,7,8,12$.**

### 1.2 What is proven and what is conjectured, clause by clause

| clause | true grade | why |
| --- | --- | --- |
| $\mathcal A_n$ strictly exceeds the diagonal orbit | **Lemma** | [ATTEMPTS.md](../ATTEMPTS.md) Result 1(c) gives $\mathcal A_n\supseteq\{W:(\Lambda^4\mathbb R^n)^{\mathrm{Stab}(W)}=0\}$, an argument, and Result 3 exhibits six non-diagonalisable members with a **proof** of non-diagonalisability (the positive eigenspace is an adjoint image, $\mathrm{rank}\,\mathrm{ad}_Z\ge4$) |
| codimension $\binom n4$ | **Observation at $n=6,7,8,12$** | a measured generic rank of a numerical differential, with a recorded non-uniformity |
| symmetric family sits below $\sqrt{3/2}$ | **conditional Lemma**, see §3.2 | rests on a closed form that is proven, an inversion that is arithmetic, and a subalgebra enumeration that is **incomplete** |
| symmetry-free remainder sits low | **Conjecture** | the block says so; the record says so ([LEDGER.md](../findings/LEDGER.md)) |

So the label `Conjecture` covers the weakest part, as the record's convention requires, but the block gives a reader no way to see that three quarters of it is stronger than the label.

### 1.3 The provenance note, checked against `git`, and false in both clauses

The note reads *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here."*

I pickaxed the block's distinctive phrase (`hoped-for clean answer`) across all refs, then read the tree at the move commit's parent.

- The move is commit `a9e4b8c0` *(refactor(results): the proofs move to findings, results.md states and points)*, Mon 31 Aug 2026. Confirmed.
- **"the only copy" is false.** At `a9e4b8c0^`, `git grep` on the codimension phrase returns four other files: [ATTEMPTS.md](../ATTEMPTS.md) lines 706, 729, 739, which held the **entire derivation**, Results 1–7, the characterisation $\mathcal A_n=\{A-B:A,B\succeq0\ \text{Bianchi},\,AB=0,\,\mathrm{Ric}(A)=\mathrm{Ric}(B)\}$, the rank table, the closed form, and a caveat the block drops; [report/sections/90-appendix.tex](../report/sections/90-appendix.tex) line 83, which held the summary in almost the block's own words; and [reviews/REVIEW_r8.md](REVIEW_r8.md) line 13, which had already audited the codimension. `results.md` held a **four-sentence summary**, not an argument.
- **"That file now carries the statement and points here" is a circular pointer.** [results.md](../results.md) line 326 carries the block's **first paragraph verbatim** and then says `**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)`, while this block says the argument was moved out of `results.md`. Neither file holds a proof.
- **The move was a copy, not a move**, exactly as [r595](REVIEW_r595.md)/[r596](REVIEW_r596.md) found for the sibling `Lemma L13` in this same file under the identical note.

**Where the argument actually lives: [ATTEMPTS.md](../ATTEMPTS.md), §"The Bianchi-defect set $\mathcal A_n$", Results 1–7.** The record bars [ATTEMPTS.md](../ATTEMPTS.md) from carrying a numbered result's proof, so **transcription into [findings/](../findings/) is owed**, as it was for L13. This is the second false provenance note of this shape found in this file; the brief's warning to *check rather than assume in either direction* was warranted, and the check went against the note.

### 1.4 The heading's promise

*"canonical statement and proof"*. The block is three short paragraphs of prose. It displays no equation, no hypothesis, no inference. Unlike the L13 case it is not byte-identical to its `results.md` copy (it carries one extra paragraph) but that extra paragraph is a summary of a conclusion, not a step of an argument. **The promise does not hold.** Either the heading loses "and proof", or Results 1–7 are transcribed.

## 2. The codimension

### 2.1 Under the Bianchi reading, confirmed, with three qualifiers the block strips

$\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$ ([conventions.md](../findings/conventions.md)), so $F(W)=\mathrm{Alt}(W_-)$ maps $\mathcal W_n$ into a space of dimension $\dim\Lambda^4\mathbb R^n=\binom n4$. Hence, wherever $F$ is differentiable,

$$\mathrm{codim}\,\mathcal A_n\ \le\ \binom n4$$

**unconditionally**, and "codimension $\binom n4$" is the statement that the differential attains that maximum. So the number is **the dimension of the target space**, not an independently derived count of relations. It is *the* number of equations; the content is only that they are independent.

That independence is established numerically and nowhere else: [ATTEMPTS.md](../ATTEMPTS.md) Result 2 solves $F=0$ by Gauss–Newton and measures $\mathrm{rank}\,dF=15,70,495$ at $n=6,8,12$, matching $\binom n4$; [REVIEW_r8.md](REVIEW_r8.md) reproduces $15,35,70$ at $n=6,7,8$ by central differences. Three qualifiers travel with it in the source and none reaches the block:

1. **Generic, not uniform.** [ATTEMPTS.md](../ATTEMPTS.md)'s *"Caveat on the dimension estimate"* records the rank as point-dependent ($\binom n4$ at symmetric outputs, but $6,10,15$ at low-symmetry rotated sphere products) and says in terms that *"the codimension-$\binom n4$ figure in Result 2 should therefore be read as the **generic** value, not a uniform one."* The block writes *"The set has codimension $\binom n4$"* flatly.
2. **The diagonal locus sits at singular points.** Result 2's own refinement: at sphere products the rank drops to $\binom p2\binom q2$. So the codimension fails exactly on the locus L6 is comparing against.
3. **$F$ is not smooth.** $W\mapsto W_-$ is only Lipschitz; it is non-differentiable across the zero-eigenvalue locus, which is precisely where [route-a.md](../findings/route-a.md) records $\delta^2$ carrying an **atom**. Padded $W_{\mathbb{CP}^2}$, the record's rival maximiser, sits on that locus. "Codimension" is therefore a statement about the smooth stratum only.

**Verdict on clause 3, Bianchi reading: CONFIRMED as an `Observation` at $n=6,7,8,12$, with "generic" restored.** It is not a `Lemma`, no proof that $dF$ is generically surjective exists on the record, and producing one is a real (and I think reachable) piece of work: the natural route is Result 1(c)'s equivariance, showing $\mathrm{Alt}\circ D(W\mapsto W_-)$ surjects onto $\Lambda^4$ at a point of trivial stabiliser.

### 2.2 Under the symmetry reading, refuted at $n=4$

Take the file's own $\Delta$. Since $g$ is a sum of squares, $\Delta(W)=0\iff[\mathrm{ad}(v_\delta),W]=0$ for every positive eigenvector, i.e. $\mathfrak p\subseteq\mathfrak k(W)$, the isotropy algebra. This is [Lemma L106](../findings/bounds.md), which I rebuilt independently before reading it. Two immediate consequences:

- $\mathrm{ad}(x)$ for $x\in\mathfrak p$ preserves every eigenspace of $W$, so **$\mathfrak p$ is a Lie subalgebra** and $W$ is $\mathfrak p$-invariant. The condition is a *rigidity* condition, not a codimension-$\binom n4$ slice.
- $\mathop{\mathrm{tr}}_{\Lambda^2}W=\tfrac12\mathop{\mathrm{scal}}=0$ on a Weyl operator, so every $W\ne0$ has $\mathfrak p\ne0$, hence $\dim\mathfrak k(W)\ge1$: **every zero-$\Delta$ point has positive-dimensional isotropy.**

Now $n=4$, where the count is checkable by hand. $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ as ideals, $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, and $W=W^+\oplus W^-$ with each $W^\pm$ traceless symmetric on the $3$-dimensional $\Lambda^\pm$; $\dim\mathcal W_4=5+5=10$, matching [conventions.md](../findings/conventions.md)'s $n(n-3)(n+1)(n+2)/12$. For $x=x_++x_-$, $\mathrm{ad}(x)$ acts on $\Lambda^\pm$ as $\mathrm{ad}(x_\pm)$, i.e. as $x_\pm\times(\cdot)$ under $\Lambda^\pm\cong\mathbb R^3$. Let $v\in\Lambda^+$ be a positive eigenvector of $W^+$. Then

$$[\mathrm{ad}(v),W]=0\iff[v\times,W^+]=0\iff W^+\ \text{is invariant under rotation about}\ v\iff W^+=\alpha\big(vv^{\mathsf T}-\tfrac12(I-vv^{\mathsf T})\big),$$

and $v$ being a **positive** eigenvector forces $\alpha>0$, i.e. $\mathrm{spec}(W^+)\propto(2,-1,-1)$. Conversely such a $W^+$ has a one-dimensional positive eigenspace, spanned by $v$, and the condition holds. If instead $W^+$ has two positive eigenvalues, two independent rotation generators must centralise it, and the centraliser of a $2$-dimensional subspace of $\mathfrak{so}(3)$ is all of $\mathfrak{so}(3)$, forcing $W^+$ scalar, hence $0$. So

$$\{\Delta=0\}\cap\mathcal W_4=\big\{W^+\oplus W^-:\ \text{each of}\ W^\pm\ \text{is}\ 0\ \text{or has spectrum}\ \propto(2,-1,-1)\big\}.$$

The set of traceless symmetric $3\times3$ matrices with a repeated eigenvalue and positive simple one is parametrised by an axis in $\mathbb{RP}^2$ and a scale: dimension $3$ inside the $5$-dimensional $S^2_0(\mathbb R^3)$. Hence the strata of $\{\Delta=0\}$ have dimensions $6$ (both blocks nonzero) and $3$ (one block zero), against $\dim\mathcal W_4=10$:

$$\mathrm{codim}\big(\{\Delta=0\}\big)\Big|_{n=4}\ =\ 4\quad\text{on the top stratum},\qquad\binom44=1 .$$

**REFUTED, by a factor of four**, and the set is **not equidimensional**, so "the codimension" is not even a well-defined quantity under this reading. Two further $n=4$ observations, both confirming that the block is not about $\Delta$:

- The whole zero-$\Delta$ set at $n=4$ consists of $\mathbb{CP}^2$-type operators and their sums. The **diagonal locus is not inside it**, a coordinate-diagonal $W$ with distinct sectional entries has $W^\pm$ of generic spectrum, so $\Delta>0$. [diagonal-half.md](../findings/diagonal-half.md) line 96 says the same at every $n$, from the other direction: on the diagonal locus $\Delta=0$ is a strict condition (positive edges must join twins), and the $C_5$ blow-up is diagonal with $\Delta=12$. **So the block's "the hoped-for clean answer, zero defect precisely on the diagonal orbit" does not even parse under $\Delta$**: the two sets are incomparable, and the record's *"$\Delta=0$ is already the generalised sphere-product shape"* is the true statement on that locus.
- The block's *"symmetry-free"* family cannot exist under $\Delta$. [ATTEMPTS.md](../ATTEMPTS.md) Result 6 gives the symmetry-free zero-defect critical points **trivial isotropy**, $\dim\mathrm{Stab}(W)=0$; combined with $\mathfrak p\ne0$ above, every one of them has $\Delta>0$. **The block's second family is empty in the reading its own file forces**, which is, on its own, a proof that the block means $\delta^2$.

## 3. "Hides no rival", the load-bearing claim

### 3.1 The witness that separates the two defects, and refutes the hinge as written

> **Padded $W_{\mathbb{CP}^2}$ has $\Delta=0$ and $\delta^2=\tfrac19$.**

Both halves are on the record, in files the block does not cite. [diagonal-half.md](../findings/diagonal-half.md) line 159: *"Padded $W_{\mathbb{CP}^2}$ has $\Delta=0$ on the $\theta>0$ branch and $\Delta=12$ on the $\theta<0$ branch"*, with $\theta>0$ the record's convention. [route-a.md](../findings/route-a.md) line 203: $g_0=\mathrm{Alt}(u_-)=a\star$, $a=\tfrac1{3\sqrt6}$, $\lVert\star\rVert^2=6$, so $\delta^2(u)=\tfrac19$; [ATTEMPTS.md](../ATTEMPTS.md) records the same as $24\delta^2=\tfrac83$ at Fox's $\mathcal S^4(\alpha)$. Consistent, and consistent with my $n=4$ derivation above, which puts exactly the $\propto(2,-1,-1)$ operators in $\{\Delta=0\}$.

This single point does four things at once.

1. **It proves $\{\Delta=0\}\ne\{\delta=0\}$**, settling the notation question with a witness rather than an argument from wording.
2. **It refutes the hinge sentence as written.** The block says reaching $\sqrt{3/2}$ *"would demand an isotropy algebra large enough to contain a unitary factor, which reintroduces the defect"*. Padded $W_{\mathbb{CP}^2}$ **has** a unitary factor in its isotropy, [ATTEMPTS.md](../ATTEMPTS.md) Result 1(c): $\mathrm{Stab}\supseteq U(2)\times SO(n-4)$, admitting the invariant $\omega\wedge\omega$, and it **attains** $\theta=\sqrt{3/2}$ exactly. The unitary factor reintroduces $\delta^2$ (through the invariant $4$-form) and **does not** reintroduce $\Delta$. **The hinge step is exactly where the two defects are conflated**, and under the block's own $\Delta$ it is false.
3. **It refutes "hides no rival" under $\Delta$, with a value.** At $n\le11$, $\sqrt{3/2}=1.224745$ exceeds the diagonal maximum $\Theta_n$ at every dimension, $\Theta_{10}=1.2$, $\Theta_{11}=1.217161$, so padded $W_{\mathbb{CP}^2}$ is a genuine rival, critical, non-diagonalisable, **sitting inside $\{\Delta=0\}$ and beating the sphere product**. The zero-$\Delta$ set hides a rival, and it is the one rival the programme already knows about.
4. **It is where the codimension statement is least defensible**, being on the zero-eigenvalue locus where $W\mapsto W_-$ is not differentiable (§2.1, qualifier 3).

### 3.2 The symmetric family: the closed form is right, the inversion is right, the enumeration is not

The closed form is [ATTEMPTS.md](../ATTEMPTS.md) Result 7 (audited there by [Reviewer 8](REVIEW_r8.md)): for a two-eigenvalue member $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ with $r=\dim\mathfrak h$, $N=\binom n2$,

$$\frac{P}{\lVert W\rVert^3}=\frac2n\sqrt{\frac{rN}{N-r}} .$$

**The inversion checks.** $\tfrac{4}{n^2}\tfrac{rN}{N-r}\ge\tfrac32\iff 8rN\ge3n^2(N-r)\iff r\,(8N+3n^2)\ge3n^2N$, and with $8N=4n^2-4n$ the bracket is $n(7n-4)$, giving

$$P\ge\sqrt{3/2}\iff r\ \ge\ \frac{3n}{7n-4}\binom n2 ,$$

exactly the threshold [ATTEMPTS.md](../ATTEMPTS.md) states, tending to $\tfrac37\binom n2$. **Two independent sanity anchors also check.** With $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, $r=\tfrac{n(n-2)}4$ and $N-r=\tfrac{n^2}4$, so $\tfrac{rN}{N-r}=\tfrac{(n-1)(n-2)}2$ and the formula returns $\tfrac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$, the balanced sphere product, recovered exactly. With $\mathfrak h$ simple of a group manifold it returns $2\sqrt{(n-1)/(n(n-3))}$, matching the record.

**The enumeration behind the hinge is where it breaks.** [ATTEMPTS.md](../ATTEMPTS.md) says: *"the only subalgebras of $\mathfrak{so}(n)$ that large are $\mathfrak{so}(n)$ itself (Weyl $=0$) and $\mathfrak u(n/2)$"*. That is false as a statement about subalgebra dimensions, and false in the direction that matters.

*Screen (arithmetic on closed forms, seconds, reported as a screen):* $\tfrac{3n}{7n-4}\binom n2$ against $\dim(\mathfrak{so}(n/2)^{\oplus2})=\tfrac{n(n-2)}4$,

| $n$ | $8$ | $10$ | $12$ | $14$ | $16$ | $20$ |
| --- | --- | --- | --- | --- | --- | --- |
| threshold | $12.92$ | $20.46$ | $29.70$ | $40.66$ | $53.33$ | $83.82$ |
| $\dim\mathfrak{so}(n/2)^{\oplus2}$ | $12$ | $20$ | $\mathbf{30}$ | $\mathbf{42}$ | $\mathbf{56}$ | $\mathbf{90}$ |

- **The balanced split clears the threshold at every even $n\ge12$ and fails below it.** It has to: the formula returns $\theta_0(n)$ there, and $\theta_0(n)\ge\sqrt{3/2}$ is precisely the $n\ge12$ crossover. So the omitted subalgebra is the **balanced sphere product itself**, the conjectured maximiser, omitted at exactly the dimensions the conjecture is about. The conclusion survives (the sphere product is diagonal and zero-defect, hence not a rival), but the stated **mechanism** (*large isotropy forces a unitary factor*), is false, and the correct statement is *forces a unitary factor **or** the balanced $\mathfrak{so}(n/2)^{\oplus2}$ split, the latter being the sphere product*.
- **$n=8$ breaks it a second way, and the record already knows.** [INDEX-traps.md](../findings/INDEX-traps.md) trap **W2**: *"$\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$ exhaust them only for $n\ne8$; at $n=8$ triality adds $\mathfrak{spin}(7)$ (dim $21$) and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ (dim $13$)"*. Both clear the $n=8$ threshold of $12.92$, and neither is $\mathfrak u(4)$ (dim $16$) nor $\mathfrak{so}(8)$ (dim $28$).
- **What actually prunes the omitted cases is a hypothesis the argument never states.** $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\in\mathcal W_n$ requires $\mathrm{Ric}(\Pi_{\mathfrak h})\propto g$ and $\mathrm{Alt}(\Pi_{\mathfrak h})=0$. The first kills the unbalanced splits: for $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ the Ricci eigenvalues are $p-2$ on $V_1$ and $q-2$ on $V_2$, forcing $p=q$; it kills $\mathfrak{so}(n-1)$ outright (eigenvalues $n-2$ and $0$, so $W=0$), which is what stops $r\to N$ sending the closed form to $+\infty$. The second is what kills $\mathfrak{spin}(7)$, whose invariant Cayley $4$-form obstructs Bianchi. **Neither constraint appears in the block or in ATTEMPTS' one-sentence enumeration.** With them restored the hinge is repairable; without them it is asserted.

**Two further limits on "for the symmetric family this is proven".**

- **The closed form is not an upper bound off its own family.** [fence-posts.md](../findings/fence-posts.md) line 345 records that extending $\theta\le\tfrac2n\sqrt{rN/(N-r)}$ to every critical point with $r=\dim E_+$ is **false**, failing wherever $\ker W\ne0$: padded $W_{\mathbb{CP}^2}$ has $r=1$, $\theta=1.224745$ against a bound of $0.254588$ at $n=8$. Since the record's symmetric family is used **padded** (Result 3: *"the padded $SU(3)$ tensor is such a critical point at $n=12$ itself"*), the inversion argument does not apply to padded members directly; the ceiling reaches them only through the separate fact that padding preserves $P$. That step is real but unstated.
- **Completeness of the family rests on Cartan's list, up to $\mathrm{Aut}$.** *"The compact symmetric spaces with $b_4=0$ are exactly the group manifolds, $SU(k)/SO(k)$, $SU(2k)/Sp(k)$, $E_6/F_4$ and spheres"* is Cartan's classification, which [conventions.md](../findings/conventions.md) flags as *"invoked in four findings files and cited to no source anywhere on the record"*. ATTEMPTS' own confidence line rates the ceiling *"moderate-to-high"* and names the hole: *"non-symmetric isotropy-irreducible spaces (Wolf's list) can have more eigenvalues and were not swept"*. **"Proven" is stronger than the source claims for itself.**

### 3.3 Cartan up to $\mathrm{Aut}(\mathfrak g)$ against $SO(n)$-conjugacy, and $n=8$

The argument does run through Cartan's list, and it **does** consume $SO(n)$-conjugacy: it needs to know which subalgebras of $\mathfrak{so}(n)$ of a given dimension occur, and whether each admits an invariant $4$-form, and $\Lambda^4\mathbb R^n$ is a functor of the **vector** representation, so it is not preserved by the outer automorphisms of $\mathfrak{so}(8)$. Dimension is an $\mathrm{Aut}$-invariant; the existence of an invariant $4$-form is not. This is [ATTEMPTS.md](../ATTEMPTS.md)'s own stated rule, and the record has already paid for breaking it twice, [r329](REVIEW_r329.md)/[r330](REVIEW_r330.md), then [r567](REVIEW_r567.md)/[r568](REVIEW_r568.md) on [L71](../findings/bounds.md).

**$n=8$ is affected, and the record holds the witness in its own value index.** [INDEX-values.md](../findings/INDEX-values.md) line 22: $\theta=1.115547=\sqrt{56/45}$ is shared by $\mathbb{HP}^2$ **and** $S^3\times S^5$, *"a triality pair, one diagonal and one not"*. Their defects differ: every sphere product has $\delta^2=0$ ([problem.md](../findings/problem.md) line 191), while [graded-half.md](../findings/graded-half.md) line 452 gives $\mathbb{HP}^2$ $\delta^2=0.031746=\tfrac2{63}$, the Kraines form supplying the invariant $4$-form. **So triality carries a zero-defect point to a defective one at the same $\theta$**, the defect is not a function of the $\mathrm{Aut}$-class. Any step that concludes "zero defect" from a position on Cartan's list is unsound at $n=8$, and the isotropy algebra $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ of $\mathbb{HP}^2$ is one of the two subalgebras trap W2 says the enumeration misses.

Practically the exposure is bounded: $n=8<12$, so the conjecture's own range is untouched. But the block states its mechanism with no dimension restriction, and at $n=8$ the mechanism is false.

### 3.4 Beyond the symmetric family, what covers the rest, and nothing does

The block is honest here and I confirm the gap rather than close it. What covers the symmetry-free component of $\mathcal A_n$ is: nothing. [ATTEMPTS.md](../ATTEMPTS.md) Result 6 is explicit, *"the $(\Lambda^4)^{\mathrm{Stab}(W)}=0$ mechanism of Result 1(c) is sufficient but far from necessary … no refinement of the dichotomy keyed to symmetry can work"*, and the surviving evidence is a seeded search. [LEDGER.md](../findings/LEDGER.md) states the same as an open obligation: *"what is missing is any argument constraining critical points with trivial stabilizer, where only numerics currently speak."*

**The conjecture's actual content, stated as it should be:** *for $n\ge12$, every critical point $W$ with $\mathrm{Alt}(W_-)=0$, trivial stabiliser and $P(W)\ge\Theta_n$ is coordinate-diagonalisable.* Everything else in the block is proven, measured, or false.

**And the block suppresses the sample size behind its own null result.** *"At $n=12$ produced no non-diagonalizable zero-defect critical point at all"* comes from [ATTEMPTS.md](../ATTEMPTS.md)'s seeded sweep, which carries the caveat verbatim: *"$n=12$ carried only 17 seeds (14 converging) … that is thin, and a wider $n=12$ sweep is the cheapest available strengthening."* A null result from 14 converged runs in a $1638$-dimensional space is not what the block's phrasing conveys. Restoring "$14$ of $17$ seeds" costs six words.

## 4. The target constant

The block's bar is $\sqrt{3/2}$, the rival maximiser's value. "Hides no rival" is a comparison against the **diagonal maximum**, which [conventions.md](../findings/conventions.md) fixes as $\Theta_n$, equal to $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$, strictly smaller, at odd $n$. Two consequences.

- **At $n\ge12$ the block's bar is conservative and the argument is unharmed.** $\Theta_n>\sqrt{3/2}$ for even $n\ge12$ ($\theta_0(12)=1.236033$) and for odd $n\ge13$ ($\Theta_{13}=1.248376$), so blocking $\sqrt{3/2}$ blocks more than needed. The crossover is at $n\ge12$ under **both** parities, so [results.md](../results.md) line 220's repair of [Conjecture L16](../findings/problem.md) to $\Theta_n$ carries over here at no cost.
- **At $n\le11$ the bar is the wrong one and the claim is false**, as §3.1 shows with padded $W_{\mathbb{CP}^2}$. $\Theta_{11}=1.217161<\sqrt{3/2}$, so a zero-defect point with value in $(\Theta_n,\sqrt{3/2})$ would beat the sphere product without ever triggering the block's mechanism.

**Owed: the block must say $n\ge12$, and should say $\Theta_n$ rather than $\sqrt{3/2}$.** Neither appears anywhere in it.

## 5. Checklist

**Hedging clauses.** Four, and all four conceal something.

- *"is **exactly** the condition under which the diagonal argument transfers unchanged"*, **refuted by the record's own audit of [Observation L15](../results.md)**: *"TWO OBSTRUCTIONS, NOT ONE. The second is $X_{\mathrm{inv}}\succeq0$"*, free on the diagonal locus and refuted off it. L6's opening clause asserts, in one word, precisely the thing L15 was refuted for. Correct: *the defect vanishing is one of two conditions.*
- *"What saves the picture is that **all of them** sit low"*, asserted, then withdrawn one sentence later for the symmetry-free half.
- *"For the symmetric family this is **proven**"*, §3.2: the enumeration is incomplete at every even $n\ge12$ and at $n=8$, and the source rates itself "moderate-to-high" with a named unswept gap.
- *"produced **no** non-diagonalizable zero-defect critical point **at all**"*, true of $14$ converged seeds, which the block does not say.

**Does the block's own file settle it?** Partly, and the rest is one file away. The $\Delta$ the block inherits is defined **three lines above** it, in the same file; the object its content is about is $\delta^2$, defined in [problem.md](../findings/problem.md). [diagonal-half.md](../findings/diagonal-half.md) line 96, the file [conventions.md](../findings/conventions.md) names as $\Delta$'s source, carries the exact characterisation of $\{\Delta=0\}$ on the diagonal locus and, at line 159, the $\Delta=0$ value at padded $W_{\mathbb{CP}^2}$ that refutes the hinge. [Lemma L106](../findings/bounds.md), which is L6's true companion under $\Delta$, is in a third file and is not cross-linked from either direction.

**Do all pointers resolve?** The block carries exactly one link, `[results.md](../results.md)`, which resolves and is **circular** (§1.3). Its enclosing section's [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) reference resolves. The block cites **no** result, file or script for any of its four quantitative claims, not the codimension, not the closed form, not the searches, not the $\sqrt{3/2}$ threshold. That is the deeper pointer failure: nothing here is checkable without a `git grep`.

## 6. What is owed

1. **Fix the notation.** State in the block which defect it means, and table $\Delta$ against $\delta^2$ in [conventions.md](../findings/conventions.md) as the seventh live letter collision, with padded $W_{\mathbb{CP}^2}$ ($\Delta=0$, $\delta^2=\tfrac19$) as the separating witness. Then either move L6 out from under the $\Delta$ definition or retitle it *the zero-**Bianchi**-defect set*.
2. **Strike the provenance note and transcribe.** [ATTEMPTS.md](../ATTEMPTS.md) Results 1–7 are the argument; the record bars that file from holding it. Reachable, and mechanical.
3. **Restore the three qualifiers on the codimension** (generic, measured at $n=6,7,8,12$, singular on the diagonal locus) and regrade that clause `Observation`. Proving generic surjectivity of $d(\mathrm{Alt}\circ(\cdot)_-)$ at a trivial-stabiliser point would make it a `Lemma`; that is an analytic task, no run needed.
4. **Repair the hinge.** Add the two hypotheses that actually prune the enumeration ($\mathrm{Ric}(\Pi_{\mathfrak h})\propto g$ and $\mathrm{Alt}(\Pi_{\mathfrak h})=0$), name $\mathfrak{so}(n/2)^{\oplus2}$ as the second large subalgebra and the sphere product as its point, and carry trap **W2**'s $n=8$ exception. Reachable by hand.
5. **Scope it.** Add "$n\ge12$" and state the bar as $\Theta_n$.
6. **Say what the conjecture is**, in the form of §3.4's displayed sentence, so the label attaches to a proposition rather than to a paragraph.

**Nothing above needed a run.** Item 3's `Lemma` upgrade is the only place a computation could help, and it should not be taken: the statement wanted is analytic, and the record already holds four measured ranks agreeing with it.
