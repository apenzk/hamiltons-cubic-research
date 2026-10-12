import Mathlib
import HamiltonsCubic.Results.L27Orbit
import HamiltonsCubic.Results.PairConv
import HamiltonsCubic.Results.L127Spec
import HamiltonsCubic.Results.FoxBridge

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L27's `1/2`-eigenspace on `W^⊥` is the span of the cross-pair orbit tangents

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L27: *$\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$,
attained exactly on the orbit tangent.*

[L27Orbit.lean](L27Orbit.lean)'s `L27_half_orbit` puts `E(1/2) ∩ W^⊥` inside the cross-pair orbit tangents. Here each cross
orbit tangent is typed as a Weyl operator `orbitOp T t j k` and shown to be a nonzero `1/2`-eigenvector in `W^⊥`, which gives
the value `1/2` as attained and the two inclusions:

* `corb`, `corb_sum`: the orbit tangent's coefficients, zero at `j, k`, summing to zero;
* `orbitOp`, `orbitOp_apply`, `orbitOp_nuX`: `T_jk` as a Weyl operator, equal to `orbitTan` on skew matrices and to `nuX j k corb`;
* **`orbitOp_props`**: at a cross pair `orbitOp` is Weyl of character `ε_j ε_k`, nonzero, orthogonal to `M`, and
  `L_e (orbitOp) = orbitOp / 2`;
* `crossOrbit`, `mem_cross`: the cross-pair orbit tangents indexed by `T ×ˢ Tᶜ`;
* **`L27_half_span`**: `H` Weyl, `H ⊥ M`, `L_e H = H/2` exactly when `H` is in the span of the cross-pair `orbitOp`.
-/

namespace HamiltonsCubic.L27Span

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.PairSquare HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.L27Sector HamiltonsCubic.L27Orbit HamiltonsCubic.DiagSquare

variable {n : ℕ}

/-- The orbit tangent's coefficients on the pair span, zero off the pair's index set. -/
noncomputable def corb (w : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) : Fin n → ℝ :=
  fun i => if j ≠ i ∧ k ≠ i then w j i - w k i else 0

theorem corb_sum {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) :
    ∑ i, corb w j k i = 0 := by
  have e : ∀ i, corb w j k i = (w j i - w k i) - (if i = j then -w k j else 0) - (if i = k then w j k else 0) := by
    intro i
    unfold corb
    by_cases hij : i = j
    · subst hij; simp [hjk, hw.hollow]
    · by_cases hik : i = k
      · subst hik; simp [Ne.symm hjk, hw.hollow]
      · simp [Ne.symm hij, Ne.symm hik, hij, hik]
  simp only [e, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true, hw.rowSum j, hw.rowSum k]
  rw [hw.symm k j]; ring

/-- **`T_jk` as a Weyl operator**, `restrictLin (pairVec j k corb)`. -/
noncomputable def orbitOp (T : Finset (Fin n)) (t : ℝ) (j k : Fin n) : CurvOp2 (Fin n) :=
  restrictLin (pairVec_lin j k (corb (t • sphereWeight T) j k)) (fun X _ => pairVec_skew j k _ X)

theorem pairVec_corb (w : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) (X : Matrix (Fin n) (Fin n) ℝ) :
    pairVec j k (corb w j k) X = pairVec j k (fun i => w j i - w k i) X := by
  unfold pairVec
  refine Finset.sum_congr rfl fun i hi => ?_
  unfold corb
  rw [if_pos (Finset.mem_filter.mp hi).2]

theorem orbitOp_apply (T : Finset (Fin n)) (t : ℝ) {j k : Fin n} (hjk : j ≠ k) (X : skewSub (Fin n)) :
    ((orbitOp T t j k X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = orbitTan (diagOp (t • sphereWeight T)) j k (X : Matrix (Fin n) (Fin n) ℝ) := by
  show pairVec j k (corb (t • sphereWeight T) j k) (X : Matrix (Fin n) (Fin n) ℝ) = _
  rw [pairVec_corb, orbit_pairVec _ (fun p q => by simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_symm T p q])
    (fun p => by simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_hollow T p, mul_zero]) hjk X.2]

