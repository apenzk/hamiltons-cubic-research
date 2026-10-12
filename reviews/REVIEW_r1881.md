# Reviewer r1881, L244 (ii)'s ceiling at every unit x of the negative eigenspace (L244Unit.lean), with the lean/INDEX.md L244 row

Gate 2 on commit 7adae251. Every declaration of [L244Unit.lean](../lean/HamiltonsCubic/Results/L244Unit.lean) was read at source against the record's Lemma L244 (ii) in [findings/second-order.md](../findings/second-order.md), together with [L244Sym.lean](../lean/HamiltonsCubic/Results/L244Sym.lean), [L244Frame.lean](../lean/HamiltonsCubic/Results/L244Frame.lean), the definitions `IsWeylOp` ([FoxProduct.lean:110](../lean/HamiltonsCubic/Base/FoxProduct.lean#L110)), `IsWeyl` ([WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)), `IsCritical` ([L40Statement.lean:77](../lean/HamiltonsCubic/Results/L40Statement.lean#L77)), `rowC_critical`, `per_vector_ceiling` and `theta_bound`. The reflection lemmas were derived by hand. A scratch file run with `lake env lean` printed the axioms of four declarations and the two signatures the final step consumes, and compiled a one-line screen that `refl 0` is the identity. The Lean is correct, the statement is (ii) at every unit `x ∈ E₀` modulo the typings the INDEX already owes, and the observations are minor: a `p = 1` corner the class-size hypothesis excludes, an owed item that is a definition rather than a gap, and duplication with L244Frame and L244Sym.

| # | Claim | Verdict |
|---|---|---|
| 1 | `L244_ceiling_unit` states (ii) at every unit `x ∈ E₀` | CONFIRMED WITH OBSERVATIONS (O1, O2, O3) |
| 2 | `refl`, `refl_inner`, `refl_refl`, `refl_self` including the degenerate case `⟨v,v⟩ = 0` | CONFIRMED |
| 3 | `refl_eigen`: a reflection through a `μ`-eigenvector keeps every `λ`-eigenvector a `λ`-eigenvector | CONFIRMED |
| 4 | `ψx_complete`, and `ψx_skew`, `ψx_orth`, `ψx_eigen`, `ψx_self` | CONFIRMED |
| 5 | Hypothesis inventory: every hypothesis of every theorem used | CONFIRMED |
| 6 | Axioms and satisfiability | CONFIRMED WITH OBSERVATIONS (standard three, satisfiability open as for the record, O4) |
| 7 | lean/INDEX.md L244 row: new text and owed list | CONFIRMED WITH OBSERVATIONS (O2, O3) |

**Summary:** `L244_ceiling_unit` proves `θ ≤ a(n − 5)`, `θ ≤ a(κ₀ − 1)`, `θ ≤ a(κ₂ − 3)` at every unit skew `x` with `Wx = −ax`, the Householder mechanism is sound in every case including `x = ψ_{k₀}`, the axioms are the standard three, and the INDEX row's removal of the frame-vector item from the owed list is correct.

## Conventions

- `inner2 X Y = ½ tr(XᵀY)`, so a unit skew `x` has `∑_{i<j} x_ij² = 1`, the record's normalisation (row (A) reads `n − 2` in these units, as L244Sym already established and r1856 checked).
- `refl v y = y − (2⟨v,y⟩/⟨v,v⟩) v`, with Lean's `r / 0 = 0`.
- `ψf`, `evf`: the spectral frame of [L244Frame.lean](../lean/HamiltonsCubic/Results/L244Frame.lean). `ψx hW k₀ x k = refl (ψf k₀ − x) (ψf k)`.
- Class `0` is the value `−a`, class `1` the value `0`, class `2` the value `a`, as in the record ("the indices 0, 1, 2 label the eigenvalues −a, 0, a in that order").
- `m₀ = |{γ : cls γ = 0}|`, `m₂ = |{γ : cls γ = 2}|`.

## The record's (ii), quoted

