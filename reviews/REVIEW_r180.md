# Gate 2 adversarial review 180, the n>=12 orbit reduction, and the degree-six constraint count

Everything below was re-derived from the definitions before the record's numbers were consulted. Scripts are in [scripts/reviewers/r180/](../scripts/reviewers/r180/); the working log is [agent_logs/gate2_180.log](../agent_logs/gate2_180.log). Tooling checked first: Python 3.9.6, sympy 1.14.0, numpy 2.0.2, SageMath 10.9 present. The machine holds 16 GB; the heaviest run here peaked at 382 MB, and the degree-six count peaked in the low tens of MB.

The whole review rests on one toolkit, [wtlib.py](../scripts/reviewers/r180/wtlib.py), which builds the Weyl module from its definition (`Sym^2(Lambda^2 V) - Lambda^4 V - Sym^2 V`) as a weight-multiplicity dictionary, and never materialises a vector space. It was validated before use: it returns dim W_n = n(n+1)(n+2)(n-3)/12 at n = 5, 6, 7, 8, 10, 12; it reproduces the record's ground-truth sequence **1, 1, 4, 5, 14** for dim (Sym^k W_5)^{O(5)}, k = 2..6; it reproduces all 24 B_2 block dimensions; and it reproduces dim (Sym^k Sym^2_0 R^n)^{O(n)} = the number of partitions of k into parts 2..n at n = 5, 6, 8, 10 for k up to 8, which is an exact independent ground truth ([validate_invariants.py](../scripts/reviewers/r180/validate_invariants.py)).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | The stable-range condition n >= 4k; 89 is only an upper bound at n=12 | **Half confirmed, half refuted.** The threshold is right for the *block table*, n=12 and n=14 agree exactly, n=10 does not. The bound is far too weak for the *invariant count*, and the open question it named is now closed: **89 is attained at n = 12** |
| 2 | The orbit-reduction asymmetry at n >= 12 | **Conclusion confirmed with a number; stated mechanism refuted.** Not "a larger H has fewer invariants", both stabilisers are spherical and dim V_lam^H <= 1 on *both* sides. **23 of the 71 blocks carry an invariant, total multiplicity 65: 477 -> 412, and 477 -> 438 once the factor swap is used** |
| 3 | The (4,1)/(3,3) weight-disjointness | **Conclusion right, both stated reasons wrong.** The two modules share **45** weights; and disjointness is not what makes the quartic unnecessary |
| 4 | The n=12 separation as now stated | **Sound except one false identity**: p_12 is not Pf^2 (independently caught by reviewer 179 mid-run) |
| 5 | The rank-3570 squeeze | **Conclusion sound; the restatement omits the step that carries it.** 178's group elements are native F_p points, so "a mod-p rank is a lower bound for the char-0 rank" does not apply to that matrix as written |
| 6 | [sym3_blocks_from_scratch.sage](../scripts/runs/sym3_blocks_from_scratch.sage) depends on nothing the record supplies | **Refuted, with a witness.** It hardcodes the record's highest weight, and the decoy V_(2,1) (also of dimension 35), gives 20 blocks / 62 multiplicities / 168 unknowns |
| 7 | A route to the degree-six O(12) invariant count that fits this machine | **Delivered.** 52 seconds, a few MB, and the answer is 89 |

---

## Claim 2, the orbit reduction at n >= 12, settled with numbers

### The block table, rebuilt from scratch

[sym3_d6_blocks.py](../scripts/reviewers/r180/sym3_d6_blocks.py) takes the character of W_12 from the definition, forms Sym^3 by Newton from the Adams operations, and peels it by the Racah alternating sum m_lam = sum_w det(w) * chi(lam + rho - w rho) over all 23040 elements of W(D_6). It reproduces the record entry for entry: **77 SO(12) constituents, 71 O(12) blocks, 184 multiplicities, 477 unknowns, largest block 9x9**, with sum m_lam d_lam = 733 813 080 = C(1640,3) exactly and dim (Sym^3 W_12)^{SO(12)} = 2. The twelve chiral constituents are the six pairs the record names, one of them ((2,2,1,1,1,+-1)), at multiplicity 2 and the other five at multiplicity 1, which is what makes 191 SO-multiplicities into 184 O-multiplicities.

### The mechanism the plan gives is not the one operating

[plan.md](../plan.md) argues that the cut is weaker at n=12 because "a larger H has fewer invariants", and worries that "V_lam are also far larger at n=12". Neither consideration decides anything, because **both stabilisers are spherical subgroups and the invariant dimension is capped at 1 on both sides.**

