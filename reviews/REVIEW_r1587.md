# Review r1587: L270 (the direction I and heaviness, H from U_s') and L271 (the torus system in P and Q)

Log: agent_logs/r1587.log

| claim | verdict | reason in one line |
|---|---|---|
| H1 L270 (1) the eigenvalue on span{C, I} | CONFIRMED | B(C,.)=<C,.> follows from C#C=C, {C,H} is orthogonal for both B and the metric, and the ratio (cq tau - tau^2)/(qd - tau^2) re-derives |
| H2 L270 (2) heaviness, and L264 (4) as a case | CONFIRMED | (c tau - d)^2 >= 0 gives strict q > d/c^2; the SU(3) in G2 witness gives lambda_I = 15/28 exactly, which is L264 (4)'s value |
| H3 L270 (3) H from U_s' | CONFIRMED | uses only stability and positive definiteness on a simple h (L264 (1)-(2)); d/c_h^2 >= N/(n-2)^2 is L260 (3)'s reading of L256 |
| H4 L270 (4) the torus bound y < y0 | CONFIRMED | ||u_alpha|| = 1 gives tr A = 2y, Cauchy-Schwarz holds on the m x m block, and f(y0) = N/c^2 checks |
| H5 L270 screens | CONFIRMED | n=9 value recomputed exactly; the torus solutions screened at m=4,5 are all heavier than I/c |
| Q1 L271 (1) F and the norm on the torus slice | CONFIRMED | 3<A,A_mu> + 6T_3 holds for arbitrary A; the four even sign patterns and tr P^3 + tr Q^3 = 12 T_3 are verified; a screen on so(8) matches |
| Q2 L271 (2) the P, Q system and its symmetries | CONFIRMED | the pair sums, u^T A u and the sum/difference re-derive; all three symmetries check (minor wording point on PD, see below) |
| Q3 L271 (3) Q = 0 only at I/c | CONFIRMED | C on the ij block has diagonal P/2 and off-diagonal +-Q/2, and A_off = -PQ, so Q=0 is coordinate-diagonal with positive weights and L261 applies |
| Q4 L271 (4) the Z2 split | CONFIRMED, one gap | the polarisation, contraction, row sums and eigenvalue re-derive; the statement needs C_Q != 0 (Q != 0), which it leaves unstated |
| Q5 L271 screens | PLAUSIBLE | support and sign claims reproduce at m=4,5; the list 0.43, 0.42, 0.35 misses the m=4 one-edge solution (0.38); the slice eigenvalue 0.55 to 0.63 was not checked |
| LEAN fidelity | CONFIRMED | every declaration states what the table says, with no circular or vacuous hypothesis |

## Method

I read each proof link by link and re-derived every step by hand from the brief's givens. After that I ran screens on so(8) and so(10), each taking seconds, with /usr/bin/python3 and numpy/scipy. The screens do four things. They build the # product from the structure constants. They build the root planes as kernels of ad(h_i -+ h_j). They compare C#C and F against L271 (1)-(2) at a random torus-invariant C with arbitrary A. They solve the P, Q system by root-finding from 60 random seeds (m=4) and 40 random seeds (m=5). All of this is screening and is offered as corroboration only, never as proof. A top-eigenvalue computation on the whole torus slice was started and then abandoned because it was too slow to count as a screen.

## H1, L270 (1)

- B(X,Y) = F(C,X,Y) is symmetric because F is. B(C,Y) = <C#C,Y> = <C,Y>. <C#I,I> = F(C,I,I) = <C,I#I> = c tau.
- H = I - (tau/q)C has <H,C> = 0, so B(C,H) = <C,H> = 0. On the basis {C,H} the pencil is diag(q, B(H,H)) against diag(q, ||H||^2), which gives the eigenvalues 1 and B(H,H)/||H||^2 = (c tau - tau^2/q)/(d - tau^2/q). That is the stated formula.
- ||H||^2 = d - tau^2/q > 0 holds exactly when C is not proportional to I, by the equality case of Cauchy-Schwarz. A multiple tI that is idempotent is I/c or 0, so C != I/c (with C != 0) is the right hypothesis. The equivalence with q(2c tau - d) > tau^2 follows by multiplying by q > 0.

