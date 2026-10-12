import HamiltonsCubic.Results.L127Le
import HamiltonsCubic.Results.L122Statement
import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.L24Eigen
import HamiltonsCubic.Results.L122Weyl

set_option linter.style.longLine false

/-!
# L122's cap from L24: the pair-block bound at every coordinate-diagonal maximiser

[findings/second-order.md](../../../findings/second-order.md), Lemma L122: at every coordinate-diagonal maximiser,
`λ_min(Δ^{(jk)}|_{𝟙^⊥}) ≥ −(θ + M_{jk})`. [L122Statement.lean](L122Statement.lean)'s `lambda_min_bound` derives it
from the cap `hcap`, `quadS (Lb M j k) x ≤ (θ/2) nrmS x` on the Ricci cut. This file derives `hcap` from
[L24Weyl.lean](L24Weyl.lean)'s `L24_weyl` at a unit diagonal Weyl maximiser `M = diagOp w`, on `Fin n`:

* **`foxProd_pairVec`**: `M ∘ ∑ c_i f_i = ∑_m (Lb c)_m f_m`, the pair block of `M ∘` in the basis `f_i` is the matrix
  `Lb`, at a symmetric hollow `w` (the record's bracketed form, diagonality alone);
* **`innerOp_pairVec`**: `⟨∑ κ_i f_i, ∑ c_i f_i⟩ = 2 ∑ κ_i c_i`, the basis `f_i` orthogonal of common norm `√2`;
* **`innerOp_diag_pairVec`**: a pair vector is orthogonal to `diagOp w`;
* **`hcap_of_max`**: at a unit, critical, diagonal Weyl `M` locally maximising `P` on the Weyl sphere with `θ = P(M) > 0`,
  `quadS (Lb w j k) c ≤ (θ/2) nrmS c` on the Ricci cut, by `L24_weyl` applied to the normalised pair vector;
* **`L122_lambda_min_of_max`**: L122's spectral condition `λ_min(Δ^{(jk)}|_{𝟙^⊥}) ≥ −(θ + M_{jk})` at every such
  maximiser, `lambda_min_bound` with its cap discharged;
* **`orbitTan_within_zero`**: the record's consequence that within-factor pair blocks carry no orbit direction, the orbit
  tangent vanishing when `w_{ji} = w_{ki}` for every `i ∉ {j, k}`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge
open HamiltonsCubic.L122Statement (Sset mem_Sset Lb quadS nrmS OnCut Kirch lambda_min_bound)

variable {n : ℕ}

theorem filter_eq_Sset (j k : Fin n) : univ.filter (fun i => j ≠ i ∧ k ≠ i) = Sset j k := by
  ext i
  rw [Finset.mem_filter, mem_Sset]
  constructor
  · rintro ⟨_, h1, h2⟩; exact ⟨Ne.symm h1, Ne.symm h2⟩
  · rintro ⟨h1, h2⟩; exact ⟨Finset.mem_univ _, Ne.symm h1, Ne.symm h2⟩

theorem rk2_zero_right' (U X : Matrix (Fin n) (Fin n) ℝ) : rk2 U 0 X = 0 := by
  unfold rk2; simp [inner2]

/-- **The pair block of `M ∘` is the matrix `Lb`**: at a symmetric hollow `w`, `j ≠ k` and a skew `X`,
`M ∘ ∑_i c_i f_i = ∑_m (∑_i Lb_{mi} c_i) f_m`. -/
theorem foxProd_pairVec {w : Matrix (Fin n) (Fin n) ℝ} (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0)
    {j k : Fin n} (hjk : j ≠ k) (c : Fin n → ℝ) {X : Matrix (Fin n) (Fin n) ℝ} (hX : IsSkew X) :
    foxProd (diagOp w) (pairVec j k c) X = pairVec j k (fun m => ∑ i ∈ Sset j k, Lb w j k m i * c i) X := by
  set s := univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  have hS : Sset j k = s := (filter_eq_Sset j k).symm
  unfold pairVec
  rw [← hsdef, pair_invariant w hw hh hjk s hs c hX, hS]
  -- the sum over `q` runs over `s`, since `f_j = f_k = 0`
  have hq : ∀ i, ∑ q, w i q • rk2 (phi j q) (phi k q) X = ∑ q ∈ s, w i q • rk2 (phi j q) (phi k q) X := by
    intro i
    rw [← Finset.sum_filter_add_sum_filter_not univ (fun q => j ≠ q ∧ k ≠ q), ← hsdef]
    have e : (univ : Finset (Fin n)).filter (fun q => ¬ (j ≠ q ∧ k ≠ q)) = {j, k} := by
      ext q; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert, Finset.mem_singleton]
      constructor
      · intro h; by_contra hc; push Not at hc; exact h ⟨Ne.symm hc.1, Ne.symm hc.2⟩
      · rintro (rfl | rfl) ⟨h1, h2⟩ <;> simp_all
    rw [e, Finset.sum_pair hjk, phi_self, rk2_zero_left, phi_self, rk2_zero_right', smul_zero, smul_zero, add_zero,
      add_zero]
  simp only [hq]
  -- the coefficient of `f_m`
  have hcoef : ∀ m ∈ s, ∑ i ∈ s, Lb w j k m i * c i
      = (1 / 2) * (w j m + w k m - w j k) * c m + ∑ i ∈ s, (1 / 2) * w i m * c i := by
    intro m hm
    have t : ∀ i, Lb w j k m i * c i
        = (if m = i then (1 / 2) * (w j m + w k m - w j k) * c m else 0) + (1 / 2) * w i m * c i := by
      intro i
      by_cases h : m = i
      · subst h; simp [Lb, hh]
      · simp only [Lb, if_neg h, zero_add]; rw [hw m i]
    rw [Finset.sum_congr rfl (fun i _ => t i), Finset.sum_add_distrib, Finset.sum_ite_eq, if_pos hm]
  have hR : ∑ m ∈ s, (∑ i ∈ s, Lb w j k m i * c i) • rk2 (phi j m) (phi k m) X
      = ∑ m ∈ s, ((1 / 2) * (w j m + w k m - w j k) * c m + ∑ i ∈ s, (1 / 2) * w i m * c i)
          • rk2 (phi j m) (phi k m) X :=
    Finset.sum_congr rfl fun m hm => by rw [hcoef m hm]
  rw [hR]
  simp only [smul_add, Finset.smul_sum, smul_smul, add_smul, Finset.sum_add_distrib, Finset.sum_smul]
  congr 1
  · exact Finset.sum_congr rfl fun i _ => by congr 1; ring
  · rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun i _ => by congr 1; ring

