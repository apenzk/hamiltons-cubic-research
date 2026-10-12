# Review r1033: the retirement run, seven commits

Reviewer: r1033. Targets: [65053292](../lean/HamiltonsCubic/Results/I36DiagTest.lean), 3e3d14cc, 57f483f3, 9afa67ae, f53f89c2, and the bookkeeping pair 6cb960ad, c877aea0.

**The analysis-only rule was stated to me in my brief and I honoured it.** Every run I made was on objects already in hand and bounded in advance: one `lake env lean` over the twelve retired declarations (20s), a four-variant probe of lake's replay behaviour on a two-module pair with no Mathlib imports (about 2s each), three reproductions of the `W33_calA` failure (111s, 29s, 23s), a machine-checked falsity witness (6s), and pure-Python re-derivations of the counts from `git show`. I opened no sweep, no census and no unbounded hunt. The probe files are in the session scratchpad and nothing of mine remains in `lean/`.

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1 | `alt_eq_smul_levi4` proved on the standard three, hypotheses load-bearing | CONFIRMED, with one correction to the *reason* |
| 2 | the seven `native_decide` retirements, statements unchanged | CONFIRMED |
| 3 | `W4_one_one` and `diagTest_isSymm` likewise | CONFIRMED |
| 4 | `WCP2_calA` likewise, and it carried six axioms | CONFIRMED |
| 5 | the axiom audit was replaying a cached log | REFUTED as to the replay mechanism, CONFIRMED as to the regex |
| 6 | compiler debt 32 to 4, `sorry` 58 to 56 | CONFIRMED, with a caveat on what the 32 measures |
| 7 | `W33_calA`'s recorded failure and its diagnosis | CONFIRMED, and the diagnosis yields a working retirement |

## Statement diffs, the defect class I was sent to find

**No retired statement changed.** I diffed each against `git show <sha>^:<path>`. Eleven are byte-identical in their signature. The twelfth, `alt_eq_smul_levi4`, differs only by `_hneg`/`_hsym` becoming `hneg`/`hsym`: the leading underscore is Lean's convention for a binder the proof does not use, and dropping it is what happens when the proof starts using it. No binder was made implicit, no type ascription moved, nothing was weakened.

## Claim 1: `alt_eq_smul_levi4`

`#print axioms` through `lake env lean` returns exactly `[propext, Classical.choice, Quot.sound]`. Confirmed.

**The falsity witness is real and I machine-checked it.** With `A := fun _ => phi 0 1`, Lean closes `altCoeff A 0 0 1 2 = 1/3` and `levi4 0 0 1 2 = 0`, hence `¬ ∃ c, ∀ a b x y, altCoeff A a b x y = c * levi4 a b x y`. The arithmetic is what the definitions give: `comp A i j k l` is `inner2 (phi 0 1) (phi k l)`, which is `1` at `(k,l) = (0,1)` and `0` at `(1,2)` and `(2,0)`, so the cyclic third of the sum is `1/3`, and `levi4` vanishes because `sgnR 0 0 = 0`.

**The correction is to the word "because".** The commit message reads "hneg and hsym are both load-bearing: the unhypothesised form is FALSE, the constant map ...". I also proved that this same witness fails `hsym`, by `X = phi 0 1`, `Y = phi 2 3`, where `inner2 (A X) Y = 0` and `inner2 X (A Y) = 1`. So the witness refutes the form carrying **neither** hypothesis, and establishes that the pair is needed jointly. It does not show that `hneg` alone is insufficient, nor that `hsym` alone is. Both are genuinely *used* in the proof, through `altCoeff_antisym_first` and the three `altCoeff_zero_1x` lemmas, which is a weaker and accurate claim. Suggested wording: "the unhypothesised form is FALSE, so some hypothesis is needed, and the proof uses both".

**Vacuity.** The hypotheses are inhabited: the identity operator satisfies `hneg` by linearity and `hsym` by `rfl`, and so does every ℝ-linear self-adjoint operator on the skew matrices, which is the intended class. The theorem is therefore not vacuous. I did not machine-check an admissible `A` whose constant `c` is nonzero. The Hodge star `star4` is the obvious candidate and the claim that it is one is reasoning, not a check.

