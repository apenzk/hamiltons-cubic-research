# Gate 2 review 197, the mod-p switch is one-sided in the wrong direction for two asserts, and the probe range sees 3 of 2362 witnesses

Scope: [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) and [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py), read at 442373b and re-read at 9467c6c, priority as briefed, claim 1 first, then claim 3, then 2 and 4. Scripts under [scripts/reviewers/r197/](../scripts/reviewers/r197/), logs in [agent_logs/gate2_197.log](../agent_logs/gate2_197.log). Everything below is exact: integer arithmetic on the cached Gaussian rationals, and exact linear algebra over F_p at two primes. No floating point enters any verdict. The audits load [n5_adapted.pkl](../scripts/runs/n5_adapted.pkl) with pickle directly and never write it back.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1a | "a screen that is wrong mod p is wrong over Q too" justifies the switch | **REFUTED AS STATED.** The implication runs one way: nonzero mod p forces nonzero over Q, and zero mod p forces nothing. Two of the five asserts (`cross == 0` and `dis == 0`), pass on VANISHING, so for exactly those two a mod-p zero is the weaker statement and a false zero is a false PASS. The slogan is true of the failure direction and it is the pass direction the certificate needs |
| 1b | can a quantity that is zero mod p be nonzero over Q, here | **YES, WITH A LIVE WITNESS IN THE SHIPPED CACHE.** Of 1,652,972 coefficients in the adapted basis, one is a nonzero rational that reduces to 0: lambda = (6,4), copy 0, position 787, monomial 56, real part 701361681334272000 = 2^24 · 3^6 · 5^3 · 7 · **65537**. The prime divides the data because it is 2^16 + 1 and the data is built from powers of two |
| 1c | `to_p` on a denominator divisible by 65537 | **SILENTLY RETURNS THE WRONG ANSWER.** `pow(0, p-2, p)` is 0 in Python, so every rational with p in its denominator maps to 0, the reduction of a pole, invented rather than computed, with no exception and no assert. Currently unreachable: the largest denominator anywhere in the cache is **144**, and no denominator divides 65537. The hazard is latent, not active |
| 1d | the one place a false zero becomes a vacuous pass | **`if not q: continue` in the probe loop.** A probe whose norm reduces to 0 is dropped with no counter, no print and no assert, so `dis == 0` can hold because nothing was compared. Measured: 0 of 36 probes are skipped today, at both primes |
| 1e | do the mod-p verdicts survive a second prime | **YES.** Recomputed at p = 1000033 with i = 649529: no singular block, dis = 0, no skipped probe, identical to p = 65537. The present pass is not a mod-p artefact |
| 3a | probes 1..3 have nonzero q and sit at different weights from probe 0 | **CONFIRMED, both parts.** All 36 probe norms are nonzero mod p, and in every one of the 12 blocks with m > 1 the positions t = 0,1,2,3 carry **four distinct weights**. Probes 1..3 do not repeat probe 0's blindness: a transposition at positions (3,4) raises dis to 2, 5 and 3 on lambda = (2,1), (3,2), (4,3), where probe 0 alone gives 0 |
| 3b | the multi-probe check is adequate to the failure it exists to catch | **REFUTED.** The failure class is a per-copy word list, whose minimal instance is a same-weight transposition inside one copy. The 12 blocks carry **2362** such transpositions. The shipped range t <= 3 can see **3** of them, and **9 of the 12 blocks have none it can see at all**. A transposition at the earliest same-weight pair passes with dis = 0 in 9 blocks; the same swap, probed over every position, fires in **12 of 12** |
| 2 | the nonsingularity control | **The fake was real and is already repaired.** `[[h00, h00], [h00, h00]]` is the constant `[[1, 1], [1, 1]]` for every block, since h00 = q00/q00 = 1 by construction, so its determinant vanished with no reference to the data and without running `ip3` once. The working tree at 04e93f2 replaces it with a duplicated copy pushed back through the measurement, which is the right control; I confirm independently that it gives det 0 and that all 24 genuine blocks give det != 0 |
| 4 | is the count assert enough for the cache | **NO, and two stronger checks are free.** `n == 7770` is invariant under every corruption preserving cardinality, I exhibit one. The per-block structure is checkable at zero cost and is not checked, and loading the cache skips the independence re-check the file exists to make, then prints `0/0` where a pass would read the same |

