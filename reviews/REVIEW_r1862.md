# REVIEW r1862: Gate 2 verdicts on L149's hmargin bridge (L149Bridge.lean)

*Cold brief, analysis-only footing. Read at source: [L149Bridge.lean](../lean/HamiltonsCubic/Results/L149Bridge.lean), [L149Margin.lean](../lean/HamiltonsCubic/Results/L149Margin.lean), [L149Statement.lean](../lean/HamiltonsCubic/Results/L149Statement.lean), [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean) (weylPerp, weylPerpR, LeRestr), [RhoEff.lean](../lean/HamiltonsCubic/Results/RhoEff.lean), [Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) (thetaSplitSq), [SphereValue.lean](../lean/HamiltonsCubic/Base/SphereValue.lean), [L27Main.lean](../lean/HamiltonsCubic/Results/L27Main.lean) (L27_half), [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean) (orbitOp_props, L27_half_span), the staged diffs of [L3Attain.lean](../lean/HamiltonsCubic/Results/L3Attain.lean) and [lean/INDEX.md](../lean/INDEX.md), and Lemma L149 in [second-order.md](../findings/second-order.md) (set-up, the two inputs, THE MARGIN COEFFICIENT, POSITIVITY AND MONOTONICITY, the 2/9 discharge, the penalty paragraph). Run: one `lake env lean` on a scratch file in /private/tmp/r1862/ carrying `#print axioms` for the seven theorems and two four-line real-arithmetic `example` screens. No sweep, no numerics.*

| # | Claim | Verdict |
|---|---|---|
| 1 | L149_margin_N | CONFIRMED WITH OBSERVATIONS (O2) |
| 2 | L149_margin_unit | PROVED BUT HOLLOW: the existential Hr is unconstrained, so the statement is equivalent to c_p ≤ c(H) (O1) |
| 3 | theta_balanced_sq | CONFIRMED |
| 4 | rho_weaken | CONFIRMED |
| 5 | L149_hmargin | PROVED BUT HOLLOW: the existential w admits w = 0, so the statement is equivalent to c_p ≤ c(H), and it types the unpenalised margin against the penalised coefficient (O1, O3) |
| 6 | L27_lambda_max | CONFIRMED |
| 7 | INDEX rows L149 and L3 | OVERSTATED on L149 (the bridge to hmargin is described as delivered), MINOR IMPRECISION on L3 (q = 2) (O1, O3, O5) |

**Summary: every theorem compiles on the standard three axioms and the arithmetic is right, but the two statements that were meant to deliver hmargin lose the link between w and H_r, which is exactly what low_margin_forces_low_norm needs, so the bridge is typed in L149_margin_N and nowhere downstream of it.**

## A. Hypothesis inventory, used and unused

- L149_margin_N: hp (m ≥ 4) feeds L149_margin and the positivity of θ. hpq turns Tᶜ.card into m. ht gives θ > 0 and hence hP0. hn gives normSq2 M = 1 (ha) and θ = P(M). hHW and hperp build the element v of weylPerpR M. horb is used at the ½-branch of hrO (h1). Every hypothesis is used. None is vacuous: the unit balanced sphere product exists for every m, and L3Attain's L3_attained at p = q = m supplies a nonzero Weyl D ⊥ M, orthogonal to every ½-eigenvector, which after normalisation satisfies every hypothesis of L149_hmargin.
- L149_margin_unit: hH1 is used (rewrites normSq2 H to 1). Otherwise inherits.
- theta_balanced_sq: hp (≥ 2), hpq, ht, hn all used (theta_sphereProduct_value needs ht and both cards ≥ 2).
- rho_weaken: hm (6 ≤ m) is used twice, for m − 1 ≠ 0 and in the final nlinarith for m² − 6m + 2 ≥ 0. hθ0 is used for 0 ≤ 2θ in Real.sqrt_le_iff. hθ is used for (2θ)² = 4θ². No unused hypothesis.
- L149_hmargin: hp (≥ 6) is used through rho_weaken, the rest pass through. No unused hypothesis.
- L27_lambda_max: hp, hq, hne feed L27_half. The attainment half needs only p, q ≥ 2 (orbitOp_props), so hne and the ≥ 3 bounds are used only by the first conjunct. No unused hypothesis.

Found nothing unused. The hypothesis horb is the ½-eigenspace form, which is the orbit tangent at p = q = m ≥ 4 by L27_half_span. The file does not type that step, so a consumer holding "H ⊥ T_{W*}O" discharges horb through L27_half_span itself (O4).

## B. Is ρ^eff_n the record's, c_p the record's, θ the record's θ₀(n)?

