import Mathlib
import HamiltonsCubic.Results.L3Gap
import HamiltonsCubic.Results.L120Eigen
import HamiltonsCubic.Results.L126Main

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L3's Hessian bound as a quadratic form: `6θ(⟨L_e H, H⟩ − ½‖H‖²) ≤ −6θ/(n − 2) ‖H‖²` off the orbit tangent

[findings/second-order.md](../../../findings/second-order.md), Lemma L3: *By [Lemma L24] the Riemannian Hessian at $W^*$ is
$6\theta(L_e-\tfrac12\mathrm{Id})$ on $T_{W^*}\Sigma=W^{*\perp}$ … So the Hessian vanishes on $T_{W^*}\mathcal O$, and on its orthogonal
complement $N$ in $T_{W^*}\Sigma$, $\mathrm{Hess}\,P\le6\theta(\lambda_m-\tfrac12)=-\frac{6\theta}{n-2}$.*

[L3Gap.lean](L3Gap.lean) bounds every eigenvalue off `1/2`. Here the bound passes to the quadratic form through an orthonormal
eigenbasis of `L_e` on `W^⊥ ∩ 𝒲ₙ`, where `L_e` is self-adjoint ([L24Restrict.lean](L24Restrict.lean)):

* **`quad_le_of_gap`**: for a symmetric `T` on a finite-dimensional real inner product space whose eigenvalues other than `c` are at
  most `λ*`, `⟨T v, v⟩ ≤ λ* ‖v‖²` at every `v` orthogonal to the `c`-eigenvectors;
* **`L3_hessian`**: applied to L24's `LeRestr` on `weylPerpR M` at a unit balanced sphere product, `p = q = m ≥ 4`, with the gap
  `L3_gap_balanced` and `hessQ_eq_Le`, the record's Hessian form satisfies `hessQ M H ≤ −(6θ/(n − 2)) ‖H‖²` at every Weyl `H ⊥ M`
  orthogonal to every `1/2`-eigenvector of `L_e` in `W^⊥ ∩ 𝒲ₙ`, which is the orbit tangent by `L27_half_span`;
* **`L3_orbit_zero`**: `hessQ M K = 0` on that orbit tangent.
-/

namespace HamiltonsCubic.L3Quad

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen

