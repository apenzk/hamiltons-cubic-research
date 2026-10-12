# REVIEW r1620: L26 stated as one theorem, the L26 row's pointers, and the second within family in L_e units

Log: [agent_logs/r1620.log](../agent_logs/r1620.log)

Scope: mu_ge_half_iff and L26_main in [L26Main.lean](../lean/HamiltonsCubic/Results/L26Main.lean) and the L26 row of [lean/INDEX.md](../lean/INDEX.md) at commit eb4f6ec9, the L26 row's pointers to L126 and L127 (commit ed256e48, whose row edit landed in its twin 43951eeb), and within_LeLin_spectrum_out in [L127Le.lean](../lean/HamiltonsCubic/Results/L127Le.lean) with [L127WMult.lean](../lean/HamiltonsCubic/Results/L127WMult.lean)'s header at commit 10b39f37, against [findings/nondegeneracy.md](../findings/nondegeneracy.md) Lemma L26. Analysis only: the build and the axiom audit were run, and one exact-arithmetic screen at n = 4 on objects constructed for it (reported as a screen).

**L26_main states the record's three clauses and each is proved soundly: the Bianchi vector v = 2a − b − c is 3X exactly, e is the record's W/θ at unit norm, and the criterion is right. within_LeLin_spectrum_out is a correct transfer through sphereWeight_compl. Three gaps: L26_main omits v ≠ 0, which makes its eigen-equation clause satisfiable by the zero vector although splitVec_ne_zero is in reach. The L26 (statement) row and findings/INDEX-results.md still say the Weyl and eigen clauses are unstated. The L26 row's file column omits L26Main.lean.**

