# REVIEW r1898: L217Bal.lean, Lemma L217 corollary (a) at the balanced orbit

*Gate 2 review of [L217Bal.lean](../lean/HamiltonsCubic/Results/L217Bal.lean) at commit 85ce054f, which claims Lemma L217's corollary (a) kernel-checked in full. The theorem is faithful to the record, its proof uses exactly the record's two uses of global maximality, and it depends on the standard three axioms only. The observations concern presentation: the conclusion is stated as P(W_{m,m}) rather than the numeral θ₀(n), the gap lemma restates one already on file, and the header's owed clause names one of the two owed items.*

| # | Claim | Verdict |
|---|---|---|
| 1 | "Some orbit point U·W\* with pairing ≥ √(1 − (3/(n−2))²)" is the record's "within geodesic angle arcsin(3/(n−2)) of the balanced orbit", P(W_{m,m}) is θ₀(n), and m ≥ 4 (n ≥ 8) is a correct generalisation of n ≥ 12 | CONFIRMED WITH OBSERVATIONS |
| 2 | `Le_bound_balanced`: ⟨L_e H,H⟩ ≤ (m−2)/(2(m−1))‖H‖² on Weyl H ⊥ W_{m,m}, ⊥ the ½-eigenvectors, and (m−2)/(2(m−1)) = ½ − 1/(n−2) | CONFIRMED WITH OBSERVATIONS |
| 3 | The proof of `L217_balanced` is the record's proof, with no extra use of global maximality, and handles s = 0 | CONFIRMED |
| 4 | Hypothesis inventory and axioms (standard three) | CONFIRMED |
| 5 | lean/INDEX.md L217 (statement) row and the findings/second-order.md L217 header note | CONFIRMED WITH OBSERVATIONS |

**One line.** `L217_balanced` is Lemma L217 corollary (a) at every balanced product n = 2m ≥ 8, sorry-free on propext, Classical.choice and Quot.sound, and the record's n ≥ 12 is where the conclusion names Conjecture A's value rather than a condition the proof needs.

## Conventions

- n = 2m, T ⊆ Fin n with |T| = |Tᶜ| = m, M = W_{m,m} = restrict(diagOp(t·sphereWeight T)) with t > 0 fixed by ‖diagOp(t·sphereWeight T)‖² = 1.
- D = |T| + |Tᶜ| − 2 = n − 2. θ = t(n − 1) = P(M).
- `LeLin a` is v ↦ (P(a)⁻¹a) ∘ v, the record's L_e with e = a/θ_a ([L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean) line 87).
- `rotR U W` is the O(n) frame change U·W, and `IsOrth U` ranges over all of O(n), reflections included, as the record's orbit O(n)·u does.
- Geodesic distance on the unit sphere of 𝒲ₙ is arccos of the inner product.

## Hypothesis inventory of L217_balanced

| Hypothesis | Content | Record's counterpart |
|---|---|---|
| `hp : 4 ≤ T.card`, `hpq : Tᶜ.card = T.card` | balanced product, m ≥ 4 | n = 2k ≥ 12 (see section 1) |
| `t`, `ht : 0 < t`, `hn` | the unit balanced product | "u the unit Weyl tensor of S^k × S^k" |
| `hWW`, `hW1` | W is a unit Weyl tensor | W\* on the unit sphere of 𝒲ₙ |
| `hmax` | P(R) ≤ P(W) for every unit Weyl R | W\* a global maximiser |
| `hnear` | ∃ U orthogonal with ⟨U·W, M⟩ ≥ √(1 − (3/(n−2))²) | W\* within arcsin(3/(n−2)) of the orbit |

No gap hypothesis, no criticality hypothesis and no first-variation hypothesis remain: all three are discharged inside the file. Every hypothesis is satisfiable: t exists by scaling, a global maximiser exists by compactness, and `hnear` is the corollary's genuine premise.

## 1. Fidelity

**The nearness set.** The record's distance from W\* to O = O(n)·M is φ = min_U arccos⟨W\*, U·M⟩. Since `rotR` is an isometry with adjoint `rotR Uᵀ` on Weyl tensors (L3Local's `innerOp2_rotR_adj`), ⟨W\*, U·M⟩ = ⟨Uᵀ·W\*, M⟩, so cos φ = max_U ⟨U·W\*, M⟩, the maximum attained by compactness of O(n) (`exists_max`). Then:

