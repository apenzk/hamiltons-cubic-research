import Mathlib.Tactic

/-!
# I73 sub-step (c), section 7: the gap-weighted sum and its spectral corollary

[reviews/2026-09-23-I73c-summed-pairs.md](../../../reviews/2026-09-23-I73c-summed-pairs.md), section 7.

**The claim, quoted from the note**: for every unit $W\in\mathcal W_n$ with $\theta=P(W)>0$,
$\sum_{\alpha,\beta}(\varepsilon_\alpha-\varepsilon_\beta)^2s_{\alpha\beta}=\frac{n+4}6\big[(n-1)\operatorname{tr}e^3-(n-3)\operatorname{tr}e^2\big]$,
and a unit maximiser satisfies $(n-1)\operatorname{tr}W^3\le(n-3)\theta$.

## What is typed here

* `gap_norm_sum` and `gap_sum_collapse`: the proof's two closing arithmetic steps, the summed norm and
  the collapse of the five summed pieces to $\frac{n+4}6[(n-1)E_3-(n-3)E_2]$, over the pieces as the
  note states them.
* `gram_free`: ring arithmetic only, that $-c\,pq$ and $c\,p^2$ cancel at weights $p$, $q$; the
  derivation of those two coefficients from the Gram null direction is not typed.
* `spectral_corollary`: the sum $\le0$ at $E_2=\theta^{-2}$, $E_3=t\,\theta^{-3}$ gives $(n-1)t\le(n-3)\theta$.
* **Not typed**: the five summed pieces. The two corrections need $\Phi$ and $\Omega$, which the layer
  does not define; the norm and unprojected pieces need rows (A) and (B) in eigenbasis form and the
  projection onto the Weyl module (`weylProj` and `weylProj_orth` now supply it).
-/

namespace HamiltonsCubic.Results

/-- **The summed norm**, `½·2N E₂ − 2(n−1)E₂/(n−2) − (2N E₂ − 4(n−1)E₂)/6` at `N = n(n−1)/2`. -/
theorem gap_norm_sum (n E2 : ℝ) (hn : n - 2 ≠ 0) :
    (1/2) * (2 * (n * (n - 1) / 2) * E2) - 2 * (n - 1) * E2 / (n - 2)
      - (1/6) * (2 * (n * (n - 1) / 2) * E2 - 4 * (n - 1) * E2)
      = (n - 1) * (n ^ 2 - 10) / (3 * (n - 2)) * E2 := by
  field_simp; ring

/-- **The collapse**: `U − Φ/(8(n−2)) − (3/8)Ω − ½·norm`, summed against `(x−y)²`. -/
theorem gap_sum_collapse (n E2 E3 : ℝ) (hn : n - 2 ≠ 0) :
    ((n * (n - 1) / 2) / 2 * E3 + E2) - 8 * E2 / (8 * (n - 2))
      - (3/8) * ((2/9) * ((n - 1) * (n - 8) * E3 + 4 * E2))
      - (1/2) * ((n - 1) * (n ^ 2 - 10) / (3 * (n - 2)) * E2)
      = (n + 4) / 6 * ((n - 1) * E3 - (n - 3) * E2) := by
  field_simp; ring

/-- **The Gram parameter cancels** at weights `p`, `q` on L235's two inequalities. -/
theorem gram_free (c p q : ℝ) : p * (-(c * p * q)) + q * (c * p ^ 2) = 0 := by ring

/-- **The spectral corollary**: the gap-weighted sum `≤ 0` at `E₂ = θ⁻²`, `E₃ = t θ⁻³` gives
`(n−1) t ≤ (n−3) θ`, for `n > −4` and `θ > 0`. -/
theorem spectral_corollary (n θ t : ℝ) (hn : -4 < n) (hθ : 0 < θ)
    (h : (n + 4) / 6 * ((n - 1) * (t / θ ^ 3) - (n - 3) * (1 / θ ^ 2)) ≤ 0) :
    (n - 1) * t ≤ (n - 3) * θ := by
  have h4 : 0 < (n + 4) / 6 := by linarith
  have h' : (n - 1) * (t / θ ^ 3) - (n - 3) * (1 / θ ^ 2) ≤ 0 := by
    by_contra hc; push_neg at hc; nlinarith [mul_pos h4 hc]
  have hθ3 : 0 < θ ^ 3 := by positivity
  have key : (n - 1) * (t / θ ^ 3) - (n - 3) * (1 / θ ^ 2) = ((n - 1) * t - (n - 3) * θ) / θ ^ 3 := by
    field_simp
  rw [key, div_nonpos_iff] at h'
  rcases h' with ⟨_, h2⟩ | ⟨h1, _⟩
  · linarith
  · linarith

/-- **Section 8's one-quantity lemma**: with `p I₁ + q I₂ = Γ` and `p, q > 0`, the pair `I₁ ≤ 0`,
`I₂ ≤ 0` is exactly the window `Γ/p ≤ I₁ ≤ 0`. -/
theorem pair_iff_window (p q I1 I2 Γ : ℝ) (hp : 0 < p) (hq : 0 < q) (h : p * I1 + q * I2 = Γ) :
    (I1 ≤ 0 ∧ I2 ≤ 0) ↔ (Γ / p ≤ I1 ∧ I1 ≤ 0) := by
  have hI2 : I2 = (Γ - p * I1) / q := by field_simp; linarith
  constructor
  · rintro ⟨h1, h2⟩
    refine ⟨?_, h1⟩
    rw [div_le_iff₀ hp]
    nlinarith
  · rintro ⟨h1, h2⟩
    refine ⟨h2, ?_⟩
    rw [div_le_iff₀ hp] at h1
    nlinarith

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.gap_sum_collapse    -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.spectral_corollary  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.pair_iff_window     -- [propext, Classical.choice, Quot.sound]
