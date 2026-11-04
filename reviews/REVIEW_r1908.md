# r1908: coverage audit of seven statement-only rows

Seven numbered results, L190, L199, L204, L205, L206, L207 and L229, carry a "L&lt;n&gt; (statement)" row marked **proved** in [lean/INDEX.md](../lean/INDEX.md) and no result row, so [lean_debts.py](../scripts/misc/lean_debts.py) lists them as statement only. This audit reads each record block against the Lean its statement row names. **Verdict: none of the seven warrants a result row marked proved. Six are PARTIAL and L207 is a FRAGMENT.** Every carrying declaration is gap-free, resting on `propext`, `Classical.choice` and `Quot.sound` or a subset, with no `sorryAx` and no `native_decide`. What separates the files from the records is scope and inputs, and the kernel check is clean throughout.

| Result | Carrying declarations | Verdict | Owed |
|---|---|---|---|
| L190 | sdCombo_sq_eq_half_norm, sdCombo_nondecomposable, ricci_at_witness, minkowski_saturated_at_witness | PARTIAL | the five-parameter family as rank-three Weyl tensors (Bianchi and Ricci-flatness at a general Λ⁺ basis with traceless weights), padded W_CP2's eigenforms identified with unitSD, the Λ⁸V scoping of the cross term |
| L199 | G_eq_sharp, trace_Gmat_weyl | PARTIAL | general n (the file is n = 4 over ℚ), the L131-composed form, the deficit 12 Alt(W²)_γγ = 4(2m−1)/(3m) at CP^m |
| L204 | alt_le_altConst_trace, wedge_normSq, trace_bound, altConst_le_altConstN, altConst_eq_altConstN_of_even, altConst_lt_altConstN_n9 | PARTIAL | Alt(A) = (1/6)Σ μ_α ω_α∧ω_α for a PSD A (hT defines T instead), tr A = Σ μ_α, optimality and attainment (balanced u, W_CP2) |
| L205 | mutually_orthogonal | PARTIAL | isotropy Σ Π_α = Id from the stratum's hypotheses, the adapted frame, coordinate-diagonality, uniqueness up to O(n), Ricci-flatness of the perfect-matching tensor |
| L206 | trace_form_bound, bound_attained_n4, traceFormDenom_lt_succ, floor_arith, third_term_le, floor_n12 | PARTIAL | the passage from a critical point to htr and htr2 (the two trace identities, self-adjointness of L_e, the multiplicities p and m), monotonicity in m at k = D − p − m, an assembled n ≥ 5 floor theorem, the padded W_CP2 looseness figures |
| L207 | mu_eq_half_iff, only_three_three, choose_two_add, orbit_dim_eq_mul, sector_dims_eq_weylDim | FRAGMENT | the whole spectral statement: L_e, the sector decomposition, dim E_{1/2}(L_e) at every split with p, q ≥ 2, the orbit-direction mechanism, the p = 2 spectrum |
| L229 | phase_deficit, phase_le_cap, collinear_eq_phaseSum, collinear_deficit, cap_attained_of_boundary, capValue_affine, diagonal_matches | PARTIAL | item 2's max_θ g = Λ[cap − dist(1,𝒜)²], item 3's best diagonal value as cap − Λ·collinearDist², the reduction from the block problem (L226, batch 11), the passage back to blocks diagonal in F, attainment |

## 1. L190

**Record** ([diagonal-half.md](../findings/diagonal-half.md), Lemma L190). *"[L189] leaves one case, and unlike its four predecessors it is INHABITED. Padded $W_{\mathbb{CP}^2}$ has $W^-=0$, so its three eigenforms lie in $\Lambda^+\mathbb R^4$; a nonzero self-dual $2$-form on $\mathbb R^4$ satisfies $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ and so has rank four."* *"AND THE CASE IS A FIVE-PARAMETER FAMILY RATHER THAN A POINT. Every $\omega\in\Lambda^+\mathbb R^4$ satisfies $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ and $\omega\wedge\omega=\lVert\omega\rVert^2f_{1234}$, so ANY orthonormal basis of $\Lambda^+\mathbb R^4$ carrying ANY nonzero traceless weight vector is such a tensor"*. *"So [I38]'s question AT RANK THREE is exactly: can the three-non-decomposable case have $\dim V>4$?"* The block adds the Minkowski saturation on the Ricci leg and the scoping of the Bianchi cross term to Λ⁸V.