- At n=5, H^0 = U(2) sits in SO(5) with SO(5)/U(2) = CP^3. I computed dim V_lam^{U(2)^0} by the equal-rank Racah formula, U(2) and SO(5) share a maximal torus, so mult_0 = sum_{u in W_H} det(u) * m_V(rho_H - u rho_H) with rho_H = (1/2,-1/2), and it is **1 for every one of the 24 blocks**, without exception. The record's rule "1 iff lambda_2 is even" is the *disconnected* answer; the connected group already gives a multiplicity-free branching.
- At n=12, O(6) x O(6) inside O(12) is a **symmetric** subgroup: it is the fixed group of conjugation by diag(I_6, -I_6), and O(12)/(O(6) x O(6)) is the real Grassmannian Gr_6(R^12). Cartan-Helgason therefore caps dim V_lam^H at 1 there too, and the classical decomposition of L^2(Gr) says the cap is attained exactly on the labels with **every part even**.

So the size of V_lam is irrelevant, and so is dim H. What changes between the two dimensions is the *selection rule*: at n=5 it constrains one label ("lambda_2 even", 16 of 24 blocks, 67%), at n=12 it constrains all six ("every part even", 23 of 71 blocks, 32%).

I did not take the Grassmannian theorem on trust. [sym3_d6_blocks.py](../scripts/reviewers/r180/sym3_d6_blocks.py) computes dim V_lam^{SO(6) x SO(6)} for all 77 SO(12) constituents by the same equal-rank Racah sum, with W_H = W(D_3) x W(D_3) of order 576 and rho_H = (2,1,0 | 2,1,0). The answer is **1 exactly on the all-even labels and 0 on every other**, 77 out of 77, and the aggregate dim (Sym^3 W_12)^{SO(6) x SO(6)} = 66 comes out the same whether summed over blocks or read straight off the Sym^3 character. The two chiral halves of [2,2,2,2,2,2] each carry an SO(6) x SO(6) invariant, which is the index-2 factor between SO(6) x SO(6) and S(O(6) x O(6)).

### The number

**Exactly 23 of the 71 blocks carry an O(6) x O(6) invariant, and their multiplicities sum to 65.**

| |lambda| | blocks (multiplicity) |
|---|---|
| 0 | ()_2 |
| 2 | (2)_3 |
| 4 | (2,2)_8, (4)_3 |
| 6 | (2,2,2)_6, (4,2)_7, (6)_1 |
| 8 | (2,2,2,2)_4, (4,2,2)_8, (4,4)_4, (6,2)_2 |
| 10 | (2,2,2,2,2)_1, (4,2,2,2)_3, (4,4,2)_3, (6,2,2)_1, (6,4)_1 |
| 12 | (2,2,2,2,2,2)_1, (4,2,2,2,2)_1, (4,4,2,2)_2, (4,4,4)_1, (6,2,2,2)_1, (6,4,2)_1, (6,6)_1 |

Each such block can lose at most one multiplicity, so

> **184 multiplicities -> at least 119, and 477 unknowns -> at least 412: a cut of at most 13.6%, against 44.6% at n=5.**

### And the true stabiliser makes the cut smaller still

Stab_{O(12)}(W*) is larger than O(6) x O(6): it contains the isometry sigma exchanging the two R^6 factors, which preserves the Weyl tensor of a *balanced* product. Under the model P = 2*Pi_A - I of a Grassmannian point, sigma sends A to A-perp and P to -P; the [2mu] line first appears among polynomials of degree |mu| in P and is a sigma-eigenvector, so **sigma acts on it by (-1)^{|mu|} = (-1)^{|lambda|/2}**. Two independent hand checks agree: Sym^2_0(R^12) has the O(6) x O(6) invariant diag(I_6, -I_6), which sigma negates (|lambda|/2 = 1), and W_12 has the invariant W* itself, which sigma fixes (|lambda|/2 = 2); the rule also reproduces the correct answers for [4] and [6] of O(4).

That keeps only the 14 blocks with |lambda| divisible by 4, of total multiplicity 39:

> **477 unknowns -> at least 438: a cut of at most 8.2%.**

### Where that leaves the record

The plan's operative sentence ("the 477 should be treated as close to the real unknown count until the branching is done"), is **right, and now has a bound**: the surviving unknown count at n = 12 lies in **[438, 477]**, against 89 constraints. Its stated reason should be replaced by the sphericity argument above.

