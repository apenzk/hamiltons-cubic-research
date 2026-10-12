# Review r224 -- Gate 2, the stability theorem (claims 1 and 2)

Reviewer 224. Brief: brief18.md. Commits under review: b8d8f72 (primary), 7479d70, 6ca5418, 1bf0974.
Scope assigned: claims 1 and 2 (reviewer 225 runs 3, 4, 5 concurrently).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1a | LR row bound: constituents of Sym^3(Weyl_n) have at most 6 rows, and this survives O(n) trace contraction | **CONFIRMED** |
| 1b | A partition labels an O(n) irreducible iff lambda'_1 + lambda'_2 <= n, boundary inclusive | **CONFIRMED** (literature, non-strict) |
| 1c | max(lambda'_1 + lambda'_2) over constituents is 12, attained at (2,2,2,2,2,2) | **CONFIRMED** |
| 1d | Multiplicities, not merely the label set, are n-independent for n >= 12 | **TRUE, BUT UNCHECKED BY THE FILE** -- confirmed here (71 blocks / 184 mult, verified at five dimensions); the file's asserts pass unchanged when multiplicities are moved |
| 2 | The threshold is exactly 12; n=11 and n=13 behave as the argument predicts | **CONFIRMED** (n=11, 12 and 13 all verified block-by-block) |
| -- | The stability theorem as a whole | **UPHELD.** The conclusion is right and the threshold is right. Two hypotheses are missing from the write-up and one supporting sentence is arithmetically wrong; neither touches the conclusion. |

**Verdict in one line: the theorem survives every attack I could mount, and it survives an independent reconstruction of the table that never reads this repo.** I found no witness against it. What I did find is that the file's own supporting evidence is thinner than the theorem it supports: the checks read 55 of the 71 blocks and are demonstrably blind to multiplicity drift (a planted table with the right labels and 102 extra multiplicities passes every assert), the load-bearing Koike-Terada step is unstated, and the n = 10 explanation accounts for one of the seven blocks it is explaining.

## Method

Everything below is computed from Littlewood's inverse restriction formula and the Weyl character formula. Nothing is read from this repo's code or its output except where explicitly comparing against it.

## Findings

### 1b -- the labelling condition (literature, not the file)

Howe, Tan and Willenbring, [Stable branching rules for classical symmetric pairs](https://arxiv.org/html/math/0311159v2), state it verbatim: each irreducible rational representation of O(n) "is indexed uniquely by a non-negative integer partition nu such that (nu')_1 + (nu')_2 <= n". The inequality is NON-STRICT, so the boundary case n = lambda'_1 + lambda'_2 is an admissible label, which is exactly the case the argument leans on at n = 12 with (2,2,2,2,2,2). The same non-strict form is the one King's modification rules are written against. No off-by-one: step (b) is stated correctly.

Boundary pinned by the Weyl tensor itself ([boundary_pin.py](scripts/reviewers/r224/boundary_pin.py)): lambda = (2,2) has lambda'_1 + lambda'_2 = 4, and `dim Weyl_n = n(n+1)(n+2)(n-3)/12` gives 0 at n = 3 and 10 at n = 4. A strict inequality would kill the four-dimensional Weyl tensor; an inequality one step looser would resurrect a three-dimensional one. Both directions of the boundary are therefore fixed by a quantity nobody can adjust, and the boundary is INCLUSIVE.

Boundary sanity: at n = 12 the label (2^6) has lambda'_1 = 6 = n/2, so it is SELF-ASSOCIATE -- its associate (obtained by replacing the first column length by n - lambda'_1 = 6) is itself. Self-associate labels are legitimate; they are the O(n) irreducibles whose restriction to SO(n) splits in two. Nothing degenerates at the boundary.

### 1a, 1c, 1d -- an independent recomputation of the stable table

