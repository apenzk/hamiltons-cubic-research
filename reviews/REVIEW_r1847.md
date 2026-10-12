# r1847: Gate 2 review of the I121 rectangle identity

Brief: [BRIEF_I121_rectangle.md](BRIEF_I121_rectangle.md). Log: [agent_logs/r1847-i121-rect.log](../agent_logs/r1847-i121-rect.log). Screens: [review_r1847_rect.py](../scripts/reviewers/review_r1847_rect.py), [review_r1847_f81.py](../scripts/reviewers/review_r1847_f81.py).

**Verdict: every mathematical conclusion survives. Four defects are in the written chain or its wording: one false justification (orientation), one asserted link (step 3), one misdescribed check, one misstated ratio.**

| # | claim | verdict |
|---|---|---|
| 1 | coordinates, rect_norm on each pairing | CONFIRMED |
| 2 | step 1, only rectangles couple, factor 6 | CONFIRMED |
| 3 | step 2, R^2 part is 6JJJ, no crossing entry | CONFIRMED |
| 4 | step 3, the # part is I_3/2 | PLAUSIBLE (link asserted, repair below) |
| 5 | step 4, crossing entries, bit sum 48XXX+6JJJ | CONFIRMED |
| 6 | rectangle identity, tau and P(B_f), independent of n | CONFIRMED, conditional on the step 3 repair |
| 7 | orientation remark "reversing e1 negates X12 and X13" | REFUTED (conclusion true, reason false) |
| 8 | restatement through tr B_f^3, J/X block sums | CONFIRMED |
| 9 | the Check paragraph | REFUTED as described (script checks 2 of the 8 triples) |
| 10 | whole P at pair-free W | CONFIRMED |
| 11 | raw reading of the bilinear formula | CONFIRMED |
| 12 | product constant and equality case | CONFIRMED, one ratio misstated |
| 13 | matching form, counting, order-nt estimate | CONFIRMED, n even must be stated |
| 14 | claims about the node (F81 witness, J visible elsewhere, averaging) | CONFIRMED |

## 1. Coordinates

Each raw entry appears twice in the symmetric operator, so the norm is 2(a^2+b^2+c^2), and with a=J, b=X+J/2, c=X-J/2 this is 4X^2+3J^2. For the block on {1,2,3,4} with A=W_{12,34}, B=W_{13,24}, C=W_{14,23}, A=B-C, the three pairings have (a,b,c) equal to (A,B,C), (B,A,-C), (C,-A,-B), and each satisfies a=b-c. So rect_norm holds for every pairing. The compression remark is right: each e_g, g in M, is fixed by rotations in g's plane and by rotations in planes disjoint from g.

## 2. Step 1

The sign group acts orthogonally on Lambda^2 and commutes with Q, so T is invariant. A term T(nu_{Q1},nu_{Q2},nu_{Q3}) carries chi_{Q1}chi_{Q2}chi_{Q3}, trivial iff every index occurs an even number of times, iff Q3=Q1 sym-diff Q2. A four-set there forces |Q1 cap Q2|=2. A repeated block would need an empty four-set. The unordered triples are in bijection with sets of three disjoint edges (the edges are the pairwise intersections), and six orderings give P(B_f)=6 sum_R tau_R. Same argument kills the two-block and one-block terms.

## 3. Step 2

tr(ABC)=tr(CBA) for symmetric matrices, so the mixed terms of tr(sum)^3 are 6 tr(nu12 nu13 nu23). A nonzero nu_Q(x,y) needs x,y complementary edges of Q. Then x lies in Q12 cap Q23 = e2, forcing y=e1, z=e3. The term is J12 J13 J23 with each edge's orientation used twice, so orientation-free.

## 4. Step 3 (gap)

