import HamiltonsCubic.Results.L50Lovelock

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L50, the self-contracted terms of the Lovelock contraction

A permutation whose upper slot `p` reads one of its own factor's lower indices contracts that factor with itself.
Summing over that one index first (`sum_update`) turns the factor into a Ricci trace (`sum_ricci_zero`), so on a
Ricci-flat `W` the term vanishes. One lemma per pair `(p, σ p)` inside a factor, twelve in all, and `selfEdge_zero`
dispatches on them. 640 of the 720 permutations are of this kind.
-/

namespace HamiltonsCubic.L50Lovelock

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Summing over one coordinate first**: `(x, v) ↦ (update x q v, x q)` is an involution of `(Fin 6 → ι) × ι`, so
`∑_x ∑_v G (update x q v) = |ι| ∑_x G x`. -/
theorem sum_update (q : Fin 6) (G : (Fin 6 → ι) → ℝ) :
    ∑ x : Fin 6 → ι, ∑ v : ι, G (Function.update x q v) = (Fintype.card ι : ℝ) * ∑ x : Fin 6 → ι, G x := by
  let e : (Fin 6 → ι) × ι ≃ (Fin 6 → ι) × ι :=
    { toFun := fun p => (Function.update p.1 q p.2, p.1 q)
      invFun := fun p => (Function.update p.1 q p.2, p.1 q)
      left_inv := fun p => by ext <;> simp
      right_inv := fun p => by ext <;> simp }
  have h := Fintype.sum_equiv e (fun p => G (Function.update p.1 q p.2)) (fun p => G p.1) (fun p => by
    simp [e])
  rw [← Fintype.sum_prod_type', h, Fintype.sum_prod_type]
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  rw [Finset.mul_sum]

/-- **A self-contracted factor kills the term**: if the integrand, with coordinate `q` replaced by `v`, is
`A x · W(v, y, v, z)` up to the pair symmetries, Ricci-flatness makes its sum vanish. -/
theorem sum_ricci_zero (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (F : (Fin 6 → ι) → ℝ) (q : Fin 6) (A : (Fin 6 → ι) → ℝ) (y z : (Fin 6 → ι) → ι)
    (hF : ∀ x v, F (Function.update x q v) = A x * W v (y x) v (z x)) :
    ∑ x, F x = 0 := by
  have h := sum_update q F
  simp only [hF, ← Finset.mul_sum] at h
  have hz : ∀ x, ∑ v, W v (y x) v (z x) = 0 := by
    intro x
    have := hRic (y x) (z x)
    rw [← this]
    refine Finset.sum_congr rfl fun v _ => ?_
    rw [hW.anti12, hW.anti34]; ring
  simp only [hz, mul_zero, Finset.sum_const_zero] at h
  rcases Nat.eq_zero_or_pos (Fintype.card ι) with h0 | h0
  · have : IsEmpty ι := Fintype.card_eq_zero_iff.mp h0
    simp
  · have : (0 : ℝ) < Fintype.card ι := by exact_mod_cast h0
    nlinarith [h]

theorem self_case_0_0 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 0 = 0) : ∑ x, LLterm W σ x = 0 := by
  have h1 : σ 1 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 0 (fun x => W (x 2) (x 3) (x (σ 2)) (x (σ 3)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5))) (fun x => x 1) (fun x => x (σ 1)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h1, h2, h3, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  try ring

theorem self_case_0_1 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 0 = 1) : ∑ x, LLterm W σ x = 0 := by
  have h1 : σ 1 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 1 (fun x => -(W (x 2) (x 3) (x (σ 2)) (x (σ 3)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5)))) (fun x => x 0) (fun x => x (σ 1)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h1, h2, h3, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti12 _ v]
  try ring

theorem self_case_1_0 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 1 = 0) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 0 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 0 (fun x => -(W (x 2) (x 3) (x (σ 2)) (x (σ 3)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5)))) (fun x => x 1) (fun x => x (σ 0)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h2, h3, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti34 v]
  try ring

theorem self_case_1_1 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 1 = 1) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 1 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 1 (fun x => W (x 2) (x 3) (x (σ 2)) (x (σ 3)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5))) (fun x => x 0) (fun x => x (σ 0)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h2, h3, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti12 _ v, hW.anti34 v]
  try ring

theorem self_case_2_2 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 2 = 2) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 2 (fun x => W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5))) (fun x => x 3) (fun x => x (σ 3)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h3, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  try ring

theorem self_case_2_3 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 2 = 3) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 3 (fun x => -(W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5)))) (fun x => x 2) (fun x => x (σ 3)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h3, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti12 _ v]
  try ring

