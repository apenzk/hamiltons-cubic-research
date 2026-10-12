import Mathlib

set_option linter.style.longLine false

/-!
# L28, the `ℂP^m` family is nondegenerate at every `m ≥ 3`, in the arithmetic that decides it

## The record's statement, verbatim

[nondegeneracy.md](../../../findings/nondegeneracy.md)'s *Lemma L28, the `ℂP^m` family is
nondegenerate at every `m ≥ 3`, canonical statement and proof*:

> **Statement.** For every $m\ge3$, the $\mathfrak u(m)$-invariant line in $\mathrm{Weyl}_{2m}$ is
> spanned by a critical $W_{\mathbb{CP}^m}$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, and
> $$\dim E(\tfrac12)=\dim(\text{orbit})=m(m-1),\qquad \lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)} .$$
> So $\mathbb{CP}^m$ is Morse–Bott nondegenerate and, since $\lambda_{\max}>\tfrac12$, is not a
> maximiser.

with the seven-row table the argument runs on, `GL(m)` highest weight, real dimension, `L_e`,
`c_S + q_S²`, and

> **Nondegeneracy is arithmetic**: $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ equals $\tfrac12$
> exactly when $c_S+q_S^2=2(m+1)$. That holds identically on the orbit, and among the rest only
> $4(m-1)$ can meet it, at $m=3$ alone, **where that summand is absent.**

## What is NOT typed here

**That the seven rows ARE the `U(m)`-isotypic decomposition of `Weyl_{2m}` with those `L_e`
values.** That is the representation theory, `GL_m ⊂ O_{2m}` branching at `λ = (2,2)`,
multiplicity-freeness (a citation valid from `m ≥ 4`, filled in by hand at `m = 3`), Schur's
lemma making `L_e` a scalar on each summand, and the closed form for `e` in the three
`U(m)`-isotypic projectors of `Λ²ℝ^{2m}`. None of `Weyl_n`, `L_e`, `#` or the branching rule has
a Lean base layer here, so **the table enters below as data and everything the block derives from
it is proved**: the dimension sum, the charge formula reproducing every eigenvalue, the two Fox
trace identities, the nondegeneracy solve, `λ_max`, the trace re-derivation of `λ_max` from the
other rows, and the `L70` slack.

**Also not typed:** criticality of `W_{ℂP^m}` (which the record takes from
`dim Weyl_{2m}^{U(m)} = 1`), and that `E(½)` *equals* rather than merely contains the orbit
tangent (which needs multiplicity-freeness).

**The `m = 3` clause is stated as the record fixes it**: the `V_{(1,1);(1,1)}` summand is
**absent** at `m = 3`, and `m²(m+1)(m−3)/4` vanishing there is the analytic continuation agreeing
with the absence rather than the reason for it. What is proved below is the arithmetic, that
`m = 3` is the only place the coincidence can occur, and `row4_dim_vanishes_at_three`.

**Everything is over `ℚ` with `m` rational**, so that no truncated subtraction can enter. The
norm convention is the record's own, *the unhalved `tr(X²)`*, which is what makes the Fox check
come out.
-/

namespace HamiltonsCubic.L28Statement

/-! ## The seven rows, as data

Indexed `1 … 7` in the order of the block's table: the line `⟨W⟩`, the `𝔰𝔲(m)` adjoint, the orbit
tangent `Λ²E ⊕ Λ²Ē`, `V_{(1,1);(1,1)}`, `V_{(2,1);(1)} ⊕ dual`, the Bochner summand `V_{(2);(2)}`,
and `V_{(2,2);∅} ⊕ dual`. -/

/-- The seven real dimensions. -/
def dim (i : ℕ) (m : ℚ) : ℚ :=
  match i with
  | 1 => 1
  | 2 => m ^ 2 - 1
  | 3 => m * (m - 1)
  | 4 => m ^ 2 * (m + 1) * (m - 3) / 4
  | 5 => 2 * m ^ 2 * (m ^ 2 - 4) / 3
  | 6 => m ^ 2 * (m - 1) * (m + 3) / 4
  | 7 => m ^ 2 * (m ^ 2 - 1) / 6
  | _ => 0

/-- The seven charges `c_S + q_S²`. -/
def charge (i : ℕ) (m : ℚ) : ℚ :=
  match i with
  | 1 => 0
  | 2 => 2 * m
  | 3 => 2 * (m + 1)
  | 4 => 4 * (m - 1)
  | 5 => 4 * (m + 1)
  | 6 => 4 * (m + 1)
  | 7 => 4 * (m + 4)
  | _ => 0

