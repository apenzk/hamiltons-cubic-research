import HamiltonsCubic.Results.L192Statement
import HamiltonsCubic.Results.I67Pf6

/-!
# L193, the adjugate law for the Pfaffian adjugate

`ω σ(ω) = -Pf(ω)·Id` on `Λ²ℝ⁶`, which is `A adj(A) = det(A)·Id` for the Pfaffian.

**`adjugate_law` states it frame-free AND PROVES IT**, 2026-09-17, standard axioms. *It needs
neither the real skew normal form nor SO(6)-equivariance: the law is a polynomial identity in the
fifteen free entries of a skew 6x6, so a finite expansion settles it.*

**The spectral half is proved.** `adjugate_law_plane` gives `c_j·(σs)_j = Pf(s)` on each of the
three planes and `adjugate_law_agree` gives that the three values coincide, *which is what makes
the matrix product a multiple of the identity rather than block-diagonal, so it is the load-bearing
step.* `area_form_sq` carries the minus: the area form squares to minus the projection onto its own
plane, which is a fact about matrices and not about scalars.

**AND IT GIVES `StarWedgeIdentity`.** *`starWedge_of_adjugate` derives it from the adjugate law
together with `Pf(J) = ±1`*, and [I67PfSign.lean](I67PfSign.lean) proves the second, so
`starWedgeIdentity_holds` there closes the predicate outright.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L193Statement

open HamiltonsCubic.L187Statement

/-- **The adjugate law on one plane**: the `j`-th entry of `ω` times the `j`-th entry of `σ(ω)` is
the Pfaffian, for each of the three planes. -/
theorem adjugate_law_plane (s : ℝ × ℝ × ℝ) :
    s.1 * (sigma s).1 = pf s ∧
    s.2.1 * (sigma s).2.1 = pf s ∧
    s.2.2 * (sigma s).2.2 = pf s := by
  refine ⟨?_, ?_, ?_⟩ <;> simp only [sigma, pf] <;> ring

/-- **THE THREE PLANES AGREE, WHICH IS THE WHOLE OF THE IDENTITY.** *On the `j`-th plane `ω` acts as
`c_j J` and `σ(ω)` as `∏_{k≠j} c_k · J`, so the product is `Pf(ω) J² = -Pf(ω) Id₂`; the value is the
same on all three, which is what makes the sum a multiple of the identity.* -/
theorem adjugate_law_agree (s : ℝ × ℝ × ℝ) :
    s.1 * (sigma s).1 = s.2.1 * (sigma s).2.1 ∧
    s.2.1 * (sigma s).2.1 = s.2.2 * (sigma s).2.2 := by
  refine ⟨?_, ?_⟩ <;> simp only [sigma] <;> ring

/-- **The sign, read off the area form's square.** *`φ₀₁² = -(E₀₀ + E₁₁)`, which is minus the
projection onto its own plane*, that is where the minus in `ω σ(ω) = -Pf(ω) Id` comes from, and it
is a fact about matrices rather than about scalars.

**An earlier version stated this with a real `c` satisfying `c * c = -1`, which is unsatisfiable over
`ℝ`, so the theorem was vacuous and verified nothing.** *A reviewer compiled the opposite sign from
the same hypothesis.* -/
theorem area_form_sq :
    HamiltonsCubic.RealLayer.phi (0 : Fin 6) 1 * HamiltonsCubic.RealLayer.phi (0 : Fin 6) 1
      = -(Matrix.single (0 : Fin 6) 0 1 + Matrix.single (1 : Fin 6) 1 1) := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [HamiltonsCubic.RealLayer.phi, Matrix.mul_apply, Fin.sum_univ_six,
      Matrix.single_apply, Matrix.add_apply, Matrix.neg_apply]

/-! ## The frame-free matrix form, stated with its gap visible -/

open HamiltonsCubic.SelfDualLayer in
/-- **The Pfaffian adjugate of a bivector on `ℝ⁶`**, `σ(ω) = ½⋆(ω ∧ ω)`. -/
noncomputable def sigma6 (X : Matrix (Fin 6) (Fin 6) ℝ) : Matrix (Fin 6) (Fin 6) ℝ :=
  (1 / 2 : ℝ) • star6 (wedgeSelf X)

