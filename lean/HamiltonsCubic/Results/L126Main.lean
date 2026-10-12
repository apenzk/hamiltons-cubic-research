import HamiltonsCubic.Results.L126GenBridge

set_option linter.style.longLine false

/-!
# L126, stated as one theorem

[findings/second-order.md](../../../findings/second-order.md), Lemma L126, *"the four-set `½`-threshold, met in the
two-factor family only at `S³ × S³`"*. The clauses are proved across `L126*.lean`, and this file composes them into
four theorems, on `Fin n`:

* **`L126_general`**: at a Weyl diagonal weight with `P(M) > 0`, every Bianchi vector of a four-set block is Weyl,
  self-adjoint and orthogonal to `M`, the derivative of the criticality map along it at a critical `M` is
  `2M∘v − P(M)v`, and the block meets the `½`-eigenspace of `L_e` exactly when `Σ = P(M)²`;
* **`L126_sphere`**: at a unit sphere product `S^p × S^q`, every four-set block other than a `(2,2)`-split vanishes on
  its Bianchi part, and at each `(2,2)`-split the Bianchi vector `2a − b − c` is nonzero, Weyl and orthogonal to `M`,
  has `L_e v = μ_{p,q} v`, and lies in the kernel of the derivative exactly when `(p,q) = (3,3)`, which is also
  exactly when `μ_{p,q} = ½`, the derivative statement carried in full;
* **`sphere_isCritical2`**: the sphere product is critical on `CurvOp2`, with multiplier `t(n − 1)`;
* **`L126_kernel_orbit`**: at a critical `M` the derivative along a self-adjoint `H ⊥ M` is `2M∘H − P(M)H`, which
  vanishes exactly on the `½`-eigenspace of `L_e`, so `ker DF(M)` there is that eigenspace, and the four-set blocks
  are orbit-free, the orbit tangent along each generator lying in its pair block and orthogonal to every four-set
  operator;
* **`L126_block_meets_iff`**: at a `(2,2)`-split the whole four-set block meets the `½`-eigenspace of `L_e` exactly
  when `(p,q) = (3,3)`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge
  HamiltonsCubic.FourSet

variable {n : ℕ}

/-- **L126 at a general diagonal `M`.** -/
theorem L126_general {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {i j k l : Fin n} (hij : i ≠ j)
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) (hP : 0 < Pcubic (diagOp w)) :
    ((∃ x y z : ℝ, x + y + z = 0 ∧ (x, y, z) ≠ (0 : ℝ × ℝ × ℝ) ∧
        LeLin (restrict (diagOp_isWeyl hwt))
            (restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X))
          = (1 / 2 : ℝ) • restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X))
      ↔ D (w i j + w k l) (w i k + w j l) (w i l + w j k) = Pcubic (diagOp w) ^ 2)
    ∧ ∀ {th : ℝ}, Qop2 (restrict (diagOp_isWeyl hwt)) = th • restrict (diagOp_isWeyl hwt) →
      ∀ {x y z : ℝ}, x + y + z = 0 →
        let M := restrict (diagOp_isWeyl hwt)
        let v := restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X)
        IsWeyl2 v ∧ innerOp2 M v = 0 ∧ ∀ Z : CurvOp2 (Fin n),
          HasDerivAt (fun s : ℝ => innerOp2 Z (critMap (M + s • v))) (innerOp2 Z ((2 : ℝ) • foxProd2 M v - Pcubic2 M • v)) 0 :=
  ⟨general_LeLin_iff hwt hij hik hil hjk hjl hkl hP,
    fun hcrit _ _ _ hs => general_DF hwt hcrit hij hik hil hjk hjl hkl hs⟩

