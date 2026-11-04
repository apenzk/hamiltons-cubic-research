# Round L61, the $M(5)=\sqrt{3/2}$ certificate

**Opened** 2026-09-05. **Verifiers allocated**: v57, v58, v59.

*`v54`, `v55`, `v56` are reserved by the open [ROUND_L147-r2](ROUND_L147r2.md) and are not reused here.*

## Sources, quoted at `file:line`

| what | where |
|---|---|
| the findings statement | [sym3-blocks.md:326](../findings/sym3-blocks.md) |
| the canonical statement | [results.md:204](../results.md), [results.md:623-628](../results.md) |
| the status-table form | [results.md:23](../results.md) |
| the achievements form | [results.md:40](../results.md) |

## The statement, three ways

**findings/sym3-blocks.md:326**,

> $F_5=\tfrac32\|W\|^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a sum of squares of cubics vanishing on the $O(5)$-orbit of $W_0$, the padded $W_{\CP^2}$. Hence $\theta\le\sqrt{3/2}$ on $\Weyl_5$, with equality exactly on that orbit.

**results.md:204**,

> $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a sum of squares of cubics vanishing on the $O(5)$-orbit of padded $W_{\mathbb{CP}^2}$, **with exact rational coefficients**. Hence $\theta\le\sqrt{3/2}$ on all of $\mathcal W_5$, critical or not, with equality exactly on that orbit.

**results.md:23**, the status table,

> **Certificate: an inequality on a machine certificate, resting on two measured links**

**results.md:40**,

> $M(5)=\sqrt{3/2}$ holds on all of $\mathcal W_5$ by an **exact rational certificate**

**The difference between these is the round's first finding**, recorded here before any verifier saw it: the canonical statement and one summary call the certificate *exact rational*, while the status table calls it *an inequality on a machine certificate resting on two measured links*. Both are in the brief, unlabelled.

## Phase 1, dispatch

Three verifiers, identical briefs, cold. Reports at `verification/VERIFY_v57.md`, `v58`, `v59`.

## Phase 2, clustering

**Reports**: [v57](VERIFY_v57.md) `GAP` · [v58](VERIFY_v58.md) `GAP` · [v59](VERIFY_v59.md) `GAP`. Unanimous on the verdict and on where the defect sits.

### The two zero-cost checks, run before any adjudication

**1. Brief against source**, the quotes at [sym3-blocks.md:326](../findings/sym3-blocks.md) and [results.md:204](../results.md) match the files verbatim. No mis-transcription.

**2. Search the record before accepting "no argument on file"**, no verifier claimed the argument absent, but the loop checked the adjacent question: *does an exact rank exist anywhere for the 40-point injectivity?* `rank_modp` is implemented and used across [scripts/](../scripts/), and [c4_ev_injective.py:63-64](../scripts/reviewers/r213/c4_ev_injective.py) uses `np.linalg.svd` with a relative threshold `1e-10` instead. **The sound instrument is in the repository and was not used at the one place it was needed.**

### Clustering table

| id | step attacked | mechanism | support |
|---|---|---|---|
| **D1** | step 6, evaluation at the 40 points is injective, so agreement there is an identity | the injectivity is a float64 SVD rank at relative threshold `1e-10`; a mod-$p$ rank would close it, the cap of 14 meaning a *lower* bound suffices | 3/3 |
| **D2** | the equality clause, "with equality exactly on that orbit" | $F_5$ is even, so $Z(F_5)$ contains $O(5)\cdot(-W_0)$, a distinct orbit; and a positive-definite Gram determines no zero set at all | 3/3 |
| **D3** | forms A–D of the statement | two assert *exact rational certificate*, one records *resting on two measured links*; they are not one statement | 3/3 |
| **D4** | the caveated form's named dependency | [results.md:23](../results.md) names [L87](../findings/sym3-blocks.md)'s rank and [L62](../findings/sym3-blocks.md)'s value, **both mod-$p$**, the sound direction. The float SVD appears in none of the four forms | 1/3 |

**D3 and D4 are not adjudicated.** They are claims about what the record's own text says, not about whether a proof step follows, and the neutral question *"prove this step valid as written"* has no purchase on them. Both were verified by the loop directly against source, above and at [results.md:23](../results.md). Recorded here with that reason rather than spending four verifiers on a reading.

