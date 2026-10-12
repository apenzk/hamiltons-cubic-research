import Mathlib.Tactic
import HamiltonsCubic.Results.WeylTraceInvariance

/-!
# A Weyl operator fixed by sign flips and transpositions is zero

The coordinate law `act_coord` at a diagonal sign matrix multiplies `R_ijkl` by `s_i s_j s_k s_l`,
and at a permutation matrix permutes its indices. Invariance under the single flips kills every
coordinate in which some index appears once, which leaves `c_ab = R_abab`; invariance under the
transpositions fixing `a` makes `c_ab` independent of `b`, and Ricci-flatness `Σ_b c_ab = 0` then
forces it to vanish. So every coordinate vanishes, and an operator of the record's `𝒲ₙ` is
determined by its coordinates.
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

/-- A condition independent of the summation variable comes out of the sum. -/
@[simp] theorem sum_ite_out {α : Type*} (s : Finset α) (p : Prop) [Decidable p] (f : α → ℝ) :
    ∑ x ∈ s, (if p then f x else 0) = if p then ∑ x ∈ s, f x else 0 := by
  split_ifs <;> simp

/-- The coordinates. -/
noncomputable def coord (R : CurvLin ι) (i j k l : ι) : ℝ := inner2 (R (phi i j)) (phi k l)

/-- Flip the sign of the `m`-th coordinate. -/
def flip (m : ι) : Matrix ι ι ℝ := Matrix.diagonal fun i => if i = m then -1 else 1

theorem flip_orth (m : ι) : (flip m)ᵀ * flip m = 1 := by
  unfold flip
  rw [Matrix.diagonal_transpose, Matrix.diagonal_mul_diagonal]
  rw [← Matrix.diagonal_one]; congr 1; funext i; split_ifs <;> norm_num

/-- The permutation matrix of `σ`, with `P i a = [σ i = a]`. -/
def permMat (σ : Equiv.Perm ι) : Matrix ι ι ℝ := fun i a => if σ i = a then 1 else 0

theorem permMat_orth (σ : Equiv.Perm ι) : (permMat σ)ᵀ * permMat σ = 1 := by
  ext a b
  simp only [Matrix.mul_apply, Matrix.transpose_apply, permMat, Matrix.one_apply, mul_ite, mul_one,
    mul_zero]
  by_cases h : a = b
  · subst h
    rw [Finset.sum_eq_single (σ.symm a)]
    · simp
    · intro c _ hc
      have hca : σ c ≠ a := fun h' => hc (by rw [← h']; simp)
      simp [hca]
    · simp
  · simp only [h, if_false]
    apply Finset.sum_eq_zero; intro i _
    split_ifs with h1 h2
    · exact absurd (h2.symm.trans h1) h
    · rfl
    · rfl

/-- The sign of the flip at index `i`. -/
def sgn (m i : ι) : ℝ := if i = m then -1 else 1

theorem rot_flip (m i j : ι) : (flip m)ᵀ * phi i j * flip m = (sgn m i * sgn m j) • phi i j := by
  rw [rot_phi]
  rw [Finset.sum_eq_single i]
  · rw [Finset.sum_eq_single j]
    · simp [flip, sgn, Matrix.diagonal_apply]
    · intro b _ hb; simp [flip, Matrix.diagonal_apply, Ne.symm hb]
    · simp
  · intro a _ ha
    apply Finset.sum_eq_zero; intro b _
    simp [flip, Matrix.diagonal_apply, Ne.symm ha]
  · simp

theorem rot_perm (σ : Equiv.Perm ι) (i j : ι) :
    (permMat σ)ᵀ * phi i j * permMat σ = phi (σ i) (σ j) := by
  rw [rot_phi]
  rw [Finset.sum_eq_single (σ i)]
  · rw [Finset.sum_eq_single (σ j)]
    · simp [permMat]
    · intro b _ hb; simp [permMat, Ne.symm hb]
    · simp
  · intro a _ ha
    apply Finset.sum_eq_zero; intro b _
    simp [permMat, Ne.symm ha]
  · simp

/-- **The coordinate law at a flip.** -/
theorem coord_flip (m : ι) (R : CurvLin ι) (i j k l : ι) :
    coord (act (flip m) R) i j k l = sgn m i * sgn m j * sgn m k * sgn m l * coord R i j k l := by
  unfold coord
  rw [act_apply, inner2_conj, rot_flip, rot_flip, map_smul, inner2_smul_left'',
    inner2_smul_right'']
  ring

