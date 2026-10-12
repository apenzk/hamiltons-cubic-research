import Mathlib
import HamiltonsCubic.Results.L3Quad
import HamiltonsCubic.Results.L217Le

set_option linter.style.longLine false

/-!
# L216 at the balanced sphere product: the gap `γ = 1/(2(m − 1))` from L3, and the isolation step with it

[findings/second-order.md](../../../findings/second-order.md), Lemma L216: step 5 needs, at the critical point, a gap
`⟨L_e H, H⟩ ≤ ½ − γ` on the unit directions normal to the orbit, which the record takes from
[L27](../../../findings/nondegeneracy.md)'s gap at the sphere products. [L217Le.lean](L217Le.lean)'s `no_critical_in_tube_Le`
takes it as the hypothesis `hgap`. [L3Quad.lean](L3Quad.lean)'s `L3_hessian` supplies it at the balanced product:

* **`Le_gap_balanced`**: at a unit sphere product with `p = q = m ≥ 4`, every unit Weyl `H ⊥ M` orthogonal to every
  `½`-eigenvector of `L_e` (the orbit tangent, by `L27_half_span`) has `⟨L_e H, H⟩ ≤ ½ − 1/(2(m − 1))`, through `L3_hessian`
  and `hessQ_eq_Le`;
* **`L216_sphere`**: hence step 5 there with `γ = 1/(2(m − 1))`, as the sign of the rotation-derived cubic form: negative for
  `0 < s < 4θγ/(9 M_P)`, `M_P` a bound on `|P|` on the unit circle of the plane of `M, H`;
* **`L216_sphere_deriv`**: the same statement as a derivative, `σ ↦ P(cos σ M + sin σ H)` has at `s` a negative derivative,
  through `P_plane` and `hasDerivAt_cub`.

The record's inference from a negative derivative to non-criticality, step 1 (the attained distance and the normal geodesic)
and equivariance stay with the record; the gap is proved at `M`.
-/

namespace HamiltonsCubic.L216Sphere

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen

variable {n : ℕ}

/-- **L27's gap at the balanced product, in `hgap`'s form.** -/
theorem Le_gap_balanced (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) (hH1 : normSq2 H = 1)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0) :
    innerOp2 (LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H) H
      ≤ 1 / 2 - 1 / (2 * ((T.card : ℝ) - 1)) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  set θ := t * ((T.card : ℝ) + Tᶜ.card - 1) with hθdef
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hθ : 0 < θ := mul_pos ht (by rw [hqR]; linarith)
  have ha : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = θ • M := sphere_isCritical2 T hp2 hq2 t
  have hP0 : Pcubic2 M ≠ 0 := by rw [hPM]; exact hθ.ne'
  have hbound := HamiltonsCubic.L3Quad.L3_hessian T hp hpq t ht hn hHW hperp horb
  have hQ := hessQ_eq_Le ha hMW hcrit hP0 (⟨(RecCurv.equiv H : RecCurv (Fin n)), hHW, hperp⟩ : weylPerpR M)
  change hessQ M H = 6 * Pcubic2 M * (innerOp2 (LeLin M H) H - (1 / 2) * normSq2 H) at hQ
  rw [hQ, hPM, hH1, mul_one] at hbound
  rw [hqR] at hbound
  have hm1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have e : (T.card : ℝ) + T.card - 2 = 2 * ((T.card : ℝ) - 1) := by ring
  rw [e] at hbound
  have hX : t * ((T.card : ℝ) + T.card - 1) = θ := by rw [hθdef, hqR]
  rw [hX, mul_one] at hbound
  have h6 : 0 < 6 * θ := by positivity
  have key : innerOp2 (LeLin M H) H - 1 / 2 ≤ -(1 / (2 * ((T.card : ℝ) - 1))) := by
    have e2 : -(6 * θ / (2 * ((T.card : ℝ) - 1))) = 6 * θ * -(1 / (2 * ((T.card : ℝ) - 1))) := by ring
    rw [e2] at hbound
    exact le_of_mul_le_mul_left hbound h6
  linarith

/-- **L216's step 5 at the balanced product**, with `γ = 1/(2(m − 1))` from L3: along the plane of `M` and a unit `H` normal to
the orbit, the rotation-derived cubic form of `P` is negative on `0 < s < 4θγ/(9 M_P)`. -/
theorem L216_sphere (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) (hH1 : normSq2 H = 1)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0)
    {MP s : ℝ} (hM0 : 0 < MP)
    (hM : ∀ x y : ℝ, x ^ 2 + y ^ 2 = 1 →
      |Pcubic2 (x • restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)) + y • H)| ≤ MP)
    (hs0 : 0 < s)
    (hsr : s < 4 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) * (1 / (2 * ((T.card : ℝ) - 1))) / (9 * MP)) :
    HamiltonsCubic.L216Bern.cub (HamiltonsCubic.L216Bern.Dq (HamiltonsCubic.L216Bern.qP
      (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H)) (Real.cos s) (Real.sin s) < 0 := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt := (sphereWeight_isWeight T hp2 hq2).smul t
  have hMW : IsWeyl2 (restrict (diagOp_isWeyl hwt)) := isWeyl2_restrict _
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by rw [hqR]; linarith)
  have ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1 := by
    rw [normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • restrict (diagOp_isWeyl hwt) :=
    sphere_isCritical2 T hp2 hq2 t
  have hgap := Le_gap_balanced T hp hpq t ht hn hHW hH1 hperp horb
  exact HamiltonsCubic.L217Le.no_critical_in_tube_Le _ H hMW.isSelfAdjoint2 hHW.isSelfAdjoint2 hcrit ha hperp hθ hM0 hM
    (by linarith) hs0 hsr

/-- **Step 5 as a derivative**: `σ ↦ P(cos σ M + sin σ H)` has a negative derivative at every `0 < s < 4θγ/(9 M_P)`. -/
theorem L216_sphere_deriv (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) (hH1 : normSq2 H = 1)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0)
    {MP s : ℝ} (hM0 : 0 < MP)
    (hM : ∀ x y : ℝ, x ^ 2 + y ^ 2 = 1 →
      |Pcubic2 (x • restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)) + y • H)| ≤ MP)
    (hs0 : 0 < s)
    (hsr : s < 4 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) * (1 / (2 * ((T.card : ℝ) - 1))) / (9 * MP)) :
    ∃ d : ℝ, HasDerivAt (fun σ => Pcubic2 (Real.cos σ • restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)) + Real.sin σ • H)) d s ∧ d < 0 := by
  refine ⟨_, ?_, L216_sphere T hp hpq t ht hn hHW hH1 hperp horb hM0 hM hs0 hsr⟩
  have e : (fun σ => Pcubic2 (Real.cos σ • restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)) + Real.sin σ • H))
      = fun σ => HamiltonsCubic.L216Bern.cub (HamiltonsCubic.L216Bern.qP (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H) (Real.cos σ) (Real.sin σ) :=
    funext fun σ => HamiltonsCubic.L216Bern.P_plane _ H _ _
  rw [e]
  exact HamiltonsCubic.L216Bern.hasDerivAt_cub _ s

end HamiltonsCubic.L216Sphere
