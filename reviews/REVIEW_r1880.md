# r1880: Gate 2 on L222Xi, item 5's infinitesimal form of Lemma L222

*Reviewer r1880, 2026-09-28, target [L222Xi.lean](../lean/HamiltonsCubic/Results/L222Xi.lean) at commit f2b67c75. Analysis-only footing: the one computation run is a seconds-long numeric screen at n = 4 on objects built for it, reported as a screen and cited as evidence for no positive claim. The Lean check is `#print axioms` against an olean newer than the source.*

| Claim | Verdict |
|---|---|
| `rot_phi`: `R_φ · (coordOp w + ν_x) = coordOp e + cos 2φ D⁻_y + sin 2φ ν_y + cos 2φ ν_x − sin 2φ D⁻_x` | CONFIRMED WITH OBSERVATIONS |
| `xi_W`: the derivative at 0 is `2 ν_y − 2 D⁻_x`, stated weakly | CONFIRMED WITH OBSERVATIONS |
| `xi_D`: `ξ · coordOp w = ν_{K_j· − K_k·}`, of character `ε_j ε_k` | CONFIRMED WITH OBSERVATIONS |
| `xi_nu`: `ξ · ν_x = −2 D⁻_x`, of character 1, `‖ξ · ν_x‖² = 4 ‖ν_x‖²` | CONFIRMED WITH OBSERVATIONS |
| INDEX row and findings note: every item of L222 kernel-checked | CONFIRMED WITH OBSERVATIONS |

**Summary.** The file says what item 5's first sentence says, with the record's normalisation of ξ and the factor 2 from the double angle, and the hand derivation, the screen and the axioms all agree with it. The observations concern form (weak derivative, membership typed as character only) and unused generality.

## Conventions

