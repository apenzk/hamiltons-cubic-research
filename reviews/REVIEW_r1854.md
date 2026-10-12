# Reviewer r1854, L27Close (LeLin_selfAdj, LeLin_perp, LeLin_weyl, signChar_sum, pr_inj, crossOrbit_indep, finrank_half, pairVec_neg, orbit_tangent_cases, L27_kernel), the repaired orbitTan_within_zero, and the L27 row's proved state

Gate 2 on commit 3703a90e ([L27Close.lean](../lean/HamiltonsCubic/Results/L27Close.lean)), commit 2862f0cc (the repaired `orbitTan_within_zero` in [L122Cap.lean](../lean/HamiltonsCubic/Results/L122Cap.lean)) and the [lean/INDEX.md](../lean/INDEX.md) L27 row, which now reads **proved**. Every statement was read at source against its definitions (`LeLin` in L24Restrict, `critMap`, `critMap_hasDerivAt` and `critMap_kernel_iff` in L126Kernel, `orbitTan` in L126Orbit, `orbitOp`, `crossOrbit`, `orbitOp_props`, `L27_half_span` in L27Span, `L27_half` in L27Main, `split_unique` in L27Sector, `SignChar` in L120Hess, `sphereWeight` in Families). Analysis-only footing: the only computation was one `lake env lean` run on a scratch file holding the axiom audit and two short screens (an `example` that the old hypothesis of `orbitTan_within_zero` forces `w j k = 0`, and an `example` that a `1/2`-eigenvector of `L_e` on all of Weyl is orthogonal to `M`, through `LeLin_selfAdj`). No refutation. The proved state is justified at the level the programme uses for "proved on the operators", with two clauses whose final linear-algebra step is prose (O2, O3).

| # | Claim | Verdict |
|---|---|---|
| 1 | `LeLin_selfAdj`, `LeLin_perp`, `LeLin_weyl` | CONFIRMED WITH OBSERVATIONS |
| 2 | `signChar_sum`, `pr_inj`, `crossOrbit_indep` | CONFIRMED |
| 3 | `finrank_half`, dim = \|T\|·\|Tᶜ\| = pq | CONFIRMED WITH OBSERVATIONS |
| 4 | `pairVec_neg`, `orbit_tangent_cases` (the orbit tangent is span `crossOrbit`) | CONFIRMED WITH OBSERVATIONS |
| 5 | `L27_kernel` as Morse–Bott nondegeneracy | CONFIRMED |
| 6 | repaired `orbitTan_within_zero`, old version vacuous at sphere products | CONFIRMED WITH OBSERVATIONS |
| 7 | L27 row reads **proved** | CONFIRMED WITH OBSERVATIONS |
| 8 | axioms of L27_kernel, finrank_half, orbit_tangent_cases, crossOrbit_indep | CONFIRMED |

**Summary: every L27Close declaration is correct and the proved state stands, with the orbit-tangent-space and unrestricted-E(1/2) identifications carried in prose one short step above the Lean (O2, O3) and three stale docstrings (O4, O5, O6).**

## 1. Attack A: self-adjointness, invariance, and λ_max

- `LeLin M A = foxProd2 ((Pcubic2 M)⁻¹ • M) A` by definition (L24Restrict). `LeLin_selfAdj` pulls the scalar out on both sides and applies `inner_fox_move` twice with `foxProd2_comm`, which is the cyclic symmetry ⟨M∘A, B⟩ = ⟨M∘B, A⟩ of the trilinear form. It needs M, A, B self-adjoint only (Weyl is stronger than required). Correct.
- `LeLin_perp`: ⟨M, M∘H⟩ = ⟨H, M∘M⟩ = θ⟨H, M⟩ = 0, scaled by P(M)⁻¹. Correct. `LeLin_weyl` is `isWeyl2_foxProd2`. Correct.
- Together these say L_e is a self-adjoint endomorphism of the finite-dimensional real space W⊥ ∩ 𝒲ₙ. Read as "the largest eigenvalue", λ_max(L_e|W⊥) = 1/2 follows from `L27_half` (every eigenvalue on a nonzero H ⊥ M is at most 1/2) and `orbitOp_props` (a nonzero 1/2-eigenvector ⊥ M exists) with no spectral theorem at all: the eigenvalue set is bounded by 1/2 and contains it.
- The spectral theorem is needed only for the Rayleigh reading, sup over unit H ⊥ M of ⟨L_e H, H⟩ equal to 1/2. That is the finite-dimensional spectral theorem for a symmetric map, standard and in Mathlib (`LinearMap.IsSymmetric.eigenvectorBasis`), and the record's Morse–Bott clause does not use it (see D). Leaving it implicit is acceptable. The INDEX sentence "so `L27_half`'s eigenvalue bound is the spectral bound" is the Rayleigh reading and is where the implicit step sits (O1).
- `LeLin_perp` duplicates `LeLin_mapsTo` in L24Restrict, and none of the three is used by `L27_kernel` or anywhere else. They are the r1848 O2 named items, correct and harmless (O1).

