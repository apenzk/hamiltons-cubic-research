import Mathlib.Tactic
import HamiltonsCubic.Results.WeylInvariantZero

/-!
# `tr (L e) = 0` on the record's `𝒲ₙ`

Average `e` over the signed permutation matrices `D_S P_σ`: the average `avg e` is fixed by every
single flip (`avg_flip`) and every permutation (`avg_perm`), so it is zero by `invariant_zero`.
The functional `e ↦ tr L e` is additive (`trE_add`) and invariant under the action
(`trE_act`), so `0 = tr L (avg e) = |G| · tr L e`.
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

theorem act_comp (g h : Matrix ι ι ℝ) (R : CurvLin ι) : act g (act h R) = act (g * h) R := by
  apply LinearMap.ext; intro Z
  simp only [act_apply, Matrix.transpose_mul, Matrix.mul_assoc]

theorem act_sum {α : Type*} (s : Finset α) (g : Matrix ι ι ℝ) (f : α → CurvLin ι) :
    act g (∑ a ∈ s, f a) = ∑ a ∈ s, act g (f a) := by
  apply LinearMap.ext; intro Z
  simp only [act_apply, LinearMap.sum_apply, Matrix.mul_sum, Matrix.sum_mul]

/-- The diagonal sign matrix flipping the coordinates in `S`. -/
def signSet (S : Finset ι) : Matrix ι ι ℝ := Matrix.diagonal fun i => if i ∈ S then -1 else 1

theorem signSet_orth (S : Finset ι) : (signSet S)ᵀ * signSet S = 1 := by
  unfold signSet
  rw [Matrix.diagonal_transpose, Matrix.diagonal_mul_diagonal, ← Matrix.diagonal_one]
  congr 1; funext i; split_ifs <;> norm_num

theorem orth_mul {A B : Matrix ι ι ℝ} (hA : Aᵀ * A = 1) (hB : Bᵀ * B = 1) :
    (A * B)ᵀ * (A * B) = 1 := by
  rw [Matrix.transpose_mul]
  calc Bᵀ * Aᵀ * (A * B) = Bᵀ * (Aᵀ * A) * B := by simp only [Matrix.mul_assoc]
    _ = 1 := by rw [hA, Matrix.mul_one, hB]

theorem orth_comm {A : Matrix ι ι ℝ} (hA : Aᵀ * A = 1) : A * Aᵀ = 1 := mul_eq_one_comm.mp hA

theorem flip_mul_signSet (m : ι) (S : Finset ι) :
    flip m * signSet S = signSet (symmDiff S {m}) := by
  unfold flip signSet
  rw [Matrix.diagonal_mul_diagonal]
  congr 1; funext i
  by_cases hi : i ∈ S <;> by_cases hm : i = m
  · subst hm; simp [hi, Finset.mem_symmDiff]
  · simp [hi, hm, Finset.mem_symmDiff]
  · subst hm; simp [hi, Finset.mem_symmDiff]
  · simp [hi, hm, Finset.mem_symmDiff]

theorem permMat_mul (τ σ : Equiv.Perm ι) : permMat τ * permMat σ = permMat (τ.trans σ) := by
  ext i a
  simp only [Matrix.mul_apply, permMat, Equiv.trans_apply, mul_ite, mul_one, mul_zero]
  rw [Finset.sum_eq_single (τ i)]
  · by_cases h : σ (τ i) = a <;> simp [h]
  · intro b _ hb; simp [Ne.symm hb]
  · simp

theorem permMat_mul_signSet (τ : Equiv.Perm ι) (S : Finset ι) :
    permMat τ * signSet S = signSet (S.map τ.symm.toEmbedding) * permMat τ := by
  ext i a
  simp only [Matrix.mul_apply, permMat, signSet, Matrix.diagonal_apply, ite_mul, one_mul, zero_mul,
    mul_ite, mul_one, mul_zero]
  rw [Finset.sum_eq_single (τ i), Finset.sum_eq_single i]
  · by_cases h : τ i = a
    · subst h; simp [Finset.mem_map_equiv]
    · simp [h]
  · intro b _ hb; simp [Ne.symm hb]
  · simp
  · intro b _ hb; simp [Ne.symm hb]
  · simp

/-- **The average over the signed permutation matrices.** -/
noncomputable def avg (e : CurvLin ι) : CurvLin ι :=
  ∑ S : Finset ι, ∑ σ : Equiv.Perm ι, act (signSet S * permMat σ) e

theorem avg_mem (e : CurvLin ι) (he : e ∈ weylModuleS ι) : avg e ∈ weylModuleS ι :=
  Submodule.sum_mem _ fun S _ => Submodule.sum_mem _ fun σ _ =>
    act_mem _ (orth_mul (signSet_orth S) (permMat_orth σ)) e he

theorem avg_flip (m : ι) (e : CurvLin ι) : act (flip m) (avg e) = avg e := by
  unfold avg
  simp only [act_sum, act_comp, ← Matrix.mul_assoc, flip_mul_signSet]
  let E : Finset ι ≃ Finset ι :=
    Function.Involutive.toPerm (fun S => symmDiff S {m}) (fun S => symmDiff_symmDiff_cancel_right _ _)
  exact Fintype.sum_equiv E _ _ (fun S => rfl)

theorem avg_perm (τ : Equiv.Perm ι) (e : CurvLin ι) : act (permMat τ) (avg e) = avg e := by
  unfold avg
  simp only [act_sum, act_comp, ← Matrix.mul_assoc, permMat_mul_signSet]
  simp only [Matrix.mul_assoc, permMat_mul]
  refine Fintype.sum_equiv (Equiv.finsetCongr τ.symm) _ _ (fun S => ?_)
  refine Fintype.sum_equiv (Equiv.mulRight τ) _ _ (fun σ => ?_)
  simp [Equiv.Perm.mul_def, Equiv.finsetCongr_apply]

