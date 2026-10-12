import Mathlib
import HamiltonsCubic.Results.L27Span
import HamiltonsCubic.Results.L126Kernel
import HamiltonsCubic.Results.L122Cap
import HamiltonsCubic.Results.FourStep4

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L27 closed: `E(1/2) ∩ W^⊥` has dimension `pq`, is the orbit tangent, and is the kernel of the criticality map

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L27: *Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$,
attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$ is Morse–Bott nondegenerate.*

* `LeLin_selfAdj`, `LeLin_perp`, `LeLin_weyl`: at a critical Weyl `M`, `L_e` is self-adjoint and maps `W^⊥ ∩ 𝒲ₙ` into itself, so
  its eigenvalues on `W^⊥` bound its spectrum there;
* `signChar_sum`, `pr_inj`, **`crossOrbit_indep`**: the cross-pair orbit tangents are linearly independent, one per
  character `ε_j ε_k`, through `split_unique`;
* **`finrank_half`**: their span, which is `E(1/2) ∩ W^⊥` by `L27_half_span`, has dimension `pq`;
* **`orbit_tangent_cases`**: every orbit tangent `T_ab` is zero (a within-factor pair) or `± T_jk` for a cross pair, so the orbit
  tangent space is that same span, of dimension `pq`;
* **`L27_kernel`**: `H ∈ W^⊥ ∩ 𝒲ₙ` is in the kernel of the criticality map's derivative `2 M ∘ H − θ H` exactly when it is in the
  orbit tangent, which is Morse–Bott nondegeneracy.
-/

namespace HamiltonsCubic.L27Close

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.PairSquare HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.L27Sector HamiltonsCubic.L27Orbit
  HamiltonsCubic.L27Span HamiltonsCubic.L221Ops

variable {n : ℕ}

/-- **`L_e` is self-adjoint.** -/
theorem LeLin_selfAdj {M A B : CurvOp2 (Fin n)} (hM : IsWeyl2 M) (hA : IsWeyl2 A) (hB : IsWeyl2 B) :
    innerOp2 (LeLin M A) B = innerOp2 A (LeLin M B) := by
  show innerOp2 (foxProd2 ((Pcubic2 M)⁻¹ • M) A) B = innerOp2 A (foxProd2 ((Pcubic2 M)⁻¹ • M) B)
  rw [foxProd2_smul_left, foxProd2_smul_left, innerOp2_smul_left, innerOp2_smul_right,
    HamiltonsCubic.FourStep4.inner_fox_move hM.isSelfAdjoint2 hA.isSelfAdjoint2 hB.isSelfAdjoint2,
    innerOp2_comm A, HamiltonsCubic.FourStep4.inner_fox_move hM.isSelfAdjoint2 hB.isSelfAdjoint2 hA.isSelfAdjoint2,
    foxProd2_comm B A]

/-- **`L_e` maps `W^⊥` into itself** at a critical `M`. -/
theorem LeLin_perp {M H : CurvOp2 (Fin n)} (hM : IsWeyl2 M) (hH : IsWeyl2 H) {θ : ℝ}
    (hcrit : foxProd2 M M = θ • M) (hperp : innerOp2 M H = 0) : innerOp2 M (LeLin M H) = 0 := by
  show innerOp2 M (foxProd2 ((Pcubic2 M)⁻¹ • M) H) = 0
  rw [foxProd2_smul_left, innerOp2_smul_right, innerOp2_comm, foxProd2_comm,
    HamiltonsCubic.FourStep4.inner_fox_move hH.isSelfAdjoint2 hM.isSelfAdjoint2 hM.isSelfAdjoint2, hcrit,
    innerOp2_smul_right, innerOp2_comm H M, hperp, mul_zero, mul_zero]

theorem LeLin_weyl {M H : CurvOp2 (Fin n)} (hM : IsWeyl2 M) (hH : IsWeyl2 H) : IsWeyl2 (LeLin M H) := by
  show IsWeyl2 (foxProd2 ((Pcubic2 M)⁻¹ • M) H)
  exact isWeyl2_foxProd2 (isWeyl2_smul _ hM) hH