One caution carries over from reviewer 177 and bites harder here. Frobenius reciprocity bounds the evaluation map by dim V_lam^H; it does not force the rank to be 1 rather than 0. At n=5 that gap was closed by measuring the orbit span against a cap of 3570. The corresponding cap at n=12 is the sum of the 23 all-even dimensions, **177 138 092**, so the same measurement is not available. Every figure above is therefore an upper bound on the cut and a lower bound on the unknowns.

---

## Claim 1, the stability threshold, and the number it was hiding

### The threshold is right for the block table

I ran the same from-scratch pipeline at n = 10 and n = 14 ([stability_scan.py](../scripts/reviewers/r180/stability_scan.py)).

| n | O(n) blocks | multiplicities | unknowns | all-even blocks / their multiplicity |
|---|---|---|---|---|
| 10 | 64 | 182 | **493** | 21 / 63 |
| 12 | 71 | 184 | 477 | 23 / 65 |
| 14 | 71 | 184 | 477 | 23 / 65 |

The n=12 and n=14 label sets and multiplicities are **identical, entry for entry**, and no n=14 label has a seventh row, so the count is stable from n=12 and nothing splits above it, exactly as reviewer 167 said. At n=10 the table is genuinely different: seven fewer blocks, and the modification rule concentrates multiplicity onto the survivors, so the *unknown count goes up* to 493. So n >= 4k is the correct threshold at k=3, and n=12 is marginal in the sense claimed.

### The bound is far too weak for the invariant count, and 89 is attained

The plan carries the same n >= 4k reasoning to k=6, reads off n >= 24, and concludes that 89 is only an upper bound at n=12 with attainment "OPEN", adding that fewer constraints "loosens the problem rather than tightening it". That inference is valid but the question is now closed the other way.

| n | k=2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| 5 | 1 | 1 | 4 | 5 | 14 |
| 6 | 1 | 2 | 6 | 13 | 45 |
| 8 | 1 | 2 | 7 | 18 | 82 |
| 10 | 1 | 2 | 7 | 19 | 88 |
| 11 | 1 | 2 | 7 | 19 | 88 |
| **12** | 1 | 2 | 7 | 19 | **89** |
| 13 | 1 | 2 | 7 | 19 | 89 |
| 15 | 1 | 2 | 7 | 19 | 89 |

> **dim (Sym^6 W_12)^{O(12)} = 89 exactly. The stable value is attained at n = 12, and item 3c's SDP is 477 unknowns against 89 constraints as originally stated.**

Two independent confirmations. First, dim (Sym^6 W_n)^{O(n)} is non-decreasing in n, because W_n embeds in W_{n+1} by padding and metric contractions restrict compatibly, so every relation among contraction schemes valid at n+1 is valid at n; the odd dimensions n=11 and n=13 need no component correction (O = SO x {+-I} and -I acts trivially on W), give 88 and 89, and squeeze n=12 into [88, 89]. Second, the direct computation at n=12 lands on 89.

Two riders worth recording.

- **The SO(12) count is 92, not 89.** Three degree-six invariants are det-twisted, Pfaffian-type contractions that O(12) rejects and SO(12) keeps. If the Gram matrix is only required SO(12)-invariant, which is the 485-parameter reduction the plan mentions as "valid, merely coarser", the constraint count is **92**.
- **n >= 4k is sufficient, not necessary, for the invariant count.** It demands n >= 20 at k=5 and n >= 24 at k=6; the true onsets are n=10 and n=12.

---

## Claim 3, the weight-disjointness is false, and it is not what saves the method

Three separate points, in [claim3_weights.py](../scripts/reviewers/r180/claim3_weights.py).

**The root expansion is wrong.** (3,3) - (4,1) = (-1,2) = -alpha_1 + **alpha_2**, not -alpha_1 + 2 alpha_2, which is (-1,3). The companion (4,1) - (3,3) = (1,-2) = alpha_1 - alpha_2 is right. Since what matters is only the presence of a negative coefficient, the conclusion drawn (neither highest weight is a weight of the other module), survives.

**"Their Sym^3 weight spaces are disjoint" is false.** V_(4,1) has 57 distinct weights and V_(3,3) has 49; **45 of them are shared**, including (0,0), (1,1), (2,2), (3,1) and the whole box down to (-3,-2). What is true is the far narrower statement that (3,3) is not a weight of V_(4,1) and (4,1) is not a weight of V_(3,3), which follows from neither dominating the other, and which says nothing about the rest of the weight lattice.

