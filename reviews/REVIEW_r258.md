# REVIEW r258 -- Gate 2, claims 4 and 5

Reviewer 258. Commits under review: ff4ed03 (primary), a157e50, 3f17991.
Primary file: [scripts/runs/run_hw_multiplicity_test.py](../scripts/runs/run_hw_multiplicity_test.py).
Scripts: [scripts/reviewers/r258/](../scripts/reviewers/r258/). Reviewer 257 runs claims 1-3 concurrently.

| # | Claim | Verdict |
|---|---|---|
| 4 | What the n=5 run says about n=12 | **REFUTED. Nothing transfers.** The docstring names three things the run exercises *"none of which any earlier validation could reach"*. **Multiplicity 4** is real but is not *"the widest available below n = 12"*: so(10) carries a block of **9**, the exact width the certificate must handle, with no associate ambiguity. **The projector-kernel hazard** cannot occur here -- the copies are whole isotypic components, so P is the identity on every vector read, which is the same condition under which r256 said the previous validation had no projector. **The two-sided coordinate** is not present at all: no covariant is evaluated, no sample point exists, and the rank is full at every one of the 1355 word positions, so position 0 is doing no work. r250's transfer needs a projector-free diagram carrier, and no object in this file is a diagram |
| 5 | plan.md section 2 item 1, rewritten in a157e50 | **BOTH DIRECTIONS.** Two sentences are stronger than reviewers 247-256 established -- one of them false, with a witness -- and nine established results never reached the item, five of them deleted from it by a157e50 itself. The item's open half, *the construction emits vectors, not diagrams*, now survives nowhere in plan.md or findings/ |

---

## Claim 4 -- REFUTED

### 4a. The test cannot fail, at any position, on any input of the right shape

Evidence: [c4_tautology.py](../scripts/reviewers/r258/c4_tautology.py) / [out_c4_tautology.txt](../scripts/reviewers/r258/out_c4_tautology.txt), exact over `Fraction`.

The file ranks the m copies of a block at `sup[:3]`, the first three positions where copy 0 is nonzero, and argues that this is meaningful because *position 0 IS the highest-weight coordinate*. I ran the same rank at **every** position of every block:

| lambda | m | positions | rank at each one |
|---|---|---|---|
| (2,2) | 4 | 35 | 4 everywhere |
| (4,2) | 4 | 220 | 4 everywhere |
| (3,2) | 3 | 105 | 3 everywhere |
| (5,2) | 2 | 390 | 2 everywhere |
| the other eight blocks | 2 | 14 to 231 | m everywhere |

**Deficient reads: 0 out of 1355 positions.** Position 0 is doing no work: the read is full rank at position 389 of block (5,2) exactly as it is at position 0, so nothing in the outcome distinguishes the highest-weight end from any other. The file's assert message -- *"a deficient read means the coordinate chosen does not separate them"* -- describes a failure mode that no choice of coordinate produces.

Three further inputs, all passing:

- **Re-mixing.** Replace the copies of a block by a random invertible rational combination of themselves. Rank m, at every block tried -- as it must be, rank being a property of the span.
- **Random non-equivariant vectors.** Five random monomials each, no group theory anywhere, same shape as a copy: rank 4, 4, 3, 2 for the four widest blocks. The asserts do not detect that the input has stopped being a representation.
- **A duplicated copy** is the only failure I could construct: replacing copy 1 by copy 0 in (2,2) gives rank 3 of 4.

So the assert fires on exactly one thing: two of the cached copies being literally equal. It is a check on the cache, not on a mathematical proposition.

### 4b. Nearly half the cached data is discarded, and the test still passes

