# Verifier v73, L62's "it equals $13$ at four primes"

**Cold brief, nothing run.** I was given the claim without the round's history and without the standing verdict against it. **I executed no script, no Sage and no numerics, and I wrote none**; every rank, prime and dimension below is read from a file on disk, source text, a stored run transcript, or a review. The one machine action of this task was `python3 -c` printing the top-level JSON keys of the four row dumps, to learn that they carry `prime`, `rows`, `rhs`, `blocks` and `shape`; no mathematics was computed from them. Log: [agent_logs/verify-L62-v73.log](../agent_logs/verify-L62-v73.log).

## Verdict

**`SUPPORTED`**, and the record understates its own evidence. The restricted sampled rank is recorded as $13$ at **six** primes, of which four are the primes near $2^{40}$ whose row dumps sit in [scripts/runs/](../scripts/runs/). The source that settles the four is [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py), where the rank assertion precedes the dump in the same block, corroborated by [REVIEW_r214.md](../reviews/REVIEW_r214.md)'s independent re-ranking of all four dumps and by a stored pipeline transcript, [assemble_p4.log](../scripts/reviewers/r211/assemble_p4.log), that prints the rank at the fourth prime in words.

**The standing objection is wrong and should be withdrawn.** [findings/sym3-blocks.md:339](../findings/sym3-blocks.md) and [findings/INDEX-results.md:76](../findings/INDEX-results.md) both carry *"'FOUR PRIMES' IS UNSUPPORTED, AT FIVE SITES"* from [r633](../reviews/REVIEW_r633.md) and [r634](../reviews/REVIEW_r634.md), on the ground that the four primes near $2^{40}$ *"belong to the certificate's row lift, a different computation at a different scale"*. The lift and the rank are **one matrix**: the lift's inputs are the four dumps, and each dump *is* the $40\times47$ restricted sampled matrix at its prime.

**What the claim does not support, and no citing site says.** The four are one $40$-point sample reduced four ways under one fixed seed. The plural is redundancy against an unlucky reduction, not breadth.

## 1. Which primes, and which computation

| prime | file or record | who computed it | what was computed |
|---|---|---|---|
| $1000033$ | default at [run_n5_assemble.py:97](../scripts/runs/run_n5_assemble.py), quoted at [sym3-blocks.md:225](../findings/sym3-blocks.md) | the pipeline | restricted sampled rank $13$ at $40$ points |
| $1000003$ | [ranks.py](../scripts/reviewers/r209/ranks.py), [REVIEW_r209.md](../reviews/REVIEW_r209.md) | reviewer 209 | rank $13$, own prime, own points, own elimination, own restriction |
| $1099511627873$ | [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json) | the pipeline, then [rank_modp.py](../scripts/reviewers/r214/rank_modp.py) | rank $13$ |
| $1099511627917$ | [n5_rows_1099511627917.json](../scripts/runs/n5_rows_1099511627917.json) | the pipeline, then [rank_modp.py](../scripts/reviewers/r214/rank_modp.py) | rank $13$ |
| $1099511627933$ | [n5_rows_1099511627933.json](../scripts/runs/n5_rows_1099511627933.json) | the pipeline, then [rank_modp.py](../scripts/reviewers/r214/rank_modp.py) | rank $13$ |
| $1099511627953$ | [n5_rows_1099511627953.json](../scripts/runs/n5_rows_1099511627953.json) and [assemble_p4.log](../scripts/reviewers/r211/assemble_p4.log) | the pipeline, then [rank_modp.py](../scripts/reviewers/r214/rank_modp.py) | rank $13$ |
|, | [check_exact_rank.py](../scripts/reviewers/r211/check_exact_rank.py), [REVIEW_r211.md:49](../reviews/REVIEW_r211.md) | reviewer 211 | $\mathop{\mathrm{rank}}_{\mathbb Q}(A)=13$ **exactly over $\mathbb Q$**, from three of the four |

All four moduli sit just above $2^{40}=1099511627776$; the four dumps carry an identical `rhs` vector and identical `blocks` and `shape`, so they are four reductions of one rational system, not four systems.

## 2. Why the four dumps are themselves the evidence

The decisive reading is the order of two statements inside one block of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py). At line 1235 the run asserts the rank; at line 1248 it opens the dump file:

```
assert rk_A == 13, f"the restricted rank is {rk_A} here, not 13"
...
_out = os.path.join(d, f"n5_rows_{PRIME}.json")
```

and `PRIME` is `int(os.environ.get("N5_PRIME", "1000033"))` at line 97. **A row dump exists at a prime only if the rank-$13$ assertion passed at that prime.** Four dumps exist. Nineteen lines further on the same run recomputes the same quantity under its own name and guards it against the cap:

```
print(f"\n  RESTRICTED sampled rank at {len(RROWS)} points, mod {PRIME}: {rr}")
assert rr <= 13, (...)
```

That print is preserved verbatim for the fourth prime in [assemble_p4.log](../scripts/reviewers/r211/assemble_p4.log): *"RESTRICTED sampled rank at 40 points, mod 1099511627953: 13"*, immediately under *"rank(A) = 13, rank([A|F_5]) = 13"* and *"rows dumped to n5_rows_1099511627953.json"*. So the fourth prime's rank is on the record in prose, not only by inference from the dump's existence.

**The matrix is the right one.** Each dump holds $40$ rows of $47$ columns over the $16$-block restricted shape `[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]`, and [REVIEW_r214.md:31](../reviews/REVIEW_r214.md) checks that the $47$ columns of the sampled matrix and the $47$ coordinates of the Gram parametrisation are the same space, so the quantity ranked is $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu_K)$, the very number L62 squeezes against its cap.

**An independent re-ranking exists.** [REVIEW_r214.md:21–22](../reviews/REVIEW_r214.md) tabulates `rank(A)` and `rank([A | F_5])` *"mod each of the four primes"* as $13,13,13,13$ and $13,13,13,13$, by a reviewer's own Gaussian elimination over $\mathbb F_p$, self-tested first on planted ranks $0,1,5,13,14,20$. That code reads the dumps and shares no elimination routine with the pipeline.

**And a stronger result than any of them.** [REVIEW_r211.md:49](../reviews/REVIEW_r211.md) records $\mathop{\mathrm{rank}}_{\mathbb Q}(A)=13$ decided exactly over $\mathbb Q$, with two controls that fail, adding $1$ to a single entry raises the exact rank to $14$, and replacing one entry by $7/13$ raises it to $14$. **A single exact rational rank of $13$ subsumes every mod-$p$ rank in the table**, and no citing site quotes it.

## 3. Where the phrase "four" came from, and one stale docstring

[REVIEW_r211.md:12](../reviews/REVIEW_r211.md) reviewed *three* primes and marked its bit-count row *"PENDING (fourth prime in flight)"*; [check_lift_arithmetic.py](../scripts/reviewers/r211/check_lift_arithmetic.py) filters `1099511627953` out with the comment *"only the three under review"*. The fourth landed and the count moved from three to four, [sym3-blocks.md:202](../findings/sym3-blocks.md) says *"lifted from **four** primes near $2^{40}$, $164$ bits"* ($4\times41$), against the earlier $123$ bits ($3\times41$).

**A minor defect falls out of this.** [run_n5_lift.py](../scripts/runs/run_n5_lift.py) was never updated: its docstring still opens *"Three primes near $2^{40}$, 123 bits together"*, and two of its own messages still read *"The mod-p rank is 13 at three primes"* and *"rank 13 both with and without $F_5$, at three primes"*, while the script globs every `n5_rows_*.json` on disk and therefore now consumes four. The prose in the file disagrees with the file's own behaviour.

## 4. What a second, third or fourth prime adds, redundancy, not breadth

**Nothing mathematical.** The direction of every inequality in play is one-way: $\mathop{\mathrm{rank}}_{\mathbb F_p}(A\bmod p)\le\mathop{\mathrm{rank}}_{\mathbb Q}(A)\le\mathop{\mathrm{rank}}\mu_K\le13$, the last step being the cap proved separately by order-one vanishing at $W_0$. **A single prime returning $13$ already closes the squeeze**, because it forces $\mathop{\mathrm{rank}}_{\mathbb Q}\ge13$ and the cap supplies $\le13$. A second prime returning $13$ adds no new inequality; it repeats one.

**Nor is the repetition independent in the way the phrase suggests.** [run_n5_assemble.py:1245](../scripts/runs/run_n5_assemble.py) states it outright: *"The sample points are regenerated identically from the fixed seed at every prime, so the rows correspond entry for entry."* The four runs share the sample, the construction of $K$, the adapted basis, the restriction and the elimination. What varies is one integer, the modulus.

