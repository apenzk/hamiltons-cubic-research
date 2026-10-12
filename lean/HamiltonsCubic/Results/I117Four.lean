import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# The four-block family of `𝔰𝔬(n)` (toward L267)

For an injection `e : Fin 4 → ι`, `𝔰𝔬(ι)` splits under `SO(4) × SO(ι ∖ e)` as `Λ²₊ ⊕ Λ²₋ ⊕ 𝔰𝔬(ι ∖ e) ⊕ V`. This file
builds the adapted basis (`omS`, the self-dual and anti-self-dual vectors of the four-block, and the `φ`'s off the
block), rewrites every `φ`-family sum in it (`four_sum_change`), defines the invariant family
`fourOp a₊ a₋ aₛ b = a₊P₊ + a₋P₋ + aₛPₛ + bP_V` and its action on the basis (`fourOp_omS`, `fourOp_phiS`), and
states the sharp's crossed pairing (`crossPair2_four`) and the quadratic form (`QF_four`) there. *The brackets of
the basis were screened numerically at `n = 7` before typing: `[Λ²₊, Λ²₋] = 0` and each factor closes with
`[ω_k, ω_l] = ±√2 ω_m`.*
-/

namespace HamiltonsCubic.I117S
open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge Matrix Finset

section FourBlock

variable {ι : Type*} [Fintype ι] [DecidableEq ι] (e : Fin 4 → ι)

/-- The self-dual (`s = true`) and anti-self-dual vectors of the four-block spanned by `e`. -/
noncomputable def omS (s : Bool) (k : Fin 3) : skewSub ι :=
  (1 / Real.sqrt 2) • match k with
    | 0 => phiS (e 0) (e 1) + (if s then (1 : ℝ) else -1) • phiS (e 2) (e 3)
    | 1 => phiS (e 0) (e 2) - (if s then (1 : ℝ) else -1) • phiS (e 1) (e 3)
    | 2 => phiS (e 0) (e 3) + (if s then (1 : ℝ) else -1) • phiS (e 1) (e 2)

/-- Membership in the four-block. -/
def inF (p : ι) : Prop := ∃ a, e a = p

instance (p : ι) : Decidable (inF e p) := by unfold inF; infer_instance

/-- **The `φ`-family sum split at the four-block**: the block's `φ` pairs become `Λ²₊ ⊕ Λ²₋`. -/
theorem four_sum_change (he : Function.Injective e) (f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ) :
    ∑ p, ∑ q, f (phiS p q) (phiS p q)
      = 2 * ∑ k, (f (omS e true k) (omS e true k) + f (omS e false k) (omS e false k))
        + ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else f (phiS p q) (phiS p q)) := by
  have hsplit : ∀ p q, f (phiS p q) (phiS p q) = (if inF e p ∧ inF e q then f (phiS p q) (phiS p q) else 0)
      + (if inF e p ∧ inF e q then 0 else f (phiS p q) (phiS p q)) := fun p q => by split_ifs <;> simp
  rw [Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => hsplit p q]
  simp only [Finset.sum_add_distrib]
  congr 1
  -- the block part, reindexed by `e`
  have hre : ∀ g : ι → ι → ℝ, ∑ p, ∑ q, (if inF e p ∧ inF e q then g p q else 0) = ∑ a, ∑ b, g (e a) (e b) := by
    intro g
    have h1 : ∀ p, ∑ q, (if inF e p ∧ inF e q then g p q else 0)
        = if inF e p then ∑ b, g p (e b) else 0 := fun p => by
      by_cases hp : inF e p
      · simp only [hp, true_and, if_true]
        rw [← Finset.sum_filter]
        have : (Finset.univ.filter (inF e)) = Finset.univ.image e := by
          ext q; simp [inF]
        rw [this, Finset.sum_image (fun x _ y _ h => he h)]
      · simp [hp]
    simp only [h1]
    rw [← Finset.sum_filter]
    have : (Finset.univ.filter (inF e)) = Finset.univ.image e := by ext q; simp [inF]
    rw [this, Finset.sum_image (fun x _ y _ h => he h)]
  rw [hre (fun p q => f (phiS p q) (phiS p q))]
  have hs := inv_sqrt2_sq
  simp only [Fin.sum_univ_four, Fin.sum_univ_three, omS, phiS_self, map_zero, LinearMap.zero_apply,
    map_add, map_sub, map_smul, LinearMap.add_apply, LinearMap.sub_apply, LinearMap.smul_apply, smul_eq_mul,
    if_true, Bool.false_eq_true, if_false]
  rw [phiS_swap (e 0) (e 1), phiS_swap (e 0) (e 2), phiS_swap (e 0) (e 3), phiS_swap (e 1) (e 2),
    phiS_swap (e 1) (e 3), phiS_swap (e 2) (e 3)]
  simp only [map_neg, LinearMap.neg_apply, neg_neg]
  linear_combination (-(f (phiS (e 0) (e 1)) (phiS (e 0) (e 1)) + f (phiS (e 2) (e 3)) (phiS (e 2) (e 3))
    + f (phiS (e 0) (e 2)) (phiS (e 0) (e 2)) + f (phiS (e 1) (e 3)) (phiS (e 1) (e 3))
    + f (phiS (e 0) (e 3)) (phiS (e 0) (e 3)) + f (phiS (e 1) (e 2)) (phiS (e 1) (e 2)))) * 4 * hs


/-- The rank-one operator `X ↦ ⟨X, u⟩ u`. -/
noncomputable def rk1 (u : skewSub ι) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => inner2 (X : Matrix ι ι ℝ) (u : Matrix ι ι ℝ) • u
      map_add' := fun X Y => by simp only [Submodule.coe_add, i2_add_l, add_smul]
      map_smul' := fun c X => by simp only [Submodule.coe_smul, i2_smul_l, smul_smul, RingHom.id_apply] }

theorem rk1_apply (u X : skewSub ι) : rk1 u X = inner2 (X : Matrix ι ι ℝ) (u : Matrix ι ι ℝ) • u := rfl

/-- The projection onto `Λ²₊` (`s = true`) or `Λ²₋` of the four-block. -/
noncomputable def projOm (s : Bool) : CurvOp2 ι := ∑ k, rk1 (omS e s k)

/-- The coordinate weight of the four-block family: `0` inside the block, `b` on mixed pairs, `aₛ` outside. -/
def wSV (as b : ℝ) : Matrix ι ι ℝ := fun p q =>
  if p = q then 0 else if inF e p ∧ inF e q then 0 else if inF e p ∨ inF e q then b else as

/-- **The four-block family** `C = a₊P₊ + a₋P₋ + aₛPₛ + bP_V`. -/
noncomputable def fourOp (ap am as b : ℝ) : CurvOp2 ι :=
  coordOp (wSV e as b) + ap • projOm e true + am • projOm e false

theorem wSV_symm (as b : ℝ) : (wSV e as b)ᵀ = wSV e as b := by
  ext p q; simp only [wSV, Matrix.transpose_apply]
  by_cases h : q = p
  · subst h; rfl
  · rw [if_neg h, if_neg (Ne.symm h)]; simp only [and_comm, or_comm]

theorem inner2_phiS (p q r t : ι) :
    inner2 ((phiS p q : skewSub ι) : Matrix ι ι ℝ) ((phiS r t : skewSub ι) : Matrix ι ι ℝ)
      = (if p = r ∧ q = t then (1 : ℝ) else 0) - (if q = r ∧ p = t then (1 : ℝ) else 0) :=
  HamiltonsCubic.FamilyLayer.inner2_phi_phi p q r t

/-- The Gram matrix of the `Λ²±` vectors. -/
theorem omS_inner (he : Function.Injective e) (s s' : Bool) (k k' : Fin 3) :
    inner2 ((omS e s k : skewSub ι) : Matrix ι ι ℝ) ((omS e s' k' : skewSub ι) : Matrix ι ι ℝ)
      = if s = s' ∧ k = k' then 1 else 0 := by
  have hs := inv_sqrt2_sq
  have hne : ∀ a b : Fin 4, a ≠ b → e a ≠ e b := fun a b h h' => h (he h')
  have h01 := hne 0 1 (by decide); have h02 := hne 0 2 (by decide); have h03 := hne 0 3 (by decide)
  have h12 := hne 1 2 (by decide); have h13 := hne 1 3 (by decide); have h23 := hne 2 3 (by decide)
  cases s <;> cases s' <;> fin_cases k <;> fin_cases k' <;>
  · simp only [omS, Submodule.coe_smul, Submodule.coe_add, Submodule.coe_sub, i2_smul_l, i2_smul_r, i2_add_l,
      i2_add_r, i2_sub_l, i2_sub_r', inner2_phiS]
    simp [h01, h02, h03, h12, h13, h23, Ne.symm h01, Ne.symm h02, Ne.symm h03, Ne.symm h12, Ne.symm h13,
      Ne.symm h23]
    try linear_combination 2 * hs


theorem projOm_apply (s : Bool) (X : skewSub ι) :
    projOm e s X = ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e s k : skewSub ι) : Matrix ι ι ℝ) • omS e s k := by
  simp only [projOm, ContinuousLinearMap.sum_apply, rk1_apply]

