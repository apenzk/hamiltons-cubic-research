# REVIEW r1646: L127's D_n decomposition is direct, L127DnDirect.lean (98dd7e46) and r1645's repairs (b47cfdc7)

**Verdict: CONFIRMED WITH GAPS.** `dn_direct` is a genuine uniqueness statement for `dn_decomp`'s six families, every step checks by hand, and its hypotheses are exactly `dn_decomp`'s conjuncts. The new sphere-line lemmas are correct, r1645's G1–G4 are repaired, and the axiom audit is 3/3 and 16/16 on the standard three. Two minor wording gaps remain: the INDEX passage says `h = h' = 0` where the theorem gives it only on `T` and `Tᶜ`, and L127DnDim's title still calls the family dimensions multiplicities.

Reviewer: cold adversarial Gate 2, analysis only. The checks are reading and hand derivation, plus `lake env lean` on both files (exit 0, no output) and the axiom audit. No numerical screen was run.

## Claim table

| # | Claim | Verdict | Basis |
|---|---|---|---|
| 1a | `dn_direct` has the families' defining conditions as hypotheses (L127DnDirect.lean:49-52) | CONFIRMED | The hypotheses `∑_T h = 0`, `∑_{Tᶜ} h' = 0`, `IsCrossW T X`, `IsWithinW T Z`, `IsWithinW Tᶜ Z'` and the sum `c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z'` are word for word `dn_decomp`'s existential body (L127DnSpan.lean:171-174), with the same κ = `dnK`. So a vanishing difference of two `dn_decomp` outputs is an instance, and the theorem is the uniqueness of that decomposition. |
| 1b | Row sums over Tᶜ give q(κh_a − c) = 0 (lines 63-68) | CONFIRMED | Summing the cross entry −c + κh_a + κ'h'_b + X_ab over b ∈ Tᶜ gives −qc + qκh_a + κ'∑_{Tᶜ}h' + ∑_{Tᶜ}X_{a·}, and the last two vanish by `hh'` and `IsCrossW`'s third clause. q ≠ 0 at q ≥ 3 gives κh_a = c. |
| 1c | The total gives c = 0 (lines 74-80) | CONFIRMED | Summing κh_a = c over a ∈ T gives κ∑_T h = pc, the left side is 0 by `hh`, p ≠ 0. |
| 1d | κ ≠ 0 at p ≥ 3 (lines 57-60) | CONFIRMED | `dnK T` = −(p − 2)/q (L127DnSpan.lean:102), nonzero for p ≥ 3 and q ≥ 3. `dnK Tᶜ` = −(q − 2)/p after `compl_compl`. Both are load-bearing: at p = 2, κ = 0 and the λ_p family is zero, r1645's claim 2b. Then h_a = 0 on T. |
| 1e | Column sums give h' = 0 on Tᶜ (lines 87-101) | CONFIRMED | For b ∈ Tᶜ the sum over a ∈ T is −pc + κ∑_T h + pκ'h'_b + ∑_T X_{·b}, and ∑_T X_{ab} = ∑_T X_{ba} = 0 by symmetry and `IsCrossW`'s fourth clause. With c = 0, pκ'h'_b = 0 with p, κ' ≠ 0. |
| 1f | Support separation of X, Z, Z' (lines 104-129) | CONFIRMED | With c = 0 and h, h' zero where read, each cross entry gives X_ab = 0, and the transposed case uses `IsCrossW`'s symmetry. Same-side entries of X vanish by its support clause. Then Z + Z' = 0, and Z' vanishes on T × T and Z off T × T by `IsWithinW`'s support clauses, so both are 0. `lamW_eq_zero` (line 29) turns h = 0 on S into `lamW S κ h = 0`, correct since `lamW` (L127Dn.lean:185-187) reads h only at points of S. |
| 2 | `dn_cross_entry` (lines 34-45): the (a, b) entry, a ∈ T, b ∉ T, reads −c + κh_a + κ'h'_b + X_ab | CONFIRMED | `sphereWeight T` (Base/Families.lean:308-312) at a ∈ T, b ∉ T, a ≠ b is −1, giving −c. `lamW T κ h` there is its third case, κh_a. `lamW Tᶜ κ' h'` has a ∉ Tᶜ, b ∈ Tᶜ, its fourth case, κ'h'_b. Z and Z' vanish there by support. |
| 3 | `sphereWeight_ne_zero`, `finrank_sphereLine` (L127DnDim.lean:329-342) | CONFIRMED | The entry at a ∈ S, b ∉ S is −1, so the weight is nonzero once S and Sᶜ are nonempty, and `finrank_span_singleton` gives dimension 1. |
| 4a | r1645 G1–G4 repaired | CONFIRMED | G1 by claim 3. G2: the header now cites `dn_direct` (L127DnDim.lean:27), which proves directness from the cross block's sums rather than by the counting route r1645 sketched, and either route suffices. G3: b47cfdc7's body names 59fca6d1's title as one step ahead. G4: the dimensions passage closes "16/16 on the standard three" (lean/INDEX.md:495), which the audit matches. |
| 4b | The owed item is stated honestly and consistently | CONFIRMED WITH GAPS | L127DnDirect.lean:18, L127DnDim.lean:27-28 and the INDEX row's **Owed** all name the passage to eigenvalue multiplicities as undeclared. The INDEX row adds the p = 2 or q = 2 spanning and the agreement of the two decompositions, which predate 98dd7e46 and are row-scoped. "Direct eigen-decomposition" is fair: each family's eigenvalue is declared (`sphere_line`, `K_lam`, `K_crossW`, `K_zero`). Residual: L127DnDim.lean:7's title "L127's D_n multiplicities, the dimension of each family" and line 26's "the record's multiplicities" still label dimensions as multiplicities (G2 below). |
| 4c | Nothing claimed beyond what is declared | CONFIRMED WITH GAPS | The INDEX passage's "forcing c = 0 and h = h' = 0" (lean/INDEX.md:495) overstates the proof, which gives h = 0 on T and h' = 0 on Tᶜ only, h being free off T. The file header (L127DnDirect.lean:15-16) states it correctly. G1 below. |
| 5 | Axiom audit | CONFIRMED | `axiom_audit.py --only L127DnDirect.lean`: 3/3 clean on the standard three. `--only L127DnDim.lean`: 16/16 clean. Both files compile with `lake env lean`, exit 0. |

