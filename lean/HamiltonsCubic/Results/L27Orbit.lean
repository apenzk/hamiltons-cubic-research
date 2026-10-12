import Mathlib
import HamiltonsCubic.Results.L27Main
import HamiltonsCubic.Results.L126Orbit
import HamiltonsCubic.Results.L127Mult

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L27's `1/2`-eigenvectors are orbit tangents

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L27: *$\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$,
attained exactly on the orbit tangent.* Lemma L207: *the cross-pair $\tfrac12$-eigenvector IS the orbit direction.*

[L27Main.lean](L27Main.lean)'s `L27_half` puts every nonzero isotypic component of a `1/2`-eigenvector on a cross pair. Here
that component is the orbit tangent `T_jk = orbitTan M j k` of [L126Orbit.lean](L126Orbit.lean) up to a scalar:

* `rk2_phi_self_left`, `rk2_phi_self_right`: `rk2` vanishes when one argument is `φ_{ii} = 0`;
* **`orbit_pairVec`**: `T_jk` is `pairVec j k c` with `c_i = w_{ji} − w_{ki}`, from `orbit_in_pairBlock`;
* **`cross_half_line`**: at a sphere product and a cross pair, a Ricci-cut coefficient vector carrying `θ/2` is a multiple of
  `(w_{ji} − w_{ki})_i` on the pair's index set, through `cross_top_iff`;
* `comp_LeLin`: the eigen-equation carried to a component in `L_e` units;
* **`L27_half_orbit`**: at `λ = 1/2` every nonzero isotypic component of `H ⊥ M` is `a · T_jk` for a cross pair `{j, k}`.
-/

namespace HamiltonsCubic.L27Orbit

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.PairSquare HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.L27Sector

variable {n : ℕ}

theorem rk2_phi_self_left (i : Fin n) (V X : Matrix (Fin n) (Fin n) ℝ) : rk2 (phi i i) V X = 0 := by
  unfold rk2; rw [phi_self]; ext a b; simp [inner2]

theorem rk2_phi_self_right (i : Fin n) (U X : Matrix (Fin n) (Fin n) ℝ) : rk2 U (phi i i) X = 0 := by
  unfold rk2; rw [phi_self]; ext a b; simp [inner2]

/-- **The orbit tangent on the pair span**: `T_jk = pairVec j k (w_{j·} − w_{k·})` on skew matrices. -/
theorem orbit_pairVec (w : Matrix (Fin n) (Fin n) ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) {j k : Fin n}
    (hjk : j ≠ k) {X : Matrix (Fin n) (Fin n) ℝ} (hX : IsSkew X) :
    orbitTan (diagOp w) j k X = pairVec j k (fun i => w j i - w k i) X := by
  rw [orbit_in_pairBlock w hw hh hjk hX]
  unfold pairVec
  rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (fun i => j ≠ i ∧ k ≠ i)]
  have h0 : ∑ i ∈ univ.filter (fun i => ¬(j ≠ i ∧ k ≠ i)), (w j i - w k i) • rk2 (phi j i) (phi k i) X = 0 := by
    refine Finset.sum_eq_zero fun i hi => ?_
    have hi' : j = i ∨ k = i := by
      have := (Finset.mem_filter.mp hi).2
      by_contra hc; push Not at hc; exact this hc
    rcases hi' with rfl | rfl
    · rw [rk2_phi_self_left, smul_zero]
    · rw [rk2_phi_self_right, smul_zero]
  rw [h0, add_zero]

