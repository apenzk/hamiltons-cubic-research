import Mathlib

set_option linter.style.longLine false

/-!
# L26, the dangerous eigenvalue of the two-block spectrum, in closed form

## The record's statement, verbatim

[nondegeneracy.md](../../../findings/nondegeneracy.md)'s *Lemma L26, the dangerous eigenvalue of
the two-block spectrum, in closed form, canonical statement and proof*:

> **Statement.** Let $n=p+q$ with $p,q\ge2$, let $\pi$ be a coordinate $2$-plane inside the
> $p$-block and $\rho$ one inside the $q$-block, and let $X$ be $\phi_\pi\odot\phi_\rho$ with its
> $\Lambda^4$ component removed. Then $X\in\mathrm{Weyl}_n$, and for the sphere product's $e$,
> $$e\circ X=\mu X,\qquad \mu=\frac{n-2}{2(p-1)(q-1)},\qquad \mu\ge\tfrac12\iff(p-2)(q-2)\le1 .$$
> So the criterion $\mu\ge\tfrac12$ binds at exactly two places, **and they are different
> places**: at $p=2$, where $\mu$ **exceeds** $\tfrac12$ by $\tfrac1{2(n-3)}$, and at
> $(p,q)=(3,3)$, where it **equals** it. [...] For $p,q\ge3$ other than $(3,3)$ **and $(3,4)$**
> the gap is $1/(2\max(p,q)-2)$, where the eigenvalue being cleared is
> $\lambda_m=\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ at $m=\max(p,q)$. [...] **At $(3,4)$ this
> family's own $\mu=\tfrac5{12}$ overtakes $\lambda_{\max(p,q)}=\tfrac13$**, so the second-largest
> eigenvalue is $\mu$ and the gap is $\tfrac1{12}$. **And $(3,4)$ is the only such split, by a
> criterion rather than by a search.** The comparison $\lambda_{\max}<\mu$ clears to
> $3p+2q-4-pq>0$, which factors as $(p-2)(q-3)<2$; over $q\ge p\ge3$ that admits exactly $(3,3)$
> and $(3,4)$ [...] **The criterion is written for $q\ge p$ and is order-dependent**: read at
> $(5,3)$ the product $(p-2)(q-3)$ is $0$ and declares an exception, while $\lambda_5=\tfrac38=\mu$
> is a tie.

and the corrected exception mechanism:

> **What decides the exception is the closed form** $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$,
> which vanishes at $(3,3)$ and nowhere else in the range.

## What is NOT typed here

**`X ∈ Weyl_n` and `e ∘ X = μ X`**, the two geometric clauses, which are the reason the closed
form is about anything. Stating them needs `Weyl_n`, the sphere product's Weyl operator, the
`Λ⁴`-component projection, and the Fox product `∘` (equivalently `L_e`), none of which has a Lean
base layer in this repository: the real Weyl layer carries `IsWeyl`, `Pcubic`, `norm` and `theta`,
and no two-block family and no `∘`. **So `μ` enters below as the record's closed form, and what is
proved is every consequence the block draws from it**, the `μ ≥ ½` criterion, the two places it
binds and that they are different places, the gap formula, the `(3,4)` overtake, the closedness of
the exception list, and the order-dependence of the criterion.

