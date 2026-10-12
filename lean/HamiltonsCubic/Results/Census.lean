import Mathlib.Tactic.NormNum

/-!
# The coincidence census, decided

[Coincidences.lean](HamiltonsCubic/Results/Coincidences.lean) recorded four coincidences
and said the exhaustiveness was a search rather than a proof. **It is now a proof.**

`ℚ`'s equality does not reduce in the kernel, so each `θ²` is carried as its normalised
numerator–denominator pair over `ℕ`, where equality is structural and `decide` closes the
enumeration. The two families are enumerated together: every sphere product with
`2 ≤ p ≤ q` and `p + q ≤ 24`, and every `ℂPᵐ` with `2 ≤ m ≤ 12`.

**Exactly eight of the enumerated points share their value with another**, four values,
each reached exactly twice, and **no value is reached three times.**
-/

namespace HamiltonsCubic.Census

set_option maxRecDepth 1000000

/-- Sphere-product splits with `2 ≤ p ≤ q` and `n = p + q ≤ 24`. -/
def pairs : List (ℕ × ℕ) :=
  ((List.range 25).flatMap (fun p => (List.range 25).map (fun q => (p, q))))
    |>.filter (fun x => 2 ≤ x.1 && x.1 ≤ x.2 && x.1 + x.2 ≤ 24)

/-- `θ²` as a normalised pair, from `2(p-1)(q-1)(n-1) / (pq(n-2))`. -/
def sphereKey (x : ℕ × ℕ) : ℕ × ℕ :=
  let p := x.1; let q := x.2; let n := p + q
  let a := 2 * (p - 1) * (q - 1) * (n - 1)
  let b := p * q * (n - 2)
  let g := Nat.gcd a b
  (a / g, b / g)

/-- `θ²` for `ℂPᵐ`, from `(m+1)(2m-1) / (3m(m-1))`. -/
def cpKey (m : ℕ) : ℕ × ℕ :=
  let a := (m + 1) * (2 * m - 1)
  let b := 3 * m * (m - 1)
  let g := Nat.gcd a b
  (a / g, b / g)

def cpRange : List ℕ := (List.range 13).filter (fun m => 2 ≤ m)

/-- Every value both families take, at `n ≤ 24`. -/
def keys : List (ℕ × ℕ) := pairs.map sphereKey ++ cpRange.map cpKey

/-- The number of times a value occurs. -/
def mult (v : ℕ × ℕ) : ℕ := (keys.filter (· == v)).length

theorem pairs_count : pairs.length = 121 := by decide

theorem cp_count : cpRange.length = 11 := by decide

theorem keys_count : keys.length = 132 := by decide

/-! ## The census -/

/-- **Exactly eight of the `132` points share their value with another.** -/
theorem shared_count : (keys.filter (fun v => mult v > 1)).length = 8 := by decide

/-- **And no value is reached three times**, so the eight are four pairs. -/
theorem no_triples : (keys.filter (fun v => mult v > 2)).length = 0 := by decide

/-! ## The four values, named -/

theorem mult_10_9 : mult (10, 9) = 2 := by decide
theorem mult_35_36 : mult (35, 36) = 2 := by decide
theorem mult_120_77 : mult (120, 77) = 2 := by decide
theorem mult_105_64 : mult (105, 64) = 2 := by decide

/-- And these four are the only ones: each of the eight shared entries is one of them. -/
theorem shared_are_these :
    (keys.filter (fun v => mult v > 1)).all
      (fun v => v == (10, 9) || v == (35, 36) || v == (120, 77) || v == (105, 64)) := by
  decide

/-! ## What this settles

**Settled, in the kernel**: that over both families at `n ≤ 24`, `121` sphere products
and `11` complex projective spaces, `132` points, **exactly four values are reached
twice, none three times, and the four are `10/9`, `35/36`, `120/77` and `105/64`.**

The previous round proved the four equalities and reported the exhaustiveness as a
search. **The search is now the theorem**, by carrying each value as a normalised pair
over `ℕ` so that equality reduces.

**Not settled here**: anything beyond `n = 24`, and the closed forms themselves.
-/

end HamiltonsCubic.Census