/-- **L126 at `S^p × S^q`.** -/
theorem L126_sphere (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    let hW : IsWeyl (diagOp (t • sphereWeight T)) := diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)
    let M := restrict hW
    -- every block but a `(2,2)`-split vanishes on its Bianchi part
    (∀ {i j k l : Fin n}, i ≠ j → i ≠ k → i ≠ l → j ≠ k → j ≠ l → k ≠ l →
      (if i ∈ T then 1 else 0) + (if j ∈ T then 1 else 0) + (if k ∈ T then 1 else 0) + (if l ∈ T then 1 else 0) ≠ (2 : ℕ) →
      ∀ x y z : ℝ, x + y + z = 0 → ∀ X : Matrix (Fin n) (Fin n) ℝ, IsSkew X →
        foxProd (diagOp (t • sphereWeight T)) (spanVec i j k l x y z) X = 0)
    -- at each `(2,2)`-split the Bianchi vector carries `μ_{p,q}`, and meets the kernel exactly at `(3,3)`
    ∧ (∀ {i j k l : Fin n}, i ∈ T → j ∈ T → k ∉ T → l ∉ T → i ≠ j → k ≠ l →
      let v := restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X)
      v ≠ 0 ∧ IsWeyl2 v ∧ innerOp2 M v = 0 ∧ LeLin M v = HamiltonsCubic.L126Statement.mu T.card Tᶜ.card • v ∧
        (∀ Z : CurvOp2 (Fin n), HasDerivAt (fun s : ℝ => innerOp2 Z (critMap (M + s • v)))
          (innerOp2 Z ((2 : ℝ) • foxProd2 M v - Pcubic2 M • v)) 0) ∧
        ((2 : ℝ) • foxProd2 M v - Pcubic2 M • v = 0 ↔ T.card = 3 ∧ Tᶜ.card = 3))
    ∧ (HamiltonsCubic.L126Statement.mu T.card Tᶜ.card = 1 / 2 ↔ T.card = 3 ∧ Tᶜ.card = 3) := by
  intro hW M
  refine ⟨fun hij hik hil hjk hjl hkl hc x y z hs X hX => nonsplit_kill T t hij hik hil hjk hjl hkl hc hX x y z hs,
    fun {i j k l} hi hj hk hl hij hkl => ?_, HamiltonsCubic.L126Statement.mu_eq_half_iff _ _ hp hq⟩
  have hik : i ≠ k := fun h => hk (h ▸ hi)
  have hil : i ≠ l := fun h => hl (h ▸ hi)
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hjl : j ≠ l := fun h => hl (h ▸ hj)
  exact ⟨splitVec_ne_zero hij hik hil hjk hjl hkl, splitVec_isWeyl2 hij hik hil hjk hjl hkl,
    (split_DF T hp hq t ht hn hi hj hk hl hij hkl).1, split_LeLin T hp hq t ht hn hi hj hk hl hij hkl,
    (split_DF T hp hq t ht hn hi hj hk hl hij hkl).2.1, split_kernel_iff T hp hq t ht hn hi hj hk hl hij hkl⟩

/-- **The sphere product is critical on `CurvOp2`**, with multiplier `t(n − 1)`. -/
theorem sphere_isCritical2 (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) :
    let hW : IsWeyl (diagOp (t • sphereWeight T)) := diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)
    Qop2 (restrict hW) = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • restrict hW := by
  intro hW
  apply isCritical2_of_extend
  intro a b
  have hs := phi_isSkew a b
  rw [Qop_congr_on_skew (fun Z _ => extend_restrict_isSkew hW Z) (fun Z hZ => extend_restrict_on_skew hW Z hZ) _ hs,
    extend_restrict_on_skew hW _ hs]
  exact sphere_isCritical T hp hq t a b

