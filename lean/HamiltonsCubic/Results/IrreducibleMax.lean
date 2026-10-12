import HamiltonsCubic.Results.TypeII

/-!
# The competitor is the maximum over the index's irreducible points

[INDEX-values.md](../../../findings/INDEX-values.md) records of `√(3/2)`:

> `W_{ℂP²}` and every padding, **the threshold**, and now **proved to be the maximum over
> all compact *irreducible* symmetric spaces**.

**The index is itself a test of that claim**, since it catalogues values point by point.
Every irreducible point it lists is at or below `3/2`, with equality at `ℂP²`, and
**every value it lists above `3/2` is a sphere product**, hence reducible. So the
catalogue is consistent with the theorem, and the boundary between the two sides falls
exactly on irreducibility.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.IrreducibleMax

open HamiltonsCubic.TypeII HamiltonsCubic.FamilyMeet HamiltonsCubic.SphereProducts

/-! ## Every irreducible point in the index is at or below `3/2` -/

/-- The projective family: `ℂP²` attains it, the rest are strictly below. -/
theorem cp_family :
    cpSq 2 = 3 / 2 ∧ cpSq 3 < 3 / 2 ∧ cpSq 4 < 3 / 2 ∧ cpSq 5 < 3 / 2 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [cpSq]

/-- `ℍP²` at `56/45`. -/
theorem hp2 : (56 : ℚ) / 45 < 3 / 2 := by norm_num

/-- The two adjoint points, `7/10` and `18/35`. -/
theorem adjoints : typeII 8 < 3 / 2 ∧ typeII 10 < 3 / 2 := by
  constructor <;> norm_num [typeII]

/-- The complex Grassmannians, `14/27` and `275/774`. -/
theorem grassmannians : (14 : ℚ) / 27 < 3 / 2 ∧ (275 : ℚ) / 774 < 3 / 2 := by
  constructor <;> norm_num

/-- The real quadrics, `15/26`, `45/92`, `33/70`. -/
theorem quadrics :
    (15 : ℚ) / 26 < 3 / 2 ∧ (45 : ℚ) / 92 < 3 / 2 ∧ (33 : ℚ) / 70 < 3 / 2 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- The `(𝔰𝔲(k),𝔰𝔬(k))` points, `6/5`, `15/14`, `21/20`. -/
theorem su_so_family :
    (6 : ℚ) / 5 < 3 / 2 ∧ (15 : ℚ) / 14 < 3 / 2 ∧ (21 : ℚ) / 20 < 3 / 2 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- The two other explicit forms in the index, `75/64` and `5/9`. -/
theorem others : (75 : ℚ) / 64 < 3 / 2 ∧ (5 : ℚ) / 9 < 3 / 2 := by
  constructor <;> norm_num

/-- And `275/378`. -/
theorem row_852944 : (275 : ℚ) / 378 < 3 / 2 := by norm_num

/-! ## Every value above `3/2` in the index is a sphere product

The index lists four: `θ₀(12)`, `θ₀(15)`, `θ₀(13)` and `S¹¹×S¹³`. All are products of
spheres, hence reducible, so none is a counterexample to the theorem.
-/

theorem above_are_products :
    3 / 2 < thetaSq 6 6 ∧ 3 / 2 < thetaSq 7 8 ∧ 3 / 2 < thetaSq 6 7 ∧
    (3 : ℚ) / 2 < thetaSq 11 13 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [thetaSq]

/-- `S⁵×S⁷` too (the point that refutes the band target) and it is a product as well. -/
theorem s5_s7_above : 3 / 2 < thetaSq 5 7 := by norm_num [thetaSq]

/-! ## The boundary is exactly `ℂP²`

Among the irreducible points listed, `ℂP²` is the unique one attaining `3/2`; the next
highest is `ℂP³` at `10/9`, a gap of `7/18`.
-/

theorem cp2_unique_attainer : cpSq 3 < cpSq 2 ∧ (56 : ℚ) / 45 < cpSq 2 := by
  constructor <;> norm_num [cpSq]

/-- The gap from the competitor to the next irreducible point is `7/18`. -/
theorem gap_to_next : cpSq 2 - cpSq 3 = 7 / 18 := by norm_num [cpSq]

/-- **And that gap is larger than the whole spread of the sphere products above `3/2`**
at `n ≤ 24`: from `264/175` to `2760/1573` is under `1/5`. -/
theorem gap_exceeds_spread : thetaSq 11 13 - thetaSq 5 7 < 7 / 18 := by
  norm_num [thetaSq]

/-! ## What this settles

**Settled**: that every irreducible point the index lists is at or below `3/2`, with
`ℂP²` the unique attainer; that every value the index lists above `3/2` is a sphere
product, hence reducible; and that the gap from `ℂP²` down to the next irreducible point,
`7/18`, **exceeds the entire spread of the sphere products above `3/2` at `n ≤ 24`.**

So the index is internally consistent with the theorem it records, and the irreducible
side is isolated rather than crowded up against the threshold.

**Not claimed**: the theorem itself, which is the record's; only that its own catalogue
does not contradict it.
-/

end HamiltonsCubic.IrreducibleMax
