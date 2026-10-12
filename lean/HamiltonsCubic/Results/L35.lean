import HamiltonsCubic.Results.L70

/-!
# L35, two structural steps of the chain

L35 caps `θ` at `√(3/2)` on the at-most-two-negative stratum. Its chain runs
through an LP relaxation and closes by interval arithmetic. Two of its steps are
structural and are proved here.

**The scope claim, which the block states in passing.** *"The chain never uses
the first Bianchi identity, so what it proves is stronger than a statement about
`𝒲ₘ`, it holds for any trace-free symmetric operator on `Λ²` with the stated
sign pattern."* That is a statement about the chain rather than a proposition,
so it is recorded here and not formalised; what it means concretely is that
every lemma below needs only trace-freeness.
-/

namespace HamiltonsCubic.L35

open HamiltonsCubic.L70

/-- **Zero negative eigenvalues is impossible**, which is where the block says
the stratum's content begins. It follows from trace-freeness alone at any
nonzero operator, no Weyl hypothesis, as the scope claim says. -/
theorem exists_negative_eigenvalue {ι : Type*} (s : Finset ι) (f : ι → ℝ)
    (hsum : ∑ b ∈ s, f b = 0) (a : ι) (ha : a ∈ s) (hfa : f a ≠ 0) :
    ∃ b ∈ s, f b < 0 :=
  (exists_neg_of_sum_zero s f hsum a ha hfa).1

/-- **Dropping constraints only enlarges a maximum**, the step that takes the
LP to the pair-capped packing `G`, and the reason the bound survives the row
marginal being dropped. -/
theorem relax_le {S T : Set ℝ} (hST : S ⊆ T) (hS : S.Nonempty)
    (hT : BddAbove T) : sSup S ≤ sSup T :=
  csSup_le_csSup hT hS hST

/-- The bound's equality case, in the form the block anchors on: at
`(2,-1,-1)/√6` the two contributions are `1/√6` and `2/√6`, summing to
`√(3/2)`. -/
theorem anchor_sum : (1 : ℝ) / Real.sqrt 6 + 2 / Real.sqrt 6 = Real.sqrt (3 / 2) := by
  have h6 : (0:ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hsq : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have key : (3 / Real.sqrt 6) ^ 2 = 3 / 2 := by
    rw [div_pow, hsq]; norm_num
  have h6' : Real.sqrt 6 ≠ 0 := ne_of_gt h6
  have hsum : (1 : ℝ) / Real.sqrt 6 + 2 / Real.sqrt 6 = 3 / Real.sqrt 6 := by
    field_simp
    ring
  rw [hsum, ← key, Real.sqrt_sq (by positivity)]

end HamiltonsCubic.L35
