# Review r1531: L193's frame-free σ∘σ = Pf·id (L193Sigma.lean, commit 3062d083)

*Gate 2, one reviewer, Lean layer. Subject: [L193Sigma.lean](../lean/HamiltonsCubic/Results/L193Sigma.lean) (`sigma6_skew`, `sigma6_sigma6`), the new L193 row and the L193 (statement) row of [lean/INDEX.md](../lean/INDEX.md), row 193 of [findings/INDEX-results.md](../findings/INDEX-results.md), and [plan-lean.md](../plan-lean.md), against [diagonal-half.md](../findings/diagonal-half.md) Lemma L193 and L187's σ∘σ = Pf·id. Analysis only: no numerical work, the build and the axiom audit alone were run.*

**Standfirst.** `sigma6_sigma6` is exactly L187's identity σ(σ(ω)) = Pf(ω)·ω stated frame-free on every bivector of ℝ⁶, with σ = ½⋆(ω∧ω) as the record normalises it and `pf6` the standard Pfaffian, whose base sign at `stdJ6` is the record's −1. The identity is invariant under ω ↦ −ω on both sides, so it holds under either form-to-matrix convention. The build is clean and both files audit on the standard three axioms with no `sorry`. With `adjugate_law` (Gate 2 passed, r993) and `starWedgeIdentity_holds` already in the layer, the Statement, the corollary and the L184 debt discharge all stand in Lean, so moving L193 to proved is right. Three record gaps remain: row 193 of INDEX-results still reads "Gate 2 OWED" against a block that says Gate 2 passed, the new row names no home for the debt discharge and no list of what it leaves out (the polarised form and the harmonicity identity are untyped), and the statement row keeps a sentence the layer has since falsified.

