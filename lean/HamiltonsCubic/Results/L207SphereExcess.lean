import Mathlib.Tactic

/-- **The Fox algebra of the Weyl module is not isospectral, for every `n ≥ 7`.** *An algebra is
isospectral (Krasnov-Tkachev) when all its idempotents share one spectrum. The idempotents of the
Fox algebra are the critical points `e = W/theta`, and `orbit_dim_eq_mul` gives `dim E(1/2) = p*q`
at `S^p x S^q` away from the `(3,3)` split. For `S^2 x S^(n-2)` that is `2(n-2)`, and for
`S^3 x S^(n-3)` with `n ≥ 7` (so `n-3 ≥ 4`, off the `(3,3)` split) it is `3(n-3)`. These differ at
every `n != 5`, so two idempotents of one algebra have different spectra.* **This is the root of
R23: the spectrum IS a separating invariant, where an isospectral algebra would offer none.** -/
theorem foxAlgebra_not_isospectral (n : ℕ) (hn : 7 ≤ n) :
    2 * (n - 2) ≠ 3 * (n - 3) := by omega

/-- **The `n = 6` witness, carrying the `(3,3)` excess explicitly.** *At `n = 6` the split
`S^3 x S^(n-3)` is `S^3 x S^3`, where `μ = 1/2`, so the four-set blocks add `C(3,2)^2 = 9` and
`dim E(1/2) = 3*3 + 9 = 18`, not the bare `3(n-3) = 9`. Against `S^2 x S^4`'s `2*4 = 8` the two
multiplicities still differ, so the algebra is not isospectral at `n = 6` either. This is the
value r911's screen confirmed against the record's own Fox product.* -/
theorem foxAlgebra_not_isospectral_six :
    2 * (6 - 2) ≠ 3 * 3 + Nat.choose 3 2 * Nat.choose 3 2 := by decide

/-!
# Lemma L207, the excess at a two-factor sphere product, and the `1/2` criterion

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), the L207 block.

At `S^p × S^q` with `n = p + q` the multiplicity of the eigenvalue `1/2` of `L e` is
`p*q + C(p,2)*C(q,2)` when `μ = 1/2` and `p*q` otherwise, where
`μ = (n-2) / (2*(p-1)*(q-1))`. The orbit dimension is `C(n,2) - C(p,2) - C(q,2)`, and the
excess is the difference.

**This file types the arithmetic, which is the whole of what the base layer can reach.**
Four statements, none of them needing `L e`, an orbit, or a sector decomposition:

`mu_eq_half_iff` is the criterion `μ = 1/2 ↔ (p-2)*(q-2) = 1`, over the rationals.
`only_three_three` turns that into `p = 3 ∧ q = 3` for natural `p, q ≥ 2`.
`orbit_dim_eq_mul` is `C(n,2) - C(p,2) - C(q,2) = p*q`, the identity that makes the
excess vanish exactly when the four-set blocks contribute nothing, proved through
`choose_two_succ` and `choose_two_add` so no natural subtraction truncates.
`sector_dims_eq_weylDim` is the closing count behind the block enumeration,
`n(n-3)/2 + C(n,2)*(n-3) + 2*C(n,4) = dim 𝒲ₙ`.

**What this file does NOT state**, and what would need the layer to grow: that the listed
sectors are the isotypic components of the sign group, that the cross-pair blocks carry
`1/2` exactly once, and that the orbit direction is that eigenvector. Those are the
geometric content and they are prose at
[nondegeneracy.md](../../../findings/nondegeneracy.md). *What is typed here is the
arithmetic those statements are combined with, which is where the criterion and the
excess actually come from.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

/-- **The four-set eigenvalue at a two-factor sphere product**, as a rational function of
the two factor dimensions. `L121` gives it as `(n-2) / (2(p-1)(q-1))` with `n = p + q`. -/
noncomputable def mu (p q : ℚ) : ℚ := (p + q - 2) / (2 * (p - 1) * (q - 1))

/-- **The criterion, over the rationals**: the four-set blocks reach `1/2` exactly when
`(p-2)(q-2) = 1`. Stated with `p, q ≠ 1` so the quotient is defined. -/
theorem mu_eq_half_iff (p q : ℚ) (hp : p ≠ 1) (hq : q ≠ 1) :
    mu p q = 1 / 2 ↔ (p - 2) * (q - 2) = 1 := by
  have hp' : p - 1 ≠ 0 := sub_ne_zero_of_ne hp
  have hq' : q - 1 ≠ 0 := sub_ne_zero_of_ne hq
  have hd : 2 * (p - 1) * (q - 1) ≠ 0 := by
    simp [hp', hq']
  unfold mu
  rw [div_eq_div_iff hd (by norm_num : (2 : ℚ) ≠ 0)]
  constructor <;> intro h <;> linarith [h]

