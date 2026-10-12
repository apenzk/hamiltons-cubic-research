import HamiltonsCubic.Results.L17Cone

set_option linter.style.longLine false

/-!
# L17's dimension count: `codim {F = 0} ≤ 186` at `n = 12`

[route-a.md](../../../findings/route-a.md), Lemma L17: *"`codim {F = 0} ≤ 186` at `n = 12`, the count of the conditions
`Π_ASD H Π_ker u = 0`"*. [L17Cone.lean](L17Cone.lean)'s `F_eq_zero_iff` reads `F(H) = 0` as `P₀HP₀` vanishing on the three
anti-self-dual bivectors `ω_γ`. This file counts those conditions.

- `vecCoords`, `Kc`, `finrank_Kc`: the bivectors orthogonal to the six `vec i`, of dimension `N − 6`, `N = dim Λ²ℝⁿ`;
- `projL`, `projK`: `x ↦ x − ∑ ⟨vec i, x⟩ vec i`, onto that complement;
- **`condMap`**: `H ↦ ((projL (H ω_γ))_γ, (⟨ω_γ', H ω_γ⟩)_{γ' ≤ γ})`, linear, into a space of dimension
  `3 (N − 6) + 6 = 3N − 12` (`finrank_cod`). The six entries on the anti-self-dual block are the upper triangle, since
  symmetry of `H` supplies the other three (`asd_entries_zero`);
- **`condMap_eq_zero_iff`**: for symmetric `H`, `condMap H = 0` iff `P₀HP₀ ω_γ = 0` for every `γ`. The kernel of `u` is
  the anti-self-dual block plus the complement (`inner_vec_of_ker`, `uOp_of_Kc`);
- **`L17_codim`**: on any space `V` of admissible directions, `{F = 0} ∩ V` is the kernel of `condMap` on `V`, and
  `dim V ≤ dim ({F = 0} ∩ V) + (3N − 12)`;
- **`L17_codim_12`**: at `n = 12`, `N = 66` and the bound is `186`.

Equality in the count needs the `186` conditions independent on `𝒲₁₂ ∩ T_uS`, and `dim 𝒲₁₂ ∩ T_uS = 1637` is
[L17Statement.lean](L17Statement.lean)'s arithmetic. Neither is proved here.
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel

variable {n : ℕ}

/-- The coordinates of a bivector against the six vectors `vec`. -/
noncomputable def vecCoords : Biv n →ₗ[ℝ] (Fin 6 → ℝ) where
  toFun x i := inner ℝ (vec i) x
  map_add' x y := by funext i; simp [inner_add_right]
  map_smul' c x := by funext i; simp [real_inner_smul_right]

/-- **The complement of the six**: the bivectors orthogonal to every `vec i`. -/
noncomputable def Kc : Submodule ℝ (Biv n) := LinearMap.ker (vecCoords (n := n))

theorem mem_Kc {x : Biv n} : x ∈ (Kc (n := n)) ↔ ∀ i, inner ℝ (vec i) x = 0 := by
  simp only [Kc, LinearMap.mem_ker, funext_iff]; rfl

theorem finrank_Kc (hn : 4 ≤ n) : finrank ℝ (Kc (n := n)) + 6 = finrank ℝ (Biv n) := by
  have hs : Function.Surjective (vecCoords (n := n)) := fun c =>
    ⟨∑ j, c j • vec j, by
      funext i
      simp only [vecCoords, LinearMap.coe_mk, AddHom.coe_mk, inner_sum, real_inner_smul_right,
        orthonormal_iff_ite.mp (vec_orthonormal hn), mul_ite, mul_one, mul_zero, Finset.sum_ite_eq, Finset.mem_univ,
        if_true]⟩
  have h := LinearMap.finrank_range_add_finrank_ker (vecCoords (n := n))
  rw [LinearMap.range_eq_top.mpr hs, finrank_top, Module.finrank_fin_fun] at h
  rw [Kc]; omega

