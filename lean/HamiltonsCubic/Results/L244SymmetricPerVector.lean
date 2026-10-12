import Mathlib

set_option linter.style.longLine false

/-!
# L244, the per-vector ceiling on a symmetric three-value critical point

## The record's statement, quoted from [second-order.md](../../../findings/second-order.md)

> At a unit Weyl critical point $W^2+W^\#=\theta W$ with eigenvalues $(-a,0,a)$, $a=1/\sqrt{2p}$, of multiplicities
> $(p,N-2p,p)$, every unit $x$ in the negative eigenspace satisfies
> $\theta\le\big(\min(\kappa_{p-1}(x),\ \kappa_p(x)-2,\ n-4)-1\big)/\sqrt{2p}$, and in particular $\theta\le(n-5)/\sqrt{2p}$.

## What is typed here

`per_vector_ceiling`: the linear-arithmetic core. The indices `0, 1, 2` label the eigenvalues `−a, 0, a`, so `E₀` is the
negative eigenspace, not the kernel. From the three per-vector rows at `x ∈ E₀`, written in
the variables `b_ab ≥ 0` and `K = θ/a + 1`, and the two source caps, `K ≤ n − 4`, `K ≤ κ₀`, `K ≤ κ₂ − 2`.
`theta_bound`: the same with `θ = a(K − 1)`.

## What is NOT typed here

**That the per-vector rows hold**: `W^# = θW − W²` as an operator identity (from `Q(𝒲ₙ) ⊆ 𝒲ₙ`, L234 step (1)),
its three consequences at every unit vector of an eigenspace, and the Ky Fan source caps. They enter as
the hypotheses `hA`, `hB`, `hC`, `h0`, `h2`, stated in the record's per-vector variables.
-/

namespace HamiltonsCubic.L244SymmetricPerVector

/-- **The core.** `hA`: row (A), `∑ b = n − 2`. `hB`: row (B) at `λ = (−a, 0, a)`, `x ∈ E₀`, divided by `a`.
`hC`: row (C), divided by `a²`, with `K = θ/a + 1`. `h0`, `h2`: the source caps from `E₀` (x in its own
kernel) and `E₂`. *Only `b00, b01, b11, b22 ≥ 0` are needed; `b02` and `b12` may have any sign.* -/
theorem per_vector_ceiling (n K κ₀ κ₂ b00 b01 b02 b11 b12 b22 : ℝ)
    (h00 : 0 ≤ b00) (h01 : 0 ≤ b01) (h11 : 0 ≤ b11) (h22 : 0 ≤ b22)
    (hA : b00 + b11 + b22 + 2 * (b01 + b02 + b12) = n - 2)
    (hB : b12 + b22 - b00 - b01 = 1)
    (hC : 2 * b02 - b00 - b22 = K)
    (h0 : 2 * (b00 + b01 + b02) ≤ κ₀)
    (h2 : 2 * (b02 + b12 + b22) ≤ κ₂) :
    K ≤ n - 4 ∧ K ≤ κ₀ ∧ K ≤ κ₂ - 2 := by
  refine ⟨by linarith, by linarith, by linarith⟩

/-- **The ceiling's equality case**: under L244's rows, `K = n − 4` exactly when
`b00 = b01 = b11 = 0`, i.e. `[E₀, E₀ ⊕ E₁]` has no `E₀` component along `x` and neither has
`[E₁, E₁]`. -/
theorem ceiling_equality (n K b00 b01 b02 b11 b12 b22 : ℝ)
    (h00 : 0 ≤ b00) (h01 : 0 ≤ b01) (h11 : 0 ≤ b11)
    (hA : b00 + b11 + b22 + 2 * (b01 + b02 + b12) = n - 2)
    (hB : b12 + b22 - b00 - b01 = 1)
    (hC : 2 * b02 - b00 - b22 = K) :
    K = n - 4 ↔ b00 = 0 ∧ b01 = 0 ∧ b11 = 0 := by
  constructor
  · intro hK
    refine ⟨by linarith, by linarith, by linarith⟩
  · rintro ⟨e0, e1, e2⟩
    linarith