---

## Claim 1, what reduction mod p does and does not preserve

### The derivation

Let Z_(p) be the rationals with denominator prime to p and let r: Z_(p)[i] -> F_p be the ring map sending i to 256, which exists because 256^2 = -1 in F_p. Every quantity the screens compute is a polynomial with integer coefficients in the cached data, so r commutes with all of it: `ip3` mod p is exactly r applied to `ip3_exact`, conjugation included, since conjugation is a ring automorphism of Z[i] and r intertwines it with the second embedding.

A ring map has a kernel. That gives one implication and refuses the other:

- **r(x) != 0 implies x != 0.** Sound. Any check that PASSES on non-vanishing is a certificate mod p.
- **r(x) = 0 permits x != 0**, for every x in p·Z_(p)[i]. Unsound. Any check that PASSES on vanishing is a screen, not a certificate.

Sorting the file's asserts by which side they pass on:

| assert | passes on | mod p |
|---|---|---|
| `pow(256, 2, PRIME) == PRIME - 1` | an identity inside F_p | nothing to lift |
| `cross == 0`, Q block-diagonal by weight | **vanishing** | **one-sided the wrong way** |
| `not sing`, det h != 0 on all 24 blocks | **non-vanishing** | **sound**; a false alarm is the only error |
| `det_p(_ctl) == 0`, the coincidence control | vanishing | one-sided, and the control is exact anyway |
| `dis == 0`, h agrees across probes | **vanishing** (equality of residues is vanishing of a difference) | **one-sided the wrong way** |
| `inhom == 0`, weight-homogeneity | a combinatorial predicate on weights | no arithmetic, unaffected |

So the switch is sound for the one assert the file calls its discriminator, `not sing`, and one-sided in the wrong direction for the two vanishing asserts. **The comment states the true implication and needs the false one.** "A screen that is wrong mod p is wrong over Q too" says a mod-p FAILURE is a genuine failure; correct, and it is what makes the screen worth running. What licenses moving on after a pass is the converse.

### How much this costs in practice

The error is per-entry and small. `cross` evaluates **243,970** entries; a single genuinely nonzero entry survives the screen with probability 1/65537, so a real violation of block-diagonality would have to be invisible at 243,970 independent coincidences to pass. As a screen it is strong. As a certificate it is worth exactly one prime, and the file spends no line on saying which of the two it is claiming.

The residual risk is systematic divisibility, and claim 1b shows it is not hypothetical here: the choice p = 2^16 + 1 is arithmetically related to the data, which is built from powers of two, and 65537 duly appears as a factor of a coefficient. A prime with no relation to the construction (a random 62-bit prime), removes the coupling at no cost. Cheaper still, and decisive: **run the two vanishing screens at two primes**, which I did (claim 1e), turning 1/p into 1/p^2 for a second pass over data that already lives in memory.

### The two silent zeros

`to_p` computes `numerator * pow(denominator % p, p-2, p)`. When p divides the denominator the inner term is `pow(0, p-2, p)` = 0, so the whole coefficient becomes 0. The rational has no image in F_p; the function invents one. Python raises nothing, and no assert guards it. [audit.py](../scripts/reviewers/r197/audit.py) reports the fact and its current reach: 0 of 1,652,972 coefficients have p in the denominator, and the largest denominator in the entire cache is 144, so no input reachable from this pickle can trigger it. One line, `assert x[0].denominator % PRIME and x[1].denominator % PRIME`, closes it permanently.

`if not cap: continue` inside `ip3` drops a coefficient whose reduction is 0, which is arithmetically the same as adding zero and costs nothing.

`if not q: continue` inside the probe loop is different in kind: it drops an entire probe. Its consequence is not a wrong number but an absent comparison, and the `dis == 0` assert cannot tell an agreement from a probe that was never run. This is the only place in the file where a false zero converts directly into a vacuous pass, and it is the only one of the three with no counter attached. **Counting the skips and asserting the count is 0 is one line and makes `dis == 0` mean what it says.**

