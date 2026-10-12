# Gate 2 review r216 -- the n=12 routing decision (claims 4, 5, 6)

Reviewer 216. Commits under review: `89466b5`, `3490455`, `537ab39`, `cf4a7fd`.
Files: [run_n12_weights.py](../scripts/runs/run_n12_weights.py), [run_n12_sym3.py](../scripts/runs/run_n12_sym3.py), [run_n12_route.py](../scripts/runs/run_n12_route.py).
Scripts for this review: [scripts/reviewers/r216/](../scripts/reviewers/r216/).

Reviewer 215 runs claims 1-3 of the same brief concurrently; this review takes claims 4, 5, 6.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 4a | dim of the Sym^3(Weyl_12) weight space at the trivial weight is 635,220 | **CONFIRMED** exactly, by a route with no Freudenthal and no Weyl orbits in it |
| 4b | the highest-weight route requires forming that space, so it does not transfer | **REFUTED.** The route was run at n=12 on 61 of the 77 blocks, 131 of the 191 multiplicities, largest weight space 13,444 |
| 5 | "the covariants' Gram has rank m_lambda per block" is a sufficient span check | **SUFFICIENT, under three preconditions the commit does not state.** Its one real dependency -- m_lambda from the peel -- is discharged here by Racah |
| 6 | cf4a7fd's three repairs | **ALL THREE HOLD.** One residual: the rank-14 step is the last floating-point link in an exact chain |

---

## Claim 4a -- 635,220 is right

Verified by [c4a_weightspaces.py](../scripts/reviewers/r216/c4a_weightspaces.py), which shares no step with the author's derivation. The author goes Freudenthal -> Weyl orbits -> Newton power sums -> peel. This review goes:

* the 12 weights of C^12 under the so(12) Cartan are +-e_1..+-e_6;
* Littlewood's restriction rule with beta over even-row partitions gives S_(2,2) = W_(2,2) + W_(2) + W_(0), so char Weyl_12 = s_22 - h_2, and Jacobi-Trudi gives s_22 = h_2^2 - h_3 h_1. Symmetric functions only, no Lie theory;
* dim Sym^3(V)_lambda = (A_1 + 3 A_2 + 2 A_3)/6 with A_j the coefficient of lambda in p_1^3, p_1 p_2, p_3.

| quantity | this review | run_n12_route.py |
|---|---|---|
| char Weyl_12 | 853 distinct weights, dimension 1638 | 1638 |
| dim (Sym^3)_0 | **635,220** | 635,220 |
| median over the 77 block weights | 810 | 810 |
| above 10,000 | 19 | 19 |
| total over the 77 | 2,002,005 | 2,002,005 |
| all 77 individually | 0 disagreements | -- |

The n=5 side of the comparison is also right: the same machinery at N=5 gives dim Weyl_5 = 35, dim Sym^3 = 7,770, trivial weight space **234** ([c4b_n5compare.py](../scripts/reviewers/r216/c4b_n5compare.py)).

As a by-product the same file confirms every number in claim 1 -- 853 distinct weights with multiplicities 1 (540 weights), 2 (240), 4 (12), 9 (60), 30 (1), which is exactly multiplicities 1, 1, 2, 4, 9, 30 over orbits 60, 480, 240, 12, 60, 1.

## Claim 4b -- the inference is wrong, and the route is open

The number is right and the conclusion drawn from it is not. Four separate reasons, three of them with a witness.

### 1. The premise about cost is false, and measurable

run_n12_weights.py's docstring rejects the module route because it would need "66 generators of size 1638x1638 -- 177 million entries before any arithmetic". A highest-weight computation needs the **six simple** raising operators, not all 66, and only on one weight space at a time. [c4b_module.py](../scripts/reviewers/r216/c4b_module.py) builds Weyl_12 explicitly as ker(wedge) ∩ ker(Ricci) inside Sym^2(Lambda^2 C^12), weight space by weight space -- the largest weight space of the 2211-dimensional ambient is 51, so no large object is ever formed.

| | measured |
|---|---|
| build time for the whole module, exact over Q | 2 seconds |
| dimension | 1638 |
| nonzeros in the six simple raising operators, **in total** | **6,714** |
| density against the 6 x 1638^2 = 16,098,264 dense figure | 0.00042 |

The operators the route needs have 6,714 nonzero entries, not 177 million.

### 2. The route was run at n=12, and it works

