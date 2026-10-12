# Review r1895: L3Local, the strict local maximum transverse to the orbit

**Standfirst.** Gate 2 on [L3Local.lean](../lean/HamiltonsCubic/Results/L3Local.lean) at commit 85c09d45, which moves Lemma L3's row in [lean/INDEX.md](../lean/INDEX.md) to **proved** by replacing the record's tubular neighbourhood step with a closest-orbit-point argument. Every claim holds. The Lean theorem is the record's local-maximum clause with the neighbourhood made explicit as a squared-distance tube around the orbit, the closing inequality checks by hand line by line, and all five main theorems rest on the standard three axioms. Two bookkeeping defects sit outside the file: [lean/INDEX.md](../lean/INDEX.md) still lists L3 under "out, needs machinery Mathlib does not have", and the record's prose proof still runs through the tubular neighbourhood theorem.

| # | Claim | Verdict |
|---|---|---|
| 1 | `L3_local_max` states the record's clause, the tube is a neighbourhood of the orbit in Σ, the orbit test is orbit membership, `rotR` is the O(n) action, and the clause gives local maximality | CONFIRMED WITH OBSERVATIONS |
| 2 | `abs_Pcubic2_le_rec`, the cubic bound through an orthonormal basis of `RecCurv` | CONFIRMED |
| 3 | `orthSet_compact`, `pairing_continuous`, `exists_max` | CONFIRMED |
| 4 | `first_order`, the first-order condition at the maximiser | CONFIRMED |
| 5 | `orbitOp_eq` and the use of `L27_half_span` to discharge `horb` | CONFIRMED |
| 6 | The closing inequality and the choice of δ | CONFIRMED |
| 7 | Axioms and hypothesis inventory | CONFIRMED |
| 8 | The INDEX L3 row and the record's L3 header note | CONFIRMED WITH OBSERVATIONS |

**One line.** The local-maximum clause of L3 is kernel-checked as stated at every even n ≥ 8, and the only defects are a stale INDEX bucket entry and a prose proof that no longer matches the checked route.

## Conventions

- Σ is the unit sphere of 𝒲ₙ in the record's norm `normSq2`, which is `‖·‖²` on the synonym `RecCurv` ([RecordNormed.lean](../lean/HamiltonsCubic/Results/RecordNormed.lean), `RecCurv.norm_sq_eq`).
- W* is `M = restrict (diagOp (t • sphereWeight T))` with |T| = |Tᶜ| = m ≥ 4, so n = 2m ≥ 8, and θ = P(M) = t(n − 1), D = n − 2.
- The action is `rotR U V = U · V(Uᵀ · U) · Uᵀ` on `CurvOp2` ([FrameOp2.lean](../lean/HamiltonsCubic/Results/FrameOp2.lean), `rotR_coe`), with `rotR_comp : rotR U (rotR U' V) = rotR (U * U') V`.
- `hessQ a v` is ‖v‖² times the second derivative of P along the unit-speed great circle through a in direction v/‖v‖ ([L24HessOp.lean](../lean/HamiltonsCubic/Results/L24HessOp.lean)).
- The screening allowance of the analysis-only footing was used only for `#print axioms` and `#check` in one `lake env lean` call on a scratch file, after waiting for another session's `lake` to finish.

## Hypothesis inventory

| Hypothesis | Where used | Needed |
|---|---|---|
| `hp : 4 ≤ T.card` | `hp2`, `hp3`, `hne`, positivity of θ and D, `L3_hessian` | yes |
| `hpq : Tᶜ.card = T.card` | `hqR` (θ > 0, D > 0), `hne`, `L3_hessian` | yes |
| `ht : 0 < t` | θ > 0, `orbitOp_props`, `L27_half_span`, `L3_hessian` | yes |
| `hn : normSq (diagOp …) = 1` | `theta_of_unit`, `normSq2 M = 1`, `orbitOp_props`, `L27_half_span`, `L3_hessian` | yes |
| `IsWeyl2 V`, `normSq2 V = 1` | Σ membership, `rotR_isWeyl2`, `normSq2_rotR`, `Pcubic2_rotR` | yes |
| `∃ U, IsOrth U ∧ normSq2 (rotR U V − M) < δ` | `hsmall` through `hmax U hU` | yes |

No hypothesis is unused. The pair `hp`, `hpq` is exactly the record's "even n ≥ 8" once T ⊆ Fin n forces n = 2|T|.

## 1. Statement fidelity

The record, [findings/second-order.md](../findings/second-order.md), heading "Lemma L3, the balanced product is a local maximum", Statement, verbatim:

