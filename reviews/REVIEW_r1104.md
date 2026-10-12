# r1104: I73(c) section 7, the gap-weighted pair sum and its spectral corollary

Log: [agent_logs/r1104-I73c-sec7.log](../agent_logs/r1104-I73c-sec7.log). One of two Gate 2 reviewers of section 7 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at 2854e98c, read with `git show`. Sections 1 to 6 are givens. Every computation below is a screen of seconds.

**Verdict: the mathematics of section 7 is correct. The Gram coefficients, the identity and the corollary all check by hand, line by line. Two findings change what the section can claim. The corollary is inert on the region the programme asks about: at every unit W with θ ≥ √(3/2) it follows from a published trace-free bound at n ≥ 11, and a screen puts it out of reach at n = 6, 7, 8 as well (F1). The Fourier-Motzkin paragraph eliminates G12 over section 3's interval only, dropping section 5's constraint G_ab ≥ ½τ_ab, so its sentence that the τ-content lives only in the two endpoint inequalities does not hold for the full system (F2). The rest are text defects.**

| # | claim | verdict |
|---|---|---|
| 1 | the G12 coefficients −c·pq and +c·p², c = (n−8)/(12(n−2)), and the cancellation at weights p, q | CONFIRMED. The screen script prints twice the note's coefficient (F3) |
| 2 | the gap-weighted identity at every unit Weyl W with P(W) > 0 | CONFIRMED, with no criticality. The screen script's docstring says the opposite (F4) |
| 3 | the corollary (n−1) tr W³ ≤ (n−3)θ and its equivalent form | CONFIRMED |
| 4 | the reach claims and the record search | PLAUSIBLE. Each sentence is true, but the corollary is inert wherever θ ≥ √(3/2) (F1). One figure is off by rounding (F5). The inequality is not on the record |
| 5 | the Fourier-Motzkin paragraph | PLAUSIBLE. The four conditions and the orientation are right over section 3's interval. The τ sentence fails once section 5's constraints are carried (F2) |
| 6 | the Lean statements | PLAUSIBLE. Each statement is the note's arithmetic. gram_free is a bare ring identity, and the not-typed list omits the derivation of the G12 coefficients (F6) |

## Claim 1, the Gram elimination

- **Null direction.** (1,1,1) × ε = (q, −(p+q), p), which is −z for the note's z. So zz^T is the kernel, z1·z2 = −q(p+q), and dG = −zz^T dG12/(q(p+q)).
- **Derivative.** d|Ric e²|²/dG12 = −(Σ_a ε_a² z_a)²/(q(p+q)). The sum is invariant under shifting ε, since z ⊥ 1 and z ⊥ ε. At ε = (0, p, p+q) it is −pq(p+q), so the derivative is −p²q(p+q).
- **The N_ab route.** dN_ab/dG_ab = 1/6 − 1/(n−2), and dG_ab ∝ z_a z_b = (−q(p+q), pq, −p(p+q)) on (12, 13, 23). Both weight vectors annihilate this, p·(−q(p+q)) + (p+q)·pq = 0 and (p+q)·pq + q·(−p(p+q)) = 0. **So the N_ab contribution is zero at every n**, not merely a multiple of n−8. The note states both facts, and the sentence "Both are multiples of n−8" is true but idle for N_ab.
- **The M12 route.** [L_a]_1 = −ℓ_a(σ − ε_a) with σ = ε1+ε2+ε3, so the M12 coefficient of F(e;P_a,P_b), counting both (1,2) and (2,1), is ℓ_aℓ_b(ε_a + ε_b − 2σ). The σ part is killed by section 6's Σ w_ab ℓ_aℓ_b = 0. So Σ w_ab ℓ_aℓ_b(ε_a+ε_b) is the full count, once per moment slot, and it is 1/(p(p+q)) and −1/(q(p+q)) on the two vectors, as the note says.
- **The coefficient.** The |Ric e²|² coefficient of M^Φ_12/(8(n−2)) + (3/8)M^Ω_12 is 4/(8(n−2)) − (3/8)(2/9) = −c. S_ab carries the correction with a minus sign, so the G12 coefficient is c·(1/(p(p+q)))·(−p²q(p+q)) = −c·pq on the first vector and c·p² on the second. p(−c·pq) + q(c·p²) = 0.
- **n = 8.** c = 0 and the N_ab part is zero, so both inequalities are free of G on their own.
- **F3 (text, script).** [screen_I73c_gram_elim.py](../scripts/misc/screen_I73c_gram_elim.py) sums both pair orders (a,b) and (b,a) in its M12 coefficient but not in its G-sum. It prints −pq(n−8)/(6(n−2)) and p²(n−8)/(6(n−2)), twice the note's −c·pq and c·p². The zeros are unaffected and the docstring flags the doubling of M12. A reader who compares the printed coefficient with the note still sees a factor of 2. The script also hardcodes c and never derives the correction's |Ric e²|² coefficient, which rests on the hand line above. **Repair**: say in the note that the script's coefficients are 2c·(…), or halve c12 in the script.
- **Text nit.** "whose |Ric e²|² parts combine to 1/(2(n−2)) − 1/12" gives the coefficient inside the correction sum, which S_ab carries with a minus sign. The sign is right in the end result.