From [findings/second-order.md, Lemma L244](../findings/second-order.md#lemma-l244-the-per-vector-ceiling-on-a-symmetric-three-value-critical-point):

> **Setting.** $W$ a unit critical point, $W^2+W^\#=\theta W$, with three eigenvalues; ... $\kappa_r(x)$ is the sum of the top $r$ eigenvalues of $-\mathrm{ad}_x^2$.
>
> (ii) **The symmetric family.** If the eigenvalues are $(-a,0,a)$, $a=1/\sqrt{2p}$, with multiplicities $(p,N-2p,p)$, **the indices $0,1,2$ label the eigenvalues $-a,0,a$ in that order, so $E_0$ is the NEGATIVE eigenspace and $E_1$ the kernel of $W$**; then every unit $x\in E_0$ gives $$\theta\ \le\ \frac{\min\big(\kappa_{p-1}(x),\ \kappa_p(x)-2,\ n-4\big)-1}{\sqrt{2p}},\qquad\text{in particular}\qquad\theta\le\frac{n-5}{\sqrt{2p}} .$$
>
> *Whether the family has a member at any $n$ is open*: the record exhibits none, a hand screen found none at $n=4$, and if it is empty at every $n$ then (ii) is vacuous ([r1856] O1, O6).

The proof of (ii) in the record: rows (B) and (C) at `x ∈ E₀` divided by `a` and `a²`, row (A) giving `K ≤ n − 4`, the `E₀` cap giving `K ≤ κ_{p−1}(x)` and the `E₂` cap giving `K + 2 ≤ κ_p(x)`, with `K = θ/a + 1`.

## Hypothesis inventory

| Theorem | Hypotheses | Used |
|---|---|---|
| `refl_inner`, `refl_refl` | none beyond `v, y, z` | n/a |
| `refl_skew` | `hv`, `hy` skew | both |
| `refl_self` | `hψ : ⟨ψ,ψ⟩ = 1`, `hx : ⟨x,x⟩ = 1` | both (in `hN`) |
| `refl_eigen` | `hW`, `hv`, `hy`, `hWv`, `hWy` | all: `hW.1` for linearity, `hW.2.2.1` (symmetry on skew pairs) with `hv`, `hy`, then `hWv`, `hWy` |
| `hId_gen` | `hcomp`, `hX` | both |
| `hWP_gen` | `hW`, `hcomp`, `heig`, `hcls`, `hX` | all |
| `L244_rows_gen` | `hW`, `ha`, `hc`, `hS`, `hcomp`, `heig`, `hcls`, `hk₀`, `hunit` | all |
| `class_orth_gen` | `hO` | yes |
| `cap_self_gen` | `hS`, `hO`, `hcomp`, `hk₀`, `htop`, `hsize` | all |
| `cap_other_gen` | `hS`, `hO`, `hcomp`, `hx`, `hsize`, `htop` | all |
| `ψx_*` | `hx`, `hk`, `hWx`, `hunit` as listed | all |
| `L244_ceiling_unit` | `hW`, `ha`, `hc`, `cls`, `hcls`, `h0size`, `h2size`, `hx`, `hunit`, `hWx`, `htop0`, `htop2` | all |

The tree build log (`/tmp/lean_tree_build.log`) shows only two `show`-linter warnings for the file (lines 127 and 130) and no unused-variable warning, consistent with the table.

## 1. Statement fidelity of `L244_ceiling_unit`

- **Conclusion.** `θ ≤ a(n − 5) ∧ θ ≤ a(κ₀ − 1) ∧ θ ≤ a(κ₂ − 3)`. At `a = 1/√(2p)`, `κ₀ = κ_{p−1}(x)`, `κ₂ = κ_p(x)` these are the three branches of the record's `min`: `(n − 4) − 1`, `κ_{p−1} − 1`, `(κ_p − 2) − 1`. Faithful.
- **`x`.** Any `x` with `IsSkew x`, `inner2 x x = 1`, `W x = (−a) • x`. This is exactly "every unit `x ∈ E₀`", `E₀` being the `−a` eigenspace in the bivector space. This is the item the commit adds over L244Sym's `L244_ceiling`, and it is delivered.
- **`IsCritical W θ`.** `∀ X Y skew, ⟨W(WX), Y⟩ + sharpBil W X Y = θ⟨WX, Y⟩`, the bilinear form of `W² + W^# = θW` on bivectors, with `sharpBil` the polarisation of `sharpQF`. It is the record's criticality. The record's "unit" is absent, which is harmless: the conclusion is homogeneous of degree one in `(W, θ, a)` (scaling `W` by `t > 0` scales `θ` and `a` by `t`), so the unit case is an instance.
- **What remains a hypothesis, and its status.**
  - `cls` with `hcls : evf k = ![−a, 0, a] (cls k)`: faithful typing of "the eigenvalues are `(−a, 0, a)`". Since `a > 0` the three values are distinct, so `cls` exists iff the spectrum lies in `{−a, 0, a}` and is then unique. Quantifying it is the three-value hypothesis itself (O2).
  - `a` general in place of `1/√(2p)`: a generalisation. The record's value is an instance once `2pa² = 1` is supplied. Owed on the INDEX as a translation, correctly.
  - Class sizes: `h0size : 2 ≤ m₀`, `h2size : 0 < m₂`, with `m₀`, `m₂` arbitrary and unrelated. The record's `(p, N − 2p, p)` is the instance `m₀ = m₂ = p`. This is more general than the record, except that `m₀ = 1` (`p = 1`) is excluded, where the record's formula still reads with `κ₀ = 0` (O1).
  - `htop0`, `htop2`: `κ₀` bounds every set of at most `m₀ − 1` slot values, and `κ₂` every set of at most `m₂`, of every normal form of `x`. As r1856 showed, the slot values are nonnegative and are the spectrum of `−ad²` at a normal form, so the least admissible `κ` is the top-`r` slot sum, which equals `κ_r(x)` once the slot multiset is identified with the spectrum of `−ad_x²`. That identification is owed and listed. The universal quantifier over normal forms is at worst stronger than the record's hypothesis, and it is not vacuous: `rowMass_cap_self` and `rowMass_cap_x` construct a normal form of `x` inside the proof, so an unsatisfiable `htop` cannot leak.
- **Verdict:** the record's (ii) at every unit `x ∈ E₀`, with the typings above. CONFIRMED WITH OBSERVATIONS.

## 2. `refl` at `⟨v,v⟩ = 0`

- `inner2 v v = 0` forces `v = 0` (`inner2_self_eq_zero`), and Lean's `c / 0 = 0` makes the coefficient `0` in any case, so `refl v = id`. My scratch screen `refl 0 y = y` compiled by `simp [refl_apply]`.
- `refl_inner`: the identity is an isometry. The Lean proof splits on `hN` and closes the degenerate branch by `simp`. Correct.
- `refl_refl`: the identity is an involution. Same split. Correct.
- `refl_self`: in the branch `⟨ψ−x, ψ−x⟩ = 0` the proof gets `ψ − x = 0`, so `refl` is the identity and `ψ = x`, which is the claimed `refl (ψ − x) ψ = x`. In the other branch, `⟨v,v⟩ = 2 − 2⟨x,ψ⟩ = 2⟨v,ψ⟩` at unit `ψ`, `x`, so the coefficient is `1` and `ψ − v = x`. Correct and meaningful in both branches.
- `refl_eigen`: at `v = 0` the conclusion is `W y = l • y`, which is `hWy`. Correct.
- `ψx_self` at `x = ψf k₀` therefore returns the unreflected frame, which is the right answer. CONFIRMED.

## 3. `refl_eigen` by hand

- Let `v`, `y` be skew with `Wv = μv`, `Wy = λy`, and `c = 2⟨v,y⟩/⟨v,v⟩`.
- Symmetry on skew pairs, `⟨Wv, y⟩ = ⟨v, Wy⟩`, gives `μ⟨v,y⟩ = λ⟨v,y⟩`, so `⟨v,y⟩(μ − λ) = 0`.
- Linearity gives `W(y − cv) = λy − cμv`.
- If `⟨v,y⟩ = 0` then `c = 0` and `cμ = cλ`. Otherwise `μ = λ` and `cμ = cλ`. Either way `W(y − cv) = λ(y − cv)`.
- The Lean proof is this argument: `hsym` from `hW.2.2.1 v y hv hy`, which is the second conjunct of `IsWeyl` (symmetry quantified over skew `X`, `Y`), `hlin` from `hW.1.1` and `hW.1.2` (additivity and homogeneity of `IsLinOp`), and `hc` by `mul_eq_zero`. Nothing else is used.
- Skewness of `v` and `y` is required: `IsWeyl`'s symmetry clause is stated only on skew pairs (by design, per WeylReal's docstring), so the lemma would not follow for a non-skew `v` or `y`.
- In the application `v = ψf k₀ − x` is a `−a` eigenvector by linearity (`hWv` in `ψx_eigen`), and skew as a difference of skew matrices. CONFIRMED.

