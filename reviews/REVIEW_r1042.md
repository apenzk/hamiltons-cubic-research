# REVIEW_r1042: L182's floor and I104's Gram system

Reviewer r1042, sole reviewer on this scope. Commits `223f8cbf` on [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) and `1373da15` on [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean).

Log: [agent_logs/r-l182-i104.log](../agent_logs/r-l182-i104.log)

| # | claim | verdict |
|---|---|---|
| 1 | [lam_mul_F_floor](../lean/HamiltonsCubic/Results/L182Statement.lean) proves the floor at every real `n ≥ 12` given `F 12 ≤ F n`, no `sorry` | **CONFIRMED** |
| 2 | the interval chain is VALID, every bound rounds outward | **CONFIRMED**, recomputed independently, twelve steps, none inward |
| 3 | margin is `4.77e-6`, and eight digits are genuinely needed | **CONFIRMED** on both counts, and one docstring contradicts both |
| 4 | [sqrt_bounds_of](../lean/HamiltonsCubic/Results/L182Statement.lean) is correct and is the only square-root instrument | **CONFIRMED** for the chain it is scoped to |
| 5 | every numeral is the script's output, and the script refuses to write on a non-closing chain | **CONFIRMED** for the floor section, and the commit message overclaims the scope |
| 6 | `Ge`/`Msys` two-sided inverse, both spectra, `λ_max(Ge) = 5/3` attained | **CONFIRMED**, and `Msys` is proved to be *the* inverse, so no other matrix can pass |
| 7 | the algebraic half of the `joint_system_holds` debt is genuinely retired | **PLAUSIBLE**, one algebraic step short, and the file and index both name that step as delivered |

## Claim 1, and the parity question

`lam_mul_F_floor (n : ℝ) (hn : 12 ≤ n) (hF : F 12 ≤ F n) : (5923 : ℝ) / 10000 < lam n * F n`. Neither file carries `sorry`, `native_decide` or an `axiom`. Every theorem named in the brief reports `[propext, Classical.choice, Quot.sound]` under `#print axioms`, run by appending the calls to the source and invoking `lake env lean` on it, so no stale `.olean` was consulted. Both files were restored byte for byte afterwards.

**The floor is non-vacuous where the record needs it.** `lam_mul_F_floor 12 (by norm_num) le_rfl` typechecks, so `n = 12` is a real instance and the theorem is not an implication with no subject.

**`hF` really does carry the parity restriction.** The record's [L182](../findings/second-order.md) is at even `n ≥ 12`, and its own text says *"the parity restriction comes from $F$ alone"*, which is the shape the Lean has. Everything the proof uses besides `hF` is unconditional at real `n ≥ 12`: [three_halves_lt_theta0sq](../lean/HamiltonsCubic/Results/L182Statement.lean) is the crossover `n² - 12n + 8 > 0`, true from `6 + 2√7 = 11.2915` upward, and [lamInf_lt_lam](../lean/HamiltonsCubic/Results/L182Statement.lean) follows from it at every real `n ≥ 12`. So the wider type claims nothing the record declines to support: where `hF` fails the statement is vacuous, and where it holds the conclusion is a theorem. `hF` is [L162](../findings/second-order.md)'s `F(n) > F(12)` at even `n ≥ 14` weakened to `≤`, which also admits `n = 12` by `le_rfl`.

**The definitions match L162 term by term.** `cp = 3θ₀/(n-2)`, `rhoEff = √6 - θ₀(n+16)/(2(n-2))`, `lam = 2/√(9(θ₀ - √(3/2)))`, `Cn = 2(2n-3)/(n-1)`, `beta = lam/(2 Cn)`, `w0 = (n-4)/n`, `s0 = √(cp + rhoEff w0²)`, `F = 4s₀/(√(4βs₀+1)+1)²`. At `n = 12` the file's `theta0_twelve_sq` gives `55/36`, and `F(12) = 0.3867277` against L162's recorded `0.38673`.

## Claim 2, the chain recomputed from scratch

I transcribed the eight surd lemmas by hand from the Lean, chose every step's direction independently, and recomputed the chain in exact `Fraction` arithmetic, checking at each step that the Lean's numerals lie OUTSIDE a valid enclosure computed here.

