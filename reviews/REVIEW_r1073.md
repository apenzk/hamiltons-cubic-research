# Review r1073: L199's last `native_decide`, retired by a general diagonal lemma

One-reader round on commit `9973e6f0`, comparing [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) against the result it claims. Log: [agent_logs/r1073-l199.log](../agent_logs/r1073-l199.log).

| Claim | Subject | Verdict |
| --- | --- | --- |
| C1 | `G_eq_sharp_diagTest_00` no longer rests on the compiler, with the audit 16/18 clean and two `sorryAx` in the statement half | **CONFIRMED** |
| C2 | `sharpMat_diagonal_00` is true at a general `d` and is the right reading of the diagonal closed form | **CONFIRMED** |
| C3 | The retirement strengthens the claim | **CONFIRMED, with the wording corrected**: the proposition is unchanged, the evidence under it is stronger |
| C4 | The arithmetic cross-check holds and the two routes share nothing | **SPLIT**: the arithmetic is CONFIRMED, "sharing nothing" is REFUTED |
| C5 | The `lean/INDEX.md` row and `plan-lean.md` report the file accurately | **PARTIALLY REFUTED**: three stale statements survive, one of them inside the layer |

## What was run

- [axiom_audit.py](../scripts/misc/axiom_audit.py) with `--only L199Statement`, re-run here rather than quoted.
- A scratch module beside the package, `#print axioms` on the six declarations at issue plus seven `#eval`s, elaborated with `lake env lean` so it carries the project toolchain, then deleted. Total `1:07` wall.

## C1: the compiler is out from under the entry. CONFIRMED

The audit reproduces exactly: `16/18 clean -- resting on the standard three alone`, with `G_eq_sharp` and `trace_Gmat_weyl` the two `sorryAx` exceptions, both in the statement half and both pre-existing. Eighteen is the file's full declaration count, so the audit covered everything in it.

The direct check agrees at every new declaration:

```
'HamiltonsCubic.Results.G_eq_sharp_diagTest_00' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.sharpMat_diagonal_00'   depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.Gmat_diagTest_00_eq'    depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.diagTest_sq'            depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.diagTest_sq_add_one'    depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.one_as_diagonal'        depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `Lean.ofReduceBool`, no `Lean.trustCompiler`, no per-use `native_decide` axiom, no `sorryAx`. The olean is newer than the source and the source matches `HEAD`, so the audit read the committed file.

## C2: the statement is the one the record means. CONFIRMED

The convention checks out three ways, and the last two are discriminating rather than merely consistent.

- **Against the closed form.** `Qop R = R * R + sharpMat R`, and [Qop_diagTest_00](../lean/HamiltonsCubic/Base/Sharp.lean) is `24` at `D = diag(1,…,6)` with `(D * D) 0 0 = 1`, so `sharpMat D 0 0 = 23`. The docstring's reading `λ₀₁² + λ₀₂λ₁₂ + λ₀₃λ₁₃` has `λ₀₁² = d 0 ^ 2` as the `R²` part, leaving `λ₀₂λ₁₂ + λ₀₃λ₁₃`. Under [pair4](../lean/HamiltonsCubic/Base/Sharp.lean) the pairs `(0,2), (1,2), (0,3), (1,3)` carry indices `1, 3, 2, 4`, so the sharp part is `d 1 * d 3 + d 2 * d 4`, which is the theorem as typed. At `D` it is `2·4 + 3·5 = 23`, matching.
- **Against an independent evaluation.** `sharpMat (diagonal ![1,2,3,4,5,6]) 0 0` evaluates to `23`, and `sharpMat (diagonal ![1,2,3,4,5,6]) 5 5` to `26`, which is `Qop_diagTest_55`'s `62` minus `6² = 36`, so the `(5,5)` convention corroborates the `(0,0)` one from the other end of the basis.
- **Against the nearest wrong reading.** The plausible mis-pairing is `d 1 * d 4 + d 2 * d 3`. At `d = ![0,1,0,1,0,0]` the typed form gives `1` and the mis-pairing gives `0`. At `d = ![0,0,1,0,1,0]` the typed form gives `1` and the mis-pairing `0`. Both evaluated: both came back `1`. The typed reading survives, the mis-pairing dies.

Vacuity does not arise: the lemma has no hypothesis beyond typing, and it is not the zero function, `23` at the `d` in play and `0` at `d = ![7,0,0,0,0,0]`, which is the correct value rather than a degenerate one.

## C3: the strengthening is of the evidence. CONFIRMED with the wording corrected

`G_eq_sharp_diagTest_00` states word for word what it stated before, so the claim itself is where it was. Two things genuinely improved: the axiom set dropped from the compiler plus the kernel to the kernel alone, and the load moved to [sharpMat_diagonal_00](../lean/HamiltonsCubic/Results/L199Statement.lean), which holds at every `d : Fin 6 → ℚ` where the tactic held at one matrix. So the accurate phrasing is that the retirement strengthens the evidence and leaves the claim fixed. As written in the commit and the index, "the retirement STRENGTHENS the claim" invites the reading that the proposition grew, and it did not.

## C4: the arithmetic holds, the independence is overstated

**The arithmetic is CONFIRMED**, recomputed from the definitions rather than from the docstring. `sharpMat (diagonal d) 0 0 = d 1 * d 3 + d 2 * d 4` gives `23` at `D`, `4·16 + 9·25 = 289` at `D²= diag(1,4,9,16,25,36)`, `1 + 1 = 2` at the identity, and `5·17 + 10·26 = 345` at `D² + 1 = diag(2,5,10,17,26,37)`. Polarisation gives `sharpBil (D²) 1 0 0 = ½(345 - 289 - 2) = 27`, so the sharp side is `4·27 - 4·23 = 16`. The commutator side is `16` by hand as well: `adMat 0` has four nonzero entries, at `(3,1), (4,2), (1,3), (2,4)`, each `±1`, and a commutator with a diagonal scales entry `(a,b)` by `d b - d a`, which is `±2` at each of those four, so the Frobenius square is `4·4 = 16`. Both were then evaluated in the layer's own definitions and both returned `16`.

**"Two routes sharing nothing" is REFUTED as stated.** [Gmat_diagTest_00_eq](../lean/HamiltonsCubic/Results/L199Statement.lean) does not route through `sharpMat`, `sharpQF` or `sharpBil`, which is the part that matters and which holds. What the two routes do share is the whole `Λ²` model underneath them: `adMat` is `coord4 (br (basis4 j) (basis4 a))` and `sharpQF` is built from `toMat4`, `coord4`, `br` and the same `basis4` and `pair4`, and both are evaluated at the same `diagTest`. A sign error in [basis4](../lean/HamiltonsCubic/Base/Sharp.lean), [pair4](../lean/HamiltonsCubic/Base/Sharp.lean) or [br](../lean/HamiltonsCubic/Base/Bivectors.lean) is therefore visible to neither route. The defensible claim is narrower: the two routes share no theorem and no declaration above the bivector model, and the expensive side no longer passes through `#`.

