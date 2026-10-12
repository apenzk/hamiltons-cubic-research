# REVIEW r1611: L127Cross.lean (the cross-factor row of L127) and pair_perp in L122Orbit.lean

Log: [agent_logs/r1611.log](../agent_logs/r1611.log)

Commits: e264c22c ([L127Cross.lean](../lean/HamiltonsCubic/Results/L127Cross.lean) and the L127 row of [lean/INDEX.md](../lean/INDEX.md)), 5183c3cc (`pair_perp` in [L122Orbit.lean](../lean/HamiltonsCubic/Results/L122Orbit.lean), the L122 row's owed list, the header of [L122Weyl.lean](../lean/HamiltonsCubic/Results/L122Weyl.lean)). Record: [second-order.md](../findings/second-order.md), Lemma L127 (line 1717) and its proof of the cross-factor row (line 1740). Analysis only: the build and the axiom audit were run and every coefficient identity was checked by hand. No screen was run.

| claim | declaration or text | verdict |
|---|---|---|
| C1 | cross_coeff_in, cross_coeff_out (L127Cross.lean:35, :69) | CONFIRMED |
| C2 | crossPair (L127Cross.lean:105) as the operator identity | CONFIRMED |
| C3 | "the cross-factor row is PROVED", spectrum exactly {½ simple, 0^{n−4}} | CONFIRMED WITH GAPS |
| C4 | pair_perp (L122Orbit.lean:107), the orthogonal half of hcap's domain | CONFIRMED |
| C5 | the L127 row's owed list and the L122 row's owed list | CONFIRMED WITH GAPS |
| C6 | build and axioms | CONFIRMED |
| C7 | downstream text and style | CONFIRMED |

Summary: the operator identity is correct, and it does imply the record's cross-factor spectrum on the Ricci cut by a hand argument checked here. The spectrum itself, the value θ = t(n−1) and the passage to L_e units stay in prose, while the L127 row reads "PROVED" and lists none of them as owed.

## 1. Definitions read

- `sphereWeight S` ([Families.lean:308](../lean/HamiltonsCubic/Base/Families.lean#L308)): hollow, symmetric, entry |Sᶜ|/(|S|−1) inside S, |S|/(|Sᶜ|−1) inside Sᶜ, and −1 across. With p = |T|, q = |Tᶜ| and w = t·sphereWeight T this gives α = tq/(p−1), β = tp/(q−1), γ = −t.
- The pair span is Σ c_i f_i with f_i = rk2(φ_ji, φ_ki), i ranging over s = indices off {j, k}. [L122Pair.lean](../lean/HamiltonsCubic/Results/L122Pair.lean) gives `pair_gram` (⟨f_i, f_i'⟩ = 2δ) and `pair_ricciFlat_iff` (the Ricci cut is Σ c_i = 0), so the coefficient inner product is the right one up to the factor 2, and crossPair's hypothesis `hsum` is exactly the Ricci cut.
- `theta_sphereProduct` ([Families.lean:655](../lean/HamiltonsCubic/Base/Families.lean#L655)) fixes RealLayer's θ at the unit-norm sphere product as thetaSplit(p, q). The multiplier of Q(W) = θW (r1610 §1) is what the orbit eigenvalue θ/2 refers to.

## 2. C1, the two coefficient identities: CONFIRMED

At q ∈ T ∩ s the left side is ½(w_jq + w_kq − w_jk)c_q + ½Σ_i c_i w_iq = ½(α − t + t)c_q + ½[α(C_T − c_q) − t C_{Tᶜ}]. The c_q terms cancel, and C_{Tᶜ} = −C_T on the cut, so the value is ½(α + t)C_T. The Lean right side is ½(t·q/(p−1) + t)C_T, the same. The out-factor twin is symmetric: ½(−t + β + t)c_q + ½[β(C_{Tᶜ} − c_q) − t C_T] = ½(β + t)C_{Tᶜ}. The proofs split s by T, isolate the diagonal term through `sum_ite_eq'`, and use `hsum` exactly once, which matches this derivation.

## 3. C2, crossPair as an operator identity: CONFIRMED

crossPair rewrites M ∘ Σ c_i f_i through `pair_invariant`, restricts each inner sum to s with `pairSum_restrict`, swaps the double sum, and matches the coefficient at each q against C1. The statement is on every skew X, and the right side's κ_q depends on q only through membership in T. Its hypotheses (j ∈ T, k ∉ T, Ricci cut) are the record's cross-factor setting. No hypothesis 2 ≤ p, q appears, which is harmless: at p = 1 the T part of s is empty and the identity still holds in Lean's division.

## 4. C3, the record's spectrum: CONFIRMED WITH GAPS

**The implication holds, by hand.** α + t = t(q + p − 1)/(p−1) = t(n−1)/(p−1), and β + t = t(n−1)/(q−1). The in-factor part of s has p−1 indices and the out-factor part q−1, so κ = (t(n−1)/2) times the per-factor average of c, which is (t(n−1)/2) times the orthogonal projection onto factor-constant vectors (orthogonal because `pair_gram` makes the f_i orthogonal with a common norm). Σκ = ½t(n−1)(C_T + C_{Tᶜ}) = 0, so the Ricci cut is invariant. The cut has dimension n−3. Its factor-constant part is one line, eigenvalue t(n−1)/2, and its zero-sum-per-factor part has dimension (p−2) + (q−2) = n−4 and eigenvalue 0. The record's proof (line 1740) uses the same three eigenvector types on 1^⊥, so "the Ricci cut" is the record's domain, and n−3 matches the L127 row's own "pair-block dimension after the Ricci cut".

**θ identification.** The criticality multiplier at t·sphereWeight T is t(n−1) at every t: within T, w_ab² + (w²)_ab = α² + (p−2)α² + qt² = θα gives θ = (p−1)α + qt²/α = t(n−1). The phrase "at unit norm" is needed only when θ means RealLayer's `theta`, which coincides with the multiplier there. The value agrees with `orbit_eigen`'s θ/2, a consistency the file could state as a corollary.

**Gaps.**

1. No theorem states the spectrum. "Exactly {θ/2 simple, 0^{n−4}}" is a reading of crossPair in the docstring ([L127Cross.lean:104](../lean/HamiltonsCubic/Results/L127Cross.lean#L104)) and the header ([L127Cross.lean:15](../lean/HamiltonsCubic/Results/L127Cross.lean#L15)). No declaration exhibits the eigenvector, the n−4 dimensional kernel, or that these exhaust the cut. The dimension count is elementary but it is the row's content.
2. The identities α + t = t(n−1)/(p−1), β + t = t(n−1)/(q−1) (which need n = p + q) and θ = t(n−1) are prose at [L127Cross.lean:15–16](../lean/HamiltonsCubic/Results/L127Cross.lean#L15). The eigenvalue in the Lean statement is ½(t·q/(p−1) + t)(p−1), which nobody has written as θ/2.
3. The passage to L_e units (division by θ, e = M/θ) is prose, as it was in r1610 for `orbit_eigen`.

The [lean/INDEX.md](../lean/INDEX.md) L127 row (line 495) says "The cross-factor row is PROVED" and "so the block carries θ/2 once (the orbit) and 0 on the n−4 zero-sum-per-factor vectors". The operator identity is proved. The spectrum statement and the θ value rest on the three prose steps above, and the row's "Owed" does not list them.

## 5. C4, pair_perp: CONFIRMED

⟨diagOp w, Σ c_i f_i⟩ is linear in c (the `lin` step). Each term is ⟨diagOp w φ_ji, φ_ki⟩ + ⟨diagOp w φ_ki, φ_ji⟩ = w_ji⟨φ_ji, φ_ki⟩ + w_ki⟨φ_ki, φ_ji⟩ = 0, because j ≠ k makes {j, i} ≠ {k, i}. The statement holds for every c, not only on the Ricci cut, and needs only symmetry of w. hcap is L24's cap on T_W S ∩ Weyl = M^⊥ ∩ Weyl, so `pairSpan_isWeyl` (Weyl on the cut) and `pair_perp` (orthogonal everywhere) together give the domain on the cut, as the new L122Weyl header ([L122Weyl.lean:10](../lean/HamiltonsCubic/Results/L122Weyl.lean#L10)) says. This closes r1610's gap 1 on the orthogonality half.

## 6. C5, the owed lists: CONFIRMED WITH GAPS

- **L122 row** (line 356): owes the bare-CurvOp to CurvOp2/LeLin carry, the composition of `pairBlock` with `Lb` and `block_eq_kirchhoff` (Ricci rows included), and the maximiser inequality from L24. With the Weyl and orthogonal halves now proved, this is the whole route to `hcap` as stated at [L122Statement.lean:233](../lean/HamiltonsCubic/Results/L122Statement.lean#L233). The norm conversion between `nrmS` and the factor 2 of `pair_gram` belongs inside the composition item. Complete.
- **L127 row** (line 495): owes the within-factor row, the D_n row and the agreement of the two decompositions. These are right and honest. Missing: the three steps of §4 (the spectral reading, the θ = t(n−1) identification with n = p + q, and the L_e normalisation). Either the row lists them or the cross-factor clause reads "the operator identity is PROVED".

## 7. C6, build and axioms: CONFIRMED

`lake build HamiltonsCubic.Results.L127Cross HamiltonsCubic.Results.L122Orbit` completed (8795 jobs, exit 0, only style linter notes). `axiom_audit.py --only L127Cross.lean`: 4/4 on the standard three. `--only L122Orbit.lean`: 5/5 on the standard three. L127Cross is imported in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean).

## 8. C7, downstream and style: CONFIRMED

- [findings/INDEX-results.md](../findings/INDEX-results.md) row 127 and the L127 block in [second-order.md](../findings/second-order.md) carry no Lean status, so nothing there is stale. STATUS.md and plan-lean.md counts moved from 861 to 862 files.
- The L127 row's link to [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean) for the four-set row resolves.
- Added lines in both commits: no em dash, no backtick inside link text, INDEX rows single-line. The semicolons in the L122 owed list separate list items that carry commas, and the one in L127Cross's header ends a bullet.
- Observation: the header's "θ = t(n−1) at unit norm" is correct for RealLayer's θ, while the multiplier equals t(n−1) at every scale.

## Verdict: CONFIRMED WITH GAPS

The operator identity and `pair_perp` are correct and clean. The gap is one of labelling: the L127 row calls the cross-factor spectrum PROVED when the spectrum, θ = t(n−1) and the L_e normalisation are prose readings, and its owed list omits them.
