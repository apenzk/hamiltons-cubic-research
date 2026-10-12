import Mathlib
import HamiltonsCubic.Results.L3Attain

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L149's margin input on all of `N`: the decomposition `H = H_s + H_r` by orthogonal projection

[findings/second-order.md](../../../findings/second-order.md), Lemma L149's set-up: *Write $H=H_s+H_r$ with $H_s$ in the
**joint** $\lambda_m$-eigenspace, both copies, and $w:=\lVert H_r\rVert$ the weight outside **both**.*
[L149Margin.lean](L149Margin.lean)'s `L149_margin` takes the two pieces as given. This file produces them from an arbitrary
direction `H` in `N`, the Weyl directions orthogonal to `M` and to the orbit tangent:

* `IsSplit`, **`split_eq_proj`**, **`split_unique`**: the decomposition's defining properties, which force `H_s` to be the
  orthogonal projection of `H` onto the `λ_m`-eigenspace, so the split and `w = ‖H_r‖` are functions of `H`;
* **`L149_margin_N`**: at a unit sphere product with `p = q = m ≥ 4`, every Weyl `H ⊥ M` orthogonal to every `½`-eigenvector
  of `L_e` in `W^⊥ ∩ 𝒲ₙ` splits as `H = H_s + H_r`, `H_s` the orthogonal projection of `H` onto the `λ_m`-eigenspace of
  L24's `LeRestr`, and `−½ hessQ(H) ≥ c_p ‖H‖² + 3θ (m − 4)/(2(m − 1)) ‖H_r‖²`;
* **`L149_margin_unit`**: on `‖H‖ = 1` that is the block's `c(H) ≥ c_p + 3θ (m − 4)/(2(m − 1)) w²`, `w² = ‖H_r‖²`;
* `theta_balanced_sq`: `θ = t(n − 1)` is `θ₀(n)`, `θ² = (2m − 1)(m − 1)/m²`;
* **`rho_weaken`**: `ρ^eff_n ≤ 3θ₀ (m − 4)/(2(m − 1))` at `m ≥ 6`, the two sides differing by `2θ₀ − √6 ≥ 0`;
* **`L149_hmargin`**: hence `c_p + ρ^eff_n w² ≤ c(H)` at every unit `H ∈ N`, `w = ‖H_r‖` of its split, the shape of
  [L149Statement.lean](L149Statement.lean)'s `hmargin`;
* `L27_lambda_max`: the orbit summand this file excludes carries L27's top eigenvalue `½`, bounded and attained in one
  statement.
-/

namespace HamiltonsCubic.L149Bridge

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen

variable {n : ℕ}

/-- **The decomposition `H = H_s + H_r`** at a Weyl `a` and an eigenvalue `c`: `H_s` a `c`-eigenvector of `L_e` in `W^⊥ ∩ 𝒲ₙ`,
`H_r` in `W^⊥ ∩ 𝒲ₙ` orthogonal to every `½`- and `c`-eigenvector there. -/
def IsSplit (a : CurvOp2 (Fin n)) (c : ℝ) (H Hs Hr : CurvOp2 (Fin n)) : Prop :=
  Hs + Hr = H ∧ IsWeyl2 Hs ∧ innerOp2 a Hs = 0 ∧ LeLin a Hs = c • Hs ∧ IsWeyl2 Hr ∧ innerOp2 a Hr = 0 ∧
    ∀ K : CurvOp2 (Fin n), IsWeyl2 K → innerOp2 a K = 0 → (LeLin a K = (1 / 2 : ℝ) • K ∨ LeLin a K = c • K) →
      innerOp2 K Hr = 0

