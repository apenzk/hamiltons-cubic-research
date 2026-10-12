# Gate 2 adversarial review 178, the n=5 certificate pipeline

Everything below was re-derived from the definitions before the record was opened. Scripts are in [scripts/reviewers/r178/](../scripts/reviewers/r178/); the working log is [agent_logs/gate2_178.log](../agent_logs/gate2_178.log). Tooling checked first: Python 3.9.6, sympy 1.14.0, SageMath 10.9.

A note on provenance. [findings/sym3-blocks.md](../findings/sym3-blocks.md) was rewritten *during* this run, commits e4869a4, f25586a, 5c80e5b and 20cb594, timestamped 12:33-12:35, fold my live heartbeats back into the record and attribute them to "Reviewer 178". The verdicts below therefore split into two layers: what the record said when the brief was written, and what the record says now. The second half of this review audits the *current* text, and finds two live numerical errors in it.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | The n=5 block table | **Confirmed**, by two mutually independent computations |
| 2a | Casimir separation at n=5 is a theorem | **Confirmed** as stated |
| 2b | Five Casimirs separate every O(12) block | **Argument refuted**; conclusion survives only as a finite check. Record already corrected to six |
| 3 | dim (Sym^6 Weyl_5)^{O(5)} = 14, sequence 1,1,4,5,14 | **Confirmed** |
| 4 | 41 highest-weight vectors; the Casimir alone does not validate the action | **Confirmed**, and the second half now has a proof rather than an anecdote |
| 5 | 174's branching rule and the four orbit numbers | **Confirmed**, and its one unproved link is now closed |
|, | Current text of [findings/sym3-blocks.md](../findings/sym3-blocks.md) | **One numerical error**: "22 distinct values" is 21 |
|, | Current text of [plan.md](../plan.md) line 389 | **Two errors**: 36 is a count of fibres, and two classes are five wide |
|, | n=12 section of [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) | **Stale**: still prints the refuted five-Casimir prose |

## Claim 1, the block table, recomputed twice

The brief flags that the twelve multiplicity-1 blocks were solved for from a recorded spectrum rather than computed. I computed the plethysm two ways, sharing no code with the record and no code with each other.

- **Method A**, [sym3_decomp.sage](../scripts/reviewers/r178/sym3_decomp.sage): Sage's `WeylCharacterRing("B2")`, `V = B2(2,2)` of degree 35, then `symmetric_power(3)`.
- **Method B**, [b2_weightspaces.sage](../scripts/reviewers/r178/b2_weightspaces.sage): weight multiplicities of V_(2,2) only, then the Sym^3 character from the Adams operations as (p1^3 + 3 p1 p2 + 2 p3)/6, then multiplicities peeled by the Racah alternating sum n_mu = sum_w sgn(w) m(mu + rho - w rho) over all 8 elements of W(B_2).

