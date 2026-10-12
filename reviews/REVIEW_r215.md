# Gate 2 review r215 -- the n=12 weight machinery (claims 1-3)

Brief: brief19.md. Commits under review: 89466b5, 3490455, 537ab39.
Files: scripts/runs/run_n12_weights.py, scripts/runs/run_n12_sym3.py, scripts/runs/run_n12_route.py.
Reviewer 216 runs claims 4-6 concurrently.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | dim V(2,2,0,0,0,0) = 1638; dominant mults 1,1,2,4,9,30 over orbits 60,480,240,12,60,1; Freudenthal recursion, `dom_rep`, descending-Casimir order | **CONFIRMED** (Sage, and the full 853-weight dictionary matches) |
| 2 | Sym^3 character by Newton; 204,205 distinct weights; peel to 77 SO(12) constituents, 191 multiplicities | **CONFIRMED** (independent character, and Racah alternation reproduces the peel exactly). One latent defect in `irr_char` -- see below |
| 3 | SO(12) -> O(12) fusion: six chirality pairs at multiplicities 2,1,1,1,1,1, giving 71/184; match with r177 | **CONFIRMED**, label and multiplicity. The det-twist hypothesis that makes 71 well-posed is missing from the file -- see below |

**Nothing in claims 1-3 is refuted.** The numbers are right, reproduced by routes that share no code with the files. What I do report are two places where the *code* is weaker than the result it produced, and one place where the record's prose is wrong.

## Independent routes used

| route | what it reproduces | shares with the file |
|---|---|---|
| Sage `WeylCharacterRing("D6")` | dim 1638, all 853 weight multiplicities | nothing |
| direct Sym^2 multiset count + Newton *recurrence* | the 204,205-weight Sym^3 character | the weight system only |
| Racah alternation over all 23,040 elements of W(D_6) | 77 constituents, 191 multiplicities | the character only, and no ordering |
| guarded Freudenthal replay of all 77 characters | the Sym^3 character reassembled weight for weight | the exact root-order test, restored |
| Sage GL plethysm `h_3[s_{2,2}]` | the full degree-12 part of the O(12) decomposition | nothing |
| Sage `symmetric_power(3)` on the D_6 character ring | 77 constituents, 191 multiplicities, block for block | nothing |

## Claim 1 -- CONFIRMED, by Sage and by a re-derivation of the two questioned steps

[scripts/reviewers/r215/c1_sage.sage](../scripts/reviewers/r215/c1_sage.sage), [c1_audit.py](../scripts/reviewers/r215/c1_audit.py).

Sage's `WeylCharacterRing("D6")(2,2,0,0,0,0)` gives degree **1638** over **853** distinct weights, with dominant multiplicities and orbit sizes

| dominant weight | mult | orbit |
|---|---|---|
| (2,2,0,0,0,0) | 1 | 60 |
| (2,1,1,0,0,0) | 1 | 480 |
| (1,1,1,1,0,0) | 2 | 240 |
| (2,0,0,0,0,0) | 4 | 12 |
| (1,1,0,0,0,0) | 9 | 60 |
| (0,0,0,0,0,0) | 30 | 1 |

which is the record's `1,1,2,4,9,30` over `60,480,240,12,60,1`, summing to 1638. The file's full 853-entry weight dictionary is **identical to Sage's**, not merely equal in total.