/-- `innerOp` is linear in its second argument over a finite sum. -/
theorem innerOp_sum_right (F : CurvOp (Fin n)) (s : Finset (Fin n)) (d : Fin n → ℝ) (G : Fin n → CurvOp (Fin n)) :
    innerOp F (fun Y => ∑ i ∈ s, d i • G i Y) = ∑ i ∈ s, d i * innerOp F (G i) := by
  unfold innerOp
  simp only [inner2_sum_right, ip_smul_r, Finset.mul_sum]
  conv_rhs => rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun i _ => by ring

/-- The pair vector evaluated at `φ_{ki}`, `i ∈ s`, is `κ_i φ_{ji}`. -/
theorem pairVec_phi_k {j k : Fin n} (hjk : j ≠ k) (κ : Fin n → ℝ) {q : Fin n}
    (hq : q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i)) : pairVec j k κ (phi k q) = κ q • phi j q := by
  unfold pairVec
  have hs' : ∀ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), k ≠ i ∧ j ≠ i :=
    fun i hi => ⟨(Finset.mem_filter.mp hi).2.2, (Finset.mem_filter.mp hi).2.1⟩
  rw [Finset.sum_congr rfl (fun i _ => by rw [rk2_comm])]
  exact pair_eval (Ne.symm hjk) _ hs' κ hq

/-- **The pair basis is orthogonal of common norm `√2`**: `⟨∑ κ_i f_i, ∑ c_i f_i⟩ = 2 ∑ κ_i c_i`. -/
theorem innerOp_pairVec {j k : Fin n} (hjk : j ≠ k) (κ c : Fin n → ℝ) :
    innerOp (pairVec j k κ) (pairVec j k c) = 2 * ∑ i ∈ Sset j k, κ i * c i := by
  set s := univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  rw [show pairVec j k c = fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y from rfl, innerOp_sum_right,
    ← filter_eq_Sset, ← hsdef, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i hi => ?_
  obtain ⟨hji, hki⟩ := hs i hi
  rw [innerOp_rk2 _ (pairVec_lin j k κ) (phi_isSkew j i) (phi_isSkew k i), pairVec_phi_k hjk κ hi]
  have e2 : pairVec j k κ (phi j i) = κ i • phi k i := pair_eval hjk s hs κ hi
  rw [e2, ip_smul_l, ip_smul_l, inner2_phi_phi, inner2_phi_phi]
  simp [hji, hki, Ne.symm hji, Ne.symm hki]
  ring

/-- **A pair vector is orthogonal to the diagonal operator.** -/
theorem innerOp_diag_pairVec {w : Matrix (Fin n) (Fin n) ℝ} (hw : ∀ p q, w p q = w q p) {j k : Fin n} (hjk : j ≠ k)
    (c : Fin n → ℝ) : innerOp (diagOp w) (pairVec j k c) = 0 := by
  set s := univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  rw [show pairVec j k c = fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y from rfl, innerOp_sum_right]
  refine Finset.sum_eq_zero fun i hi => ?_
  obtain ⟨hji, hki⟩ := hs i hi
  rw [innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew j i) (phi_isSkew k i), diagOp_phi w hw, diagOp_phi w hw,
    ip_smul_l, ip_smul_l, inner2_phi_phi, inner2_phi_phi]
  simp [hjk, Ne.symm hjk, hji, hki, Ne.symm hji, Ne.symm hki]

