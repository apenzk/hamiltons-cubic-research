# REVIEW r256 -- Gate 2, claims 3, 4, 5

Reviewer 256. Commits under review: f8e22e1 (primary), adb2a3d, 7c21cd4.
Primary file: [scripts/runs/run_component_independence.py](../scripts/runs/run_component_independence.py).
Scripts: [scripts/reviewers/r256/](../scripts/reviewers/r256/).

**The file was rewritten in the worktree while this review ran** (r255's repair: `COMPS` changed to distinct-index components and both asserts changed to rank 1). The claim-by-claim verdicts below are on the committed version, f8e22e1; the postscript re-runs claims 3 and 4 against the revision, and **both survive it, claim 3 more forcefully than before**.

## Verdict table

| Claim | Subject | Verdict |
|---|---|---|
| 3 | The validation (rank-2 / rank-1 asserts) | **REFUTED, with two witnesses.** Both asserts are passed by schemes that are not linear reads, and one is passed by a scheme that discards every numerical value. The rank-2 pair is independent because its members sit in inequivalent O(n) isotypics -- no scheme reading values can miss it -- and the rank-1 pair is two names for one function |
| 4 | Hardcoded COMPS and seed | **UPHELD -- the pair exists, and it is exhibited.** A nonzero covariant D vanishing at all twelve (component, sample) pairs is constructed exactly at n=5 and n=6, and the file's own procedure reports rank 1 for the independent pair (X, X+D). The failure is in the SAFE direction, so the file's soundness survives and its power does not: adding one component restores rank 2, which is the file's own escape hatch, now shown to be load-bearing rather than optional |
| 5 | Applicability at degree 3, \|lambda\| <= 12 | **CONDITIONAL, and the condition is the one thing the validation cannot exercise.** The cost survives -- one component at degree 3 costs n^((12-\|lambda\|)/2) <= 2,985,984 ops at n=12. The soundness does not transfer for free: at degree 3 there is a projector with a kernel, and a component read of unprojected covariants reports independence where the target holds a dependence -- exhibited exactly, in the file's own carrier |

## Claim 3 -- the validation, where four attempts died

**Verdict: REFUTED.** The two asserts exclude the r247/r251 error class and nothing else. Two wrong schemes pass both and then certify a linearly dependent triple as independent. Evidence: [c3_wrong_schemes.py](../scripts/reviewers/r256/c3_wrong_schemes.py) / [out_c3.txt](../scripts/reviewers/r256/out_c3.txt), [c3b_universe.py](../scripts/reviewers/r256/c3b_universe.py) / [out_c3b.txt](../scripts/reviewers/r256/out_c3b.txt).

### What the asserts have to catch

The soundness argument in the file's docstring is an argument about a **linear** map: "a relation among the covariants forces the same relation among any fixed set of their components" holds exactly because `F -> (F_{i_1 j_1}, ..., F_{i_k j_k})` is linear in `F`. A validation that cannot distinguish a linear read from a nonlinear one tests nothing about the property the conclusion rests on.

### Witness 1 -- a wrong scheme that passes both asserts

A *scheme* is any rule `S` turning a covariant's value at `W` into the matrix entry. Four of them, all run on the file's own carriers, its own `COMPS`, its own `seed=0`, four samples:

| scheme | n=5 ind/dep | n=6 | n=7 | linear? | rank reported for `{A, B, A+B}` (true rank 2) |
|---|---|---|---|---|---|
| honest `F_ij` | 2 / 1 | 2 / 1 | 2 / 1 | yes | 2 |
| indicator `[F_ij != 0]` | 2 / 1 | 2 / 1 | 2 / 1 | no | 2 |
| entrywise square `F_ij^2` | 2 / 1 | 2 / 1 | 2 / 1 | no | **3** |
| one contraction too many, `(F.F)_ij` | 2 / 1 | 2 / 1 | 2 / 1 | no | **3** |

with `A = (W.W)_ij`, `B = |W|^2 delta_ij`, `C = A + B`, so `C - A - B = 0` identically for every Weyl tensor. The last two schemes **pass both asserts at every carrier and then report rank 3 for three covariants satisfying an exact linear identity** -- they read a true dependence as independence, which is r254's finding reappearing one level up. `(F.F)_ij` is not a contrived function either: it is what a diagram implementation produces if one contraction too many survives.

So the answer to the brief's question is: **a wrong scheme that passes both asserts exists, and it is one contraction away from the right one.**

### Witness 2 -- the rank-2 assert has no arithmetic content

At the three chosen components, one sample, n=5:

| component | `(W.W)_ij` | `&#124;W&#124;^2 delta_ij` |
|---|---|---|
| (0,0) | 489/16 | 502/3 |
| (0,1) | -173/144 | **0** |
| (1,2) | 145/288 | **0** |

The second column is identically zero at both off-diagonal components because `delta_ij` is. Rank 2 follows from the **zero pattern alone**: one column nonzero somewhere the other vanishes. That is why the indicator scheme -- which throws away every numerical value and keeps only "is this entry zero" -- reports 2 as well. Any scheme `h(F_ij)` with `h(0)=0` and `h` nonvanishing elsewhere passes.

### Independent for a reason any scheme would report

The brief's question, answered directly: **for a reason any scheme would report.** `(W.W)_ij = X0_ij + (|W|^2/n) delta_ij` with `X0` traceless and nonzero on every sample (checked exactly), so the first covariant has a nonzero `lambda=(2)` component and the second has none. Inequivalent O(n) isotypics are orthogonal, so the pair is independent **by Schur, before any component is read**. A component test is not what establishes it, and no value-reading scheme could fail to report it.

### The rank-1 assert is an identity, not a test

`W_{aibc} = -W_{iabc}`, so `W_{aibc}W_{ajbc} = W_{iabc}W_{jabc}` -- the two "covariants" are the **same function**, verified equal as full matrices on every sample at n=5,6,7. Every scheme that reads a covariant's *value* returns two identical columns and rank 1, whatever the scheme does to that value. The assert therefore excludes exactly one thing: a scheme that reads a diagram's *label* rather than its value, which is the r247/r251 ambient-space error. That is a real guard and worth having; it is not evidence that the read is a correct component read.

### The validation universe cannot host the hard case

Enumerating all 840 ways to give two Weyl tensors two free legs and match the remaining six slots, the span of the resulting diagrams has **rank 1** over all n^2 components of two samples: every such contraction is a multiple of `(W.W)_ij` (spot check: `W_{iabc}W_{jbac} = (W.W)_ij / 2`, the two-index form of the record's `A = 2C`). So the validation's second covariant is not a diagram at all -- it needs the metric -- and with `g` admitted the space is 2-dimensional, **one dimension per isotypic**.

Consequence: the validation universe contains **no block of multiplicity >= 2**. At n=12 the blocks carry multiplicities up to 9 ([REVIEW_r248.md](REVIEW_r248.md), claim 3), and covariants in *different* blocks are orthogonal hence automatically independent. The only thing that ever has to be certified is **within-block** independence, and the validation cannot exhibit a single instance of it.


## Claim 4 -- the fixed components and the fixed seed

**Verdict: UPHELD, in the safe direction.** An adversarial pair defeats the constants; it defeats them by making the test report *too little*, never too much. Evidence: [c4_defeat_comps.py](../scripts/reviewers/r256/c4_defeat_comps.py) / [out_c4.txt](../scripts/reviewers/r256/out_c4.txt).

### The witness

`s = |W|^2` is a scalar covariant and `X = W.W` a 2-index one, so every `s^a (X^k)_ij` is a genuine O(n)-covariant with two free indices. The family `{s^a X^k : k = 0..n-1, a = 0..2}` has 3n members and is **independent as a family of functions** (exact rank 15 of 15 at n=5, 18 of 18 at n=6, over all n^2 components of four samples). The file's test imposes only `3 components x 4 samples = 12` linear conditions, so for n >= 5 a nonzero `D` in that family vanishes at every pair the test looks at. Solving exactly:

| n | family size | conditions | D vanishes at all 12 | D nonzero elsewhere | rank of `(X, X+D)` at the file's COMPS | with `(2,3)` added | at seed 1 |
|---|---|---|---|---|---|---|---|
| 5 | 15 | 12 | yes | yes | **1** | 2 | 2 |
| 6 | 18 | 12 | yes | yes | **1** | 2 | 2 |

`X` and `X + D` are independent covariants -- the same two columns reach rank 2 the moment a fourth component or a different seed is used -- and at `COMPS = [(0,0),(0,1),(1,2)]` with `seed = 0` the file's procedure returns 1. So **yes: the test's power depends on constants the file never justifies.**

### What that does and does not damage

- It does **not** break soundness. The read is linear, so a spurious rank can never be reported: `rank = N` still proves independence. The adversary can only push the reported rank *down*.
- It does break the file's framing of its own escape hatch. "A deficient component matrix means the chosen components were unlucky ... and more components can be added at will" is written as a remark; the witness shows it is the load-bearing part of the procedure, because a deficient answer at a fixed `COMPS` carries no information at all about the covariants.
- The **counting** version is sharper than the adversarial one and needs no adversary: the matrix has `len(COMPS) * samples = 12` rows, so its rank is at most 12. **As configured, the test can certify at most 12 covariants and there are 184.** Certifying all of them needs at least 184 rows -- unless one first invokes block orthogonality to cut the job into blocks of multiplicity at most 9, and that invocation is exactly the `F_c(W) in V_lambda` premise the file's opening argument assumes rather than establishes.


## Claim 5 -- what changes at degree 3 with |lambda| up to 12

**Verdict: the cost claim transfers, the soundness claim does not transfer unconditionally, and the validation cannot exercise the difference.** Evidence: [c5_projector.py](../scripts/reviewers/r256/c5_projector.py) / [out_c5.txt](../scripts/reviewers/r256/out_c5.txt).

### What stays

A degree-3 diagram has 12 index slots; `|lambda|` of them are free and the rest are contracted in pairs, so one component costs `n^((12-|lambda|)/2)`:

| \|lambda\| | 0 | 2 | 4 | 6 | 8 | 10 | 12 |
|---|---|---|---|---|---|---|---|
| ops per component read at n=12 | 2,985,984 | 248,832 | 20,736 | 1,728 | 144 | 12 | 1 |

Nothing of size `n^{|lambda|}` is built, and the largest read is three million multiply-adds. **The file's central cost claim is correct at degree 3** -- which is worth saying plainly, because it is the first thing in five attempts at this item that survives contact.

### What changes, and what breaks

1. **A projector appears, and it has a kernel.** In the validation the two free indices carry no target: `P` is the identity, and the identity `<F, e_I> = <F, P e_I>` is never used. At `|lambda| = 12` the target is a Young-symmetrised traceless subspace of `(R^12)^{x12}` and `P` kills a great deal. **Independence is not preserved by a map with a kernel**, so ranking components of *unprojected* covariants certifies independence of the raw diagrams, which is a different and strictly stronger statement than independence of the objects in `V_lambda`. Witness, inside the file's own carrier, `P` the traceless projection onto `V_(2)`:

   | n | rank of raw component reads for `(A, B)` | rank in the target |
   |---|---|---|
   | 5 | 2 | **1** |
   | 6 | 2 | **1** |
   | 7 | 2 | **1** |

   with `A = (W.W)_ij` and `B = A - (|W|^2/n) delta_ij`. They are independent as raw covariants and are the **same element** of `V_(2)` (exactly: `tr(W.W) = |W|^2`). A component test run on unprojected objects returns 2 where the truth in the target is 1 -- **r254's failure mode, a dependence read as independence, reappearing at the one place degree 3 differs from the validation**. This is why the whole method stands or falls on `F_c(W)` genuinely lying in `V_{lambda_c}`, and why the record's own note that the construction "emits VECTORS in a weight space" is not a loose end but the hinge.

2. **Components become multi-indices, and the escape hatch is not uniform.** "More components can be added at will" is true at `|lambda| = 12` (12^12 of them) and **empty at `|lambda| = 0`**, where the covariant is a scalar with exactly one component -- and the `|lambda| = 0` block has multiplicity 2 ([REVIEW_r254.md](REVIEW_r254.md)'s block table). There the rows must come from extra *samples*, not extra components. A single rule for choosing rows does not cover the table.

3. **Many multi-indices read zero for symmetry reasons.** A basis element `e_I` whose multi-index repeats a value inside an antisymmetrised column of `lambda` pairs to zero with all of `V_lambda`, producing a row of zeros. The validation's choice -- one diagonal component and two off-diagonal ones -- is a heuristic tuned to a symmetric 2-tensor and carries no information about which `I` to pick at `|lambda| = 10`.

4. **The row budget is set by multiplicity, not by 184.** Covariants in different blocks are orthogonal, so only within-block independence is at stake: at most 9 columns per block ([REVIEW_r248.md](REVIEW_r248.md)), against the 12 rows the file uses. That is comfortable -- but the block split is available **only after** `F_c(W) in V_{lambda_c}` is established, the same premise as point 1. Without it the matrix is 184 columns wide and needs 184 rows.

5. **Degree 3 is odd in W.** `F_c(-W) = -F_c(W)` for every covariant simultaneously, so a sample and its negation contribute one row's worth of rank between them. Harmless for random draws, fatal for any symmetric sampling scheme.

### Answer to the brief's question

The test is applicable at degree 3 **conditionally**: given covariants honestly built inside `V_{lambda_c}`, a per-block component matrix with at least `m_lambda <= 9` well-chosen multi-index rows certifies independence at a few million operations per entry. Every part of that sentence after "given" is untested by the validation, which has no projector, no multi-index, and no block of multiplicity greater than one.

## What should be written instead

1. **Drop the two asserts and validate the property that matters: linearity of the read.** The scheme should be checked against a *constructed exact relation* -- `C = A + B` with `C` computed independently -- so that a nonlinear or mis-contracted read is caught. Both current asserts are passed by `(F.F)_ij`.
2. **State the rank-2 example for what it is.** `(W.W)_ij` and `|W|^2 delta_ij` lie in inequivalent isotypics; their independence needs no test and demonstrates no capability. A validation of this test needs two covariants in the *same* block, which degree 2 with two free indices cannot supply -- the smallest honest carrier is degree 3.
3. **Make the row count a computed quantity, not a constant.** `len(COMPS) * samples` must exceed the number of columns; at 12 rows the procedure cannot certify 184 covariants, and an adversary can hold any single pair at rank 1.
4. **Put `F_c(W) in V_{lambda_c}` at the top of the file as the standing hypothesis.** It is what makes the component read a read of the right object and what makes the block split legal; the validation supports neither.


## Postscript -- the revised validation, re-tested

The worktree version replaces the constants with

```
COMPS = [(0, 1), (1, 2), (0, 2)]      # distinct entries only
assert r_ind == 1                     # was: == 2
assert r_dep == 1
```

Evidence: [c6_revised.py](../scripts/reviewers/r256/c6_revised.py) / [out_c6.txt](../scripts/reviewers/r256/out_c6.txt), [c4b_newcomps.py](../scripts/reviewers/r256/c4b_newcomps.py) / [out_c4b.txt](../scripts/reviewers/r256/out_c4b.txt).

### Claim 3 against the revision: worse, and the witness is now one line

| scheme | n=5 | n=6 | n=7 | passes both revised asserts |
|---|---|---|---|---|
| honest `F_ij` | 1/1 | 1/1 | 1/1 | yes |
| indicator `[F_ij != 0]` | 1/1 | 1/1 | 1/1 | yes |
| entrywise square `F_ij^2` | 1/1 | 1/1 | 1/1 | yes |
| `(F.F)_ij` | 1/1 | 1/1 | 1/1 | yes |
| **constant 1 -- reads nothing at all** | 1/1 | 1/1 | 1/1 | **yes** |
| constant 0 | 0/0 | 0/0 | 0/0 | no |

Both asserts are now **collapses**: at distinct-index components `|W|^2 delta_ij` is identically zero, so one column is zero, and the other pair of columns is identical. Nothing in the revised validation exhibits the test **correctly reporting independence**, and therefore a scheme that answers "rank 1" regardless of its input passes it. The only property the pair of asserts still pins down is "the answer is not identically 0".

The revision is right about the mathematics (the trivial-block leak through `(0,0)` was real) and it removed the one assert that had any output-shape variety, leaving a validation strictly weaker than the one four reviewers already refuted. The repair belongs in the docstring; the validation needs rebuilding from a constructed exact relation, per point 1 of the recommendations above.

Also stale in the revision: the closing text still prints "independence SEEN from one component (rank 2)" directly under asserts that now demand rank 1.

### Claim 4 against the revision: the witness holds, built traceless

At distinct-index components every covariant of the form (scalar) x g reads identically zero -- which is the *intent* of the repair, since such a covariant is the zero map into `V_(2)`. So the adversarial `D` has to be a genuine nonzero map into the target. Rebuilding the family traceless, `s^a Y^k` with `Y^k = X^k - tr(X^k)/n delta`:

| n | family | independent as functions | conditions | D traceless | D vanishes on all 12 reads | rank of `(Y^1, Y^1+D)` at the revised COMPS | with 2 more components | at seed 1 |
|---|---|---|---|---|---|---|---|---|
| 5 | 16 | 16 of 16 | 12 | yes | yes | **1** | 2 | 2 |
| 6 | 20 | 20 of 20 | 12 | yes | yes | **1** | 2 | 2 |

Two covariants that are nonzero and independent **as maps into `V_(2)`** -- exactly the objects the repair says the test is about -- are reported as rank 1 at the file's constants. Claim 4 stands unchanged against the revision.
