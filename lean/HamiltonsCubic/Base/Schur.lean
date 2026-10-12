import HamiltonsCubic.Base.SpectralFn

set_option linter.style.longLine false

/-!
# Schur multipliers in the eigenbasis of a symmetric operator

Part of milestone 3 of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md). Fix a
symmetric `u` with eigenbasis `eᵢ` and eigenvalues `λᵢ`. For `φ : ℝ → ℝ → ℝ` and an operator `H`, `schur hn hu φ H`
is the operator whose `(i, j)` entry is `φ(λᵢ, λⱼ) ⟪eᵢ, H eⱼ⟫`. Every operator the build needs is one of these:

- `H` itself is `φ = 1` (`schur_one`);
- the block-diagonal part `H_blk = ∑_λ P_λ H P_λ` is `φ(a, b) = [a = b]`;
- the rotation generator `K = ∑_{λ ≠ μ} P_λ H P_μ / (μ − λ)` is `φ(a, b) = [a ≠ b] / (b − a)`;
- the kernel compression `P₀ H P₀` is `φ(a, b) = [a = 0][b = 0]`, `zeroφ` in [BlockValue.lean](BlockValue.lean).

The rules are entrywise: `entry_schur` reads an entry, `ext_entries` compares operators by entries, and composition
with any `f(u)` multiplies `φ` by `f` of one argument (`schur_comp_specFn`, `specFn_comp_schur`). Hence
**`schur_commutator`**: `schur φ H ∘ u − u ∘ schur φ H = schur ((b − a) φ(a, b)) H`, which gives `[K, u] = H − H_blk`.
-/

namespace HamiltonsCubic.SpectralFn

open Module

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {n : ℕ} (hn : finrank ℝ E = n) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

/-- **The Schur multiplier**: the operator with entries `φ(λᵢ, λⱼ) ⟪eᵢ, H eⱼ⟫` in the eigenbasis of `u`. -/
noncomputable def schur (φ : ℝ → ℝ → ℝ) (H : E →ₗ[ℝ] E) : E →ₗ[ℝ] E :=
  ∑ i, ∑ j, (φ (hu.eigenvalues hn i) (hu.eigenvalues hn j) * inner ℝ (hu.eigenvectorBasis hn i) (H (hu.eigenvectorBasis hn j))) •
    (innerₛₗ ℝ (hu.eigenvectorBasis hn j)).smulRight (hu.eigenvectorBasis hn i)

/-- **Operators agree when their entries in an orthonormal basis agree.** -/
theorem ext_entries {X Y : E →ₗ[ℝ] E} (h : ∀ k l, inner ℝ (hu.eigenvectorBasis hn k) (X (hu.eigenvectorBasis hn l)) =
    inner ℝ (hu.eigenvectorBasis hn k) (Y (hu.eigenvectorBasis hn l))) : X = Y :=
  (hu.eigenvectorBasis hn).toBasis.ext fun l =>
    InnerProductSpace.ext_inner_left_basis (hu.eigenvectorBasis hn).toBasis fun k => by
      simpa only [OrthonormalBasis.coe_toBasis] using h k l

/-- **The entries of a Schur multiplier.** -/
theorem entry_schur (φ : ℝ → ℝ → ℝ) (H : E →ₗ[ℝ] E) (k l : Fin n) :
    inner ℝ (hu.eigenvectorBasis hn k) (schur hn hu φ H (hu.eigenvectorBasis hn l)) =
      φ (hu.eigenvalues hn k) (hu.eigenvalues hn l) * inner ℝ (hu.eigenvectorBasis hn k) (H (hu.eigenvectorBasis hn l)) := by
  have ho := (hu.eigenvectorBasis hn).orthonormal
  have hij : ∀ x y, inner ℝ (hu.eigenvectorBasis hn x) (hu.eigenvectorBasis hn y) = if x = y then 1 else 0 :=
    fun x y => orthonormal_iff_ite.mp ho x y
  simp only [schur, LinearMap.sum_apply, LinearMap.smul_apply, LinearMap.smulRight_apply, innerₛₗ_apply_apply,
    inner_sum, inner_smul_right, hij, mul_ite, mul_one, mul_zero]
  rw [Finset.sum_eq_single k (fun x _ hx => by simp [Ne.symm hx]) (by simp)]
  simp

/-- The entries of `f(u)`: `f(λ_l)` on the diagonal and `0` off it. -/
theorem entry_specFn (f : ℝ → ℝ) (k l : Fin n) :
    inner ℝ (hu.eigenvectorBasis hn k) (specFn hn f hu (hu.eigenvectorBasis hn l)) =
      if k = l then f (hu.eigenvalues hn l) else 0 := by
  rw [specFn_apply_of_eigen hn f hu (apply_eigvec hn hu l), real_inner_smul_right,
    orthonormal_iff_ite.mp (hu.eigenvectorBasis hn).orthonormal]
  split_ifs <;> simp

