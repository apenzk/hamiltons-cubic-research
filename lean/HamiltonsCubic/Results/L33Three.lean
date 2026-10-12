import HamiltonsCubic.Results.L33Proof
import HamiltonsCubic.Results.L240SlotBasis

set_option linter.style.longLine false

/-!
# L33 at `m = 3`: `Weyl₃ = 0`

[L33Proof.lean](L33Proof.lean) proves Lemma L33 at every `m ≠ 3`. At `m = 3` the statement holds
because there is no nonzero Weyl operator, and this file proves that:

- `weyl3_pairs_zero`: for `IsWeyl W` on `ℝ³`, every pair component `⟨W φ_ij, φ_kl⟩` with `i < j`,
  `k < l` vanishes, by the six Ricci equations and the pair symmetries, without first Bianchi. The three diagonal ones give
  `R₀₁₀₁ + R₀₂₀₂ = R₀₁₀₁ + R₁₂₁₂ = R₀₂₀₂ + R₁₂₁₂ = 0`, and each off-diagonal one is a single
  mixed component, `Ric₀₁ = R₀₂₁₂`, `Ric₀₂ = R₀₁₂₁`, `Ric₁₂ = R₁₀₂₀`;
- `weyl3_zero`: so `W X = 0` at every skew `X`, `W` being linear on bivectors (`weyl_lin`) and
  every bivector expanding in the `φ_kl` (`phi_expand_ordered`);
- `L33_three` and `L33_all`: **L33 at `m = 3`, and so at every `m`**, on the negative side
  (`MinoritySide`);
- `isWeyl_neg` and `L33_all_pos`: **the positive side**, `MinoritySidePos`, by `W ↦ −W`.
-/

namespace HamiltonsCubic.L33Three

open HamiltonsCubic.RealLayer HamiltonsCubic.L33Statement HamiltonsCubic.L41Statement.Frame

/-- `W` sends a negated bivector to the negated image. -/
theorem W_neg {W : Matrix (Fin 3) (Fin 3) ℝ → Matrix (Fin 3) (Fin 3) ℝ} (hW : IsWeyl W)
    (X : Matrix (Fin 3) (Fin 3) ℝ) (hX : IsSkew X) : W (-X) = -W X := by
  have h := weyl_lin hW (Finset.univ : Finset (Fin 1)) (fun _ => (-1 : ℝ)) (fun _ => X) (fun _ => hX)
  simpa using h

