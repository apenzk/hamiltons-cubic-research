# Review r1046: L199's first moment, `G_eq_sharp`'s cost, L171's two gaps

Reviewer r1046, sole reviewer. Scope: [da95ac2b](../lean/HamiltonsCubic/Results/L199Statement.lean), [3c48649b](../lean/HamiltonsCubic/Results/L199Statement.lean) and [3fd1914c](../lean/HamiltonsCubic/Results/L171Statement.lean), on [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean), [L171Statement.lean](../lean/HamiltonsCubic/Results/L171Statement.lean) and [lean/INDEX.md](../lean/INDEX.md).

Log: [agent_logs/r-l199-l171.log](../agent_logs/r-l199-l171.log).

| # | claim | verdict |
|---|---|---|
| 1 | `trace_Gmat_weyl` is correctly stated, `IsWeyl` is the right hypothesis, and it is the record's first moment at `n = 4` | **CONFIRMED** |
| 2 | the screen behind it is sound: the quoted witness is Weyl and `tr(Gmat W) = 3456 = 12 tr(WᵀW)` | **CONFIRMED**, every clause reproduced |
| 3 | the closed form and its two corollaries | **CONFIRMED, and now DERIVED rather than fitted**, with one normalisation the docstring leaves unsaid |
| 4 | `Msys_quadForm_eq_at_ones` establishes sharpness of `λ_min(Msys) = 3/5` | **CONFIRMED**, with the reading separated from the declaration |
| 5 | the `G_eq_sharp` cost measurement is honest | **REFUTED**, on the inference and on the fact, and measured here to be backwards |
| 6 | `plane_objective_le` and `plane_objective_attained` give the maximum | **CONFIRMED as mathematics, REFUTED as new**: the file already proved it, fifty lines below |
| 7 | the `sorry` is two gaps and what remains is the decomposition plus the Rayleigh bound | **REFUTED**: the split is right in direction, the enumeration is short by two items, and the file now carries two contradicting accounts of its own gap |

## Claim 3, the closed form, derived

**The formula is a polynomial identity and I have derived it, so it no longer rests on forty random matrices.** Rebuilding `adMat` and `Gmat` from the Lean definitions ([Sharp.lean:41](../lean/HamiltonsCubic/Base/Sharp.lean) for `basis4`, `pair4`, `coord4`, [Bivectors.lean:46](../lean/HamiltonsCubic/Base/Bivectors.lean) for `phi` and `br`) and expanding `tr(Gmat R)` over a symmetric `R` with all twenty-one entries free gives, exactly:

```
tr(Gmat R) = 12‖R‖² - 2(tr R)² - 8(R₀₅ - R₁₄ + R₂₃)² - 8‖B‖²
```

with `‖R‖² = tr(RᵀR)`. Three further identities came out of the same expansion and are worth recording, because they are what make the two corollaries readable.

**In blocks, the formula has no basis-dependent term at all.** Writing `R` as `[[A, B], [Bᵀ, C]]` against the orthonormal self-dual splitting, `tr R = tr A + tr C` and `R₀₅ - R₁₄ + R₂₃ = (tr A - tr C)/2`, and the identity becomes

```
tr(Gmat R) = 12‖A‖² + 12‖C‖² + 16‖B‖² - 4(tr A)² - 4(tr C)²
```

**The deficit is then manifestly a sum of squares**, which is the whole of the first corollary:

```
12 tr(RᵀR) - tr(Gmat R) = 8‖B‖² + 4(tr A)² + 4(tr C)²  ≥ 0
```

at every symmetric `R`, with no hypothesis. **CONFIRMED.**

**And `IsWeyl` really is the equality locus, not merely a sufficient condition.** Equality forces `B = 0`, `tr A = 0` and `tr C = 0`, which is `B = 0`, `tr R = 0` and `IsBianchi R`. The remaining step is that `IsRicciFlat` is exactly `B = 0` together with `tr R = 0`, and that is a fact about [Sharp.lean:109](../lean/HamiltonsCubic/Base/Sharp.lean)'s `Ric` rather than about the name: evaluated symbolically, the sixteen entries of `Ric R` are symmetric in `(a,b)` with no Bianchi assumed, they span a ten-dimensional space of linear conditions on `R`, and that span **equals** the span of the nine entries of `B` together with `tr R`. Adding `IsBianchi` takes the joint rank to eleven on both sides. So `IsWeyl` is the equality locus exactly. **CONFIRMED.**

### The correction this claim needs: `‖B‖` is normalisation-bound

