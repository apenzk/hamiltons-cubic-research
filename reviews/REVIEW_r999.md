# Review r999: the closed form of `#` at a diagonal operator

Gate 2 reviewer r999, brief [BRIEF_sharpQF_diagOp.md](BRIEF_sharpQF_diagOp.md). Derivation by hand from the primitives, then an independent reimplementation that reproduced the proved anchor before any disagreement was believed.

## Overall verdict: REFUTED

**[sharpQF_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L56) is false as stated.** The correct closed form at every symmetric hollow `w` and every `a ≠ b` is

$$\mathrm{sharpQF}(\mathrm{diagOp}\,w)(\varphi_{ab}) \;=\; \sum_{d\notin\{a,b\}} w_{ad}\,w_{bd} \;=\; (w^2)_{ab}.$$

It is quadratic in `w`, where the claim is linear in `w`.

| # | claim | verdict |
|---|---|---|
| 1 | closed form `(1/2) Σ_{d∉{a,b}} (w_ad + w_bd)` | **REFUTED**. The value is `Σ_{d∉{a,b}} w_ad w_bd = (w²)_ab` |
| 2 | collapse to `-w_ab` on the zero-row-sum locus | **REFUTED**. The locus value is `(w²)_ab`. The collapse arithmetic itself is valid, but its premise is not |
| 3 | only the `2(n-2)` one-index-shared directions contribute | **CONFIRMED on the support, REFUTED on the weight.** Those directions are exactly the contributors, and each contributes the PRODUCT `w_ad w_bd` of both weights rather than the complementary weight alone |
| 4 | the anchor: the all-ones weight returns `(n-2)‖η‖²` | **CONFIRMED, and it is blind.** Both the correct form and the claimed form return `n-2` at the all-ones weight, so the control cannot separate them |
| 5 | the constant: `-1/4`, the ordered-pair double count, the `1/2` | **CONFIRMED consistent.** The constants are not where the error is |
| 6 | hypothesis class | symmetry is used and needed. Hollowness is unused for the per-direction sum and is exactly what turns it into `(w²)_ab`. No row-sum hypothesis is needed, which the claim got right |
| 7 | vacuity | not vacuous for `n ≥ 3`, and true but empty at `n ≤ 2` |

## Where the error entered: the brief's quoted definition has one `R`, the Lean definition has two

This is the whole of it.

