# Verifier v74, L62's "it equals $13$ at four primes"

*The brief was cold: it put the sentence to me neutrally and named no verdict. **I ran nothing**, no script, no Sage, no numerics, and I wrote no code. Every number below is read from files already on disk, as text and metadata: stored JSON row dumps, a stored run log, review files, and the pipeline sources. Log: [agent_logs/verify-L62-v74.log](../agent_logs/verify-L62-v74.log).*

## Verdict

**`SUPPORTED`.** The record supports a restricted sampled rank of exactly $13$ at **four** primes near $2^{40}$, and at **two** further primes besides, so the claim as written is true and understates its own evidence. The source is the four stored row dumps [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json), [n5_rows_1099511627917.json](../scripts/runs/n5_rows_1099511627917.json), [n5_rows_1099511627933.json](../scripts/runs/n5_rows_1099511627933.json) and [n5_rows_1099511627953.json](../scripts/runs/n5_rows_1099511627953.json), each written by [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) only behind an assertion that the rank is $13$, together with the independent re-ranking of all four in [REVIEW_r214.md](../reviews/REVIEW_r214.md).

**A standing finding of the record is wrong and should be withdrawn.** [sym3-blocks.md:339](../findings/sym3-blocks.md) and [INDEX-results.md:76](../findings/INDEX-results.md) both carry *"'four primes' is unsupported at five sites, the record names two, and the four near $2^{40}$ belong to the certificate's row lift, a different computation at a different scale."* The four *are* the row-lift primes; the rows they lift *are* the $40\times47$ restricted sampled matrix whose rank is the quantity in dispute; and the rank at each of them is asserted by the producing run and recomputed by a reviewer with his own code. This agrees with [v64](VERIFY_v64.md), [v65](VERIFY_v65.md), [v66](VERIFY_v66.md) and with §9.1 of [REVIEW_r688.md](../reviews/REVIEW_r688.md), reached here from the artifacts rather than from those reports.

## 1. Which primes, and what each one rests on

| Prime | Bits | What was computed | Where it is recorded | Re-checked by |
| --- | --- | --- | --- | --- |
| $1099511627873$ | $41$ | restricted sampled rank $13$ at the $40$ points | [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json) | [r214](../reviews/REVIEW_r214.md), [r211](../reviews/REVIEW_r211.md) |
| $1099511627917$ | $41$ | same | [n5_rows_1099511627917.json](../scripts/runs/n5_rows_1099511627917.json) | [r214](../reviews/REVIEW_r214.md), [r211](../reviews/REVIEW_r211.md) |
| $1099511627933$ | $41$ | same | [n5_rows_1099511627933.json](../scripts/runs/n5_rows_1099511627933.json) | [r214](../reviews/REVIEW_r214.md), [r211](../reviews/REVIEW_r211.md) |
| $1099511627953$ | $41$ | same, and the run's own printout survives | [n5_rows_1099511627953.json](../scripts/runs/n5_rows_1099511627953.json), [assemble_p4.log:127](../scripts/reviewers/r211/assemble_p4.log) | [r214](../reviews/REVIEW_r214.md) |
| $1000033$ | $20$ | same; the pipeline default | [run_n5_assemble.py:97](../scripts/runs/run_n5_assemble.py), quoted at [sym3-blocks.md:225](../findings/sym3-blocks.md) | the shipped run logs |
| $1000003$ | $20$ | same, on reviewer 209's own code and own points, $T$ rebuilt from three positions | [REVIEW_r209.md](../reviews/REVIEW_r209.md), quoted at [sym3-blocks.md:225](../findings/sym3-blocks.md) |, |

**So the count on the record is six, and "four" names the four with stored matrices.** The two small primes are quoted in prose; the four large ones are the only ones whose sampled matrix a reader can open.

## 2. Why the four dumps are the restricted matrix, and not the lift's

Three facts from the source settle the substitution the standing finding makes.

