import HamiltonsCubic.Results.L127DnLam

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` eigenspaces at `p = 2`

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. At `p = 2` the record's `λ_p = 0` joins `0^{rest}`,
and [L127DnSpan.lean](L127DnSpan.lean)'s `lamW_two_eq_zero` and `within_two_eq_zero` make the `λ_p` family and the zero
family inside `T` equal to `{0}`. This file declares the eigenspaces of `M ∘` on `𝒟ₙ` at `p = 2`, `q ≥ 2`, `t ≠ 0`:

* **`dnLp_two`**, **`dn_units_two`**: `λ_p = 0`, `0 ≤ λ_q < 1`, `−μ < 0`;
* **`dn_eig_line_two`**, **`finrank_eig_line_two`**: the `θ`-eigenspace is the sphere-weight line, dimension `1`;
* **`dn_eig_cross_two`**, **`finrank_eig_cross_two`**: the `θ(−μ)`-eigenspace is the cross family, dimension `q − 1`;
* **`dn_eig_lamq_two`**, **`finrank_eig_lamq_two`**: at `q ≥ 3` the `θ λ_q`-eigenspace is the `λ_q` family, dimension
  `q − 1`;
* **`dn_eig_zero_two`**, **`finrank_eig_zero_two`**: the `0`-eigenspace is the zero family inside `Tᶜ`, dimension
  `binom q 2 − q`, `0` at `q = 2`;
* **`dnθ_compl`**, **`dnMu_compl`**, **`dnLq_compl`**, **`crossSub_compl`**, and the primed **`dn_eig_line_two'`**,
  **`dn_eig_cross_two'`**, **`dn_eig_lamp_two'`**, **`dn_eig_zero_two'`** with their finranks: the mirror `q = 2`.

So at `p = 2`, `q ≥ 3` the row reads `{1, λ_q^{q−1}, (−μ)^{q−1}, 0^{q(q−3)/2}}`: the record's `λ_p^{p−1} = 0^1` and its
`0^{rest}`, `rest = (q² − 3q − 2)/2`, together give the value `0` multiplicity `q(q − 3)/2`, which the `0`-eigenspace
carries, and `1 + 2(q − 1) + q(q − 3)/2 = n(n − 3)/2` at `n = q + 2`. At `p = q = 2` also `λ_q = 0` joins the value `0`,
whose eigenspace is `{0}`, the record's `λ_p^1 + λ_q^1 + 0^{−2}` counting `0` as well, and `𝒟₄` is the line and the
cross family. The mirror `q = 2` is the same statement with `T` and `Tᶜ` exchanged, declared below through `dnθ_compl`,
`dnMu_compl`, `dnLq_compl` and `crossSub_compl` as `dn_eig_line_two'`, `dn_eig_cross_two'`, `dn_eig_lamp_two'` and
`dn_eig_zero_two'` with their finranks. [L127DnExcl.lean](L127DnExcl.lean)'s `dn_excl` holds at `p, q ≥ 2`, so no
other value occurs. [L127DnTwoCount.lean](L127DnTwoCount.lean) declares the dimension sums at `p = 2` and at `q = 2`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section two

variable (T : Finset ι) (hp : T.card = 2) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : t ≠ 0)

include hp in
theorem dnLp_two : dnLp T = 0 := by unfold dnLp; rw [hp]; norm_num

include hp hq in
theorem dn_units_two : dnLp T = 0 ∧ 0 ≤ dnLq T ∧ dnLq T < 1 ∧ dnMu T < 0 := by
  have hq' : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  have hp' : (T.card : ℝ) = 2 := by exact_mod_cast hp
  refine ⟨dnLp_two T hp, ?_, ?_, ?_⟩
  · unfold dnLq; exact div_nonneg (by linarith) (by linarith)
  · unfold dnLq; exact (div_lt_one (by linarith)).mpr (by linarith)
  · unfold dnMu; exact neg_neg_of_pos (div_pos (by linarith) (mul_pos (by linarith) (by linarith)))

include hp hq ht in
theorem dnθ_ne_two : dnθ T t ≠ 0 := by
  have hq' : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  have hp' : (T.card : ℝ) = 2 := by exact_mod_cast hp
  exact mul_ne_zero ht (by linarith)

include hp hq ht in
theorem dnθ_mul_ne_two {a b : ℝ} (hab : a ≠ b) : dnθ T t * a ≠ dnθ T t * b := fun h =>
  hab (mul_left_cancel₀ (dnθ_ne_two T hp hq t ht) h)

