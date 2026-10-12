# Reviewer 312, PARTIAL, salvaged from the log

**This is not a verdict and nothing in it may be cited until rebuilt.** The reviewer was stopped by the user before filing, so what follows is its heartbeat log verbatim, the only durable trace of the work. Its brief covered M1 (Lemma L69), M2 (the B1 resolution), M3 (the 1.107x cushion), M4 (the endgame's positivity step), M5 (the mass route as a dead end) and M6 (census dimension).

```
PID 73559 | r312 Gate2 audit start 2026-09-01T09:03:33Z
PHASE PLAN: P0 read record (lemma69/graded-half, bounds, diagonal-half) | P1 build own Weyl basis + Q + L_e from scratch, self-test | P2 M1 derive the 1/(p-1)+1/(q-1)-1/(n-1)<=1/3 inequality, attack assembly | P3 M2 H_A leaves Weyl, projection table, L_e-invariance | P4 M3 verify r305 npy points, frame-independent padding certificate, hunt counterexample | P5 write reviews/REVIEW_r312.md
[P2 start] M1 algebra re-derived from scratch, INDEPENDENT of repo scripts.
  Own derivation: product of Einstein factors, R block-diag on Lambda^2, Weyl part W = R - K_avg*Id (Einstein), K_avg=rho/(n-1), factor a: R_a=W_a+(rho/(n_a-1))Id_a.
  ||W||^2 = sum_a ||W_a||^2 + [sum_a n_a/(2(n_a-1)) - n/(2(n-1))] * rho^2 ... at rho=1 the bracket coefficient is 1/2 each.
  With rho=1/2 (Einstein const 1/2 normalisation): B = sum_a f(n_a) - n/(8(n-1)), f(m)=m/(8(m-1)). CONFIRMS record's B exactly.
  Cross-check: balanced p=q=n/2 gives ||W||^2 = n^2/(8(n-1)(n-2)) = 1/(4 theta_0^2), theta_0^2=2(n-1)(n-2)/n^2. MATCHES record.
  Normalisation link CONFIRMED analytically: unit-norm critical W with Q(W)=theta W rescales to W_nat=W/(2theta) with Q(W_nat)=(1/2)W_nat, so ||W_nat||^2=1/(4theta^2); theta>=sqrt(3/2) <=> ||W||^2<=1/6. EXACT.
  NEW-STEP inequality: (1/8)[1 + 1/(p-1)+1/(q-1)-1/(n-1)] <= 1/6  <=>  1/(p-1)+1/(q-1)-1/(n-1) <= 1/3. CONFIRMED.
  p=2: LHS>1. p=3: LHS>1/2. p=4: <=> q>=n, impossible at every n. p=5: 5/((n-6)(n-1))<=1/12 <=> n^2-7n-54>=0 <=> n>=11.64.. => n>=12. ALL CONFIRMED.
  BONUS found, stronger than record: for k factors ||W||^2 = (1/8)[(k-1) + sum 1/(n_a-1) - 1/(n-1)], so k>=3 gives >=1/4 > 1/6 OUTRIGHT -- multi-factor excluded without any Jensen/balanced argument.
[P2 numeric] Own build CONFIRMS: I#=(n-2)I, dim Weyl_n = n(n+1)(n+2)(n-3)/12 at n=4,5,6.
  Einstein sphere product with rho=1 satisfies Q(W)=1*W exactly (resid <3e-16) at (3,3),(3,4),(3,5),(4,4),(2,4),(4,5),(5,5),(5,7).
  => normalisation Q(W_nat)=(1/2)W_nat at rho=1/2, and ||W_nat||^2 = 1/(4 theta^2) verified to 1e-16 at all eight. RECORD'S NORMALISATION LINK CONFIRMED.
  ||W||^2 = (1/2)[p/(p-1)+q/(q-1)-n/(n-1)] at rho=1 -- exact at all eight.
  theta(S^5xS^7)=1.228239157725981 (record 1.228239158 OK); theta(S^3xS^5)=1.115546702 OK; theta(S^5xS^5)=1.2 exact.
[P2 next] enumerate equivariant graded points directly: commutant of so(k)+so(l) and of u(n/2) inside Weyl_n.
```
