import HamiltonsCubic.Results.L70Dims

set_option linter.style.longLine false

/-!
# L70's saturation on L23's family is a symmetric pair

[findings/bounds.md](../../../findings/bounds.md), Lemma L70: *on Lemma L23's two-eigenvalue family `W = Π_𝔥 − (r/N) I`,
`E_max = 𝔥`, `E_min = 𝔪 = 𝔥^⊥` and `v ∈ 𝔪`. The both-indices-in-`𝔥` mass is `⟨v, [𝔥, 𝔥]⟩ = 0` automatically, since
`𝔥` is a subalgebra and `𝔪 ⊥ 𝔥`. The only surviving obstruction is the `𝔪 × 𝔪` mass, so saturation
`⟺ [𝔪, 𝔪] ⊥ 𝔪`.*

In an orthonormal eigenframe `v` with `𝔥` spanned by the frame vectors `v_a`, `a ∈ H`:

- `cst_cyclic`: `⟨[v_x, v_a], v_b⟩ = ⟨[v_a, v_b], v_x⟩`;
- `cst_closed_of_span`: `𝔥` closed under the bracket makes `⟨[v_a, v_b], v_c⟩ = 0` at `a, b ∈ H`, `c ∉ H`;
- `hh_mass_zero`: **the `𝔥 × 𝔥` mass at `v_{γ₀} ∈ 𝔪` vanishes**;
- `L70_support_iff_mm`: **at a two-valued spectrum with `E_max = 𝔥`, the frame support condition of `saturation_dims`
  and `support_of_saturation` at `v_{γ₀} ∈ 𝔪` holds iff `⟨[v_a, v_b], v_{γ₀}⟩ = 0` for all `a, b ∈ 𝔪`**, and `L70_saturation_iff_symmetric`
  gives it at every `v_{γ₀} ∈ 𝔪` iff `[𝔪, 𝔪] ⊥ 𝔪`.
-/

namespace HamiltonsCubic.L41Statement.Frame

open HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {Γ : Type*} [Fintype Γ] [DecidableEq Γ]
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}

/-- `⟨[v_x, v_a], v_b⟩ = ⟨[v_a, v_b], v_x⟩`. -/
theorem cst_cyclic (hf : EigenFrame W v lam) (x a b : Γ) : cst v x a b = cst v a b x := by
  rw [cst_swap23 hf, cst_swap12 hf, cst_swap23 hf, cst_swap12 hf]; ring

/-- `X ↦ ⟨X, Y⟩` is linear. -/
noncomputable def innerL (Y : Matrix ι ι ℝ) : Matrix ι ι ℝ →ₗ[ℝ] ℝ where
  toFun X := inner2 X Y
  map_add' A B := by unfold inner2; rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring
  map_smul' c A := by
    unfold inner2; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul]; simp; ring

omit [DecidableEq ι] in
/-- **`𝔥` closed under the bracket**, `[v_a, v_b] ∈ span{v_c : c ∈ H}` at `a, b ∈ H`, puts no mass off `𝔥`. -/
theorem cst_closed_of_span (hf : EigenFrame W v lam) (H : Set Γ)
    (hclosed : ∀ a b, a ∈ H → b ∈ H → br (v a) (v b) ∈ Submodule.span ℝ (v '' H))
    (a b c : Γ) (ha : a ∈ H) (hb : b ∈ H) (hc : c ∉ H) : cst v a b c = 0 := by
  have hle : Submodule.span ℝ (v '' H) ≤ LinearMap.ker (innerL (v c)) := by
    rw [Submodule.span_le]
    rintro _ ⟨d, hd, rfl⟩
    show inner2 (v d) (v c) = 0
    rw [hf.orthonormal, if_neg (fun (h : d = c) => hc (h ▸ hd))]
  exact hle (hclosed a b ha hb)