/-- The projection away from the six, `x − ∑ ⟨vec i, x⟩ vec i`. -/
noncomputable def projL : Biv n →ₗ[ℝ] Biv n := LinearMap.id - rankSum (fun _ => 1) (vec (n := n))

theorem projL_apply (x : Biv n) : projL x = x - ∑ i, inner ℝ (vec i) x • vec (n := n) i := by
  simp [projL, rankSum_apply]

theorem projL_mem (hn : 4 ≤ n) (x : Biv n) : projL x ∈ (Kc (n := n)) := by
  rw [mem_Kc]; intro i
  rw [projL_apply, inner_sub_right, inner_sum]
  simp only [real_inner_smul_right, orthonormal_iff_ite.mp (vec_orthonormal hn), mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq, Finset.mem_univ, if_true, sub_self]

/-- `⟨k, z⟩ = ⟨k, projL z⟩` for `k` in the complement. -/
theorem inner_projL {k : Biv n} (hk : k ∈ (Kc (n := n))) (z : Biv n) : inner ℝ k z = inner ℝ k (projL z) := by
  rw [mem_Kc] at hk
  have hk' : ∀ i, inner ℝ k (vec (n := n) i) = 0 := fun i => by rw [real_inner_comm]; exact hk i
  rw [projL_apply, inner_sub_right, inner_sum]
  simp only [real_inner_smul_right, hk', mul_zero, Finset.sum_const_zero, sub_zero]

/-- `projL` onto the complement, as a map into it. -/
noncomputable def projK (hn : 4 ≤ n) : Biv n →ₗ[ℝ] (Kc (n := n)) := LinearMap.codRestrict _ projL (projL_mem hn)

/-- The six upper-triangular index pairs of the anti-self-dual block. -/
def pr6 : Fin 6 → Fin 3 × Fin 3 := ![(0, 0), (0, 1), (0, 2), (1, 1), (1, 2), (2, 2)]

/-- **The condition map**: `H ↦ (projL(H ω_γ))_γ` together with the six entries `⟨ω_γ', H ω_γ⟩`, `γ' ≤ γ`, of
`H` on the anti-self-dual block. Its target has dimension `3 (N − 6) + 6 = 3N − 12`. -/
noncomputable def condMap (hn : 4 ≤ n) : (Biv n →ₗ[ℝ] Biv n) →ₗ[ℝ] ((Fin 3 → Kc (n := n)) × (Fin 6 → ℝ)) where
  toFun H := (fun γ => projK hn (H (asd γ)), fun j => inner ℝ (asd (pr6 j).1) (H (asd (pr6 j).2)))
  map_add' H H' := by
    refine Prod.ext (funext fun γ => ?_) (funext fun j => ?_) <;> simp [inner_add_right]
  map_smul' c H := by
    refine Prod.ext (funext fun γ => ?_) (funext fun j => ?_) <;> simp [real_inner_smul_right]

theorem finrank_cod (hn : 4 ≤ n) :
    finrank ℝ ((Fin 3 → Kc (n := n)) × (Fin 6 → ℝ)) = 3 * finrank ℝ (Biv n) - 12 := by
  rw [Module.finrank_prod, Module.finrank_pi_fintype, Module.finrank_fin_fun]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul]
  have := finrank_Kc hn; omega

/-- The six entries vanish iff every entry of `H` on the anti-self-dual block does. -/
theorem asd_entries_zero {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric)
    (h : ∀ j, inner ℝ (asd (n := n) (pr6 j).1) (H (asd (pr6 j).2)) = 0) (a b : Fin 3) :
    inner ℝ (asd (n := n) a) (H (asd b)) = 0 := by
  have hs : ∀ a b : Fin 3, inner ℝ (asd (n := n) a) (H (asd b)) = inner ℝ (asd (n := n) b) (H (asd a)) := fun a b => by
    rw [← hH, real_inner_comm]
  fin_cases a <;> fin_cases b
  · exact h 0
  · exact h 1
  · exact h 2
  · rw [hs]; exact h 1
  · exact h 3
  · exact h 4
  · rw [hs]; exact h 2
  · rw [hs]; exact h 4
  · exact h 5