> For every **even $n\ge8$**, the unit Weyl tensor $W^*$ of $S^{n/2}\times S^{n/2}$ with $P(W^*)>0$ is a local maximum of $P$ on the unit sphere $\Sigma$ of $\mathcal W_n$, not merely within $\mathcal D_n$, and strictly so transverse to its $O(n)$-orbit $\mathcal O$: some neighbourhood $U$ of $\mathcal O$ in $\Sigma$ has $P<P(W^*)$ on $U\setminus\mathcal O$.

The Lean statement (from `#check`) quantifies over unit Weyl V with `∃ U, IsOrth U ∧ normSq2 (rotR U V − W*) < δ` and concludes `P V < P W* ∨ ∃ U, IsOrth U ∧ rotR U V = W*`.

- **The tube is a neighbourhood of 𝒪 in Σ.** `rotR U` is an isometry of `normSq2` on Weyl operators (`normSq2_rotR`) and `rotR Uᵀ (rotR U V − W*) = V − rotR Uᵀ W*` by `rotR_comp` and Uᵀ U = 1. So the set is {V ∈ Σ : dist(V, 𝒪)² < δ}. It contains 𝒪, since V = rotR g W* has rotR gᵀ V = W* at distance 0. It is open in Σ as a union over U of preimages of an open ball under the continuous map V ↦ rotR U V. In finite dimension the norm topology is the only vector topology, so no transport between `CurvOp2`'s native topology and `RecCurv`'s arises: the statement names the neighbourhood by its norm directly.
- **The orbit test is orbit membership.** `rotR U V = W*` with U orthogonal gives V = rotR Uᵀ W* ∈ 𝒪, and conversely V = rotR g W* gives rotR gᵀ V = W*. The disjunction "P(V) < P(W*) or V ∈ 𝒪" is the record's "P < P(W*) on U∖𝒪".
- **`rotR` is the record's O(n) action.** It is conjugation on Λ² in both slots, with no determinant twist, so orientation-reversing U act as in the record's O(n)-orbit. `IsOrth U` is Uᵀ U = 1 ∧ U Uᵀ = 1, the whole of O(n), and `exists_max` maximises over all of it.
- **Σ.** `IsWeyl2 V ∧ normSq2 V = 1` is the unit sphere of 𝒲ₙ in the record's norm, per the conventions.
- **Local maximum.** On the orbit P = P(W*) by `Pcubic2_rotR`, and off it P < P(W*), so P ≤ P(W*) on the tube, which contains a ball around W*. The first clause, "a local maximum of P on Σ", follows from the second. "Not merely within 𝒟ₙ" is automatic since V ranges over all of Σ.
- **The binders match the list three verifiers named** in [lean/INDEX.md](../lean/INDEX.md) line 803: n even with 8 ≤ n, the unit sphere, W* with 0 < P(W*), the O(n)-action and orbit, and a neighbourhood of the orbit with P < P(W*) off it.

The identification of the diagonal model `restrict (diagOp (t • sphereWeight T))` with the Weyl tensor of S^m × S^m is carried by earlier files (`sphereWeight`, `sphere_isCritical2`) and was not re-derived here (O3).

## 2. The cubic bound

`triL` is `cubicTri` packaged as a trilinear map on `RecCurv`, with linearity in each slot from the `cubicTri_add_*` and `cubicTri_smul_*` lemmas. With b the standard orthonormal basis of `RecCurv`, x = Σᵢ ⟨bᵢ, x⟩ bᵢ, and trilinearity gives triL x x x = Σ_{i,j,k} ⟨bᵢ,x⟩⟨bⱼ,x⟩⟨b_k,x⟩ triL(b_k,b_j,bᵢ). Cauchy–Schwarz with ‖bᵢ‖ = 1 gives |⟨bᵢ,x⟩| ≤ ‖x‖, so |P(x)| ≤ C‖x‖³ with C = Σ |triL(b_k,b_j,bᵢ)| ≥ 0. `Pcubic2_eq_cubicTri` identifies P with the diagonal of `cubicTri`. The transfer to `CurvOp2` uses ‖equiv H‖² = normSq2 H and √(r²) = r for r ≥ 0. The argument is correct and C depends only on n.

## 3. Compactness and continuity

- `orthSet_compact`: the diagonal entry of U Uᵀ = 1 gives Σ_k U_ik² = 1, so U_ij² ≤ 1 and U lies in the box [−1, 1]^{n×n}. The set is closed as the intersection of two preimages of {1} under continuous matrix maps. A closed subset of a compact box is compact.
- `pairing_continuous`: `innerOp2` is ½ Σᵢⱼ inner2 of the matrices on the basis bivectors φᵢⱼ, `inner2` is continuous in its left slot (trace of a product), and U ↦ rotR U V X is U · V(Uᵀ X U) · Uᵀ, continuous because V is a continuous linear map and the subtype map is continuous.
- `exists_max`: `IsCompact.exists_isMaxOn` on the nonempty set (1 is orthogonal) with the continuous pairing. Correct.