## H2, L270 (2)

- If q(2c tau - d) > tau^2 >= 0, then 2c tau > d. Also tau^2/(2c tau - d) >= d/c^2 is equivalent to (c tau - d)^2 >= 0, so the bound q > d/c^2 is strict. The contrapositive gives lambda_I <= 1/2 whenever q <= d/c^2.
- For L264 (4), C = aP_k + bP_p with a != b and C, I = P_k + P_p independent, so the two planes coincide and the pencil on them is the same object.
- Witness (exact arithmetic): tau = 45/14, q = 351/392, d = 14, c = 4 give lambda_I = 15/28. From L264 (4), D = c_k y^2 + 4 alpha^2 x = 112/9 and 1/2 + c(2x-y)(y-x)/(2D) = 1/2 + 1/28 = 15/28. They agree. Also a = cx/D = 9/28 and b = c(y-x)/D = 3/28 reproduce C,, and q = 0.8954 > d/c^2 = 0.875, so C is heavier than I/c.

## H3, L270 (3)

- A maximiser exists by compactness and is PSD by L260 (1). By L264 (1), C = X/F(X) is a stable idempotent, PD on the semisimple h it is supported on (C = C|_h + 0). By L264 (2), h is simple. ||C||^2 = 1/F(X)^2 = 1/kappa_n^2.
- Stability against H in Sym^2 so(n) orthogonal to C implies stability against H in Sym^2 h, because # restricted to Sym^2 h is h's own # (h is closed under the bracket). So C is a stable PD idempotent of h in U_s''s sense. Nothing else about the maximiser is used.
- d/c_h^2 >= N/(n-2)^2 is the bound L260 (3) asserts for I/c_h "by L256". Reading L256's M(h) as the bracket mass sum ||[e_a,e_b]||^2 = 2 tr(I#I) = 2 c_h d, which matches L256's so(n) value 2(n-2)N, the cap becomes 2c_h/sqrt d <= 2(n-2)/sqrt N, which is the same bound. M is not defined in the brief, so this step rests on L260 (3) as given.
- U_s gives ||C||^2 = d/c^2, which implies U_s'. U_s' constrains only idempotents with ||C||^2 < d/c^2, so it is vacuous on heavier ones. Both statements are correct.

## H4, L270 (4)

- ||C||^2 = ||A||^2 + sum_alpha 2 mu_alpha^2, because each root plane has dimension 2. tr A_mu = 2 sum mu^2 ||u_alpha||^2 = 2y, since ||u_alpha||^2 = |alpha|^2/2 = 1. Cauchy-Schwarz on the m x m block gives ||A||^2 >= (tr A)^2/m.
- At I/c (c = 2m-2) every mu equals 1/(2m-2). There are m(m-1) positive roots, so y0 = m/(4(m-1)). Then 4y0^2/m + 2y0 = m(2m-1)/(4(m-1)^2) = N/c^2, with equality because A is scalar there. f(y) = 4y^2/m + 2y is increasing on y >= 0, so q < N/c^2 forces y < y0. Idempotency enters only through A = A_mu.

## H5, L270 screens