[c4b_hw.py](../scripts/reviewers/r216/c4b_hw.py) performs the n=5 construction at n=12: basis of the lambda weight space of Sym^3, stack the six simple raising operators, take the kernel, compare its dimension with m_lambda.

The kernel dimension is **certified**, not sampled: over Q the nullity is at least m_lambda by complete reducibility, and reducing mod p can only lower the rank, so a mod-p nullity equal to m_lambda pins the nullity over Q to m_lambda exactly.

| run | prime | blocks | multiplicities | mismatches | wall clock |
|---|---|---|---|---|---|
| [hw10000.log](../scripts/reviewers/r216/hw10000.log) | 2147483647 | 58 of 77 | 121 of 191 | **0** | 248 s |
| [hw13500_p40009.log](../scripts/reviewers/r216/hw13500_p40009.log) | 40009 | **61 of 77** | **131 of 191** | **0** | 536 s |

Largest block completed: the **13,444**-dimensional weight space at (2,2,2,2,0,0), 103 s, nullity 4 against m_lambda = 4. The two runs use different primes and agree with each other and with the peel everywhere they overlap. Naive dense mod-p elimination in Python, no sparsity exploited, no tuning. The n=5 run the commit compares against took 86 s.

Measured cost, so the extrapolation is not a guess:

| weight space | rows | rank time |
|---|---|---|
| 810 | 2,560 | 0.2 s |
| 4,335 | 12,163 | 6.5 s |
| 9,029 | 25,301 | 75 s |
| 13,444 | 42,734 | 104 s |

What remains unrun is 16 blocks and 60 multiplicities, all of them above 14,595. The stacked matrix has about two nonzeros per column per operator -- the trivial block itself is roughly 7.6M nonzeros in 635,220 columns -- so those are sparse ranks over GF(p), not dense ones, and the trivial block among them is already settled by diagrams (below).

This is also an independent re-derivation of 131 of the 191 SO(12) multiplicities, by a method that shares nothing with the peel.

### 3. The block that closed the route is the block that never needed it

"the tail contains the TRIVIAL block, which no certificate can skip." The trivial block of Sym^3(Weyl_12) has multiplicity **2**, and its multiplicity space is the space of cubic O(12)-invariants of the Weyl tensor. By the first fundamental theorem for O(n) that space is spanned by complete contractions of three Weyl tensors with the metric -- which is precisely the diagram construction the commit switches to, and there its completeness is a **theorem** rather than the span obligation claim 5 takes on.

[c4b_trivial_block.py](../scripts/reviewers/r216/c4b_trivial_block.py) exhibits the pair and checks it:

* I1 = W_abcd W_cdef W_efab and I2 = W_acbd W_cedf W_eafb;
* independent -- the 2 x 8 matrix of their values at 8 random Weyl tensors has singular values 1.450 and 1.369;
* invariant -- both move by 5e-16 relative under a random O(12) rotation;
* with m_0 = 2 from the character, the two diagrams span the trivial multiplicity space exactly.

So the single measurement that closes the route -- 635,220 at the trivial weight -- is taken at the one weight where the alternative is free and provably complete. A hybrid (diagrams for the trivial block, highest-weight vectors for the other 76) faces at most 1,366,785 columns spread across 76 independent problems, of which this review has already dispatched 54.

### 4. The comparison is absolute where the quantity is relative

The highest-weight route exists to avoid touching Sym^3. What it buys is therefore the ratio, and by that ratio it improves with n ([c4b_n5compare.py](../scripts/reviewers/r216/c4b_n5compare.py)):

| n | dim Weyl_n | dim Sym^3 | trivial weight space | compression |
|---|---|---|---|---|
| 5 | 35 | 7,770 | 234 | 33x |
| 6 | 84 | 102,340 | 1,470 | 70x |
| 7 | 168 | 804,440 | 7,316 | 110x |
| 8 | 300 | 4,545,100 | 22,420 | 203x |
| 12 | 1,638 | 733,813,080 | 635,220 | **1,155x** |

Read as 635,220 against 234, the route looks like it degrades by a factor of 2,715. Read by the ratio the route is built to deliver, it improves by a factor of 35.

### What should replace the dead end

The route is live and the record should say so. The cheapest correct split is:

1. the trivial block by contraction diagrams, complete by the FFT, m_0 = 2 -- already exhibited above;
2. the other 76 blocks by highest-weight vectors, which are a basis by construction and carry no span obligation. 60 of them are done in this review at a cost of 536 seconds;
3. the remaining large blocks by the same method with sparse rank over GF(p) instead of dense -- the stacked matrix has about 2 nonzeros per column per operator, so the trivial block itself is roughly 7.6M nonzeros, which is a routine sparse rank, not an impossibility.

Recording this as `Deliverable: dead-end` closes a route that is open. That is the error the brief calls the most expensive available.

---

## Claim 5 -- the Gram check is sufficient, under three preconditions the commit does not state

[c5_gram.py](../scripts/reviewers/r216/c5_gram.py). The direction is right and it is right conservatively. If the covariants D_1..D_N lie in the multiplicity space M_lambda then for any pairing

    rank Gram(D) <= dim span{D_i} <= m_lambda,

so rank = m_lambda forces span = M_lambda. The test cannot pass a family that fails to span. With an invariant pairing that is nondegenerate on M_lambda -- true for the apolar pairing on a self-dual block -- the converse holds too, so the test is exact rather than merely safe.

**A corollary worth using.** rank_p <= rank_Q <= m_lambda, so a rank over GF(p) equal to m_lambda certifies spanning over Q with no lifting and no rational arithmetic. A floating-point rank does not: it can only overestimate, which is the direction that passes a deficient family. Given this programme's history -- a psd point whose least eigenvalue was -1440 reported as +1.416, a PSD verifier that passed an indefinite matrix -- the check should be specified as exact or mod-p from the start.

What it misses:

| # | Miss | Consequence |
|---|---|---|
| 1 | it inherits m_lambda from the peel | the test certifies dim span >= m_lambda_**stated**. If a multiplicity is understated, a deficient family passes silently. Highest-weight vectors are a basis by construction, so their count **measures** m_lambda -- the switch gives up the programme's only independent handle on the character |
| 2 | it presupposes each D_i sits in one block | raw contraction diagrams do not. With an invariant pairing the Gram of unprojected diagrams is the **sum** of the per-block Grams, so rank can reach m_lambda on contributions from other blocks. Explicit witness in the script: two diagrams, Gram = I_2, rank 2 = m_lambda, and the lambda-components span dimension 1 |
| 3 | it presupposes the pairing is invariant | blocks decouple by Schur only for an invariant pairing; otherwise "rank m_lambda per block" is not well defined |
| 4 | it is insensitive to equivariance | a family of arbitrary sextics of the right degree can have Gram rank m_lambda. The n=5 build carries a live equivariance guard; the check as stated contains none |
| 5 | coverage, and SO versus O | passing on the blocks tested says nothing about the others, and on the six **fused** chirality pairs the multiplicity to test against is the O(12) one. 191 and 184 differ on exactly those six |

Miss 2 is the one with teeth, because the fix costs the advantage. To form the Gram on block lambda you must first project the diagrams into the lambda-isotypic component, and that projection is linear algebra inside Sym^3 -- the cost run_n12_route.py says the diagram route avoids entirely ("forms no weight space at all"). The commit records the advantage and not the tension.

### Miss 1 discharged, by supplying the count the route gave up

[c5_racah.py](../scripts/reviewers/r216/c5_racah.py) computes every multiplicity by Racah's alternating sum

    m_lambda = sum_{w in W(D_6)} sgn(w) * N(lambda + rho - w rho),   |W(D_6)| = 23,040,

with N the Sym^3 weight multiplicity built from the claim 4a character. No Freudenthal, no peel, no cached file.

| quantity | Racah | run_n12_sym3.py |
|---|---|---|
| Sym^3 distinct weights | 204,205 | 204,205 |
| dimension | 733,813,080 = C(1640,3) | same |
| multiplicities over the 77 constituents | 0 disagreements | -- |
| total SO(12) multiplicity | 191 | 191 |
| sum m_lambda dim V(lambda) | 733,813,080 | -- |
| chirality pairs and multiplicities | 6 pairs at 2,1,1,1,1,1 | 6 pairs at 2,1,1,1,1,1 |
| O(12) | 71 blocks, 184 multiplicities | 71, 184 |

The dimension sum closing on C(1640,3) with all m_lambda non-negative also proves **completeness** -- no constituent is missing from the list of 77. So claims 2 and 3's headline numbers survive an independent derivation as well, and claim 5's dependency on the peel is discharged.

## Claim 6 -- all three repairs hold

