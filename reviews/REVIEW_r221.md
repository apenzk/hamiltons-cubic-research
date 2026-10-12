# Review r221 -- Gate 2, the n=12 covariant construction

Reviewer 221. Adversarial. Commits under review: bd5acb6, bc8b75e, e106cc2 (plus 9f9db90).
File under review: scripts/runs/run_n12_covariants.py, building on scripts/reviewers/r216/c4b_hw.py.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | Certification: nullity_Q >= m_lambda by complete reducibility, rank_p <= rank_Q, so nullity_p = m_lambda pins nullity_Q | **SOUND, but the docstring states the wrong conclusion** -- every step is valid; what the equality actually buys is that the mod-p kernel is the reduction of the rational one, not the value of nullity_Q, which the character already fixed |
| 2 | By-weight basis enumeration produces exactly the lambda weight space, once each | **CORRECT** -- proved from the loop structure and confirmed by exact set equality against two other enumerations on 39 blocks |
| 3 | Nullities recomputed independently agree | **CONFIRMED** -- all 77 multiplicities rebuilt by symmetric functions + Racah, and 42 nullities recomputed at a second prime, 31 of them in exact rational arithmetic; 0 disagreements |
| 4 | "sparse elimination is 20x worse than dense" | **REFUTED.** On the same block, properly-implemented sparse beats dense (28.3 s against 44.2 s at 6,137 columns), and the 1,943 s the dead-end rests on does not reproduce -- I measure 69.6 s for the author's own routine on the author's own matrix, while its neighbours in the same log reproduce within 10%. A live route has been closed on one bad timing |

## Claim 1 -- the certification argument

### The chain, step by step

Write V for the 1638-dimensional so(12) = D6 module, M = (Sym^3 V)_lambda, and A for the stacked matrix of the six simple raising operators E_1..E_6 restricted to M, mapping into the direct sum of the six weight spaces (Sym^3 V)_{lambda+alpha_i}.

**Step A -- nullity_Q >= m_lambda.** Valid, and in fact an equality. The simple root vectors generate n^+, so ker A over Q is exactly the space of singular (highest-weight) vectors of weight lambda in Sym^3 V. Weyl's theorem gives Sym^3 V = direct sum over mu of L(mu)^{m_mu} in char 0, and a singular vector of weight lambda inside L(mu) exists only for mu = lambda, where the space is 1-dimensional. So nullity_Q = m_lambda on the nose. The one-sided form the docstring uses is the weaker true statement, which is all the chain needs, so nothing is lost. It really is complete reducibility that is being used and nothing stronger -- what is needed is that the lambda-isotypic part is a direct summand, not merely a subquotient.

**Step B -- rank_p <= rank_Q.** Valid *provided* the mod-p matrix is the reduction of the rational one, i.e. no denominator of a structure constant is divisible by P = 2^31 - 1. If a k-by-k minor is nonzero mod p it is nonzero over Q, hence rank_p <= rank_Q and nullity_p >= nullity_Q. I checked the hypothesis against the data rather than assuming it: over all 6,714 nonzero entries of D["E"], the set of denominators is exactly {1, 2} and no numerator vanishes mod P. So 2A is integral, P is odd (and prime -- 2^31-1 is Mersenne), and the reduction is faithful. Recorded in [scripts/reviewers/r221/out_denoms.txt](scripts/reviewers/r221/out_denoms.txt).

The failure mode the code would not notice is worth naming because it is one line away: `pow(x.denominator % P, P-2, P)` returns 0 rather than raising when the denominator is divisible by P, so a bad prime would silently zero entries instead of erroring. It does not bite on this data.

**Step C -- the deduction.** m_lambda <= nullity_Q <= nullity_p, and nullity_p is observed equal to m_lambda, so all three coincide. Logically valid.

### What the argument actually certifies

The conclusion as written -- "pins the nullity over Q to m_lambda exactly" -- is a statement about a number that was **already** pinned. m_lambda comes from the character, and Step A alone gives nullity_Q = m_lambda without computing anything. So read literally the certification is vacuous: it proves a theorem that was its own input.

