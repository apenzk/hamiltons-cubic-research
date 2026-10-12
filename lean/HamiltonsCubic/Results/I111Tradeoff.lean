import Mathlib

set_option linter.style.longLine false

/-!
# The pinning sum and the cross term trade off exactly, over an abstract symmetric trilinear form

[reviews/2026-09-14-I104-tau-positive.md](../../../reviews/2026-09-14-I104-tau-positive.md) records the
identity `∑ g_a + 3τ = θ(1-t)/2` on the four-set subalgebra `S = D_n ⊕ V_Q₁ ⊕ V_Q₂ ⊕ V_Q₃`. The two
halves that make it are character orthogonality, and NOTHING about the four-set geometry enters
either: both are consequences of total symmetry of `T` together with the vanishing pairings.

So everything below is stated over an arbitrary real vector space carrying a totally symmetric
trilinear form. The four-set structure appears only as the hypotheses `hDab`, `haaa`, `haab` and `hDDN`, each of
which the record derives from characters, and a reader can see that nothing else about the blocks
is used. *An earlier version of this line named a nonexistent `hPnu` and omitted `haaa`*
([r1071](../../../reviews/REVIEW_r1071.md)).

## What is proved

* `P_N_eq_six_tau`: `P(ν₁+ν₂+ν₃) = 6 T(ν₁,ν₂,ν₃)`. *The cubic form of the whole off-diagonal part
  has NO contribution from any individual block: it is six times the cross-block invariant.*
* `a_eq_sum_g`: `T(D,N,N) = ∑ₐ T(D,νₐ,νₐ)`. *The pairing the record calls `a` is the sum of the
  three block pinning terms.*
* `tradeoff`: from the record's own `θ(1-t) = 2a + P(N)`, those two collapses give
  `g₁+g₂+g₃ + 3τ = θ(1-t)/2`. **This is [L221](../../../findings/second-order.md) item 2 SUMMED over
  the three blocks and is strictly weaker than that per-block identity**, which the record already
  held, Gate 2 passed and kernel-checked ([r1071](../../../reviews/REVIEW_r1071.md),
  [r1072](../../../reviews/REVIEW_r1072.md)). *It is typed here for the collapses and the explicit
  hypotheses, not for novelty.*
* `PD_closed_form`: with `θt = P(D) + a` as well, `P(D) = (3/2)θt - θ/2 + 3τ`.

## What is NOT stated

That `T` polarises the Hamilton cubic, that `V_Q` is two-dimensional, that the vanishing hypotheses
follow from character orthogonality, or the two `(D,N)` relations themselves, which are
[second-order.md](../../../findings/second-order.md)'s and are carried here as hypotheses.
-/

namespace HamiltonsCubic.I111Tradeoff

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- The hypotheses a totally symmetric trilinear form satisfies, packaged. -/
structure SymTri (T : V → V → V → ℝ) : Prop where
  add_left : ∀ x y z w, T (x + y) z w = T x z w + T y z w
  swap12 : ∀ x y z, T x y z = T y x z
  swap23 : ∀ x y z, T x y z = T x z y

namespace SymTri

variable {T : V → V → V → ℝ} (h : SymTri T)
include h

theorem add_mid (x y z w : V) : T z (x + y) w = T z x w + T z y w := by
  rw [h.swap12, h.add_left, h.swap12 x z, h.swap12 y z]

theorem add_right (x y z w : V) : T z w (x + y) = T z w x + T z w y := by
  rw [h.swap23, h.add_mid, h.swap23 z x w, h.swap23 z y w]

end SymTri

section

variable {T : V → V → V → ℝ} (h : SymTri T) (D v₁ v₂ v₃ : V)
include h

/-- **The pairing `a` is the sum of the three block pinning terms.**

*The cross terms die because `νₐ ∘ ν_b` lands in the THIRD block and is orthogonal to `D`.* -/
theorem a_eq_sum_g
    (hDab : T D v₁ v₂ = 0 ∧ T D v₁ v₃ = 0 ∧ T D v₂ v₃ = 0) :
    T D (v₁ + v₂ + v₃) (v₁ + v₂ + v₃)
      = T D v₁ v₁ + T D v₂ v₂ + T D v₃ v₃ := by
  obtain ⟨h12, h13, h23⟩ := hDab
  have e21 : T D v₂ v₁ = 0 := (h.swap23 D v₂ v₁).trans h12
  have e31 : T D v₃ v₁ = 0 := (h.swap23 D v₃ v₁).trans h13
  have e32 : T D v₃ v₂ = 0 := (h.swap23 D v₃ v₂).trans h23
  simp only [h.add_mid, h.add_right, h12, h13, h23, e21, e31, e32]
  ring

/-- **`P(N)` is six times the cross-block invariant**, with no contribution from any block.

