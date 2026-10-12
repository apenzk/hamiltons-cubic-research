# Gate 2 review r239 -- claims 1, 2, 6 (the counts)

Reviewer 239. Brief: brief25.md. Commits under review: ade3158, b5dedf3, 762593e. Primary file: [scripts/runs/run_a1_canonical_lift.py](../scripts/runs/run_a1_canonical_lift.py).

## Verdict table

| Claim | Statement | Verdict |
|---|---|---|
| 1 | dim (Sym^6 Weyl_n)^{O(n)} = 89 stably; sequence 0,1,2,7,19,89 | **CONFIRMED** by a third route |
| 2 | 89 on all of [12, infinity) by padding monotonicity | **VALID** -- no dip is possible, and 13..23 needs no check |
| 6 | dim (Sym^6 Weyl_n*)^{B_n} = 339,423 stationary from n = 12; post F32 | **CONFIRMED**, with one bookkeeping slip and one precision note |

---

## Claim 1 -- CONFIRMED. The universal count is 89, on a third route.

**Script:** [scripts/reviewers/r239/c1_haar_moments.py](../scripts/reviewers/r239/c1_haar_moments.py), guards in [c1_guards.py](../scripts/reviewers/r239/c1_guards.py) and [c1_deg24_controls.py](../scripts/reviewers/r239/c1_deg24_controls.py).

The route is Haar integration over O(n) at large fixed n. It shares no ingredient with r238's Hall pairing or r224's Littlewood restriction rule: no Schur functions, no plethysm, no branching rule, no even-partition criterion, and no `omega_(2,2) = s_(2,2) - s_(2)` identity.

**Step 1 -- the Weyl character from definitions, as a polynomial in traces of powers.** Algebraic curvature tensors are `S^2(Lambda^2 V)` minus the first Bianchi piece `Lambda^4 V`; removing traceless-Ricci and scalar leaves the Weyl space. With `p_j(g) = tr(g^j)`,

    chi_W = ( e_2^2 + e_2(g^2) ) / 2  -  e_4  -  (p_1^2 + p_2)/2
          = p_1^4/12 - p_1 p_3/3 + p_2^2/4 - p_1^2/2 - p_2/2 .

**Step 2 -- symmetric powers by the cycle index.** `chi_{Sym^k W}(g) = sum_{rho |- k} z_rho^{-1} prod_i chi_W(g^{rho_i})`, and `chi_W(g^m)` is the same polynomial with `p_j -> p_{jm}`. So the degree-6 character is an explicit rational polynomial in `p_1..p_24`, every monomial of weighted degree exactly 24.

**Step 3 -- the integral, exactly.** By the exact-moment theorem for the orthogonal group (Diaconis-Shahshahani; Diaconis-Evans, *TAMS* 353 (2001)), for Haar `g` on O(n),

    E[ prod_j tr(g^j)^{a_j} ] = E[ prod_j (eta_j + sqrt(j) Z_j)^{a_j} ]   whenever sum_j j a_j <= n,

with `Z_j` iid standard normal and `eta_j = 1` for `j` even, `0` for `j` odd. Weighted degree 24 means the value produced is the *exact* integral for every `n >= 24` -- precisely the stable range at issue.

**Result.** The whole sequence reproduces, in exact rational arithmetic:

| k | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| dim (Sym^k W_n)^{O(n)}, n >= 4k | 0 | 1 | 2 | 7 | 19 | **89** |

**Guards, because a moment machine that is wrong everywhere would also print integers.**

- *chi_W is right.* An orthogonal projector onto the Weyl subspace of `(R^n)^{ot 4}` was built explicitly at n = 5, 6, 7 (idempotent and symmetric to 3e-16, traces 35 / 84 / 168 = `n(n+1)(n+2)(n-3)/12`), and `tr(P g^{ot 4})` at random Haar `g` agrees with the polynomial to 1e-9 in every trial.
- *The moment functional is right.* Twelve joint trace moments on O(12) and O(24) match Monte-Carlo Haar sampling (4e5 draws each) within 2 standard errors.
- *The pipeline is right at the degree that matters.* Three control representations whose stable invariant rings are known free algebras were run at weighted degree exactly 24: `Sym^24 V` gives 1; `Sym^12 S^2_0 V` gives 21 = partitions of 12 into parts >= 2; `Sym^12 Lambda^2 V` gives 11 = partitions of 12 into even parts. All three match. The controls at degree 12 (k = 6) likewise give 0,1,1,2,2,4 and 0,1,0,2,0,3, the correct generator counts.

So the certificate base is not misaimed on account of the count. **89 stands.**

