# REVIEW r1208: off-ansatz invertibility lemma (I111), 2026-09-26

Target: reviews/2026-09-14-I104-tau-positive.md, section "Off the ansatz: invertibility holds at every surviving block, and the lift is a certificate, 2026-09-26", first paragraph, and its use in findings/fence-posts.md post F75.

Log: agent_logs/r1208.log

Footing: analysis only. One random screen (seconds) and two Lean compiles of the file under audit, reported as screens.

| claim | declaration | verdict |
|---|---|---|
| C1 | HamiltonsCubic.I111Invertible.surviving_block_invertible | CONFIRMED |
| C2 | same, statement comparison | PLAUSIBLE, one-line correction |
| C3 | none (prose scope reading) | CONFIRMED on the prose proof |

## C1, the lemma, link by link: CONFIRMED

- **Case N_a > 1/2.** u_a^2 <= t = 1 - N <= 1 - N_a < 1/2 = theta^2/3. Uses N >= N_a (other N_b >= 0) and u_a <= sqrt t. Both are givens. Holds.
- **m and u0.** m = sqrt3 theta gives m^2 = 9/2, u0 = m/3 = theta/sqrt3, so sqrt3 u >= theta is exactly u >= u0. u0^2 = 1/2 and u0^3 = m/6.
- **Identity 2 sqrt3 F_a(u) = E(u) + 2 sqrt3 tau.** Multiplying F_a by 2 sqrt3: 2 sqrt3 theta u^2 = 2m u^2, u^3/(2 sqrt3) becomes u^3, (u/sqrt3) c becomes 2cu, and N_a(theta/2 - tau/N_a) becomes m N_a - 2 sqrt3 tau. Holds, reading N_a(theta/2 - tau/N_a) as theta N_a/2 - tau (the record's own form in L221 step 4). At N_a = 0 the printed form is undefined, but tau > 0 forces every nu_a nonzero (L221(b) step 1: nu_3 = 0 gives tau = 0), so N_a > 0 on the claim's domain.
- **Factorisation.** E(u) - E(u0) = 2m(u^2 - u0^2) - (u^3 - u0^3) - 2c(u - u0) = (u - u0)(2m(u + u0) - (u^2 + u u0 + u0^2) - 2c). Exact.
- **Value at u0.** E(u0) = m(1 - 1/6 - 2c/3 - N_a). With c = t + (N - N_a)/2 = 1 - N/2 - N_a/2 this is m(1/6 + N/3 - 2N_a/3) = (m/6)(1 + 2N - 4N_a). Exact. It uses t = 1 - N as an identity, which is a given.
- **First term.** 1 + 2N - 4N_a >= 1 - 2N_a >= 0 on N_a <= 1/2, using N >= N_a. Holds.
- **Bracket.** On u0 <= u <= 1: 2m(u + u0) >= 4m u0 = 4m^2/3 = 6, u^2 + u u0 + u0^2 <= 3 (u0 = 1/sqrt2 <= 1), 2c <= 2 (c = 1 - N/2 - N_a/2 <= 1). So the bracket is at least 1. Bounding the increasing positive part from below and the subtracted part from above separately is legitimate. Holds.
- **u <= 1.** Unstated in the prose but follows from the givens: u_a <= sqrt t and t = 1 - N <= 1.
- **Conclusion.** E(u) >= 0 gives F_a(u) >= tau/sqrt3 > 0, strictly. So sqrt3 u_a >= theta forces F_a(u_a) > 0, and the contrapositive is the NON-STRICT form F_a(u_a) <= 0 implies sqrt3 u_a < theta, stronger than C1 as briefed (F_a < 0).
- **Screen.** 2,000,000 random tuples (N_a in [0,0.6], u in [0, sqrt t], 0 < tau <= (1/2) sqrt(N1 N2 N3)): 114,121 had sqrt3 u >= theta, none had F <= 0, least value of F - tau/sqrt3 was 0.0068. Consistent with the proof, and a screen only.

## C2, the Lean statement: PLAUSIBLE, one-line correction

- lean/HamiltonsCubic/Results/I111Invertible.lean compiles clean with `lake env lean` (about 42 s). It is imported by lean/HamiltonsCubic.lean line 564. It contains no sorry and no native_decide.
- **Hypotheses match the givens.** theta^2 = 3/2, theta > 0, k^2 = 3, k > 0, u >= 0, u^2 <= t, t = 1 - N, 0 <= N_a <= N, tau > 0. N_a <= N stands in for the other blocks being nonnegative, which is weaker and suffices. The slack is written as -N_a theta/2 + tau, the N_a != 0 form, which is the right reading (C1, third bullet). The conclusion 3u^2 < theta^2 is sqrt3 u < theta under u >= 0, theta > 0. Nothing is assumed that C1 does not state.
- **Nonvacuous.** theta = sqrt(3/2), k = sqrt3, N = N_a = 0.3, t = 0.7, u = 0.1, tau = 0.01 satisfies every hypothesis: F = 0.01225 - 0.00029 - 0.04041 - 0.18371 + 0.01 = -0.2022 < 0, and 3u^2 = 0.03 < 1.5.
- **The gap.** The hypothesis is hF : F < 0 (strict). The record's survival condition is non-strict: L221 step 4 (findings/second-order.md, Lemma L221) is the inequality theta u_i^2 <= (sqrt3/2)u^3 + (u/sqrt3)(t - u^2) + (theta N_i/2 - tau) + (u/(2 sqrt3))(N - N_i), which rearranges to F_i(u_i) <= 0 at every critical point. The prose claim "a block with sqrt3 u_a >= theta has F_a(u_a) > 0" covers blocks with F_a = 0. The Lean theorem's contrapositive gives only F_a >= 0 there, so a block the chain leaves alive at F_a = 0 is outside the cited declaration.
- **Correction, checked.** Replace `+ τ < 0) :` by `+ τ ≤ 0) :` and the last `have hneg := mul_neg_of_pos_of_neg (by positivity : (0:ℝ) < 2 * k) hF` by `have hneg := mul_nonpos_of_nonneg_of_nonpos (by positivity : (0:ℝ) ≤ 2 * k) hF`. A copy with exactly those two edits compiles clean (scratchpad, about 22 s). The repository file was not edited.

## C3, the scope removal in post F75: CONFIRMED on the prose proof

- **Where invertibility is used.** findings/fence-posts.md post F75 ("the block system is square") and the I104 note's M5 paragraph use it for one thing: nu_a = (theta - 2L_{q_a})^{-1}(2 nu_b o nu_c), so the block system is six equations in six angles. That needs theta - sqrt3 u_a != 0 at genuine critical points, and nothing more. theta + sqrt3 u_a > 0 is automatic.
- **Invertibility is needed only where the chain leaves blocks alive.** L221 step 4 holds at every unit critical point of the stratum and uses L220 steps 5, 7, 8 and step 2's eigenvalue bound, none of which uses invertibility, so there is no circularity. Every critical point therefore has F_a(u_a) <= 0 for every block, and the non-strict form of C1 gives sqrt3 u_a < theta for each. No use of invertibility in the record sits at a configuration where some block has F_a > 0, because such a configuration is not a critical point.
- **Boundary F_a = 0.** Covered by the prose proof (strict F_a >= tau/sqrt3 > 0). Covered by the Lean citation only after the C2 correction. The fence post and the I104 note both cite `surviving_block_invertible` as the source.
- **Scope remarks, true of the record and worth one clause each.**
  - The lemma is at theta^2 = 3/2 only. I111 asks whether a multi-block critical point reaches theta = sqrt(3/2), so this is the value used, but the statement does not transfer to other theta.
  - The lemma gives theta - sqrt3 u_a > 0 with no uniform margin. The on-ansatz margin theta - sqrt3 u >= 0.3587 (I104 note, M5 paragraph) stays an on-ansatz figure. Squareness needs only invertibility, so the F75 reading is unaffected.
  - tau <= 0 is outside the lemma and needs no invertibility, since L221(b) closes it at theta^2 <= 6/5.

## Summary

- The proof is correct link by link. It proves the stronger non-strict form (F_a <= 0 implies sqrt3 u_a < theta).
- The Lean declaration is correct and nonvacuous but states the strict form, so it misses surviving blocks at F_a = 0. A two-line fix, verified to compile, closes this.
- The reading that removes F75's scope caveat is sound, because L221 step 4 puts every critical point inside F_a <= 0 without using invertibility.
