import HamiltonsCubic.Results.L126Assembly

set_option linter.style.longLine false

/-!
# L126's other splits and second eigenvector: only the `(2,2)`-splits are nonzero, with eigenvalues `±½(A − B)`

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *"the nonzero four-set blocks are the
`(2,2)`-splits"*. On the Bianchi part `x + y + z = 0` of a four-set block, `M ∘` is `½G`, and:

* **`equal_sums_kill`**: when the three opposite-pair sums agree, `A = B = C`, `M ∘` vanishes on the Bianchi part;
* **`split_40_sums`**, **`split_31_sums`**, **`split_13_sums`**, **`split_04_sums`**: at a sphere product the sums
  agree at every split other than `(2,2)`, written with `l` the odd index out, and **`sums_eq_of_not_22`** and
  **`nonsplit_kill`** take every placement, so every non-`(2,2)` block vanishes on its Bianchi part;
* **`split_eigen_second`**: at a `(2,2)`-split the second Bianchi vector `b − c` has `M ∘ (b − c) = −½(A − B)(b − c)`,
  so the Bianchi part of a `(2,2)` block carries `±½(A − B)`, which `split_value_eq` makes `±μ_{p,q}` after `/θ`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Equal opposite-pair sums kill the Bianchi part**: with `A = B = C` and `x + y + z = 0`,
`M ∘ (x a + y b + z c) = 0` on every bivector. -/
theorem equal_sums_kill (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k)
    (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) {X : Matrix ι ι ℝ} (hX : IsSkew X)
    (hAB : w i j + w k l = w i k + w j l) (hAC : w i j + w k l = w i l + w j k) (x y z : ℝ) (hs : x + y + z = 0) :
    foxProd (diagOp w) (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y
        + z • rk2 (phi i l) (phi j k) Y) X = 0 := by
  rw [fourSet_span w hw hij hik hil hjk hjl hkl hX x y z, ← hAB, ← hAC]
  have e : (w i j + w k l) * x + (w i j + w k l) * y + (w i j + w k l) * z = 0 := by
    rw [← mul_add, ← mul_add, hs, mul_zero]
  simp only [e, zero_smul, add_zero, smul_zero]

theorem split_40_sums (T : Finset ι) (t : ℝ) {i j k l : ι} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∈ T) (hl : l ∈ T)
    (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) :
    let w := t • sphereWeight T
    w i j + w k l = w i k + w j l ∧ w i j + w k l = w i l + w j k := by
  intro w
  simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hi hj hij, sphereWeight_in T hk hl hkl,
    sphereWeight_in T hi hk hik, sphereWeight_in T hj hl hjl, sphereWeight_in T hi hl hil, sphereWeight_in T hj hk hjk]
  trivial

theorem split_31_sums (T : Finset ι) (t : ℝ) {i j k l : ι} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∈ T) (hl : l ∉ T)
    (hij : i ≠ j) (hik : i ≠ k) (hjk : j ≠ k) :
    let w := t • sphereWeight T
    w i j + w k l = w i k + w j l ∧ w i j + w k l = w i l + w j k := by
  intro w
  simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hi hj hij, sphereWeight_cross T hk hl,
    sphereWeight_in T hi hk hik, sphereWeight_cross T hj hl, sphereWeight_cross T hi hl, sphereWeight_in T hj hk hjk]
  refine ⟨trivial, by ring⟩

theorem split_13_sums (T : Finset ι) (t : ℝ) {i j k l : ι} (hi : i ∉ T) (hj : j ∉ T) (hk : k ∉ T) (hl : l ∈ T)
    (hij : i ≠ j) (hik : i ≠ k) (hjk : j ≠ k) :
    let w := t • sphereWeight T
    w i j + w k l = w i k + w j l ∧ w i j + w k l = w i l + w j k := by
  intro w
  have c : ∀ a, a ∉ T → sphereWeight T a l = -1 := fun a ha => by
    rw [sphereWeight_symm]; exact sphereWeight_cross T hl ha
  simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_out T hi hj hij, c k hk, sphereWeight_out T hi hk hik,
    c j hj, c i hi, sphereWeight_out T hj hk hjk]
  refine ⟨trivial, by ring⟩