- `Rot j k c s` sends `e_j ↦ c e_j + s e_k` and `e_k ↦ −s e_j + c e_k` ([PairSquare.lean:76](../lean/HamiltonsCubic/Results/PairSquare.lean#L76)), so `R_φ = I + φ ξ + O(φ²)` with `ξ e_j = e_k`, `ξ e_k = −e_j`, which is the record's ξ.
- `rotR U V = X ↦ U V(Uᵀ X U) Uᵀ` ([FrameOp2.lean:45](../lean/HamiltonsCubic/Results/FrameOp2.lean#L45)), the natural action `Ad_U ∘ V ∘ Ad_U⁻¹` on `Λ²`. Its derivative along `R_φ` at 0 is `[Λ²ξ, V]`, the record's `ξ · W = [Λ²ξ, W]` in item 5's proof.
- `nuX j k x = X ↦ S X D + D X S`, `S = E_jk + E_kj`, `D = diag(vy j k x)` ([PairSquare.lean:326](../lean/HamiltonsCubic/Results/PairSquare.lean#L326)), and `vy` zeroes the coordinates `j, k` ([DiagSquare.lean:88](../lean/HamiltonsCubic/Results/DiagSquare.lean#L88)). `ν_x φ_ja = x_a φ_ka`, `ν_x φ_ka = x_a φ_ja`.
- `Dminus j k y = u (vy y)ᵀ + (vy y) uᵀ`, `u = e_j − e_k` ([DiagSquare.lean:91](../lean/HamiltonsCubic/Results/DiagSquare.lean#L91)): weight `y_a` at `(j, a)`, `−y_a` at `(k, a)`.
- `innerOp2`, `normSq2` as in [Bivectors2.lean:279](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279), definite by `normSq2_eq_zero`.

## The record's item 5, quoted

From [second-order.md](../findings/second-order.md), Lemma L222, Statement: *"Let ξ ∈ 𝔰𝔬(n) be the generator with ξe_j = e_k, ξe_k = −e_j."* Item 5: *"ξ·D ∈ V_{jk} with coordinates K_{ja} − K_{ka}, and ξ·ν ∈ 𝒟ₙ with ‖ξ·ν‖² = 4‖ν‖². At an angle of the (j,k)-rotation minimising ‖ν‖², with D, K and x those of the rotated tensor: ⟨x, K_{j·} − K_{k·}⟩ = 0, and ‖ν‖² ≤ ½ Σ_a (K_{ka} − K_{ja})²."* Proof step 5: *"Λ²ξ sends e_{ja} ↦ e_{ka}, e_{ka} ↦ −e_{ja}, and ξ·W = [Λ²ξ, W]. For diagonal D the commutator has entries K_{ja} − K_{ka} at (ja,ka) and (ka,ja). For ν it is diagonal with ∓2x_a at (ja),(ka), norm² 8‖x‖²."*

## Hypothesis inventory

| Theorem | Hypotheses | Used where |
|---|---|---|
| `rot_phi` | `hjk : j ≠ k`, `hw : IsWeight w`, `x`, `φ` | `hjk` in `rot_even`, `rot_Dminus`, `rot_nuX`. `hw.symm` for `evᵀ = ev`. `hw` also feeds `odd_sum_zero` into `Dminus_weight`, whose only use is `.symm` (O5). `x` unconstrained |
| `xi_W` | `hjk`, `hw`, `x`, `V` | all through `rot_phi` |
| `xi_D` | `hjk`, `hw`, `V` | `hjk`, `hw` in `xi_W` at `x = 0`, and `hw` through `odd_sum_zero` for the character clause (`nuX_char` needs `Σ vy z = 0`) |
| `xi_nu` | `hjk`, `hxv : Σ vy j k x = 0`, `V` | `hxv` in the character clause (`Dminus_weight`) and the norm clause (`normSq2_nuX`), not in the derivative clause |

`rot_phi` taking `x` with no condition is right: `rot_nuX` and `rot_Dminus` ([L224Rot.lean:83](../lean/HamiltonsCubic/Results/L224Rot.lean#L83), [L224Rot.lean:94](../lean/HamiltonsCubic/Results/L224Rot.lean#L94)) take only `hjk` and `c² + s² = 1`, and `rot_even` needs only a symmetric weight that is swap-even off `{j, k}`.

## 1. Statement fidelity

- **Normalisation and the double angle.** By `rot_Dminus`, `rot_nuX` with `c = cos φ`, `s = sin φ`, `c² − s² = cos 2φ` and `2cs = sin 2φ`, which `rot_phi` rewrites through `hc2`, `hs2`. Differentiating at 0 gives `2 ν_y − 2 D⁻_x`, and the swap-even part is fixed. The factor 2 is the double angle, and ξ is the record's ξ (Conventions). By hand: `[Λ²ξ, D⁻_y] φ_ja = Λ²ξ(y_a φ_ja) − D⁻_y φ_ka = y_a φ_ka + y_a φ_ka = 2y_a φ_ka`, so `ξ · D⁻_y = ν_{2y}`, and `ξ · D = ν_{2y} = ν_{K_j· − K_k·}` since `2y_a = w_ja − w_ka`. This is the record's *"entries K_{ja} − K_{ka} at (ja,ka)"*.
- **Weak versus strong.** `xi_W` states, for every `V`, `HasDerivAt (φ ↦ ⟨R_φ · W, V⟩) ⟨2ν_y − 2D⁻_x, V⟩ 0`. Since `innerOp2` is definite (`normSq2_eq_zero`), two candidates `L, L'` satisfying this for all `V` have `⟨L − L', V⟩ = 0` for all `V`, hence `L = L'`. In finite dimension the weak statement is also equivalent to the strong one, since the coordinate functionals of a basis are among the `⟨·, V⟩`. The docstring argues this in one clause ("determines it since the pairing is nondegenerate"), and nothing in the file proves it (O1).
- **`nuX` at `j, k`.** `nuX j k x` reads `x` only through `vy j k x`, so the values `w_jj − w_kj = −w_kj` and `w_jk − w_kk = w_jk` at `a = j, k` are discarded. The coordinates are `w_ja − w_ka` for `a ∉ {j, k}`, as the record says (*"Restricting to a ∉ {j,k} matters"*). The character proof passes through `vy_vy` to `nuX_char` on `vy z`, which is zero at `j, k`. Screen: `z_j = −0.8`, `z_k = 0.8` nonzero and the derivative still matches `ν_z` (Section 4).
- **Every D ∈ 𝒟ₙ.** `xi_D` is stated for `coordOp w` at a weight `w`. Every Weyl operator of character 1 is such a `coordOp` of a weight by `trivial_block_iff` ([L120Ident.lean:49](../lean/HamiltonsCubic/Results/L120Ident.lean#L49), up to `coordOp_eq_restrict`). The INDEX row cites it, the file's docstring does not (O3).

## 2. Hypotheses

Inventory above. On `xi_nu`: ν need not be in `V_jk`. `x_j, x_k` are invisible to `nuX` and to `Dminus` (both read `vy x`), so the norm identity is insensitive to them. `hxv` is the sum condition off `{j, k}`, which is the `V_jk` condition once `x_j = x_k = 0` is read as a convention. The ratio 4 itself needs no sum condition: `‖D⁻_x‖² = 2‖vy x‖²` holds unconditionally (`normSq2_Dminus`), and `rotR` by an orthogonal matrix is an isometry of all of `CurvOp2`, so `‖ν_x‖² = 2‖vy x‖²` holds too. The screen at `x = (0, 0, 1, 0.4)`, sum 1.4, gives ratio 4.0. `hxv` enters the norm clause only because `normSq2_nuX` carries it (O4). It is genuinely needed for "∈ 𝒟ₙ": at nonzero sum `D⁻_x` has row `j` summing to `Σ x_a ≠ 0` and is not a weight.

## 3. Sign and factor

By hand: `[Λ²ξ, ν_x] φ_ja = Λ²ξ(x_a φ_ka) − ν_x(φ_ka) = −x_a φ_ja − x_a φ_ja = −2x_a φ_ja`, and on `φ_ka` it gives `x_a φ_ka + x_a φ_ka = 2x_a φ_ka`. On `φ_jk`, `Λ²ξ φ_jk = e_k∧e_k − e_j∧e_j = 0`, and `ν_x φ_ab` has no `jk` component. So `ξ · ν_x` is diagonal with `−2x_a` at `(ja)`, `+2x_a` at `(ka)`: this is `−2 D⁻_x`, and it is the record's *"∓2x_a at (ja),(ka)"*, equivalently the note's `ξ·ν_x = D⁻_{−2x}`. The norm: `‖−2 D⁻_x‖² = 4 ‖D⁻_x‖²` (`innerOp2_smul_left/right`), `‖D⁻_x‖² = 2‖vy x‖²` (`normSq2_Dminus`), `‖ν_x‖² = 2‖vy x‖²` (`normSq2_nuX`, `rot45_Dminus` and `normSq2_rotR`, the 45° rotation an isometry). Hence `‖ξ·ν_x‖² = 8‖x‖² = 4‖ν_x‖²`, the record's figure. No sign or factor discrepancy.

## 4. Axioms and a concrete object

- `#print axioms` on `rot_phi`, `xi_W`, `xi_D`, `xi_nu`: each `[propext, Classical.choice, Quot.sound]`. The olean (18:26:46) postdates the source (18:25:21), the file is unmodified since f2b67c75, and it has no `sorry`.
- **Screen** (pure Python, seconds, central difference `h = 1e-6`). `n = 4`, `j = 0`, `k = 1`, `w = α Z + β Y` with `α = 0.8`, `β = 1.3`, `Z` the swap-even weight `w_01 = w_23 = α`, others `−α/2`, and `Y` the odd weight `w_02 = w_13 = β`, `w_03 = w_12 = −β` (row sums 0 to 1e-16). `x = (5, −3, 0.7, −0.7)`, deliberately nonzero at `j, k`. Operators built on 4×4 skew matrices from the Lean definitions verbatim.

| Check | Residual |
|---|---|
| `xi_W`: finite difference vs `2ν_y − 2D⁻_x` | 1.5e-10 (claim norm 5.9) |
| `xi_D`: vs `ν_{w_j· − w_k·}` | 3.5e-12 |
| `ν_z φ_ja` coefficient on `φ_ka` vs `K_ja − K_ka` | 2.6 = 2.6, −2.6 = −2.6 |
| `xi_nu`: vs `−2 D⁻_x` | 1.9e-12 |
| `‖ξ·ν‖² / ‖ν‖²` | 4.0 |
| derivative vs commutator `[ad ξ, ·]` for `ν` and `D` | 1.9e-12, 3.5e-12 |

## 5. The INDEX row and the note

Read against items 1 to 6 of the record:

| Item | Typed by |
|---|---|
| 1 subalgebra, rotation-preserved | `Sjk_mul`, `Sjk_mul_weyl`, `Sjk_rot` |
| 2 `ν∘ν = G_x`, both norms | `Q_nuX`, `Q_pair`, `normSq2_nuX`, `normSq2_Gy`, `normSq2_Q_pair` |
| 3 pinning, `2L_{D⁺}D⁻ = θD⁻` | `Sjk_pin_uncond`, `Sjk_odd` |
| 4 `L_{G_x}` on the odd part | `LG_Dminus`, `LG_odd`, `odd_iff` |
| 5 infinitesimal form | `xi_D`, `xi_nu` (this file) |
| 5 minimising angle | `L222_min`, `L222_min_W`, `hmin_iff` |
| 6 `θ⟨D,G_x⟩ = ⟨L_{G_x}D,D⟩` | `crit_pair` |

Nothing in items 1 to 6 is left untyped. Two readings remain untyped, and neither is owed for the lemma: that the derivative of `R_φ · W` equals the commutator `[Λ²ξ, W]` of the record's proof (O6), and the membership in `V_jk`, `𝒟ₙ` beyond the character (O2). The generality note on `normSq2_nuX`'s `hsum` is accurate, and the screen confirms the identity holds without it.

## Verdict

**CONFIRMED WITH OBSERVATIONS.** `rot_phi`, `xi_W`, `xi_D` and `xi_nu` type item 5's infinitesimal sentence with the record's ξ, sign and factor, on standard axioms, and the INDEX row's "proved" for L222 stands. **The falsifying object** would be a weight `w` and an `x` (with `x_j, x_k` nonzero, to test the `vy` truncation) at which the derivative of `R_φ · W` differs from `2ν_y − 2D⁻_x` by a sign, by the factor 2, or by a component at `a ∈ {j, k}`. I looked for it by the commutator computed by hand on `φ_ja`, `φ_ka`, `φ_jk`, and by the n = 4 screen above at a weight with both swap-even and swap-odd parts. Neither found one.

## Observations

- **O1.** `xi_W`, `xi_D`, `xi_nu` state the derivative weakly. The equivalence with the strong statement (definiteness of `innerOp2` plus finite dimension) is argued in the docstring and not proved. Since `rot_phi` is an explicit trigonometric combination, a strong `HasDerivAt` in `CurvOp2` would follow with the same proof shape, given a normed-space instance on `CurvOp2`.
- **O2.** "∈ V_jk" in `xi_D` is typed as `SignChar (setChar {j, k})` and "∈ 𝒟ₙ" in `xi_nu` as `SignChar (fun _ => 1)`. Weyl-ness is not in either conclusion, though it is one lemma away (`nuX_weyl` at `hzs`, `Dminus_weyl` at `hxv`). This matches the L222Op convention in the INDEX row, where 𝒟ₙ and V_jk are the character summands.
- **O3.** The file's `xi_D` docstring does not cite `trivial_block_iff` for the coverage of every D ∈ 𝒟ₙ. The INDEX row does. A one-clause citation in the docstring would make the file self-standing.
- **O4.** `xi_nu`'s norm clause inherits `hxv` from `normSq2_nuX`, and the ratio 4 holds without it (orthogonal `rotR` is an isometry of all of `CurvOp2`). `hxv` is needed for the character-1 clause. `x_j, x_k` are free, which is a strict generalisation of the record's `ν ∈ V_jk`.
- **O5.** `rot_phi` uses `hw` only for symmetry. `odd_sum_zero` and `Dminus_weight` are invoked to get `(Dminus j k y)ᵀ = Dminus j k y`, which `vv_sym` gives unconditionally, so `rot_phi` holds for every symmetric `w`. By reading, not checked in Lean.
- **O6.** The identification of the derivative of `φ ↦ R_φ · W` at 0 with the record's commutator `[Λ²ξ, W]` is by reading (Conventions) and untyped. The file defines `ξ · W` as the derivative, which is a legitimate typing of the record's ξ-action, and the screen checks the two agree at n = 4.