/-- **The average is zero.** -/
theorem avg_eq_zero (e : CurvLin ι) (he : e ∈ weylModuleS ι) : avg e = 0 :=
  invariant_zero (avg e) (avg_mem e he) (fun m => avg_flip m e) (fun j k => avg_perm _ e)

/-- The trace of the (unique) `L e`. -/
noncomputable def trE (e : weylModuleS ι) : ℝ :=
  LinearMap.trace ℝ (weylModuleS ι) (Classical.choose (leftMulS_exists (e : CurvLin ι) e.2))

theorem trE_spec (e : weylModuleS ι) (L : weylModuleS ι →ₗ[ℝ] weylModuleS ι)
    (hL : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      (L Y : CurvLin ι) Z = foxProd (fun A => (e : CurvLin ι) A) (fun A => (Y : CurvLin ι) A) Z) :
    LinearMap.trace ℝ (weylModuleS ι) L = trE e := by
  unfold trE
  rw [leftMulS_unique _ L _ hL (Classical.choose_spec (leftMulS_exists (e : CurvLin ι) e.2))]

theorem foxProd_add_left' (X X' : CurvLin ι) (Y : CurvLin ι) (Z : Matrix ι ι ℝ) :
    foxProd (fun A => (X + X') A) (fun A => Y A) Z =
      foxProd (fun A => X A) (fun A => Y A) Z + foxProd (fun A => X' A) (fun A => Y A) Z := by
  rw [foxProd_comm, foxProd_comm (fun A => X A), foxProd_comm (fun A => X' A)]
  have : (fun A => (X + X') A) = fun W => X W + X' W := by funext W; simp
  rw [this]
  exact foxProd_add_right _ _ _ (isLinOp_of_curvLin Y) (isLinOp_of_curvLin X)
    (isLinOp_of_curvLin X') Z

theorem trE_add (e f : weylModuleS ι) : trE (e + f) = trE e + trE f := by
  have he := Classical.choose_spec (leftMulS_exists (e : CurvLin ι) e.2)
  have hf := Classical.choose_spec (leftMulS_exists (f : CurvLin ι) f.2)
  rw [← trE_spec (e + f) (Classical.choose (leftMulS_exists (e : CurvLin ι) e.2) +
      Classical.choose (leftMulS_exists (f : CurvLin ι) f.2)), map_add]
  · rfl
  · intro Y Z
    rw [LinearMap.add_apply, Submodule.coe_add, LinearMap.add_apply, he, hf, Submodule.coe_add,
      foxProd_add_left']

theorem trE_zero : trE (0 : weylModuleS ι) = 0 := by
  have := trE_add (0 : weylModuleS ι) 0
  rw [add_zero] at this
  linarith

theorem trE_sum {α : Type*} (s : Finset α) (f : α → weylModuleS ι) :
    trE (∑ a ∈ s, f a) = ∑ a ∈ s, trE (f a) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [trE_zero]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, trE_add, ih]

theorem trE_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (e : weylModuleS ι) :
    trE (actS g hg e) = trE e := by
  have he := Classical.choose_spec (leftMulS_exists (e : CurvLin ι) e.2)
  have hge := Classical.choose_spec (leftMulS_exists ((actS g hg e : weylModuleS ι) : CurvLin ι)
    (actS g hg e).2)
  unfold trE
  exact trace_leftMulS_act g hg (orth_comm hg) e _ _ he hge

/-- **`tr (L e) = 0` on the record's `𝒲ₙ`.** -/
theorem trace_leftMulS_eq_zero' (e : CurvLin ι) (he : e ∈ weylModuleS ι)
    (L : weylModuleS ι →ₗ[ℝ] weylModuleS ι)
    (hL : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      (L Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z) :
    LinearMap.trace ℝ (weylModuleS ι) L = 0 := by
  set E : weylModuleS ι := ⟨e, he⟩
  rw [trE_spec E L hL]
  have hg : ∀ (S : Finset ι) (σ : Equiv.Perm ι),
      (signSet S * permMat σ)ᵀ * (signSet S * permMat σ) = 1 :=
    fun S σ => orth_mul (signSet_orth S) (permMat_orth σ)
  have havg : (∑ S : Finset ι, ∑ σ : Equiv.Perm ι, actS (signSet S * permMat σ) (hg S σ) E) =
      (0 : weylModuleS ι) := by
    apply Subtype.ext
    simp only [Submodule.coe_sum, Submodule.coe_zero]
    exact avg_eq_zero e he
  have h := congrArg trE havg
  rw [trE_zero, trE_sum] at h
  simp only [trE_sum, trE_act] at h
  rw [Finset.sum_const, Finset.sum_const, smul_smul, nsmul_eq_mul] at h
  have hpos : (0 : ℝ) < ((Finset.univ : Finset (Finset ι)).card * (Finset.univ : Finset (Equiv.Perm ι)).card : ℕ) := by
    have h1 := Finset.card_pos.mpr (⟨∅, Finset.mem_univ _⟩ : (Finset.univ : Finset (Finset ι)).Nonempty)
    have h2 := Finset.card_pos.mpr (⟨1, Finset.mem_univ _⟩ : (Finset.univ : Finset (Equiv.Perm ι)).Nonempty)
    exact_mod_cast Nat.mul_pos h1 h2
  rcases mul_eq_zero.mp h with h' | h'
  · exact absurd h' (ne_of_gt hpos)
  · exact h'

end HamiltonsCubic.Results
