# r1031, the native_decide retirements

**Brief**: establish that each of ~40 retirements proves THE SAME STATEMENT it replaced, and that nothing was weakened, deleted or quietly restated. A comparison against something fixed, so one reader.

**Verdict.** *The mathematics is sound, the bookkeeping is not.* No retired theorem was weakened and nothing was quietly restated. Every stated numeric value checked is right, including the one the brief most doubted. **Three defects, all in prose and tooling rather than in Lean.**

## D1, a live declaration documented as using a tactic it no longer uses

`WCP2_critical`'s docstring opened *"STILL `native_decide`, AND THE SPLIT SAYS WHY"* and spent twenty-four lines explaining why it could not be retired. **The proof term two lines below is `WCP2_critical'`, a kernel proof.** The statements are character-identical, so the retirement is legitimate; the docstring is the only thing wrong, and it is the first thing a reader meets. *The same defect was repeating in uncommitted work on `WCP2_sharp_one`.*

## D2, THE BASE TAINT IS MISATTRIBUTED, AND THE AUDIT COMMITTED ALONGSIDE IT SAYS SO

The commit and [lean/INDEX.md](../lean/INDEX.md) both claim *"27 of 32 tainted declarations in `Base` inherit from this single use"* of `WCP2_sharp_one`. **Reading the `axioms.json` added by that same commit: exactly ONE of the 27 involves it.** The other 26 trace to sixteen unrelated tactic uses, chiefly `WCP2_bianchiOf` and `W33_bianchiOf` (9 between them), `sdA_complex_structure` and `ofMatrix_WCP2_sdA` (5).

**Retiring `WCP2_sharp_one` would clear 1 of 32, not 27.**

## D3, THE AXIOM GATE SILENTLY DROPS EVERY PRIMED DECLARATION

The report regex is `'([^']+)'`, which **cannot match a name containing an apostrophe**. All 27 primed theorems in the layer are absent from `axioms.json`. The tool prints `clean/total` with `total` the count PARSED, never compared against the count ASKED, so the loss leaves no trace.

**Consequence**: `sharpQF'_id` and its three corollaries are attested by nothing, and the *"8/8 clean"* claim for Curvature cannot have come from this tool, which sees 4 of those 8. **That is the one status claim that reads as measured while being inferred.** *The tool's own header warns about precisely this failure mode in its sibling regex.*

**Fixed the same session**: the name is now matched lazily, and a guard compares asked against parsed and says so loudly when they differ.

## WHERE NOTHING WAS WRONG

- **The `alt_eq_smul_levi4` refutation is correct**, recomputed in exact rationals: the constant map `x ↦ φ₀₁` gives `altCoeff A 0 0 1 2 = 1/3` against `levi4 0 0 1 2 = 0`, and *"thirty-six of two hundred and fifty-six"* is exactly right. **No true statement was marked false.** The Hodge-star screen also holds at all 256 tuples. Nothing cites the theorem, so adding hypotheses harms no consumer.
- **All 72 of RelationBSharp's values are correct**, including `sharpMat 1 = 2·I` and `sharpMat (W+I)`'s diagonal and its six nonzero off-diagonal entries, and the assembly target `sharpBilin WCP2 1 = -WCP2`. **A wrong value is not what was costing the elaboration time.**
- **Every general-`n` theorem genuinely implies its fixed-dimension corollary**, checked for `RicOf_id_diag`, `sharpQF'_id` and `rowMass_value`. Each corollary's statement is byte-identical to the `native_decide` version replaced.
- **No statement changed anywhere else.** Every declaration signature was extracted at both ends of the range and diffed: the only change is `alt_eq_smul_levi4`'s two added hypotheses, which is disclosed.

## BLOCKING AT THE TIME OF REVIEW

The tree build was failing on an UNCOMMITTED `set_option` placed below its docstring, *"exactly the modifier-placement trap a hook was added for"*. **Until fixed, no tree build could confirm anything.** Fixed the same session.

## STYLE

`cc_expand`'s docstring still says three `native_decide` checks *"stay until that lands"*; they were retired in the same file forty minutes later.

**Cost claims** are mutually consistent and were not re-measured. Only the `8/8 clean` of D3 reads as inferred.
