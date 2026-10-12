import HamiltonsCubic.Results.B12PairSphere
import HamiltonsCubic.Results.B12FourSector

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 6b: the four-set sectors at the sphere product

[B12FourSector.lean](B12FourSector.lean)'s `trace_four_sector` gives the sector `{i, j, k, l}` as
`½(A² + B² + C² − AB − BC − CA)`, `A`, `B`, `C` the opposite-pair sums of the weight. At the sphere product `t · W_T` the
value depends only on how many of the four indices lie in `T`:

* `count4`: that number, as `[i ∈ T] + [j ∈ T] + [k ∈ T] + [l ∈ T]`, and **`card_inter_four`**: it is `|{i,j,k,l} ∩ T|`;
* **`four_sphere_val`**: the value is `2θ²μ²` when two of the four lie in `T`, where `B = C = −2t` and `A + 2t = θ(n − 2)/((p − 1)(q − 1))`,
  and `0` otherwise, where `A = B = C`.

`θ` and `−μ` are [L127DnEig.lean](L127DnEig.lean)'s `dnθ`, `dnMu`. [r1919](../../../reviews/REVIEW_r1919.md) derived the same by hand.
-/

namespace HamiltonsCubic.B12FourSphere

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Four

variable {n : ℕ}

/-- The four-set value, `½(A² + B² + C² − AB − BC − CA)`. -/
noncomputable def fourVal (w : Matrix (Fin n) (Fin n) ℝ) (i j k l : Fin n) : ℝ :=
  (sA w i j k l ^ 2 + sB w i j k l ^ 2 + sC w i j k l ^ 2 - sA w i j k l * sB w i j k l
    - sB w i j k l * sC w i j k l - sC w i j k l * sA w i j k l) / 2

/-- How many of the four indices lie in `T`. -/
def count4 (T : Finset (Fin n)) (i j k l : Fin n) : ℕ :=
  (if i ∈ T then 1 else 0) + (if j ∈ T then 1 else 0) + (if k ∈ T then 1 else 0) + (if l ∈ T then 1 else 0)

theorem card_inter_four (T : Finset (Fin n)) {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l)
    (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) :
    (({i, j, k, l} : Finset (Fin n)) ∩ T).card = count4 T i j k l := by
  rw [← Finset.filter_mem_eq_inter]
  simp only [Finset.filter_insert, Finset.filter_singleton, count4]
  by_cases hi : i ∈ T <;> by_cases hj : j ∈ T <;> by_cases hk : k ∈ T <;> by_cases hl : l ∈ T <;>
    simp [hi, hj, hk, hl, hij, hik, hil, hjk, hjl, hkl]

section sphere

variable (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ)

include hp hq in
/-- **The four-set value at the sphere product.** -/
theorem four_sphere_val {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) :
    fourVal (t • sphereWeight T) i j k l = if count4 T i j k l = 2 then 2 * dnθ T t ^ 2 * dnMu T ^ 2 else 0 := by
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by
    have : (3 : ℝ) ≤ T.card := by exact_mod_cast hp
    linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by
    have : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
    linarith
  rw [smul_sphereWeight_eq]
  unfold fourVal sA sB sC count4 dnθ dnMu
  by_cases hi : i ∈ T <;> by_cases hj : j ∈ T <;> by_cases hk : k ∈ T <;> by_cases hl : l ∈ T <;>
    simp only [HamiltonsCubic.Results.blockW, Matrix.of_apply, hij, hik, hil, hjk, hjl, hkl, hi, hj, hk, hl,
      if_false, if_true, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl,
      not_false_eq_true] <;> norm_num <;> field_simp <;> ring

end sphere

end HamiltonsCubic.B12FourSphere
