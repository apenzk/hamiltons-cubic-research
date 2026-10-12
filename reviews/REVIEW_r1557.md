# Review r1557: batch 39, statement H from stable idempotents (U_s) and the stability exchange on two-component families

Log: agent_logs/r1557.log

Overall: CONFIRMED, with two wording corrections (B4) and one strengthening (B2).

| claim | verdict | reason in one line |
|---|---|---|
| B1 the reduction to U_s | CONFIRMED | a PSD global maximiser X gives C = X/F(X) with C#C = C, Theorem A's Hessian re-derived here gives L_C <= 1/2 on C^perp, Sym^2 h is #-closed, L260 (3) carries the norm bound |
| B2 several ideals fail the bound | CONFIRMED (stronger) | holds unconditionally: # splits block by block across ideals, so EVERY PD idempotent on a non-simple h has eigenvalue 1 of multiplicity >= number of ideals |
| B3 the plane eigenvalues and the exchange at y = 2x | CONFIRMED | formula, trace-minus-1, orthogonality by self-adjointness, the identity 2cx(c1+alpha)+2cy(y-x)-3D = c(2x-y)(y-x), (c1-alpha)/c at I/c and a' = b' = 1/c at y = 2x all check |
| B4 U_s on two-component families, and so(n) | CONFIRMED (scope wording) | established only for idempotents ON the ansatz; "fails whenever I/c satisfies it" is literally false at y = 2x, where the two coincide; the so(n) consequence from L259 (2) is correct |
| B5 y <= 2x as a ratio bound | CONFIRMED | y <= 2x iff c1 <= alpha(2 + d_p/d_k) using c = c1+x, y = c-2alpha, x d_k = alpha d_p |
| B6 the SU(3) in G2 values | CONFIRMED | D = 112/9, second eigenvalue 1/2 + (8/9)/(224/9) = 15/28, I/4 gives (3-4/3)/4 = 5/12 |
| B7 Lean statements | CONFIRMED | sharp_lin, twocomp_second_root_peirce and g2_su3_peirce say what the prose claims; the file builds clean |

## Method

Every step derived by hand from the givens. One screen only: `lake env lean HamiltonsCubic/Results/I117LemmaF.lean` (clean, no output). No numerical computation was run. The working note was read only as quoted in the brief.

## B1

- Criticality: on the unit sphere a maximiser X of F(X,X,X) satisfies 3 X#X = 2 mu X, and pairing with X gives X#X = F(X) X. So C = X/F(X) has C#C = C and norm 1/kappa_n. L260 (1) supplies a PSD global maximiser, so C is a minimal idempotent in Tkachev's sense: (Sym^2 so(n), #, trace pairing) is commutative with <A#B,C> fully symmetric (a metrized algebra) and the pairing is positive definite (Euclidean).
- Hessian, re-derived: with g = <x#x,x>, grad g = 3 x#x and Hess g = 6 L_x. Then (1/3) Hess(g/r^3) = (2 r^4 L_x - g r^2 - 3 r^2 (x^2 (x) x + x (x) x^2) + 5 g x (x) x)/r^7. The slide's denominator |x|^5 should be |x|^7 (and |c|^5 at c rather than |c|^3). The factor is positive, so the sign argument is unaffected. At c (where g = |c|^2) this is |c|^2((2L_c - 1)|c|^2 - c (x) c)/|c|^7. f is degree-0 homogeneous, so a local maximum on the sphere is a local maximum on A^x, the ambient Hessian is NSD, and on c^perp this gives L_c <= 1/2. Only local maximality is used.
- Normalisation: Tkachev's idempotent c^2 = c and L_c = multiplication by c match C#C = C and L_C = C#(.) exactly.
- Closure: for v, w in h, [v,w] is in h, so (vv^T)#(ww^T) is in Sym^2 h. Bilinearity over spectral decompositions gives closure of Sym^2 h (operators with range in h), and on it # is h's own product for the restricted form. C lies in Sym^2 h, so the bound restricts to C^perp in Sym^2 h.
- H from U_s: U_s gives C = sum Pi_i/c_i on the support h. L260 (3) (given) states that every such sum meets ||C||^2 >= N/(n-2)^2 by L256 for n >= 9. With ||C||^2 = 1/kappa_n^2 this gives kappa_n <= (n-2)/sqrt N, and I attains that value (L259 (2)). The record's passage from L256 to the bound is L260 (3)'s, and B1 uses it at the same n >= 9. U_s is needed only for global maximisers, which is weaker than U_s as stated.

## B2

- As written: C = sum Pi_i/c_i. Brackets between distinct ideals vanish, so Pi_i # Pi_j = 0 for i != j and L_C Pi_j = Pi_j. The combination (d_2/c_2) Pi_1 - (d_1/c_1) Pi_2 is orthogonal to C with eigenvalue 1 > 1/2. Correct.
- "Stable ones live on simple h" follows from U_s as stated. **It also holds without U_s.** Write A#B = (1/2) sum a_ij b_kl [e_i,e_k][e_j,e_l]^T in a basis adapted to h = h_1 + ... + h_m. Split C into diagonal blocks D_i (h_i to h_i) and off-diagonal blocks E_ij. Then D_i#D_j = 0 (i != j), D_i#E_jk = 0, and E_ij#E_kl = 0 unless {i,j} = {k,l}, with E_ij#E_ij in the ij block. So C#C = C splits into D_i#D_i = D_i and E_ij#E_ij = E_ij, and L_C fixes each nonzero block. A PD C has every D_i != 0 (it is PD on h_i), so eigenvalue 1 has multiplicity >= m. **Every PD idempotent on a non-simple h is unstable**, with no block-diagonality hypothesis. U_s is therefore needed only on simple h, where it reads: stable PD implies I/c. The record could state this as a lemma.

