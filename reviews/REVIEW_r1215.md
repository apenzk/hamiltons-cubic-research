# Review r1215: batch 19 of the I73 class-ceiling note (quartic bound on Pi#Pi)

Log: [agent_logs/r1215.log](../agent_logs/r1215.log). Object: the section "Batch 19" at the end of [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), read against [L255 and L256](../findings/second-order.md). Analysis-only footing: every number below is a screen of seconds on constructed objects, never evidence for a positive claim.

| claim | verdict |
|---|---|
| C1 compressed operator K_V, its quadratic form and trace | CONFIRMED |
| C2 the two Cauchy-Schwarz steps and M(V) <= 2 sqrt(d) ||Pi#Pi||_F | CONFIRMED |
| C3 equality on subalgebras | CONFIRMED at so(k) and every simple subalgebra; PLAUSIBLE as worded ("every irreducible subalgebra"), repair below |
| C4 chain theta <= M/(2d^{3/2}) <= ||Pi#Pi||_F/d <= sqrt2(n-2)/sqrt(n(n-1)) < theta0(n) | CONFIRMED |
| C4' the boxed bound as quantified (every n) | REFUTED for n <= 8, correction: the box carries n >= 9 |
| C5 curvature-tensor identification and star value | CONFIRMED; the clause "on subalgebras it is L256's condition" PLAUSIBLE, repair below |
| C6 attempts paragraph | PLAUSIBLE: conclusions correct, the list of isotypic scalars omits the Lambda^4 part |

## C1

With the record normalisation and L244's formula extended bilinearly, <(Pi#Pi)x,x> = (1/2) sum_{i,j} <[v_i,v_j],x>^2, so the compression of 2 Pi#Pi to V has the stated form. By invariance <[v_i,v_j],x> = <v_i,[v_j,x]> up to sign, so the form equals sum_j ||pi_V [x,v_j]||^2 = ||pi_V ad_x pi_V||_HS^2 for x in V. Summing over x = v_k gives tr K_V = sum_{ijk} <[v_i,v_j],v_k>^2 = M(V). The check I#I = (n-2)I holds in this normalisation (screen at n = 6).

## C2

K_V is a positive semidefinite d x d matrix with eigenvalues l_1..l_d, so M^2 = (sum l)^2 <= d sum l^2 = d tr K_V^2. Compression by an orthogonal projector does not increase the Hilbert-Schmidt norm, so tr K_V^2 = ||pi_V B pi_V||_F^2 <= ||B||_F^2 with B = 2 Pi#Pi. Directions are right and the constant is 2 sqrt(d).

## C3

For a subalgebra h = V, [v_i,v_j] lies in V, so Pi#Pi vanishes on V-perp and on the cross block, and on V it is (1/2) times the Casimir of ad on h with respect to the record form. At so(k) this is (k-2)Pi (screen: so(4) in so(6) gives 2 Pi exactly), M = 2d(k-2), and both inequalities of C2 are equalities. **Repair.** Equality in the first step needs K_V scalar, which holds on a simple subalgebra (Schur) or one whose simple ideals share one Casimir value, and fails on u(m) in so(2m), which acts irreducibly on R^{2m} but whose centre carries eigenvalue 0, and on Lambda^2_+(1234) + so(3)(567), Casimir values 2 and 1. Replace "every irreducible subalgebra" by "every simple subalgebra (more generally, every subalgebra whose ideals share one Casimir value)".

## C4

C2 gives M/(2 d^{3/2}) <= 2 sqrt(d) ||Pi#Pi||_F/(2 d^{3/2}) = ||Pi#Pi||_F/d, and the box gives (n-2)/sqrt(N) = sqrt2 (n-2)/sqrt(n(n-1)). The final inequality against theta0(n) = sqrt(2(n-1)(n-2))/n squares to n(n-2) < (n-1)^2, true for every n. Equality at Pi = I: ||(n-2)I||_F = (n-2) sqrt(N), the screen control 10 sqrt(66) = 81.2404 at n = 12 is right. The cap of L255 (M < 2 theta0 d^{3/2}) follows strictly.

