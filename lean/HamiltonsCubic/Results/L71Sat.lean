import Mathlib
import HamiltonsCubic.Results.L71Incl
import HamiltonsCubic.Results.L71Proof

/-!
# L71 end to end: a saturating critical point gives a symmetric pair

[L71Incl.lean](L71Incl.lean) proves L70's equality case as three inclusions **at frame vectors** of
the spectral eigenframe (`L71_mm`, `L71_mh`, `L71_mr`), and [L71Proof.lean](L71Proof.lean) proves
the Lie-theoretic half `L71` **for subspaces** `𝔪, 𝔥, 𝔯` of `𝔰𝔬(n)`. The passage between them, *"the
subspace inclusions following by frame completeness and bilinearity"*, is typed here:

* `sat_of_frame`: for any complete orthonormal frame `v` of `𝔰𝔬(n)` with labels `ev`, if the three
  frame-level inclusions hold then `𝔪 = span{v_k : ev k = λ_min}`, `𝔥 = span{v_k : ev k = λ_max}` and
  `𝔯 = span{v_k : ev k ∉ {λ_min, λ_max}}` satisfy `L71`'s hypotheses, so `𝔯 = 0`, `𝔥 = [𝔪, 𝔪]` and
  `[𝔥, 𝔥] ⊆ 𝔥`;
* `L71_saturated`: at a critical linear Weyl operator saturating L70's bound, in its spectral
  eigenframe with `λ_min` attained and `n ≥ 5`, the same three conclusions, so `(𝔰𝔬(n), 𝔥)` is a
  symmetric pair with `𝔥 = [𝔪, 𝔪]`.
-/

namespace HamiltonsCubic.L71Sat

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement
  HamiltonsCubic.L41Statement.Frame

variable {n : ℕ}

/-- The span of the frame vectors whose label satisfies `p`. -/
noncomputable def spanOf {Γ : Type*} (v : Γ → Matrix (Fin n) (Fin n) ℝ) (p : Γ → Prop) :
    Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) :=
  Submodule.span ℝ (v '' {k | p k})

theorem mem_spanOf {Γ : Type*} (v : Γ → Matrix (Fin n) (Fin n) ℝ) (p : Γ → Prop) {k : Γ}
    (hk : p k) : v k ∈ spanOf v p :=
  Submodule.subset_span ⟨k, hk, rfl⟩

theorem skew_of_spanOf {Γ : Type*} (v : Γ → Matrix (Fin n) (Fin n) ℝ) (p : Γ → Prop)
    (hsk : ∀ k, IsSkew (v k)) : ∀ A ∈ spanOf v p, L71Statement.Skew A := by
  intro A hA
  induction hA using Submodule.span_induction with
  | mem x hx => obtain ⟨k, _, rfl⟩ := hx; exact hsk k
  | zero => show (0 : Matrix (Fin n) (Fin n) ℝ)ᵀ = -0; simp
  | add x y _ _ hx hy =>
      show (x + y)ᵀ = -(x + y)
      rw [Matrix.transpose_add, hx, hy, neg_add]
  | smul c x _ hx =>
      show (c • x)ᵀ = -(c • x)
      rw [Matrix.transpose_smul, hx, smul_neg]

/-- `br` is linear in its first argument and vanishes at `0`, in the form `span_induction` uses. -/
theorem br_add_l (X Y Z : Matrix (Fin n) (Fin n) ℝ) : br (X + Y) Z = br X Z + br Y Z := by
  simp only [br]; noncomm_ring
theorem br_add_r (X Y Z : Matrix (Fin n) (Fin n) ℝ) : br X (Y + Z) = br X Y + br X Z := by
  simp only [br]; noncomm_ring
