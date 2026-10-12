# ROUND L10, the reducible-isotropy families, one critical point each, and a threshold the family's first member attains

**Id:** L10. **Source:** [findings/graded-half.md](../findings/graded-half.md):468–476, with the canonical form at [results.md](../results.md):379. **Date:** 2026-09-07. **Verifiers allocated:** v107, v108, v109. **Phase:** 6, closed. **Verdict:** `BROKEN`, repaired, impact `PROPAGATES`.

**Why this id.** Tier 1, cited eight or more times. Its closed form is the value the whole threshold argument compares against.

**Phase 0's own finding, the statement contradicts its own body, and both go to the verifiers unlabelled.** The heading and [results.md](../results.md):128 say the families' points are **"all below the threshold"**; the body gives $\theta^2=\tfrac32$ **exactly** at $m=2$, and $\sqrt{3/2}$ *is* the threshold. The verifiers are told neither which reading the record intends nor that anyone has noticed.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Is every point below the threshold?** **Evaluate the closed form at $m=2$ and say what you get, then say what the heading and the canonical form claim.**
2. **Is "one critical point each" proved, or is it one-dimensionality restated?** *A one-dimensional space of Weyl operators meets the unit sphere in two points, $\pm W$, and $P$ is an odd cubic.* **Say how many critical points a one-dimensional family carries, and which of them the value belongs to.**
3. **Is the dimension count on file?** *"Ricci-flatness together with the first Bianchi identity cuts each one-parameter-per-factor family down to a one-dimensional space" is the load-bearing step.* **Find its argument, or record that the claim has none.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

### The block

Ricci-flatness together with the first Bianchi identity cuts each one-parameter-per-factor family down to a one-dimensional space of Weyl operators, so the critical point in each is forced rather than found. For the $\mathbb{CP}^m$ family the value is exact in closed form,

$$\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)},$$

decreasing monotonically to $2/3$ and equal to exactly $3/2$ at $m=2$, so the rival maximizer is the first member of this family rather than an isolated exception. The Wolf spaces give $1.115547$ and $0.852944$, the complex Grassmannians $0.720082$ and $0.596068$. All sit far below $\sqrt{3/2}$. Three of these are ungraded, with slack between $0.57$ and $0.96$, so they bear on the critical-point census rather than on the graded enumeration.

### The canonical form, quoted alongside without comment

Ricci-flatness together with the first Bianchi identity cuts each one-parameter-per-factor reducible-isotropy family down to a one-dimensional space of Weyl operators, so the critical point in each family is forced rather than found, and there is exactly one per family. For the $\mathbb{CP}^m$ family the value is $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, exactly $\tfrac32$ at $m=2$ and strictly decreasing in $m$. Every other family's point sits below the threshold. The lemma reaches the reducible-isotropy families and no other critical point.

### The landscape summary, quoted alongside without comment

**Lemma L10 (landscape). The reducible-isotropy families carry one critical point each, all below the threshold.**

## Phase 2, the clustering

