import HamiltonsCubic.Results.L126Final
import HamiltonsCubic.Results.L68Statement

set_option linter.style.longLine false

/-!
# L126's `DF(M)` at the sphere product: criticality, self-adjointness and orthogonality to `M` discharged

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *"On the tangent space the criticality map
`F(W) = Q(W) − P(W)W` has `DF(M) = θ(2L_e − Id)`"*, at a diagonal critical point `M`. [L126Final.lean](L126Final.lean)
proves the algebraic kernel clause, and [r1600](../../../reviews/REVIEW_r1600.md) named the three hypotheses of
`critMap_hasDerivAt` owed at the sphere product. This file supplies them:

* **`sphere_offdiag`**, **`sphere_diagCrit`**, **`sphere_isCritical`**: the sphere weight satisfies
  `w_ab² + (w²)_ab = (n − 1) w_ab` off the diagonal, so `t · sphereWeight T` is diagonally critical with multiplier
  `t(n − 1)` and the operator is critical;
* **`rk2_symm`**, **`innerOp_lin3`**: `U ⊙ V` is self-adjoint, and the pairing is linear in its second slot;
* **`split_DF`**: on `Fin n` at a unit sphere product and a `(2,2)`-split, `M` is critical on `CurvOp2`
  (`isCritical2_of_extend`), the Bianchi vector `v` is self-adjoint and `⟨M, v⟩ = 0`, so the derivative of `F` along
  `M + s v` is `2M∘v − P(M)v`, which vanishes exactly when `(p,q) = (3,3)`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A sphere weight inside `S` is `α` off the diagonal and `0` on it. -/
theorem sw_in (S : Finset ι) {a c : ι} (ha : a ∈ S) (hc : c ∈ S) :
    sphereWeight S a c = (Sᶜ.card : ℝ) / ((S.card : ℝ) - 1) - (if c = a then (Sᶜ.card : ℝ) / ((S.card : ℝ) - 1) else 0) := by
  by_cases h : c = a
  · subst h; simp [sphereWeight]
  · rw [sphereWeight_in S ha hc (Ne.symm h), if_neg h, sub_zero]

theorem sw_out (S : Finset ι) {a c : ι} (ha : a ∉ S) (hc : c ∉ S) :
    sphereWeight S a c = (S.card : ℝ) / ((Sᶜ.card : ℝ) - 1) - (if c = a then (S.card : ℝ) / ((Sᶜ.card : ℝ) - 1) else 0) := by
  by_cases h : c = a
  · subst h; simp [sphereWeight]
  · rw [sphereWeight_out S ha hc (Ne.symm h), if_neg h, sub_zero]