| step | true enclosure | Lean's interval | direction |
|---|---|---|---|
| base surds | `lo² < x < hi²` for all four | as stated | strictly outward |
| `G = 9(θ₀(12) - √(3/2))` | `[0.101593800, 0.101593980]` | equal | lower takes `θ₀` LOW and `√(3/2)` HIGH |
| `R = √G` | `[0.3187378233, 0.3187381057]` | outward of it | one `sqrt_bounds_of` |
| `λ(12) = 2/R` | `[6.2747438642, 6.2747495732]` | outward | reciprocal REVERSES, lower takes `R` HIGH |
| `β = 11λ/84` | `[0.8216926489, 0.8216933966]` | outward | positive scalar, order kept |
| `X = cp + ρ_eff w₀²` | `[0.6903847747, 0.6903847883]` | outward | `ρ_eff` lower takes `√6` LOW and `θ₀` HIGH |
| `s₀ = √X` | `[0.8308939607, 0.8308939698]` | outward | one `sqrt_bounds_of` |
| `Y = 4βs₀ + 1` | `[3.7309578328, 3.7309603550]` | outward | both factors positive |
| `V = √Y` | `[1.9315687490, 1.9315694023]` | outward | one `sqrt_bounds_of` |
| `F = 4s₀/(V+1)²` | `[0.3867276559, 0.3867278373]` | outward | lower takes `s₀` LOW over `(V HIGH + 1)²` |
| `W = 9(√2 - √(3/2))` | `[1.705218120, 1.705218300]` | equal | lower takes `√2` LOW and `√(3/2)` HIGH |
| `U = √W`, `λ∞ = 2/U` | `[1.5315811106, 1.5315812044]` | outward | reciprocal reverses |

**No step rounds inward.** The one place the brief flagged, `s₀` appearing in `F`'s numerator and in its denominator, is handled by treating the two occurrences as independent, which yields a valid outer enclosure and is conservative rather than tight.

**A correction to the brief's premise, and it strengthens the verdict.** An inward rounding could not have passed Lean silently. Each chain lemma is a self-contained inequality about the real quantity, proved from its named predecessor, so an inward bound would be a FALSE proposition and the `nlinarith` would refuse it. The direction risk lives in [l182_emit.py](../scripts/misc/l182_emit.py), whose single `assert` tests only the final product and would be made to look BETTER by an inward step. What rules that out is Lean's acceptance of every step, plus this recomputation.

## Claim 3, the margin, and a docstring that contradicts it

**The proved margin is `4.771113e-06`**, so the commit's `4.77e-6` is right. **The TRUE value, computed at 50 decimal digits by a route sharing nothing with the script**, is

`λ∞ F(12) = 0.592304924934549950629744123666…`,

with `λ∞ = 1.53158115358378986925…` and `F(12) = 0.38672774442842873718…`. So the true margin over `0.5923` is `4.925e-6`, and the surd section's *"The true value is `0.59230492…`, so the margin is `4.9 × 10⁻⁶`"* is correct.

**Eight digits are genuinely needed.** Rerunning the chain on a six-digit surd grid gives `0.592297845`, below `0.5923` by `2.16e-6`, so the precision is forced. The file's figure for that screen is `0.5922980` against this `0.5922978`, a grid-choice difference in the last digit with the direction identical. Eight digits gives `0.5923048`, as stated.

### DEFECT: the `lam_mul_F_floor` docstring is a pre-proof leftover and re-records the constant wrongly for the third time

It carries three false sentences, all in the block beginning *"WHAT IS LEFT IS ONE NUMERAL"*:

- *"ITS MARGIN IS `4 × 10⁻⁵`"*. The margin is `4.9e-6` true, `4.77e-6` proved. Wrong by an order of magnitude.
- *"`λ∞ F(12) = 0.5923041…`"*, asserted as an EQUALITY. [second-order.md](../findings/second-order.md)'s L182 block already corrected exactly this: *"asserted $\lambda_\infty F(12)=0.5923041$ as an equality; both are wrong … it is a valid lower bound and not the value"*. This is the third recording of the constant wrongly, which is what the brief anticipated.
- *"the remaining step needs six rigorous significant figures"*, which contradicts the same file's surd section eleven theorems earlier: *"EIGHT DIGITS IS THE PRECISION THE FLOOR NEEDS, AND SIX IS NOT ENOUGH."*

