# REVIEW r1130: Gate 2 of the Lean proofs of L238 (i) and L243, and R39's spread caps

Brief: [2026-09-25-gate2-lean-spread-brief.md](2026-09-25-gate2-lean-spread-brief.md). Log: [agent_logs/r1130.log](../agent_logs/r1130.log). Analysis only, with seconds-scale screens on objects constructed for the purpose (one Lean scratch file compiled against the built library, two short Python checks), reported as screens.

| Item | Verdict |
|---|---|
| 1. A, statements | CONFIRMED |
| 2. A, completeness | PLAUSIBLE: nothing is mathematically unproved, but the r = k branch lives in `frame_bound`, and "L243 fully in Lean" holds for r = n − 1 only until the two are assembled |
| 3. B, mean-spread identity | CONFIRMED |
| 4. B, Jensen step | CONFIRMED |
| 5. B, scope | CONFIRMED (nothing proved rests on the envelope), with a defect in the screen: the computed envelope undershoots the true φ_12 near q = 1/6, so the spread caps are not valid constraints as computed |

## Item 1: the Lean statements match the record

- `frame_gaussian_form` ([GaussianPairForm.lean](../lean/HamiltonsCubic/Results/GaussianPairForm.lean)): the left side is the sum over ordered pairs i ≠ j of −½ tr([X_i,X_j]²), which is ‖[X_i,X_j]‖² in the record's norm. The right side is the standard Gaussian mean (`Measure.pi` of `gaussianReal 0 1`) of Σ_{i≠j}(G_ii G_jj − G_ij²) with G_ij = ⟨X_i v, X_j v⟩, minus 4k(k−1). The constant elaborates in ℝ (the binop elaborator casts the leaf `k`), and at k = 7 it is 168, as L238 (i) states.
- `hnorm` (tr X_i² = −2) is ⟨X_i,X_i⟩ = 1 and `horth` (tr X_iX_j = 0 for i ≠ j) is ⟨X_i,X_j⟩ = 0, so the hypotheses are exactly the record's orthonormality plus skewness. None is vacuous: any orthonormal family of skew matrices satisfies them.
- `L243_frame` ([GaussianRankStep.lean](../lean/HamiltonsCubic/Results/GaussianRankStep.lean)): P = Σ X_iᵀX_i = Σ(−X_i²) is the record's P, tr P = 2k is derived inside the proof (`htrP`) and not assumed, r = n − 1 with n ≥ 2, and the conclusion is L243's frame-level inequality at that r. At n = 2 the factor 1 − 1/(n−1) is 0 and the bound reads T ≤ −4k(k−1), true since so(2) holds no orthonormal pair.
- `#print axioms` on `frame_gaussian_form` and `L243_frame` gives only propext, Classical.choice, Quot.sound (screen, run against the built library). No `sorry` in either file.
- Aside, outside the brief's claims: L238 (ii)'s refinement r = d − 1 with d = rank P (v restricted to ran P) is not what `L243_frame` states, which uses the ambient n. The INDEX row for L238 already lists it as untyped.

## Item 2: completeness of the frame-level L243

- The record's L243 takes r = min(k, n − 1). `L243_frame` proves the r = n − 1 branch only, which is the stronger branch exactly when k ≥ n − 1.
- **The r = k branch is already proved, in a different file and not through `trace_sq_le_k`.** At r = k the right side is (1 − 1/k)(4k² + 2 tr P²) − 4k(k−1) = 2(1 − 1/k) tr P², which is precisely `frame_bound` in [FrameGaussianBound.lean](../lean/HamiltonsCubic/Results/FrameGaussianBound.lean) (skewness only, orthonormality unused, Gaussian-free). Its `frameT` is Σ_{i,j}(tr X_i²X_j² − tr X_iX_jX_iX_j), equal to the ordered bracket total for skew X_i.
- Screen: a scratch file restating the r = k branch in `L243_frame`'s exact shape (bracket total written with `if i = j`, P = Σ X_iᵀX_i) and proving it from `frame_bound` compiles in about thirty lines, standard three axioms. The min-assembly is then two cases and a `min` lemma.
- **Corrections.** The docstring "L243, fully in Lean" on `L243_frame`, the INDEX phrase "L243's cap at the frame level with no analytic hypothesis", and second-order.md's "The cap is proved in Lean at the frame level" each hold at r = n − 1. They should say so, and name `frame_bound` as the r = k branch, or the assembled `min` theorem should be added. The brief's row "The rank-k bound: `trace_sq_le_k` (proved, not assembled into a cap)" points at the wrong declaration: `trace_sq_le_k` would need integrating, while `frame_bound` is the cap already.
- Nothing the record claims at frame level is left unproved. The class-form reading (tr P² = Σ G_ab, T = Σ τ_abc) is untyped and is recorded as such.

## Item 3: the mean-spread identity