[universal_o.sage](scripts/reviewers/r224/universal_o.sage) rebuilds the whole stable decomposition from Littlewood's inverse restriction formula inside the ring of symmetric functions, reading nothing from this repo and using no modification rule:

    omega_nu = sum_{beta} (-1)^{|beta|/2} s_{nu/beta},  beta with Frobenius coordinates (a | a-1).

The script self-checks the basis two ways before using it: it reproduces the forward Littlewood restriction s_lambda = sum (sum_{delta even rows} c^lambda_{mu delta}) omega_mu on seven test partitions, and it reproduces the classical product [2] x [2] = [4]+[31]+[22]+[2]+[11]+[0]. Then omega_(2,2) = s_22 - s_2 (which is the Weyl-tensor character, since S_(2,2)(V) = Weyl + traceless-Ricci + scalar), and Sym^3 is the plethysm h_3[omega_(2,2)].

Result:

| quantity | value |
|---|---|
| blocks | **71** |
| total multiplicity | **184** |
| negative multiplicities | none |
| max rows over constituents | **6** |
| max lambda'_1 + lambda'_2 | **12**, at (2,2,2,2,2,2), multiplicity 1 |
| sum over blocks of m(m+1)/2 | **477** |

This is an independent reproduction of the record's 71 / 184, and it settles 1a, 1c and 1d together: the multiplicities themselves -- not merely the label set -- are the n-independent universal ones, because they are computed once in the universal ring and every one of the 71 labels satisfies lambda'_1 + lambda'_2 <= 12.

Separately, [plethysm_top.sage](scripts/reviewers/r224/plethysm_top.sage) confirms the top-degree witness on its own: h_3[s_22] contains s_(2,2,2,2,2,2) with coefficient 1, so the constituent that sets the threshold really is there and is not an artifact of a truncated label list.

### 2 -- the threshold, and the n = 11 falsification test

The threshold is not tuned. It is `3 * |(2,2)| = 12`, forced by the single constituent (2,2,2,2,2,2): three factors of a two-row label give at most six rows, and the one constituent that is a 6 x 2 rectangle has both column lengths equal to 6. The same construction gives `4k` for `Sym^k(Weyl)`, checked in [threshold_k.sage](scripts/reviewers/r224/threshold_k.sage): k=1 threshold 4 (1 block), k=2 threshold 8 (13 blocks / 14 mult), k=3 threshold 12 (71 / 184), k=4 threshold 16 (279 / 4058). That 12 lands next to the conjecture's own `6 + 2*sqrt(7) = 11.29` is arithmetic coincidence between two unrelated formulas; nothing in the plethysm knows about the crossover.

The decisive test is n = 11, where the argument predicts a specific, different table. At n = 11 exactly one of the 71 labels, (2,2,2,2,2,2), has `lambda'_1 + lambda'_2 = 12 = n+1`, which King's modification rule sends to zero -- so the O(11) table should be 70 blocks / 183 multiplicities, and every other block should be untouched.

[predict_so.py](scripts/reviewers/r224/predict_so.py) turns that into a block-by-block prediction for the SO(11) decomposition; [so_sym3.sage](scripts/reviewers/r224/so_sym3.sage) computes the SO(11) decomposition from the Weyl character formula alone (B5, Sym^3 of the 1144-dimensional module, dimension 250,187,080 checked against binom(1146,3)).

| n | predicted | computed (Weyl character formula) | mismatching blocks |
|---|---|---|---|
| 10 | -- | 77 blocks / 205 mult (D5) | -- |
| 11 | 70 blocks / 183 mult | 70 blocks / 183 mult (B5) | **0** |
| 12 | 77 blocks / 191 mult | 77 blocks / 191 mult (D6) | **0** |
| 13 | 71 blocks / 184 mult | 71 blocks / 184 mult (B6) | **0** |