### The premise behind "exactness only at the final PSD verification"

The sentence carries two claims and only one of them is about arithmetic. Exactness at the end repairs *wrong arithmetic on the right objects*. It repairs *wrong objects* only if the final verification is over-determined against F_5, more independent sample equations than unknowns, so a corrupted adapted basis cannot be absorbed into G. The file's own docstring records the condition, in 194's form: the consistency test rank(A) = rank[A | F_5] is vacuous at 14 samples and carries content only above 15. **So the mod-p switch upstream is licensed by the over-determination downstream, and the two must be stated together.** Neither the assemble file nor the plan's stage-5 row does.

---

## Claim 3, the probes differ from probe 0, and they still miss almost everything

### What the check can and cannot detect, derived

Write R_i[t] = X_t u_i, where X_t is the composite lowering operator of the fixed word t and u_i is copy i's highest-weight vector. `replay` applies the SAME X_t to every copy, so by equivariance of the Hermitian form on the isotypic component,

    <R_i[t], R_j[t]> = h_ij · Q_tt   for every t,

with h independent of t. The ratio against copy 0 therefore reproduces h at every probe **for any word list whatever**, which is why `dis == 0` holds unconditionally on correctly-built data and why it is not evidence about the word list on its own. What it detects is the construction breaking: if copy i were replayed with its own list X_t^(i), the pairing at t becomes <X_t^(0) u_0, X_t^(i) u_i>, which is not h_0i Q_tt.

Two consequences fix the scope exactly:

1. **t = 0 is blind**, since the empty word makes X_0 the identity for every list, 195's finding.
2. **The minimal per-copy divergence is a same-weight transposition.** A divergence that changes the WEIGHT of a position pairs vectors of different weights, and `ip3` returns 0 across weights, so it is caught wherever it lands. What survives is a permutation of positions carrying the same weight, the only divergence that keeps every pairing in a nonzero block. A transposition of positions (t1, t2) is visible to a probe range R iff t1 is in R, because weight-distinctness at 0..3 forbids t2 in R with t1 outside it.

### The measurement

[audit2.py](../scripts/reviewers/r197/audit2.py) answers the brief's two questions directly. All 36 probes have q != 0 mod p, and the weights at t = 0,1,2,3 are four distinct weights in all 12 blocks with m > 1, so the probes are not repeats of probe 0, and swapping the pair (3,4) inside copy 1 raises dis to 2, 5, 3 on lambda = (2,1), (3,2), (4,3) where probe 0 alone reports 0. **The check has content.**

It has very little. Counting the same-weight position pairs per block:

| lambda | m | dim | same-weight pairs | pairs with t1 <= 3 | earliest pair | dis after swapping it |
|---|---|---|---|---|---|---|
| (2,0) | 2 | 14 | 1 | 0 | (6,7) | 0 |
| (2,1) | 2 | 35 | 19 | 1 | (3,4) | 2 |
| (2,2) | 4 | 35 | 11 | 0 | (4,5) | 0 |
| (3,0) | 2 | 30 | 5 | 0 | (8,9) | 0 |
| (3,1) | 2 | 81 | 78 | 0 | (4,5) | 0 |
| (3,2) | 3 | 105 | 114 | 1 | (3,4) | 5 |
| (4,0) | 2 | 55 | 15 | 0 | (9,10) | 0 |
| (4,1) | 2 | 154 | 211 | 0 | (4,5) | 0 |
| (4,2) | 4 | 220 | 404 | 0 | (4,5) | 0 |
| (4,3) | 2 | 231 | 373 | 1 | (3,4) | 3 |
| (4,4) | 2 | 165 | 130 | 0 | (4,5) | 0 |
| (5,2) | 2 | 390 | 1001 | 0 | (4,5) | 0 |
| **total** | | | **2362** | **3** | | |

