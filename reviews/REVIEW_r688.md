# Review r688, Lemma L90, evaluation is injective on the image

*Reviewer B on the L90 brief. Review number **688**. A second reviewer holds r687 on an identical brief; I have read neither their report nor their log.*

**VERDICT: GAP, the conclusion is true and is established twice over on the record, by an argument L90 does not use; the argument L90 *does* use was refuted as circular on 2026-08-29 by [r214](REVIEW_r214.md), repaired the same morning in [run_n5_verify.py](../scripts/runs/run_n5_verify.py), and never propagated to [findings/sym3-blocks.md](../findings/sym3-blocks.md), which is now the last carrier of the retracted version.**

The block is not wrong about anything it concludes. It is wrong about why, and about who stands behind it.

---

## 1. Readings adopted, stated up front

From [conventions.md](../findings/conventions.md), read first as the brief instructs:

| symbol | reading I adopt | why it matters here |
| --- | --- | --- |
| $\mathcal W_5$ | the $O(5)$-irreducible $[2,2]$, $\dim 35$, highest weight $(2,2)$ in the $e$-basis | fixes the $B_2$ block table I re-derive in §5 |
| $\mu$ | **the restricted map**, $\mathrm{Sym}^2(K^*)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, where $K$ is the orbit-constrained cubics | L90 writes a bare $\mu$; twenty-five lines above, [L89](../findings/sym3-blocks.md) titles itself with the **unrestricted** $\mu$, of rank $14$. I read L90's as restricted because its value is $13$ |
| $\mathrm{ev}$ | evaluation of an invariant sextic at the fixed list of $40$ sample tensors, a map to $\mathbb R^{40}$ | the object the whole lemma is about |
| $\theta_0(n)$ | the closed form alone, per the 2026-09-04 repair | not consumed here; recorded because the brief asks |
| $S_{XYZ}$ | ordered slots, per the 2026-09-04 repair | not consumed here |
| "diagonal" | diagonal in coordinate $2$-planes | not consumed here |

**Two further readings the record does not supply, which I had to fix myself and which a reader will trip on**, see §7 and §5:

- **the block order** in the dumps and the certificate is $(-m_\lambda,\lambda)$ with $m_\lambda$ the **full** multiplicity of $\lambda$ in $\mathrm{Sym}^3\mathcal W_5$, *before* the orbit constraint removes one. Read with the surviving multiplicity instead, the order is different, and L90's own sentence about the bug says only "$(-m,\lambda)$";
- **there are two different sixteens**, and the file uses both without distinguishing them.

