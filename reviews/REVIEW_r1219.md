# REVIEW r1219: I73 class ceiling, Batches 23 and 24 (the quartic bound on coordinate subspaces)

Log: agent_logs/r1219.log. Claim read verbatim from reviews/2026-09-26-I73-class-ceiling.md, sections "Batch 23" and "Batch 24". Every step was rebuilt by hand from the definitions first. A screen (sage -python, 25 s, script in the session scratchpad) then checked C1, C2, C3, C5 and the bound. It is reported as a screen only.

| claim | verdict |
|---|---|
| C1 | CONFIRMED |
| C2 | CONFIRMED |
| C3 | CONFIRMED, with a proof supplied here. The attribution "Pearson's kurtosis bound" is loose: Pearson's inequality is a LOWER bound on kurtosis |
| C4 | CONFIRMED for the inequality. The equality clause is REFUTED as worded: equality holds exactly at K_n AND at the edgeless graph |
| C5 | CONFIRMED, constant 8 derived by hand |
| C6 | CONFIRMED |

## C1

- Basis: E_ij = e_i e_j^T - e_j e_i^T has <E_ij,E_ij> = (1/2) tr(E_ij^T E_ij) = 1, so the coordinate basis is orthonormal for the record inner product. [E_ij, E_jk] = E_ik, so every structure constant c_{j,cd} in this basis is 0 or +-1, and [c,d] of two coordinate elements is a single coordinate element or 0.
- # from the index formula (A#B)_{jk} = (1/2) sum c_{jcd} c_{kef} A_{ce} B_{df} (findings/bounds.md, the L244 formula). Pi is the diagonal 0/1 matrix on E, so (Pi#Pi)_{jk} = (1/2) sum_{c,d in E} c_{jcd} c_{kcd}.
- Off-diagonal: a pair (c,d) contributes to row j only when [c,d] = +-j, so c_{jcd} c_{kcd} = 0 for j != k. The operator is diagonal.
- Diagonal at j = E_ik: the ordered pairs (c,d) in E x E with [c,d] = +-E_ik are (E_im, E_mk) and its reverse for each common neighbour m, so the entry is (1/2)(2 codeg(i,k)) = codeg(i,k). This holds at every pair i<k, edge or not.
- The Frobenius norm is taken in a record-orthonormal basis, which this is, so ||Pi#Pi||_F^2 = S(G). It agrees with L257's form (1/4) sum <[v_i,v_j],[v_k,v_l]>^2. With d = e the quartic bound is S <= (n-2)^2 e^2 / N. At K_n every codegree is n-2, S = N(n-2)^2 and the right side is (n-2)^2 N, so equality.
- Screen: I#I = (n-2)I exactly at n = 5, 6. On all 1024 graphs at n = 5 and 400 random graphs at n = 6, Pi#Pi equals diag(codeg) with error 0 and ||Pi#Pi||_F^2 = S.

## C2

(A^2)_ii = d_i and (A^2)_ik = codeg(i,k) for i != k, and tr A^4 = sum_{i,k} (A^2)_ik^2 since A^2 is symmetric. So tr A^4 = sum d_i^2 + 2S. Screened on the same graphs.

## C3

Proof (Lagrange). Maximise F = sum x_i^4 on {sum x_i = 0, sum x_i^2 = 1}, a compact set, n >= 2. The gradients 1 and 2x are independent there (x is not constant), so at a maximiser 4x_i^3 = 2 mu x_i + nu for every i. Every x_i is thus a root of the cubic 4t^3 - 2 mu t - nu, whose roots r_1, r_2, r_3 sum to 0 and have e_2 = -mu/2. Multiplying by x_i and summing gives F = mu/2 = -e_2 = (r_1^2 + r_2^2 + r_3^2)/2.

- Three values used, with multiplicities p, q, r >= 1: r_1^2 + r_2^2 + r_3^2 <= p r_1^2 + q r_2^2 + r r_3^2 = 1, so F <= 1/2.
- Two values a (p times), b (q = n - p times): pa + qb = 0 and pa^2 + qb^2 = 1 give F = pa^4 + qb^4 = (p^2 - pq + q^2)/(npq) = (n^2/(pq) - 3)/n, largest at pq = n-1, where it equals c_n = (n^2 - 3n + 3)/(n(n-1)).
- c_n - 1/2 = (n-2)(n-3)/(2n(n-1)) >= 0, so the maximum is c_n, attained at one value against n-1 equal ones. For n >= 4 that is the only maximiser up to order and sign. At n = 3 every admissible x gives F = 1/2 = c_3 (for three numbers summing to 0, p_4 = p_2^2/2).

