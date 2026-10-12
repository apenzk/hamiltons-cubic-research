import Mathlib

/-!
# The small-mass node's pair identity, and the bound it gives

[reviews/2026-09-28b-LIT-step8-sweep.md](../../../reviews/2026-09-28b-LIT-step8-sweep.md), the
four-set route for I121.

**The source's statement.** Split `W = A + B_p + B_f` into diagonal, pair and four-set parts. "The
pair-character part of `Q(W) = ρ W` is ... and pairing with `B_p` gives
`T(B_f,B_f,B_p) = ρ‖B_p‖² - P(B_p) - 2⟨L_A B_p,B_p⟩ - 2T(B_f,B_p,B_p)`. So
`ρ = P(B_f) + 3⟨L_A B_f,B_f⟩ + P(A) + 3ρ‖B_p‖² - 3⟨L_A B_p,B_p⟩ - 2P(B_p) - 3T(B_p,B_p,B_f)`."

**What is typed.** `pair_identity`: for a symmetric trilinear `T` on a real inner product space,
three vectors with `T A A B_f = 0` (the one cross term the identity needs, which L120 gives), the
paired pair criticality `T W W B_p = ρ ‖B_p‖²`, the identity for `T W W W`. *`T A A B_p` and
`T A B_p B_f` need not vanish: they cancel against three times the criticality equation.* `small_mass_bound`: the
scalar inequality it gives once each term is bounded.

**Not typed**: that `T A A B_f` vanishes, which is L120's block diagonality, and the four
bounds fed to `small_mass_bound` (L218, L57, Banach's theorem, the definition of `S_F`).
-/

namespace HamiltonsCubic.PairIdentity

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-- **THE PAIR IDENTITY.** -/
theorem pair_identity (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y)
    (A Bp Bf : V) (ρ : ℝ)
    (hAAf : T A A Bf = 0)
    (hcrit : T (A + Bp + Bf) (A + Bp + Bf) Bp = ρ * ‖Bp‖ ^ 2) :
    T (A + Bp + Bf) (A + Bp + Bf) (A + Bp + Bf)
      = T Bf Bf Bf + 3 * T A Bf Bf + T A A A + 3 * ρ * ‖Bp‖ ^ 2 - 3 * T A Bp Bp
        - 2 * T Bp Bp Bp - 3 * T Bp Bp Bf := by
  simp only [map_add, LinearMap.add_apply] at hcrit ⊢
  have p1 : T A Bp A = T A A Bp := h23 A Bp A
  have p2 : T A Bf A = T A A Bf := h23 A Bf A
  have p3 : T A Bf Bp = T A Bp Bf := h23 A Bf Bp
  have p4 : T Bp A A = T A A Bp := (h12 Bp A A).trans (h23 A Bp A)
  have p5 : T Bp A Bp = T A Bp Bp := h12 Bp A Bp
  have p6 : T Bp A Bf = T A Bp Bf := h12 Bp A Bf
  have p7 : T Bp Bp A = T A Bp Bp := (h23 Bp Bp A).trans (h12 Bp A Bp)
  have p8 : T Bp Bf A = T A Bp Bf := (h23 Bp Bf A).trans (h12 Bp A Bf)
  have p9 : T Bp Bf Bp = T Bp Bp Bf := h23 Bp Bf Bp
  have p10 : T Bf A A = T A A Bf := (h12 Bf A A).trans (h23 A Bf A)
  have p11 : T Bf A Bp = T A Bp Bf := (h12 Bf A Bp).trans (h23 A Bf Bp)
  have p12 : T Bf A Bf = T A Bf Bf := h12 Bf A Bf
  have p13 : T Bf Bp A = T A Bp Bf := ((h12 Bf Bp A).trans (h23 Bp Bf A)).trans (h12 Bp A Bf)
  have p14 : T Bf Bp Bp = T Bp Bp Bf := (h12 Bf Bp Bp).trans (h23 Bp Bf Bp)
  have p15 : T Bf Bp Bf = T Bp Bf Bf := h12 Bf Bp Bf
  have p16 : T Bf Bf A = T A Bf Bf := (h23 Bf Bf A).trans (h12 Bf A Bf)
  have p17 : T Bf Bf Bp = T Bp Bf Bf := (h23 Bf Bf Bp).trans (h12 Bf Bp Bf)
  linarith [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, hcrit, hAAf]

/-- **THE SMALL-MASS BOUND**, scalar: the identity with each term bounded. -/
theorem small_mass_bound (ρ SF μ θ t p f Pf LAf PA LAp Pp Tppf : ℝ)
    (hid : ρ = Pf + 3 * LAf + PA + 3 * ρ * p ^ 2 - 3 * LAp - 2 * Pp - 3 * Tppf)
    (hPf : Pf ≤ SF * f ^ 3) (hLAf : LAf ≤ μ * t * f ^ 2) (hPA : PA ≤ θ * t ^ 3)
    (hLAp : -LAp ≤ μ * t * p ^ 2) (hPp : -Pp ≤ ρ * p ^ 3) (hT : -Tppf ≤ ρ * p ^ 2 * f) :
    ρ ≤ SF * f ^ 3 + 3 * μ * t * f ^ 2 + θ * t ^ 3
      + p ^ 2 * (3 * ρ + 3 * μ * t + 2 * ρ * p + 3 * ρ * f) := by
  linarith

end HamiltonsCubic.PairIdentity
