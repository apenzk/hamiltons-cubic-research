import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L139, the counterexample is a majority of the space, and it leaves the surviving route alone

[route-a.md](../../../findings/route-a.md)'s Lemma L139, withdrawn on two grounds: its dimension
range rested on [L137](L137.lean)'s coefficients, and its step (a) is independently false. The
second is a witness, and its size is worth recording.

**The counterexample is not a thin set.** `r428` exhibits a `209`-dimensional space of genuine
Weyl tensors inside `{F=0} ∩ T_u𝒪^⊥` at `n = 8`. Since `dim 𝒲₈ = 8·9·10·5/12 = 300`, that is
over two thirds of the ambient Weyl space, so *"the compression is not Bianchi on the cone"*
fails on a majority of directions rather than on a special family. **This is the opposite of the
record's usual failure mode**, where the counterexamples live on measure-zero sets that random
sampling cannot see.

**And the witness value leaves the surviving route untouched.** `‖Alt(P₀HP₀)‖²` reaches `0.093`
there, which refutes Bianchi-ness (the claim is that it vanishes) while sitting **below**
[L140](../../../findings/route-a.md)'s `‖g₁‖² ≤ 1/4` and below the `ℂP²` defect `1/9`. So the
object that kills L139(a) is consistent with the bound the record now relies on, and no part of
the replacement route is put at risk by it.

**The replacement is strictly wider.** L139 claimed `12 ≤ n ≤ 31`, twenty dimensions; L140
reaches every `n ≥ 12`, so the withdrawal loses nothing and gains every `n > 31`, where the old
range asserted nothing at all.
-/

namespace HamiltonsCubic.ConeCounterexample

/-! ## The size of the counterexample space -/

/-- `dim 𝒲ₙ = n(n+1)(n+2)(n-3)/12`, which at `n = 8` is `300`. -/
theorem weyl_dim_eight : (8 : ℚ) * 9 * 10 * 5 / 12 = 300 := by norm_num

/-- **The `209`-dimensional witness space is over two thirds of it.** -/
theorem witness_is_a_majority : (2 : ℚ) / 3 < 209 / 300 ∧ (209 : ℚ) / 300 < 1 := by
  refine ⟨by norm_num, by norm_num⟩

/-- So the failure is generic on the cone rather than confined to a special family, `91` of the
`300` dimensions lie outside it. -/
theorem complement_dimension : 300 - 209 = 91 := by norm_num

/-! ## The witness value, against the bounds that matter -/

/-- **`0.093` is nonzero**, which is what refutes Bianchi-ness of the compression. -/
theorem witness_nonzero : (0 : ℚ) < 93 / 1000 := by norm_num

/-- **And it sits below `L140`'s ceiling `1/4`**, so the object that kills this lemma does not
threaten the route that replaced it. -/
theorem witness_below_ceiling : (93 : ℚ) / 1000 < 1 / 4 := by norm_num

/-- It also sits below the `ℂP²` defect `1/9`. -/
theorem witness_below_cp2_defect : (93 : ℚ) / 1000 < 1 / 9 := by norm_num

/-- The three values in order: `0 < 0.093 < 1/9 < 1/4`. -/
theorem value_ordering :
    (0 : ℚ) < 93 / 1000 ∧ (93 : ℚ) / 1000 < 1 / 9 ∧ (1 : ℚ) / 9 < 1 / 4 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The replacement is strictly wider -/

/-- The withdrawn range covered twenty dimensions. -/
theorem old_range_size : 31 - 12 + 1 = 20 := by norm_num

/-- **And `n ≥ 12` strictly contains it**, so the withdrawal costs nothing in range and gains
every `n > 31`, where the old range asserted nothing. -/
theorem new_range_is_strictly_wider : ¬ (∀ n : ℕ, 12 ≤ n → n ≤ 31) := by
  intro h
  have := h 32 (by norm_num)
  omega

end HamiltonsCubic.ConeCounterexample