theorem orbitOp_nuX (T : Finset (Fin n)) (t : ℝ) {j k : Fin n} (hjk : j ≠ k) :
    orbitOp T t j k = nuX j k (corb (t • sphereWeight T) j k) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show pairVec j k (corb (t • sphereWeight T) j k) (X : Matrix (Fin n) (Fin n) ℝ)
    = Smat j k * (X : Matrix (Fin n) (Fin n) ℝ) * diagonal (vy j k (corb (t • sphereWeight T) j k))
      + diagonal (vy j k (corb (t • sphereWeight T) j k)) * (X : Matrix (Fin n) (Fin n) ℝ) * Smat j k
  rw [← HamiltonsCubic.PairIdent.pairLin_eq_nuX hjk _ (by simp [corb]) (by simp [corb]) X.2]
  rfl

/-- **Each cross orbit tangent is a nonzero `1/2`-eigenvector in `W^⊥`.** -/
theorem orbitOp_props (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {j k : Fin n} (hj : j ∈ T) (hk : k ∉ T) :
    IsWeyl2 (orbitOp T t j k) ∧ SignChar (setChar {j, k}) (orbitOp T t j k) ∧ orbitOp T t j k ≠ 0 ∧
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t))) (orbitOp T t j k) = 0 ∧
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t))) (orbitOp T t j k)
        = (1 / 2 : ℝ) • orbitOp T t j k := by
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hwt : IsWeight (t • sphereWeight T) := (sphereWeight_isWeight T hp hq).smul t
  have hcj : corb (t • sphereWeight T) j k j = 0 := by simp [corb]
  have hck : corb (t • sphereWeight T) j k k = 0 := by simp [corb]
  have hsum := corb_sum hwt hjk
  have hW : IsWeyl2 (orbitOp T t j k) := by
    rw [orbitOp_nuX T t hjk]
    exact HamiltonsCubic.PairConv.nuX_weyl hjk _ (by rw [HamiltonsCubic.PairIdent.vy_of_zero _ hcj hck]; exact hsum)
  have hC : SignChar (setChar {j, k}) (orbitOp T t j k) := by
    rw [orbitOp_nuX T t hjk]; exact HamiltonsCubic.PairConv.nuX_char hjk _ hcj hck hsum
  obtain ⟨heigT, X, hX, hX0⟩ := cross_orbit_exists T hp hq t ht hj hk
  refine ⟨hW, hC, ?_, ?_, ?_⟩
  · intro h0
    apply hX0
    have := orbitOp_apply T t hjk ⟨X, hX⟩
    rw [h0] at this
    rw [← this]; rfl
  · -- characters `1` and `ε_j ε_k` are orthogonal, through the flip at `j`
    have hM1 : SignChar (fun _ => 1) (restrict (diagOp_isWeyl hwt)) :=
      (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hwt, rfl⟩
    set ε : Fin n → ℝ := fun i => if i = j then -1 else 1 with hεdef
    have hε : ∀ i, ε i * ε i = 1 := fun i => by by_cases h : i = j <;> simp [hεdef, h]
    refine char_orth hM1 hC hε ?_
    simp [setChar, hεdef, Finset.prod_insert, hjk, Ne.symm hjk]
  · -- the eigen-relation, from `cross_orbit_exists` on bivectors
    have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
      rw [← theta_of_unit _ hn]
      exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp hq t) hn
    have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
    have hP0 : Pcubic (diagOp (t • sphereWeight T)) ≠ 0 := by rw [hPθ]; exact mul_ne_zero ht.ne' (by
      have : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
      linarith)
    have hagree : ∀ Z : Matrix (Fin n) (Fin n) ℝ, IsSkew Z →
        pairVec j k (corb (t • sphereWeight T) j k) Z = orbitTan (diagOp (t • sphereWeight T)) j k Z := fun Z hZ => by
      rw [pairVec_corb, orbit_pairVec _ (fun p q => by simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_symm T p q])
        (fun p => by simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_hollow T p, mul_zero]) hjk hZ]
    refine (LeLin_pairVec_iff hwt hP0 j k _ (1 / 2)).mpr fun Z hZ => ?_
    rw [foxProd_congr_on_skew (fun W hW => (diagOp_isWeyl hwt).1 W hW) (fun W _ => pairVec_skew j k _ W)
      (fun _ _ => rfl) hagree Z hZ, heigT Z hZ, hagree Z hZ, hPθ]
    congr 1; ring