Both give **24 blocks, sum m·dim = 7770 exactly, multiplicities summing to 41, unknowns to 65**. The twelve multiplicity-1 blocks come out as (0,0), (1,0), (3,3), (5,0), (5,1), (5,3), (5,4), (6,0), (6,2), (6,3), (6,4), (6,6) (the record's list entry for entry), **with dimensions summing to 4125 exactly**. The rest of the table matches too: multiplicity 4 on (4,2) and (2,2), multiplicity 3 on (3,2), multiplicity 2 on the nine blocks (5,2), (4,4), (4,3), (4,1), (4,0), (3,1), (3,0), (2,1), (2,0).

The record's identification of the module is right for the reason it gives: 2e_1 + 2e_2 = 4ω_2 in B_2, and the competing 35-dimensional weight (2,1) = ω_1 + 2ω_2 carries c_2 = 12 against 16. Method B independently reproduces the largest weight space as **234 at weight (0,0)**.

## Claim 2a, separation at n=5

The theorem is sound as written. For B_2, rho = (3/2, 1/2), so ell_1 = lam_1 + 3/2 ≥ lam_2 + 3/2 > lam_2 + 1/2 = ell_2 > 0 for every dominant lam; the strict decrease and positivity are automatic rather than observed. In the variables t_i = ell_i^2 the two power sums give e_1 = p_2 and e_2 = (p_2^2 − p_4)/2, which determine {t_1, t_2} as a multiset, and positivity plus strict decrease then determine (ell_1, ell_2) and hence lam. The Harish-Chandra image of the degree-4 generator has p_4 as its leading term, and any two algebraically independent generators of Z(U(so(5))) carry the same information as (p_2, p_4), so "the generator is what separates, not the degree" is correct.

I reproduce the p_4 values on all three collisions: 7361/8 against 4481/8 at c = 30, 8521/8 against 14281/8 at c = 40, 17561/8 against 25625/8 at c = 60. And (c_2, c_4) is injective on all 24.

## Claim 2b, the n=12 half, where the argument breaks

This is the claim the brief asked me to attack hardest, and it does break.

**What is true.** rho(D_6) = (5,4,3,2,1,0) has rho_6 = 0, so ell_6 = lam_6. An O(12) block splits under SO(12) exactly when lam_6 ≠ 0. Pf = ell_1···ell_6 vanishes exactly on the non-split blocks. All three sub-statements hold.

**Where the inference fails.** p_2, p_4, p_6, p_8, p_10 are p_1 through p_5 in the six variables t_i = ell_i^2. Newton's identities recover e_1 through e_5 and stop; e_6 = prod ell_i^2 = Pf^2 is algebraically independent of them. So five power sums leave a one-parameter family, rather than a sign. The sign-only ambiguity is what remains after **all six** W(B_6)-invariants p_2 through p_12. Since p_12 = F(p_2,…,p_10) ± 6 Pf^2, the five do suffice **on a block already known to have Pf = 0**, and the argument silently extends that to the whole table.

**The extension is not vacuous, and I have the witnesses.** I decomposed Sym^3(Weyl_12) independently in [d6_sym3.sage](../scripts/reviewers/r178/d6_sym3.sage), by the same Adams-plus-Racah route as method B above, over the 23040 elements of W(D_6). The character closes at **733813080 = C(1640,3) exactly**. The result is **77 SO(12) constituents**, of which **12 carry lam_6 ≠ 0**, in six chirality pairs:

| O(12) label | multiplicity |
|---|---|
| (2,2,2,2,2,2) | 1 |
| (3,3,2,2,1,1) | 1 |
| (4,4,1,1,1,1) | 1 |
| (3,2,2,1,1,1) | 1 |
| (4,2,1,1,1,1) | 1 |
| (2,2,1,1,1,1) | 2 |

That is 65 + 2·6 = 77 SO(12) constituents against 65 + 6 = **71 O(12) blocks**, which independently confirms the record's 71. Six of those 71 are split, so on six blocks the five-Casimir argument covers nothing.

**The conclusion survives, as a finite check.** Every block of Sym^3(Weyl_12) obeys lam ≤ (6,6,0,0,0,0) in dominance, so ell ⊆ {0,…,11}. I enumerated all 924 dominant O(12) weights with ell ⊆ {0,…,11} in [d6_casimir_search.py](../scripts/reviewers/r178/d6_casimir_search.py) and (p_2,…,p_10) is injective on every one of them; the same holds out to ell_1 ≤ 34, which is 1623160 weights. So five Casimirs do determine the label for every block that occurs, by exhaustion over a bounded set, which is exactly the kind of measurement the record elsewhere refuses to accept as a guarantee. Producing a general counterexample amounts to two six-element sets of distinct non-negative integers whose **squares** share power sums p_1 through p_5, a Prouhet–Tarry–Escott condition strong enough that none exists in that range; I offer no opinion on whether one exists at all.

**The current record has already been corrected** to "six invariants separate the 71 O(12) blocks, and the sixth is Pf^2", which is the right statement: the O(12)-invariant part of the centre is C[p_2, p_4, p_6, p_8, p_10, Pf^2], six generators, of degrees 2, 4, 6, 8, 10, 12. Reviewer 177's chirality pairs and multiplicities agree with mine.

**Residual defect.** [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) still prints the refuted text at its n=12 section, "on every non-split block Pf = 0 and p_2..p_10, FIVE Casimirs (determine lam") so the script and the finding it supports now disagree.

