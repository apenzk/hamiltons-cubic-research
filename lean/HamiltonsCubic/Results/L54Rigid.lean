import HamiltonsCubic.Results.L52Frame

set_option linter.style.longLine false

/-!
# L54 (2) and (4): `ω ≻ d`, and rigidity at `t_F = 2`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L54: in the basis `{φ_ab, ψ_k}`
with `ψ_k` an eigenbasis of `K`, **(2)** `μ ≻ d_φ` and `ω ≻ d`, and **(4)** at `t_F = 2`,
`μ = d_φ` and `ω = d` as sorted vectors. [L54Schur.lean](L54Schur.lean) proves `μ ≻ d_φ`. **This
file proves the rest**, with `ψ_k = diag(w_k)` for `w` Mathlib's orthonormal eigenbasis of `K` on
`ℝⁿ` (`wK`):

- `L54_omega_majorizes`: `ω ≻ d`, Schur at `W̊` in that basis;
- `sum_dphi_sq`: `∑ d_φ² = t_F/2`, and `sum_d_sq`: `∑ d² = 3t_F/2`, the `ψ`-block carrying
  `∑ κ² = tr K² = t_F`;
- `L54_rigidity`: **at `t_F = 2` and unit norm, `μ` and `d_φ` have the same sorted vector, and so
  do `ω` and `d`**, by `sameSorted_of_majorizes_of_normSq_eq`.

The `ψ`-block here runs over all of `ℝⁿ`, one more dimension than the record's `𝟏^⊥`. At a
Ricci-flat `R`, `K 𝟏 = 0` (`K_row_sum`) and `W̊ g = 0` (`ringW_one`), so the spectra on `ℝⁿ` and `S²`
are those on `𝟏^⊥` and `S²₀` plus one `0` each, proved as `K_spectrum_split` and `ringW_spectrum_split` in
[L54Spectrum.lean](L54Spectrum.lean). That the `ψ`-diagonal here is the record's `d` plus one `0` is
[L54Diag.lean](L54Diag.lean)'s `dpsi_split`, (4) on `S²₀` is its `L54_rigidity_S20`, and (2) on `S²₀` in convex
form is its `L54_majorizes_S20`.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.L54Statement

variable {n : ℕ}

section K

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

theorem Kmat_symm (a b : Fin n) : Kmat R a b = Kmat R b a := by
  unfold Kmat
  rw [R4_anti1 R hR hskew hsym b a a b, R4_anti2 R hR b a a b]

theorem Kmat_isHermitian : (Kmat R).IsHermitian := by
  ext a b; simp only [Matrix.conjTranspose_apply, star_trivial]; exact Kmat_symm R hR hskew hsym b a

/-- Mathlib's orthonormal eigenbasis of `K`, as functions on `Fin n`. -/
noncomputable def wK (k : Fin n) : Fin n → ℝ :=
  ⇑((Kmat_isHermitian R hR hskew hsym).eigenvectorBasis k)

theorem wK_complete (i j : Fin n) :
    ∑ k, wK R hR hskew hsym k i * wK R hR hskew hsym k j = if i = j then 1 else 0 := by
  have hU := Matrix.mem_unitaryGroup_iff.mp (Kmat_isHermitian R hR hskew hsym).eigenvectorUnitary.2
  have h := congrFun (congrFun hU i) j
  simp only [Matrix.mul_apply, Matrix.star_apply, star_trivial, Matrix.one_apply] at h
  exact h

theorem wK_norm (k : Fin n) : wK R hR hskew hsym k ⬝ᵥ wK R hR hskew hsym k = 1 := by
  have hU := Matrix.mem_unitaryGroup_iff'.mp (Kmat_isHermitian R hR hskew hsym).eigenvectorUnitary.2
  have h := congrFun (congrFun hU k) k
  simp only [Matrix.mul_apply, Matrix.star_apply, star_trivial, Matrix.one_apply, if_true] at h
  exact h

