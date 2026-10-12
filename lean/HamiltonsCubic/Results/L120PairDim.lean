import HamiltonsCubic.Results.L120Pair

set_option linter.style.longLine false

/-!
# L120's pair summand has dimension `n − 3`

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: the pair summand `V_{jk}` has dimension
`n − 3`, *"one Ricci relation cuts each pair block from `n − 2` to `n − 3`"*. [L120Pair.lean](L120Pair.lean) identifies
`V_{jk}` with the pair span on its Ricci cut. This file counts it, on `Fin n`, `n ≥ 3`:

* **`pairMap`**: the coefficient map `c ↦ pairLin j k c ∘ₗ skewProj`, linear in `c`;
* **`pairSummand_mem`**: an operator is in the image of the Ricci-cut coefficient space (vanishing off
  `s = {y : y ≠ j, y ≠ k}`, zero sum) exactly when it is in `weylModuleS` and transforms under every flip by `ε_j ε_k`;
* **`pairSummand_finrank`**: that image has dimension `n − 3`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {n : ℕ}

theorem pairLin_apply (j k : Fin n) (c : Fin n → ℝ) (Y : Matrix (Fin n) (Fin n) ℝ) :
    pairLin j k c Y = ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) Y := rfl

/-- The coefficient map of the pair summand, linear in the coefficients. -/
noncomputable def pairMap (j k : Fin n) : (Fin n → ℝ) →ₗ[ℝ] CurvLin (Fin n) where
  toFun c := pairLin j k c ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)
  map_add' c d := by
    apply LinearMap.ext; intro Y
    simp only [LinearMap.add_apply, LinearMap.comp_apply, pairLin_apply, Pi.add_apply, add_smul,
      Finset.sum_add_distrib]
  map_smul' r c := by
    apply LinearMap.ext; intro Y
    simp only [LinearMap.smul_apply, LinearMap.comp_apply, pairLin_apply, Pi.smul_apply, smul_eq_mul, mul_smul,
      Finset.smul_sum, RingHom.id_apply]

/-- **The pair summand, characterised**: `R` is in the image of the Ricci-cut coefficient space exactly when it is a
Weyl operator transforming under every flip by the character of `{j, k}`. -/
theorem pairSummand_mem {j k : Fin n} (hjk : j ≠ k) (R : CurvLin (Fin n)) :
    R ∈ (LinearMap.ker (blockSums1 (univ.filter (fun i => j ≠ i ∧ k ≠ i)))).map (pairMap j k)
      ↔ R ∈ weylModuleS (Fin n) ∧ ∀ m, act (flip m) R = (sgn m j * sgn m k) • R := by
  rw [Submodule.mem_map]
  constructor
  · rintro ⟨c, hc, rfl⟩
    rw [mem_ker_blockSums1] at hc
    exact ⟨pairS_mem hjk c hc.2, pairS_iso hjk c hc.2⟩
  · rintro ⟨hR, hiso⟩
    obtain ⟨hsum, hEq⟩ := pair_isotypic R hR hjk hiso
    refine ⟨fun y => coord R j y k y, ?_, hEq.symm⟩
    rw [mem_ker_blockSums1]
    refine ⟨fun y hy => ?_, hsum⟩
    have : y = j ∨ y = k := by
      by_contra h; push Not at h
      exact hy (Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm h.1, Ne.symm h.2⟩)
    rcases this with rfl | rfl
    · exact cd_self12 R y k y
    · exact cd_self34 R j y y

/-- **The pair summand has dimension `n − 3`.** -/
theorem pairSummand_finrank {j k : Fin n} (hjk : j ≠ k) (hn : 3 ≤ n) :
    Module.finrank ℝ ((LinearMap.ker (blockSums1 (univ.filter (fun i => j ≠ i ∧ k ≠ i)))).map (pairMap j k))
      = n - 3 := by
  set s := univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i) with hsdef
  set V := LinearMap.ker (blockSums1 s)
  have hinj : Function.Injective ((pairMap j k).comp V.subtype) := by
    intro c d h
    apply Subtype.ext
    have hc := (mem_ker_blockSums1 s c.1).mp c.2
    have hd := (mem_ker_blockSums1 s d.1).mp d.2
    funext y
    by_cases hy : y ∈ s
    · obtain ⟨hjy, hky⟩ := (Finset.mem_filter.mp hy).2
      have e := congrArg (fun F : CurvLin (Fin n) => coord F j y k y) h
      simp only [LinearMap.comp_apply, Submodule.coe_subtype] at e
      change coord (pairLin j k c.1 ∘ₗ _) j y k y = coord (pairLin j k d.1 ∘ₗ _) j y k y at e
      rwa [coord_pairS_diag hjk _ (Ne.symm hjy) (Ne.symm hky), coord_pairS_diag hjk _ (Ne.symm hjy) (Ne.symm hky)] at e
    · rw [hc.1 y hy, hd.1 y hy]
  have hcard : s.card + 2 = n := by
    have := pairIdx_card (ι := Fin n) hjk
    rwa [Fintype.card_fin] at this
  have hne : s.Nonempty := Finset.card_pos.mp (by omega)
  rw [show V.map (pairMap j k) = LinearMap.range ((pairMap j k).comp V.subtype) by
      rw [LinearMap.range_comp, Submodule.range_subtype],
    LinearMap.finrank_range_of_inj hinj, finrank_ker_blockSums1 s hne]
  omega

end HamiltonsCubic.Results