[c6_repairs.py](../scripts/reviewers/r216/c6_repairs.py).

| repair | verdict |
|---|---|
| the identity argument, replaced by r213's | **holds**, and the 14 is confirmed by a fourth route |
| the halved off-diagonal form, C = (M + diag M)/2 | **holds**, re-derived from herm_row's packing |
| the denominator correction | **holds**, exactly |

**R1, the identity argument.** The replacement is: every row entry and F_5 are O(5)-invariant sextics; (Sym^6 Weyl_5)^O(5) is 14-dimensional; 120 explicit invariant sextics have rank 14 at the 40 points; so evaluation is injective there and agreement is identity. The logic is sound in both steps -- rank 14 against a cap of 14 forces the 120 sextics to span the whole invariant space, and injectivity on a spanning set of a 14-dimensional space is injectivity on the space. The row entries are genuinely invariant: [herm_row](../scripts/runs/run_n5_assemble.py#L848) walks one block at a time and packs H_ij = &lt;c_i(W), c_j(W)&gt; for covariants c_i, c_j of the same type, so each real and imaginary part is an invariant sextic in W.

The load-bearing 14 is re-derived here by a fourth independent route -- Racah's alternating sum over W(B_2) on the Sym^6 character built by Newton from the Littlewood + Jacobi-Trudi character of Weyl_5:

* dim Sym^6(Weyl_5) = 3,838,380 = C(40,6), and
* dim (Sym^6 Weyl_5)^so(5) = **14**. Since -I acts on Weyl_5 by (+1)^4 = +1, the O(5)-invariants coincide with the so(5)-invariants, so 14 is the O(5) number too.

(For context the same computation gives dim (Sym^3 Weyl_5)^O(5) = 1, against 2 at n=12.)

One residual, not a refutation: the rank-14 step is the last floating-point link in an otherwise exact chain. It carries a 14-decade singular value gap, and numerical rank errs by overestimating, which is the unsafe direction here. A mod-p rank of the same 120 x 40 matrix would close it at no cost.

**R2, the halved form.** Re-derived from the packing rather than accepted. [herm_row](../scripts/runs/run_n5_assemble.py#L848) appends, per block, H_ii for each i and then Re H_ij, Im H_ij for i &lt; j. For Hermitian C and Hermitian H,

    tr(C H) = sum_i C_ii H_ii + sum_{i<j} 2 (Re C_ij Re H_ij + Im C_ij Im H_ij),

so the coordinate at slot (i&lt;j, real) is 2 Re C_ij. [blocks()](../scripts/runs/run_n5_verify.py#L39) puts that coordinate straight into M_ij, so M has doubled off-diagonals and C = (M + diag M)/2 exactly as stated. The implication is valid too: M positive definite forces M_ii > 0, so diag M is positive definite and C is the average of two positive definite matrices. Both are now checked rather than one inferred, which is the right call. Least eigenvalue over the blocks: 0.02126 for M (consistent with r213's certified 21/1000), 0.02337 for C.

**R3, the denominator.** The certificate has 47 coordinates and a declared rounding denominator of 100,000. Coordinates with a strictly larger denominator: **13**. Largest denominator: **49,895,950,104,000,000 = 4.990e16**. Matches the repair digit for digit.

---

## How claims 4 and 5 interlock

The two findings are the same finding seen twice.

* Highest-weight vectors are a basis of the multiplicity space **by construction**, so their count is a measurement of m_lambda. The route carries its own calibration.
* Contraction diagrams are not a basis by construction, so the diagram route must borrow m_lambda from the peel to certify spanning. The route consumes a calibration it cannot produce.

537ab39 abandons the producer and keeps the consumer, on a measurement taken at the one weight where the producer was never needed. The right split keeps both: diagrams for the trivial block, where the FFT makes completeness a theorem, and highest-weight vectors elsewhere, where they hand back the 184 that the Gram check has to be tested against.

## Residuals

| | |
|---|---|
| 16 of the 77 blocks are still unrun by the highest-weight route here | all above 14,595; sparse rank over GF(p) rather than the dense elimination used above |
| r213's rank-14 injectivity step is floating point | 14-decade gap, but numerical rank errs by overestimating, which is the unsafe direction. A mod-p rank of the same 120 x 40 matrix closes it |
| [charpoly](../scripts/runs/run_n5_verify.py#L55) carries an unused inner `mul` | dead code, no effect on the result |