/-- **The `𝔥 × 𝔥` mass at `v_{γ₀} ∈ 𝔪` vanishes.** -/
theorem hh_mass_zero (hf : EigenFrame W v lam) (H : Set Γ)
    (hclosed : ∀ a b c, a ∈ H → b ∈ H → c ∉ H → cst v a b c = 0)
    (γ₀ a b : Γ) (hg : γ₀ ∉ H) (ha : a ∈ H) (hb : b ∈ H) : cst v γ₀ a b = 0 := by
  rw [cst_cyclic hf]; exact hclosed a b γ₀ ha hb hg

/-- **L70's support condition at `v_{γ₀} ∈ 𝔪` is `[𝔪, 𝔪] ⊥ v_{γ₀}`**, at a two-valued spectrum
`λ = λ_max` on `H` and `λ_min` off it. -/
theorem L70_support_iff_mm (hf : EigenFrame W v lam) (H : Set Γ) [DecidablePred (· ∈ H)]
    (hclosed : ∀ a b c, a ∈ H → b ∈ H → c ∉ H → cst v a b c = 0)
    (lmin lmax : ℝ) (hne : lmin ≠ lmax) (hlam : ∀ a, lam a = if a ∈ H then lmax else lmin)
    (γ₀ : Γ) (hg : γ₀ ∉ H) :
    (∀ a b, cst v γ₀ a b ≠ 0 → (lam a = lmin ∧ lam b = lmax) ∨ (lam a = lmax ∧ lam b = lmin)) ↔
      ∀ a b, a ∉ H → b ∉ H → cst v a b γ₀ = 0 := by
  constructor
  · intro hs a b ha hb
    rw [← cst_cyclic hf]
    by_contra h0
    have hla : lam a = lmin := by rw [hlam, if_neg ha]
    have hlb : lam b = lmin := by rw [hlam, if_neg hb]
    rcases hs a b h0 with ⟨_, h⟩ | ⟨h, _⟩
    · exact hne (hlb ▸ h)
    · exact hne (hla ▸ h)
  · intro hmm a b h0
    by_cases ha : a ∈ H <;> by_cases hb : b ∈ H
    · exact absurd (hh_mass_zero hf H hclosed γ₀ a b hg ha hb) h0
    · right; rw [hlam, hlam, if_pos ha, if_neg hb]; exact ⟨rfl, rfl⟩
    · left; rw [hlam, hlam, if_neg ha, if_pos hb]; exact ⟨rfl, rfl⟩
    · exact absurd (by rw [cst_cyclic hf]; exact hmm a b ha hb) h0

/-- **Saturation at every `v_{γ₀} ∈ 𝔪` iff `[𝔪, 𝔪] ⊥ 𝔪`**, the symmetric-pair condition. -/
theorem L70_saturation_iff_symmetric (hf : EigenFrame W v lam) (H : Set Γ) [DecidablePred (· ∈ H)]
    (hclosed : ∀ a b, a ∈ H → b ∈ H → br (v a) (v b) ∈ Submodule.span ℝ (v '' H))
    (lmin lmax : ℝ) (hne : lmin ≠ lmax) (hlam : ∀ a, lam a = if a ∈ H then lmax else lmin) :
    (∀ γ₀, γ₀ ∉ H → ∀ a b, cst v γ₀ a b ≠ 0 →
        (lam a = lmin ∧ lam b = lmax) ∨ (lam a = lmax ∧ lam b = lmin)) ↔
      ∀ a b c, a ∉ H → b ∉ H → c ∉ H → cst v a b c = 0 := by
  have hc := cst_closed_of_span hf H hclosed
  constructor
  · intro hs a b c ha hb hcH
    exact (L70_support_iff_mm hf H hc lmin lmax hne hlam c hcH).mp (hs c hcH) a b ha hb
  · intro hmm γ₀ hg
    exact (L70_support_iff_mm hf H hc lmin lmax hne hlam γ₀ hg).mpr fun a b ha hb => hmm a b γ₀ ha hb hg

end HamiltonsCubic.L41Statement.Frame