The calibration is right: on a diagonal tensor only the k=i, l=j branch survives in R_ijkl R_ipkq R_jplq, giving 6 sum over triangles, so kappa=1/2 given L220 step 7. **What is missing is the proportionality itself.** "In index form <R#,R> = kappa I_3" is asserted, and a one-point calibration fixes kappa only once proportionality is known. A different contraction matters here: with the third factor R_jqlp instead of R_jplq the step 4 sum would be 8XXX-JJJ and P would be 3JJJ+24XXX. That contraction differs from I_3 on diagonal tensors by -2 sum K^3, so the diagonal does separate them, but only if the note first says that <R#,R> lies in the span of tr R^3 and I_3 on W_n.

*Repair*: add one sentence, either deriving <R#,R> from the so(n) structure constants ([e_ij,e_kl] as Kronecker deltas, which gives a single three-factor contraction), or citing that the O(n)-invariant cubics on W_n are spanned by tr R^3 and I_3 and that the diagonal (sum K^3 against sum over triangles) separates them. *Screen (not evidence)*: on a random Weyl tensor at n=6 built from Kulkarni-Nomizu products, <W#,W> with the Lie-algebra sharp normalised by I#=(n-2)I equals I_3/2 to 8 digits, and the R_jqlp contraction does not.

## 5. Step 4

The mixed part draws one factor from each block. Factors 1 and 2 share i,k and lie in distinct rectangle blocks, so {i,k} is their shared edge. In the same way {j,l} and {p,q} are edges. Each factor is W_{e0 f0, e1 f1} for the edges written as (i,k),(j,l),(p,q), which is b=X+J'/2 with J' the J for those orientations, J'=s_e s_f J. Expanding the product of (X_ab + s_a s_b J_ab/2) over the 8 bits leaves 8XXX plus JJJ times (s1s2)(s1s3)(s2s3)/8 summed, which is JJJ. The mixed XXJ and XJJ terms cancel. Six edge assignments give I_3 = 48XXX+6JJJ. rect_bits types exactly this sum.

## 6. The identity

6JJJ + (24XXX+3JJJ) = 9JJJ+24XXX, and tau = P/6. Nothing depends on n. *Screen*: my own four-index construction of the blocks gives tau equal to the formula at random (J,X) on all three blocks, and P(B_f) and P(A+B_f) equal to the formulas at n=6 and n=7.

## 7. Orientation remark (REFUTED as a reason)

"X12X13X23 is independent of the planes' orientations, since reversing e1 negates X12 and X13" is false. Reversing e=(i,j) sends b=W_{ik,jl} to W_{jk,il}=c and c to b, so **X is unchanged and J=a is negated**. Screen: reversing e1 on a block with (J,X)=(0.7,0.3) reads (-0.7,0.3). The product XXX is orientation-free trivially, and JJJ is orientation-free because each edge enters two of the J's. *Correction*: "X_ab is independent of orientations, and reversing e1 negates J12 and J13, so J12J13J23 is too." This also fixes the matching-form section, where X_M is well defined and J_M is defined up to conjugation by a diagonal sign matrix, which leaves tr J_M^3 unchanged.

## 8. Restatement

tr B_f^3 = 6 sum_R JJJ by step 2 and characters, so P(B_f) = (3/2) tr B_f^3 + 24 sum XXX. Every raw four-set entry W_{ab,cd} is the J of the pairing ({a,b}|{c,d}). On one block sum J^2 = A^2+B^2+C^2 = N/2 and sum 4X^2 = 6(B^2-BC+C^2) = (3/2)N with N=4(B^2-BC+C^2). Both hold.

## 9. The Check paragraph (REFUTED as described)

The note says [check_I121_rectangle_cubic.py](../scripts/misc/check_I121_rectangle_cubic.py) evaluates tau "on the eight basis triples ... 0 at the six mixed triples". **The script evaluates two triples only**: all blocks at (J,X)=(1,0), and all at (0,1). The six mixed coefficients are never computed. The P(B_f) comparison on a random tensor constrains them only in aggregate. The values quoted (20.4282301675, 15 rectangles at n=6, 420=C(8,6)x15 at n=8) reproduce. The mixed zeros do hold, by steps 2 and 4 by hand and by my random-coordinate screen. *Correction*: describe what the script does, or add the six mixed triples. The script and the note both carry uncommitted working-tree edits from another session at the time of this review. I reviewed the brief's quoted text and ran the script as it stood.