- ρ^eff: L149_hmargin writes √6 − θ(n + 16)/(2(n − 2)) with n written as T.card + Tᶜ.card. The record's box gives ρ^eff_n = 3θ₀(n − 8)/(2(n − 2)) − (2/9)|κ_n|, |κ_n| = 9(θ₀ − √(3/2)). Expanding, 3θ₀(n − 8)/(2(n − 2)) − 2θ₀ + √6 = √6 − θ₀(n + 16)/(2(n − 2)), which is the record's own closed form and RhoEff.lean's (its D(n) is the cleared sign of exactly this). Same formula.
- c_p: the Lean writes 3θ/(n − 2). The record's κ := n c_p = 3θ₀n/(n − 2), so c_p = 3θ₀/(n − 2). At n = 2m this is 3θ/(2(m − 1)) = 3θ(½ − λ_m) with λ_m = (m − 2)/(2(m − 1)), which is L149_margin's c_p. The step e1 in the proof is that identity. Same.
- θ: θ = t(n − 1) with T.card + Tᶜ.card = n. theta_balanced_sq proves θ² = (2m − 1)(m − 1)/m² through thetaSplitSq(m, m) = 2(2m − 1)(m − 1)²/((2m − 2)m²). Theta0.lean's evenSq(n) = 2(n − 1)(n − 2)/n² equals that at n = 2m, and θ ≥ 0, so θ = θ₀(n). The Lean never writes θ = θ₀(n) as a root, only the square, which is all rho_weaken consumes. Same.
- rho_weaken's gap: the two sides sum to 2θ (checked by hand: (2m + 16 + 6m − 24)/(4(m − 1)) = 2), so the difference is 2θ₀ − √6 = (2/9)|κ_n|, the record's penalty. The docstring's "≥ 0 exactly when m² − 6m + 2 ≥ 0" is right: 4θ₀² ≥ 6 is 2m² − 12m + 4 ≥ 0, with roots 3 ± √7, and m = 6 gives 2.

## C. The existential w

This is the finding of the review (O1).

- The w that L149_hmargin produces in its proof is √(normSq2 H_r) = ‖H_r‖_F, which is the record's "weight outside both copies" (modulo D). The statement does not say so. It says ∃ w ≥ 0 with c_p + ρ^eff w² ≤ c(H).
- That statement is equivalent to c_p ≤ c(H) whenever ρ^eff ≥ 0, which holds at every m ≥ 6 (RhoEff). The witness w = 0 always works from c_p ≤ c(H), and any witness implies c_p ≤ c(H). Screened in the scratch file as an abstract equivalence over ℝ, compiled clean. So the statement carries no information about w at all.
- L149_margin_unit has the same defect: ∃ Hr with no property, and the coefficient 3θ(m − 4)/(2(m − 1)) ≥ 0 at m ≥ 4, so Hr = 0 is a witness whenever c_p ≤ c(H).
- For L149Statement's use: low_margin_forces_low_norm takes hmargin : cp + ρ w² ≤ c and hop : opn ≤ b0 + w at one shared w. From L149_hmargin a consumer obtains some w, but hop at that w is false in general (w = 0 would need ‖H‖_op ≤ b0 for every H ∈ N). So L149_hmargin cannot be fed to low_margin_forces_low_norm. The weakening matters exactly where the brief asked.
- The route that works goes through L149_margin_N, whose Hr is tied to H by Hs + Hr = H and by the eigen and orthogonality conjuncts. A consumer takes w := √(normSq2 Hr) from there and applies rho_weaken itself. The repair to the file is to state L149_hmargin (and L149_margin_unit) with the H_r of L149_margin_N exposed, for instance ∃ Hs Hr, Hs + Hr = H ∧ ... ∧ c_p + ρ^eff normSq2 Hr ≤ c(H), or to state them for the fixed w = ‖(E.starProjection v)ᗮ part‖.

## D. The decomposition

