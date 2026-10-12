import Mathlib.Tactic

/-!
# Lemma L214, the frame split, typed as vector algebra

[findings/second-order.md](../../../findings/second-order.md), the L214 block.

**What the block says.** Split a unit critical point `W = D + N` in an arbitrary orthonormal
frame, `D` its coordinate-diagonal part, `t = ‖D‖²`, `a = ⟪D ∘ N, N⟫`. Then `θ t = P D + a` and
`θ (1-t) = 2a + P N`, and at a maximiser `a ≥ (θ/2) t (1-t)`.

## What is typed here, and what typing revealed

The polarisation `T x y z = ⟪x ∘ y, z⟫` is a **totally symmetric** trilinear form, so this file
works with `T` directly, over an arbitrary real module, with symmetry as two transposition
hypotheses. Criticality enters in its paired form, `T W W x = θ ⟪W, x⟫` for every `x`, and the
pairing `ip` is symmetric.

**TYPING FOUND THAT THE BLOCK'S TWO FRAME INPUTS ARE ONE SCALAR.** *The block quotes both
`D ∘ D ∈ 𝒟ₙ`, hence `⟪D ∘ D, N⟫ = 0`, and `π_F (D ∘ N) = 0`, hence `⟪D ∘ N, D⟫ = 0`. Total
symmetry makes those the same number, `T D D N`, so each of the two consequences of
[L120](../../../findings/second-order.md) proves the whole requirement on its own.* The
hypothesis here is `hperp : T D D N = 0`, once.

- `rel_one` and `rel_two` are the two relations.
- `cross_cancel` is **the step a reader must check**: `T W X X = θ t (1-t) - a` for
  `X = t • N - (1-t) • D`, with the coefficient of `a` collapsing to `-1`.
- `test_perp` and `test_norm` give `X ⊥ W` and `‖X‖² = t(1-t)`.
- `maximiser_ineq` closes [L24](../../../findings/second-order.md)'s cap into the inequality.

*Nothing here is specific to `𝒲ₙ`, the Fox product or Hamilton's `Q`.* **Not typed**: that `𝒟ₙ`
is the `Γ`-fixed subspace and that `L_D` preserves the isotypic summands, which is L120 and needs
the sign group; and L24's cap, which is the Hessian computation. Both enter as hypotheses, which
is where the block's own debts are.
-/

namespace HamiltonsCubic.Results

variable {V : Type*} [AddCommGroup V] [Module ℝ V]
  (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ) (ip : V →ₗ[ℝ] V →ₗ[ℝ] ℝ) (D N : V) (θ t : ℝ)

/-- The expansion of `T (D+N) (D+N) x`, used by both relations. -/
theorem expand_pair (hs12 : ∀ x y z : V, T x y z = T y x z) (x : V) :
    T (D + N) (D + N) x = T D D x + 2 * T D N x + T N N x := by
  simp only [map_add, LinearMap.add_apply]
  rw [hs12 N D x]
  ring

/-- `T D N D` and `T N N D` in terms of the two scalars the relations use. -/
theorem perm_values (hs12 : ∀ x y z : V, T x y z = T y x z)
    (hs23 : ∀ x y z : V, T x y z = T x z y) :
    T D N D = T D D N ∧ T N N D = T D N N := by
  refine ⟨by rw [hs23 D N D], ?_⟩
  rw [hs12 N N D, hs23 N N D, hs12 N D N]

/-- **RELATION ONE.** Pairing criticality with `D` gives `θ t = T D D D + T D N N`. *The single
frame input `hperp` kills the only cross term.* -/
theorem rel_one (hs12 : ∀ x y z : V, T x y z = T y x z)
    (hs23 : ∀ x y z : V, T x y z = T x z y)
    (hipsymm : ∀ x y : V, ip x y = ip y x)
    (hcrit : ∀ x : V, T (D + N) (D + N) x = θ * ip (D + N) x)
    (hDN : ip D N = 0) (ht : ip D D = t) (hperp : T D D N = 0) :
    θ * t = T D D D + T D N N := by
  have h := hcrit D
  rw [expand_pair T D N hs12 D] at h
  obtain ⟨e1, e2⟩ := perm_values T D N hs12 hs23
  rw [e1, e2, hperp] at h
  have hWD : ip (D + N) D = t := by
    simp only [map_add, LinearMap.add_apply]
    rw [ht, hipsymm N D, hDN, add_zero]
  rw [hWD] at h
  linarith [h]