## Claim 2 -- VALID. The squeeze is airtight, and there is nothing between 13 and 23 to check.

Write `m(n) = dim (Sym^6 W_n)^{O(n)}` and let `V` be the free span of the degree-6 complete-contraction diagram symbols -- perfect matchings of the 24 Weyl slots -- with `eps_n : V -> Poly_6(W_n)^{O(n)}` the evaluation at dimension n. The extension needs three things, and all three hold.

**(1) `rank eps_n = m(n)` at every n, with no stable-range caveat.** Polarising a degree-6 invariant gives a multilinear O(n)-invariant on six copies of `V^{ot 4}`; the first fundamental theorem for O(n) writes it as a combination of complete index pairings, at *every* n. So `eps_n` is surjective throughout and the rank is the dimension.

**(2) The kernels nest downward, and here is why the hazard of claim 4 does not reach it.** For `n >= n_0` the block embedding `pad : W_{n_0} -> W_n` lands in `W_n` -- the pair symmetries and first Bianchi survive verbatim, and the Ricci trace with respect to the n-dimensional metric equals the padded `n_0`-dimensional trace, hence zero. And `q_D^{(n)} o pad = q_D^{(n_0)}` for every diagram, because a complete contraction of six Weyl tensors has all 24 slots on Weyl factors: the sums run over 1..n but every term with an index above `n_0` carries a vanishing component, and **no bare metric, hence no closed loop `delta^a_a = n`, occurs anywhere**. So `ker eps_n` is contained in `ker eps_{n_0}`, and `m` is nondecreasing.

  *This is the exact condition, and it is worth stating as a condition:* fact (ii) holds for `V` **because** `V` contains no symbol carrying a detached metric loop. A symbol like r232's `q_2 + n q_1` -- reviewer 238's plant P4 -- is precisely such an object, and for it the padding identity fails and monotonicity with it. The relocated free-index problem of claim 4 lives in *covariants*, which carry free indices and can pick up bare metric pairs; the degree-6 complete contractions here cannot. The two do not interact.

**(3) Both endpoints are genuine values of `m`, not limits.** `m(12) = 89` is the record's audited row. `m(n) = 89` for **every** `n >= 24` is the claim-1 computation above -- and this matters more than it looks: the Diaconis-Evans moment identity is *exact* for `n >= 24`, so 89 is the value of `m` at 24, not merely its limit. Had 89 been available only asymptotically, monotonicity would not have pinned the interval.

**The conclusion.** `m` is nondecreasing and `m(12) = m(24) = 89`, so

    89 = m(12) <= m(13) <= ... <= m(23) <= m(24) = 89 ,

and every value in between is 89. **A dip is impossible on interval-ordering grounds alone; there is nothing to compute at n = 13..23.** Above 24, claim 1 gives 89 directly. So `m == 89` on `[12, infinity)`, the lift is canonical from 12, and the file's conclusion stands as written.

**What the argument actually rests on, stated plainly.** Only one input here is not recomputed in this review: the anchor `m(12) = 89`. Monotonicity plus `m(24) = 89` on its own gives only `m(12) <= 89`. If the record's n = 12 row were too low, the file's conclusion would fail and the canonicity base would move up to the first n at which 89 is attained. **The anchor is the single load-bearing number in claim 2, and it deserves to be labelled as such in the record**, which currently presents it as settled background.

**An empirical falsification test of fact (ii).** [c2_rank_ramp.py](../scripts/reviewers/r239/c2_rank_ramp.py) ([output](../scripts/reviewers/r239/out_c2_ramp.txt)). The containment in (2) holds on *any* subspace of `V`, so for one **fixed** set `D` of diagrams the rank of `eps_n` restricted to `span(D)` must itself be nondecreasing in n. A dip anywhere would refute (ii) outright and take the extension with it. 600 diagrams were fixed once (rejecting those whose greedy pairwise contraction schedule needs an intermediate above `n^5`, so that the same set is affordable at every n) and evaluated on random Weyl tensors at n = 6..14.

## Claim 6 -- CONFIRMED. 339,423 is right, and stationary from exactly n = 2d = 12.