/-- **The sphere weight satisfies the diagonal criticality identity** with multiplier `n − 1`. -/
theorem sphere_offdiag (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) {a b : ι} (hab : a ≠ b) :
    sphereWeight S a b ^ 2 + (sphereWeight S * sphereWeight S) a b
      = ((S.card : ℝ) + Sᶜ.card - 1) * sphereWeight S a b := by
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : (S.card : ℝ) - 1 ≠ 0 := by linarith
  have hq1 : (Sᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  set α := (Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)
  set β := (S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)
  rw [Matrix.mul_apply, ← Finset.sum_add_sum_compl S]
  by_cases ha : a ∈ S <;> by_cases hb : b ∈ S
  · -- both inside
    have h1 : ∀ c ∈ S, sphereWeight S a c * sphereWeight S c b
        = α ^ 2 - (if c = a then α ^ 2 else 0) - (if c = b then α ^ 2 else 0) := by
      intro c hc
      rw [sw_in S ha hc, sphereWeight_symm S c b, sw_in S hb hc]
      by_cases hca : c = a
      · subst hca; simp [hab]
      · by_cases hcb : c = b
        · subst hcb; simp [hca]
        · simp [hca, hcb]; ring
    have h2 : ∀ c ∈ Sᶜ, sphereWeight S a c * sphereWeight S c b = 1 := by
      intro c hc
      rw [sphereWeight_cross S ha (Finset.mem_compl.mp hc), sphereWeight_symm S c b,
        sphereWeight_cross S hb (Finset.mem_compl.mp hc)]; norm_num
    rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, Finset.sum_sub_distrib, Finset.sum_sub_distrib,
      Finset.sum_const, Finset.sum_ite_eq' S a, Finset.sum_ite_eq' S b, if_pos ha, if_pos hb, Finset.sum_const,
      nsmul_eq_mul, nsmul_eq_mul, sphereWeight_in S ha hb hab]
    simp only [α]; field_simp; ring
  · -- a inside, b outside
    have h1 : ∀ c ∈ S, sphereWeight S a c * sphereWeight S c b = -(α - (if c = a then α else 0)) := by
      intro c hc
      rw [sw_in S ha hc, sphereWeight_cross S hc hb]; ring
    have h2 : ∀ c ∈ Sᶜ, sphereWeight S a c * sphereWeight S c b = -(β - (if c = b then β else 0)) := by
      intro c hc
      rw [sphereWeight_cross S ha (Finset.mem_compl.mp hc), sw_out S (Finset.mem_compl.mp hc) hb]
      by_cases hcb : c = b
      · subst hcb; simp
      · rw [if_neg hcb, if_neg (Ne.symm hcb)]; ring
    rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, Finset.sum_neg_distrib, Finset.sum_neg_distrib,
      Finset.sum_sub_distrib, Finset.sum_sub_distrib, Finset.sum_const, Finset.sum_const, Finset.sum_ite_eq' S a,
      Finset.sum_ite_eq' Sᶜ b, if_pos ha, if_pos (Finset.mem_compl.mpr hb), nsmul_eq_mul, nsmul_eq_mul,
      sphereWeight_cross S ha hb]
    simp only [α, β]; field_simp; ring
  · -- a outside, b inside
    have h1 : ∀ c ∈ S, sphereWeight S a c * sphereWeight S c b = -(α - (if c = b then α else 0)) := by
      intro c hc
      rw [sphereWeight_symm S a c, sphereWeight_cross S hc ha, sphereWeight_symm S c b, sw_in S hb hc]
      by_cases hcb : c = b
      · subst hcb; simp
      · simp [hcb, α]
    have h2 : ∀ c ∈ Sᶜ, sphereWeight S a c * sphereWeight S c b = -(β - (if c = a then β else 0)) := by
      intro c hc
      rw [sw_out S ha (Finset.mem_compl.mp hc), sphereWeight_symm S c b, sphereWeight_cross S hb (Finset.mem_compl.mp hc)]
      ring
    rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, Finset.sum_neg_distrib, Finset.sum_neg_distrib,
      Finset.sum_sub_distrib, Finset.sum_sub_distrib, Finset.sum_const, Finset.sum_const, Finset.sum_ite_eq' S b,
      Finset.sum_ite_eq' Sᶜ a, if_pos hb, if_pos (Finset.mem_compl.mpr ha), nsmul_eq_mul, nsmul_eq_mul,
      sphereWeight_symm S a b, sphereWeight_cross S hb ha]
    simp only [α, β]; field_simp; ring
  · -- both outside
    have h1 : ∀ c ∈ S, sphereWeight S a c * sphereWeight S c b = 1 := by
      intro c hc
      rw [sphereWeight_symm S a c, sphereWeight_cross S hc ha, sphereWeight_cross S hc hb]; norm_num
    have h2 : ∀ c ∈ Sᶜ, sphereWeight S a c * sphereWeight S c b
        = β ^ 2 - (if c = a then β ^ 2 else 0) - (if c = b then β ^ 2 else 0) := by
      intro c hc
      have hc' := Finset.mem_compl.mp hc
      rw [sw_out S ha hc', sphereWeight_symm S c b, sw_out S hb hc']
      by_cases hca : c = a
      · subst hca; simp [hab]
      · by_cases hcb : c = b
        · subst hcb; simp [hca]
        · simp [hca, hcb]; ring
    rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, Finset.sum_sub_distrib, Finset.sum_sub_distrib,
      Finset.sum_const, Finset.sum_ite_eq' Sᶜ a, Finset.sum_ite_eq' Sᶜ b, if_pos (Finset.mem_compl.mpr ha),
      if_pos (Finset.mem_compl.mpr hb), Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul, sphereWeight_out S ha hb hab]
    simp only [β]; field_simp; ring

/-- **The unit sphere product is diagonally critical** with multiplier `t(n − 1)`. -/
theorem sphere_diagCrit (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ) :
    HamiltonsCubic.L68Statement.IsDiagCritical (t • sphereWeight S) (t * ((S.card : ℝ) + Sᶜ.card - 1)) := by
  refine ⟨fun a b => by simp only [Matrix.smul_apply, sphereWeight_symm], fun a => by simp [sphereWeight],
    fun a b hab => ?_⟩
  have h := sphere_offdiag S hp hq hab
  simp only [Matrix.smul_apply, smul_eq_mul, Matrix.smul_mul, Matrix.mul_smul] at h ⊢
  linear_combination t ^ 2 * h

/-- **The sphere product is critical as an operator**, `Q(M) = t(n − 1) M` on basis bivectors. -/
theorem sphere_isCritical (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ) :
    IsCritical (diagOp (t • sphereWeight S)) (t * ((S.card : ℝ) + Sᶜ.card - 1)) :=
  HamiltonsCubic.L68Statement.isCritical_srg_form_uncond ((sphereWeight_isWeight S hp hq).smul t)
    (sphere_diagCrit S hp hq t)

end HamiltonsCubic.L126Assembly

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge

variable {n : ℕ}

theorem rk2_symm (U V X Y : Matrix (Fin n) (Fin n) ℝ) : inner2 (rk2 U V X) Y = inner2 X (rk2 U V Y) := by
  unfold rk2; simp only [ip_add_l, ip_add_r, ip_smul_l, ip_smul_r]; rw [inner2_comm X U, inner2_comm X V]; ring

