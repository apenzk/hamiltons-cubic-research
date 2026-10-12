# Gate 2 adversarial review r225

Reviewer 225. Brief: brief18.md. Assigned claims 3, 4, 5 (r224 runs 1 and 2 concurrently).
Commits under review: b8d8f72 (primary), 7479d70, 6ca5418, 1bf0974.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 3 | Sym^3(Weyl_n) has 71 blocks / 184 multiplicities at n = 12, 14, 16; n = 10 differs | **CONFIRMED** -- 71/184/477 reproduced independently; exact dimension identity holds at n = 12, 13, 14, 16, 18, 20, 24 and breaks at 10 and 11; O(10) total multiplicity is 182, proved without any modification rule |
| 4 | run_n12_stability.py asserts over 60 of 71 labels -- is the subset conclusion sound? | **conclusion sound, check is not** -- it now sees 56 of 71 blocks; a 16-block subset still passes |
| 5 | dim^1.77 scaling extrapolated 18x to "about 42 hours" | **not supportable as stated** -- 2 abscissae, 0 residual degrees of freedom; a 10% shift in one timing gives 144 h |

Status: in progress. Rows update and commit as each claim settles.

## Claim 3 -- interim: the stable table reproduces

Independent route, no repo code read ([r225_stable.sage](scripts/reviewers/r225/r225_stable.sage)):

- `Weyl_n = res_O(n)(s_{2,2} - s_2)` as a virtual GL character (Littlewood restriction gives `res s_{2,2} = [2,2]+[2]+[0]` and `res s_2 = [2]+[0]`). Restriction is a lambda-ring homomorphism, so `Sym^3(Weyl_n) = res(Sym^3(s_{2,2} - s_2))`.
- `Sym^3` of the virtual argument computed three independent ways that agree: Adams `(psi1^3 + 3 psi1 psi2 + 2 psi3)/6`, the direct plethysm `h_3[A]`, and the lambda-ring expansion `S3 x - S2 x * y + x * L2 y - L3 y`.
- Degree-12 result F self-checks against `binom(D_n+2, 3)` with `D_n = n(n+1)(n+2)(n-3)/12` at n = 6, 8, 10, 12, 16, 24 via the hook-content formula.
- Littlewood restriction (skew by every partition with all parts even, sizes 0..12) gives the stable O-table.

Result: **71 blocks, total multiplicity 184, max rows 6, max lambda'_1 + lambda'_2 = 12**, attained by the single label (2,2,2,2,2,2). No negative multiplicities. This matches the record's numbers exactly, arrived at without reading the repo's implementation.

Still to settle: that this stable table is the actual O(n) table at n = 12, 14, 16 (rather than only for n >= 24), and that n = 10 differs.

## Claim 3 -- n = 10 differs, settled without any modification rule

Second, structurally independent route ([r225_wcr.sage](scripts/reviewers/r225/r225_wcr.sage)): decompose `Sym^3` of the `SO(2m)` irrep with highest weight (2,2,0,...,0) in Sage's `WeylCharacterRing("D_m")`. This is pure root-system character theory -- no Littlewood restriction, no King modification rule, no repo code. Degree check `sum m_lambda * dim = binom(D_n+2,3)` asserted inside the run.

At n = 10 (D_5, 226 s): **77 SO(10) blocks, total multiplicity 205.**

Pulling that back to O(10) needs no modification rule, only the standard O/SO branching ([r225_so_to_o.py](scripts/reviewers/r225/r225_so_to_o.py)):

- an O(n) irrep with l(lambda) = m restricts to the `+/-` pair `(a_1..a_{m-1}, +-a_m)`, so one pair of equal SO multiplicities = one O block of that multiplicity;
- an O(n) irrep with l(lambda) < m restricts irreducibly, and it shares that SO block with its associate, so an `a_m = 0` SO block of multiplicity k pulls back to a total O multiplicity of exactly k.

At n = 10 the SO table has 13 such `+/-` pairs and 51 blocks with `a_5 = 0`, giving

**O(10) total multiplicity = 182, block count in [64, 115].**

182 != 184. **n = 10 genuinely differs from the stable table, and it is proved here rather than assumed.** The block count alone would have been inconclusive (71 lies inside [64,115]) -- the multiplicity total is what decides it, which is precisely the "label set stable while multiplicities move" failure mode the brief warns about, caught here on the correct side.

## Claim 4 -- the conclusion is right; the check is not what establishes it

[r225_claim4.py](scripts/reviewers/r225/r225_claim4.py), [r225_claim4_plant.py](scripts/reviewers/r225/r225_claim4_plant.py).

