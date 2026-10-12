import HamiltonsCubic.Results.L71Statement
import HamiltonsCubic.Results.SoSimple

/-!
# L71, proved

[L71Statement.lean](L71Statement.lean) carries the statement's definitions; the proof needs
[SoSimple.lean](SoSimple.lean), so it lives here, in the statement's namespace.

**The proof.** `𝔤' = 𝔪 + [𝔪,𝔪]` is invariant under `𝔪`, `𝔥` and `𝔯` by the Jacobi identity, hence an ideal of
`𝔰𝔬(n)`, hence everything since `𝔪 ≠ 0` and `𝔰𝔬(n)` is simple at `n ≥ 5`. `𝔯` commutes with `𝔤'`, so `𝔯 = 0`.
For `𝔥 = [𝔪,𝔪]`: **no orthogonality of `𝔪, 𝔥, 𝔯` is assumed**, so `𝔪 ∩ [𝔪,𝔪]` is handled as a second ideal.
If it is everything, `𝔥 ⊆ [𝔪,𝔪]` at once; if it is zero, the `𝔪`-part of any `y ∈ 𝔥` commutes with `𝔪`, hence
with `𝔤'`, hence vanishes.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L71Statement

open Matrix

variable {n : ℕ}

/-- **L71, the Lie-theoretic half.** Let `𝔪`, `𝔥`, `𝔯` be subspaces of `𝔰𝔬(n)`, `n ≥ 5`, spanning
it, with `𝔪 ≠ 0` and satisfying the three relations L70's equality case delivers,
`[𝔪,𝔪] ⊆ 𝔥`, `[𝔪,𝔥] ⊆ 𝔪`, `[𝔪,𝔯] = 0`. Then `𝔯 = 0`, `𝔥 = [𝔪,𝔪]`, and `[𝔥,𝔥] ⊆ 𝔥`, so
`(𝔰𝔬(n), 𝔥)` is a symmetric pair.