- **The recursion is Freudenthal's, with one bilinear form throughout.** The file computes `MULT[mu] = 2*num/den` with `num = sum_{alpha>0} sum_{k>=1} m_{dom_rep(mu+k alpha)} <mu+k alpha, alpha>` and `den = <lam,lam+2rho> - <mu,mu+2rho>`, which is `(|lam+rho|^2 - |mu+rho|^2) m_mu = 2 sum_{alpha>0} sum_{k>=1} m_{mu+k alpha} <mu+k alpha, alpha>` verbatim. All of `rho`, `casimir`, the numerator and the denominator go through the same `ip`, the ambient Euclidean form; D_6 is simply laced so every root has the same length and no coroot rescaling is owed. `rho = (5,4,3,2,1,0)` is asserted in the file and is correct for D_6, and the 30 positive roots are the full set `e_i +/- e_j`, i < j.
- **`dom_rep` is correct.** Sorting the absolute values descending and flipping the last entry when the count of negatives is odd lands in the W(D_6) orbit (permutations and an even number of sign changes) and is dominant. Verified exhaustively: on all 853 weights of the module and on all 15,625 integer vectors in [-2,2]^6, `dom_rep(nu)` is dominant, lies in `orbit(nu)`, and is the *unique* dominant element of that orbit -- zero failures. The zero-entry edge case is where an odd sign change would be fatal, and it is safe because the flip lands on a zero (-0 = 0), which is exactly when W(D_6) can absorb an odd sign change.
- **Descending Casimir is a valid processing order.** The argument: for dominant mu < lam, `casimir(lam) - casimir(mu) = <lam-mu, lam+mu+2rho>` with lam-mu a nonzero non-negative combination of positive roots and lam+mu+2rho strictly dominant, so the difference is strictly positive. Hence (i) Freudenthal's denominator never vanishes and (ii) every nu = mu + k*alpha appearing in the numerator has `dom_rep(nu) > mu`, so it has strictly larger Casimir and has already been processed. Measured: the six Casimir values 44, 40, 32, 24, 20, 0 are strictly decreasing in processing order, and replaying the recursion shows **no alpha-string truncated early** -- the `key not in MULT` break never fires on a weight of nonzero multiplicity.
- **A latent defect in `dominant_below`, harmless here.** The root-order test is "partial sums >= 0 and total even". The exact D_6 condition also requires `c_5 = S_5 - S_6/2 >= 0`, which the file omits. For lam = (2,2,0,0,0,0) it changes nothing (both tests return the same 6 weights, and neither misses any), and I prove it cannot: a spurious mu needs |mu_6| > S_5 >= 0, while dominance forces sum(mu_1..mu_5) >= 5|mu_6| and S_5 >= 0 forces that sum <= 4, so |mu_6| = 0. The same test is reused in `run_n12_sym3.py`'s `irr_char` for 77 other highest weights, where the argument does not carry -- see claim 2.

**Verdict: claim 1 confirmed.**

## Claim 2 -- CONFIRMED, and the mis-ordering question is closed by an order-free method

[c2_racah.py](../scripts/reviewers/r215/c2_racah.py), [c2_irrchar_audit.py](../scripts/reviewers/r215/c2_irrchar_audit.py), [c2_freudenthal_exact.py](../scripts/reviewers/r215/c2_freudenthal_exact.py).

**The character.** Rebuilt by a route sharing no arithmetic with the file: Sym^2 from the direct multiset count -- `m_a*m_b` for a != b and `C(m_a+1,2)` for a = b -- and then Sym^3 from Newton's *recurrence* `3 h_3 = h_2 p_1 + h_1 p_2 + p_3`, against the file's closed form `6 h_3 = p_1^3 + 3 p_1 p_2 + 2 p_3`. Sym^2 lands on 1,342,341 = C(1639,2); Sym^3 on **204,205 distinct weights** and 733,813,080 = C(1640,3); every division by 3 is exact. The two dictionaries are **identical entry by entry**, not merely equal in total. The trivial weight space is 635,220 in both.

**The decomposition, without any ordering.** Racah's alternation `m_lambda = sum_w sgn(w) chi(w(lambda+rho) - rho)` reads each multiplicity off the character on its own, over all 23,040 elements of W(D_6), with no peel and no notion of "next". Applied to the 122 dominant weights present, it returns **77 constituents with multiplicities summing to 191**, with **no negative multiplicity**, and the resulting block dictionary is **identical to the peel's**. `sum m_lambda dim V(lambda) = 733,813,080` recomputed from the Weyl dimension formula.

**Could the peel mis-order?** No, and there are two answers.
- *Structurally.* The peel takes the remaining dominant weight of largest Casimir. If a remaining dominant mu were strictly above lambda in the root order then `casimir(mu) > casimir(lambda)`, so maximal Casimir implies maximal in the root order, and no other surviving constituent can reach lambda's weight space. The multiplicity read off is therefore exactly `m_lambda`. Ties in Casimir are harmless: two weights of equal Casimir are incomparable.
- *Empirically, and this is the decisive one.* The 77 irreducible characters, recomputed under guards the file omits, **reassemble the Sym^3 character exactly, weight for weight over all 204,205 weights**. A mis-ordering that "still sums to C(1640,3)" would have to reproduce 204,205 weight multiplicities as well, and it does not get the chance -- the reassembly is exact.