## 4. The first-order condition

`xi_W hjk hw 0 V'` gives the derivative at φ = 0 of f(φ) = ⟨rotR(R_φ)(coordOp w + ν_0), V'⟩ as ⟨2ν_y − 2 coordOp(D⁻ 0), V'⟩, with y_a = (w_ja − w_ka)/2. `nuX_zero` and `Dminus_zero` reduce this to f(φ) = ⟨rotR(R_φ) M, V'⟩ with derivative 2⟨ν_y, V'⟩, using `coordOp_eq_restrict` to name coordOp w = M.

Direction: `innerOp2_rotR_adj` gives ⟨rotR R M, rotR U₀ V⟩ = ⟨M, rotR Rᵀ (rotR U₀ V)⟩ = ⟨M, rotR (Rᵀ U₀) V⟩, and Rᵀ U₀ is orthogonal by `isOrth_mul (isOrth_transpose _) hU₀`. So f(φ) = ⟨rotR(R_φᵀ U₀) V, M⟩ ≤ ⟨rotR U₀ V, M⟩ = f(0), the last step from `Rot_zero`. Hence 0 is a global maximum of f, in particular a local one, and `IsLocalMax.hasDerivAt_eq_zero` gives 2⟨ν_y, V'⟩ = 0. The sign of the rotation is immaterial, since the maximum at 0 holds for every φ. `innerOp2_rotR_adj` itself is correct: `innerOp2_rotR` with R orthogonal plus `rotR_comp` and R Rᵀ = 1. Correct.

## 5. The orbit tangent and horb

`orbitOp_eq` rewrites `orbitOp T t j k` via `orbitOp_nuX` as ν applied to the vector `corb` scaled, and checks entrywise that it equals 2 ν_y with y_a = ((t·s)_ja − (t·s)_ka)/2, casing on a = j, a = k and neither. This matches the y in `first_order` with w = t · sphereWeight T, so ⟨crossOrbit q, V'⟩ = 0 for every cross pair q ∈ T × Tᶜ. With ⟨crossOrbit q, M⟩ = 0 (`orbitOp_props`), h = V' − aM satisfies ⟨crossOrbit q, h⟩ = 0, and span induction extends this to the span.

`L27_half_span` needs p, q ≥ 3 and (p, q) ≠ (3, 3). Both hold since p = q = m ≥ 4, and the file derives `hp3`, `hq3`, `hne` from `hp`, `hpq` by `omega`. Its forward direction sends every Weyl K with K ⊥ M and `LeLin M K = K/2` into span(crossOrbit), where `LeLin M` is L_e with e = M/P(M), the record's L_e. That is the hypothesis `horb` of `L3_hessian` verbatim. Correct.

## 6. The closing inequality, by hand

Write V' = aM + h with a = ⟨V', M⟩ and h ⊥ M. Then ‖h‖² = u = 1 − a².