The whole block describes work as remaining that the theorem underneath it performs. **Correction: delete it and keep the first two paragraphs of that docstring, which are accurate.**

## Claim 4, the instrument

[sqrt_bounds_of](../lean/HamiltonsCubic/Results/L182Statement.lean) is correct: `0 ≤ a`, `0 ≤ b`, `a² ≤ x`, `x ≤ b²` give `a ≤ √x ≤ b` through `Real.sqrt_sq` at each nonnegative endpoint. Within the floor section it is the only square-root instrument, applied four times, at `R`, `s₀`, `V` and `U`, with `Real.sqrt_le_sqrt` and `Real.sqrt_sq` appearing only inside its own proof. The eight surd lemmas above it use `Real.sq_sqrt` with `nlinarith`, and the structural theorems use `Real.sqrt_lt_sqrt`, both outside the scope the commit gives the claim.

## Claim 5, provenance of the numerals

I ran [l182_emit.py](../scripts/misc/l182_emit.py) and diffed its `l182_floor.lean` against the file. **Identical line for line across the whole floor section**, from the section heading through `lamInf_mul_F_twelve_gt`. Its guard `assert P > Q(5923,10000), "chain does not close"` precedes `out = open(...)`, so a non-closing chain writes nothing.

Two qualifications, both about scope rather than correctness:

- **The eight base surd numerals and `5923/10000` are typed by hand**, in the Lean and again in the script's `S2`, `S32`, `S6` and `T` tuples. All eight agree exactly as rationals, which I checked (the script writes `√6`'s bounds reduced, the Lean unreduced, and they are the same numbers). The file's docstring scopes it correctly with *"EVERY NUMERAL BELOW"*. The commit message's *"every numeral is emitted"* does not.
- **The `assert` is a weak guard.** An inward step TIGHTENS the interval and raises the apparent margin, so it passes. The guard catches a chain that fails to close and nothing else.

## Claim 6, `G_e` rebuilt from the record's definition

[2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md) defines it as *"$G_e$ the $3\times3$ matrix of unit diagonal and off-diagonals $\pm\tfrac13$"*, with the parity argument ruling out the odd sign patterns so that every admissible one gives `5/3`, and states `G_e⁻¹ = (3/2)I - (3/10)J`. [LEDGER.md](../findings/LEDGER.md) repeats both. The Lean's `Ge` has diagonal `1` and off-diagonal `1/3`, and `Msys` has diagonal `6/5` and off-diagonal `-3/10`, which are `(2/3)I + (1/3)J` and `(3/2)I - (3/10)J` exactly. **Both match the record's own definition rather than only its two quoted identities.**

**The "different matrix" worry is structurally void, and I proved so in Lean**: `Msys = Ge⁻¹` follows from `Msys_mul_Ge` by `Matrix.inv_eq_left_inv`, and an inverse is unique, so nothing else satisfies the relation. The spectra are as claimed, `5/3` on the constants and `2/3` on the mean-zero plane for `Ge`, `3/5` and `3/2` for `Msys`, each by an eigenvector identity.

**`Ge_quadForm_eq_at_ones` IS sharpness of `Ge_quadForm_le`** rather than a separate fact: it exhibits equality at the all-ones vector, which is where `λ_max` is attained. One thing the file leaves implicit: the record's `±1/3` and the parity argument that discards the minus patterns, which would give `λ_max = 4/3`. Taking the all-plus matrix is the right choice, since parity is geometry, and the file does not say the sign choice is an input.

**The sharpness the record's scalar bound actually rests on is missing.** That bound comes from `λ_min(Msys) = 3/5`, so its sharpness is equality in `Msys_quadForm_ge`, at the all-ones vector where both sides are `9/5`. It is one line and it is not in the file.

## Claim 7, the debt, and the one real overclaim of this review

### `sum_sq_le_of_quadForm_le` is NOT the record's `Σ u_i² ≤ (5/3) t`

The file's own header defines `q_a = α_a e_a + β_a f_a` and `u_a² = α_a² + β_a²`, and states the system as `t ≥ Σ β_a² + (3/2) Σ α_a² - (3/10) (Σ α_a)²`. `Msys_quadForm` proves that the `Msys` form is the `α`-part of that expression, so the vector `Msys` acts on is `α`.