/-- **`H_s` is the orthogonal projection** of `H` onto the `c`-eigenspace of `LeRestr`, so the split is determined by `H`. -/
theorem split_eq_proj {a : CurvOp2 (Fin n)} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a) (hcrit : Qop2 a = lam • a)
    (hθ : Pcubic2 a ≠ 0) {c : ℝ} {H Hs Hr : CurvOp2 (Fin n)} (h : IsSplit a c H Hs Hr) (hHW : IsWeyl2 H)
    (hHP : innerOp2 a H = 0) :
    Hs = tanV ((Module.End.eigenspace (LeRestr ha hWa hcrit hθ) c).starProjection
      (⟨(RecCurv.equiv H : RecCurv (Fin n)), hHW, hHP⟩ : weylPerpR a)) := by
  obtain ⟨hsum, hsW, hsP, hsE, hrW, hrP, hrO⟩ := h
  set E := Module.End.eigenspace (LeRestr ha hWa hcrit hθ) c
  have hs'E : (⟨(RecCurv.equiv Hs : RecCurv (Fin n)), hsW, hsP⟩ : weylPerpR a) ∈ E :=
    Module.End.mem_eigenspace_iff.mpr (Subtype.ext hsE)
  have hr'E : (⟨(RecCurv.equiv Hr : RecCurv (Fin n)), hrW, hrP⟩ : weylPerpR a) ∈ Eᗮ := by
    rw [Submodule.mem_orthogonal]
    intro w hw
    exact hrO (tanV w) w.2.1 w.2.2 (Or.inr (congrArg Subtype.val (Module.End.mem_eigenspace_iff.mp hw)))
  have hu : (⟨(RecCurv.equiv H : RecCurv (Fin n)), hHW, hHP⟩ : weylPerpR a)
      = ⟨(RecCurv.equiv Hs : RecCurv (Fin n)), hsW, hsP⟩ + ⟨(RecCurv.equiv Hr : RecCurv (Fin n)), hrW, hrP⟩ :=
    Subtype.ext hsum.symm
  rw [Submodule.eq_starProjection_of_mem_orthogonal' hs'E hr'E hu]
  rfl

/-- **The split is unique**, so `w = ‖H_r‖` is a function of `H`. -/
theorem split_unique {a : CurvOp2 (Fin n)} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a) (hcrit : Qop2 a = lam • a)
    (hθ : Pcubic2 a ≠ 0) {c : ℝ} {H Hs Hr Hs' Hr' : CurvOp2 (Fin n)} (h1 : IsSplit a c H Hs Hr)
    (h2 : IsSplit a c H Hs' Hr') : Hs = Hs' ∧ Hr = Hr' := by
  have hHW : IsWeyl2 H := h1.1 ▸ isWeyl2_add h1.2.1 h1.2.2.2.2.1
  have hHP : innerOp2 a H = 0 := by rw [← h1.1, innerOp2_add_right, h1.2.2.1, h1.2.2.2.2.2.1, add_zero]
  have e1 := split_eq_proj ha hWa hcrit hθ h1 hHW hHP
  have e2 := split_eq_proj ha hWa hcrit hθ h2 hHW hHP
  have hs : Hs = Hs' := e1.trans e2.symm
  refine ⟨hs, ?_⟩
  have e : Hs + Hr = Hs + Hr' := by rw [h1.1, hs, h2.1]
  have e' : (RecCurv.equiv Hs : RecCurv (Fin n)) + RecCurv.equiv Hr = RecCurv.equiv Hs + RecCurv.equiv Hr' := by
    rw [← map_add, ← map_add, e]
  exact RecCurv.equiv.injective (add_left_cancel e')

/-- **The margin on all of `N`.** -/
theorem L149_margin_N (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0) :
    ∃ Hs Hr : CurvOp2 (Fin n), IsSplit (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) H Hs Hr ∧
      3 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) / (2 * ((T.card : ℝ) - 1)) * normSq2 H
        + 3 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) * ((T.card : ℝ) - 4) / (2 * ((T.card : ℝ) - 1)) * normSq2 Hr
        ≤ -hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H / 2 := by
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
  set LP := ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) with hLP
  have hLPh : LP ≠ 1 / 2 := by
    rw [hLP]; intro h
    rw [div_eq_iff (by linarith)] at h
    linarith
  -- the projection onto the `λ_m`-eigenspace, inside `W^⊥ ∩ 𝒲ₙ`
  set E := Module.End.eigenspace (LeRestr ha hMW hcrit hP0) LP with hEdef
  obtain ⟨v, hv⟩ : ∃ v : weylPerpR M, tanV v = H := ⟨⟨(RecCurv.equiv H : RecCurv (Fin n)), hHW, hperp⟩, rfl⟩
  obtain ⟨s, hsdef⟩ : ∃ s : weylPerpR M, s = E.starProjection v := ⟨_, rfl⟩
  obtain ⟨r, hrdef⟩ : ∃ r : weylPerpR M, r = v - s := ⟨_, rfl⟩
  have hsE : s ∈ E := by rw [hsdef]; exact E.starProjection_apply_mem v
  have hrE : r ∈ Eᗮ := by rw [hrdef, hsdef]; exact E.sub_starProjection_mem_orthogonal v
  have hseig : LeLin M (tanV s) = LP • tanV s := congrArg Subtype.val (Module.End.mem_eigenspace_iff.mp hsE)
  have hsum : tanV s + tanV r = H := by
    rw [← hv, hrdef]
    show ((s : RecCurv (Fin n)) : CurvOp2 (Fin n)) + (((v : RecCurv (Fin n)) - (s : RecCurv (Fin n)) : RecCurv (Fin n)) : CurvOp2 (Fin n))
      = ((v : RecCurv (Fin n)) : CurvOp2 (Fin n))
    exact add_sub_cancel (s : RecCurv (Fin n)) (v : RecCurv (Fin n))
  have hsW : IsWeyl2 (tanV s) := s.2.1
  have hsP : innerOp2 M (tanV s) = 0 := s.2.2
  have hrW : IsWeyl2 (tanV r) := r.2.1
  have hrP : innerOp2 M (tanV r) = 0 := r.2.2
  have hrO : ∀ K : CurvOp2 (Fin n), IsWeyl2 K → innerOp2 M K = 0 →
      (LeLin M K = (1 / 2 : ℝ) • K ∨ LeLin M K = LP • K) → innerOp2 K (tanV r) = 0 := by
    intro K hKW hKP hK
    obtain ⟨k, hk⟩ : ∃ k : weylPerpR M, tanV k = K := ⟨⟨(RecCurv.equiv K : RecCurv (Fin n)), hKW, hKP⟩, rfl⟩
    rcases hK with hK | hK
    · -- a `½`-eigenvector: `H ⊥ K`, and `H_s ⊥ K` since their eigenvalues differ
      have h1 : innerOp2 K H = 0 := horb K hKW hKP hK
      have h2 : innerOp2 K (tanV s) = 0 := by
        have e : innerOp2 (LeLin M K) (tanV s) = innerOp2 K (LeLin M (tanV s)) := LeLin_selfAdj hMW hKW hsW
        rw [hK, hseig, innerOp2_smul_left, innerOp2_smul_right] at e
        have e2 : (1 / 2 - LP) * innerOp2 K (tanV s) = 0 := by linarith
        rcases mul_eq_zero.mp e2 with h | h
        · exact absurd (by linarith : LP = 1 / 2) hLPh
        · exact h
      have h3 : innerOp2 K (tanV s + tanV r) = innerOp2 K (tanV s) + innerOp2 K (tanV r) := innerOp2_add_right _ _ _
      rw [hsum, h1, h2, zero_add] at h3
      exact h3.symm
    · -- a `λ_m`-eigenvector: `K ∈ E` and `H_r ∈ Eᗮ`
      have hkE : k ∈ E := Module.End.mem_eigenspace_iff.mpr (Subtype.ext (by
        show LeLin M (tanV k) = LP • tanV k
        rw [hk]; exact hK))
      have := Submodule.inner_right_of_mem_orthogonal hkE hrE
      rw [← hk]; exact this
  have key := HamiltonsCubic.L149Margin.L149_margin T hp hpq t ht hn hsW hsP hseig hrW hrP hrO
  rw [hsum] at key
  exact ⟨tanV s, tanV r, ⟨hsum, hsW, hsP, hseig, hrW, hrP, hrO⟩, key⟩