**`‖B‖` must be read in the ORTHONORMAL adapted basis** `uᵢ = (e_p ± e_q)/√2`, and the docstring's *"a basis adapted to `Λ²₊ ⊕ Λ²₋`"* does not say so. Taken in the unnormalised `e_p ± e_q` the mixed block is `2B`, so the recorded `-8‖B‖²` would have to read `-2‖B‖²`. In a layer whose own `Λ²` inner product carries a `½` ([Bivectors.lean:39](../lean/HamiltonsCubic/Base/Bivectors.lean)), an unstated normalisation in a recorded formula is the failure mode the record has already paid for twice.

### And the two questions the brief asked about it

**`‖B‖` is well defined without fixing an orientation.** Reversing the orientation of `ℝ⁴` swaps `Λ²₊` with `Λ²₋`, which sends `B` to `Bᵀ` and `R₀₅ - R₁₄ + R₂₃` to its negative. Both enter squared, so the formula is invariant under the swap. It is likewise invariant under `SO(4)`, which acts by separate rotations of the two factors and leaves `‖B‖`, `‖A‖`, `‖C‖`, `tr A` and `tr C` alone.

**The three counterexample rows are reproduced, and that is a consistency check rather than evidence.** The formula returns `8`, `12` and `68` against `12`, `24` and `168`, and the deficits `4`, `12` and `100` match `8‖B‖² + 4(tr A)² + 4(tr C)²` term by term. But a formula fitted on forty points in a twenty-one-dimensional space with four invariant coefficients is over-determined several times over, so three more points it happens to fit carry no information the fit did not already have. It is not an arithmetic tautology, the three rows being degenerate diagonals outside the random sample, but it is close enough to one that it should not be cited as confirmation. **The derivation above is what closes this, and the record should cite that rather than the count of random matrices.**

## Claim 5, the cost measurement, refuted three ways

**First, both runs were killed at caps, so neither number is a runtime.** `7m53s` and `3m57s` are censoring times. They bound the cost below and say nothing whatever about its shape. *"Cutting the work to a third cut the time to about a half"* is a statement about the two caps the operator chose before the runs started, not about two measurements, and it would read the same way if the true costs were twenty minutes and nineteen minutes.

**Second, even read generously as completions the data contradicts the conclusion.** Two points determine the two-parameter model `c + k·m` exactly: `c + 3k = 473s` and `c + k = 237s` give a marginal cost `k = 118s` per matrix and a fixed cost `c = 119s`. A fixed overhead and a marginal cost of the same size is precisely the alternative the conclusion was meant to exclude, so the arithmetic the sentence rests on refutes the sentence.

**Third, I measured it, and the split runs the other way.** A file importing only [Base/Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean), defining `sharpBil` and carrying one `#eval` that times itself from inside:

| quantity | measured |
|---|---|
| whole `lake env lean` run | `4m46s` wall, `273s` user |
| same import with a trivial `#eval` (baseline) | `25.8s` wall |
| evaluating the FIRST entry of `sharpBil (diagTest²) 1` | `15.8s` |
| evaluating the next five entries | `2ms` total |

So on this machine the cost is dominated by ELABORATING AND COMPILING the file, the first evaluated entry costs about sixteen seconds, and every entry after it is sub-millisecond. **The recorded conclusion is backwards.** It also explains the data that produced it: two `#eval` runs killed at four and eight minutes were almost certainly killed while the file was still compiling, before any entry was evaluated, which is exactly why the amount of work inside them made so little difference to the time.

**The consequence for the record is larger than the sentence.** *"An `#eval` screen of this identity is not reachable at all"* is unsupported and looks false. A whole-matrix check is thirty-six entries at sub-millisecond marginal cost once the file compiles, and what needs pricing is the compile, not the arithmetic. The route the file already proposes, evaluating `sharpMat` once per argument, is good advice for a different reason than the one given.

**One housekeeping note.** Nothing in [agent_logs/](../agent_logs/) records the two `#eval` runs, so the only artefact of the measurement is the commit message's own numbers. A measurement offered as the reason to close a route should leave a log.

## Claim 6, the one-variable step, true and not new

**Both theorems are correct, their hypotheses are right, and they compose.** `plane_objective_attained` returns `al ≤ 1 ∧ -1 ≤ al ∧ …`, whose first conjunct is exactly `plane_objective_le`'s hypothesis, so the pair gives the MAXIMUM of `a·α + tλ(1-α²)` over `α ∈ [-1,1]` and not merely a bound. Both are on the standard three axioms.