## 10. Whole P at pair-free W

T(A,A,B_f) vanishes because A has trivial character and each nu_Q has chi_Q nontrivial. The cross terms T(A,nu_Q,nu_Q') carry chi_Q chi_Q', trivial only for Q=Q'. nu_sq's signed coordinates with a+b+c=0 agree with the raw entries up to sign, so the squares match. 2J^2 - (X+J/2)^2 - (X-J/2)^2 = (3/2)J^2 - 2X^2. inner_PiQ gives the pairing with A, and each unordered pair of disjoint edges is one pairing of one block. The weights +9/2 and -6 are 3x(3/2) and 3x(-2). The slot correspondence between nu_sq's (a,b,c) and PiQ's (x,y,z) is taken on trust from the Lean statement. The screen at n=6 and 7 agrees.

## 11. Raw reading

The formula's output is Bianchi-consistent (a1a2 = (b1b2+c1c2) - (b1c2+c1b2) under a=b-c). The chi_{Q3}-isotypic part of W_n is V_{Q3} alone, since pair entries carry two-set characters. So <nu1 o nu2, nu3> for all nu3 determines nu1 o nu2, and matching tau on V_{Q3} settles the raw reading, conditional on the identity. The edge labels line up: b1=W_{ik,jl}=X12+J12/2 and b3=W_{km,lp}=X23+J23/2. rect_raw is the resulting ring identity. The signed reading's divergence is quoted from r1077 and was not re-derived.

## 12. Product constant

x^2+j^2=1 on each block, and the stated form of tau follows. Bound: |c j1 j2j3 + x1 x2x3| <= sqrt(c^2 j2^2 j3^2 + x2^2 x3^2) <= 1. With c<1, equality needs j2j3=0 and |x2x3|=1, and by symmetry every x_i=+-1. So the equality case is right. rect_unit does not carry it, so it stands in prose. **Misstated ratio**: the purely invisible rectangle reaches tau = sqrt(N1N2N3)/(2 sqrt3), which is 1/sqrt3 of the bound (1/2)sqrt(N1N2N3), not "1/(2 sqrt3) of it". The identification with L221's screened constant ([second-order.md](../findings/second-order.md) L221 open item) assumes L221's N_i is the same operator norm. That was not checked.

## 13. Matching form and estimate

A rectangle lies in (n-7)!! perfect matchings. tr J_M^3 over a hollow matrix counts each triple of edges six times, which gives the 1/(n-7)!! form. E(M) = sum_{e<f} 4X^2 = 2||X_M||_F^2. The sum over M of ||X_M||_F^2 is 2(n-5)!! x (3/8)||B_f||^2 = (3/4)(n-5)!!||B_f||^2. With |tr X^3| <= ||X||_F^3 and ||X_M||_F <= t/sqrt2 (the matching inequality, maximal frame), the visible part is at most (3/sqrt2)(n-5) t ||B_f||^2. **Scope**: the rectangle identity holds at every n (screened at n=7), but the matching form needs n even. The note does not say so.

## 14. The node

J_{M0}=0 at F81's witness holds by hand. e_{p_k q_k} is fixed by the torus, and the product operator beta I + (alpha-beta)(Pi_{Lambda^2 P}+Pi_{Lambda^2 Q}) has no entry between two mixed bivectors. *Screen*: at n=8 and 12, max|J_{M0}|=0, E(M0)=1-t^2 (the whole four-set mass sits on unions of two M0 edges, so "the whole four-set value sits in X_{M0}" is right read as mass), and E(M0) is far above the slack t^2 - sum a_e^2 (0.875 against 0.018 at n=8). The J_{pi1} = (2/3)(X_{pi2} - X_{pi3}) relation checks from the coordinates in section 1. The averaging paragraph claims no bound beyond order nt and names the missing concentration. **The note does not overclaim on the node.**