**Lean** ([L190Statement.lean](../lean/HamiltonsCubic/Results/L190Statement.lean)).

- `sdCombo_sq_eq_half_norm (x y z : ℝ) : sdCombo x y z * sdCombo x y z = (-(1 / 2) * inner2 (sdCombo x y z) (sdCombo x y z)) • 1`
- `sdCombo_nondecomposable (x y z : ℝ) (h : x ^ 2 + y ^ 2 + z ^ 2 ≠ 0) : ∃ ν, sdCombo x y z * ν = 1`
- `ricci_at_witness : (2 : ℝ) • (unitSD 0 * (unitSD 0)ᵀ) = unitSD 1 * (unitSD 1)ᵀ + unitSD 2 * (unitSD 2)ᵀ`
- `minkowski_saturated_at_witness : det(2 • (unitSD 0 * (unitSD 0)ᵀ)) ^ (1/4) = det(unitSD 1 * (unitSD 1)ᵀ) ^ (1/4) + det(unitSD 2 * (unitSD 2)ᵀ) ^ (1/4)`

**Comparison.**

- The self-dual square identity is typed at every member of Λ⁺ℝ⁴, and non-decomposability is typed as invertibility. That reading is sound at n = 4 (invertible means rank four) and is a proxy rather than the record's rank statement.
- **No declaration says the family consists of Weyl tensors.** The record's claim that any orthonormal Λ⁺ basis with any nonzero traceless weight vector gives a rank-three Weyl tensor (first Bianchi through ω∧ω = ‖ω‖²f₁₂₃₄, Ricci-flatness) has no declaration. The file types the forms, never a tensor built from them.
- The identification of padded W_CP2's eigenforms with the unitSD forms is untyped. W_CP2 and its spectrum live in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), and no declaration links them to unitSD.
- ricci_at_witness is the Gram identity at the witness, taken with rescaling weights (2, 1, 1) chosen by hand. It is the rescaled Ricci reading at the witness and matches the record's clause there.
- ω∧ω = ‖ω‖²f₁₂₃₄ has no declaration.
- The Λ⁸V cross-term scoping is untyped, and the file and the statement row both say so.
- "The question is exactly dim V &gt; 4" is a composition with L185, L186 and L189 and is untyped here.

**Axioms.** All four carrying declarations: `[propext, Classical.choice, Quot.sound]`.

**Verdict: PARTIAL.**

## 2. L199

**Record** ([bounds.md](../findings/bounds.md), Lemma L199). *"Let $W$ be any symmetric operator on $\Lambda^2\mathbb R^n$ and let $G_W$ be the symmetric operator with $\langle G_Wx,x\rangle=\lVert[\mathrm{ad}(x),W]\rVert^2$, whose diagonal in an eigenbasis is the record's $g_k$. Then $$G_W=4\,(W^2\#I)-4\,(W\#W),$$ with no hypothesis of any kind, not first Bianchi, not Ricci-flatness, not criticality, not a dimension. Composing with Lemma L131's $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ at $R=W^2$, $$G_W=4\big(\mathrm{Ric}(W^2)\wedge\mathrm{id}\big)+12\,\mathrm{Alt}(W^2)-4W^2-4W^\#."$$* The block title adds *"the deficit of the recorded diagonal-locus identity is $12\,\mathrm{Alt}(W^2)$"*, valued at CP^m as 4(2m−1)/(3m).