include hp hq in
/-- The parts of an eigen-weight at `p = 2`: the `λ_p` part and the zero part inside `T` vanish outright. -/
private theorem parts_two {u : Matrix ι ι ℝ} (hu : IsWeight u) {ν : ℝ} (hK : KL (t • sphereWeight T) u = ν • u) :
    ∃ (c : ℝ) (h' : ι → ℝ) (X Z' : Matrix ι ι ℝ), ∑ b ∈ Tᶜ, h' b = 0 ∧ IsCrossW T X ∧ IsWithinW Tᶜ Z' ∧
      u = c • sphereWeight T + lamW Tᶜ (dnK Tᶜ) h' + X + Z' ∧
      (dnθ T t * 1 ≠ ν → c = 0) ∧ (dnθ T t * dnLq T ≠ ν → lamW Tᶜ (dnK Tᶜ) h' = 0) ∧
      (dnθ T t * dnMu T ≠ ν → X = 0) ∧ ((0 : ℝ) ≠ ν → Z' = 0) := by
  obtain ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', he⟩ := dn_decomp2 T hu (by omega) hq
  obtain ⟨e1, -, e3, e4, -, e6⟩ :=
    dn_eigen_parts T (by omega) hq t (fun a c hac => K_of_KL hK hac) c h h' hh hh' hX hZ hZ' he
  refine ⟨c, h', X, Z', hh', hX, hZ', ?_, e1, e3, e4, e6⟩
  rw [he, lamW_two_eq_zero T hp hh, within_two_eq_zero T hp hZ]
  abel

include hp hq ht in
/-- **At `p = 2` the `θ`-eigenspace of `M ∘` on `𝒟ₙ` is the sphere-weight line.** -/
theorem dn_eig_line_two :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1) = Submodule.span ℝ {sphereWeight T} := by
  obtain ⟨u1, u2, u3, u4⟩ := dn_units_two T hp hq
  have hc := sphere_diagCrit T (by omega) hq t
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨c, h', X, Z', -, -, -, he, -, e3, e4, e6⟩ := parts_two T hp hq t hu (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e3 (dnθ_mul_ne_two T hp hq t ht (by linarith)), e4 (dnθ_mul_ne_two T hp hq t ht (by linarith)),
      e6 (by rw [← mul_zero (dnθ T t)]; exact dnθ_mul_ne_two T hp hq t ht (by norm_num))]
    simpa using Submodule.smul_mem _ c (Submodule.mem_span_singleton_self (sphereWeight T))
  · intro hu
    obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hu
    refine ⟨(dnWeights ι).smul_mem c (sphereWeight_isWeight T (by omega) hq), ?_⟩
    exact Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1
      (fun p q => by simp [sphereWeight_symm T p q]) (fun a => by simp [sphereWeight_hollow]) _
      (sphere_line T (by omega) hq t c))

include hp hq ht in
theorem finrank_eig_line_two :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1)) = 1 := by
  rw [dn_eig_line_two T hp hq t ht, finrank_sphereLine T (by omega) (by omega)]

include hp hq ht in
/-- **At `p = 2` the `θ(−μ)`-eigenspace of `M ∘` on `𝒟ₙ` is the cross family.** -/
theorem dn_eig_cross_two :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T) = crossSub T := by
  obtain ⟨u1, u2, u3, u4⟩ := dn_units_two T hp hq
  have hc := sphere_diagCrit T (by omega) hq t
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨c, h', X, Z', -, hX, -, he, e1, e3, -, e6⟩ := parts_two T hp hq t hu (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e1 (dnθ_mul_ne_two T hp hq t ht (by linarith)), e3 (dnθ_mul_ne_two T hp hq t ht (by linarith)),
      e6 (by rw [← mul_zero (dnθ T t)]; exact dnθ_mul_ne_two T hp hq t ht (by linarith))]
    simpa using (show X ∈ crossSub T from hX)
  · intro hX
    exact ⟨IsCrossW.isWeight hX, Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ u hc.1 hc.2.1 hX.1
      (fun a => hX.2.1 a a Iff.rfl) _ (sphere_crossW T (by omega) hq t hX))⟩

include hp hq ht in
theorem finrank_eig_cross_two :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T)) = Tᶜ.card - 1 := by
  rw [dn_eig_cross_two T hp hq t ht, finrank_crossSub T (by omega) (by omega), hp]; simp

