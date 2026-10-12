import HamiltonsCubic.Base.Bivectors

/-!
# L37, diagonality is decided by a single kernel

`δ_A(X) = AX + XA` for symmetric `A`, and `Φ_W(A) = [W, δ_A]`. `W` is diagonal
in *some* orthonormal frame iff some `A ∈ ker Φ_W` has pairwise-distinct sums
`aᵢ + aⱼ`; so `dim ker Φ_W < n` certifies non-diagonality with no frame search.

**Starting at the structural half.** The block's computational content is a
kernel dimension at a given `W`. Its structural content is stated in passing,
and that is what this file proves:

* `δ_A` preserves the skew matrices, which is what lets it act on `Λ²` at all;
* `δ_A` is linear in `A`, so `ker Φ_W` is a subspace and its dimension is what
  the corollary counts;
* **the distinctness is achievable at every `n`**, the witness
  `A = Σ 2ⁱ fᵢfᵢᵀ` has pairwise-distinct sums, so the criterion is never
  obstructed by genericity.

The last is the one the block flags, and it is a statement about `ℕ`.
-/

namespace HamiltonsCubic.Base

open Matrix

variable {n : ℕ}

/-- `δ_A(X) = AX + XA`. -/
def delta (A X : Matrix (Fin n) (Fin n) ℚ) : Matrix (Fin n) (Fin n) ℚ := A * X + X * A

/-- **`δ_A` preserves skewness** for symmetric `A`, which is what lets it act on
`Λ²` at all. -/
theorem delta_isSkew {A X : Matrix (Fin n) (Fin n) ℚ}
    (hA : A.IsSymm) (hX : IsSkew X) : IsSkew (delta A X) := by
  unfold IsSkew delta at *
  rw [Matrix.transpose_add, Matrix.transpose_mul, Matrix.transpose_mul, hX, hA.eq]
  simp [Matrix.mul_neg, Matrix.neg_mul]

/-- `δ` is additive in `A`, so `Φ_W` is too and `ker Φ_W` is a subspace, which
is what makes its dimension the thing the corollary counts. -/
theorem delta_add_left (A B X : Matrix (Fin n) (Fin n) ℚ) :
    delta (A + B) X = delta A X + delta B X := by
  unfold delta
  rw [Matrix.add_mul, Matrix.mul_add]
  abel

theorem delta_smul_left (c : ℚ) (A X : Matrix (Fin n) (Fin n) ℚ) :
    delta (c • A) X = c • delta A X := by
  unfold delta
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_add]

/-- **The distinctness is achievable at every `n`.** The sums `2ⁱ + 2ʲ` over
`i < j` are pairwise distinct: `2ʲ ≤ 2ⁱ + 2ʲ < 2ʲ⁺¹` pins `j`, and cancelling
pins `i`. So the block's witness `A = Σ 2ⁱ fᵢfᵢᵀ` works at every dimension and
the criterion is never obstructed by genericity. -/
theorem two_pow_add_inj {i j k l : ℕ} (hij : i < j) (hkl : k < l)
    (h : 2 ^ i + 2 ^ j = 2 ^ k + 2 ^ l) : i = k ∧ j = l := by
  have hjl : j = l := by
    by_contra hne
    rcases Nat.lt_or_ge j l with hlt | hge
    · have h1 : 2 ^ i + 2 ^ j < 2 ^ (j + 1) := by
        have : (2:ℕ) ^ i < 2 ^ j := Nat.pow_lt_pow_right (by norm_num) hij
        have : (2:ℕ) ^ (j + 1) = 2 ^ j + 2 ^ j := by ring
        omega
      have h2 : (2:ℕ) ^ (j + 1) ≤ 2 ^ l := Nat.pow_le_pow_right (by norm_num) hlt
      have h3 : (2:ℕ) ^ l ≤ 2 ^ k + 2 ^ l := Nat.le_add_left _ _
      omega
    · have hlj : l < j := lt_of_le_of_ne hge (Ne.symm hne)
      have h1 : 2 ^ k + 2 ^ l < 2 ^ (l + 1) := by
        have : (2:ℕ) ^ k < 2 ^ l := Nat.pow_lt_pow_right (by norm_num) hkl
        have : (2:ℕ) ^ (l + 1) = 2 ^ l + 2 ^ l := by ring
        omega
      have h2 : (2:ℕ) ^ (l + 1) ≤ 2 ^ j := Nat.pow_le_pow_right (by norm_num) hlj
      have h3 : (2:ℕ) ^ j ≤ 2 ^ i + 2 ^ j := Nat.le_add_left _ _
      omega
  subst hjl
  refine ⟨?_, rfl⟩
  have : (2:ℕ) ^ i = 2 ^ k := by omega
  exact Nat.pow_right_injective (le_refl 2) this

end HamiltonsCubic.Base
