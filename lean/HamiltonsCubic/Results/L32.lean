import HamiltonsCubic.Results.L81Proof

set_option linter.style.longLine false

/-!
# L32, a bivector's centraliser collapses to a line

[findings/isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L32: for `m ≠ 3` and nonzero
`x ∈ 𝔰𝔬(m)`, `𝔷(𝔠) ∩ 𝔠^⊥ = ℝx` with `𝔠 = 𝔷(x) ∩ x^⊥`, except when `x` is a multiple of a complex
structure on a `4`-plane, where it is `3`-dimensional.

- `L32`: **`zPerp x = span {x}`** off the exception, from [L81Proof.lean](L81Proof.lean)'s `L81`
  (the dimension is `1` there) and `x ∈ zPerp x`;
- `L32_exception`: **dimension `3`** at the exception.
-/

open Module HamiltonsCubic.SkewNormalForm HamiltonsCubic.SkewCentraliser

namespace HamiltonsCubic.L81Statement

variable {m : ℕ}

/-- **L32**: off the rank-four complex structures, `𝔷(𝔠) ∩ 𝔠^⊥ = ℝx`. -/
theorem L32 (hm : m ≠ 3) (x : Matrix (Fin m) (Fin m) ℝ) (hxskew : Skew x) (hx0 : x ≠ 0)
    (hexc : ¬ MultipleOfRankFour x) : zPerp x = Submodule.span ℝ {x} := by
  obtain ⟨hiff, hdim⟩ := L81 hm x hxskew hx0
  have h1 : finrank ℝ (zPerp x) = 1 := by
    rcases hdim with h | h
    · exact h
    · exact absurd (hiff.mp (by omega)) hexc
  have hle : Submodule.span ℝ {x} ≤ zPerp x :=
    (Submodule.span_le).mpr (Set.singleton_subset_iff.mpr (x_mem_zPerp hxskew))
  have hs : finrank ℝ (Submodule.span ℝ {x}) = 1 := finrank_span_singleton hx0
  exact (Submodule.eq_of_le_of_finrank_eq hle (by rw [hs, h1])).symm

/-- **At the exception the dimension is `3`.** -/
theorem L32_exception (hm : m ≠ 3) (x : Matrix (Fin m) (Fin m) ℝ) (hxskew : Skew x) (hx0 : x ≠ 0)
    (hexc : MultipleOfRankFour x) : finrank ℝ (zPerp x) = 3 := by
  obtain ⟨hiff, hdim⟩ := L81 hm x hxskew hx0
  rcases hdim with h | h
  · have := hiff.mpr hexc; omega
  · exact h

end HamiltonsCubic.L81Statement
