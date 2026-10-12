import Mathlib
import HamiltonsCubic.Results.L217Statement

set_option linter.style.longLine false

/-!
# L219, the reflection split, stated for a cubic form invariant under an involution

## The record's statement

[second-order.md](../../../findings/second-order.md)'s Lemma L219: *let `σ` be the action of a reflection
of `ℝⁿ` on `𝒲ₙ` and split `W = b + c` into its `σ`-even and `σ`-odd parts. Then
`P(W) = P(b) + 3⟨L_b c, c⟩` and `P(c) = 0`. If `W` is a critical point, `Q(W) = θ W`, then
`⟨L_b c, c⟩ = (θ/2)‖c‖²` and `P(b) = θ(‖b‖² - ½‖c‖²)`.*

## What is typed

**The lemma's algebra, over any real inner product space carrying a symmetric trilinear form `T`
invariant under a linear map `σ`**, with `P(x) = T x x x` and `⟨L_b c, c⟩ = T b c c`.
*The instantiation enters as hypotheses:*

* `hσ`: `T (σ x) (σ y) (σ z) = T x y z`, which holds because a reflection lies in `O(n)` and `O(n)` acts on
  `𝒲ₙ` by algebra automorphisms;
* `hb`, `hc`: `σ b = b` and `σ c = -c`, the parity split;
* `hcrit`: `T W W x = θ ⟪W, x⟫` for every `x`, criticality paired against `x`;
* `horth`: `⟪b, c⟫ = 0`, which holds because `σ` is an isometry.

**Not typed**: `𝒲ₙ`, its `T`, the reflection's action, and the corollary that `W` is coordinate-diagonal in a
frame exactly when its odd part vanishes at each of the frame's vectors.
-/

namespace HamiltonsCubic.L219Statement

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

open HamiltonsCubic.L217Statement

/-- **The odd part has zero cubic.** -/
theorem odd_cube_zero (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {c : V} (hc : σ c = -c) :
    T c c c = 0 := by
  have h := hσ c c c
  rw [hc] at h
  simp only [map_neg, LinearMap.neg_apply, neg_neg] at h
  linarith

/-- **The even square is orthogonal to the odd part.** -/
theorem even_even_odd_zero (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {b c : V} (hb : σ b = b) (hc : σ c = -c) :
    T b b c = 0 := by
  have h := hσ b b c
  rw [hb, hc] at h
  simp only [map_neg] at h
  linarith

/-- **Lemma L219, the split.** `P(b + c) = P(b) + 3 T b c c` and `P(c) = 0`. -/
theorem reflection_split (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {b c : V} (hb : σ b = b) (hc : σ c = -c) :
    T (b + c) (b + c) (b + c) = T b b b + 3 * T b c c ∧ T c c c = 0 := by
  have e := cubic_expansion T h12 h23 b c 1 1
  simp only [one_smul, one_pow, one_mul, mul_one] at e
  have hbbc := even_even_odd_zero T σ hσ hb hc
  have hccc := odd_cube_zero T σ hσ hc
  refine ⟨?_, hccc⟩
  rw [e, hbbc, hccc]
  ring

/-- **At a critical point**, `T b c c = (θ/2)‖c‖²` and `P(b) = θ(‖b‖² - ½‖c‖²)`. -/
theorem reflection_split_critical (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {b c : V} (hb : σ b = b) (hc : σ c = -c)
    {θ : ℝ} (hcrit : ∀ x, T (b + c) (b + c) x = θ * inner ℝ (b + c) x) (horth : inner ℝ b c = 0) :
    T b c c = θ / 2 * ‖c‖ ^ 2 ∧ T b b b = θ * (‖b‖ ^ 2 - ‖c‖ ^ 2 / 2) := by
  have hbbc := even_even_odd_zero T σ hσ hb hc
  have hccc := odd_cube_zero T σ hσ hc
  have hcb : inner ℝ c b = 0 := by rw [real_inner_comm]; exact horth
  have hWc := hcrit c
  have hWb := hcrit b
  simp only [map_add, LinearMap.add_apply, inner_add_left, real_inner_self_eq_norm_sq] at hWc hWb
  have s1 : T c b c = T b c c := h12 c b c
  have s2 : T b c b = T b b c := h23 b c b
  have s3 : T c b b = T b b c := by rw [h12 c b b, s2]
  have s4 : T c c b = T b c c := by rw [h23 c c b, s1]
  have hc2 : T b c c = θ / 2 * ‖c‖ ^ 2 := by
    rw [horth] at hWc
    linarith
  refine ⟨hc2, ?_⟩
  rw [hcb] at hWb
  linarith

/-- **The bound at a global maximiser, `‖c_u‖² ≤ 3/4`**, from the plane cubic. On the unit circle of
`span {b, c}` the two critical relations give `P(α b + β c) = θ (3α - α³)/2`, and the circle reaches
`α = -(1 - s²)^{-1/2}`. With `t = 1 - s²` and that `α`, global maximality `θ (3α - α³)/2 ≤ θ` forces `t ≥ 1/4`. -/
theorem odd_mass_le (θ t α : ℝ) (hθ : 0 < θ) (hα : α < 0) (hαt : α ^ 2 * t = 1)
    (hmax : θ * (3 * α - α ^ 3) / 2 ≤ θ) : 1 / 4 ≤ t := by
  have h1 : 3 * α - α ^ 3 ≤ 2 := by
    have := hmax
    nlinarith
  have h2 : -2 ≤ α := by nlinarith [sq_nonneg (α - 1)]
  have h3 : α ^ 2 ≤ 4 := by nlinarith
  have ht : 0 < t := by
    by_contra h
    push Not at h
    nlinarith [sq_nonneg α]
  nlinarith [mul_le_mul_of_nonneg_right h3 ht.le]

/-- A witness that the hypotheses are satisfiable: `T = 0`, `σ = -id`, `b = 0`, `c = 1` on `ℝ`, `θ = 0`. -/
example : True := by
  have := reflection_split_critical (V := ℝ) 0 (fun _ _ _ => rfl) (fun _ _ _ => rfl) (-LinearMap.id)
    (fun _ _ _ => rfl) (b := 0) (c := 1) (by simp) (by simp) (θ := 0) (fun _ => by simp) (by simp)
  trivial

end HamiltonsCubic.L219Statement