## Claim 2, the identity

I re-derived each piece from its definition, with E_k = tr e^k, E_1 = 0, N = n(n−1)/2 and w = x² − 2xy + y².

- **g.** Σ_α x_α Ψ_α² = −Ric(X), so Σ x_α y_β g_αβ = ⟨Ric X, Ric Y⟩ and Σ w g = 2⟨Ric e², (n−1)I⟩ − 2|Ric e|² = 2(n−1)·2E_2 = 4(n−1)E_2.
- **T.** Σ w Σ_γ T = 2·2(n−2)E_2 − 2m_110, and m_110 = Σ_α ε_α(−2ε_α) = −2E_2 by row B. The total is 4(n−1)E_2. So Σ w|h|² = 2(n−1)E_2.
- **Norm.** Σ w·1 = 2N E_2. So Σ w‖N_4‖² = (2N − 4(n−1))E_2/6, and Σ w‖X‖² = [N − 2(n−1)/(n−2) − (2N − 4(n−1))/6]E_2 = (n−1)(n²−10)/(3(n−2))·E_2.
- **Unprojected.** Σ w(ε_α+ε_β)/4 = 2N E_3/4, all cross terms carrying E_1. Σ w Σ_γ ε_γT = 2m_201 − 2m_111, and m_201 = −2E_3 by row B. So the piece is N E_3/2 + E_3 + m_111/2 = N E_3/2 + E_2, with m_111 = 2⟨e,e^#⟩ = 2(E_2 − E_3).
- **Φ and Ω.** Σ w Φ = 2M^Φ_02 − 2M^Φ_11 = 24E_3 − 2(12E_3 − 4E_2) = 8E_2. Σ w Ω = (2/9)[((n−4)(n−5) − 12)E_3 + 4E_2], and (n−4)(n−5) − 12 = (n−1)(n−8).
- **Closing.** The E_3 coefficient is N/2 − (n−1)(n−8)/12 = (n−1)(n+4)/6. The E_2 coefficient is [6(n−2) − 6 − 2(n−2) − (n−1)(n²−10)]/(6(n−2)) = (−n³ + n² + 14n − 24)/(6(n−2)), and n³ − n² − 14n + 24 = (n−2)(n−3)(n+4). Both as stated.
- **The facts used.** Row A is the Killing mass. Row B is the Weyl identity W#I = −W ([Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1). It uses Ricci-flatness and first Bianchi and no criticality, as [bounds.md](../findings/bounds.md) already records in the L73 block, where it was measured at random Weyl tensors. ⟨e,e^#⟩ = E_2 − E_3 is the definition θ = P(W) at unit W. The Ric normalisation tr(ΨΨ^T) = 2 gives Ric(Id) = (n−1)I and tr Ric X = 2 tr X, consistent with section 3. **No criticality enters anywhere**, so the note's non-critical control confirms the statement's scope.
- **Diagonal and same-eigenspace pairs.** Every piece is summed against w, and w = 0 on those pairs. Whatever the per-pair formulas return there (at α = β, ‖N_4‖² is 0 while (1−g)/6 is not) is multiplied by 0. The bilinear rewrites (Σ x_α y_β g = ⟨Ric X, Ric Y⟩ and the Φ, Ω moments) are identities over all ordered pairs, diagonal included. The weighted sum equals Σ_{a,b} w_ab S_ab, which is basis-independent. **Harmless.**
- **Rerun.** [screen_I73c_gapweighted.py](../scripts/misc/screen_I73c_gapweighted.py) evaluates s_αβ by direct projection with the repository's circ, independently of section 2's formulas. It reproduces the note: residuals ≤ 6.2e-15 at the six stored objects and 5.7e-14 at the random non-critical control (criticality residual 0.58).
- **F4 (text, script).** The script's docstring says "the identity needs criticality (rows B, C), so a random Weyl tensor is the control that must FAIL". That is false, the note says the opposite, and the script's own output refutes it. **Repair the docstring**: row B is a Weyl identity, row C is not used, and the control must pass.