**Also not typed:** `‖X‖² = 4/3` with the coefficients `⅔, ⅓, −⅓`, because the block does not
fix the doubling convention under which the three coefficients give `4/3` rather than `2/3`, and
[the layer's docstring](../Base/WeylReal.lean) records normalisation as where this record's errors
live; and the ten-summand dimension list behind the `(3,2)` over-count.

**Everything is over `ℚ`**, so no truncated subtraction can enter; the exception census is over
`ℕ` because it is a statement about which splits exist.
-/

namespace HamiltonsCubic.L26Statement

/-! ## The closed form -/

/-- **`μ = (n−2)/(2(p−1)(q−1))` with `n = p + q`**, the eigenvalue the family exhibits. -/
def mu (p q : ℚ) : ℚ := (p + q - 2) / (2 * (p - 1) * (q - 1))

/-- **`λ_m = (m−2)/(2(m−1))`**, the eigenvalue on `S²₀(ℝ^m)` that L27's bound clears. -/
def lam (m : ℚ) : ℚ := (m - 2) / (2 * (m - 1))

/-! ## `½ − μ` in closed form, and the criterion it decides -/

/-- **`½ − μ = ((p−2)(q−2) − 1)/(2(p−1)(q−1))`**, *the closed form that decides the exception*,
in place of the isomorphism the record withdrew. -/
theorem half_sub_mu (p q : ℚ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    1 / 2 - mu p q = ((p - 2) * (q - 2) - 1) / (2 * (p - 1) * (q - 1)) := by
  have h1 : p - 1 ≠ 0 := by intro h; linarith
  have h2 : q - 1 ≠ 0 := by intro h; linarith
  simp only [mu]
  field_simp
  ring

/-- **`μ ≥ ½ ↔ (p−2)(q−2) ≤ 1`**, for `p, q ≥ 2`. -/
theorem mu_ge_half_iff (p q : ℚ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    1 / 2 ≤ mu p q ↔ (p - 2) * (q - 2) ≤ 1 := by
  have hd : (0:ℚ) < 2 * (p - 1) * (q - 1) := by nlinarith
  rw [← sub_nonpos, half_sub_mu p q hp hq, div_le_iff₀ hd]
  constructor <;> intro h <;> nlinarith

/-! ## The two places the criterion binds, and they are different places -/

/-- **At `p = 2` the eigenvalue STRICTLY exceeds `½`, by `1/(2(n−3))`.** *This is an
inequality, not an attainment, and the record insists the two cases never be collapsed.* -/
theorem mu_at_two (q : ℚ) (hq : 3 ≤ q) : mu 2 q = 1 / 2 + 1 / (2 * (2 + q - 3)) := by
  have h : q - 1 ≠ 0 := by intro h; linarith
  have h' : -1 + q ≠ 0 := by intro hh; linarith
  have hc : (-1 + q) * (-1 + q)⁻¹ = 1 := mul_inv_cancel₀ h'
  simp only [mu]
  field_simp
  first
    | linear_combination hc
    | linear_combination -hc
    | linear_combination (2:ℚ) * hc

/-- **And it is strictly above `½` there.** -/
theorem mu_at_two_gt (q : ℚ) (hq : 3 ≤ q) : 1 / 2 < mu 2 q := by
  rw [mu_at_two q hq]
  have : (0:ℚ) < 1 / (2 * (2 + q - 3)) := by
    apply div_pos one_pos; linarith
  linarith

/-- **At `(3,3)` it EQUALS `½`**, *only the equality is degeneracy*, `E(½)` being an
eigenspace. -/
theorem mu_at_three_three : mu 3 3 = 1 / 2 := by norm_num [mu]

/-- **So `(3,3)` is the only equality in the range `p, q ≥ 3`**: `(p−2)(q−2) = 1` with both
factors at least `1` forces `p = q = 3`. -/
theorem equality_only_at_three_three (p q : ℚ) (hp : 3 ≤ p) (hq : 3 ≤ q)
    (h : mu p q = 1 / 2) : p = 3 ∧ q = 3 := by
  have hd : (0:ℚ) < 2 * (p - 1) * (q - 1) := by nlinarith
  have hz : ((p - 2) * (q - 2) - 1) / (2 * (p - 1) * (q - 1)) = 0 := by
    rw [← half_sub_mu p q (by linarith) (by linarith), h]; ring
  have hnum : (p - 2) * (q - 2) - 1 = 0 := by
    rcases div_eq_zero_iff.mp hz with h1 | h1
    · exact h1
    · exact absurd h1 (ne_of_gt hd)
  have ha : (1:ℚ) ≤ p - 2 := by linarith
  have hb : (1:ℚ) ≤ q - 2 := by linarith
  have ha' : p - 2 ≤ 1 := by nlinarith
  have hb' : q - 2 ≤ 1 := by nlinarith
  exact ⟨by linarith, by linarith⟩

/-! ## The gap, and the `(3,4)` overtake -/

/-- **The gap `½ − λ_m` is `1/(2m−2)`.** -/
theorem gap_lam (m : ℚ) (hm : 2 ≤ m) : 1 / 2 - lam m = 1 / (2 * m - 2) := by
  have h : m - 1 ≠ 0 := by intro h; linarith
  simp only [lam]
  have h' : -1 + m ≠ 0 := by intro hh; linarith
  field_simp
  ring

/-- **`λ_m < μ ↔ (p−2)(q−3) < 2`**, read at `m = q` with `q ≥ p ≥ 3`, the block's own
reduction, which passes through `3p + 2q − 4 − pq > 0`. -/
theorem lam_lt_mu_iff (p q : ℚ) (hp : 3 ≤ p) (hpq : p ≤ q) :
    lam q < mu p q ↔ (p - 2) * (q - 3) < 2 := by
  have hq : (3:ℚ) ≤ q := le_trans hp hpq
  have h1 : (0:ℚ) < p - 1 := by linarith
  have h2 : (0:ℚ) < q - 1 := by linarith
  simp only [lam, mu]
  rw [div_lt_div_iff₀ (by linarith) (by nlinarith)]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/-- **At `(3,4)` the family's own `μ = 5/12` overtakes `λ₄ = ⅓`**, so the second-largest
eigenvalue is `μ` and the gap is `1/12`. -/
theorem overtake_at_three_four :
    mu 3 4 = 5 / 12 ∧ lam 4 = 1 / 3 ∧ lam 4 < mu 3 4 ∧ 1 / 2 - mu 3 4 = 1 / 12 := by
  refine ⟨by norm_num [mu], by norm_num [lam], ?_, ?_⟩
  · norm_num [mu, lam]
  · simp only [mu]; norm_num

/-- **Two splits sit on the equality locus `(p−2)(q−3) = 2`**, `(3,5)` and `(4,4)`, where the
second-largest eigenvalue is attained twice and the gap value is unchanged. -/
theorem equality_locus :
    mu 3 5 = 3 / 8 ∧ lam 5 = 3 / 8 ∧ mu 4 4 = 1 / 3 ∧ lam 4 = 1 / 3 := by
  refine ⟨by norm_num [mu], by norm_num [lam],
    by norm_num [mu], by norm_num [lam]⟩

/-- **The criterion is ORDER-DEPENDENT and is written for `q ≥ p`.** Read at `(5,3)` the product
`(p−2)(q−3)` is `0`, which would declare an exception, while `λ₅ = 3/8 = μ` is a tie, *so a
consumer quoting the factorisation without the ordering is misled.* -/
theorem criterion_order_dependent :
    ((5:ℚ) - 2) * (3 - 3) = 0 ∧ lam 5 = mu 5 3 := by
  refine ⟨by norm_num, ?_⟩
  norm_num [lam, mu]

/-! ## The exception list is closed, by a criterion rather than by a search -/

/-- **Over `q ≥ p ≥ 3`, `(p−2)(q−3) < 2` admits exactly `(3,3)` and `(3,4)`.** *`p = 3` gives
`q < 5`; `p = 4` needs `q < 4`, empty against `q ≥ 4`; `p ≥ 5` gives at least `3·2 = 6`.* -/
theorem exception_list (p q : ℕ) (hp : 3 ≤ p) (hpq : p ≤ q) :
    ((p - 2) * (q - 3) < 2 ↔ (p = 3 ∧ q = 3) ∨ (p = 3 ∧ q = 4)) := by
  constructor
  · intro h
    rcases Nat.lt_or_ge p 4 with hp4 | hp4
    · have hp3 : p = 3 := by omega
      subst hp3
      have : q < 5 := by omega
      interval_cases q <;> omega
    · exfalso
      have h1 : 2 ≤ p - 2 := by omega
      have h2 : 1 ≤ q - 3 := by omega
      nlinarith
  · rintro (⟨h1, h2⟩ | ⟨h1, h2⟩) <;> subst h1 <;> subst h2 <;> norm_num

/-! ## The bottom end, and the historical `(2,2)` note -/

/-- **The bottom-end criterion is `p, q ≥ 3`, not `n ≥ 5`.** *`dim Weyl₅ = 35`, against a
ten-summand sum reading `37` at `(3,2)`.* -/
theorem dimWeyl_five : (5:ℚ) * (5 + 1) * (5 + 2) * (5 - 3) / 12 = 35 := by norm_num

/-- **At `(2,2)` the operator `e` is non-primitive under the Hodge splitting**: its spectrum is
`(−1)⁴, (½)⁴, 1²`, whose multiplicities sum to `dim Weyl₄ = 10` and in which `1` is not simple.
-/
theorem two_two_spectrum : (4:ℚ) + 4 + 2 = 10 ∧ (4:ℚ) * (4 + 1) * (4 + 2) * (4 - 3) / 12 = 10 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## Non-vacuity

The range the gap formula is stated on is non-empty, and the two exceptional splits really are
exceptional. -/

/-- **A witness inside the clean range**: `(4,5)` has `q ≥ p ≥ 3`, is neither `(3,3)` nor `(3,4)`,
and there `λ₅ = 3/8` strictly exceeds `μ = 7/24`, so the gap is `½ − λ₅ = 1/8 = 1/(2·5−2)`. -/
example : mu 4 5 = 7 / 24 ∧ lam 5 = 3 / 8 ∧ mu 4 5 < lam 5 ∧ 1 / 2 - lam 5 = 1 / (2 * 5 - 2) := by
  refine ⟨by norm_num [mu], by norm_num [lam], ?_, ?_⟩
  · norm_num [mu, lam]
  · simp only [lam]; norm_num

end HamiltonsCubic.L26Statement