/-- The cross-pair orbit tangents, indexed by `T ×ˢ Tᶜ`. -/
noncomputable def crossOrbit (T : Finset (Fin n)) (t : ℝ) : ↥(T ×ˢ Tᶜ) → CurvOp2 (Fin n) :=
  fun p => orbitOp T t p.1.1 p.1.2

theorem mem_cross (T : Finset (Fin n)) (p : ↥(T ×ˢ Tᶜ)) : p.1.1 ∈ T ∧ p.1.2 ∉ T := by
  have := p.2
  rw [Finset.mem_product, Finset.mem_compl] at this
  exact this

/-- **L27's `1/2`-eigenspace on `W^⊥`**: at a unit sphere product with `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, a Weyl `H` has
`H ⊥ M` and `L_e H = H/2` exactly when `H` is in the span of the cross-pair orbit tangents. -/
theorem L27_half_span (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H) :
    (innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0 ∧
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = (1 / 2 : ℝ) • H)
      ↔ H ∈ Submodule.span ℝ (Set.range (crossOrbit T t)) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  set M := restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp2 hq2).smul t)) with hMdef
  constructor
  · rintro ⟨hperp, heig⟩
    rw [← sum_comp H hHW]
    refine Submodule.sum_mem _ fun s _ => ?_
    by_cases hs0 : comp s H hHW = 0
    · rw [hs0]; exact Submodule.zero_mem _
    obtain ⟨j, k, hj, hk, rfl, a, ha⟩ :=
      L27_half_orbit T hp hq hne t ht hn hHW hperp heig s hs0
    have hjk : j ≠ k := fun h => hk (h ▸ hj)
    have e : comp {j, k} H hHW = a • orbitOp T t j k := by
      refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
      rw [ha X.1 X.2, ContinuousLinearMap.smul_apply, Submodule.coe_smul, orbitOp_apply T t hjk X]
    rw [e]
    refine Submodule.smul_mem _ a (Submodule.subset_span ⟨⟨(j, k), ?_⟩, rfl⟩)
    rw [Finset.mem_product, Finset.mem_compl]; exact ⟨hj, hk⟩
  · intro hmem
    clear hHW
    induction hmem using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨p, rfl⟩ := hx
      obtain ⟨-, -, -, h1, h2⟩ := orbitOp_props T hp2 hq2 t ht hn (mem_cross T p).1 (mem_cross T p).2
      exact ⟨h1, h2⟩
    | zero =>
      refine ⟨?_, by rw [map_zero, smul_zero]⟩
      have h := innerOp2_add_right M 0 0
      have h00 : (0 : CurvOp2 (Fin n)) + 0 = 0 := add_zero (0 : CurvOp2 (Fin n))
      rw [h00] at h
      linarith
    | add x y _ _ hx hy =>
      exact ⟨by rw [innerOp2_add_right, hx.1, hy.1, add_zero], by rw [map_add, hx.2, hy.2]; module⟩
    | smul a x _ hx =>
      exact ⟨by rw [innerOp2_smul_right, hx.1, mul_zero], by rw [map_smul, hx.2, smul_comm]⟩

end HamiltonsCubic.L27Span