## Claim 3, the corollary

- [L125](../findings/second-order.md) reads ⟨Y,L_eY⟩ ≤ ½‖Y‖² + ½⟨W,Y⟩² for every Y ∈ 𝒲_n at a maximiser. For α ≠ β, ⟨W,X⟩ = ⟨W,Y_0⟩ = W(ψ_α,ψ_β) = 0, because π is the orthogonal projection and W ∈ 𝒲_n. So s_αβ ≤ 0 for every α ≠ β, whether or not ε_α ≠ ε_β. **X ≠ 0 is not needed**: X = 0 gives s = 0.
- Every term w·s is then ≤ 0, so the sum is ≤ 0. With E_2 = θ^{−2} and E_3 = tr W³/θ³, and n+4 > 0 and θ > 0, this gives (n−1) tr W³ ≤ (n−3)θ.
- θ = tr W³ + ⟨W,W^#⟩ at unit W turns this into 2 tr W³ ≤ (n−3)⟨W,W^#⟩. Correct.

## Claim 4, reach, and the record search

- **n = 5.** [bispectral.md](../findings/bispectral.md) records ⟨W^#,W⟩ = 2 tr W³ identically on Weyl_n for n ≤ 5. Then θ = 3 tr W³ > 0, and the corollary reads 4 tr W³ ≤ 6 tr W³, which always holds. Empty, as stated.
- **Non-empty at n = 6, 7, 8.** Believable and true as a statement about 𝒲_n. The quoted ratios are large because P can be small and positive.
- **F5 (text).** "at tr W³/θ ≤ 0.43" is exceeded by the script's own S²×S⁴ line, 0.4333 = 13/30. Write ≤ 13/30 or ≤ 0.44.
- **F1 (scope, the substantive finding).** Every unit trace-free operator on Λ² satisfies tr W³ ≤ (N−2)/√(N(N−1)) with N = C(n,2). This is Okumura's bound, recorded in [problem.md](../findings/problem.md) item 2 as the Tachibana-trick inequality. The corollary can therefore bind only where θ < (n−1)/(n−3)·(N−2)/√(N(N−1)). At n = 11 the right side is 1.2156 < √(3/2) = 1.2247, and it decreases in n from there. At n = 10 it is 1.2425. **So at n ≥ 11 the corollary holds automatically at every unit W with θ ≥ √(3/2).** In particular it holds at every global maximiser, since padded W_CP² gives θ = √(3/2) at every n, and at every hypothetical counterexample. It adds nothing there. The same holds in the class-level system, since the bound is spectral. *Screen, not evidence*: four seeds of projected gradient ascent on tr W³ over unit 𝒲_n found 0.5446, 0.5446 and 0.5726 at n = 6, 7, 8, against the thresholds (n−3)/(n−1)·√(3/2) = 0.735, 0.816 and 0.875. So on 𝒲_n the corollary looks inert above √(3/2) at those n too. Its only content is at local maximisers with small θ. **Repair**: the Corollary and "What (c) now is" should say that the condition is implied wherever θ ≥ √(3/2) at n ≥ 11, by Okumura's bound, and screens as inert there at n = 6, 7, 8. The section's "not empty" sentence should add that the witnesses have small P.
- **Record search.** I found no occurrence of (n−1) tr W³ ≤ (n−3)θ, of 2 tr W³ ≤ (n−3)⟨W,W^#⟩, or of the gap-weighted sum in [findings/](../findings/) or [references/](../references/). The nearest recorded objects are these.
  - The orbit-tangent moments g_k = Σ(λ_α−λ_β)²T_kαβ, with Σ g_k = 4(n−1) and Σ λ_k g_k = −4P ([conventions.md](../findings/conventions.md), [bounds.md](../findings/bounds.md)). They use the same weight on the unprojected bracket. They are identities and not second-order conditions.
  - Fox's trace identities, tr L_e = 0 and tr L_e² = κ/θ² ([fence-posts.md](../findings/fence-posts.md), [INDEX-results.md](../findings/INDEX-results.md) row 206). Taking the trace of L125 over W^⊥ gives −1 ≤ ½(D−1), which is empty. So the corollary is not a trace of the Hessian, and those identities do not imply it.
  - The balanced-product value tr W³/θ = 2/((n−1)(n−2)) in [nondegeneracy.md](../findings/nondegeneracy.md).
  - Relative to recorded results, the corollary is implied by Okumura's bound together with θ ≥ √(3/2), at n ≥ 11 and only at those points (F1).