/-- **Every ordered pair component of a Weyl operator on `ℝ³` vanishes.** -/
theorem weyl3_pairs_zero {W : Matrix (Fin 3) (Fin 3) ℝ → Matrix (Fin 3) (Fin 3) ℝ} (hW : IsWeyl W) :
    ∀ i j k l : Fin 3, i < j → k < l → inner2 (W (phi i j)) (phi k l) = 0 := by
  have hWw := hW
  obtain ⟨hsk, hsym, -, hRic⟩ := hW
  set r : Fin 3 → Fin 3 → Fin 3 → Fin 3 → ℝ := fun i j k l => inner2 (W (phi i j)) (phi k l) with hr
  have hA2 : ∀ i j k l, r i j l k = -r i j k l := fun i j k l => by
    simp only [hr, phi_swap k l]; unfold inner2; simp [Matrix.trace_neg]
  have hA1 : ∀ i j k l, r j i k l = -r i j k l := fun i j k l => by
    simp only [hr, phi_swap i j, W_neg hWw _ (phi_isSkew i j)]
    unfold inner2; simp [Matrix.transpose_neg, Matrix.trace_neg]
  have hP : ∀ i j k l, r i j k l = r k l i j := fun i j k l => by
    simp only [hr]; rw [hsym _ _ (phi_isSkew i j) (phi_isSkew k l), RealLayer.inner2_comm]
  have hD1 : ∀ i k l, r i i k l = 0 := fun i k l => by
    simp only [hr, phi_self]
    have : W 0 = 0 := by
      have h := weyl_lin hWw (∅ : Finset (Fin 1)) (fun _ => (1 : ℝ)) (fun _ => 0)
        (fun _ => by simp [IsSkew])
      simpa using h
    rw [this]; unfold inner2; simp
  have hD2 : ∀ i j k, r i j k k = 0 := fun i j k => by
    simp only [hr, phi_self]; unfold inner2; simp
  have hRic' : ∀ a b, r a 0 b 0 + r a 1 b 1 + r a 2 b 2 = 0 := fun a b => by
    have h := hRic a b
    unfold Ric at h
    rw [Fin.sum_univ_three] at h
    exact h
  have e00 := hRic' 0 0
  have e11 := hRic' 1 1
  have e22 := hRic' 2 2
  have e01 := hRic' 0 1
  have e02 := hRic' 0 2
  have e12 := hRic' 1 2
  simp only [hD1, hD2, zero_add, add_zero] at e00 e11 e22 e01 e02 e12
  have s1 : r 1 0 1 0 = r 0 1 0 1 := by rw [hA1, hA2]; ring
  have s2 : r 2 0 2 0 = r 0 2 0 2 := by rw [hA1, hA2]; ring
  have s3 : r 2 1 2 1 = r 1 2 1 2 := by rw [hA1, hA2]; ring
  have s4 : r 0 1 2 1 = -r 0 1 1 2 := by rw [hA2]
  have s5 : r 1 0 2 0 = r 0 1 0 2 := by rw [hA1, hA2]; ring
  rw [s1] at e11
  rw [s2, s3] at e22
  rw [s4] at e02
  rw [s5] at e12
  have z0101 : r 0 1 0 1 = 0 := by linarith
  have z0202 : r 0 2 0 2 = 0 := by linarith
  have z1212 : r 1 2 1 2 = 0 := by linarith
  have z0212 : r 0 2 1 2 = 0 := by linarith
  have z0112 : r 0 1 1 2 = 0 := by linarith
  have z0102 : r 0 1 0 2 = 0 := by linarith
  have z0201 : r 0 2 0 1 = 0 := by rw [hP]; exact z0102
  have z1201 : r 1 2 0 1 = 0 := by rw [hP]; exact z0112
  have z1202 : r 1 2 0 2 = 0 := by rw [hP]; exact z0212
  intro i j k l hij hkl
  show r i j k l = 0
  fin_cases i <;> fin_cases j <;> fin_cases k <;> fin_cases l <;>
    first
    | exact absurd hij (by decide)
    | exact absurd hkl (by decide)
    | assumption