The file loads the **raw** pickle, whose entries are `(Fraction, Fraction)` pairs -- Gaussian rationals. The coercion `F(x[0]) if isinstance(x, tuple)` keeps the real part only. Of the **826,486** stored coefficients, **387,158 carry a nonzero imaginary part** and are silently dropped. The run still reports full rank on all twelve blocks. (Claim 3 is r257's; recorded here because it bears on what the passing run establishes: it passes while reading 47% of its input as zero.)

### 4c. The projector-kernel hazard is not exercised -- and cannot be

Evidence: [c4_transfer.py](../scripts/reviewers/r258/c4_transfer.py) / [out_c4_transfer.txt](../scripts/reviewers/r258/out_c4_transfer.txt).

The docstring's central transfer claim is that the file *"exercises multiplicity 4, the projector-kernel hazard, and the two-sided coordinate, none of which any earlier validation could reach."* The middle item is false.

Every copy has length exactly `dim V_lambda` (0 mismatches over all 41 copies), and `sum_lambda m_lambda dim V_lambda = 7770 = dim Sym^3(Weyl_5)`. The copies are therefore whole so(5)-submodules exhausting the space, and **the isotypic projector P_lambda is the identity on every vector the file reads**.

r256's hazard is a statement about vectors *outside* V_lambda: `A = (W.W)_ij` and `B = A - (|W|^2/n) delta_ij` are independent as raw covariants and the same element of V_(2), so an unprojected read returns 2 where the target holds 1. Producing that failure requires an object on which P is not the identity. **This file contains no such object.** That is exactly the condition under which r256 said the previous validation had "no projector": *"In the validation the two free indices carry no target: P is the identity, and the identity `<F, e_I> = <F, P e_I>` is never used."* The condition is unchanged here; only the multiplicity is larger.

### 4d. The read is not the read the n=12 procedure needs

The docstring: *"for a block of multiplicity m, read the highest-weight coordinate of each copy at several sample points and rank the m columns."*

The code does none of that. `comps = sup[:3]` are **positions in the lowering word list** -- indices of basis vectors of V_lambda inside one copy -- not sample points. No Weyl tensor is drawn, no covariant is evaluated, and `import random` is never used. The rows are indexed by **monomials of Sym^3(Weyl_5)**: for block (2,2) the matrix is **398 x 4**, for (4,2) it is 129 x 4. The file reads the full coefficient expansion of three basis vectors of each copy, which is the entire object, not one coordinate of a value.

The n=12 procedure the plan proposes is: draw W, evaluate the covariant F_c(W) in V_lambda, read its highest-weight coordinate, rank the m columns. **No step of that procedure occurs here.** The two-sidedness r255 derived -- vanishing of the highest-weight coordinate *on all W* forces F = 0 by equivariance -- is a statement about a covariant evaluated on Weyl tensors. With no evaluation there is nothing for it to apply to.

### 4e. "Multiplicity 4 is the widest available below n = 12" is false

Evidence: [c4_mult_below12.sage](../scripts/reviewers/r258/c4_mult_below12.sage) / [out_c4_mult.txt](../scripts/reviewers/r258/out_c4_mult.txt) -- `Sym^3` of the (2,2) module of so(n), by Weyl character ring, sharing no code with this repo.

| n | algebra | dim Weyl_n | blocks | copies | max multiplicity | associate ambiguity |
|---|---|---|---|---|---|---|
| 5 | B2 | 35 | 24 | 41 | **4**, at (2,2) and (4,2) | yes -- associate (2,2,2) has 3 rows |
| 8 | D4 | 300 | 72 | 230 | **13**, at (3,2,1) | yes -- associate has 5 rows |
| 9 | B4 | 495 | 67 | 179 | **9**, at (3,2,1) | yes -- associate has 6 rows |
| 10 | D5 | 770 | 77 | 205 | **9**, at (3,2,1) | **none** -- associate has 7 rows |
| 12 | -- | 1638 | 77 | 191 | 9, at (3,2,1,0,0,0) | none |

The n=5 row **reproduces the cached table exactly** (24 blocks, 41 copies, max 4), which is the control on the method. The n=12 row is read off [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) and agrees with [sym3-stability.md](../findings/sym3-stability.md).

**n = 10 is the clean witness.** An SO(n) isotypic can aggregate an O(n) block with its associate, so the raw numbers need a check. For (3,2,1) at n=10 the associate has first column length 10-3 = 7, hence 7 rows, and every constituent of Sym^3 has at most 6 rows by the Newell-Littlewood bound -- so its O(10) multiplicity is 0 and **m_SO(10) = m_O(10) = 9**. Two dimensions below 12 there is a genuine O(n) block of the exact width the certificate must handle. The same check leaves n=8 and n=9 ambiguous, and it leaves the file's own n=5 number ambiguous too, in the direction that hurts it: the associate of (2,2) at n=5 is (2,2,2), which has 3 rows, so the SO(5) multiplicity 4 may split as two O(5) blocks and the exercised O(5) width may be **narrower than 4**.

*n = 11 (B5, dim 1144) was launched in the same sweep and stopped unfinished once n = 10 had settled the question; the trailing `B5` line in [out_c4_mult.txt](../scripts/reviewers/r258/out_c4_mult.txt) is that run, not a result.*

It matters twice. The regime the certificate must handle is a block of **9** columns -- [REVIEW_r248.md](REVIEW_r248.md) makes `det Gram` a product of determinants of size up to 9 -- and 4 is not it: 67 of the 77 n=12 blocks have multiplicity at most 4, holding 122 of 191 copies, so the exercised width misses the 10 blocks that carry the other 69. And the wider case was available seven dimensions lower than the file says it was.

### 4f. r250's transfer does not reach these carriers

r250 confirmed: independence transfers *upward* along restriction, `T(J_D^(n)) = (n/m)^L J_D^(m)`, and its one load-bearing hypothesis is that **the carrier is a fixed contraction diagram with n-independent coefficients** -- the `J_1 = I_1 + I_2/n`, `J_2 = I_1 + I_2/24` counterexample being what happens otherwise.

The objects here are dictionaries from a monomial index of `Sym^3(Weyl_5)` to a Gaussian rational, produced by a BFS echelon selection of lowering words run at n=5. No diagram is named anywhere in the file or in its cache. Worse for transfer, the indexing is rank-dependent: **so(5) has rank 2 and so(12) rank 6**, so the word alphabet that `comps` indexes has two letters at n=5 and six at n=12, and "position t" has no n-independent referent.

What does transfer is worthless. `iota: Weyl_5 -> Weyl_12` induces an injection `Sym^3(iota)`, so the 41 padded vectors are independent in `Sym^3(Weyl_12)` -- for free, injectivity being all that is used. But `iota` commutes only with `O(5) < O(12)`, so those images are not so(12)-isotypic and are not the 184 covariants. **Independence of 41 objects that are not the objects in question is the entire content of the transfer.**

### 4g. The direction of the whole exercise is inverted

At n=12 the input is a list of diagrams and the unknown is whether they realise the 184 copies. At n=5 the input *is* the decomposition -- the copies come out of `HW`, already sorted into blocks -- and the file confirms that a basis of a multiplicity space is a basis. The n=5 run consumes as data the object whose construction at n=12 is the item's stated debt (*"7/71 built"*). The file's own closing line, *"OWED: the n=12 covariants as diagrams"*, names the gap correctly; what it does not say is that the same gap is what makes the n=5 exercise trivial rather than merely incomplete.

### Verdict

**Success at n=5 transfers nothing.** The run is a consistency check on [n5_adapted.pkl](../scripts/runs/n5_adapted.pkl) -- and a weak one, passing on random vectors and on half its own data. It is a local result on a cached basis, and item 1 is no further forward than it was at a157e50.

**What would make an n=5 rehearsal informative**, in order of cost: (i) evaluate an actual covariant at drawn Weyl tensors, so that a sample point exists; (ii) build at least one carrier *outside* V_lambda, so that P is not the identity and r256's hazard can fire; (iii) read one coordinate, not the whole coefficient vector, so that the choice of coordinate can be wrong; (iv) plant an exact relation and require the procedure to find it, per r256's recommendation 1. Steps (i)-(iii) are the only ones that distinguish this file's outcome from `rank(basis) = size(basis)`.

---

## Claim 5 -- plan.md section 2 item 1 after a157e50: BOTH DIRECTIONS

Evidence: [c5_plan_witnesses.py](../scripts/reviewers/r258/c5_plan_witnesses.py) / [out_c5_plan.txt](../scripts/reviewers/r258/out_c5_plan.txt), and `git show a157e50 -- plan.md`.

### 5a. Sentence by sentence

| plan.md item 1 says | the record says | verdict |
|---|---|---|
| "five attempts have been refuted" | r247, r251, r253, r254, r255 + r256 | faithful |
| "the 184 covariants are linearly independent as functions at n=12, padding then giving every n>=12 (r247, r250)" | r250 confirmed the transfer **and named one load-bearing hypothesis**: the carrier must be a projector-free diagram with n-independent coefficients | **STRONGER -- see 5b** |
| "one component costs n^((12-\|lambda\|)/2) <= 2,985,984 at n=12" | r256 claim 5, verbatim | faithful as a per-component figure; **incomplete for the read the plan then proposes -- see 5c** |
| "pairing with e_I of **distinct** entries needs no projector, e_I being traceless hence already in V_lambda" | r255 recommendation 1: *"Pair with `c_lambda e_I`, **not** `e_I`"* | **STRONGER, AND FALSE -- see 5c** |
| "rank = N proves independence from one draw; a deficient matrix is uninformative" | r255 section 2b, r256 claim 4 | faithful, and it repairs the wording error r255 flagged in the file |
| "reading raw diagram values gives a necessary condition only -- {P F_c} independent implies {F_c} independent, never the converse" | r255 section 2c | faithful |
| the whole r256 validation-universe paragraph (rank 1; with g, 2; multiplicity 9 at n=12; Schur-independent before a component is read) | r256 claim 3 | faithful |
| "read the highest-weight coordinate inside V_lambda, **which equivariance plus polarisation makes two-sided**" | r255 section 2c: two-sided because *"vanishing of the highest-weight coordinate **on all W** forces F = 0"* | **STRONGER -- see 5d** |
| "at degree 3 the projector has a kernel, so unprojected reads return 2 where the target holds 1" | r256 claim 5 point 1 | faithful |
| "at \|lambda\| = 0 the add-more-components hatch is empty, a scalar having one component while that block has multiplicity 2" | r256 claim 5 point 2 | faithful |

### 5b. Stronger 1 -- r250's hypothesis was deleted by the rewrite

Before a157e50, item 1 read:

> **Its one hypothesis: the carrier must be a projector-free diagram** -- $J_1=I_1+I_2/n$ and $J_2=I_1+I_2/24$ are independent at $12$ and identical at $24$ -- *and reviewer 252 shows such carriers exist, so the hypothesis does not void the transfer.*

After it, the padding transfer is stated with no hypothesis at all. r250's own words were that this *"should be written into the record with it"*; the rewrite removed it from the one place that had it. It survives in [fence-posts.md](../findings/fence-posts.md) line 332 -- but attached to the **n=24 reuse**, not to the item that has to satisfy it.

The asymmetry is sharp: the plan's standing-state bullet still keeps r250's *negative* finding -- *"reviewer 250 shows the padding transfer does **not** need"* the no-free-loop lemma -- while the same review's *positive* hypothesis is gone from the item. One review, harvested on one side.

It bites immediately. The covariants at n=12 are not built as diagrams, so the hypothesis is not currently satisfiable, and the theorem statement in the plan promises every n >= 12 from a step whose precondition the item cannot yet meet.

### 5c. Stronger 2 -- the Young symmetriser was dropped, and the sentence left behind is false

r255's recommendation, twice: *"Pair with `c_lambda e_I`, not `e_I`. For a multi-index I with distinct entries ... the Young symmetriser `c_lambda e_I` is traceless and hence lies in V_lambda."* The plan keeps "distinct entries" and "traceless hence already in V_lambda" and **drops `c_lambda`**. What is left is false, and the two halves of r255's sentence are exactly what makes it false: distinct entries give tracelessness, and the *symmetriser* gives membership of V_lambda.

Witness, exact, in [out_c5_plan.txt](../scripts/reviewers/r258/out_c5_plan.txt), using the S_4 central idempotent:

- `e_I = e_0 (x) e_1 (x) e_2 (x) e_3` has distinct entries, so every trace vanishes -- and `P_(2,2) e_I != e_I` (its image has support 12).
- The fully antisymmetric `T` on four slots is traceless, has `T_{0123} = 1`, and `P_(2,2) T = 0` exactly. So `<T, e_I> = 1` while `<P_(2,2) T, e_I> = 0`: the distinct-entry read of the **raw** object is not a read of the projected one, and the pair `{0, T}` -- equal in `V_(2,2)` -- reads rank 1.

This is r256's degree-3 hazard reproduced from the plan's own sentence, three lines above the plan's own statement of that hazard. **The item asserts, and then denies, that the read needs no projector.**

Liveness at n=12, from [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl):

| \|lambda\| | shapes present | multiplicities |
|---|---|---|
| 2 | (2) alone | 3 |
| 4 | (4), (3,1), (2,2), (2,1,1), (1,1,1,1) | 3, 3, 8, 3, 3 |

At \|lambda\| = 2 the sentence is *accidentally* harmless: only (2) occurs, so an equivariant covariant into a 2-tensor has no antisymmetric part and the raw read equals the projected read. That is the size every refuted attempt used, which is why the error has not yet fired. From \|lambda\| = 4 up, five inequivalent shapes occur at once and a raw covariant carries all five.

**And the cost figure goes with it.** r255 priced its own recommendation: one coordinate is a signed sum over the row and column groups, `prod(row!) * prod(col!)` terms -- `2!^6 * 6!^2 = 3.3e7` for `(2,2,2,2,2,2)`. Maximising `12^((12-|lambda|)/2) * prod(row!) * prod(col!)` over the 77 blocks gives **33,177,600**, at (6,6), (2,2,2,2,2,2) and their partners -- **11x the plan's 2,985,984**. The conclusion *cost is not the obstacle* survives comfortably; the number attached to it is the cost of a different read from the one the plan proposes.

### 5d. Stronger 3 -- "two-sided" without r255's quantifier, contradicting the item's own paragraph

r255's proposition is: *for a covariant F into V_lambda, vanishing of the highest-weight coordinate **on all W** forces F = 0 by equivariance and polarisation.* That is correct -- the O(n)-orbit of the highest-weight vector spans V_lambda, so knowing one coordinate at every W determines F. The plan states the conclusion, "makes two-sided", without the quantifier that carries it.

At a finite sample it is false, and the same paragraph of the plan already says so about component reads (*"a deficient matrix is uninformative"*). Witness, exact at n=5, in [c5_plan_witnesses.py](../scripts/reviewers/r258/c5_plan_witnesses.py):

- family `s^a * traceless((W.W)^k)`, a = 0..2, k = 1..4: **12 covariants into V_(2)**, independent as functions (rank 12 of 12 over every component of 4 samples);
- the highest-weight coordinate of `V_(2)` for so(5) is `<F, u (x) u>` with `u = e_0 + i e_1`, i.e. the two rational functionals `F_00 - F_11` and `2 F_01`. Four samples give **8 conditions on a 12-dimensional family**, so the read has a nullspace -- dimension 4;
- take `D` in it. `D` is nonzero at 92 (sample, component) pairs and its highest-weight coordinate is **zero at all four samples**. Then for `Y = traceless(W.W)`:

| read | rank of the pair `(Y, Y + D)` |
|---|---|
| highest-weight coordinate, 4 samples | **1** |
| every component, the same 4 samples | **2** |

A two-sided read cannot return 1 for an independent pair. The highest-weight coordinate is two-sided **as a function of all W** and exactly as one-sided as a component read at any finite sample -- so the sampling hypothesis that r256's claim 4 established for components (rows must outnumber columns, and fixed constants are defeatable) transfers verbatim to the highest-weight read, and the plan states neither.

The consequence is not academic: the sixth attempt read "two-sided" as licence and built a test with no sample points at all (claim 4, section 4d).

### 5e. Weaker -- what the reviews established and the item does not carry

Five of these were **deleted from item 1 by a157e50 itself**; four never reached it.

| # | established | where it is now |
|---|---|---|
| 1 | **"the construction emits VECTORS in a weight space, not diagrams"** -- the item's open half, and what r256 called *"not a loose end but the hinge"* | **deleted** from item 1; absent from plan.md, findings/ and FINDINGS.md; survives only as a source comment at [run_n24_via_diagrams.py:45](../scripts/runs/run_n24_via_diagrams.py#L45) |
| 2 | r250's projector-free-carrier hypothesis on the padding step | **deleted**; in fence-posts.md, attached to the n=24 reuse (5b) |
| 3 | r247's refutation of the Sturm/Gram reduction, with the witness `C = A/2` against `det = n^6(n^2-1)` | **deleted**; in no findings file -- nothing in the working record now says why that route was retired |
| 4 | r249's projector: closed form, 0.4 ms per application, exact trace 1638, a verified Weyl_12 basis in six seconds | **deleted**; in no findings file -- a built asset the plan no longer knows it has |
| 5 | r250: step 1's *"spanning at 12 implies spanning at 24"* is a non sequitur; basis-hood comes from the stability count | **deleted**; survives in fence-posts.md line 332 |
| 6 | r256 recommendation 3: the row count must be a computed quantity exceeding the column count -- 12 rows cannot certify 184 covariants, and a block of 9 columns needs at least 9 rows | never reached the plan |
| 7 | r256 claim 4: the add-more-components hatch is **load-bearing at every lambda**, a deficient read at fixed constants carrying no information at all | the plan carries only the \|lambda\| = 0 emptiness, which is the narrower half |
| 8 | r256 claim 3 and recommendation 1: `(F.F)_ij`, `F_ij^2`, an indicator and even the constant 1 pass the asserts, so a validation must plant an **exact relation** | never reached the plan -- and the sixth attempt then passed on random non-equivariant vectors (4a) |
| 9 | r256 recommendation 4: `F_c(W) in V_{lambda_c}` as the **standing hypothesis**, on which both the read and the block split depend | implicit in "inside V_lambda", never named as a hypothesis |

Items 6, 7 and 8 are the ones with teeth: each is a constraint on the *next* attempt, each was written for exactly that purpose, and none of them is in the document the next attempt is written from. Item 8 is the sharpest -- r256 said in terms that a validation passed by a wrong scheme proves nothing, the plan did not carry it, and attempt six shipped a validation passed by random vectors.

### Verdict

**Overstated in three places, understated in nine.** The two that matter are 5c, which is false rather than merely strong, and 5e item 1: with *the construction emits vectors, not diagrams* deleted, plan.md no longer states the obstruction that is the entire remaining content of the item, and item 1 reads as a method-selection problem when it is still a construction problem.

**What to change.**

1. Restore r250's hypothesis to the padding sentence, and restore *"the construction emits vectors in a weight space, not diagrams"* as the item's open half.
2. Rewrite the test-vector sentence as r255 wrote it: **pair with `c_lambda e_I`**, and price it at up to 33,177,600 terms per coordinate rather than 2,985,984.
3. Qualify "two-sided": on all W. Add the sampling obligation -- at least `m_lambda` independent conditions per block, drawn rather than fixed.
4. Add r256's three unlanded requirements: computed row count, hatch load-bearing everywhere, validation against a planted exact relation.
5. Put `F_c(W) in V_{lambda_c}` in the item as the named standing hypothesis it is.
