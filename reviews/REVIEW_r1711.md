# Review r1711: statement fidelity of L56Norm, L56CP and L56MultiNorm, every L56 gap figure read off an operator

Cold brief, analysis only. The kernel checks were taken as given and nothing was built (no `lake build`, no `lake env`). The only computation is a screen of a few seconds: the `Λ²` matrices of `W_{ℂP²}`, `W_{ℂP³}`, `W_{ℂP⁴}` and of `diagOp vW` at `S³×S⁹`, `S⁴×S⁴`, `(S³)⁴` and `(2,2,8)`, built in the `φ_{ij}` basis and diagonalised numerically (a scratchpad script outside the repository), reported as a screen and never as evidence for a positive claim. Log: agent_logs/review-r1711.log.

**Verdict: every typed statement in the three files is true and says what the corrected L56 block means. One reading is carried by prose rather than by a type: for the sphere products the gap is taken as the smallest modulus of the vertex ENTRIES, and the step "the `Λ²` spectrum of `diagOp w` is its set of off-diagonal entries" is proved in one direction only (`diagOp_phi`, each `φ_{ab}` an eigenvector). The converse is a two-line argument and is nowhere typed, while L56CP proves the corresponding `spec_eq` for `ℂPᵐ`. At `m = 2` the header's treatment of the zero eigenvalue is honest, and the record's own definition ("smallest nonzero modulus") gives `1/6` there against `cpGapSq 2 = 0`.**

| claim | verdict | reason |
|---|---|---|
| `row_sq`, `normSq_vertex` | CONFIRMED | `vW` row: `p-1` entries `-(n-p)/(p-1)` and `n-p` entries `1`, squares sum to `(n-p)²/(p-1) + (n-p)`. `innerOp_diagOp` gives `normSq = ½ Σ_{a,b} vW²` |
| `normSq_two` | CONFIRMED | `½(p·f(p) + q·f(q))` with `n = p+q` is `pq(n-1)(n-2)/(2(p-1)(q-1))`. Screen at `S³×S⁹`: `92.8125` both ways |
| `gapSq_eq_normalised` | CONFIRMED (type), prose PLAUSIBLE | the identity holds at every two-factor labelling. Its docstring reading, "`(p/(q-1))²` is the squared smallest modulus", needs `p < q`, which is absent from the hypotheses and supplied only by L56Weyl's `vertex_min`, which the file does not cite |
| `vertex_min_balanced` | CONFIRMED | `p/(p-1) ≥ 1` at `p ≥ 2`, a bare real inequality, linked to `vW` only through `vertex_entries` |
| `balancedGapSq_eq_normalised` | CONFIRMED | at `q = p`, `n = 2p`, `normSq_two` gives `p²(n-1)(n-2)/(2(p-1)²)`, and `1` over it is `2(n-2)/(n²(n-1))` after `(p-1)² = (n-2)²/4`. Screen at `S⁴×S⁴`: `0.0267857` both ways |
| `eigen_cases` | CONFIRMED | outside `cA ± 1`, `eigen_mul_J` forces `X = cJ`, and pairing with `J` forces `λ = cA + 1 + 2m` |
| `Xp_eigen`, `Xm_eigen` | CONFIRMED | `partner 0 = 1 ≠ 2`, so `J₀₂ = J₂₀ = 0`. `conj_phi_apply` at `(0,2)` is `J₀₂J₂₀ - J₀₀J₂₂ = 0`, so `X±(0,2) = -1 ≠ 0`. Both are skew, `frob J X± = 0`, `conj X± = ±X±` |
| `Spec`, `spec_eq` | CONFIRMED | eigenvalues on nonzero skew `X` is the `Λ²` spectrum of the self-adjoint restriction. Three values at every `m ≥ 2`. Screen: `{-2, 0, 4}` at `m = 2`, `{-1.6, 0.4, 6.4}` at `m = 3` |
| `min_modulus` | CONFIRMED | `(2m-4)/(2m-1) ≤ (2m+2)/(2m-1)` and `≤ cA+1+2m`. The inequality runs in the right direction |
| `cp_gap` | CONFIRMED at `m ≥ 3` | `((2m-4)/(2m-1))² · (2m-1)/(12m(m²-1)) = (m-2)²/(3m(m²-1)(2m-1))`. Screen at `ℂP³`: `1/360` both ways. At `m = 2` it equals the smallest modulus including `0`, which the header says |
| L56CP header on `m = 2` | CONFIRMED (honest) | it states the zero and the "including `0`" reading. It omits that the record also says the formula was "verified against the record's printed `W_{ℂP²}` spectrum", which under the record's "nonzero" definition gives `gap² = 1/6` |
| `vertex_min_multi` | CONFIRMED | `(k-1)p/(p-1) ≥ 1`: within modulus at least the across modulus `1`, strictly at `k ≥ 2` |
| `multiGapSq_closed` | CONFIRMED | `c²/(…) = 2(p-1)/(n(n-p)(n-1))`. At `(4,3)`: `4/(12·9·11) = 1/297` |
| `multiGapSq_eq_normalised` | CONFIRMED | `normSq = ½·n·((n-p)²/(p-1) + (n-p)) = n(n-p)(n-1)/(2(p-1))`. Screen at `(S³)⁴`: `297` and `1/297` |
| `beta228`, `bs228`, `vertex_min_228` | CONFIRMED | labels `0,0,1,1,2×8`, sizes `2,2,8`. Entries `-10`, `-4/7`, `1`, lower bound `4/7`. Attainment (at `(4,5)`) is true and untyped |
| `gap228_eq_normalised` | CONFIRMED | `normSq = 200 + 448/49 + 36 = 1716/7`, `(16/49)/(1716/7) = 4/3003`. Screen agrees |
| sphere-product "gap = smallest modulus of the `Λ²` spectrum" | PLAUSIBLE (true, untyped) | only `diagOp_phi` (entries are eigenvalues) is in the layer. The converse holds by `w_ab X_ab = λ X_ab` at a nonzero off-diagonal entry of `X`, and no file states it |
| INDEX: "Every figure the corrected block states is now read off an operator" | PLAUSIBLE | right for `ℂPᵐ` (spectrum typed) and right in substance for the spheres, where "read off" means off the diagonal weights |
| INDEX L56 row **proved** | CONFIRMED with two caveats | every corrected figure and ordering is typed. The caveats are the untyped converse above and the `m = 2` conflict with "nonzero" |

