# Reviewer r1844, L220's closing converse and proved state (FourEqNu.lean, INDEX), L27's sector reduction (L27Sector.lean) and four-set sector (L27Four.lean), with the L27 row

Cold Gate 2 review of commits 236fb662, e8e8bf8d, 6ee25a50 and 978f7b36, working from the brief's verbatim quotation of [Lemma L220](../findings/second-order.md) (as changed by 05e7182f, lines 1542 to 1560, step 9 read at source) and of [Lemma L27 and L207](../findings/nondegeneracy.md), and from the Lean sources: [FourEqNu.lean](../lean/HamiltonsCubic/Results/FourEqNu.lean), [FourEq.lean](../lean/HamiltonsCubic/Results/FourEq.lean) (`Q_nu`, `fox_pair`, `Vq_zero`, `converse`, `L220_witness`), [FourProd.lean](../lean/HamiltonsCubic/Results/FourProd.lean) (`PiQ`, `nu_sq`), [L126GenBridge.lean](../lean/HamiltonsCubic/Results/L126GenBridge.lean) (`spanVec`), [FourSup.lean](../lean/HamiltonsCubic/Results/FourSup.lean), [L27Sector.lean](../lean/HamiltonsCubic/Results/L27Sector.lean), [L27Four.lean](../lean/HamiltonsCubic/Results/L27Four.lean), [L120Decomp.lean](../lean/HamiltonsCubic/Results/L120Decomp.lean) (`comp`, `sum_comp`), [L120Support.lean](../lean/HamiltonsCubic/Results/L120Support.lean) (`comp_zero`), [CompChar.lean](../lean/HamiltonsCubic/Results/CompChar.lean) (`proj_of_char`, `act_char`), [L222Op.lean](../lean/HamiltonsCubic/Results/L222Op.lean) (`foxProd2_char2`), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) (`sphereWeight`), [L126Sphere.lean](../lean/HamiltonsCubic/Results/L126Sphere.lean) (`fourSet_sigma`), [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean) (`orbitTan`, `orbit_in_pairBlock`), [L127Mult.lean](../lean/HamiltonsCubic/Results/L127Mult.lean) (`cross_top_iff`), [L127Le.lean](../lean/HamiltonsCubic/Results/L127Le.lean) (`cross_LeLin_spectrum`, `within_LeLin_spectrum`), [L127DnExcl.lean](../lean/HamiltonsCubic/Results/L127DnExcl.lean) (`dn_excl_fox`), [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean) (`LeLin`), and the L220 and L27 rows of [lean/INDEX.md](../lean/INDEX.md). Analysis-only footing. What was run: one scratch file of `#print axioms` over eleven theorems, and one scratch `example` discharging `four_sphere_lt`'s hypothesis `0 < theta`, both through `lake env lean` after the lake lock cleared, 0 errors on each (`/private/tmp/r1844/Check.lean` audit lines, `/private/tmp/r1844/Check2.lean`). Every other check is by hand. Heartbeat log: [agent_logs/review-r1844.log](../agent_logs/review-r1844.log).

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | `nu_mem'`: `aσ_A + bσ_B` is Weyl of character `χ_Q` | CONFIRMED |
| 2 | `converse_gen`: six scalar identities (with `x + y + z = 0`) give both step-3 equations, `Q(q + ν) = θ(q + ν)`, and `‖q + ν‖² = 2(x² + y² + z²) + 4a² − 4ab + 4b²` | CONFIRMED |
| 3 | `converse_rows`: each of the three rows at `θ = 6t`, `u² = t²` is critical with `‖q + ν‖² = 24t²` | CONFIRMED |
| 4 | Each row is the record's `q = tp`, `ν = ±tp` for the same permutation `p` in `nu_sq`'s signed coordinates | CONFIRMED |
| 5 | e8e8bf8d: the L220 rows read **proved** | CONFIRMED WITH OBSERVATIONS |
| 6 | `extendL_sum'`, `proj_sum'`, `eq_zero_of_extendL`, `foxProd2_sum_right` | CONFIRMED |
| 7 | `split_unique`: a vanishing sum of operators of pairwise distinct sign characters has every term zero | CONFIRMED |
| 8 | `comp_eigen`: at `M` of character `1`, `M ∘ H = cH` gives `M ∘ comp_t H = c · comp_t H` for every `t` | CONFIRMED |
| 9 | `sig`, `four_eigen_sq`: `4c² = A² + B² + C² − AB − BC − CA` at any weight | CONFIRMED |
| 10 | `sig22`, `sig_le_sphere`: at a unit sphere product the discriminant is at most `((p+q−2)/((p−1)(q−1)))² θ²` on every four distinct indices | CONFIRMED |
| 11 | `four_sphere`: `4c² ≤ ((p+q−2)/((p−1)(q−1)))² θ²` | CONFIRMED |
| 12 | `four_sphere_lt`: `4c² < θ²` at `p, q ≥ 3`, `(p, q) ≠ (3, 3)` | CONFIRMED WITH OBSERVATIONS |
| 13 | INDEX L27 row: the remaining half re-filed from `out` to `ready` by assembly over the sign group | CONFIRMED WITH OBSERVATIONS |