**Lean** ([L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean)).

- `G_eq_sharp (R : Matrix (Fin 6) (Fin 6) ℚ) (_hR : R.IsSymm) : Gmat R = Matrix.of fun j k => 4 * sharpBil (R * R) 1 j k - 4 * sharpMat R j k`
- `trace_Gmat_weyl (R : Matrix (Fin 6) (Fin 6) ℚ) (hR : IsWeyl R) : (Gmat R).trace = 12 * (Rᵀ * R).trace`

**Comparison.**

- The record's identity is at every n, and the Lean is at n = 4 only (Fin 6 = Λ²ℝ⁴), over ℚ. The record's "not a dimension" is the clause the file does not reach.
- Gmat is defined as the Gram matrix of the commutators [ad φ_j, R] in the φ basis, which is the record's G_W. The symmetry hypothesis matches the record's "symmetric operator".
- The L131-composed form has no declaration, since Ric(W²)∧id and Alt(W²) are not built in this file. The file's header says so.
- The deficit clause (12 Alt(W²)_γγ, its CP^m value) has no declaration.
- trace_Gmat_weyl is a consequence at a Weyl tensor and is an extra, not a clause of the statement.

**Axioms.** `G_eq_sharp`, `trace_Gmat_weyl`: `[propext, Classical.choice, Quot.sound]`.

**Verdict: PARTIAL.** The #-form at n = 4 is proved in full.

## 3. L204

**Record** ([bounds.md](../findings/bounds.md), Lemma L204). *"For every positive semidefinite $A$ on $\Lambda^2\mathbb R^n$, $$\lVert\mathrm{Alt}(A)\rVert\ \le\ \sqrt{\frac{m-1}{3m}}\ \mathop{\mathrm{tr}}A,\qquad m=\lfloor n/2\rfloor,$$ in the record's norm $\lVert R\rVert^2=\tfrac14\sum R_{ijkl}^2$"*, together with the ruling that the m-form is the right one and *"THE CONSTANT IS OPTIMAL AND A WEYL TENSOR ATTAINS IT"*, equality at A = u⊗u for the balanced u and at W_CP2.

**Lean** ([L204AltBound.lean](../lean/HamiltonsCubic/Results/L204AltBound.lean)).

- `alt_le_altConst_trace {n} (hn : 2 ≤ n) (μ : Fin (n*(n-1)/2) → ℝ) (hμ : ∀ a, 0 ≤ μ a) (ω : Fin (n*(n-1)/2) → Matrix (Fin n) (Fin n) ℝ) (hskew) (hunit : ∀ a, (1/2) * ((ω a)ᵀ * ω a).trace = 1) (horth) (T) (hT : T = fun i j k l => (1/6) * ∑ a, μ a * wedgeSelf (ω a) i j k l) : Real.sqrt (tensorNormSq T) ≤ altConst (n / 2) * ∑ a, μ a`
- `wedge_normSq (w) (hw : wᵀ = -w) : tensorNormSq (wedgeSelf w) = 3 * (∑ i, ∑ j, w i j ^ 2) ^ 2 - 6 * Q4 w`
- `trace_bound (hn : 2 ≤ n) (w) (hw : wᵀ = -w) (hunit : (1/2) * (wᵀ * w).trace = 1) : 2 ≤ ((n / 2 : ℕ) : ℝ) * Q4 w`
- `altConst_le_altConstN (n) (hn : 2 ≤ n) : altConst (n / 2) ≤ altConstN n`, `altConst_eq_altConstN_of_even`, `altConst_lt_altConstN_n9 : altConst 4 < altConstN 9`

**Comparison.**