The real content runs the other way, and it is worth more than what is claimed. Let K be the rational kernel, L = K intersect Z_(p)^N, a free Z_(p)-module of rank m_lambda. Its reduction L-bar sits inside ker A_p and has dimension m_lambda. Observing dim ker A_p = m_lambda forces ker A_p = L-bar. **So the computed mod-p kernel is exactly the reduction of the true rational highest-weight space** -- P is a lucky prime for this block, the mod-p basis vectors lift, and rational reconstruction from them is legitimate. That is the statement the downstream construction of explicit covariants needs, and it does require the equality rather than the inequality. I would rewrite the docstring to say this.

### Trying to break it

A case where the chain gives the wrong answer needs one of its premises to fail. Steps B and C are unconditional given a faithful reduction, which I verified. Step A is the attackable one, because it presumes A really is the matrix of the raising operators of a genuine module.

* **If the pickled E operators are not a Lie algebra action**, "nullity_Q >= m_lambda" is not a theorem about them, and nullity_p = m_lambda could hold by coincidence, certifying nothing. This is not hypothetical hand-waving -- D["E"] is a cached artefact and nothing in the run checks it satisfies any relation. Tested below.
* **If m_lambda and the matrix came from a common source**, the check would be circular. They do not: m_lambda is from n12_sym3_blocks.pkl (character/Racah) and A is from the weight-space module.
* **Degenerate perturbations self-report.** Zeroing entries of A can raise rank as easily as lower it, so a corrupted A gives nullity_p != m_lambda and the assert fires. The direction of the guard is right.

So: no case where the chain gives a wrong answer, *conditional on* D["E"] being a genuine raising-operator action. That condition is the load-bearing unchecked one, and claim 3 below is where I test it.

### The unchecked premise, now checked

[scripts/reviewers/r221/c1_ops.py](scripts/reviewers/r221/c1_ops.py) tests the cached D["E"] against three things the run under review never looks at. Output in [scripts/reviewers/r221/out_ops.txt](scripts/reviewers/r221/out_ops.txt).

| Test | Result |
|---|---|
| T1 shape -- E_i takes V_w to V_{w+alpha_i}, column and row counts agree with WDIM | 0 violations |
| T2 Serre relations for n^+ of D6 -- [E_i,E_j]=0 when a_ij=0, ad(E_i)^2 E_j = 0 when a_ij=-1, over **Q** in exact fractions | 0 violations |
| T3 joint kernel of the six E_i on V itself | dimension 1, at weight (2,2,0,0,0,0) |

The Gram matrix of ALPHA is the D6 Cartan matrix exactly. T3 is the sharp one: V has a unique singular line, at the highest weight of the Weyl module W_(2,2), which is the space of Weyl curvature tensors in 12 dimensions -- 12^2(12^2-1)/12 - 78 = 1716 - 78 = 1638, the right number. So V is irreducible with the right highest weight and E is a genuine n^+-action.

**Residual gap, stated honestly.** T2 pins the action of n^+, not of all of so(12); the pickle carries no lowering operators, so from the cached data alone one cannot rule out an n^+-action that fails to extend. Complete reducibility, which Step A needs, is a statement about the *full* so(12) module. The evidence against a spurious action is strong -- correct character (r216 rederived it from symmetric functions with no Lie theory), correct Serre relations, unique singular line at the right weight, and dozens of blocks agreeing with an independently computed multiplicity -- but it is evidence, not a derivation. Storing the six F_i alongside the E_i and checking [E_i,F_j] = delta_ij H_i would close it in an afternoon.

## Claim 2 -- the by-weight basis enumeration

### It is correct, and here is why, not just that

Fix lambda. The target set is S = { (i,j,k) : i <= j <= k, GW[i] + GW[j] + GW[k] = lambda }. The loop runs over ordered pairs of *weights* (a,b) with a <= b in the WTS order, sets c = WRANK[lambda - wa - wb], and discards the pair when c < b.

