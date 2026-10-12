# REVIEW r1186: per-vector ceiling kappa <= n - 5 - mu_m(x)/2

Log: agent_logs/r1186.log. Claim: reviews/2026-09-25-I73c-per-vector-rows.md, line 215. Analysis-only footing; one seconds-scale screen on constructed objects, reported as a screen.

| Item | Verdict |
|---|---|
| 1. Frobenius identity | CONFIRMED |
| 2. Eckart-Young | CONFIRMED |
| 3. Interlacing, mu_m | CONFIRMED |
| 4. kappa <= n-5-mu_m(x)/2, edge recedes by max mu_m/2 | CONFIRMED |
| 5. Novelty, strength, star remark | PLAUSIBLE (novel; strengthens L244; star remark true only for p >= n-2) |

## Item 1
A maps h (orthonormal basis psi_gamma, gamma in E_0 u E_1) into so(n) with the given inner product, so ||(P_0+P_1)A||_F^2 = sum over ordered pairs gamma, delta in h of <[x,psi_gamma],psi_delta>^2. Ad-invariance gives <[x,y],z> = <x,[y,z]>, so each term is <[psi_gamma,psi_delta],x>^2. The ordered-pair blocks E0xE0, E0xE1, E1xE0, E1xE1 contribute 2b00, 2b01, 2b10 = 2b01, 2b11, total 2(b00 + 2b01 + b11). The factor 2 and the 2 on b01 are right.

## Item 2
A = P_2 A + (P_0+P_1)A with rank(P_2 A) <= dim E_2 = p. Eckart-Young-Mirsky: ||A - B||_F^2 >= sum_{i>p} sigma_i(A)^2 for every B of rank <= p. Take B = P_2 A.

## Item 3
The inner product is ad-invariant, so ad_x^T = -ad_x and ad_x^T ad_x = -ad_x^2. sigma_i(A)^2 are the eigenvalues of the compression of -ad_x^2 to h (codim p). Cauchy interlacing: lambda_k(compression) >= lambda_{k+p}(-ad_x^2) (descending). Take k = p+j, j = 1..m: indices 2p+1..N, the m smallest. dim h = p+m, so sum_{i>p} sigma_i(A)^2 has exactly m terms and is >= mu_m(x).

## Item 4
All b_ab >= 0, so b00 + 2b01 + b11 <= 4b00 + 4b01 + b11, which equals n-5-kappa by L244's quoted K = (n-4) - 4b00 - 4b01 - b11 with K = kappa+1 (findings/second-order.md, L244 proof (ii)). Hence mu_m(x)/2 <= n-5-kappa at every unit x in E_0, and kappa <= n-5 - max_x mu_m(x)/2. mu_m(x) = 0 iff dim ker(-ad_x^2) = dim c(x) >= m, so the recession vanishes iff every x in E_0 has dim c(x) >= m. Correct as stated.

## Item 5
- Novelty: findings/second-order.md has no mu_m, Eckart-Young or interlacing-on-h statement. L244 uses Ky Fan on top sums only. New.
- Strength, a reformulation worth recording: tr(-ad_x^2) = 2 sum_{a,b} b_ab = 2(n-2) (row (A)), so mu_m(x) = 2(n-2) - kappa_{2p}(x) and the claim reads **kappa <= kappa_{2p}(x)/2 - 3**. Since kappa_{2p} <= 2 kappa_p and kappa_{2p}/2 <= n-2, it implies both L244's kappa_p(x)-3 term and its n-5 term, so it dominates two of L244's three per-vector terms (the kappa_{p-1}(x)-1 term is not compared here).
- Star remark: for unit decomposable x = e^u, -ad_x^2 has 2(n-2) eigenvalues 1 and dim c(x) = N - 2(n-2), so mu_m(x) = 2 max(0, n-2-p). "Decomposable with mu_m = 0" holds only when p >= n-2. For a star E_0 = e^U with p <= n-3 every element has mu_m = 2(n-2-p) > 0, and the bound gives kappa <= p-3, a real margin. The remark should be scoped to p in {n-2, n-1} (which covers every pair in the note's own screen, all with p >= n-2).

## Screen (seconds, constructed objects; a screen, not evidence)
/usr/bin/python3, 120 random orthonormal splits at (n,p) = (5,3),(6,4),(6,5),(7,6),(7,4),(8,5), random unit x in E_0: item 1 identity and mu_m = 2(n-2) - kappa_{2p} to 9e-15; the Eckart-Young and interlacing slacks both >= 0.117. Decomposable mu_m = 0,0,0,0,2,2 against the prediction 2 max(0,n-2-p).

## Lean
None of 1-4 is typed; agree the layer lacks singular values of ad_x. The kappa_{2p} form needs only Ky Fan on the top 2p eigenvalues plus row (A), which may be closer to what the layer can state.