Block-by-block agreement at both, not merely agreeing totals. The n = 12 row is the boundary case: the prediction of 77 SO-blocks rather than 71 is precisely the six labels with six rows splitting at ell = n/2, and it lands exactly, so the self-associate boundary labels are present as full O(12) irreducibles. The threshold is real: at 11 the table moves, in exactly the one place the argument says it must, and at 12 it does not. n = 13 then reproduces the stable table exactly -- 71 blocks and 184 multiplicities, block for block -- which is the odd-n case the brief asked for and which the argument predicts, since the labelling condition knows nothing about the parity of n.

### Do the file's own checks fire?

[plant_violation.py](scripts/reviewers/r224/plant_violation.py) replays [run_n12_stability.py](scripts/runs/run_n12_stability.py)'s logic on a copy of its label source with three plants:

| plant | result |
|---|---|
| baseline | PASS (max rows 6, threshold 12) |
| remove (2,2,2,2,2,2) | ASSERT FIRES (threshold 10) |
| inject a 7-row label | ASSERT FIRES (rows) |
| inject a label with col1+col2 = 13 | ASSERT FIRES (rows) |
| move multiplicities ((2^6): 1 -> 7, (4): 3 -> 99), labels untouched | **PASSES** |

The three label plants fire, so the checks are not vacuous. The fourth is the failure mode the brief names, and it goes straight through: the file stores its labels in a `set`, which discards multiplicity before any assert runs, so a table with the right 71 labels and 102 extra multiplicities passes every check in the file. Nothing in [run_n12_stability.py](scripts/runs/run_n12_stability.py) is capable of noticing multiplicity drift. What does notice it is the dimension identity below -- `sum mult * dim_O(n)` stops equalling `binom(dim Weyl_n + 2, 3)` immediately. One caveat on their logic: given `rows <= 6` the quantity `lambda'_1 + lambda'_2` is at most 12 automatically, so `assert worst == 12` can only ever fail downward -- it tests that the maximum is ATTAINED, and the upper half of the statement is carried entirely by the rows assert.

### A bonus: the record's n = 10 numbers, reconstructed from the same table

The universal table plus King's rule reproduces the record's n = 10 pair exactly, which is a further independent check that the 71 / 184 table is the right object. [predict_so.py](scripts/reviewers/r224/predict_so.py) and the SO(10) run give the residual directly: comparing the computed SO(10) decomposition (D5, 77 blocks / 205 multiplicities) against the universal table with (2,2,2,2,2,2) simply deleted leaves a residual of exactly `-[2,2,2,2,2] - [2,2,2,2,-2]`. So at n = 10 the modification of omega_(2^6) is `-[2,2,2,2,2]`, and the O(10) table is

    71 blocks / 184 mult  minus (2^6)  minus (2^5)  =  69 blocks / 182 mult,

and identifying each of the five remaining long labels (ell = 6 > n/2) with its associate -- all five associates are present -- gives **64 blocks / 182 multiplicities / 493 unknowns**, the record's numbers to the digit.

So both of the record's sampled tables are reproduced from one independent computation, all three figures each:

| n | record | this review |
|---|---|---|
| 12 (and 14) | 71 blocks / 184 mult / 477 unknowns | 71 / 184 / 477 |
| 10 | 64 blocks / 182 mult / 493 unknowns | 64 / 182 / 493 |

**A precision defect in the file's own prose.** [run_n12_stability.py](scripts/runs/run_n12_stability.py) says "n = 10 differs because (2,2,2,2,2,2) is not an O(10) label, 6+6 > 10". That accounts for one of the seven missing blocks. Two of the seven come from the modification -- the failed label AND the (2,2,2,2,2) block it cancels against -- and the other five come from associate identification at n = 10, which is a labelling phenomenon that does not occur at all for n >= 12. The conclusion survives untouched; the sentence explaining it does not match its own arithmetic.

### The decisive check: one fixed table, five dimensions

[dimcheck.sage](scripts/reviewers/r224/dimcheck.sage) tests the whole table at once. If the 71 blocks and 184 multiplicities really are n-independent, then for every n >= 12

    sum_lambda  mult(lambda) * dim_{O(n)}[lambda]  =  binom(dim Weyl_n + 2, 3),

