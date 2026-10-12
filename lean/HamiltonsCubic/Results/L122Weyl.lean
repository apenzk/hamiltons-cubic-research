import HamiltonsCubic.Results.L122Pair
import HamiltonsCubic.Results.L126Weyl

set_option linter.style.longLine false

/-!
# L122's pair span is Weyl on its Bianchi part

[findings/second-order.md](../../../findings/second-order.md), Lemma L122, and [r1608](../../../reviews/REVIEW_r1608.md)'s
owed item: `lambda_min_bound`'s `hcap` is L24's cap on Weyl directions orthogonal to `M`, and this file gives the Weyl
half of that domain, [L122Orbit.lean](L122Orbit.lean)'s `pair_perp` the orthogonal half.

* **`bianchi_pairBasis`**: one pair-basis operator `f_i = φ_ji ⊙ φ_ki` satisfies first Bianchi at every tuple, its two
  pairs sharing the index `i`, by splitting each index over `j, k, i` and the rest;
* **`pairSpan_isWeyl`**: `∑_{i∈s} c_i f_i`, `s` avoiding `j` and `k`, preserves bivectors, is symmetric, satisfies first
  Bianchi, and is Ricci-flat when `∑ c_i = 0` ([L122Pair.lean](L122Pair.lean)'s `pair_ricciFlat_iff`), so it is Weyl.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {n : ℕ}

set_option maxHeartbeats 4000000 in
-- the proof splits each of the four indices over `j, k, i` and the rest, 256 branches each closed by `simp_all`
/-- **One pair-basis operator satisfies first Bianchi at every tuple**, its two pairs sharing the index `i`. -/
theorem bianchi_pairBasis {j k i : Fin n} (hjk : j ≠ k) (hji : j ≠ i) (hki : k ≠ i) (p q r s : Fin n) :
    bianchi (rk2 (phi j i) (phi k i)) p q r s = 0 := by
  unfold bianchi rk2
  simp only [ip_add_l, ip_smul_l, inner2_phi_phi]
  rcases (show j = p ∨ k = p ∨ i = p ∨ (p ≠ j ∧ p ≠ k ∧ p ≠ i ∧ j ≠ p ∧ k ≠ p ∧ i ≠ p) by tauto)
    with hp | hp | hp | hp <;> (try subst hp) <;>
  rcases (show j = q ∨ k = q ∨ i = q ∨ (q ≠ j ∧ q ≠ k ∧ q ≠ i ∧ j ≠ q ∧ k ≠ q ∧ i ≠ q) by tauto)
    with hq | hq | hq | hq <;> (try subst hq) <;>
  rcases (show j = r ∨ k = r ∨ i = r ∨ (r ≠ j ∧ r ≠ k ∧ r ≠ i ∧ j ≠ r ∧ k ≠ r ∧ i ≠ r) by tauto)
    with hr | hr | hr | hr <;> (try subst hr) <;>
  rcases (show j = s ∨ k = s ∨ i = s ∨ (s ≠ j ∧ s ≠ k ∧ s ≠ i ∧ j ≠ s ∧ k ≠ s ∧ i ≠ s) by tauto)
    with hs | hs | hs | hs <;> (try subst hs) <;>
  simp_all [hjk.symm, hji.symm, hki.symm]

/-- **THE PAIR SPAN'S BIANCHI VECTORS ARE WEYL**: `∑_{i∈s} c_i f_i`, `s` avoiding `j` and `k`, preserves bivectors, is
symmetric, satisfies first Bianchi at every tuple, and is Ricci-flat when `∑ c_i = 0`. -/
theorem pairSpan_isWeyl {j k : Fin n} (hjk : j ≠ k) (s : Finset (Fin n)) (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i)
    (c : Fin n → ℝ) (hsum : ∑ i ∈ s, c i = 0) :
    IsWeyl (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) := by
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun p q r t => ?_, fun a b => ?_⟩
  · have hsk : ∀ i, IsSkew (c i • rk2 (phi j i) (phi k i) X) := fun i => by
      have h := rk2_skew (phi_isSkew j i) (phi_isSkew k i) X
      unfold IsSkew at *; rw [Matrix.transpose_smul, h, smul_neg]
    unfold IsSkew at *
    rw [Matrix.transpose_sum]
    simp only [hsk, Finset.sum_neg_distrib]
  · simp only [ip_sum_l, ip_smul_l, inner2_sum_right, ip_smul_r, rk2_symm]
  · unfold bianchi
    simp only [ip_sum_l, ip_smul_l]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    refine Finset.sum_eq_zero fun i hi => ?_
    have h := bianchi_pairBasis hjk (hs i hi).1 (hs i hi).2 p q r t
    unfold bianchi at h
    rw [← mul_add, ← mul_add, h, mul_zero]
  · exact (pair_ricciFlat_iff hjk s hs c).mpr hsum a b

end HamiltonsCubic.L126Assembly