- **The dumped rows are the matrix whose rank is asserted.** [run_n5_assemble.py:1229](../scripts/runs/run_n5_assemble.py) sets `AUG = [RROWS[t] + [RHS[t]] ...]`, line 1232 takes `rk_A = rank_mod_p([r[:-1] for r in AUG])` (which is `RROWS`), line 1235 is `assert rk_A == 13`, and the dump of `{"prime": PRIME, "rows": RROWS, ...}` follows at line 1260. **A dump exists at a prime only because the rank-$13$ assertion passed at that prime.** Line 1268 then recomputes the same rank as `rr` and asserts `rr <= 13` against the derived cap.
- **The prime is the run's, not a post-hoc label.** [run_n5_assemble.py:97](../scripts/runs/run_n5_assemble.py) reads `PRIME = int(os.environ.get("N5_PRIME", "1000033"))`, and the filename is built as `n5_rows_{PRIME}.json`. Four filenames, four runs.
- **The shape is the restricted one.** Each dump carries `"blocks"` of $16$ entries and `"shape"` $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$, summing to the $25$ multiplicities with $\sum m^2=47$; the first row has $47$ entries and the row separators count $40$ rows. That is the $40\times47$ restricted Hermitian system, matching the `assert len(RROWS[0]) == 47` at line 1266.

**The lift is a second consumer of the same files.** [run_n5_lift.py:22](../scripts/runs/run_n5_lift.py) globs `n5_rows_*.json` and CRT-reconstructs across them. Two computations on one set of dumps is why the phrase looked migrated; it did not migrate.

## 3. Independent re-ranking

- **[r214](../reviews/REVIEW_r214.md) re-ranked all four with its own elimination.** Its verdict table reads *"`rank(A)` mod each of the four primes | my own Gaussian elimination over F_p, self-tested on planted ranks 0,1,5,13,14,20 | 13, 13, 13, 13"*, with `rank([A|F_5])` the same. The code is [rank_modp.py](../scripts/reviewers/r214/rank_modp.py), whose header states the governing inequality, `rank_{F_p}(A mod p) <= rank_Q(A)`, *"so attaining 13 mod p gives rank_Q(A) >= 13 with no trust in the CRT lift at all"*, and which globs the dumps rather than re-deriving them.
- **[r211](../reviews/REVIEW_r211.md) went further and computed the rank over $\mathbb Q$.** [check_exact_rank.py](../scripts/reviewers/r211/check_exact_rank.py) does exact Gaussian elimination on `Fraction`s of the lifted matrix: *"`rank_Q(A) = 13`, matching the mod-p rank at three primes; `rank_Q([A | F_5]) = 13`, so the system is consistent over Q, exactly, not mod p"*, with perturbation controls that raise the rank to $14$. This is a **stronger** statement than the claim makes, and the claim quotes the weaker one, the point [r687:127](../reviews/REVIEW_r687.md) already made.
- **The residue-to-rational hypothesis is argued, once, and outside the block.** The mod-$p$ bound needs the sampled matrix to be the reduction of a rational one; [r209](../reviews/REVIEW_r209.md) supplies that for the restriction step (*"the pivot $u_k$ is nonzero mod $p$ by construction … so `rank_p(restricted) <= rank_Q(restricted) <= 13` holds"*). No written form of L62 states it.

## 4. What the second, third and fourth prime add, redundancy, not breadth

**Plainly: redundancy.** The four runs share the sample, the code and the construction, and the mathematics is closed by the first.