/-- **`schur 1 H = H`.** -/
theorem schur_one (H : E →ₗ[ℝ] E) : schur hn hu (fun _ _ => 1) H = H :=
  ext_entries hn hu fun k l => by rw [entry_schur, one_mul]

/-- **Composition with `f(u)` on the right multiplies `φ` by `f` of its second argument.** -/
theorem schur_comp_specFn (φ : ℝ → ℝ → ℝ) (f : ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    schur hn hu φ H ∘ₗ specFn hn f hu = schur hn hu (fun a b => φ a b * f b) H :=
  ext_entries hn hu fun k l => by
    rw [LinearMap.comp_apply, specFn_apply_of_eigen hn f hu (apply_eigvec hn hu l), map_smul, real_inner_smul_right,
      entry_schur, entry_schur]
    ring

/-- **Composition with `f(u)` on the left multiplies `φ` by `f` of its first argument.** -/
theorem specFn_comp_schur (φ : ℝ → ℝ → ℝ) (f : ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    specFn hn f hu ∘ₗ schur hn hu φ H = schur hn hu (fun a b => f a * φ a b) H :=
  ext_entries hn hu fun k l => by
    rw [LinearMap.comp_apply, ← specFn_isSymmetric hn f hu, specFn_apply_of_eigen hn f hu (apply_eigvec hn hu k),
      real_inner_smul_left, entry_schur, entry_schur]
    ring

/-- **A Schur multiplier is linear in `φ`**: sums. -/
theorem schur_add (φ ψ : ℝ → ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    schur hn hu φ H + schur hn hu ψ H = schur hn hu (fun a b => φ a b + ψ a b) H :=
  ext_entries hn hu fun k l => by
    rw [LinearMap.add_apply, inner_add_right, entry_schur, entry_schur, entry_schur]; ring

/-- **A Schur multiplier is linear in `φ`**: differences. -/
theorem schur_sub (φ ψ : ℝ → ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    schur hn hu φ H - schur hn hu ψ H = schur hn hu (fun a b => φ a b - ψ a b) H :=
  ext_entries hn hu fun k l => by
    rw [LinearMap.sub_apply, inner_sub_right, entry_schur, entry_schur, entry_schur]; ring

/-- **A Schur multiplier depends on `φ` only at pairs of eigenvalues.** -/
theorem schur_congr {φ ψ : ℝ → ℝ → ℝ} (H : E →ₗ[ℝ] E)
    (h : ∀ i j, φ (hu.eigenvalues hn i) (hu.eigenvalues hn j) = ψ (hu.eigenvalues hn i) (hu.eigenvalues hn j)) :
    schur hn hu φ H = schur hn hu ψ H :=
  ext_entries hn hu fun k l => by rw [entry_schur, entry_schur, h]

/-- **The commutator with `u`**: `schur φ H ∘ u − u ∘ schur φ H = schur ((b − a) φ(a, b)) H`. -/
theorem schur_commutator (φ : ℝ → ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    schur hn hu φ H ∘ₗ u - u ∘ₗ schur hn hu φ H = schur hn hu (fun a b => (b - a) * φ a b) H := by
  have h1 := schur_comp_specFn hn hu φ id H
  have h2 := specFn_comp_schur hn hu φ id H
  rw [specFn_id] at h1 h2
  rw [h1, h2, schur_sub]
  exact schur_congr hn hu H fun i j => by simp only [id]; ring

/-- **The commutator with `f(u)`**: `schur φ H ∘ f(u) − f(u) ∘ schur φ H = schur ((f(b) − f(a)) φ(a, b)) H`. -/
theorem schur_commutator_specFn (φ : ℝ → ℝ → ℝ) (f : ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    schur hn hu φ H ∘ₗ specFn hn f hu - specFn hn f hu ∘ₗ schur hn hu φ H =
      schur hn hu (fun a b => (f b - f a) * φ a b) H := by
  rw [schur_comp_specFn, specFn_comp_schur, schur_sub]
  exact schur_congr hn hu H fun i j => by ring

/-- **Symmetry**: `H` symmetric and `φ` symmetric give `schur φ H` symmetric. -/
theorem schur_isSymmetric {φ : ℝ → ℝ → ℝ} (hφ : ∀ a b, φ a b = φ b a) {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric) :
    (schur hn hu φ H).IsSymmetric := by
  set e := hu.eigenvectorBasis hn
  have hent : ∀ k l, inner ℝ (schur hn hu φ H (e k)) (e l) = inner ℝ (e k) (schur hn hu φ H (e l)) := fun k l => by
    rw [real_inner_comm, entry_schur, entry_schur, hφ, ← hH, real_inner_comm]
  intro x y
  rw [← e.sum_repr' x, ← e.sum_repr' y]
  simp only [map_sum, map_smul, sum_inner, inner_sum, real_inner_smul_left, real_inner_smul_right, hent]

/-- **Skewness**: `H` symmetric and `φ` antisymmetric give `⟪schur φ H x, y⟫ = −⟪x, schur φ H y⟫`. -/
theorem schur_isSkew {φ : ℝ → ℝ → ℝ} (hφ : ∀ a b, φ a b = -φ b a) {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric) (x y : E) :
    inner ℝ (schur hn hu φ H x) y = -inner ℝ x (schur hn hu φ H y) := by
  set e := hu.eigenvectorBasis hn
  have hent : ∀ k l, inner ℝ (schur hn hu φ H (e k)) (e l) = -inner ℝ (e k) (schur hn hu φ H (e l)) := fun k l => by
    rw [real_inner_comm, entry_schur, entry_schur, hφ, ← hH, real_inner_comm]; ring
  rw [← e.sum_repr' x, ← e.sum_repr' y]
  simp only [map_sum, map_smul, sum_inner, inner_sum, real_inner_smul_left, real_inner_smul_right, hent,
    ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring

/-! ## The block-diagonal part and the rotation generator -/

/-- `[a = b]`, the multiplier of the block-diagonal part. -/
noncomputable def blkφ (a b : ℝ) : ℝ := if a = b then 1 else 0

/-- `[a ≠ b] / (b − a)`, the multiplier of the rotation generator. -/
noncomputable def rotφ (a b : ℝ) : ℝ := if a = b then 0 else 1 / (b - a)

theorem blkφ_symm (a b : ℝ) : blkφ a b = blkφ b a := by
  unfold blkφ; by_cases h : a = b <;> simp [h, eq_comm]

theorem rotφ_antisymm (a b : ℝ) : rotφ a b = -rotφ b a := by
  unfold rotφ
  by_cases h : a = b
  · simp [h]
  · rw [if_neg h, if_neg (Ne.symm h), one_div, one_div, ← inv_neg, neg_sub]

/-- **`H_blk = ∑_λ P_λ H P_λ`**, the part of `H` that commutes with `u`. -/
noncomputable def blkPart (H : E →ₗ[ℝ] E) : E →ₗ[ℝ] E := schur hn hu blkφ H

/-- **`K = ∑_{λ ≠ μ} P_λ H P_μ / (μ − λ)`**, the generator of the rotation that block-diagonalises `u + tH` to
first order. -/
noncomputable def rotGen (H : E →ₗ[ℝ] E) : E →ₗ[ℝ] E := schur hn hu rotφ H

/-- **`[K, u] = H − H_blk`**: the rotation generator removes exactly the off-diagonal blocks. -/
theorem rotGen_commutator (H : E →ₗ[ℝ] E) :
    rotGen hn hu H ∘ₗ u - u ∘ₗ rotGen hn hu H = H - blkPart hn hu H := by
  unfold rotGen blkPart
  rw [schur_commutator]
  rw [show H - schur hn hu blkφ H = schur hn hu (fun _ _ => 1) H - schur hn hu blkφ H by rw [schur_one], schur_sub]
  exact schur_congr hn hu H fun i j => by
    unfold rotφ blkφ
    by_cases h : hu.eigenvalues hn i = hu.eigenvalues hn j
    · simp [h]
    · rw [if_neg h, if_neg h, one_div, mul_inv_cancel₀ (sub_ne_zero.mpr (Ne.symm h))]; ring

/-- **`[K, g(u)]` is the Daleckii–Krein off-diagonal part**, entries `(g(λⱼ) − g(λᵢ)) / (λⱼ − λᵢ) ⟪eᵢ, H eⱼ⟫` for
`λᵢ ≠ λⱼ` and `0` otherwise. -/
theorem rotGen_commutator_specFn (g : ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    rotGen hn hu H ∘ₗ specFn hn g hu - specFn hn g hu ∘ₗ rotGen hn hu H =
      schur hn hu (fun a b => (g b - g a) * rotφ a b) H :=
  schur_commutator_specFn hn hu rotφ g H

theorem blkPart_isSymmetric {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric) : (blkPart hn hu H).IsSymmetric :=
  schur_isSymmetric hn hu blkφ_symm hH

/-- **`K` is skew** for symmetric `H`. -/
theorem rotGen_isSkew {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric) (x y : E) :
    inner ℝ (rotGen hn hu H x) y = -inner ℝ x (rotGen hn hu H y) :=
  schur_isSkew hn hu rotφ_antisymm hH x y

/-- **`H_blk` commutes with every `f(u)`.** -/
theorem blkPart_comm_specFn (f : ℝ → ℝ) (H : E →ₗ[ℝ] E) :
    blkPart hn hu H ∘ₗ specFn hn f hu = specFn hn f hu ∘ₗ blkPart hn hu H := by
  unfold blkPart
  rw [schur_comp_specFn, specFn_comp_schur]
  exact schur_congr hn hu H fun i j => by
    unfold blkφ
    by_cases h : hu.eigenvalues hn i = hu.eigenvalues hn j
    · simp [h, mul_comm]
    · simp [h]

end HamiltonsCubic.SpectralFn
