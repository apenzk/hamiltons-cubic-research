import Mathlib

set_option linter.style.longLine false

/-!
# I73 sub-step (c): the diagonal identity behind the projected pair quotient's Ricci constant

**At a diagonal traceless `k`, the curvature operator `K = k ∧○ g` is diagonal on `Λ²` with
entries `k i + k j`, and `Q(K) = K² + K#` has entries `(n-2) k i k j - k i² - k j² + ∑ k m²`.**
*With the classical diagonal `R#` formula `(R#)_{ij} = ∑_{m ≠ i,j} r_{im} r_{jm}`, this is the
statement `Q(k ∧○ g) = ½(n-2) k ∧○ k - k² ∧○ g + ½|k|² g ∧○ g`, whose Weyl part fixes the constant
`1/(2(n-2))` in the projected pair quotient of
[the working note](../../../reviews/2026-09-23-I73c-projected-pair.md).*

**What is NOT typed here**: the split identity itself and its `Λ⁴` constant, which need an
orthogonal projection onto `Weyl_n` and the preservation `Q(Weyl_n) ⊆ Weyl_n`. A grep of the layer
for `weylProj`, `orthogonalProjection` over `IsWeyl`, and any theorem concluding `IsWeyl (Qop _)`
returns nothing.
-/

namespace HamiltonsCubic.Results

open Finset

/-- **The diagonal entry of `Q(k ∧○ g)` at a traceless diagonal `k`.** -/
theorem diag_Q_kg {n : ℕ} (k : Fin n → ℝ) (hk : ∑ m, k m = 0) {i j : Fin n} (hij : i ≠ j) :
    (k i + k j) ^ 2 + ∑ m ∈ (univ.erase i).erase j, (k i + k m) * (k j + k m)
      = ((n : ℝ) - 2) * k i * k j - k i ^ 2 - k j ^ 2 + ∑ m, k m ^ 2 := by
  have hj : j ∈ univ.erase i := mem_erase.2 ⟨hij.symm, mem_univ _⟩
  have hsplit : ∀ f : Fin n → ℝ, ∑ m, f m = f i + f j + ∑ m ∈ (univ.erase i).erase j, f m := by
    intro f
    rw [← add_sum_erase _ _ (mem_univ i), ← add_sum_erase _ _ hj]
    ring
  have hS := hsplit k
  have hQ := hsplit (fun m => k m ^ 2)
  have hC := hsplit (fun _ => (1 : ℝ))
  simp only [sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul, mul_one] at hC
  have hE : ∑ m ∈ (univ.erase i).erase j, (k i + k m) * (k j + k m)
      = k i * k j * ∑ m ∈ (univ.erase i).erase j, (1 : ℝ)
        + (k i + k j) * ∑ m ∈ (univ.erase i).erase j, k m
        + ∑ m ∈ (univ.erase i).erase j, k m ^ 2 := by
    rw [mul_sum, mul_sum, ← sum_add_distrib, ← sum_add_distrib]
    exact sum_congr rfl fun m _ => by ring
  rw [hE]
  have h1 : ∑ m ∈ (univ.erase i).erase j, (1 : ℝ) = (n : ℝ) - 2 := by
    rw [sum_const, nsmul_eq_mul, mul_one]; linarith
  have h2 : ∑ m ∈ (univ.erase i).erase j, k m = -(k i + k j) := by linarith
  have h3 : ∑ m ∈ (univ.erase i).erase j, k m ^ 2 = ∑ m, k m ^ 2 - k i ^ 2 - k j ^ 2 := by
    linarith
  rw [h1, h2, h3]
  ring

end HamiltonsCubic.Results