## 4. `ψx_complete`

- Write `R = refl v`. For skew `Y`, `RY` is skew, so `ψf_complete` gives `RY = ∑_k ⟨ψf k, RY⟩ ψf k`.
- Then `Y = R(RY) = ∑_k ⟨ψf k, RY⟩ Rψf k` by linearity of `R`.
- `⟨ψf k, RY⟩ = ⟨Rψf k, R(RY)⟩ = ⟨Rψf k, Y⟩` by `refl_inner` then `refl_refl`.
- So `Y = ∑_k ⟨ψx k, Y⟩ ψx k`, the claim. The Lean proof is this chain (`e1`, `hZ`, `map_sum`, `map_smul`, `refl_inner`, `refl_refl`).
- Siblings: `ψx_skew` from `refl_skew`, `ψx_orth` from `refl_inner` and `ψf_orth`, `ψx_eigen` from `refl_eigen` with the same `evf`, `ψx_self` from `refl_self`. So `ψx` is orthonormal, complete, skew and eigen with the unchanged eigenvalue list, and `hcls` transfers verbatim. CONFIRMED.

## 5. The generic rows and caps

- `hId_gen`, `hWP_gen` are L244Frame's `hId_frame`, `hWP_frame` with `ψf` abstracted to any complete eigenframe. The proofs are line for line the same.
- `L244_rows_gen` is L244Sym's `L244_rows` at any complete skew eigenframe with a unit `ψ k₀`. It uses `rowMass_total_any`, `rowB_mass`, `rowC_mass` and `rowC_critical` directly instead of the `_frame` wrappers. The algebra (`rB − a·s01 − a·s02`, `nlinarith` for row (C)) is unchanged from what r1856 checked.
- `cap_self_gen`, `cap_other_gen` generalise L244Sym's caps, taking orthonormality `hO` as a hypothesis in place of the spectral frame's own.
- `L244_ceiling_unit` picks any `k₀` of class `0` (from `h0size`), reflects, rewrites `ψ k₀ = x` into `htop0`, `htop2`, and runs `per_vector_ceiling` and `theta_bound` exactly as L244Sym did. The final step's `per_vector_ceiling` signature was printed: its caps are `2(b00 + b01 + b02) ≤ κ₀` and `2(b02 + b12 + b22) ≤ κ₂`, and the proof supplies the second from `c2` (which is `2(b20 + b21 + b22) ≤ κ₂`) with `s02`, `s12` by `linarith`. Correct.
- L244Sym's `L244_ceiling` is now the special case `x = ψf k₀` (O3).

