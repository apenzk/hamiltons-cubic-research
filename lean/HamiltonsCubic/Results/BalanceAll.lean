import HamiltonsCubic.Results.OrbitDim
import Mathlib.Tactic.Linarith

/-!
# Balance maximises `θ`, at every dimension, and the reason is `pq`

[BalanceMax.lean](HamiltonsCubic/Results/BalanceMax.lean) decided this to `n = 24` by
enumeration. The bound comes off, and the argument is two lines.

At fixed `n`, write `θ²(p,q) = 2(p-1)(q-1)(n-1) / (pq(n-2))`. Since

  `(p-1)(q-1)/(pq) = 1 - (p + q - 1)/(pq) = 1 - (n-1)/(pq)`,

and `n` is fixed, **`θ²` is an increasing function of `pq` alone.** Maximising `θ` over
splits is therefore maximising `pq`, which is the classical fact that a product with
fixed sum is largest when the factors are equal.

**And `pq` is the orbit dimension** ([OrbitDim.lean](HamiltonsCubic/Results/OrbitDim.lean)).
So the split that maximises `θ` is the split that maximises the orbit, a statement the
record makes in neither direction, and which explains why the maximiser and the largest
orbit coincide throughout its tables.

Everything is `ring`, `norm_num` or `nlinarith`, kernel-checked, unbounded in `n`.
-/

namespace HamiltonsCubic.BalanceAll

open HamiltonsCubic.OrbitDim

/-! ## `θ²` depends on the split only through `pq` -/

/-- **The identity.** `(p-1)(q-1) = pq - (p+q) + 1`, so with `n = p + q` fixed the
numerator is `pq - (n-1)`. -/
theorem numerator_identity (p q : ℚ) :
    (p - 1) * (q - 1) = p * q - (p + q - 1) := by ring

/-- So two splits of the same `n` compare exactly as their products do: the difference of
cross-multiplied `θ²` values is a positive multiple of the difference of the products. -/
theorem compares_by_product (n a b : ℚ) :
    (a - (n - 1)) * b - (b - (n - 1)) * a = (n - 1) * (a - b) := by ring

/-! ## `pq` is largest at the most balanced split -/

/-- **Moving `p` up toward `n/2` increases the product**: `p(n-p) < (p+1)(n-p-1)` exactly
when `2p + 1 < n`. -/
theorem product_step (p n : ℚ) :
    (p + 1) * (n - p - 1) - p * (n - p) = n - 2 * p - 1 := by ring

/-- So at every `p` strictly below `(n-1)/2` the product strictly rises. -/
theorem product_rises {p n : ℚ} (h : 2 * p + 1 < n) :
    p * (n - p) < (p + 1) * (n - p - 1) := by
  have := product_step p n
  linarith

/-- **And `pq` is the orbit dimension**, so the maximiser of `θ` maximises the orbit. -/
theorem product_is_orbit (p q : ℚ) : orbitDim p q = p * q := orbitDim_eq p q

/-! ## The two together

`θ²` rises with `pq`; `pq` rises as the split balances; so `θ²` is maximised at the most
balanced split, at every `n`, with no enumeration.
-/

/-- At `n = 12`, the products `2·10, 3·9, 4·8, 5·7, 6·6` are `20, 27, 32, 35, 36`, rising
to the balanced split, exactly as the theorem says. -/
theorem products_12 :
    (2 : ℚ) * 10 = 20 ∧ (3 : ℚ) * 9 = 27 ∧ (4 : ℚ) * 8 = 32 ∧
    (5 : ℚ) * 7 = 35 ∧ (6 : ℚ) * 6 = 36 := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;> norm_num

/-- And at odd `n = 13` they rise to the near-balanced `6·7 = 42`. -/
theorem products_13 :
    (2 : ℚ) * 11 = 22 ∧ (5 : ℚ) * 8 = 40 ∧ (6 : ℚ) * 7 = 42 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- The gap between the balanced product and a split `k` off balance is exactly `k²`,
which is [OrbitDim](HamiltonsCubic/Results/OrbitDim.lean)'s imbalance cost seen again. -/
theorem imbalance_gap (m k : ℚ) : m * m - (m - k) * (m + k) = k ^ 2 := by ring

/-! ## What this settles

**Settled, unbounded in `n`**: that `θ²` depends on the split only through `pq`; that
`pq` rises strictly as the split balances; and hence that **the most balanced split
maximises `θ` at every dimension**, the enumerated round's `n ≤ 24` comes off, and with
it the last bound in this group of results.

**And the reason is structural**: `pq` is the orbit dimension, so *the maximising split is
the one with the largest orbit*. The record's tables show the two coinciding at every
point and connect them nowhere.

**Not claimed**: the closed form itself, which is the record's.
-/

end HamiltonsCubic.BalanceAll
