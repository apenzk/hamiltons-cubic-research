# Review r605, Lemma L19, the lift of the diagonal proof, the top orbits, and the remaining gap

*Review number taken: **r605**. r606 is allocated to the second reviewer on the identical brief; I have read neither their report nor their log. Concurrent audits of L63, L55 and L77 are untouched. Standing rule inherited and observed: **analysis only**, nothing below was computed, every number quoted is read off the record and attributed to the line that carries it.*

**Verdict: `NO CHECKABLE STATEMENT`.** [Lemma L19](../findings/problem.md) has no proposition. The block is five prose paragraphs under a heading promising a *canonical statement and proof*; it contains no hypothesis, no conclusion, no quantifier, no displayed formula, and (the only link in the block being the provenance back-pointer), **not one pointer to a numbered result, file or script**. There is nothing here that could be true or false, so the block cannot be confirmed or refuted as a whole.

Grading the heading's three claims separately, as the brief directs, the picture is not uniform:

| heading claim | verdict | why |
| --- | --- | --- |
| *the rest of the diagonal proof lifts* | **unlocatable** | the lemma said to have replaced the diagonal-specific one is named nowhere on the record, and the sharpness family it names occurs in no other line of the repository |
| *the top orbits are rigid* | **`REFUTED` as to status, true as to content, at named dimensions** | the support is an exact machine certificate at $n=8,12,14$ ([ATTEMPTS.md](../ATTEMPTS.md), Result 12(a)), which is a computation. *"Proven rather than computed … established in exact integer arithmetic"* contradicts itself in this record's own vocabulary |
| *the remaining gap sharpens* | **`GAP`, and it is not a sharpening** | what it "sharpens to" is a localization statement strictly stronger than the target it is supposed to reduce, and logically incomparable with [Conjecture L16](../findings/problem.md) rather than weaker than it |

The provenance note is the one thing in the block that checks out clean. **The move lost nothing**, see §5.

---

## 1. What the statement of Lemma L19 is

There is none. Reconstructing the strongest proposition the prose will bear, one would have to write something like:

> *Attempted reconstruction.* For $n\ge12$: (i) the two inequalities of Jäger's middle chapters hold at every critical point of $P$ on $\{\lVert W\rVert=1\}$, not only on the diagonal locus; (ii) at every critical orbit with $\theta\ge\sqrt{3/2}$ the kernel of the second variation equals the orbit tangent; (iii) Conjecture A at $n\ge12$ follows from a localization statement.

Each of the three parts breaks on a different missing quantity. (i) does not say **which** two inequalities, nor what "proven off the diagonal locus" quantifies over. (ii) does not say what "the dimensions that matter" are, and the set of "high-value critical orbits" is not enumerated anywhere, [second-order.md:317](../findings/second-order.md) states flatly that *"completeness of any enumeration is both stronger than required and already false, and an isotropy-indexed list can never reach the symmetry-free points."* (iii) does not say what "close" means, in which metric, or with what quantifier order over $n$.

**A `Lemma` heading over a paragraph with no proposition is the finding**, and it is already on the record's own books: [LEDGER.md:1700](../findings/LEDGER.md) reads *"seven blocks carry 'and proof' with no proof marker at all, including [L1](../findings/problem.md) and [L19](../findings/problem.md), neither audited."* [INDEX-results.md](../findings/INDEX-results.md) row 19 says *"Gate 2: no verdict on the record."* Both were true when written; this review supplies the verdict for row 19 and leaves the L1 half alone.

**The `Proof:` pointer is circular in substance.** [results.md:650](../results.md) carries as L19's statement one paragraph of the block, verbatim, and ends *"**Proof:** [problem.md](../findings/problem.md)"*; the block in [problem.md](../findings/problem.md) repeats that same paragraph and adds four more of the same kind. Following the pointer returns the reader to the text they came from. Compare [Lemma L20](../findings/route-a.md), whose pre-move entry carried an actual `*Proof.*` and whose post-move block still does, the migration preserved proofs where they existed.

