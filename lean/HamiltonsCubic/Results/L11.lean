import HamiltonsCubic.Results.L26Statement

set_option linter.style.longLine false

/-!
# L11, the two failures of Morse–Bott nondegeneracy at a two-block sphere product

[nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L11: *"At the unpadded dimension `n=p+q`, for
`p,q≥3` with `(p,q)≠(3,3)`, `S^p×S^q` is Morse–Bott nondegenerate: the Hessian kernel is exactly the orbit tangent,
of dimension `pq`."* The one degenerate case in that range is `(3,3)`, and `min(p,q)=2` is nondegenerate but not a
maximum, which is a different failure. The proof runs
through [L26Statement.lean](L26Statement.lean)'s closed form `½ - μ = ((p-2)(q-2) - 1)/(2(p-1)(q-1))`. This file
proves the arithmetic the block rests on:

* **`trichotomy`**: over integers `p, q ≥ 2`, `μ < ½` exactly in L11's range, `μ = ½` exactly at `(3, 3)`, and
  `μ > ½` exactly at `min(p, q) = 2`, so the three cases partition the range and the two failures are different;
* **`two_two`**: at `(2, 2)`, `μ = 1`, and L26's recorded spectrum `(-1)⁴, (½)⁴, 1²` has total multiplicity
  `10 = dim 𝒲₄` and trace `0`, with `dim E(½) = 4 = pq`: non-maximal and nondegenerate at once;
* **`s2s4_recount`**: the over-count at `S² × S⁴` is `86 - 84 = 2 = dim S²₀(ℝ²)`;
* **`padded_half`**, **`padded_count`**: at a padded dimension the four-set value `1/(2(p-1))` is `½` exactly at
  `p = 2`. At `S² × S²` the count `q(n - n₀)` is `2(n - 4)`, and the excess `4(n - 4)` is that count doubled, both
  factors being `2`-spheres (arithmetic on the quoted counts);
* **`coincidence_iff`**, **`coincidence_solutions`**, **`mu_two_five`**: `C(k,2)C(l,2) = kl` is `(k-1)(l-1) = 4`,
  solved at `(3, 3)`, `(2, 5)` and `(5, 2)`, and at `(2, 5)` the point has `μ = ⅝ ≠ ½`, so the coincidence does
  not explain the exception;
* **`three_three_kernel`**, **`sign_characters`**: at `(3, 3)` the recorded kernel `18` is `pq + C(p,2)C(q,2)` against
  the orbit's `9`, and the character values `(-1)²·3 = +3` and `(-1)·3 = -3` the block reads at `-I` (arithmetic
  only, the representation-theoretic reading being the block's);
* **`s7s7`**: `½ - μ = ⅓` at `S⁷ × S⁷`.

**What is not typed**, each entering as a quoted number or not at all: that `μ` is the dangerous `L_e`-eigenvalue
and that `E(½)` is the Hessian kernel, which are L26's and L24's; L27's claim that in L11's range `½` is attained on
the orbit tangent alone; the `(2,2)` spectrum, the `86`-dimensional `S² × S⁴` decomposition and the `(3,3)` kernel
`18`; and that `-I`'s characters make the two summands non-isomorphic.
-/

namespace HamiltonsCubic.L11

open HamiltonsCubic.L26Statement

/-- **The three cases partition `p, q ≥ 2`**: `μ < ½` in L11's range, `μ = ½` at `(3,3)` only, `μ > ½` at
`min(p,q) = 2` only. -/
theorem trichotomy (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    (mu p q < 1 / 2 ↔ 3 ≤ p ∧ 3 ≤ q ∧ ¬ (p = 3 ∧ q = 3)) ∧
    (mu p q = 1 / 2 ↔ p = 3 ∧ q = 3) ∧
    (1 / 2 < mu p q ↔ p = 2 ∨ q = 2) := by
  have hp' : (2 : ℚ) ≤ p := by exact_mod_cast hp
  have hq' : (2 : ℚ) ≤ q := by exact_mod_cast hq
  have hd : (0 : ℚ) < 2 * (p - 1) * (q - 1) := by nlinarith
  -- `(½ - μ)·D = (p-2)(q-2) - 1` with `D > 0`
  have hs : (1 / 2 - mu p q) * (2 * (p - 1) * (q - 1)) = ((p : ℚ) - 2) * (q - 2) - 1 := by
    rw [half_sub_mu p q hp' hq', div_mul_cancel₀ _ hd.ne']
  have cases3 : ((p = 2 ∨ q = 2) ∧ 1 / 2 < mu p q) ∨ ((p = 3 ∧ q = 3) ∧ mu p q = 1 / 2) ∨
      ((3 ≤ p ∧ 3 ≤ q ∧ ¬ (p = 3 ∧ q = 3)) ∧ mu p q < 1 / 2) := by
    by_cases h2 : p = 2 ∨ q = 2
    · left
      refine ⟨h2, ?_⟩
      have : ((p : ℚ) - 2) * (q - 2) = 0 := by
        rcases h2 with h | h <;> simp [h]
      by_contra hc
      have : 0 ≤ (1 / 2 - mu p q) * (2 * (p - 1) * (q - 1)) := mul_nonneg (by linarith) hd.le
      linarith
    · have hp3 : (3 : ℚ) ≤ p := by exact_mod_cast (by omega : 3 ≤ p)
      have hq3 : (3 : ℚ) ≤ q := by exact_mod_cast (by omega : 3 ≤ q)
      by_cases h33 : p = 3 ∧ q = 3
      · right; left
        refine ⟨h33, ?_⟩
        obtain ⟨rfl, rfl⟩ := h33
        norm_num [mu]
      · right; right
        refine ⟨⟨by omega, by omega, h33⟩, ?_⟩
        have hbig : (1 : ℚ) < ((p : ℚ) - 2) * (q - 2) := by
          rcases (show 4 ≤ p ∨ 4 ≤ q by omega) with h4 | h4
          · have : (4 : ℚ) ≤ p := by exact_mod_cast h4
            nlinarith
          · have : (4 : ℚ) ≤ q := by exact_mod_cast h4
            nlinarith
        by_contra hc
        have : (1 / 2 - mu p q) * (2 * (p - 1) * (q - 1)) ≤ 0 :=
          mul_nonpos_of_nonpos_of_nonneg (by linarith) hd.le
        linarith
  rcases cases3 with ⟨hc, hm⟩ | ⟨hc, hm⟩ | ⟨hc, hm⟩
  · refine ⟨⟨fun h => absurd h (not_lt.mpr hm.le), fun h => by omega⟩,
      ⟨fun h => by linarith, fun h => by omega⟩, ⟨fun _ => hc, fun _ => hm⟩⟩
  · refine ⟨⟨fun h => by linarith, fun h => absurd hc h.2.2⟩, ⟨fun _ => hc, fun _ => hm⟩,
      ⟨fun h => by linarith, fun h => by omega⟩⟩
  · refine ⟨⟨fun _ => hc, fun _ => hm⟩, ⟨fun h => by linarith, fun h => absurd h hc.2.2⟩,
      ⟨fun h => by linarith, fun h => by omega⟩⟩

/-- **`(2,2)`**: `μ = 1`, and the spectrum `(-1)⁴, (½)⁴, 1²` has multiplicity `10 = dim 𝒲₄`, trace `0`, and
`dim E(½) = 4 = pq`. -/
theorem two_two :
    mu 2 2 = 1 ∧ (4 : ℚ) + 4 + 2 = 4 * 5 * 6 * 1 / 12 ∧ (4 : ℚ) * (-1) + 4 * (1 / 2) + 2 * 1 = 0 ∧
      (4 : ℕ) = 2 * 2 := by
  refine ⟨by norm_num [mu], by norm_num, by norm_num, rfl⟩

/-- **The `S² × S⁴` over-count is one summand**: `86 - dim 𝒲₆ = 2 = dim S²₀(ℝ²)`. -/
theorem s2s4_recount : (6 : ℚ) * 7 * 8 * 3 / 12 = 84 ∧ (86 : ℚ) - 84 = 2 * 3 / 2 - 1 := by
  constructor <;> norm_num

/-- **At a padded dimension the four-set value `1/(2(p-1))` is `½` exactly at `p = 2`.** -/
theorem padded_half (p : ℚ) (hp : 2 ≤ p) : 1 / (2 * (p - 1)) = 1 / 2 ↔ p = 2 := by
  have h : 2 * (p - 1) ≠ 0 := by intro h; linarith
  constructor
  · intro e
    rw [div_eq_div_iff h (by norm_num)] at e
    linarith
  · rintro rfl; norm_num

/-- **Arithmetic on the padded counts**: at `S² × S²` the count `q(n - n₀)` is `2(n - 4)`, which is not the
recorded `4(n - 4)`, and doubling it for the second `2`-sphere factor gives `4(n - 4)`. -/
theorem padded_count (n : ℚ) (hn : 4 < n) :
    (2 : ℚ) * (n - 4) ≠ 4 * (n - 4) ∧ 2 * (n - 4) + 2 * (n - 4) = 4 * (n - 4) := by
  constructor
  · intro h; linarith
  · ring

/-- **The dimension coincidence**: `C(k,2)C(l,2) = kl` is `(k-1)(l-1) = 4` for `k, l ≥ 2`. -/
theorem coincidence_iff (k l : ℚ) (hk : 2 ≤ k) (hl : 2 ≤ l) :
    (k * (k - 1) / 2) * (l * (l - 1) / 2) = k * l ↔ (k - 1) * (l - 1) = 4 := by
  have hkl : k * l ≠ 0 := by positivity
  constructor
  · intro h
    have : k * l * ((k - 1) * (l - 1) - 4) = 0 := by linear_combination 4 * h
    have := (mul_eq_zero.mp this).resolve_left hkl
    linarith
  · intro h; linear_combination (k * l / 4) * h

/-- **Its solutions over the integers** `k, l ≥ 2` are `(3,3)`, `(2,5)`, `(5,2)`. -/
theorem coincidence_solutions (k l : ℕ) (hk : 2 ≤ k) (hl : 2 ≤ l) :
    (k - 1) * (l - 1) = 4 ↔ (k = 3 ∧ l = 3) ∨ (k = 2 ∧ l = 5) ∨ (k = 5 ∧ l = 2) := by
  constructor
  · intro h
    have hk5 : k ≤ 5 := by
      by_contra hc
      have : 5 ≤ (k - 1) * (l - 1) := by
        calc 5 ≤ (k - 1) * 1 := by omega
          _ ≤ (k - 1) * (l - 1) := Nat.mul_le_mul_left _ (by omega)
      omega
    have hl5 : l ≤ 5 := by
      by_contra hc
      have : 5 ≤ (k - 1) * (l - 1) := by
        calc 5 ≤ 1 * (l - 1) := by omega
          _ ≤ (k - 1) * (l - 1) := Nat.mul_le_mul_right _ (by omega)
      omega
    interval_cases k <;> interval_cases l <;> simp_all
  · rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩) <;> rfl

/-- **At `(2,5)`, where the coincidence also holds, `μ = ⅝ ≠ ½`**, so the point is nondegenerate. -/
theorem mu_two_five : mu 2 5 = 5 / 8 ∧ mu 2 5 ≠ 1 / 2 := by
  constructor <;> norm_num [mu]

/-- **At `(3,3)` the kernel is `pq + C(p,2)C(q,2) = 18`**, twice the orbit's `9`. -/
theorem three_three_kernel : 3 * 3 + Nat.choose 3 2 * Nat.choose 3 2 = 18 ∧ 18 = 2 * (3 * 3) := by
  decide

/-- **The character values the block reads at `-I`**: `(-1)² · C(3,2) = 3` on `Λ²ℝ³` and `(-1) · 3 = -3` on `ℝ³`.
That these make the two summands non-isomorphic under `O(3) × O(3)` is the block's reading and is not typed. -/
theorem sign_characters : (-1 : ℤ) ^ 2 * (Nat.choose 3 2 : ℤ) = 3 ∧ (-1 : ℤ) * 3 = -3 := by
  decide

/-- **`½ - μ = ⅓` at `S⁷ × S⁷`**, no arithmetic beyond the closed form. -/
theorem s7s7 : 1 / 2 - mu 7 7 = 1 / 3 := by norm_num [mu]

end HamiltonsCubic.L11