### What it actually reads

| quantity | value |
|---|---|
| raw labels parsed from the covariant logs | 62 |
| distinct O(12) blocks those represent | **56** |
| blocks in the full table | 71 |
| blocks the file never sees | **15** |
| multiplicity carried by the unseen blocks | **51 of 184 (28%)** |

The file prints "62 distinct constituent labels", but 6 of the 62 are chirality partners `(...,+-a_6)` of labels already counted -- the same O(12) block seen twice. So its own count overstates coverage: it has 56 blocks, not 62, and the gap to 71 is 15, wider than the brief's 11.

### Could a missing block carry a larger lambda'_1 + lambda'_2?

**No -- and provably so, but not for the reason the file gives.** Over the 15 unseen blocks the true maximum is 8 (from my independent full table). More importantly the bound is a priori: a partition with at most 6 rows has `lambda'_1 <= 6` and `lambda'_2 <= lambda'_1 <= 6`, so `lambda'_1 + lambda'_2 <= 12` follows from step 1 alone with no table needed. Step 3's assert therefore splits into

- `worst <= 12`: a consequence of step 1, needing no data at all;
- `worst >= 12`: needs exactly one witness, and `(2,2,2,2,2,2)` is in the subset.

One witness plus an a-priori bound is enough. The subset is sufficient *by luck of which half it read*, not by design.

### Planted violations -- does the check fire?

Source exec'd in memory with `LOGS` repointed at doctored copies; the file under review is not edited.

| plant | result |
|---|---|
| control | passes |
| extremal label `(2,2,2,2,2,+-2)` deleted from the logs | **ASSERT FIRES** ("the threshold is 10, not 12") |
| a 7-row constituent added to the logs | **ASSERT FIRES** (step 1) |
| a `lambda'_1+lambda'_2 = 13` constituent added to the logs | **ASSERT FIRES** (step 1) |
| a 7-row constituent that exists but was never logged | passes -- silently |
| logs truncated to the first 20 lines (**16 of 71 blocks**) | **passes**, with the full confident output |

The last row is the defect in one line: with 16 of 71 blocks visible the file prints "every constituent labels an O(n) irreducible once n >= 12" exactly as it does with 56. Every plant that is *visible* fires; nothing that is *absent* can. The file's own docstring says it "checks steps 1 and 3 against the constituents the covariant run actually produced" -- honest about its input, but the printed conclusion is stated over the whole table.

**Verdict.** The threshold really is 12 -- I confirm it independently over all 71 blocks. The file's assert is a witness check dressed as a coverage check. Recommended repair: state in the file that `worst <= 12` is a corollary of the row bound and that the log scan supplies only the attainment witness, and report the distinct-*block* count (56) rather than the raw label count (62).

## Claim 5 -- the dim^1.77 extrapolation is not supportable as stated

[r225_claim5.py](scripts/reviewers/r225/r225_claim5.py). The arithmetic reproduces: exponent 1.7667 from 27,030 -> 578.6 s and 34,731 -> 901.0 s, giving 42.5 h at 635,220 columns.

| | |
|---|---|
| measured span | **1.28x** |
| extrapolation reach | **18.3x** |
| abscissae | **2** |
| residual degrees of freedom | **0** -- two points, two parameters, the fit is exact by construction |

The commit says "three timings". The third (894.1 s) is the chirality partner at the *same* 34,731 columns -- a replicate, not a third abscissa. It contributes zero leverage on the slope. It does give the only noise estimate available: 0.77%.

### Sensitivity

Perturbing the single 27,030-column timing and refitting:

| shift in t(27,030) | exponent | predicted hours |
|---|---|---|
| -20% | 2.657 | 565 |
| -10% | 2.187 | **144** |
| 0% | 1.767 | **42.5** |
| +10% | 1.387 | 14 |
| +20% | 1.039 | 5 |

**A 10% move in one of two data points takes the answer from 42 h to 144 h or to 14 h -- a factor of 10 across a plausible noise band.**

Propagating the 0.77% replicate spread properly gives a *statistical* band of 37.5-48.2 h, which looks reassuring and is the wrong thing to quote. The dominant error is model form: two abscissae cannot see curvature, and sparse elimination cost curves upward as fill-in grows, so the exponent measured near 3x10^4 is a lower bound on the exponent near 6x10^5. What the answer becomes if the exponent is anything else:

| exponent | time |
|---|---|
| 1.77 | 1.8 days |
| 2.00 | 3.5 days |
| 2.20 | 6.2 days |
| 2.50 | 14.9 days |
| 3.00 (dense) | 63.8 days |

