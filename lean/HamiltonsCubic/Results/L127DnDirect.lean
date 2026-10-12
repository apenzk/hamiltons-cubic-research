import HamiltonsCubic.Results.L127DnDim

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` families: the sum is direct

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnSpan.lean](L127DnSpan.lean)'s
`dn_decomp2` (`dn_decomp` at `p, q ≥ 3`) writes every weight as a sum over six families at `p, q ≥ 2` and [L127DnDim.lean](L127DnDim.lean) gives their
dimensions. This file shows the decomposition is unique:

* **`dn_cross_entry`**: on the cross block a vanishing sum reads `−c + κ h_a + κ' h'_b + X_{ab} = 0`;
* **`dn_direct2`** (`dn_direct` its `p, q ≥ 3` form): at `p, q ≥ 2` a vanishing sum of one member of each family has
  every member zero. The cross block's row sums give `κ h_a = c`, their total `c = 0`, the column sums `κ' h'_b = 0`,
  so the cross block vanishes. A `λ` member vanishes through `h = 0` where `κ ≠ 0` (`|S| ≥ 3`) and through
  `lamW_two_eq_zero` at `|S| = 2`, and what is left is supported on disjoint blocks.

[L127DnMult.lean](L127DnMult.lean), [L127DnEig.lean](L127DnEig.lean) and [L127DnLam.lean](L127DnLam.lean) pass from it to the eigenspaces and their dimensions.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [Fintype ι] in
/-- A `λ` weight vanishes when `h` vanishes on `S`. -/
theorem lamW_eq_zero (S : Finset ι) (κ : ℝ) (h : ι → ℝ) (hz : ∀ a ∈ S, h a = 0) : lamW S κ h = 0 := by
  ext a b
  simp only [lamW, Matrix.of_apply, Matrix.zero_apply]
  by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;> simp [ha, hb, hz a, hz b]

theorem dn_cross_entry (T : Finset ι) (c κ κ' : ℝ) (h h' : ι → ℝ) {X Z Z' : Matrix ι ι ℝ} (hZ : IsWithinW T Z)
    (hZ' : IsWithinW Tᶜ Z') (hs : c • sphereWeight T + lamW T κ h + lamW Tᶜ κ' h' + X + Z + Z' = 0) {a b : ι}
    (ha : a ∈ T) (hb : b ∉ T) : -c + κ * h a + κ' * h' b + X a b = 0 := by
  have e := congrFun (congrFun hs a) b
  have hab : a ≠ b := fun e => hb (e ▸ ha)
  have hbc : b ∈ Tᶜ := Finset.mem_compl.mpr hb
  have hac : a ∉ Tᶜ := fun h => (Finset.mem_compl.mp h) ha
  simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, Matrix.zero_apply] at e
  rw [hZ.2.2.1 a b (Or.inr hb), hZ'.2.2.1 a b (Or.inl hac)] at e
  simp only [sphereWeight, lamW, Matrix.of_apply, hab, ha, hb, hbc, hac, if_false, if_true, and_true,
    and_false, false_and, not_false_eq_true] at e
  linarith

/-- **The decomposition is direct**: at `p, q ≥ 2` a vanishing sum of one member of each family has every member
zero. The cross block's row sums give `κ h_a = c`, their total `c = 0`, and the column sums `κ' h'_b = 0`, so the
cross block vanishes. A `λ` member then vanishes through `h = 0` where `κ ≠ 0` (`|S| ≥ 3`) and through
`lamW_two_eq_zero` at `|S| = 2`. -/
theorem dn_direct2 (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (c : ℝ) (h h' : ι → ℝ)
    {X Z Z' : Matrix ι ι ℝ} (hh : ∑ b ∈ T, h b = 0) (hh' : ∑ b ∈ Tᶜ, h' b = 0) (hX : IsCrossW T X)
    (hZ : IsWithinW T Z) (hZ' : IsWithinW Tᶜ Z')
    (hs : c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z' = 0) :
    c = 0 ∧ lamW T (dnK T) h = 0 ∧ lamW Tᶜ (dnK Tᶜ) h' = 0 ∧ X = 0 ∧ Z = 0 ∧ Z' = 0 := by
  have hp' : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hq' : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  have hp0 : (T.card : ℝ) ≠ 0 := by intro h; linarith
  have hq0 : (Tᶜ.card : ℝ) ≠ 0 := by intro h; linarith
  have E := fun {a b} (ha : a ∈ T) (hb : b ∉ T) => dn_cross_entry T c _ _ h h' hZ hZ' hs ha hb
  have hrow' : ∀ a ∈ T, dnK T * h a = c := fun a ha => by
    have e : ∑ b ∈ Tᶜ, (-c + dnK T * h a + dnK Tᶜ * h' b + X a b) = 0 :=
      Finset.sum_eq_zero fun b hb => E ha (Finset.mem_compl.mp hb)
    rw [Finset.sum_add_distrib, Finset.sum_add_distrib, ← Finset.mul_sum, hh', hX.2.2.1 a ha, Finset.sum_const,
      nsmul_eq_mul] at e
    have e' : (Tᶜ.card : ℝ) * (dnK T * h a - c) = 0 := by linarith
    rcases mul_eq_zero.mp e' with h0 | h0
    · exact absurd h0 hq0
    · linarith
  have hc : c = 0 := by
    have e : ∑ a ∈ T, dnK T * h a = ∑ a ∈ T, c := Finset.sum_congr rfl hrow'
    rw [← Finset.mul_sum, hh, mul_zero, Finset.sum_const, nsmul_eq_mul] at e
    rcases mul_eq_zero.mp e.symm with h0 | h0
    · exact absurd h0 hp0
    · exact h0
  have hkh : ∀ a ∈ T, dnK T * h a = 0 := fun a ha => by rw [hrow' a ha, hc]
  have hkh' : ∀ b ∈ Tᶜ, dnK Tᶜ * h' b = 0 := fun b hb => by
    have hbT := Finset.mem_compl.mp hb
    have e : ∑ a ∈ T, (-c + dnK T * h a + dnK Tᶜ * h' b + X a b) = 0 :=
      Finset.sum_eq_zero fun a ha => E ha hbT
    have hXc : ∑ a ∈ T, X a b = 0 := by
      rw [Finset.sum_congr rfl fun a _ => hX.1 a b]; exact hX.2.2.2 b hbT
    rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_add_distrib, ← Finset.mul_sum, hh, hXc,
      Finset.sum_const, Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul, hc] at e
    have e' : (T.card : ℝ) * (dnK Tᶜ * h' b) = 0 := by linarith
    rcases mul_eq_zero.mp e' with h0 | h0
    · exact absurd h0 hp0
    · exact h0
  -- a `λ` member vanishes: through `h = 0` where `κ ≠ 0`, and by `lamW_two_eq_zero` on a pair
  have lamzero : ∀ (S : Finset ι) (g : ι → ℝ), 2 ≤ S.card → 1 ≤ Sᶜ.card → ∑ b ∈ S, g b = 0 →
      (∀ a ∈ S, dnK S * g a = 0) → lamW S (dnK S) g = 0 := fun S g h2 h1 hg hk => by
    by_cases hS : S.card = 2
    · exact lamW_two_eq_zero S hS hg
    · have hS3 : (3 : ℝ) ≤ S.card := by exact_mod_cast (show 3 ≤ S.card by omega)
      have hSc : (1 : ℝ) ≤ Sᶜ.card := by exact_mod_cast h1
      have hK : dnK S ≠ 0 := by
        unfold dnK; exact div_ne_zero (by intro h; linarith) (by intro h; linarith)
      exact lamW_eq_zero S (dnK S) g fun a ha => (mul_eq_zero.mp (hk a ha)).resolve_left hK
  have hL := lamzero T h hp (by omega) hh hkh
  have hL' := lamzero Tᶜ h' hq (by rw [compl_compl]; omega) hh' hkh'
  have hX0 : X = 0 := by
    ext a b
    by_cases ha : a ∈ T <;> by_cases hb : b ∈ T
    · exact hX.2.1 a b (iff_of_true ha hb)
    · have := E ha hb; rw [hc, hkh a ha, hkh' b (Finset.mem_compl.mpr hb)] at this
      simpa using this
    · have := E hb ha; rw [hc, hkh b hb, hkh' a (Finset.mem_compl.mpr ha)] at this
      rw [Matrix.zero_apply, hX.1 a b]; simpa using this
    · exact hX.2.1 a b (iff_of_false ha hb)
  rw [hc, zero_smul, hL, hL', hX0] at hs
  simp only [zero_add] at hs
  have hZZ : ∀ a b, Z a b + Z' a b = 0 := fun a b => by
    have := congrFun (congrFun hs a) b; simpa using this
  refine ⟨hc, hL, hL', hX0, ?_, ?_⟩
  · ext a b
    by_cases hab : a ∈ T ∧ b ∈ T
    · have := hZZ a b
      rw [hZ'.2.2.1 a b (Or.inl fun h => (Finset.mem_compl.mp h) hab.1)] at this
      simpa using this
    · rw [not_and_or] at hab; exact hZ.2.2.1 a b hab
  · ext a b
    by_cases hab : a ∈ Tᶜ ∧ b ∈ Tᶜ
    · have := hZZ a b
      rw [hZ.2.2.1 a b (Or.inl (Finset.mem_compl.mp hab.1))] at this
      simpa using this
    · rw [not_and_or] at hab; exact hZ'.2.2.1 a b hab

/-- **The decomposition is direct**, at `p, q ≥ 3`. -/
theorem dn_direct (T : Finset ι) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (c : ℝ) (h h' : ι → ℝ)
    {X Z Z' : Matrix ι ι ℝ} (hh : ∑ b ∈ T, h b = 0) (hh' : ∑ b ∈ Tᶜ, h' b = 0) (hX : IsCrossW T X)
    (hZ : IsWithinW T Z) (hZ' : IsWithinW Tᶜ Z')
    (hs : c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z' = 0) :
    c = 0 ∧ lamW T (dnK T) h = 0 ∧ lamW Tᶜ (dnK Tᶜ) h' = 0 ∧ X = 0 ∧ Z = 0 ∧ Z' = 0 :=
  dn_direct2 T (by omega) (by omega) c h h' hh hh' hX hZ hZ' hs

end HamiltonsCubic.Results