**Summary:** every theorem proves what it states on the standard three axioms, the three rows of `converse_rows` are the record's six equality points in its own signed coordinates, L220's **proved** state is justified for every mathematical clause with one wording repair owed on the `Wc` sentence, and L27's re-filing to `ready` is sound but its owed list omits four named bridging steps.

## 1. Attack line A: `converse_gen` and the eighteen identities of `converse_rows`

**`converse_gen`, hypotheses against the proof.**

- `h1`, `h2`, `h3` are consumed only in `hD`: `PiQ_mul` turns `q ∘ q` into `Π_Q(xx + yz + zy, yy + zx + xz, zz + xy + yx)`, `Q_nu` turns `ν ∘ ν` into `Π_Q(2a² − (−b)² − (b−a)², …)`, and after `PiQ_add'`, `PiQ_smul'` the goal splits into three scalar equations, which are `h1`, `h2`, `h3` verbatim. The patterns in the hypotheses are copied from `Q_nu` with `(x, y) := (a, b)`, so they carry `nu_sq`'s substitution `(a, b, c) ↦ (a, −b, b − a)`.
- `hA`, `hB` are consumed only in `hV`: the error `E = 2q ∘ ν − θν` is Weyl of character `χ_Q` (`isWeyl2_foxProd2`, `Dnu_char`), its pairings with `σ_A`, `σ_B` are `2·fox_pair − θ·pair_nu`, and `hA`, `hB` say both vanish, so `Vq_zero` gives `E = 0`. The right sides `θ(4a − 2b)` and `θ(−2a + 4b)` are `pair_nu`'s first two conjuncts, and the left sides are twice `fox_pair`'s.
- `hs` is needed twice: `PiQ_weight` (so `q ∈ 𝒟ₙ`, Weyl of character 1) and `fox_pair`.
- The hypotheses are also necessary, which the claim does not need but which shows they are not over-strong: `h1` to `h3` are the three values of an equality in `Π_Q` read back through `PiQ_entries`, and `hA`, `hB` are pairings of a true equation. So `converse_gen`'s hypotheses are equivalent to the two step-3 equations at `q = Π_Q(x, y, z)`, `ν = aσ_A + bσ_B`.
- The third conjunct follows from `Qop2_add`, `Q(q + ν) = Q(q) + 2q ∘ ν + Q(ν)`, and the first two, which is step 3 read backwards.

**The norm formula.** `‖q‖² = 2(x² + y² + z²)` is `normSq2_PiQ`, the cross term `⟨q, ν⟩` vanishes by `inner_char_four` (characters 1 and `χ_Q`), and `‖ν‖² = 4a² − 4ab + 4b²` is `pair_nu`'s third conjunct, the Gram matrix `[[4, −2], [−2, 4]]` evaluated at `(a, b)`. The conclusion's formula is the sum. Matches `pair_nu` exactly.

**The eighteen identities by hand.** Notation: LHS minus RHS, to be shown equal to the `linear_combination` coefficient times `(u² − t²)`. `ring` rows must give 0.

Row 1, `(x, y, z) = (2t, −t, −t)`, `(a, b) = (2u, u)`, so `(−b)² = u²`, `(b − a)² = u²`:

- `h1`: `4t² + 2t² + (8u² − u² − u²) − 12t² = 6u² − 6t²`, coefficient 6. Matches.
- `h2`: `t² − 4t² + (2u² − u² − 4u²) + 6t² = 3t² − 3u²`, coefficient −3. Matches.
- `h3`: `t² − 4t² + (2u² − 4u² − u²) + 6t² = 3t² − 3u²`, coefficient −3. Matches.
- `hA`: `2(2u·6t + u·6t) = 36tu` against `6t(8u − 2u) = 36tu`, `ring`. Matches.
- `hB`: `2(2u·6t + u·(−12t)) = 0` against `6t(−4u + 4u) = 0`, `ring`. Matches.
- norm: `2·6t² + (16u² − 8u² + 4u²) − 24t² = 12u² − 12t²`, coefficient 12. Matches.

