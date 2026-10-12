# Review r201, the Hermitian assert passes on a product where i squared is +1

Audited at HEAD `c6da435`, re-read against `b167362`. Reviewer 201, Gate 2, brief `brief13.md`. Scripts: [scripts/reviewers/r201/](../scripts/reviewers/r201/). Log: [agent_logs/gate2_201.log](../agent_logs/gate2_201.log).

**Reviewer 202 filed on this brief while this was running.** We agree on the exact Q(i) values, the off-diagonal counts, the digest, 103, the gauge symmetry and the coincident-copy hole, each reached independently, and I do not restate his arguments. One line of his verdict table is too strong and is corrected here: *"the Hermitian assert fires under both sabotages of the pair arithmetic"*. I planted seven, and **two of them pass**, including the one that replaces Q(i) by the split-complex algebra, where i squared is +1.

| new here | where |
|---|---|
| a product with i squared = +1 passes the Hermitian assert with **65 of 77 h entries wrong**, and the structural reason why no Hermitian test can ever see it | [1.1](#11-the-assert-is-a-symmetry-test-so-it-cannot-see-the-one-thing-the-pair-form-was-adopted-to-protect) |
| a three-line unit test that, together with the existing assert, catches **all seven** arithmetic sabotages | [1.2](#12-what-closes-it-three-lines) |
| the h normalisation has no `q00 != 0` guard, so a probe killed mod p yields h identically zero, which is Hermitian | [1.3](#13-a-second-way-past-the-assert-the-normaliser-is-unguarded) |
| h is exactly **positive definite** on all 12 blocks over Q(i), Sylvester, every leading minor, with the det table | [1.4](#14-what-the-object-actually-is-h-is-positive-definite-over-qi) |
| the exact Q(i) route costs **7 s for all 77 entries**, less than the mod-p route it screens for | [1.5](#15-the-screen-is-slower-than-the-thing-it-screens-for) |
| two disagreeing digests are already on record for the same untouched pickle | [2](#claim-2-the-digest-separates-nine-corruptions-and-two-values-for-one-cache-are-already-on-record) |

## Verdict table

| claim | verdict | the one line |
|---|---|---|
| 1. is the pair arithmetic correct | **UPHELD, exactly** | all 77 h entries of the 12 blocks reduce from the exact Q(i) values; (2,0) is 192's [[1, 55i/37], [-55i/37, 5075/1628]] to the digit |
| 1'. does the Hermitian assert fire under sabotage | **PARTLY, 5 of 7 fire, 2 pass** | i squared = +1 passes with 65/77 entries wrong; swapping re and im in `gp` passes with 18/77 wrong |
| 1''. do the complex off-diagonal counts match exact Q(i) | **UPHELD** | 6 / 4 / 2,2,2,2 / six zeros, confirmed entry by entry; no zero is a false zero |
| 2. the cache digest | **UPHELD as a hash, EMPTY as a check** | 9 of 9 corruptions move it, all at count 7770; it is printed and compared to nothing, and the record already holds two different digests for one unmodified pickle |
| 3a. permutation of the word list on every copy | **NOT A DEFECT** | h is bit-identical and `dis` is 0 because the permutation is a relabelling that preserves the whole construction, converging with r202 |
| 3b. coincident copies | **LIVE HOLE** | every copy of every block set to copy 0: `dis` 0, `skipped` 0, Hermitian True; `det h != 0` is the cheap catch and it was deleted at this HEAD |
| 4. 103 against 681 | **SETTLED: 103**, by a third route | strip primes below 1e5 from all 147,014 distinct numerators, trial-divide the 9,794 surviving cofactors: 103 of 14,440 |

**Method.** Nothing under review was edited. [plant.py](../scripts/reviewers/r201/plant.py), [plant2.py](../scripts/reviewers/r201/plant2.py) and [plant3.py](../scripts/reviewers/r201/plant3.py) read [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) from disk, truncate it after the block under test (line 251 for the Gram, line 403 for `assert dis == 0`), apply one textual substitution against a unique anchor, and `exec` the result with `__file__` set to the real path, so every variant differs from the shipped file in exactly the planted defect, and the shipped loaders, cache and prime are the real ones. The baseline variant is the unmodified text and it passes.

---

## Claim 1, the arithmetic is right, and the check that guards it is weaker than the record says

### 1.0 The values are exact

[exact_h.py](../scripts/reviewers/r201/exact_h.py) computes h over Q(i) with `Fraction` arithmetic and no prime anywhere: h_ij = <R_i[0], R_j[0]> / <R_0[0], R_0[0]>, the same probe the file uses. [compare.py](../scripts/reviewers/r201/compare.py) reduces those 77 entries mod 1000033 and compares them to `HMAT` as the shipped code builds it.

```
entries compared 77, mismatches 0
(2,0) equals 192's [[1,55i/37],[-55i/37,5075/1628]] EXACTLY: True
```

The full exact Gram, for the record, every entry is purely real or purely imaginary, consistent with 199's measurement that 0 of 826,486 cached coefficients carry both parts:

| lambda | m | h | complex off-diagonals (exact = mod p) |
|---|---|---|---|
| (2,0) | 2 | [[1, 55i/37], [-55i/37, 5075/1628]] | 2 |
| (2,1) | 2 | [[1, 9i/16], [-9i/16, 243/128]] | 2 |
| (2,2) | 4 | row 0: [1, -16/111, -25i/74, -20/37] | 6 |
| (3,0) | 2 | [[1, 3/20], [3/20, 601/1680]] | 0 |
| (3,1) | 2 | [[1, 21i/64], [-21i/64, 153/128]] | 2 |
| (3,2) | 3 | row 0: [1, 3/4, 9i/8] | 4 |
| (4,0) | 2 | [[1, -76i/43], [76i/43, 275/86]] | 2 |
| (4,1) | 2 | [[1, -31/27], [-31/27, 347/243]] | 0 |
| (4,2) | 4 | row 0: [1, 81/40, -31/15, 5/3] | 0 |
| (4,3) | 2 | [[1, -2/27], [-2/27, 88/243]] | 0 |
| (4,4) | 2 | [[1, -5/8], [-5/8, 11/24]] | 0 |
| (5,2) | 2 | [[1, -5/32], [-5/32, 135/512]] | 0 |

18 complex off-diagonals in total, distributed exactly as the brief reports. The six blocks reporting 0 report it because the entries are real over Q(i), not because a numerator died mod p.

### 1.1 The assert is a symmetry test, so it cannot see the one thing the pair form was adopted to protect

Write the measured Gram as h_ij = X_ij * inv with X_ij = sum_ab c_ia * conj(c_jb) * K(t_a, t_b), where * is whatever product `gpmul` implements and conj is whatever `gpconj` implements. `assert herm` holds as an **identity in the data** as soon as three things are true:

1. the kernel is conjugate-symmetric, K(s,t) = conj(K(t,s));
2. * is commutative and associative;
3. conj is a ring involution for *, conj(u*v) = conj(u)*conj(v).

Condition 1 is a property of [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) alone and holds structurally: H_ab is built as sum_ijkl x_a conj(x_b), so H_ba = conj(H_ab), and `sym3_ip` sums over bijections, which carries that symmetry to Sym^3 term by term, measured at 0 violations over all 45 stored entries in [exact_h.py](../scripts/reviewers/r201/exact_h.py). Conditions 2 and 3 are properties of the four lines of pair arithmetic and of **nothing else**. The adapted vectors never enter, so no corruption of them can be seen here.

Now take the split-complex product, `gpmul` with the sign of i squared flipped. It is commutative, associative, and conj(u,v) = (u,-v) is still an involution for it. All three conditions hold, so h comes out Hermitian, and the assert passes on an algebra that is F_p x F_p under (a,b) -> (a+b, a-b), a **worse** collapse of Q(i) than the one reviewer 200 found, since it splits the field into two independent copies of F_p rather than mapping it into one.

Measured ([plant2.py](../scripts/reviewers/r201/plant2.py), each row a run of the real file with one substitution; "h vs truth" counts entries differing from the exact Q(i) Gram reduced mod p):

| plant | substitution | assert | h vs truth | complex off-diags |
|---|---|---|---|---|
| S0 | none (the shipped text) | passes | 0/77 | 18 |
| **S1** | **`gpmul` with i squared = +1** | **passes** | **65/77 wrong** | 18 |
| S2 | `gpconj` = identity | FIRES | (|), |
| S3 | `ip3_g` drops the conjugation | FIRES | (|), |
| S4 | `gp` folds i into one residue (r200's collapse) | FIRES | (|), |
| S5 | `gpmul` made non-commutative | FIRES | (|), |
| S6 | `gpconj` negates the real part | FIRES | (|), |
| **S7** | **`gp` swaps re and im** | **passes** | **18/77 wrong** | 18 |

S1 and S7 are the two that satisfy conditions 2 and 3, and they are exactly the two that pass. The count of complex off-diagonals is 18 in every passing case, so that printed diagnostic separates nothing either.

The assert is worth keeping, it catches r200's collapse, which is what it was written for, and four more. What it does not do is establish that the arithmetic is Q(i).

### 1.2 What closes it: three lines

[fixcheck.py](../scripts/reviewers/r201/fixcheck.py) reimplements each sabotage in isolation and runs three candidate one-liners against it:

```
variant                i^2 = -1   gp keeps i   gp is a ring map
shipped                True       True         True                PASSES ALL
S1 i^2 = +1            False      True         False               CAUGHT
S4 collapse            True       False        True                CAUGHT
S5 non-commutative     True       True         True                PASSES ALL
S7 gp swaps re/im      True       False        False               CAUGHT
```

that is,

```python
assert gpmul((0, 1), (0, 1)) == (PRIME - 1, 0)
assert gp((F(1), F(0))) == (1, 0) and gp((F(0), F(1))) == (0, 1)
assert all(gpmul(gp(x), gp(y)) == gp(cmul(x, y)) for x, y in SAMPLE)
```

Each is O(1) and needs no cache. **Together with the existing Hermitian assert they catch all seven plants**: S1 and S7 by the unit tests, S2, S3, S4, S5, S6 by the assert. The two are complementary rather than redundant, the assert alone misses S1 and S7, the unit tests alone miss S5.

### 1.3 A second way past the assert: the normaliser is unguarded

The Gram block normalises by `q00 = ip3_g(copies[0][0], copies[0][0])`, then `den = q00[0]^2 + q00[1]^2` and `dinv = pow(den, PRIME-2, PRIME)`. There is no check that `q00 != (0,0)`. When it is zero, `pow(0, p-2, p)` returns 0, `inv` is (0,0), the whole row comes out zero, and the all-zeros matrix is Hermitian with 0 complex off-diagonals, a silent pass on a dead block.

Plant D3 makes it happen: scale copy 0's probe vector of (2,0) by PRIME, so q00 vanishes mod p while the object stays perfectly good over Q.

```
[D3 probe scaled by PRIME] passes  | h vs exact truth: 4/77 entries wrong | complex off-diags 16 (truth 18)
```

The whole (2,0) block is replaced by zeros and nothing complains. The asymmetry is worth naming: the `dis` loop at line 388 **does** guard the same expression, counts the skips, and asserts `skipped == 0` with the reason spelled out, "so `dis == 0` would mean 'never compared'". The Gram block twelve lines earlier needs the identical guard and does not have it. `assert q00 != (0, 0)` and `assert row[0][0] == (1, 0)` are each one line.

The scan at line 100 makes this unreachable for the current cache and prime, since it proves no cached coefficient dies mod p, but the scan covers coefficients, not the inner products built from them, and the guard costs nothing.

### 1.4 What the object actually is: h is positive definite over Q(i)

Beyond Hermiticity, [det.py](../scripts/reviewers/r201/det.py) evaluates every leading principal minor of the exact h by Gaussian elimination over Q(i):

```
  lambda=(2, 0): 1, 54675/60236        all real: True   all > 0: True
  lambda=(2, 2): 1, 2208/1369, 36720/50653, 891000/1874161   all real: True   all > 0: True
  lambda=(3, 2): 1, 11/4, 3267/64      all real: True   all > 0: True
  lambda=(4, 2): 1, 20979/1600, 169029/2000, 5733/25        all real: True   all > 0: True
  ... 12 of 12 blocks
```

Every minor is real and strictly positive, so by Sylvester's criterion h is positive definite on all 12 blocks. That is the property a multiplicity Gram must have and no assert in the pipeline tests it; it also gives the cheap catch for coincident copies below, since a repeated copy sends the top minor to 0.

### 1.5 The screen is slower than the thing it screens for

The mod-p pair arithmetic exists to make the Gram cheap. Measured, it is not cheaper. [exact_h.py](../scripts/reviewers/r201/exact_h.py) produces all 77 entries of all 12 blocks over Q(i) in **7 s** after a 7 s module load, on the same cache, the per-block timings all print as 0 s. The probe-0 Gram is small: the vectors involved carry 5 to 147 monomials, so the whole measurement is a few million `Fraction` operations.

The mod-p path is a screen whose one-sided direction the file itself documents; here the exact answer is available for the same money, so `HMAT` can simply be exact and the question of what the screen can and cannot see does not arise for this block. That does **not** extend to the `dis` sweep at line 388, which touches every position of every copy and is a different order of work, the recommendation is scoped to the Gram.

---

## Claim 2, the digest separates nine corruptions, and two values for one cache are already on record

[digest.py](../scripts/reviewers/r201/digest.py) lifts the digest verbatim from [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) and applies it to corrupted in-memory copies of the pickle. The clean value is `84a0459fe49cc41e`, which is what the shipped loader prints today.

| plant | digest moves | count still 7770 |
|---|---|---|
| C1 +1 on one coefficient, last block | yes | yes |
| C2 sign flip on one imaginary part | yes | yes |
| C3 two copies swapped in (2,2) | yes | yes |
| C4 two positions swapped, copy 1 only | yes | yes |
| C5 copies made coincident, (2,0) | yes | yes |
| C6 positions rotated in every copy | yes | yes |
| C7 one copy scaled by 2 | yes | yes |
| C8 one coefficient in the **last** copy of (4,2) | yes | yes |
| C9 one coefficient zeroed, support size kept | yes | yes |

9 of 9, and all 9 keep `n == 7770`, so the digest does the discriminating that 198 asked of it and the count assert still discriminates nothing. C8 and C9 are the two the previous shape digest provably missed.

**And it is compared to nothing.** `_dig` is formatted into one print and never read again, the only two references in the tree are its assignment and that f-string. The concrete cost of that is already visible in the record: [agent_logs/n5_pair.log](../agent_logs/n5_pair.log) line 2 reports `digest 4bef35d68377105b` for a run over `n5_adapted.pkl`, and the same loader over the same file, whose mtime predates that run and has not changed since, prints `84a0459fe49cc41e` today. The two disagree because the hashing code changed between them (commit `c6da435`), not because the cache did, but **nothing in the repo can tell those two causes apart**, which is exactly the failure mode a digest is meant to exclude. One stored constant and one `assert _dig == EXPECTED` closes it.

**Hygiene, measured and unreachable.** `to_p` asserts `a.denominator % PRIME` before inverting, with the reason written out, `pow(0, p-2, p)` silently returns the reduction of a pole. `gp`, which replaces it on the pair path, dropped that guard. It is not currently reachable: the cache holds 24 distinct denominators, the largest 3 bits wide, and every entry of H is an integer, so no denominator can be divisible by 1000033. It is one line and it should come back with the function that replaced its owner.

---

## Claims 3 and 4, converging with r202

**3a, the global permutation.** Rotating the positions of block (2,0) by 7 **in every copy** leaves h bit-identical (0/77 entries changed) and `dis` at 0. I read this as r202 does: it is a relabelling of one index that every downstream consumer carries uniformly (`BYW`, the weight blocks of Q and the coordinate solve all key off the same positions) so it changes no computed quantity and no check should fire on it. The falsifiable statement is that a permutation of a **single** copy is caught, and it is: the same rotation applied to copy 1 alone fires `assert dis == 0` at 10 disagreements (plant E3), while applied to both copies it gives 0 (plant E2). The pair E2/E3 is what makes `dis` a real check rather than a constant.

**3b, coincident copies.** Confirmed at full scale: with every copy of every block replaced by copy 0, the file runs from the top through `assert dis == 0` and passes, `dis` 0, `skipped` 0, Hermitian True on all 12 blocks. The cheap catch is `det h != 0`, which [det.py](../scripts/reviewers/r201/det.py) evaluates exactly on the real object at 12 nonzero values (54675/60236 at (2,0) up to 5733/25 at (4,2)) and at exactly 0 for the coincident control. That check was removed at this HEAD on the argument that "h at probe 0 is a nullspace basis Gram, so nonsingularity there is automatic". The argument is right and it is the reason the assert cannot fail on a **sound** cache; the case it was covering is a **corrupted** one, which the same comment names as its only reachable failure and then discards.

**4, the prime count is 103.** Third route, sharing no step with either earlier one ([primes.py](../scripts/reviewers/r201/primes.py)): take the 147,014 distinct nonzero absolute numerators in the cache, strip every prime factor below 1e5 from each, and trial-divide the 9,794 surviving cofactors by the 14,440 primes of the window. The cofactors are at most 28 bits, so each has at most one prime factor above 1e5 and the method is complete.

```
coefficients 826486, both parts nonzero 0
distinct nonzero numerators 147014, distinct denominators 24
primes in (900000,1100000): 14440
  [numerators] cofactors > 1 after stripping primes < 1e5: 9794  max bits 28
  [numerators] primes in the window dividing one: 103
  [denominators] primes in the window dividing one: 0
```

103, and 0 through the denominators. This also reproduces 199's two enabling measurements: 826,486 coefficients, of which 0 carry both parts. The comment at lines 96-99 of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) still says 681 and "a 95% draw"; the assert message it guards already says 103. The comment is the wrong one.

---

## Every plant in one table

Each row is one run of the real source with one planted defect.

| plant | what was corrupted | check under test | result |
|---|---|---|---|
| S0 | nothing | Hermitian | passes, h exact |
| S1 | `gpmul`, i squared = +1 | Hermitian | **passes**, 65/77 h entries wrong |
| S2 | `gpconj` = identity | Hermitian | fires |
| S3 | `ip3_g` drops the conjugation | Hermitian | fires |
| S4 | `gp` folds i into one residue | Hermitian | fires |
| S5 | `gpmul` non-commutative | Hermitian | fires |
| S6 | `gpconj` negates the real part | Hermitian | fires |
| S7 | `gp` swaps re and im | Hermitian | **passes**, 18/77 wrong |
| D1 | copy 1's probe vector of (2,0) replaced by random Gaussians | Hermitian | **passes**, 3/77 wrong |
| D2 | copies of (2,0) made coincident | Hermitian | **passes**, 3/77 wrong |
| D3 | copy 0's probe vector of (2,0) scaled by PRIME | Hermitian | **passes**, block zeroed |
| D4 | positions rotated in every copy of (2,0) | Hermitian | passes, h unchanged (gauge) |
| E0 | nothing | `dis == 0`, `skipped == 0` | passes, dis 0, skipped 0 |
| E1 | copies of (2,0) made coincident | `dis == 0` | **passes**, dis 0, skipped 0 |
| E2 | positions rotated in **every** copy of (2,0) | `dis == 0` | passes, dis 0 (gauge) |
| E3 | positions rotated in **one** copy of (2,0) | `dis == 0` | fires, dis 10 |
| E4 | every copy of every block set to copy 0 | `dis == 0` | **passes**, dis 0, skipped 0 |

D1 is the sharpest statement of what the Hermitian assert is not: a copy's probe vector replaced by pseudo-random Gaussian integers leaves h Hermitian on all 12 blocks, because the assert reads the arithmetic and never the data.