open HamiltonsCubic.SelfDualLayer in
/-- **THE ADJUGATE LAW, FRAME-FREE.** *`ω σ(ω) = -Pf(ω)·Id` at every bivector of `ℝ⁶`.*

**PROVED 2026-09-17, entry by entry.** *Each of the thirty-six entries is
[I67AdjugateEntries.lean](I67AdjugateEntries.lean)'s `adj_i_j`, and the scalar the six diagonal ones
carry is `pf6` by [pf6_eq](I67Pf6.lean).* **The route past the step ceiling was REINDEXING**: `pf6 X`
is `triple6 X X X`, six nested sums that `simp` cannot expand at any budget, and
[star_wedge_pairing](I67Relabel.lean) reads the Pfaffian off the adjugate instead, by relabelling
bound variables rather than enumerating terms.

*The earlier justification for the `sorry`, that the frame-adapted proof needs the real skew normal
form and SO(6)-equivariance, described a PROOF STRATEGY rather than the statement, and the
statement is polynomial.*

**The row for this result previously called the STATEMENT blocked, which was wrong**: `star6`,
`wedgeSelf`, `pf6` and `IsSkew` were all in the layer, so what was owed was a proof and not a
statement, and a reviewer typed this to show it. -/
theorem adjugate_law (X : Matrix (Fin 6) (Fin 6) ℝ)
    (hX : HamiltonsCubic.RealLayer.IsSkew X) :
    X * sigma6 X = (-(pf6 X)) • (1 : Matrix (Fin 6) (Fin 6) ℝ) := by
  ext i j
  unfold sigma6
  rw [HamiltonsCubic.I67Pf6.pf6_eq X hX]
  fin_cases i <;> fin_cases j
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_0_0 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_0_1 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_0_2 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_0_3 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_0_4 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_0_5 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_1_0 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_1_1 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_1_2 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_1_3 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_1_4 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_1_5 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_2_0 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_2_1 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_2_2 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_2_3 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_2_4 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_2_5 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_3_0 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_3_1 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_3_2 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_3_3 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_3_4 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_3_5 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_4_0 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_4_1 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_4_2 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_4_3 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_4_4 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_4_5 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_5_0 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_5_1 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_5_2 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_5_3 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_5_4 X hX
  · simpa using HamiltonsCubic.I67AdjugateEntries.adj_5_5 X hX

/-! ## What L193 does to L184's standing debt -/

open HamiltonsCubic.SelfDualLayer in
/-- **THE ADJUGATE LAW GIVES `StarWedgeIdentity`, WHICH THE RECORD HAS CARRIED AS AN UNPROVED
`Prop`.** *At a complex structure `J² = -Id` gives `J⁻¹ = -J`, so multiplying `J σ(J) = -Pf(J) Id`
through by `-J` returns `σ(J) = Pf(J) J`, which is `⋆(J ∧ J) = 2 Pf(J) J`*, **[L184](../../../findings/diagonal-half.md)
case 2's owed identity, with the constant and the base sign settled and `ε_J = Pf(J)`.**

*Stated as an implication from its two inputs*, which is how it was written while both were owed.
**The FIRST input is now the theorem `adjugate_law` sixty lines above**, so `starWedge_of_pf` below
discharges it, and [I67PfSign.lean](I67PfSign.lean)'s `pf6_complexStructure` supplies the second. -/
theorem starWedge_of_adjugate
    (hAdj : ∀ X : Matrix (Fin 6) (Fin 6) ℝ, HamiltonsCubic.RealLayer.IsSkew X →
      X * sigma6 X = (-(pf6 X)) • (1 : Matrix (Fin 6) (Fin 6) ℝ))
    (hPf : ∀ J : Matrix (Fin 6) (Fin 6) ℝ, IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1) :
    StarWedgeIdentity := by
  intro J hJ
  refine ⟨pf6 J, hPf J hJ, ?_⟩
  have hskew : HamiltonsCubic.RealLayer.IsSkew J := hJ.1
  have hsq : J * J = -1 := hJ.2
  have h := hAdj J hskew
  -- multiply through by -J on the left, using J * J = -1
  have hL : (-J) * (J * sigma6 J) = sigma6 J := by
    rw [← Matrix.mul_assoc, Matrix.neg_mul, hsq]; simp
  have hR : (-J) * ((-(pf6 J)) • (1 : Matrix (Fin 6) (Fin 6) ℝ)) = (pf6 J) • J := by
    rw [Matrix.mul_smul, Matrix.mul_one]; module
  have : sigma6 J = (pf6 J) • J := by rw [← hL, h, hR]
  have h2 : star6 (wedgeSelf J) = (2 : ℝ) • sigma6 J := by rw [sigma6]; module
  rw [h2, this, smul_smul]

