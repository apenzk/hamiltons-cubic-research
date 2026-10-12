import Mathlib
import HamiltonsCubic.Results.L47Statement

set_option linter.style.longLine false

/-!
# L47, the dimension lemma: the implication and the certificates

[findings/problem.md](../../../findings/problem.md), Lemma L47: at a locally symmetric Einstein
space normalised to Einstein constant `½`, `tr R = n/4`, `‖W‖² = ‖R‖² − n/(8(n−1))`, and
Cauchy–Schwarz gives `‖R‖² ≥ (n/4)²/dim 𝔥`; hence
`dim 𝔥 ≤ 3n²(n−1)/(2(7n−4)) ⟹ ‖W‖² ≥ 1/6`.

[L47.lean](L47.lean) compares the bound with `dim 𝔰𝔬(n)`, and
[CauchyEquality.lean](CauchyEquality.lean) proves the Cauchy–Schwarz step with its equality case.
**This file proves the rest of the argument's arithmetic**:

- `dimension_lemma` and `dimension_lemma_strict`: from `‖R‖² ≥ (n/4)²/D`, `‖W‖² ≥ 1/6` when
  `P(n, D) ≥ 0` and `‖W‖² > 1/6` when `P(n, D) > 0`, with [L47Statement.lean](L47Statement.lean)'s
  `P`, whose `P_nonneg_iff` and `weyl_floor` are the same step in divided form;
- `cert_*`: the eight family certificates, `P(n, dim 𝔥) = 3n²(n−1) − 2(7n−4) dim 𝔥 > 0` at every
  member, each with the family's parameters shifted to the record's starting rank; **generated from
  [b_symmetric_dimension_lemma.py](../../../scripts/route-b/b_symmetric_dimension_lemma.py)'s
  family table**, `ring_nf` exposing the nonnegative coefficients and the positive constant term
  that script checks;
- `exc_*`: the twelve exceptional spaces, `dim 𝔥 < bound(dim G − dim 𝔥)`, **generated from the
  script's `(dim G, dim 𝔥)` table**;
- `CPm_ge` and `HPm_gt`: `‖W‖² = 3m(m−1)/(4(m+1)(2m−1)) ≥ 1/6` on `ℂPᵐ`, with equality exactly at
  `m = 2`, and `‖W‖² = 9m(2m+1)(m−1)/(4(m+2)²(4m−1)) > 1/6` on `ℍPᵐ`, for `m ≥ 2`.