**Every weight triple is generated exactly once.** A kept (a,b,c) has a <= b from the loop bound and b <= c from the guard. Conversely take any a <= b <= c with wa + wb + wc = lambda. The pair (a,b) is visited, c is determined by subtraction, and c >= b, so it is kept. For uniqueness, ask which of the three pairs drawn from the multiset {u <= v <= w} survive: (u,v) yields c = w and is kept; (u,w) yields c = v and is discarded unless v = w, in which case it *is* the pair (u,v); (v,w) yields c = u and is discarded unless u = w, i.e. u = v = w, again the same pair. So exactly one surviving pair per multiset. The `if c < b: continue` guard is doing precisely this job and it is the right guard -- `c < a` would be wrong, and no guard at all would triple-count.

**Within a weight triple, every index triple once.** OFF is assigned in WTS order, so weight blocks are contiguous and a < b implies every index of block a is below every index of block b. Then `max(ia, OFF[wb])` equals OFF[wb] when a < b (whole block, and ia < ib holds for free) and equals ia when a = b (giving ia <= ib); likewise for the third loop. All four cases -- a<b<c, a=b<c, a<b=c, a=b=c -- come out right from the same two `max` calls, which is why the four-case version in r216's sym3_basis collapses to this one. Distinct weight triples occupy disjoint index ranges, so there is no cross-iteration duplication either.

### Is the assert enough on its own?

**No.** `assert len(B) == S3dim` is a count against the character, and a count cannot separate "one triple missed and one double-counted" from "correct". It is a real check and it would catch most blunders, but it is not sufficient, so I did not rely on it. Note also that a duplicated triple would *not* be caught downstream in a silent way: `idx = {m: j for j, m in enumerate(B)}` keeps only the last occurrence (and is in fact dead -- `idx` is never read in run_n12_covariants.py), while the row-building loop would fill both columns identically, giving a repeated column, unchanged rank and nullity one too high -- a visible mismatch. So duplicates inflate the nullity rather than hiding.

### What I actually ran

[scripts/reviewers/r221/c2_basis.py](scripts/reviewers/r221/c2_basis.py) compares three enumerations **as sets**, so a compensating miss-plus-duplicate cannot pass:

* **A** the author's loop, copied verbatim;
* **B** an independent loop of a different shape -- iterate over basis *indices* ia <= ib and solve for the third weight, rather than over weight *pairs*;
* **C** r216's four-case `cwr` version.

On all 39 blocks with weight space at most 900, output in [scripts/reviewers/r221/out_basis.txt](scripts/reviewers/r221/out_basis.txt):

* set(A) = set(B) = set(C), with no repeats in any of the three (len == len of set);
* every triple is sorted and its three weights sum to lambda, checked element by element;
* the common count equals both the cached character S3[lambda] and the symmetric-function count (h2^2 - h3 h1 - h2, then (p1^3 + 3 p1 p2 + 2 p3)/6), recomputed here from the 12 weights of C^12 with no Lie theory in the path;
* and the symmetric-function weight system CHI is **identical as a dict** to the pickled WDIM, so the module's weight multiplicities are independently confirmed too.

**0 disagreements.** Claim 2 stands.

## Claim 3 -- are the nullities right?

### 3a. The target side: all 77 multiplicities recomputed from scratch

Before recomputing nullities it is worth asking what they are being compared *against*. The run compares `nul` to `BL[lam]` out of n12_sym3_blocks.pkl -- a cached artefact of the author's own Freudenthal/orbit/peel pipeline, i.e. exactly the pipeline that produced a weight system summing to 65 against 1638 earlier in this programme. [scripts/reviewers/r221/c3_mult.py](scripts/reviewers/r221/c3_mult.py) rebuilds it along a route sharing nothing with it:

