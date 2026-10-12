# Gate 2 review r209 -- "rank = 13 EXACTLY", claims 1 and 2

Commits under review: [304d7ca](../scripts/runs/run_n5_assemble.py), f2eeda4, 584c9c9. Reviewer 210 runs claims 3-6 concurrently.
Scripts: [scripts/reviewers/r209/](../scripts/reviewers/r209/). Log: [agent_logs/gate2_209.log](../agent_logs/gate2_209.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | attained-cap: "sampling and reduction only LOSE rank", both uses | **upheld as stated in the asserts, over-stated in the prose** -- the bound is conditional on equivariance of the copy identification, and a witness where sampling RAISES the rank is exhibited |
| 2a | the expansion at W_0 is rank one in (copy, position) | **upheld, EXACTLY over Q(i)**, by a route that needs no expansion |
| 2b | T a = 0 is equivalent to "the cubics lie in K" | **upheld**, two independent proofs; the shipped vector is the only one of the three tried that can work |
| 2c | the code's choice of a single position t | **cannot change the subspace**; verified on every position of every block, and T rebuilt from the last and the middle position gives 0/47 and rank 13 |
| -- | bonus: the 16 / 25 / 47 / 36 bookkeeping (claim 5) | **confirmed exactly over Q(i)**, from a measured rank rather than the quoted dim V^H = 1 |

Nothing here refutes the theorem. Two things are weaker than the record says, both recorded below.

## What made this cheap, and mostly exact

W_0^3 has support **4 monomials**, all in the single Sym^3 weight class (0,0). So the whole restriction question is one 234 x 234 solve, and every inner product against W_0^3 costs four `sym3_ip` calls. Everything in claim 2 was recomputed at a prime unrelated to the shipped one -- 1000003, which is 3 mod 4, so F_p[i] is a FIELD rather than F_p x F_p -- and the parts that matter were done exactly over Q(i).

## Claim 1 -- the attained-cap argument

### The inequality is right, and the two uses are the SAME direction

Let U be the 89 real Hermitian unknowns, mu : U -> (Sym^6 W*)^{O(5)} the map sending a Gram to its sextic. For a point W the sampled row is the covector

    ell_W(P) = (mu P)(W) = (mu^* ev_W)(P),

so every row lies in mu^*(S^*), of dimension rank(mu). Hence

    rank of the sampled matrix = dim span{ell_W} <= rank(mu),

and reduction mod p loses rank again, since a nonzero r x r minor mod p lifts. Both uses run this way: the cap is a theorem (surjectivity of Sym^2(Sym^3) -> Sym^6 for 14; vanishing at W_0 for 13), the sample supplies the lower bound, and **no step anywhere needs the reverse inequality**. The brief's "is the monotonicity right in BOTH directions used" has the answer that only one direction is ever used, twice.

The restricted case is the same statement pulled back: with P = T^T P' conj(T) one has sum_ij P_ij B_ij = sum_ab P'_ab H_ab, so ell'_W = iota^*(ell_W) and span{ell'} = iota^*(span{ell}).

### The Hermitian coordinates cannot inflate anything

Taking (P_ii, Re P_ij, Im P_ij) is an R-linear isomorphism from the Hermitian matrices onto R^{m^2}, and the pairing is tr(P B) = sum_i P_ii B_ii + 2 sum_{i<j} (Re P_ij Re B_ij + Im P_ij Im B_ij). The shipped row drops the factor 2, which rescales the unknowns and leaves the rank alone. The one coordinate that would be extra -- Im B_ii -- is never emitted. So the coordinate map is injective on functionals and surjective onto their coordinates: no inflation.

### T is a mod-p object, and that is still sound

The restriction is built from u read off the expansion MOD P, so the reader should check that the restricted matrix is the reduction of a rational one. It is: the pivot u_k is nonzero mod p by construction, so the rows e_i - (u_i/u_k) e_k reduce from the same rational rows, and the reduction of the rational hyperplane {e : e^T a = 0} has dimension m-1 and sits inside {e : e^T u = 0}, which also has dimension m-1 -- so they agree even if some a_i happens to vanish mod p. Hence rank_p(restricted) <= rank_Q(restricted) <= 13 holds.

### Where it is over-stated: the bound is CONDITIONAL, and a witness exists