with dimensions from the Weyl dimension formula (and doubled at ell(lambda) = n/2, where [lambda] splits over SO(n)). The individual dim_{O(n)}[lambda] change completely from one n to the next, so a single multiplicity vector satisfying this at several n by accident is not credible.

| n | sum mult x dim | binom(dim Weyl_n + 2, 3) | |
|---|---|---|---|
| 12 | 733,813,080 | 733,813,080 | MATCH |
| 13 | 1,965,013,050 | 1,965,013,050 | MATCH |
| 14 | 4,874,429,560 | 4,874,429,560 | MATCH |
| 16 | 24,883,123,720 | 24,883,123,720 | MATCH |
| 18 | 104,207,616,600 | 104,207,616,600 | MATCH |

The n = 12 row is the boundary case in its sharpest form. Six of the 71 labels have exactly six rows, so at n = 12 each sits at ell = n/2 and splits over SO(12); the identity holds only if each contributes BOTH halves, i.e. occurs as a full O(12) irreducible. Using the undoubled dimensions there breaks the match. So the boundary is not merely admissible in principle -- the arithmetic at n = 12 confirms those labels are present as genuine O(12) irreducibles.

**Planted violation.** The same check at n = 10, pretending the stable table still holds, gives 76,398,014 against the true 76,385,540 -- it FIRES. Applying King's rule ((2^6) cancelling against (2^5)) restores the match exactly. So the check is capable of failing, and it fails precisely where the theorem says the table moves.

[dimcheck_k.sage](scripts/reviewers/r224/dimcheck_k.sage) runs the same identity for Sym^2 and Sym^4, which tests the omega-basis machinery independently of the k = 3 answer. Both hold, and both hold AT their own threshold n = 4k -- Sym^2 at n = 8, 9, 10, 12 and Sym^4 at n = 16, 17, 18, 20, all MATCH. So the boundary case n = 4k exactly is confirmed three times over, at k = 2, 3 and 4.

Note this covers odd n as well: n = 13 is included and behaves exactly like 12 and 14, which is what the argument predicts (the condition lambda'_1 + lambda'_2 <= n has nothing to do with the parity of n).

## Two things the written argument leaves out

**1. The step that carries the whole implication is unstated.** The argument reasons "no modification rule fires, therefore the decomposition is independent of n". What licenses that inference is Koike-Terada's universal character ring: there is a specialisation map pi_n from the universal ring to R(O(n)) with pi_n(omega_nu) = [nu] when nu'_1 + nu'_2 <= n and the modification otherwise, it is a RING homomorphism, and it commutes with Sym^3 because it is evaluation of symmetric functions at the eigenvalues of a group element. Only then does "Sym^3 computed once, universally" descend to "Sym^3 computed at each n". Without that sentence the file has a statement about a list of labels rather than about a decomposition. The step is true, and this review's n = 10 and n = 11 reconstructions are evidence for it, but it is the load-bearing step and it is not written down.

**2. Step 1 names the wrong rule.** "A Littlewood-Richardson product of three partitions of at most two rows has at most six rows" is the GL(n) statement. The relevant rule for O(n) is Newell-Littlewood: `N_{lambda,mu,nu} = sum c^lambda_{alpha beta} c^mu_{alpha gamma} c^nu_{beta gamma}`, so nu appearing forces `c^nu_{beta gamma} != 0` with beta contained in lambda and gamma in mu, hence `ell(nu) <= ell(beta) + ell(gamma) <= ell(lambda) + ell(mu)`. Same bound of 6, different reason, and the trace contractions the brief worries about only lower the degree -- they never add rows. The independent computation confirms max rows = 6 on the actual universal constituents rather than leaving it to the bound.

## Scope -- what the theorem does and does not buy

The theorem establishes that the BLOCK TABLE (labels and multiplicities, hence the shape of the SDP: 71 blocks, 184 multiplicities, 477 unknowns) is the same for every n >= 12. That is what it says and it is true.