/-- **The quadratic form under a spectral gap.** -/
theorem quad_le_of_gap {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
    {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) (c lstar : ℝ)
    (hgap : ∀ v : E, v ≠ 0 → ∀ μ : ℝ, T v = μ • v → μ ≠ c → μ ≤ lstar)
    (v : E) (hv : ∀ w : E, T w = c • w → inner ℝ w v = 0) :
    inner ℝ (T v) v ≤ lstar * ‖v‖ ^ 2 := by
  set b := hT.eigenvectorBasis rfl
  set e := hT.eigenvalues rfl
  have hTb : ∀ i, T (b i) = e i • b i := fun i => hT.apply_eigenvectorBasis rfl i
  have hexp : inner ℝ (T v) v = ∑ i, e i * inner ℝ (b i) v ^ 2 := by
    rw [← b.sum_inner_mul_inner (T v) v]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [hT v (b i), hTb, real_inner_smul_right, real_inner_comm v (b i)]
    ring
  have hnorm : ‖v‖ ^ 2 = ∑ i, inner ℝ (b i) v ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, ← b.sum_inner_mul_inner v v]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [real_inner_comm v (b i)]; ring
  rw [hexp, hnorm, Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  by_cases hci : e i = c
  · have h0 : inner ℝ (b i) v = 0 := hv (b i) (by rw [hTb, hci])
    rw [h0]; simp
  · have hb0 : b i ≠ 0 := by
      intro h
      have := b.orthonormal.1 i
      rw [h, norm_zero] at this
      exact zero_ne_one this
    have hle := hgap (b i) hb0 (e i) (hTb i) hci
    exact mul_le_mul_of_nonneg_right hle (sq_nonneg _)

variable {n : ℕ}

/-- **The Hessian's quadratic form at the balanced product, off the orbit tangent**: at a unit sphere product with
`p = q = m ≥ 4`, every Weyl `H ⊥ M` orthogonal to every `1/2`-eigenvector of `L_e` in `W^⊥ ∩ 𝒲ₙ` (the orbit tangent,
`L27_half_span`) has `hessQ M H ≤ −(6θ/(n − 2)) ‖H‖²`, with `θ = P(M) = t(n − 1)`. -/
theorem L3_hessian (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0) :
    hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H
      ≤ -(6 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) / ((T.card : ℝ) + Tᶜ.card - 2)) * normSq2 H := by
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
  set v : weylPerpR M := ⟨(RecCurv.equiv H : RecCurv (Fin n)), hHW, hperp⟩
  have key := quad_le_of_gap (LeRestr_isSymmetric ha hMW hcrit hP0) (1 / 2)
    (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)))
    (fun w hw μ hμ hne => by
      have hw0 : tanV w ≠ 0 := by
        intro h; apply hw; exact Subtype.ext h
      have he : LeLin M (tanV w) = μ • tanV w := congrArg Subtype.val hμ
      exact HamiltonsCubic.L3Gap.L3_gap_balanced T hp hpq t ht hn w.2.1 w.2.2 hw0 he hne)
    v (fun w hw => horb (tanV w) w.2.1 w.2.2 (congrArg Subtype.val hw))
  have hnorm : ‖v‖ ^ 2 = normSq2 H := RecCurv.norm_sq_eq (v : RecCurv (Fin n))
  have hin : inner ℝ (LeRestr ha hMW hcrit hP0 v) v = innerOp2 (LeLin M H) H := rfl
  rw [hnorm, hin] at key
  have hQ : hessQ M H = 6 * Pcubic2 M * (innerOp2 (LeLin M (tanV v)) (tanV v) - (1 / 2) * normSq2 (tanV v)) :=
    hessQ_eq_Le ha hMW hcrit hP0 v
  change hessQ M H = 6 * Pcubic2 M * (innerOp2 (LeLin M H) H - (1 / 2) * normSq2 H) at hQ
  rw [hQ, hPM]
  have hN : 0 ≤ normSq2 H := normSq2_nonneg H
  have e : ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) - 1 / 2 = -(1 / ((T.card : ℝ) + Tᶜ.card - 2)) := by
    rw [hqR, show (T.card : ℝ) + T.card - 2 = 2 * ((T.card : ℝ) - 1) by ring]
    have h1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
    field_simp; ring
  have h1 : innerOp2 (LeLin M H) H - (1 / 2) * normSq2 H ≤ -(1 / ((T.card : ℝ) + Tᶜ.card - 2)) * normSq2 H := by
    rw [← e]; nlinarith
  have h6 : 0 ≤ 6 * θ := by positivity
  calc 6 * θ * (innerOp2 (LeLin M H) H - (1 / 2) * normSq2 H)
      ≤ 6 * θ * (-(1 / ((T.card : ℝ) + Tᶜ.card - 2)) * normSq2 H) := mul_le_mul_of_nonneg_left h1 h6
    _ = -(6 * θ / ((T.card : ℝ) + Tᶜ.card - 2)) * normSq2 H := by ring

/-- **The Hessian vanishes on the orbit tangent**: at a unit sphere product with `p, q ≥ 2` and `θ > 0`, every Weyl `K ⊥ M` with
`L_e K = K/2` (the orbit tangent, by `L27_half_span` off `(3, 3)`) has `hessQ M K = 0`. -/
theorem L3_orbit_zero (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {K : CurvOp2 (Fin n)} (hKW : IsWeyl2 K)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0)
    (hK : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K) :
    hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 := by
  have hwt := (sphereWeight_isWeight T hp hq).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp hq t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  have ha : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • M := sphere_isCritical2 T hp hq t
  have hP0 : Pcubic2 M ≠ 0 := by rw [hPM]; exact hθ.ne'
  set v : weylPerpR M := ⟨(RecCurv.equiv K : RecCurv (Fin n)), hKW, hperp⟩
  have hQ := hessQ_eq_Le ha hMW hcrit hP0 v
  change hessQ M K = 6 * Pcubic2 M * (innerOp2 (LeLin M K) K - (1 / 2) * normSq2 K) at hQ
  rw [hQ, hK, innerOp2_smul_left]
  unfold normSq2; ring

end HamiltonsCubic.L3Quad