**The shipped range sees 3 of 2362 witnesses, and 9 of 12 blocks contain none it can see.** The blindness 195 exposed at probe 0 is narrowed by a factor of 2362/2359, not removed. The reason is structural rather than accidental: the BFS in `word_list` reaches each new weight before it revisits one, so the first few positions are precisely the positions whose weights are unrepeated, exactly the positions where a same-weight transposition cannot exist.

### The repair, costed

[audit4.py](../scripts/reviewers/r197/audit4.py) runs the identical loop over every position instead of t <= 3.

On clean data every position agrees (dis = 0, no probe skipped, at both primes) so widening the range costs no false alarm. On data carrying the earliest same-weight transposition inside copy 1 it fires in **12 of 12 blocks**, against 3 of 12 for t <= 3:

| lambda | dim | clean dis, all t | swapped pair | dis, t <= 3 | dis, all t |
|---|---|---|---|---|---|
| (2,0) | 14 | 0 | (6,7) | 0 | 4 |
| (2,1) | 35 | 0 | (3,4) | 2 | 4 |
| (2,2) | 35 | 0 | (4,5) | 0 | 14 |
| (3,0) | 30 | 0 | (8,9) | 0 | 6 |
| (3,1) | 81 | 0 | (4,5) | 0 | 6 |
| (3,2) | 105 | 0 | (3,4) | 5 | 10 |
| (4,0) | 55 | 0 | (9,10) | 0 | 6 |
| (4,1) | 154 | 0 | (4,5) | 0 | 6 |
| (4,2) | 220 | 0 | (4,5) | 0 | 12 |
| (4,3) | 231 | 0 | (3,4) | 3 | 6 |
| (4,4) | 165 | 0 | (4,5) | 0 | 6 |
| (5,2) | 390 | 0 | (4,5) | 0 | 6 |

The whole table, the clean full-range sweep, plus a second full-range sweep and a t <= 3 sweep on transposed data for every block, takes **78 seconds**, so the clean sweep alone is well under a minute. That is with `ip3` reduced through H mod p and the per-vector reductions memoised; the shipped `ip3` recomputes `sym3_ip` from Fractions and reduces every coefficient afresh on every call, and the same two memoisations apply to it.

Cheaper than the full sweep, and sufficient by the derivation above: probe **one position from each weight that occurs more than once**. That is 12 to 60 extra probes per block instead of 3, and by construction it makes every same-weight transposition detectable.

**And the control belongs in the file.** The transposition is four lines (swap two same-weight positions inside copy 1, rebuild h, rerun the loop, assert dis > 0) and it is what turns `dis == 0` from a theorem about equivariance into a measurement. As shipped, `assert dis == 0` has no accompanying evidence that dis can be nonzero at all.

---

## Claim 2, the control was fake, and the repair landed before this review was filed

`row[0][0]` is `ip3(u_0, u_0) * inv(q00)` = 1 by construction in every block with m > 1, and `[[1]]` in the rest, so `_ctl = [[HMAT[l][0][0]] * 2] * 2` was the constant matrix `[[1, 1], [1, 1]]` for any data whatever. Its determinant vanished because a 2x2 matrix of equal entries has rank 1, with no reference to coincidence and without calling `ip3` once. It exercised one proposition (that `det_p` returns 0 on a singular input) and none of the propositions the assert's message claims.

Two further defects in the same three lines, both now gone from the working tree:

- The bare name `l` at that line lives only in the comprehension scopes at lines 155 and 243, which do not leak in Python 3, so the line raised `NameError: name 'l' is not defined`. **The control assert, the multi-probe assert and the homogeneity assert were all unreachable**, the second instance of exactly the defect 18c15f3 repaired for `det_p` twenty-seven lines earlier. Reproduced in [ctl_nameerror.py](../scripts/reviewers/r197/ctl_nameerror.py), which reads both statements out of git at 442373b and executes them, so what runs is what shipped.
- The measurement-based control that replaces it (duplicate copy 0, push it through `ip3` and `det_p`), is the right one. Independently, on the current cache: h with copy 0 duplicated is `[[1, 1], [1, 1]]` with det 0, a linearly dependent list gives det 0, and all 24 genuine blocks give det != 0, so the control fails what the data passes. Confirmed.

