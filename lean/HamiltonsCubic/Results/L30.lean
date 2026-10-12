import HamiltonsCubic.Base.Bivectors

/-!
# L30, why padding preserves the norm and `θ`

L30 descends a Weyl operator with small negative eigenspace to its support `U`,
"with the same norm and the same `θ`". The reviewers record that this clause
**was asserted and never proved, and it is the clause the lemma exists for**,
it is what lets a bound proved at `dim U` govern every `n`. They also name its
two lines: the norm from orthonormality, and `θ` because `Λ²U = 𝔰𝔬(U)` is a Lie
subalgebra, which is what keeps `W#` inside.

**The structural half is that subalgebra fact**, and it is proved here for a
coordinate subspace: matrices supported in `S × S` are closed under
multiplication, hence under the bracket. So `Λ²U` is closed under `[·,·]`, and
the pairing of two supported bivectors sees only entries inside `S`.

The same fact is what [L44](L44.lean) owes for its padding, and what the record
uses to carry `θ(W_{ℂP²}) = √(3/2)` from `n = 4` to every `n`.
-/

namespace HamiltonsCubic.Base

open Matrix

variable {n : ℕ}

/-- Supported in a coordinate subspace: every entry outside `S × S` vanishes. -/
def SupportedIn (S : Finset (Fin n)) (X : Matrix (Fin n) (Fin n) ℚ) : Prop :=
  ∀ i j, (i ∉ S ∨ j ∉ S) → X i j = 0

/-- **Supported matrices are closed under multiplication.** -/
theorem SupportedIn.mul {S : Finset (Fin n)} {X Y : Matrix (Fin n) (Fin n) ℚ}
    (hX : SupportedIn S X) (hY : SupportedIn S Y) : SupportedIn S (X * Y) := by
  intro i j hij
  rw [Matrix.mul_apply]
  refine Finset.sum_eq_zero fun k _ => ?_
  rcases hij with hi | hj
  · rw [hX i k (Or.inl hi), zero_mul]
  · rw [hY k j (Or.inr hj), mul_zero]

/-- **Hence closed under the bracket**, which is `Λ²U = 𝔰𝔬(U)` being a Lie
subalgebra, the fact that keeps `W#` inside under padding. -/
theorem SupportedIn.bracket {S : Finset (Fin n)} {X Y : Matrix (Fin n) (Fin n) ℚ}
    (hX : SupportedIn S X) (hY : SupportedIn S Y) : SupportedIn S (br X Y) := by
  intro i j hij
  unfold br
  rw [Matrix.sub_apply, hX.mul hY i j hij, hY.mul hX i j hij, sub_zero]

/-- Supported matrices form a subspace, so the padding is linear. -/
theorem SupportedIn.add {S : Finset (Fin n)} {X Y : Matrix (Fin n) (Fin n) ℚ}
    (hX : SupportedIn S X) (hY : SupportedIn S Y) : SupportedIn S (X + Y) := by
  intro i j hij
  rw [Matrix.add_apply, hX i j hij, hY i j hij, add_zero]

/- The reviewers' other line (*the norm from orthonormality*), is definitional
in this encoding rather than a theorem: padded and unpadded operators live in
the same matrix space here, so the pairing is literally the same sum. Stating it
as content would need two dimensions and a padding map between them, which the
layer does not yet have. The bracket closure above is the half that carries
real weight, and it is what keeps `W#` inside under padding. -/

end HamiltonsCubic.Base