variable {N : ℕ} (hN : finrank ℝ (Biv n) = N)

/-- The kernel of `u` is orthogonal to the three self-dual `vec`. -/
theorem inner_vec_of_ker (hn : 4 ≤ n) {b : Biv n} (hb : uOp b = 0) {i : Fin 6} (hi : i.val < 3) :
    inner ℝ (vec i) b = 0 := by
  have h : inner ℝ (uOp (vec (n := n) i)) b = inner ℝ (vec i) (uOp b) := uOp_isSymmetric _ _
  rw [hb, inner_zero_right, uOp, rankSum_vec hn, real_inner_smul_left] at h
  exact (mul_eq_zero.mp h).resolve_left (lam6_ne_zero hi)

/-- The complement lies in the kernel of `u`. -/
theorem uOp_of_Kc {z : Biv n} (hz : z ∈ (Kc (n := n))) : uOp z = 0 := by
  rw [mem_Kc] at hz
  simp [uOp, rankSum_apply, hz]

/-- **The kernel of the condition map is exactly `P₀HP₀` vanishing on the anti-self-dual bivectors.** -/
theorem condMap_eq_zero_iff (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) :
    condMap hn H = 0 ↔ ∀ γ : Fin 3, schur hN uOp_isSymmetric zeroφ H (asd (n := n) γ) = 0 := by
  have hu := uOp_isSymmetric (n := n)
  have hz0 : ∀ {w : Biv n}, uOp w = 0 → uOp w = (0 : ℝ) • w := fun h => by rw [h, zero_smul]
  constructor
  · intro h γ
    have h1 : ∀ γ', projL (H (asd (n := n) γ')) = 0 := fun γ' => by
      have := congrArg (fun p => ((p.1 γ' : Kc (n := n)) : Biv n)) h
      simpa [condMap, projK] using this
    have h2 : ∀ j, inner ℝ (asd (n := n) (pr6 j).1) (H (asd (pr6 j).2)) = 0 := fun j => by
      have := congrFun (congrArg Prod.snd h) j
      simpa [condMap] using this
    have hent := asd_entries_zero hH h2
    -- every kernel vector of `u` is orthogonal to `H ω_γ`
    have hker : ∀ b : Biv n, uOp b = 0 → inner ℝ b (H (asd γ)) = 0 := fun b hb => by
      have hdec : b = ∑ i, inner ℝ (vec i) b • vec (n := n) i + projL b := by rw [projL_apply]; abel
      rw [hdec, inner_add_left, inner_projL (projL_mem hn b), h1, inner_zero_right, add_zero, sum_inner]
      rw [Fin.sum_univ_six]
      simp only [real_inner_smul_left]
      rw [inner_vec_of_ker hn hb (by decide : (0 : Fin 6).val < 3), inner_vec_of_ker hn hb (by decide : (1 : Fin 6).val < 3),
        inner_vec_of_ker hn hb (by decide : (2 : Fin 6).val < 3)]
      have e3 := hent 0 γ; have e4 := hent 1 γ; have e5 := hent 2 γ
      simp only [asd] at e3 e4 e5
      change inner ℝ (vec (n := n) 3) (H (asd γ)) = 0 at e3
      change inner ℝ (vec (n := n) 4) (H (asd γ)) = 0 at e4
      change inner ℝ (vec (n := n) 5) (H (asd γ)) = 0 at e5
      rw [e3, e4, e5]; ring
    refine InnerProductSpace.ext_inner_left_basis (hu.eigenvectorBasis hN).toBasis fun k => ?_
    simp only [OrthonormalBasis.coe_toBasis, inner_zero_right]
    rw [inner_schur_eigen₂ hN hu zeroφ H (hu.apply_eigenvectorBasis hN k) (uOp_asd hn γ)]
    by_cases hk : hu.eigenvalues hN k = 0
    · have hb : uOp (hu.eigenvectorBasis hN k) = 0 := by rw [hu.apply_eigenvectorBasis, hk]; simp
      rw [hker _ hb, mul_zero]
    · simp [zeroφ, hk]
  · intro h
    -- every kernel vector of `u` is orthogonal to `H ω_γ`
    have hker : ∀ γ (w : Biv n), uOp w = 0 → inner ℝ w (H (asd γ)) = 0 := fun γ w hw => by
      have := inner_schur_eigen₂ hN hu zeroφ H (hz0 hw) (uOp_asd hn γ)
      rw [h γ, inner_zero_right] at this
      simpa [zeroφ] using this.symm
    refine Prod.ext (funext fun γ => ?_) (funext fun j => ?_)
    · have hz := projL_mem hn (H (asd (n := n) γ))
      have h0 : inner ℝ (projL (H (asd (n := n) γ))) (projL (H (asd γ))) = 0 := by
        rw [← inner_projL hz]; exact hker γ _ (uOp_of_Kc hz)
      have : projL (H (asd (n := n) γ)) = 0 := inner_self_eq_zero.mp h0
      exact Subtype.ext (by simpa [condMap, projK] using this)
    · simpa [condMap] using hker (pr6 j).2 _ ((uOp_asd hn _).trans (zero_smul _ _))

/-- **`{F = 0}` is the kernel of the condition map**, on the admissible directions. -/
theorem F_eq_zero_iff_condMap (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hA : Admissible H) :
    Fval hN hA.symm = 0 ↔ condMap hn H = 0 :=
  (F_eq_zero_iff hN hn hA.symm hA.bianchi hA.tangent).trans (condMap_eq_zero_iff hN hn hA.symm).symm

/-- **L17's dimension count**: on any space `V` of admissible directions (symmetric, `Alt(H) = 0`, tangent), the equality
cone `{F = 0} ∩ V` is the kernel of the condition map, and its codimension in `V` is at most `3N − 12`, `N = dim Λ²ℝⁿ`. -/
theorem L17_codim (hn : 4 ≤ n) (V : Submodule ℝ (Biv n →ₗ[ℝ] Biv n)) (hV : ∀ H ∈ V, Admissible H) :
    (∀ H : V, H ∈ LinearMap.ker (condMap hn ∘ₗ V.subtype) ↔ Fval hN (hV H H.2).symm = 0) ∧
      finrank ℝ V ≤ finrank ℝ (LinearMap.ker (condMap hn ∘ₗ V.subtype)) + (3 * finrank ℝ (Biv n) - 12) := by
  refine ⟨fun H => ?_, ?_⟩
  · rw [LinearMap.mem_ker, LinearMap.comp_apply, Submodule.subtype_apply, F_eq_zero_iff_condMap hN hn (hV H H.2)]
  · have h := LinearMap.finrank_range_add_finrank_ker (condMap hn ∘ₗ V.subtype)
    have hr := Submodule.finrank_le (LinearMap.range (condMap hn ∘ₗ V.subtype))
    rw [finrank_cod hn] at hr
    omega

theorem finrank_biv12 : finrank ℝ (Biv 12) = 66 := by
  rw [finrank_euclideanSpace]; rfl

/-- **At `n = 12`: `codim {F = 0} ≤ 186`**, the record's count of the conditions `Π_ASD H Π_ker u = 0`: `3 · 63` entries
of `P₀HP₀` on the three anti-self-dual bivectors, less the `3` that symmetry makes redundant on their own block. -/
theorem L17_codim_12 (V : Submodule ℝ (Biv 12 →ₗ[ℝ] Biv 12)) (hV : ∀ H ∈ V, Admissible H) :
    finrank ℝ V ≤ finrank ℝ (LinearMap.ker (condMap (by norm_num) ∘ₗ V.subtype)) + 186 := by
  have := (L17_codim rfl (by norm_num) V hV).2
  rwa [finrank_biv12] at this

end HamiltonsCubic.L17Deriv
