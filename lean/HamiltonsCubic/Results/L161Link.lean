import HamiltonsCubic.Results.L161
import HamiltonsCubic.Results.L2Operators

set_option linter.style.longLine false

/-!
# L161 at the operator: `θ²` derived, not defined

[L161.lean](L161.lean) proves `θ² · trLe2 = (n−1)(2n−1)/4` with `θ²` the definition `thetaSq`, the closed form
`2(n−1)(p−1)(q−1)/((n−2)pq)`. [L2Operators.lean](L2Operators.lean)'s `theta_sq_sphere` derives that closed form
as `θ²` of the unit sphere-product operator `diagOp (t • sphereWeight S)`. This file joins the two:

* **`thetaSq_cast`**: `thetaSq p q`, cast to `ℝ`, is L2Statement's `thetaSpSq p q`;
* **`kappa_at_operator`**: at a unit sphere product with `|S| = p ≥ 2`, `|Sᶜ| = q ≥ 2`,
  `θ(W)² · trLe2 p q = (n−1)(2n−1)/4`, with `θ` the operator's own and `n = p + q`. The factor `trLe2` is L161's
  closed form, which is `tr(L_e²)` where L27's decomposition holds, `p, q ≥ 3`.

**Still owed**: `tr(L_e²)` enters as L161's closed form over L27's ten summands, and Fox's Theorem 1.3.
-/

namespace HamiltonsCubic.L161

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L2Statement HamiltonsCubic.L2Operators

/-- **`thetaSq` is `thetaSpSq`**, the same closed form over `ℚ` and over `ℝ`. -/
theorem thetaSq_cast (p q : ℕ) : ((thetaSq p q : ℚ) : ℝ) = thetaSpSq p q := by
  unfold thetaSq thetaSpSq; push_cast; ring

/-- **L161's identity with the operator's own `θ`**: `θ(W)² · trLe2 = (n−1)(2n−1)/4` at a unit sphere product, `trLe2`
being L161's closed form for `tr(L_e²)`. -/
theorem kappa_at_operator {n : ℕ} (S : Finset (Fin n)) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight S)) = 1) :
    theta (diagOp (t • sphereWeight S)) ^ 2 * ((trLe2 S.card Sᶜ.card : ℚ) : ℝ)
      = ((n : ℝ) - 1) * (2 * n - 1) / 4 := by
  have hpq : S.card + Sᶜ.card = n := by rw [Finset.card_add_card_compl, Fintype.card_fin]
  rw [theta_sq_sphere S hp hq t ht hn, ← thetaSq_cast, ← Rat.cast_mul]
  have hp' : (2 : ℚ) ≤ S.card := by exact_mod_cast hp
  have hq' : (2 : ℚ) ≤ Sᶜ.card := by exact_mod_cast hq
  rw [kappa_identity _ _ (by linarith) (by linarith) (by linarith) (by linarith) (by linarith)]
  have hn' : ((S.card : ℚ) + (Sᶜ.card : ℚ)) = (n : ℚ) := by exact_mod_cast hpq
  rw [hn']; push_cast; ring

end HamiltonsCubic.L161