1. the 12 weights of C^12 under the so(12) Cartan;
2. char Weyl_12 = h2^2 - h3 h1 - h2, symmetric functions only;
3. the **full** weight-multiplicity function of Sym^3 V by (p1^3 + 3 p1 p2 + 2 p3)/6, as an explicit dict -- 25k weights summing to C(1640,3) = 733,813,080, which is checked;
4. Racah: c_lambda = sum over w in W(D6) of sgn(w) m(lambda + rho - w rho), with rho = (5,4,3,2,1,0) and W(D6) the 23,040 evenly-signed permutations, sgn(w) = sgn(sigma) since the flips multiply to +1.

Result, [scripts/reviewers/r221/out_mult.txt](scripts/reviewers/r221/out_mult.txt): **all 77 block multiplicities agree, 0 disagreements, total 191 against cached 191.**

I also asked whether the block *list* is complete, which nothing in the run checks. Sym^3 V carries 122 dominant weights; of these, **every one with nonzero multiplicity is in BL** -- so no covariant is being dropped before the computation starts.

The headline "184 covariants" reconciles with the 191: the 14 multiplicities sitting on weights with lambda_6 != 0 are seven SO(12) chiral pairs, each pair restricting from one O(12) irrep, and 191 - 7 = 184. Consistent.

### 3b. The computed side: nullities recomputed without the prime

[scripts/reviewers/r221/c3_nullity.py](scripts/reviewers/r221/c3_nullity.py) rebuilds the raising-operator matrix from the original Fraction structure constants, using the **independent index-loop enumeration** of claim 2 rather than the author's weight loop, and takes the rank two ways:

* **exact rational Gaussian elimination** -- no reduction anywhere, so this computes nullity_Q directly rather than certifying it;
* **a second prime**, 1,000,003, chosen far from 2^31 - 1, which would expose an unlucky-prime coincidence at P.

Output in [scripts/reviewers/r221/out_nullity.txt](scripts/reviewers/r221/out_nullity.txt): **42 blocks up to 1,222 columns at the second prime (67 multiplicities), of which 31 up to 400 columns also in exact rational arithmetic (40 multiplicities). 0 disagreements** -- every nullity equals m_lambda, which is now itself independently recomputed. The exact-Q runs are the strongest evidence available: they confirm nullity_Q = m_lambda with no lucky-prime hypothesis at all, and they confirm that P = 2^31 - 1 was in fact lucky on those blocks.

## Claim 4 -- "sparse elimination is 20x worse than dense"

### The comparison as made cannot support the conclusion

6,137 columns sparse in 1,943 s against 13,444 columns dense in 103 s. Elimination cost is superlinear in the dimension, so the *smaller* problem taking longer is the only thing the two numbers jointly establish; the ratio 1943/103 is not a method ratio because the problems differ by a factor 2.2 in size. The commit message states the ratio as if it were.

### What the code actually times

Reading `sparse_rank` before running it: it is **not** sparse elimination in the usual sense. Live rows are never updated -- each row is reduced against the accumulated pivots and then becomes a pivot itself, so this is row-echelon-by-insertion with no fill control at all, and the pivot rows fill in unboundedly. Two further costs sit on top:

* `live.sort(key=len)` runs inside the `while` loop, but since live rows are never modified their lengths never change, so every sort after the first re-sorts an already-sorted list -- pure overhead, quadratic in the number of len() calls;
* `c0 = min(r, key=lambda c: (len(r), c))` -- `len(r)` does not depend on `c`, so the key is constant in its first slot and this is just `min(r)`. Harmless, but it signals the pivot rule was meant to do something it does not do.

So what is being compared is a Python-dict echelon insertion against a vectorised numpy elimination, which is a language-and-representation comparison, not a sparse-vs-dense one.

### The fair run

[scripts/reviewers/r221/c4_bench.py](scripts/reviewers/r221/c4_bench.py) builds one matrix per block and hands the **identical** rows to three routines: **S** the author's `sparse_rank` verbatim, **D** r216's dense numpy `rank_modp` verbatim, and **M** a sparse elimination done as normally meant -- Markowitz pivot on (row length - 1) times (column count - 1), with the other live rows actually updated.

