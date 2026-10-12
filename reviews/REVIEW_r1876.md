# REVIEW r1876: L222 item 5 at a minimising angle, L222Min.lean

Gate 2 review of [L222Min.lean](../lean/HamiltonsCubic/Results/L222Min.lean) against [second-order.md](../findings/second-order.md), Lemma L222, item 5, read at source together with [L222Rot.lean](../lean/HamiltonsCubic/Results/L222Rot.lean), [L224Rot.lean](../lean/HamiltonsCubic/Results/L224Rot.lean), [L224EqRot.lean](../lean/HamiltonsCubic/Results/L224EqRot.lean), [PairNorm.lean](../lean/HamiltonsCubic/Results/PairNorm.lean), [PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean), [PairIdent.lean](../lean/HamiltonsCubic/Results/PairIdent.lean) and [DiagSquare.lean](../lean/HamiltonsCubic/Results/DiagSquare.lean). Footing: analysis only. The one Lean run was `#print axioms` on a scratch file with a one-line `example`, seconds of compute.

| # | Claim | Verdict |
|---|---|---|
| 1 | `min_angle_real`: `X ≤ C²X + S²Y + 2CSZ` at every unit `(C, S)` gives `Z = 0` and `X ≤ Y` | CONFIRMED |
| 2 | `nuX_add`, `vy_add`, `vy_vy` | CONFIRMED |
| 3 | `L222_min`: under `hmin`, `Σ_a x_a (w_{ja} − w_{ka}) = 0` and `‖ν_x‖² ≤ ½ Σ_{a∉{j,k}} (w_{ka} − w_{ja})²` | CONFIRMED WITH OBSERVATIONS |
| 4 | The INDEX L222 row and the record's L222 header | CONFIRMED WITH OBSERVATIONS |

Summary: the file proves what the record's item 5 claims at a minimising angle, with two readings left untyped (the identification of `hmin`'s expression with the rotated tensor's pair part, and `hys` from the weight property), both of which the INDEX row half states.

## A. Hypothesis inventory

Every hypothesis of `L222_min` is used. `hjk` feeds both calls of `normSq2_nuX`. `hxj` and `hxk` give `vy x = x` through `vy_of_zero`, and they are used again in the first conclusion at `c = j, k`. `hxs` gives the zero sum of `vy (a • yv + b • x)` in `hsum` and the hypothesis of `normSq2_nuX` in `hX`. `hys` is used once, in `hsum`, so that `normSq2_nuX` applies to every combination `a • yv + b • x`. `hmin` is the whole content.

`hys` is derivable from `w` being a weight. [L222Rot.lean](../lean/HamiltonsCubic/Results/L222Rot.lean) derives it inside `Sjk_rot` from `hw.rowSum j`, `hw.rowSum k`, `hw.hollow` and `hw.symm` through `sum_vy`: `Σ_{c∉{j,k}} y_c = (Σ_c w_{jc} − Σ_c w_{kc})/2 − y_j − y_k = 0 − (−w_{kj}/2) − (w_{jk}/2) = 0`. I rechecked that arithmetic by hand. In `L222_min`, `w` is a bare `Matrix` and `hys` is an extra hypothesis. That is a strict generalisation rather than a gap: at a genuine tensor `coordOp w` with `IsWeight w` the hypothesis is discharged by the argument above. The discharge sits inside the proof of `Sjk_rot` and is not exported, so a consumer wanting `L222_min` at a weight must repeat it (O2). Whether `hys` is needed at all turns on `normSq2_nuX` without `hsum`, which the INDEX row already lists as owed for generality (r1804 O2).

## B. Fidelity of hmin

In L222Rot's `hrot`, `rotR (Rot j k c s) (coordOp w + nuX j k x)` equals a character-1 part `coordOp ev + (c² − s²) • coordOp (D⁻_y) − 2cs • coordOp (D⁻_x)` plus the pair part `(2cs) • nuX j k y + (c² − s²) • nuX j k x`, with `y_a = (w_{ja} − w_{ka})/2`. This comes from `rot_even` (the swap-even part fixed), `rot_Dminus` (`D⁻_y ↦ (c² − s²) D⁻_y + 2cs ν_y`) and `rot_nuX` (`ν_x ↦ (c² − s²) ν_x − 2cs D⁻_x`), whose statements I read in [L224Rot.lean](../lean/HamiltonsCubic/Results/L224Rot.lean#L83). The pair part is exactly the expression inside `hmin`, same `y`, same coefficients, same order. The decomposition into character `1` and character `ε_jε_k` is unique by `char_split_zero`, so that expression is the `ε_jε_k` component of the rotated tensor, and `hmin` is "‖ν‖² at the identity is at most ‖ν‖² at every rotation".

