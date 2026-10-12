import Mathlib
import HamiltonsCubic.Results.L216Sphere

set_option linter.style.longLine false

/-!
# L216 at every sphere product `S^p × S^q`, `p, q ≥ 3`, `(p, q) ≠ (3, 3)`: the gap `γ_{p,q} = ½ − max(λ_p, λ_q, μ)`

[L216Sphere.lean](L216Sphere.lean) discharges L216's gap hypothesis at the balanced product. At `p ≠ q` the gap is
[L3Gap.lean](L3Gap.lean)'s `L3_gap`, every `L_e`-eigenvalue on `W^⊥` off `½` being at most `max(λ_p, λ_q, μ)`, carried to the
quadratic form by [L3Quad.lean](L3Quad.lean)'s `quad_le_of_gap`:

* **`gap_lt_half`**: `max(λ_p, λ_q, μ) < ½` at `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, so `γ_{p,q} > 0`;
* **`Le_gap_sphere`**: at a unit sphere product with `p, q ≥ 3`, every unit Weyl `H ⊥ M` orthogonal to every `½`-eigenvector of
  `L_e` has `⟨L_e H, H⟩ ≤ max(λ_p, λ_q, μ)`;
* **`L216_sphere_general`**: step 5 there with `γ_{p,q} = ½ − max(λ_p, λ_q, μ)`, as a negative derivative of
  `σ ↦ P(cos σ M + sin σ H)` on `0 < s < 4θγ_{p,q}/(9 M_P)`; it carries no `(p, q) ≠ (3, 3)` hypothesis and is vacuous at
  `(3, 3)`, where `γ_{p,q} = 0`, the positivity off `(3, 3)` being `gap_lt_half`;
* **`horb_of_orbit`**: orthogonality to the cross orbit tangents gives the `horb` hypothesis, through `L27_half_span`, so the
  two theorems above hold at every `H` normal to the orbit.

`Le_gap_balanced` in [L216Sphere.lean](L216Sphere.lean) is the case `p = q = m ≥ 4` of `Le_gap_sphere`.
-/

namespace HamiltonsCubic.L216Unbal

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen

variable {n : ℕ}

/-- `max(λ_p, λ_q, μ)`, the top of `L_e`'s spectrum on `W^⊥` off `½` at `S^p × S^q`. -/
noncomputable def lamTop (p q : ℝ) : ℝ :=
  max (max ((p - 2) / (2 * (p - 1))) ((q - 2) / (2 * (q - 1)))) ((p + q - 2) / (2 * (p - 1) * (q - 1)))

/-- **`γ_{p,q} > 0`** at `p, q ≥ 3` off `(3, 3)`. -/
theorem gap_lt_half {p q : ℝ} (hp : 3 ≤ p) (hq : 3 ≤ q) (hne : ¬ (p = 3 ∧ q = 3)) : lamTop p q < 1 / 2 := by
  unfold lamTop
  have hp1 : 0 < p - 1 := by linarith
  have hq1 : 0 < q - 1 := by linarith
  refine max_lt (max_lt ?_ ?_) ?_
  · rw [div_lt_iff₀ (by linarith)]; linarith
  · rw [div_lt_iff₀ (by linarith)]; linarith
  · rw [div_lt_iff₀ (by positivity)]
    have h : 0 < (p - 2) * (q - 2) - 1 := by
      by_cases h3 : p = 3
      · have hq4 : 3 < q := lt_of_le_of_ne hq (fun e => hne ⟨h3, e.symm⟩)
        rw [h3]; nlinarith
      · have hp4 : 3 < p := lt_of_le_of_ne hp (Ne.symm h3)
        nlinarith
    nlinarith

/-- **L27's gap at every sphere product, in `hgap`'s form.** -/
theorem Le_gap_sphere (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) (hH1 : normSq2 H = 1)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0) :
    innerOp2 (LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H) H
      ≤ lamTop (T.card : ℝ) (Tᶜ.card : ℝ) := by
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
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (3 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  have ha : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • M := sphere_isCritical2 T hp2 hq2 t
  have hP0 : Pcubic2 M ≠ 0 := by rw [hPM]; exact hθ.ne'
  set v : weylPerpR M := ⟨(RecCurv.equiv H : RecCurv (Fin n)), hHW, hperp⟩
  have key := HamiltonsCubic.L3Quad.quad_le_of_gap (LeRestr_isSymmetric ha hMW hcrit hP0) (1 / 2)
    (lamTop (T.card : ℝ) (Tᶜ.card : ℝ))
    (fun w hw μ hμ hne => by
      have hw0 : tanV w ≠ 0 := by
        intro h; apply hw; exact Subtype.ext h
      have he : LeLin M (tanV w) = μ • tanV w := congrArg Subtype.val hμ
      exact HamiltonsCubic.L3Gap.L3_gap T hp hq t ht hn w.2.1 w.2.2 hw0 he hne)
    v (fun w hw => horb (tanV w) w.2.1 w.2.2 (congrArg Subtype.val hw))
  have hnorm : ‖v‖ ^ 2 = normSq2 H := RecCurv.norm_sq_eq (v : RecCurv (Fin n))
  have hin : inner ℝ (LeRestr ha hMW hcrit hP0 v) v = innerOp2 (LeLin M H) H := rfl
  rw [hnorm, hin, hH1, mul_one] at key
  exact key

/-- **L216's step 5 at every sphere product off `(3, 3)`**, with `γ_{p,q} = ½ − max(λ_p, λ_q, μ) > 0`, as a negative
derivative of `σ ↦ P(cos σ M + sin σ H)` on `0 < s < 4θγ_{p,q}/(9 M_P)`. -/
theorem L216_sphere_general (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
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
    (hsr : s < 4 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) * (1 / 2 - lamTop (T.card : ℝ) (Tᶜ.card : ℝ)) / (9 * MP)) :
    ∃ d : ℝ, HasDerivAt (fun σ => Pcubic2 (Real.cos σ •
        restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)) + Real.sin σ • H)) d s ∧ d < 0 := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt := (sphereWeight_isWeight T hp2 hq2).smul t
  have hMW : IsWeyl2 (restrict (diagOp_isWeyl hwt)) := isWeyl2_restrict _
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (3 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  have ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1 := by
    rw [normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • restrict (diagOp_isWeyl hwt) :=
    sphere_isCritical2 T hp2 hq2 t
  have hgap := Le_gap_sphere T hp hq t ht hn hHW hH1 hperp horb
  refine ⟨_, ?_, HamiltonsCubic.L217Le.no_critical_in_tube_Le _ H hMW.isSelfAdjoint2 hHW.isSelfAdjoint2 hcrit ha hperp hθ
    hM0 hM (by linarith) hs0 hsr⟩
  have e : (fun σ => Pcubic2 (Real.cos σ • restrict (diagOp_isWeyl hwt) + Real.sin σ • H))
      = fun σ => HamiltonsCubic.L216Bern.cub (HamiltonsCubic.L216Bern.qP (restrict (diagOp_isWeyl hwt)) H)
          (Real.cos σ) (Real.sin σ) :=
    funext fun σ => HamiltonsCubic.L216Bern.P_plane _ H _ _
  rw [e]
  exact HamiltonsCubic.L216Bern.hasDerivAt_cub _ s

/-- **`horb` from the orbit tangent** (r1866 O2, r1867 O3): at `p, q ≥ 3` off `(3, 3)`, a direction orthogonal to every cross
orbit tangent is orthogonal to every `½`-eigenvector of `L_e` in `W^⊥ ∩ 𝒲ₙ`, through `L27_half_span`. -/
theorem horb_of_orbit (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)}
    (hH : ∀ p, innerOp2 (HamiltonsCubic.L27Span.crossOrbit T t p) H = 0) :
    ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0 := by
  intro K hKW hKP hK
  have hmem := (HamiltonsCubic.L27Span.L27_half_span T hp hq hne t ht hn hKW).mp ⟨hKP, hK⟩
  clear hKW hKP hK
  induction hmem using Submodule.span_induction with
  | mem x hx => obtain ⟨p, rfl⟩ := hx; exact hH p
  | zero => rw [show (0 : CurvOp2 (Fin n)) = (0 : ℝ) • H from (zero_smul ℝ H).symm, innerOp2_smul_left, zero_mul]
  | add x y _ _ ihx ihy => rw [innerOp2_add_left, ihx, ihy, add_zero]
  | smul a x _ ih => rw [innerOp2_smul_left, ih, mul_zero]

end HamiltonsCubic.L216Unbal