## 2. Claim one, "the rest of the diagonal proof lifts"

### 2.1 From the diagonal locus to where, under what hypothesis

The block never says. The natural reading (to every critical point of $P|_{\lVert W\rVert=1}$ at $n\ge12$), is the one the surrounding chapters use, and it is the reading under which the claim fails.

**The two inequalities are [Lemma L18](../findings/problem.md)'s "two departures", and L18's own block says one of them is granted, not proven.** L18 reads: *"The operator positivity his proof invokes, **false off the diagonal locus**, is needed only through one scalar contraction, whose diagonal part is proven nonnegative and whose cross term provably vanishes **at every named critical point**"*, and then *"**Granting** that cross-term bound off the class where it is already proven, the chain gives …"*. So at the moment L19 asserts both inequalities proven off the diagonal locus, the block 100 lines above it in the same file asserts one of them holds at named points and is granted elsewhere.

**And today's audit of L18 makes it worse, not better.** The box at [problem.md:277](../findings/problem.md) records ([r477](REVIEW_r477.md), [r478](REVIEW_r478.md), independently): *"'granting that cross-term bound' names one grant where [LEDGER.md](../findings/LEDGER.md) records **two**: $J_5\ge0$ **and the E-track certificate**, which the same file marks single-author since inception, never audited."* Two live grants, one of them never audited, is the state of the chain L19 declares proven.

### 2.2 The gloss contradicts the thing it glosses

L19's own explanation reads: *"the working estimate needs nothing about its operator argument beyond **positive semidefiniteness** and the value of its Ricci contraction."* L18 says the operator positivity is precisely what is *"false off the diagonal locus"*. Positive semidefiniteness is named by one sentence as the cheap hypothesis that makes the lift work and by the other as the hypothesis that fails. **"Its operator argument" has no antecedent in the block**, so a reader cannot tell whether the two sentences are about the same operator. That is not a wording problem; it is the whole content of the claim.

### 2.3 The replacement lemma and its sharpness family are unlocated

*"A lemma whose original argument was genuinely diagonal-specific has been replaced outright by an unconditional one, sharp at a family I had not noticed before: the critical operator of a product of $n/2$ two-spheres."*

- The replacement lemma carries **no number and no pointer**. The obvious candidate is the section immediately above the block, [*"Step 1 is PROVED, and it IS the record's own Dirichlet inequality"*](../findings/problem.md), which proves $\lambda\le\frac{n-1}n\mu$ unconditionally on $\mathcal D_n$. But that argument is *diagonal by construction* (it pairs $S^{\circ2}+S^2=\lambda S+D$ with $v\otimes v$ for $S\in\mathcal D_n$) so it is not a lemma that "lifts", and its recorded equality family is *"every $S^p\times S^q$, balanced or not, even or odd $n$"*, not a product of $n/2$ two-spheres.
- **The sharpness family occurs nowhere else in the repository.** A grep for the phrase across [findings/](../findings/), [results.md](../results.md) and [ATTEMPTS.md](../ATTEMPTS.md) returns exactly two hits: this sentence and its verbatim copy at [results.md:652](../results.md). No block, no index row, no script, no equality-case computation.

### 2.4 "The endgame section is frame-free until its final steps … and that place is priced"

Two clauses, and they separate.

**"Priced" does name a real bound**, and this is the one hedging clause in the block that survives. The pricing is L18's unconditional half, $J_4\le24\,\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$, which [r477](REVIEW_r477.md) and [r478](REVIEW_r478.md) confirm is a `Lemma`: *"unconditional, pointwise, dimension-free … the constant $24$ is right."* So this is a stated bound, not a place where a bound is owed.

**"At exactly one place" is refuted, and it is the third time the same error has been made about the same argument.**