- The brief quotes `sharpQF(R)(η) = -¼ Σ_i Σ_j ⟨[η, R([η, φ_ij])], φ_ij⟩`, with `R` applied **once**.
- [WeylReal.lean:102](../lean/HamiltonsCubic/Base/WeylReal.lean#L102) defines `sharpQF R η = -(1/4) * ∑ i, ∑ j, inner2 (br η (R (br η (R (phi i j))))) (phi i j)`, with `R` applied **twice**.
- The source corroborates its own reading twice over: [WeylReal.lean:264](../lean/HamiltonsCubic/Base/WeylReal.lean#L264) records `sharpQF R η = -½ tr(ad_η R ad_η R)`, and [sharpQF_neg](../lean/HamiltonsCubic/Base/WeylReal.lean#L286) is a PROVED theorem whose docstring says `sharpQF` "is even in `R` ... since `R` enters it exactly twice".

**Under the brief's one-`R` reading the claimed answer is exactly right.** I derived `(1/2) Σ_{d∉{a,b}} (w_ad + w_bd)` from it independently and asserted it against a reimplementation. So the claim is a correct theorem about an operator the record does not define, and the `sorry` in [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean#L62) cannot be discharged.

## Row 1 refuted without any numerics

[sharpQF_neg](../lean/HamiltonsCubic/Base/WeylReal.lean#L286) is proved, and [diagOp_smul_arg](../lean/HamiltonsCubic/Base/SharpDiag.lean#L40) gives its linearity hypothesis for `diagOp w`. So

$$\mathrm{sharpQF}(\mathrm{diagOp}(-w))(\varphi_{ab}) = \mathrm{sharpQF}(\mathrm{diagOp}\,w)(\varphi_{ab}),$$

since `diagOp(-w) X = -(diagOp w) X`. The claimed right-hand side is odd in `w`, so the claim forces it to vanish identically. At `w = J - I`, symmetric and hollow, it equals `n - 2`, which is nonzero for `n ≥ 3`. **Two theorems already in the base layer contradict the third.**

## The derivation

Fix `a ≠ b` and `η = φ_ab`. Take the ordered pair `(i,j)` and read `br_phi_phi`.

1. **Disjoint pairs die.** If `{i,j} ∩ {a,b} = ∅` all four Kronecker deltas vanish, so `[φ_ab, φ_ij] = 0`.
2. **The pair itself dies.** At `{i,j} = {a,b}` the bracket is `[φ_ab, ±φ_ab] = 0`.
3. **One shared index survives.** At `(i,j) = (a,d)` with `d ∉ {a,b}`: `diagOp w (φ_ad) = w_ad φ_ad` by [diagOp_phi](../lean/HamiltonsCubic/Base/Families.lean#L160), which is where **symmetry of `w`** is spent. Then `[φ_ab, φ_ad] = φ_bd`, then `diagOp w (φ_bd) = w_bd φ_bd`, then `[φ_ab, φ_bd] = -φ_ad`, and pairing against `φ_ad` gives `-w_ad w_bd`. The same at `(i,j) = (b,d)`, and each reversed ordered pair repeats its partner because two sign flips cancel.
4. **Count.** Four ordered pairs per `d`, each contributing `-w_ad w_bd`, so the double sum is `-4 Σ_{d∉{a,b}} w_ad w_bd` and `-1/4` of it is `Σ_{d∉{a,b}} w_ad w_bd`.
5. **Hollowness closes it.** `Σ_{all d} w_ad w_bd = (w²)_ab`, and the two excluded terms are `w_aa w_ba` and `w_ab w_bb`, both zero exactly when `w` is hollow. So `(w²)_ab` is the hollow-case spelling and `Σ_{d∉{a,b}} w_ad w_bd` is the general one.

Under the brief's one-`R` reading, step 3 loses the second weight and each ordered pair contributes `-w_bd` at `(a,d)` and `-w_ad` at `(b,d)`, giving `(1/2) Σ_{d∉{a,b}} (w_ad + w_bd)`. **The two readings differ by which of the two weights survives, never by a constant.**

## Row 4: the control is satisfied by both readings, which is why it let this through

`id = diagOp J` at the all-ones `J`, which is symmetric and not hollow, so the general form applies: `Σ_{d∉{a,b}} 1 · 1 = n - 2`, and `‖φ_ab‖² = 1`. That is [sharpQF_id](../lean/HamiltonsCubic/Base/StructureConstants.lean#L190) exactly. The claimed linear form also returns `(1/2)(2(n-2)) = n - 2` there. **A control that a wrong answer passes is not a control for this claim**, and the reason is structural: at `R = id` one application and two applications are the same map, so no `R = id` test can ever see the degree.

The test that does see it is the degree test: `sharpQF(diagOp(t w))` scales as `t²` and the claimed form as `t`.

## The constants

The `-1/4` is the `1/2` of `inner2` times the `1/2` paying for the ordered-pair double count, as [WeylReal.lean:100](../lean/HamiltonsCubic/Base/WeylReal.lean#L100) states. The four ordered pairs per `d` cancel it to a clean coefficient of `1`. The `1/2` in the claimed answer is the same double-count factor surviving the two-per-`d` unordered count of the one-`R` reading. **All three constants are mutually consistent, in both readings.** The defect is the degree in `w`, and it is invisible to every factor-of-two check.

## Row 2

Given the claimed right-hand side, the collapse is correct arithmetic: hollowness gives `w_aa = 0`, so `Σ_{d∉{a,b}} w_ad = (Σ_d w_ad) - w_ab = -w_ab` under zero row sums, and the same at `b` with `w_ba = w_ab`. **Both hollowness and the row-sum hypothesis are genuinely used, and the conclusion still fails**, because its premise does. On the locus the value is `(w²)_ab`, which is `-w_ab` only by coincidence.

## Vacuity

The claim would be vacuous if the sum ranged over nothing, which is the case `n ≤ 2`: at `n = 2` there is no `d`, both sides are zero, and the statement holds emptily. It is not vacuous for `n ≥ 3`, where `w = J - I` is symmetric and hollow and the corrected form returns `n - 2 ≠ 0`. The hypothesis class is also inhabited well beyond the constant weight, since every symmetric hollow matrix qualifies.

## What the corrected form buys, which is the whole of the file's stated purpose

With `sharpQF(diagOp w)(φ_ab) = (w²)_ab`, the rest of the chain closes in two lines for every symmetric hollow `w`, with no row-sum hypothesis:

- [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L153) is diagonal in the `φ` basis with `sharpOp (diagOp w) (φ_ab) = (w²)_ab φ_ab`.
- [trCube](../lean/HamiltonsCubic/Base/WeylReal.lean#L142) `= (1/2) Σ_{i,j} w_ij³`, and [sharpPair](../lean/HamiltonsCubic/Base/WeylReal.lean#L166) `= (1/2) Σ_{i,j} w_ij (w²)_ij = (1/2) tr(w³)` by symmetry of `w`.
- So [Pcubic](../lean/HamiltonsCubic/Base/WeylReal.lean#L170) `(diagOp w) = (1/2)(Σ_{a,b} w_ab³ + tr(w³))`, which is [diagP](../lean/HamiltonsCubic/Base/Families.lean#L641) verbatim.

That is [DiagCubicFormula](../lean/HamiltonsCubic/Base/Families.lean#L649), the dependency [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean#L14) names as the record's largest. **The claimed linear form cannot reach it**, since it makes `Pcubic (diagOp w)` fail to be cubic in `w`. I verified the whole chain numerically as well, and it lands on `diagP` exactly.

## The reimplementation, and what it was run against first

Two scripts, built from the primitive definitions of `phi`, `inner2`, `br` and `diagOp` alone, with every check written as an assertion.

- **Anchors reproduced before anything else**: `sharpQF id η = (n-2) inner2 η η` on random skew `η` at `n = 2,3,4,5,6` and on every basis bivector, and `sharpOp id X = (n-2) X`, which is the record's `id# = (n-2) id`. Both hold to `1e-9`.
- **Then the disagreement**: 481 assertions in the first script and 145 in the second, all passing, including `sharpQF (diagOp w) (φ_ab) = (w²)_ab` on random symmetric hollow `w`, the degree test, and `Pcubic (diagOp w) = diagP w` on random locus weights at `n = 3,4,5`.
- The claimed form matches the Lean `sharpQF` nowhere outside the all-ones weight, and matches the brief's quoted one-`R` form everywhere.

Scripts are in the session scratchpad and are seconds of compute on objects constructed for the purpose, reported as a screen. **The hand derivation above stands on its own, and the parity argument from [sharpQF_neg](../lean/HamiltonsCubic/Base/WeylReal.lean#L286) refutes the claim without running anything.**

## What to change

1. Restate [sharpQF_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L56) as `sharpQF (diagOp w) (phi a b) = ∑ d, (if d = a then 0 else if d = b then 0 else w a d * w b d)`, hypothesis `∀ a b, w a b = w b a` only, and add the hollow-case spelling `(w * w) a b` as a corollary.
2. Drop the `-w_ab` corollary. The locus value is `(w²)_ab`.
3. Correct the mechanism sentence in the file header and in the docstring: each surviving direction contributes the product of the two weights, `w_ad w_bd`, rather than its complementary weight.
4. Add the degree check as the anchor the layer was missing, since `R = id` provably cannot see this class of error.
