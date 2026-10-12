# Review r1885: I117, positive-definite #-idempotents on g2's torus family (reader two of two)

Brief: [BRIEF_I117_g2_torus.md](BRIEF_I117_g2_torus.md). Note: [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md). Log: [r1885-i117-g2-torus.log](../agent_logs/r1885-i117-g2-torus.log). Worked independently of r1884, from definitions. The scripts under review were not run or imported.

**Verdict: the note stands. Items 1 to 5 are CONFIRMED, and item 6 is CONFIRMED with two wording corrections, neither of which changes a conclusion.**

| item | claim | verdict |
|---|---|---|
| 1 | the family is nine-dimensional and closed under # | CONFIRMED |
| 2 | the product table (1/2, 2/3, alpha alpha^T, 1/2 alpha^T A alpha), with lengths squared 2 and 2/3 | CONFIRMED, derived by hand |
| 3 | the system reduces to A = sum w^2 alpha alpha^T and six cubics, and PD means exactly w > 0 | CONFIRMED |
| 4 | the stabiliser is S3, a reflection or trivial | CONFIRMED |
| 5 | Weyl-invariant: two positive solutions. Reflection: 53 complex, 31 real, four positive, as tabulated | CONFIRMED, both solves reproduced exactly with my own construction |
| 6 | scope | CONFIRMED with corrections C1 and C2 |

## Item 1

Under a maximal torus T, g2 splits as t (weight 0, multiplicity 2) plus six real planes V_alpha on which T acts by rotation through alpha. The six positive roots of g2 are pairwise non-proportional, so no two planes share a weight and there are no equivariant maps between different blocks. On t every symmetric 2x2 matrix commutes with T (3 dimensions). On each V_alpha the commutant is {aI + bJ}, and symmetry kills J (1 dimension each). Total 3 + 6 = 9. The sharp is built from Ad-invariant structure constants in an orthonormal basis, so C#D is T-invariant whenever C and D are, and the family is closed.

## Item 2

Write the record's sharp as (A#B)_ab = 1/2 sum c_agd c_bez A_ge B_dz. For P_alpha, P_beta projections onto orthonormal bases this gives (P_alpha # P_beta)_aa = 1/2 sum over g in V_alpha, d in V_beta of c_agd^2.

- **A#A = 0.** A nonzero term needs c_agd with g, d both in t, and [t, t] = 0.
- **P_alpha # P_alpha = alpha alpha^T on t.** For H in t and u, v an orthonormal pair in V_alpha with [H,u] = alpha(H) v, the two terms c_Huv, c_Hvu each square to alpha(H)^2, so the entry is alpha(H) alpha(H'), with alpha taken as a vector through the metric. The V_gamma components vanish since [V_alpha, V_alpha] lies in t (2 alpha is not a root).
- **A # P_alpha = 1/2 (alpha^T A alpha) P_alpha.** For a = u in V_alpha, c_uHv = -alpha(H), so the entry is 1/2 sum A_ge alpha(g) alpha(e). Other blocks vanish by the same weight argument.
- **Mixed products.** By T-invariance P_alpha # P_beta restricted to V_gamma is a scalar kappa, and tracing gives kappa = S/4, with S(alpha, beta, gamma) the sum of squared structure constants over the three planes, totally symmetric in them.
- **The constants.** For a in V_gamma, the Casimir identity sum_{b,c} c_abc^2 = 2c = 8 (c = 4, which with h-dual 4 fixes the long length squared at 2, so short 2/3) splits over the planes. Summed over the two basis vectors of V_gamma: 16 = 4 |gamma|^2 + 2 sum over unordered pairs of S. Onto a long gamma, the pairs are one long-long and one short-short, so S_LL + S_SS = 4. Onto a short gamma, the pairs are two short-long and one short-short (for gamma = alpha1: (alpha1+alpha2, alpha2), (3alpha1+alpha2, 2alpha1+alpha2), (2alpha1+alpha2, alpha1+alpha2)), so 2 S_SL + S_SSS = 20/3. The reflection in the short gamma swaps the two short-long pairs. The long roots span su(3), whose own Casimir (c = 3) gives S_LL = 2. So S_SS onto long = 2, and by total symmetry of S the triple (alpha1, alpha1+alpha2, alpha2) gives S_SL = 2, hence S_SSS = 8/3. The coefficients S/4 are 1/2, 1/2, 1/2 and 2/3, as the note states.
- **Cross-check against the Lean-checked blocks.** L263_blocks in [L263Blocks.lean](../lean/HamiltonsCubic/Results/L263Blocks.lean) has P_k # P_k = 3 P_k and P_p # P_p = P_k + 4/3 P_p at SU(3). The table predicts the same: c = 3 for su(3), and on a short plane two ordered short-short terms of 2/3 give 4/3. On a long plane two ordered terms of 1/2 give 1. On t the short roots give sum alpha alpha^T = I.
- **Squared dot products.** Long-long: 4 or 1. Long-short: 1 or 0. Short-short: 4/9 or 1/9. All as stated.

