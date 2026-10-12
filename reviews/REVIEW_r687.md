# Review r687, Lemma L90, "evaluation is injective on the image"

**Reviewer A of a pair on identical briefs. Target: the block headed `#### Lemma L90` in [findings/sym3-blocks.md](../findings/sym3-blocks.md), located by heading text and found at line 141 of a 245-line file. Analysis only; no computation was run, and no numerical claim below is mine, arithmetic is hand arithmetic, done as a screen on claims I record.**

## Verdict: GAP

**The theorem is true and closes exactly, over $\mathbb Q$, with no genericity assumption anywhere.** I rebuilt it cold and it holds: the $40$ recorded points are certified unisolvent for the image *a posteriori* by an attained rank, so nothing here rests on the points being generic. That is the difference the brief asks about, and it falls on the good side of it.

**The block does not contain that argument. It contains the argument its own author withdrew as circular, on the same day, in a commit that never touched [findings/](../findings/).**

| # | defect | severity |
| --- | --- | --- |
| D1 | The stated proof (*"$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes"*), is the one [r214](REVIEW_r214.md) refuted as circular. Nothing measures $\mathrm{rank}\,\mu$; sampling's inequality runs the wrong way. The repair commit `cf4a7fdf` touched two scripts and no finding, so the withdrawn sentence is still the record's proof, byte-identical since 2026-08-29. | **the block's proof is a non-argument** |
| D2 | *"was nowhere in the record"* is **false**. The identical step entered this same file **one day earlier** and now sits **eight lines above L90's heading**, inside [L89](../findings/sym3-blocks.md)'s block, as r204's unisolvence note. | false novelty claim |
| D3 | The block **contradicts itself ten lines apart**: $\boxed{\mathrm{rank}=13}$, then *"the rank is open in $[1,13]$"*. Both strata are inside L90, the second superseded by the first on 2026-08-29 and never removed. | live self-contradiction |
| D4 | *"measured at four primes"* **conflates two computations at two scales**. The block's own next paragraph names $1000033$ and $1000003$; the four primes near $2^{40}$ are the certificate's row lift, and [r211](REVIEW_r211.md) does report the sampled rank matching mod three of them. So the phrase is defensible only by a reading the block never gives, while the block names two. | ambiguous, and unreconciled twelve lines later |
| D5 | The block's **strongest evidence goes unclaimed**: [r211](REVIEW_r211.md) computed $\mathrm{rank}_{\mathbb Q}(A)=13$ **exactly over $\mathbb Q$**, with controls that fail on a single perturbed entry. The block quotes only mod-$p$ ranks and a floating-point gap. | understated |
| D6 | Eight reviewers are cited by bare number ($181$, $182$, $203$, $208$, $209$, $210$, $211$, $212$), with **no link to any of them**, in a file whose sibling blocks link every review they name. The block resolves exactly one pointer, to [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py), and that one is good. | citation format |

**Everything the block attributes to r208, r209, r210, r211 and r212 checks out against those reviews.** The three-bullet list of hypotheses is faithfully sourced, down to r209's *"expansion vector, unconjugated"* and the multiplicity Gram cancelling against the conjugation. The failure is in the block's own two-sentence proof and in its account of its own novelty, not in its scholarship.

## Readings adopted, stated as the brief requires

