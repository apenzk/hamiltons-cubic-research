import HamiltonsCubic.Results.L179Statement

set_option linter.style.longLine false

/-!
# L186: no rank-three Weyl tensor has exactly one non-decomposable image form

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L186: *"L179(b) reads the first Bianchi identity as
`∑ λ_i ω_i ∧ ω_i = 0`. A form is decomposable exactly when `ω ∧ ω = 0`, so the two decomposable forms contribute
nothing and the identity collapses to `λ₁ ω₁ ∧ ω₁ = 0` with `λ₁ ≠ 0`, forcing `ω₁` decomposable."*

- `IsDecomp`: `X = u vᵀ − v uᵀ`;
- **`wedgeSelf_of_decomp`**, **`decomp_of_wedgeSelf`**, `isDecomp_iff`: a `2`-form is decomposable exactly when
  `ω ∧ ω = 0` ([SelfDual.lean](../Base/SelfDual.lean)'s `wedgeSelf`), the converse by the Plücker relation at a nonzero
  entry;
- **`L186`**: with [L179Statement.lean](L179Statement.lean)'s `bianchi_iff_wedge`, if every image form of
  `W = ∑ λ_i ω_i ⊗ ω_i` but `ω_i` is decomposable and `λ_i ≠ 0`, first Bianchi forces `ω_i` decomposable, at every rank.
-/

namespace HamiltonsCubic.L186Proof

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer HamiltonsCubic.L179

variable {ι : Type*}

/-- A decomposable `2`-form: `X = u vᵀ − v uᵀ`. -/
def IsDecomp (X : Matrix ι ι ℝ) : Prop := ∃ u v : ι → ℝ, X = vecMulVec u v - vecMulVec v u

/-- **A decomposable form has `ω ∧ ω = 0`.** -/
theorem wedgeSelf_of_decomp {X : Matrix ι ι ℝ} (h : IsDecomp X) (a b c d : ι) : wedgeSelf X a b c d = 0 := by
  obtain ⟨u, v, rfl⟩ := h
  simp only [wedgeSelf, wedge2, halfw, Pi.add_apply, Matrix.sub_apply, vecMulVec_apply]; ring

/-- **The Plücker converse: `ω ∧ ω = 0` forces `ω` decomposable.** At a nonzero entry `X_ab`, the relation
`X_ab X_cd − X_ac X_bd + X_ad X_bc = 0` writes `X = (row_a / X_ab) ∧ row_b`. -/
theorem decomp_of_wedgeSelf {X : Matrix ι ι ℝ} (h : ∀ a b c d, wedgeSelf X a b c d = 0) : IsDecomp X := by
  by_cases hX : ∃ a b, X a b ≠ 0
  · obtain ⟨a, b, hab⟩ := hX
    refine ⟨fun c => X a c / X a b, fun d => X b d, ?_⟩
    ext c d
    have hp := h a b c d
    simp only [wedgeSelf, wedge2, halfw, Pi.add_apply] at hp
    simp only [Matrix.sub_apply, vecMulVec_apply]
    field_simp
    linarith
  · push Not at hX
    refine ⟨0, 0, ?_⟩
    ext c d; simp [hX c d]

theorem isDecomp_iff (X : Matrix ι ι ℝ) : IsDecomp X ↔ ∀ a b c d, wedgeSelf X a b c d = 0 :=
  ⟨fun h => wedgeSelf_of_decomp h, decomp_of_wedgeSelf⟩

variable [Fintype ι] [DecidableEq ι]

/-- **L186, in general form**: for `W = ∑ λ_i ω_i ⊗ ω_i` satisfying first Bianchi, if every image form but `ω_i` is
decomposable and `λ_i ≠ 0`, then `ω_i` is decomposable too. So no rank-three Weyl tensor has exactly one
non-decomposable image form. -/
theorem L186 {r : ℕ} (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (hskew : ∀ i, (om i)ᵀ = -om i)
    (hB : ∀ a b c d, bianchi (rankSumOp lam om) a b c d = 0) (i : Fin r) (hi : lam i ≠ 0)
    (hothers : ∀ j, j ≠ i → IsDecomp (om j)) : IsDecomp (om i) := by
  have hw := (bianchi_iff_wedge lam om hskew).mp hB
  refine decomp_of_wedgeSelf fun a b c d => ?_
  have h := hw a b c d
  rw [bianchi_sum_filter, Finset.sum_eq_single i (fun j _ hj => by rw [wedgeSelf_of_decomp (hothers j hj), mul_zero])
    (fun h => absurd (Finset.mem_univ i) h)] at h
  exact (mul_eq_zero.mp h).resolve_left hi

end HamiltonsCubic.L186Proof
