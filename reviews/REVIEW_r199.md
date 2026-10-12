# Review r199, the sampling question, and three checks with no error state

Audited at HEAD `774e03b`, re-read against `ea88fc0`. Reviewer 199, Gate 2, brief `brief12.md`. Scripts: [scripts/reviewers/r199/](../scripts/reviewers/r199/). Log: [agent_logs/gate2_199.log](../agent_logs/gate2_199.log).

**Reviewer 200 filed on the same brief while this was running and reached the same headline independently: `assert cross == 0` is a tautology.** I confirm that finding from my own derivation and my own controls, and I do not restate his argument at length. What is new here is below, and the first item answers the question the brief made the priority.

| new here | where |
|---|---|
| the sampling is blind **on its own**, and would stay blind after the tautology is repaired, exact coverage, and a planted violation the shipped sweep passes | [1.2](#12-the-sampling-is-a-second-defect-and-it-survives-the-first-ones-repair) |
| `dis == 0` has two blind spots and an unasserted counter; and reviewer 200's `p^-k` case for not needing the exact version does not hold for a systematic error | [1.3](#13-dis--0-the-one-with-content-and-what-it-cannot-see), [3](#claim-3-the-mod-p-direction) |
| the exact-over-Q version of `dis`, which the record calls pending and nobody had run | [3](#claim-3-the-mod-p-direction) |
| the cache digest committed as the discriminating replacement for `n == 7770` cannot fail either, two independent reasons | [1.5](#15-upstream-the-cache-digest-cannot-fail-either) |

## Verdict table

| claim | verdict | the one line |
|---|---|---|
| 1. the four asserts now pass | **REFUTED** | there are three, and the first cannot fail, converging with r200 |
| 1'. **does the 60-pair sampling retain the power to detect a real violation** | **NO, and separately from the tautology** | it computes 1,330 of 1,318,354 cross-weight entries, **93.5% are unreachable at any sample size**, and a planted violation at one of them passes |
| 2. the prime | **UPHELD on the facts** | 1000033 is prime, is 1 mod 4, and 0 of 826,486 coefficients die under it; the powers of two are in the **denominators**, whose entire prime support is {2, 3, 7} |
| 3. the mod-p direction | **PARTLY WRONG**, and one degree worse than r200 records | the argument's named beneficiary was deleted; and `dis` is *not* protected by `p^-k` against a systematic error |
| 4. stage 4 | **WILL NOT RUN** | confirmed; r200's key-space diagnosis is right, and `sample_weyl` cannot reach the line it fails on |

**The reported run reproduces.** A byte copy run to completion in the sandbox, off the same cache (digest `4bef35d68377105b`), gives every figure the brief quotes: `square: True`, `cross ... 0`, `0 disagreements, 0 skipped`, `more than one weight: 0`, `unknowns: 89`. The numbers are right. The question is what they are worth, and the answer differs by assert.

**Method.** [scripts/reviewers/r199/sandbox/](../scripts/reviewers/r199/sandbox/) holds byte copies of the four modules and a symlink to `n5_adapted.pkl`; nothing under review was edited or executed. `base_assemble.py` is a byte copy of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) and every sabotaged variant is a **textual patch** of it produced by [patch.py](../scripts/reviewers/r199/patch.py) against a unique anchor, so each variant differs from the shipped file only in the planted defect. Where a variant is faster than the original it is because `QWIDTH`'s blocks, which feed stage 4 and not the sweep, are skipped; that is the only deviation.

**Every sabotage, in one table.** Each row is a run of a byte copy with one planted defect; `exit` is the process's own exit code.

| variant | planted defect | check under test | exit | verdict |
|---|---|---|---|---|
| `var_square` | one adapted vector deleted from the weight-(0,0) class | squareness | **0** | reports `False`, continues |
| `var_cross_plant` A | one cross-weight `Q` entry forced nonzero at (0, 127) of (6,4) | `cross == 0` | **1** | fires, the assert is reachable |
| `var_cross_plant` B | the same, at (0, 1), reachable, but not among the 60 pairs drawn | `cross == 0` | **0** | **misses** (sampling) |
| `var_cross_plant` C | the same, at (8, 5), neither index first in its class | `cross == 0` | **0** | **misses** (`[:1]`) |
| `var_cross_data` | one copy-0 vector of (6,4) gains a foreign-weight monomial | `cross == 0` | **0** | **misses** the realistic corruption |
| `var_inhom` | the same corruption, run past the sweep | `inhom == 0` | **1** | fires |
| `var_h_swap` | two same-weight positions transposed inside copy 1 of (4,2) | `dis == 0` | **1** | fires, 12 disagreements |

**The brief's standard, answered directly.** For each check: can it fail, and has it been run?

| check | can it fail? | has it been run? |
|---|---|---|
| squareness, line 220 | **no**, it is a `print`; and the boolean is a count, blind to dependence | yes, and it reported `False` while the run continued |
| `cross == 0`, line 278 | **no** on weight-homogeneous input; on non-homogeneous input, with probability 1.01e-3 | yes, and it passed with a real violation present |
| `dis == 0`, line 335 | **yes**, exhaustively over 9,568 comparisons | yes, and it fires under a per-copy transposition |
| `inhom == 0`, line 341 | **yes**, exhaustively over 7770 vectors, exactly over Q | yes, and it fires |
| the cache digest, `run_n5_adapted.py` line 96 | **no**, it hashes support sizes, and it is never compared | it is computed and printed |

---

## Claim 1, the asserts

### 1.0 Three asserts, not four, and the fourth is already condemned in plan.md

`grep -n assert` gives three on the data: line 278 `cross == 0`, line 335 `dis == 0`, line 341 `inhom == 0`, plus line 94 on `IMOD` and the denominator guard inside `to_p`. "Every weight block square" is line 220, a `print`, followed by a diagnostic `if not square:` that prints and falls through.

Run rather than reasoned. `var_square.py` deletes one adapted vector from the largest weight class before `COLS` is built:

```
R199 removed one adapted vector of weight (0, 0): the class now has 233 vectors against 234 monomials
  every weight block is square: False   <- it must be, the adapted
R199 REACHED THE LINE AFTER THE SQUARE CHECK
```

Exit code 0. A `False` there is not fatal and should be, because `solve_weight` assumes squareness and has no residual check. Two further points: `square = all(len(MONS.get(w, [])) == len(COLS[w]) for w in COLS)` quantifies over `COLS` alone, so a weight in `MONS` and absent from `COLS` is never examined; and [plan.md](../plan.md) already carries this exact check in its table of checks that could not have failed, *"a count, invariant under the multiplicity-basis choice ... it fires only when a vector is zeroed"*, while commit `264c82c` ships it as one of the asserts that pass and can each fail.

### 1.1 `assert cross == 0` is a tautology, converging with r200

I derived this independently before r200's review was committed and record only the mechanism and my controls.

`H` is built in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) line 85 under `if WT[a] != WT[b]: continue`, so it stores no cross-weight key; `sym3_ip` drops a bijection term the moment `H.get` misses; a surviving term forces `WT[t_i] = WT[s_pi(i)]` for all three `i` and hence equal `Sym^3` weight. So `ip3(u, v) = 0` exactly for weight-homogeneous `u, v` of distinct weight, whatever the coefficients. [tautology.py](../scripts/reviewers/r199/sandbox/tautology.py), with the arithmetic lifted verbatim out of the file under review:

```
1. H keys with WT[a] != WT[b]: 0 of 45
2. sym3_ip on 156,928 cross-weight monomial pairs: 0 nonzero
3. control basis: 160 random vectors over 40 weights, each homogeneous
   shipped sweep (60 pairs, one vector each) on the garbage: cross = 0
   EXHAUSTIVE over all 12,480 cross-weight entries of the garbage: 0
```

One point of emphasis I would add to r200's account. The comment at line 260 (*"Reviewer 191 forced this repair on H and it was never carried across here"*), misidentifies what 191's repair was. 191's repair recomputes the discarded pairs **from the raw tensors `T`, bypassing `H`** ([run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) lines 99–111). This sweep calls `ip3`, which reads `H`, so it inherits the `continue` it was written to falsify, while copying the wording of the print line from the file where the check is real. The repair was not carried across; a routing of it through the very object it was meant to check was.

The only error state the sweep can reach is a **non-homogeneous** adapted vector, which can file a vector under one of its two weights and so produce a genuine cross-weight entry. That state is caught with certainty sixty lines later by `assert inhom == 0`, which uses no arithmetic at all, and the cross assert runs at line 278, *before* the homogeneity it depends on is established at line 341.

### 1.2 The sampling is a second defect, and it survives the first one's repair

r200 records the sampling question as moot. It is moot for the file as it stands, and it is not moot for the file after the obvious repair, because the two defects are independent: making `ip3` see cross-weight pairs (the fix that would give the sweep an error state), leaves the sampling exactly as blind as it is now. The numbers are the answer the brief asked for, so here they are, exact and unsampled ([coverage.py](../scripts/reviewers/r199/sandbox/coverage.py)):

| | entries |
|---|---|
| unordered cross-weight `Q` entries in copy 0, all 24 blocks | **1,318,354** |
| reachable by this code **at any sample size** | 85,764, **6.51%** |
| computed by `pairs[:60]` | **1,330**, **0.101%** |

The 6.51% is the part that matters, and it is structural rather than statistical. `for a in byw_[ws[x]][:1]` and `for b in byw_[ws[y]][:1]` restrict **both** indices to the first vector of its weight class, so any entry whose row or column is a later vector is excluded with certainty. **93.5% of the cross-weight entries cannot be reached however large the sample**; raising 60 to the full pair list would buy 6.51% and stop. Within the reachable part, one uniformly placed violation is detected with probability 1.01e-3, and about 687 simultaneous violations are needed for an even chance of one hit. And `_rnd.seed(11)` is fixed, so those 1,330 entries are the *same* 1,330 on every run, a violation outside them is missed by every run in perpetuity. Re-running is not a second sample.

**The control.** `var_cross_plant.py` wraps `ip3` to return 1 on exactly one designated pair of copy-0 vectors of lambda = (6,4), a single genuine block-diagonality violation, with everything else untouched.

| plant | site | outcome |
|---|---|---|
| **A** | positions (0, 127), one of the 1,330 the seed draws | `AssertionError: Q is not block-diagonal by weight`, **exit 1** |
| **B** | positions (0, 1), first-of-class on both sides, so reachable, but not among the 60 pairs drawn | `cross-weight Q entries COMPUTED and nonzero: 0`, **assert PASSED**, exit 0 |
| **C** | positions (8, 5), weights (4,5) and (5,4), neither index first in its class, so unreachable at any sample size | `cross-weight Q entries COMPUTED and nonzero: 0`, **assert PASSED**, exit 0 |

The three sites separate the two causes cleanly. **A** shows the assert is correctly wired and reachable, so the misses are not a wiring artefact. **B** is missed by the *sampling* alone, it is a pair the sweep is built to look at, and 60 of `(6,4)`'s 12,246 pairs is 0.5%, so it was not drawn. **C** is missed by the `[:1]`, which no sample size touches. Each is a real violation, present in the data, reported as `0   (must be 0)`.

### 1.3 `dis == 0`, the one with content, and what it cannot see

This one is not sampled: every position `t >= 1` of every block with `m > 1`, all `m^2` ratios, `sum_lambda m^2 (dim - 1)` over the twelve blocks, which is 9,568 comparisons across 1,503 probe positions. Reviewer 197's widening from `t <= 3` to every position is the right repair. It fires under sabotage: `var_h_swap.py` transposes two same-weight positions (4 and 5) inside copy 1 of lambda = (4,2), reviewer 195's sabotage, applied to one copy rather than to all of them.

```
R199 transposed same-weight positions 4,5 in copy 1 of (4, 2)
  h agrees across ALL probes: 12 disagreements, 0 skipped
AssertionError: Schur fails: h depends on the probe
```

Exit 1, and the counter distinguishes the twelve real disagreements from a silent pass.

Three things are not recorded.

* **The counter guarding it is not asserted.** `skipped` was added so that `dis == 0` could not mean "never compared". It is incremented at line 320, printed at line 334, and line 335 asserts `dis == 0` alone. A build in which every probe had `q = 0` would print `0 disagreements, 1503 skipped` and pass. The instrument is right and it is wired to nothing.
* **A wrong-but-shared word list is invisible.** Under `R_i[t] -> R_i[sigma(t)]` applied to every copy at once, `<R_i[t], R_j[t]> / q_t` is unchanged for every `i, j, t`, and `HMAT` is unchanged whenever `sigma(0) = 0`. `replay` applies one fixed list to all copies, so a shared list is precisely the shape this test cannot see. What it does see is a list chosen per copy, the defect [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) was written against, and the narrower of the two.
* **Coincident copies pass.** If the `copies[i]` are all equal then `h_ij = 1` at every position, consistently, and `dis = 0`. [plan.md](../plan.md) lists "two copies could coincide" as a live risk; since reviewer 198 removed the nonsingularity assert, nothing in the file detects it. `det h` is computed at line 183, printed, and discarded. Asserting it there costs one line, is the non-vanishing direction the mod-p argument actually supports, and (unlike the probe-0 version 198 removed as vacuous), would be evaluated on `HMAT` after it is built rather than on a nullspace basis by construction.

### 1.4 `assert inhom == 0`, exact, exhaustive, and the strongest of the three

`len({mwt(k) for k in v}) > 1` over all 7770 vectors: no prime, no modular arithmetic, no sampling, so its verdict holds over Q as it stands. Sabotage, `var_inhom.py`: one monomial of a foreign weight added to copy 0, position 100 of lambda = (4,2).

```
R199 made lambda=(4, 2) position 100 inhomogeneous
  adapted vectors carrying more than one weight: 1  (must be 0)
AssertionError: an adapted vector is not weight-homogeneous
```

Exit 1.

**It also carries the load the cross assert claims, and the contrast is the cleanest statement of 1.1 and 1.2 together.** `var_cross_data.py` plants the realistic version of the corruption the cross sweep exists to catch: one adapted vector in copy 0 of lambda = (6,4), at position 400, gains a monomial of a *different* weight, a genuine, live cross-weight `Q` entry, not a wrapper around `ip3`.

```
R199 corrupted lambda=(6, 4) position 400: added monomial 2 of weight (-6, -4) to a vector of weight (1, -2)
  cross-weight Q entries COMPUTED and nonzero: 0   (must be 0)
R199 CROSS ASSERT PASSED
```

Exit 0. The same defect fires `inhom` with certainty, at no arithmetic cost, sixty lines later. So on the one corruption the sweep can in principle see, it is beaten by an assert already in the file that costs nothing and has no sampling in it.

### 1.5 Upstream: the cache digest cannot fail either

[run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) lines 93–101 add a content digest on reviewer 198's finding that `assert n == 7770` is vacuous, 198 having exhibited three corruptions that pass at count 7770. The digest hashes

```python
(k, len(cs), tuple(len(v) for v in cs[0]))
```

block label, copy count, and the **support sizes of copy 0**. It is therefore invariant under any change to a coefficient *value*, and under any change whatever to copies 1 through m-1, which is 17 of the 41 copies. And it is `print`ed, never compared against a stored value, so it has no error state of any kind. Two independent reasons, and `assert n == 7770` is still on line 101 beneath it. The remedy is one committed hex string and a hash over the coefficients rather than over their count.

---

## Claim 2, the prime

Upheld on every fact the brief asks about. 1000033 is prime (`sympy.isprime`, `p - 1 = 2^5 . 3 . 11 . 947`); `1000033 mod 4 = 1`; `IMOD = 350504` by search, `350504^2 = -1`.

**Rescan under the new prime**, [scan_prime.py](../scripts/reviewers/r199/sandbox/scan_prime.py), all 826,486 stored coefficients, testing the operative condition `a + b . IMOD = 0 mod p` rather than only `p | numerator`:

```
P = 1000033  (i = 350504): denominators divisible by p: 0 | numerators: 0 | FALSE ZEROS: 0
P = 65537    (i = 256):    numerators: 1 | FALSE ZEROS: 1
   witness ((6, 4), 0, 787, 56, Fraction(701361681334272000, 1), Fraction(0, 1))
```

197's witness is reproduced exactly from the pickle, independently. The new prime is clean.

**On "unrelated to the construction", which I read differently from the file and the same way as r200.** Separating the two halves of the cached rationals ([denominators.py](../scripts/reviewers/r199/sandbox/denominators.py)):

```
denominators != 1: 72,470 over 23 distinct values
  their whole prime support: [2, 3, 7]
distinct nonzero numerators: 147,014, up to 21 digits
primes in [900001, 1100000]: 14,440  (product has 287,772 bits)
primes in that window dividing SOME numerator: 103 (0.7%)
  1000033 among them: False
  65537 divides a numerator: True
```

**A discrepancy with r200 on one number, checked three ways.** He reports 681 of the 14,440 primes in that window dividing some numerator, a 4.7% risk, now written into a code comment and an assert message in the working tree; I get 103, a 0.7% risk. Three routes, all agreeing ([crosscheck_primes.py](../scripts/reviewers/r199/sandbox/crosscheck_primes.py), [denominators.py](../scripts/reviewers/r199/sandbox/denominators.py)):

1. gcd of each numerator against a product tree of all 14,440 primes, then factor the gcd, 103 primes, carried by 105 of the 147,014 numerators;
2. plain trial division of every prime against every numerator, on a 600-prime subwindow, 7, against the product tree's 7 on the same subwindow;
3. the structural reason: these numerators are smooth. Of 300 sampled, **3 have any prime factor above 10^5 at all**. A prime near 10^6 dividing one is rare because the cache is built by rational elimination on small integers, which is the same fact the "powers of two" remark was reaching for and got the wrong half of.

The candidate explanation that the two of us measure different conditions, `p | numerator` against the false zero `a + b . IMOD = 0 mod p`, does not survive: no cached coefficient has both parts nonzero, so the two conditions coincide here. **The conclusion is identical under either figure and neither of us should be read as disagreeing about it**: escaping was a draw rather than a consequence, and nothing checked it. The magnitude is what differs, and it is now quoted in the code, so it wants rebuilding before it hardens.

The powers of two are in the **denominators**, and no prime above 7 can divide one. The 65537 witness has denominator 1, it is a numerator with an ordinary large prime factor. So the property that saved 1000033 is "divides no numerator of this cache", which is a fact about one pickle rather than about the prime, and nothing in the pipeline tests it. My scan is the test; it costs half a second and belongs in the file.

**Two stale docstrings.** `to_p` (line 104) still says *"with i = 256"* and `ip3` (line 133) still says *"256 -> -256"*. 256 is the square root of -1 mod 65537. The two lines that tell a reader how the imaginary unit is represented both name the wrong element, changed in the same commit that changed the prime.

**Scope.** The scan covers stored basis coefficients. A false zero is equally live inside `sym3_ip` values and inside the `ip3` accumulator (`ip3` drops a term on `if not cap: continue`) and those are not enumerable, which is a second reason the mod-p verdicts stay screens.

---

## Claim 3, the mod-p direction

The logic is stated correctly and the referent is stale: the paragraph at lines 96–101 says the one-sided argument *"supports the NONSINGULARITY assert"*, and that assert was removed at line 290. **As the file stands, the one-sided argument supports no assert in it.** The count "two zero-tests" is right (`inhom` is exact combinatorics and the square check compares list lengths) and the file never says which two, nor that the others are exact. All of this agrees with r200.

**Where I part from r200.** He classifies `dis` as not needing the exact version, on the ground that hiding a real violation requires every disagreement to vanish at once, at `p^-k`, with `9568/p = 0.0096` expected false agreements. **That bound assumes the k discrepancies are algebraically independent mod p, and the failure mode being screened does not have that shape.** If `h` depends on the probe through a systematic error (a normalisation, a convention, a word list applied to the wrong copy), the discrepancy at each position is the *same* rational, or a common rational times a position-dependent factor. Then `p | numerator` at one position implies it at all of them, the events are perfectly correlated, and the probability is `p^-1`, not `p^-k`. The instrument that separates the two cases is reviewer 197's recomputation at a second prime, and it is worth considerably more than the comparison count.

**So the exact version is worth having, and nobody had run it.** [exact_h.py](../scripts/reviewers/r199/sandbox/exact_h.py) runs the multi-probe check over Q(i) with `ip3_exact`, every position, smallest blocks first:

```
  lambda=(2, 0) m=2 dim  14: probed to t=13,  0 disagreements   [21s]
  lambda=(3, 0) m=2 dim  30: probed to t=29,  0 disagreements   [55s]
  lambda=(2, 1) m=2 dim  35: probed to t=34,  0 disagreements   [82s]
  lambda=(2, 2) m=4 dim  35: probed to t=34,  0 disagreements   [145s]
  lambda=(4, 0) m=2 dim  55: probed to t=54,  0 disagreements   [203s]
  lambda=(3, 1) m=2 dim  81: probed to t=80,  0 disagreements   [296s]
  lambda=(3, 2) m=3 dim 105: probed to t=104, 0 disagreements   [443s]
  lambda=(4, 1) m=2 dim 154: probed to t=138, 0 disagreements   [600s]

EXACT over Q(i): 2872 comparisons, 0 disagreements, 0 skipped
```

**2,872 of the 9,568 comparisons, 30% of the assert's domain, verified over Q(i) with no prime in them**, seven complete blocks and part of the eighth, in ten minutes on one core. Schur orthogonality holds exactly on that part, so on it the screen and the certificate now agree. Two side facts fall out. `skipped` is 0 exactly, which it must be: the form is positive definite over Q, so `q_t = 0` cannot occur and every skip the mod-p run could ever report would be a *false* zero, the counter is a prime-quality meter rather than a coverage meter, and reading it as coverage would invert its meaning. And the ten-minute cost for 30% says the whole assert is exactly verifiable overnight, which puts it well inside what a certificate can afford.

That is the check the file calls "pending", discharged over Q on part of its domain. On the rest it remains a screen, and `dis` is the only one of the three asserts for which the distinction has any content: `cross` is a tautology, so no exact recomputation can rescue it, and `inhom` is already exact.

---

## Claim 4, stage 4, read rather than run

**r200's first failure is right and I confirm it**: [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py)'s `cube` (line 216) keys its output by monomial **tuple** while `solve_weight` builds `mi` over monomial **indices**, so `if k in mi` is false for every key, the augmented column stays zero, and every solve returns `x = 0` silently. Three additions behind it:

1. **`sample_weyl` cannot even reach that line.** It returns `wm2.sym2_to_R(...)`, a `5 x 5 x 5 x 5` nested list of `Fraction`s, a Weyl tensor in the `Sym^2(Lambda^2)` realisation, not a `Sym^3` element. `solve_weight` calls `target.items()` on it: `AttributeError`. And its 35 random coordinates index `wm2.BASIS`, in the `Sym^2(Lambda^2)` nullspace ordering, whereas `MONO` indexes `hw.WBASIS`, the joint `H1`/`H2` weight basis over Q(i). Nothing maps between the two orderings. Wiring `cube` in is not a key-type fix; it is a change of which function produces the sample.
2. **The right-hand side was reduced with the wrong operator, and one of the two ways it can arrive fails silently.** At `774e03b`, line 375 filled the matrix columns with `to_p(cv)` while line 377 filled the augmented column of the same matrix with `cv % PRIME`. A `G` raises `TypeError` and a `(Fraction, Fraction)` pair raises `TypeError`, but a bare `Fraction` does not: `Fraction(3,2) % 1000033` returns `3/2`, putting a rational into a modular elimination with no exception. *The working tree has since changed the line to `to_p(cv)` and added a `hit` assert on the key types, so this and r200's key-space finding are both repaired.*
3. **No solvability check.** `solve_weight` pivots over `c in range(n)` and never inspects the augmented column afterwards. A rank-deficient block sets the free coordinates to 0 and returns one arbitrary member of an affine family; an inconsistent system returns a vector that does not expand the target. Neither signals. `assert r == n` and `assert all(A[t][n] == 0 for t in range(r, len(A)))` cost nothing. And squareness (now asserted), is a *count*: `solve_weight` needs the adapted vectors of a weight to be linearly *independent*, which nothing tests.
4. **The docstring's four checks still do not exist.** Lines 18–29 promise `B` Hermitian at every sample point, the trivial block proportional to `tr(W^3)^2`, rank exactly 14, and consistency `rank(A) = rank[A | F_5]`. `grep -n "F_5\|rank\|Hermitian"` finds no code for any of the four. Lines 30–33 of the same docstring accuse `run_n5_evaluate.py` of exactly this, and [plan.md](../plan.md) already records it once. This is the third telling, in a file that names the defect in its own opening paragraph.

Two smaller ones. `import random as _rnd` (line 265) and `import random as _r2` (line 350) bind the same module, so `_r2.seed(17)` resets the generator whose `seed(11)` the cross sweep's reproducibility rests on, inert only because the sweep has already run, and it makes the sweep's fixed sample an artefact of statement order. And `IDX` (lines 361–366) reconstructs `BYW` (lines 60–66) entry for entry, with `COLS` (lines 215–217) the same structure a third time: three resident names for one 7770-entry index.

---

## The working tree has already moved, and two of the repairs need a second look

`run_n5_assemble.py` changed under this review, on findings from this review and r200's. Three of the four changes are right: `square` is now an `assert` (crediting the forced `square=False` above), the cross-weight sweep is deleted with both reasons recorded, and the two `i = 256` docstrings are corrected. Two points on what replaced them.

**The deletion leaves nothing in this file watching the fact.** The comment points at `run_n5_evaluate.py`, which is correct, the exhaustive exact check is there and runs. But `run_n5_assemble.py` loads that module with `quiet=True` and never inspects its result, so a regression on the evaluate side would print into `/dev/null` and the assemble run would proceed. `cross` is a module-level name in `run_n5_evaluate.py`, defined at line 99 and incremented at line 110 and nowhere shadowed, so `assert ev.cross == 0` costs one line and closes that gap without restaging anything.

**The new prime scan tests a quantity that is right only by a property of the cache that nothing states.** `_scan_prime` computes `(x.r.numerator + x.i.numerator * IMOD) % PRIME`, discarding both denominators, whereas `to_p` computes `a1 . a2^-1 + b1 . b2^-1 . IMOD`. Those agree on vanishing only when the two parts share a denominator. In this cache all 72,470 non-unit denominators sit on coefficients whose *other* part is zero (I checked: **of 826,486 coefficients, exactly 0 have both real and imaginary parts nonzero**) so a lone part's denominator is an invertible scalar and the two conditions coincide. The assert is therefore sound today and stops being sound the first time a coefficient carries both parts, with no signal. Calling `to_p(x)` instead is the same cost and needs no hypothesis.

**And the 681 in that comment does not reproduce.** See claim 2: I get 103, by three routes that agree. The figure is now in a shipped code comment and in an assert message, which is the point at which a reviewer's unrebuilt number becomes part of the record.

---

## What I would change, smallest first

*Marked `[done]` where the working tree already carries the change.*

1. `[done]` Make the square check an `assert`. **Still open:** quantify it over `MONS.keys() | COLS.keys()` rather than over `COLS` alone, and add the independence test that a count cannot give.
2. Assert `skipped == 0` beside `dis == 0`. The counter exists to stop `dis == 0` meaning "never compared" and is read by nobody, and the exact run shows a nonzero `skipped` would be a false zero rather than a coverage gap.
3. Assert `det_p(HMAT[lam])` inside the loop at line 183, where it is already computed and thrown away. It is the only thing in the file that would notice coincident copies, and it is the one test the one-sided mod-p argument actually supports.
4. `[done]` Delete the cross sweep. **Still open:** `assert ev.cross == 0`, so that the exhaustive exact check the comment now points at is one this file would notice failing.
5. Move `assert inhom == 0` above whatever stands where the sweep did: it is the hypothesis the sweep's silence depended on, and it is the cheaper of the two.
6. Compare the cache digest against a committed value, and hash the coefficients rather than their support sizes.
7. `[done]` `cv % PRIME` -> `to_p(cv)`, and `i = 256` corrected in both docstrings. **Still open:** `_scan_prime` should call `to_p(x)` too, for the same reason.
8. Add `assert r == n` and a residual test on the augmented column in `solve_weight`, the two lines standing between a corrupted cache and a plausible-looking `B`.

**If a sweep of this shape is ever built again, drop the `[:1]`.** It is what puts 93.5% of the entries out of reach, and it is the one line of the sampling that no increase in the sample size can compensate for.