Row 2, `(x, y, z) = (−t, 2t, −t)`, `(a, b) = (u, 2u)`, so `(−b)² = 4u²`, `(b − a)² = u²`:

- `h1`: `t² − 4t² + (2u² − 4u² − u²) + 6t² = 3t² − 3u²`, coefficient −3. Matches.
- `h2`: `4t² + 2t² + (8u² − u² − u²) − 12t² = 6u² − 6t²`, coefficient 6. Matches.
- `h3`: `t² − 4t² + (2u² − u² − 4u²) + 6t² = 3t² − 3u²`, coefficient −3. Matches.
- `hA`: `2(u·(−12t) + 2u·6t) = 0` against `6t(4u − 4u) = 0`. Matches.
- `hB`: `2(u·6t + 2u·6t) = 36tu` against `6t(−2u + 8u) = 36tu`. Matches.
- norm: `12t² + (4u² − 8u² + 16u²) − 24t² = 12u² − 12t²`, coefficient 12. Matches.

Row 3, `(x, y, z) = (−t, −t, 2t)`, `(a, b) = (u, −u)`, so `(−b)² = u²`, `(b − a)² = 4u²`:

- `h1`: `t² − 4t² + (2u² − u² − 4u²) + 6t² = 3t² − 3u²`, coefficient −3. Matches.
- `h2`: `t² − 4t² + (2u² − 4u² − u²) + 6t² = 3t² − 3u²`, coefficient −3. Matches.
- `h3`: `4t² + 2t² + (8u² − u² − u²) − 12t² = 6u² − 6t²`, coefficient 6. Matches.
- `hA`: `2(u·6t + (−u)(−12t)) = 36tu` against `6t(4u + 2u) = 36tu`. Matches.
- `hB`: `2(u·(−12t) + (−u)·6t) = −36tu` against `6t(−2u − 4u) = −36tu`. Matches.
- norm: `12t² + (4u² + 4u² + 4u²) − 24t² = 12u² − 12t²`, coefficient 12. Matches.

All eighteen agree with the file's coefficients. Rank one, r1841 O4, checked on row 1: the `σ_A` equation gives `a = 2b` and the `σ_B` equation `12ta − 24tb = −12ta + 24tb` gives `a = 2b` again.

Finding: none against claims 1 to 3.

## 2. Attack line B: the rows in the record's coordinates

- `nu_sq` writes `ν = aσ_A + (−b)σ_B` with `(a, b, c)`, `a + b + c = 0`, so a Lean pair `(α, β)` in `ν = ασ_A + βσ_B` has signed coordinates `(α, −β, β − α)`.
- These are `spanVec`'s coordinates, `spanVec(x, y, z) = x e_ij⊙e_kl + y e_ki⊙e_jl + z e_il⊙e_jk`, with `σ_A = (1, 0, −1)` and `σ_B = (0, −1, 1)` there (r1826 O1). Their first slot is the pairing `ij|kl`, the same slot as `PiQ`'s `x`, so `q` and `ν` are read in one coordinate system, as the record's "in the pairing coordinates" requires. The square pattern of `nu_sq` is the record's step 2 pattern `x = 2a² − b² − c²` with `a` in that slot.
- Row 1: `(α, β) = (2u, u)` gives `(2u, −u, −u) = u(2, −1, −1)`, and `q = t(2, −1, −1)`. Same `p`, `ν = ±tp`.
- Row 2: `(α, β) = (u, 2u)` gives `(u, −2u, u) = −u(−1, 2, −1)`, and `q = t(−1, 2, −1)`. Same `p`, `ν = ∓tp`, and `u = ±t` covers both signs.
- Row 3: `(α, β) = (u, −u)` gives `(u, u, −2u) = −u(−1, −1, 2)`, and `q = t(−1, −1, 2)`. Same `p`, `ν = ∓tp`.
- With `u = ±t` each row is two points, six in all, the record's six.

Finding: none against claim 4. See O4 for the record's `e_ik⊙e_jl` sign, which is r1826 O1 and not new.

## 3. Attack line C: the **proved** state of L220

Clause by clause of the statement as changed by 05e7182f:

| Clause | Lean | Covered |
| --- | --- | --- |
| `n ≥ 5`, `Q = {i,j,k,l}` | six distinctness hypotheses, so `n ≥ 4` | yes, stronger (r1839 O3) |
| unit critical `W = D + ν` in `𝒮_Q`, `ν ∈ V_Q`, `ν ≠ 0`, `θ > 0` | `IsWeyl2 D`, `SignChar 1 D`, `IsWeyl2 ν`, `SignChar χ_Q ν`, `ν ≠ 0`, `Qop2 W = θW`, `normSq2 W = 1`, `0 < θ` | yes, character 1 Weyl is `𝒟ₙ` by `trivial_block_iff`, and `Q(W) = θW` at unit `W` is the programme's criticality with `θ = P(W)` |
| `θ ≤ √(3/2)` | `L220_bound`, `θ² ≤ 3/2` with `θ > 0` | yes |
| equality only at the listed points | `L220_eq_points`: `r = 0` (`D` is `coordOp (PiQ …)`), `q = tp`, `ν = ±tp`, `t = θ/6` | yes, and `θ = √(3/2)` gives `t = 1/√24` |
| each listed point attains equality | `converse_rows` at `t = 1/√24`: `Q(W) = √(3/2)W`, `‖W‖² = 1` | yes, see O1 |
| the six placements of padded `W_CP²` on `Q` | none | see O2 |
| `n ≥ 12`: `sup P = Θₙ` on the unit sphere of `𝒮_Q`, attained only on `𝒟ₙ` | `L220_sup_even` (even `n ≥ 12`), `L220_sup_odd` (odd `n ≥ 13`), three conjuncts each | yes, `n = 12` is even so the odd statement's `13` loses nothing |

"Exactly" is the conjunction of `L220_eq_points` (only these) and `converse_rows` (all of these). "Attained only on 𝒟ₙ" is the third conjunct of each sup theorem with `trivial_block_iff`, as r1841 checked.

On the `Wc` sentence. The INDEX says "the name padded `W_CP²` is the record's description of the six operators, argued in its step 9, and a comparison with CP2Real's `Wc` would be a separate statement outside L220". The first half is accurate: after 05e7182f the equality set is named by its coordinates, and the appositive describes it, with step 9 arguing the description (a permutation of `Q` permutes the pairings, the flip at one index of `Q` negates `ν`). The second half is inaccurate as worded: the appositive sits inside L220's statement, so the identification is part of L220 as written, untyped, and not outside it. It carries no weight in the inequality, the equality set or the `n ≥ 12` clause. The layer already holds what a typed identification would use: [CP2Real.lean](../lean/HamiltonsCubic/Results/CP2Real.lean)'s `Wc`, `Wc_theta` (`θ = √(3/2)`) and [L167Full.lean](../lean/HamiltonsCubic/Results/L167Full.lean)'s `Wc_blk` (`Wc n = pad (Wc 4 ∘ blk)`). See O2.

Verdict on claim 5: the proved state is justified for every clause that carries mathematical content, with the `Wc` sentence to be reworded (O2).

## 4. Attack line D: `split_unique` and `comp_eigen`

**`split_unique`.** Apply `proj t ∘ extendL` to `∑_s A_s = 0`. `extendL_sum'` and `proj_sum'` distribute. For each `s`, `act_char` turns `SignChar (setChar s) (A s)` into the equivariance `proj_of_char` needs, which gives `proj t (extendL (A s)) = if t = s then extendL (A s) else 0`. The erased sum is zero termwise and the surviving term is `extendL (A t) = 0`, so `eq_zero_of_extendL` gives `A t = 0`. The "pairwise distinct characters" is carried by indexing over all `s : Finset ι` with `setChar s`, which `setChar_sep` inside `proj_of_char` separates. Correct.

**`comp_eigen`.** With `A_s = M ∘ comp_s H + (−c) comp_s H`: `foxProd2_char2` gives `M ∘ comp_s H` the character `1 · χ_s = χ_s` (the `signChar_congr` step with `one_mul`), and `comp_char` gives `comp_s H` the character `χ_s`. `∑_s A_s = M ∘ ∑_s comp_s H − c ∑_s comp_s H = M ∘ H − cH = 0` by `foxProd2_sum_right`, `sum_comp`, `heig`. `split_unique` gives each `A_t = 0`. Correct.