"Evaluation at points can only LOSE rank" is written in the file as if it were a property of sampling. It is not. It is the statement that each row is a pullback, and that needs **B_ij(W) to be an invariant function of W**, which needs the copies of a block identified equivariantly -- one word list per block, the thing [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) was written to enforce.

[scripts/reviewers/r209/inflate.py](../scripts/reviewers/r209/inflate.py) exhibits the failure in the smallest model with room for it: G = S_3 on R^3, cubics Sym^3(R^3), multiplicities 3 / 1 / 3, sum m^2 = 19 unknowns, and dim (Sym^6 R^3)^{S_3} = 7 monomial orbits as the cap.

| pipeline | B invariant | sampled rank | cap | multi-probe h |
|---|---|---|---|---|
| copies from the matrix-coefficient projectors | 36/36 | **7** | 7 | agrees |
| copy 1 of the standard block given its own position list | 12/36 | **10** | 7 | DISAGREES |

So a single example where sampling raises the rank does exist, and the brief is right to ask for it. What it refutes is the unconditional wording, not the argument: the shipped code's `assert rr <= 13` says the right thing -- a rank above the cap "indicts the pipeline rather than the theorem" -- and the guard that excludes the mechanism is the multi-probe Schur test, `dis == 0` with `skipped == 0` at every position. That test is load-bearing for the rank cap, and the file does not say so.

### Second gap: B Hermitian is asserted for h and never for B

The stage-3 docstring lists "B must be HERMITIAN at every sample point" among the checks. Stage 5 does not run it; `herm_row` silently drops `H[i][i][1]`. It is true structurally -- Q_ts = <c0[t], c0[s]> is Hermitian, and G_ij = sum x_it conj(x_js) Q_ts inherits it -- and I verified it: Q is Hermitian on every block, G(W_0) is Hermitian on every block, and across 22 independent sample points there is no non-Hermitian Gram entry. Dropping Im B_ii can only lose information, so the direction of the bound survives even if it failed; but the check the docstring advertises is still not the check that runs.

### What attainment does not buy

