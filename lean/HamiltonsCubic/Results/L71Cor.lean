import Mathlib
import HamiltonsCubic.Results.L71Witness
import HamiltonsCubic.Base.Bivectors2

set_option linter.style.longLine false

/-!
# L71's one-step corollaries: two eigenvalues, and `𝔰𝔬(n) = 𝔥 ⊕ 𝔪`

[findings/bounds.md](../../../findings/bounds.md), Lemma L71: *"Then $\mathfrak r=0$,
$\mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m$ is a symmetric pair with $\mathfrak h=[\mathfrak m,\mathfrak m]$,
$W$ has exactly two eigenvalues ..."*. [L71Sat.lean](L71Sat.lean)'s `L71_saturated` gives `𝔯 = 0`,
`𝔥 = [𝔪, 𝔪]` and `[𝔥, 𝔥] ⊆ 𝔥` for the spectral frame's spans, and the L71 row owes the one-step
corollaries. They hold at any orthonormal complete eigenframe whose middle span vanishes:

* `two_valued`: every frame eigenvalue is `λ_min` or `λ_max`;
* `skew_mem_sup`: every skew matrix lies in `𝔪 ⊔ 𝔥`, `𝔪 = span{v_k : λ_k = λ_min}`, `𝔥 = span{v_k : λ_k = λ_max}`;
* `inf_eq_bot`: `𝔪 ⊓ 𝔥 = ⊥` when `λ_min ≠ λ_max`;
* `L71_corollaries`: at every saturating critical point of `L71_saturated`, `W` is two-valued on
  its spectral frame and `𝔰𝔬(n) = 𝔪 ⊕ 𝔥`; `witness_two_valued` reads it at the balanced sphere product.
-/

namespace HamiltonsCubic.L71Cor

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L41Statement
  HamiltonsCubic.L71Sat

variable {n : ℕ} {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

/-- The pairing with `v j`, as a linear functional. -/
noncomputable def pairWith (Y : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ →ₗ[ℝ] ℝ where
  toFun X := inner2 X Y
  map_add' A B := FamilyLayer.inner2_add_left A B Y
  map_smul' c X := by simp [FamilyLayer.inner2_smul_left]

theorem ne_zero_of_unit {X : Matrix (Fin n) (Fin n) ℝ} (h : inner2 X X = 1) : X ≠ 0 := by
  rintro rfl
  simp [inner2_eq_sum] at h

omit [Fintype Γ] [DecidableEq Γ] in
/-- **Two eigenvalues**: an empty middle span forces every frame eigenvalue to an end. -/
theorem two_valued (v : Γ → Matrix (Fin n) (Fin n) ℝ) (ev : Γ → ℝ) (lmin lmax : ℝ)
    (hon : ∀ k, inner2 (v k) (v k) = 1)
    (hmid : spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) = ⊥) (k : Γ) :
    ev k = lmin ∨ ev k = lmax := by
  by_contra h
  push Not at h
  have hk : v k ∈ spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) :=
    Submodule.subset_span ⟨k, h, rfl⟩
  rw [hmid, Submodule.mem_bot] at hk
  exact ne_zero_of_unit (hon k) hk

omit [DecidableEq Γ] in
/-- **`𝔪 ⊔ 𝔥` contains every skew matrix.** -/
theorem skew_mem_sup (v : Γ → Matrix (Fin n) (Fin n) ℝ) (ev : Γ → ℝ) (lmin lmax : ℝ)
    (hon : ∀ k, inner2 (v k) (v k) = 1)
    (hcomplete : ∀ X, IsSkew X → X = ∑ γ, inner2 X (v γ) • v γ)
    (hmid : spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) = ⊥)
    (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    X ∈ spanOf v (fun k => ev k = lmin) ⊔ spanOf v (fun k => ev k = lmax) := by
  rw [hcomplete X hX]
  refine Submodule.sum_mem _ fun k _ => Submodule.smul_mem _ _ ?_
  rcases two_valued v ev lmin lmax hon hmid k with h | h
  · exact Submodule.mem_sup_left (Submodule.subset_span ⟨k, h, rfl⟩)
  · exact Submodule.mem_sup_right (Submodule.subset_span ⟨k, h, rfl⟩)

omit [Fintype Γ] in
/-- A span of frame vectors off `j`'s class is orthogonal to `v j`. -/
theorem span_orth (v : Γ → Matrix (Fin n) (Fin n) ℝ) (ev : Γ → ℝ) (c : ℝ)
    (horth : ∀ γ δ, inner2 (v γ) (v δ) = if γ = δ then 1 else 0) (j : Γ) (hj : ev j ≠ c)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : x ∈ spanOf v (fun k => ev k = c)) : inner2 x (v j) = 0 := by
  have hle : spanOf v (fun k => ev k = c) ≤ LinearMap.ker (pairWith (v j)) := by
    refine Submodule.span_le.mpr ?_
    rintro _ ⟨k, hk, rfl⟩
    have hkj : k ≠ j := by rintro rfl; exact hj hk
    show inner2 (v k) (v j) = 0
    rw [horth, if_neg hkj]
  exact hle hx