**Scripts:** [c6_burnside.py](../scripts/reviewers/r239/c6_burnside.py) (table, [output](../scripts/reviewers/r239/out_c6_burnside.txt)), [c6_extend.py](../scripts/reviewers/r239/c6_extend.py) (the d=6 column pushed past r237's range), [c6_direct_n4.py](../scripts/reviewers/r239/c6_direct_n4.py) (a character-free check, [output](../scripts/reviewers/r239/out_c6_direct_n4.txt)).

Burnside over the conjugacy classes of B_n = signed permutations, indexed by pairs of partitions (positive and negative cycles), with `p_m(g) = sum_{L in lam, L|m} L + sum_{L in mu, L|m} L (-1)^{m/L}` and centralizer order `2^{l(lam)+l(mu)} z_lam z_mu`; the class character is the same cycle-index expression as in claim 1, evaluated on the chi_W polynomial that was checked there against an explicit Weyl projector.

| n | d=1 | d=2 | d=3 | d=4 | d=5 | d=6 |
|---|---|---|---|---|---|---|
| 4 | 0 | 3 | 5 | 14 | 27 | 67 |
| 5 | 0 | 3 | 9 | 60 | 350 | 2163 |
| 6 | 0 | 3 | 17 | 167 | 1989 | 26630 |
| 8 | 0 | 3 | 17 | 241 | 6014 | 231741 |
| 10 | 0 | 3 | 17 | 241 | 6511 | 335171 |
| 11 | 0 | 3 | 17 | 241 | 6511 | 339014 |
| **12** | 0 | 3 | 17 | 241 | 6511 | **339423** |
| 13 .. 25 | 0 | 3 | 17 | 241 | 6511 | **339423** |

This reproduces [scripts/reviewers/r237/out_bn_d6.txt](../scripts/reviewers/r237/out_bn_d6.txt) entry for entry on n = 4..16, and extends the d=6 column to n = 25, where it is still 339,423. Guards: the class bookkeeping is checked by `sum over classes 1/|centralizer| = 1` for n = 1..12; the standard representation reproduces `dim (Sym^d R^n)^{B_n} = #partitions of d/2 into parts <= n` for n = 2..7 and d = 1..8; and the whole n = 4 column 0, 3, 5, 14, 27, 67 is reproduced **character-free** -- the 384 elements of B_4 enumerated as signed permutation matrices, pushed through `g^{ot 4}` onto the 10-dimensional Weyl space, and the Reynolds average of every degree-d monomial evaluated at random points, the rank of that value matrix being the dimension.

**Is the corrected post right?** Its operative sentence is, and its stated reason is not the reason.

- **Right:** `24` is not a proved lower bound on the base. Proposition 2.9's `n_0 >= k_B` is a *sufficient* condition; a sufficient condition failing at 12 proves nothing about the base, and the dimension the proposition would deliver is already stationary at 12. The post's own final wording -- the consequent is "dimensionally intact at 12" -- is exactly the right strength, since a stationary dimension is necessary but not sufficient for unique extension: one still needs the restriction map to be injective, which the count alone does not give. The post does not claim otherwise.
- **The reason as written conflates two objects.** "k_B >= 24 is a generation-degree fact ... **But** the sign subgroup of B_n forces every coordinate index to even multiplicity, so a B_n-invariant of degree d has support <= 2d, never 4d." The generation-degree statement is about the **module** Sym^6(W_n): it contains `W_{1234} W_{5678} ... W_{21,22,23,24}`, support 24, which no B_n-translate of a support-<24 element reaches. The even-multiplicity statement is about the **invariants**. Both are true and they do not contradict: the "But" is rhetorical, and `k_B >= 24` as a generation degree of the module stands unrefuted. What is refuted is only its relevance.
- **One bookkeeping slip to fix.** "stationary from n = 2d in every column -- 4, 6, 8, 10, 12 for d = 1..6" gives five thresholds for six columns. The computed thresholds are exactly n = 2d, and the list 4, 6, 8, 10, 12 is the d = **2..6** list; the d = 1 column is identically 0 for every n >= 4, so its threshold is vacuous. (For n <= 3 the Weyl space is zero and the virtual character `n(n+1)(n+2)(n-3)/12` goes negative, so the table is only meaningful from n = 4.)
- **One precision note.** The support argument proves the spanning set of orbit sums is *n-independent* once n >= 2d, which gives a ceiling; padding gives `ker eps_n^B` contained in `ker eps_12^B`, so the dimension is nondecreasing. Nondecreasing plus a fixed ceiling plus the computed equality at n = 12 and n = 25 pins the value on that whole window. It does not close the statement for *every* n by pure argument -- an increase past 25 is excluded by computation up to 25 and by the regularity of the columns, not by a proof in the record. Since the number is used as evidence that 24 is unnecessary rather than as a load-bearing lemma, this costs nothing; it is worth not overstating.

**Verdict: the number is right, the stationarity threshold is right and is exactly 2d, and the corrected post has not swung too far. Its conclusion is sound; its supporting sentence should stop opposing a generation-degree fact to an invariant-support fact, and its threshold list should read d = 2..6.**
