# REVIEW r1217: I73 class ceiling, Batch 22 (the quartic bound as a principal-angle inequality)

Log: agent_logs/r1217.log. Claim read verbatim from reviews/2026-09-26-I73-class-ceiling.md, section "Batch 22". Every step was rebuilt by hand from the definitions first. A screen (sage -python, 1.5 s, script in the session scratchpad) then checked each identity at n = 5, 6, 7, 9. It is reported as a screen only.

| claim | verdict |
|---|---|
| C1 | CONFIRMED |
| C2 | CONFIRMED |
| C3 | CONFIRMED with range repair: "a zero angle needs d >= 2(n-2)" holds at n = 5 and n >= 7, and is false at n = 4, 6 |
| C4 | CONFIRMED |
| C5 | CONFIRMED: an obstacle, stated as open. The reformulation is new to findings/ |

## C1

Setting: C = -sum_a ad_{e_a}^2. On g (x) g the total Casimir is C (x) 1 + 1 (x) C - 2 Omega, so Omega = (2 C_adj - C_lambda)/2 on each summand. The sign is right. In the record normalisation C_lambda = <lambda, lambda + 2 rho> in the standard epsilon basis: this gives C_vec = n-1 and C_adj = 2(n-2), matching <C_adj z,z> = sum_{a,b} <[e_a,e_b],z>^2 = 2<(I#I)z,z>.

- Lambda^2 g = S_{(2,1,1)}(R^n) as a GL(n) module (the dimensions agree: N(N-1)/2 = n(n+1)(n-1)(n-2)/8). Under O(n) it splits into [2,1,1] plus the single trace [1,1], which is the adjoint copy A. C_{[2,1,1]} = 6 + (4n-14) = 4(n-2) = 2 C_adj, so Omega = 0 on H. On A, Omega = (4(n-2) - 2(n-2))/2 = n-2.
- Sym^2 g = S_{(2,2)} plus S_{(1,1,1,1)}. Under O(n), S_{(2,2)} splits into [2,2], [2] and [0]. The Casimirs 0, 2n, 4n-4, 4n-16 on [0], [2], [2,2], Lambda^4 give Omega = 2(n-2), n-4, -2, 4.
- Multiplicities: 1, binom(n+1,2)-1, dim W_n, binom(n,4).
- Omega on Sym^2 is exactly 2(I#.): sum_a ad_a R ad_a^T has (x,y) entry sum c_{ijx} R_{jl} c_{ily} = 2(I#R)_{xy}.

Screen at n = 5, 6, 7: on Lambda^2 g the eigenvalue n-2 has multiplicity N and every other eigenvalue is 0. On Sym^2 g the eigenvalues are {2(n-2):1, n-4:binom(n+1,2)-1, -2:dim W_n, 4:binom(n,4)}, exactly. Omega(R) = 2(I#R) holds to 0.0 at a random symmetric R. At n = 6 the [2,1,1] summand splits under SO(6) into self-dual and anti-self-dual halves, and both carry the same Casimir, so the statement is unaffected.

## C2

Take beta(x wedge y) = [x,y] with e_b wedge e_c orthonormal. Then <beta beta^T z,z> = sum_{b<c} <[e_b,e_c],z>^2 = <(I#I)z,z>, so beta beta^T = (n-2) I. beta^T beta has the same nonzero spectrum, and its range is im beta^T = {phi_z} = A, so beta^T beta = (n-2) P_A. In the wedge basis beta^T beta also equals Omega restricted to Lambda^2 g (screen, 2e-16).

- L244 extended bilinearly gives <(Pi#Pi)z,z> = sum_{i<j} <[v_i,v_j],z>^2 = <beta L beta^T z,z> with L = Lambda^2 Pi. Both sides are symmetric, so they are equal as operators.
- ||Pi#Pi||_F^2 = tr(beta L beta^T beta L beta^T) = (n-2)^2 tr(L P_A L P_A). The operator L P_A L has eigenvalues cos^2 of the principal angles between Lambda^2 V and A, so the trace is sum cos^4.
- The normalisations agree: the Frobenius norm is the trace on End(g), which is the norm L257 uses.
- The equivalence with L257 is exact: ||Pi#Pi||_F <= (n-2)d/sqrt N if and only if sum cos^4 <= d^2/N.

Screen at n = 7, 9 with random V of d = 3, 8, 15: Pi#Pi - beta L beta^T is at most 3e-15. F^2/(n-2)^2, tr(L P_A L P_A) and the sum of the fourth powers of the singular values of Q_{Lambda^2 V}^T Q_A agree to 1e-15.

## C3

- **Equality at V = g.** L = I, so sum cos^4 = tr P_A = N = d^2/N. CONFIRMED.
- **so(k).** [so(k), so(k)] lies in so(k), so Pi#Pi vanishes off so(k), and on so(k) it is so(k)'s own I#I = (k-2) I. Hence Pi#Pi = (k-2) Pi. The nonzero eigenvalues of L P_A L are those of beta L beta^T/(n-2), namely (k-2)/(n-2) with multiplicity d, and the rest are 0. Screen at n = 7, 9 and k = 4, 5, 6: cos^2 clusters exactly at (k-2)/(n-2) x d, and the rest are 0.
- **Zero angle.** A zero angle is a common unit vector of Lambda^2 V and A, that is phi_z in Lambda^2 V. Under the identification phi_z(x,y) = <[x,y],z> = <x, [y,z]>, phi_z is the skew operator ad_z (up to sign), and that operator lies in Lambda^2 V if and only if im ad_z is contained in V. CONFIRMED.
- **"which needs d >= 2(n-2)". This needs a range.** The minimal rank of ad_z is N minus the maximal centraliser dimension. For one block of complex dimension m with an (n-2m)-dimensional kernel, the centraliser has dimension m^2 + (n-2m)(n-2m-1)/2. This is convex in m, and merging blocks only enlarges it, so the maximum sits at m = 1 or at m = floor(n/2).
  - Comparing the endpoints, rank ad_z >= 2(n-2) holds if and only if n = 5 or n >= 7.
  - At n = 6 the complex structure J has centraliser u(3) of dimension 9 and rank ad_J = 6 < 8. The screen confirms rank ad_J = 6.
  - At n = 4 a self-dual z has rank ad_z = 2 < 4.
  - The batch works at L257's n >= 9, where the claim is true. The sentence should carry "(n = 5 or n >= 7)" or "for n >= 9". This is the same small-n phenomenon (Lambda^2_+) that makes the quartic bound fail at n <= 8.

## C4

- **First identity.** With the plain trace HS, <M_a,M_b> = sum_{i,j} <[e_a,v_i],v_j><[e_b,v_i],v_j>. Ad-invariance gives <[e_a,v_i],v_j> = <e_a,[v_i,v_j]>, so the sum is sum_{i,j} <[v_i,v_j],e_a><[v_i,v_j],e_b> = 2(Pi#Pi)_{ab}. The factor and sign are right, and the sign drops out because each term is a product of two like factors.
- **Second identity.** Put T = sum_a M_a (x) M_a on V (x) V and let S be the swap.
  - Index bookkeeping gives sum_{a,b} tr(M_a M_b M_a M_b) = tr(T^2 S).
  - The M_a are skew, so T is symmetric and commutes with S. Then tr(T^2 S) = ||T|_Sym||^2 - ||T|_Lambda||^2 = ||T||^2 - 2||T|_Lambda||^2.
  - ||T||^2 = sum_{a,b} <M_a,M_b>^2 = 4||Pi#Pi||^2.
  - T = (pi (x) pi) Omega (pi (x) pi), and Omega|_{Lambda^2 g} = beta^T beta. So T|_{Lambda^2 V} = L beta^T beta L, whose squared norm is ||Pi#Pi||^2. This step uses both Omega = n-2 on A and Omega = 0 on H, as the note says.
  - Hence sum tr((M_a M_b)^2) = 4F^2 - 2F^2 = 2F^2, and the Lambda^2 V share is exactly a quarter.
- **Screen**, n = 7, 9 at d = 3, 8, 15: <M_a,M_b> - 2 Pi#Pi is at most 6e-15. sum tr((M_a M_b)^2) = 2F^2 to 1e-13. ||T||^2 = 4F^2, and ||T on Lambda^2 V||^2/||T||^2 = 0.25000000 every time.

## C5

- **The bound quoted as "only".** The eigenvalues (n-2) cos^2 lie in [0, n-2]. Their sum is tr Pi#Pi = (1/2) sum_i ||ad_{v_i} pi_V||^2 <= (1/2) d * 2(n-2) = (n-2)d. So ||Pi#Pi||_F^2 <= (n-2)^2 d, which is weaker than the target (n-2)^2 d^2/N by the factor N/d. CONFIRMED.
- **Framing.** The closing sentence is labelled "Open" and claims no result. CONFIRMED.
- **Record search.** Grepped findings/ for "adjoint copy", "[2,1,1]", "Casimir" and "principal angle". There is no Omega spectrum on Lambda^2 so(n) and no adjoint copy on file. The principal-angle hits (findings/diagonal-half.md, findings/bispectral.md) concern 2-planes in R^n and are unrelated. Brauer-pairing mentions the label (2,1,1) only as an admissibility example. The reformulation is new to the findings record.

## Lean table

C1-C5 are representation-theoretic identities, checked by hand and by screen. Typing is owed if the principal-angle form is ever used as a step. The C3 range repair should be carried into any statement.
