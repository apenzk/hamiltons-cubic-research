import Mathlib

set_option linter.style.longLine false

/-!
# L159, the involutions of the compact `𝔰𝔬(n)`: the checkable half

[findings/graded-half.md](../../../findings/graded-half.md), Lemma L159: for `n ≥ 3`, `n ≠ 8`, every
involution of `𝔰𝔬(n)` is `Ad_g` with `g ∈ O(n)`, `g² = ±I`, conjugate to exactly one of `Ad_{g_p}`
(`0 ≤ p ≤ ⌊n/2⌋`) or, at even `n`, `Ad_J`.

**Proved here**, for matrices over `ℝ`:

- `Ad_involutive`, `Ad_skew`, `Ad_bracket`: `Ad_g X = g X gᵀ` with `gᵀg = 1` and `g² = ±1` preserves
  skewness and the bracket and squares to the identity, so it is an involutive automorphism of
  `𝔰𝔬(n)`, the direction of the classification that runs from `g` to `σ`;
- `dims_gp` and `dims_J`: the fixed algebra and the `−1` part have dimensions summing to
  `dim 𝔰𝔬(n)`, `p(p−1)/2 + (n−p)(n−p−1)/2 + p(n−p)` and `m² + m(m−1)` at `n = 2m`;
- `countO` and `countSO` are the record's class counts as definitions, `⌊n/2⌋ + 1` at odd `n`,
  `⌊n/2⌋ + 2` at even `n`, one more for `SO(n)` at `n ≡ 0 (4)`; `count_O_odd` reads the odd case
  off, and `count_SO_12` gives eight `O(12)`-classes against nine `SO(12)`-classes;
- `spin7_not_standard`: the `n = 8` falsifier's dimension facts. `21 ≠ 16 = dim 𝔲(4)`, and a
  `21`-dimensional algebra preserving a `k`-dimensional subspace of `ℝ⁸` lies in
  `𝔰𝔬(k) ⊕ 𝔰𝔬(8−k)`, whose dimension is below `21` at every `2 ≤ k ≤ 6` and equals it at
  `k ∈ {1, 7}`. So the count leaves only the vector stabiliser `𝔰𝔬(7)` acting as `7 + 1`, and
  `𝔰𝔭𝔦𝔫(7)` fixes no nonzero vector of its spin module (it is transitive on `S⁷`), which is the
  representation-theoretic step and is not typed. *A lighter form of that step: `X = 2L_uL_v`
  with `u ⊥ v` unit lies in `𝔰𝔭𝔦𝔫(7)` and has `X² = −4`, so it is invertible and fixes no vector.*

**Not typed, and out**: that every involution is some `Ad_g`, i.e. `Aut(𝔰𝔬(n)) = Ad(O(n))` for
`n ≠ 8`, and the conjugacy classification, which need automorphism theory of simple Lie algebras
that Mathlib does not carry.
-/

namespace HamiltonsCubic.L159

open Matrix

variable {n : ℕ}

/-- `Ad_g X = g X gᵀ`. -/
def Ad (g X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := g * X * gᵀ

theorem Ad_skew (g X : Matrix (Fin n) (Fin n) ℝ) (hX : Xᵀ = -X) : (Ad g X)ᵀ = -Ad g X := by
  unfold Ad
  rw [transpose_mul, transpose_mul, transpose_transpose, hX]
  simp [Matrix.mul_assoc]

theorem Ad_bracket (g X Y : Matrix (Fin n) (Fin n) ℝ) (hg : gᵀ * g = 1) :
    Ad g (X * Y - Y * X) = Ad g X * Ad g Y - Ad g Y * Ad g X := by
  unfold Ad
  have e : ∀ A B : Matrix (Fin n) (Fin n) ℝ, g * A * gᵀ * (g * B * gᵀ) = g * (A * B) * gᵀ := by
    intro A B
    calc g * A * gᵀ * (g * B * gᵀ) = g * A * (gᵀ * g) * B * gᵀ := by simp only [Matrix.mul_assoc]
      _ = g * (A * B) * gᵀ := by rw [hg]; simp only [Matrix.mul_one, Matrix.mul_assoc]
  rw [e, e, Matrix.mul_sub, Matrix.sub_mul]

/-- **`Ad_g` is an involution when `g² = ±1`.** -/
theorem Ad_involutive (g X : Matrix (Fin n) (Fin n) ℝ) (s : ℝ) (hs : s ^ 2 = 1)
    (hg2 : g * g = s • (1 : Matrix (Fin n) (Fin n) ℝ)) : Ad g (Ad g X) = X := by
  unfold Ad
  have hgt : gᵀ * gᵀ = s • (1 : Matrix (Fin n) (Fin n) ℝ) := by
    rw [← transpose_mul, hg2, transpose_smul, transpose_one]
  calc g * (g * X * gᵀ) * gᵀ = (g * g) * X * (gᵀ * gᵀ) := by simp only [Matrix.mul_assoc]
    _ = X := by rw [hg2, hgt, smul_mul_assoc, Matrix.one_mul, mul_smul_comm, Matrix.mul_one, smul_smul, ← sq, hs, one_smul]

/-- **The `g_p` family's dimensions sum to `dim 𝔰𝔬(n)`.** -/
theorem dims_gp (n p : ℚ) :
    p * (p - 1) / 2 + (n - p) * (n - p - 1) / 2 + p * (n - p) = n * (n - 1) / 2 := by ring

/-- **The `J` family's dimensions sum to `dim 𝔰𝔬(2m)`**: `dim 𝔲(m) = m²`, `dim Λ²_ℂ ℂᵐ = m(m−1)`. -/
theorem dims_J (m : ℚ) : m ^ 2 + m * (m - 1) = (2 * m) * (2 * m - 1) / 2 := by ring

/-- The `O(n)` count, `⌊n/2⌋ + 1` at odd `n` and `⌊n/2⌋ + 2` at even `n`. -/
def countO (n : ℕ) : ℕ := n / 2 + 1 + (if n % 2 = 0 then 1 else 0)

/-- The `SO(n)` count, one more at `n ≡ 0 (4)`, the `𝔲(n/2)` row splitting. -/
def countSO (n : ℕ) : ℕ := countO n + (if n % 4 = 0 then 1 else 0)

/-- **At `n = 12`: eight `O(12)`-classes against nine `SO(12)`-classes.** -/
theorem count_SO_12 : countO 12 = 8 ∧ countSO 12 = 9 := by decide

theorem count_O_odd (n : ℕ) (h : n % 2 = 1) : countO n = n / 2 + 1 := by
  unfold countO; rw [if_neg (by omega)]

/-- **The `n = 8` falsifier's count**: `dim 𝔰𝔭𝔦𝔫(7) = 21` differs from `dim 𝔲(4) = 16`, exceeds
`dim 𝔰𝔬(k) + dim 𝔰𝔬(8−k)` at every `2 ≤ k ≤ 6`, and equals it at `k ∈ {1, 7}`. -/
theorem spin7_not_standard :
    (21 : ℕ) ≠ 4 ^ 2 ∧
      (∀ k ∈ Finset.Icc 2 6, k * (k - 1) / 2 + (8 - k) * (8 - k - 1) / 2 < 21) ∧
      (∀ k ∈ ({1, 7} : Finset ℕ), k * (k - 1) / 2 + (8 - k) * (8 - k - 1) / 2 = 21) := by
  refine ⟨by norm_num, ?_, ?_⟩ <;> decide

end HamiltonsCubic.L159