/-- **The block's form, on the unit sphere**: `c(H) = −½ hessQ(H) ≥ c_p + 3θ (m − 4)/(2(m − 1)) w²` at every unit `H ∈ N`,
with `w² = ‖H_r‖²` the weight outside the `λ_m`-eigenspace and `c_p = 3θ/(2(m − 1))`. -/
theorem L149_margin_unit (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) (hH1 : normSq2 H = 1)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0) :
    ∃ Hs Hr : CurvOp2 (Fin n), IsSplit (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) H Hs Hr ∧
      3 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) / (2 * ((T.card : ℝ) - 1))
        + 3 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) * ((T.card : ℝ) - 4) / (2 * ((T.card : ℝ) - 1)) * normSq2 Hr
        ≤ -hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H / 2 := by
  obtain ⟨Hs, Hr, hS, h⟩ := L149_margin_N T hp hpq t ht hn hHW hperp horb
  rw [hH1, mul_one] at h
  exact ⟨Hs, Hr, hS, h⟩

/-- **`θ` at the balanced product**: at a unit sphere product with `p = q = m`, `θ = t(n − 1) = θ₀(n)`, so
`θ² = (2m − 1)(m − 1)/m² = 2(n − 1)(n − 2)/n²`. -/
theorem theta_balanced_sq (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    (t * ((T.card : ℝ) + Tᶜ.card - 1)) ^ 2 = (2 * (T.card : ℝ) - 1) * ((T.card : ℝ) - 1) / (T.card : ℝ) ^ 2 := by
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp hq2 t) hn
  have hv := theta_sphereProduct_value T hp hq2 t ht hn
  rw [theta_of_unit _ hn, hPθ] at hv
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hmR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  rw [hv, thetaSplit, Real.sq_sqrt, thetaSplitSq, hqR]
  · have h1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
    have h2 : (T.card : ℝ) ≠ 0 := by linarith
    rw [show (T.card : ℝ) + T.card - 2 = 2 * ((T.card : ℝ) - 1) by ring,
      show (T.card : ℝ) + T.card - 1 = 2 * (T.card : ℝ) - 1 by ring]
    field_simp
  · rw [thetaSplitSq, hqR]
    apply div_nonneg
    · apply mul_nonneg; apply mul_nonneg; all_goals nlinarith
    · nlinarith

