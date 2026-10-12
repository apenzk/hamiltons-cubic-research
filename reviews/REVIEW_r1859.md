# REVIEW r1859: L149's margin input in Lean, and L3_orbit_zero

Cold brief from the lean loop, Gate 2, analysis only. Read at source: [L149Margin.lean](../lean/HamiltonsCubic/Results/L149Margin.lean), [L3Quad.lean](../lean/HamiltonsCubic/Results/L3Quad.lean), [L3Gap.lean](../lean/HamiltonsCubic/Results/L3Gap.lean), [L127DnExcl.lean](../lean/HamiltonsCubic/Results/L127DnExcl.lean) (the statement of dn_excl_fox), [L127DnEig.lean](../lean/HamiltonsCubic/Results/L127DnEig.lean), [L127Le.lean](../lean/HamiltonsCubic/Results/L127Le.lean), [L120Eigen.lean](../lean/HamiltonsCubic/Results/L120Eigen.lean), the definition of hessQ in [L24HessOp.lean](../lean/HamiltonsCubic/Results/L24HessOp.lean), [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean) (L27_half_span), [L149Statement.lean](../lean/HamiltonsCubic/Results/L149Statement.lean), the L3 and L149 rows of [lean/INDEX.md](../lean/INDEX.md), [findings/second-order.md](../findings/second-order.md) Lemma L149, and [REVIEW_r1858.md](REVIEW_r1858.md) O1. Run: one scratch file under /private/tmp/r1859 with `#print axioms` on seven declarations and three arithmetic `example` screens, which elaborated with exit 0 and no errors. No sweep, no numerics.

| # | Claim | Verdict |
|---|---|---|
| 1 | gap_val: every eigenvalue on a nonzero Weyl H ⊥ M, p, q ≥ 3, is ½, λ_p, λ_q, or at most μ | CONFIRMED |
| 2 | gap_two: at p = q = m ≥ 4, one other than ½ and λ_m is at most 1/(m−1) | CONFIRMED |
| 3 | quad_le_of_gap₂: the eigenbasis bound with two excluded eigenvalues | CONFIRMED |
| 4 | L149_margin: c_p‖H‖² + 3θ(m−4)/(2(m−1))‖H_r‖² ≤ −hessQ(H)/2 | CONFIRMED WITH OBSERVATIONS |
| 5 | L3_orbit_zero: hessQ M K = 0 at every Weyl K ⊥ M with L_e K = K/2 | CONFIRMED WITH OBSERVATIONS |
| 6 | The lean/INDEX.md L149 and L3 rows | CONFIRMED WITH OBSERVATIONS |

**Summary.** The five theorems are proved as stated, the margin identity is the record's to the factor, and the Lean decomposition is the record's at every m ≥ 5 and harmlessly different at m = 4, where the coefficient is zero. The gaps are in bookkeeping: the step from L149_margin to L149Statement's hmargin is untyped, L149Statement's docstring still says neither input is typed, and the L3 row reads as if r1858 reviewed L3_orbit_zero.

## A. Hypothesis inventory

