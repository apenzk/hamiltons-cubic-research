# REVIEW r1866: L216 at the balanced sphere product (L216Sphere.lean)

**Standfirst.** Cold Gate 2 read of [L216Sphere.lean](../lean/HamiltonsCubic/Results/L216Sphere.lean) on an analysis-only footing. I read the file at source with every declaration it consumes: `no_critical_in_tube_Le` and `Tsym_eq_Le` in [L217Le.lean](../lean/HamiltonsCubic/Results/L217Le.lean), `no_critical_in_tube_crit`, `cub`, `Dq`, `qP`, `P_plane` and `hasDerivAt_cub` in [L216Bern.lean](../lean/HamiltonsCubic/Results/L216Bern.lean), `L3_hessian` and `quad_le_of_gap` in [L3Quad.lean](../lean/HamiltonsCubic/Results/L3Quad.lean), `L3_gap_balanced` in [L3Gap.lean](../lean/HamiltonsCubic/Results/L3Gap.lean), `hessQ_eq_Le` in [L120Eigen.lean](../lean/HamiltonsCubic/Results/L120Eigen.lean), `sphere_isCritical2` in [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean), `hessQ` in [L24HessOp.lean](../lean/HamiltonsCubic/Results/L24HessOp.lean) and `L27_half_span` in [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean). On the record side I read Lemma L216 in [second-order.md](../findings/second-order.md) (statement, corollary, steps 1 to 5, the Lean note), the λ_m and μ discussion in [nondegeneracy.md](../findings/nondegeneracy.md), and the L216 row of [lean/INDEX.md](../lean/INDEX.md). The one run was `lake env lean` on a scratch file printing axioms for `Le_gap_balanced`, `L216_sphere` and `L3_hessian`. No sweep or numerical hunt was run.

| # | Claim | Verdict |
|---|---|---|
| 1 | `Le_gap_balanced`: at a unit balanced product, p = q = m ≥ 4, every unit Weyl H ⊥ M orthogonal to every ½-eigenvector of L_e has ⟨L_e H, H⟩ ≤ ½ − 1/(2(m−1)) | CONFIRMED |
| 2 | `L216_sphere`: step 5 at the balanced product with γ = 1/(2(m−1)), the rotation derivative negative on 0 < s < 4θγ/(9 M_P) | CONFIRMED WITH OBSERVATIONS |
| 3 | The L216 row: L27's gap "PROVED and consumed" at the balanced product | CONFIRMED WITH OBSERVATIONS |

**Summary.** Both theorems prove what they say on the standard three axioms, γ is the record's balanced γ exactly, and the defects are all in how the row and the record's Lean note describe the file, not in the Lean.

## A. Hypothesis inventory

`Le_gap_balanced` takes `hp`, `hpq`, `t`, `ht`, `hn`, `hHW`, `hH1`, `hperp`, `horb`. Every one is used: `hp` and `hpq` fix the balanced shape and feed `L3_hessian`, `ht` gives θ > 0 so that 6θ can be cancelled (`le_of_mul_le_mul_left`), `hn` gives ‖M‖ = 1 and θ = t(2m − 1), `hH1` turns ‖H‖² into 1, and `hperp`, `horb` are passed to `L3_hessian` and to `hessQ_eq_Le` through the `weylPerpR M` package. None restates the conclusion. `horb` is the nearest thing to a load-bearing assumption, and it is the record's own hypothesis in eigenvector form: "orthogonal to every ½-eigenvector of L_e on W^⊥" in place of "orthogonal to the orbit tangent". The two coincide by `L27_half_span` together with the identification of span(crossOrbit) with the orbit tangent, and that bridge is cited in the docstring and not composed here (O2).

`L216_sphere` adds `MP`, `s`, `hM0`, `hM`, `hs0`, `hsr`. All are consumed by `no_critical_in_tube_Le`. `hM0` is derivable from `hM`: at (x, y) = (1, 0), `hM` gives |P(M)| = θ ≤ M_P, and θ > 0 (O3). The gap hypothesis of `no_critical_in_tube_Le` is discharged by `linarith` from `Le_gap_balanced`, with γ unified to 1/(2(m − 1)) through the shape of `hsr`. The `(by omega)` proofs inside the statement's types differ syntactically between the hypotheses and the consumers, which proof irrelevance makes definitionally equal, and the kernel accepted it. Nothing in either statement restates its conclusion.