theorem signChar_sum {c : (Fin n → ℝ) → ℝ} {κ : Type*} (s : Finset κ) (f : κ → CurvOp2 (Fin n))
    (h : ∀ k ∈ s, SignChar c (f k)) : SignChar c (∑ k ∈ s, f k) := by
  classical
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty]; exact signChar_zero _
  | insert a s ha ih =>
    rw [Finset.sum_insert ha]
    exact signChar_add (h a (Finset.mem_insert_self a s)) (ih fun k hk => h k (Finset.mem_insert_of_mem hk))

/-- A cross pair is determined by its underlying set. -/
theorem pr_inj (T : Finset (Fin n)) {p q : ↥(T ×ˢ Tᶜ)}
    (h : ({p.1.1, p.1.2} : Finset (Fin n)) = {q.1.1, q.1.2}) : p = q := by
  obtain ⟨hp1, hp2⟩ := mem_cross T p
  obtain ⟨hq1, hq2⟩ := mem_cross T q
  have hj : p.1.1 ∈ ({q.1.1, q.1.2} : Finset (Fin n)) := by rw [← h]; simp
  have hk : p.1.2 ∈ ({q.1.1, q.1.2} : Finset (Fin n)) := by rw [← h]; simp
  simp only [Finset.mem_insert, Finset.mem_singleton] at hj hk
  have e1 : p.1.1 = q.1.1 := by
    rcases hj with h' | h'
    · exact h'
    · exact absurd (h' ▸ hp1) hq2
  have e2 : p.1.2 = q.1.2 := by
    rcases hk with h' | h'
    · exact absurd (h' ▸ hq1) hp2
    · exact h'
  exact Subtype.ext (Prod.ext e1 e2)

set_option maxHeartbeats 1600000 in
/-- **The cross-pair orbit tangents are linearly independent.** -/
theorem crossOrbit_indep (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) : LinearIndependent ℝ (crossOrbit T t) := by
  refine (Fintype.linearIndependent_iff (ι := ↥(T ×ˢ Tᶜ)) (R := ℝ) (M := CurvOp2 (Fin n))
    (v := crossOrbit T t)).mpr ?_
  intro g hg p0
  set pr : ↥(T ×ˢ Tᶜ) → Finset (Fin n) := fun p => {p.1.1, p.1.2} with hprdef
  set A : Finset (Fin n) → CurvOp2 (Fin n) :=
    fun u => ∑ p ∈ univ.filter (fun p => pr p = u), g p • crossOrbit T t p with hAdef
  have hA : ∀ u, SignChar (setChar u) (A u) := fun u =>
    signChar_sum _ _ fun p hpm => by
      have hpu : pr p = u := (Finset.mem_filter.mp hpm).2
      have hc := (orbitOp_props T hp hq t ht hn (mem_cross T p).1 (mem_cross T p).2).2.1
      rw [← hpu]
      exact signChar_smul hc _
  have hsum : ∑ u, A u = 0 := by
    simp only [hAdef]
    rw [Finset.sum_fiberwise]
    exact hg
  have h0 := split_unique hA hsum (pr p0)
  have hsingle : A (pr p0) = g p0 • crossOrbit T t p0 := by
    simp only [hAdef]
    refine Finset.sum_eq_single p0 (fun p hp hne => absurd (pr_inj T (Finset.mem_filter.mp hp).2) hne) ?_
    intro h; exact (h (Finset.mem_filter.mpr ⟨Finset.mem_univ p0, rfl⟩)).elim
  rw [hsingle] at h0
  by_contra hg
  apply (orbitOp_props T hp hq t ht hn (mem_cross T p0).1 (mem_cross T p0).2).2.2.1
  have e := congrArg (fun F : CurvOp2 (Fin n) => (g p0)⁻¹ • F) h0
  simp only [smul_smul, inv_mul_cancel₀ hg, one_smul] at e
  exact e.trans (by module)

/-- **`dim E(1/2) ∩ W^⊥ = pq`**: the span of the cross-pair orbit tangents has dimension `|T| · |Tᶜ|`. -/
theorem finrank_half (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    Module.finrank ℝ (Submodule.span ℝ (Set.range (crossOrbit T t))) = T.card * Tᶜ.card := by
  rw [finrank_span_eq_card (crossOrbit_indep T hp hq t ht hn), Fintype.card_coe, Finset.card_product]

theorem pairVec_neg (j k : Fin n) (c : Fin n → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    pairVec j k (fun i => -c i) X = -pairVec j k c X := by
  unfold pairVec
  rw [← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun i _ => neg_smul _ _

/-- **Every orbit tangent is zero or a cross-pair orbit tangent up to sign**, so the orbit tangent space is the span of
`crossOrbit`, of dimension `pq` by `finrank_half`. -/
theorem orbit_tangent_cases (T : Finset (Fin n)) (t : ℝ) {a b : Fin n} (hab : a ≠ b) :
    (∀ X : Matrix (Fin n) (Fin n) ℝ, IsSkew X → orbitTan (diagOp (t • sphereWeight T)) a b X = 0) ∨
      ∃ q : ↥(T ×ˢ Tᶜ), ∃ s : ℝ, (s = 1 ∨ s = -1) ∧ ∀ X : skewSub (Fin n),
        orbitTan (diagOp (t • sphereWeight T)) a b (X : Matrix (Fin n) (Fin n) ℝ)
          = s • ((crossOrbit T t q X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) := by
  set w := t • sphereWeight T with hwdef
  have hw : ∀ p q, w p q = w q p := fun p q => by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_symm T p q]
  have hh : ∀ p, w p p = 0 := fun p => by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_hollow T p, mul_zero]
  by_cases ha : a ∈ T <;> by_cases hb : b ∈ T
  · -- within `T`
    left
    refine fun X hX => orbitTan_within_zero w hw hh hab (fun i hia hib => ?_) hX
    simp only [w, Matrix.smul_apply, smul_eq_mul]
    by_cases hi : i ∈ T
    · rw [sphereWeight_in T ha hi (Ne.symm hia), sphereWeight_in T hb hi (Ne.symm hib)]
    · rw [sphereWeight_cross T ha hi, sphereWeight_cross T hb hi]
  · -- cross, `a ∈ T`
    right
    refine ⟨⟨(a, b), by rw [Finset.mem_product, Finset.mem_compl]; exact ⟨ha, hb⟩⟩, 1, Or.inl rfl, fun X => ?_⟩
    rw [one_smul]
    exact (orbitOp_apply T t hab X).symm
  · -- cross, `b ∈ T`: `T_ab = −T_ba`
    right
    refine ⟨⟨(b, a), by rw [Finset.mem_product, Finset.mem_compl]; exact ⟨hb, ha⟩⟩, -1, Or.inr rfl, fun X => ?_⟩
    show _ = (-1 : ℝ) • ((orbitOp T t b a X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
    rw [orbitOp_apply T t (Ne.symm hab) X, orbit_pairVec w hw hh hab X.2, orbit_pairVec w hw hh (Ne.symm hab) X.2,
      HamiltonsCubic.L27Pair.pairVec_comm, neg_one_smul, ← pairVec_neg]
    congr 1; funext i; ring
  · -- within `Tᶜ`
    left
    refine fun X hX => orbitTan_within_zero w hw hh hab (fun i hia hib => ?_) hX
    simp only [w, Matrix.smul_apply, smul_eq_mul]
    by_cases hi : i ∈ T
    · rw [sphereWeight_symm T a i, sphereWeight_symm T b i, sphereWeight_cross T hi ha, sphereWeight_cross T hi hb]
    · rw [sphereWeight_out T ha hi (Ne.symm hia), sphereWeight_out T hb hi (Ne.symm hib)]

/-- **Morse–Bott nondegeneracy at a sphere product**: at `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, a Weyl `H ⊥ M` is in the kernel of the
criticality map's derivative `2 M ∘ H − θ H` exactly when it is in the span of the cross-pair orbit tangents, which is the orbit
tangent space (`orbit_tangent_cases`), of dimension `pq` (`finrank_half`). -/
theorem L27_kernel (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0) :
    (2 : ℝ) • foxProd2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H
        - Pcubic2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) • H = 0
      ↔ H ∈ Submodule.span ℝ (Set.range (crossOrbit T t)) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hP0 : Pcubic2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp2 hq2).smul t))) ≠ 0 := by
    rw [Pcubic2_restrict (isLinOp_diagOp _), hPθ]
    exact mul_ne_zero ht.ne' (by linarith)
  rw [critMap_kernel_iff hP0]
  constructor
  · intro h; exact (L27_half_span T hp hq hne t ht hn hHW).mp ⟨hperp, h⟩
  · intro h; exact ((L27_half_span T hp hq hne t ht hn hHW).mpr h).2

end HamiltonsCubic.L27Close
