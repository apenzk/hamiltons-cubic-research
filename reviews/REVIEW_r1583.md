# Review r1583: L135(a) at the competitor (L135Inst), the L34 row's owed item, and r1581's repairs

**Standfirst.** The three commits are sound and the Lean is correct. [L135Inst.lean](../lean/HamiltonsCubic/Results/L135Inst.lean) proves `u + tH = √(1+t²)(cos(arctan t)u + sin(arctan t)H)` with no orthogonality, derives the reparametrisation relation from positive degree-2 homogeneity (which δ²(W) = ‖Alt(W₋)‖² has, W₋ = ½(\|W\| − W) being positively 1-homogeneous), and feeds it to [L135Statement.lean](../lean/HamiltonsCubic/Results/L135Statement.lean)'s `coeff_identity` at A = 1/9. The expansions share their constant term and their linear coefficient B, as the record's definitions require. 47160e33 closes all four of r1581's gaps, and 438f9217's claim that dim U = m is proved at m = 6, 7, 8 is true. The build is clean, both audits read the standard three only, and there is no `sorry`, `admit` or `native_decide`. Four gaps remain, all in prose. The main one is that `hrel_of_homog` duplicates `line_eq`, which [L135Statement.lean:91](../lean/HamiltonsCubic/Results/L135Statement.lean#L91) already proved. The "instantiation" the old L135 row listed as owed therefore did not need a new file, and the new header's "This file supplies that relation" is inaccurate. The L140 row's "owing only δ² as an operator function" leaves out the two expansion hypotheses. The L34 row keeps a stale "nothing owed but the formal assembly" sentence beside its new owed item.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1a | `line_eq_scaled_circle`: u + tH = √(1+t²)(cos(arctan t)u + sin(arctan t)H), with no orthogonality needed | **CONFIRMED** |
| A-1b | δ² = ‖Alt(W₋)‖² is positively homogeneous of degree 2, so `hrel_of_homog`'s hypothesis is faithful | **CONFIRMED** |
| A-1c | `L135_at_competitor` states L135(a) with the record's c₂ and Δ₂, the same A = 1/9 and the same B on both paths | **CONFIRMED** |
| A-1d | "This file supplies that relation" (header), and the L135 row's "The instantiation is PROVED" as new work | **CONFIRMED WITH GAP** (it duplicates L135Statement's `line_eq`, [L135Inst.lean:11](../lean/HamiltonsCubic/Results/L135Inst.lean#L11), [L135Inst.lean:39](../lean/HamiltonsCubic/Results/L135Inst.lean#L39)) |
| A-1e | owed item: δ² as a function on operators, AltPart's `defectSq` being on spectral data | **CONFIRMED** |
| A-1f | L140 row: the `hdef` binder is given by `L135_at_competitor` "owing only δ² as an operator function" | **CONFIRMED WITH GAP** (the one-sided expansion `hk` is also a hypothesis, and L140.lean's binder is over ℚ, [lean/INDEX.md:507](../lean/INDEX.md#L507)) |
| A-2a | dim U = m and existence at m = 6, 7, 8 are proved in L34Statement.lean | **CONFIRMED** |
| A-2b | "the construction's θ values" are a record claim that remains untyped | **CONFIRMED** |
| A-2c | the L34 row is otherwise consistent after the edit | **CONFIRMED WITH GAP** (stale "nothing on this row is owed but the formal assembly", [lean/INDEX.md:655](../lean/INDEX.md#L655)) |
| A-3 | 47160e33 closes r1581's gaps 1 to 4 | **CONFIRMED** |
| B | build, axiom audit (3/3 and 5/5), no `sorry`/`admit`/`native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAP** (L135 main row still reads "statement: not typed", [lean/INDEX.md:485](../lean/INDEX.md#L485)) |
| D | markdown style of the three commits | **CONFIRMED** |

**Summary:** L135(a) at the competitor is correct on the standard three, r1581 is fully repaired and L34's dim U = m is proved, with four prose gaps, the main one that L135Inst re-proves L135Statement's `line_eq`.

## 1. Files and rows carrying the ids

- L135: [L135.lean](../lean/HamiltonsCubic/Results/L135.lean), [L135Statement.lean](../lean/HamiltonsCubic/Results/L135Statement.lean), [L135Inst.lean](../lean/HamiltonsCubic/Results/L135Inst.lean). Rows: [lean/INDEX.md:485](../lean/INDEX.md#L485) (main, partial) and [lean/INDEX.md:486](../lean/INDEX.md#L486) (statement, proved).
- L140: L140.lean, L140Abs.lean, L140Statement.lean. Rows [lean/INDEX.md:507](../lean/INDEX.md#L507) and [lean/INDEX.md:508](../lean/INDEX.md#L508).
- L34: L34.lean, L34b.lean to L34l.lean, L34Statement.lean. Rows [lean/INDEX.md:655](../lean/INDEX.md#L655) and [lean/INDEX.md:656](../lean/INDEX.md#L656).
- L52: L52.lean, L52Bound.lean, L52Frame.lean, L52S20.lean, L52Statement.lean. Rows [lean/INDEX.md:377](../lean/INDEX.md#L377) and [lean/INDEX.md:378](../lean/INDEX.md#L378).

## 2. L135Inst against Lemma L135(a)

- **`line_eq_scaled_circle`.** cos(arctan t) = 1/√(1+t²) and sin(arctan t) = t/√(1+t²), so the right side is u + tH identically. It is an identity in any real vector space, and the proof uses only `Real.cos_arctan` and `Real.sin_arctan`. Correct, and it needs no orthogonality.
- **Homogeneity.** The record fixes W₋ := ½(\|W\| − W). For c > 0, \|cW\| = c\|W\|, so (cW)₋ = cW₋, and Alt is linear, so δ²(cW) = c²δ²(W). The hypothesis `hD` asks this for c > 0, which is exactly what δ² has. The record's own second proof uses nothing more.
- **`L135_at_competitor`.** The record defines c₂ and Δ₂ as the one-sided second-order coefficients of δ² along cos t u + sin t H and along u + tH. Both paths pass through u with velocity H, so both expansions have constant δ²(u) and linear coefficient the one-sided derivative of δ² at u in the direction H. The theorem's `hk` and `hh` carry the same constant 1/9 and the same B, which is faithful. `line_coeff_eq` in fact derives the line's expansion from the circle's with the same A and B, so `hh` is implied by `hk` and `hrel` (redundant, harmless).
- **The value 1/9.** It enters as the expansions' constant, a limit from the right. The theorem has no hypothesis D(u) = 1/9 and needs none. The header's "δ²(u) = 1/9 at the operator [...] enter here as the hypotheses on D" ([L135Inst.lean:21](../lean/HamiltonsCubic/Results/L135Inst.lean#L21)) is accurate only in the sense that the expansions presuppose it. For continuous D the constant is forced to be D(u), so nothing is lost.
- **The duplication (gap 1).** [L135Statement.lean:91](../lean/HamiltonsCubic/Results/L135Statement.lean#L91)'s `line_eq` already proves δ2(u + tH) = (1 + t²) δ2(cos(arctan t)u + sin(arctan t)H) for every 2-homogeneous δ2 and every t. That is `hrel_of_homog`'s conclusion, and the statement row ([lean/INDEX.md:486](../lean/INDEX.md#L486)) lists `line_eq`. The only differences are cosmetic: L135Inst asks c > 0 where `line_eq` asks c ≥ 0 (the same for δ², which vanishes at 0), and a plain module where `line_eq` asks for an inner product space it never uses. So the old owed item "the two instantiated at the competitor" was already met by `line_eq` with `coeff_identity`. The header's "This file supplies that relation" ([L135Inst.lean:11](../lean/HamiltonsCubic/Results/L135Inst.lean#L11)) and the main row's "The instantiation is PROVED [...] in L135Inst.lean" should credit `line_eq`, or `hrel_of_homog` should be derived from it.
- **The owed item.** [AltPart.lean:759](../lean/HamiltonsCubic/Base/AltPart.lean#L759)'s `defectSq_smul` takes `(lam, om)`, spectral data, and scales the spectrum. The layer has no δ² on operators, so the owed item "δ² as a function on operators with its homogeneity and δ²(u) = 1/9 there" is accurate.
- **The L140 row (gap 2).** "the chain's `hdef` binder c₂ = Δ₂ − 1/9, which L135Inst's `L135_at_competitor` gives for any positively 2-homogeneous D, owing only δ² as an operator function". `L135_at_competitor` also takes `hk`, the existence of the one-sided second-order expansion of δ² along the circle with constant 1/9. The record presupposes it in defining c₂, and its own remainder paragraph notes that δ² is one-sided at u and that the expansion's structure is (c)'s, which it marks INCOMPLETE. So "only" understates what is owed. Separately, the chain assembled in [L140.lean:35](../lean/HamiltonsCubic/Results/L140.lean#L35) takes `hdef` over ℚ, while `L135_at_competitor` concludes over ℝ. The binder it matches directly is [L140Statement.lean:230](../lean/HamiltonsCubic/Results/L140Statement.lean#L230)'s `i3_target`.

## 3. 438f9217, the L34 row

- `L34` ([L34Statement.lean:228](../lean/HamiltonsCubic/Results/L34Statement.lean#L228)) proves, for m = 6, 7, 8, a W with `IsWeyl W`, `ExactlyTwoNegative W v₁ v₂ b c` and `finrank (support v₁ v₂) = m`. That is dim U = m with existence, with no `sorry`. The edit is correct.
- **θ values.** The record's block ([stratum-two-negative.md](../findings/stratum-two-negative.md), Lemma L34) records θ = −√3/2 at m = 8 and −27√14/98 at m = 6 for the construction. L34Statement types only the arithmetic from the recorded raw spectra to those values (`six_theta`, `eight_theta`), not that a constructed W has those spectra. At m = 6 the Lean witness is a different operator. A hand screen (Gram matrix of the two ω₀ forms sharing φ₄₅, inner product ½) gives its spectrum on the planes as (−2, −2, 3/2, 1/2, 1, 1), not the record's (−3, −1, 1, 1, 1, 1). This agrees with the statement row's "the alignment is load-bearing" sentence. So "the construction's θ values" remain owed, which is accurate.
- **Stale text (gap 3).** The same row still says "So nothing on this row is owed but the formal assembly [...] wants `LinearIndependent` plumbing" and "The remaining obstacle to the count is that". The statement row now proves exactly two negative eigenvalues in the form `ExactlyTwoNegative`, and the row's own new ending names a different owed item. The commit fixed one stale owed clause in this row and left these two beside it.
- Note, pre-existing and outside the three commits: [L34Statement.lean:226](../lean/HamiltonsCubic/Results/L34Statement.lean#L226) calls the m = 6 planes "the record's alignment". The record's alignment gives (−3, −1, 1, 1, 1, 1), and the statement row at [lean/INDEX.md:656](../lean/INDEX.md#L656) correctly says the Lean witness uses a different one.

## 4. 47160e33 against r1581

- **Gap 1.** `omit hw in` at [L52S20.lean:106](../lean/HamiltonsCubic/Results/L52S20.lean#L106). The signature, checked with `#check @L52_record_S20`, has no `w` or `hw` binder. The build's unused-variable warning is gone. Closed.
- **Gap 2.** The header ([L52S20.lean:19](../lean/HamiltonsCubic/Results/L52S20.lean#L19)) and the row now name `ringW_spectrum_split` and `sum_diag_split` (with `dpsi_split` beneath), which is what the proof calls. The remaining mention of `omega_lower_iff` in the row describes that separately proved passage, correctly. Closed.
- **Gap 3.** The flagged splice is now two sentences, and the owed list is no longer headed by r1579. Closed. Two older semicolon splices remain in the same row ("positive; **and the inequality needs no Karamata**" and "doubly stochastic combination of the spectrum; and that"), which r1581 also missed. They predate all three commits.
- **Gap 4.** The file column lists L52Bound.lean and L52Frame.lean. Closed.

## 5. Soundness

- `lake build HamiltonsCubic.Results.L135Inst HamiltonsCubic.Results.L52S20 HamiltonsCubic.Results.L34Statement`: completed, exit 0. L135Inst builds with no warnings. L52S20 and L34Statement carry only linter warnings.
- `axiom_audit.py --only L135Inst.lean`: 3/3 clean on the standard three. `--only L52S20.lean`: 5/5 clean.
- No `sorry`, `admit` or `native_decide` in the three files. The one match for "sorry" is L34Statement's docstring saying there is none.

## 6. Downstream

- [lean/INDEX.md:485](../lean/INDEX.md#L485): the L135 main row still ends "statement: not typed" while its statement row types and proves (a). 438f9217 repaired exactly this disagreement on the L34 row. Gap 4.
- [INDEX-results.md:151](../findings/INDEX-results.md#L151) tags L135 "Lean: proved" pointing at the statement file, while the main lean row is partial. This is pre-existing and consistent with the statement row.
- [route-a.md](../findings/route-a.md) carries no Lean claim about L135(a) that the commits contradict.

## 7. Style

- No em dash, no backtick inside link text and no new semicolon splice in any line the three commits added to a markdown file. Table rows stay single lines.

## Verdict

**CONFIRMED WITH GAPS.** The Lean is correct and faithful to Lemma L135(a), r1581 is fully repaired and L34's dim U = m is proved. Gaps:

1. [L135Inst.lean:11](../lean/HamiltonsCubic/Results/L135Inst.lean#L11), [L135Inst.lean:39](../lean/HamiltonsCubic/Results/L135Inst.lean#L39) and [lean/INDEX.md:485](../lean/INDEX.md#L485): `hrel_of_homog` re-proves [L135Statement.lean:91](../lean/HamiltonsCubic/Results/L135Statement.lean#L91)'s `line_eq`. The header's "This file supplies that relation" and the row's "The instantiation is PROVED" should credit `line_eq`, or `hrel_of_homog` should be derived from it.
2. [lean/INDEX.md:507](../lean/INDEX.md#L507): "owing only δ² as an operator function" omits that `L135_at_competitor` also takes the one-sided expansion `hk` (with constant 1/9) as a hypothesis. The chain's `hdef` in [L140.lean:35](../lean/HamiltonsCubic/Results/L140.lean#L35) is over ℚ, so the theorem matches [L140Statement.lean:230](../lean/HamiltonsCubic/Results/L140Statement.lean#L230)'s binder, not L140.lean's.
3. [lean/INDEX.md:655](../lean/INDEX.md#L655): the L34 row keeps "nothing on this row is owed but the formal assembly" and "The remaining obstacle to the count", both stale now that the statement row proves `ExactlyTwoNegative`, beside the new "Owed: the construction's θ values".
4. [lean/INDEX.md:485](../lean/INDEX.md#L485): the L135 main row reads "statement: not typed" while its statement row types (a). This is the disagreement 438f9217 fixed for L34. Note, pre-existing: [L34Statement.lean:226](../lean/HamiltonsCubic/Results/L34Statement.lean#L226) calls the m = 6 planes "the record's alignment", which the statement row correctly says they are not. Two older semicolon splices also remain in [lean/INDEX.md:377](../lean/INDEX.md#L377).