/-- `innerOp2` on two restricted operators is the bare `innerOp`. -/
theorem innerOp2_restrictLin {F G : CurvOp (Fin n)} (hF : IsLinOp F) (hFs : ∀ X, IsSkew X → IsSkew (F X))
    (hG : IsLinOp G) (hGs : ∀ X, IsSkew X → IsSkew (G X)) :
    innerOp2 (restrictLin hF hFs) (restrictLin hG hGs) = innerOp F G := rfl

/-- **L122's cap, from L24.** At a unit, critical diagonal Weyl operator `M = diagOp w` that locally maximises `P` on the
Weyl sphere with `θ = P(M) > 0`, the pair block's quadratic form on the Ricci cut is at most `θ/2` times the norm. -/
theorem hcap_of_max {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {lam : ℝ}
    (ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1)
    (hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = lam • restrict (diagOp_isWeyl hwt))
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 (Fin n) | normSq2 R = 1 ∧ IsWeyl2 R} (restrict (diagOp_isWeyl hwt)))
    (hθ : 0 < Pcubic2 (restrict (diagOp_isWeyl hwt))) {j k : Fin n} (hjk : j ≠ k) (c : Fin n → ℝ)
    (hc : OnCut j k c) :
    quadS (Lb w j k) j k c ≤ (Pcubic2 (restrict (diagOp_isWeyl hwt)) / 2) * nrmS j k c := by
  set hW := diagOp_isWeyl hwt
  set a := restrict hW
  set θ := Pcubic2 a
  set s := univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  have hsum : ∑ i ∈ s, c i = 0 := by rw [hsdef, filter_eq_Sset]; exact hc
  set v := restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)
  have hWv : IsWeyl2 v := by
    have h := isWeyl2_restrict (pairSpan_isWeyl hjk s hs c hsum)
    have e : v = restrict (pairSpan_isWeyl hjk s hs c hsum) := ContinuousLinearMap.ext fun _ => rfl
    rw [e]; exact h
  have hWa : IsWeyl2 a := isWeyl2_restrict hW
  -- `v ⊥ M`
  have hperp : innerOp2 a v = 0 := by
    rw [← innerOp_extend]
    have e : innerOp (extend a) (extend v) = innerOp (diagOp w) (pairVec j k c) := by
      unfold innerOp
      refine congrArg _ (Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_)
      rw [extend_restrict_on_skew hW _ (phi_isSkew x y),
        extend_restrictLin_on_skew (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X) _ (phi_isSkew x y)]
    rw [e, innerOp_diag_pairVec hwt.symm hjk c]
  -- `⟨M, Q(v)⟩ = 2 quadS` and `‖v‖² = 2 nrmS`
  set κ : Fin n → ℝ := fun m => ∑ i ∈ Sset j k, Lb w j k m i * c i
  have hQ : innerOp2 a (Qop2 v) = 2 * quadS (Lb w j k) j k c := by
    rw [← innerOp2_foxProd2_self hWa.isSelfAdjoint2 hWv.isSelfAdjoint2]
    have e : innerOp2 (foxProd2 a v) v = innerOp (pairVec j k κ) (pairVec j k c) := by
      unfold innerOp2 innerOp
      refine congrArg _ (Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_)
      simp only [applyPhi]
      rw [bridge_apply hW (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X),
        foxProd_pairVec hwt.symm hwt.hollow hjk c (phi_isSkew x y)]
      rfl
    rw [e, innerOp_pairVec hjk]
    unfold quadS
    congr 1
    refine Finset.sum_congr rfl fun i _ => ?_
    simp only [κ, Finset.sum_mul]
    exact Finset.sum_congr rfl fun m _ => by ring
  have hN : normSq2 v = 2 * nrmS j k c := by
    unfold normSq2
    rw [innerOp2_restrictLin, innerOp_pairVec hjk]; rfl
  -- apply L24 to the normalised `v`
  by_cases h0 : nrmS j k c = 0
  · have hz : ∀ i ∈ Sset j k, c i = 0 := by
      intro i hi
      have := (Finset.sum_eq_zero_iff_of_nonneg (fun m _ => mul_self_nonneg (c m))).mp h0 i hi
      exact mul_self_eq_zero.mp this
    have : quadS (Lb w j k) j k c = 0 := by
      unfold quadS
      exact Finset.sum_eq_zero fun i hi => by rw [hz i hi]; simp
    rw [this, h0, mul_zero]
  · have hpos : 0 < nrmS j k c :=
      lt_of_le_of_ne (Finset.sum_nonneg fun m _ => mul_self_nonneg (c m)) (Ne.symm h0)
    set r := (Real.sqrt (2 * nrmS j k c))⁻¹
    have hr2 : r ^ 2 = (2 * nrmS j k c)⁻¹ := by
      rw [inv_pow, Real.sq_sqrt (by linarith)]
    have h1 : normSq2 (r • v) = 1 := by
      rw [normSq2_smul, hr2, hN, inv_mul_cancel₀ (by linarith)]
    have hperp' : innerOp2 a (r • v) = 0 := by rw [innerOp2_smul_right, hperp, mul_zero]
    have hL := L24_weyl ha hWa hcrit hmax hθ (isWeyl2_smul r hWv) hperp' h1
    rw [Qop2_smul, innerOp2_smul_right, hr2, hQ] at hL
    have hpos2 : 0 < 2 * nrmS j k c := by linarith
    rw [inv_mul_le_iff₀ hpos2] at hL
    nlinarith