/-- **The weakening `ρ^eff_n ≤ 3θ₀ (m − 4)/(2(m − 1))`**, `n = 2m ≥ 12`, `ρ^eff_n = √6 − θ₀(n)(n + 16)/(2(n − 2))`. The two sides
differ by `2θ₀ − √6`, which is `≥ 0` exactly when `θ₀² ≥ 3/2`, that is `m² − 6m + 2 ≥ 0`. -/
theorem rho_weaken {m θ : ℝ} (hm : 6 ≤ m) (hθ0 : 0 ≤ θ) (hθ : θ ^ 2 = (2 * m - 1) * (m - 1) / m ^ 2) :
    Real.sqrt 6 - θ * (2 * m + 16) / (2 * (2 * m - 2)) ≤ 3 * θ * (m - 4) / (2 * (m - 1)) := by
  have hm1 : m - 1 ≠ 0 := by linarith
  have hsum : θ * (2 * m + 16) / (2 * (2 * m - 2)) + 3 * θ * (m - 4) / (2 * (m - 1)) = 2 * θ := by
    have h2 : 2 * m - 2 ≠ 0 := by linarith
    field_simp; ring
  have hsq : Real.sqrt 6 ≤ 2 * θ := by
    rw [Real.sqrt_le_iff]
    refine ⟨by linarith, ?_⟩
    have hm2 : (0 : ℝ) < m ^ 2 := by positivity
    have e : (2 * θ) ^ 2 = 4 * ((2 * m - 1) * (m - 1) / m ^ 2) := by rw [mul_pow, hθ]; ring
    rw [e, show 4 * ((2 * m - 1) * (m - 1) / m ^ 2) = 4 * ((2 * m - 1) * (m - 1)) / m ^ 2 by ring,
      le_div_iff₀ hm2]
    nlinarith
  linarith

