import HamiltonsCubic.Base.WeylReal

/-!
# The sharp form vanishes on the kernel at a critical point

**What this is for.** [L197](../../../findings/target.md) reads Hamilton's strong maximum principle
in Wilking's Lie-algebraic form, `⟨R# x, y⟩ = -½ tr(ad_x R ad_y R)`, and observes that the step
needing `R ≥ 0` is the SIGN of `R#(v,v)` at `v ∈ ker R`. *Criticality supplies the equality case
instead, with no sign hypothesis.*

**This file carries the elementary half**: from `Q(W) = θ·W`, pairing against a kernel vector kills
the `W²` term and the right-hand side together, so the sharp form vanishes there. *That is the whole
of the step, and it needs no positivity, no cone and no flow.*

**WHAT IT DOES NOT COVER**: that `⟨W# v, v⟩` equals `-½tr((ad_v W)²)`, which is Wilking's definition
and would need `ad` on `Λ² ≅ 𝔰𝔬(n)` tied to the record's `sharpBil`; nor the norm-balance reading;
nor anything about rank. *The geometry enters only where those are supplied.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **At a critical point the kernel is contained in the sharp form's kernel.**

*Criticality is `Q(W) = θ·W`, that is `W² + W^# = θ W` as operators.* At `v` with `W v = 0` the
square term and the right-hand side both vanish, so `W^# v = 0`, **not merely that it pairs to zero
against `v`**, which is what a first reading of the mechanism gives. -/
theorem sharp_kernel_of_crit
    (W sharp : E →ₗ[ℝ] E) (θ : ℝ) (v : E)
    (hcrit : ∀ x, W (W x) + sharp x = θ • W x)
    (hker : W v = 0) :
    sharp v = 0 := by
  have h := hcrit v
  rw [hker, map_zero, zero_add, smul_zero] at h
  exact h

/-- The pairing consequence, which is the form the bracket identity is read in. -/
theorem sharp_pairing_zero_of_crit
    (W sharp : E →ₗ[ℝ] E) (θ : ℝ) (v : E)
    (hcrit : ∀ x, W (W x) + sharp x = θ • W x)
    (hker : W v = 0) :
    ⟪sharp v, v⟫ = 0 := by
  rw [sharp_kernel_of_crit W sharp θ v hcrit hker, inner_zero_left]

end HamiltonsCubic.RealLayer