The identification is by reading. `hrot` is a local `have` in the proof of `Sjk_rot`, whose statement is existential in `D'` and `ν'` and does not expose the formula. No theorem states "the `V_{jk}` component of `rotR (Rot j k c s) (coordOp w + nuX j k x)` is `2cs ν_y + (c² − s²) ν_x`" (O1). This is an observation: the module docstring and the INDEX row both say the hypothesis is L222Rot's computation.

## C. Reading of x and K

`Rot j k c s` ([PairSquare.lean:76](../lean/HamiltonsCubic/Results/PairSquare.lean#L76)) has columns `(c, s)` and `(−s, c)` in the `(j, k)` plane, determinant `c² + s² = 1`, so the family is all of `SO(2)` in that plane and is closed under composition. If `θ₀` minimises `‖ν‖²` along the orbit of `W₀` and `W = Rot(θ₀) W₀`, then the orbit of `W` is the same set reparametrised, and `W` minimises at the identity. So stating the conclusions for the tensor `W = coordOp w + ν_x` at which `hmin` holds is the record's "with D, K and x those of the rotated tensor". `x` is the ν-coordinate vector (`‖ν_x‖² = 2‖x‖²` by `normSq2_nuX`, matching the record's `‖ν‖² = 2‖x‖²`), and `w` is the weight of the character-1 part, which the record calls the sectional matrix `K` (the L120Ident reading `coordOp w = restrict (diagOp_isWeyl hw)`, used in `Sjk_rot`).

The sums match the record's convention. The statement of L222 says "Sums over a run over a ∉ {j,k}", and the proof of item 5 adds that the indices `a = j, k` would contribute `2K_{jk}²`. `vy j k (fun a => w k a − w j a)` zeroes exactly those two entries, so the Lean bound is the record's bound. The first conclusion sums over all `a`, but `x_j = x_k = 0` makes it the same sum.

"Minimising" is read globally in `hmin` (every rotation). The record's proof argues from a local minimum by second-order Taylor expansion. The two are equivalent here: `‖ν(φ)‖²` is `C²X + S²Y + 2CSZ` at `(C, S) = (cos 2φ, sin 2φ)`, which is `(X+Y)/2 + ((X−Y)/2) cos 4φ + Z sin 4φ`, a single sinusoid in `4φ`, whose local minima are all global. So the global reading loses nothing, but that is an argument by hand, not in the file (O3).

## D. min_angle_real

`X ≤ Y` from `(C, S) = (0, 1)`. Correct.

The rational parametrisation. With `C = (1 − t²)/(1 + t²)`, `S = 2t/(1 + t²)`, the numerator of `C²X + S²Y + 2CSZ − X` over `(1 + t²)²` is `(1 − t²)²X + 4t²Y + 4t(1 − t²)Z − (1 + t²)²X = 4t²(Y − X) + 4t(1 − t²)Z`, which is `4t (t(Y − X) + (1 − t²)Z)`, the file's `e`. Checked by hand.

The limit. At `t > 0`, `key t` divided by `t` gives `(1 − t²)Z ≥ −t(Y − X)`. At `−t`, `key (−t)` is `−t (−t(Y − X) + (1 − t²)Z) ≥ 0`, so `(1 − t²)Z ≤ t(Y − X)`. Hence `(1 − t²)|Z| ≤ t|Y − X| ≤ tB`. With `t = min(1/2, |Z|/(4B))`, `B = |Y − X| + 1 > 0`: `t > 0` needs `Z ≠ 0`, which is the contradiction hypothesis. `t ≤ 1/2` gives `1 − t² ≥ 3/4`, and `t ≤ |Z|/(4B)` gives `tB ≤ |Z|/4`. So `(3/4)|Z| ≤ |Z|/4`, false at `|Z| > 0`.

Both sign cases. `Z < 0` uses `e1`: `(1 − t²)(−Z) ≤ t(Y − X) ≤ tB ≤ −Z/4` against `(3/4)(−Z) ≤ (1 − t²)(−Z)`. `Z > 0` uses `e2`: `(1 − t²)Z ≤ t(Y − X) ≤ tB ≤ Z/4` against `(3/4)Z ≤ (1 − t²)Z`. Each is linear in the atoms once `hA`, `habs`, `le_abs_self` and `htB` are supplied, so `nlinarith` closes it. The pairing is the right one: `e1` bounds `(1 − t²)Z` from below, which is the useful half at negative `Z`, and `e2` bounds it from above, the useful half at positive `Z`.

## E. Axioms

`#print axioms` on a scratch file importing the built module, via `lake env lean`: `L222_min`, `min_angle_real`, `nuX_add`, `vy_add` and `vy_vy` each depend on `[propext, Classical.choice, Quot.sound]`, the standard three. The scratch `example` instantiating `min_angle_real` at `X = 2, Y = 3, Z = 0` elaborated without error. The module is imported in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) (line 1077) and its `.olean` is present.

## F. Breakers

- `min_angle_real`: breaks if the hypothesis covers only the quarter circles with `CS ≥ 0`. The object is `X = 0, Y = 1, Z = 1`: it satisfies the inequality at every such `(C, S)` and fails the conclusion. Over the full circle it fails the hypothesis at `C = 1/√2, S = −1/√2` (`0 ≤ 1/2 − 1` is false). I checked by hand that the file's hypothesis quantifies over the full circle, and that the proof uses both `t` and `−t`, which is where the two halves enter.
- `L222_min`, first conclusion: breaks at a non-minimiser. The object is any `x, y` with `⟨x, y_v⟩ ≠ 0`: then `Z ≠ 0`, a small rotation with `CS` of the sign of `−Z` lowers `‖ν‖²`, and `hmin` fails there, as it must.
- `L222_min`, second conclusion: breaks if the sum ran over all `a`, where it would gain `2w_{jk}²` and become weaker, not false. It would be false with the constant `¼` in place of `½`: at `x ⊥ y_v` with `‖x‖ = ‖y_v‖`, `hmin` holds (the sinusoid is constant in `C` and `S`) and `‖ν_x‖² = 2‖y_v‖² = ½ Σ (w_{ka} − w_{ja})²`, so `½` is sharp. I derived that equality case by hand.
- `hmin` is non-vacuous: at `x ⊥ y_v` with `‖x‖ ≤ ‖y_v‖`, `‖ν‖²(C, S) = 2(C²‖x‖² + S²‖y_v‖²) ≥ 2‖x‖²`. The `example` in my scratch file screens the arithmetic core at `X = 2, Y = 3, Z = 0` through `min_angle_real`. That is a screen, not evidence.
- Hypothesis drops: without `hys` the proof loses `normSq2_nuX` on the combinations. I found no object breaking the conclusion without it, and r1804 O2 suggests the norm identity holds without `hsum`, so `hys` is likely removable.

## Observations

- O1. The identification of `hmin`'s expression with the `V_{jk}` component of the rotated tensor is by reading of L222Rot's local `hrot`. Exporting `hrot` as a theorem, and stating a corollary of `L222_min` with `hmin'`: `∀ c s, c² + s² = 1 → ‖V_{jk}-part of rotR (Rot j k c s) W‖² ≥ ‖ν_x‖²`, would type it. The INDEX row's "the minimising angle being untyped (r1824 O5)" covers the angle but not this bridge.
- O2. `hys` is an extra hypothesis where the record's setting (w a weight) implies it. The derivation exists only inside the proof of `Sjk_rot`. Exporting it as a lemma `hys_of_weight` would let consumers discharge it in one line.
- O3. `hmin` is the global-minimum reading. The record's proof is second-order and local. They agree because `‖ν‖²` along the orbit is a sinusoid in `4φ`. Neither the file nor the record header says so, and one sentence in the INDEX row would close the question.
- O4. The docstring's bullet list names `nuX_add` and `vy_vy` but not `vy_add`, which the INDEX row does name. Cosmetic.
- O5. The record header now says "item 5's conclusions at a minimising angle are `L222_min`" and "The Lean owes item 5's infinitesimal form". That is accurate: the first sentence of item 5 (`ξ·D ∈ V_{jk}` with coordinates `K_{ja} − K_{ka}`, `‖ξ·ν‖² = 4‖ν‖²`) is untouched by this file, and the INDEX row's status stays **partial**, which is correct.

## Verdict

CONFIRMED WITH OBSERVATIONS. `min_angle_real`, the three helper lemmas and `L222_min` are correct and faithful to item 5's second sentence, with the record's "sums over a ∉ {j,k}" convention matched exactly. The two untyped links (O1, O2) are readings the docstring and INDEX row state, and none of the observations changes a verdict.
