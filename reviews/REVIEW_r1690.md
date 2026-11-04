# REVIEW r1690: L61's witness, M(5) = √(3/2) on the certificate alone (476ccb86)

**Verdict: CONFIRMED.** `witness` in [L61Witness.lean](../lean/HamiltonsCubic/Results/L61Witness.lean) builds the record's $W_0$ as CP2Real's `Wc n`, the $\mathbb{CP}^2$ Weyl operator $\sum_a\mu_a\langle\cdot,\omega_a\rangle\omega_a$ on the first four coordinates and zero elsewhere, with `normSq = 1` and `Pcubic = √(3/2)`, at every $n\ge4$. `M5_attained` is attainment on the unit sphere of $\mathcal W_5$ with no `sorry`, `L61_M5` is `L61` with `hW₀` supplied by that witness and nothing else, and `F5_eq_record` is the record's $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ on a linear Weyl operator through L50's `Pcubic_collapse`. The axiom screen puts 3/4 declarations on the standard three and `L61_M5` alone on `sorryAx`, which is `F5_nonneg`'s. Two observations, neither a defect: `F5_nonneg`'s domain `IsWeyl` is wider than `F5_eq_record`'s `IsWeylOp` and loses nothing, and [L61Statement.lean](../lean/HamiltonsCubic/Results/L61Statement.lean)'s prose still calls the witness imported and L50's identification untyped.

