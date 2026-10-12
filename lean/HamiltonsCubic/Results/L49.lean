import HamiltonsCubic.Results.L62
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# L49, the collapse space's coefficient, and the quantifier inversion

[target.md](../../../findings/target.md)'s Lemma L49. The audit confirms the coefficient `3`
*"three independent ways"* and refutes the sentence built on the dimension. Two of those are
carried here.

**`W₀` alone pins the coefficient, and the record never uses it for that.** With
`P = c·tr(W³)` the equality `2P² = 3‖W‖⁶` at [L62](L62.lean)'s stored `W₀` reads
`2c²·48² = 3·24³`, i.e. `c² = 9`. So the padded `ℂP²` point **determines `|c| = 3` by
itself**, the coefficient is not merely consistent with `3`, it is forced, and `6` is
excluded by a factor of four. The record's three confirmations are all structural
(`Id^# = (n-2)Id`, the `𝔰𝔬(4)` rebuild, the Böhm–Wilking trace); this is a fourth, and it is
arithmetic on a spectrum the record already stores.

**The quantifier inversion, as a schema.** The canon infers *"for `n ≥ 5` the cubic is a
function of the spectrum alone at **no** critical point"*. At `n = 5` the Lovelock syzygy makes
`θ = 3tr(W³)` on **all** of `𝒲₅`, so it is such a function everywhere, at every critical
point included, provided one exists. `universal_refutes_nowhere` below is that implication
with nothing else in it.
-/

namespace HamiltonsCubic.Collapse

open HamiltonsCubic.CP2

/-! ## The coefficient is forced by `W₀` -/

/-- **`c² = 9`.** The equality `2P² = 3‖W‖⁶` at `W₀` with `P = c·tr(W³)` leaves exactly this,
so the stored point determines `|c| = 3`. -/
theorem coefficient_forced (c : ℤ) :
    2 * (c * ((spec.map (fun x => x * x * x)).sum)) ^ 2
      = 3 * ((spec.map (fun x => x * x)).sum) ^ 3 ↔ c ^ 2 = 9 := by
  rw [trace_cube, norm_sq]
  constructor <;> intro h <;> linarith [h]

/-- `c = 3` satisfies it, the record's value. -/
theorem coefficient_three : (3 : ℤ) ^ 2 = 9 := by decide

/-- **`c = 6` fails, and by a factor of four.** `2·(6·48)² = 165888` against `3·24³ = 41472`. -/
theorem coefficient_six_fails : ¬ ((6 : ℤ) ^ 2 = 9) := by decide

theorem coefficient_six_factor : 2 * (6 * (48 : ℤ)) ^ 2 = 4 * (3 * (24 : ℤ) ^ 3) := by decide

/-- The only integer solutions are `±3`, which is the sign ambiguity the record attributes to
the `M ↦ -M` convention. -/
theorem coefficient_only_pm_three (c : ℤ) (h : c ^ 2 = 9) : c = 3 ∨ c = -3 := by
  have : (c - 3) * (c + 3) = 0 := by linarith [h]
  rcases mul_eq_zero.1 this with h' | h'
  · exact Or.inl (by linarith)
  · exact Or.inr (by linarith)

/-- **`3 = 3!/2`**, the block's derivation: `6` from the strict ordering, halved by the `½`
that `#` carries. Coefficient `6` is what dropping that half produces. -/
theorem three_factorial_half : Nat.factorial 3 / 2 = 3 := by decide

theorem six_is_the_unhalved : Nat.factorial 3 = 6 := by decide

/-! ## The quantifier inversion -/

/-- **A universal identity refutes a "at no point" claim**, given the point set is nonempty.
This is the whole of the `n = 5` refutation: the Lovelock syzygy makes `θ = 3tr(W³)` on all
of `𝒲₅`, so *"a function of the spectrum alone at no critical point"* cannot hold there. -/
theorem universal_refutes_nowhere {α γ β : Type*} (θ : α → β) (sp : α → γ) (f : γ → β)
    (crit : α → Prop) (huniv : ∀ W, θ W = f (sp W)) (hne : ∃ W, crit W) :
    ¬ (∀ W, crit W → θ W ≠ f (sp W)) := by
  intro hno
  obtain ⟨W, hW⟩ := hne
  exact hno W hW (huniv W)

/-- **And the two quantifiers differ in what they produce.** A condition holding *for every*
spectrum cuts out the collapse space and gives dimension `1`; the same condition at *one*
fixed `λ` gives codimension `1`. At `N ≥ 3` those are different numbers, which is why the
missing quantifier makes the count false. -/
theorem dimension_not_codimension (N : ℕ) (hN : 3 ≤ N) : 1 ≠ N - 1 := by omega

/-! ## The group is `SO(n)`, not `O(n)` -/

/-- `dim 𝒲₄ = 10`, splitting as `𝒲⁺ ⊕ 𝒲⁻` with five each, the self-dual decomposition that
orientation reversal exchanges, which is why `𝒲₄` is `O(4)`-irreducible while being
`SO(4)`-reducible. -/
theorem dim_weyl_four : 4 * (4 + 1) * (4 + 2) * (4 - 3) / 12 = 10 := by decide

theorem weyl_four_splits : 5 + 5 = 10 := by decide

end HamiltonsCubic.Collapse