**One line:** the mathematics is right and the normalisation is one convention throughout (`normSq = Σ λ²` on `Λ²`, `φ_{ij}` orthonormal). Two readings live in prose: the entries-are-the-spectrum step for spheres, and `p < q` in `gapSq_eq_normalised`.

## Conventions

- `phi i j = single j i 1 - single i j 1`, `inner2 X Y = ½ tr(XᵀY)`, so `inner2 (phi i j) (phi i j) = 1` for `i ≠ j` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)).
- `innerOp R S = ½ Σ_{i,j} inner2 (R φ_{ij}) (S φ_{ij})`, `normSq R = innerOp R R = Σ_{i<j} ‖R φ_{ij}‖²`, the Hilbert–Schmidt norm of `R` on `Λ²`, equal to `Σ λ²` over the `Λ²` spectrum for self-adjoint `R`.
- `diagOp w X = w ∘ X`, `diagOp_phi`: `diagOp w φ_{ab} = w_{ab} φ_{ab}` for symmetric `w` ([Families.lean](../lean/HamiltonsCubic/Base/Families.lean)).
- `vW = -(n-1)·weylE`, `weylE` the Einstein-normalised (`Ric = 1`) Weyl weights of L56Weyl, reviewed CONFIRMED in [REVIEW_r1710.md](REVIEW_r1710.md).
- `WCPm X = cA X + J X Jᵀ + (Σ J_{ij} X_{ij}) J`, `cA = -3/(2m-1)` ([L70CPm.lean](../lean/HamiltonsCubic/Results/L70CPm.lean)). `normSq_WCPm` ([L53CPm.lean](../lean/HamiltonsCubic/Results/L53CPm.lean)) opens `HamiltonsCubic.RealLayer`, so it is the same `normSq` as L56Norm's.
- The gap is scale-invariant (`min|λ| / ‖W‖`), so the overall scale of `vW` or `WCPm` is immaterial.