**D1 and D2 go to phase 3**: v60, v61 on D1; v62, v63 on D2.

### A defect in the brief, recorded against the round's own evidence

**The brief asked whether the rank claim was "exact or numerical".** The loop had found that answer itself before the round opened, and put the question in. So the 3/3 support on D1 is **weaker than unanimity normally is**, the verifiers were pointed at the place. What was not steered, and carries independent weight: v59's proof of step 1 from $B_2\cong C_2$, its second anchor at $S^2\times S^3$, its falsifier enumeration, and v57's location of the exact line and threshold.

*The rule this suggests: a brief may name a step to check and must not name the property to look for.*

### Not findings, recorded so they are not re-derived

- **Step 1 is true and now proved** (v59): $(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ is one-dimensional, via $B_2\cong C_2$, $\mathcal W_5\cong\mathrm{Sym}^4\mathbb C^4$ and Littlewood in the stable range.
- **A second anchor** (v59): $S^2\times S^3$ returns $2\sqrt2/3=\Theta_5$ exactly, kernel-free, which the record does not carry.
- **$47=36+11$** (v57): the certificate's Hermitian count and [L59](../findings/sym3-blocks.md)'s real-symmetric one are one object counted twice.
- **The content is a rank statement** (v57): $\max p_3$ on the rank-$\le r$ stratum is $(r-2)/\sqrt{r(r-1)}$, equal to $1/\sqrt6$ exactly at $r=3$, so the certificate is about forbidding rank $\ge4$.
- **A falsifier shape survives** (v59): spectrum $(3,-1,-1,-1,0^6)/\sqrt{12}$ gives $\theta=\sqrt3$ and clears [L73](../findings/bounds.md) at equality, with no closed-form obstruction on the record. **The certificate is load-bearing, not decorative.**

### Withdrawn candidates

- *"Injectivity proven at the wrong 40 points"* (v57), r213's `range(41)`/skip-first faithfully reproduces [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py), where a probe draw precedes the sample loop. No object at which the sets differ.
- *"L59's 36 against the certificate's 47"* (v59), $47=36+11$, real-symmetric plus imaginary.
- *"exact rational coefficients against a Gaussian-rational Hermitian Gram"* (v59), recorded with its reason in that report.

## Phase 3, adjudication

| finding | adjudicators | outcome |
|---|---|---|
| **D1**, the injectivity behind the identity | [v60](VERIFY_v60.md) `FAILS` · [v61](VERIFY_v61.md) `VALID AS WRITTEN` | **split, settled by the loop, below** |
| **D2**, the equality clause | [v62](VERIFY_v62.md) `FAILS` · [v63](VERIFY_v63.md) `FAILS` | **confirmed** |

### D1, the split, and how the loop settled it

v60 read the cited computation and found it a float64 SVD rank at a stipulated threshold, with the perturbation bound the argument needs (an *upper* bound, by Weyl's inequality), nowhere computed. **That reading is correct.**

v61 found a second computation the other four reports missed: [run_n5_assemble.py:913-953](../scripts/runs/run_n5_assemble.py) performs Gauss–Jordan over $\mathbb F_p$ on the same evaluation matrix. **The loop verified this at source rather than taking it:**

- **Same points.** [c4_ev_injective.py:26](../scripts/reviewers/r213/c4_ev_injective.py) sets `random.seed(20260829)` and draws 35 `randint(-4,4)` per sample, skipping draw 0. [run_n5_assemble.py:894](../scripts/runs/run_n5_assemble.py) sets `_r5.seed(20260829)` and `rand_weyl_tensor()` draws 35 `randint(-4,4)`, with `_probe` consuming draw 0. **Identical seed, identical draw shape, identical offset, the two point sets are the same 40 tensors.**
- **Rank 14, exactly, at several primes.** `sampled rank at 40 points, mod 1000033: 14` and the same at `1099511627873` and `1099511627933`.
- **The cap is exact and independent**, so $14=\mathop{\mathrm{rank}}_{\mathbb F_p}\le\mathop{\mathrm{rank}}_{\mathbb Q}\le14$ closes it. With the cap in force, injectivity is a *lower* bound, and a lower bound is exactly what a mod-$p$ reduction gives.

**Resolution: the step is VALID. D1 is not a defect in the mathematics.** It is three defects in the record of it:

1. **Mis-citation.** [REVIEW_r213.md:143-150](../reviews/REVIEW_r213.md) and [run_n5_verify.py:144-148](../scripts/runs/run_n5_verify.py) hang the step on the float SVD. The proof is the mod-$p$ rank, cited nowhere for this purpose.
2. **The evidence is untracked.** `agent_logs/` is gitignored ([.gitignore:7](../.gitignore)). The exact rank exists only in local transcripts; a fresh clone cannot see it.
3. **Printed, never asserted.** [run_n5_assemble.py:944](../scripts/runs/run_n5_assemble.py) branches on `r == 14` with a `print`; the only `assert` is the upper bound at line 950. **A future run dropping to 13 exits 0 and the step goes quiet.**

*Both adjudicators were right about different things, and neither alone would have produced this.* The three original reports read the cited route and stopped there, which is what the brief asked them to do, and is the cost of a brief that names where to look.

### D2, confirmed, and the failure is structural

Both adjudicators derived the same identity independently: with $P=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$,

$$F_5(W)=\lVert W\rVert^6\left(\tfrac32-\theta(W)^2\right).$$

So $Z(F_5)$ is the **two-sided** equality locus plus the origin, while the clause names the maximiser set alone. Three closed-form grounds against the converse:

- **Parity.** $F_5$ even and the cubics odd force vanishing on $O(5)\cdot(-W_0)$, a distinct orbit, its spectrum $(-2,1,1,0^7)/\sqrt6$ is not $W_0$'s, and $O(5)$ preserves spectra. The inference proves too much.
- **Homogeneity.** $Z(F_5)$ is a cone containing $0$ and every $tW_0$. This makes the clause **literally false** in the two forms omitting $\lVert W\rVert=1$; [results.md:625](../results.md) says *"every unit $W$"* and escapes it.
- **Structural.** A degree-6 SOS forces homogeneous cubic summands, hence odd, hence $Z=-Z$ and a cone. **No certificate of this shape can have the orbit as its zero set**, the clause is unreachable by that route, not merely unproven by it.

**A free strengthening comes with it, and is not currently claimed:** the certificate proves the two-sided $\lvert\theta\rvert\le\sqrt{3/2}$.

## Phase 4, the spread

### Copies of the statement, hunted before citations of it

**Five full statements of L61 exist**, not one original and four citations:

| site | carries the equality clause | carries D1's mis-citation |
|---|---|---|
| [sym3-blocks.md:326](../findings/sym3-blocks.md) (the canonical block | **yes** |), |
| [sym3-blocks.md:198](../findings/sym3-blocks.md), **a second original in the same file** | no | **yes**, and worse (below) |
| [results.md:204](../results.md) | **yes** | *"with exact rational coefficients"* |
| [results.md:625](../results.md) | **yes**, but says *"every unit $W$"* | *"an exact rational certificate"* |
| [report/sections/07-gradedness-split.tex:879](../report/sections/07-gradedness-split.tex) | **yes**, verbatim |, |

**[sym3-blocks.md:198](../findings/sym3-blocks.md) is the sharpest case the skill's copy rule describes.** It reads:

> exhibited by a Gram with **rational** entries at denominator $10^5$ … Every step is exact over $\mathbb Q$.

The block at 310 **already records that figure as false**, 13 of 47 coordinates reach $5\times10^{16}$, and the `denominator` field names the rounding rather than the point. *The correction was made at one site and the second original in the same file still stands, uncorrected and correct-looking.* Its second sentence is also the D1 mis-citation in its strongest form.

### The refutation was already in the file

[sym3-blocks.md:106](../findings/sym3-blocks.md) reads:

> cubics are odd, so vanishing on $O(5)\cdot W_0$ **automatically** forces vanishing on the orbit of $-W_0$

That is D2's parity ground, stated **220 lines above the block that asserts the clause it kills**, and flagged there as *"a positive result the block is missing"*. The round did not discover the refutation; it discovered that the record already held it and had not applied it.

### Dispositions

**Nothing on the record uses the equality clause.** The searches for a consumer (a uniqueness claim, an "only member", an equality case cited downstream), return only [results.md:23](../results.md), which records the clause as *unproven*. Every dependent uses the **bound** $M(5)=\sqrt{3/2}$, which survives untouched and is strengthened to the two-sided $\lvert\theta\rvert\le\sqrt{3/2}$.

| dependent | disposition | why |
|---|---|---|
| [results.md:40](../results.md), *the low strata are closed* | `SURVIVES` | uses the bound only |
| [report/sections/09-status.tex:12](../report/sections/09-status.tex), *Proven* | `NARROWED` | the bound is proven; *"exact rational sum-of-squares certificate"* overstates the artefact |
| [report/diagram.tex:85](../report/sections/diagram.tex), [diagram-closed.tex:97](../report/sections/diagram-closed.tex) | `SURVIVES` | name the value, not the clause |
| [findings/INDEX.md:38](../findings/INDEX.md) | `SURVIVES` | names the bound |

### Impact class: `CONTAINED`

The conclusion every dependent uses is reached and survives; no dependent is `UNSUPPORTED`. What falls is a clause nothing consumes, and what needs correcting is the record's description of its own artefact at five sites.

### Is the defect one of a class?

**Yes, and the class is enumerable.** Both defects are of one kind: *a correction applied at one site while a second full statement of the same result stands elsewhere*. [findings/INDEX.md](../findings/INDEX.md) and [results.md](../results.md) carry full statements for many results, and [report/sections/](../report/sections/) carries a third. **The siblings are every result whose statement appears in full in more than one file**, a candidate class for [plan-verification.md](../../plan-verification.md), settled one round at a time, not a verdict here.

## Phase 5, narrow

**Narrowed, not retracted.** The bound is proven and every dependent uses it; what falls is a clause nothing consumes.

| site | change |
|---|---|
| [sym3-blocks.md:326](../findings/sym3-blocks.md) | *"equality exactly on that orbit"* → *"equality on that orbit"*, two-sided bound, one line of provenance |
| [sym3-blocks.md:198](../findings/sym3-blocks.md) | the false `denominator $10^5$` replaced by the true $5\times10^{16}$ and what the field actually names; *"every step is exact over $\mathbb Q$"* replaced by which step is exact and which rests on the mod-$p$ rank |
| [results.md:204](../results.md) | clause narrowed, two-sided bound |
| [results.md:625](../results.md) | clause narrowed, two-sided bound |
| [results.md:23](../results.md) | *"resting on two measured links"* → the mod-$p$ ranks are proofs under an exact cap, not measurements |
| [report/07-gradedness-split.tex:879](../report/sections/07-gradedness-split.tex) | clause narrowed, two-sided bound |

**Deleted, not annotated.** No site keeps the old wording beside the new. The chronology is in [ATTEMPTS.md](../ATTEMPTS.md); one line of provenance stays at the canonical block.

**Two operational defects are recorded and not repaired here**, since repairing either means running something:

- the exact rank lives only in `agent_logs/`, gitignored, so a fresh clone cannot see it;
- [run_n5_assemble.py:944](../scripts/runs/run_n5_assemble.py) prints on `r == 14` and asserts only the upper bound, so a future run dropping to 13 exits 0.

## Phase 6, verdict

**`PROVEN, hypotheses corrected`** for the bound, **`BROKEN`** for the equality clause, impact **`CONTAINED`**.

- the bound $\lvert\theta\rvert\le\sqrt{3/2}$ on $\mathcal W_5$ holds, is two-sided, and its identity step is exact;
- *"with equality exactly on that orbit"* is false as written and unreachable by a certificate of this shape;
- no dependent is `UNSUPPORTED`.

**Verifiers**: v57, v58, v59 · adjudicated v60, v61 (split, settled by the loop) and v62, v63.

### What this round says about the loop

**The brief named the property to look for, and three reports found it and stopped.** All three located the float singular-value rank because the brief asked whether the rank was exact or numerical, a question carrying its own answer. Only the adjudication, which was asked a neutral question, found the mod-$p$ rank that makes the step sound.

*A brief may name the step to check. It must not name the property to look for.*