## 2. Attack B: independence and dimension

- `pr_inj`: for p = (j, k), q = (j', k') with j, j' ∈ T and k, k' ∉ T, {j, k} = {j', k'} forces j = j' (j = k' contradicts k' ∉ T) and k = k' (k = j' contradicts k ∉ T). Correct. So the fibres of p ↦ {p.1, p.2} on T ×ˢ Tᶜ are singletons or empty.
- `crossOrbit_indep`: for a relation Σ g_p crossOrbit_p = 0, group by fibre, A u = Σ_{pr p = u} g_p crossOrbit_p. Each summand has character `setChar u` (from `orbitOp_props`' second conjunct and `signChar_smul`), so `signChar_sum` gives `SignChar (setChar u) (A u)` for every u, the empty fibre giving 0 through `signChar_zero`. `Finset.sum_fiberwise` gives Σ_u A u = 0, `split_unique` gives A (pr p0) = 0, the singleton fibre gives g_{p0} crossOrbit_{p0} = 0, and `orbitOp_props`' third conjunct (nonzero) gives g_{p0} = 0. Sound.
- `split_unique` needs the characters `setChar s` pairwise distinct over s. That lives in `proj_of_char` (reviewed at r1844) and is true since ∏_{i∈s} ε_i determines s.
- `finrank_half`: `finrank_span_eq_card` gives the Fintype card of the subtype ↥(T ×ˢ Tᶜ), `Fintype.card_coe` and `card_product` then give |T|·|Tᶜ|. With p = |T|, q = |Tᶜ|, n = p + q this is pq. CONFIRMED. The docstring and INDEX name this span "E(1/2) ∩ W⊥", which is `L27_half_span` read as a set equality, not a Submodule equality in Lean. The step is immediate (O2).

## 3. Attack C: the orbit tangent space

- `orbitTan M j k Y = [φ_jk, M Y] − M [φ_jk, Y]` is d/ds of Ad(exp sφ_jk) ∘ M ∘ Ad(exp −sφ_jk) at 0, the SO(n)-orbit's velocity along the generator φ_jk. The record's "orbit tangent" is the image of X ↦ [ad X, M] over skew X (I117Statements' `orbitTangent` is this map at the CurvOp2 level). Since {φ_ab : a < b} spans the skew matrices and the map is linear in X, that image is span{orbitTan M a b}. So yes, the orbit tangent is the span of the generators' tangents, and dim(orbit) is the dimension of that span.
- `orbit_tangent_cases` case split: a, b ∈ T and a, b ∉ T go to `orbitTan_within_zero` with the off-{a, b} hypothesis discharged by `sphereWeight_in`/`sphereWeight_cross` (resp. `_out`/`_cross` with `_symm`), constant on each block. The mixed cases give `orbitOp_apply` directly (a ∈ T, b ∉ T, s = 1) or, for a ∉ T, b ∈ T, orbitTan_ab = pairVec a b (w_a· − w_b·) = pairVec b a (w_a· − w_b·) = −pairVec b a (w_b· − w_a·) = −orbitOp b a, through `orbit_pairVec`, `pairVec_comm` and `pairVec_neg`. The sign is right, and it matches φ_ba = −φ_ab.
- Reverse inclusion: every `crossOrbit` element is an `orbitTan` on skew matrices by `orbitOp_apply`. So the two spans agree as sets of maps on skew matrices, and the orbit tangent has dimension pq by `finrank_half`.
- What Lean does not hold: a single Submodule equality "image of X ↦ [ad X, M] = span crossOrbit" in CurvOp2. The pieces are the generator-level cases and `orbitOp_apply`, and the expansion X = ½Σ X_ab φ_ab and the passage from `orbitTan` (a CurvOp on all matrices) to CurvOp2 are prose. CONFIRMED WITH OBSERVATIONS (O3).
- dim(orbit) = pq also agrees with the independent count dim O(n) − dim(O(p)×O(q)) = n(n−1)/2 − p(p−1)/2 − q(q−1)/2 = pq, so the within-factor generators being exactly the stabiliser directions is consistent.

## 4. Attack D: L27_kernel as Morse–Bott nondegeneracy

- The function is P(W) = ⟨W, Q(W)⟩ on the unit sphere of 𝒲ₙ, Q(W) = W∘W. Its gradient is 3Q(W), so the critical points on the sphere are the zeros of `critMap W = Q(W) − P(W) W`, and at a critical unit M with θ = P(M) the Riemannian Hessian on the tangent H ⊥ M is 3(2M∘H − θH) (the Euclidean Hessian 6M∘H minus ⟨∇P, M⟩ = 3θ times the identity, then projected to M⊥, which is the identity on the image by `LeLin_perp`).
- `critMap_hasDerivAt` gives the directional derivative of `critMap` at M along H ⊥ M, weakly against every test Z, as 2M∘H − P(M)H, the P-term's own derivative 3⟨H, Q(M)⟩M vanishing at H ⊥ M. So the kernel in `L27_kernel` is the kernel of the Hessian on the sphere's tangent, up to the factor 3. Right formal meaning.
- `L27_kernel`'s proof: `theta_of_critical_unit` gives θ = t(n − 1), nonzero at t > 0 and p ≥ 3, `critMap_kernel_iff` turns the kernel condition into L_e H = H/2, and `L27_half_span` (with the hypothesis H ⊥ M carried) gives the span. Both directions correct.
- Morse–Bott nondegeneracy is "kernel of the Hessian on T_M S = T_M(critical manifold)". The critical set contains the O(n)-orbit, whose tangent lies in the kernel automatically, so kernel = orbit tangent (this lemma plus C) says the critical set is, near M, the orbit, a manifold with tangent equal to the kernel. That is the standard definition. The link "Hessian = 3 DF(M) on the tangent" is a docstring statement over `critMap_hasDerivAt`, and no Lean statement names the Hessian of P on the sphere (O7). CONFIRMED.

## 5. Attack E: the repaired orbitTan_within_zero

- New hypothesis ∀ i ≠ j, k, w_ji = w_ki. Proof: `orbit_in_pairBlock` writes orbitTan as Σ_i (w_ji − w_ki) φ_ji ⊙ φ_ki, the i = j term vanishes by `phi_self` and `rk2_zero_left`, the i = k term by `phi_self`, `rk2_comm`, `rk2_zero_left`, the rest by the hypothesis. Correct.
- The old hypothesis ∀ i, w_ji = w_ki at i = k reads w_jk = w_kk = 0. The screen `example … (hwk : ∀ i, w j i = w k i) : w j k = 0 := by rw [hwk k, hh]` compiles (see G). At a within-factor pair of `t • sphereWeight T`, w_jk = t·|Tᶜ|/(|T| − 1) (or t·|T|/(|Tᶜ| − 1)) is nonzero at t > 0 and |Tᶜ|, |T| ≥ 1. So the old lemma was vacuous exactly where its docstring applied it (not vacuous in general: it held at w_jk = 0). CONFIRMED.
- The commit message says "the lemma has no users". True at 2862f0cc, and L27Close is now its user, in both within-factor branches of `orbit_tangent_cases`.
- The module docstring of L122Cap (lines 25–26) still says "when `w_{ji} = w_{ki}` for every `i`", the old hypothesis (O4).

## 6. Attack F: coverage of the record's clauses

| Clause of the record | Lean | Status |
|---|---|---|
| hypotheses p, q ≥ 3, (p, q) ≠ (3, 3), n = p + q, at W_{p,q} | `hp`, `hq`, `hne`, unit `t • sphereWeight T` via `hn` | covered |
| λ_max(L_e\|W⊥) = 1/2 | `L27_half` (≤) and `orbitOp_props` (attained), with `LeLin_selfAdj`/`LeLin_perp` for the restriction | covered as the largest eigenvalue, no single theorem (O1) |
| attained exactly on the orbit tangent | `L27_half_span` (E(1/2) ∩ W⊥ = span crossOrbit) and `orbit_tangent_cases` with `orbitOp_apply` (span crossOrbit = orbit tangent) | covered, the second equality at generator level (O3) |
| dim E(1/2) = pq | `finrank_half` on W⊥, and the unrestricted E(1/2) lies in W⊥ by self-adjointness and L_e M = M, screened below | covered on W⊥, unrestricted by a two-line step not in the tree (O2) |
| = dim(orbit) | `finrank_half` with `orbit_tangent_cases` | covered at generator level (O3) |
| Morse–Bott nondegenerate | `L27_kernel` with `critMap_hasDerivAt` | covered, Hessian named in prose (O7) |

- No clause is uncovered. Two are covered at the level of their generators or their W⊥ restriction, one short and standard linear-algebra step below the record's wording. The record's own E(1/2) is, read in context, E(1/2) of L_e on W⊥ (the record writes λ_max(L_e|_{W⊥}) in the same sentence), which makes O2 a wording point.

## 7. Attack G: axioms

- One `lake env lean` run on a scratch file importing L27Close, at HEAD after 3703a90e, exit 0, `grep -c error` = 0. It agrees with the coordinator's own audit at HEAD.
- `L27_kernel`, `finrank_half`, `orbit_tangent_cases`, `crossOrbit_indep`, `LeLin_selfAdj`, `LeLin_perp` and `orbitTan_within_zero` each depend on exactly [propext, Classical.choice, Quot.sound]. No `sorryAx`, and no `native_decide` axiom.
- Screen 1 (reported as a screen): `example (w : Matrix ι ι ℝ) (hh : ∀ a, w a a = 0) (hwk : ∀ i, w j i = w k i) : w j k = 0 := by rw [hwk k, hh]` compiles, so the old hypothesis of `orbitTan_within_zero` forces w_jk = 0.
- Screen 2 (reported as a screen): at n = 7, from `IsWeyl2 M`, `IsWeyl2 H`, `LeLin M M = M` and `LeLin M H = (1/2) • H`, `innerOp2 M H = 0` follows through `LeLin_selfAdj`, `innerOp2_smul_left`, `innerOp2_comm` and `linarith`. This compiles, so the unrestricted E(1/2) lies in W⊥ (O2).
- CONFIRMED.

## 8. Attack H: what would break each statement, and what I did to look

- `crossOrbit_indep`: breaks if two index pairs shared an unordered set (they cannot, orientation j ∈ T, k ∉ T is fixed, `pr_inj`) or if some `orbitOp` were zero (`orbitOp_props` excludes it through `cross_orbit_exists`) or if characters of distinct sets coincided (they do not). Looked by reading `pr_inj`, `split_unique`, `proj_of_char` usage and the fibre argument line by line.
- `finrank_half`: breaks only with `crossOrbit_indep`. Read the cardinality chain.
- `orbit_tangent_cases`: breaks if the sphere weight differed within a block off {a, b}, but it is constant per block pair by definition (Families.lean lines 308–342), and the four membership cases exhaust Fin n. Checked the sign in the (a ∉ T, b ∈ T) case by hand through `pairVec_comm`.
- `L27_kernel`: breaks if θ = 0 (θ = t(n − 1) > 0) or if `L27_half_span` failed, which r1848 reviewed. Checked `critMap_kernel_iff` both directions and the derivative in `critMap_hasDerivAt` against the Riemannian Hessian computed by hand.
- `orbitTan_within_zero`: breaks if φ_ii were nonzero, and `phi_self` rules that out. Screened the old hypothesis in Lean.
- Proved state: would break if a record clause lacked a Lean counterpart. The table in section 6 found none.

## Observations

- **O1.** `LeLin_selfAdj`, `LeLin_perp`, `LeLin_weyl` are used by nothing (`LeLin_perp` duplicates L24Restrict's `LeLin_mapsTo`), and λ_max = 1/2 is two theorems, not one. A two-line `L27_lambda_max` (every eigenvalue on W⊥ ∩ 𝒲ₙ is ≤ 1/2, and 1/2 is one) would give the INDEX clause a single name. The Rayleigh-quotient reading rests on the spectral theorem, which is standard and acceptable to leave implicit.
- **O2.** `finrank_half` is the dimension of span `crossOrbit`. Its docstring and the INDEX call it dim E(1/2) ∩ W⊥, which is `L27_half_span` read as a set equality. The record's unqualified E(1/2) needs E(1/2) ⊆ W⊥, a two-line consequence of `LeLin_selfAdj` and L_e M = M (screened in section 7).
- **O3.** "The orbit tangent space is span `crossOrbit`" is carried by `orbit_tangent_cases` and `orbitOp_apply` at the generator level. A Submodule statement equating the image of X ↦ `orbitTangent`-style [ad X, M] with span `crossOrbit` would close the one remaining prose step (expansion of skew X in the φ_ab and the CurvOp to CurvOp2 passage).
- **O4.** [L122Cap.lean](../lean/HamiltonsCubic/Results/L122Cap.lean) module docstring, lines 25–26, still states the old hypothesis "for every `i`". The theorem's own docstring was updated, the header was not. Commit 2862f0cc's "no users" is superseded by L27Close.
- **O5.** [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 490 still reads "[r1845] pending on the rest" and "Gate 2 on L27Close pending", both stale after r1845 and this review.
- **O6.** The INDEX L27 row still carries the sentence "The conclusion's route, re-filed from `out` to `ready` by assembly", and ends on "**statement: typed**" after the proved summary. Both are history the row's **proved** status has overtaken.
- **O7.** The identification "kernel of DF(M) on the tangent = kernel of the Hessian of P on the sphere" (Hess = 3·DF there) lives in docstrings over `critMap_hasDerivAt`. It is standard and correct, and no Lean statement names the Hessian.

## Overall verdict

CONFIRMED WITH OBSERVATIONS. Every declaration in L27Close is correct, the repaired `orbitTan_within_zero` is correct and its predecessor was vacuous at sphere products, and the L27 row's **proved** is justified: each clause of the record has a Lean counterpart, two of them one standard linear-algebra step below the record's wording (O2, O3), none needing further mathematics.