*`νₐ ∘ νₐ` lands in the TRIVIAL character component and is orthogonal to every `ν_b`, so every
term with a repeated index vanishes and the six distinct-index terms are each `τ`.* -/
theorem P_N_eq_six_tau
    (haaa : T v₁ v₁ v₁ = 0 ∧ T v₂ v₂ v₂ = 0 ∧ T v₃ v₃ v₃ = 0)
    (haab : T v₁ v₁ v₂ = 0 ∧ T v₁ v₁ v₃ = 0 ∧ T v₂ v₂ v₁ = 0 ∧ T v₂ v₂ v₃ = 0
      ∧ T v₃ v₃ v₁ = 0 ∧ T v₃ v₃ v₂ = 0) :
    T (v₁ + v₂ + v₃) (v₁ + v₂ + v₃) (v₁ + v₂ + v₃) = 6 * T v₁ v₂ v₃ := by
  obtain ⟨d1, d2, d3⟩ := haaa
  obtain ⟨p112, p113, p221, p223, p331, p332⟩ := haab
  -- every permutation of a repeated-index triple, from the two swaps
  have p121 : T v₁ v₂ v₁ = 0 := (h.swap23 v₁ v₂ v₁).trans p112
  have p211 : T v₂ v₁ v₁ = 0 := (h.swap12 v₂ v₁ v₁).trans p121
  have p131 : T v₁ v₃ v₁ = 0 := (h.swap23 v₁ v₃ v₁).trans p113
  have p311 : T v₃ v₁ v₁ = 0 := (h.swap12 v₃ v₁ v₁).trans p131
  have p212 : T v₂ v₁ v₂ = 0 := (h.swap23 v₂ v₁ v₂).trans p221
  have p122 : T v₁ v₂ v₂ = 0 := (h.swap12 v₁ v₂ v₂).trans p212
  have p232 : T v₂ v₃ v₂ = 0 := (h.swap23 v₂ v₃ v₂).trans p223
  have p322 : T v₃ v₂ v₂ = 0 := (h.swap12 v₃ v₂ v₂).trans p232
  have p313 : T v₃ v₁ v₃ = 0 := (h.swap23 v₃ v₁ v₃).trans p331
  have p133 : T v₁ v₃ v₃ = 0 := (h.swap12 v₁ v₃ v₃).trans p313
  have p323 : T v₃ v₂ v₃ = 0 := (h.swap23 v₃ v₂ v₃).trans p332
  have p233 : T v₂ v₃ v₃ = 0 := (h.swap12 v₂ v₃ v₃).trans p323
  -- the six distinct-index terms are all τ
  have q132 : T v₁ v₃ v₂ = T v₁ v₂ v₃ := h.swap23 v₁ v₃ v₂
  have q213 : T v₂ v₁ v₃ = T v₁ v₂ v₃ := h.swap12 v₂ v₁ v₃
  have q231 : T v₂ v₃ v₁ = T v₁ v₂ v₃ := (h.swap23 v₂ v₃ v₁).trans (h.swap12 v₂ v₁ v₃)
  have q312 : T v₃ v₁ v₂ = T v₁ v₂ v₃ := (h.swap12 v₃ v₁ v₂).trans (h.swap23 v₁ v₃ v₂)
  have q321 : T v₃ v₂ v₁ = T v₁ v₂ v₃ := (h.swap12 v₃ v₂ v₁).trans q231
  simp only [h.add_left, h.add_mid, h.add_right, d1, d2, d3,
    p112, p113, p221, p223, p331, p332, p121, p211, p131, p311, p212, p122,
    p232, p322, p313, p133, p323, p233, q132, q213, q231, q312, q321]
  ring

end

/-- **THE CUBIC EXPANSION, WITH THE HYPOTHESIS THE PROSE DERIVATION LEFT IMPLICIT.**
`P(D+N) = P(D) + 3 T(D,N,N) + P(N)` needs `T(D,D,N) = 0`, which is character orthogonality
again (`D ∘ D` lands in the TRIVIAL component and `N` has none).

*[r1072](../../../reviews/REVIEW_r1072.md) found this hypothesis unstated in the prose chain: the
conclusion holds, and the written argument did not carry the step. It is a binder here, so no
reader can inherit it silently.* -/
theorem cubic_expand (h : SymTri T) (D N : V) (hDDN : T D D N = 0) :
    T (D + N) (D + N) (D + N) = T D D D + 3 * T D N N + T N N N := by
  have hDND : T D N D = 0 := (h.swap23 D D N).symm.trans hDDN
  have hNDD : T N D D = 0 := (h.swap12 N D D).trans hDND
  have e1 : T N D N = T D N N := h.swap12 N D N
  have e2 : T N N D = T D N N := (h.swap23 N N D).trans (h.swap12 N D N)
  simp only [h.add_left, h.add_mid, h.add_right, hDDN, hDND, hNDD, e1, e2]
  ring

/-- **THE TRADE-OFF.** From the record's `θ(1-t) = 2a + P(N)` and the two collapses,
the pinning sum and the cross term are tied by one line.

*So the chain's step 7 ceiling on the pinning and its step 8 ceiling on the cross term are not
independent: raising `τ` by `δ` lowers `∑ gₐ` by exactly `3δ`.* -/
theorem tradeoff (θ t a τ g₁ g₂ g₃ PN : ℝ)
    (hrel : θ * (1 - t) = 2 * a + PN) (ha : a = g₁ + g₂ + g₃) (hPN : PN = 6 * τ) :
    g₁ + g₂ + g₃ + 3 * τ = θ * (1 - t) / 2 := by
  rw [ha, hPN] at hrel
  linarith

/-- **`P(D)` in closed form**, with no reference to `D`'s shape, from the record's `θt = P(D) + a`
together with the trade-off. -/
theorem PD_closed_form (θ t a τ PD g₁ g₂ g₃ PN : ℝ)
    (hD : θ * t = PD + a) (hrel : θ * (1 - t) = 2 * a + PN)
    (ha : a = g₁ + g₂ + g₃) (hPN : PN = 6 * τ) :
    PD = 3 / 2 * θ * t - θ / 2 + 3 * τ := by
  rw [ha, hPN] at hrel
  rw [ha] at hD
  linarith

end HamiltonsCubic.I111Tradeoff