| # | Claim | Verdict |
|---|---|---|
| 1 | `Wc 5` is the record's $W_0$, the zero-padding of $W_{\mathbb{CP}^2}$, unit norm, $P(W_0)=\sqrt{3/2}$ | **CONFIRMED** |
| 2a | `witness` is "the witness transfers up, $M(n)\ge\sqrt{3/2}$ at every $n\ge5$" (stated from $n\ge4$) | **CONFIRMED** |
| 2b | `M5_attained` is attainment on the unit sphere of $\mathcal W_5$, no `sorry` | **CONFIRMED** |
| 3 | `L61_M5` is exactly `L61` with `hW₀` discharged, resting only on `F5_nonneg` | **CONFIRMED** |
| 4a | `F5_eq_record` states the record's $F_5$ under L50's collapse | **CONFIRMED** |
| 4b | `IsWeylOp` (linear plus `IsWeyl`) is the right hypothesis | **CONFIRMED** (observation O1) |
| 4c | The layer's `trCube` is the record's $\mathop{\mathrm{tr}}(W^3)$ | **CONFIRMED** |
| 5 | Axioms: only `L61_M5` on `sorryAx`, via `F5_nonneg` | **CONFIRMED** (screen by the repo's audit script) |
| 6 | The [lean/INDEX.md](../lean/INDEX.md) L61 statement row claims what is proved | **CONFIRMED** |
| O2 | L61Statement.lean's prose agrees with the layer after this commit | **OBSERVATION** (stale, outside the commit) |

One line: the attainment half of L61 is built from the padded $\mathbb{CP}^2$ operator and proved on the standard axioms, so $M(5)=\sqrt{3/2}$ now rests on the sum-of-squares certificate and nothing else.

## Attack line 1: `Wc 5` is the record's $W_0$

- **Definition** ([CP2Real.lean:177](../lean/HamiltonsCubic/Results/CP2Real.lean#L177)): `Wc n X = ∑ a, (mu a * inner2 X (om a)) • om a`, with `om a = sq2⁻¹ • (Emb n * J a * (Emb n)ᵀ)` and `mu = (2/√6, −1/√6, −1/√6)`.
- **The three $J_a$** are the standard $4\times4$ complex structures of one orientation, so $\{\omega_a\}$ is an orthonormal basis of $\Lambda^\pm$ on $\mathbb R^4$ and `Wc 4` is diagonal on it with eigenvalues $\mu$ and zero on the other half. That is $W_{\mathbb{CP}^2}$, the Weyl tensor with $W^+\propto\mathop{\mathrm{diag}}(2,-1,-1)$ and $W^-=0$. Which orientation the $J_a$ carry is immaterial to the record's claim, since the two choices are exchanged by a reflection and the record's orbit is under $O(5)$.
- **Zero-padding.** `Emb n` is the inclusion of the first four coordinates (`Emb n p x = if p = x then 1 else 0`). Any bivector involving index $\ge4$ has zero pairing with every $\omega_a$, so `Wc n` kills it. That is the record's "zero-padding".
- **Normalisation.** `Wc_values` ([CP2Real.lean:303](../lean/HamiltonsCubic/Results/CP2Real.lean#L303)) gives `normSq = 1`, `trCube = 1/√6`, `sharpPair = 2/√6`. By hand: $\sum\mu_a^2=(4+1+1)/6=1$, $\sum\mu_a^3=(8-1-1)/(6\sqrt6)=1/\sqrt6$, and $P=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle=3/\sqrt6=\sqrt{3/2}$, which also agrees with L50's $\langle W,W^\#\rangle=2\mathop{\mathrm{tr}}W^3$. So $\lVert W_0\rVert=1$ and $P(W_0)=\sqrt{3/2}$, the record's normalisation.
- **`witness`'s proof** rewrites `Pcubic = trCube + sharpPair` with those two values and `sqrt32 : √(3/2) = 3/√6`. No other input.

## Attack line 2: `witness` and `M5_attained`

- **`witness {n} (hn : 4 ≤ n) : IsWeyl (Wc n) ∧ normSq (Wc n) = 1 ∧ Pcubic (Wc n) = √(3/2)`.** For each $n\ge5$ this exhibits a unit element of `IsWeyl` on $\mathbb R^n$ with $P=\sqrt{3/2}$, which is exactly what $M(n)\ge\sqrt{3/2}$ needs. The range $n\ge4$ contains the record's $n\ge5$. `IsWeyl` includes the bivector-preservation clause, so the witness lies in the class the layer's $\mathcal W_n$ is.
- **`M5_attained`** states `√(3/2) ∈ {t | ∃ W : W5, IsWeyl W ∧ normSq W = 1 ∧ Pcubic W = t}`, the same set `L61` takes the greatest element of, witnessed by `Wc 5`. The audit screen puts it on the standard three, so it carries no `sorry`.
- **Linearity.** `witness` does not state `IsLinOp (Wc n)`. `Wc n` is linear by its definition (a finite sum of `inner2 X (om a)` times fixed matrices), and the set in `L61` asks only `IsWeyl`, so nothing is missing for the claim as stated.

## Attack line 3: `L61_M5`

- `L61_M5 := L61 ⟨Wc 5, witness (by norm_num)⟩`. Its type is `L61`'s conclusion verbatim, `IsGreatest {t | ∃ W : W5, IsWeyl W ∧ normSq W = 1 ∧ Pcubic W = t} (√(3/2))`, and its only argument is `hW₀`, filled by the witness.
- `L61`'s body ([L61Statement.lean](../lean/HamiltonsCubic/Results/L61Statement.lean)) uses `hW₀` for membership and `L61_bound` for the upper bound, and `L61_bound` is `bound_of_F5_nonneg hnorm (F5_nonneg W hW)`. `F5_nonneg` is the file's one `sorry`. So `L61_M5` rests on `F5_nonneg` and on proved lemmas only, which the axiom screen corroborates.

## Attack line 4: `F5_eq_record`

- **Statement.** `F5 W = 3 / 2 * normSq W ^ 3 - 9 * trCube W ^ 2` for `W : W5` with `IsWeylOp W`. `F5 W` is defined as `3/2 * normSq W ^ 3 - Pcubic W ^ 2`, and the proof rewrites `Pcubic W = 3 * trCube W` by `SecondKind.Pcubic_collapse` ([L50Coord.lean:84](../lean/HamiltonsCubic/Results/L50Coord.lean#L84)) with `Fintype.card (Fin 5) ≤ 5`. That is the record's sentence "$P(W)=3\mathop{\mathrm{tr}}(W^3)$ there", squared, and the record's $F_5$ is exactly the right-hand side.
- **`trCube` is $\mathop{\mathrm{tr}}(W^3)$.** `trCube R = innerOp (compOp R) R` with `innerOp R S = ½ ∑ᵢⱼ inner2 (R φᵢⱼ) (S φᵢⱼ)` ([WeylReal.lean:136](../lean/HamiltonsCubic/Base/WeylReal.lean#L135)). The sum runs over the $\varphi_{ij}$ with the ordered-pair doubling paid by the $\tfrac12$, so it is $\sum_{i<j}\langle W^2\varphi_{ij},W\varphi_{ij}\rangle=\mathop{\mathrm{tr}}_{\Lambda^2}W^3$ for $W$ self-adjoint on bivectors. The same pairing gives `normSq` as $\lVert W\rVert^2$ on $\Lambda^2$, and `Wc_values` is consistent with both ($\sum\mu^2=1$, $\sum\mu^3=1/\sqrt6$).
- **The hypothesis.** `Pcubic_collapse` needs linearity (`hR : IsLinOp R`) plus the four `IsWeyl` clauses, and `IsWeylOp` ([FoxProduct.lean:110](../lean/HamiltonsCubic/Base/FoxProduct.lean#L110)) is precisely `IsLinOp R ∧ IsWeyl R`. The record's $\mathcal W_5$ consists of linear operators, so `IsWeylOp` is its faithful reading.

### O1: `F5_nonneg` quantifies over `IsWeyl`, `F5_eq_record` over `IsWeylOp`

- The two domains differ by linearity, so the record form is proved on a subclass of the set the certificate is stated on. I checked that the difference is empty on everything `F5` reads.
- For skew $X$ and every $(i,j)$, the symmetry clause gives $\langle RX,\varphi_{ij}\rangle=\langle X,R\varphi_{ij}\rangle$, linear in $X$, and the first clause makes $RX$ skew, so $RX$ is determined by those coordinates. Hence any `IsWeyl` map is linear on skew inputs.
- `normSq`, `trCube` and `sharpPair` evaluate $R$ only at skew arguments (the $\varphi_{ij}$, their images, and commutators `br η (R ·)` of skew matrices). So an `IsWeyl` map and its linear extension from $\Lambda^2$ have the same `F5`, and `F5_nonneg` on `IsWeyl` is equivalent to `F5_nonneg` on `IsWeylOp`. The sorry's domain is therefore neither wider in content than the record's $\mathcal W_5$ nor a false strengthening of it.

## Attack line 5: axioms

- Screen: `python3 scripts/misc/axiom_audit.py --only L61Witness.lean` reports 4 declarations, 3/4 on the standard three (`witness`, `M5_attained`, `F5_eq_record`), and `L61_M5` on `sorryAx`. This is a screen by the repo's script, and it matches the reading of the proof terms above: `L61_M5` reaches `sorryAx` through `L61 → L61_bound → F5_nonneg` and through nothing else, since `witness` is clean.

## The INDEX row

- The edited row lists both files, keeps "One `sorry`, `F5_nonneg`", marks the attainment half PROVED through `witness`, `M5_attained` and `L61_M5`, records `F5_eq_record` as L50's identification, and files `F5_nonneg` as `out` with the reason the record gives (the $O(5)$-averaged cubic forms are not stored). Each clause matches the Lean. Status `partial` is correct while the `sorry` stands.

## O2: stale prose in L61Statement.lean (outside the commit)

- The module docstring still says of the $P=3\mathop{\mathrm{tr}}(W^3)$ identification that "That identification is L50's and is not typed here", and `L61`'s and `zero_isWeyl`'s docstrings call the witness "imported rather than built". Both are true of that file alone and now incomplete for the layer, since [L61Witness.lean](../lean/HamiltonsCubic/Results/L61Witness.lean) types the identification and builds the witness. A one-line pointer to L61Witness.lean in each place would close it. No theorem statement is affected.

## What would break the claims, and where I looked

- **A `Wc` in a different normalisation** (for example $\mu=(2,-1,-1)$ unscaled, or $\omega_a$ of norm $\sqrt2$), which would make `normSq ≠ 1` or move $P$ off $\sqrt{3/2}$. I read `mu`, `om`, `Emb` and `Wc_values` and recomputed the three values by hand.
- **A `trCube` or `innerOp` summing over all of $\mathbb R^{n\times n}$** rather than bivectors, which would make `trCube` differ from $\mathop{\mathrm{tr}}_{\Lambda^2}W^3$. I read both definitions: the sum is over the $\varphi_{ij}$.
- **A nonlinear `IsWeyl` map with $F_5<0$**, which would make `F5_nonneg` a false statement and `L61_M5` rest on it. O1's argument rules it out.
- **`L61_M5` reaching `sorryAx` through the witness**, ruled out by the proof term and the axiom screen.