theorem self_case_3_2 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 3 = 2) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 2 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 2 (fun x => -(W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5)))) (fun x => x 3) (fun x => x (σ 2)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h2, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti34 v]
  try ring

theorem self_case_3_3 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 3 = 3) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 3 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 3 (fun x => W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5))) (fun x => x 2) (fun x => x (σ 2)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h2, h4, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti12 _ v, hW.anti34 v]
  try ring

theorem self_case_4_4 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 4 = 4) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 4 (fun x => W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 2) (x 3) (x (σ 2)) (x (σ 3))) (fun x => x 5) (fun x => x (σ 5)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h2, h3, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  try ring

theorem self_case_4_5 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 4 = 5) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h5 : σ 5 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 5 (fun x => -(W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 2) (x 3) (x (σ 2)) (x (σ 3)))) (fun x => x 4) (fun x => x (σ 5)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h2, h3, h5, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti12 _ v]
  try ring

theorem self_case_5_4 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 5 = 4) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 4 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 4 (fun x => -(W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 2) (x 3) (x (σ 2)) (x (σ 3)))) (fun x => x 5) (fun x => x (σ 4)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h2, h3, h4, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti34 v]
  try ring

theorem self_case_5_5 (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : σ 5 = 5) : ∑ x, LLterm W σ x = 0 := by
  have h0 : σ 0 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h1 : σ 1 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h2 : σ 2 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h3 : σ 3 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  have h4 : σ 4 ≠ 5 := fun h => absurd (σ.injective (h.trans hσ.symm)) (by decide)
  refine sum_ricci_zero W hW hRic _ 5 (fun x => W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 2) (x 3) (x (σ 2)) (x (σ 3))) (fun x => x 4) (fun x => x (σ 4)) fun x v => ?_
  simp only [LLterm, Function.update_apply, hσ, h0, h1, h2, h3, h4, if_true, if_false]
  simp (config := {decide := true}) only [if_false]
  rw [hW.anti12 _ v, hW.anti34 v]
  try ring

/-- The owner of a slot position: `0, 1 ↦ 0`, `2, 3 ↦ 1`, `4, 5 ↦ 2`. -/
def owner (i : Fin 6) : Fin 3 := ⟨i.val / 2, by omega⟩

/-- **A self-contracted permutation**: some factor's upper slot `p` reads one of its own lower indices. -/
def selfEdge (σ : Equiv.Perm (Fin 6)) : Prop := ∃ p : Fin 6, owner (σ p) = owner p

instance : DecidablePred selfEdge := fun σ => by unfold selfEdge; infer_instance

/-- **Every self-contracted term vanishes** on a Ricci-flat `W`. -/
theorem selfEdge_zero (W : ι → ι → ι → ι → ℝ) (hW : WeylC W) (hRic : ∀ a b, ∑ c, W a c b c = 0)
    (σ : Equiv.Perm (Fin 6)) (hσ : selfEdge σ) : ∑ x, LLterm W σ x = 0 := by
  obtain ⟨p, hp⟩ := hσ
  simp only [owner, Fin.mk.injEq] at hp
  have hlt := (σ p).isLt
  fin_cases p <;> simp at hp
  · rcases (show (σ 0).val = 0 ∨ (σ 0).val = 1 by omega) with h | h
    · exact self_case_0_0 W hW hRic σ (Fin.ext h)
    · exact self_case_0_1 W hW hRic σ (Fin.ext h)
  · rcases (show (σ 1).val = 0 ∨ (σ 1).val = 1 by omega) with h | h
    · exact self_case_1_0 W hW hRic σ (Fin.ext h)
    · exact self_case_1_1 W hW hRic σ (Fin.ext h)
  · rcases (show (σ 2).val = 2 ∨ (σ 2).val = 3 by omega) with h | h
    · exact self_case_2_2 W hW hRic σ (Fin.ext h)
    · exact self_case_2_3 W hW hRic σ (Fin.ext h)
  · rcases (show (σ 3).val = 2 ∨ (σ 3).val = 3 by omega) with h | h
    · exact self_case_3_2 W hW hRic σ (Fin.ext h)
    · exact self_case_3_3 W hW hRic σ (Fin.ext h)
  · rcases (show (σ 4).val = 4 ∨ (σ 4).val = 5 by omega) with h | h
    · exact self_case_4_4 W hW hRic σ (Fin.ext h)
    · exact self_case_4_5 W hW hRic σ (Fin.ext h)
  · rcases (show (σ 5).val = 4 ∨ (σ 5).val = 5 by omega) with h | h
    · exact self_case_5_4 W hW hRic σ (Fin.ext h)
    · exact self_case_5_5 W hW hRic σ (Fin.ext h)

end HamiltonsCubic.L50Lovelock