- If φ ≤ arcsin(3/(n−2)) ≤ π/2, then cos φ ≥ cos arcsin(3/(n−2)) = √(1 − (3/(n−2))²), because cos is decreasing on [0, π]. The maximising U satisfies `hnear`.
- If some U has ⟨U·W\*, M⟩ ≥ √(1 − (3/(n−2))²) ≥ 0, then cos φ ≥ that value, so φ ∈ [0, π/2] and φ ≤ arcsin(3/(n−2)).

The two sets are equal. The record's restriction φ ∈ [0, π/2] is implied by the pairing bound and is handled in Lean by `hc0 : 0 ≤ c`, which follows from `Real.sqrt_nonneg` (line 111). The radicand 1 − 9/D² is positive since D ≥ 6 (`hD6`), and the code also covers the negative case (line 177) although it cannot arise.

**The value θ₀(n).** The theorem concludes P(W) = P(M), and the docstring and INDEX row add "= θ₀(n)". That identification is correct: θ₀(n)² = 2(n−1)(n−2)/n² is the unit balanced product's value. As a screen, L212's closed form at k = 2, n₁ = n₂ = m gives θ² = 2/(1 + 4/(n−2) − 1/(n−1)) = 2(n−1)(n−2)/n², and in Lean [L2Operators.lean](../lean/HamiltonsCubic/Results/L2Operators.lean)'s `theta_sq_sphere` gives θ² = `thetaSpSq` at every unit sphere product, the route by which the tree already identifies the value. L217Bal itself does not import that step, so the numeral θ₀(n) is carried by name (O1). Since W is a global maximiser, P(W) = sup P, so the Lean conclusion is the record's "sup P = θ₀(n)".

**n ≥ 8 against the record's n ≥ 12.** The generalisation is correct.

- The gap: [L216](../findings/second-order.md)'s corollary states "At the balanced product, n = 2m ≥ 8, this is γ = 1/(n−2)". From L3_gap, the top eigenvalue off ½ is max(λ_m, μ) with λ_m = (m−2)/(2(m−1)) and μ = (n−2)/(2(m−1)²) = 1/(m−1). λ_m ≥ μ iff m ≥ 4, with equality at m = 4, so γ = ½ − λ_m = 1/(2(m−1)) = 1/(n−2) for every m ≥ 4, and at m = 3 the gap closes (μ = ½), which is the (3,3) exclusion.
- The cap: 3γ = 3/(n−2) ≤ ½ iff n ≥ 8, with equality at n = 8, so min(3γ, ½) = 3/(n−2) throughout, and [L217.lean](../lean/HamiltonsCubic/Results/L217.lean)'s `three_gamma_le_half` records the same threshold.
- The record's n ≥ 12 is where θ₀(n) is Conjecture A's value. At n = 8 and 10, √(3/2) > θ₀(n) (the L2/L44 threshold), so sup P > θ₀(n) and the Lean theorem there says no global maximiser lies in the tube, which is corollary (b)'s exclusion reading. The Lean statement is stronger than the record's and true (O2).

## 2. Le_bound_balanced

The proof applies [L3Quad.lean](../lean/HamiltonsCubic/Results/L3Quad.lean)'s `quad_le_of_gap` to the symmetric operator `LeRestr` on M^⊥ ∩ 𝒲ₙ, with c = ½ and l\* = (m−2)/(2(m−1)). Its spectral hypothesis (every eigenvalue μ ≠ ½ on a nonzero vector is ≤ l\*) is [L3Gap.lean](../lean/HamiltonsCubic/Results/L3Gap.lean)'s `L3_gap_balanced`, fed the eigenvector's Weyl property, orthogonality to M and nonzeroness through `tanV` (lines 62 to 66). The orthogonality hypothesis is `horb` transported through `tanV` (line 67). `‖v‖² = normSq2 H` is `RecCurv.norm_sq_eq`, and the inner product identification is `rfl`.