- **hT defines T as the eigen-expansion.** A PSD operator A, its spectral decomposition, and the identity Alt(A) = (1/6)Σ μ_α ω_α∧ω_α are all absent. The record's step 1 is therefore a hypothesis, and tr A appears only as Σ μ_α. The statement row itself says this.
- horth is a hypothesis the triangle-inequality proof does not need. It is harmless.
- The ruling between the two constants is typed in full (ordering at every n ≥ 2, equality at even n, separation at n = 9).
- Optimality and attainment have no declaration, at the balanced u or at W_CP2. So "sharp" and "a Weyl tensor attains it" are untyped.

**Axioms.** All six: `[propext, Classical.choice, Quot.sound]`.

**Verdict: PARTIAL.**

## 4. L205

**Record** ([diagonal-half.md](../findings/diagonal-half.md), Lemma L205). *"When the positive eigenspace has dimension $a=n/2$, isotropy reads $\sum_{\alpha\in A}\Pi_\alpha=\mathrm{Id}_n$, and multiplying by $\Pi_\alpha$ gives $\sum_{\beta\ne\alpha}\Pi_\alpha\Pi_\beta=0$, whose trace is $\sum_{\beta\ne\alpha}\lVert\Pi_\alpha\Pi_\beta\rVert_F^2=0$ with every term nonnegative, so every product vanishes and the $n/2$ planes are mutually orthogonal. They sum to $\mathbb R^n$, so an orthonormal basis chosen in each gives a frame with $\omega_\alpha=f_{2\alpha-1}\wedge f_{2\alpha}$, and at two eigenvalues $W=\lambda_-\mathrm{Id}+(\lambda_+-\lambda_-)\Pi_A$ is determined by $\Pi_A$ alone, hence coordinate-diagonal in that frame."* *"the unique solution up to $O(n)$ is the perfect-matching tensor, $\lambda_+=n-2$ on $n/2$ disjoint planes and $-1$ elsewhere"*, with Ricci-flatness in one line, *"So the $\kappa=1$ stratum contains exactly one object and it is a product of two-spheres"*.

**Lean** ([L205Kappa1.lean](../lean/HamiltonsCubic/Results/L205Kappa1.lean)).

- `mutually_orthogonal (P : Fin m → Matrix (Fin n) (Fin n) ℝ) (hsymm : ∀ a, (P a)ᵀ = P a) (hidem : ∀ a, P a * P a = P a) (hsum : ∑ b, P b = 1) {a b : Fin m} (hab : a ≠ b) : P a * P b = 0`
- supporting: `sum_offDiag_eq_zero`, `trace_sum_offDiag_eq_zero`, `l205_trace_eq_normSq`

**Comparison.**

- The mutual-orthogonality step is typed in full generality (any symmetric idempotents, no rank two, no count n/2).
- Isotropy Σ Π_α = Id is a hypothesis. The record derives it from a two-eigenvalue point of the decomposable locus with a = n/2, and that derivation is untyped.
- The frame, the ω_α = f_{2α−1}∧f_{2α} form, coordinate-diagonality, uniqueness up to O(n), the perfect-matching spectrum and its Ricci-flatness have no declarations. These carry the lemma's title claim ("exactly one element").
- The hypothesis r880 named (a decomposable orthonormal eigenbasis) does not appear, since the file never builds W.

**Axioms.** `mutually_orthogonal`: `[propext, Classical.choice, Quot.sound]`.

**Verdict: PARTIAL.** The file types the lemma's key step and leaves its conclusion.

## 5. L206

**Record** ([bounds.md](../findings/bounds.md), Lemma L206). *"Let $W$ be a critical point with $\theta\ne0$ and $e=W/\theta$. Let $p=\dim E_1(L_e)$, let $m=\dim E_{1/2}(L_e)$, let $D=\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ and $k=D-p-m$. Then $$\theta^2\ \le\ \frac{\kappa(n)}{\,p+\dfrac m4+\dfrac{(2p+m)^2}{4k}\,},\qquad \kappa(n)=\frac{(2n-1)(n-1)}4 ."$$* The block goes on to claim attainment at S²×S², monotonicity in m, the floor above 3/2 at zero excess for every n ≥ 5, and looseness at padded W_CP2 (2.5533 at n = 12).