**Not typed**: that the families and the twelve pairs are the compact irreducible symmetric spaces
with their `(n, dim 𝔥)` (the classification, and the script's hard-coded dimensions), and the
rank bound `rank R ≤ dim 𝔥` (Petersen–Stanfield Proposition 2.1), which feed the display's
hypotheses.
-/

namespace HamiltonsCubic.L47Cert

/-- The cleared form `P(n, D) = 3n²(n−1) − 2(7n−4) D`, [L47Statement.lean](L47Statement.lean)'s
own, so the certificates below feed its `P_nonneg_iff` and `weyl_floor` directly. -/
noncomputable abbrev P (n D : ℝ) : ℝ := HamiltonsCubic.L47Statement.P n D

/-- The bound over `ℚ`, for the exceptional table. -/
def boundQ (n : ℚ) : ℚ := 3 * n ^ 2 * (n - 1) / (2 * (7 * n - 4))

/-- **THE DIMENSION LEMMA**: `‖R‖² ≥ (n/4)²/D`, `‖W‖² = ‖R‖² − n/(8(n−1))` and
`D ≤ 3n²(n−1)/(2(7n−4))` give `‖W‖² ≥ 1/6`, for `n ≥ 2` and `D > 0`. -/
theorem dimension_lemma (n D R2 W2 : ℝ) (hn : 2 ≤ n) (hD : 0 < D)
    (hCS : (n / 4) ^ 2 / D ≤ R2) (hW : W2 = R2 - n / (8 * (n - 1)))
    (hdim : D ≤ 3 * n ^ 2 * (n - 1) / (2 * (7 * n - 4))) : 1 / 6 ≤ W2 := by
  have hn1 : 0 < n - 1 := by linarith
  have h7 : 0 < 7 * n - 4 := by linarith
  have hP : 0 ≤ P n D := by
    unfold P HamiltonsCubic.L47Statement.P
    rw [le_div_iff₀ (by positivity)] at hdim
    nlinarith
  -- `(n/4)²/D − n/(8(n−1)) − 1/6 = P / (48 D (n−1))`
  have key : (n / 4) ^ 2 / D - n / (8 * (n - 1)) - 1 / 6 = P n D / (48 * D * (n - 1)) := by
    unfold P HamiltonsCubic.L47Statement.P; field_simp; ring
  have : 0 ≤ (n / 4) ^ 2 / D - n / (8 * (n - 1)) - 1 / 6 := by
    rw [key]; positivity
  linarith

/-- **The strict form**: `P(n, D) > 0` gives `‖W‖² > 1/6`, which is what the certificates' strictly
positive constant terms buy, and what *"equality only at `ℂP²`"* needs. -/
theorem dimension_lemma_strict (n D R2 W2 : ℝ) (hn : 2 ≤ n) (hD : 0 < D)
    (hCS : (n / 4) ^ 2 / D ≤ R2) (hW : W2 = R2 - n / (8 * (n - 1))) (hP : 0 < P n D) :
    1 / 6 < W2 := by
  have hn1 : 0 < n - 1 := by linarith
  have key : (n / 4) ^ 2 / D - n / (8 * (n - 1)) - 1 / 6 = P n D / (48 * D * (n - 1)) := by
    unfold P HamiltonsCubic.L47Statement.P; field_simp; ring
  have : 0 < (n / 4) ^ 2 / D - n / (8 * (n - 1)) - 1 / 6 := by
    rw [key]; positivity
  linarith

/-- **AIII**, Gr_C(p,q), rank p ≥ 2: `P > 0` after the shift, constant term `616`. -/
theorem cert_AIII (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    0 < P (2*(2+a)*(2+a+b)) ((2+a)^2 + (2+a+b)^2 - 1) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

/-- **BDI**, Gr_R(p,q), rank p ≥ 2: `P > 0` after the shift, constant term `48`. -/
theorem cert_BDI (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    0 < P ((2+a)*(2+a+b)) ((2+a)*((2+a)-1)/2 + (2+a+b)*((2+a+b)-1)/2) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

/-- **CII**, Gr_H(p,q), rank p ≥ 2: `P > 0` after the shift, constant term `7200`. -/
theorem cert_CII (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    0 < P (4*(2+a)*(2+a+b)) ((2+a)*(2*(2+a)+1) + (2+a+b)*(2*(2+a+b)+1)) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

/-- **AI**, SU(m)/SO(m), rank m−1 ≥ 2: `P > 0` after the shift, constant term `114`. -/
theorem cert_AI (a : ℝ) (ha : 0 ≤ a) :
    0 < P (((3+a)-1)*((3+a)+2)/2) ((3+a)*((3+a)-1)/2) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

/-- **AII**, SU(2m)/Sp(m), rank m−1 ≥ 2: `P > 0` after the shift, constant term `3696`. -/
theorem cert_AII (a : ℝ) (ha : 0 ≤ a) :
    0 < P (((3+a)-1)*(2*(3+a)+1)) ((3+a)*(2*(3+a)+1)) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

/-- **DIII**, SO(2m)/U(m), m ≥ 4: `P > 0` after the shift, constant term `2192`. -/
theorem cert_DIII (a : ℝ) (ha : 0 ≤ a) :
    0 < P ((4+a)*((4+a)-1)) ((4+a)^2) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

/-- **CI**, Sp(m)/U(m), rank m ≥ 2: `P > 0` after the shift, constant term `236`. -/
theorem cert_CI (a : ℝ) (ha : 0 ≤ a) :
    0 < P ((2+a)*((2+a)+1)) ((2+a)^2) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

/-- **II**, simple G, dim ≥ 6: `P > 0` after the shift, constant term `84`. -/
theorem cert_II (a : ℝ) (ha : 0 ≤ a) :
    0 < P ((6+a)) ((6+a)) := by
  unfold P HamiltonsCubic.L47Statement.P; ring_nf; positivity

theorem exc_EI : (36 : ℚ) < boundQ (42) := by norm_num [boundQ]

theorem exc_EII : (38 : ℚ) < boundQ (40) := by norm_num [boundQ]

theorem exc_EIII : (46 : ℚ) < boundQ (32) := by norm_num [boundQ]

theorem exc_EIV : (52 : ℚ) < boundQ (26) := by norm_num [boundQ]

theorem exc_EV : (63 : ℚ) < boundQ (70) := by norm_num [boundQ]

theorem exc_EVI : (69 : ℚ) < boundQ (64) := by norm_num [boundQ]

theorem exc_EVII : (79 : ℚ) < boundQ (54) := by norm_num [boundQ]

theorem exc_EVIII : (120 : ℚ) < boundQ (128) := by norm_num [boundQ]

theorem exc_EIX : (136 : ℚ) < boundQ (112) := by norm_num [boundQ]

theorem exc_FI : (24 : ℚ) < boundQ (28) := by norm_num [boundQ]

theorem exc_FII : (36 : ℚ) < boundQ (16) := by norm_num [boundQ]

theorem exc_G : (6 : ℚ) < boundQ (8) := by norm_num [boundQ]

/-- **`ℂPᵐ`**: `‖W‖² = 3m(m−1)/(4(m+1)(2m−1)) ≥ 1/6` for `m ≥ 2`, the difference being
`(5m−1)(m−2)/(12(m+1)(2m−1))`, zero exactly at `m = 2`. -/
theorem CPm_ge (m : ℝ) (hm : 2 ≤ m) :
    3 * m * (m - 1) / (4 * (m + 1) * (2 * m - 1)) - 1 / 6
      = (5 * m - 1) * (m - 2) / (12 * (m + 1) * (2 * m - 1))
    ∧ 1 / 6 ≤ 3 * m * (m - 1) / (4 * (m + 1) * (2 * m - 1)) := by
  have h1 : 0 < m + 1 := by linarith
  have h2 : 0 < 2 * m - 1 := by linarith
  have e : 3 * m * (m - 1) / (4 * (m + 1) * (2 * m - 1)) - 1 / 6
      = (5 * m - 1) * (m - 2) / (12 * (m + 1) * (2 * m - 1)) := by
    have n1 : m + 1 ≠ 0 := h1.ne'
    have n2 : 2 * m - 1 ≠ 0 := h2.ne'
    rw [div_sub_div _ _ (by positivity) (by norm_num), div_eq_div_iff (by positivity) (by positivity)]
    ring
  refine ⟨e, ?_⟩
  have : 0 ≤ (5 * m - 1) * (m - 2) / (12 * (m + 1) * (2 * m - 1)) := by
    apply div_nonneg _ (by positivity); nlinarith
  linarith

/-- **`ℍPᵐ`**: `‖W‖² = 9m(2m+1)(m−1)/(4(m+2)²(4m−1)) > 1/6` for `m ≥ 2`. -/
theorem HPm_gt (m : ℝ) (hm : 2 ≤ m) :
    1 / 6 < 9 * m * (2 * m + 1) * (m - 1) / (4 * (m + 2) ^ 2 * (4 * m - 1)) := by
  have h1 : 0 < 4 * m - 1 := by linarith
  rw [lt_div_iff₀ (by positivity)]
  obtain ⟨a, ha, rfl⟩ : ∃ a, 0 ≤ a ∧ m = 2 + a := ⟨m - 2, by linarith, by ring⟩
  nlinarith [mul_nonneg ha ha, mul_nonneg (mul_nonneg ha ha) ha]

/-- The record's two minima: `1/6` at `ℂP²`, `45/224` at `ℍP²`; that they are the minima over
`m ≥ 2` is [L47Statement.lean](L47Statement.lean)'s `cp_floor` and `hp_floor`. -/
theorem minima : 3 * (2 : ℝ) * (2 - 1) / (4 * (2 + 1) * (2 * 2 - 1)) = 1 / 6
    ∧ 9 * (2 : ℝ) * (2 * 2 + 1) * (2 - 1) / (4 * (2 + 2) ^ 2 * (4 * 2 - 1)) = 45 / 224 := by
  constructor <;> norm_num

end HamiltonsCubic.L47Cert