Against `L3_hessian`: that lemma gives hessQ(M)(H) ≤ −6θ/(n−2)·‖H‖², and hessQ = 6(θ⟨L_eH,H⟩ − ½θ‖H‖²) turns it into ⟨L_eH,H⟩ ≤ (½ − 1/(n−2))‖H‖², the same bound. The identity (m−2)/(2(m−1)) = ½ − 1/(2(m−1)) = ½ − 1/(n−2) is checked in the file as `hγ` (lines 201 to 204), with n − 2 = 2(m − 1). [L216Sphere.lean](../lean/HamiltonsCubic/Results/L216Sphere.lean)'s `Le_gap_balanced` already proves the unit-norm form of the same bound through `L3_hessian` (O3).

## 3. The proof of L217_balanced

The record's steps map as follows.

| Record | Lean |
|---|---|
| step 1, φ attained at u₁ = g·u | `exists_max W M` gives U₀ maximising U ↦ ⟨U·W, M⟩, and V' = U₀·W, c = ⟨V', M⟩ (lines 104 to 109). The record moves u to u₁, the Lean moves W\* to V', equivalent by equivariance, and P(V') = P(W) by `Pcubic2_rotR` |
| c = cos φ ≥ 0 | `hc_ge` from `hnear` and maximality at U₀ (line 110), `hc0` from it |
| W\* = c u₁ + s V | h = V' − cM, ⟨M, h⟩ = 0, ‖h‖² = 1 − c², s = √‖h‖², v = h/s, V' = cM + sv (lines 112 to 122, 167, 186, 206) |
| V ⊥ T_{u₁}O by first variation | `first_order` gives ⟨orbitOp(j,k), V'⟩ = 0 at each cross pair j ∈ T, k ∈ Tᶜ, with ⟨orbitOp, M⟩ = 0 from `orbitOp_props`, so ⟨crossOrbit q, h⟩ = 0 (lines 123 to 136), then `L27_half_span` puts every ½-eigenvector of L_e in M^⊥ into the span of `crossOrbit`, so v is orthogonal to all of them (lines 194 to 198) |
| the gap at V | `Le_bound_balanced` at v with ‖v‖ = 1, then `hγ` (lines 199 to 205) |
| s ≤ min(3γ, ½) | from c² ≥ 1 − 9/D² and c² + s² = 1, then 3/D ≤ ½ from D ≥ 6 (lines 172 to 184) |
| steps 2 to 5 | `L217_op_Le` with u = M, θ = t(n−1) (line 211) |
| m ≥ P(u) | `hPV'` from `hmax M` (line 151) |

The first-variation step needs only orthogonality to the cross generators, because the within-factor rotations fix M and `L27_half_span` is an iff whose ⇒ direction is what is used. `first_order` uses maximality of the orbit pairing, which is the first variation of distance and involves P nowhere.

**Uses of global maximality.** `hmax` enters exactly twice: at M, giving P(M) ≤ P(W) (the record's m ≥ P(u) = θ_u), and at every unit Weyl R inside `L217_op_Le` (the record's P(V) ≤ m in step 3). Nothing else consumes it. `exists_max` and `first_order` are independent of it.

**The case s = 0.** Then h = 0, 1 − c² = 0, and c ≥ 0 excludes c = −1, so c = 1 and V' = M, giving P(W) = P(V') = P(M) directly (lines 154 to 165). This is the record's "At φ = 0, W\* ∈ O and m = θ_u". The branch s > 0 passes s ≥ 0 to `L217_op_Le`, which also accepts s = 0, so the split is a convenience for dividing by s.

## 4. Axioms

`#print axioms` in a scratch file importing the built module (after waiting on `pgrep -x lake`):