**What the reduction needs.** An eigenvector of `L_e` splits into its character components, each an eigenvector of the same value or zero. That is exactly `comp_eigen` with `M = P(e)⁻¹ e`, since `LeLin a v = foxProd2 (P(a)⁻¹ • a) v` in [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean), and a scalar multiple of a character-1 operator has character 1.

**The hypotheses.** Character 1 on `M` is the right one: a sphere product is `coordOp (t • sphereWeight T)`, a coordinate-diagonal weight, which has character 1 by `trivial_block_iff` (as `four_eigen_sq`'s proof itself uses for `r`). `M` is required to be Weyl nowhere, neither in `comp_eigen` nor in `split_unique` nor in `foxProd2_char2`. `H` must be Weyl because `comp` is defined on Weyl operators, which is harmless since `L_e` acts on `W⊥ ⊂ 𝒲ₙ`. The components off `|t| ∈ {0, 2, 4}` are zero by `comp_zero`, so the statement's "for every `t`" is trivially true there.

Finding: none against claims 6 to 8.

## 5. Attack line E: `four_eigen_sq` and `sig_le_sphere`

**`four_eigen_sq` in general.** The proof sets `q = Π_Q((s₁ − m)/2, (s₂ − m)/2, (s₃ − m)/2)` with `m` the mean of the pairing sums, shows `r = w − q` is a weight orthogonal to `Π_Q` (the `linear_combination m * habc` step is `inner_PiQ` on `r` reduced by `x + y + z = 0`), then `Lq_eigen` gives `2q ∘ ν = 2cν` and `step5` gives `(2c)² = 3‖q‖² = 6∑((sᵢ − m)/2)² = (3/2)∑(sᵢ − m)²`. Since `∑(sᵢ − m)² = ∑sᵢ² − (∑sᵢ)²/3 = (2/3)(∑sᵢ² − ∑sᵢsⱼ)`, this is `sig(A, B, C)`. Correct for every weight.

**At one explicit weight, by hand.** `w = Π_Q(1, −1/2, −1/2)` (row sums `1 − 1/2 − 1/2 = 0`, hollow, symmetric, so a weight). `A = 2`, `B = C = −1`, `sig = 4 + 1 + 1 + 2 − 1 + 2 = 9`, so `4c² = 9`. Directly: `fox_pair` at `(x, y, z) = (1, −1/2, −1/2)` gives the pairing matrix `[[3, 3], [3, −6]]` against the Gram `[[4, −2], [−2, 4]]`, and `det(M − cG) = (3 − 4c)(−6 − 4c) − (3 + 2c)² = 12c² − 27`, so `c² = 9/4`, `4c² = 9`. Agrees.

**`ν ≠ 0`.** Needed: at `ν = 0` the eigen-equation holds for every `c`. It enters through `step5`.

**The sixteen membership patterns.** `sig` is symmetric in its three arguments, so a relabelling only has to produce the same multiset `{A, B, C}` up to `w`'s symmetry.

| Pattern `(i, j, k, l) ∈ T` | Case in the proof | Value |
| --- | --- | --- |
| TTTT, FFFF | `simp` | `A = B = C` (`2α` or `2β`), so 0 |
| TTTF, TTFT, TFTT, FTTT | `simp` | `A = B = C = α + γ`, so 0 |
| TFFF, FTFF, FFTF, FFFT | `simp` | `A = B = C = β + γ`, so 0 |
| TTFF | `sig22 … i j k l` | `sig(w_ij + w_kl, w_ik + w_jl, w_il + w_jk)`, the target |
| FFTT | `sig22 … k l i j` | `sig(w_kl + w_ij, w_ki + w_lj, w_kj + w_li)`, same multiset |
| TFTF | `sig22 … i k j l` | `sig(w_ik + w_jl, w_ij + w_kl, w_il + w_kj)`, first two swapped |
| FTFT | `sig22 … j l i k` | `sig(w_jl + w_ik, w_ji + w_lk, w_jk + w_li)`, first two swapped |
| TFFT | `sig22 … i l j k` | `sig(w_il + w_jk, w_ij + w_lk, w_ik + w_lj)`, a cyclic shift |
| FTTF | `sig22 … j k i l` | `sig(w_jk + w_il, w_ji + w_kl, w_jl + w_ki)`, a cyclic shift |

Here `α = t·|Tᶜ|/(|T| − 1)` is `t·sphereWeight` inside `T`, `β = t·|T|/(|Tᶜ| − 1)` inside `Tᶜ`, and `γ = −t` across. The (2,2) patterns are six, not three: three pairings each met twice (a set and its complement), all giving the same discriminant. The `try simp only [hs …]` and the `ring` fallback close the `w_ba`/`w_ab` and argument-order differences. The (3,1), (4,0) and (0,4) patterns give `A = B = C` as the table shows.

**The (2,2) value by hand.** With `B = C = 2γ`, `sig = (A − B)² = (α + β + 2t)²` in units with `γ = −t`, and `α + β + 2t = t(n − 1)(n − 2)/((p − 1)(q − 1))`. With `θ = t(n − 1)` (the critical value of `sphere_isCritical` at unit norm) this is `((n − 2)/((p − 1)(q − 1)))² θ²`, the right side, so `c = ±μθ`, `μ = (n − 2)/(2(p − 1)(q − 1))`, the record's `±μ`.

Finding: none against claims 9 to 11.

## 6. Attack line F: `four_sphere_lt`

- `(p − 2)(q − 2) ≥ 2` off `(3, 3)`: with `a = p − 2 ≥ 1`, `b = q − 2 ≥ 1`, not both 1, one factor is at least 2 and the other at least 1. The proof's three-way case split is this.
- Then `p + q − 2 < (p − 1)(q − 1)` is `(p − 1)(q − 1) − (p + q − 2) = (p − 2)(q − 2) − 1 ≥ 1 > 0`, so the ratio is in `[0, 1)`, its square is below 1, and `4c² ≤ ratio² θ² < θ²` needs `θ² > 0`. Correct.
- `hθ : 0 < theta (…)` is used only for `θ² > 0`, and without it the strict inequality fails at `θ = 0`. It is stated honestly, as an explicit hypothesis in the signature. It is dischargeable: the scratch `example` in `/private/tmp/r1844/Check2.lean` proves `0 < theta (diagOp (t • sphereWeight T))` from `3 ≤ |T|`, `3 ≤ |Tᶜ|`, `0 < t` and unit norm, through `theta_of_critical_unit (sphere_isCritical …)`, which gives `θ = t(n − 1)`. Compiled with 0 errors. See O3.
- The docstring says `|c| < θ/2`, and the statement is `4c² < θ²`, the same thing. With `L_e = P(e)⁻¹ e ∘` and `P(e) = θ` at a unit critical `e`, this is `|L_e| < 1/2` on every four-set block, the record's `1/2 − μ > 0`.

Finding: none against claim 12. O3 records the discharge.

## 7. Attack line G: the L27 re-filing

**Whether the sign group suffices.** Yes. The route is: `L_e` is self-adjoint on `W⊥` (`inner_fox_move`, `LeLin_mapsTo`), so `λ_max` is attained at an eigenvector, and `comp_eigen` splits any eigenvector into eigenvectors of the same value on `𝒟ₙ`, the pair blocks and the four-set blocks, all other characters carrying zero. Each sector's spectrum is then read off typed lemmas: `𝒟ₙ` has the values `θ`, `θ(p−2)/(2(p−1))`, `θ(q−2)/(2(q−1))` and a negative one (`dn_excl_fox`), with `θ` only on `e` (`dn_eig_line`), which `W⊥` removes. Within pair blocks have `0`, `(p−2)/(2(p−1))`, `−μ` (`within_LeLin_spectrum`). Cross pair blocks have `0` and `1/2` (`cross_LeLin_spectrum`), with `1/2` on one line (`cross_top_iff`). Four-set blocks have `|L_e| ≤ μ < 1/2` (`four_sphere_lt`). Nothing uses irreducibility under `O(p) × O(q)`: every block's spectrum is computed, so Nienhaus Proposition 4.6 only matches the answer to the ten summands. The re-filing to `ready` is right.

**Steps not typed and not listed as owed in the row.** The row owes "the pair blocks … once a character-`ε_jε_k` component is written on the pair span, and the assembly itself". These further steps are needed and are not named:

1. **The `1/2` line is the orbit tangent.** `cross_top_iff` gives the `1/2` space as the `c` constant on each factor with `∑c = 0`. `orbit_in_pairBlock` gives `orbitTan (diagOp w) j k = ∑ᵢ (w_ji − w_ki) f_i`, whose coefficients at `j ∈ T`, `k ∉ T` are `t(n−1)/(p−1)` on `T` and `−t(n−1)/(q−1)` on `Tᶜ`, constant per factor with sum zero, so they lie on that line. I checked this by hand. No lemma states it. [L127Mult.lean](../lean/HamiltonsCubic/Results/L127Mult.lean)'s docstring calls the dimension count prose.
2. **`dim(orbit) = pq`.** This needs `orbitTan … j k = 0` for `j, k` in one factor (the coefficients `w_ji − w_ki` vanish there, by the same formula) and `orbitTan … j k ≠ 0` and independent across cross pairs (distinct characters, `split_unique`). `cross_count_eq_orbit_dim` in [L127Statement.lean](../lean/HamiltonsCubic/Results/L127Statement.lean) is a count of pairs only.
3. **The bridge between the four-set statement and `LeLin`.** `four_sphere_lt` is stated for `foxProd2 (coordOp w)` against `theta (diagOp w)`, while the pair-block lemmas are stated for `LeLin (restrict (diagOp_isWeyl …))`. The assembly needs `coordOp w = restrict (diagOp_isWeyl hw)` (`coordOp_eq_restrict`) and `Pcubic2` of it equal to `theta (diagOp w)` at unit norm, as `cross_LeLin_spectrum`'s proof does internally with `theta_of_unit`. The same bridge applies to `dn_excl_fox`, stated on `foxProd` and `diagOp`.
4. **The discharge of `hθ`** in `four_sphere_lt`, one line (O3).

The Morse–Bott sentence itself, "so `S^p × S^q` is Morse–Bott nondegenerate", runs from `E(1/2) = T(orbit)` through the relation between the Hessian of `P` on the sphere and `L_e`, which the row does not mention either. That may be intended as part of "the assembly", but the row should say so. See O5.

Verdict on claim 13: the re-filing is right and the typed pieces are what the route needs. The owed list is incomplete as written.

## 8. Attack line H: hypothesis inventory and axioms

`#print axioms` in `/private/tmp/r1844/Check.lean`, after the lake lock cleared: `converse_rows`, `converse_gen`, `L220_eq_points`, `comp_eigen`, `split_unique`, `four_eigen_sq`, `sig_le_sphere`, `four_sphere`, `four_sphere_lt`, `L220_sup_even`, `L220_sup_odd` each depend on `[propext, Classical.choice, Quot.sound]` only. The four errors in that file's output all come from a trailing `example` with a missing `open`, which was rerun correctly as `Check2.lean` with 0 errors.

Hypothesis inventory:

- `converse_gen`: the six distinctness hypotheses, `hs`, and the five scalar identities `h1`, `h2`, `h3`, `hA`, `hB` (the brief's "six scalar hypotheses" counts `hs` among them). All used, none vacuous.
- `converse_rows`: the distinctness hypotheses and `u² = t²`. No sign on `t`, which is correct since the rows are critical for every `t`, and `θ = 6t < 0` at `t < 0` is r1835 O4's reading.
- `comp_eigen`: `M` of character 1, `H` Weyl, the eigen-equation. No Weyl on `M`, no self-adjointness, no norm.
- `four_eigen_sq`: `w` a weight, `ν` Weyl of character `χ_Q`, `ν ≠ 0`, the eigen-equation, distinctness.
- `four_sphere_lt`: `3 ≤ |T|`, `3 ≤ |Tᶜ|`, not both 3, `0 < t`, unit norm, `0 < θ` (dischargeable), `ν` as above.

## 9. Attack line I: what would break each statement, and what I did to look

- **`converse_gen`, `converse_rows`.** A row where `Q(q + ν) ≠ 6t(q + ν)`, or a row not equal to the record's `tp`, `±tp`. I recomputed all eighteen scalar identities and all three rows' signed coordinates by hand, and checked the Gram and pairing formulas they rest on against `pair_nu` and `fox_pair`. Nothing found.
- **L220 proved.** A unit critical point with `θ² = 3/2` off the list (excluded by `L220_eq_points`, whose case split I read), a listed point that is not unit or has `ν = 0` (at `t = 1/√24`, `‖W‖² = 24t² = 1` and `‖ν‖² = 12t² > 0`), or a clause of the statement with no theorem (only the appositive, O2).
- **`split_unique`, `comp_eigen`.** An operator of character `χ_s` with a nonzero `proj_t` for `t ≠ s`, or a character-1 `M` whose product changes a component's character. Both are excluded by `proj_of_char` and `foxProd2_char2`, whose statements I read. Nothing found.
- **`four_eigen_sq`.** A weight where `4c² ≠ sig`. I derived the identity from `step5` in general and checked it at `Π_Q(1, −1/2, −1/2)` both ways. Nothing found.
- **`sig_le_sphere`, `four_sphere`.** A membership pattern mishandled, or a (2,2) relabelling that permutes `w`'s arguments into a different multiset. I tabulated all sixteen. Nothing found.
- **`four_sphere_lt`.** A pair `(p, q)` with `p, q ≥ 3` off `(3, 3)` and `μ ≥ 1/2`. By hand at `(3, 4)`, `μ = 5/12`, and in general `1/2 − μ = ((p−2)(q−2) − 1)/(2(p−1)(q−1)) ≥ 1/(2(p−1)(q−1))`. This is a screen, not evidence beyond the kernel check.
- **The L27 re-filing.** A sector whose spectrum is not typed, or a value `≥ 1/2` in `W⊥` off the cross lines. I read the statements of `dn_excl_fox`, `cross_LeLin_spectrum`, `within_LeLin_spectrum`, `cross_top_iff`, `orbit_in_pairBlock`. The spectra are all below `1/2` off the cross lines. The gaps are in the bridging (O5), not in the spectra.

## Observations

- **O1.** No single theorem states that each row at `t = 1/√24` is a unit critical point with `ν ≠ 0` and `θ = √(3/2)`. `L220_witness` states it for row 1 at `u = t`. For the other five points it is one line from `converse_rows` (`‖W‖² = 24t² = 1`, `‖ν‖² = 12u² ≠ 0`). Harmless, and optional to type.
- **O2.** The INDEX sentence "a comparison with CP2Real's `Wc` would be a separate statement outside L220" should be reworded. The appositive "the six placements of padded `W_CP²` on `Q`" is inside L220's statement, is argued in step 9, and is untyped. Suggested wording: "the appositive naming the six operators padded `W_CP²` is argued in step 9 and is untyped, and it carries no weight in the inequality, the equality set or the `n ≥ 12` clause". Typing it would use `Wc`, `Wc_theta` and `Wc_blk`, showing that row 1 at `u = t = 1/√24` on `Q = {0, 1, 2, 3}` equals `Wc n` up to the frame and sign conventions. The **proved** state stands either way, because the record names the equality set by its coordinates since 05e7182f.
- **O3.** `four_sphere_lt`'s `hθ` is dischargeable in four lines: `theta_of_critical_unit (sphere_isCritical T _ _ t) hn` rewrites `θ` to `t(|T| + |Tᶜ| − 1)`, positive at `t > 0`, `|T| ≥ 3`. The hypothesis could be dropped from the signature, and the INDEX row's "and `θ > 0`" would then go too.
- **O4.** The record's setting writes `b` on `e_ik⊙e_jl`, while `spanVec`'s second term is `e_ki⊙e_jl`. Only the latter makes `a + b + c = 0` the Bianchi condition and makes `ν = ±tp` hold at the same `p` as `q`. This is r1826 O1, recorded in the INDEX, and I repeat it only because the record's equality clause now names coordinates, so the record's setting sentence could carry the sign as well.
- **O5.** The L27 row's owed list should add, by name: the identification of `cross_top_iff`'s `1/2` line with `orbitTan` through `orbit_in_pairBlock`; `dim(orbit) = pq` as the vanishing of within-factor `orbitTan` and the independence of the cross ones; the `coordOp`/`LeLin` and `Pcubic2`/`theta (diagOp …)` bridge for `four_sphere_lt` and `dn_excl_fox`; and the Hessian-to-`L_e` step behind "Morse–Bott nondegenerate". None of these needs `O(p) × O(q)` representation theory, so they do not affect the re-filing to `ready`.
- **O6.** The row's "`sig_le_sphere` … equal at a `(2,2)` split and `0` at the other fourteen membership patterns" is wrong in its count: six of the sixteen patterns are (2,2) splits and ten give `0`. The theorem proves an inequality and is unaffected. Reword to "equal at the six `(2,2)` patterns and `0` at the other ten".

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** All thirteen claims hold. `converse_gen` and `converse_rows` are correct to the coefficient, and the three rows are the record's six equality points in its own coordinates. L220's **proved** state is justified, with O2's rewording of the `Wc` sentence owed. `split_unique` and `comp_eigen` are exactly the sign-group reduction the L27 route needs, on a character-1 `M` with no Weyl hypothesis. `four_eigen_sq`, `sig_le_sphere`, `four_sphere` and `four_sphere_lt` are correct, with `hθ` dischargeable (O3). The L27 re-filing to `ready` is right, and its owed list should name four more bridging steps (O5) and fix one count (O6). No REFUTED verdict.
