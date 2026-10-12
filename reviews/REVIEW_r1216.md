# Review r1216: batch 22 of the I73 class-ceiling note, the quartic bound as a principal-angle inequality

Adversarial Gate 2 reader. Target: the section "Batch 22" of [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md). Analysis-only footing: every numerical line below is a screen of seconds on objects constructed for it (script in the session scratchpad, about 55 s at n = 5, 6, 7, 9), never evidence for a positive claim. Conventions used: e_i ^ e_j orthonormal, <A,B> = (1/2) tr(A^T B), c_{jab} = <[e_a,e_b],e_j> totally antisymmetric, (A#B)_{jk} = (1/2) sum c_{jcd} c_{kef} A_{ce} B_{df} (the index formula of L199, equivalent to L244's per-vector formula).

## Verdicts

| Claim | Verdict | Note |
|---|---|---|
| C1 Casimir spectra | CONFIRMED | Casimir values rederived, multiplicities screened at n = 5, 6, 7 |
| C2 principal-angle identity | CONFIRMED | holds with the orthonormal-wedge convention for Lambda^2 g, which the note's beta beta^T = (n-2) I fixes |
| C3 equality case, so(k), zero angles | CONFIRMED with a range qualifier | "d >= 2(n-2)" needs n = 5 or n >= 7; false at n = 4, 6. Harmless at L257's n >= 9 |
| C4 two identities | CONFIRMED | the second is Bianchi (Jacobi) for R_{ijkl} = <[v_i,v_j],[v_k,v_l]>, equivalently Omega = 0 on H |
| C5 obstacle paragraph, novelty | CONFIRMED | stated as an obstacle; the reformulation is on the record nowhere in findings/ |

## C1 Casimir spectra

- Omega = sum_a ad_a (x) ad_a. With C = -sum rho(e_a)^2, the Casimir of g (x) g is C_adj (x) 1 + 1 (x) C_adj - 2 Omega, so Omega = (2 C_adj - C_lambda)/2 on each isotypic summand. Correct.
- Normalisation: sum_{i<j} (E_ij - E_ji)^2 = -(n-1) I, so C_vec = n-1, which is <lambda, lambda + 2 rho> with eps_i orthonormal and rho = sum (n/2 - i) eps_i. Then C_adj = |eps1+eps2|^2 + 2<eps1+eps2,rho> = 2 + 2n - 6 = 2(n-2). Correct, and it equals (1/2) sum_{c,d} c_{jcd}^2 doubled, i.e. I#I = (n-2) I.
- Lambda^2 g: Lambda^2(Lambda^2 R^n) = S_(2,1,1) as GL(n), restricting to [2,1,1] + [1,1] under O(n). C_[2,1,1] = 6 + 2(2n-7) = 4n-8 = 2 C_adj, so Omega = 0 on H. On A = [1,1]: Omega = (4(n-2) - 2(n-2))/2 = n-2. Correct.
- Sym^2 g = S_(2,2) + S_(1,1,1,1) restricts to [0] + [2] + [2,2] + [1,1,1,1]. Casimirs 0, 2n, 4n-4, 4n-16 give Omega = 2(n-2), n-4, -2, 4. Correct.
- "the second list being 2(I#)": (I#B) = (1/2) sum_c ad_c B ad_c^T and Omega(B) = sum_c ad_c B ad_c^T, so Omega = 2(I#) on symmetric B. Matches r1214's scalars n-2, (n-4)/2, -1, 2.
- Screen: n = 5, 6, 7, Lambda^2 spectrum {n-2 x N, 0 x rest}; Sym^2 multiplicities 1, 14/20/27, 35/84/168, 5/15/35, as stated. Omega(B) - 2 I#B below 1e-15.
- Remark: at n = 8 the scalars n-4 and 4 coincide, so a numerical diagonalisation there would merge traceless Ricci and Lambda^4. The note screens n = 5, 6, 7 only, so nothing is misread.

## C2 principal-angle identity

- beta(e_c ^ e_d) = [e_c,e_d] on the orthonormal basis e_c ^ e_d (c < d). Then (beta beta^T)_{jk} = sum_{c<d} c_{jcd} c_{kcd} = (1/2) sum_{c,d} = (n-2) delta_{jk}. Correct. With the tensor embedding (e_c(x)e_d - e_d(x)e_c)/sqrt2 the value would be 2(n-2), so the convention matters and the note's is the consistent one.
- beta^T z = sum_{c<d} c_{zcd} e_c ^ e_d = phi_z, so im beta^T = A, and beta beta^T = (n-2) I makes beta^T beta/(n-2) the orthogonal projector P_A. Correct, and consistent with C1 (Omega restricted to Lambda^2 g equals beta^T beta).
- Pi#Pi = beta (Lambda^2 Pi) beta^T: expanding, (beta L beta^T)_{jk} = sum_{e<f} c_{kef} sum_{c,d} c_{jcd} Pi_{ce} Pi_{df}, and the summand is symmetric under e <-> f (two sign flips), so this is (1/2) sum over all e,f, the index formula. Correct.
- ||Pi#Pi||_F^2 = tr(L beta^T beta L beta^T beta) = (n-2)^2 tr(L P_A L P_A), and for two orthogonal projectors tr((P_A L P_A)^2) = sum cos^4 of the principal angles. Correct. L257 becomes sum cos^4 <= d^2/N exactly.
- Screen at n = 9, random V of d = 5, 12, 20: beta beta^T - (n-2) I = 0, P_A idempotent, Pi#Pi - beta L beta^T below 1e-15, and the three quantities ||Pi#Pi||^2/(n-2)^2, tr(L P_A L P_A), sum cos^4 agree to 15 digits.

## C3 equality case, so(k), zero angles

- V = g: Lambda^2 V contains A, N angles zero, sum = N = d^2/N. Correct.
- V = so(k): for j in V, (Pi#Pi)_{jj'} = (1/2) Killing of so(k) restricted = (k-2) delta. For j outside V, [V,V] in V kills every term. So Pi#Pi = (k-2) Pi, and the nonzero cos^2 (eigenvalues of Pi#Pi/(n-2)) are (k-2)/(n-2) on d directions. Correct. Screen at n = 9, k = 4, 6, 8 reproduces it. The inequality then reads (k-2)^2/d <= (n-2)^2/N, L256's monotonicity.
- Zero angle: a nonzero element of Lambda^2 V intersected with A is phi_z with phi_z(x,y) = -<x, ad_z y>, so phi_z lies in Lambda^2 V exactly when the skew operator ad_z is supported on V x V, equivalently im ad_z in V. Correct.
- "which needs d >= 2(n-2)": d >= rank ad_z = N - dim c(z). The centraliser of z with k equal eigenvalue pairs is u(k) + so(n-2k), of dimension k^2 + (n-2k)(n-2k-1)/2, convex in k, so the max is at k = 1 or k = floor(n/2). At k = 1 rank ad_z = 2(n-2). At k = n/2 (n even) the dimension is n^2/4, which exceeds 1 + (n-2)(n-3)/2 at n = 4 and n = 6 and ties at n = 8. **So the minimum of rank ad_z is 2(n-2) for n = 5 and n >= 7, but 6 < 8 at n = 6 (z a complex structure) and 2 < 4 at n = 4.** Screen: at n = 6 the complex structure J has rank ad_J = 6. Correction: add "for n >= 7" (or n = 5, n >= 7). Inside L257's range n >= 9 the sentence is true as written.

## C4 the two identities

- M_a = pi_V ad_a pi_V, HS the plain trace inner product on operators of g. tr(M_a^T M_b) = sum_{i,j} <[e_a,v_j],v_i><[e_b,v_j],v_i> = sum_{i,j} <[v_i,v_j],e_a><[v_i,v_j],e_b> = 2 (Pi#Pi)_{ab}. Correct (with the record's (1/2) tr normalisation on operators it would read (Pi#Pi)_{ab}, so "HS" must mean the plain trace, the standard reading).
- Second identity, independent derivation: sum_a (M_a)_{ij}(M_a)_{kl} = <[v_i,v_j],[v_k,v_l]> =: R_{ijkl}, an algebraic curvature tensor on V (Bianchi from Jacobi of the full bracket). Then sum_{a,b} tr((M_a M_b)^2) = sum R_{ijkl} R_{jkli} = |R|^2 - sum R_{ijkl} R_{ikjl} = |R|^2/2, and |R|^2 = 4 ||Pi#Pi||_F^2 by L257's "What it gives" line. So the value is 2 ||Pi#Pi||_F^2. Correct, signs included (M_a^T = -M_a, two signs cancel).
- The note's route: T = sum_a M_a (x) M_a commutes with the swap S, ||T||_F^2 = sum <M_a,M_b>^2 = 4X (X = ||Pi#Pi||_F^2), and tr(T^T T S) = sum tr((M_a M_b)^2), so ||T|_{Lambda^2 V}||^2 = (4X - 2X)/2 = X, a quarter. Equivalently T|_{Lambda^2 V} = (n-2) L P_A L by Omega = (n-2) P_A on Lambda^2 g, whose norm is X by C2. So "since Omega vanishes on H" is a valid justification.
- Screen at n = 9, d = 5, 12, 20: HS - 2 Pi#Pi below 4e-15, sum tr((M_a M_b)^2) = 2X to 13 digits, ||T||^2 = 4X, ||T P_Lambda||^2 = X, [T,S] = 0.

## C5 novelty and the obstacle paragraph

- "Where it stops" is worded as an obstacle and closes with "Open". Its arithmetic is right: the nonzero eigenvalues of Pi#Pi are (n-2) cos^2 phi_k in [0, n-2], tr Pi#Pi <= tr Pi#I = <I#I,Pi> = (n-2) d (using Pi#(I-Pi) >= 0), so ||Pi#Pi||_F^2 <= (n-2)^2 d, weaker than (n-2)^2 d^2/N since d <= N.
- Grep of findings/, routes.md and plan.md for "principal angle", "adjoint copy", "[2,1,1]", "Schatten": the only principal-angle hits (diagonal-half.md lines 1192, 1312, 1324) concern angles between 2-planes in R^n, unrelated. The Casimir decomposition of Lambda^2 so(n) and the cos^4 reading of L257 are new to the record. The Casimir values themselves are classical representation theory and the note cites them as such.

## Lean

None owed at this stage: representation-theoretic identities checked by screen and by hand here. If the principal-angle form enters a proof, beta beta^T = (n-2) I and Pi#Pi = beta (Lambda^2 Pi) beta^T are the two statements to type.
