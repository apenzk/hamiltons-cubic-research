import HamiltonsCubic.Results.L27

set_option linter.style.longLine false

/-!
# L161, `κ_n = (n−1)(2n−1)/4` at every `n ≥ 6`: the identity

[findings/curvature-invariants.md](../../../findings/curvature-invariants.md), Lemma L161: with
`L_e`'s spectrum at `W_{p,q}` read off [L27](L27.lean)'s ten summands,
`tr(L_e²) = 1 + pq/4 + d_p λ_p² + d_q λ_q² + (d_p d_q + e_p e_q) μ²`, and multiplying by
`θ² = 2(n−1)(p−1)(q−1)/((n−2)pq)` gives `(p+q−1)(2(p+q)−1)/4` **identically in `p, q`**.

**Proved here**: `kappa_identity`, that rational-function identity over `ℚ`, with `μ` L26's
`(n−2)/(2(p−1)(q−1))` (`mu_eq_L26` in L27.lean) and `d_m`, `e_m`, `λ_m` L27's `dimS`, `dimL`, `lam`;
and `kappa_split_free`: two splits of the same `n` give the same value, the consistency Fox's
`W`-independence predicts. Fox's theorem is what licenses the unbalanced split at odd `n`.

**Not typed**: Fox's Theorem 1.3, that `tr(L_x L_y) = κ_n⟨x, y⟩` with `κ_n` independent of `W`, and
the spectrum of `L_e` on the ten summands, which is [L27](L27.lean)'s representation theory.
-/

namespace HamiltonsCubic.L161

open HamiltonsCubic.L27

/-- `tr(L_e²)` at `W_{p,q}` from the ten eigenvalues and their multiplicities. -/
def trLe2 (p q : ℚ) : ℚ :=
  1 + p * q / 4 + dimS p * lam p ^ 2 + dimS q * lam q ^ 2
    + (dimS p * dimS q + dimL p * dimL q) * HamiltonsCubic.L26Statement.mu p q ^ 2

/-- `θ²` at `S^p × S^q`. -/
def thetaSq (p q : ℚ) : ℚ := 2 * (p + q - 1) * (p - 1) * (q - 1) / ((p + q - 2) * (p * q))

/-- **`θ² · tr(L_e²) = (n−1)(2n−1)/4`**, identically in `p, q`. -/
theorem kappa_identity (p q : ℚ) (hp : p ≠ 0) (hq : q ≠ 0) (hp1 : p - 1 ≠ 0) (hq1 : q - 1 ≠ 0)
    (hn : p + q - 2 ≠ 0) :
    thetaSq p q * trLe2 p q = (p + q - 1) * (2 * (p + q) - 1) / 4 := by
  unfold thetaSq trLe2 lam dimS dimL HamiltonsCubic.L26Statement.mu
  field_simp
  ring

/-- **The value depends on `n = p + q` alone**, so an unbalanced split at odd `n` reads the same
`κ_n` a balanced one would. -/
theorem kappa_split_free (p q p' q' : ℚ) (h : p + q = p' + q')
    (hp : p ≠ 0) (hq : q ≠ 0) (hp1 : p - 1 ≠ 0) (hq1 : q - 1 ≠ 0) (hn : p + q - 2 ≠ 0)
    (hp' : p' ≠ 0) (hq' : q' ≠ 0) (hp1' : p' - 1 ≠ 0) (hq1' : q' - 1 ≠ 0) :
    thetaSq p q * trLe2 p q = thetaSq p' q' * trLe2 p' q' := by
  rw [kappa_identity p q hp hq hp1 hq1 hn, kappa_identity p' q' hp' hq' hp1' hq1' (h ▸ hn), h]

/-- At `n = 13`, inside the audited range `4 ≤ n ≤ 13`: `κ₁₃ = 75`. The first odd `n` the lemma
newly covers is `15`. -/
theorem kappa_13 : thetaSq 3 10 * trLe2 3 10 = 75 := by
  rw [kappa_identity 3 10 (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by norm_num)]
  norm_num

end HamiltonsCubic.L161
