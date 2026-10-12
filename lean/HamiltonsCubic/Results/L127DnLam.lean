import HamiltonsCubic.Results.L127DnEig

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` eigenspaces at `θ λ_p` and `θ λ_q`

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnEig.lean](L127DnEig.lean) declares the
eigenspaces at `θ`, `θ(−μ)` and `0`. This file completes the row at the sphere product with `p, q ≥ 3` and `t ≠ 0`:

* **`dnLp_eq_dnLq_iff`**: `λ_p = λ_q` exactly when `p = q`;
* **`sum_extF`**, **`lam_parts`**, **`lam_mem`**: a member of the `λ` family on `S` is `lamW S (dnK S) h` with
  `∑_S h = 0`, and a weight;
* **`lamp_mem_eig`**, **`lamq_mem_eig`**: the `λ_p` and `λ_q` families lie in `KL`'s `θ λ_p`- and `θ λ_q`-eigenspaces;
* **`dn_eig_lamp`**, **`finrank_eig_lamp`**: at `p ≠ q` the `θ λ_p`-eigenspace is the `λ_p` family, dimension `p − 1`;
* **`dn_eig_lamq`**, **`finrank_eig_lamq`**: at `p ≠ q` the `θ λ_q`-eigenspace is the `λ_q` family, dimension `q − 1`;
* **`dn_eig_lam_eq`**, **`finrank_eig_lam_eq`**: at `p = q` the two merge, the eigenspace is both families, dimension
  `2(p − 1)`, their intersection being `0` by `dn_direct` (`lam_disjoint`).

With [L127DnEig.lean](L127DnEig.lean) this declares every eigenspace of `M ∘` on `𝒟ₙ` with its dimension, and
[L127DnExcl.lean](L127DnExcl.lean)'s `dn_excl` that no other value occurs, the `𝒟ₙ` row at `p, q ≥ 3`, `t ≠ 0`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem dnLp_eq_dnLq_iff (T : Finset ι) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) : dnLp T = dnLq T ↔ T.card = Tᶜ.card := by
  have hp' : (3 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hq' : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  unfold dnLp dnLq
  constructor
  · intro h
    rw [div_eq_div_iff (by nlinarith) (by nlinarith)] at h
    exact_mod_cast (by nlinarith : (T.card : ℝ) = Tᶜ.card)
  · intro h; rw [h]

omit [Fintype ι] in
theorem sum_extF (S : Finset ι) (h : S → ℝ) : ∑ b ∈ S, extF S h b = ∑ i : S, h i := by
  rw [← Finset.sum_coe_sort S]
  exact Finset.sum_congr rfl fun i _ => by simp [extF, i.2]

/-- The `λ` family on `S` at `κ = dnK S`, in the form `sphere_lam` reads. -/
theorem lam_parts (S : Finset ι) {v : Matrix ι ι ℝ} (hv : v ∈ LinearMap.range (lamMap S (dnK S))) :
    ∃ h : ι → ℝ, ∑ b ∈ S, h b = 0 ∧ v = lamW S (dnK S) h := by
  obtain ⟨⟨g, hg⟩, rfl⟩ := hv
  refine ⟨extF S g, ?_, rfl⟩
  rw [sum_extF]; exact LinearMap.mem_ker.mp hg

theorem lam_mem (S : Finset ι) (hS : 1 ≤ Sᶜ.card) {h : ι → ℝ} (hh : ∑ b ∈ S, h b = 0) :
    lamW S (dnK S) h ∈ dnWeights ι := by
  have hq : (Sᶜ.card : ℝ) ≠ 0 := by linarith [show (1 : ℝ) ≤ Sᶜ.card by exact_mod_cast hS]
  exact lamW_isWeight S _ h hh (by unfold dnK; field_simp)

section sphere

variable (T : Finset ι) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : t ≠ 0)

include hp hq in
theorem lamp_mem_eig {h : ι → ℝ} (hh : ∑ b ∈ T, h b = 0) :
    lamW T (dnK T) h ∈ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T) := by
  have hc := sphere_diagCrit T (by omega) (by omega) t
  exact Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1 (lamW_symm T _ h) (fun a => by simp [lamW]) _
    (sphere_lam T (by omega) (by omega) t h hh))

include hp hq in
theorem lamq_mem_eig {h : ι → ℝ} (hh : ∑ b ∈ Tᶜ, h b = 0) :
    lamW Tᶜ (dnK Tᶜ) h ∈ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLq T) := by
  have hc := sphere_diagCrit T (by omega) (by omega) t
  have hK' : dnK Tᶜ = -((Tᶜ.card : ℝ) - 2) / T.card := by unfold dnK; rw [compl_compl]
  refine Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1 (lamW_symm Tᶜ _ h) (fun a => by simp [lamW]) _ ?_)
  rw [hK']; exact sphere_lam_compl T (by omega) (by omega) t h hh

include hp hq ht in
/-- The parts of a weight in the `θ λ_p`-eigenspace outside the two `λ` families vanish. -/
private theorem lam_eig_parts {u : Matrix ι ι ℝ} (hu : IsWeight u) {ν : ℝ} (hν : ν = dnθ T t * dnLp T ∨ ν = dnθ T t * dnLq T)
    (hK : KL (t • sphereWeight T) u = ν • u) :
    ∃ h h' : ι → ℝ, ∑ b ∈ T, h b = 0 ∧ ∑ b ∈ Tᶜ, h' b = 0 ∧ u = lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' ∧
      (dnθ T t * dnLp T ≠ ν → lamW T (dnK T) h = 0) ∧ (dnθ T t * dnLq T ≠ ν → lamW Tᶜ (dnK Tᶜ) h' = 0) := by
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  obtain ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', he⟩ := dn_decomp T hu hp hq
  obtain ⟨e1, e2, e3, e4, e5, e6⟩ :=
    dn_eigen_parts T (by omega) (by omega) t (fun a c hac => K_of_KL hK hac) c h h' hh hh' hX hZ hZ' he
  have ne : ∀ r : ℝ, r ≠ dnLp T → r ≠ dnLq T → dnθ T t * r ≠ ν := fun r h1 h2 => by
    rcases hν with rfl | rfl
    · exact dnθ_mul_ne T hp hq t ht h1
    · exact dnθ_mul_ne T hp hq t ht h2
  have z : dnθ T t * 0 ≠ ν := ne 0 u1.ne u3.ne
  rw [mul_zero] at z
  refine ⟨h, h', hh, hh', ?_, e2, e3⟩
  rw [he, e1 (ne 1 u2.ne' u4.ne'), e4 (ne _ (u5.trans u1).ne (u5.trans u3).ne), e5 z, e6 z]
  simp

include hp hq ht in
/-- **At `p ≠ q` the `θ λ_p`-eigenspace of `M ∘` on `𝒟ₙ` is the `λ_p` family.** -/
theorem dn_eig_lamp (hpq : T.card ≠ Tᶜ.card) :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T) = LinearMap.range (lamMap T (dnK T)) := by
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨h, h', hh, -, he, -, e3⟩ := lam_eig_parts T hp hq t ht hu (Or.inl rfl) (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e3 (dnθ_mul_ne T hp hq t ht fun e => hpq ((dnLp_eq_dnLq_iff T hp hq).mp e.symm)), add_zero]
    exact mem_range_lamMap T _ h hh
  · intro hv
    obtain ⟨h, hh, rfl⟩ := lam_parts T hv
    exact ⟨lam_mem T (by omega) hh, lamp_mem_eig T hp hq t hh⟩

include hp hq ht in
theorem finrank_eig_lamp (hpq : T.card ≠ Tᶜ.card) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T)) = T.card - 1 := by
  rw [dn_eig_lamp T hp hq t ht hpq, finrank_lam T _ hp]

include hp hq ht in
/-- **At `p ≠ q` the `θ λ_q`-eigenspace of `M ∘` on `𝒟ₙ` is the `λ_q` family.** -/
theorem dn_eig_lamq (hpq : T.card ≠ Tᶜ.card) :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLq T) = LinearMap.range (lamMap Tᶜ (dnK Tᶜ)) := by
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨h, h', -, hh', he, e2, -⟩ := lam_eig_parts T hp hq t ht hu (Or.inr rfl) (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e2 (dnθ_mul_ne T hp hq t ht fun e => hpq ((dnLp_eq_dnLq_iff T hp hq).mp e)), zero_add]
    exact mem_range_lamMap Tᶜ _ h' hh'
  · intro hv
    obtain ⟨h, hh, rfl⟩ := lam_parts Tᶜ hv
    exact ⟨lam_mem Tᶜ (by rw [compl_compl]; omega) hh, lamq_mem_eig T hp hq t hh⟩

include hp hq ht in
theorem finrank_eig_lamq (hpq : T.card ≠ Tᶜ.card) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLq T)) = Tᶜ.card - 1 := by
  rw [dn_eig_lamq T hp hq t ht hpq, finrank_lam Tᶜ _ hq]

include hp hq ht in
/-- **At `p = q` the two `λ` families share the eigenspace.** -/
theorem dn_eig_lam_eq (hpq : T.card = Tᶜ.card) :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T)
      = LinearMap.range (lamMap T (dnK T)) ⊔ LinearMap.range (lamMap Tᶜ (dnK Tᶜ)) := by
  have hL : dnLp T = dnLq T := (dnLp_eq_dnLq_iff T hp hq).mpr hpq
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨h, h', hh, hh', he, -, -⟩ := lam_eig_parts T hp hq t ht hu (Or.inl rfl) (Module.End.mem_eigenspace_iff.mp hE)
    rw [he]
    exact Submodule.add_mem_sup (mem_range_lamMap T _ h hh) (mem_range_lamMap Tᶜ _ h' hh')
  · intro hv
    obtain ⟨v, hv1, v', hv2, rfl⟩ := Submodule.mem_sup.mp hv
    obtain ⟨h, hh, rfl⟩ := lam_parts T hv1
    obtain ⟨h', hh', rfl⟩ := lam_parts Tᶜ hv2
    refine ⟨(dnWeights ι).add_mem (lam_mem T (by omega) hh) (lam_mem Tᶜ (by rw [compl_compl]; omega) hh'), ?_⟩
    refine Submodule.add_mem _ (lamp_mem_eig T hp hq t hh) ?_
    rw [hL]; exact lamq_mem_eig T hp hq t hh'

include hp hq in
theorem lam_disjoint :
    LinearMap.range (lamMap T (dnK T)) ⊓ LinearMap.range (lamMap Tᶜ (dnK Tᶜ)) = ⊥ := by
  rw [eq_bot_iff]
  rintro v ⟨hv1, hv2⟩
  obtain ⟨h, hh, rfl⟩ := lam_parts T hv1
  obtain ⟨h', hh', he⟩ := lam_parts Tᶜ hv2
  have hneg : ∑ b ∈ Tᶜ, (-h') b = 0 := by simp [hh']
  have hs : (0 : ℝ) • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) (-h') + 0 + 0 + 0 = 0 := by
    rw [show -h' = (-1 : ℝ) • h' by ext; simp, lamW_smul, ← he]; simp
  obtain ⟨-, hL, -⟩ := dn_direct T hp hq 0 h (-h') hh hneg ⟨fun _ _ => rfl, fun _ _ _ => rfl, fun _ _ => by simp,
    fun _ _ => by simp⟩ ⟨fun _ _ => rfl, fun _ => rfl, fun _ _ _ => rfl, fun _ _ => by simp⟩
    ⟨fun _ _ => rfl, fun _ => rfl, fun _ _ _ => rfl, fun _ _ => by simp⟩ hs
  rw [hL]; exact Submodule.zero_mem _

include hp hq ht in
/-- **Its dimension is `2(p − 1)`.** -/
theorem finrank_eig_lam_eq (hpq : T.card = Tᶜ.card) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T)) = 2 * (T.card - 1) := by
  rw [dn_eig_lam_eq T hp hq t ht hpq]
  have := Submodule.finrank_sup_add_finrank_inf_eq (LinearMap.range (lamMap T (dnK T)))
    (LinearMap.range (lamMap Tᶜ (dnK Tᶜ)))
  rw [lam_disjoint T hp hq, finrank_bot, finrank_lam T _ hp, finrank_lam Tᶜ _ hq, ← hpq] at this
  omega

end sphere

end HamiltonsCubic.Results