include hp hq ht in
/-- **At `p = 2`, `q ≥ 3` the `θ λ_q`-eigenspace of `M ∘` on `𝒟ₙ` is the `λ_q` family.** -/
theorem dn_eig_lamq_two (hq3 : 3 ≤ Tᶜ.card) :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLq T) = LinearMap.range (lamMap Tᶜ (dnK Tᶜ)) := by
  obtain ⟨u1, u2, u3, u4⟩ := dn_units_two T hp hq
  have hq' : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq3
  have hLq : 0 < dnLq T := by unfold dnLq; exact div_pos (by linarith) (by linarith)
  have hc := sphere_diagCrit T (by omega) hq t
  have hK' : dnK Tᶜ = -((Tᶜ.card : ℝ) - 2) / T.card := by unfold dnK; rw [compl_compl]
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨c, h', X, Z', hh', -, -, he, e1, -, e4, e6⟩ := parts_two T hp hq t hu (Module.End.mem_eigenspace_iff.mp hE)
    rw [he, e1 (dnθ_mul_ne_two T hp hq t ht (by linarith)), e4 (dnθ_mul_ne_two T hp hq t ht (by linarith)),
      e6 (by rw [← mul_zero (dnθ T t)]; exact dnθ_mul_ne_two T hp hq t ht hLq.ne)]
    simpa using mem_range_lamMap Tᶜ _ h' hh'
  · intro hv
    obtain ⟨h, hh, rfl⟩ := lam_parts Tᶜ hv
    refine ⟨lam_mem Tᶜ (by rw [compl_compl]; omega) hh, ?_⟩
    refine Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1 (lamW_symm Tᶜ _ h) (fun a => by simp [lamW]) _ ?_)
    rw [hK']; exact sphere_lam_compl T (by omega) hq t h hh

include hp hq ht in
theorem finrank_eig_lamq_two (hq3 : 3 ≤ Tᶜ.card) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLq T)) = Tᶜ.card - 1 := by
  rw [dn_eig_lamq_two T hp hq t ht hq3, finrank_lam Tᶜ _ hq3]

