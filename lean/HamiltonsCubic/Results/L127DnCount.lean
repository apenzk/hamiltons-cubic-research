import HamiltonsCubic.Results.L127DnDim

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` count: the six family dimensions sum to `dim 𝒟ₙ`

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnDim.lean](L127DnDim.lean) gives the
six families' dimensions. This file adds them up:

* **`dn_dim_sum`**: `1 + (p − 1) + (q − 1) + (p − 1)(q − 1) + (binom p 2 − p) + (binom q 2 − q) = binom n 2 − n` at
  `p, q ≥ 3`, `n = p + q`, so `0^{rest}` counts `p(p − 3)/2 + q(q − 3)/2`;
* **`dn_finrank_sum`**: the six families' dimensions, as declared, sum to the dimension of `𝒟ₙ`'s weights
  (L120DiagDim's `finrank_weights`).
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The six dimensions sum to `binom n 2 − n`.** -/
theorem dn_dim_sum {p q : ℕ} (hp : 3 ≤ p) (hq : 3 ≤ q) :
    1 + (p - 1) + (q - 1) + (p - 1) * (q - 1) + (p.choose 2 - p) + (q.choose 2 - q) = (p + q).choose 2 - (p + q) := by
  have hP := two_mul_choose_two_sub hp
  have hQ := two_mul_choose_two_sub hq
  have hN := two_mul_choose_two_sub (show 3 ≤ p + q by omega)
  obtain ⟨a, rfl⟩ : ∃ a, p = a + 3 := ⟨p - 3, by omega⟩
  obtain ⟨b, rfl⟩ : ∃ b, q = b + 3 := ⟨q - 3, by omega⟩
  rw [show a + 3 - 3 = a by omega] at hP
  rw [show b + 3 - 3 = b by omega] at hQ
  rw [show a + 3 + (b + 3) - 3 = a + b + 3 by omega] at hN
  rw [show a + 3 - 1 = a + 2 by omega, show b + 3 - 1 = b + 2 by omega]
  apply Nat.eq_of_mul_eq_mul_left (show 0 < 2 by norm_num)
  rw [hN, mul_add, mul_add, mul_add, mul_add, mul_add, hP, hQ]
  ring

/-- **The declared dimensions sum to `dim 𝒟ₙ`**: at `p, q ≥ 3` the six families' dimensions sum to that of the weights. -/
theorem dn_finrank_sum (T : Finset ι) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) :
    Module.finrank ℝ (Submodule.span ℝ {sphereWeight T}) + Module.finrank ℝ (LinearMap.range (lamMap T (dnK T)))
      + Module.finrank ℝ (LinearMap.range (lamMap Tᶜ (dnK Tᶜ))) + Module.finrank ℝ (crossSub T)
      + Module.finrank ℝ (withinSub T) + Module.finrank ℝ (withinSub Tᶜ)
      = Module.finrank ℝ (LinearMap.ker (rowSumL (ι := ι))) := by
  have hn : T.card + Tᶜ.card = Fintype.card ι := by rw [Finset.card_add_card_compl]
  rw [finrank_sphereLine T (by omega) (by omega), finrank_lam T _ hp, finrank_lam Tᶜ _ hq,
    finrank_crossSub T (by omega) (by omega), finrank_withinSub T hp, finrank_withinSub Tᶜ hq,
    finrank_weights (by omega), ← hn, ← dn_dim_sum hp hq]

end HamiltonsCubic.Results