- H_r ⊥ orbit tangent: proved for every ½-eigenvector K in W^⊥ ∩ 𝒲ₙ, by H ⊥ K (horb) and H_s ⊥ K (distinct eigenvalues of a self-adjoint operator, LeLin_selfAdj, with LP ≠ ½, which holds at every m ≥ 2 since (m − 2)/(2(m − 1)) = ½ would need m − 2 = m − 1). The orbit tangent is contained in that eigenspace by orbitOp_props and equals it by L27_half_span at p = q = m ≥ 4. Correct.
- H_r ⊥ E(λ_m): by Submodule.sub_starProjection_mem_orthogonal and inner_right_of_mem_orthogonal. Correct.
- Hs is the starProjection onto E = eigenspace (LeRestr ...) LP inside weylPerpR M, a finite-dimensional real inner product space, so the projection exists and is orthogonal. Correct.
- The statement of L149_margin_N does not record that Hs and Hr are Weyl and ⊥ M, though the proof has hsW, hsP, hrW, hrP. Without those conjuncts the conclusion does not characterise Hs as the projection: the eigen conjunct uses LeLin on all of CurvOp2, and the orthogonality conjunct tests Hr only against Weyl, ⊥ M eigenvectors, so a λ_m-eigenvector of LeLin outside 𝒲ₙ ∩ M^⊥ could in principle be shifted between the two pieces. The INDEX row says "H_s the orthogonal projection", which describes the construction and not the statement (O2).
- m = 4: λ_4 = 1/3 = μ, so E(λ_m) also contains the Λ²⊗Λ² summand and H_r is the weight outside all three. The coefficient (m − 4) is zero there, so the bound collapses to c_p‖H‖² ≤ c(H), which is correct and harmless. At m ≥ 5, λ_m > μ (equivalent to m > 4), so gap_two's list separates λ_m from everything below.
- What the Lean does not settle: the record's w is the weight outside "both S²₀(ℝ^m) copies", the Lean's is the weight outside E(λ_m). They agree if E(λ_m) is exactly the two copies at m ≥ 5, which the record takes from L27's multiplicity-free list and which is untyped. The margin bound does not care. The operator-norm input does, since L146 prices H_s on the copies (O6).

## E. Direction and edge cases

- Direction: every inequality is a lower bound on the margin c(H) = −½ hessQ(H), which is what hmargin asserts. rho_weaken is an upper bound on ρ^eff, which is the direction that lets the stronger m-form coefficient be replaced by the weaker ρ^eff. Correct.
- m = 6: rho_weaken's slack is 2θ₀(12) − √6 = 2.4721 − 2.4495 ≈ 0.023 (the square form gives 4·55/36 − 6 = 1/9 > 0). Tight but positive, as the docstring says. ρ^eff_12 ≈ 0.719 > 0.
- ρ^eff ≥ 0: not needed by any Lean proof here (mul_le_mul_of_nonneg_right uses normSq2 Hr ≥ 0, not ρ ≥ 0). It is what makes the existential collapse in C clean. At negative ρ the existential would be weaker still.
- H_r = 0 (H ∈ E(λ_m)): the bound is c_p ≤ c(H), which is attained with equality on the λ_m-eigenvectors (L3_sharp at one direction). Consistent.
- H = 0 is excluded by normSq2 H = 1 in the unit forms, and L149_margin_N holds trivially at H = 0.

## F. Axioms