theorem br_smul_l (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) : br (c • X) Y = c • br X Y := by
  simp only [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem br_smul_r (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) : br X (c • Y) = c • br X Y := by
  simp only [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem br_zero_l (Y : Matrix (Fin n) (Fin n) ℝ) : br 0 Y = 0 := by simp [br]
theorem br_zero_r (X : Matrix (Fin n) (Fin n) ℝ) : br X 0 = 0 := by simp [br]

/-- **Bilinear closure**: if a bilinear-in-spans property holds on generators it holds on spans.
Stated for `br u w ∈ T` with `u` in the span of `S₁` and `w` in the span of `S₂`. -/
theorem br_mem_of_gen (S₁ S₂ : Set (Matrix (Fin n) (Fin n) ℝ))
    (T : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ))
    (hgen : ∀ x ∈ S₁, ∀ y ∈ S₂, br x y ∈ T) :
    ∀ u ∈ Submodule.span ℝ S₁, ∀ w ∈ Submodule.span ℝ S₂, br u w ∈ T := by
  intro u hu w hw
  induction hu using Submodule.span_induction with
  | mem x hx =>
      induction hw using Submodule.span_induction with
      | mem y hy => exact hgen x hx y hy
      | zero => rw [br_zero_r]; exact T.zero_mem
      | add y z _ _ hy hz => rw [br_add_r]; exact T.add_mem hy hz
      | smul c y _ hy => rw [br_smul_r]; exact T.smul_mem c hy
  | zero => rw [br_zero_l]; exact T.zero_mem
  | add x y _ _ hx hy => rw [br_add_l]; exact T.add_mem hx hy
  | smul c x _ hx => rw [br_smul_l]; exact T.smul_mem c hx

/-- **L71 from frame-level inclusions.** For a complete orthonormal frame of `𝔰𝔬(n)` and the three
componentwise inclusions of L70's equality case, `L71`'s conclusions hold for the eigenframe spans. -/
theorem sat_of_frame {Γ : Type*} [Fintype Γ] (hn : 5 ≤ n) (v : Γ → Matrix (Fin n) (Fin n) ℝ)
    (ev : Γ → ℝ) (lmin lmax : ℝ)
    (hsk : ∀ k, IsSkew (v k)) (hon : ∀ k, inner2 (v k) (v k) = 1)
    (hcomp : ∀ X, IsSkew X → X = ∑ k, inner2 X (v k) • v k)
    (h_mm : ∀ γ a b, ev γ = lmin → ev a = lmin → inner2 (br (v γ) (v a)) (v b) ≠ 0 → ev b = lmax)
    (h_mh : ∀ γ a b, ev γ = lmin → ev a = lmax → inner2 (br (v γ) (v a)) (v b) ≠ 0 → ev b = lmin)
    (h_mr : ∀ γ a, ev γ = lmin → ev a ≠ lmin → ev a ≠ lmax → br (v γ) (v a) = 0)
    (hex : ∃ γ, ev γ = lmin) :
    spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) = ⊥ ∧
      spanOf v (fun k => ev k = lmax) = L71Statement.brackets (spanOf v (fun k => ev k = lmin)) ∧
      (∀ x ∈ spanOf v (fun k => ev k = lmax), ∀ y ∈ spanOf v (fun k => ev k = lmax),
        L71Statement.br x y ∈ spanOf v (fun k => ev k = lmax)) := by
  set m := spanOf v (fun k => ev k = lmin) with hm
  set h := spanOf v (fun k => ev k = lmax) with hh
  set r := spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) with hr
  -- a bracket of frame vectors is its own frame expansion
  have hexp : ∀ γ a, br (v γ) (v a) = ∑ b, inner2 (br (v γ) (v a)) (v b) • v b := fun γ a =>
    hcomp _ (br_skew (hsk γ) (hsk a))
  -- a frame sum whose nonzero terms all carry a given label lies in that label's span
  have hsum : ∀ (c : Γ → ℝ) (p : Γ → Prop), (∀ b, c b ≠ 0 → p b) →
      ∑ b, c b • v b ∈ spanOf v p := by
    intro c p hp
    refine Submodule.sum_mem _ fun b _ => ?_
    by_cases hc : c b = 0
    · rw [hc, zero_smul]; exact Submodule.zero_mem _
    · exact Submodule.smul_mem _ _ (mem_spanOf v p (hp b hc))
  have hmm : ∀ u ∈ m, ∀ w ∈ m, L71Statement.br u w ∈ h := by
    refine br_mem_of_gen _ _ h ?_
    rintro _ ⟨γ, hγ, rfl⟩ _ ⟨a, ha, rfl⟩
    rw [hexp γ a]
    exact hsum _ _ fun b hb => h_mm γ a b hγ ha hb
  have hmh : ∀ u ∈ m, ∀ x ∈ h, L71Statement.br u x ∈ m := by
    refine br_mem_of_gen _ _ m ?_
    rintro _ ⟨γ, hγ, rfl⟩ _ ⟨a, ha, rfl⟩
    rw [hexp γ a]
    exact hsum _ _ fun b hb => h_mh γ a b hγ ha hb
  have hmr : ∀ u ∈ m, ∀ z ∈ r, L71Statement.br u z = 0 := by
    have := br_mem_of_gen (v '' {k | ev k = lmin}) (v '' {k | ev k ≠ lmin ∧ ev k ≠ lmax}) ⊥ ?_
    · intro u hu z hz
      exact (Submodule.mem_bot ℝ).mp (this u hu z hz)
    · rintro _ ⟨γ, hγ, rfl⟩ _ ⟨a, ⟨ha1, ha2⟩, rfl⟩
      rw [h_mr γ a hγ ha1 ha2]
      exact Submodule.zero_mem _
  have hspan : ∀ A : Matrix (Fin n) (Fin n) ℝ, L71Statement.Skew A → A ∈ m ⊔ h ⊔ r := by
    intro A hA
    rw [hcomp A hA]
    refine Submodule.sum_mem _ fun k _ => ?_
    by_cases h1 : ev k = lmin
    · exact Submodule.mem_sup_left (Submodule.mem_sup_left
        (Submodule.smul_mem _ _ (mem_spanOf v _ h1)))
    · by_cases h2 : ev k = lmax
      · exact Submodule.mem_sup_left (Submodule.mem_sup_right
          (Submodule.smul_mem _ _ (mem_spanOf v _ h2)))
      · exact Submodule.mem_sup_right (Submodule.smul_mem _ _ (mem_spanOf v
          (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) ⟨h1, h2⟩))
  have hm0 : m ≠ ⊥ := by
    obtain ⟨γ, hγ⟩ := hex
    intro hbot
    have hmem : v γ ∈ m := mem_spanOf v _ hγ
    rw [hbot, Submodule.mem_bot] at hmem
    have := hon γ
    rw [hmem] at this
    simp [inner2] at this
  exact L71Statement.L71 hn m h r (skew_of_spanOf v _ hsk) (skew_of_spanOf v _ hsk)
    (skew_of_spanOf v _ hsk) hspan hmm hmh hmr hm0

open HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind in
/-- **L71 at a saturating critical point.** For a critical linear Weyl operator `W` on `Λ²ℝⁿ`,
`n ≥ 5`, with `λ_min < 0 < λ_max` bracketing its spectrum, `λ_min` attained, and L70's bound an
equality, the spectral eigenframe's spans `𝔪 = E_min`, `𝔥 = E_max`, `𝔯` (the rest) have `𝔯 = 0`,
`𝔥 = [𝔪, 𝔪]` and `[𝔥, 𝔥] ⊆ 𝔥`: `(𝔰𝔬(n), 𝔥)` is a symmetric pair. -/
theorem L71_saturated (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin) :
    let v := frameVec W hW.1 hW.2.1 hW.2.2.1
    let ev := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
    spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) = ⊥ ∧
      spanOf v (fun k => ev k = lmax) = L71Statement.brackets (spanOf v (fun k => ev k = lmin)) ∧
      (∀ x ∈ spanOf v (fun k => ev k = lmax), ∀ y ∈ spanOf v (fun k => ev k = lmax),
        L71Statement.br x y ∈ spanOf v (fun k => ev k = lmax)) := by
  intro v ev
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  refine sat_of_frame hn v ev lmin lmax hf.skew (fun k => by simpa using hf.orthonormal k k)
    hf.complete ?_ ?_ ?_ hex
  · exact fun γ a b hγ ha hb =>
      L71_mm W hW θ hc lmin lmax hneg hpos hlo hhi hsat γ a b hγ ha hb
  · exact fun γ a b hγ ha hb =>
      L71_mh W hW θ hc lmin lmax hneg hpos hlo hhi hsat γ a b hγ ha hb
  · exact fun γ a hγ ha1 ha2 =>
      L71_mr W hW θ hc lmin lmax hneg hpos hlo hhi hsat γ a hγ ha1 ha2

end HamiltonsCubic.L71Sat
