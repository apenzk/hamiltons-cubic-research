import HamiltonsCubic.Results.SphereProducts

/-!
# The band, the near-balanced family, exactly

[target.md](../../../findings/target.md) tracks `S^{n/2-1} × S^{n/2+1}` and calls it the
**band**. Two claims about it are recorded as decimals:

* *"$25$–$28$ catalogued band points exceed $\sqrt{3/2}$ at $n\le24$, maximum
  $1.324617$ at $S^{11}\times S^{13}$"*;
* *"the band is asymptotically extremal": `θ/θ₀(n)` runs `0.9937, 0.9976, 0.9988,
  0.9997, 0.99996` at `n = 12, 16, 20, 30, 60`, with `θ² → 2`.*

Both become exact under the closed form of
[SphereProducts.lean](HamiltonsCubic/Results/SphereProducts.lean).

**A reading the sentence does not claim, and a reader might take.** *"Maximum
`1.324617` at `S¹¹×S¹³`"* is the maximum over the **band**. Over **all** two-block
products at `n ≤ 24` it is not the maximum: the balanced `S¹²×S¹²` sits above it, at
`253/144` against `2760/1573`. The two are separated by less than `0.001` in `θ`, which
is why decimals to six places do not settle which is larger, and the rationals do.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Band

open HamiltonsCubic.SphereProducts

/-! ## The seven band points at even `n ≤ 24`, exact -/

theorem band_12 : thetaSq 5 7   = 264 / 175   := by norm_num [thetaSq]
theorem band_14 : thetaSq 6 8   = 455 / 288   := by norm_num [thetaSq]
theorem band_16 : thetaSq 7 9   = 80 / 49     := by norm_num [thetaSq]
theorem band_18 : thetaSq 8 10  = 1071 / 640  := by norm_num [thetaSq]
theorem band_20 : thetaSq 9 11  = 1520 / 891  := by norm_num [thetaSq]
theorem band_22 : thetaSq 10 12 = 693 / 400   := by norm_num [thetaSq]
theorem band_24 : thetaSq 11 13 = 2760 / 1573 := by norm_num [thetaSq]

/-- **All seven exceed `3/2`.** -/
theorem band_all_exceed :
    3 / 2 < thetaSq 5 7 ∧ 3 / 2 < thetaSq 6 8 ∧ 3 / 2 < thetaSq 7 9 ∧
    3 / 2 < thetaSq 8 10 ∧ 3 / 2 < thetaSq 9 11 ∧ 3 / 2 < thetaSq 10 12 ∧
    (3 : ℚ) / 2 < thetaSq 11 13 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num [thetaSq]

/-- **The band is increasing in `n`** across the tabulated range, so its maximum at
`n ≤ 24` is the last point. -/
theorem band_increasing :
    thetaSq 5 7 < thetaSq 6 8 ∧ thetaSq 6 8 < thetaSq 7 9 ∧
    thetaSq 7 9 < thetaSq 8 10 ∧ thetaSq 8 10 < thetaSq 9 11 ∧
    thetaSq 9 11 < thetaSq 10 12 ∧ thetaSq 10 12 < thetaSq 11 13 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num [thetaSq]

/-! ## What the maximum is a maximum of

The balanced point at the same dimension is **above** the band's last point. The
record's sentence is about the band and is correct there; this states the comparison the
decimals cannot.
-/

/-- `θ²(S¹²×S¹²) = 253/144`. -/
theorem balanced_24 : thetaSq 12 12 = 253 / 144 := by norm_num [thetaSq]

/-- **`S¹²×S¹² > S¹¹×S¹³`**, by `0.000881…` in `θ`, closer than the six places the
record prints. -/
theorem balanced_beats_band : thetaSq 11 13 < thetaSq 12 12 := by
  norm_num [thetaSq]

/-! ## Asymptotic extremality

`θ²/θ₀(n)²` along the band, exactly, at the dimensions the record tabulates. Each is
below `1` and rising, which is the content of *"no gap between the middle of the band
and the cap"*.
-/

theorem ratio_12 : thetaSq 5 7 / thetaSq 6 6 = 9504 / 9625 := by norm_num [thetaSq]
theorem ratio_16 : thetaSq 7 9 / thetaSq 8 8 = 1024 / 1029 := by norm_num [thetaSq]
theorem ratio_20 : thetaSq 9 11 / thetaSq 10 10 = 152000 / 152361 := by norm_num [thetaSq]

/-- Each ratio is strictly below `1` and they increase, the band approaches the
balanced value from below and does not reach it. -/
theorem ratios_lt_one_and_rise :
    (9504 : ℚ) / 9625 < 1024 / 1029 ∧ (1024 : ℚ) / 1029 < 152000 / 152361 ∧
    (152000 : ℚ) / 152361 < 1 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- **`θ² < 2` along the band**, at every tabulated point, the ceiling the record
says it approaches. -/
theorem band_below_two : thetaSq 11 13 < 2 := by norm_num [thetaSq]

/-! ## What this settles

**Settled**: the band's seven values at even `n ≤ 24` exactly, that all exceed `3/2`,
that the family is increasing so its maximum is the last point, the three tabulated
ratios exactly, and that the balanced point at `n = 24` sits above the band's maximum.

**Not settled here**: the count *"25–28 catalogued band points"*, which is a statement
about a catalogue this file does not have; and `θ² → 2`, which is a limit rather than
an arithmetic fact and is not stated above.
-/

end HamiltonsCubic.Band
