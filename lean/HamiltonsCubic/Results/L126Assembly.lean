import HamiltonsCubic.Results.L126Sphere
import HamiltonsCubic.Results.L126Statement
import HamiltonsCubic.Results.L121Bianchi
import HamiltonsCubic.Results.L126Orbit

set_option linter.style.longLine false

/-!
# L126 assembled: at `S^p × S^q` each `(2,2)`-split four-set carries an `L_e`-eigenvector of eigenvalue `±μ_{p,q}`

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *"At `S^p × S^q`, `n = p + q`, the nonzero
four-set blocks are the `(2,2)`-splits, with the common value `μ_{p,q} = (n−2)/(2(p−1)(q−1))`"*, the value being an
eigenvalue of `L_e`, `e = M/θ`, on the Bianchi part of the block. The pieces were proved separately: the block
([L121Block.lean](L121Block.lean)'s `fourSet_span`), its Bianchi cut ([L121Bianchi.lean](L121Bianchi.lean)), the sum
`Σ/θ² = ((n−2)/((p−1)(q−1)))²` ([L126Sphere.lean](L126Sphere.lean)'s `fourSet_sigma`), and the value `μ_{p,q}`
([L126Statement.lean](L126Statement.lean)'s `mu`). This file assembles them at a `(2,2)`-split `i, j ∈ T`,
`k, l ∉ T` of a unit sphere product `M = diagOp (t · sphereWeight T)`:

* **`split_B_eq_C`**: the two cross sums agree, `B = C = −2t`, since every cross weight is `−t`;
* **`split_eigen`**: `v = 2a − b − c` (signed basis of `fourSet_G`) satisfies `M ∘ v = ½(A − B) v` on every bivector,
  and `v` satisfies first Bianchi at every tuple;
* **`split_value`**: `((A − B)/(2θ))² = μ_{p,q}²`, so `L_e v = λ v` with `λ = (A − B)/(2θ)` and `|λ| = μ_{p,q}`;
* **`split_value_eq`**: with its sign, `λ = +μ_{p,q}`, since `A − B` and `θ` are positive.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **At a `(2,2)`-split the two cross sums agree**: `w_ik + w_jl = w_il + w_jk = −2t`. -/
theorem split_B_eq_C (T : Finset ι) (t : ℝ) {i j k l : ι} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T) (hl : l ∉ T) :
    (t • sphereWeight T) i k + (t • sphereWeight T) j l = -2 * t
      ∧ (t • sphereWeight T) i l + (t • sphereWeight T) j k = -2 * t := by
  simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T hi hk, sphereWeight_cross T hj hl,
    sphereWeight_cross T hi hl, sphereWeight_cross T hj hk]
  constructor <;> ring

/-- **The eigenvector**: at a `(2,2)`-split, `v = 2a − b − c` has `M ∘ v = ½(A − B) v` on every bivector, and
satisfies first Bianchi at every tuple. -/
theorem split_eigen (T : Finset ι) (t : ℝ) {i j k l : ι} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T) (hl : l ∉ T)
    (hij : i ≠ j) (hkl : k ≠ l) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    let w := t • sphereWeight T
    let v : CurvOp ι := fun Y => (2 : ℝ) • rk2 (phi i j) (phi k l) Y + (-1 : ℝ) • rk2 (phi k i) (phi j l) Y
      + (-1 : ℝ) • rk2 (phi i l) (phi j k) Y
    foxProd (diagOp w) v X = ((w i j + w k l - (w i k + w j l)) / 2) • v X
      ∧ ∀ p q r s, bianchi v p q r s = 0 := by
  intro w v
  have hik : i ≠ k := fun h => hk (h ▸ hi)
  have hil : i ≠ l := fun h => hl (h ▸ hi)
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hjl : j ≠ l := fun h => hl (h ▸ hj)
  have hw : ∀ p q, w p q = w q p := fun p q => by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_symm]
  obtain ⟨hB, hC⟩ := split_B_eq_C T t hi hj hk hl
  refine ⟨?_, ?_⟩
  · rw [fourSet_span w hw hij hik hil hjk hjl hkl hX 2 (-1) (-1)]
    simp only [v]
    rw [show w i k + w j l = -2 * t from hB, show w i l + w j k = -2 * t from hC]
    module
  · exact (fourSet_bianchi_iff hij hik hil hjk hjl hkl 2 (-1) (-1)).mpr (by norm_num)