## Claims 2, 3 and 4: the twelve retirements

One `lake env lean` run over all of them:

| declaration | axioms after retirement |
| --- | --- |
| `alt_eq_smul_levi4`, `so_three_not_isotropic`, `sd_bracket_sq`, `sdA_complex_structure`, `WCP2_eigen_minus₁`, `WCP2_eigen_minus₂`, `W4_one_one`, `diagTest_isSymm`, `WCP2_calA` | `[propext, Classical.choice, Quot.sound]` |
| `lambda_min`, `lambda_max` | `[propext, Quot.sound]`, cleaner still |
| `W33_calA` | the standard three plus six `._native.native_decide.ax_1_1` … `ax_1_6`, as recorded |

**`WCP2_calA` did carry six.** [lean/axioms.json](../lean/axioms.json) at 6cb960ad records `ax_1_1` through `ax_1_6` against it, one per `fin_cases` branch. Confirmed.

**57f483f3's "three declarations from one retirement" is right.** `sdA_mul_neg_self` and `sdA_no_kernel` live in [L34k.lean](../lean/HamiltonsCubic/Results/L34k.lean), not in [L33c.lean](../lean/HamiltonsCubic/Results/L33c.lean), and both left the compiler bucket when `sdA_complex_structure` did.

**`diagTest_isSymm`'s diagnosis is right.** [diagTest](../lean/HamiltonsCubic/Base/Sharp.lean) is literally `Matrix.diagonal ![1, 2, 3, 4, 5, 6]`, so `Matrix.diagonal_transpose _` is the library stating the claim outright rather than a weaker cousin of it.

**Vacuity of the hypothesis-free equalities.** `lambda_min` and `lambda_max` are near-definitional: they index a literal vector. They prove nothing mathematical and never did, before or after, so the retirement neither gains nor loses content. The rest are genuine computations whose two sides are not syntactically identical: `W4 1 1 = -WCP2` runs `-(q+r)/2` at `q = r = 1`, `sd_bracket_sq` evaluates a trace to `16`, `sdA_complex_structure` multiplies two `4×4` matrices.

## Claim 5: the axiom audit and `lake build`

**The regex half is confirmed and it matters.** I reproduced the defect in Python on a realistic sample. Given

```
warning: ./HamiltonsCubic/Results/L33c.lean:12:0: declaration uses 'sorry'
info: 'HamiltonsCubic.Base.sdA_complex_structure' depends on axioms: [propext, Classical.choice, Quot.sound]
```

the old `'(.+?)'` under `DOTALL` captures `sorry'\ninfo: 'HamiltonsCubic.Base.sdA_complex_structure` as the declaration name and **consumes the real report with it**. The effect is a declaration going missing from the table, not a clean declaration being reported tainted. The anchored replacement rejects the fragment and keeps the real row.

**The replay half is refuted.** I built a two-module pair, `R1033A` proving `(10 : Nat) ^ 3 = 1000` and `R1033B` importing it and running `#print axioms`, and ran four variants on Lean 4.33.1 with this repository's lake:

| variant | result |
| --- | --- |
| change A's proof from `native_decide` to `decide`, rebuild B | B rebuilt, new answer |
| delete B's source, change A, recreate B byte-identical, rebuild | B rebuilt, new answer (this mirrors the audit's generate-and-delete cycle exactly) |
| change A's content, restore A's original mtime, rebuild B | B rebuilt, new answer |
| change A's content to the **same byte count** and restore the original mtime, rebuild B | B rebuilt, new answer |

In every case `lake build` gave the current answer. Lake hashes content, not mtime or size. **And when lake does replay, it says so**: the build line reads `Replayed HamiltonsCubic.R1033B` rather than `Built HamiltonsCubic.R1033B`, so the claim that "nothing in the output said the answer was stale" is wrong about lake's output, though the audit script never read that line.

**I could not reproduce the observation behind the diagnosis** and I record it as unreproduced rather than as disproved in that instance. One alternative that produces exactly the reported symptom, a regeneration leaving the file byte-identical: [axiom_audit.py](../scripts/misc/axiom_audit.py)'s `main()` returns `2` on `if not found` **before** it writes the `--json` file, so an audit whose build produced no parseable report leaves `lean/axioms.json` untouched at its previous content.