/-- **The ceiling on `θ`**, with `θ = a(K − 1)` and `a > 0`. -/
theorem theta_bound (n a θ K κ₀ κ₂ : ℝ) (ha : 0 < a) (hK : θ = a * (K - 1))
    (h : K ≤ n - 4 ∧ K ≤ κ₀ ∧ K ≤ κ₂ - 2) :
    θ ≤ a * (n - 5) ∧ θ ≤ a * (κ₀ - 1) ∧ θ ≤ a * (κ₂ - 3) := by
  obtain ⟨h1, h2, h3⟩ := h
  refine ⟨?_, ?_, ?_⟩ <;> rw [hK] <;> nlinarith

/-- **At `n = 12` the symmetric family is excluded above `θ₀(12)` once `p ≥ 17`**: `θ ≤ 7/√(2p)` and
`49/(2·17) < 220/144 = θ₀(12)²`. -/
theorem p17_excluded : (49 : ℚ) / (2 * 17) < 220 / 144 := by norm_num

/-- **And not at `p = 16`**: `49/32 ≥ 220/144`, so the `x`-free bound alone stops there. -/
theorem p16_not_excluded : (220 : ℚ) / 144 ≤ 49 / 32 := by norm_num

/-! ## The star window, at every `n` (fence post F77)

At a decomposable unit `x` the eigenvalues of `−ad_x²` are `1` with multiplicity `2(n − 2)` and `0`
otherwise, so `κ_r = r` for `r ≤ 2(n − 2)`. With `x ∈ E₀ = e ∧ U`, `dim U = p`, the caps read
`κ₀ = p − 1`, `κ₂ = p`, and the union caps `2p − 1`, `2(n − 2)`, `2(n − 2)`. The witness below meets every
row and every cap, single and union, at `K = p − 2`, i.e. `θ = (p − 3)/√(2p)`. -/

theorem star_window_feasible (n p : ℝ) (hp : 2 ≤ p) (hn : p ≤ n - 2) :
    let b00 : ℝ := 0; let b01 : ℝ := 0; let b02 : ℝ := (p - 2) / 2
    let b11 : ℝ := n - 4 - (p - 2); let b12 : ℝ := 1; let b22 : ℝ := 0; let K := p - 2
    (0 ≤ b00 ∧ 0 ≤ b01 ∧ 0 ≤ b02 ∧ 0 ≤ b11 ∧ 0 ≤ b12 ∧ 0 ≤ b22) ∧
    b00 + b11 + b22 + 2 * (b01 + b02 + b12) = n - 2 ∧
    b12 + b22 - b00 - b01 = 1 ∧ 2 * b02 - b00 - b22 = K ∧
    2 * (b00 + b01 + b02) ≤ p - 1 ∧ 2 * (b02 + b12 + b22) ≤ p ∧
    2 * ((b00 + b01 + b02) + (b02 + b12 + b22)) ≤ 2 * p - 1 ∧
    2 * ((b00 + b01 + b02) + (b01 + b11 + b12)) ≤ 2 * (n - 2) ∧
    2 * ((b01 + b11 + b12) + (b02 + b12 + b22)) ≤ 2 * (n - 2) := by
  intro b00 b01 b02 b11 b12 b22 K
  refine ⟨⟨le_refl _, le_refl _, by simp only [b02]; linarith, by simp only [b11]; linarith,
    zero_le_one, le_refl _⟩, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    simp only [b00, b01, b02, b11, b12, b22, K] <;> linarith

/-- **The window's ceiling beats `θ₀(n)` at every `n` once `p ≥ 9`**: `(p − 3)² ≥ 4p` since
`(p − 3)² − 4p = (p − 1)(p − 9)`, and `θ₀(n)² = 2(n − 1)(n − 2)/n² < 2`, so
`((p − 3)/√(2p))² ≥ 2 > θ₀(n)²`. -/
theorem star_window_beats_theta0 (n p : ℝ) (hp : 9 ≤ p) (hn : 2 ≤ n) :
    2 * p * (2 * (n - 1) * (n - 2) / n ^ 2) < (p - 3) ^ 2 := by
  have hn0 : 0 < n ^ 2 := by positivity
  have h1 : 2 * (n - 1) * (n - 2) / n ^ 2 < 2 := by
    rw [div_lt_iff₀ hn0]; nlinarith
  nlinarith [mul_lt_mul_of_pos_left h1 (by linarith : (0:ℝ) < 2 * p)]

/-- **And L245 admits the star when `2p ≤ n − 1`**; the window `9 ≤ p ≤ (n − 1)/2` is non-empty from
`n = 19`. -/
example : (2 : ℝ) * 9 ≤ 19 - 1 := by norm_num

end HamiltonsCubic.L244SymmetricPerVector
