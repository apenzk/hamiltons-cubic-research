import Mathlib.Tactic

/-!
# L237's exact ceiling on L173's ray, as a dual certificate

[findings/second-order.md](../../../findings/second-order.md), Lemma L237, and section 9 of
[the summed-pair note](../../../reviews/2026-09-23-I73c-summed-pairs.md).

On L173's ray the values are `ν = a·(−1, 0, 4/3)` with multiplicities `(4, K, 3)`, `K` the kernel. In
units of `a` (`u = θ/a`), the reduced rows of [L104](../../../findings/bounds-relaxations.md) for the
negative class read, with `μ = (3, K, 3)` in that row,

* (B₀) `−6 t₀₀₀ − 3K t₀₀K + 3 t₀₀₂ + 4K t₀K₂ + 8 t₀₂₂ = 2`,
* (C₀) `6 t₀₀₀ − 24 t₀₀₂ + (32/3) t₀₂₂ = −2(u + 1)`,

and the Ky Fan cap with three own-class and three positive-class partners is
`3P₀₀ + 3P₀₂ = 6 t₀₀₀ + 3K t₀₀K + 18 t₀₀₂ + 3K t₀K₂ + 6 t₀₂₂ ≤ κ`. The theorem is the certificate:
`u ≤ −15/7 + 16κ/21`, so `κ = κ₆ = 8` gives `θ ≤ (83/21)a = 83√21/294`, and `κ = 12`, the bare pair
caps, returns L173's `7a`. **The kernel size `K` enters only with nonnegative multipliers**, which is
why the ceiling does not depend on `n`.

**Not typed**: the derivation of the rows from L104 at this spectrum and of the cap from L237's
lemma; the arithmetic of both is written out above and in the note.
-/

namespace HamiltonsCubic.Results

theorem l237_ray_certificate (K u κ t000 t00K t002 t0KK t0K2 t022 : ℝ)
    (hK : 0 ≤ K) (h000 : 0 ≤ t000) (h00K : 0 ≤ t00K) (h002 : 0 ≤ t002) (h0K2 : 0 ≤ t0K2)
    (h022 : 0 ≤ t022)
    (hB : -6 * t000 - 3 * K * t00K + 3 * t002 + 4 * K * t0K2 + 8 * t022 = 2)
    (hC : 6 * t000 - 24 * t002 + 32 / 3 * t022 = -2 * (u + 1))
    (hcap : 6 * t000 + 3 * K * t00K + 18 * t002 + 3 * K * t0K2 + 6 * t022 ≤ κ) :
    u ≤ -15 / 7 + 16 / 21 * κ := by
  have p1 : 0 ≤ K * t00K := mul_nonneg hK h00K
  have p2 : 0 ≤ K * t0K2 := mul_nonneg hK h0K2
  nlinarith

/-- **At `κ = κ₆ = 8` the ceiling is `83/21` in units of `a`.** -/
theorem l237_ray_ceiling : (-15 / 7 + 16 / 21 * 8 : ℝ) = 83 / 21 := by norm_num

/-- **And at the bare pair caps, `κ = 12`, it returns L173's `7`.** -/
theorem l237_ray_bare : (-15 / 7 + 16 / 21 * 12 : ℝ) = 7 := by norm_num

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.l237_ray_certificate