Same matrix, three routines, one process, [scripts/reviewers/r221/out_bench.txt](scripts/reviewers/r221/out_bench.txt) and [scripts/reviewers/r221/out_bench2.txt](scripts/reviewers/r221/out_bench2.txt):

| lambda | cols | rows | nnz | S author | D dense | M sparse | nullity |
|---|---:|---:|---:|---:|---:|---:|---:|
| (4,3,1,1,1,0) | 794 | 1,805 | 5,166 | 0.2 s | 0.1 s | 0.3 s | 2 = m |
| (3,3,2,1,1,0) | 1,697 | 4,267 | 12,867 | 26.4 s | 1.3 s | 2.0 s | 3 = m |
| (4,2,2,0,0,0) | 2,614 | 6,545 | 19,185 | 2.3 s | 3.2 s | 4.3 s | 8 = m |
| (4,2,1,1,0,0) | 4,186 | 10,728 | 32,235 | 30.4 s | 7.2 s | 10.6 s | 4 = m |
| **(3,3,1,1,0,0)** | **6,137** | **17,233** | **52,245** | **69.6 s** | **44.2 s** | **28.3 s** | **8 = m** |

Two things fall out.

**First: at the block the dead-end was declared on, sparse done properly is FASTER than dense** -- 28.3 s against 44.2 s, a 1.6x win for sparse, not a 20x loss. Even the author's own unmodified routine is 1.6x slower than dense there, not 20x. The crossover is visible in the table: dense wins below ~4,000 columns and sparse takes the lead by 6,137, which is the direction one expects when nnz per column stays flat at 8.5 while dense cost grows as the cube.

**Second, and worse: the 1,943 s does not reproduce.** [agent_logs/n12_cov_big.log](agent_logs/n12_cov_big.log) line 28 records `rank 1943.1s` at (3,3,1,1,0,0). Running the same function on the same matrix I measure 69.6 s -- a factor of 28. That is not a machine-speed difference, because the surrounding blocks in the same log reproduce on this machine to within 10%:

| lambda | cols | author's log | r221 |
|---|---:|---:|---:|
| (3,3,2,1,1,0) | 1,697 | 24.4 s | 26.4 s |
| (4,2,2,0,0,0) | 2,614 | 2.2 s | 2.3 s |
| (4,2,1,1,0,0) | 4,186 | 33.9 s | 30.4 s |
| **(3,3,1,1,0,0)** | **6,137** | **1,943.1 s** | **69.6 s** |

Four blocks, three agree, one is off by 28x. The same log carries a second obvious contention artefact -- `build 573.8s` at (4,3,1,0,0,0) where every neighbour builds in 0.3 s -- which the author attributed to the `WTS.index` linear scan. Both outliers being in the same run points at load on the box during that run, not at the algorithm. **The 1,943 s is an outlier, and the entire dead-end verdict rests on it.**

A third, unrelated data point falls out of the claim 3 work: [scripts/reviewers/r221/c3_nullity.py](scripts/reviewers/r221/c3_nullity.py) reaches the same block at the *second* prime, through a different enumeration and a shortest-row elimination, in **49.1 s end to end including the build** ([scripts/reviewers/r221/out_nullity2.txt](scripts/reviewers/r221/out_nullity2.txt)). Three separate runs of this block on this machine land between 28 s and 70 s. None lands near 1,943 s.

### Verdict on claim 4

The conclusion is **refuted three times over**: the comparison was between different problems, the timed routine is not sparse elimination (no live-row updates, so no fill control at all -- the very thing the docstring blames), and the one number it rests on does not reproduce. Sparse is not a dead end here; on the largest block measured it is the fastest of the three. The docstring's "Measured, not predicted, and recorded so the idea is not retried" should be struck, and the sentence "plain sparse elimination is worse still" in the remaining-blocks paragraph with it.

## Working notes

(in progress)
