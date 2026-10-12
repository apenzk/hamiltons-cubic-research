import Mathlib

set_option linter.style.longLine false

/-!
# L71, saturation forces the balanced sphere product, STATED

[bounds.md](../../../findings/bounds.md)'s and [results.md](../../../results.md)'s Lemma L71,
quoted verbatim:

> Let `W` be a critical point of `𝒲ₙ` **at unit norm**, `n ≥ 5`, with `λ_min < 0 < λ_max`, at
> which Lemma L70 holds with equality, the scalar condition `θ = λ_min + (n-2)λ_max`. Write
> `𝔪 = E_min`, `𝔥 = E_max` and `𝔯` for the remaining eigenspaces, kernel included. The equality
> case reads `[𝔪,𝔪] ⊆ 𝔥`, `[𝔪,𝔥] ⊆ 𝔪`, `[𝔪,𝔯] = 0`; then `𝔤' = 𝔪 + [𝔪,𝔪]` is a subalgebra
> normalised by `𝔥` and centralised by `𝔯`, hence an ideal of the simple `𝔰𝔬(n)`, hence all of it.
> So `𝔯 = 0`, `𝔥 = [𝔪,𝔪]`, `(𝔰𝔬(n),𝔥)` is a symmetric pair, `W` has exactly two eigenvalues, and
> with `dim 𝔥 = n(n-2)/4` the pair is `𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2)` by Cartan's classification,
> `dim(𝔰𝔬(n/2+t) ⊕ 𝔰𝔬(n/2-t)) = n²/4 + t² - n/2` forces `t = 0`, `𝔲(n/2)` has the wrong dimension,
> and at `n = 8` the balanced involution is fixed by triality. Hence `W` is the Weyl tensor of
> `S^{n/2} × S^{n/2}`, `θ = θ₀(n)`, and **no critical point saturates at odd `n ≥ 5`**, since
> `dim 𝔪 = n²/4` is not an integer.

with the audit's finding that one bracket relation of the symmetric-pair conclusion was never
derived:

> `[𝔥,𝔥] ⊆ 𝔥` is needed for the symmetric-pair conclusion and was never derived; it now follows
> from `𝔥 = [𝔪,𝔪]` and the normalisation above.

## What IS typed here

**The Lie-theoretic half, in full.** `L71` below takes the three bracket relations, which is
exactly what L70's equality case reads, and concludes `𝔯 = 0`, `𝔥 = [𝔪,𝔪]` and the missing
`[𝔥,𝔥] ⊆ 𝔥`, over `𝔰𝔬(n)` at `n ≥ 5`. **It is proved in [L71Proof.lean](L71Proof.lean).**

**Both closed-form clauses, proved.** `balanced_forced` is the dimension count that forces the
split to be balanced at every even `n` at once, and `odd_no_saturation` is the parity clause:
`n²/4` is not an integer at odd `n`, so the conclusion's `dim 𝔪` cannot exist there.

## How `L71` is proved

The ideal argument: `𝔤' = 𝔪 + [𝔪,𝔪]` is normalised by `𝔪` and `𝔥` and centralised by `𝔯`, hence an ideal,
hence all of `𝔰𝔬(n)`. **Simplicity of `𝔰𝔬(n)` at `n ≥ 5` is proved, not assumed**, in
[SoSimple.lean](SoSimple.lean). The statement assumes only that `𝔪, 𝔥, 𝔯` span, not that they are
orthogonal, so `𝔥 = [𝔪,𝔪]` takes a second ideal, `𝔪 ∩ [𝔪,𝔪]`.

## What is NOT typed here

**Everything about `W`.** `𝒲ₙ`, criticality, `θ`, `λ_min`, `λ_max`, the eigenspaces `E_min` and
`E_max`, and Lemma L70's equality case are absent, so the passage *from* saturation *to* the three
bracket relations is not typed, the relations are hypotheses of `L71` rather than consequences of
a spectral condition. **A reader must check that passage in [L70](../../../findings/bounds.md).**

**The last clause, which the record itself records as owed.** *"What is asserted without argument
is the last clause, that `W` is the sphere product's Weyl tensor."* That identification, and
`θ = θ₀(n)` with it, is [L169](../../../findings/bounds.md)'s and is not stated here.

**`dim 𝔥 = n(n-2)/4`.** The record derives it from tracelessness *after* `𝔯 = 0`; this file takes
it as the input to `balanced_forced` rather than deriving it.