**Suggested replacement**, for the commit's bullet and the index row: *two routes that share only the bivector model meet at 16, the commutator side through `Gmat_diag_eq_sum_sq` and the sharp side through `sharpMat_diagonal_00`.*

## C5: the row is accurate where it is new and stale in three places

**What holds.** Every declaration the [lean/INDEX.md](../lean/INDEX.md) L199 row names exists, in this file or in [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean): the residue of the row's backticked identifiers after removing tactic names and prose is empty. `statement: typed` is right, `G_eq_sharp` being a typed proposition carrying a `sorry`, and `partial` is the right status word. The row's `16/18` matches the audit re-run here. `trace_transpose_mul` exists in Mathlib at `Mathlib/LinearAlgebra/Matrix/Trace.lean:154`, as the row asserts, and carries the other shape. The first table of [plan-lean.md](../plan-lean.md) is correctly regenerated: the L199 row is gone and only [RelationB.lean](../lean/HamiltonsCubic/Base/RelationB.lean) remains, one use.

**Defect 1, inside the layer.** [L199Statement.lean:81](../lean/HamiltonsCubic/Results/L199Statement.lean#L81), in `G_eq_sharp`'s own docstring, still reads *"Its only evidence is `G_eq_sharp_diagTest_00`, ONE entry by `native_decide`."* That is false as of this commit. The file asserts at line 289 that the last `native_decide` in it is retired and asserts at line 81 that its evidence rests on one, which is the same header-against-note contradiction inside one file that [r1044](REVIEW_r1044.md) caught here before. Repair: *"Its only evidence is `G_eq_sharp_diagTest_00`, ONE entry, now kernel-checked."*

**Defect 2, in the index row.** The same sentence stands near the top of the L199 row in [lean/INDEX.md](../lean/INDEX.md), *"Its only evidence is `G_eq_sharp_diagTest_00`, one entry by `native_decide`"*, and the row's closing paragraph says the file is free of the tactic. A reader stopping at the first sentence gets the retired state of the file.

**Defect 3, in plan-lean.md.** The file table is current and the summary line above it is not. [plan-lean.md](../plan-lean.md) reads *"`native_decide` in 1 files, tainting 3 declarations"* and *"`HamiltonsCubic.Results` carries 2, `HamiltonsCubic.Base` carries 1"*, so one file with one use is reported as tainting three declarations, two of them in the namespace this commit cleaned. The source is [lean/axioms.json](../lean/axioms.json), dated 2026-09-21 and still carrying `HamiltonsCubic.Results.G_eq_sharp_diagTest_00._native.native_decide.ax_1_1` and `HamiltonsCubic.Results.Gmat_diagTest_ne_zero._native.native_decide.ax_1_1`. The file's own header names the fix: `axiom_audit.py --json lean/axioms.json` before `lean_debts.py` when the second table is to move. So the commit bullet *"plan-lean.md regenerated"* covers the half that reads the sources and not the half that reads the audit.

**A provenance note, not a defect.** The index row was committed at 20:36 in `9f2fd504`, one minute before the Lean work landed in `9973e6f0` at 20:37, so the row asserting `16/18` preceded the commit it describes. The numbers are right, and the ordering means the record briefly promised a result the layer had not yet committed.

## Two hunts that came back clean

- **Name shadowing.** `sharpMat_diagonal_00`, `diagTest_sq`, `diagTest_sq_add_one` and `one_as_diagonal` appear nowhere else in `lean/HamiltonsCubic` and nowhere in Mathlib. `one_as_diagonal` sits near Mathlib's `Matrix.diagonal_one`, which the proof uses, and does not shadow it: it is in `HamiltonsCubic.Results` and the name differs.
- **The `set_option` trap.** All four `set_option ... in` in the file sit above their docstrings, lines 50, 224, 246 and 259. The new one at 259 is followed by a `--` reason comment and then the docstring, which keeps the docstring attached to the theorem.