**And that statement is not what makes the quartic unnecessary.** The weight-(4,1) space of Sym^3(W_5) is **46-dimensional**, of which only 2 belong to the block (4,1). The other 44 come from thirteen *other* blocks ((4,2), (4,3), (4,4), (5,0), (5,1), (5,2), (5,3), (5,4), (6,0), (6,2), (6,3), (6,4), (6,6)), none of which shares (4,1)'s Casimir value. The highest-weight construction already discards all 44. It does so because ker(e_1) ∩ ker(e_2) on the weight-lambda space of *any* finite-dimensional module is exactly the multiplicity space M_lambda, a fact that never consults a Casimir eigenvalue. That, and not disjointness, is why no Casimir coincidence can reach the method, and it would hold even if (3,3) did contribute to the weight-(4,1) space.

So: the quartic generator is genuinely unnecessary for the highest-weight route, and the record's argument for it is a non-sequitur built on a false statement.

---

## Claim 4, sound, with one false identity

Checked step by step. rho(D_6) = (5,4,3,2,1,0) has rho_6 = 0, so ell_6 = lambda_6. p_{2k}(ell) = p_k(ell^2), so p_2, p_4, ..., p_12 are p_1, ..., p_6 in the variables ell_i^2 and Newton returns every e_1, ..., e_6, recovering the multiset {ell_i^2}. The ordering that turns the multiset back into a label holds: ell_1 > ... > ell_5 = lambda_5 + 1 > |lambda_6| = |ell_6| >= 0, because |lambda_6| <= lambda_5. The degrees agree: W(D_6) has basic degrees 2, 4, 6, 8, 10 and 6 (the Pfaffian), W(B_6) has 2, 4, 6, 8, 10, 12.

**p_12 = Pf^2 is false.** Pf^2 = e_6(ell^2) and p_12 = p_6(ell^2) are different polynomials, at ell = (1,2,3,4,5,6) they read 518 400 and 2 438 235 715 ([claim4_p12.py](../scripts/reviewers/r180/claim4_p12.py)). What is true is that Newton makes either one complete the list, since 6 e_6 = e_5 p_1 - e_4 p_2 + e_3 p_3 - e_2 p_4 + e_1 p_5 - p_6. Reviewer 179 reached the same point and the record was corrected during this run; the correction as it now stands in [findings/sym3-blocks.md](../findings/sym3-blocks.md) is right.

---

## Claim 5, the conclusion holds; the one-line restatement does not carry it

The cap reproduces exactly: the sixteen n=5 blocks with lambda_2 even have dimensions summing to **3570**.

The record's restatement is "a mod-p rank is a *lower* bound for the characteristic-zero span". For the reduction of a fixed integer matrix that is correct. **It does not apply to the matrix 178 actually built.** [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) draws A as a random skew matrix over F_46337 and sets g = (I - A)(I + A)^{-1}: these are native F_p points of O_5, not reductions of rational orthogonal matrices, so there is no char-0 matrix of which the Gram is the reduction. The char-0 cap is also derived from complete reducibility and Frobenius reciprocity, neither of which survives into characteristic p.

The argument is nonetheless sound, by a step the record does not state. The orbit span is the image of a morphism defined over Z[1/2] (W_0 is integral, and O_5 is smooth over Z[1/2]) so dim S(k) is the rank of a matrix with entries in Z[1/2][O_5], and rank can only drop under reduction. Hence

    3570 = rank_{F_p}(Gram)  <=  dim S(F_p-bar)  <=  dim S(C)  <=  3570,

and the squeeze closes. That middle inequality is the whole content, and it is what should be written down; "a mod-p rank is a lower bound for the char-0 rank" is a different statement that happens to have the same shape.

---

## Claim 6, refuted, with a witness

[sym3_blocks_from_scratch.sage](../scripts/runs/sym3_blocks_from_scratch.sage) opens `W5 = B2(0, 4)` with the comment that [2,2] = 4 omega_2, and its only guard is `assert W5.degree() == 35`. That is precisely the check [findings/sym3-blocks.md](../findings/sym3-blocks.md) documents as insufficient, omega_1 + 2 omega_2 = (2,1) also has dimension 35. So the script's header claim that it "depends on nothing the record supplies" is false: it imports the record's identification of the module and asserts nothing that could catch a wrong one.

The dependency is load-bearing, not cosmetic. [n5_from_definition.py](../scripts/reviewers/r180/n5_from_definition.py) runs the same decomposition on the decoy:

| module | blocks | multiplicities | unknowns | distinct c_2 |
|---|---|---|---|---|
| V_(2,2), the true W_5 | 24 | 41 | 65 | 21 of 24 |
| V_(2,1), also dimension 35 | 20 | 62 | **168** | 18 of 20 |

The same script settles the module without asserting anything: building W_5 as Sym^2(Lambda^2 R^5) - Lambda^4 R^5 - Sym^2 R^5 gives highest weight **(2,2)**, and peeling its Sym^3 returns the record's 24-block table exactly, all 24 labels, all multiplicities, all dimensions, 41 multiplicities, 65 unknowns, 21 distinct Casimir values. **The record's table is right; this script is not what establishes it.** The working tree now carries a Casimir guard added mid-run, which is an improvement but still asserts the record's answer rather than deriving the module, the fix is three lines of character arithmetic.

---

## Claim 7, the cheap route exists, and it produced the 89

The Adams route blows memory at D_6 because it materialises Sym^6, some 1.97 x 10^7 weights. **h_k is a W-invariant character, so Newton's recursion k h_k = sum_j p_j h_{k-j} can be carried on dominant weights alone**: h_{k-j}(mu - nu) equals h_{k-j} at the dominant representative of mu - nu, so every intermediate value can be looked up after a sort. [dominant_sym.py](../scripts/reviewers/r180/dominant_sym.py) stores **1970 numbers** for k=6 at D_6 and finishes in 52 seconds. The trivial multiplicity then comes from the Racah alternating sum sum_w det(w) h_k(rho - w rho) over the 23040 elements of W(D_6).

That gives the SO(n) count. For even n the O(n) count needs the integral over the other component, and it has a clean form. An element of O(2r)^- has eigenvalues {t_j, t_j^{-1}} for j < r together with +1 and -1; Ad is Lambda^2 of that, so the twisted Weyl density is

    prod_{alpha in D_{r-1}} (1 - t^alpha) * prod_j (1 - t_j^2)(1 - t_j^{-2})  =  prod_{alpha in C_{r-1}} (1 - t^alpha),

because {+-e_i +- e_j} together with {+-2e_j} is exactly the root system C_{r-1}. So **the integral over the non-identity component of O(2r) is a Weyl integration for C_{r-1}**, and reduces to another Racah sum over W(C_{r-1}). [coset_o.py](../scripts/reviewers/r180/coset_o.py) implements it and [coset_validate.py](../scripts/reviewers/r180/coset_validate.py) checks it at n = 4, 6, 8 against the exact O(n)-invariant counts of Lambda^2, including the degrees where the Pfaffian makes SO and O differ, 0, 1, 0, 2 recovered every time.

Together they give the whole table in claim 1 above, on this machine, in under two minutes per dimension.

---

## What the record should change

1. **[plan.md](../plan.md), the n>=12 orbit-reduction paragraph.** Replace "a larger H has *fewer* invariants, so fewer blocks are cut" with the sphericity argument: both stabilisers are spherical, dim V_lam^H <= 1 on both sides, and the selection rules differ, "lambda_2 even" at n=5 against "every part even" at n=12. Record the numbers: 23 of 71 blocks, multiplicity 65, unknowns in [438, 477], and the cap 177 138 092 that makes the n=5 rank measurement unavailable here.
2. **[plan.md](../plan.md), the 89.** It is attained at n=12; the sequence in n is 14, 45, 82, 88, 88, 89, 89, 89 at n = 5, 6, 8, 10, 11, 12, 13, 15. Retire "whether it is attained is OPEN" and the "more under-determined" reading with it. Add that the SO(12) count is 92.
3. **[plan.md](../plan.md) and [findings/sym3-blocks.md](../findings/sym3-blocks.md), the (4,1)/(3,3) paragraph.** The modules share 45 weights; delete "their Sym^3 weight spaces are disjoint", fix -alpha_1 + 2 alpha_2 to -alpha_1 + alpha_2, and give the real reason, ker(e_1) ∩ ker(e_2) at weight lambda is M_lambda in any module, so the construction never reads a Casimir.
4. **[findings/sym3-blocks.md](../findings/sym3-blocks.md), the orbit constraint.** State the semicontinuity step that carries the 3570 squeeze, since the group elements are native F_p points.
5. **[sym3_blocks_from_scratch.sage](../scripts/runs/sym3_blocks_from_scratch.sage).** Build the module from Sym^2(Lambda^2) - Lambda^4 - Sym^2 and read its highest weight, rather than asserting it.
