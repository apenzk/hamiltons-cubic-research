# REVIEW r1858: L3's quadratic-form Hessian bound (L3Quad.lean)

*Cold brief: Gate 2 on [L3Quad.lean](../lean/HamiltonsCubic/Results/L3Quad.lean), `quad_le_of_gap` and `L3_hessian`, against [second-order.md](../findings/second-order.md) Lemma L3 and the [lean/INDEX.md](../lean/INDEX.md) L3 row. Read at source: L3Quad in full, [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean) (`weylPerp`, `LeLin`, `weylPerpR`, `LeRestr`, `LeRestr_isSymmetric`), [L24HessOp.lean](../lean/HamiltonsCubic/Results/L24HessOp.lean) (`hessQ`, `hessQ_eq`, `tanV`, `hessOp`, `hessQ_op`), [L120Eigen.lean](../lean/HamiltonsCubic/Results/L120Eigen.lean) (`hessQ_eq_Le`), [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean) (`sphere_isCritical2`), [RecordNormed.lean](../lean/HamiltonsCubic/Results/RecordNormed.lean) (`RecCurv`, `inner_eq`, `norm_sq_eq`), [L3Gap.lean](../lean/HamiltonsCubic/Results/L3Gap.lean) (`L3_gap_balanced`), [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean) (`orbitOp`, `crossOrbit`, `L27_half_span`), [L27Close.lean](../lean/HamiltonsCubic/Results/L27Close.lean) (`orbit_tangent_cases`), [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean) (`orbitTan`). Run: one `lake env lean` scratch file with `#print axioms` on both theorems (both on the standard three, see F). Analysis only, no sweeps.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `quad_le_of_gap`: symmetric T, eigenvalues other than c at most λ*, gives ⟨Tv, v⟩ ≤ λ*‖v‖² for v orthogonal to the c-eigenvectors | CONFIRMED |
| 2 | `L3_hessian`: at p = q = m ≥ 4, hessQ M H ≤ −(6θ/(n−2))‖H‖² on N, θ = t(n−1) = P(M) | CONFIRMED |
| 3 | The hypothesis `horb` says exactly "H ∈ N", N the complement of the orbit tangent in W^⊥ ∩ 𝒲ₙ | CONFIRMED WITH OBSERVATIONS |
| 4 | INDEX L3 row: "Hessian half PROVED", owing the local maximum and attainment | CONFIRMED WITH OBSERVATIONS |

**Summary: both theorems are correct and state the record's Hessian bound on N exactly, the row is accurate, and the observations are one unstated clause (the Hessian vanishing on the orbit tangent), no non-vacuity witness for N, and a self-matching lock wait in the brief.**

## A. Hypothesis inventory

- `quad_le_of_gap`: `E` finite-dimensional real inner product space (needed for `eigenvectorBasis`), `hT : T.IsSymmetric` (used for the basis and for moving T across the inner product in `hexp`), `c`, `lstar`, `hgap` (used for each basis vector with eigenvalue ≠ c, whose nonzeroness is derived from orthonormality), `hv` (used for each basis vector with eigenvalue = c). All used. No sign hypothesis on λ* is needed, and none is taken: the termwise bound multiplies by the nonnegative square ⟨bᵢ, v⟩².
- `L3_hessian`: `hp : 4 ≤ |T|` (feeds `L3_gap_balanced`, `hp2`, `hq2` and θ > 0), `hpq : |Tᶜ| = |T|` (balance, used in `e` and `hqR`), `ht : 0 < t` (θ > 0, needed for `6θ ≥ 0` and `hP0`), `hn` (unit norm: `ha`, `theta_of_unit`), `hHW` and `hperp` (membership of `weylPerpR M`), `horb` (orthogonality to the c = ½ eigenvectors). All used.
- Consumed: `LeRestr_isSymmetric` needs `ha`, `hMW`, `hcrit : Qop2 M = θ • M`, `hP0`, all discharged from `sphere_isCritical2` and `hPM`. `hessQ_eq_Le` needs the same four. `L3_gap_balanced` takes `hp, hpq, ht, hn`, the vector's Weyl and perp clauses, nonzeroness (supplied from `w ≠ 0` through `Subtype.ext`), the eigen-equation (through `congrArg Subtype.val`) and `μ ≠ ½`. `sphere_isCritical2` needs `2 ≤ |T|, |Tᶜ|`, supplied. Each hypothesis matches its object: `weylPerpR M` carries exactly `IsWeyl2 ∧ ⟨M, ·⟩ = 0`, and its inner product and norm are `innerOp2` and `normSq2` by `RecCurv.inner_eq` (rfl) and `norm_sq_eq`.
- Unused: none found in either theorem.

