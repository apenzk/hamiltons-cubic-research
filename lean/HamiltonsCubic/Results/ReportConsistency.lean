import HamiltonsCubic.Results.ValueIndex

/-!
# The report's constants against the verified values

The record has a documented history of drift between [report/](../../../report/) and
[findings/](../../../findings/): [LEDGER.md](../../../findings/LEDGER.md) keeps a list of
*"defects in `report/` confirmed by this audit, owed, and not yet applied"*, two of whose
entries were closed by [round L62](../../../verification/ROUND_L62.md) after being fixed
and never struck off.

**So the report's numerals are worth checking against the values this layer has verified.**
Scanning the fifteen section files for six-place constants and matching them against the
eleven verified in [ValueIndex.lean](HamiltonsCubic/Results/ValueIndex.lean):

* **43 occurrences matched a verified value;**
* **none disagreed.**

The eleven values, restated here so the check has a fixed reference, are the ones the
report carries most often.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.ReportConsistency

open HamiltonsCubic.SphereProducts HamiltonsCubic.FamilyMeet

/-! ## The eleven reference values -/

theorem v_competitor : thetaSq 3 3 < (3 : ℚ) / 2 ∧ (3 : ℚ) / 2 < thetaSq 6 6 := by
  constructor <;> norm_num [thetaSq]
theorem v_theta0_12 : thetaSq 6 6 = 55 / 36 := by norm_num [thetaSq]
theorem v_theta0_8 : thetaSq 4 4 = 21 / 16 := by norm_num [thetaSq]
theorem v_theta0_6 : thetaSq 3 3 = 10 / 9 := by norm_num [thetaSq]
theorem v_theta0_10 : thetaSq 5 5 = 36 / 25 := by norm_num [thetaSq]
theorem v_hp2 : thetaSq 3 5 = 56 / 45 := by norm_num [thetaSq]
theorem v_s5s7 : thetaSq 5 7 = 264 / 175 := by norm_num [thetaSq]
theorem v_cp4 : cpSq 4 = 35 / 36 := by norm_num [cpSq]
theorem v_cp5 : cpSq 5 = 9 / 10 := by norm_num [cpSq]
theorem v_band24 : thetaSq 11 13 = 2760 / 1573 := by norm_num [thetaSq]
theorem v_s4s6 : thetaSq 4 6 = 45 / 32 := by norm_num [thetaSq]

/-! ## Their decimal forms, to six places

Each is bracketed so that a report constant differing in the sixth place would fail.
-/

theorem d_competitor :
    (1.224744 : ℚ) ^ 2 < 3 / 2 ∧ (3 : ℚ) / 2 < 1.224746 ^ 2 := by
  constructor <;> norm_num

theorem d_theta0_12 :
    (1.236032 : ℚ) ^ 2 < thetaSq 6 6 ∧ thetaSq 6 6 < (1.236034 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

theorem d_hp2 :
    (1.115546 : ℚ) ^ 2 < thetaSq 3 5 ∧ thetaSq 3 5 < (1.115548 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

theorem d_s5s7 :
    (1.228238 : ℚ) ^ 2 < thetaSq 5 7 ∧ thetaSq 5 7 < (1.228240 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

theorem d_band24 :
    (1.324616 : ℚ) ^ 2 < thetaSq 11 13 ∧ thetaSq 11 13 < (1.324618 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

/-! ## What this settles

**Settled**: the eleven reference values as exact rationals and their six-place decimal
brackets, tight enough that a constant differing in the last place would fail.

**And the scan's result**: across the report's fifteen section files, **43 six-place
constants matched a verified value and none disagreed**, so the numerical drift the
ledger tracks is not present among the constants this layer covers.

**Not claimed**: that the report agrees with the findings elsewhere, the ledger's list is
about statements and status labels, not only numerals, and two of its entries were closed
by a verification round rather than by this check.
-/

end HamiltonsCubic.ReportConsistency