- tau = 3(1/2) + 10/16 + 20 sqrt13/32 = (17 + 5 sqrt13)/8. The expression q(14 tau - 36) - tau^2 = [873(-50 + 70 sqrt13) - 128(614 + 170 sqrt13)]/8192 = (39350 sqrt13 - 122242)/8192 > 0 is recomputed by hand. q = 873/1024 > 36/49.
- Screen: every non-uniform PD torus solution found has q above N/c^2. At m=4 these are 0.8611 (one edge) and 0.8951 (two triangle solutions), against 0.7778. At m=5 they are 0.8475 and 0.8946, against 0.7031. The G2 idempotents through L264 (4) are heavier by (2) together with H2.
- Wording point in "What it gives": H does not need "no torus-invariant PD idempotent lighter than I/c". It needs this only for the stable ones (U_s'). As written, the sentence overstates the requirement. It also covers only the torus family, which is not enough for H by itself.

## Q1, L271 (1)

- A#A = 0 because t is abelian. Hence (C#C)_t = A_mu for any A, and the root-plane coefficient is 2 mu u^T A u + S_alpha. Pairing with C, and weighting each root plane by 2, gives <A,A_mu> + 2<A,A_mu> + 2 sum mu_alpha S_alpha. S_alpha sums over unordered pairs with coefficient 1, and each triangle is counted once per member, so this equals 3<A,A_mu> + 6 T_3.
- (A_mu)_ii = 2 sum mu^2 (u_alpha)_i^2 = d_i. (A_mu)_ij takes -1/2 * 2U^2 from eps_i - eps_j and +V^2 from eps_i + eps_j, giving V^2 - U^2 = -PQ.
- Triangles on {i,j,k}: the closing signed sums are exactly (-,-,-), (-,+,+), (+,-,+) and (+,+,-), where a + marks an eps_a + eps_b root. (+,+,+) does not close. No triangle uses two roots on the same index pair, since eps_i +- eps_j combine to 2 eps. tr P^3 counts each unordered triple 6 times, which gives 12 T_3.
- Screen (so(8), random A, U, V > 0): F matches the formula to 1e-14, the norm matches, the t-part and every root-plane coefficient of C#C match to 1e-15, and C#C has no component outside the torus-invariant form.

## Q2, L271 (2)

- Pairs landing on eps_i - eps_j: (eps_i - eps_l, eps_l - eps_j) and (eps_i + eps_l, eps_j + eps_l), giving (U^2 + V^2)_ij. Pairs landing on eps_i + eps_j: (eps_i - eps_l, eps_l + eps_j) and (eps_i + eps_l, eps_j - eps_l), giving (UV + VU)_ij.
- u^T A u = (A_ii + A_jj -+ 2A_ij)/2. The two equations are U(1 - e + 2A_ij) = S_- and V(1 - e - 2A_ij) = S_+ with A_ij = V^2 - U^2. Their sum and difference give the P, Q pair, because 2(v^2 - u^2)(u - v) = -2P Q^2 and 2(v^2 - u^2)(u + v) = -2Q P^2 in the respective combinations.
- Symmetries: d = (1/2) sum (P^2 + Q^2) and A_ij = -PQ are symmetric under P <-> Q. Q -> SQS with A -> SAS fixes Q_ij^2, (P^2)_ij, the products A_ij P Q, and tr Q^3, while (Q^2) -> S Q^2 S. The map -(A_off, Q) flips only tr Q^3. All three hold.
- PD: C is PD exactly when A is PD and U, V > 0. At an idempotent A = A_mu is PD once all mu > 0, because the D_m roots span t, so "P_ij > |Q_ij|" is exact in the idempotent context the statement sets. For a general C the Cartan block needs its own condition, and the sentence could say "at an idempotent".

## Q3, L271 (3)

With R_- = span((e13 + e24)/sqrt2, (e14 - e23)/sqrt2) and R_+ as its companion, U P_- + V P_+ has diagonal (U+V)/2 on the block and off-diagonal entries +-(U-V)/2. So the block is diagonal exactly when Q_ij = 0. On t, A_off = -PQ vanishes too. The coordinate weights are P_ij/2 = U_ij > 0 and d_i > 0, so L261 gives I/(n-2). The screen confirms that the kernels of ad(h_i -+ h_j) give these planes.

## Q4, L271 (4)

- C_P + C_Q = C, with (P/2 + Q/2, P/2 - Q/2) = (U, V) and diag d + A_off = A_mu. <C_P, C_Q> = sum_{i<j} 2[(P/2)(Q/2) - (P/2)(Q/2)] = 0.
- Taking the st-coefficient of F(C + s C_P + t C_Q) gives 6F(C,C_P,C_Q) = 3 sum_{i,l} d_i Q_il^2 + 6 sum P^2 Q^2, using A_ij = -PQ. This is the stated expression. Contracting the Q equation gives sum (d_i + d_j) Q^2 = ||Q||^2 - 2 sum P^2 Q^2 - tr Q^3. Since ||C_Q||^2 = sum P^2 Q^2 + ||Q||^2/2, this yields F(C,C_P,C_Q) = ||C_Q||^2/2 - tr Q^3/4.
- Row sums: sum_l L_kl = <C#C, C_k> = ||C_k||^2. The pencil then has eigenvector (1,1) with eigenvalue 1, and the trace gives the second eigenvalue 1 - L_PQ(1/G_P + 1/G_Q). Substituting reproduces the stated formula and the criterion q tr Q^3 > 2||C_Q||^4.
- **Gap**: the formula divides by ||C_Q||^2 and so needs Q != 0. By (3) this means C != I/c. The statement should add this hypothesis. At I/c the plane degenerates, and the screen's pencil there has only a 1-dimensional span.
- Screen: the direct pencil eigenvalue on span(C_P, C_Q), computed from the # product, equals the formula at every non-uniform solution to 1e-10.

## Q5, L271 screens

| m | solution | Q support | tr Q^3 | split eigenvalue | q vs N/c^2 |
|---|---|---|---|---|---|
| 4 | one edge | {0,3} | 0 | 0.380 | 0.8611 > 0.7778 |
| 4 | triangle (non-uniform Q) | 3 edges on {0,1,3} | 0.114 | 0.4257 | 0.8951 |
| 4 | triangle (uniform Q) | 3 edges on {0,2,3} | 0.115 | 0.4264 | 0.8951 |
| 5 | triangle | 3 edges on {0,1,4} | 0.122 | 0.4193 | 0.8946 > 0.7031 |
| 5 | one edge | {0,3} | 0 | 0.3506 | 0.8475 |

- The support claim (two or three indices), the claim tr Q^3 = 0 on one edge, and the positive sign product on triangles all reproduce.
- The record's "0.43, 0.42 and 0.35" match m=4 triangle, m=5 triangle and m=5 one edge. The m=4 one-edge solution (0.38, the L267 type at n=8) is missing from the list. Either list it or name the m of each value.
- The eigenvalue 0.55 to 0.63 on C^perp over the whole torus slice was not screened. lambda_I at these solutions (0.60, 0.532, 0.505, 0.600) is a lower bound for it and is consistent with it.

## LEAN

- idir_test: its hypotheses (B symmetric, B C Y = <C,Y>, B I I = c<I,C>, <I,I> = d, <C,C> > 0) are exactly the proof's inputs, and the four conjuncts are the proof's four facts. Nothing is circular, and the hypotheses are satisfiable.
- idir_heavy: q > 0 and c > 0 imply q c^2 > d, which is faithful.
- torus_light_y: faithful once q >= 4y^2/m + 2y and q < f(y0) are multiplied by m. The hypothesis y0 >= 0 is harmless.
- l267_idir_n9: the constants match the brief (q = 873/1024, tau = 17/8 + 5 sqrt13/8, c = 7, d = 36).
- pq_entry: u(1 - e + 2(v^2 - u^2)) = sm and v(1 - e - 2(v^2 - u^2)) = sp are L268's pair equations with A_ij = v^2 - u^2, as derived above. Faithful.
- pq_square, pq_triangles and qsplit_test are faithful: qsplit_test's left side is 1 - L(1/gP + 1/gQ) with L = gQ/2 - kappa/4. The index-level contents (which pairs land where, the triangle patterns, and L_PQ itself) are prose, as the table says, and are confirmed above.