**Disk staleness is a separate matter and I keep it separate.** [lean/axioms.json](../lean/axioms.json) had last been regenerated at 9e045dde, which predates both 92b5df4b and 9ac6d553. Those two commits retired `mh_in_m`, `mm_in_h`, `mr_zero`, `W33_bianchiOf` and `WCP2_bianchiOf`, and eleven downstream consumers rode on the two `bianchiOf` witnesses: `W33_isWeylOf`, `WCP2_isWeylOf`, `W4_isWeylOf`, `W4_sdA`, `W4_signature`, `W4_spectrum`, `WCP2_add_W33_isWeylOf`, `L34_construction_isWeylOf`, `L34_witness_isWeylOf`, `ofMatrix_WCP2_sdA`, `pad_sdA_ne_zero`. Five plus eleven is sixteen, which is exactly the 32-to-16 drop. **The committed file was simply two commits behind**, and that accounts for the whole difference without any replay. This is a statement about the file on disk and says nothing about what a fresh `lake build` would have printed.

**One defect the fix introduced.** The new `REPORT` pattern is anchored with `^` under `MULTILINE`, which matches the bare lines `lake env lean` emits. `lake build` prefixes every report with `info: <path>:<line>:<col>: `, so those lines no longer match at all. The parser and the runner are now coupled and nothing in the file says so, and a revert to `lake build` would yield zero parses. The `if not found` guard turns that into an exit 2 rather than a silent clean bill, so the failure is loud, but the coupling deserves a line in the docstring.

**A correction to the commit message.** It attributes the 5307-to-5431 difference to "the 20 modules that were unreachable from the root until this morning". `generate()` writes an explicit `import` for every source file and has no notion of a root, and the file count moved by two, from 540 to 542. The commit's own regex diagnosis is the better explanation: roughly 124 real reports were consumed by log fragments, which is the size of the gap.

## Claim 6: the counts

**Compiler debt.** Re-derived from `lean/axioms.json` at each commit by classifying on `._native.native_decide.`:

| commit | compiler-tainted |
| --- | --- |
| 3e3d14cc^ | 32 |
| 3e3d14cc | 16 |
| 6cb960ad | 7 |
| c877aea0 | 4 |

The chain reproduces. **The caveat is on what the 32 measures**: it was read off a table of 5307 entries produced by the broken parser and two commits stale, so 32 to 16 measures the tooling fix and the missing refresh together, and only 16 to 4 is this run's retirements. The commit messages do keep those apart, though a reader of the session summary might not.

**The 4 is confirmed independently of the audit.** `native_decide` appears in exactly three files, [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) twice, [RelationB.lean](../lean/HamiltonsCubic/Base/RelationB.lean) once and [L33b.lean](../lean/HamiltonsCubic/Results/L33b.lean) once, attached to `G_eq_sharp_diagTest_00`, `Gmat_diagTest_ne_zero`, `WCP2_sharp_one` and `W33_calA`. That is the audit's list exactly.

**`sorry`, 58 to 56, confirmed.** Counted by my own comment-stripping and backtick-stripping scanner over `git show` of every source at each commit: 58 at f0fa7f4f, which is where this session's work begins, 57 at 9ac6d553 where `lam_mul_F_gt` closed, 56 at 65053292 where `alt_eq_smul_levi4` closed, 56 at HEAD. An earlier note of mine filed 57 to 56 against the wrong baseline and is withdrawn. Commit 65053292's own "57 to 56" is right for that commit.

**Coverage caveat, and 4 is a lower bound only in a narrow sense.** 43 declarations present in the sources are absent from `lean/axioms.json` at HEAD. Every one is either a `private theorem`, whose mangled name `#print axioms` cannot reach from outside its file, or a docstring line that begins with the word `theorem` followed by a word, which `declarations()` reads as a declaration because it does not track comment depth. A private theorem's taint still surfaces through whichever public theorem uses it, so the compiler count is not undercounted in practice. **What is damaged is the guard**: the `AUDIT INCOMPLETE` banner, written to make the apostrophe bug visible, now fires on every full run because of the prose false positives, so it no longer distinguishes a real loss from the standing noise. The clean fix is to skip comment blocks in `declarations()` as [lean_debts.py](../scripts/misc/lean_debts.py)'s `sorry_sites()` already does, and to exclude `private` from the generated `#print axioms` list.