## 6. Axioms and satisfiability

- `#print axioms` (scratch file, `lake env lean` in `lean/` after the background tree build finished):
  - `L244_ceiling_unit`: `[propext, Classical.choice, Quot.sound]`
  - `refl_eigen`: `[propext, Classical.choice, Quot.sound]`
  - `ψx_complete`: `[propext, Classical.choice, Quot.sound]`
  - `refl_self`: `[propext, Classical.choice, Quot.sound]`
- **Satisfiability.** Joint satisfiability of the hypotheses needs a critical linear Weyl `W` with spectrum in `{−a, 0, a}`, `a > 0`, `m₀ ≥ 2`, `m₂ ≥ 1`. This class is wider than the record's symmetric family (no condition `m₀ = m₂`, no unit norm), so it is non-empty if the record's family is, and possibly otherwise.
  - `n ≤ 3`: the Weyl space is zero, so `W = 0`, every `evf k = 0`, class `0` is empty, and `h0size` fails. Vacuous.
  - `n = 4`: r1856's hand screen carries over to the wider class. Each block of `W = W⁺ ⊕ W⁻` is traceless on a 3-space, so with entries in `{−a, 0, a}` it is `0` or a permutation of `(a, 0, −a)`, and at the `0` entry criticality reads `c·a·(−a) = 0`, false. A zero `W` fails `h0size`. Vacuous (a screen, by hand).
  - `n ≥ 5`: undecided. The record says "Whether the family has a member at any n is open" and routes it to I114. I did not search (an open-ended hunt, outside the analysis-only footing).
- Individually every hypothesis is satisfiable (`isWeylOp_zero`, any `a > 0`, unit skew `x`), and none contradicts another at the level of the definitions. The theorem's content is conditional on the family exactly as the record's (ii) is. CONFIRMED WITH OBSERVATIONS (O4).

## 7. The INDEX row

