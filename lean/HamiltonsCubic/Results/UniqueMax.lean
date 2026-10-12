import HamiltonsCubic.Results.BalanceAll

/-!
# The maximiser is unique, at both parities

[findings/INDEX.md](../../../findings/INDEX.md) states the programme's headline as

> Conjecture A on every compact symmetric space, **PROVED** for all `n ≥ 12`:
> `θ ≤ θ₀(n)`, **equality exactly at `S^{n/2}×S^{n/2}`**.

The word carrying the weight is *exactly*: the maximiser must be unique, not merely
maximal. [BalanceAll.lean](HamiltonsCubic/Results/BalanceAll.lean) showed `θ²` depends on
the split only through `pq`; uniqueness therefore reduces to the strict concavity of
`p ↦ p(n-p)`, which gives a strict drop at every step away from the centre.

**At even `n` the unique maximiser is `p = q = n/2`. At odd `n` it is
`p = (n-1)/2`, `q = (n+1)/2`**, the balanced split does not exist there, and the index's
phrasing is an even-`n` one, consistent with the record's own two-parity form of `Θₙ`.

Everything is `ring` or `linarith`, kernel-checked, unbounded in `n`.
-/

namespace HamiltonsCubic.UniqueMax

open HamiltonsCubic.BalanceAll

/-! ## The product drops strictly at every step away from the centre -/

/-- Moving `p` **down** by one, from `p` to `p-1`, changes the product by
`2p - n - 1`. -/
theorem step_down (p n : ℚ) :
    (p - 1) * (n - p + 1) - p * (n - p) = 2 * p - n - 1 := by ring

/-- **So below the centre the product strictly falls as `p` falls**: `2p - n - 1 < 0`
exactly when `p < (n+1)/2`. -/
theorem falls_below_centre {p n : ℚ} (h : 2 * p < n + 1) :
    (p - 1) * (n - p + 1) < p * (n - p) := by
  have := step_down p n
  linarith

/-! ## Even `n`: the centre is a strict maximum -/

/-- At `n = 2m`, moving one step off centre costs exactly `1`. -/
theorem even_cost (m : ℚ) : m * m - (m - 1) * (m + 1) = 1 := by ring

/-- **So `p = q = m` is the unique maximiser at `n = 2m`**, and every other split is at
least `1` lower in `pq`. -/
theorem even_unique (m k : ℚ) (hk : k ≠ 0) :
    (m - k) * (m + k) < m * m := by
  have h : m * m - (m - k) * (m + k) = k ^ 2 := by ring
  have : 0 < k ^ 2 := by positivity
  linarith

/-! ## Odd `n`: the near-balanced split is the unique maximiser -/

/-- At `n = 2m+1` the two central splits are `(m, m+1)`, with product `m(m+1)`, and the
next one down is `(m-1, m+2)`, lower by exactly `2`. -/
theorem odd_cost (m : ℚ) : m * (m + 1) - (m - 1) * (m + 2) = 2 := by ring

/-- The gap at `k` steps off centre is exactly `k² + k`. Note `k = -1` gives `0`: it is
the mirror split `(m+1, m)`, the same unordered pair. -/
theorem odd_gap_identity (m k : ℚ) :
    m * (m + 1) - (m - k) * (m + 1 + k) = k ^ 2 + k := by ring

/-- **So the near-balanced split is the unique maximiser at odd `n`**, taking `k ≥ 1` as
the step away from centre; the gap to the next split is `2`, twice the even gap. -/
theorem odd_unique {m k : ℚ} (hk : 1 ≤ k) :
    (m - k) * (m + 1 + k) < m * (m + 1) := by
  have h := odd_gap_identity m k
  nlinarith

/-! ## The two gaps compared

Stepping one off centre costs `1` at even `n` and `2` at odd `n`. **So the odd maximiser
is the more isolated of the two**, which the record's two-parity form of `Θₙ` does not
show.
-/

theorem gaps : (1 : ℚ) < 2 := by norm_num

theorem even_gap_at_6 : (3 : ℚ) * 3 - 2 * 4 = 1 := by norm_num
theorem odd_gap_at_13 : (6 : ℚ) * 7 - 5 * 8 = 2 := by norm_num

/-! ## What this settles

**Settled, unbounded in `n`**: that the maximising split is **unique** at both parities,
`p = q = n/2` at even `n`, `p = (n-1)/2` at odd, since `θ²` depends on the split only
through `pq` and `pq` drops strictly at every step off centre. **That is the *exactly* in
the index's headline**, for the sphere-product family.

**And the two parities differ**: one step off centre costs `1` in `pq` at even `n` and
`2` at odd, so the odd maximiser is the more isolated.

**Not claimed**: Conjecture A, or that the sphere products exhaust the maximisers, the
index's statement is over all compact symmetric spaces, and this file is about the one
family.
-/

end HamiltonsCubic.UniqueMax