## B. Is γ the record's γ at the balanced product?

Yes. The record's corollary gives γ_{p,q} = min(1/(2(p−1)), 1/(2(q−1)), ½ − μ) with μ = (n − 2)/(2(p−1)(q−1)), and states that at the balanced product n = 2m ≥ 8 this is γ = 1/(n − 2). At p = q = m, μ = (2m − 2)/(2(m−1)²) = 1/(m − 1), so ½ − μ = (m − 3)/(2(m − 1)) ≥ 1/(2(m − 1)) exactly when m ≥ 4, and the minimum is 1/(2(m − 1)) = 1/(n − 2). The Lean γ is ½ − λ_m with λ_m = (m − 2)/(2(m − 1)) from `L3_gap_balanced`, which is the same number. `L3_gap_balanced` bounds every eigenvalue off ½ by λ_m, which covers the μ and −μ sectors too (the L3Gap header records λ_m − μ = (m − 4)/(2(m − 1)) ≥ 0), so the γ used is the full-spectrum gap on W^⊥ at the balanced product and not a single-sector value. No unbalanced γ enters: `hpq : Tᶜ.card = T.card` forces p = q throughout. The source in Lean is L3's gap, itself assembled from L27's sector lemmas (`dn_le`, `pair_le`, `four_le`), so calling it "L27's gap" is accurate in substance.

## C. Is the conclusion the record's "no critical point at distance s"?

No, and the file's docstring overstates it slightly. The conclusion `cub (Dq (qP M H)) (cos s) (sin s) < 0` is a polynomial inequality. It is φ′(s) for φ(σ) = P(cos σ M + sin σ H) only through `P_plane` and `hasDerivAt_cub` in L216Bern.lean, which are proved but are not composed into this statement, so the theorem never mentions a derivative (O1). Against the r931/r932 list:

| Item | Typed here? |
|---|---|
| Step 1: compactness of the orbit and attainment of the distance | No |
| The nearest-point normal geodesic, W = cos s W₁ + sin s H | No. The theorem takes W₁ = M itself and a given H |
| Equivariance carrying the gap from W₀ to W₁ = g·W₀ | No. The gap is proved at M only |
| H ⊥ orbit tangent, in the record's form | In eigenvector form (`horb`), bridged by `L27_half_span` in prose only |
| L143's value M = 1 + √(n − 2) | No. M_P is a hypothesis |
| Final inference: φ′(s) < 0 implies the point is non-critical | No |
| The gap at the sphere product | Yes, new in this file |
| Steps 2 to 5 along P itself | Yes, via L216Bern and L217Le |

So what is new is exactly the discharge of `hgap` at the balanced product. The docstring's "so no critical point lies there" is the record's step 5 conclusion, not the theorem's.

## D. Edge cases

- **m = 4.** λ_4 = 1/3 = μ, a tie, so the second eigenvalue is attained twice. The gap value is unchanged, 1/6 = 1/(n − 2) at n = 8, and `L3_gap_balanced` is stated for m ≥ 4 with its bound max(λ_m, μ) = λ_m holding at the tie. The Lean covers m = 4 with no special case, and the record's range n = 2m ≥ 8 is the same range. m = 3 is correctly excluded: there ½ − μ = 0 and the product is degenerate.
- **H not unit.** Excluded by `hH1`. The correct scaled form, ⟨L_e H, H⟩ ≤ (½ − γ)‖H‖², is what `L3_hessian` gives, and the unit version is the record's. `no_critical_in_tube_Le` itself asks no norm of H, but the gap is only meaningful at ‖H‖ = 1, and L216_sphere supplies it.
- **M_P small.** `hM` forces M_P ≥ |P(M)| = θ, so the radius is at most 4γ/9 ≤ 2/27 and a small M_P cannot enlarge it. An M_P below the true bound makes `hM` false and the theorem vacuous, which is correct behaviour for a hypothesis bound.
- **H = 0 or H not orthogonal to M.** Excluded by `hH1` and `hperp`.

## E. Does the row claim more than the Lean proves?