## Hypothesis inventory

| theorem | hypotheses | satisfiable at the record's cases | load-bearing |
|---|---|---|---|
| `row_sq`, `normSq_vertex` | `∀ a, 2 ≤ bs β a`, `2 ≤ card ι` | yes | `hbs` keeps `p - 1 ≠ 0` |
| `normSq_two`, `gapSq_eq_normalised` | Bool labelling, `h1`, `h2` (both factors nonempty), `hbs`, `hn` | yes, every `S^p × S^q`, `p, q ≥ 2` | `h1`, `h2` make it two factors. `p < q` is absent, see §2 |
| `balancedGapSq_eq_normalised` | as above plus `heq` | yes, `S^p × S^p` | yes |
| `eigen_cases` | `1 ≤ m`, `X ≠ 0`, eigen equation | yes | `X ≠ 0` |
| witnesses, `spec_eq`, `min_modulus`, `cp_gap` | `2 ≤ m` | yes, `m = 3, 4, …` used by the record | `m ≥ 2` needed for index `2`. `m = 2` included, see §3 |
| `vertex_min_multi`, `multiGapSq_closed` | `2 ≤ k`, `2 ≤ p` | yes, `(4,3)` | `k ≥ 2` gives an across entry |
| `multiGapSq_eq_normalised` | `∀ a, bs β a = p`, `2 ≤ p`, `2 ≤ k`, `card ι = kp` | yes, e.g. `Fin 12 → Fin 4`, `a ↦ a/3`. No instance is written in the file | `hcard` fixes `k` as the factor count |
| `vertex_min_228`, `gap228_eq_normalised` | concrete | instantiated | none vacuous |

No hypothesis is vacuous and none excludes a case the corrected block uses.

## 1. Normalisation (question 1)

`normSq` is `½ Σ_{i,j}` over ordered pairs of `inner2 (Rφ_{ij}) (Rφ_{ij})` with `inner2(φ,φ) = 1`, so it is `Σ_{i<j} ‖Rφ_{ij}‖²`, the squared Hilbert–Schmidt norm on `Λ²`. For a self-adjoint operator this is `Σ λ²` over the `Λ²` spectrum with multiplicity, which is the unit normalisation the record's "normalised `Λ²` spectrum" uses: the record's own `(2,2,8)` line divides by `2(10/11)² + 36(1/11)² + 28(4/77)²` "over the 66 pairs", a sum of squared eigenvalues. L56Norm and L56CP use the same `HamiltonsCubic.RealLayer.normSq`.

**Falsifier sought:** a factor-of-two mismatch between `normSq` and `Σ λ²`. **Screen:** `Σ λ²` of the numerically built `Λ²` matrix equals the typed `normSq` at `S³×S⁹` (`92.8125`), `ℂP²` (`24`), `ℂP³` (`57.6`, the typed `12·3·8/5`) and `ℂP⁴` (`102.857`). The squared gaps come out `1/660` at `S³×S⁹` and `1/360` at `ℂP³`, both matching `gapSq 3 9` and `cpGapSq 3`. None found.

## 2. Entries versus spectrum for the sphere products (question 2)

Mathematically the `Λ²` spectrum of `diagOp w` for symmetric hollow `w` is exactly `{w_ab : a < b}`: `diagOp_phi` makes each `φ_{ab}` an eigenvector, and conversely if `w ∘ X = λX` with `X` skew and nonzero, pick `a ≠ b` with `X_ab ≠ 0` (a nonzero skew matrix has one), then `λ = w_ab`. So the files' reading is correct.