The measurement cannot distinguish any of these. The commit's own hedge -- "a measurement from three timings ... stated as an extrapolation and not as a bound" -- is the right register, but the docstring and the commit subject then say "THAT IS A COST, NOT A WALL" and "42 hours rather than unreachable", which is a claim the two points do not carry. Nothing here bounds peak memory either, and fill-in at 635,220 columns is at least as likely to be the wall as time is.

**Verdict.** The exponent is a valid two-point slope and nothing more. Supportable statement: *"elimination on the two measured blocks scales as dim^1.77 over a 1.28x span; extrapolating that slope 18x gives 42 h, with the caveat that the data cannot constrain curvature and exponents up to 3 are equally consistent, spanning 42 h to 64 days."* Reaching a defensible number needs a third abscissa well above 34,731 -- one block near 10^5 columns would cut the range enormously.

## Claim 3 -- the labelling condition at the boundary (literature)

The n = 12 case sits exactly on the boundary lambda'_1 + lambda'_2 = n, so whether the inequality is strict decides the whole threshold. Two independent statements of it, both non-strict:

- [King, *Modification rules and products of irreducible representations of the unitary, orthogonal, and symplectic groups*, J. Math. Phys. 12 (1971) 1588](https://pubs.aip.org/aip/jmp/article-abstract/12/8/1588/224431/Modification-Rules-and-Products-of-Irreducible) -- the origin of the modification rules, phrased as removal of continuous boundary hooks.
- [Sam-Snowden, *Homology of Littlewood complexes*](https://arxiv.org/pdf/1209.3509) and [Howe-Tan-Willenbring, *Stable branching rules for classical symmetric pairs*](https://arxiv.org/html/math/0311159v2): the irreducibles of O(V) are indexed by partitions whose **first two columns have at most dim V boxes in total**.

So `lambda'_1 + lambda'_2 <= n` with `<=`, and `(2,2,2,2,2,2)` at n = 12 (6 + 6 = 12) is a legitimate O(12) label. Step (b) of the argument is stated correctly, including at the boundary where it matters. My SO(12) computation tests this empirically rather than by citation: if `(2^6)` were not an O(12) label the SO(12) decomposition could carry no `(2,2,2,2,2,+-2)` chirality pair.

### Claim 4, addendum: the coverage is a function of wall-clock time

The brief says the file reads 60 labels; when I ran it, it read 62, because [run_n12_covariants.py](scripts/runs/run_n12_covariants.py) (PID 2119, 1 h 36 m elapsed at the time of writing) is still appending to [agent_logs/n12_tail.log](agent_logs/n12_tail.log). **The number of blocks the assert ranges over depends on how far a concurrently running job has got, and the file prints the same conclusion at every stage of that job.** A check whose input grows under it, and whose verdict never changes as it grows, is not measuring coverage.

### Claim 4, addendum 2: the docstring was corrected, the printed output was not

[run_n12_stability.py](scripts/runs/run_n12_stability.py) changed on disk mid-review (r224's verdicts folded in). Lines 49-54 now retract the old explanation of n = 10 -- "An earlier version said 'because (2,2,2,2,2,2) is not an O(10) label'. That explains ONE of the seven missing blocks." But the file's last executable line still prints exactly the retracted sentence:

```
print("    n = 10 differs because (2,2,2,2,2,2) is not an O(10) label, 6+6 > 10.")
```

So running the file emits the claim its own docstring calls wrong. The seven missing blocks are confirmed by my count too: 71 - 64 = 7.

The Python body is otherwise unchanged, so everything under claim 4 above still stands: 56 of 71 blocks read, 15 unseen, and a 16-block subset passes.

## Claim 3 -- two further corroborations, both external to the repo

**The "477 unknowns" reproduces.** Summing `m(m+1)/2` over my independently computed 71 blocks gives exactly **477**, and at n = 10 the same sum over the O(10) reconstruction gives exactly **493**, alongside 64 blocks and 182 multiplicities. All six of the record's numbers (71/184/477 and 64/182/493) come out of a computation that read none of its code.

**The trivial block's multiplicity is 2, and that is checkable against physics.** My table gives multiplicity 2 for the empty partition -- the space of cubic O(n)-invariants of the Weyl tensor. The general-dimension count of cubic Weyl invariants is exactly two, `C_abcd C^cdef C_ef^ab` and `C_abcd C^aefd C_e^bc_f` ([Note on Invariants of the Weyl Tensor](https://www.researchgate.net/publication/1963726_Note_on_Invariants_of_the_Weyl_Tensor), [Ambient space and integration of the trace anomaly](https://arxiv.org/pdf/2411.03842)). The one entry of the table with an independent literature value agrees.

Bearing on claim 5: since the trivial block's multiplicity is 2, its Gram matrix is 2x2 -- **3 of the 477 unknowns**. The commit's "second route ... skips elimination entirely" is therefore not a hopeful aside; the object at the end of the 42 hours is a 3-parameter block whose spanning set the first fundamental theorem hands over directly. That weakens the case for quoting the 42 h figure at all.

## Claim 3 -- a remark on the derivation the file now gives

After r224's pass the file leans on Koike-Terada: "the universal character ring maps onto R(O(n)) by a RING homomorphism that commutes with Sym^3". Koike-Terada give a *ring* homomorphism; commuting with `Sym^3` is a **lambda-ring** statement and does not follow from being a ring map, so as written the file is citing more than the reference supplies.

There is a shorter route that needs no such compatibility, and it is the one I used:

1. `Weyl_n = res_{O(n)}(s_{2,2} - s_2)` -- an identity of virtual O(n) characters, valid for n >= 4.
2. Restriction along `O(n) < GL(n)` is a homomorphism of **lambda-rings**, because it is restriction of actual representations. So `Sym^3(Weyl_n) = res_{O(n)}(F)` with `F = Sym^3(s_{2,2} - s_2)` a single degree-12 symmetric function, **the same F for every n**.
3. The only n-dependence left is expanding `res_{O(n)}(s_lambda)` into O(n) irreducibles -- Littlewood's rule plus King's modification. Every constituent of the stable expansion has `lambda'_1 + lambda'_2 <= 12`, so for n >= 12 nothing is modified and the answer is n-independent.

Step 2 is where "the multiplicities are stable, not just the label set" actually comes from, and it is elementary. Recommend replacing the Koike-Terada sentence with it.

## Claim 3 -- the exact dimension identity, n by n

[r225_littlewood_check.sage](scripts/reviewers/r225/r225_littlewood_check.sage) first validates the two tools:

- the El Samra-King O(n) dimension formula reproduces `dim[1] = n`, `dim[2] = n(n+1)/2 - 1`, `dim[1,1] = n(n-1)/2`, `dim[2,2] = n(n+1)(n+2)(n-3)/12` for n = 4..19;
- `dim_GL(n) s_lambda = sum_mu m_mu dim_O(n)[mu]` over my Littlewood restriction, for every partition of size <= 8 at every n from `2 l(lambda)` to 24: **1241 checks, 0 failures**. Bumping one multiplicity in `res s_{3,2,1}` makes the check fire (64,130 against 64,064), so it is not vacuous.

Then [r225_dimcheck.sage](scripts/reviewers/r225/r225_dimcheck.sage) applies the identity to the 71-block table:

| n | all 71 labels allowed? | `sum m * dim_O(n)` | `binom(dim Weyl_n + 2, 3)` | |
|---|---|---|---|---|
| 10 | **no** -- 1 label fails | -- | 76,385,540 | table not even well-formed |
| 11 | **no** -- 1 label fails | -- | 250,187,080 | table not even well-formed |
| 12 | yes | 733,813,080 | 733,813,080 | **match** |
| 13 | yes | 1,965,013,050 | 1,965,013,050 | **match** |
| 14 | yes | 4,874,429,560 | 4,874,429,560 | **match** |
| 16 | yes | 24,883,123,720 | 24,883,123,720 | **match** |
| 18 | yes | 104,207,616,600 | 104,207,616,600 | **match** |
| 20 | yes | 373,910,116,580 | 373,910,116,580 | **match** |
| 24 | yes | 3,391,442,154,100 | 3,391,442,154,100 | **match** |

The single label that fails at n = 10 and n = 11 is `(2,2,2,2,2,2)` -- `6 + 6 = 12 > 11`. **The threshold is exactly 12: not 11 (fails), not 13 (13 already works, so 13 is not the first).** These are exact integers up to 3.4 x 10^12 with no slack anywhere.

Planted violations at n = 12, both fire:

| plant | sum | target | |
|---|---|---|---|
| multiplicity 8 -> 9 at `[2,2]` | 733,814,718 | 733,813,080 | **CHECK FIRES** |
| extremal block `(2,2,2,2,2,2)` deleted | 733,756,452 | 733,813,080 | **CHECK FIRES** |

## Claim 3 -- verdict

**Confirmed. No moving entry anywhere at n = 12, 14 or 16, and n = 10 genuinely differs.** Three routes, none of which read the repo's implementation:

| route | what it shows |
|---|---|
| lambda-ring plethysm + Littlewood restriction | 71 blocks, 184 multiplicities, 477 unknowns, max rows 6, max `lambda'_1+lambda'_2 = 12` at the single label `(2,2,2,2,2,2)` |
| exact O(n) dimension identity | holds at n = 12, 13, 14, 16, 18, 20, 24; the table is not even well-formed at n = 10 or 11 |
| Sage Weyl character ring, D_5 | O(10) total multiplicity **182**, blocks **64**, unknowns **493** -- all three of the record's n = 10 numbers, none of its code |

The threshold is exactly 12: 11 fails, 12 is the first n at which every label is admissible. The labelling condition `lambda'_1 + lambda'_2 <= n` is non-strict in the literature, which is what puts `(2,2,2,2,2,2)` inside O(12) rather than outside it -- the one off-by-one that would have moved everything.

A fourth route -- Sage's Weyl character ring at D_6, D_7, D_8 (n = 12, 14, 16 directly, no Littlewood and no modification rule anywhere) -- is running; it will either confirm the above or refute it, and this section will be updated with the result either way. Nothing in the verdict depends on it: the dimension identity at n = 12 already pins the table to an exact integer of 733,813,080 with a planted single-multiplicity perturbation firing.

### What the claim does not cover

The stability theorem fixes the SHAPE of the SDP -- which blocks, which multiplicities, 477 unknowns -- for every n >= 12. The file now says this itself. It says nothing about the constraint data, so "a certificate built at n=12 covers every larger even dimension" remains a claim about shape and needs its own transfer argument. That caveat is correctly recorded in the file and I have nothing to add to it.

### Every published summary statistic reproduces

[plan.md:388](plan.md#L388) states "**71 blocks**, multiplicities 1...9 summing to 184, **477 scalar unknowns**, largest block 9x9". My independent table gives multiplicity range 1..9, the unique 9 at `(3,2,1)`, the sum 184, `sum m(m+1)/2 = 477`, and the multiplicity histogram `1:29, 2:16, 3:10, 4:6, 5:1, 6:4, 7:1, 8:3, 9:1`. Every number in the boxed claim checks out.

## Claim 3 -- fourth route lands at n = 12: exact match

[r225_wcr.sage](scripts/reviewers/r225/r225_wcr.sage) at D_6 (1622 s) decomposes `Sym^3` of the 1638-dimensional SO(12) irrep (2,2,0,0,0,0) purely by Weyl character theory -- no Littlewood restriction, no King modification rule, no repo code, with `sum m * dim = binom(1640, 3)` asserted inside the run.

**Result: 77 SO(12) blocks, total multiplicity 191. My 71-block O-table predicts 77 and 191, and [r225_compare.py](scripts/reviewers/r225/r225_compare.py) reports EXACT MATCH -- every block, every multiplicity.**

Six of the 71 labels have exactly 6 rows and so split into chirality pairs in SO(12): `(2,2,1,1,1,1)`, `(2,2,2,2,2,2)`, `(3,2,2,1,1,1)`, `(3,3,2,2,1,1)`, `(4,2,1,1,1,1)`, `(4,4,1,1,1,1)`. 71 + 6 = 77 and 184 + 7 = 191. Sage produces exactly those twelve `+-` weights and no others.

**The boundary case is settled empirically.** `(2,2,2,2,2,+-2)` both appear with multiplicity 1. If `lambda'_1 + lambda'_2 <= n` were strict, `(2,2,2,2,2,2)` would not be an O(12) label and that pair could not be there. It is there. The off-by-one the brief flags as most likely does not occur.

One honest caveat: for the 65 SO blocks with `a_6 = 0`, the O(12) preimage is `lambda` or its associate `lambda~`, and at n = 12 many associates have `|lambda~| = 12`, so the degree bound does not separate them. Since associating is an involution, this can permute which label carries a multiplicity but cannot change the block count, the multiplicity multiset, or `sum m(m+1)/2`. So 71 / 184 / 477 are confirmed outright; the specific labels rest on the Littlewood derivation, which the dimension identity independently corroborates at every n from 12 to 24.

### n = 14: exact match

D_7, 9650 s. **71 SO(14) blocks, total multiplicity 184 -- exactly the table, with no chirality splitting anywhere** (all 71 labels have at most 6 rows, and 6 < 7 = rank). `EXACT MATCH: True`, block by block. So the table at n = 14 is literally identical to the table at n = 12 as an O-decomposition, not merely equal in its summary statistics.

D_8 (n = 16) still running.
