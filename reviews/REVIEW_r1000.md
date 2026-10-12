# REVIEW r1000: the closed form of `#` at a diagonal operator

Gate 2, brief [BRIEF_sharpQF_diagOp.md](BRIEF_sharpQF_diagOp.md). Skeleton committed first, verdicts filled in as each phase closed.

## Verdict: REFUTED

**The brief's quoted definition of `sharpQF` is not the one [sharpQF_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean) is stated against.** The brief applies `R` ONCE, at [WeylReal.lean:102](../lean/HamiltonsCubic/Base/WeylReal.lean) the record applies it TWICE, and the claimed closed form is correct for the brief's version and false for the record's.

| # | claim | verdict |
|---|-------|---------|
| 1 | `sharpQF (diagOp w) (phi a b) = ½ Σ_{d∉{a,b}} (w_ad + w_bd)` | **REFUTED** against [sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean), CONFIRMED against the brief's one-`R` form |
| 2 | collapse to `-w_ab` on the zero-row-sum locus | REFUTED for the record's `#`, CONFIRMED for the one-`R` form |
| 3 | the `2(n-2)` one-shared-index directions are the only contributors | **CONFIRMED**, for both forms |
| 4 | anchor: the all-ones weight returns `(n-2)‖η‖²` | **CONFIRMED**, and it does NOT discriminate: both forms return `n-2` |
| - | the `-¼`, the ordered double count and the `½` | CONSISTENT, no factor of two is loose |
| - | hypothesis class | symmetry is used once, hollowness is used nowhere in row 1 |
| - | vacuity | not vacuous |

**The correct closed form**, at every symmetric `w` and every `a ≠ b`, with no row-sum and no hollowness hypothesis:

$$\mathrm{sharpQF}(\mathrm{diagOp}\,w)(\varphi_{ab}) \;=\; \sum_{d\notin\{a,b\}} w_{ad}\,w_{bd} \;=\; (w^2)_{ab}\quad\text{(the second equality needs }w\text{ hollow)}.$$

## The discrepancy, stated exactly

The brief writes `sharpQF(R)(η) = -¼ Σ_i Σ_j ⟨[η, R([η, φ_ij])], φ_ij⟩`, linear in `R`. [WeylReal.lean:102](../lean/HamiltonsCubic/Base/WeylReal.lean) defines

```
def sharpQF (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) : ℝ :=
  -(1/4) * ∑ i : ι, ∑ j : ι, inner2 (br η (R (br η (R (phi i j))))) (phi i j)
```

with `R` in both slots. The record knows which one it means and says so in three places: [StructureConstants.lean:92](../lean/HamiltonsCubic/Base/StructureConstants.lean) records `sharpQF R η = -½ tr(ad_η R ad_η R)`, [WeylReal.lean:264](../lean/HamiltonsCubic/Base/WeylReal.lean) repeats it, and [sharpQF_neg](../lean/HamiltonsCubic/Base/WeylReal.lean) is proved precisely because "`R` enters it exactly twice". Hamilton's `#` is quadratic in `R`, which is what makes `Pcubic` cubic, so the two-`R` form is the intended object and the brief's is a misquote rather than a competing convention.

`sharpQF_diagOp` is stated against the Lean `sharpQF`. Its right-hand side is linear in `w`. A quadratic form cannot equal a linear one, so the theorem is false as stated, independently of any arithmetic below.

## Row 1 derived from the definitions

The inner bracket, at `η = φ_ab` with `a ≠ b`, is read off the given structure constants. Ordered pairs with `i = j` vanish because `φ_ii = 0`, and the pair `(i,j)` and its swap `(j,i)` contribute equally because `φ_ji = -φ_ij` enters quadratically, so the ordered sum is twice the unordered one.

Three classes of unordered pair exhaust the sum:

- `{i,j} = {a,b}`: `[φ_ab, φ_ab] = 0`, contributes nothing.
- `{i,j} ∩ {a,b} = ∅`: all four deltas fail, `[φ_ab, φ_ij] = 0`, contributes nothing.
- exactly one shared index, `{a,d}` or `{b,d}` with `d ∉ {a,b}`: `[φ_ab, φ_ad] = φ_bd` and `[φ_ab, φ_bd] = -φ_ad`, the only surviving directions.

For the record's two-`R` form, at the pair `{a,d}`: `diagOp w` sends `φ_ad` to `w_ad φ_ad`, the inner bracket gives `w_ad φ_bd`, the middle `diagOp w` gives `w_ad w_bd φ_bd`, the outer bracket gives `-w_ad w_bd φ_ad`, and pairing against `φ_ad` gives `-w_ad w_bd`. The pair `{b,d}` gives the same number by the same route. Hence the unordered sum is `-2 Σ_{d∉{a,b}} w_ad w_bd`, the ordered sum doubles it to `-4 Σ`, and `-¼` of that is

$$\sum_{d\notin\{a,b\}} w_{ad}w_{bd}.$$

For the brief's one-`R` form the middle scaling is absent, `{a,d}` contributes `-w_bd` and `{b,d}` contributes `-w_ad`, and the same bookkeeping returns `½ Σ_{d∉{a,b}} (w_ad + w_bd)`, which is exactly row 1. So row 1 is a correct evaluation of the wrong functional.

## Row 4, the control

`diagOp` of the all-ones matrix is the identity on every matrix, so the anchor is a special case of row 1's hypothesis class once hollowness is dropped. Both closed forms reproduce it: the quadratic one gives `Σ_{d∉{a,b}} 1·1 = n-2`, the linear one gives `½·2(n-2) = n-2`, and `‖φ_ab‖² = 1` under the `½`-carrying pairing, matching [sharpQF_id](../lean/HamiltonsCubic/Base/StructureConstants.lean).

