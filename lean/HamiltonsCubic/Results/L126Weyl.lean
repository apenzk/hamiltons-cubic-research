import HamiltonsCubic.Results.L126General

set_option linter.style.longLine false

/-!
# L126's direction is Weyl: the `(2,2)` Bianchi vector lies in the tangent space the record means

[findings/second-order.md](../../../findings/second-order.md), Lemma L126, *"On the tangent space the criticality map
..."*: the tangent space at `M` is the Weyl operators orthogonal to `M`. [L126DF.lean](L126DF.lean)'s `split_DF` has
`⟨M, v⟩ = 0`, and [r1601](../../../reviews/REVIEW_r1601.md) named `v`'s Weyl property as owed. This file proves it:

* **`phi_pair_disjoint`**: for disjoint pairs, `⟨φ_pq, φ_ac⟩ ⟨φ_rs, φ_bc⟩ = 0` at every `a, b, c`;
* **`ric_rk2_disjoint`**: so `U ⊙ V` has zero Ricci contraction when `U`, `V` are basis bivectors on disjoint pairs;
* **`splitVec_isWeyl`**, **`splitVec_isWeyl2`**: the Bianchi vector `2a − b − c` preserves bivectors, is symmetric,
  satisfies first Bianchi (`fourSet_bianchi_iff`) and is Ricci-flat, so it is Weyl, and its restriction is `IsWeyl2`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge

variable {n : ℕ}

theorem phi_pair_disjoint {p q r s : Fin n} (hpr : p ≠ r) (hps : p ≠ s) (hqr : q ≠ r) (hqs : q ≠ s) (a b c : Fin n) :
    inner2 (phi p q) (phi a c) * inner2 (phi r s) (phi b c) = 0 := by
  rw [inner2_phi_phi, inner2_phi_phi]
  by_cases hcp : c = p
  · subst hcp
    simp [Ne.symm hpr, Ne.symm hps]
  · by_cases hcq : c = q
    · subst hcq
      simp [Ne.symm hqr, Ne.symm hqs]
    · simp [Ne.symm hcp, Ne.symm hcq]

theorem ric_rk2_disjoint {p q r s : Fin n} (hpr : p ≠ r) (hps : p ≠ s) (hqr : q ≠ r) (hqs : q ≠ s) (a b : Fin n) :
    Ric (rk2 (phi p q) (phi r s)) a b = 0 := by
  unfold Ric rk2
  simp only [ip_add_l, ip_smul_l]
  refine Finset.sum_eq_zero fun c _ => ?_
  have h1 := phi_pair_disjoint hpr hps hqr hqs b a c
  have h2 := phi_pair_disjoint hpr hps hqr hqs a b c
  linear_combination h1 + h2

/-- **THE `(2,2)` BIANCHI VECTOR IS WEYL.** -/
theorem splitVec_isWeyl {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) : IsWeyl (splitVec i j k l) := by
  refine ⟨fun X _ => splitVec_skew i j k l X, fun X Y _ _ => ?_, fun p q r s => ?_, fun a b => ?_⟩
  · unfold splitVec; simp only [ip_add_l, ip_add_r, ip_smul_l, ip_smul_r, rk2_symm]
  · exact (fourSet_bianchi_iff hij hik hil hjk hjl hkl 2 (-1) (-1)).mpr (by norm_num) p q r s
  · unfold Ric splitVec
    simp only [ip_add_l, ip_smul_l, Finset.sum_add_distrib, ← Finset.mul_sum]
    have r1 := ric_rk2_disjoint hik hil hjk hjl a b
    have r2 := ric_rk2_disjoint (p := k) (q := i) (r := j) (s := l) hjk.symm hkl hij hil a b
    have r3 := ric_rk2_disjoint (p := i) (q := l) (r := j) (s := k) hij hik hjl.symm hkl.symm a b
    unfold Ric at r1 r2 r3
    rw [r1, r2, r3]; ring

theorem splitVec_isWeyl2 {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) :
    IsWeyl2 (restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X)) := by
  have h := isWeyl2_restrict (splitVec_isWeyl hij hik hil hjk hjl hkl)
  have e : restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X)
      = restrict (splitVec_isWeyl hij hik hil hjk hjl hkl) := ContinuousLinearMap.ext fun _ => rfl
  rw [e]; exact h

end HamiltonsCubic.L126Assembly