| claim | declaration or text | verdict |
|---|---|---|
| C1 | v = 2a − b − c is 3X, X = φ_π ⊙ φ_ρ minus its Λ⁴ component | CONFIRMED (algebra, and a screen: ‖X‖² = 4/3, a + b + c totally antisymmetric) |
| C2 | LeLin's e is the record's e = W/θ at unit norm | CONFIRMED |
| C3 | mu_ge_half_iff | CONFIRMED |
| C4 | L26_main states Lemma L26 | CONFIRMED WITH GAPS (no v ≠ 0 clause) |
| C5 | the λ_max comparison and (3,4) uniqueness left to L26.lean | CONFIRMED (they are proof content, the record's Statement has three clauses) |
| C6 | scope disclosed (Fin n, unit norm) | CONFIRMED |
| C7 | the row's pointers (split_value_eq, split_LeLin, within_LeLin_spectrum_out, within_top_exists_out, L126_block_meets_iff) | CONFIRMED (with a note on units) |
| C8 | within_LeLin_spectrum_out | CONFIRMED |
| C9 | L127WMult header | CONFIRMED |
| C10 | build and axiom audit | CONFIRMED (2/2 and 6/6 on the standard three) |
| C11 | downstream text | GAP (L26 (statement) row and INDEX-results stale) |
| C12 | style | CONFIRMED (one lint warning noted) |

Summary: the lemma is now stated and proved faithfully in the layer, and what remains is a nonvanishing clause, two stale downstream sentences and a file column.

## 1. v = 3X (C1)

splitVec i j k l is 2 rk2(φ_ij, φ_kl) − rk2(φ_ki, φ_jl) − rk2(φ_il, φ_jk), with rk2 U V = U⟨V, ·⟩ + V⟨U, ·⟩, the symmetric product U ⊙ V. With π = {i, j} ⊂ T and ρ = {k, l} ⊂ Tᶜ, a = φ_π ⊙ φ_ρ. Since φ_ki ⊙ φ_jl = φ_ik ⊙ φ_lj, the three terms are the three pairings of the four indices in the cyclic order of the first Bianchi sum, and a + b + c is the Λ⁴ element (φ_ij ∧ φ_kl read in S²Λ²). The three are mutually orthogonal of equal norm, so the orthogonal projection of a onto Λ⁴ is ⅓(a + b + c) and X = ⅔a − ⅓b − ⅓c, which is v/3. This matches the record's coefficients.

Norm: inner2 is ½ tr(XᵀY), so ‖φ_ij‖² = 1, and innerOp is ½ Σ over ordered pairs, which is the sum over unordered pairs. Then ‖a‖² = |a(φ_ij)|² + |a(φ_kl)|² = 2 and ‖X‖² = (4 + 1 + 1)/9 · 2 = 4/3. A screen at n = 4 in exact rationals reproduced ‖a‖² = 2, the three cross inner products 0, ‖v/3‖² = 4/3, ⟨v, a + b + c⟩ = 0, a vanishing Bianchi sum for v and total antisymmetry of a + b + c (screen only, the Lean proof is splitVec_isWeyl2).

IsWeyl2 carries self-adjointness, first Bianchi and Ricci-flatness, so IsWeyl2 v is X ∈ Weyl_n.

## 2. e (C2)

LeLin a v = foxProd2 ((Pcubic2 a)⁻¹ • a) v, so e = a/P(a). split_LeLin rewrites Pcubic2 (restrict hW) = theta (diagOp w) through Pcubic2_restrict and theta_of_unit under hn : normSq = 1, so e = W/θ at unit norm, the record's e.

## 3. The criterion (C3)

μ = (p + q − 2)/(2(p − 1)(q − 1)) ≥ ½ is p + q − 2 ≥ pq − p − q + 1, that is pq − 2p − 2q + 3 ≤ 0, that is (p − 2)(q − 2) ≤ 1. The Lean proof clears the positive denominator with le_div_iff₀ and closes both directions by nlinarith. On Fin n, T.card + Tᶜ.card = n, so the record's n − 2 is the numerator.

## 4. L26_main against the Statement (C4, C5, C6)

The record's Statement ([findings/nondegeneracy.md:85](../findings/nondegeneracy.md#L85)) has exactly three clauses, X ∈ Weyl_n, e ∘ X = μX, and the criterion, over p, q ≥ 2 with π, ρ coordinate planes in the two blocks. L26_main's hypotheses (2 ≤ T.card, 2 ≤ Tᶜ.card, i, j ∈ T, k, l ∉ T, i ≠ j, k ≠ l) are that range, and its conclusion is the three clauses at v = 3X, which transfer to X by scaling. The λ_max comparison, the (3,4) overtake and its uniqueness sit in the proof paragraph at line 89, so leaving them to [L26.lean](../lean/HamiltonsCubic/Results/L26.lean) is correct and the header says so. The scope (Fin n, unit-norm sphere product, t > 0) is in both the header and the row.

Gap: e ∘ X = μX is an eigenvalue claim, and as typed it holds of v = 0. L26_main proves the equation for the specific splitVec, so it is not vacuous in fact, but a reader of the statement cannot tell that from it. splitVec_ne_zero ([L126Final.lean:34](../lean/HamiltonsCubic/Results/L126Final.lean#L34)) is reachable from L26Main's imports (L126Main → L126GenBridge → L126Weyl → L126General → L126DF → L126Final) and closes this with one more conjunct.

The identification v = 3X is prose in the header, since the layer has no Λ⁴ projection to state it with. §1 checks it, and the header discloses it.

## 5. The pointers (C7)

ed256e48 changes only STATUS.md although its message names lean/INDEX.md as the deliverable. The row edit it describes is in 43951eeb, which has the same message. Against HEAD's row ([lean/INDEX.md:544](../lean/INDEX.md#L544)):

- split_value_eq ([L126Assembly.lean:104](../lean/HamiltonsCubic/Results/L126Assembly.lean#L104)) gives (w_ij + w_kl − w_ik − w_jl)/(2θ) = μ_{p,q}, and split_LeLin ([L126Bridge.lean:49](../lean/HamiltonsCubic/Results/L126Bridge.lean#L49)) the eigen-equation. Accurate.
- within_LeLin_spectrum_out bounds the L_e spectrum of the second family by {0, (q − 2)/(2(q − 1)), −μ}, and within_top_exists_out ([L127Within.lean:341](../lean/HamiltonsCubic/Results/L127Within.lean#L341)) exhibits the top eigenvector at q ≥ 3 in M units, value ½ t(p/(q − 1) + 1)(q − 2), which is (q − 2)/(2(q − 1)) after division by θ = t(n − 1). Accurate as pointers. The attainment in L_e units composes within_top_exists_out with LeLin_pairVec_iff, which no declaration does, and "λ_max is the top of the whole spectrum" is L27's, as the record says. Neither is a gap in these commits since the row cites the pieces and the comparison proved in L26.lean takes λ_max as a closed form.
- L126_block_meets_iff ([L126Main.lean:119](../lean/HamiltonsCubic/Results/L126Main.lean#L119)) is the ½-eigenspace meeting the (2,2) block exactly at (3,3). Accurate.

Process note: 10b39f37 also flipped the L260 row from partial to proved, an unrelated edit from a stale copy, and 43951eeb restored partial. HEAD's L260 row is consistent with plan-lean.md, so nothing is owed.

## 6. within_LeLin_spectrum_out (C8, C9)

sphereWeight_compl ([L127Within.lean:196](../lean/HamiltonsCubic/Results/L127Within.lean#L196)) is sphereWeight Tᶜ = sphereWeight T, so the hypotheses hn and heig at T are those at Tᶜ, and within_LeLin_spectrum at Tᶜ with (hq, Tᶜᶜ.card ≥ 2) applies to j, k ∈ Tᶜ. The convert only has to match the Weyl proof term and the weight, which proof irrelevance and the rewrite do. compl_compl turns the three values into 0, (q − 2)/(2(q − 1)) and −(q + p − 2)/(2(q − 1)(p − 1)), and ring_nf identifies the last with −μ_{p,q}. The hypotheses c, hsum, hne and the pair span are unchanged by the swap. Correct.

L127WMult's header now says the division by θ is within_LeLin_spectrum, which it is, and the L127 row scopes within_LeLin_spectrum to j, k ∈ T with the new theorem beside it. r1619's two gaps are closed.

## 7. Soundness (C10)

lake build HamiltonsCubic.Results.L26Main HamiltonsCubic.Results.L127Le completed (8808 jobs, linter warnings only). axiom_audit.py --only L26Main.lean: 2/2 clean. --only L127Le.lean: 6/6 clean. Only propext, Classical.choice and Quot.sound.

## 8. Downstream (C11)

- [lean/INDEX.md:545](../lean/INDEX.md#L545), the L26 (statement) row, still reads "X ∈ W_n and e ∘ X = μX are NOT stated". They are now stated and proved in L26Main.lean.
- [findings/INDEX-results.md:41](../findings/INDEX-results.md#L41) gives L26 as "Lean: partial" with L26Statement.lean as the statement, while the L26 row reads proved with the statement typed. One of the two needs to say which status holds.
- [lean/INDEX.md:544](../lean/INDEX.md#L544): the file column lists only L26.lean, while the row's own claim rests on L26Main.lean.

findings/nondegeneracy.md cites only L26.lean for the uniqueness, which remains accurate.

## 9. Style (C12)

No em dash in L26Main.lean, L127Le.lean, L127WMult.lean or the L26 row, no backticks inside link text, and the row is one line. The new text uses no semicolon splices. The build warns at [L127Le.lean:155](../lean/HamiltonsCubic/Results/L127Le.lean#L155) that `convert ... <;> rw` needs no `<;>`, cosmetic.

## Gaps

1. [L26Main.lean:45](../lean/HamiltonsCubic/Results/L26Main.lean#L45): L26_main has no v ≠ 0 conjunct, so the eigen clause reads as satisfiable by zero. Add splitVec_ne_zero.
2. [lean/INDEX.md:545](../lean/INDEX.md#L545) and [findings/INDEX-results.md:41](../findings/INDEX-results.md#L41): stale "NOT stated" and "Lean: partial" after L26Main.
3. [lean/INDEX.md:544](../lean/INDEX.md#L544): the file column omits L26Main.lean.

## Verdict

**CONFIRMED WITH GAPS.**