Attainment is not self-validating. rank_sampled = 13 forces rank(mu') = 13 only under the preconditions above, and a defect that lands the rank exactly ON the cap is invisible -- both caps are derived from theory, so the run has no independent oracle for the number it prints. The history in f2eeda4 is the good case: three wrong restrictions all came out at 14 against a cap of 13, i.e. ABOVE the cap, where the assert can see them. A wrong restriction that came out at 13 would have been accepted.

## Claim 2 -- the restriction T

### 2a. Rank one at W_0, exactly, without expanding anything

The K-condition on a multiplicity vector d is a statement about VALUES: d gives a cubic of K exactly when sum_i d_i <R_i[t], W_0^3> = 0 for every position t (positions of nonzero weight are automatic, since W_0^3 sits in weight (0,0)). Those covectors are exactly computable -- four `sym3_ip` calls each. [scripts/reviewers/r209/claim2.py](../scripts/reviewers/r209/claim2.py) computes the matrix W_lambda = [<R_i[t], W_0^3>] over Q(i) and takes its rank exactly:

    rank 1 on all 16 blocks with lambda_2 even,  rank 0 on all 8 with lambda_2 odd.

Now W_lambda = Q conj(X)^T h^T with X the expansion, Q the position Gram and h the multiplicity Gram, both Grams of linearly independent vectors under a positive definite form, hence invertible. So **rank(X) = rank(W_lambda) = 1 exactly** -- the rank-one claim, proved rather than sampled, and with dim V(lambda)^H = 1 as a consequence rather than an input. Independently, mod p, every nonzero column of X is a multiple of the first on every block.

### 2b. T a = 0 is the K condition -- two proofs

**Convention-free.** G(W_0) = c a a^* with c = ||v_0||_Q^2 > 0 (measured: `= c a a*` true and c nonzero on all 16 blocks; G(W_0) = 0 identically on the 8 odd blocks). A Gram P = sum_k e^k e^{k*} gives the sextic value c sum_k |(e^k)^T a|^2 at W_0, which vanishes iff every e^k is bilinearly orthogonal to a. Every Gram of K-cubics has a sextic vanishing at W_0, so the K hyperplane sits inside {e : e^T a = 0}; both have codimension exactly 1 per even block, by the exact rank above; so they are equal. This uses no convention about which coordinates the Gram is written in.

**In coordinates.** For F = (sum_j d_j m_j) (x) v one has <W^3, F> = sum_i (h conj(d))_i <X_i, v>_Q, so the Gram-index coordinate is e = h conj(d). The K condition d^T (h conj(a)) = 0 becomes conj(e)^T h^{-1} h conj(a) = conj(e^T a) = 0: **the multiplicity Gram and the conjugation cancel exactly**, which is why the shipped combination -- expansion vector, unconjugated -- is right and why the two attempts that used one of the two are not. Checked: conj(h^{-1} w) is proportional to a on all 16 blocks.

**And the failed attempt is localised.** The raw value vector w = <R_i, W_0^3> is proportional to a on exactly the 8 even blocks with m = 1, where the restriction kills the block whatever normal is used, and differs from a on **all 8 even blocks with m >= 2** -- every block where the choice has content. So attempt 2 was wrong on every block that matters, which is consistent with its 20/47 and its rank 14.

### 2c. The choice of t cannot change the subspace

It cannot, and for a reason stronger than the comment in the file gives. The comment argues from equivariance that "the RATIOS across copies do not depend on t". The fact is rank(X) = 1, proved exactly above, so every nonzero column of X is a multiple of every other. Verified two ways: directly, mod p, on every one of the 148 zero-weight positions across all 24 blocks (zero columns not proportional to the first); and operationally, by rebuilding T from the LAST and the MIDDLE admissible position and re-running the restricted rank.

The file never checks rank-oneness. It does not have to, but the reason is worth recording: the 0/47 diagnostic **is** the rank-one test. T annihilates exactly the line spanned by u, so H(W_0) = T G(W_0) T^* = 0 iff T x_{.,t} = 0 for every position t iff every column of X is a multiple of u. The diagnostic therefore validates the choice of t a posteriori, and would fire on any block whose expansion was not rank one.

## Independent reproduction of both numbers

[scripts/reviewers/r209/ranks.py](../scripts/reviewers/r209/ranks.py) rebuilds the whole of stage 5 -- own prime (1000003), own pair arithmetic, own weight-block factorisation, own 22 sample points, own restriction -- and reads off:

| quantity | shipped ([agent_logs/n5_fixed.log](../agent_logs/n5_fixed.log), p = 1000033, 40 points) | r209 (p = 1000003, 22 points) |
|---|---|---|
| coefficients vanishing mod p | 0 | 0 |
| unrestricted unknowns / rank | 89 / **14** | 89 / **14** |
| non-Hermitian Gram entries | not checked | **0** across 22 points |
| restricted unknowns | 47 | 47 |
| row at W_0, T from the FIRST position | 0/47 | 0/47, rank **13** |
| row at W_0, T from the LAST position | not run | 0/47, rank **13** |
| row at W_0, T from the MIDDLE position | not run | 0/47, rank **13** |

Both caps are attained on independent data, and the position used to build T is immaterial in fact as well as in principle.

## One ambiguity in the bookkeeping: the two 16s are different sets

The comment above the restriction says the orbit condition kills "one multiplicity in each of the 16 blocks with lambda_2 even", and then that "25 multiplicities survive across 16 blocks". The run prints the second count. **They are not the same 16.** Of the 24 blocks, 16 have lambda_2 even and 8 of those have multiplicity 1, so the restriction annihilates them completely and `TR[lam]` is empty; `herm_row` skips them. What survives is 8 even blocks plus the 8 blocks with lambda_2 odd, which carry no condition at all. The equality of the two counts is a coincidence, and the sentence reads as though one set were the other. The shape it produces -- nine scalars, five 2x2, two 3x3 -- is confirmed exactly, and it mixes restricted even blocks with unrestricted odd ones.

## Recommendations

1. Say in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) that "sampling only loses rank" is conditional on the copies being identified equivariantly, and name `dis == 0` as the guard. As written, the sentence reads as unconditional and it is not.
2. Either run the Hermitian check on B that the stage-3 docstring advertises, or delete the sentence.
3. Separate the two 16s in the comment above the restriction; as written they read as one set.
4. The 16 / 25 / 47 / 36 bookkeeping now has an exact derivation from rank([<R_i[t], W_0^3>]) that does not quote dim V(lambda)^H = 1 or a mod-p Gram rank of 3570. It is 20 lines and exact; it is a better foundation than the quote.
