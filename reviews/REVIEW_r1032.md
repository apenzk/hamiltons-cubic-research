# Reviewer r1032: the twelve symmetry lemmas, index positions against names

**Verdict: CONFIRMED on the mathematics, three defects in the bookkeeping.**

Audited: [AltAntisym.lean](../lean/HamiltonsCubic/Base/AltAntisym.lean) and [BianchiSym.lean](../lean/HamiltonsCubic/Base/BianchiSym.lean), commits `80558301`, `ff5fd403` and `f0fa7f4f`. The brief asked five questions: whether the index positions match the lemma names, whether the first-pair asymmetry is structural, whether the dependency chains are acyclic, whether the ℚ/ℝ duplication claim holds, and whether the nine-declaration count is right.

Analysis-only rule stated in the brief and honoured: the one numerical act is a seconds-long screen over 256 tuples, reported below as a screen.

## What is clean

| question | verdict | how it was established |
|---|---|---|
| index positions match names, all twelve | CONFIRMED | `#check` on every lemma against the compiled oleans, not source reading. `_12 → i i k l`, `_13 → i j i l`, `_14 → i j k i`, `_23 → i j j l`, `_24 → i j k j`, `_34 → i j k k`, on both sides |
| every `linarith` hint instantiates to the equation the goal needs | CONFIRMED | binder substitution, one at a time. No hint vacuous or off by one |
| dependency order acyclic and strictly backward | CONFIRMED | ℝ: `cyclic → antisym_last`; `zero_23 ← mid`, `zero_34 ← cyclic+23`, `zero_24 ← cyclic+34`, `zero_12 ← first`, `zero_13 ← mid+12`, `zero_14 ← cyclic+13`. ℚ mirrors it |
| no gap axioms | CONFIRMED | `#print axioms` on the deepest lemma of each chain returns `[propext, Classical.choice, Quot.sound]` |
| the ℚ/ℝ duplication claim | CONFIRMED | no ℚ `inner2_comm`, `inner2_neg_left` or `inner2_neg_right` existed under any name. The three inline proofs are not waste |
| hypotheses satisfiable, so nothing vacuous | CONFIRMED | `fun X => X` meets both. On the record, `hsym` for `ofMatrix WCP2` is the first clause of `WCP2_isWeylOf`, and `hneg` is `ofMatrix_neg` |

## The first-pair asymmetry is structural, and both hypotheses are load-bearing

From the definition, `bianchiOf R i j k l = ⟨Rφ_ij,φ_kl⟩ + ⟨Rφ_ik,φ_lj⟩ + ⟨Rφ_il,φ_jk⟩`. **The first index sits inside `R`'s argument in all three summands**, so a first-pair swap must move `R` across the pairing, while the last three only permute symbols. Screened over all 256 tuples on `Fin 4`:

| operator | `hneg` | `hsym` | first-swap violations | last-swap | cyclic |
|---|---|---|---|---|---|
| `X ↦ ⟨φ₀₁,X⟩ φ₂₃` | holds | fails | 16 | 0 | 0 |
| `X ↦ X + φ₀₁` | fails | holds | 80 | 0 | 0 |
| `X ↦ X` | holds | holds | 0 | 0 | 0 |

Cyclic invariance and the last-pair swap hold for arbitrary maps, including non-linear ones. **Neither hypothesis can be dropped.**

## Defect 1: both new modules were orphaned from the library root

Neither file was imported by [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), and no other module imported them. The transitive closure from the root reaches 520 of 542 modules; these two were among the 22 outside it, with [RelationBSharp.lean](../lean/HamiltonsCubic/Base/RelationBSharp.lean), which the same run rewrote.

**What that cost**: the default `lake build` target skipped them, [axiom_audit.py](../scripts/misc/axiom_audit.py) would never record them, and they appeared in neither [lean/INDEX.md](../lean/INDEX.md) nor [plan-lean.md](../plan-lean.md). Their oleans existed only because they had been built by name.

**Applied**: three import lines added to the root.

## Defect 2: the nine-declaration count

- `WCP2_bianchiOf` has 6 dependents and `W33_bianchiOf` has 3, with `WCP2_add_W33_isWeylOf` in both, so **the distinct union is 8**. The nine was r1031's `6+3`, which double-counts.
- `alt_eq_smul_levi4` is tainted by `sorryAx` rather than the compiler, sits in `Results` rather than the layer, and carries exactly itself. Adding it as a third contributor mixes two taint kinds and two layers.
- **Thirty-two is the repository-wide `native_decide` count. The Base layer's is 27.** Both r1031 and [lean/INDEX.md](../lean/INDEX.md) phrase it as "of 32 in `Base`", so the file inherited an existing error rather than inventing one.
- The comparison against `WCP2_sharp_one`'s one dependent checks out exactly.
- Every count above is a lower bound while the audit parser drops primed names.

**Applied**: the docstring now states 8, separates `alt_eq_smul_levi4` by taint kind and layer, and distinguishes 27 from 32.

## Defect 3: "half of the 256 tuples"

Commit `f0fa7f4f` says the six coincidence lemmas cover "the half of the 256 tuples that the case split choked on. The other half are permutations of one tuple". **On `Fin 4` the split is 232 with a repeat against 24 all-distinct**, not half and half.

## Style notes, no action owed

- [BianchiSym.lean](../lean/HamiltonsCubic/Base/BianchiSym.lean) says the last three indices need "`phi_swap` and `ring` alone"; `bianchiOf_antisym_last` also uses `inner2_neg_right_q`. A pairing fact rather than an operator fact, so the asymmetry survives.
- [AltAntisym.lean](../lean/HamiltonsCubic/Base/AltAntisym.lean) said each of the six patterns is "one `linarith` from two instances"; `altCoeff_zero_23` and `altCoeff_zero_12` take one instance each. Corrected to "one or two".
- `altCoeff_antisym_last` is exported and unused inside its own file, `zero_34` being derived through the cycle. It is a generator for later consumers, not dead code.
- The 5.5 GB `fin_cases` failure is corroborated independently by the pre-existing docstring at [I36DiagTest.lean](../lean/HamiltonsCubic/Results/I36DiagTest.lean).

Log: [agent_logs/r-symmetry.log](../agent_logs/r-symmetry.log).