**Reports:** [VERIFY_v107](VERIFY_v107.md) `BROKEN`, [VERIFY_v108](VERIFY_v108.md) `BROKEN`, [VERIFY_v109](VERIFY_v109.md) `BROKEN`. **Unanimous on every cluster below.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | "all below the threshold" | $\theta^2\vert_{m=2}=\tfrac96=\tfrac32$, so the family **attains** $\sqrt{3/2}$ at the member the block itself calls the rival maximizer | v107, v108, v109 |
| **C2** | "exactly one critical point per family" | a line meets the sphere at $\pm W$ and $Q(-W)=Q(W)=(-\theta)(-W)$, so both are critical; the source said "up to sign" and the qualifier was dropped | v107, v108, v109 |
| **C3** | the one-dimensionality | a table of computed ranks at nine members of five families, against a claim quantified over *each* family | v107, v108, v109 |
| **C4** | the closed form's provenance | it **is** derivable, from Fox's $\lvert S^r\rvert^2=\frac{6r(r-2)}{(r+2)(r-1)}$ at $r=2m$, read at source, and the block cites none of it, offering the unproved dimension count instead | v107, v108, v109 |
| **C5** | "All sit far below $\sqrt{3/2}$" | $\mathbb{HP}^2$ is at $91.1\%$ of the threshold, a gap of $0.1092$ that the same file calls tight | v108, v109 |
| **C6** | the class the bound quantifies over | the mechanism is derived for $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$, and $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ is one-parameter-per-factor with $\theta^2=\tfrac{55}{36}$, **above** the threshold, a value this same file records | v109 |
| **C7** | "reducible-isotropy" | $\mathfrak u(m)$ acts *irreducibly* on $\mathbb R^{2m}$; the same file uses the word in the representation sense elsewhere | v108, v109 |
| **C8** | [INDEX-results.md](../findings/INDEX-results.md):25's "Gate 2 passed" | the two cited reviewers returned *CONFIRMED with two caveats* and *PLAUSIBLE-with-defect*, **and both flagged this very headline** | v107, v108, v109 |
| **C9** | $m=1$ | admitted by every copy of the statement, and doubly inadmissible, zero denominator, and Fox declares $S^2(\alpha)$ trivial | v109 |
| **C10** | the mechanism clause at :442 | "Ricci-flatness imposes *two* linear conditions" is inconsistent with the table it cites and belongs to the real-Grassmannian section, where Bianchi is not needed | v108, v109 |
| **C11** | the complex-Grassmannian clause | a universal standing on two computed members with no closed form anywhere on the record, **the only place a falsifier could live** | v107, v109 |

**Withdrawn:** the $2/3$ limit, "first member of this family", $\theta^2=45/56$ at $m=8$, and the slack interval's rounding, all correct.

## Phase 3, adjudication

**Three verifiers, three `BROKEN`, no contradiction between them on any value.** Every stated number was reproduced by hand independently: $3/2$, $10/9$, $35/36$, $9/10$, $77/90$, $52/63$, $45/56$, the four decimals, the limit, and the monotonicity via the derivative numerator $-3(3m^2-2m+1)$.

**C1 and C2 are the round, and they are different kinds of error.** C1 is a false statement about a value everyone computes correctly. **C2 is a miscount that survives because $P$ is odd and the record kept only the positive branch**, the same sign structure that broke L57's equality clause two rounds ago, in a different file and a different lemma.

**C6 shows the two clauses cannot both be about the same class.** The mechanism is derived for one class and the bound asserted over another, and on the mechanism's own class the bound is false at $n=12$, at the record's *conjectured global maximiser*.

**C8 is the trap operating on a status stamp.** A row saying "Gate 2 passed" is a citable claim about the record's own confidence, and this one was false on its own citations while carrying the sentence both cited reviewers had flagged.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `BROKEN`. Impact: `PROPAGATES`**, the $\mathbb{CP}^m$ closed form and its monotonicity `SURVIVE` and are now sourced; the headline, the count and the index row were `UNSUPPORTED` and are rewritten.

- **The block is rewritten**, stating the closed form with Fox as its source rather than the dimension count; $m\ge2$ as part of the statement; **two** critical points $\pm W$ with the value on the $P>0$ branch; the one-dimensionality as an owed computation; the class as the listed families with $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ named as what the wider reading would wrongly admit; and the $\mathbb{HP}^2$ gap given as $91.1\%$ of the threshold rather than "far below".
- **Both [results.md](../results.md) forms are corrected**, landscape and canonical.
- **[INDEX-results.md](../findings/INDEX-results.md):25 no longer says "Gate 2 passed"**; it states what the two verdicts actually were and that both flagged the headline.
- **The mechanism clause at :442** now reads *one* linear condition, names where the *two* belongs, and carries the sign qualifier.

*The correction to C1 had been written four times before this round, twice in reviews, once in the ledger where it was used to reject an L10 citation, and once in the Lean index, and had reached the statement none of those times. [L10.lean](../lean/HamiltonsCubic/Results/L10.lean) has been right throughout, proving `cpSq_two_attains` alongside `cpSq_lt_threshold` for `3 ≤ m`.*