/-- **The eigenvalue of `L_e` on `v` has modulus `μ_{p,q}`**: `((A − B)/(2θ))² = μ_{p,q}²` at a unit sphere product,
`p = |T|`, `q = |Tᶜ|`. -/
theorem split_value (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {i j k l : ι} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T)
    (hl : l ∉ T) (hij : i ≠ j) (hkl : k ≠ l) :
    let w := t • sphereWeight T
    ((w i j + w k l - (w i k + w j l)) / (2 * theta (diagOp w))) ^ 2
      = HamiltonsCubic.L126Statement.mu T.card Tᶜ.card ^ 2 := by
  intro w
  have hs := HamiltonsCubic.L57Critical.fourSet_sigma T hp hq t ht hn i j k l hi hj hk hl hij hkl
  simp only at hs
  obtain ⟨hB, hC⟩ := split_B_eq_C T t hi hj hk hl
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ0 : 0 < theta (diagOp w) := by
    rw [show w = t • sphereWeight T from rfl, theta_sphereProduct_value T hp hq t ht hn, thetaSplit]
    apply Real.sqrt_pos.mpr
    unfold thetaSplitSq
    apply div_pos
    · have : 0 < (T.card : ℝ) - 1 := by linarith
      have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
      have : 0 < (T.card : ℝ) + Tᶜ.card - 1 := by linarith
      positivity
    · have : 0 < (T.card : ℝ) + Tᶜ.card - 2 := by linarith
      positivity
  -- `Σ = (A − B)²` because `B = C`
  have hsig : (w i j + w k l - (w i k + w j l)) ^ 2
      = (((T.card : ℝ) + Tᶜ.card - 2) / (((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))) ^ 2 * theta (diagOp w) ^ 2 := by
    rw [← hs]
    have e1 : w i k + w j l = -2 * t := hB
    have e2 : w i l + w j k = -2 * t := hC
    rw [e1, e2]; ring
  unfold HamiltonsCubic.L126Statement.mu
  rw [div_pow, hsig]
  have h1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have h2 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  field_simp

/-- **THE EIGENVALUE IS `+μ_{p,q}`**, with its sign: `(A − B)/(2θ) = μ_{p,q}`, since `A − B = t(q/(p−1) + p/(q−1) + 2)`
is positive and so is `θ`. The `½` threshold reads this sign. -/
theorem split_value_eq (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {i j k l : ι} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T)
    (hl : l ∉ T) (hij : i ≠ j) (hkl : k ≠ l) :
    let w := t • sphereWeight T
    (w i j + w k l - (w i k + w j l)) / (2 * theta (diagOp w)) = HamiltonsCubic.L126Statement.mu T.card Tᶜ.card := by
  intro w
  have hsq := split_value T hp hq t ht hn hi hj hk hl hij hkl
  simp only at hsq
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ0 : 0 < theta (diagOp w) := by
    rw [show w = t • sphereWeight T from rfl, theta_sphereProduct_value T hp hq t ht hn, thetaSplit]
    apply Real.sqrt_pos.mpr
    unfold thetaSplitSq
    apply div_pos
    · have : 0 < (T.card : ℝ) - 1 := by linarith
      have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
      have : 0 < (T.card : ℝ) + Tᶜ.card - 1 := by linarith
      positivity
    · have : 0 < (T.card : ℝ) + Tᶜ.card - 2 := by linarith
      positivity
  obtain ⟨hB, _⟩ := split_B_eq_C T t hi hj hk hl
  have hA : w i j + w k l = t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1) + (T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) := by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hi hj hij, sphereWeight_out T hk hl hkl]; ring
  have hlam : 0 < (w i j + w k l - (w i k + w j l)) / (2 * theta (diagOp w)) := by
    have e : w i k + w j l = -2 * t := hB
    rw [e, hA]
    have : 0 < (T.card : ℝ) - 1 := by linarith
    have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
    apply div_pos _ (by positivity)
    have : 0 < t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1) + (T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) := by positivity
    linarith
  have hmu : 0 < HamiltonsCubic.L126Statement.mu T.card Tᶜ.card := by
    unfold HamiltonsCubic.L126Statement.mu
    have : 0 < (T.card : ℝ) - 1 := by linarith
    have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
    apply div_pos (by linarith) (by positivity)
  exact (pow_left_inj₀ hlam.le hmu.le (by norm_num : (2 : ℕ) ≠ 0)).mp hsq

end HamiltonsCubic.L126Assembly
