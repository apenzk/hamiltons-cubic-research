import HamiltonsCubic.Results.L44Statement
import HamiltonsCubic.Results.CP2Real

set_option linter.style.longLine false

/-!
# L44's witness, discharged

[L44Statement.lean](L44Statement.lean)'s `L44_elementary` takes the padded `ℂP²` value as the binder
`hwitness`: a unit Weyl `W` on `ℝⁿ` with `P(W) = √(3/2)`. [CP2Real.lean](CP2Real.lean) proves it in the
same `RealLayer` types, `Wc_weyl`, `Wc_values` and `Wc_theta`, at every `n ≥ 4`. So the elementary route runs
with no imported value.

* **`witness`**: the zero-padded `ℂP²` operator `Wc n` is Weyl, of unit norm, with `P = √(3/2)`;
* **`L44_heading`**: at every `4 ≤ n ≤ 11`, a unit Weyl tensor has `θ²` strictly above the maximum `Θₙ²` of
  `θ(S^p × S^q)²` over the splits `p + q = n`, so the conjecture's conclusion fails there.

The cone conclusion, `Ω₀` non-invariant for `4 ≤ n ≤ 11`, stays with the record: `Ω₀`, `F`, `Φ` and
Böhm–Wilking's criterion have no base layer.
-/

namespace HamiltonsCubic.L44Witness

open HamiltonsCubic.RealLayer HamiltonsCubic.CP2Real HamiltonsCubic.L44Statement

/-- **The padded `ℂP²` witness**, proved: unit, Weyl, and `P = √(3/2)`. -/
theorem witness {n : ℕ} (hn : 4 ≤ n) :
    IsWeyl (Wc n) ∧ normSq (Wc n) = 1 ∧ Pcubic (Wc n) = Real.sqrt (3 / 2) := by
  have hW := Wc_weyl hn
  have hv := Wc_values hn
  have ht := Wc_theta hn
  refine ⟨hW, hv.1, ?_⟩
  unfold theta HamiltonsCubic.RealLayer.norm at ht
  rwa [hv.1, Real.sqrt_one, one_pow, div_one] at ht

/-- **L44's heading, with no imported value**: at every `4 ≤ n ≤ 11`, some unit Weyl tensor has `θ²` above
the best sphere product's. -/
theorem L44_heading {n : ℕ} (h4 : 4 ≤ n) (h11 : n ≤ 11) (M : ℝ)
    (hub : ∀ p q : ℕ, 2 ≤ p → 2 ≤ q → p + q = n → thetaSpSq p q ≤ M)
    (hatt : ∃ p q : ℕ, 2 ≤ p ∧ 2 ≤ q ∧ p + q = n ∧ thetaSpSq p q = M) :
    ∃ W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ,
      IsWeyl W ∧ normSq W = 1 ∧ M < Pcubic W ^ 2 :=
  L44_elementary h4 h11 M hub hatt ⟨Wc n, witness h4⟩

end HamiltonsCubic.L44Witness