```
'HamiltonsCubic.L217Bal.L217_balanced' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L217Bal.Le_bound_balanced' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`grep -c sorry` on the file returns 0, and the background tree build log ends "Build completed successfully".

## 5. The INDEX row and the record's header

The L217 (statement) row in [lean/INDEX.md](../lean/INDEX.md) adds L217Bal.lean to the file list and a "Corollary (a), the balanced orbit, PROVED" clause that states both theorems accurately: the gap as (m−2)/(2(m−1))‖H‖² = (½ − 1/(n−2))‖H‖², the nearness as the pairing with its geodesic reading, the L3Local machinery, and the standard three axioms. The owed clause names the lemma at a general gapped critical orbit (its first-variation step needs the orbit derivative at an arbitrary Weyl u) and corollary (b) at the unbalanced sphere products. Both are genuinely owed. On (b), `first_order` is stated for any weight w, and [L216Unbal.lean](../lean/HamiltonsCubic/Results/L216Unbal.lean)'s `Le_gap_sphere` already gives the gap in the bounded form, so the remaining work is smaller than the clause suggests (O4).

The [findings/second-order.md](../findings/second-order.md) L217 header now reads "Corollary (a) is kernel-checked in full as `L217_balanced` ... the Lean owes the first-variation step at a general gapped critical orbit". That is accurate for (a). It names one of the INDEX row's two owed items and omits corollary (b) (O5).

## Verdict

**CONFIRMED WITH OBSERVATIONS.** `L217_balanced` is the record's corollary (a) at every balanced product with m ≥ 4, with the nearness hypothesis equal as a set to the geodesic tube, no hypothesis beyond the record's, and the standard three axioms.

**The falsifying object** would be an orthogonal U and a unit Weyl global maximiser W with ⟨U·W, W_{m,m}⟩ ≥ √(1 − (3/(n−2))²) and P(W) > P(W_{m,m}), or, for fidelity, a W within geodesic angle arcsin(3/(n−2)) of the orbit admitting no such U. The first is excluded by the kernel-checked proof. For the second, I derived the equality of the two sets by hand from compactness of O(n) and the adjointness of `rotR`. I also checked the arithmetic identities ((m−2)/(2(m−1)) = ½ − 1/(n−2), 3/(n−2) ≤ ½ at n = 8, λ_m ≥ μ iff m ≥ 4, L212's closed form reducing to θ₀(n)²) by hand as screens, read every dependency's statement, and ran `#print axioms`. No numerical run was needed or made.

## Observations

- **O1.** The conclusion is `Pcubic2 W = Pcubic2 W_{m,m}`, and "= θ₀(n)" in the docstring and the INDEX row rests on the identification in [L2Operators.lean](../lean/HamiltonsCubic/Results/L2Operators.lean)'s `theta_sq_sphere` together with [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s `thetaSplitSq_balanced` (`thetaSplitSq m m = theta0Sq (2m)`), neither of which L217Bal invokes. A one-line corollary composing the two would make the numeral kernel-checked in the same file.
- **O2.** The Lean statement holds at n = 8 and 10, beyond the record's n ≥ 12. There, since √(3/2) > θ₀(n), it reads as an exclusion: no global maximiser lies within arcsin(3/(n−2)) of the balanced orbit (at n = 8 the radius is arcsin ½ = π/6). The record's corollary (a) could note this, since it is a statement the record does not currently make.
- **O3.** `Le_bound_balanced` is the non-unit restatement of [L216Sphere.lean](../lean/HamiltonsCubic/Results/L216Sphere.lean)'s `Le_gap_balanced`, reached through `quad_le_of_gap` and `L3_gap_balanced` rather than `L3_hessian`. Both are correct. The second copy could be derived from the first by scaling.
- **O4.** The owed corollary (b) is closer than the INDEX clause suggests: `first_order` already covers every sphere-product weight, and `Le_gap_sphere` with `horb_of_orbit` supplies the gap and the orbit-normal step at every (p, q) off (3,3). What remains is the analogue of this file with `lamTop` in place of (m−2)/(2(m−1)) and a comparison against a value above θ_{p,q}.
- **O5.** The findings header's owed clause names only the first-variation step at a general gapped orbit, while the INDEX row also owes corollary (b). Aligning the two would keep a reader of the findings file from taking (b) as done.
- **O6.** Pre-existing and outside this commit (introduced at 369a0370): corollary (a)'s text in findings/second-order.md reads "gives $\gamma=1/(n-2)$ * **So if some ...", with a stray asterisk and no full stop between the italic clause and the bold sentence.
- **O7.** The INDEX row's status column reads **proved** while its owed clause lists two items. The status predates this commit and was left unchanged, so this is a convention question for the row rather than a defect of L217Bal.
