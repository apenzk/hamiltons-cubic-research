import HamiltonsCubic.Results.L127DnDirect

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` multiplicities: each eigenspace is the sum of the families carrying its value

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnSpan.lean](L127DnSpan.lean)'s
`dn_decomp2` writes a weight as one member of each of six families at `p, q ≥ 2`, [L127DnDirect.lean](L127DnDirect.lean)'s
`dn_direct2` makes that unique, and [L127DnDim.lean](L127DnDim.lean) gives the families' dimensions. This file joins them:

* **`lamW_smul`**: a `λ` weight is linear in its coefficients;
* **`dn_eigen_parts`**: at the sphere product with `p, q ≥ 2`, if a weight `u` has `K u = ν u` off the diagonal then
  every family member of `u` whose family carries a value other than `ν` is zero. Applying `K − ν` to the
  decomposition gives the vanishing sum `∑ (v_i − ν) P_i` of family members, which `dn_direct2` kills term by term.

So at `p, q ≥ 3`, `t ≠ 0` the `ν`-eigenspace of `M ∘` on `𝒟ₙ` is the direct sum of the families carrying `ν`, and its dimension is the sum of
their dimensions: `1` at `θ`, `p − 1` at `θ λ_p`, `q − 1` at `θ λ_q` (the two adding at `p = q`), `(p − 1)(q − 1)` at
`θ(−μ)`, and `p(p − 3)/2 + q(q − 3)/2` at `0`, the record's multiplicities. At `t = 0` every family carries `0`, and
at `p = 2` or `q = 2` [L127DnTwo.lean](L127DnTwo.lean) gives the eigenspaces.

[L127DnEig.lean](L127DnEig.lean) declares the eigenspace equalities and dimensions at `θ`, `θ(−μ)` and `0`.
[L127DnLam.lean](L127DnLam.lean) declares those at `θ λ_p` and `θ λ_q`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [Fintype ι] in
theorem lamW_smul (S : Finset ι) (κ r : ℝ) (h : ι → ℝ) : lamW S κ (r • h) = r • lamW S κ h := by
  ext a b
  simp only [lamW, Matrix.of_apply, Matrix.smul_apply, Pi.smul_apply, smul_eq_mul]
  split_ifs <;> ring

/-- **Each part of an eigen-weight carries the eigenvalue or vanishes.** At the sphere product with `p, q ≥ 2`, a
weight `u = c w₁ + L + L' + X + Z + Z'` (`dn_decomp2`) with `K u = ν u` off the diagonal has every part whose family
value differs from `ν` equal to zero. -/
theorem dn_eigen_parts (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) {u : Matrix ι ι ℝ} {ν : ℝ}
    (hK : ∀ a c, a ≠ c → Kmat (t • sphereWeight T) u a c = ν * u a c) (c : ℝ) (h h' : ι → ℝ)
    {X Z Z' : Matrix ι ι ℝ} (hh : ∑ b ∈ T, h b = 0) (hh' : ∑ b ∈ Tᶜ, h' b = 0) (hX : IsCrossW T X)
    (hZ : IsWithinW T Z) (hZ' : IsWithinW Tᶜ Z')
    (he : u = c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z') :
    (t * ((T.card : ℝ) + Tᶜ.card - 1) * 1 ≠ ν → c = 0) ∧
    (t * ((T.card : ℝ) + Tᶜ.card - 1) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) ≠ ν →
      lamW T (dnK T) h = 0) ∧
    (t * ((T.card : ℝ) + Tᶜ.card - 1) * (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))) ≠ ν →
      lamW Tᶜ (dnK Tᶜ) h' = 0) ∧
    (t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2)
      / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)))) ≠ ν → X = 0) ∧
    ((0 : ℝ) ≠ ν → Z = 0) ∧ ((0 : ℝ) ≠ ν → Z' = 0) := by
  set w := t • sphereWeight T
  set v1 := t * ((T.card : ℝ) + Tᶜ.card - 1) * 1
  set v2 := t * ((T.card : ℝ) + Tᶜ.card - 1) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)))
  set v3 := t * ((T.card : ℝ) + Tᶜ.card - 1) * (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)))
  set v4 := t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2)
      / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))))
  have hc := sphere_diagCrit T (by omega) (by omega) t
  have hK' : dnK Tᶜ = -((Tᶜ.card : ℝ) - 2) / T.card := by unfold dnK; rw [compl_compl]
  -- each part is an eigenvector of `KL w`
  have E : ∀ (v : Matrix ι ι ℝ) (μ : ℝ), (∀ p q, v p q = v q p) → (∀ a, v a a = 0) →
      (∀ a b, foxProd (diagOp w) (diagOp v) (phi a b) = μ • diagOp v (phi a b)) → KL w v = μ • v :=
    fun v μ hs hv hf => Module.End.mem_eigenspace_iff.mp
      (mem_eigenspace_KL _ v hv μ fun a c hac => K_of_fox _ v hc.1 hs hc.2.1 hv μ hf hac)
  have E1 := E _ v1 (fun p q => by simp [sphereWeight_symm T p q]) (fun a => by simp [sphereWeight_hollow])
    (sphere_line T hp hq t c)
  have E2 := E (lamW T (dnK T) h) v2 (lamW_symm T _ h) (fun a => by simp [lamW]) (sphere_lam T (by omega) (by omega) t h hh)
  have E3 := E (lamW Tᶜ (dnK Tᶜ) h') v3 (lamW_symm Tᶜ _ h') (fun a => by simp [lamW])
    (by rw [hK']; exact sphere_lam_compl T (by omega) (by omega) t h' hh')
  have E4 := E _ v4 hX.1 (fun a => hX.2.1 a a Iff.rfl) (sphere_crossW T hp hq t hX)
  have E5 := E _ 0 hZ.1 hZ.2.1 (sphere_zero T (by omega) (by omega) t Z hZ.1 hZ.2.1 hZ.2.2.1 hZ.2.2.2)
  have E6 := E _ 0 hZ'.1 hZ'.2.1
    (sphere_zero_compl T (by omega) (by omega) t Z' hZ'.1 hZ'.2.1 hZ'.2.2.1 hZ'.2.2.2)
  have Eu : KL w u = ν • u := Module.End.mem_eigenspace_iff.mp (mem_eigenspace_KL _ u (by
    intro a; rw [he]; simp [sphereWeight_hollow, lamW, hX.2.1 a a Iff.rfl, hZ.2.1 a, hZ'.2.1 a]) ν hK)
  -- `(K − ν) u = 0` read on the parts
  have hsum : ((v1 - ν) * c) • sphereWeight T + lamW T (dnK T) ((v2 - ν) • h) + lamW Tᶜ (dnK Tᶜ) ((v3 - ν) • h')
      + (v4 - ν) • X + (0 - ν) • Z + (0 - ν) • Z' = 0 := by
    have k : KL w u - ν • u = 0 := by rw [Eu, sub_self]
    rw [he, map_add, map_add, map_add, map_add, map_add, E1, E2, E3, E4, E5, E6] at k
    rw [lamW_smul, lamW_smul, ← k]
    simp only [smul_add, sub_smul, mul_smul]
    abel
  have hh2 : ∑ b ∈ T, ((v2 - ν) • h) b = 0 := by simp [← Finset.mul_sum, hh]
  have hh3 : ∑ b ∈ Tᶜ, ((v3 - ν) • h') b = 0 := by simp [← Finset.mul_sum, hh']
  obtain ⟨d1, d2, d3, d4, d5, d6⟩ := dn_direct2 T hp hq _ _ _ hh2 hh3 ((crossSub T).smul_mem (v4 - ν) hX)
    ((withinSub T).smul_mem (0 - ν) hZ) ((withinSub Tᶜ).smul_mem (0 - ν) hZ') hsum
  rw [lamW_smul] at d2 d3
  refine ⟨fun hn => ?_, fun hn => ?_, fun hn => ?_, fun hn => ?_, fun hn => ?_, fun hn => ?_⟩
  · rcases mul_eq_zero.mp d1 with h0 | h0
    · exact absurd (sub_eq_zero.mp h0) hn
    · exact h0
  · exact (smul_eq_zero.mp d2).resolve_left (sub_ne_zero.mpr hn)
  · exact (smul_eq_zero.mp d3).resolve_left (sub_ne_zero.mpr hn)
  · exact (smul_eq_zero.mp d4).resolve_left (sub_ne_zero.mpr hn)
  · exact (smul_eq_zero.mp d5).resolve_left (sub_ne_zero.mpr hn)
  · exact (smul_eq_zero.mp d6).resolve_left (sub_ne_zero.mpr hn)

end HamiltonsCubic.Results