/-- The seven eigenvalues of `L_e`. -/
def lam (i : ℕ) (m : ℚ) : ℚ :=
  match i with
  | 1 => 1
  | 2 => (m + 2) / (2 * (m + 1))
  | 3 => 1 / 2
  | 4 => 2 / (m + 1)
  | 5 => 0
  | 6 => 0
  | 7 => -3 / (m + 1)
  | _ => 0

/-- **`dim Weyl_n = n(n+1)(n+2)(n−3)/12`.** -/
def dimWeyl (n : ℚ) : ℚ := n * (n + 1) * (n + 2) * (n - 3) / 12

/-- **`θ² = (m+1)(2m−1)/(3m(m−1))`**, the block's closed form. -/
def thetaSq (m : ℚ) : ℚ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-- **Fox's constant** `κ_F(n) = (2n−1)(n−1)/4`. -/
def kappaF (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 4

/-! ## The charge formula reproduces every eigenvalue

`λ_S = 1 − (c_S + q_S²)/(4(m+1))`, row by row. -/

/-- **The master formula holds on all seven rows**, `1 ≤ i ≤ 7`. -/
theorem lam_of_charge (m : ℚ) (hm : m ≠ -1) (i : ℕ) (hi : 1 ≤ i) (hi7 : i ≤ 7) :
    lam i m = 1 - charge i m / (4 * (m + 1)) := by
  have h1 : m + 1 ≠ 0 := fun h => hm (by linarith)
  interval_cases i <;> simp [lam, charge] <;> field_simp <;> ring

/-! ## The dimension sum, identically in `m` -/

/-- **The seven real dimensions sum to `dim Weyl_{2m}`**, as a polynomial identity in `m`. *Both
sides are `(8m⁴ − 14m² − 6m)/6 = m(m+1)(2m+1)(2m−3)/3`.* -/
theorem dims_sum (m : ℚ) :
    dim 1 m + dim 2 m + dim 3 m + dim 4 m + dim 5 m + dim 6 m + dim 7 m = dimWeyl (2 * m) := by
  simp only [dim, dimWeyl]; ring

/-- **And the block's own closed form for it**, `m(m+1)(2m+1)(2m−3)/3`. -/
theorem dimWeyl_two_m (m : ℚ) : dimWeyl (2 * m) = m * (m + 1) * (2 * m + 1) * (2 * m - 3) / 3 := by
  simp only [dimWeyl]; ring

/-! ## Nondegeneracy is arithmetic

`λ_S = ½` exactly when `c_S + q_S² = 2(m+1)`; that holds identically on the orbit row, and among
the other six only row `4` can meet it, at `m = 3` alone. -/

/-- **`λ_S = ½ ↔ c_S + q_S² = 2(m+1)`.** -/
theorem lam_eq_half_iff (m : ℚ) (hm : m ≠ -1) (i : ℕ) (hi : 1 ≤ i) (hi7 : i ≤ 7) :
    lam i m = 1 / 2 ↔ charge i m = 2 * (m + 1) := by
  have h1 : m + 1 ≠ 0 := fun h => hm (by linarith)
  rw [lam_of_charge m hm i hi hi7]
  constructor
  · intro h; field_simp at h; linarith
  · intro h; rw [h]; field_simp; ring

/-- **The orbit row carries `½` identically in `m`.** -/
theorem orbit_row_half (m : ℚ) : charge 3 m = 2 * (m + 1) ∧ lam 3 m = 1 / 2 := ⟨rfl, rfl⟩

/-- **Among the six rows other than the orbit, only row `4` can reach `½`, and only at `m = 3`.**
*`4(m−1) = 2(m+1) ↔ m = 3`; `0`, `2m`, `4(m+1)` and `4(m+4)` never equal `2(m+1)` for `m ≥ 3`.*
-/
theorem only_row_four_at_three (m : ℚ) (hm : 3 ≤ m) (i : ℕ) (hi : 1 ≤ i) (hi7 : i ≤ 7)
    (hne : i ≠ 3) (h : charge i m = 2 * (m + 1)) : i = 4 ∧ m = 3 := by
  interval_cases i <;> simp only [charge] at h <;> first
    | (exact absurd rfl hne)
    | (exfalso; linarith)
    | (exact ⟨rfl, by linarith⟩)

/-- **And at `m = 3` that summand is absent**, `m²(m+1)(m−3)/4` vanishes there, which the record
records as the analytic continuation agreeing with the absence rather than the reason for it. -/
theorem row4_dim_vanishes_at_three : dim 4 3 = 0 := by simp only [dim]; norm_num

/-- **Nondegeneracy, assembled.** For `m > 3` no row other than the orbit carries `½`, so
`E(½)` is the orbit tangent, of dimension `m(m−1)`; and at `m = 3` the only row that could is
absent. -/
theorem nondegenerate (m : ℚ) (hm : 3 < m) (i : ℕ) (hi : 1 ≤ i) (hi7 : i ≤ 7) (hne : i ≠ 3) :
    lam i m ≠ 1 / 2 := by
  have hm1 : m ≠ -1 := by intro h; linarith
  intro h
  have hc := (lam_eq_half_iff m hm1 i hi hi7).mp h
  have := only_row_four_at_three m hm.le i hi hi7 hne hc
  linarith [this.2]

/-- **The orbit's dimension is `m(m−1)`**, which is the row-`3` dimension. -/
theorem orbit_dim (m : ℚ) : dim 3 m = m * (m - 1) := rfl

/-! ## `λ_max`, and why the point is not a maximiser -/

/-- **`λ_max = (m+2)/(2(m+1)) = ½ + 1/(2(m+1))`**, on the `𝔰𝔲(m)` adjoint. -/
theorem lambda_max_form (m : ℚ) (hm : 3 ≤ m) : lam 2 m = 1 / 2 + 1 / (2 * (m + 1)) := by
  have h1 : m + 1 ≠ 0 := by intro h; linarith
  simp only [lam]; field_simp; ring

/-- **It exceeds `½`**, so `ℂP^m` is no local maximiser. -/
theorem lambda_max_gt_half (m : ℚ) (hm : 3 ≤ m) : 1 / 2 < lam 2 m := by
  rw [lambda_max_form m hm]
  have : (0:ℚ) < 1 / (2 * (m + 1)) := by positivity
  linarith

/-- **And it is the largest value on `W^⊥`**, every row other than the line `⟨W⟩` is at most
`(m+2)/(2(m+1))`, for `m ≥ 3`. *The only competitor is `2/(m+1)`, which loses from `m ≥ 2`.* -/
theorem lambda_max_is_max (m : ℚ) (hm : 3 ≤ m) (i : ℕ) (hi : 2 ≤ i) (hi7 : i ≤ 7) :
    lam i m ≤ lam 2 m := by
  have h1 : (0:ℚ) < m + 1 := by linarith
  have hb : (0:ℚ) < 2 * (m + 1) := by linarith
  interval_cases i <;> simp only [lam]
  · exact le_refl _
  · rw [div_le_div_iff₀ (by norm_num) hb]; nlinarith
  · rw [div_le_div_iff₀ h1 hb]; nlinarith
  · rw [le_div_iff₀ hb]; nlinarith
  · rw [le_div_iff₀ hb]; nlinarith
  · rw [div_le_div_iff₀ h1 hb]; nlinarith

/-! ## The two Fox trace identities, which check the list's arithmetic

*And do no more than that: both pass at `m = 2`, where row `4`'s dimension is `−3` and the list
is known refuted, so they certify internal arithmetic and say nothing about the decomposition.*
-/

/-- `tr L_e = ∑ dim_S · λ_S`. -/
def trL (m : ℚ) : ℚ :=
  dim 1 m * lam 1 m + dim 2 m * lam 2 m + dim 3 m * lam 3 m + dim 4 m * lam 4 m
    + dim 5 m * lam 5 m + dim 6 m * lam 6 m + dim 7 m * lam 7 m

/-- `tr (L_e²) = ∑ dim_S · λ_S²`. -/
def trLsq (m : ℚ) : ℚ :=
  dim 1 m * lam 1 m ^ 2 + dim 2 m * lam 2 m ^ 2 + dim 3 m * lam 3 m ^ 2 + dim 4 m * lam 4 m ^ 2
    + dim 5 m * lam 5 m ^ 2 + dim 6 m * lam 6 m ^ 2 + dim 7 m * lam 7 m ^ 2

/-- **`tr L_e = 0`**, identically in `m`. -/
theorem trace_zero (m : ℚ) (hm : m ≠ -1) : trL m = 0 := by
  have h1 : m + 1 ≠ 0 := fun h => hm (by linarith)
  simp only [trL, dim, lam]
  field_simp
  ring

/-- **`tr(L_e²) = 3m(m−1)(4m−1)/(4(m+1))`**, identically in `m`. -/
theorem trace_sq (m : ℚ) (hm : m ≠ -1) :
    trLsq m = 3 * m * (m - 1) * (4 * m - 1) / (4 * (m + 1)) := by
  have h1 : m + 1 ≠ 0 := fun h => hm (by linarith)
  simp only [trLsq, dim, lam]
  field_simp
  ring

/-- **And that is Fox's `κ_F(2m)‖e‖²`**, with `‖e‖² = 1/θ²`, stated as `tr(L_e²)·θ² = κ_F(2m)`,
so the second identity *derives* `κ_F` at even `n` rather than testing the table against it. -/
theorem trace_sq_is_fox (m : ℚ) (hm : 3 ≤ m) : trLsq m * thetaSq m = kappaF (2 * m) := by
  have h1 : m + 1 ≠ 0 := by intro h; linarith
  have h2 : m ≠ 0 := by intro h; linarith
  have h3 : m - 1 ≠ 0 := by intro h; linarith
  rw [trace_sq m (by intro h; linarith)]
  simp only [thetaSq, kappaF]
  field_simp
  ring

/-- **Both identities pass at `m = 2`, where row `4` has dimension `−3`**, the block's own
caveat, that they certify the list's internal arithmetic and not the decomposition. -/
theorem identities_pass_at_two : dim 4 2 = -3 ∧ trL 2 = 0 := by
  refine ⟨by simp only [dim]; norm_num, trace_zero 2 (by norm_num)⟩

/-- **The trace solve returns `λ_max` from the other four rows.** Holding the rest fixed,
`tr L_e = 0` reads `(m²−1)y = (m+2)(m−1)/2`, so `y = (m+2)/(2(m+1))`. *A second route to the
value, and not independent of the charge formula, five of whose outputs it consumes.* -/
theorem trace_solve (m y : ℚ) (hm : 3 ≤ m)
    (h : 1 + (m ^ 2 - 1) * y + m * (m - 1) / 2 + m ^ 2 * (m - 3) / 2 - m ^ 2 * (m - 1) / 2 = 0) :
    y = (m + 2) / (2 * (m + 1)) := by
  have h1 : (0:ℚ) < m + 1 := by linarith
  have h2 : (0:ℚ) < m - 1 := by linarith
  have hstep : (m ^ 2 - 1) * y = (m + 2) * (m - 1) / 2 := by linarith
  field_simp
  nlinarith [hstep]

/-! ## `θ²`, and the two places the record reads it -/

/-- **`θ²(3) = 10/9 = θ₀(6)²`**, `ℂP³` sits exactly at `Θ₆`, while `λ_max = 5/8 > ½` says it is
no local maximiser. -/
theorem thetaSq_at_three : thetaSq 3 = 10 / 9 ∧ lam 2 3 = 5 / 8 := by
  refine ⟨by simp only [thetaSq]; norm_num, by simp only [lam]; norm_num⟩

/-- **`θ₀(6)² = 10/9`**, the value `θ²(3)` meets. -/
theorem theta0_six_sq : 2 * (6 - 1) * (6 - 2) / (6:ℚ) ^ 2 = 10 / 9 := by norm_num

/-! ## The `L70` slack, computed rather than asserted

`e` has `λ_max = 2(m−1)/(2m−1)` and `λ_min = −1/(2m−1)`, so `W = θe` has those times `θ`, and
`L70`'s saturation value at `n = 2m` is `θ(1 + 2(m−2))`, a slack of exactly `2(m−2)θ`, vanishing
only at `m = 2`, outside this lemma's range. -/

/-- **The slack is `2(m−2)θ`.** -/
theorem l70_slack (m θ : ℚ) (hm : 3 ≤ m) :
    -(θ / (2 * m - 1)) + (2 * m - 2) * (θ * (2 * (m - 1)) / (2 * m - 1))
      = θ * (1 + 2 * (m - 2)) := by
  have h : 2 * m - 1 ≠ 0 := by intro h; linarith
  field_simp
  ring

/-- **And it is strictly positive for `m ≥ 3`**, so `W_{ℂP^m}` does not saturate `L70`. -/
theorem l70_slack_pos (m θ : ℚ) (hm : 3 ≤ m) (hθ : 0 < θ) : 0 < 2 * (m - 2) * θ := by
  have : (0:ℚ) < m - 2 := by linarith
  positivity

/-! ## Non-vacuity

The range `m ≥ 3` is non-empty and the table is honest there: at `m = 3` the seven dimensions sum
to `dim Weyl₆ = 84`, with row `4` absent. -/

example : dim 1 3 + dim 2 3 + dim 3 3 + dim 4 3 + dim 5 3 + dim 6 3 + dim 7 3 = 84 ∧
    dimWeyl 6 = 84 ∧ dim 4 3 = 0 := by
  refine ⟨by simp only [dim]; norm_num, by simp only [dimWeyl]; norm_num,
    by simp only [dim]; norm_num⟩

end HamiltonsCubic.L28Statement
