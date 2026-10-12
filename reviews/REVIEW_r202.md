# Review r202, the two blind spots are one gauge symmetry and one live hole, and the 103/681 split has an arithmetic cause

Audited at HEAD `c6da435`. Reviewer 202, Gate 2, brief `brief13.md`. Scripts: [scripts/reviewers/r202/](../scripts/reviewers/r202/). Log: [agent_logs/gate2_202.log](../agent_logs/gate2_202.log).

The brief made claims 3 and 4 the priority and both are settled here with witnesses. Claims 1 and 2 are also answered, claim 1 against an exact computation over Q(i) that nobody had run at this site.

## Verdict table

| claim | verdict | the one line |
|---|---|---|
| 1. the Gaussian pair arithmetic | **UPHELD, exactly** | the pair form reproduces the exact Q(i) Gram entry-for-entry on all 12 multiplicity blocks, 192's h on (2,0) included; the Hermitian assert fires under both sabotages of the pair arithmetic |
| 1'. the complex off-diagonal counts | **UPHELD** | 6 / 4 / 2,2,2,2 / 0x6 confirmed against exact arithmetic, no false zero among the six blocks reporting 0 |
| 2. the cache digest | **UPHELD as a hash, EMPTY as a check** | it changes under all three plants, including one the old digest missed; it is compared to nothing and no reference value exists anywhere in the repo |
| 3a. word-list permutation on every copy | **NOT A DEFECT**, `dis` is blind to it and so is everything else, because it is a **gauge transformation** | h is bit-identical, Q' is Q conjugated by the permutation, so B = c* Q c is invariant; the only thing that moves is the digest, which would fire on a change that cannot do harm |
| 3b. coincident copies | **LIVE HOLE, CONFIRMED AT FULL SCALE** | every copy of every block replaced by copy 0: `dis` 0, `skipped` 0, Hermitian True, square True, inhom 0, count 7770, the whole file passes, and **det h = 0 on all 12 blocks**, the check the working tree deleted at this HEAD |
| 4. 103 against 681 | **SETTLED: 103.** r199 is right | 681 is 103 in-window plus **578 primes above the window**; r200's filter has no upper bound and the ratio was taken against the window's prime count |

---

## Claim 4, the discrepancy is a missing upper bound, and both numbers are correct measurements of different quantities

Settled by two routes, neither of them either reviewer's.

**Route 1, a remainder tree** ([claim4_window.py](../scripts/reviewers/r202/claim4_window.py)). P is the product of all 147,013 distinct nonzero absolute numerators in the cache, 4,650,867 bits, built by a product tree. P is then pushed down a product tree over the 14,440 primes of [900001, 1100000). A prime p divides some numerator iff p divides P, because p is prime. Nothing here factors a numerator and nothing here computes a gcd, so it shares no step with r199's per-numerator gcd or r200's per-numerator `factorint`.

```
distinct nonzero |numerators| (1 dropped): 147,013
P has 4,650,867 bits
r199 window [900001,1100000): 14,440 primes, product 287,772 bits
  primes in window dividing SOME numerator: 103  (0.71%)
  1000033 among them: False
```

**Route 2, full factorisation, which locates the 681** ([claim4_unbounded.py](../scripts/reviewers/r202/claim4_unbounded.py)):

```
distinct primes dividing some numerator 9,794; largest 162,215,671
A  in-window (9e5,1.1e6)      : 103   -> 0.71% of the 14,440 window primes
B  q > 9e5, NO upper bound    : 681   -> r200 divided THIS by 14,440: 4.72%
C  q >= 1.1e6 (outside window): 578   (= B - A = 578)
```

**The cause, read off [scan_prime2.py](../scripts/reviewers/r200/scan_prime2.py).** Line 31 is `big = [q for q in ps if q > 900000]`, and `ps` is the sorted list of **every** prime dividing some numerator, running to 162,215,671. So `big` counts primes over a range 800 times wider than the window; line 35 then prints it under the label "count of primes p with 9e5 < p < 1.1e6 that are hit", and lines 37-38 divide it by `primepi(1.1e6) - primepi(9e5)`. Numerator and denominator range over different sets. Every other figure in r200's paragraph (9794, 9178, 162215671, 1000033 missed, 65537 hit once), reproduces exactly; only the ratio is affected.

