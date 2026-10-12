import HamiltonsCubic.Results.OrbitWeyl

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedSimpArgs false

/-!
# A nonzero Weyl operator moves under some rotation generator

L25's route to `λ_max(L_e|_{W⊥}) ≥ ½` needs `Du ≠ 0` for some skew `A` at a nonzero critical `u`, so that
[OrbitWeyl.lean](OrbitWeyl.lean)'s `orbit_half_weyl` produces a nonzero `½`-eigenvector. **This file proves it
at every `n ≥ 2`**, with no representation theory:

- `phi_col`: `∑_m (φ_pq)_{ms} X_m = [s=p] X_q − [s=q] X_p`;
- `contract`: the invariance at `A = φ_pq`, contracted over the slot `k = p`, as seven coordinate terms;
- `contract_weyl`: at a Weyl `u` those seven terms are `−(n−1) R_ijql`, the pair symmetry, the Ricci contraction
  and one Bianchi sum absorbing the rest;
- **`weyl_invariant_zero`**: a Weyl `u` with `D_{φ_pq} u = 0` on bivectors for every `p, q` vanishes on `Λ²`;
- **`weyl_moves`**: a Weyl `u` nonzero on some bivector has `D_{φ_pq} u ≠ 0` on some bivector.
-/

namespace HamiltonsCubic.OrbitDeriv

open Finset Matrix HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem phi_col (p q s : ι) (X : ι → ℝ) :
    ∑ m, phi p q m s * X m = (if s = p then X q else 0) - (if s = q then X p else 0) := by
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, sub_mul, Finset.sum_sub_distrib, ite_mul, one_mul,
    zero_mul, ite_and]
  simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
  congr 1 <;> exact if_congr eq_comm rfl rfl

