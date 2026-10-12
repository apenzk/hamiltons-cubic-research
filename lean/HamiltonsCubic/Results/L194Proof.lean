import HamiltonsCubic.Results.L183Statement
import HamiltonsCubic.Results.CollinearSphere
import HamiltonsCubic.Results.PhiSphereN

set_option linter.style.longLine false

/-!
# L194: the distinct branch of L183 is empty

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L194: *"Let `W = ∑ λ_i ω_i ⊗ ω_i ∈ 𝒲_n` with the `ω_i`
orthonormal and every `λ_i ≠ 0`. Then `Φ(ω₁) = Φ(ω₂) = Φ(ω₃)`."* The assembly of three proved pieces:
[L183Statement.lean](L183Statement.lean)'s `collinear_of_weyl` (coincident or distinct-and-collinear),
[PhiSphereN.lean](PhiSphereN.lean)'s `phi_sphere` (the images lie on a sphere), and
[CollinearSphere.lean](CollinearSphere.lean)'s `eq_of_collinear_of_norm_eq` (a line meets a sphere at most twice).

- `Idx`, **`emb`**, `emb_sub`, `emb_smul`, `emb_injective`: `Φ(ω) = (ω², ω ∧ ω)` as a vector of a Euclidean space, the
  `S²` block with the Frobenius norm and the `Λ⁴` block scaled by `1/√24`, which is the multi-index-orthonormal norm
  `‖·‖_⊥` of [conventions.md](../../../findings/conventions.md) on the alternating `ω ∧ ω`;
- **`norm_emb_Phi`**: `‖Φ(ω)‖² = tr(ω⁴) + ‖ω ∧ ω‖²_⊥ = 2⟨ω, ω⟩²` at every `n`;
- **`L194`**: the three images are equal.
-/

namespace HamiltonsCubic.L194Proof

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer

variable {n : ℕ}

/-- The index type of `S²(ℝⁿ) ⊕ Λ⁴ℝⁿ` with all indices kept. -/
abbrev Idx (n : ℕ) := (Fin n × Fin n) ⊕ (Fin n × Fin n × Fin n × Fin n)

/-- **`Φ` in a Euclidean space**: `ω²` with the Frobenius norm and `ω ∧ ω` scaled by `1/√24`, so the second block
carries the multi-index-orthonormal norm `‖·‖_⊥` of [conventions.md](../../../findings/conventions.md). -/
noncomputable def emb (P : Matrix (Fin n) (Fin n) ℝ × (Fin n → Fin n → Fin n → Fin n → ℝ)) : EuclideanSpace ℝ (Idx n) :=
  WithLp.toLp 2 (Sum.elim (fun p => P.1 p.1 p.2) (fun q => (1 / Real.sqrt 24) * P.2 q.1 q.2.1 q.2.2.1 q.2.2.2))

theorem emb_sub (P Q) : emb (n := n) (P - Q) = emb P - emb Q := by
  ext i; rcases i with p | q <;> simp [emb]; ring

theorem emb_smul (c : ℝ) (P) : emb (n := n) (c • P) = c • emb P := by
  ext i; rcases i with p | q <;> simp [emb]; ring

theorem emb_injective : Function.Injective (emb (n := n)) := by
  intro P Q h
  have h24 : Real.sqrt 24 ≠ 0 := by positivity
  refine Prod.ext (Matrix.ext fun a b => ?_) (funext fun a => funext fun b => funext fun c => funext fun d => ?_)
  · have := congrArg (fun v : EuclideanSpace ℝ (Idx n) => v (Sum.inl (a, b))) h; simpa [emb] using this
  · have := congrArg (fun v : EuclideanSpace ℝ (Idx n) => v (Sum.inr (a, b, c, d))) h
    simpa [emb, h24] using this

/-- **`‖Φ(ω)‖² = tr(ω⁴) + ‖ω ∧ ω‖²_⊥ = 2⟨ω, ω⟩²`** in the embedding, by [PhiSphereN.lean](PhiSphereN.lean). -/
theorem norm_emb_Phi {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsSkew w) :
    ‖emb (Phi w)‖ ^ 2 = 2 * inner2 w w ^ 2 := by
  rw [← phi_sphere w hw, EuclideanSpace.norm_sq_eq]
  simp only [Fintype.sum_sum_type, Fintype.sum_prod_type, emb, Phi, Real.norm_eq_abs, sq_abs, Sum.elim_inl,
    Sum.elim_inr]
  have hs := skew_entry hw
  have hsym : ∀ a b, (w * w) b a = (w * w) a b := fun a b => by
    simp only [Matrix.mul_apply]; refine Finset.sum_congr rfl fun c _ => ?_; rw [hs b c, hs c a]; ring
  have t1 : ∑ a, ∑ b, (w * w) a b ^ 2 = (w ^ 4).trace := by
    rw [show w ^ 4 = (w * w) * (w * w) by rw [pow_succ, pow_succ, pow_succ, pow_one, Matrix.mul_assoc,
      Matrix.mul_assoc]]
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply (M := w * w)]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [hsym b a, sq]
  have h24 : (1 / Real.sqrt 24) ^ 2 = 1 / 24 := by rw [div_pow, one_pow, Real.sq_sqrt (by norm_num)]
  have t2 : ∀ a b c d, (1 / Real.sqrt 24 * wedgeSelf w a b c d) ^ 2 = 1 / 6 * w4n w a b c d ^ 2 :=
    fun a b c d => by
      have : wedgeSelf w a b c d = 2 * w4n w a b c d := by
        simp only [wedgeSelf, wedge2, halfw, Pi.add_apply, w4n]; ring
      rw [this, mul_pow, h24]; ring
  simp only [t2, ← Finset.mul_sum]
  rw [t1]

/-- **L194: the distinct branch of L183 is empty**, so a rank-three Weyl tensor `W = ∑ λ_i ω_i ⊗ ω_i` with orthonormal
`ω_i` and every `λ_i ≠ 0` has its three images `Φ(ω_i)` equal. -/
theorem L194 (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin n) (Fin n) ℝ) (hskew : ∀ i, (om i)ᵀ = -om i)
    (hon : ∀ i i', inner2 (om i) (om i') = if i = i' then 1 else 0) (hlam : ∀ i, lam i ≠ 0)
    (hW : IsWeyl (HamiltonsCubic.L183.rankSumOp lam om)) :
    Phi (om 0) = Phi (om 1) ∧ Phi (om 1) = Phi (om 2) := by
  rcases HamiltonsCubic.L183.collinear_of_weyl lam om hskew hon hlam hW with h | ⟨h01, h12, h02, t, ht⟩
  · exact h
  · exfalso
    have hn : ∀ i, ‖emb (Phi (om i))‖ = Real.sqrt 2 := fun i => by
      have h1 : inner2 (om i) (om i) = 1 := by simpa using hon i i
      have h2 := norm_emb_Phi (w := om i) (hskew i)
      rw [h1] at h2
      rw [← Real.sqrt_sq (_root_.norm_nonneg _), h2]; norm_num
    have hcol : emb (Phi (om 0)) - emb (Phi (om 2)) = t • (emb (Phi (om 1)) - emb (Phi (om 2))) := by
      rw [← emb_sub, ← emb_sub, ← emb_smul, ht]
    rcases eq_of_collinear_of_norm_eq _ _ _ t hcol (by rw [hn, hn]) (by rw [hn, hn]) with h | h | h
    · exact h02 (emb_injective h)
    · exact h01 (emb_injective h)
    · exact h12 (emb_injective h)

end HamiltonsCubic.L194Proof