## Claim 3, the 14 constraints

Confirmed. Reading the trivial multiplicity off the Sage decomposition of Sym^d(Weyl_5) gives **1, 1, 4, 5, 14 for d = 2 through 6**, with sum m·dim closing at 630, 7770, 73815, 575757 and 3838380 in turn. This is a different route from the record's Weyl-integration constant term, and it agrees. The degree-3 entry of 1 is consistent with the Lovelock collapse recorded elsewhere.

The stable-range comparison sequence 1, 2, 7, 19, 89 sits outside what I recomputed.

## Claim 4, the 41 vectors, and what the Casimir proves

The count is right: the multiplicities sum to **41** in both of my independent decompositions, so 41 is the number of highest-weight vectors to find.

The more interesting half is the methodological claim, which the record supports with an anecdote about a bug that no longer exists. **The conclusion is correct, and it deserves a proof rather than an anecdote.** Take any B-orthonormal basis {X_a} of so(5) and any O in O(10); the transported family Y_a = sum_b O_ab X_b satisfies sum_a Y_a Y_a = sum_a X_a X_a identically, because that sum depends only on the quadratic form. Since O(10) is vastly larger than the automorphism group of so(5), almost every such transport breaks the brackets while leaving C untouched.

[casimir_not_validating.py](../scripts/reviewers/r178/casimir_not_validating.py) makes this concrete over the integers, with C = −sum_a rho(X_a)^2 and X_a = E_ij − E_ji, the record's own normalisation:

| transport | Casimir | Lie relations failing, of 45 |
|---|---|---|
| single sign flip Y_s = −X_s | exactly unchanged | 9 |
| transposition of two basis elements | exactly unchanged | 19 to 22 |
| global sign flip Y_a = −X_a | exactly unchanged | 30 |

So the record's "the bracket check is what tests the action" is right, and its companion remark that the eigenvalue is a similarity invariant and so says nothing about orthonormality is right too. The specific historical detail (three of 45 failing), is a statement about code that no longer exists, and I neither reproduce nor contradict it.

## Claim 5, the orbit constraint

**The branching rule is 174's, and I re-derived it from the geometry.** W_0 is the Weyl tensor of CP^2 padded by a fifth axis; it determines its complex structure up to sign, and an orientation-reversing element of O(4) carries Lambda^2_+ to Lambda^2_-, so Stab_{O(4)}(W_0) is the two-component group U(2) ⋊ ⟨sigma⟩ with sigma the conjugation, and Stab_{O(5)}(W_0) is that times the padding reflection eps = diag(1,1,1,1,−1).

Three steps then give the rule.

1. **eps is redundant.** Every constituent of Sym^3(Weyl_5) has −Id acting trivially, so each is the extension V_lam^+ of an SO(5) label; eps = (−Id)·diag(−1,−1,−1,−1,1) therefore acts as diag(−1,−1,−1,−1,1), which is already the scalar −1 in U(2).
2. **The U(2)-invariants are always one-dimensional.** Branching so(5) → so(4) is multiplicity-free over lam_1 ≥ mu_1 ≥ lam_2 ≥ |mu_2|, and mu_1 + mu_2 = 0 forces mu = (lam_2, −lam_2). So a unique constituent has j_L = 0, and it has j_R = lam_2; the u(1)_R weight-zero space inside a spin-lam_2 module is one-dimensional for every integer lam_2.
3. **sigma decides.** In quaternion coordinates sigma is right multiplication by j, which fixes SU(2)_L pointwise and is the Weyl element of su(2)_R. On the m = 0 vector of spin j it acts by (−1)^j. Hence **dim V_lam^H = 1 exactly when lam_2 is even**, and 0 otherwise.