/-- **The remaining clauses of L126**: at a critical `M` the derivative of the criticality map along `M + s H`, for a
self-adjoint `H ⊥ M`, is `2M∘H − P(M)H` (`critMap_hasDerivAt`), and that operator vanishes exactly on the
`½`-eigenspace of `L_e` (`critMap_kernel_iff`), which together are `ker DF(M) = E_½(L_e)` on the tangent space; and the
four-set blocks are orbit-free, the orbit tangent along each generator lying in its pair block and orthogonal to every
four-set operator. -/
theorem L126_kernel_orbit {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) :
    (∀ {th : ℝ}, Qop2 (restrict (diagOp_isWeyl hwt)) = th • restrict (diagOp_isWeyl hwt) →
      ∀ H : CurvOp2 (Fin n), IsSelfAdjoint2 H → innerOp2 (restrict (diagOp_isWeyl hwt)) H = 0 → ∀ Z : CurvOp2 (Fin n),
        HasDerivAt (fun s : ℝ => innerOp2 Z (critMap (restrict (diagOp_isWeyl hwt) + s • H)))
          (innerOp2 Z ((2 : ℝ) • foxProd2 (restrict (diagOp_isWeyl hwt)) H
            - Pcubic2 (restrict (diagOp_isWeyl hwt)) • H)) 0)
    ∧ (∀ H : CurvOp2 (Fin n), Pcubic2 (restrict (diagOp_isWeyl hwt)) ≠ 0 →
      ((2 : ℝ) • foxProd2 (restrict (diagOp_isWeyl hwt)) H - Pcubic2 (restrict (diagOp_isWeyl hwt)) • H = 0
        ↔ LeLin (restrict (diagOp_isWeyl hwt)) H = (1 / 2 : ℝ) • H))
    ∧ (∀ {j k : Fin n}, j ≠ k → ∀ X : Matrix (Fin n) (Fin n) ℝ, IsSkew X →
        orbitTan (diagOp w) j k X = ∑ i, (w j i - w k i) • rk2 (phi j i) (phi k i) X)
    ∧ (∀ j k a b c d : Fin n, a ≠ c → a ≠ d → b ≠ c → b ≠ d →
        innerOp (orbitTan (diagOp w) j k) (rk2 (phi a b) (phi c d)) = 0) :=
  ⟨fun hcrit H hH hperp Z => critMap_hasDerivAt (isSelfAdjoint2_restrict (diagOp_isWeyl hwt)) hH hcrit hperp Z,
    fun _ hθ => critMap_kernel_iff hθ,
    fun hjk _ hX => orbit_in_pairBlock w (fun p q => hwt.symm p q) (fun a => hwt.hollow a) hjk hX,
    fun j k a b c d hac had hbc hbd => orbit_perp_fourSet w (fun p q => hwt.symm p q) j k a b c d hac had hbc hbd⟩

/-- **The whole `(2,2)` block meets the `½`-eigenspace of `L_e` exactly at `S³ × S³`**: at a unit sphere product and
a `(2,2)`-split, some Bianchi vector of the four-set block with a nonzero coefficient triple has `L_e v = ½ v` exactly
when `(p,q) = (3,3)`. -/
theorem L126_block_meets_iff (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {i j k l : Fin n} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T)
    (hl : l ∉ T) (hij : i ≠ j) (hkl : k ≠ l) :
    (∃ x y z : ℝ, x + y + z = 0 ∧ (x, y, z) ≠ (0 : ℝ × ℝ × ℝ) ∧
        LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)))
            (restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X))
          = (1 / 2 : ℝ) • restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X))
      ↔ T.card = 3 ∧ Tᶜ.card = 3 := by
  have hik : i ≠ k := fun h => hk (h ▸ hi)
  have hil : i ≠ l := fun h => hl (h ▸ hi)
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hjl : j ≠ l := fun h => hl (h ▸ hj)
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : Pcubic (diagOp (t • sphereWeight T)) = theta (diagOp (t • sphereWeight T)) := (theta_of_unit _ hn).symm
  have hθ0 : 0 < theta (diagOp (t • sphereWeight T)) := by
    rw [theta_sphereProduct_value T hp hq t ht hn, thetaSplit]
    apply Real.sqrt_pos.mpr
    unfold thetaSplitSq
    apply div_pos
    · have : 0 < (T.card : ℝ) - 1 := by linarith
      have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
      have : 0 < (T.card : ℝ) + Tᶜ.card - 1 := by linarith
      positivity
    · have : 0 < (T.card : ℝ) + Tᶜ.card - 2 := by linarith
      positivity
  rw [general_LeLin_iff ((sphereWeight_isWeight T hp hq).smul t) hij hik hil hjk hjl hkl (hθ ▸ hθ0), hθ]
  have h := HamiltonsCubic.L57Critical.L126_threshold T hp hq t ht hn i j k l hi hj hk hl hij hkl
  simp only at h
  rw [← HamiltonsCubic.L126Statement.recip_iff_three_three _ _ hp hq, ← h]
  unfold D
  rfl

end HamiltonsCubic.L126Assembly
