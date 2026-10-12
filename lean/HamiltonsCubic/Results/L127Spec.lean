import HamiltonsCubic.Results.L127Cross
import HamiltonsCubic.Results.L126General

set_option linter.style.longLine false

/-!
# L127's cross-factor spectrum as a theorem: every eigenvalue on the Ricci cut is `0` or `θ/2`

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, cross-factor row, and
[r1611](../../../reviews/REVIEW_r1611.md)'s owed spectrum. From [L127Cross.lean](L127Cross.lean)'s `crossPair`:

* **`pair_eval`**: `(∑_{i∈s} d_i f_i)(φ_jq) = d_q φ_kq`, so the pair-span coefficients are read off the operator;
* **`cross_filter_in`**, **`cross_filter_out`**: the two factors of the pair indices are `T ∖ {j}` and `Tᶜ ∖ {k}`;
* **`cross_spectrum`**: every eigenvalue of `M ∘` on a nonzero Ricci-cut vector of the cross pair span is `0` or
  `t(n − 1)/2`, the criticality multiplier halved, which is `θ` halved at unit norm by
  [L74Statement.lean](L74Statement.lean)'s `theta_of_critical_unit` with `sphere_isCritical`;
* **`cross_orbit_exists`**: `θ/2` occurs, on the nonzero orbit tangent. The multiplicities and the division by `θ` into
  `L_e` units are prose.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The pair-span coefficients are read off at `φ_jq`**: `(∑_{i∈s} d_i f_i)(φ_jq) = d_q φ_kq`. -/
theorem pair_eval {j k : ι} (hjk : j ≠ k) (s : Finset ι) (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (d : ι → ℝ) {q : ι}
    (hq : q ∈ s) : ∑ i ∈ s, d i • rk2 (phi j i) (phi k i) (phi j q) = d q • phi k q := by
  have hterm : ∀ i ∈ s, d i • rk2 (phi j i) (phi k i) (phi j q) = if i = q then d q • phi k q else 0 := by
    intro i hi
    obtain ⟨hji, hki⟩ := hs i hi
    unfold rk2
    rw [inner2_phi_phi, inner2_phi_phi]
    by_cases hiq : i = q
    · subst hiq; simp [Ne.symm hjk, hji.symm]
    · simp [hiq, hji.symm]
  rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq' s q, if_pos hq]

omit [Fintype ι] in
theorem phi_entry' {p q : ι} (hpq : p ≠ q) (c : ℝ) : (c • phi p q) q p = c := by
  simp [phi, hpq, hpq.symm]

theorem cross_filter_in (T : Finset ι) {j k : ι} (_hj : j ∈ T) (hk : k ∉ T) :
    (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T) = T.erase j := by
  ext i
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_erase]
  constructor
  · rintro ⟨⟨h1, _⟩, h3⟩; exact ⟨Ne.symm h1, h3⟩
  · rintro ⟨h1, h3⟩; exact ⟨⟨Ne.symm h1, fun h => hk (h ▸ h3)⟩, h3⟩

theorem cross_filter_out (T : Finset ι) {j k : ι} (hj : j ∈ T) (_hk : k ∉ T) :
    (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T) = Tᶜ.erase k := by
  ext i
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_erase, Finset.mem_compl]
  constructor
  · rintro ⟨⟨_, h2⟩, h3⟩; exact ⟨Ne.symm h2, h3⟩
  · rintro ⟨h2, h3⟩; exact ⟨⟨fun h => h3 (h ▸ hj), Ne.symm h2⟩, h3⟩

