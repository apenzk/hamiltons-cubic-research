# Review r1594: L273 (H on the torus slice of so(2m), m >= 5, from the matrix inequality J1)

Log: agent_logs/r1594.log

Overall: CONFIRMED WITH MINOR GAPS. Every step of (1), (2) and (3) holds as written. The gaps are in wording and provenance only.

| claim | verdict | reason in one line |
|---|---|---|
| T1 L273 (1) F <= 3||A|| g + T and g >= 1/sqrt m | CONFIRMED | A_mu = (diag d, -P∘Q) makes L271 (1) read F = 3 tr(A A_mu) + T. tr A_mu = ||U||^2 + ||V||^2 = b^2, and A_mu is PSD, so 1/sqrt m <= g <= 1. Minor: equality needs A a non-negative multiple of A_mu, which "parallel" leaves unstated |
| T2 L273 (2) lambda_m (1 - g^2) <= Psi_kappa(g) for m >= 5, failing at m = 4 | CONFIRMED | Unique minimiser, the substitution, h, t0, both relations, the four Taylor coefficients, lambda kappa t0 = 2(m-2)/(m-1) and h'(t0) < 0 at m = 4 all rederived by hand |
| T3 L273 (3) J1 implies H on the torus slice | CONFIRMED | The chain is valid for arbitrary signs of A, P and Q, provided J1 is read over all symmetric zero-diagonal P, Q with b = 1. The b = 0 case holds because t is abelian |
| T4 What it gives: the Lagrange equations, the equality cases, the screens | CONFIRMED | Both equality cases give LHS = lambda_m exactly. The Lagrange system has the stated form with one theta for both equations. Minor: the rescaling needs the multiplier nu > 0, which holds at any maximiser but is left unstated |
| LEAN fidelity | CONFIRMED | Each declaration states what the table says, with no circular hypothesis, and jh_constants discharges jh_zero's hypotheses. Minor: jh_zero's docstring labels itself "L273 (1)", and the m = 4 failure is untyped, which the provenance line leaves unsaid |

## Method

- I read the chain link by link against L268, L271 and the givens, then rederived each step by hand.
- Screen (seconds, reported as a screen and not as evidence): BFGS from 40 random starts at m = 4 and at m = 5, run on two objectives. The first is J1's scale-invariant form T/b^3 + lambda g^2/b^4. The second is the full torus ratio F/||X||^3 with X = (A, P, Q) built from L271 (1). Script: the scratchpad file s1594.py, run once. Output:
  - m = 5: J1 max 1.1858541221 against lambda_5 = 1.1858541226, and torus H max 1.19256958506 against kappa = 1.19256958800.
  - m = 4: J1 max 1.0886621078 against lambda_4 = 1.0886621079, and torus H max 1.15470 (= 2/sqrt 3) against kappa = 1.13389.
- I did not read the author's working note, and I did not read any other reviewer's report.

## T1

- A_mu is the Cartan block from L268, 2 Σ μ_α^2 u_α u_α^T.
  - For α = ε_i - ε_j it contributes U_ij^2 at (ii) and (jj), and -U_ij^2 at (ij).
  - For α = ε_i + ε_j it contributes V_ij^2 at (ii) and (jj), and +V_ij^2 at (ij).
  - So (A_mu)_ii = d_i and (A_mu)_ij = V^2 - U^2 = -P_ij Q_ij.
- L271 (1)'s first two terms are therefore 3 tr(A A_mu), taken in the same trace inner product that gives ||C||^2 = ||A||^2 + ... . Cauchy–Schwarz then gives F <= 3||A|| g + T.
- Equality holds exactly when A = s A_mu with s >= 0 (or A = 0). A negative multiple gives -3||A|| g. The word "parallel" should say this.
- tr A_mu = Σ_i Σ_l (U_il^2 + V_il^2) = ||U||^2 + ||V||^2. Also b^2 = ½(||U+V||^2 + ||U-V||^2) = ||U||^2 + ||V||^2, so the two agree, and at b = 1 Cauchy–Schwarz gives g >= tr/sqrt m = 1/sqrt m.
- A_mu is a sum of PSD rank ones, so g <= tr A_mu = 1. The range needed is therefore [1/sqrt m, 1], and (2) covers all of it (and more).

## T2

- Put φ(a) = κ(1+a^2)^{3/2} - 3ag. Then φ'(a) = 3(κ a sqrt(1+a^2) - g). The map a -> κ a sqrt(1+a^2) is strictly increasing from 0 to infinity, so the minimiser is unique, and it is interior because g > 0.
- With t = sqrt(1+a^2): g = κ a t, so g^2 = κ^2 t^2 (t^2 - 1), and Ψ = κ t^3 - 3κ a^2 t = κ t(3 - 2t^2).
- Ψ - λ(1 - g^2) expands to h(t) exactly as stated. The map g -> t is increasing and continuous with t >= 1.
- At t0 = sqrt((2m-1)/(2(m-1))):
  - κ^2 t0^2 (t0^2 - 1) = 1/m.
  - κ t0 = sqrt2 sqrt(m-1)/sqrt m and 3 - 2t0^2 = (m-2)/(m-1), so κ t0 (3 - 2t0^2) = sqrt2 (m-2)/sqrt(m(m-1)) = λ_m (1 - 1/m).
  - λ_m κ t0 = 2(m-2)/(m-1).