- quad_le_of_gap₂: hT gives the eigenbasis (used), hgap bounds each basis eigenvalue off c₁, c₂ (used), hv kills the coefficients at c₁ and c₂ (used, both disjuncts). c₁ = c₂ is allowed and harmless. Multiplicities are covered because hv quantifies over every eigenvector, and each basis vector is one.
- dn_val: hp, hq ≥ 3 feed dn_units and the value-1 exclusion through dn_eig_line (used), ht, hn fix θ = t(n−1) > 0 (used), hDW, hD1 make D diagonal (used), hD0 gives u ≠ 0 (used), hperp rules out the value 1 (used), heig (used).
- pair_val: hp, hq ≥ 2 (used by the three sector spectra and for μ ≥ 0, λ ≥ 0), hjk, hVW, hV give the pairVec form (used), hV0 (used), heig (used). hn and ht are passed to the spectra.
- gap_val: every hypothesis of L3_gap minus hhalf, all used in the same places as in L3_gap. hperp reaches only the ∅ component, through comp_perp, which is the only sector where M lives.
- gap_two: hp ≥ 4 (used for m − 1 ≠ 0 and to feed gap_val's ≥ 3), hpq (used to collapse λ_q into λ_m and μ into 1/(m−1)), h1, h2 (used to discard the first three disjuncts), the rest passed to gap_val.
- L149_margin: hp, hpq, t, ht, hn build M, θ > 0, ‖M‖ = 1 and the gap (used). hsW, hsP (used for H's membership in weylPerpR and for horth), hsE (used in hexp and hcross, and as the disjunct that makes hrO apply to H_s). hrW, hrP (used to form v). hrO (used twice: to get ⟨H_s, H_r⟩ = 0 and to satisfy quad_le_of_gap₂'s hv). No hypothesis is idle.
- L3_orbit_zero: hp, hq ≥ 2 for the sphere weight and sphere_isCritical2, ht, hn for θ ≠ 0 and ‖M‖ = 1 (hessQ_eq_Le needs both), hKW, hperp to place K in weylPerpR, hK (the whole content). All used.

## B. Is −hessQ/2 the record's margin?

Yes. hessQ_eq_Le gives hessQ(H) = 6θ(⟨L_e H, H⟩ − ½‖H‖²) on weylPerpR, so −hessQ(H)/2 = 3θ(½‖H‖² − ⟨L_e H, H⟩), which on an eigenvector of value λ is 3θ(½ − λ)‖H‖², the record's summand margin exactly. The value on E(λ_m) is 3θ(½ − λ_m) = 3θ/(2(m−1)) = 3θ/(n−2), and the record's κ = n c_p = 3θ₀n/(n−2) gives the same c_p. θ is P(M) at a unit M in Lean and θ₀ in the record. Their numerical value, θ₀ = √(2(n−1)(n−2))/n, is nowhere asserted in these files, and nothing here needs it.

## C. Does the decomposition match?

- H_s. Lean takes one λ_m-eigenvector in W^⊥ ∩ 𝒲ₙ, including 0. The eigenspace is a subspace, so this is "H_s ∈ E(λ_m)", the full λ_m-eigenspace of L_e on W^⊥ ∩ 𝒲ₙ. At m ≥ 5, λ_m differs from μ, −μ, 0 and ½, so by L27's list that eigenspace is the two S²₀(ℝ^m) copies, the record's joint eigenspace. At m = 4, λ_4 = μ_4 = 1/3 and E(λ_m) also contains the Λ² ⊗ Λ² summand, so the Lean w is smaller than the record's w there. The coefficient is (m − 4) = 0 at m = 4, so the two statements coincide.
- H_r. hrO asks H_r ⊥ E(½) and H_r ⊥ E(λ_m) inside W^⊥ ∩ 𝒲ₙ. E(½) there is the span of the cross-pair orbit tangents by L27_half_span (an iff, p, q ≥ 3 off (3, 3)), so this is the record's "outside both, and outside the orbit". H_s is automatically ⊥ E(½) as an eigenvector of another value of a self-adjoint map, so H = H_s + H_r is in N.
- Existence of the decomposition. Every H ∈ N splits so, by the orthogonal projection onto E(λ_m) inside the finite-dimensional weylPerpR M: H − proj is ⊥ E(λ_m), and is ⊥ E(½) because H and proj both are. The Lean result is stated for a given pair and does not need this, but the record's reading "for every H ∈ N" does, and it is not typed (O2).

## D. Are the sector value lists complete?

- Diagonal sector: dn_excl_fox returns the five values θ·{1, λ_p, λ_q, −μ, 0}. dn_val discards 1 by hperp and dn_eig_line, keeps λ_p and λ_q as values, and bounds −μ and 0 by μ (μ > 0 from dn_units). No case lost.
- Pair sector: cross gives 0 or ½, within T gives 0, λ_p, −μ, within Tᶜ gives 0, λ_q, −μ. pair_val keeps ½, λ_p, λ_q and bounds 0 and −μ by μ ≥ 0. The k ∈ T, j ∉ T case is the symmetric one, by pairVec_comm. No case lost.
- Four-set sector: four_le, λ ≤ μ, unchanged from L3Gap.
- Components with |s| ∉ {0, 2, 4} vanish (comp_zero). So gap_val is L3_gap with the maximum unfolded, and it additionally keeps ½ as a value where L3_gap assumed it away.
- At p = q = m: μ = (2m − 2)/(2(m − 1)²) = 1/(m − 1), and ½ − μ = (m − 3)/(2(m − 1)), the record's smallest off-summand margin. (½ − μ) − (½ − λ_m) = (m − 4)/(2(m − 1)), the record's "minus c_p", and (m − 3) − 1 = m − 4. All three identities screened in the scratch file.
- The record's claim that the +μ margin is the smallest off-summand one holds: the other off-summand values are 0 and −μ, both below μ, so their margins are larger.

## E. Edge cases

- m = 4: λ_4 = μ_4 = 1/3. gap_two excludes 1/3 through h2, so the Λ² ⊗ Λ² eigenvectors are excluded as λ_m ones, and what remains (0, −μ, and four-set values below μ) is at most 1/3. The statement is true and the proof does not care that λ_m = μ. L149_margin at m = 4 is c_p‖H‖² ≤ −hessQ(H)/2, which is L3_hessian's bound, halved.
- Range m ≥ 4 against the record's m ≥ 6: the record's m ≥ 6 comes from κ_n's positivity in the other branch (the note at n = 10), not from the margin, and the record itself says the margin coefficient is positive from m = 5. The Lean range is wider and correct.
- (3, 3) is outside Lean's range (hp ≥ 4), which is where μ = ½ and the gap closes.
- H_s = 0: the conclusion is c_p‖H_r‖² + coefficient·‖H_r‖² ≤ −hessQ(H_r)/2, which is 3θ(½ − 1/(m−1))‖H_r‖², the full +μ margin. H_r = 0: it is c_p‖H_s‖² ≤ −hessQ(H_s)/2, an equality. Both = 0: 0 ≤ 0, hessQ M 0 = 0 from its definition. None is vacuous.

## F. Axioms

All seven declarations (gap_val, gap_two, quad_le_of_gap₂, L149_margin, L3_orbit_zero, dn_val, pair_val) depend on exactly propext, Classical.choice and Quot.sound, the standard three. No sorryAx, no native_decide. The three arithmetic screens (μ = 1/(m−1) at p = q = m, λ_4 = μ_4 = 1/3, and the m − 4 identity) elaborated.

## G. Do the INDEX rows claim more than the Lean proves?

- L149 (statement) row: its description of L149_margin matches the theorem, and "which on ‖H‖ = 1 is the block's c(H) ≥ c_p + 3θ₀(m−4)/(2(m−1))w²" is right under θ = θ₀ and c = −hessQ/2 (B). It lists the operator-norm input as owed and says L149Statement still takes both inputs as hypotheses, which is accurate.
- hmargin in low_margin_forces_low_norm is `cp + ρ * w ^ 2 ≤ c` over bare reals. L149_margin gives it with c := −hessQ(H)/2, c_p := 3θ/(2(m−1)), w² := normSq2 H_r and ρ := 3θ(m−4)/(2(m−1)), once normSq2(H_s + H_r) = 1 is imposed. Three steps separate them and none is typed: the normalisation; the decomposition's existence for a given H ∈ N (C); and, since the chain runs at ρ = ρ^eff_n, the weakening ρ^eff_n ≤ 3θ₀(m−4)/(2(m−1)), which is |κ_n| ≥ 0, i.e. θ₀(n) ≥ √(3/2). Each is short. The row names none of them (O2).
- L149Statement.lean's module docstring, section "What is NOT typed here", still says "The two inputs themselves" are untyped. The first is now typed (O3).
- L3 row: the L3_orbit_zero clause is accurate as a statement about ½-eigenvectors, and "so the Hessian vanishes on the orbit tangent" follows through L27_half_span's reverse direction at p, q ≥ 3 off (3, 3), a composition the row leaves to the reader. The sentence after it, "Gate 2 on L3Quad: r1858, CONFIRMED WITH OBSERVATIONS", now covers a theorem r1858 never saw: r1858 raised O1 asking for it (O1 below).

## H. What would break each statement, and what I did to look

- gap_val: an eigenvector with value in (μ, ½) off λ_p, λ_q, or with value 1 surviving ⊥ M. I traced every disjunct of dn_excl_fox and the three pair spectra and found each landed (D).
- gap_two: λ_q surviving as a separate value, or μ above λ_m. Neither: hpq identifies λ_q with λ_m and μ with 1/(m−1) ≤ λ_m at m ≥ 4.
- quad_le_of_gap₂: a v with a component on a c₁- or c₂-eigenvector, or a repeated eigenvalue splitting across basis vectors. hv covers every eigenvector of either value, and each basis vector is one, so no coefficient escapes.
- L149_margin: a cross term ⟨L_e H_r, H_s⟩ or ⟨H_s, H_r⟩ ≠ 0, or θ ≤ 0. The first two are killed by hrO applied to H_s itself and by LeLin_selfAdj, and θ = t(n−1) > 0. I also checked the final ring identity by hand: 3θ(½(a+b) − λ_m a − b/(m−1)) = (3θ/(2(m−1)))(a+b) + 3θ(m−4)/(2(m−1))·b.
- L3_orbit_zero: a ½-eigenvector outside weylPerpR, which hessQ_eq_Le would not reach. hKW and hperp exclude it. The theorem is the diagonal form hessQ(K) = 0. The bilinear statement, Hess(K, ·) = 0, is not typed. It follows here because L_e ≤ ½ on W^⊥ makes the Hessian negative semidefinite (O4).

## Observations

- **O1.** The L3 row's "Gate 2 on L3Quad: r1858" should name r1859 for L3_orbit_zero, since r1858 reviewed only quad_le_of_gap and L3_hessian and raised O1 asking for this theorem.
- **O2.** The L149 (statement) row should name the three untyped steps from L149_margin to hmargin: normalisation ‖H‖ = 1, the orthogonal decomposition of an arbitrary H ∈ N into H_s + H_r, and ρ^eff_n ≤ 3θ₀(m−4)/(2(m−1)). A short bridging theorem would close the first two.
- **O3.** [L149Statement.lean](../lean/HamiltonsCubic/Results/L149Statement.lean)'s docstring still lists the margin input as untyped. It should point to L149Margin.lean.
- **O4.** L3_orbit_zero is the quadratic form vanishing, the diagonal of the record's "the Hessian vanishes on T_{W*}𝒪". Equivalent here by negative semidefiniteness, which is L27's ½ bound, but the equivalence is not typed.
- **O5.** The margin's Lean range, m ≥ 4, is wider than the record's m ≥ 6, correctly: the record's restriction belongs to the other input.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** All five theorems prove what they state, the margin is the record's to the factor 3θ(½ − λ), the value lists lost no case in adaptation, and the Lean decomposition is the record's. The rows overstate only review coverage (O1) and leave the bridge to hmargin unnamed (O2).