/-- **THE CROSS-FACTOR SPECTRUM**: at a sphere product, `j ∈ T`, `k ∉ T`, every eigenvalue of `M ∘` on the Ricci cut of
the pair span (a nonzero `∑ c_i f_i`, `∑ c_i = 0`, with `M ∘ v = λ v` on every bivector) is `0` or `t(n − 1)/2`,
the latter being `θ/2` with `θ = t(n − 1)` the criticality multiplier. -/
theorem cross_spectrum (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) {j k : ι} (hj : j ∈ T)
    (hk : k ∉ T) (c : ι → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
    (hne : ∃ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q ≠ 0) (lam : ℝ)
    (heig : ∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X
        = lam • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X) :
    lam = 0 ∨ lam = t * ((T.card : ℝ) + Tᶜ.card - 1) / 2 := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  set CT := ∑ i ∈ s.filter (· ∈ T), c i
  set CO := ∑ i ∈ s.filter (· ∉ T), c i
  set AT := (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t)
  set AO := (1 / 2 : ℝ) * (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t)
  -- the eigen-equation, coefficient by coefficient
  have key : ∀ q ∈ s, (if q ∈ T then AT * CT else AO * CO) = lam * c q := by
    intro q hq
    have e := heig (phi j q) (phi_isSkew j q)
    have hc := crossPair T t hj hk c hsum (phi_isSkew j q)
    rw [hc, pair_eval hjk s hs _ hq, pair_eval hjk s hs c hq, smul_smul] at e
    have e2 := congrArg (fun A : Matrix ι ι ℝ => A q k) e
    change (_ • phi k q) q k = (_ • phi k q) q k at e2
    rw [phi_entry' (hs q hq).2, phi_entry' (hs q hq).2] at e2
    exact e2
  -- sum over each factor
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have cardT : ((s.filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 1 := by
    rw [hsdef, cross_filter_in T hj hk, Finset.card_erase_of_mem hj, Nat.cast_sub (by omega)]; simp
  have cardO : ((s.filter (· ∉ T)).card : ℝ) = (Tᶜ.card : ℝ) - 1 := by
    rw [hsdef, cross_filter_out T hj hk, Finset.card_erase_of_mem (Finset.mem_compl.mpr hk), Nat.cast_sub (by omega)]
    simp
  have sT : AT * CT * ((T.card : ℝ) - 1) = lam * CT := by
    have : ∑ q ∈ s.filter (· ∈ T), (AT * CT) = ∑ q ∈ s.filter (· ∈ T), lam * c q :=
      Finset.sum_congr rfl fun q hq => by
        have h := key q (Finset.mem_filter.mp hq).1; rw [if_pos (Finset.mem_filter.mp hq).2] at h; exact h
    rw [Finset.sum_const, nsmul_eq_mul, cardT, ← Finset.mul_sum] at this; linarith
  have sO : AO * CO * ((Tᶜ.card : ℝ) - 1) = lam * CO := by
    have : ∑ q ∈ s.filter (· ∉ T), (AO * CO) = ∑ q ∈ s.filter (· ∉ T), lam * c q :=
      Finset.sum_congr rfl fun q hq => by
        have h := key q (Finset.mem_filter.mp hq).1; rw [if_neg (Finset.mem_filter.mp hq).2] at h; exact h
    rw [Finset.sum_const, nsmul_eq_mul, cardO, ← Finset.mul_sum] at this; linarith
  obtain ⟨kT, kO⟩ := cross_kappa T hp hq t
  have h1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have h2 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  have eT : AT * ((T.card : ℝ) - 1) = t * ((T.card : ℝ) + Tᶜ.card - 1) / 2 := by
    simp only [AT]; rw [kT]; field_simp
  have eO : AO * ((Tᶜ.card : ℝ) - 1) = t * ((T.card : ℝ) + Tᶜ.card - 1) / 2 := by
    simp only [AO]; rw [kO]; field_simp
  by_cases hl : lam = t * ((T.card : ℝ) + Tᶜ.card - 1) / 2
  · exact Or.inr hl
  · left
    have hCT : CT = 0 := by
      have : (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2 - lam) * CT = 0 := by rw [← eT]; linarith
      exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr (Ne.symm hl))
    have hCO : CO = 0 := by
      have : (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2 - lam) * CO = 0 := by rw [← eO]; linarith
      exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr (Ne.symm hl))
    obtain ⟨q, hq, hcq⟩ := hne
    have h := key q hq
    rw [hCT, hCO, mul_zero, mul_zero, ite_self] at h
    exact (mul_eq_zero.mp h.symm).resolve_right hcq

/-- **`θ/2` OCCURS IN THE CROSS BLOCK**: at a sphere product, `j ∈ T`, `k ∉ T`, the orbit tangent `T_jk` satisfies
`M ∘ T_jk = (t(n − 1)/2) T_jk` (`orbit_eigen` at `sphere_diagCrit`), and it is nonzero, its value at `φ_jq` being
`(α + t) φ_kq` for any `q ∈ T ∖ {j}`. -/
theorem cross_orbit_exists (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∉ T) :
    (∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (orbitTan (diagOp (t • sphereWeight T)) j k) X
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2) • orbitTan (diagOp (t • sphereWeight T)) j k X)
    ∧ ∃ X : Matrix ι ι ℝ, IsSkew X ∧ orbitTan (diagOp (t • sphereWeight T)) j k X ≠ 0 := by
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  obtain ⟨hw, hh, hc⟩ := HamiltonsCubic.L126Assembly.sphere_diagCrit T hp hq t
  refine ⟨fun X hX => ?_, ?_⟩
  · rw [orbit_eigen _ hw hh hc hjk hX]
  · -- a second index of `T`
    obtain ⟨q, hqT, hqj⟩ : ∃ q ∈ T, q ≠ j := by
      by_contra h; push Not at h
      have : T ⊆ {j} := fun x hx => Finset.mem_singleton.mpr (h x hx)
      have := Finset.card_le_card this; simp at this; omega
    have hkq : k ≠ q := fun h => hk (h ▸ hqT)
    refine ⟨phi j q, phi_isSkew j q, fun h0 => ?_⟩
    rw [orbit_in_pairBlock _ hw hh hjk (phi_isSkew j q), pairSum_restrict hjk,
      pair_eval hjk _ (fun i hi => (Finset.mem_filter.mp hi).2) _ (Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm hqj, hkq⟩)] at h0
    have e := congrArg (fun A : Matrix ι ι ℝ => A q k) h0
    change (_ • phi k q) q k = (0 : Matrix ι ι ℝ) q k at e
    rw [phi_entry' hkq] at e
    simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hj hqT (Ne.symm hqj), Matrix.zero_apply] at e
    rw [sphereWeight_symm, sphereWeight_cross T hqT hk] at e
    have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
    have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
    have : 0 < t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) := by
      apply mul_pos ht; apply div_pos (by linarith) (by linarith)
    linarith

end HamiltonsCubic.L121Block
