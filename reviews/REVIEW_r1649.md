# REVIEW r1649: L127DnMult.lean (lamW_smul, dn_eigen_parts) and r1648's repairs, commit b52562ce

**Verdict: CONFIRMED WITH GAPS.** `dn_eigen_parts` is correct, its proof is sound and the audit is clean. The multiplicity argument it feeds is correct by hand at `t ≠ 0`, but the eigenspace equality and its dimension are prose, the header's multiplicity list fails at `t = 0`, and two sibling headers now credit L127DnMult with "the eigenspaces" that it does not declare.

Reviewer: cold adversarial Gate 2, analysis only. Log: [agent_logs/review-l127dnmult.log](../agent_logs/review-l127dnmult.log). Screen run: `python3 scripts/misc/axiom_audit.py --only L127DnMult.lean`, a screen of the axioms only.

Source: [findings/second-order.md](../findings/second-order.md):1728, "#### Lemma L127", the `D_n` row, `σ(L_e|D_n) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^rest}`, stated at the sphere product critical point in `L_e` units (so `θ ≠ 0`).

## Claims

| # | Claim | Verdict | Notes |
| --- | --- | --- | --- |
| 1a | The six eigen-relations E1–E6 are correctly obtained | CONFIRMED | Each is `mem_eigenspace_KL` fed by `K_of_fox` on the family's own `foxProd` relation (`sphere_line`, `sphere_lam`, `sphere_lam_compl` after rewriting `dnK Tᶜ`, `sphere_crossW`, `sphere_zero`, `sphere_zero_compl`), exactly the six pieces `dn_excl` already uses (L127DnExcl.lean:90-100) with the same values `v1`–`v4`, `0`, `0`. Symmetry and hollowness are discharged per family. |
| 1b | The scaled tuple is a legal `dn_direct` input | CONFIRMED | `c ↦ (v1 − ν)c` is a free scalar. `lamW_smul` moves the scalar into `h`, and `hh2`, `hh3` keep the sums zero. `IsCrossW` and `IsWithinW` are carried by `crossSub.smul_mem` and `withinSub.smul_mem`, whose carriers are those predicates (L127DnDim.lean:38, :243). Each conclusion `(v_i − ν) P_i = 0` with `v_i ≠ ν` gives `P_i = 0` by `smul_eq_zero`. |
| 1c | `dn_eigen_parts` as a whole | CONFIRMED | Hypothesis `he` supplies the decomposition, so no weight hypothesis is needed. At `t = 0` every value is `0` and each implication is vacuous or correct, so the statement has no bad corner. |
| 2a | "The ν-eigenspace on `D_n` is the direct sum of the families carrying ν, its dimension the sum of theirs" | CONFIRMED WITH GAPS | By hand: `⊇` from E1–E6 and the families lying in `D_n` (L127DnSpan), `⊆` from `dn_decomp` plus `dn_eigen_parts`, directness from `dn_direct`, so `dim = Σ` over carrying families. Correct. Neither the submodule equality nor the finrank is declared, and the file's **Not yet declared** names only the finrank (G2). |
| 2b | The multiplicity list `1, p−1, q−1, (p−1)(q−1), p(p−3)/2 + q(q−3)/2` with "the two adding at p = q" | CONFIRMED WITH GAPS | At `t ≠ 0` (so `θ = t(p+q−1) ≠ 0`) the five values are distinct except `λ_p = λ_q` iff `p = q`, since `λ_p = (p−2)/(2(p−1)) ∈ (0, ½)` increases strictly in `p` and `−μ < 0`. At `t = 0` all values are `0` and the `0`-eigenspace is all of `D_n`, so the printed list is false there (G1). |
| 2c | Commit title and INDEX "the multiplicities are the record's" | CONFIRMED WITH GAPS | Honest as a derivation sketched in prose with the finrank owed, and the INDEX row's **Owed** says so. The title reads as a declared result and carries no `t ≠ 0` (G1, G2). |
| 3a | r1648 G1 (L127DnUnits header) | CONFIRMED WITH GAPS | The stale "not yet declared" count is gone and L127DnCount is cited. The new text says the four files "give ... the eigenspaces", which L127DnMult does not declare (G3). |
| 3b | r1648 G2 (L127DnSpan header) | CONFIRMED WITH GAPS | Now cites L127DnDim and keeps only the `p = 2`, `q = 2` spanning as owed. Same "the eigenspaces" overstatement (G3). |
| 3c | r1648 G3 (L127DnCount "exhaust") | CONFIRMED | Title and docstring now read "sum to `dim D_n`". |
| 3d | Headers mutually consistent | CONFIRMED WITH GAPS | L127DnExcl.lean:20, L127DnDirect.lean:18 and L127DnDim.lean:27-28 still owe "the multiplicities" with no pointer to L127DnMult, while L127DnMult's header states them as the record's and L127DnSpan/L127DnUnits credit it with the eigenspaces. L127Dn.lean:25 still says spanning is undeclared, stale since `dn_decomp` (G3, G4). |
| 4 | Axiom audit | CONFIRMED | 2/2 clean, resting on the standard three alone, as the commit body and INDEX say. |
| 5 | Provenance: import (0f710381) and INDEX row text (b5dbd7b0) | CONFIRMED | lean/HamiltonsCubic.lean:169 imports L127DnMult, landed in 0f710381. The INDEX passage "And each eigenspace is the sum" (lean/INDEX.md:495) landed in b5dbd7b0 and matches the file's declarations and owed line. It inherits G1. |