/-- **`Weyl₃ = 0` on bivectors.** -/
theorem weyl3_zero {W : Matrix (Fin 3) (Fin 3) ℝ → Matrix (Fin 3) (Fin 3) ℝ} (hW : IsWeyl W)
    (X : Matrix (Fin 3) (Fin 3) ℝ) (hX : IsSkew X) : W X = 0 := by
  have hz := weyl3_pairs_zero hW
  have hphi : ∀ ij : {x : Fin 3 × Fin 3 // x.1 < x.2}, W (phi ij.1.1 ij.1.2) = 0 := by
    intro ij
    have hS : IsSkew (W (phi ij.1.1 ij.1.2)) := hW.1 _ (phi_isSkew _ _)
    rw [HamiltonsCubic.L240SlotBasis.phi_expand_ordered _ hS]
    refine Finset.sum_eq_zero fun kl _ => ?_
    rw [RealLayer.inner2_comm, hz _ _ _ _ ij.2 kl.2, zero_smul]
  rw [HamiltonsCubic.L240SlotBasis.phi_expand_ordered X hX,
    weyl_lin hW Finset.univ _ _ (fun ij => phi_isSkew _ _)]
  exact Finset.sum_eq_zero fun ij _ => by rw [hphi ij, smul_zero]

/-- **L33 AT `m = 3`**, where no Weyl operator has a nonzero eigenvalue. -/
theorem L33_three (W : Matrix (Fin 3) (Fin 3) ℝ → Matrix (Fin 3) (Fin 3) ℝ)
    (hW : IsWeyl W) (x : Matrix (Fin 3) (Fin 3) ℝ) (lam : ℝ) (hmin : MinoritySide W x lam) :
    False := by
  obtain ⟨hx, hx0, hlam, heig, -⟩ := hmin
  rw [weyl3_zero hW x hx] at heig
  rcases smul_eq_zero.mp heig.symm with h | h
  · exact absurd h (ne_of_lt hlam)
  · exact hx0 h

/-- **L33 AT EVERY `m`**: `L33_no_such_W` off `m = 3`, `L33_three` at it. -/
theorem L33_all {m : ℕ} (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ) (hW : IsWeyl W)
    (x : Matrix (Fin m) (Fin m) ℝ) (lam : ℝ) (hmin : MinoritySide W x lam)
    (hexc : ¬ IsScaledComplexStructure x) : False := by
  by_cases hm : m = 3
  · subst hm; exact L33_three W hW x lam hmin
  · exact L33_no_such_W hm W hW x lam hmin hexc

/-- **The positive minority side**: `x` spans an eigenvector of `λ > 0` and `W ≤ 0` on `x^⊥`. -/
def MinoritySidePos {m : ℕ} (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ)
    (x : Matrix (Fin m) (Fin m) ℝ) (lam : ℝ) : Prop :=
  IsSkew x ∧ x ≠ 0 ∧ 0 < lam ∧ W x = lam • x ∧
    ∀ y : Matrix (Fin m) (Fin m) ℝ, IsSkew y → inner2 y x = 0 → inner2 (W y) y ≤ 0

/-- `inner2` is odd in its first slot. -/
theorem inner2_neg_left {m : ℕ} (A B : Matrix (Fin m) (Fin m) ℝ) :
    inner2 (-A) B = -inner2 A B := by
  unfold inner2; simp [Matrix.transpose_neg, Matrix.trace_neg]

/-- **`−W` is Weyl when `W` is.** -/
theorem isWeyl_neg {m : ℕ} {W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ}
    (hW : IsWeyl W) : IsWeyl (fun X => -W X) := by
  obtain ⟨hsk, hsym, hB, hRic⟩ := hW
  refine ⟨fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · have h := hsk X hX; unfold IsSkew at *; rw [Matrix.transpose_neg, h]
  · rw [inner2_neg_left, RealLayer.inner2_comm X (-W Y), inner2_neg_left, hsym X Y hX hY,
      RealLayer.inner2_comm]
  · have h := hB i j k l
    unfold bianchi at *
    simp only [inner2_neg_left]
    linarith
  · have h := hRic a b
    unfold Ric at *
    simp only [inner2_neg_left, Finset.sum_neg_distrib, h, neg_zero]

/-- **L33 ON THE POSITIVE SIDE**, from `L33_all` applied to `−W`. -/
theorem L33_all_pos {m : ℕ} (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ)
    (hW : IsWeyl W) (x : Matrix (Fin m) (Fin m) ℝ) (lam : ℝ) (hmin : MinoritySidePos W x lam)
    (hexc : ¬ IsScaledComplexStructure x) : False := by
  obtain ⟨hx, hx0, hlam, heig, hnp⟩ := hmin
  refine L33_all (fun X => -W X) (isWeyl_neg hW) x (-lam) ⟨hx, hx0, by linarith, ?_, ?_⟩ hexc
  · show -W x = -lam • x
    rw [heig, neg_smul]
  · intro y hy hyx
    show 0 ≤ inner2 (-W y) y
    rw [inner2_neg_left]
    linarith [hnp y hy hyx]

end HamiltonsCubic.L33Three