/-- **L122's spectral condition, unconditional at a maximiser**: at a unit, critical diagonal Weyl `M = diagOp w`
locally maximising `P` on the Weyl sphere with `θ = P(M) > 0`, the Kirchhoff matrix's Rayleigh quotient on the Ricci
cut is at least `−(θ + M_{jk})`, which is `λ_min(Δ^{(jk)}|_{𝟙^⊥}) ≥ −(θ + M_{jk})`. -/
theorem L122_lambda_min_of_max {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {lam : ℝ}
    (ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1)
    (hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = lam • restrict (diagOp_isWeyl hwt))
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 (Fin n) | normSq2 R = 1 ∧ IsWeyl2 R} (restrict (diagOp_isWeyl hwt)))
    (hθ : 0 < Pcubic2 (restrict (diagOp_isWeyl hwt))) {j k : Fin n} (hjk : j ≠ k) (x : Fin n → ℝ)
    (hx : OnCut j k x) :
    -(Pcubic2 (restrict (diagOp_isWeyl hwt)) + w j k) * nrmS j k x ≤ quadS (Kirch w j k) j k x :=
  lambda_min_bound w j k _ hjk hwt.symm (fun i _ => hwt.rowSum i)
    (fun y hy => hcap_of_max hwt ha hcrit hmax hθ hjk y hy) x hx

/-- **Within-factor pair blocks carry no orbit direction**: when `w_{ji} = w_{ki}` for every `i ≠ j, k` (as for `j, k` in the
same factor of a sphere product), the orbit tangent `[φ_{jk}, M]` vanishes on every bivector, the terms at `i = j, k`
vanishing through `φ_{ii} = 0` (r1848 O3). -/
theorem orbitTan_within_zero {ι : Type*} [Fintype ι] [DecidableEq ι] (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p)
    (hh : ∀ a, w a a = 0) {j k : ι} (hjk : j ≠ k) (hwk : ∀ i, i ≠ j → i ≠ k → w j i = w k i) {X : Matrix ι ι ℝ}
    (hX : IsSkew X) : orbitTan (diagOp w) j k X = 0 := by
  rw [orbit_in_pairBlock w hw hh hjk hX]
  refine Finset.sum_eq_zero fun i _ => ?_
  by_cases hij : i = j
  · subst hij; rw [phi_self, rk2_zero_left, smul_zero]
  · by_cases hik : i = k
    · subst hik; rw [phi_self, rk2_comm, rk2_zero_left, smul_zero]
    · rw [hwk i hij hik, sub_self, zero_smul]

end HamiltonsCubic.L126Assembly
