import HamiltonsCubic.Results.CrossingAll

/-!
# The maximum is increasing at every dimension

[MaxCrossing.lean](HamiltonsCubic/Results/MaxCrossing.lean) decided that the
sphere-product maximum rises with `n` to `24`. With both closed forms in hand
([CrossingAll.lean](HamiltonsCubic/Results/CrossingAll.lean)) the bound comes off, and
the proof is two inequalities that each collapse to a constant.

Writing `E(m) = (2m-1)(m-1)/m²` for the even maximum at `n = 2m` and
`O(m) = 4m(m-1)/((m+1)(2m-1))` for the odd one at `n = 2m+1`:

* **`E(m) < O(m)`** cross-multiplies to `(2m-1)²(m+1) < 4m³`, which is `4m³ - 3m + 1 < 4m³`
 , that is `1 < 3m`;
* **`O(m) < E(m+1)`** cross-multiplies to `4(m²-1) < 4m² - 1`, that is `-4 < -1`.

**Both are constants after cancellation**, so the interleaving holds at every `m ≥ 2` with
nothing to check dimension by dimension.
-/

namespace HamiltonsCubic.MaxMonotone

/-- The even maximum at `n = 2m`. -/
def E (m : ℚ) : ℚ := (2 * m - 1) * (m - 1) / m ^ 2

/-- The odd maximum at `n = 2m+1`. -/
def O (m : ℚ) : ℚ := 4 * m * (m - 1) / ((m + 1) * (2 * m - 1))

/-! ## `E(m) < O(m)` -/

/-- The cross-multiplied difference is `3m - 1`, after the common factor `(m-1)`. -/
theorem even_odd_identity (m : ℚ) :
    4 * m ^ 3 - (2 * m - 1) ^ 2 * (m + 1) = 3 * m - 1 := by ring

/-- **So the odd maximum at `n = 2m+1` exceeds the even one at `n = 2m`**, at every
`m ≥ 2`. -/
theorem even_lt_odd {m : ℚ} (hm : 2 ≤ m) :
    (2 * m - 1) ^ 2 * (m + 1) < 4 * m ^ 3 := by
  nlinarith

/-! ## `O(m) < E(m+1)` -/

/-- The cross-multiplied difference is the constant `3`. -/
theorem odd_even_identity (m : ℚ) :
    (2 * m + 1) * (2 * m - 1) - 4 * (m ^ 2 - 1) = 3 := by ring

/-- **So the even maximum at `n = 2m+2` exceeds the odd one at `n = 2m+1`**, at every
`m`, the inequality does not depend on `m` at all. -/
theorem odd_lt_even (m : ℚ) : 4 * (m ^ 2 - 1) < (2 * m + 1) * (2 * m - 1) := by
  nlinarith [odd_even_identity m]

/-! ## The interleaving, and what it gives

`E(2) < O(2) < E(3) < O(3) < …`, so the maximum rises at every step of `n`, with no
dimension bound. Two of the record's numbers sit in that chain: `E(6) = 55/36` at
`n = 12` and `O(6) = 120/77` at `n = 13`.
-/

theorem E_6 : E 6 = 55 / 36 := by norm_num [E]
theorem O_6 : O 6 = 120 / 77 := by norm_num [O]
theorem E_7 : E 7 = 78 / 49 := by norm_num [E]

/-- The three in order, `n = 12`, `13`, `14`. -/
theorem chain_12_13_14 : E 6 < O 6 ∧ O 6 < E 7 := by
  constructor <;> norm_num [E, O]

/-- And `O(5) = 40/27` at `n = 11` sits below `E(6)`, which is the crossing pair. -/
theorem O_5 : O 5 = 40 / 27 := by norm_num [O]

theorem chain_11_12 : O 5 < E 6 := by norm_num [E, O]

/-! ## What this settles

**Settled, unbounded in `n`**: that the sphere-product maximum is strictly increasing at
every step, even to odd and odd to even, by two inequalities that reduce to `1 < 3m` and
`-4 < -1` after cancellation. **The `n ≤ 24` of the enumerated round comes off**, and with
it the last dimension bound on this chain of results.

*The second inequality does not depend on `m`*, the even maximum overtakes the preceding
odd one by a constant margin in the cross-multiplied form, which is why no dimension is
special.

**Not claimed**: that these two forms are the maxima, which is
[BalanceMax.lean](HamiltonsCubic/Results/BalanceMax.lean)'s and decided to `n = 24`.
-/

end HamiltonsCubic.MaxMonotone