**The Cartan step and the `n = 8` case.** `𝔥 ≅ 𝔰𝔬(p) ⊕ 𝔰𝔬(q)` up to `SO(n)`-conjugacy needs
Cartan's classification and `Aut(𝔰𝔬(n)) = Ad(O(n))` at `n ≠ 8`; `balanced_forced` is only the
dimension arithmetic that runs *after* the classification has produced a `(p,q)`.
-/

namespace HamiltonsCubic.L71Statement

open Matrix

variable {n : ℕ}

/-- The bracket on `𝔰𝔬(n)`. -/
def br (X Y : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := X * Y - Y * X

/-- Membership in `𝔰𝔬(n)`. -/
def Skew (X : Matrix (Fin n) (Fin n) ℝ) : Prop := Xᵀ = -X

/-- `[𝔪,𝔪]`, the span of the brackets of `𝔪` with itself. -/
def brackets (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) :
    Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) :=
  Submodule.span ℝ {A | ∃ u ∈ m, ∃ v ∈ m, A = br u v}

/-! ## The dimension count, proved

`dim 𝔰𝔬(p) = C(p,2)`, so writing `p = n/2 + t` and `q = n/2 - t` the isotropy dimension is
`n²/4 + t² - n/2`. It is stated over `ℝ` so that `t` ranges over the half-integers the record's
substitution allows at odd splits, and so no `ℕ`-truncation enters. -/

/-- **`dim(𝔰𝔬(n/2+t) ⊕ 𝔰𝔬(n/2-t)) = n²/4 + t² - n/2`**, the record's closed form. -/
theorem pair_dim (n t : ℝ) :
    ((n / 2 + t) * ((n / 2 + t) - 1) + (n / 2 - t) * ((n / 2 - t) - 1)) / 2
      = n ^ 2 / 4 + t ^ 2 - n / 2 := by
  ring

/-- **So the target `dim 𝔥 = n(n-2)/4` forces `t = 0` at every `n` at once**, no case list, which
is the audit's correction of the block's `n = 6…16` enumeration. -/
theorem balanced_forced (n t : ℝ)
    (h : ((n / 2 + t) * ((n / 2 + t) - 1) + (n / 2 - t) * ((n / 2 - t) - 1)) / 2
      = n * (n - 2) / 4) : t = 0 := by
  rw [pair_dim] at h
  have : t ^ 2 = 0 := by nlinarith
  simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this

/-- **`𝔲(n/2)` has the wrong dimension**, `n²/4` against the required `n(n-2)/4`, and the two agree
at no `n > 0`. -/
theorem u_half_excluded (n : ℝ) (hn : 0 < n) : n ^ 2 / 4 ≠ n * (n - 2) / 4 := by
  intro h
  nlinarith

/-! ## The parity clause, proved -/

/-- **No critical point saturates at odd `n ≥ 5`.** The conclusion requires `dim 𝔪 = n²/4` to be
an integer, and at odd `n` it is not: `n²` is odd, so `4d = n²` has no solution. -/
theorem odd_no_saturation {n : ℕ} (hodd : Odd n) : ¬ ∃ d : ℕ, 4 * d = n ^ 2 := by
  rintro ⟨d, hd⟩
  obtain ⟨k, rfl⟩ := hodd
  have hexp : (2 * k + 1) ^ 2 = 4 * (k ^ 2 + k) + 1 := by ring
  rw [hexp] at hd
  omega

/-! ## The hypotheses are inhabited

`𝔪 = 0` satisfies all three bracket relations with any `𝔥` and `𝔯`, which is why `L71` carries
`𝔪 ≠ ⊥`: the conclusion `𝔯 = 0` is false for the trivial `𝔪`. -/

/-- The three bracket relations hold vacuously at `𝔪 = ⊥`, so `hm0` is doing real work. -/
theorem trivial_m_satisfies_relations (h r : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) :
    (∀ u ∈ (⊥ : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)), ∀ v ∈ (⊥ : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)), br u v ∈ h) ∧
      (∀ u ∈ (⊥ : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)), ∀ x ∈ h, br u x ∈ (⊥ : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ))) ∧
      (∀ u ∈ (⊥ : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)), ∀ z ∈ r, br u z = 0) := by
  refine ⟨?_, ?_, ?_⟩ <;> intro u hu <;>
    simp only [Submodule.mem_bot] at hu <;> subst hu <;> intro v hv <;>
    simp [br]

/-! ## The statement -/

/-! ## The statement

**`L71` is stated and proved in [L71Proof.lean](L71Proof.lean)**, in this namespace, because its proof
runs through [SoSimple.lean](SoSimple.lean). -/

end HamiltonsCubic.L71Statement