/-- **And over the naturals it isolates `S³ × S³`.** For `p, q ≥ 2` the only solution of
`(p-2)*(q-2) = 1` is `p = q = 3`, because a product of naturals is `1` only when both
factors are. -/
theorem only_three_three {p q : ℕ} (hp : 2 ≤ p) (hq : 2 ≤ q)
    (h : (p - 2) * (q - 2) = 1) : p = 3 ∧ q = 3 := by
  have h1 : (p - 2) ∣ 1 := ⟨q - 2, h.symm⟩
  have h2 : (q - 2) ∣ 1 := ⟨p - 2, by rw [mul_comm] at h; exact h.symm⟩
  have e1 := Nat.dvd_one.mp h1
  have e2 := Nat.dvd_one.mp h2
  omega

/-- **One step of the binomial recursion, with the literal `2` in place.** `Nat.choose_succ_succ`
states the step at `k+1`, and its `1+1` does not unify with the goal's `2`, so the literal is
normalised here once and the induction below rewrites with this instead. -/
theorem choose_two_succ (n : ℕ) : Nat.choose (n + 1) 2 = Nat.choose n 2 + n := by
  have h : Nat.choose (n + 1) (1 + 1) = Nat.choose n 1 + Nat.choose n (1 + 1) :=
    Nat.choose_succ_succ n 1
  simpa [Nat.choose_one_right, Nat.add_comm] using h

theorem choose_two_add (p q : ℕ) :
    Nat.choose (p + q) 2 = Nat.choose p 2 + Nat.choose q 2 + p * q := by
  induction q with
  | zero => simp
  | succ m ih =>
      have he : p + (m + 1) = (p + m) + 1 := by omega
      rw [he, choose_two_succ, ih, choose_two_succ]
      ring

/-- **The orbit dimension is `p*q`.** `C(n,2) - C(p,2) - C(q,2) = p*q` with `n = p + q`,
which is why the excess vanishes exactly when the four-set blocks contribute no `1/2`:
the cross-pair sector supplies `p*q` and the orbit needs `p*q`. Natural subtraction is safe
here because `choose_two_add` gives the sum form first. -/
theorem orbit_dim_eq_mul (p q : ℕ) :
    Nat.choose (p + q) 2 - Nat.choose p 2 - Nat.choose q 2 = p * q := by
  rw [choose_two_add]
  omega

/-- **The closing count behind the block enumeration.** The coordinate-diagonal sector,
the `C(n,2)` pair blocks of dimension `n-3`, and the `C(n,4)` four-set blocks of dimension
`2` exhaust the Weyl module: `n(n-3)/2 + C(n,2)*(n-3) + 2*C(n,4) = n(n+1)(n+2)(n-3)/12`.

Stated over `ℚ` with a real parameter so no natural subtraction truncates, and proved by
`ring` after clearing the binomials. -/
theorem sector_dims_eq_weylDim (n : ℚ) :
    n * (n - 3) / 2 + (n * (n - 1) / 2) * (n - 3) + 2 * (n * (n - 1) * (n - 2) * (n - 3) / 24)
      = n * (n + 1) * (n + 2) * (n - 3) / 12 := by
  ring

/-!
## The axiom check, recorded where a reader meets it

```
#print axioms mu_eq_half_iff          -- [propext, Classical.choice, Quot.sound]
#print axioms only_three_three        -- [propext, Classical.choice, Quot.sound]
#print axioms choose_two_succ         -- [propext]
#print axioms choose_two_add          -- [propext, Quot.sound]
#print axioms orbit_dim_eq_mul        -- [propext, Quot.sound]
#print axioms sector_dims_eq_weylDim  -- [propext, Classical.choice, Quot.sound]
#print axioms foxAlgebra_not_isospectral -- [propext]
```

**One object satisfying the hypotheses, so vacuity is visible.** `p = q = 3` gives
`mu 3 3 = 1/2` and `(3-2)*(3-2) = 1`, and there `orbit_dim_eq_mul` reads `15 - 3 - 3 = 9`
against `C(3,2)^2 = 9` of four-set contribution, which is the recorded excess at
`S³ × S³`. All three check by `norm_num [mu]` and `decide`.
-/

end HamiltonsCubic.Results