open HamiltonsCubic.SelfDualLayer in
/-- **`StarWedgeIdentity` now rests on ONE input rather than two.** *`starWedge_of_adjugate` takes
the adjugate law and `Pf(J) = plus or minus 1` as hypotheses; the first is now the theorem
`adjugate_law` above, so it is discharged here and only the second remains.*

**`pf6 J = 1 or -1` at a complex structure is `pf6_complexStructure`** in
[I67PfSign.lean](I67PfSign.lean), by orthogonal normal form and `pf6_conj` rather than through
`Pf(X)^2 = det X`. -/
theorem starWedge_of_pf
    (hPf : ∀ J : Matrix (Fin 6) (Fin 6) ℝ, IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1) :
    StarWedgeIdentity :=
  starWedge_of_adjugate adjugate_law hPf

/-! ## The associativity bookkeeping behind the withdrawn contraction -/

open HamiltonsCubic.SelfDualLayer in
/-- **WHAT THIS CERTIFIES IS ASSOCIATIVITY, AND ITS DOCSTRING ONCE CLAIMED MORE.**

*`starB` and `cross` are FREE matrices with no skewness, no `⋆`, no `∧` and no relation to the
Bianchi defect; `om` carries no orthonormality and `lam` no sign or sum condition.* **And `hId` is a
DEFINITION of `cross`, not the harmonicity identity**, it pins `cross k` to `-½ (om k * starB)`, so
the content is exactly `(∑ k, lam k • (om k * om k)) * starB = 0`.

**The box this was written for is WITHDRAWN**: both Gate 2 reviewers showed the constraint it derives
is harmonicity restated under Ricci, excluding no defect and forcing nothing. *The theorem is kept
because the bookkeeping it does is real and was worth typing, and because a headline claiming
`BOTH WEYL CONDITIONS CONSUMED` over a statement about arbitrary matrices is the failure this file
should carry an example of rather than delete.* -/
theorem ricci_annihilates_defect
    (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (starB : Matrix (Fin 6) (Fin 6) ℝ)
    (cross : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (hId : ∀ k : Fin 3, om k * starB = (-2 : ℝ) • cross k)
    (hRicci : ∑ k : Fin 3, lam k • (om k * om k) = 0) :
    ∑ k : Fin 3, lam k • (om k * cross k) = 0 := by
  have key : ∀ k : Fin 3,
      lam k • (om k * (om k * starB)) = (-2 : ℝ) • (lam k • (om k * cross k)) := by
    intro k; rw [hId k, Matrix.mul_smul, smul_comm]
  have hL : ∑ k : Fin 3, lam k • (om k * (om k * starB)) = 0 := by
    have : ∀ k : Fin 3, lam k • (om k * (om k * starB)) = (lam k • (om k * om k)) * starB := by
      intro k; rw [Matrix.smul_mul, Matrix.mul_assoc]
    simp only [this, ← Finset.sum_mul, hRicci, Matrix.zero_mul]
  rw [Finset.sum_congr rfl (fun k _ => key k), ← Finset.smul_sum] at hL
  have : (-2 : ℝ) ≠ 0 := by norm_num
  exact (smul_eq_zero.mp hL).resolve_left this

end HamiltonsCubic.L193Statement