**Lean** ([L206TraceFormBound.lean](../lean/HamiltonsCubic/Results/L206TraceFormBound.lean)).

- `trace_form_bound {k : ℕ} (hk : 0 < k) (μ : Fin k → ℝ) (p d θ κ : ℝ) (hθ : θ ≠ 0) (htr : p + d/2 + ∑ j, μ j = 0) (htr2 : p + d/4 + ∑ j, (μ j)^2 = κ / θ^2) : θ^2 * traceFormDenom p d k ≤ κ`
- `bound_attained_n4 : killingConst 4 / traceFormDenom 2 4 4 = 3/4`
- `traceFormDenom_lt_succ (p d k) (hp : 0 ≤ p) (hd : 0 ≤ d) (hk : 0 < k) : traceFormDenom p d k < traceFormDenom p (d+1) k`
- `floor_arith (n) (hn : 5 ≤ n) : 1 + n(n-1)/8 + 3/2 < 2 * killingConst n / 3`
- `third_term_le (n) (hn : 5 ≤ n) : (2 + n(n-1)/2)^2 ≤ 6 * (weylDim n - 1 - n(n-1)/2)`
- `floor_n12`, `threshold_n12_below`, `threshold_n12_at`

**Comparison.**

- The Cauchy–Schwarz step is typed in full, over abstract reals. The two trace identities are hypotheses, and so is the reading of the L_e spectrum as p ones, d halves and k real free values. The record derives that reading from criticality and the self-adjointness of L_e, which the file's header names as prose-only. The trace identities are record results elsewhere ([algebra.md](../findings/algebra.md), [second-order.md](../findings/second-order.md)), and no Lean declaration anywhere in the tree types either of them: a grep for the trace of L_e finds only this file.
- κ(n) is a definition, and the record likewise imports it from elsewhere. That is consistent with the block.
- Monotonicity is typed with k held fixed. The record's claim is monotonicity in m at k = D − p − m, which also moves k. The typed lemma is one half of it. The other half (the third term increasing as k falls) is unstated.
- The n ≥ 5 floor is two arithmetic lemmas at p = 1. No declaration composes them with traceFormDenom into "cap &gt; 3/2 at d ≤ n(n−1)/2 for every n ≥ 5".
- The padded W_CP2 figures (d = 4n − 14, looseness 1.73× to 2.65×) and the S²×S³×S³ value 1.145045 have no declarations. floor_n12 is at d = 66, which is a different point.

**Axioms.** All eight listed: `[propext, Classical.choice, Quot.sound]`.

**Verdict: PARTIAL.** A narrower reading could call the displayed inequality proved, with its spectral inputs named as imported. Under [lean/INDEX.md](../lean/INDEX.md)'s own rule that a hypothesis input is acceptable when it is classical and external, these inputs are internal record results, so the reading does not apply.

## 6. L207

**Record** ([nondegeneracy.md](../findings/nondegeneracy.md), Lemma L207). *"Let $n=p+q$ with $p,q\ge2$ and let $e=W/\theta$ for the Weyl tensor of $S^p\times S^q$, so $e=-M/(n-1)$ with $M$ the sectional matrix. Then $$\dim E_{1/2}(L_e)\;=\;pq\;+\;\binom p2\binom q2\cdot\big[\,\mu=\tfrac12\,\big],\qquad \mu=\frac{n-2}{2(p-1)(q-1)},$$ and $\mu=\tfrac12$ exactly when $(p-2)(q-2)=1$, which is $p=q=3$ alone. Since the orbit dimension is $\binom n2-\binom p2-\binom q2=pq$, the excess is $0$ at every split except $S^3\times S^3$, where it is $\binom32^2=9$."*

**Lean** ([L207SphereExcess.lean](../lean/HamiltonsCubic/Results/L207SphereExcess.lean)).

