import HamiltonsCubic.Results.L126Bridge
import HamiltonsCubic.Results.L126Kernel

set_option linter.style.longLine false

/-!
# L126 at the sphere product: the `(2,2)` Bianchi vector is killed by `2M∘ − P(M)` exactly at `S³ × S³`

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *"`ker DF(M)` is the `½`-eigenspace of `L_e`,
which ... a four-set block meets exactly when `Σ_{ijkl} = θ²`"*, and at `S^p × S^q` *"`μ_{p,q} = ½ ⟺ (p,q) = (3,3)`"*.

* **`splitVec_phi`**, **`splitVec_ne_zero`**: the Bianchi vector sends `φ_ij` to `2φ_kl`, so it is nonzero;
* **`split_kernel_iff`**: at a unit sphere product on `Fin n` and a `(2,2)`-split, the Bianchi vector is killed by the
  operator `2M∘ − P(M)` exactly when `(p,q) = (3,3)`, composing [L126Bridge.lean](L126Bridge.lean)'s `split_LeLin` with
  [L126Kernel.lean](L126Kernel.lean)'s `critMap_kernel_iff` and [L126Statement.lean](L126Statement.lean)'s
  `mu_eq_half_iff`. The operator is the derivative of the criticality map along `M + s v`, by
  [L126DF.lean](L126DF.lean)'s `split_DF`, which discharges `critMap_hasDerivAt`'s hypotheses at this `M` and `v`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge

variable {n : ℕ}

theorem splitVec_phi {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (_hkl : k ≠ l) : splitVec i j k l (phi i j) = (2 : ℝ) • phi k l := by
  unfold splitVec rk2
  rw [inner2_phi_phi, inner2_phi_phi, inner2_phi_phi, inner2_phi_phi, inner2_phi_phi, inner2_phi_phi]
  simp only [hij, hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, and_true, and_false, if_true, if_false,
    and_self]
  module

theorem splitVec_ne_zero {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) :
    restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X) ≠ 0 := by
  intro h
  have e := congrArg (fun F : CurvOp2 (Fin n) => ((F ⟨phi i j, phi_isSkew i j⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) h
  change splitVec i j k l (phi i j) = _ at e
  rw [splitVec_phi hij hik hil hjk hjl hkl] at e
  have h1 := congrArg (fun A : Matrix (Fin n) (Fin n) ℝ => A l k) e
  simp [phi, hkl] at h1

/-- **L126 AT THE SPHERE PRODUCT**: `2M∘v − P(M)v = 0` for the `(2,2)` Bianchi vector exactly when `(p,q) = (3,3)`. -/
theorem split_kernel_iff (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {i j k l : Fin n} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T)
    (hl : l ∉ T) (hij : i ≠ j) (hkl : k ≠ l) :
    let hW : IsWeyl (diagOp (t • sphereWeight T)) := diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)
    let M := restrict hW
    let v := restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X)
    ((2 : ℝ) • foxProd2 M v - Pcubic2 M • v = 0 ↔ T.card = 3 ∧ Tᶜ.card = 3) := by
  intro hW M v
  have hik : i ≠ k := fun h => hk (h ▸ hi)
  have hil : i ≠ l := fun h => hl (h ▸ hi)
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hjl : j ≠ l := fun h => hl (h ▸ hj)
  have hP : Pcubic2 M = theta (diagOp (t • sphereWeight T)) := by
    rw [Pcubic2_restrict (isLinOp_diagOp _) hW, theta_of_unit _ hn]
  have hval := split_value_eq T hp hq t ht hn hi hj hk hl hij hkl
  simp only at hval
  have hmu : 0 < HamiltonsCubic.L126Statement.mu T.card Tᶜ.card := by
    unfold HamiltonsCubic.L126Statement.mu
    have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
    have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
    have : 0 < (T.card : ℝ) - 1 := by linarith
    have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
    apply div_pos (by linarith) (by positivity)
  have hθ : Pcubic2 M ≠ 0 := by
    rw [hP]; intro h0; rw [h0, mul_zero, div_zero] at hval; linarith
  rw [critMap_kernel_iff hθ, split_LeLin T hp hq t ht hn hi hj hk hl hij hkl,
    ← HamiltonsCubic.L126Statement.mu_eq_half_iff _ _ hp hq]
  constructor
  · intro h
    have e := congrArg (fun F : CurvOp2 (Fin n) => ((F ⟨phi i j, phi_isSkew i j⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) h
    simp only [_root_.smul_apply, Submodule.coe_smul] at e
    change HamiltonsCubic.L126Statement.mu T.card Tᶜ.card • splitVec i j k l (phi i j)
      = (1 / 2 : ℝ) • splitVec i j k l (phi i j) at e
    rw [splitVec_phi hij hik hil hjk hjl hkl] at e
    have e2 := congrArg (fun A : Matrix (Fin n) (Fin n) ℝ => A l k) e
    simp [phi, hkl, hkl.symm] at e2
    linarith
  · intro h; rw [h]

end HamiltonsCubic.L126Assembly
