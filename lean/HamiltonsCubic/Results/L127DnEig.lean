import HamiltonsCubic.Results.L127DnMult
import HamiltonsCubic.Results.L127DnCount

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` eigenspaces and their dimensions

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnMult.lean](L127DnMult.lean)'s
`dn_eigen_parts` shows an eigen-weight has no part outside the families carrying its value. This file names the
eigenspaces of `M ∘` on `𝒟ₙ` (`KL`'s eigenspaces cut to the weights) and computes their dimensions at the sphere product
with `p, q ≥ 3` and `t ≠ 0`, where the unit values `1`, `λ_p`, `λ_q`, `−μ`, `0` are distinct except `λ_p = λ_q` at
`p = q` (`dn_units` for the sign and size bounds, [L127DnLam.lean](L127DnLam.lean)'s `dnLp_eq_dnLq_iff` for
`λ_p = λ_q`):

* **`dnWeights`**: `𝒟ₙ`'s weights as a subspace;
* **`KL_of_fox`**, **`K_of_KL`**: the eigen-relations of `M ∘` on the `φ_{ab}`, of `KL`, and of `K` off the diagonal
  are one relation;
* **`dn_eig_cross`**, **`finrank_eig_cross`**: the `θ(−μ)`-eigenspace is the cross family, dimension `(p − 1)(q − 1)`;
* **`dn_eig_line`**, **`finrank_eig_line`**: the `θ`-eigenspace is the sphere-weight line, dimension `1`;
* **`dn_eig_zero`**, **`finrank_eig_zero`**: the `0`-eigenspace is the two zero families, dimension
  `(binom p 2 − p) + (binom q 2 − q)`, the record's `0^{rest}`.

[L127DnLam.lean](L127DnLam.lean) declares the `θ λ_p`- and `θ λ_q`-eigenspaces, dimension `p − 1` and `q − 1` at
`p ≠ q` and `2(p − 1)` at `p = q`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `𝒟ₙ`'s weights, as a subspace. -/
def dnWeights (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (Matrix ι ι ℝ) where
  carrier := {u | IsWeight u}
  add_mem' {u v} hu hv := ⟨fun a b => by simp [hu.symm a b, hv.symm a b], fun a => by simp [hu.hollow a, hv.hollow a],
    fun a => by simp [Finset.sum_add_distrib, hu.rowSum a, hv.rowSum a]⟩
  zero_mem' := ⟨fun _ _ => rfl, fun _ => rfl, fun _ => by simp⟩
  smul_mem' c u hu := ⟨fun a b => by simp [hu.symm a b], fun a => by simp [hu.hollow a],
    fun a => by simp [← Finset.mul_sum, hu.rowSum a]⟩

/-- An eigen-relation of `M ∘ diagOp v` on the `φ_{ab}` is one of `KL`. -/
theorem KL_of_fox (w v : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hhw : ∀ a, w a a = 0)
    (hs : ∀ p q, v p q = v q p) (hv : ∀ a, v a a = 0) (μ : ℝ)
    (hf : ∀ a b, foxProd (diagOp w) (diagOp v) (phi a b) = μ • diagOp v (phi a b)) : KL w v = μ • v :=
  Module.End.mem_eigenspace_iff.mp (mem_eigenspace_KL _ v hv μ fun _ _ hac => K_of_fox _ v hw hs hhw hv μ hf hac)

omit [Fintype ι] in
theorem K_of_KL [Fintype ι] {w u : Matrix ι ι ℝ} {ν : ℝ} (h : KL w u = ν • u) {a c : ι} (hac : a ≠ c) :
    Kmat w u a c = ν * u a c := by
  have := congrFun (congrFun h a) c
  change (if a = c then 0 else Kmat w u a c) = (ν • u) a c at this
  rwa [if_neg hac, Matrix.smul_apply, smul_eq_mul] at this

section sphere

variable (T : Finset ι) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : t ≠ 0)

/-- The multiplier `θ = t(p + q − 1)`. -/
noncomputable def dnθ : ℝ := t * ((T.card : ℝ) + Tᶜ.card - 1)
/-- The unit values `λ_p`, `λ_q`, `−μ`. -/
noncomputable def dnLp : ℝ := ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))
noncomputable def dnLq : ℝ := ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))
noncomputable def dnMu : ℝ := -(((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)))

include hp hq in
theorem dn_units : 0 < dnLp T ∧ dnLp T < 1 ∧ 0 < dnLq T ∧ dnLq T < 1 ∧ dnMu T < 0 := by
  have hp' : (3 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hq' : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  unfold dnLp dnLq dnMu
  refine ⟨div_pos (by linarith) (by linarith), (div_lt_one (by linarith)).mpr (by linarith),
    div_pos (by linarith) (by linarith), (div_lt_one (by linarith)).mpr (by linarith), ?_⟩
  exact neg_neg_of_pos (div_pos (by linarith) (mul_pos (by linarith) (by linarith)))

include hp hq ht in
theorem dnθ_ne : dnθ T t ≠ 0 := by
  have hp' : (3 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hq' : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  exact mul_ne_zero ht (by linarith)

include hp hq ht in
theorem dnθ_mul_ne {a b : ℝ} (hab : a ≠ b) : dnθ T t * a ≠ dnθ T t * b := fun h =>
  hab (mul_left_cancel₀ (dnθ_ne T hp hq t ht) h)

include hp hq in
/-- The parts of an eigen-weight, with each family's eigen-relation of `KL`. -/
private theorem parts {u : Matrix ι ι ℝ} (hu : IsWeight u) {ν : ℝ} (hK : KL (t • sphereWeight T) u = ν • u) :
    ∃ (c : ℝ) (h h' : ι → ℝ) (X Z Z' : Matrix ι ι ℝ), ∑ b ∈ T, h b = 0 ∧ ∑ b ∈ Tᶜ, h' b = 0 ∧ IsCrossW T X ∧
      IsWithinW T Z ∧ IsWithinW Tᶜ Z' ∧
      u = c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z' ∧
      (dnθ T t * 1 ≠ ν → c = 0) ∧ (dnθ T t * dnLp T ≠ ν → lamW T (dnK T) h = 0) ∧
      (dnθ T t * dnLq T ≠ ν → lamW Tᶜ (dnK Tᶜ) h' = 0) ∧ (dnθ T t * dnMu T ≠ ν → X = 0) ∧
      ((0 : ℝ) ≠ ν → Z = 0) ∧ ((0 : ℝ) ≠ ν → Z' = 0) := by
  obtain ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', he⟩ := dn_decomp T hu hp hq
  exact ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', he,
    dn_eigen_parts T (by omega) (by omega) t (fun a c hac => K_of_KL hK hac) c h h' hh hh' hX hZ hZ' he⟩

include hp hq in
theorem cross_mem_eig {X : Matrix ι ι ℝ} (hX : IsCrossW T X) :
    X ∈ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T) := by
  have hc := sphere_diagCrit T (by omega) (by omega) t
  exact Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ X hc.1 hc.2.1 hX.1 (fun a => hX.2.1 a a Iff.rfl) _
    (sphere_crossW T (by omega) (by omega) t hX))

include hp hq ht in
/-- **The `θ(−μ)`-eigenspace of `M ∘` on `𝒟ₙ` is the cross family.** -/
theorem dn_eig_cross :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T) = crossSub T := by
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨c, h, h', X, Z, Z', -, -, hX, -, -, he, e1, e2, e3, -, e5, e6⟩ :=
      parts T hp hq t hu (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e1 (dnθ_mul_ne T hp hq t ht (by linarith)), e2 (dnθ_mul_ne T hp hq t ht (by linarith)),
      e3 (dnθ_mul_ne T hp hq t ht (by linarith)),
      e5 (by rw [← mul_zero (dnθ T t)]; exact dnθ_mul_ne T hp hq t ht (by linarith)),
      e6 (by rw [← mul_zero (dnθ T t)]; exact dnθ_mul_ne T hp hq t ht (by linarith))]
    simpa using (show X ∈ crossSub T from hX)
  · intro hX
    exact ⟨IsCrossW.isWeight hX, cross_mem_eig T hp hq t hX⟩

include hp hq ht in
/-- **Its dimension is `(p − 1)(q − 1)`.** -/
theorem finrank_eig_cross :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T))
      = (T.card - 1) * (Tᶜ.card - 1) := by
  rw [dn_eig_cross T hp hq t ht, finrank_crossSub T (by omega) (by omega)]

include hp hq ht in
/-- **The `θ`-eigenspace of `M ∘` on `𝒟ₙ` is the sphere-weight line.** -/
theorem dn_eig_line :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1) = Submodule.span ℝ {sphereWeight T} := by
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  have hc := sphere_diagCrit T (by omega) (by omega) t
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨c, h, h', X, Z, Z', -, -, -, -, -, he, -, e2, e3, e4, e5, e6⟩ :=
      parts T hp hq t hu (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e2 (dnθ_mul_ne T hp hq t ht (by linarith)), e3 (dnθ_mul_ne T hp hq t ht (by linarith)),
      e4 (dnθ_mul_ne T hp hq t ht (by linarith)),
      e5 (by rw [← mul_zero (dnθ T t)]; exact dnθ_mul_ne T hp hq t ht (by norm_num)),
      e6 (by rw [← mul_zero (dnθ T t)]; exact dnθ_mul_ne T hp hq t ht (by norm_num))]
    simpa using Submodule.smul_mem _ c (Submodule.mem_span_singleton_self (sphereWeight T))
  · intro hu
    obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hu
    refine ⟨(dnWeights ι).smul_mem c (sphereWeight_isWeight T (by omega) (by omega)), ?_⟩
    exact Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1
      (fun p q => by simp [sphereWeight_symm T p q]) (fun a => by simp [sphereWeight_hollow]) _
      (sphere_line T (by omega) (by omega) t c))

include hp hq ht in
theorem finrank_eig_line :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1)) = 1 := by
  rw [dn_eig_line T hp hq t ht, finrank_sphereLine T (by omega) (by omega)]

include hp hq ht in
/-- **The `0`-eigenspace of `M ∘` on `𝒟ₙ` is the two zero families.** -/
theorem dn_eig_zero :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0 = withinSub T ⊔ withinSub Tᶜ := by
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  have hc := sphere_diagCrit T (by omega) (by omega) t
  have z : ∀ r : ℝ, r ≠ 0 → dnθ T t * r ≠ 0 := fun r hr => mul_ne_zero (dnθ_ne T hp hq t ht) hr
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨c, h, h', X, Z, Z', -, -, -, hZ, hZ', he, e1, e2, e3, e4, -, -⟩ :=
      parts T hp hq t hu (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e1 (z 1 one_ne_zero), e2 (z _ u1.ne'), e3 (z _ u3.ne'), e4 (z _ u5.ne)]
    simpa [add_assoc] using Submodule.add_mem_sup hZ hZ'
  · intro hu
    obtain ⟨Z, hZ, Z', hZ', rfl⟩ := Submodule.mem_sup.mp hu
    have eZ := sphere_zero T (by omega) (by omega) t Z hZ.1 hZ.2.1 hZ.2.2.1 hZ.2.2.2
    have eZ' := sphere_zero_compl T (by omega) (by omega) t Z' hZ'.1 hZ'.2.1 hZ'.2.2.1 hZ'.2.2.2
    refine ⟨(dnWeights ι).add_mem (IsWithinW.isWeight hZ) (IsWithinW.isWeight hZ'), ?_⟩
    exact Submodule.add_mem _
      (Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1 hZ.1 hZ.2.1 _ eZ))
      (Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1 hZ'.1 hZ'.2.1 _ eZ'))

theorem withinSub_disjoint : withinSub T ⊓ withinSub Tᶜ = ⊥ := by
  rw [eq_bot_iff]
  rintro Z ⟨hZ, hZ'⟩
  rw [Submodule.mem_bot]
  ext a b
  by_cases ha : a ∈ T
  · exact hZ'.2.2.1 a b (Or.inl fun h => (Finset.mem_compl.mp h) ha)
  · exact hZ.2.2.1 a b (Or.inl ha)

include hp hq ht in
/-- **Its dimension is `(binom p 2 − p) + (binom q 2 − q)`**, the record's `0^{rest}`. -/
theorem finrank_eig_zero :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0)
      = (T.card.choose 2 - T.card) + (Tᶜ.card.choose 2 - Tᶜ.card) := by
  rw [dn_eig_zero T hp hq t ht, ← finrank_withinSub T hp, ← finrank_withinSub Tᶜ hq]
  have := Submodule.finrank_sup_add_finrank_inf_eq (withinSub T) (withinSub Tᶜ)
  rw [withinSub_disjoint T, finrank_bot] at this
  omega

end sphere

end HamiltonsCubic.Results
