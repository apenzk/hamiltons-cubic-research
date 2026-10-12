import Mathlib
import HamiltonsCubic.Results.L217

set_option linter.style.longLine false

/-!
# L217, the value bootstrap, stated for a cubic form

## The record's statement, as audited by [r933](../../../reviews/REVIEW_r933.md) and [r934](../../../reviews/REVIEW_r934.md)

[second-order.md](../../../findings/second-order.md)'s Lemma L217: *let `u` be a unit critical point of
`P` with `θ_u > 0` and gap `⟨L_e H, H⟩ ≤ 1/2 - γ` off `u` and the orbit tangent; let `W*` be a global
maximiser at geodesic distance `φ ∈ [0, π/2]` from the orbit with `sin φ ≤ min(3γ, 1/2)`; then
`P(W*) ≤ θ_u`, hence `= θ_u`.*

## What is typed

**The lemma's own chain, over any real vector space carrying a symmetric trilinear form `T`**, with
`P(x) = T x x x`. `value_bootstrap` states the conclusion `m ≤ θ` from the configuration the lemma's
steps (1) to (3) reach, and proves it through the exact cubic expansion. *The instantiation at `𝒲ₙ`
enters as hypotheses, each named for the step that supplies it:*

* `hW`: `W* = c • u + s • v`, which the first variation of distance supplies (step 1);
* `hcrit`: `T u u v = 0`, criticality `Q(u) = θ u` polarised against `v ⟂ u` (step 2);
* `hgap`: `T u v v ≤ θ (1/2 - γ)`, the gap, since `T u v v = θ ⟨L_e v, v⟩` (step 2);
* `hmax`: `T v v v ≤ m`, the global comparison at the maximiser (step 3).

**Not typed**: `𝒲ₙ`, its `T`, the orbit, geodesic distance and the first-variation step, which is
why those four enter as hypotheses rather than conclusions.
-/

namespace HamiltonsCubic.L217Statement

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- **The exact cubic expansion along `c • u + s • v`**, for a symmetric trilinear form. -/
theorem cubic_expansion (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y) (u v : V) (c s : ℝ) :
    T (c • u + s • v) (c • u + s • v) (c • u + s • v)
      = c ^ 3 * T u u u + 3 * c ^ 2 * s * T u u v + 3 * c * s ^ 2 * T u v v + s ^ 3 * T v v v := by
  have e1 : T u v u = T u u v := h23 u v u
  have e2 : T v u u = T u u v := by rw [h12 v u u, e1]
  have e3 : T v u v = T u v v := h12 v u v
  have e4 : T v v u = T u v v := by rw [h23 v v u, e3]
  simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, smul_eq_mul]
  rw [e1, e2, e3, e4]
  ring

/-- **Lemma L217, the value bootstrap.** A global maximiser of value `m` in the tube
`sin φ ≤ min(3γ, 1/2)` about a gapped critical point of value `θ` has `m ≤ θ`. -/
theorem value_bootstrap (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y)
    {u v W : V} {θ γ m s c : ℝ}
    (hθ : 0 < θ) (hγ0 : 0 ≤ γ) (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2)
    (hW : W = c • u + s • v) (hm : m = T W W W)
    (huu : T u u u = θ) (hcrit : T u u v = 0)
    (hgap : T u v v ≤ θ * (1 / 2 - γ)) (hmax : T v v v ≤ m) :
    m ≤ θ := by
  have hexp0 := cubic_expansion T h12 h23 u v c s
  rw [← hW, ← hm, huu, hcrit] at hexp0
  have hexp : m = θ * (c ^ 3 + 3 * c * s ^ 2 * (T u v v / θ)) + s ^ 3 * T v v v := by
    rw [hexp0]; field_simp; ring
  have hα : T u v v / θ ≤ 1 / 2 - γ := by
    rw [div_le_iff₀ hθ]; linarith
  exact HamiltonsCubic.L217.tube_value_le hs0 hc0 hc hγ0 hs hshalf hθ hexp hα hmax

/-- **And the value is exactly `θ`**, since a global maximiser's value is at least `P(u) = θ`. -/
theorem value_eq (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y)
    {u v W : V} {θ γ m s c : ℝ}
    (hθ : 0 < θ) (hγ0 : 0 ≤ γ) (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2)
    (hW : W = c • u + s • v) (hm : m = T W W W)
    (huu : T u u u = θ) (hcrit : T u u v = 0)
    (hgap : T u v v ≤ θ * (1 / 2 - γ)) (hmax : T v v v ≤ m) (hlow : θ ≤ m) :
    m = θ :=
  le_antisymm (value_bootstrap T h12 h23 hθ hγ0 hs0 hc0 hc hs hshalf hW hm huu hcrit hgap hmax) hlow

/-! ## The hypotheses are satisfiable

*On `ℝ` with `T x y z = x y z`, `u = 1`, `v = 0`, `c = 1`, `s = 0`: every hypothesis holds and
`m = θ = 1`.* -/

example : (1 : ℝ) ≤ 1 := by
  let T : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ :=
    LinearMap.mk₂ ℝ (fun x y => (x * y) • (LinearMap.id : ℝ →ₗ[ℝ] ℝ))
      (by intros; ext; simp; ring) (by intros; ext; simp; ring)
      (by intros; ext; simp; ring) (by intros; ext; simp; ring)
  have hT : ∀ x y z, T x y z = x * y * z := fun x y z => by simp [T]
  have h12 : ∀ x y z, T x y z = T y x z := fun x y z => by rw [hT, hT]; ring
  have h23 : ∀ x y z, T x y z = T x z y := fun x y z => by rw [hT, hT]; ring
  exact value_bootstrap T h12 h23 (u := 1) (v := 0) (W := 1) (θ := 1) (γ := 1 / 10) (m := 1)
    (s := 0) (c := 1)
    (by norm_num) (by norm_num) le_rfl (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by simp) (by rw [hT]; norm_num) (by rw [hT]; norm_num) (by rw [hT]; norm_num)
    (by rw [hT]; norm_num) (by rw [hT]; norm_num)

end HamiltonsCubic.L217Statement