/-- **L149's `hmargin`, on the operators**: at a unit sphere product with `p = q = m ≥ 6` (`n = 2m ≥ 12`), every unit Weyl
`H ⊥ M` orthogonal to the orbit tangent splits as `H_s + H_r` (`IsSplit`, unique by `split_unique`), and with
`w = ‖H_r‖` the weight outside the `λ_m`-eigenspace, `c_p + ρ^eff_n w² ≤ c(H) = −½ hessQ(H)`, `c_p = 3θ/(n − 2)`, `ρ^eff_n = √6 − θ(n + 16)/(2(n − 2))`, `θ = θ₀(n)`: the shape of
[L149Statement.lean](L149Statement.lean)'s `hmargin`. -/
theorem L149_hmargin (T : Finset (Fin n)) (hp : 6 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) (hH1 : normSq2 H = 1)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0) :
    ∃ Hs Hr : CurvOp2 (Fin n), IsSplit (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) H Hs Hr ∧
      3 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) / ((T.card : ℝ) + Tᶜ.card - 2)
        + (Real.sqrt 6 - t * ((T.card : ℝ) + Tᶜ.card - 1) * ((T.card : ℝ) + Tᶜ.card + 16)
            / (2 * ((T.card : ℝ) + Tᶜ.card - 2))) * Real.sqrt (normSq2 Hr) ^ 2
        ≤ -hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H / 2 := by
  obtain ⟨Hs, Hr, hS, h⟩ := L149_margin_unit T (by omega) hpq t ht hn hHW hH1 hperp horb
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hmR : (6 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hN : 0 ≤ normSq2 Hr := normSq2_nonneg Hr
  refine ⟨Hs, Hr, hS, ?_⟩
  rw [Real.sq_sqrt hN]
  have hθsq := theta_balanced_sq T (by omega) hpq t ht hn
  rw [hqR] at h hθsq ⊢
  set θ := t * ((T.card : ℝ) + T.card - 1) with hθdef
  have hθ0 : 0 ≤ θ := mul_nonneg ht.le (by linarith)
  have hρ := rho_weaken hmR hθ0 hθsq
  have e1 : 3 * θ / ((T.card : ℝ) + T.card - 2) = 3 * θ / (2 * ((T.card : ℝ) - 1)) := by ring_nf
  have e2 : θ * ((T.card : ℝ) + T.card + 16) / (2 * ((T.card : ℝ) + T.card - 2))
      = θ * (2 * (T.card : ℝ) + 16) / (2 * (2 * (T.card : ℝ) - 2)) := by ring_nf
  rw [e1, e2]
  have hle := mul_le_mul_of_nonneg_right hρ hN
  have e3 : 3 * θ * ((T.card : ℝ) - 4) / (2 * ((T.card : ℝ) - 1)) * normSq2 Hr
      = 3 * θ * ((T.card : ℝ) - 4) / (2 * ((T.card : ℝ) - 1)) * normSq2 Hr := rfl
  linarith

/-- **L27's `λ_max(L_e|_{W^⊥}) = ½` as one statement** (r1854 O1): at a unit sphere product with `p, q ≥ 3`, `(p, q) ≠ (3, 3)`,
every `L_e`-eigenvalue on a nonzero Weyl `H ⊥ M` is at most `½`, and `½` is one. -/
theorem L27_lambda_max (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    (∀ H : CurvOp2 (Fin n), IsWeyl2 H →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0 → H ≠ 0 →
      ∀ lam : ℝ, LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = lam • H →
        lam ≤ 1 / 2) ∧
    ∃ H : CurvOp2 (Fin n), IsWeyl2 H ∧ H ≠ 0 ∧
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0 ∧
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = (1 / 2 : ℝ) • H := by
  refine ⟨fun H hHW hperp hH0 lam heig =>
    (HamiltonsCubic.L27Main.L27_half T hp hq hne t ht hn hHW hperp hH0 heig).1, ?_⟩
  obtain ⟨j, hj⟩ := Finset.card_pos.mp (by omega : 0 < T.card)
  obtain ⟨k, hk⟩ := Finset.card_pos.mp (by omega : 0 < Tᶜ.card)
  obtain ⟨hW, _, h0, hP, hE⟩ :=
    HamiltonsCubic.L27Span.orbitOp_props T (by omega) (by omega) t ht hn hj (Finset.mem_compl.mp hk)
  exact ⟨_, hW, h0, hP, hE⟩

end HamiltonsCubic.L149Bridge