- `mu_eq_half_iff (p q : ℚ) (hp : p ≠ 1) (hq : q ≠ 1) : mu p q = 1/2 ↔ (p - 2) * (q - 2) = 1`
- `only_three_three {p q : ℕ} (hp : 2 ≤ p) (hq : 2 ≤ q) (h : (p - 2) * (q - 2) = 1) : p = 3 ∧ q = 3`
- `choose_two_add (p q : ℕ) : (p + q).choose 2 = p.choose 2 + q.choose 2 + p * q`, `orbit_dim_eq_mul`
- `sector_dims_eq_weylDim (n : ℚ) : n(n-3)/2 + (n(n-1)/2)(n-3) + 2·(n(n-1)(n-2)(n-3)/24) = n(n+1)(n+2)(n-3)/12`

**Comparison.**

- Every declaration is arithmetic on p, q, n. L_e, the orbit, the sign group, the sector decomposition and E_{1/2} appear nowhere. The headline dimension formula, the one-per-cross-pair mechanism and the p = 2 spectrum have no declarations. The statement row says this.
- The typed facts are consequences the proof combines with (the μ = 1/2 criterion, the orbit count, the sector count identity).
- The spectral content at p, q ≥ 3 off (3,3) is proved elsewhere, in the L27 files: `finrank_half` in [L27Close.lean](../lean/HamiltonsCubic/Results/L27Close.lean) gives dim E(½)∩W⊥ = pq. The p = 2 splits and the (3,3) excess of 9 are the part of L207 beyond L27, and no Lean file carries them.

**Axioms.** `mu_eq_half_iff`, `only_three_three`, `sector_dims_eq_weylDim`: `[propext, Classical.choice, Quot.sound]`. `choose_two_add`, `orbit_dim_eq_mul`: `[propext, Quot.sound]`.

**Verdict: FRAGMENT.**

## 7. L229

**Record** ([second-order.md](../findings/second-order.md), Lemma L229). *"On the common-eigenvector stratum, $\sup\Phi$ at fixed $T$ equals the supremum over the points of that stratum at which $\hat U$ and $V$ are both diagonal in $F$, and it is attained there."* Four numbered steps follow: item 1 the deficit identity, item 2 *"$\max_\vartheta g=\Lambda\big[1+\rho_1^2+\rho_2^2-\mathop{\mathrm{dist}}(1,\mathcal A)^2\big]$"*, item 3 the diagonal values and *"the best diagonal value is $\Lambda\big[1+\rho_1^2+\rho_2^2-\mathop{\mathrm{dist}}(1,\{\pm\rho_1\pm\rho_2\})^2\big]$, and it equals $\max_\vartheta g$ exactly when $1\notin\mathop{\mathrm{int}}\mathcal A$"*, and item 4 affineness in (p², r²) on the segment 3x + y = B.

**Lean** ([L229Statement.lean](../lean/HamiltonsCubic/Results/L229Statement.lean)).