## Item 3

Expanding C#C with C = A + sum w_alpha P_alpha: the t block is sum w_alpha^2 alpha alpha^T, and the V_gamma block is 2 w_gamma (1/2 gamma^T A gamma) + 2 sum over unordered pairs of kappa w_alpha w_beta. Substituting A gives the displayed cubic. The positive roots span t, so A is PD once every w_alpha is nonzero. C is PD iff A is PD and every w > 0, which the second condition already implies. **Check at I/4:** sum over positive roots of alpha alpha^T = c I_t = 4 I_t (from -tr ad_H^2 = 2c |H|^2), so A = 1/4 I. The Weyl-invariant reduction (long x, short y) follows: sum of w^2 (alpha . gamma)^2 is 6x^2 + 2y^2 onto a long gamma and 2x^2 + 2/3 y^2 onto a short one. The right-hand sides are x^2 + y^2 and 2xy + 4/3 y^2, as written.

## Item 4

W(G2) is dihedral of order 12, and -1 fixes every plane. W/{±1} is S3, acting faithfully on the three long lines (the Weyl group of the A2 of long roots) and compatibly on the short lines. Each long root is orthogonal to exactly one short root. A long-root reflection s_alpha and the reflection in the short root orthogonal to alpha differ by -1, so both have the same image in S3, which fixes that orthogonal pair and swaps the other two pairs (checked: s_alpha2 swaps 3alpha1+alpha2 with 3alpha1+2alpha2, and alpha1 with alpha1+alpha2). N(T) acts on the family by conjugation and preserves #, so solution sets are W-stable. The subgroups of S3 are 1, three conjugate reflections, Z3 and S3, and a Z3-invariant weight vector is uniform on each triple, hence S3-invariant. The stabiliser types are exactly S3, a reflection (one up to conjugacy) or trivial.

## Item 5

Solved in advance-bounded exact runs (seconds). My own construction: simple roots alpha1 short, alpha2 long, Gram [[2/3, -1], [-1, 2]], coefficients from item 2, reflection s_alpha2 with x on alpha2, y on 2alpha1+alpha2, z on {3alpha1+alpha2, 3alpha1+2alpha2}, u on {alpha1, alpha1+alpha2}. Real roots by lex Groebner basis and back-substitution over the algebraic reals.

- **Weyl-invariant.** After saturating by xy, the ideal has degree 4, with eliminant (y - 1/4)(y - 3/28)(y^2 + 2y - 9/4). The quadratic's roots give x = -1/2. On the excluded branch y = 0, x is 1/3 or -1/2, which is not PD. **The positive solutions are exactly (1/4, 1/4) and (9/28, 3/28).**
- **Reflection.** The four distinct equations give a zero-dimensional ideal with 53 solutions counted with multiplicity (the radical has 49), 31 distinct real solutions, and **exactly four positive ones**, the same four whether or not XYZU is saturated out:

| (x, z, u, y) | norm squared, exact | A eigenvalues | identification |
|---|---|---|---|
| (1/4, 1/4, 1/4, 1/4) | 7/8 | 1/4, 1/4 | I/4 |
| (9/28, 9/28, 3/28, 3/28) | 351/392 | 9/28, 9/28 | L263 SU(3) |
| (11/29, sqrt(77/1682), sqrt(77/1682), 5/29) | 746/841 | 11/29, 5/29 | L263 SO(4): A is 11/29 along alpha2 (2x^2 + z^2 + u^2 = 319/841) and 5/29 along the orthogonal short root, matching P_L and P_S |
| (0.3387527, 0.3119786, 0.1091570, 0.1052897), x of degree 6 | 0.89543956, degree 6 | 0.3387527, 0.3033544 | new |

The minimal polynomial of x in the new solution is x^6 - 910/51 x^5 + 637/6 x^4 - 104674/459 x^3 + 3967313/22032 x^2 - 20773/408 x + 90961/22032. All four have norm squared at least 7/8, with equality only at I/4.

## Item 6, scope

The note labels the trivial-stabiliser type as screened only, gives stability numbers as screen values U_s' does not need, and lists the 409-solution enumeration as a waiting long run. The Lean paragraph correctly marks the product table and both solves as untyped, with the reflection solve described as a machine result.

- **C1 (wording).** "Every positive-definite torus-invariant idempotent on g2 with a nontrivial stabiliser is one of these four" holds up to the Weyl group. The SO(4) solution and the new one each have three W-images (one per reflection), all with the same norm. It should read "is W-conjugate to one of these four". The U_s' conclusion is unaffected.
- **C2 (digits).** The new solution's squared norm is 0.8954396, which rounds to 0.895440 (the screen's value). The reflection table's 0.895439 is truncated and should read 0.895440.