Hand-checks in agreement: (1,0) gives the line through e_5, matching the covariant T(W_0) ∝ e_5 that the record uses to kill the vector block; (1,1) gives 0, since sigma flips J; (2,0) gives 1; (2,2) gives 1, as W_0 itself must be fixed.

**The four numbers all reproduce** off my own block table: 16 blocks with lam_2 even, dimensions summing to **3570 exactly**, surviving multiplicities **25**, unknowns **36**, shape **two 3×3, five 2×2 and nine scalars**, with the eight dying multiplicity-1 blocks being (0,0), (1,0), (5,0), (5,4), (6,0), (6,2), (6,4), (6,6). The collision statement holds too: at c = 60 both (5,4) and (6,2) die, at c = 40 the block (5,0) dies leaving (4,3) alone, and only c = 30 survives with (4,1) and (3,3), both odd in the second label.

**The one link that was being assumed is now closed.** "Each of the 16 loses one multiplicity" needs the evaluation map from the m-dimensional space of degree-3 covariants into V_lam^H to be non-zero, block by block; a covariant that happens to vanish at W_0 costs nothing. [plan.md](../plan.md) supplies this by citing 174's measured span of 3570, but [findings/sym3-blocks.md](../findings/sym3-blocks.md) asserts the multiplicity drop with no such step. I settled it exactly in [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage).

Since the span S of the SO(5)-orbit of W_0^{⊗3} is a quotient of the functions on SO(5)/H, the multiplicity of V_lam in S is at most dim V_lam^H, so **dim S ≤ 3570** with equality exactly when all 16 evaluation maps are non-zero. Building W_0 as 2·w1 w1^T − w2 w2^T − w3 w3^T on Lambda^2 R^5, with eigenvalues (4, −2, −2) on the self-dual forms and zero elsewhere, and taking 3700 orbit points from Cayley transforms of random skew matrices over F_46337, the Gram matrix ⟨W_a, W_b⟩^3 (the kernel identity for the cubic Veronese), has **rank exactly 3570**. A rank over F_p is a lower bound for the characteristic-zero span, so the span is 3570, every evaluation map is onto, and the 25 multiplicities and 36 unknowns are now proved. This also reproduces 174's measured 3570 from an independent construction of W_0.

## Two live errors in the current record

**[findings/sym3-blocks.md](../findings/sym3-blocks.md): "The degree-two Casimir takes 22 distinct values across the 24 blocks."** It takes **21**. Twenty-four blocks with three colliding pairs leave 24 − 3 = 21 values, and the explicit list is 0, 4, 10, 12, 16, 18, 20, 24, 28, 30, 34, 40, 42, 46, 48, 52, 54, 60, 66, 74, 96. The sentence also contradicts the script it cites two paragraphs earlier: [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) prints "c2 takes 21 distinct values across 24 blocks".

**[plan.md](../plan.md) line 389: "The Casimir separates only 36 of 71 blocks there, 52 fuse into 17 classes, one of them five blocks wide."** The 52-into-17 half is exactly right, and I reproduce it from my own block list. The other two numbers need repair. Since 71 − 52 = 19, the Casimir separates **19** blocks; 36 is the number of **fibres**, 19 singletons plus 17 fused classes. And the fibre sizes are {1: 19, 2: 7, 3: 4, 4: 4, 5: 2}, so **two** classes are five blocks wide, not one, they are {(3,3,2,2,1,1), (3,3,3,1,0,0), (4,2,2,2,0,0), (4,3,1,1,1,0), (4,4,0,0,0,0)} and {(3,3,3,3,0,0), (4,3,2,2,1,0), (4,4,1,1,1,1), (4,4,2,0,0,0), (5,3,1,1,0,0)}. I confirm the rest: (c_2, c_4) is injective on all 71.

## What I did not check

The stable-range comparison sequence 1, 2, 7, 19, 89. The explicit 41 highest-weight vectors over Q(i) as vectors, as opposed to their count. The value tr(W_0^3) = 1/sqrt 6 and the normalisation of the covariant T^e. Whether degree 3 is adequate for the certificate at all.