- Fourth moment on the unit sphere of ℝ^m: E ξ_α⁴ = 3/(m(m+2)), E ξ_α²ξ_β² = 1/(m(m+2)) for α ≠ β, odd moments zero. This is the stated Kronecker formula.
- E tr x⁴ = [Σ tr(Ψ_α²Ψ_γ²) + Σ tr(Ψ_αΨ_βΨ_αΨ_β) + Σ tr(Ψ_αΨ_β²Ψ_α)]/(m(m+2)). With Σ Ψ_α² = −A_c (A_c = Σ Ψ_αΨ_αᵀ, the record's isotropy matrix, and Ψᵀ = −Ψ), the first and third terms are each tr A_c² = G_cc.
- For skew X, Y: ‖[X,Y]‖² = −½ tr([X,Y]²) = tr X²Y² − tr XYXY by cyclicity, so Σ tr(Ψ_αΨ_βΨ_αΨ_β) = G_cc − τ_cc·, with τ_cc· = Σ_{α,β∈E_c} ‖[ψ_α,ψ_β]‖² = Σ_{c'} τ_{cc c'} over ordered pairs, which is the record's τ_ab = Σ_c τ_abc at a = b = c (T_αβγ = ⟨[v_α,v_β],v_γ⟩², the eigenframe being a full orthonormal basis of so(n)). **τ_cc· is the right sum.** Total (3G_cc − τ_cc·)/(m(m+2)).
- Unit x (in the record's norm) has Σ s_i² = 1, and eigenvalues ±i s_i give tr x⁴ = 2Σ s_i⁴.
- The S⁵×S⁷ value: the Λ²ℝ⁵ class is the so(5) block, m = 10, A_c = 4·I_5, G_cc = 80, τ_cc· = 10·2·3 = 60 (L153's row mass at n = 5), so (240 − 60)/240 = 0.75.
- Screen (Monte Carlo, 10⁵ samples, on constructed subspaces): random 5-dimensional subspace of so(7) predicted 1.13518, sampled 1.13579 ± 0.00056; random 9-dimensional subspace of so(6) predicted 1.27880, sampled 1.27857 ± 0.00067; the so(5) block of so(12) gives E Σ s_i⁴ = 0.7485 ± 0.0009 against 0.75.

## Item 4: the Jensen step

- If κ_r(x) ≤ φ_r(q(x)) pointwise with φ_r concave on the convex range of q = Σ s_i⁴ (at n = 12, q ∈ [1/6, 1]), then E κ_r ≤ E φ_r(q) ≤ φ_r(E q). Correct.
- 2R_a(x) = 2Σ_b b_ab(x) = Σ_{γ∈E_a} ‖[x,ψ_γ]‖² (L244 (i)'s proof, by invariance over the full eigenframe) is a quadratic form in x. So Σ_{α∈E_c} 2R_a(ψ_α) is basis-independent, equals τ_{ca·} = Σ_{α∈c,γ∈a} ‖[ψ_α,ψ_γ]‖² (= τ_{ac·}), and equals m_c E_x 2R_a(x). The Haar average is therefore not needed: the trace of a quadratic form over E_c is m_c times its mean on the unit sphere. With the source cap 2R_a(x) ≤ κ_r(x) this gives τ_{ca·} ≤ m_c φ_r((3G_cc − τ_cc·)/(2m_c(m_c+2))).
- The r must be the source cap's: m_a for a ≠ c, m_c − 1 for a = c, m_b + m_d for a union. Each is fixed by the multiplicities, so for a fixed spectrum type each supporting line u + v·q ≥ φ_r gives τ_{ca·} ≤ m_c u + v(3G_cc − τ_cc·)/(2(m_c + 2)), linear in (τ, G). Valid as long as the line majorises φ_r on the whole q-range, which holds for a supporting line of the true concave envelope.
- The note's remark that Ky Fan quantities are convex in −ad_x² and so average from below is correct and is why the envelope in q is needed.

## Item 5: scope

- **Nothing stated as proved rests on the numerical envelope.** The working note keeps φ_r as owed, and its "spread envelope, computed" section labels the caps and the 177-of-2080 count as screens. The brief's context line agrees.
- **Defect in the screen: the computed envelope is an inner approximation and undershoots the true φ_12.** Two causes. SLSQP from 40 starts returns lower bounds on the maximum at each grid q, and the hull is linearly interpolated between 41 grid points. The second bites near q = 1/6: q = 1/6 forces equal angles (x = J/√6, κ_12 = 8 exactly), q − 1/6 is quadratic in a perturbation of the angles while κ_12 changes linearly (the 30-fold eigenvalue 2/3 splits), so the true φ_12 has a vertical tangent at q = 1/6 and lies above every chord from (1/6, 8).
- Explicit counterpoints (screen, evaluated from the angle formula for −ad_x² on so(12)): angles J/√6 + 0.05·(1,1,1,1,−2,−2)/‖·‖, renormalised, give q = 0.16827 and κ_12 = 8.554 against the computed hull 8.156; with 0.1 instead, q = 0.17275, κ_12 = 9.081 against 8.586. Four perturbation directions all exceed the hull.
- Consequence: a spread cap evaluated at a class mean q in that window, or a supporting line through the hull's left end, excludes points the true φ_12 allows. The note's word "Sound" for the 177-of-2080 screen should be withdrawn: the S⁵×S⁷ control checks one point, and the count may over-exclude. A valid screen needs an outer bound on φ_r (analytic, or the grid maxima inflated by a proven modulus plus the √(q − 1/6) behaviour at the left end).
- Minor: the note says "κ_r depends on spread only for r ≤ 20". Its own saved data (agent_logs/spread_envelope.npz) show the hull at q = 1/6 equal to 2r/3 < 20 for every r ≤ 29, and 20 flat only from r = 30 (the equal-angle x has exactly 30 nonzero eigenvalues). The threshold should read r ≤ 29.