**The anchor therefore does not discriminate, and the brief is wrong to call it decisive.** The all-ones weight is the one point of weight space where a linear and a quadratic form in `w` are forced to agree, because every factor is `1`. Any check built on it alone would have passed row 1.

## Row 2

On the locus, `Σ_d w_ad = 0` with `w` hollow gives `Σ_{d∉{a,b}} w_ad = -w_ab` and likewise for `b`, so the one-`R` form collapses to `½(-w_ab - w_ab) = -w_ab`. The arithmetic of row 2 is right, resting on a premise that is not.

The record's `#` collapses instead to `(w²)_ab` on the locus, which is where hollowness enters: `Σ_{d∉{a,b}} w_ad w_bd = (w²)_ab - w_aa w_ab - w_ab w_bb`, and the two correction terms vanish only for hollow `w`. Zero row sums buy nothing here, since the quadratic form has no row-sum identity to spend them on.

## Row 3 and the constants

Row 3's mechanism is correct and is the one piece of the claim that survives intact for both forms. Exactly `2(n-2)` unordered directions contribute, those sharing exactly one index with `{a,b}`, and the complementarity is real: the direction `φ_ad` is scaled on the way out by `w_bd`, the weight on the index it does NOT carry. What row 3 omits is that the record's `#` scales it a second time on the way in, by `w_ad`, so each direction contributes the PRODUCT of the two weights rather than the complementary one alone.

The constants are consistent. The `-¼` is the `½` of [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean) times the `½` paying for the ordered double count, the double count contributes its factor of two, and `ad²_{φab}` acts by `-1` on the surviving directions, exactly as [br_br_phi](../lean/HamiltonsCubic/Base/StructureConstants.lean) states. The three cancel to leave `+1` per unordered direction, which is what both closed forms show.

## Hypothesis class

**Hollowness of `w` is used nowhere in row 1.** The derivation evaluates `w` only at `w_ad` and `w_bd` with `d ∉ {a,b}`, so no diagonal entry is ever read, and the `i = j` terms die on `φ_ii = 0` before the weight is consulted. This is not a defect of the claim but a hypothesis it does not need, and it is why the anchor at the non-hollow all-ones weight works at all. Hollowness returns only if the answer is restated as `(w²)_ab`.

**Symmetry of `w` is used exactly once, and it is load-bearing.** It is what makes `diagOp w` map `Λ²` into `Λ²`: `(diagOp w)(X)_ij = w_ij X_ij` is antisymmetric for antisymmetric `X` only when `w_ij = w_ji`. Without it `diagOp w` is not an operator on bivectors and the pairing is not the one the definition intends. The derivation itself, once `φ_ba = -φ_ab` is allowed to be evaluated consistently, needs nothing further from `w`.

## Vacuity

The claim would be vacuous if the hypotheses forced the sum to be empty or the weight to be zero: `n ≤ 2`, where no `d ∉ {a,b}` exists and both sides are `0`, or a hypothesis class collapsing to `w = 0`. Neither holds. Symmetric hollow weights form a space of dimension `n(n-1)/2`, `a ≠ b` is satisfiable at every `n ≥ 2`, and at `n ≥ 3` the sum has `n-2` nonempty terms. The witness below has both sides nonzero and unequal, which is the strongest possible statement that the claim is non-vacuous and false.

## What was run, and its controls

A matrix-level reimplementation from the definitions alone: `phi i j` as `single j i 1 - single i j 1`, `inner2` as `½ tr(XᵀY)`, `br` as the commutator, `diagOp` as the Hadamard product, and both sum variants. Seconds of compute on objects constructed for the purpose, inside the screening allowance.

**Controls, asserted rather than printed**, and passed before any disagreement was believed: both variants return `(n-2)·inner2 η η` at `R = id` for random skew `η` at `n = 3..7`, both return `n-2` at every `φ_ab`, and both return `n-2` at `diagOp` of the all-ones matrix. The row-3 count is asserted as `4(n-2)` ordered pairs, every one of them sharing exactly one index.

With the controls holding, the two-`R` variant matches `Σ_{d∉{a,b}} w_ad w_bd` to `1.3e-15` and misses the claimed linear form by up to `4.18` over random symmetric hollow `w` at `n = 3..7`. On the zero-row-sum locus it matches `(w²)_ab` to `1.1e-15` and misses `-w_ab` by up to `3.45`. Dropping hollowness leaves both closed forms exact. A non-symmetric `w` breaks skewness of `diagOp w X` outright, as the hypothesis-class reading predicts.

**A separating witness**, `n = 3`, `w_02 = 2`, `w_12 = 3`, `w_01 = -5`, symmetric and hollow, at `(a,b) = (0,1)`: the record's `sharpQF` returns `6`, the claimed form returns `2.5`, and `Σ_{d∉{a,b}} w_ad w_bd = (w²)_01 = 6`.

## What the repair is

State `sharpQF_diagOp` as `Σ_{d∉{a,b}} w_ad w_bd`, or equivalently `(w²)_ab` under the hollowness the signature already carries, and drop the row-sum corollary of row 2 in favour of the same expression. The three linearity lemmas in [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean) are unaffected and remain proved. The mechanism paragraph in that file's header needs one change: each surviving direction contributes the product of its own weight and its complementary weight, not the complementary weight alone.