In the Lean, only the first half is present, as `diagOp_phi` in the base layer, and none of the three files cites it for the spectrum. The sphere-product "smallest modulus" statements are real inequalities between the three entry values (`vertex_min` in L56Weyl, `vertex_min_balanced`, `vertex_min_multi`) or a lower bound over the `vW` entries (`vertex_min_228`). Neither attainment at `(2,2,8)` nor the converse is typed. **The files claim more than they prove only in prose**: L56Norm's header calls `(p/(q-1))²/normSq` "the smallest vertex modulus of the unit-normalised Weyl operator, squared", which is exact as a statement about entries, and the INDEX sentence "every figure … read off an operator" leans on the untyped converse for the spheres. L56CP, by contrast, types `Spec` and `spec_eq`.

`gapSq_eq_normalised` carries no `p < q` hypothesis. The identity is true for every two-factor labelling, but at `p > q` the smallest modulus is `q/(p-1)` and at `p = q` it is `1`, so the docstring's reading "the recorded gap is the smallest vertex modulus" holds at `p < q` only, which is where the record defines `gap(p,q)`. **Falsifier sought:** a two-factor labelling where the docstring's reading fails. `S⁹×S³` (`p = 9`, `q = 3`) is one: the identity gives `(9/2)²/normSq`, which is the largest modulus. Repair: add `(hpq : bs β a₁ < bs β a₂)` or cite `vertex_min` in the docstring.