One gap remains. The control covers the coincident pair; the comment also claims a **dependent triple** as a degeneracy the shipped checks miss, and nothing exercises that path. It costs one more `_dup`, and I confirm it does vanish, so the assert would hold.

---

## Claim 4, the count assert, and the check the cache load skips

`assert n == 7770` pins cardinality and nothing else. Three things it does not see, in increasing order of seriousness:

1. **Structure is free and unchecked.** Every copy must have exactly dimB2(lambda) vectors and every block its own multiplicity. The current cache satisfies both (measured, all 24 blocks) and asserting them costs one comprehension. A cache with the right total and a wrong split passes today.
2. **Provenance is not recorded.** The pickle carries no hash of [n5_hw_cache.json](../scripts/runs/n5_hw_cache.json), no hash of [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py), no record of the weight basis its coordinates are expressed in. This is a live coupling and not a hypothetical one: [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) rebuilds H from the *current* json while ADAPTED comes from the *stored* pickle, so a change to WBASIS or to its ordering puts the Gram and the adapted vectors in different coordinate systems, with every downstream screen computed on mismatched data and the count still 7770. A superseded run is exactly the case the brief names, and a stored SHA-256 of the json plus the source rules it out in two lines.
3. **Loading the cache skips the check the file exists to make.** The independence re-check (replay every copy, reduce, require rank = dim), sits inside `if ADAPTED is None:`, so it runs only on a rebuild. After a cache load `ok = bad = 0` and the file prints `blocks with a shared word list spanning every copy: 0/0`, which reads as a pass and is a count of nothing. **This is the check 182's finding put there**, and the cache turns it off. It is also the cheapest of the three to restore, because the reduction runs on data already in memory.

I verify two facts that limit how bad the current state is: every block's position 0 carries weight exactly lambda, and all 7770 vectors are weight-homogeneous under the *current* WT, so the shipped pickle and the shipped json are in the same coordinate system today. Neither fact is asserted anywhere; the second is the `inhom` assert, which until 04e93f2 was unreachable.

---

## What ships with a control, against the standard

| assert | control shipped | is the control real |
|---|---|---|
| `cross == 0` | **none** |, . A positive control is one line and I ran it: the same-weight off-diagonal entries, same code path, come out nonzero 11 of 11, 67 of 67 and 119 of 119 on lambda = (2,2), (3,2), (4,2), so the counter demonstrably can increment |
| `not sing` | yes, `_ctl` | **now yes**, duplicate a copy, measure through `ip3`. Until 04e93f2 it was a constant matrix of ones that never ran |
| `dis == 0` | **none** |, . 195's transposition is described in the comment and absent from the file. Supplied here, and it shows the shipped probe range catches 3 of 2362 instances |
| `inhom == 0` | **none** |, and none is needed: it is combinatorial and its failure is directly exhibitable |
| cache `n == 7770` | **none** |, . I exhibit a corruption it accepts: replace every vector of block (2,0) copy 1 by copy 0's and the count is still 7770, while the block becomes coincident |

## Scripts

- [audit.py](../scripts/reviewers/r197/audit.py), p-divisibility across all 1,652,972 cached coefficients and all 90 H entries; probe weights, probe norms and same-weight position pairs per block.
- [audit2.py](../scripts/reviewers/r197/audit2.py), locates the coefficient divisible by p; rebuilds h, det h and dis as the file computes them; runs the same-weight transposition control at a probed and an unprobed position for all 12 blocks; runs the coincidence and dependence controls through the measurement; repeats every screen at p = 1000033.
- [audit3.py](../scripts/reviewers/r197/audit3.py), the cross-weight screen's exposure and its missing positive control; the cache's structural invariants and a corruption the count assert accepts.
- [audit4.py](../scripts/reviewers/r197/audit4.py), the full-range probe sweep, clean and transposed, with timings.
- [ctl_nameerror.py](../scripts/reviewers/r197/ctl_nameerror.py), both NameErrors, executed from the shipped text at 442373b, and the constant value of the old control.