**A real defect in `irr_char`, which happens not to bite.** `irr_char` reuses `dominant_below`'s incomplete root-order test (partial sums >= 0, total even) and *drops the denominator assertion* that `run_n12_weights.py` carries, writing `int(2*num/den) if den else 0`. Audited over the 77 constituents: the test admits **65 weights that are not below lambda, on 39 of the 77**, and on several of them the Freudenthal denominator is **zero or negative** -- at (2,2,2,2,2,0) it is -4, at (4,2,2,2,2,0) two denominators are non-positive. The result survives because no weight of V(lambda) lies above a weight not below lambda, so the numerator is 0 and every spurious weight is assigned 0 and then filtered by `if not m: continue`. Two hazards remain in the code as written:

1. a **negative** denominator with a nonzero numerator would silently return a negative multiplicity rather than firing an assertion;
2. `int(2*num/den)` **truncates** a non-integer Fraction instead of failing, in both files.

Replaying all 77 with the exact root-order condition, `assert den > 0` and `assert val.denominator == 1` restored: **every run passes**, each weight system sums to its Weyl dimension, and the reassembly is exact. So the two hazards are latent, not live. They should be closed anyway -- the guard `run_n12_weights.py` has is the guard that caught the earlier 65-against-1638 failure, and `irr_char` is the copy that lost it.

**Verdict: claim 2 confirmed.** 204,205 weights, 77 SO(12) constituents, 191 multiplicities.

## Claim 3 -- CONFIRMED, with one load-bearing hypothesis that the file leaves out

[c3_fusion.py](../scripts/reviewers/r215/c3_fusion.py), run against **my own** Racah blocks rather than the file's pickle.

**The six pairs match reviewer 177 exactly**, label and multiplicity:

| lambda | mult (each half) | dim (Weyl formula) | r177's dim |
|---|---|---|---|
| (2,2,2,2,2,+/-2) | 1 | 28,314 | 28,314 |
| (3,3,2,2,1,+/-1) | 1 | 2,814,669 | 2,814,669 |
| (4,4,1,1,1,+/-1) | 1 | 4,679,675 | 4,679,675 |
| (3,2,2,1,1,+/-1) | 1 | 462,462 | 462,462 |
| (4,2,1,1,1,+/-1) | 1 | 750,750 | 750,750 |
| (2,2,1,1,1,+/-1) | 2 | 21,450 | 21,450 |

Multiplicities 1,1,1,1,1,2 summing to 7, so 191 - 7 = 184 and 77 - 6 = 71. Every pair has **equal** multiplicity on its two halves -- a six-fold consistency test the decomposition had to pass and did, since Sym^3 of an O(12)-module is stable under the outer automorphism of D_6.

**The fusion rule is right, and here is why.** SO(12) has index 2 in O(12), so Clifford theory applies to the restriction of any O(12)-irreducible U.
- If `U|_{SO}` is irreducible, U and U tensor det are the two O(12)-extensions of it.
- If `U|_{SO}` is reducible it is a sum of two conjugate SO-irreducibles swapped by any g of determinant -1, and U = Ind(V_lambda) is irreducible because the two summands are non-isomorphic.

Which case occurs is decided by lambda_6. An orientation-reversing g acts on the D_6 Dynkin diagram as the outer automorphism exchanging the two spin nodes, whose effect on the ambient label is `(lambda_1,...,lambda_5,lambda_6) -> (lambda_1,...,lambda_5,-lambda_6)`. So V_lambda is g-stable exactly when lambda_6 = 0, and the pairs with lambda_6 != 0 are exactly the ones that fuse. The fused block is irreducible over O(12) by Clifford, of dimension twice the SO dimension, and multiplicities on the two halves must agree -- which is the test above.

**The gap: 71 is not determined by the SO(12) data alone, and the file does not say what closes it.** For a constituent with lambda_6 = 0, *two* O(12) labels restrict to the same SO(12) module: [lambda] and its det-twist, whose associated partition has 12 - l(lambda) >= 7 rows. If a multiplicity-4 SO block were really 3 copies of [lambda] plus 1 of [lambda] tensor det, the O(12) count would be **72 blocks with the same 184 multiplicities**, and nothing in `run_n12_sym3.py` would notice -- the script fuses on lambda_6 alone and asserts (71,184).