theorem split_04_sums (T : Finset ι) (t : ℝ) {i j k l : ι} (hi : i ∉ T) (hj : j ∉ T) (hk : k ∉ T) (hl : l ∉ T)
    (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) :
    let w := t • sphereWeight T
    w i j + w k l = w i k + w j l ∧ w i j + w k l = w i l + w j k := by
  intro w
  simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_out T hi hj hij, sphereWeight_out T hk hl hkl,
    sphereWeight_out T hi hk hik, sphereWeight_out T hj hl hjl, sphereWeight_out T hi hl hil,
    sphereWeight_out T hj hk hjk]
  trivial

/-- **The second eigenvector**: at a `(2,2)`-split, `M ∘ (b − c) = −½(A − B)(b − c)` on every bivector. -/
theorem split_eigen_second (T : Finset ι) (t : ℝ) {i j k l : ι} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T) (hl : l ∉ T)
    (hij : i ≠ j) (hkl : k ≠ l) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    let w := t • sphereWeight T
    let u : CurvOp ι := fun Y => (0 : ℝ) • rk2 (phi i j) (phi k l) Y + (1 : ℝ) • rk2 (phi k i) (phi j l) Y
      + (-1 : ℝ) • rk2 (phi i l) (phi j k) Y
    foxProd (diagOp w) u X = (-(w i j + w k l - (w i k + w j l)) / 2) • u X := by
  intro w u
  have hik : i ≠ k := fun h => hk (h ▸ hi)
  have hil : i ≠ l := fun h => hl (h ▸ hi)
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hjl : j ≠ l := fun h => hl (h ▸ hj)
  have hw : ∀ p q, w p q = w q p := fun p q => by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_symm]
  obtain ⟨hB, hC⟩ := split_B_eq_C T t hi hj hk hl
  rw [fourSet_span w hw hij hik hil hjk hjl hkl hX 0 1 (-1)]
  simp only [u]
  rw [show w i k + w j l = -2 * t from hB, show w i l + w j k = -2 * t from hC]
  module

/-- **EVERY SPLIT BUT `(2,2)` HAS EQUAL SUMS, AT ANY PLACEMENT**: at a sphere product and four distinct indices of
which the number in `T` is not `2`, `A = B` and `A = C`. This is the relabelling the four `split_*_sums` stand for,
decided over all sixteen membership patterns. -/
theorem sums_eq_of_not_22 (T : Finset ι) (t : ℝ) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l)
    (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (hn : (if i ∈ T then 1 else 0) + (if j ∈ T then 1 else 0) + (if k ∈ T then 1 else 0)
      + (if l ∈ T then 1 else 0) ≠ (2 : ℕ)) :
    let w := t • sphereWeight T
    w i j + w k l = w i k + w j l ∧ w i j + w k l = w i l + w j k := by
  intro w
  simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight, Matrix.of_apply, hij, hik, hil, hjk, hjl, hkl,
    if_false]
  by_cases hi : i ∈ T <;> by_cases hj : j ∈ T <;> by_cases hk : k ∈ T <;> by_cases hl : l ∈ T <;>
    simp only [hi, hj, hk, hl, if_true, if_false] at hn ⊢ <;> norm_num at hn <;> constructor <;> first | trivial | ring

/-- **The non-`(2,2)` blocks vanish on their Bianchi part, at any placement**: `equal_sums_kill` composed with
`sums_eq_of_not_22`. -/
theorem nonsplit_kill (T : Finset ι) (t : ℝ) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l)
    (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (hn : (if i ∈ T then 1 else 0) + (if j ∈ T then 1 else 0) + (if k ∈ T then 1 else 0)
      + (if l ∈ T then 1 else 0) ≠ (2 : ℕ)) {X : Matrix ι ι ℝ} (hX : IsSkew X) (x y z : ℝ) (hs : x + y + z = 0) :
    foxProd (diagOp (t • sphereWeight T)) (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y
        + z • rk2 (phi i l) (phi j k) Y) X = 0 := by
  obtain ⟨hAB, hAC⟩ := sums_eq_of_not_22 T t hij hik hil hjk hjl hkl hn
  have hw : ∀ p q, (t • sphereWeight T) p q = (t • sphereWeight T) q p := fun p q => by
    simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_symm]
  exact equal_sums_kill _ hw hij hik hil hjk hjl hkl hX hAB hAC x y z hs

end HamiltonsCubic.L126Assembly