- `phase_deficit (l r₁ r₂ t₁ t₂ : ℝ) : phaseCap l r₁ r₂ - phaseSum l r₁ r₂ t₁ t₂ = l * ((1 - r₂ cos t₁ - r₁ cos t₂)^2 + (r₂ sin t₁ + r₁ sin t₂)^2)`
- `phase_le_cap (hl : 0 ≤ l) : phaseSum l r₁ r₂ t₁ t₂ ≤ phaseCap l r₁ r₂`
- `collinear_eq_phaseSum`, `collinear_deficit (h₁ : e₁^2 = 1) (h₂ : e₂^2 = 1) : phaseCap l r₁ r₂ - collinear l r₁ r₂ e₁ e₂ = l * (1 - e₁ r₂ - e₂ r₁)^2`
- `cap_attained_of_boundary (h : r₁ + r₂ = 1 ∨ r₁ - r₂ = 1 ∨ r₂ - r₁ = 1) : ∃ e₁ e₂, e₁^2 = 1 ∧ e₂^2 = 1 ∧ collinear l r₁ r₂ e₁ e₂ = phaseCap l r₁ r₂`
- `capValue_affine`, the affine form in (x, y) = (p², r²)
- `diagonal_matches (c₀ c₁ c₂ l bv dA dC B : ℝ) (hl : 0 ≤ l) (hB : 0 ≤ B) (hA : 0 < dA) (hC : 0 < dC) (hbv : 0 < bv) (x y) (hx : 0 ≤ x) (hy : 0 ≤ y) (hxy : 3x + y = B) : ∃ x' y', 0 ≤ x' ∧ 0 ≤ y' ∧ 3x' + y' = B ∧ c₀ + c₁x + c₂y − l·annulusDist(...)² ≤ c₀ + c₁x' + c₂y' − l·collinearDist(...)²`

**Comparison.**

- Items 1 and 4 are typed exactly.
- **Item 2 is not typed.** annulusDist is a definition equal to the record's closed form for dist(1, 𝒜). No declaration shows that the phase sum's maximum over (t₁, t₂) equals phaseCap − l·annulusDist², in either direction. This includes the fact that the sum of the two circles is the annulus 𝒜.
- Item 3 is typed at each sign pair, and at the boundary through cap_attained_of_boundary. No declaration says that the best diagonal value is phaseCap − l·collinearDist².
- diagonal_matches is the step-5 transfer on the segment in terms of the two distance formulas, with c₀, c₁, c₂ free. Joined to capValue_affine and to the untyped item 2, it gives the step-5 domination.
- The reduction from the block problem to the phase sum (L226, batch 11), the frustration normalisation d_A, d_C, v₂ &gt; 0, the passage back to blocks diagonal in F, and attainment by compactness have no declarations. The file names the reduction and the passage back as not typed.

**Axioms.** All seven: `[propext, Classical.choice, Quot.sound]`.

**Verdict: PARTIAL.**

## Observations

**O1.** No file among the seven carries `sorry`, and none uses `native_decide`. The seven are kept out of "proved" by scope and inputs alone.

**O2.** The Lean columns of [findings/INDEX-results.md](../findings/INDEX-results.md) are stale for four of the seven. L199 reads "the operator identity and its trace carrying `sorry`", L204 "one `sorry` at the maximisation", L205 "one `sorry` at the nonnegativity", and L229 "one named `sorry`". All four files are now `sorry`-free. The L204 block in [bounds.md](../findings/bounds.md) still says *"with the bound itself carrying the one `sorry` whose gap is the maximisation"*, and the L229 block in [second-order.md](../findings/second-order.md) still says *"`diagonal_matches` types the conclusion of step 5 on the segment, as a named `sorry`"*.

**O3.** L207's INDEX-results row reads "Lean: blocked, the base layer carrying no $L_e$". The base layer now carries L_e as `Lidem` in [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), with the linear form `LeLin` in [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean) used by the L27 files, so the stated blocker is out of date. What is owed is the p = 2 and (3,3) cases on top of L27's p, q ≥ 3 result.

**O4.** L205's owed frame step has a proved counterpart: [L201](../lean/HamiltonsCubic/Results/L201Statement.lean)'s frame_of_commuting takes commuting rank-two projections to a common frame, and mutually_orthogonal gives commutation (products zero). What would remain is the O(n) uniqueness and the perfect-matching tensor's Ricci-flatness.

**O5.** The two trace identities that L206's trace_form_bound takes as hypotheses have no Lean declaration anywhere in the tree. They are the one input that keeps L206's displayed inequality from reaching a critical point in Lean.

**O6.** Of the seven, L199 and L206 are closest to a "proved" row. L199 needs its n = 4 restriction recorded as scope, or a general-n proof. L206 needs the trace identities typed.
