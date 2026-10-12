import Mathlib
import HamiltonsCubic.Results.L61Statement
import HamiltonsCubic.Results.CP2Real
import HamiltonsCubic.Results.L50Coord

/-!
# L61's witness: `W₀`, the padded `W_{ℂP²}`, built rather than imported

[L61Statement.lean](L61Statement.lean) states `L61`, *"`√(3/2)` is the greatest value of `P` on the
unit sphere of `𝒲₅`"*, with the attainment half taken as a hypothesis `hW₀`: *"`W₀`, the
zero-padding of `W_{ℂP²}` into `𝒲₅`, is a unit Weyl tensor with `P(W₀) = √(3/2)`"*. This file
supplies it from [CP2Real.lean](CP2Real.lean)'s `Wc n`, the padded `W_{ℂP²}` on `Λ²ℝⁿ`:

* `witness`: at every `n ≥ 4`, `Wc n` is a unit Weyl tensor with `P = √(3/2)` (`Wc_weyl`,
  `Wc_values`), which is the record's *"the witness transfers up, so `M(n) ≥ √(3/2)` at every
  `n ≥ 5`"*;
* `M5_attained`: `√(3/2)` is attained on the unit sphere of `𝒲₅`, with no `sorry`;
* `L61_M5`: `L61` with its witness discharged, so the statement's only open input is
  `F5_nonneg`, the sum-of-squares certificate;
* `F5_eq_record`: on a linear Weyl operator, `F5` is the record's `(3/2)‖W‖⁶ − 9 tr(W³)²`, by
  L50's collapse at `n = 5`.
-/

namespace HamiltonsCubic.L61Witness

open HamiltonsCubic.RealLayer HamiltonsCubic.CP2Real HamiltonsCubic.L61Statement

/-- **The padded `W_{ℂP²}` at every `n ≥ 4`**: a unit Weyl tensor with `P = √(3/2)`. -/
theorem witness {n : ℕ} (hn : 4 ≤ n) :
    IsWeyl (Wc n) ∧ normSq (Wc n) = 1 ∧ Pcubic (Wc n) = Real.sqrt (3 / 2) := by
  obtain ⟨hn1, hc, hs⟩ := Wc_values hn
  refine ⟨Wc_weyl hn, hn1, ?_⟩
  unfold Pcubic
  rw [hc, hs, sqrt32]
  ring

/-- **`√(3/2)` is attained on the unit sphere of `𝒲₅`**, at `W₀ = Wc 5`. -/
theorem M5_attained :
    Real.sqrt (3 / 2) ∈ {t : ℝ | ∃ W : W5, IsWeyl W ∧ normSq W = 1 ∧ Pcubic W = t} :=
  ⟨Wc 5, witness (by norm_num)⟩

/-- **L61 with its witness built**: `M(5) = √(3/2)`, resting on `F5_nonneg` alone. -/
theorem L61_M5 :
    IsGreatest {t : ℝ | ∃ W : W5, IsWeyl W ∧ normSq W = 1 ∧ Pcubic W = t}
      (Real.sqrt (3 / 2)) :=
  L61 ⟨Wc 5, witness (by norm_num)⟩

/-- **The record's form of `F₅`**: on a linear Weyl operator at `n = 5`,
`F5 W = (3/2)‖W‖⁶ − 9 tr(W³)²`, by L50's collapse `P = 3 tr(W³)` below dimension six
(`Pcubic_collapse` in [L50Coord.lean](L50Coord.lean)). -/
theorem F5_eq_record (W : W5) (hW : IsWeylOp W) :
    F5 W = 3 / 2 * normSq W ^ 3 - 9 * trCube W ^ 2 := by
  obtain ⟨hL, hs, hy, hB, hRic⟩ := hW
  rw [F5, SecondKind.Pcubic_collapse W hL hs hy hB hRic (by simp)]
  ring

end HamiltonsCubic.L61Witness