theorem projOm_omS (he : Function.Injective e) (s s' : Bool) (k : Fin 3) :
    projOm e s (omS e s' k) = if s = s' then omS e s' k else 0 := by
  rw [projOm_apply]
  simp only [omS_inner e he, Fin.sum_univ_three]
  by_cases h : s = s'
  · subst h; fin_cases k <;> simp
  · simp [h, Ne.symm h]

/-- The block `φ`'s are orthogonal to `Λ²±` off the block. -/
theorem inner2_phiS_omS (p q : ι) (hpq : ¬(inF e p ∧ inF e q)) (s : Bool) (k : Fin 3) :
    inner2 ((phiS p q : skewSub ι) : Matrix ι ι ℝ) ((omS e s k : skewSub ι) : Matrix ι ι ℝ) = 0 := by
  have hp : ∀ a b, ¬(p = e a ∧ q = e b) := fun a b h => hpq ⟨⟨a, h.1.symm⟩, ⟨b, h.2.symm⟩⟩
  have hq : ∀ a b, ¬(q = e a ∧ p = e b) := fun a b h => hpq ⟨⟨b, h.2.symm⟩, ⟨a, h.1.symm⟩⟩
  fin_cases k <;>
  · simp only [omS, Submodule.coe_smul, Submodule.coe_add, Submodule.coe_sub, i2_smul_r, i2_add_r, i2_sub_r',
      inner2_phiS]
    simp [hp, hq]

theorem projOm_phiS (p q : ι) (hpq : ¬(inF e p ∧ inF e q)) (s : Bool) : projOm e s (phiS p q) = 0 := by
  rw [projOm_apply]; simp [inner2_phiS_omS e p q hpq]

theorem coordOp_phiS (a : Matrix ι ι ℝ) (ha : aᵀ = a) (p q : ι) : coordOp a (phiS p q) = a p q • phiS p q :=
  Subtype.ext (by rw [coordOp_coe a ha, Submodule.coe_smul]; exact hadamard_phi a ha p q)

/-- **The family on `Λ²±`**: `C ω±_k = a± ω±_k`. -/
theorem fourOp_omS (he : Function.Injective e) (ap am as b : ℝ) (s : Bool) (k : Fin 3) :
    fourOp e ap am as b (omS e s k) = (if s then ap else am) • omS e s k := by
  have hne : ∀ a b : Fin 4, a ≠ b → e a ≠ e b := fun a b h h' => h (he h')
  have hw : ∀ a c : Fin 4, wSV e as b (e a) (e c) = 0 := fun a c => by
    simp only [wSV]; split_ifs with h1 h2 <;> first | rfl | exact absurd ⟨⟨a, rfl⟩, ⟨c, rfl⟩⟩ h2
  have hco : coordOp (wSV e as b) (omS e s k) = 0 := by
    fin_cases k <;>
    · simp only [omS, map_smul, map_add, map_sub, coordOp_phiS _ (wSV_symm e as b), hw, zero_smul, add_zero,
        sub_zero, smul_zero]
  simp only [fourOp, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply, hco, projOm_omS e he, zero_add]
  cases s <;> simp

/-- **The family off the block**: `C φ_pq = aₛ φ_pq` on the complement, `b φ_pq` on mixed pairs. -/
theorem fourOp_phiS (ap am as b : ℝ) (p q : ι) (hpq : ¬(inF e p ∧ inF e q)) :
    fourOp e ap am as b (phiS p q) = wSV e as b p q • phiS p q := by
  simp only [fourOp, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
    coordOp_phiS _ (wSV_symm e as b), projOm_phiS e p q hpq, smul_zero, add_zero]


/-- **The crossed pairing of the sharp in the four-block basis**, for any `C` diagonal there. -/
theorem crossPair2_four (he : Function.Injective e) (C : CurvOp2 ι) (lam : Bool → ℝ) (w : ι → ι → ℝ)
    (hω : ∀ s k, C (omS e s k) = lam s • omS e s k)
    (hφ : ∀ p q, ¬(inF e p ∧ inF e q) → C (phiS p q) = w p q • phiS p q) (X Y : skewSub ι) :
    crossPair2 C X Y = (1 / 4) * (2 * ∑ k, ∑ s : Bool, lam s *
        inner2 ((C (brS Y (omS e s k)) : skewSub ι) : Matrix ι ι ℝ) ((brS X (omS e s k) : skewSub ι) : Matrix ι ι ℝ)
      + ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else w p q *
        inner2 ((C (brS Y (phiS p q)) : skewSub ι) : Matrix ι ι ℝ) ((brS X (phiS p q) : skewSub ι) : Matrix ι ι ℝ))) := by
  let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((brS X (C (brS Y (C W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have hcp : crossPair2 C X Y = -(1 / 4) * ∑ p, ∑ q, f (phiS p q) (phiS p q) := rfl
  have hskew : ∀ W, f W W = -inner2 ((C (brS Y (C W)) : skewSub ι) : Matrix ι ι ℝ)
      ((brS X W : skewSub ι) : Matrix ι ι ℝ) := fun W =>
    HamiltonsCubic.L33Statement.ad_skewAdjoint (C (brS Y (C W))).2 X.2 W.2
  rw [hcp, four_sum_change e he f]
  have h1 : ∀ k s, f (omS e s k) (omS e s k) = -(lam s * inner2 ((C (brS Y (omS e s k)) : skewSub ι) : Matrix ι ι ℝ)
      ((brS X (omS e s k) : skewSub ι) : Matrix ι ι ℝ)) := fun k s => by
    rw [hskew, hω, brS_smul_right, map_smul, Submodule.coe_smul, i2_smul_l]
  have h2 : ∀ p q, (if inF e p ∧ inF e q then (0 : ℝ) else f (phiS p q) (phiS p q))
      = -(if inF e p ∧ inF e q then 0 else w p q * inner2 ((C (brS Y (phiS p q)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS X (phiS p q) : skewSub ι) : Matrix ι ι ℝ)) := fun p q => by
    split_ifs with h
    · simp
    · rw [hskew, hφ p q h, brS_smul_right, map_smul, Submodule.coe_smul, i2_smul_l]
  simp only [h1, h2, Fintype.sum_bool, Finset.sum_neg_distrib, Finset.sum_add_distrib, Finset.sum_sub_distrib,
    neg_add, ← Finset.mul_sum, ← Finset.sum_mul]
  ring

/-- **Parseval for the quadratic form of a diagonal `C`** in the four-block basis. -/
theorem QF_four (he : Function.Injective e) (C : CurvOp2 ι) (lam : Bool → ℝ) (w : ι → ι → ℝ)
    (hω : ∀ s k, C (omS e s k) = lam s • omS e s k)
    (hφ : ∀ p q, ¬(inF e p ∧ inF e q) → C (phiS p q) = w p q • phiS p q) (hsa : IsSelfAdjoint2 C)
    (Z : skewSub ι) :
    inner2 ((C Z : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      = ∑ k, ∑ s : Bool, lam s * inner2 (Z : Matrix ι ι ℝ) ((omS e s k : skewSub ι) : Matrix ι ι ℝ) ^ 2
        + (1 / 2) * ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else
          w p q * inner2 (Z : Matrix ι ι ℝ) ((phiS p q : skewSub ι) : Matrix ι ι ℝ) ^ 2) := by
  let g : skewSub ι →ₗ[ℝ] ℝ :=
    { toFun := fun W => inner2 ((C W : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      map_add' := fun W W' => by simp only [map_add, Submodule.coe_add, i2_add_l]
      map_smul' := fun c W => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul, RingHom.id_apply] }
  have h := sum_phi_inner_sub Z g
  let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ (fun W W' => inner2 (Z : Matrix ι ι ℝ) (W : Matrix ι ι ℝ) * g W')
    (fun W₁ W₂ W' => by simp only [Submodule.coe_add, i2_add_r, add_mul])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul, mul_assoc])
    (fun W W₁' W₂' => by simp only [map_add, mul_add])
    (fun c W W' => by simp only [map_smul, smul_eq_mul]; ring)
  have e1 : ∑ p, ∑ q, inner2 (Z : Matrix ι ι ℝ) (phi p q) * g ⟨phi p q, phi_mem_skewSub p q⟩
      = ∑ p, ∑ q, f (phiS p q) (phiS p q) := rfl
  rw [e1, four_sum_change e he f] at h
  simp only [f, g, LinearMap.mk₂_apply, LinearMap.coe_mk, AddHom.coe_mk] at h
  have hg1 : ∀ s k, inner2 ((C (omS e s k) : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      = lam s * inner2 (Z : Matrix ι ι ℝ) ((omS e s k : skewSub ι) : Matrix ι ι ℝ) := fun s k => by
    rw [hω, Submodule.coe_smul, i2_smul_l, inner2_comm]
  have hg2 : ∀ p q, ¬(inF e p ∧ inF e q) → inner2 ((C (phiS p q) : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      = w p q * inner2 (Z : Matrix ι ι ℝ) ((phiS p q : skewSub ι) : Matrix ι ι ℝ) := fun p q hpq => by
    rw [hφ p q hpq, Submodule.coe_smul, i2_smul_l, inner2_comm]
  simp only [hg1] at h
  rw [show (∑ p, ∑ q, if inF e p ∧ inF e q then (0 : ℝ) else inner2 (Z : Matrix ι ι ℝ)
      ((phiS p q : skewSub ι) : Matrix ι ι ℝ) * inner2 ((C (phiS p q) : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ))
      = ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else w p q * inner2 (Z : Matrix ι ι ℝ)
        ((phiS p q : skewSub ι) : Matrix ι ι ℝ) ^ 2) from
    Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => by
      split_ifs with hpq
      · rfl
      · rw [hg2 p q hpq]; ring] at h
  rw [← h]
  simp only [Fintype.sum_bool, Finset.sum_add_distrib, ← Finset.mul_sum]
  have e1 : ∀ s, ∑ x, inner2 (Z : Matrix ι ι ℝ) ((omS e s x : skewSub ι) : Matrix ι ι ℝ)
      * (lam s * inner2 (Z : Matrix ι ι ℝ) ((omS e s x : skewSub ι) : Matrix ι ι ℝ))
      = lam s * ∑ x, inner2 (Z : Matrix ι ι ℝ) ((omS e s x : skewSub ι) : Matrix ι ι ℝ) ^ 2 := fun s => by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun x _ => by ring
  rw [e1, e1]
  ring

end FourBlock

section FourBlock2

variable {ι : Type*} [Fintype ι] [DecidableEq ι] (e : Fin 4 → ι)

theorem skew_zero_of_inner' (Z : skewSub ι) (h : inner2 (Z : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) = 0) : Z = 0 := by
  have h1 : toSk Z = 0 := inner_self_eq_zero.mp (by rw [inner_toSk]; exact h)
  exact Subtype.ext (show FrameExtension.toM (toSk Z) = 0 by rw [h1]; rfl)

/-- **A linear functional in the four-block basis.** -/
theorem four_expand (he : Function.Injective e) (g : skewSub ι →ₗ[ℝ] ℝ) (Y : skewSub ι) :
    g Y = ∑ k, ∑ s : Bool, inner2 (Y : Matrix ι ι ℝ) ((omS e s k : skewSub ι) : Matrix ι ι ℝ) * g (omS e s k)
      + (1 / 2) * ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else
          inner2 (Y : Matrix ι ι ℝ) ((phiS p q : skewSub ι) : Matrix ι ι ℝ) * g (phiS p q)) := by
  have h := sum_phi_inner_sub Y g
  let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ (fun W W' => inner2 (Y : Matrix ι ι ℝ) (W : Matrix ι ι ℝ) * g W')
    (fun W₁ W₂ W' => by simp only [Submodule.coe_add, i2_add_r, add_mul])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul, mul_assoc])
    (fun W W₁' W₂' => by simp only [map_add, mul_add])
    (fun c W W' => by simp only [map_smul, smul_eq_mul]; ring)
  have e1 : ∑ p, ∑ q, inner2 (Y : Matrix ι ι ℝ) (phi p q) * g ⟨phi p q, phi_mem_skewSub p q⟩
      = ∑ p, ∑ q, f (phiS p q) (phiS p q) := rfl
  rw [e1, four_sum_change e he f] at h
  simp only [f, LinearMap.mk₂_apply, Fintype.sum_bool] at h ⊢
  rw [← h, Finset.sum_add_distrib]
  ring

/-- An operator vanishing on the four-block basis vanishes. -/
theorem op_zero_four (he : Function.Injective e) (T : CurvOp2 ι) (hω : ∀ s k, T (omS e s k) = 0)
    (hφ : ∀ p q, ¬(inF e p ∧ inF e q) → T (phiS p q) = 0) : T = 0 := by
  refine ContinuousLinearMap.ext fun X => ?_
  let g : skewSub ι →ₗ[ℝ] ℝ :=
    { toFun := fun W => inner2 ((T W : skewSub ι) : Matrix ι ι ℝ) ((T X : skewSub ι) : Matrix ι ι ℝ)
      map_add' := fun W W' => by simp only [map_add, Submodule.coe_add, i2_add_l]
      map_smul' := fun c W => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul, RingHom.id_apply] }
  have h := four_expand e he g X
  have hz : ∀ W : skewSub ι, T W = 0 → g W = 0 := fun W hW => by
    show inner2 ((T W : skewSub ι) : Matrix ι ι ℝ) _ = 0
    rw [hW]; simp [inner2]
  have hg : g X = 0 := by
    rw [h]
    simp only [hz _ (hω _ _), mul_zero, Finset.sum_const_zero, zero_add]
    rw [Finset.sum_eq_zero fun p _ => Finset.sum_eq_zero fun q _ => ?_]
    · ring
    split_ifs with hpq
    · rfl
    · rw [hz _ (hφ p q hpq), mul_zero]
  exact skew_zero_of_inner' _ hg

/-- **Self-adjoint operators with the same quadratic form are equal.** -/
theorem op_eq_of_QF (R R' : CurvOp2 ι) (hR : IsSelfAdjoint2 R) (hR' : IsSelfAdjoint2 R')
    (h : ∀ X : skewSub ι, inner2 ((R X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ)
      = inner2 ((R' X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ)) : R = R' := by
  have hD : ∀ X Y : skewSub ι, inner2 (((R - R') X : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0 := by
    intro X Y
    have hXY := h (X + Y)
    have hX := h X
    have hY := h Y
    simp only [map_add, Submodule.coe_add, i2_add_l, i2_add_r] at hXY
    have s1 := hR Y X
    have s2 := hR' Y X
    simp only [ContinuousLinearMap.sub_apply, Submodule.coe_sub, i2_sub_l]
    rw [inner2_comm (Y : Matrix ι ι ℝ)] at s1 s2
    linarith
  have hz : R - R' = 0 := ContinuousLinearMap.ext fun X =>
    skew_zero_of_inner' _ (hD X ((R - R') X))
  exact sub_eq_zero.mp hz


/-- The coordinate weights of the family's coordinate-diagonal members: `c` inside the block, `b` mixed, `aₛ` outside. -/
def wAll (c as b : ℝ) : Matrix ι ι ℝ := fun p q =>
  if p = q then 0 else if inF e p ∧ inF e q then c else if inF e p ∨ inF e q then b else as

theorem wAll_symm (c as b : ℝ) : (wAll e c as b)ᵀ = wAll e c as b := by
  ext p q; simp only [wAll, Matrix.transpose_apply]
  by_cases h : q = p
  · subst h; rfl
  · rw [if_neg h, if_neg (Ne.symm h)]; simp only [and_comm, or_comm]

theorem wAll_diag (c as b : ℝ) (p : ι) : wAll e c as b p p = 0 := by simp [wAll]

theorem wAll_off (c as b : ℝ) (p q : ι) (hpq : ¬(inF e p ∧ inF e q)) : wAll e c as b p q = wSV e as b p q := by
  simp only [wAll, wSV, if_neg hpq]

/-- **The coordinate-diagonal members**: `fourOp c c aₛ b = coordOp (wAll c aₛ b)`. -/
theorem fourOp_eq_coordOp (he : Function.Injective e) (c as b : ℝ) :
    fourOp e c c as b = coordOp (wAll e c as b) := by
  have hne : ∀ a b : Fin 4, a ≠ b → e a ≠ e b := fun a b h h' => h (he h')
  have hw : ∀ a d : Fin 4, a ≠ d → wAll e c as b (e a) (e d) = c := fun a d h => by
    simp only [wAll, if_neg (hne a d h)]
    rw [if_pos ⟨⟨a, rfl⟩, ⟨d, rfl⟩⟩]
  have h := op_zero_four e he (fourOp e c c as b - coordOp (wAll e c as b))
    (fun s k => by
      rw [ContinuousLinearMap.sub_apply, fourOp_omS e he, sub_eq_zero]
      have hcs : (if s then c else c) = c := by cases s <;> rfl
      rw [hcs]
      fin_cases k <;>
      · simp only [omS, map_smul, map_add, map_sub, coordOp_phiS _ (wAll_symm e c as b),
          hw _ _ (by decide : (0 : Fin 4) ≠ 1), hw _ _ (by decide : (2 : Fin 4) ≠ 3),
          hw _ _ (by decide : (0 : Fin 4) ≠ 2), hw _ _ (by decide : (1 : Fin 4) ≠ 3),
          hw _ _ (by decide : (0 : Fin 4) ≠ 3), hw _ _ (by decide : (1 : Fin 4) ≠ 2)]
        module)
    (fun p q hpq => by
      rw [ContinuousLinearMap.sub_apply, fourOp_phiS e c c as b p q hpq, coordOp_phiS _ (wAll_symm e c as b),
        wAll_off e c as b p q hpq, sub_self])
  exact sub_eq_zero.mp h


theorem card_inF (he : Function.Injective e) : (Finset.univ.filter (inF e)).card = 4 := by
  have : (Finset.univ.filter (inF e)) = Finset.univ.image e := by ext q; simp [inF]
  rw [this, Finset.card_image_of_injective _ he]; simp

theorem card_notF (he : Function.Injective e) :
    ((Finset.univ.filter (fun k => ¬ inF e k)).card : ℝ) = (Fintype.card ι : ℝ) - 4 := by
  have h := Finset.card_filter_add_card_filter_not (s := Finset.univ) (p := inF e)
  rw [card_inF e he, Finset.card_univ] at h
  have : (Finset.univ.filter (fun k => ¬ inF e k)).card = Fintype.card ι - 4 := by omega
  rw [this, Nat.cast_sub (by omega)]; push_cast; ring

/-- A sum over a finset with two points removed, the summand constant elsewhere. -/
theorem sum_two_off (A : Finset ι) (p q : ι) (hp : p ∈ A) (hq : q ∈ A) (hpq : p ≠ q) (g : ι → ℝ) (x : ℝ)
    (hg : ∀ k ∈ A, k ≠ p → k ≠ q → g k = x) (gp : g p = 0) (gq : g q = 0) :
    ∑ k ∈ A, g k = x * ((A.card : ℝ) - 2) := by
  rw [← Finset.add_sum_erase _ _ hp, gp, zero_add,
    ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hpq, hq⟩), gq, zero_add,
    Finset.sum_congr rfl fun k hk => hg k (Finset.mem_of_mem_erase (Finset.mem_of_mem_erase hk))
      (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hk)) (Finset.ne_of_mem_erase hk),
    Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_erase.mpr ⟨Ne.symm hpq, hq⟩),
    Finset.card_erase_of_mem hp, nsmul_eq_mul]
  have h2 : 2 ≤ A.card := by
    have := Finset.card_le_card (Finset.insert_subset hp (Finset.singleton_subset_iff.mpr hq))
    rw [Finset.card_insert_of_notMem (by simpa using hpq), Finset.card_singleton] at this; exact this
  push_cast [Nat.cast_sub (by omega : 1 ≤ A.card), Nat.cast_sub (by omega : 1 ≤ A.card - 1)]
  ring

theorem sum_one_off (A : Finset ι) (p : ι) (hp : p ∈ A) (g : ι → ℝ) (x : ℝ)
    (hg : ∀ k ∈ A, k ≠ p → g k = x) (gp : g p = 0) : ∑ k ∈ A, g k = x * ((A.card : ℝ) - 1) := by
  rw [← Finset.add_sum_erase _ _ hp, gp, zero_add,
    Finset.sum_congr rfl fun k hk => hg k (Finset.mem_of_mem_erase hk) (Finset.ne_of_mem_erase hk),
    Finset.sum_const, Finset.card_erase_of_mem hp, nsmul_eq_mul]
  have h1 : 1 ≤ A.card := Finset.card_pos.mpr ⟨p, hp⟩
  push_cast [Nat.cast_sub h1]; ring

theorem sum_const_on (A : Finset ι) (g : ι → ℝ) (x : ℝ) (hg : ∀ k ∈ A, g k = x) :
    ∑ k ∈ A, g k = x * (A.card : ℝ) := by
  rw [Finset.sum_congr rfl hg, Finset.sum_const, nsmul_eq_mul, mul_comm]

/-- **The square of the coordinate weights**, block by block, with `|ι| - 4` off-block indices. -/
theorem starW_wAll (he : Function.Injective e) (c as b : ℝ) (p q : ι) (hpq : p ≠ q) :
    starW (wAll e c as b) p q = wAll e (2 * c ^ 2 + ((Fintype.card ι : ℝ) - 4) * b ^ 2)
      (((Fintype.card ι : ℝ) - 6) * as ^ 2 + 4 * b ^ 2)
      (3 * c * b + ((Fintype.card ι : ℝ) - 5) * b * as) p q := by
  have hF := card_inF e he
  have hS := card_notF e he
  simp only [starW]
  rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (inF e)]
  simp only [wAll, if_neg hpq]
  by_cases hp : inF e p <;> by_cases hq : inF e q
  · -- both in the block
    simp only [hp, hq, and_self, if_true]
    rw [sum_two_off _ p q (by simpa using hp) (by simpa using hq) hpq _ (c * c)
        (fun k hk h1 h2 => by simp only [Finset.mem_filter] at hk; simp [Ne.symm h1, Ne.symm h2, h1, h2, hk.2, hp, hq])
        (by simp) (by simp),
      sum_const_on _ _ (b * b) (fun k hk => by
        simp only [Finset.mem_filter] at hk
        have h1 : p ≠ k := fun h => hk.2 (h ▸ hp)
        have h2 : k ≠ q := fun h => hk.2 (h ▸ hq)
        simp [h1, h2, hk.2, hp, hq]), hF, hS]
    push_cast; ring
  · simp only [hp, hq, and_false, if_false, true_or, or_false, if_true]
    rw [sum_one_off _ p (by simpa using hp) _ (c * b) (fun k hk h1 => by
        simp only [Finset.mem_filter] at hk
        have h2 : k ≠ q := fun h => hq (h ▸ hk.2)
        simp [Ne.symm h1, h2, hk.2, hp, hq]) (by simp),
      sum_one_off _ q (by simpa using hq) _ (b * as) (fun k hk h1 => by
        simp only [Finset.mem_filter] at hk
        have h2 : p ≠ k := fun h => hk.2 (h ▸ hp)
        simp [h1, h2, hk.2, hp, hq]) (by simp), hF, hS]
    push_cast; ring
  · simp only [hp, hq, false_and, if_false, false_or, if_true]
    rw [sum_one_off _ q (by simpa using hq) _ (b * c) (fun k hk h1 => by
        simp only [Finset.mem_filter] at hk
        have h2 : p ≠ k := fun h => hp (h ▸ hk.2)
        simp [h1, h2, hk.2, hp, hq]) (by simp),
      sum_one_off _ p (by simpa using hp) _ (as * b) (fun k hk h1 => by
        simp only [Finset.mem_filter] at hk
        have h2 : k ≠ q := fun h => hk.2 (h ▸ hq)
        simp [Ne.symm h1, h2, hk.2, hp, hq]) (by simp), hF, hS]
    push_cast; ring
  · simp only [hp, hq, and_false, if_false, or_self]
    rw [sum_const_on _ _ (b * b) (fun k hk => by
        simp only [Finset.mem_filter] at hk
        have h1 : p ≠ k := fun h => hp (h ▸ hk.2)
        have h2 : k ≠ q := fun h => hq (h ▸ hk.2)
        simp [h1, h2, hk.2, hp, hq]),
      sum_two_off _ p q (by simpa using hp) (by simpa using hq) hpq _ (as * as)
        (fun k hk h1 h2 => by simp only [Finset.mem_filter] at hk; simp [Ne.symm h1, Ne.symm h2, h1, h2, hk.2, hp, hq])
        (by simp) (by simp), hF, hS]
    push_cast; ring


theorem coordOp_congr_off (a a' : Matrix ι ι ℝ) (ha : aᵀ = a) (ha' : a'ᵀ = a')
    (h : ∀ p q, p ≠ q → a p q = a' p q) : coordOp a = coordOp a' := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [coordOp_coe a ha, coordOp_coe a' ha']
  have hX : ∀ p, (X : Matrix ι ι ℝ) p p = 0 := fun p => by
    have := congrFun (congrFun X.2 p) p
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
  ext p q
  simp only [Matrix.hadamard_apply]
  by_cases hpq : p = q
  · subst hpq; rw [hX, mul_zero, mul_zero]
  · rw [h p q hpq]

/-- **The sharp of a coordinate-diagonal member of the family** stays in the family. -/
theorem sharp_fourOp_cc (he : Function.Injective e) (c as b : ℝ) :
    sharpMapCL (fourOp e c c as b) = fourOp e (2 * c ^ 2 + ((Fintype.card ι : ℝ) - 4) * b ^ 2)
      (2 * c ^ 2 + ((Fintype.card ι : ℝ) - 4) * b ^ 2) (((Fintype.card ι : ℝ) - 6) * as ^ 2 + 4 * b ^ 2)
      (3 * c * b + ((Fintype.card ι : ℝ) - 5) * b * as) := by
  rw [fourOp_eq_coordOp e he, fourOp_eq_coordOp e he,
    sharpMapCL_coordOp _ (wAll_symm e c as b) (wAll_diag e c as b)]
  exact coordOp_congr_off _ _ (starW_symm _ (wAll_symm e c as b)) (wAll_symm e _ _ _)
    (fun p q h => starW_wAll e he c as b p q h)


theorem phiS_e (he : Function.Injective e) (a b c d : Fin 4) :
    brS (phiS (e a) (e b)) (phiS (e c) (e d))
      = (if a = c then (1 : ℝ) else 0) • phiS (e b) (e d) + (if b = d then (1 : ℝ) else 0) • phiS (e a) (e c)
        - (if a = d then (1 : ℝ) else 0) • phiS (e b) (e c) - (if b = c then (1 : ℝ) else 0) • phiS (e a) (e d) := by
  rw [brS_phiS]; simp only [he.eq_iff]

/-- `Λ²₊` and `Λ²₋` commute. -/
theorem brS_omS_pm (he : Function.Injective e) (k l : Fin 3) : brS (omS e true k) (omS e false l) = 0 := by
  fin_cases k <;> fin_cases l <;>
  · simp only [omS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      phiS_e e he, Fin.isValue, Fin.reduceEq, if_false, if_true, zero_smul, one_smul, add_zero, zero_add, sub_zero,
      zero_sub, Bool.false_eq_true, brS_smul_left, brS_smul_right, smul_add, smul_sub, smul_zero]
    simp only [phiS_self, phiS_swap (e 1) (e 0), phiS_swap (e 2) (e 0), phiS_swap (e 3) (e 0),
      phiS_swap (e 2) (e 1), phiS_swap (e 3) (e 1), phiS_swap (e 3) (e 2)]
    module

/-- The `𝔰𝔲(2)` table of each factor: `[ω₀, ω₁] = ±√2 ω₂` and cyclically, `+` on `Λ²₊`. -/
theorem brS_omS_01 (he : Function.Injective e) (s : Bool) :
    brS (omS e s 0) (omS e s 1) = ((if s then 1 else -1) * Real.sqrt 2) • omS e s 2 := by
  have hs := inv_sqrt2_mul
  have hr : Real.sqrt 2 * (Real.sqrt 2)⁻¹ = 1 := mul_inv_cancel₀ (by positivity)
  cases s <;>
  · simp only [omS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      phiS_e e he, Fin.isValue, Fin.reduceEq, if_false, if_true, zero_smul, one_smul, add_zero, zero_add, sub_zero,
      zero_sub, Bool.false_eq_true, smul_add, smul_sub, smul_zero]
    simp only [phiS_self, phiS_swap (e 1) (e 0), phiS_swap (e 2) (e 0), phiS_swap (e 3) (e 0),
      phiS_swap (e 2) (e 1), phiS_swap (e 3) (e 1), phiS_swap (e 3) (e 2)]
    have h2 : Real.sqrt 2 ≠ 0 := by positivity
    have h22 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
    match_scalars <;> field_simp <;> nlinarith [h22]

theorem brS_omS_12 (he : Function.Injective e) (s : Bool) :
    brS (omS e s 1) (omS e s 2) = ((if s then 1 else -1) * Real.sqrt 2) • omS e s 0 := by
  have hs := inv_sqrt2_mul
  cases s <;>
  · simp only [omS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      phiS_e e he, Fin.isValue, Fin.reduceEq, if_false, if_true, zero_smul, one_smul, add_zero, zero_add, sub_zero,
      zero_sub, Bool.false_eq_true, smul_add, smul_sub, smul_zero]
    simp only [phiS_self, phiS_swap (e 1) (e 0), phiS_swap (e 2) (e 0), phiS_swap (e 3) (e 0),
      phiS_swap (e 2) (e 1), phiS_swap (e 3) (e 1), phiS_swap (e 3) (e 2)]
    have h2 : Real.sqrt 2 ≠ 0 := by positivity
    have h22 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
    match_scalars <;> field_simp <;> nlinarith [h22]

theorem brS_omS_20 (he : Function.Injective e) (s : Bool) :
    brS (omS e s 2) (omS e s 0) = ((if s then 1 else -1) * Real.sqrt 2) • omS e s 1 := by
  have hs := inv_sqrt2_mul
  cases s <;>
  · simp only [omS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      phiS_e e he, Fin.isValue, Fin.reduceEq, if_false, if_true, zero_smul, one_smul, add_zero, zero_add, sub_zero,
      zero_sub, Bool.false_eq_true, smul_add, smul_sub, smul_zero]
    simp only [phiS_self, phiS_swap (e 1) (e 0), phiS_swap (e 2) (e 0), phiS_swap (e 3) (e 0),
      phiS_swap (e 2) (e 1), phiS_swap (e 3) (e 1), phiS_swap (e 3) (e 2)]
    have h2 : Real.sqrt 2 ≠ 0 := by positivity
    have h22 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
    match_scalars <;> field_simp <;> nlinarith [h22]


theorem i2_br_move (X Y Z : skewSub ι) :
    inner2 ((brS X Y : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      = inner2 (X : Matrix ι ι ℝ) ((brS Y Z : skewSub ι) : Matrix ι ι ℝ) := by
  rw [brS_neg, Submodule.coe_neg, show ∀ M N : Matrix ι ι ℝ, inner2 (-M) N = -inner2 M N from fun M N => by
    unfold inner2; rw [Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]; ring, inner2_brS_skew, neg_neg]

theorem brS_omS_off (s : Bool) (k : Fin 3) (p q : ι) (hp : ¬ inF e p) (hq : ¬ inF e q) :
    brS (omS e s k) (phiS p q) = 0 := by
  have hp' : ∀ a, e a ≠ p := fun a h => hp ⟨a, h⟩
  have hq' : ∀ a, e a ≠ q := fun a h => hq ⟨a, h⟩
  fin_cases k <;>
  · simp only [omS, brS_smul_left, brS_add_left, brS_sub_left, brS_smul_left, brS_phiS, hp', hq', if_false,
      zero_smul, add_zero, sub_zero, smul_zero, sub_self]

/-- **The mixed block sees both chiralities alike**: for `q` off the block, the Gram forms
`X ↦ Σ_k ⟨X, [ω^±_k, φ_{e a, q}]⟩²` of the three `Λ²₊` and the three `Λ²₋` vectors are equal. -/
theorem vsym_mixed (he : Function.Injective e) (X : skewSub ι) (a : Fin 4) (q : ι) (hq : ¬ inF e q) :
    ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e true k) (phiS (e a) q) : skewSub ι) : Matrix ι ι ℝ) ^ 2
      = ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e false k) (phiS (e a) q) : skewSub ι) : Matrix ι ι ℝ) ^ 2 := by
  have hq' : ∀ b, e b ≠ q := fun b h => hq ⟨b, h⟩
  have hq'' : ∀ b, q ≠ e b := fun b h => hq ⟨b, h.symm⟩
  fin_cases a <;>
  · simp only [Fin.sum_univ_three, omS, brS_smul_left, brS_add_left, brS_sub_left, brS_phiS, he.eq_iff,
      hq', hq'', Fin.isValue, Fin.reduceEq, if_false, if_true, zero_smul, one_smul, add_zero, zero_add, sub_zero,
      zero_sub, Bool.false_eq_true, smul_add, smul_sub, smul_zero, smul_neg, Submodule.coe_smul, Submodule.coe_add,
      Submodule.coe_sub, Submodule.coe_neg, i2_smul_r, i2_add_r, i2_sub_r', ZeroMemClass.coe_zero]
    try simp only [show ∀ M : Matrix ι ι ℝ, inner2 M (-(0 : Matrix ι ι ℝ)) = 0 from fun M => by simp [inner2],
      show ∀ M N : Matrix ι ι ℝ, inner2 M (-N) = -inner2 M N from fun M N => by
        unfold inner2; rw [Matrix.mul_neg, Matrix.trace_neg]; ring]
    ring

/-- **Both chiralities have the same Gram form on every `φ_{pq}` with an index off the block**, from
`vsym_mixed` and the vanishing of both brackets when neither index is on it. -/
theorem vsym (he : Function.Injective e) (X : skewSub ι) (p q : ι) (hpq : ¬(inF e p ∧ inF e q)) :
    ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e true k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2
      = ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e false k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2 := by
  by_cases hp : inF e p
  · obtain ⟨a, rfl⟩ := hp
    exact vsym_mixed e he X a q (fun h => hpq ⟨⟨a, rfl⟩, h⟩)
  by_cases hq : inF e q
  · obtain ⟨a, rfl⟩ := hq
    have hn : ∀ s k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e s k) (phiS p (e a)) : skewSub ι) : Matrix ι ι ℝ) ^ 2
        = inner2 (X : Matrix ι ι ℝ) ((brS (omS e s k) (phiS (e a) p) : skewSub ι) : Matrix ι ι ℝ) ^ 2 := by
      intro s k
      have hsw : phiS p (e a) = (-1 : ℝ) • phiS (e a) p := by rw [phiS_swap (e a) p]; exact (neg_one_smul ℝ _).symm
      rw [hsw, brS_smul_right, Submodule.coe_smul, i2_smul_r]
      ring
    simp only [hn]
    exact vsym_mixed e he X a p hp
  · simp [brS_omS_off e _ _ p q hp hq, inner2]


theorem coordOp_sa (a : Matrix ι ι ℝ) (ha : aᵀ = a) : IsSelfAdjoint2 (coordOp a) := fun X Y => by
  rw [coordOp_coe a ha, coordOp_coe a ha, inner2_eq_sum, inner2_eq_sum]
  congr 1
  exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => by rw [Matrix.hadamard_apply, Matrix.hadamard_apply]; ring

theorem rk1_sa (u : skewSub ι) : IsSelfAdjoint2 (rk1 u) := fun X Y => by
  rw [rk1_apply, rk1_apply, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_r, inner2_comm (u : Matrix ι ι ℝ)]
  ring

theorem sa_add {R R' : CurvOp2 ι} (h : IsSelfAdjoint2 R) (h' : IsSelfAdjoint2 R') : IsSelfAdjoint2 (R + R') :=
  fun X Y => by
    simp only [ContinuousLinearMap.add_apply, Submodule.coe_add, i2_add_l, i2_add_r, h X Y, h' X Y]

theorem sa_smul {R : CurvOp2 ι} (c : ℝ) (h : IsSelfAdjoint2 R) : IsSelfAdjoint2 (c • R) := fun X Y => by
  simp only [ContinuousLinearMap.smul_apply, Submodule.coe_smul, i2_smul_l, i2_smul_r, h X Y]

theorem projOm_sa (s : Bool) : IsSelfAdjoint2 (projOm e s) := by
  unfold projOm
  rw [Fin.sum_univ_three]
  exact sa_add (sa_add (rk1_sa _) (rk1_sa _)) (rk1_sa _)

theorem fourOp_sa (ap am as b : ℝ) : IsSelfAdjoint2 (fourOp e ap am as b) :=
  sa_add (sa_add (coordOp_sa _ (wSV_symm e as b)) (sa_smul ap (projOm_sa e true))) (sa_smul am (projOm_sa e false))


theorem brS_self' (X : skewSub ι) : brS X X = 0 := by
  have h := brS_neg X X
  have h2 : (2 : ℝ) • brS X X = 0 := by
    rw [two_smul]; nth_rewrite 1 [h]; exact neg_add_cancel _
  exact (smul_eq_zero.mp h2).resolve_left two_ne_zero

/-- **The `Λ²±` block of the sharp's quadratic form**. -/
theorem om_block_sum (he : Function.Injective e) (lam : Bool → ℝ) (X : skewSub ι) (s : Bool) :
    ∑ k, ∑ k', ∑ s', lam s' * inner2 (X : Matrix ι ι ℝ) ((brS (omS e s k) (omS e s' k') : skewSub ι) : Matrix ι ι ℝ) ^ 2
      = 4 * lam s * ∑ m, inner2 (X : Matrix ι ι ℝ) ((omS e s m : skewSub ι) : Matrix ι ι ℝ) ^ 2 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hmp : ∀ k l, brS (omS e false k) (omS e true l) = 0 := fun k l => by
    rw [brS_neg, brS_omS_pm e he, neg_zero]
  have r10 : ∀ t, brS (omS e t 1) (omS e t 0) = -(((if t then 1 else -1) * Real.sqrt 2) • omS e t 2) := fun t => by
    rw [brS_neg, brS_omS_01 e he]
  have r21 : ∀ t, brS (omS e t 2) (omS e t 1) = -(((if t then 1 else -1) * Real.sqrt 2) • omS e t 0) := fun t => by
    rw [brS_neg, brS_omS_12 e he]
  have r02 : ∀ t, brS (omS e t 0) (omS e t 2) = -(((if t then 1 else -1) * Real.sqrt 2) • omS e t 1) := fun t => by
    rw [brS_neg, brS_omS_20 e he]
  have hsq : ∀ (c : ℝ) (Z : skewSub ι), inner2 (X : Matrix ι ι ℝ) ((c • Z : skewSub ι) : Matrix ι ι ℝ) ^ 2
      = c ^ 2 * inner2 (X : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) ^ 2 := fun c Z => by
    rw [Submodule.coe_smul, i2_smul_r]; ring
  have hsqn : ∀ (c : ℝ) (Z : skewSub ι), inner2 (X : Matrix ι ι ℝ) ((-(c • Z) : skewSub ι) : Matrix ι ι ℝ) ^ 2
      = c ^ 2 * inner2 (X : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) ^ 2 := fun c Z => by
    rw [Submodule.coe_neg, Submodule.coe_smul, show ∀ M N : Matrix ι ι ℝ, inner2 M (-N) = -inner2 M N from fun M N => by
      unfold inner2; rw [Matrix.mul_neg, Matrix.trace_neg]; ring, i2_smul_r]; ring
  have h0 : inner2 (X : Matrix ι ι ℝ) (((0 : skewSub ι)) : Matrix ι ι ℝ) = 0 := by simp [inner2]
  cases s <;>
  · simp only [Fin.sum_univ_three, Fintype.sum_bool, brS_self', brS_omS_pm e he, hmp, brS_omS_01 e he,
      brS_omS_12 e he, brS_omS_20 e he, r10, r21, r02, hsq, hsqn, h0]
    simp only [if_true, if_false, Bool.false_eq_true, mul_pow, h2]
    ring


/-- The `V`-term of the sharp's quadratic form on the family. -/
noncomputable def Vterm (as b : ℝ) (X : skewSub ι) : ℝ :=
  ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else wSV e as b p q *
    ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e true k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2)

/-- The `φ`–`φ` term of the sharp's quadratic form on the family. -/
noncomputable def Eterm (as b : ℝ) (X : skewSub ι) : ℝ :=
  ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else wSV e as b p q * ((1 / 2) * ∑ r, ∑ t,
    (if inF e r ∧ inF e t then 0 else wSV e as b r t *
      inner2 (X : Matrix ι ι ℝ) ((brS (phiS p q) (phiS r t) : skewSub ι) : Matrix ι ι ℝ) ^ 2)))

theorem sq_brS_swap (X Y Z : skewSub ι) :
    inner2 (X : Matrix ι ι ℝ) ((brS Y Z : skewSub ι) : Matrix ι ι ℝ) ^ 2
      = inner2 (X : Matrix ι ι ℝ) ((brS Z Y : skewSub ι) : Matrix ι ι ℝ) ^ 2 := by
  rw [brS_neg Y Z, Submodule.coe_neg, show ∀ M N : Matrix ι ι ℝ, inner2 M (-N) = -inner2 M N from fun M N => by
    unfold inner2; rw [Matrix.mul_neg, Matrix.trace_neg]; ring]; ring

/-- **The sharp's quadratic form on the family**, with `λ₊, λ₋` entering only through `Λ²±` and the `V`-term. -/
theorem G_form (he : Function.Injective e) (lp lm as b : ℝ) (X : skewSub ι) :
    sharpQF2 (fourOp e lp lm as b) X
      = 2 * lp ^ 2 * ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e true k : skewSub ι) : Matrix ι ι ℝ) ^ 2
        + 2 * lm ^ 2 * ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e false k : skewSub ι) : Matrix ι ι ℝ) ^ 2
        + (lp + lm) / 2 * Vterm e as b X + (1 / 4) * Eterm e as b X := by
  set lam : Bool → ℝ := fun s => if s then lp else lm with hlam
  have hω : ∀ s k, fourOp e lp lm as b (omS e s k) = lam s • omS e s k := fun s k => fourOp_omS e he lp lm as b s k
  have hφ : ∀ p q, ¬(inF e p ∧ inF e q) → fourOp e lp lm as b (phiS p q) = wSV e as b p q • phiS p q :=
    fun p q h => fourOp_phiS e lp lm as b p q h
  have hsa := fourOp_sa e lp lm as b
  rw [sharpQF2_eq_crossPair2, crossPair2_four e he _ lam (wSV e as b) hω hφ]
  simp only [QF_four e he _ lam (wSV e as b) hω hφ hsa, i2_br_move]
  -- the `ω`–`ω` block
  have hA : ∀ k s, ∑ k', ∑ s', lam s' * inner2 (X : Matrix ι ι ℝ)
      ((brS (omS e s k) (omS e s' k') : skewSub ι) : Matrix ι ι ℝ) ^ 2 = _ := fun k s => rfl
  -- the `V`-terms
  have hV1 : ∀ s, ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else wSV e as b p q *
      ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e s k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2)
      = Vterm e as b X := by
    intro s; cases s
    · unfold Vterm
      refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
      split_ifs with h
      · rfl
      · rw [vsym e he X p q h]
    · rfl
  -- rearrange the ω–φ terms: ∑_k ∑_s λ_s (½ ∑∑ ite ...) = ½ ∑_s λ_s ∑∑ ite (w ∑_k ...)
  have swap3 : ∀ g : Fin 3 → ι → ι → ℝ, ∑ k, ∑ p, ∑ q, (if inF e p ∧ inF e q then (0 : ℝ) else wSV e as b p q * g k p q)
      = ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else wSV e as b p q * ∑ k, g k p q) := by
    intro g
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun q _ => ?_
    split_ifs
    · simp
    · rw [Finset.mul_sum]
  have hωφ : ∑ k, ∑ s, lam s * ((1 / 2) * ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else wSV e as b p q *
      inner2 (X : Matrix ι ι ℝ) ((brS (omS e s k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2))
      = (lp + lm) / 2 * Vterm e as b X := by
    rw [Finset.sum_comm]
    have e1 : ∀ s, ∑ k, lam s * ((1 / 2) * ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else wSV e as b p q *
        inner2 (X : Matrix ι ι ℝ) ((brS (omS e s k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2))
        = lam s / 2 * Vterm e as b X := by
      intro s
      rw [← Finset.mul_sum, ← Finset.mul_sum, swap3 (fun k p q =>
        inner2 (X : Matrix ι ι ℝ) ((brS (omS e s k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2), hV1 s]
      ring
    rw [Fintype.sum_bool, e1 true, e1 false]
    simp only [hlam, if_true, Bool.false_eq_true, if_false]
    ring
  -- the φ–ω terms
  have hφω : ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else wSV e as b p q *
      (∑ k, ∑ s, lam s * inner2 (X : Matrix ι ι ℝ) ((brS (phiS p q) (omS e s k) : skewSub ι) : Matrix ι ι ℝ) ^ 2
        + (1 / 2) * ∑ r, ∑ t, (if inF e r ∧ inF e t then 0 else wSV e as b r t *
          inner2 (X : Matrix ι ι ℝ) ((brS (phiS p q) (phiS r t) : skewSub ι) : Matrix ι ι ℝ) ^ 2)))
      = (lp + lm) * Vterm e as b X + Eterm e as b X := by
    have e2 : ∀ p q, (if inF e p ∧ inF e q then (0 : ℝ) else wSV e as b p q *
        (∑ k, ∑ s, lam s * inner2 (X : Matrix ι ι ℝ) ((brS (phiS p q) (omS e s k) : skewSub ι) : Matrix ι ι ℝ) ^ 2
          + (1 / 2) * ∑ r, ∑ t, (if inF e r ∧ inF e t then 0 else wSV e as b r t *
            inner2 (X : Matrix ι ι ℝ) ((brS (phiS p q) (phiS r t) : skewSub ι) : Matrix ι ι ℝ) ^ 2)))
        = lp * (if inF e p ∧ inF e q then 0 else wSV e as b p q *
            ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e true k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2)
          + lm * (if inF e p ∧ inF e q then 0 else wSV e as b p q *
            ∑ k, inner2 (X : Matrix ι ι ℝ) ((brS (omS e false k) (phiS p q) : skewSub ι) : Matrix ι ι ℝ) ^ 2)
          + (if inF e p ∧ inF e q then 0 else wSV e as b p q * ((1 / 2) * ∑ r, ∑ t,
            (if inF e r ∧ inF e t then 0 else wSV e as b r t *
              inner2 (X : Matrix ι ι ℝ) ((brS (phiS p q) (phiS r t) : skewSub ι) : Matrix ι ι ℝ) ^ 2))) := by
      intro p q
      split_ifs with h
      · ring
      · simp only [Fintype.sum_bool, hlam, if_true, Bool.false_eq_true, if_false, Finset.sum_add_distrib,
          sq_brS_swap X (phiS p q), ← Finset.mul_sum]
        ring
    rw [Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => e2 p q]
    simp only [Finset.sum_add_distrib, ← Finset.mul_sum]
    rw [hV1 true, hV1 false]
    unfold Eterm; ring
  have hωω : ∑ k, ∑ s, lam s * ∑ k', ∑ s', lam s' * inner2 (X : Matrix ι ι ℝ)
      ((brS (omS e s k) (omS e s' k') : skewSub ι) : Matrix ι ι ℝ) ^ 2
      = 4 * lp ^ 2 * ∑ m, inner2 (X : Matrix ι ι ℝ) ((omS e true m : skewSub ι) : Matrix ι ι ℝ) ^ 2
        + 4 * lm ^ 2 * ∑ m, inner2 (X : Matrix ι ι ℝ) ((omS e false m : skewSub ι) : Matrix ι ι ℝ) ^ 2 := by
    rw [Finset.sum_comm]
    simp only [← Finset.mul_sum]
    rw [Fintype.sum_bool, om_block_sum e he lam X true, om_block_sum e he lam X false]
    simp only [hlam, if_true, Bool.false_eq_true, if_false]
    ring
  rw [hφω]
  simp only [mul_add, Finset.sum_add_distrib]
  rw [hωω, hωφ]
  ring


theorem sharp_sa (C : CurvOp2 ι) : IsSelfAdjoint2 (sharpMapCL C) := fun X Y => by
  rw [sharpMapCL_apply, sharpMapCL_apply, inner2_sharpMap, inner2_comm, inner2_sharpMap,
    sharpBil2_eq_crossPair2, sharpBil2_eq_crossPair2, crossPair2_comm]

theorem sharp_QF (C : CurvOp2 ι) (X : skewSub ι) :
    inner2 ((sharpMapCL C X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) = sharpQF2 C X := by
  rw [sharpMapCL_apply, inner2_sharpMap, sharpBil2_eq_crossPair2, sharpQF2_eq_crossPair2]

theorem QF_fourOp (he : Function.Injective e) (lp lm as b : ℝ) (X : skewSub ι) :
    inner2 ((fourOp e lp lm as b X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ)
      = lp * ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e true k : skewSub ι) : Matrix ι ι ℝ) ^ 2
        + lm * ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e false k : skewSub ι) : Matrix ι ι ℝ) ^ 2
        + (1 / 2) * ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else
          wSV e as b p q * inner2 (X : Matrix ι ι ℝ) ((phiS p q : skewSub ι) : Matrix ι ι ℝ) ^ 2) := by
  rw [QF_four e he _ (fun s => if s then lp else lm) (wSV e as b) (fun s k => fourOp_omS e he lp lm as b s k)
    (fun p q h => fourOp_phiS e lp lm as b p q h) (fourOp_sa e lp lm as b)]
  simp only [Fintype.sum_bool, if_true, Bool.false_eq_true, if_false, Finset.sum_add_distrib, ← Finset.mul_sum]

/-- **The four-block family is closed under `#`**, with `|ι| - 4` off-block indices. -/
theorem sharp_fourOp (he : Function.Injective e) (lp lm as b : ℝ) :
    sharpMapCL (fourOp e lp lm as b) = fourOp e (2 * lp ^ 2 + ((Fintype.card ι : ℝ) - 4) * b ^ 2)
      (2 * lm ^ 2 + ((Fintype.card ι : ℝ) - 4) * b ^ 2) (((Fintype.card ι : ℝ) - 6) * as ^ 2 + 4 * b ^ 2)
      (3 * ((lp + lm) / 2) * b + ((Fintype.card ι : ℝ) - 5) * b * as) := by
  set c := (lp + lm) / 2 with hc
  refine op_eq_of_QF _ _ (sharp_sa _) (fourOp_sa e _ _ _ _) fun X => ?_
  rw [sharp_QF, G_form e he, QF_fourOp e he]
  have hcc := G_form e he c c as b X
  rw [← sharp_QF, sharp_fourOp_cc e he, QF_fourOp e he] at hcc
  have hV : (lp + lm) / 2 = (c + c) / 2 := by rw [hc]; ring
  rw [hV]
  linarith [hcc]

end FourBlock2

section FourBlock3

variable {ι : Type*} [Fintype ι] [DecidableEq ι] (e : Fin 4 → ι)

theorem wSV_add (as b as' b' : ℝ) (p q : ι) : wSV e (as + as') (b + b') p q = wSV e as b p q + wSV e as' b' p q := by
  simp only [wSV]; split_ifs <;> ring

theorem fourOp_add (he : Function.Injective e) (ap am as b ap' am' as' b' : ℝ) :
    fourOp e ap am as b + fourOp e ap' am' as' b' = fourOp e (ap + ap') (am + am') (as + as') (b + b') := by
  have h := op_zero_four e he (fourOp e (ap + ap') (am + am') (as + as') (b + b') - (fourOp e ap am as b + fourOp e ap' am' as' b'))
    (fun s k => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.add_apply, fourOp_omS e he]
      cases s <;> simp [add_smul])
    (fun p q h => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.add_apply, fourOp_phiS e _ _ _ _ p q h, wSV_add,
        add_smul, sub_self])
  exact (sub_eq_zero.mp h).symm

theorem fourOp_smul (he : Function.Injective e) (c ap am as b : ℝ) :
    c • fourOp e ap am as b = fourOp e (c * ap) (c * am) (c * as) (c * b) := by
  have hw : ∀ p q, wSV e (c * as) (c * b) p q = c * wSV e as b p q := fun p q => by simp only [wSV]; split_ifs <;> ring
  have h := op_zero_four e he (fourOp e (c * ap) (c * am) (c * as) (c * b) - c • fourOp e ap am as b)
    (fun s k => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply, fourOp_omS e he, smul_smul]
      cases s <;> simp)
    (fun p q h => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply, fourOp_phiS e _ _ _ _ p q h, hw,
        smul_smul, sub_self])
  exact (sub_eq_zero.mp h).symm

/-- The ordered off-block pairs, counted by weight. -/
theorem sum_off_pairs (he : Function.Injective e) (g : ℝ → ℝ) (hg : g 0 = 0) (as b : ℝ) :
    ∑ p, ∑ q, (if inF e p ∧ inF e q then 0 else g (wSV e as b p q))
      = ((Fintype.card ι : ℝ) - 4) * ((Fintype.card ι : ℝ) - 5) * g as + 8 * ((Fintype.card ι : ℝ) - 4) * g b := by
  have hF := card_inF e he
  have hS := card_notF e he
  have hrow : ∀ p, ∑ q, (if inF e p ∧ inF e q then 0 else g (wSV e as b p q))
      = if inF e p then ((Fintype.card ι : ℝ) - 4) * g b else 4 * g b + ((Fintype.card ι : ℝ) - 5) * g as := by
    intro p
    rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (inF e)]
    by_cases hp : inF e p
    · rw [if_pos hp, sum_const_on _ _ 0 (fun q hq => by
          simp only [Finset.mem_filter] at hq; simp [hp, hq.2]),
        sum_const_on _ _ (g b) (fun q hq => by
          simp only [Finset.mem_filter] at hq
          have h1 : p ≠ q := fun h => hq.2 (h ▸ hp)
          simp [wSV, hp, hq.2, h1]), hS]
      ring
    · rw [if_neg hp, sum_const_on _ _ (g b) (fun q hq => by
          simp only [Finset.mem_filter] at hq
          have h1 : p ≠ q := fun h => hp (h ▸ hq.2)
          simp [wSV, hp, hq.2, h1]),
        sum_one_off _ p (by simpa using hp) _ (g as) (fun q hq h1 => by
          simp only [Finset.mem_filter] at hq
          simp [wSV, hp, hq.2, Ne.symm h1]) (by simp [wSV, hg]), hF, hS]
      push_cast; ring
  simp only [hrow]
  rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (inF e),
    sum_const_on _ _ (((Fintype.card ι : ℝ) - 4) * g b) (fun p hp => by simp only [Finset.mem_filter] at hp; simp [hp.2]),
    sum_const_on _ _ (4 * g b + ((Fintype.card ι : ℝ) - 5) * g as) (fun p hp => by
      simp only [Finset.mem_filter] at hp; simp [hp.2]), hF, hS]
  push_cast; ring


theorem wSV_mul (as b as' b' : ℝ) (p q : ι) :
    wSV e as b p q * wSV e as' b' p q = wSV e (as * as') (b * b') p q := by
  simp only [wSV]; split_ifs <;> ring

/-- **The operator pairing on the family**: `⟨C_x, C_y⟩ = 3x₊y₊ + 3x₋y₋ + ½ r(r-1) xₛyₛ + 4r x_b y_b`. -/
theorem innerOp2_fourOp (he : Function.Injective e) (xp xm xs xb yp ym ys yb : ℝ) :
    innerOp2 (fourOp e xp xm xs xb) (fourOp e yp ym ys yb)
      = 3 * xp * yp + 3 * xm * ym + (1 / 2) * ((Fintype.card ι : ℝ) - 4) * ((Fintype.card ι : ℝ) - 5) * xs * ys
        + 4 * ((Fintype.card ι : ℝ) - 4) * xb * yb := by
  let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((fourOp e xp xm xs xb W : skewSub ι) : Matrix ι ι ℝ)
      ((fourOp e yp ym ys yb W' : skewSub ι) : Matrix ι ι ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [map_add, Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have h : innerOp2 (fourOp e xp xm xs xb) (fourOp e yp ym ys yb) = (1 / 2) * ∑ p, ∑ q, f (phiS p q) (phiS p q) := rfl
  rw [h, four_sum_change e he f]
  simp only [f, LinearMap.mk₂_apply, fourOp_omS e he, Submodule.coe_smul, i2_smul_l, i2_smul_r, omS_inner e he]
  have hφ : ∀ p q, (if inF e p ∧ inF e q then (0 : ℝ) else inner2 ((fourOp e xp xm xs xb (phiS p q) : skewSub ι) : Matrix ι ι ℝ)
      ((fourOp e yp ym ys yb (phiS p q) : skewSub ι) : Matrix ι ι ℝ))
      = (if inF e p ∧ inF e q then 0 else id (wSV e (xs * ys) (xb * yb) p q)) := fun p q => by
    split_ifs with hpq
    · rfl
    · rw [fourOp_phiS e _ _ _ _ p q hpq, fourOp_phiS e _ _ _ _ p q hpq, Submodule.coe_smul, Submodule.coe_smul,
        i2_smul_l, i2_smul_r, inner2_phiS, id, ← wSV_mul]
      by_cases h : p = q
      · subst h; simp [wSV]
      · simp [h, Ne.symm h]
  simp only [hφ]
  rw [sum_off_pairs e he id rfl]
  simp only [Fin.sum_univ_three, id, if_true, and_self, Bool.false_eq_true, if_false]
  ring

/-- **The cubic on the family**, `F(C_x) = ⟨C_x, C_x # C_x⟩`. -/
theorem Ftri_fourOp (he : Function.Injective e) (xp xm xs xb : ℝ) :
    Ftri (fourOp e xp xm xs xb) (fourOp e xp xm xs xb) (fourOp e xp xm xs xb)
      = 3 * xp * (2 * xp ^ 2 + ((Fintype.card ι : ℝ) - 4) * xb ^ 2)
        + 3 * xm * (2 * xm ^ 2 + ((Fintype.card ι : ℝ) - 4) * xb ^ 2)
        + (1 / 2) * ((Fintype.card ι : ℝ) - 4) * ((Fintype.card ι : ℝ) - 5) * xs
          * (((Fintype.card ι : ℝ) - 6) * xs ^ 2 + 4 * xb ^ 2)
        + 4 * ((Fintype.card ι : ℝ) - 4) * xb * (3 * ((xp + xm) / 2) * xb + ((Fintype.card ι : ℝ) - 5) * xb * xs) := by
  rw [Ftri_sharp, sharp_fourOp e he, innerOp2_fourOp e he]


/-- **`I` is the four-block member with every coefficient `1`.** -/
theorem idOp_eq_fourOp (he : Function.Injective e) : (idOp : CurvOp2 ι) = fourOp e 1 1 1 1 := by
  rw [fourOp_eq_coordOp e he]
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [coordOp_coe _ (wAll_symm e 1 1 1)]
  have hX : ∀ p, (X : Matrix ι ι ℝ) p p = 0 := fun p => by
    have := congrFun (congrFun X.2 p) p
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
  ext p q
  simp only [Matrix.hadamard_apply, ContinuousLinearMap.id_apply]
  by_cases h : p = q
  · subst h; rw [hX, mul_zero]
  · simp only [wAll, if_neg h]; split_ifs <;> ring

/-- **Positive coefficients give a positive definite member.** -/
theorem fourOp_pd (he : Function.Injective e) (ap am as b : ℝ) (hp : 0 < ap) (hm : 0 < am) (hs : 0 < as)
    (hb : 0 < b) : IsPD2 (fourOp e ap am as b) := by
  intro X hX
  rw [QF_fourOp e he]
  have t1 : 0 ≤ ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e true k : skewSub ι) : Matrix ι ι ℝ) ^ 2 :=
    Finset.sum_nonneg fun k _ => sq_nonneg _
  have t2 : 0 ≤ ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e false k : skewSub ι) : Matrix ι ι ℝ) ^ 2 :=
    Finset.sum_nonneg fun k _ => sq_nonneg _
  have hw : ∀ p q, 0 ≤ wSV e as b p q := fun p q => by simp only [wSV]; split_ifs <;> linarith
  have t3 : 0 ≤ ∑ p, ∑ q, (if inF e p ∧ inF e q then (0 : ℝ) else
      wSV e as b p q * inner2 (X : Matrix ι ι ℝ) ((phiS p q : skewSub ι) : Matrix ι ι ℝ) ^ 2) :=
    Finset.sum_nonneg fun p _ => Finset.sum_nonneg fun q _ => by
      split_ifs <;> first | exact le_refl _ | exact mul_nonneg (hw p q) (sq_nonneg _)
  by_contra hle
  push_neg at hle
  have z1 : ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e true k : skewSub ι) : Matrix ι ι ℝ) ^ 2 = 0 := by
    nlinarith [mul_nonneg hp.le t1, mul_nonneg hm.le t2]
  have z2 : ∑ k, inner2 (X : Matrix ι ι ℝ) ((omS e false k : skewSub ι) : Matrix ι ι ℝ) ^ 2 = 0 := by
    nlinarith [mul_nonneg hp.le t1, mul_nonneg hm.le t2]
  have z3 : ∑ p, ∑ q, (if inF e p ∧ inF e q then (0 : ℝ) else
      wSV e as b p q * inner2 (X : Matrix ι ι ℝ) ((phiS p q : skewSub ι) : Matrix ι ι ℝ) ^ 2) = 0 := by
    nlinarith [mul_nonneg hp.le t1, mul_nonneg hm.le t2]
  have eω : ∀ s k, inner2 (X : Matrix ι ι ℝ) ((omS e s k : skewSub ι) : Matrix ι ι ℝ) = 0 := by
    intro s k
    have hz : ∀ k', inner2 (X : Matrix ι ι ℝ) ((omS e s k' : skewSub ι) : Matrix ι ι ℝ) ^ 2 = 0 := by
      intro k'
      cases s
      · exact (Finset.sum_eq_zero_iff_of_nonneg (fun k _ => sq_nonneg _)).mp z2 k' (Finset.mem_univ _)
      · exact (Finset.sum_eq_zero_iff_of_nonneg (fun k _ => sq_nonneg _)).mp z1 k' (Finset.mem_univ _)
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp (hz k)
  have eφ : ∀ p q, ¬(inF e p ∧ inF e q) → inner2 (X : Matrix ι ι ℝ) ((phiS p q : skewSub ι) : Matrix ι ι ℝ) = 0 := by
    intro p q hpq
    by_cases hpq' : p = q
    · subst hpq'; rw [phiS_self]; simp [inner2]
    have hrow := (Finset.sum_eq_zero_iff_of_nonneg (fun p _ => Finset.sum_nonneg fun q _ => by
      split_ifs <;> first | exact le_refl _ | exact mul_nonneg (hw p q) (sq_nonneg _))).mp z3 p (Finset.mem_univ p)
    have hpt := (Finset.sum_eq_zero_iff_of_nonneg (fun q _ => by
      split_ifs <;> first | exact le_refl _ | exact mul_nonneg (hw p q) (sq_nonneg _))).mp hrow q (Finset.mem_univ q)
    rw [if_neg hpq] at hpt
    have hwpos : 0 < wSV e as b p q := by simp only [wSV, if_neg hpq', if_neg hpq]; split_ifs <;> linarith
    have := (mul_eq_zero.mp hpt).resolve_left hwpos.ne'
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  apply hX
  let g : skewSub ι →ₗ[ℝ] ℝ :=
    { toFun := fun W => inner2 (X : Matrix ι ι ℝ) (W : Matrix ι ι ℝ)
      map_add' := fun W W' => by simp only [Submodule.coe_add, i2_add_r]
      map_smul' := fun c W => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul, RingHom.id_apply] }
  have h := four_expand e he g X
  have hg : g X = 0 := by
    rw [h]
    simp only [g, LinearMap.coe_mk, AddHom.coe_mk, eω, mul_zero, Finset.sum_const_zero, zero_add]
    rw [Finset.sum_eq_zero fun p _ => Finset.sum_eq_zero fun q _ => ?_]
    · ring
    split_ifs with hpq
    · rfl
    · rw [eφ p q hpq, mul_zero]
  exact skew_zero_of_inner' _ hg


/-- `F(C, X, X)` by polarising the cubic, on any index type. -/
theorem Ftri_pol' {C X : CurvOp2 ι} (hC : IsSelfAdjoint2 C) (hX : IsSelfAdjoint2 X) :
    Ftri C X X = (Ftri (C + X) (C + X) (C + X) + Ftri (C + (-1 : ℝ) • X) (C + (-1 : ℝ) • X) (C + (-1 : ℝ) • X)
      - 2 * Ftri C C C) / 6 := by
  have h1 := Ftri_line hC hX 1
  have h2 := Ftri_line hC hX (-1)
  rw [one_smul] at h1
  rw [h1, h2]; ring

/-- The block embedding `Fin 4 ↪ Fin n` L267's member lives on. -/
def L267e (n : ℕ) (hn : 4 ≤ n) : Fin 4 → Fin n := fun a => Fin.castLE hn a

theorem L267e_inj (n : ℕ) (hn : 4 ≤ n) : Function.Injective (L267e n hn) := fun a a' h => by
  have := congrArg Fin.val h; simp [L267e] at this; exact Fin.ext this

set_option maxHeartbeats 1000000 in
/-- **L267, the stated member.** With `N = n`, `K = 1/(N - 5)`, `b = √(3N - 14) K/8`, `D = √((N - 6)(5N - 24)/32) K` and
`a₊ = (½ + D)/2`, the four-block member `C = fourOp e a₊ (½ - a₊) (K/4) b` (so `a₊ + a₋ = ½`, `a₊a₋ = (N - 4)b²/2`,
`aₛ = 1/(4(N - 5))`, `b² = (3N - 14)/(64(N - 5)²)`) is a self-adjoint positive definite idempotent other than
`I/(n - 2)`, with `‖C‖² = (53N² - 524N + 1296)/(64(N - 5)²)` and `‖C‖²(N - 2)² - ‖I‖² = 3(N - 6)²(7N² - 44N + 48)/(64(N - 5)²)`.
The direction `H₀ = a₋P₊ + a₊P₋ + (1/(N - 5))Pₛ + 4bP_V`, projected off `C` and scaled by `‖C‖²` (`H = ‖C‖² H₀ - ⟨H₀, C⟩ C`),
is orthogonal to `C` with `F(C, H, H) - ½‖H‖² = 9(53N² - 524N + 1296)(249N⁴ - 4840N³ + 34620N² - 108000N + 123840)K⁶/524288`,
which is positive, so `C` is unstable, and `C` is heavier than `I/(n - 2)`. -/
theorem L267_member (n : ℕ) (hn : 7 ≤ n) (N K b D ap : ℝ) (hNdef : N = n) (hKdef : K = 1 / (N - 5))
    (hbdef : b = Real.sqrt (3 * N - 14) * K / 8) (hDdef : D = Real.sqrt ((N - 6) * (5 * N - 24) / 32) * K)
    (hapdef : ap = (1 / 2 + D) / 2) :
    let C := fourOp (L267e n (by omega)) ap (1 / 2 - ap) (K / 4) b
    let qv := 3 * ap * ap + 3 * (1 / 2 - ap) * (1 / 2 - ap) + (1 / 2) * (N - 4) * (N - 5) * (K / 4) * (K / 4)
      + 4 * (N - 4) * b * b
    let gv := 3 * (1 / 2 - ap) * ap + 3 * ap * (1 / 2 - ap) + (1 / 2) * (N - 4) * (N - 5) * K * (K / 4)
      + 4 * (N - 4) * (4 * b) * b
    let H := fourOp (L267e n (by omega)) (qv * (1 / 2 - ap) - gv * ap) (qv * ap - gv * (1 / 2 - ap))
      (qv * K - gv * (K / 4)) (qv * (4 * b) - gv * b)
    IsSelfAdjoint2 C ∧ IsPD2 C ∧ IsIdem C ∧ C ≠ (1 / ((n : ℝ) - 2)) • idOp ∧
      normSq2 C = (53 * N ^ 2 - 524 * N + 1296) * K ^ 2 / 64 ∧
      normSq2 C * (N - 2) ^ 2 - normSq2 (idOp : CurvOp2 (Fin n))
        = 3 * (N - 6) ^ 2 * (7 * N ^ 2 - 44 * N + 48) * K ^ 2 / 64 ∧
      IsSelfAdjoint2 H ∧ innerOp2 H C = 0 ∧
      Ftri C H H - (1 / 2) * normSq2 H
        = 9 * (53 * N ^ 2 - 524 * N + 1296) * (249 * N ^ 4 - 4840 * N ^ 3 + 34620 * N ^ 2 - 108000 * N + 123840)
          * K ^ 6 / 524288 ∧
      ¬ IsStable C ∧ normSq2 (idOp : CurvOp2 (Fin n)) / ((n : ℝ) - 2) ^ 2 < normSq2 C := by
  intro C qv gv H
  set e := L267e n (by omega) with he_def
  have he : Function.Injective e := L267e_inj n _
  have hN : (7 : ℝ) ≤ N := by rw [hNdef]; exact_mod_cast hn
  have hcard : (Fintype.card (Fin n) : ℝ) = N := by rw [Fintype.card_fin, hNdef]
  have hK : K * (N - 5) = 1 := by rw [hKdef]; exact one_div_mul_cancel (by linarith)
  have hK0 : 0 < K := by rw [hKdef]; apply div_pos one_pos; linarith
  have hb2 : b ^ 2 = (3 * N - 14) * K ^ 2 / 64 := by
    rw [hbdef, div_pow, mul_pow, Real.sq_sqrt (by linarith)]; ring
  have hb0 : 0 < b := by rw [hbdef]; have := Real.sqrt_pos.mpr (show (0 : ℝ) < 3 * N - 14 by linarith); positivity
  have hD2 : D ^ 2 = (N - 6) * (5 * N - 24) / 32 * K ^ 2 := by
    rw [hDdef, mul_pow, Real.sq_sqrt (by have : 0 ≤ (N - 6) * (5 * N - 24) := by nlinarith
                                         positivity)]
  have hD0 : 0 < D := by
    rw [hDdef]; have := Real.sqrt_pos.mpr (show (0 : ℝ) < (N - 6) * (5 * N - 24) / 32 by nlinarith); positivity
  have h1 : ap ^ 2 - ap / 2 + (N - 4) * b ^ 2 / 2 = 0 := by
    rw [hapdef]; linear_combination (1 / 4) * hD2 + ((N - 4) / 2) * hb2 + (1 / 16) * (K * (N - 5) + 1) * hK
  have hap0 : 0 < ap := by rw [hapdef]; linarith
  have hDhalf : D < 1 / 2 := by
    have hq : D ^ 2 < (1 / 2) ^ 2 := by
      rw [hD2]
      have hK2 : K ^ 2 * (N - 5) ^ 2 = 1 := by rw [← mul_pow, hK]; norm_num
      nlinarith [sq_nonneg K, hK0]
    nlinarith
  have ham0 : 0 < 1 / 2 - ap := by rw [hapdef]; linarith
  have hapne : ap ≠ 1 / 2 - ap := by rw [hapdef]; intro h; linarith
  have hC : C = fourOp e ap (1 / 2 - ap) (K / 4) b := rfl
  have hH : H = fourOp e (qv * (1 / 2 - ap) - gv * ap) (qv * ap - gv * (1 / 2 - ap)) (qv * K - gv * (K / 4))
      (qv * (4 * b) - gv * b) := rfl
  have hq : qv = 3 * ap * ap + 3 * (1 / 2 - ap) * (1 / 2 - ap) + (1 / 2) * (N - 4) * (N - 5) * (K / 4) * (K / 4)
      + 4 * (N - 4) * b * b := rfl
  have hg : gv = 3 * (1 / 2 - ap) * ap + 3 * ap * (1 / 2 - ap) + (1 / 2) * (N - 4) * (N - 5) * K * (K / 4)
      + 4 * (N - 4) * (4 * b) * b := rfl
  have hHC : innerOp2 H C = 0 := by
    rw [hH, hC, innerOp2_fourOp e he, hcard, hq, hg]; ring
  have hI : normSq2 (idOp : CurvOp2 (Fin n)) = N * (N - 1) / 2 := by
    unfold normSq2; rw [idOp_eq_fourOp e he, innerOp2_fourOp e he, hcard]; ring
  have hCn : normSq2 C = (53 * N ^ 2 - 524 * N + 1296) * K ^ 2 / 64 := by
    unfold normSq2; rw [hC, innerOp2_fourOp e he, hcard]
    linear_combination 6 * h1 + (N - 4) * hb2 + (-3 * K * N / 4 + 15 * K / 4 - 3 / 4) * hK
  have gap : (53 * N ^ 2 - 524 * N + 1296) * K ^ 2 / 64 * (N - 2) ^ 2 - N * (N - 1) / 2
      = 3 * (N - 6) ^ 2 * (7 * N ^ 2 - 44 * N + 48) * K ^ 2 / 64 := by
    linear_combination (N * (N - 1) / 2 * (K * (N - 5) + 1)) * hK
  have key : Ftri C H H - (1 / 2) * normSq2 H
      = 9 * (53 * N ^ 2 - 524 * N + 1296) * (249 * N ^ 4 - 4840 * N ^ 3 + 34620 * N ^ 2 - 108000 * N + 123840)
        * K ^ 6 / 524288 := by
    rw [Ftri_pol' (show IsSelfAdjoint2 C from fourOp_sa e _ _ _ _) (show IsSelfAdjoint2 H from fourOp_sa e _ _ _ _), hH, hC, fourOp_smul e he, fourOp_add e he,
      fourOp_add e he, Ftri_fourOp e he, Ftri_fourOp e he, Ftri_fourOp e he]
    unfold normSq2
    rw [innerOp2_fourOp e he, hcard, hq, hg]
    linear_combination (45*K^4*N^4/512 - 405*K^4*N^3/256 + 5445*K^4*N^2/512 - 2025*K^4*N/64 + 1125*K^4/32 - 225*K^3*N^4*b^2/64 + 225*K^3*N^3*ap^2/32 - 225*K^3*N^3*ap/64 + 4275*K^3*N^3*b^2/64 + 45*K^3*N^3/32 - 3375*K^3*N^2*ap^2/32 + 3375*K^3*N^2*ap/64 - 15075*K^3*N^2*b^2/32 - 675*K^3*N^2/32 + 8325*K^3*N*ap^2/16 - 8325*K^3*N*ap/32 + 2925*K^3*N*b^2/2 + 1665*K^3*N/16 - 3375*K^3*ap^2/4 + 3375*K^3*ap/8 - 3375*K^3*b^2/2 - 675*K^3/4 + 855*K^2*N^3*b^2/32 - 405*K^2*N^2*ap^2/16 + 405*K^2*N^2*ap/32 - 11115*K^2*N^2*b^2/32 - 243*K^2*N^2/64 + 3645*K^2*N*ap^2/16 - 3645*K^2*N*ap/32 + 5985*K^2*N*b^2/4 + 2187*K^2*N/64 - 2025*K^2*ap^2/4 + 2025*K^2*ap/8 - 4275*K^2*b^2/2 - 1215*K^2/16 - 675*K*N^3*b^4 + 1350*K*N^2*ap^2*b^2 - 675*K*N^2*ap*b^2 + 8775*K*N^2*b^4 + 270*K*N^2*b^2 - 12150*K*N*ap^2*b^2 + 6075*K*N*ap*b^2 - 37800*K*N*b^4 - 2430*K*N*b^2 + 27000*K*ap^2*b^2 - 13500*K*ap*b^2 + 54000*K*b^4 + 5400*K*b^2 + 765*N^2*b^4 - 810*N*ap^2*b^2 + 405*N*ap*b^2 - 6120*N*b^4 - 27*N*b^2/2 + 3240*ap^2*b^2 - 54*ap^2 - 1620*ap*b^2 + 27*ap + 12240*b^4 + 54*b^2 - 27/4) * h1 + (3375*K^5*N^6/4096 - 89325*K^5*N^5/4096 + 491625*K^5*N^4/2048 - 720225*K^5*N^3/512 + 592425*K^5*N^2/128 - 259425*K^5*N/32 + 23625*K^5/4 - 12375*K^4*N^5/8192 + 132975*K^4*N^4/4096 - 285255*K^4*N^3/1024 + 305415*K^4*N^2/256 - 163215*K^4*N/64 + 17415*K^4/8 + 1125*K^3*N^5*b^2/64 - 24525*K^3*N^4*b^2/64 - 225*K^3*N^4/32 + 53325*K^3*N^3*b^2/16 + 4005*K^3*N^3/32 - 57825*K^3*N^2*b^2/4 - 1665*K^3*N^2/2 + 31275*K^3*N*b^2 + 4905*K^3*N/2 - 27000*K^3*b^2 - 2700*K^3 - 4005*K^2*N^4*b^2/128 + 8415*K^2*N^3*b^2/16 + 495*K^2*N^3/256 - 6615*K^2*N^2*b^2/2 - 405*K^2*N^2/16 + 9225*K^2*N*b^2 + 1755*K^2*N/16 - 9630*K^2*b^2 - 315*K^2/2 + 675*K*N^4*b^4/2 - 11475*K*N^3*b^4/2 - 135*K*N^3*b^2 + 36450*K*N^2*b^4 + 1755*K*N^2*b^2 + 27*K*N^2/2 - 102600*K*N*b^4 - 7560*K*N*b^2 - 243*K*N/2 + 108000*K*b^4 + 10800*K*b^2 + 270*K - 765*N^3*b^4/2 + 4590*N^2*b^4 - 45*N^2*b^2/4 - 18360*N*b^4 + 90*N*b^2 + 27*N/8 + 24480*b^4 - 180*b^2 - 27/2) * hb2 + (10125*K^6*N^6/262144 - 33075*K^6*N^5/32768 + 719325*K^6*N^4/65536 - 1041525*K^6*N^3/16384 + 847125*K^6*N^2/4096 - 366975*K^6*N/1024 + 33075*K^6/128 - 4239*K^5*N^5/16384 + 101457*K^5*N^4/16384 - 120411*K^5*N^3/2048 + 2266425*K^5*N^2/8192 - 660195*K^5*N/1024 + 304425*K^5/512 - 9639*K^4*N^4/16384 + 87291*K^4*N^3/8192 - 589149*K^4*N^2/8192 + 219285*K^4*N/1024 - 121365*K^4/512 - 63*K^3*N^3/128 + 3321*K^3*N^2/512 - 14409*K^3*N/512 + 2565*K^3/64 + 27*K^2*N^2/128 - 1107*K^2*N/512 + 351*K^2/64 + 27*K*N/128 - 135*K/128 + 27/128) * hK
  refine ⟨fourOp_sa e _ _ _ _, fourOp_pd e he _ _ _ _ hap0 ham0 (by positivity) hb0, ?_, ?_, hCn,
    by rw [hCn, hI]; exact gap, fourOp_sa e _ _ _ _, hHC, key, ?_, ?_⟩
  · -- idempotent
    show sharpMapCL C = C
    rw [hC, sharp_fourOp e he, hcard]
    have c1 : 2 * ap ^ 2 + (N - 4) * b ^ 2 = ap := by linear_combination 2 * h1
    have c2 : 2 * (1 / 2 - ap) ^ 2 + (N - 4) * b ^ 2 = 1 / 2 - ap := by linear_combination 2 * h1
    have c3 : (N - 6) * (K / 4) ^ 2 + 4 * b ^ 2 = K / 4 := by linear_combination 4 * hb2 + (K / 4) * hK
    have c4 : 3 * ((ap + (1 / 2 - ap)) / 2) * b + (N - 5) * b * (K / 4) = b := by
      linear_combination (b / 4) * hK
    rw [c1, c2, c3, c4]
  · -- other than I/(n - 2)
    intro h
    have hval : ∀ s : Bool, (if s then ap else 1 / 2 - ap) = 1 / ((n : ℝ) - 2) := by
      intro s
      have h' := congrArg (fun T : CurvOp2 (Fin n) => inner2 ((T (omS e s 0) : skewSub (Fin n)) :
        Matrix (Fin n) (Fin n) ℝ) ((omS e s 0 : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) h
      simp only [hC, fourOp_omS e he, ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply,
        Submodule.coe_smul, i2_smul_l, omS_inner e he, and_self, if_true, mul_one] at h'
      exact h'
    have ht := hval true
    have hf := hval false
    simp only [if_true, Bool.false_eq_true, if_false] at ht hf
    exact hapne (ht.trans hf.symm)
  · -- unstable
    have hpoly : 0 < 249 * N ^ 4 - 4840 * N ^ 3 + 34620 * N ^ 2 - 108000 * N + 123840 := by
      have hm : 0 ≤ N - 7 := by linarith
      have e1 : 249 * N ^ 4 - 4840 * N ^ 3 + 34620 * N ^ 2 - 108000 * N + 123840
          = 249 * (N - 7) ^ 4 + 2132 * (N - 7) ^ 3 + 6186 * (N - 7) ^ 2 + 6828 * (N - 7) + 1949 := by ring
      rw [e1]; positivity
    have hq53 : 0 < 53 * N ^ 2 - 524 * N + 1296 := by
      have e5 : 53 * N ^ 2 - 524 * N + 1296 = 53 * (N - 7) ^ 2 + 218 * (N - 7) + 225 := by ring
      rw [e5]; have : 0 ≤ N - 7 := by linarith
      positivity
    have hT : 0 < 9 * (53 * N ^ 2 - 524 * N + 1296) * (249 * N ^ 4 - 4840 * N ^ 3 + 34620 * N ^ 2 - 108000 * N + 123840)
        * K ^ 6 / 524288 := by positivity
    intro hst
    have := hst H (fourOp_sa e _ _ _ _) hHC
    linarith only [this, key, hT]
  · -- heavier than I/(n - 2)
    have hn2 : ((n : ℝ) - 2) = N - 2 := by rw [hNdef]
    rw [hI, hCn, hn2, div_lt_iff₀ (pow_pos (by linarith) 2)]
    have hpos : 0 < 3 * (N - 6) ^ 2 * (7 * N ^ 2 - 44 * N + 48) * K ^ 2 / 64 := by
      have h7 : 0 < 7 * N ^ 2 - 44 * N + 48 := by
        have e7 : 7 * N ^ 2 - 44 * N + 48 = 7 * (N - 7) ^ 2 + 54 * (N - 7) + 83 := by ring
        rw [e7]; have : 0 ≤ N - 7 := by linarith
        positivity
      have h6 : 0 < (N - 6) ^ 2 := pow_pos (by linarith) 2
      have hK2 : 0 < K ^ 2 := pow_pos hK0 2
      have : 0 < 3 * (N - 6) ^ 2 * (7 * N ^ 2 - 44 * N + 48) * K ^ 2 := by
        apply mul_pos (mul_pos (mul_pos (by norm_num) h6) h7) hK2
      linarith
    linarith only [gap, hpos]

end FourBlock3


/-- **L267.** For every `n ≥ 7`, `𝔰𝔬(n)` carries a positive definite `#`-idempotent other than `I/(n - 2)`, unstable
and heavier than it; the member, its norm, the gap and the destabilising direction are `L267_member`'s. -/
theorem L267_U_fails (n : ℕ) (hn : 7 ≤ n) :
    ∃ C : CurvOp2 (Fin n), IsSelfAdjoint2 C ∧ IsPD2 C ∧ IsIdem C ∧ C ≠ (1 / ((n : ℝ) - 2)) • idOp ∧
      ¬ IsStable C ∧ normSq2 (idOp : CurvOp2 (Fin n)) / ((n : ℝ) - 2) ^ 2 < normSq2 C := by
  obtain ⟨h1, h2, h3, h4, -, -, -, -, -, h5, h6⟩ := L267_member n hn _ _ _ _ _ rfl rfl rfl rfl rfl
  exact ⟨_, h1, h2, h3, h4, h5, h6⟩

end HamiltonsCubic.I117S