- The four Taylor coefficients follow from h', h''/2, h'''/6 and h''''/24, and they factor exactly as stated.
- Their signs: t0^2 > 1 > ½, and the second coefficient is λκ(6t0^2 - 1) - 6t0 >= 3(2t0^2 - 1)/(2t0) >= 0 when 2λκ t0 >= 3.
- 4(m-2)/(m-1) >= 3 holds exactly when m >= 5.
- At m = 4, 2λκ t0 = 8/3 < 3, so h'(t0) < 0 while h(t0) = 0. Hence h < 0 just above t0, that is for g just above ½. This confirms the failure claim.
- Non-negative Taylor coefficients are sufficient only, which is all (2) asserts for m >= 5.

## T3

- Scaling X by 1/b > 0 scales F and ||X||^3 alike by 1/b^3, so the reduction to b = 1 is sound.
- At b = 0, P = Q = 0 and X = A on t. A decomposes into rank ones supported in t, and t is abelian, so every bracket vanishes: A#A = 0 and F = 0.
- At b = 1 with a = ||A||, the chain runs F <= 3ag + T <= 3ag + λ(1 - g^2) <= 3ag + Ψ(g) <= κ(1+a^2)^{3/2}.
  - The second step is J1.
  - The third is (2), applicable because g >= 1/sqrt m.
  - The last holds because Ψ is a minimum over a >= 0.
- No step uses a sign of A, P or Q. J1 must accordingly hold over all real symmetric zero-diagonal P, Q (U and V are free), and the statement's "whenever b = 1" reads that way.
- Cosmetic: the symbol T denotes both the maximal torus and the cubic trace.

## T4

- **Uniform point.** P = 2μ(J - I), Q = 0, with μ^2 = 1/(2m(m-1)).
  - tr(J - I)^3 = m(m-1)(m-2), so T = 4μ^3 m(m-1)(m-2) = sqrt2 (m-2)/sqrt(m(m-1)) = λ_m (1 - 1/m).
  - d_i = 1/m and the off-diagonal block of A_mu is 0, so g^2 = 1/m.
  - LHS = λ_m: equality.
- **Λ^2_+ edge.** P_12 = ±Q_12 = x with x^2 = ½ and nothing else.
  - tr P^3 = tr Q^3 = 0, since a single off-diagonal pair has an off-diagonal cube.
  - d_1 = d_2 = ½ and (A_mu)_12 = ∓½, so g^2 = 1.
  - LHS = λ_m: equality.
- **Lagrange equations.** Use g^2 = Σ d_i^2 + Σ_{i≠j} P_ij^2 Q_ij^2 with d_i = ½ Σ_l (P_il^2 + Q_il^2).
  - The partial derivatives in P_ij (i < j) are ∂T = 3(P^2)_ij, ∂g^2 = 2P_ij(d_i + d_j + 2Q_ij^2) and ∂b^2 = 2P_ij.
  - Stationarity: 3(P^2)_ij = 2P_ij(ν - λ(d_i + d_j + 2Q_ij^2)), and the same with P and Q exchanged.
  - Rescale (P, Q) -> s(P, Q) with s^2 = λ/ν and θ = 2νs/3. The result is (P^2)_ij = θ P_ij(1 - d_i - d_j - 2Q_ij^2), with the same θ in both equations. θ = 1 recovers L271 (2).
  - Euler's relation gives 2ν = 3T + 4λg^2 = 3G + λg^2. The rescaling needs ν > 0. That holds at every maximiser (G >= λ there) and at any critical point with 3T + 4λg^2 > 0, but the sentence claims it for the Lagrange equations in general. Minor: add "at critical points with ν > 0".
- **Q = 0 reading.** T_u - T >= λ(g^2 - 1/m) is J1 rewritten, since T_u = λ(1 - 1/m). At Q = 0, the bound T <= T_u is the traceless cubic bound on the zero-diagonal P.
- **Threshold sentence.** My screen reproduces J1's value (max = λ_m at m = 4 and at m = 5). It also shows that at m = 4 the torus slice itself violates H: sup F/||X||^3 ≈ 2/sqrt3 > κ_4. So the threshold is real on this family and not an artefact of the chain. This is a screen and supports the reading only.

## LEAN

- jh is h verbatim.
- jh_mono: the hypotheses are κ, l, t0 > 0, t0^2 >= ½, 2lκ t0 >= 3 and u >= 0. The conclusion is h(t0) <= h(t0 + u). Nothing is circular, and the ring identity fixes the four coefficients as stated.
- jh_threshold is the stated equivalence over real m > 1.
- jh_zero is pure algebra from the two relations. It is non-vacuous because jh_constants proves both relations at the actual constants, together with λκ t0 = 2(m-2)/(m-1) and t0^2 >= ½.
- jh_nonneg assembles these into h(t) >= 0 for t >= t0 and real m >= 5. This is (2) in the variable t, as the record says.
- Minor: jh_zero's docstring reads "L273 (1), the equality point" but belongs to (2).
- Minor: the m = 4 failure clause of (2) is typed nowhere. It is a hand argument from h'(t0) < 0, and the provenance line should list it with the prose items.