**Recommended repair** (the file owner's call): a lemma `diagOp_spec (w) (symm) (hollow) : {λ | ∃ X, IsSkew X ∧ X ≠ 0 ∧ diagOp w X = λ • X} = {λ | ∃ a b, a ≠ b ∧ w a b = λ}`, a few lines, which would put the sphere products on the footing `spec_eq` gives `ℂPᵐ`.

## 3. The zero modulus at `m = 2` (question 3)

At `m = 2`, `cA + 1 = 0` and the spectrum is `{-2, 0, 4}` (screen agrees: multiplicities `2, 3, 1`, the `0` on the three-dimensional `𝔰𝔲(2) = Λ⁻`, as `W⁻_{ℂP²} = 0` requires). `cp_gap` then gives `cpGapSq 2 = 0 = 0²/24`. The record defines the gap as "the smallest **nonzero** modulus", which at `ℂP²` gives `2²/24 = 1/6`. The L56CP header says exactly this: the formula at `m = 2` "reads the gap as the smallest modulus including `0`", and the record applies the formula at `m ≥ 3` (`ℂP³`, `ℂP⁴`, `m ≥ 5`), where every eigenvalue is nonzero (`cA + 1 = (2m-4)/(2m-1) > 0`). That is honest.

Two notes. The header's "the record uses the formula at `m ≥ 3`" omits that the record also says the formula was "verified against the record's printed `W_{ℂP²}` spectrum", which under the record's nonzero definition it fails. That is a record-level tension, outside the Lean. The INDEX row says "At `m = 2` the smallest modulus is `0`" without saying this departs from the record's definition. Neither is a type-level defect.

**Other zero moduli sought:** a sphere-product entry vanishes only when `n = p`, a single factor, excluded by `h1`/`h2` and by `k ≥ 2`. The across entry is `1`. None found.

## 4. `Spec` and the witnesses (question 4)

`Spec m` is the set of `λ` with a nonzero skew `X`, `WCPm X = λX`. Since `WCPm` preserves skewness (`WCPm_skew`) and is self-adjoint on `Λ²`, this is its `Λ²` spectrum. `eigen_cases` is proved for arbitrary `X`, which is stronger than needed. The witnesses: `i0 = 0`, `i2 = 2` exist at `2m ≥ 4`. `partner 0 = 1`, so `J₀₂ = 0` and by skewness `J₂₀ = 0`. `conj_phi_apply i0 i2 i0 i2 = J₀₂·J₂₀ - J₀₀·J₂₂ = 0`, and `phi i0 i2` at `(i0, i2)` is `-1`. So `X±(0,2) = -1`, both nonzero. `frob J φ₀₂ = -2J₀₂ = 0` and `frob_J_conj` give `frob J X± = 0`. `conj_conj` gives `conj X± = ±X±`. Hence `WCPm X± = (cA ± 1)X±`. `J` is skew, nonzero at `m ≥ 1` by `frob_J_J = 2m`, at `cA + 1 + 2m`. **Falsifier sought:** an eigenvalue of the numerically built `Λ²` matrix outside the three values at `m = 2, 3, 4`. None. Trace check by hand: `m²(cA+1) + 2m + m(m-1)(cA-1) = cA·m(2m-1) + 3m = 0`, so `WCPm` is traceless as a Weyl operator must be.

## 5. Equal blocks (question 5)

With every factor of size `p` and `card ι = kp`, there are exactly `k` factors, so the hypotheses describe `(S^p)^k` at the Einstein normalisation. `multiGapSq k p` was defined from unit-sphere weights `1 - c`, `-c`. These are `(p-1)·weylE` (L56Weyl's `unit_weights`), a rescaling of `vW`, so the gap is the same. `vertex_min_multi` states `(kp - p)/(p-1) ≥ 1`: the within modulus is at least the across modulus `1`, which is the right direction for the across entry to be the minimum. At `(S³)⁴` the within entry is `-9/2`, across `1`, `normSq = 12·(81/4) + 54 = 297`, so `gap² = 1/297`, `gap = 0.05803`, the record's `0.0580`. **Falsifier sought:** a `k ≥ 2`, `p ≥ 2` with `(k-1)p < p - 1`, impossible since `(k-1)p ≥ p`. Screen at `(S³)⁴` agrees.

## 6. `(2,2,8)` (question 6)

`beta228 = ![0,0,1,1,2,…,2]` has blocks of sizes `2, 2, 8`, and `bs228` records it. Entries: `-(12-2)/1 = -10` within each `S²`, `-(12-8)/7 = -4/7` within `S⁸`, `1` across. The smallest modulus is `4/7` (attained at any pair inside `S⁸`, untyped). `normSq = 2·100 + 28·16/49 + 36·1 = 1716/7`, and `(16/49)/(1716/7) = 4/3003`, `√ = 0.036497`, the record's figure. The ratio `4/7 : 1` equals L56Multi's `4/77 : 1/11`, as the `-(n-1) = -11` rescaling requires. Screen agrees.

## 7. Hypotheses, docstrings and the INDEX row (question 7)

- No hypothesis is vacuous. `multiGapSq_eq_normalised` has no written instance, and `Fin 12 → Fin 4`, `a ↦ a/3` satisfies it.
- Docstring claims the types do not carry: (a) the sphere-product "smallest modulus of the spectrum" reading (§2), (b) the `p < q` reading of `gapSq_eq_normalised` (§2), (c) attainment in `vertex_min_228`.
- The INDEX L56 row **proved** is warranted for what the corrected block states: the ordering, the floor, the balanced display, `ℂPᵐ` against the floor at `m = 3, 4, ≥ 5`, `(S³)⁴` and `(2,2,8)`. The heading's clause "it is not the set's floor" is, per the record, unwitnessed, and the row rightly leaves it unformalised, though it says so only for the refuted values. The sentence "every figure … read off an operator" should carry the §2 qualifier until `diagOp_spec` exists.

## Overall verdict

**CONFIRMED on the mathematics for every declaration in the three files.** Normalisation is one convention across spheres and `ℂPᵐ`, every screened figure matches, and every hypothesis admits the record's cases. **PLAUSIBLE, true but untyped:** the entries-equal-spectrum step for sphere products and the `p < q` reading of `gapSq_eq_normalised`. **Honest:** L56CP's `m = 2` note. The one record-level tension is that its "nonzero" definition and its `ℂP²` verification claim disagree at `m = 2`.