**The hypotheses the brief asked about, one at a time.**

- **`al ≤ 1` is load-bearing in `plane_objective_le`**, not decoration. Dropping it makes the first branch false: at `a = 1`, `lam = 1`, `t = 1/10` the branch condition holds and `V = 1`, while `α = 5` gives `5 - 12/5 = 13/5 > 1`.
- **`-1 ≤ al` is correctly ABSENT from `plane_objective_le`.** Below `-1` the objective is at most `-a`, so the bound survives, and the extra generality costs nothing. It is present in `plane_objective_attained`'s CONCLUSION, where it is needed downstream, since the geometric witness sets `‖v‖² = 1 - α²` and so needs `α² ≤ 1`.
- **`t = 0` is neither vacuous nor trivial.** `V a lam 0 = a`, and the bound reads `a·α ≤ a`, which is the content *"at `t = 0` the maximum is `a`"* and not an identity.

**But the file already proved this, and the commit does not say so.** [scalar_max](../lean/HamiltonsCubic/Results/L171Statement.lean) sits fifty lines below the new pair, PREDATES the commit, and states `IsGreatest (f a lam t '' Set.Icc (-1) 1) (V a lam t)` with `f a lam t c = a * c + t * lam * (1 - c ^ 2)`. That is the same objective, the same closed form and both halves.

- `plane_objective_attained` is `scalar_max.1` with `f` unfolded and the `Set.Icc` membership unpacked.
- `plane_objective_le` is `scalar_max.2` with the unneeded lower bound dropped. **Checked in Lean**: the term `(scalar_max ha hlam ht).2 ⟨al, ⟨h1, hal⟩, rfl⟩` closes `plane_objective_le`'s statement in one line, and it elaborated.

So *"That half is proved here"*, the index's *"the one-variable half of it is now PROVED"*, and the docstring's *"so the closed form is the maximum rather than merely an upper bound"* all present as new what the file's own **What is typed here** list already recorded: *"`scalar_max` … **proved**: this is the whole content of the two branches once the maximiser is known to lie in the plane"*. **The mathematics is CONFIRMED and the novelty is REFUTED.** The honest version of the commit is that the `sorry`'s description was wrong, which is a real finding, and that no new mathematics was needed to see it.

## Claim 7, what the `sorry` still owes

**The direction is right: the gap the file called one thing is more than one thing. The enumeration is what fails.** Written out, the remaining proof of [L171](../lean/HamiltonsCubic/Results/L171Statement.lean) has these parts.

| part | what it needs | in the new account? |
|---|---|---|
| decomposition `K = (α/a)q + v`, `v ⟂ q`, `α² + ‖v‖² = 1` | inner-product algebra and `M q = 0` | yes |
| the cross term dies, `⟪MK,K⟫ = ⟪Mv,v⟫` | `M q = 0` **and `M.IsSymmetric`** | symmetry unstated |
| `⟪Mv,v⟫ ≤ λ‖v‖²` | scaling the Rayleigh bound off the unit sphere, and `0 ≤ t` | yes |
| the `≤` half closes | `plane_objective_le` | yes |
| the `∈` half: a unit `K` with objective exactly `V` | on the second branch, a unit `v ∈ q^⊥` with `⟪Mv,v⟫ = λ`, that is **ATTAINMENT of `λ` on `q^⊥`** | **no** |

**The omission is the one that matters, because `IsGreatest` has two halves and the Rayleigh bound delivers only one.** `⟪Mv,v⟫ ≤ λ‖v‖²` is an inequality. It can never produce the member of the set, and above the branch point the maximiser needs `‖v‖² = 1 - α² > 0` at the top Rayleigh quotient. So the theorem is NOT provable from what the file now says is left.

**The missing step is short, and naming it costs the account nothing.** From `_hlam : IsGreatest …` take a unit `K₀` with `⟪MK₀,K₀⟫ = λ` and split it as `K₀ = β q̂ + w` with `w ⟂ q`. Then `λ = ⟪Mw,w⟫ ≤ λ‖w‖² ≤ λ`, and `0 < lam` forces `‖w‖ = 1`, so `K₀` was in `q^⊥` all along. **This is where `_hlampos` earns its place**, and the new account, which uses `λ > 0` nowhere, gives no sign of it.

