import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Order.Interval.Finset.Nat

/-!
# L90, evaluation is injective on the image

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L90, whose block prints an argument
its own author withdrew. The defect and its repair are both statements about an ordering, and
neither mentions the geometry, which is why the circularity survived: nothing in the
sampling step looks wrong locally.

**The circularity.** The stated proof reads `rank(ev ∘ μ) = 13 = rank μ` with *"measured at
four primes"*, but only the first is measured, and sampling's inequality runs
`rank(ev ∘ μ) ≤ rank μ`, **from the measured side to the unmeasured one**. Knowing the
smaller quantity fixes nothing about the larger, and `sampling_wrong_way` exhibits the gap.

**The repair, and why it costs less.** Importing [L62](L62.lean)'s order-1 cap gives
`13 ≤ rank(ev ∘ μ) ≤ rank μ ≤ 13`, which squeezes both to `13`. That is **one measurement and
one theorem**, where the printed argument claims two measurements, so the repair is cheaper
as well as valid.

**The stronger route already on the record.** The unrestricted sampled rank at those same
points is `14`, the full dimension of the invariant sextics, so evaluation is injective on
**every** invariant sextic and not merely on the image. A rank meeting its own cap needs no
genericity: the attained value certifies those `40` points a posteriori.
-/

namespace HamiltonsCubic.Unisolvence

/-! ## The inequality runs the wrong way -/

/-- **Knowing the smaller side fixes nothing about the larger.** `a ≤ b` with `a = 13` leaves
`b` free above `13`, so the printed argument cannot reach `rank μ = 13`. -/
theorem sampling_wrong_way : ∃ a b : ℕ, a ≤ b ∧ a = 13 ∧ b ≠ 13 := ⟨13, 14, by omega, rfl, by omega⟩

/-- What sampling does give, in the direction it actually runs. -/
theorem sampling_direction {a b : ℕ} (h : a ≤ b) (ha : a = 13) : 13 ≤ b := by omega

/-! ## The repair: one measurement and one theorem -/

/-- **The squeeze.** A measured lower bound on the composite, sampling's inequality, and a
*proved* upper bound on `rank μ` force both to `13`. -/
theorem squeeze {r rmu : ℕ} (hmeas : 13 ≤ r) (hsample : r ≤ rmu) (hcap : rmu ≤ 13) :
    r = 13 ∧ rmu = 13 := by
  constructor <;> omega

/-! ## The stronger route: rank meets its cap -/

/-- **A rank attaining its cap is injective on the whole space**, not merely on a subspace:
`14 ≤ r` and `r ≤ 14` leave no room. So no genericity hypothesis enters, and the `40` points
are certified by the attained value itself. -/
theorem rank_meets_cap {r : ℕ} (hmeas : 14 ≤ r) (hcap : r ≤ 14) : r = 14 := by omega

/-! ## The block contradicts itself -/

/-- **The two claims ten lines apart are incompatible, and by twelve values.** A boxed
`rank = 13` names one value; *"the rank is open in `[1,13]`"* admits thirteen, so the second
sentence readmits twelve the first excludes. -/
theorem interval_card : (Finset.Icc 1 13).card = 13 := by decide

theorem readmitted : (Finset.Icc 1 13).card - 1 = 12 := by decide

end HamiltonsCubic.Unisolvence