theorem innerOp_lin3 (F G H K : CurvOp (Fin n)) (x y z : ℝ) :
    innerOp F (fun Y => x • G Y + y • H Y + z • K Y) = x * innerOp F G + y * innerOp F H + z * innerOp F K := by
  unfold innerOp
  have e : ∀ a b : Fin n, inner2 (F (phi a b)) (x • G (phi a b) + y • H (phi a b) + z • K (phi a b))
      = x * inner2 (F (phi a b)) (G (phi a b)) + y * inner2 (F (phi a b)) (H (phi a b))
        + z * inner2 (F (phi a b)) (K (phi a b)) := fun a b => by simp only [ip_add_r, ip_smul_r]
  simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum]
  ring

/-- **`DF(M)` AT THE `(2,2)` BIANCHI VECTOR, WITH ITS HYPOTHESES DISCHARGED**: at a unit sphere product on `Fin n` and a
`(2,2)`-split, `M` is critical on `CurvOp2`, `v` is self-adjoint and orthogonal to `M` (the first conjunct), so
`critMap_hasDerivAt` applies, and
the derivative `2M∘v − P(M)v` vanishes exactly when `(p,q) = (3,3)`. -/
theorem split_DF (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {i j k l : Fin n} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T)
    (hl : l ∉ T) (hij : i ≠ j) (hkl : k ≠ l) :
    let hW : IsWeyl (diagOp (t • sphereWeight T)) := diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)
    let M := restrict hW
    let v := restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X)
    innerOp2 M v = 0 ∧ (∀ Z : CurvOp2 (Fin n), HasDerivAt (fun s : ℝ => innerOp2 Z (critMap (M + s • v)))
        (innerOp2 Z ((2 : ℝ) • foxProd2 M v - Pcubic2 M • v)) 0)
      ∧ ((2 : ℝ) • foxProd2 M v - Pcubic2 M • v = 0 ↔ T.card = 3 ∧ Tᶜ.card = 3) := by
  intro hW M v
  have hik : i ≠ k := fun h => hk (h ▸ hi)
  have hil : i ≠ l := fun h => hl (h ▸ hi)
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hjl : j ≠ l := fun h => hl (h ▸ hj)
  set w := t • sphereWeight T
  set th := t * ((T.card : ℝ) + Tᶜ.card - 1)
  -- criticality on `CurvOp2`
  have hcritE : IsCritical (extend M) th := by
    intro a b
    have hs := phi_isSkew a b
    rw [Qop_congr_on_skew (fun Z _ => extend_restrict_isSkew hW Z) (fun Z hZ => extend_restrict_on_skew hW Z hZ) _ hs,
      extend_restrict_on_skew hW _ hs]
    exact sphere_isCritical T hp hq t a b
  have hcrit : Qop2 M = th • M := isCritical2_of_extend hcritE
  -- `v` self-adjoint
  have hsa : IsSelfAdjoint2 v := by
    intro X Y
    change inner2 (splitVec i j k l X) Y = inner2 (X : Matrix (Fin n) (Fin n) ℝ) (splitVec i j k l Y)
    unfold splitVec
    simp only [ip_add_l, ip_add_r, ip_smul_l, ip_smul_r, rk2_symm]
  -- `v` orthogonal to `M`
  have hperp : innerOp2 M v = 0 := by
    rw [← innerOp_extend]
    have e : innerOp (extend M) (extend v) = innerOp (diagOp w) (splitVec i j k l) := by
      unfold innerOp
      refine congrArg _ (Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_)
      rw [extend_restrict_on_skew hW _ (phi_isSkew a b),
        extend_restrictLin_on_skew (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X) _ (phi_isSkew a b)]
    rw [e]
    have hsplit : splitVec i j k l = fun Y => (2 : ℝ) • rk2 (phi i j) (phi k l) Y + (-1 : ℝ) • rk2 (phi k i) (phi j l) Y
        + (-1 : ℝ) • rk2 (phi i l) (phi j k) Y := rfl
    have hw : ∀ p q, w p q = w q p := fun p q => by simp only [w, Matrix.smul_apply, sphereWeight_symm]
    rw [hsplit, innerOp_lin3,
      innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew i j) (phi_isSkew k l),
      innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew k i) (phi_isSkew j l),
      innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew i l) (phi_isSkew j k)]
    simp only [diagOp_phi w hw, ip_smul_l, inner2_phi_phi]
    simp [hij, hik, hil, hjk, hjl, hkl, hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, hkl.symm]
  exact ⟨hperp, fun Z => critMap_hasDerivAt (isSelfAdjoint2_restrict hW) hsa hcrit hperp Z,
    split_kernel_iff T hp hq t ht hn hi hj hk hl hij hkl⟩

end HamiltonsCubic.L126Assembly