/-- **RELATION TWO.** Pairing criticality with `N` gives `θ (1-t) = 2 T D N N + T N N N`. -/
theorem rel_two (hs12 : ∀ x y z : V, T x y z = T y x z)
    (hipsymm : ∀ x y : V, ip x y = ip y x)
    (hcrit : ∀ x : V, T (D + N) (D + N) x = θ * ip (D + N) x)
    (hDN : ip D N = 0) (htN : ip N N = 1 - t) (hperp : T D D N = 0) :
    θ * (1 - t) = 2 * T D N N + T N N N := by
  have h := hcrit N
  rw [expand_pair T D N hs12 N] at h
  rw [hperp] at h
  have hWN : ip (D + N) N = 1 - t := by
    simp only [map_add, LinearMap.add_apply]
    rw [htN, hDN, zero_add]
  rw [hWN] at h
  linarith [h]

/-- **The test vector is orthogonal to `W`.** -/
theorem test_perp (hipsymm : ∀ x y : V, ip x y = ip y x)
    (hDN : ip D N = 0) (ht : ip D D = t) (htN : ip N N = 1 - t) :
    ip (t • N - (1 - t) • D) (D + N) = 0 := by
  simp only [map_sub, map_smul, LinearMap.sub_apply, LinearMap.smul_apply, map_add,
    LinearMap.add_apply, smul_eq_mul]
  rw [ht, htN, hDN, hipsymm N D, hDN]
  ring

/-- **And its norm is `t(1-t)`.** -/
theorem test_norm (hipsymm : ∀ x y : V, ip x y = ip y x)
    (hDN : ip D N = 0) (ht : ip D D = t) (htN : ip N N = 1 - t) :
    ip (t • N - (1 - t) • D) (t • N - (1 - t) • D) = t * (1 - t) := by
  simp only [map_sub, map_smul, LinearMap.sub_apply, LinearMap.smul_apply, smul_eq_mul]
  rw [ht, htN, hDN, hipsymm N D, hDN]
  ring

/-- **THE CANCELLATION, WHICH IS THE STEP TO CHECK.** For `X = t • N - (1-t) • D`,
`T W X X = θ t (1-t) - T D N N`.

*Expanding gives `T D N N (3t² - 2t) + (1-t)² T D D D + t² T N N N`, and substituting the two
relations collapses the coefficient of `T D N N` from `3t² - 2t - (1-t)² - 2t²` to `-1`, leaving
`θ t (1-t)² + θ t² (1-t) = θ t (1-t)`.* -/
theorem cross_cancel (hs12 : ∀ x y z : V, T x y z = T y x z)
    (hs23 : ∀ x y z : V, T x y z = T x z y)
    (hperp : T D D N = 0)
    (hr1 : θ * t = T D D D + T D N N)
    (hr2 : θ * (1 - t) = 2 * T D N N + T N N N) :
    T (D + N) (t • N - (1 - t) • D) (t • N - (1 - t) • D) = θ * (t * (1 - t)) - T D N N := by
  obtain ⟨e1, e2⟩ := perm_values T D N hs12 hs23
  have e3 : T N D N = T D N N := by rw [hs12 N D N]
  have e4 : T N D D = T D D N := by rw [hs12 N D D]; exact e1
  simp only [map_add, map_sub, map_smul, LinearMap.add_apply, LinearMap.sub_apply,
    LinearMap.smul_apply, smul_eq_mul]
  rw [e1, e2, e3, e4, hperp]
  linear_combination (-(1 - t) ^ 2) * hr1 - t ^ 2 * hr2

/-- **THE BLOCK'S INEQUALITY**, from [L24](../../../findings/second-order.md)'s cap evaluated at
the test vector. -/
theorem maximiser_ineq
    (hcancel : T (D + N) (t • N - (1 - t) • D) (t • N - (1 - t) • D)
      = θ * (t * (1 - t)) - T D N N)
    (hcap : T (D + N) (t • N - (1 - t) • D) (t • N - (1 - t) • D) ≤ θ / 2 * (t * (1 - t))) :
    θ / 2 * (t * (1 - t)) ≤ T D N N := by
  rw [hcancel] at hcap
  linarith

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.expand_pair
#print axioms HamiltonsCubic.Results.perm_values
#print axioms HamiltonsCubic.Results.rel_one
#print axioms HamiltonsCubic.Results.rel_two
#print axioms HamiltonsCubic.Results.test_perp
#print axioms HamiltonsCubic.Results.test_norm
#print axioms HamiltonsCubic.Results.cross_cancel
#print axioms HamiltonsCubic.Results.maximiser_ineq