## Claim 7: `W33_calA`'s recorded failure

**The measurement is real, not a guess.** I ran the shared `WCP2_calA` script against `W33` with the diagonal lemmas supplied, twice:

| configuration | outcome | wall time |
| --- | --- | --- |
| as the committed file is configured, `maxRecDepth 100000` and `maxHeartbeats 4000000`, `simp`'s `maxSteps` at its default | `simp failed: maximum number of steps exceeded` | 111s |
| the same with `simp (maxSteps := 4000000)` | `simp failed with a nested error: maximum recursion depth has been reached` | 29s |

So the recorded sentence is right under the reading "with `maxSteps` raised to four million it reaches `maxRecDepth`, which is at 100000". **The wording invites the wrong reading**, because in the committed file `4000000` is `maxHeartbeats` and `maxSteps` is never set at all. As the file stands, someone who deletes the `native_decide` and runs the shared script gets the `maxSteps` wall at 111s, not the recursion wall at 41s. Worth one clarifying clause.

**The diagnosis is right, and I tested it rather than reasoning about it.** I defined `W33lit` as the same matrix written `!![2,0,…;…;0,…,2]`, proved `W33lit = W33` by `ext` and `fin_cases`, and ran the **unmodified** shared script on it. It closes, whole file in 23s, no raised `maxSteps`. The form is the cause, exactly as the file says.

**And that hands the fourth compiler debt a retirement now.** This elaborates clean, on `[propext, Classical.choice, Quot.sound]`:

```lean
def W33lit : Matrix (Fin 6) (Fin 6) ℚ :=
  !![ 2,  0,  0,  0,  0,  0;
      0, -1,  0,  0,  0,  0;
      0,  0, -1,  0,  0,  0;
      0,  0,  0, -1,  0,  0;
      0,  0,  0,  0, -1,  0;
      0,  0,  0,  0,  0,  2]

theorem W33lit_eq : W33lit = W33 := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [W33lit, W33, Fin.ext_iff]

set_option maxHeartbeats 4000000 in
set_option maxRecDepth 100000 in
theorem W33lit_calA (a : Fin 6) :
    calA W33lit (basis4 a) = (2 : ℚ) • ofMatrix W33lit (basis4 a) := by
  ext i j
  fin_cases a <;>
    simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;>
    simp [calA, ofMatrix, W33lit, basis4, br, phi, toMat4, coord4, pair4,
      Matrix.mulVec, dotProduct, Fin.sum_univ_six, Fin.sum_univ_four,
      Matrix.mul_apply, Matrix.single_apply, Matrix.sub_apply, Matrix.add_apply,
      Matrix.smul_apply, Matrix.sum_apply, Matrix.of_apply, Fin.ext_iff] <;>
    fin_cases i <;> fin_cases j <;> norm_num

theorem W33_calA (a : Fin 6) :
    calA W33 (basis4 a) = (2 : ℚ) • ofMatrix W33 (basis4 a) := by
  rw [← W33lit_eq]; exact W33lit_calA a
```

The cost is 23s for the module against the current 21s, and it is cheaper than the `rfl`-ground-facts shape the file names for the next attempt. The one thing to weigh is that `W33lit` is a second name for a matrix the layer already has, so it belongs beside `W33` in [L33.lean](../lean/HamiltonsCubic/Results/L33.lean) with a docstring saying why a second form exists.

## What I did not check

- Whether an admissible `A` for `alt_eq_smul_levi4` gives a nonzero constant. The identity gives `c = 0`, which is enough for non-vacuity and not enough to show the conclusion has bite.
- `tree build clean across 9249 targets`, reported in 6cb960ad and c877aea0. A full `lake build` is the open-ended run the analysis-only rule reserves, so I did not start one.
- Whether the audit's full run reproduces 5431 today. I ran it only under `--only L199`, where it asked about 7 and parsed 7 and classified `diagTest_isSymm` clean.