`#print axioms` on L149_margin_N, L149_margin_unit, theta_balanced_sq, rho_weaken, L149_hmargin, L27_lambda_max and HamiltonsCubic.L3Attain.L3_attained returns [propext, Classical.choice, Quot.sound] for all seven, the standard three. The two screens (the existential in L149_hmargin's shape is equivalent to c_p ≤ c at ρ ≥ 0, and w = 0 witnesses it from c_p ≤ c at any ρ) compiled without error in the same run, exit 0. The oleans of L149Bridge and L3Attain are newer than their sources, so the axiom report is on the staged text.

## G. Do the INDEX rows claim more than the Lean proves?

L149 row:
- "L149_margin_N, ... H_s the orthogonal projection onto the λ_m-eigenspace of LeRestr (Mathlib's starProjection)": true of the proof, not of the statement (O2).
- "L149_hmargin, at n = 2m ≥ 12 every unit H ∈ N has w ≥ 0 with c_p + ρ^eff w² ≤ c(H), the shape of hmargin": literally true and equivalent to c_p ≤ c(H) (O1). "The bridge to hmargin, PROVED" reads as the input discharged, and it is discharged only in a form low_margin_forces_low_norm cannot consume alongside hop.
- The row's Owed list names only the operator-norm input. It omits: the tie between hmargin's w and hop's w (O1); the penalised margin that branch 2 consumes (O3); E(λ_m) = the two copies for L146 (O6); the ⊥ orbit tangent to horb step (O4, available, just untyped).
- L149Statement.lean's own docstring still says the three bridging steps are "none typed" (O7).

L3 row:
- The q ≥ 2 repair to L3_attained is correct: the proof uses hq only through hq2 and hqR ≥ 2 (for θ > 0), and the file compiles.
- "orthogonal to every ½-eigenvector (the orbit tangent off (3,3) by L27_half_span)": L27_half_span requires p, q ≥ 3 and (p, q) ≠ (3, 3). At q = 2, now inside L3_attained's range, no typed result identifies that eigenspace with the orbit tangent. "Off (3,3)" reads as covering (p, 2) and does not (O5).
- orbit_bilinear_zero is stated at a general unit critical Weyl a, so its parenthetical identification is a gloss for sphere products and needs the same p, q ≥ 3 reading. The rest of the L3 row matches the files as far as this review read them.

What L149 still owes: the operator-norm input; a margin statement with w tied to H_r; the penalised numerator c(H) − |κ_n|u² ≥ c_p + ρ^eff w² for branch 2, which follows from L149_margin_N, rho_weaken's identity and u² = (2/9)‖Π_{Λ²⊗Λ²}H‖² ≤ (2/9)w²; the joint minimisation the record's box marks owed; the audit of the repair.

## H. Objects that would break each statement

- Claim 1: an H ∈ N whose component outside E(λ_m) has an L_e-eigenvalue in (1/(m − 1), λ_m). gap_two rules it out, and I checked gap_two's case split against gap_val (½, λ_p, λ_q, ≤ μ). Also a λ_m-eigenvector with eigenvalue ½, ruled out by LP ≠ ½. Found none.
- Claim 2: none breaks it, because Hr = 0 witnesses it whenever claim 1 gives c_p ≤ c(H). The object that breaks the intended reading is any H with H_r ≠ 0: the statement says nothing about it.
- Claim 3: a balanced unit product with θ ≠ θ₀. theta_sphereProduct_value pins θ as thetaSplit(m, m). Checked the algebra by hand.
- Claim 4: m in [6, ∞) with m² − 6m + 2 < 0. The larger root is 3 + √7 ≈ 5.646 < 6. Found none.
- Claim 5: as for claim 2, w = 0 always witnesses it. The object that shows the hollowness is H ∈ N with ‖H‖_op near 1 (w = Θ(1)): L149_hmargin permits w = 0 there, and hop at w = 0 is false.
- Claim 6: a nonzero Weyl H ⊥ M with eigenvalue > ½ at p, q ≥ 3 off (3, 3), excluded by L27_half. The attainment uses orbitOp_props with j ∈ T, k ∉ T, which exist since both cards are ≥ 3.
- Claim 7: a (p, 2) product, which sits inside L3_attained's new range and outside L27_half_span's.

## Observations

- **O1 (substantive).** L149_hmargin and L149_margin_unit quantify their weight existentially with no property attached, so each is equivalent to c_p ≤ c(H), screened as an abstract equivalence over ℝ. low_margin_forces_low_norm needs the same w in hmargin and hop, so L149_hmargin as stated cannot be consumed there. Repair: expose H_r (or Hs, Hr with Hs + Hr = H and the eigen, Weyl, ⊥ M conjuncts) in both statements, or fix w as the norm of the projection's complement.
- **O2.** L149_margin_N's conclusion omits IsWeyl2 Hs, IsWeyl2 Hr, innerOp2 M Hs = 0, innerOp2 M Hr = 0, all in hand in the proof. With them the conclusion characterises Hs as the orthogonal projection, as the INDEX row says. Without them it does not.
- **O3.** The record separates the two coefficients: the margin bullet uses the unpenalised m-form, branch 2 uses the penalised ρ^eff_n, and it warns against substituting one for the other. L149_hmargin puts the penalised coefficient on the unpenalised margin, which is sound as a weakening (rho_weaken's slack is exactly (2/9)|κ_n|) and serves the dichotomy, but it is not branch 2's numerator. The INDEX should say which consumer it serves and list the penalised form as owed.
- **O4.** horb is phrased on the ½-eigenspace. Its identification with the orbit tangent at p = q = m ≥ 4 is L27_half_span, available and untyped as a corollary here. The docstring of L149_hmargin says "orthogonal to the orbit tangent", which is the reading after that step.
- **O5.** L3 row and L3Attain docstring: "the orbit tangent off (3,3), by L27_half_span" at p ≥ 3, q ≥ 2. L27_half_span needs q ≥ 3. Suggested wording: "the orbit tangent at p, q ≥ 3 off (3, 3), by L27_half_span".
- **O6.** The Lean's w is the weight outside E(λ_m). The record's is the weight outside the two S²₀ copies. Equality at m ≥ 5 is L27's multiplicity-free list, untyped. The margin input is indifferent. The operator-norm input through L146 is not.
- **O7.** L149Statement.lean's "What is NOT typed here" says the normalisation, the decomposition and the weakening are "none typed". L149Bridge now types all three, so the docstring is stale.
- **O8.** LP ≠ ½ is proved inside L149_margin_N by linarith from 4 ≤ m, while it holds for every m ≥ 2. Harmless.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS on L149_margin_N, theta_balanced_sq, rho_weaken, L27_lambda_max and the L3Attain q ≥ 2 repair. PROVED BUT HOLLOW on L149_margin_unit and L149_hmargin, whose existential weight reduces each to c_p ≤ c(H). The L149 INDEX row overstates the bridge: the delivered hmargin cannot be paired with hop, and the row's Owed list is missing the w tie, the penalised branch-2 numerator and the E(λ_m) identification.**