**And the file now contradicts itself about its own `sorry`.** The new section says the gap is the decomposition and the Rayleigh bound. The untouched **What the `sorry` is** section, forty lines above, still says the maximiser must be taken *"with `v` a top eigenvector of `M|_{q^⊥}`, which needs the spectral theorem for a symmetric operator on a finite-dimensional real inner product space"*. **Neither is right.** The new one omits attainment. The old one overstates it: `_hlam` is handed in as an `IsGreatest`, so attainment on `E` is a HYPOTHESIS, the argument above carries it to `q^⊥` without a spectrum, and the `[FiniteDimensional ℝ E]` instance is then idle as well.

*This is the same defect [da95ac2b](../lean/HamiltonsCubic/Results/L199Statement.lean) was written to celebrate catching in [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), a header and a note contradicting each other inside one file, reintroduced in [L171Statement.lean](../lean/HamiltonsCubic/Results/L171Statement.lean) by the next commit.* The **What is typed here** list was also left un-updated and names neither new declaration.

## Claims 1, 2 and 4, confirmed

**Claim 1.** `IsWeyl` at [Sharp.lean:115](../lean/HamiltonsCubic/Base/Sharp.lean) does encode the Weyl conditions and `IsRicciFlat` is not weaker: `Ric` is built through `Λ²` as a genuine contraction, and its vanishing is exactly `B = 0` with `tr R = 0`, ten independent conditions, as the rank computation under claim 3 shows. The statement `(Gmat R).trace = 12 * (Rᵀ * R).trace` is the record's `Σ_k g_k = 4(n-1)‖W‖²` at `n = 4` ([bounds.md](../findings/bounds.md), the L199 block and the quantifier note). Two conventions that could have spoiled that reading do not: the `φ_j` are orthonormal for the layer's own `inner2`, so `tr(Gmat R)` is invariant under an orthonormal change of `Λ²`-basis and equals `Σ_k g_k` in an eigenbasis, and both sides are quadratic in the same norm, so the `½` cancels. The record's block also says these moments *"consume relation (B)"*, which is Ricci-flatness with first Bianchi, so `IsWeyl` is the record's own hypothesis and, by claim 3, the weakest one available.

**Claim 2.** Every clause of the screen reproduced independently from the Lean definitions: `W` is symmetric, `W₀₅ - W₁₄ + W₂₃ = 0`, `tr W = 0`, all sixteen `Ric W a b = 0`, `tr(WᵀW) = 288`, and `tr(Gmat W) = 3456 = 12 × 288`. The witness is a genuine `IsWeyl` object and the arithmetic is right.

**Claim 4.** `Msys` has off-diagonal `-3/10` and diagonal `6/5`, so each row sums to `3/5` at the all-ones vector and both sides of `Msys_quadForm_eq_at_ones` are `9/5`. With `Msys_quadForm_ge` it makes `3/5` the best constant, which for a symmetric matrix is `λ_min = 3/5`, and the eigenvalues `3/5, 3/2, 3/2` agree. `#print axioms` clean on `Msys_quadForm_eq_at_ones`, `Msys_quadForm_ge` and `Ge_quadForm_eq_at_ones`. Two qualifications: *"`λ_min(Msys) = 3/5` is attained"* is a READING of two declarations and no eigenvalue is typed anywhere, and neither `_eq_at_ones` theorem appears in [lean/INDEX.md](../lean/INDEX.md), whose I104 row was not touched by the commit and names no declaration for the sharpness it asserts.

## Overreach sweep

Each sentence below is quoted from what these three commits added, with what the declarations support.

| where | sentence | what holds |
|---|---|---|
| [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), `diagTest_isSymm` | *"The hypotheses are inhabited, so nothing above is vacuous"* | **false for `trace_Gmat_weyl` as of this commit.** `diagTest` has `tr = 21` and is not `IsWeyl`, and no `IsWeyl` witness is typed in the layer at all. The screening witness lives only in the commit message. The sentence covers `G_eq_sharp` and nothing else |
| [lean/INDEX.md](../lean/INDEX.md), L199 row | *"Non-vacuity is visible: `diagTest_isSymm` and `Gmat_diagTest_ne_zero` exhibit an object satisfying the hypothesis"* | same defect, and "the hypothesis" now means two different things for the row's two theorems |
| [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), `G_eq_sharp` | *"the cost is dominated by EVALUATING `sharpMat` rather than by compiling it once"* | **refuted**, and measured backwards: `273s` user, `15.8s` of it evaluation |
| same | *"says an `#eval` screen of this identity is not reachable at all"* | unsupported, and the measurement above says the opposite |
| same, and the L199 index row | *"Cutting the work to a third cut the time to about a half"* | two runs killed at caps are not two times |
| [lean/INDEX.md](../lean/INDEX.md), L171 row | *"the one-variable half of it is now PROVED"* | it was proved before the commit, by `scalar_max` |
| L171 row and the new section docstring | *"What the `sorry` still owes is the GEOMETRY alone, the decomposition and the Rayleigh bound"* | short by attainment of `λ` on `q^⊥` and by the symmetry of `M` |
| [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean), `Msys_quadForm_eq_at_ones` | *"so `λ_min(Msys) = 3/5` is attained"* | a reading of two declarations, correct, with no eigenvalue typed |