Not in its new sentence, which is scoped to the balanced product and states the eigenvector form accurately. Two frictions remain. First, the same row's "What the file does NOT state" list still ends with "[L27]'s gap at the sphere products" with no strike-through or qualifier, which now contradicts the sentence "PROVED and consumed" at the balanced product. It should read as discharged at p = q = m ≥ 4 and open at unbalanced p ≠ q (O4). Second, the record's Lean note under Lemma L216 in second-order.md names L216IsolationRadius, L216Bern and L217Le and says nothing of L216Sphere, so the record's reader does not learn that the corollary's balanced case is now typed (O5). The row status stays **partial**, which is right: the record's L216 is at a general quantitatively nondegenerate orbit, its corollary covers all p, q ≥ 3 other than (3,3), and this file covers only the balanced product and only step 5.

## F. Axioms

`lake env lean` on a scratch file importing `HamiltonsCubic.Results.L216Sphere` printed, for `Le_gap_balanced`, `L216_sphere` and `L3_hessian` alike, `[propext, Classical.choice, Quot.sound]`, the standard three, with exit code 0. No `sorry` appears in L216Sphere.lean, L3Quad.lean, L3Gap.lean, L217Le.lean or L216Bern.lean. The olean postdates the source, and the staged root [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) imports the new file.

## G. What would break each statement, and what I did to look

- **Claim 1** breaks on a unit Weyl H ⊥ M, orthogonal to the ½-eigenspace, with ⟨L_e H, H⟩ > (m − 2)/(2(m − 1)). In an orthonormal eigenbasis that needs an L_e-eigenvalue on W^⊥ strictly between λ_m and ½, or above ½. I looked by reading `quad_le_of_gap` (the eigenbasis expansion is correct, eigenvalues equal to c are killed by orthogonality and every other one is bounded by the gap) and `L3_gap_balanced` (every eigenvalue off ½ is at most λ_m, assembled from L27's sector lemmas). I also checked that `L_e` restricted to W^⊥ excludes the eigenvalue 1 on ⟨W⟩, which `hperp` does. Nothing found.
- **Claim 2** breaks on some 0 < s < 4θγ/(9 M_P) at which the cubic derivative form is nonnegative. That would need a failure in L216Bern's Taylor and Bernstein chain, already reviewed at r1761, or in the gap. I checked that the γ passed is the one proved and that `no_critical_in_tube_Le`'s `Tsym_eq_Le` step uses P(M) = θ ≠ 0, supplied by `Pcubic2_crit`. Nothing found.
- **Claim 3** breaks on a sentence of the row that the Lean does not support. The breaking object is the stale unqualified "L27's gap at the sphere products" in the not-stated list (O4), a description defect and not a mathematical one.

## Observations

- **O1.** The conclusion is the polynomial `cub (Dq (qP M H)) (cos s) (sin s)`, which is φ′(s) only through `P_plane` and `hasDerivAt_cub`. A one-line corollary stating `HasDerivAt (fun σ => Pcubic2 (cos σ • M + sin σ • H)) _ s` with a negative value would put the derivative in the type.
- **O2.** `horb` is the ½-eigenspace form. The bridge to the record's orbit-tangent form (`L27_half_span` plus span(crossOrbit) being the tangent) is prose in the docstring.
- **O3.** `hM0` in `L216_sphere` is redundant, following from `hM` at (1, 0) and θ > 0. Harmless.
- **O4.** The L216 row's "What the file does NOT state" list still lists L27's gap at the sphere products unqualified. It should say discharged at the balanced product by L216Sphere.lean, open at p ≠ q.
- **O5.** The Lean note under Lemma L216 in second-order.md omits L216Sphere.lean and the balanced-product discharge of the gap.
- **O6.** The file docstring's "so no critical point lies there" claims the record's inference, which the theorem does not carry (item C). The theorem's own words should stop at the sign of the derivative.

## Overall verdict

CONFIRMED WITH OBSERVATIONS. `Le_gap_balanced` and `L216_sphere` are correct, sorry-free, and use the record's γ = 1/(n − 2) at the balanced product. Step 1, equivariance, L143's M and the non-criticality inference remain with the record, and the row and record note need O4 and O5 to say so consistently.
