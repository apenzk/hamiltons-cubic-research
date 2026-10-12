import HamiltonsCubic.Base.BivModel
import HamiltonsCubic.Results.DefectCP2

set_option linter.style.longLine false

/-!
# L17's derivative identity at the padded `ℂP²` competitor

Milestone 5c of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md), and with it the
identity that [L17Statement.lean](L17Statement.lean) carries as the hypothesis `hderiv`.

> $$d^+\delta^2(u;H)=-2a\,F(H),\qquad a=\tfrac1{3\sqrt6},$$
> [route-a.md](../../../findings/route-a.md), Lemma L17, with `F(H) = H₂₂ + H₃₃ + tr(Π_ASD (P₀HP₀)₋)`.

- `om6`, the self-dual `a, b, c` and anti-self-dual `a', b', c'` of `ℝ⁴`, with integer entries `om6Z`; `inner2_om6`
  (orthogonal, norm² `2`) and `cyclic_eq_star`, the integer identity `∑_{b,c} cyc(ω ⊗ ω) = ∑ s_δ ω_δ ⊗ ω_δ`, both by
  `decide`;
- `vec δ = ω_δ/√2` padded into `Λ²ℝⁿ`, orthonormal (`vec_orthonormal`), and `uOp = ∑ λ_δ vec_δ vec_δᵀ` with
  `λ = (2, −1, −1, 0, 0, 0)/√6`. **`defectSq_u_eq`** identifies it with the layer's `lamU`, `omU`, so
  `altNormSq_uNeg` is `δ²(u) = 1/9` from `defect_u`;
- **`pairing`**: `⟨Alt(u₋), Alt(X)⟩ = a ∑_δ s_δ ⟪vec_δ, X vec_δ⟫` for every operator `X`, `s = +1` on the self-dual
  and `−1` on the anti-self-dual bivectors, which is `Alt(u₋) = a⋆` read against `Alt(X)`;
- the three branches of `D` on eigenvectors of `u`: `inner_commutator_eigen` (the Daleckii–Krein term pairs to `0`),
  `inner_schur_eigen` (`Σ_{λ<0} P_λHP_λ` gives `[μ<0] ⟪w, H w⟫`) and `schur_zero_eigen` (`P₀HP₀` kills the self-dual
  eigenvectors);
- **`hasDerivWithinAt_defect_u`**: `d⁺δ²(u; H) = −2a (H₂₂ + H₃₃ + ∑_{ASD} ⟪ω, (P₀HP₀)₋ ω⟫)` for every symmetric `H` on
  `Λ²ℝⁿ`, `n ≥ 4`, with `H₂₂`, `H₃₃` the entries of `H` on `u`'s unit negative eigenvectors `b/√2`, `c/√2`.

*The identity holds for every symmetric `H`. Tangency and the first Bianchi identity are consumed by `F ≥ 0` in
[L17Close.lean](L17Close.lean), and criticality by `d⁺P(u; H) = 0` in [L17Phi.lean](L17Phi.lean).*
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.FamilyLayer
  HamiltonsCubic.FamilyLayer.CP2 HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel HamiltonsCubic.DefectCP2

variable {n : ℕ}

/-! ## The six bivectors of `ℝ⁴`, padded -/

/-- The self-dual `a, b, c` and the anti-self-dual `a', b', c'`. -/
noncomputable def om6 : Fin 6 → Matrix (Fin 4) (Fin 4) ℝ := ![bivA, bivB, bivC, bivA', bivB', bivC']

/-- The integer entries of `φᵢⱼ` on `Fin 4`. -/
def phiZ (i j a b : Fin 4) : ℤ := (if j = a ∧ i = b then 1 else 0) - (if i = a ∧ j = b then 1 else 0)

theorem phi_eq_cast (i j : Fin 4) : phi i j = fun a b => ((phiZ i j a b : ℤ) : ℝ) := by
  funext a b
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, phiZ]
  push_cast
  rfl