/-- **The contraction of the invariance at `A = φ_pq` over the slot `k = p`.** -/
theorem contract (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hl : IsLinOp u) (i j q l : ι) :
    ∑ p, inner2 (Dop (phi p q) u (phi i j)) (phi p l) =
      -(((Fintype.card ι : ℝ) - 1) * inner2 (u (phi i j)) (phi q l) + inner2 (u (phi i j)) (phi l q)
        + inner2 (u (phi q j)) (phi i l) + inner2 (u (phi i q)) (phi j l)
        - (if l = q then ∑ p, inner2 (u (phi i j)) (phi p p) else 0)
        - (if i = q then ∑ p, inner2 (u (phi p j)) (phi p l) else 0)
        - (if j = q then ∑ p, inner2 (u (phi i p)) (phi p l) else 0)) := by
  simp only [Dop_coord _ (phi_isSkew _ _) u hl, Finset.sum_add_distrib, phi_col, Finset.sum_neg_distrib]
  simp only [Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true,
    Finset.sum_ite_irrel, Finset.sum_const_zero, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  split_ifs <;> ring

theorem inner2_zero_l' (Y : Matrix ι ι ℝ) : inner2 0 Y = 0 := by unfold inner2; simp

theorem inner2_neg_r' (X Y : Matrix ι ι ℝ) : inner2 X (-Y) = -inner2 X Y := by
  unfold inner2; simp

theorem linOp_neg (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hl : IsLinOp u) (X : Matrix ι ι ℝ) : u (-X) = -u X := by
  rw [show -X = (-1 : ℝ) • X by simp, hl.2]; simp

/-- **At a Weyl `u`, the contraction is `−(n−1) R_ijql`**: pair symmetry, Ricci-flatness and Bianchi
absorb every other term. -/
theorem contract_weyl (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hu : IsWeylOp u) (i j q l : ι) :
    ∑ p, inner2 (Dop (phi p q) u (phi i j)) (phi p l) =
      -((Fintype.card ι : ℝ) - 1) * inner2 (u (phi i j)) (phi q l) := by
  obtain ⟨hl, _, hsym, hb, hric⟩ := hu
  rw [contract u hl]
  have e1 : inner2 (u (phi i j)) (phi l q) = -inner2 (u (phi i j)) (phi q l) := by
    rw [phi_swap q l, inner2_neg_r']
  have e2 : ∑ p, inner2 (u (phi i j)) (phi p p) = 0 := by simp [phi_self, inner2]
  have e3 : ∑ p, inner2 (u (phi p j)) (phi p l) = 0 := by
    rw [← hric j l]; unfold Ric
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [phi_swap j p, phi_swap l p, linOp_neg u hl, inner2_neg_r']
    unfold inner2; simp [Matrix.transpose_neg]
  have e4 : ∑ p, inner2 (u (phi i p)) (phi p l) = 0 := by
    have : ∑ p, inner2 (u (phi i p)) (phi p l) = -Ric u i l := by
      unfold Ric; rw [← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun p _ => ?_
      rw [phi_swap l p, inner2_neg_r']
    rw [this, hric]; simp
  have e5 : inner2 (u (phi q j)) (phi i l) = inner2 (u (phi i l)) (phi q j) := by
    rw [hsym _ _ (phi_isSkew q j) (phi_isSkew i l), inner2_comm]
  have hB := hb i q j l
  unfold bianchi at hB
  rw [e1, e2, e3, e4, e5]
  simp only [ite_self, sub_zero]
  have e6 : inner2 (u (phi i j)) (phi l q) = -inner2 (u (phi i j)) (phi q l) := e1
  linarith

/-- **A WEYL OPERATOR KILLED BY EVERY ROTATION GENERATOR IS ZERO ON `Λ²`**, at `n ≥ 2`: if `D_{φ_pq} u = 0` on
bivectors for every `p, q`, then `u X = 0` for every bivector `X`. So a nonzero `u ∈ 𝒲ₙ` has `Du ≠ 0` for some
`A = φ_pq`. -/
theorem weyl_invariant_zero (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hu : IsWeylOp u) (hn : 2 ≤ Fintype.card ι)
    (hD : ∀ p q X, IsSkew X → Dop (phi p q) u X = 0) : ∀ X, IsSkew X → u X = 0 := by
  have hcoef : ∀ i j k l, inner2 (u (phi i j)) (phi k l) = 0 := by
    intro i j k l
    have h := contract_weyl u hu i j k l
    simp only [hD _ _ _ (phi_isSkew i j), inner2_zero_l', Finset.sum_const_zero] at h
    have hn' : (2 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    have hne : ((Fintype.card ι : ℝ) - 1) ≠ 0 := by linarith
    have : ((Fintype.card ι : ℝ) - 1) * inner2 (u (phi i j)) (phi k l) = 0 := by linarith
    exact (mul_eq_zero.mp this).resolve_left hne
  have hphi : ∀ i j, u (phi i j) = 0 := by
    intro i j
    rw [← skew_expand (u (phi i j)) (hu.2.1 _ (phi_isSkew i j))]
    simp [hcoef]
  intro X hX
  rw [← skew_expand X hX, hu.1.2, linOp_sum u hu.1]
  simp [linOp_sum u hu.1, hu.1.2, hphi]

/-- **A nonzero Weyl operator moves**: at `n ≥ 2`, if `u X ≠ 0` for some bivector `X`, then
`D_{φ_pq} u Y ≠ 0` for some `p, q` and some bivector `Y`. -/
theorem weyl_moves (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hu : IsWeylOp u) (hn : 2 ≤ Fintype.card ι)
    (hne : ∃ X, IsSkew X ∧ u X ≠ 0) : ∃ p q Y, IsSkew Y ∧ Dop (phi p q) u Y ≠ 0 := by
  by_contra h
  push_neg at h
  obtain ⟨X, hX, hX0⟩ := hne
  exact hX0 (weyl_invariant_zero u hu hn (fun p q Y hY => h p q Y hY) X hX)

end HamiltonsCubic.OrbitDeriv
