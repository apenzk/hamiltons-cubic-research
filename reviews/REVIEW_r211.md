# Gate 2 review r211 -- the lift to Q (claims 1 and 2)

Commits under review: eaf59e1, cc1cabd, cbb18cf. Assigned scope: claims 1 and 2 of brief17
(reviewer 212 holds 3-5). Scripts: [scripts/reviewers/r211/](../scripts/reviewers/r211/).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1a | CRT is right | CONFIRMED |
| 1b | Reconstruction is unique at the heights actually reached | CONFIRMED, with a latent bound defect |
| 1c | 123 bits is enough; nothing reconstructed to a wrong small rational | PENDING (fourth prime in flight) |
| 2a | Exact rank over Q is 13 and the system is consistent over Q | CONFIRMED, and this is a test with teeth |
| 2b | The rhs entries are the true F_5 values | CONFIRMED against a from-scratch exact recomputation |
| 2c | Column order of the rows matches the dumped block shape | PENDING (measurement in flight) |
| 2d | The pairing convention the rows encode | DISCREPANCY, provably harmless -- see below |

## 1a, 1b -- the CRT and the reconstruction

[check_lift_arithmetic.py](../scripts/reviewers/r211/check_lift_arithmetic.py) reruns the lift with
an independent CRT (sympy) and an independent half-EEA reconstruction that carries separate
numerator and denominator bounds and verifies the congruence `num == den*a (mod M)` before
returning. Over all 1920 entries (40x47 rows plus 40 rhs):

- the three moduli are prime, distinct, 41 bits each, all 1 mod 4;
- 0 CRT disagreements, 0 reconstruction disagreements, 0 failures;
- max numerator 35906421773828096 (55 bits), max denominator 800415 (20 bits);
- uniqueness margin `2*max(|num|*den)/M = 2.26e-14`, so every reconstructed value is the unique
  rational of its height congruent to the CRT residue, by an enormous margin.

**Latent defect in the bound.** `run_n5_lift.py` sets `BOUND = int((M // 2) ** 0.5)`, a float
square root of a 121-bit integer. It returns 815238614229736320, which is **30 above**
`isqrt(M // 2) = 815238614229736290`, and at that value `2*BOUND**2 - M = +96806891517146283047 > 0`.
The uniqueness hypothesis for rational reconstruction is `2*N*D < M`; as coded it **fails**. Any
entry reconstructing with a numerator or denominator in the 30-wide window above the true bound
would be accepted without a uniqueness guarantee. Nothing lands there -- the largest height reached
is 4.4% of the bound -- so the defect is latent, not live. The fix is `isqrt`.

**"123 bits" overstates the modulus.** The figure is the sum of the three `bit_length()`s. The
product is 1329227996262441571707707956308001753, a **121-bit** integer with `log2 M = 120.00`. The
margin is so large that the difference does not bite, but the reported number is not the modulus.

## 2a -- exact rank over Q

`run_n5_lift.py` checks a float64 SVD rank with a 1e-10 relative threshold. That is a screen. Over Q
the rank is decidable, and [check_exact_rank.py](../scripts/reviewers/r211/check_exact_rank.py)
decides it by exact Gaussian elimination on Fractions:

- `rank_Q(A) = 13`, matching the mod-p rank at three primes;
- `rank_Q([A | F_5]) = 13`, so the system is **consistent over Q**, exactly, not mod p;
- affine family dimension 47 - 13 = 34 in Hermitian coordinates.

This is the strongest check available before the fourth prime lands, because it has teeth: two
controls confirm the test can fail. Adding 1 to a single entry raises the exact rank to 14; replacing
one entry by 7/13 -- a small rational of exactly the kind a too-short CRT would emit -- also raises it
to 14. So 1880 entries all reconstructing into a rank-13 configuration is not something a wrong
reconstruction survives.

## 2b -- the right-hand sides, against a known exact answer

This is the check the brief asked for and it is available without the pipeline. The 40 sample points
are integer Weyl tensors drawn from `random.seed(20260829)`, and `F_5 = (3/2)|W|^6 - 9 tr(W^3)^2` is a
direct contraction. [check_rhs_exact.py](../scripts/reviewers/r211/check_rhs_exact.py) replays the
seed, rebuilds the 40 tensors from `run_n5_weyl_module.py` alone, and computes F_5 over Q:

- the 40 lifted rhs rationals equal the exact values, **40 of 40**, all integers;
- the exact values reduce to the dumped residues at all three primes, 40 of 40 each.

This tests four things at once that rank agreement cannot: that the sample stream really is
regenerated identically at every prime (an independent replay reproduces it), that the mod-p F_5
evaluator is right, that CRT plus reconstruction return the true rational on entries whose answer is
known independently, and that the row/rhs correspondence is not off by one. Heights here reach only
2.8e11, so it stresses correctness rather than the reconstruction bound.

## 2c -- REFUTED: the SDP is blocked on the wrong column partition

**This is the finding.** `run_n5_assemble.py`'s `herm_row` walks the blocks in the order
`sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l))` -- by decreasing multiplicity, ties broken
lexicographically -- and that is the order the 47 columns of every dumped row carry. The dump records
`blocks` and `shape` as `[... for l in sorted(TR) if TR[l]]`, plain lexicographic. `run_n5_lift.py`
reads `SHAPE = data[0]["shape"]` and cuts the columns with it.

