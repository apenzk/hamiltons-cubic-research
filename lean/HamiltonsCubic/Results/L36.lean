import HamiltonsCubic.Base.Bivectors

/-!
# L36, the isotropy cap, at both parities

`S = 0` caps the negative eigenspace at `⌊n²/4⌋`, with equality at the mixed
planes `ℝᵖ ⊗ ℝᵠ`, `p = ⌈n/2⌉`, a continuous analogue of Mantel's theorem.

**The structural half.** The Lie-algebra proof of the cap is the block's
foreground. Stated in passing are the two arithmetic facts that make the
statement *sharp at both parities*, and the witness that killed the first
version of the maximiser:

* `⌈n/2⌉ · ⌊n/2⌋ = ⌊n²/4⌋` at every `n`, which is why one family attains the cap
  at both parities rather than needing two;
* `𝔰𝔬(p) ⊕ 𝔰𝔬(q)` has dimension `n(n-2)/4` and **falls short by exactly `n/2`**
  at even `n`, so the refuted maximiser missed by a margin that grows;
* and it is **not admissible at all**, an isotropic subalgebra being abelian
  while `⟨[φ₀₁, φ₁₂], φ₀₂⟩ ≠ 0` already inside one `𝔰𝔬(3)`.

The cap itself is owed.
-/

namespace HamiltonsCubic.L36

/-- **Sharpness at both parities is one identity.** The mixed planes have
dimension `⌈n/2⌉ · ⌊n/2⌋`, and that is `⌊n²/4⌋` at every `n`, `n²/4` at even `n`
and `(n²-1)/4` at odd, exactly as the block records. -/
theorem ceil_mul_floor (n : ℕ) : ((n + 1) / 2) * (n / 2) = n ^ 2 / 4 := by
  rcases Nat.even_or_odd n with ⟨m, hm⟩ | ⟨m, hm⟩
  · subst hm
    have h1 : (m + m + 1) / 2 = m := by omega
    have h2 : (m + m) / 2 = m := by omega
    have h3 : (m + m) ^ 2 = 4 * m ^ 2 := by ring
    rw [h1, h2, h3, Nat.mul_div_cancel_left _ (by norm_num)]
    ring
  · subst hm
    have h1 : (2 * m + 1 + 1) / 2 = m + 1 := by omega
    have h2 : (2 * m + 1) / 2 = m := by omega
    have h3 : (2 * m + 1) ^ 2 = 4 * (m ^ 2 + m) + 1 := by ring
    rw [h1, h2, h3, Nat.mul_add_div (by norm_num)]
    simp
    ring

/-- **The refuted maximiser falls short by exactly `n/2`.** At `n = 2m` the cap
is `m²`, while `dim(𝔰𝔬(m) ⊕ 𝔰𝔬(m)) = m(m-1)`. Written with `m = k+1` so no
truncated subtraction enters: the shortfall `k+1` is `m`, which is `n/2`. -/
theorem so_sum_falls_short (k : ℕ) : (k + 1) * k + (k + 1) = (k + 1) ^ 2 := by ring

end HamiltonsCubic.L36

namespace HamiltonsCubic.Base

/-- **And the refuted maximiser is not admissible.** An isotropic subalgebra is
abelian, but the Cartan form does not vanish on one `𝔰𝔬(3)`: `⟨[φ₀₁, φ₁₂], φ₀₂⟩`
is nonzero. -/
theorem so_three_not_isotropic :
    inner2 (br (phi (0 : Fin 4) 1) (phi 1 2)) (phi 0 2) ≠ 0 := by
  simp only [inner2, br, phi, Matrix.mul_apply, Matrix.trace, Matrix.diag_apply,
    Fin.sum_univ_four, Matrix.single_apply, Matrix.sub_apply, Matrix.transpose_apply,
    Matrix.of_apply, Matrix.smul_apply, Fin.ext_iff, Fin.isValue]
  norm_num [Fin.ext_iff]

end HamiltonsCubic.Base