**Consequence for the file.** [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) lines 96-99 still say "681 of the 14,440 primes ... so escaping a false zero is a 95% draw". The assert message on line 120 already carries the corrected 103. The comment and the message it guards now disagree by a factor of six and the comment is the wrong one. The true hit rate is 0.71%, so the draw was 99.3%, not 95%, which weakens nothing in either reviewer's conclusion, since the escape is still a draw and still unchecked before the scan was added, but the number is quoted in shipped source and should be the right one.

---

## Claim 3a, the global word-list permutation is a gauge transformation, so no check should catch it

**The construction.** For a block lambda, sigma is a random permutation of the positions, applied to **every** copy: R'_i[t] = R_i[sigma(t)]. Run on (2,0) (m=2, dim 14) and (2,2) (m=4, dim 35) with sigma from a fixed seed, so position 0 no longer carries the empty word and R'_i[0] is no longer u_i.

**It passes everything** ([claim3_plants.py](../scripts/reviewers/r202/claim3_plants.py), plant A):

```
--- PLANT A -- global word-list permutation ---
  vectors 7770 (7770: True) | square True | inhom 0 | digest c3c51357fb3992d2
  lambda=(2, 0) m=2: Hermitian True | dis 0 | skipped 0 | det h (425425, 0) (nonzero) | rank ... FULL
  lambda=(2, 2) m=4: Hermitian True | dis 0 | skipped 0 | det h (534064, 0) (nonzero) | rank ... FULL
```

**And det h does not move either.** (425425, 0) and (534064, 0) are the baseline values, bit for bit. That is the first sign this is not a corruption at all.

**It is a change of basis of the abstract V(lambda) by a permutation matrix.** Verified elementwise ([claim3_gauge.py](../scripts/reviewers/r202/claim3_gauge.py)):

```
lambda=(2, 0)  sigma[:6]=[4, 2, 1, 9, 0, 11]
  h identical elementwise: True
  same weight classes (as SETS of words): True
  Q' is Q conjugated by the permutation: True
```

and the same on (2,2). The derivation behind the measurement: h_ij is defined by `<R_i[t], R_j[t]> = h_ij Q_tt` at every t, so relabelling t by sigma permutes the probes and leaves h fixed, which is exactly why the normalising probe moving off the empty word costs nothing. Q'_{ts} = Q_{sigma(t)sigma(s)}, verified above; the coordinate vector of a sample transforms as c' = sigma^{-1}.c because it solves the same system with permuted columns; so B = c'* Q' c' = c* Q c. **Nothing downstream of the adapted basis can see the permutation, so there is nothing for a check to catch.**

**The only thing that fires is the digest**, `84a0459fe49cc41e` becomes `c3c51357fb3992d2`, because it hashes vectors in list order. If the digest is ever compared against a committed value, as [REVIEW_r199.md](REVIEW_r199.md) item 6 recommends and as it should be, then it will reject a rebuild that differs from the reference only by word ordering, which is a rebuild that computes the identical answer. That is worth knowing before the reference hex is committed: the digest is a **provenance** check on one pickle, not a correctness check on the basis, and it will have false positives of exactly this shape.

**So 199's item is real as stated and empty as a threat.** The blindness is genuine (`dis == 0` cannot see a global permutation) but the transformation it is blind to is one the whole pipeline is blind to, by design. The distinction that carries the content is per-copy against global, and the per-copy case is already caught: the control below.

**Control, so the harness means something** ([claim3_plants.py](../scripts/reviewers/r202/claim3_plants.py), plant C). A same-weight transposition inside copy 1 only, which 195 and 197 report the multi-probe check catches:

```
--- PLANT C -- control, per-copy transposition ---
  lambda=(2, 0) m=2: ... | dis 4 | skipped 0 | det h nonzero | rank FULL
  lambda=(2, 2) m=4: ... | dis 14 | skipped 0 | det h nonzero | rank FULL
```

`dis` fires, det h does not, rank does not. The three checks are complementary and none of them subsumes another.

---

## Claim 3b, coincident copies pass the entire file, and the one check that catches them was deleted at this HEAD

**The construction, at full scale.** Every copy of **every** block replaced by an independent deep copy of copy 0, deep, not aliased, so this is not 198's `_dup = [copies[0], copies[0]]` mistake where all four inner products were literally the same call ([claim3_full_coincident.py](../scripts/reviewers/r202/claim3_full_coincident.py)):

```
vectors 7770 (7770: True) | square True | inhom 0 | digest 94c354b5f8ff73a5
  lambda=(2, 0) m=2: Hermitian True | h is all-ones True | complex off-diag 0 | dis 0 skipped 0 | det h (0, 0)
  lambda=(3, 0) m=2: ... dis 0 skipped 0 | det h (0, 0)
  ... all 12 blocks ...
  lambda=(5, 2) m=2: ... dis 0 skipped 0 | det h (0, 0)

SHIPPED ASSERTS: dis == 0 -> True; skipped == 0 -> True; square -> True; inhom == 0 -> True; count 7770 -> True
```

61 seconds for the whole battery. **Every assert in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) passes on a cache whose 41 copies carry only 24 distinct vector lists.** h is the all-ones matrix on every block, which is Hermitian, which is probe-independent, and which is therefore invisible to `dis`, to `skipped`, to the Hermitian assert, to `square`, to `inhom` and to `n == 7770`.

**The reason `square` cannot see it is worth stating precisely.** `square` compares `len(MONS[w])` with `len(COLS[w])`, a count of monomials against a count of vectors. Duplicating a copy preserves the count exactly, because each duplicate lands in the same weight class as its original. What fails is **independence**, and a count cannot express independence. That is [REVIEW_r199.md](REVIEW_r199.md) item 1's "still open", demonstrated: the per-weight matrix loses rank, 186/193 at weight (1,1) and 144/147 at (2,1) for the two-block plant, while `square` reports True throughout.

**Three checks catch it, and the file contains none of them.**

| check | fires | cost | status in the file |
|---|---|---|---|
| `det h != 0 mod p` | (0,0) on all 12 blocks | free, h is already built | **deleted at this HEAD**: `det_p` removed, lines 224-226 |
| `rank == n` in the per-weight solve | 186/193, 144/147 | one pass already in `solve_weight` | `solve_weight` is **never called**, see below |
| the printed complex off-diagonal counts | 2,0,2,6,2,2,4,0,0,0,0,0 becomes twelve zeros | free | a `print`, not an assert |

**The deletion is the finding.** [REVIEW_r199.md](REVIEW_r199.md) item 3 asked for `assert det_p(HMAT[lam])` inside the loop at line 183, calling it "the only thing in the file that would notice coincident copies, and the one test the one-sided mod-p argument actually supports". The working tree's response was to delete `det_p` as dead code. It was dead; the repair for a dead check is to call it, and the check was deleted instead. As the file now stands the comment at lines 122-127, that reduction gives "nonzero mod p implies nonzero over Q", so the argument supports a non-vanishing test, names no test in the file at all, which is what both r199 and r200 said and which is now one degree worse, because the candidate has been removed rather than left uncalled.

**det h is exactly the right check for the mod-p regime.** `det h != 0 mod p` implies `det h != 0` over Q(i), the one-sided direction the file's own paragraph describes. It cannot produce a false alarm, and its false-negative rate is the probability that a genuinely singular h reduces to something nonzero mod p, which is zero. It costs nothing: `HMAT[lam]` is built already, m is at most 4, and the determinant of a 4x4 matrix of Gaussian pairs is 24 products.

