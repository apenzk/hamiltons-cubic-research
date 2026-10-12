import Mathlib
import HamiltonsCubic.Results.L217Gen
import HamiltonsCubic.Results.L217Orbit
import HamiltonsCubic.Results.L143Attain
import HamiltonsCubic.Results.L216Unbal

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L216 at every gapped critical orbit: no other critical point within `r = 4θγ/(9M)` of the orbit

[findings/second-order.md](../../../findings/second-order.md), Lemma L216: *Let $W_0$ be a unit critical point of $P$ with
$\theta_0=P(W_0)>0$ and $e=W_0/\theta_0$, and suppose that $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp W_0$ orthogonal
to the orbit tangent $T_{W_0}\mathcal O$, with $\gamma>0$. Then no critical point of $P$ on the unit sphere of $\mathcal W_n$ lies within
geodesic distance $r=\frac{4\theta_0\gamma}{9(1+\sqrt{n-2})}$ of the orbit $\mathcal O=O(n)\cdot W_0$, other than the points of $\mathcal O$
itself.*

[L216Bern.lean](L216Bern.lean) and [L217Le.lean](L217Le.lean) type steps 2 to 5 along a great circle. Here step 1 and the final inference
are typed: the nearest orbit point and the normal direction come from [L217Gen.lean](L217Gen.lean)'s `first_order_gen`, and a critical
point on the circle makes `φ'` vanish there. `M` is a bound on `|P|` over the unit Weyl sphere, which the record takes from L143 as
`1 + √(n − 2)`.

* `cubDer_eq`: `φ'` along the circle through orthonormal `u`, `v` is `3 T(c, c, c')`;
* **`cubDer_crit`**: at a critical point `c` of the circle, `φ' = 0`;
* **`L216_general`**: a unit critical Weyl `W` with `⟨U · W, u⟩ > cos r` for some orthogonal `U` lies on the orbit of `u`;
* **`L216_radius`**: the same with the record's `M = 1 + √(n − 2)`, from L143's `L143_unconditional`;
* `crossOrbit_eq_tang`, **`L216_sphere_radius`**: the corollary at every sphere product `p, q ≥ 3` off `(3, 3)` with L216's `γ_{p,q}`.
-/

namespace HamiltonsCubic.L216Gen

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.TensorBridge
  HamiltonsCubic.L3Local HamiltonsCubic.L217Gen HamiltonsCubic.L214Op HamiltonsCubic.L216Bern

variable {n : ℕ}

/-- **The rotation derivative of `P` along a great circle** is `3 T(c, c, c')`. -/
theorem cubDer_eq (u v : CurvOp2 (Fin n)) (x y : ℝ) :
    cub (Dq (qP u v)) x y = 3 * Tsym (x • u + y • v) (x • u + y • v) ((-y) • u + x • v) := by
  simp only [Tsym_add_left, Tsym_add_mid, Tsym_add_right, Tsym_smul_left, Tsym_smul_mid, Tsym_smul_right]
  rw [Tsym_12 v u u, Tsym_23 u v u, Tsym_12 v u v, Tsym_12 v v u, Tsym_23 u v v]
  have e : Tsym v v u = Tsym u v v := by rw [Tsym_23, Tsym_12]
  simp only [cub, Dq, qP, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_succ, Matrix.head_cons,
    Fin.succ_zero_eq_one, Fin.succ_one_eq_two, Matrix.vecHead, Matrix.vecTail, Function.comp, Matrix.cons_val_two,
    Matrix.cons_val_three, ← Tsym_diag]
  rw [e]
  ring