The theorem takes `x ⬝ᵥ (Msys *ᵥ x) ≤ t` and concludes `x ⬝ᵥ x ≤ 5/3 * t`, which is **`Σ α_a² ≤ (5/3) t`, the record's statement only on the `β = 0` locus**. Two things separate it from the record's:

- the conclusion is about `α`, and the record's `u` carries the `β`-part as well;
- the hypothesis bounds the `α`-form alone, and the record's `t` bounds `Σ β_a² +` that form.

**The record's statement is true and is two lines, and I verified it in Lean.** Chaining `Msys_quadForm_ge` with the `β`-part's own coefficient `1 ≥ 3/5` gives `t ≥ Σβ² + (3/5)Σα² ≥ (3/5)(Σβ² + Σα²) = (3/5) Σ u_a²`, closed by `nlinarith` with the three `sq_nonneg (b i)`.

**So two places overclaim and need the same correction.** The docstring's *"The record's scalar bound"*, and [lean/INDEX.md](../lean/INDEX.md)'s row, which reads *"`sum_sq_le_of_quadForm_le` reaches the record's $\sum u_i^2\le\tfrac53t$ from the matrix rather than from a rearrangement"*. **Correction: either add the two-line theorem on `u` and let the row stand, or restate both to say the theorem is the bound on the `α`-part.** The first is better, since it costs two lines and makes the row true.

### The debt itself

The trailer `Lean: blocked -- joint_system_holds` is still correctly open. [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) now requires a declaration keyword before the name (the residual [r1038](REVIEW_r1038.md) flagged has been repaired), so the docstring mention of the name does not close it, and `1373da15` carries no `Lean: void` trailer.

**The trailer's stated REASON is now false, however.** It reads *"needing $G_e$ and its inverse, which the layer does not carry"*, and the layer now carries both, with both spectra. **Correction: restate the reason to name the geometry**, that a configuration's three pattern planes realise this `G_e` with each cross-Gram of rank one at principal cosines `(1/3, 0)`, which is what the file's closing heading already says.

Given the missing two-line step, the algebraic half is retired **except for one step**, which is why claim 7 is PLAUSIBLE rather than CONFIRMED. Nothing else the debt's algebra needs is absent.

## Vacuity and sharpness across both files

Nothing in either file is trivially true, and I checked the hypotheses that could have made a theorem empty.

- `forcing_at_surviving_config` is non-vacuous, with a Lean witness at `x = √(47567/750000) · 1`, where its conclusion holds with EQUALITY, so the specialisation is sharp as well as inhabited.
- `forcing`'s hypothesis is satisfiable for every `d > 0` along the constants, where the `x`-dependent part reads `3.6 c²`.
- `Ge_mulVec_of_sum_zero` is non-vacuous at `u = (1, -1, 0)`.
- `deriv_in_u_neg` is a one-step `linarith` that no other declaration in the file consumes. Its own docstring says as much, so it is decorative rather than defective.

### DEFECT: `forcing_at_excluded_config`'s docstring inverts the safety direction

It says the record's `0.116707` *"ROUNDS UP"* from `8753/75000 = 0.1167066…`, which is right and which I checked exactly. The gloss that follows is backwards: *"an earlier version of this docstring said 'rounded down', which is backwards and would have been the unsafe direction for a lower bound had it been true."*

For a lower bound, rounding DOWN is the safe direction and rounding UP is the unsafe one. The sentence labels the safe direction unsafe, and so presents the record's genuinely unsafe quotation as the harmless case. `0.116707 > 8753/75000`, so the record's figure asserts marginally more than the theorem proves. **Correction: "the record's `0.116707` rounds UP from the rational, which is the unsafe direction for a lower bound, so the exact `8753/75000` is what should be quoted."**

## How the analysis-only rule was honoured

Every computation ran on objects already in hand and finished in seconds: three Python runs in exact `Fraction` and 50-digit `Decimal` arithmetic, and three `lake env lean` invocations of 40 to 65 seconds each, one Lean process at a time. The six-digit variant of the chain is a **screen of a claim already recorded in the file**, reported as a screen and cited for nothing beyond confirming the direction the file states. No sweep, no census, no optimisation of unknown cost, and no falsifier hunt was opened. Both Lean files were restored to their committed state after the `#print axioms` runs, and `lean/HamiltonsCubic/Results/I67PfSquared.lean`, which another session holds, was left untouched.