/-- **The coordinate law at a permutation.** -/
theorem coord_perm (σ : Equiv.Perm ι) (R : CurvLin ι) (i j k l : ι) :
    coord (act (permMat σ) R) i j k l = coord R (σ i) (σ j) (σ k) (σ l) := by
  unfold coord
  rw [act_apply, inner2_conj, rot_perm, rot_perm]

theorem sgn_self (m : ι) : sgn m m = -1 := by simp [sgn]
theorem sgn_ne {m i : ι} (h : i ≠ m) : sgn m i = 1 := by simp [sgn, h]

section Invariant

variable (R : CurvLin ι) (hR : R ∈ weylModuleS ι)
  (hf : ∀ m, act (flip m) R = R) (hp : ∀ j k, act (permMat (Equiv.swap j k)) R = R)
include hR hf hp

/-- An index appearing once in the first slot kills the coordinate. -/
theorem coord_single {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) :
    coord R i j k l = 0 := by
  have h := coord_flip i R i j k l
  rw [hf i, sgn_self, sgn_ne (Ne.symm hij), sgn_ne (Ne.symm hik), sgn_ne (Ne.symm hil)] at h
  linarith

theorem coord_swap12 (i j k l : ι) : coord R i j k l = -coord R j i k l := by
  unfold coord; rw [phi_swap i j, map_neg]; simp [inner2]

theorem coord_swap34 (i j k l : ι) : coord R i j k l = -coord R i j l k := by
  unfold coord; rw [phi_swap k l]; simp [inner2]

theorem coord_self12 (i k l : ι) : coord R i i k l = 0 := by
  unfold coord; rw [phi_self, map_zero]; simp [inner2]

/-- **Only `c_ab = R_abab` survives.** -/
theorem coord_reduce (i j k l : ι) (hkl : ¬(k = i ∧ l = j)) (hlk : ¬(k = j ∧ l = i)) :
    coord R i j k l = 0 := by
  by_cases hij : i = j
  · subst hij; exact coord_self12 R hR hf hp i k l
  by_cases hik : i = k
  · subst hik
    have hlj : l ≠ j := fun h => hkl ⟨rfl, h⟩
    by_cases hil : i = l
    · subst hil; rw [coord_swap34 R hR hf hp, ← coord_swap34 R hR hf hp]
      unfold coord; rw [phi_self]; simp [inner2]
    · rw [coord_swap12 R hR hf hp]
      have := coord_single R hR hf hp (i := j) (j := i) (k := i) (l := l) (Ne.symm hij)
        (Ne.symm hij) (Ne.symm hlj)
      rw [this, neg_zero]
  by_cases hil : i = l
  · subst hil
    have hkj : k ≠ j := fun h => hlk ⟨h, rfl⟩
    rw [coord_swap12 R hR hf hp]
    have := coord_single R hR hf hp (i := j) (j := i) (k := k) (l := i) (Ne.symm hij)
      (Ne.symm hkj) (Ne.symm hij)
    rw [this, neg_zero]
  · exact coord_single R hR hf hp hij hik hil

/-- **`c_ab` does not depend on `b`.** -/
theorem coord_c_eq {a b c : ι} (hb : b ≠ a) (hc : c ≠ a) : coord R a b a b = coord R a c a c := by
  have h := coord_perm (Equiv.swap b c) R a b a b
  rw [hp b c] at h
  rw [h, Equiv.swap_apply_of_ne_of_ne (Ne.symm hb) (Ne.symm hc), Equiv.swap_apply_left]

/-- **Ricci-flatness kills `c_ab`.** -/
theorem coord_c_zero {a b : ι} (hab : a ≠ b) : coord R a b a b = 0 := by
  have hric := hR.1.2.2.2 a a
  unfold Ric at hric
  have hsum : ∑ c, coord R a c a c = (((Finset.univ : Finset ι).card : ℝ) - 1) * coord R a b a b := by
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
    rw [coord_self12 R hR hf hp, zero_add]
    rw [Finset.sum_congr rfl (fun c hc => coord_c_eq R hR hf hp (Finset.ne_of_mem_erase hc)
      (Ne.symm hab) |>.trans (coord_c_eq R hR hf hp (Ne.symm hab) (Ne.symm hab)))]
    · rw [Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_univ a), nsmul_eq_mul,
        Nat.cast_sub (Finset.card_pos.mpr ⟨a, Finset.mem_univ a⟩), Nat.cast_one]
  have h0 : ∑ c, coord R a c a c = 0 := hric
  have hcard : (2 : ℝ) ≤ (Finset.univ : Finset ι).card := by
    have : ({a, b} : Finset ι).card ≤ (Finset.univ : Finset ι).card := Finset.card_le_univ _
    rw [Finset.card_pair hab] at this
    exact_mod_cast this
  rw [hsum] at h0
  rcases mul_eq_zero.mp h0 with h | h
  · linarith
  · exact h