/-- **A critical point on the circle stops `φ`.** -/
theorem cubDer_crit {u v : CurvOp2 (Fin n)} (hu1 : normSq2 u = 1) (hv1 : normSq2 v = 1) (huv : innerOp2 u v = 0)
    {x y : ℝ} (hc : IsSelfAdjoint2 (x • u + y • v)) {lam : ℝ} (hQ : Qop2 (x • u + y • v) = lam • (x • u + y • v)) :
    cub (Dq (qP u v)) x y = 0 := by
  rw [cubDer_eq, Tsym_crit hc hQ]
  have hvu : innerOp2 v u = 0 := by rw [innerOp2_comm]; exact huv
  unfold normSq2 at hu1 hv1
  rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, innerOp2_comm u, innerOp2_comm v,
    innerOp2_add_left, innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, innerOp2_smul_left, innerOp2_smul_left,
    hu1, hv1, huv, hvu]
  ring

/-- **L216 at every gapped critical orbit.** `u` a unit critical Weyl operator with `θ = P(u) > 0` and the gap
`⟨L_e H, H⟩ ≤ ½ − γ`, `γ > 0`, at every unit Weyl `H ⊥ u` orthogonal to the orbit tangent; `M > 0` a bound on `|P|` over the unit Weyl
sphere. A unit critical Weyl `W` (`Q(W) = λ W`) with `⟨U · W, u⟩ > cos r` for some orthogonal `U`, `r = 4θγ/(9M)`, i.e. within geodesic
distance `r` of the orbit, lies on the orbit. -/
theorem L216_general {u : CurvOp2 (Fin n)} (huW : IsWeyl2 u) (hu1 : normSq2 u = 1) {θ : ℝ} (hQ : Qop2 u = θ • u)
    (hθ : 0 < θ) {γ : ℝ} (hγ : 0 < γ)
    (hgap : ∀ H : CurvOp2 (Fin n), IsWeyl2 H → normSq2 H = 1 → innerOp2 u H = 0 →
      (∀ j k : Fin n, j ≠ k → innerOp2 (tang u j k) H = 0) → innerOp2 (LeLin u H) H ≤ 1 / 2 - γ)
    {M : ℝ} (hM0 : 0 < M) (hMb : ∀ X : CurvOp2 (Fin n), IsWeyl2 X → normSq2 X = 1 → |Pcubic2 X| ≤ M)
    {W : CurvOp2 (Fin n)} (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1) {lam : ℝ} (hWc : Qop2 W = lam • W)
    (hnear : ∃ U, IsOrth U ∧ Real.cos (4 * θ * γ / (9 * M)) < innerOp2 (rotR U W) u) :
    ∃ U, IsOrth U ∧ rotR U W = u := by
  have hPu : Pcubic2 u = θ := HamiltonsCubic.L217Le.Pcubic2_crit huW.isSelfAdjoint2 hQ hu1
  set r : ℝ := 4 * θ * γ / (9 * M) with hrdef
  have hr0 : 0 ≤ r := by positivity
  obtain ⟨U, hU, hUnear⟩ := hnear
  obtain ⟨U₀, hU₀, hmx⟩ := exists_max W u
  set V' := rotR U₀ W with hV'def
  have hV'W : IsWeyl2 V' := rotR_isWeyl2 hU₀ hWW
  have hV'1 : normSq2 V' = 1 := by rw [hV'def, normSq2_rotR hU₀ hWW, hW1]
  have hV'c : Qop2 V' = lam • V' := HamiltonsCubic.L217Orbit.crit_rotR hU₀ hWW hWc
  set c := innerOp2 V' u with hcdef
  have hc_gt : Real.cos r < c := lt_of_lt_of_le hUnear (hmx U hU)
  set h := V' - c • u with hhdef
  have hhW : IsWeyl2 h := HamiltonsCubic.L214Frame.isWeyl2_sub' hV'W (isWeyl2_smul c huW)
  have hperp : innerOp2 u h = 0 := by
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, show innerOp2 u u = 1 from hu1, ← hcdef]; ring
  have hu : normSq2 h = 1 - c ^ 2 := by
    rw [hhdef, normSq2_sub, hV'1, innerOp2_smul_right, ← hcdef]
    unfold normSq2
    rw [innerOp2_smul_left, innerOp2_smul_right]
    unfold normSq2 at hu1
    rw [hu1]; ring
  have hdecomp : V' = c • u + h := by rw [hhdef]; abel
  have htan : ∀ j k : Fin n, j ≠ k → innerOp2 (tang u j k) h = 0 := by
    intro j k hjk
    have h1 := first_order_gen huW hWW hU₀ hmx hjk
    have h2 := tangent_perp huW hjk
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, innerOp2_comm V', innerOp2_comm u, h1, h2]
    ring
  have hu0 : 0 ≤ normSq2 h := innerOp2_self_nonneg h
  have hcm : -1 < c := lt_of_le_of_lt (Real.neg_one_le_cos r) hc_gt
  clear_value h c V' r
  by_cases hz : normSq2 h = 0
  · refine ⟨U₀, hU₀, ?_⟩
    have h0 : h = 0 := normSq2_eq_zero hz
    have e : (c - 1) * (c + 1) = 0 := by
      have : 1 - c ^ 2 = 0 := by rw [← hu, hz]
      linear_combination -this
    have hc1 : c = 1 := by
      rcases mul_eq_zero.mp e with h1 | h1
      · linarith
      · linarith
    rw [← hV'def, hdecomp, h0, hc1]
    module
  · exfalso
    have hpos : 0 < normSq2 h := lt_of_le_of_ne hu0 (Ne.symm hz)
    have hc1 : c < 1 := by nlinarith only [hu, hpos, hcm]
    set s := Real.arccos c with hsdef
    have hcos : Real.cos s = c := Real.cos_arccos hcm.le hc1.le
    have hsin : Real.sin s = Real.sqrt (normSq2 h) := by rw [hsdef, Real.sin_arccos, hu]
    have hs_pos : 0 < s := Real.arccos_pos.mpr hc1
    have hsin_pos : 0 < Real.sin s := by rw [hsin]; exact Real.sqrt_pos.mpr hpos
    have hsin2 : Real.sin s ^ 2 = normSq2 h := by rw [hsin]; exact Real.sq_sqrt hu0
    set v := (Real.sin s)⁻¹ • h with hvdef
    have hvW : IsWeyl2 v := isWeyl2_smul _ hhW
    have hv1 : normSq2 v = 1 := by
      rw [hvdef]; unfold normSq2
      rw [innerOp2_smul_left, innerOp2_smul_right]
      have : innerOp2 h h = Real.sin s ^ 2 := hsin2.symm
      rw [this]; field_simp
    have hvu : innerOp2 u v = 0 := by rw [hvdef, innerOp2_smul_right, hperp, mul_zero]
    have hvtan : ∀ j k : Fin n, j ≠ k → innerOp2 (tang u j k) v = 0 := by
      intro j k hjk; rw [hvdef, innerOp2_smul_right, htan j k hjk, mul_zero]
    have hg := hgap v hvW hv1 hvu hvtan
    have hW' : V' = Real.cos s • u + Real.sin s • v := by
      rw [hdecomp, hvdef, smul_smul, mul_inv_cancel₀ hsin_pos.ne', one_smul, hcos]
    -- `|P| ≤ M` on the circle
    have hcirc : ∀ x y : ℝ, x ^ 2 + y ^ 2 = 1 → |Pcubic2 (x • u + y • v)| ≤ M := fun x y hxy =>
      hMb _ (isWeyl2_add (isWeyl2_smul x huW) (isWeyl2_smul y hvW)) (plane_unit u v hu1 hv1 hvu x y hxy)
    -- `r ≤ 2/3`, from Bernstein twice at the orbit point
    have hT : Tsym u v v ≤ θ * (1 / 2 - γ) := by
      rw [HamiltonsCubic.L217Le.Tsym_eq_Le huW.isSelfAdjoint2 hvW.isSelfAdjoint2 (by rw [hPu]; exact hθ.ne'), hPu]
      exact mul_le_mul_of_nonneg_left hg hθ.le
    have hB := bern1 (Dq (qP u v)) (3 * M) (bern1 (qP u v) M (P_plane_bound u v M hcirc)) 1 0 (by norm_num)
    have hval : cub (Dq (Dq (qP u v))) 1 0 = 6 * Tsym u v v - 3 * Pcubic2 u := by
      simp only [cub, Dq, qP, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.cons_val_two,
        Matrix.tail_cons, Matrix.cons_val_three]
      ring
    rw [hval, hPu] at hB
    have hθγ : 6 * θ * γ ≤ 9 * M := by
      have := neg_abs_le (6 * Tsym u v v - 3 * θ)
      nlinarith only [hB, this, hT]
    have hr23 : r ≤ 2 / 3 := by
      rw [hrdef, div_le_iff₀ (by positivity)]; nlinarith only [hθγ]
    have hrpi : r ≤ Real.pi := le_trans hr23 (by linarith only [Real.pi_gt_three])
    have hs_lt : s < r := by
      by_contra hge
      have hge' := le_of_not_gt hge
      have := Real.cos_le_cos_of_nonneg_of_le_pi hr0 (Real.arccos_le_pi c) hge'
      rw [hcos] at this
      linarith only [this, hc_gt]
    have hneg := HamiltonsCubic.L217Le.no_critical_in_tube_Le u v huW.isSelfAdjoint2 hvW.isSelfAdjoint2 hQ hu1 hvu hθ hM0
      hcirc hg hs_pos (by rw [hrdef] at hs_lt; exact hs_lt)
    have hzero : cub (Dq (qP u v)) (Real.cos s) (Real.sin s) = 0 := by
      have hc' : Qop2 (Real.cos s • u + Real.sin s • v) = lam • (Real.cos s • u + Real.sin s • v) := by
        rw [← hW']; exact hV'c
      have hsa : IsSelfAdjoint2 (Real.cos s • u + Real.sin s • v) := by rw [← hW']; exact hV'W.isSelfAdjoint2
      exact cubDer_crit hu1 hv1 hvu hsa hc'
    linarith only [hneg, hzero]

/-- **L216 with the record's radius**: at `n ≥ 4`, L143's `M = 1 + √(n − 2)` bounds `|P|` on the unit Weyl sphere, so no unit critical
Weyl `W` off the orbit lies within geodesic distance `r = 4θγ/(9(1 + √(n − 2)))` of a gapped critical orbit. -/
theorem L216_radius (hn : 4 ≤ n) {u : CurvOp2 (Fin n)} (huW : IsWeyl2 u) (hu1 : normSq2 u = 1) {θ : ℝ} (hQ : Qop2 u = θ • u)
    (hθ : 0 < θ) {γ : ℝ} (hγ : 0 < γ)
    (hgap : ∀ H : CurvOp2 (Fin n), IsWeyl2 H → normSq2 H = 1 → innerOp2 u H = 0 →
      (∀ j k : Fin n, j ≠ k → innerOp2 (tang u j k) H = 0) → innerOp2 (LeLin u H) H ≤ 1 / 2 - γ)
    {W : CurvOp2 (Fin n)} (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1) {lam : ℝ} (hWc : Qop2 W = lam • W)
    (hnear : ∃ U, IsOrth U ∧ Real.cos (4 * θ * γ / (9 * (1 + Real.sqrt ((n : ℝ) - 2)))) < innerOp2 (rotR U W) u) :
    ∃ U, IsOrth U ∧ rotR U W = u :=
  L216_general huW hu1 hQ hθ hγ hgap (by positivity)
    (fun X hXW hX1 => HamiltonsCubic.L143Attain.L143_unconditional hn X ⟨hX1, hXW⟩) hWW hW1 hWc hnear

/-- At a sphere product, the cross-pair orbit tangent is the generator tangent. -/
theorem crossOrbit_eq_tang (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ)
    (q : ↥(T ×ˢ Tᶜ)) :
    HamiltonsCubic.L27Span.crossOrbit T t q
      = tang (restrict (FamilyLayer.diagOp_isWeyl ((FamilyLayer.sphereWeight_isWeight T hp hq).smul t))) q.1.1 q.1.2 := by
  obtain ⟨hj, hk⟩ := HamiltonsCubic.L27Span.mem_cross T q
  have hjk : q.1.1 ≠ q.1.2 := fun e => hk (e ▸ hj)
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show ((HamiltonsCubic.L27Span.orbitOp T t q.1.1 q.1.2 X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
  rw [HamiltonsCubic.L27Span.orbitOp_apply T t hjk X]
  rfl

/-- **L216's corollary at the sphere products**: at `S^p × S^q`, `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, with L216's gap
`γ_{p,q} = ½ − max(λ_p, λ_q, μ)` and `M = 1 + √(n − 2)`, a unit critical Weyl `W` within geodesic distance
`4θ_{p,q}γ_{p,q}/(9(1 + √(n − 2)))` of the orbit lies on it. -/
theorem L216_sphere_radius (hn : 4 ≤ n) (T : Finset (Fin n)) (hp3 : 3 ≤ T.card) (hq3 : 3 ≤ Tᶜ.card)
    (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3)) (t : ℝ) (ht : 0 < t) (hn1 : normSq (FamilyLayer.diagOp (t • FamilyLayer.sphereWeight T)) = 1)
    {W : CurvOp2 (Fin n)} (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1) {lam : ℝ} (hWc : Qop2 W = lam • W)
    (hnear : ∃ U, IsOrth U ∧ Real.cos (4 * (t * ((T.card : ℝ) + Tᶜ.card - 1))
      * (1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ)) / (9 * (1 + Real.sqrt ((n : ℝ) - 2))))
      < innerOp2 (rotR U W) (restrict (FamilyLayer.diagOp_isWeyl ((FamilyLayer.sphereWeight_isWeight T (by omega) (by omega)).smul t)))) :
    ∃ U, IsOrth U ∧ rotR U W = restrict (FamilyLayer.diagOp_isWeyl ((FamilyLayer.sphereWeight_isWeight T (by omega) (by omega)).smul t)) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt := (FamilyLayer.sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (FamilyLayer.diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hmR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp3
  have hqR : (3 : ℝ) ≤ ((Tᶜ.card : ℕ) : ℝ) := by exact_mod_cast hq3
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  have ha1 : normSq2 M = 1 := by
    rw [hMdef, HamiltonsCubic.RealLayer.normSq2_restrict (HamiltonsCubic.RealLayer.isLinOp_diagOp _) (FamilyLayer.diagOp_isWeyl hwt), hn1]
  have hcrit : Qop2 M = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • M := HamiltonsCubic.L126Assembly.sphere_isCritical2 T hp2 hq2 t
  have hγ : 0 < 1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ) := by
    have := HamiltonsCubic.L216Unbal.gap_lt_half hmR hqR (fun h => hne ⟨by exact_mod_cast h.1, by exact_mod_cast h.2⟩)
    linarith
  refine L216_radius hn hMW ha1 hcrit hθ hγ ?_ hWW hW1 hWc hnear
  intro H hHW hH1 hHM hHt
  have hcross : ∀ q, innerOp2 (HamiltonsCubic.L27Span.crossOrbit T t q) H = 0 := by
    intro q
    obtain ⟨hj, hk⟩ := HamiltonsCubic.L27Span.mem_cross T q
    have hjk : q.1.1 ≠ q.1.2 := fun e => hk (e ▸ hj)
    rw [crossOrbit_eq_tang T hp2 hq2 t q]
    exact hHt _ _ hjk
  have horb := HamiltonsCubic.L216Unbal.horb_of_orbit T hp3 hq3 hne t ht hn1 hcross
  have hg := HamiltonsCubic.L216Unbal.Le_gap_sphere T hp3 hq3 t ht hn1 hHW hH1 hHM horb
  linarith

end HamiltonsCubic.L216Gen