**So the four are redundancy against exactly one failure mode**: a coincidental rank drop under an unlucky reduction, which cannot happen upward and which the exact rational rank of [r211](../reviews/REVIEW_r211.md) rules out on its own. **They buy no breadth**, and the phrase "at four primes" invites the reading that they do.

**The one genuine breadth on the record is elsewhere and is not what the claim counts.** [r209](../reviews/REVIEW_r209.md) rebuilt the measurement at $1000003$ with its own sample points and its own restriction, taken from the last and the middle admissible position rather than the first, and got $13$ each time; [assemble_r214_freshpoint.py](../scripts/reviewers/r214/assemble_r214_freshpoint.py) re-ran the pipeline at $1099511627873$ against twelve points drawn from a seed the pipeline had never used. Those vary the sample. The four primes do not.

**And the residual risk is untouched by any count.** Both [REVIEW_r209.md:63](../reviews/REVIEW_r209.md) and [REVIEW_r214.md:68](../reviews/REVIEW_r214.md) note that a defect landing the rank exactly *on* the cap is invisible to every test in the pipeline, since the run has no independent oracle for the number it prints. Four primes agreeing at $13$ is four confirmations of the same reading of the same construction.

## 5. Where the claim is cited, and whether any site names a prime

| site | wording | names a prime |
|---|---|---|
| [results.md:206](../results.md) | *"a sampled rank attaining $13$ at four primes forces equality"* | no |
| [results.md:631](../results.md) | *"it equals $13$ at four primes"* | no |
| [findings/sym3-blocks.md:346](../findings/sym3-blocks.md) | *"It attains it, at four primes."* | no |
| [findings/sym3-blocks.md:221](../findings/sym3-blocks.md) | *"$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes"* | no |
| [report/sections/07-gradedness-split.tex:905](../report/sections/07-gradedness-split.tex) | *"It attains it, at four primes."* | no |
| [report/sections/09-status.tex:13](../report/sections/09-status.tex) | *"Equality rests on one sampled mod-$p$ rank, at four primes"* | no |

**Six citing sites, and not one names a prime.** The nearest any file comes is [sym3-blocks.md:202](../findings/sym3-blocks.md), which names the scale (*"four primes near $2^{40}$"*) for the *rows*, in the lift table rather than in L62's block.

**The only site in the record that names primes names a different pair.** [sym3-blocks.md:225](../findings/sym3-blocks.md) reads *"$13$ at $40$ points mod $1000033$, and reviewer 209 reproduced it independently at $p=1000003$"*, two primes, $121$ lines above the block that says four. [sym3-blocks.md:138](../findings/sym3-blocks.md) compounds it, referring to *"[L62]'s two primes and independent code path"*. **Three counts of the same evidence coexist in one file: two, four, and (at line 202, for the rows) four near $2^{40}$**, and the pair at line 225 is disjoint from the four at line 202.

## 6. Concurrence with the round, and what is owed

[ROUND_L62.md:34](ROUND_L62.md) already carries this as **D6**, with ticks from all three verifiers, [v64](VERIFY_v64.md), [v65](VERIFY_v65.md), [v66](VERIFY_v66.md), and the same reading I reached cold: *"the standing objection is too strong … the real defect is that no citing site names one, and the plural buys nothing"*. I reached it from [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py)'s assert-before-dump ordering before reading any of the three, so this is concurrence rather than inheritance.

**What is owed, in order of value:**

1. **Withdraw the standing verdict.** *"'FOUR PRIMES' IS UNSUPPORTED"* stands live at [findings/sym3-blocks.md:339](../findings/sym3-blocks.md) and [findings/INDEX-results.md:76](../findings/INDEX-results.md), refuted by four readers and unrepaired.
2. **Quote the exact rank instead.** $\mathop{\mathrm{rank}}_{\mathbb Q}(A)=13$ from [r211](../reviews/REVIEW_r211.md) is strictly stronger than any mod-$p$ count and appears at no citing site.
3. **Name the primes once, and say the four are one sample reduced four ways.** The plural currently reads as breadth and is redundancy.
4. **Fix [run_n5_lift.py](../scripts/runs/run_n5_lift.py)'s docstring**, which still says three primes and $123$ bits while the script consumes four.