## What would break each claim, and where I looked

- **Claim 1**: an E_i proved at a value other than the one in the conclusion, or a scaled member leaving its family (for instance `lamW` with a `h` whose sum is no longer zero). I compared `v1`–`v4` against `dn_excl`'s set term by term and traced every `dn_direct` argument to its predicate.
- **Claim 2**: a coincidence of family values beyond `p = q`, which would merge multiplicities. I checked `1`, `λ_p`, `λ_q`, `−μ`, `0` pairwise over `p, q ≥ 3` and found the only other collapse at `t = 0`. A second break would be a family outside `D_n`, excluded by L127DnSpan.
- **Claim 3**: any header still calling the count undeclared, or crediting a file with a declaration it lacks. I grepped every L127Dn*.lean header for "Not yet", "multiplicit" and "exhaust".

## Gaps

- **G1 (prose, minor), [L127DnMult.lean:18-20](../lean/HamiltonsCubic/Results/L127DnMult.lean) and [lean/INDEX.md:495](../lean/INDEX.md).** The multiplicity list holds at `t ≠ 0` only. At `t = 0` every family carries `0`. Add "at `t ≠ 0`" (equivalently `θ ≠ 0`, the record's setting).
- **G2 (scope, minor), [L127DnMult.lean:22](../lean/HamiltonsCubic/Results/L127DnMult.lean) and the commit title.** The eigenspace equality `(KL w).eigenspace ν ⊓ D_n = ⨆_{v_i = ν} F_i` is undeclared as well as its finrank. **Not yet declared** should name both.
- **G3 (prose, minor, downstream), [L127DnSpan.lean:30-31](../lean/HamiltonsCubic/Results/L127DnSpan.lean) and [L127DnUnits.lean:23-25](../lean/HamiltonsCubic/Results/L127DnUnits.lean).** "give ... the eigenspaces" overstates `dn_eigen_parts`. Meanwhile [L127DnExcl.lean:20](../lean/HamiltonsCubic/Results/L127DnExcl.lean), [L127DnDirect.lean:18](../lean/HamiltonsCubic/Results/L127DnDirect.lean) and [L127DnDim.lean:27-28](../lean/HamiltonsCubic/Results/L127DnDim.lean) owe the multiplicities with no pointer to L127DnMult. One wording across all five is needed.
- **G4 (prose, minor, pre-existing), [L127Dn.lean:25](../lean/HamiltonsCubic/Results/L127Dn.lean).** "*Not yet declared*: that these families span `D_n`" is stale since L127DnSpan's `dn_decomp`.