**And `solve_weight` is never called.** Lines 421 and 435 define `sample_weyl` and `solve_weight`; `grep` finds no call to either anywhere in the file, which ends at line 480 on a `print`. Stage 4 does not run. Everything r199 and r200 found in `solve_weight`, the key-type bug, the `hit` assert that repairs it, the missing `assert r == n`, the missing residual test, is in code that never executes, and the section's own comment at lines 414-416 ("Run to completion before anything here is claimed") introduces it. `wm2 = load("run_n5_weyl_module.py")` at line 419 is a module load paid for two functions nobody calls.

**Cheapest closure, in order.** `assert det_gp(HMAT[lam]) != (0, 0)` in the loop at line 246, beside the Hermitian assert, which is one line and catches the plant on the first block. Then the independence test `square` cannot give, which is the rank of the per-weight matrix and is the same elimination `solve_weight` already writes.

---

## Claim 1, the pair arithmetic is right, and it is right against exact Q(i), not only against itself

**192's measurement, reproduced** ([claim1_2_values.py](../scripts/reviewers/r202/claim1_2_values.py)):

```
h on lambda=(2,0), pair form mod p:      [(1,0), (0,162169)] / [(0,837864), (342152,0)]
192's exact h reduced mod p:             [(1,0), (0,162169)] / [(0,837864), (342152,0)]
  MATCH: True
  same h at probe 7: True
```

162169 is 55/37 mod 1000033 and 342152 is 5075/1628, so the pair form gives exactly `[[1, 55i/37], [-55i/37, 5075/1628]]`.

**The stronger test, which nobody had run: exact Q(i) at probe 0 on all 12 multiplicity blocks** ([claim1_exact.py](../scripts/reviewers/r202/claim1_exact.py)). The risk the mod-p pair form carries is an **undercount** of the complex off-diagonals: a genuinely nonzero imaginary part whose numerator happens to be divisible by the prime reads as real. The six blocks the run reports at 0 are exactly the ones at risk, and they are the six the brief quotes.

```
(2,0) m=2 exact 2  modp 2  MATCH True  exact-Hermitian True  reduces to the mod-p h: True
(3,0) m=2 exact 0  modp 0  MATCH True  ...
(2,1) m=2 exact 2  modp 2  ...   (2,2) m=4 exact 6  modp 6  ...
(4,0) m=2 exact 2  modp 2  ...   (3,1) m=2 exact 2  modp 2  ...
(3,2) m=3 exact 4  modp 4  ...   (4,1) m=2 exact 0  modp 0  ...
(4,4) m=2 exact 0  modp 0  ...   (4,2) m=4 exact 0  modp 0  ...
(4,3) m=2 exact 0  modp 0  ...   (5,2) m=2 exact 0  modp 0  ...
      exact h on (2,0) = [[1, 55i/37], [-55i/37, 5075/1628]]
```

Every entry of the exact Gaussian-rational h reduces to the corresponding mod-p pair, and h is Hermitian over Q(i) on all 12. The counts the brief quotes (6 at (2,2), 4 at (3,2), 2 each at (2,0), (2,1), (4,0), (3,1), 0 at the other six), are the truth, not a mod-p artefact.

**Four seconds for all twelve blocks.** That is the whole of the exact computation, because it needs only the probe-0 vectors, whose supports run from 7 to 147 monomials. The mod-p pair machinery at this site buys nothing: `HMAT` could be built over Q(i) exactly, in four seconds, and the one-sided-reduction paragraph would then have nothing left to caveat about `HMAT`. The mod-p path earns its cost in the multi-probe loop, which touches all 7770 vectors; it does not earn it in the twelve 4x4-at-most Grams.

**The Hermitian assert fires under sabotage.** Two independent corruptions of the pair arithmetic, each leaving the code otherwise intact:

| sabotage | Hermitian on (2,0), (2,2), (3,2) | assert fires |
|---|---|---|
| sign error in `gpmul`'s imaginary cross term | False, False, False | yes |
| `gpconj` replaced by the identity | False, False, False | yes |