- **$\mu$ is the restricted map**, $\mathrm{Sym}^2(K)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, where $K$ is the cubics cut out by $\sigma_\lambda(W_0)=0$. [L59](../findings/sym3-blocks.md)'s audit records that this file writes $\mu$ for the restricted and unrestricted maps in consecutive sentences; **L90 means the restricted one throughout**, and every number in it ($13$, $23$, $34$, $36$, $47$) is consistent only with that reading.
- **$\mathrm{ev}$ is evaluation at the $40$ sample tensors**, $\mathrm{ev}:(\mathrm{Sym}^6\mathcal W_5)^{O(5)}\to\mathbb R^{40}$, $F\mapsto(F(W_1),\dots,F(W_{40}))$. The points are drawn by `rand_weyl_tensor` at [run_n5_assemble.py:917](../scripts/runs/run_n5_assemble.py#L917).
- **The source is the $47$-dimensional Hermitian parametrisation** over $\mathbb Q(i)$, of which $36$ are the real unknowns and $11$ are gauge. Checked by hand from [L86](../findings/sym3-blocks.md)'s shape *two $3\times3$, five $2\times2$, nine scalars*: $\sum k^2=18+20+9=47$, $\sum\binom{k+1}2=12+15+9=36$, $\sum\binom k2=6+5+0=11$, and $47-36=11$.
- **Apolarity as [L59](../findings/sym3-blocks.md) states it**, $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, with the pairing left unnamed there and inert here, every use below is scale-free.
- **$\theta_0$, $S_{XYZ}$, $t$ and the $iklj$ order** are quoted from [conventions.md](../findings/conventions.md) and **none of them enters this block**. L90 is pure linear algebra over the certificate's own spaces; the repaired entries do not reach it.

## 1. The injectivity, derived cold

**The statement.** $\mathrm{ev}$ restricted to $\mathrm{im}\,\mu$ is injective, so a sextic in the image is pinned by its $40$ values.

**What forces it is neither a dimension count on the points nor general position, it is an attained rank.** In three lines:

1. $\mathrm{rank}(\mathrm{ev}\circ\mu)=\dim\mathrm{ev}(\mathrm{im}\,\mu)\le\dim\mathrm{im}\,\mu=\mathrm{rank}\,\mu$. Sampling only loses rank; this is the *only* inequality it supplies, and it runs from the measured side to the unmeasured one.
2. $\mathrm{rank}\,\mu\le13$ is a **theorem**, [L62](../findings/sym3-blocks.md)'s order-$1$ cap, which is also L90's own last bullet: every product of two cubics of $K$ vanishes at $W_0$, evaluation at $W_0$ is a nonzero functional on [L85](../findings/sym3-blocks.md)'s $14$ (witness $\lVert W\rVert^6$, value $1$), so the image lies in a $13$-dimensional subspace.
3. $\mathrm{rank}(\mathrm{ev}\circ\mu)=13$ is **measured**, mod $1000033$ by the pipeline, mod $1000003$ by [r209](REVIEW_r209.md) on its own code and its own points, and **exactly over $\mathbb Q$** by [r211](REVIEW_r211.md), whose controls move the rank to $14$ under a single perturbed entry.

Then $13\le\mathrm{rank}\,\mu\le13$, so $\mathrm{ev}(\mathrm{im}\,\mu)$ has dimension $13=\dim\mathrm{im}\,\mu$ and $\mathrm{ev}$ is injective there. **The cap is what closes it, and the cap is a theorem.**

**Why the block's version fails.** It asserts the two $13$s as *both* measured. Only the composite is. Read literally the argument is $\mathrm{rank}(\mathrm{ev}\circ\mu)=13\Rightarrow\mathrm{rank}\,\mu=13$, which is the failure mode the claim exists to exclude: were $\mathrm{rank}\,\mu=14$, the kernels would differ by one dimension and the Gram's sextic could agree with $F_5$ at those $40$ points and nowhere else. The containment $\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$ and *"equal dimensions force equal kernels"* are both correct (they are rank-nullity dressed differently) and they are not the disputed step.

**The repair is twelve lines below the defect, in the same block**, as *"Upper bound $13$, and it comes from order $1$"*. So the answer was in the block, under the block's own heading, and the block did not use it. This is the checklist item that keeps paying.

**Genericity is not assumed and not needed.** The $40$ points are pseudo-random draws with no general-position hypothesis stated or checked, and none is required: the attained rank certifies *these* points, and an exact rank over $\mathbb Q$ certifies them without a probabilistic reading. Had the rank come out below the cap, the conclusion would simply be unavailable, which is the honest shape.

**One trap the block flags and should be read against this:** *"a defect landing the rank exactly on the cap is invisible"*. It is L90's own third bullet, and this argument is exactly that configuration. The guard is the multi-probe Schur test, which the block correctly names load-bearing.

**$F_5$ in the image is a separate step and the block needs it.** Injectivity on $\mathrm{im}\,\mu$ says two *image* elements agreeing at the $40$ points coincide; $F_5$ must be known to be in the image before agreement with it forces equality. The block supplies this, and correctly: $\mathrm{rank}=13$ gives $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$ by the cap's own witness, and $F_5\perp\mathcal A(W_0^6)$ because $F_5(W_0)=0$. Equivalently and more cheaply: $\mathrm{im}\,\mu$ is $13$-dimensional inside the $13$-dimensional $\{F:F(W_0)=0\}$, hence equal to it, hence contains $F_5$. **[r214](REVIEW_r214.md) reached that same one-line form**; the block reaches the conclusion by the longer route and does not say which fact does the work.

## 2. Is $40$ enough, and why $40$?

**Yes, with margin, and $40$ is not derived from anything.**

| quantity | value | where |
| --- | --- | --- |
| $\dim\mathrm{im}\,\mu$ | $13$ | the cap, attained |
| $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ | $14$ | [L85](../findings/sym3-blocks.md) |
| points needed for injectivity on the image | $\ge13$ | rank |
| points needed for injectivity on **all** invariant sextics | $\ge14$ | rank |
| points used | $40$ | `NSAMP = 40`, [run_n5_assemble.py:913](../scripts/runs/run_n5_assemble.py#L913) |

`NSAMP = 40` is a bare constant with no comment and no derivation; the $27$ surplus equations are what give the consistency test $\mathrm{rank}[A\mid F_5]=\mathrm{rank}\,A$ its bug-detecting value.

**$40$ is not another view of $14$, $36$ or $65$.** I checked the arithmetic and found no relation: it is neither $36+4$ in any meaningful sense nor a moment of the multiplicity column, and the sampled system's own numbers close without it, $47-13=34$ is the exact kernel the certificate uses, $36-13=23$ is the real affine family, and $34=23+11$ recovers the gauge count exactly. **The one coincidence worth a warning: $40$ is also the Casimir value of the colliding pair $(4,3)$ and $(5,0)$ in [L84](../findings/sym3-blocks.md)'s list, four sections above, and the two have nothing to do with each other.**

**What $40$ buys that $13$ would not.** [r213](REVIEW_r213.md) measured the $40\times120$ evaluation matrix of explicit invariant sextics at rank $14$ against a cap of $14$, so evaluation at those points is injective on **every** invariant sextic, a statement about the points alone, needing neither $\mathrm{rank}\,\mu$ nor $F_5\in\mathrm{im}\,\mu$. That is the clean form of L90, it is the direct answer to the unisolvence question [L89](../findings/sym3-blocks.md) records as open, and **it is nowhere in [findings/](../findings/)**. It is also numerical (a $14$-decade singular-value gap) where the route in §1 closes exactly over $\mathbb Q$, so the two are worth keeping side by side rather than substituting one for the other.

## 3. "Was nowhere in the record", refuted

**Checked with `git`, as the brief directs, and it fails.**

| strand | what it shows |
| --- | --- |
| `git log -S"evaluation is injective on the image"` | first appears in `f3309892`, 2026-08-29, whose own message says *"the load-bearing step that was nowhere in the record"*, the claim is original to the block, not a later gloss |
| `git show ec35c0b9 -- findings/` | **2026-08-28**, one day earlier, adds to this same file: *"the pipeline's $A$ is the sampled coefficient matrix, whose rank is $\le14$ with equality only when the sample points are unisolvent for the $14$ invariants. No theorem supplies unisolvence"* |
| position today | that sentence is **eight lines above L90's heading**, inside [L89](../findings/sym3-blocks.md)'s block |

**Unisolvence and "evaluation is injective" are the same property.** The record held the step, in the same file, stated precisely and attributed, and flagged as unsupplied. What L90 added was an argument, a defective one. The honest sentence is *"the step was recorded as open by r204 and is discharged here"*, which is both true and stronger.

**This is not a manufactured provenance of [L84](../findings/sym3-blocks.md)'s kind.** No event is invented; a novelty claim is simply wrong, and it was wrong on the day it was written.

## 4. The two audits, and whether the ordering fix landed

**Both audits are real and both found real errors.** [r212](REVIEW_r212.md) and [r211](REVIEW_r211.md), independently, within two minutes on 2026-08-29: `herm_row` walked the blocks by $(-m,\lambda)$ while the dump walked them by $\lambda$, so the SDP partitioned the $47$ columns into the wrong blocks and the reported point had minimum eigenvalue $-1440$ rather than $+1.416$.

**The fix landed**, at `57fb44d5`, and it is in the current file: the dump derives its order from `ADAPTED` at the dump site rather than restating it, and the block's corrected figures, $t=2.336698\times10^{-2}$, optimal and interior, are the rerun's own.

**Two things the brief asks about, and the answers differ.**

- **Is the ordering convention stated anywhere?** **No.** It exists as one sort key in one script and a comment beside it. [conventions.md](../findings/conventions.md), the file whose stated purpose is that *"a convention restated in two files is a convention that will disagree with itself"*, carries no entry for the block order, though it carries entries for ordered pairs, ordered slots and ordered sums. **This is precisely the unstated ordering that silently reappears**, and the same file already lost a cycle to the ordered/unordered reading of $K$.
- **Does the guard have teeth?** **Less than the commit claims.** The assert added beside the fix compares $\sum_\lambda k_\lambda^2$ against the row length. That total is **invariant under every permutation of the block order**, so the assert detects a count mismatch and cannot detect the defect it was added for. What actually protects the consumer is that the dump now writes its own `blocks` and `shape` lists, making the file self-describing, a good fix, guarded by an assert that is not the guard.

**The block's second error is attributed loosely.** *"Two audits stand behind it, and both found real errors"* is true of the ordering; the inline-LDL acceptance of the denominator-$10^4$ point was caught by a Sylvester check, and the class of defect is credited to reviewers 181 and 182, per [run_n5_verify.py](../scripts/runs/run_n5_verify.py)'s own header. Grouping it under *"the two audits"* reads as r211/r212 having found it. **The claim that the accepted point is verified by a file sharing no code with its producer holds**, [run_n5_verify.py](../scripts/runs/run_n5_verify.py) imports nothing from the pipeline and goes through characteristic polynomials and Sturm sequences.

## 5. What consumes L90, and the L62 filing

**Badly filed, not circular.** The dependency graph is acyclic and runs one way:

```
order-1 cap (theorem)  +  sampled rank 13 (r211, exact over Q)
        |                         |
        +------------+------------+
                     v
        rank = 13  ->  dim ANN = 1  ->  F_5 in im(mu)      [L62]
                     v
        ev injective on im(mu)                              [L90]
                     v
        the 40 equations give an identity
```

**L62 consumes nothing from L90**: its two inputs are the cap and the sampled rank, neither of which mentions evaluation injectivity. L90 consumes L62's conclusion twice over, for $\mathrm{rank}\,\mu=13$ and for $F_5\in\mathrm{im}\,\mu$. **A reader landing on L90 meets the consumer before the producer, and meets L62's whole proof restated inside L90 on the way**, which is why the ordering looks circular and is not.

**The duplication is real, in three of the four kinds the brief names.**

1. **Numbered twice.** $\mathrm{rank}=13$, $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$ and $F_5\perp\mathrm{ANN}$ are stated in full under L90's heading and again, with the same argument, in L62's trailing paragraph at the end of the file. The order-$1$ cap is stated under **both**.
2. **Under a foreign heading.** The pairing *"Upper bound $13$"* / *"Lower bound $1$"* is one bullet list cut in half by the L91 heading placed over it at `8d869d2c`. The upper half now reads as L90's and is L62's theorem; the lower half is L91's own statement, correctly.
3. **A stale stratum preserved.** *"the rank is open in $[1,13]$"* entered at `ec35c0b9` on 2026-08-28 and was superseded by `d7fd5fce` on 2026-08-29. The superseding text was appended and the superseded text left, so **L90 now asserts both, ten lines apart**, and [L91](../findings/sym3-blocks.md)'s *"tightness is open"* carries a third reading immediately below.
4. **Outside [findings/](../findings/)**: nothing of L90's own text. Neither [results.md](../results.md) nor [report/](../report/) mentions the $40$ points or the injectivity, so the defective wording has not propagated. **What did propagate is the conclusion it carries**: [results.md](../results.md) tables the certificate as **Proven**, crediting Lemmas $59$ and $61$–$65$ and citing L90 nowhere, so the step the record calls load-bearing supports a `Proven` row it is not named in. The label survives the repair of §1, which is why this is a filing defect and not a retraction. L90 is indexed, correctly, at [INDEX-results.md](../findings/INDEX-results.md) row $90$, *"Gate 2: no verdict on the record"*.

## What the block owes

1. **Replace the two-sentence proof** with the three-line chain of §1 (cap, sampled rank, squeeze) and say that the cap is [L62](../findings/sym3-blocks.md)'s and a theorem. One sentence changes a non-argument into an argument.
2. **Withdraw *"was nowhere in the record"***, and cite r204's unisolvence note eight lines above as the statement of the gap this block closes.
3. **Delete the stale *"open in $[1,13]$"* paragraph** or date it explicitly as superseded. A numbered Lemma cannot hold its own negation ten lines from its conclusion.
4. **Replace *"measured at four primes"*** with what was actually done: $\mathrm{rank}_{\mathbb Q}(A)=13$ exactly over $\mathbb Q$ ([r211](REVIEW_r211.md)), matching the reduction mod the lift's $41$-bit primes and reproduced independently mod $1000003$ ([r209](REVIEW_r209.md)) against the pipeline's $1000033$. The exact result is the stronger one and the block is currently quoting the weaker.
5. **Record r213's stronger statement** (evaluation at those $40$ points is injective on all $14$ invariant sextics) as the point-only form, marked numerical.
6. **Table the block order in [conventions.md](../findings/conventions.md)**: $(-m,\lambda)$, descending multiplicity then lexicographic, the order `herm_row` walks. It is the one thing here that will come back.
7. **Link the reviews.** Eight bare reviewer numbers in one block, zero links.

## What I did not do

**No computation was run.** The exact ranks, the mod-$p$ ranks, the singular-value gap and the eigenvalue figures are all read from the reviews and commits that produced them; where I say a number checks, it is hand arithmetic on the block's own quantities ($47=18+20+9$, $36=12+15+9$, $11=47-36$, $34=47-13$, $23=36-13$, $34=23+11$). **Deciding whether the sampled rank is still $13$ under a fresh point set would need a run**, and it would decide only robustness, not the theorem: the recorded rank is exact over $\mathbb Q$, so a re-run at new points that came out $13$ would add nothing, and one that came out lower would indict the new points rather than the claim.