Measured from the real `ADAPTED` by [check_block_order.py](../scripts/reviewers/r211/check_block_order.py):

| | order | sizes |
|---|---|---|
| columns of the rows | (2,2) (4,2) (3,2) (2,0) (2,1) (3,0) (3,1) (4,0) (4,1) (4,3) (4,4) (5,2) (3,3) (5,1) (5,3) (6,3) | 3 3 2 1 2 1 2 1 2 2 1 1 1 1 1 1 |
| dumped `shape` | (2,0) (2,1) (2,2) (3,0) (3,1) (3,2) (3,3) (4,0) (4,1) (4,2) (4,3) (4,4) (5,1) (5,2) (5,3) (6,3) | 1 2 3 1 2 2 1 1 2 3 2 1 1 1 1 1 |

Both partitions sum to 47 in squares, which is why `assert len(coord) == NC` passes and why nothing
upstream notices: every check in `run_n5_assemble.py` is a rank or a consistency test, and those are
invariant under any permutation of the columns. The block structure is used in exactly one place --
the PSD constraint -- and that is the place it is wrong. The printed per-block eigenvalue labels are
mislabelled for the same reason.

**An independent, exact confirmation that does not read the code.**
`B^lambda_ij(W) = Q^lambda(x_i, x_j)` is a Gram matrix of the copies of `W^3` against the ambient
metric, and the restriction `H = T B T*` is a congruence, so **every block of every row must be
positive semidefinite at every sample point**. That is a known exact answer, and it decides the
partition. [check_row_psd.py](../scripts/reviewers/r211/check_row_psd.py), over the lifted rationals:

- true partition: **640 of 640** blocks psd; exactly over Q, **200 of 200** of the 2x2 blocks psd;
- dumped shape: **239 of 640** blocks fail; exactly over Q, only **41 of 200** of the 2x2 blocks psd,
  worst scaled minimum eigenvalue -1.12.

So the dumped `shape` provably does not describe the columns.

**What it costs cc1cabd.** [rerun_lift_correct_order.py](../scripts/reviewers/r211/rerun_lift_correct_order.py)
reproduces the reported solve exactly -- dumped shape, `t = 0.9999999981`, worst eigenvalue
**1.416183** and affine residual **7.972e-14**, matching the commit to every digit printed -- and then
reads that same returned point under the true partition:

> worst eigenvalue **-1.440e+03**, with (4,2) at -1440, (3,1) at -963, (2,2) at -538.

The reported "STRICTLY positive definite point, worst eigenvalue 1.416" **is not positive
semidefinite as a certificate Gram**. It is a feasible point of a different semidefinite program.
This is precisely the failure the brief named: a feasible point found in bad coordinates that "would
read as a certificate".

**What survives.** Solving the same affine system under the true partition is still feasible and
still strictly positive definite:

> status optimal, `t = 0.0233670`, worst eigenvalue **2.3367e-02**, affine residual 3.34e-15.

So the programme's conclusion -- the family contains a strictly psd point -- appears to hold, but the
margin is **sixty times smaller** than reported and the published point must be discarded. Two further
consequences follow for claims 3 and 4, which are reviewer 212's:

- the optimum under the true partition is 0.0234, **strictly below the cap** `t <= 1`. So the
  homogeneous kernel contains **no** psd direction in the correct coordinates, and the earlier
  "unbounded means feasible plus a psd kernel direction" reading was itself an artefact of the wrong
  blocking;
- any rational rounding must be done at margin 0.023, not 1.4.

`run_n5_psd.py` has a third ordering, `SHAPE = sorted(TR[l].shape[0] ...)`, which agrees with neither.

## 2d -- the pairing convention loses a factor of two (harmless, but state it)

The equation is `sum_ij C_ij B_ij` with `C`, `B` Hermitian, which expands to
`sum_i C_ii B_ii + 2 sum_{i<j} (Re C Re B - Im C Im B)`. `herm_row` emits `(B_ii; Re B_ij, Im B_ij)`
and `run_n5_lift.py` dots it against `(C_ii; Re C_ij, Im C_ij)`, giving
`sum_i C_ii B_ii + sum_{i<j} (Re C Re B + Im C Im B)` -- no factor 2, and the opposite sign on the
imaginary part. So the variable the SDP solves for is not the certificate Gram `C` but
`Chat` with `Chat_ii = C_ii`, `Chat_ij = 2 conj(C_ij)` off the diagonal.

This one is **harmless in both directions**, and the reason should be recorded rather than left to
luck: `C = conj(Chat) o ((J + I)/2)` where `o` is the Hadamard product. Transposition preserves
positive semidefiniteness, `(J + I)/2` is positive definite, and by the Schur product theorem a
Hadamard product of a psd matrix with a pd matrix is psd -- strictly so when the first is pd. So
`Chat` psd iff `C` psd, and strict definiteness transfers too. The affine constraint is likewise
preserved because the change of variables is diagonal and invertible. Ranks are unaffected.