**What the sweep did NOT find.** The deficit sentence, the equality-locus sentence and *"the three counterexamples are the three deficits, a lost scalar-curvature term and a lost Ricci term"* are all exactly right, the last one term by term: `2(tr R)² + 8(R₀₅-R₁₄+R₂₃)²` is `4(tr A)² + 4(tr C)²`, the scalar part, and `8‖B‖²` is the trace-free Ricci part. The `IsWeyl` repair and its attribution to [r1044](REVIEW_r1044.md) are accurate.

**Adjacent, outside these commits.** [lean/INDEX.md](../lean/INDEX.md)'s I104 row carries status **proved** while [I104GramSystem.lean:254](../lean/HamiltonsCubic/Results/I104GramSystem.lean) (`joint_system_holds`) carries a `sorry`, which the elaborator reported on every run here.

## `#print axioms`

Appended to each source, elaborated with `lake env lean`, and every file restored byte for byte afterwards, confirmed by an empty `git diff`.

| declaration | axioms |
|---|---|
| `trace_Gmat_weyl` | `propext, sorryAx, Classical.choice, Quot.sound` |
| `trace_comm_sq` | standard three |
| `Msys_quadForm_eq_at_ones` | standard three |
| `Msys_quadForm_ge` | standard three |
| `Ge_quadForm_eq_at_ones` | standard three |
| `plane_objective_le` | standard three |
| `plane_objective_attained` | standard three |
| `scalar_max` | standard three |
| `L171` | `propext, sorryAx, Classical.choice, Quot.sound` |

Two `sorry` warnings in [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), on `G_eq_sharp` and `trace_Gmat_weyl`, and one in [L171Statement.lean](../lean/HamiltonsCubic/Results/L171Statement.lean), on `L171`, matching what the files declare. No `Lean.ofReduceBool` reached any of these.

## Corrections owed

1. **Withdraw the cost conclusion** in [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) and the L199 row of [lean/INDEX.md](../lean/INDEX.md), and record instead that the two runs were censored at caps, that the compile dominates, and that a whole-matrix `#eval` screen evaluates in seconds once the file is compiled.
2. **Fix the non-vacuity sentence** so it is scoped to `G_eq_sharp`, and type the Weyl witness if `trace_Gmat_weyl` is to have one in the layer.
3. **Name the third item in L171's `sorry`**, attainment of `λ` on `q^⊥`, and the symmetry of `M` in the cross-term step. **Delete or rewrite the old What the `sorry` is section**, which now says something different and needs no spectral theorem.
4. **Say that `scalar_max` already carried the one-variable step**, in the commit's own terms, and either delete the duplicate pair or keep it with a pointer.
5. **Say `‖B‖` is taken in the ORTHONORMAL adapted basis**, and cite the derivation rather than the forty random matrices.
6. **Index `Msys_quadForm_eq_at_ones` and `Ge_quadForm_eq_at_ones`** in the I104 row, and fix that row's **proved** status against `joint_system_holds`'s `sorry`.

## How the analysis-only rule was honoured

**No sweep, census, optimisation or falsifier hunt was opened.** The work above is a derivation, run in seconds of symbolic algebra on objects constructed for the purpose: `adMat` and `Gmat` rebuilt from the Lean definitions, `tr(Gmat R)` expanded over the twenty-one free entries, and the rank of `Ric`'s linear span compared against the span of `B` and `tr R`. Total cost under a second.

**Three Lean runs, each priced in advance and each on files already in hand**: the axiom probes on [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean) and [L171Statement.lean](../lean/HamiltonsCubic/Results/L171Statement.lean), one process at a time, one to five minutes each, restored byte for byte.

**Two cost probes, with the cap declared before each started.** The first completed in `4m46s` and its numbers are above. **The second was killed at my declared `420s` cap with no output, and is recorded as a censored observation rather than as a time**, which is the discipline claim 5 failed. Its scratch files were removed and `git status` is clean.