## Gaps

- **G1 (prose, minor), [lean/INDEX.md:495](../lean/INDEX.md).** "forcing $c=0$ and $h=h'=0$" should read "$h=0$ on $T$ and $h'=0$ on $T^c$", as the file header does.
- **G2 (prose, minor), [L127DnDim.lean:7](../lean/HamiltonsCubic/Results/L127DnDim.lean) and [L127DnDim.lean:26](../lean/HamiltonsCubic/Results/L127DnDim.lean).** The title and closing sentence still call the family dimensions the multiplicities, while line 27 owes the passage to multiplicities. Retitle to "the dimension of each family" and write "the record's multiplicity counts" or similar.

## What would break each claim, and what was done to look for it

- Claim 1 would break on a nonzero tuple (c, h, h', X, Z, Z') with vanishing sum. The candidates are a kernel of κ, killed at p ≥ 3 by 1d, and a cross X absorbing −c + κh_a, killed by the block row and column sums. I rederived every sum by hand and checked `IsCrossW`'s clauses supply exactly the vanishing sums used. I also checked the hypotheses against `dn_decomp` so the uniqueness is about the right families.
- Claim 2 would break on a wrong case of `lamW` or `sphereWeight` at a ∈ T, b ∉ T. I evaluated each definition's case split there.
- Claim 3 would break on `sphereWeight S = 0` with S and Sᶜ nonempty, which the −1 entry excludes.
- Claim 4 would break on a passage claiming the multiplicities as declared. I read both headers, both commit bodies and the whole L127 **Owed** clause, and found only the two wording slips above.
- Claim 5 would break on a hidden axiom or a `sorry`. The audit is clean.