- **One prime already closes the squeeze.** $\operatorname{rank}_{\mathbb F_p}(A\bmod p)\le\operatorname{rank}_{\mathbb Q}(A)\le\operatorname{rank}\mu_K\le13$, the last step being the order-one vanishing at $W_0$. A single prime attaining $13$ forces every inequality to equality. A second prime cannot strengthen an equality.
- **The four are four reductions of one rational matrix.** [run_n5_assemble.py:1246](../scripts/runs/run_n5_assemble.py) says so where it dumps: *"The sample points are regenerated identically from the fixed seed at every prime, so the rows correspond entry for entry."* Same $40$ points, same $47$ columns, same block order.
- **What repetition does buy is a guard against arithmetic accident and coding error**, not against the theorem being false, and the accident it guards is the one direction the cap already excludes. It is also the lift's actual requirement: $123$ bits of modulus, per [run_n5_lift.py:8](../scripts/runs/run_n5_lift.py), which is why four exist at all.
- **The genuine breadth lies elsewhere and is not what "four primes" names.** [r209](../reviews/REVIEW_r209.md) at $p=1000003$ used its own code, its own points and $T$ rebuilt from three positions, and $1000003\equiv3\bmod4$, so $\mathbb F_p[i]$ is a field rather than a split algebra, exercising a different arithmetic path. [r214](../reviews/REVIEW_r214.md)'s elimination is independent of the pipeline's. **Two independent code paths is the breadth; four moduli is the redundancy.** The claim advertises the redundancy and leaves the breadth unmentioned.
- **The known blind spot is untouched by any number of primes.** [r209:63](../reviews/REVIEW_r209.md) records that *"a defect that lands the rank exactly ON the cap is invisible"*, both caps come from theory, so the run has no independent oracle for the number it prints. Four primes reproduce the same blind spot four times.

## 5. Where the claim is cited, and whether any site names a prime

| Site | Form | Names a prime |
| --- | --- | --- |
| [results.md:631](../results.md) | *"it equals $13$ at four primes"* | no |
| [results.md:206](../results.md) | *"a sampled rank attaining $13$ at four primes"* | no |
| [sym3-blocks.md:346](../findings/sym3-blocks.md) | *"It attains it, at four primes."* | no |
| [sym3-blocks.md:221](../findings/sym3-blocks.md) | *"$\operatorname{rank}(\mathrm{ev}\circ\mu)=13=\operatorname{rank}\mu$ is measured at four primes"* | no |
| [report/sections/07-gradedness-split.tex:905](../report/sections/07-gradedness-split.tex) | verbatim restatement | no |
| [report/sections/09-status.tex:13](../report/sections/09-status.tex) | *"Equality rests on one sampled mod-$p$ rank, at four primes"* | no |

**No citing site names any of the four.** Two nearby lines name primes and neither is a citation of this claim: [sym3-blocks.md:225](../findings/sym3-blocks.md) names $1000033$ and $1000003$ for a *different* sentence about the same rank, and [report/sections/07-gradedness-split.tex:887](../report/sections/07-gradedness-split.tex) names *"four primes near $2^{40}$"* for the CRT lift. **That coincidence of wording, in the same LaTeX file eighteen lines apart, is the whole origin of the "different computation" objection**, and the two sentences are about the same four files.

## 6. The strongest reading the words support

**"A sampled rank equal to $13$ forces equality; it equals $13$ at four primes"** is true under its own subject: *it* is the sampled rank, the rank of the $40\times47$ restricted evaluation matrix, and that is measured at four primes with the matrices on disk, at two more in prose, and exactly over $\mathbb Q$ once. **What "four primes" cannot reach is $\operatorname{rank}\mu_K$ itself**, which no prime measures, the squeeze reaches it, through the cap. The count is sound; the plural is decoration; and the load-bearing companion to the measurement is the theorem, not the repetition.

## What would change this verdict

- A demonstration that the four dumps do not reduce a single rational matrix at the recorded $40$ points, for instance a block-order drift between dumps, of the kind [r211](../reviews/REVIEW_r211.md) and [r212](../reviews/REVIEW_r212.md) caught once already. The dumps' identical `blocks` and `shape` fields argue against it.
- A defect in the multi-probe Schur guard of stage 3, which [r209](../reviews/REVIEW_r209.md) shows is what licenses `sampled rank <= rank(mu)` at all. That would cost the value $13$ at all six primes together, not at four of them.

## Repairs owed to the record

1. **Withdraw the "unsupported" finding** at [sym3-blocks.md:339](../findings/sym3-blocks.md) and [INDEX-results.md:76](../findings/INDEX-results.md), replacing it with the count of six and the two named sources.
2. **Name the primes at one canonical site**, so that no reader has to reconstruct the set from filenames.
3. **Quote the exact result instead of the modular one**, [r211](../reviews/REVIEW_r211.md)'s $\operatorname{rank}_{\mathbb Q}(A)=13$ is stronger than any number of primes and is already on file.