theorem wK_eigen (k : Fin n) :
    Kmat R *ᵥ wK R hR hskew hsym k
      = (Kmat_isHermitian R hR hskew hsym).eigenvalues k • wK R hR hskew hsym k :=
  (Kmat_isHermitian R hR hskew hsym).mulVec_eigenvectorBasis k

/-- **L54 (2), `ω ≻ d`**: the spectrum of `W̊` majorises its diagonal in the basis `ew (wK R)`. -/
theorem L54_omega_majorizes :
    Majorizes (Bw_isHermitian R hR hskew hsym (wK R hR hskew hsym) (wK_complete R hR hskew hsym)).eigenvalues
      (fun u => Bw (wK R hR hskew hsym) (ringW R) u u) :=
  schur_majorizes _ _

/-- `t_F`, the squared Frobenius norm of `K`. -/
noncomputable def tF : ℝ := ∑ a, ∑ b, Kmat R a b ^ 2

omit hskew hsym in
theorem Kmat_diag (a : Fin n) : Kmat R a a = 0 := by unfold Kmat; exact R4_self_left R hR a a a

/-- **`∑ d_φ² = t_F/2`.** -/
theorem sum_dphi_sq : ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2 = tF R / 2 := by
  have h := sum_pairs (fun a b => Kmat R a b ^ 2) (fun a => by rw [Kmat_diag R hR]; ring)
    (fun a b => by rw [Kmat_symm R hR hskew hsym])
  unfold tF; rw [h]; ring

/-- **`∑ d² = 3t_F/2`**: the `ψ`-block carries `∑ κ² = tr K² = t_F`. -/
theorem sum_d_sq :
    ∑ u, Bw (wK R hR hskew hsym) (ringW R) u u ^ 2 = 3 * tF R / 2 := by
  rw [Fintype.sum_sum_type]
  simp only [Bw_diag_pair R hR hskew hsym, Bw_diag_psi R hR hskew hsym, wK_eigen R hR hskew hsym,
    dotProduct_smul, wK_norm R hR hskew hsym, smul_eq_mul, mul_one, neg_sq]
  rw [sum_dphi_sq R hR hskew hsym, ← trace_pow_eq_sum_eigenvalues]
  have htr : ((Kmat R) ^ 2).trace = tF R := by
    rw [pow_two, Matrix.trace]
    unfold tF
    simp only [Matrix.diag, Matrix.mul_apply]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by
      rw [Kmat_symm R hR hskew hsym b a]; ring
  rw [htr]; ring

/-- **L54 (4), RIGIDITY**: at `t_F = 2` and unit norm, `μ` and `d_φ` have the same sorted vector,
and so do `ω` and `d`. -/
theorem L54_rigidity (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1)
    (ht : tF R = 2) :
    SameSorted (Mpair_isHermitian R hR hskew hsym).eigenvalues (fun p : Pairs n => Kmat R p.1.1 p.1.2)
    ∧ SameSorted (Bw_isHermitian R hR hskew hsym (wK R hR hskew hsym) (wK_complete R hR hskew hsym)).eigenvalues
        (fun u => Bw (wK R hR hskew hsym) (ringW R) u u) := by
  refine ⟨sameSorted_of_majorizes_of_normSq_eq _ _ (L54_mu_majorizes R hR hskew hsym) ?_,
    sameSorted_of_majorizes_of_normSq_eq _ _ (L54_omega_majorizes R hR hskew hsym) ?_⟩
  · rw [sum_mu_sq R hR hskew hsym, hunit, sum_dphi_sq R hR hskew hsym, ht]; norm_num
  · rw [sum_omega_w_sq R hR hskew hsym _ (wK_complete R hR hskew hsym) hB, hunit, sum_d_sq R hR hskew hsym, ht]; norm_num

end K

end HamiltonsCubic.SecondKind
