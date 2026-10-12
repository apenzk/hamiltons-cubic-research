import Mathlib
import HamiltonsCubic.Results.L27Pair
import HamiltonsCubic.Results.L127DnEig
import HamiltonsCubic.Results.L126GenBridge

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L27's diagonal sector: `L_e` on a character-`1` component of `W^⊥` at a sphere product

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L27: *$1$ on $\langle W\rangle$ … $\lambda_m=(m-2)/(2(m-1))<\tfrac12$ on
$S^2_0(\mathbb R^m)$ … $-\mu$ on $S^2_0\otimes S^2_0$ … and $0$ on the remaining four.* In the sign-group route these are the
values on the coordinate-diagonal sector $\mathcal D_n$, which [L127DnExcl.lean](L127DnExcl.lean)'s `dn_excl_fox` lists and
[L127DnEig.lean](L127DnEig.lean)'s `dn_eig_line` places: the value `1` lives on the sphere-weight line, which is `⟨W⟩`.

* `fox_bridge`: `M ∘ D = c D` between two restricted diagonal operators gives the bare relation on every `φ_{ab}`;
* **`dn_sphere`**: at a unit sphere product with `p, q ≥ 3`, an `L_e`-eigenvalue on a nonzero Weyl component of character
  `1` orthogonal to `M` is below `1/2`.
-/

namespace HamiltonsCubic.L27Dn

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.PairSquare

variable {n : ℕ}

/-- **The bare relation on the `φ_{ab}`** from `M ∘ D = c D` between restricted diagonal operators. -/
theorem fox_bridge {w u : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (hu : IsWeight u) {c : ℝ}
    (h : foxProd2 (restrict (diagOp_isWeyl hw)) (restrict (diagOp_isWeyl hu)) = c • restrict (diagOp_isWeyl hu)) :
    ∀ a b, foxProd (diagOp w) (diagOp u) (phi a b) = c • diagOp u (phi a b) := by
  intro a b
  have e := congrArg (fun F : CurvOp2 (Fin n) =>
    ((F ⟨phi a b, phi_mem_skewSub a b⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) h
  rw [restrict_eq_restrictLin' (isLinOp_diagOp u) (diagOp_isWeyl hu),
    bridge_apply (diagOp_isWeyl hw) (isLinOp_diagOp u) (diagOp_isWeyl hu).1] at e
  rw [e, _root_.smul_apply, Submodule.coe_smul]
  rfl

/-- **L27's diagonal sector at a sphere product**: at `p, q ≥ 3`, an `L_e`-eigenvalue on a nonzero Weyl operator of character
`1` orthogonal to the unit sphere product `M` is below `1/2`. -/
theorem dn_sphere (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {D : CurvOp2 (Fin n)} (hDW : IsWeyl2 D)
    (hD1 : SignChar (fun _ => 1) D) (hD0 : D ≠ 0)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = 0)
    {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = lam • D) :
    lam < 1 / 2 := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  set w := t • sphereWeight T with hwdef
  have hwt : IsWeight w := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hPθ : Pcubic (diagOp w) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp w) (diagOp_isWeyl hwt), hPθ]
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (3 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  -- `D` is diagonal
  obtain ⟨u, hu, rfl⟩ := (HamiltonsCubic.L120Ident.trivial_block_iff D hDW).mp hD1
  have hu0 : u ≠ 0 := by
    rintro rfl
    apply hD0
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    rw [restrict_apply]
    show diagOp 0 (X : Matrix (Fin n) (Fin n) ℝ) = 0
    ext a b
    simp [diagOp]
  -- the eigen-relation as `M ∘ D = (λθ) D`
  have hfox : foxProd2 M (restrict (diagOp_isWeyl hu))
      = (lam * (t * ((T.card : ℝ) + Tᶜ.card - 1))) • restrict (diagOp_isWeyl hu) := by
    have h1 : LeLin M (restrict (diagOp_isWeyl hu)) = (Pcubic2 M)⁻¹ • foxProd2 M (restrict (diagOp_isWeyl hu)) :=
      foxProd2_smul_left _ _ _
    rw [h1, hPM] at heig
    have h2 := congrArg (fun F => (t * ((T.card : ℝ) + Tᶜ.card - 1)) • F) heig
    simp only [smul_smul, mul_inv_cancel₀ hθ.ne', one_smul] at h2
    rw [h2, mul_comm]
  have hf := fox_bridge hwt hu hfox
  have hmem := dn_excl_fox T hp2 hq2 t hu hu0 hf
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hmem
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  simp only [dnLp, dnLq, dnMu] at u1 u2 u3 u4 u5
  have hlp : ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  have hlq : ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  rcases hmem with h | h | h | h | h
  · -- the value `1`: `u` is on the sphere-weight line, against `D ⊥ M`
    exfalso
    have hl : lam = 1 := by
      have := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _))
      linarith
    have hKL := KL_of_fox w u hwt.symm hwt.hollow hu.symm hu.hollow _ hf
    have hmem' : u ∈ dnWeights (Fin n) ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1) := by
      refine ⟨hu, Module.End.mem_eigenspace_iff.mpr ?_⟩
      rw [← hwdef, hKL, h]
      unfold dnθ; ring_nf
    rw [dn_eig_line T hp hq t ht.ne'] at hmem'
    obtain ⟨s, hs⟩ := Submodule.mem_span_singleton.mp hmem'
    have hD : restrict (diagOp_isWeyl hu) = (s / t) • M := by
      rw [← coordOp_eq_restrict hu, hMdef, ← coordOp_eq_restrict hwt, ← coordOp_smul', ← hs, hwdef, smul_smul,
        div_mul_cancel₀ s ht.ne']
    have hN : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp w) (diagOp_isWeyl hwt), hn]
    rw [hD, innerOp2_smul_right] at hperp
    unfold normSq2 at hN
    rw [hN, mul_one] at hperp
    have hs0 : s = 0 := by
      rcases div_eq_zero_iff.mp hperp with h' | h'
      · exact h'
      · exact absurd h' ht.ne'
    apply hu0
    rw [← hs, hs0, zero_smul]
  · have := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); linarith
  · have := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); linarith
  · have := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); linarith
  · have : lam = 0 := by
      rcases mul_eq_zero.mp h with h' | h'
      · exact h'
      · exact absurd h' hθ.ne'
    linarith

end HamiltonsCubic.L27Dn