## B. `horb` is exactly H ∈ N

- The set quantified in `horb` is {K Weyl, ⟨M, K⟩ = 0, L_e K = ½K}. `L27_half_span` at `3 ≤ |T|`, `3 ≤ |Tᶜ|`, ¬(3,3) (all implied by m ≥ 4) proves this set equals `span crossOrbit` as an iff, both directions.
- `crossOrbit` is `orbitOp` at cross pairs (j ∈ T, k ∉ T). `orbitTan M j k = [φ_jk, M·] − M[φ_jk, ·]` in [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean) is the infinitesimal action of the generator φ_jk of 𝔰𝔬(n), hence spans T_{W*}𝒪. `orbit_tangent_cases` shows each `orbitTan` is zero (within T or within Tᶜ) or ± a `crossOrbit`, and the cross case is `orbitOp_apply` read backwards, so span of orbit tangents = span `crossOrbit`. Therefore the `horb` set is T_{W*}𝒪 and `horb` with `hHW`, `hperp` says H ∈ N = (T_{W*}𝒪)^⊥ ∩ W^⊥ ∩ 𝒲ₙ.
- Vacuity or overstrength: `horb` constrains only H, the K-set is a subspace (of dimension pq by the record's `finrank_half`), and orthogonality to a subspace forces H = 0 only when that subspace is all of W^⊥. The record places λ_m on S²₀(ℝ^m) sectors inside W^⊥ off the orbit tangent, so N ≠ 0 mathematically. The Lean file carries no witness H ≠ 0 in N (O2), which is the attainment debt the row already names.

## C. hessQ against the record's Riemannian Hessian

- `hessQ a v = ⟨v, v⟩ · (d²/dt²) P(cos t · a + sin t · v/‖v‖)|₀`. For unit a and Weyl v ⊥ a, the curve is the unit-speed great circle of Σ through a with velocity v/‖v‖, a geodesic of the round sphere Σ ⊂ 𝒲ₙ. Along a geodesic, (f∘γ)'' = Hess f(γ', γ'), so hessQ a v = Hess P(v/‖v‖, v/‖v‖) · ‖v‖² = Hess P(v, v). The normalisation is quadratic in v, as required.
- Independent check of the value: with P(x) = C(x, x, x), f'' = 3C(γ'', γ, γ) + 6C(γ', γ', γ), and at t = 0 with γ'' = −a this is −3θ + 6C(u, u, a) = 6θ(⟨L_e u, u⟩ − ½), matching `hessQ_eq_Le` and the record's 6θ(L_e − ½Id).
- H = 0: `innerOp2 0 0 = 0` kills the factor, so hessQ M 0 = 0 and the bound reads 0 ≤ 0.
- Side: the bound is an upper bound on hessQ, negative coefficient −6θ/(n−2) < 0, the record's "Hess P ≤ −6θ/(n−2)". Correct side. The derivation multiplies the gap inequality by 6θ ≥ 0, so the direction is preserved.

## D. θ and n − 2

- θ: `hPM` proves `Pcubic2 M = t(|T| + |Tᶜ| − 1)` through `theta_of_critical_unit` and `Pcubic2_restrict`, so θ in the statement is P(W*) by proof, which is the record's definition θ = P(W*). The record's closed form √2 (m−1)/m √((n−1)/(n−2)) is not restated and need not be.
- n − 2 is written as |T| + |Tᶜ| − 2, which equals n − 2 since T and Tᶜ partition Fin n. With |Tᶜ| = |T| = m this is 2m − 2, and the identity `e`, λ_m − ½ = −1/(2m − 2), reproduces the record's −3θ/(m − 1) = −6θ/(n − 2).
- Evenness of n is implicit in `hpq`, matching the record's "even n ≥ 8".

## E. Edge cases

- m = 4: λ_4 = 2/6 = 1/3 = μ = 1/(m−1). `L3_gap_balanced` takes the max of λ_m and μ and discharges μ ≤ λ_m with the factor (m − 4) ≥ 0, so the tie is handled and nothing is lost.
- (3,3): excluded by `hp : 4 ≤ |T|`. Nothing is claimed at n = 6, where μ = ½ would merge the sectors with the orbit tangent. The file's docstrings say p = q = m ≥ 4 throughout.
- H = 0: see C. Also admissible: `quad_le_of_gap` at v = 0 gives 0 ≤ 0.
- t < 0: excluded by `ht`, correctly, since the record notes the Hessian changes sign with θ.

## F. Axioms

- `#print axioms` via `lake env lean` on a scratch file importing `HamiltonsCubic.Results.L3Quad` (olean built 14:55, after the 14:47 source edit): `quad_le_of_gap` and `L3_hessian` each depend on [propext, Classical.choice, Quot.sound], the standard three. Exit 0. No `sorry`, no `native_decide` (grepped the file: neither occurs).

## G. The INDEX row

- The row states `quad_le_of_gap` and `L3_hessian` as they are in the file, cites `L27_half_span` for the orbit tangent identification (checked in B), and names θ = P(M) = t(n − 1). It keeps the row's status at **partial** and the statement at "not typed".
- Owed, correctly listed: the local-maximum clause (strictness transverse to 𝒪 via a tubular neighbourhood, with the `taylor_bound` route marked untried) and the attainment of −6θ/(n−2) on S²₀(ℝ^m).
- Not mentioned either way: the record's sentence "the Hessian vanishes on T_{W*}𝒪". It is one line from `hessQ_eq_Le` (L_e K = ½K makes the bracket zero), yet no declaration states it (O1). "Hessian half PROVED" reads as covering the Hessian paragraph, of which this clause and attainment are the two pieces absent, and the row owes only one of them.

## H. Breaking objects and what was done to look for them

- `quad_le_of_gap` would break for a non-symmetric T (the rotation of ℝ² has no real eigenvalues, so `hgap` is vacuous while ⟨Tv, v⟩ = 0 ≤ λ*‖v‖² needs λ* ≥ 0: with λ* = −1 and v ≠ 0 the conclusion fails). `hT` excludes it. It would also break in infinite dimension without a spectral basis. `FiniteDimensional` excludes it. Checked by reading the proof's two uses of `hT`.
- `L3_hessian` would break at (3,3) (μ = ½ puts the Λ²⊗Λ² sector at Hessian 0 off the orbit tangent), at t < 0 (sign flip), and at p ≠ q with λ_p ≠ λ_q (the constant would be max(λ_p, λ_q, μ)). Each is excluded by `hp`, `ht`, `hpq`. It would break if `horb` were orthogonality to a proper subspace of the ½-eigenspace. B shows the set is the whole ½-eigenspace in W^⊥ ∩ 𝒲ₙ.
- It would break if hessQ carried a normalisation linear in ‖H‖ or omitted the scale. C derives it independently.
- Searched for, found nothing: an unused hypothesis, a hypothesis mismatched to its object, a vacuous `horb`, a sign error in `e` or in the final `calc`, a θ differing from P(M).

## Observations

- **O1.** The clause "the Hessian vanishes on T_{W*}𝒪" of the record's Hessian paragraph has no declaration. It is immediate from `hessQ_eq_Le` and the ½-eigen equation. Either add a two-line corollary or list it with attainment in the row, so "Hessian half PROVED" matches what is typed.
- **O2.** L3Quad proves no instance with H ≠ 0 in N, so a reader of the file alone cannot rule out N = 0. The attainment debt (an S²₀(ℝ^m) vector with equality) would discharge both at once.
- **O3.** Process: the brief's lock wait `while pgrep -f "bin/lake " ...` matches its own shell, whose command line contains the string "bin/lake ", so it never exits. My first screen hung on it and on another session's identical loop, and was restarted with `pgrep -x lake`. Other briefs and skills carrying this line hang the same way.
- **O4.** `L3_hessian`'s docstring and the row say "unit sphere product" while `hn` normalises `diagOp` in the CurvOp layer, with `normSq2_restrict` carrying it to M. Correct, noted only because the unit hypothesis lives on a different object from the one the conclusion is about.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Both theorems are proved as stated, carry the record's Hessian bound on N with the right constant, sign and normalisation, and consume every hypothesis. The row claims no more than the Lean proves, with O1 the one clause of the Hessian paragraph neither proved nor listed as owed.