- [Observation L15](../findings/problem.md) was refuted this cycle for exactly this shape, [INDEX-results.md](../findings/INDEX-results.md) row 15: *"'exactly one exception' is false, the second is $X_{\mathrm{inv}}\succeq0$"* ([r469](REVIEW_r469.md), [r470](REVIEW_r470.md)).
- L18 was refuted for it hours later (the box in this same file: *"'The answer is **one** exactly-priced term'), [ATTEMPTS.md](../ATTEMPTS.md)'s Result 10(a) records **Lemma 3.3.1 is not defect-free**, a second $24\delta^2$ with a favourable $-6.4\delta^2$ beside it, so **three entries**."*
- L19 makes the same count, in the same file, four paragraphs later, and has never been audited.

**And the price is quoted at the wrong level, for the same reason L18's was.** [ATTEMPTS.md:908](../ATTEMPTS.md) gives the chain penalty as $(J_4-J_5)/\sqrt{1-e^2}$; L18's audit box records that the block *"quotes the numerator alone, never mentions $e$, and then draws the dichotomy that needs the divided form."* L19 inherits the numerator reading wholesale.

**"Frame-free until its final steps" is a claim about Jäger's §3.6, and §3.6 is where this record's own dimension problem lives.** [Lemma L1](../findings/problem.md)'s audit ([r497](REVIEW_r497.md), [r498](REVIEW_r498.md)) established that *"Assumption 1, $m\ge8$, a standing hypothesis of his whole Chapter 3, [is] used again and genuinely at its §3.6 ideal-induction step, so the closure below rests on this record's own replacement for that step, the six-line graph argument recorded here as **Result 5b**"*, which is *"unnumbered, unindexed and has never been through Gate 2."* [ATTEMPTS.md:629](../ATTEMPTS.md) adds that Result 5b *"replaces §3.6 **after** Lemma 3.6.10 rather than the whole section"* and *"still consumes Lemmas 3.6.7–3.6.8"*, and [LEDGER.md:27](../findings/LEDGER.md) records that *"only Jäger's §3.6 endgame lacks an odd analogue."* So the endgame is the one section of the source whose hypotheses this record has had to replace, and L19 describes it as the part that costs nothing.

### 2.5 The source of the lift says, in bold, that it is not a proof

[ATTEMPTS.md:2468](../ATTEMPTS.md), *"the diagonal argument lifts to the non-diagonal case"*, is where the lift was derived. Its closing paragraph:

> **Not a proof.** What exists is the dichotomy rewritten in three concrete quantities with both extremal cases identified. Gate 2 on the chain is in flight.

Two lines above it, on the very inequality L19 says now lifts:

> $\mathrm{LOSS}\ge\mu^2/n\iff\lambda\le\frac{n-1}n\mu$. **Measured**, $\mathrm{LOSS}=\mu^2/n$ **exactly** at every sphere product tested … and $\mathrm{LOSS}<0$ at padded $W_{\mathbb{CP}^2}$ at every $n$.

**$\mathrm{LOSS}<0$ at the rival maximizer is the diagonal step failing off the diagonal locus**, at the one point that matters. From $\lambda\mu=\mu^2-\mathrm{LOSS}$ with $\mu>0$, $\mathrm{LOSS}<0$ gives $\lambda>\mu$, so $\lambda\le\frac{n-1}n\mu$ is false there. The record's own words: *"the two branches are tight on disjoint families"*, a dichotomy, not a lift. Whatever "the rest lifts" means, it does not mean this inequality holds off the diagonal locus.

## 3. Claim two, "the top orbits are rigid"

### 3.1 The support, located

The claim is *"at every high-value critical orbit (the rival maximizer and every sphere pair, in the dimensions that matter), the degenerate directions of the second variation are exactly the directions along the orbit, established in exact integer arithmetic."* Its source is [ATTEMPTS.md:916](../ATTEMPTS.md), Result 12(a):

> For **19 orbits** (Fox and every sphere split at $n=8,12,14$, plus $\mathbb{HP}^2$/$\mathbb{HP}^3$ at $n=12$), the radical of the second variation **equals** the orbit tangent space, proven in exact integer arithmetic (rank over $\mathbb F_p$ bounds rank over $\mathbb Q$; bordered-matrix upper bound on the radical, $\mathrm{ad}$-rank lower bound on the orbit; every inequality pointing the safe way).

"Fox" is padded $W_{\mathbb{CP}^2}$, [second-order.md:317](../findings/second-order.md): *"Fox $\mathcal S^4(\alpha)=$ padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ exactly."* The certificate is sound: [nondegeneracy.md:428](../findings/nondegeneracy.md) explains why mod-$p$ suffices in this direction, *"rank over $\mathbb F_p$ is at most rank over $\mathbb Q$, so $\mathrm{nullity}_p\ge\mathrm{nullity}_{\mathbb Q}$: mod-$p$ bounds the kernel from above. That settles nondegeneracy."*

**So the mathematics is right at the orbits and dimensions named. What is wrong is the label.**

### 3.2 "Proven rather than computed" is refuted by the next clause of the same sentence

An exact machine certificate at three dimensions is a computation. This record's labels are literal (`Lemma` proven, `Observation` verified at the dimensions named) and the sentence itself supplies the disqualifying evidence: *"established in exact integer arithmetic."* **A proof is not established in exact integer arithmetic; a certificate is.** "In the dimensions that matter" resolves to $n=8,12,14$, so the claim covers no $n\ge16$ and no odd $n$, in a programme every one of whose statements carries $n\ge12$.

**This is `Observation`, not `Lemma`, at the rival maximizer**, and the record already says so where it is careful. [second-order.md:205](../findings/second-order.md): *"At padded $W_{\mathbb{CP}^2}$ it is a **measurement** stopping at $n=10$: [Lemma L28](../findings/nondegeneracy.md) is stated at $m\ge3$ in native dimension, and padding manufactures excess elsewhere, so those measurements re-derive what was known and say nothing about a degenerate maximizer."*

### 3.3 The record carries four incompatible dimension lists for this one fact

| line | what it says the rival maximizer's rigidity covers |
| --- | --- |
| [nondegeneracy.md:155](../findings/nondegeneracy.md) | *"excess $0$ … at $n=6,8,10$"* |
| [second-order.md:243](../findings/second-order.md) | *"Morse–Bott nondegenerate at $n=8,10,12$, with $\dim E(\tfrac12)=18,26,34$"* |
| [second-order.md:205](../findings/second-order.md) | *"a measurement stopping at $n=10$"* |
| [ATTEMPTS.md:916](../ATTEMPTS.md) | Fox at $n=8,12,14$, exact integer arithmetic |

No two of these agree. Any reader asking "is the rival maximizer rigid at $n=12$?" gets yes, yes, no and yes from four places, with no reconciling note. **This is a defect independent of L19 and is the single most useful thing in this review to fix**, since it is the orbit whose value defines the localization threshold.

### 3.4 "Every sphere pair" is false without the value localization the block omits

Three separate families are degenerate, all of them sphere pairs or their paddings, and all of them on the record:

- **$S^3\times S^3$.** [Lemma L27](../findings/nondegeneracy.md) is stated for $p,q\ge3$ with $(p,q)\ne(3,3)$; at $(3,3)$, $\mu=\tfrac12$ exactly and $\dim E(\tfrac12)=18$ against orbit $9$, excess $9$, *"an eigenvalue coincidence, not representation mixing"*. Its value is $1.054093=\Theta_6$, the diagonal maximum at the only $n$ where it exists, so it is "high-value" by any reading that does not smuggle $n\ge12$ into "the dimensions that matter".
- **Padded sphere pairs.** [nondegeneracy.md:377](../findings/nondegeneracy.md): *"the whole $S^2\times S^k$ family for $k=2,\dots,8$ is nondegenerate at its own dimension and degenerate at **every** padding, eighteen cases, with excess $q(n-n_0)$."* And at [line 409](../findings/nondegeneracy.md): *"Padding does **not** preserve nondegeneracy … $S^3\times S^3$ keeps excess $9$ at $n=6\ldots14$ including odd $n$."*
- **Multi-block products.** [nondegeneracy.md:379](../findings/nondegeneracy.md): $(S^3)^3$ at $n=9$ is exactly critical, *"degenerate with orbit $27$ against $\dim E(\tfrac12)=81$"*, and *"degeneracy is generic at $k\ge3$, excess $24$–$162$ across seven products."*

**What rescues the claim is a hypothesis the block does not state.** [nondegeneracy.md:454](../findings/nondegeneracy.md) states it correctly: *"Every known exception sits at value at most $1.054$, below the rival maximizer's $\sqrt{3/2}$, so a **value-localised** version survives … the exceptions are excluded by fiat."* And [LEDGER.md:23](../findings/LEDGER.md): *"'Every graded critical point is Morse–Bott nondegenerate' is false."* L19 states the conclusion of the value-localised version while omitting the localization, and buries the omission in *"in the dimensions that matter"*.

**The strongest form of the rigidity claim that the record supports** is therefore: *for $p,q\ge3$ with $(p,q)\ne(3,3)$, $S^p\times S^q$ is Morse–Bott nondegenerate at every $n=p+q$*, which is [Lemma L27](../findings/nondegeneracy.md), a genuine `Lemma` with a representation-theoretic proof and no dimension bound, **whose credit L19 obscures by describing it as exact integer arithmetic**, together with *padded $W_{\mathbb{CP}^2}$ is Morse–Bott nondegenerate at the dimensions certified*, which is an `Observation`.

### 3.5 One clause that is right and should be kept

*"Each orbit is therefore nondegenerate and isolated in the critical set: nothing branches off it."* Morse–Bott nondegeneracy does give local isolation, and the record even records the converse caution properly at [nondegeneracy.md:411](../findings/nondegeneracy.md): *"Degeneracy does not break openness … a degenerate orbit can still be isolated at third order."* The inference is sound where the hypothesis holds.

## 4. Claim three, and the open core, "the remaining gap sharpens"

### 4.1 Stating the localization claim precisely, and what is missing from it

The block: *"the open core becomes a localization statement, every critical point at or above the rival maximizer's value lies close to one of these rigid orbits, which the rigidity then finishes outright."*

The strongest precise form:

> **(Loc).** For every $n\ge12$ there is $\varepsilon_n>0$ such that every critical point $W$ of $P|_{\lVert W\rVert=1}$ with $P(W)\ge\sqrt{3/2}$ satisfies $d\big(W,\mathcal O\big)<\varepsilon_n$ for some $\mathcal O$ in the list $\{SO(n).W_{\mathbb{CP}^2}\}\cup\{SO(n).W_{p,q}:p+q=n,\ p,q\ge3\}$, with $d$ the angular distance on the unit sphere of $\mathcal W_n$.

Four things the block does not supply and cannot be read to supply:

1. **The metric.** The block names none. [INDEX-results.md](../findings/INDEX-results.md) row 20 records the same defect one result away (*"**the metric of its radius is defined nowhere**"*) for [Lemma L20](../findings/route-a.md)'s $0.5748$. So this is a repeat, not a first offence.
2. **The list.** "These rigid orbits" has no referent that is closed under anything. Written out it is an enumeration hypothesis, and [second-order.md:317](../findings/second-order.md) says enumeration completeness *"is already false"*.
3. **The radius $\varepsilon_n$.** See §4.2, no radius exists anywhere on the record for any of the orbits in question.
4. **The quantifier order.** $\forall n\,\exists\varepsilon_n$ or $\exists\varepsilon\,\forall n$ changes what has to be proved completely, and the block does not choose.

### 4.2 Granting (Loc), does rigidity finish it? Not as stated, the uniformity is the whole content

Morse–Bott nondegeneracy at an orbit $\mathcal O$ says $\ker\mathrm{Hess}=T\mathcal O$. What that yields is: **there exists** a neighbourhood $U_{\mathcal O}$ with $\mathrm{Crit}(P)\cap U_{\mathcal O}=\mathcal O$. The composition needs $\varepsilon_n\le\min_{\mathcal O}r(\mathcal O)$ where $r(\mathcal O)$ is that neighbourhood's radius. Three obstructions, in increasing order of seriousness:

- **No radius is on the record for any orbit in the list.** A statement about $\ker\mathrm{Hess}$ is zeroth-order in the radius; extracting $r(\mathcal O)$ needs a quantitative inverse-function or Łojasiewicz estimate, and none is given. The two halves of the reduction therefore cannot be composed even in principle until somebody produces $r(\mathcal O)$, and the record prices that route: [plan.md:179](../plan.md) records *"[post F4](../findings/fence-posts.md)'s Łojasiewicz constants are **astronomical and location-blind**"*, which is the same objection L19 itself raises against general finiteness arguments two sentences later.
- **The list grows with $n$.** At each $n\ge12$ it holds $\lfloor n/2\rfloor-2$ sphere pairs plus the rival, and the uniformity needed is over a family whose size is $\Theta(n)$, then across $n$. The record has nothing on how $r(S^p\times S^q)$ varies with the split or with $n$.
- **At the one orbit that sets the threshold, there is no nondegeneracy statement valid at all $n\ge12$ to take a radius of.** By §3.2–3.3 the rival maximizer's rigidity is certified at named dimensions only, and [Lemma L28](../findings/nondegeneracy.md) (the only `Lemma` in the family), is stated *"at $m\ge3$ in native dimension"*, which excludes $m=2$ and excludes padding.

So the brief's suspicion is correct and is worse than a missing uniformity: **rigidity at each orbit is not the same as a uniform neighbourhood covering all critical points above the threshold, and here not one of the individual neighbourhoods has been produced either.**

### 4.3 (Loc) is stronger than the target, so it is not a sharpening

Grant (Loc) and grant rigidity with radii. The conclusion is that every critical point with $P\ge\sqrt{3/2}$ **lies on** one of the listed orbits, a complete classification of $\mathrm{Crit}(P)\cap\{P\ge\sqrt{3/2}\}$. Conjecture A at $n\ge12$ asks only for the inequality $P\le\Theta_n$ at critical points. **The open core as L19 frames it therefore entails Conjecture A together with a classification the record separately says is out of reach**, so it is strictly stronger than the thing it is offered as a reduction of. Calling that a sharpening of the gap inverts the direction.

### 4.4 "What is left is strictly weaker than Conjecture L16" is false

[results.md:226](../results.md) carries this as L19's glance entry. The two statements are **incomparable**, neither implying the other:

- **L16 $\not\Rightarrow$ (Loc).** [Conjecture L16](../findings/problem.md) is $P(W)\le\theta_0(n)+\kappa_n\delta^2$ on $\{\lvert W\rvert=1\}$, a value bound carrying no information about where critical points sit. It is consistent with L16 that critical points at value $\sqrt{3/2}$ are dense in some region.
- **(Loc)+rigidity $\not\Rightarrow$ L16.** The composite gives a bound at critical points at or above $\sqrt{3/2}$ and nothing at all below it, still less at non-critical $W$, whereas L16's advertised strength, in the block on the same page, is precisely that *"zero-defect points fall under it with no criticality hypothesis."*

"Strictly weaker" is a logical relation and neither direction holds. Since neither statement is written down precisely in the block, the comparison was never checkable in the first place.

### 4.5 The two "closed neighbouring routes"

- *"General finiteness arguments for critical values carry constants far too large to say anything in a fixed dimension"*, **this one resolves and is correct.** [nondegeneracy.md:159](../findings/nondegeneracy.md) refutes the finiteness shortcut as circular, and [plan.md:179](../plan.md) prices Łojasiewicz as *"astronomical and location-blind"*.
- *"The lifted chain goes vacuous once the defect exceeds roughly a thousandth"*, the number is [ATTEMPTS.md:908](../ATTEMPTS.md)'s $c(12)=1.0008\times10^{-3}$, and the diagnosis there is sharper than L19's: *"for $d\gtrsim0.04$ the chain goes vacuous because Jäger's $x\le2$ hypothesis fails"*, the $10^{-3}$ being where the closing branch stops rather than where the chain dies. **And $c(12)$ is the E-track certificate's output**, the grant L18's audit flags as *"single-author since inception, never audited"*. So a route is declared closed on the strength of an unaudited number.

## 5. Provenance, checked, and the note is TRUE

The brief warns that six of seven provenance notes audited here were false. **This one is not.** Evidence, from the commit that performed the move, **a9e4b8c0**, *"refactor(results): the proofs move to findings, results.md states and points"*:

- Before the move, [results.md](../results.md) lines 775–786 carried *"##### Lemma 19: the rest of the diagonal proof lifts…"* and the five paragraphs, **and the block in [findings/problem.md](../findings/problem.md) at that commit's parent contained none of them**, a search of the parent tree for *"nothing branches off it"* across [findings/](../findings/), [results.md](../results.md) and [ATTEMPTS.md](../ATTEMPTS.md) returns exactly one hit, in results.md. So results.md genuinely held the only copy, unlike [Lemma L1](../findings/problem.md) and [Lemma L11](../findings/nondegeneracy.md), whose identical notes are false and are marked so in their blocks.
- The five paragraphs transferred **verbatim**, with no text dropped.

**So the absence of a proof is not damage from the move. The block never had one.** The same commit moved [Lemma L20](../findings/route-a.md)'s entry, which did carry a `*Proof.*`, and that proof arrived intact, which is the control showing the migration preserved proofs where they existed.

**One sub-claim of the note is wrong, though.** *"That file now carries the statement and points here"*, [results.md:650](../results.md) carries not a statement but one of the block's five narrative paragraphs, duplicated, followed by a pointer back to the file it was copied from. Neither file holds a statement.

## 6. The sub-section that follows, it belongs to Lemma L57

*"So the all-$n$ diagonal theorem is COMPLETE"* at [problem.md:388](../findings/problem.md) is **not part of L19**: same heading level (`####`), different subject, and its content is the canonical statement of [Lemma L57](../findings/problem.md), whose own numbered block sits 139 lines below at line 527 with the identical display $\langle Q(W),W\rangle\le\Theta_n\lvert W\rvert^3$, the identical two-parity formula for $\Theta_n$, and the identical equality case.

**On the brief's question, "COMPLETE" against L19's "remaining gap" is not a mathematical contradiction.** L57 is the theorem *on the diagonal locus* $\mathcal D_n$; L19's gap is the lift *off* it. The two are consistent, and [conventions.md](../findings/conventions.md) keeps them apart: $\Theta_n\le M(n)$, *"strictly at $n=4$ and $n=6$"*, so the diagonal maximum is not claimed to be the global one.

**The defect is placement and duplication, and it is real.** A numbered result's canonical statement appears twice in one file under two headings, the second copy unnumbered and immediately beneath a different lemma that announces a remaining gap. A reader arriving at L19 reads "COMPLETE" as L19's own conclusion; nothing in the layout stops them. Two smaller things in that section:

- It says both *"uniqueness holds at $n=4$ as well"* and, in its display, *"uniquely for $n\ge5$"*. Read together they assert uniqueness at every $n\ge4$, which is presumably intended, but the reader has to reconstruct that.
- Its parenthetical *"Two independent Gate 2 proofs of the one lemma that was open"* refers to step 3, closed by [r123](INDEX.md) and [r124](INDEX.md) per the step-3 section, and is stated without saying which lemma, the same unattributed style as L19.
- It uses $\Theta_n$ throughout, correctly, consistent with the L0 repair. **Nothing in L19 itself turns on the target constant**, so the $\theta_0(n)\to\Theta_n$ correction leaves the block's verdict unchanged; I record that as checked rather than assumed.

## 7. Hedging clauses, one by one

The brief asked for the clause-by-clause pass. Nine clauses, and eight conceal something incomplete.

| clause | what it conceals |
| --- | --- |
| *"more cleanly than expected"* | that one of the two inequalities is granted, not proven, and on **two** grants, not one |
| *"needs nothing … beyond positive semidefiniteness"* | that positive semidefiniteness is exactly what [Lemma L18](../findings/problem.md) says is false off the diagonal locus |
| *"replaced outright by an unconditional one"* | a lemma with no number, no block and no pointer |
| *"sharp at a family I had not noticed before"* | a family that appears in no other line of the repository |
| *"frame-free until its final steps"* | that §3.6's own $m\ge8$ hypothesis is discharged only by Result 5b, unnumbered and never through Gate 2 |
| *"at exactly one place"* | the third repetition of a count refuted twice this cycle ([L15](../findings/problem.md), [L18](../findings/problem.md)) |
| *"and that place is priced"* | **nothing, this one is sound**, $J_4\le24\delta^2\lambda_{\max}$, though quoted at the numerator level rather than the divided form the dichotomy consumes |
| *"proven rather than computed"* | an exact machine certificate at three dimensions |
| *"in the dimensions that matter"* | $n=8,12,14$; no $n\ge16$, no odd $n$ |
| *"which the rigidity then finishes outright"* | a uniformity over a growing orbit family, and radii that exist for no orbit on the list |

## 8. What is owed, and whether it is reachable

**Reachable now, by hand, no computation:**

1. **Give L19 a statement, or retire the number.** The honest statement of what is actually proven here is [Lemma L27](../findings/nondegeneracy.md)'s, which already has a number. If L19 is to survive, it should be restated as the value-localised rigidity claim with its hypothesis visible: *for $n\ge12$, every critical orbit on the record with $\theta\ge\sqrt{3/2}$ is Morse–Bott nondegenerate*, labelled `Observation`, with $n=8,12,14$ named.
2. **Reconcile the four dimension lists of §3.3.** This is reading, not computing, and it is the highest-value repair in the block's neighbourhood.
3. **Restate the "strictly weaker than L16" glance entry** at [results.md:226](../results.md) as "incomparable with", with the reason from §4.4.
4. **Number the "COMPLETE" section into [Lemma L57](../findings/problem.md) or delete it as a duplicate.**
5. **Move the localization core onto [plan.md](../plan.md) as an item**, where it currently does not appear. The nearest thing is [R12](../routes.md), which is marked **STALLED** and whose closure mechanism is different (isolated graded orbits $\Rightarrow$ ungraded part compact $\Rightarrow S\ge c>0$), and which cannot cover the rival maximizer anyway, since [fence-posts.md:326](../findings/fence-posts.md) records padded $W_{\mathbb{CP}^2}$ as *"ungraded with excess $0$"*.

**Not reachable without new mathematics:** the radius $r(\mathcal O)$ at any orbit on the list, and hence (Loc) itself. Per §4.3 that statement is stronger than Conjecture A restricted above $\sqrt{3/2}$, so it is not a reduction and should not be recorded as the open core without saying so.

**Where computation would decide something, named and not run** (analysis-only rule, no approval held): extending the exact Morse–Bott certificate of [ATTEMPTS.md:916](../ATTEMPTS.md) to padded $W_{\mathbb{CP}^2}$ at $n=16$ and at one odd $n$ would settle whether *"the dimensions that matter"* can honestly be widened. **A pass would upgrade the `Observation`'s dimension list and change nothing about its label**; a fail would refute the rigidity claim outright at the orbit that sets the threshold, and would take the localization core with it. It would not make the claim a `Lemma` either way, so it is not what this block most needs.

---

*Checked and not used: nothing in L19 turns on $\theta_0(n)$ versus $\Theta_n$, so the [Lemma L0](../findings/problem.md) repair is orthogonal to this verdict; L0 was not re-audited. No computation was performed for this review.*
