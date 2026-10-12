# Review r1209: invertibility off the ansatz (I111, surviving blocks)

Log: [agent_logs/r1209.log](../agent_logs/r1209.log)

Claim audited: the first paragraph of "Off the ansatz: invertibility holds at every surviving block, and the lift is a certificate, 2026-09-26" in [the I104 note](2026-09-14-I104-tau-positive.md), with its Lean declaration and the scope reading of [post F75](../findings/fence-posts.md).

| claim | declaration | verdict |
|---|---|---|
| C1 | HamiltonsCubic.I111Invertible.surviving_block_invertible | CONFIRMED (one harmless slip in the final constant, one unstated step) |
| C2 | same, statement comparison | CONFIRMED |
| C3 | none (prose scope reading) | CONFIRMED on the record's current uses |

## C1, the lemma, link by link

- **Case N_a > 1/2.** N >= N_a > 1/2 (other N_b >= 0), so u_a^2 <= t = 1 - N < 1/2 = theta^2/3, hence sqrt3 u_a < theta. Follows from givens.
- **Identity.** F_a(u) = theta u^2 - u^3/(2 sqrt3) - (u/sqrt3)c - N_a theta/2 + tau. Times 2 sqrt3, with m = sqrt3 theta: 2m u^2 - u^3 - 2cu - m N_a + 2 sqrt3 tau. Correct. m^2 = 3 * 3/2 = 9/2.
- **Factorisation.** E(u) - E(u0) = 2m(u^2 - u0^2) - (u^3 - u0^3) - 2c(u - u0), which is (u - u0) times the displayed bracket. Correct.
- **Value at u0.** u0^2 = m^2/9 = 1/2, u0^3 = m/6, and c = 1 - N/2 - N_a/2. Then E(u0) = m(1 - 1/6 - 2c/3 - N_a) = (m/6)(1 + 2N - 4N_a). Correct. Lower bound (m/6)(1 - 2N_a) uses N >= N_a, and it is >= 0 because N_a <= 1/2 in this case.
- **Bracket.** For u >= u0: 2m(u + u0) >= 4m u0 = 4m^2/3 = 6. For u <= 1 and u0 = 1/sqrt2 < 1: u^2 + u u0 + u0^2 <= 3 (loose, the true cap is 2.21). And 2c <= 2 since c = 1 - (N + N_a)/2 <= 1. So bracket >= 1. Correct.
- **u <= 1.** The written proof uses it without saying where it comes from. It follows from the givens: u_a <= sqrt t and t = 1 - N <= 1. Unstated, justified.
- **Conclusion.** E >= 0 on [u0, 1], so 2 sqrt3 F >= 2 sqrt3 tau, i.e. **F_a(u) >= tau**. The prose writes F_a(u) >= tau/sqrt3. That is true (weaker) but it is not what the identity gives. Correction: replace tau/sqrt3 by tau. Positivity, and so the lemma, is unaffected.
- **N_a = 0.** The record's form N_a(theta/2 - tau/N_a) is undefined there. The proof (and Lean) use the expanded form -N_a theta/2 + tau, its continuous extension. Harmless, worth a word.
- **Strength.** The contrapositive proves F_a > 0 whenever sqrt3 u_a >= theta, so F_a <= 0 (not only < 0) already forces sqrt3 u_a < theta. At tau = 0 the same argument gives F >= 0, so it needs tau >= 0 only to reach the strict conclusion from F < 0.
- **Screen (not evidence).** 38462 random tuples with sqrt3 u >= theta, u <= sqrt t, sum N <= 1, 0 < tau <= (1/2) sqrt(N1N2N3): zero with F <= 0, and min of F - tau/sqrt3 was +0.0084. Consistent with the lemma.

Hypotheses actually used: theta^2 = 3/2, theta > 0, 0 <= N_a <= N, u <= sqrt t, t = 1 - N, tau > 0. No equal-u or equal-N_i hypothesis. The prose is correct that none enters.

## C2, Lean vs claim

- File compiles clean (lake env lean, 47 s, no warnings, no sorry).
- Hypotheses: theta^2 = 3/2, theta > 0, k^2 = 3, k > 0, 0 <= u, u^2 <= t, t = 1 - N, 0 <= Na <= N, tau > 0, and hF: the expanded slack < 0. Conclusion 3u^2 < theta^2, equivalent to sqrt3 u < theta for u >= 0, theta > 0.
- Nothing is assumed beyond C1's givens. It is if anything weaker: it needs only Na <= N rather than each N_b >= 0, and u^2 <= t in place of u <= sqrt t. The slack is the record's F with the N_a(theta/2 - tau/N_a) term expanded, identical for N_a > 0.
- Not vacuous: theta = sqrt(3/2), k = sqrt3, u = 1/2, N = 1/2, t = 1/2, Na = 0.2, tau = 0.01 gives F = -0.030 < 0 and all hypotheses hold.
- The file's docstring correctly lists what is left to the record (u_a <= sqrt t, the eigenvalues, the chain inequality).

## C3, the scope reading of post F75

- The record's use of invertibility is post F75's "square system" paragraph: theta - 2L_{q_a} invertible "throughout the surviving set", to write nu_a = (theta - 2L_{q_a})^{-1}(2 nu_b o nu_c). The surviving set is by definition what the chain leaves, i.e. every block has F_a(u_a) <= 0. By C1 each such block has theta - sqrt3 u_a > 0, and theta + sqrt3 u_a > 0 always, so both plane eigenvalues are positive. Excluding F_a > 0 blocks suffices.
- No use of invertibility found at a configuration with some F_a >= 0 being kept. A configuration with one block at F_a > 0 is excluded as a whole, so its other blocks never need the inverse. A block at exactly F_a = 0 is covered by the contrapositive (F_a > 0 whenever sqrt3 u_a >= theta).
- The chain's lower bound on u comes from pairing the block equation with nu_a and the bound on L_q, which does not invert theta - 2L_q, so the argument is not circular.
- Scope limits to keep visible: the lemma is at theta^2 = 3/2 and tau > 0 (I104's tau > 0 case, which is where I111 and post F75 live). It says nothing for tau < 0 or other theta. No record use outside that case was found in findings/, results.md, plan.md or STATUS.md.
- Downstream note for the parent: [findings/INDEX-traps.md](../findings/INDEX-traps.md) row 75 still reads "theta - 2L_{q_a} being invertible on the equal-u ansatz". That is true but now narrower than the record. Not edited here (outside this review's remit).

## Corrections owed

1. The I104 note, same paragraph: "F_a(u) >= tau/sqrt3 > 0" should read "F_a(u) >= tau > 0".
2. Optional: say u <= 1 comes from u_a <= sqrt t <= 1, and that the slack is read in its expanded form at N_a = 0.