*The third conclusion is the relation the audit found underived in the record's write-up; it is
stated here as a conclusion rather than assumed.* -/
theorem L71 (hn : 5 ≤ n)
    (m h r : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ))
    (hmskew : ∀ A ∈ m, Skew A) (hhskew : ∀ A ∈ h, Skew A) (hrskew : ∀ A ∈ r, Skew A)
    (hspan : ∀ A : Matrix (Fin n) (Fin n) ℝ, Skew A → A ∈ m ⊔ h ⊔ r)
    (hmm : ∀ u ∈ m, ∀ v ∈ m, br u v ∈ h)
    (hmh : ∀ u ∈ m, ∀ x ∈ h, br u x ∈ m)
    (hmr : ∀ u ∈ m, ∀ z ∈ r, br u z = 0)
    (hm0 : m ≠ ⊥) :
    r = ⊥ ∧ h = brackets m ∧ (∀ x ∈ h, ∀ y ∈ h, br x y ∈ h) := by
  have jac : ∀ X Y Z : Matrix (Fin n) (Fin n) ℝ, br X (br Y Z) = br (br X Y) Z + br Y (br X Z) := by
    intro X Y Z; unfold br; noncomm_ring
  have anti : ∀ X Y : Matrix (Fin n) (Fin n) ℝ, br X Y = -br Y X := by intro X Y; unfold br; abel
  have badd_r : ∀ X Y Z : Matrix (Fin n) (Fin n) ℝ, br X (Y + Z) = br X Y + br X Z := by
    intro X Y Z; unfold br; noncomm_ring
  have badd_l : ∀ X Y Z : Matrix (Fin n) (Fin n) ℝ, br (X + Y) Z = br X Z + br Y Z := by
    intro X Y Z; unfold br; noncomm_ring
  have bsmul_r : ∀ (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ), br X (c • Y) = c • br X Y := by
    intro c X Y; unfold br; rw [Matrix.mul_smul, Matrix.smul_mul, smul_sub]
  have bzero_r : ∀ X : Matrix (Fin n) (Fin n) ℝ, br X 0 = 0 := by intro X; unfold br; simp
  -- the six closure facts
  have c1 : ∀ u ∈ m, ∀ a ∈ m, br u a ∈ brackets m := fun u hu a ha => Submodule.subset_span ⟨u, hu, a, ha, rfl⟩
  have hbh : brackets m ≤ h := by
    rw [brackets, Submodule.span_le]; rintro _ ⟨u, hu, v, hv, rfl⟩; exact hmm u hu v hv
  have c2 : ∀ u ∈ m, ∀ k ∈ brackets m, br u k ∈ m := by
    intro u hu k hk
    induction hk using Submodule.span_induction with
    | mem x hx => obtain ⟨v, hv, w, hw, rfl⟩ := hx; exact hmh u hu _ (hmm v hv w hw)
    | zero => rw [bzero_r]; exact m.zero_mem
    | add x y _ _ hx hy => rw [badd_r]; exact m.add_mem hx hy
    | smul c x _ hx => rw [bsmul_r]; exact m.smul_mem c hx
  have c3 : ∀ x ∈ h, ∀ a ∈ m, br x a ∈ m := fun x hx a ha => by
    rw [anti]; exact m.neg_mem (hmh a ha x hx)
  have c4 : ∀ x ∈ h, ∀ k ∈ brackets m, br x k ∈ brackets m := by
    intro x hx k hk
    induction hk using Submodule.span_induction with
    | mem y hy =>
      obtain ⟨v, hv, w, hw, rfl⟩ := hy
      rw [jac]
      exact (brackets m).add_mem (c1 _ (c3 x hx v hv) w hw) (c1 v hv _ (c3 x hx w hw))
    | zero => rw [bzero_r]; exact (brackets m).zero_mem
    | add a b _ _ ha hb => rw [badd_r]; exact (brackets m).add_mem ha hb
    | smul c a _ ha => rw [bsmul_r]; exact (brackets m).smul_mem c ha
  have c5 : ∀ z ∈ r, ∀ a ∈ m, br z a = 0 := fun z hz a ha => by rw [anti, hmr a ha z hz, neg_zero]
  have c6 : ∀ z ∈ r, ∀ k ∈ brackets m, br z k = 0 := by
    intro z hz k hk
    induction hk using Submodule.span_induction with
    | mem y hy =>
      obtain ⟨v, hv, w, hw, rfl⟩ := hy
      rw [jac, c5 z hz v hv, c5 z hz w hw]; unfold br; simp
    | zero => exact bzero_r z
    | add a b _ _ ha hb => rw [badd_r, ha, hb, add_zero]
    | smul c a _ ha => rw [bsmul_r, ha, smul_zero]
  -- skewness
  have hsk_br : ∀ X Y : Matrix (Fin n) (Fin n) ℝ, Skew X → Skew Y → Skew (br X Y) := by
    intro X Y hX hY; unfold Skew br at *
    rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hX, hY]; noncomm_ring
  have hkskew : ∀ k ∈ brackets m, Skew k := by
    intro k hk
    induction hk using Submodule.span_induction with
    | mem y hy => obtain ⟨v, hv, w, hw, rfl⟩ := hy; exact hsk_br _ _ (hmskew v hv) (hmskew w hw)
    | zero => unfold Skew; simp
    | add a b _ _ ha hb => unfold Skew at *; rw [Matrix.transpose_add, ha, hb, neg_add]
    | smul c a _ ha => unfold Skew at *; rw [Matrix.transpose_smul, ha, smul_neg]
  -- splitting a skew matrix along `m ⊔ h ⊔ r`
  have hsplit : ∀ X, Skew X → ∃ xm ∈ m, ∃ xh ∈ h, ∃ xr ∈ r, X = xm + xh + xr := by
    intro X hX
    obtain ⟨y, hy, xr, hxr, rfl⟩ := Submodule.mem_sup.mp (hspan X hX)
    obtain ⟨xm, hxm, xh, hxh, rfl⟩ := Submodule.mem_sup.mp hy
    exact ⟨xm, hxm, xh, hxh, xr, hxr, rfl⟩
  -- an ideal of `𝔰𝔬(n)` in the `SoSimple` sense
  have ideal_of : ∀ J : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ),
      (∀ A ∈ J, Skew A) →
      (∀ u ∈ m, ∀ A ∈ J, br u A ∈ J) → (∀ x ∈ h, ∀ A ∈ J, br x A ∈ J) → (∀ z ∈ r, ∀ A ∈ J, br z A ∈ J) →
      ∀ A ∈ J, ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → HamiltonsCubic.SoSimple.bk X A ∈ J := by
    intro J _ hJm hJh hJr A hA X hX
    obtain ⟨xm, hxm, xh, hxh, xr, hxr, rfl⟩ := hsplit X hX
    show br (xm + xh + xr) A ∈ J
    rw [badd_l, badd_l]
    exact J.add_mem (J.add_mem (hJm xm hxm A hA) (hJh xh hxh A hA)) (hJr xr hxr A hA)
  -- `𝔤' = 𝔪 + [𝔪,𝔪]` is everything
  set g' := m ⊔ brackets m with hg'
  have hg'skew : ∀ A ∈ g', Skew A := by
    intro A hA
    obtain ⟨a, ha, k, hk, rfl⟩ := Submodule.mem_sup.mp hA
    have h1 := hmskew a ha; have h2 := hkskew k hk
    unfold Skew at *; rw [Matrix.transpose_add, h1, h2, neg_add]
  have hg'ideal := ideal_of g' hg'skew
    (fun u hu A hA => by
      obtain ⟨a, ha, k, hk, rfl⟩ := Submodule.mem_sup.mp hA
      rw [badd_r]
      exact g'.add_mem (Submodule.mem_sup_right (c1 u hu a ha)) (Submodule.mem_sup_left (c2 u hu k hk)))
    (fun x hx A hA => by
      obtain ⟨a, ha, k, hk, rfl⟩ := Submodule.mem_sup.mp hA
      rw [badd_r]
      exact g'.add_mem (Submodule.mem_sup_left (c3 x hx a ha)) (Submodule.mem_sup_right (c4 x hx k hk)))
    (fun z hz A hA => by
      obtain ⟨a, ha, k, hk, rfl⟩ := Submodule.mem_sup.mp hA
      rw [badd_r, c5 z hz a ha, c6 z hz k hk, add_zero]; exact g'.zero_mem)
  obtain ⟨a0, ha0, ha00⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hm0
  have hall : ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → X ∈ g' :=
    HamiltonsCubic.SoSimple.so_simple g' hg'skew hg'ideal hn ⟨a0, Submodule.mem_sup_left ha0, ha00⟩
  -- a matrix commuting with all of `𝔰𝔬(n)` is zero
  have hcenter : ∀ z : Matrix (Fin n) (Fin n) ℝ, Skew z →
      (∀ Y : Matrix (Fin n) (Fin n) ℝ, Skew Y → br z Y = 0) → z = 0 := by
    intro z hz hc
    apply HamiltonsCubic.SoSimple.center_zero (by omega) hz
    intro a b
    have := hc _ (HamiltonsCubic.SoSimple.ph_skew a b)
    show br (HamiltonsCubic.SoSimple.ph a b) z = 0
    rw [anti, this, neg_zero]
  -- commuting with `𝔤'`
  have hcomm_g : ∀ z : Matrix (Fin n) (Fin n) ℝ, (∀ u ∈ m, br z u = 0) →
      ∀ Y : Matrix (Fin n) (Fin n) ℝ, Skew Y → br z Y = 0 := by
    intro z hzm Y hY
    obtain ⟨a, ha, k, hk, rfl⟩ := Submodule.mem_sup.mp (hall Y hY)
    rw [badd_r, hzm a ha, zero_add]
    clear hY
    induction hk using Submodule.span_induction with
    | mem y hy =>
      obtain ⟨v, hv, w, hw, rfl⟩ := hy
      rw [jac, hzm v hv, hzm w hw]; unfold br; simp
    | zero => exact bzero_r z
    | add x y _ _ hx hy => rw [badd_r, hx, hy, add_zero]
    | smul c x _ hx => rw [bsmul_r, hx, smul_zero]
  have hr : r = ⊥ := by
    rw [eq_bot_iff]
    intro z hz
    rw [Submodule.mem_bot]
    exact hcenter z (hrskew z hz) (hcomm_g z (fun u hu => c5 z hz u hu))
  -- `𝔥 = [𝔪,𝔪]`, through the ideal `𝔪 ∩ [𝔪,𝔪]`
  have hh : h = brackets m := by
    apply le_antisymm _ hbh
    intro y hy
    obtain ⟨a, ha, k, hk, hyak⟩ := Submodule.mem_sup.mp (hall y (hhskew y hy))
    set c := m ⊓ brackets m with hc
    have hcskew : ∀ A ∈ c, Skew A := fun A hA => hmskew A hA.1
    have hcideal := ideal_of c hcskew
      (fun u hu A hA => ⟨c2 u hu A hA.2, c1 u hu A hA.1⟩)
      (fun x hx A hA => ⟨c3 x hx A hA.1, c4 x hx A hA.2⟩)
      (fun z hz A hA => by rw [c5 z hz A hA.1]; exact c.zero_mem)
    by_cases hc0 : ∃ A ∈ c, A ≠ 0
    · exact (HamiltonsCubic.SoSimple.so_simple c hcskew hcideal hn hc0 y (hhskew y hy)).2
    · push Not at hc0
      have hah : a ∈ h := by
        have : a = y - k := by rw [← hyak]; abel
        rw [this]; exact h.sub_mem hy (hbh hk)
      have ha0 : a = 0 := hcenter a (hmskew a ha) (hcomm_g a (fun u hu => by
        rw [anti]; exact neg_eq_zero.mpr (hc0 _ ⟨hmh u hu a hah, c1 u hu a ha⟩)))
      rw [← hyak, ha0, zero_add]; exact hk
  refine ⟨hr, hh, fun x hx y hy => ?_⟩
  rw [hh] at hx hy ⊢
  exact c4 x (hbh hx) y hy

end HamiltonsCubic.L71Statement