## B3

- L_C(uP_k + vP_p) = au c1 P_k + (av alpha + bu alpha) P_p + bv(xP_k + yP_p). This matches, and the plane is invariant.
- C is an eigenvector with eigenvalue 1, so the other eigenvalue is the trace minus 1, namely a c1 + a alpha + b y - 1. L_C is self-adjoint on the invariant plane with the restricted pairing (which is where x d_k = alpha d_p enters), so eigenvectors of distinct eigenvalues are orthogonal. If the two eigenvalues are equal, any direction orthogonal to C in the plane serves.
- Second root: substituting c1 = c - x, alpha = (c-y)/2 and D = (c-x)y^2 + (c-y)^2 x gives 2cx(c1+alpha) + 2cy(y-x) - 3D = -2cx^2 + 3cxy - cy^2 = c(2x-y)(y-x), which is the stated value. D > 0 (c1 > 0, x = alpha d_p/d_k > 0), so it exceeds 1/2 iff x < y < 2x. This uses only the two trace relations.
- I/c: (c1 + alpha + y)/c - 1 = (c1 - alpha)/c. This is <= 1/2 iff c1 - 2alpha <= x iff y <= 2x.
- y = 2x: alpha = (c1 - x)/2 and D = 4x(c1 x + alpha^2) = x(c1 + x)^2 = x c^2, so a' = b' = 1/c. Correct.

## B4

- **Established:** among idempotents of the form aP_k + bP_p with y <= 2x, only I/c can be stable. The PD second root (x < y < 2x) has an eigenvalue above 1/2 in a direction of C^perp inside Sym^2 g, and one direction suffices to fail. P_k/c1 is not PD. This is U_s restricted to the ansatz. It says nothing about PD idempotents of (Sym^2 g, #) off span(P_k, P_p). The bold sentence "U_s holds on every two-component family with y <= 2x" should carry "on the ansatz" explicitly, as the preceding sentence does.
- **Correction:** "the positive-definite second root fails the bound whenever I/c satisfies it" is false at y = 2x, where the second root is I/c and sits at eigenvalue exactly 1/2. The intended statement is: for x < y < 2x. The conclusion is unaffected.
- For y > 2x the plane test is only necessary, so U_s on the ansatz is open there. It is not refuted.
- so(n): L259 (2) makes I, hence I/(n-2), a strict local maximum of F/||.||^3 for n >= 7. B1's Hessian computation needs only local maximality, so L_{I/c} <= 1/2 on I^perp, the plane direction gives (c1 - alpha)/c <= 1/2, and so y <= 2x for every L263 pair in so(n), n >= 7. Correct. Screens by hand: so(n-1) in so(n) gives y = 0, and symmetric pairs always give y = 0. G2 in so(7) has Cas ratio 1/2 >= 1/2.5, and spin(7) in so(8) has 3/5 >= 3/7. All are consistent.

## B5

y <= 2x iff c - 2alpha <= 2x iff c1 - 2alpha <= x = alpha d_p/d_k iff alpha/c1 >= 1/(2 + d_p/d_k), and alpha/c1 = Cas_k(p)/Cas_k(k). Correct.

## B6

With c = 4, c1 = 3, alpha = 4/3, x = 1, y = 4/3: D = 48/9 + 64/9 = 112/9 and (a', b') = (9/28, 3/28). The second eigenvalue is 27/28 + 12/28 + 4/28 - 1 = 15/28, which matches the formula 1/2 + 1/28. I/4 gives 5/12. The data satisfy x d_k = 8 = alpha d_p, and c1 = 3 agrees with the dual Coxeter number of su(3) against 4 for g2 (index-1 embedding).

## B7

- sharp_lin: C#(uP_k + vP_p) = (a ck u + b x v)P_k + (b alpha u + (a alpha + b y) v)P_p over IsotropyPair's fields. Faithful.
- twocomp_second_root_peirce: a' ck + a' alpha + b' y - 1 - 1/2 = c(2x-y)(y-x)/(2D) under the two trace relations and D != 0. Faithful. The reading of the left side as an eigenvalue is prose, and the table says so.
- g2_su3_peirce: bare arithmetic 9/28*3 + 9/28*4/3 + 3/28*4/3 - 1 = 15/28, with no instantiation of the general theorem. It is faithful to "the value 15/28". The 5/12 at I/4 is untyped.
- Build: `lake env lean` on the file is clean.

## B8

- The slide's Hessian denominator typo (B1). It is harmless, but the transcription in references/ should be corrected or annotated.
- B2's unconditional multi-ideal instability is a free strengthening. It reduces U_s to simple h.
- No family within the givens' reach refutes U_s. Families with y > 2x can exist only in a g where I/c fails to be a local maximum. In so(n), n >= 7, none exist, by B4.