## Claim 5, Fourier-Motzkin

- **Over section 3's interval, correct.** From section 3's equations, G13 = (−ε1s1 − pG12)/(p+q), G23 = (pG12 − ε2s2)/q, G11 = (s1ε3 − qG12)/(p+q) and G22 = (s2ε3 − (p+q)G12)/q. G33's G12 coefficient is −p²/(q(p+q)). The listed ends follow exactly: lower ends from G12 ≥ 0 and G23 ≥ 0, upper ends from G13 ≥ 0, G11 ≥ 4m1²/n, G22 ≥ 4m2²/n and G33 ≥ 4m3²/n.
- **The feasible set is an interval.** The Cauchy–Schwarz constraints are the preimage of the rotated cone {f² ≤ gh, g,h ≥ 0} under an affine map, so they are convex in G12. The note did not say this, and FM needs it.
- **Orientation.** For n > 8 (c > 0), the first inequality bounds G12 below by A1/(c·pq), which pairs with the upper end. The second bounds G12 above, which pairs with the lower end. The fourth pair is p·A1 + q·A2 ≤ 0, the gap-weighted sum. The orientation reverses for n < 8. Correct.
- **F2 (gap, conclusion wrong as stated).** Section 5 says to "carry G_ab − ½τ_ab ≥ 0 and G_ab ≤ m_am_b as explicit constraints", and they are valid, being Σ|h|² ≥ 0 and Σ‖N_4‖² ≥ 0. With them the interval gains these ends.
  - Lower ends G12 ≥ ½τ12 and G12 ≥ (ε2s2 + qτ23/2)/p. They dominate the listed 0 and ε2s2/p, since τ ≥ 0.
  - An upper end G12 ≤ (−ε1s1 − (p+q)τ13/2)/p.
  - Linear (ε,m) ends from G_ab ≤ m_am_b.
  - **So τ enters the interval ends and the nonemptiness condition as well, and "the τ-content lives entirely in the two endpoint inequalities … with G12 replaced by explicit functions of (ε,m)" holds only with section 5's constraints dropped.** **Repair**: either scope the paragraph to section 3's interval and say so, or redo it with these ends, where the endpoints become functions of (ε,m,τ).

## Claim 6, Lean

[I73cGapWeighted.lean](../lean/HamiltonsCubic/Results/I73cGapWeighted.lean), read and not compiled, per the brief.

- **gap_norm_sum** is ½·2N E_2 − 2(n−1)E_2/(n−2) − (2N E_2 − 4(n−1)E_2)/6 = (n−1)(n²−10)/(3(n−2))·E_2. That is the note's summed norm. It is the note's claim.
- **gap_sum_collapse** is the note's closing line verbatim, with the five pieces as hypotheses-free real numbers. It is the note's claim.
- **spectral_corollary** takes the RHS ≤ 0 at E_2 = θ^{−2}, E_3 = tθ^{−3} and derives (n−1)t ≤ (n−3)θ, for n > −4 and θ > 0. It is the note's claim, in the first form only.
- **F6.** gram_free states p(−c·pq) + q(c·p²) = 0 for free reals c, p, q. That is the last line of the elimination and nothing more. It ties c to nothing and touches no Gram matrix. **It says nothing beyond ring arithmetic.** The derivation of the two coefficients (null direction, derivative, M12 count, N_ab cancellation) is not typed. The header's "Not typed" list omits it, and the note's "the Gram cancellation … typed and proved" overstates it. The not-typed reason is also half right. The Φ and Ω pieces need Φ and Ω. The g, T and unprojected pieces need only rows A and B, the Ric identities and w, and could be typed over abstract sums with those rows as hypotheses. **Repair**: rename or redescribe gram_free as the closing arithmetic, and add the coefficient derivation to the not-typed list.
