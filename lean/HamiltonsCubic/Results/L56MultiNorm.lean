import Mathlib
import HamiltonsCubic.Results.L56Norm
import HamiltonsCubic.Results.L56Multi

set_option linter.style.longLine false

/-!
# L56's multi-block gaps, from the vertex operator

[L56Multi.lean](L56Multi.lean) takes the gap of `k` equal spheres as the definition `multiGapSq`
(smallest modulus `c` over the pair sum of the unit-sphere weights) and evaluates `(2,2,8)` from its
weights by hand. [L56Norm.lean](L56Norm.lean) proves `normSq (diagOp vW)` at every product of spheres.
This file reads both multi-block figures off the operator:

* `vertex_min_multi`: at `k ≥ 2` equal factors of size `p` the across entry `1` is the smallest
  vertex modulus, `(n-p)/(p-1) ≥ 1`;
* `multiGapSq_closed`: `multiGapSq k p = 2(p-1)/(n(n-p)(n-1))`, `n = kp`;
* `multiGapSq_eq_normalised`: `multiGapSq k p = 1² / normSq (diagOp vW)` at every labelling with `k`
  factors of size `p`, so `gap_S3_four`'s `1/297` is the normalised smallest modulus of `(S³)⁴`;
* `beta228`, `bs228`: the labelling `(2,2,8)` of `Fin 12`; `vertex_min_228`: its smallest vertex modulus is
  `4/7`; `gap228_eq_normalised`: `(4/7)² / normSq (diagOp vW) = 4/3003`, L56Multi's `gap_228`.
-/

namespace HamiltonsCubic.L56MultiNorm

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L56Weyl
  HamiltonsCubic.L56Norm

/-- **The across entry is the smallest** at `k ≥ 2` equal factors: `(kp-p)/(p-1) ≥ 1`. -/
theorem vertex_min_multi {k p : ℕ} (hk : 2 ≤ k) (hp : 2 ≤ p) :
    (1 : ℝ) ≤ ((k : ℝ) * p - p) / ((p : ℝ) - 1) := by
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp
  have hkR : (2 : ℝ) ≤ k := by exact_mod_cast hk
  rw [le_div_iff₀ (by linarith)]
  nlinarith

/-- **The closed form of `multiGapSq`**: `2(p-1)/(n(n-p)(n-1))`, `n = kp`. -/
theorem multiGapSq_closed {k p : ℝ} (hk : 2 ≤ k) (hp : 2 ≤ p) :
    HamiltonsCubic.L56Statement.multiGapSq k p = 2 * (p - 1) / ((k * p) * (k * p - p) * (k * p - 1)) := by
  have h1 : p - 1 ≠ 0 := by linarith
  have hn : k * p - 1 ≠ 0 := by nlinarith
  have hnp : k * p - p ≠ 0 := by nlinarith
  have hkp : k * p ≠ 0 := by positivity
  have hD : k * (p * (p - 1) / 2) * (1 - HamiltonsCubic.L56Statement.cMulti k p) ^ 2
      + ((k * p) * (k * p - 1) / 2 - k * (p * (p - 1) / 2)) * HamiltonsCubic.L56Statement.cMulti k p ^ 2
      = (p - 1) * (k * p) * (k * p - p) / (2 * (k * p - 1)) := by
    unfold HamiltonsCubic.L56Statement.cMulti
    field_simp
    ring
  rw [HamiltonsCubic.L56Statement.multiGapSq, hD, HamiltonsCubic.L56Statement.cMulti]
  field_simp

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {κ : Type*} [DecidableEq κ]

/-- **`k` equal factors**: `multiGapSq k p = 1² / normSq (diagOp vW)`, the across modulus `1` over the
norm of the vertex operator. -/
theorem multiGapSq_eq_normalised (β : ι → κ) {k p : ℕ} (hp : ∀ a, bs β a = p) (hp2 : 2 ≤ p)
    (hk : 2 ≤ k) (hcard : Fintype.card ι = k * p) :
    HamiltonsCubic.L56Statement.multiGapSq k p = 1 ^ 2 / normSq (diagOp (vW β)) := by
  have hbs : ∀ a, 2 ≤ bs β a := fun a => by rw [hp a]; exact hp2
  have hn : 2 ≤ Fintype.card ι := by rw [hcard]; nlinarith
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp2
  have hkR : (2 : ℝ) ≤ k := by exact_mod_cast hk
  have hN : (Fintype.card ι : ℝ) = k * p := by rw [hcard]; push_cast; ring
  rw [normSq_vertex β hbs hn]
  simp only [hp, Finset.sum_const, Finset.card_univ, nsmul_eq_mul, hN]
  rw [multiGapSq_closed hkR hpR]
  have h1 : (p : ℝ) - 1 ≠ 0 := by linarith
  have hn1 : (k : ℝ) * p - 1 ≠ 0 := by nlinarith
  have hnp : (k : ℝ) * p - p ≠ 0 := by nlinarith
  have hkp : (k : ℝ) * p ≠ 0 := by positivity
  field_simp
  ring

/-! ## `(2,2,8)` -/

/-- The labelling `(2,2,8)` of `Fin 12`. -/
def beta228 : Fin 12 → Fin 3 := ![0, 0, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2]

theorem bs228 : ∀ a : Fin 12, bs beta228 a = if a.val < 4 then 2 else 8 := by decide

theorem bs228_ge : ∀ a : Fin 12, 2 ≤ bs beta228 a := fun a => by
  rw [bs228 a]; split_ifs <;> norm_num

/-- **The smallest vertex modulus of `(2,2,8)` is `4/7`**: the entries are `-10` within an `S²`,
`-4/7` within `S⁸` and `1` across. -/
theorem vertex_min_228 (a b : Fin 12) (hab : a ≠ b) : (4 / 7 : ℝ) ≤ |vW beta228 a b| := by
  have e : vW beta228 a b = -((Fintype.card (Fin 12) : ℝ) - 1) * weylE beta228 a b := rfl
  rw [e, vertex_entries beta228 bs228_ge (by simp) a b hab, bs228 a]
  simp only [Fintype.card_fin]
  split_ifs <;> norm_num [abs_of_nonneg, abs_of_nonpos]

/-- **`gap((2,2,8))² = 4/3003`**, L56Multi's `gap_228`, as the smallest vertex modulus over the norm of
the vertex operator. -/
theorem gap228_eq_normalised : (4 / 7 : ℝ) ^ 2 / normSq (diagOp (vW beta228)) = 4 / 3003 := by
  rw [normSq_vertex beta228 bs228_ge (by simp)]
  simp only [bs228, Fintype.card_fin, Fin.sum_univ_succ, Fin.sum_univ_zero]
  norm_num

end HamiltonsCubic.L56MultiNorm