/-- The integer entries of the six bivectors. -/
def om6Z (γ : Fin 6) (a b : Fin 4) : ℤ :=
  match γ with
  | 0 => phiZ 0 1 a b + phiZ 2 3 a b
  | 1 => phiZ 0 2 a b + phiZ 3 1 a b
  | 2 => phiZ 0 3 a b + phiZ 1 2 a b
  | 3 => phiZ 0 1 a b + phiZ 3 2 a b
  | 4 => phiZ 0 2 a b + phiZ 1 3 a b
  | 5 => phiZ 0 3 a b + phiZ 2 1 a b

theorem om6_eq_cast (γ : Fin 6) : om6 γ = fun a b => ((om6Z γ a b : ℤ) : ℝ) := by
  funext a b
  fin_cases γ <;>
  simp only [om6, om6Z, bivA, bivB, bivC, bivA', bivB', bivC', phi_eq_cast, Int.cast_add] <;> rfl

theorem om6_skew (γ : Fin 6) : IsSkew (om6 γ) := by
  rw [om6_eq_cast]
  unfold IsSkew
  ext a b
  change ((om6Z γ b a : ℤ) : ℝ) = -((om6Z γ a b : ℤ) : ℝ)
  rw [← Int.cast_neg]
  congr 1
  revert γ a b
  decide

/-- **Orthogonality with norm² `2`**, computed on integer entries. -/
theorem inner2_om6 (γ δ : Fin 6) : inner2 (om6 γ) (om6 δ) = if γ = δ then 2 else 0 := by
  rw [inner2_eq_sum, om6_eq_cast, om6_eq_cast]
  have h : ∀ γ δ : Fin 6, (∑ a : Fin 4, ∑ b : Fin 4, om6Z γ a b * om6Z δ a b) = if γ = δ then 4 else 0 := by
    decide
  have := congrArg (fun z : ℤ => (z : ℝ)) (h γ δ)
  simp only [Int.cast_sum, Int.cast_mul] at this
  rw [this]
  split_ifs <;> norm_num

/-- **The integer identity behind `Alt(u₋) = a⋆`**: on `ℝ⁴`, the cyclic sum of `b ⊗ b + c ⊗ c` is
`∑_γ s_γ ω_γ ⊗ ω_γ` with `s = +1` on the self-dual and `−1` on the anti-self-dual bivectors. Both are `2ε`. -/
theorem cyclic_eq_star : ∀ i j k l : Fin 4,
    (om6Z 1 i j * om6Z 1 k l + om6Z 1 i k * om6Z 1 l j + om6Z 1 i l * om6Z 1 j k) +
      (om6Z 2 i j * om6Z 2 k l + om6Z 2 i k * om6Z 2 l j + om6Z 2 i l * om6Z 2 j k) =
    (om6Z 0 i j * om6Z 0 k l + om6Z 1 i j * om6Z 1 k l + om6Z 2 i j * om6Z 2 k l) -
      (om6Z 3 i j * om6Z 3 k l + om6Z 4 i j * om6Z 4 k l + om6Z 5 i j * om6Z 5 k l) := by
  decide

/-! ## Padding -/

theorem inner2_pad (hn : 4 ≤ n) (M N : Matrix (Fin 4) (Fin 4) ℝ) :
    inner2 (pad (n := n) M) (pad N) = inner2 M N := by
  rw [inner2_eq_sum, inner2_eq_sum]
  congr 1
  rw [sum_pad hn _ fun a ha => Finset.sum_eq_zero fun b _ => by rw [pad_zero _ a b (by omega), zero_mul]]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [sum_pad hn _ fun b hb => by rw [pad_zero _ _ b (by omega), zero_mul]]
  refine Finset.sum_congr rfl fun b _ => ?_
  simp [pad, a.isLt, b.isLt]

/-- **The unit bivectors `ω_γ/√2`, padded into `ℝⁿ`**, in the model `Biv n`. -/
noncomputable def vec (γ : Fin 6) : Biv n := (Real.sqrt 2)⁻¹ • coords (pad (om6 γ))

theorem pad_om6_skew (γ : Fin 6) : IsSkew (pad (n := n) (om6 γ)) := pad_skew _ (om6_skew γ)

theorem vec_orthonormal (hn : 4 ≤ n) : Orthonormal ℝ (vec (n := n)) := by
  rw [orthonormal_iff_ite]
  intro γ δ
  rw [vec, vec, real_inner_smul_left, real_inner_smul_right, inner_coords (pad_om6_skew γ) (pad_om6_skew δ),
    inner2_pad hn, inner2_om6]
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h0 : Real.sqrt 2 ≠ 0 := by positivity
  split_ifs
  · field_simp; rw [h2]
  · simp

/-! ## The coordinates are linear, and a quadratic form in `φ`-components -/

/-- `coords` as a linear map. -/
noncomputable def coordsL : Matrix (Fin n) (Fin n) ℝ →ₗ[ℝ] Biv n where
  toFun := coords
  map_add' X Y := by ext p; simp only [coords_apply, PiLp.add_apply, AltLayer.inner2_add_left]
  map_smul' c X := by ext p; simp only [coords_apply, PiLp.smul_apply, AltLayer.inner2_smul_left, smul_eq_mul, RingHom.id_apply]

theorem coordsL_apply (X : Matrix (Fin n) (Fin n) ℝ) : coordsL X = coords X := rfl

/-- **A skew matrix in `φ`-coordinates**: `coords Ω = −½ ∑ᵢⱼ Ωᵢⱼ coords φᵢⱼ`. -/
theorem coords_expand {Ω : Matrix (Fin n) (Fin n) ℝ} (hΩ : IsSkew Ω) :
    coords Ω = ∑ i, ∑ j, (-(1 / 2) * Ω i j) • coords (phi i j) := by
  conv_lhs => rw [← skew_expand Ω hΩ]
  rw [← coordsL_apply, map_smul, map_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [map_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [map_smul, smul_smul, inner2_phi _ hΩ, coordsL_apply]
  congr 1; ring

/-- **`⟪coords Ω, X coords Ω⟫ = ¼ ∑ Ωᵢⱼ Ω_kl ⟪φ_kl, X φᵢⱼ⟫`.** -/
theorem inner_coords_apply {Ω : Matrix (Fin n) (Fin n) ℝ} (hΩ : IsSkew Ω) (X : Biv n →ₗ[ℝ] Biv n) :
    inner ℝ (coords Ω) (X (coords Ω)) =
      (1 / 4) * ∑ i, ∑ j, ∑ k, ∑ l, Ω i j * Ω k l * compOf X i j k l := by
  rw [coords_expand hΩ]
  simp only [map_sum, map_smul, sum_inner, inner_sum, real_inner_smul_left, real_inner_smul_right, compOf,
    Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  ring

/-! ## The competitor and its negative part -/

/-- `(√2)⁻¹ · (√2)⁻¹ = ½`. -/
theorem inv_sqrt_two_sq : (Real.sqrt 2)⁻¹ * (Real.sqrt 2)⁻¹ = 1 / 2 := by
  rw [← mul_inv, Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2), one_div]

/-- **`⟪φ_kl, X φᵢⱼ⟫` of a rank sum over the padded bivectors.** -/
theorem compOf_rankSum_vec (μ : Fin 6 → ℝ) (i j k l : Fin n) :
    compOf (rankSum μ (vec (n := n))) i j k l =
      ∑ δ, μ δ * (1 / 2) * (pad (om6 δ) i j * pad (om6 δ) k l) := by
  unfold compOf
  rw [rankSum_apply, inner_sum]
  refine Finset.sum_congr rfl fun δ _ => ?_
  rw [real_inner_smul_right, vec, real_inner_smul_left, real_inner_smul_right,
    inner_coords (pad_om6_skew δ) (phi_isSkew i j), real_inner_comm,
    inner_coords (pad_om6_skew δ) (phi_isSkew k l), inner2_phi _ (pad_om6_skew δ),
    inner2_phi _ (pad_om6_skew δ)]
  have h := inv_sqrt_two_sq
  linear_combination (μ δ * pad (om6 δ) i j * pad (om6 δ) k l) * h

/-- The competitor's coefficients on the unit bivectors: `(2, −1, −1)/√6` on the self-dual ones, `0` on the rest. -/
noncomputable def lam6 : Fin 6 → ℝ := ![2 / Real.sqrt 6, -1 / Real.sqrt 6, -1 / Real.sqrt 6, 0, 0, 0]

/-- The negative parts of those coefficients. -/
noncomputable def lamNeg : Fin 6 → ℝ := ![0, 1 / Real.sqrt 6, 1 / Real.sqrt 6, 0, 0, 0]

theorem negPart_lam6 (γ : Fin 6) : negPartScalar (lam6 γ) = lamNeg γ := by
  have h6 : 0 < Real.sqrt 6 := by positivity
  fin_cases γ <;> simp only [lam6, lamNeg, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val]
  · exact negPartScalar_of_nonneg (by positivity)
  · rw [negPartScalar_of_nonpos (by rw [neg_div]; exact neg_nonpos.mpr (by positivity))]; ring
  · rw [negPartScalar_of_nonpos (by rw [neg_div]; exact neg_nonpos.mpr (by positivity))]; ring
  all_goals exact negPartScalar_of_nonneg le_rfl

/-- The signs of `⋆`: `+1` on the self-dual bivectors, `−1` on the anti-self-dual ones. -/
def s6 : Fin 6 → ℝ := ![1, 1, 1, -1, -1, -1]

/-- **`Alt(u₋) = a ⋆` pointwise**, with `a⋆ = (1/(6√6)) ∑ s_δ ω_δ ⊗ ω_δ` in the padded unnormalised bivectors. -/
theorem alt4_uNeg (i j k l : Fin n) :
    alt4 (compOf (rankSum lamNeg (vec (n := n)))) i j k l =
      1 / (6 * Real.sqrt 6) * ∑ δ, s6 δ * (pad (om6 δ) i j * pad (om6 δ) k l) := by
  unfold alt4
  simp only [compOf_rankSum_vec, Fin.sum_univ_six, lamNeg, s6, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val]
  by_cases hb : i.val < 4 ∧ j.val < 4 ∧ k.val < 4 ∧ l.val < 4
  · obtain ⟨hi, hj, hk, hl⟩ := hb
    have e : ∀ (δ : Fin 6) (a b : Fin n) (ha : a.val < 4) (hb : b.val < 4),
        pad (n := n) (om6 δ) a b = ((om6Z δ ⟨a.val, ha⟩ ⟨b.val, hb⟩ : ℤ) : ℝ) := fun δ a b ha hb => by
      rw [pad_apply _ _ _ ⟨ha, hb⟩, om6_eq_cast]
    simp only [e _ _ _ hi hj, e _ _ _ hi hk, e _ _ _ hi hl, e _ _ _ hj hk, e _ _ _ hk hl, e _ _ _ hl hj]
    have hc := congrArg (fun z : ℤ => (z : ℝ)) (cyclic_eq_star ⟨i.val, hi⟩ ⟨j.val, hj⟩ ⟨k.val, hk⟩ ⟨l.val, hl⟩)
    push_cast at hc
    have h6 : Real.sqrt 6 ≠ 0 := by positivity
    field_simp
    linear_combination (6 : ℝ) * hc
  · have z : ∀ (δ : Fin 6) (a b : Fin n), ¬(a.val < 4 ∧ b.val < 4) → pad (n := n) (om6 δ) a b = 0 :=
      fun δ a b h => pad_zero _ a b h
    rcases not_and_or.mp hb with hi | hb'
    · simp [z _ i _ (fun h => hi h.1)]
    rcases not_and_or.mp hb' with hj | hb''
    · simp [z _ i j (fun h => hj h.2), z _ l j (fun h => hj h.2), z _ j k (fun h => hj h.1)]
    rcases not_and_or.mp hb'' with hk | hl
    · simp [z _ k l (fun h => hk h.1), z _ i k (fun h => hk h.2), z _ j k (fun h => hk h.2)]
    · simp [z _ k l (fun h => hl h.2), z _ l j (fun h => hl h.1), z _ i l (fun h => hl h.2)]

/-- Bringing an innermost sum to the front of a four-fold sum. -/
theorem sum4_comm_inner {κ : Type*} [Fintype κ] (f : κ → Fin n → Fin n → Fin n → Fin n → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, ∑ δ, f δ i j k l = ∑ δ, ∑ i, ∑ j, ∑ k, ∑ l, f δ i j k l := by
  calc ∑ i, ∑ j, ∑ k, ∑ l, ∑ δ, f δ i j k l = ∑ i, ∑ j, ∑ k, ∑ δ, ∑ l, f δ i j k l :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
          Finset.sum_comm
    _ = ∑ i, ∑ j, ∑ δ, ∑ k, ∑ l, f δ i j k l :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_comm
    _ = ∑ i, ∑ δ, ∑ j, ∑ k, ∑ l, f δ i j k l := Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ δ, ∑ i, ∑ j, ∑ k, ∑ l, f δ i j k l := Finset.sum_comm

theorem inner_vec_apply (δ : Fin 6) (X : Biv n →ₗ[ℝ] Biv n) :
    inner ℝ (vec (n := n) δ) (X (vec δ)) = (1 / 2) * inner ℝ (coords (pad (n := n) (om6 δ))) (X (coords (pad (om6 δ)))) := by
  rw [vec, map_smul, real_inner_smul_left, real_inner_smul_right, ← mul_assoc, inv_sqrt_two_sq]

/-- **`⟨Alt(u₋), Alt(X)⟩ = a · tr(⋆X)`** for every operator `X` on `Λ²ℝⁿ`, with `a = 1/(3√6)` and
`tr(⋆X) = ∑_δ s_δ ⟪v_δ, X v_δ⟫` over the unit self-dual (`s = +1`) and anti-self-dual (`s = −1`) bivectors. -/
theorem pairing (X : Biv n →ₗ[ℝ] Biv n) :
    fourInner (alt4 (compOf (rankSum lamNeg (vec (n := n))))) (alt4 (compOf X)) =
      1 / (3 * Real.sqrt 6) * ∑ δ, s6 δ * inner ℝ (vec δ) (X (vec δ)) := by
  rw [← alt4_selfAdjoint (alt4 _) _, alt4_idem]
  unfold fourInner
  simp_rw [alt4_uNeg, inner_vec_apply, inner_coords_apply (pad_om6_skew _)]
  simp only [Finset.mul_sum, Finset.sum_mul]
  rw [sum4_comm_inner]
  refine Finset.sum_congr rfl fun δ _ => Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  have h6 : Real.sqrt 6 ≠ 0 := by positivity
  field_simp
  ring

/-! ## The three branches of `D` on eigenvectors of `u` -/

section Branches
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {N : ℕ} (hN : finrank ℝ E = N) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

omit [FiniteDimensional ℝ E] in
/-- **The rotation term pairs to zero**: `⟪w, (K G − G K) w⟫ = 0` whenever `G` is symmetric and `G w = c w`. -/
theorem inner_commutator_eigen (K G : E →ₗ[ℝ] E) (hG : G.IsSymmetric) {w : E} {c : ℝ} (hw : G w = c • w) :
    inner ℝ w ((K ∘ₗ G - G ∘ₗ K) w) = 0 := by
  rw [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.comp_apply, inner_sub_right, hw, map_smul,
    real_inner_smul_right, ← hG, hw, real_inner_smul_left, sub_self]

/-- An eigenvector's coordinates vanish off its eigenvalue. -/
theorem coord_eigen {w : E} {μ : ℝ} (hw : u w = μ • w) (i : Fin N) :
    inner ℝ (hu.eigenvectorBasis hN i) w = 0 ∨ hu.eigenvalues hN i = μ := by
  have h1 : inner ℝ (u (hu.eigenvectorBasis hN i)) w = inner ℝ (hu.eigenvectorBasis hN i) (u w) := hu _ w
  rw [apply_eigvec hN hu, hw, real_inner_smul_left, real_inner_smul_right] at h1
  by_cases h0 : inner ℝ (hu.eigenvectorBasis hN i) w = 0
  · exact Or.inl h0
  · exact Or.inr (mul_right_cancel₀ h0 h1)

/-- **A Schur multiplier on an eigenvector**: `⟪w, schur φ H w⟫ = φ(μ, μ) ⟪w, H w⟫` when `u w = μ w`. -/
theorem inner_schur_eigen (φ : ℝ → ℝ → ℝ) (H : E →ₗ[ℝ] E) {w : E} {μ : ℝ} (hw : u w = μ • w) :
    inner ℝ w (schur hN hu φ H w) = φ μ μ * inner ℝ w (H w) := by
  set e := hu.eigenvectorBasis hN
  have hexp : ∀ X : E →ₗ[ℝ] E, inner ℝ w (X w) =
      ∑ i, ∑ j, inner ℝ (e i) w * inner ℝ (e j) w * inner ℝ (e i) (X (e j)) := fun X => by
    conv_lhs => rw [← e.sum_repr' w]
    simp only [map_sum, map_smul, inner_sum, sum_inner, real_inner_smul_left, real_inner_smul_right]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  rw [hexp, hexp H, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [entry_schur]
  rcases coord_eigen hN hu hw i with hi | hi
  · rw [hi]; ring
  rcases coord_eigen hN hu hw j with hj | hj
  · rw [hj]; ring
  · rw [hi, hj]; ring

/-- **The kernel branch vanishes off the kernel**: `(P₀HP₀) w = 0` when `u w = μ w` with `μ ≠ 0`. -/
theorem schur_zero_eigen (H : E →ₗ[ℝ] E) {w : E} {μ : ℝ} (hw : u w = μ • w) (hμ : μ ≠ 0) :
    schur hN hu zeroφ H w = 0 := by
  refine InnerProductSpace.ext_inner_left_basis (hu.eigenvectorBasis hN).toBasis fun i => ?_
  rw [OrthonormalBasis.coe_toBasis, inner_zero_right]
  conv_lhs => rw [← (hu.eigenvectorBasis hN).sum_repr' w]
  simp only [map_sum, map_smul, inner_sum, real_inner_smul_right]
  refine Finset.sum_eq_zero fun j _ => ?_
  rw [entry_schur]
  rcases coord_eigen hN hu hw j with hj | hj
  · rw [hj, zero_mul]
  · rw [hj]; unfold zeroφ; rw [if_neg (fun h => hμ h.2)]; ring

end Branches

/-! ## L17's derivative identity -/

section Main
variable {N : ℕ} (hN : finrank ℝ (Biv n) = N)

/-- **The padded competitor `u`**, with spectrum `(2, −1, −1)/√6` on the self-dual bivectors and `0` on the rest. -/
noncomputable def uOp : Biv n →ₗ[ℝ] Biv n := rankSum lam6 (vec (n := n))

theorem uOp_isSymmetric : (uOp (n := n)).IsSymmetric := rankSum_isSymmetric _ _

omit hN in
theorem rankSum_vec (hn : 4 ≤ n) (μ : Fin 6 → ℝ) (δ : Fin 6) :
    rankSum μ (vec (n := n)) (vec δ) = μ δ • vec δ := by
  rw [rankSum_apply]
  simp only [orthonormal_iff_ite.mp (vec_orthonormal hn), mul_ite, mul_one, mul_zero, ite_smul, zero_smul,
    Finset.sum_ite_eq', Finset.mem_univ, if_true]

/-- **`u₋ = (bbᵀ + ccᵀ)/√6`** in the unit bivectors. -/
theorem uNeg_eq (hn : 4 ≤ n) :
    specFn hN negPartScalar (uOp_isSymmetric (n := n)) = rankSum lamNeg (vec (n := n)) := by
  unfold uOp
  rw [specFn_rankSum hN negPartScalar (by simp [negPartScalar]) lam6 (vec_orthonormal hn)]
  congr 1
  exact funext negPart_lam6

theorem lam6_ne_zero {δ : Fin 6} (hδ : δ.val < 3) : lam6 δ ≠ 0 := by
  have h6 : 0 < Real.sqrt 6 := by positivity
  fin_cases δ <;> simp_all [lam6]

/-- **L17's derivative identity, `d⁺δ²(u; H) = −2a F(H)`**, at the padded `ℂP²` competitor `u` and every symmetric
`H` on `Λ²ℝⁿ`, `n ≥ 4`, with `a = 1/(3√6)` and
`F(H) = H₂₂ + H₃₃ + tr(Π_ASD (P₀HP₀)₋)`: `H₂₂`, `H₃₃` are `H` on the unit bivectors `b/√2`, `c/√2` spanning `u`'s
negative eigenspace, and the trace runs over the unit anti-self-dual bivectors. -/
theorem hasDerivWithinAt_defect_u (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric)
    (hW : ∀ t : ℝ, (uOp + t • H).IsSymmetric) :
    HasDerivWithinAt (fun t => altNormSqOf (specFn hN negPartScalar (hW t)))
      (-2 * (1 / (3 * Real.sqrt 6)) *
        (inner ℝ (vec 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
          ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
            inner ℝ (vec δ) (specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH) (vec δ))))
      (Set.Ici 0) 0 := by
  have h := hasDerivWithinAt_defect hN uOp_isSymmetric hH hW
  refine h.congr_deriv ?_
  rw [uNeg_eq hN hn, pairing]
  set P := specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH)
  have hG := rankSum_isSymmetric lamNeg (vec (n := n))
  have hDv : ∀ δ : Fin 6, inner ℝ (vec δ) ((rotGen hN uOp_isSymmetric H ∘ₗ rankSum lamNeg vec -
      rankSum lamNeg vec ∘ₗ rotGen hN uOp_isSymmetric H + (-schur hN uOp_isSymmetric negBlkφ H + P)) (vec δ)) =
      -(negBlkφ (lam6 δ) (lam6 δ) * inner ℝ (vec δ) (H (vec δ))) + inner ℝ (vec δ) (P (vec δ)) := fun δ => by
    rw [LinearMap.add_apply, inner_add_right,
      inner_commutator_eigen _ _ hG (rankSum_vec hn lamNeg δ), zero_add, LinearMap.add_apply, inner_add_right,
      LinearMap.neg_apply, inner_neg_right, inner_schur_eigen hN uOp_isSymmetric negBlkφ H (rankSum_vec hn lam6 δ)]
  have hPv : ∀ δ : Fin 6, δ.val < 3 → inner ℝ (vec δ) (P (vec δ)) = 0 := fun δ hδ => by
    have hz := schur_zero_eigen hN uOp_isSymmetric H (rankSum_vec hn lam6 δ) (lam6_ne_zero hδ)
    rw [specFn_apply_of_eigen hN negPartScalar _ (μ := 0) (by rw [hz, zero_smul])]
    simp [negPartScalar]
  simp only [Fin.sum_univ_six, s6, hDv]
  rw [hPv 0 (by decide), hPv 1 (by decide), hPv 2 (by decide)]
  have h6 : 0 < Real.sqrt 6 := by positivity
  have n0 : negBlkφ (lam6 0) (lam6 0) = 0 := by
    unfold negBlkφ; rw [if_neg]; simp only [lam6, Matrix.cons_val_zero, not_and, not_lt]; intro; positivity
  have n1 : negBlkφ (lam6 1) (lam6 1) = 1 := by
    unfold negBlkφ; rw [if_pos]; simp only [lam6, Matrix.cons_val_one, true_and]
    rw [neg_div]; exact neg_neg_of_pos (by positivity)
  have n2 : negBlkφ (lam6 2) (lam6 2) = 1 := by
    unfold negBlkφ; rw [if_pos]; simp only [lam6, Matrix.cons_val, true_and]
    rw [neg_div]; exact neg_neg_of_pos (by positivity)
  have nz : ∀ δ : Fin 6, 3 ≤ δ.val → negBlkφ (lam6 δ) (lam6 δ) = 0 := fun δ hδ => by
    unfold negBlkφ
    have : lam6 δ = 0 := by fin_cases δ <;> simp_all [lam6]
    rw [this]; simp
  rw [n0, n1, n2, nz 3 (by decide), nz 4 (by decide), nz 5 (by decide)]
  rw [Finset.sum_insert (by decide), Finset.sum_insert (by decide), Finset.sum_singleton]
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val]
  ring

/-- **This `u` is the layer's competitor**: the layer's `defectSq lamU omU`, which `defect_u` evaluates to `1/9`, is
`‖Alt(u₋)‖²` for `uOp`. -/
theorem defectSq_u_eq (hn : 4 ≤ n) :
    defectSq (ι := Fin n) lamU (omU (n := n)) = altNormSqOf (specFn hN negPartScalar (uOp_isSymmetric (n := n))) := by
  have hom : ∀ γ, IsSkew (omU (n := n) γ) := fun γ => pad_skew _ (omCP2_skew γ)
  have e : ∀ γ : Fin 3, omCP2 γ = om6 ⟨γ.val, by omega⟩ := by intro γ; fin_cases γ <;> rfl
  have horth : ∀ γ δ, inner2 (omU (n := n) γ) (omU δ) = if γ = δ then 2 else 0 := fun γ δ => by
    unfold omU
    rw [inner2_pad hn, e, e, inner2_om6]
    simp only [Fin.mk.injEq, Fin.val_inj]
  rw [defectSq_eq_of_orthogonal hN lamU hom (by norm_num) horth]
  have hvec : ∀ γ : Fin 3, (Real.sqrt 2)⁻¹ • coords (omU (n := n) γ) = vec ⟨γ.val, by omega⟩ := fun γ => by
    rw [vec, omU, e]
  have hop : rankSum (fun γ => 2 * lamU γ) (fun γ => (Real.sqrt 2)⁻¹ • coords (omU (n := n) γ)) = uOp := by
    refine LinearMap.ext fun x => ?_
    unfold uOp
    rw [rankSum_apply, rankSum_apply, Fin.sum_univ_three, Fin.sum_univ_six]
    simp only [hvec]
    have h6 : Real.sqrt 6 ≠ 0 := by positivity
    have l0 : 2 * lamU 0 = lam6 0 := by simp [lamU, lamCP2, lam6]; ring
    have l1 : 2 * lamU 1 = lam6 1 := by simp [lamU, lamCP2, lam6]; ring
    have l2 : 2 * lamU 2 = lam6 2 := by simp [lamU, lamCP2, lam6]; ring
    have l3 : lam6 3 = 0 := rfl
    have l4 : lam6 4 = 0 := rfl
    have l5 : lam6 5 = 0 := rfl
    rw [l0, l1, l2, l3, l4, l5]
    simp only [zero_mul, zero_smul, add_zero]
    rfl
  have key : ∀ (T : Biv n →ₗ[ℝ] Biv n) (hT : T.IsSymmetric), T = uOp →
      specFn hN negPartScalar hT = specFn hN negPartScalar (uOp_isSymmetric (n := n)) := by
    rintro T hT rfl; rfl
  rw [key _ _ hop]

/-- **`δ²(u) = 1/9`** in the operator form, from the layer's `defect_u`. -/
theorem altNormSq_uNeg (hn : 4 ≤ n) :
    altNormSqOf (specFn hN negPartScalar (uOp_isSymmetric (n := n))) = 1 / 9 := by
  rw [← defectSq_u_eq hN hn, defect_u hn]

end Main

end HamiltonsCubic.L17Deriv
