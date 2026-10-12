# REVIEW r1696: the odd MW' for m ≥ 7 (R48 working note, batch 10)

Log: [agent_logs/r1696.log](../agent_logs/r1696.log). Claim: [batch 10 of the R48 note](2026-09-27-R48-torus-families.md), certificate [cert_oddmw.py](../scripts/misc/cert_oddmw.py), Lean statements in [OddMW.lean](../lean/HamiltonsCubic/Results/OddMW.lean).

**Verdict: the proof holds link by link. No error in the result and no gap that blocks it; three minor presentation gaps, one of which matters for the Lean formalisation (F3).**

| claim | verdict | reason |
|---|---|---|
| Statement | CONFIRMED | Follows from steps 1 to 9. Equality at the uniform point checked exactly (the certificate's `Phi1(S_u) = 0`) and by screen (excess 2e-16). |
| Step 1 | CONFIRMED | `2ab ≤ α²a² + b²/α²` is `(αa − b/α)² ≥ 0`. With `u_i = π_i r_i = π_0 q_0i` the two halves are exactly the stated terms. At the uniform point `r = 1/(2m−1)`, `q_0i = 1/m`, and `α²(1 − r) = (m−1)/m = 1 − q_0i`, so equality holds. |
| Step 2 | CONFIRMED | Lean `R0` needs `6 ≤` slots and row 0 has `m ≥ 7`. With γ ≡ 1 it reads `Σ q(1−q)² ≤ ((m−1)/m)(1 − ρ_0)`. Since `ρ_0 ≥ 1/m`, `(1/m − ρ_0) ≤ 0` and a smaller slope weakens nothing. `(t_n/α²)(m−1)/m = 1/√2` checked by hand. `c_0* ≤ 1/√2` is a certificate side condition. `π_0 = 0` gives a zero term. |
| Step 3 | CONFIRMED | The κ-rescaling matches `β` at κ_o with `slope` at κ(n). Both sides are affine in π for fixed (q, γ). The linear-part identity holds at both endpoints: `G_u + b_0σ²/n − n f_0(σ/n) = b_0σ` and `G_u + sh σ²/n − n ψ_L(σ/n) = Kt σ + sh σ`, both checked by hand. Monotonicity of `H(X, ·)` on `[X, min(1, nX)]` holds: `y ≤ ȳ` is `τ ≤ nX`, and both endpoints of each chord stay ordered and inside `[0, 1/n]`. `σ ∈ [X, min(1, nX)]` for `X ∈ [σ/n, σ]`. σ = 0 is trivial. |
| Step 4 | CONFIRMED | Column mass: `Σ_{k≠i} w_ki + w_0i = π_i` (zero diagonal). Weighted Cauchy–Schwarz with `a_k = β_kπ_k` and `b_k = π_k` gives `T_i'`. Tightness: `q_ki β(π_u) = (2/(2m−1)) β(π_u) = (1/m) β̃_0`. Positivity of β follows from `β(½) > 0` and `c' > 0`. |
| Step 5 | CONFIRMED | ψ collects every r-dependent term. `ψ̃ − T` has a double root at `r_1` and a root at 1, and `c_3 > 0` is certified. Inflection at `(2r_1+1)/3`. The envelope is concave and majorises ψ̃. Jensen's weights are `π_i/S` with mean `π_0/S`. `(Σπ_iσ_i)² ≤ m Σπ_i²σ_i²` with `Σπ_iσ_i = 2S − 1`. Minor gap F1: `r_1 < 1` is asserted but not certified. |
| Step 6 | CONFIRMED | Titu's form is right. The identity for `Σπ_i²T_i'` holds. `φ(x) = x/c' + 1/c'² + (s_o − 1/c'²)/(1 − c'x)` up to the factor `1/b_0`, so φ is concave wherever `c'x < 1` exactly when `c'²s_o ≤ 1`, and `s_o ≤ S/2 ≤ ½`, `c' < 1`. The Jensen mean is `s_o/S`. See F3 on the Lean route. |
| Step 7 | CONFIRMED | Every term is accounted for with the right sign: row sums, both halves of step 1, κ_3, the Cauchy–Schwarz term (`s_o²/X` decreasing in X), `(S² − s_o)/(2t_o)`, `π_0S/t_n` and `λs_o`. The domain is `s_o ∈ [S²/m, S/2]`. |
| Step 8 | CONFIRMED | `λ − 1/(2t_o) = (t_o/2)κ_o` gives the derivative. `h(z) = (S−z)/(1−c'z)` has `h' = (c'S−1)/(1−c'z)² < 0` and `h'' = 2c'(c'S−1)/(1−c'z)³ < 0`. `E > 0` including the corner `S = ½`, `z = ½`. A positive, concave, decreasing E makes `s/E` convex, since `(s/E)'' = s(1/E)'' + 2(1/E)' ≥ 0`. The certificate's (b) is exactly `(E − yE')/E² − κ_o > 0` at `y = S²/m`. |
| Step 9 | CONFIRMED | `S ≥ 1/(1+r_1) ⟺ r̄ ≤ r_1`. T is certified on `[½, ⅔] ⊇ [½, 1/(1+r_1)]` because `r_1 > ½`, and the cubic on `[½, 1] ⊇` its branch. Both are valid upper bounds on their own branch. `sign_on` handles odd-power factors by Bernstein coefficients in `t = m − 7` and skips even powers, so its logic is sound. Re-run: all checks pass in 8.5 s. |
| Lean statements | CONFIRMED | `To`, `Tn`, `Lam` and `C0` are the constants divided by √2. `Lam − 1/(4To)` equals `(λ − 1/(2t_o))/√2`, `1/(4To)` equals `(1/(2t_o))/√2` and `1/(2Tn)` equals `(1/t_n)/√2`. `htot` counts `w_i0` and `w_0i`. `q_0i = u_i/Σu`. `m = n+1` with `6 ≤ n`. The diagonal γ is harmless because `W i i = 0`. Division by zero only reaches terms whose numerator is 0. `scaled_row_chord` has `n` slots with `6 ≤ n`, `κ ≤ kap n`, and its slope is β. `scaled_left_concave` is exactly the step-3 lemma. |

## Findings

- **F1 (step 5, minor gap in the argument, result unaffected).** `r_1 < 1` is used for the inflection position and for the envelope's chord on `[r_1, 1]`. The certificate checks only `r_1 > ½`. The fix is one line: `1 − r_1 = (2m−1)(m−3)/(2(2m²−5m+1)) > 0`.
- **F2 (step 3, presentation).** The chord-slope comparison needs both the left endpoints ordered (`y ≤ ȳ`) and the right endpoints ordered (`y' ≤ ȳ'`, which is `τ' ≤ nX`). The prose states only the first. The comparison also uses that concave chord slopes decrease in each endpoint separately. Both hold on the stated range.
- **F3 (step 6, route to Lean).** The prose cites "L276's argument" for concavity of φ. L276's Lean `tangent_phi` is the tangent at `x = s`, where the Jensen mean equals the numerator constant. Here the mean is `s_o/S ≠ s_o`, so `tangent_phi` does not apply verbatim. The mathematics holds: φ is globally concave under `c'²s_o ≤ 1` by the partial-fraction form above, so its tangent at any point dominates. The Lean proof of `oddMWprime` needs a generalised tangent lemma at an arbitrary point `x_0` with `c'x_0 < 1`.
- **Out of scope.** The "What it gives" paragraph (J1_odd and H on the torus slice for m ≥ 7) rests on batch 6's chain, which this review did not examine.

## Screens (not evidence for the claim)

- [cert_oddmw.py](../scripts/misc/cert_oddmw.py) re-run: all assertions pass.
- 20000 walks each at m = 7 and 8 (random powers, near-uniform perturbations, walks near the old edge `w_12` dominant, and Dirichlet samples), with γ chosen optimally per entry. Maximum of LHS − c₀: −6.1e-8 at m = 7 and −4.1e-8 at m = 8. Uniform point: 2e-16 and −2e-16.