- **Expansion.** P(aM + h) = a³P(M) + 3a²⟨Q(M), h⟩ + 3a⟨M, Q(h)⟩ + P(h). Criticality Q(M) = θM and h ⊥ M kill the middle term, leaving a³θ + 3a⟨M, Q(h)⟩ + P(h). This is `hexp`.
- **Hessian.** `hessQ_eq` gives hessQ M h = 6⟨M, Q(h)⟩ − 3θu, and `L3_hessian` gives hessQ M h ≤ −(6θ/D)u. So 3⟨M, Q(h)⟩ ≤ −(3θ/D)u + (3/2)θu. This is `hMQ`.
- **Assembly.** With a > 0, P(V') ≤ a³θ + (3/2)aθu − (3θ/D)au + P(h). Substituting u = 1 − a², a³θ + (3/2)aθ(1 − a²) = θ((3/2)a − ½a³), and θ − θ((3/2)a − ½a³) = (θ/2)(a³ − 3a + 2) = (θ/2)(a − 1)²(a + 2) ≥ 0 for a > −2. This is `hcubic`.
- **Why a > ½.** ‖V' − M‖² = 2 − 2a and ‖UV − M‖² = 2 − 2⟨UV, M⟩. Maximality of U₀ gives ⟨UV, M⟩ ≤ a, so 2 − 2a ≤ ‖UV − M‖² < δ ≤ 1, hence a > ½. So a(3θ/D)u ≥ (3θ/(2D))u = κu. This is `hlin`.
- **Why u ≤ 2(1 − a).** u = (1 − a)(1 + a) = 2(1 − a) − (1 − a)² ≤ 2(1 − a) < δ ≤ (κ/(C + 1))².
- **Cubic remainder.** r = √u < κ/(C + 1), so Cr < (C + 1)r < κ when r > 0, and P(h) ≤ Cr³ = Cr·u.
- **Conclusion.** P(V) = P(V') ≤ θ − κu + Cru = θ − u(κ − Cr) < θ when u > 0. When u = 0, h = 0 and a² = 1 with a > ½ force a = 1, so V' = M and V is on the orbit.

δ = min(1, (κ/(C + 1))²) with κ = 3θ/(2(n − 2)) is positive and serves both needs: δ ≤ 1 forces a > ½, and δ ≤ (κ/(C + 1))² forces Cr < κ. Every step matches the Lean proof. Correct.

## 7. Axioms

`#print axioms` on `L3_local_max`, `abs_Pcubic2_le_rec`, `first_order`, `orbitOp_eq` and `exists_max` each returns `[propext, Classical.choice, Quot.sound]`. The inventory above finds no unused hypothesis.

## 8. The INDEX row and the header note

The L3 row at [lean/INDEX.md](../lean/INDEX.md) line 519 describes the file accurately, including the displayed bound P(V') ≤ θ(3/2 a − ½a³) − (3θ/(n − 2))a‖h‖² + C‖h‖³, which is the proof's `hstep` plus `hcubic` plus `hlin` before substituting the bound on P(h). The header note in [findings/second-order.md](../findings/second-order.md) correctly names `L3_local_max` and its closest-orbit-point route. Two defects sit beside them (O1, O2).

## Verdict

**CONFIRMED WITH OBSERVATIONS.** `L3_local_max` is the record's strict-local-maximum clause at every even n ≥ 8, proved by a correct argument on the standard three axioms, and with L3Quad and L3Attain it carries the whole of L3's Statement.

**Falsifier.** The object that would refute the claims is a unit Weyl V arbitrarily close to the orbit of W*, off it, with P(V) ≥ P(W*). Equivalently, a Weyl h ⊥ W*, orthogonal to the orbit tangent, with hessQ W* h > −(6θ/(n − 2))‖h‖², or a gap between the orbit tangent and the ½-eigenspace of L_e on W*^⊥. I looked for it by checking that the Lean tube is exactly the distance tube around 𝒪, that the closest-point normalisation really puts V' ⊥ every cross-pair tangent (sign and orthogonality of Rᵀ U₀ in `first_order`), that `L27_half_span`'s scope covers p = q ≥ 4, and that each inequality of the closing chain follows with the stated δ. None of these failed, and the kernel confirms the chain.

## Observations

- **O1. [lean/INDEX.md](../lean/INDEX.md) line 803 is stale.** L3 is still listed under "out, needs machinery Mathlib does not have", saying its proof needs "a tubular neighbourhood of an orbit". Line 519 now records it proved without that theorem. The entry should leave the bucket, keeping its list of binders as the fidelity reference it served as here.
- **O2. The record's prose proof and the checked proof differ.** The paragraph "From the Hessian to a local maximum" in [findings/second-order.md](../findings/second-order.md) still runs through the tubular neighbourhood theorem and an unnamed third-derivative constant K. The header note points to the Lean route, but a reader of the proof reads the other one. The closest-orbit-point argument of section 6 is shorter and fully elementary, and would fit as the proof itself.
- **O3. The diagonal model.** The file takes W* as `restrict (diagOp (t • sphereWeight T))` with t fixed by `hn` and signed by `ht`. Its identification with the Weyl tensor of S^m × S^m is inherited from earlier reviewed files and was not re-checked here.
- **O4. The constant C is non-explicit.** It comes from an arbitrary orthonormal basis of `RecCurv`, so δ is existential. The Statement asks for nothing more, but any consumer wanting a radius would need a bound on C.
- **O5. L9 may inherit the route.** [lean/INDEX.md](../lean/INDEX.md) line 804 files L9 as blocked partly on "L3's tubular-neighbourhood step". The closest-orbit-point argument in this file uses only compactness of O(n), the first-order condition along coordinate-plane rotations and a Hessian bound off the ½-eigenspace, so it may transfer to τW₃₅ once the corresponding span and Hessian lemmas exist.
- **O6. The file column of the L3 row** lists L3.lean, L3Gap.lean and L3Local.lean but omits L3Quad.lean and L3Attain.lean, which the row's text cites as carrying the Hessian bound and its attainment.
