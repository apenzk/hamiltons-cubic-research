import Mathlib

set_option linter.style.longLine false

/-!
# L120's block totals, as a polynomial identity

[second-order.md](../../../findings/second-order.md)'s Lemma L120 splits `𝒲ₙ` over the sign characters as
`𝒟ₙ ⊕ ⨁_{i,j,k,l} V_{ijkl} ⊕ ⨁_{j,k} V_{jk}` with dimensions `n(n-3)/2`, `2` and `n-3`. **Their total is the
polynomial `n(n+1)(n+2)(n-3)/12`**, the record's `dim 𝒲ₙ`, as dimensions for `n ≥ 3`. The record calls this
transcription insurance and nothing more: it holds equally where the isotypic claim fails, so it certifies
no decomposition, and no Lean object here carries `dim 𝒲ₙ`.

* `choose_four_cast`, `choose_two_cast`: `C(n,4)` and `C(n,2)` as polynomials in `n` over `ℚ`, at every `n`;
* **`L120_dim_sum`**: `n(n-3)/2 + 2 C(n,4) + (n-3) C(n,2) = n(n+1)(n+2)(n-3)/12`.

That each isotypic subspace is the named summand with that dimension, rather than only that the numbers are
consistent, stays owed.
-/

namespace HamiltonsCubic.SignCharacters

theorem choose_four_cast (n : ℕ) : ((n.choose 4 : ℕ) : ℚ) = n * (n - 1) * (n - 2) * (n - 3) / 24 := by
  rcases Nat.lt_or_ge n 4 with h | h
  · interval_cases n <;> simp [Nat.choose]
  · obtain ⟨m, rfl⟩ : ∃ m, n = m + 4 := ⟨n - 4, by omega⟩
    have hd := Nat.descFactorial_eq_factorial_mul_choose (m + 4) 4
    have h2 : (((m + 4).descFactorial 4 : ℕ) : ℚ) = (m + 4) * (m + 3) * (m + 2) * (m + 1) := by
      simp [Nat.descFactorial_succ]; ring
    rw [hd, Nat.cast_mul] at h2
    norm_num [Nat.factorial] at h2
    push_cast
    linarith

theorem choose_two_cast (n : ℕ) : ((n.choose 2 : ℕ) : ℚ) = n * (n - 1) / 2 := by
  rw [Nat.cast_choose_two]

/-- **L120's block totals**: the summand dimensions sum to the polynomial `n(n+1)(n+2)(n-3)/12`. -/
theorem L120_dim_sum (n : ℕ) :
    (n : ℚ) * (n - 3) / 2 + 2 * (n.choose 4 : ℚ) + ((n : ℚ) - 3) * (n.choose 2 : ℚ)
      = n * (n + 1) * (n + 2) * (n - 3) / 12 := by
  rw [choose_four_cast, choose_two_cast]; ring

end HamiltonsCubic.SignCharacters