| item | claim | verdict |
| --- | --- | --- |
| A-1 | `sigma6_sigma6` is the frame-free form of L187's σ∘σ = Pf·id, with the record's σ = ½⋆(ω∧ω) | **CONFIRMED** |
| A-2 | `pf6` agrees with the record's Pf, sign included | **CONFIRMED** (standard Pfaffian polynomial by `pf6_eq`, Pf(`stdJ6`) = −1 as the record states under φ = E_ba − E_ab, and the identity is convention-invariant) |
| A-3 | the adjugate law is proved | **CONFIRMED** (`adjugate_law`, r993) |
| A-4 | "strictly stronger than L187" | **CONFIRMED AS COMMENTARY** (both conclusions are theorems, the implication is not typed as such and needs no typing, and "the converse is unavailable" is a remark about L187's model, not a mathematical claim) |
| A-5 | L193 discharges L184's debt | **CONFIRMED** (`starWedge_of_pf` with `pf6_complexStructure`, closed as `starWedgeIdentity_holds` in I67PfSign.lean) |
| A-6 | moving L193 to proved | **CONFIRMED WITH GAP** (right for the Statement, the corollary and the discharge, and the row omits the untyped polarised form and harmonicity identity) |
| A-7 | "usable matrix form" and "where a proof tying Ricci-flatness to first Bianchi would start" | **COMMENTARY** (orientation remarks, carrying no mathematical claim) |
| A-8 | the row's account of the record's five-line route | **CONFIRMED** (a fair reading of "transpose, take determinants, apply the law at σ(ω), invert, extend by density") |
| B | build, axiom audit, no `sorry` | **CONFIRMED** |
| C-1 | the new L193 row and the statement row's closing pipe | **CONFIRMED WITH GAP** |
| C-2 | row 193 of INDEX-results | **CONFIRMED WITH GAP** ("Gate 2 OWED" is stale) |
| C-3 | plan-lean.md | **CONFIRMED** |
| D | style of the new text | **CONFIRMED** (one negation-led sentence in the Lean header, noted) |

**Summary: the mathematics and the Lean are sound and L193 is rightly proved, with three record gaps in the index rows. CONFIRMED WITH GAPS.**

## A. Fidelity

**A-1.** L187 at [diagonal-half.md:683](../findings/diagonal-half.md) puts σ(ω) = ⋆(ω∧ω)/2 and states σ(σ(ω)) = Pf(ω)ω. [L193Statement.lean:65](../lean/HamiltonsCubic/Results/L193Statement.lean) defines `sigma6 X = (1/2) • star6 (wedgeSelf X)`, the same normalisation, and [L193Sigma.lean:36](../lean/HamiltonsCubic/Results/L193Sigma.lean) states `sigma6 (sigma6 X) = pf6 X • X` under `IsSkew X` alone. The hypothesis is exactly ω ∈ Λ², and `sigma6_skew` holds at every matrix, which is what licenses the second application of the entry theorems. The proof applies [I67AdjugateLaw.lean](../lean/HamiltonsCubic/Results/I67AdjugateLaw.lean)'s fifteen `sigma_i_j` at X and again at σ(X), rewrites `pf6` by `pf6_eq`, closes the fifteen upper entries by `ring`, and fills the diagonal and lower triangle from skewness of both sides. It uses no normal form.

**A-2.** [Pfaffian6.lean:77](../lean/HamiltonsCubic/Base/Pfaffian6.lean) defines `pf6 = triple6 X X X`, and [I67Pf6.lean:43](../lean/HamiltonsCubic/Results/I67Pf6.lean) proves it equal to the fifteen-term polynomial X₀₁X₂₃X₄₅ − … on skew X, the standard Pfaffian. At `stdJ6 = φ₀₁ + φ₂₃ + φ₄₅` with φ = E_ba − E_ab every block entry X₂ₖ,₂ₖ₊₁ is −1, so Pf = −1, which is the base sign the record fixes at [diagonal-half.md:875](../findings/diagonal-half.md). The identity is also robust to that convention: σ is quadratic, so σ(σ(−X)) = σ(σ(X)), and Pf(−X)(−X) = Pf(X)X since Pf has odd degree three.

**A-3 to A-5.** The Statement is `adjugate_law` ([L193Statement.lean:85](../lean/HamiltonsCubic/Results/L193Statement.lean)), Gate 2 passed at r993. The L184 discharge is typed end to end: `starWedge_of_pf` ([L193Statement.lean:167](../lean/HamiltonsCubic/Results/L193Statement.lean)) with `pf6_complexStructure`, closed as `starWedgeIdentity_holds` ([I67PfSign.lean:167](../lean/HamiltonsCubic/Results/I67PfSign.lean)). "Strictly stronger" at [diagonal-half.md:860](../findings/diagonal-half.md) has two halves. The forward half is now covered in content, since both the law and the corollary are theorems, and an implication between two theorems carries nothing further to type. The converse half ("L187 living on a pair-spectrum model with no matrix product in it") describes L187's formulation and is commentary.

**A-6, gap.** The L193 block carries two identities beyond its Statement, each stated as holding "at every" argument and each only screened: the polarised form at [diagonal-half.md:866](../findings/diagonal-half.md), α β(η,ζ) + η β(α,ζ) + ζ β(α,η) = −⟨β(α,η),ζ⟩ Id at every three 2-forms, and the harmonicity identity ζ⋆𝓑 = −2Σλᵢωᵢβ(ωᵢ,ζ) at [diagonal-half.md:868](../findings/diagonal-half.md). Neither is typed anywhere in the layer (no declaration applies `star6` to a `wedge2` of two distinct forms). Row 193 of INDEX-results says [lean/INDEX.md](../lean/INDEX.md) "says what it leaves out" ([INDEX-results.md:214](../findings/INDEX-results.md)), and the new row at [lean/INDEX.md:228](../lean/INDEX.md) names neither. "Proved" is right for the lemma as numbered, and the row owes an owed-list naming these two. The row also credits the L184 discharge to no file: it lists L193Statement.lean and L193Sigma.lean, while the closing theorem is in I67PfSign.lean.

**A-7.** "It is the relation the record carries in a usable matrix form, SelfDual.lean carrying two others" and "where a proof tying Ricci-flatness to first Bianchi would start" ([INDEX-results.md:214](../findings/INDEX-results.md)) are orientation remarks. They assert no identity and have nothing to type.

**A-8.** The record's route at [diagonal-half.md:860](../findings/diagonal-half.md) is "transpose, take determinants to get Pf∘σ = Pf², apply the law at σ(ω), invert, extend by density". The row's "runs through σ(X) = −Pf(X)X⁻¹ at invertible X and needs Pf(σ(X)) = Pf(X)² and a density step" ([lean/INDEX.md:228](../lean/INDEX.md), [L193Sigma.lean:18](../lean/HamiltonsCubic/Results/L193Sigma.lean)) reads the "invert" step out as the formula it produces, which is a paraphrase and not a misquotation. The point it makes is material: Pf(σX) = Pf(X)² goes through `pf_sq_eq_det`, which is `sorry`'d in [I67PfSquared.lean:156](../lean/HamiltonsCubic/Results/I67PfSquared.lean), so the entry route is what lets the corollary close cleanly. *An observation on the record, outside this commit: taking determinants of the law gives det σ(ω) = Pf⁴ and so Pf(σω)² = Pf⁴, and the sign choice Pf∘σ = +Pf² needs one more line (the two polynomial factors, one vanishing identically, fixed by σ(`stdJ6`) = −`stdJ6`). The five lines elide it.*

## B. Soundness

`lake build HamiltonsCubic.Results.L193Sigma` completed (8721 jobs, exit 0), with only the `maxHeartbeats` style linter note. `axiom_audit.py --only L193Sigma` prints 2/2 clean and `--only L193Statement` 7/7 clean, both on the standard three axioms. [L193Sigma.lean](../lean/HamiltonsCubic/Results/L193Sigma.lean) contains no `sorry`, `native_decide` or `axiom`.

## C. Records

**C-1, gap.** The new L193 row ([lean/INDEX.md:228](../lean/INDEX.md)) and the statement row (line 229) both end in a closing pipe. The statement row keeps "`StarWedgeIdentity` follows from pf6(J) = ±1 alone, which needs Pf(X)² = det X and det J = 1, neither typed in this layer" at [lean/INDEX.md:229](../lean/INDEX.md). The layer has since proved pf6(J) = ±1 by the equivariance route (`pf6_complexStructure`) and `StarWedgeIdentity` outright ([lean/INDEX.md:349](../lean/INDEX.md)), so the sentence is stale, and the commit touched that line without repairing it. A-6's two omissions sit in the new row.

**C-2, gap.** Row 193 of [INDEX-results.md:214](../findings/INDEX-results.md) opens "**Gate 2 OWED.**" while the block itself says "Gate 2 passed, r820 … r821" at [diagonal-half.md:856](../findings/diagonal-half.md) and the row's label is Lemma, which the file's legend defines as Gate 2 passed. The commit rewrote this row's Lean cell and left the stale status. The Lean cell ("Lean: proved", linking both files) is correct. The record's L193 text is not stale against the Lean on the corollary. One sentence at [diagonal-half.md:870](../findings/diagonal-half.md), "Pf(J) = ±1 falls out of the same normal form the adjugate law owes", is stale, since the law owes no normal form, and a later paragraph of the block corrects it.

**C-3.** [plan-lean.md](../plan-lean.md) drops L193's "no Lean row" entry and moves the counts 131 → 130 and 804 → 805 files, matching STATUS.md's 3 → 2 untouched. Consistent.

## D. Style

The new row, the INDEX-results cell and the Lean header carry no em dash, no backticks inside link text and no hard wrap, and every touched row closes with a pipe. The semicolons in the diff are pre-existing or generated (the STATUS and plan-lean count lines, the statement row's "proof: complete; GATE 2 PASSED" label) or terminate a list item in the Lean header. One note: [L193Sigma.lean:18](../lean/HamiltonsCubic/Results/L193Sigma.lean) opens "The route is the entries, not the record's five lines", a negation-led phrasing the repository's writing convention asks to state positively.