This is the strongest assert in the file: it is the only one that fires on all three blocks tested under both plants, and unlike `dis` it has no gauge symmetry.

---

## Claim 2, the digest hashes what it says it hashes, and is compared to nothing

**Three plants, all caught** ([claim1_2_values.py](../scripts/reviewers/r202/claim1_2_values.py)):

```
  clean                                   84a0459fe49cc41e
  copy 0 coefficient doubled              1338bee336931a58  changed True
  copy 3 of (2,2) coefficient tripled     ec5bbfced6a37393  changed True
  coefficient zeroed, key kept            c0f529492eb283d9  changed True
```

The second is the case the old digest missed by construction (a copy other than 0) and the third is the case a support-size hash cannot see, a coefficient set to zero with its key retained. The repair does what it claims.

**It still has no error state.** `grep` over [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) finds `_dig` on exactly two lines, 109 where it is computed and 112 where it is printed, and the string appears nowhere else in the repository, no committed reference, in the source, in [plan.md](../plan.md) or in [findings/INDEX.md](../findings/INDEX.md). `assert n == 7770` is still on line 113 beneath it. The digest of the pickle at this HEAD is **`84a0459fe49cc41e`**, and that is the hex to commit.

Two qualifications on committing it. It is computed only on the cache-hit path, so a rebuild from scratch produces no digest at all and has nothing to compare. And it is order-sensitive in the word list, per claim 3a, so it will reject a rebuild that differs from the reference by a gauge transformation, which is the right behaviour for a provenance check and the wrong behaviour for a correctness check, and the comment at lines 97-101 should say which of the two it is.

---

## One hygiene defect, hit rather than looked for

[run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) line 275 is `with open(_p, "w") as _f: json.dump(_cache, _f)`, executed unconditionally on every import, and every module in the n=5 pipeline imports it. Truncate-then-write with no temporary file and no rename, so any concurrent reader that lands inside the window reads a truncated file. This review hit it:

```
json.decoder.JSONDecodeError: Expecting ',' delimiter: line 1 column 155640 (char 155639)
```

with reviewer 201's run in flight at the same moment. The file was valid again seconds later. Two lines fix it, write to `_p + ".tmp"`, then `os.replace`, and the same file makes the opposite argument for the other cache: [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) lines 157-160 deliberately decline to rewrite the pickle when it was loaded, crediting 198, because "the pickle carries its own provenance in its mtime". That reasoning applies verbatim to the JSON cache, where it was not applied, and the mtime of `n5_hw_cache.json` is therefore the time of the last run rather than the time the content was produced.

---

## What I would change, smallest first

1. **`assert det_gp(HMAT[lam]) != (0, 0)`** in the loop at line 246. One line, free, and it is the only thing that catches coincident copies. It restores a referent to the one-sided mod-p paragraph, which currently names nothing.
2. **Fix the 681 in the comment at lines 96-99 to 103**, matching the assert message on line 120 that already says 103. The two disagree in shipped source.
3. **Commit `84a0459fe49cc41e`** and compare, and say in the comment that the digest is provenance rather than correctness, it fires on a gauge change and it does not run on the rebuild path.
4. **Build `HMAT` exactly over Q(i).** Four seconds for all 12 blocks, measured. The mod-p pair form is verified correct at this site, so this is not a repair; it is removing a caveat for the price of nothing.
5. **The independence test `square` cannot give**: the rank of the per-weight matrix, which is the elimination `solve_weight` already contains.
6. **Either call stage 4 or delete it.** `sample_weyl` and `solve_weight` are defined and never called; the section's own comment says to run it to completion before anything in it is claimed, and four reviewers have now filed findings against code that does not execute.
7. **`os.replace` for `n5_hw_cache.json`**, and stop rewriting it when it was loaded, for the reason [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) already gives about the pickle.

**On 199's two blind spots, the summary.** One of them is a symmetry of the problem and should be left alone; the other is a live hole whose only cheap detector was deleted in this cycle. Treating them as a pair understates the second, and the record should carry them apart.