- New paragraph: `refl`, `refl_inner`, `refl_refl`, `refl_skew`, `refl_self`, `refl_eigen` ("the symmetry of W forces ⟨v,y⟩ = 0 when μ ≠ λ"), `ψx` ("skew, orthonormal, complete, with the same eigenvalues and ψ_{k₀} ↦ x"), `L244_rows_gen`, `cap_self_gen`, `cap_other_gen`, `L244_ceiling_unit` ("at every unit skew x with Wx = −ax, the caps read off x's own normal forms"), "standard three axioms". Every clause matches the source and the axiom printout.
- Owed list before the commit: `a = 1/√(2p)`, the bound at every unit `x ∈ E₀`, `κ_r(x)` as a top-`r` sum, `cls` constructed. After: the second item removed. The removal is correct, since `L244_ceiling_unit` delivers it.
- The remaining three items are accurate as a list of what separates the Lean from the record's sentence. Two refinements: the `cls` item is a one-line definition (`cls k = 0, 1, 2` according as `evf k = −a, 0, a`) given the three-value spectrum, rather than a mathematical gap (O2), and the `p = 1` corner is not on the list (O1).
- The status `partial` stays right, since the `κ_r` identification and the `a` translation are open. CONFIRMED WITH OBSERVATIONS.

## The falsifier

The object that would refute the claim is a critical linear Weyl `W` with spectrum in `{−a, 0, a}`, `a > 0`, `m₀ ≥ 2`, `m₂ ≥ 1`, and a unit skew `x` with `Wx = −ax` at which `θ > a(n − 5)`, or `θ > a(κ₀ − 1)`, or `θ > a(κ₂ − 3)` for admissible `κ₀`, `κ₂`. The theorem is machine-checked on the standard three axioms, so such an object exists only if a definition misreads the record. I looked for that misreading instead: the degenerate reflection (`x = ψ_{k₀}`, section 2), the skewness requirement on the symmetry clause (section 3), the transfer of `hcls` and of the `κ` hypotheses from `ψf k₀` to `x` (sections 4, 5), vacuity of the `κ` hypotheses (section 1, a normal form is constructed in the proof), and vacuity of the whole (section 6). None opens.

## Verdict

**CONFIRMED WITH OBSERVATIONS.** `L244_ceiling_unit` is Lemma L244 (ii) at every unit `x` of the negative eigenspace, at a general `a > 0` and general class sizes `m₀ ≥ 2`, `m₂ ≥ 1`, with the `κ` values as slot-sum bounds, on the standard three axioms. The Householder mechanism is correct in every case, and the INDEX row is accurate.

## Observations

- **O1.** `h0size : 2 ≤ m₀` excludes `p = 1`. There the record's `E₀` cap is over `E₀ ∩ x^⊥ = 0`, giving `b_{0b} = 0` for every `b` and `K ≤ 2b₀₂ = 0`, so `θ ≤ −a`. The Lean needs `0 < m` in `twice_rowMass_le_of_top`. Either add the corner (it follows from the rows with `b₀₀ = b₀₁ = b₀₂ = 0` and needs no Ky Fan cap) or state "`p ≥ 2`" beside the owed list. Minor, since the symmetric family at `p = 1` is a single pair of eigenvectors and plays no role in the `n = 12` arithmetic.
- **O2.** The owed item "the labelling `cls` constructed from W's three eigenvalues rather than quantified" is a definition. Since `a > 0` makes `−a, 0, a` distinct, `hcls` is equivalent to "every eigenvalue of `W` lies in `{−a, 0, a}`", which is the record's setting, and `cls` is then unique. Suggest rewording it to "`cls` defined from `evf` (routine)" so the owed list reads as the two substantive items, the `a` translation and the `κ_r` identification.
- **O3.** Duplication. `hId_gen`, `hWP_gen` restate L244Frame's `hId_frame`, `hWP_frame` at a general frame, `L244_rows_gen`, `cap_self_gen`, `cap_other_gen` restate L244Sym's `L244_rows`, `cap_self`, `cap_other`, and L244Sym's `L244_ceiling` is the case `x = ψf k₀` of `L244_ceiling_unit`. The `_frame` and L244Sym versions could be one-line corollaries of the `_gen` ones. Cosmetic.
- **O4.** Non-vacuity is inherited from the record: the hypotheses are jointly unsatisfiable at `n ≤ 4` (section 6, by hand), and undecided at `n ≥ 5` pending I114. The Lean class is wider than the record's family (`m₀ ≠ m₂` allowed, no unit norm), so a member of the wider class that is not symmetric would make the theorem non-vacuous while leaving (ii) vacuous. Worth one sentence in the INDEX row.
- **O5.** The two `show` tactics at [L244Unit.lean:127](../lean/HamiltonsCubic/Results/L244Unit.lean#L127) and [L244Unit.lean:130](../lean/HamiltonsCubic/Results/L244Unit.lean#L130) trip the style linter, as the same lines in L244Frame do. Cosmetic.