**Line anchors.** I located the block by heading text, as instructed. It is at [sym3-blocks.md:141](../findings/sym3-blocks.md#L141) today. Prior reviews cite it at `#L115` ([r597](REVIEW_r597.md), [r598](REVIEW_r598.md)) and `#L117` ([r634](REVIEW_r634.md)), **off by a fixed $+26$, so those pointers are stale rather than wrong**, and the offset is uniform across [r598](REVIEW_r598.md)'s five anchors into this file. [r633](REVIEW_r633.md)'s "sym3-blocks.md:121–135" for the boxed display maps to 147–161 under the same shift.

---

## 2. The map, the source, the target, and what "evaluation at $40$ points" means

Set up cold, from the definitions.

An SOS certificate for $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a positive semidefinite quadratic form $G$ on a space of cubics, whose associated sextic is $F_5$. Because $O(5)$ acts and $F_5$ is invariant, $G$ may be taken invariant. So:

- **the source** is $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}$, of dimension $65$ ([L88](../findings/sym3-blocks.md)); restricted to the orbit-constrained cubics $K$ it is $36$-dimensional ([L86](../findings/sym3-blocks.md), [L59](../findings/sym3-blocks.md)'s $65=36+29$);
- **the target** is $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, of dimension $14$ ([L85](../findings/sym3-blocks.md));
- **$\mu$** is multiplication, $q\cdot q'\mapsto qq'$, extended to the symmetric square.

The pipeline never compares coefficients in the $14$. It fixes $40$ sample tensors $W_1,\dots,W_{40}\in\mathcal W_5$ from a seeded RNG and imposes the $40$ scalar equations $\mu(G)(W_i)=F_5(W_i)$. So what the certificate satisfies is $\mathrm{ev}\big(\mu(G)-F_5\big)=0$ in $\mathbb R^{40}$.

**The gap the lemma exists to close is exactly one implication:** from $\mathrm{ev}(\mu(G)-F_5)=0$ to $\mu(G)=F_5$. Two things are needed and only one is named in the heading:

1. $\mu(G)-F_5$ must lie in a space on which $\mathrm{ev}$ is injective;
2. $F_5$ must lie in that space, or $\mu(G)-F_5$ is not in $\mathop{\mathrm{im}}\mu$ and (1) says nothing about it.

The block supplies (2) from [L62](../findings/sym3-blocks.md)'s $\dim\mathrm{ANN}=1$, and that half is correct, I check it in §4.3. Its trouble is entirely in (1).

---

## 3. The stated proof, and why it does not stand as written

L90's proof is three sentences. I quote the load-bearing one:

> Writing $\mu$ for the Gram-to-sextic map and $\mathrm{ev}$ for evaluation, $\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$ always, while $\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes. Equal dimensions force equal kernels, so $\mathrm{ev}$ is injective on the image.

**The linear algebra is right.** In fact it is tighter than the block says: for any linear $\mathrm{ev}$,
$$\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)=\dim\mathop{\mathrm{im}}\mu-\dim(\ker\mathrm{ev}\cap\mathop{\mathrm{im}}\mu),$$
so $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)=\mathop{\mathrm{rank}}\mu$ is *equivalent* to $\mathrm{ev}$ being injective on $\mathop{\mathrm{im}}\mu$. The kernel-containment sentence is not needed. No complaint here.

**The input is not right.** The clause *"$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured"* asserts a measurement of two quantities. **Only the first is measured, and the inequality sampling supplies runs the wrong way:**
$$\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)\ \le\ \mathop{\mathrm{rank}}\mu .$$
A sampled rank of $13$ therefore gives $\mathop{\mathrm{rank}}\mu\ge13$ and nothing else. Were $\mathop{\mathrm{rank}}\mu=14$, the sampled rank would still be free to read $13$, and that configuration is precisely the failure mode the lemma exists to exclude, a sextic in $\mathop{\mathrm{im}}\mu$ agreeing with $F_5$ at the $40$ points and nowhere else. **So the block's proof assumes the thing it is proving.**

**This is not my discovery. It is a five-day-old retraction that never reached this file.** [r214](REVIEW_r214.md) §"Defect 1" states it in these words, of the identical text then printed by [run_n5_verify.py](../scripts/runs/run_n5_verify.py). I re-derived the objection before reading r214 and reached the same two lines.

### 3.1 The repair, which is one sentence and sits $100$ lines below in the same file

Import the cap from [L62](../findings/sym3-blocks.md): every cubic of $K$ vanishes at $W_0$, so every sextic of $\mathop{\mathrm{im}}\mu$ vanishes at $W_0$; evaluation at $W_0$ is a **nonzero** functional on the $14$, since $\lVert W\rVert^6$ is an invariant sextic with $\lVert W_0\rVert^6=1$; hence $\mathop{\mathrm{im}}\mu$ lies in a $13$-dimensional subspace and $\mathop{\mathrm{rank}}\mu\le13$. Then
$$13\ \le\ \mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)\ \le\ \mathop{\mathrm{rank}}\mu\ \le\ 13,$$
all equal, and $\mathrm{ev}$ is injective on $\mathop{\mathrm{im}}\mu$. **One measurement and one theorem, not two measurements.**

So the answer to the brief's question "what forces it" is: **not a dimension count, not a Vandermonde argument, and not general position, a squeeze between a derived upper bound and a machine-measured lower bound at the actual points.**

### 3.2 The stronger route, which is already on the record and which the block does not use

The lemma's conclusion (injectivity on the $13$-dimensional image), is a *corollary* of a cleaner fact recorded independently twice:

- **[r214](REVIEW_r214.md)**, re-running the pipeline from a copy at $p=1099511627873$: *"unrestricted sampled rank at the $40$ points, $14$, the theorem's cap, attained, so the points are unisolvent"*;
- **[r209](REVIEW_r209.md)**, own prime, own code, own factorisation: *"unrestricted unknowns / rank: $89/14$"*, matching the shipped run at $p=1000033$;
- **[r213](REVIEW_r213.md)** by a third construction: $120$ explicit invariant sextics, built as complete contractions of six copies of $W$ over random perfect matchings of the $24$ indices, of rank $14$ at those same $40$ points.

Rank $14$ against a cap of $14$ means the $40$ evaluation functionals **span the full dual of the $14$**. So evaluation is injective on *every* invariant sextic. Under that statement the argument needs no $\mu$, no $\mathop{\mathrm{rank}}\mu$, no [L62](../findings/sym3-blocks.md), no cap, and no membership claim: two invariant sextics agreeing at the $40$ points are equal, full stop. **It also makes L90's heading understate its own subject**, "injective on the image" is the weak form of what holds.

### 3.3 Where each of the three carriers stands today

| carrier | argument it gives | state |
| --- | --- | --- |
| [run_n5_verify.py](../scripts/runs/run_n5_verify.py) lines 127–153 | r213's, injective on **all** $14$ | corrected 2026-08-29 10:59 by `cf4a7fdf`, and it prints *"the argument this file first gave was circular, and reviewer 214 said so"* |
| [report/sections/07-gradedness-split.tex:883](../report/sections/07-gradedness-split.tex#L883) | r213's, *"$120$ explicit invariant sextics have rank $14$ against a cap of $14$ there"* | correct |
| **[sym3-blocks.md:143](../findings/sym3-blocks.md#L143)** | **the retracted rank-comparison** | **uncorrected** |

`cf4a7fdf` touched exactly two files, [run_n5_falsify.py](../scripts/runs/run_n5_falsify.py) and [run_n5_verify.py](../scripts/runs/run_n5_verify.py). **The findings file was not in the commit**, and no later commit repaired it. The record designates [findings/](../findings/) canonical and the report derivative; here the derivative is right and the canon is wrong, which inverts the record's own hierarchy. [r282](REVIEW_r282.md) noticed this on the day and wrote *"the script's version is sound; the findings file carries the retracted one"*, **and it was still not fixed.** [r598](REVIEW_r598.md) noticed it again later and judged L90's version "defensible after L62", which is my §3.1 and is correct as a repair, but the text was still not repaired.

---

## 4. Is $40$ enough, and why exactly $40$?

### 4.1 What $d$ is

$d=\dim\mathop{\mathrm{im}}\mu=13$. Under the stronger reading of §3.2 the relevant space is the whole $14$.

**So $40$ exceeds it by a factor of about three**, and under either reading the count is not close to binding. Any $13$ (resp. $14$) points at which the evaluation functionals are independent would do; the marginal value of the $15$th through $40$th point for *this* lemma is zero.

### 4.2 Why $40$

`NSAMP = 40` is a hardcoded constant at [run_n5_assemble.py:913](../scripts/runs/run_n5_assemble.py#L913), with no comment and no derivation anywhere in [findings/](../findings/). Reading the shapes it plausibly targets the $36$ real-symmetric unknowns with a margin of four, but **that reading fails on the actual matrix**: the sampled system is $40\times47$, so it is *underdetermined* by seven columns, not overdetermined. Which is harmless, because the rank is capped at $13$ regardless and the solution set is meant to be a family rather than a point.

**$40$ is therefore a free parameter, not a derived one, and no result in the file changes if it moves, provided it stays large enough for the rank to attain $13$.** The block presents it as though the number mattered; it does not.

### 4.3 Is $40$ another view of $14$, $36$ or $65$? **No.**

I checked all of the file's circulating figures and $40$ is none of them, nor a sum or difference of any pair that appears. The near neighbours are real reading hazards and should be named:

| number | what it is | distance from $40$ |
| --- | --- | --- |
| $41$ | the highest-weight vectors, $\sum m_\lambda$ over the $24$ blocks | $+1$, and it appears in a section heading a few dozen lines above |
| $47$ | the **columns** of the sampled matrix, $\sum m^2$ over the surviving blocks | $+7$ |
| $36$ | the real-symmetric unknowns, $\sum m(m+1)/2$ | $-4$ |
| $14$, $13$ | the target dimension and the image dimension | the ones that actually govern |

**And I confirm the membership half (2) of §2 by hand.** [L59](../findings/sym3-blocks.md)'s apolarity gives $F_5\in\mathop{\mathrm{im}}\mu\iff F_5\perp\mathrm{ANN}$; with $\dim\mathrm{ANN}=1$ and $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$, and the apolar pairing against $W_0^6$ being evaluation at $W_0$, this reduces to $F_5(W_0)=0$, which is exact over $\mathbb Z$. Equivalently and more directly: $\mathop{\mathrm{im}}\mu\subseteq W_{13}$ with $\dim\mathop{\mathrm{im}}\mu=13=\dim W_{13}$, so $\mathop{\mathrm{im}}\mu=W_{13}$, and $F_5$ is an invariant sextic vanishing at $W_0$, hence in $W_{13}$. **Both routes are sound and the block's is one of them.** Note that this half *does* consume $\mathop{\mathrm{rank}}\mu=13$, so it inherits §3.1's dependency on the same single measurement.

---

## 5. Independent re-derivation of the surrounding block arithmetic

I rebuilt the $16$ surviving blocks by hand from [L83](../findings/sym3-blocks.md)'s table and [L86](../findings/sym3-blocks.md)'s parity rule, without reading the certificate first, then screened the result against the shipped JSON metadata.

Splitting the $24$ blocks by the parity of $\lambda_2$: **$16$ even carrying $29$ multiplicities, $8$ odd carrying $12$**, which reproduces [L59](../findings/sym3-blocks.md)'s $29/12$ line. Each even block loses one multiplicity, so $29-16=13$ survive there; the odd blocks keep all $12$. **Total $25$ surviving multiplicities**, matching [L86](../findings/sym3-blocks.md).

The eight even blocks that die outright are exactly the eight of multiplicity $1$ ($(0,0)$, $(1,0)$, $(5,0)$, $(5,4)$, $(6,0)$, $(6,2)$, $(6,4)$, $(6,6)$) which is L86's list verbatim. The survivors are

$$\underbrace{(2,2)_3,\ (4,2)_3,\ (3,2)_2,\ (2,0)_1,\ (3,0)_1,\ (4,0)_1,\ (4,4)_1,\ (5,2)_1}_{\text{even, }13}\qquad \underbrace{(2,1)_2,\ (3,1)_2,\ (4,1)_2,\ (4,3)_2,\ (3,3)_1,\ (5,1)_1,\ (5,3)_1,\ (6,3)_1}_{\text{odd, }12}$$

**two $3\times3$, five $2\times2$, nine scalars**, which is L86's shape, and

$$\textstyle\sum m^2=47,\qquad \sum\frac{m(m+1)}2=36,\qquad \sum\frac{m(m-1)}2=11,\qquad 36+11=47 .$$

**Everything reproduces.** The $47$ columns of the sampled matrix are $36$ real-symmetric unknowns plus $11$ imaginary directions, and [r210](REVIEW_r210.md)'s $34=23+11$ for the kernel is the same decomposition. The identity $47=36+11$ **is nowhere in [findings/](../findings/)**, and it is the one line that reconciles the file's "$36$ unknowns" with the certificate's $47$ coordinates, a reader meeting both numbers has no bridge.

### 5.1 A trap: there are two different sixteens

**[L86](../findings/sym3-blocks.md)'s "that rule selects exactly $16$ blocks" and the certificate's $16$ blocks are different sets.** L86's sixteen are the $\lambda_2$-**even** blocks, of which eight then die. The certificate's sixteen are the eight surviving even blocks plus the eight odd ones. The counts coincide by accident. **A reader who identifies them concludes the certificate carries no odd-$\lambda_2$ block, and the JSON carries five.** The file never distinguishes them.

*(Method note, per the standing rule: everything in §5 is hand arithmetic on the file's own table, screened against the block/shape metadata of [n5_certificate.json](../scripts/runs/n5_certificate.json) and the four row dumps, a few seconds reading list lengths, on a claim I was about to record. **No rank, Gram or linear algebra was computed**; see §9.)*

---

## 6. "Was nowhere in the record", checked against `git`, and it is clean

The brief flags that one block's provenance was found manufactured today. **This one is not.** The history:

| time (2026-08-29) | commit | what |
| --- | --- | --- |
| 10:13 | `f3309892` | writes the L90 body into [sym3-blocks.md](../findings/sym3-blocks.md) **and** the same argument into [run_n5_verify.py](../scripts/runs/run_n5_verify.py), in one commit; the message says *"Records the load-bearing step that was nowhere in the record"* |
| 10:38 | `b342ccba` | [r214](REVIEW_r214.md) records the argument as circular |
| 10:59 | `cf4a7fdf` | *"my stated argument was circular"*, repairs the **script only** |
| 2026-09-02 02:13 | `8d869d2c` | places the `#### Lemma L90` heading over text written four days earlier |

A `-S` search for the argument's distinguishing string across the whole tree returns `f3309892` as the first commit. **So the claim was true when written**, and the commit message states it in the same terms the block does. Provenance clean.

**But the sentence is now stale in a way that misleads.** As a present-tense clause in a canonical block dated five days later, *"was nowhere in the record"* reads as a claim of standing, this block being the step's home. The step now has two other homes, both carrying a **different and better** argument, and **the block never says its own was withdrawn**. The hedge earned its place on 2026-08-29 and should have been retired on the same morning.

**"The load-bearing step" is earned.** Without it the exhibited Gram certifies nothing: its sextic could agree with $F_5$ at $40$ places and differ everywhere else, and the bound $\theta\le\sqrt{3/2}$ on $\mathcal W_5$ loses its only support. [r633](REVIEW_r633.md)'s impact table reaches the same conclusion.

---

## 7. The two audits, the ordering fix, and the convention

### 7.1 The audits named are the wrong ones

The block says *"**Two audits stand behind it**, and both found real errors"* and then names **reviewers 211 and 212**. Reading both reviews:

- **[r211](REVIEW_r211.md)**'s assigned scope is *"claims 1 and 2 of brief17"*, the CRT lift and the exact rank over $\mathbb Q$;
- **[r212](REVIEW_r212.md)**'s is *"claims 3, 4, 5"*, affine feasibility and the claimed strictly-PSD point.

**Neither audited the injectivity step.** They audited the certificate's *lift* and its *positive definiteness*. The audits that did address L90's step are **[r213](REVIEW_r213.md) and [r214](REVIEW_r214.md)**, and one of them **refuted the argument the sentence is attached to**.

So the sentence is defective under both readings of its pronoun. If *"it"* is the injectivity claim, the attribution is false. If *"it"* is the certificate, the sentence is true but is filed under the wrong heading, and it silently withholds that the two audits which *did* stand behind the injectivity claim did not stand behind it. **The one audit fact a reader of L90 most needs (that its proof was withdrawn), is the one the paragraph replaces with two unrelated reviewer numbers.**

### 7.2 The ordering fix **landed**, verified

[r211](REVIEW_r211.md) and [r212](REVIEW_r212.md) found that [herm_row](../scripts/runs/run_n5_assemble.py#L851) walked the blocks by $(-m,\lambda)$ while the JSON dump walked them by $\lambda$, so the consumer partitioned the $47$ columns into the wrong blocks; r211 records the true worst eigenvalue as $-1.440\times10^3$, with $(4,2)$ at $-1440$. The block reports the number correctly.

The repair is at [run_n5_assemble.py:1250](../scripts/runs/run_n5_assemble.py#L1250), and it is a good one, it *derives* the order at the dump site rather than restating it, with a comment saying that is what stops it drifting again, plus an assertion that the dumped order accounts for every column. **Screened: the `blocks` and `shape` fields of [n5_certificate.json](../scripts/runs/n5_certificate.json) and of all four `n5_rows_*.json` dumps agree entry for entry, and the common order is $(-m_\lambda,\lambda)$.** The fix landed and holds across all five artefacts.

### 7.3 The convention is **not** stated, and L90's own description of it is ambiguous

The brief's worry is right. Grepping [findings/](../findings/), [results.md](../results.md) and [report/](../report/): the **only** statement of the block order anywhere outside the script is L90's own narrative sentence about the bug. It says the consumer orders by *"$(-m,\lambda)$"*, and **$m$ is not disambiguated**.

**I tripped on this myself.** Read with $m$ the *surviving* multiplicity, the `shape` field, the number the file's "$25$ surviving multiplicities" trains a reader to reach for, the ordering test on the certificate **fails**. It passes only with $m$ the **full** multiplicity in $\mathrm{Sym}^3$, before the orbit constraint removes one: $(2,2)$ and $(4,2)$ lead at $m=4$ though they carry $3$ surviving copies each, and $(2,0)$ at $m=2$ precedes $(3,3)$ at $m=1$ though both carry one.

So the convention is stated in exactly one place, in a sentence about a bug rather than as a convention, in a form that admits the wrong reading. **This is the shape of thing the brief says silently reappears**, and it is a two-line addition to [conventions.md](../findings/conventions.md).

---

## 8. What consumes L90, and whether the backwards dependency is circular

**Badly filed, not circular. I am confident of this.**

The physical arrangement is as the brief describes: [L62](../findings/sym3-blocks.md)'s proof sits inside L90's block, the "THE RESTRICTED RANK IS $13$" paragraph, the boxed display, the three caveat bullets and the "upper bound $13$" bullet, all under L90's heading, while L90's own text consumes $\mathop{\mathrm{rank}}\mu=13$, which is L62's conclusion. [r633](REVIEW_r633.md) and [r634](REVIEW_r634.md) both found it.

**Tracing the dependency to the leaves:**

- L62's cap $\mathop{\mathrm{rank}}\mu\le13$ needs [L85](../findings/sym3-blocks.md)'s $14$ and the orbit constraint. Neither touches $\mathrm{ev}$, the $40$ points, or L90;
- L62's lower bound $\mathop{\mathrm{rank}}\mu\ge13$ needs the sampled rank, i.e. $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)=13$. That is a measurement, not a consequence of L90;
- L90 needs both of the above and nothing else.

**No arc returns to L90.** The chain is acyclic and the ordering is L85 → L62 → L90.

**But the structure is worth stating, because both blocks hide it.** L62 and L90 are presented as two results resting on separate evidence. They rest on **one** measurement, $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)=13$, plus **one** theorem, the cap. From those two, §3.1's squeeze delivers L62 *and* L90 together. Under that presentation **L62 becomes a corollary of the same squeeze rather than an input to L90**, and the physical filing (L62's proof inside L90's block), stops being anomalous, because the two share a proof. [r633](REVIEW_r633.md) reached the same reorganisation independently; I record that I reached it before reading r633 and by the same route.

**What the filing does cost a reader** is direction: someone following a pointer to L62's proof lands inside a downstream result and cannot tell which way the arrow runs. That is a filing defect with a one-line repair, not a logical one.

---

## 9. Where I stopped for want of computation

**Standing rule inherited from the brief: analysis only.** I did not run, and name here what a run would decide:

| run | what it would decide | what each outcome would mean |
| --- | --- | --- |
| $\mathop{\mathrm{rank}}$ of the $40\times47$ matrix in the four `n5_rows_*.json` dumps, over $\mathbb F_p$ | whether $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)=13$ at the certificate's own points | $13$: the squeeze of §3.1 closes and L90's conclusion is established. $<13$: the cap is not attained, $\dim\mathrm{ANN}\ge2$, and both L62 and L90 fail. $>13$: the cap is violated, which by this file's own record means a non-equivariant copy identification, and the pipeline is broken upstream |
| the same on the $89$ unrestricted columns | whether the $40$ points are unisolvent for the full $14$ | $14$: §3.2's stronger statement holds and L90 needs no $\mu$ at all. $<14$: r213's, r214's and the report's route all fail, and only the weaker image-restricted form survives |

**Both are already on the record**, the first at [r214](REVIEW_r214.md) at four primes near $2^{40}$ and in the shipped run at $p=1000033$, the second at [r214](REVIEW_r214.md) and [r209](REVIEW_r209.md). I take them as recorded measurements and do not re-run them. **I record no positive claim resting on any computation of my own**; §5's screen is metadata reading, and §7.2's is a comparison of five JSON key lists.

### 9.1 "Measured at four primes", where I part from an earlier audit

[r633](REVIEW_r633.md) and [r634](REVIEW_r634.md), auditing L62, found *"four primes"* unsupported, on the ground that the four primes near $2^{40}$ belong to the certificate's **row lift**, a different computation. For L62 (whose claim is about $\mathop{\mathrm{rank}}\mu$), I agree completely: **nothing measures $\mathop{\mathrm{rank}}\mu$ at any prime.**

**For L90's first conjunct the finding is different, and the record does support four.** [r214](REVIEW_r214.md)'s verdict table reads *"`rank(A)` mod each of the four primes (my own Gaussian elimination over $\mathbb F_p$, self-tested on planted ranks $0,1,5,13,14,20$), $13,13,13,13$"*, and the four dumps `n5_rows_1099511627873/917/933/953.json` are on disk, each $40\times47$ with an identical block order. The row lift and the rank are **two computations on the same four dumps**, which is why the phrase looked migrated. So:

> **"$\mathrm{rank}(\mathrm{ev}\circ\mu)=13$ at four primes" is grounded. "$\mathrm{rank}\,\mu=13$ is measured" is grounded at no prime at all.** L90's sentence conjoins them under one verb, and the grounded half lends its support to the ungrounded one.

Two further precisions on the block's evidence line, which claims *"reviewer 209 reproduced it independently at $p=1000003$ ... with its own code, its own points"*:

- **r209 used $22$ points, not $40$** ([r209](REVIEW_r209.md)'s comparison table). So r209 reproduces that $\mathop{\mathrm{rank}}\mu$ **attains** $13$ (a property of $\mu$, needing only *some* point set) and says nothing about the certificate's own $40$;
- **injectivity of $\mathrm{ev}$ is a property of the $40$ points**, so it rests on the single shipped run at $p=1000033$ and on r214's four dumps. r209 corroborates the neighbouring claim, not this one.

---

## 10. The checklist

### Hedging clauses

| clause | verdict |
| --- | --- |
| *"the load-bearing step"* | **earned**, §6 |
| *"was nowhere in the record"* | **true when written, stale now, and it conceals a retraction**, §6 |
| *"is measured at four primes"* | **half grounded, half groundless, under one verb**, §9.1 |
| *"Two audits stand behind it"* | **false of the injectivity claim; the two audits that engaged it withdrew the argument**, §7.1 |
| *"the necessary condition is a theorem"* (the block's own sub-heading) | **false as an unqualified claim**, the cap is a theorem, the value is a measurement, which is exactly [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md)'s split on L62, and L90's heading carries it too |

### Duplication, four kinds

1. **Same content, other files, *corrected***, [run_n5_verify.py](../scripts/runs/run_n5_verify.py) and [report/sections/07-gradedness-split.tex:883](../report/sections/07-gradedness-split.tex#L883) both give the identity step by r213's route. **The findings copy is the only surviving carrier of the retracted one.**
2. **Another result's proof under this heading**, [L62](../findings/sym3-blocks.md)'s, per §8, with L62's own body at [sym3-blocks.md:244](../findings/sym3-blocks.md#L244) restating it near-verbatim. Two copies of one proof, in one file, under two headings.
3. **Unnumbered restatement**, [results.md:586](../results.md#L586) carries L59's apolarity and [results.md:206](../results.md#L206) carries L62, both propagating *"at four primes"*.
4. **Absence rather than duplication, and it is the more serious**: **L90 has no statement in [results.md](../results.md) at all**, nor do L91 or L92. [INDEX-results.md:105](../findings/INDEX-results.md#L105) carries it as *"Gate 2: no verdict on the record"*. So the record's canonical statement of what it calls its load-bearing step exists in **exactly one paragraph**, and that paragraph is the withdrawn one.

### Does the block's own file settle it?

**Yes, twice, and the brief's tally rises again.**

- **The repair is $100$ lines below.** [L62](../findings/sym3-blocks.md)'s body supplies the cap $\mathop{\mathrm{rank}}\mu\le13$, which is the single missing ingredient of §3.1. The file contains its own fix and does not connect the two.
- **The stronger route is one grep away.** The unrestricted sampled rank of $14$ at the same $40$ points is recorded in [r209](REVIEW_r209.md), [r213](REVIEW_r213.md), [r214](REVIEW_r214.md) and the report, and it makes the whole rank-comparison unnecessary.

### Pointers

The block carries exactly one file pointer, to [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py), for `ldl_psd`. **It resolves**, and the file exists. Unlike [L61](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md), L90 carries no `##`-section pointer, so the boundary ambiguity those two audits deadlocked on **does not arise here**.

*Incoming* pointers to L90 are a different matter: [r597](REVIEW_r597.md), [r598](REVIEW_r598.md) and [r634](REVIEW_r634.md) anchor it at `#L115`/`#L117` against today's $141$, a uniform $+26$ shift, as §1 records.

---

## 11. Repairs owed, in priority order

1. **Replace L90's proof with r213's route**, the one [run_n5_verify.py](../scripts/runs/run_n5_verify.py) and the report have carried since 2026-08-29: every coordinate of the Gram-to-sextic map and $F_5$ alike are $O(5)$-invariant sextics in a $14$-dimensional space; the $40$ evaluation functionals attain rank $14$ there; so $\mathrm{ev}$ is injective on **every** invariant sextic and agreement is identity outright. *This retires the dependency on $\mathop{\mathrm{rank}}\mu$, on [L62](../findings/sym3-blocks.md) and on the cap, and it strengthens the heading.*
2. **If the rank-comparison is kept instead, state the squeeze**, $13\le\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)\le\mathop{\mathrm{rank}}\mu\le13$, naming [L62](../findings/sym3-blocks.md)'s cap as the third inequality. **Never write $\mathop{\mathrm{rank}}\mu$ as measured.**
3. **Fix the audit attribution.** Name [r213](REVIEW_r213.md) and [r214](REVIEW_r214.md) as the audits of *this* step, and say r214 withdrew the argument. Move the r211/r212 paragraph to the certificate table above it, where its subject lives.
4. **Split the block, as [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) proposed for L62** (cap as `Lemma`, attained value as `Observation`) and note that L90 and L62 share one measurement, not two.
5. **State the block-order convention in [conventions.md](../findings/conventions.md)**, with $m$ disambiguated as the **full** multiplicity in $\mathrm{Sym}^3\mathcal W_5$, and record $47=36+11$ beside the file's $36$.
6. **Distinguish the two sixteens** in [L86](../findings/sym3-blocks.md), the $\lambda_2$-even blocks and the surviving blocks.
7. **Give L90 a statement in [results.md](../results.md)**, and record a Gate 2 verdict against it in [INDEX-results.md](../findings/INDEX-results.md).
8. **Ground or correct "four primes" at all six sites**, the fifth and sixth being [sym3-blocks.md:143](../findings/sym3-blocks.md#L143) itself, which [r633](REVIEW_r633.md)'s five-site list does not include. Per §9.1 the phrase is defensible for $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)$ with [r214](REVIEW_r214.md) cited, and indefensible for $\mathop{\mathrm{rank}}\mu$.

---

## 12. The one-line answer the brief asks for

**Injectivity does not rest on the points being generic, and genericity is neither checked nor needed.** It rests on an exact mod-$p$ rank of the evaluation matrix at the recorded $40$ points, a one-sided bound, reduction and sampling both losing rank only, reproduced at four primes by an independent reviewer with independent code and again at a fifth prime on independent points. **That is stronger than general position and weaker than a hand-checkable proof: it is a machine certificate for a step the record calls load-bearing, and no argument a human can check establishes it.** The line between a proof and a very likely computation falls here, not at genericity, but at the rank.