**C4', the box as quantified.** The box says "for every rank-d projector onto a subspace of so(n)" with no range of n. It is false for n <= 8. Counterexample: Lambda^2_+ in so(4) inside so(n), d = 3, Pi#Pi = 2 Pi, ||Pi#Pi||_F = 2 sqrt3, ratio ||Pi#Pi||_F sqrt(N)/((n-2)d) = sqrt(2n(n-1)/3)/(n-2), which exceeds 1 exactly when n^2 - 10n + 12 < 0, that is n <= 8 (screen: 1.2172, 1.1180, 1.0583, 1.0184 at n = 5..8, then 0.9897 at n = 9). For d = 2 the maximum of ||[v_1,v_2]||^2 is 2 (Bloch-Iserles bound, attained on Lambda^2_+) and the bound fails for n <= 5. This is the same threshold as L256's n >= 9. Correction: write "for n >= 9 and every rank-d projector" in the box. The consequence the section draws (n >= 12) lies inside that range, so the implication stands.

## C5

Pi#Pi = (1/2) sum_{ij} w_ij w_ij^T with w_ij = [v_i,v_j], so ||Pi#Pi||_F^2 = (1/4) sum_{ijkl} <w_ij,w_kl>^2. R(x,y,u,w) = <[x,y],[u,w]> is antisymmetric in each pair and symmetric under pair exchange, and the Bianchi sum is <[[x,y],u] + [[y,u],x] + [[u,x],y], w> = 0 by invariance and Jacobi. The quartic sum is the Frobenius norm squared of the curvature operator of R restricted to Lambda^2 V with v_i ^ v_j orthonormal, so "the norm" is exact in the curvature-operator convention (half the tensor norm sqrt(sum R_ijkl^2)). Star: brackets [e_1i,e_1j] = +-e_ij are orthonormal, Pi#Pi is a projector of rank d(d-1)/2, norm sqrt(d(d-1)/2) (screen at d = 4 agrees).

**Repair to "on subalgebras it is L256's condition".** On a simple subalgebra the two coincide (M/d^{3/2} = 2||Pi#Pi||_F/d). On a semisimple one with ideals of dimensions d_i and Casimir values c_i, the quartic bound reads sum c_i^2 d_i <= (n-2)^2 d^2/N, which is stronger than L256's sum c_i d_i <= (n-2) d^{3/2}/sqrt(N). It still holds at n >= 9 from L256's per-ideal table: sum c_i^2 d_i <= max_i(c_i^2/d_i) sum d_i^2 <= max_i(c_i^2/d_i) d^2, and c_i^2/d_i <= (n-2)^2/N is L256's C/sqrt(d) <= 2(n-2)/sqrt(N). Suggested wording: "on subalgebras it follows from L256's table (and equals L256's condition on simple ones)".

## C6

- Monotonicity: P#Q >= 0 for P, Q >= 0 by the bilinear formula with positive weights, so I#Pi - Pi#Pi = (I - Pi)#Pi >= 0 and 0 <= Pi#Pi <= I#Pi. For 0 <= A <= B, tr A^2 <= tr AB <= tr B^2, so the Frobenius inequality follows. CONFIRMED.
- Isotypic scalars: n-2 on the trace, (n-4)/2 on traceless Ricci, -1 on Weyl are right, but Sym^2 Lambda^2 has a fourth O(n)-part, Lambda^4 (the Bianchi-violating part), on which I# acts by 2 (screen: eigenvalue 2 with multiplicity 5, 15, 35 at n = 5, 6, 7, the other multiplicities matching trace, Ricci and Weyl dimensions). A general projector has a Lambda^4 component, so the list should carry four scalars. The bound ||I#Pi||_F^2 >= (n-2)^2 d^2/N stands, since the decomposition is orthogonal and I#-invariant and the trace part alone contributes (n-2)^2 d^2/N.
- The op-times-trace bound: ||Pi#Pi||_op <= ||I#I||_op = n-2 by monotonicity, tr Pi#Pi = (1/2) sum_i ||ad_{v_i}Pi||_HS^2 <= (n-2)d, giving (n-2)^2 d. CONFIRMED.
- Refutation attempt on the quartic bound (screen, Grassmannian ascent with Lambda^2_+-seeded and random starts, seconds per n): n = 9, d in {2..12, 14, 15, 16, 20, 21, 25, 28, 30, 33, 35}; n = 10, d in {3, 4, 5, 8, 10, 14, 15, 21}; n = 11, d in {3, 8, 10, 15}; n = 12, d in {3, 8, 10, 15, 21}. No violator. Best ratios are subalgebras: Lambda^2_+ 0.9897 (n = 9), so(8) 0.9719 and codimension-one 0.9741 (n = 9, d = 28, 35), so(7) 0.9352, G2 0.9163, su(3) 0.9091 (n = 9). The margin at n = 9 is about 1 percent, set by Lambda^2_+, the same object that sets L256's threshold.