It does not by itself say that a numerical certificate found at n = 12 is valid at n = 14. Same block shape means the SDP has the same variables; it does not mean the constraint data are the same numbers. The docstring's "a certificate built at n=12 covers every larger even dimension without recomputation" therefore reaches past what steps (a)-(c) prove. The constraint side is settled elsewhere in the record -- plan.md line 402 records that "89 for all n >= 12" is an observation with the first fundamental theorem guaranteeing stability only from n >= 4k = 24, and line 394 closes it by a squeeze (padding monotonicity plus stability at n >= 4k, with an exact evaluation reaching 89 at n = 12). That squeeze, not this theorem, is what makes the constraint count n-independent, and the two should not be conflated when the route is written up.

## Note bearing on claim 4 (reviewer 225's assignment) -- the subset the file reads

Having the full universal table makes the subset question answerable, so it is recorded here rather than left to guesswork.

[run_n12_stability.py](scripts/runs/run_n12_stability.py) reads 61 labels from the covariant logs, which reduce to **55 distinct partitions** once the D6 sign variants are folded by its own `abs()`. The universal table has 71. Every one of the 55 is in the 71 -- nothing spurious -- but 16 blocks are missing, and those 16 carry **57 of the 184 multiplicities**, so the file sees 55/71 of the blocks and 127/184 of the multiplicity.

Could the missing 16 have carried a larger value? No: their maximum `lambda'_1 + lambda'_2` is 8, at (2,2,2,2), and their maximum row count is 5. So the assert's conclusion is correct. But that is a fact established here from the full table, not something the file's own reading guarantees -- from inside the file, a missing block with seven rows would have been invisible.

Two further gaps in what the checks can catch:

* the file examines a SET of labels and never looks at a multiplicity, so multiplicity drift at fixed label set -- the exact failure mode the brief names -- would pass every assert in the file;
* given the rows assert, `lambda'_1 + lambda'_2 <= 12` is automatic, so `assert worst == 12` is only testing attainment.

## Runs behind this review

| script | what it computes | route |
|---|---|---|
| [universal_o.sage](scripts/reviewers/r224/universal_o.sage) | the stable table, 71 blocks / 184 mult / 477 unknowns | Littlewood inverse restriction in Lambda |
| [plethysm_top.sage](scripts/reviewers/r224/plethysm_top.sage) | the top-degree witness (2,2,2,2,2,2) | GL plethysm h_3[s_22] |
| [dimcheck.sage](scripts/reviewers/r224/dimcheck.sage) | the dimension identity at n = 12, 13, 14, 16, 18, and its failure at n = 10 | Weyl dimension formula |
| [dimcheck_k.sage](scripts/reviewers/r224/dimcheck_k.sage) | the same identity for Sym^2 and Sym^4 at their own thresholds 8 and 16 | Weyl dimension formula |
| [so_sym3.sage](scripts/reviewers/r224/so_sym3.sage) | the SO(n) decomposition of Sym^3(Weyl_n), n = 10, 11, 12, 13 (14 still running) | Weyl character formula only |
| [predict_so.py](scripts/reviewers/r224/predict_so.py) | the O(n) -> SO(n) prediction those runs are tested against | universal table + King's rule |
| [plant_violation.py](scripts/reviewers/r224/plant_violation.py) | whether the file's asserts fire under three plants | replay of the file's own logic |
| [boundary_pin.py](scripts/reviewers/r224/boundary_pin.py) | the boundary of the labelling condition, pinned by dim Weyl_3 = 0 and dim Weyl_4 = 10 | dimension formula |

The n = 14 (D7) run is still in flight and writes to `agent_logs/r224_n14.log`; it is a direct block-by-block confirmation of what the dimension identity already establishes at n = 14, and no verdict above waits on it. Its prediction is 71 blocks / 184 multiplicities, stored in `scripts/reviewers/r224/pred_so_14.json`, checkable afterwards with `python3 scripts/reviewers/r224/compare.py 14`.