/-- **The cross pair's `θ/2`-line**: a Ricci-cut coefficient vector carrying `θ/2` at a sphere product is a multiple of the
orbit tangent's coefficients on the pair's index set. -/
theorem cross_half_line (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : Fin n}
    (hj : j ∈ T) (hk : k ∉ T) (c : Fin n → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
    (h : ∀ X : Matrix (Fin n) (Fin n) ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (pairVec j k c) X
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2) • pairVec j k c X) :
    ∃ a : ℝ, ∀ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
      c i = a * ((t • sphereWeight T) j i - (t • sphereWeight T) k i) := by
  have hc := (cross_top_iff T hp hq t ht hj hk c hsum).mp h
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  set ST := ∑ i ∈ s.filter (· ∈ T), c i
  set SO := ∑ i ∈ s.filter (· ∉ T), c i
  have hSO : SO = -ST := by
    have := Finset.sum_filter_add_sum_filter_not s (· ∈ T) c
    rw [hsum] at this; linarith
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : t * ((T.card : ℝ) + Tᶜ.card - 1) ≠ 0 := mul_ne_zero ht.ne' (by linarith)
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  have hn1 : (T.card : ℝ) + Tᶜ.card - 1 ≠ 0 := by linarith
  have hn1' : -1 + (Tᶜ.card : ℝ) + T.card ≠ 0 := by linarith
  refine ⟨ST / (t * ((T.card : ℝ) + Tᶜ.card - 1)), fun i hi => ?_⟩
  have hji : j ≠ i := ((Finset.mem_filter.mp hi).2).1
  have hki : k ≠ i := ((Finset.mem_filter.mp hi).2).2
  rw [hc i hi]
  simp only [Matrix.smul_apply, smul_eq_mul]
  by_cases hiT : i ∈ T
  · rw [if_pos hiT, sphereWeight_in T hj hiT hji, sphereWeight_symm T k i, sphereWeight_cross T hiT hk]
    field_simp [hn1, hn1']
    ring
  · rw [if_neg hiT, hSO, sphereWeight_cross T hj hiT, sphereWeight_out T hk hiT hki]
    field_simp [hn1, hn1']
    ring

/-- The eigen-equation on a component, in `L_e` units. -/
theorem comp_LeLin (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t))) H = lam • H)
    (s : Finset (Fin n)) :
    LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t))) (comp s H hHW) = lam • comp s H hHW := by
  set w := t • sphereWeight T with hwdef
  have hwt : IsWeight w := (sphereWeight_isWeight T hp hq).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hM1 : SignChar (fun _ => 1) M := (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hwt, rfl⟩
  have hPθ : Pcubic (diagOp w) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp hq t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp w) (diagOp_isWeyl hwt), hPθ]
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  set θ := t * ((T.card : ℝ) + Tᶜ.card - 1) with hθdef
  have hθ : 0 < θ := mul_pos ht (by linarith)
  have hLe : ∀ V : CurvOp2 (Fin n), LeLin M V = θ⁻¹ • foxProd2 M V := fun V => by
    rw [← hPM]; exact foxProd2_smul_left _ _ _
  have hfox : foxProd2 M H = (lam * θ) • H := by
    have h2 := congrArg (fun F => θ • F) (heig.symm.trans (hLe H))
    simp only [smul_smul, mul_inv_cancel₀ hθ.ne', one_smul] at h2
    rw [← h2, mul_comm]
  rw [hLe, comp_eigen hM1 hHW hfox s, smul_smul]
  congr 1
  field_simp

/-- **L27's `1/2`-eigenvectors are orbit tangents**: at a unit sphere product with `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, a Weyl
`H ⊥ M` with `L_e H = H/2` has every nonzero isotypic component equal to `a · T_jk` on skew matrices, for a cross pair
`{j, k}`, `j ∈ T`, `k ∉ T`. -/
theorem L27_half_orbit (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = (1 / 2 : ℝ) • H)
    (s : Finset (Fin n)) (hs0 : comp s H hHW ≠ 0) :
    ∃ j k : Fin n, j ∈ T ∧ k ∉ T ∧ s = {j, k} ∧ ∃ a : ℝ, ∀ X : Matrix (Fin n) (Fin n) ℝ, (hX : IsSkew X) →
      ((comp s H hHW ⟨X, hX⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
        = a • orbitTan (diagOp (t • sphereWeight T)) j k X := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  obtain ⟨j, k, hj, hk, rfl⟩ :=
    (HamiltonsCubic.L27Main.comp_sector T hp hq hne t ht hn hHW hperp heig s hs0).2 rfl
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  refine ⟨j, k, hj, hk, rfl, ?_⟩
  have hwt := (sphereWeight_isWeight T hp2 hq2).smul t
  have hcLe := comp_LeLin T hp2 hq2 t ht hn hHW heig {j, k}
  obtain ⟨c, hsum, hV⟩ := HamiltonsCubic.L27Pair.pair_eq_pairVec hjk (comp_isWeyl2 _ H hHW) (comp_char _ H hHW)
  rw [hV] at hcLe
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp2
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq2
  have hP0 : Pcubic (diagOp (t • sphereWeight T)) ≠ 0 := by rw [hPθ]; exact mul_ne_zero ht.ne' (by linarith)
  have hf := (LeLin_pairVec_iff hwt hP0 j k c (1 / 2)).mp hcLe
  have hf' : ∀ X : Matrix (Fin n) (Fin n) ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (pairVec j k c) X
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2) • pairVec j k c X := fun X hX => by
    rw [hf X hX, hPθ]; ring_nf
  obtain ⟨a, ha⟩ := cross_half_line T hp2 hq2 t ht hj hk c hsum hf'
  refine ⟨a, fun X hX => ?_⟩
  rw [hV]
  show pairVec j k c X = _
  rw [orbit_pairVec _ (fun p q => by simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_symm T p q])
    (fun p => by simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_hollow T p, mul_zero]) hjk hX]
  unfold pairVec
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun i hi => ?_
  rw [ha i hi, smul_smul]

end HamiltonsCubic.L27Orbit