/-- **Every coordinate vanishes.** -/
theorem coord_zero (i j k l : ι) : coord R i j k l = 0 := by
  by_cases h1 : k = i ∧ l = j
  · obtain ⟨rfl, rfl⟩ := h1
    by_cases hij : k = l
    · subst hij; exact coord_self12 R hR hf hp k k k
    · exact coord_c_zero R hR hf hp hij
  by_cases h2 : k = j ∧ l = i
  · obtain ⟨rfl, rfl⟩ := h2
    rw [coord_swap34 R hR hf hp]
    by_cases hij : l = k
    · subst hij; rw [coord_self12 R hR hf hp, neg_zero]
    · rw [coord_c_zero R hR hf hp hij, neg_zero]
  exact coord_reduce R hR hf hp i j k l h1 h2

end Invariant

theorem inner2_phi_eq (M : Matrix ι ι ℝ) (k l : ι) : inner2 M (phi k l) = (1 / 2) * (M l k - M k l) := by
  simp only [inner2, phi, Matrix.mul_sub, Matrix.trace_sub, Matrix.trace, Matrix.diag,
    Matrix.mul_apply, Matrix.transpose_apply, Matrix.single_apply]
  simp only [Matrix.single_apply, Matrix.sub_apply, mul_sub, Finset.sum_sub_distrib, mul_ite, mul_one,
    mul_zero, ite_and, sum_ite_out, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem skew_eq_zero_of_coord (M : Matrix ι ι ℝ) (hM : IsSkew M) (h : ∀ k l, inner2 M (phi k l) = 0) :
    M = 0 := by
  ext l k
  have h1 := h k l
  rw [inner2_phi_eq] at h1
  have h2 : M k l = -M l k := by
    have := congrFun (congrFun hM l) k
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    exact this
  simp only [Matrix.zero_apply]
  linarith

theorem skew_expand (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    X = (1 / 2 : ℝ) • ∑ k, ∑ l, X l k • phi k l := by
  ext p q
  have hqp : X q p = -X p q := by
    have := congrFun (congrFun hX p) q
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    exact this
  simp only [Matrix.smul_apply, Matrix.sum_apply, phi, Matrix.sub_apply, Matrix.single_apply,
    smul_eq_mul, mul_sub, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib]
  simp [ite_and, Finset.sum_ite_eq, Finset.sum_ite_eq']
  rw [hqp]; ring

/-- **A Weyl operator fixed by every single sign flip and every transposition is zero.** -/
theorem invariant_zero (R : CurvLin ι) (hR : R ∈ weylModuleS ι)
    (hf : ∀ m, act (flip m) R = R) (hp : ∀ j k, act (permMat (Equiv.swap j k)) R = R) : R = 0 := by
  have hphi : ∀ i j, R (phi i j) = 0 := fun i j =>
    skew_eq_zero_of_coord _ (hR.1.1 _ (phi_isSkew i j)) (fun k l => coord_zero R hR hf hp i j k l)
  have hskew : ∀ X, IsSkew X → R X = 0 := by
    intro X hX
    rw [skew_expand X hX]
    simp [map_sum, map_smul, hphi]
  apply LinearMap.ext; intro Z
  have hZ : Z = (1 / 2 : ℝ) • (Z - Zᵀ) + (1 / 2 : ℝ) • (Z + Zᵀ) := by
    ext p q; simp [Matrix.add_apply, Matrix.sub_apply]; ring
  have hA : IsSkew ((1 / 2 : ℝ) • (Z - Zᵀ)) := by
    unfold IsSkew; rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_transpose]
    ext p q; simp [Matrix.sub_apply]; ring
  have hS : ((1 / 2 : ℝ) • (Z + Zᵀ))ᵀ = (1 / 2 : ℝ) • (Z + Zᵀ) := by
    rw [Matrix.transpose_smul, Matrix.transpose_add, Matrix.transpose_transpose, add_comm]
  rw [hZ, map_add, hskew _ hA, hR.2 _ hS, add_zero]
  simp

end HamiltonsCubic.Results