include hp hq ht in
/-- **At `p = 2` the `0`-eigenspace of `M ∘` on `𝒟ₙ` is the zero family inside `Tᶜ`.** -/
theorem dn_eig_zero_two : dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0 = withinSub Tᶜ := by
  obtain ⟨u1, u2, u3, u4⟩ := dn_units_two T hp hq
  have hc := sphere_diagCrit T (by omega) hq t
  have z : ∀ r : ℝ, r ≠ 0 → dnθ T t * r ≠ 0 := fun r hr => mul_ne_zero (dnθ_ne_two T hp hq t ht) hr
  ext u
  constructor
  · rintro ⟨hu, hE⟩
    obtain ⟨c, h', X, Z', hh', -, hZ', he, e1, e3, e4, -⟩ := parts_two T hp hq t hu (Module.End.mem_eigenspace_iff.mp hE)
    have hL : lamW Tᶜ (dnK Tᶜ) h' = 0 := by
      by_cases hq2 : Tᶜ.card = 2
      · exact lamW_two_eq_zero Tᶜ hq2 hh'
      · have hq3 : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast (show 3 ≤ Tᶜ.card by omega)
        exact e3 (z _ (by unfold dnLq; exact (div_pos (by linarith) (by linarith)).ne'))
    rw [he, e1 (z 1 one_ne_zero), hL, e4 (z _ u4.ne)]
    simpa using (show Z' ∈ withinSub Tᶜ from hZ')
  · intro hZ'
    refine ⟨IsWithinW.isWeight hZ', ?_⟩
    exact Module.End.mem_eigenspace_iff.mpr (KL_of_fox _ _ hc.1 hc.2.1 hZ'.1 hZ'.2.1 _
      (sphere_zero_compl T (by omega) hq t u hZ'.1 hZ'.2.1 hZ'.2.2.1 hZ'.2.2.2))

include hp hq ht in
theorem finrank_eig_zero_two :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0) = Tᶜ.card.choose 2 - Tᶜ.card := by
  rw [dn_eig_zero_two T hp hq t ht]
  by_cases hq2 : Tᶜ.card = 2
  · have : withinSub Tᶜ = ⊥ := by
      rw [eq_bot_iff]; intro Z hZ; rw [Submodule.mem_bot]; exact within_two_eq_zero Tᶜ hq2 hZ
    rw [this, finrank_bot, hq2]; rfl
  · exact finrank_withinSub Tᶜ (by omega)

end two

/-! ## The mirror `q = 2`, through `T ↔ Tᶜ` -/

theorem dnθ_compl (T : Finset ι) (t : ℝ) : dnθ Tᶜ t = dnθ T t := by unfold dnθ; rw [compl_compl]; ring
theorem dnMu_compl (T : Finset ι) : dnMu Tᶜ = dnMu T := by unfold dnMu; rw [compl_compl]; ring
theorem dnLq_compl (T : Finset ι) : dnLq Tᶜ = dnLp T := by unfold dnLq dnLp; rw [compl_compl]

theorem crossSub_compl (T : Finset ι) : crossSub Tᶜ = crossSub T := by
  have key : ∀ S : Finset ι, ∀ X, IsCrossW S X → IsCrossW Sᶜ X := fun S X ⟨hs, hsupp, h1, h2⟩ =>
    ⟨hs, fun a b hab => hsupp a b (by simpa only [Finset.mem_compl, not_iff_not] using hab),
      fun a ha => by rw [compl_compl]; exact h2 a (Finset.mem_compl.mp ha),
      fun a ha => h1 a (by simpa using ha)⟩
  ext X
  exact ⟨fun h => (show IsCrossW T X by simpa using key Tᶜ X h), key T X⟩

section mirror

variable (T : Finset ι) (hq : Tᶜ.card = 2) (hp : 2 ≤ T.card) (t : ℝ) (ht : t ≠ 0)

include hq hp ht in
/-- **At `q = 2` the `θ`-eigenspace is the sphere-weight line.** -/
theorem dn_eig_line_two' :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1) = Submodule.span ℝ {sphereWeight T} := by
  have := dn_eig_line_two Tᶜ hq (by rw [compl_compl]; exact hp) t ht
  rwa [HamiltonsCubic.L121Block.sphereWeight_compl, dnθ_compl] at this

include hq hp ht in
theorem finrank_eig_line_two' :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1)) = 1 := by
  rw [dn_eig_line_two' T hq hp t ht, finrank_sphereLine T (by omega) (by omega)]

include hq hp ht in
/-- **At `q = 2` the `θ(−μ)`-eigenspace is the cross family**, dimension `p − 1`. -/
theorem dn_eig_cross_two' :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T) = crossSub T := by
  have := dn_eig_cross_two Tᶜ hq (by rw [compl_compl]; exact hp) t ht
  rwa [HamiltonsCubic.L121Block.sphereWeight_compl, dnθ_compl, dnMu_compl, crossSub_compl] at this

include hq hp ht in
theorem finrank_eig_cross_two' :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T)) = T.card - 1 := by
  have := finrank_eig_cross_two Tᶜ hq (by rw [compl_compl]; exact hp) t ht
  rwa [HamiltonsCubic.L121Block.sphereWeight_compl, dnθ_compl, dnMu_compl, compl_compl] at this

include hq hp ht in
/-- **At `q = 2`, `p ≥ 3` the `θ λ_p`-eigenspace is the `λ_p` family**, dimension `p − 1`. -/
theorem dn_eig_lamp_two' (hp3 : 3 ≤ T.card) :
    dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T) = LinearMap.range (lamMap T (dnK T)) := by
  have := dn_eig_lamq_two Tᶜ hq (by rw [compl_compl]; exact hp) t ht (by rw [compl_compl]; exact hp3)
  rw [HamiltonsCubic.L121Block.sphereWeight_compl, dnθ_compl, dnLq_compl] at this
  rw [this]
  ext v
  constructor
  · intro hv
    obtain ⟨h, hh, rfl⟩ := lam_parts Tᶜᶜ hv
    simp only [compl_compl] at hh ⊢
    exact mem_range_lamMap T _ h hh
  · intro hv
    obtain ⟨h, hh, rfl⟩ := lam_parts T hv
    have hh' : ∑ b ∈ Tᶜᶜ, h b = 0 := by rw [compl_compl]; exact hh
    have := mem_range_lamMap Tᶜᶜ (dnK Tᶜᶜ) h hh'
    rwa [show lamW Tᶜᶜ (dnK Tᶜᶜ) h = lamW T (dnK T) h by rw [compl_compl]] at this

include hq hp ht in
theorem finrank_eig_lamp_two' (hp3 : 3 ≤ T.card) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T)) = T.card - 1 := by
  rw [dn_eig_lamp_two' T hq hp t ht hp3, finrank_lam T _ hp3]

include hq hp ht in
/-- **At `q = 2` the `0`-eigenspace is the zero family inside `T`**, dimension `binom p 2 − p`. -/
theorem dn_eig_zero_two' : dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0 = withinSub T := by
  have := dn_eig_zero_two Tᶜ hq (by rw [compl_compl]; exact hp) t ht
  rwa [HamiltonsCubic.L121Block.sphereWeight_compl, compl_compl] at this

include hq hp ht in
theorem finrank_eig_zero_two' :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0) = T.card.choose 2 - T.card := by
  have := finrank_eig_zero_two Tᶜ hq (by rw [compl_compl]; exact hp) t ht
  rwa [HamiltonsCubic.L121Block.sphereWeight_compl, compl_compl] at this

end mirror

end HamiltonsCubic.Results