What closes it is a row bound. By the Newell-Littlewood rule, `N_{mu,nu,lambda} = sum_{alpha,beta,gamma} c^mu_{alpha beta} c^nu_{beta gamma} c^lambda_{gamma alpha}`, and `c^lambda_{gamma alpha} != 0` forces `l(lambda) <= l(gamma) + l(alpha) <= l(nu) + l(mu)`. Applied twice to [2,2] x [2,2] x [2,2], **every constituent of the tensor cube has at most 6 rows**, so no det-twist (which needs at least 7) can appear; all labels satisfy `lambda'_1 + lambda'_2 <= 12`, so they are in the stable range and no modification rule intervenes. Sym^3 sits inside the tensor cube, so it inherits the bound. `findings/sym3-blocks.md` states this hypothesis; `run_n12_sym3.py` does not, and it is the only reason its fusion is a computation rather than a convention.

The same bound makes three further predictions, all of which the decomposition satisfies with each bound attained: `l(lambda) <= 6` (max 6), `lambda_1 <= 6` (max 6), `|lambda| <= 12 and even` (max 12, no odd). And the constituents attaining 6 rows are **exactly the 12 chiral halves** -- which is the theory's own statement, since l(lambda) = 6 is lambda_6 != 0.

**Two corroborations of the count that do not go through the fusion rule.**
- The trivial block has multiplicity **2**, the two cubic contractions of the Weyl tensor available for n >= 6. Both are built from Weyl tensors alone with no epsilon, so both are genuine O(12) invariants -- the det block is empty, exactly as the row bound predicts at the one place it can be checked against known mathematics.
- The three top-degree pairs (2,2,2,2,2,+/-2), (3,3,2,2,1,+/-1), (4,4,1,1,1,+/-1) are the three partitions of 12 with six rows that appear in the GL plethysm, as r177 notes; that they are precisely the |lambda| = 12 chiral constituents here is an independent match.

**A wording defect in the record.** [findings/sym3-blocks.md](../findings/sym3-blocks.md) lists the six pairs and closes "at multiplicity 2", which reads as applying to all six. It applies to (2,2,1,1,1,+/-1) alone; the other five are multiplicity 1. Taken at face value the sentence gives 191 - 12 = 179, not 184. Reviewer 177's own review has the correct per-row table; the compression into the findings file lost it.

**Verdict: claim 3 confirmed**, with the recommendation that the row bound be written into `run_n12_sym3.py` beside the fusion, and the findings sentence repaired.

## Three further corroborations

**The highest weight is pinned, not merely dimension-matched.** [c1_uniqueness.py](../scripts/reviewers/r215/c1_uniqueness.py). At n=5 a dimension check could not separate [2,2] from [2,1] -- both 35 -- and only the Casimir did. At n=12 there is no such ambiguity: sweeping every dominant D_6 weight with entries in [-6,6], **(2,2,0,0,0,0) is the only one of Weyl dimension 1638**. Its Casimir is 44, which agrees with the classical `sum lambda_i(lambda_i + n - 2i)` for so(12).

**The top degree, from a GL plethysm that never touches the weight system.** [c2_plethysm.sage](../scripts/reviewers/r215/c2_plethysm.sage), [c2_topdegree.py](../scripts/reviewers/r215/c2_topdegree.py). In degree 12 the trace removal is invisible, so the |lambda| = 12 O(12) blocks of Sym^3(Weyl_12) must be the GL constituents of the plethysm `h_3[s_{2,2}]`, and every one of those has at most 3*2 = 6 rows so needs no modification rule. Sage's plethysm gives 16 constituents with multiplicities summing to 17; my Racah decomposition's degree-12 part, with each chirality pair counted once, is **identical block for block** -- including the lone multiplicity 2 at (4,4,2,2) and the three six-row labels (2,2,2,2,2,2), (3,3,2,2,1,1), (4,4,1,1,1,1) that are the top chiral pairs.

**Sage's own `symmetric_power(3)`.** [c2_sage_sym3.sage](../scripts/reviewers/r215/c2_sage_sym3.sage), [c2_sage_compare.py](../scripts/reviewers/r215/c2_sage_compare.py). Twenty-six minutes on `WeylCharacterRing("D6")(2,2,0,0,0,0).symmetric_power(3)`: degree 733,813,080, **77 constituents, 191 multiplicities**, and the block dictionary is **identical** to both mine and the file's. This is a fifth route sharing no code at all with the repository.

**The trivial block is 2.** Both the two cubic contractions of the Weyl tensor available for n >= 6, and the count `run_n12_sym3.py` implies. This is the one multiplicity in the whole table with an answer known outside this computation, and it comes out right.