Check of the value: x = (n-1, -1, ..., -1)/sqrt(n(n-1)) gives ((n-1)^3 + 1)/(n^2 (n-1)) = c_n. Screen: 20000 random vectors at n = 3, 4, 5, 8 never exceed c_n.

The note cites "Pearson's kurtosis bound with the extremal skewness (n-2)/sqrt(n-1)". Pearson's inequality kurtosis >= skewness^2 + 1 bounds kurtosis from below and cannot give this. The upper bound n - 2 + 1/(n-1) on the population kurtosis of n points (which is n c_n) is a separate classical fact. Repair: replace the parenthesis by the Lagrange argument above or by a correct citation. The inequality itself is sound.

## C4

- 2S = tr A^4 - sum d_i^2 <= c_n t^2 - t^2/n, using C3 on the eigenvalues of A (tr A = 0) and Cauchy-Schwarz sum d_i^2 >= (sum d_i)^2/n = t^2/n.
- c_n - 1/n = (n^2 - 3n + 3 - (n-1))/(n(n-1)) = (n-2)^2/(n(n-1)). With t = 2e: S <= 2(n-2)^2 e^2/(n(n-1)) = (n-2)^2 e^2/N. Correct.
- Equality needs both steps tight: G regular, and (for n >= 4) spectrum (lambda, mu, ..., mu). If e > 0 then A = mu I + (lambda - mu) v v^T with zero diagonal, which forces v_i^2 = 1/n, and the off-diagonal entries (lambda - mu) v_i v_j lie in {0,1} and are nonzero, hence all 1. So A = J - I, which is K_n. At n = 3 regularity alone decides: K_3 or empty.
- **The edgeless graph (e = 0) also gives equality, 0 = 0.** "Equality exactly at K_n" should read "equality exactly at K_n and the edgeless graph", or "among graphs with at least one edge, exactly at K_n". Nothing downstream uses the equality case.
- Screen: largest S/bound over all graphs at n = 5 is exactly 1.

## C5

Let U_i be Frobenius-orthonormal in V and v_i = sqrt(2) U_i the record-orthonormal basis. For skew X, Y, <X,Y> = -(1/2) tr(XY), and [v_i,v_j] = 2[U_i,U_j]. So <[v_i,v_j],[v_k,v_l]> = -2 tr([U_i,U_j][U_k,U_l]) and ||Pi#Pi||_F^2 = sum_{ijkl} tr([U_i,U_j][U_k,U_l])^2.

Write T(ijkl) = tr(U_i U_j U_k U_l). It is cyclic, and reversal-invariant because each U is skew and four signs cancel. Hence T(jilk) = T(ijkl) and T(jikl) = T(ijlk) after relabelling. Expanding tr([U_i,U_j][U_k,U_l]) = T(ijkl) - T(ijlk) - T(jikl) + T(jilk) and squaring:

- the four squares each sum to tr Z^4, since tr of a product of Kronecker squares is the product of traces: tr Z^4 = sum T(ijkl)^2;
- of the six cross terms, two sum to +tr Z^4 and four to -X, with X = sum T(ijkl) T(ijlk);
- X = tr(Z^2 (Z^2)^Gamma), since Z^2 = sum U_i U_j (x) U_i U_j and transposing the second factor gives sum U_i U_j (x) U_j U_i.

Total 4 tr Z^4 + 2(2 tr Z^4 - 4X) = 8(tr Z^4 - tr(Z^2 (Z^2)^Gamma)). The constant 8 is right, with ||Pi#Pi||_F the record Frobenius norm and the U_i Frobenius-orthonormal. tr Z = sum (tr U_i)^2 = 0 and tr Z^2 = sum tr(U_i U_j)^2 = d, as stated, and Z is symmetric. Screen: the identity holds to 2e-15 at (n,d) = (5,3), (5,7), (6,3), (6,7). The sentence around it ("the mechanism to lift") is a heuristic, correctly labelled open.

## C6

coordinate_quartic takes n > 2, hid: T4 = D2 + 2S, heig: T4 n(n-1) <= (n^2 - 3n + 3) t^2, hcs: t^2 <= n D2, and concludes 2S n(n-1) <= (n-2)^2 t^2. These are exactly C2, C3 applied to A, and Cauchy-Schwarz, with denominators cleared (legitimate since n(n-1) > 0). The docstring states that all three enter as hypotheses and that the codegree reading of Pi#Pi is the note's, which matches the Lean table. The file compiles clean with lake env lean (no sorry, no warnings). It does not type the equality case, and claims none.

## Summary

The theorem S(G) <= (n-2)^2 e^2/N and hence the quartic bound on every coordinate subspace at every n >= 3 stand. Two text repairs: the Pearson attribution in the C3 step, and the equality clause (add the edgeless graph).