/-- **`𝔪 ⊓ 𝔥 = ⊥`** when the two eigenvalues differ. -/
theorem inf_eq_bot (v : Γ → Matrix (Fin n) (Fin n) ℝ) (ev : Γ → ℝ) (lmin lmax : ℝ) (hne : lmin ≠ lmax)
    (hskew : ∀ k, IsSkew (v k))
    (horth : ∀ γ δ, inner2 (v γ) (v δ) = if γ = δ then 1 else 0)
    (hcomplete : ∀ X, IsSkew X → X = ∑ γ, inner2 X (v γ) • v γ) :
    spanOf v (fun k => ev k = lmin) ⊓ spanOf v (fun k => ev k = lmax) = ⊥ := by
  rw [eq_bot_iff]
  intro x hx
  rw [Submodule.mem_inf] at hx
  rw [Submodule.mem_bot]
  have hxs : IsSkew x := by
    have hle : spanOf v (fun k => ev k = lmin) ≤ skewSub (Fin n) := by
      refine Submodule.span_le.mpr ?_
      rintro _ ⟨k, -, rfl⟩
      exact hskew k
    exact hle hx.1
  have hc : ∀ j, inner2 x (v j) = 0 := by
    intro j
    by_cases hj : ev j = lmin
    · exact span_orth v ev lmax horth j (by rw [hj]; exact hne) x hx.2
    · exact span_orth v ev lmin horth j hj x hx.1
  rw [hcomplete x hxs]
  simp [hc]

open HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind in
/-- **L71's corollaries at every saturating critical point**: on the spectral frame `W` has the two
eigenvalues `λ_min`, `λ_max` only, and the skew matrices split as `𝔪 ⊕ 𝔥`. -/
theorem L71_corollaries (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin) :
    let v := frameVec W hW.1 hW.2.1 hW.2.2.1;
    let ev := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues;
    (∀ k, ev k = lmin ∨ ev k = lmax) ∧
      (∀ X, IsSkew X → X ∈ spanOf v (fun k => ev k = lmin) ⊔ spanOf v (fun k => ev k = lmax)) ∧
      spanOf v (fun k => ev k = lmin) ⊓ spanOf v (fun k => ev k = lmax) = ⊥ := by
  intro v ev
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  have hsat' := L71_saturated hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat hex
  have hon : ∀ k, inner2 (v k) (v k) = 1 := fun k => by simpa using hf.orthonormal k k
  exact ⟨two_valued v ev lmin lmax hon hsat'.1,
    fun X hX => skew_mem_sup v ev lmin lmax hon hf.complete hsat'.1 X hX,
    inf_eq_bot v ev lmin lmax (by linarith) hf.skew hf.orthonormal hf.complete⟩

open HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind HamiltonsCubic.L71Witness in
/-- **At the balanced sphere product** the spectral eigenvalues are `-1/(2p-1)` and
`1/(p-1) - 1/(2p-1)` only. -/
theorem witness_two_valued (p : ℕ) (hp : 3 ≤ p) :
    let hW := Wb_isWeylOp p (by omega);
    ∀ k, (Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues k = -(1 / (2 * (p : ℝ) - 1)) ∨
      (Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues k
        = 1 / ((p : ℝ) - 1) - 1 / (2 * (p : ℝ) - 1) := by
  intro hW
  have hpR : (3 : ℝ) ≤ p := by exact_mod_cast hp
  have h1 : 0 < (p : ℝ) - 1 := by linarith
  have h2 : 0 < 2 * (p : ℝ) - 1 := by linarith
  have hC : 0 < 1 / (2 * (p : ℝ) - 1) := by positivity
  have hAC : 1 / (2 * (p : ℝ) - 1) < 1 / ((p : ℝ) - 1) := one_div_lt_one_div_of_lt h1 (by linarith)
  exact (L71_corollaries (n := 2 * p) (by omega) (Wb p) hW 1 (Wb_critical p hp) _ _ (by linarith)
    (by linarith) (fun j => (ev_bounds p hp j).1) (fun j => (ev_bounds p hp j).2)
    (by push_cast; field_simp; ring) (ev_attains p hp)).1

end HamiltonsCubic.L71Cor
