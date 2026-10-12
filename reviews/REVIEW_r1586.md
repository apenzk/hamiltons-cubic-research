# Review r1586: L270 (the direction I and heaviness, H from U_s') and L271 (the torus system in P and Q)

Log: agent_logs/r1586.log

Overall: CONFIRMED WITH MINOR GAPS. Every numbered part of L270 and L271 holds. The gaps are wording and screen bookkeeping, listed per claim.

| claim | verdict | reason in one line |
|---|---|---|
| H1 L270 (1) the eigenvalue on span{C, I} | CONFIRMED | B = F(C,.,.) symmetric, B(C,.) = <C,.> from C#C = C, <C#I,I> = <C, I#I> = c tau, and {C, H} is B- and metric-orthogonal, so lambda_I = B(H,H)/norm(H)^2 = (cq tau - tau^2)/(qd - tau^2) |
| H2 L270 (2) heaviness, and L264 (4) as a case | CONFIRMED | q > tau^2/(2c tau - d) >= d/c^2 by (c tau - d)^2 >= 0, strict; at su(3) in G2 lambda_I = 15/28, equal to L264 (4)'s trace minus 1, and q = 351/392 > 14/16 |
| H3 L270 (3) H from U_s' | CONFIRMED | the chain uses only stability and positive definiteness on a simple h, with M(h) = 2 c_h d in L256; minor: the attained direction of H (I/(n-2) meets the bound) is left implicit |
| H4 L270 (4) the torus bound y < y0 | CONFIRMED | q = norm(A)^2 + 2y, tr A = 2y, Cauchy-Schwarz on the m x m Cartan block, equality at I/c, f(y) = 4y^2/m + 2y increasing, f(y0) = m(2m-1)/(4(m-1)^2) = d/c^2 |
| H5 L270 screens | CONFIRMED | tau = 17/8 + 5 sqrt13/8 and the test value (39350 sqrt13 - 122242)/8192 recomputed; L267's point, su(3) in G2 and every torus solution I found at m = 4, 5 are heavier; the second G2 idempotent was not recomputed (its data is outside the brief) |
| Q1 L271 (1) F and the norm on the torus slice | CONFIRMED | F = 3<A, A_mu> + 6 T_3 for arbitrary A (A#A = 0 on the abelian t); A_mu entries d_i and V^2 - U^2 = -PQ; four triangles per triple, even number of plus roots; screen agrees to 1e-14 at random A, U, V |
| Q2 L271 (2) the P, Q system and its symmetries | CONFIRMED | pair sums (U^2+V^2)_ij on eps_i - eps_j and (UV+VU)_ij on eps_i + eps_j, u^T A u = (d_i+d_j)/2 -+ A_ij, sum and difference give the pair; every stated symmetry checks; positive definiteness is P > abs(Q), the Cartan block A_mu being then positive definite automatically |
| Q3 L271 (3) Q = 0 only at I/c | CONFIRMED | the 4-dim block carries diagonal entries P_ij/2 and off-diagonal entries +-Q_ij/2, A_off = -PQ vanishes with Q, weights d_i and P_ij/2 are positive, L261 applies |
| Q4 L271 (4) the Z2 split | CONFIRMED | orthogonality, the polarisation, the contraction and the row-sum eigenvalue all rederived; minor: (4) divides by norm(C_Q)^2, so it needs Q != 0 (C != I/c), which the statement leaves implicit |
| Q5 L271 screens | CONFIRMED (screen) | at m = 4, 5 the positive non-uniform solutions found have Q on one edge or one triangle and split eigenvalue 0.35 to 0.43; minor: m = 4 also has an edge solution with split eigenvalue 0.380, absent from the record's quoted 0.43, 0.42, 0.35 |
| LEAN fidelity | CONFIRMED | all eight declarations state what the table says, with no hypothesis carrying the conclusion and no vacuous instance |

## Method

- I read the quoted chain link by link, then derived each step by hand from the definitions and givens in the brief. The derivations are reproduced below.
- I read L256's and L264's text in findings/second-order.md for two things only: the normalisation of M(h), and L264 (4)'s eigenvalue matrix. I did not read the D6 working note or any other reviewer's output.
- Screen, reported as a screen: sage -python with numpy and scipy. I built so(2m) for m = 4, 5 with the orthonormal basis e_a wedge e_b (c comes out as 6 and 8, correct), Hamilton's product from the structure constants, the Cartan h_i = e_{2i-1} wedge e_{2i}, and the root planes as kernels of ad(h_i +- h_j) on each 4-dim block. With that I (a) compared F(C,C,C), the norm, A_mu and the root components of C#C against L271 (1)-(2) at random A, U, V, and (b) solved the P, Q system by least squares from 60 random seeds (m = 4), 60 random seeds and 30 edge-type seeds (m = 5). Each solution was checked against the full C#C = C (residual 0 to machine precision) and for positive definiteness. Total runtime was under 20 seconds. Script: scratchpad r1586/screen.py and screen_edge.py.

## H1. L270 (1)

- B(X,Y) = <C#X, Y> = F(C,X,Y) is symmetric because F is fully symmetric. B(C,Y) = <C#C, Y> = <C,Y>. <C#I, I> = F(C,I,I) = <C, I#I> = c tau.
- H = I - (tau/q) C gives <H,C> = 0, so B(C,H) = <C,H> = 0. The plane span{C, H} = span{C, I} is therefore diagonal for both B and the metric, with eigenvalue 1 on C and B(H,H)/norm(H)^2 on H.
- B(H,H) = c tau - 2 tau^2/q + tau^2/q = c tau - tau^2/q, and norm(H)^2 = d - tau^2/q. The ratio is (cq tau - tau^2)/(qd - tau^2).
- norm(H)^2 = (qd - tau^2)/q > 0 exactly when C is not parallel to I (Cauchy-Schwarz with equality only for parallel vectors, and C != 0). Parallel to I means C = I/c, since that is the only nonzero idempotent multiple of I.
- With norm(H)^2 > 0, lambda_I > 1/2 is equivalent to 2(c tau - tau^2/q) > d - tau^2/q, and multiplying by q > 0 gives q(2c tau - d) > tau^2.

## H2. L270 (2)

- q > 0 and tau^2 > 0 force 2c tau - d > 0, hence q > tau^2/(2c tau - d). Then tau^2/(2c tau - d) >= d/c^2 is equivalent to c^2 tau^2 - 2 c d tau + d^2 = (c tau - d)^2 >= 0. So q > d/c^2 strictly. The contrapositive gives lambda_I <= 1/2 whenever q <= d/c^2 and C != I/c.
- For C = aP_k + bP_p with a != b, span{C, I} = span{P_k, P_p} because I = P_k + P_p. L264 (4)'s "second eigenvalue on the span" is the compression of C#. to that plane, so it equals lambda_I by H1.
- Worked check, su(3) in G2 (c = 4, d = 14, dim k = 8, dim p = 6, a = 9/28, b = 3/28):
  - tau = (72 + 18)/28 = 45/14 and q = (648 + 54)/784 = 351/392.
  - lambda_I = (cq tau - tau^2)/(qd - tau^2) = (6480/5488)/(12096/5488) = 15/28.
  - L264 (4)'s matrix [[a c_1, b x], [b alpha, a alpha + b y]] with c_1 = 3, alpha = 4/3, x = 1, y = 4/3 fixes (a,b), which confirms the idempotent: a^2 c_1 + b^2 x = 252/784 = 9/28, and 2ab alpha + b^2 y = 84/784 = 3/28. Its trace minus 1 is 27/28 + 12/28 + 4/28 - 1 = 15/28, the same as lambda_I.
  - Since 15/28 > 1/2, this point is unstable, and q = 0.8954 > d/c^2 = 0.875, as (2) requires.

## H3. L270 (3)

- By L260 (1) the maximiser X can be taken PSD. By L264 (1), C = X/F(X) is an idempotent that is positive definite on its semisimple support h and stable in the ambient sense. Its norm is norm(C)^2 = 1/F(X)^2 = 1/kappa_n^2.
- Sym^2 h is closed under # (stated in L264's proof), so ambient stability restricts to stability inside h. By L264 (2), h is simple.
- U_s' gives norm(C)^2 >= d/c_h^2. L264's proof states M(h) = 2 c_h d, which is consistent with the so(n) value 2(n-2)N/N^{3/2} = 2(n-2)/sqrt N. So L256 reads c_h/sqrt d <= (n-2)/sqrt N, that is d/c_h^2 >= N/(n-2)^2. Therefore kappa_n <= (n-2)/sqrt N.
- The chain uses nothing about the maximiser beyond stability and positive definiteness on a simple h.
- Minor gap: statement H is an equality, and its other half, kappa_n >= (n-2)/sqrt N, is the value at I/sqrt N. The proof says "which is H" without naming that half. It is immediate.
- U_s implies U_s', because C = I/c has norm(C)^2 = d/c^2. Any C with q >= d/c^2 satisfies U_s' vacuously, so U_s' asks nothing of heavier idempotents.
- Wording note on "What it gives": "What H needs on the torus family is that no torus-invariant PD idempotent is lighter than I/c" overstates the requirement. By (3), H needs this only for stable ones, and the torus family is one sufficient sub-target rather than something H requires on its own.

## H4. L270 (4)

- norm(C)^2 = norm(A)^2 + sum_alpha mu_alpha^2 norm(I_{R_alpha})^2 = norm(A)^2 + 2y.
- For an idempotent, A = 2 sum_alpha mu_alpha^2 u_alpha u_alpha^T with norm(u_alpha) = 1, so tr A = 2y. Cauchy-Schwarz on the m x m block gives norm(A)^2 >= (tr A)^2/m, with equality iff A is scalar.
- At I/c (c = 2m - 2, mu = 1/c on all m(m-1) positive roots) y0 = m/(4(m-1)), A = I_t/c is scalar, and f(y0) = m/(4(m-1)^2) + m/(2(m-1)) = m(2m-1)/(4(m-1)^2) = d/c^2.
- f is increasing on y >= 0, so q < d/c^2 gives f(y) <= q < f(y0), hence y < y0.

## H5. L270 screens

- L267, n = 9:
  - tau = 3/2 + 10/16 + 20 sqrt13/32 = 17/8 + 5 sqrt13/8.
  - Writing the test value over 4096: q(14 tau - 36) = (-21825 + 30555 sqrt13)/4096 and tau^2 = (39296 + 10880 sqrt13)/4096. The difference is (39350 sqrt13 - 122242)/8192 ≈ 2.34 > 0.
  - q = 873/1024 ≈ 0.853 > 36/49. The value 873/1024 is consistent with the givens: a_+^2 + a_-^2 = 191/1024 with a_+ + a_- = 1/2 has real roots.
- su(3) in G2 is heavier (H2). The second G2 idempotent was not recomputed because its data is outside the brief. By (2), any point that passes the test is heavier automatically.
- Torus screen: every non-uniform positive solution found is heavier (q/(d/c^2) between 1.107 and 1.273). lambda_I at those solutions lies between 0.505 and 0.601, above 1/2, consistent with (2).

## Q1. L271 (1)

- A#A = 0 because t is abelian. From L268's givens, (C#C)_t = sum_alpha mu_alpha^2 P_alpha#P_alpha = A_mu for every A. T-invariance kills the cross terms, and the positive roots give pairwise inequivalent irreducible 2-dim T-modules, so the R_alpha component is scalar: 2 mu_alpha u_alpha^T A u_alpha + S_alpha.
- F = <A, A_mu> + 2 sum_alpha mu_alpha(2 mu_alpha u^T A u + S_alpha), using <P_alpha, P_alpha> = 2. The middle term is 2<A, A_mu>. The last term counts each triangle once for each of its 3 roots, giving 3 <A, A_mu> + 6 T_3. Nothing here assumed A = A_mu.
- (A_mu)_ii = sum over roots containing i of mu^2 = d_i, because (u u^T)_ii = 1/2. (A_mu)_ij = 2(-U^2/2 + V^2/2) = V^2 - U^2 = -PQ.
- Triangles on {i,j,k}: (-,-,-), and three patterns with two plus roots, one for each choice of the single minus edge. Patterns with one or three plus roots are not closed. The identity pq_triangles and tr P^3 = 6 sum_{i<j<k} P_ij P_jk P_ik give tr P^3 + tr Q^3 = 12 T_3.
- Norm: 2 sum_{i<j}(U^2 + V^2) = (1/2)(norm(P)^2 + norm(Q)^2).
- The screen agrees with each piece at random data.

## Q2. L271 (2)

- The pairs landing on eps_i - eps_j are (eps_i - eps_k, eps_k - eps_j) and (eps_i + eps_k, eps_j + eps_k), which give (U^2 + V^2)_ij. The pairs landing on eps_i + eps_j are (eps_i - eps_k, eps_j + eps_k) and (eps_i + eps_k, eps_j - eps_k), which give (UV + VU)_ij.
- u^T A u = (A_ii + A_jj)/2 -+ A_ij. With A = A_mu the two root equations are u(1 - e + 2(v^2 - u^2)) = sm and v(1 - e - 2(v^2 - u^2)) = sp. Their sum and difference are exactly the stated P and Q equations, and the screen agrees.
- Symmetries:
  - P <-> Q preserves the system, because d is symmetric in P and Q, and preserves all four terms of F.
  - Q -> SQS, A -> SAS preserves d, A_ij = -P_ij Q_ij (it becomes s_i s_j A_ij), (Q^2)_ij (it becomes s_i s_j (Q^2)_ij), A_ij P_ij Q_ij and tr Q^3.
  - (A_off, Q) -> -(A_off, Q) fixes A_ij P_ij Q_ij and flips tr Q^3. The statement correctly claims this only for F, since the Q equation is not odd.
- Positive definiteness: mu > 0 is equivalent to P > abs(Q). Given mu > 0, A_mu is positive definite because the D_m roots span t, so the Cartan block adds no condition.

## Q3. L271 (3)

- On the block with basis e_{2i-1,2j-1}, e_{2i-1,2j}, e_{2i,2j-1}, e_{2i,2j}, C restricts to ((U+V)/2) I_4 + ((U-V)/2)(P_- - P_+). The operator P_- - P_+ pairs e_{2i-1,2j-1} with e_{2i,2j} and e_{2i-1,2j} with e_{2i,2j-1}, with zero diagonal.
- So C is coordinate-diagonal on the root blocks exactly when Q = 0. For an idempotent, the Cartan block is then diagonal too (A_off = -PQ = 0).
- The weights d_i > 0 and P_ij/2 > 0, so L261 gives C = I/(n-2).

## Q4. L271 (4)

- C_P + C_Q = C. The two are orthogonal: the diagonal and off-diagonal Cartan parts are orthogonal, and on the root planes 2 sum (P/2 · Q/2 - P/2 · Q/2) = 0.
- Polarising the cubic form in (A_diag, A_off, P, Q) at (C, C_P, C_Q):
  - the d-term gives (1/2) sum_{i,l} d_i Q_il^2 = (1/4) sum_{i != j}(d_i + d_j) Q_ij^2;
  - the A_off P Q term gives -sum A_ij P_ij Q_ij = sum P^2 Q^2;
  - the traces give 0.
- Contracting the Q equation with Q gives sum_{i != j} Q^2(1 - d_i - d_j - 2P^2) = tr Q^3. Substituting yields F(C, C_P, C_Q) = (1/2) norm(Q)^2 - (1/4) sum(d_i + d_j) Q^2 - (1/2) tr Q^3, which equals (1/2)(norm(A_off)^2 + norm(Q)^2/2) - (1/4) tr Q^3 = (1/2) norm(C_Q)^2 - (1/4) tr Q^3. The screen matches L_PQ to all digits.
- The rows of L sum to <C, C_k> = G_kk, so (1,1) is an eigenvector with eigenvalue 1 and the other eigenvalue is 1 - L_PQ(1/G_P + 1/G_Q). Substituting gives the stated formula and the criterion q tr Q^3 > 2 norm(C_Q)^4. The screen's eigenvalue equals the formula at every solution.
- Minor gap: the statement does not exclude Q = 0, where C_Q = 0 and the formula divides by zero. It holds for C != I/c, which by (3) is Q != 0.

## Q5. L271 screens (screen, not evidence)

| m | solution | Q support | tr Q^3 | split eigenvalue | top slice eigenvalue on C-perp | q vs d/c^2 |
|---|---|---|---|---|---|---|
| 4 | edge | 2 indices | 0 | 0.380 | 0.613 | 0.861 vs 0.778 |
| 4 | triangle (two nearby distinct solutions) | 3 indices | 0.114, 0.115 | 0.426 | 0.549 | 0.895 vs 0.778 |
| 5 | triangle | 3 indices | 0.122 | 0.419 | 0.553 | 0.895 vs 0.703 |
| 5 | edge (edge-type seeds) | 2 indices | 0 | 0.351 | 0.630 | 0.848 vs 0.703 |

- The record's 0.43, 0.42 and 0.35 match the m = 4 triangle, the m = 5 triangle and the m = 5 edge. Its slice range 0.55 to 0.63 matches.
- Minor: the m = 4 edge solution (split 0.380, slice 0.613) also exists and is not among the quoted values, although the text says "at every positive solution found". It does not change the qualitative claim, since the split eigenvalue is still below 1/2 and the slice eigenvalue is inside the quoted range. The list should add it or say which solutions it covers.

## LEAN

- idir_test: abstract symmetric bilinear B with B(C,.) = <C,.>, B(I,I) = c<I,C> and <I,I> = d. It concludes orthogonality, B(H,H), norm(H)^2 and the equivalence, which is exactly L270 (1)'s algebra. The positivity of norm(H)^2, needed to read the ratio as lambda_I, is prose, which is correct.
- idir_heavy: c > 0, q > 0 and the test give q c^2 > d. Faithful, and τ is unconstrained.
- torus_light_y: the hypotheses are the Cartan Cauchy-Schwarz bound times m and lightness times m. The identification q0 = f(y0) is prose. Faithful.
- l267_idir_n9: exact arithmetic, and τ and q agree with my recomputation.
- pq_entry, pq_square, pq_triangles: faithful algebraic cores. The root-pair bookkeeping is prose, as the table says.
- qsplit_test: encodes the second eigenvalue as trace minus 1 with L_PQ = G_Q/2 - κ/4, which is faithful to (4). The pencil and row-sum step is prose.
- No hypothesis assumes its conclusion, and each hypothesis set is satisfiable by the record's data.
